/**
* OpenCL Fast Fourier Transform implementation.
*
* Copyright 2011 by Rightware. All rights reserved.
*/


/** Passed from the compiler depending on platform */
#define real_t float
#define complex_t float2


// The higher radix kernels up to 16 are derived based on information from
// http://www.bealto.com/gpu-fft_intro.html and radix32 as a logical extension on the basic method



// real part of complex product (a,b)
#define MULT_RE(a,b) (a.x * b.x - a.y*b.y)
// imaginary part of complex product (a,b)
#define MULT_IM(a,b) (a.x * b.y + a.y*b.x)

// complex product
inline complex_t mul_1(complex_t a,complex_t b)
{
  return (complex_t) (MULT_RE(a,b), MULT_IM(a,b));
}

// Return a^2
inline complex_t sqr_1(complex_t a)
{
  return (complex_t)(a.x*a.x - a.y*a.y, 2.0f*a.x*a.y);
}

// Return cos(alpha)+I*sin(alpha)
inline complex_t exp_alpha_1(real_t alpha)
{
  float cs,sn;
  cs = half_cos(alpha); sn = half_sin(alpha);// native sin+cos
  return (complex_t)(cs,sn);
}

// Return a*EXP(-I*PI*1/2) = a*(-I)
inline complex_t mul_p1q2(complex_t a)
{
  return (complex_t)(a.y,-a.x);
}

// Return a*EXP(+I*PI*1/2) = a*(+I)
inline complex_t imul_p1q2(complex_t a)
{
  return (complex_t)(-a.y, a.x);
}

/** Complex multiplication */
inline complex_t mulcomp(complex_t a,complex_t b)
{
  return (complex_t)(a.x * b.x - a.y * b.y, a.y * b.x + a.x * b.y);
}

/** Twiddle .*/
inline complex_t twiddle(complex_t x, real_t alpha)
{
    real_t rl, img;
    img = half_sin(alpha);
    rl = half_cos(alpha);
    return mulcomp(x, (complex_t)(rl, img));
}

/**
* Radix 2 forward kernel
* Stage goes 1, 2, 4, 8 ... N/2
* Every invocation has to have N/2 threads
*/
__kernel void radix2fft(__global const complex_t * restrict input, __global complex_t * restrict output, int stage)
{
    const int size = get_global_size(0);
    const int i = get_global_id(0);

    /* Same as i % stage as stage is always power of two. As an interesting sidenote this method of output and input index calculation is almost similar to the bitonic sort */
    const int inputind = i & (stage - 1);
    const int outputind = ((i - inputind) << 1) + inputind;
    const real_t alpha = -M_PI_F*(real_t)inputind/(real_t)stage;
    complex_t i1 = input[i];
    complex_t i2 = twiddle(input[i + size], alpha);
    const complex_t tmp = i1 - i2;
    i1 += i2;
    i2 = tmp;
    output[outputind] = i1;
    output[outputind + stage] = i2;
}

/** Radix 2 inverse fft kernel. */
__kernel void radix2ifft(__global const complex_t * restrict input, __global complex_t * restrict output, int stage)
{
    const int size = get_global_size(0);
    const int i = get_global_id(0);

    /* Same as i % stage as stage is always power of two. As an interesting sidenote this method of output and input index calculation is almost similar to the bitonic sort */
    const int inputind = i & (stage - 1);
    const int outputind = ((i - inputind) << 1) + inputind;
    const real_t alpha = M_PI_F*(real_t)inputind/(real_t)stage;
    complex_t i1 = input[i];
    complex_t i2 = twiddle(input[i + size], alpha);
    const complex_t tmp = i1 - i2;
    i1 += i2;
    i2 = tmp;
    output[outputind] = i1/2.0f;
    output[outputind + stage] = i2/2.0f;
}

/** 2D row and columnvise versions of the radix2 kernel. */
__kernel void radix2fft2dRow(__global const complex_t * restrict input, __global complex_t * restrict output, int stage)
{
    const int size = get_global_size(0);
    const int i = get_global_id(0);
    const int j = get_global_id(1);

    const int inputind = i & (stage - 1);
    const int outputind = ((i - inputind) << 1) + inputind;

    const real_t alpha = -M_PI_F*(real_t)inputind/(real_t)stage;
    complex_t i1 = input[i + size*2*j];
    complex_t i2 = twiddle(input[i + size + size*2*j], alpha);
    const complex_t tmp = i1 - i2;
    i1 += i2;
    i2 = tmp;
    output[outputind + size*2*j] = i1;
    output[outputind + stage + size*2*j] = i2;
}

float2 square(float2 a) {
    return (float2)(a.x * a.x - a.y * a.y, 2.0f * a.x * a.y);
}

__constant float SQRT_2 = 0.707106781188f;

float2 mul_p1q4(float2 a) {
    return (float2)(SQRT_2) * (float2)(a.x + a.y, -a.x + a.y);
}

float2 mul_p3q4(float2 a) {
    return (float2)(SQRT_2) * (float2)(-a.x + a.y, -a.x - a.y);
}

#define mul_p0q1(a) (a)
#define mul_p0q2 mul_p0q1
#define mul_p0q4 mul_p0q2
#define mul_p2q4 mul_p1q2


__constant float COS_8 = 0.923879532511f; // cos(Pi/8)
__constant float SIN_8 = 0.382683432365f; // sin(Pi/8)
#define mul_p0q8 mul_p0q4
float2  mul_p1q8(float2 a) { return mul_1((float2)(COS_8,-SIN_8),a); }
#define mul_p2q8 mul_p1q4
float2  mul_p3q8(float2 a) { return mul_1((float2)(SIN_8,-COS_8),a); }
#define mul_p4q8 mul_p2q4
float2  mul_p5q8(float2 a) { return mul_1((float2)(-SIN_8,-COS_8),a); }
#define mul_p6q8 mul_p3q4
float2  mul_p7q8(float2 a) { return mul_1((float2)(-COS_8,-SIN_8),a); }

// Compute in-place DFT2 and twiddle
#define DFT2_TWIDDLE(a,b,t) { float2 tmp = t(a-b); a += b; b = tmp; }

