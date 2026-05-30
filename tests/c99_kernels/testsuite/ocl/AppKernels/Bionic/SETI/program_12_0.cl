#ifndef M_PI
#define M_PI 0x1.921fb54442d18p+1
#endif
#define complexMul(a,b) ((float2)(mad(-(a).y, (b).y, (a).x * (b).x), mad((a).y, (b).x, (a).x * (b).y)))

#define cos_sinLUT1(res,dir,i,cossinLUT)\
{\
(res)=(float2)((cossinLUT)[i].x , (dir)*(cossinLUT)[i].y);\
}

#define cos_sinLUT2(res,dir,_i,_k,cossinLUT1,cossinLUT2) \
{   float _sin_1= (cossinLUT1)[_i].y;    \
    float _sin_2= (cossinLUT2)[_k].y;    \
    float _cos_1= (cossinLUT1)[_i].x;    \
    float _cos_2= (cossinLUT2)[_k].x;    \
    float _cos_res = _cos_1 * _cos_2 - _sin_1 * _sin_2; \
    float _sin_res = (dir) * (_sin_1 * _cos_2 + _cos_1 * _sin_2); \
    (res)=(float2)(_cos_res,_sin_res);    \
}

#define conj(a) ((float2)((a).x, -(a).y))
#define conjTransp(a) ((float2)(-(a).y, (a).x))

#define fftKernel2(a,dir) \
{ \
    float2 c = (a)[0];    \
    (a)[0] = c + (a)[1];  \
    (a)[1] = c - (a)[1];  \
}

#define fftKernel2S(d1,d2,dir) \
{ \
    float2 c = (d1);   \
    (d1) = c + (d2);   \
    (d2) = c - (d2);   \
}

#define fftKernel4(a,dir) \
{ \
    fftKernel2S((a)[0], (a)[2], dir); \
    fftKernel2S((a)[1], (a)[3], dir); \
    fftKernel2S((a)[0], (a)[1], dir); \
    (a)[3] = (float2)(dir)*(conjTransp((a)[3])); \
    fftKernel2S((a)[2], (a)[3], dir); \
    float2 c = (a)[1]; \
    (a)[1] = (a)[2]; \
    (a)[2] = c; \
}

#define fftKernel4s(a0,a1,a2,a3,dir) \
{ \
    fftKernel2S((a0), (a2), dir); \
    fftKernel2S((a1), (a3), dir); \
    fftKernel2S((a0), (a1), dir); \
    (a3) = (float2)(dir)*(conjTransp((a3))); \
    fftKernel2S((a2), (a3), dir); \
    float2 c = (a1); \
    (a1) = (a2); \
    (a2) = c; \
}

#define bitreverse8(a) \
{ \
    float2 c; \
    c = (a)[1]; \
    (a)[1] = (a)[4]; \
    (a)[4] = c; \
    c = (a)[3]; \
    (a)[3] = (a)[6]; \
    (a)[6] = c; \
}

#define fftKernel8(a,dir) \
{ \
	const float2 w1  = (float2)(0x1.6a09e6p-1f,  dir*0x1.6a09e6p-1f);  \
	const float2 w3  = (float2)(-0x1.6a09e6p-1f, dir*0x1.6a09e6p-1f);  \
	float2 c; \
	fftKernel2S((a)[0], (a)[4], dir); \
	fftKernel2S((a)[1], (a)[5], dir); \
	fftKernel2S((a)[2], (a)[6], dir); \
	fftKernel2S((a)[3], (a)[7], dir); \
	(a)[5] = complexMul(w1, (a)[5]); \
	(a)[6] = (float2)(dir)*(conjTransp((a)[6])); \
	(a)[7] = complexMul(w3, (a)[7]); \
	fftKernel2S((a)[0], (a)[2], dir); \
	fftKernel2S((a)[1], (a)[3], dir); \
	fftKernel2S((a)[4], (a)[6], dir); \
	fftKernel2S((a)[5], (a)[7], dir); \
	(a)[3] = (float2)(dir)*(conjTransp((a)[3])); \
	(a)[7] = (float2)(dir)*(conjTransp((a)[7])); \
	fftKernel2S((a)[0], (a)[1], dir); \
	fftKernel2S((a)[2], (a)[3], dir); \
	fftKernel2S((a)[4], (a)[5], dir); \
	fftKernel2S((a)[6], (a)[7], dir); \
	bitreverse8((a)); \
}

