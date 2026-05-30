/**
* OpenCL FFT Wave simulation implementation.
* This 'simulator' supplies the convolution kernel to be used with fft code from fft.cl
* Copyright 2011 by Rightware. All rights reserved.
*/

#define real_t float
#define complex_t float2

/** Size of data of single vertex. */
#define VERTEX_DATA_SIZE 8


inline complex_t mulcomp(complex_t a,complex_t b)
{
  return (complex_t)(a.x * b.x - a.y * b.y, a.y * b.x + a.x * b.y);
}

inline complex_t complex_expi(real_t alpha)
{
    real_t rel, img;
    img = sincos(alpha, &rel);
    return (complex_t)(rel, img);
}

/* Takes fourier transform of a 2 dimensional wave field as an input and outputs the field multiplied by the dispersion kernel. */
__kernel void deepWaterDispersion(__global const complex_t * restrict input, __global complex_t * restrict output, real_t t)
{
    const int i = get_global_id(0);
    const int j = get_global_id(1);
    int x = i;
    int y = j;
    int w = get_global_size(0);
    int h = get_global_size(1);
    if(x > w/2) x = x - w;
    if(y > h/2) y = y - h;
    const real_t k_len = fast_length((complex_t)((real_t)x, (real_t) y));
    const real_t mulfactor = sqrt((9.81f/2*M_PI_F)*k_len)*t;
    /* The division term is derived with Stetson-Harrison method to approximate the frequency dependent attenuation determined by Kramers-Krönig relationship*/
    output[i + j*w] = mulcomp(input[i + j*w], complex_expi(mulfactor))/(exp(mulfactor/80.0f));
}

/* Adds a drop to the frequency domain heightfield. */
__kernel void addDrop(__global complex_t * restrict field, real_t dropx, real_t dropy)
{
    const int i = get_global_id(0);
    const int j = get_global_id(1);
    int x = i;
    int y = j;
    int w = get_global_size(0);
    const real_t wf = (real_t) w;
    int h = get_global_size(1);

    /* Transforms the indexes into frequency coordinates as in shifting the DC level into center of the array */
    if(x > w/2) x = x - w;
    if(y > h/2) y = y - h;

    const real_t mulfactor = -2.0f * M_PI_F * (dropx * (real_t) x + (real_t) y * dropy)/wf;
    const real_t sigma = 5.0f;
    const complex_t k = (complex_t)((real_t) x, (real_t) y);
    field[i + j*w] += complex_expi(mulfactor)*exp(-dot(k, k)/((wf/sigma)*(wf/sigma)));
}

/* Sum contents of the second into the first */
__kernel void addFields(__global complex_t * restrict first, __global complex_t * restrict second)
{
    const int i = get_global_id(0);
    const int j = get_global_id(1);
    const int w = get_global_size(0);
    first[i + j*w] += second[i + j*w];
}

/* TODO: Make a optimized version which is only called for the relevant region when more drivers become compliant with the global offset */
__kernel void zeroBoundaries(__global complex_t * restrict field, int boundarySize)
{
    const int i = get_global_id(0);
    const int j = get_global_id(1);
    const int w = get_global_size(0);
    if(i > boundarySize || j > boundarySize) field[i + j*w] = (complex_t)(0.0f, 0.0f);
}


/* Generate the heightfield from the complex input. Called simply with 2 dimensional global size equivalent to amount of points */
__kernel void generateHeightFieldVbo(__global const complex_t * restrict input, __global float* restrict output, int inputStride)
{
    const int id0 = get_global_id(0);
    const int id1 = get_global_id(1);
    const int globalSize0 = get_global_size(0);
    const int globalSize1 = get_global_size(1);
    const complex_t in = input[id0 + id1 * inputStride];
    float4 outputValue = (float4)((float)id0/(float)globalSize0, (float)in.x, (float)id1/(float)globalSize1, 0.0f);
    int offset = (id0 + id1 * globalSize0) * VERTEX_DATA_SIZE;
    output[offset + 0] = outputValue.x - 0.5f;
    output[offset + 1] = outputValue.y;
    output[offset + 2] = outputValue.z - 0.5f;
    output[offset + 3] = 0.0f;
}

__kernel void resetFaceNormals(__global float4* faceNormals)
{
    unsigned int i = get_global_id(0);
    faceNormals[i] = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
}

__kernel void calculateFaceNormals(__global const unsigned int* restrict indexes, __global float4* positions, __global float4* faceNormals)
{
    unsigned int i = get_global_id(0);
    unsigned int offset = i * 3;

    unsigned int index1 = indexes[offset + 0] * 2;
    unsigned int index2 = indexes[offset + 1] * 2;
    unsigned int index3 = indexes[offset + 2] * 2;

    float4 p1 = positions[index1];
    float4 p2 = positions[index2];
    float4 p3 = positions[index3];

    float4 v1 = p3 - p1;
    float4 v2 = p2 - p1;
    float4 d = cross(v1, v2);

    faceNormals[i] = normalize(d);
}

__kernel void averageFaceNormals(__global float* vbo, __global float4* faceNormals, __global const int* restrict faceIndexes)
{
    unsigned int n;
    unsigned int i = get_global_id(0);
    unsigned int offset = i * 8;
    float4 normal = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

    for(n = 0; n < 8; ++n)
    {
        unsigned int faceIndex = faceIndexes[offset + n];
        if(faceIndex != -1)
        {
            normal += faceNormals[faceIndex];
        }
    }

    normal = normalize(normal);

    /* Set the position to VBO. */
    {
        unsigned int vboOffset = i * VERTEX_DATA_SIZE;
        vbo[vboOffset + 4] = normal.x;
        vbo[vboOffset + 5] = normal.y;
        vbo[vboOffset + 6] = normal.z;
        vbo[vboOffset + 7] = 0.0f;
    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
