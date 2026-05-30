// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
kernel void test(global int *defines) {
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
#ifdef cl_khr_fp64
  defines[0] = 1;
#else
  defines[0] = 0;
#endif
#pragma OPENCL EXTENSION cl_khr_fp64 : disable

#ifdef cl_khr_icd
  defines[1] = 1;
#else
  defines[1] = 0;
#endif
#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
#ifdef cl_khr_global_int32_base_atomics
  defines[2] = 1;
#else
  defines[2] = 0;
#endif
#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : disable

#pragma OPENCL EXTENSION cl_khr_global_int32_extended_atomics : enable
#ifdef cl_khr_global_int32_extended_atomics
  defines[3] = 1;
#else
  defines[3] = 0;
#endif
#pragma OPENCL EXTENSION cl_khr_global_int32_extended_atomics : disable

#pragma OPENCL EXTENSION cl_khr_local_int32_base_atomics : enable
#ifdef cl_khr_local_int32_base_atomics
  defines[4] = 1;
#else
  defines[4] = 0;
#endif
#pragma OPENCL EXTENSION cl_khr_local_int32_base_atomics : disable

#pragma OPENCL EXTENSION cl_khr_local_int32_extended_atomics : enable
#ifdef cl_khr_local_int32_extended_atomics
  defines[5] = 1;
#else
  defines[5] = 0;
#endif
#pragma OPENCL EXTENSION cl_khr_local_int32_extended_atomics : disable

#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : enable
#ifdef cl_khr_byte_addressable_store
  defines[6] = 1;
#else
  defines[6] = 0;
#endif
#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : disable

#ifdef cl_intel_printf
  defines[7] = 1;
#else
  defines[7] = 0;
#endif
#ifdef cl_ext_device_fission
  defines[8] = 1;
#else
  defines[8] = 0;
#endif
#ifdef cl_intel_exec_by_local_thread
  defines[9] = 1;
#else
  defines[9] = 0;
#endif
#ifdef cl_khr_gl_sharing
  defines[10] = 1;
#else
  defines[10] = 0;
#endif
#ifdef cl_intel_dx9_media_sharing
  defines[11] = 1;
#else
  defines[11] = 0;
#endif
#ifdef cl_khr_dx9_media_sharing
  defines[12] = 1;
#else
  defines[12] = 0;
#endif
#ifdef cl_khr_d3d11_sharing
  defines[13] = 1;
#else
  defines[13] = 0;
#endif
#ifdef cl_intel_printf
  defines[14] = 1;
#else
  defines[14] = 0;
#endif
#ifdef cl_ext_device_fission
  defines[15] = 1;
#else
  defines[15] = 0;
#endif
#ifdef cl_intel_exec_by_local_thread
  defines[16] = 1;
#else
  defines[16] = 0;
#endif
#ifdef cl_intel_dx9_media_sharing
  defines[17] = 1;
#else
  defines[17] = 0;
#endif
}
