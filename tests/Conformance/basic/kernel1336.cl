// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(const __global uint8 *src, __global uint8 *dst,
                      __local uint8 *localBuffer, int copiesPerWorkgroup,
                      int copiesPerWorkItem) {
  int i;
  for (i = 0; i < copiesPerWorkItem; i++)
    localBuffer[get_local_id(0) * copiesPerWorkItem + i] = (uint8)(uint)0;
  barrier(CLK_LOCAL_MEM_FENCE);
  event_t event;
  event = async_work_group_copy(
      (__local uint8 *)localBuffer,
      (__global const uint8 *)(src + copiesPerWorkgroup * get_group_id(0)),
      (size_t)copiesPerWorkgroup, 0);
  wait_group_events(1, &event);
  for (i = 0; i < copiesPerWorkItem; i++)
    dst[get_global_id(0) * copiesPerWorkItem + i] =
        localBuffer[get_local_id(0) * copiesPerWorkItem + i];
}