#define bitreverse4x4(a) \
{ \
	float2 c; \
	c = (a)[1];  (a)[1]  = (a)[4];  (a)[4]  = c; \
	c = (a)[2];  (a)[2]  = (a)[8];  (a)[8]  = c; \
	c = (a)[3];  (a)[3]  = (a)[12]; (a)[12] = c; \
	c = (a)[6];  (a)[6]  = (a)[9];  (a)[9]  = c; \
	c = (a)[7];  (a)[7]  = (a)[13]; (a)[13] = c; \
	c = (a)[11]; (a)[11] = (a)[14]; (a)[14] = c; \
}

#define fftKernel16(a,dir) \
{ \
    const float w0 = 0x1.d906bcp-1f; \
    const float w1 = 0x1.87de2ap-2f; \
    const float w2 = 0x1.6a09e6p-1f; \
    fftKernel4s((a)[0], (a)[4], (a)[8],  (a)[12], dir); \
    fftKernel4s((a)[1], (a)[5], (a)[9],  (a)[13], dir); \
    fftKernel4s((a)[2], (a)[6], (a)[10], (a)[14], dir); \
    fftKernel4s((a)[3], (a)[7], (a)[11], (a)[15], dir); \
    (a)[5]  = complexMul((a)[5], (float2)(w0, dir*w1)); \
    (a)[6]  = complexMul((a)[6], (float2)(w2, dir*w2)); \
    (a)[7]  = complexMul((a)[7], (float2)(w1, dir*w0)); \
    (a)[9]  = complexMul((a)[9], (float2)(w2, dir*w2)); \
    (a)[10] = (float2)(dir)*(conjTransp((a)[10])); \
    (a)[11] = complexMul((a)[11], (float2)(-w2, dir*w2)); \
    (a)[13] = complexMul((a)[13], (float2)(w1, dir*w0)); \
    (a)[14] = complexMul((a)[14], (float2)(-w2, dir*w2)); \
    (a)[15] = complexMul((a)[15], (float2)(-w0, dir*-w1)); \
    fftKernel4((a), dir); \
    fftKernel4((a) + 4, dir); \
    fftKernel4((a) + 8, dir); \
    fftKernel4((a) + 12, dir); \
    bitreverse4x4((a)); \
}

#define bitreverse32(a) \
{ \
    float2 c1, c2; \
    c1 = (a)[2];   (a)[2] = (a)[1];   c2 = (a)[4];   (a)[4] = c1;   c1 = (a)[8];   (a)[8] = c2;    c2 = (a)[16];  (a)[16] = c1;   (a)[1] = c2; \
    c1 = (a)[6];   (a)[6] = (a)[3];   c2 = (a)[12];  (a)[12] = c1;  c1 = (a)[24];  (a)[24] = c2;   c2 = (a)[17];  (a)[17] = c1;   (a)[3] = c2; \
    c1 = (a)[10];  (a)[10] = (a)[5];  c2 = (a)[20];  (a)[20] = c1;  c1 = (a)[9];   (a)[9] = c2;    c2 = (a)[18];  (a)[18] = c1;   (a)[5] = c2; \
    c1 = (a)[14];  (a)[14] = (a)[7];  c2 = (a)[28];  (a)[28] = c1;  c1 = (a)[25];  (a)[25] = c2;   c2 = (a)[19];  (a)[19] = c1;   (a)[7] = c2; \
    c1 = (a)[22];  (a)[22] = (a)[11]; c2 = (a)[13];  (a)[13] = c1;  c1 = (a)[26];  (a)[26] = c2;   c2 = (a)[21];  (a)[21] = c1;   (a)[11] = c2; \
    c1 = (a)[30];  (a)[30] = (a)[15]; c2 = (a)[29];  (a)[29] = c1;  c1 = (a)[27];  (a)[27] = c2;   c2 = (a)[23];  (a)[23] = c1;   (a)[15] = c2; \
}

