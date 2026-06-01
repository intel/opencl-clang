#define TONE_MAX_CLARITY 100.0

#define _ChkBoundaryUpdate_(value, min, max)	if ( value < min ) { value = min; } else if ( value > max ) { value = max; }
#define ROUNDF_INT( fValue ) ((int)(fValue + 0.5f))
#define ROUND_PIXEL( dValue ) ((unsigned short)(dValue + 0.5))

constant sampler_t sample_nearest = CLK_NORMALIZED_COORDS_FALSE |
                                    CLK_ADDRESS_CLAMP_TO_EDGE   |
                                    CLK_FILTER_NEAREST ;

kernel void	DoClarity(global const ushort4*  srcIm,
                      global const ushort4*  bluIm,
                      global ushort4*  dstIm,
                      global float* tblUc,
                      int   nWidth,
                      float m_dAmount,
                      float dClarity
)
{
    int		x = get_global_id(0);

    if ( x >= nWidth )
        return;

    ushort4 iSrc4 = srcIm[x];
    ushort4 iBlu4 = bluIm[x];

    int i = 0;
    int pSrc[3];
    int pDst[3];
    int pBlu[3];

    pSrc[0] = iSrc4.s2; pSrc[1] = iSrc4.s1; pSrc[2] = iSrc4.s0;
    pBlu[0] = iBlu4.s2; pBlu[1] = iBlu4.s1; pBlu[2] = iBlu4.s0;

    for ( i = 0; i < 3; i++ )
    {
        //int nDst = pDst[i];
        int nSrc = pSrc[i];
        int nBlu = pBlu[i];

        // Apply mid-tone weighting
        int nPhrase[3] = {2600, 13500, 56700};								// Replace with constants // Compiler does that
        float dMidToneWeight = ( nSrc >= nPhrase[1]  && nSrc < nPhrase[2] );
        int nUnit = 32;
        int nIdx = 0;

		if ( nSrc >= nPhrase[0] && nSrc < nPhrase[1] )
        {
            // Use table
            nIdx = ( nSrc - nPhrase[0] ) / nUnit;
            dMidToneWeight = tblUc[nIdx];
        }
		else if ( nSrc >= nPhrase[2] )
        {
            // Use table
            nIdx = ( nSrc - nPhrase[0] - nPhrase[2] + nPhrase[1] ) / nUnit;
            dMidToneWeight = tblUc[nIdx];
        }

        // Algorithm: original + weight * edge, where edge = original - blur
		int nDst = (int) ( nSrc + dClarity * dMidToneWeight * ( nSrc - nBlu ) + 0.5 );

        if ( nDst > 65535 )
            nDst = 65535;
        if ( nDst < 0 )
            nDst = 0;

        pDst[i] = nDst;
    }

    iSrc4.s2 = pDst[0];
    iSrc4.s1 = pDst[1];
    iSrc4.s0 = pDst[2];

    dstIm[x] = iSrc4;
}


kernel void	DoClarity_pipeline(global const ushort4*  srcIm,
                      global const ushort4*  bluIm,
                      global ushort4*  dstIm,
                      //global unsigned char* tblUc,
					  global float* tblUc,
					  int   nOffset,
					  int   nBlurOffset,
                      int   nWidth,
                      float m_dAmount,
                      float dClarity
)
{
	int g_id = get_global_id(0);
    int	x = g_id + nOffset;

    if ( g_id >= nWidth )
        return;

    ushort4 iSrc4 = srcIm[x];
    ushort4 iBlu4 = bluIm[g_id+nBlurOffset];

	/*local float lutR[616];

	int init = get_local_id(0)+get_local_size(0)*get_local_id(1);
    int step = get_local_size(0)*get_local_size(1);

    for (int i = init; i < 616; i += step)
    {
            lutR[i] = tblUc[i];
    }
    barrier(CLK_LOCAL_MEM_FENCE);*/

    int i = 0;
    int pSrc[3];
    int pDst[3];
    int pBlu[3];

    pSrc[0] = iSrc4.s2; pSrc[1] = iSrc4.s1; pSrc[2] = iSrc4.s0;
    pBlu[0] = iBlu4.s2; pBlu[1] = iBlu4.s1; pBlu[2] = iBlu4.s0;

	// Where is the third load from the memory?!?!?
	//	Could it be tblUc[nIdx] access?

	// 1. Unroll the loop // Compiler does that
    for ( i = 0; i < 3; i++ )
    {
        //int nDst = pDst[i];
        int nSrc = pSrc[i];
        int nBlu = pBlu[i];

        // Apply mid-tone weighting
        int nPhrase[3] = {2600, 13500, 56700};								// Replace with constants // Compiler does that
        float dMidToneWeight = ( nSrc >= nPhrase[1]  && nSrc < nPhrase[2] );
        int nUnit = 32;
        int nIdx = 0;
        /*if ( nSrc < nPhrase[0] )											// Get rid of redundant code
        {
            dMidToneWeight = 0;
        }
        else*/

		if ( nSrc >= nPhrase[0] && nSrc < nPhrase[1] )
        {
            // Use table
            nIdx = ( nSrc - nPhrase[0] ) / nUnit;
            dMidToneWeight = tblUc[nIdx]; // / 255.0;							// Precompute / 255.0
			//dMidToneWeight = 0;
        }
		else if ( nSrc >= nPhrase[2] )
        {
            // Use table
            nIdx = ( nSrc - nPhrase[0] - nPhrase[2] + nPhrase[1] ) / nUnit;
            dMidToneWeight = tblUc[nIdx]; // / 255.0;							// Precompute / 255.0
			//dMidToneWeight = 0;
        }

        // Algorithm: original + weight * edge, where edge = original - blur
        //int nDst = (int) ( nSrc + m_dAmount * ( dClarity / TONE_MAX_CLARITY ) * dMidToneWeight * ( nSrc - nBlu ) + 0.5 );
		int nDst = (int) ( nSrc + dClarity * dMidToneWeight * ( nSrc - nBlu ) + 0.5 );

        if ( nDst > 65535 )						// Replace with min/max
            nDst = 65535;
        if ( nDst < 0 )
            nDst = 0;

        pDst[i] = nDst;
    }

    iSrc4.s2 = pDst[0];
    iSrc4.s1 = pDst[1];
    iSrc4.s0 = pDst[2];

	/*iSrc4.s0 = pSrc[0]+pBlu[0];
	iSrc4.s1 = pSrc[1]+pBlu[1];
	iSrc4.s2 = pSrc[2]+pBlu[2];*/

    dstIm[x] = iSrc4;
	//dstIm[x] = iBlu4;
}

