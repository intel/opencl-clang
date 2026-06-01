//The Kernels follows
const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP|CLK_FILTER_NEAREST;
#define PADDING         (32)
#define GROUP_DIMX      (32)
#define LOG_GROUP_DIMX  (5)
#define GROUP_DIMY      (2)
/*

__kernel void YVVBlurColsZeroPadf2(__global const float2 *restrict imgBuff, __global float2 *imgTemp, __write_only image2d_t imgout,
float4 bb, float scaleFactor, __global const float* restrict M,
int width, int height,  int prePadX,  int prePadY,  int postPadX,  int postPadY)
{
int xID = get_global_id(0) + prePadX;
if (xID >= width - postPadX)
return;
const  int colLimit=height - postPadY;
int yID = prePadY;
__global const float2* x =imgBuff + xID + yID*width;
__global float2* y =imgTemp + xID + yID*width;
const float bbs0=bb.s0;
float4 ymm_0=(float4)0.0f;
float4 ymm_1=(float4)0.0f;
bb.s0=0.0f;
for (;yID < colLimit;yID++) {
float2 y0 = x[0] + (float2)(dot(ymm_0,bb),dot(ymm_1,bb));
ymm_0=ymm_0.xyyz;
ymm_0.y=y0.x;
ymm_1=ymm_1.xyyz;
ymm_1.y=y0.y;
*y = y0;
x += width;
y += width;
}
const float fltSum = scaleFactor*bbs0*bbs0;
yID--;
y -= width;
float ym0 = dot(ymm_0,(float4)(0.f,M[0],M[1],M[2]))*fltSum;
float ym1 = dot(ymm_0,(float4)(0.f,M[3],M[4],M[5]))*fltSum;
float ym2 = dot(ymm_0,(float4)(0.f,M[6],M[7],M[8]))*fltSum;
ymm_0=(float4)(0.0f,ym0,ym1,ym2);
ym0 = dot(ymm_1,(float4)(0.f,M[0],M[1],M[2]))*fltSum;
ym1 = dot(ymm_1,(float4)(0.f,M[3],M[4],M[5]))*fltSum;
ym2 = dot(ymm_1,(float4)(0.f,M[6],M[7],M[8]))*fltSum;
ymm_1=(float4)(0.0f,ym0,ym1,ym2);
write_imagef(imgout,(int2)(xID,yID),(float4)(ymm_0.y,ymm_1.y,0.f,0.f));
while (yID > prePadY) {
//x -= width;
y -= width;
yID--;
float2 y0 = ((float2)fltSum) * (*y) + (float2)(dot(ymm_0,bb),dot(ymm_1,bb));
ymm_0=ymm_0.xyyz;
ymm_0.y=y0.x;
ymm_1=ymm_1.xyyz;
ymm_1.y=y0.y;
write_imagef(imgout,(int2)(xID,yID),(float4)(ymm_0.y,ymm_1.y,0.f,0.f));
}
}

__kernel void YVVBlurRowsZeroPadf2(__read_only image2d_t imgout, __global float2 *imgTemp, __write_only image2d_t imgoutRes,
float4 bb, float scaleFactor, __global const float* restrict M,
int width, int height,  int prePadX,  int prePadY,  int postPadX,  int postPadY)
{
int yID = get_global_id(0) + prePadY;
if (yID >= height - postPadY)
return;
const  int rowLimit=width - postPadX;
int xID = prePadX;
__global float2* y =imgTemp + xID*height + yID;
const float bbs0=bb.s0;
float4 ymm_0=(float4)0.0f;
float4 ymm_1=(float4)0.0f;
bb.s0=0.0f;
for (;xID < rowLimit;xID++) {
float2 x =read_imagef(imgout,sampler,(int2)(xID,yID)).xy;
float2 y0 = x + (float2)(dot(ymm_0,bb),dot(ymm_1,bb));
ymm_0=ymm_0.xyyz;
ymm_0.y=y0.x;
ymm_1=ymm_1.xyyz;
ymm_1.y=y0.y;
*y = y0;
y += height;
}
const float fltSum = scaleFactor*bbs0*bbs0;
xID--;
y -= height;
float ym0 = dot(ymm_0,(float4)(0.f,M[0],M[1],M[2]))*fltSum;
float ym1 = dot(ymm_0,(float4)(0.f,M[3],M[4],M[5]))*fltSum;
float ym2 = dot(ymm_0,(float4)(0.f,M[6],M[7],M[8]))*fltSum;
ymm_0=(float4)(0.0f,ym0,ym1,ym2);
ym0 = dot(ymm_1,(float4)(0.f,M[0],M[1],M[2]))*fltSum;
ym1 = dot(ymm_1,(float4)(0.f,M[3],M[4],M[5]))*fltSum;
ym2 = dot(ymm_1,(float4)(0.f,M[6],M[7],M[8]))*fltSum;
ymm_1=(float4)(0.0f,ym0,ym1,ym2);
write_imagef(imgoutRes,(int2)(xID,yID),(float4)(ymm_0.y,ymm_1.y,0.f,0.f));
while (xID > prePadX) {
y -= height;
xID--;
float2 y0 = ((float2)fltSum) * (*y) + (float2)(dot(ymm_0,bb),dot(ymm_1,bb));
ymm_0=ymm_0.xyyz;
ymm_0.y=y0.x;
ymm_1=ymm_1.xyyz;
ymm_1.y=y0.y;
write_imagef(imgoutRes,(int2)(xID,yID),(float4)(ymm_0.y,ymm_1.y,0.f,0.f));
}
}

__kernel void YVVBlurRowsZeroPadf2_nSum(__read_only image2d_t imgout, __global float2 *imgTemp, __write_only image2d_t imgoutRes,__write_only image2d_t sumImg,
float4 bb, float scaleFactor, __global const float*  restrict M,
int width, int height,  int prePadX,  int prePadY,  int postPadX,  int postPadY, int kkF,int xOff,int widthLimit)
{
int yID = get_global_id(0) + prePadY;
if (yID >= height - postPadY)
return;
const  int rowLimit=width - postPadX;
int xID = prePadX;
__global float2* y =imgTemp + xID*height + yID;
const float bbs0=bb.s0;
float4 ymm_0=(float4)0.0f;
float4 ymm_1=(float4)0.0f;
bb.s0=0.0f;
for (;xID < rowLimit;xID++) {
float2 x =read_imagef(imgout,sampler,(int2)(xID,yID)).xy;
float2 y0 = x + (float2)(dot(ymm_0,bb),dot(ymm_1,bb));
ymm_0=ymm_0.xyyz;
ymm_0.y=y0.x;
ymm_1=ymm_1.xyyz;
ymm_1.y=y0.y;
*y = y0;
y += height;
}
const float fltSum = scaleFactor*bbs0*bbs0;
xID--;
y -= height;
float ym0 = dot(ymm_0,(float4)(0.f,M[0],M[1],M[2]))*fltSum;
float ym1 = dot(ymm_0,(float4)(0.f,M[3],M[4],M[5]))*fltSum;
float ym2 = dot(ymm_0,(float4)(0.f,M[6],M[7],M[8]))*fltSum;
ymm_0=(float4)(0.0f,ym0,ym1,ym2);
ym0 = dot(ymm_1,(float4)(0.f,M[0],M[1],M[2]))*fltSum;
ym1 = dot(ymm_1,(float4)(0.f,M[3],M[4],M[5]))*fltSum;
ym2 = dot(ymm_1,(float4)(0.f,M[6],M[7],M[8]))*fltSum;
ymm_1=(float4)(0.0f,ym0,ym1,ym2);
float4 sum=(float4)0.0f;
write_imagef(imgoutRes,(int2)(xID,yID),(float4)(ymm_0.y,ymm_1.y,0.f,0.f));
sum.x=ymm_0.y;
if(xID<xOff || xID>=widthLimit)
sum.x=0.0f;
sum.y=sum.x*sum.x;
sum.z=sum.y*sum.x;
sum.w=sum.y*sum.y;
while (xID > prePadX) {
y -= height;
xID--;
float2 y0 = ((float2)fltSum) * (*y) + (float2)(dot(ymm_0,bb),dot(ymm_1,bb));
ymm_0=ymm_0.xyyz;
ymm_0.y=y0.x;
ymm_1=ymm_1.xyyz;
ymm_1.y=y0.y;
write_imagef(imgoutRes,(int2)(xID,yID),(float4)(ymm_0.y,ymm_1.y,0.f,0.f));
if(xID<xOff || xID>=widthLimit)
y0=(float2)0.0f;
y0.y=y0.x*y0.x;
sum.x+=y0.x;
sum.y+=y0.y;
sum.z+=y0.x*y0.y;
sum.w+=y0.y*y0.y;
}
write_imagef(sumImg,(int2)(yID,kkF),sum);
}*/
inline float dot2(int2 a, int2 b)
{
return  (float)(a.x*b.x+a.y*b.y);
}