__kernel void fft_radix16_2drow(__global const float2 * restrict x,__global float2 * restrict y,int p)
{
  const int t = get_global_size(0); // number of threads
  const int i = get_global_id(0); // current thread
  const int j = get_global_id(1); // current thread
  const int k = i & (p-1); // index in input sequence, in 0..P-1
  const int row_offset = t * 16 * j;

  // Inputs indices are I+{0,..,15}*T
  x += i + row_offset;

  // Output indices are J+{0,..,15}*P, where
  // J is I with four 0 bits inserted at bit log2(P)
  y += ((i-k)<<4) + k + row_offset;

  // Load
  float2 u[16];
  for (int m=0;m<16;m++) u[m] = x[m*t];

  // Twiddle, twiddling factors are exp(_I*PI*{0,..,15}*K/8P)
  float alpha = -M_PI_F*(float)k/(float)(8*p);
  for (int m=1;m<16;m++) u[m] = mul_1(exp_alpha_1(m*alpha),u[m]);

  // 8x in-place DFT2 and twiddle (1)
  DFT2_TWIDDLE(u[0],u[8],mul_p0q8);

  DFT2_TWIDDLE(u[1],u[9],mul_p1q8);

  DFT2_TWIDDLE(u[2],u[10],mul_p2q8);

  DFT2_TWIDDLE(u[3],u[11],mul_p3q8);

  DFT2_TWIDDLE(u[4],u[12],mul_p4q8);

  DFT2_TWIDDLE(u[5],u[13],mul_p5q8);

  DFT2_TWIDDLE(u[6],u[14],mul_p6q8);

  DFT2_TWIDDLE(u[7],u[15],mul_p7q8);



  // 8x in-place DFT2 and twiddle (2)

  DFT2_TWIDDLE(u[0],u[4],mul_p0q4);

  DFT2_TWIDDLE(u[1],u[5],mul_p1q4);

  DFT2_TWIDDLE(u[2],u[6],mul_p2q4);

  DFT2_TWIDDLE(u[3],u[7],mul_p3q4);

  DFT2_TWIDDLE(u[8],u[12],mul_p0q4);

  DFT2_TWIDDLE(u[9],u[13],mul_p1q4);

  DFT2_TWIDDLE(u[10],u[14],mul_p2q4);

  DFT2_TWIDDLE(u[11],u[15],mul_p3q4);



  // 8x in-place DFT2 and twiddle (3)

  DFT2_TWIDDLE(u[0],u[2],mul_p0q2);

  DFT2_TWIDDLE(u[1],u[3],mul_p1q2);

  DFT2_TWIDDLE(u[4],u[6],mul_p0q2);

  DFT2_TWIDDLE(u[5],u[7],mul_p1q2);

  DFT2_TWIDDLE(u[8],u[10],mul_p0q2);

  DFT2_TWIDDLE(u[9],u[11],mul_p1q2);

  DFT2_TWIDDLE(u[12],u[14],mul_p0q2);

  DFT2_TWIDDLE(u[13],u[15],mul_p1q2);



  // 8x DFT2 and store (reverse binary permutation)

  y[0]    = u[0]  + u[1]  ;
  y[p]    = u[8]  + u[9]  ;
  y[2*p]  = u[4]  + u[5]  ;
  y[3*p]  = u[12] + u[13] ;
  y[4*p]  = u[2]  + u[3]  ;
  y[5*p]  = u[10] + u[11] ;
  y[6*p]  = u[6]  + u[7]  ;
  y[7*p]  = u[14] + u[15] ;
  y[8*p]  = u[0]  - u[1]  ;
  y[9*p]  = u[8]  - u[9]  ;
  y[10*p] = u[4]  - u[5]  ;
  y[11*p] = u[12] - u[13] ;
  y[12*p] = u[2]  - u[3]  ;
  y[13*p] = u[10] - u[11] ;
  y[14*p] = u[6]  - u[7]  ;
  y[15*p] = u[14] - u[15] ;
}
__kernel void fft_radix16_2dcolumn(__global const float2 * restrict x,__global float2 * restrict y,int p)
{
  const int t = get_global_size(1); // number of threads
  const int stride = t * 16;

  const int i = get_global_id(0); // current thread
  const int j = get_global_id(1); // current thread

  // Inputs indices are I+{0,..,15}*T
  const int k = j & (p-1); // index in input sequence, in 0..P-1
  // Output indices are J+{0,..,15}*P, where
  // J is I with four 0 bits inserted at bit log2(P)
  const int l = ((j-k)<<4) + k;

  //const int row_offset = t * 16 * j;
  // Inputs indices are I+{0,..,15}*T
  //x += i + row_offset;

  // Output indices are J+{0,..,15}*P, where
  // J is I with four 0 bits inserted at bit log2(P)
  //y += ((i-k)<<4) + k + row_offset;

  // Load
  float2 u[16];
  for (int m=0;m<16;m++) u[m] = x[i + stride*(j+m*t)];

  // Twiddle, twiddling factors are exp(_I*PI*{0,..,15}*K/8P)
  float alpha = -M_PI_F*(float)k/(float)(8*p);

  for (int m=1;m<16;m++) u[m] = mul_1(exp_alpha_1(m*alpha),u[m]);

  // 8x in-place DFT2 and twiddle (1)
  DFT2_TWIDDLE(u[0],u[8],mul_p0q8);
  DFT2_TWIDDLE(u[1],u[9],mul_p1q8);
  DFT2_TWIDDLE(u[2],u[10],mul_p2q8);
  DFT2_TWIDDLE(u[3],u[11],mul_p3q8);
  DFT2_TWIDDLE(u[4],u[12],mul_p4q8);
  DFT2_TWIDDLE(u[5],u[13],mul_p5q8);
  DFT2_TWIDDLE(u[6],u[14],mul_p6q8);
  DFT2_TWIDDLE(u[7],u[15],mul_p7q8);

  // 8x in-place DFT2 and twiddle (2)
  DFT2_TWIDDLE(u[0],u[4],mul_p0q4);
  DFT2_TWIDDLE(u[1],u[5],mul_p1q4);
  DFT2_TWIDDLE(u[2],u[6],mul_p2q4);
  DFT2_TWIDDLE(u[3],u[7],mul_p3q4);
  DFT2_TWIDDLE(u[8],u[12],mul_p0q4);
  DFT2_TWIDDLE(u[9],u[13],mul_p1q4);
  DFT2_TWIDDLE(u[10],u[14],mul_p2q4);
  DFT2_TWIDDLE(u[11],u[15],mul_p3q4);

  // 8x in-place DFT2 and twiddle (3)
  DFT2_TWIDDLE(u[0],u[2],mul_p0q2);
  DFT2_TWIDDLE(u[1],u[3],mul_p1q2);
  DFT2_TWIDDLE(u[4],u[6],mul_p0q2);
  DFT2_TWIDDLE(u[5],u[7],mul_p1q2);
  DFT2_TWIDDLE(u[8],u[10],mul_p0q2);
  DFT2_TWIDDLE(u[9],u[11],mul_p1q2);
  DFT2_TWIDDLE(u[12],u[14],mul_p0q2);
  DFT2_TWIDDLE(u[13],u[15],mul_p1q2);

  // 8x DFT2 and store (reverse binary permutation)
  y[i + stride*(l+0)]    = u[0]  + u[1]  ;
  y[i + stride*(l+p)]    = u[8]  + u[9]  ;
  y[i + stride*(l+2*p)]  = u[4]  + u[5]  ;
  y[i + stride*(l+3*p)]  = u[12] + u[13] ;
  y[i + stride*(l+4*p)]  = u[2]  + u[3]  ;
  y[i + stride*(l+5*p)]  = u[10] + u[11] ;
  y[i + stride*(l+6*p)]  = u[6]  + u[7]  ;
  y[i + stride*(l+7*p)]  = u[14] + u[15] ;
  y[i + stride*(l+8*p)]  = u[0]  - u[1]  ;
  y[i + stride*(l+9*p)]  = u[8]  - u[9]  ;
  y[i + stride*(l+10*p)] = u[4]  - u[5]  ;
  y[i + stride*(l+11*p)] = u[12] - u[13] ;
  y[i + stride*(l+12*p)] = u[2]  - u[3]  ;
  y[i + stride*(l+13*p)] = u[10] - u[11] ;
  y[i + stride*(l+14*p)] = u[6]  - u[7]  ;
  y[i + stride*(l+15*p)] = u[14] - u[15] ;
}

// cos(Pi/16)
// sin(Pi/16)
#define COS_16F 0.98078528040323044912618223613424f
#define SIN_16F 0.19509032201612826784828486847702f

// cos(3Pi/16)
// sin(3Pi/16)
#define COS3_16F 0.83146961230254523707878837761791f
#define SIN3_16F 0.55557023301960222474283081394853f

__constant float COS_16 = COS_16F; // cos(Pi/16)
__constant float SIN_16 = SIN_16F; // sin(Pi/16)

__constant float COS3_16 = COS3_16F; // cos(3Pi/16)
__constant float SIN3_16 = SIN3_16F; // sin(3Pi/16)

__constant float COS5_16 = SIN3_16F; // cos(5Pi/16)
__constant float SIN5_16 = COS3_16F; // sin(5Pi/16);

__constant float COS7_16 = SIN_16F; // cos(7Pi/16)
__constant float SIN7_16 = COS_16F; // sin(7Pi/16);


