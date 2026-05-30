//R: here kernels for SETI MultiBeam OpenCL build will be located
// This version is using fraction(a * b * b) = fraction((_a + fa) (_b + fb) ^ 2) for enhancing the precision
#define M_2PI              6.28318530717958647692f //R: it's single precision constant here !
//#if USE_OPENCL_NV || USE_OPENCL_HD5xxx || USE_OPENCL_INTEL
//	#define OCL_REAL_LOCAL 1
//#endif

#define GAUSSIAN_POT_LENGTH 64
typedef struct {
	int icfft;
	int fft_ind;
	float bin;
	float peak_power;
	float mean_power;
	float chisqr;
	float null_chisqr;
	float max_power;
	float score;
	float pot[GAUSSIAN_POT_LENGTH];
} GPUGaussian;
#define MAX_GPU_GAUSSIANS 30
typedef struct {
	int index;
	float bscore;//R:Keeps threshold w/o info where it occured. Can be used to avoid lot of wrong reports.
	GPUGaussian gaussian[MAX_GPU_GAUSSIANS+1];//R: best gaussian stored as zero element of this array
} GPUGaussians;
typedef struct {
	int icfft;
	int fft_ind;
	float bin;
	float power;
} GPUAutocorr;
#define MAX_GPU_AUTOCORRS 30
typedef struct {
	int index;
	float threshold;
	GPUAutocorr autocorr[MAX_GPU_AUTOCORRS+1];//R: best autocorr stored as zero element of this array
} GPUAutocorrs;
typedef struct {
	int icfft;
	int fft_ind;
	float bin;
	float power;
} GPUSpike;
#define MAX_GPU_SPIKES 30
typedef struct {
	int index;
	float threshold;
	GPUSpike spike[MAX_GPU_SPIKES+1];//R: best spike stored as zero element of this array
} GPUSpikes;
typedef struct {
	int icfft;
	GPUSpikes spikes;
	GPUAutocorrs autocorrs;
	GPUGaussians gaussians;
} GPUState;

//R: single precision direct chirp (w/o angle range reduce) gives too low precision results to be used here (kernel deleted).
//R: port of original chirp2 from CUDA app gives increased number of inconclusives due to relatively low precision;
//R: it can be replaced with CHIRP3 mod that does more precise computations but suffers in speed on lesser ATi GPUs
//R: Also, it (CHIRP3) can't be used for FERMI due to bad precision on those chips.
//R: Doube precision chirp wins in speed for
#if OCL_DOUBLE_CHIRP
#if defined(cl_khr_fp64)   //R:double precision chirp here
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
#endif
#if defined(cl_amd_fp64)
#pragma OPENCL EXTENSION cl_amd_fp64 : enable
#endif

__kernel
void CalcChirpData_kernel_dp_cl(const double chirp_rate, __global float4* cx_DataArray, __global float4* cx_ChirpDataArray,
								 const double recip_sample_rate)
{
		uint i= get_global_id(0);

		float4 cx=cx_DataArray[i];
		float4 chirp;
		float2 c, d;
		float2 angf;
		double2 time;
		time.x = (2*i)*recip_sample_rate;
		time.y= (2*i+1)*recip_sample_rate;
	    double2 ang  = chirp_rate*(time*time);
		//ang  = ang-floor(ang);
		ang  = ang-trunc(ang);//R: trunc faster than floor for ATi
		angf.x =(float)ang.x;
		angf.y =(float)ang.y;
		angf*=M_2PI;
		//d=sincos(angf,&c);
		d=native_sin(angf);
		c=native_cos(angf);
			// real = cx.x * c - cx.y * d;
		chirp.xz = cx.xz*c.xy-cx.yw*d.xy;
			// imag = cx.x * d + cx.y * c;
		chirp.yw = cx.xz*d.xy+cx.yw*c.xy;
		cx_ChirpDataArray[i] = chirp;
}


#elif OCL_CHIRP3 //R: more precise than usual FP chirp and even faster than DP chirp on DP-enabled cards.
float __fmul_rn(float a, float b){return a*b;}
float __fadd_rn(float a, float b){return a+b;}
float __float2int_rn(float a){return rint(a);}
float __int2float_rn(int a){return (float)a;}
float2 split(float a)
{
	const float split= 4097;
	float t = __fmul_rn(a,split);
	float2 r;
	r.x = t-(t-a);
	r.y = a - r.x;
	return r;
}
 float2 twoProd(float a, float b)
{
	float2 r;
	r.x = __fmul_rn(a,b);
	float2 aS = split(a);
	float2 bS = split(b);
	r.y = ( ( __fmul_rn(aS.x,bS.x) - r.x )
				+ __fmul_rn(aS.x,bS.y) + __fmul_rn(aS.y,bS.x) )
				+ __fmul_rn(aS.y,bS.y);
	return r;
}

float2 quickTwoSum(float a, float b)
{
	float2 r;
	r.x = a + b;
	r.y = b - (r.x-a);
	return r;
}

float2 df64_mult(float2 a, float2 b)
{
	float ah=a.x,al=a.y,bh=b.x,bl=b.y;
	float2 p;
	p = twoProd(ah,bh);
	p.y += ah*bl;
	p.y += al*bh;
	p = quickTwoSum(p.x,p.y);
	return p;
}

__kernel
void CalcChirpData_kernel_df64_cl(const float2 chirp_rate, __global float4* cx_DataArray,
							  __global float4* cx_ChirpDataArray, const float2 recip_sample_rate) {
	uint i= get_global_id(0);
	//uint j=get_global_id(1);
//Jason: translating to intrinsics for IEEE compliance, better agreement with Fermi & CPU
//R:in OpenCL round to nearest is default rounding mode. intrinsics are emulated.
		float4 cx = cx_DataArray[i];
		float2 c, d;
		float4 chirped;
		float4 time;
		time.xy=df64_mult(split(__int2float_rn(2*i)),recip_sample_rate);
		time.zw=df64_mult(split(__int2float_rn(2*i+1)),recip_sample_rate);
		float4 angdf;
		angdf.xy = df64_mult(chirp_rate,df64_mult(time.xy,time.xy));
		angdf.zw = df64_mult(chirp_rate,df64_mult(time.zw,time.zw));
		angdf = (angdf-rint(angdf))*M_2PI;
		float2 ang;
		ang.xy= angdf.xz+angdf.yw;
#if USE_OPENCL_INTEL //R: native_sin/cos too imprecise on Intel GPUs.
		d=sincos(ang,&c);
#else
		d=native_sin(ang);
		c=native_cos(ang);
#endif
//		real = cx.x * c - cx.y * d;
//		imag = cx.x * d + cx.y * c;
		chirped.xz = cx.xz*c - cx.yw*d;
		chirped.yw = cx.xz*d+cx.yw*c;

		cx_ChirpDataArray[i] = chirped;
}

