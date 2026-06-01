#define	MAX_ProPhotoRGB 65535
#define PRECISION 32

kernel void ApplyNormalEdge(global const ushort* src_buf, global int* dst_buf, int width, int height, int src_stride, int dst_stride, int nRangeDivider, float temp1, int Left, int Top, int SrcChannelNum, int DstChannelNum, int temp2  )
{
	int		x = get_global_id(0);
	int		y = get_global_id(1);

	//if( x >= (width/SrcChannelNum) || y >= height || x < Left || y < Top )
	if( x >= width || y >= height || x < Left || y < Top )
		return;

    int	src_index = y*src_stride + x*SrcChannelNum;
	int	dst_index = y*dst_stride + x*DstChannelNum;

	int src = (int)(src_buf[src_index]);   // read from input
    int dst = dst_buf[dst_index];   // read from input

    float sign;
	float fEdgeValue = 0;

	fEdgeValue = (src - (float)dst/10);

	// Normalize
	sign = 1.0f;

	if ( fEdgeValue < 0 )
	{
		sign = -1.0f;
		fEdgeValue *= -1;
	}

    if ( fEdgeValue > nRangeDivider )
	{
		fEdgeValue = nRangeDivider + (fEdgeValue - nRangeDivider ) * temp1/temp2 ;
	}

    fEdgeValue *= sign;

    dst = convert_int(10 * fEdgeValue);

    dst_buf[dst_index] = dst;

}

kernel void LABToProPhotoRGB48(global const ushort* pLumiBufSrc, global const int* pChroma1BufSrc, global const int* pChroma2BufSrc, global ushort4* pBufferDst, int width, int height, int LSrc_nStride, int C1Src_nStride, int C2Src_nStride, int dst_stride, global int* m_pnLAB2XYZTable)
{
    //int width = get_global_size(0);
    //int height = get_global_size(1);

	int		x = get_global_id(0);
	int		y = get_global_id(1);

	if( x >= width || y >= height)
		return;

    int L1_index = LSrc_nStride * y + x;
    int C1_index = C1Src_nStride * y + x;
    int C2_index = C2Src_nStride * y + x;
    int dst_index = dst_stride * y + x;

	ushort pLBufSrc = pLumiBufSrc[L1_index];
	int pC1BufSrc = pChroma1BufSrc[C1_index];
	int pC2BufSrc = pChroma2BufSrc[C2_index];

	//int var_Y = (int)( ( ( (float)pLBufSrc + 10485.6f ) / 1.16f ) + 0.5f );
    //int var_Y = (int)( ( ( (float)pLBufSrc + 10485.6f )* 1 / 1.16f ) + 0.5f );
    int var_Y = (int)fma( ( (float)pLBufSrc + 10485.6f ), 1 / 1.16f, 0.5f );

	//int var_X = pC1BufSrc * 0.2f + var_Y;
    int var_X = fma(pC1BufSrc, 0.2f, var_Y);
	int var_Z = var_Y - (pC2BufSrc >> 1);

	int X = 0;
	int Z = 0;

	if ( var_X < 0 )
	{
		//X = (int)( ( (  ( (float)var_X / 65535.0f ) - 0.1379310f ) * 8415.949659f ) + 0.5f );
        //X = (int)( ( (  ( (float)var_X * 1 / 65535.0f ) - 0.1379310f ) * 8415.949659f ) + 0.5f );
        X = (int)( fma ( fma( (float)var_X, 1 / 65535.0f, - 0.1379310f ), 8415.949659f, 0.5f ));
	}
	else
	{
		X = m_pnLAB2XYZTable[var_X];
	}

	if ( var_Z < 0 )
	{
		//Z = (int)( ( (  ( (float)var_Z / 65535.0f ) - 0.1379310f ) * 8415.949659f ) + 0.5f );
        //Z = (int)( ( (  ( (float)var_Z * 1 / 65535.0f ) - 0.1379310f ) * 8415.949659f ) + 0.5f );
        Z = (int)( fma ( fma( (float)var_Z, 1 / 65535.0f, - 0.1379310f ), 8415.949659f, 0.5f ));
	}
	else
	{
		Z = m_pnLAB2XYZTable[var_Z];
	}

	int Y = m_pnLAB2XYZTable[var_Y];

	//float var_R = X *  1.2977854f + Y * -0.2556075f + Z * -0.0421779f;
    float var_R = fma(X, 1.2977854f, fma( Y, -0.2556075f, Z * -0.0421779f));
	//float var_G = X * -0.5251131f + Y *  1.5081673f + Z *  0.0169457f;
    float var_G = fma(X, -0.5251131f, fma( Y,  1.5081673f, Z *  0.0169457f));
	float var_B = Z;

	// Normalize
    //int nMaxValue = MAX_ProPhotoRGB;
    float  dRatio = 1.0f;

	/*if ( var_R > var_G )
	{
		if ( var_R > var_B )
			dRatio = nMaxValue / var_R;
		else
			dRatio = nMaxValue / var_B;
	}
	else
	{
		if ( var_G > var_B )
			dRatio = nMaxValue / var_G;
		else
			dRatio = nMaxValue / var_B;
	}*/

    float max_var = max(var_B,max(var_R, var_G));
    //dRatio = MAX_ProPhotoRGB / max_var;

	//if ( dRatio < 1.0f )
    if ( max_var > MAX_ProPhotoRGB )
	{
       dRatio = MAX_ProPhotoRGB / max_var;
		var_R = var_R * dRatio;
		var_G = var_G * dRatio;
		var_B = var_B * dRatio;
	}

    var_R = max(0.0f, min(var_R, 65535.0f));
    var_G = max(0.0f, min(var_G, 65535.0f));
    var_B = max(0.0f, min(var_B, 65535.0f));

    //if ( var_R < 0 ) { var_R = 0; } else if ( var_R > 65535 ) { var_R = 65535; }
	//if ( var_G < 0 ) { var_G = 0; } else if ( var_G > 65535 ) { var_G = 65535; }
	//if ( var_B < 0 ) { var_B = 0; } else if ( var_B > 65535 ) { var_B = 65535; }

	ushort4 dst4 = pBufferDst[dst_index];
	dst4.s0 = (ushort)var_B; //RGB[2];
	dst4.s1 = (ushort)var_G; //RGB[1];
	dst4.s2 = (ushort)var_R; //RGB[0];
    pBufferDst[dst_index] = (dst4);
}


