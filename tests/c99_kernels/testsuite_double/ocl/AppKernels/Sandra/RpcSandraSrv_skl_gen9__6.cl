
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


inline
void MandelAddPixel(__global unsigned char* restrict pMemory, const uchar iPixel,
							const int iPixelX, const int iPixelY, const int iImageW)
{
	const int iIndex = iPixelX + iImageW*iPixelY;
	pMemory[iIndex] = iPixel;
}


#define qsemul				double2
#define qsemul2				double4

#define dadd_rn(a, b)		(a+b)
#define dsub_rn(a, b)		(a-b)

#define dmul_rn(a, b)		(a*b)

#ifdef FP_FAST_FMA
#define fma_rn(a, b, c)		fma(a, b, c)
#define fms_rn(a, b, c)		fma(a, b, -c)
#else
#define fma_rn(a, b, c)		mad(a, b, c)
#define fms_rn(a, b, c)		mad(a, b, -c)
#endif

inline qsemul2 qsadd4(const qsemul2 a, const qsemul2 b)
{
	qsemul2 z;
	double2 t1, t2, t3, t4, t5, e;

	t1 = dadd_rn (a.xz, b.xz);
	t2 = dsub_rn (t1, a.xz);
	t3 = dadd_rn (dadd_rn (a.xz, t2 - t1), dsub_rn (b.xz, t2));
	t4 = dadd_rn (a.x, b.yw);
	t2 = dsub_rn (t4, a.yw);
	t5 = dadd_rn (dadd_rn (a.yw, t2 - t4), dsub_rn (b.yw, t2));
	t3 = dadd_rn (t3, t4);
	t4 = dadd_rn (t1, t3);
	t3 = dadd_rn (t1 - t4, t3);
	t3 = dadd_rn (t3, t5);
	z.xz = e = dadd_rn (t4, t3);
	z.yw = dadd_rn (t4 - e, t3);

	return z;
}

inline qsemul qsadd(const qsemul a, const qsemul b)
{
	qsemul z;
	double t1, t2, t3, t4, t5, e;

	t1 = dadd_rn (a.x, b.x);
	t2 = dsub_rn (t1, a.x);
	t3 = dadd_rn (dadd_rn (a.x, t2 - t1), dsub_rn (b.x, t2));
	t4 = dadd_rn (a.y, b.y);
	t2 = dsub_rn (t4, a.y);
	t5 = dadd_rn (dadd_rn (a.y, t2 - t4), dsub_rn (b.y, t2));
	t3 = dadd_rn (t3, t4);
	t4 = dadd_rn (t1, t3);
	t3 = dadd_rn (t1 - t4, t3);
	t3 = dadd_rn (t3, t5);
	z.x = e = dadd_rn (t4, t3);
	z.y = dadd_rn (t4 - e, t3);

	return z;
}


inline qsemul2 qssub4(const qsemul2 a, const qsemul2 b)
{
	qsemul2 z;
	double2 t1, t2, t3, t4, t5, e;

	t1 = dsub_rn (a.xz, b.xz);
	t2 = dsub_rn (t1, a.xz);
	t3 = dsub_rn (dadd_rn (a.xz, t2 - t1), dadd_rn (b.xz, t2));
	t4 = dsub_rn (a.yw, b.yw);
	t2 = dsub_rn (t4, a.yw);
	t5 = dsub_rn (dadd_rn (a.yw, t2 - t4), dadd_rn (b.yw, t2));
	t3 = dadd_rn (t3, t4);
	t4 = dadd_rn (t1, t3);
	t3 = dadd_rn (t1 - t4, t3);
	t3 = dadd_rn (t3, t5);
	z.xz = e = dadd_rn (t4, t3);
	z.yw = dadd_rn (t4 - e, t3);

	return z;
}

inline qsemul qssub(const qsemul a, const qsemul b)
{
	qsemul z;
	double t1, t2, t3, t4, t5, e;

	t1 = dsub_rn (a.x, b.x);
	t2 = dsub_rn (t1, a.x);
	t3 = dsub_rn (dadd_rn (a.x, t2 - t1), dadd_rn (b.x, t2));
	t4 = dsub_rn (a.y, b.y);
	t2 = dsub_rn (t4, a.y);
	t5 = dsub_rn (dadd_rn (a.y, t2 - t4), dadd_rn (b.y, t2));
	t3 = dadd_rn (t3, t4);
	t4 = dadd_rn (t1, t3);
	t3 = dadd_rn (t1 - t4, t3);
	t3 = dadd_rn (t3, t5);
	z.x = e = dadd_rn (t4, t3);
	z.y = dadd_rn (t4 - e, t3);

	return z;
}


