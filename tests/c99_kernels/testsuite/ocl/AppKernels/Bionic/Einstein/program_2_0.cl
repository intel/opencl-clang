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
 unsigned int startIndex = i; \
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
 }    \
} \
__kernel void fft0(__global float2 *in, __global float2 *out, int dir, int S, __global float2 * cossinLUT1, __global float2 * cossinLUT2 )
{
    __local float sMem[2064];
    int i, j, r, indexIn, indexOut, index, tid, bNum, xNum, k, l;
    int s, ii, jj, offset;
    float2 w;
    float ang, angf, ang1;
    __local float *lMemStore, *lMemLoad;
    float2 a[16];
    int lId = get_local_id( 0 );
    int groupId = get_group_id( 0 );
 __local  float2  cossin_T_LUT[256];
 int lLUTind= lId;
     cossin_T_LUT[lLUTind]=cossinLUT2[lLUTind];
 lLUTind+=128;
     cossin_T_LUT[lLUTind]=cossinLUT2[lLUTind];
 barrier(CLK_LOCAL_MEM_FENCE);
bNum = groupId & 1023;
xNum = groupId >> 10;
indexIn = mul24(bNum, 16);
tid = indexIn;
i = tid >> 0;
j = tid & 0;
indexOut = mad24(i, 128, j);
indexIn += (xNum << 21);
indexOut += (xNum << 21);
tid = lId;
i = tid & 15;
j = tid >> 4;
indexIn += mad24(j, 16384, i);
in += indexIn;
a[0] = in[0];
a[1] = in[131072];
a[2] = in[262144];
a[3] = in[393216];
a[4] = in[524288];
a[5] = in[655360];
a[6] = in[786432];
a[7] = in[917504];
a[8] = in[1048576];
a[9] = in[1179648];
a[10] = in[1310720];
a[11] = in[1441792];
a[12] = in[1572864];
a[13] = in[1703936];
a[14] = in[1835008];
a[15] = in[1966080];
fftKernel16(a, dir);
{ int ang_index = (1 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[1] = complexMul(a[1], w);
{ int ang_index = (1 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[2] = complexMul(a[2], w);
{ int ang_index = (3 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[3] = complexMul(a[3], w);
{ int ang_index = (1 * ( j)) & 31;
  int k = ang_index * 8;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[4] = complexMul(a[4], w);
{ int ang_index = (5 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[5] = complexMul(a[5], w);
{ int ang_index = (3 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[6] = complexMul(a[6], w);
{ int ang_index = (7 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[7] = complexMul(a[7], w);
{ int ang_index = (1 * ( j)) & 15;
  int k = ang_index * 16;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[8] = complexMul(a[8], w);
{ int ang_index = (9 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[9] = complexMul(a[9], w);
{ int ang_index = (5 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[10] = complexMul(a[10], w);
{ int ang_index = (11 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[11] = complexMul(a[11], w);
{ int ang_index = (3 * ( j)) & 31;
  int k = ang_index * 8;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[12] = complexMul(a[12], w);
{ int ang_index = (13 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[13] = complexMul(a[13], w);
{ int ang_index = (7 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[14] = complexMul(a[14], w);
{ int ang_index = (15 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[15] = complexMul(a[15], w);
indexIn = mad24(j, 256, i);
lMemStore = sMem + tid;
lMemLoad = sMem + indexIn;
lMemStore[0] = a[0].x;
lMemStore[128] = a[1].x;
lMemStore[256] = a[2].x;
lMemStore[384] = a[3].x;
lMemStore[512] = a[4].x;
lMemStore[640] = a[5].x;
lMemStore[768] = a[6].x;
lMemStore[896] = a[7].x;
lMemStore[1024] = a[8].x;
lMemStore[1152] = a[9].x;
lMemStore[1280] = a[10].x;
lMemStore[1408] = a[11].x;
lMemStore[1536] = a[12].x;
lMemStore[1664] = a[13].x;
lMemStore[1792] = a[14].x;
lMemStore[1920] = a[15].x;
barrier(CLK_LOCAL_MEM_FENCE);
a[0].x = lMemLoad[0];
a[1].x = lMemLoad[16];
a[2].x = lMemLoad[32];
a[3].x = lMemLoad[48];
a[4].x = lMemLoad[64];
a[5].x = lMemLoad[80];
a[6].x = lMemLoad[96];
a[7].x = lMemLoad[112];
a[8].x = lMemLoad[128];
a[9].x = lMemLoad[144];
a[10].x = lMemLoad[160];
a[11].x = lMemLoad[176];
a[12].x = lMemLoad[192];
a[13].x = lMemLoad[208];
a[14].x = lMemLoad[224];
a[15].x = lMemLoad[240];
barrier(CLK_LOCAL_MEM_FENCE);
lMemStore[0] = a[0].y;
lMemStore[128] = a[1].y;
lMemStore[256] = a[2].y;
lMemStore[384] = a[3].y;
lMemStore[512] = a[4].y;
lMemStore[640] = a[5].y;
lMemStore[768] = a[6].y;
lMemStore[896] = a[7].y;
lMemStore[1024] = a[8].y;
lMemStore[1152] = a[9].y;
lMemStore[1280] = a[10].y;
lMemStore[1408] = a[11].y;
lMemStore[1536] = a[12].y;
lMemStore[1664] = a[13].y;
lMemStore[1792] = a[14].y;
lMemStore[1920] = a[15].y;
barrier(CLK_LOCAL_MEM_FENCE);
a[0].y = lMemLoad[0];
a[1].y = lMemLoad[16];
a[2].y = lMemLoad[32];
a[3].y = lMemLoad[48];
a[4].y = lMemLoad[64];
a[5].y = lMemLoad[80];
a[6].y = lMemLoad[96];
a[7].y = lMemLoad[112];
a[8].y = lMemLoad[128];
a[9].y = lMemLoad[144];
a[10].y = lMemLoad[160];
a[11].y = lMemLoad[176];
a[12].y = lMemLoad[192];
a[13].y = lMemLoad[208];
a[14].y = lMemLoad[224];
a[15].y = lMemLoad[240];
barrier(CLK_LOCAL_MEM_FENCE);
fftKernel8(a + 0, dir);
fftKernel8(a + 8, dir);
l = ((bNum << 4) + i) >> 0;
k = j << 1;
{ int ang_index = (1 * ( l * (k + 0))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
{ int ang_index = (1 * ( l * (k + 16))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
{ int ang_index = (1 * ( l * (k + 32))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
{ int ang_index = (1 * ( l * (k + 48))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
{ int ang_index = (1 * ( l * (k + 64))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
{ int ang_index = (1 * ( l * (k + 80))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
{ int ang_index = (1 * ( l * (k + 96))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
{ int ang_index = (1 * ( l * (k + 112))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
{ int ang_index = (1 * ( l * (k + 1))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
a[8] = complexMul(a[8], w);
{ int ang_index = (1 * ( l * (k + 17))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
a[9] = complexMul(a[9], w);
{ int ang_index = (1 * ( l * (k + 33))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
a[10] = complexMul(a[10], w);
{ int ang_index = (1 * ( l * (k + 49))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
a[11] = complexMul(a[11], w);
{ int ang_index = (1 * ( l * (k + 65))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
a[12] = complexMul(a[12], w);
{ int ang_index = (1 * ( l * (k + 81))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
a[13] = complexMul(a[13], w);
{ int ang_index = (1 * ( l * (k + 97))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
a[14] = complexMul(a[14], w);
{ int ang_index = (1 * ( l * (k + 113))) & 2097151;
 int k = (ang_index +  4096) >> 13;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 8192 );
  float mh=-2.9960563097e-006*(float)r;
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
a[15] = complexMul(a[15], w);
lMemStore = sMem + mad24(i, 129, j << 1);
lMemLoad = sMem + mad24(tid >> 7, 129, tid & 127);
lMemStore[ 0] = a[0].x;
lMemStore[ 16] = a[1].x;
lMemStore[ 32] = a[2].x;
lMemStore[ 48] = a[3].x;
lMemStore[ 64] = a[4].x;
lMemStore[ 80] = a[5].x;
lMemStore[ 96] = a[6].x;
lMemStore[ 112] = a[7].x;
lMemStore[ 1] = a[8].x;
lMemStore[ 17] = a[9].x;
lMemStore[ 33] = a[10].x;
lMemStore[ 49] = a[11].x;
lMemStore[ 65] = a[12].x;
lMemStore[ 81] = a[13].x;
lMemStore[ 97] = a[14].x;
lMemStore[ 113] = a[15].x;
barrier(CLK_LOCAL_MEM_FENCE);
a[0].x = lMemLoad[0];
a[1].x = lMemLoad[129];
a[2].x = lMemLoad[258];
a[3].x = lMemLoad[387];
a[4].x = lMemLoad[516];
a[5].x = lMemLoad[645];
a[6].x = lMemLoad[774];
a[7].x = lMemLoad[903];
a[8].x = lMemLoad[1032];
a[9].x = lMemLoad[1161];
a[10].x = lMemLoad[1290];
a[11].x = lMemLoad[1419];
a[12].x = lMemLoad[1548];
a[13].x = lMemLoad[1677];
a[14].x = lMemLoad[1806];
a[15].x = lMemLoad[1935];
barrier(CLK_LOCAL_MEM_FENCE);
lMemStore[ 0] = a[0].y;
lMemStore[ 16] = a[1].y;
lMemStore[ 32] = a[2].y;
lMemStore[ 48] = a[3].y;
lMemStore[ 64] = a[4].y;
lMemStore[ 80] = a[5].y;
lMemStore[ 96] = a[6].y;
lMemStore[ 112] = a[7].y;
lMemStore[ 1] = a[8].y;
lMemStore[ 17] = a[9].y;
lMemStore[ 33] = a[10].y;
lMemStore[ 49] = a[11].y;
lMemStore[ 65] = a[12].y;
lMemStore[ 81] = a[13].y;
lMemStore[ 97] = a[14].y;
lMemStore[ 113] = a[15].y;
barrier(CLK_LOCAL_MEM_FENCE);
a[0].y = lMemLoad[0];
a[1].y = lMemLoad[129];
a[2].y = lMemLoad[258];
a[3].y = lMemLoad[387];
a[4].y = lMemLoad[516];
a[5].y = lMemLoad[645];
a[6].y = lMemLoad[774];
a[7].y = lMemLoad[903];
a[8].y = lMemLoad[1032];
a[9].y = lMemLoad[1161];
a[10].y = lMemLoad[1290];
a[11].y = lMemLoad[1419];
a[12].y = lMemLoad[1548];
a[13].y = lMemLoad[1677];
a[14].y = lMemLoad[1806];
a[15].y = lMemLoad[1935];
barrier(CLK_LOCAL_MEM_FENCE);
indexOut += tid;
out += indexOut;
out[0] = a[0];
out[128] = a[1];
out[256] = a[2];
out[384] = a[3];
out[512] = a[4];
out[640] = a[5];
out[768] = a[6];
out[896] = a[7];
out[1024] = a[8];
out[1152] = a[9];
out[1280] = a[10];
out[1408] = a[11];
out[1536] = a[12];
out[1664] = a[13];
out[1792] = a[14];
out[1920] = a[15];
}
__kernel void fft1(__global float2 *in, __global float2 *out, int dir, int S, __global float2 * cossinLUT1, __global float2 * cossinLUT2 )
{
    __local float sMem[2048];
    int i, j, r, indexIn, indexOut, index, tid, bNum, xNum, k, l;
    int s, ii, jj, offset;
    float2 w;
    float ang, angf, ang1;
    __local float *lMemStore, *lMemLoad;
    float2 a[16];
    int lId = get_local_id( 0 );
    int groupId = get_group_id( 0 );
 __local  float2  cossin_T_LUT[256];
 int lLUTind= lId;
     cossin_T_LUT[lLUTind]=cossinLUT2[lLUTind];
 lLUTind+=128;
     cossin_T_LUT[lLUTind]=cossinLUT2[lLUTind];
 barrier(CLK_LOCAL_MEM_FENCE);
bNum = groupId & 1023;
xNum = groupId >> 10;
indexIn = mul24(bNum, 16);
tid = indexIn;
i = tid >> 7;
j = tid & 127;
indexOut = mad24(i, 16384, j);
indexIn += (xNum << 21);
indexOut += (xNum << 21);
tid = lId;
i = tid & 15;
j = tid >> 4;
indexIn += mad24(j, 16384, i);
in += indexIn;
a[0] = in[0];
a[1] = in[131072];
a[2] = in[262144];
a[3] = in[393216];
a[4] = in[524288];
a[5] = in[655360];
a[6] = in[786432];
a[7] = in[917504];
a[8] = in[1048576];
a[9] = in[1179648];
a[10] = in[1310720];
a[11] = in[1441792];
a[12] = in[1572864];
a[13] = in[1703936];
a[14] = in[1835008];
a[15] = in[1966080];
fftKernel16(a, dir);
{ int ang_index = (1 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[1] = complexMul(a[1], w);
{ int ang_index = (1 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[2] = complexMul(a[2], w);
{ int ang_index = (3 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[3] = complexMul(a[3], w);
{ int ang_index = (1 * ( j)) & 31;
  int k = ang_index * 8;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[4] = complexMul(a[4], w);
{ int ang_index = (5 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[5] = complexMul(a[5], w);
{ int ang_index = (3 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[6] = complexMul(a[6], w);
{ int ang_index = (7 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[7] = complexMul(a[7], w);
{ int ang_index = (1 * ( j)) & 15;
  int k = ang_index * 16;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[8] = complexMul(a[8], w);
{ int ang_index = (9 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[9] = complexMul(a[9], w);
{ int ang_index = (5 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[10] = complexMul(a[10], w);
{ int ang_index = (11 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[11] = complexMul(a[11], w);
{ int ang_index = (3 * ( j)) & 31;
  int k = ang_index * 8;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[12] = complexMul(a[12], w);
{ int ang_index = (13 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[13] = complexMul(a[13], w);
{ int ang_index = (7 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[14] = complexMul(a[14], w);
{ int ang_index = (15 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[15] = complexMul(a[15], w);
indexIn = mad24(j, 256, i);
lMemStore = sMem + tid;
lMemLoad = sMem + indexIn;
lMemStore[0] = a[0].x;
lMemStore[128] = a[1].x;
lMemStore[256] = a[2].x;
lMemStore[384] = a[3].x;
lMemStore[512] = a[4].x;
lMemStore[640] = a[5].x;
lMemStore[768] = a[6].x;
lMemStore[896] = a[7].x;
lMemStore[1024] = a[8].x;
lMemStore[1152] = a[9].x;
lMemStore[1280] = a[10].x;
lMemStore[1408] = a[11].x;
lMemStore[1536] = a[12].x;
lMemStore[1664] = a[13].x;
lMemStore[1792] = a[14].x;
lMemStore[1920] = a[15].x;
barrier(CLK_LOCAL_MEM_FENCE);
a[0].x = lMemLoad[0];
a[1].x = lMemLoad[16];
a[2].x = lMemLoad[32];
a[3].x = lMemLoad[48];
a[4].x = lMemLoad[64];
a[5].x = lMemLoad[80];
a[6].x = lMemLoad[96];
a[7].x = lMemLoad[112];
a[8].x = lMemLoad[128];
a[9].x = lMemLoad[144];
a[10].x = lMemLoad[160];
a[11].x = lMemLoad[176];
a[12].x = lMemLoad[192];
a[13].x = lMemLoad[208];
a[14].x = lMemLoad[224];
a[15].x = lMemLoad[240];
barrier(CLK_LOCAL_MEM_FENCE);
lMemStore[0] = a[0].y;
lMemStore[128] = a[1].y;
lMemStore[256] = a[2].y;
lMemStore[384] = a[3].y;
lMemStore[512] = a[4].y;
lMemStore[640] = a[5].y;
lMemStore[768] = a[6].y;
lMemStore[896] = a[7].y;
lMemStore[1024] = a[8].y;
lMemStore[1152] = a[9].y;
lMemStore[1280] = a[10].y;
lMemStore[1408] = a[11].y;
lMemStore[1536] = a[12].y;
lMemStore[1664] = a[13].y;
lMemStore[1792] = a[14].y;
lMemStore[1920] = a[15].y;
barrier(CLK_LOCAL_MEM_FENCE);
a[0].y = lMemLoad[0];
a[1].y = lMemLoad[16];
a[2].y = lMemLoad[32];
a[3].y = lMemLoad[48];
a[4].y = lMemLoad[64];
a[5].y = lMemLoad[80];
a[6].y = lMemLoad[96];
a[7].y = lMemLoad[112];
a[8].y = lMemLoad[128];
a[9].y = lMemLoad[144];
a[10].y = lMemLoad[160];
a[11].y = lMemLoad[176];
a[12].y = lMemLoad[192];
a[13].y = lMemLoad[208];
a[14].y = lMemLoad[224];
a[15].y = lMemLoad[240];
barrier(CLK_LOCAL_MEM_FENCE);
fftKernel8(a + 0, dir);
fftKernel8(a + 8, dir);
l = ((bNum << 4) + i) >> 7;
k = j << 1;
{ int ang_index = (1 * ( l * (k + 0))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
{ int ang_index = (1 * ( l * (k + 16))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
{ int ang_index = (1 * ( l * (k + 32))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
{ int ang_index = (1 * ( l * (k + 48))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
{ int ang_index = (1 * ( l * (k + 64))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
{ int ang_index = (1 * ( l * (k + 80))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
{ int ang_index = (1 * ( l * (k + 96))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
{ int ang_index = (1 * ( l * (k + 112))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
{ int ang_index = (1 * ( l * (k + 1))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
a[8] = complexMul(a[8], w);
{ int ang_index = (1 * ( l * (k + 17))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
a[9] = complexMul(a[9], w);
{ int ang_index = (1 * ( l * (k + 33))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
a[10] = complexMul(a[10], w);
{ int ang_index = (1 * ( l * (k + 49))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
a[11] = complexMul(a[11], w);
{ int ang_index = (1 * ( l * (k + 65))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
a[12] = complexMul(a[12], w);
{ int ang_index = (1 * ( l * (k + 81))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
a[13] = complexMul(a[13], w);
{ int ang_index = (1 * ( l * (k + 97))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
a[14] = complexMul(a[14], w);
{ int ang_index = (1 * ( l * (k + 113))) & 16383;
 int k = (ang_index +  32) >> 6;
 float2 csx0 =cossin_T_LUT[k];
 float2 csx0Transp= (float2)(csx0.y,-csx0.x);
 int    r=ang_index - k * ( 64 );
  float mh=-3.8349520764e-004*(float)r;
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
a[15] = complexMul(a[15], w);
indexOut += mad24(j, 256, i);
out += indexOut;
out[0] = a[0];
out[2048] = a[1];
out[4096] = a[2];
out[6144] = a[3];
out[8192] = a[4];
out[10240] = a[5];
out[12288] = a[6];
out[14336] = a[7];
out[128] = a[8];
out[2176] = a[9];
out[4224] = a[10];
out[6272] = a[11];
out[8320] = a[12];
out[10368] = a[13];
out[12416] = a[14];
out[14464] = a[15];
}
__kernel void fft2(__global float2 *in, __global float2 *out, int dir, int S, __global float2 * cossinLUT1, __global float2 * cossinLUT2 )
{
    __local float sMem[2048];
    int i, j, r, indexIn, indexOut, index, tid, bNum, xNum, k, l;
    int s, ii, jj, offset;
    float2 w;
    float ang, angf, ang1;
    __local float *lMemStore, *lMemLoad;
    float2 a[16];
    int lId = get_local_id( 0 );
    int groupId = get_group_id( 0 );
 __local  float2  cossin_T_LUT[256];
 int lLUTind= lId;
     cossin_T_LUT[lLUTind]=cossinLUT2[lLUTind];
 lLUTind+=128;
     cossin_T_LUT[lLUTind]=cossinLUT2[lLUTind];
 barrier(CLK_LOCAL_MEM_FENCE);
bNum = groupId & 1023;
xNum = groupId >> 10;
indexIn = mul24(bNum, 16);
tid = indexIn;
i = tid >> 14;
j = tid & 16383;
indexOut = mad24(i, 2097152, j);
indexIn += (xNum << 21);
indexOut += (xNum << 21);
tid = lId;
i = tid & 15;
j = tid >> 4;
indexIn += mad24(j, 16384, i);
in += indexIn;
a[0] = in[0];
a[1] = in[131072];
a[2] = in[262144];
a[3] = in[393216];
a[4] = in[524288];
a[5] = in[655360];
a[6] = in[786432];
a[7] = in[917504];
a[8] = in[1048576];
a[9] = in[1179648];
a[10] = in[1310720];
a[11] = in[1441792];
a[12] = in[1572864];
a[13] = in[1703936];
a[14] = in[1835008];
a[15] = in[1966080];
fftKernel16(a, dir);
{ int ang_index = (1 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[1] = complexMul(a[1], w);
{ int ang_index = (1 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[2] = complexMul(a[2], w);
{ int ang_index = (3 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[3] = complexMul(a[3], w);
{ int ang_index = (1 * ( j)) & 31;
  int k = ang_index * 8;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[4] = complexMul(a[4], w);
{ int ang_index = (5 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[5] = complexMul(a[5], w);
{ int ang_index = (3 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[6] = complexMul(a[6], w);
{ int ang_index = (7 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[7] = complexMul(a[7], w);
{ int ang_index = (1 * ( j)) & 15;
  int k = ang_index * 16;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[8] = complexMul(a[8], w);
{ int ang_index = (9 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[9] = complexMul(a[9], w);
{ int ang_index = (5 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[10] = complexMul(a[10], w);
{ int ang_index = (11 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[11] = complexMul(a[11], w);
{ int ang_index = (3 * ( j)) & 31;
  int k = ang_index * 8;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[12] = complexMul(a[12], w);
{ int ang_index = (13 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[13] = complexMul(a[13], w);
{ int ang_index = (7 * ( j)) & 63;
  int k = ang_index * 4;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[14] = complexMul(a[14], w);
{ int ang_index = (15 * ( j)) & 127;
  int k = ang_index * 2;
  float2 cs =cossin_T_LUT[k];
  cs.y *=dir;
w = cs;
}
a[15] = complexMul(a[15], w);
indexIn = mad24(j, 256, i);
lMemStore = sMem + tid;
lMemLoad = sMem + indexIn;
lMemStore[0] = a[0].x;
lMemStore[128] = a[1].x;
lMemStore[256] = a[2].x;
lMemStore[384] = a[3].x;
lMemStore[512] = a[4].x;
lMemStore[640] = a[5].x;
lMemStore[768] = a[6].x;
lMemStore[896] = a[7].x;
lMemStore[1024] = a[8].x;
lMemStore[1152] = a[9].x;
lMemStore[1280] = a[10].x;
lMemStore[1408] = a[11].x;
lMemStore[1536] = a[12].x;
lMemStore[1664] = a[13].x;
lMemStore[1792] = a[14].x;
lMemStore[1920] = a[15].x;
barrier(CLK_LOCAL_MEM_FENCE);
a[0].x = lMemLoad[0];
a[1].x = lMemLoad[16];
a[2].x = lMemLoad[32];
a[3].x = lMemLoad[48];
a[4].x = lMemLoad[64];
a[5].x = lMemLoad[80];
a[6].x = lMemLoad[96];
a[7].x = lMemLoad[112];
a[8].x = lMemLoad[128];
a[9].x = lMemLoad[144];
a[10].x = lMemLoad[160];
a[11].x = lMemLoad[176];
a[12].x = lMemLoad[192];
a[13].x = lMemLoad[208];
a[14].x = lMemLoad[224];
a[15].x = lMemLoad[240];
barrier(CLK_LOCAL_MEM_FENCE);
lMemStore[0] = a[0].y;
lMemStore[128] = a[1].y;
lMemStore[256] = a[2].y;
lMemStore[384] = a[3].y;
lMemStore[512] = a[4].y;
lMemStore[640] = a[5].y;
lMemStore[768] = a[6].y;
lMemStore[896] = a[7].y;
lMemStore[1024] = a[8].y;
lMemStore[1152] = a[9].y;
lMemStore[1280] = a[10].y;
lMemStore[1408] = a[11].y;
lMemStore[1536] = a[12].y;
lMemStore[1664] = a[13].y;
lMemStore[1792] = a[14].y;
lMemStore[1920] = a[15].y;
barrier(CLK_LOCAL_MEM_FENCE);
a[0].y = lMemLoad[0];
a[1].y = lMemLoad[16];
a[2].y = lMemLoad[32];
a[3].y = lMemLoad[48];
a[4].y = lMemLoad[64];
a[5].y = lMemLoad[80];
a[6].y = lMemLoad[96];
a[7].y = lMemLoad[112];
a[8].y = lMemLoad[128];
a[9].y = lMemLoad[144];
a[10].y = lMemLoad[160];
a[11].y = lMemLoad[176];
a[12].y = lMemLoad[192];
a[13].y = lMemLoad[208];
a[14].y = lMemLoad[224];
a[15].y = lMemLoad[240];
barrier(CLK_LOCAL_MEM_FENCE);
fftKernel8(a + 0, dir);
fftKernel8(a + 8, dir);
indexOut += mad24(j, 32768, i);
out += indexOut;
out[0] = a[0];
out[262144] = a[1];
out[524288] = a[2];
out[786432] = a[3];
out[1048576] = a[4];
out[1310720] = a[5];
out[1572864] = a[6];
out[1835008] = a[7];
out[16384] = a[8];
out[278528] = a[9];
out[540672] = a[10];
out[802816] = a[11];
out[1064960] = a[12];
out[1327104] = a[13];
out[1589248] = a[14];
out[1851392] = a[15];
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
