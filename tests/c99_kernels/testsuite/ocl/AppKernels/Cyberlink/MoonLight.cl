__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;


__kernel void MoonLight(__read_only image2d_t src, __write_only image2d_t dst, int width, int height, int degree, int Reciprocal)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 tempSrc = {0, 0, 0, 0};
	int4 SumARGB = {0, 0, 0, 0};

	for(int iLayerCount=0; iLayerCount < degree; iLayerCount++ )
	{

		if( h - iLayerCount >= 1 )
			h = h - 1;

		if( w - iLayerCount >= 1 )
			w = w - 1;

		coord = (int2)(w, h);
		tempSrc = read_imageui(src, imageSampler, coord);

		SumARGB.x += tempSrc.x;
		SumARGB.y += tempSrc.y;
		SumARGB.z += tempSrc.z;
	}

	SumARGB.x = (SumARGB.x * Reciprocal) >> 16;
	SumARGB.y = (SumARGB.y * Reciprocal) >> 16;
	SumARGB.z = (SumARGB.z * Reciprocal) >> 16;

	coord = (int2)(get_global_id(0), get_global_id(1));
	tempSrc = read_imageui(src, imageSampler, coord);

	SumARGB.x = ( max(SumARGB.x, (int)tempSrc.x) * 3 + tempSrc.x ) >> 2;
	SumARGB.y = ( max(SumARGB.y, (int)tempSrc.y) * 3 + tempSrc.y ) >> 2;
	SumARGB.z = ( max(SumARGB.z, (int)tempSrc.z) * 3 + tempSrc.z ) * 0.18;

	tempSrc = convert_uint4(SumARGB);

	write_imageui(dst, coord, tempSrc);

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
