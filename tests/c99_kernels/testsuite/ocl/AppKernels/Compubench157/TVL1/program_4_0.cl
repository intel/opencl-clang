#define USE_UNORM

#define BC symmBC

// clamp condition
inline int clampBC(const int x, const int y, const int nx, const int ny)
{
	const int idx = clamp(x,0,nx-1);
	const int idy = clamp(y,0,ny-1);
	return idx + idy * nx;
}

// periodic boundary condition
inline int perBC(const int x, const int y, const int nx, const int ny)
{
	const int idx = x < 0 ? x + nx*(-x/nx+1) : x - nx*(x/nx);
	const int idy = y < 0 ? y + ny*(-y/ny+1) : y - ny*(y/ny);
	return idx + idy * nx;
}

// symmetry boundary condition
inline int symmBC(const int x, const int y, const int nx, const int ny)
{
	int idx = x;
	int idy = y;
	if (x < 0) idx = (-x % (int)nx)-1;
	if (y < 0) idy = (-y % (int)ny)-1;
	if (nx <= x) idx = (nx-1) - (x % (int)nx);
	if (ny <= y) idy = (ny-1) - (y % (int)ny);
	return idx + idy * nx;
}

__kernel void gauss5x5(
	__read_only image2d_t input,
	__write_only image2d_t output,
	const int nx,
	const int ny
	)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);

	if (idx >= nx || idy >= ny)
		return;

	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	// perform convolution
	float4 result = (float4)(0.0f);

	result +=  2.0f/571.0f * read_imagef(input,sampler,(int2)(idx-2,idy-2));
	result +=  7.0f/571.0f * read_imagef(input,sampler,(int2)(idx-1,idy-2));
	result += 12.0f/571.0f * read_imagef(input,sampler,(int2)(idx  ,idy-2));
	result +=  7.0f/571.0f * read_imagef(input,sampler,(int2)(idx+1,idy-2));
	result +=  2.0f/571.0f * read_imagef(input,sampler,(int2)(idx+2,idy-2));

	result +=  7.0f/571.0f * read_imagef(input,sampler,(int2)(idx-2,idy-1));
	result += 31.0f/571.0f * read_imagef(input,sampler,(int2)(idx-1,idy-1));
	result += 52.0f/571.0f * read_imagef(input,sampler,(int2)(idx  ,idy-1));
	result += 31.0f/571.0f * read_imagef(input,sampler,(int2)(idx+1,idy-1));
	result +=  7.0f/571.0f * read_imagef(input,sampler,(int2)(idx+2,idy-1));

	result += 12.0f/571.0f * read_imagef(input,sampler,(int2)(idx-2,idy  ));
	result += 52.0f/571.0f * read_imagef(input,sampler,(int2)(idx-1,idy  ));
	result +=127.0f/571.0f * read_imagef(input,sampler,(int2)(idx  ,idy  ));
	result += 52.0f/571.0f * read_imagef(input,sampler,(int2)(idx+1,idy  ));
	result += 12.0f/571.0f * read_imagef(input,sampler,(int2)(idx+2,idy  ));

	result +=  7.0f/571.0f * read_imagef(input,sampler,(int2)(idx-2,idy+1));
	result += 31.0f/571.0f * read_imagef(input,sampler,(int2)(idx-1,idy+1));
	result += 52.0f/571.0f * read_imagef(input,sampler,(int2)(idx  ,idy+1));
	result += 31.0f/571.0f * read_imagef(input,sampler,(int2)(idx+1,idy+1));
	result +=  7.0f/571.0f * read_imagef(input,sampler,(int2)(idx+2,idy+1));

	result +=  2.0f/571.0f * read_imagef(input,sampler,(int2)(idx-2,idy+2));
	result +=  7.0f/571.0f * read_imagef(input,sampler,(int2)(idx-1,idy+2));
	result += 12.0f/571.0f * read_imagef(input,sampler,(int2)(idx  ,idy+2));
	result +=  7.0f/571.0f * read_imagef(input,sampler,(int2)(idx+1,idy+2));
	result +=  2.0f/571.0f * read_imagef(input,sampler,(int2)(idx+2,idy+2));

	write_imagef(output,(int2)(idx,idy),result);
}