__kernel void ShiftImageFrequencies(__global float *imgBuff, __global float2 *imgBuffOut, int2 hh, int2 kk, int width, int height){
int xID=get_global_id(0);
int yID=get_global_id(1);
if(xID>=width || yID>=height)
return;
float angInc=2*3.14159f/dot2(kk,kk);//2*pi/(kx*kx+ky*ky);
int xInc=dot2(hh,kk);//(hx*kx+hy*ky);
int yInc=dot2(hh,(int2)(-kk.y,kk.x));//(-hx*ky+hy*kx);
float x=imgBuff[xID+yID*width];
float angle=( xID*xInc + yID*yInc) * angInc;
float2 out=(float2)(x*cos(angle),x*sin(angle));
//P.real= P.real* sin(( xID*xInc + yID*yInc) * angInc);
//P.img= P.img  * cos(( xID*xInc + yID*yInc) * angInc);
imgBuffOut[xID+yID*width]=out;
}

__kernel void ShiftImageFrequencies2(__global float *imgBuff, __global float2 *imgBuffOut, int2 hh, int2 kk, int width, int height){
if(get_global_id(0)>=width)
return;
int xID= get_global_id(0);
int yID = get_global_id(1) * 12;
float angInc=2*3.14159f/dot2(kk,kk);//2*pi/(kx*kx+ky*ky);
int xInc=dot2(hh,kk);//(hx*kx+hy*ky);
int yInc=dot2(hh,(int2)(-kk.y,kk.x));//(-hx*ky+hy*kx);
for(int k=0; k < 12 && yID < height; k++, yID++)
{
float x=imgBuff[xID+yID*width];
float angle=( xID*xInc + yID*yInc) * angInc;
float2 out=(float2)(x*cos(angle),x*sin(angle));
imgBuffOut[xID+yID*width]=out;
}
}
#define BLOCK_SIZE 16

__kernel void RecursiveGaussianAlgo4Step1_3order_float2(__global const float2 * src,__global float4 * ProImage_01,__global float2 * ProImage_2,
__global float4 *EpiImage_01,__global float2 *EpiImage_2,
const int width,const int prePadY,const int block_size,const int n_blocks_y, const float Gamma, const float Beta, const float Alpha, const float fltSum,
__constant float4* epilogfactors,const int padding)
{
int global_id_x=(int)get_global_id(0);
int global_id_y=(int)get_global_id(1);
if(global_id_x>=width ||global_id_y>=n_blocks_y-1)
return ;
float2 ProLogue0=0.0f;
float2 ProLogue1=0.0f;
float2 ProLogue2=0.0f;
float2 EpiLogue0=0.0f;
float2 EpiLogue1=0.0f;
float2 EpiLogue2=0.0f;
float2 capixel=0.f;
//#pragma unroll
for(int pidy=0;pidy<BLOCK_SIZE;pidy++)
{
capixel= src[global_id_x+(pidy+prePadY+global_id_y*BLOCK_SIZE)*(width+padding)];
EpiLogue0+= ((float2)(epilogfactors[pidy].x*fltSum)) * capixel;
EpiLogue1+= ((float2)(epilogfactors[pidy].y*fltSum)) * capixel;
EpiLogue2+= ((float2)(epilogfactors[pidy].z*fltSum)) * capixel;
float2 temp = capixel + ProLogue0*(float2)Gamma + ProLogue1*(float2)Beta + ProLogue2*(float2)Alpha;
ProLogue0=ProLogue1;
ProLogue1=ProLogue2;
ProLogue2=temp;
}
ProImage_01[global_id_x+global_id_y*width]=(float4)(ProLogue0.x,ProLogue0.y,ProLogue1.x,ProLogue1.y);
ProImage_2[global_id_x+global_id_y*width]=ProLogue2;
EpiImage_01[global_id_x+global_id_y*width]=(float4)(EpiLogue0.x,EpiLogue0.y,EpiLogue1.x,EpiLogue1.y);
EpiImage_2[global_id_x+global_id_y*width]=EpiLogue2;
}

__kernel void RecursiveGaussianAlgo4Step2_3_order3_float2(__global const float2 * src,__global float2 * dst,__global const float4 * inProImage_01,__global const float2 * inProImage_2,
__global float4* cProImage_01,__global float2* cProImage_2,__global const float4 * inEpiImage_01,__global const float2 * inEpiImage_2,
__global float4* cEpiImage_01,__global float2* cEpiImage_2, const float8 M07,const float M8,const float fltSum,const float Gamma, const float Beta, const float Alpha,
const int width, const int padding, const int lastBlkHeight,const int prePadY,
const int width4,const int width2,const int block_size,const int n_block_y,
const float p2p2, const float p2p1, const float p2p0,
const float p1p2, const float p1p1, const float p1p0,
const float p0p2, const float p0p1, const float p0p0,
const float p2e2, const float p2e1, const float p2e0,
const float p1e2, const float p1e1, const float p1e0,
const float p0e2, const float p0e1, const float p0e0)
{
int global_id_x=(int)get_global_id(0);
if(global_id_x>=width)
return ;
float2 ProLogue0=0.0f;
float2 ProLogue1=0.0f;
float2 ProLogue2=0.0f;
for(int pidy=0;pidy<n_block_y-1;pidy++)
{
float4 p=inProImage_01[global_id_x+(pidy)*width4];
p.xy+= ProLogue0*(float2)p0p0 + ProLogue1*(float2)p1p0 + ProLogue2*(float2)p2p0;
p.zw+= ProLogue0*(float2)p0p1 + ProLogue1*(float2)p1p1 + ProLogue2*(float2)p2p1;
float2 p_2=inProImage_2[global_id_x+(pidy)*width2];
p_2+=  ProLogue0*(float2)p0p2 + ProLogue1*(float2)p1p2 + ProLogue2*(float2)p2p2;
cProImage_01[global_id_x+(pidy)*width4]=p;
cProImage_2[global_id_x+(pidy)*width2]=p_2;
ProLogue0=p.xy;
ProLogue1=p.zw;
ProLogue2=p_2;
}
int global_id_y=n_block_y-1;
for(int pidy=0;pidy<lastBlkHeight;pidy++)
{
float2 capixel= src[global_id_x+(pidy+prePadY+global_id_y*BLOCK_SIZE)*(width+padding)];
capixel = capixel + ProLogue0*(float2)Gamma + ProLogue1*(float2)Beta + ProLogue2*(float2)Alpha;
dst[global_id_x+(pidy+prePadY+global_id_y*BLOCK_SIZE)*(width)]=capixel;
ProLogue0=ProLogue1;
ProLogue1=ProLogue2;
ProLogue2=capixel;
}
float2 epiLogue0=(ProLogue0 * (float2)M07.s2 + ProLogue1 * (float2)M07.s1 + ProLogue2 * (float2)M07.s0)*(float2)fltSum;
float2 epiLogue1=(ProLogue0 * (float2)M07.s5 + ProLogue1 * (float2)M07.s4 + ProLogue2 * (float2)M07.s3)*(float2)fltSum;
float2 epiLogue2=(ProLogue0 * (float2)M8     + ProLogue1 * (float2)M07.s7 + ProLogue2 * (float2)M07.s6)*(float2)fltSum;
dst[global_id_x+(prePadY+(lastBlkHeight-1)+global_id_y*BLOCK_SIZE)*(width)]=epiLogue0;
for(int pidy=lastBlkHeight-2;pidy>=0;pidy--)
{
float2 temp=dst[global_id_x+(pidy+prePadY+global_id_y*BLOCK_SIZE)*(width)];
temp= temp*(float2)fltSum + epiLogue0 * (float2)Alpha + epiLogue1 * (float2)Beta + epiLogue2 * (float2)Gamma;
epiLogue2=epiLogue1;
epiLogue1=epiLogue0;
epiLogue0=temp;
dst[global_id_x+(pidy+prePadY+global_id_y*BLOCK_SIZE)*(width)]=epiLogue0;
}
float4 ep01=(float4){epiLogue0.x,epiLogue0.y,epiLogue1.x,epiLogue1.y};
cEpiImage_01[global_id_x+(n_block_y-1)*width4]=ep01;
cEpiImage_2[global_id_x+(n_block_y-1)*width2]=epiLogue2;
for(int eidy=n_block_y-2;eidy>0;eidy--)
{
float4 iEpi_01=inEpiImage_01[global_id_x+(eidy)*width4];
float4 cPro_01= cProImage_01[global_id_x+(eidy-1)*width4];
float2 iEpi_2=inEpiImage_2[global_id_x+(eidy)*width2];
float2 cPro_2= cProImage_2[global_id_x+(eidy-1)*width2];
iEpi_01.xy+=cPro_01.xy*(float2)(p0e0*fltSum) + cPro_01.zw*(float2)(p1e0*fltSum) + cPro_2*(float2)(p2e0*fltSum) + epiLogue0*(float2)p2p2 + epiLogue1*(float2)p1p2 + epiLogue2*(float2)p0p2;
iEpi_01.zw+=cPro_01.xy*(float2)(p0e1*fltSum) + cPro_01.zw*(float2)(p1e1*fltSum) + cPro_2*(float2)(p2e1*fltSum) + epiLogue0*(float2)p2p1 + epiLogue1*(float2)p1p1 + epiLogue2*(float2)p0p1;
iEpi_2+=cPro_01.xy*(float2)(p0e2*fltSum) + cPro_01.zw*(float2)(p1e2*fltSum) + cPro_2*(float2)(p2e2*fltSum) + epiLogue0*(float2)p2p0 + epiLogue1*(float2)p1p0 + epiLogue2*(float2)p0p0;
cEpiImage_01[global_id_x+(eidy)*width4]=iEpi_01;
cEpiImage_2[global_id_x+(eidy)*width2]=iEpi_2;
epiLogue0=iEpi_01.xy;
epiLogue1=iEpi_01.zw;
epiLogue2=iEpi_2;
}
//for m=-1 prologue must be zero.
float4 iEpi_01=inEpiImage_01[global_id_x];
float2 iEpi_2=inEpiImage_2[global_id_x];
iEpi_01.xy+= epiLogue0*(float2)p2p2 + epiLogue1*(float2)p1p2 + epiLogue2*(float2)p0p2;
iEpi_01.zw+= epiLogue0*(float2)p2p1 + epiLogue1*(float2)p1p1 + epiLogue2*(float2)p0p1;
iEpi_2+= epiLogue0*(float2)p2p0 + epiLogue1*(float2)p1p0 + epiLogue2*(float2)p0p0;
cEpiImage_01[global_id_x]=iEpi_01;
cEpiImage_2[global_id_x]=iEpi_2;
}