//R: this kernel will process both signs of chirp value so doubled buffer required
__kernel
void CalcChirpData_kernel_df64_twin_cl(const float2 chirp_rate, __global float4* cx_DataArray,
							  __global float4* cx_ChirpDataArray_pos,__global float4* cx_ChirpDataArray_neg,
							  const float2 recip_sample_rate) {
	uint i= get_global_id(0);
//Jason: translating to intrinsics for IEEE compliance, better agreement with Fermi & CPU
//R:in OpenCL round to nearest is default rounding mode. intrinsics are emulated.
		float4 cx = cx_DataArray[i];
		float2 c, d;
		float4 chirped;
		float4 chirped_neg;
		float4 time;
		time.xy=df64_mult(split(__int2float_rn(2*i)),recip_sample_rate);
		time.zw=df64_mult(split(__int2float_rn(2*i+1)),recip_sample_rate);
		float4 angdf;
		angdf.xy = df64_mult(chirp_rate,df64_mult(time.xy,time.xy));
		angdf.zw = df64_mult(chirp_rate,df64_mult(time.zw,time.zw));
		angdf = (angdf-rint(angdf))*M_2PI;
		float2 ang;
		ang.xy= angdf.xz+angdf.yw;
#if USE_OPENCL_INTEL //R: native_sin/cos too imprecise on Intel GPUs.
		d=sincos(ang,&c);
#else
		d=native_sin(ang);
		c=native_cos(ang);
#endif

//		real = cx.x * c - cx.y * d;
//		imag = cx.x * d + cx.y * c;
		chirped.xz = cx.xz*c - cx.yw*d;
		chirped.yw = cx.xz*d+cx.yw*c;
		chirped_neg.xz = cx.xz*c + cx.yw*d;
		chirped_neg.yw = -cx.xz*d+cx.yw*c;
		cx_ChirpDataArray_pos[i] = chirped;
		cx_ChirpDataArray_neg[i] = chirped_neg;
}
#else
__kernel __attribute__((vec_type_hint(float4)))
void CalcChirpData_kernel2_cl(const float4 chirp_rate, __global float4* cx_DataArray,
									   __global float4* cx_ChirpDataArray,__global float4* sample_rate) {
	uint i= get_global_id(0);
	float4 cx = cx_DataArray[i];
	float4 time = sample_rate[i];
	float sin1,sin2, cos1,cos2;
	float4 chirped;
	float tmp;
	float a = chirp_rate.x;
	float b = time.x;
	float a1= chirp_rate.z;
	float b1= time.z;
	float fa = chirp_rate.y;
	float fb = time.y;
	float fa1 = chirp_rate.w;
	float fb1 = time.w;
	float ang  = fract(2 * a * fract(b * fb,&tmp),&tmp) + fract(a * fb * fb,&tmp) +
		fract(b * fract(b * fa,&tmp),&tmp) + fract(2 * b * fa * fb,&tmp) + fa * fb * fb;
	ang -= floor(ang);
	ang *= M_2PI;
	//sin1=sincos(ang,&cos1);
	sin1=native_sin(ang);
	cos1=native_cos(ang);
	chirped.x = cx.x * cos1 - cx.y * sin1;
	chirped.y = cx.x * sin1 + cx.y * cos1;
	ang  = fract(2 * a1 * fract(b1 * fb1,&tmp),&tmp) + fract(a1 * fb1 * fb1,&tmp) +
		fract(b1 * fract(b1 * fa1,&tmp),&tmp) + fract(2 * b1 * fa1 * fb1,&tmp) + fa1 * fb1 * fb1;
	ang -= floor(ang);
	ang *= M_2PI;
	//sin2=sincos(ang,&cos2);
	sin2=native_sin(ang);
	cos2=native_cos(ang);
	chirped.z = cx.z * cos2 - cx.w * sin2;
	chirped.w = cx.z * sin2 + cx.w * cos2;

		cx_ChirpDataArray[i] = chirped;
}
#endif
#if USE_OPENCL_NV
__kernel void GetPowerSpectrum_kernel_cl(__global float2* FreqData, __global float* PowerSpectrum) {
	uint i= get_global_id(0);
	float2 f1 = FreqData[i];
	float p;
	p=mad(f1.x,f1.x,f1.y*f1.y);
	PowerSpectrum[i] = p;
}
#else
__kernel void GetPowerSpectrum_kernel_cl(__global float4* FreqData, __global float2* PowerSpectrum) {
	uint i= get_global_id(0);
	float4 f1 = FreqData[i];
	float2 p;
	p.xy=mad(f1.xz,f1.xz,f1.yw*f1.yw);
	PowerSpectrum[i] = p;
}
#endif
#if 0
typedef struct{
	float mean;
	float maximum;
	float index;
} SpikeResults;//R: there is no float3 in OpenCL 1.0 s using such structure
#endif
#if SIGNALS_ON_GPU
__kernel __attribute__((vec_type_hint(float4)))
void PC_find_spike_kernel_cl(__global float4* PowerSpectrum, __global float2* MeanMaxIdx, uint fftlen,
									  __constant GPUState* gpu_state,__global uint* result_flag){
	//R: CUDA version of this kernel use shared memory and reducing, HD4xxx have no shared memory so I will
	//do whole power array per workitem.
	uint tid= get_global_id(0);
	//float mean=0.f;
	float4 sum4=0.f;
	float maxval=0.f;
	//float power;
	float pos=0.f;//R: should be integer value but will use float for better memory packing
//	float4 mmi;
	float4 p;
	//R: separate handling of first quad - DC element should be omitted
	p=PowerSpectrum[tid*(fftlen>>2)];
	sum4.x=p.x;
	sum4.y=p.y;
	sum4.z=p.z;
	sum4.w=p.w;
	if(p.y>maxval){pos=1;}
	maxval=max(maxval,p.y);
	if(p.z>maxval){pos=2;}
	maxval=max(maxval,p.z);
	if(p.w>maxval){pos=3;}
	maxval=max(maxval,p.w);
	for(uint i=1;i<(fftlen>>2);i++){
		p=PowerSpectrum[i+tid*(fftlen>>2)];//R:doing 4 elements at once
		sum4+=p;
		if(p.x>maxval){pos=i*4;}
		maxval=max(maxval,p.x);
		if(p.y>maxval){pos=i*4+1;}
		maxval=max(maxval,p.y);
		if(p.z>maxval){pos=i*4+2;}
		maxval=max(maxval,p.z);
		if(p.w>maxval){pos=i*4+3;}
		maxval=max(maxval,p.w);
	}
	float2 res;//x-power, y - pos
	res.x=maxval*fftlen/(sum4.x+sum4.y+sum4.z+sum4.w);//R: mean is just the sum actually hence multiplication on fftlen
	res.y=pos;
	MeanMaxIdx[tid]=res;
//	MeanMaxIdx[3*tid+1]=maxval;
//	MeanMaxIdx[2*tid+1]=pos;
//	float power=maxval/mean;
//	float score=log10(power/40.f);
	if(res.x>gpu_state->spikes.spike[0].power || res.x>gpu_state->spikes.threshold){
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;//R: something interesting inside this block
	}
}
#else
__kernel __attribute__((vec_type_hint(float4)))
void PC_find_spike_kernel_cl(__global float4* PowerSpectrum, __global float2* MeanMaxIdx, uint fftlen,
									  float best, float spike_thresh,__global uint* result_flag){
	//R: CUDA version of this kernel use shared memory and reducing, HD4xxx have no shared memory so I will
	//do whole power array per workitem.
	uint tid= get_global_id(0);
	//float mean=0.f;
	float4 sum4=0.f;
	float maxval=0.f;
	//float power;
	float pos=0.f;//R: should be integer value but will use float for better memory packing
//	float4 mmi;
	float4 p;
	//R: separate handling of first quad - DC element should be omitted
	p=PowerSpectrum[tid*(fftlen>>2)];
	sum4.x=p.x;
	sum4.y=p.y;
	sum4.z=p.z;
	sum4.w=p.w;
	if(p.y>maxval){pos=1;}
	maxval=max(maxval,p.y);
	if(p.z>maxval){pos=2;}
	maxval=max(maxval,p.z);
	if(p.w>maxval){pos=3;}
	maxval=max(maxval,p.w);
	for(uint i=1;i<(fftlen>>2);i++){
		p=PowerSpectrum[i+tid*(fftlen>>2)];//R:doing 4 elements at once
		sum4+=p;
		if(p.x>maxval){pos=i*4;}
		maxval=max(maxval,p.x);
		if(p.y>maxval){pos=i*4+1;}
		maxval=max(maxval,p.y);
		if(p.z>maxval){pos=i*4+2;}
		maxval=max(maxval,p.z);
		if(p.w>maxval){pos=i*4+3;}
		maxval=max(maxval,p.w);
	}
	float2 res;//x-power, y - pos
	res.x=maxval*fftlen/(sum4.x+sum4.y+sum4.z+sum4.w);//R: mean is just the sum actually hence multiplication on fftlen
	res.y=pos;
	MeanMaxIdx[tid]=res;
//	MeanMaxIdx[3*tid+1]=maxval;
//	MeanMaxIdx[2*tid+1]=pos;
//	float power=maxval/mean;
//	float score=log10(power/40.f);
	if(res.x>best || res.x>spike_thresh){
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;//R: cpu attention required to this block
	}
}
#endif
#ifdef OCL_REAL_LOCAL //USE_OPENCL_NV || USE_OPENCL_HD5xxx || USE_INTEL
__kernel void PC_find_spike32_kernel_cl(__global float* PowerSpectrum, __global float2* MeanMaxIdx, uint Nchunk,
									  //float best, float spike_thresh,__global uint4* result_flag,
									  __local float4* tmp){
//R: float4 in shared mem is waste of resources, but CUDA SDK3.2RC2 doesn't understand float3... weird...
	const int tid = get_local_id(0);
    const int y = get_global_id(1);
    const int gridX = get_local_size(0);
    const int start = y * gridX * Nchunk;
    const int end = (y + 1) * gridX*Nchunk;

    float sum = 0.0f;
    float maximum = 0.0f;
    int pos = 0;

	int i = start + tid;
	float val = PowerSpectrum[i];
	sum += val;//R: sum calculated over all elements while peak searched only through non-DC components
	if (get_global_id(0) > 0) { // Original max omits first element of every fft
		if (val > maximum)
			pos = i;
		maximum = max(maximum, val);
	}

    for (i = start + tid + gridX; i < end; i += gridX) {
        val = PowerSpectrum[i];
        sum += val;
        if (val > maximum)
            pos = i;
        maximum = max(maximum, val);
    }

    tmp[tid] =(float4)(sum, maximum, (float)(pos - start),0.f);

    for (i = gridX >> 1; i > 0; i >>= 1) {
        barrier(CLK_LOCAL_MEM_FENCE);
        if (tid < i) {
            tmp[tid] = (float4)(
                tmp[tid].x + tmp[tid + i].x,
                max(tmp[tid].y, tmp[tid + i].y),
                tmp[tid].y > tmp[tid + i].y ? tmp[tid].z : tmp[tid + i].z,0.f//R:w not used
                );
        }
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    if (tid == 0) {
		//float4 mp4;
		//tmp4.x/=(gridX * Nchunk);//mean value needed, not just sum; sum/fftlen
		float2 power;
			power.x=(gridX * Nchunk)*tmp[0].y/tmp[0].x;
			power.y=tmp[0].z;
		//tmp4.xyzw=tmp[tid].xyzw;//R:float4 in output array but float3 in shared memory
		MeanMaxIdx[y]=power;
	//MeanMaxIdx[3*tid+2]=tmp4.z;
	//	float power=tmp4.y/tmp4.x;//max/mean
	//	float score=log10(power/40.f);
	//	if(score>best || power>spike_thresh){
	//		result_flag[0].x=1;//R: only in this case kernel results are needed
	//	}
	}

}
#endif
#if SIGNALS_ON_GPU
__kernel void Spike_logging_kernel_cl(__global float2* MeanMaxIdx,int size, __global GPUState* gpu_state){
	//R: can use some reduce scheme but simplest single workitem form now (can be enqueued as task for now)
	gpu_state->icfft++;//R:only one spike search per icfft. Will be called with size==0 where no spikes done
	for(int i=0;i<size;i++){
		if(gpu_state->spikes.index>=MAX_GPU_SPIKES) return;//R: no best update or new signals logging allowed after overflow
		if(MeanMaxIdx[i].x>gpu_state->spikes.spike[0].power){//R: best spike update
			gpu_state->spikes.spike[0].power=MeanMaxIdx[i].x;
			gpu_state->spikes.spike[0].bin=MeanMaxIdx[i].y;
			gpu_state->spikes.spike[0].fft_ind=i;
			gpu_state->spikes.spike[0].icfft=gpu_state->icfft;
		}
		if(MeanMaxIdx[i].x>gpu_state->spikes.threshold){//R: logging new signal in next slot
			gpu_state->spikes.index++;//R: in case of multi-workitem kernel should be atomic
			int idx=gpu_state->spikes.index;
			gpu_state->spikes.spike[idx].power=MeanMaxIdx[i].x;
			gpu_state->spikes.spike[idx].bin=MeanMaxIdx[i].y;
			gpu_state->spikes.spike[idx].fft_ind=i;
			gpu_state->spikes.spike[idx].icfft=gpu_state->icfft;
		}

	}
}
__kernel void Spike_logging_HD5_kernel_cl(__global float2* MeanMaxIdx,int size, __global GPUState* gpu_state){
	int tid=get_global_id(0);//R: here should be gID, but later lID==gID cause only 1 WG for this kernel
	if(tid==0)gpu_state->icfft++;//R:only one spike search per icfft. Will be called with size==0 where no spikes done
	local float bpower[256];
	local float bbin[256];
	local int bfft_ind[256];
	local int was_signal[256];
	if(size==0)return;
	int stride=size/get_local_size(0);
	float best,best_bin,best_fft;

	best=bpower[tid]=gpu_state->spikes.spike[0].power;
	was_signal[tid]=0;
	float threshold=gpu_state->spikes.threshold;
	for(int i=tid*stride;i<(tid+1)*stride;i++){
		//if(gpu_state->spikes.index>=MAX_GPU_SPIKES) return;//R: no best update or new signals logging allowed after overflow
		if(MeanMaxIdx[i].x>best){//R: best spike update
			best=MeanMaxIdx[i].x;
			best_bin=MeanMaxIdx[i].y;
			best_fft=i;
			//gpu_state->spikes.spike[0].icfft=gpu_state->icfft;
		}
		if(MeanMaxIdx[i].x>threshold){//R: logging new signal in next slot
			was_signal[tid]=1;
			//gpu_state->spikes.index++;//R: in case of multi-workitem kernel should be atomic
			//int idx=gpu_state->spikes.index;
			//gpu_state->spikes.spike[idx].power=MeanMaxIdx[i].x;
			//gpu_state->spikes.spike[idx].bin=MeanMaxIdx[i].y;
			//gpu_state->spikes.spike[idx].fft_ind=i;
			//gpu_state->spikes.spike[idx].icfft=gpu_state->icfft;
		}
	}
	bpower[tid]=best;
	bbin[tid]=best_bin;
	bfft_ind[tid]=best_fft;
	barrier(CLK_LOCAL_MEM_FENCE);
	if(tid==0){
		int idx=gpu_state->spikes.index;
		for(int j=0;j<get_local_size(0);j++){
			if(bpower[j]>best){
				best=bpower[j];
				best_bin=bbin[j];
				best_fft=bfft_ind[j];
			}
			if(was_signal[j]){
				for(int k=j*stride;k<(j+1)*stride;k++)if(MeanMaxIdx[k].x>threshold){
						if(idx>=MAX_GPU_SPIKES) break;
						idx++;
						gpu_state->spikes.spike[idx].power=MeanMaxIdx[k].x;
						gpu_state->spikes.spike[idx].bin=MeanMaxIdx[k].y;
						gpu_state->spikes.spike[idx].fft_ind=k;
						gpu_state->spikes.spike[idx].icfft=gpu_state->icfft;
				}
			}
		}
		gpu_state->spikes.index=idx;
		if(best>gpu_state->spikes.spike[0].power){
			gpu_state->spikes.spike[0].power=best;
			gpu_state->spikes.spike[0].bin=best_bin;
			gpu_state->spikes.spike[0].fft_ind=best_fft;
			gpu_state->spikes.spike[0].icfft=gpu_state->icfft;
		}
	}
}
__kernel void Spike_partial_logging_kernel_cl(__global float2* MeanMaxIdx,int size, __global GPUState* gpu_state,__global uint* result_flag){
	//R: can use some reduce scheme but simplest single workitem form now (can be enqueued as task for now)
	gpu_state->icfft++;//R:only one spike search per icfft. Will be called with size==0 where no spikes done
	for(int j=0;j<RESULT_SIZE;j++)
		if(result_flag[j]==1){
			result_flag[j]=0;
			int stride=(size/RESULT_SIZE);
		for(int i=j*stride;i<(j+1)*stride;i++){
		if(gpu_state->spikes.index>=MAX_GPU_SPIKES) return;//R: no best update or new signals logging allowed after overflow
		if(MeanMaxIdx[i].x>gpu_state->spikes.spike[0].power){//R: best spike update
			gpu_state->spikes.spike[0].power=MeanMaxIdx[i].x;
			gpu_state->spikes.spike[0].bin=MeanMaxIdx[i].y;
			gpu_state->spikes.spike[0].fft_ind=i;
			gpu_state->spikes.spike[0].icfft=gpu_state->icfft;
		}
		if(MeanMaxIdx[i].x>gpu_state->spikes.threshold){//R: logging new signal in next slot
			gpu_state->spikes.index++;//R: in case of multi-workitem kernel should be atomic
			int idx=gpu_state->spikes.index;
			gpu_state->spikes.spike[idx].power=MeanMaxIdx[i].x;
			gpu_state->spikes.spike[idx].bin=MeanMaxIdx[i].y;
			gpu_state->spikes.spike[idx].fft_ind=i;
			gpu_state->spikes.spike[idx].icfft=gpu_state->icfft;
		}
		}
	}
}
__kernel void Spike_partial_logging_HD5_kernel_cl(__global float2* MeanMaxIdx,int size, __global GPUState* gpu_state,__global uint* result_flag){
	//R: can use some reduce scheme but simplest single workitem form now (can be enqueued as task for now)
	int j=get_global_id(0);//R: here should be gID, but later lID==gID cause only 1 WG for this kernel
	if(j==0)gpu_state->icfft++;//R:only one spike search per icfft. Will be called with size==0 where no spikes done
	//for(int j=0;j<RESULT_SIZE;j++)
	local GPUSpike spikes[RESULT_SIZE][MAX_GPU_SPIKES+1];//own signals array for each workitem
	//R: icfft field of 0th spike slot for each workitem will be used as real size of signal array for that workitem
	float bpower=gpu_state->spikes.spike[0].power;
	int idx=0;
	float bbin;
	int bfft_ind=-1;
	float threshold=gpu_state->spikes.threshold;
	if(result_flag[j]==1){
			result_flag[j]=0;
			int stride=(size/RESULT_SIZE);
	  for(int i=j*stride;i<(j+1)*stride;i++){
			if(idx>=MAX_GPU_SPIKES) break;//R: no best update or new signals logging allowed after overflow
		if(MeanMaxIdx[i].x>bpower){//R: best spike update
			bpower=MeanMaxIdx[i].x;
			bbin=MeanMaxIdx[i].y;
			bfft_ind=i;
			//gpu_state->spikes.spike[0].icfft=gpu_state->icfft;
		}
		if(MeanMaxIdx[i].x>threshold){//R: logging new signal in next slot
			idx++;
			//int idx=gpu_state->spikes.index;
			spikes[j][idx].power=MeanMaxIdx[i].x;
			spikes[j][idx].bin=MeanMaxIdx[i].y;
			spikes[j][idx].fft_ind=i;
			//gpu_state->spikes.spike[idx].icfft=gpu_state->icfft;
		}
	  }
		//R: dump best spike and array size into shared area
		spikes[j][0].power=bpower;
		spikes[j][0].bin=bbin;
		spikes[j][0].fft_ind=bfft_ind;
		spikes[j][0].icfft=idx;

	}else{//R: set shared variables to "no update required" state
		  spikes[j][0].icfft=-1;
	}
	//R: now reduce all arrays to master one
	barrier(CLK_LOCAL_MEM_FENCE);
	if(j==0){
		idx=gpu_state->spikes.index;
		for(int i=0;i<RESULT_SIZE;i++){
			if(spikes[i][0].icfft==-1)continue;
			if(spikes[i][0].power>bpower){
				bpower=spikes[i][0].power;
				bbin=spikes[i][0].bin;
				bfft_ind=spikes[i][0].fft_ind;
			}
			for(int k=1;k<=spikes[i][0].icfft;k++){
				if(idx>=MAX_GPU_SPIKES){
					gpu_state->spikes.index=idx;
					if(bpower>gpu_state->spikes.spike[0].power){
						gpu_state->spikes.spike[0].power=bpower;
						gpu_state->spikes.spike[0].bin=bbin;
						gpu_state->spikes.spike[0].fft_ind=bfft_ind;
						gpu_state->spikes.spike[0].icfft=gpu_state->icfft;
					}
					return;
				}
				idx++;
				gpu_state->spikes.spike[idx].power=spikes[i][k].power;
				gpu_state->spikes.spike[idx].bin=spikes[i][k].bin;
				gpu_state->spikes.spike[idx].fft_ind=spikes[i][k].fft_ind;
				gpu_state->spikes.spike[idx].icfft=gpu_state->icfft;
			}
		}
		gpu_state->spikes.index=idx;
		if(bpower>gpu_state->spikes.spike[0].power){
			gpu_state->spikes.spike[0].power=bpower;
			gpu_state->spikes.spike[0].bin=bbin;
			gpu_state->spikes.spike[0].fft_ind=bfft_ind;
			gpu_state->spikes.spike[0].icfft=gpu_state->icfft;
		}
	}
}
__kernel void Autocorr_logging_kernel_cl(__global float2* PowerBin,int size, __global GPUState* gpu_state){
	//R: can use some reduce scheme but simplest single workitem form now (can be enqueued as task for now)
	//R: for usual autocorr search at 128k FFT size there are only 8 elements to look for SETI 7
	for(int i=0;i<size;i++){
		if(gpu_state->autocorrs.index>=MAX_GPU_AUTOCORRS) return;//R: no best update or new signals logging allowed after overflow
		if(PowerBin[i].x>gpu_state->autocorrs.autocorr[0].power){//R: best autocorr update
			gpu_state->autocorrs.autocorr[0].power=PowerBin[i].x;
			gpu_state->autocorrs.autocorr[0].bin=PowerBin[i].y;
			gpu_state->autocorrs.autocorr[0].fft_ind=i;
			gpu_state->autocorrs.autocorr[0].icfft=gpu_state->icfft;
		}
		if(PowerBin[i].x>gpu_state->autocorrs.threshold){//R: logging new signal in next slot
			gpu_state->autocorrs.index++;//R: in case of multi-workitem kernel should be atomic
			int idx=gpu_state->autocorrs.index;
			gpu_state->autocorrs.autocorr[idx].power=PowerBin[i].x;
			gpu_state->autocorrs.autocorr[idx].bin=PowerBin[i].y;
			gpu_state->autocorrs.autocorr[idx].fft_ind=i;
			gpu_state->autocorrs.autocorr[idx].icfft=gpu_state->icfft;
		}

	}
}
#endif
__kernel __attribute__((vec_type_hint(float4)))
void PC_find_spike_reduce0_kernel_cl(__global float4* PowerSpectrum, __global float4* tmp, uint fftlen){
	//R: CUDA version of this kernel use shared memory and reducing, HD4xxx have no shared memory so I will
	//do whole power array per workitem.
	uint tid= get_global_id(0);
	uint y=get_global_id(1);
	float4 sum4=(float4)0.f;
	float maxval=0.f;
	float pos=0.f;//R: should be integer value but will use float for better memory packing
	float4 sum_val_pos;
	float4 p;
	int i=0;

	//R: separate handling of first quad - DC element should be omitted
	if(y==0){
		p=PowerSpectrum[tid*(fftlen>>2)];
		sum4.x=p.x;
		sum4.y=p.y;
		sum4.z=p.z;
		sum4.w=p.w;
		if(p.y>maxval){pos=1;}
		maxval=max(maxval,p.y);
		if(p.z>maxval){pos=2;}
		maxval=max(maxval,p.z);
		if(p.w>maxval){pos=3;}
		maxval=max(maxval,p.w);
		i=1;
	}
	for(;i<(64);i++){
		p=PowerSpectrum[i+y*64+tid*(fftlen>>2)];//R:doing 4 elements at once
		sum4+=p;
		if(p.x>maxval){pos=i*4;}
		maxval=max(maxval,p.x);
		if(p.y>maxval){pos=i*4+1;}
		maxval=max(maxval,p.y);
		if(p.z>maxval){pos=i*4+2;}
		maxval=max(maxval,p.z);
		if(p.w>maxval){pos=i*4+3;}
		maxval=max(maxval,p.w);
	}
	sum_val_pos.x=sum4.x+sum4.y+sum4.z+sum4.w;
	sum_val_pos.y=maxval;
	sum_val_pos.z=pos+256*y;
	//R: w field not used
	tmp[tid*(fftlen>>8)+y]=sum_val_pos;
}
__kernel __attribute__((vec_type_hint(float4)))
void PC_find_spike_reduce1_kernel_cl(__global float4* tmp, __global float* MeanMaxIdx, uint fftlen){
	//R: CUDA version of this kernel use shared memory and reducing, HD4xxx have no shared memory so I will
	//do whole power array per workitem.
	uint tid= get_global_id(0);
	//float mean=0.f;
	float sum=0.f;
	float maxval=0.f;
	float pos=0.f;//R: should be integer value but will use float for better memory packing
	//float4 mmi;
	float4 sum_val_pos;
	for(uint y=0;y<(fftlen>>8);y++){
		sum_val_pos=tmp[y+tid*(fftlen>>8)];
		sum+=sum_val_pos.x;
		if(sum_val_pos.y>maxval){pos=sum_val_pos.z;}
		maxval=max(maxval,sum_val_pos.y);
	}
	float power=maxval*fftlen/sum;
	//mmi.x=mean;
	//mmi.y=maxval;
	//mmi.z=pos;
	//R: w field not used
	MeanMaxIdx[2*tid]=power;//mmi.x;
	MeanMaxIdx[2*tid+1]=pos;//mmi.y;
	//MeanMaxIdx[3*tid+2]=mmi.z;
	//float power=maxval/mean;
	//float score=log10(power/40);
	//if(score>best || power>spike_thresh){
	//	result_flag[0].x=1;//R: only in this case kernel results are needed
	//}
}


__kernel __attribute__((vec_type_hint(float4)))
void Transpose4_kernel_cl(__global float4* in, __global float4* out,uint x_size,uint y_size){
	//R: ATI HD4xxx has no cache exposed in OpenCL so do single possible memory optimization - vector reads in register file.
	//R: x_size matrix width, y_size - matrix heigh
	uint tidx= get_global_id(0);
	uint tidy= get_global_id(1);
	float4 d0=in[tidx+(x_size>>2)*(tidy<<2)];
	float4 d1=in[tidx+(x_size>>2)*((tidy<<2)+1)];
	float4 d2=in[tidx+(x_size>>2)*((tidy<<2)+2)];
	float4 d3=in[tidx+(x_size>>2)*((tidy<<2)+3)];
	float4 o0,o1,o2,o3;
	o0.x=d0.x;o0.y=d1.x;o0.z=d2.x;o0.w=d3.x;
	o1.x=d0.y;o1.y=d1.y;o1.z=d2.y;o1.w=d3.y;
	o2.x=d0.z;o2.y=d1.z;o2.z=d2.z;o2.w=d3.z;
	o3.x=d0.w;o3.y=d1.w;o3.z=d2.w;o3.w=d3.w;
	out[tidy+(y_size>>2)*(tidx<<2)]=o0;
	out[tidy+(y_size>>2)*((tidx<<2)+1)]=o1;
	out[tidy+(y_size>>2)*((tidx<<2)+2)]=o2;
	out[tidy+(y_size>>2)*((tidx<<2)+3)]=o3;
}


typedef struct {
    int iSigma;
    int gauss_pot_length;
    float GaussPowerThresh;
    float GaussPeakPowerThresh3;
    float GaussPeakPowerThresh;
	float GaussSigmaSq;
    int GaussTOffsetStart;
    int GaussTOffsetStop;
    float PeakScaleFactor;
    float GaussChiSqThresh;
    float gauss_null_chi_sq_thresh;
	float gauss_chi_sq_thresh;
//	float* dev_PoT;
//    float* dev_PoTPrefixSum;
//    float* dev_PowerSpectrum;
//    float4* dev_GaussFitResults;
//    float4* dev_GaussFitResultsReordered;
//    float4* dev_GaussFitResultsReordered2;
//    float* dev_NormMaxPower;
//    float* dev_outputposition;
	float score_offset;
	int temp_size;
    int NumDataPoints;
//	float f_weight[CUDA_ACC_MAX_GaussTOffsetStop]; // cached  static_cast<float>(EXP(i, 0, PoTInfo.GaussSigmaSq));
//    unsigned int nsamples;
} ocl_GaussFit_t;

#if !__APPLE__
__kernel __attribute__((vec_type_hint(float4)))
void GetFixedPoT_kernel_cl(
	__global float4* power, __global float4* PoT,int fftlen, __constant ocl_GaussFit_t* settings
	) {
	int ul_PoT_i  = get_global_id(0);//R: dots position in single PoT array (0 to gauss_pot_length)
	int ul_PoT = get_global_id(1);//R: index of PoT array (there are fflen/4 (each workitem handles 1 dot for 4 PoT arrays) number of such arrays, each 64 points wide)

	int
		//ul_PoTChunkSize,
		ul_PoTChunk_i,
		ul_PoTChunkLimit,
		//tPowerLen;//R: length of transposed power array

	//tPowerLen = 1024*1024 / fftlen;//R: we have 1M of dots in initial power 2D matrix
	//ul_PoTChunkSize  = tPowerLen / gauss_pot_length;//R: for now PoT array size for Gauss fitting is 64, this size in dots, not dots4
		ul_PoTChunkSize=settings->temp_size/fftlen;
	// If the number of spectra is greater than the number
	// of elements in a PoT array, we add sum adjacent spectra
	// into PoT elements.
	// ul_PoTChunkSize indicates how many time-wise
	// power spectra bins are added together to make one PoT bin.

	ul_PoTChunk_i = ul_PoTChunkSize * ul_PoT_i;
	ul_PoTChunkLimit = ul_PoTChunk_i + ul_PoTChunkSize;

	float4 sum = (float4)0.0f;
	for (; ul_PoTChunk_i < ul_PoTChunkLimit; ul_PoTChunk_i++) {
		sum += power[(fftlen>>2)*ul_PoTChunk_i+ul_PoT];
	}
	PoT[ul_PoT_i*(fftlen>>2)+ul_PoT] = sum;
}
#else //R: Alternate kernel variant with maybe increased precision (looks like OSX OpenCL requires this path)
__kernel __attribute__((vec_type_hint(float4)))
void GetFixedPoT_kernel_cl(
	__global float4* power, __global float4* PoT,int fftlen, __constant ocl_GaussFit_t* settings
	) {
	int ul_PoT_i  = get_global_id(0);//R: dots position in single PoT array (0 to gauss_pot_length)
	int ul_PoT = get_global_id(1);//R: index of PoT array (there are fflen/4 (each workitem handles 1 dot for 4 PoT arrays) number of such arrays, each 64 points wide)

	int
		//ul_PoTChunkSize,
		ul_PoTChunk_i,
		//ul_PoTChunkLimit,
		//tPowerLen;//R: length of transposed power array

	//tPowerLen = 1024*1024 / fftlen;//R: we have 1M of dots in initial power 2D matrix
	//ul_PoTChunkSize  = tPowerLen / gauss_pot_length;//R: for now PoT array size for Gauss fitting is 64, this size in dots, not dots4
		ul_PoTChunkSize=settings->temp_size/fftlen;
	// If the number of spectra is greater than the number
	// of elements in a PoT array, we add sum adjacent spectra
	// into PoT elements.
	// ul_PoTChunkSize indicates how many time-wise
	// power spectra bins are added together to make one PoT bin.
	int block_num=(ul_PoTChunkSize>128)?(ul_PoTChunkSize>>7):1;
	int block_size=(ul_PoTChunkSize>128)?128:ul_PoTChunkSize;
	ul_PoTChunk_i = ul_PoTChunkSize * ul_PoT_i;
	//ul_PoTChunkLimit = ul_PoTChunk_i + ul_PoTChunkSize;

	float4 sum = (float4)0.0f;
	float4 partial_sum=(float4)0.0f;
	for (int i=0; i<block_num;i++){
			for(int j=0;j<block_size;j++)
				partial_sum += power[(fftlen>>2)*(ul_PoTChunk_i+i*block_size+j)+ul_PoT];
			sum+=partial_sum;
			partial_sum= (float4)0.0f;
	}
	PoT[ul_PoT_i*(fftlen>>2)+ul_PoT] = sum;
}
#endif

//R: TODO check if pre-check should be added in Normalize kernel to skip some areas of PoT matrix
__kernel __attribute__((vec_type_hint(float4)))
void NormalizePoT_kernel_cl(int ul_FftLength,__global float4* PoT,
									 __global float4* PoTPrefixSum, __global float4* NormMaxPower,
									 __constant ocl_GaussFit_t* settings) {
	int tid= get_global_id(0);//R: should be from 0 to ul_FftLength/4
//R: do 4 PoT arrays at once
//TODO: try to allocate private array of gauss_pot_length float4 elements in register file to eliminate secondary read from
//global memory. But check of assembly output required to make sure private array not spilled into global memory
	float4 TotalPower = (float4)0.0f;
	int gauss_pot_length=settings->gauss_pot_length;
	for (int i = 0; i < gauss_pot_length; i++) {
		TotalPower += PoT[i * (ul_FftLength>>2)+tid];
	}
	float4 MeanPower = TotalPower / (float4)gauss_pot_length;

	// Normalize power-of-time
	float4 sum = (float4)0.0f;
	float4 NormMaxPower_i = (float4)0.0f;
	for (int i = 0; i < gauss_pot_length; i++) {
		float4 PoTi = PoT[i * (ul_FftLength>>2)+tid] /MeanPower;
		NormMaxPower_i = max(NormMaxPower_i, PoTi);
		sum += PoTi;
		PoT[i * (ul_FftLength>>2)+tid] = PoTi;
		PoTPrefixSum[i * (ul_FftLength>>2)+tid] = sum;
	}
	NormMaxPower[tid] = NormMaxPower_i;
}




__kernel __attribute__((vec_type_hint(float4)))
void NormalizePoT_peak_PC_kernel_cl(int ul_FftLength,__global float4* PoT,
									 __global float4* PoTPrefixSum, __global float4* NormMaxPower,
									 __constant ocl_GaussFit_t* settings,__global uint* WeakPeaks) {
	int tid= get_global_id(0);//R: should be from 0 to ul_FftLength/4
//R: do 4 PoT arrays at once
//TODO: try to allocate private array of 64 float4 elements in register file to eliminate secondary read from
//global memory. But check of assembly output required to make sure private array not spilled into global memory
	float4 TotalPower = (float4)0.0f;
	int gauss_pot_length=settings->gauss_pot_length;
	for (int i = 0; i < gauss_pot_length; i++) {
		TotalPower += PoT[i * (ul_FftLength>>2)+tid];
	}
	float4 MeanPower = TotalPower / (float4)gauss_pot_length;

	// Normalize power-of-time
	float4 sum = (float4)0.0f;
	float4 NormMaxPower_i = (float4)0.0f;
	for (int i = 0; i < gauss_pot_length; i++) {
		float4 PoTi = PoT[i * (ul_FftLength>>2)+tid] /MeanPower;
		NormMaxPower_i = max(NormMaxPower_i, PoTi);
		sum += PoTi;
		PoT[i * (ul_FftLength>>2)+tid] = PoTi;
		PoTPrefixSum[i * (ul_FftLength>>2)+tid] = sum;
	}
	NormMaxPower[tid] = NormMaxPower_i;
	float thresh=settings->GaussPowerThresh;
#if !__APPLE__
	if(NormMaxPower_i.x>thresh || NormMaxPower_i.y>thresh ||
		NormMaxPower_i.z>thresh || NormMaxPower_i.w>thresh)	WeakPeaks[tid]=1;
#else
	//uje: alternate signal test can be faster
	if (NormMaxPower_i.x > thresh) WeakPeaks[tid]=1;
	else if (NormMaxPower_i.y > thresh) WeakPeaks[tid]=1;
	else if (NormMaxPower_i.z > thresh) WeakPeaks[tid]=1;
	else if (NormMaxPower_i.w > thresh) WeakPeaks[tid]=1;
#endif
	else WeakPeaks[tid]=0;
}




#if SETI7_GBT
	#define GAUSS_POT_LENGTH 128
	#define GAUSS_POT_LENGTH_F (128.0f)
	float gammln(float a) {
		//R: only 63 or 63.5 values for a so use precomputd gammln(a) here.
		return (a==63.f)?196.86618167296356f:198.93576493000361f;
	}
#elif SETI7_2x2
	#define GAUSS_POT_LENGTH 128
	#define GAUSS_POT_LENGTH_F (128.0f)
	float gammln(float a) {
		//R: only 63 or 63.5 values for a so use precomputd gammln(a) here.
		return (a==63.f)?196.86618167296356f:198.93576493000361f;
	}
#elif SETI7_UNKNOWN_SIZE
//R: size of gaussian array unknown
	float gammln(float a) {
	float x,y,tmp,ser;
	float cof[6]={76.18009172947146f,-86.50532032941677f,
		24.01409824083091f,-1.231739572450155f,
		0.1208650973866179e-2f,-0.5395239384953e-5f};

	y=x=a;
	tmp=x+5.5f;
	tmp -= (x+0.5f)*log(tmp);
	ser=1.000000000190015f;
	for (int j=0;j<=5;j++){y+=1.f; ser += cof[j]/y;}
	return (float)(-tmp+log(2.5066282746310005f*ser/x));
}
#else
	#define GAUSS_POT_LENGTH 64
	#define GAUSS_POT_LENGTH_F (64.0f)
	float gammln(float a) {
		//R: only 31 or 31.5 values for a so use precomputd gammln(a) here.
		return (a==31.f)?74.658233642578125f:76.371200561523437f;
	}
#endif

#define ITMAX 10000  // Needs to be a few times the sqrt of the max. input to lcgf
//R: this function called only from device
//R: wlll process 4 PoTs at once as whole ATI OpenCL gauss search chain does - memory access optimization and better computing density
float4 GetTrueMean2(__global float4* fp_PoTPrefixSum, int ul_TOffset, int ul_ExcludeLen, int ul_FftLength,int tid,
					int gauss_pot_length) {
	// TrueMean is the mean power of the data set minus all power
	// out to ExcludeLen from our current TOffset.
	int i_start, i_lim;
	float4 f_ExcludePower;

	// take care that we do not add to exclude power beyond PoT bounds!
	i_start = max(ul_TOffset - ul_ExcludeLen, 0) - 1;
	i_lim = min(ul_TOffset + ul_ExcludeLen + 1, gauss_pot_length) - 1;

	f_ExcludePower = fp_PoTPrefixSum[i_lim * (ul_FftLength>>2)+tid];
	if (i_start >= 0)
		f_ExcludePower -= fp_PoTPrefixSum[i_start * (ul_FftLength>>2)+tid];

	return(((float4)(gauss_pot_length) - f_ExcludePower) / (float4)(gauss_pot_length - (i_lim - i_start)));
}
float4 GetPeak(__global float4* fp_PoT, int ul_TOffset, int ul_HalfSumLength,
					   float4 f_MeanPower, float f_PeakScaleFactor, int ul_FftLength,int tid,__constant float* f_weight) {
	// Peak power is calculated as the weighted
	// sum of all powers within ul_HalfSumLength
	// of the assumed gaussian peak.
	// The weights are given by the gaussian function itself.
	// BUG WATCH : for the f_PeakScaleFactor to work,
	// ul_HalfSumLength *must* be set to sigma.

	int i;
	float4 f_sum=(float4)0.0f;

	// Find a weighted sum
	for (i = ul_TOffset - ul_HalfSumLength; i <= ul_TOffset + ul_HalfSumLength; i++) {
		f_sum += (fp_PoT[i * (ul_FftLength>>2)+tid] - f_MeanPower) * f_weight[abs(i-ul_TOffset)];
	}
	return(f_sum * (float4)f_PeakScaleFactor);
}

float4 GetChiSq(__global float4* fp_PoT, int ul_FftLength,int ul_TOffset,
				float4 f_PeakPower, float4 f_MeanPower, float4* xsq_null,int tid,__constant float* f_weight,
				int gauss_pot_length,int NumDataPoints) {
	// We calculate our assumed gaussian powers
	// on the fly as we try to fit them to the
	// actual powers at each point along the PoT.

	float4 f_ChiSq = (float4)0.0f, f_null_hyp=(float4)0.0f;
	float rebin = NumDataPoints / (ul_FftLength * gauss_pot_length);

	float4 recip_MeanPower = (float4)1.0f / f_MeanPower;
	for (int i = 0; i < gauss_pot_length; ++i) {
		float4 f_PredictedPower = f_MeanPower + f_PeakPower * (float4)f_weight[abs(i - ul_TOffset)];
		f_PredictedPower *= recip_MeanPower;

		// ChiSq in this realm is:
		//  sum[0:i]( (observed power - expected power)^2 / expected variance )
		// The power of a signal is:
		//  power = (noise + signal)^2 = noise^2 + signal^2 + 2*noise*signal
		// With mean power normalization, noise becomes 1, leaving:
		//  power = signal^2 +or- 2*signal + 1
		float4 noise=2.0f*sqrt(max(f_PredictedPower,1.0f)-1.0f)+1.0f;
		float4 recip_noise = (float4)rebin / noise;

		float4 PoTval = fp_PoT[i * (ul_FftLength>>2)+tid] * recip_MeanPower;
		f_ChiSq += (recip_noise*(PoTval - f_PredictedPower)*(PoTval - f_PredictedPower));
		f_null_hyp+= (recip_noise*(PoTval - 1.0f)*(PoTval - 1.0f));
	}

	f_ChiSq/=(float4)(gauss_pot_length);
	f_null_hyp/=(float4)(gauss_pot_length);

	(*xsq_null)=f_null_hyp;
	return f_ChiSq;
}
float4 lcgf(float a, float4 x) {
	const float EPS= 1.19209e-006f; //007;//std::numeric_limits<double>::epsilon();
	const float FPMIN= 9.86076e-031f; //032;//std::numeric_limits<double>::min()/EPS;
	float4 an,b,c,d,del,h;
	float gln=gammln(a);

	b=x+(float4)(1.0f-a);
	c=(float4)(1.0f/FPMIN);
	d=(float4)1.0f/b;
	h=d;
	for (int i=1;i<=ITMAX;++i) {
		an = -i*((float)i-a);
		b += (float4)2.0f;
		d=an*d+b;
		if (fabs(d.x)<FPMIN) d.x=FPMIN;
		if (fabs(d.y)<FPMIN) d.y=FPMIN;
		if (fabs(d.z)<FPMIN) d.z=FPMIN;
		if (fabs(d.w)<FPMIN) d.w=FPMIN;
		c=b+an/c;
		if (fabs(c.x)<FPMIN) c.x=FPMIN;
		if (fabs(c.y)<FPMIN) c.y=FPMIN;
		if (fabs(c.z)<FPMIN) c.z=FPMIN;
		if (fabs(c.w)<FPMIN) c.w=FPMIN;
		d=(float4)1.0f/d;
		del=d*c;
		h*=del;
		if (fabs(del.x-1.0f)<EPS && fabs(del.y-1.0f)<EPS && fabs(del.z-1.0f)<EPS && fabs(del.w-1.0f)<EPS) break;
	}

	return (log(h)-x+a*log(x)-(float4)gln);
}

float4 calc_GaussFit_score(float4 chisqr, float4 null_chisqr,float score_offset,int gauss_pot_length) {
	float gauss_bins = (float)gauss_pot_length;
	float gauss_dof = (gauss_bins-2.0f) * 0.5f;
	float null_dof = (gauss_bins-1.0f) * 0.5f;
	gauss_bins *= 0.5f;
	return  score_offset +
		lcgf(gauss_dof,max(chisqr*gauss_bins,(float4)(gauss_dof+1.0f)))
		//-cudaAcc_lcgf(gauss_dof,cudaAcc_GaussFit_settings.gauss_chi_sq_thresh*gauss_bins) // <- always the same result
		-lcgf(null_dof,max(null_chisqr*gauss_bins,null_dof+1.0f));
		//+cudaAcc_lcgf(null_dof,cudaAcc_GaussFit_settings.gauss_null_chi_sq_thresh*gauss_bins); // <- always the same result
}
float GetTrueMean2_fl(__global float* fp_PoTPrefixSum, int ul_TOffset, int ul_ExcludeLen, int ul_FftLength,int tid,
					  int gauss_pot_length) {
	// TrueMean is the mean power of the data set minus all power
	// out to ExcludeLen from our current TOffset.
	int i_start, i_lim;
	float f_ExcludePower;

	// take care that we do not add to exclude power beyond PoT bounds!
	i_start = max(ul_TOffset - ul_ExcludeLen, 0) - 1;
	i_lim = min(ul_TOffset + ul_ExcludeLen + 1, gauss_pot_length) - 1;

	f_ExcludePower = fp_PoTPrefixSum[i_lim * (ul_FftLength)+tid];
	if (i_start >= 0)
		f_ExcludePower -= fp_PoTPrefixSum[i_start * (ul_FftLength)+tid];

	return(((float)(gauss_pot_length) - f_ExcludePower) / (float)(gauss_pot_length - (i_lim - i_start)));
}
float GetPeak_fl(__global float* fp_PoT, int ul_TOffset, int ul_HalfSumLength,
					   float f_MeanPower, float f_PeakScaleFactor, int ul_FftLength,int tid,__constant float* f_weight) {
	// Peak power is calculated as the weighted
	// sum of all powers within ul_HalfSumLength
	// of the assumed gaussian peak.
	// The weights are given by the gaussian function itself.
	// BUG WATCH : for the f_PeakScaleFactor to work,
	// ul_HalfSumLength *must* be set to sigma.

	int i;
	float f_sum=(float)0.0f;

	// Find a weighted sum
	for (i = ul_TOffset - ul_HalfSumLength; i <= ul_TOffset + ul_HalfSumLength; i++) {
		f_sum += (fp_PoT[i * (ul_FftLength)+tid] - f_MeanPower) * f_weight[abs(i-ul_TOffset)];
	}
	return(f_sum * f_PeakScaleFactor);
}

float GetChiSq_fl(__global float* fp_PoT, int ul_FftLength,int ul_TOffset,
				float f_PeakPower, float f_MeanPower, float* xsq_null,int tid,__constant float* f_weight,
				int gauss_pot_length,int NumDataPoints) {
	// We calculate our assumed gaussian powers
	// on the fly as we try to fit them to the
	// actual powers at each point along the PoT.

	float f_ChiSq = (float)0.0f, f_null_hyp=(float)0.0f;
	float rebin = NumDataPoints / (ul_FftLength * gauss_pot_length);

	float recip_MeanPower = (float)1.0f / f_MeanPower;
	for (int i = 0; i < gauss_pot_length; ++i) {
		float f_PredictedPower = f_MeanPower + f_PeakPower * (float)f_weight[abs(i - ul_TOffset)];
		f_PredictedPower *= recip_MeanPower;

		// ChiSq in this realm is:
		//  sum[0:i]( (observed power - expected power)^2 / expected variance )
		// The power of a signal is:
		//  power = (noise + signal)^2 = noise^2 + signal^2 + 2*noise*signal
		// With mean power normalization, noise becomes 1, leaving:
		//  power = signal^2 +or- 2*signal + 1
		float noise=2.0f*sqrt(max(f_PredictedPower,1.0f)-1.0f)+1.0f;
		float recip_noise = (float)rebin / noise;

		float PoTval = fp_PoT[i * (ul_FftLength)+tid] * recip_MeanPower;
		f_ChiSq += (recip_noise*(PoTval - f_PredictedPower)*(PoTval - f_PredictedPower));
		f_null_hyp+= (recip_noise*(PoTval - 1.0f)*(PoTval - 1.0f));
	}

	f_ChiSq/=(float)(gauss_pot_length);
	f_null_hyp/=(float)(gauss_pot_length);

	(*xsq_null)=f_null_hyp;
	return f_ChiSq;
}
float lcgf_fl(float a, float x) {
	const float EPS= 1.19209e-006f; //007;//std::numeric_limits<double>::epsilon();
	const float FPMIN= 9.86076e-031f; //032;//std::numeric_limits<double>::min()/EPS;
	float an,b,c,d,del,h;
	float gln=gammln(a);

	b=x+(float)(1.0f-a);
	c=(float)(1.0f/FPMIN);
	d=(float)1.0f/b;
	h=d;
	for (int i=1;i<=ITMAX;++i) {
		an = -i*((float)i-a);
		b += (float)2.0f;
		d=an*d+b;
		if (fabs(d)<FPMIN) d=FPMIN;
		c=b+an/c;
		if (fabs(c)<FPMIN) c=FPMIN;
		d=(float)1.0f/d;
		del=d*c;
		h*=del;
		if (fabs(del-1.0f)<EPS) break;
	}

	return (log(h)-x+a*log(x)-(float)gln);
}

float calc_GaussFit_score_fl(float chisqr, float null_chisqr,float score_offset,int gauss_pot_length) {
	float gauss_bins = (float)gauss_pot_length;
	float gauss_dof = (gauss_bins-2.0f) * 0.5f;
	float null_dof = (gauss_bins-1.0f) * 0.5f;
	gauss_bins *= 0.5f;
	return  score_offset +
		lcgf_fl(gauss_dof,max(chisqr*gauss_bins,(float)(gauss_dof+1.0f)))
		//-cudaAcc_lcgf(gauss_dof,cudaAcc_GaussFit_settings.gauss_chi_sq_thresh*gauss_bins) // <- always the same result
		-lcgf_fl(null_dof,max(null_chisqr*gauss_bins,null_dof+1.0f));
		//+cudaAcc_lcgf(null_dof,cudaAcc_GaussFit_settings.gauss_null_chi_sq_thresh*gauss_bins); // <- always the same result
}

#if OCL_REAL_LOCAL //USE_OPENCL_NV || USE_OPENCL_HD5xxx //R: this kernel uses local memory, use it on shared memory-enabled GPUs
float GetPeak_local(__local float* fp_PoT, int ul_TOffset, int ul_HalfSumLength,
					   float f_MeanPower, float f_PeakScaleFactor, int ul_FftLength,__local float* f_weight) {
	// Peak power is calculated as the weighted
	// sum of all powers within ul_HalfSumLength
	// of the assumed gaussian peak.
	// The weights are given by the gaussian function itself.
	// BUG WATCH : for the f_PeakScaleFactor to work,
	// ul_HalfSumLength *must* be set to sigma.

	int i;
	float f_sum=(float)0.0f;

	// Find a weighted sum
	for (i = ul_TOffset - ul_HalfSumLength; i <= ul_TOffset + ul_HalfSumLength; i++) {
		f_sum += (fp_PoT[i*get_local_size(0)+get_local_id(0)] - f_MeanPower) * f_weight[abs(i-ul_TOffset)];
	}
	return(f_sum * f_PeakScaleFactor);
}
float GetChiSq_local(__local float* fp_PoT, int ul_FftLength,int ul_TOffset,
				float f_PeakPower, float f_MeanPower, float* xsq_null,__local float* f_weight,
				int gauss_pot_length,int NumDataPoints) {
	// We calculate our assumed gaussian powers
	// on the fly as we try to fit them to the
	// actual powers at each point along the PoT.

	float f_ChiSq = (float)0.0f, f_null_hyp=(float)0.0f;
	float rebin = NumDataPoints / (ul_FftLength * gauss_pot_length);

	float recip_MeanPower = (float)1.0f / f_MeanPower;
	for (int i = 0; i < gauss_pot_length; ++i) {
		float f_PredictedPower = f_MeanPower + f_PeakPower * (float)f_weight[abs(i - ul_TOffset)];
		f_PredictedPower *= recip_MeanPower;

		// ChiSq in this realm is:
		//  sum[0:i]( (observed power - expected power)^2 / expected variance )
		// The power of a signal is:
		//  power = (noise + signal)^2 = noise^2 + signal^2 + 2*noise*signal
		// With mean power normalization, noise becomes 1, leaving:
		//  power = signal^2 +or- 2*signal + 1
		float noise=2.0f*sqrt(max(f_PredictedPower,1.0f)-1.0f)+1.0f;
		float recip_noise = (float)rebin / noise;

		float PoTval = fp_PoT[i * get_local_size(0)+get_local_id(0)] * recip_MeanPower;
		f_ChiSq += (recip_noise*(PoTval - f_PredictedPower)*(PoTval - f_PredictedPower));
		f_null_hyp+= (recip_noise*(PoTval - 1.0f)*(PoTval - 1.0f));
	}

	f_ChiSq/=(float)(gauss_pot_length);
	f_null_hyp/=(float)(gauss_pot_length);

	(*xsq_null)=f_null_hyp;
	return f_ChiSq;
}
#if !defined(SIGNALS_ON_GPU)
__kernel void GaussFit_kernel_cl(__global float* PoT, __global float* PoTPrefixSum,int ul_FftLength, float best_gauss_score,
								 __constant ocl_GaussFit_t* settings,__constant float* f_weight,
								 __global uint* result_flag, __global float4* GaussFitResults,
								 __local float* p//,image2d_t gauss_cache,image2d_t null_cache
								 ) {
    int tid =  get_global_id(0);//R: from 0 to fftlen
	int ul_TOffset =  get_global_id(1) + settings->GaussTOffsetStart;//R: something less than 64
	for(int i=0;i<(GAUSS_POT_LENGTH/get_local_size(1));i++){
		p[(get_local_size(1)*i+get_local_id(1))*get_local_size(0)+get_local_id(0)]=PoT[tid+(get_local_size(1)*i+get_local_id(1))*(ul_FftLength)];
	}//R: fetch get_local_size(0) PoTs into local memory
	__local float l_weight[GAUSS_POT_LENGTH];
	int ltid=(get_local_size(0)*get_local_id(1)+get_local_id(0));
	(ltid<GAUSS_POT_LENGTH)?(l_weight[ltid]=f_weight[ltid]):false;//R: fetch weights array into local memory too
	barrier(CLK_LOCAL_MEM_FENCE);
//R: now all accesses to PoT will go into local memory.
if(ul_TOffset>=settings->GaussTOffsetStop) return;//R: we outside of possible gaussian
	float f_null_hyp;

	int iSigma = settings->iSigma;

	float 	f_TrueMean,
		f_ChiSq,
		f_PeakPower;

	// slide dynamic gaussian across the Power Of Time array

	// TrueMean is the mean power of the data set minus all power
	// out to 2 sigma from our current TOffset.
	f_TrueMean = GetTrueMean2_fl(
		PoTPrefixSum,
		ul_TOffset,
		2 * iSigma,
		ul_FftLength,tid,GAUSS_POT_LENGTH
		);

	f_PeakPower = GetPeak_local(
		p,
		ul_TOffset,
		iSigma,
		f_TrueMean,
		settings->PeakScaleFactor,
		ul_FftLength,l_weight
		);
#if 1
	// worth looking at ?
		int res=(f_PeakPower  < settings->GaussPeakPowerThresh3*f_TrueMean);
	//res&=1;
	//debug[ul_TOffset * ul_FftLength + tid]=res;
	if (res) {
		GaussFitResults[ul_TOffset * ul_FftLength + tid] = (float4)0.0f;
		return;
	}
#endif
	// look at it - try to fit
	f_ChiSq = GetChiSq_local(
		p,
		ul_FftLength,
		ul_TOffset,
		f_PeakPower,
		f_TrueMean,
		&f_null_hyp,l_weight,GAUSS_POT_LENGTH,settings->NumDataPoints
		);
	float4 tmp;

	//R: additional check to see if score needed or not
/*
	res=(f_ChiSq <=  (float4)settings->gauss_chi_sq_thresh);
	if( ((f_ChiSq.x <=  settings->GaussChiSqThresh) && (f_null_hyp.x >= settings->gauss_null_chi_sq_thresh))||
		((f_ChiSq.y <=  settings->GaussChiSqThresh) && (f_null_hyp.y >= settings->gauss_null_chi_sq_thresh)) ||
		((f_ChiSq.z <=  settings->GaussChiSqThresh) && (f_null_hyp.z >= settings->gauss_null_chi_sq_thresh)) ||
		((f_ChiSq.w <=  settings->GaussChiSqThresh) && (f_null_hyp.w >= settings->gauss_null_chi_sq_thresh))
	){
		result_flag[0].z=1;
	}
*/
#if 0
	float score = calc_GaussFit_score_cached(f_ChiSq, f_null_hyp,settings->score_offset,gauss_cache,null_cache);
#else
	float score = calc_GaussFit_score_fl(f_ChiSq, f_null_hyp,settings->score_offset,GAUSS_POT_LENGTH);
#endif
	if (((f_ChiSq <=  settings->gauss_chi_sq_thresh) && (score > best_gauss_score))
		|| ((f_ChiSq <=  settings->GaussChiSqThresh) && (f_null_hyp >= settings->gauss_null_chi_sq_thresh))
		&& (f_PeakPower  >= settings->GaussPeakPowerThresh*f_TrueMean)) {
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;//R: hot attention required to this block
		tmp.x=f_TrueMean;
		tmp.y=f_PeakPower;
		tmp.z=f_ChiSq;
		tmp.w=f_null_hyp;
	} else {
		tmp=(float4)0.0f;
	}
		GaussFitResults[ul_TOffset * ul_FftLength + tid] = tmp;
} // End of gaussfit()

#endif
__kernel void GaussFit_no_best_kernel_cl(__global float* PoT, __global float* PoTPrefixSum,int ul_FftLength,
								 __constant ocl_GaussFit_t* settings,__constant float* f_weight,
								 __global uint* result_flag, __global float4* GaussFitResults,__local float* p) {
    int tid =  get_global_id(0);//R: from 0 to fftlen
	int ul_TOffset =  get_global_id(1) + settings->GaussTOffsetStart;//R: something less than gauss_pot_length
	for(int i=0;i<(GAUSS_POT_LENGTH/get_local_size(1));i++){
		p[(get_local_size(1)*i+get_local_id(1))*get_local_size(0)+get_local_id(0)]=
			PoT[tid+(get_local_size(1)*i+get_local_id(1))*(ul_FftLength)];
	}//R: fetch get_local_size(0) PoTs into local memory
	__local float l_weight[GAUSS_POT_LENGTH];
	int ltid=(get_local_size(0)*get_local_id(1)+get_local_id(0));
	(ltid<GAUSS_POT_LENGTH)?(l_weight[ltid]=f_weight[ltid]):false;//R: fetch weights array into local memory too
	barrier(CLK_LOCAL_MEM_FENCE);
//R: now all accesses to PoT will go into local memory.
if(ul_TOffset>=settings->GaussTOffsetStop) return;//R: we outside of possible gaussian
	float f_null_hyp;

	int iSigma = settings->iSigma;

	float 	f_TrueMean,
		f_ChiSq,
		f_PeakPower;

	// slide dynamic gaussian across the Power Of Time array

	// TrueMean is the mean power of the data set minus all power
	// out to 2 sigma from our current TOffset.
	f_TrueMean = GetTrueMean2_fl(
		PoTPrefixSum,
		ul_TOffset,
		2 * iSigma,
		ul_FftLength,tid,GAUSS_POT_LENGTH
		);

	f_PeakPower = GetPeak_local(
		p,
		ul_TOffset,
		iSigma,
		f_TrueMean,
		settings->PeakScaleFactor,
		ul_FftLength,l_weight
		);
#if 1
	// worth looking at ?
	int res=(f_PeakPower < settings->GaussPeakPowerThresh*f_TrueMean);//R: no best so full threshold used
	//res&=1;
	//debug[ul_TOffset * ul_FftLength + tid]=res;
	if (res) {
		GaussFitResults[ul_TOffset * ul_FftLength + tid] = (float4)0.0f;
		//result_flag[0].w=1;
		return;
	}
#endif
	// look at it - try to fit
	f_ChiSq = GetChiSq_local(
		p,
		ul_FftLength,
		ul_TOffset,
		f_PeakPower,
		f_TrueMean,
		&f_null_hyp,l_weight,GAUSS_POT_LENGTH,settings->NumDataPoints
		);
	float4 tmp;

	if ( ((f_ChiSq <=  settings->GaussChiSqThresh) && (f_null_hyp >= settings->gauss_null_chi_sq_thresh))
		) {
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;//R: hot attention required to this block
		tmp.x=f_TrueMean;
		tmp.y=f_PeakPower;
		tmp.z=f_ChiSq;
		tmp.w=f_null_hyp;
	} else {
		tmp=(float4)0.0f;
	}
		GaussFitResults[ul_TOffset * ul_FftLength + tid] = tmp;
} // End of gaussfit()


#else //R: ATI HD4xxx kernel (non vectorized but with pre-exit enabled)
__kernel void GaussFit_kernel_cl(__global float* PoT, __global float* PoTPrefixSum,int ul_FftLength, float best_gauss_score,
								 __constant ocl_GaussFit_t* settings,__constant float* f_weight,
								 __global uint* result_flag, __global float4* GaussFitResults) {
    int tid =  get_global_id(0);//R: from 0 to fftlen
	int ul_TOffset =  get_global_id(1) + settings->GaussTOffsetStart;//R: something less than 64
	if(ul_TOffset>=settings->GaussTOffsetStop) return;//R: we outside of possible gaussian
	float f_null_hyp;

	int iSigma = settings->iSigma;

	float 	f_TrueMean,
		f_ChiSq,
		f_PeakPower;

	// slide dynamic gaussian across the Power Of Time array

	// TrueMean is the mean power of the data set minus all power
	// out to 2 sigma from our current TOffset.
	f_TrueMean = GetTrueMean2_fl(
		PoTPrefixSum,
		ul_TOffset,
		2 * iSigma,
		ul_FftLength,tid,settings->gauss_pot_length
		);

	f_PeakPower = GetPeak_fl(
		PoT,
		ul_TOffset,
		iSigma,
		f_TrueMean,
		settings->PeakScaleFactor,
		ul_FftLength,tid,f_weight
		);
#if 1
	int res;
	// worth looking at ?
	res=(f_PeakPower  < settings->GaussPeakPowerThresh3*f_TrueMean);
	//res&=1;
	//debug[ul_TOffset * ul_FftLength + tid]=res;
	if (res) {
		GaussFitResults[ul_TOffset * ul_FftLength + tid] = (float4)0.0f;
		return;
	}
#endif
	// look at it - try to fit
	f_ChiSq = GetChiSq_fl(
		PoT,
		ul_FftLength,
		ul_TOffset,
		f_PeakPower,
		f_TrueMean,
		&f_null_hyp,tid,f_weight,settings->gauss_pot_length,settings->NumDataPoints
		);
	float4 tmp;

	//R: additional check to see if score needed or not
/*
	res=(f_ChiSq <=  (float4)settings->gauss_chi_sq_thresh);
	if( ((f_ChiSq.x <=  settings->GaussChiSqThresh) && (f_null_hyp.x >= settings->gauss_null_chi_sq_thresh))||
		((f_ChiSq.y <=  settings->GaussChiSqThresh) && (f_null_hyp.y >= settings->gauss_null_chi_sq_thresh)) ||
		((f_ChiSq.z <=  settings->GaussChiSqThresh) && (f_null_hyp.z >= settings->gauss_null_chi_sq_thresh)) ||
		((f_ChiSq.w <=  settings->GaussChiSqThresh) && (f_null_hyp.w >= settings->gauss_null_chi_sq_thresh))
	){
		result_flag[0].z=1;
	}
*/
	float score = calc_GaussFit_score_fl(f_ChiSq, f_null_hyp,settings->score_offset,settings->gauss_pot_length);

	if (((f_ChiSq <=  settings->gauss_chi_sq_thresh) && (score > best_gauss_score))
		|| ((f_ChiSq <=  settings->GaussChiSqThresh) && (f_null_hyp >= settings->gauss_null_chi_sq_thresh)
		&& (f_PeakPower  >= settings->GaussPeakPowerThresh*f_TrueMean))
		){
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;//R: hot attention required to this block
		tmp.x=f_TrueMean;
		tmp.y=f_PeakPower;
		tmp.z=f_ChiSq;
		tmp.w=f_null_hyp;
	} else {
		tmp=(float4)0.0f;
	}
		GaussFitResults[ul_TOffset * ul_FftLength + tid] = tmp;
} // End of gaussfit()


__kernel void GaussFit_no_best_kernel_cl(__global float* PoT, __global float* PoTPrefixSum,int ul_FftLength,
								 __constant ocl_GaussFit_t* settings,__constant float* f_weight,
								 __global uint* result_flag, __global float4* GaussFitResults) {
    int tid =  get_global_id(0);//R: from 0 to fftlen
	int ul_TOffset =  get_global_id(1) + settings->GaussTOffsetStart;//R: something less than gauss_pot_length
	if(ul_TOffset>=settings->GaussTOffsetStop) return;//R: we outside of possible gaussian
	float f_null_hyp;

	int iSigma = settings->iSigma;

	float 	f_TrueMean,
		f_ChiSq,
		f_PeakPower;

	// slide dynamic gaussian across the Power Of Time array

	// TrueMean is the mean power of the data set minus all power
	// out to 2 sigma from our current TOffset.
	f_TrueMean = GetTrueMean2_fl(
		PoTPrefixSum,
		ul_TOffset,
		2 * iSigma,
		ul_FftLength,tid,settings->gauss_pot_length
		);

	f_PeakPower = GetPeak_fl(
		PoT,
		ul_TOffset,
		iSigma,
		f_TrueMean,
		settings->PeakScaleFactor,
		ul_FftLength,tid,f_weight
		);
#if 1
	int res;
	// worth looking at ?
	res=(f_PeakPower  < settings->GaussPeakPowerThresh*f_TrueMean); //R: no best besides reportable possible so using full threshold
	//res&=1;
	//debug[ul_TOffset * ul_FftLength + tid]=res;
	if (res) {
		GaussFitResults[ul_TOffset * ul_FftLength + tid] = (float4)0.0f;
		return;
	}
#endif
	// look at it - try to fit
	f_ChiSq = GetChiSq_fl(
		PoT,
		ul_FftLength,
		ul_TOffset,
		f_PeakPower,
		f_TrueMean,
		&f_null_hyp,tid,f_weight,settings->gauss_pot_length,settings->NumDataPoints
		);
	float4 tmp;
	if ( ((f_ChiSq <=  settings->GaussChiSqThresh) && (f_null_hyp >= settings->gauss_null_chi_sq_thresh))) {
//R: global size is power of 2 so it should be safe to perform integer division here
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;//R: hot attention required to this block
		tmp.x=f_TrueMean;
		tmp.y=f_PeakPower;
		tmp.z=f_ChiSq;
		tmp.w=f_null_hyp;
	} else {
		tmp=(float4)0.0f;
	}
		GaussFitResults[ul_TOffset * ul_FftLength + tid] = tmp;
} // End of gaussfit()



#endif
#if SIGNALS_ON_GPU
__kernel void GaussFit_SoG_kernel_PE_cl(__global float4* PoT, __global float4* PoTPrefixSum,int ul_FftLength, __global GPUState* gpu_state,
								 __constant ocl_GaussFit_t* settings,__constant float* f_weight,
								 __global uint* result_flag, __global float4* GaussFitResults,
								 __constant uint* WeakPeaks,__global float* GaussFitScores) {
//R: each workitem handles 1 dot from 4 PoTs at once.
    int tid =  get_global_id(0);//R: from 0 to fftlen/4
	int ul_TOffset =  get_global_id(1) + settings->GaussTOffsetStart;//R: something less than gauss_pot_length
//	if(ul_TOffset>=gpu_settings.GaussTOffsetStop) return;//R: we outside of possible gaussian
	__local float bscore;
	((get_local_id(0)+get_local_id(1))==0)?bscore=gpu_state->gaussians.gaussian[0].score:false;
//max(gpu_state->gaussians.bscore,gpu_state->gaussians.gaussian[0].score):false;
	bool was_reportable=(gpu_state->gaussians.index>0);
	int out=ul_TOffset * ul_FftLength + (tid<<2);
	float4 score=(float4)-12.f;
	barrier(CLK_LOCAL_MEM_FENCE);

	if(WeakPeaks[tid]==0){
		GaussFitResults[out] = (float4)0.0f;
		GaussFitResults[out+1] = (float4)0.0f;
		GaussFitResults[out+2] = (float4)0.0f;
		GaussFitResults[out+3] = (float4)0.0f;
		GaussFitScores[out]=-12.f;
		GaussFitScores[out+1]=-12.f;
		GaussFitScores[out+2]=-12.f;
		GaussFitScores[out+3]=-12.f;
		//return;//R: preliminary exit if whole 4 PoTs don't have even weak peak
	}else{
	float4 f_null_hyp;

	int iSigma = settings->iSigma;

	float4 	f_TrueMean,
		f_ChiSq,
		f_PeakPower;

	// slide dynamic gaussian across the Power Of Time array

	// TrueMean is the mean power of the data set minus all power
	// out to 2 sigma from our current TOffset.
	f_TrueMean = GetTrueMean2(
		PoTPrefixSum,
		ul_TOffset,
		2 * iSigma,
		ul_FftLength,tid,settings->gauss_pot_length
		);

	f_PeakPower = GetPeak(
		PoT,
		ul_TOffset,
		iSigma,
		f_TrueMean,
		settings->PeakScaleFactor,
		ul_FftLength,tid,f_weight
		);
	//gpu_debug[ul_TOffset * ul_FftLength + (tid<<2)]=f_PeakPower;
#if 0
//R: cause each workitem deals with 4 PoTs preliminary exit possible only when all 4 have no peak
	// worth looking at ?
	if (f_PeakPower.x / f_TrueMean.x < settings->GaussPeakPowerThresh3 && f_PeakPower.y / f_TrueMean.y < settings->GaussPeakPowerThresh3 &&
		f_PeakPower.z / f_TrueMean.z < settings->GaussPeakPowerThresh3 && f_PeakPower.w / f_TrueMean.w < settings->GaussPeakPowerThresh3) {
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)] = (float4)0.0f;
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)+1] = (float4)0.0f;
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)+2] = (float4)0.0f;
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)+3] = (float4)0.0f;
		return;
	}
