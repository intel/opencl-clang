//OpenCL source code
#define MAND_MAX_ITER		255
#define MAND_EXIT_VAL		4.0f


inline void MandelAddQuadPixel(__global unsigned char* pMemory, const uchar4 iPixel,
                            const int iPixelX, const int iPixelY,
                            const int iImageW)
{
    const int iIndex = iPixelX + iImageW*iPixelY;

        __global uchar4 *pWord = (__global uchar4 *)(&pMemory[iIndex]);
    *pWord= iPixel;
}


inline float4 dsadd4(const float4 a, const float4 b)
{
	float4 c;
	const float2 a0 = a.xz;
	const float2 a1 = a.yw;
	const float2 b0 = b.xz;
	const float2 b1 = b.yw;

	float2 t1 = a0 + b0;
	float2 e  = t1 - a0;
	float2 t2 = ((b0 - e) + (a0 - (t1 - e))) + a1 + b1;

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

	float t1 = a0 + b0;
	float e  = t1 - a0;
	float t2 = ((b0 - e) + (a0 - (t1 - e))) + a1 + b1;

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

	float2 t1 = a0 - b0;
	float2 e  = t1 - a0;
	float2 t2 = ((-b0 - e) + (a0 - (t1 - e))) + a1 - b1;

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

	float t1 = a0 - b0;
	float e  = t1 - a0;
	float t2 = ((-b0 - e) + (a0 - (t1 - e))) + a1 - b1;

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
	float2 cona = a0 * cfCon;
	float2 conb = b0 * cfCon;
	float2 sa1 = cona - (cona - a0);
	float2 sb1 = conb - (conb - b0);
	float2 sa2 = a0 - sa1;
	float2 sb2 = b0 - sb1;

		float2 c11 = a0 * b0;
	float2 c21 = (((sa1 * sb1 - c11) + sa1 * sb2) + sa2 * sb1) + sa2 * sb2;

        float2 c2 = a0 * b1 + a1 * b0;

        float2 t1 = c11 + c2;
    float2 e  = t1 - c11;
    float2 t2 = ((c2 - e) + (c11 - (t1 - e))) + c21 + a1 * b1;

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
	float cona = a0 * cfCon;
	float conb = b0 * cfCon;
	float sa1 = cona - (cona - a0);
	float sb1 = conb - (conb - b0);
	float sa2 = a0 - sa1;
	float sb2 = b0 - sb1;

		float c11 = a0 * b0;
	float c21 = (((sa1 * sb1 - c11) + sa1 * sb2) + sa2 * sb1) + sa2 * sb2;

        float c2 = a0 * b1 + a1 * b0;

        float t1 = c11 + c2;
    float e  = t1 - c11;
    float t2 = ((c2 - e) + (c11 - (t1 - e))) + c21 + a1 * b1;

        e = t1 + t2;
	c.x = e;
	c.y = t2 - (e - t1);

	return c;
}


int MandelPixelDblEmul(const float4 fzinit)
{
	const float2 fzinitX = fzinit.xy;
	const float2 fzinitY = fzinit.zw;

    float2	fvalX = fzinitX;
    float2	fvalY = fzinitY;

    float2	fvalXSav = fzinitX;
    float2	fvalYSav = fzinitY;
    float2	ftmp, ftmp0;

    int		ccount = 0;
    int		stay;
    int     acount = MAND_MAX_ITER+1;
    do {
                ftmp  = dssub(dsadd(dsmul(fvalX, fvalX), fzinitX), dsmul(fvalY, fvalY));
        ftmp0 = dsmul(fvalX, fvalY);
        fvalY = dsadd(dsadd(ftmp0, ftmp0), fzinitY);

        fvalX = dssub(dsadd(dsmul(ftmp, ftmp), fzinitX), dsmul(fvalY, fvalY));
        ftmp0 = dsmul(ftmp, fvalY);
        fvalY = dsadd(dsadd(ftmp0, ftmp0), fzinitY);

                ftmp  = dssub(dsadd(dsmul(fvalX, fvalX), fzinitX), dsmul(fvalY, fvalY));
        ftmp0 = dsmul(fvalX, fvalY);
        fvalY = dsadd(dsadd(ftmp0, ftmp0), fzinitY);

        fvalX = dssub(dsadd(dsmul(ftmp, ftmp), fzinitX), dsmul(fvalY, fvalY));
        ftmp0 = dsmul(ftmp, fvalY);
        fvalY = dsadd(dsadd(ftmp0, ftmp0), fzinitY);

                ftmp  = dssub(dsadd(dsmul(fvalX, fvalX), fzinitX), dsmul(fvalY, fvalY));
        ftmp0 = dsmul(fvalX, fvalY);
        fvalY = dsadd(dsadd(ftmp0, ftmp0), fzinitY);

        fvalX = dssub(dsadd(dsmul(ftmp, ftmp), fzinitX), dsmul(fvalY, fvalY));
        ftmp0 = dsmul(ftmp, fvalY);
        fvalY = dsadd(dsadd(ftmp0, ftmp0), fzinitY);

                ftmp  = dssub(dsadd(dsmul(fvalX, fvalX), fzinitX), dsmul(fvalY, fvalY));
        ftmp0 = dsmul(fvalX, fvalY);
        fvalY = dsadd(dsadd(ftmp0, ftmp0), fzinitY);

        fvalX = dssub(dsadd(dsmul(ftmp, ftmp), fzinitX), dsmul(fvalY, fvalY));
        ftmp0 = dsmul(ftmp, fvalY);
        fvalY = dsadd(dsadd(ftmp0, ftmp0), fzinitY);

                ftmp = dsadd(dsmul(fvalX, fvalX), dsmul(fvalY, fvalY));
        stay = (ftmp.x <= MAND_EXIT_VAL) ? 1 : 0;
        fvalXSav = (0!=stay) ? fvalX : fvalXSav;
        fvalYSav = (0!=stay) ? fvalY : fvalYSav;

        acount -= 8;
        ccount += stay*8;  	} while (stay && (acount > 0));


                    if ( !stay ) {
      fvalX = fvalXSav;
      fvalY = fvalYSav;
      acount = 8;
      do {
		ftmp0 = dsadd(dsmul(fvalX, fvalX), dsmul(fvalY, fvalY));
        stay = (ftmp0.x <= MAND_EXIT_VAL) ? 1 : 0;

        ftmp  = dssub(dsadd(dsmul(fvalX, fvalX), fzinitX), dsmul(fvalY, fvalY));
        ftmp0 = dsmul(fvalX, fvalY);
        fvalY = dsadd(dsadd(ftmp0, ftmp0), fzinitY);

        ccount+=stay;
        ftmp0 = dsadd(dsmul(ftmp, ftmp), dsmul(fvalY, fvalY));

        fvalX = dssub(dsadd(dsmul(ftmp, ftmp), fzinitX), dsmul(fvalY, fvalY));
        ftmp0 = dsmul(ftmp, fvalY);
        fvalY = dsadd(dsadd(ftmp0, ftmp0), fzinitY);

        ccount+=stay;
        acount -= 2;
      } while ( stay && (acount > 0));
    }

	return convert_uchar_sat(ccount);
}