__kernel void RecursiveGaussianAlgo4Step2_3_order3_float2_sum(__global const float2 * src,__global float2 * dst,__global const float4 * inProImage_01,__global const float2 * inProImage_2,
__global float4* cProImage_01,__global float2* cProImage_2,__global const float4 * inEpiImage_01,__global const float2 * inEpiImage_2,
__global float4* cEpiImage_01,__global float2* cEpiImage_2, __global float4* sumImg_4, const int kkF,
const float8 M07,const float M8,const float fltSum,const float Gamma, const float Beta, const float Alpha,
const int width, const int padding, const int lastBlkHeight,const int prePadY, const int rowLimit,
const int width4,const int width2,const int block_size,const int n_block_y,
const float p2p2, const float p2p1, const float p2p0,
const float p1p2, const float p1p1, const float p1p0,
const float p0p2, const float p0p1, const float p0p0,
const float p2e2, const float p2e1, const float p2e0,
const float p1e2, const float p1e1, const float p1e0,
const float p0e2, const float p0e1, const float p0e0)
{
int global_id_x=(int)get_global_id(0);
if(global_id_x>=width)
return ;
float2 ProLogue0=0.0f;
float2 ProLogue1=0.0f;
float2 ProLogue2=0.0f;
for(int pidy=0;pidy<n_block_y-1;pidy++)
{
float4 p=inProImage_01[global_id_x+(pidy)*width4];
p.xy+= ProLogue0*(float2)p0p0 + ProLogue1*(float2)p1p0 + ProLogue2*(float2)p2p0;
p.zw+= ProLogue0*(float2)p0p1 + ProLogue1*(float2)p1p1 + ProLogue2*(float2)p2p1;
float2 p_2=inProImage_2[global_id_x+(pidy)*width2];
p_2+=  ProLogue0*(float2)p0p2 + ProLogue1*(float2)p1p2 + ProLogue2*(float2)p2p2;
cProImage_01[global_id_x+(pidy)*width4]=p;
cProImage_2[global_id_x+(pidy)*width2]=p_2;
ProLogue0=p.xy;
ProLogue1=p.zw;
ProLogue2=p_2;
}
int global_id_y=n_block_y-1;
for(int pidy=0;pidy<lastBlkHeight;pidy++)
{
float2 capixel= src[global_id_x+(pidy+prePadY+global_id_y*BLOCK_SIZE)*(width+padding)];
capixel = capixel + ProLogue0*(float2)Gamma + ProLogue1*(float2)Beta + ProLogue2*(float2)Alpha;
dst[global_id_x+(pidy+prePadY+global_id_y*BLOCK_SIZE)*(width)]=capixel;
ProLogue0=ProLogue1;
ProLogue1=ProLogue2;
ProLogue2=capixel;
}
float2 epiLogue0=(ProLogue0 * (float2)M07.s2 + ProLogue1 * (float2)M07.s1 + ProLogue2 * (float2)M07.s0)*(float2)fltSum;
float2 epiLogue1=(ProLogue0 * (float2)M07.s5 + ProLogue1 * (float2)M07.s4 + ProLogue2 * (float2)M07.s3)*(float2)fltSum;
float2 epiLogue2=(ProLogue0 * (float2)M8     + ProLogue1 * (float2)M07.s7 + ProLogue2 * (float2)M07.s6)*(float2)fltSum;
int yId=prePadY+(lastBlkHeight-1)+global_id_y*BLOCK_SIZE;
dst[global_id_x+(yId)*(width)]=epiLogue0;
float out=epiLogue0.x*epiLogue0.x;
float4 sum=(float4)0.0f;
if(yId<rowLimit)
sum+=(float4)(epiLogue0.x,out,epiLogue0.x*out,out*out);
for(int pidy=lastBlkHeight-2;pidy>=0;pidy--)
{
yId=pidy+prePadY+global_id_y*BLOCK_SIZE;
float2 temp=dst[global_id_x+(yId)*(width)];
temp= temp*(float2)fltSum + epiLogue0 * (float2)Alpha + epiLogue1 * (float2)Beta + epiLogue2 * (float2)Gamma;
epiLogue2=epiLogue1;
epiLogue1=epiLogue0;
epiLogue0=temp;
dst[global_id_x+(yId)*(width)]=epiLogue0;
out=epiLogue0.x*epiLogue0.x;
if(yId<rowLimit)
sum+=(float4)(epiLogue0.x,out,epiLogue0.x*out,out*out);
}
sumImg_4[global_id_x + (n_block_y-1 )*width ]=sum;
float4 ep01=(float4){epiLogue0.x,epiLogue0.y,epiLogue1.x,epiLogue1.y};
cEpiImage_01[global_id_x+(n_block_y-1)*width4]=ep01;
cEpiImage_2[global_id_x+(n_block_y-1)*width2]=epiLogue2;
for(int eidy=n_block_y-2;eidy>0;eidy--)
{
float4 iEpi_01=inEpiImage_01[global_id_x+(eidy)*width4];
float4 cPro_01= cProImage_01[global_id_x+(eidy-1)*width4];
float2 iEpi_2=inEpiImage_2[global_id_x+(eidy)*width2];
float2 cPro_2= cProImage_2[global_id_x+(eidy-1)*width2];
iEpi_01.xy+=cPro_01.xy*(float2)(p0e0*fltSum) + cPro_01.zw*(float2)(p1e0*fltSum) + cPro_2*(float2)(p2e0*fltSum) + epiLogue0*(float2)p2p2 + epiLogue1*(float2)p1p2 + epiLogue2*(float2)p0p2;
iEpi_01.zw+=cPro_01.xy*(float2)(p0e1*fltSum) + cPro_01.zw*(float2)(p1e1*fltSum) + cPro_2*(float2)(p2e1*fltSum) + epiLogue0*(float2)p2p1 + epiLogue1*(float2)p1p1 + epiLogue2*(float2)p0p1;
iEpi_2+=cPro_01.xy*(float2)(p0e2*fltSum) + cPro_01.zw*(float2)(p1e2*fltSum) + cPro_2*(float2)(p2e2*fltSum) + epiLogue0*(float2)p2p0 + epiLogue1*(float2)p1p0 + epiLogue2*(float2)p0p0;
cEpiImage_01[global_id_x+(eidy)*width4]=iEpi_01;
cEpiImage_2[global_id_x+(eidy)*width2]=iEpi_2;
epiLogue0=iEpi_01.xy;
epiLogue1=iEpi_01.zw;
epiLogue2=iEpi_2;
}
//for m=-1 prologue must be zero.
float4 iEpi_01=inEpiImage_01[global_id_x];
float2 iEpi_2=inEpiImage_2[global_id_x];
iEpi_01.xy+= epiLogue0*(float2)p2p2 + epiLogue1*(float2)p1p2 + epiLogue2*(float2)p0p2;
iEpi_01.zw+= epiLogue0*(float2)p2p1 + epiLogue1*(float2)p1p1 + epiLogue2*(float2)p0p1;
iEpi_2+= epiLogue0*(float2)p2p0 + epiLogue1*(float2)p1p0 + epiLogue2*(float2)p0p0;
cEpiImage_01[global_id_x]=iEpi_01;
cEpiImage_2[global_id_x]=iEpi_2;
}