#endif
	// look at it - try to fit
	f_ChiSq = GetChiSq(
		PoT,
		ul_FftLength,
		ul_TOffset,
		f_PeakPower,
		f_TrueMean,
		&f_null_hyp,tid,f_weight,settings->gauss_pot_length,settings->NumDataPoints
		);

//R: scores calculation needed only until first reportable Gaussian will be found. Use this fact.

	score = (was_reportable?(float4)-12.0f:
		calc_GaussFit_score(f_ChiSq, f_null_hyp,settings->score_offset,GAUSS_POT_LENGTH));
	float4 tmp;
	if (((f_ChiSq.x <=  settings->gauss_chi_sq_thresh) && (score.x > bscore))
		|| ((f_ChiSq.x <=  settings->GaussChiSqThresh) && (f_null_hyp.x >= settings->gauss_null_chi_sq_thresh)
		&& (f_PeakPower.x  >= settings->GaussPeakPowerThresh*f_TrueMean.x))
		) {
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;//R: hot attention required to this block
		tmp.x=f_TrueMean.x;
		tmp.y=f_PeakPower.x;
		tmp.z=f_ChiSq.x;
		tmp.w=f_null_hyp.x;
	} else {
		tmp=(float4)0.0f;
		score.x=-12.f;
	}
	GaussFitResults[out] = tmp;
	if (((f_ChiSq.y <=  settings->gauss_chi_sq_thresh) && (score.y > bscore))
		|| ((f_ChiSq.y <=  settings->GaussChiSqThresh) && (f_null_hyp.y >= settings->gauss_null_chi_sq_thresh)
		&& (f_PeakPower.y  >= settings->GaussPeakPowerThresh*f_TrueMean.y))
		) {
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;//R: hot attention required to this block
		tmp.x=f_TrueMean.y;
		tmp.y=f_PeakPower.y;
		tmp.z=f_ChiSq.y;
		tmp.w=f_null_hyp.y;
	} else {
		tmp=(float4)0.0f;
		score.y=-12.f;
	}
	GaussFitResults[out+1] = tmp;
	if (((f_ChiSq.z <=  settings->gauss_chi_sq_thresh) && (score.z > bscore))
		|| ((f_ChiSq.z <=  settings->GaussChiSqThresh) && (f_null_hyp.z >= settings->gauss_null_chi_sq_thresh)
		&& (f_PeakPower.z  >= settings->GaussPeakPowerThresh*f_TrueMean.z))
		) {
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;//R: hot attention required to this block
		tmp.x=f_TrueMean.z;
		tmp.y=f_PeakPower.z;
		tmp.z=f_ChiSq.z;
		tmp.w=f_null_hyp.z;
	} else {
		tmp=(float4)0.0f;
		score.z=-12.f;
	}
	GaussFitResults[out+2] = tmp;
	if (((f_ChiSq.w <=  settings->gauss_chi_sq_thresh) && (score.w > bscore))
		|| ((f_ChiSq.w <=  settings->GaussChiSqThresh) && (f_null_hyp.w >= settings->gauss_null_chi_sq_thresh)
		&& (f_PeakPower.w  >= settings->GaussPeakPowerThresh*f_TrueMean.w))
		) {
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;//R: hot attention required to this block
		tmp.x=f_TrueMean.w;
		tmp.y=f_PeakPower.w;
		tmp.z=f_ChiSq.w;
		tmp.w=f_null_hyp.w;
	} else {
		tmp=(float4)0.0f;
		score.w=-12.f;
	}
	GaussFitResults[out+3] = tmp;
	}
		GaussFitScores[out]=score.x;
		GaussFitScores[out+1]=score.y;
		GaussFitScores[out+2]=score.z;
		GaussFitScores[out+3]=score.w;
