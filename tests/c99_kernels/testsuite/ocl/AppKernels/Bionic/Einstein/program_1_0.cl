#define ERP_SINCOS_LUT_RES    64
#define ERP_TWO_PI            6.283185f
float deviceSinLUTLookup(__constant float *, __constant float *, __private float);
float deviceSinLUTLookup(__constant float *constSinSamples,
                         __constant float *constCosSamples,
                         __private  float  x)
{
    float xt;
    int i0;
    float d, d2;
    float ts, tc;
    /* normalize value */
    xt = modf(x / ERP_TWO_PI, &x); /* xt in (-1, 1) */
    if ( xt < 0.0f ) {
        xt += 1.0f;                /* xt in [0, 1 ) */
    }
    /* determine LUT index */
    i0 = (int) (xt * ERP_SINCOS_LUT_RES + 0.5f);
    d = d2 = ERP_TWO_PI * (xt - 1.0f / ERP_SINCOS_LUT_RES * i0);
    d2 *= 0.5f * d;
    /* fetch sin/cos samples from constant memory */
    ts = constSinSamples[i0];
    tc = constCosSamples[i0];
    /* use taylor-expansion for sin around samples */
    return ts + d * tc - d2 * ts;
}
__kernel void kernelTimeSeriesModulation(__constant float *constSinSamples,
                                         __constant float *constCosSamples,
                                         __private  float  tau,
                                         __private  float  Omega,
                                         __private  float  Psi0,
                                         __private  float  dt,
                                         __private  float  step_inv,
                                         __private  float  S0,
                                         __global   float *del_t)
{
    size_t i = get_global_id(0);
    /* compute time offset */
    float t = i * dt;
    float x = Omega * t + Psi0;
    float sinX = deviceSinLUTLookup(constSinSamples, constCosSamples, x);
    /* compute time offsets */
    del_t[i] = tau * sinX * step_inv - S0;
}
__kernel void kernelTimeSeriesLengthModulated(__private unsigned int  nsamples_unpadded,
                                              __global  float        *del_t,
                                              __global  unsigned int *timeSeriesLength)
{
    /* number of timesteps that fit into the duration = at most the amount we had before */
    size_t n_steps = nsamples_unpadded - 1;
    /* TODO: avoid global memory reads!!! */
    /* nearest_idx (see time_series_resampling kernel) must not exceed n_unpadded - 1, so go back as far as needed to ensure that */
    while(n_steps - del_t[n_steps] >= nsamples_unpadded - 1) {
        n_steps--;
    }
    /* copy length into global variable */
    *timeSeriesLength = n_steps;
}
__kernel void kernelTimeSeriesResampling(__global  float        *input,
                                         __global  float        *del_t,
                                         __private unsigned int  length,
                                         __global  float        *output)
{
    size_t i = get_global_id(0);
    /* TODO: ensure coalesced memory access (load/store) !!! */
    /* only resample 'existing' time samples */
    if(i < length) {
        /* sample i arrives at the detector at i - del_t[i], choose nearest neighbor */
        int nearest_idx = (int)(i - del_t[i] + 0.5f);
        /* set i-th bin in resampled time series (at the pulsar) to nearest_idx bin from de-dispersed time series */
        output[i] = input[nearest_idx];
    }
    else {
        /* set remaining buffercells to zero (for upcoming sum reduction) */
        output[i] = 0.0f;
    }
}
__kernel void kernelTimeSeriesMeanReduction(__global float *input,
                                            __global float *output,
                                            __private unsigned int input_offset,
                                            __private unsigned int output_offset)
{
    __local float sharedPartialSum[OCL_RESAMP_REDUCTION_WGSIZE_X];
    size_t i = get_global_id(0);
    size_t workItemIdx_x = get_local_id(0);
    /* coalesced load of time series data into shared memory */
    sharedPartialSum[workItemIdx_x] = input[i+input_offset];
    /* wait for load to finish */
    barrier(CLK_LOCAL_MEM_FENCE);
    /* compute sum of current workgroup (in log2(workgroup size) iterations) */
    for(size_t stride = get_local_size(0) >> 1; stride > 0; stride >>= 1) {
        /* sum two strided values per thread */
        if(workItemIdx_x < stride) {
            sharedPartialSum[workItemIdx_x] += sharedPartialSum[workItemIdx_x + stride];
        }
        /* wait for (partial) block summing iteration to finish */
        barrier(CLK_LOCAL_MEM_FENCE);
    }
    /* store sum of current workgroup in global memory (single thread) */
    if(workItemIdx_x == 0) {
        output[get_group_id(0)+output_offset] = sharedPartialSum[0];
    }
}
__kernel void kernelTimeSeriesPadding(__private float         mean,
                                      __private unsigned int  offset,
                                      __global  float        *input,
                                      __global  float        *output)
{
    size_t i= get_global_id(0);
    /* can't be avoided as time series varies in length (incl. non-multiple-of-32 values) */
    if(i >= offset) {
        /* coalesced store of resampled time series padding data to global memory */
        output[i] = mean;
    } else {
        output[i]=input[i];
    }
}
__kernel void kernelTimeSeriesPaddingTranspose(__private float         mean,
                                      __private unsigned int  padding_offset,
                                      __private unsigned int  radix,
                                      __private unsigned int  subFFTlen,
                                      __global  float         *input ,
                                      __global  float         *output)
{
    size_t id1 = get_global_id(0);
    size_t i,k,folded_i;
    float v;
    for(i=radix*2*id1, folded_i=2*id1,k=0; k < radix ; i+=2, k++, folded_i+=subFFTlen) {
    //real part
      v= (i >= padding_offset) ? mean : input[i];
      output[folded_i] = v;
    // imag part
      v= (i+1 >= padding_offset) ? mean : input[i+1];
      output[folded_i+1] = v;
    }
}
#define complexMul(a,b) ((float2)(-((a).y)*(b).y + (a).x * (b).x, (a).y* (b).x + (a).x * (b).y))

