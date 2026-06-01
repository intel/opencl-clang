#define SMEM(X, Y) sdata[(Y)*tilew+(X)]
int iclamp(int x, int a, int b)
{
    return max(a, min(b, x));
}
uint rgbToInt(float r, float g, float b)
{
  r = clamp(r, 0.0f, 255.0f);
  g = clamp(g, 0.0f, 255.0f);
  b = clamp(b, 0.0f, 255.0f);
  return (convert_uint(b)<<16) + (convert_uint(g)<<8) + convert_uint(r);
}
uint getPixel(__global unsigned int *data, int x, int y, int width, int height)
{
    x = iclamp(x, 0, width-1);
    y = iclamp(y, 0, height-1);
    return data[y*width+x];
}
__kernel void post_fx_kernel_global_mem(__global unsigned int* g_data, __global unsigned int* g_odata, int imgw, int imgh, int tilew, int radius, float threshold, float highlight)
{
    const int x = get_global_id(0);
    const int y = get_global_id(1);
    if (x >= imgw || y >= imgh)
      return;
    const int tx = get_local_id(0);
    const int ty = get_local_id(1);
    const int bw = get_local_size(0);
    const int bh = get_local_size(1);
     float rsum = .0f;
     float gsum = 0.0f;
     float bsum = 0.0f;
     float samples = 0.0f;
    for(int iy=0; iy<=radius+radius+1; iy++)
    {
       for(int ix=0; ix<=radius+radius+1; ix++)
      {
           int dx = ix - radius;
           int dy = iy - radius;
            uint pixel = getPixel(g_data, x+dx, y+dy, imgw, imgh);
            float l = dx*dx + dy*dy;
            if (l <= radius*radius)
            {
                float r = convert_float(pixel&0x0ff);
                float g = convert_float((pixel>>8)&0x0ff);
                float b = convert_float((pixel>>16)&0x0ff);
               float lum = (r + g + b) / (255*3);
               if (lum > threshold)
               {
                 r *= highlight;
                 g *= highlight;
                 b *= highlight;
               }
               rsum += r;
               gsum += g;
               bsum += b;
               samples += 1.0f;
            }
        }
    }
     rsum /= samples;
     gsum /= samples;
     bsum /= samples;
    g_odata[y*imgw+x] = rgbToInt(rsum, gsum, bsum);
}__kernel void post_fx_kernel_local_mem(__global unsigned int* g_data, __global unsigned int* g_odata, int imgw, int imgh, int tilew, int radius, float threshold, float highlight, __local unsigned int* sdata)
{
    const int x = get_global_id(0);
    const int y = get_global_id(1);
    if (x >= imgw || y >= imgh)
      return;
    const int tx = get_local_id(0);
    const int ty = get_local_id(1);
    const int bw = get_local_size(0);
    const int bh = get_local_size(1);
    SMEM(radius + tx, radius + ty) = getPixel(g_data, x, y, imgw, imgh);
    if (tx < radius) {
        SMEM(tx, radius + ty) = getPixel(g_data, x - radius, y, imgw, imgh);
        SMEM(radius + bw + tx, radius + ty) = getPixel(g_data, x + bw, y, imgw, imgh);
    }
    if (ty < radius) {
        SMEM(radius + tx, ty) = getPixel(g_data, x, y - radius, imgw, imgh);
        SMEM(radius + tx, radius + bh + ty) = getPixel(g_data, x, y + bh, imgw, imgh);
    }
    if ((tx < radius) && (ty < radius)) {
        SMEM(tx, ty) = getPixel(g_data, x - radius, y - radius, imgw, imgh);
        SMEM(tx, radius + bh + ty) = getPixel(g_data, x - radius, y + bh, imgw, imgh);
        SMEM(radius + bw + tx, ty) = getPixel(g_data, x + bh, y - radius, imgw, imgh);
        SMEM(radius + bw + tx, radius + bh + ty) = getPixel(g_data, x + bw, y + bh, imgw, imgh);
    }
    barrier(CLK_LOCAL_MEM_FENCE);
     float rsum = .0f;
     float gsum = 0.0f;
     float bsum = 0.0f;
     float samples = 0.0f;
    for(int iy=0; iy<=radius+radius+1; iy++)
    {
       for(int ix=0; ix<=radius+radius+1; ix++)
      {
           int dx = ix - radius;
           int dy = iy - radius;
            uint pixel = SMEM(radius+tx+dx, radius+ty+dy);
            float l = dx*dx + dy*dy;
            if (l <= radius*radius)
            {
                float r = convert_float(pixel&0x0ff);
                float g = convert_float((pixel>>8)&0x0ff);
                float b = convert_float((pixel>>16)&0x0ff);
               float lum = (r + g + b) * 0.001307189542f;// /(255*3);
               if (lum > threshold)
               {
                 r *= highlight;
                 g *= highlight;
                 b *= highlight;
               }
               rsum += r;
               gsum += g;
               bsum += b;
               samples += 1.0f;
            }
        }
    }
     rsum /= samples;
     gsum /= samples;
     bsum /= samples;
    g_odata[y*imgw+x] = rgbToInt(rsum, gsum, bsum);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