__kernel void median3x3(
	const __global float2* restrict input,
	__global float2* restrict output,
	const int nx,
	const int ny
	)
{
	const int idx = get_global_id(0);
	const int idy = get_global_id(1);
	const int id  = idx + idy * nx;

	if (idx >= nx || idy >= ny)
		return;

	float2 window[9];

	window[0] = input[clampBC(idx-1,idy-1,nx,ny)];
	window[1] = input[clampBC(idx  ,idy-1,nx,ny)];
	window[2] = input[clampBC(idx+1,idy-1,nx,ny)];

	window[3] = input[clampBC(idx-1,idy  ,nx,ny)];
	window[4] = input[clampBC(idx  ,idy  ,nx,ny)];
	window[5] = input[clampBC(idx+1,idy  ,nx,ny)];

	window[6] = input[clampBC(idx-1,idy+1,nx,ny)];
	window[7] = input[clampBC(idx  ,idy+1,nx,ny)];
	window[8] = input[clampBC(idx+1,idy+1,nx,ny)];

	// perform partial bitonic sort to find current median
	float2 flMin = min(window[0], window[1]);
	float2 flMax = max(window[0], window[1]);
	window[0] = flMin;
	window[1] = flMax;

	flMin = min(window[3], window[2]);
	flMax = max(window[3], window[2]);
	window[3] = flMin;
	window[2] = flMax;

	flMin = min(window[2], window[0]);
	flMax = max(window[2], window[0]);
	window[2] = flMin;
	window[0] = flMax;

	flMin = min(window[3], window[1]);
	flMax = max(window[3], window[1]);
	window[3] = flMin;
	window[1] = flMax;

	flMin = min(window[1], window[0]);
	flMax = max(window[1], window[0]);
	window[1] = flMin;
	window[0] = flMax;

	flMin = min(window[3], window[2]);
	flMax = max(window[3], window[2]);
	window[3] = flMin;
	window[2] = flMax;

	flMin = min(window[5], window[4]);
	flMax = max(window[5], window[4]);
	window[5] = flMin;
	window[4] = flMax;

	flMin = min(window[7], window[8]);
	flMax = max(window[7], window[8]);
	window[7] = flMin;
	window[8] = flMax;

	flMin = min(window[6], window[8]);
	flMax = max(window[6], window[8]);
	window[6] = flMin;
	window[8] = flMax;

	flMin = min(window[6], window[7]);
	flMax = max(window[6], window[7]);
	window[6] = flMin;
	window[7] = flMax;

	flMin = min(window[4], window[8]);
	flMax = max(window[4], window[8]);
	window[4] = flMin;
	window[8] = flMax;

	flMin = min(window[4], window[6]);
	flMax = max(window[4], window[6]);
	window[4] = flMin;
	window[6] = flMax;

	flMin = min(window[5], window[7]);
	flMax = max(window[5], window[7]);
	window[5] = flMin;
	window[7] = flMax;

	flMin = min(window[4], window[5]);
	flMax = max(window[4], window[5]);
	window[4] = flMin;
	window[5] = flMax;

	flMin = min(window[6], window[7]);
	flMax = max(window[6], window[7]);
	window[6] = flMin;
	window[7] = flMax;

	flMin = min(window[0], window[8]);
	flMax = max(window[0], window[8]);
	window[0] = flMin;
	window[8] = flMax;

	window[4] = max(window[0], window[4]);
	window[5] = max(window[1], window[5]);

	window[6] = max(window[2], window[6]);
	window[7] = max(window[3], window[7]);

	window[4] = min(window[4], window[6]);
	window[5] = min(window[5], window[7]);

	output[id] = min(window[4], window[5]);
}

