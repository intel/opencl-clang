#define m_nMaxValue      65535
#define m_nMaxValueDiv2  32768
#define m_nMappingMax    65533
#define m_nMappingMin    2

#define	MAX_16BITS_VALUE		65535
#define WEIGHTING_OFFSET		32768
#define	POW_TABLE_OFFSET		1000
#define	POW_TABLE_OFFSET_DIV2	500
#define WEIGHTING_OFFSET_DIV2	16384

// this kernel combine the code of functions m_fnApplyWeightExposure and m_fnAvoidHueShift
// This kernel handles nWeightExposure with value with > 0;
kernel void ApplyWeightExposure_pos_AvoidHueShift(global const ushort4* srcIm,	global ushort4* dstIm, global float *m_pfExpGrowthTable,
                                                  global int*	m_pnExpDistTable, float fSlope,
												     int  width, int height, int src_stride, int dst_stride, int nWeight)
{
	int		x = get_global_id(0);
	int		y = get_global_id(1);

	if( x >= width || y >= height)
		return;

	int	src_index = y*src_stride + x;
	int	dst_index = y*dst_stride + x;

	int4 src4 = convert_int4(srcIm[src_index]);   // read from input
	int3 srcBGR = { src4.s0,src4.s1,src4.s2 };

    // 1. m_fnApplyWeightExposure
	int3	dstBGR;
	// computation for dstBGR[]

    float3 fDst = convert_float3(srcBGR) * fSlope;
    int3   nDst = convert_int3(fDst);
    float3 t_grow_lcp = (float3)(m_pfExpGrowthTable[srcBGR.s0], m_pfExpGrowthTable[srcBGR.s1], m_pfExpGrowthTable[srcBGR.s2]);
    int3 nDstB = min(nDst, MAX_16BITS_VALUE-1);
    int3   t_dist_lcp = { m_pnExpDistTable[nDstB.s0], m_pnExpDistTable[nDstB.s1], m_pnExpDistTable[nDstB.s2] };

    int3 dstBGR_m = convert_int3( ((fDst - MAX_16BITS_VALUE) * t_grow_lcp + MAX_16BITS_VALUE) + 0.5f );
    int3 dstBGR_l = nDst + ((t_dist_lcp - nDst) * nWeight + WEIGHTING_OFFSET_DIV2) / WEIGHTING_OFFSET;
    dstBGR = nDst >= MAX_16BITS_VALUE ? dstBGR_m : dstBGR_l;

    /*
	for ( int i = 0; i < 3; i++ )
	{
		int nDst = (int)( (srcBGR[i] * fSlope) );

		if ( nDst >= MAX_16BITS_VALUE )
		{
			// Use exponential growth table
			dstBGR[i] = (int)( ((nDst - MAX_16BITS_VALUE) * m_pfExpGrowthTable[srcBGR[i]] + MAX_16BITS_VALUE) + 0.5f );
		}
		else
		{
			// Use exponential distribution table with linear interpolation
			dstBGR[i] = nDst + ((m_pnExpDistTable[nDst] - nDst) * nWeight + WEIGHTING_OFFSET_DIV2) / WEIGHTING_OFFSET;
		}
	}
    */

    // 2. m_fnAvoidHueShift
    // if ( dstBGR[0] != srcBGR[0] && dstBGR[1] != srcBGR[1] && dstBGR[2] != srcBGR[2] )
    if ( all(dstBGR != srcBGR) )
    {
        int nMedian      = 0;
	    int nMax         = 0;
	    int nMin         = 0;
	    int nMedianDst   = 0;
	    int nMedianDst_o = 0;
	    int nMaxDst      = 0;
	    int nMinDst      = 0;
	    int nMaxIndex       = 0;
	    int nMinIndex       = 0;
	    int nMedianIndex    = 0;

        int nRed = srcBGR[0];
        int nGreen = srcBGR[1];
        int nBlue = srcBGR[2];
		if((nRed == nGreen) && (nGreen == nBlue))
		{
			nMax = srcBGR[0];
		    nMaxIndex = 0;
			nMin = srcBGR[1];
		    nMinIndex = 1;
		}
		else
		{
			nMax = max( nRed, max( nGreen, nBlue ) );
			nMin = min( nRed, min( nGreen, nBlue ) );
			nMaxIndex = ((nMax == nGreen) && (nMax != nRed)) * 1 + ((nMax == nBlue) && (nMax != nGreen) && (nMax != nRed)) * 2;
			nMinIndex = ((nMin == nGreen) && (nMin != nRed)) * 1 + ((nMin == nBlue) && (nMin != nGreen) && (nMin != nRed)) * 2;
		}
        nMedianIndex = 3 - nMinIndex - nMaxIndex;
	    nMedian      = srcBGR[nMedianIndex];

	    // Max and min value is totally based on mapping table, only median value could be corrected for avoiding hue shift
	    nMaxDst      = dstBGR[nMaxIndex];
	    nMinDst      = dstBGR[nMinIndex];
	    nMedianDst_o = dstBGR[nMedianIndex];

	    unsigned int nDelta = nMax - nMin;

        if (nDelta == 0)
		    nMedianDst = nMedianDst_o;
	    else
		    nMedianDst = (int)(( ((float)(nMedian - nMin)*(float)(nMaxDst - nMinDst) / (float)nDelta) ) + nMinDst + 0.5f); // avoid hue shift formula

        int max_median = max( nMedianDst_o, max( nMedianDst, nMedian ) );
        int min_median = min( nMedianDst_o, min( nMedianDst, nMedian ) );
		dstBGR[nMedianIndex] = (nMedianDst_o + nMedianDst + nMedian) - (max_median + min_median );

       // dstBGR[nMedianIndex] = nMedianDst_o;
        //if( max_median != nMedianDst && min_median != nMedianDst)
       //     dstBGR[nMedianIndex] = nMedianDst;
       // else if( max_median != nMedian && min_median != nMedian)
         //   dstBGR[nMedianIndex] = nMedian;

    }


    // 3. _ChkBoundaryUpdate_( intBGR[i], 0, MAX_16BITS_VALUE );
   /*for(int i = 0; i < 3; i++)
    {
        //if(dstBGR[i] < 0)
        //    dstBGR[i] = 0;
       // else if(dstBGR[i] > MAX_16BITS_VALUE)
            //dstBGR[i] = MAX_16BITS_VALUE;
		dstBGR[i] = min(dstBGR[i], MAX_16BITS_VALUE);
    }*/
    dstBGR = min(dstBGR, MAX_16BITS_VALUE);

	// output
    int4 dst4 = {dstBGR.s0,dstBGR.s1,dstBGR.s2,src4.s3};
	dstIm[dst_index] = convert_ushort4(dst4);

}

