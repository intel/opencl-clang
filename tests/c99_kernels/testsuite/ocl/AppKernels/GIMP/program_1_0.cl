/* This is almost a copy-paste from babl/base conversion functions in RGBA space */

/* Alpha threshold used in the reference implementation for
 * un-pre-multiplication of color data:
 *
 * 0.01 / (2^16 - 1)
 */
#define BABL_ALPHA_THRESHOLD 0.0f

float linear_to_gamma_2_2 (float value)
{
  if (value > 0.0030402477f)
    return 1.055f * native_powr (value, (1.0f/2.4f)) - 0.055f;
  return 12.92f * value;
}

float gamma_2_2_to_linear (float value)
{
  if (value > 0.03928f)
    return native_powr ((value + 0.055f) / 1.055f, 2.4f);
  return value / 12.92f;
}
__kernel void rgbau8_to_rgbaf (__global const uchar4 * in,
                               __global       float4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = convert_float4(in[gid]) / 255.0f;
  float4 out_v = in_v;
  out[gid] = out_v;
}
__kernel void rgbaf_to_rgbau8 (__global const float4 * in,
                               __global       uchar4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 out_v = in_v;
  out[gid] = convert_uchar4_sat_rte(255.0f * out_v);
}
__kernel void rgbaf_to_ragabaf (__global const float4 * in,
                                __global       float4 * out)
{
  int gid = get_global_id(0);
  float4 in_v = in[gid];
  float4 out_v;
  out_v   = in_v * in_v.w;
  out_v.w = in_v.w;
  out[gid] = out_v;
}

__kernel void ragabaf_to_rgbaf (__global const float4 * in,
                                __global       float4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 out_v;
  out_v = (in_v.w > BABL_ALPHA_THRESHOLD)? in_v / in_v.w : (float4)(0.0f);
  out_v.w = in_v.w;
  out[gid] = out_v;
}
__kernel void rgbau8_to_ragabaf (__global const uchar4 * in,
                                 __global       float4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = convert_float4(in[gid]) / 255.0f;
  float4 out_v;
  out_v   = in_v * in_v.w;
  out_v.w = in_v.w;
  out[gid] = out_v;
}

__kernel void ragabaf_to_rgbau8 (__global const float4 * in,
                                 __global       uchar4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 out_v;
  out_v = (in_v.w > BABL_ALPHA_THRESHOLD)? in_v / in_v.w : (float4)(0.0f);
  out_v.w = in_v.w;
  out[gid] = convert_uchar4_sat_rte(255.0f * out_v);
}
__kernel void rgba_gamma_u8_to_ragabaf (__global const uchar4 * in,
                                        __global       float4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = convert_float4(in[gid]) / 255.0f;
  float4 tmp_v;
  tmp_v = (float4)(gamma_2_2_to_linear(in_v.x),
                   gamma_2_2_to_linear(in_v.y),
                   gamma_2_2_to_linear(in_v.z),
                   in_v.w);
  float4 out_v;
  out_v   = tmp_v * tmp_v.w;
  out_v.w = tmp_v.w;
  out[gid] = out_v;
}

__kernel void ragabaf_to_rgba_gamma_u8 (__global const float4 * in,
                                        __global       uchar4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 tmp_v;
  tmp_v = (in_v.w > BABL_ALPHA_THRESHOLD)? in_v / in_v.w : (float4)(0.0f);
  tmp_v.w = in_v.w;
  float4 out_v;
  out_v = (float4)(linear_to_gamma_2_2(tmp_v.x),
                   linear_to_gamma_2_2(tmp_v.y),
                   linear_to_gamma_2_2(tmp_v.z),
                   tmp_v.w);
  out[gid] = convert_uchar4_sat_rte(255.0f * out_v);
}
__kernel void rgb_gamma_u8_to_ragabaf (__global const uchar  * in,
                                       __global       float4 * out)
{
  int gid = get_global_id(0);
  float3 in_v  = convert_float3(vload3 (gid, in)) / 255.0f;
  float4 tmp_v;
  tmp_v = (float4)(gamma_2_2_to_linear(in_v.x),
                   gamma_2_2_to_linear(in_v.y),
                   gamma_2_2_to_linear(in_v.z),
                   1.0f);
  float4 out_v;
  out_v   = tmp_v * tmp_v.w;
  out_v.w = tmp_v.w;
  out[gid] = out_v;
}