#define mul_p0q16 mul_p0q8
float2  mul_p1q16(float2 a) { return mul_1((float2)(COS_16,-SIN_16),a); }
#define mul_p2q16 mul_p1q8
float2  mul_p3q16(float2 a) { return mul_1((float2)(COS3_16,-SIN3_16),a); }
#define mul_p4q16 mul_p2q8
float2  mul_p5q16(float2 a) { return mul_1((float2)(COS5_16,-SIN5_16),a); }
#define mul_p6q16 mul_p3q8
float2  mul_p7q16(float2 a) { return mul_1((float2)(COS7_16,-SIN7_16),a); }
#define mul_p8q16 mul_p4q8
float2  mul_p9q16(float2 a) { return mul_1((float2)(-SIN_16,-COS_16),a); }
#define mul_p10q16 mul_p5q8
float2  mul_p11q16(float2 a) { return mul_1((float2)(-SIN3_16,-COS3_16),a); }
#define mul_p12q16 mul_p6q8
float2  mul_p13q16(float2 a) { return mul_1((float2)(-SIN5_16,-COS5_16),a); }
#define mul_p14q16 mul_p7q8
float2  mul_p15q16(float2 a) { return mul_1((float2)(-SIN7_16,-COS7_16),a); }

#define imul_p0q16 imul_p0q8
float2  imul_p1q16(float2 a) { return mul_1((float2)(COS_16,SIN_16),a); }
#define imul_p2q16 imul_p1q8
float2  imul_p3q16(float2 a) { return mul_1((float2)(COS3_16,SIN3_16),a); }
#define imul_p4q16 imul_p2q8
float2  imul_p5q16(float2 a) { return mul_1((float2)(COS5_16,SIN5_16),a); }
#define imul_p6q16 imul_p3q8
float2  imul_p7q16(float2 a) { return mul_1((float2)(COS7_16,SIN7_16),a); }
#define imul_p8q16 imul_p4q8
float2  imul_p9q16(float2 a) { return mul_1((float2)(-SIN_16,COS_16),a); }
#define imul_p10q16 imul_p5q8
float2  imul_p11q16(float2 a) { return mul_1((float2)(-SIN3_16,COS3_16),a); }
#define imul_p12q16 imul_p6q8
float2  imul_p13q16(float2 a) { return mul_1((float2)(-SIN5_16,COS5_16),a); }
#define imul_p14q16 imul_p7q8
float2  imul_p15q16(float2 a) { return mul_1((float2)(-SIN7_16,COS7_16),a); }

__kernel void fft_radix32_2drow(__global const float2 * restrict x,__global float2 * restrict y,int p)
{
  const int t = get_global_size(0); // number of threads
  const int i = get_global_id(0); // current thread
  const int j = get_global_id(1); // current thread
  const int k = i & (p-1); // index in input sequence, in 0..P-1
  const int row_offset = t * 32 * j;

  // Inputs indices are I+{0,..,31}*T
  x += i + row_offset;

  // Output indices are J+{0,..,31}*P, where
  // J is I with four 0 bits inserted at bit log2(P)
  y += ((i-k)<<5) + k + row_offset;

  // Load
  float2 u[32];
  for (int m=0;m<32;m++) u[m] = x[m*t];

  // Twiddle, twiddling factors are exp(_I*PI*{0,..,31}*K/16P)
  float alpha = -M_PI_F*(float)k/(float)(16*p);
  for (int m=1;m<32;m++) u[m] = mul_1(exp_alpha_1(m*alpha),u[m]);

  // 16x in-place DFT2 and twiddle (1)
  DFT2_TWIDDLE(u[ 0],u[16], mul_p0q16);
  DFT2_TWIDDLE(u[ 1],u[17], mul_p1q16);
  DFT2_TWIDDLE(u[ 2],u[18], mul_p2q16);
  DFT2_TWIDDLE(u[ 3],u[19], mul_p3q16);
  DFT2_TWIDDLE(u[ 4],u[20], mul_p4q16);
  DFT2_TWIDDLE(u[ 5],u[21], mul_p5q16);
  DFT2_TWIDDLE(u[ 6],u[22], mul_p6q16);
  DFT2_TWIDDLE(u[ 7],u[23], mul_p7q16);
  DFT2_TWIDDLE(u[ 8],u[24], mul_p8q16);
  DFT2_TWIDDLE(u[ 9],u[25], mul_p9q16);
  DFT2_TWIDDLE(u[10],u[26],mul_p10q16);
  DFT2_TWIDDLE(u[11],u[27],mul_p11q16);
  DFT2_TWIDDLE(u[12],u[28],mul_p12q16);
  DFT2_TWIDDLE(u[13],u[29],mul_p13q16);
  DFT2_TWIDDLE(u[14],u[30],mul_p14q16);
  DFT2_TWIDDLE(u[15],u[31],mul_p15q16);

  // 16x in-place DFT2 and twiddle (2)
  DFT2_TWIDDLE(u[0],u[8],mul_p0q8);
  DFT2_TWIDDLE(u[1],u[9],mul_p1q8);
  DFT2_TWIDDLE(u[2],u[10],mul_p2q8);
  DFT2_TWIDDLE(u[3],u[11],mul_p3q8);
  DFT2_TWIDDLE(u[4],u[12],mul_p4q8);
  DFT2_TWIDDLE(u[5],u[13],mul_p5q8);
  DFT2_TWIDDLE(u[6],u[14],mul_p6q8);
  DFT2_TWIDDLE(u[7],u[15],mul_p7q8);
  DFT2_TWIDDLE(u[16],u[24],mul_p0q8);
  DFT2_TWIDDLE(u[17],u[25],mul_p1q8);
  DFT2_TWIDDLE(u[18],u[26],mul_p2q8);
  DFT2_TWIDDLE(u[19],u[27],mul_p3q8);
  DFT2_TWIDDLE(u[20],u[28],mul_p4q8);
  DFT2_TWIDDLE(u[21],u[29],mul_p5q8);
  DFT2_TWIDDLE(u[22],u[30],mul_p6q8);
  DFT2_TWIDDLE(u[23],u[31],mul_p7q8);

  // 16x in-place DFT2 and twiddle (3)
  DFT2_TWIDDLE(u[0],u[4],mul_p0q4);
  DFT2_TWIDDLE(u[1],u[5],mul_p1q4);
  DFT2_TWIDDLE(u[2],u[6],mul_p2q4);
  DFT2_TWIDDLE(u[3],u[7],mul_p3q4);
  DFT2_TWIDDLE(u[8],u[12],mul_p0q4);
  DFT2_TWIDDLE(u[9],u[13],mul_p1q4);
  DFT2_TWIDDLE(u[10],u[14],mul_p2q4);
  DFT2_TWIDDLE(u[11],u[15],mul_p3q4);
  DFT2_TWIDDLE(u[16],u[20],mul_p0q4);
  DFT2_TWIDDLE(u[17],u[21],mul_p1q4);
  DFT2_TWIDDLE(u[18],u[22],mul_p2q4);
  DFT2_TWIDDLE(u[19],u[23],mul_p3q4);
  DFT2_TWIDDLE(u[24],u[28],mul_p0q4);
  DFT2_TWIDDLE(u[25],u[29],mul_p1q4);
  DFT2_TWIDDLE(u[26],u[30],mul_p2q4);
  DFT2_TWIDDLE(u[27],u[31],mul_p3q4);

  // 16x in-place DFT2 and twiddle (3)
  DFT2_TWIDDLE(u[0],u[2],mul_p0q2);
  DFT2_TWIDDLE(u[1],u[3],mul_p1q2);
  DFT2_TWIDDLE(u[4],u[6],mul_p0q2);
  DFT2_TWIDDLE(u[5],u[7],mul_p1q2);
  DFT2_TWIDDLE(u[8],u[10],mul_p0q2);
  DFT2_TWIDDLE(u[9],u[11],mul_p1q2);
  DFT2_TWIDDLE(u[12],u[14],mul_p0q2);
  DFT2_TWIDDLE(u[13],u[15],mul_p1q2);
  DFT2_TWIDDLE(u[16],u[18],mul_p0q2);
  DFT2_TWIDDLE(u[17],u[19],mul_p1q2);
  DFT2_TWIDDLE(u[20],u[22],mul_p0q2);
  DFT2_TWIDDLE(u[21],u[23],mul_p1q2);
  DFT2_TWIDDLE(u[24],u[26],mul_p0q2);
  DFT2_TWIDDLE(u[25],u[27],mul_p1q2);
  DFT2_TWIDDLE(u[28],u[30],mul_p0q2);
  DFT2_TWIDDLE(u[29],u[31],mul_p1q2);

  // 16x DFT2 and store (reverse binary permutation)
  y[0]    = u[ 0] + u[ 1] ;
  y[p]    = u[16] + u[17] ;
  y[2*p]  = u[ 8] + u[ 9] ;
  y[3*p]  = u[24] + u[25] ;
  y[4*p]  = u[ 4] + u[ 5] ;
  y[5*p]  = u[20] + u[21] ;
  y[6*p]  = u[12] + u[13] ;
  y[7*p]  = u[28] + u[29] ;
  y[8*p]  = u[ 2] + u[ 3] ;
  y[9*p]  = u[18] + u[19] ;
  y[10*p] = u[10] + u[11] ;
  y[11*p] = u[26] + u[27] ;
  y[12*p] = u[ 6] + u[ 7] ;
  y[13*p] = u[22] + u[23] ;
  y[14*p] = u[14] + u[15] ;
  y[15*p] = u[30] + u[31] ;
  y[16*p] = u[ 0] - u[ 1] ;
  y[17*p] = u[16] - u[17] ;
  y[18*p] = u[ 8] - u[ 9] ;
  y[19*p] = u[24] - u[25] ;
  y[20*p] = u[ 4] - u[ 5] ;
  y[21*p] = u[20] - u[21] ;
  y[22*p] = u[12] - u[13] ;
  y[23*p] = u[28] - u[29] ;
  y[24*p] = u[ 2] - u[ 3] ;
  y[25*p] = u[18] - u[19] ;
  y[26*p] = u[10] - u[11] ;
  y[27*p] = u[26] - u[27] ;
  y[28*p] = u[ 6] - u[ 7] ;
  y[29*p] = u[22] - u[23] ;
  y[30*p] = u[14] - u[15] ;
  y[31*p] = u[30] - u[31] ;
}

