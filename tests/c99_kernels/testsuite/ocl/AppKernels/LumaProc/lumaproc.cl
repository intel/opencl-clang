/***********************************************************************

    INTEL CONFIDENTIAL
    Copyright 2014 Intel Corporation All Rights Reserved.

    The source code contained or described herein and all documents
    related to the source code ("Material") are owned by Intel
    Corporation or its suppliers or licensors. Title to the Material
    remains with Intel Corporation or its suppliers and licensors.
    The Material may contain trade secrets and proprietary and
    confidential information of Intel Corporation and its suppliers
    and licensors, and is protected by worldwide copyright and trade
    secret laws and treaty provisions. No part of the Material may be
    used, copied, reproduced, modified, published, uploaded, posted,
    transmitted, distributed, or disclosed in any way without Intel's
    prior express written permission.

    No license under any patent, copyright, trade secret or other
    intellectual property right is granted to or conferred upon you
    by disclosure or delivery of the Materials, either expressly,
    by implication, inducement, estoppel or otherwise. Any license
    under such intellectual property rights must be express and
    approved by Intel in writing.

**********************************************************************/

#define CEIL_DIV(a, b) (((a) + (b) - 1) / (b))
#define CEIL(a, b)     (CEIL_DIV(a, b) * (b))

/* Gaussian filter defines */
#define GAUSS_FILTER_RADIUS      (2)
#define GAUSS_FILTER_SIZE        (2 * GAUSS_FILTER_RADIUS + 1)
#define GAUSS_FILTER_DIV         (256.0f)
#define GAUSS_FILTER_SCATTER_DIV (64.0f)

/* Gaussian pyramid decomposition defines */
#define LUMA_PYR_DOWN_SCALE_FACTOR (2)

#define LUMA_PYR_DOWN_KERNEL_OUT_SIZE_X (8)
#define LUMA_PYR_DOWN_KERNEL_IN_SIZE_X  (LUMA_PYR_DOWN_SCALE_FACTOR * LUMA_PYR_DOWN_KERNEL_OUT_SIZE_X)

#define LUMA_PYR_DOWN_KERNEL_OUT_SIZE_Y (32)
#define LUMA_PYR_DOWN_KERNEL_IN_SIZE_Y  (LUMA_PYR_DOWN_SCALE_FACTOR * LUMA_PYR_DOWN_KERNEL_OUT_SIZE_Y)

#define LUMA_PYR_DOWN_KERNEL_OVERLAP   (LUMA_PYR_DOWN_KERNEL_IN_SIZE_X)

#define LUMA_PYR_DOWN_LOC_GROUP_SIZE_X (24)
#define LUMA_PYR_DOWN_LOC_GROUP_SIZE_Y (1)

#define LUMA_PYR_DOWN_INPUT_BUF_WIDTH (LUMA_PYR_DOWN_LOC_GROUP_SIZE_X * LUMA_PYR_DOWN_KERNEL_IN_SIZE_X + \
                                       2 * LUMA_PYR_DOWN_KERNEL_OVERLAP)
#define LUMA_PYR_DOWN_INPUT_BUF_HEIGHT (CEIL(GAUSS_FILTER_SIZE, LUMA_PYR_DOWN_SCALE_FACTOR))
#define LUMA_PYR_DOWN_INPUT_BUF_SIZE (LUMA_PYR_DOWN_INPUT_BUF_WIDTH * LUMA_PYR_DOWN_INPUT_BUF_HEIGHT)

#define LUMA_PYR_DOWN_GAUSS_DELAY CEIL_DIV(2 * GAUSS_FILTER_RADIUS, LUMA_PYR_DOWN_SCALE_FACTOR)

/* Lumaproc last level blending defines */
#define LUMA_BLEND_KERNEL_SIZE_X (4)
#define LUMA_BLEND_KERNEL_SIZE_Y (1)

/* Lumaproc pyramid reconstruction defines */
#define LUMA_PYR_UP_SCALE_FACTOR (2)

#define LUMA_PYR_UP_KERNEL_PREV_SIZE_X (2)
#define LUMA_PYR_UP_KERNEL_CURR_SIZE_X (LUMA_PYR_UP_SCALE_FACTOR * LUMA_PYR_UP_KERNEL_PREV_SIZE_X)

#define LUMA_PYR_UP_KERNEL_PREV_SIZE_Y (32)
#define LUMA_PYR_UP_KERNEL_CURR_SIZE_Y (LUMA_PYR_UP_SCALE_FACTOR * LUMA_PYR_UP_KERNEL_PREV_SIZE_Y)

#define LUMA_PYR_UP_KERNEL_HOR_OVERLAP (LUMA_PYR_UP_KERNEL_PREV_SIZE_X)
#define LUMA_PYR_UP_KERNEL_VER_OVERLAP  CEIL_DIV(GAUSS_FILTER_RADIUS, LUMA_PYR_DOWN_SCALE_FACTOR)

#define LUMA_PYR_UP_LOC_GROUP_SIZE_X   (96)
#define LUMA_PYR_UP_LOC_GROUP_SIZE_Y   (1)

#define LUMA_PYR_UP_INPUT_BUF_WIDTH  (LUMA_PYR_UP_LOC_GROUP_SIZE_X * LUMA_PYR_UP_KERNEL_PREV_SIZE_X + \
                                      2 * LUMA_PYR_UP_KERNEL_HOR_OVERLAP)
#define LUMA_PYR_UP_INPUT_BUF_HEIGHT  CEIL_DIV(GAUSS_FILTER_SIZE, LUMA_PYR_UP_SCALE_FACTOR)
#define LUMA_PYR_UP_INPUT_BUF_SIZE   (LUMA_PYR_UP_INPUT_BUF_WIDTH * LUMA_PYR_UP_INPUT_BUF_HEIGHT)

#define LUMA_PYR_UP_GAUSS_DELAY       CEIL_DIV(2 * GAUSS_FILTER_RADIUS, LUMA_PYR_UP_SCALE_FACTOR)

/** @brief Downscale 2x with nearest neighbour decimation
  *
  * @param[in] in input float16 vector
  *
  * @return output float8 vector
  */
static inline float8 downscale_nnd_2x (float16 in)
{
    float8 out;

    out = in.s02468ace;

    return out;
}

/** @brief Horizontal Gaussian filter 5x5 for float4 vectors
  *
  * @param[in] in_0 input vector shifted for -2 from filter anchor
  * @param[in] in_1 input vector shifted for -1 from filter anchor
  * @param[in] in_2 input vector shifted for 0 from filter anchor
  * @param[in] in_3 input vector shifted for 1 from filter anchor
  * @param[in] in_4 input vector shifted for 2 from filter anchor
  *
  * @return output float4 vector
  */
static inline float4 gauss_filter_1D_5x5_float4 (float4 in_0, float4 in_1, float4 in_2,
                                                   float4 in_3, float4 in_4)
{
    float4 out;

    out = (in_0 + in_4);
    out = mad((in_1 + in_3), 4.0f, out);
    out = mad(in_2, 6.0f, out);

    return out;
}

