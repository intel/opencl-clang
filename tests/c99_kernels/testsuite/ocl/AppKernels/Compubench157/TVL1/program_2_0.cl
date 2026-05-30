
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

__kernel void init_u(
	__global float2 * u
	)
{
	u[get_global_id(0) + get_global_id(1) * get_global_size(0)] = (float2)(0.0f);
}

__kernel void init_p(
	__global float4 * p
	)
{
	p[get_global_id(0) + get_global_id(1) * get_global_size(0)] = (float4)(0.0f);
}

__kernel void gauss3x3(
	const __global float4* restrict input,
	__global float* restrict output,
	const int nx,
	const int ny
	)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);
	int id = idx + idy * nx;

	// perform convolution
	float4 result = (float4)(0.0f, 0.0f, 0.0f, 1.0f);

	result += 1.0f/16.0f * input[BC(idx-1,idy-1,nx,ny)];
	result += 2.0f/16.0f * input[BC(idx  ,idy-1,nx,ny)];
	result += 1.0f/16.0f * input[BC(idx+1,idy-1,nx,ny)];

	result += 2.0f/16.0f * input[BC(idx-1,idy  ,nx,ny)];
	result += 4.0f/16.0f * input[BC(idx  ,idy  ,nx,ny)];
	result += 2.0f/16.0f * input[BC(idx+1,idy  ,nx,ny)];

	result += 1.0f/16.0f * input[BC(idx-1,idy+1,nx,ny)];
	result += 2.0f/16.0f * input[BC(idx  ,idy+1,nx,ny)];
	result += 1.0f/16.0f * input[BC(idx+1,idy+1,nx,ny)];

	//output[id] = (0.2126f*result.x + 0.7152f*result.y + 0.0722f*result.z);
	output[id] = dot(result,(float4)(0.2126f,0.7152f,0.0722f,0.0f));
}

__kernel void gauss5x5(
	const __global float4* restrict input,
	__global float* restrict output,
	const int nx,
	const int ny
	)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);
	int id = idx + idy * nx;

	// perform convolution
	float4 result = (float4)(0.0f, 0.0f, 0.0f, 1.0f);

	result +=  2.0f/571.0f * input[BC(idx-2,idy-2,nx,ny)];
	result +=  7.0f/571.0f * input[BC(idx-1,idy-2,nx,ny)];
	result += 12.0f/571.0f * input[BC(idx  ,idy-2,nx,ny)];
	result +=  7.0f/571.0f * input[BC(idx+1,idy-2,nx,ny)];
	result +=  2.0f/571.0f * input[BC(idx+2,idy-2,nx,ny)];

	result +=  7.0f/571.0f * input[BC(idx-2,idy-1,nx,ny)];
	result += 31.0f/571.0f * input[BC(idx-1,idy-1,nx,ny)];
	result += 52.0f/571.0f * input[BC(idx  ,idy-1,nx,ny)];
	result += 31.0f/571.0f * input[BC(idx+1,idy-1,nx,ny)];
	result +=  7.0f/571.0f * input[BC(idx+2,idy-1,nx,ny)];

	result += 12.0f/571.0f * input[BC(idx-2,idy  ,nx,ny)];
	result += 52.0f/571.0f * input[BC(idx-1,idy  ,nx,ny)];
	result +=127.0f/571.0f * input[BC(idx  ,idy  ,nx,ny)];
	result += 52.0f/571.0f * input[BC(idx+1,idy  ,nx,ny)];
	result += 12.0f/571.0f * input[BC(idx+2,idy  ,nx,ny)];

	result +=  7.0f/571.0f * input[BC(idx-2,idy+1,nx,ny)];
	result += 31.0f/571.0f * input[BC(idx-1,idy+1,nx,ny)];
	result += 52.0f/571.0f * input[BC(idx  ,idy+1,nx,ny)];
	result += 31.0f/571.0f * input[BC(idx+1,idy+1,nx,ny)];
	result +=  7.0f/571.0f * input[BC(idx+2,idy+1,nx,ny)];

	result +=  2.0f/571.0f * input[BC(idx-2,idy+2,nx,ny)];
	result +=  7.0f/571.0f * input[BC(idx-1,idy+2,nx,ny)];
	result += 12.0f/571.0f * input[BC(idx  ,idy+2,nx,ny)];
	result +=  7.0f/571.0f * input[BC(idx+1,idy+2,nx,ny)];
	result +=  2.0f/571.0f * input[BC(idx+2,idy+2,nx,ny)];

	//output[id] = (0.2126f*result.x + 0.7152f*result.y + 0.0722f*result.z);
	output[id] = dot(result,(float4)(0.2126f,0.7152f,0.0722f,0.0f));
}

