__kernel void calc_block_color(__global float4 *in,
                             __global float4 *out,
                             int xsize,
                             int ysize,
                             int roi_x,
                             int roi_y,
                             int line_width,
                             int block_count_x )
{
    int gidx = get_global_id(0);
    int gidy = get_global_id(1);
    int cx = roi_x / xsize + gidx;
    int cy = roi_y / ysize + gidy;

    float weight   = 1.0f / (xsize * ysize);

    int px = cx * xsize + xsize - roi_x;
    int py = cy * ysize + ysize - roi_y;

    int i,j;
    float4 col = 0.0f;
    for (j = py;j < py + ysize; ++j)
    {
        for (i = px;i < px + xsize; ++i)
        {
            col += in[j * line_width + i];
        }
    }
    out[gidy * block_count_x + gidx] = col * weight;

}

__kernel void kernel_pixelise (__global float4 *in,
                             __global float4 *out,
                             int xsize,
                             int ysize,
                             int roi_x,
                             int roi_y,
                             int block_count_x)
{
    int gidx = get_global_id(0);
    int gidy = get_global_id(1);

    int src_width  = get_global_size(0);
    int cx = (gidx + roi_x) / xsize - roi_x / xsize;
    int cy = (gidy + roi_y) / ysize - roi_y / ysize;
    out[gidx + gidy * src_width] = in[cx + cy * block_count_x];
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