/** @brief Horizontal Gaussian filter 5x5 for float16 vectors
  *
  * @param[in] in_0 input vector shifted for -2 from filter anchor
  * @param[in] in_1 input vector shifted for -1 from filter anchor
  * @param[in] in_2 input vector shifted for 0 from filter anchor
  * @param[in] in_3 input vector shifted for 1 from filter anchor
  * @param[in] in_4 input vector shifted for 2 from filter anchor
  *
  * @return output float16 vector
  */
static inline float16 gauss_filter_1D_5x5_float16 (float16 in_0, float16 in_1, float16 in_2,
                                                   float16 in_3, float16 in_4)
{
    float16 out;

    out = (in_0 + in_4);
    out = mad((in_1 + in_3), 4.0f, out);
    out = mad(in_2, 6.0f, out);

    return out;
}

/** @brief Gaussian filter 5x5
  *
  * @param[in] line_0 pointer to line 0 of input in local memory
  * @param[in] line_1 pointer to line 1 of input in local memory
  * @param[in] line_2 pointer to line 2 of input in local memory
  * @param[in] line_3 pointer to line 3 of input in local memory
  * @param[in] line_4 pointer to line 4 of input in local memory
  *
  * @return output float16 vector
  */
static inline float16 gauss_filter_5x5 (__local uchar *line_0, __local uchar *line_1, __local uchar *line_2,
                                        __local uchar *line_3, __local uchar *line_4)
{
    float2 in_left, in_right;
    float16 in;
    float16 out_line_0, out_line_1, out_line_2, out_line_3, out_line_4;
    float16 out;

    /* Load inputs for line 0 and calculate horizontal Gaussian filter */
    in_left = convert_float2(*((__local uchar2 *)(line_0 - GAUSS_FILTER_RADIUS)));
    in_right = convert_float2(*((__local uchar2 *)(line_0 + LUMA_PYR_DOWN_KERNEL_IN_SIZE_X)));
    in = convert_float16(*((__local uchar16 *)line_0));

    out_line_0 = gauss_filter_1D_5x5_float16((float16)(in_left.s01, in.s01234567, in.s89ab, in.scd),
                                             (float16)(in_left.s1,  in.s01234567, in.s89ab, in.scde),
                                                       in,
                                             (float16)(in.s123, in.s4567, in.s89abcdef, in_right.s0),
                                             (float16)(in.s23,  in.s4567, in.s89abcdef, in_right.s01));

    /* Load inputs for line 1 and calculate horizontal Gaussian filter */
    in_left = convert_float2(*((__local uchar2 *)(line_1 - GAUSS_FILTER_RADIUS)));
    in_right = convert_float2(*((__local uchar2 *)(line_1 + LUMA_PYR_DOWN_KERNEL_IN_SIZE_X)));
    in = convert_float16(*((__local uchar16 *)line_1));

    out_line_1 = gauss_filter_1D_5x5_float16((float16)(in_left.s01, in.s01234567, in.s89ab, in.scd),
                                     (float16)(in_left.s1,  in.s01234567, in.s89ab, in.scde),
                                               in,
                                     (float16)(in.s123, in.s4567, in.s89abcdef, in_right.s0),
                                     (float16)(in.s23,  in.s4567, in.s89abcdef, in_right.s01));

    /* Load inputs for line 2 and calculate horizontal Gaussian filter */
    in_left = convert_float2(*((__local uchar2 *)(line_2 - GAUSS_FILTER_RADIUS)));
    in_right = convert_float2(*((__local uchar2 *)(line_2 + LUMA_PYR_DOWN_KERNEL_IN_SIZE_X)));
    in = convert_float16(*((__local uchar16 *)line_2));

    out_line_2 = gauss_filter_1D_5x5_float16((float16)(in_left.s01, in.s01234567, in.s89ab, in.scd),
                                             (float16)(in_left.s1,  in.s01234567, in.s89ab, in.scde),
                                                       in,
                                             (float16)(in.s123, in.s4567, in.s89abcdef, in_right.s0),
                                             (float16)(in.s23,  in.s4567, in.s89abcdef, in_right.s01));

    /* Load inputs for line 3 and calculate horizontal Gaussian filter */
    in_left = convert_float2(*((__local uchar2 *)(line_3 - GAUSS_FILTER_RADIUS)));
    in_right = convert_float2(*((__local uchar2 *)(line_3 + LUMA_PYR_DOWN_KERNEL_IN_SIZE_X)));
    in = convert_float16(*((__local uchar16 *)line_3));

    out_line_3 = gauss_filter_1D_5x5_float16((float16)(in_left.s01, in.s01234567, in.s89ab, in.scd),
                                             (float16)(in_left.s1,  in.s01234567, in.s89ab, in.scde),
                                                       in,
                                             (float16)(in.s123, in.s4567, in.s89abcdef, in_right.s0),
                                             (float16)(in.s23,  in.s4567, in.s89abcdef, in_right.s01));

    /* Load inputs for line 4 and calculate horizontal Gaussian filter */
    in_left = convert_float2(*((__local uchar2 *)(line_4 - GAUSS_FILTER_RADIUS)));
    in_right = convert_float2(*((__local uchar2 *)(line_4 + LUMA_PYR_DOWN_KERNEL_IN_SIZE_X)));
    in = convert_float16(*((__local uchar16 *)line_4));

    out_line_4 = gauss_filter_1D_5x5_float16((float16)(in_left.s01, in.s01234567, in.s89ab, in.scd),
                                             (float16)(in_left.s1,  in.s01234567, in.s89ab, in.scde),
                                                       in,
                                             (float16)(in.s123, in.s4567, in.s89abcdef, in_right.s0),
                                             (float16)(in.s23,  in.s4567, in.s89abcdef, in_right.s01));

    /* Calculate output Gaussian filter */
    out = gauss_filter_1D_5x5_float16(out_line_0, out_line_1, out_line_2, out_line_3, out_line_4);
    out = out / GAUSS_FILTER_DIV;

    return out;
}

/** @brief Lumaproc pyramid decomposition kernel with 5x5 gaussian filter
 *
 * @param[in] input pointer to input pyramid level plane
 * @param[out] output pointer to output pyramid level plane
 * @param[in] input_width input pyramid level width
 * @param[in] input_height input pyramid level height
 * @param[in] input_stride input pyramid level stride
 * @param[in] input_offset input pyramid level offset
 * @param[in] output_width output pyramid level width
 * @param[in] output_height output pyramid level height
 * @param[in] output_stride output pyramid level stride
 * @param[in] output_offset output pyramid level offset
 *
 * Function calculates next pyramid level for lumaproc gaussian piramyd decomposition
 * using 5x5 gaussian kernel.
 */
