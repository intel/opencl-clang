//The Kernels follows
#define STOCHASTIC__BOUNDARY_CONDITION_WAY_OUTSIDE_LIMIT_FRACTION 0.2f
__constant sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
__constant sampler_t linearsampler = CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_LINEAR;
inline float fast_sqrt (float x)
{
union
{
int i;
float x;
} u;
if (x <= 0)
return 0;
else
{
u.x = x;
u.i = (1<<29) + (u.i >> 1) - (1<<22);
// One Babylonian Step
u.x = 0.5f * (u.x + x/u.x);
return u.x;
}
}
inline float2 safe_normalize(float2 n)
{
const float L2 = (n.x)*(n.x)+(n.y)*(n.y);
if (L2 != 0)
{
const float L=sqrt(L2);
n.x/= L;n.y /= L;
}
else
{
n.x = 1; n.y = 0;
}
return n;
}
typedef   struct
{
float bottom,top,left,right;
}FloatRect;
bool IsInvalid (const FloatRect rect)
{
return (rect.bottom < rect.top) || (rect.right < rect.left);
}
inline FloatRect line_segment_bound (float2 r1, float2 r2)
{
float left = min (r1.x, r2.x);
float top = min (r1.y, r2.y);
float right = max (r1.x, r2.x);
float bottom = max (r1.y, r2.y);
FloatRect r;
r.bottom=bottom;
r.right=right;
r.top=top;
r.left=left;
return r;
}
float2 trajectory (const float t, float2 r0, float2 rm, float2 r1)
{
const float one_minus_t = (float )(1) - t;
const float alpha = one_minus_t * one_minus_t;
const float beta = (float) (2) *( t * one_minus_t);
const float gamma = t * t;
float2 r;
r.x=alpha * r0.x + beta * rm.x + gamma * r1.x;
r.y=alpha * r0.y + beta * rm.y + gamma * r1.y;
return r;
}
FloatRect UnionWith ( FloatRect rect1, FloatRect rect2)
{
if (IsInvalid (rect1));
else if (IsInvalid (rect2))
return rect1;
else
{
rect2.top = min (rect2.top, rect1.top);
rect2.bottom = max (rect2.bottom, rect1.bottom);
rect2.left = min (rect2.left, rect1.left);
rect2.right = max (rect2.right, rect1.right);
}
return rect2;
}
inline FloatRect triangle_bound (float2 r0, float2 r1, float2 r2)
{
float2 r_corner1;
r_corner1.x=min(r0.x, min (r1.x, r2.x));
r_corner1.y=min(r0.y,min(r1.y, r2.y));
float2 r_corner2 ;
r_corner2.x=max(r0.x, max (r1.x, r2.x));
r_corner2.y=max(r0.y, max(r1.y, r2.y));
FloatRect r;
r.bottom=r_corner2.y;
r.right=r_corner2.x;
r.top=r_corner1.y;
r.left=r_corner1.x;
return r;
}
bool isEqual(const float2 r1,const float2 r2)
{
if(r1.x==r2.x&&r1.y==r2.y)
return true;
return false;
}
FloatRect quadratic_bezier_bound (float2 r0, float2 rm, float2 r1)
{
FloatRect bound = isEqual(r0,r1) ?line_segment_bound (r0, rm):line_segment_bound (r0, r1);
float2 v0 = (float2)(2)*(rm - r0);
float2 v1 =(float2)(2)*(r1 - rm);
float2 a = v1-v0;
// get the times and locations of the maxima of the trajectory
const float tx = (a.x != 0) ? -v0.x/a.x : 0;
const float ty = (a.y != 0) ? -v0.y/a.y : 0;
if ((0 <= tx) && (tx <= 1))
{
float2 r_x_extreme = trajectory (tx, r0, rm, r1);
bound =  UnionWith (triangle_bound (r0, r_x_extreme, r1),bound);
}
if ((0 <= ty) && (ty <= 1))
{
float2 r_y_extreme = trajectory (ty, r0, rm, r1);
bound = UnionWith (triangle_bound (r0, r_y_extreme, r1),bound);
}
return bound;
}
inline float4 get_bezier2_kernel_trajectory_dense(__read_only image2d_t src,const int x,const int y,const float dx_center,
const float dy_center,const float dense_spacing,const int n_path_blur_kernel_points_max,const float two_xm0,const float two_ym0,const float xm1_plus_xm0,
const float ym1_plus_ym0,const int use_centered_kernel,const int anti_alias,const int entire_image_left,
const int entire_image_top,const int entire_image_right,const int entire_image_bottom,const int data_origin_x, const int data_origin_y,
const int data_end_x, const int data_end_y,const int padSize)
{
// Step along the curve with equal spacing (dense_spacing) of arc length
// calculate approximate arc lengths along the curve
float4 sum=0;
float dxt = (use_centered_kernel) ? -dx_center:0.f;
float dyt = (use_centered_kernel) ? -dy_center:0.f;
if(anti_alias)
sum=read_imagef(src, linearsampler, (float2)(dxt+x+0.5-data_origin_x+padSize,dyt+y+0.5-data_origin_y+padSize));
else
sum=read_imagef(src, sampler, (float2)(dxt+x+0.5-data_origin_x+padSize,dyt+y+0.5-data_origin_y+padSize));
if (dense_spacing <= 0)
{
return sum;
}
const float way_outside_limit =STOCHASTIC__BOUNDARY_CONDITION_WAY_OUTSIDE_LIMIT_FRACTION* padSize;
const float ds = dense_spacing;	// spacing of arc length (units of pixels)
const float dt_min = 0.1f;	// use at least ten points to avoid artifacts where the field passes steeply through zero
float dt = dt_min;
// constant acceleration (because we have a quadratic Bezier trajectory which is equivalent to a parabola)
const float ax = -2.0f * xm1_plus_xm0;
const float ay = -2.0f * ym1_plus_ym0;
// Calculate the arctimes, which are the time parameters for equal arc length spacing along the curve
float vx = two_xm0;
float vy = two_ym0;
float v = sqrt (vx*vx + vy*vy);
dt = (v != 0) ? ds / v : dt_min;
dt = min (dt_min, dt);
vx += ax * dt;
vy += ay * dt;
// get the trajectory motions dx(t), dy(t) for given starting point (x, y)
// step in units of equal arc length along the curve
int nt = 1;
int insideNt=1;
for (float t=dt; t <= 1 && nt < n_path_blur_kernel_points_max; t += dt, ++nt)
{
// Quadratic Bezier coordinates relative to first endpoint of curve
float dxt = t * (two_xm0 - t * xm1_plus_xm0);
float dyt = t * (two_ym0 - t * ym1_plus_ym0);
// get the coordinate of the trajectory relative to the current tile
float xt = (float)(x + dxt);
float yt = (float)(y + dyt);
float way_outside = false;
if (use_centered_kernel)
{
xt =xt- dx_center;
yt =yt- dy_center;
}
if (xt < entire_image_left)
{
const float distance_to_edge = (float) (entire_image_left) - xt;
if (way_outside_limit < distance_to_edge)
way_outside = true;
xt = 2.f * entire_image_left - xt;
}
if (entire_image_right <= xt)
{
const float distance_to_edge = xt - (float) (entire_image_right - 1);
if (way_outside_limit < distance_to_edge)
way_outside = true;
xt =  2.0f *entire_image_right - xt - 1.0f;
}
if (yt < entire_image_top)
{
const float distance_to_edge = (float) (entire_image_top) - yt;
if (way_outside_limit < distance_to_edge)
way_outside = true;
yt = 2.0f *entire_image_top - yt;
}
if (entire_image_bottom <= yt)
{
const float distance_to_edge = yt - (float)(entire_image_bottom - 1);
if (way_outside_limit < distance_to_edge)
way_outside = true;
yt = 2.0f *entire_image_bottom - yt - 1.0f;
}
dxt = xt - x;
dyt = yt - y;
// Make sure the kernel trajectory does not go outside of the padded boundary
if (!way_outside &&!((xt < data_origin_x - padSize) || (data_end_x + padSize - 1 < xt)|| (yt < data_origin_y - padSize) || (data_end_y + padSize - 1 < yt)) )
{
if(anti_alias)
sum=sum+read_imagef(src, linearsampler, (float2)(dxt+x+0.5-data_origin_x+padSize,dyt+y+0.5-data_origin_y+padSize));
else
sum=sum+read_imagef(src, sampler, (float2)(dxt+x+0.5-data_origin_x+padSize,dyt+y+0.5-data_origin_y+padSize));
insideNt++;
}
if (v > 0)
{
const float v_a = vx * ax + vy * ay;
const float n_a = v_a/v;
v += n_a*dt;
vx += ax * dt;
vy += ay * dt;
dt = min (dt_min, ds/v);
}
else
{
vx = vy = 0;
dt = dt_min;
}
}
float4 scale=(float4)(1.0f)/(float4)(insideNt);
return sum*scale;
}
inline float4 get_bezier2_kernel_trajectory_strobe(__read_only image2d_t src,const int x,const int y,const float dx_center,
const float dy_center,const int N,const float two_xm0,const float two_ym0,const float xm1_plus_xm0,
const float ym1_plus_ym0,const int use_centered_kernel,const int anti_alias,const int entire_image_left,
const int entire_image_top,const int entire_image_right,const int entire_image_bottom,const int data_origin_x, const int data_origin_y,
const int data_end_x, const int data_end_y,const int padSize)
{
float4 sum=0;
if (N <= 1)
{
if(anti_alias)
sum=read_imagef(src, linearsampler, (float2)(x+0.5-data_origin_x+padSize,y+0.5-data_origin_y+padSize));
else
sum=read_imagef(src, sampler, (float2)(x+0.5-data_origin_x+padSize,y+0.5-data_origin_y+padSize));
return sum;
}
int insideNt = 0;
for (int nt=0; nt < N; ++nt)
{
float t = (float)(nt)/(float)(N-1);
// Quadratic Bezier coordinates relative to first endpoint of curve
float dxt = t * (two_xm0 - t * xm1_plus_xm0);
float dyt = t * (two_ym0 - t * ym1_plus_ym0);
// get the coordinate of the trajectory relative to the current tile
float xt = (float) (x + dxt);
float yt = (float) (y + dyt);
// center the kernel at the point halfway along the trajectory
if (use_centered_kernel)
{
xt =xt- dx_center;
yt =yt- dy_center;
}
xt = (xt < entire_image_left) ? 2.f*entire_image_left - xt :xt;
xt = (entire_image_right <= xt) ? 2.f*entire_image_right - xt - 1:xt;
yt = (yt < entire_image_top) ? 2.f*entire_image_top - yt :	yt;
yt = (entire_image_bottom <= yt) ? 2.f*entire_image_bottom - yt - 1 :yt;
dxt = xt - x;
dyt = yt - y;
// Make sure the kernel trajectory does not go outside of the padded boundary
if(!((xt < data_origin_x - padSize) || (data_end_x + padSize - 1 < xt) || (yt < data_origin_y - padSize) || (data_end_y + padSize - 1 < yt)) )
{
float4 data;
if(anti_alias)
data=read_imagef(src, linearsampler, (float2)(dxt+x+0.5-data_origin_x+padSize,dyt+y+0.5-data_origin_y+padSize));
else
data=read_imagef(src, sampler, (float2)(dxt+x+0.5-data_origin_x+padSize,dyt+y+0.5-data_origin_y+padSize));
sum = sum+data ;
insideNt++;
}
}
float4 scale=(float4)(1.0f)/(float4)(insideNt);
return sum*scale;
}
int calculate_n_dense_path_samples(const int x,const int y,const float dx_center,
const float dy_center,const float dense_spacing,const int n_path_blur_kernel_points_max,const float two_xm0,const float two_ym0,const float xm1_plus_xm0,
const float ym1_plus_ym0,const int use_centered_kernel,const int anti_alias,const int entire_image_left,
const int entire_image_top,const int entire_image_right,const int entire_image_bottom,const int data_origin_x, const int data_origin_y,
const int data_end_x, const int data_end_y,const int padSize)
{
float dxt = (use_centered_kernel) ? -dx_center:0.f;
float dyt = (use_centered_kernel) ? -dy_center:0.f;
const float way_outside_limit =STOCHASTIC__BOUNDARY_CONDITION_WAY_OUTSIDE_LIMIT_FRACTION* padSize;
const float ds = dense_spacing;	// spacing of arc length (units of pixels)
const float dt_min = 0.1f;
float dt = dt_min;
// constant acceleration (because we have a quadratic Bezier trajectory which is equivalent to a parabola)
const float ax = -2.0f * xm1_plus_xm0;
const float ay = -2.0f * ym1_plus_ym0;
// Calculate the arctimes, which are the time parameters for equal arc length spacing along the curve
float vx = two_xm0;
float vy = two_ym0;
float v = sqrt (vx*vx + vy*vy);
dt = (v != 0) ? ds / v : dt_min;
dt = min (dt_min, dt);
vx += ax * dt;
vy += ay * dt;
int nt = 1;
int insideNt=1;
for (float t=dt; t <= 1 && nt < n_path_blur_kernel_points_max; t += dt, ++nt)
{
// Quadratic Bezier coordinates relative to first endpoint of curve
dxt = t * (two_xm0 - t * xm1_plus_xm0);
dyt = t * (two_ym0 - t * ym1_plus_ym0);
// get the coordinate of the trajectory relative to the current tile
float xt = (float)(x + dxt);
float yt = (float)(y + dyt);
float way_outside = false;
if (use_centered_kernel)
{
xt =xt- dx_center;
yt =yt- dy_center;
}
if (xt < entire_image_left)
{
const float distance_to_edge = (float) (entire_image_left) - xt;
if (way_outside_limit < distance_to_edge)
way_outside = true;
xt = 2.f * entire_image_left - xt;
}
if (entire_image_right <= xt)
{
const float distance_to_edge = xt - (float) (entire_image_right - 1);
if (way_outside_limit < distance_to_edge)
way_outside = true;
xt =  2.0f *entire_image_right - xt - 1.0f;
}
if (yt < entire_image_top)
{
const float distance_to_edge = (float) (entire_image_top) - yt;
if (way_outside_limit < distance_to_edge)
way_outside = true;
yt = 2.0f *entire_image_top - yt;
}
if (entire_image_bottom <= yt)
{
const float distance_to_edge = yt - (float)(entire_image_bottom - 1);
if (way_outside_limit < distance_to_edge)
way_outside = true;
yt = 2.0f *entire_image_bottom - yt - 1.0f;
}
dxt = xt - x;
dyt = yt - y;
// Make sure the kernel trajectory does not go outside of the padded boundary
if (!((xt < data_origin_x - padSize) || (data_end_x + padSize - 1 < xt)|| (yt < data_origin_y - padSize) || (data_end_y + padSize - 1 < yt)) )
{
insideNt++;
}
if (v > 0)
{
const float v_a = vx * ax + vy * ay;
const float n_a = v_a/v;
v += n_a*dt;
vx += ax * dt;
vy += ay * dt;
dt = min (dt_min, ds/v);
}
else
{
vx = vy = 0;
dt = dt_min;
}
}
return (insideNt);
}
inline float4 get_bezier2_kernel_trajectory_dense_taper(__read_only image2d_t src,const int x,const int y,const float dx_center,
const float dy_center,const float dense_spacing,const int n_path_blur_kernel_points_max,const float two_xm0,const float two_ym0,const float xm1_plus_xm0,
const float ym1_plus_ym0,const int use_centered_kernel,const int anti_alias,const int entire_image_left,
const int entire_image_top,const int entire_image_right,const int entire_image_bottom,const int data_origin_x, const int data_origin_y,
const int data_end_x, const int data_end_y,const int padSize,const float path_blur_taper)
{
float4 sum=0;
float dxt = (use_centered_kernel) ? -dx_center:0.f;
float dyt = (use_centered_kernel) ? -dy_center:0.f;
if(anti_alias)
sum+=read_imagef(src, linearsampler, (float2)(dxt+x+0.5-data_origin_x+padSize,dyt+y+0.5-data_origin_y+padSize));
else
sum+=read_imagef(src, sampler, (float2)(dxt+x+0.5-data_origin_x+padSize,dyt+y+0.5-data_origin_y+padSize));
if (dense_spacing <= 0)
return sum;
const int n_path_blur_dense_samples=calculate_n_dense_path_samples(x,y,dx_center,dy_center,dense_spacing,n_path_blur_kernel_points_max,two_xm0,two_ym0, xm1_plus_xm0,ym1_plus_ym0,
use_centered_kernel,anti_alias,entire_image_left,entire_image_top,entire_image_right,
entire_image_bottom,data_origin_x,data_origin_y,data_end_x,data_end_y,padSize);
const float way_outside_limit =STOCHASTIC__BOUNDARY_CONDITION_WAY_OUTSIDE_LIMIT_FRACTION* padSize;
const float ds = dense_spacing;	// spacing of arc length (units of pixels)
//	const float dt_min = 0.3333f;	// use at least four points to avoid artifacts where the field passes steeply through zero
const float dt_min = 0.1f;
float dt = dt_min;
// constant acceleration (because we have a quadratic Bezier trajectory which is equivalent to a parabola)
const float ax = -2.0f * xm1_plus_xm0;
const float ay = -2.0f * ym1_plus_ym0;
//const float a = fast_sqrt (ax*ax + ay*ay);
// Calculate the arctimes, which are the time parameters for equal arc length spacing along the curve
float vx = two_xm0;
float vy = two_ym0;
float v = sqrt (vx*vx + vy*vy);
dt = (v != 0) ? ds / v : dt_min;
dt = min (dt_min, dt);
vx += ax * dt;
vy += ay * dt;
// get the trajectory motions dx(t), dy(t) for given starting point (x, y)
// step in units of equal arc length along the curve
const float taper_extinction = 12.00f;	// controls the maximum amount of extinctiion along the kernel trajectory
float taper_time_offset = (use_centered_kernel) ?	0.5f *(n_path_blur_dense_samples - 1) :0.f;
int taper_time_offset_int =	(int)(taper_time_offset+0.5);
const float taper_gain = (1 < n_path_blur_dense_samples) ?	(taper_extinction * path_blur_taper)/(float)(n_path_blur_dense_samples - 1) :0.f;
float taper_decay_factor =exp (-taper_gain);
int nt = 1;
int insideNt=1;
float taper = 1.f;
float normalization=taper;
const float taper_growth_factor=1.f/taper_decay_factor;
bool even_no_points=!(n_path_blur_dense_samples%2);
taper*=taper_growth_factor;
for (float t=dt; t <= 1 && nt < n_path_blur_kernel_points_max; t += dt, ++nt)
{
// Quadratic Bezier coordinates relative to first endpoint of curve
dxt = t * (two_xm0 - t * xm1_plus_xm0);
dyt = t * (two_ym0 - t * ym1_plus_ym0);
// get the coordinate of the trajectory relative to the current tile
float xt = (float)(x + dxt);
float yt = (float)(y + dyt);
float way_outside = false;
if (use_centered_kernel)
{
xt =xt- dx_center;
yt =yt- dy_center;
}
if (xt < entire_image_left)
{
const float distance_to_edge = (float) (entire_image_left) - xt;
if (way_outside_limit < distance_to_edge)
way_outside = true;
xt = 2.f * entire_image_left - xt;
}
if (entire_image_right <= xt)
{
const float distance_to_edge = xt - (float) (entire_image_right - 1);
if (way_outside_limit < distance_to_edge)
way_outside = true;
xt =  2.0f *entire_image_right - xt - 1.0f;
}
if (yt < entire_image_top)
{
const float distance_to_edge = (float) (entire_image_top) - yt;
if (way_outside_limit < distance_to_edge)
way_outside = true;
yt = 2.0f *entire_image_top - yt;
}
if (entire_image_bottom <= yt)
{
const float distance_to_edge = yt - (float)(entire_image_bottom - 1);
if (way_outside_limit < distance_to_edge)
way_outside = true;
yt = 2.0f *entire_image_bottom - yt - 1.0f;
}
dxt = xt - x;
dyt = yt - y;
// Make sure the kernel trajectory does not go outside of the padded boundary
if (!((xt < data_origin_x - padSize) || (data_end_x + padSize - 1 < xt)|| (yt < data_origin_y - padSize) || (data_end_y + padSize - 1 < yt)) )
{
if(anti_alias)
sum+=taper*read_imagef(src, linearsampler, (float2)(dxt+x+0.5-data_origin_x+padSize,dyt+y+0.5-data_origin_y+padSize));
else
sum+=taper*read_imagef(src, sampler, (float2)(dxt+x+0.5-data_origin_x+padSize,dyt+y+0.5-data_origin_y+padSize));
normalization += taper;
if(insideNt<taper_time_offset_int)
taper *= taper_growth_factor;
else
taper *= taper_decay_factor;
if(insideNt==(taper_time_offset_int-1)&&even_no_points)
taper *= taper_decay_factor;
insideNt++;
}
if (v > 0)
{
const float v_a = vx * ax + vy * ay;
const float n_a = v_a/v;
v += n_a*dt;
vx += ax * dt;
vy += ay * dt;
dt = min (dt_min, ds/v);
}
else
{
vx = vy = 0;
dt = dt_min;
}
}
float4 scale=(float4)(1.0f)/(float4)(normalization);
return sum*scale;
}
inline float4 get_bezier2_kernel_trajectory_strobe_taper(__read_only image2d_t src,const int x,const int y,const float dx_center,
const float dy_center,const int N,const float two_xm0,const float two_ym0,const float xm1_plus_xm0,
const float ym1_plus_ym0,const int use_centered_kernel,const int anti_alias,const int entire_image_left,
const int entire_image_top,const int entire_image_right,const int entire_image_bottom,const int data_origin_x, const int data_origin_y,
const int data_end_x, const int data_end_y,const int padSize,const float path_blur_taper)
{
float4 sum=0;
if (N <= 1)
{
if(anti_alias)
sum=read_imagef(src, linearsampler, (float2)(x+0.5-data_origin_x+padSize,y+0.5-data_origin_y+padSize));
else
sum=read_imagef(src, sampler, (float2)(x+0.5-data_origin_x+padSize,y+0.5-data_origin_y+padSize));
return sum;
}
const float taper_extinction = 12.00f;	// controls the maximum amount of extinction along the kernel trajectory
float taper_time_offset = (use_centered_kernel) ?	0.5f *(N - 1) :0.f;
int taper_time_offset_int =	(int)(taper_time_offset+0.5);
const float taper_gain = (taper_extinction * path_blur_taper)/(float)(N - 1);
float taper_decay_factor =exp (-taper_gain);
int insideNt = 0;
float normalization=0.f;
const float taper_growth_factor=1.f/taper_decay_factor;
float taper=1.f;
bool even_no_points=!(N%2);
for (int nt=0; nt < N; ++nt)
{
float t = (float)(nt)/(float)(N-1);
// Quadratic Bezier coordinates relative to first endpoint of curve
float dxt = t * (two_xm0 - t * xm1_plus_xm0);
float dyt = t * (two_ym0 - t * ym1_plus_ym0);
// get the coordinate of the trajectory relative to the current tile
float xt = (float) (x + dxt);
float yt = (float) (y + dyt);
// center the kernel at the point halfway along the trajectory
if (use_centered_kernel)
{
xt =xt- dx_center;
yt =yt- dy_center;
}
xt = (xt < entire_image_left) ? 2.f*entire_image_left - xt :xt;
xt = (entire_image_right <= xt) ? 2.f*entire_image_right - xt - 1:xt;
yt = (yt < entire_image_top) ? 2.f*entire_image_top - yt :	yt;
yt = (entire_image_bottom <= yt) ? 2.f*entire_image_bottom - yt - 1 :yt;
dxt = xt - x;
dyt = yt - y;
// Make sure the kernel trajectory does not go outside of the padded boundary
if(!((xt < data_origin_x - padSize) || (data_end_x + padSize - 1 < xt) || (yt < data_origin_y - padSize) || (data_end_y + padSize - 1 < yt)) )
{
if(anti_alias)
sum=sum+(float4)(taper)*read_imagef(src, linearsampler, (float2)(dxt+x+0.5-data_origin_x+padSize,dyt+y+0.5-data_origin_y+padSize));
else
sum=sum+(float4)(taper)*read_imagef(src, sampler, (float2)(dxt+x+0.5-data_origin_x+padSize,dyt+y+0.5-data_origin_y+padSize));
normalization+= taper;
// need to handle even points case if n%2==0 then taper *= taper_decay_factor;
if(insideNt<taper_time_offset_int)
taper *= taper_growth_factor;
else
taper *= taper_decay_factor;
if(insideNt==(taper_time_offset_int-1)&&even_no_points)
taper *= taper_decay_factor;
insideNt++;
}
}
float4 scale=(float4)(1.0f)/(float4)(normalization);
return sum*scale;
}
inline
float4 get_bezier2_kernel_trajectory_dense_strobe (	const int x, const int y,const float bezier_field0,
const float bezier_field1, const float bezier_field2,
const float bezier_field3, const float bezier_field4,
const float bezier_field5,
__read_only image2d_t src,
const int padSize,
const int entire_image_left, const int entire_image_top,
const int entire_image_right, const int entire_image_bottom,
const int data_origin_x, const int data_origin_y,
const int data_end_x, const int data_end_y,
const float n_trajectory_time_steps,
const int n_path_blur_kernel_points_max,
const float dense_spacing,
const int use_centered_kernel,const int anti_alias,const float strobe_strength,
const int use_dense_path,const int  use_strobed_path,const float path_blur_taper
)
{
float xm0=0, ym0=1;
float xm1 = 0, ym1 = 0;
const float r01_length = bezier_field0;
float2 nm0=(float2)(bezier_field3,bezier_field4);
nm0=safe_normalize (nm0);
float2 r01;
r01= (float2)(r01_length)*(nm0);
float2 rm0=(float2)( r01*(float2)(bezier_field1) + (float2)(nm0.y,-nm0.x)*(float2)(bezier_field2));
xm0 = -rm0.x;
ym0 = -rm0.y;
xm1 = (r01.x-rm0.x);
ym1 = (r01.y-rm0.y);
const float two_xm0 = 2.0f * xm0;
const float two_ym0 = 2.0f * ym0;
const float xm1_plus_xm0 = xm1 + xm0;
const float ym1_plus_ym0 = ym1 + ym0;
////////////////////////////////////////////////////////////////////////////////////
// The kernel can be shifted so that it is centered at the trajectory halfway point
float dx_center = 0, dy_center = 0;
// will add function to solve the bound
if (use_centered_kernel)
{
float2 r0={0,0};
float2 rm={xm0, ym0};
float2 r1 ={xm0 - xm1, ym0 - ym1};
FloatRect kernel_bound =  quadratic_bezier_bound(r0, rm, r1);
dx_center = 0.5 * (kernel_bound.left +kernel_bound.right);
dy_center = 0.5 * (kernel_bound.top + kernel_bound.bottom);
}
// const float path_blur_taper=0.f;
//////////////////////////////////////////////////////////////////////////////////
float4 sum_s=0.0f;
if(use_strobed_path)
{
if(path_blur_taper!=0.f)
sum_s=get_bezier2_kernel_trajectory_strobe_taper(src,x,y,dx_center,dy_center,n_trajectory_time_steps,two_xm0,two_ym0, xm1_plus_xm0,ym1_plus_ym0,
use_centered_kernel,anti_alias,entire_image_left,entire_image_top,entire_image_right,
entire_image_bottom,data_origin_x,data_origin_y,data_end_x,data_end_y,padSize,path_blur_taper);
else
sum_s=get_bezier2_kernel_trajectory_strobe(src,x,y,dx_center,dy_center,n_trajectory_time_steps,two_xm0,two_ym0, xm1_plus_xm0,ym1_plus_ym0,
use_centered_kernel,anti_alias,entire_image_left,entire_image_top,entire_image_right,
entire_image_bottom,data_origin_x,data_origin_y,data_end_x,data_end_y,padSize);
}
float4 sum_d=0.0f;
if(use_dense_path)
{
if(path_blur_taper!=0.f)
sum_d=get_bezier2_kernel_trajectory_dense_taper(src,x,y,dx_center,dy_center,dense_spacing,n_path_blur_kernel_points_max,two_xm0,two_ym0, xm1_plus_xm0,ym1_plus_ym0,
use_centered_kernel,anti_alias,entire_image_left,entire_image_top,entire_image_right,
entire_image_bottom,data_origin_x,data_origin_y,data_end_x,data_end_y,padSize,path_blur_taper);
else
sum_d=get_bezier2_kernel_trajectory_dense(src,x,y,dx_center,dy_center,dense_spacing,n_path_blur_kernel_points_max,two_xm0,two_ym0, xm1_plus_xm0,ym1_plus_ym0,
use_centered_kernel,anti_alias,entire_image_left,entire_image_top,entire_image_right,
entire_image_bottom,data_origin_x,data_origin_y,data_end_x,data_end_y,padSize);
}
float4 sum=(float4)(strobe_strength) * sum_s + (float4)(1.0f - strobe_strength) * sum_d;
return sum;
}

