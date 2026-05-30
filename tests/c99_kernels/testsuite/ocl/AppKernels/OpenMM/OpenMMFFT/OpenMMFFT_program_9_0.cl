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
    const int inputZSize = 25/2+1;
    if (z < inputZSize)
        return in[x*28*inputZSize+y*inputZSize+z];
    int xp = (x == 0 ? 0 : 30-x);
    int yp = (y == 0 ? 0 : 28-y);
    real2 value = in[xp*28*inputZSize+yp*inputZSize+(25-z)];
    return (real2) (value.x, -value.y);
}

/**
 * Perform a 1D FFT on each row along one axis.
 */

__kernel void execFFT(__global const real2* restrict in, __global real2* restrict out, __local real2* restrict w,
        __local real2* restrict data0, __local real2* restrict data1) {
    for (int i = get_local_id(0); i < 25; i += get_local_size(0))
        w[i] = (real2) (cos(-(1)*i*2*3.14159265e+00f/25), sin(-(1)*i*2*3.14159265e+00f/25));
    barrier(CLK_LOCAL_MEM_FENCE);

    for (int baseIndex = get_group_id(0)*5; baseIndex < 30*28; baseIndex += get_num_groups(0)*5) {
        int index = baseIndex+get_local_id(0)/25;
        int x = index/28;
        int y = index-x*28;
#if 0
        if (x < 30/2+1) {
#endif
#if 0
        for (int z = get_local_id(0); z < 25; z += get_local_size(0))
    #if 0
            data0[z] = (real2) (in[x*(28*25)+y*25+z], 0);
    #elif 0
            data0[z] = loadComplexValue(in, x, y, z);
    #else
            data0[z] = in[x*(28*25)+y*25+z];
    #endif
#else
        if (index < 30*28)
    #if 0
            data0[get_local_id(0)] = (real2) (in[x*(28*25)+y*25+get_local_id(0)%25], 0);
    #elif 0
            data0[get_local_id(0)] = loadComplexValue(in, x, y, get_local_id(0)%25);
    #else
            data0[get_local_id(0)] = in[x*(28*25)+y*25+get_local_id(0)%25];
    #endif
#endif
#if 0
        }
#endif
        barrier(CLK_LOCAL_MEM_FENCE);
        {
// Pass 1 (radix 5)
if (get_local_id(0) < 25) {
int block = get_local_id(0)/5;
int i = get_local_id(0)-block*5;
int base = i+block*25;
int j = i/1;
real2 c0 = data0[base];
real2 c1 = data0[base+5];
real2 c2 = data0[base+10];
real2 c3 = data0[base+15];
real2 c4 = data0[base+20];
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
data1[base+(4*j+1)*1] = multiplyComplex(w[j*25/25], d7+d9);
data1[base+(4*j+2)*1] = multiplyComplex(w[j*50/25], d8+d10);
data1[base+(4*j+3)*1] = multiplyComplex(w[j*75/25], d8-d10);
data1[base+(4*j+4)*1] = multiplyComplex(w[j*100/25], d7-d9);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 2 (radix 5)
if (get_local_id(0) < 25) {
int block = get_local_id(0)/5;
int i = get_local_id(0)-block*5;
int base = i+block*25;
int j = i/5;
real2 c0 = data1[base];
real2 c1 = data1[base+5];
real2 c2 = data1[base+10];
real2 c3 = data1[base+15];
real2 c4 = data1[base+20];
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
data0[base+4*j*5] = c0+d4;
data0[base+(4*j+1)*5] = multiplyComplex(w[j*25/5], d7+d9);
data0[base+(4*j+2)*5] = multiplyComplex(w[j*50/5], d8+d10);
data0[base+(4*j+3)*5] = multiplyComplex(w[j*75/5], d8-d10);
data0[base+(4*j+4)*5] = multiplyComplex(w[j*100/5], d7-d9);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
if (index < 30*28)
out[y*(25*30)+(get_local_id(0)%25)*30+x] = data0[get_local_id(0)];

    }
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