__kernel void luma_pyr_down_5x5 (__global uchar *input, __global uchar *output,
                                 int input_width, int input_height, int input_stride, int input_offset,
                                 int output_width, int output_height, int output_stride, int output_offset)
{
    int x_global = get_global_id(0);
    int y_global = get_global_id(1);
    int x_in = LUMA_PYR_DOWN_KERNEL_IN_SIZE_X * x_global;
    int y_in = LUMA_PYR_DOWN_KERNEL_IN_SIZE_Y * y_global;
    int x_out = LUMA_PYR_DOWN_KERNEL_OUT_SIZE_X * x_global;
    int y_out = LUMA_PYR_DOWN_KERNEL_OUT_SIZE_Y * y_global;
    int x_loc = get_local_id(0);
    int kernel_size_y = (y_global == ((int)get_global_size(1) - 1)) ?
                         output_height % LUMA_PYR_DOWN_KERNEL_OUT_SIZE_Y : LUMA_PYR_DOWN_KERNEL_OUT_SIZE_Y;

    /* Handle the case where height is multiple of LUMA_PYR_DOWN_KERNEL_OUT_SIZE_Y */
    if (kernel_size_y == 0) {
        kernel_size_y = LUMA_PYR_DOWN_KERNEL_OUT_SIZE_Y;
    }

    /* Border flags */
    int x_gt_0 = (x_in > 0) ? 1 : 0;
    int x_lt_w_m_ksx = (x_in < (input_width - LUMA_PYR_DOWN_KERNEL_OVERLAP)) ? 1 : 0;
    int x_lt_w = (x_out < output_width) ? 1 : 0;

    /* Horizontal padding flags */
    int pad_left  = (x_loc == 0) && (x_gt_0 == 0);
    int pad_right = (x_global == (input_width - 1) / LUMA_PYR_DOWN_KERNEL_IN_SIZE_X);

    /* Global memory offsets */
    int in_line_0_offset = (y_in + ((y_in > 0) ? -GAUSS_FILTER_RADIUS : 0)) * input_stride + x_in + input_offset;
    int in_line_1_offset = in_line_0_offset + ((y_in > 0) ? input_stride : 0);
    int out_line_offset = y_out * output_stride + x_out + output_offset;

    /* Local memory buffer */
    __local uchar input_buffer[LUMA_PYR_DOWN_INPUT_BUF_SIZE];
    int curr_offset = x_loc * LUMA_PYR_DOWN_KERNEL_IN_SIZE_X + LUMA_PYR_DOWN_KERNEL_OVERLAP;
    /* Pointers to current line in local memory buffer */
    __local uchar *input_ptr = (__local uchar *)input_buffer + curr_offset;
    __local uchar16 *input_line_0_ptr16 = (__local uchar16 *)(input_ptr);
    __local uchar16 *input_line_1_ptr16 = (__local uchar16 *)(input_ptr + LUMA_PYR_DOWN_INPUT_BUF_WIDTH);
    /* Pointers to input lines for Gaussian filter */
    __local uchar *input_line_0_ptr = input_ptr;
    __local uchar *input_line_1_ptr = (__local uchar *)input_ptr +     LUMA_PYR_DOWN_INPUT_BUF_WIDTH;
    __local uchar *input_line_2_ptr = (__local uchar *)input_ptr + 2 * LUMA_PYR_DOWN_INPUT_BUF_WIDTH;
    __local uchar *input_line_3_ptr = (__local uchar *)input_ptr + 3 * LUMA_PYR_DOWN_INPUT_BUF_WIDTH;
    __local uchar *input_line_4_ptr = (__local uchar *)input_ptr + 4 * LUMA_PYR_DOWN_INPUT_BUF_WIDTH;
    int line_3_offset = curr_offset + 3 * LUMA_PYR_DOWN_INPUT_BUF_WIDTH;
    int line_4_offset = curr_offset + 4 * LUMA_PYR_DOWN_INPUT_BUF_WIDTH;

    /* Process kernel_size_y lines and store results to global memory */
    for (int line = 0; line < kernel_size_y + LUMA_PYR_DOWN_GAUSS_DELAY; line++) {
        int pad_line;
        int line_inc;
        int line_in;

        /* Ensure that all work items have finished reading from local memory */
        barrier(CLK_LOCAL_MEM_FENCE);

        /* Read two stripe lines from global to local memory buffer */
        /* Each work-item reads 2 lines of 16 pixels from global memory, except first and last that reads 32 pixels */
        if (x_loc == 0 && x_gt_0 != 0) {
            *(input_line_0_ptr16 - 1) = vload16((in_line_0_offset / LUMA_PYR_DOWN_KERNEL_IN_SIZE_X) - 1,
                                                (__global uchar *)(input));
            *(input_line_1_ptr16 - 1) = vload16((in_line_1_offset / LUMA_PYR_DOWN_KERNEL_IN_SIZE_X) - 1,
                                                (__global uchar *)(input));
        }
        if (x_lt_w != 0) {
            *(input_line_0_ptr16) = vload16(in_line_0_offset / LUMA_PYR_DOWN_KERNEL_IN_SIZE_X,
                                            (__global uchar *)(input));
            *(input_line_1_ptr16) = vload16(in_line_1_offset / LUMA_PYR_DOWN_KERNEL_IN_SIZE_X,
                                            (__global uchar *)(input));
        }
        if ((x_loc == LUMA_PYR_DOWN_LOC_GROUP_SIZE_X - 1) && (x_lt_w_m_ksx != 0)) {
            *(input_line_0_ptr16 + 1) = vload16((in_line_0_offset / LUMA_PYR_DOWN_KERNEL_IN_SIZE_X) + 1,
                                                (__global uchar *)(input));
            *(input_line_1_ptr16 + 1) = vload16((in_line_1_offset / LUMA_PYR_DOWN_KERNEL_IN_SIZE_X) + 1,
                                                (__global uchar *)(input));
        }

        /* Pad left horizontal border */
        if (pad_left != 0) {
            uchar pad_val;
            /* Pad first line */
            pad_val = *((__local uchar *)input_line_0_ptr16);
            *((__local uchar2 *)input_line_0_ptr16 - 1) = (uchar2)(pad_val, pad_val);
            /* Pad second line */
            pad_val = *((__local uchar *)input_line_1_ptr16);
            *((__local uchar2 *)input_line_1_ptr16 - 1) = (uchar2)(pad_val, pad_val);
        }

        /* Pad right horizontal border */
        if (pad_right != 0) {
            uchar pad_val;
            int pad_offset = input_width - x_in;

            /* Pad first line */
            pad_val = *((__local uchar *)input_line_0_ptr16 + pad_offset - 1);
            *((__local uchar *)input_line_0_ptr16 + pad_offset) = pad_val;
            *((__local uchar *)input_line_0_ptr16 + pad_offset + 1) = pad_val;
            /* Pad second line */
            pad_val = *((__local uchar *)input_line_1_ptr16 + pad_offset - 1);
            *((__local uchar *)input_line_1_ptr16 + pad_offset) = pad_val;
            *((__local uchar *)input_line_1_ptr16 + pad_offset + 1) = pad_val;
        }

        /* Ensure that all work items have finished writing into local memory */
        barrier(CLK_LOCAL_MEM_FENCE);

        /* Calculate input line */
        line_in = line * LUMA_PYR_DOWN_SCALE_FACTOR;

        /* Calculate output data after enough input lines is fetched */
        if (line >= LUMA_PYR_DOWN_GAUSS_DELAY)
        {
            float16 out_gauss;
            float8 out;

            out_gauss = gauss_filter_5x5(input_line_0_ptr, input_line_1_ptr, input_line_2_ptr,
                                         input_line_3_ptr, input_line_4_ptr);
            out = downscale_nnd_2x(out_gauss);
            /* Result will be stored in output buffer only for pixels with x index lower than actual buffer width */
            if (x_lt_w != 0) {
                vstore8(convert_uchar8_sat_rte(out), out_line_offset / LUMA_PYR_DOWN_KERNEL_OUT_SIZE_X,
                        (__global uchar *)(output));
            }

            /* Update pointers to local memory input buffer */
            line_3_offset = (line_3_offset + LUMA_PYR_DOWN_INPUT_BUF_WIDTH * LUMA_PYR_DOWN_SCALE_FACTOR) %
                             LUMA_PYR_DOWN_INPUT_BUF_SIZE;
            line_4_offset = (line_4_offset + LUMA_PYR_DOWN_INPUT_BUF_WIDTH * LUMA_PYR_DOWN_SCALE_FACTOR) %
                             LUMA_PYR_DOWN_INPUT_BUF_SIZE;
            input_line_0_ptr = input_line_2_ptr;
            input_line_1_ptr = input_line_3_ptr;
            input_line_2_ptr = input_line_4_ptr;
            input_line_3_ptr = (__local uchar *)input_buffer + line_3_offset;
            input_line_4_ptr = (__local uchar *)input_buffer + line_4_offset;

            /* Update pointer to global output memory buffer */
            out_line_offset += output_stride;
        }

        /* Update pointers to local memory input buffer */
        curr_offset = (curr_offset + LUMA_PYR_DOWN_INPUT_BUF_WIDTH * LUMA_PYR_DOWN_SCALE_FACTOR) %
                      LUMA_PYR_DOWN_INPUT_BUF_SIZE;
        input_ptr = (__local uchar *)input_buffer + curr_offset;
        input_line_0_ptr16 = (__local uchar16 *)(input_ptr);
        input_line_1_ptr16 = (__local uchar16 *)(input_ptr + LUMA_PYR_DOWN_INPUT_BUF_WIDTH);

        /* Update pointers to global input memory buffer */
        /* Pad vertical border if input line is out of bounds */
        pad_line = ((y_in + line_in - GAUSS_FILTER_RADIUS) < 0) ||
                   ((y_in + line_in - GAUSS_FILTER_RADIUS) > input_height - LUMA_PYR_DOWN_SCALE_FACTOR - 1);
        line_inc = (pad_line == 0) ?
                    LUMA_PYR_DOWN_SCALE_FACTOR :
                  ((y_in + line_in - GAUSS_FILTER_RADIUS + 1) != (input_height - 1)) ? 0 : 1;
        in_line_0_offset += line_inc * input_stride;
        in_line_1_offset = in_line_0_offset +
                        (((y_in + line_in - GAUSS_FILTER_RADIUS + 1) <=
                          (input_height - LUMA_PYR_DOWN_SCALE_FACTOR - 1)) ? input_stride : 0);
    }
}

