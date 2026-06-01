__kernel void generateSpectrum( __global const float2* restrict h0,
								__global const float* restrict omega,
								__global float2* restrict htOut,
								__global float2* restrict slopeXOut,
								__global float2* restrict slopeYOut,
								unsigned int in_width,
								const float t )
{
	unsigned int out_width = get_global_size(0);
	unsigned int out_height = get_global_size(1);

	unsigned int x = get_global_id(0);
    unsigned int y = get_global_id(1);
    unsigned int in_index = y*in_width+x;
    unsigned int in_mindex = (out_height - y)*in_width + (out_width - x); // mirrored
    unsigned int out_index = y*out_width+x;

	float2 h0_k = h0[in_index];
	float2 h0_mk = h0[in_mindex];

	float sin_v, cos_v;
	sin_v = sincos(omega[in_index] * t, &cos_v);

	float2 ht;
	ht.x = (h0_k.x + h0_mk.x) * cos_v - (h0_k.y + h0_mk.y) * sin_v;
	ht.y = (h0_k.x - h0_mk.x) * sin_v + (h0_k.y - h0_mk.y) * cos_v;

	// H(t) -> Dx(t), Dy(t)
	float kx = x - out_width * 0.5f;
	float ky = y - out_height * 0.5f;
	float sqr_k = kx * kx + ky * ky;
	float rsqr_k = 0;
	if (sqr_k > 1e-12f)
		rsqr_k = 1 / sqrt(sqr_k);
	kx *= rsqr_k;
	ky *= rsqr_k;

	float2 dt_x = (float2)(ht.y * kx, -ht.x * kx);
	float2 dt_y = (float2)(ht.y * ky, -ht.x * ky);

	htOut[out_index] = ht;
	slopeXOut[out_index] = dt_x;
	slopeYOut[out_index] = dt_y;
}

__kernel void updateHeightMap(	__global const float2* restrict htOut,
								__global const float2* restrict slopeXOut,
								__global const float2* restrict slopeYOut,
								__global float4* restrict hMapOut)
{
	unsigned int x = get_global_id(0);
    unsigned int y = get_global_id(1);
	unsigned int width = get_global_size(0);

	float scale = 512.0f*512.0f;

    unsigned int id = y*width+x;

    float sign_correction = ((x + y) & 0x01) ? -1.0f : 1.0f;

	float dx = slopeXOut[id].x * sign_correction * 0.0f;
	float dy = slopeYOut[id].x * sign_correction * 0.0f;
	float dz = htOut[id].x * sign_correction;

	//float4 baseGrid = (float4)(x,y,0.0f,1.0f) * 2000.0f / 512.0f;
	float4 offset = scale * (float4)(dx, dy, dz, 0.0f);

	// global position for point render
	//hMapOut[id] = baseGrid;
	//hMapOut[id] = baseGrid + offset;

	// local displacement for texture
	hMapOut[id] = offset;
}

__kernel void updateNormalMap(	__global const float4* restrict hMap,
								__global float4* restrict normal)
{
	unsigned int x = get_global_id(0);
    unsigned int y = get_global_id(1);
	unsigned int width = get_global_size(0);

	unsigned int xP = (y*width+((x+1)%width));
	unsigned int xN = (y*width+((x-1+width)%width));

	unsigned int yP = (((y+1)%width)*width+x);
	unsigned int yN = (((y-1+width)%width)*width+x);

	float4 n = cross( (float4)(2.0f * (2000.0f / 512.0f), 0.0f, hMap[xP].z - hMap[xN].z, 0.0f), (float4)(0.0f, 2.0f * (2000.0f / 512.0f), hMap[yP].z - hMap[yN].z, 0.0f));
	//float4 n = (float4)(-(hMap[xP].z - hMap[xN].z), 2.0f * 2000.0f/512.0f, -(hMap[yP].z - hMap[yN].z),0.0f);

    unsigned int id = y*width+x;
	normal[id] = 0.5f * ( normalize(n) + (float4)(1.0f, 1.0f, 1.0f, 0.0f));
}
__kernel
void transpose( __global const float2* restrict Data_In, __global float2* restrict Data_Out )
{
	uint x = get_global_id(0);
	uint y = get_global_id(1);

	uint width = get_global_size(0);
	uint height = get_global_size(1);

	uint srcId = y * width + x;
	uint dstId = x * height + y;

	Data_Out[dstId] = Data_In[srcId];
}

