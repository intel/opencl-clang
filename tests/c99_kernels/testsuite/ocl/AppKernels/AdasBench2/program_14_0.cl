/*
* Vertical Stripe Enhancement
*/

constant sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE |
    CLK_ADDRESS_CLAMP_TO_EDGE |
	CLK_FILTER_NEAREST;

kernel void VerticalStripeEnhancement(read_only image2d_t  src,
					   write_only image2d_t  gradmag,
					   int width,int img_height,float y_vanish)
{
	int2 coordi = (int2)(get_global_id(0), get_global_id(1));
	float2 coordf = (float2)((float)get_global_id(0) + 0.5f, (float)get_global_id(1) + 0.5f);

//	float y_vanish = 100;// 195;
	float tau = 1.0*width*(coordf.y - y_vanish) / (img_height-y_vanish);
	float4 color= read_imagef(src, sampler, coordf);
	float4 xtau= read_imagef(src, sampler, coordf + (float2)(tau,0));
//	float4 ytau = read_imagef(src, sampler, coordf + (float2)(0,tau));
//	float4 y_tau = read_imagef(src, sampler, coordf + (float2)(0,-tau));
	float4 x_tau = read_imagef(src, sampler, coordf - (float2)(tau, 0));
	float4 res = 1*(2 * color - xtau - x_tau) - 1*fabs(xtau - x_tau);
//	res += 2 * ((xtau - x_tau)*(xtau - x_tau) + (ytau - y_tau)*(ytau - y_tau));
	res = clamp(res, 0.0f, 1.0f);
//	write_imagef(gradmag, coordi, (float4)((res.xyz*1.0 + 0.5*color.xyz)*color.xyz *1.0, 1));
	write_imagef(gradmag, coordi, (float4)(res.xyz, 1));
}


kernel void getStripePointsVertical(
	read_only image2d_t  src,
	int ppy,
	global int * out_count,
	global float2 * out,
	int stripe_width,
	int img_width,
	int img_height,
	float y_vanish,
	int gSize)
{
	int i = get_global_id(0);

	if (i >= gSize)
		return;

	int translate = i * 32;

	int y = get_global_id(0) + ppy;

//	float y_vanish = 100;// 95;
	float tau = 1.0*stripe_width*(y - y_vanish) / (img_height-y_vanish);

	int point_count = 0;

	for (int x = 0; x < img_width; ++x)
	{
		float2 coordf = (float2)(x,y);
		float tmp = read_imagef(src, sampler, coordf).x;
		int count = 0;
		float start_x = x;
		while (tmp  > 0.4f && x < img_width)
		{
			++x;
			++count;
			coordf.x = x;
			tmp = read_imagef(src, sampler, coordf).x;

		}

		if (count > tau && count<1.5f*tau)
		{

			out[point_count + translate].x = start_x + count / 2.0f;
			out[point_count + translate].y = y;

			++point_count;
		}

	}
	out_count[i] = point_count;
}

/*  TUTI ENHANCE
{
int2 coordi = (int2)(get_global_id(0), get_global_id(1));
float2 coordf = (float2)((float)get_global_id(0), (float)get_global_id(1));

float y_vanish = 180;
float tau = 1.0*width*(coordf.y - y_vanish) / y_vanish;
float4 color= read_imagef(src, sampler, coordf);
float4 xtau= read_imagef(src, sampler, coordf + (float2)(tau,0));
//	float4 ytau = read_imagef(src, sampler, coordf + (float2)(0,tau));
//	float4 y_tau = read_imagef(src, sampler, coordf + (float2)(0,-tau));
float4 x_tau = read_imagef(src, sampler, coordf - (float2)(tau, 0));
float4 res = 1*(2 * color - xtau - x_tau) - 1*fabs(xtau - x_tau);
//	res += 2 * ((xtau - x_tau)*(xtau - x_tau) + (ytau - y_tau)*(ytau - y_tau));
res = clamp(res, 0.0f, 1.0f);
write_imagef(gradmag,coordi,(float4)(res.xyz*0.5+color.xyz*color.xyz *1.0, 1));
}
*/
/*
kernel void HorizontalStripeEnhancement(read_only image2d_t  src,
					   write_only image2d_t  gradmag,
					   int width)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int tau = width;
	float color = read_imagef(src, sampler, coord).x;
	float xtau  = read_imagef(src, sampler, coord + (int2)(0,tau)).x;
	float x_tau = read_imagef(src, sampler, coord - (int2)(0,tau)).x;
	float res = 2 * color - xtau - x_tau - fabs(xtau - x_tau);
	write_imagef(gradmag, coord, (float4)(fabs(res), fabs(res),fabs(res), 1) );
}
*/