/** @brief Soft threhold function
 *
 * @param[in] input input float4 vector
 * @param[in] thr_high high threshold value
 * @param[in] val_thr_low function value at low threshold
 * @param[in] val_thr_high function value at high threshold
 * @return output float4 vector calculated using threshold transfer function
 *
 * This function performs soft threshold transfer function.
 * Tranfer function can looks like below:
 *             __________
 *            /
 *           /
 * _________/
 *
 */
static inline float4 soft_threshold(float4 input, float thr_low, float thr_high,
                                     float val_thr_low, float val_thr_high)
{
    float k;
    float4 out;

    k = (val_thr_high - val_thr_low) / (thr_high - thr_low);
    out = mad(k, input - thr_low, val_thr_low);
    out = clamp(out, val_thr_low, val_thr_high);

    return out;
}

/** @brief Lumaproc pyramid blending kernel
 *
 * @param[in] input_meV pointer to under-exposed input pyramid level plane
 * @param[in] input_0eV pointer to base input pyramid level plane
 * @param[in] input_peV pointer to over-exposed input pyramid level plane
 * @param[out] output pointer to output pyramid level plane
 * @param[in] width pyramid level width
 * @param[in] height pyramid level height
 * @param[in] input_stride input pyramid level stride
 * @param[in] input_offset input pyramid level offset
 * @param[in] output_stride output pyramid level stride
 * @param[in] output_offset output pyramid level offset
 * @param[in] luma_thr_low_meV low threshold for under-exposed frame weight curve
 * @param[in] luma_thr_high_meV high threshold for under-exposed frame weight curve
 * @param[in] weight_thr_low_meV weight value at low threshold for under-exposed frame weight curve
 * @param[in] weight_thr_high_meV weight value at threshold for under-exposed frame weight curve
 * @param[in] luma_thr_low_0eV low threshold for base frame weight curve
 * @param[in] luma_thr_high_0eV high threshold for base frame weight curve
 * @param[in] weight_thr_low_0eV weight value at low threshold for base frame weight curve
 * @param[in] weight_thr_high_0eV weight value at threshold for base frame weight curve
 *
 * Function blends last gaussian pyramid level.
 */
__kernel void luma_blend (__global uchar *input_meV, __global uchar *input_0eV, __global uchar *input_peV, __global uchar *output,
                          int width, int height, int input_stride, int input_offset, int output_stride, int output_offset,
                          float luma_thr_low_meV, float luma_thr_high_meV, float weight_thr_low_meV, float weight_thr_high_meV,
                          float luma_thr_low_0eV, float luma_thr_high_0eV, float weight_thr_low_0eV, float weight_thr_high_0eV)
{
    int x_global = get_global_id(0);
    int y_global = get_global_id(1);
    int x = LUMA_BLEND_KERNEL_SIZE_X * x_global;
    int y = LUMA_BLEND_KERNEL_SIZE_Y * y_global;

    /* Flag indicator for valid pixel position */
    int is_valid = (x < width) && (y < height) ? 1 : 0;

    /* Global memory offsets */
    int in_offset = y * input_stride + x + input_offset;
    int out_offset = y * output_stride + x + output_offset;

    if (is_valid != 0) {
        float4 input_val_meV, input_val_0eV, input_val_peV;
        float4 weight_meV, weight_0eV, weight_peV;
        float4 out;

        /* Load input vectors */
        input_val_meV = convert_float4(vload4(in_offset / LUMA_BLEND_KERNEL_SIZE_X, (__global uchar *)(input_meV)));
        input_val_0eV = convert_float4(vload4(in_offset / LUMA_BLEND_KERNEL_SIZE_X, (__global uchar *)(input_0eV)));
        input_val_peV = convert_float4(vload4(in_offset / LUMA_BLEND_KERNEL_SIZE_X, (__global uchar *)(input_peV)));

        /* Apply soft threshold function */
        weight_meV = soft_threshold(input_val_meV,
                                    luma_thr_low_meV, luma_thr_high_meV, weight_thr_low_meV, weight_thr_high_meV);
        weight_0eV = soft_threshold(input_val_0eV,
                                    luma_thr_low_0eV, luma_thr_high_0eV, weight_thr_low_0eV, weight_thr_high_0eV);

        /* Calculate weights */
        weight_peV = 1.0f - weight_0eV;
        weight_0eV = weight_0eV * (1.0f - weight_meV);

        /* Blend */
        out = weight_meV * input_val_meV;
        out = mad(weight_0eV, input_val_0eV, out);
        out = mad(weight_peV, input_val_peV, out);

        vstore4(convert_uchar4_sat_rte(out), out_offset / LUMA_BLEND_KERNEL_SIZE_X, (__global uchar *)(output));
    }
}