__kernel void binom5x5UpSample(
	const __global float2* restrict input,
	__global float2* restrict output,
	const int nx,
	const int ny
	)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);
	int id = idx + idy * nx * 2;

	// perform convolution
	float2 out = (float2)(0.0f, 0.0f);

	// only works if BC = symmetry
	// other BCs require different setup

	out +=  1.0f/256.0f * !((idx-2)%2) * !((idy-2)%2) * input[BC((idx-2)/2,(idy-2)/2,nx,ny)];
	out +=  4.0f/256.0f * !((idx-1)%2) * !((idy-2)%2) * input[BC((idx-1)/2,(idy-2)/2,nx,ny)];
	out +=  6.0f/256.0f * !((idx  )%2) * !((idy-2)%2) * input[BC((idx  )/2,(idy-2)/2,nx,ny)];
	out +=  4.0f/256.0f * !((idx+1)%2) * !((idy-2)%2) * input[BC((idx+1)/2,(idy-2)/2,nx,ny)];
	out +=  1.0f/256.0f * !((idx+2)%2) * !((idy-2)%2) * input[BC((idx+2)/2,(idy-2)/2,nx,ny)];

	out +=  4.0f/256.0f * !((idx-2)%2) * !((idy-1)%2) * input[BC((idx-2)/2,(idy-1)/2,nx,ny)];
	out += 16.0f/256.0f * !((idx-1)%2) * !((idy-1)%2) * input[BC((idx-1)/2,(idy-1)/2,nx,ny)];
	out += 24.0f/256.0f * !((idx  )%2) * !((idy-1)%2) * input[BC((idx  )/2,(idy-1)/2,nx,ny)];
	out += 16.0f/256.0f * !((idx+1)%2) * !((idy-1)%2) * input[BC((idx+1)/2,(idy-1)/2,nx,ny)];
	out +=  4.0f/256.0f * !((idx+2)%2) * !((idy-1)%2) * input[BC((idx+2)/2,(idy-1)/2,nx,ny)];

	out +=  6.0f/256.0f * !((idx-2)%2) * !((idy  )%2) * input[BC((idx-2)/2,(idy  )/2,nx,ny)];
	out += 24.0f/256.0f * !((idx-1)%2) * !((idy  )%2) * input[BC((idx-1)/2,(idy  )/2,nx,ny)];
	out += 36.0f/256.0f * !((idx  )%2) * !((idy  )%2) * input[BC((idx  )/2,(idy  )/2,nx,ny)];
	out += 24.0f/256.0f * !((idx+1)%2) * !((idy  )%2) * input[BC((idx+1)/2,(idy  )/2,nx,ny)];
	out +=  6.0f/256.0f * !((idx+2)%2) * !((idy  )%2) * input[BC((idx+2)/2,(idy  )/2,nx,ny)];

	out +=  4.0f/256.0f * !((idx-2)%2) * !((idy+1)%2) * input[BC((idx-2)/2,(idy+1)/2,nx,ny)];
	out += 16.0f/256.0f * !((idx-1)%2) * !((idy+1)%2) * input[BC((idx-1)/2,(idy+1)/2,nx,ny)];
	out += 24.0f/256.0f * !((idx  )%2) * !((idy+1)%2) * input[BC((idx  )/2,(idy+1)/2,nx,ny)];
	out += 16.0f/256.0f * !((idx+1)%2) * !((idy+1)%2) * input[BC((idx+1)/2,(idy+1)/2,nx,ny)];
	out +=  4.0f/256.0f * !((idx+2)%2) * !((idy+1)%2) * input[BC((idx+2)/2,(idy+1)/2,nx,ny)];

	out +=  1.0f/256.0f * !((idx-2)%2) * !((idy+2)%2) * input[BC((idx-2)/2,(idy+2)/2,nx,ny)];
	out +=  4.0f/256.0f * !((idx-1)%2) * !((idy+2)%2) * input[BC((idx-1)/2,(idy+2)/2,nx,ny)];
	out +=  6.0f/256.0f * !((idx  )%2) * !((idy+2)%2) * input[BC((idx  )/2,(idy+2)/2,nx,ny)];
	out +=  4.0f/256.0f * !((idx+1)%2) * !((idy+2)%2) * input[BC((idx+1)/2,(idy+2)/2,nx,ny)];
	out +=  1.0f/256.0f * !((idx+2)%2) * !((idy+2)%2) * input[BC((idx+2)/2,(idy+2)/2,nx,ny)];

	output[id] = 8.0f * out;
}

