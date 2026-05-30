#define TONE_MAX_TABLE_SIZE     65536   // 2^16
#define EXPVALUE                5909    // TONE_MAX_TABLE_SIZE/ log(TONE_MAX_TABLE_SIZE)
#define	MAX_8BITS_VALUE         255
#define	MAX_16BITS_VALUE        65535

#define FASTHSV_HMAX			36000
#define FASTHSV48_HMAX			32640
#define FASTHSV48_HMAX_DIV2		16320
#define	FASTHSV48_HUE_60		5440
#define	FASTHSV48_HUE_120		10880
#define	FASTHSV48_HUE_240		21760
#define FASTHSV_RGB_SHIFT		7
#define	FASTHSV_RGB_SHIFT_DIV2	64
#define FASTHSV_SVMAX			32640		//  = (255 << FASTHSV_RGB_SHIFT)
#define FASTHSV_SVMAX_DIV2		16320
#define	FASTHSV_HUE_60			6000
#define	FASTHSV_HUE_60_DIV2		3000
#define	FASTHSV_HUE_120			12000
#define	FASTHSV_HUE_240			24000

#define FASTHSV48_MAX_RGB		65535
#define FASTHSV48_MAX_RGB_DIV2	32768

#define HUE_RED_CENTER			0
#define HUE_ORANGE_CENTER		3000
#define HUE_YELLOW_CENTER		5500
#define HUE_GREEN_CENTER		9500
#define HUE_AQUA_CENTER			16000
#define HUE_BLUE_CENTER			23000
#define HUE_PURPLE_CENTER		27500
#define HUE_MAGENTA_CENTER		33000
#define HUE_MAX					35999
#define HUE_NORMALIZE_VALUE		100

#define HUE_RED_MIN				(-3000)
#define HUE_RED_MIN_2			33000
#define HUE_RED_MAX				3000
#define HUE_ORANGE_MIN			0
#define HUE_ORANGE_MAX			5500
#define HUE_YELLOW_MIN			3000
#define HUE_YELLOW_MAX			9500
#define HUE_GREEN_MIN			5500
#define HUE_GREEN_MAX			16000
#define HUE_AQUA_MIN			9500
#define HUE_AQUA_MAX			23000
#define HUE_BLUE_MIN			16000
#define HUE_BLUE_MAX			27500
#define HUE_PURPLE_MIN			23000
#define HUE_PURPLE_MAX			33000
#define HUE_MAGENTA_MIN			27500
#define HUE_MAGENTA_MAX			35999

#define WEIGHTING_SHIFT			10
#define WEIGHTING_OFFSET		1024
#define WEIGHTING_OFFSET_DIV2	512

#define _ChkBoundaryUpdate_(value, min, max)	if ( value < min ) { value = min; } else if ( value > max ) { value = max; }
#define ROUND_INT( dValue ) ((int)(dValue + 0.5f))

constant	sampler_t	sample_linear	=	CLK_NORMALIZED_COORDS_FALSE |
								CLK_ADDRESS_CLAMP_TO_EDGE   |
								CLK_FILTER_LINEAR ;

constant	sampler_t	sample_nearest	=	CLK_NORMALIZED_COORDS_FALSE |
								CLK_ADDRESS_CLAMP_TO_EDGE   |
								CLK_FILTER_NEAREST ;

constant	float	cRound65 = (0.5f * 1.0f / 65535.0f);
typedef enum _HUE_COLOR_DEF
{
	Hue_None = -1,
	Hue_Red = 0,
	Hue_Orange,
	Hue_Yellow,
	Hue_Green,
	Hue_Aqua,
	Hue_Blue,
	Hue_Purple,
	Hue_Magenta,
	Hue_COLOR_COUNT = 8
} HUE_COLOR_DEF;

typedef ushort S_tables[5];
typedef ushort V_tables[3];

typedef enum _S_mapping
{
	Val_Ast = 0,	// Luminance
	Sat_Adj,		// Saturation
	Sat_Min,
	Vib_Adj,		// Vibrance
	Vib_Min
} S_mapping;
typedef enum _V_mapping
{
	Val_Adj = 0,
	Sat_Ast,
	Vib_Ast
} V_mapping;

typedef struct _hsv_color_table
{
	ushort S_tables[8][32641][5];
	ushort V_tables[8][32641][3];
} hsv_color_table;

#define GET_S_VALUE(val, color, tbl_id) (mappingTbl->S_tables[color][val][tbl_id])
#define GET_V_VALUE(val, color, tbl_id) (mappingTbl->V_tables[color][val][tbl_id])

