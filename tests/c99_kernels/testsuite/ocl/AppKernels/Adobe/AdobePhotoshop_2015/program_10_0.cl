inline float dot8(float8 a, float8 b)
{
float8 c =a*b;
return dot(c.lo + c.hi,(float4)1.0f);
}

__kernel void fmask(__global float* logProbs, float8 diskPSP, __global float8* pwrSpectra, __global float* pwrSpectraLogProd,float8 nFreqOfMag,float8 noiseSpSq,
float sToLogProbFactor, float biasToLargeRadii, float maxSS,float logProbScale, int sIters, int probPlane,
int width, int height ,int cmptAbsProbs)
{
int idx=get_global_id(0);
if(idx>=width)
return;
const float8 fwNoise= noiseSpSq*nFreqOfMag;
//float fwWghts0Sum=dot8(diskPSP*nFreqOfMag,((float8)1.0f));
float8 eps = (float8)1e-10f;
//eps.s7=0.0f;
int NF=(int)dot8(nFreqOfMag,(float8)1.0f);
sToLogProbFactor=sToLogProbFactor*NF;
float fmSumInv = 1.0f/NF;
float bias = biasToLargeRadii*probPlane*NF;
for(int idy=0;idy<height;idy++)
{
const float8 pwrSpecVec = pwrSpectra[idx + idy*width];
const float8 latentSpec= max(eps,pwrSpecVec-fwNoise)/diskPSP;
float ss= dot8(latentSpec,(float8)1.0f) * fmSumInv;
for (int sIter=1; sIter<sIters; sIter++)
{
const float8 wSqrt = (float8)1.0f / ((float8)1.0f + noiseSpSq / ((float8)ss * diskPSP));
const float8 wghts = wSqrt*wSqrt;
const float wfSum=dot8(nFreqOfMag,wghts);
const float wNrmz = 1.0f/wfSum;
ss = wNrmz*dot8(wghts, latentSpec);
}
ss = max(ss, 1e-16f);
float logP = 0;
float8 vv=diskPSP*(float8)ss+noiseSpSq;
float8 ratio= pwrSpecVec/vv;
logP= dot8((float8)1.0f,-ratio - nFreqOfMag*log(vv));
if (cmptAbsProbs==1) {
logP += pwrSpectraLogProd[idx + idy*width] + NF;
}
const float sOver = max(0.0f, ss-maxSS);
logP -= sOver*sToLogProbFactor;
// When things are totally uncertain, for most pictures is better to assume out of focus.
// So we can give a slight bias in that direction.
logP += bias;
// Store out final log P:
logProbs[idx + idy*width] = logP;
}
}

