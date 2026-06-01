int CLAMP(int val,int lo,int hi)
{
    return (val < lo) ? lo : ((hi < val) ? hi : val);
}

float4 get_pixel_color_CL(const __global float4 *in_buf,
                          int     rect_width,
                          int     rect_height,
                          int     rect_x,
                          int     rect_y,
                          int     x,
                          int     y)
{
    int ix = x - rect_x;
    int iy = y - rect_y;

    ix = CLAMP(ix, 0, rect_width-1);
    iy = CLAMP(iy, 0, rect_height-1);

    return in_buf[iy * rect_width + ix];
}

__kernel void motion_blur_CL(const __global float4 *src_buf,
                             int     src_width,
                             int     src_height,
                             int     src_x,
                             int     src_y,
                             __global float4 *dst_buf,
                             int     dst_x,
                             int     dst_y,
                             int     num_steps,
                             float   offset_x,
                             float   offset_y)
{
    int gidx = get_global_id(0);
    int gidy = get_global_id(1);

    float4 sum = 0.0f;
    int px = gidx + dst_x;
    int py = gidy + dst_y;

    for(int step = 0; step < num_steps; ++step)
    {
        float t = num_steps == 1 ? 0.0f :
            step / (float)(num_steps - 1) - 0.5f;

        float xx = px + t * offset_x;
        float yy = py + t * offset_y;

        int   ix = (int)floor(xx);
        int   iy = (int)floor(yy);

        float dx = xx - floor(xx);
        float dy = yy - floor(yy);

        float4 mixy0,mixy1,pix0,pix1,pix2,pix3;

        pix0 = get_pixel_color_CL(src_buf, src_width,
            src_height, src_x, src_y, ix,   iy);
        pix1 = get_pixel_color_CL(src_buf, src_width,
            src_height, src_x, src_y, ix+1, iy);
        pix2 = get_pixel_color_CL(src_buf, src_width,
            src_height, src_x, src_y, ix,   iy+1);
        pix3 = get_pixel_color_CL(src_buf, src_width,
            src_height, src_x, src_y, ix+1, iy+1);

        mixy0 = dy * (pix2 - pix0) + pix0;
        mixy1 = dy * (pix3 - pix1) + pix1;

        sum  += dx * (mixy1 - mixy0) + mixy0;
    }

    dst_buf[gidy * get_global_size(0) + gidx] =
        sum / num_steps;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
