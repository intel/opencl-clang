// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(const __global long2 *src, __global long2 *dst,
                      __local long2 *localBuffer, int copiesPerWorkgroup,
                      int copiesPerWorkItem, int stride) {
  int i;
  for (i = 0; i < copiesPerWorkItem; i++)
    localBuffer[get_local_id(0) * copiesPerWorkItem + i] = (long2)(long)0;
  barrier(CLK_LOCAL_MEM_FENCE);
  event_t event;
  event = async_work_group_strided_copy(
      (__local long2 *)localBuffer,
      (__global const long2 *)(src +
                               copiesPerWorkgroup * stride * get_group_id(0)),
      (size_t)copiesPerWorkgroup, (size_t)stride, 0);
  wait_group_events(1, &event);
  for (i = 0; i < copiesPerWorkItem; i++)
    dst[get_global_id(0) * copiesPerWorkItem * stride + i * stride] =
        localBuffer[get_local_id(0) * copiesPerWorkItem + i];
}
