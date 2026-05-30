#define APPLY_PERIODIC_TO_DELTA(delta) delta.xyz -= floor(delta.xyz*invPeriodicBoxSize.xyz+0.5f)*periodicBoxSize.xyz;
#define APPLY_PERIODIC_TO_POS(pos) pos.xyz -= floor(pos.xyz*invPeriodicBoxSize.xyz)*periodicBoxSize.xyz;
#define APPLY_PERIODIC_TO_POS_WITH_CENTER(pos, center) {pos.x -= floor((pos.x-center.x)*invPeriodicBoxSize.x+0.5f)*periodicBoxSize.x; \
pos.y -= floor((pos.y-center.y)*invPeriodicBoxSize.y+0.5f)*periodicBoxSize.y; \
pos.z -= floor((pos.z-center.z)*invPeriodicBoxSize.z+0.5f)*periodicBoxSize.z;}
#define EXP native_exp
#define LOG native_log
#define RECIP native_recip
#define RSQRT native_rsqrt
#define SQRT native_sqrt
#define SYNC_WARPS barrier(CLK_LOCAL_MEM_FENCE)
#define WORK_GROUP_SIZE 64
#define convert_mixed4 convert_float4
#define convert_real4 convert_float4

typedef float real;
typedef float2 real2;
typedef float3 real3;
typedef float4 real4;
typedef float mixed;
typedef float2 mixed2;
typedef float3 mixed3;
typedef float4 mixed4;
real2 multiplyComplex(real2 c1, real2 c2) {
    return (real2) (c1.x*c2.x-c1.y*c2.y, c1.x*c2.y+c1.y*c2.x);
}

/**
 * Load a value from the half-complex grid produces by a real-to-complex transform.
 */
real2 loadComplexValue(__global const real2* restrict in, int x, int y, int z) {
    const int inputZSize = 30/2+1;
    if (z < inputZSize)
        return in[x*25*inputZSize+y*inputZSize+z];
    int xp = (x == 0 ? 0 : 28-x);
    int yp = (y == 0 ? 0 : 25-y);
    real2 value = in[xp*25*inputZSize+yp*inputZSize+(30-z)];
    return (real2) (value.x, -value.y);
}

/**
 * Perform a 1D FFT on each row along one axis.
 */

__kernel void execFFT(__global const real2* restrict in, __global real2* restrict out, __local real2* restrict w,
        __local real2* restrict data0, __local real2* restrict data1) {
    for (int i = get_local_id(0); i < 30; i += get_local_size(0))
        w[i] = (real2) (cos(-(1)*i*2*3.14159265e+00f/30), sin(-(1)*i*2*3.14159265e+00f/30));
    barrier(CLK_LOCAL_MEM_FENCE);

    for (int baseIndex = get_group_id(0)*4; baseIndex < 28*25; baseIndex += get_num_groups(0)*4) {
        int index = baseIndex+get_local_id(0)/30;
        int x = index/25;
        int y = index-x*25;
#if 0
        if (x < 28/2+1) {
#endif
#if 0
        for (int z = get_local_id(0); z < 30; z += get_local_size(0))
    #if 0
            data0[z] = (real2) (in[x*(25*30)+y*30+z], 0);
    #elif 0
            data0[z] = loadComplexValue(in, x, y, z);
    #else
            data0[z] = in[x*(25*30)+y*30+z];
    #endif
#else
        if (index < 28*25)
    #if 0
            data0[get_local_id(0)] = (real2) (in[x*(25*30)+y*30+get_local_id(0)%30], 0);
    #elif 0
            data0[get_local_id(0)] = loadComplexValue(in, x, y, get_local_id(0)%30);
    #else
            data0[get_local_id(0)] = in[x*(25*30)+y*30+get_local_id(0)%30];
    #endif
#endif
#if 0
        }
#endif
        barrier(CLK_LOCAL_MEM_FENCE);
        {
// Pass 1 (radix 5)
if (get_local_id(0) < 24) {
int block = get_local_id(0)/6;
int i = get_local_id(0)-block*6;
int base = i+block*30;
int j = i/1;
real2 c0 = data0[base];
real2 c1 = data0[base+6];
real2 c2 = data0[base+12];
real2 c3 = data0[base+18];
real2 c4 = data0[base+24];
real2 d0 = c1+c4;
real2 d1 = c2+c3;
real2 d2 = 9.51056516e-01f*(c1-c4);
real2 d3 = 9.51056516e-01f*(c2-c3);
real2 d4 = d0+d1;
real2 d5 = 5.59016994e-01f*(d0-d1);
real2 d6 = c0-0.25f*d4;
real2 d7 = d6+d5;
real2 d8 = d6-d5;
real2 d9 = (1)*(real2) (d2.y+6.18033989e-01f*d3.y, -d2.x-6.18033989e-01f*d3.x);
real2 d10 = (1)*(real2) (6.18033989e-01f*d2.y-d3.y, d3.x-6.18033989e-01f*d2.x);
data1[base+4*j*1] = c0+d4;
data1[base+(4*j+1)*1] = multiplyComplex(w[j*30/30], d7+d9);
data1[base+(4*j+2)*1] = multiplyComplex(w[j*60/30], d8+d10);
data1[base+(4*j+3)*1] = multiplyComplex(w[j*90/30], d8-d10);
data1[base+(4*j+4)*1] = multiplyComplex(w[j*120/30], d7-d9);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 2 (radix 3)
if (get_local_id(0) < 40) {
int block = get_local_id(0)/10;
int i = get_local_id(0)-block*10;
int base = i+block*30;
int j = i/5;
real2 c0 = data1[base];
real2 c1 = data1[base+10];
real2 c2 = data1[base+20];
real2 d0 = c1+c2;
real2 d1 = c0-0.5f*d0;
real2 d2 = (1)*8.66025404e-01f*(real2) (c1.y-c2.y, c2.x-c1.x);
data0[base+2*j*5] = c0+d0;
data0[base+(2*j+1)*5] = multiplyComplex(w[j*30/6], d1+d2);
data0[base+(2*j+2)*5] = multiplyComplex(w[j*60/6], d1-d2);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 3 (radix 2)
if (get_local_id(0) < 60) {
int block = get_local_id(0)/15;
int i = get_local_id(0)-block*15;
int base = i+block*30;
int j = i/15;
real2 c0 = data0[base];
real2 c1 = data0[base+15];
data1[base+j*15] = c0+c1;
data1[base+(j+1)*15] = multiplyComplex(w[j*30/2], c0-c1);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
if (index < 28*25)
out[y*(30*28)+(get_local_id(0)%30)*28+x] = data1[get_local_id(0)];

    }
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
