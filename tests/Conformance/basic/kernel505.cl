// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
kernel void loop_constant_kernel(global float *out, constant float *i_pos,
                                 int num) {
  int tid = get_global_id(0);
  float sum = 0;
  for (int i = 0; i < num; i++) {
    float pos = i_pos[i * 3];
    sum += pos;
  }
  out[tid] = sum;
}
