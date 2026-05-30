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
    const int inputZSize = 28/2+1;
    if (z < inputZSize)
        return in[x*30*inputZSize+y*inputZSize+z];
    int xp = (x == 0 ? 0 : 25-x);
    int yp = (y == 0 ? 0 : 30-y);
    real2 value = in[xp*30*inputZSize+yp*inputZSize+(28-z)];
    return (real2) (value.x, -value.y);
}

/**
 * Perform a 1D FFT on each row along one axis.
 */

__kernel void execFFT(__global const real2* restrict in, __global real2* restrict out, __local real2* restrict w,
        __local real2* restrict data0, __local real2* restrict data1) {
    for (int i = get_local_id(0); i < 28; i += get_local_size(0))
        w[i] = (real2) (cos(-(-1)*i*2*3.14159265e+00f/28), sin(-(-1)*i*2*3.14159265e+00f/28));
    barrier(CLK_LOCAL_MEM_FENCE);

    for (int baseIndex = get_group_id(0)*4; baseIndex < 25*30; baseIndex += get_num_groups(0)*4) {
        int index = baseIndex+get_local_id(0)/28;
        int x = index/30;
        int y = index-x*30;
#if 0
        if (x < 25/2+1) {
#endif
#if 0
        for (int z = get_local_id(0); z < 28; z += get_local_size(0))
    #if 0
            data0[z] = (real2) (in[x*(30*28)+y*28+z], 0);
    #elif 0
            data0[z] = loadComplexValue(in, x, y, z);
    #else
            data0[z] = in[x*(30*28)+y*28+z];
    #endif
#else
        if (index < 25*30)
    #if 0
            data0[get_local_id(0)] = (real2) (in[x*(30*28)+y*28+get_local_id(0)%28], 0);
    #elif 0
            data0[get_local_id(0)] = loadComplexValue(in, x, y, get_local_id(0)%28);
    #else
            data0[get_local_id(0)] = in[x*(30*28)+y*28+get_local_id(0)%28];
    #endif
#endif
#if 0
        }
#endif
        barrier(CLK_LOCAL_MEM_FENCE);
        {
// Pass 1 (radix 7)
if (get_local_id(0) < 16) {
int block = get_local_id(0)/4;
int i = get_local_id(0)-block*4;
int base = i+block*28;
int j = i/1;
real2 c0 = data0[base];
real2 c1 = data0[base+4];
real2 c2 = data0[base+8];
real2 c3 = data0[base+12];
real2 c4 = data0[base+16];
real2 c5 = data0[base+20];
real2 c6 = data0[base+24];
real2 d0 = c1+c6;
real2 d1 = c1-c6;
real2 d2 = c2+c5;
real2 d3 = c2-c5;
real2 d4 = c4+c3;
real2 d5 = c4-c3;
real2 d6 = d2+d0;
real2 d7 = d5+d3;
real2 b0 = c0+d6+d4;
real2 b1 = -1.16666667e+00f*(d6+d4);
real2 b2 = 7.90156469e-01f*(d0-d4);
real2 b3 = 5.58542673e-02f*(d4-d2);
real2 b4 = 7.34302201e-01f*(d2-d0);
real2 b5 = -(-1)*4.40958552e-01f*(d7+d1);
real2 b6 = -(-1)*3.40872931e-01f*(d1-d5);
real2 b7 = -(-1)*-5.33969360e-01f*(d5-d3);
real2 b8 = -(-1)*8.74842291e-01f*(d3-d1);
real2 t0 = b0+b1;
real2 t1 = b2+b3;
real2 t2 = b4-b3;
real2 t3 = -b2-b4;
real2 t4 = b6+b7;
real2 t5 = b8-b7;
real2 t6 = -b8-b6;
real2 t7 = t0+t1;
real2 t8 = t0+t2;
real2 t9 = t0+t3;
real2 t10 = (real2) (t4.y+b5.y, -(t4.x+b5.x));
real2 t11 = (real2) (t5.y+b5.y, -(t5.x+b5.x));
real2 t12 = (real2) (t6.y+b5.y, -(t6.x+b5.x));
data1[base+6*j*1] = b0;
data1[base+(6*j+1)*1] = multiplyComplex(w[j*28/28], t7-t10);
data1[base+(6*j+2)*1] = multiplyComplex(w[j*56/28], t9-t12);
data1[base+(6*j+3)*1] = multiplyComplex(w[j*84/28], t8+t11);
data1[base+(6*j+4)*1] = multiplyComplex(w[j*112/28], t8-t11);
data1[base+(6*j+5)*1] = multiplyComplex(w[j*140/28], t9+t12);
data1[base+(6*j+6)*1] = multiplyComplex(w[j*168/28], t7+t10);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 2 (radix 4)
if (get_local_id(0) < 28) {
int block = get_local_id(0)/7;
int i = get_local_id(0)-block*7;
int base = i+block*28;
int j = i/7;
real2 c0 = data1[base];
real2 c1 = data1[base+7];
real2 c2 = data1[base+14];
real2 c3 = data1[base+21];
real2 d0 = c0+c2;
real2 d1 = c0-c2;
real2 d2 = c1+c3;
real2 d3 = (-1)*(real2) (c1.y-c3.y, c3.x-c1.x);
data0[base+3*j*7] = d0+d2;
data0[base+(3*j+1)*7] = multiplyComplex(w[j*28/4], d1+d3);
data0[base+(3*j+2)*7] = multiplyComplex(w[j*56/4], d0-d2);
data0[base+(3*j+3)*7] = multiplyComplex(w[j*84/4], d1-d3);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
if (index < 25*30)
out[y*(28*25)+(get_local_id(0)%28)*25+x] = data0[get_local_id(0)];

    }
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