__kernel void ragabaf_to_rgb_gamma_u8 (__global const float4 * in,
                                       __global       uchar  * out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 tmp_v;
  tmp_v = (in_v.w > BABL_ALPHA_THRESHOLD)? in_v / in_v.w : (float4)(0.0f);
  tmp_v.w = in_v.w;
  float4 out_v;
  out_v = (float4)(linear_to_gamma_2_2(tmp_v.x),
                   linear_to_gamma_2_2(tmp_v.y),
                   linear_to_gamma_2_2(tmp_v.z),
                   tmp_v.w);
  vstore3 (convert_uchar3_sat_rte(255.0f * out_v.xyz * out_v.w), gid, out);
}
__kernel void rgbaf_to_rgba_gamma_f (__global const float4 * in,
                                     __global       float4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 out_v;
  out_v = (float4)(linear_to_gamma_2_2(in_v.x),
                   linear_to_gamma_2_2(in_v.y),
                   linear_to_gamma_2_2(in_v.z),
                   in_v.w);
  out[gid] = out_v;
}
__kernel void rgba_gamma_f_to_rgbaf (__global const float4 * in,
                                     __global       float4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 out_v;
  out_v = (float4)(gamma_2_2_to_linear(in_v.x),
                   gamma_2_2_to_linear(in_v.y),
                   gamma_2_2_to_linear(in_v.z),
                   in_v.w);
  out[gid] = out_v;
}
__kernel void rgbau8_to_rgba_gamma_f (__global const uchar4 * in,
                                      __global       float4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = convert_float4(in[gid]) / 255.0f;
  float4 out_v;
  out_v = (float4)(linear_to_gamma_2_2(in_v.x),
                   linear_to_gamma_2_2(in_v.y),
                   linear_to_gamma_2_2(in_v.z),
                   in_v.w);
  out[gid] = out_v;
}
__kernel void rgba_gamma_f_to_rgbau8 (__global const float4 * in,
                                      __global       uchar4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 out_v;
  out_v = (float4)(gamma_2_2_to_linear(in_v.x),
                   gamma_2_2_to_linear(in_v.y),
                   gamma_2_2_to_linear(in_v.z),
                   in_v.w);
  out[gid] = convert_uchar4_sat_rte(255.0f * out_v);
}
__kernel void rgbaf_to_ycbcraf (__global const float4 * in,
                                __global       float4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 out_v;

  float3 rgb = (float3)(linear_to_gamma_2_2(in_v.x),
                        linear_to_gamma_2_2(in_v.y),
                        linear_to_gamma_2_2(in_v.z));

  out_v = (float4)( 0.299f    * rgb.x + 0.587f    * rgb.y + 0.114f    * rgb.z,
                   -0.168736f * rgb.x - 0.331264f * rgb.y + 0.5f      * rgb.z,
                    0.5f      * rgb.x - 0.418688f * rgb.y - 0.081312f * rgb.z,
                   in_v.w);
  out[gid] = out_v;
}
__kernel void ycbcraf_to_rgbaf (__global const float4 * in,
                                __global       float4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 out_v;

  float4 rgb = (float4)(1.0f * in_v.x + 0.0f      * in_v.y + 1.40200f    * in_v.z,
                        1.0f * in_v.x - 0.344136f * in_v.y - 0.71414136f * in_v.z,
                        1.0f * in_v.x + 1.772f    * in_v.y + 0.0f        * in_v.z,
                        0.0f);

  out_v = (float4)(linear_to_gamma_2_2(rgb.x),
                   linear_to_gamma_2_2(rgb.y),
                   linear_to_gamma_2_2(rgb.z),
                   in_v.w);
  out[gid] = out_v;
}
__kernel void rgbau8_to_ycbcraf (__global const uchar4 * in,
                                 __global       float4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = convert_float4(in[gid]) / 255.0f;
  float4 out_v;

  float4 rgb = (float4)(linear_to_gamma_2_2(in_v.x),
                        linear_to_gamma_2_2(in_v.y),
                        linear_to_gamma_2_2(in_v.z),
                        0.0f);

  out_v = (float4)( 0.299f    * rgb.x + 0.587f    * rgb.y + 0.114f    * rgb.z,
                   -0.168736f * rgb.x - 0.331264f * rgb.y + 0.5f      * rgb.z,
                    0.5f      * rgb.x - 0.418688f * rgb.y - 0.081312f * rgb.z,
                   in_v.w);
  out[gid] = out_v;
}
__kernel void ycbcraf_to_rgbau8 (__global const float4 * in,
                                 __global       uchar4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 out_v;

  float4 rgb = (float4)(1.0f * in_v.x + 0.0f      * in_v.y + 1.40200f    * in_v.z,
                        1.0f * in_v.x - 0.344136f * in_v.y - 0.71414136f * in_v.z,
                        1.0f * in_v.x + 1.772f    * in_v.y + 0.0f        * in_v.z,
                        0.0f);

  out_v = (float4)(gamma_2_2_to_linear(rgb.x),
                   gamma_2_2_to_linear(rgb.y),
                   gamma_2_2_to_linear(rgb.z),
                   in_v.w);
  out[gid] = convert_uchar4_sat_rte(255.0f * out_v);
}
__kernel void rgbu8_to_rgbaf (__global const uchar  * in,
                              __global       float4 * out)
{
  int gid = get_global_id(0);
  uchar3 in_v;
  float4 out_v;
  in_v = vload3 (gid, in);
  out_v.xyz = convert_float3(in_v) / 255.0f;
  out_v.w   = 1.0f;
  out[gid]  = out_v;
}
__kernel void rgbaf_to_rgbu8 (__global const float4 * in,
                              __global       uchar  * out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  uchar3 out_v = convert_uchar3_sat_rte(255.0f * in_v.w * in_v.xyz);
  vstore3 (out_v, gid, out);
}
__kernel void yu8_to_yf (__global const uchar * in,
                         __global       float * out)
{
  int gid = get_global_id(0);
  float in_v  = convert_float (in[gid]) / 255.0f;
  float out_v;
  out_v = in_v;
  out[gid] = out_v;
}
  /* source: http://www.poynton.com/ColorFAQ.html */
  #define RGB_LUMINANCE_RED    (0.212671f)
  #define RGB_LUMINANCE_GREEN  (0.715160f)
  #define RGB_LUMINANCE_BLUE   (0.072169f)
