// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(const __global uchar16 *src, __global uchar16 *dst,
                      __local uchar16 *localBuffer, int copiesPerWorkgroup,
                      int copiesPerWorkItem, int stride) {
  int i;
  for (i = 0; i < copiesPerWorkItem; i++)
    localBuffer[get_local_id(0) * copiesPerWorkItem + i] = (uchar16)(uchar)0;
  barrier(CLK_LOCAL_MEM_FENCE);
  for (i = 0; i < copiesPerWorkItem; i++)
    localBuffer[get_local_id(0) * copiesPerWorkItem + i] =
        src[get_global_id(0) * copiesPerWorkItem * stride + i * stride];
  barrier(CLK_LOCAL_MEM_FENCE);
  event_t event;
  event = async_work_group_strided_copy(
      (__global uchar16 *)(dst + copiesPerWorkgroup * stride * get_group_id(0)),
      (__local const uchar16 *)localBuffer, (size_t)copiesPerWorkgroup,
      (size_t)stride, 0);
  wait_group_events(1, &event);
}
