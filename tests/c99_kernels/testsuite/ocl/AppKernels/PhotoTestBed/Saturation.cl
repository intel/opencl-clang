__constant float LUV_U_MAX = 220.0f;
__constant float LUV_U_MIN = -134.0f;
__constant float LUV_V_MAX = 122.0f;
__constant float LUV_V_MIN = -140.0f;
__constant float ref_U = 0.2091600528f;
__constant float ref_V = 0.4880733845f;

void ConvertToLAB_D50( float3 RGB, float3* LAB, float dMaxValue )
{
    RGB = ( RGB / dMaxValue ) * 100.0f;

    float3 var_XYZ = (float3)(dot(RGB, (float3)(0.7976749, 0.1351917, 0.0313534)) / 96.422,
                              dot(RGB, (float3)(0.2880402, 0.7118741, 0.0000857)) / 100.0,
                              RGB.s2 * 0.8252100 / 82.521);


	// XYZ to LAB
    float3 pow_XYZ = native_powr ( var_XYZ, (float3)( 1.0f/3.0f , 1.0f/3.0f, 1.0f/3.0f));
    //float3 pow_XYZ = cbrt(var_XYZ);
    var_XYZ.s0 = ( var_XYZ.s0 > 0.008856 ) ? pow_XYZ.s0 : var_XYZ.s0 * 7.787f + ( 16.0f / 116.0f );
    var_XYZ.s1 = ( var_XYZ.s1 > 0.008856 ) ? pow_XYZ.s1 : var_XYZ.s1 * 7.787f + ( 16.0f / 116.0f );
    var_XYZ.s2 = ( var_XYZ.s2 > 0.008856 ) ? pow_XYZ.s2 : var_XYZ.s2 * 7.787f + ( 16.0f / 116.0f );

	(*LAB).s0 = ( 116 * var_XYZ.s1 ) - 16;
	(*LAB).s1 = 500 * ( var_XYZ.s0 - var_XYZ.s1 );
	(*LAB).s2 = 200 * ( var_XYZ.s1 - var_XYZ.s2 );

}

void ConvertFromLAB_D50( float3 LAB, float3* RGB, float dMaxValue )
{
	// LAB to XYZ
    float var_Y = ( LAB.s0 + 16 ) / 116;
    float3 var_XYZ = (float3)(LAB.s1 / 500 + var_Y, ( LAB.s0 + 16 ) / 116, var_Y - LAB.s2 / 200);
    //float3 pow_XYZ = native_powr(var_XYZ, (float3)(3.0f, 3.0f, 3.0f));
    float3 pow_XYZ = var_XYZ * var_XYZ * var_XYZ;

	var_XYZ.s0 = (pow_XYZ.s0 > 0.008856) ? pow_XYZ.s0 : ( var_XYZ.s0 - 16.0 / 116.0 ) / 7.787;
    var_XYZ.s1 = (pow_XYZ.s1 > 0.008856) ? pow_XYZ.s1 : ( var_XYZ.s1 - 16.0 / 116.0 ) / 7.787;
    var_XYZ.s2 = (pow_XYZ.s2 > 0.008856) ? pow_XYZ.s2 : ( var_XYZ.s2 - 16.0 / 116.0 ) / 7.787;

	var_XYZ = var_XYZ * (float3)(0.96422f, 1.0f, 0.82521f);
    float3 vRGB;
    vRGB.s0 = dot(var_XYZ, (float3)(1.3459433, -0.2556075, -0.0511118));
    vRGB.s1 = dot(var_XYZ, (float3)(-0.5445989, 1.5081673, 0.0205351));
    vRGB.s2 = var_XYZ.s2 *  1.2118128f;

	*RGB = clamp( vRGB* dMaxValue, (float3)(0, 0, 0), (float3)(dMaxValue, dMaxValue, dMaxValue) );
}

void ConvertToLUV_D50( float3 RGB, float3* LUV, float dMaxValue )
{

    RGB = (RGB / dMaxValue ) * 100.0f;

	// Observer = 2, Illuminant = D50

	float X = dot(RGB, (float3)(0.7976749, 0.1351917, 0.0313534));
	float Y = dot(RGB, (float3)(0.2880402, 0.7118741, 0.0000857));
	float Z = RGB.s2 * 0.8252100;

	float var_U = ( 4 * X ) / ( X + ( 15 * Y ) + ( 3 * Z ) );
	float var_V = ( 9 * Y ) / ( X + ( 15 * Y ) + ( 3 * Z ) );
	float var_Y = Y / 100.0;

    var_Y = ( var_Y > 0.008856 ) ? native_powr( var_Y, ( 1.0f/3.0f ) ) : ( 7.787 * var_Y ) + ( 16.0 / 116.0 );

	// XYZ to LUV reference white: D50
    // ( 4 * 96.422 ) / ( 96.422 + ( 15 * 100.0 ) + ( 3 * 82.521 ) ) = 385.688 / 1843.985 = 0.2091600528
    // ( 9 * 100.0 )  / ( 96.422 + ( 15 * 100.0 ) + ( 3 * 82.521 ) ) = 900 / 1843.985 = 0.4880733845

	(*LUV).s0 = ( 116 * var_Y ) - 16;
	(*LUV).s1 = 13 * (*LUV).s0 * ( var_U - ref_U );
	(*LUV).s2 = 13 * (*LUV).s0 * ( var_V - ref_V );

}

