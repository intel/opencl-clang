// Copyright (C) 2013-2015 Altera Corporation, San Jose, California, USA. All rights reserved.
// Permission is hereby granted, free of charge, to any person obtaining a copy of this
// software and associated documentation files (the "Software"), to deal in the Software
// without restriction, including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to
// whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
// This agreement shall be governed in all respects by the laws of the State of California and
// by the laws of the United States of America.

#define FILTER_LENGTH 128

/******************************************************************************

This kernel implements the complex FIR filter with 128-taps.

******************************************************************************/

__attribute__((task))
__kernel void tdfir (
        __global float *restrict dataPtr, __global float *restrict filterPtr,
        __global float *restrict resultPtr, const int totalInputLength,
        const int paddedSingleInputLength
        )
{
  float ai_a0[FILTER_LENGTH];
  float ai_b0[FILTER_LENGTH];

  float coef_real[FILTER_LENGTH];
  float coef_imag[FILTER_LENGTH];

  int ilen, k;

#pragma unroll
  for(ilen = 0; ilen < FILTER_LENGTH; ilen++) {
    ai_a0[ilen] = 0.0f;
    ai_b0[ilen] = 0.0f;
  }

  uchar  load_filter = 1;
  ushort load_filter_index = 0;
  uchar  num_coefs_loaded = 0;
  ushort ifilter = 0;

  for(ilen = 0; ilen < totalInputLength; ilen++)
  {
    float firReal = 0.0f;
    float firImag = 0.0f;
    int index = ilen >> 1;

    float data1,data2;

    #pragma unroll
    for (k=0; k < FILTER_LENGTH-1; k++)
    {
      ai_a0[k] = ai_a0[k+1];
      ai_b0[k] = ai_b0[k+1];
    }

    // Shift in 1 complex data point to process
    ai_a0[FILTER_LENGTH-1] = dataPtr[2*ilen];
    ai_b0[FILTER_LENGTH-1] = dataPtr[2*ilen+1];

    // Also shift in the filter coefficients for every set of data to process
    // Shift the cofficients in 8 complex points every clock cycle
    // It will take 16 clock cycles to shift all 128 coefficients in.
    // Thus, we need to pad the incoming data with 16 complex points of 0
    // at the beginning of every new dataset to ensure data is aligned.
    if (load_filter) {
       #pragma unroll
       for (k=0; k < FILTER_LENGTH-1; k+=8)
       {
          coef_real[k] = coef_real[k+8];
          coef_imag[k] = coef_imag[k+8];
          coef_real[k+1] = coef_real[k+9];
          coef_imag[k+1] = coef_imag[k+9];
          coef_real[k+2] = coef_real[k+10];
          coef_imag[k+2] = coef_imag[k+10];
          coef_real[k+3] = coef_real[k+11];
          coef_imag[k+3] = coef_imag[k+11];
          coef_real[k+4] = coef_real[k+12];
          coef_imag[k+4] = coef_imag[k+12];
          coef_real[k+5] = coef_real[k+13];
          coef_imag[k+5] = coef_imag[k+13];
          coef_real[k+6] = coef_real[k+14];
          coef_imag[k+6] = coef_imag[k+14];
          coef_real[k+7] = coef_real[k+15];
          coef_imag[k+7] = coef_imag[k+15];
       }

       coef_real[FILTER_LENGTH-8] = filterPtr[16*load_filter_index];
       coef_imag[FILTER_LENGTH-8] = filterPtr[16*load_filter_index+1];
       coef_real[FILTER_LENGTH-7] = filterPtr[16*load_filter_index+2];
       coef_imag[FILTER_LENGTH-7] = filterPtr[16*load_filter_index+3];
       coef_real[FILTER_LENGTH-6] = filterPtr[16*load_filter_index+4];
       coef_imag[FILTER_LENGTH-6] = filterPtr[16*load_filter_index+5];
       coef_real[FILTER_LENGTH-5] = filterPtr[16*load_filter_index+6];
       coef_imag[FILTER_LENGTH-5] = filterPtr[16*load_filter_index+7];
       coef_real[FILTER_LENGTH-4] = filterPtr[16*load_filter_index+8];
       coef_imag[FILTER_LENGTH-4] = filterPtr[16*load_filter_index+9];
       coef_real[FILTER_LENGTH-3] = filterPtr[16*load_filter_index+10];
       coef_imag[FILTER_LENGTH-3] = filterPtr[16*load_filter_index+11];
       coef_real[FILTER_LENGTH-2] = filterPtr[16*load_filter_index+12];
       coef_imag[FILTER_LENGTH-2] = filterPtr[16*load_filter_index+13];
       coef_real[FILTER_LENGTH-1] = filterPtr[16*load_filter_index+14];
       coef_imag[FILTER_LENGTH-1] = filterPtr[16*load_filter_index+15];
       ++load_filter_index;

       if (++num_coefs_loaded == (FILTER_LENGTH>>3)) { load_filter = 0; num_coefs_loaded = 0; }
    }

#pragma unroll
    for (k=FILTER_LENGTH-1; k >=0; k--)
    {
      // This is the core computation of the FIR filter
      firReal += ai_a0[k] * coef_real[FILTER_LENGTH-1-k]  - ai_b0[k] * coef_imag[FILTER_LENGTH-1-k];
      firImag += ai_a0[k] * coef_imag[FILTER_LENGTH-1-k]  + ai_b0[k] * coef_real[FILTER_LENGTH-1-k];
    }

    // writing back the computational result
    resultPtr[2*ilen] = firReal;
    resultPtr[2*ilen+1] = firImag;

    // The ifilter variable is a counter that counts up to the number of data inputs
    // per filter to process.  When it reaches paddedSingleInputLength, we will know
    // that it is time to load in new filter coefficients for the next batch of data,
    // and reset the counter.
    if (ifilter == paddedSingleInputLength)
    {
       load_filter = 1;
    }
    if (ifilter == paddedSingleInputLength)
    {
      ifilter = 0;
    }
    else
      ifilter++;
  }
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