__kernel void binom5x5DownSample(
	__read_only image2d_t input,
	__write_only image2d_t output,
	const int nx,
	const int ny
	)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);

	if (idx >= nx/2 || idy >= ny/2)
		return;

	const float x = (0.5f + 2*idx) / nx;
	const float y = (0.5f + 2*idy) / ny;
	const float xPixDist = 1.0f / nx;
	const float yPixDist = 1.0f / ny;

	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_TRUE |
		CLK_ADDRESS_MIRRORED_REPEAT |
		CLK_FILTER_NEAREST;

	// perform convolution
	float4 result = (float4)(0.0f);

	result +=  1.0f/256.0f * read_imagef(input,sampler,(float2)(x-2*xPixDist,y-2*yPixDist));
	result +=  4.0f/256.0f * read_imagef(input,sampler,(float2)(x-1*xPixDist,y-2*yPixDist));
	result +=  6.0f/256.0f * read_imagef(input,sampler,(float2)(x+0*xPixDist,y-2*yPixDist));
	result +=  4.0f/256.0f * read_imagef(input,sampler,(float2)(x+1*xPixDist,y-2*yPixDist));
	result +=  1.0f/256.0f * read_imagef(input,sampler,(float2)(x+2*xPixDist,y-2*yPixDist));

	result +=  4.0f/256.0f * read_imagef(input,sampler,(float2)(x-2*xPixDist,y-1*yPixDist));
	result += 16.0f/256.0f * read_imagef(input,sampler,(float2)(x-1*xPixDist,y-1*yPixDist));
	result += 24.0f/256.0f * read_imagef(input,sampler,(float2)(x+0*xPixDist,y-1*yPixDist));
	result += 16.0f/256.0f * read_imagef(input,sampler,(float2)(x+1*xPixDist,y-1*yPixDist));
	result +=  4.0f/256.0f * read_imagef(input,sampler,(float2)(x+2*xPixDist,y-1*yPixDist));

	result +=  6.0f/256.0f * read_imagef(input,sampler,(float2)(x-2*xPixDist,y ));
	result += 24.0f/256.0f * read_imagef(input,sampler,(float2)(x-1*xPixDist,y ));
	result += 36.0f/256.0f * read_imagef(input,sampler,(float2)(x+0*xPixDist,y ));
	result += 24.0f/256.0f * read_imagef(input,sampler,(float2)(x+1*xPixDist,y ));
	result +=  6.0f/256.0f * read_imagef(input,sampler,(float2)(x+2*xPixDist,y ));

	result +=  4.0f/256.0f * read_imagef(input,sampler,(float2)(x-2*xPixDist,y+1*yPixDist));
	result += 16.0f/256.0f * read_imagef(input,sampler,(float2)(x-1*xPixDist,y+1*yPixDist));
	result += 24.0f/256.0f * read_imagef(input,sampler,(float2)(x+0*xPixDist,y+1*yPixDist));
	result += 16.0f/256.0f * read_imagef(input,sampler,(float2)(x+1*xPixDist,y+1*yPixDist));
	result +=  4.0f/256.0f * read_imagef(input,sampler,(float2)(x+2*xPixDist,y+1*yPixDist));

	result +=  1.0f/256.0f * read_imagef(input,sampler,(float2)(x-2*xPixDist,y+2*yPixDist));
	result +=  4.0f/256.0f * read_imagef(input,sampler,(float2)(x-1*xPixDist,y+2*yPixDist));
	result +=  6.0f/256.0f * read_imagef(input,sampler,(float2)(x+0*xPixDist,y+2*yPixDist));
	result +=  4.0f/256.0f * read_imagef(input,sampler,(float2)(x+1*xPixDist,y+2*yPixDist));
	result +=  1.0f/256.0f * read_imagef(input,sampler,(float2)(x+2*xPixDist,y+2*yPixDist));

	write_imagef(output,(int2)(idx,idy),result);
}