#define fftKernel32(a,dir) \
{ \
    fftKernel2S((a)[0],  (a)[16], dir); \
    fftKernel2S((a)[1],  (a)[17], dir); \
    fftKernel2S((a)[2],  (a)[18], dir); \
    fftKernel2S((a)[3],  (a)[19], dir); \
    fftKernel2S((a)[4],  (a)[20], dir); \
    fftKernel2S((a)[5],  (a)[21], dir); \
    fftKernel2S((a)[6],  (a)[22], dir); \
    fftKernel2S((a)[7],  (a)[23], dir); \
    fftKernel2S((a)[8],  (a)[24], dir); \
    fftKernel2S((a)[9],  (a)[25], dir); \
    fftKernel2S((a)[10], (a)[26], dir); \
    fftKernel2S((a)[11], (a)[27], dir); \
    fftKernel2S((a)[12], (a)[28], dir); \
    fftKernel2S((a)[13], (a)[29], dir); \
    fftKernel2S((a)[14], (a)[30], dir); \
    fftKernel2S((a)[15], (a)[31], dir); \
    (a)[17] = complexMul((a)[17], (float2)(0x1.f6297cp-1f, dir*0x1.8f8b84p-3f)); \
    (a)[18] = complexMul((a)[18], (float2)(0x1.d906bcp-1f, dir*0x1.87de2ap-2f)); \
    (a)[19] = complexMul((a)[19], (float2)(0x1.a9b662p-1f, dir*0x1.1c73b4p-1f)); \
    (a)[20] = complexMul((a)[20], (float2)(0x1.6a09e6p-1f, dir*0x1.6a09e6p-1f)); \
    (a)[21] = complexMul((a)[21], (float2)(0x1.1c73b4p-1f, dir*0x1.a9b662p-1f)); \
    (a)[22] = complexMul((a)[22], (float2)(0x1.87de2ap-2f, dir*0x1.d906bcp-1f)); \
    (a)[23] = complexMul((a)[23], (float2)(0x1.8f8b84p-3f, dir*0x1.f6297cp-1f)); \
    (a)[24] = complexMul((a)[24], (float2)(0x0p+0f, dir*0x1p+0f)); \
    (a)[25] = complexMul((a)[25], (float2)(-0x1.8f8b84p-3f, dir*0x1.f6297cp-1f)); \
    (a)[26] = complexMul((a)[26], (float2)(-0x1.87de2ap-2f, dir*0x1.d906bcp-1f)); \
    (a)[27] = complexMul((a)[27], (float2)(-0x1.1c73b4p-1f, dir*0x1.a9b662p-1f)); \
    (a)[28] = complexMul((a)[28], (float2)(-0x1.6a09e6p-1f, dir*0x1.6a09e6p-1f)); \
    (a)[29] = complexMul((a)[29], (float2)(-0x1.a9b662p-1f, dir*0x1.1c73b4p-1f)); \
    (a)[30] = complexMul((a)[30], (float2)(-0x1.d906bcp-1f, dir*0x1.87de2ap-2f)); \
    (a)[31] = complexMul((a)[31], (float2)(-0x1.f6297cp-1f, dir*0x1.8f8b84p-3f)); \
    fftKernel16((a), dir); \
    fftKernel16((a) + 16, dir); \
    bitreverse32((a)); \
}