__kernel void RecursiveGaussianAlgo4Step4_order3_float2(__global const float2 * src,__global const float4 * cProImage_01,
__global const float2 * cProImage_2,__global const float4 * cEpiImage_01,__global const float2 * cEpiImage_2,__global float2 *dst,
const int width,const int height,const int block_size,const int n_blocks_y, const float gamma,const float beta,const float alpha,
const float invGamma,const float fltSum,const int padding,const int prePadY)
{
int global_id_x=(int)get_global_id(0);
int global_id_y=(int)get_global_id(1);
if(global_id_x>=width ||global_id_y>=n_blocks_y-1)
return ;
float2 ProLogue0=0.0f;
float2 ProLogue1=0.0f;
float2 ProLogue2=0.0f;
float2 EpiLogue0=0.0f;
float2 EpiLogue1=0.0f;
float2 EpiLogue2=0.0f;
if(global_id_y!=0)
{
float4 p=cProImage_01[global_id_x+(global_id_y-1)*width];
ProLogue0=p.xy;
ProLogue1=p.zw;
ProLogue2=cProImage_2[global_id_x+(global_id_y-1)*width];
}
__global const float2 * data=src + global_id_x +  (prePadY+global_id_y*BLOCK_SIZE)*(width+padding);
float4 p=cEpiImage_01[global_id_x+(global_id_y)*width];
EpiLogue0=p.xy;
EpiLogue1=p.zw;
EpiLogue2=cEpiImage_2[global_id_x+(global_id_y)*width];
float2 out=EpiLogue0;
#pragma unroll
for(int idy=0;idy<BLOCK_SIZE;idy++)
{
if(idy<BLOCK_SIZE-3)
dst[global_id_x+(idy+prePadY+global_id_y*BLOCK_SIZE)*(width)]=out;
float2 p=data[0]+ ProLogue0*(float2)gamma+ProLogue1*(float2)beta+ProLogue2*(float2)alpha;
out=(out - p*(float2)fltSum - EpiLogue1*(float2)alpha -EpiLogue2*(float2)beta )*(float2)invGamma;
EpiLogue0=EpiLogue1;
EpiLogue1=EpiLogue2;
EpiLogue2=out;
ProLogue0=ProLogue1;
ProLogue1=ProLogue2;
ProLogue2=p;
out=EpiLogue0;
data+=(width+padding);
}
p=cEpiImage_01[global_id_x+(global_id_y+1)*width];
EpiLogue0=p.xy;
EpiLogue1=p.zw;
EpiLogue2=cEpiImage_2[global_id_x+(global_id_y+1)*width];
out=ProLogue2*(float2)fltSum + EpiLogue0*(float2)alpha +EpiLogue1*(float2)beta +EpiLogue2*(float2)gamma;
dst[global_id_x+(BLOCK_SIZE-1+prePadY+global_id_y*BLOCK_SIZE)*(width)]=out;
EpiLogue2=EpiLogue1;
EpiLogue1=EpiLogue0;
EpiLogue0=out;
out=ProLogue1*(float2)fltSum + EpiLogue0*(float2)alpha +EpiLogue1*(float2)beta +EpiLogue2*(float2)gamma;
dst[global_id_x+(BLOCK_SIZE-2+prePadY+global_id_y*BLOCK_SIZE)*(width)]=out;
EpiLogue2=EpiLogue1;
EpiLogue1=EpiLogue0;
EpiLogue0=out;
out=ProLogue1*(float2)fltSum + EpiLogue0*(float2)alpha +EpiLogue1*(float2)beta +EpiLogue2*(float2)gamma;
dst[global_id_x+(BLOCK_SIZE-3+prePadY+global_id_y*BLOCK_SIZE)*(width)]=out;
EpiLogue2=EpiLogue1;
EpiLogue1=EpiLogue0;
EpiLogue0=out;
}

__kernel void RecursiveGaussianAlgo4Step1_3order_float2_img(__read_only image2d_t src,__global float4 * ProImage_01,__global float2 * ProImage_2,
__global float4 *EpiImage_01,__global float2 *EpiImage_2,
const int height,const int prePadX,const int block_size,const int n_blocks_x, const float Gamma, const float Beta, const float Alpha, const float fltSum,
__constant float4* epilogfactors,const int padding)
{
int global_id_x=(int)get_global_id(0);
int global_id_y=(int)get_global_id(1);
if(global_id_x>=n_blocks_x-1 ||global_id_y>=height)
return ;
float2 ProLogue0=0.0f;
float2 ProLogue1=0.0f;
float2 ProLogue2=0.0f;
float2 EpiLogue0=0.0f;
float2 EpiLogue1=0.0f;
float2 EpiLogue2=0.0f;
float2 capixel=0.f;
//#pragma unroll
for(int pidx=0;pidx<BLOCK_SIZE;pidx++)
{
capixel= read_imagef(src,sampler,(int2)(pidx+prePadX+global_id_x*BLOCK_SIZE,global_id_y)).xy;
EpiLogue0+= ((float2)(epilogfactors[pidx].x*fltSum)) * capixel;
EpiLogue1+= ((float2)(epilogfactors[pidx].y*fltSum)) * capixel;
EpiLogue2+= ((float2)(epilogfactors[pidx].z*fltSum)) * capixel;
float2 temp = capixel + ProLogue0*(float2)Gamma + ProLogue1*(float2)Beta + ProLogue2*(float2)Alpha;
ProLogue0=ProLogue1;
ProLogue1=ProLogue2;
ProLogue2=temp;
}
ProImage_01[global_id_x*height+global_id_y]=(float4)(ProLogue0.x,ProLogue0.y,ProLogue1.x,ProLogue1.y);
ProImage_2[global_id_x*height+global_id_y]=ProLogue2;
EpiImage_01[global_id_x*height+global_id_y]=(float4)(EpiLogue0.x,EpiLogue0.y,EpiLogue1.x,EpiLogue1.y);
EpiImage_2[global_id_x*height+global_id_y]=EpiLogue2;
}

__kernel void RecursiveGaussianAlgo4Step2_3_order3_float2_row_img(__read_only image2d_t src,__global float2 * dst,__global const float4 * inProImage_01,__global const float2 * inProImage_2,
__global float4* cProImage_01,__global float2* cProImage_2,__global const float4 * inEpiImage_01,__global const float2 * inEpiImage_2,
__global float4* cEpiImage_01,__global float2* cEpiImage_2, const float8 M07,const float M8,const float fltSum,const float Gamma, const float Beta, const float Alpha,
const int height, const int padding, const int lastBlkHeight,const int prePadX,
const int height4,const int height2,const int block_size,const int n_block_x,
const float p2p2, const float p2p1, const float p2p0,
const float p1p2, const float p1p1, const float p1p0,
const float p0p2, const float p0p1, const float p0p0,
const float p2e2, const float p2e1, const float p2e0,
const float p1e2, const float p1e1, const float p1e0,
const float p0e2, const float p0e1, const float p0e0)
{
int global_id_y=(int)get_global_id(1);
if(global_id_y>=height)
return ;
float2 ProLogue0=0.0f;
float2 ProLogue1=0.0f;
float2 ProLogue2=0.0f;
for(int pidx=0;pidx<n_block_x-1;pidx++)
{
float4 p=inProImage_01[global_id_y+(pidx)*height4];
p.xy+= ProLogue0*(float2)p0p0 + ProLogue1*(float2)p1p0 + ProLogue2*(float2)p2p0;
p.zw+= ProLogue0*(float2)p0p1 + ProLogue1*(float2)p1p1 + ProLogue2*(float2)p2p1;
float2 p_2=inProImage_2[global_id_y+(pidx)*height2];
p_2+=  ProLogue0*(float2)p0p2 + ProLogue1*(float2)p1p2 + ProLogue2*(float2)p2p2;
cProImage_01[global_id_y+(pidx)*height4]=p;
cProImage_2[global_id_y+(pidx)*height2]=p_2;
ProLogue0=p.xy;
ProLogue1=p.zw;
ProLogue2=p_2;
}
int global_id_x=n_block_x-1;
for(int pidx=0;pidx<lastBlkHeight;pidx++)
{
float2 capixel= read_imagef(src,sampler,(int2)(pidx+prePadX+global_id_x*BLOCK_SIZE,global_id_y)).xy;
capixel = capixel + ProLogue0*(float2)Gamma + ProLogue1*(float2)Beta + ProLogue2*(float2)Alpha;
dst[global_id_y+(pidx+prePadX+global_id_x*BLOCK_SIZE)*(height)]=capixel;
ProLogue0=ProLogue1;
ProLogue1=ProLogue2;
ProLogue2=capixel;
}
float2 epiLogue0=(ProLogue0 * (float2)M07.s2 + ProLogue1 * (float2)M07.s1 + ProLogue2 * (float2)M07.s0)*(float2)fltSum;
float2 epiLogue1=(ProLogue0 * (float2)M07.s5 + ProLogue1 * (float2)M07.s4 + ProLogue2 * (float2)M07.s3)*(float2)fltSum;
float2 epiLogue2=(ProLogue0 * (float2)M8     + ProLogue1 * (float2)M07.s7 + ProLogue2 * (float2)M07.s6)*(float2)fltSum;
dst[global_id_y+(prePadX+(lastBlkHeight-1)+global_id_x*BLOCK_SIZE)*(height)]=epiLogue0;
for(int pidx=lastBlkHeight-2;pidx>=0;pidx--)
{
float2 temp=dst[global_id_y+(pidx+prePadX+global_id_x*BLOCK_SIZE)*(height)];
temp= temp*(float2)fltSum + epiLogue0 * (float2)Alpha + epiLogue1 * (float2)Beta + epiLogue2 * (float2)Gamma;
epiLogue2=epiLogue1;
epiLogue1=epiLogue0;
epiLogue0=temp;
dst[global_id_y+(pidx+prePadX+global_id_x*BLOCK_SIZE)*(height)]=epiLogue0;
}
float4 ep01=(float4){epiLogue0.x,epiLogue0.y,epiLogue1.x,epiLogue1.y};
cEpiImage_01[global_id_y+(n_block_x-1)*height4]=ep01;
cEpiImage_2[global_id_y+(n_block_x-1)*height2]=epiLogue2;
for(int eidx=n_block_x-2;eidx>0;eidx--)
{
float4 iEpi_01=inEpiImage_01[global_id_y+(eidx)*height4];
float4 cPro_01= cProImage_01[global_id_y+(eidx-1)*height4];
float2 iEpi_2=inEpiImage_2[global_id_y+(eidx)*height2];
float2 cPro_2= cProImage_2[global_id_y+(eidx-1)*height2];
iEpi_01.xy+=cPro_01.xy*(float2)(p0e0*fltSum) + cPro_01.zw*(float2)(p1e0*fltSum) + cPro_2*(float2)(p2e0*fltSum) + epiLogue0*(float2)p2p2 + epiLogue1*(float2)p1p2 + epiLogue2*(float2)p0p2;
iEpi_01.zw+=cPro_01.xy*(float2)(p0e1*fltSum) + cPro_01.zw*(float2)(p1e1*fltSum) + cPro_2*(float2)(p2e1*fltSum) + epiLogue0*(float2)p2p1 + epiLogue1*(float2)p1p1 + epiLogue2*(float2)p0p1;
iEpi_2+=cPro_01.xy*(float2)(p0e2*fltSum) + cPro_01.zw*(float2)(p1e2*fltSum) + cPro_2*(float2)(p2e2*fltSum) + epiLogue0*(float2)p2p0 + epiLogue1*(float2)p1p0 + epiLogue2*(float2)p0p0;
cEpiImage_01[global_id_y+(eidx)*height4]=iEpi_01;
cEpiImage_2[global_id_y+(eidx)*height2]=iEpi_2;
epiLogue0=iEpi_01.xy;
epiLogue1=iEpi_01.zw;
epiLogue2=iEpi_2;
}
//for m=-1 prologue must be zero.
float4 iEpi_01=inEpiImage_01[global_id_y];
float2 iEpi_2=inEpiImage_2[global_id_y];
iEpi_01.xy+= epiLogue0*(float2)p2p2 + epiLogue1*(float2)p1p2 + epiLogue2*(float2)p0p2;
iEpi_01.zw+= epiLogue0*(float2)p2p1 + epiLogue1*(float2)p1p1 + epiLogue2*(float2)p0p1;
iEpi_2+= epiLogue0*(float2)p2p0 + epiLogue1*(float2)p1p0 + epiLogue2*(float2)p0p0;
cEpiImage_01[global_id_y]=iEpi_01;
cEpiImage_2[global_id_y]=iEpi_2;
}