__kernel void convolve_dense_strobe(__write_only image2d_t dst0,__write_only image2d_t dst1,__write_only image2d_t dst2,
__write_only image2d_t dst3,
__read_only image2d_t src,// image and row increment
__global float4* restrict bezier_fieldtex1,
__global float2* restrict bezier_fieldtex2,
const int cols ,const int rows,
const int padSize,
const int anti_alias,				// use neighboring image samples to estimate imaage values at non-integral locations
const int use_dense_path,
const int  use_strobed_path,
const int n_strobe_flashes,
const float strobe_strength,
const float dense_spacing,
const int use_centered_kernel,
const int nChannels,
const int n_path_blur_kernel_points_max,const int entire_image_left, const int entire_image_top,
const int entire_image_right, const int entire_image_bottom,
const int data_origin_x, const int data_origin_y,const int data_end_x,const int data_end_y,const float path_blur_taper)
{
int x = get_global_id(0);
int y = get_global_id(1);
if(x >= (cols)||y >= (rows))
return;
float4 bezier_field1=bezier_fieldtex1[x+y*cols];
float2 bezier_field2=bezier_fieldtex2[x+y*cols];
float4 sum= get_bezier2_kernel_trajectory_dense_strobe(x+data_origin_x,y+data_origin_y,bezier_field1.x,bezier_field1.y,bezier_field1.z,
bezier_field1.w,bezier_field2.x,bezier_field2.y,src,padSize,
entire_image_left,entire_image_top,
entire_image_right, entire_image_bottom,
data_origin_x, data_origin_y,
data_end_x, data_end_y,
n_strobe_flashes,n_path_blur_kernel_points_max,dense_spacing,
use_centered_kernel,anti_alias,strobe_strength,use_dense_path,use_strobed_path,path_blur_taper);
switch(nChannels)
{
case 4:
write_imagef(dst3, (int2)(x,y), sum.w);
case 3:
write_imagef(dst2, (int2)(x,y), sum.z);
case 2:
write_imagef(dst1, (int2)(x,y), sum.y);
case 1:
write_imagef(dst0, (int2)(x,y), sum.x);
break;
}
}

