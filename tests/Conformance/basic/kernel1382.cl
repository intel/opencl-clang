// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(const __global ushort3 *src, __global ushort3 *dst,
                      __local ushort3 *localBuffer, int copiesPerWorkgroup,
                      int copiesPerWorkItem) {
  int i;
  for (i = 0; i < copiesPerWorkItem; i++)
    localBuffer[get_local_id(0) * copiesPerWorkItem + i] = (ushort3)(ushort)0;
  barrier(CLK_LOCAL_MEM_FENCE);
  for (i = 0; i < copiesPerWorkItem; i++)
    localBuffer[get_local_id(0) * copiesPerWorkItem + i] =
        src[get_global_id(0) * copiesPerWorkItem + i];
  barrier(CLK_LOCAL_MEM_FENCE);
  event_t event;
  event = async_work_group_copy(
      (__global ushort3 *)(dst + copiesPerWorkgroup * get_group_id(0)),
      (__local const ushort3 *)localBuffer, (size_t)copiesPerWorkgroup, 0);
  wait_group_events(1, &event);
}