__kernel void RecursiveGaussianAlgo4Step2_3_order3_float2_row_img_sum(__read_only image2d_t src,__global float2 * dst,__global const float4 * inProImage_01,__global const float2 * inProImage_2,
__global float4* cProImage_01,__global float2* cProImage_2,__global const float4 * inEpiImage_01,__global const float2 * inEpiImage_2,
__global float4* cEpiImage_01,__global float2* cEpiImage_2, __global float4* sumImg_4, const int kkF,
const float8 M07,const float M8,const float fltSum,const float Gamma, const float Beta, const float Alpha,
const int height, const int padding, const int lastBlkHeight,const int prePadX, const int rowLimit,
const int height4,const int height2,const int block_size,const int n_block_x,
const float p2p2, const float p2p1, const float p2p0,
const float p1p2, const float p1p1, const float p1p0,
const float p0p2, const float p0p1, const float p0p0,
const float p2e2, const float p2e1, const float p2e0,
const float p1e2, const float p1e1, const float p1e0,
const float p0e2, const float p0e1, const float p0e0)
{
int global_id_y=(int)get_global_id(1);
if(global_id_y>=height)
return ;
float2 ProLogue0=0.0f;
float2 ProLogue1=0.0f;
float2 ProLogue2=0.0f;
for(int pidx=0;pidx<n_block_x-1;pidx++)
{
float4 p=inProImage_01[global_id_y+(pidx)*height4];
p.xy+= ProLogue0*(float2)p0p0 + ProLogue1*(float2)p1p0 + ProLogue2*(float2)p2p0;
p.zw+= ProLogue0*(float2)p0p1 + ProLogue1*(float2)p1p1 + ProLogue2*(float2)p2p1;
float2 p_2=inProImage_2[global_id_y+(pidx)*height2];
p_2+=  ProLogue0*(float2)p0p2 + ProLogue1*(float2)p1p2 + ProLogue2*(float2)p2p2;
cProImage_01[global_id_y+(pidx)*height4]=p;
cProImage_2[global_id_y+(pidx)*height2]=p_2;
ProLogue0=p.xy;
ProLogue1=p.zw;
ProLogue2=p_2;
}
int global_id_x=n_block_x-1;
for(int pidx=0;pidx<lastBlkHeight;pidx++)
{
float2 capixel= read_imagef(src,sampler,(int2)(pidx+prePadX+global_id_x*BLOCK_SIZE,global_id_y)).xy;
capixel = capixel + ProLogue0*(float2)Gamma + ProLogue1*(float2)Beta + ProLogue2*(float2)Alpha;
dst[global_id_y+(pidx+prePadX+global_id_x*BLOCK_SIZE)*(height)]=capixel;
ProLogue0=ProLogue1;
ProLogue1=ProLogue2;
ProLogue2=capixel;
}
float2 epiLogue0=(ProLogue0 * (float2)M07.s2 + ProLogue1 * (float2)M07.s1 + ProLogue2 * (float2)M07.s0)*(float2)fltSum;
float2 epiLogue1=(ProLogue0 * (float2)M07.s5 + ProLogue1 * (float2)M07.s4 + ProLogue2 * (float2)M07.s3)*(float2)fltSum;
float2 epiLogue2=(ProLogue0 * (float2)M8     + ProLogue1 * (float2)M07.s7 + ProLogue2 * (float2)M07.s6)*(float2)fltSum;
int xId=prePadX+(lastBlkHeight-1)+global_id_x*BLOCK_SIZE;
dst[global_id_y+(xId)*(height)]=epiLogue0;
float out=epiLogue0.x*epiLogue0.x;
float4 sum=(float4)0.0f;
if(xId<rowLimit)
sum+=(float4)(epiLogue0.x,out,epiLogue0.x*out,out*out);
for(int pidx=lastBlkHeight-2;pidx>=0;pidx--)
{
xId=pidx+prePadX+global_id_x*BLOCK_SIZE;
float2 temp=dst[global_id_y+(xId)*(height)];
temp= temp*(float2)fltSum + epiLogue0 * (float2)Alpha + epiLogue1 * (float2)Beta + epiLogue2 * (float2)Gamma;
epiLogue2=epiLogue1;
epiLogue1=epiLogue0;
epiLogue0=temp;
dst[global_id_y+(xId)*(height)]=epiLogue0;
out=epiLogue0.x*epiLogue0.x;
if(xId<rowLimit)
sum+=(float4)(epiLogue0.x,out,epiLogue0.x*out,out*out);
}
sumImg_4[global_id_y + (n_block_x-1 )*height ]=sum;
float4 ep01=(float4){epiLogue0.x,epiLogue0.y,epiLogue1.x,epiLogue1.y};
cEpiImage_01[global_id_y+(n_block_x-1)*height4]=ep01;
cEpiImage_2[global_id_y+(n_block_x-1)*height2]=epiLogue2;
for(int eidx=n_block_x-2;eidx>0;eidx--)
{
float4 iEpi_01=inEpiImage_01[global_id_y+(eidx)*height4];
float4 cPro_01= cProImage_01[global_id_y+(eidx-1)*height4];
float2 iEpi_2=inEpiImage_2[global_id_y+(eidx)*height2];
float2 cPro_2= cProImage_2[global_id_y+(eidx-1)*height2];
iEpi_01.xy+=cPro_01.xy*(float2)(p0e0*fltSum) + cPro_01.zw*(float2)(p1e0*fltSum) + cPro_2*(float2)(p2e0*fltSum) + epiLogue0*(float2)p2p2 + epiLogue1*(float2)p1p2 + epiLogue2*(float2)p0p2;
iEpi_01.zw+=cPro_01.xy*(float2)(p0e1*fltSum) + cPro_01.zw*(float2)(p1e1*fltSum) + cPro_2*(float2)(p2e1*fltSum) + epiLogue0*(float2)p2p1 + epiLogue1*(float2)p1p1 + epiLogue2*(float2)p0p1;
iEpi_2+=cPro_01.xy*(float2)(p0e2*fltSum) + cPro_01.zw*(float2)(p1e2*fltSum) + cPro_2*(float2)(p2e2*fltSum) + epiLogue0*(float2)p2p0 + epiLogue1*(float2)p1p0 + epiLogue2*(float2)p0p0;
cEpiImage_01[global_id_y+(eidx)*height4]=iEpi_01;
cEpiImage_2[global_id_y+(eidx)*height2]=iEpi_2;
epiLogue0=iEpi_01.xy;
epiLogue1=iEpi_01.zw;
epiLogue2=iEpi_2;
}
//for m=-1 prologue must be zero.
float4 iEpi_01=inEpiImage_01[global_id_y];
float2 iEpi_2=inEpiImage_2[global_id_y];
iEpi_01.xy+= epiLogue0*(float2)p2p2 + epiLogue1*(float2)p1p2 + epiLogue2*(float2)p0p2;
iEpi_01.zw+= epiLogue0*(float2)p2p1 + epiLogue1*(float2)p1p1 + epiLogue2*(float2)p0p1;
iEpi_2+= epiLogue0*(float2)p2p0 + epiLogue1*(float2)p1p0 + epiLogue2*(float2)p0p0;
cEpiImage_01[global_id_y]=iEpi_01;
cEpiImage_2[global_id_y]=iEpi_2;
}

