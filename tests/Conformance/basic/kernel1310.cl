// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(const __global uchar3 *src, __global uchar3 *dst,
                      __local uchar3 *localBuffer, int copiesPerWorkgroup,
                      int copiesPerWorkItem) {
  int i;
  for (i = 0; i < copiesPerWorkItem; i++)
    localBuffer[get_local_id(0) * copiesPerWorkItem + i] = (uchar3)(uchar)0;
  barrier(CLK_LOCAL_MEM_FENCE);
  event_t event;
  event = async_work_group_copy(
      (__local uchar3 *)localBuffer,
      (__global const uchar3 *)(src + copiesPerWorkgroup * get_group_id(0)),
      (size_t)copiesPerWorkgroup, 0);
  wait_group_events(1, &event);
  for (i = 0; i < copiesPerWorkItem; i++)
    dst[get_global_id(0) * copiesPerWorkItem + i] =
        localBuffer[get_local_id(0) * copiesPerWorkItem + i];
}
