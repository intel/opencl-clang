#define CHAR2( X , Y )  (char2)( X ,Y)
#define CHAR4( X , Y , Z , W)  (char4)( X ,Y, Z, W)
#define UCHAR2( X , Y )  (uchar2)( X ,Y)
#define UCHAR4( X , Y , Z , W)  (uchar4)( X ,Y, Z, W)
#define SHORT2( X , Y )  (short2)( X ,Y)
#define SHORT4( X , Y , Z , W)  (short4)( X ,Y, Z, W)
#define USHORT2( X , Y )  (ushort2)( X ,Y)
#define USHORT4( X , Y , Z , W)  (ushort4)( X ,Y, Z, W)
#define INT2( X , Y )  (int2)( X ,Y)
#define INT4( X , Y , Z , W)  (int4)( X ,Y, Z , W)
#define UINT2( X , Y )  (uint2)( X ,Y)
#define UINT4( X , Y , Z , W)  (uint4)( X ,Y, Z , W)
#define FLOAT2( X , Y )  (float2)( X ,Y)
#define FLOAT4( X , Y , Z , W)  (float4)( X ,Y, Z , W)
#define DOUBLE2( X , Y )  (double2)( X ,Y)
#define DOUBLE4( X , Y , Z , W)  (double4)( X ,Y, Z , W)
#ifdef USESTRINGIFY
STRINGIFY(
#endif

inline float ifelse_1(int flag, float iftrue,float iffalse)
{
flag=flag*-1;
return as_float ((flag & as_int(iftrue)) | (~flag & as_int(iffalse)));
}

inline float4 ifelse(int4 flag, float4 iftrue,float4 iffalse)
{
return as_float4 ((flag & as_int4(iftrue)) | (~flag & as_int4(iffalse)));
}

typedef struct
{
int _x0,_y0;
float _cosine1,_sine1;
float _cosine2,_sine2;
float _outer_line_distance1,_inner_line_distance1;
float _outer_line_distance2,_inner_line_distance2;
float _distortion,_amplitude;
int _invert_shape,_symmetric_distortion;
float _log_shift;

}tilt_shift_shape_params;

typedef struct
{
float _cosine,_sine;
float _radius_x,_radius_y;
float _radius_left,_radius_right;
float _radius_top,_radius_bottom;
float _shape_power,_inverse_shape_power;
float _amplitude;
int _x0,_y0;
int _invert_shape;
} iris_super_ellipse_params;

#define n_second_order_iterations  2
#define n_first_order_iterations 6
#define error_threshold 1.0e-5f
#define f_initial 0.3f
#define alpha 1.6f


//// x ^ power
//	x can be positive, zero or negative, but the result is 0 if x <= 0 (no complex math here)
// power can be between negative, zero or positive
inline float fast_power_f(float x, float power)
{
return ifelse_1(isgreater(x,0.0f),pow(x,power),0.0f);
}
inline float fast_absolute_power_f(float x, float power)
{
return fast_power_f(fabs(x),power);
}



inline float super_ellipse_f ( int xIdx,  int yIdx,__global iris_super_ellipse_params* params)
{


float x= (float)xIdx;
float y= (float)yIdx;

float ZERO=0.0f;
float ONE =1.0f;
float a_out= params->_radius_x;
float b_out= params->_radius_y;

int zeroResFlag=  0;
int oneResFlag=  0;

float dx = (x * params->_cosine - y * params->_sine);
float dy = (y * params->_cosine + x * params->_sine);
int flag;

zeroResFlag= zeroResFlag | (isequal(dx,ZERO) & isequal(dy,ZERO));


flag=isgreater(dx,ZERO);
float a_in = ifelse_1(flag,params->_radius_right,params->_radius_left);
flag=isgreater(dy,ZERO);
float b_in = ifelse_1(flag,params->_radius_bottom,params->_radius_top);


float a_oi=a_out-a_in;
float b_oi=b_out-b_in;

float X_in=dx/a_in;
float Y_in=dy/b_in;

float X_out=dx/a_out;
float Y_out=dy/b_out;

float mu=(params->_shape_power);
float nu=(params->_inverse_shape_power);
float F_in=fast_power_f(fast_absolute_power_f(X_in,mu)+fast_absolute_power_f(Y_in,mu),nu);
float F_out=fast_power_f(fast_absolute_power_f(X_out,mu)+fast_absolute_power_f(Y_out,mu),nu);


zeroResFlag = zeroResFlag | islessequal(F_in,ONE);

oneResFlag = oneResFlag | islessequal(ONE,F_out);

float f=f_initial;
for (int n=0; n < n_second_order_iterations; ++n)
{
float a_f = a_in + f * a_oi;
float b_f = b_in + f * b_oi;
float Fx= fast_absolute_power_f(dx/a_f, mu);
float Fy= fast_absolute_power_f(dy/b_f, mu);
float F =  Fx + Fy;
float Fp= fast_power_f(F,nu);

float G1 = (a_oi/a_f) * Fx + (b_oi/b_f) * Fy;
float G2 = (a_oi/a_f)*(a_oi/a_f) * Fx + (b_oi/b_f)*(b_oi/b_f) * Fy;

float two_K = 2 * mu*mu * ((1-nu*nu) * G1/F - G2/G1);
float df1 = alpha * (F * (Fp - 1.0f))/(Fp * G1);

float  A = 2*alpha -1.0f + two_K * df1;


flag=isgreater(A,ZERO);
float denominator = ifelse_1(flag,ONE + native_sqrt (A),ONE);
flag=isequal(G1,ZERO);
float df2 = ifelse_1(flag,ZERO,df1/denominator);

f=max(min(f+ df2,ONE),ZERO);
}
float error=ZERO;
for (int n=0 ; n < n_first_order_iterations; ++n)
{
float a_f = a_in + f * a_oi;
float b_f = b_in + f * b_oi;

float Fx= fast_absolute_power_f(dx/a_f, mu);
float Fy= fast_absolute_power_f(dy/b_f, mu);
float F =  Fx + Fy;
float Fp= fast_power_f(F,nu);
error=fabs(Fp-ONE);
flag=islessequal(error,error_threshold);
float f_old=f;
float G1 = (a_oi/a_f) * Fx + (b_oi/b_f) * Fy;


float df =   ifelse_1(isnotequal(G1,ZERO), (F * (Fp - 1.0f))/(Fp * G1) ,ZERO);

f=max(min(f+ df,ONE),ZERO);

f=ifelse_1(flag,f_old,f);
}

float c0=5.0f;
float c1=-10.0;
float c2=10.0f;
float c3=-4.0f;

f=f * f * (c0 + f * (c1 + f * (c2 + f * c3)));

f=ifelse_1(zeroResFlag,ZERO,f);
f=ifelse_1(oneResFlag,ONE,f);
return f;
}



inline float cubic_sigmoid_f(float x)
{
float ZERO =0.0f;
float ONE  =1.0f;
float TWO  =2.0f;
float THREE=3.0f;

return	(x < ZERO) ?	ZERO :
(ONE < x) ?	ONE :
x * x *(THREE - TWO * x);
}


inline float linear_ramp_f (float x)
{
float ZERO =(float)0.0;
float ONE  =(float)1.0;
return max(min(x,ONE),ZERO);
}



inline float distortion_shape_asymmetric_f(int xIdx,  int yIdx,__global tilt_shift_shape_params* params)
{
float ZERO =0.0f;
float ONE  =1.0f;

float x= (float)(xIdx);
float y= (float)(yIdx);

float dx2 = (x * params->_cosine2 - y * params->_sine2);

float do2 = params->_outer_line_distance2;
float di2 = params->_inner_line_distance2;
#if SANE_MAC
float _dL2_inverse = (do2 != di2) ?	ONE/ fabs (do2 - di2) : ZERO;
#else
float _dL2_inverse = isnotequal(do2,di2)?ONE / fabs (do2 - di2):ZERO;
#endif
return linear_ramp_f (_dL2_inverse * (dx2 - di2));
}



inline float distortion_shape_symmetric_f(int xIdx,  int yIdx,__global tilt_shift_shape_params* params)
{
float ZERO =0.0f;
float ONE  =1.0f;

float x= (float)xIdx;
float y= (float)yIdx;

float dx1 = (x * params->_cosine1 - y * params->_sine1);
float dx2 = (x * params->_cosine2 - y * params->_sine2);

float do2 = params->_outer_line_distance2;
float di2 = params->_inner_line_distance2;
float do1 = params->_outer_line_distance1;
float di1 = params->_inner_line_distance1;
#if SANE_MAC
float _dL1_inverse = (do1 != di1) ?	ONE / fabs (do1 - di1) : ZERO;
float _dL2_inverse = (do2 != di2) ?	ONE/ fabs (do2 - di2) : ZERO;
#else
float _dL1_inverse = isnotequal(do1,di1)?ONE / fabs (do1 - di1):ZERO;
float _dL2_inverse = isnotequal(do2,di2)?ONE / fabs (do2 - di2):ZERO;
#endif

return linear_ramp_f (_dL2_inverse * (dx2 - di2)) + linear_ramp_f (_dL1_inverse * (- di1 - dx1));
}


inline float4 atan2_impl(float4 y, float4 x)
{
float4 pi_t= (float4)3.14159265358979323846264338327950288f;
float4 theta = atan( y*native_recip(x));
int4 sgnX =signbit(x);
int4 sgnY =signbit(y);
float4 tmp = ifelse(sgnX & ~sgnY , theta+pi_t , theta);
return ifelse(sgnX & sgnY,theta-pi_t,tmp);

}


inline float orientation_angle_f (int xIdx,  int yIdx, __global tilt_shift_shape_params* params)
{
// move the center point along the transverse axis (the x axis when the focus line is vertical) in order to change the concentration of angles

float ZERO =0.0f;

float x= (float)xIdx;
float y= (float)(yIdx);
float center_shift_x = params->_log_shift * params->_inner_line_distance2;

float x_shifted = x + center_shift_x;
#if SANE_MAC
return (y == ZERO && x_shifted == ZERO) ? ZERO :atan2 (-y, x_shifted);
#else
return isequal(y,ZERO) & isequal(x_shifted,ZERO)?ZERO:atan2 (-y, x_shifted);
#endif
}

typedef struct
{
float _amplitude;
float _blur_radius;
float _x0,_y0;
}gradient_multipole_params;



inline float gradient_multipole_f(int xIdx,  int yIdx,int _n_shapes,float _blur_radius_max, __global gradient_multipole_params* params)
{
float ZERO =(float)0.0;
float ONE	=(float)1.0;
if(_blur_radius_max==0)
return ZERO;
float x= (float)xIdx;
float y= (float)(yIdx);
float x0,y0,x1,y1,x2,y2;
float x_f,y_f;
float A0,A1,A2;
float field,normalization;
switch(_n_shapes)
{
case 1:
return (float) params[0]._amplitude;
case 2:
{
A0 = (float)(params[0]._amplitude * (params[0]._blur_radius / _blur_radius_max));
A1 = (float)(params[1]._amplitude * (params[1]._blur_radius / _blur_radius_max));

x0 = (float)(params[0]._x0);
y0 = (float)(params[0]._y0);

x1 = (float)(params[1]._x0);
y1 = (float)(params[1]._y0);

float x10 = x1 - x0;
float y10 = y1 - y0;

x_f = x;
y_f = y;

float dr0_r10 = (x_f - x0) * x10 + (y_f - y0) * y10;

float r10_sq = x10*x10 + y10*y10;
#if SANE_MAC
float projection = (r10_sq != 0) ?	dr0_r10 / r10_sq : 0;
#else
float projection = isnotequal(r10_sq,ZERO)?dr0_r10/ r10_sq:ZERO;
#endif
projection = max (ZERO, projection);
projection = min (projection, ONE);

field = (A0 + (A1 - A0) * projection);

return field;
}
case 3:
{
A0 = params[0]._amplitude * (params[0]._blur_radius / _blur_radius_max);
A1 = params[1]._amplitude * (params[1]._blur_radius / _blur_radius_max);
A2 = params[2]._amplitude * (params[2]._blur_radius / _blur_radius_max);

x_f = x;
y_f = y;

x0 = (float)params[0]._x0;
y0 = (float)params[0]._y0;

x1 = (float)params[1]._x0;
y1 = (float)params[1]._y0;

x2 = (float)params[2]._x0;
y2 = (float)params[2]._y0;

float dx0 = x_f - x0;
float dy0 = y_f - y0;

float dx1 = x_f - x1;
float dy1 = y_f - y1;

float dx2 = x_f - x2;
float dy2 = y_f - y2;

float dr0_sq = dx0 * dx0 + dy0 * dy0;
float dr1_sq = dx1 * dx1 + dy1 * dy1;
float dr2_sq = dx2 * dx2 + dy2 * dy2;

float f0 = 1.0f / (dr0_sq * dr0_sq + (float)0.01);
float f1 = 1.0f / (dr1_sq * dr1_sq + (float)0.01);
float f2 = 1.0f / (dr2_sq * dr2_sq + (float)0.01);

normalization = f0 + f1 + f2;

field = (f0 * A0 + f1 * A1 + f2 * A2) / normalization;

field = max (ZERO, field);
field = min (field, ONE);

return  field;
}
default:
{
x_f = x;
y_f = y;

field = ZERO;
normalization = ZERO;

for (int s = 0; s < _n_shapes; ++s)
{
float x_s = (float)params[s]._x0;
float y_s = (float)params[s]._y0;
float dx_s = x_f - x_s;
float dy_s = y_f - y_s;
float dr_s_sq = dx_s * dx_s + dy_s * dy_s;

float f = 1.0f / (dr_s_sq * dr_s_sq + 0.01f);
float A = params[s]._amplitude * (params[s]._blur_radius / _blur_radius_max);

field += f * A;

normalization += f;
}

field = isless(ZERO,normalization)? min(max(ZERO,field/normalization),ONE):ONE;


return field;
}
}
}



__kernel void gradient_multipole_Kernel_f(__global float * mask, int row_increment, int row_begin, int height, int col_begin, int width, float _blur_radius_max, int _n_shapes,__global gradient_multipole_params* params)
{
int xIdx=(int)get_global_id(0);
int yIdx=(int)get_global_id(1);

if(xIdx>=width || yIdx>=height)
return;
float out=gradient_multipole_f(xIdx+col_begin , yIdx+row_begin, _n_shapes, _blur_radius_max,  params);

mask=mask+ ( row_increment*(yIdx)  + xIdx) ;
*mask=out;

}

inline float tilt_shift_strip_f(int xIdx,  int yIdx,__global tilt_shift_shape_params* params)
{
float ZERO =0.0f;
float ONE  =1.0f;
float x= (float)xIdx;
float y= (float)(yIdx);

float dx1 = (x * params->_cosine1 - y * params->_sine1);
float dx2 = (x * params->_cosine2 - y * params->_sine2);

float  do1 = params->_outer_line_distance1;
float  di1 = params->_inner_line_distance1;
float  do2 = params->_outer_line_distance2;
float  di2 = params->_inner_line_distance2;
#if SANE_MAC
float _dL1_inverse = (do1 != di1) ?	ONE / std::fabs (do1 - di1) : 0;

float _dL2_inverse = (do2 != di2) ?	ONE / std::fabs (do2 - di2) : 0;
#else
float _dL1_inverse = isnotequal(do1,di1) ?	ONE / fabs (do1 - di1) : ZERO;

float _dL2_inverse = isnotequal(do2,di2) ?	ONE / fabs (do2 - di2) : ZERO;
#endif
return cubic_sigmoid_f (_dL1_inverse * (- di1 - dx1)) + cubic_sigmoid_f (_dL2_inverse * (dx2 - di2));
}

__kernel void tilt_shift_distortion_f(__global float * mask, int row_increment, int row_begin, int height, int col_begin,
int width, int _n_shapes,
float ellipse_distortion_minimum,
float ellipse_distortion_maximum,
__global tilt_shift_shape_params* params)
{
int xIdx=(int)get_global_id(0) ;
int yIdx=(int)get_global_id(1);

if(xIdx>=width || yIdx>=height)
return;
float combined_field=0.0f;
for (int a =0; a < _n_shapes; ++a)
{
float out=params[a]._symmetric_distortion==1?distortion_shape_symmetric_f(xIdx+col_begin-params[a]._x0,yIdx+row_begin-params[a]._y0,params+a):
distortion_shape_asymmetric_f(xIdx+col_begin-params[a]._x0,yIdx+row_begin-params[a]._y0,params+a);
float amp=(params[a]._amplitude);
float field=(params[a]._invert_shape!=1)?amp*out:
amp*(1.0f-out);
combined_field=combined_field+ field * (params[a]._distortion);
}
combined_field=min(max(ellipse_distortion_minimum,combined_field),ellipse_distortion_maximum);
mask=mask+  (row_increment*(yIdx)  +xIdx);
*mask=combined_field;
}



__kernel void tilt_shift_angles_f(__global float * mask, int row_increment, int row_begin, int height, int col_begin, int width, int _n_shapes,__global tilt_shift_shape_params* params)
{
int xIdx=(int)get_global_id(0);
int yIdx=(int)get_global_id(1);

if(xIdx>=width || yIdx>=height)
return;

float cosine_avg = 0.0f;
float sine_avg = 0.0f;
float normalization = 0.0f;

for (int a =0; a < _n_shapes; ++a)
{
float angle=orientation_angle_f(xIdx+col_begin-params[a]._x0, yIdx+row_begin-params[a]._y0, params+a);
float amp = (float)(params[a]._amplitude);
cosine_avg += cos (angle) * amp;
sine_avg += sin (angle) * amp;

normalization+=amp;
}
#if SANE_MAC
float out=(normalization>0.0f)?atan2(sine_avg/normalization,cosine_avg/normalization),0.0f;
#else
float out=normalization>0.0f?  atan2((float)(sine_avg/normalization),(float)(cosine_avg/normalization)):  0.0f;
#endif
mask=mask+  (row_increment*(yIdx)  + xIdx);
*mask=out;
}



__kernel void tilt_shift_strip_kernel_f(__global float * mask, int row_increment, int row_begin, int height, int col_begin, int width, int _n_shapes,__global tilt_shift_shape_params* params)
{
int xIdx=(int)get_global_id(0);
int yIdx=(int)get_global_id(1);

if(xIdx>=width || yIdx>=height)
return;
float ONE = 1.0f;
float combined_field = ONE;
for (int a =0; a < _n_shapes; ++a)
{
float A = params[a]._amplitude;
float field=(params[a]._invert_shape != 1)?(ONE - A) + A *  tilt_shift_strip_f(xIdx+col_begin-params[a]._x0,yIdx+row_begin-params[a]._y0,params+a)
:(ONE - A) + A *  (ONE - tilt_shift_strip_f(xIdx+col_begin-params[a]._x0,yIdx+row_begin -params[a]._y0,params+a));
combined_field = combined_field*field;
}



mask=mask+ ( row_increment*(yIdx)  + xIdx) ;
*mask=combined_field;
}




__kernel void super_ellipse_kernel_f(__global float * mask, int row_increment, int row_begin, int height, int col_begin, int width, int _n_shapes,__global iris_super_ellipse_params* params)
{
int xIdx=(int)get_global_id(0);
int yIdx=(int)get_global_id(1);

if(xIdx>=width || yIdx>=height)
return;
float ONE =  1.0f;
float combined_field = ONE;

for (int a =0; a < _n_shapes; ++a)
{
float A = params[a]._amplitude;
const int X = col_begin+xIdx;
const int Y = row_begin+yIdx;
const float superEllipse = super_ellipse_f(X -params[a]._x0,Y -params[a]._y0,params+a);
float field = (params[a]._invert_shape != 1)?(ONE - A) + A *  superEllipse
:(ONE - A) + A *  (ONE - superEllipse);
combined_field = combined_field*field;
}


mask=mask+ ( row_increment*(yIdx)  + xIdx);
*mask=combined_field;
}

__kernel void combine_linear_f(__global float * mask,__global float * mask1,__global float * mask2 ,int row_increment, int row_begin, int height, int col_begin, int width, float c1,float c2)
{
int xIdx=(int)get_global_id(0);
int yIdx=(int)get_global_id(1);

if(xIdx>=width || yIdx>=height)
return;

float out= c1*mask1[row_increment*(yIdx)  + xIdx]+c2*mask2[row_increment*(yIdx)  + xIdx];

mask[row_increment*(yIdx)  + xIdx]=out;

}

// bokeh boost
inline float abs_f(float I1)
{

return I1>0?I1:-I1;

}
inline float masked_boost_chrominance(float src,float modulation_mask, float luminance,float _I1,float _I2,
float _k12,float _beta1,float _beta2,float _normalization, float _mask_scale_factor,float _boost_factor)
{

const float lightness =  luminance;
const float phi1 = (float)((_I1 < lightness) ?	pow (_k12 * (lightness - _I1), _beta1) :0.0f);

const float phi2 = (float)((lightness < _I2) ?	pow (_k12 * (_I2 - lightness), _beta2) :0.0f);

const float bump = _normalization * phi1 * phi2;
float boosted_s = (float) (0.5 + (src - 0.5) * (1.0 +  _boost_factor * bump));
float mask_ = modulation_mask*_mask_scale_factor;

mask_ =	(mask_< 0.0f) ? 0.0f :( 1.0f < mask_) ?1.0f:mask_;

float mask_square = mask_ * mask_;
float mask_fourth = mask_square * mask_square;
return ((boosted_s - src)* mask_fourth + src);

}



inline float masked_boost_luminance_energy(float src,float modulation_mask, float luminance,float _I1,float _I2,
float _k12,float _beta1,float _beta2,float _normalization, float _colorfulness,float _boost_factor)
{


const float lightness = (float)((1.0f - _colorfulness) *  luminance + _colorfulness *src);
const float phi1 = (float)((_I1 < lightness) ?	pow (_k12 * (lightness - _I1), _beta1) :0.0f);

const float phi2 = (float)((lightness < _I2) ?	pow (_k12 * (_I2 - lightness), _beta2) :0.0f);

const float bump = _normalization * phi1 * phi2;
float boosted_s = (float) (src + src* _boost_factor * bump);
float mask_ = modulation_mask;

mask_ =	(mask_< 0.0f) ? 0.0f :( 1.0f < mask_) ?1.0f:mask_;

float mask_square = mask_ * mask_;
float mask_fourth = mask_square * mask_square;
return ((boosted_s - src)* mask_fourth + src);

}
__kernel void masked_boost_luminance_energy_lab(
__read_only image2d_t srcImage,__global float *modulation_mask,__read_only image2d_t luminance,
__write_only image2d_t dst,int width,int height,
float boost_threshold_low ,
float boost_threshold_high ,
float _boost_factor ,
float _colorfulness ,
float _mask_scale_factor,
float maximum_boost_colorfulness)
{
int i=(int)get_global_id(0);
int j=(int)get_global_id(1);

if(i>=width ||j>=height)
return;

float _I1, _I2;
float _k12;
float _beta1, _beta2;
float _normalization;
const float beta_max = 3.0f;
const float kappa = 2.0f;

_I1  = (float) min (boost_threshold_low, boost_threshold_high);
_I2 = (float)  max (boost_threshold_low, boost_threshold_high);


_k12 = (float)((_I1 != _I2) ?	1.0f / abs_f((_I2 - _I1)) :0.0f);
_beta1 =(float)( beta_max * exp (-kappa * (1.0f - _I2)));
_beta2 = (float)(beta_max * exp (-kappa * _I1));
_normalization = pow (_beta1 + _beta2, _beta1 + _beta2) / (pow (_beta1, _beta1) * pow (_beta2, _beta2));
const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;

if (_I1 != _I2)
{
float4 src=read_imagef(srcImage,sampler,(int2)(i,j));
float lumi=read_imagef(luminance,sampler,INT2(i,j)).x;//luminance[i+width*j];
float mod_mask=modulation_mask[i+width*j];
float4 out;

out.x=masked_boost_luminance_energy(src.x,mod_mask,lumi,_I1,_I2,_k12,_beta1,_beta2,_normalization,0,_boost_factor);
out.y=masked_boost_chrominance(src.y,mod_mask,lumi,_I1,_I2,_k12,_beta1,_beta2,_normalization,_mask_scale_factor, _colorfulness * maximum_boost_colorfulness);
out.z=masked_boost_chrominance(src.z,mod_mask,lumi,_I1,_I2,_k12,_beta1,_beta2,_normalization,_mask_scale_factor,_colorfulness * maximum_boost_colorfulness);
out.w=src.w;
write_imagef(dst,INT2(i,j),out);
}


}

inline float4 _masked_boost_luminance_energy_f4(
float4 s,float modulation_mask,float luminance,
float boost_threshold_low ,
float boost_threshold_high ,
float _boost_factor ,
float _colorfulness )
{

float _I1, _I2;
float _k12;
float _beta1, _beta2;
float _normalization;
const float beta_max = 3.0f;
const float kappa = 2.0f;

_I1  = (float) min (boost_threshold_low, boost_threshold_high);
_I2 = (float)  max (boost_threshold_low, boost_threshold_high);


_k12 = (float)((_I1 != _I2) ?	1.0f / abs_f((_I2 - _I1)) :0.0f);
_beta1 =(float)( beta_max * exp (-kappa * (1.0f - _I2)));
_beta2 = (float)(beta_max * exp (-kappa * _I1));
_normalization = pow (_beta1 + _beta2, _beta1 + _beta2) / (pow (_beta1, _beta1) * pow (_beta2, _beta2));
if (_I1 != _I2)
{


const float4 lightness = (float4)((1.0f - _colorfulness) *luminance) + (float4)(_colorfulness) * s;
float4 phi1,phi2;
phi1.x = ((_I1 < lightness.x) ?	pow (_k12 * (lightness.x - _I1), _beta1) :0.0f);
phi1.y = ((_I1 < lightness.y) ?	pow (_k12 * (lightness.y - _I1), _beta1) :0.0f);
phi1.z = ((_I1 < lightness.z) ?	pow (_k12 * (lightness.z - _I1), _beta1) :0.0f);
phi1.w = ((_I1 < lightness.w) ?	pow (_k12 * (lightness.w - _I1), _beta1) :0.0f);

phi2.x = ((lightness.x < _I2) ?	pow (_k12 * (_I2 - lightness.x), _beta2) :0.0f);
phi2.y = ((lightness.y < _I2) ?	pow (_k12 * (_I2 - lightness.y), _beta2) :0.0f);
phi2.z = ((lightness.z < _I2) ?	pow (_k12 * (_I2 - lightness.z), _beta2) :0.0f);
phi2.w = ((lightness.w < _I2) ?	pow (_k12 * (_I2 - lightness.w), _beta2) :0.0f);

float4 bump = (float4)(_normalization) * phi1 * phi2;
float mask_ = modulation_mask;
mask_ =	(mask_< 0.0f) ? 0.0f :( 1.0f < mask_) ?1.0f:mask_;

float mask_square = mask_ * mask_;
float mask_fourth = mask_square * mask_square;

float4 boosted_n= (float4)(_boost_factor*mask_fourth)*bump; // verify it must copy it to every channel
return (s * boosted_n + s);
}

return 0.0f;
}
inline float _blurb_form_luminance_rgb(float x, float y,float z)
{
float out=(0.30f * x + 0.59f *y + 0.11f *z);

return out;
}

inline float _blurb_form_luminance_cmyk(float x, float y,float z,float w)
{
float out=(0.30f * x + 0.59f *y + 0.11f *z)*w;

return out;
}
__kernel void _boost_highlights(__read_only image2d_t srcImage,__global float *modulation_mask,__read_only image2d_t scaledImage,
__write_only image2d_t dst,int width,int height,
float boost_threshold_low ,
float boost_threshold_high ,
float _boost_factor ,
float _colorfulness ,
int image_mode)
{

int i=(int)get_global_id(0);
int j=(int)get_global_id(1);

if(i>=width ||j>=height)
return;

const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
float4 src= read_imagef(srcImage,sampler,INT2(i,j));
float4 scaledSrc= read_imagef(scaledImage,sampler,INT2(i,j));
float mask=modulation_mask[i+j*width];
float4 out=0;
float luminance=0;
switch(image_mode)
{
case 1://grayscale
luminance=scaledSrc.x;
break;
case 3://rgb
luminance= _blurb_form_luminance_rgb(scaledSrc.x,scaledSrc.y,scaledSrc.z);
break;
case 4://cmyk
luminance= _blurb_form_luminance_cmyk(scaledSrc.x,scaledSrc.y,scaledSrc.z,scaledSrc.w);
break;

}

out=_masked_boost_luminance_energy_f4(src,mask,luminance,boost_threshold_low,boost_threshold_high,_boost_factor,_colorfulness);

write_imagef(dst,INT2(i,j),out);

}

inline float fast_sqrt (const float x)
{
union
{
int i;
float x;
} u;

if (x <= 0)
{
return 0;
}
else
{
u.x = x;
u.i = (1<<29) + (u.i >> 1) - (1<<22);

// One Babylonian Step
u.x = 0.5f * (u.x + x/u.x);

return u.x;
}
}

inline float spatially_varying_smooth_gradients_f (__global float *src,const int R_int,const float f_R ,const float one_ninth ,const int tidX,const int tidY,int d_a,
float gradient_gain)
{


//a0 a1 a2
//a3 a4 a5
//a6 a7 a8

if (R_int == 0)
{
return src[tidX+tidY*d_a];
}
else
{

float a0= src[(tidX -1)+(tidY-1)*d_a];
float a1= src[(tidX) + (tidY-1)*d_a];
float a2= src[(tidX +1)+ (tidY-1)*d_a];

float a3= src[(tidX -1)+(tidY)*d_a];
float a4= src[(tidX) +  tidY*d_a];
float a5= src[(tidX +1)+ (tidY)*d_a];

float a6= src[(tidX -1)+(tidY+1)*d_a];
float a7= src[(tidX) + (tidY+1)*d_a];
float a8= src[(tidX +1)+ (tidY+1)*d_a];

// Calculate gradient of image

const float gradient_x=(a8-a6)+2.0f*(a5-a3)+(a2-a0);
const float gradient_y=(a6-a0)+2.0f*(a7-a1)+(a8-a2);

const float gradient2 = gradient_x * gradient_x + gradient_y * gradient_y;

float gradient = 0;
float avg=(a0+a1+a2+a3+a4+a5+a6+a7+a8)*one_ninth;

if(gradient2!=0)
{
gradient=fast_sqrt(gradient2);
if(avg>0)gradient/= avg;
}


const float f_gradient = max ( 0.0f, min (gradient * gradient_gain, 1.0f) );
float out= a4 + f_gradient * f_R * (avg - a4);

return out;
}

}

__kernel void _spatially_varying_smooth_gradients_kernel_f(__global float *src1,  int d_a,
__global float *radius,  int d_radius,
float radius_max,
__global float *dst,  int d_b,
int rows,
int cols,
float post_blur_smooth_gradient_gain,int offset)
{


int tidX=(int)get_global_id(0)+offset;
int tidY=(int)get_global_id(1)+offset;

if(tidX>=(cols-offset)||tidY>=(rows-offset))
return ;

//const int required_padding_size = radius_max + 2;

const float one_ninth = 1.0f/9.0f;

const float R_mask = radius[(tidX)+(tidY)*d_radius];
const float R = min(max (0.0f, radius_max * R_mask), radius_max);

const int R_int =(int)(R + 0.5);
const float f_R =(float)(min (R/2.5f, 1.0f));

dst[tidX+tidY*d_b]=spatially_varying_smooth_gradients_f(src1,R_int ,f_R,one_ninth,tidX,tidY,d_a,post_blur_smooth_gradient_gain);

}



__kernel void _spatially_varying_smooth_gradients_normalization_f(__global float * restrict src1,__global float * restrict src2,__global float * restrict src3,__global float * restrict src4,__global float * restrict src5,  __global float* restrict src6, __global float* restrict srcNormal, int d_a,
__global float *radius,  int d_radius,
float radius_max,
__read_only image2d_t inputColor,
__read_only image2d_t inputAlpha,
__read_only image2d_t inputLayer,
const float selectionBleed,
__read_only image2d_t selectionMask,
__write_only image2d_t dst,
__write_only image2d_t dstAlpha,
__write_only image2d_t dstLayer,
int left,
int top,
int right,
int bottom,
float post_blur_smooth_gradient_gain,int OffsetX,int OffsetY)
{


int tidX=(int)get_global_id(0);
int tidY=(int)get_global_id(1);

if(tidX>(right+1)|| tidY>(bottom+1))
return ;

//Due to linear-sample, need to have the edges replicated
tidX = max(left, tidX);
tidX = min(right, tidX);
tidY = max(top, tidY);
tidY = min(bottom, tidY);
float4 blurColor;
float blurAlpha;
float blurLayer;
float normal=0.0f;
{
const float one_ninth = 1.0f/9.0f;

int tidOffX=tidX-OffsetX;
int tidOffY=tidY-OffsetY;
const float R_mask = radius[(tidX)+(tidY)*d_radius];
const float R = min(max (0.0f, radius_max * R_mask), radius_max);

const int R_int =(int)(R + 0.5);
const float f_R =(float)(min (R/2.5f, 1.0f));

float data0=spatially_varying_smooth_gradients_f(src1,R_int ,f_R,one_ninth,tidOffX,tidOffY, d_a,post_blur_smooth_gradient_gain);
float data1=spatially_varying_smooth_gradients_f(src2,R_int ,f_R,one_ninth,tidOffX,tidOffY, d_a,post_blur_smooth_gradient_gain);
float data2=spatially_varying_smooth_gradients_f(src3,R_int ,f_R,one_ninth,tidOffX,tidOffY,d_a,post_blur_smooth_gradient_gain);
float data3=spatially_varying_smooth_gradients_f(src4,R_int ,f_R,one_ninth,tidOffX,tidOffY,d_a,post_blur_smooth_gradient_gain);
float data4=spatially_varying_smooth_gradients_f(src5,R_int ,f_R,one_ninth,tidOffX,tidOffY,d_a,post_blur_smooth_gradient_gain);
float data5=spatially_varying_smooth_gradients_f(src6,R_int ,f_R,one_ninth,tidOffX,tidOffY,d_a,post_blur_smooth_gradient_gain);
normal=spatially_varying_smooth_gradients_f(srcNormal,R_int ,f_R,one_ninth,tidOffX,tidOffY,d_a,post_blur_smooth_gradient_gain);
blurColor = (float4)(data0/normal,data1/normal,data2/normal,data3/normal);
blurAlpha = data4/normal;
blurLayer = data5/normal;
//Need to account for impact of precision during divide (especially for HDR image)
blurColor /= normal/normal;
blurAlpha /= normal/normal;
blurLayer /= normal/normal;
}

const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
const float4 input = read_imagef(inputColor, sampler, (int2)(tidX, tidY));
const float CMYKalpha = read_imagef(inputAlpha, sampler, (int2)(tidX, tidY)).x;
const float layer = read_imagef(inputLayer, sampler, (int2)(tidX, tidY)).x;
float selection = read_imagef(selectionMask, sampler, (int2)(tidX, tidY)).x;
const float4 selectionVec = (float4)(selection, selection, selection, selection);

const float blendAdd = (1.f-selectionBleed)*(1.f-selection);
const float4 blendInput = blendAdd*input;
const float4 result = normal > 0.f ? (selection*blurColor)+((1-selection)*input) : input;
const float resultAlpha = normal > 0.f ? (selection*blurAlpha)+((1-selection)*CMYKalpha) : CMYKalpha;
const float resultLayer = normal > 0.f ? (selection*blurLayer)+((1-selection)*layer) : layer;
write_imagef(dst,(int2)(get_global_id(0), get_global_id(1)), result);
write_imagef(dstAlpha,(int2)(get_global_id(0), get_global_id(1)), (float4)(resultAlpha, resultAlpha, resultAlpha, resultAlpha));
write_imagef(dstLayer,(int2)(get_global_id(0), get_global_id(1)), (float4)(resultLayer, resultLayer, resultLayer, resultLayer));

}
#ifdef USESTRINGIFY
);
#endif


// buildOptions=-D HALF_POWER=1 -D K_SCALE=2
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D HALF_POWER=1 -D K_SCALE=2" %cfg_path --cl-device=%cl_device 2>&1