#define untangle(res,Ha,Hb,tf) \
   { float2 _t1= (float2) (0.5f * ((Ha).x + (Hb).x) ,0.5f*((Ha).y - (Hb).y));     \
     float2 _t2= (float2) (0.5f * ((Ha).y + (Hb).y), 0.5f*(-(Ha).x + (Hb).x ));   \
     (res) = _t1 + complexMul(_t2,(tf)); \
   }
#define untangle2(res,Ha,Hb,tf) \
   { float2 _t1= (float2) (1.0f + tf.y , -tf.x);     \
     float2 _t2= (float2) (1.0f - tf.y, tf.x);   \
     float2 _Hbconj = (float2) (Hb.x,-Hb.y);     \
     (res) = 0.5f * (complexMul(_t1,Ha) + complexMul(_t2,_Hbconj)); \
   }
__kernel void kernelPowerSpectrum(__global  float2 *       fft_complex_data,
                                  __global  float *        twiddle_data,
                                  __private float          norm_factor,
                                  __private unsigned int   complexFFTlength,
                                  __global  float  *       ps_data)
{
    __local float2 localFFTData[OCL_PS_WGSIZE_X];
    __local float2 localFFTDataM[OCL_PS_WGSIZE_X];
    __local float2 localFFTTwiddleData[OCL_PS_WGSIZE_X];
    __local float2 localFFTTwiddleDataM[OCL_PS_WGSIZE_X];
    float2 res,resM;
    size_t globalId = get_global_id(0);
    size_t localId = get_local_id(0);
    size_t reverseIdx = (globalId==0) ? 0 : complexFFTlength - globalId;
    int ignore = (globalId +globalId > complexFFTlength);
    /* coalesced load of FFT data into local memory */
    localFFTData[localId] = fft_complex_data[globalId];
    localFFTDataM[localId] = fft_complex_data[reverseIdx];
    localFFTTwiddleData[localId].x  = twiddle_data[globalId];
    localFFTTwiddleData[localId].y  = twiddle_data[globalId+complexFFTlength];
    localFFTTwiddleDataM[localId].x = twiddle_data[reverseIdx];
    localFFTTwiddleDataM[localId].y = twiddle_data[reverseIdx+complexFFTlength];
    /* wait for load to finish */
    barrier(CLK_LOCAL_MEM_FENCE);
    untangle(res,localFFTData[localId],localFFTDataM[localId],localFFTTwiddleData[localId]);
    untangle(resM,localFFTDataM[localId],localFFTData[localId],localFFTTwiddleDataM[localId]);
    /* computer power spectrum */
    if(0 == globalId ) {
       ps_data[0] = 0.0f;
       untangle(res,localFFTData[localId],localFFTData[localId],(float2) (-1.0f,0.0f));
       ps_data[complexFFTlength]= norm_factor * (res.x * res.x + res.y * res.y);
    }
    else {
       if (!ignore) ps_data[globalId] = norm_factor * (res.x * res.x + res.y * res.y);
       if (!ignore) ps_data[reverseIdx] = norm_factor * (resM.x * resM.x + resM.y * resM.y);
    }
}
#define complexMul(a,b) ((float2)(-((a).y)*(b).y + (a).x * (b).x, (a).y* (b).x + (a).x * (b).y))