__kernel void fmaskHetero(__global float* logProbs,__global float* probs,__global const float8* restrict diskPSP,__global const float8* restrict rcpDiskPSP,
__global const float* restrict logProbFloorVec,__global const float8* restrict pwrSpectra,
__global const float*  restrict pwrSpectraLogProd, __local float* localLogProbs,float8 nFreqOfMag,float8 noiseSpSq,float8 eps,
float sToLogProbFactor, float biasToLargeRadii, float maxSS,float logProbScale, int sIters, int sliceNo,
int width, int height ,int cmptAbsProbs, int sliceheight, int planes,
float logScale, float maxLogProbFloor)
{
int idx=get_global_id(0);
int idy=get_global_id(1);
if(idx>=width || idy>=sliceheight)
return;
const float8 fwNoise= noiseSpSq*nFreqOfMag;
//float fwWghts0Sum=dot8(diskPSP*nFreqOfMag,((float8)1.0f));
int NF=(int)dot8(nFreqOfMag,(float8)1.0f);
sToLogProbFactor=sToLogProbFactor*NF;
float fmSumInv = 1.0f/NF;
const size_t sliceSize=sliceheight*width;
const size_t temp=(height+planes-1)/planes;
const size_t offsetY= temp*sliceNo*width;
float M = maxLogProbFloor;
for(unsigned int probPlane=0;probPlane<planes;probPlane++)
{
const float bias = biasToLargeRadii*probPlane*NF;
const float8 pwrSpecVec = pwrSpectra[offsetY + idx + idy*width];
const float8 latentSpec= max(eps,pwrSpecVec-fwNoise) * rcpDiskPSP[probPlane];
float ss= dot8(latentSpec,(float8)1.0f) * fmSumInv;
for (int sIter=1; sIter<sIters; sIter++)
{
const float rcpSS = 1.0f / ss;
const float8 wSqrt = (float8)1.0f / ((float8)1.0f + noiseSpSq * rcpDiskPSP[probPlane] * ((float8)rcpSS));
const float8 wghts = wSqrt*wSqrt;
const float wfSum=dot8(nFreqOfMag,wghts);
const float wNrmz = 1.0f/wfSum;
ss = wNrmz*dot8(wghts, latentSpec);
}
ss = max(ss, 1e-16f);
float logP = 0;
float8 vv=diskPSP[probPlane]*(float8)ss+noiseSpSq;
float8 ratio= pwrSpecVec/vv;
logP= dot8((float8)1.0f,-ratio - nFreqOfMag*log(vv));
if (cmptAbsProbs==1) {
logP += pwrSpectraLogProd[offsetY + idx + idy*width] + NF;
}
const float sOver = max(0.0f, ss-maxSS);
logP -= sOver*sToLogProbFactor;
// When things are totally uncertain, for most pictures is better to assume out of focus.
// So we can give a slight bias in that direction.
logP += bias;
// Store out final log P:
//logProbs[probPlane*sliceSize + idx + idy*width] = logP;
localLogProbs[get_local_size(0)*get_local_size(1)*probPlane + get_local_id(0)+get_local_size(0)*get_local_id(1)]=logP;
const float flooredLogP = max(logScale*logP, logProbFloorVec[probPlane]);
if (flooredLogP > M) {
M = flooredLogP;
}
}
float sumlogP=.0f;
for(unsigned int probPlane=0;probPlane<planes;probPlane++)
{
//float logP=logProbs[probPlane*sliceSize + idx + idy*width];
float logP=localLogProbs[get_local_size(0)*get_local_size(1)*probPlane + get_local_id(0)+get_local_size(0)*get_local_id(1)];
logP = max(logScale*logP, logProbFloorVec[probPlane]);
sumlogP+=exp(logP - M);
}
for(unsigned int probPlane=0;probPlane<planes;probPlane++)
{
//float logP=logProbs[probPlane*sliceSize + idx + idy*width];
float logP=localLogProbs[get_local_size(0)*get_local_size(1)*probPlane + get_local_id(0)+get_local_size(0)*get_local_id(1)];
logP = max(logScale*logP, logProbFloorVec[probPlane]);
logP=exp(logP - M)/sumlogP;
probs[probPlane*sliceSize + idx + idy*width] = logP;
}
}

__kernel void interleavePlanesfloat8(__global float * dataPlanes,__global float8* datainterleaved, int planes, unsigned int area, int width, float emptyfill)
{
if(get_global_id(0)>=width)
return;
size_t batches=area/width;
for(size_t batch=0;batch<batches;batch++)
{
size_t id= get_global_id(0) + batch*width;
float8 datum=(float8)emptyfill;
switch(planes)
{
case 8:
datum.s7=dataPlanes[7*area+id];
case 7:
datum.s6=dataPlanes[6*area+id];
case 6:
datum.s5=dataPlanes[5*area+id];
case 5:
datum.s4=dataPlanes[4*area+id];
case 4:
datum.s3=dataPlanes[3*area+id];
case 3:
datum.s2=dataPlanes[2*area+id];
case 2:
datum.s1=dataPlanes[1*area+id];
case 1:
datum.s0=dataPlanes[0*area+id];
default:break;
}
datainterleaved[id]=datum;
}
}

__kernel void AccumulateFilteredResponses(__global float2 *fftOut, __global float *pwrSpectraLogProd,__global float *pwrSpectra, float minFreqRespSq, int cmptAbsProbs,
unsigned int inPadX,unsigned int inPadY,unsigned int outPadX,unsigned int outPadY,
unsigned int inLineWidth,unsigned int inHeight, unsigned int inWidth,
unsigned int outLineWidth,unsigned int outLineHeight,unsigned int bin)
{
if(get_global_id(0)>=inWidth)
return;
for(size_t yId=0;yId<inHeight;yId++)
{
size_t indexIn= get_global_id(0)+inPadX + (yId+inPadY)*inLineWidth;
size_t indexOut= get_global_id(0)+outPadX + (yId+outPadY)*outLineWidth + outLineWidth*outLineHeight*bin;
float2 aa= fftOut[indexIn];
const float absValSqrd = max(minFreqRespSq, aa.x*aa.x + aa.y*aa.y);
if (cmptAbsProbs)
{
pwrSpectraLogProd[indexOut] += log(absValSqrd);
}
pwrSpectra[indexOut] += absValSqrd;
}
}

