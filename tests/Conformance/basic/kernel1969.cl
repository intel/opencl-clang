// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#line 2 "D:\\Work\\trunk\\head\\src\\tests\\conform1.2\\src\\test_conformance\\basic\\test_preprocessors.cpp"
__kernel void test(__global int *results, __global char *outFileString,
                   __global char *outRoundingString) {
#ifdef __IMAGE_SUPPORT__
  results[0] = __IMAGE_SUPPORT__;
#else
  results[0] = 0xf00baa;
#endif
#ifdef __ENDIAN_LITTLE__
  results[1] = __ENDIAN_LITTLE__;
#else
  results[1] = 0xf00baa;
#endif
#ifdef __OPENCL_VERSION__
  results[2] = __OPENCL_VERSION__;
#else
  results[2] = 0xf00baa;
#endif
#ifdef __OPENCL_C_VERSION__
  results[3] = __OPENCL_C_VERSION__;
#else
  results[3] = 0xf00baa;
#endif
#ifdef __LINE__
  results[4] = __LINE__;
#else
  results[4] = 0xf00baa;
#endif
#ifdef __kernel_exec
  results[6] = 1;
#else
  results[6] = 0xf00baa;
#endif
#ifdef __FILE__
  int i;
  constant char *f = "" __FILE__;
  for (i = 0; f[i] != 0 && i < 512; i++)
    outFileString[i] = f[i];
  outFileString[i] = 0;
#else
  outFileString[0] = 0;
#endif
}