__kernel void init_u(
	__global float2* u,
    const int nx,
	const int ny
	)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);
	int id = idx + idy * nx;

	if (idx >= nx || idy >= ny)
		return;

	u[id] = (float2)(0.0f);
}

__kernel void grad_init_p(
	__read_only image2d_t I1,
	__write_only image2d_t I1xy,
	__write_only image2d_t p,
	const int nx,
	const int ny
  )
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);

	if (idx >= nx || idy >= ny)
		return;

	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const float4 convIntensity = (float4)(0.2126f,0.7152f,0.0722f,0.0f);

	const float I1_c = dot(read_imagef(I1,sampler,(int2)(idx+0,idy+0)),convIntensity);
	const float I1_r = dot(read_imagef(I1,sampler,(int2)(idx+1,idy+0)),convIntensity);
	const float I1_l = dot(read_imagef(I1,sampler,(int2)(idx-1,idy+0)),convIntensity);
	const float I1_t = dot(read_imagef(I1,sampler,(int2)(idx+0,idy+1)),convIntensity);
	const float I1_b = dot(read_imagef(I1,sampler,(int2)(idx+0,idy-1)),convIntensity);

#ifdef USE_UNORM
	write_imagef(I1xy,(int2)(idx,idy),(float4)(I1_c,0.5f*(I1_r-I1_l)+0.5f,0.5f*(I1_t-I1_b)+0.5f,0.0f));
#else
	write_imagef(I1xy,(int2)(idx,idy),(float4)(I1_c,0.5f*(I1_r-I1_l)     ,0.5f*(I1_t-I1_b)     ,0.0f));
#endif

	write_imagef(p,(int2)(idx,idy),(float4)(0.0f));
}

__kernel void warping(
	__read_only image2d_t I1xy,
	const __global float2* restrict u12,
	__write_only image2d_t I1wxy,
	const int nx,
	const int ny
  )
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);
	int id = idx + idy * nx;

	if (idx >= nx || idy >= ny)
		return;

	const sampler_t sampler_warp =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_LINEAR;

	const float2 u12w = ((float2)(idx,idy) + u12[id] + (float2)(0.5f,0.5f));

#ifdef USE_UNORM
	float4 I1wxy_ = (float4)(0.0f,0.5f,0.5f,0.0f);
#else
	float4 I1wxy_ = (float4)(0.0f,0.0f,0.0f,0.0f);
#endif

	if (!(u12w.x < 0.5f || u12w.y < 0.5f || nx-0.5f < u12w.x || ny-0.5f < u12w.y))
	{
		I1wxy_ = read_imagef(I1xy, sampler_warp, u12w);
	}

	write_imagef(I1wxy,(int2)(idx,idy),I1wxy_);
}

__kernel void grad_rho_c(
	__read_only image2d_t I0,
	__read_only image2d_t I1wxy,
	const __global float2* restrict u12,
	//__write_only image2d_t grad_rhoc,
	__global float2* restrict grad_rhoc,
	const int nx,
	const int ny
	)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);
	int id = idx + idy * nx;

	if (idx >= nx || idy >= ny)
		return;

	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const float4 convIntensity = (float4)(0.2126f,0.7152f,0.0722f,0.0f);