kernel void ProPhotoRGB48toLAB(global const ushort4* pixelBufferSrc, global ushort* pixelLumiDst, global int* pixelChroma1Dst, global int* pixelChroma2Dst, int width, int height, int src_stride, int LDst_nStride, int C1Dst_nStride, int C2Dst_nStride, global int* m_pnXYZtoLABTable)
{
    //int width = get_global_size(0);
    //int height = get_global_size(1);
    int		x = get_global_id(0);
	int		y = get_global_id(1);

	if( x >= width || y >= height)
		return;

	int	src_index = y*src_stride + x;
	int	Lumidst_index = y*LDst_nStride + x;
    int	C1dst_index = y*C1Dst_nStride + x;
	int	C2dst_index = y*C2Dst_nStride + x;

    ushort4 src4 = (pixelBufferSrc[src_index]);   // read from input

	ushort RGB[3];
	int LAB[3];

	int X = (src4.s2 * 13554 + src4.s1 * 2297 + src4.s0 * 533 + 8192) >> 14;
    //int X = (fma(src4.s2, 13554, fma(src4.s1, 2297, fma(src4.s0, 533, 8192)))) >> 14;
	int Y = (src4.s2 * 4719 + src4.s1 * 11663 + src4.s0 + 8192) >> 14;
    //int Y = (fma(src4.s2, 4719, fma(src4.s1, 11663, src4.s0 + 8192))) >> 14;
	int Z = (src4.s0 * 16384 + 8192) >> 14;
    //int Z = (fma(src4.s0, 16384, 8192)) >> 14;

    int var_X = m_pnXYZtoLABTable[X];
	int var_Y = m_pnXYZtoLABTable[Y];
	int var_Z = m_pnXYZtoLABTable[Z];

	//LAB[0] = ( ( ( 1.16f * (float)var_Y ) - 10485.6f ) + 0.5f );
    LAB[0] = (  fma( 1.16f, (float)var_Y, - 10485.6f ) + 0.5f );
	LAB[1] = 5 * ( var_X - var_Y );
	LAB[2] = ( var_Y - var_Z ) << 1;

  	pixelLumiDst[Lumidst_index] = (ushort)LAB[0];
	pixelChroma1Dst[C1dst_index] = LAB[1];
	pixelChroma2Dst[C2dst_index] = LAB[2];
}