/*	if(!was_reportable){//R: Only if no reported Gaussians so far
		GaussFitScores[out]=score.x;
		GaussFitScores[out+1]=score.y;
		GaussFitScores[out+2]=score.z;
		GaussFitScores[out+3]=score.w;
		(tid)?score.x=max(score.x,score.y):score.y;//R: DC omitted
		score.x=max(score.x,score.z);
		score.x=max(score.x,score.w);
		bscore=max(score.x,bscore);//R; atomics would allow real best guess at cost of slower writes here
		barrier(CLK_LOCAL_MEM_FENCE);//R: TODO evaluate usage of non-barrier fence calls instead of barriers
		//R: guessed best should be little lower than real best to allow point with that real best to win
		((get_local_id(0)+get_local_id(1))==0)?gpu_state->gaussians.bscore=(bscore*0.999):false;

	}
*/
} // End of gaussfit()
__kernel void GaussFit_SoG_kernel_cl(__global float* PoT, __global float* PoTPrefixSum,int ul_FftLength, __global GPUState* gpu_state,
								 __constant ocl_GaussFit_t* settings,__constant float* f_weight,
								 __global uint* result_flag, __global float4* GaussFitResults,
								 __local float* p,__global float* GaussFitScores
								 ) {
    int tid =  get_global_id(0);//R: from 0 to fftlen
	int ul_TOffset =  get_global_id(1) + settings->GaussTOffsetStart;//R: something less than 64
	for(int i=0;i<(GAUSS_POT_LENGTH/get_local_size(1));i++){
		p[(get_local_size(1)*i+get_local_id(1))*get_local_size(0)+get_local_id(0)]=PoT[tid+(get_local_size(1)*i+get_local_id(1))*(ul_FftLength)];
	}//R: fetch get_local_size(0) PoTs into local memory
	__local float l_weight[GAUSS_POT_LENGTH];
	int ltid=(get_local_size(0)*get_local_id(1)+get_local_id(0));
	(ltid<GAUSS_POT_LENGTH)?(l_weight[ltid]=f_weight[ltid]):false;//R: fetch weights array into local memory too
//	__local float blscore[256];
	float score=-12.f;
	__local bool no_reportable;
	__local float bscore;
	if(ltid){
		no_reportable=(gpu_state->gaussians.index==0);
		(no_reportable)?bscore=gpu_state->gaussians.gaussian[0].score:false;//max(gpu_state->gaussians.bscore,gpu_state->gaussians.gaussian[0].score):false;
	}
	barrier(CLK_LOCAL_MEM_FENCE);
//R: now all accesses to PoT will go into local memory.
if(ul_TOffset<settings->GaussTOffsetStop && tid){ //R: DC PoT skipped
	float f_null_hyp;

	int iSigma = settings->iSigma;

	float 	f_TrueMean,
		f_ChiSq,
		f_PeakPower;

	// slide dynamic gaussian across the Power Of Time array

	// TrueMean is the mean power of the data set minus all power
	// out to 2 sigma from our current TOffset.
	f_TrueMean = GetTrueMean2_fl(
		PoTPrefixSum,
		ul_TOffset,
		2 * iSigma,
		ul_FftLength,tid,GAUSS_POT_LENGTH
		);

	f_PeakPower = GetPeak_local(
		p,
		ul_TOffset,
		iSigma,
		f_TrueMean,
		settings->PeakScaleFactor,
		ul_FftLength,l_weight
		);

	int out=ul_TOffset * ul_FftLength + tid;

	// worth looking at ?
	if(f_PeakPower  < settings->GaussPeakPowerThresh3*f_TrueMean || !no_reportable&&(f_PeakPower  < settings->GaussPeakPowerThresh*f_TrueMean)){
		GaussFitResults[out] = (float4)0.0f;
	}else{
	// look at it - try to fit
	f_ChiSq = GetChiSq_local(
		p,
		ul_FftLength,
		ul_TOffset,
		f_PeakPower,
		f_TrueMean,
		&f_null_hyp,l_weight,GAUSS_POT_LENGTH,settings->NumDataPoints
		);
	float4 tmp;

//R: scores calculation needed only until first reportable Gaussian will be found. Use this fact.
	score=(no_reportable?calc_GaussFit_score_fl(f_ChiSq, f_null_hyp,settings->score_offset,GAUSS_POT_LENGTH):-12.0f);
		if ( ((f_ChiSq <=  settings->GaussChiSqThresh) && (f_null_hyp >= settings->gauss_null_chi_sq_thresh))
			&& (f_PeakPower  >= settings->GaussPeakPowerThresh*f_TrueMean)||
			( no_reportable && (score > bscore) && (f_ChiSq <=  settings->gauss_chi_sq_thresh) )
		) {
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;// hot attention required to this block
		tmp.x=f_TrueMean;
		tmp.y=f_PeakPower;
		tmp.z=f_ChiSq;
		tmp.w=f_null_hyp;
	} else {
		tmp=(float4)0.0f;
		score=-12.f;
	}
	GaussFitResults[out] = tmp;
	//(!was_reportable)?GaussFitScores[out]=score:false;
	GaussFitScores[out]=score; //R: easier for GPU to write always
	}
}
/*	if(no_reportable){//R: Only if no reported Gaussians so far
		blscore[ltid]=score;
		for(int i=((get_local_size(0)*get_local_size(1))>>1); i>0;i>>=1){
			barrier(CLK_LOCAL_MEM_FENCE);
			if(ltid<i){
				blscore[ltid]=max(blscore[ltid],blscore[ltid+i]);
			}
		}
		barrier(CLK_LOCAL_MEM_FENCE);
		(ltid==0 && blscore[0]>bscore)?gpu_state->gaussians.bscore=(blscore[0]*0.999f):false;
		//(ltid==0 && score>bscore)?gpu_state->gaussians.bscore=(score*0.999f):false;
	}
*/

} // End of gaussfit()

__kernel void Gaussian_logging_kernel(__global float* PoT, __global float* NormMaxPower,int ul_FftLength,
								__constant ocl_GaussFit_t* settings, __global uint* result_flag,
								__global float4* GaussFitResults,__global GPUState* gpu_state,__global float* GaussFitScores){
	//__local float bpot[GAUSSIAN_POT_LENGTH];//R: could be in registers, but compilers like to spill too large register arrays
	int bfft_ind;
	int bbin;
	float bpower;
	float bmean;
	float bchi;
	float bnul;
	//float bmax;
	float bscore=-12.f;
	int idx;
	int start=settings->GaussTOffsetStart;
	int stop=settings->GaussTOffsetStop;
	int stride=(RESULT_SIZE>ul_FftLength?1:ul_FftLength/RESULT_SIZE);
	for(int i=0;i<(RESULT_SIZE>ul_FftLength?ul_FftLength:RESULT_SIZE);i++)if(result_flag[i]==1){
		result_flag[i]=0;
		bscore=gpu_state->gaussians.gaussian[0].score;
			//max(gpu_state->gaussians.bscore,gpu_state->gaussians.gaussian[0].score);//R take "best"
		idx=gpu_state->gaussians.index;
		for(int j=max(i*stride,1);j<(i+1)*stride;j++){//R: DC PoT always skipped in Gaussian search
			for(int k=start;k<stop;k++){
				if(idx>=MAX_GPU_GAUSSIANS){//R: update global mem data and return on overflow
						gpu_state->gaussians.index=idx;
						//gpu_state->gaussians.bscore=bscore;//R: to this point real best should be logged so no need to reduce guessed best
						if(bscore>gpu_state->gaussians.gaussian[0].score){//R: best gaussian update in global memory
							gpu_state->gaussians.gaussian[0].score=bscore;
							gpu_state->gaussians.gaussian[0].icfft=gpu_state->icfft;
							gpu_state->gaussians.gaussian[0].fft_ind=bfft_ind;
							gpu_state->gaussians.gaussian[0].bin=bbin;
							gpu_state->gaussians.gaussian[0].peak_power=bpower;
							gpu_state->gaussians.gaussian[0].mean_power=bmean;
							gpu_state->gaussians.gaussian[0].chisqr=bchi;
							gpu_state->gaussians.gaussian[0].null_chisqr=bnul;
							gpu_state->gaussians.gaussian[0].max_power=NormMaxPower[bbin];
							for(int m=0;m<GAUSSIAN_POT_LENGTH;m++)gpu_state->gaussians.gaussian[0].pot[m]=PoT[m*ul_FftLength+bbin];
						}
						return;
				}
				int coord=ul_FftLength*k+j;
				float4 tmp=GaussFitResults[coord];
				if(tmp.x==0.0f)continue;//R: nothing here
				float score = (idx?-12.f:GaussFitScores[coord]);
				//R: best update
				if( (score > bscore)&&(tmp.z<=settings->gauss_chi_sq_thresh) ){
					bscore=score;
					bfft_ind=k;
					bbin=j;
					bpower=tmp.y;
					bmean=tmp.x;
					bchi=tmp.z;
					bnul=tmp.w;
					//bmax=NormMaxPower[j];
					//for(int m=0;m<GAUSSIAN_POT_LENGTH;m++)bpot[m]=PoT[m*ul_FftLength+j];
				}
				//R: new gaussian logging
				if( (tmp.z<=settings->GaussChiSqThresh) && (tmp.w >= settings->gauss_null_chi_sq_thresh) &&
					(tmp.y>=tmp.x*settings->GaussPeakPowerThresh)){
					idx++;
					//gpu_state->gaussians.gaussian[idx].score=score;
					gpu_state->gaussians.gaussian[idx].icfft=gpu_state->icfft;
					gpu_state->gaussians.gaussian[idx].fft_ind=k;
					gpu_state->gaussians.gaussian[idx].bin=j;
					gpu_state->gaussians.gaussian[idx].peak_power=tmp.y;
					gpu_state->gaussians.gaussian[idx].mean_power=tmp.x;
					gpu_state->gaussians.gaussian[idx].chisqr=tmp.z;
					gpu_state->gaussians.gaussian[idx].null_chisqr=tmp.w;
					gpu_state->gaussians.gaussian[idx].max_power=NormMaxPower[j];
					//R: TODO evaluate async workgroup copy
					for(int m=0;m<GAUSSIAN_POT_LENGTH;m++)gpu_state->gaussians.gaussian[idx].pot[m]=PoT[m*ul_FftLength+j];
				}
			}}

		if(bscore>gpu_state->gaussians.gaussian[0].score){//R: best gaussian update in global memory
			gpu_state->gaussians.gaussian[0].score=bscore;
			gpu_state->gaussians.gaussian[0].icfft=gpu_state->icfft;
			gpu_state->gaussians.gaussian[0].fft_ind=bfft_ind;
			gpu_state->gaussians.gaussian[0].bin=bbin;
			gpu_state->gaussians.gaussian[0].peak_power=bpower;
			gpu_state->gaussians.gaussian[0].mean_power=bmean;
			gpu_state->gaussians.gaussian[0].chisqr=bchi;
			gpu_state->gaussians.gaussian[0].null_chisqr=bnul;
			gpu_state->gaussians.gaussian[0].max_power=NormMaxPower[bbin];
			for(int m=0;m<GAUSSIAN_POT_LENGTH;m++)gpu_state->gaussians.gaussian[0].pot[m]=PoT[m*ul_FftLength+bbin];
		}

		gpu_state->gaussians.index=idx;
	}
}
#if 0 //R: much slower on C-60
__kernel void Gaussian_logging2_kernel(__global float* PoT, __global float* NormMaxPower,int ul_FftLength,
								__constant ocl_GaussFit_t* settings, __global uint* result_flag,
								__global float4* GaussFitResults,__global GPUState* gpu_state,__global float* GaussFitScores){
	//__local float bpot[GAUSSIAN_POT_LENGTH];//R: could be in registers, but compilers like to spill too large register arrays
	int tid=get_local_id(0);
	int bfft_ind;
	int bbin;
	float bpower;
	float bmean;
	float bchi;
	float bnul;
	//float bmax;
	float bscore=-12.f;
	int idx=0;
	int stride=(RESULT_SIZE>ul_FftLength?1:ul_FftLength/RESULT_SIZE);
	local int lidx[RESULT_SIZE];
	lidx[tid]=0;
	local int2 scoord[RESULT_SIZE][MAX_GPU_GAUSSIANS+1];//x == j; y == k; 0th == best
	scoord[tid][0].x=-1;//R: if remains @-1 - no best update for this thread
	//for(int i=0;i<(RESULT_SIZE>ul_FftLength?ul_FftLength:RESULT_SIZE);i++)
	float gscore=gpu_state->gaussians.gaussian[0].score;
	if(result_flag[tid]==1){
		result_flag[tid]=0;
		int start=settings->GaussTOffsetStart;
		int stop=settings->GaussTOffsetStop;
		bscore=gscore;
			//max(gpu_state->gaussians.bscore,gpu_state->gaussians.gaussian[0].score);//R take "best"
		idx=gpu_state->gaussians.index;
		for(int j=max(tid*stride,1);j<(tid+1)*stride;j++){//R: DC PoT always skipped in Gaussian search
			for(int k=start;k<stop;k++){
				if(idx>=MAX_GPU_GAUSSIANS)break;
				/*
				if(idx>=MAX_GPU_GAUSSIANS){//R: update global mem data and return on overflow
						gpu_state->gaussians.index=idx;
						//gpu_state->gaussians.bscore=bscore;//R: to this point real best should be logged so no need to reduce guessed best
						if(bscore>gpu_state->gaussians.gaussian[0].score){//R: best gaussian update in global memory
							gpu_state->gaussians.gaussian[0].score=bscore;
							gpu_state->gaussians.gaussian[0].icfft=gpu_state->icfft;
							gpu_state->gaussians.gaussian[0].fft_ind=bfft_ind;
							gpu_state->gaussians.gaussian[0].bin=bbin;
							gpu_state->gaussians.gaussian[0].peak_power=bpower;
							gpu_state->gaussians.gaussian[0].mean_power=bmean;
							gpu_state->gaussians.gaussian[0].chisqr=bchi;
							gpu_state->gaussians.gaussian[0].null_chisqr=bnul;
							gpu_state->gaussians.gaussian[0].max_power=NormMaxPower[bbin];
							for(int m=0;m<GAUSSIAN_POT_LENGTH;m++)gpu_state->gaussians.gaussian[0].pot[m]=PoT[m*ul_FftLength+bbin];
						}
						return;
				}
				*/
				int coord=ul_FftLength*k+j;
				float4 tmp=GaussFitResults[coord];
				if(tmp.x==0.0f)continue;//R: nothing here
				float score = (idx?-12.f:GaussFitScores[coord]);
				//R: best update
				if( (score > bscore)&&(tmp.z<=settings->gauss_chi_sq_thresh) ){
					bscore=score;
					bfft_ind=k;
					bbin=j;
					//bpower=tmp.y;
					//bmean=tmp.x;
					//bchi=tmp.z;
					//bnul=tmp.w;
					//bmax=NormMaxPower[j];
					//for(int m=0;m<GAUSSIAN_POT_LENGTH;m++)bpot[m]=PoT[m*ul_FftLength+j];
				}
				//R: new gaussian logging
				if( (tmp.z<=settings->GaussChiSqThresh) && (tmp.w >= settings->gauss_null_chi_sq_thresh) &&
					(tmp.y>=tmp.x*settings->GaussPeakPowerThresh)){
					idx++;
					//gpu_state->gaussians.gaussian[idx].score=score;
					//gpu_state->gaussians.gaussian[idx].icfft=gpu_state->icfft;
					//gpu_state->gaussians.gaussian[idx].fft_ind=k;
					//gpu_state->gaussians.gaussian[idx].bin=j;
					scoord[tid][idx].x=j;
					scoord[tid][idx].y=k;
					//gpu_state->gaussians.gaussian[idx].peak_power=tmp.y;
					//gpu_state->gaussians.gaussian[idx].mean_power=tmp.x;
					//gpu_state->gaussians.gaussian[idx].chisqr=tmp.z;
					//gpu_state->gaussians.gaussian[idx].null_chisqr=tmp.w;
					//gpu_state->gaussians.gaussian[idx].max_power=NormMaxPower[j];
					//R: TODO evaluate async workgroup copy
					//for(int m=0;m<GAUSSIAN_POT_LENGTH;m++)gpu_state->gaussians.gaussian[idx].pot[m]=PoT[m*ul_FftLength+j];
				}
			}}

		if(bscore>gscore){//R: best gaussian update in global memory
					scoord[tid][0].x=bbin;
					scoord[tid][0].y=bfft_ind;
//			gpu_state->gaussians.gaussian[0].score=bscore;
//			gpu_state->gaussians.gaussian[0].icfft=gpu_state->icfft;
//			gpu_state->gaussians.gaussian[0].fft_ind=bfft_ind;
//			gpu_state->gaussians.gaussian[0].bin=bbin;
//			gpu_state->gaussians.gaussian[0].peak_power=bpower;
//			gpu_state->gaussians.gaussian[0].mean_power=bmean;
//			gpu_state->gaussians.gaussian[0].chisqr=bchi;
//			gpu_state->gaussians.gaussian[0].null_chisqr=bnul;
//			gpu_state->gaussians.gaussian[0].max_power=NormMaxPower[bbin];
//			for(int m=0;m<GAUSSIAN_POT_LENGTH;m++)gpu_state->gaussians.gaussian[0].pot[m]=PoT[m*ul_FftLength+bbin];
		}

		//gpu_state->gaussians.index=idx;
		lidx[tid]=idx;
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	//R: here is final serial reduce
	if(tid==0){
		int gidx=gpu_state->gaussians.index;
		idx=gidx;
		bscore=gscore;
		for(int i=0;i<RESULT_SIZE;i++){
			for(int j=gidx+1;j<=lidx[i];j++){
				int coord=ul_FftLength*scoord[i][j].y+scoord[i][j].x;
				if(scoord[i][0].x!=-1 && idx==0){//R: worth to check best
					int bcoord=ul_FftLength*scoord[i][0].y+scoord[i][0].x;
					float score=GaussFitScores[bcoord];
					float4 btmp=GaussFitResults[bcoord];
					if(score>bscore){
						bscore=score;
						bfft_ind=scoord[i][0].y;
						bbin=scoord[i][0].x;
						bpower=btmp.y;
						bmean=btmp.x;
						bchi=btmp.z;
						bnul=btmp.w;
					//	bmax=NormMaxPower[j];
					//for(int m=0;m<GAUSSIAN_POT_LENGTH;m++)bpot[m]=PoT[m*ul_FftLength+j];
					}
				}
				if(idx>=MAX_GPU_GAUSSIANS){//R: update global mem data and return on overflow
						gpu_state->gaussians.index=idx;
						//gpu_state->gaussians.bscore=bscore;//R: to this point real best should be logged so no need to reduce guessed best
						if(bscore>gpu_state->gaussians.gaussian[0].score){//R: best gaussian update in global memory
							gpu_state->gaussians.gaussian[0].score=bscore;
							gpu_state->gaussians.gaussian[0].icfft=gpu_state->icfft;
							gpu_state->gaussians.gaussian[0].fft_ind=bfft_ind;
							gpu_state->gaussians.gaussian[0].bin=bbin;
							gpu_state->gaussians.gaussian[0].peak_power=bpower;
							gpu_state->gaussians.gaussian[0].mean_power=bmean;
							gpu_state->gaussians.gaussian[0].chisqr=bchi;
							gpu_state->gaussians.gaussian[0].null_chisqr=bnul;
							gpu_state->gaussians.gaussian[0].max_power=NormMaxPower[bbin];
							for(int m=0;m<GAUSSIAN_POT_LENGTH;m++)gpu_state->gaussians.gaussian[0].pot[m]=PoT[m*ul_FftLength+bbin];
						}
						return;
				}

				float4 tmp=GaussFitResults[coord];
				idx++;
				gpu_state->gaussians.gaussian[idx].score=-12.f;
				gpu_state->gaussians.gaussian[idx].icfft=gpu_state->icfft;
				gpu_state->gaussians.gaussian[idx].fft_ind=scoord[i][j].y;
				gpu_state->gaussians.gaussian[idx].bin=scoord[i][j].x;
				gpu_state->gaussians.gaussian[idx].peak_power=tmp.y;
				gpu_state->gaussians.gaussian[idx].mean_power=tmp.x;
				gpu_state->gaussians.gaussian[idx].chisqr=tmp.z;
				gpu_state->gaussians.gaussian[idx].null_chisqr=tmp.w;
				gpu_state->gaussians.gaussian[idx].max_power=NormMaxPower[scoord[i][j].x];
					//R: TODO evaluate async workgroup copy
				for(int m=0;m<GAUSSIAN_POT_LENGTH;m++)gpu_state->gaussians.gaussian[idx].pot[m]=PoT[m*ul_FftLength+scoord[i][j].x];


			}
		}
		if(bscore>gscore){
			gpu_state->gaussians.gaussian[0].score=bscore;
			gpu_state->gaussians.gaussian[0].icfft=gpu_state->icfft;
			gpu_state->gaussians.gaussian[0].fft_ind=bfft_ind;
			gpu_state->gaussians.gaussian[0].bin=bbin;
			gpu_state->gaussians.gaussian[0].peak_power=bpower;
			gpu_state->gaussians.gaussian[0].mean_power=bmean;
			gpu_state->gaussians.gaussian[0].chisqr=bchi;
			gpu_state->gaussians.gaussian[0].null_chisqr=bnul;
			gpu_state->gaussians.gaussian[0].max_power=NormMaxPower[bbin];
			for(int m=0;m<GAUSSIAN_POT_LENGTH;m++)gpu_state->gaussians.gaussian[0].pot[m]=PoT[m*ul_FftLength+bbin];
		}
		gpu_state->gaussians.index=idx;
	}
}
#endif
#else

__kernel void GaussFit_kernel_PE_cl(__global float4* PoT, __global float4* PoTPrefixSum,int ul_FftLength, float best_gauss_score,
								 __constant ocl_GaussFit_t* settings,__constant float* f_weight,
								 __global uint* result_flag, __global float4* GaussFitResults,
								 __constant uint* WeakPeaks/*,__global float4* gpu_debug*/) {
//R: each workitem handles 1 dot from 4 PoTs at once.
    int tid =  get_global_id(0);//R: from 0 to fftlen/4
	int ul_TOffset =  get_global_id(1) + settings->GaussTOffsetStart;//R: something less than gauss_pot_length
//	if(ul_TOffset>=gpu_settings.GaussTOffsetStop) return;//R: we outside of possible gaussian
	if(WeakPeaks[tid]==0){
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)] = (float4)0.0f;
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)+1] = (float4)0.0f;
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)+2] = (float4)0.0f;
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)+3] = (float4)0.0f;
		return;//R: preliminary exit if whole 4 PoTs don't have even weak peak
	}
	float4 f_null_hyp;

	int iSigma = settings->iSigma;

	float4 	f_TrueMean,
		f_ChiSq,
		f_PeakPower;

	// slide dynamic gaussian across the Power Of Time array

	// TrueMean is the mean power of the data set minus all power
	// out to 2 sigma from our current TOffset.
	f_TrueMean = GetTrueMean2(
		PoTPrefixSum,
		ul_TOffset,
		2 * iSigma,
		ul_FftLength,tid,settings->gauss_pot_length
		);

	f_PeakPower = GetPeak(
		PoT,
		ul_TOffset,
		iSigma,
		f_TrueMean,
		settings->PeakScaleFactor,
		ul_FftLength,tid,f_weight
		);
	//gpu_debug[ul_TOffset * ul_FftLength + (tid<<2)]=f_PeakPower;