__kernel void Interleave32To32(__read_only image2d_t srcChan0,
__read_only image2d_t srcChan1,
__read_only image2d_t srcChan2,
__read_only image2d_t srcChan3,
__write_only image2d_t dstImage,
int originX, int originY,
int cols, int rows,
int nChannels
)
{
int col = get_global_id(0);
int row = get_global_id(1);
if (col >= cols || row >= rows)
return;
float4 pixel32;
float pixel0= read_imagef(srcChan0,sampler,(int2)(col,row)).x;
float pixel1=0.f;
float pixel2=0.f;
float pixel3=0.f;
switch(nChannels)
{
case 4 :
pixel3= read_imagef(srcChan3,sampler,(int2)(col,row)).x;
case 3 :
pixel2= read_imagef(srcChan2,sampler,(int2)(col,row)).x;
case 2:
pixel1= read_imagef(srcChan1,sampler,(int2)(col,row)).x;
break;
}
write_imagef(dstImage, (int2)(originX + col, originY + row), (float4)(pixel0,pixel1,pixel2,pixel3));
}

__kernel void imageCopy_kernel(__read_only image2d_t srcImage,__write_only image2d_t dst0,__write_only image2d_t dst1,__write_only image2d_t dst2,
__write_only image2d_t dst3,int width,int height,int offsetX,int offsetY,const int nChannels)
{
int x= get_global_id(0);
int y= get_global_id(1);
if(x>=width||y>=height)
return ;
//const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
float4 sum= read_imagef(srcImage,sampler,(int2){x+offsetX,y+offsetY});
switch(nChannels)
{
case 4:
write_imagef(dst3, (int2)(x,y), sum.w);
case 3:
write_imagef(dst2, (int2)(x,y), sum.z);
case 2:
write_imagef(dst1, (int2)(x,y), sum.y);
case 1:
write_imagef(dst0, (int2)(x,y), sum.x);
break;
}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