void ConvertFromLUV_D50( float3 LUV, float3* RGB, float dMaxValue )
{
	// LUV to XYZ reference white: D50
	float var_Y = ( LUV.s0 + 16.0 ) / 116.0;
	float dTemp = var_Y * var_Y * var_Y;
    var_Y = ( dTemp > 0.008856 ) ? dTemp : ( var_Y - 16.0 / 116.0 ) / 7.787;

    // ( 4 * 96.422 ) / ( 96.422 + ( 15 * 100.0 ) + ( 3 * 82.521 ) ) = 385.688 / 1843.985 = 0.2091600528
    // ( 9 * 100.0 )  / ( 96.422 + ( 15 * 100.0 ) + ( 3 * 82.521 ) ) = 900 / 1843.985 = 0.4880733845

	float var_U = LUV.s1 / ( 13 * LUV.s0 ) + ref_U;
	float var_V = LUV.s2 / ( 13 * LUV.s0 ) + ref_V;

	float Y = var_Y * 100.0;
	float X =  - ( 9 * Y * var_U ) / ( ( var_U - 4 ) * var_V  - var_U * var_V );
	float Z = ( 9 * Y - ( 15 * var_V * Y ) - ( var_V * X ) ) / ( 3 * var_V );

    float3 XYZ = (float3)(X, Y, Z) / 100.0f;
    float3 vRGB;

	vRGB.s0 = dot(XYZ, (float3)(1.3459433, -0.2556075, -0.0511118));
	vRGB.s1 = dot(XYZ, (float3)(-0.5445989, 1.5081673, 0.0205351));
	vRGB.s2 = XYZ.s2 *  1.2118128;

    *RGB = clamp( vRGB* dMaxValue, (float3)(0, 0, 0), (float3)(dMaxValue, dMaxValue, dMaxValue) );

}

kernel void	ApplySaturationProPhotoRGB_LAB
(
    global const ushort4* srcIm,
    global ushort4*       dstIm,
    global int*           mapTbl,
    int                   iWidth,
    float                 fSaturation,
    float                 fBoundary
)
{
    int		x = get_global_id(0);

    if ( x >= iWidth )
        return;
    ushort4 iSrc4 = srcIm[x];
    float3 dRGB, dLAB, dLCH;
    dRGB = (float3)(iSrc4.s2, iSrc4.s1, iSrc4.s0);
    ConvertToLAB_D50(dRGB, &dLAB, fBoundary);

    dLCH.s0 = dLAB.s0;
    dLCH.s1 = native_sqrt ( dLAB.s1 * dLAB.s1 + dLAB.s2 * dLAB.s2 );
    dLCH.s2 = atan2( dLAB.s2, dLAB.s1 );

    int nIndexS = (int)( (dLCH.s1 / 240.11214 * fBoundary) + 0.5 );
    dLCH.s1 = (float)mapTbl[nIndexS] / fBoundary * 240.11214;

    dLAB.s1 = native_cos( dLCH.s2 ) * dLCH.s1;
    dLAB.s2 = native_sin( dLCH.s2 ) * dLCH.s1;

    ConvertFromLAB_D50( dLAB, &dRGB, fBoundary);
    iSrc4 = (ushort4)(dRGB.s2+0.5, dRGB.s1+0.5, dRGB.s0+0.5, iSrc4.s3);
    dstIm[x] = iSrc4;
}

kernel void	ApplySaturationProPhotoRGB_LUV
(
    global const ushort4* srcIm,
    global ushort4*       dstIm,
    global float*         pfLWeighting,
    int                   iWidth,
    float                 fSaturation,
    float                 fBoundary,
    float                 fSlope
)
{
    int		x = get_global_id(0);

    if ( x >= iWidth )
        return;
    ushort4 iSrc4 = srcIm[x];
    float3 dRGB, dLUV;
    dRGB = (float3)(iSrc4.s2, iSrc4.s1, iSrc4.s0);
    ConvertToLUV_D50( dRGB, &dLUV, fBoundary );
    dLUV.s1 = fSlope * dLUV.s1;
    dLUV.s2 = fSlope * dLUV.s2;
    clamp( dLUV, LUV_V_MIN, LUV_V_MAX );
    ConvertFromLUV_D50( dLUV, &dRGB, fBoundary );

    dRGB = round(dRGB);
    iSrc4 = (ushort4)(dRGB.s2, dRGB.s1, dRGB.s0, iSrc4.s3);
    dstIm[x] = iSrc4;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
