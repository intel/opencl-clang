// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(const __global float2 *src, __global float2 *dst,
                      __local float2 *localBuffer, int copiesPerWorkgroup,
                      int copiesPerWorkItem) {
  // Ignore this: float2floatfloat2
  int i;
  prefetch(
      (const __global float2 *)(src + copiesPerWorkItem * get_global_id(0)),
      copiesPerWorkItem);
  for (i = 0; i < copiesPerWorkItem; i++)
    dst[get_global_id(0) * copiesPerWorkItem + i] =
        src[get_global_id(0) * copiesPerWorkItem + i];
}