inline qsemul2 qsmul4(const qsemul2 a, const qsemul2 b)
{
	qsemul2 t, z;
	double2 e;

	t.xz = dmul_rn (a.xz, b.xz);
	t.yw = fma_rn (a.xz, b.xz, -t.xz);
	t.yw = fma_rn (a.yw, b.yw, t.yw);
	t.yw = fma_rn (a.xz, b.yw, t.yw);
	t.yw = fma_rn (a.yw, b.xz, t.yw);
	z.xz = e = dadd_rn (t.xz, t.yw);
	z.yw = dadd_rn (t.xz - e, t.yw);

	return z;
}

inline qsemul qsmul(const qsemul a, const qsemul b)
{
	qsemul t, z;
	double e;

	t.x = dmul_rn (a.x, b.x);
	t.y = fma_rn (a.x, b.x, -t.x);
	t.y = fma_rn (a.y, b.y, t.y);
	t.y = fma_rn (a.x, b.y, t.y);
	t.y = fma_rn (a.y, b.x, t.y);
	z.x = e = dadd_rn (t.x, t.y);
	z.y = dadd_rn (t.x - e, t.y);

	return z;
}


#define qsfma(a, b, c)		qsadd(qsmul(a, b), c)
#define qsfma4(a, b, c)		qsadd4(qsmul4(a, b), c)

#define qsfms(a, b, c)		qssub(c, qsmul(a, b))
#define qsfms4(a, b, c)		qssub4(c, qsmul4(a, b))


inline uchar MandelPixelQuadEmul(const qsemul2 fzinit)
{
	qsemul2	fval = fzinit;
	qsemul	ftmp, fsum;
	int		ccount = 0;

	do {
				ftmp = qsmul((qsemul)(fval.xy), (qsemul)(fval.zw));
		fval = qsmul4(fval, fval);
		fsum = qsadd((qsemul)(fval.xy), (qsemul)(fval.zw));

		if ( fsum.x > MAND_EXIT_VAL ) break;

		fval.xy = qssub((qsemul)(fval.xy), (qsemul)(fval.zw));
		fval.zw = qsadd(ftmp, ftmp);

		fval = qsadd4(fval, fzinit);

		ccount++;

				ftmp = qsmul((qsemul)(fval.xy), (qsemul)(fval.zw));
		fval = qsmul4(fval, fval);
		fsum = qsadd((qsemul)(fval.xy), (qsemul)(fval.zw));

		if ( fsum.x > MAND_EXIT_VAL ) break;

		fval.xy = qssub((qsemul)(fval.xy), (qsemul)(fval.zw));
		fval.zw = qsadd(ftmp, ftmp);

		fval = qsadd4(fval, fzinit);

		ccount++;
	} while( ccount < MAND_MAX_ITER );

	return convert_uchar_sat(ccount);
}


__attribute__((vec_type_hint(char)))
#ifdef KERNEL_MAX_THREADS
__attribute__((work_group_size_hint(KERNEL_MAX_THREADS, 1, 1)))
#endif
__kernel void MandelThread(__global unsigned char* restrict pMemory,
						const int imageW, const int imageH,
						const double fXmin0, const double fXmin1,
						const double fYmin0, const double fYmin1,
						const double fXinc0, const double fXinc1,
						const double fYinc0, const double fYinc1)
{
	const unsigned int iX = get_global_id(0);
	const unsigned int iY = get_global_id(1);

	if ((iX < imageW) && (iY < imageH)) {
		const qsemul2 fzpos = (qsemul2)(iX, 0.0, iY, 0.0);
		const qsemul2 fzmin = (qsemul2)(fXmin0, fXmin1, fYmin0, fYmin1);
		const qsemul2 fzinc = (qsemul2)(fXinc0, fXinc1, fYinc0, fYinc1);

		const double4 fzinit = qsfma4(fzpos, fzinc, fzmin);

		const uchar iCount = MandelPixelQuadEmul(fzinit);

		MandelAddPixel(pMemory, iCount, iX, iY, imageW);
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
