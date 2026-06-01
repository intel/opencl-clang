// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(const __global uint3 *src, __global uint3 *dst,
                      __local uint3 *localBuffer, int copiesPerWorkgroup,
                      int copiesPerWorkItem) {
  // Ignore this: uint3uintuint3
  int i;
  prefetch((const __global uint3 *)(src + copiesPerWorkItem * get_global_id(0)),
           copiesPerWorkItem);
  for (i = 0; i < copiesPerWorkItem; i++)
    dst[get_global_id(0) * copiesPerWorkItem + i] =
        src[get_global_id(0) * copiesPerWorkItem + i];
}