kernel void ApplyWeightExposure_neg_AvoidHueShift(global const ushort4* srcIm,	global ushort4* dstIm, global float *m_pfExpGrowthTable,
                                                  global int*	m_nExpDistTable, float fSlope,
												     int  width, int height, int src_stride, int dst_stride, int nWeight )
{
	int		x = get_global_id(0);
	int		y = get_global_id(1);

	if( x >= width || y >= height)
		return;

	int	src_index = y*src_stride + x;
	int	dst_index = y*dst_stride + x;

    int4 src4 = convert_int4(srcIm[src_index]);   // read from input
	//int srcBGR[3] = {src4.s0,src4.s1,src4.s2 };


	int3 srcBGR = { src4.s0,src4.s1,src4.s2 };

        // 1. m_fnApplyWeightExposure
	int3	dstBGR;
	// computation for dstBGR[]

    float3 fDst = convert_float3(srcBGR) * fSlope + 0.5f;
    float3 t_grow_lcp = { m_pfExpGrowthTable[srcBGR.s0], m_pfExpGrowthTable[srcBGR.s1], m_pfExpGrowthTable[srcBGR.s2] };
    dstBGR = convert_int3(fDst) + ( convert_int3(  fDst * t_grow_lcp - fDst + 0.5f ) * nWeight + WEIGHTING_OFFSET_DIV2) / WEIGHTING_OFFSET;


    // 1. m_fnApplyWeightExposure
	/*int	dstBGR[3];

    for ( int i = 0; i < 3; i++ )
	{
		int nDst = (int)( (srcBGR[i] * fSlope) + 0.5f);

       // Use exponential growth table with linear interpolation
		dstBGR[i] = nDst + ( (int)(  nDst * m_pfExpGrowthTable[srcBGR[i]] - nDst + 0.5f ) * nWeight + WEIGHTING_OFFSET_DIV2) / WEIGHTING_OFFSET;
	}*/

    // 2. m_fnAvoidHueShift
   //if ( dstBGR[0] != srcBGR[0] && dstBGR[1] != srcBGR[1] && dstBGR[2] != srcBGR[2] )
   if ( all(dstBGR != srcBGR) )
   {
        int nMedian      = 0;
	    int nMax         = 0;
	    int nMin         = 0;
	    int nMedianDst   = 0;
	    int nMedianDst_o = 0;
	    int nMaxDst      = 0;
	    int nMinDst      = 0;
	    int nMaxIndex       = 0;
	    int nMinIndex       = 0;
	    int nMedianIndex    = 0;

        int nRed = srcBGR[0];
        int nGreen = srcBGR[1];
        int nBlue = srcBGR[2];
        if((nRed == nGreen) && (nGreen == nBlue))
		{
			nMax = srcBGR[0];
		    nMaxIndex = 0;
			nMin = srcBGR[1];
		    nMinIndex = 1;
		}
		else
		{
			nMax = max( nRed, max( nGreen, nBlue ) );
			nMin = min( nRed, min( nGreen, nBlue ) );
			nMaxIndex = ((nMax == nGreen) && (nMax != nRed)) * 1 + ((nMax == nBlue) && (nMax != nGreen) && (nMax != nRed)) * 2;
			nMinIndex = ((nMin == nGreen) && (nMin != nRed)) * 1 + ((nMin == nBlue) && (nMin != nGreen) && (nMin != nRed)) * 2;
		}

        nMedianIndex = 3 - nMinIndex - nMaxIndex;
	    nMedian      = srcBGR[nMedianIndex];

	    // Max and min value is totally based on mapping table, only median value could be corrected for avoiding hue shift
	    nMaxDst      = dstBGR[nMaxIndex];
	    nMinDst      = dstBGR[nMinIndex];
	    nMedianDst_o = dstBGR[nMedianIndex];

	    unsigned int nDelta = nMax - nMin;

        if (nDelta == 0)
		    nMedianDst = nMedianDst_o;
	    else
		    nMedianDst = (int)(( ((float)(nMedian - nMin)*(float)(nMaxDst - nMinDst) / (float)nDelta) ) + nMinDst + 0.5f); // avoid hue shift formula


        //dstBGR[nMedianIndex] = nMedianDst_o;
        //if( max_median != nMedianDst && min_median != nMedianDst)
            //dstBGR[nMedianIndex] = nMedianDst;
        //else if( max_median != nMedian && min_median != nMedian)
            //dstBGR[nMedianIndex] = nMedian;
		int max_median = max( nMedianDst_o, max( nMedianDst, nMedian ) );
        int min_median = min( nMedianDst_o, min( nMedianDst, nMedian ) );
		dstBGR[nMedianIndex] = (nMedianDst_o + nMedianDst + nMedian) - (max_median + min_median );
    }

    // _ChkBoundaryUpdate_( intBGR[i], 0, MAX_16BITS_VALUE );
    /*for(int i = 0; i < 3; i++)
    {
        //if(dstBGR[i] < 0)
            //dstBGR[i] = 0;
       // else if(dstBGR[i] > MAX_16BITS_VALUE)
           // dstBGR[i] = MAX_16BITS_VALUE;
		dstBGR[i] = min(dstBGR[i],MAX_16BITS_VALUE);
    }*/

    dstBGR = min(dstBGR, MAX_16BITS_VALUE);

	// output
    int4 dst4 = {dstBGR.s0,dstBGR.s1,dstBGR.s2,src4.s3};
	dstIm[dst_index] = convert_ushort4(dst4);

}