kernel void	DoClarity_pipeline2(global const ushort4*  srcIm,
                      global const ushort4*  bluIm,
                      global ushort4*  dstIm,
                      //global unsigned char* tblUc,
					  global float* tblUc,
					  int   nOffset,
					  int   nBlurOffset,
                      int   nWidth,
                      float m_dAmount,
                      float dClarity
)
{
	size_t g_id = get_global_id(0);
    size_t	x = g_id + nOffset;

    if ( g_id >= nWidth )
        return;

    // ushort4 iSrc4 = srcIm[x];
    // ushort4 iBlu4 = bluIm[g_id+nBlurOffset];

	// Local lookup table
	/*local float lutR[616];
	int init = get_local_id(0)+get_local_size(0)*get_local_id(1);
    int step = get_local_size(0)*get_local_size(1);
    for (int i = init; i < 616; i += step)
    {
            lutR[i] = tblUc[i];
    }
    barrier(CLK_LOCAL_MEM_FENCE);*/

    ushort3 iSrc3 = as_ushort3(srcIm[x]);				  // *((ushort3*)&srcIm[x]);
    ushort3 iBlu3 = as_ushort3(bluIm[g_id+nBlurOffset]); // *((ushort3*)&bluIm[g_id+nBlurOffset]);

    int3 pSrc3 = convert_int3(iSrc3);
    int3 pBlu3 = convert_int3(iBlu3);

    int3 vIdx = (0);
    // float3 vdMidToneWeight = convert_float3( ( pSrc3 >= (13500)  && pSrc3 < (56700) ) );
	float3 vdMidToneWeight = ( (pSrc3 >= (13500))  && (pSrc3 < (56700)) ) ? (float3)(1.0) : (float3)(0.0);

	int3 b1 = (pSrc3 >= (2600)) &&  (pSrc3 < (13500));
    vIdx = b1 ? (pSrc3 - (2600)) / 32 : vIdx;

	int3 b2 = (pSrc3 >= (56700));
    vIdx = b2 ? (pSrc3 - (45800)) / 32 : vIdx;

	float3 lkp;
    lkp.s0 = tblUc[vIdx.s0];
    lkp.s1 = tblUc[vIdx.s1];
    lkp.s2 = tblUc[vIdx.s2];

	vdMidToneWeight = b1 || b2 ? lkp : vdMidToneWeight;

	// vdMidToneWeight = ( pSrc3 >= (13500)  && pSrc3 < (56700) ) ? (1.0f) : vdMidToneWeight;

    int3 nvDst = convert_int3( convert_float3(pSrc3) + dClarity * vdMidToneWeight * convert_float3( pSrc3 - pBlu3 ) + (float3)(0.5) );

    nvDst = clamp(nvDst, 0, 65535);

    // *((ushort3*)&dstIm[x]) = convert_ushort3(nvDst);
	ushort3 vRes = convert_ushort3(nvDst);
	dstIm[x] = (ushort4)( vRes.s0, vRes.s1, vRes.s2, srcIm[x].s3 );

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