__kernel void fft_radix32_2dcolumn(__global const float2 * restrict x,__global float2 * restrict y,int p)
{
  const int t = get_global_size(1); // number of threads
  const int i = get_global_id(0); // current thread
  const int j = get_global_id(1); // current thread
  const int k = j & (p-1); // index in input sequence, in 0..P-1
  const int stride = t * 32;
  const int l = ((j-k)<<5) + k;

  // Load
  float2 u[32];
  for (int m=0;m<32;m++) u[m] = x[i + stride*(j+m*t)];

  // Twiddle, twiddling factors are exp(_I*PI*{0,..,31}*K/16P)
  float alpha = -M_PI_F*(float)k/(float)(16*p);
  for (int m=1;m<32;m++) u[m] = mul_1(exp_alpha_1(m*alpha),u[m]);

  // 16x in-place DFT2 and twiddle (1)
  DFT2_TWIDDLE(u[ 0],u[16], mul_p0q16);
  DFT2_TWIDDLE(u[ 1],u[17], mul_p1q16);
  DFT2_TWIDDLE(u[ 2],u[18], mul_p2q16);
  DFT2_TWIDDLE(u[ 3],u[19], mul_p3q16);
  DFT2_TWIDDLE(u[ 4],u[20], mul_p4q16);
  DFT2_TWIDDLE(u[ 5],u[21], mul_p5q16);
  DFT2_TWIDDLE(u[ 6],u[22], mul_p6q16);
  DFT2_TWIDDLE(u[ 7],u[23], mul_p7q16);
  DFT2_TWIDDLE(u[ 8],u[24], mul_p8q16);
  DFT2_TWIDDLE(u[ 9],u[25], mul_p9q16);
  DFT2_TWIDDLE(u[10],u[26],mul_p10q16);
  DFT2_TWIDDLE(u[11],u[27],mul_p11q16);
  DFT2_TWIDDLE(u[12],u[28],mul_p12q16);
  DFT2_TWIDDLE(u[13],u[29],mul_p13q16);
  DFT2_TWIDDLE(u[14],u[30],mul_p14q16);
  DFT2_TWIDDLE(u[15],u[31],mul_p15q16);

  // 16x in-place DFT2 and twiddle (2)
  DFT2_TWIDDLE(u[0],u[8],mul_p0q8);
  DFT2_TWIDDLE(u[1],u[9],mul_p1q8);
  DFT2_TWIDDLE(u[2],u[10],mul_p2q8);
  DFT2_TWIDDLE(u[3],u[11],mul_p3q8);
  DFT2_TWIDDLE(u[4],u[12],mul_p4q8);
  DFT2_TWIDDLE(u[5],u[13],mul_p5q8);
  DFT2_TWIDDLE(u[6],u[14],mul_p6q8);
  DFT2_TWIDDLE(u[7],u[15],mul_p7q8);
  DFT2_TWIDDLE(u[16],u[24],mul_p0q8);
  DFT2_TWIDDLE(u[17],u[25],mul_p1q8);
  DFT2_TWIDDLE(u[18],u[26],mul_p2q8);
  DFT2_TWIDDLE(u[19],u[27],mul_p3q8);
  DFT2_TWIDDLE(u[20],u[28],mul_p4q8);
  DFT2_TWIDDLE(u[21],u[29],mul_p5q8);
  DFT2_TWIDDLE(u[22],u[30],mul_p6q8);
  DFT2_TWIDDLE(u[23],u[31],mul_p7q8);

  // 16x in-place DFT2 and twiddle (3)
  DFT2_TWIDDLE(u[0],u[4],mul_p0q4);
  DFT2_TWIDDLE(u[1],u[5],mul_p1q4);
  DFT2_TWIDDLE(u[2],u[6],mul_p2q4);
  DFT2_TWIDDLE(u[3],u[7],mul_p3q4);
  DFT2_TWIDDLE(u[8],u[12],mul_p0q4);
  DFT2_TWIDDLE(u[9],u[13],mul_p1q4);
  DFT2_TWIDDLE(u[10],u[14],mul_p2q4);
  DFT2_TWIDDLE(u[11],u[15],mul_p3q4);
  DFT2_TWIDDLE(u[16],u[20],mul_p0q4);
  DFT2_TWIDDLE(u[17],u[21],mul_p1q4);
  DFT2_TWIDDLE(u[18],u[22],mul_p2q4);
  DFT2_TWIDDLE(u[19],u[23],mul_p3q4);
  DFT2_TWIDDLE(u[24],u[28],mul_p0q4);
  DFT2_TWIDDLE(u[25],u[29],mul_p1q4);
  DFT2_TWIDDLE(u[26],u[30],mul_p2q4);
  DFT2_TWIDDLE(u[27],u[31],mul_p3q4);

  // 16x in-place DFT2 and twiddle (3)
  DFT2_TWIDDLE(u[0],u[2],mul_p0q2);
  DFT2_TWIDDLE(u[1],u[3],mul_p1q2);
  DFT2_TWIDDLE(u[4],u[6],mul_p0q2);
  DFT2_TWIDDLE(u[5],u[7],mul_p1q2);
  DFT2_TWIDDLE(u[8],u[10],mul_p0q2);
  DFT2_TWIDDLE(u[9],u[11],mul_p1q2);
  DFT2_TWIDDLE(u[12],u[14],mul_p0q2);
  DFT2_TWIDDLE(u[13],u[15],mul_p1q2);
  DFT2_TWIDDLE(u[16],u[18],mul_p0q2);
  DFT2_TWIDDLE(u[17],u[19],mul_p1q2);
  DFT2_TWIDDLE(u[20],u[22],mul_p0q2);
  DFT2_TWIDDLE(u[21],u[23],mul_p1q2);
  DFT2_TWIDDLE(u[24],u[26],mul_p0q2);
  DFT2_TWIDDLE(u[25],u[27],mul_p1q2);
  DFT2_TWIDDLE(u[28],u[30],mul_p0q2);
  DFT2_TWIDDLE(u[29],u[31],mul_p1q2);

  // 16x DFT2 and store (reverse binary permutation)
  y[i + stride*(l+0)]    = u[ 0] + u[ 1] ;
  y[i + stride*(l+p)]    = u[16] + u[17] ;
  y[i + stride*(l+2*p)]  = u[ 8] + u[ 9] ;
  y[i + stride*(l+3*p)]  = u[24] + u[25] ;
  y[i + stride*(l+4*p)]  = u[ 4] + u[ 5] ;
  y[i + stride*(l+5*p)]  = u[20] + u[21] ;
  y[i + stride*(l+6*p)]  = u[12] + u[13] ;
  y[i + stride*(l+7*p)]  = u[28] + u[29] ;
  y[i + stride*(l+8*p)]  = u[ 2] + u[ 3] ;
  y[i + stride*(l+9*p)]  = u[18] + u[19] ;
  y[i + stride*(l+10*p)] = u[10] + u[11] ;
  y[i + stride*(l+11*p)] = u[26] + u[27] ;
  y[i + stride*(l+12*p)] = u[ 6] + u[ 7] ;
  y[i + stride*(l+13*p)] = u[22] + u[23] ;
  y[i + stride*(l+14*p)] = u[14] + u[15] ;
  y[i + stride*(l+15*p)] = u[30] + u[31] ;
  y[i + stride*(l+16*p)] = u[ 0] - u[ 1] ;
  y[i + stride*(l+17*p)] = u[16] - u[17] ;
  y[i + stride*(l+18*p)] = u[ 8] - u[ 9] ;
  y[i + stride*(l+19*p)] = u[24] - u[25] ;
  y[i + stride*(l+20*p)] = u[ 4] - u[ 5] ;
  y[i + stride*(l+21*p)] = u[20] - u[21] ;
  y[i + stride*(l+22*p)] = u[12] - u[13] ;
  y[i + stride*(l+23*p)] = u[28] - u[29] ;
  y[i + stride*(l+24*p)] = u[ 2] - u[ 3] ;
  y[i + stride*(l+25*p)] = u[18] - u[19] ;
  y[i + stride*(l+26*p)] = u[10] - u[11] ;
  y[i + stride*(l+27*p)] = u[26] - u[27] ;
  y[i + stride*(l+28*p)] = u[ 6] - u[ 7] ;
  y[i + stride*(l+29*p)] = u[22] - u[23] ;
  y[i + stride*(l+30*p)] = u[14] - u[15] ;
  y[i + stride*(l+31*p)] = u[30] - u[31] ;
}