kernel void GetSharpenessInfo_Accelerator_ROIProc(global ushort* pLumChannelBuf, global int* pImageBuffer,int width, int height, global int* nMaxEdge, global int* nMinEdge, global int *pRangeNumber, global int *pnRangeDivider,int nLumStride, int nImageStride, int nLumChannelNum, int nImageChannelNum, int Left, int Top)
{
	int		y = get_global_id(0);

	if(  y >= height)
		return;

	private int range_buffer[32] = {0};
	private int nMax = 0;
	private int nMin = 10000;

	int LumIndex, ImgIndex, pImageStart, nEdgeValue;
	ushort pLumStart;
	int y_nLumStride = (y+Top)*nLumStride;
	int y_nImageStride = (y+Top)*nImageStride;
    for( int x = Left; x < width/nLumChannelNum; x++)
    {
		LumIndex = y_nLumStride  + x*nLumChannelNum;
		ImgIndex = y_nImageStride  + x*nImageChannelNum;

		pLumStart= pLumChannelBuf[LumIndex];
		pImageStart = pImageBuffer[ImgIndex];
		nEdgeValue = 0;

		// Attention : tenfold output
		nEdgeValue = pLumStart - pImageStart/10;
		nEdgeValue = abs(nEdgeValue);

		if ( nEdgeValue > nMax )
		{
			nMax = nEdgeValue;
		}

		if (  nEdgeValue < nMin  )
		{
			nMin = nEdgeValue;
		}

		for ( int j = 0; j < PRECISION; ++j )
		{
			if ( ( nEdgeValue >= pnRangeDivider[j] ) && ( nEdgeValue < pnRangeDivider[j+1] ) )
			{
				range_buffer[j]++;
				j = PRECISION;
			}
		}
	}

	nMaxEdge[y] = nMax;
	nMinEdge[y] = nMin;

	for(int z = 0; z < 32; z++)
		pRangeNumber[32*y+z] = range_buffer[z];

}


kernel void GetSharpenessInfo_Accelerator_ROIProc_v1(global ushort* pLumChannelBuf, global int* pImageBuffer,int width, int height, global int* nMaxEdge, global int* nMinEdge, int nLumStride, int nImageStride, int nLumChannelNum, int nImageChannelNum, int Left, int Top)
{
	int		y = get_global_id(0);

	if(  y >= height)
		return;

	private int nMax = 0;
	private int nMin = 10000;

	int LumIndex, ImgIndex, pImageStart, nEdgeValue;
	ushort pLumStart;
	int y_nLumStride = (y+Top)*nLumStride;
	int y_nImageStride = (y+Top)*nImageStride;
    for( int x = Left; x < width/nLumChannelNum; x++)
    {
		LumIndex = y_nLumStride  + x*nLumChannelNum;
		ImgIndex = y_nImageStride  + x*nImageChannelNum;

		pLumStart= pLumChannelBuf[LumIndex];
		pImageStart = pImageBuffer[ImgIndex];
		nEdgeValue = 0;

		// Attention : tenfold output
		nEdgeValue = pLumStart - pImageStart/10;
		nEdgeValue = abs(nEdgeValue);

		if ( nEdgeValue > nMax )
		{
			nMax = nEdgeValue;
		}

		if (  nEdgeValue < nMin  )
		{
			nMin = nEdgeValue;
		}
	}

	nMaxEdge[y] = nMax;
	nMinEdge[y] = nMin;
}

















// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