__kernel void gauss7x7(
	const __global float4* restrict input,
	__global float* restrict output,
	const int nx,
	const int ny
	)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);
	int id = idx + idy * nx;

	// perform convolution
	float4 result = (float4)(0.0f, 0.0f, 0.0f, 1.0f);

	result +=  1.0f/170.0f * input[BC(idx-3,idy-3,nx,ny)];
	result +=  1.0f/170.0f * input[BC(idx-2,idy-3,nx,ny)];
	result +=  2.0f/170.0f * input[BC(idx-1,idy-3,nx,ny)];
	result +=  2.0f/170.0f * input[BC(idx  ,idy-3,nx,ny)];
	result +=  2.0f/170.0f * input[BC(idx+1,idy-3,nx,ny)];
	result +=  1.0f/170.0f * input[BC(idx+2,idy-3,nx,ny)];
	result +=  1.0f/170.0f * input[BC(idx+3,idy-3,nx,ny)];

	result +=  1.0f/170.0f * input[BC(idx-3,idy-2,nx,ny)];
	result +=  3.0f/170.0f * input[BC(idx-2,idy-2,nx,ny)];
	result +=  4.0f/170.0f * input[BC(idx-1,idy-2,nx,ny)];
	result +=  5.0f/170.0f * input[BC(idx  ,idy-2,nx,ny)];
	result +=  4.0f/170.0f * input[BC(idx+1,idy-2,nx,ny)];
	result +=  3.0f/170.0f * input[BC(idx+2,idy-2,nx,ny)];
	result +=  1.0f/170.0f * input[BC(idx+3,idy-2,nx,ny)];

	result +=  2.0f/170.0f * input[BC(idx-3,idy-1,nx,ny)];
	result +=  4.0f/170.0f * input[BC(idx-2,idy-1,nx,ny)];
	result +=  7.0f/170.0f * input[BC(idx-1,idy-1,nx,ny)];
	result +=  8.0f/170.0f * input[BC(idx  ,idy-1,nx,ny)];
	result +=  7.0f/170.0f * input[BC(idx+1,idy-1,nx,ny)];
	result +=  4.0f/170.0f * input[BC(idx+2,idy-1,nx,ny)];
	result +=  2.0f/170.0f * input[BC(idx+3,idy-1,nx,ny)];

	result +=  2.0f/170.0f * input[BC(idx-3,idy  ,nx,ny)];
	result +=  5.0f/170.0f * input[BC(idx-2,idy  ,nx,ny)];
	result +=  8.0f/170.0f * input[BC(idx-1,idy  ,nx,ny)];
	result += 10.0f/170.0f * input[BC(idx  ,idy  ,nx,ny)];
	result +=  8.0f/170.0f * input[BC(idx+1,idy  ,nx,ny)];
	result +=  5.0f/170.0f * input[BC(idx+2,idy  ,nx,ny)];
	result +=  2.0f/170.0f * input[BC(idx+3,idy  ,nx,ny)];

	result +=  2.0f/170.0f * input[BC(idx-3,idy+1,nx,ny)];
	result +=  4.0f/170.0f * input[BC(idx-2,idy+1,nx,ny)];
	result +=  7.0f/170.0f * input[BC(idx-1,idy+1,nx,ny)];
	result +=  8.0f/170.0f * input[BC(idx  ,idy+1,nx,ny)];
	result +=  7.0f/170.0f * input[BC(idx+1,idy+1,nx,ny)];
	result +=  4.0f/170.0f * input[BC(idx+2,idy+1,nx,ny)];
	result +=  2.0f/170.0f * input[BC(idx+3,idy+1,nx,ny)];

	result +=  1.0f/170.0f * input[BC(idx-3,idy+2,nx,ny)];
	result +=  3.0f/170.0f * input[BC(idx-2,idy+2,nx,ny)];
	result +=  4.0f/170.0f * input[BC(idx-1,idy+2,nx,ny)];
	result +=  5.0f/170.0f * input[BC(idx  ,idy+2,nx,ny)];
	result +=  4.0f/170.0f * input[BC(idx+1,idy+2,nx,ny)];
	result +=  3.0f/170.0f * input[BC(idx+2,idy+2,nx,ny)];
	result +=  1.0f/170.0f * input[BC(idx+3,idy+2,nx,ny)];

	result +=  1.0f/170.0f * input[BC(idx-3,idy+3,nx,ny)];
	result +=  1.0f/170.0f * input[BC(idx-2,idy+3,nx,ny)];
	result +=  2.0f/170.0f * input[BC(idx-1,idy+3,nx,ny)];
	result +=  2.0f/170.0f * input[BC(idx  ,idy+3,nx,ny)];
	result +=  2.0f/170.0f * input[BC(idx+1,idy+3,nx,ny)];
	result +=  1.0f/170.0f * input[BC(idx+2,idy+3,nx,ny)];
	result +=  1.0f/170.0f * input[BC(idx+3,idy+3,nx,ny)];

	//output[id] = (0.2126f*result.x + 0.7152f*result.y + 0.0722f*result.z);
	output[id] = dot(result,(float4)(0.2126f,0.7152f,0.0722f,0.0f));
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
	const __global float* restrict input,
	__global float* restrict output,
	const int nx,
	const int ny
	)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);
	int id = idx + idy * nx / 2;

	// perform convolution
	float out = 0.0f;

	out +=  1.0f/256.0f * input[BC(2*idx-2,2*idy-2,nx,ny)];
	out +=  4.0f/256.0f * input[BC(2*idx-1,2*idy-2,nx,ny)];
	out +=  6.0f/256.0f * input[BC(2*idx  ,2*idy-2,nx,ny)];
	out +=  4.0f/256.0f * input[BC(2*idx+1,2*idy-2,nx,ny)];
	out +=  1.0f/256.0f * input[BC(2*idx+2,2*idy-2,nx,ny)];

	out +=  4.0f/256.0f * input[BC(2*idx-2,2*idy-1,nx,ny)];
	out += 16.0f/256.0f * input[BC(2*idx-1,2*idy-1,nx,ny)];
	out += 24.0f/256.0f * input[BC(2*idx  ,2*idy-1,nx,ny)];
	out += 16.0f/256.0f * input[BC(2*idx+1,2*idy-1,nx,ny)];
	out +=  4.0f/256.0f * input[BC(2*idx+2,2*idy-1,nx,ny)];

	out +=  6.0f/256.0f * input[BC(2*idx-2,2*idy  ,nx,ny)];
	out += 24.0f/256.0f * input[BC(2*idx-1,2*idy  ,nx,ny)];
	out += 36.0f/256.0f * input[BC(2*idx  ,2*idy  ,nx,ny)];
	out += 24.0f/256.0f * input[BC(2*idx+1,2*idy  ,nx,ny)];
	out +=  6.0f/256.0f * input[BC(2*idx+2,2*idy  ,nx,ny)];

	out +=  4.0f/256.0f * input[BC(2*idx-2,2*idy+1,nx,ny)];
	out += 16.0f/256.0f * input[BC(2*idx-1,2*idy+1,nx,ny)];
	out += 24.0f/256.0f * input[BC(2*idx  ,2*idy+1,nx,ny)];
	out += 16.0f/256.0f * input[BC(2*idx+1,2*idy+1,nx,ny)];
	out +=  4.0f/256.0f * input[BC(2*idx+2,2*idy+1,nx,ny)];

	out +=  1.0f/256.0f * input[BC(2*idx-2,2*idy+2,nx,ny)];
	out +=  4.0f/256.0f * input[BC(2*idx-1,2*idy+2,nx,ny)];
	out +=  6.0f/256.0f * input[BC(2*idx  ,2*idy+2,nx,ny)];
	out +=  4.0f/256.0f * input[BC(2*idx+1,2*idy+2,nx,ny)];
	out +=  1.0f/256.0f * input[BC(2*idx+2,2*idy+2,nx,ny)];

	output[id] = out;
}

