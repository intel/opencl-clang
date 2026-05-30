__kernel void buildWarpPlaneMaps(__global float * xmap, __global float * ymap,
__constant float * KRT,
int tl_u, int tl_v,
int cols, int rows,
int xmap_step, int ymap_step,
int xmap_offset, int ymap_offset,
float scale)
{
int du = get_global_id(0);
int dv = get_global_id(1);
__constant float * ck_rinv = KRT;
__constant float * ct      = KRT + 9;
if (du < cols && dv < rows)
{
int xmap_index = mad24(dv, xmap_step, xmap_offset + du);
int ymap_index = mad24(dv, ymap_step, ymap_offset + du);
float u = tl_u + du;
float v = tl_v + dv;
float x, y;
float x_ = u / scale - ct[0];
float y_ = v / scale - ct[1];
float z;
x = ck_rinv[0] * x_ + ck_rinv[1] * y_ + ck_rinv[2] * (1 - ct[2]);
y = ck_rinv[3] * x_ + ck_rinv[4] * y_ + ck_rinv[5] * (1 - ct[2]);
z = ck_rinv[6] * x_ + ck_rinv[7] * y_ + ck_rinv[8] * (1 - ct[2]);
x /= z;
y /= z;
xmap[xmap_index] = x;
ymap[ymap_index] = y;
}
}
__kernel void buildWarpCylindricalMaps(__global float * xmap, __global float * ymap,
__constant float * ck_rinv,
int tl_u, int tl_v,
int cols, int rows,
int xmap_step, int ymap_step,
int xmap_offset, int ymap_offset,
float scale)
{
int du = get_global_id(0);
int dv = get_global_id(1);
if (du < cols && dv < rows)
{
int xmap_index = mad24(dv, xmap_step, xmap_offset + du);
int ymap_index = mad24(dv, ymap_step, ymap_offset + du);
float u = tl_u + du;
float v = tl_v + dv;
float x, y;
u /= scale;
float x_ = sin(u);
float y_ = v / scale;
float z_ = cos(u);
float z;
x = ck_rinv[0] * x_ + ck_rinv[1] * y_ + ck_rinv[2] * z_;
y = ck_rinv[3] * x_ + ck_rinv[4] * y_ + ck_rinv[5] * z_;
z = ck_rinv[6] * x_ + ck_rinv[7] * y_ + ck_rinv[8] * z_;
if (z > 0) { x /= z; y /= z; }
else x = y = -1;
xmap[xmap_index] = x;
ymap[ymap_index] = y;
}
}
__kernel void buildWarpSphericalMaps(__global float * xmap, __global float * ymap,
__constant float * ck_rinv,
int tl_u, int tl_v,
int cols, int rows,
int xmap_step, int ymap_step,
int xmap_offset, int ymap_offset,
float scale)
{
int du = get_global_id(0);
int dv = get_global_id(1);
if (du < cols && dv < rows)
{
int xmap_index = mad24(dv, xmap_step, xmap_offset + du);
int ymap_index = mad24(dv, ymap_step, ymap_offset + du);
float u = tl_u + du;
float v = tl_v + dv;
float x, y;
v /= scale;
u /= scale;
float sinv = sin(v);
float x_ = sinv * sin(u);
float y_ = - cos(v);
float z_ = sinv * cos(u);
float z;
x = ck_rinv[0] * x_ + ck_rinv[1] * y_ + ck_rinv[2] * z_;
y = ck_rinv[3] * x_ + ck_rinv[4] * y_ + ck_rinv[5] * z_;
z = ck_rinv[6] * x_ + ck_rinv[7] * y_ + ck_rinv[8] * z_;
if (z > 0) { x /= z; y /= z; }
else x = y = -1;
xmap[xmap_index] = x;
ymap[ymap_index] = y;
}
}
__kernel void buildWarpAffineMaps(__global float * xmap, __global float * ymap,
__constant float * c_warpMat,
int cols, int rows,
int xmap_step, int ymap_step,
int xmap_offset, int ymap_offset)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int xmap_index = mad24(y, xmap_step, x + xmap_offset);
int ymap_index = mad24(y, ymap_step, x + ymap_offset);
float xcoo = c_warpMat[0] * x + c_warpMat[1] * y + c_warpMat[2];
float ycoo = c_warpMat[3] * x + c_warpMat[4] * y + c_warpMat[5];
xmap[xmap_index] = xcoo;
ymap[ymap_index] = ycoo;
}
}
__kernel void buildWarpPerspectiveMaps(__global float * xmap, __global float * ymap,
__constant float * c_warpMat,
int cols, int rows,
int xmap_step, int ymap_step,
int xmap_offset, int ymap_offset)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int xmap_index = mad24(y, xmap_step, x + xmap_offset);
int ymap_index = mad24(y, ymap_step, x + ymap_offset);
float coeff = 1.0f / (c_warpMat[6] * x + c_warpMat[7] * y + c_warpMat[8]);
float xcoo = coeff * (c_warpMat[0] * x + c_warpMat[1] * y + c_warpMat[2]);
float ycoo = coeff * (c_warpMat[3] * x + c_warpMat[4] * y + c_warpMat[5]);
xmap[xmap_index] = xcoo;
ymap[ymap_index] = ycoo;
}
}


// buildOptions= -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
