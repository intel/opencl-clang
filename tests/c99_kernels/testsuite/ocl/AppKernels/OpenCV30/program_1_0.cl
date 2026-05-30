#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
__kernel void convertC3C4(__global const GENTYPE4 * restrict src, __global GENTYPE4 *dst,
int cols, int rows,
int dstStep_in_piexl, int pixel_end)
{
int id = get_global_id(0);
int3 pixelid = (int3)(mul24(id,3),mad24(id,3,1),mad24(id,3,2));
pixelid = clamp(pixelid,0,pixel_end);
GENTYPE4 pixel0, pixel1, pixel2, outpix0,outpix1,outpix2,outpix3;
pixel0 = src[pixelid.x];
pixel1 = src[pixelid.y];
pixel2 = src[pixelid.z];
outpix0 = (GENTYPE4)(pixel0.x,pixel0.y,pixel0.z,0);
outpix1 = (GENTYPE4)(pixel0.w,pixel1.x,pixel1.y,0);
outpix2 = (GENTYPE4)(pixel1.z,pixel1.w,pixel2.x,0);
outpix3 = (GENTYPE4)(pixel2.y,pixel2.z,pixel2.w,0);
int4 outy = (id<<2)/cols;
int4 outx = (id<<2)%cols;
outx += (int4)(0, 1, 2, 3);
outy = select(outy, outy+1, outx>=cols);
outx = select(outx, outx-cols, outx>=cols);
outy = select(outy, outy + 1, outx >= cols);
outx = select(outx, outx-cols, outx >= cols);
outy = select(outy, outy + 1, outx >= cols);
outx = select(outx, outx-cols, outx >= cols);
int4 addr = mad24(outy,(int4)dstStep_in_piexl,outx);
if(outx.w<cols && outy.w<rows)
{
dst[addr.x] = outpix0;
dst[addr.y] = outpix1;
dst[addr.z] = outpix2;
dst[addr.w] = outpix3;
}
else if(outx.z<cols && outy.z<rows)
{
dst[addr.x] = outpix0;
dst[addr.y] = outpix1;
dst[addr.z] = outpix2;
}
else if(outx.y<cols && outy.y<rows)
{
dst[addr.x] = outpix0;
dst[addr.y] = outpix1;
}
else if(outx.x<cols && outy.x<rows)
dst[addr.x] = outpix0;
}
__kernel void convertC4C3(__global const GENTYPE4 * restrict src, __global GENTYPE4 *dst,
int cols, int rows,
int srcStep_in_pixel, int pixel_end)
{
int id = get_global_id(0)<<2;
int y = id / cols;
int x = id % cols;
int4 x4 = (int4)(x,x+1,x+2,x+3);
int4 y4 = select((int4)y,(int4)(y+1),x4>=(int4)cols);
x4 = select(x4,x4-(int4)cols,x4>=(int4)cols);
y4 = select(y4, y4 + 1,x4>=(int4)cols);
x4 = select(x4, x4 - (int4)cols,x4>=(int4)cols);
y4 = select(y4, y4 + 1,x4>=(int4)cols);
x4 = select(x4, x4-(int4)cols,x4>=(int4)cols);
y4=clamp(y4,(int4)0,(int4)(rows-1));
int4 addr = mad24(y4, (int4)srcStep_in_pixel, x4);
GENTYPE4 pixel0,pixel1,pixel2,pixel3, outpixel1, outpixel2;
pixel0 = src[addr.x];
pixel1 = src[addr.y];
pixel2 = src[addr.z];
pixel3 = src[addr.w];
pixel0.w = pixel1.x;
outpixel1.x = pixel1.y;
outpixel1.y = pixel1.z;
outpixel1.z = pixel2.x;
outpixel1.w = pixel2.y;
outpixel2.x = pixel2.z;
outpixel2.y = pixel3.x;
outpixel2.z = pixel3.y;
outpixel2.w = pixel3.z;
int4 outaddr = mul24(id>>2 , 3);
outaddr.y++;
outaddr.z+=2;
if(outaddr.z <= pixel_end)
{
dst[outaddr.x] = pixel0;
dst[outaddr.y] = outpixel1;
dst[outaddr.z] = outpixel2;
}
else if(outaddr.y <= pixel_end)
{
dst[outaddr.x] = pixel0;
dst[outaddr.y] = outpixel1;
}
else if(outaddr.x <= pixel_end)
dst[outaddr.x] = pixel0;
}


// buildOptions=-D INTEL_DEVICE -D GENTYPE4=uchar4
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D INTEL_DEVICE -D GENTYPE4=uchar4" %cfg_path --cl-device=%cl_device 2>&1