kernel void	DoMappingAvoidHueShiftEX_Fast( global const ushort4* srcIm,	global ushort4* dstIm,	int  width, int height,
										 global int *MappingTable, int src_stride, int dst_stride)
{
    int		x = get_global_id(0);
    int		y = get_global_id(1);

    if( x >= width || y >= height)
        return;

    int	src_index = y*src_stride + x;
    int	dst_index = y*dst_stride + x;

    int4 src4 = convert_int4(srcIm[src_index]);

    int nMedian;
    int nMax;
    int nMin;
    int nMedianDst;
    int nMedianDst_o;
    int nMaxDst;
    int nMinDst;

    int nMaxIndex;
    int nMinIndex;
    int nMedianIndex;

    // find max index and value
    //if ( (srcBGR[0] >= srcBGR[1]) && (srcBGR[0] >= srcBGR[2]) )
    if ( (src4.s0 >= src4.s1) && (src4.s0 >= src4.s2) )
    {
        nMax = src4.s0;
        nMaxIndex = 0;
    }
    //else if ( (srcBGR[1] >= srcBGR[0]) && (srcBGR[1] >= srcBGR[2]) )
    else if ( (src4.s1 >= src4.s0) && (src4.s1 >= src4.s2) )
    {
        nMax = src4.s1;
        nMaxIndex = 1;
    }
    //else if ( (srcBGR[2] >= srcBGR[0]) && (srcBGR[2] >= srcBGR[1]) )
    else if ( (src4.s2 >= src4.s0) && (src4.s2 >= src4.s1) )
    {
        nMax = src4.s2;
        nMaxIndex = 2;
    }

    // find  min index and value
    //if ( (nMaxIndex != 0) && (srcBGR[0] <= srcBGR[1]) && (srcBGR[0] <= srcBGR[2]) )
    if ( (nMaxIndex != 0) && (src4.s0 <= src4.s1) && (src4.s0 <= src4.s2) )
    {
        nMin = src4.s0;
        nMinIndex = 0;
    }
    //else if ( (nMaxIndex != 1)  && (srcBGR[1] <= srcBGR[0]) && (srcBGR[1] <= srcBGR[2]) )
    else if ( (nMaxIndex != 1)  && (src4.s1 <= src4.s0) && (src4.s1 <= src4.s2) )
    {
        nMin = src4.s1;
        nMinIndex = 1;
    }
    //else if ( (nMaxIndex != 2) && (srcBGR[2] <= srcBGR[0]) && (srcBGR[2] <= srcBGR[1]) )
    else if ( (nMaxIndex != 2) && (src4.s2 <= src4.s0) && (src4.s2 <= src4.s1) )
    {
        nMin = src4.s2;
        nMinIndex = 2;
    }

    // find medium index and value
    nMedianIndex = 3 - nMinIndex - nMaxIndex;
    nMedian      = (src4.s0 + src4.s1 + src4.s2) - (nMin + nMax);

    // Max and min value is totally based on mapping table, only median value could be corrected for avoiding hue shift
    //nMaxDst      = MappingTable[srcBGR[nMaxIndex]];
    //nMinDst      = MappingTable[srcBGR[nMinIndex]];
    //nMedianDst_o = MappingTable[srcBGR[nMedianIndex]];
    nMaxDst      = MappingTable[nMax];
    nMinDst    = MappingTable[nMin];
    nMedianDst_o = MappingTable[nMedian];
    int Dst[3];

    unsigned int nSrcDelta = nMax - nMin;
    if ( nSrcDelta > 0 )
    {
        // Keep saturation is too risk on tone adjustment. Disable it until better solution.
        //unsigned int nDstDelta = nMaxDst - nMinDst_o;

        //float dSrcSat = (float)nSrcDelta/(float)nMax;
        //float dDstSat = (float)(nMaxDst-nMinDst_o)/(float)nMaxDst;
        //float dSatWeight = (dDstSat-dSrcSat) * (dDstSat-dSrcSat);

        //nMinDst = nMaxDst - (dSrcSat*nMaxDst);
        //nMinDst = nMinDst * dSatWeight + nMinDst_o * (1 - dSatWeight);

        nMedianDst = (int)(((unsigned int)(nMedian - nMin)*(unsigned int)(nMaxDst - nMinDst) + (nSrcDelta >> 1)) / nSrcDelta) + nMinDst; // avoid hue shift formula
    }
    else
    {
        nMedianDst = nMedianDst_o;
    }

    if ( nMedianDst_o >= nMedian)
    {
        if (nMedianDst >= nMedianDst_o)
            Dst[nMedianIndex] = nMedianDst_o;
        else if (nMedianDst >= nMedian)
            Dst[nMedianIndex] = nMedianDst;
        else
            Dst[nMedianIndex] = nMedian;
    }
    else
    {
        if ( nMedianDst <= nMedianDst_o )
            Dst[nMedianIndex] = nMedianDst_o;
        else if ( nMedianDst <= nMedian )
            Dst[nMedianIndex] = nMedianDst;
        else
            Dst[nMedianIndex] = nMedian;
    }

    Dst[nMaxIndex] = nMaxDst;
    Dst[nMinIndex] = nMinDst;
    int4 dst4 = {Dst[0],Dst[1],Dst[2],src4.s3};   // value of original alpha channel not kept

    dstIm[dst_index] = convert_ushort4(dst4);
}

