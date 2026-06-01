// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(const __global long3 *src, __global long3 *dst,
                      __local long3 *localBuffer, int copiesPerWorkgroup,
                      int copiesPerWorkItem) {
  // Ignore this: long3longlong3
  int i;
  prefetch((const __global long3 *)(src + copiesPerWorkItem * get_global_id(0)),
           copiesPerWorkItem);
  for (i = 0; i < copiesPerWorkItem; i++)
    dst[get_global_id(0) * copiesPerWorkItem + i] =
        src[get_global_id(0) * copiesPerWorkItem + i];
}
