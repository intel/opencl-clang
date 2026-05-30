
//-----------------------------------------------------------------------------
__kernel void matrixLinearRgbToRgb_Planar( __global float4 * pDst,
										   __global float4 const * pSrc,
										   unsigned int nRowVectors, unsigned int nPlaneVectors,
										   float m00, float m01, float m02,
										   float m10, float m11, float m12,
										   float m20, float m21, float m22,
										   const int nNumCurves,
										   __global const ushort * restrict pCurve,
										   const unsigned int destFormat, const float fWhite )
{
	int		x = get_global_id( 0 );
	float4	vRed = pSrc[x];
	float4	vGrn = pSrc[x + nPlaneVectors ];
	float4	vBlu = pSrc[x + 2 * nPlaneVectors ];

	//	clamp to [0..1] - after this step the highlight data will be gone
	vRed = clamp( vRed, (float4)0.f, (float4)1.f );
	vGrn = clamp( vGrn, (float4)0.f, (float4)1.f );
	vBlu = clamp( vBlu, (float4)0.f, (float4)1.f );

	//	RGB to RGB
	float4	vRedOut = m00 * vRed + m01 * vGrn + m02 * vBlu;
	float4	vGrnOut = m10 * vRed + m11 * vGrn + m12 * vBlu;
	float4	vBluOut = m20 * vRed + m21 * vGrn + m22 * vBlu;

	//	clamp again to [0..1]
	vRedOut = clamp( vRedOut, (float4)0.f, (float4)1.f );
	vGrnOut = clamp( vGrnOut, (float4)0.f, (float4)1.f );
	vBluOut = clamp( vBluOut, (float4)0.f, (float4)1.f );

	//	apply the output curve
	if ( nNumCurves > 0 )
	{
		//	convert to 16-bit ints to do curve lookup
		int4	vRedI = convert_int4( vRedOut * 65535.f );
		int4	vGrnI = convert_int4( vGrnOut * 65535.f );
		int4	vBluI = convert_int4( vBluOut * 65535.f );
		float	fInv65535 = 1.f / 65535.f;

		//	perform LUT lookup
		switch ( nNumCurves )
		{
			case 1:
				vRedI.x = pCurve[vRedI.x];
				vRedI.y = pCurve[vRedI.y];
				vRedI.z = pCurve[vRedI.z];
				vRedI.w = pCurve[vRedI.w];

				vGrnI.x = pCurve[vGrnI.x];
				vGrnI.y = pCurve[vGrnI.y];
				vGrnI.z = pCurve[vGrnI.z];
				vGrnI.w = pCurve[vGrnI.w];

				vBluI.x = pCurve[vBluI.x];
				vBluI.y = pCurve[vBluI.y];
				vBluI.z = pCurve[vBluI.z];
				vBluI.w = pCurve[vBluI.w];
				break;

			case 3:
			{
				__global const ushort * restrict pCurveR = pCurve;
				__global const ushort * restrict pCurveG = pCurveR + 65535;
				__global const ushort * restrict pCurveB = pCurveG + 65535;

				vRedI.x = pCurveR[vRedI.x];
				vRedI.y = pCurveR[vRedI.y];
				vRedI.z = pCurveR[vRedI.z];
				vRedI.w = pCurveR[vRedI.w];

				vGrnI.x = pCurveG[vGrnI.x];
				vGrnI.y = pCurveG[vGrnI.y];
				vGrnI.z = pCurveG[vGrnI.z];
				vGrnI.w = pCurveG[vGrnI.w];

				vBluI.x = pCurveB[vBluI.x];
				vBluI.y = pCurveB[vBluI.y];
				vBluI.z = pCurveB[vBluI.z];
				vBluI.w = pCurveB[vBluI.w];
				break;
			}

			default:
				break;
		}

		//	convert back to float
		vRedOut = convert_float4( vRedI ) * fInv65535;
		vGrnOut = convert_float4( vGrnI ) * fInv65535;
		vBluOut = convert_float4( vBluI ) * fInv65535;
	}

	//	ouput to destination
	if (destFormat == 0)
	{
		pDst[x]                     = vRedOut;
		pDst[x + nPlaneVectors]     = vGrnOut;
		pDst[x + 2 * nPlaneVectors] = vBluOut;
	}
	else
	{
		__global ushort4 * pShortDst = (__global ushort4 *)(pDst);

		ushort4	vRedI = convert_ushort4( clamp( convert_int4( vRedOut * fWhite + 0.5f ), (int4)0, (int4)65535 ) );
		ushort4	vGrnI = convert_ushort4( clamp( convert_int4( vGrnOut * fWhite + 0.5f ), (int4)0, (int4)65535 ) );
		ushort4	vBluI = convert_ushort4( clamp( convert_int4( vBluOut * fWhite + 0.5f ), (int4)0, (int4)65535 ) );

		pShortDst[x]                     = vRedI;
		pShortDst[x + nPlaneVectors]     = vGrnI;
		pShortDst[x + 2 * nPlaneVectors] = vBluI;
	}
}

//-----------------------------------------------------------------------------


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