void FastRGB48toHSV(int R, int G, int B, int* H, int* S, int* V)
{
    int delta, h;
	unsigned int nMin, nMax;

	nMin = min(min(R, G), B);
	nMax = max(max(R, G), B);

	// normalize RGB (65535) to SVMAX (32640)
	*V = (nMax * FASTHSV_SVMAX + FASTHSV48_MAX_RGB_DIV2) / FASTHSV48_MAX_RGB;
	delta = nMax - nMin;

	if ( delta != 0 )
		*S = FASTHSV_SVMAX - ( nMin * FASTHSV_SVMAX + (nMax >> 1) ) / nMax;
	else
	{
		// r = g = b, H don't care
		*S = 0;
		return;
	}

	// h is from 0 ~ 32640 which can use int for calculation without overflow
	if ( R == nMax )
		h = (( G - B ) * FASTHSV48_HUE_60 + (delta >> 1)) / delta;
	else if ( G == nMax )
		h = FASTHSV48_HUE_120 + (( B - R ) * FASTHSV48_HUE_60 + (delta >> 1)) / delta;
	else
		h = FASTHSV48_HUE_240 + (( R - G ) * FASTHSV48_HUE_60 + (delta >> 1)) / delta;

	if ( h < 0 )
		*H = (unsigned int)(h + FASTHSV48_HMAX);
	else
		*H = h;

	// adjust h to H (0 ~ 36000)
	*H = ((*H) * FASTHSV_HMAX + FASTHSV48_HMAX_DIV2) / FASTHSV48_HMAX;
}
void FastHSVtoRGB48( int H, int S, int V, int* R, int* G, int* B )
{
	unsigned int f;
	unsigned int p, q, t;
	unsigned int r, g, b;

	if ( S == 0 )
	{
		// achromatic (gray)
		r = g = b = V;
	}
	else
	{
		int hi = (H / FASTHSV_HUE_60);
		f = H % FASTHSV_HUE_60;
		p = (V * (FASTHSV_SVMAX - S) + FASTHSV_SVMAX_DIV2) / FASTHSV_SVMAX;
		q = (V * (FASTHSV_SVMAX - (S * f + FASTHSV_HUE_60_DIV2) / FASTHSV_HUE_60) + FASTHSV_SVMAX_DIV2) / FASTHSV_SVMAX;
		t = (V * (FASTHSV_SVMAX - (S * (FASTHSV_HUE_60 - f) + FASTHSV_HUE_60_DIV2) / FASTHSV_HUE_60) + FASTHSV_SVMAX_DIV2) / FASTHSV_SVMAX;

		switch( hi )
		{
		case 0:
			r = V;
			g = t;
			b = p;
			break;
		case 1:
			r = q;
			g = V;
			b = p;
			break;
		case 2:
			r = p;
			g = V;
			b = t;
			break;
		case 3:
			r = p;
			g = q;
			b = V;
			break;
		case 4:
			r = t;
			g = p;
			b = V;
			break;
		default:	// case 5:
			r = V;
			g = p;
			b = q;
			break;
		}
	}

	// de-normalize SVMAX (32640) to RGB (65535)
	*R = (unsigned short) ((r * FASTHSV48_MAX_RGB + FASTHSV_SVMAX_DIV2) / FASTHSV_SVMAX);
	*G = (unsigned short) ((g * FASTHSV48_MAX_RGB + FASTHSV_SVMAX_DIV2) / FASTHSV_SVMAX);
	*B = (unsigned short) ((b * FASTHSV48_MAX_RGB + FASTHSV_SVMAX_DIV2) / FASTHSV_SVMAX);
}

