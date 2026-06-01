// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void compute_sum(__global int *a, int n, __global int *tmp_sum,
                          __global int *sum) {
  int tid = get_local_id(0);
  int lsize = get_local_size(0);
  int i;

  tmp_sum[tid] = 0;
  for (i = tid; i < n; i += lsize)
    tmp_sum[tid] += a[i];

  // updated to work for any workgroup size
  for (i = hadd(lsize, 1); lsize > 1; i = hadd(i, 1)) {
    barrier(CLK_GLOBAL_MEM_FENCE);
    if (tid + i < lsize)
      tmp_sum[tid] += tmp_sum[tid + i];
    lsize = i;
  }

  // no barrier is required here because last person to write to tmp_sum[0] was
  // tid 0
  if (tid == 0)
    *sum = tmp_sum[0];
}