kernel void treshold_flag_head(
	read_only image2d_t  src,
	global int *flagBuff,
	global int *headBuff)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int destId = x + y * 1024;

	float2 coordf = (float2)(x, y);
	float tmp = read_imagef(src, sampler, coordf).x;
	int flag = tmp > 0.4f ? 1 : 0;

	flagBuff[destId] = flag;

	if (x == 0)
	{
		headBuff[destId] = 1;
	}
	else
	{
		float2 coordf_prev = (float2)(x - 1.0, y);
		float tmp_prev = read_imagef(src, sampler, coordf_prev).x;
		int flag_prev = tmp_prev > 0.4f ? 1 : 0;

		if (flag == 0)
		{
			headBuff[destId] = 1;
		}
		else if (flag_prev == 0)
		{
			headBuff[destId] = 1;
		}
		else
		{
			headBuff[destId] = 0;
		}
	}
}

#define WGSIZEX 256

kernel void treshold_scan(
	global int *dataBuff,
	global int *headBuff,
	global int *flagBuff,
	const int n,
	const int numBatch)
{
	int grpId = get_group_id(0);
	int wiLId = get_local_id(0);

	local int sData[WGSIZEX];
	local int sHead[WGSIZEX];
	local int sFlag[WGSIZEX];

	local int carryData[1];

	if (wiLId == WGSIZEX - 1)
	{
		carryData[0] = 0;
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	for (int b = 0; b < numBatch; ++b)
	{
		int id = 1024 * grpId + b*WGSIZEX + wiLId;

		// read input data into local memory
		sData[wiLId] = (id < n) ? 1 : 0;
		sHead[wiLId] = (id < n) ? headBuff[id] : 0;
		sFlag[wiLId] = (id < n) ? flagBuff[id] : 0;
		barrier(CLK_LOCAL_MEM_FENCE);

		for (int offset = 1; offset < WGSIZEX; offset *= 2)
		{
			int td, th;
			int flag;

			if (wiLId >= offset)
			{
				td = sData[wiLId - offset];
				th = sHead[wiLId - offset];
				flag = sFlag[wiLId - offset];
			}
			barrier(CLK_LOCAL_MEM_FENCE);

			if (wiLId >= offset)
			{
				sData[wiLId] += sHead[wiLId] ? 0 : td;
				sHead[wiLId] |= th;

				sFlag[wiLId] = min(flag, sFlag[wiLId]);
			}
			barrier(CLK_LOCAL_MEM_FENCE);
		}

		// write result for this block to global mem
		if (id < n)
		{
			dataBuff[id] = sData[wiLId] + sFlag[wiLId] * carryData[0];
		}

		if (wiLId == WGSIZEX - 1)
		{
			carryData[0] = sData[wiLId] + sFlag[wiLId] * carryData[0];
		}
		barrier(CLK_LOCAL_MEM_FENCE);
	}
}

kernel void treshold_stripe(
	const global int *data,
	global int *out_count,
	global float2 *out,
	const int ppy,
	const int stripe_width,
	const int img_width,
	const int img_height,
	const float y_vanish,
	const int numBatch)
{
	int grpId = get_group_id(0);
	int wiLId = get_local_id(0);

	int translate = grpId * 32;

	int y = grpId + ppy;
	float tau = 1.0*stripe_width*(y - y_vanish) / (img_height - y_vanish);

	local int point_count[1];
	if (wiLId == 0)
	{
		point_count[0] = 0;
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	for (int b = 0; b < numBatch; ++b)
	{
		int id = (b*WGSIZEX + wiLId) + y*img_width;
		int count = data[id];
		int count_next = 0;

		if ((b*WGSIZEX + wiLId) + 1 != img_width)
		{
			count_next = data[(b*WGSIZEX + wiLId) + 1 + y*img_width];
		}

		if (count > tau && count < 1.5f * tau && count_next != 1)
		{
			int oldValue = atomic_inc(point_count);
			out[oldValue + translate].x = (b*WGSIZEX + wiLId) - count / 2.0f;
			out[oldValue + translate].y = y;
		}

		barrier(CLK_LOCAL_MEM_FENCE);
	}

	if (wiLId == 0)
	{
		out_count[grpId] = point_count[0];
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