__kernel void AccumulateFilteredResponsesImg(__read_only image2d_t fftOut, __global float *pwrSpectraLogProd,__global float *pwrSpectra, float minFreqRespSq, int cmptAbsProbs,
unsigned int inPadX,unsigned int inPadY,unsigned int outPadX,unsigned int outPadY,
unsigned int inHeight, unsigned int inWidth,
unsigned int outLineWidth,unsigned int outLineHeight,unsigned int bin)
{
const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP|CLK_FILTER_NEAREST;
int xID=get_global_id(0);
int yID=get_global_id(1);
if(xID>=inWidth || yID>=inHeight)
return;
float2 aa= read_imagef(fftOut,sampler,(int2)(xID+inPadX,yID+inPadY)).xy;
//for(size_t yId=0;yId<inHeight;yId++)
{
size_t indexOut= xID+outPadX + (yID+outPadY)*outLineWidth + outLineWidth*outLineHeight*bin;
const float absValSqrd = max(minFreqRespSq, aa.x*aa.x + aa.y*aa.y);
if (cmptAbsProbs)
{
pwrSpectraLogProd[indexOut] += log(absValSqrd);
}
pwrSpectra[indexOut] += absValSqrd;
}
}

__kernel void AccumulateFilteredResponsesImgFirst(__read_only image2d_t fftOut, __global float *pwrSpectraLogProd,__global float *pwrSpectra, float minFreqRespSq, int cmptAbsProbs,
unsigned int inPadX,unsigned int inPadY,unsigned int outPadX,unsigned int outPadY,
unsigned int inHeight, unsigned int inWidth,
unsigned int outLineWidth,unsigned int outLineHeight,unsigned int bin)
{
const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP|CLK_FILTER_NEAREST;
int xID=get_global_id(0);
int yID=get_global_id(1);
if(xID>=inWidth || yID>=inHeight)
return;
float2 aa= read_imagef(fftOut,sampler,(int2)(xID+inPadX,yID+inPadY)).xy;
//for(size_t yId=0;yId<inHeight;yId++)
{
size_t indexOut= xID+outPadX + (yID+outPadY)*outLineWidth + outLineWidth*outLineHeight*bin;
const float absValSqrd = max(minFreqRespSq, aa.x*aa.x + aa.y*aa.y);
if (cmptAbsProbs)
{
pwrSpectraLogProd[indexOut] = log(absValSqrd);
}
pwrSpectra[indexOut] = absValSqrd;
}
}

__kernel void InitSingleImage(__write_only image2d_t img, unsigned int width, unsigned int height, float4 val)
{
if(get_global_id(0)>=width||get_global_id(1)>=height)
return;
write_imagef(img, (int2)(get_global_id(0), get_global_id(1)), val);
}

__kernel void InitBuffers(__global float* pwrSpectraLogProd, __global float * pwrSpectra, unsigned int bin, unsigned int width, unsigned int height, float val)
{
if(get_global_id(0)>=width||get_global_id(1)>=height)
return;
//for(size_t yId=0;yId<height;yId++)
size_t yId=get_global_id(1);
{
size_t index= get_global_id(0) + yId*width +  width*height*bin;
pwrSpectraLogProd[index]=val;
pwrSpectra[index]=val;
}
}

__kernel void InitBuffer(__global float* Buff,  unsigned int offset, unsigned int width, unsigned int height, float val)
{
if(get_global_id(0)>=width||get_global_id(1)>=height)
return;
size_t yId=get_global_id(1);
size_t index= get_global_id(0) + yId*width +  offset;
Buff[index]=val;
}