__kernel void \
clFFT_1DTwistInterleaved(__global float2 *in, unsigned int startRow, unsigned int numCols, unsigned int N, unsigned int numRowsToProcess, int dir) \
{ \
   float2 a, w; \
   float ang; \
   unsigned int j; \
	unsigned int i = get_global_id(0); \
	unsigned int startIndex = mad24(startRow, numCols, i); \
	 \
	if(i < numCols) \
	{ \
	    for(j = 0; j < numRowsToProcess; j++) \
	    { \
	        a = in[startIndex]; \
	        ang = 2.0f * M_PI * dir * i * (startRow + j) / N; \
	        w = (float2)(native_cos(ang), native_sin(ang)); \
	        a = complexMul(a, w); \
	        in[startIndex] = a; \
	        startIndex += numCols; \
	    } \
	}	 \
} \
__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
 void fft0(__global float2 *in, __global float2 *out, int dir, int S, __global float2 * cossinLUT1, __global float2 * cossinLUT2)
{
    __local float sMem[520];
    int i, j, r, indexIn, indexOut, index, tid, bNum, xNum, k, l;
    int s, ii, jj, offset;
    float2 w;
    float ang, angf, ang1;
    __local float *lMemStore, *lMemLoad;
    float2 a[8];
    int lId = get_local_id( 0 );
    int groupId = get_group_id( 0 );
 __local  float2  cossin_T_LUT[256];
 int lLUTind= lId;
     cossin_T_LUT[lLUTind]=cossinLUT2[lLUTind];
 lLUTind+=64;
     cossin_T_LUT[lLUTind]=cossinLUT2[lLUTind];
 lLUTind+=64;
     cossin_T_LUT[lLUTind]=cossinLUT2[lLUTind];
 lLUTind+=64;
     cossin_T_LUT[lLUTind]=cossinLUT2[lLUTind];
 barrier(CLK_LOCAL_MEM_FENCE);
bNum = groupId & 7;
xNum = groupId >> 3;
indexIn = mul24(bNum, 8);
tid = indexIn;
i = tid >> 0;
j = tid & 0;
indexOut = mad24(i, 64, j);
indexIn += (xNum << 12);
indexOut += (xNum << 12);
tid = lId;
i = tid & 7;
j = tid >> 3;
indexIn += mad24(j, 64, i);
in += indexIn;
a[0] = in[0];
a[1] = in[512];
a[2] = in[1024];
a[3] = in[1536];
a[4] = in[2048];
a[5] = in[2560];
a[6] = in[3072];
a[7] = in[3584];
fftKernel8(a, dir);
{ int ang_index = (1 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[1] = complexMul(a[1], w);
{ int ang_index = (1 * ( j)) & 31;
  int k = ang_index * 8;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[2] = complexMul(a[2], w);
{ int ang_index = (3 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[3] = complexMul(a[3], w);
{ int ang_index = (1 * ( j)) & 15;
  int k = ang_index * 16;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[4] = complexMul(a[4], w);
{ int ang_index = (5 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[5] = complexMul(a[5], w);
{ int ang_index = (3 * ( j)) & 31;
  int k = ang_index * 8;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[6] = complexMul(a[6], w);
{ int ang_index = (7 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[7] = complexMul(a[7], w);
indexIn = mad24(j, 64, i);
lMemStore = sMem + tid;
lMemLoad = sMem + indexIn;
lMemStore[0] = a[0].x;
lMemStore[64] = a[1].x;
lMemStore[128] = a[2].x;
lMemStore[192] = a[3].x;
lMemStore[256] = a[4].x;
lMemStore[320] = a[5].x;
lMemStore[384] = a[6].x;
lMemStore[448] = a[7].x;
barrier(CLK_LOCAL_MEM_FENCE);
a[0].x = lMemLoad[0];
a[1].x = lMemLoad[8];
a[2].x = lMemLoad[16];
a[3].x = lMemLoad[24];
a[4].x = lMemLoad[32];
a[5].x = lMemLoad[40];
a[6].x = lMemLoad[48];
a[7].x = lMemLoad[56];
barrier(CLK_LOCAL_MEM_FENCE);
lMemStore[0] = a[0].y;
lMemStore[64] = a[1].y;
lMemStore[128] = a[2].y;
lMemStore[192] = a[3].y;
lMemStore[256] = a[4].y;
lMemStore[320] = a[5].y;
lMemStore[384] = a[6].y;
lMemStore[448] = a[7].y;
barrier(CLK_LOCAL_MEM_FENCE);
a[0].y = lMemLoad[0];
a[1].y = lMemLoad[8];
a[2].y = lMemLoad[16];
a[3].y = lMemLoad[24];
a[4].y = lMemLoad[32];
a[5].y = lMemLoad[40];
a[6].y = lMemLoad[48];
a[7].y = lMemLoad[56];
barrier(CLK_LOCAL_MEM_FENCE);
fftKernel8(a + 0, dir);
l = ((bNum << 3) + i) >> 0;
k = j << 0;
{ int ang_index = (1 * ( l * (k + 0))) & 4095;
 int k = (ang_index +  8) >> 4;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 16 );
  float mh=-1.5339808306e-003*(float)r;
  float mhsqr2= mh*mh*(-0.5f);
  float hqub6= mhsqr2*mh*(1.0f/3.0f);
  float2 cs;
   cs= hqub6 * csx0Transp;
   cs += mhsqr2*csx0;
   cs += mh*csx0Transp;
   cs += csx0;
   cs.y *=dir;
w = cs;
}
a[0] = complexMul(a[0], w);
{ int ang_index = (1 * ( l * (k + 8))) & 4095;
 int k = (ang_index +  8) >> 4;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 16 );
  float mh=-1.5339808306e-003*(float)r;
  float mhsqr2= mh*mh*(-0.5f);
  float hqub6= mhsqr2*mh*(1.0f/3.0f);
  float2 cs;
   cs= hqub6 * csx0Transp;
   cs += mhsqr2*csx0;
   cs += mh*csx0Transp;
   cs += csx0;
   cs.y *=dir;
w = cs;
}
a[1] = complexMul(a[1], w);
{ int ang_index = (1 * ( l * (k + 16))) & 4095;
 int k = (ang_index +  8) >> 4;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 16 );
  float mh=-1.5339808306e-003*(float)r;
  float mhsqr2= mh*mh*(-0.5f);
  float hqub6= mhsqr2*mh*(1.0f/3.0f);
  float2 cs;
   cs= hqub6 * csx0Transp;
   cs += mhsqr2*csx0;
   cs += mh*csx0Transp;
   cs += csx0;
   cs.y *=dir;
w = cs;
}
a[2] = complexMul(a[2], w);
{ int ang_index = (1 * ( l * (k + 24))) & 4095;
 int k = (ang_index +  8) >> 4;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 16 );
  float mh=-1.5339808306e-003*(float)r;
  float mhsqr2= mh*mh*(-0.5f);
  float hqub6= mhsqr2*mh*(1.0f/3.0f);
  float2 cs;
   cs= hqub6 * csx0Transp;
   cs += mhsqr2*csx0;
   cs += mh*csx0Transp;
   cs += csx0;
   cs.y *=dir;
w = cs;
}
a[3] = complexMul(a[3], w);
{ int ang_index = (1 * ( l * (k + 32))) & 4095;
 int k = (ang_index +  8) >> 4;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 16 );
  float mh=-1.5339808306e-003*(float)r;
  float mhsqr2= mh*mh*(-0.5f);
  float hqub6= mhsqr2*mh*(1.0f/3.0f);
  float2 cs;
   cs= hqub6 * csx0Transp;
   cs += mhsqr2*csx0;
   cs += mh*csx0Transp;
   cs += csx0;
   cs.y *=dir;
w = cs;
}
a[4] = complexMul(a[4], w);
{ int ang_index = (1 * ( l * (k + 40))) & 4095;
 int k = (ang_index +  8) >> 4;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 16 );
  float mh=-1.5339808306e-003*(float)r;
  float mhsqr2= mh*mh*(-0.5f);
  float hqub6= mhsqr2*mh*(1.0f/3.0f);
  float2 cs;
   cs= hqub6 * csx0Transp;
   cs += mhsqr2*csx0;
   cs += mh*csx0Transp;
   cs += csx0;
   cs.y *=dir;
w = cs;
}
a[5] = complexMul(a[5], w);
{ int ang_index = (1 * ( l * (k + 48))) & 4095;
 int k = (ang_index +  8) >> 4;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 16 );
  float mh=-1.5339808306e-003*(float)r;
  float mhsqr2= mh*mh*(-0.5f);
  float hqub6= mhsqr2*mh*(1.0f/3.0f);
  float2 cs;
   cs= hqub6 * csx0Transp;
   cs += mhsqr2*csx0;
   cs += mh*csx0Transp;
   cs += csx0;
   cs.y *=dir;
w = cs;
}
a[6] = complexMul(a[6], w);
{ int ang_index = (1 * ( l * (k + 56))) & 4095;
 int k = (ang_index +  8) >> 4;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 16 );
  float mh=-1.5339808306e-003*(float)r;
  float mhsqr2= mh*mh*(-0.5f);
  float hqub6= mhsqr2*mh*(1.0f/3.0f);
  float2 cs;
   cs= hqub6 * csx0Transp;
   cs += mhsqr2*csx0;
   cs += mh*csx0Transp;
   cs += csx0;
   cs.y *=dir;
w = cs;
}
a[7] = complexMul(a[7], w);
lMemStore = sMem + mad24(i, 65, j << 0);
lMemLoad = sMem + mad24(tid >> 6, 65, tid & 63);
lMemStore[ 0] = a[0].x;
lMemStore[ 8] = a[1].x;
lMemStore[ 16] = a[2].x;
lMemStore[ 24] = a[3].x;
lMemStore[ 32] = a[4].x;
lMemStore[ 40] = a[5].x;
lMemStore[ 48] = a[6].x;
lMemStore[ 56] = a[7].x;
barrier(CLK_LOCAL_MEM_FENCE);
a[0].x = lMemLoad[0];
a[1].x = lMemLoad[65];
a[2].x = lMemLoad[130];
a[3].x = lMemLoad[195];
a[4].x = lMemLoad[260];
a[5].x = lMemLoad[325];
a[6].x = lMemLoad[390];
a[7].x = lMemLoad[455];
barrier(CLK_LOCAL_MEM_FENCE);
lMemStore[ 0] = a[0].y;
lMemStore[ 8] = a[1].y;
lMemStore[ 16] = a[2].y;
lMemStore[ 24] = a[3].y;
lMemStore[ 32] = a[4].y;
lMemStore[ 40] = a[5].y;
lMemStore[ 48] = a[6].y;
lMemStore[ 56] = a[7].y;
barrier(CLK_LOCAL_MEM_FENCE);
a[0].y = lMemLoad[0];
a[1].y = lMemLoad[65];
a[2].y = lMemLoad[130];
a[3].y = lMemLoad[195];
a[4].y = lMemLoad[260];
a[5].y = lMemLoad[325];
a[6].y = lMemLoad[390];
a[7].y = lMemLoad[455];
barrier(CLK_LOCAL_MEM_FENCE);
indexOut += tid;
out += indexOut;
out[0] = a[0];
out[64] = a[1];
out[128] = a[2];
out[192] = a[3];
out[256] = a[4];
out[320] = a[5];
out[384] = a[6];
out[448] = a[7];
}
__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
 void fft1(__global float2 *in, __global float2 *out, int dir, int S, __global float2 * cossinLUT1, __global float2 * cossinLUT2)
{
    __local float sMem[512];
    int i, j, r, indexIn, indexOut, index, tid, bNum, xNum, k, l;
    int s, ii, jj, offset;
    float2 w;
    float ang, angf, ang1;
    __local float *lMemStore, *lMemLoad;
    float2 a[8];
    int lId = get_local_id( 0 );
    int groupId = get_group_id( 0 );
 __local  float2  cossin_T_LUT[256];
 int lLUTind= lId;
     cossin_T_LUT[lLUTind]=cossinLUT2[lLUTind];
 lLUTind+=64;
     cossin_T_LUT[lLUTind]=cossinLUT2[lLUTind];
 lLUTind+=64;
     cossin_T_LUT[lLUTind]=cossinLUT2[lLUTind];
 lLUTind+=64;
     cossin_T_LUT[lLUTind]=cossinLUT2[lLUTind];
 barrier(CLK_LOCAL_MEM_FENCE);
bNum = groupId & 7;
xNum = groupId >> 3;
indexIn = mul24(bNum, 8);
tid = indexIn;
i = tid >> 6;
j = tid & 63;
indexOut = mad24(i, 4096, j);
indexIn += (xNum << 12);
indexOut += (xNum << 12);
tid = lId;
i = tid & 7;
j = tid >> 3;
indexIn += mad24(j, 64, i);
in += indexIn;
a[0] = in[0];
a[1] = in[512];
a[2] = in[1024];
a[3] = in[1536];
a[4] = in[2048];
a[5] = in[2560];
a[6] = in[3072];
a[7] = in[3584];
fftKernel8(a, dir);
{ int ang_index = (1 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[1] = complexMul(a[1], w);
{ int ang_index = (1 * ( j)) & 31;
  int k = ang_index * 8;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[2] = complexMul(a[2], w);
{ int ang_index = (3 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[3] = complexMul(a[3], w);
{ int ang_index = (1 * ( j)) & 15;
  int k = ang_index * 16;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[4] = complexMul(a[4], w);
{ int ang_index = (5 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[5] = complexMul(a[5], w);
{ int ang_index = (3 * ( j)) & 31;
  int k = ang_index * 8;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[6] = complexMul(a[6], w);
{ int ang_index = (7 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[7] = complexMul(a[7], w);
indexIn = mad24(j, 64, i);
lMemStore = sMem + tid;
lMemLoad = sMem + indexIn;
lMemStore[0] = a[0].x;
lMemStore[64] = a[1].x;
lMemStore[128] = a[2].x;
lMemStore[192] = a[3].x;
lMemStore[256] = a[4].x;
lMemStore[320] = a[5].x;
lMemStore[384] = a[6].x;
lMemStore[448] = a[7].x;
barrier(CLK_LOCAL_MEM_FENCE);
a[0].x = lMemLoad[0];
a[1].x = lMemLoad[8];
a[2].x = lMemLoad[16];
a[3].x = lMemLoad[24];
a[4].x = lMemLoad[32];
a[5].x = lMemLoad[40];
a[6].x = lMemLoad[48];
a[7].x = lMemLoad[56];
barrier(CLK_LOCAL_MEM_FENCE);
lMemStore[0] = a[0].y;
lMemStore[64] = a[1].y;
lMemStore[128] = a[2].y;
lMemStore[192] = a[3].y;
lMemStore[256] = a[4].y;
lMemStore[320] = a[5].y;
lMemStore[384] = a[6].y;
lMemStore[448] = a[7].y;
barrier(CLK_LOCAL_MEM_FENCE);
a[0].y = lMemLoad[0];
a[1].y = lMemLoad[8];
a[2].y = lMemLoad[16];
a[3].y = lMemLoad[24];
a[4].y = lMemLoad[32];
a[5].y = lMemLoad[40];
a[6].y = lMemLoad[48];
a[7].y = lMemLoad[56];
barrier(CLK_LOCAL_MEM_FENCE);
fftKernel8(a + 0, dir);
indexOut += mad24(j, 64, i);
out += indexOut;
out[0] = a[0];
out[512] = a[1];
out[1024] = a[2];
out[1536] = a[3];
out[2048] = a[4];
out[2560] = a[5];
out[3072] = a[6];
out[3584] = a[7];
}


// buildOptions=-cl-mad-enable -w
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-mad-enable -w" %cfg_path --cl-device=%cl_device 2>&1