void GetHueWeight( int nHue, HUE_COLOR_DEF* color1, HUE_COLOR_DEF* color2, float* weight1, float* weight2 )
{
	if ( nHue >= HUE_RED_CENTER && nHue < HUE_ORANGE_CENTER )
	{
		*color1 = Hue_Red;
		*color2 = Hue_Orange;
		*weight1 = (float)(HUE_RED_MAX - nHue) / (HUE_RED_MAX - HUE_RED_CENTER);
		*weight2 = (float)(nHue - HUE_ORANGE_MIN) / (HUE_ORANGE_CENTER - HUE_ORANGE_MIN);
	}
	else if ( nHue >= HUE_ORANGE_CENTER && nHue < HUE_YELLOW_CENTER )
	{
		*color1 = Hue_Orange;
		*color2 = Hue_Yellow;
		*weight1 = (float)(HUE_ORANGE_MAX - nHue) / (HUE_ORANGE_MAX - HUE_ORANGE_CENTER);
		*weight2 = (float)(nHue - HUE_YELLOW_MIN) / (HUE_YELLOW_CENTER - HUE_YELLOW_MIN);
	}
	else if ( nHue >= HUE_YELLOW_CENTER && nHue < HUE_GREEN_CENTER )
	{
		*color1 = Hue_Yellow;
		*color2 = Hue_Green;
		*weight1 = (float)(HUE_YELLOW_MAX - nHue) / (HUE_YELLOW_MAX - HUE_YELLOW_CENTER);
		*weight2 = (float)(nHue - HUE_GREEN_MIN) / (HUE_GREEN_CENTER - HUE_GREEN_MIN);
	}
	else if ( nHue >= HUE_GREEN_CENTER && nHue < HUE_AQUA_CENTER )
	{
		*color1 = Hue_Green;
		*color2 = Hue_Aqua;
		*weight1 = (float)(HUE_GREEN_MAX - nHue) / (HUE_GREEN_MAX - HUE_GREEN_CENTER);
		*weight2 = (float)(nHue - HUE_AQUA_MIN) / (HUE_AQUA_CENTER - HUE_AQUA_MIN);
	}
	else if ( nHue >= HUE_AQUA_CENTER && nHue < HUE_BLUE_CENTER )
	{
		*color1 = Hue_Aqua;
		*color2 = Hue_Blue;
		*weight1 = (float)(HUE_AQUA_MAX - nHue) / (HUE_AQUA_MAX - HUE_AQUA_CENTER);
		*weight2 = (float)(nHue - HUE_BLUE_MIN) / (HUE_BLUE_CENTER - HUE_BLUE_MIN);
	}
	else if ( nHue >= HUE_BLUE_CENTER && nHue < HUE_PURPLE_CENTER )
	{
		*color1 = Hue_Blue;
		*color2 = Hue_Purple;
		*weight1 = (float)(HUE_BLUE_MAX - nHue) / (HUE_BLUE_MAX - HUE_BLUE_CENTER);
		*weight2 = (float)(nHue - HUE_PURPLE_MIN) / (HUE_PURPLE_CENTER - HUE_PURPLE_MIN);
	}
	else if ( nHue >= HUE_PURPLE_CENTER && nHue < HUE_MAGENTA_CENTER )
	{
		*color1 = Hue_Purple;
		*color2 = Hue_Magenta;
		*weight1 = (float)(HUE_PURPLE_MAX - nHue) / (HUE_PURPLE_MAX - HUE_PURPLE_CENTER);
		*weight2 = (float)(nHue - HUE_MAGENTA_MIN) / (HUE_MAGENTA_CENTER - HUE_MAGENTA_MIN);
	}
	else if ( nHue >= HUE_MAGENTA_CENTER && nHue <= HUE_MAX )
	{
		*color1 = Hue_Magenta;
		*color2 = Hue_Red;
		*weight1 = (float)(HUE_MAGENTA_MAX - nHue) / (HUE_MAGENTA_MAX - HUE_MAGENTA_CENTER);
		*weight2 = (float)(nHue - HUE_RED_MIN_2) / (HUE_MAX + 1 - HUE_RED_MIN_2);
	}
}

