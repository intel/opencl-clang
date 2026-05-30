//OpenCL source code
typedef char                   sbyte;
typedef unsigned char          byte;
typedef          long int Int64;
typedef unsigned long int UInt64;




































































































 float lerp(float n1, float n2, float a)
{
	return n1 + a * (n2 - n1);
}

typedef struct __attribute__((packed)) _Affine2D_struct
{
	float2 xa;
	float2 ya;
	float2 ta;
} Affine2D;

 float2 Affine2D_transformVector(const Affine2D* a, float2 v)
{
	return ((float2)((a->xa.x*v.x + a->ya.x*v.y + a->ta.x),(a->xa.y*v.x + a->ya.y*v.y + a->ta.y)));
}

 float2 Affine2D_transformVector_cm(__constant Affine2D* a, float2 v)
{
	return ((float2)((a->xa.x*v.x + a->ya.x*v.y + a->ta.x),(a->xa.y*v.x + a->ya.y*v.y + a->ta.y)));
}

 void Affine2D_transformPoint(const Affine2D* a, float* x_out, float* y_out, float x, float y)
{
	*x_out = a->xa.x*x + a->ya.x*y + a->ta.x;
	*y_out = a->xa.y*x + a->ya.y*y + a->ta.y;
}

 void Affine2D_getInverse(const Affine2D* a, Affine2D* out)
{
	float det = a->xa.x * a->ya.y - a->xa.y * a->ya.x;

	out->xa.x =  a->ya.y / det;
	out->xa.y = -a->xa.y / det;
	out->ya.x = -a->ya.x / det;
	out->ya.y =  a->xa.x / det;
	out->ta.x = (a->ta.y * a->ya.x - a->ta.x * a->ya.y) / det;
	out->ta.y = (a->ta.x * a->xa.y - a->ta.y * a->xa.x) / det;
}


typedef struct __attribute__((packed)) _FractalInfo_struct
{
	uint     branchCount;
	float    brightness;
	float    invGamma;
	float    vibrancy;
	float4   bgColor;
	Affine2D vpsTransform;
	float    reserved0;
	float    reserved1;
} FractalInfo;


typedef struct __attribute__((packed)) _BranchInfo_struct
{
	uint     normWeight;
	float    colorWeight;
	float2   chroma;
	Affine2D preTransform;
	Affine2D postTransform;
} BranchInfo;


typedef struct _IterStatEntry_struct
{
	UInt64 dotCount;
	float  peakDensity;
	float  reserved0;
} IterStatEntry;


typedef struct __attribute__((packed)) _GlobalStatEntry_struct
{
	UInt64 iterCount;
	UInt64 dotCount;
	float  density;
	float  peakDensity;
	float  scaleConstant;
} GlobalStatEntry;