/** @brief Upscale 2x with 0 interpolation
  *
  * @param[in] in input float value
  *
  * @return output float2 vector
  */
static inline float2 upscale_scatter_2x_float (float in)
{
    float2 out;

    out.s0 = in;
    out.s1 = 0.0f;

    return out;
}

/** @brief Upscale 2x with 0 interpolation
  *
  * @param[in] in input float2 vector
  *
  * @return output float4 vector
  */
static inline float4 upscale_scatter_2x_float2 (float2 in)
{
    float4 out;

    out.s02 = in;
    out.s13 = 0.0f;

    return out;
}

/** @brief Gaussian pyramid level upscale and filter
  *
  * @param[in] line_0 pointer to line 0 of previous pyramid level in local memory
  * @param[in] line_1 pointer to line 1 of previous pyramid level in local memory
  * @param[in] line_2 pointer to line 2 of previous pyramid level in local memory
  * @param[out] out_0 output line 0 of upscaled pyramid level
  * @param[out] out_1 output line 1 of upscaled pyramid level
  *
  * This function upscales previous Gaussian pyramid level and filters upscaled
  * layer with 5x5 Gaussian filter.
  */
static inline void gauss_pyr_up_5x5 (__local uchar *line_0, __local uchar *line_1, __local uchar *line_2,
                                     float4 *out_0, float4 *out_1)
{
    float in_left, in_right;
    float2 in;
    float2 in_left_uscaled, in_right_uscaled;
    float4 in_uscaled;
    float4 out_line_0, out_line_1, out_line_2;

    /* Load inputs for line 0 */
    in_left = convert_float(*(line_0 - CEIL_DIV(GAUSS_FILTER_RADIUS, LUMA_PYR_UP_SCALE_FACTOR)));
    in_right = convert_float(*(line_0 + LUMA_PYR_UP_KERNEL_PREV_SIZE_X));
    in = convert_float2(*((__local uchar2 *)line_0));

    /* Upscale line 0 */
    in_left_uscaled = upscale_scatter_2x_float(in_left);
    in_right_uscaled = upscale_scatter_2x_float(in_right);
    in_uscaled = upscale_scatter_2x_float2(in);

    /* Calculate horizontal Gaussian filter for line 0 */
    out_line_0 = gauss_filter_1D_5x5_float4((float4)(in_left_uscaled.s01, in_uscaled.s01),
                                            (float4)(in_left_uscaled.s1,  in_uscaled.s012),
                                                     in_uscaled,
                                            (float4)(in_uscaled.s123, in_right_uscaled.s0),
                                            (float4)(in_uscaled.s23, in_right_uscaled.s01));

    /* Load inputs for line 1 */
    in_left = convert_float(*(line_1 - CEIL_DIV(GAUSS_FILTER_RADIUS, LUMA_PYR_UP_SCALE_FACTOR)));
    in_right = convert_float(*(line_1 + LUMA_PYR_UP_KERNEL_PREV_SIZE_X));
    in = convert_float2(*((__local uchar2 *)line_1));

    /* Upscale line 1 */
    in_left_uscaled = upscale_scatter_2x_float(in_left);
    in_right_uscaled = upscale_scatter_2x_float(in_right);
    in_uscaled = upscale_scatter_2x_float2(in);

    /* Calculate horizontal Gaussian filter for line 1 */
    out_line_1 = gauss_filter_1D_5x5_float4((float4)(in_left_uscaled.s01, in_uscaled.s01),
                                            (float4)(in_left_uscaled.s1,  in_uscaled.s012),
                                                     in_uscaled,
                                            (float4)(in_uscaled.s123, in_right_uscaled.s0),
                                            (float4)(in_uscaled.s23, in_right_uscaled.s01));

    /* Load inputs for line 2 */
    in_left = convert_float(*(line_2 - CEIL_DIV(GAUSS_FILTER_RADIUS, LUMA_PYR_UP_SCALE_FACTOR)));
    in_right = convert_float(*(line_2 + LUMA_PYR_UP_KERNEL_PREV_SIZE_X));
    in = convert_float2(*((__local uchar2 *)line_2));

    /* Upscale line 2 */
    in_left_uscaled = upscale_scatter_2x_float(in_left);
    in_right_uscaled = upscale_scatter_2x_float(in_right);
    in_uscaled = upscale_scatter_2x_float2(in);

    /* Calculate horizontal Gaussian filter for line 2 */
    out_line_2 = gauss_filter_1D_5x5_float4((float4)(in_left_uscaled.s01, in_uscaled.s01),
                                            (float4)(in_left_uscaled.s1,  in_uscaled.s012),
                                                     in_uscaled,
                                            (float4)(in_uscaled.s123, in_right_uscaled.s0),
                                            (float4)(in_uscaled.s23, in_right_uscaled.s01));

    /* Calculate Gaussian filter for 2 output lines */
    /* Output line 0 */
    *out_0 = gauss_filter_1D_5x5_float4(out_line_0, 0.0f, out_line_1, 0.0f, out_line_2);
    *out_0 = *out_0 / GAUSS_FILTER_SCATTER_DIV;
    /* Output line 1 */
    *out_1 = gauss_filter_1D_5x5_float4(0.0f, out_line_1, 0.0f, out_line_2, 0.0f);
    *out_1 = *out_1 / GAUSS_FILTER_SCATTER_DIV;
}

/** @brief Lumaproc pyramid reconstruction kernel with 5x5 gaussian filter
 *
 * @param[in] input_meV pointer to under-exposed input pyramid level plane
 * @param[in] input_0eV pointer to base input pyramid level plane
 * @param[in] input_peV pointer to over-exposed input pyramid level plane
 * @param[in] input_meV pointer to under-exposed input pyramid previous level plane
 * @param[in] input_0eV pointer to base input pyramid previous level plane
 * @param[in] input_peV pointer to over-exposed input pyramid previous level plane
 * @param[out] output pointer to output pyramid level plane
 * @param[in] output_prev pointer to output pyramid previous level plane
 * @param[in] width pyramid level width
 * @param[in] height pyramid level height
 * @param[in] prev_width pyramid previous level width
 * @param[in] prev_height pyramid previous level height
 * @param[in] input_stride input pyramid level stride
 * @param[in] input_offset input pyramid level offset
 * @param[in] input_prev_stride input pyramid previous level stride
 * @param[in] input_prev_offset input pyramid previous level offset
 * @param[in] output_stride output pyramid level stride
 * @param[in] output_offset output pyramid level offset
 * @param[in] output_prev_stride output pyramid previous level stride
 * @param[in] output_prev_offset output pyramid previous level offset
 * @param[in] luma_thr_low_meV low threshold for under-exposed frame weight curve
 * @param[in] luma_thr_high_meV high threshold for under-exposed frame weight curve
 * @param[in] weight_thr_low_meV weight value at low threshold for under-exposed frame weight curve
 * @param[in] weight_thr_high_meV weight value at threshold for under-exposed frame weight curve
 * @param[in] luma_thr_low_0eV low threshold for base frame weight curve
 * @param[in] luma_thr_high_0eV high threshold for base frame weight curve
 * @param[in] weight_thr_low_0eV weight value at low threshold for base frame weight curve
 * @param[in] weight_thr_high_0eV weight value at threshold for base frame weight curve
 * @param[in] sharp_strength sharpening strength for current laplacian pyramid level
 *
 * Function calculates laplacian pyramid levels, blends them and reconstructs gaussian pyramid level.
 */