void GetHueWeight_INT( int nHue, HUE_COLOR_DEF* color1, HUE_COLOR_DEF* color2, int* weight1, int* weight2 )
{
	if ( nHue >= HUE_RED_CENTER && nHue < HUE_ORANGE_CENTER )
	{
		*color1 = Hue_Red;
		*color2 = Hue_Orange;
		*weight1 = ((HUE_RED_MAX - nHue) << WEIGHTING_SHIFT) / (HUE_RED_MAX - HUE_RED_CENTER);
		*weight2 = ((nHue - HUE_ORANGE_MIN) << WEIGHTING_SHIFT) / (HUE_ORANGE_CENTER - HUE_ORANGE_MIN);
	}
	else if ( nHue < HUE_YELLOW_CENTER )
	{
		*color1 = Hue_Orange;
		*color2 = Hue_Yellow;
		*weight1 = ((HUE_ORANGE_MAX - nHue) << WEIGHTING_SHIFT) / (HUE_ORANGE_MAX - HUE_ORANGE_CENTER);
		*weight2 = ((nHue - HUE_YELLOW_MIN) << WEIGHTING_SHIFT) / (HUE_YELLOW_CENTER - HUE_YELLOW_MIN);
	}
	else if ( nHue < HUE_GREEN_CENTER )
	{
		*color1 = Hue_Yellow;
		*color2 = Hue_Green;
		*weight1 = ((HUE_YELLOW_MAX - nHue) << WEIGHTING_SHIFT) / (HUE_YELLOW_MAX - HUE_YELLOW_CENTER);
		*weight2 = ((nHue - HUE_GREEN_MIN) << WEIGHTING_SHIFT) / (HUE_GREEN_CENTER - HUE_GREEN_MIN);
	}
	else if ( nHue < HUE_AQUA_CENTER )
	{
		*color1 = Hue_Green;
		*color2 = Hue_Aqua;
		*weight1 = ((HUE_GREEN_MAX - nHue) << WEIGHTING_SHIFT) / (HUE_GREEN_MAX - HUE_GREEN_CENTER);
		*weight2 = ((nHue - HUE_AQUA_MIN) << WEIGHTING_SHIFT) / (HUE_AQUA_CENTER - HUE_AQUA_MIN);
	}
	else if ( nHue < HUE_BLUE_CENTER )
	{
		*color1 = Hue_Aqua;
		*color2 = Hue_Blue;
		*weight1 = ((HUE_AQUA_MAX - nHue) << WEIGHTING_SHIFT) / (HUE_AQUA_MAX - HUE_AQUA_CENTER);
		*weight2 = ((nHue - HUE_BLUE_MIN) << WEIGHTING_SHIFT) / (HUE_BLUE_CENTER - HUE_BLUE_MIN);
	}
	else if ( nHue < HUE_PURPLE_CENTER )
	{
		*color1 = Hue_Blue;
		*color2 = Hue_Purple;
		*weight1 = ((HUE_BLUE_MAX - nHue) << WEIGHTING_SHIFT) / (HUE_BLUE_MAX - HUE_BLUE_CENTER);
		*weight2 = ((nHue - HUE_PURPLE_MIN) << WEIGHTING_SHIFT) / (HUE_PURPLE_CENTER - HUE_PURPLE_MIN);
	}
	else if ( nHue < HUE_MAGENTA_CENTER )
	{
		*color1 = Hue_Purple;
		*color2 = Hue_Magenta;
		*weight1 = ((HUE_PURPLE_MAX - nHue) << WEIGHTING_SHIFT) / (HUE_PURPLE_MAX - HUE_PURPLE_CENTER);
		*weight2 = ((nHue - HUE_MAGENTA_MIN) << WEIGHTING_SHIFT) / (HUE_MAGENTA_CENTER - HUE_MAGENTA_MIN);
	}
	else if ( nHue <= HUE_MAX )
	{
		*color1 = Hue_Magenta;
		*color2 = Hue_Red;
		*weight1 = ((HUE_MAGENTA_MAX - nHue) << WEIGHTING_SHIFT) / (HUE_MAGENTA_MAX - HUE_MAGENTA_CENTER);
		*weight2 = ((nHue - HUE_RED_MIN_2) << WEIGHTING_SHIFT) / (HUE_MAX + 1 - HUE_RED_MIN_2);
	}
}

void m_fnAdjustLuminanceProPhotoRGB( int H, int* S, int* V,
                                     global float* satWeightTbl, global float* valWeightTbl,
                                     global int* valAdjTbl, global int* valMinTbl, global int* valAstTbl,
									 HUE_COLOR_DEF color1, HUE_COLOR_DEF color2, float dWeight1, float dWeight2 )
{
	float dSWeight = satWeightTbl[*S];
	float dVWeight = valWeightTbl[*V];

	int nNew1, nNew2;
	int nDiff1, nDiff2;

	global int* pMappingTable1 = &valAdjTbl[color1*FASTHSV_SVMAX];
	global int* pMappingTable2 = &valAdjTbl[color2*FASTHSV_SVMAX];

	// Adjust Value
	nNew1 = pMappingTable1[*V];	// color1's new value
	nNew2 = pMappingTable2[*V];	// color2's new value

	nDiff1 = ROUND_INT( (dWeight1 * ( nNew1 - *V )) );	// color1's effect quantity
	nDiff2 = ROUND_INT( (dWeight2 * ( nNew2 - *V )) );	// color2's effect quantity

	// Adjust Value according to adjuster curve and dSWeight
	*V = *V + ROUND_INT( ((nDiff1 + nDiff2) * dSWeight) );	// synergy of color1 and color2

	// Adjust Saturation
	pMappingTable1 = &valAstTbl[color1*FASTHSV_SVMAX];
	pMappingTable2 = &valAstTbl[color2*FASTHSV_SVMAX];

	nNew1 = pMappingTable1[*S];	// color1's new value
	nNew2 = pMappingTable2[*S];	// color2's new value

	nDiff1 = ROUND_INT( (dWeight1 * ( nNew1 - *S )) );	// color1's effect quantity
	nDiff2 = ROUND_INT( (dWeight2 * ( nNew2 - *S )) );	// color2's effect quantity

	// Adjust Saturation according to adjusterAssist curve and dVWeight
	*S = *S + ROUND_INT( ((nDiff1 + nDiff2) * dVWeight) );	// synergy of color1 and color2

	_ChkBoundaryUpdate_( *V, 0, FASTHSV_SVMAX );
	_ChkBoundaryUpdate_( *S, 0, FASTHSV_SVMAX );

}