//zero angle
#define imul_p0q1(a) (a)
#define imul_p0q2 imul_p0q1
#define imul_p0q4 imul_p0q2
#define imul_p2q4 imul_p1q2

// for angle +PI/4
float2 imul_p1q4(float2 a) {
    return (float2)(SQRT_2) * (float2)(a.x - a.y, a.x + a.y);
}
// for angle +3PI/4
float2 imul_p3q4(float2 a) {
    return (float2)(SQRT_2) * (float2)(-a.x - a.y,  a.x - a.y);
}

#define imul_p0q8 imul_p0q4
float2  imul_p1q8(float2 a) { return mul_1((float2)(COS_8, SIN_8),a); }
#define imul_p2q8 imul_p1q4
float2  imul_p3q8(float2 a) { return mul_1((float2)(SIN_8, COS_8),a); }
#define imul_p4q8 imul_p2q4
float2  imul_p5q8(float2 a) { return mul_1((float2)(-SIN_8, COS_8),a); }
#define imul_p6q8 imul_p3q4
float2  imul_p7q8(float2 a) { return mul_1((float2)(-COS_8, SIN_8),a); }

/** Inverse fft radix 16 */
__kernel void ifft_radix16_2drow(__global const float2 * restrict x,__global float2 * restrict y,int p)
{

  const int t = get_global_size(0); // number of threads
  const int i = get_global_id(0); // current thread
  const int j = get_global_id(1); // current thread
  const int k = i & (p-1); // index in input sequence, in 0..P-1
  const int row_offset = t * 16 * j;

  // Inputs indices are I+{0,..,15}*T
  x += i + row_offset;

  // Output indices are J+{0,..,15}*P, where
  // J is I with four 0 bits inserted at bit log2(P)
  y += ((i-k)<<4) + k + row_offset;

  // Load
  float2 u[16];
  for (int m=0;m<16;m++) u[m] = x[m*t];

  // Twiddle, twiddling factors are exp(_I*PI*{0,..,15}*K/8P)
  float alpha = M_PI_F*(float)k/(float)(8*p);
  for (int m=1;m<16;m++) u[m] = mul_1(exp_alpha_1(m*alpha),u[m]);

  // 8x in-place DFT2 and twiddle (1)
  DFT2_TWIDDLE(u[0],u[8],imul_p0q8);

  DFT2_TWIDDLE(u[1],u[9],imul_p1q8);

  DFT2_TWIDDLE(u[2],u[10],imul_p2q8);

  DFT2_TWIDDLE(u[3],u[11],imul_p3q8);

  DFT2_TWIDDLE(u[4],u[12],imul_p4q8);

  DFT2_TWIDDLE(u[5],u[13],imul_p5q8);

  DFT2_TWIDDLE(u[6],u[14],imul_p6q8);

  DFT2_TWIDDLE(u[7],u[15],imul_p7q8);



  // 8x in-place DFT2 and twiddle (2)

  DFT2_TWIDDLE(u[0],u[4],imul_p0q4);

  DFT2_TWIDDLE(u[1],u[5],imul_p1q4);

  DFT2_TWIDDLE(u[2],u[6],imul_p2q4);

  DFT2_TWIDDLE(u[3],u[7],imul_p3q4);

  DFT2_TWIDDLE(u[8],u[12],imul_p0q4);

  DFT2_TWIDDLE(u[9],u[13],imul_p1q4);

  DFT2_TWIDDLE(u[10],u[14],imul_p2q4);

  DFT2_TWIDDLE(u[11],u[15],imul_p3q4);



  // 8x in-place DFT2 and twiddle (3)

  DFT2_TWIDDLE(u[0],u[2],imul_p0q2);

  DFT2_TWIDDLE(u[1],u[3],imul_p1q2);

  DFT2_TWIDDLE(u[4],u[6],imul_p0q2);

  DFT2_TWIDDLE(u[5],u[7],imul_p1q2);

  DFT2_TWIDDLE(u[8],u[10],imul_p0q2);

  DFT2_TWIDDLE(u[9],u[11],imul_p1q2);

  DFT2_TWIDDLE(u[12],u[14],imul_p0q2);

  DFT2_TWIDDLE(u[13],u[15],imul_p1q2);



  // 8x DFT2 and store (reverse binary permutation)
  // 1/N factor = 1/16 for scaling back
  const float fact = 0.0625f;

  y[0]    = fact* (u[0]  + u[1]  );
  y[p]    = fact* (u[8]  + u[9]  );
  y[2*p]  = fact* (u[4]  + u[5]  );
  y[3*p]  = fact* (u[12] + u[13] );
  y[4*p]  = fact* (u[2]  + u[3]  );
  y[5*p]  = fact* (u[10] + u[11] );
  y[6*p]  = fact* (u[6]  + u[7]  );
  y[7*p]  = fact* (u[14] + u[15] );
  y[8*p]  = fact* (u[0]  - u[1]  );
  y[9*p]  = fact* (u[8]  - u[9]  );
  y[10*p] = fact* (u[4]  - u[5]  );
  y[11*p] = fact* (u[12] - u[13] );
  y[12*p] = fact* (u[2]  - u[3]  );
  y[13*p] = fact* (u[10] - u[11] );
  y[14*p] = fact* (u[6]  - u[7]  );
  y[15*p] = fact* (u[14] - u[15] );

}

