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
#define HBAR 6.35077450e-02f
#define M_PI 3.14159265e+00f
#define NUM_ATOMS 100
#define NUM_COPIES 30
#define PADDED_NUM_ATOMS 128
#define SCALE 1.82574186e-01f
#define THREAD_BLOCK_SIZE 30

mixed4 multiplyComplexRealPart(mixed2 c1, mixed4 c2r, mixed4 c2i) {
    return c1.x*c2r-c1.y*c2i;
}

mixed4 multiplyComplexImagPart(mixed2 c1, mixed4 c2r, mixed4 c2i) {
    return c1.x*c2i+c1.y*c2r;
}

mixed4 multiplyComplexRealPartConj(mixed2 c1, mixed4 c2r, mixed4 c2i) {
    return c1.x*c2r+c1.y*c2i;
}

mixed4 multiplyComplexImagPartConj(mixed2 c1, mixed4 c2r, mixed4 c2i) {
    return c1.x*c2i-c1.y*c2r;
}

/**
 * Apply the PILE-L thermostat.
 */
__kernel void applyPileThermostat(__global mixed4* velm, __global float4* random, unsigned int randomIndex,
        mixed dt, mixed kT, mixed friction) {
    const int numBlocks = get_global_size(0)/NUM_COPIES;
    const int blockStart = NUM_COPIES*(get_local_id(0)/NUM_COPIES);
    const int indexInBlock = get_local_id(0)-blockStart;
    const mixed nkT = NUM_COPIES*kT;
    const mixed twown = 2.0f*nkT/HBAR;
    const mixed c1_0 = exp(-0.5f*dt*friction);
    const mixed c2_0 = sqrt(1.0f-c1_0*c1_0);
    __local mixed4 v[2*THREAD_BLOCK_SIZE];
    __local mixed4 temp[2*THREAD_BLOCK_SIZE];
    __local mixed2 w[NUM_COPIES];
    __local mixed4* vreal = &v[blockStart];
    __local mixed4* vimag = &v[blockStart+get_local_size(0)];
    if (get_local_id(0) < NUM_COPIES)
        w[indexInBlock] = (mixed2) (cos(-indexInBlock*2*M_PI/NUM_COPIES), sin(-indexInBlock*2*M_PI/NUM_COPIES));
    barrier(CLK_LOCAL_MEM_FENCE);
    randomIndex += NUM_COPIES*(get_global_id(0)/NUM_COPIES);
    for (int particle = get_global_id(0)/NUM_COPIES; particle < NUM_ATOMS; particle += numBlocks) {
        mixed4 particleVelm = velm[particle+indexInBlock*PADDED_NUM_ATOMS];
        mixed invMass = particleVelm.w;
        mixed c3_0 = c2_0*sqrt(nkT*invMass);

        // Forward FFT.

        vreal[indexInBlock] = SCALE*particleVelm;
        vimag[indexInBlock] = (mixed4) (0.0f, 0.0f, 0.0f, 0.0f);
        barrier(CLK_GLOBAL_MEM_FENCE);
        {
__local mixed4* real0 = vreal;
__local mixed4* imag0 = vimag;
__local mixed4* real1 = &temp[blockStart];
__local mixed4* imag1 = &temp[blockStart+get_local_size(0)];
{
// Pass 1 (radix 5)
if (indexInBlock < 6) {
int i = indexInBlock;
int j = i/1;
mixed4 c0r = real0[i];
mixed4 c0i = imag0[i];
mixed4 c1r = real0[i+6];
mixed4 c1i = imag0[i+6];
mixed4 c2r = real0[i+12];
mixed4 c2i = imag0[i+12];
mixed4 c3r = real0[i+18];
mixed4 c3i = imag0[i+18];
mixed4 c4r = real0[i+24];
mixed4 c4i = imag0[i+24];
mixed4 d0r = c1r+c4r;
mixed4 d0i = c1i+c4i;
mixed4 d1r = c2r+c3r;
mixed4 d1i = c2i+c3i;
mixed4 d2r = 9.51056516e-01f*(c1r-c4r);
mixed4 d2i = 9.51056516e-01f*(c1i-c4i);
mixed4 d3r = 9.51056516e-01f*(c2r-c3r);
mixed4 d3i = 9.51056516e-01f*(c2i-c3i);
mixed4 d4r = d0r+d1r;
mixed4 d4i = d0i+d1i;
mixed4 d5r = 5.59016994e-01f*(d0r-d1r);
mixed4 d5i = 5.59016994e-01f*(d0i-d1i);
mixed4 d6r = c0r-0.25f*d4r;
mixed4 d6i = c0i-0.25f*d4i;
mixed4 d7r = d6r+d5r;
mixed4 d7i = d6i+d5i;
mixed4 d8r = d6r-d5r;
mixed4 d8i = d6i-d5i;
mixed4 d9r = 1.0f*(d2i+6.18033989e-01f*d3i);
mixed4 d9i = 1.0f*(-d2r-6.18033989e-01f*d3r);
mixed4 d10r = 1.0f*(6.18033989e-01f*d2i-d3i);
mixed4 d10i = 1.0f*(d3r-6.18033989e-01f*d2r);
real1[i+4*j*1] = c0r+d4r;
imag1[i+4*j*1] = c0i+d4i;
real1[i+(4*j+1)*1] = multiplyComplexRealPart(w[j*30/30], d7r+d9r, d7i+d9i);
imag1[i+(4*j+1)*1] = multiplyComplexImagPart(w[j*30/30], d7r+d9r, d7i+d9i);
real1[i+(4*j+2)*1] = multiplyComplexRealPart(w[j*60/30], d8r+d10r, d8i+d10i);
imag1[i+(4*j+2)*1] = multiplyComplexImagPart(w[j*60/30], d8r+d10r, d8i+d10i);
real1[i+(4*j+3)*1] = multiplyComplexRealPart(w[j*90/30], d8r-d10r, d8i-d10i);
imag1[i+(4*j+3)*1] = multiplyComplexImagPart(w[j*90/30], d8r-d10r, d8i-d10i);
real1[i+(4*j+4)*1] = multiplyComplexRealPart(w[j*120/30], d7r-d9r, d7i-d9i);
imag1[i+(4*j+4)*1] = multiplyComplexImagPart(w[j*120/30], d7r-d9r, d7i-d9i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 2 (radix 3)
if (indexInBlock < 10) {
int i = indexInBlock;
int j = i/5;
mixed4 c0r = real1[i];
mixed4 c0i = imag1[i];
mixed4 c1r = real1[i+10];
mixed4 c1i = imag1[i+10];
mixed4 c2r = real1[i+20];
mixed4 c2i = imag1[i+20];
mixed4 d0r = c1r+c2r;
mixed4 d0i = c1i+c2i;
mixed4 d1r = c0r-0.5f*d0r;
mixed4 d1i = c0i-0.5f*d0i;
mixed4 d2r = 1.0f*8.66025404e-01f*(c1i-c2i);
mixed4 d2i = 1.0f*8.66025404e-01f*(c2r-c1r);
real0[i+2*j*5] = c0r+d0r;
imag0[i+2*j*5] = c0i+d0i;
real0[i+(2*j+1)*5] = multiplyComplexRealPart(w[j*30/6], d1r+d2r, d1i+d2i);
imag0[i+(2*j+1)*5] = multiplyComplexImagPart(w[j*30/6], d1r+d2r, d1i+d2i);
real0[i+(2*j+2)*5] = multiplyComplexRealPart(w[j*60/6], d1r-d2r, d1i-d2i);
imag0[i+(2*j+2)*5] = multiplyComplexImagPart(w[j*60/6], d1r-d2r, d1i-d2i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 3 (radix 2)
if (indexInBlock < 15) {
int i = indexInBlock;
int j = i/15;
mixed4 c0r = real0[i];
mixed4 c0i = imag0[i];
mixed4 c1r = real0[i+15];
mixed4 c1i = imag0[i+15];
real1[i+j*15] = c0r+c1r;
imag1[i+j*15] = c0i+c1i;
real1[i+(j+1)*15] = multiplyComplexRealPart(w[j*30/2], c0r-c1r, c0i-c1i);
imag1[i+(j+1)*15] = multiplyComplexImagPart(w[j*30/2], c0r-c1r, c0i-c1i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
real0[indexInBlock] = real1[indexInBlock];
imag0[indexInBlock] = imag1[indexInBlock];
barrier(CLK_LOCAL_MEM_FENCE);
}


        // Apply the thermostat.

        if (indexInBlock == 0) {
            // Apply a local Langevin thermostat to the centroid mode.

            vreal[0].xyz = vreal[0].xyz*c1_0 + c3_0*convert_mixed4(random[randomIndex]).xyz;
        }
        else {
            // Use critical damping white noise for the remaining modes.

            int k = (indexInBlock <= NUM_COPIES/2 ? indexInBlock : NUM_COPIES-indexInBlock);
            const bool isCenter = (NUM_COPIES%2 == 0 && k == NUM_COPIES/2);
            const mixed wk = twown*sin(k*M_PI/NUM_COPIES);
            const mixed c1 = exp(-wk*dt);
            const mixed c2 = sqrt((1.0f-c1*c1)/2.0f) * (isCenter ? sqrt(2.0f) : 1.0f);
            const mixed c3 = c2*sqrt(nkT*invMass);
            mixed4 rand1 = c3*convert_mixed4(random[randomIndex+k]);
            mixed4 rand2 = (isCenter ? 0.0f : c3*convert_mixed4(random[randomIndex+NUM_COPIES-k]));
            vreal[indexInBlock].xyz = c1*vreal[indexInBlock].xyz + rand1.xyz;
            vimag[indexInBlock].xyz = c1*vimag[indexInBlock].xyz + (indexInBlock < NUM_COPIES/2 ? rand2.xyz : -rand2.xyz);
        }
        barrier(CLK_GLOBAL_MEM_FENCE);

        // Inverse FFT.

        {
__local mixed4* real0 = vreal;
__local mixed4* imag0 = vimag;
__local mixed4* real1 = &temp[blockStart];
__local mixed4* imag1 = &temp[blockStart+get_local_size(0)];
{
// Pass 1 (radix 5)
if (indexInBlock < 6) {
int i = indexInBlock;
int j = i/1;
mixed4 c0r = real0[i];
mixed4 c0i = imag0[i];
mixed4 c1r = real0[i+6];
mixed4 c1i = imag0[i+6];
mixed4 c2r = real0[i+12];
mixed4 c2i = imag0[i+12];
mixed4 c3r = real0[i+18];
mixed4 c3i = imag0[i+18];
mixed4 c4r = real0[i+24];
mixed4 c4i = imag0[i+24];
mixed4 d0r = c1r+c4r;
mixed4 d0i = c1i+c4i;
mixed4 d1r = c2r+c3r;
mixed4 d1i = c2i+c3i;
mixed4 d2r = 9.51056516e-01f*(c1r-c4r);
mixed4 d2i = 9.51056516e-01f*(c1i-c4i);
mixed4 d3r = 9.51056516e-01f*(c2r-c3r);
mixed4 d3i = 9.51056516e-01f*(c2i-c3i);
mixed4 d4r = d0r+d1r;
mixed4 d4i = d0i+d1i;
mixed4 d5r = 5.59016994e-01f*(d0r-d1r);
mixed4 d5i = 5.59016994e-01f*(d0i-d1i);
mixed4 d6r = c0r-0.25f*d4r;
mixed4 d6i = c0i-0.25f*d4i;
mixed4 d7r = d6r+d5r;
mixed4 d7i = d6i+d5i;
mixed4 d8r = d6r-d5r;
mixed4 d8i = d6i-d5i;
mixed4 d9r = -1.0f*(d2i+6.18033989e-01f*d3i);
mixed4 d9i = -1.0f*(-d2r-6.18033989e-01f*d3r);
mixed4 d10r = -1.0f*(6.18033989e-01f*d2i-d3i);
mixed4 d10i = -1.0f*(d3r-6.18033989e-01f*d2r);
real1[i+4*j*1] = c0r+d4r;
imag1[i+4*j*1] = c0i+d4i;
real1[i+(4*j+1)*1] = multiplyComplexRealPartConj(w[j*30/30], d7r+d9r, d7i+d9i);
imag1[i+(4*j+1)*1] = multiplyComplexImagPartConj(w[j*30/30], d7r+d9r, d7i+d9i);
real1[i+(4*j+2)*1] = multiplyComplexRealPartConj(w[j*60/30], d8r+d10r, d8i+d10i);
imag1[i+(4*j+2)*1] = multiplyComplexImagPartConj(w[j*60/30], d8r+d10r, d8i+d10i);
real1[i+(4*j+3)*1] = multiplyComplexRealPartConj(w[j*90/30], d8r-d10r, d8i-d10i);
imag1[i+(4*j+3)*1] = multiplyComplexImagPartConj(w[j*90/30], d8r-d10r, d8i-d10i);
real1[i+(4*j+4)*1] = multiplyComplexRealPartConj(w[j*120/30], d7r-d9r, d7i-d9i);
imag1[i+(4*j+4)*1] = multiplyComplexImagPartConj(w[j*120/30], d7r-d9r, d7i-d9i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 2 (radix 3)
if (indexInBlock < 10) {
int i = indexInBlock;
int j = i/5;
mixed4 c0r = real1[i];
mixed4 c0i = imag1[i];
mixed4 c1r = real1[i+10];
mixed4 c1i = imag1[i+10];
mixed4 c2r = real1[i+20];
mixed4 c2i = imag1[i+20];
mixed4 d0r = c1r+c2r;
mixed4 d0i = c1i+c2i;
mixed4 d1r = c0r-0.5f*d0r;
mixed4 d1i = c0i-0.5f*d0i;
mixed4 d2r = -1.0f*8.66025404e-01f*(c1i-c2i);
mixed4 d2i = -1.0f*8.66025404e-01f*(c2r-c1r);
real0[i+2*j*5] = c0r+d0r;
imag0[i+2*j*5] = c0i+d0i;
real0[i+(2*j+1)*5] = multiplyComplexRealPartConj(w[j*30/6], d1r+d2r, d1i+d2i);
imag0[i+(2*j+1)*5] = multiplyComplexImagPartConj(w[j*30/6], d1r+d2r, d1i+d2i);
real0[i+(2*j+2)*5] = multiplyComplexRealPartConj(w[j*60/6], d1r-d2r, d1i-d2i);
imag0[i+(2*j+2)*5] = multiplyComplexImagPartConj(w[j*60/6], d1r-d2r, d1i-d2i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 3 (radix 2)
if (indexInBlock < 15) {
int i = indexInBlock;
int j = i/15;
mixed4 c0r = real0[i];
mixed4 c0i = imag0[i];
mixed4 c1r = real0[i+15];
mixed4 c1i = imag0[i+15];
real1[i+j*15] = c0r+c1r;
imag1[i+j*15] = c0i+c1i;
real1[i+(j+1)*15] = multiplyComplexRealPartConj(w[j*30/2], c0r-c1r, c0i-c1i);
imag1[i+(j+1)*15] = multiplyComplexImagPartConj(w[j*30/2], c0r-c1r, c0i-c1i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
real0[indexInBlock] = real1[indexInBlock];
imag0[indexInBlock] = imag1[indexInBlock];
barrier(CLK_LOCAL_MEM_FENCE);
}

        if (invMass != 0)
            velm[particle+indexInBlock*PADDED_NUM_ATOMS].xyz = SCALE*vreal[indexInBlock].xyz;
        randomIndex += get_global_size(0);
    }
}

/**
 * Advance the positions and velocities.
 */
__kernel void integrateStep(__global mixed4* posq, __global mixed4* velm, __global real4* force, mixed dt, mixed kT) {
    const int numBlocks = get_global_size(0)/NUM_COPIES;
    const int blockStart = NUM_COPIES*(get_local_id(0)/NUM_COPIES);
    const int indexInBlock = get_local_id(0)-blockStart;
    const mixed nkT = NUM_COPIES*kT;
    const mixed twown = 2.0f*nkT/HBAR;
    __local mixed4 q[2*THREAD_BLOCK_SIZE];
    __local mixed4 v[2*THREAD_BLOCK_SIZE];
    __local mixed4 temp[2*THREAD_BLOCK_SIZE];
    __local mixed2 w[NUM_COPIES];

    // Update velocities.

    for (int particle = get_global_id(0)/NUM_COPIES; particle < NUM_ATOMS; particle += numBlocks) {
        int index = particle+indexInBlock*PADDED_NUM_ATOMS;
        mixed4 particleVelm = velm[index];
        particleVelm.xyz += convert_mixed4(force[index]).xyz*(0.5f*dt*particleVelm.w);
        if (particleVelm.w != 0)
            velm[index] = particleVelm;
    }

    // Evolve the free ring polymer by transforming to the frequency domain.

    __local mixed4* qreal = &q[blockStart];
    __local mixed4* qimag = &q[blockStart+get_local_size(0)];
    __local mixed4* vreal = &v[blockStart];
    __local mixed4* vimag = &v[blockStart+get_local_size(0)];
    if (get_local_id(0) < NUM_COPIES)
        w[indexInBlock] = (mixed2) (cos(-indexInBlock*2*M_PI/NUM_COPIES), sin(-indexInBlock*2*M_PI/NUM_COPIES));
    barrier(CLK_LOCAL_MEM_FENCE);
    for (int particle = get_global_id(0)/NUM_COPIES; particle < NUM_ATOMS; particle += numBlocks) {
        mixed4 particlePosq = posq[particle+indexInBlock*PADDED_NUM_ATOMS];
        mixed4 particleVelm = velm[particle+indexInBlock*PADDED_NUM_ATOMS];

        // Forward FFT.

        qreal[indexInBlock] = SCALE*particlePosq;
        qimag[indexInBlock] = (mixed4) (0.0f, 0.0f, 0.0f, 0.0f);
        vreal[indexInBlock] = SCALE*particleVelm;
        vimag[indexInBlock] = (mixed4) (0.0f, 0.0f, 0.0f, 0.0f);
        barrier(CLK_GLOBAL_MEM_FENCE);
        {
__local mixed4* real0 = qreal;
__local mixed4* imag0 = qimag;
__local mixed4* real1 = &temp[blockStart];
__local mixed4* imag1 = &temp[blockStart+get_local_size(0)];
{
// Pass 1 (radix 5)
if (indexInBlock < 6) {
int i = indexInBlock;
int j = i/1;
mixed4 c0r = real0[i];
mixed4 c0i = imag0[i];
mixed4 c1r = real0[i+6];
mixed4 c1i = imag0[i+6];
mixed4 c2r = real0[i+12];
mixed4 c2i = imag0[i+12];
mixed4 c3r = real0[i+18];
mixed4 c3i = imag0[i+18];
mixed4 c4r = real0[i+24];
mixed4 c4i = imag0[i+24];
mixed4 d0r = c1r+c4r;
mixed4 d0i = c1i+c4i;
mixed4 d1r = c2r+c3r;
mixed4 d1i = c2i+c3i;
mixed4 d2r = 9.51056516e-01f*(c1r-c4r);
mixed4 d2i = 9.51056516e-01f*(c1i-c4i);
mixed4 d3r = 9.51056516e-01f*(c2r-c3r);
mixed4 d3i = 9.51056516e-01f*(c2i-c3i);
mixed4 d4r = d0r+d1r;
mixed4 d4i = d0i+d1i;
mixed4 d5r = 5.59016994e-01f*(d0r-d1r);
mixed4 d5i = 5.59016994e-01f*(d0i-d1i);
mixed4 d6r = c0r-0.25f*d4r;
mixed4 d6i = c0i-0.25f*d4i;
mixed4 d7r = d6r+d5r;
mixed4 d7i = d6i+d5i;
mixed4 d8r = d6r-d5r;
mixed4 d8i = d6i-d5i;
mixed4 d9r = 1.0f*(d2i+6.18033989e-01f*d3i);
mixed4 d9i = 1.0f*(-d2r-6.18033989e-01f*d3r);
mixed4 d10r = 1.0f*(6.18033989e-01f*d2i-d3i);
mixed4 d10i = 1.0f*(d3r-6.18033989e-01f*d2r);
real1[i+4*j*1] = c0r+d4r;
imag1[i+4*j*1] = c0i+d4i;
real1[i+(4*j+1)*1] = multiplyComplexRealPart(w[j*30/30], d7r+d9r, d7i+d9i);
imag1[i+(4*j+1)*1] = multiplyComplexImagPart(w[j*30/30], d7r+d9r, d7i+d9i);
real1[i+(4*j+2)*1] = multiplyComplexRealPart(w[j*60/30], d8r+d10r, d8i+d10i);
imag1[i+(4*j+2)*1] = multiplyComplexImagPart(w[j*60/30], d8r+d10r, d8i+d10i);
real1[i+(4*j+3)*1] = multiplyComplexRealPart(w[j*90/30], d8r-d10r, d8i-d10i);
imag1[i+(4*j+3)*1] = multiplyComplexImagPart(w[j*90/30], d8r-d10r, d8i-d10i);
real1[i+(4*j+4)*1] = multiplyComplexRealPart(w[j*120/30], d7r-d9r, d7i-d9i);
imag1[i+(4*j+4)*1] = multiplyComplexImagPart(w[j*120/30], d7r-d9r, d7i-d9i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 2 (radix 3)
if (indexInBlock < 10) {
int i = indexInBlock;
int j = i/5;
mixed4 c0r = real1[i];
mixed4 c0i = imag1[i];
mixed4 c1r = real1[i+10];
mixed4 c1i = imag1[i+10];
mixed4 c2r = real1[i+20];
mixed4 c2i = imag1[i+20];
mixed4 d0r = c1r+c2r;
mixed4 d0i = c1i+c2i;
mixed4 d1r = c0r-0.5f*d0r;
mixed4 d1i = c0i-0.5f*d0i;
mixed4 d2r = 1.0f*8.66025404e-01f*(c1i-c2i);
mixed4 d2i = 1.0f*8.66025404e-01f*(c2r-c1r);
real0[i+2*j*5] = c0r+d0r;
imag0[i+2*j*5] = c0i+d0i;
real0[i+(2*j+1)*5] = multiplyComplexRealPart(w[j*30/6], d1r+d2r, d1i+d2i);
imag0[i+(2*j+1)*5] = multiplyComplexImagPart(w[j*30/6], d1r+d2r, d1i+d2i);
real0[i+(2*j+2)*5] = multiplyComplexRealPart(w[j*60/6], d1r-d2r, d1i-d2i);
imag0[i+(2*j+2)*5] = multiplyComplexImagPart(w[j*60/6], d1r-d2r, d1i-d2i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 3 (radix 2)
if (indexInBlock < 15) {
int i = indexInBlock;
int j = i/15;
mixed4 c0r = real0[i];
mixed4 c0i = imag0[i];
mixed4 c1r = real0[i+15];
mixed4 c1i = imag0[i+15];
real1[i+j*15] = c0r+c1r;
imag1[i+j*15] = c0i+c1i;
real1[i+(j+1)*15] = multiplyComplexRealPart(w[j*30/2], c0r-c1r, c0i-c1i);
imag1[i+(j+1)*15] = multiplyComplexImagPart(w[j*30/2], c0r-c1r, c0i-c1i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
real0[indexInBlock] = real1[indexInBlock];
imag0[indexInBlock] = imag1[indexInBlock];
barrier(CLK_LOCAL_MEM_FENCE);
}

        {
__local mixed4* real0 = vreal;
__local mixed4* imag0 = vimag;
__local mixed4* real1 = &temp[blockStart];
__local mixed4* imag1 = &temp[blockStart+get_local_size(0)];
{
// Pass 1 (radix 5)
if (indexInBlock < 6) {
int i = indexInBlock;
int j = i/1;
mixed4 c0r = real0[i];
mixed4 c0i = imag0[i];
mixed4 c1r = real0[i+6];
mixed4 c1i = imag0[i+6];
mixed4 c2r = real0[i+12];
mixed4 c2i = imag0[i+12];
mixed4 c3r = real0[i+18];
mixed4 c3i = imag0[i+18];
mixed4 c4r = real0[i+24];
mixed4 c4i = imag0[i+24];
mixed4 d0r = c1r+c4r;
mixed4 d0i = c1i+c4i;
mixed4 d1r = c2r+c3r;
mixed4 d1i = c2i+c3i;
mixed4 d2r = 9.51056516e-01f*(c1r-c4r);
mixed4 d2i = 9.51056516e-01f*(c1i-c4i);
mixed4 d3r = 9.51056516e-01f*(c2r-c3r);
mixed4 d3i = 9.51056516e-01f*(c2i-c3i);
mixed4 d4r = d0r+d1r;
mixed4 d4i = d0i+d1i;
mixed4 d5r = 5.59016994e-01f*(d0r-d1r);
mixed4 d5i = 5.59016994e-01f*(d0i-d1i);
mixed4 d6r = c0r-0.25f*d4r;
mixed4 d6i = c0i-0.25f*d4i;
mixed4 d7r = d6r+d5r;
mixed4 d7i = d6i+d5i;
mixed4 d8r = d6r-d5r;
mixed4 d8i = d6i-d5i;
mixed4 d9r = 1.0f*(d2i+6.18033989e-01f*d3i);
mixed4 d9i = 1.0f*(-d2r-6.18033989e-01f*d3r);
mixed4 d10r = 1.0f*(6.18033989e-01f*d2i-d3i);
mixed4 d10i = 1.0f*(d3r-6.18033989e-01f*d2r);
real1[i+4*j*1] = c0r+d4r;
imag1[i+4*j*1] = c0i+d4i;
real1[i+(4*j+1)*1] = multiplyComplexRealPart(w[j*30/30], d7r+d9r, d7i+d9i);
imag1[i+(4*j+1)*1] = multiplyComplexImagPart(w[j*30/30], d7r+d9r, d7i+d9i);
real1[i+(4*j+2)*1] = multiplyComplexRealPart(w[j*60/30], d8r+d10r, d8i+d10i);
imag1[i+(4*j+2)*1] = multiplyComplexImagPart(w[j*60/30], d8r+d10r, d8i+d10i);
real1[i+(4*j+3)*1] = multiplyComplexRealPart(w[j*90/30], d8r-d10r, d8i-d10i);
imag1[i+(4*j+3)*1] = multiplyComplexImagPart(w[j*90/30], d8r-d10r, d8i-d10i);
real1[i+(4*j+4)*1] = multiplyComplexRealPart(w[j*120/30], d7r-d9r, d7i-d9i);
imag1[i+(4*j+4)*1] = multiplyComplexImagPart(w[j*120/30], d7r-d9r, d7i-d9i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 2 (radix 3)
if (indexInBlock < 10) {
int i = indexInBlock;
int j = i/5;
mixed4 c0r = real1[i];
mixed4 c0i = imag1[i];
mixed4 c1r = real1[i+10];
mixed4 c1i = imag1[i+10];
mixed4 c2r = real1[i+20];
mixed4 c2i = imag1[i+20];
mixed4 d0r = c1r+c2r;
mixed4 d0i = c1i+c2i;
mixed4 d1r = c0r-0.5f*d0r;
mixed4 d1i = c0i-0.5f*d0i;
mixed4 d2r = 1.0f*8.66025404e-01f*(c1i-c2i);
mixed4 d2i = 1.0f*8.66025404e-01f*(c2r-c1r);
real0[i+2*j*5] = c0r+d0r;
imag0[i+2*j*5] = c0i+d0i;
real0[i+(2*j+1)*5] = multiplyComplexRealPart(w[j*30/6], d1r+d2r, d1i+d2i);
imag0[i+(2*j+1)*5] = multiplyComplexImagPart(w[j*30/6], d1r+d2r, d1i+d2i);
real0[i+(2*j+2)*5] = multiplyComplexRealPart(w[j*60/6], d1r-d2r, d1i-d2i);
imag0[i+(2*j+2)*5] = multiplyComplexImagPart(w[j*60/6], d1r-d2r, d1i-d2i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 3 (radix 2)
if (indexInBlock < 15) {
int i = indexInBlock;
int j = i/15;
mixed4 c0r = real0[i];
mixed4 c0i = imag0[i];
mixed4 c1r = real0[i+15];
mixed4 c1i = imag0[i+15];
real1[i+j*15] = c0r+c1r;
imag1[i+j*15] = c0i+c1i;
real1[i+(j+1)*15] = multiplyComplexRealPart(w[j*30/2], c0r-c1r, c0i-c1i);
imag1[i+(j+1)*15] = multiplyComplexImagPart(w[j*30/2], c0r-c1r, c0i-c1i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
real0[indexInBlock] = real1[indexInBlock];
imag0[indexInBlock] = imag1[indexInBlock];
barrier(CLK_LOCAL_MEM_FENCE);
}


        // Apply the thermostat.

        if (indexInBlock == 0) {
            qreal[0].xyz += vreal[0].xyz*dt;
            qimag[0].xyz += vimag[0].xyz*dt;
        }
        else {
            const mixed wk = twown*sin(indexInBlock*M_PI/NUM_COPIES);
            const mixed wt = wk*dt;
            const mixed coswt = cos(wt);
            const mixed sinwt = sin(wt);
            const mixed4 vprimereal = vreal[indexInBlock]*coswt - qreal[indexInBlock]*(wk*sinwt); // Advance velocity from t to t+dt
            const mixed4 vprimeimag = vimag[indexInBlock]*coswt - qimag[indexInBlock]*(wk*sinwt);
            qreal[indexInBlock] = vreal[indexInBlock]*(sinwt/wk) + qreal[indexInBlock]*coswt; // Advance position from t to t+dt
            qimag[indexInBlock] = vimag[indexInBlock]*(sinwt/wk) + qimag[indexInBlock]*coswt;
            vreal[indexInBlock] = vprimereal;
            vimag[indexInBlock] = vprimeimag;
        }
        barrier(CLK_GLOBAL_MEM_FENCE);

        // Inverse FFT.

        {
__local mixed4* real0 = qreal;
__local mixed4* imag0 = qimag;
__local mixed4* real1 = &temp[blockStart];
__local mixed4* imag1 = &temp[blockStart+get_local_size(0)];
{
// Pass 1 (radix 5)
if (indexInBlock < 6) {
int i = indexInBlock;
int j = i/1;
mixed4 c0r = real0[i];
mixed4 c0i = imag0[i];
mixed4 c1r = real0[i+6];
mixed4 c1i = imag0[i+6];
mixed4 c2r = real0[i+12];
mixed4 c2i = imag0[i+12];
mixed4 c3r = real0[i+18];
mixed4 c3i = imag0[i+18];
mixed4 c4r = real0[i+24];
mixed4 c4i = imag0[i+24];
mixed4 d0r = c1r+c4r;
mixed4 d0i = c1i+c4i;
mixed4 d1r = c2r+c3r;
mixed4 d1i = c2i+c3i;
mixed4 d2r = 9.51056516e-01f*(c1r-c4r);
mixed4 d2i = 9.51056516e-01f*(c1i-c4i);
mixed4 d3r = 9.51056516e-01f*(c2r-c3r);
mixed4 d3i = 9.51056516e-01f*(c2i-c3i);
mixed4 d4r = d0r+d1r;
mixed4 d4i = d0i+d1i;
mixed4 d5r = 5.59016994e-01f*(d0r-d1r);
mixed4 d5i = 5.59016994e-01f*(d0i-d1i);
mixed4 d6r = c0r-0.25f*d4r;
mixed4 d6i = c0i-0.25f*d4i;
mixed4 d7r = d6r+d5r;
mixed4 d7i = d6i+d5i;
mixed4 d8r = d6r-d5r;
mixed4 d8i = d6i-d5i;
mixed4 d9r = -1.0f*(d2i+6.18033989e-01f*d3i);
mixed4 d9i = -1.0f*(-d2r-6.18033989e-01f*d3r);
mixed4 d10r = -1.0f*(6.18033989e-01f*d2i-d3i);
mixed4 d10i = -1.0f*(d3r-6.18033989e-01f*d2r);
real1[i+4*j*1] = c0r+d4r;
imag1[i+4*j*1] = c0i+d4i;
real1[i+(4*j+1)*1] = multiplyComplexRealPartConj(w[j*30/30], d7r+d9r, d7i+d9i);
imag1[i+(4*j+1)*1] = multiplyComplexImagPartConj(w[j*30/30], d7r+d9r, d7i+d9i);
real1[i+(4*j+2)*1] = multiplyComplexRealPartConj(w[j*60/30], d8r+d10r, d8i+d10i);
imag1[i+(4*j+2)*1] = multiplyComplexImagPartConj(w[j*60/30], d8r+d10r, d8i+d10i);
real1[i+(4*j+3)*1] = multiplyComplexRealPartConj(w[j*90/30], d8r-d10r, d8i-d10i);
imag1[i+(4*j+3)*1] = multiplyComplexImagPartConj(w[j*90/30], d8r-d10r, d8i-d10i);
real1[i+(4*j+4)*1] = multiplyComplexRealPartConj(w[j*120/30], d7r-d9r, d7i-d9i);
imag1[i+(4*j+4)*1] = multiplyComplexImagPartConj(w[j*120/30], d7r-d9r, d7i-d9i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 2 (radix 3)
if (indexInBlock < 10) {
int i = indexInBlock;
int j = i/5;
mixed4 c0r = real1[i];
mixed4 c0i = imag1[i];
mixed4 c1r = real1[i+10];
mixed4 c1i = imag1[i+10];
mixed4 c2r = real1[i+20];
mixed4 c2i = imag1[i+20];
mixed4 d0r = c1r+c2r;
mixed4 d0i = c1i+c2i;
mixed4 d1r = c0r-0.5f*d0r;
mixed4 d1i = c0i-0.5f*d0i;
mixed4 d2r = -1.0f*8.66025404e-01f*(c1i-c2i);
mixed4 d2i = -1.0f*8.66025404e-01f*(c2r-c1r);
real0[i+2*j*5] = c0r+d0r;
imag0[i+2*j*5] = c0i+d0i;
real0[i+(2*j+1)*5] = multiplyComplexRealPartConj(w[j*30/6], d1r+d2r, d1i+d2i);
imag0[i+(2*j+1)*5] = multiplyComplexImagPartConj(w[j*30/6], d1r+d2r, d1i+d2i);
real0[i+(2*j+2)*5] = multiplyComplexRealPartConj(w[j*60/6], d1r-d2r, d1i-d2i);
imag0[i+(2*j+2)*5] = multiplyComplexImagPartConj(w[j*60/6], d1r-d2r, d1i-d2i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 3 (radix 2)
if (indexInBlock < 15) {
int i = indexInBlock;
int j = i/15;
mixed4 c0r = real0[i];
mixed4 c0i = imag0[i];
mixed4 c1r = real0[i+15];
mixed4 c1i = imag0[i+15];
real1[i+j*15] = c0r+c1r;
imag1[i+j*15] = c0i+c1i;
real1[i+(j+1)*15] = multiplyComplexRealPartConj(w[j*30/2], c0r-c1r, c0i-c1i);
imag1[i+(j+1)*15] = multiplyComplexImagPartConj(w[j*30/2], c0r-c1r, c0i-c1i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
real0[indexInBlock] = real1[indexInBlock];
imag0[indexInBlock] = imag1[indexInBlock];
barrier(CLK_LOCAL_MEM_FENCE);
}

        {
__local mixed4* real0 = vreal;
__local mixed4* imag0 = vimag;
__local mixed4* real1 = &temp[blockStart];
__local mixed4* imag1 = &temp[blockStart+get_local_size(0)];
{
// Pass 1 (radix 5)
if (indexInBlock < 6) {
int i = indexInBlock;
int j = i/1;
mixed4 c0r = real0[i];
mixed4 c0i = imag0[i];
mixed4 c1r = real0[i+6];
mixed4 c1i = imag0[i+6];
mixed4 c2r = real0[i+12];
mixed4 c2i = imag0[i+12];
mixed4 c3r = real0[i+18];
mixed4 c3i = imag0[i+18];
mixed4 c4r = real0[i+24];
mixed4 c4i = imag0[i+24];
mixed4 d0r = c1r+c4r;
mixed4 d0i = c1i+c4i;
mixed4 d1r = c2r+c3r;
mixed4 d1i = c2i+c3i;
mixed4 d2r = 9.51056516e-01f*(c1r-c4r);
mixed4 d2i = 9.51056516e-01f*(c1i-c4i);
mixed4 d3r = 9.51056516e-01f*(c2r-c3r);
mixed4 d3i = 9.51056516e-01f*(c2i-c3i);
mixed4 d4r = d0r+d1r;
mixed4 d4i = d0i+d1i;
mixed4 d5r = 5.59016994e-01f*(d0r-d1r);
mixed4 d5i = 5.59016994e-01f*(d0i-d1i);
mixed4 d6r = c0r-0.25f*d4r;
mixed4 d6i = c0i-0.25f*d4i;
mixed4 d7r = d6r+d5r;
mixed4 d7i = d6i+d5i;
mixed4 d8r = d6r-d5r;
mixed4 d8i = d6i-d5i;
mixed4 d9r = -1.0f*(d2i+6.18033989e-01f*d3i);
mixed4 d9i = -1.0f*(-d2r-6.18033989e-01f*d3r);
mixed4 d10r = -1.0f*(6.18033989e-01f*d2i-d3i);
mixed4 d10i = -1.0f*(d3r-6.18033989e-01f*d2r);
real1[i+4*j*1] = c0r+d4r;
imag1[i+4*j*1] = c0i+d4i;
real1[i+(4*j+1)*1] = multiplyComplexRealPartConj(w[j*30/30], d7r+d9r, d7i+d9i);
imag1[i+(4*j+1)*1] = multiplyComplexImagPartConj(w[j*30/30], d7r+d9r, d7i+d9i);
real1[i+(4*j+2)*1] = multiplyComplexRealPartConj(w[j*60/30], d8r+d10r, d8i+d10i);
imag1[i+(4*j+2)*1] = multiplyComplexImagPartConj(w[j*60/30], d8r+d10r, d8i+d10i);
real1[i+(4*j+3)*1] = multiplyComplexRealPartConj(w[j*90/30], d8r-d10r, d8i-d10i);
imag1[i+(4*j+3)*1] = multiplyComplexImagPartConj(w[j*90/30], d8r-d10r, d8i-d10i);
real1[i+(4*j+4)*1] = multiplyComplexRealPartConj(w[j*120/30], d7r-d9r, d7i-d9i);
imag1[i+(4*j+4)*1] = multiplyComplexImagPartConj(w[j*120/30], d7r-d9r, d7i-d9i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 2 (radix 3)
if (indexInBlock < 10) {
int i = indexInBlock;
int j = i/5;
mixed4 c0r = real1[i];
mixed4 c0i = imag1[i];
mixed4 c1r = real1[i+10];
mixed4 c1i = imag1[i+10];
mixed4 c2r = real1[i+20];
mixed4 c2i = imag1[i+20];
mixed4 d0r = c1r+c2r;
mixed4 d0i = c1i+c2i;
mixed4 d1r = c0r-0.5f*d0r;
mixed4 d1i = c0i-0.5f*d0i;
mixed4 d2r = -1.0f*8.66025404e-01f*(c1i-c2i);
mixed4 d2i = -1.0f*8.66025404e-01f*(c2r-c1r);
real0[i+2*j*5] = c0r+d0r;
imag0[i+2*j*5] = c0i+d0i;
real0[i+(2*j+1)*5] = multiplyComplexRealPartConj(w[j*30/6], d1r+d2r, d1i+d2i);
imag0[i+(2*j+1)*5] = multiplyComplexImagPartConj(w[j*30/6], d1r+d2r, d1i+d2i);
real0[i+(2*j+2)*5] = multiplyComplexRealPartConj(w[j*60/6], d1r-d2r, d1i-d2i);
imag0[i+(2*j+2)*5] = multiplyComplexImagPartConj(w[j*60/6], d1r-d2r, d1i-d2i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
{
// Pass 3 (radix 2)
if (indexInBlock < 15) {
int i = indexInBlock;
int j = i/15;
mixed4 c0r = real0[i];
mixed4 c0i = imag0[i];
mixed4 c1r = real0[i+15];
mixed4 c1i = imag0[i+15];
real1[i+j*15] = c0r+c1r;
imag1[i+j*15] = c0i+c1i;
real1[i+(j+1)*15] = multiplyComplexRealPartConj(w[j*30/2], c0r-c1r, c0i-c1i);
imag1[i+(j+1)*15] = multiplyComplexImagPartConj(w[j*30/2], c0r-c1r, c0i-c1i);
}
barrier(CLK_LOCAL_MEM_FENCE);
}
real0[indexInBlock] = real1[indexInBlock];
imag0[indexInBlock] = imag1[indexInBlock];
barrier(CLK_LOCAL_MEM_FENCE);
}

        if (particleVelm.w != 0) {
            posq[particle+indexInBlock*PADDED_NUM_ATOMS].xyz = SCALE*qreal[indexInBlock].xyz;
            velm[particle+indexInBlock*PADDED_NUM_ATOMS].xyz = SCALE*vreal[indexInBlock].xyz;
        }
    }
}

/**
 * Advance the velocities by a half step.
 */
__kernel void advanceVelocities(__global mixed4* velm, __global real4* force, mixed dt) {
    const int numBlocks = get_global_size(0)/NUM_COPIES;
    const int blockStart = NUM_COPIES*(get_local_id(0)/NUM_COPIES);
    const int indexInBlock = get_local_id(0)-blockStart;

    // Update velocities.

    for (int particle = get_global_id(0)/NUM_COPIES; particle < NUM_ATOMS; particle += numBlocks) {
        int index = particle+indexInBlock*PADDED_NUM_ATOMS;
        mixed4 particleVelm = velm[index];
        particleVelm.xyz += convert_mixed4(force[index]).xyz*(0.5f*dt*particleVelm.w);
        if (particleVelm.w != 0)
            velm[index] = particleVelm;
    }
}

/**
 * Copy a set of positions and velocities from the integrator's arrays to the context.
 */
__kernel void copyDataToContext(__global mixed4* srcVel, __global mixed4* dstVel, __global mixed4* srcPos,
        __global real4* dstPos, __global int* order, int copy) {
    const int base = copy*PADDED_NUM_ATOMS;
    for (int particle = get_global_id(0); particle < NUM_ATOMS; particle += get_global_size(0)) {
        int index = base+order[particle];
        dstVel[particle] = srcVel[index];
        dstPos[particle] = convert_real4(srcPos[index]);
    }
}

/**
 * Copy a set of positions, velocities, and forces from the context to the integrator's arrays.
 */
__kernel void copyDataFromContext(__global real4* srcForce, __global real4* dstForce, __global mixed4* srcVel,
        __global mixed4* dstVel, __global real4* srcPos, __global mixed4* dstPos, __global int* order, int copy) {
    const int base = copy*PADDED_NUM_ATOMS;
    for (int particle = get_global_id(0); particle < NUM_ATOMS; particle += get_global_size(0)) {
        int index = base+order[particle];
        dstForce[index] = srcForce[particle];
        dstVel[index] = srcVel[particle];
        dstPos[index] = convert_mixed4(srcPos[particle]);
    }
}

/**
 * Atom positions in one copy have been modified.  Apply the same offsets to all the other copies.
 */
__kernel void applyCellTranslations(__global mixed4* posq, __global real4* movedPos, __global int* order, int movedCopy) {
    for (int particle = get_global_id(0); particle < NUM_ATOMS; particle += get_global_size(0)) {
        int index = order[particle];
        mixed4 delta = convert_mixed4(movedPos[particle])-posq[movedCopy*PADDED_NUM_ATOMS+index];
        for (int copy = 0; copy < NUM_COPIES; copy++)
            posq[copy*PADDED_NUM_ATOMS+index] += delta;
    }
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