void m_fnAdjustLuminanceProPhotoRGB_SVM( int H, int* S, int* V,
                                     global float* satWeightTbl, global float* valWeightTbl,
                                     global hsv_color_table* mappingTbl, int valAdjTbl, int valMinTbl, int valAstTbl,
									 HUE_COLOR_DEF color1, HUE_COLOR_DEF color2, float dWeight1, float dWeight2 )
{
	float dSWeight = satWeightTbl[*S];
	float dVWeight = valWeightTbl[*V];

	int nNew1, nNew2;
	int nDiff1, nDiff2;

	nNew1 = GET_V_VALUE(*V, color1, valAdjTbl);
	nNew2 = GET_V_VALUE(*V, color2, valAdjTbl);

	nDiff1 = ROUND_INT( (dWeight1 * ( nNew1 - *V )) );	// color1's effect quantity
	nDiff2 = ROUND_INT( (dWeight2 * ( nNew2 - *V )) );	// color2's effect quantity

	// Adjust Value according to adjuster curve and dSWeight
	*V = *V + ROUND_INT( ((nDiff1 + nDiff2) * dSWeight) );	// synergy of color1 and color2

	// Adjust Saturation

	nNew1 = GET_S_VALUE(*S, color1, valAstTbl);
	nNew2 = GET_S_VALUE(*S, color2, valAstTbl);

	nDiff1 = ROUND_INT( (dWeight1 * ( nNew1 - *S )) );	// color1's effect quantity
	nDiff2 = ROUND_INT( (dWeight2 * ( nNew2 - *S )) );	// color2's effect quantity

	// Adjust Saturation according to adjusterAssist curve and dVWeight
	*S = *S + ROUND_INT( ((nDiff1 + nDiff2) * dVWeight) );	// synergy of color1 and color2

	_ChkBoundaryUpdate_( *V, 0, FASTHSV_SVMAX );
	_ChkBoundaryUpdate_( *S, 0, FASTHSV_SVMAX );

}

