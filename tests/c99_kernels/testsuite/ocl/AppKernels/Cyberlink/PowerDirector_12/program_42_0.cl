#ifndef	M_PI
#define M_PI		    3.1415926535897932384626433832795f
#endif

__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;


__kernel void Square(__read_only image2d_t input, __write_only image2d_t output, int width, int height, float curvature,
                     float fCurvature, float MaxR, float MaxR2, float dS, float dSR,
                     float dS2, float dSR2, int CenterX, int CenterY, unsigned char getAlphaType)
{
	// convert to polar

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int nIndex;
	uint4 Src_L, Src_R;
	int4 tempRGB1;
	int4 tempRGB2;

	int w = get_global_id(0);
	int h = get_global_id(1);

	int nXMapped;
	int nYMapped;

	{

		float dR = h - CenterY;
		float dRx = w - CenterX;

		if (dR <= 0 )
		{

			dR = (-1.0f) * dR;
			float fAoffset = ( native_exp( dR * dSR ) - 1.0f ) * fCurvature;
			// convert back to cartesian

			float oldX;
			if(dRx <= 0.0f)
			{
				dRx = (-1.0f) * dRx;
				float fAoffset = ( native_exp( dRx * dSR2 ) - 1 ) * fCurvature;
				// oldX = dMaxR2 - fAoffset;
				oldX = CenterX - fAoffset;
			}
			else
			{
				float fAoffset = ( native_exp( dRx * dSR2 ) - 1 ) * fCurvature;
				// oldX = dMaxR2 + fAoffset;
				oldX = CenterX + fAoffset;
			}

			float oldY = CenterY - fAoffset  ;

			oldX = (oldX < 0)? 0 : ( (oldX >= width)? (width - 1) : oldX );
			oldY = (oldY < 0)? 0 : ( (oldY >= height)? (height - 1) : oldY );

			nXMapped = oldX * 65536;
			nYMapped = oldY * 65536;

		}
		else
		{

			float fAoffset = ( native_exp( dR * dSR ) - 1 ) * fCurvature;
			// convert back to cartesian
			float oldX;
			if(dRx <= 0.0f)
			{
				dRx = (-1.0f) * dRx;
				float fAoffset = ( native_exp( dRx * dSR2 ) - 1 ) * fCurvature;
				// oldX = dMaxR2 - fAoffset;
		     		oldX = CenterX - fAoffset;
			}
			else
			{
				float fAoffset = ( native_exp( dRx * dSR2 ) - 1 ) * fCurvature;
				// oldX = dMaxR2 + fAoffset;
				oldX = CenterX + fAoffset;
			}


	                float oldY = CenterY + fAoffset ;

			oldX = (oldX < 0)? 0 : ( (oldX >= width)? (width - 1) : oldX );
			oldY = (oldY < 0)? 0 : ( (oldY >= height)? (height - 1) : oldY );

			nXMapped = oldX * 65536;
			nYMapped = oldY * 65536;

		}

		int fraction_x = nXMapped & 0x0000ffff;
		int fraction_y = nYMapped & 0x0000ffff;

		nIndex = (nYMapped >> 16) * width + (nXMapped >> 16);

		coord = (int2)(nIndex % width, nIndex / width);
		Src_L = read_imageui(input, imageSampler, coord);

		if(((nXMapped >> 16) + 1) != width)
		{
			coord = (int2)((nIndex+1) % width, (nIndex+1) / width);
			Src_R = read_imageui(input, imageSampler, coord);
		}
		else
		{
			Src_R = Src_L;
		}

		tempRGB1.x = (((int)Src_L.x << 16) + ( (int)Src_R.x - (int)Src_L.x ) * fraction_x) >> 16;
		tempRGB1.y = (((int)Src_L.y << 16) + ( (int)Src_R.y - (int)Src_L.y ) * fraction_x) >> 16;
		tempRGB1.z = (((int)Src_L.z << 16) + ( (int)Src_R.z - (int)Src_L.z ) * fraction_x) >> 16;

		if(((nXMapped >> 16) + 1) != width)
		{
			if(((nYMapped >> 16) + 1) != height)
			{
				coord = (int2)((nIndex+width) % width, (nIndex+width) / width);
				Src_L = read_imageui(input, imageSampler, coord);
				coord = (int2)((nIndex+width+1) % width, (nIndex+width+1) / width);
				Src_R = read_imageui(input, imageSampler, coord);

			}
			else
			{
				coord = (int2)((nIndex) % width, (nIndex) / width);
				Src_L = read_imageui(input, imageSampler, coord);
				coord = (int2)((nIndex+1) % width, (nIndex+1) / width);
				Src_R = read_imageui(input, imageSampler, coord);
			}
		}
		else
		{
			if(((nYMapped >> 16) + 1) != height)
			{
				coord = (int2)((nIndex+width) % width, (nIndex+width) / width);
				Src_L = read_imageui(input, imageSampler, coord);
				Src_R = Src_L;
			}
			else
			{
				coord = (int2)((nIndex) % width, (nIndex) / width);
				Src_L = read_imageui(input, imageSampler, coord);
				Src_R = Src_L;
			}
		}

		tempRGB2.x = (((int)Src_L.x << 16) + ( (int)Src_R.x - (int)Src_L.x ) * fraction_x) >> 16;
		tempRGB2.y = (((int)Src_L.y << 16) + ( (int)Src_R.y - (int)Src_L.y ) * fraction_x) >> 16;
		tempRGB2.z = (((int)Src_L.z << 16) + ( (int)Src_R.z - (int)Src_L.z ) * fraction_x) >> 16;


		tempRGB1.x = ((tempRGB1.x << 16) + (tempRGB2.x - tempRGB1.x) * fraction_y) >> 16;
		tempRGB1.y = ((tempRGB1.y << 16) + (tempRGB2.y - tempRGB1.y) * fraction_y) >> 16;
		tempRGB1.z = ((tempRGB1.z << 16) + (tempRGB2.z - tempRGB1.z) * fraction_y) >> 16;

		Src_L = convert_uint4(tempRGB1);
		Src_L.w = 255;
		coord = (int2)(get_global_id(0), get_global_id(1));
		write_imageui(output, coord, Src_L);

	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
