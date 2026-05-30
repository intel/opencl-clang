// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global float *p, __global half *f,
                   uint extra_last_thread) {
  __local ushort data[3 * (128 + 1)];
  size_t i = get_global_id(0);
  size_t lid = get_local_id(0);
  size_t last_i = get_global_size(0) - 1;
  size_t adjust = 0;
  size_t lsize = get_local_size(0);
  event_t async_event;
  if (last_i == i && extra_last_thread != 0) {
    adjust = 3 - extra_last_thread;
  }
  vstore_half3_rte(vload3(i, p - adjust), lid, (__local half *)(&data[0]));
  barrier(CLK_LOCAL_MEM_FENCE);
  async_event = async_work_group_copy((__global ushort *)(f + 3 * (i - lid)),
                                      (__local ushort *)(&data[adjust]),
                                      lsize * 3 - adjust, 0);
  wait_group_events(1, &async_event);
}