void m_fnAdjustSaturationProPhotoRGB( int H, int *S, int *V,
                                      global int* satAdjTbl, global int* satMinTbl, global int* satAstTbl,
                                      HUE_COLOR_DEF color1, HUE_COLOR_DEF color2, float dWeight1, float dWeight2 )
{
	// Basic Idea:
	// 1.
	// Adjust saturation between adjuster and adjusterMin curves. (Interpolate by dVWeight)
	// for (saturation-), the saturation difference will apply a gamma curve by value amount.
	// 2.
	// Adjust value by adjusterAssist curve and apply a dSWeight weighting.

	float dVWeight = (float)*V / FASTHSV_SVMAX;
	float dSWeight = (float)*S / FASTHSV_SVMAX;

	int nNew1, nNew2, nNewMin1, nNewMin2;
	int nDiff1, nDiff2;

	global int* pMappingTable1 = &satAdjTbl[color1*FASTHSV_SVMAX];
	global int* pMappingTable2 = &satAdjTbl[color2*FASTHSV_SVMAX];
	global int* pMappingTableMin1 = &satMinTbl[color1*FASTHSV_SVMAX];
	global int* pMappingTableMin2 = &satMinTbl[color2*FASTHSV_SVMAX];

	// Adjust Saturation
	nNew1 = pMappingTable1[*S];	// color1's new saturation
	nNew2 = pMappingTable2[*S];	// color2's new saturation
	nNewMin1 = pMappingTableMin1[*S];	// color1's new min saturation
	nNewMin2 = pMappingTableMin2[*S];	// color2's new min saturation

	// new saturation will be between adjuster and adjusterMin curve according to value weight
	nNew1 = ROUND_INT( (nNew1 * (1 - dVWeight) + nNewMin1 * dVWeight) );
	nNew2 = ROUND_INT( (nNew2 * (1 - dVWeight) + nNewMin2 * dVWeight) );

	nDiff1 = ROUND_INT( (dWeight1 * ( nNew1 - *S )) );	// color1's effect quantity
	nDiff2 = ROUND_INT( (dWeight2 * ( nNew2 - *S )) );	// color2's effect quantity

	int nTotalDiff = nDiff1 + nDiff2;	// synergy of color1 and color2

	if ( nTotalDiff < 0 )
	{
		// When saturation goes down, we should adjust the difference by dVWeight
		// The smaller the value, the difference should be smaller
		// The difference will apply a gamma curve (1.0 ~ 1.7 according to dVWeight)
		int nAbsDiff = -nTotalDiff;
		float dGamma = 1.0 + 0.7 * (1.0 - dVWeight) ;
		nAbsDiff = ROUND_INT( (pow( (float)nAbsDiff / *S, dGamma ) * *S) );
		nTotalDiff = -nAbsDiff;
	}

	*S = *S + nTotalDiff;

	// Adjust Value
	// Only when saturation slider < 0 need to adjust value
	// Adjust value by adjusterAssist curve
	// Then, apply dSWeight in difference. The smaller the saturation, we should adjust value slighter

	pMappingTable1 = &satAstTbl[color1*FASTHSV_SVMAX];
	pMappingTable2 = &satAstTbl[color2*FASTHSV_SVMAX];

	nNew1 = pMappingTable1[*V];
	nNew2 = pMappingTable2[*V];

	nDiff1 = ROUND_INT( (dWeight1 * ( nNew1 - *V ) * dSWeight) );	// color1's effect quantity
	nDiff2 = ROUND_INT( (dWeight2 * ( nNew2 - *V ) * dSWeight) );	// color2's effect quantity

	*V = *V + nDiff1 + nDiff2;

	_ChkBoundaryUpdate_( *S, 0, FASTHSV_SVMAX );
	_ChkBoundaryUpdate_( *V, 0, FASTHSV_SVMAX );

}

void m_fnAdjustSaturationProPhotoRGB_SVM( int H, int *S, int *V,
                                      global hsv_color_table* mappingTbl, int satAdjTbl, int satMinTbl, int satAstTbl,
                                      HUE_COLOR_DEF color1, HUE_COLOR_DEF color2, float dWeight1, float dWeight2 )
{
	// Basic Idea:
	// 1.
	// Adjust saturation between adjuster and adjusterMin curves. (Interpolate by dVWeight)
	// for (saturation-), the saturation difference will apply a gamma curve by value amount.
	// 2.
	// Adjust value by adjusterAssist curve and apply a dSWeight weighting.

	float dVWeight = (float)*V / FASTHSV_SVMAX;
	float dSWeight = (float)*S / FASTHSV_SVMAX;

	int nNew1, nNew2, nNewMin1, nNewMin2;
	int nDiff1, nDiff2;

	nNew1 = GET_S_VALUE(*S, color1, satAdjTbl);
	nNew2 = GET_S_VALUE(*S, color2, satAdjTbl);
	nNewMin1 = GET_S_VALUE(*S, color1, satMinTbl);
	nNewMin2 = GET_S_VALUE(*S, color2, satMinTbl);

	// new saturation will be between adjuster and adjusterMin curve according to value weight
	nNew1 = ROUND_INT( (nNew1 * (1 - dVWeight) + nNewMin1 * dVWeight) );
	nNew2 = ROUND_INT( (nNew2 * (1 - dVWeight) + nNewMin2 * dVWeight) );

	nDiff1 = ROUND_INT( (dWeight1 * ( nNew1 - *S )) );	// color1's effect quantity
	nDiff2 = ROUND_INT( (dWeight2 * ( nNew2 - *S )) );	// color2's effect quantity

	int nTotalDiff = nDiff1 + nDiff2;	// synergy of color1 and color2

	if ( nTotalDiff < 0 )
	{
		// When saturation goes down, we should adjust the difference by dVWeight
		// The smaller the value, the difference should be smaller
		// The difference will apply a gamma curve (1.0 ~ 1.7 according to dVWeight)
		int nAbsDiff = -nTotalDiff;
		float dGamma = 1.0f + 0.7f * (1.0f - dVWeight) ;
		nAbsDiff = ROUND_INT( (pow( (float)nAbsDiff / *S, dGamma ) * *S) );
		nTotalDiff = -nAbsDiff;
	}

	*S = *S + nTotalDiff;

	// Adjust Value
	// Only when saturation slider < 0 need to adjust value
	// Adjust value by adjusterAssist curve
	// Then, apply dSWeight in difference. The smaller the saturation, we should adjust value slighter

	nNew1 = GET_V_VALUE(*V, color1, satAstTbl);
	nNew2 = GET_V_VALUE(*V, color2, satAstTbl);

	nDiff1 = ROUND_INT( (dWeight1 * ( nNew1 - *V ) * dSWeight) );	// color1's effect quantity
	nDiff2 = ROUND_INT( (dWeight2 * ( nNew2 - *V ) * dSWeight) );	// color2's effect quantity

	*V = *V + nDiff1 + nDiff2;

	_ChkBoundaryUpdate_( *S, 0, FASTHSV_SVMAX );
	_ChkBoundaryUpdate_( *V, 0, FASTHSV_SVMAX );

}