__kernel void grad_init_p(
	const __global float* restrict I1,
	__global float4* restrict I1xy,
	__global float4* restrict p,
	const int nx,
	const int ny
	)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);
	int id = idx + idy * nx;

	if (idx >= nx || idy >= ny)
		return;

	// centered gradient on the body of the image
	// one sided gradient on the boundary of the image
	const float dx = 0.5f * ( I1[clampBC(idx+1,idy  ,nx,ny)] - I1[clampBC(idx-1,idy  ,nx,ny)] );
	const float dy = 0.5f * ( I1[clampBC(idx  ,idy+1,nx,ny)] - I1[clampBC(idx  ,idy-1,nx,ny)] );

	I1xy[id] = (float4)(I1[id],dx,dy,0.0f);
	p[id] = (float4)(0.0f);
}

__kernel void warping(
	const __global float4* restrict I1xy,
	const __global float2* restrict u12,
	__global float4* restrict I1wxy,
	const int nx,
	const int ny
	)
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);
	int id = idx + idy * nx;

	if (idx >= nx || idy >= ny)
		return;

	const float u1w = (float)(idx) + u12[id].x;
	const float u2w = (float)(idy) + u12[id].y;

	if (u1w<0.0f || nx-1.0f<u1w || u2w<0.0f || ny-1.0f<u2w)
	{
		I1wxy[id] = (float4)(0.0f);
		return;
	}

	int i0, j0, i1, j1;
	float s0, t0, s1, t1;

	i0=(int)u1w; i1=i0+1; if(nx-1<i1) i1 = i0;
	j0=(int)u2w; j1=j0+1; if(ny-1<j1) j1 = j0;

	s1 = u1w-(float)i0; s0 = 1.0f-(float)s1;
    t1 = u2w-(float)j0; t0 = 1.0f-(float)t1;

	I1wxy[id] = s0 * ( t0*I1xy[j0*nx+i0] + t1*I1xy[j1*nx+i0] ) +
		s1 * ( t0*I1xy[j0*nx+i1] + t1*I1xy[j1*nx+i1] );
}

