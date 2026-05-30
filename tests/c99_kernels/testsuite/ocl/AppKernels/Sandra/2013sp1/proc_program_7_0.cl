
#define MAND_MAX_ITER       255
#define MAND_EXIT_VAL       4.0f

#define USE_MAD

#ifdef FP_FAST_FMAF
#define fma_f	fma
#else
#define	fma_f	mad
#endif


inline void MandelAddQuadPixel(__global unsigned char* pMemory, const uchar4 iPixel,
                            const int iPixelX, const int iPixelY,
                            const int iImageW)
{
    const int iIndex = iPixelX + iImageW*iPixelY;

        __global uchar4 *pWord = (__global uchar4 *)(&pMemory[iIndex]);
    *pWord= iPixel;
}


uchar4 MandelQuadPixelFloat(const float4 fzinitX, const float4 fzinitY)
{

    float4  fvalX = fzinitX;
    float4  fvalY = fzinitY;

    float4	fvalXSav = fzinitX;
    float4	fvalYSav = fzinitY;
    float4  ftmp;

    int4    ccount = 0;
    int4    stay;
    int     acount = MAND_MAX_ITER+1;
    do {
#ifdef USE_MAD
                ftmp = fma_f(fvalX, fvalX, fzinitX);
        ftmp = fma_f(-fvalY, fvalY, ftmp);
        fvalY = fma_f(2*fvalX, fvalY, fzinitY);
        fvalX = fma_f(ftmp, ftmp, fzinitX);
        fvalX = fma_f(-fvalY, fvalY, fvalX);
        fvalY = fma_f(2*ftmp, fvalY, fzinitY);

                ftmp = fma_f(fvalX, fvalX, fzinitX);
        ftmp = fma_f(-fvalY, fvalY, ftmp);
        fvalY = fma_f(2*fvalX, fvalY, fzinitY);
        fvalX = fma_f(ftmp, ftmp, fzinitX);
        fvalX = fma_f(-fvalY, fvalY, fvalX);
        fvalY = fma_f(2*ftmp, fvalY, fzinitY);

                ftmp = fma_f(fvalX, fvalX, fzinitX);
        ftmp = fma_f(-fvalY, fvalY, ftmp);
        fvalY = fma_f(2*fvalX, fvalY, fzinitY);
        fvalX = fma_f(ftmp, ftmp, fzinitX);
        fvalX = fma_f(-fvalY, fvalY, fvalX);
        fvalY = fma_f(2*ftmp, fvalY, fzinitY);

                ftmp = fma_f(fvalX, fvalX, fzinitX);
        ftmp = fma_f(-fvalY, fvalY, ftmp);
        fvalY = fma_f(2*fvalX, fvalY, fzinitY);
        fvalX = fma_f(ftmp, ftmp, fzinitX);
        fvalX = fma_f(-fvalY, fvalY, fvalX);
        fvalY = fma_f(2*ftmp, fvalY, fzinitY);

                ftmp = fma_f(fvalX, fvalX, fzinitX);
        ftmp = fma_f(-fvalY, fvalY, ftmp);
        fvalY = fma_f(2*fvalX, fvalY, fzinitY);
        fvalX = fma_f(ftmp, ftmp, fzinitX);
        fvalX = fma_f(-fvalY, fvalY, fvalX);
        fvalY = fma_f(2*ftmp, fvalY, fzinitY);

                ftmp = fma_f(fvalX, fvalX, fzinitX);
        ftmp = fma_f(-fvalY, fvalY, ftmp);
        fvalY = fma_f(2*fvalX, fvalY, fzinitY);
        fvalX = fma_f(ftmp, ftmp, fzinitX);
        fvalX = fma_f(-fvalY, fvalY, fvalX);
        fvalY = fma_f(2*ftmp, fvalY, fzinitY);

                ftmp = fma_f(fvalX, fvalX, fzinitX);
        ftmp = fma_f(-fvalY, fvalY, ftmp);
        fvalY = fma_f(2*fvalX, fvalY, fzinitY);
        fvalX = fma_f(ftmp, ftmp, fzinitX);
        fvalX = fma_f(-fvalY, fvalY, fvalX);
        fvalY = fma_f(2*ftmp, fvalY, fzinitY);

                ftmp = fma_f(fvalX, fvalX, fzinitX);
        ftmp = fma_f(-fvalY, fvalY, ftmp);
        fvalY = fma_f(2*fvalX, fvalY, fzinitY);
        fvalX = fma_f(ftmp, ftmp, fzinitX);
        fvalX = fma_f(-fvalY, fvalY, fvalX);
        fvalY = fma_f(2*ftmp, fvalY, fzinitY);
#else
                ftmp  = fvalX * fvalX + fzinitX - fvalY*fvalY ;
        fvalY = 2*fvalX*fvalY + fzinitY;
        fvalX = ftmp*ftmp + fzinitX - fvalY*fvalY ;
        fvalY = 2*ftmp*fvalY + fzinitY;

                ftmp  = fvalX * fvalX + fzinitX - fvalY*fvalY ;
        fvalY = 2*fvalX*fvalY + fzinitY;
        fvalX = ftmp*ftmp + fzinitX - fvalY*fvalY ;
        fvalY = 2*ftmp*fvalY + fzinitY;

                ftmp  = fvalX * fvalX + fzinitX - fvalY*fvalY ;
        fvalY = 2*fvalX*fvalY + fzinitY;
        fvalX = ftmp*ftmp + fzinitX - fvalY*fvalY ;
        fvalY = 2*ftmp*fvalY + fzinitY;

                ftmp  = fvalX * fvalX + fzinitX - fvalY*fvalY ;
        fvalY = 2*fvalX*fvalY + fzinitY;
        fvalX = ftmp*ftmp + fzinitX - fvalY*fvalY ;
        fvalY = 2*ftmp*fvalY + fzinitY;

                ftmp  = fvalX * fvalX + fzinitX - fvalY*fvalY ;
        fvalY = 2*fvalX*fvalY + fzinitY;
        fvalX = ftmp*ftmp + fzinitX - fvalY*fvalY ;
        fvalY = 2*ftmp*fvalY + fzinitY;

                ftmp  = fvalX * fvalX + fzinitX - fvalY*fvalY ;
        fvalY = 2*fvalX*fvalY + fzinitY;
        fvalX = ftmp*ftmp + fzinitX - fvalY*fvalY ;
        fvalY = 2*ftmp*fvalY + fzinitY;

                ftmp  = fvalX * fvalX + fzinitX - fvalY*fvalY ;
        fvalY = 2*fvalX*fvalY + fzinitY;
        fvalX = ftmp*ftmp + fzinitX - fvalY*fvalY ;
        fvalY = 2*ftmp*fvalY + fzinitY;

                ftmp  = fvalX * fvalX + fzinitX - fvalY*fvalY ;
        fvalY = 2*fvalX*fvalY + fzinitY;
        fvalX = ftmp*ftmp + fzinitX - fvalY*fvalY ;
        fvalY = 2*ftmp*fvalY + fzinitY;
#endif

        stay = ((fvalX*fvalX + fvalY*fvalY) <= MAND_EXIT_VAL);
        fvalXSav = select(fvalXSav, fvalX, stay);
        fvalYSav = select(fvalYSav, fvalY, stay);

        acount -= 16;
        ccount -= stay*16;  	} while ((stay.s0|stay.s1|stay.s2|stay.s3) && (acount));


                    if ( !(stay.s0 & stay.s1 & stay.s2 & stay.s3) ) {
      fvalX = fvalXSav;
      fvalY = fvalYSav;
      acount = 16;
      do {
        stay = ((fvalX*fvalX + fvalY*fvalY) <= MAND_EXIT_VAL);
#ifdef USE_MAD
        ftmp = fma_f(fvalX, fvalX, fzinitX);
        ftmp = fma_f(-fvalY, fvalY, ftmp);
        fvalY = fma_f(2*fvalX, fvalY, fzinitY);
#else
        ftmp  = fvalX * fvalX + fzinitX - fvalY*fvalY ;
        fvalY = 2*fvalX*fvalY + fzinitY;
#endif
        ccount-=stay;
        stay = ((ftmp*ftmp + fvalY*fvalY) <= MAND_EXIT_VAL);
#ifdef USE_MAD
        fvalX = fma_f(ftmp, ftmp, fzinitX);
        fvalX = fma_f(-fvalY, fvalY, fvalX);
        fvalY = fma_f(2*ftmp, fvalY, fzinitY);
#else
        fvalX = ftmp*ftmp + fzinitX - fvalY*fvalY ;
        fvalY = 2*ftmp*fvalY + fzinitY;
#endif
        ccount-=stay;
        acount -= 2;
      } while ((stay.s0|stay.s1|stay.s2|stay.s3) && (acount));
    }

        return convert_uchar4_sat(ccount);
}

