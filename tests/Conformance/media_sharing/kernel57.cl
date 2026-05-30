// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
kernel void detect_round(global float4 *in, write_only image2d_t out) {
  write_imagef(out, (int2)(get_global_id(0), 0), in[get_global_id(0)]);
}