__kernel void RecursiveGaussianAlgo4Step4_order3_float2_row_img(__read_only image2d_t src,__global const float4 * cProImage_01,
__global const float2 * cProImage_2,__global const float4 * cEpiImage_01,__global const float2 * cEpiImage_2,__global float2 *dst,
const int height,const int block_size,const int n_blocks_x, const float gamma,const float beta,const float alpha,
const float invGamma,const float fltSum,const int padding,const int prePadX)
{
int global_id_x=(int)get_global_id(0);
int global_id_y=(int)get_global_id(1);
if(global_id_x>=n_blocks_x-1 ||global_id_y>=height)
return ;
float2 ProLogue0=0.0f;
float2 ProLogue1=0.0f;
float2 ProLogue2=0.0f;
float2 EpiLogue0=0.0f;
float2 EpiLogue1=0.0f;
float2 EpiLogue2=0.0f;
if(global_id_x!=0)
{
float4 p=cProImage_01[global_id_y+(global_id_x-1)*height];
ProLogue0=p.xy;
ProLogue1=p.zw;
ProLogue2=cProImage_2[global_id_y+(global_id_x-1)*height];
}
float4 p=cEpiImage_01[global_id_y+(global_id_x)*height];
EpiLogue0=p.xy;
EpiLogue1=p.zw;
EpiLogue2=cEpiImage_2[global_id_y+(global_id_x)*height];
float2 out=EpiLogue0;
#pragma unroll
for(int idx=0;idx<BLOCK_SIZE;idx++)
{
if(idx<BLOCK_SIZE-3)
dst[global_id_y+(idx+prePadX+global_id_x*BLOCK_SIZE)*(height)]=out;
float2 p=read_imagef(src,sampler,(int2)(idx+prePadX+global_id_x*BLOCK_SIZE,global_id_y)).xy;
p+= ProLogue0*(float2)gamma+ProLogue1*(float2)beta+ProLogue2*(float2)alpha;
out=(out - p*(float2)fltSum - EpiLogue1*(float2)alpha -EpiLogue2*(float2)beta )*(float2)invGamma;
EpiLogue0=EpiLogue1;
EpiLogue1=EpiLogue2;
EpiLogue2=out;
ProLogue0=ProLogue1;
ProLogue1=ProLogue2;
ProLogue2=p;
out=EpiLogue0;
}
p=cEpiImage_01[global_id_y+(global_id_x+1)*height];
EpiLogue0=p.xy;
EpiLogue1=p.zw;
EpiLogue2=cEpiImage_2[global_id_y+(global_id_x+1)*height];
out=ProLogue2*(float2)fltSum + EpiLogue0*(float2)alpha +EpiLogue1*(float2)beta +EpiLogue2*(float2)gamma;
dst[global_id_y+(BLOCK_SIZE-1+prePadX+global_id_x*BLOCK_SIZE)*(height)]=out;
EpiLogue2=EpiLogue1;
EpiLogue1=EpiLogue0;
EpiLogue0=out;
out=ProLogue1*(float2)fltSum + EpiLogue0*(float2)alpha +EpiLogue1*(float2)beta +EpiLogue2*(float2)gamma;
dst[global_id_y+(BLOCK_SIZE-2+prePadX+global_id_x*BLOCK_SIZE)*(height)]=out;
EpiLogue2=EpiLogue1;
EpiLogue1=EpiLogue0;
EpiLogue0=out;
out=ProLogue1*(float2)fltSum + EpiLogue0*(float2)alpha +EpiLogue1*(float2)beta +EpiLogue2*(float2)gamma;
dst[global_id_y+(BLOCK_SIZE-3+prePadX+global_id_x*BLOCK_SIZE)*(height)]=out;
EpiLogue2=EpiLogue1;
EpiLogue1=EpiLogue0;
EpiLogue0=out;
}

__kernel void Transpose_imagetobuf(__read_only image2d_t src,__global float2 *dst,
const int height,const int width,const int n_blocks_x,const int padding)
{
int global_id_x=(int)get_global_id(0);
int global_id_y=(int)get_global_id(1);
if(global_id_x>=n_blocks_x ||global_id_y>=height)
return ;
float2 p=0.f;
#pragma unroll
for(int idx=0;idx<BLOCK_SIZE;idx++)
{
p=read_imagef(src,sampler,(int2)(idx+global_id_x*BLOCK_SIZE,global_id_y)).xy;
dst[global_id_y+(idx+global_id_x*BLOCK_SIZE)*(height+padding)]=p;
}
}

__kernel void RecursiveGaussianAlgo4Step4_order3_float2_row_img_sum(__read_only image2d_t src,__global const float4 * cProImage_01,
__global const float2 * cProImage_2,__global const float4 * cEpiImage_01,__global const float2 * cEpiImage_2,__global float4 * sumImg_4,__global float2 *dst,
const int height,const int block_size,const int n_blocks_x, const float gamma,const float beta,const float alpha, const int kkF,int sumOffX, int rowLimit,
const float invGamma,const float fltSum,const int padding,const int prePadX)
{
int global_id_x=(int)get_global_id(0);
int global_id_y=(int)get_global_id(1);
if(global_id_x>=n_blocks_x-1 ||global_id_y>=height)
return ;
float2 ProLogue0=0.0f;
float2 ProLogue1=0.0f;
float2 ProLogue2=0.0f;
float2 EpiLogue0=0.0f;
float2 EpiLogue1=0.0f;
float2 EpiLogue2=0.0f;
if(global_id_x!=0)
{
float4 p=cProImage_01[global_id_y+(global_id_x-1)*height];
ProLogue0=p.xy;
ProLogue1=p.zw;
ProLogue2=cProImage_2[global_id_y+(global_id_x-1)*height];
}
float4 p=cEpiImage_01[global_id_y+(global_id_x)*height];
EpiLogue0=p.xy;
EpiLogue1=p.zw;
EpiLogue2=cEpiImage_2[global_id_y+(global_id_x)*height];
float2 out=EpiLogue0;
float4 sum4=(float4)0.0f;
float x2=0.0f;
#pragma unroll
for(int idx=0;idx<BLOCK_SIZE;idx++)
{
int xId=idx+prePadX+global_id_x*BLOCK_SIZE;
if(idx<BLOCK_SIZE-3)
{
dst[global_id_y+(xId)*(height)]=out;
x2=out.x*out.x;
if(xId>=sumOffX && xId<rowLimit)
sum4+=(float4)(out.x,x2,out.x*x2,x2*x2);
}
float2 p=read_imagef(src,sampler,(int2)(xId,global_id_y)).xy;
p+= ProLogue0*(float2)gamma+ProLogue1*(float2)beta+ProLogue2*(float2)alpha;
out=(out - p*(float2)fltSum - EpiLogue1*(float2)alpha -EpiLogue2*(float2)beta )*(float2)invGamma;
EpiLogue0=EpiLogue1;
EpiLogue1=EpiLogue2;
EpiLogue2=out;
ProLogue0=ProLogue1;
ProLogue1=ProLogue2;
ProLogue2=p;
out=EpiLogue0;
}
p=cEpiImage_01[global_id_y+(global_id_x+1)*height];
EpiLogue0=p.xy;
EpiLogue1=p.zw;
EpiLogue2=cEpiImage_2[global_id_y+(global_id_x+1)*height];
int xId=BLOCK_SIZE-1+prePadX+global_id_x*BLOCK_SIZE;
out=ProLogue2*(float2)fltSum + EpiLogue0*(float2)alpha +EpiLogue1*(float2)beta +EpiLogue2*(float2)gamma;
dst[global_id_y+(xId)*(height)]=out;
EpiLogue2=EpiLogue1;
EpiLogue1=EpiLogue0;
EpiLogue0=out;
x2=out.x*out.x;
if(xId>=sumOffX && xId<rowLimit)
sum4+=(float4)(out.x,x2,out.x*x2,x2*x2);
xId--;
out=ProLogue1*(float2)fltSum + EpiLogue0*(float2)alpha +EpiLogue1*(float2)beta +EpiLogue2*(float2)gamma;
dst[global_id_y+(xId)*(height)]=out;
EpiLogue2=EpiLogue1;
EpiLogue1=EpiLogue0;
EpiLogue0=out;
x2=out.x*out.x;
if(xId>=sumOffX && xId<rowLimit)
sum4+=(float4)(out.x,x2,out.x*x2,x2*x2);
xId--;
out=ProLogue1*(float2)fltSum + EpiLogue0*(float2)alpha +EpiLogue1*(float2)beta +EpiLogue2*(float2)gamma;
dst[global_id_y+(xId)*(height)]=out;
EpiLogue2=EpiLogue1;
EpiLogue1=EpiLogue0;
EpiLogue0=out;
x2=out.x*out.x;
if(xId>=sumOffX && xId<rowLimit)
sum4+=(float4)(out.x,x2,out.x*x2,x2*x2);
sumImg_4[global_id_y+ (global_id_x)*height]=sum4;
}