#ifdef USE_UNORM
	const float I0_ =  dot(read_imagef(I0,sampler,(int2)(idx,idy)),convIntensity) * 255.0f;
	const float4 I1wxy_ = read_imagef(I1wxy, sampler, (int2)(idx,idy));

	const float I1 = I1wxy_.x * 255.0f;
	const float2 I1xy = (I1wxy_.yz - (float2)(0.5f,0.5f)) * 255.0f;
#else
	const float I0_ =  dot(read_imagef(I0,sampler,(int2)(idx,idy)),convIntensity);
	const float4 I1wxy_ = read_imagef(I1wxy, sampler, (int2)(idx,idy));

	const float I1 = I1wxy_.x;
	const float2 I1xy = I1wxy_.yz;
#endif

	const float grad2 = I1xy.x * I1xy.x + I1xy.y * I1xy.y;
	const float rho_c = I1 - I1xy.x * u12[id].x - I1xy.y * u12[id].y - I0_;

	//write_imagef(grad_rhoc,(int2)(idx,idy),(float4)(grad2,rho_c,0.0f,0.0f));
	grad_rhoc[id] = (float2)(grad2,rho_c);
}

// thresholding step to update v
inline float2 TH(const float rho, const float l_t, const float grad2, const float2 Ixy)
{
  if( fabs(rho) > l_t * grad2 )
    return sign(-rho) * l_t * Ixy;
  else
    if( grad2 < 1E-10f )
      return (float2)0.0f;
    else
      return -rho * Ixy / grad2;
}

// thresholding step to update v
inline float2 THLDS(const float rho, const float l_t, const float grad2, const float2 Ixy)
{
	float2 result = fabs(rho) > l_t * grad2 ? ( sign(-rho) * l_t * Ixy ) : ( -rho * Ixy / max( grad2, 1E-10f) );
	return result;
}

inline void write_imagef_P_UNORM(__write_only image2d_t i, const int2 xy, const float4 d)
{
	write_imagef(i, xy, (d + 1.0f) * 0.5f);
}

inline float4 read_imagef_P_UNORM(__read_only image2d_t i, sampler_t srcSampler, const int2 xy)
{
  return read_imagef(i, srcSampler, xy) * 2.0f - 1.0f;
}

__kernel void update_u(
	__read_only image2d_t I1wxy,
	const __global float2* restrict grad_rhoc,
	__read_only image2d_t p,
	__global float2* restrict u12,
	const float theta,
	const float l_t,
	const float t_t,
	const int nx,
	const int ny
	)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);
	int id = idx + idy * nx;

	if (idx >= nx || idy >= ny)
		return;

	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

#ifdef USE_UNORM
	const float2 Ixy = (read_imagef(I1wxy, sampler, (int2)(idx,idy)).yz - (float2)(0.5f,0.5f)) * 255.0f;
#else
	const float2 Ixy = read_imagef(I1wxy, sampler, (int2)(idx,idy)).yz;
#endif
	const float2 grad_rho_c = grad_rhoc[id];
	const float rho = grad_rho_c.y + dot(Ixy,u12[id]);

	const float2 d12 = TH(rho, l_t, grad_rho_c.x, Ixy);

#ifdef USE_UNORM
	const float4 p_c = read_imagef_P_UNORM(p, sampler, (int2)(idx+0,idy+0));
	const float2 p_l = read_imagef_P_UNORM(p, sampler, (int2)(idx-1,idy+0)).xz;
	const float2 p_b = read_imagef_P_UNORM(p, sampler, (int2)(idx+0,idy-1)).yw;
#else
	const float4 p_c = read_imagef(p, sampler, (int2)(idx+0,idy+0));
	const float2 p_l = read_imagef(p, sampler, (int2)(idx-1,idy+0)).xz;
	const float2 p_b = read_imagef(p, sampler, (int2)(idx+0,idy-1)).yw;