__kernel
void transposeScale( __global const float2* restrict Data_In, __global float2* restrict Data_Out )
{
	uint x = get_global_id(0);
	uint y = get_global_id(1);

	uint width = get_global_size(0);
	uint height = get_global_size(1);

	uint srcId = y * width + x;
	uint dstId = x * height + y;

	Data_Out[dstId] = Data_In[srcId] / (float2)(512.0f*512.0f);
}

__kernel __attribute__((reqd_work_group_size (16,16,1)))
void transpose16x16Local( __global const float2* restrict Data_In, __global float2* restrict Data_Out )
{
	local float2 aux[16*16];
	uint bx = get_group_id(0),
		 by = get_group_id(1);
	uint ix = get_local_id(0),
		 iy = get_local_id(1);

	uint w = get_global_size(0);
	uint h = get_global_size(1);

	by = (by+bx)%get_num_groups(1);

	Data_In += (bx*16)+(by*16)*w;
	Data_Out += (by*16)+(bx*16)*h;

	aux[iy+ix*16] = Data_In[ix+w*iy];
	barrier(CLK_LOCAL_MEM_FENCE);

	Data_Out[ix+h*iy] = aux[ix+iy*16];
}

__kernel __attribute__((reqd_work_group_size (16,16,1)))
void transposeScale16x16Local( __global const float2* restrict Data_In, __global float2* restrict Data_Out )
{
	local float2 aux[16*16];
	uint bx = get_group_id(0),
		 by = get_group_id(1);
	uint ix = get_local_id(0),
		 iy = get_local_id(1);

	uint w = get_global_size(0);
	uint h = get_global_size(1);

	by = (by+bx)%get_num_groups(1);

	Data_In += (bx*16)+(by*16)*w;
	Data_Out += (by*16)+(bx*16)*h;

	aux[iy+ix*16] = Data_In[ix+w*iy];
	barrier(CLK_LOCAL_MEM_FENCE);

	Data_Out[ix+h*iy] = aux[ix+iy*16] / (float2)(512.0f*512.0f);
}

__kernel __attribute__((reqd_work_group_size (8,8,1)))
void transpose8x8Local( __global const float2* restrict Data_In, __global float2* restrict Data_Out )
{
	local float2 aux[8*8];
	uint bx = get_group_id(0),
		 by = get_group_id(1);
	uint ix = get_local_id(0),
		 iy = get_local_id(1);

	uint w = get_global_size(0);
	uint h = get_global_size(1);

	by = (by+bx)%get_num_groups(1);

	Data_In += (bx*8)+(by*8)*w;
	Data_Out += (by*8)+(bx*8)*h;

	aux[iy+ix*8] = Data_In[ix+w*iy];
	barrier(CLK_LOCAL_MEM_FENCE);

	Data_Out[ix+h*iy] = aux[ix+iy*8];
}

__kernel __attribute__((reqd_work_group_size (8,8,1)))
void transposeScale8x8Local( __global const float2* restrict Data_In, __global float2* restrict Data_Out )
{
	local float2 aux[8*8];
	uint bx = get_group_id(0),
		 by = get_group_id(1);
	uint ix = get_local_id(0),
		 iy = get_local_id(1);

	uint w = get_global_size(0);
	uint h = get_global_size(1);

	by = (by+bx)%get_num_groups(1);

	Data_In += (bx*8)+(by*8)*w;
	Data_Out += (by*8)+(bx*8)*h;

	aux[iy+ix*8] = Data_In[ix+w*iy];
	barrier(CLK_LOCAL_MEM_FENCE);

	Data_Out[ix+h*iy] = aux[ix+iy*8] / (float2)(512.0f*512.0f);
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