__kernel void rgbaf_to_yaf (__global const float4 * in,
                            __global       float2 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float2 out_v;

  float luminance = in_v.x * RGB_LUMINANCE_RED +
                    in_v.y * RGB_LUMINANCE_GREEN +
                    in_v.z * RGB_LUMINANCE_BLUE;

  out_v.x = luminance;
  out_v.y = in_v.w;

  out[gid] = out_v;
}
__kernel void yaf_to_rgbaf (__global const float2 * in,
                            __global       float4 * out)
{
  int gid = get_global_id(0);
  float2 in_v  = in[gid];
  float4 out_v = (float4) (in_v.x, in_v.x, in_v.x, in_v.y);

  out[gid] = out_v;
}
__kernel void rgbau8_to_yaf (__global const uchar4 * in,
                             __global       float2 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = convert_float4(in[gid]) / 255.0f;
  float2 out_v;

  float luminance = in_v.x * RGB_LUMINANCE_RED +
                    in_v.y * RGB_LUMINANCE_GREEN +
                    in_v.z * RGB_LUMINANCE_BLUE;

  out_v.x = luminance;
  out_v.y = in_v.w;

  out[gid] = out_v;
}
__kernel void yaf_to_rgbau8 (__global const float2 * in,
                             __global       uchar4 * out)
{
  int gid = get_global_id(0);
  float2 in_v  = in[gid];
  float4 out_v = (float4) (in_v.x, in_v.x, in_v.x, in_v.y);

  out[gid] = convert_uchar4_sat_rte(255.0f * out_v);
}
__kernel void rgba_gamma_u8_to_yaf (__global const uchar4 * in,
                                    __global       float2 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = convert_float4(in[gid]) / 255.0f;
  float4 tmp_v;
  tmp_v = (float4)(gamma_2_2_to_linear(in_v.x),
                   gamma_2_2_to_linear(in_v.y),
                   gamma_2_2_to_linear(in_v.z),
                   in_v.w);
  float2 out_v;

  float luminance = tmp_v.x * RGB_LUMINANCE_RED +
                    tmp_v.y * RGB_LUMINANCE_GREEN +
                    tmp_v.z * RGB_LUMINANCE_BLUE;

  out_v.x = luminance;
  out_v.y = tmp_v.w;

  out[gid] = out_v;
}
__kernel void yaf_to_rgba_gamma_u8 (__global const float2 * in,
                                    __global       uchar4 * out)
{
  int gid = get_global_id(0);
  float2 in_v  = in[gid];
  float4 tmp_v = (float4) (in_v.x, in_v.x, in_v.x, in_v.y);

  float4 out_v;
  out_v = (float4)(linear_to_gamma_2_2(tmp_v.x),
                   linear_to_gamma_2_2(tmp_v.y),
                   linear_to_gamma_2_2(tmp_v.z),
                   tmp_v.w);
  out[gid] = convert_uchar4_sat_rte(255.0f * out_v);
}
__kernel void rgb_gamma_u8_to_yaf (__global const uchar  * in,
                                   __global       float2 * out)
{
  int gid = get_global_id(0);
  float3 in_v  = convert_float3(vload3 (gid, in)) / 255.0f;
  float4 tmp_v;
  tmp_v = (float4)(gamma_2_2_to_linear(in_v.x),
                   gamma_2_2_to_linear(in_v.y),
                   gamma_2_2_to_linear(in_v.z),
                   1.0f);
  float2 out_v;

  float luminance = tmp_v.x * RGB_LUMINANCE_RED +
                    tmp_v.y * RGB_LUMINANCE_GREEN +
                    tmp_v.z * RGB_LUMINANCE_BLUE;

  out_v.x = luminance;
  out_v.y = tmp_v.w;

  out[gid] = out_v;
}
__kernel void yaf_to_rgb_gamma_u8 (__global const float2 * in,
                                   __global       uchar  * out)
{
  int gid = get_global_id(0);
  float2 in_v  = in[gid];
  float4 tmp_v = (float4) (in_v.x, in_v.x, in_v.x, in_v.y);

  float4 out_v;
  out_v = (float4)(linear_to_gamma_2_2(tmp_v.x),
                   linear_to_gamma_2_2(tmp_v.y),
                   linear_to_gamma_2_2(tmp_v.z),
                   tmp_v.w);
  vstore3 (convert_uchar3_sat_rte(255.0f * out_v.xyz * out_v.w), gid, out);
}
__kernel void rgbaf_to_rgba_gamma_u8 (__global const float4 * in,
                                      __global       uchar4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 out_v;
  out_v = (float4)(linear_to_gamma_2_2(in_v.x),
                   linear_to_gamma_2_2(in_v.y),
                   linear_to_gamma_2_2(in_v.z),
                   in_v.w);
  out[gid] = convert_uchar4_sat_rte(255.0f * out_v);
}
__kernel void rgba_gamma_u8_to_rgbaf (__global const uchar4 * in,
                                      __global       float4 * out)
{
  int gid = get_global_id(0);
  float4 in_v  = convert_float4(in[gid]) / 255.0f;
  float4 out_v;
  out_v = (float4)(gamma_2_2_to_linear(in_v.x),
                   gamma_2_2_to_linear(in_v.y),
                   gamma_2_2_to_linear(in_v.z),
                   in_v.w);
  out[gid] = out_v;
}
__kernel void rgbaf_to_rgb_gamma_u8 (__global const float4 * in,
                                     __global       uchar  * out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 tmp_v;
  uchar3 out_v;
  tmp_v = (float4)(linear_to_gamma_2_2(in_v.x),
                   linear_to_gamma_2_2(in_v.y),
                   linear_to_gamma_2_2(in_v.z),
                   in_v.w);
  out_v = convert_uchar3_sat_rte(255.0f * tmp_v.w * tmp_v.xyz);
  vstore3 (out_v, gid, out);
}
__kernel void rgb_gamma_u8_to_rgbaf (__global const uchar  * in,
                                     __global       float4 * out)
{
  int gid = get_global_id(0);
  uchar3 in_v;
  float3 tmp_v;
  float4 out_v;
  in_v = vload3 (gid, in);
  tmp_v = convert_float3(in_v) / 255.0f;
  out_v = (float4)(gamma_2_2_to_linear(tmp_v.x),
                   gamma_2_2_to_linear(tmp_v.y),
                   gamma_2_2_to_linear(tmp_v.z),
                   1.0f);
  out[gid] = out_v;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
