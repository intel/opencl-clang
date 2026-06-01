#define TONE_MAX_TABLE_SIZE			65536		// 2^16
#define EXPVALUE	5909							// TONE_MAX_TABLE_SIZE/ log(TONE_MAX_TABLE_SIZE)


constant	sampler_t	sample_linear	=	CLK_NORMALIZED_COORDS_FALSE |
								CLK_ADDRESS_CLAMP_TO_EDGE   |
								CLK_FILTER_LINEAR ;

constant	sampler_t	sample_nearest	=	CLK_NORMALIZED_COORDS_FALSE |
								CLK_ADDRESS_CLAMP_TO_EDGE   |
								CLK_FILTER_NEAREST ;

constant	float	cRound65 = (0.5f * 1.0f / 65535.0f);

// For 8 bit or 16 bit input images, OpenCL will map 0.0 to 1.0 to full range
//	and can just multiply by 255.


kernel void	DoMappingWeightAndSaturationEx( global const ushort4* srcIm,	global ushort4* dstIm,	int  width,
											float  fGradientEdge, int  nMaxValue,
											global int * MappingTable, global float * LogMappingTable, global float * ExpMappingTable,
											global int * SatMappingTable, global int * SatWeightingTable,
											global	unsigned short * GradientMask, int  GradientStride )
{
	// single work item per kernel

	int		x = get_global_id(0);

	// Assumes local_size(1) is an exact divisor of actual image height - possibly "1" - so can just test X bounds
	if( x < width )
	{

	int		nBoundary = nMaxValue;
	float	fBoundary = (float)nMaxValue;

	int		MaskIndex = x;
	float	fEdgeWeight = fGradientEdge * (float)(GradientMask[MaskIndex]);

	int4	pixel4 =  convert_int4(srcIm[x]);

	// Get min, median, max values from RGB (ignore alpha)
	int		nMax, nMedian, nMin;
	int		nRed, nGreen, nBlue, nAlpha;

	nRed = pixel4.s0;
	nGreen = pixel4.s1;
	nBlue = pixel4.s2;
	nAlpha = pixel4.s3;

	nMax = max( nRed, max( nGreen, nBlue ) );
	nMin = min( nRed, min( nGreen, nBlue ) );
	nMedian = (nRed + nGreen + nBlue) - nMax - nMin;

	// get positions of max, min, median - will use shuffle( MinMedianMaxAlpha, mask ) at end.
	int	posRed, posGreen, posBlue;

	// Note: values are indices to min/med/max/alpha vector at end.
	posRed = posGreen = posBlue = 1;	// default to Median

	if ( (nRed >= nGreen) && (nRed >= nBlue) )
	{
		posRed = 2;	// Red is Max
	}
	else if ( (nGreen >= nRed) && (nGreen >= nBlue) )
	{
		posGreen = 2;	// Green is Max
	}
	else if ( (nBlue >= nRed) && (nBlue >= nGreen) )
	{
		posBlue = 2;	// Blue is Max
	}

	// find  min index and value
	if ( (posRed != 2) && (nRed == nMin) )
	//if ( (posRed != 2) && (nRed <= nGreen) && (nRed <= nBlue) )
	{
		posRed = 0;		// Red is min
	}
	//else if ( (posGreen != 2)  && (nGreen <= nRed) && (nGreen <= nBlue) )
	else if ( (posGreen != 2)  && (nGreen == nMin) )
	{
		posGreen = 0;	// Green is min
	}
	//else if ( (posBlue != 2) && (nBlue <= nRed) && (nBlue <= nGreen) )
	else if ( (posBlue != 2) && (nBlue == nMin) )
	{
		posBlue = 0;	// Blue is min
	}


	uint4	shufMasku4;

	shufMasku4 = (uint4)(posRed, posGreen, posBlue, 3 );	// mask to select from min/med/max/alpha at end



	float	fMaxDstLog, fMedianDstLog, fMinDstLog;

	int	mapMax = MappingTable[ nMax];
	fMaxDstLog = fmax( LogMappingTable[ mapMax] + fEdgeWeight, 0.0f );
	fMedianDstLog = fmax( LogMappingTable[ MappingTable[ nMedian]] + fEdgeWeight, 0.0f );
	fMinDstLog = fmax( LogMappingTable[ MappingTable[ nMin]] + fEdgeWeight, 0.0f );


	// fmax above insures none are LESS than zero - slightly faster this way
	fMaxDstLog =    (fMaxDstLog == 0.0f)?    0.0f : (ExpMappingTable[ min( (int)( 0.5f + EXPVALUE *  fMaxDstLog ), TONE_MAX_TABLE_SIZE-1 ) ]);
	fMedianDstLog = (fMedianDstLog == 0.0f)? 0.0f : (ExpMappingTable[ min( (int)( 0.5f + EXPVALUE *  fMedianDstLog ), TONE_MAX_TABLE_SIZE-1 ) ]);
	fMinDstLog =    (fMinDstLog == 0.0f)?    0.0f : (ExpMappingTable[ min( (int)( 0.5f + EXPVALUE *  fMinDstLog ), TONE_MAX_TABLE_SIZE-1 ) ]);


	int	nMaxDst, nMedianDst, nMinDst;

	nMaxDst = (int)( 0.5f + fmax( fMaxDstLog, 0.0f ) );
	nMedianDst = (int)( 0.5f + fmax( fMedianDstLog, 0.0f ) );
	nMinDst = (int)( 0.5f + fmax( fMinDstLog, 0.0f ) );



	bool	bDecreaseSat = ( mapMax > nMax );


	if( bDecreaseSat )
	{
		nMaxDst = max( nMaxDst, nMax );
		nMedianDst = max( nMedianDst, nMedian );
		nMinDst = max( nMinDst, nMin );
	}
	else
	{
		nMaxDst = max( nMaxDst, 0 );
		nMedianDst = max( nMedianDst, 0 );
		nMinDst = max( nMinDst, 0 );
	}


	float	fSaturationNew, fSaturationOld;

	// FOLLOWING LINE HAS NO EFFECT - OVERWRITTEN LATER
	//fSaturationNew = select( (float)(nMaxDst - nMinDst) / select( (float)nMaxDst, 1.0f, (nMaxDst == 0) ), 0.0f, (nMaxDst == 0) );

	fSaturationOld = select( (float)(nMax - nMin) / select( (float)nMax, 1.0f, (nMax == 0) ), 0.0f, (nMax == 0) );


	float	fWeighting;

	if( nMaxDst == 0 )
		fWeighting = 1.0f;
	else
		fWeighting = (float)nMax / nMaxDst;

	if( bDecreaseSat )
		fSaturationNew = fSaturationOld + ( (SatMappingTable[ (int)(0.5f + (fSaturationOld * fBoundary))] / fBoundary) - fSaturationOld )
											* ( 1.0f - fWeighting ) *  SatWeightingTable[nMax] / fBoundary;
	else
		fSaturationNew = fSaturationOld;


	nMinDst = min( (int)(0.5f + fmax( ((float)nMaxDst * (1.0f - fSaturationNew)), 0.0f ) ), nMedianDst );

	uint	uDelta;

	uDelta = nMax - nMin;

	if( uDelta != 0 )
		nMedianDst = nMinDst + (int)( ((uint)(nMedian - nMin) * (uint)(nMaxDst - nMinDst) + (uDelta>>1)) / uDelta );


	int4	dstPixel;

	// THIS WAS IN ORIGINAL CODE - but rounding does nothing but waste time
	//nMaxDst = (int)(0.5f + min(nMaxDst, nBoundary) );
	//nMinDst = (int)(0.5f + min(nMinDst, nBoundary) );
	//nMedianDst = (int)(0.5f + min(nMedianDst, nBoundary) );
	nMaxDst =		min(nMaxDst, nBoundary );
	nMinDst =		min(nMinDst, nBoundary );
	nMedianDst =	min(nMedianDst, nBoundary );

	dstPixel = (int4)(nMinDst, nMedianDst, nMaxDst, nAlpha );

	dstPixel = shuffle( dstPixel, shufMasku4 );

	dstIm[x] = convert_ushort4(dstPixel);

	}	// end if width test

}	// end  DoMappingHeightAndSaturationex kernel


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
