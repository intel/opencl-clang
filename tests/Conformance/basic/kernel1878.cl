// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(const __global double *src, __global double *dst,
                      __local double *localBuffer, int copiesPerWorkgroup,
                      int copiesPerWorkItem, int stride) {
  int i;
  for (i = 0; i < copiesPerWorkItem; i++)
    localBuffer[get_local_id(0) * copiesPerWorkItem + i] = (double)(double)0;
  barrier(CLK_LOCAL_MEM_FENCE);
  for (i = 0; i < copiesPerWorkItem; i++)
    localBuffer[get_local_id(0) * copiesPerWorkItem + i] =
        src[get_global_id(0) * copiesPerWorkItem * stride + i * stride];
  barrier(CLK_LOCAL_MEM_FENCE);
  event_t event;
  event = async_work_group_strided_copy(
      (__global double *)(dst + copiesPerWorkgroup * stride * get_group_id(0)),
      (__local const double *)localBuffer, (size_t)copiesPerWorkgroup,
      (size_t)stride, 0);
  wait_group_events(1, &event);
}
