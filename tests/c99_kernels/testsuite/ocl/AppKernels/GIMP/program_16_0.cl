#define NEIGHBOURS 8
#define AXES       (NEIGHBOURS/2)

#define POW2(a) ((a)*(a))

#define GEN_METRIC(before, center, after) POW2((center) * 2 - (before) - (after))

#define BAIL_CONDITION(new,original) ((new) < (original))

#define SYMMETRY(a)  (NEIGHBOURS - (a) - 1)

#define O(u,v) (((u)+((v) * (src_stride))))

__kernel void noise_reduction_cl (__global       float4 *src_buf,
                                  int src_stride,
                                  __global       float4 *dst_buf,
                                  int dst_stride)
{
    int gidx = get_global_id(0);
    int gidy = get_global_id(1);

    __global float4 *center_pix = src_buf + (gidy + 1) * src_stride + gidx + 1;
    int dst_offset = dst_stride * gidy + gidx;

    int offsets[NEIGHBOURS] = {
        O(-1, -1), O( 0, -1), O( 1, -1),
        O(-1,  0),            O( 1,  0),
        O(-1,  1), O( 0,  1), O( 1,  1)
    };

    float4 sum;
    int4   count;
    float4 cur;
    float4 metric_reference[AXES];

    for (int axis = 0; axis < AXES; axis++)
      {
        float4 before_pix = *(center_pix + offsets[axis]);
        float4 after_pix  = *(center_pix + offsets[SYMMETRY(axis)]);
        metric_reference[axis] = GEN_METRIC (before_pix, *center_pix, after_pix);
      }

    cur = sum = *center_pix;
    count = 1;

    for (int direction = 0; direction < NEIGHBOURS; direction++)
      {
        float4 pix   = *(center_pix + offsets[direction]);
        float4 value = (pix + cur) * (0.5f);
        int    axis;
        int4   mask = {1, 1, 1, 0};

        for (axis = 0; axis < AXES; axis++)
          {
            float4 before_pix = *(center_pix + offsets[axis]);
            float4 after_pix  = *(center_pix + offsets[SYMMETRY(axis)]);

            float4 metric_new = GEN_METRIC (before_pix,
                                            value,
                                            after_pix);
            mask = BAIL_CONDITION (metric_new, metric_reference[axis]) & mask;
          }
        sum   += mask >0 ? value : 0;
        count += mask >0 ? 1     : 0;
      }
    dst_buf[dst_offset]   = (sum/convert_float4(count));
    dst_buf[dst_offset].w = cur.w;
}
__kernel void transfer(__global float4 * in,
              int               in_width,
              __global float4 * out)
{
    int gidx = get_global_id(0);
    int gidy = get_global_id(1);
    int width = get_global_size(0);
    out[gidy * width + gidx] = in[gidy * in_width + gidx];
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
