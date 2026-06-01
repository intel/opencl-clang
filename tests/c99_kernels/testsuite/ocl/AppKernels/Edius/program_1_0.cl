
inline float3 BT709_RGB_to_YCbCr(float3 v)
{
	float3 d;
	d.s0 = (v.s0 *  0.2126000000000000) + (v.s1 *  0.7152000000000000) + (v.s2 *  0.0722000000000000);
	d.s1 = (v.s0 * -0.1145721060573400) + (v.s1 * -0.3854278939426600) + (v.s2 *  0.5000000000000000);
	d.s2 = (v.s0 *  0.5000000000000000) + (v.s1 * -0.4541529083058170) + (v.s2 * -0.0458470916941834);
	return d;
}

inline float3 BT601_RGB_to_YCbCr(float3 v)
{
	float3 d;
	d.s0 = (v.s0 *  0.2990000000000000) + (v.s1 *  0.5870000000000000) + (v.s2 *  0.1140000000000000);
	d.s1 = (v.s0 * -0.1687358916478560) + (v.s1 * -0.3312641083521440) + (v.s2 *  0.5000000000000000);
	d.s2 = (v.s0 *  0.5000000000000000) + (v.s1 * -0.4186875891583450) + (v.s2 * -0.0813124108416548);
	return d;
}

inline float Gamma_Linear_to_BT709_(float v)
{
	if (v >= 0.018) {
		return 1.099 * native_powr(v, (float) 0.45) - 0.099;
	} else if (v >= -0.0045) {
		return 4.50 * v;
	} else {
		return (1.099 * native_powr(-4 * v, (float)  0.45) - 0.099) / -4;
	}
}

inline float3 Gamma_Linear_to_BT709(float3 v)
{
	v.s0 = Gamma_Linear_to_BT709_(v.s0);
	v.s1 = Gamma_Linear_to_BT709_(v.s1);
	v.s2 = Gamma_Linear_to_BT709_(v.s2);
	return v;
}

inline float3 Gamma_Linear_to_BT601(float3 v)
{
	return Gamma_Linear_to_BT709(v); // same as 709
}

inline float3 Gamut_SGamut3_to_BT709(float3 v)
{
	float3 d;
	d.s0 = (v.s0 *  1.8779151284) + (v.s1 * -0.7941687613) + (v.s2 * -0.0837463671);
	d.s1 = (v.s0 * -0.1768069813) + (v.s1 *  1.3509996209) + (v.s2 * -0.1741926396);
	d.s2 = (v.s0 * -0.0262011264) + (v.s1 * -0.1484222623) + (v.s2 *  1.1746233888);
	return d;
}

inline float3 Gamut_SGamut3_to_BT601(float3 v)
{
	float3 d;
	d.s0 = (v.s0 *  1.7912361921) + (v.s1 * -0.7036743277) + (v.s2 * -0.0875618644);
	d.s1 = (v.s0 * -0.1768069813) + (v.s1 *  1.3509996209) + (v.s2 * -0.1741926396);
	d.s2 = (v.s0 * -0.0244037778) + (v.s1 * -0.1663165459) + (v.s2 *  1.1907203237);
	return d;
}

inline float3 SGamut3Linear_to_BT709(float3 v)
{
	v = Gamut_SGamut3_to_BT709(v);
	v = clamp(v, (float) 0.0, (float) 1.2);
	v = Gamma_Linear_to_BT709(v);
	v = BT709_RGB_to_YCbCr(v);
	return v;
}

inline float3 SGamut3Linear_to_BT601(float3 v)
{
	v = Gamut_SGamut3_to_BT601(v);
	v = clamp(v, (float) 0.0, (float) 1.2);
	v = Gamma_Linear_to_BT601(v);
	v = BT601_RGB_to_YCbCr(v);
	return v;
}