#if DO_CHECK

inline int MandelPixelFloat(const float2 fzinit)
{
    float2  fval = fzinit;
    float   ftmp;
    int     ccount = 0;

    do {
        if ( fval.x*fval.x + fval.y*fval.y > MAND_EXIT_VAL ) break;

        ftmp  = fval.x * fval.x + fzinit.x - fval.y*fval.y;
        fval.y = 2*fval.x*fval.y + fzinit.y;

        ccount++;
        fval.x = ftmp;

    } while( ccount < MAND_MAX_ITER );

    return ccount;
}

#endif

__kernel void MandelThread(__global unsigned char* pMemory,
                        const int imageW, const int imageH,
                        const float fXmin, const float fYmin,
                        const float fXinc, const float fYinc)
{
    const unsigned int iX = get_global_id(0) << 2;
    const unsigned int iY = get_global_id(1);

        if ((iX < imageW) && (iY < imageH)) {
        float4 fzinitX = (float4)(iX, iX+1, iX+2, iX+3);
#ifdef USE_MAD
		fzinitX = fma_f(fzinitX, (float4)(fXinc), (float4)(fXmin));
#else
        fzinitX *= fXinc;
        fzinitX += fXmin;
#endif

        #ifdef USE_MAD
        const float4 fzinitY = (float4)fma_f(iY, fYinc, fYmin);
#else
        const float4 fzinitY = (float4)(iY * fYinc + fYmin);
#endif

        const uchar4 iCount4 = MandelQuadPixelFloat(fzinitX, fzinitY);

        MandelAddQuadPixel(pMemory, iCount4, iX, iY, imageW);
    }
}



// buildOptions=-cl-mad-enable -cl-fast-relaxed-math -D _IS_GPU_
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-mad-enable -cl-fast-relaxed-math -D _IS_GPU_" %cfg_path --cl-device=%cl_device 2>&1