__kernel void ifft_radix16_2dcolumn(__global const float2 * restrict x,__global float2 * restrict y,int p)
{
  const int t = get_global_size(1); // number of threads
  const int stride = t * 16;

  const int i = get_global_id(0); // current thread
  const int j = get_global_id(1); // current thread

  // Inputs indices are I+{0,..,15}*T
  const int k = j & (p-1); // index in input sequence, in 0..P-1
  // Output indices are J+{0,..,15}*P, where
  // J is I with four 0 bits inserted at bit log2(P)
  const int l = ((j-k)<<4) + k;

  //const int row_offset = t * 16 * j;
  // Inputs indices are I+{0,..,15}*T
  //x += i + row_offset;

  // Output indices are J+{0,..,15}*P, where
  // J is I with four 0 bits inserted at bit log2(P)
  //y += ((i-k)<<4) + k + row_offset;

  // Load
  float2 u[16];
  for (int m=0;m<16;m++) u[m] = x[i + stride*(j+m*t)];

  // Twiddle, twiddling factors are exp(I*PI*{0,..,15}*K/8P)
  float alpha = M_PI_F*(float)k/(float)(8*p);

  for (int m=1;m<16;m++) u[m] = mul_1(exp_alpha_1(m*alpha),u[m]);

  // 8x in-place DFT2 and twiddle (1)
  DFT2_TWIDDLE(u[0],u[8],imul_p0q8);
  DFT2_TWIDDLE(u[1],u[9],imul_p1q8);
  DFT2_TWIDDLE(u[2],u[10],imul_p2q8);
  DFT2_TWIDDLE(u[3],u[11],imul_p3q8);
  DFT2_TWIDDLE(u[4],u[12],imul_p4q8);
  DFT2_TWIDDLE(u[5],u[13],imul_p5q8);
  DFT2_TWIDDLE(u[6],u[14],imul_p6q8);
  DFT2_TWIDDLE(u[7],u[15],imul_p7q8);

  // 8x in-place DFT2 and twiddle (2)
  DFT2_TWIDDLE(u[0],u[4],imul_p0q4);
  DFT2_TWIDDLE(u[1],u[5],imul_p1q4);
  DFT2_TWIDDLE(u[2],u[6],imul_p2q4);
  DFT2_TWIDDLE(u[3],u[7],imul_p3q4);
  DFT2_TWIDDLE(u[8],u[12],imul_p0q4);
  DFT2_TWIDDLE(u[9],u[13],imul_p1q4);
  DFT2_TWIDDLE(u[10],u[14],imul_p2q4);
  DFT2_TWIDDLE(u[11],u[15],imul_p3q4);

  // 8x in-place DFT2 and twiddle (3)
  DFT2_TWIDDLE(u[0],u[2],imul_p0q2);
  DFT2_TWIDDLE(u[1],u[3],imul_p1q2);
  DFT2_TWIDDLE(u[4],u[6],imul_p0q2);
  DFT2_TWIDDLE(u[5],u[7],imul_p1q2);
  DFT2_TWIDDLE(u[8],u[10],imul_p0q2);
  DFT2_TWIDDLE(u[9],u[11],imul_p1q2);
  DFT2_TWIDDLE(u[12],u[14],imul_p0q2);
  DFT2_TWIDDLE(u[13],u[15],imul_p1q2);

  // 8x DFT2 and store (reverse binary permutation)
  // 1/N factor = 1/16 for scaling back
  const float fact = 0.0625f;

  y[i + stride*(l+0)]    = fact*(u[0]  + u[1]);
  y[i + stride*(l+p)]    = fact*(u[8]  + u[9]);
  y[i + stride*(l+2*p)]  = fact*(u[4]  + u[5]);
  y[i + stride*(l+3*p)]  = fact*(u[12] + u[13]);
  y[i + stride*(l+4*p)]  = fact*(u[2]  + u[3]);
  y[i + stride*(l+5*p)]  = fact*(u[10] + u[11]);
  y[i + stride*(l+6*p)]  = fact*(u[6]  + u[7]);
  y[i + stride*(l+7*p)]  = fact*(u[14] + u[15]);
  y[i + stride*(l+8*p)]  = fact*(u[0]  - u[1]);
  y[i + stride*(l+9*p)]  = fact*(u[8]  - u[9]);
  y[i + stride*(l+10*p)] = fact*(u[4]  - u[5]);
  y[i + stride*(l+11*p)] = fact*(u[12] - u[13]);
  y[i + stride*(l+12*p)] = fact*(u[2]  - u[3]);
  y[i + stride*(l+13*p)] = fact*(u[10] - u[11]);
  y[i + stride*(l+14*p)] = fact*(u[6]  - u[7]);
  y[i + stride*(l+15*p)] = fact*(u[14] - u[15]);
}

__kernel void radix2fft2dColumn(__global const complex_t * restrict input, __global complex_t * restrict output, int stage)
{
    const int size = get_global_size(1);
    const int i = get_global_id(0);
    const int j = get_global_id(1);

    const int inputind = j & (stage - 1);
    const int outputind = ((j - inputind) << 1) + inputind;
    const real_t alpha = -M_PI_F*(real_t)inputind/(real_t)stage;
    complex_t i1 = input[i + size*2*j];
    complex_t i2 = twiddle(input[i + size*2*(j+size)], alpha);
    const complex_t tmp = i1 - i2;
    i1 += i2;
    i2 = tmp;
    output[outputind*2*size + i] = i1;
    output[(outputind + stage)*2*size + i] = i2;
}

__kernel void radix2ifft2dRow(__global const complex_t * restrict input, __global complex_t * restrict output, int stage)
{
    const int size = get_global_size(0);
    const int i = get_global_id(0);
    const int j = get_global_id(1);

    const int inputind = i & (stage - 1);
    const int outputind = ((i - inputind) << 1) + inputind;
    const real_t alpha = M_PI_F*(real_t)inputind/(real_t)stage;
    complex_t i1 = input[i + size*2*j];
    complex_t i2 = twiddle(input[i + size + size*2*j], alpha);
    const complex_t tmp = i1 - i2;
    i1 += i2;
    i2 = tmp;
    output[outputind + size*2*j] = i1/2.0f;
    output[outputind + stage + size*2*j] = i2/2.0f;
}

__kernel void radix2ifft2dColumn(__global const complex_t * restrict input, __global complex_t * restrict output, int stage)
{
    const int size = get_global_size(1);
    const int i = get_global_id(0);
    const int j = get_global_id(1);

    const int inputind = j & (stage - 1);
    const int outputind = ((j - inputind) << 1) + inputind;
    const real_t alpha = M_PI_F*(real_t)inputind/(real_t)stage;
    complex_t i1 = input[i + size*2*j];
    complex_t i2 = twiddle(input[i + size*2*(j+size)], alpha);
    const complex_t tmp = i1 - i2;
    i1 += i2;
    i2 = tmp;
    output[outputind*2*size + i] = i1/2.0f;
    output[(outputind + stage)*2*size + i] = i2/2.0f;
}