__kernel void Convert_to_W210_709(__global ushort8 *src_buffer, __global ushort4 *dst_buffer, const float src_base, const float src_range, unsigned int length)
{
	size_t index = get_global_id(0);
	if (index >= length) return;

	ushort8 src = src_buffer[index]; // R, G, B

	float3 s1 = (convert_float3(src.s012) - src_base) / src_range;
	float3 s2 = (convert_float3(src.s456) - src_base) / src_range;

	float3 d1 = SGamut3Linear_to_BT709(s1); // Y, Cb, Cr
	float3 d2 = SGamut3Linear_to_BT709(s2);
	float4 d = { d1.s0, d1.s1, d2.s0, d1.s2 }; // Y, Cb, Y, Cr

	const float4 dst_base = {64.5, 512.5, 64.5, 512.5};
	const float4 dst_range = {876, 896, 876, 896};
	ushort4 dst = convert_ushort4(clamp(d * dst_range + dst_base, (float) 0, (float) 1023));
	dst_buffer[index] = dst;
}

__kernel void Convert_to_W210_601(__global ushort8 *src_buffer, __global ushort4 *dst_buffer, const float src_base, const float src_range, unsigned int length)
{
	size_t index = get_global_id(0);
	if (index >= length) return;

	ushort8 src = src_buffer[index]; // R, G, B

	float3 s1 = (convert_float3(src.s012) - src_base) / src_range;
	float3 s2 = (convert_float3(src.s456) - src_base) / src_range;

	float3 d1 = SGamut3Linear_to_BT601(s1); // Y, Cb, Cr
	float3 d2 = SGamut3Linear_to_BT601(s2);
	float4 d = { d1.s0, d1.s1, d2.s0, d1.s2 }; // Y, Cb, Y, Cr

	const float4 dst_base = {64.5, 512.5, 64.5, 512.5};
	const float4 dst_range = {876, 896, 876, 896};
	ushort4 dst = convert_ushort4(clamp(d * dst_range + dst_base, (float) 0, (float) 1023));
	dst_buffer[index] = dst;
}

__kernel void Convert_to_YUY2_709(__global ushort8 *src_buffer, __global uchar4 *dst_buffer, const float src_base, const float src_range, unsigned int length)
{
	size_t index = get_global_id(0);
	if (index >= length) return;

	ushort8 src = src_buffer[index]; // R, G, B

	float3 s1 = (convert_float3(src.s012) - src_base) / src_range;
	float3 s2 = (convert_float3(src.s456) - src_base) / src_range;

	float3 d1 = SGamut3Linear_to_BT709(s1); // Y, Cb, Cr
	float3 d2 = SGamut3Linear_to_BT709(s2);
	float4 d = { d1.s0, d1.s1, d2.s0, d1.s2 }; // Y, Cb, Y, Cr

	const float4 dst_base = {16.5, 128.5, 16.5, 128.5};
	const float4 dst_range = {219, 224, 219, 224};
	uchar4 dst = convert_uchar4(clamp(d * dst_range + dst_base, (float) 0, (float) 255));
	dst_buffer[index] = dst;
}

__kernel void Convert_to_YUY2_601(__global ushort8 *src_buffer, __global uchar4 *dst_buffer, const float src_base, const float src_range, unsigned int length)
{
	size_t index = get_global_id(0);
	if (index >= length) return;

	ushort8 src = src_buffer[index]; // R, G, B

	float3 s1 = (convert_float3(src.s012) - src_base) / src_range;
	float3 s2 = (convert_float3(src.s456) - src_base) / src_range;

	float3 d1 = SGamut3Linear_to_BT601(s1); // Y, Cb, Cr
	float3 d2 = SGamut3Linear_to_BT601(s2);
	float4 d = { d1.s0, d1.s1, d2.s0, d1.s2 }; // Y, Cb, Y, Cr

	const float4 dst_base = {16.5, 128.5, 16.5, 128.5};
	const float4 dst_range = {219, 224, 219, 224};
	uchar4 dst = convert_uchar4(clamp(d * dst_range + dst_base, (float) 0, (float) 255));
	dst_buffer[index] = dst;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
