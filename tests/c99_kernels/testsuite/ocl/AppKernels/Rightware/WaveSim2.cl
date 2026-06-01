/**
* OpenCL Fast Fourier Transform implementation.
*
* Copyright 2011 by Rightware. All rights reserved.
*/


/** Passed from the compiler depending on platform */
#define real_t float
#define complex_t float2


/** Complex multiplication */
inline complex_t mulcomp(complex_t a,complex_t b)
{
  return (complex_t)(a.x * b.x - a.y * b.y, a.y * b.x + a.x * b.y);
}

/** Twiddle .*/
inline complex_t twiddle(complex_t x, real_t alpha)
{
    real_t rl, img;
    img = native_sin(alpha);
    rl = native_cos(alpha);
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


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