typedef struct __attribute__((packed)) _Dot_struct
{
	float2 pos;
	float2 chroma;
} Dot;


















 unsigned int MWC_rand(
	__local uint4* x,
	__local uint*  c
);

 void MWC_seed(
	__local uint4* x,
	__local uint*  c,
	            uint seed
){
	int j;
	(*x).x = seed * 29943829 - 1;
	(*x).y = (*x).x  * 29943829 - 1;
	(*x).z = (*x).y  * 29943829 - 1;
	(*x).w = (*x).z  * 29943829 - 1;
	*c     = (*x).w  * 29943829 - 1;
	for(j = 0; j < 19; j++)
		MWC_rand(x, c);
}

 unsigned int MWC_rand(
	__local uint4* x,
	__local uint*  c
){
	UInt64 sum =
		((UInt64)2111111111)*(UInt64)(*x).w +
		((UInt64)1492)*(UInt64)(*x).z +
		((UInt64)1776)*(UInt64)(*x).y +
		((UInt64)5115)*(UInt64)(*x).x +
		      (UInt64)(*c);

	(*x).w = (*x).z;
	(*x).z = (*x).y;
	(*x).y = (*x).x;
	(*x).x = (uint)sum;
	*c     = (uint)(sum >> 32);
	return (*x).x;
}

 float2 MWC_rand_float2(
	__local uint4* x,
	__local uint*  c
){
	float2 result;
	uint rnd = MWC_rand(x, c);
	result.x = (float)(rnd&0xFFFF) / 32768.0f - 1.0f;
	result.y = (float)(rnd>>16)   / 32768.0f - 1.0f;
	return result;
}

















































































































































































































 float2 vari_linear(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	return v;
}

 float2 vari_sinusoidal(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	return ((float2)((native_sin(v.x)),(native_sin(v.y))));
}

 float2 vari_spherical(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	return ((float2)((v.x / (rsq+(4.7019774E-38f))),(v.y / (rsq+(4.7019774E-38f)))));
}

 float2 vari_swirl(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	float j = native_sin(rsq);
	float k = native_cos(rsq);
	return ((float2)((j*v.x - k*v.y),(k*v.x + j*v.y)));
}

 float2 vari_horseshoe(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	return ((float2)(((v.x*v.x - v.y*v.y)/(r+(4.7019774E-38f))),((2.0f*v.x*v.y)/(r+(4.7019774E-38f)))));
}

 float2 vari_polar(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	return ((float2)((theta / 3.14159265358f),(r - 1.0f)));
}

 float2 vari_handkerchief(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	return ((float2)((r * native_sin(theta+r)),(r * native_cos(theta-r))));
}

 float2 vari_heart(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	return ((float2)((r*native_sin(theta*r)),(-r*native_cos(theta*r))));
}

 float2 vari_disc(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	return ((float2)((theta*native_sin(3.14159265358f*r)/3.14159265358f),(theta*native_cos(3.14159265358f*r)/3.14159265358f)));
}

 float2 vari_spiral(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	return ((float2)(((native_cos(theta) + native_sin(r))/(r+(4.7019774E-38f))),((native_sin(theta) - native_cos(r))/(r+(4.7019774E-38f)))));
}

 float2 vari_hyperbolic(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	return ((float2)((v.y/(rsq+(4.7019774E-38f))),(v.x)));
}

 float2 vari_diamond(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	return ((float2)((v.y / (r+(4.7019774E-38f)) * native_cos(r)),(v.x / (r+(4.7019774E-38f)) * native_sin(r))));
}

 float2 vari_ex(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	float j,k;
	j = native_cos(r)*v.y + native_sin(r)*v.x;
	k = native_sin(r)*v.y + native_cos(r)*v.x;
	return ((float2)((j*j*j/(rsq+(4.7019774E-38f))),(k*k*k/(rsq+(4.7019774E-38f)))));
}

 float2 vari_julia(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	float k = 0.5f*theta + 3.14159265358f*(float)(entropy&0x0001);
	return ((float2)((native_sqrt(r)*native_cos(k)),(native_sqrt(r)*native_sin(k))));
}

 float2 vari_bent(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	return ((float2)((v.x >= 0 ? v.x : 2.0f*v.x),(v.y >= 0 ? v.y : v.y*0.5f)));
}

 float2 vari_waves(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	return ((float2)((v.x + branch->preTransform.ya.x * native_sin(v.y/(branch->preTransform.ta.x*branch->preTransform.ta.x + (4.7019774E-38f)))),(v.y + branch->preTransform.ya.y * native_sin(v.x/(branch->preTransform.ta.y*branch->preTransform.ta.y + (4.7019774E-38f))))));
}

 float2 vari_fisheye(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	float k = 2.0f/(r+1.0f);
	return ((float2)((k*v.y),(k*v.x)));
}

 float2 vari_popcorn(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	return ((float2)((v.x + branch->preTransform.ta.x*native_sin(native_tan(3.0f*v.y))),(v.y + branch->preTransform.ta.y*native_sin(native_tan(3.0f*v.x)))));
}

 float2 vari_exponential(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	float k = native_exp(v.x - 1.0f);
	return ((float2)((native_sin(3.14159265358f*v.y)*k),(native_cos(3.14159265358f*v.y)*k)));
}

 float2 vari_power(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	float k;
	float nx = v.x/(r+(4.7019774E-38f));
	float ny = v.y/(r+(4.7019774E-38f));
	k = native_powr(r,ny);
	return ((float2)((nx * k),(ny * k)));
}

 float2 vari_cosine(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	float cosh_ty = 0.5f*(native_exp(v.y) - native_exp(-v.y));
	float sinh_ty = 0.5f*(native_exp(v.y) + native_exp(-v.y));
	return ((float2)((native_cos(3.14159265358f*v.x)*cosh_ty),(-1.0f*native_sin(3.14159265358f*v.x)*sinh_ty)));
}

 float2 vari_eyefish(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	float k = 2.0f/(r+1.0f);
	return ((float2)((k*v.x),(k*v.y)));
}

 float2 vari_bubble(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	float k = 4.0f / (rsq + 4.0f);
	return ((float2)((k*v.x),(k*v.y)));
}

 float2 vari_cylinder(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	return ((float2)((native_sin(v.x)),(v.y)));
}

 float2 vari_noise(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	float p1,p2;
	uint rnd = MWC_rand(randX, randC);
	p1 = (float)(rnd>>16) / 65536.0f;
	p2 = 2.0f*3.14159265358f*(float)(rnd&0x0000FFFF) / 65536.0f;

	return ((float2)((p1*native_cos(p2)*v.x),(p1*native_sin(p2)*v.y)));
}

 float2 vari_blur(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	float br,bt;
	uint rnd = MWC_rand(randX, randC);
	br = (float)(rnd>>16) / 65536.0f;
	bt = 2.0f * 3.14159265358f * (float)(rnd&0x0000FFFF) / 65536.0f;

	return ((float2)((native_cos(bt)*br),(native_sin(bt)*br)));
}

 float2 vari_gaussian_blur(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	float br,bt;
	uint rnd;
	uint sum = 0;

	rnd = MWC_rand(randX, randC);
	sum += (rnd&0x0000FFFF) + (rnd>>16);
	rnd = MWC_rand(randX, randC);
	sum += (rnd&0x0000FFFF) + (rnd>>16);
	br = (float)sum / 65536.0f - 2.0f;
	bt = 2.0f * 3.14159265358f * (float)(entropy&0x0000FFFF) / 65536.0f;

	return ((float2)((native_cos(bt)*br),(native_sin(bt)*br)));
}

 float2 vari_orb9k(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	float k = 2.0f/(rsq+1.0f);
	return ((float2)((k*v.x),(k*v.y)));
}

 float2 vari_ripple9k(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	float k = native_sin(r*1.57079632679f);
	return ((float2)((k*v.x),(k*v.y)));
}

 float2 vari_bulge9k(
	float2 v,
	__constant BranchInfo* branch,
	float theta, float r, float rsq, uint entropy,
	__local uint4*      randX,
	__local uint*       randC
){
	float k = (r+1.0f)/(r+(4.7019774E-38f));
	return ((float2)((k*v.x),(k*v.y)));
}



 uint chooseRandomBranch(
	uint rnd,
	uint branchCount,
	__constant BranchInfo branches[]
){
	uint i;

	for(i = 0; i < 16; i++)
		if(rnd < branches[i].normWeight)
			return i;

	return i;
}








 void iterate(
	__private float2*   pos,
	__private float2*   color,
	            uint      entropy,
	__constant BranchInfo* branch,
	__constant float       branchVariWeights[],
	__local uint4*      randX,
	__local uint*       randC
){
	float2 t;
	float2 vn;
	float2 result;
	float theta, rsq, r;
	result.x = 0.0f;
	result.y = 0.0f;

	(*color).x = lerp((*color).x, branch->chroma.x, branch->colorWeight);
	(*color).y = lerp((*color).y, branch->chroma.y, branch->colorWeight);

	t = Affine2D_transformVector_cm(&(branch->preTransform), *pos);
	theta = atan2(t.x,t.y);
	rsq = t.x*t.x + t.y*t.y;
	r = native_sqrt(rsq);

	if(branchVariWeights[0] > 0.0f){ vn = vari_linear(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[0]*vn.x; result.y += branchVariWeights[0]*vn.y; }
	if(branchVariWeights[1] > 0.0f){ vn = vari_sinusoidal(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[1]*vn.x; result.y += branchVariWeights[1]*vn.y; }
	if(branchVariWeights[2] > 0.0f){ vn = vari_spherical(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[2]*vn.x; result.y += branchVariWeights[2]*vn.y; }
	if(branchVariWeights[3] > 0.0f){ vn = vari_swirl(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[3]*vn.x; result.y += branchVariWeights[3]*vn.y; }
	if(branchVariWeights[4] > 0.0f){ vn = vari_horseshoe(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[4]*vn.x; result.y += branchVariWeights[4]*vn.y; }
	if(branchVariWeights[5] > 0.0f){ vn = vari_polar(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[5]*vn.x; result.y += branchVariWeights[5]*vn.y; }
	if(branchVariWeights[6] > 0.0f){ vn = vari_handkerchief(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[6]*vn.x; result.y += branchVariWeights[6]*vn.y; }
	if(branchVariWeights[7] > 0.0f){ vn = vari_heart(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[7]*vn.x; result.y += branchVariWeights[7]*vn.y; }
	if(branchVariWeights[8] > 0.0f){ vn = vari_disc(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[8]*vn.x; result.y += branchVariWeights[8]*vn.y; }
	if(branchVariWeights[9] > 0.0f){ vn = vari_spiral(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[9]*vn.x; result.y += branchVariWeights[9]*vn.y; }
	if(branchVariWeights[10] > 0.0f){ vn = vari_hyperbolic(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[10]*vn.x; result.y += branchVariWeights[10]*vn.y; }
	if(branchVariWeights[11] > 0.0f){ vn = vari_diamond(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[11]*vn.x; result.y += branchVariWeights[11]*vn.y; }
	if(branchVariWeights[12] > 0.0f){ vn = vari_ex(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[12]*vn.x; result.y += branchVariWeights[12]*vn.y; }
	if(branchVariWeights[13] > 0.0f){ vn = vari_julia(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[13]*vn.x; result.y += branchVariWeights[13]*vn.y; }
	if(branchVariWeights[14] > 0.0f){ vn = vari_bent(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[14]*vn.x; result.y += branchVariWeights[14]*vn.y; }
	if(branchVariWeights[15] > 0.0f){ vn = vari_waves(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[15]*vn.x; result.y += branchVariWeights[15]*vn.y; }
	if(branchVariWeights[16] > 0.0f){ vn = vari_fisheye(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[16]*vn.x; result.y += branchVariWeights[16]*vn.y; }
	if(branchVariWeights[17] > 0.0f){ vn = vari_popcorn(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[17]*vn.x; result.y += branchVariWeights[17]*vn.y; }
	if(branchVariWeights[18] > 0.0f){ vn = vari_exponential(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[18]*vn.x; result.y += branchVariWeights[18]*vn.y; }
	if(branchVariWeights[19] > 0.0f){ vn = vari_power(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[19]*vn.x; result.y += branchVariWeights[19]*vn.y; }
	if(branchVariWeights[20] > 0.0f){ vn = vari_cosine(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[20]*vn.x; result.y += branchVariWeights[20]*vn.y; }
	if(branchVariWeights[21] > 0.0f){ vn = vari_eyefish(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[21]*vn.x; result.y += branchVariWeights[21]*vn.y; }
	if(branchVariWeights[22] > 0.0f){ vn = vari_bubble(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[22]*vn.x; result.y += branchVariWeights[22]*vn.y; }
	if(branchVariWeights[23] > 0.0f){ vn = vari_cylinder(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[23]*vn.x; result.y += branchVariWeights[23]*vn.y; }
	if(branchVariWeights[24] > 0.0f){ vn = vari_noise(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[24]*vn.x; result.y += branchVariWeights[24]*vn.y; }
	if(branchVariWeights[25] > 0.0f){ vn = vari_blur(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[25]*vn.x; result.y += branchVariWeights[25]*vn.y; }
	if(branchVariWeights[26] > 0.0f){ vn = vari_gaussian_blur(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[26]*vn.x; result.y += branchVariWeights[26]*vn.y; }
	if(branchVariWeights[27] > 0.0f){ vn = vari_orb9k(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[27]*vn.x; result.y += branchVariWeights[27]*vn.y; }
	if(branchVariWeights[28] > 0.0f){ vn = vari_ripple9k(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[28]*vn.x; result.y += branchVariWeights[28]*vn.y; }
	if(branchVariWeights[29] > 0.0f){ vn = vari_bulge9k(t, branch, theta, r, rsq, entropy, randX, randC); result.x += branchVariWeights[29]*vn.x; result.y += branchVariWeights[29]*vn.y; }

	*pos = Affine2D_transformVector_cm(&(branch->postTransform), result);
}




















__kernel void init_iterators_kernel(
	__global uint4 entropyXBuffer[],
	__global uint  entropyCBuffer[],
	__global uint  entropySeedBuffer[]
){
	__local uint4 randXBuffer   [128];
	__local uint  randCBuffer   [128];
	__local uint  randSeedBuffer[128];

	uint lid = get_local_id(0);
	uint gid = get_global_id(0);

	randXBuffer[lid]    = ((uint4)((0),(0),(0),(0)));
	randCBuffer[lid]    = 0;
	randSeedBuffer[lid] = entropySeedBuffer[gid];

	MWC_seed(randXBuffer+lid, randCBuffer+lid, randSeedBuffer[lid]);

	entropyXBuffer[gid] = randXBuffer[lid];
	entropyCBuffer[gid] = randCBuffer[lid];
}

__kernel void reset_iterators_kernel(
	             uint             xRes,
	             uint             yRes,

	__constant    FractalInfo*     fractalInfo,
	__constant    BranchInfo       branchInfo[],
	__constant    float            variWeightBuffer[],

	__global   float2           iterPosStateBuffer[],
	__global   float2           iterColorStateBuffer[],
	__global   IterStatEntry    iterStatBuffer[],
	__global   GlobalStatEntry* globalStatBuffer,
	__global   uint4            entropyXBuffer[],
	__global   uint             entropyCBuffer[],
	__global   uint             entropySeedBuffer[]
){
	int iter;
	uint bi;
	float2 pos;
	float2 color;
	uint rnd;

	__local uint4 randXBuffer   [128];
	__local uint  randCBuffer   [128];
	__local uint  randSeedBuffer[128];

	uint lid = get_local_id(0);
	uint gid = get_global_id(0);

	randXBuffer[lid]    = ((uint4)((0),(0),(0),(0)));
	randCBuffer[lid]    = 0;
	randSeedBuffer[lid] = entropySeedBuffer[gid];

	MWC_seed(randXBuffer+lid, randCBuffer+lid, randSeedBuffer[lid]);

	pos = MWC_rand_float2(randXBuffer+lid, randCBuffer+lid);




	color = ((float2)((0.5f),(0.5f)));

	for(iter = 0; iter < 32; iter++)
	{
		rnd = MWC_rand(randXBuffer+lid, randCBuffer+lid);
		bi = chooseRandomBranch(rnd & 0x0000FFFF, fractalInfo->branchCount, branchInfo);
		iterate(&pos, &color, (rnd>>16), branchInfo+bi, variWeightBuffer+(bi*48), randXBuffer+lid, randCBuffer+lid);
	}

	iterPosStateBuffer[gid] = pos;
	iterColorStateBuffer[gid] = color;
	iterStatBuffer[gid].dotCount = 0;
	iterStatBuffer[gid].peakDensity = 0.0f;

	if(gid == 0)
	{
		globalStatBuffer->iterCount =     0;
		globalStatBuffer->dotCount =      0;
		globalStatBuffer->density  =      0.0f;
		globalStatBuffer->peakDensity =   0.0f;
		globalStatBuffer->scaleConstant = 0.0f;
	}
}

__kernel void reset_output_kernel(
	int xRes,
	int yRes,
	__global float4  accumBuffer[],
	__global uint    outputBuffer[]
)
{
	int x = get_global_id(0);
	int y = get_global_id(1);

	if(x < xRes && y < yRes)
	{
		(*((accumBuffer + 4*((((y))*xRes) + ((x))) + 2*((0)) + ((0))))) = ((float4)((0.0f),(0.0f),(0.0f),(0.0f)));
		(*((accumBuffer + 4*((((y))*xRes) + ((x))) + 2*((1)) + ((0))))) = ((float4)((0.0f),(0.0f),(0.0f),(0.0f)));
		(*((accumBuffer + 4*((((y))*xRes) + ((x))) + 2*((0)) + ((1))))) = ((float4)((0.0f),(0.0f),(0.0f),(0.0f)));
		(*((accumBuffer + 4*((((y))*xRes) + ((x))) + 2*((1)) + ((1))))) = ((float4)((0.0f),(0.0f),(0.0f),(0.0f)));

		(*((outputBuffer + (((y))*xRes) + ((x))))) = 0x00000000;
	}
}














__kernel void iterate_kernel(
	             uint             xRes,
	             uint             yRes,

	__constant    FractalInfo*     fractalInfo,
	__constant    BranchInfo       branchInfo[],
	__constant    float            variWeightBuffer[],

	__global   float2           iterPosStateBuffer[],
	__global   float2           iterColorStateBuffer[],
	__global   IterStatEntry    iterStatBuffer[],
	__global   GlobalStatEntry* globalStatBuffer,
	__global   uint4            entropyXBuffer[],
	__global   uint             entropyCBuffer[],
	__global   float4           accumBuffer[],






	__read_only  image2d_t        palette,
	             sampler_t        paletteSampler,


	             uint             iterCount
){
	float2 pos;
	float2 color;
	float4 sample = ((float4)((1.0f),(1.0f),(1.0f),(1.0f)));

	float4 mem;
	uint bi;
	float2 screenPos;
	UInt64 dotCount;
	float peakDensity;
	int xa,ya;
	int x,y;
	uint iter;
	uint rnd;

	__local uint4 randXBuffer   [128];
	__local uint  randCBuffer   [128];

	uint lid = get_local_id(0);
	uint gid = get_global_id(0);

	pos =       iterPosStateBuffer[gid];
	color =     iterColorStateBuffer[gid];
	dotCount =  iterStatBuffer[gid].dotCount;
	peakDensity = iterStatBuffer[gid].peakDensity;
	randXBuffer[lid] = entropyXBuffer[gid];
	randCBuffer[lid] = entropyCBuffer[gid];


	for(iter = 0; iter < iterCount; iter++)
	{
		rnd = MWC_rand(randXBuffer+lid, randCBuffer+lid);
		bi = chooseRandomBranch(rnd & 0x0000FFFF, fractalInfo->branchCount, branchInfo);

		iterate(&pos, &color, (rnd>>16), branchInfo+bi, variWeightBuffer+(bi*48), randXBuffer+lid, randCBuffer+lid);

		screenPos = Affine2D_transformVector_cm(&(fractalInfo->vpsTransform), pos);

		xa = (int)(2.0f*screenPos.x);
		ya = (int)(2.0f*screenPos.y);
		x  = xa >> 1;
		y  = ya >> 1;

		if(x >= 0 && x < xRes && y >= 0 && y < yRes)
		{




			sample = read_imagef(palette, paletteSampler, color);








			mem = (*((accumBuffer + 4*((((y))*xRes) + ((x))) + 2*(((ya&1))) + (((xa&1))))));
			mem.x += sample.x;
			mem.y += sample.y;
			mem.z += sample.z;
			mem.w += 1.0f;
			(*((accumBuffer + 4*((((y))*xRes) + ((x))) + 2*(((ya&1))) + (((xa&1)))))) = mem;

			dotCount++;
			peakDensity = fmax(peakDensity,mem.w);
		}
	}


	iterPosStateBuffer[gid]   = pos;
	iterColorStateBuffer[gid] = color;
	iterStatBuffer[gid].dotCount = dotCount;
	iterStatBuffer[gid].peakDensity = peakDensity;
	entropyXBuffer[gid] = randXBuffer[lid];
	entropyCBuffer[gid] = randCBuffer[lid];

	if(gid == 0)
	{
		globalStatBuffer->iterCount += (UInt64)(get_global_size(0) * iterCount);
	}
}


__kernel void update_stats_kernel(
                 uint             xRes,
                 uint             yRes,

	__constant    FractalInfo*     fractalInfo,

                 uint             iteratorCount,
	__global   IterStatEntry    iterStatBuffer[],
	__global   GlobalStatEntry* globalStatBuffer
){
	UInt64 totalIterationCount = 0;
	UInt64 totalDotCount = 0;
	float peakDensity = 0.0f;
	int i;
	float totalSubPixels, density, invPixArea, scaleConstant;

	if(get_global_id(0) == 0)
	{
		for(i = 0; i < iteratorCount; i++)
		{
			totalDotCount += iterStatBuffer[i].dotCount;
			peakDensity = fmax(peakDensity,iterStatBuffer[i].peakDensity);
		}
		totalIterationCount = globalStatBuffer->iterCount;
		totalSubPixels = (float)(xRes*yRes*(2*2));
		density = (float)totalDotCount / totalSubPixels;
		invPixArea = fabs((fractalInfo->vpsTransform.xa.x)*(fractalInfo->vpsTransform.ya.y) - (fractalInfo->vpsTransform.xa.y)*(fractalInfo->vpsTransform.ya.x));
		scaleConstant = (64.0f/1.0f)*(invPixArea*(float)(2*2))/(float)totalIterationCount;

		globalStatBuffer->dotCount = totalDotCount;
		globalStatBuffer->density = fmax(density,(4.7019774E-38f));
		globalStatBuffer->peakDensity = fmax(peakDensity,(4.7019774E-38f));
		globalStatBuffer->scaleConstant = fmax(scaleConstant,(4.7019774E-38f));
	}
}


 float4 tonemap(__constant FractalInfo* fractal, float4 rawPix, float scaleConstant)
{
	float z, ka, gammaFactor;
	float4 logPix;
	float4 result;

	logPix.w = (1.0f/2.0f) * fractal->brightness * native_log10(1.0f+rawPix.w*scaleConstant);
	ka = logPix.w / rawPix.w;

	logPix.x = ka * rawPix.x;
	logPix.y = ka * rawPix.y;
	logPix.z = ka * rawPix.z;

	z = native_powr(logPix.w,fractal->invGamma);
	gammaFactor = z / logPix.w;

	result.x = clamp((lerp(native_powr(logPix.x,fractal->invGamma), gammaFactor*logPix.x, fractal->vibrancy)),0.0f,1.0f);
	result.y = clamp((lerp(native_powr(logPix.y,fractal->invGamma), gammaFactor*logPix.y, fractal->vibrancy)),0.0f,1.0f);
	result.z = clamp((lerp(native_powr(logPix.z,fractal->invGamma), gammaFactor*logPix.z, fractal->vibrancy)),0.0f,1.0f);
	result.w = clamp((z),0.0f,1.0f);

	return result;
}

__kernel void update_output_kernel(
	           uint             xRes,
	           uint             yRes,

	__constant  FractalInfo*     fractalInfo,

	__global GlobalStatEntry* globalStatBuffer,
	__global float4           accumBuffer[],
	__global uint             outputBuffer[]
){
	uint4 iPix;
	float4 pix,acc;
	float scaleConstant;

	int x = get_global_id(0);
	int y = get_global_id(1);

	acc = ((float4)((0.0f),(0.0f),(0.0f),(0.0f)));

	if(x < xRes && y < yRes)
	{
		scaleConstant = globalStatBuffer->scaleConstant;

		pix = tonemap( fractalInfo, (*((accumBuffer + 4*((((y))*xRes) + ((x))) + 2*((0)) + ((0))))), scaleConstant);
		acc.x += pix.w*pix.x;
		acc.y += pix.w*pix.y;
		acc.z += pix.w*pix.z;
		acc.w += pix.w;

		pix = tonemap( fractalInfo, (*((accumBuffer + 4*((((y))*xRes) + ((x))) + 2*((1)) + ((0))))), scaleConstant);
		acc.x += pix.w*pix.x;
		acc.y += pix.w*pix.y;
		acc.z += pix.w*pix.z;
		acc.w += pix.w;

		pix = tonemap( fractalInfo, (*((accumBuffer + 4*((((y))*xRes) + ((x))) + 2*((0)) + ((1))))), scaleConstant);
		acc.x += pix.w*pix.x;
		acc.y += pix.w*pix.y;
		acc.z += pix.w*pix.z;
		acc.w += pix.w;

		pix = tonemap( fractalInfo, (*((accumBuffer + 4*((((y))*xRes) + ((x))) + 2*((1)) + ((1))))), scaleConstant);
		acc.x += pix.w*pix.x;
		acc.y += pix.w*pix.y;
		acc.z += pix.w*pix.z;
		acc.w += pix.w;

		if(acc.w < (1.0f/256.0f))
		{
			iPix = ((uint4)((0),(0),(0),(0)));
		}
		else
		{
			acc.x /= acc.w;
			acc.y /= acc.w;
			acc.z /= acc.w;
			acc.w *= 0.25f;

			iPix.x = (uint)(255.0f*acc.x) & 0xFF;
			iPix.y = (uint)(255.0f*acc.y) & 0xFF;
			iPix.z = (uint)(255.0f*acc.z) & 0xFF;
			iPix.w = (uint)(255.0f*acc.w) & 0xFF;
		}

		(*((outputBuffer + (((y))*xRes) + ((x))))) = iPix.w << 24 | iPix.z << 16 | iPix.y << 8 | iPix.x;
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
