
#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : enable

#if defined(cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
#elif defined(cl_amd_fp64)
#pragma OPENCL EXTENSION cl_amd_fp64 : enable
#else
#error "FP64 not supported!"
#endif

#define MAND_MAX_ITER		255
#define MAND_EXIT_VAL		4.0

#define USE_MAD

#ifdef FP_FAST_FMA
#define fma_d	fma
#else
#define	fma_d	mad
#endif

inline
void MandelAddPixel(__global unsigned char* restrict pMemory, const uchar iPixel,
							const int iPixelX, const int iPixelY, const int iImageW)
{
	const int iIndex = iPixelX + iImageW*iPixelY;
	pMemory[iIndex] = iPixel;
}


inline uchar MandelPixelDouble(const double fzinitX, const double fzinitY)
{
	const int ITER_PER_LOOP = 2*4;

    double	fvalX = fzinitX;
    double	fvalY = fzinitY;

    double	fvalXSav = fzinitX;
    double	fvalYSav = fzinitY;
    double	ftmp;

    int		ccount = 0;
    int		stay;
    int     acount = MAND_MAX_ITER+1;
    do {
#ifdef USE_MAD
                ftmp = fma_d(fvalX, fvalX, fzinitX);
        ftmp = fma_d(-fvalY, fvalY, ftmp);
        fvalY = fma_d(fvalX+fvalX, fvalY, fzinitY);
        fvalX = fma_d(ftmp, ftmp, fzinitX);
        fvalX = fma_d(-fvalY, fvalY, fvalX);
        fvalY = fma_d(ftmp+ftmp, fvalY, fzinitY);

                ftmp = fma_d(fvalX, fvalX, fzinitX);
        ftmp = fma_d(-fvalY, fvalY, ftmp);
        fvalY = fma_d(fvalX+fvalX, fvalY, fzinitY);
        fvalX = fma_d(ftmp, ftmp, fzinitX);
        fvalX = fma_d(-fvalY, fvalY, fvalX);
        fvalY = fma_d(ftmp+ftmp, fvalY, fzinitY);

                ftmp = fma_d(fvalX, fvalX, fzinitX);
        ftmp = fma_d(-fvalY, fvalY, ftmp);
        fvalY = fma_d(fvalX+fvalX, fvalY, fzinitY);
        fvalX = fma_d(ftmp, ftmp, fzinitX);
        fvalX = fma_d(-fvalY, fvalY, fvalX);
        fvalY = fma_d(ftmp+ftmp, fvalY, fzinitY);

                ftmp = fma_d(fvalX, fvalX, fzinitX);
        ftmp = fma_d(-fvalY, fvalY, ftmp);
        fvalY = fma_d(fvalX+fvalX, fvalY, fzinitY);
        fvalX = fma_d(ftmp, ftmp, fzinitX);
        fvalX = fma_d(-fvalY, fvalY, fvalX);
        fvalY = fma_d(ftmp+ftmp, fvalY, fzinitY);
#else
                ftmp  = fvalX * fvalX + fzinitX - fvalY*fvalY ;
        fvalY = 2.0*fvalX*fvalY + fzinitY;
        fvalX = ftmp*ftmp + fzinitX - fvalY*fvalY ;
        fvalY = 2.0*ftmp*fvalY + fzinitY;

                ftmp  = fvalX * fvalX + fzinitX - fvalY*fvalY ;
        fvalY = 2.0*fvalX*fvalY + fzinitY;
        fvalX = ftmp*ftmp + fzinitX - fvalY*fvalY ;
        fvalY = 2.0*ftmp*fvalY + fzinitY;

                ftmp  = fvalX * fvalX + fzinitX - fvalY*fvalY ;
        fvalY = 2.0*fvalX*fvalY + fzinitY;
        fvalX = ftmp*ftmp + fzinitX - fvalY*fvalY ;
        fvalY = 2.0*ftmp*fvalY + fzinitY;

                ftmp  = fvalX * fvalX + fzinitX - fvalY*fvalY ;
        fvalY = 2.0*fvalX*fvalY + fzinitY;
        fvalX = ftmp*ftmp + fzinitX - fvalY*fvalY ;
        fvalY = 2.0*ftmp*fvalY + fzinitY;
#endif

		#ifdef USE_MAD
        stay = (fma_d(fvalY, fvalY, fvalX*fvalX) <= MAND_EXIT_VAL);
#else
		stay = ((fvalX*fvalX + fvalY*fvalY) <= MAND_EXIT_VAL);
#endif
        fvalXSav = (stay) ? fvalX : fvalXSav;
        fvalYSav = (stay) ? fvalY : fvalYSav;

        acount -= ITER_PER_LOOP;
        ccount += stay*ITER_PER_LOOP;  	} while (stay && (acount > 0));


                    if ( !stay ) {
      fvalX = fvalXSav;
      fvalY = fvalYSav;
      acount = ITER_PER_LOOP;
      do {
#ifdef USE_MAD
		stay = (fma_d(fvalY, fvalY, fvalX*fvalX) <= MAND_EXIT_VAL);

        ftmp = fma_d(fvalX, fvalX, fzinitX);
        ftmp = fma_d(-fvalY, fvalY, ftmp);
        fvalY = fma_d(fvalX+fvalX, fvalY, fzinitY);
#else
		stay = ((fvalX*fvalX + fvalY*fvalY) <= MAND_EXIT_VAL);

        ftmp  = fvalX * fvalX + fzinitX - fvalY*fvalY ;
        fvalY = 2.0*fvalX*fvalY + fzinitY;
#endif
        ccount+=stay;
#ifdef USE_MAD
		stay = (fma_d(fvalY, fvalY, ftmp*ftmp) <= MAND_EXIT_VAL);

        fvalX = fma_d(ftmp, ftmp, fzinitX);
        fvalX = fma_d(-fvalY, fvalY, fvalX);
        fvalY = fma_d(ftmp+ftmp, fvalY, fzinitY);
#else
		stay = ((ftmp*ftmp + fvalY*fvalY) <= MAND_EXIT_VAL);

        fvalX = ftmp*ftmp + fzinitX - fvalY*fvalY ;
        fvalY = 2.0*ftmp*fvalY + fzinitY;
#endif
        ccount+=stay;
        acount -= 2;
      } while ( stay && (acount > 0));
    }

    	return convert_uchar_sat(ccount);
}


__attribute__((vec_type_hint(char)))
#ifdef KERNEL_MAX_THREADS
__attribute__((work_group_size_hint(KERNEL_MAX_THREADS, 1, 1)))
#endif
__kernel void MandelThread(__global unsigned char* restrict pMemory,
						const int imageW, const int imageH,
						const double fXmin, const double fYmin,
						const double fXinc, const double fYinc)
{
	const unsigned int iX = get_global_id(0);
	const unsigned int iY = get_global_id(1);

	if ((iX < imageW) && (iY < imageH)) {
		const double2 fzpos = (double2)(iX, iY);
		const double2 fzmin = (double2)(fXmin, fYmin);
		const double2 fzinc = (double2)(fXinc, fYinc);

		const double2 fzinit = fzmin + fzpos*fzinc;

		const uchar iCount = MandelPixelDouble(fzinit.x, fzinit.y);

		MandelAddPixel(pMemory, iCount, iX, iY, imageW);
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