// this kernel combine the code of functions m_fnApplyWeightExposure and m_fnAvoidHueShift
kernel void ApplyWeightExposure_AvoidHueShift(global const ushort4* srcIm, global ushort4* dstIm, global int* m_pnTable1,
                                                  global int* m_pnTable2, int width, int height, int src_stride, int dst_stride, float fWeight1, float fWeight2)
{
	int		x = get_global_id(0);
	int		y = get_global_id(1);

	if( x >= width || y >= height)
		return;

	int	src_index = y*src_stride + x;
	int	dst_index = y*dst_stride + x;

	int4 src4 = convert_int4(srcIm[src_index]);   // read from input
	int3 srcBGR = { src4.s0,src4.s1,src4.s2 };

    // 1. m_fnApplyWeightExposure
	int3	dstBGR;
	// computation for dstBGR[]

	float3 weight1_3 = (float3)(fWeight1, fWeight1, fWeight1);
	float3 weight2_3 = (float3)(fWeight2, fWeight2, fWeight2);
    float3 table1_3 = (float3)(m_pnTable1[srcBGR.s0], m_pnTable1[srcBGR.s1], m_pnTable1[srcBGR.s2]);
	float3 table2_3 = (float3)(m_pnTable2[srcBGR.s0], m_pnTable2[srcBGR.s1], m_pnTable2[srcBGR.s2]);
	dstBGR = convert_int3( (table1_3 * fWeight1 + table2_3 * weight2_3) + 0.5f );

    /*
	for( int i = 0; i < 3; ++i )
    {
        dstBGR[i] = ROUNDF_INT( pnTbl_1[srcBGR[i]] * (nWeight_2 -dWeightExposure_abs) + pnTbl_2[srcBGR[i]] * (dWeightExposure_abs - nWeight_1) );
    }
    */

    // 2. m_fnAvoidHueShift
    // if ( dstBGR[0] != srcBGR[0] && dstBGR[1] != srcBGR[1] && dstBGR[2] != srcBGR[2] )
    if ( all(dstBGR != srcBGR) )
    {
        int nMedian      = 0;
	    int nMax         = 0;
	    int nMin         = 0;
	    int nMedianDst   = 0;
	    int nMedianDst_o = 0;
	    int nMaxDst      = 0;
	    int nMinDst      = 0;
	    int nMaxIndex       = 0;
	    int nMinIndex       = 0;
	    int nMedianIndex    = 0;

        int nRed = srcBGR[0];
        int nGreen = srcBGR[1];
        int nBlue = srcBGR[2];
		if((nRed == nGreen) && (nGreen == nBlue))
		{
			nMax = srcBGR[0];
		    nMaxIndex = 0;
			nMin = srcBGR[1];
		    nMinIndex = 1;
		}
		else
		{
			nMax = max( nRed, max( nGreen, nBlue ) );
			nMin = min( nRed, min( nGreen, nBlue ) );
			nMaxIndex = ((nMax == nGreen) && (nMax != nRed)) * 1 + ((nMax == nBlue) && (nMax != nGreen) && (nMax != nRed)) * 2;
			nMinIndex = ((nMin == nGreen) && (nMin != nRed)) * 1 + ((nMin == nBlue) && (nMin != nGreen) && (nMin != nRed)) * 2;
		}
        nMedianIndex = 3 - nMinIndex - nMaxIndex;
	    nMedian      = srcBGR[nMedianIndex];

	    // Max and min value is totally based on mapping table, only median value could be corrected for avoiding hue shift
	    nMaxDst      = dstBGR[nMaxIndex];
	    nMinDst      = dstBGR[nMinIndex];
	    nMedianDst_o = dstBGR[nMedianIndex];

	    unsigned int nDelta = nMax - nMin;

        if (nDelta == 0)
		    nMedianDst = nMedianDst_o;
	    else
		    nMedianDst = (int)(( ((float)(nMedian - nMin)*(float)(nMaxDst - nMinDst) / (float)nDelta) ) + nMinDst + 0.5f); // avoid hue shift formula

        int max_median = max( nMedianDst_o, max( nMedianDst, nMedian ) );
        int min_median = min( nMedianDst_o, min( nMedianDst, nMedian ) );
		dstBGR[nMedianIndex] = (nMedianDst_o + nMedianDst + nMedian) - (max_median + min_median );

       // dstBGR[nMedianIndex] = nMedianDst_o;
        //if( max_median != nMedianDst && min_median != nMedianDst)
       //     dstBGR[nMedianIndex] = nMedianDst;
       // else if( max_median != nMedian && min_median != nMedian)
         //   dstBGR[nMedianIndex] = nMedian;

    }


    // 3. _ChkBoundaryUpdate_( intBGR[i], 0, MAX_16BITS_VALUE );
   /*for(int i = 0; i < 3; i++)
    {
        //if(dstBGR[i] < 0)
        //    dstBGR[i] = 0;
       // else if(dstBGR[i] > MAX_16BITS_VALUE)
            //dstBGR[i] = MAX_16BITS_VALUE;
		dstBGR[i] = min(dstBGR[i], MAX_16BITS_VALUE);
    }*/
    dstBGR = min(dstBGR, MAX_16BITS_VALUE);

	// output
    int4 dst4 = {dstBGR.s0,dstBGR.s1,dstBGR.s2,src4.s3};
	dstIm[dst_index] = convert_ushort4(dst4);

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