__kernel void luma_pyr_up_5x5 (__global uchar *input_meV, __global uchar *input_0eV, __global uchar *input_peV,
                               __global uchar *input_prev_meV, __global uchar *input_prev_0eV, __global uchar *input_prev_peV,
                               __global uchar *output, __global uchar *output_prev,
                               int width, int height, int prev_width, int prev_height,
                               int input_stride, int input_offset, int input_prev_stride, int input_prev_offset,
                               int output_stride, int output_offset, int output_prev_stride, int output_prev_offset,
                               float luma_thr_low_meV, float luma_thr_high_meV, float weight_thr_low_meV, float weight_thr_high_meV,
                               float luma_thr_low_0eV, float luma_thr_high_0eV, float weight_thr_low_0eV, float weight_thr_high_0eV,
                               float sharp_strength)
{
    int x_global = get_global_id(0);
    int y_global = get_global_id(1);
    int x_prev = LUMA_PYR_UP_KERNEL_PREV_SIZE_X * x_global;
    int y_prev = LUMA_PYR_UP_KERNEL_PREV_SIZE_Y * y_global;
    int x_curr = LUMA_PYR_UP_KERNEL_CURR_SIZE_X * x_global;
    int y_curr = LUMA_PYR_UP_KERNEL_CURR_SIZE_Y * y_global;
    int x_loc = get_local_id(0);
    int kernel_size_y = (y_global == ((int)get_global_size(1) - 1)) ?
                         prev_height % LUMA_PYR_UP_KERNEL_PREV_SIZE_Y : LUMA_PYR_UP_KERNEL_PREV_SIZE_Y;

    /* Handle the case where height is multiple of LUMA_PYR_DOWN_KERNEL_OUT_SIZE_Y */
    if (kernel_size_y == 0) {
        kernel_size_y = LUMA_PYR_UP_KERNEL_PREV_SIZE_Y;
    }

    /* Border flags */
    int x_gt_0 = (x_prev > 0) ? 1 : 0;
    int x_lt_w_m_ksx = (x_prev < (prev_width - LUMA_PYR_UP_KERNEL_HOR_OVERLAP)) ? 1 : 0;
    int x_lt_w = (x_curr < width) ? 1 : 0;

    /* Horizontal padding flags */
    int pad_left  = (x_loc == 0) && (x_gt_0 == 0);
    int pad_right = (x_global == (prev_width - 1) / LUMA_PYR_UP_KERNEL_PREV_SIZE_X);

    /* Global memory offsets */
    int input_prev_line_offset = (y_prev + ((y_prev > 0) ? -LUMA_PYR_UP_KERNEL_VER_OVERLAP : 0)) * input_prev_stride +
                               x_prev + input_prev_offset;
    int output_prev_line_offset = (y_prev + ((y_prev > 0) ? -LUMA_PYR_UP_KERNEL_VER_OVERLAP : 0)) * output_prev_stride
                                   + x_prev + output_prev_offset;
    int input_curr_line_offset = y_curr * input_stride + x_curr + input_offset;
    int output_curr_line_offset = y_curr * output_stride + x_curr + output_offset;

    /* Local memory buffers */
    __local uchar input_prev_meV_buffer[LUMA_PYR_UP_INPUT_BUF_SIZE];
    __local uchar input_prev_0eV_buffer[LUMA_PYR_UP_INPUT_BUF_SIZE];
    __local uchar input_prev_peV_buffer[LUMA_PYR_UP_INPUT_BUF_SIZE];
    __local uchar output_prev_buffer[LUMA_PYR_UP_INPUT_BUF_SIZE];
    int curr_offset = x_loc * LUMA_PYR_UP_KERNEL_PREV_SIZE_X + LUMA_PYR_UP_KERNEL_HOR_OVERLAP;
    /* Pointers to current line in local memory buffer */
    __local uchar *buff_ptr;
    __local uchar2 *buff_ptr2;
    /* Pointers to input lines for Gaussian filter */
    __local uchar *buff_line_0_ptr;
    __local uchar *buff_line_1_ptr;
    __local uchar *buff_line_2_ptr;
    int buff_line_0_offset = curr_offset;
    int buff_line_1_offset = curr_offset + LUMA_PYR_UP_INPUT_BUF_WIDTH;
    int buff_line_2_offset = curr_offset + 2 * LUMA_PYR_UP_INPUT_BUF_WIDTH;

    /* Process kernel_size_y lines and store results to global memory */
    for (int line = 0; line < kernel_size_y + LUMA_PYR_UP_GAUSS_DELAY; line++) {
        int pad_line;
        int line_inc;

        /* Border flag */
        int y_lt_h_m_1 = (y_curr + LUMA_PYR_UP_SCALE_FACTOR * (line - LUMA_PYR_UP_GAUSS_DELAY) < height - 1) ? 1 : 0;

        /* Ensure that all work items have finished reading from local memory */
        barrier(CLK_LOCAL_MEM_FENCE);

        /* Read stripe line for previous pyramid levels from global to local memory buffer */
        /* Each work-item reads line of 8 pixels from global memory, except first and last that reads 16 pixels */
        /* Read under-exposed frame */
        buff_ptr  = (__local uchar *)input_prev_meV_buffer + curr_offset;
        buff_ptr2 = (__local uchar2 *)buff_ptr;
        if (x_loc == 0 && x_gt_0 != 0) {
            *(buff_ptr2 - 1) = vload2((input_prev_line_offset / LUMA_PYR_UP_KERNEL_PREV_SIZE_X) - 1,
                                      (__global uchar *)(input_prev_meV));

        }
        if (x_lt_w != 0) {
            *(buff_ptr2) = vload2((input_prev_line_offset / LUMA_PYR_UP_KERNEL_PREV_SIZE_X),
                                  (__global uchar *)(input_prev_meV));
        }
        if ((x_loc == LUMA_PYR_UP_LOC_GROUP_SIZE_X - 1) && (x_lt_w_m_ksx != 0)) {
            *(buff_ptr2 + 1) = vload2((input_prev_line_offset / LUMA_PYR_UP_KERNEL_PREV_SIZE_X) + 1,
                                      (__global uchar *)(input_prev_meV));
        }
        /* Pad under-exposed frame */
        /* Pad left horizontal border */
        if (pad_left != 0) {
            uchar pad_val = *buff_ptr;
            *(buff_ptr - 1) = pad_val;
        }
        /* Pad right horizontal border */
        if (pad_right != 0) {
            int pad_offset = prev_width - x_prev;
            uchar pad_val = *(buff_ptr + pad_offset - 1);
            *(buff_ptr + pad_offset) = pad_val;
        }

        /* Read base frame */
        buff_ptr  = (__local uchar *)input_prev_0eV_buffer + curr_offset;
        buff_ptr2 = (__local uchar2 *)buff_ptr;
        if (x_loc == 0 && x_gt_0 != 0) {
            *(buff_ptr2 - 1) = vload2((input_prev_line_offset / LUMA_PYR_UP_KERNEL_PREV_SIZE_X) - 1,
                                      (__global uchar *)(input_prev_0eV));

        }
        if (x_lt_w != 0) {
            *(buff_ptr2) = vload2((input_prev_line_offset / LUMA_PYR_UP_KERNEL_PREV_SIZE_X),
                                  (__global uchar *)(input_prev_0eV));
        }
        if ((x_loc == LUMA_PYR_UP_LOC_GROUP_SIZE_X - 1) && (x_lt_w_m_ksx != 0)) {
            *(buff_ptr2 + 1) = vload2((input_prev_line_offset / LUMA_PYR_UP_KERNEL_PREV_SIZE_X) + 1,
                                      (__global uchar *)(input_prev_0eV));
        }
        /* Pad base frame */
        /* Pad left horizontal border */
        if (pad_left != 0) {
            uchar pad_val = *buff_ptr;
            *(buff_ptr - 1) = pad_val;
        }
        /* Pad right horizontal border */
        if (pad_right != 0) {
            int pad_offset = prev_width - x_prev;
            uchar pad_val = *(buff_ptr + pad_offset - 1);
            *(buff_ptr + pad_offset) = pad_val;
        }

        /* Read over-exposed frame */
        buff_ptr  = (__local uchar *)input_prev_peV_buffer + curr_offset;
        buff_ptr2 = (__local uchar2 *)buff_ptr;
        if (x_loc == 0 && x_gt_0 != 0) {
            *(buff_ptr2 - 1) = vload2((input_prev_line_offset / LUMA_PYR_UP_KERNEL_PREV_SIZE_X) - 1,
                                      (__global uchar *)(input_prev_peV));

        }
        if (x_lt_w != 0) {
            *(buff_ptr2) = vload2((input_prev_line_offset / LUMA_PYR_UP_KERNEL_PREV_SIZE_X),
                                  (__global uchar *)(input_prev_peV));
        }
        if ((x_loc == LUMA_PYR_UP_LOC_GROUP_SIZE_X - 1) && (x_lt_w_m_ksx != 0)) {
            *(buff_ptr2 + 1) = vload2((input_prev_line_offset / LUMA_PYR_UP_KERNEL_PREV_SIZE_X) + 1,
                                      (__global uchar *)(input_prev_peV));
        }
        /* Pad over-exposed frame */
        /* Pad left horizontal border */
        if (pad_left != 0) {
            uchar pad_val = *buff_ptr;
            *(buff_ptr - 1) = pad_val;
        }
        /* Pad right horizontal border */
        if (pad_right != 0) {
            int pad_offset = prev_width - x_prev;
            uchar pad_val = *(buff_ptr + pad_offset - 1);
            *(buff_ptr + pad_offset) = pad_val;
        }

        /* Read output frame */
        buff_ptr  = (__local uchar *)output_prev_buffer + curr_offset;
        buff_ptr2 = (__local uchar2 *)buff_ptr;
        if (x_loc == 0 && x_gt_0 != 0) {
            *(buff_ptr2 - 1) = vload2((output_prev_line_offset / LUMA_PYR_UP_KERNEL_PREV_SIZE_X) - 1,
                                      (__global uchar *)(output_prev));

        }
        if (x_lt_w != 0) {
            *(buff_ptr2) = vload2((output_prev_line_offset / LUMA_PYR_UP_KERNEL_PREV_SIZE_X),
                                  (__global uchar *)(output_prev));
        }
        if ((x_loc == LUMA_PYR_UP_LOC_GROUP_SIZE_X - 1) && (x_lt_w_m_ksx != 0)) {
            *(buff_ptr2 + 1) = vload2((output_prev_line_offset / LUMA_PYR_UP_KERNEL_PREV_SIZE_X) + 1,
                                      (__global uchar *)(output_prev));
        }
        /* Pad over-exposed frame */
        /* Pad left horizontal border */
        if (pad_left != 0) {
            uchar pad_val = *buff_ptr;
            *(buff_ptr - 1) = pad_val;
        }
        /* Pad right horizontal border */
        if (pad_right != 0) {
            int pad_offset = prev_width - x_prev;
            uchar pad_val = *(buff_ptr + pad_offset - 1);
            *(buff_ptr + pad_offset) = pad_val;
        }

        /* Ensure that all work items have finished writing into local memory */
        barrier(CLK_LOCAL_MEM_FENCE);

        /* Calculate output data after enough input lines is fetched */
        if (line >= LUMA_PYR_UP_GAUSS_DELAY)
        {
            float4 input_meV_0, input_meV_1;
            float4 input_0eV_0, input_0eV_1;
            float4 input_peV_0, input_peV_1;
            float4 weight_meV_0, weight_meV_1;
            float4 weight_0eV_0, weight_0eV_1;
            float4 weight_peV_0, weight_peV_1;
            float4 input_meV_uscaled_0, input_meV_uscaled_1;
            float4 input_0eV_uscaled_0, input_0eV_uscaled_1;
            float4 input_peV_uscaled_0, input_peV_uscaled_1;
            float4 output_0, output_1;
            float4 output_uscaled_0, output_uscaled_1;

            if (x_lt_w != 0) {
                /* Load first line of current input pyramid level */
                input_meV_0 = convert_float4(vload4(input_curr_line_offset / LUMA_PYR_UP_KERNEL_CURR_SIZE_X,
                                                      (__global uchar *)(input_meV)));
                input_0eV_0 = convert_float4(vload4(input_curr_line_offset / LUMA_PYR_UP_KERNEL_CURR_SIZE_X,
                                                      (__global uchar *)(input_0eV)));
                input_peV_0 = convert_float4(vload4(input_curr_line_offset / LUMA_PYR_UP_KERNEL_CURR_SIZE_X,
                                                      (__global uchar *)(input_peV)));
                if (y_lt_h_m_1 != 0) {
                    int input_next_curr_line_offset = input_curr_line_offset + input_stride;
                    /* Load second line of current input pyramid level */
                    input_meV_1 = convert_float4(vload4(input_next_curr_line_offset / LUMA_PYR_UP_KERNEL_CURR_SIZE_X,
                                                          (__global uchar *)(input_meV)));
                    input_0eV_1 = convert_float4(vload4(input_next_curr_line_offset / LUMA_PYR_UP_KERNEL_CURR_SIZE_X,
                                                          (__global uchar *)(input_0eV)));
                    input_peV_1 = convert_float4(vload4(input_next_curr_line_offset / LUMA_PYR_UP_KERNEL_CURR_SIZE_X,
                                                          (__global uchar *)(input_peV)));
                }
            }
            /* Apply soft threshold function */
            /* Line 0 */
            weight_meV_0 = soft_threshold(input_meV_0,
                                        luma_thr_low_meV, luma_thr_high_meV, weight_thr_low_meV, weight_thr_high_meV);
            weight_0eV_0 = soft_threshold(input_0eV_0,
                                        luma_thr_low_0eV, luma_thr_high_0eV, weight_thr_low_0eV, weight_thr_high_0eV);
            /* Line 1 */
            weight_meV_1 = soft_threshold(input_meV_1,
                                        luma_thr_low_meV, luma_thr_high_meV, weight_thr_low_meV, weight_thr_high_meV);
            weight_0eV_1 = soft_threshold(input_0eV_1,
                                        luma_thr_low_0eV, luma_thr_high_0eV, weight_thr_low_0eV, weight_thr_high_0eV);

            /* Calculate weights */
            /* Line 0 */
            weight_peV_0 = 1.0f - weight_0eV_0;
            weight_0eV_0 = weight_0eV_0 * (1.0f - weight_meV_0);
            /* Line 1 */
            weight_peV_1 = 1.0f - weight_0eV_1;
            weight_0eV_1 = weight_0eV_1 * (1.0f - weight_meV_1);

            /* Upscale and filter previous levels */
            /* Under-exposed frame */
            buff_line_0_ptr = (__local uchar *)input_prev_meV_buffer + buff_line_0_offset;
            buff_line_1_ptr = (__local uchar *)input_prev_meV_buffer + buff_line_1_offset;
            buff_line_2_ptr = (__local uchar *)input_prev_meV_buffer + buff_line_2_offset;
            gauss_pyr_up_5x5(buff_line_0_ptr, buff_line_1_ptr, buff_line_2_ptr,
                             &input_meV_uscaled_0, &input_meV_uscaled_1);
            /* Base frame */
            buff_line_0_ptr = (__local uchar *)input_prev_0eV_buffer + buff_line_0_offset;
            buff_line_1_ptr = (__local uchar *)input_prev_0eV_buffer + buff_line_1_offset;
            buff_line_2_ptr = (__local uchar *)input_prev_0eV_buffer + buff_line_2_offset;
            gauss_pyr_up_5x5(buff_line_0_ptr, buff_line_1_ptr, buff_line_2_ptr,
                             &input_0eV_uscaled_0, &input_0eV_uscaled_1);
            /* Over-exposed frame */
            buff_line_0_ptr = (__local uchar *)input_prev_peV_buffer + buff_line_0_offset;
            buff_line_1_ptr = (__local uchar *)input_prev_peV_buffer + buff_line_1_offset;
            buff_line_2_ptr = (__local uchar *)input_prev_peV_buffer + buff_line_2_offset;
            gauss_pyr_up_5x5(buff_line_0_ptr, buff_line_1_ptr, buff_line_2_ptr,
                             &input_peV_uscaled_0, &input_peV_uscaled_1);
            /* Output frame */
            buff_line_0_ptr = (__local uchar *)output_prev_buffer + buff_line_0_offset;
            buff_line_1_ptr = (__local uchar *)output_prev_buffer + buff_line_1_offset;
            buff_line_2_ptr = (__local uchar *)output_prev_buffer + buff_line_2_offset;
            gauss_pyr_up_5x5(buff_line_0_ptr, buff_line_1_ptr, buff_line_2_ptr,
                             &output_uscaled_0, &output_uscaled_1);

            /* Calculate Laplace layer */
            /* Line 0 */
            input_meV_0 -= input_meV_uscaled_0;
            input_0eV_0 -= input_0eV_uscaled_0;
            input_peV_0 -= input_peV_uscaled_0;
            /* Line 1 */
            input_meV_1 -= input_meV_uscaled_1;
            input_0eV_1 -= input_0eV_uscaled_1;
            input_peV_1 -= input_peV_uscaled_1;

            /* Blend Laplace layer */
            /* Line 0 */
            output_0 = weight_meV_0 * input_meV_0;
            output_0 = mad(weight_0eV_0, input_0eV_0, output_0);
            output_0 = mad(weight_peV_0, input_peV_0, output_0);
            /* Line 1 */
            output_1 = weight_meV_1 * input_meV_1;
            output_1 = mad(weight_0eV_1, input_0eV_1, output_1);
            output_1 = mad(weight_peV_1, input_peV_1, output_1);

            /* Apply sharpening */
            /* Line 0 */
            output_0 *= sharp_strength;
            /* Line 1 */
            output_1 *= sharp_strength;

            /* Reconstruct output Gaussian pyramid level */
            /* Line 0 */
            output_0 += output_uscaled_0;
            /* Line 1 */
            output_1 += output_uscaled_1;

            if (x_lt_w != 0) {
                /* Store line 0 of output pyramid level */
                vstore4(convert_uchar4_sat_rte(output_0), output_curr_line_offset / LUMA_PYR_UP_KERNEL_CURR_SIZE_X,
                        (__global uchar *)(output));
                if (y_lt_h_m_1 != 0) {
                    int output_next_curr_line_offset = output_curr_line_offset + output_stride;
                    /* Store line 1 of output pyramid level */
                    vstore4(convert_uchar4_sat_rte(output_1),
                             output_next_curr_line_offset / LUMA_PYR_UP_KERNEL_CURR_SIZE_X,
                             (__global uchar *)(output));
                }
            }

            /* Update line offsets for Gaussian filter */
            buff_line_0_offset = buff_line_1_offset;
            buff_line_1_offset = buff_line_2_offset;
            buff_line_2_offset = (buff_line_2_offset + LUMA_PYR_UP_INPUT_BUF_WIDTH) % LUMA_PYR_UP_INPUT_BUF_SIZE;

            /* Update offset of global memory buffer pointers */
            input_curr_line_offset += LUMA_PYR_UP_SCALE_FACTOR * input_stride;
            output_curr_line_offset += LUMA_PYR_UP_SCALE_FACTOR * output_stride;
        }

        /* Update offset of local memory input buffer pointers */
        curr_offset = (curr_offset + LUMA_PYR_UP_INPUT_BUF_WIDTH) % LUMA_PYR_UP_INPUT_BUF_SIZE;

        /* Update pointers to global input memory buffer */
        /* Pad vertical border if input line is out of bounds */
        pad_line = ((y_prev + line - LUMA_PYR_UP_KERNEL_VER_OVERLAP) < 0) ||
                   ((y_prev + line - LUMA_PYR_UP_KERNEL_VER_OVERLAP) > prev_height - 2);
        line_inc = (pad_line == 0) ? 1 : 0;
        input_prev_line_offset += line_inc * input_prev_stride;
        output_prev_line_offset += line_inc * output_prev_stride;
    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