__kernel void ifft_radix32_2drow(__global const float2 * restrict x,__global float2 * restrict y,int p)
{
  const int t = get_global_size(0); // number of threads
  const int i = get_global_id(0); // current thread
  const int j = get_global_id(1); // current thread
  const int k = i & (p-1); // index in input sequence, in 0..P-1
  const int row_offset = t * 32 * j;

  // Inputs indices are I+{0,..,31}*T
  x += i + row_offset;

  // Output indices are J+{0,..,31}*P, where
  // J is I with four 0 bits inserted at bit log2(P)
  y += ((i-k)<<5) + k + row_offset;

  // Load
  float2 u[32];
  for (int m=0;m<32;m++) u[m] = x[m*t];

  // Twiddle, twiddling factors are exp(_I*PI*{0,..,31}*K/16P)
  float alpha = M_PI_F*(float)k/(float)(16*p);
  for (int m=1;m<32;m++) u[m] = mul_1(exp_alpha_1(m*alpha),u[m]);

  // 16x in-place DFT2 and twiddle (1)
  DFT2_TWIDDLE(u[ 0],u[16], imul_p0q16);
  DFT2_TWIDDLE(u[ 1],u[17], imul_p1q16);
  DFT2_TWIDDLE(u[ 2],u[18], imul_p2q16);
  DFT2_TWIDDLE(u[ 3],u[19], imul_p3q16);
  DFT2_TWIDDLE(u[ 4],u[20], imul_p4q16);
  DFT2_TWIDDLE(u[ 5],u[21], imul_p5q16);
  DFT2_TWIDDLE(u[ 6],u[22], imul_p6q16);
  DFT2_TWIDDLE(u[ 7],u[23], imul_p7q16);
  DFT2_TWIDDLE(u[ 8],u[24], imul_p8q16);
  DFT2_TWIDDLE(u[ 9],u[25], imul_p9q16);
  DFT2_TWIDDLE(u[10],u[26],imul_p10q16);
  DFT2_TWIDDLE(u[11],u[27],imul_p11q16);
  DFT2_TWIDDLE(u[12],u[28],imul_p12q16);
  DFT2_TWIDDLE(u[13],u[29],imul_p13q16);
  DFT2_TWIDDLE(u[14],u[30],imul_p14q16);
  DFT2_TWIDDLE(u[15],u[31],imul_p15q16);

  // 16x in-place DFT2 and twiddle (2)
  DFT2_TWIDDLE(u[0],u[8],imul_p0q8);
  DFT2_TWIDDLE(u[1],u[9],imul_p1q8);
  DFT2_TWIDDLE(u[2],u[10],imul_p2q8);
  DFT2_TWIDDLE(u[3],u[11],imul_p3q8);
  DFT2_TWIDDLE(u[4],u[12],imul_p4q8);
  DFT2_TWIDDLE(u[5],u[13],imul_p5q8);
  DFT2_TWIDDLE(u[6],u[14],imul_p6q8);
  DFT2_TWIDDLE(u[7],u[15],imul_p7q8);
  DFT2_TWIDDLE(u[16],u[24],imul_p0q8);
  DFT2_TWIDDLE(u[17],u[25],imul_p1q8);
  DFT2_TWIDDLE(u[18],u[26],imul_p2q8);
  DFT2_TWIDDLE(u[19],u[27],imul_p3q8);
  DFT2_TWIDDLE(u[20],u[28],imul_p4q8);
  DFT2_TWIDDLE(u[21],u[29],imul_p5q8);
  DFT2_TWIDDLE(u[22],u[30],imul_p6q8);
  DFT2_TWIDDLE(u[23],u[31],imul_p7q8);

  // 16x in-place DFT2 and twiddle (3)
  DFT2_TWIDDLE(u[0],u[4],imul_p0q4);
  DFT2_TWIDDLE(u[1],u[5],imul_p1q4);
  DFT2_TWIDDLE(u[2],u[6],imul_p2q4);
  DFT2_TWIDDLE(u[3],u[7],imul_p3q4);
  DFT2_TWIDDLE(u[8],u[12],imul_p0q4);
  DFT2_TWIDDLE(u[9],u[13],imul_p1q4);
  DFT2_TWIDDLE(u[10],u[14],imul_p2q4);
  DFT2_TWIDDLE(u[11],u[15],imul_p3q4);
  DFT2_TWIDDLE(u[16],u[20],imul_p0q4);
  DFT2_TWIDDLE(u[17],u[21],imul_p1q4);
  DFT2_TWIDDLE(u[18],u[22],imul_p2q4);
  DFT2_TWIDDLE(u[19],u[23],imul_p3q4);
  DFT2_TWIDDLE(u[24],u[28],imul_p0q4);
  DFT2_TWIDDLE(u[25],u[29],imul_p1q4);
  DFT2_TWIDDLE(u[26],u[30],imul_p2q4);
  DFT2_TWIDDLE(u[27],u[31],imul_p3q4);

  // 16x in-place DFT2 and twiddle (3)
  DFT2_TWIDDLE(u[0],u[2],imul_p0q2);
  DFT2_TWIDDLE(u[1],u[3],imul_p1q2);
  DFT2_TWIDDLE(u[4],u[6],imul_p0q2);
  DFT2_TWIDDLE(u[5],u[7],imul_p1q2);
  DFT2_TWIDDLE(u[8],u[10],imul_p0q2);
  DFT2_TWIDDLE(u[9],u[11],imul_p1q2);
  DFT2_TWIDDLE(u[12],u[14],imul_p0q2);
  DFT2_TWIDDLE(u[13],u[15],imul_p1q2);
  DFT2_TWIDDLE(u[16],u[18],imul_p0q2);
  DFT2_TWIDDLE(u[17],u[19],imul_p1q2);
  DFT2_TWIDDLE(u[20],u[22],imul_p0q2);
  DFT2_TWIDDLE(u[21],u[23],imul_p1q2);
  DFT2_TWIDDLE(u[24],u[26],imul_p0q2);
  DFT2_TWIDDLE(u[25],u[27],imul_p1q2);
  DFT2_TWIDDLE(u[28],u[30],imul_p0q2);
  DFT2_TWIDDLE(u[29],u[31],imul_p1q2);
  const float fact = 0.031250f;
  // 16x DFT2 and store (reverse binary permutation)
  y[0]    = fact * (u[ 0] + u[ 1]) ;
  y[p]    = fact * (u[16] + u[17]) ;
  y[2*p]  = fact * (u[ 8] + u[ 9]) ;
  y[3*p]  = fact * (u[24] + u[25]) ;
  y[4*p]  = fact * (u[ 4] + u[ 5]) ;
  y[5*p]  = fact * (u[20] + u[21]) ;
  y[6*p]  = fact * (u[12] + u[13]) ;
  y[7*p]  = fact * (u[28] + u[29]) ;
  y[8*p]  = fact * (u[ 2] + u[ 3]) ;
  y[9*p]  = fact * (u[18] + u[19]) ;
  y[10*p] = fact * (u[10] + u[11]) ;
  y[11*p] = fact * (u[26] + u[27]) ;
  y[12*p] = fact * (u[ 6] + u[ 7]) ;
  y[13*p] = fact * (u[22] + u[23]) ;
  y[14*p] = fact * (u[14] + u[15]) ;
  y[15*p] = fact * (u[30] + u[31]) ;
  y[16*p] = fact * (u[ 0] - u[ 1]) ;
  y[17*p] = fact * (u[16] - u[17]) ;
  y[18*p] = fact * (u[ 8] - u[ 9]) ;
  y[19*p] = fact * (u[24] - u[25]) ;
  y[20*p] = fact * (u[ 4] - u[ 5]) ;
  y[21*p] = fact * (u[20] - u[21]) ;
  y[22*p] = fact * (u[12] - u[13]) ;
  y[23*p] = fact * (u[28] - u[29]) ;
  y[24*p] = fact * (u[ 2] - u[ 3]) ;
  y[25*p] = fact * (u[18] - u[19]) ;
  y[26*p] = fact * (u[10] - u[11]) ;
  y[27*p] = fact * (u[26] - u[27]) ;
  y[28*p] = fact * (u[ 6] - u[ 7]) ;
  y[29*p] = fact * (u[22] - u[23]) ;
  y[30*p] = fact * (u[14] - u[15]) ;
  y[31*p] = fact * (u[30] - u[31]) ;
}