#define untangle(res,Ha,Hb,tf) \
   { float2 _t1= (float2) (0.5f * ((Ha).x + (Hb).x) ,0.5f*((Ha).y - (Hb).y));     \
     float2 _t2= (float2) (0.5f * ((Ha).y + (Hb).y), 0.5f*(-(Ha).x + (Hb).x ));   \
     (res) = _t1 + complexMul(_t2,(tf)); \
   }
#define untangle2(res,Ha,Hb,tf) \
   { float2 _t1= (float2) (1.0f + tf.y , -tf.x);     \
     float2 _t2= (float2) (1.0f - tf.y, tf.x);   \
     float2 _Hbconj = (float2) (Hb.x,-Hb.y);     \
     (res) = 0.5f * (complexMul(_t1,Ha) + complexMul(_t2,_Hbconj)); \
   }
__kernel void kernelPowerSpectrum_radix3_r2c(__global  float2        *fft_data,
                                         __global  float        *fft_twiddle_data,
                                         __global  float        *fft_twiddle_data_rc,
                                         __private int           subFFTlength,
                                         __private unsigned int  ps_length,
                                         __private float         twiddle_factor,
                                         __private float         norm_factor,
                                         __global  float        *ps_data)
{
    __local float2 localFFTData_mod0[OCL_PS_R3_R2C_WGSIZE_X];
    __local float2 localFFTData_mod1[OCL_PS_R3_R2C_WGSIZE_X];
    __local float2 localFFTData_mod2[OCL_PS_R3_R2C_WGSIZE_X];
    __local float2 localTwiddle_mod0[OCL_PS_R3_R2C_WGSIZE_X];
    __local float2 localTwiddle_mod1[OCL_PS_R3_R2C_WGSIZE_X];
    __local float2 localTwiddle_mod2[OCL_PS_R3_R2C_WGSIZE_X];
    __local float2 localFFTData_modM0[OCL_PS_R3_R2C_WGSIZE_X];
    __local float2 localFFTData_modM1[OCL_PS_R3_R2C_WGSIZE_X];
    __local float2 localFFTData_modM2[OCL_PS_R3_R2C_WGSIZE_X];
    __local float2 localTwiddle_modM0[OCL_PS_R3_R2C_WGSIZE_X];
    __local float2 localTwiddle_modM1[OCL_PS_R3_R2C_WGSIZE_X];
    __local float2 localTwiddle_modM2[OCL_PS_R3_R2C_WGSIZE_X];
    //float  ac1,ac2,bd1,bd2;
    //float2 prod_1,prod_2;
    float2 r0_1;
    float2 r1_1;
    float2 r2_1;
    float2 r0_2;
    float2 r1_2;
    float2 r2_2;
    float t1_1,t2_1,m_1;
    float t1_2,t2_2,m_2;
    size_t globalId = get_global_id(0);
    size_t localId = get_local_id(0);
    size_t    fullFFTlength= subFFTlength+subFFTlength+subFFTlength;
    size_t mask =  subFFTlength -1;
    size_t index_reverse = (subFFTlength-globalId) & mask;
        int ignore=(globalId > (size_t) subFFTlength /2) ;
    /* coalesced load of FFT data into local memory */
    localFFTData_mod0[localId] = fft_data[globalId];
    localFFTData_mod1[localId] = fft_data[globalId+subFFTlength];
    localFFTData_mod2[localId] = fft_data[globalId+subFFTlength+subFFTlength];
    /* coalesced load of FFT data into local memory */
    localFFTData_modM0[localId] = fft_data[index_reverse];
    localFFTData_modM1[localId] = fft_data[index_reverse+subFFTlength];
    localFFTData_modM2[localId] = fft_data[index_reverse+subFFTlength+subFFTlength];
 //   localTwiddle_mod0[localId].x = fft_twiddle_data[globalId];
 //   localTwiddle_mod0[localId].y = fft_twiddle_data[globalId+fullFFTlength];
    localTwiddle_mod1[localId].x = fft_twiddle_data[globalId+subFFTlength];
    localTwiddle_mod1[localId].y = fft_twiddle_data[globalId+subFFTlength+fullFFTlength];
    localTwiddle_mod2[localId].x = fft_twiddle_data[globalId+subFFTlength+subFFTlength];
    localTwiddle_mod2[localId].y = fft_twiddle_data[globalId+subFFTlength+subFFTlength+fullFFTlength];
 //   localTwiddle_modM0[localId].x = fft_twiddle_data[index_reverse];
 //   localTwiddle_modM0[localId].y = fft_twiddle_data[index_reverse+fullFFTlength];
    localTwiddle_modM1[localId].x = fft_twiddle_data[index_reverse+subFFTlength];
    localTwiddle_modM1[localId].y = fft_twiddle_data[index_reverse+subFFTlength+fullFFTlength];
    localTwiddle_modM2[localId].x = fft_twiddle_data[index_reverse+subFFTlength+subFFTlength];
    localTwiddle_modM2[localId].y = fft_twiddle_data[index_reverse+subFFTlength+subFFTlength+fullFFTlength];
    /* wait for load to finish */
    barrier(CLK_LOCAL_MEM_FENCE);
    // complex multiply of twiddle factor
    //TODO: vectorize
 // NOTHING to do for first localFFTData_mod0 and localFFTData_modM0 since twiddle factor
  // is always 1.0 + 0i for them
    localFFTData_mod1[localId] = complexMul(localFFTData_mod1[localId],localTwiddle_mod1[localId])  ;
    localFFTData_modM1[localId] =  complexMul(localFFTData_modM1[localId],localTwiddle_modM1[localId]);
    localFFTData_mod2[localId] = complexMul(localFFTData_mod2[localId],localTwiddle_mod2[localId])  ;
    localFFTData_modM2[localId] = complexMul(localFFTData_modM2[localId],localTwiddle_modM2[localId]);


    // butterfly step
    // Now compute (r0,r1,r2) = FFT(x0,x1,x2):
    // r_n = sum_k=0..2 (w^[n*k] x_k)   ,
    // where w:=e^(-2pi*i/3) = cos(2pi/3) - i*sin(2pi/3) = -1/2 - i*sqrt(3)/2
    // which can be simplified to
    // (in MATLAB/octave notation)
    // a0 = real(x0); a1 = real(x1); a2 = real(x2);
    // b0 = imag(x0); b1 = imag(x1); b2 = imag(x2);
    // tf=sqrt(3)/2;
    //
    // m1=(a1+a2)*0.5;
    // m2=(b1-b2)*tf;
    // m3=(b1+b2)*0.5;
    // m4=(a1-a2)*tf;
    //
    // res0= (a0+a1+a2) + i*(b0 + b1 + b2 );
    // res1= a0-m1 +m2  + i*(b0-m3 -m4);
    // res2= a0-m1 -m2  + i*(b0-m3 +m4);
    // However, we made sure through choice of the twiddle factors
    // that x1 and x2 are already scaled by 0.5 before this step, so we can avoid
    // the trivial multiplications by 0.5 here.
    // With butterfly_twiddle_factor = sqrt(3),
    // x0 = localFFTData_mod0, x1 = localFFTData_mod1, x2 = localFFTData_mod2,we get:
    //

    m_1= twiddle_factor * (localFFTData_mod1[localId].y - localFFTData_mod2[localId].y);
    m_2= twiddle_factor * (localFFTData_modM1[localId].y - localFFTData_modM2[localId].y);

    t1_1=localFFTData_mod1[localId].x + localFFTData_mod2[localId].x;
    t1_2=localFFTData_modM1[localId].x + localFFTData_modM2[localId].x;
    r0_1.x = (t1_1+t1_1) + localFFTData_mod0[localId].x;
    r0_2.x = (t1_2+t1_2) + localFFTData_modM0[localId].x;
    t2_1= localFFTData_mod0[localId].x - t1_1;
    t2_2= localFFTData_modM0[localId].x - t1_2;
    r1_1.x = t2_1 +m_1;
    r1_2.x = t2_2 +m_2;
    r2_1.x = t2_1 -m_1;
    r2_2.x = t2_2 -m_2;

    m_1= twiddle_factor * (localFFTData_mod1[localId].x - localFFTData_mod2[localId].x);
    m_2= twiddle_factor * (localFFTData_modM1[localId].x - localFFTData_modM2[localId].x);

    t1_1=localFFTData_mod1[localId].y + localFFTData_mod2[localId].y;
    t1_2=localFFTData_modM1[localId].y + localFFTData_modM2[localId].y;
    r0_1.y = (t1_1+t1_1) + localFFTData_mod0[localId].y;
    r0_2.y = (t1_2+t1_2) + localFFTData_modM0[localId].y;
    t2_1= localFFTData_mod0[localId].y - t1_1;
    t2_2= localFFTData_modM0[localId].y - t1_2;
    r1_1.y = t2_1 -m_1;
    r1_2.y = t2_2 -m_2;
    r2_1.y = t2_1 +m_1;
    r2_2.y = t2_2 +m_2;

    /* coalesced load of FFT twiddle factors into local memory */
    localTwiddle_mod0[localId].x = fft_twiddle_data_rc[globalId];
    localTwiddle_mod0[localId].y = fft_twiddle_data_rc[globalId+fullFFTlength];
    /* wait for load to finish */
    barrier(CLK_LOCAL_MEM_FENCE);
    /* coalesced load of FFT twiddle factors into local memory */
    localTwiddle_mod1[localId].x = fft_twiddle_data_rc[globalId+subFFTlength];
    localTwiddle_mod1[localId].y = fft_twiddle_data_rc[globalId+subFFTlength+fullFFTlength];
    /* wait for load to finish */
    barrier(CLK_LOCAL_MEM_FENCE);
    /* coalesced load of FFT twiddle factors into local memory */
    localTwiddle_mod2[localId].x = fft_twiddle_data_rc[globalId+subFFTlength+subFFTlength];
    localTwiddle_mod2[localId].y = fft_twiddle_data_rc[globalId+subFFTlength+subFFTlength+fullFFTlength];
    /* wait for load to finish */
    barrier(CLK_LOCAL_MEM_FENCE);
    /* coalesced load of FFT twiddle factors into local memory */
    localTwiddle_modM0[localId].x = fft_twiddle_data_rc[subFFTlength-globalId];
    localTwiddle_modM0[localId].y = fft_twiddle_data_rc[subFFTlength-globalId+fullFFTlength];
    /* wait for load to finish */
    barrier(CLK_LOCAL_MEM_FENCE);
    /* coalesced load of FFT twiddle factors into local memory */
    localTwiddle_modM1[localId].x = fft_twiddle_data_rc[subFFTlength+subFFTlength-globalId];
    localTwiddle_modM1[localId].y = fft_twiddle_data_rc[subFFTlength+subFFTlength-globalId+fullFFTlength];
    /* wait for load to finish */
    barrier(CLK_LOCAL_MEM_FENCE);
    /* coalesced load of FFT twiddle factors into local memory */
    /* Note: we have to avoid overrun for globalId==0  */
    localTwiddle_modM2[localId].x = fft_twiddle_data_rc[(subFFTlength+subFFTlength+subFFTlength-globalId) % fullFFTlength];
    localTwiddle_modM2[localId].y = fft_twiddle_data_rc[((subFFTlength+subFFTlength+subFFTlength-globalId) % fullFFTlength )+fullFFTlength];
    /* wait for load to finish */
    barrier(CLK_LOCAL_MEM_FENCE);
    if (globalId==0){
        r2_2=r0_1;
        r1_2=r2_1;
        r0_2=r1_1;
    }
    float2 res;
    float2 tf= localTwiddle_mod0[localId];
    untangle(res,r0_1,r2_2,tf);
    if(0 == globalId) {
       res.x=res.y= 0.0f;
    }
    if(!ignore) ps_data[globalId] = norm_factor * (res.x * res.x + res.y * res.y);
    tf= localTwiddle_mod1[localId];
    untangle(res,r1_1,r1_2,tf);
    if(!ignore) ps_data[globalId+subFFTlength] = norm_factor * (res.x * res.x + res.y * res.y);
    tf= localTwiddle_mod2[localId];
    untangle(res,r2_1,r0_2,tf);
    if(!ignore) ps_data[globalId+subFFTlength+subFFTlength] = norm_factor * (res.x * res.x + res.y * res.y);
    tf= localTwiddle_modM0[localId];
    untangle(res,r0_2,r2_1,tf);
    if(!ignore) ps_data[subFFTlength-globalId] = norm_factor * (res.x * res.x + res.y * res.y);
    tf= localTwiddle_modM1[localId];
    untangle(res,r1_2,r1_1,tf);
    if(!ignore) ps_data[subFFTlength+subFFTlength-globalId] = norm_factor * (res.x * res.x + res.y * res.y);
    tf= localTwiddle_modM2[localId];
    untangle(res,r2_2,r0_1,tf);
    if(!ignore) ps_data[subFFTlength+subFFTlength+subFFTlength-globalId] = norm_factor * (res.x * res.x + res.y * res.y);

}
#ifdef USE_TEXTURES
    /* FIXME: add OpenCL image object access here */
    #define FETCH(t, i) tex1Dfetch(t##Image, i)