void m_fnAdjustBWProPhotoRGB_INT(   int nInput, int H, int S, int* nOutput,
                                    global int* pnAdjTbl,
                                    global int* pnSatWeightTbl,
                                    global int* pnSkinSatWeightTbl,
                                    HUE_COLOR_DEF color1, HUE_COLOR_DEF color2, int nWeight1, int nWeight2 )
{
        int nSWeight        = pnSatWeightTbl[S];
        int nSkinSWeight    = pnSkinSatWeightTbl[S];

        int nIdx1 = color1 + nInput * Hue_COLOR_COUNT;
        int nIdx2 = color2 + nInput * Hue_COLOR_COUNT;

        int nNew1 = pnAdjTbl[nIdx1];
        int nNew2 = pnAdjTbl[nIdx2];

        int nDiff1 = ((nNew1 - nInput) * nWeight1 + WEIGHTING_OFFSET_DIV2) >> WEIGHTING_SHIFT;
        int nDiff2 = ((nNew2 - nInput) * nWeight2 + WEIGHTING_OFFSET_DIV2) >> WEIGHTING_SHIFT;

        if ( H >= HUE_RED_CENTER && H < HUE_YELLOW_CENTER )
        {
            *nOutput = nInput + ( ( (nDiff1 + nDiff2) * nSkinSWeight + WEIGHTING_OFFSET_DIV2 ) >> ( WEIGHTING_SHIFT - 1 ) );
        }
        else
        {
            *nOutput = nInput + ( ( (nDiff1 + nDiff2) * nSWeight + WEIGHTING_OFFSET_DIV2 ) >> ( WEIGHTING_SHIFT - 1 ) );
        }
}

kernel void	DoMappingHSV( global const ushort4* srcIm,
                          global ushort4* dstIm,
                          int nWidth,
                          global float* satWeightTbl,
                          global float* valWeightTbl,
                          int hasHue, global int* hueTbl,
                          int hasSat, global int* satAdjTbl, global int* satMinTbl, global int* satAstTbl,
                          int hasVal, global int* valAdjTbl, global int* valMinTbl, global int* valAstTbl,
                          int hasVib, global int* vibAdjTbl, global int* vibMinTbl, global int* vibAstTbl
                          )
{
    int		x = get_global_id(0);

    if ( x >= nWidth )
        return;

    ushort4 oPixeli4 = srcIm[x];

    int R, G, B;
    int H, S, V;

    R = oPixeli4.s2;
    G = oPixeli4.s1;
    B = oPixeli4.s0;
    FastRGB48toHSV(R, G, B, &H, &S, &V);

    float dWeight1 = 0;
    float dWeight2 = 0;
    HUE_COLOR_DEF color1 = Hue_None;
    HUE_COLOR_DEF color2 = Hue_None;

    if ( S > 0 )
    {
        GetHueWeight( H, &color1, &color2, &dWeight1, &dWeight2 );
        if ( hasVal )
            m_fnAdjustLuminanceProPhotoRGB ( H, &S, &V, satWeightTbl, valWeightTbl,
                                             valAdjTbl, valMinTbl, valAstTbl, color1, color2, dWeight1, dWeight2 );
        if ( hasSat )
            m_fnAdjustSaturationProPhotoRGB( H, &S, &V,
                                             satAdjTbl, satMinTbl, satAstTbl, color1, color2, dWeight1, dWeight2 );
        if ( hasHue )
            H = hueTbl[H];
        if ( hasVib )
            m_fnAdjustSaturationProPhotoRGB( H, &S, &V,
                                             vibAdjTbl, vibMinTbl, vibAstTbl, color1, color2, dWeight1, dWeight2 );

    }

    FastHSVtoRGB48(H, S, V, &R, &G, &B);
    oPixeli4.s2 = R;
    oPixeli4.s1 = G;
    oPixeli4.s0 = B;

    dstIm[x] = oPixeli4;

}