#endif

	const float2 div_x = idx != 0 ? p_c.xz - p_l : p_c.xz;
	const float2 div_y = idy != 0 ? p_c.yw - p_b : p_c.yw;

	u12[id] += d12 + theta*(div_x + div_y);
}

__kernel void update_p(
	const __global float2* restrict u12,
	__read_only image2d_t p_in,
	__write_only image2d_t p_out,
	const float theta,
	const float l_t,
	const float t_t,
	const int nx,
	const int ny
	)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);
	int id = idx + idy * nx;

	if (idx >= nx || idy >= ny)
		return;

	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const float2 grad_x = idx != (nx-1) ? u12[id+ 1] - u12[id] : 0.0f;
	const float2 grad_y = idy != (ny-1) ? u12[id+nx] - u12[id] : 0.0f;

	const float4 u_der = (float4)(grad_x.x,grad_y.x,grad_x.y,grad_y.y);

	const float2 ng12 = (float2)(1.0f) + (float2)(t_t) * (float2)( hypot(grad_x.s0,grad_y.s0), hypot(grad_x.s1,grad_y.s1) );

#ifdef USE_UNORM
	write_imagef_P_UNORM(p_out,(int2)(idx,idy),(read_imagef_P_UNORM(p_in,sampler,(int2)(idx,idy)) + (float4)(t_t) * u_der) / ng12.xxyy);
#else
	write_imagef(p_out,(int2)(idx,idy),(read_imagef(p_in,sampler,(int2)(idx,idy)) + (float4)(t_t) * u_der) / ng12.xxyy);
#endif
}

#define LWG_SIZE_X 16
#define LWG_SIZE_Y 16
#define LWG_BORDER 4
#define NITER_LOOP 4

#define LIDX(i,j) ( (i) + (j) * LWG_SIZE_X )
#define GIDX(i,j) ( (i) + (j) * nx )