#else
    #define FETCH(t, i) (t[i])
#endif
__kernel void kernelHarmonicSumming(__global   float       *sumspec1,
                                    __global   float       *sumspec2,
                                    __global   float       *sumspec3,
                                    __global   float       *sumspec4,
                                    __global   const float *powerspectrum,
                                    __global   int         *dirty,
                                    __constant int         *h_lut,
                                    __constant int         *k_lut,
                                    __constant float       *thrA,
                                    __private  int          window_2,
                                    __private  int          fundamental_idx_hi,
                                    __private  int          harmonic_idx_hi)
{
    __local float sspec_cand[4 * OCL_HS_WGSIZE_X];
    /* FIXME: these pointers should be stored locally or in registers! */
    __global float * sumspec[4];
    int idx_j = (get_group_id(1) << 4) + get_group_id(0);
    int idx_j_offset =  (idx_j << OCL_HS_LOG_WGSIZE_X) + -16 ; // negative index to handle left border
    int i = idx_j_offset + get_local_id(0) + 8;
    int k;
    int h = i;
    int j, jj,len, offset, lend2, lenM1;
    float sum;
    float p;
    int i2, i4, i8;
    int iN;
    if(i < window_2 || i >= harmonic_idx_hi ) {
    // no candidate contribution from this index
    sspec_cand[get_local_id(0)] = 0.0f;
    sspec_cand[OCL_HS_WGSIZE_X + get_local_id(0)] = 0.0f;
    sspec_cand[2*OCL_HS_WGSIZE_X + get_local_id(0)] = 0.0f;
    sspec_cand[3*OCL_HS_WGSIZE_X + get_local_id(0)] = 0.0f;
 } else {
    p  = FETCH(powerspectrum, i);
    i2 = i  + i;
    i4 = i << 2;
    i8 = i4 + i4;
    iN = i8 + 8;
    // mark pages with potential candidates also in powerspectrum itself
    // this can cause concurrent writes to the same address, but all of them
    // write the same value !
    if( (p > FETCH(thrA,0)) && (i < fundamental_idx_hi)) {
        dirty[ (i>> OCL_LOG_PS_PAGE_SIZE_X)] = 1;
    }
    p += FETCH(powerspectrum, iN >> 4);
    sspec_cand[get_local_id(0)] = p;
    iN   = i4 + 8;
    sum  = FETCH(powerspectrum, iN >> 4);
    iN  += i8;
    sum += FETCH(powerspectrum, iN >> 4);
    p += sum;
    sspec_cand[OCL_HS_WGSIZE_X + get_local_id(0)] = p;
    iN   = i2 + 8;
    sum  = FETCH(powerspectrum, iN >> 4);
    iN  += i4;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i4;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i4;
    sum += FETCH(powerspectrum, iN >> 4);
    p += sum;
    sspec_cand[2 * OCL_HS_WGSIZE_X + get_local_id(0)] = p;
    iN   = i + 8;
    sum  = FETCH(powerspectrum, iN >> 4);
    iN  += i2;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i2;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i2;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i2;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i2;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i2;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i2;
    sum += FETCH(powerspectrum, iN >> 4);
    p += sum;
    sspec_cand[3 * OCL_HS_WGSIZE_X + get_local_id(0)] = p;
 }
    sumspec[0] = sumspec1;
    sumspec[1] = sumspec2;
    sumspec[2] = sumspec3;
    sumspec[3] = sumspec4;
    barrier(CLK_GLOBAL_MEM_FENCE);
    if((get_local_id(0) & 15) < 12) {
        h = FETCH(h_lut, get_local_id(0) & 15);
        k = FETCH(k_lut, get_local_id(0) & 15) + ((get_local_id(0) >> 4) << 4);
        len    = 1 << h;
        lend2  = len >> 1;
        offset = ((h - 1) << OCL_HS_LOG_WGSIZE_X) + k;
        lenM1  = len - 1;
        sum = sspec_cand[offset];
        /* #pragma unroll 15 */
        for (j = 1; j < 16; j++) {
            sum = fmax(sum, sspec_cand[offset + (j & lenM1)]);
        }
        jj = (idx_j_offset + k + 8 + lend2) ;
        j= (jj>= 0) ? (jj  >> h) : -1 ;
        if (
            (sum > FETCH(thrA, h )) &&
            (j < fundamental_idx_hi) && j>=0 )
        {
        /* mark this page of the sumspec array as dirty */
        /* TODO: maybe write to shared memory buffer first, then (by thread 0) to global memory if set to 1, avoiding
                simultaneous writes to global memory from the same block */

            dirty[((fundamental_idx_hi >> OCL_LOG_PS_PAGE_SIZE_X) +1)  * h + (j>> OCL_LOG_PS_PAGE_SIZE_X)] = 1;
            sumspec[h-1][j] = sum;
        }
    }
}
__kernel void kernelHarmonicSummingGaps(__global   float       *sumspec1,
                                        __global   float       *sumspec2,
                                        __global   float       *sumspec3,
                                        __global   float       *sumspec4,
                                        __global   const float *powerspectrum,
                                        __global   int         *dirty,
                                        __constant int         *h_lut,
                                        __constant int         *k_lut,
                                        __constant float       *thrA,
                                        __private  int          window_2,
                                        __private  int          fundamental_idx_hi,
                                        __private  int          harmonic_idx_hi)
{
    __local float sspec_cand[2 * OCL_HS_WGSIZE_X];
    /* FIXME: these pointers should be stored locally or in registers! */
    __global float * sumspec[4];
    int idx_j = (get_group_id(1) << 4) + get_group_id(0);
    int idx_j_offset = (idx_j << OCL_HS_LOG_WGSIZE_X);
    int idx_i_offset = get_local_id(0);
    int i = idx_j_offset + 4 + (get_local_id(0) & 7) + ((get_local_id(0) >> 3 ) << 4);
    int k;
    int h = i;
    int j, len, offset, lend2, lenM1;
    float sum;
    float p;
    int i2, i4, i8;
    int iN;
    /* for this kernel , there can be now overlap with the left border of the spectrum (index 0),
     * but we could be lower than window_2 or higher than harmonic_idx_hi */
    if(i < window_2 || i >= harmonic_idx_hi ) {
      // no candidate contribution from this index
       sspec_cand[idx_i_offset] = 0.0f;
       sspec_cand[(OCL_HS_WGSIZE_X / 2)  + idx_i_offset] = 0.0f;
       sspec_cand[2*(OCL_HS_WGSIZE_X / 2) + idx_i_offset] = 0.0f;
       sspec_cand[3*(OCL_HS_WGSIZE_X / 2) + idx_i_offset] = 0.0f;
   } else {
    p  = FETCH(powerspectrum, i);
    i2 = i + i;
    i4 = i << 2;
    i8 = i4 + i4;
    iN = i8 + 8;
    // mark pages with potential candidates also in powerspectrum itself
    // this can cause concurrent writes to the same address, but all of them
    // write the same value !
    if( (p > FETCH(thrA,0)) && (i < fundamental_idx_hi) ) {
        dirty[ (i>> OCL_LOG_PS_PAGE_SIZE_X)] = 1;
    }
    p += FETCH(powerspectrum, iN >> 4);
    sspec_cand[idx_i_offset] = p;
    iN   = i4 + 8;
    sum  = FETCH(powerspectrum, iN >> 4);
    iN  += i8;
    sum += FETCH(powerspectrum, iN >> 4);
    p += sum;
    sspec_cand[(OCL_HS_WGSIZE_X / 2) + idx_i_offset] = p;
    iN   = i2 + 8;
    sum  = FETCH(powerspectrum, iN >> 4);
    iN  += i4;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i4;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i4;
    sum += FETCH(powerspectrum, iN >> 4);
    p += sum;
    sspec_cand[2 * (OCL_HS_WGSIZE_X / 2) + idx_i_offset] = p;
    iN   = i + 8;
    sum  = FETCH(powerspectrum, iN >> 4);
    iN  += i2;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i2;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i2;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i2;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i2;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i2;
    sum += FETCH(powerspectrum, iN >> 4);
    iN  += i2;
    sum += FETCH(powerspectrum, iN >> 4);
    p += sum;
    sspec_cand[3 * (OCL_HS_WGSIZE_X / 2) + idx_i_offset] = p;
    sumspec[0] = sumspec1;
    sumspec[1] = sumspec2;
    sumspec[2] = sumspec3;
    sumspec[3] = sumspec4;
  }
    barrier(CLK_GLOBAL_MEM_FENCE);
    if((get_local_id(0) < 4 * (OCL_HS_WGSIZE_X / 16)) && ((get_local_id(0) & 3) != 3)) {
        h      = 3 - (get_local_id(0) & 3);
        k      = FETCH(k_lut, (get_local_id(0) & 3) + 13) + ((get_local_id(0) >> 2) << 3);
        len    = 1 << h;
        lend2  = len >> 1;
        offset = ((h - 1) << (OCL_HS_LOG_WGSIZE_X - 1)) + k;
        lenM1  = len - 1;
        sum = sspec_cand[offset];
        /* #pragma unroll 7 */
        for (j = 1; j < 8; j++) {
            sum = fmax(sum, sspec_cand[offset + (j & lenM1)]);
        }
        j = ((idx_j_offset + k + ((get_local_id(0) >> 2) << 3) + 4 + lend2) >> h) ;
        if (
            (sum > FETCH(thrA, h )) &&
            (j < fundamental_idx_hi))
        {
        /* mark this page of the sumspec array as dirty */
        /* TODO: maybe write to shared memory buffer first, then (by thread 0) to global memory if set to 1, avoiding
                simultaneous writes to global memory from the same block */

            dirty[((fundamental_idx_hi >> OCL_LOG_PS_PAGE_SIZE_X) +1)  * h + (j>> OCL_LOG_PS_PAGE_SIZE_X)] = 1;
            sumspec[h-1][j] = sum;
        }
    }
}
__kernel void kernelFillFloatBuffer(__private unsigned int  length,
                                    __private float         value,
                                    __global  float        *buffer)
{
    size_t i = get_global_id(0);
    if(i < length) {
        buffer[i] = value;
    }
}
__kernel void kernelFillIntBuffer(__private unsigned int  length,
                                    __private int           value,
                                    __global  int          *buffer)
{
    size_t i = get_global_id(0);
    if(i < length) {
        buffer[i] = value;
    }
}



// buildOptions=-Werror -cl-single-precision-constant  -DOCL_HS_CONDITIONAL_STORES_THRESHOLD=1 -DOCL_RESAMP_REDUCTION_WGSIZE_X=256 -DOCL_PS_WGSIZE_X=256 -DOCL_PS_R3_R2C_WGSIZE_X=256 -DOCL_HS_WGSIZE_X=256 -DOCL_HS_LOG_WGSIZE_X=8 -DOCL_LOG_PS_PAGE_SIZE_X=10
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -Werror -cl-single-precision-constant  -DOCL_HS_CONDITIONAL_STORES_THRESHOLD=1 -DOCL_RESAMP_REDUCTION_WGSIZE_X=256 -DOCL_PS_WGSIZE_X=256 -DOCL_PS_R3_R2C_WGSIZE_X=256 -DOCL_HS_WGSIZE_X=256 -DOCL_HS_LOG_WGSIZE_X=8 -DOCL_LOG_PS_PAGE_SIZE_X=10" %cfg_path --cl-device=%cl_device 2>&1