#if 0
//R: cause each workitem deals with 4 PoTs preliminary exit possible only when all 4 have no peak
	// worth looking at ?
	if (f_PeakPower.x / f_TrueMean.x < settings->GaussPeakPowerThresh3 && f_PeakPower.y / f_TrueMean.y < settings->GaussPeakPowerThresh3 &&
		f_PeakPower.z / f_TrueMean.z < settings->GaussPeakPowerThresh3 && f_PeakPower.w / f_TrueMean.w < settings->GaussPeakPowerThresh3) {
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)] = (float4)0.0f;
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)+1] = (float4)0.0f;
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)+2] = (float4)0.0f;
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)+3] = (float4)0.0f;
		return;
	}
#endif
	// look at it - try to fit
	f_ChiSq = GetChiSq(
		PoT,
		ul_FftLength,
		ul_TOffset,
		f_PeakPower,
		f_TrueMean,
		&f_null_hyp,tid,f_weight,settings->gauss_pot_length,settings->NumDataPoints
		);


	float4 score = calc_GaussFit_score(f_ChiSq, f_null_hyp,settings->score_offset,settings->gauss_pot_length);
	float4 tmp;
	if (((f_ChiSq.x <=  settings->gauss_chi_sq_thresh) && (score.x > best_gauss_score))
		|| ((f_ChiSq.x <=  settings->GaussChiSqThresh) && (f_null_hyp.x >= settings->gauss_null_chi_sq_thresh)
		   && (f_PeakPower.x  >= settings->GaussPeakPowerThresh*f_TrueMean.x))
		) {
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;//R: hot attention required to this block
		tmp.x=f_TrueMean.x;
		tmp.y=f_PeakPower.x;
		tmp.z=f_ChiSq.x;
		tmp.w=f_null_hyp.x;
	} else {
		tmp=(float4)0.0f;
	}
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)] = tmp;
	if (((f_ChiSq.y <=  settings->gauss_chi_sq_thresh) && (score.y > best_gauss_score))
		|| ((f_ChiSq.y <=  settings->GaussChiSqThresh) && (f_null_hyp.y >= settings->gauss_null_chi_sq_thresh)
		&& (f_PeakPower.y  >= settings->GaussPeakPowerThresh*f_TrueMean.y))
		) {
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;//R: hot attention required to this block
		tmp.x=f_TrueMean.y;
		tmp.y=f_PeakPower.y;
		tmp.z=f_ChiSq.y;
		tmp.w=f_null_hyp.y;
	} else {
		tmp=(float4)0.0f;
	}
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)+1] = tmp;
	if (((f_ChiSq.z <=  settings->gauss_chi_sq_thresh) && (score.z > best_gauss_score))
		|| ((f_ChiSq.z <=  settings->GaussChiSqThresh) && (f_null_hyp.z >= settings->gauss_null_chi_sq_thresh)
			&& (f_PeakPower.z  >= settings->GaussPeakPowerThresh*f_TrueMean.z))
		) {
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;//R: hot attention required to this block
		tmp.x=f_TrueMean.z;
		tmp.y=f_PeakPower.z;
		tmp.z=f_ChiSq.z;
		tmp.w=f_null_hyp.z;
	} else {
		tmp=(float4)0.0f;
	}
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)+2] = tmp;
	if (((f_ChiSq.w <=  settings->gauss_chi_sq_thresh) && (score.w > best_gauss_score))
		|| ((f_ChiSq.w <=  settings->GaussChiSqThresh) && (f_null_hyp.w >= settings->gauss_null_chi_sq_thresh)
			&& (f_PeakPower.w  >= settings->GaussPeakPowerThresh*f_TrueMean.w))
		) {
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;//R: hot attention required to this block
		tmp.x=f_TrueMean.w;
		tmp.y=f_PeakPower.w;
		tmp.z=f_ChiSq.w;
		tmp.w=f_null_hyp.w;
	} else {
		tmp=(float4)0.0f;
	}
		GaussFitResults[ul_TOffset * ul_FftLength + (tid<<2)+3] = tmp;
} // End of gaussfit()


#endif

__kernel
#if !__APPLE__
  //uje: the attribute work group size hint is not available on apple+ati platform
__attribute__((work_group_size_hint(1, 1, 1)))
#endif
void set_mem_kernel_cl(__global float4* data){
	uint tid=get_global_id(0);
	data[tid]=(float4)(0.0f);
}