__kernel void sumSums(__global const float4* restrict sumImg_4,__global float4* restrict sumImgOut_4, int height, int n_blocks_x, int preY, int postY, unsigned int kkFLimit )
{
unsigned int x= get_global_id(0);
unsigned int kkF=get_global_id(1);
if(x>=height || kkF >= kkFLimit)
return;
float4 sum=(float4)0.0f;
for(int y=0;y<n_blocks_x;y++)
{
sum+=sumImg_4[x+ (kkF*n_blocks_x + y)*height];
}
sumImgOut_4[x+ kkF*height]=sum;
}

__kernel void sumSum4s(__global const float4* restrict sumImg_4,__global float4* restrict sumImgOut_4, int height, int n_blocks_x, int preY, int postY,unsigned int kkF)
{
unsigned int x= get_global_id(0);
unsigned int y=0;
if(x>=height)
return;
float4 sum=(float4)0.0f;
//unsigned int stepY=1;//get_local_size(1);
for(;y<n_blocks_x;y++)
{
sum+=sumImg_4[x+ y*height];
}
sumImgOut_4[x+ kkF*height]=sum;
}

__kernel void RecursiveGaussianAlgo4Step4_order3_float2_sum(__global const float2 * src,__global const float4 * cProImage_01,
__global const float2 * cProImage_2,__global const float4 * cEpiImage_01,__global const float2 * cEpiImage_2,__global float4 * sumImg_4,__global float2 *dst,
const int width,const int height,const int block_size,const int n_blocks_y, const float gamma,const float beta,const float alpha, const int kkF,int sumOffX, int rowLimit,
const float invGamma,const float fltSum,const int padding,const int prePadY)
{
int global_id_x=(int)get_global_id(0);
int global_id_y=(int)get_global_id(1);
if(global_id_x>=width ||global_id_y>=n_blocks_y-1)
return ;
float2 ProLogue0=0.0f;
float2 ProLogue1=0.0f;
float2 ProLogue2=0.0f;
float2 EpiLogue0=0.0f;
float2 EpiLogue1=0.0f;
float2 EpiLogue2=0.0f;
if(global_id_y!=0)
{
float4 p=cProImage_01[global_id_x+(global_id_y-1)*width];
ProLogue0=p.xy;
ProLogue1=p.zw;
ProLogue2=cProImage_2[global_id_x+(global_id_y-1)*width];
}
__global const float2 * data=src + global_id_x +  (prePadY+global_id_y*BLOCK_SIZE)*(width+padding);
float4 p=cEpiImage_01[global_id_x+(global_id_y)*width];
EpiLogue0=p.xy;
EpiLogue1=p.zw;
EpiLogue2=cEpiImage_2[global_id_x+(global_id_y)*width];
float2 out=EpiLogue0;
float4 sum4=(float4)0.0f;
float x2=0.0f;
#pragma unroll
for(int idy=0;idy<BLOCK_SIZE;idy++)
{
int yId=idy+prePadY+global_id_y*BLOCK_SIZE;
if(idy<BLOCK_SIZE-3)
{
dst[global_id_x+(yId)*(width)]=out;
x2=out.x*out.x;
if(yId>=sumOffX && yId<rowLimit)
sum4+=(float4)(out.x,x2,out.x*x2,x2*x2);
}
float2 p=data[0]+ ProLogue0*(float2)gamma+ProLogue1*(float2)beta+ProLogue2*(float2)alpha;
out=(out - p*(float2)fltSum - EpiLogue1*(float2)alpha -EpiLogue2*(float2)beta )*(float2)invGamma;
EpiLogue0=EpiLogue1;
EpiLogue1=EpiLogue2;
EpiLogue2=out;
ProLogue0=ProLogue1;
ProLogue1=ProLogue2;
ProLogue2=p;
out=EpiLogue0;
data+=(width+padding);
}
p=cEpiImage_01[global_id_x+(global_id_y+1)*width];
EpiLogue0=p.xy;
EpiLogue1=p.zw;
EpiLogue2=cEpiImage_2[global_id_x+(global_id_y+1)*width];
int yId=BLOCK_SIZE-1+prePadY+global_id_y*BLOCK_SIZE;
out=ProLogue2*(float2)fltSum + EpiLogue0*(float2)alpha +EpiLogue1*(float2)beta +EpiLogue2*(float2)gamma;
dst[global_id_x+(yId)*(width)]=out;
EpiLogue2=EpiLogue1;
EpiLogue1=EpiLogue0;
EpiLogue0=out;
x2=out.x*out.x;
if(yId>=sumOffX && yId<rowLimit)
sum4+=(float4)(out.x,x2,out.x*x2,x2*x2);
yId--;
out=ProLogue1*(float2)fltSum + EpiLogue0*(float2)alpha +EpiLogue1*(float2)beta +EpiLogue2*(float2)gamma;
dst[global_id_x+(yId)*(width)]=out;
EpiLogue2=EpiLogue1;
EpiLogue1=EpiLogue0;
EpiLogue0=out;
x2=out.x*out.x;
if(yId>=sumOffX && yId<rowLimit)
sum4+=(float4)(out.x,x2,out.x*x2,x2*x2);
yId--;
out=ProLogue1*(float2)fltSum + EpiLogue0*(float2)alpha +EpiLogue1*(float2)beta +EpiLogue2*(float2)gamma;
dst[global_id_x+(yId)*(width)]=out;
EpiLogue2=EpiLogue1;
EpiLogue1=EpiLogue0;
EpiLogue0=out;
x2=out.x*out.x;
if(yId>=sumOffX && yId<rowLimit)
sum4+=(float4)(out.x,x2,out.x*x2,x2*x2);
sumImg_4[global_id_x+ (global_id_y)*width]=sum4;
}

__kernel void AccumulateFilteredResponsesImg_Transpose_buf_first(__read_only image2d_t src,__global float *pwrSpectraLogProd,__global float *pwrSpectra,
float minFreqRespSq, int cmptAbsProbs,
const int width,const int n_blocks_y,unsigned int inPadX,
unsigned int inPadY,unsigned int outPadX,unsigned int outPadY,
unsigned int inHeight, unsigned int inWidth,
unsigned int outLineWidth,unsigned int outLineHeight,unsigned int bin)
{
int global_id_x=(int)get_global_id(0);
int global_id_y=(int)get_global_id(1);
if(global_id_x>=n_blocks_y || global_id_y>=inWidth)
return ;
float2 p=0.f;
unsigned int leftY=BLOCK_SIZE;
if(inHeight < (global_id_x+1)*BLOCK_SIZE )
leftY=inHeight&(BLOCK_SIZE-1);
for(int idy=0;idy<leftY;idy++)
{
int yId=idy+global_id_x*BLOCK_SIZE;
p=read_imagef(src,sampler,(int2)(idy+inPadY+global_id_x*BLOCK_SIZE,global_id_y+inPadX)).xy;
//size_t indexOut = global_id_y + outPadX + (yId+outPadY)*outLineWidth + outLineWidth*outLineHeight*bin;
size_t indexOut = (global_id_y + 4*yId ) % outLineWidth + outPadX + (yId+outPadY)*outLineWidth + outLineWidth*outLineHeight*bin;
const float absValSqrd = max(minFreqRespSq, p.x*p.x + p.y*p.y);
if (cmptAbsProbs)
{
pwrSpectraLogProd[indexOut] = log(absValSqrd);
}
pwrSpectra[indexOut] = absValSqrd;
}
}