__kernel void ifft_radix32_2dcolumn(__global const float2 * restrict x,__global float2 * restrict y,int p)
{
  const int t = get_global_size(1); // number of threads
  const int i = get_global_id(0); // current thread
  const int j = get_global_id(1); // current thread
  const int k = j & (p-1); // index in input sequence, in 0..P-1
  const int stride = t * 32;
  const int l = ((j-k)<<5) + k;

  // Load
  float2 u[32];
  for (int m=0;m<32;m++) u[m] = x[i + stride*(j+m*t)];

  // Twiddle, twiddling factors are exp(_I*PI*{0,..,31}*K/16P)
  float alpha = M_PI_F*(float)k/(float)(16*p);
  for (int m=1;m<32;m++) u[m] = mul_1(exp_alpha_1(m*alpha),u[m]);

  // 16x in-place DFT2 and twiddle (1)
  DFT2_TWIDDLE(u[ 0],u[16], imul_p0q16);
  DFT2_TWIDDLE(u[ 1],u[17], imul_p1q16);
  DFT2_TWIDDLE(u[ 2],u[18], imul_p2q16);
  DFT2_TWIDDLE(u[ 3],u[19], imul_p3q16);
  DFT2_TWIDDLE(u[ 4],u[20], imul_p4q16);
  DFT2_TWIDDLE(u[ 5],u[21], imul_p5q16);
  DFT2_TWIDDLE(u[ 6],u[22], imul_p6q16);
  DFT2_TWIDDLE(u[ 7],u[23], imul_p7q16);
  DFT2_TWIDDLE(u[ 8],u[24], imul_p8q16);
  DFT2_TWIDDLE(u[ 9],u[25], imul_p9q16);
  DFT2_TWIDDLE(u[10],u[26],imul_p10q16);
  DFT2_TWIDDLE(u[11],u[27],imul_p11q16);
  DFT2_TWIDDLE(u[12],u[28],imul_p12q16);
  DFT2_TWIDDLE(u[13],u[29],imul_p13q16);
  DFT2_TWIDDLE(u[14],u[30],imul_p14q16);
  DFT2_TWIDDLE(u[15],u[31],imul_p15q16);

  // 16x in-place DFT2 and twiddle (2)
  DFT2_TWIDDLE(u[0],u[8],imul_p0q8);
  DFT2_TWIDDLE(u[1],u[9],imul_p1q8);
  DFT2_TWIDDLE(u[2],u[10],imul_p2q8);
  DFT2_TWIDDLE(u[3],u[11],imul_p3q8);
  DFT2_TWIDDLE(u[4],u[12],imul_p4q8);
  DFT2_TWIDDLE(u[5],u[13],imul_p5q8);
  DFT2_TWIDDLE(u[6],u[14],imul_p6q8);
  DFT2_TWIDDLE(u[7],u[15],imul_p7q8);
  DFT2_TWIDDLE(u[16],u[24],imul_p0q8);
  DFT2_TWIDDLE(u[17],u[25],imul_p1q8);
  DFT2_TWIDDLE(u[18],u[26],imul_p2q8);
  DFT2_TWIDDLE(u[19],u[27],imul_p3q8);
  DFT2_TWIDDLE(u[20],u[28],imul_p4q8);
  DFT2_TWIDDLE(u[21],u[29],imul_p5q8);
  DFT2_TWIDDLE(u[22],u[30],imul_p6q8);
  DFT2_TWIDDLE(u[23],u[31],imul_p7q8);

  // 16x in-place DFT2 and twiddle (3)
  DFT2_TWIDDLE(u[0],u[4],imul_p0q4);
  DFT2_TWIDDLE(u[1],u[5],imul_p1q4);
  DFT2_TWIDDLE(u[2],u[6],imul_p2q4);
  DFT2_TWIDDLE(u[3],u[7],imul_p3q4);
  DFT2_TWIDDLE(u[8],u[12],imul_p0q4);
  DFT2_TWIDDLE(u[9],u[13],imul_p1q4);
  DFT2_TWIDDLE(u[10],u[14],imul_p2q4);
  DFT2_TWIDDLE(u[11],u[15],imul_p3q4);
  DFT2_TWIDDLE(u[16],u[20],imul_p0q4);
  DFT2_TWIDDLE(u[17],u[21],imul_p1q4);
  DFT2_TWIDDLE(u[18],u[22],imul_p2q4);
  DFT2_TWIDDLE(u[19],u[23],imul_p3q4);
  DFT2_TWIDDLE(u[24],u[28],imul_p0q4);
  DFT2_TWIDDLE(u[25],u[29],imul_p1q4);
  DFT2_TWIDDLE(u[26],u[30],imul_p2q4);
  DFT2_TWIDDLE(u[27],u[31],imul_p3q4);

  // 16x in-place DFT2 and twiddle (3)
  DFT2_TWIDDLE(u[0],u[2],imul_p0q2);
  DFT2_TWIDDLE(u[1],u[3],imul_p1q2);
  DFT2_TWIDDLE(u[4],u[6],imul_p0q2);
  DFT2_TWIDDLE(u[5],u[7],imul_p1q2);
  DFT2_TWIDDLE(u[8],u[10],imul_p0q2);
  DFT2_TWIDDLE(u[9],u[11],imul_p1q2);
  DFT2_TWIDDLE(u[12],u[14],imul_p0q2);
  DFT2_TWIDDLE(u[13],u[15],imul_p1q2);
  DFT2_TWIDDLE(u[16],u[18],imul_p0q2);
  DFT2_TWIDDLE(u[17],u[19],imul_p1q2);
  DFT2_TWIDDLE(u[20],u[22],imul_p0q2);
  DFT2_TWIDDLE(u[21],u[23],imul_p1q2);
  DFT2_TWIDDLE(u[24],u[26],imul_p0q2);
  DFT2_TWIDDLE(u[25],u[27],imul_p1q2);
  DFT2_TWIDDLE(u[28],u[30],imul_p0q2);
  DFT2_TWIDDLE(u[29],u[31],imul_p1q2);

  const float fact = 0.031250f;
  // 16x DFT2 and store (reverse binary permutation)
  y[i + stride*(l+0)]    = fact * (u[ 0] + u[ 1]) ;
  y[i + stride*(l+p)]    = fact * (u[16] + u[17]) ;
  y[i + stride*(l+2*p)]  = fact * (u[ 8] + u[ 9]) ;
  y[i + stride*(l+3*p)]  = fact * (u[24] + u[25]) ;
  y[i + stride*(l+4*p)]  = fact * (u[ 4] + u[ 5]) ;
  y[i + stride*(l+5*p)]  = fact * (u[20] + u[21]) ;
  y[i + stride*(l+6*p)]  = fact * (u[12] + u[13]) ;
  y[i + stride*(l+7*p)]  = fact * (u[28] + u[29]) ;
  y[i + stride*(l+8*p)]  = fact * (u[ 2] + u[ 3]) ;
  y[i + stride*(l+9*p)]  = fact * (u[18] + u[19]) ;
  y[i + stride*(l+10*p)] = fact * (u[10] + u[11]) ;
  y[i + stride*(l+11*p)] = fact * (u[26] + u[27]) ;
  y[i + stride*(l+12*p)] = fact * (u[ 6] + u[ 7]) ;
  y[i + stride*(l+13*p)] = fact * (u[22] + u[23]) ;
  y[i + stride*(l+14*p)] = fact * (u[14] + u[15]) ;
  y[i + stride*(l+15*p)] = fact * (u[30] + u[31]) ;
  y[i + stride*(l+16*p)] = fact * (u[ 0] - u[ 1]) ;
  y[i + stride*(l+17*p)] = fact * (u[16] - u[17]) ;
  y[i + stride*(l+18*p)] = fact * (u[ 8] - u[ 9]) ;
  y[i + stride*(l+19*p)] = fact * (u[24] - u[25]) ;
  y[i + stride*(l+20*p)] = fact * (u[ 4] - u[ 5]) ;
  y[i + stride*(l+21*p)] = fact * (u[20] - u[21]) ;
  y[i + stride*(l+22*p)] = fact * (u[12] - u[13]) ;
  y[i + stride*(l+23*p)] = fact * (u[28] - u[29]) ;
  y[i + stride*(l+24*p)] = fact * (u[ 2] - u[ 3]) ;
  y[i + stride*(l+25*p)] = fact * (u[18] - u[19]) ;
  y[i + stride*(l+26*p)] = fact * (u[10] - u[11]) ;
  y[i + stride*(l+27*p)] = fact * (u[26] - u[27]) ;
  y[i + stride*(l+28*p)] = fact * (u[ 6] - u[ 7]) ;
  y[i + stride*(l+29*p)] = fact * (u[22] - u[23]) ;
  y[i + stride*(l+30*p)] = fact * (u[14] - u[15]) ;
  y[i + stride*(l+31*p)] = fact * (u[30] - u[31]) ;
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