__kernel void grad_rho_c(
	const __global float* restrict I0,
	const __global float4* restrict I1wxy,
	const __global float2* restrict u12,
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

	const float grad2 = I1wxy[id].y * I1wxy[id].y + I1wxy[id].z * I1wxy[id].z;
	const float rho_c = I1wxy[id].x - I1wxy[id].y * u12[id].x - I1wxy[id].z * u12[id].y - I0[id];

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

__kernel void update_u(
	const __global float4* restrict I1wxy,
	const __global float2* restrict grad_rhoc,
	const __global float4* restrict p,
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

	const float2 Ixy = (float2)(I1wxy[id].y,I1wxy[id].z);
	const float rho = grad_rhoc[id].y + dot(Ixy,u12[id]);

	const float2 d12 = TH(rho, l_t, grad_rhoc[id].x, Ixy);

	const float2 div_x = idx != 0 ? p[id].xz - p[id- 1].xz : p[id].xz;
	const float2 div_y = idy != 0 ? p[id].yw - p[id-nx].yw : p[id].yw;

	u12[id] += d12 + theta*(div_x + div_y);
}

__kernel void update_p(
	const __global float2* restrict u12,
	__global float4* restrict p,
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

	const float2 grad_x = idx != (nx-1) ? u12[id+ 1] - u12[id] : 0.0f;
	const float2 grad_y = idy != (ny-1) ? u12[id+nx] - u12[id] : 0.0f;

	const float4 u_der = (float4)(grad_x.x,grad_y.x,grad_x.y,grad_y.y);

	const float2 ng12 = (float2)(1.0f) + (float2)(t_t) * (float2)( hypot(grad_x.s0,grad_y.s0), hypot(grad_x.s1,grad_y.s1) );

	p[id] = (p[id] + (float4)(t_t) * u_der) / ng12.xxyy;
}

// thresholding step to update v
inline float2 THLDS(const float rho, const float l_t, const float grad2, const float2 Ixy)
{
	float2 result = fabs(rho) > l_t * grad2 ? ( sign(-rho) * l_t * Ixy ) : ( -rho * Ixy / max( grad2, 1E-10f) );
	return result;
}

#define LWG_SIZE_X 16
#define LWG_SIZE_Y 16
#define LWG_BORDER 4
#define NITER_LOOP 4

#define LIDX(i,j) ( (i) + (j) * LWG_SIZE_X )
#define GIDX(i,j) ( (i) + (j) * nx )

__kernel void update_u_p(
	const __global float4* restrict I1wxy,
	const __global float2* restrict grad_rhoc,
	const __global float4* restrict p,
	const __global float2* restrict u12,
	__global float4* restrict pOut,
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

	const int id = GIDX(x,y);

	float4 current_p = p[id];
	float2 current_u12 = u12[id];

	const float2 Ixy = (float2)(I1wxy[id].y,I1wxy[id].z);
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
	  pOut[id] = current_p;
	  u12Out[id] = current_u12;
	}
}

__kernel void color_code(
	const __global float2* restrict u12,
	__global float4* restrict output,
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

	output[id] = result;
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