__kernel void AccumulateFilteredResponsesImg_Transpose_buf(__read_only image2d_t src,__global float *pwrSpectraLogProd,__global float *pwrSpectra,
float minFreqRespSq, int cmptAbsProbs,
const int width,const int n_blocks_y,unsigned int inPadX,
unsigned int inPadY,unsigned int outPadX,unsigned int outPadY,
unsigned int inHeight, unsigned int inWidth,
unsigned int outLineWidth,unsigned int outLineHeight,unsigned int bin)
{
int global_id_x=(int)get_global_id(0);
int global_id_y=(int)get_global_id(1);
if(global_id_x>=n_blocks_y || global_id_y>=inWidth)
return ;
float2 p=0.f;
unsigned int leftY=BLOCK_SIZE;
if(inHeight < (global_id_x+1)*BLOCK_SIZE )
leftY=inHeight&(BLOCK_SIZE-1);
for(int idy=0;idy<leftY;idy++)
{
int yId=idy+global_id_x*BLOCK_SIZE;
p=read_imagef(src,sampler,(int2)(idy+inPadY+global_id_x*BLOCK_SIZE,global_id_y+inPadX)).xy;
//size_t indexOut = global_id_y + outPadX + (yId+outPadY)*outLineWidth + outLineWidth*outLineHeight*bin;
size_t indexOut = (global_id_y + 4*yId ) % outLineWidth + outPadX + (yId+outPadY)*outLineWidth + outLineWidth*outLineHeight*bin;
const float absValSqrd = max(minFreqRespSq, p.x*p.x + p.y*p.y);
if (cmptAbsProbs)
{
pwrSpectraLogProd[indexOut] += log(absValSqrd);
}
pwrSpectra[indexOut] += absValSqrd;
}
}

__kernel void copyFloat2Buff_Img(__global float2 *src,__write_only image2d_t dst, int width, int height)
{
int global_id_x=(int)get_global_id(0);
int global_id_y=(int)get_global_id(1);
if(global_id_x>=width || global_id_y>=height)
return ;
float2 val=src[global_id_x+global_id_y*width];
write_imagef(dst, (int2)(global_id_x,global_id_y), (float4)(val.x,val.y,0.0f,0.0f));
}

__kernel void AccumulateFilteredResponses_buf_first(__global float2 *src,__global float *pwrSpectraLogProd,__global float *pwrSpectra,
float minFreqRespSq, int cmptAbsProbs,int height,
const int width,const int n_blocks_x,unsigned int inPadX,
unsigned int inPadY,unsigned int outPadX,unsigned int outPadY,
unsigned int inHeight, unsigned int inWidth,
unsigned int outLineWidth,unsigned int outLineHeight,unsigned int bin)
{
int global_id_x=(int)get_global_id(0);
int global_id_y=(int)get_global_id(1);
if(global_id_x>=inHeight  || global_id_y>=n_blocks_x)
return ;
float2 p=0.f;
int k=global_id_y*BLOCK_SIZE;
for(int idx=0;idx<BLOCK_SIZE && k <inWidth  ;idx++ , k++)
{
int xId=idx+global_id_y*BLOCK_SIZE;
p=src[global_id_x+inPadY + (xId + inPadX)*height];
size_t indexOut = global_id_x + outPadY + (xId+outPadX)*outLineHeight + outLineWidth*outLineHeight*bin;
//size_t indexOut = (global_id_y + 4*yId ) % outLineWidth + outPadX + (yId+outPadY)*outLineWidth + outLineWidth*outLineHeight*bin;
const float absValSqrd = max(minFreqRespSq, p.x*p.x + p.y*p.y);
if (cmptAbsProbs)
{
pwrSpectraLogProd[indexOut] = log(absValSqrd);
}
pwrSpectra[indexOut] = absValSqrd;
}
}

__kernel void AccumulateFilteredResponses_buf(__global float2 *src,__global float *pwrSpectraLogProd,__global float *pwrSpectra,
float minFreqRespSq, int cmptAbsProbs,int height,
const int width,const int n_blocks_x,unsigned int inPadX,
unsigned int inPadY,unsigned int outPadX,unsigned int outPadY,
unsigned int inHeight, unsigned int inWidth,
unsigned int outLineWidth,unsigned int outLineHeight,unsigned int bin)
{
int global_id_x=(int)get_global_id(0);
int global_id_y=(int)get_global_id(1);
if(global_id_x>=inHeight  || global_id_y>=n_blocks_x)
return ;
float2 p=0.f;
int k=global_id_y*BLOCK_SIZE;
for(int idx=0;idx<BLOCK_SIZE && k <inWidth  ;idx++ , k++)
{
int xId=idx+global_id_y*BLOCK_SIZE;
p=src[global_id_x+inPadY + (xId + inPadX)*height];
size_t indexOut = global_id_x + outPadY + (xId+outPadX)*outLineHeight + outLineWidth*outLineHeight*bin;
//size_t indexOut = (global_id_y + 4*yId ) % outLineWidth + outPadX + (yId+outPadY)*outLineWidth + outLineWidth*outLineHeight*bin;
const float absValSqrd = max(minFreqRespSq, p.x*p.x + p.y*p.y);
if (cmptAbsProbs)
{
pwrSpectraLogProd[indexOut] += log(absValSqrd);
}
pwrSpectra[indexOut] += absValSqrd;
}
}

__kernel void ShiftBufferBack(__global float* BuffIn,__global float* BuffOut,unsigned int padX,unsigned int padY,
unsigned int inLineWidth,unsigned int inLineHeight,unsigned int outLineWidth)
{
if(get_global_id(0)>=inLineWidth)
return;
int yId = get_global_id(1) * 12 + padY;
for(int k=0; k < 12 && yId < inLineHeight; k++, yId++)
{
BuffOut[get_global_id(0) + padX + yId*outLineWidth]=BuffIn[(get_global_id(0) + (yId-padY)*4)%inLineWidth +padX + yId*inLineWidth];
}
}

__kernel void CopyBufferBack(__global float* BuffIn,__global float* BuffOut,
unsigned int inLineWidth,unsigned int inLineHeight,unsigned int outLineWidth)
{
if(get_global_id(0)>=inLineWidth)
return;
int yId = get_global_id(1) * 12 ;
for(int k=0; k < 12 && yId < inLineHeight; k++, yId++)
{
BuffOut[get_global_id(0) + yId*outLineWidth]=BuffIn[get_global_id(0) + yId*(inLineWidth+PADDING)];
}
}

__kernel void transposeApple2(__global float2 *input,__global float2 *output,
int width,int height)
{
__local float2 tile[GROUP_DIMX*(GROUP_DIMX+1)];
int block_x = get_group_id(0);
int block_y = get_group_id(1);
int local_x = get_local_id(0) & (GROUP_DIMX - 1);
int local_y = get_local_id(0) >> LOG_GROUP_DIMX;
int local_input  = mad24(local_y, GROUP_DIMX + 1, local_x);
int local_output = mad24(local_x, GROUP_DIMX + 1, local_y);
int in_x = mad24(block_x, GROUP_DIMX, local_x);
int in_y = mad24(block_y, GROUP_DIMX, local_y);
int input_index = mad24(in_y, width, in_x);
int out_x = mad24(block_y, GROUP_DIMX, local_x);
int out_y = mad24(block_x, GROUP_DIMX, local_y);
int output_index = mad24(out_y, height + PADDING, out_x);
int global_input_stride  = width * GROUP_DIMY;
int global_output_stride = (height + PADDING) * GROUP_DIMY;
int local_input_stride  = GROUP_DIMY * (GROUP_DIMX + 1);
int local_output_stride = GROUP_DIMY;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index];
barrier(CLK_LOCAL_MEM_FENCE);
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output];
}

__kernel void transposeApple(__global float *input,__global float *output,
int width,int height)
{
__local float tile[GROUP_DIMX*(GROUP_DIMX+1)];
int block_x = get_group_id(0);
int block_y = get_group_id(1);
int local_x = get_local_id(0) & (GROUP_DIMX - 1);
int local_y = get_local_id(0) >> LOG_GROUP_DIMX;
int local_input  = mad24(local_y, GROUP_DIMX + 1, local_x);
int local_output = mad24(local_x, GROUP_DIMX + 1, local_y);
int in_x = mad24(block_x, GROUP_DIMX, local_x);
int in_y = mad24(block_y, GROUP_DIMX, local_y);
int input_index = mad24(in_y, width, in_x);
int out_x = mad24(block_y, GROUP_DIMX, local_x);
int out_y = mad24(block_x, GROUP_DIMX, local_y);
int output_index = mad24(out_y, height + PADDING, out_x);
int global_input_stride  = width * GROUP_DIMY;
int global_output_stride = (height + PADDING) * GROUP_DIMY;
int local_input_stride  = GROUP_DIMY * (GROUP_DIMX + 1);
int local_output_stride = GROUP_DIMY;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index]; local_input += local_input_stride; input_index += global_input_stride;
tile[local_input] = input[input_index];
barrier(CLK_LOCAL_MEM_FENCE);
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output]; local_output += local_output_stride; output_index += global_output_stride;
output[output_index] = tile[local_output];
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
