/**
 * Color to grayscale conversion in OpenCL C.
 *
 * @param {uchar4*} src source image (RGBA)
 * @param {uchar4*} dst destination image (RGBA)
 * @param {uint} width source and destination image width in pixels
 * @param {uint} height source and destination image height in pixels
 *
 * @author Tomi Aarnio, Nokia Research Tampere, 2011
 */

__kernel void clDesaturate(__global const uchar4* src,
                           __global uchar4* dst,
                           uint width,
                           uint height)
{
  int x = get_global_id(0);
  int y = get_global_id(1);
  if (x >= width || y >= height) return;

  int i = y * width + x;

  uchar4 color = src[i];
  uchar lum = (uchar)(0.30f * color.x + 0.59f * color.y + 0.11f * color.z);
  dst[i] = (uchar4)(lum, lum, lum, 255);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