kernel void	DoMappingHSV_SVM( global const ushort4* srcIm,
                          global ushort4* dstIm,
                          int nWidth,
                          global float* satWeightTbl,
                          global float* valWeightTbl,
                          int hasHue, global int* hueTbl,
                          int hasSat,
                          int hasVal,
                          int hasVib,
                          global hsv_color_table *mappingTbl
                          )
{
    int		x = get_global_id(0);

    if ( x >= nWidth )
        return;

    ushort4 oPixeli4 = srcIm[x];

    int R, G, B;
    int H, S, V;

    R = oPixeli4.s2;
    G = oPixeli4.s1;
    B = oPixeli4.s0;
    FastRGB48toHSV(R, G, B, &H, &S, &V);

    float dWeight1 = 0;
    float dWeight2 = 0;
    HUE_COLOR_DEF color1 = Hue_None;
    HUE_COLOR_DEF color2 = Hue_None;

    if ( S > 0 )
    {
        GetHueWeight( H, &color1, &color2, &dWeight1, &dWeight2 );
        if ( hasVal )
            m_fnAdjustLuminanceProPhotoRGB_SVM( H, &S, &V, satWeightTbl, valWeightTbl,
                                             mappingTbl, Val_Adj, -1/*Val_Min not used*/, Val_Ast, /* valAdjTbl, valMinTbl, valAstTbl, */
                                             color1, color2, dWeight1, dWeight2 );
        if ( hasSat )
            m_fnAdjustSaturationProPhotoRGB_SVM( H, &S, &V,
                                             mappingTbl, Sat_Adj, Sat_Min, Sat_Ast, /* satAdjTbl, satMinTbl, satAstTbl, */
                                             color1, color2, dWeight1, dWeight2 );
        if ( hasHue )
            H = hueTbl[H];
        if ( hasVib )
            m_fnAdjustSaturationProPhotoRGB_SVM( H, &S, &V,
                                             mappingTbl, Vib_Adj, Vib_Min, Vib_Ast, /* vibAdjTbl, vibMinTbl, vibAstTbl, */
                                             color1, color2, dWeight1, dWeight2 );
    }

    FastHSVtoRGB48(H, S, V, &R, &G, &B);
    oPixeli4.s2 = R;
    oPixeli4.s1 = G;
    oPixeli4.s0 = B;

    dstIm[x] = oPixeli4;

}

kernel void	DoMappingBW(global const ushort4* srcIm,
                        global ushort4* dstIm,
                        int nWidth,
                        global int* pnAdjTbl,
                        global int* pnSatWeightTbl,
                        global int* pnSkinSatWeightTbl)
{
    int     x = get_global_id(0);

    if ( x >= nWidth )
        return;

    ushort4 oPixeli4 = srcIm[x];

    int R, G, B;
    int H, S, V;

    R = oPixeli4.s2;
    G = oPixeli4.s1;
    B = oPixeli4.s0;

    int nRatioR = 9438;
    int nRatioG = 23327;
    int nRatioB = 3;

    int nInLuminance = (nRatioR * R + nRatioG * G +  nRatioB * B) >> 15;
    int nOutLuminance = 0;

    FastRGB48toHSV(R, G, B, &H, &S, &V);

    int nWeight1 = 0;
    int nWeight2 = 0;
    HUE_COLOR_DEF color1 = Hue_None;
    HUE_COLOR_DEF color2 = Hue_None;

    if ( S > 0 )
    {
        GetHueWeight_INT( H, &color1, &color2, &nWeight1, &nWeight2 );
        m_fnAdjustBWProPhotoRGB_INT(nInLuminance, H, S, &nOutLuminance,
                                    pnAdjTbl, pnSatWeightTbl, pnSkinSatWeightTbl,
                                    color1, color2, nWeight1, nWeight2);
    }
    else
        nOutLuminance = nInLuminance;

    nOutLuminance = clamp(nOutLuminance, 0, MAX_16BITS_VALUE);

    oPixeli4.s2 = nOutLuminance;
    oPixeli4.s1 = nOutLuminance;
    oPixeli4.s0 = nOutLuminance;

    dstIm[x] = oPixeli4;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