__kernel void SumPwrSpectra(__global float *pwrSpectraLogProdIn,__global float *pwrSpectraLogProdOut,unsigned int inPadX,
unsigned int inPadY,unsigned int inLineWidth,unsigned int inLineHeight,unsigned int outWidth,unsigned int outHeight,unsigned int bins)
{
int xId=get_global_id(0);
int yId=get_global_id(1);
if(xId>=outWidth || yId>=outHeight)
return;
float sumSpectra = 0.0f;
size_t index= xId+inPadX + (yId+inPadY)*inLineWidth ;
float sum=0.0f;
for(int bin=0 ;bin<bins ; bin++)
{
sum+=pwrSpectraLogProdIn[index + inLineWidth*inLineHeight*bin];
}
pwrSpectraLogProdOut[xId + yId*outWidth]=sum;
}

__kernel void calculateErrorStats(__read_only image2d_t imgRowSums,__global float* errVals, int offX, int offY,int widthLimit, int heightLimit, int filterlimit)
{
const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP|CLK_FILTER_NEAREST;
int xID=get_global_id(0);
if(xID>=filterlimit)
return;
float4 sum=(float4)0.0f;
for(int yID=offY;yID<heightLimit;yID++)
{
sum+=read_imagef(imgRowSums,sampler,(int2)(yID,xID));
}
const float N=(widthLimit-offX)*(heightLimit-offY);
const float mu= (N > 0) ? sum.s0/N : 0.0f;
const float sum_delta2=sum.s1 - 2*mu*sum.s0 + mu*mu*N;
const float sum_delta4=sum.s3 - 4*mu*sum.s2 + 6*mu*mu*sum.s1 - 4*mu*mu*mu*sum.s0 + mu*mu*mu*mu;
const float mu4 = (N > 0) ? sum_delta4/N : 0.0;
const float sigma2 = (N > 0) ? sum_delta2/N : 0.0;
const float sigma4 = sigma2*sigma2;
const float kappa = (sigma4 > 0.0) ? mu4/sigma4 : 0.0;
errVals[xID]=sigma2;
errVals[xID+filterlimit]=kappa;
}

__kernel void calculatePartialErrorStats(__read_only image2d_t imgRowSums,__global float4* partials, int offY, int heightLimit, int filterlimit)
{
const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP|CLK_FILTER_NEAREST;
int xID=get_global_id(0);
if(xID>=filterlimit)
return;
float4 sum=(float4)0.0f;
for(int yID=offY;yID<heightLimit;yID++)
{
sum+=read_imagef(imgRowSums,sampler,(int2)(yID,xID));
}
partials[xID]=sum;
}

__kernel void sumImage(__global const float2* restrict fftOut, __global float*sumOut, unsigned int width,unsigned int height,unsigned int OffsetX,unsigned int OffsetY,unsigned int lineWidth)
{
if(get_global_id(0)>=lineWidth)
return ;
float sum=0;
for(unsigned int yId=OffsetY;yId<height;yId++)
{
size_t index= get_global_id(0) + yId*lineWidth;
sum+=fftOut[index].x;
}
if(get_global_id(0)<OffsetX || get_global_id(0)>=width)
sum=0.0f;
sumOut[get_global_id(0)]=sum;
}
#define LOCAL_MEM_SIZE_XXX 64

__kernel __attribute__((reqd_work_group_size(LOCAL_MEM_SIZE_XXX, 1, 1)))
void SummaryStatDistFilterResponse(__global const float2* restrict fftOut, __global float*sumOut, __global float*output, unsigned int width,unsigned int height,unsigned int OffsetX,unsigned int OffsetY,unsigned int lineWidth)
{
if(get_global_id(0)>=lineWidth)
return ;
__local float addmem[LOCAL_MEM_SIZE_XXX];
float sum=0.0f;
uint rep=width/get_local_size(0);
for(int block=0;block<rep;block++)
sum+= sumOut[get_local_id(0) + block*get_local_size(0)];
int remains=width-rep*get_local_size(0);
if(remains>0)
{
if(get_local_id(0)<remains)
sum+= sumOut[get_local_id(0) + rep*get_local_size(0)];
}
addmem[get_local_id(0)]=sum;
barrier(CLK_LOCAL_MEM_FENCE);
sum=0.0f;
for(int i=0;i<LOCAL_MEM_SIZE_XXX;i++)
sum+=addmem[i];
int N = (width-OffsetX)*(height-OffsetY);
float mu = (N > 0) ? sum/N : 0.0f;
/////////////////////////////////////////////////////////////////
float sum_delta2=0.0f,sum_delta4=0.0f;
for(unsigned int yId=OffsetY;yId<height;yId++)
{
size_t index= get_global_id(0) + yId*lineWidth;
float delta=fftOut[index].x-mu;
float delta2=delta*delta;
sum_delta2+=delta2;
sum_delta4+=delta2*delta2;
}
if(get_global_id(0)<OffsetX || get_global_id(0)>=width)
{
sum_delta2=0.0f;
sum_delta4=0.0f;
}
output[get_global_id(0)]=sum_delta2;
output[get_global_id(0)+lineWidth]=sum_delta4;
}