__kernel __attribute__((vec_type_hint(float4)))
void PC_find_triplets_kernel_cl(int ul_FftLength, int len_power, float triplet_thresh_base, int AdvanceBy, int PoTLen,
									  __global float4* PoT,__global uint* result_flag) {
//R: difference from original kernel: this one just doing fast precheck and relies on CPU for real triplet analysis
//R: this kernel does 4 PoT chunks at once.
//R: cause workitems can write flag in arbitrary order it's not possible to set error code actually (original CUDA code
// missed this fact and tries to return error code from kernel. That is, different variable should be used for setting
// state flags.
	int ul_PoT = get_global_id(0);//R: 4 PoTs at once!
	int y = get_global_id(1);//R: index of offset chunk
	int fft_len4=ul_FftLength>>2;
	int TOffset = y * AdvanceBy;
	if(TOffset + len_power > PoTLen) {
		TOffset = PoTLen - len_power;
	}
	__global float4* fp_PulsePot= PoT + ul_PoT + TOffset * (fft_len4);
	// Clear the result array
	int4 numBinsAboveThreshold=(int4)0;
	int i;
	float4 mean_power=(float4)0.f,triplet_thresh=(float4)triplet_thresh_base,pp;

	/* Get all the bins that are above the threshold, and find the power array mean value */
	for( i=0;i<len_power;i++ ) {
		mean_power += fp_PulsePot[i*fft_len4];
	}
	mean_power /= (float4)len_power;
	triplet_thresh*=mean_power;

	for( i=0;i<len_power;i++ ) {
		pp= fp_PulsePot[i*fft_len4];
		if(  pp.x>= triplet_thresh.x ) {
			numBinsAboveThreshold.x++;
		}
		if(  pp.y>= triplet_thresh.y ) {
			numBinsAboveThreshold.y++;
		}
		if(  pp.z>= triplet_thresh.z ) {
			numBinsAboveThreshold.z++;
		}
		if(  pp.w>= triplet_thresh.w ) {
			numBinsAboveThreshold.w++;
		}
	}
	if(numBinsAboveThreshold.x>2 || numBinsAboveThreshold.y>2 || numBinsAboveThreshold.z>2 || numBinsAboveThreshold.w>2){
//R: global size is power of 2 so it should be safe to perform integer division here
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;
	}
}
__kernel __attribute__((vec_type_hint(float4)))
void PC_find_triplets_kernel_HD5_cl(int ul_FftLength, int len_power, float triplet_thresh_base, int AdvanceBy, int PoTLen,
									  __global float4* PoT,__global uint* result_flag,
									  __local float4* tmp) {
//R: this one uses local memory to increase number of separate workitems hence number of workgroups for better load of
// multi-CU devices

//R: difference from original kernel: this one just doing fast precheck and relies on CPU for real triplet analysis
//R: this kernel does 4 PoT chunks at once.
//R: cause workitems can write flag in arbitrary order it's not possible to set error code actually (original CUDA code
// missed this fact and tries to return error code from kernel. That is, different variable should be used for setting
// state flags.
	int ul_PoT = get_global_id(0);//R: 4 PoTs at once!
	int y = get_global_id(1);//R: index of offset chunk
	int tid=get_local_id(2);
	int fft_len4=ul_FftLength>>2;
	int TOffset = y * AdvanceBy;
//R: each wave of third index works on single PoT array
//	local float4 local_sum[64/*can be get_local_size(2) if variable length allowed*/];
	if(TOffset + len_power > PoTLen) {
		TOffset = PoTLen - len_power;
	}
	__global float4* fp_PulsePot= PoT + ul_PoT + TOffset * (fft_len4);
	// Clear the result array
	//int4 numBinsAboveThreshold_private=(int4)0;
	float4 tmp_private=(float4)0.f,triplet_thresh=(float4)triplet_thresh_base,pp;
	__local float4* tmp_local=tmp+get_local_size(2)*get_local_id(0);

	/* Get all the bins that are above the threshold, and find the power array mean value */
	for( int i=tid;i<len_power;i+=get_local_size(2) ) {
		tmp_private += fp_PulsePot[i*fft_len4];
	}
	//R: here can be one of new reduce operations but this will require higher CL version
	tmp_local[tid]=tmp_private;
	for(int i=(get_local_size(2)>>1); i>0;i>>=1){
		barrier(CLK_LOCAL_MEM_FENCE);
		if(tid<i){
			tmp_local[tid]+=tmp_local[tid+i];
		}
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if(tid==0){
		tmp_private=tmp_local[0];
		tmp_private/= (float4)len_power;
		//PulsePoT_average[ul_PoT+y*fft_len4]=tmp_private;//R: this avg will be needed later, at pulse finding
		tmp_local[0]=tmp_private;//R: to  share with other threads
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	tmp_private=tmp_local[0];//R: broadcast reduced value to all threads for further use
	triplet_thresh*=tmp_private;
	tmp_private=(float4)0.f;

	for( int i=tid;i<len_power;i+=get_local_size(2)) {
		pp= fp_PulsePot[i*fft_len4];
		if(  pp.x>= triplet_thresh.x ) {
			tmp_private.x+=1.f;
//			printf("X BRANCH: global:(%d,%d,%d); local:(%d,%d,%d); tmp_private:(%v4g)\n",
//				get_global_id(0),get_global_id(1),get_global_id(2),
//				get_local_id(0),get_local_id(1),get_local_id(2),tmp_private);
//			printf("pp:(%v4g); triplet_thresh:(%v4g)\n",pp,triplet_thresh);
		}
		if(  pp.y>= triplet_thresh.y ) {
			tmp_private.y+=1.f;
//			printf("Y BRANCH: global:(%d,%d,%d); local:(%d,%d,%d); tmp_private:(%v4g)\n",
//				get_global_id(0),get_global_id(1),get_global_id(2),
//				get_local_id(0),get_local_id(1),get_local_id(2),tmp_private);
//			printf("pp:(%v4g); triplet_thresh:(%v4g)\n",pp,triplet_thresh);
		}
		if(  pp.z>= triplet_thresh.z ) {
			tmp_private.z+=1.f;
//			printf("Z BRANCH: global:(%d,%d,%d); local:(%d,%d,%d); tmp_private:(%v4g)\n",
//				get_global_id(0),get_global_id(1),get_global_id(2),
//				get_local_id(0),get_local_id(1),get_local_id(2),tmp_private);
//			printf("pp:(%v4g); triplet_thresh:(%v4g)\n",pp,triplet_thresh);
		}
		if(  pp.w>= triplet_thresh.w ) {
			tmp_private.w+=1.f;
//			printf("W BRANCH: global:(%d,%d,%d); local:(%d,%d,%d); tmp_private:(%v4g)\n",
//				get_global_id(0),get_global_id(1),get_global_id(2),
//				get_local_id(0),get_local_id(1),get_local_id(2),tmp_private);
//			printf("pp:(%v4g); triplet_thresh:(%v4g)\n",pp,triplet_thresh);
		}
	}
//R: again need to reduce values
	tmp_local[tid]=tmp_private;
	for(int i=(get_local_size(2)>>1); i>0;i>>=1){
		barrier(CLK_LOCAL_MEM_FENCE);
		if(tid<i){
			tmp_local[tid]+=tmp_local[tid+i];
		}
	}
	barrier(CLK_LOCAL_MEM_FENCE);
  if(tid==0){
		tmp_private=tmp_local[0];
	if(tmp_private.x>2.f || tmp_private.y>2.f || tmp_private.z>2.f || tmp_private.w>2.f){
//		printf("Resulting numbers of peaks: (%v4g)\n",tmp_private);
//R: global size is power of 2 so it should be safe to perform integer division here
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;
	}
  }
}


__kernel __attribute__((vec_type_hint(float4)))
void PC_find_triplets_avg_kernel_cl(int ul_FftLength, int len_power, float triplet_thresh_base, int AdvanceBy, int PoTLen,
									  __global float4* PoT,__global uint* result_flag,__global float4* PulsePoT_average) {
//R: difference from original kernel: this one just doing fast precheck and relies on CPU for real triplet analysis
//R: this kernel does 4 PoT chunks at once.
//R: cause workitems can write flag in arbitrary order it's not possible to set error code actually (original CUDA code
// missed this fact and tries to return error code from kernel. That is, different variable should be used for setting
// state flags.
	int ul_PoT = get_global_id(0);//R: 4 PoTs at once!
	int y = get_global_id(1);//R: index of offset chunk
	int fft_len4=ul_FftLength>>2;
	int TOffset = y * AdvanceBy;
	if(TOffset + len_power > PoTLen) {
		TOffset = PoTLen - len_power;
	}
	__global float4* fp_PulsePot= PoT + ul_PoT + TOffset * (fft_len4);
	// Clear the result array
	int4 numBinsAboveThreshold=(int4)0;
	int i;
	float4 mean_power=(float4)0.f,triplet_thresh=(float4)triplet_thresh_base,pp;

	/* Get all the bins that are above the threshold, and find the power array mean value */
	for( i=0;i<len_power;i++ ) {
		mean_power += fp_PulsePot[i*fft_len4];
	}
	mean_power /= (float4)len_power;
	PulsePoT_average[ul_PoT+y*fft_len4]=mean_power;//R: this avg will be needed later, at pulse finding
	triplet_thresh*=mean_power;

	for( i=0;i<len_power;i++ ) {
		pp= fp_PulsePot[i*fft_len4];
		if(  pp.x>= triplet_thresh.x ) {
			numBinsAboveThreshold.x++;
		}
		if(  pp.y>= triplet_thresh.y ) {
			numBinsAboveThreshold.y++;
		}
		if(  pp.z>= triplet_thresh.z ) {
			numBinsAboveThreshold.z++;
		}
		if(  pp.w>= triplet_thresh.w ) {
			numBinsAboveThreshold.w++;
		}
	}
	if(numBinsAboveThreshold.x>2 || numBinsAboveThreshold.y>2 || numBinsAboveThreshold.z>2 || numBinsAboveThreshold.w>2){
//R: global size is power of 2 so it should be safe to perform integer division here
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;
	}
}

__kernel __attribute__((vec_type_hint(float4)))
void PC_find_triplets_avg_kernel_HD5_cl(int ul_FftLength, int len_power, float triplet_thresh_base, int AdvanceBy, int PoTLen,
									  __global float4* PoT,__global uint* result_flag,__global float4* PulsePoT_average,
									  __local float4* tmp) {
//R: this one uses local memory to increase number of separate workitems hence number of workgroups for better load of
// multi-CU devices

//R: difference from original kernel: this one just doing fast precheck and relies on CPU for real triplet analysis
//R: this kernel does 4 PoT chunks at once.
//R: cause workitems can write flag in arbitrary order it's not possible to set error code actually (original CUDA code
// missed this fact and tries to return error code from kernel. That is, different variable should be used for setting
// state flags.
	int ul_PoT = get_global_id(0);//R: 4 PoTs at once!
	int y = get_global_id(1);//R: index of offset chunk
	int tid=get_local_id(2);
	int fft_len4=ul_FftLength>>2;
	int TOffset = y * AdvanceBy;
//R: each wave of third index works on single PoT array
//	local float4 local_sum[64/*can be get_local_size(2) if variable length allowed*/];
	if(TOffset + len_power > PoTLen) {
		TOffset = PoTLen - len_power;
	}
	__global float4* fp_PulsePot= PoT + ul_PoT + TOffset * (fft_len4);
	// Clear the result array
	//int4 numBinsAboveThreshold_private=(int4)0;
	float4 tmp_private=(float4)0.f,triplet_thresh=(float4)triplet_thresh_base,pp;
	__local float4* tmp_local=tmp+get_local_size(2)*get_local_id(0);

	/* Get all the bins that are above the threshold, and find the power array mean value */
	for( int i=tid;i<len_power;i+=get_local_size(2)/*can be get_local_size(2) if variable length allowed*/ ) {
		tmp_private += fp_PulsePot[i*fft_len4];
	}
	//R: here can be one of new reduce operations but this will require higher CL version
	tmp_local[tid]=tmp_private;
	for(int i=(get_local_size(2)>>1); i>0;i>>=1){
		barrier(CLK_LOCAL_MEM_FENCE);
		if(tid<i){
			tmp_local[tid]+=tmp_local[tid+i];
		}
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if(tid==0){
		tmp_private=tmp_local[0];
		tmp_private/= (float4)len_power;
		PulsePoT_average[ul_PoT+y*fft_len4]=tmp_private;//R: this avg will be needed later, at pulse finding
		tmp_local[0]=tmp_private;//R: to  share with other threads
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	tmp_private=tmp_local[0];//R: broadcast reduced value to all threads for further use
	triplet_thresh*=tmp_private;
	tmp_private=(float4)0.f;

	for( int i=tid;i<len_power;i+=get_local_size(2)) {
		pp= fp_PulsePot[i*fft_len4];
		if(  pp.x>= triplet_thresh.x ) {
			tmp_private.x+=1.f;
//			printf("X BRANCH: global:(%d,%d,%d); local:(%d,%d,%d); tmp_private:(%v4g)\n",
//				get_global_id(0),get_global_id(1),get_global_id(2),
//				get_local_id(0),get_local_id(1),get_local_id(2),tmp_private);
//			printf("pp:(%v4g); triplet_thresh:(%v4g)\n",pp,triplet_thresh);
		}
		if(  pp.y>= triplet_thresh.y ) {
			tmp_private.y+=1.f;
//			printf("Y BRANCH: global:(%d,%d,%d); local:(%d,%d,%d); tmp_private:(%v4g)\n",
//				get_global_id(0),get_global_id(1),get_global_id(2),
//				get_local_id(0),get_local_id(1),get_local_id(2),tmp_private);
//			printf("pp:(%v4g); triplet_thresh:(%v4g)\n",pp,triplet_thresh);
		}
		if(  pp.z>= triplet_thresh.z ) {
			tmp_private.z+=1.f;
//			printf("Z BRANCH: global:(%d,%d,%d); local:(%d,%d,%d); tmp_private:(%v4g)\n",
//				get_global_id(0),get_global_id(1),get_global_id(2),
//				get_local_id(0),get_local_id(1),get_local_id(2),tmp_private);
//			printf("pp:(%v4g); triplet_thresh:(%v4g)\n",pp,triplet_thresh);
		}
		if(  pp.w>= triplet_thresh.w ) {
			tmp_private.w+=1.f;
//			printf("W BRANCH: global:(%d,%d,%d); local:(%d,%d,%d); tmp_private:(%v4g)\n",
//				get_global_id(0),get_global_id(1),get_global_id(2),
//				get_local_id(0),get_local_id(1),get_local_id(2),tmp_private);
//			printf("pp:(%v4g); triplet_thresh:(%v4g)\n",pp,triplet_thresh);
		}
	}
//R: again need to reduce values
	tmp_local[tid]=tmp_private;
	for(int i=(get_local_size(2)>>1)/*can be get_local_size(2) if variable length allowed*/; i>0;i>>=1){
		barrier(CLK_LOCAL_MEM_FENCE);
		if(tid<i){
			tmp_local[tid]+=tmp_local[tid+i];
		}
	}
	barrier(CLK_LOCAL_MEM_FENCE);
  if(tid==0){
		tmp_private=tmp_local[0];
	if(tmp_private.x>2.f || tmp_private.y>2.f || tmp_private.z>2.f || tmp_private.w>2.f){
//R: global size is power of 2 so it should be safe to perform integer division here
//		printf("Resulting numbers of peaks: (%v4g)\n",tmp_private);
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;
	}
  }
}

/*
0 1 2 3 4 5 6 7 8 9 10 - 11=di
x x x x x - new di
x x x x x x - tmp0=1+new di=6
0+6 1+7 2+8 3+9 (4+10)=stop+(stop+tmp0) - 5=di
 x   x  -new di, tmp0=1+2=3
(0+6)+(3+9) (1+7)+(4+10)
*/
float4 sumtop2(__global float4 *tab, __global float4* dest, int di, int fft_len4, int tmp0) {
//R: this function working with 4 different frequency bins at once as all other pulse finding functions do
	float4 sum, tmax;
	int   i;
	tmax = 0.0f;
	__global float4 *one = tab;
	__global float4 *two = tab + tmp0 * fft_len4;

	for (i = 0; i < di; i++) {
		float4 i1 = one[i * (fft_len4)];
		float4 i2 = two[i * (fft_len4)];
		sum = i1 + i2;
		dest[i * (fft_len4)] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}
float4 sumtop3(__global float4 *tab, __global float4* dest, int di, int fft_len4, int tmp0, int tmp1) {
	float4 sum, tmax;
	int   i;
	tmax = 0.0f;
	__global float4 *one = tab;
	__global float4 *two = tab + tmp0 * fft_len4;
	__global float4 *three = tab + tmp1 * (fft_len4);

	for (i = 0; i < di; i++) {
		int offset=i * (fft_len4);
		float4 i1 = one[offset];
		float4 i2 = two[offset];
		float4 i3 = three[offset];
		sum = i1 + i2;
		sum += i3;
		dest[offset] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}
float4 sumtop4(__global float4 *tab, __global float4* dest, int di, int fft_len4, int tmp0, int tmp1, int tmp2) {
	float4 sum, tmax;
	int   i;
	__global float4 *one = tab;
	__global float4 *two = tab + tmp0 * (fft_len4);
	__global float4 *three = tab + tmp1 * (fft_len4);
	__global float4 *four = tab + tmp2 * (fft_len4);
	tmax = 0.0f;

	for (i = 0; i < di; i++) {
		float4 i1 = one[i * fft_len4];
		float4 i2 = two[i * fft_len4];
		float4 i3 = three[i * fft_len4];
		float4 i4 = four[i * fft_len4];
		sum = i1 + i2;
		sum += i3;
		sum += i4;
		dest[i * fft_len4] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}

float4 sumtop5(__global float4 *tab, __global float4* dest, int di, int fft_len4, int tmp0, int tmp1, int tmp2, int tmp3) {
	float4 sum, tmax;
	int   i;
	__global float4 *one = tab;
	__global float4 *two = tab + tmp0 * (fft_len4);
	__global float4 *three = tab + tmp1 * (fft_len4);
	__global float4 *four = tab + tmp2 * (fft_len4);
	__global float4 *five = tab + tmp3 * (fft_len4);
	tmax = 0.0f;

	for (i = 0; i < di; i++) {
		float4 i1 = one[i * fft_len4];
		float4 i2 = two[i * fft_len4];
		float4 i3 = three[i * fft_len4];
		float4 i4 = four[i * fft_len4];
		float4 i5 = five[i * fft_len4];
		sum = i1 + i2;
		sum += i3;
		sum += i4;
		sum += i5;
		dest[i * fft_len4] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}
typedef struct {
	//int NumDataPoints;
	// find_triplets
	//float *power_ft;
	//float4* results_ft;
	//result_flag* result_flags_ft;

	// find_pulse
	//float* PulsePot_fp;		// Input data
	//float* PulsePot8_fp;	// Input data moved 8 bytes forward for coleased reads
	//float* tmp_pot_fp;		// Temporary array
	//float* best_pot_fp;		// Copy folded pots with best score
	//float* report_pot_fp;	// Copy folded pots for reporting
	//float4* results_fp;		// Additional data for reporting

	//result_find_pulse_flag* result_flags_fp;

	//const float* t_funct_cache_fp; // cached results of cudaAcc_t_funct
	float rcfg_dis_thresh;
	int PulseMax;
} PulseFind_t;
#define FOLDS_COUNT 4
#define FOLDS_START 2
float4 t_funct(int di, int num_adds, int j, int PulseMax, __global float* t_funct_cache) {
	return (float4)t_funct_cache[j * PulseMax * FOLDS_COUNT + (num_adds - FOLDS_START) * PulseMax + di];
}

#if 0
__kernel __attribute__((vec_type_hint(float4)))
void PC_find_pulse_kernel_cl(float best_pulse_score, int PulsePotLen, int AdvanceBy,
								  int fft_len, int ndivs,int pass,
								  __global PulseFind_t* settings,__global float* t_funct_cache_fp,
								  __global float4* PoT,__global float4* tmp_PoT,__global uint4* result_flag,int offset,
								  __global float4* PulsePoT_average, int PoTLen)
{
	if(result_flag[0].x == 1) return;//R: if CPU processing already needed - abort kernel ASAP
	//const int PoTLen = NumDataPoints/fft_len;
	int ul_PoT = get_global_id(0)+offset;
	int y = get_global_id(1);
	int z=get_global_id(2);
	int TOffset1 = y * AdvanceBy;
	int TOffset2 = (32*y+z) * AdvanceBy;
	float rcfg_dis_thresh=settings->rcfg_dis_thresh;
	int PulseMax=settings->PulseMax;
	int fft_len4=fft_len>>2;

	//if (ul_PoT < 1) return; // Original find_pulse, omits first element
	//if (ul_PoT >= fft_len) return;
	if(TOffset1 + PulsePotLen > PoTLen) {
		TOffset1 = PoTLen - PulsePotLen;
	}

	__global float4* fp_PulsePot	= PoT + ul_PoT + TOffset1 * (fft_len4);
	__global float4* tmp_pot		= tmp_PoT + ul_PoT + TOffset2 * (fft_len4);
	//float* best_pot		= cudaAcc_PulseFind_settings.best_pot_fp	+ ul_PoT + TOffset2 * fft_len;
	//float* report_pot	= cudaAcc_PulseFind_settings.report_pot_fp	+ ul_PoT + TOffset2 * fft_len;

	int di;

	float4 avg;//,maxp=0;//, snr=0, fthresh=0;
	float4 tmp_max;
	avg=PulsePoT_average[ul_PoT+y*fft_len4];
	//  Periods from PulsePotLen/3 to PulsePotLen/4, and power of 2 fractions of.
	//   then (len/4 to len/5) and finally (len/5 to len/6)
	//
	int num_adds = pass;
	//for(int num_adds = 3; num_adds <= 5; num_adds++)
    {
		int firstP, lastP;
		switch(num_adds) {
		case 3: lastP = (PulsePotLen*2)/3-z;  firstP = (PulsePotLen*1)/2; break;
		case 4: lastP = (PulsePotLen*3)/4-z;  firstP = (PulsePotLen*3)/5; break;
		case 5: lastP = (PulsePotLen*4)/5-z;  firstP = (PulsePotLen*4)/6; break;
		}
		int num_adds_minus1 = num_adds - 1;
		int p = lastP;
		for (p = lastP ; p > firstP ; p-=32) {
			float4 cur_thresh, dis_thresh;
			int /*tabofst, */mper, perdiv;
			int tmp0, tmp1, tmp2, tmp3;

			//tabofst = ndivs*3+2-num_adds;
			mper = p * (12/num_adds_minus1);
			perdiv = num_adds_minus1;
			tmp0 = (int)((mper + 6)/12);             // round(period)
			tmp1 = (int)((mper * 2 + 6)/12);         // round(period*2)
			di = (int)p/perdiv;                      // (int)period
			//dis_thresh = cudaAcc_t_funct(di, num_adds)*avg;
			dis_thresh = t_funct(di, num_adds, 0, PulseMax, t_funct_cache_fp) * avg;

			switch(num_adds) {
			case 3:
				tmp_max = sumtop3(fp_PulsePot, tmp_pot, di, fft_len4, tmp0, tmp1);
				break;
			case 4:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp_max = sumtop4(fp_PulsePot, tmp_pot, di, fft_len4, tmp0, tmp1, tmp2);
				break;
			case 5:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp3 = (int)((mper * 4 + 6)/12);     // round(period*4)
				tmp_max = sumtop5(fp_PulsePot, tmp_pot, di, fft_len4, tmp0, tmp1, tmp2, tmp3);
				break;
			}

			if (tmp_max.x>dis_thresh.x || tmp_max.y>dis_thresh.y ||
				tmp_max.z>dis_thresh.z || tmp_max.w>dis_thresh.w) {
				// unscale for reporting
				tmp_max /= (float4)num_adds;
				cur_thresh = (dis_thresh / (float4)num_adds - avg) * rcfg_dis_thresh + avg;

				float4 _snr = (tmp_max-avg)/(cur_thresh-avg);
				if (_snr.x  > best_pulse_score ||
					_snr.y  > best_pulse_score ||
					_snr.z  > best_pulse_score ||
					_snr.w  > best_pulse_score ) {
					result_flag[0].x = 1;//return;
				}
				if( (tmp_max.x>cur_thresh.x) ||
					(tmp_max.y>cur_thresh.y) ||
					(tmp_max.z>cur_thresh.z) ||
					(tmp_max.w>cur_thresh.w) ) {
					result_flag[0].x = 1;//return;
				}
			}

			int num_adds_2 = 2* num_adds;

			//	int j = 1;
			//float4 tmp_max2=(float4)0.f;
			for (int j = 1; j < ndivs ; j++)
			{
				//perdiv *=2;
				tmp0 = di & 1;
				di >>= 1;
				tmp0 += di;
				dis_thresh = t_funct(di, num_adds, j,PulseMax,t_funct_cache_fp) * avg;
				{
					tmp_max = sumtop2(tmp_pot, tmp_pot, di, fft_len4, tmp0);
				}
				if (tmp_max.x>dis_thresh.x || tmp_max.y>dis_thresh.y ||
					tmp_max.z>dis_thresh.z || tmp_max.w>dis_thresh.w) {
					// unscale for reporting
					tmp_max /= (float4)num_adds_2;
					cur_thresh = (dis_thresh / (float4)num_adds_2 - avg) * rcfg_dis_thresh + avg;

					float4 _snr = (tmp_max-avg)/(cur_thresh-avg);
					if (_snr.x  > best_pulse_score ||
						_snr.y  > best_pulse_score ||
						_snr.z  > best_pulse_score ||
						_snr.w  > best_pulse_score) {
						result_flag[0].x = 1;return;
					}
					if ((tmp_max.x>cur_thresh.x) ||
						(tmp_max.y>cur_thresh.y) ||
						(tmp_max.z>cur_thresh.z) ||
						(tmp_max.w>cur_thresh.w) ) {
						result_flag[0].x = 1;//return;
					}
				}

				num_adds_2 *=2;
			}  // for (j = 1; j < ndivs
		} // for (p = lastP
	} // for(num_adds =
}
#else
__kernel __attribute__((vec_type_hint(float4)))
void PC_find_pulse_kernel1_cl(float best_pulse_score, int PulsePotLen, int AdvanceBy,
								  int fft_len, int ndivs,int pass,
								  __global PulseFind_t* settings,__global float* t_funct_cache_fp,
								  __global float4* PoT,__global float4* tmp_PoT,__global uint4* result_flag,int offset,
								  __global float4* PulsePoT_average,int PoTLen)
{
	if(result_flag[0].x == 1) return;//R: if CPU processing already needed - abort kernel ASAP
	//const int PoTLen = NumDataPoints/fft_len;
	int ul_PoT = get_global_id(0)+offset;
	uint y = get_global_id(1);
	uint z=get_global_id(2);//Periods unroll
	uint TOffset1 = y * AdvanceBy;
	uint TOffset2 = (get_global_size(2)*y+z) * (PulsePotLen/pass);
	float rcfg_dis_thresh=settings->rcfg_dis_thresh;
	int PulseMax=settings->PulseMax;
	uint fft_len4=fft_len>>2;

	//if (ul_PoT < 1) return; // Original find_pulse, omits first element
	//if (ul_PoT >= fft_len) return;
	if(TOffset1 + PulsePotLen > PoTLen) {
		TOffset1 = PoTLen - PulsePotLen;
	}

	__global float4* fp_PulsePot	= PoT + ul_PoT + TOffset1 * (fft_len4);
	__global float4* tmp_pot		= tmp_PoT + ul_PoT + TOffset2 * (fft_len4);
	//float* best_pot		= cudaAcc_PulseFind_settings.best_pot_fp	+ ul_PoT + TOffset2 * fft_len;
	//float* report_pot	= cudaAcc_PulseFind_settings.report_pot_fp	+ ul_PoT + TOffset2 * fft_len;

	int di;

	float4 avg;//,maxp=0;//, snr=0, fthresh=0;
	float4 tmp_max;
	avg=PulsePoT_average[ul_PoT+y*fft_len4];
	//  Periods from PulsePotLen/3 to PulsePotLen/4, and power of 2 fractions of.
	//   then (len/4 to len/5) and finally (len/5 to len/6)
	//
	int num_adds = pass;
	//for(int num_adds = 3; num_adds <= 5; num_adds++)
    {
		int firstP, lastP;
		switch(num_adds) {
		case 3: lastP = (PulsePotLen*2)/3-z;  firstP = (PulsePotLen*1)/2; break;
		case 4: lastP = (PulsePotLen*3)/4-z;  firstP = (PulsePotLen*3)/5; break;
		case 5: lastP = (PulsePotLen*4)/5-z;  firstP = (PulsePotLen*4)/6; break;
		}
		int num_adds_minus1 = num_adds - 1;
		int p = lastP;
		for (p = lastP ; p > firstP ; p-=get_global_size(2)) {
			float4 cur_thresh, dis_thresh;
			int /*tabofst, */mper, perdiv;
			int tmp0, tmp1, tmp2, tmp3;

			//tabofst = ndivs*3+2-num_adds;
			mper = p * (12/num_adds_minus1);
			perdiv = num_adds_minus1;
			tmp0 = (int)((mper + 6)/12);             // round(period)
			tmp1 = (int)((mper * 2 + 6)/12);         // round(period*2)
			di = (int)p/perdiv;                      // (int)period
			//dis_thresh = cudaAcc_t_funct(di, num_adds)*avg;
			dis_thresh = t_funct(di, num_adds, 0, PulseMax, t_funct_cache_fp) * avg;

			switch(num_adds) {
			case 3:
				tmp_max = sumtop3(fp_PulsePot, tmp_pot, di, fft_len4, tmp0, tmp1);
				break;
			case 4:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp_max = sumtop4(fp_PulsePot, tmp_pot, di, fft_len4, tmp0, tmp1, tmp2);
				break;
			case 5:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp3 = (int)((mper * 4 + 6)/12);     // round(period*4)
				tmp_max = sumtop5(fp_PulsePot, tmp_pot, di, fft_len4, tmp0, tmp1, tmp2, tmp3);
				break;
			}

			if (tmp_max.x>dis_thresh.x || tmp_max.y>dis_thresh.y ||
				tmp_max.z>dis_thresh.z || tmp_max.w>dis_thresh.w) {
				// unscale for reporting
				tmp_max /= (float4)num_adds;

				cur_thresh = (dis_thresh / (float4)num_adds - avg) * rcfg_dis_thresh + avg;

				float4 _snr = (tmp_max-avg)/(cur_thresh-avg);
				if (_snr.x  > best_pulse_score ||
					_snr.y  > best_pulse_score ||
					_snr.z  > best_pulse_score ||
					_snr.w  > best_pulse_score ) {
					result_flag[0].x = 1;//return;
				}
				if( (tmp_max.x>cur_thresh.x) ||
					(tmp_max.y>cur_thresh.y) ||
					(tmp_max.z>cur_thresh.z) ||
					(tmp_max.w>cur_thresh.w) ) {
					result_flag[0].x = 1;//return;
				}
			}

			int num_adds_2 = 2* num_adds;

			//	int j = 1;
			//float4 tmp_max2=(float4)0.f;
			for (int j = 1; j < ndivs ; j++)
			{
				//perdiv *=2;
				tmp0 = di & 1;
				di >>= 1;
				tmp0 += di;
				dis_thresh = t_funct(di, num_adds, j,PulseMax,t_funct_cache_fp) * avg;
				{
					tmp_max = sumtop2(tmp_pot, tmp_pot, di, fft_len4, tmp0);
				}
				if (tmp_max.x>dis_thresh.x || tmp_max.y>dis_thresh.y ||
					tmp_max.z>dis_thresh.z || tmp_max.w>dis_thresh.w) {
					// unscale for reporting
					tmp_max /= (float4)num_adds_2;

					cur_thresh = (dis_thresh /(float4)num_adds_2 - avg) * rcfg_dis_thresh + avg;

					float4 _snr = (tmp_max-avg)/(cur_thresh-avg);
					if (_snr.x  > best_pulse_score ||
						_snr.y  > best_pulse_score ||
						_snr.z  > best_pulse_score ||
						_snr.w  > best_pulse_score) {
						result_flag[0].x = 1;
						return;
					}
					if ((tmp_max.x>cur_thresh.x) ||
						(tmp_max.y>cur_thresh.y) ||
						(tmp_max.z>cur_thresh.z) ||
						(tmp_max.w>cur_thresh.w) ) {
						result_flag[0].x = 1;
#if __APPLE__
            return;
#endif
					}
				}

				num_adds_2 *=2;
			}  // for (j = 1; j < ndivs
		} // for (p = lastP
	} // for(num_adds =
}
#endif

#if 0
__kernel
void PC_find_pulse_kernel2_pass3_cl(float best_pulse_score, int PulsePotLen, int AdvanceBy,
								  int fft_len, int ndivs,//int pass,
								  __global PulseFind_t* settings,__global float* t_funct_cache_fp,
								  __global float4* PoT,__global float4* tmp_PoT,__global uint4* result_flag,
								  __global float4* PulsePoT_average,int PoTLen)
{
//	if(result_flag[0].x == 1) return;//R: if CPU processing already needed - abort kernel ASAP
	//const int PoTLen = NumDataPoints/fft_len;
	int ul_PoT = get_global_id(0);
	int y = get_global_id(1);
	int z=get_global_id(2);
	int TOffset1 = y * AdvanceBy;
	int TOffset2 = (get_global_size(2)*y+z) * (PulsePotLen/3);//pass);
	float rcfg_dis_thresh=settings->rcfg_dis_thresh;
	int PulseMax=settings->PulseMax;
	int fft_len4=fft_len>>2;

	//if (ul_PoT < 1) return; // Original find_pulse, omits first element
	//if (ul_PoT >= fft_len) return;
	if(TOffset1 + PulsePotLen > PoTLen) {
		TOffset1 = PoTLen - PulsePotLen;
	}

	__global float4* fp_PulsePot	= PoT + ul_PoT + TOffset1 * (fft_len4);
	__global float4* tmp_pot		= tmp_PoT + ul_PoT + TOffset2 * (fft_len4);
	//float* best_pot		= cudaAcc_PulseFind_settings.best_pot_fp	+ ul_PoT + TOffset2 * fft_len;
	//float* report_pot	= cudaAcc_PulseFind_settings.report_pot_fp	+ ul_PoT + TOffset2 * fft_len;

	int di;

	float4 avg;//,maxp=0;//, snr=0, fthresh=0;
	float4 tmp_max;
	avg=PulsePoT_average[ul_PoT+y*fft_len4];//*3.f;//R: will use scaled max later
	//  Periods from PulsePotLen/3 to PulsePotLen/4, and power of 2 fractions of.
	//   then (len/4 to len/5) and finally (len/5 to len/6)
	//
	//int num_adds = 3;//pass;
	//int res=0;
	//for(int num_adds = 3; num_adds <= 5; num_adds++)
    {
		int firstP, lastP;
		lastP = (PulsePotLen*2)/3-z;  firstP = (PulsePotLen*1)/2;
		//int num_adds_minus1 = num_adds - 1;
		int p = lastP;
		for (p = lastP ; p > firstP ; p-=get_global_size(2)) {
			float4 cur_thresh, dis_thresh;
			int /*tabofst, */mper;//, perdiv;
			int tmp0, tmp1;//, tmp2, tmp3;
			float4 scaled_avg;
			//tabofst = ndivs*3+2-num_adds;
			mper = p * (12/2);//num_adds_minus1);
			//perdiv = 2;//num_adds_minus1;
			tmp0 = (int)((mper + 6)/12);             // round(period)
			tmp1 = (int)((mper * 2 + 6)/12);         // round(period*2)
			di = (int)p/2;//perdiv;                      // (int)period
			dis_thresh = t_funct(di, 3/*num_adds*/, 0, PulseMax, t_funct_cache_fp) * avg;
			tmp_max = sumtop3(fp_PulsePot, tmp_pot, di, fft_len4, tmp0, tmp1);

			if (tmp_max.x>dis_thresh.x || tmp_max.y>dis_thresh.y ||
				tmp_max.z>dis_thresh.z || tmp_max.w>dis_thresh.w) {
				// unscale for reporting
				scaled_avg=avg*3.0f;
				//tmp_max /= 3;//num_adds;
				cur_thresh = (dis_thresh/* / 3 num_adds*/ - scaled_avg) * rcfg_dis_thresh + scaled_avg;

				float4 _snr = (tmp_max-scaled_avg)/(cur_thresh-scaled_avg);
				if (_snr.x  > best_pulse_score ||
					_snr.y  > best_pulse_score ||
					_snr.z  > best_pulse_score ||
					_snr.w  > best_pulse_score || (tmp_max.x>cur_thresh.x) ||
					(tmp_max.y>cur_thresh.y) ||
					(tmp_max.z>cur_thresh.z) ||
					(tmp_max.w>cur_thresh.w) ) {
					//res=1;
					result_flag[0].x = 1;//return;
				}
			}

			int num_adds_2 =6;// 2* num_adds;

			//	int j = 1;
			//float4 tmp_max2=(float4)0.f;
			for (int j = 1; j < ndivs ; j++)
			{
				//perdiv *=2;
				tmp0 = di & 1;
				di >>= 1;
				tmp0 += di;
				dis_thresh = t_funct(di,3/* num_adds*/, j,PulseMax,t_funct_cache_fp) * avg;
				{
					tmp_max = sumtop2(tmp_pot, tmp_pot, di, fft_len4, tmp0);
				}
				if (tmp_max.x>dis_thresh.x || tmp_max.y>dis_thresh.y ||
					tmp_max.z>dis_thresh.z || tmp_max.w>dis_thresh.w) {
					// unscale for reporting
					scaled_avg=avg*(float4)num_adds_2;
					//tmp_max /= num_adds_2;
					cur_thresh = (dis_thresh/* / num_adds_2*/ - scaled_avg) * rcfg_dis_thresh + scaled_avg;

					float4 _snr = (tmp_max-scaled_avg)/(cur_thresh-scaled_avg);
					if (_snr.x  > best_pulse_score ||
						_snr.y  > best_pulse_score ||
						_snr.z  > best_pulse_score ||
						_snr.w  > best_pulse_score ||
						(tmp_max.x>cur_thresh.x) ||
						(tmp_max.y>cur_thresh.y) ||
						(tmp_max.z>cur_thresh.z) ||
						(tmp_max.w>cur_thresh.w) ) {
						//res=1;
						result_flag[0].x = 1;//return;
					}
				}

				num_adds_2 *=2;
			}  // for (j = 1; j < ndivs
		} // for (p = lastP
	} // for(num_adds =
	//if(res==1)result_flag[0].x = 1;
}
#endif

#if 0
__kernel __attribute__((vec_type_hint(float4)))
void PC_find_pulse_partial_kernel_cl(float best_pulse_score, int PulsePotLen, int AdvanceBy,
								  int fft_len, int ndivs,int pass,
								  __global PulseFind_t* settings,__global float* t_funct_cache_fp,
								  __global float4* PoT,__global float4* tmp_PoT,__global uint4* result_flag,int offset,
								  __global float4* PulsePoT_average,int P,int PP,int PoTLen)
{
	if(result_flag[0].x == 1) return;//R: if CPU processing already needed - abort kernel ASAP
	//const int PoTLen = NumDataPoints/fft_len;
	int ul_PoT = get_global_id(0)+offset;
	int y = get_global_id(1);
	int z=get_global_id(2);
	int TOffset1 = y * AdvanceBy;
	int TOffset2 = (32*y+z) * AdvanceBy;
	float rcfg_dis_thresh=settings->rcfg_dis_thresh;
	int PulseMax=settings->PulseMax;
	int fft_len4=fft_len>>2;

	//if (ul_PoT < 1) return; // Original find_pulse, omits first element
	//if (ul_PoT >= fft_len) return;
	if(TOffset1 + PulsePotLen > PoTLen) {
		TOffset1 = PoTLen - PulsePotLen;
	}

	__global float4* fp_PulsePot	= PoT + ul_PoT + TOffset1 * (fft_len4);
	__global float4* tmp_pot		= tmp_PoT + ul_PoT + TOffset2 * (fft_len4);
	//float* best_pot		= cudaAcc_PulseFind_settings.best_pot_fp	+ ul_PoT + TOffset2 * fft_len;
	//float* report_pot	= cudaAcc_PulseFind_settings.report_pot_fp	+ ul_PoT + TOffset2 * fft_len;

	int di;

	float4 avg;//,maxp=0;//, snr=0, fthresh=0;
	float4 tmp_max;
	avg=PulsePoT_average[ul_PoT+y*fft_len4];
	//  Periods from PulsePotLen/3 to PulsePotLen/4, and power of 2 fractions of.
	//   then (len/4 to len/5) and finally (len/5 to len/6)
	//
	int num_adds = pass;
	//for(int num_adds = 3; num_adds <= 5; num_adds++)
    {
		int lastP;
		switch(num_adds) {
		case 3: lastP = P-z; break;
		case 4: lastP = P-z; break;
		case 5: lastP = P-z; break;
		}
		int num_adds_minus1 = num_adds - 1;
		int p = lastP;
		for (p = lastP ; p > PP ; p-=32) {
			float4 cur_thresh, dis_thresh;
			int /*tabofst, */mper, perdiv;
			int tmp0, tmp1, tmp2, tmp3;

			//tabofst = ndivs*3+2-num_adds;
			mper = p * (12/num_adds_minus1);
			perdiv = num_adds_minus1;
			tmp0 = (int)((mper + 6)/12);             // round(period)
			tmp1 = (int)((mper * 2 + 6)/12);         // round(period*2)
			di = (int)p/perdiv;                      // (int)period
			//dis_thresh = cudaAcc_t_funct(di, num_adds)*avg;
			dis_thresh = t_funct(di, num_adds, 0, PulseMax, t_funct_cache_fp) * avg;

			switch(num_adds) {
			case 3:
				tmp_max = sumtop3(fp_PulsePot, tmp_pot, di, fft_len4, tmp0, tmp1);
				break;
			case 4:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp_max = sumtop4(fp_PulsePot, tmp_pot, di, fft_len4, tmp0, tmp1, tmp2);
				break;
			case 5:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp3 = (int)((mper * 4 + 6)/12);     // round(period*4)
				tmp_max = sumtop5(fp_PulsePot, tmp_pot, di, fft_len4, tmp0, tmp1, tmp2, tmp3);
				break;
			}

			if (tmp_max.x>dis_thresh.x || tmp_max.y>dis_thresh.y ||
				tmp_max.z>dis_thresh.z || tmp_max.w>dis_thresh.w) {
				// unscale for reporting
				tmp_max /= (float4)num_adds;
				cur_thresh = (dis_thresh / (float4)num_adds - avg) * rcfg_dis_thresh + avg;

				float4 _snr = (tmp_max-avg)/(cur_thresh-avg);
				if (_snr.x  > best_pulse_score ||
					_snr.y  > best_pulse_score ||
					_snr.z  > best_pulse_score ||
					_snr.w  > best_pulse_score ) {
					result_flag[0].x = 1;//return;
				}
				if( (tmp_max.x>cur_thresh.x) ||
					(tmp_max.y>cur_thresh.y) ||
					(tmp_max.z>cur_thresh.z) ||
					(tmp_max.w>cur_thresh.w) ) {
					result_flag[0].x = 1;//return;
				}
			}

			int num_adds_2 = 2* num_adds;

			//	int j = 1;
			//float4 tmp_max2=(float4)0.f;
			for (int j = 1; j < ndivs ; j++)
			{
				//perdiv *=2;
				tmp0 = di & 1;
				di >>= 1;
				tmp0 += di;
				dis_thresh = t_funct(di, num_adds, j,PulseMax,t_funct_cache_fp) * avg;
				{
					tmp_max = sumtop2(tmp_pot, tmp_pot, di, fft_len4, tmp0);
				}
				if (tmp_max.x>dis_thresh.x || tmp_max.y>dis_thresh.y ||
					tmp_max.z>dis_thresh.z || tmp_max.w>dis_thresh.w) {
					// unscale for reporting
					tmp_max /= (float4)num_adds_2;
					cur_thresh = (dis_thresh / (float4)num_adds_2 - avg) * rcfg_dis_thresh + avg;

					float4 _snr = (tmp_max-avg)/(cur_thresh-avg);
					if (_snr.x  > best_pulse_score ||
						_snr.y  > best_pulse_score ||
						_snr.z  > best_pulse_score ||
						_snr.w  > best_pulse_score) {
						result_flag[0].x = 1;return;
					}
					if ((tmp_max.x>cur_thresh.x) ||
						(tmp_max.y>cur_thresh.y) ||
						(tmp_max.z>cur_thresh.z) ||
						(tmp_max.w>cur_thresh.w) ) {
						result_flag[0].x = 1;//return;
					}
				}

				num_adds_2 *=2;
			}  // for (j = 1; j < ndivs
		} // for (p = lastP
	} // for(num_adds =
}
#endif

__kernel void PC_find_pulse_partial_kernel1_cl(const float best_pulse_score, int PulsePotLen, int AdvanceBy,
								  int fft_len, int ndivs,int pass,
								  __global PulseFind_t* settings,__global float* t_funct_cache_fp,
								  __global float4* PoT,__global float4* tmp_PoT,__global uint4* result_flag,int offset,
								  __global float4* PulsePoT_average,int P,int PP, int PoTLen)
{
	//if(result_flag[0].x == 1) return;//R: if CPU processing already needed - abort kernel ASAP
	//const int PoTLen = 1024*1024/fft_len;
	int ul_PoT = get_global_id(0)+offset;
	int y = get_global_id(1);
	int z=get_global_id(2);
	int TOffset1 = y * AdvanceBy;
	int TOffset2 = (get_global_size(2)*y+z) * (PulsePotLen/pass);
	float rcfg_dis_thresh=settings->rcfg_dis_thresh;
	int PulseMax=settings->PulseMax;
	int fft_len4=fft_len>>2;

	//if(ul_PoT == 0 && y == 0 && z == 0) printf("Entering PulseFind\n");

	//if (ul_PoT < 1) return; // Original find_pulse, omits first element
	//if (ul_PoT >= fft_len) return;
	if(TOffset1 + PulsePotLen > PoTLen) {
		TOffset1 = PoTLen - PulsePotLen;
	}

	__global float4* fp_PulsePot	= PoT + ul_PoT + TOffset1 * (fft_len4);
	__global float4* tmp_pot		= tmp_PoT + ul_PoT + TOffset2 * (fft_len4);
	//float* best_pot		= cudaAcc_PulseFind_settings.best_pot_fp	+ ul_PoT + TOffset2 * fft_len;
	//float* report_pot	= cudaAcc_PulseFind_settings.report_pot_fp	+ ul_PoT + TOffset2 * fft_len;

	int di;

	float4 avg;//,maxp=0;//, snr=0, fthresh=0;
	float4 tmp_max;
	avg=PulsePoT_average[ul_PoT+y*fft_len4];
	//  Periods from PulsePotLen/3 to PulsePotLen/4, and power of 2 fractions of.
	//   then (len/4 to len/5) and finally (len/5 to len/6)
	//
	int num_adds = pass;
	//for(int num_adds = 3; num_adds <= 5; num_adds++)
    {
		int lastP;
		switch(num_adds) {
		case 3: lastP = P-z; break;
		case 4: lastP = P-z; break;
		case 5: lastP = P-z; break;
		}
		int num_adds_minus1 = num_adds - 1;
		int p = lastP;
		for (p = lastP ; p > PP ; p-=get_global_size(2)) {
        	//if(ul_PoT == 0 && y == 0 && z == 0) printf("p=%d\n",p);
			float4 cur_thresh, dis_thresh;
			int /*tabofst, */mper, perdiv;
			int tmp0, tmp1, tmp2, tmp3;

			//tabofst = ndivs*3+2-num_adds;
			mper = p * (12/num_adds_minus1);
			perdiv = num_adds_minus1;
			tmp0 = (int)((mper + 6)/12);             // round(period)
			tmp1 = (int)((mper * 2 + 6)/12);         // round(period*2)
			di = (int)p/perdiv;                      // (int)period
			//dis_thresh = cudaAcc_t_funct(di, num_adds)*avg;
			dis_thresh = t_funct(di, num_adds, 0, PulseMax, t_funct_cache_fp) * avg;

			switch(num_adds) {
			case 3:
				tmp_max = sumtop3(fp_PulsePot, tmp_pot, di, fft_len4, tmp0, tmp1);
				break;
			case 4:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp_max = sumtop4(fp_PulsePot, tmp_pot, di, fft_len4, tmp0, tmp1, tmp2);
				break;
			case 5:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp3 = (int)((mper * 4 + 6)/12);     // round(period*4)
				tmp_max = sumtop5(fp_PulsePot, tmp_pot, di, fft_len4, tmp0, tmp1, tmp2, tmp3);
				break;
			}
			//if(ul_PoT == 0 && y == 0 && z == 0) printf("label 1\n");
			if (tmp_max.x>dis_thresh.x || tmp_max.y>dis_thresh.y ||
				tmp_max.z>dis_thresh.z || tmp_max.w>dis_thresh.w) {
				// unscale for reporting
				tmp_max /= (float4)num_adds;
				cur_thresh = (dis_thresh / (float4)num_adds - avg) * rcfg_dis_thresh + avg;

				float4 _snr = (tmp_max-avg)/(cur_thresh-avg);
				if (_snr.x  > best_pulse_score ||
					_snr.y  > best_pulse_score ||
					_snr.z  > best_pulse_score ||
					_snr.w  > best_pulse_score ) {
					result_flag[0].x = 1;
					//printf("location 1 hit: ul_PoT=%d,y=%d,z=%d,p=%d\n",ul_PoT,y,z,p);
					//return;
				}
				if( (tmp_max.x>cur_thresh.x) ||
					(tmp_max.y>cur_thresh.y) ||
					(tmp_max.z>cur_thresh.z) ||
					(tmp_max.w>cur_thresh.w) ) {
					result_flag[0].x = 1;
					//printf("location 2 hit: ul_PoT=%d,y=%d,z=%d,p=%d\n",ul_PoT,y,z,p);
					//return;
				}
			}

			int num_adds_2 = 2* num_adds;

			//	int j = 1;
			//float4 tmp_max2=(float4)0.f;
			for (int j = 1; j < ndivs ; j++)
			{
    			//if(ul_PoT == 0 && y == 0 && z == 0) printf("j=%d\n",j);

				//perdiv *=2;
				tmp0 = di & 1;
				di >>= 1;
				tmp0 += di;
				dis_thresh = t_funct(di, num_adds, j,PulseMax,t_funct_cache_fp) * avg;
				{
					tmp_max = sumtop2(tmp_pot, tmp_pot, di, fft_len4, tmp0);
				}
#if 0
	if(ul_PoT == 1 && y == 3 && z == 7 && p == 4454){
		printf("tmp_max=(%d,%d,%d,%d) dis_thresh=(%d,%d,%d,%d) j=%d\n",
			tmp_max.x,tmp_max.y,tmp_max.z,tmp_max.w,dis_thresh.x,dis_thresh.y,dis_thresh.z,dis_thresh.w,j);
	}
#endif
				if (tmp_max.x>dis_thresh.x || tmp_max.y>dis_thresh.y ||
					tmp_max.z>dis_thresh.z || tmp_max.w>dis_thresh.w) {
					// unscale for reporting
					tmp_max /= (float4)num_adds_2;
					cur_thresh = (dis_thresh / (float4)num_adds_2 - avg) * rcfg_dis_thresh + avg;

					float4 _snr = (tmp_max-avg)/(cur_thresh-avg);
					//if(ul_PoT == 0 && y == 0 && z == 0) printf("label 2\n");

#if 0
	if(ul_PoT == 1 && y == 3 && z == 7 && p == 4454){
		printf("_snr=(%d,%d,%d,%d) best_pulse_score=(%d)\n",
			_snr.x,_snr.y,_snr.z,_snr.w,best_pulse_score);
	}
#endif
					if (_snr.x  > best_pulse_score ||
						_snr.y  > best_pulse_score ||
						_snr.z  > best_pulse_score ||
						_snr.w  > best_pulse_score) {
						result_flag[0].x = 1;//printf("location 3 hit: ul_PoT=%d,y=%d,z=%d,p=%d\n",ul_PoT,y,z,p);return;
					}
					if ((tmp_max.x>cur_thresh.x) ||
						(tmp_max.y>cur_thresh.y) ||
						(tmp_max.z>cur_thresh.z) ||
						(tmp_max.w>cur_thresh.w) ) {
						result_flag[0].x = 1;//printf("location 4 hit: ul_PoT=%d,y=%d,z=%d,p=%d\n",ul_PoT,y,z,p);//return;
					}
				}

				num_adds_2 *=2;
			}  // for (j = 1; j < ndivs
		} // for (p = lastP
	} // for(num_adds =
}


float4 sumtop3f(__global float4 *tab, int di, int fft_len4, int tmp0, int tmp1) {
	float4 sum, tmax;
	int   i;
	tmax = (float4)0.0f;
	__global float4 *one = tab;
	__global float4 *two = tab + tmp0 * fft_len4;
	__global float4 *three = tab + tmp1 * (fft_len4);

	for (i = 0; i < di; i++) {
		float4 i1 = one[i * (fft_len4)];
		float4 i2 = two[i * (fft_len4)];
		float4 i3 = three[i * (fft_len4)];
		sum = i1 + i2;
		sum += i3;
		//dest[i * (fft_len4)] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}

float4 sumtop4f(__global float4 *tab, int di, int fft_len4, int tmp0, int tmp1, int tmp2) {
	float4 sum, tmax;
	int   i;
	__global float4 *one = tab;
	__global float4 *two = tab + tmp0 * (fft_len4);
	__global float4 *three = tab + tmp1 * (fft_len4);
	__global float4 *four = tab + tmp2 * (fft_len4);
	tmax = (float4)0.0f;

	for (i = 0; i < di; i++) {
		float4 i1 = one[i * fft_len4];
		float4 i2 = two[i * fft_len4];
		float4 i3 = three[i * fft_len4];
		float4 i4 = four[i * fft_len4];
		sum = i1 + i2;
		sum += i3;
		sum += i4;
		//dest[i * fft_len4] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}

float4 sumtop5f(__global float4 *tab, int di, int fft_len4, int tmp0, int tmp1, int tmp2, int tmp3) {
	float4 sum, tmax;
	int   i;
	__global float4 *one = tab;
	__global float4 *two = tab + tmp0 * (fft_len4);
	__global float4 *three = tab + tmp1 * (fft_len4);
	__global float4 *four = tab + tmp2 * (fft_len4);
	__global float4 *five = tab + tmp3 * (fft_len4);
	tmax = (float4)0.0f;

	for (i = 0; i < di; i++) {
		float4 i1 = one[i * fft_len4];
		float4 i2 = two[i * fft_len4];
		float4 i3 = three[i * fft_len4];
		float4 i4 = four[i * fft_len4];
		float4 i5 = five[i * fft_len4];
		sum = i1 + i2;
		sum += i3;
		sum += i4;
		sum += i5;
		//dest[i * fft_len4] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}
__kernel __attribute__((vec_type_hint(float4)))
//R: TODO: cause kernel is small need to check
//1) if reading flag is needed- reading global memory is costly
//2) if unroll over periods (z-axis) is needed - each unrolled workitem requires separate average read from global memory
void PC_find_pulse_f_kernel_cl(float best_pulse_score, int PulsePotLen, int AdvanceBy,
								  int fft_len,
								  __global PulseFind_t* settings,__global float* t_funct_cache_fp,
								  __global float4* PoT,__global uint* result_flag,
								  __global float4* PulsePoT_average,int PoTLen)
{
	//if(result_flag[0].x == 1) return;//R: if CPU processing already needed - abort kernel ASAP
	int z=get_global_id(2);
	int firstP = (PulsePotLen*1)/2;
	int p = (PulsePotLen*2)/3-z;
	//const int PoTLen = 1024*1024/fft_len;
	int ul_PoT = get_global_id(0);
	int y = get_global_id(1);

	int TOffset1 = y * AdvanceBy;
	//int TOffset2 = y * AdvanceBy;
	float rcfg_dis_thresh=settings->rcfg_dis_thresh;
	int PulseMax=settings->PulseMax;
	int fft_len4=fft_len>>2;

	//if (ul_PoT < 1) return; // Original find_pulse, omits first element
	//if (ul_PoT >= fft_len) return;
	if(TOffset1 + PulsePotLen > PoTLen) {
		TOffset1 = PoTLen - PulsePotLen;
	}

	__global float4* fp_PulsePot	= PoT + ul_PoT + TOffset1 * (fft_len4);
	//__global float4* tmp_pot		= tmp_PoT + ul_PoT + TOffset2 * (fft_len4);
	//float* best_pot		= cudaAcc_PulseFind_settings.best_pot_fp	+ ul_PoT + TOffset2 * fft_len;
	//float* report_pot	= cudaAcc_PulseFind_settings.report_pot_fp	+ ul_PoT + TOffset2 * fft_len;

	int di;

	float4 avg;//,maxp=0;//, snr=0, fthresh=0;
	float4 tmp_max;
	avg=PulsePoT_average[ul_PoT+y*fft_len4];
	uint need_cpu_reprocess=0;
	//  Periods from PulsePotLen/3 to PulsePotLen/4, and power of 2 fractions of.
	//   then (len/4 to len/5) and finally (len/5 to len/6)
	//
	for(int num_adds = 3; num_adds <= 5; num_adds++)
    {
		switch(num_adds) {
		case 4: p = (PulsePotLen*3)/4-z;  firstP = (PulsePotLen*3)/5;
			break;
		case 5: p = (PulsePotLen*4)/5-z;  firstP = (PulsePotLen*4)/6;
			break;
		}
		if(p<=firstP) return;//R: return should be safe cause first iteration has biggest number of periods involved
		int num_adds_minus1 = num_adds - 1;
		//int p = lastP;
		/*for (p = lastP ; p > firstP ; p-=)*/ {
			float4 cur_thresh, dis_thresh;
			int /*tabofst, */mper, perdiv;
			int tmp0, tmp1, tmp2, tmp3;

			//tabofst = ndivs*3+2-num_adds;
			mper = p * (12/num_adds_minus1);
			perdiv = num_adds_minus1;
			tmp0 = (int)((mper + 6)/12);             // round(period)
			tmp1 = (int)((mper * 2 + 6)/12);         // round(period*2)
			di = (int)p/perdiv;                      // (int)period
			//dis_thresh = cudaAcc_t_funct(di, num_adds)*avg;
			dis_thresh = t_funct(di, num_adds, 0, PulseMax, t_funct_cache_fp) * avg;

			switch(num_adds) {
			case 3:
				tmp_max = sumtop3f(fp_PulsePot, di, fft_len4, tmp0, tmp1);
				break;
			case 4:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp_max = sumtop4f(fp_PulsePot, di, fft_len4, tmp0, tmp1, tmp2);
				break;
			case 5:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp3 = (int)((mper * 4 + 6)/12);     // round(period*4)
				tmp_max = sumtop5f(fp_PulsePot, di, fft_len4, tmp0, tmp1, tmp2, tmp3);
				break;
			}

			if (tmp_max.x>dis_thresh.x || tmp_max.y>dis_thresh.y ||
				tmp_max.z>dis_thresh.z || tmp_max.w>dis_thresh.w) {
				// unscale for reporting
				tmp_max /= (float4)num_adds;
				cur_thresh = (dis_thresh / (float4)num_adds - avg) * rcfg_dis_thresh + avg;

				float4 _snr = (tmp_max-avg)/(cur_thresh-avg);
				if (_snr.x  > best_pulse_score ||
					_snr.y  > best_pulse_score ||
					_snr.z  > best_pulse_score ||
					_snr.w  > best_pulse_score ) {
					need_cpu_reprocess = 1;
				}
				if( (tmp_max.x>cur_thresh.x) ||
					(tmp_max.y>cur_thresh.y) ||
					(tmp_max.z>cur_thresh.z) ||
					(tmp_max.w>cur_thresh.w) ) {
					need_cpu_reprocess = 1;//return;
				}
			}
		} // for (p = lastP
	} // for(num_adds =
	//R: global size is power of 2 so it should be safe to perform integer division here
	if(need_cpu_reprocess){
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;
	}

}




#if OCL_REAL_LOCAL //USE_OPENCL_NV || USE_OPENCL_HD5xxx
float sumtop2_local(__local float *tab, __local float* dest, int di,int tmp0) {
//R: this function working with 4 different frequency bins at once as all other pulse finding functions do
	float sum, tmax;
	int   i;
	tmax = 0.0f;
	__local float *one = tab;
	__local float *two = tab + tmp0*get_local_size(0);

	for (i = 0; i < di; i++) {
		int offset=i*get_local_size(0);
		float i1 = one[offset];
		float i2 = two[offset];
		sum = i1 + i2;
		dest[offset] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}
float sumtop3_local( __global float *tab, __local float* dest, int di, int tmp0, int tmp1,int fftlen) {
	float sum, tmax;
	int   i;
	tmax = 0.0f;
	__global float *one = tab;
	__global float *two = tab + tmp0*fftlen;
	__global float *three = tab + tmp1*fftlen;

	for (i = 0; i < di; i++) {
		int offset=i*fftlen;
		float i1 = one[offset];
		float i2 = two[offset];
		float i3 = three[offset];
		sum = i1 + i2;
		sum += i3;
		dest[i*get_local_size(0)] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}
float sumtop4_local(__global float *tab, __local float* dest, int di, int tmp0, int tmp1, int tmp2,int fftlen) {
	float sum, tmax;
	int   i;
	__global float *one = tab;
	__global float *two = tab + tmp0*fftlen;
	__global float *three = tab + tmp1*fftlen;
	__global float *four = tab + tmp2*fftlen;
	tmax = 0.0f;

	for (i = 0; i < di; i++) {
		int offset=i*fftlen;
		float i1 = one[offset];
		float i2 = two[offset];
		float i3 = three[offset];
		float i4 = four[offset];
		sum = i1 + i2;
		sum += i3;
		sum += i4;
		dest[i*get_local_size(0)] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}
float sumtop5_local(__global float *tab, __local float* dest, int di, int tmp0, int tmp1, int tmp2, int tmp3,int fftlen) {
	float sum, tmax;
	int   i;
	__global float *one = tab;
	__global float *two = tab + tmp0*fftlen;
	__global float *three = tab + tmp1*fftlen;
	__global float *four = tab + tmp2*fftlen;
	__global float *five = tab + tmp3*fftlen;
	tmax = 0.0f;

	for (i = 0; i < di; i++) {
		int offset=i*fftlen;
		float i1 = one[offset];
		float i2 = two[offset];
		float i3 = three[offset];
		float i4 = four[offset];
		float i5 = five[offset];
		sum = i1 + i2;
		sum += i3;
		sum += i4;
		sum += i5;
		dest[i*get_local_size(0)] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}
float t_funct_f(int di, int num_adds, int j, int PulseMax, __global float* t_funct_cache) {
	return t_funct_cache[j * PulseMax * FOLDS_COUNT + (num_adds - FOLDS_START) * PulseMax + di];
}
//R: this kernel should be used for small power arrays that fit in local memory comletely
__kernel void PC_find_pulse_local_kernel1_cl(float best_pulse_score, int PulsePotLen, int AdvanceBy,
								  int fft_len, int ndivs,
								  __global PulseFind_t* settings,__global float* t_funct_cache_fp,
								  __global float* PoT,__local float* tmp_PoT,__global uint* result_flag,
								  __global float* PulsePoT_average,int PoTLen)
{
	//if(result_flag[0].x == 1) return;//R: if CPU processing already needed - abort kernel ASAP
	//const int PoTLen = 1024*1024/fft_len;
	int ul_PoT = get_global_id(0);
	int y = get_global_id(1);
	int z=get_local_id(0);
	int TOffset1 = y * AdvanceBy;
	float rcfg_dis_thresh=settings->rcfg_dis_thresh;
	int PulseMax=settings->PulseMax;
	int need_cpu_reprocess=0;

	//if (ul_PoT < 1) return; // Original find_pulse, omits first element
	//if (ul_PoT >= fft_len) return;
	if(TOffset1 + PulsePotLen > PoTLen) {
		TOffset1 = PoTLen - PulsePotLen;
	}

	__global float* fp_PulsePot	= PoT + ul_PoT + TOffset1 * (fft_len);
	__local float* tmp_pot		= tmp_PoT +z;
	//float* best_pot		= cudaAcc_PulseFind_settings.best_pot_fp	+ ul_PoT + TOffset2 * fft_len;
	//float* report_pot	= cudaAcc_PulseFind_settings.report_pot_fp	+ ul_PoT + TOffset2 * fft_len;

	int di;

	float avg;//,maxp=0;//, snr=0, fthresh=0;
	float tmp_max;
	avg=PulsePoT_average[ul_PoT+y*fft_len];
	//  Periods from PulsePotLen/3 to PulsePotLen/4, and power of 2 fractions of.
	//   then (len/4 to len/5) and finally (len/5 to len/6)
	//
	//int num_adds = pass;
	for(int num_adds = 3; num_adds <= 5; num_adds++)
    {
		int firstP, lastP;
		switch(num_adds) {
		case 3: lastP = (PulsePotLen*2)/3;  firstP = (PulsePotLen*1)/2; break;
		case 4: lastP = (PulsePotLen*3)/4;  firstP = (PulsePotLen*3)/5; break;
		case 5: lastP = (PulsePotLen*4)/5;  firstP = (PulsePotLen*4)/6; break;
		}
		int num_adds_minus1 = num_adds - 1;
		int p = lastP;
		for (p = lastP ; p > firstP ; p--) {
			float cur_thresh, dis_thresh;
			int /*tabofst, */mper, perdiv;
			int tmp0, tmp1, tmp2, tmp3;

			//tabofst = ndivs*3+2-num_adds;
			mper = p * (12/num_adds_minus1);
			perdiv = num_adds_minus1;
			tmp0 = (int)((mper + 6)/12);             // round(period)
			tmp1 = (int)((mper * 2 + 6)/12);         // round(period*2)
			di = (int)p/perdiv;                      // (int)period
			//dis_thresh = cudaAcc_t_funct(di, num_adds)*avg;
			dis_thresh = t_funct_f(di, num_adds, 0, PulseMax, t_funct_cache_fp) * avg;

			switch(num_adds) {
			case 3:
				tmp_max = sumtop3_local(fp_PulsePot, tmp_pot, di, tmp0, tmp1,fft_len);
				break;
			case 4:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp_max = sumtop4_local(fp_PulsePot, tmp_pot, di, tmp0, tmp1, tmp2,fft_len);
				break;
			case 5:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp3 = (int)((mper * 4 + 6)/12);     // round(period*4)
				tmp_max = sumtop5_local(fp_PulsePot, tmp_pot, di, tmp0, tmp1, tmp2, tmp3,fft_len);
				break;
			}

			if (tmp_max>dis_thresh) {
				// unscale for reporting
				tmp_max /= (float)num_adds;
				cur_thresh = (dis_thresh / (float)num_adds - avg) * rcfg_dis_thresh + avg;

				float _snr = (tmp_max-avg)/(cur_thresh-avg);
				if (_snr  > best_pulse_score || (tmp_max>cur_thresh)) {
					need_cpu_reprocess = 1;break;//goto ThreadEnd;
				}
			}

			int num_adds_2 = 2* num_adds;

			//	int j = 1;
			//float tmp_max2=(float4)0.f;
			for (int j = 1; j < ndivs ; j++)
			{
				//perdiv *=2;
				tmp0 = di & 1;
				di >>= 1;
				tmp0 += di;
				dis_thresh = t_funct_f(di, num_adds, j,PulseMax,t_funct_cache_fp) * avg;
				{
					tmp_max = sumtop2_local(tmp_pot, tmp_pot, di,tmp0);
				}
				if (tmp_max>dis_thresh) {
					// unscale for reporting
					tmp_max /= (float)num_adds_2;
					cur_thresh = (dis_thresh / (float)num_adds_2 - avg) * rcfg_dis_thresh + avg;

					float _snr = (tmp_max-avg)/(cur_thresh-avg);
					if (_snr  > best_pulse_score || (tmp_max>cur_thresh)) {
						need_cpu_reprocess = 1;break;//goto ThreadEnd;
					}
				}

				num_adds_2 *=2;
			}  // for (j = 1; j < ndivs
		} // for (p = lastP
	} // for(num_adds =
		//R: global size is power of 2 so it should be safe to perform integer division here
//ThreadEnd:
	if(need_cpu_reprocess){
		int result_coordinate=(get_global_size(0)>RESULT_SIZE)?
			((RESULT_SIZE*get_global_id(0))/get_global_size(0)):get_global_id(0);
		result_flag[result_coordinate]=1;
	}

}
float sumtop3_fl(__global float *tab, __global float* dest, int di, int tmp0, int tmp1, int fft_len) {
	float sum, tmax;
	int   i;
	tmax = 0.0f;
	__global float *one = tab;
	__global float *two = tab + tmp0 * fft_len;
	__global float *three = tab + tmp1 * (fft_len);

	for (i = 0; i < di; i++) {
		int offset=i * (fft_len);
		float i1 = one[offset];
		float i2 = two[offset];
		float i3 = three[offset];
		sum = i1 + i2;
		sum += i3;
		dest[offset] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}
float sumtop4_fl(__global float *tab, __global float* dest, int di, int tmp0, int tmp1, int tmp2, int fft_len) {
	float sum, tmax;
	int   i;
	__global float *one = tab;
	__global float *two = tab + tmp0 * (fft_len);
	__global float *three = tab + tmp1 * (fft_len);
	__global float *four = tab + tmp2 * (fft_len);
	tmax = 0.0f;

	for (i = 0; i < di; i++) {
		int offset=i * (fft_len);
		float i1 = one[offset];
		float i2 = two[offset];
		float i3 = three[offset];
		float i4 = four[offset];
		sum = i1 + i2;
		sum += i3;
		sum += i4;
		dest[offset] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}

float sumtop5_fl(__global float *tab, __global float* dest, int di, int tmp0, int tmp1, int tmp2, int tmp3, int fft_len) {
	float sum, tmax;
	int   i;
	__global float *one = tab;
	__global float *two = tab + tmp0 * (fft_len);
	__global float *three = tab + tmp1 * (fft_len);
	__global float *four = tab + tmp2 * (fft_len);
	__global float *five = tab + tmp3 * (fft_len);
	tmax = 0.0f;

	for (i = 0; i < di; i++) {
		int offset=i * (fft_len);
		float i1 = one[offset];
		float i2 = two[offset];
		float i3 = three[offset];
		float i4 = four[offset];
		float i5 = five[offset];
		sum = i1 + i2;
		sum += i3;
		sum += i4;
		sum += i5;
		dest[offset] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}
float sumtop2_fl(__global float *tab, __global float* dest, int di, int tmp0, int fft_len) {
//R: this function working with 4 different frequency bins at once as all other pulse finding functions do
	float sum, tmax;
	int   i;
	tmax = 0.0f;
	__global float *one = tab;
	__global float *two = tab + tmp0 * fft_len;

	for (i = 0; i < di; i++) {
		int offset=i * (fft_len);
		float i1 = one[offset];
		float i2 = two[offset];
		sum = i1 + i2;
		dest[offset] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}
float sumtop2_semi_local(__global float *tab, __local float* dest, int di, int tmp0, int fft_len,int z) {
//R: this function working with 4 different frequency bins at once as all other pulse finding functions do
	float sum, tmax;
	int   i;
	tmax = 0.0f;
	__global float *one = tab;
	__global float *two = tab + tmp0 * fft_len;

	for (i = 0; i < di; i++) {
		int offset=i * (fft_len);
		float i1 = one[offset];
		float i2 = two[offset];
		sum = i1 + i2;
		dest[i*z] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}
float sumtop2_local2(__local float *tab, __local float* dest, int di,int tmp0,int z) {
//R: this function working with 4 different frequency bins at once as all other pulse finding functions do
	float sum, tmax;
	int   i;
	tmax = 0.0f;
	__local float *one = tab;
	__local float *two = tab + tmp0*z;

	for (i = 0; i < di; i++) {
		int offset=i*z;
		float i1 = one[offset];
		float i2 = two[offset];
		sum = i1 + i2;
		dest[offset] = sum;
		tmax = max(tmax, sum);
	}
	return tmax;
}
__kernel void PC_find_pulse_semi_local_kernel_cl(float best_pulse_score, int PulsePotLen, int AdvanceBy,
								  int fft_len, int ndivs,
								  __global PulseFind_t* settings,__global float* t_funct_cache_fp,
								  __global float* PoT,__global float* tmp_PoT,__global uint4* result_flag,
								  __global float* PulsePoT_average,__local float* local_tmp,int PoTLen)
{
//R: X-axis - different FFT bins, Y-axis - different PulsePoTs inside same FFT bin
//R: Z-axis - unroll through periods

	//if(result_flag[0].x == 1) return;//R: if CPU processing already needed - abort kernel ASAP
	//const int PoTLen = 1024*1024/fft_len;
	int ul_PoT = get_global_id(0);
	if (ul_PoT < 1) return; // Original find_pulse, omits first element
	int y = get_global_id(1);
	int z=get_global_id(2);
	int slz=get_local_size(0)*get_local_size(2);
	int TOffset1 = y * AdvanceBy;
	int TOffset2 =(get_global_size(2)*y+get_global_id(2)) * (PulsePotLen/3);
	float rcfg_dis_thresh=settings->rcfg_dis_thresh;
	int PulseMax=settings->PulseMax;

	//if (ul_PoT >= fft_len) return;
	if(TOffset1 + PulsePotLen > PoTLen) {
		TOffset1 = PoTLen - PulsePotLen;
	}

	__global float* fp_PulsePot	= PoT + ul_PoT + TOffset1 * (fft_len);
	__global float* tmp_pot=tmp_PoT + ul_PoT + TOffset2 * (fft_len);
	__local float* ltmp=local_tmp+get_local_id(0)+get_local_id(2)*get_local_size(0);

	int di;

	float avg;//,maxp=0;//, snr=0, fthresh=0;
	float tmp_max;
	avg=PulsePoT_average[ul_PoT+y*fft_len];
	//  Periods from PulsePotLen/3 to PulsePotLen/4, and power of 2 fractions of.
	//   then (len/4 to len/5) and finally (len/5 to len/6)
	//
	for(int num_adds = 3; num_adds <= 5; num_adds++)
    {
		int firstP, lastP;
		switch(num_adds) {
		case 3: lastP = (PulsePotLen*2)/3-z;  firstP = (PulsePotLen*1)/2; break;
		case 4: lastP = (PulsePotLen*3)/4-z;  firstP = (PulsePotLen*3)/5; break;
		case 5: lastP = (PulsePotLen*4)/5-z;  firstP = (PulsePotLen*4)/6; break;
		}
		int num_adds_minus1 = num_adds - 1;
		int p = lastP;
		for (p = lastP ; p > firstP ; p-=get_global_size(2)) {
			int local_only=0;
			float cur_thresh, dis_thresh;
			int /*tabofst, */mper, perdiv;
			int tmp0, tmp1, tmp2, tmp3;

			//tabofst = ndivs*3+2-num_adds;
			mper = p * (12/num_adds_minus1);
			perdiv = num_adds_minus1;
			tmp0 = (int)((mper + 6)/12);             // round(period)
			tmp1 = (int)((mper * 2 + 6)/12);         // round(period*2)
			di = (int)p/perdiv;                      // (int)period
			//dis_thresh = cudaAcc_t_funct(di, num_adds)*avg;
			dis_thresh = t_funct_f(di, num_adds, 0, PulseMax, t_funct_cache_fp) * avg;

			switch(num_adds) {
			case 3:
				tmp_max = sumtop3_fl(fp_PulsePot, tmp_pot, di, tmp0, tmp1,fft_len);
				break;
			case 4:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp_max = sumtop4_fl(fp_PulsePot, tmp_pot, di, tmp0, tmp1, tmp2,fft_len);
				break;
			case 5:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp3 = (int)((mper * 4 + 6)/12);     // round(period*4)
				tmp_max = sumtop5_fl(fp_PulsePot, tmp_pot, di, tmp0, tmp1, tmp2, tmp3,fft_len);
				break;
			}

			if (tmp_max>dis_thresh) {
				// unscale for reporting
				tmp_max /= (float)num_adds;
				cur_thresh = (dis_thresh / (float)num_adds - avg) * rcfg_dis_thresh + avg;

				float _snr = (tmp_max-avg)/(cur_thresh-avg);
				if (_snr  > best_pulse_score ) {
					result_flag[0].x = 1;return;
				}
				if( (tmp_max>cur_thresh) ) {
					result_flag[0].x = 1;return;
				}
			}

			int num_adds_2 = 2* num_adds;

			//	int j = 1;
			//float tmp_max2=(float4)0.f;
			for (int j = 1; j < ndivs ; j++)
			{
				//perdiv *=2;
				tmp0 = di & 1;
				di >>= 1;
				tmp0 += di;
				dis_thresh = t_funct_f(di, num_adds, j,PulseMax,t_funct_cache_fp) * avg;
				if(local_only)//R: both arrays in local memory already
				{
					tmp_max = sumtop2_local2(ltmp, ltmp, di,tmp0,slz);
				}else if(di<=60)//R:new array will fit inside local memory
				{
					local_only=1;
					tmp_max = sumtop2_semi_local(tmp_pot, ltmp, di,tmp0,fft_len,slz);
				}else
				{
					tmp_max = sumtop2_fl(tmp_pot, tmp_pot, di,tmp0,fft_len);
				}
				if (tmp_max>dis_thresh) {
					// unscale for reporting
					tmp_max /= (float)num_adds_2;
					cur_thresh = (dis_thresh / (float)num_adds_2 - avg) * rcfg_dis_thresh + avg;

					float _snr = (tmp_max-avg)/(cur_thresh-avg);
					if (_snr  > best_pulse_score) {
						result_flag[0].x = 1;return;
					}
					if ((tmp_max>cur_thresh) ) {
						result_flag[0].x = 1;return;
					}
				}

				num_adds_2 *=2;
			}  // for (j = 1; j < ndivs
		} // for (p = lastP
	} // for(num_adds =
}
#if USE_OPENCL_NV
__kernel void PC_find_pulse_kernel1_fl_cl(float best_pulse_score, int PulsePotLen, int AdvanceBy,
								  int fft_len, int ndivs,int pass,
								  __global PulseFind_t* settings,__global float* t_funct_cache_fp,
								  __global float* PoT,__global float* tmp_PoT,__global uint4* result_flag,int offset,
								  __global float* PulsePoT_average,int PoTLen)
{
	if(result_flag[0].x == 1) return;//R: if CPU processing already needed - abort kernel ASAP
	//const int PoTLen = 1024*1024/fft_len;
	int ul_PoT = get_global_id(0)+offset;
	int y = get_global_id(1);
	int z=get_global_id(2);
	int TOffset1 = y * AdvanceBy;
	int TOffset2 = (get_global_size(2)*y+z) * (PulsePotLen/pass);
	float rcfg_dis_thresh=settings->rcfg_dis_thresh;
	int PulseMax=settings->PulseMax;
	//int fft_len4=fft_len>>2;

	//if (ul_PoT < 1) return; // Original find_pulse, omits first element
	//if (ul_PoT >= fft_len) return;
	if(TOffset1 + PulsePotLen > PoTLen) {
		TOffset1 = PoTLen - PulsePotLen;
	}

	__global float* fp_PulsePot	= PoT + ul_PoT + TOffset1 * (fft_len);
	__global float* tmp_pot		= tmp_PoT + ul_PoT + TOffset2 * (fft_len);
	//float* best_pot		= cudaAcc_PulseFind_settings.best_pot_fp	+ ul_PoT + TOffset2 * fft_len;
	//float* report_pot	= cudaAcc_PulseFind_settings.report_pot_fp	+ ul_PoT + TOffset2 * fft_len;

	int di;

	float avg;//,maxp=0;//, snr=0, fthresh=0;
	float tmp_max;
	avg=PulsePoT_average[ul_PoT+y*fft_len];
	//  Periods from PulsePotLen/3 to PulsePotLen/4, and power of 2 fractions of.
	//   then (len/4 to len/5) and finally (len/5 to len/6)
	//
	int num_adds = pass;
	//for(int num_adds = 3; num_adds <= 5; num_adds++)
    {
		int firstP, lastP;
		switch(num_adds) {
		case 3: lastP = (PulsePotLen*2)/3-z;  firstP = (PulsePotLen*1)/2; break;
		case 4: lastP = (PulsePotLen*3)/4-z;  firstP = (PulsePotLen*3)/5; break;
		case 5: lastP = (PulsePotLen*4)/5-z;  firstP = (PulsePotLen*4)/6; break;
		}
		int num_adds_minus1 = num_adds - 1;
		int p = lastP;
		for (p = lastP ; p > firstP ; p-=get_global_size(2)) {
			float cur_thresh, dis_thresh;
			int /*tabofst, */mper, perdiv;
			int tmp0, tmp1, tmp2, tmp3;

			//tabofst = ndivs*3+2-num_adds;
			mper = p * (12/num_adds_minus1);
			perdiv = num_adds_minus1;
			tmp0 = (int)((mper + 6)/12);             // round(period)
			tmp1 = (int)((mper * 2 + 6)/12);         // round(period*2)
			di = (int)p/perdiv;                      // (int)period
			//dis_thresh = cudaAcc_t_funct(di, num_adds)*avg;
			dis_thresh = t_funct_f(di, num_adds, 0, PulseMax, t_funct_cache_fp) * avg;

			switch(num_adds) {
			case 3:
				tmp_max = sumtop3_fl(fp_PulsePot, tmp_pot, di, tmp0, tmp1, fft_len);
				break;
			case 4:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp_max = sumtop4_fl(fp_PulsePot, tmp_pot, di,tmp0, tmp1, tmp2, fft_len);
				break;
			case 5:
				tmp2 = (int)((mper * 3 + 6)/12);     // round(period*3)
				tmp3 = (int)((mper * 4 + 6)/12);     // round(period*4)
				tmp_max = sumtop5_fl(fp_PulsePot, tmp_pot, di,tmp0, tmp1, tmp2, tmp3, fft_len);
				break;
			}

			if (tmp_max>dis_thresh) {
				// unscale for reporting
				tmp_max /= (float)num_adds;
				cur_thresh = (dis_thresh / (float)num_adds - avg) * rcfg_dis_thresh + avg;

				float _snr = (tmp_max-avg)/(cur_thresh-avg);
				if (_snr  > best_pulse_score ) {
					result_flag[0].x = 1;//return;
				}
				if( (tmp_max>cur_thresh) ) {
					result_flag[0].x = 1;//return;
				}
			}

			int num_adds_2 = 2* num_adds;

			//	int j = 1;
			//float tmp_max2=(float)0.f;
			for (int j = 1; j < ndivs ; j++)
			{
				//perdiv *=2;
				tmp0 = di & 1;
				di >>= 1;
				tmp0 += di;
				dis_thresh = t_funct_f(di, num_adds, j,PulseMax,t_funct_cache_fp) * avg;
				{
					tmp_max = sumtop2_fl(tmp_pot, tmp_pot, di, tmp0, fft_len);
				}
				if (tmp_max>dis_thresh ) {
					// unscale for reporting
					tmp_max /= (float)num_adds_2;
					cur_thresh = (dis_thresh / (float)num_adds_2 - avg) * rcfg_dis_thresh + avg;

					float _snr = (tmp_max-avg)/(cur_thresh-avg);
					if (_snr  > best_pulse_score) {
						result_flag[0].x = 1;return;
					}
					if ((tmp_max>cur_thresh) ) {
						result_flag[0].x = 1;//return;
					}
				}

				num_adds_2 *=2;
			}  // for (j = 1; j < ndivs
		} // for (p = lastP
	} // for(num_adds =
}
#endif
#endif

#if SETI7
__kernel void RepackInput_kernel_cl( __global float* PowerSpectrum, __global float2* dct_In)
{
	//R: taking Jason's CUDA kernel as base and extend to 2D matrix to process whole icfft at once
	int sidx = get_global_id(0);
	int y=get_global_id(1);
	int nDestPoints = (get_global_size(0))*4;
	int didx1 = sidx*2;
	int didx2 = (nDestPoints-2)-didx1+nDestPoints*y;
	didx1+=nDestPoints*y;

	float a = PowerSpectrum[sidx+y*get_global_size(0)];

	dct_In[didx1] =(float2)(0.0f,0.f);
	dct_In[didx1+1] =(float2)(a,0.0f);

	dct_In[didx2] =(float2)(0.0f,0.0f);
	dct_In[didx2+1] =(float2)(a,0.0f);
}
#if 0 //USE_OPENCL_NV || USE_OPENCL_HD5xxx //R: working worse still
__kernel void FindAutoCorrelation_kernel1_cl(__global float2* AutoCorrelation,  __global float2* result){
	__local float* PartialSumMaxIdx[256*3];
	const int tid=get_local_id(0);
	const int y=get_global_id(1)*(4*128*1024);
	float partial_sum=0.0f;
	float partial_max=0.0f;
	float idx=0.0f;
	__global float2* auto_corr=AutoCorrelation+y;
	for(int i=tid*256;i<(tid+1)*256;i++){
		float tmp=auto_corr[i].x;
		tmp*=tmp;
		partial_sum+=tmp;
		if(i!=0 && tmp>partial_max){
			partial_max=tmp;
			idx=(float)i;
		}
	}
	int did=3*tid;
	PartialSumMaxIdx[did]=partial_sum;
	PartialSumMaxIdx[did+1]=partial_max;
	PartialSumMaxIdx[did+2]=idx;
	if(tid==0){
		float full_max=0.0f;
		float idx=0.0f;
		float Sum=0.0f;
		for(int i=0;i<256;i++){
			Sum+=PartialSumMaxIdx[3*i];
			if(PartialSumMaxIdx[i*3+1]>full_max){
				full_max=PartialSumMaxIdx[i*3+1];
				idx=PartialSumMaxIdx[i*3+2];
			}
		}
		result[get_global_id(1)].x=full_max*(128.0f*1024.0f)/Sum;//peak value
		result[get_global_id(1)].y=idx;//bin
	}

}
#else
__kernel void FindAutoCorrelation_reduce0_kernel1_cl(__global float2* AutoCorrelation, __global float* PartialSumMaxIdx,
													 int fft_len){
	const int tid=get_global_id(0);
	const int y=get_global_id(1)*(fft_len<<2);
	float partial_sum=0.0f;
	float partial_max=0.0f;
	int first_pass_len=(fft_len>>9);
	float idx=0.0f;
	__global float2* auto_corr=AutoCorrelation+y;
	for(int i=tid*first_pass_len;i<(tid+1)*first_pass_len;i++){
		float tmp=auto_corr[i].x;
		tmp*=tmp;
		partial_sum+=tmp;
		if(i!=0 && tmp>partial_max){
			partial_max=tmp;
			idx=(float)i;
		}
	}
	int did=3*(256*get_global_id(1)+tid);
	PartialSumMaxIdx[did]=partial_sum;
	PartialSumMaxIdx[did+1]=partial_max;
	PartialSumMaxIdx[did+2]=idx;
}
__kernel void FindAutoCorrelation_reduce1_kernel_cl(__global float* PartialSumMaxIdx, __global float2* result,int fft_len){
	const int sid=256*get_global_id(0);
	float full_max=0.0f;
	float idx=0.0f;
	float Sum=0.0f;
	for(int i=0;i<256;i++){
		Sum+=PartialSumMaxIdx[3*(sid+i)];
		float tmp=PartialSumMaxIdx[(sid+i)*3+1];
		if(tmp>full_max){
			full_max=tmp;
			idx=PartialSumMaxIdx[(sid+i)*3+2];
		}
	}
	result[get_global_id(0)].x=full_max*(fft_len)/Sum;//peak value
	result[get_global_id(0)].y=idx;//bin
}
#endif
#endif


// buildOptions=-w -cl-unsafe-math-optimizations -DUSE_OPENCL_INTEL -DRESULT_SIZE=32  -DSETI7 -DOCL_CHIRP3
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -w -cl-unsafe-math-optimizations -DUSE_OPENCL_INTEL -DRESULT_SIZE=32  -DSETI7 -DOCL_CHIRP3" %cfg_path --cl-device=%cl_device 2>&1
