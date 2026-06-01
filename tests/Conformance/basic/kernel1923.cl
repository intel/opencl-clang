// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(const __global ushort4 *src, __global ushort4 *dst,
                      __local ushort4 *localBuffer, int copiesPerWorkgroup,
                      int copiesPerWorkItem) {
  // Ignore this: ushort4ushortushort4
  int i;
  prefetch(
      (const __global ushort4 *)(src + copiesPerWorkItem * get_global_id(0)),
      copiesPerWorkItem);
  for (i = 0; i < copiesPerWorkItem; i++)
    dst[get_global_id(0) * copiesPerWorkItem + i] =
        src[get_global_id(0) * copiesPerWorkItem + i];
}