__kernel void calcMax(__global const float* restrict buff0,__global const float* restrict buff1,__global const float* restrict buff2,__global const float* restrict buff3,
__global float* maxOut,float floorLogP,unsigned int validBuff,unsigned int width,unsigned int height)
{
if(get_global_id(0)>=width)
return;
for(uint yId=0;yId<height;yId++)
{
float M=floorLogP;
switch(validBuff)
{
case 4:M= max(M,buff3[get_global_id(0) + yId*width]);
case 3:M= max(M,buff2[get_global_id(0) + yId*width]);
case 2:M= max(M,buff1[get_global_id(0) + yId*width]);
case 1:M= max(M,buff0[get_global_id(0) + yId*width]);
default:break;
}
maxOut[get_global_id(0) + yId*width]=M;
}
}

__kernel void calcProbs(__global const float* restrict logProbs,__global const float* restrict maxout,
__global float* probs, float logScale, float floorLogP, unsigned int width,unsigned int height)
{
if(get_global_id(0)>=width)
return;
for(uint yId=0;yId<height;yId++)
{
size_t index=get_global_id(0) + yId*width;
probs[index] = exp(logScale*(max(logProbs[index],floorLogP) - maxout[index]));
}
}

__kernel void calcProbsRefined(__global const float* restrict logProbs, __global float* probs,
float logScale, float floorLogP, unsigned int width,unsigned int height)
{
if(get_global_id(0)>=width)
return;
int yId = get_global_id(1) * 12;
for(int k=0; k < 12 && yId < height; k++, yId++)
{
size_t index=get_global_id(0) + yId*width;
probs[index] = exp(logScale* max(logProbs[index],floorLogP) );
}
}

__kernel void calcSum(__global const float* restrict buff0,__global const float* restrict buff1,__global const float* restrict buff2,__global const float* restrict buff3,
__global float* sumOut,unsigned int validBuff,unsigned int width,unsigned int height)
{
if(get_global_id(0)>=width)
return;
for(uint yId=0;yId<height;yId++)
{
float sum=0.0f;
switch(validBuff)
{
case 4:sum+= buff3[get_global_id(0) + yId*width];
case 3:sum+= buff2[get_global_id(0) + yId*width];
case 2:sum+= buff1[get_global_id(0) + yId*width];
case 1:sum+= buff0[get_global_id(0) + yId*width];
default:break;
}
sumOut[get_global_id(0) + yId*width]=sum;
}
}

__kernel void calcSum2(__global const float* restrict buff0,__global const float* restrict buff1,__global const float* restrict buff2,__global const float* restrict buff3,
__global float* sumOut,unsigned int validBuff,unsigned int padX,unsigned int padY, unsigned int inLineWidth,unsigned int inLineHeight,unsigned int outLineWidth)
{
if(get_global_id(0)>=inLineWidth)
return;
int yId = get_global_id(1) * 12 + padY;
for(int k=0; k < 12 && yId < inLineHeight; k++, yId++)
{
float sum=0.0f;
switch(validBuff)
{
case 4:sum+= buff3[get_global_id(0) +padX + yId*inLineWidth];
case 3:sum+= buff2[get_global_id(0) +padX + yId*inLineWidth];
case 2:sum+= buff1[get_global_id(0) +padX + yId*inLineWidth];
case 1:sum+= buff0[get_global_id(0) +padX + yId*inLineWidth];
default:break;
}
sumOut[get_global_id(0) + (yId-padY)*outLineWidth]=sum;
}
}

__kernel void computeProbs(__global float* probs,__global const float* restrict sum,unsigned int width,unsigned int height)
{
if(get_global_id(0)>=width)
return;
for(uint yId=0;yId<height;yId++)
{
size_t index=get_global_id(0) + yId*width;
probs[index]/=sum[index];
}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