__kernel void update_u_p(
	__read_only image2d_t I1wxy,
	const __global float2* restrict grad_rhoc,
	__read_only image2d_t p,
	const __global float2* restrict u12,
	__write_only image2d_t pOut,
	__global float2* restrict u12Out,
	const float theta,
	const float l_t,
	const float t_t,
	const int nx,
	const int ny
	)
{
	__local float2 shared_u12[LWG_SIZE_X*LWG_SIZE_Y];
	__local float4 shared_p[LWG_SIZE_X*LWG_SIZE_Y];

	int x = get_global_id(0) - LWG_BORDER * 2 * get_group_id(0) - LWG_BORDER;
	int y = get_global_id(1) - LWG_BORDER * 2 * get_group_id(1) - LWG_BORDER;

	const int lx = get_local_id(0);
	const int ly = get_local_id(1);

	// ensure to work in active region only
        x = min( max(x,0), nx-1);
        y = min( max(y,0), ny-1);

	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const int id = GIDX(x,y);

	float4 current_p;
#ifdef USE_UNORM
	current_p = read_imagef_P_UNORM(p, sampler, (int2)(x,y));
#else
	current_p = read_imagef(p, sampler, (int2)(x,y));
#endif

	float2 current_u12 = u12[id];

#ifdef USE_UNORM
	const float2 Ixy = (read_imagef(I1wxy, sampler, (int2)(x,y)).yz - (float2)(0.5f,0.5f)) * 255.0f;
#else
	const float2 Ixy = read_imagef(I1wxy, sampler, (int2)(x,y)).yz;
#endif
	const float2 grc = grad_rhoc[id];

	for(int i = 0; i < NITER_LOOP; i++)
	{
		shared_p[LIDX(lx,ly)] = current_p;
		barrier(CLK_LOCAL_MEM_FENCE);
		//updating u
		const float2 div_x = x != 0 ? (lx != 0 ? current_p.xz - shared_p[LIDX(lx-1,   ly)].xz : current_p.xz ) : current_p.xz;
		const float2 div_y = y != 0 ? (ly != 0 ? current_p.yw - shared_p[LIDX(lx  , ly-1)].yw : current_p.yw ) : current_p.yw;

		float rho = grc.y + dot(Ixy,current_u12);
		float2 d12 = THLDS(rho, l_t, grc.x, Ixy);

		current_u12 += d12 + theta*(div_x + div_y);
		shared_u12[LIDX(lx,ly)] = current_u12;

		barrier(CLK_LOCAL_MEM_FENCE);
		//updating p
		const float2 grad_x = x != (nx-1) ? ( lx != (LWG_SIZE_X-1) ? shared_u12[LIDX(lx+1, ly  )] - current_u12 : 0.0f ) : 0.0f;
		const float2 grad_y = y != (ny-1) ? ( ly != (LWG_SIZE_Y-1) ? shared_u12[LIDX(lx  , ly+1)] - current_u12 : 0.0f ) : 0.0f;

		const float4 u_der = (float4)(grad_x.x,grad_y.x,grad_x.y,grad_y.y);

		const float2 ng12 = (float2)(1.0f) + (float2)(t_t) * (float2)( hypot(grad_x.s0,grad_y.s0), hypot(grad_x.s1,grad_y.s1) );

		current_p = (current_p + (float4)(t_t) * u_der) / ng12.xxyy;
	}

	//reestablish non-clamped global coordinates
	x = get_global_id(0) - LWG_BORDER * 2 * get_group_id(0) - LWG_BORDER;
	y = get_global_id(1) - LWG_BORDER * 2 * get_group_id(1) - LWG_BORDER;

	//since global x,y coordinates can be duplicated due to overlapping tiles, need to check local coords lx, ly to ensure that correct values are pushed out
	if ( (x >= 0) && (y >= 0) && (x < nx) && (y < ny) && (lx >= LWG_BORDER) && (ly >= LWG_BORDER) && (lx < LWG_SIZE_X-LWG_BORDER) && (ly < LWG_SIZE_Y-LWG_BORDER) )
	{
#ifdef USE_UNORM
		write_imagef_P_UNORM(pOut,(int2)(x,y),current_p);
#else
		write_imagef(pOut,(int2)(x,y),current_p);
#endif
		u12Out[id] = current_u12;
	}
}

__kernel void color_code(
	const __global float2* restrict u12,
	__write_only image2d_t output,
	const float maxPixDist,
	const int nx,
	const int ny
	)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);
	int id = idx + idy * nx;

	if (idx >= nx || idy >= ny)
		return;

	float x = u12[id].x / maxPixDist;
	float y = u12[id].y / maxPixDist;

	float xAbs = fabs(x);
	float yAbs = fabs(y);

	if (1.0f < xAbs)
	{
		x = sign(x);
		y /= xAbs;
		yAbs /= xAbs;
	}
	if (1.0f < yAbs)
	{
		y = sign(y);
		x /= yAbs;
	}

	float distM = 1.4142f - hypot(x - 1.0f, y + 1.0f);
	float distO = 1.4142f - hypot(x - 1.0f, y - 1.0f);
	float distG = 1.4142f - hypot(x + 1.0f, y - 1.0f);
	float distB = 1.4142f - hypot(x + 1.0f, y + 1.0f);
	float distW = 1.4142f - hypot(x, y);

	distM = max(0.0f, distM);
	distO = max(0.0f, distO);
	distG = max(0.0f, distG);
	distB = max(0.0f, distB);
	distW = max(0.0f, distW);

	float weight = distM + distO + distG + distB + distW;
	distM /= weight; distO /= weight; distG /= weight; distB /= weight; distW /= weight;

	float4 result = (float4)(255.0f);
	result.x = distW * 255.0f + distO * 255.0f + distM * 255.0f;
	result.y = distW * 255.0f + distO * 127.5f + distG * 255.0f;
	result.z = distW * 255.0f + distB * 255.0f + distM * 255.0f;

	write_imagef(output,(int2)(idx,idy),result);
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