#if DO_CHECK

inline int GoldMandelPixelDblEmul(const float4 fzinit)
{
	float4	fval = fzinit;
	float4	ftmp, fsum;
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
	} while( ccount < MAND_MAX_ITER );

	return ccount;
}

#endif

__kernel void MandelThread(__global unsigned char* pMemory,
						const int imageW, const int imageH,
						const float fXmin0, const float fXmin1,
						const float fYmin0, const float fYmin1,
						const float fXinc0, const float fXinc1,
						const float fYinc0, const float fYinc1)
{
	const unsigned int iX = 4*get_global_id(0);
	const unsigned int iY = get_global_id(1);

	if ((iX < imageW) && (iY < imageH)) {
        uchar4 iCount;

		float4 fzmin = (float4)(fXmin0, fXmin1, fYmin0, fYmin1);
		float4 fzinc = (float4)(fXinc0, fXinc1, fYinc0, fYinc1);

		float4 fzpos0 = (float4)(iX, 0, iY, 0);
		float4 fzinit0 = dsadd4(dsmul4(fzpos0, fzinc), fzmin);
		iCount.s0 = MandelPixelDblEmul(fzinit0);

		float4 fzpos1 = (float4)(iX+1, 0, iY, 0);
		float4 fzinit1 = dsadd4(dsmul4(fzpos1, fzinc), fzmin);
		iCount.s1 = MandelPixelDblEmul(fzinit1);

		float4 fzpos2 = (float4)(iX+2, 0, iY, 0);
		float4 fzinit2 = dsadd4(dsmul4(fzpos2, fzinc), fzmin);
		iCount.s2 = MandelPixelDblEmul(fzinit2);

		float4 fzpos3 = (float4)(iX+3, 0, iY, 0);
		float4 fzinit3 = dsadd4(dsmul4(fzpos3, fzinc), fzmin);
		iCount.s3 = MandelPixelDblEmul(fzinit3);

#if DO_CHECK
        uchar4 iCountGold;

		float4 gfzpos0 = (float4)(iX, 0, iY, 0);
		float4 gfzinit0 = dsadd4(dsmul4(gfzpos0, fzinc), fzmin);
		iCountGold.s0 = GoldMandelPixelDblEmul(gfzinit0);

		float4 gfzpos1 = (float4)(iX+1, 0, iY, 0);
		float4 gfzinit1 = dsadd4(dsmul4(gfzpos1, fzinc), fzmin);
		iCountGold.s1 = GoldMandelPixelDblEmul(gfzinit1);

		float4 gfzpos2 = (float4)(iX+2, 0, iY, 0);
		float4 gfzinit2 = dsadd4(dsmul4(gfzpos1, fzinc), fzmin);
		iCountGold.s2 = GoldMandelPixelDblEmul(gfzinit3);

		float4 gfzpos3 = (float4)(iX+3, 0, iY, 0);
		float4 gfzinit3 = dsadd4(dsmul4(gfzpos1, fzinc), fzmin);
		iCountGold.s3 = GoldMandelPixelDblEmul(gfzinit4);

        if ((iCountGold.s0 != iCount.s0) || (iCountGold.s1 != iCount.s1) ||
            (iCountGold.s2 != iCount.s2) || (iCountGold.s3 != iCount.s3)) {
            printf ("Mismatch: on ix=%d, iY=%d;  ", iX, iY);
            printf ("gold:%x %x %x %x != quad:%x %x %x %x\n",
                    iCountGold.s0, iCountGold.s1, iCountGold.s2, iCountGold.s3,
                    iCount.s0, iCount.s1, iCount.s2, iCount.s3);
        }
#endif

        MandelAddQuadPixel(pMemory, iCount, iX, iY, imageW);
	}
}

 __kernel void ocl_test_kernel(__global int *ocl_test_results)
 {
   ocl_test_results[3] = 0;
   ocl_test_results[0] = 2; //kernel finished
 }


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
