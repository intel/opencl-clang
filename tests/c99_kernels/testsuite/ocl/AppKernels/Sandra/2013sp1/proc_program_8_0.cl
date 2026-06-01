
#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : enable

#define MAND_MAX_ITER		255
#define MAND_EXIT_VAL		4.0f


inline void MandelAddPixel(__global unsigned char* pMemory, const int iPixel,
							const int iPixelX, const int iPixelY,
							const int iImageW)
{
	const int iIndex = iPixelX + iImageW*iPixelY;
	pMemory[iIndex] = (unsigned char)iPixel;
}


inline float4 dsadd4(const float4 a, const float4 b)
{
	float4 c;
	const float2 a0 = a.xz;
	const float2 a1 = a.yw;
	const float2 b0 = b.xz;
	const float2 b1 = b.yw;

	const float2 t1 = a0 + b0;
	float2 e  = t1 - a0;
	const float2 t2 = ((b0 - e) + (a0 - (t1 - e))) + a1 + b1;

		e = t1 + t2;
	c.xz = e;
	c.yw = t2 - (e - t1);

    return c;
}

inline float2 dsadd(const float2 a, const float2 b)
{
	float2 c;
	const float a0 = a.x;
	const float a1 = a.y;
	const float b0 = b.x;
	const float b1 = b.y;

	const float t1 = a0 + b0;
	float e  = t1 - a0;
	const float t2 = ((b0 - e) + (a0 - (t1 - e))) + a1 + b1;

		e = t1 + t2;
	c.x = e;
	c.y = t2 - (e - t1);

    return c;
}


inline float4 dssub4(const float4 a, const float4 b)
{
	float4 c;
	const float2 a0 = a.xz;
	const float2 a1 = a.yw;
	const float2 b0 = b.xz;
	const float2 b1 = b.yw;

	const float2 t1 = a0 - b0;
	float2 e  = t1 - a0;
	const float2 t2 = ((-b0 - e) + (a0 - (t1 - e))) + a1 - b1;

		e = t1 + t2;
	c.xz = e;
	c.yw = t2 - (e - t1);

    return c;
}

inline float2 dssub(const float2 a, const float2 b)
{
	float2 c;
	const float a0 = a.x;
	const float a1 = a.y;
	const float b0 = b.x;
	const float b1 = b.y;

	const float t1 = a0 - b0;
	float e  = t1 - a0;
	const float t2 = ((-b0 - e) + (a0 - (t1 - e))) + a1 - b1;

		e = t1 + t2;
	c.x = e;
	c.y = t2 - (e - t1);

    return c;
}


inline float4 dsmul4(const float4 a, const float4 b)
{
	float4 c;
	const float2 a0 = a.xz;
	const float2 a1 = a.yw;
	const float2 b0 = b.xz;
	const float2 b1 = b.yw;

		const float2 cfCon = 8193.0f;
	const float2 cona = a0 * cfCon;
	const float2 conb = b0 * cfCon;
	const float2 sa1 = cona - (cona - a0);
	const float2 sb1 = conb - (conb - b0);
	const float2 sa2 = a0 - sa1;
	const float2 sb2 = b0 - sb1;

		const float2 c11 = a0 * b0;
	const float2 c21 = (((sa1 * sb1 - c11) + sa1 * sb2) + sa2 * sb1) + sa2 * sb2;

        const float2 c2 = a0 * b1 + a1 * b0;

        const float2 t1 = c11 + c2;
    float2 e  = t1 - c11;
    const float2 t2 = ((c2 - e) + (c11 - (t1 - e))) + c21 + a1 * b1;

        e = t1 + t2;
	c.xz = e;
	c.yw = t2 - (e - t1);

	return c;
}

inline float2 dsmul(const float2 a, const float2 b)
{
	float2 c;
	const float a0 = a.x;
	const float a1 = a.y;
	const float b0 = b.x;
	const float b1 = b.y;

		const float cfCon = 8193.0f;
	const float cona = a0 * cfCon;
	const float conb = b0 * cfCon;
	const float sa1 = cona - (cona - a0);
	const float sb1 = conb - (conb - b0);
	const float sa2 = a0 - sa1;
	const float sb2 = b0 - sb1;

		const float c11 = a0 * b0;
	const float c21 = (((sa1 * sb1 - c11) + sa1 * sb2) + sa2 * sb1) + sa2 * sb2;

        const float c2 = a0 * b1 + a1 * b0;

        const float t1 = c11 + c2;
    float e  = t1 - c11;
    const float t2 = ((c2 - e) + (c11 - (t1 - e))) + c21 + a1 * b1;

        e = t1 + t2;
	c.x = e;
	c.y = t2 - (e - t1);

	return c;
}


int MandelPixelDblEmul(const float4 fzinit)
{
	float4	fval = fzinit;
	float2	ftmp, fsum;
	int		ccount = 0;

	do {
				ftmp = dsmul((float2)(fval.xy), (float2)(fval.zw));

		fval = dsmul4(fval, fval);

		fsum = dsadd((float2)(fval.xy), (float2)(fval.zw));

		if ( fsum.x > MAND_EXIT_VAL ) break;

		fval.xy = dssub((float2)(fval.xy), (float2)(fval.zw));
		fval.zw = dsadd((float2)(ftmp.xy), (float2)(ftmp.xy));

		fval = dsadd4(fval, fzinit);

		ccount++;

				ftmp = dsmul((float2)(fval.xy), (float2)(fval.zw));

		fval = dsmul4(fval, fval);

		fsum = dsadd((float2)(fval.xy), (float2)(fval.zw));

		if ( fsum.x > MAND_EXIT_VAL ) break;

		fval.xy = dssub((float2)(fval.xy), (float2)(fval.zw));
		fval.zw = dsadd((float2)(ftmp.xy), (float2)(ftmp.xy));

		fval = dsadd4(fval, fzinit);

		ccount++;

				ftmp = dsmul((float2)(fval.xy), (float2)(fval.zw));

		fval = dsmul4(fval, fval);

		fsum = dsadd((float2)(fval.xy), (float2)(fval.zw));

		if ( fsum.x > MAND_EXIT_VAL ) break;

		fval.xy = dssub((float2)(fval.xy), (float2)(fval.zw));
		fval.zw = dsadd((float2)(ftmp.xy), (float2)(ftmp.xy));

		fval = dsadd4(fval, fzinit);

		ccount++;

	} while( ccount < MAND_MAX_ITER );

	return convert_uchar_sat(ccount);
}


__kernel void MandelThread(__global unsigned char* pMemory,
						const int imageW, const int imageH,
						const float fXmin0, const float fXmin1,
						const float fYmin0, const float fYmin1,
						const float fXinc0, const float fXinc1,
						const float fYinc0, const float fYinc1)
{
	const unsigned int iX = get_global_id(0);
	const unsigned int iY = get_global_id(1);

	if ((iX < imageW) && (iY < imageH)) {
		const float4 fzpos = (float4)(iX, 0, iY, 0);
		const float4 fzmin = (float4)(fXmin0, fXmin1, fYmin0, fYmin1);
		const float4 fzinc = (float4)(fXinc0, fXinc1, fYinc0, fYinc1);

		const float4 fzinit = dsadd4(dsmul4(fzpos, fzinc), fzmin);

		const int iCount = MandelPixelDblEmul(fzinit);

		MandelAddPixel(pMemory, iCount, iX, iY, imageW);
	}
}


// buildOptions=-cl-mad-enable -cl-fast-relaxed-math -D _IS_GPU_
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-mad-enable -cl-fast-relaxed-math -D _IS_GPU_" %cfg_path --cl-device=%cl_device 2>&1
