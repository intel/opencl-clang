// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(const __global double2 *src, __global double2 *dst,
                      __local double2 *localBuffer, int copiesPerWorkgroup,
                      int copiesPerWorkItem) {
  int i;
  for (i = 0; i < copiesPerWorkItem; i++)
    localBuffer[get_local_id(0) * copiesPerWorkItem + i] = (double2)(double)0;
  barrier(CLK_LOCAL_MEM_FENCE);
  event_t event;
  event = async_work_group_copy(
      (__local double2 *)localBuffer,
      (__global const double2 *)(src + copiesPerWorkgroup * get_group_id(0)),
      (size_t)copiesPerWorkgroup, 0);
  wait_group_events(1, &event);
  for (i = 0; i < copiesPerWorkItem; i++)
    dst[get_global_id(0) * copiesPerWorkItem + i] =
        localBuffer[get_local_id(0) * copiesPerWorkItem + i];
}
