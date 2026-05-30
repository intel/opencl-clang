/*
* Transform the image plane to another, determined by the given homography
*/

constant sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE |
    CLK_ADDRESS_CLAMP_TO_EDGE |
    CLK_FILTER_LINEAR;

typedef struct Rect_
{
    unsigned x;
    unsigned y;
    unsigned width;
    unsigned height;
} Rect;

__kernel void ToGray(read_only image2d_t inputImage,
							write_only image2d_t outputImage)
{
	int i = get_global_id(0);
	int j = get_global_id(1);

	float4 tmp = read_imagef(inputImage, sampler,(float2)(i, j));

	write_imagef(outputImage,(int2)(i, j), (tmp.x + tmp.y + tmp.z) / 3.0f);
}

__kernel void BGRAToGray(read_only image2d_t inputImage,
							write_only image2d_t outputImage)
{
	int i = get_global_id(0);
	int j = get_global_id(1);

	float4 tmp = read_imagef(inputImage, sampler,(float2)(i, j));

	write_imagef(outputImage,(int2)(i, j), tmp.x*0.0722f + tmp.y*0.7152f + tmp.z*0.2126f);
}

__kernel void RGBAToGray(read_only image2d_t inputImage,
							write_only image2d_t outputImage)
{
	int i = get_global_id(0);
	int j = get_global_id(1);

	float4 tmp = read_imagef(inputImage, sampler,(float2)(i, j));

	write_imagef(outputImage,(int2)(i, j), tmp.x*0.2126f + tmp.y*0.7152f + tmp.z*0.0722f);
}

__kernel void BGRToRGBA(
	__global uchar *input_image,
	__write_only image2d_t output_image)
{
	const int x = get_global_id(0);
	const int y = get_global_id(1);
	const int idx = y * get_global_size(0) + x;

	const uchar4 p_in = (uchar4)(input_image[idx * 3 + 2], input_image[idx * 3 + 1], input_image[idx * 3 + 0], (uchar)255);
	const float4 p_out = convert_float4(p_in) * (1.0f / 255.0f);
	write_imagef(output_image, (int2)(x, y), p_out);
}

__kernel void RGBToRGBA(
	__global uchar *input_image,
	__write_only image2d_t output_image)
{
	const int x = get_global_id(0);
	const int y = get_global_id(1);
	const int idx = y * get_global_size(0) + x;

	const uchar4 p_in = (uchar4)(input_image[idx * 3 + 0], input_image[idx * 3 + 1], input_image[idx * 3 + 2], (uchar)255);
	const float4 p_out = convert_float4(p_in) * (1.0f / 255.0f);
	write_imagef(output_image, (int2)(x, y), p_out);
}



//__kernel void BGRToRGBA(__global uchar *inputImage,
//						__write_only image2d_t outputImage,
//						const unsigned rect_x,
//						const unsigned rect_y,
//						const unsigned rect_width,
//						const unsigned rect_height,
////						Rect rect,
//						float scale_x,
//						float scale_y,
//						int o_width,
//						int o_height)
//{
//	const int x = get_global_id(0);
//	const int y = get_global_id(1);
//	const int width = get_global_size(0);
//
//
//	float2 readpos = (float2)((float)x / scale_x + rect_x, (float)y / scale_y + rect_y);
//	readpos.x = clamp(readpos.x, 1.0f, (float)(o_width - 2.0001f));
//	readpos.y = clamp(readpos.y, 1.0f, (float)(o_height - 2.0001f));
//	const int2 readpos_i = (int2)((int)readpos.x,(int)readpos.y);
//	const float2 frac = readpos - (float2)((float)readpos_i.x, (float)readpos_i.y);
//	float4 p_out = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
//	int ix, iy;
////// Gauss Blur and bilinear:
////	const float w_[4] = { 1.0f, 2.0f, 1.0f, 0.0f };
////	for (ix = -1; ix < 3; ix++){
////		for (iy = -1; iy < 3; iy++){
//
//// Bilenear only:
//	const float w_[4] = { 0.0f, 4.0f, 0.0f, 0.0f };
//	for (ix = 0; ix < 2; ix++){
//		for (iy = 0; iy < 2; iy++){
//
//			int idx = (iy + readpos_i.y)*o_width + (ix + readpos_i.x);
//			const uchar4 p_in = (uchar4)(inputImage[idx * 3 + 2], inputImage[idx * 3 + 1], inputImage[idx * 3 + 0], (uchar)255);
//			float4 p_out_ = convert_float4(p_in) * (1.0f / 255.0f);
//
//			float wx = w_[ix + 1] * (1.0f - frac.x) + (frac.x)*w_[3 - (ix + 1)];
//			float wy = w_[iy + 1] * (1.0f - frac.y) + (frac.y)*w_[3 - (iy + 1)];
//
//			p_out += p_out_*(wx*wy);
//		}
//	}
//
////	const int idx = ((int))*o_width + (int);
//
////	const uchar4 p_in = (uchar4)( inputImage[idx*3+2], inputImage[idx*3+1], inputImage[idx*3+0], (uchar)255 );
//	//const uchar4 p_in = (uchar4)( ((uchar3 *)inputImage)[idx], (uchar)0 );
////	const float4 p_out = convert_float4(p_in) * (1.0f / 255.0f);
//
//	write_imagef(outputImage, (int2)(x, y), p_out/16.0f );
//}

__kernel void XXXAToAXXX(__read_only image2d_t inputImage,
                         __write_only image2d_t outputImage) {


        const int x  = get_global_id(0);
        const int y  = get_global_id(1);

        float4 p_in  = read_imagef(inputImage, sampler, (float2)(x, y));
        float4 p_out = (p_in.s0, p_in.s2, p_in.s1, 0);

        write_imagef(outputImage, (int2)(x, y), p_out);
}



__kernel void GrayToRGBA(__global uchar *inputImage,
						__write_only image2d_t outputImage)
{
	const int x = get_global_id(0);
	const int y = get_global_id(1);
	const int width = get_global_size(0);

	const int idx = y*width + x;

	const float p_in = convert_float(inputImage[idx]);
	const float4 p_out = (float4)(p_in, p_in, p_in, 0.0f) * (1.0f / 255.0f);
	write_imagef(outputImage, (int2)(x, y), p_out );
}

__kernel void RGBAToHSV(read_only image2d_t inputImage,
					write_only image2d_t outputImage)
{
	const int2 pos = (int2)(get_global_id(0), get_global_id(1) );

	float4 image_pixel = read_imagef(inputImage, sampler, pos);

	float r,g,b;
	r = image_pixel.x;
    g = image_pixel.y;
    b = image_pixel.z;

	float max = fmax(r, fmax(g, b));
    float min = fmin(r, fmin(g, b));
    float diff = max - min;

	float h,s,v;
    v = max;

    if(v == 0.0f) { // black
		h = s = 0.0f;
    } else {
		s = diff / v;
		if(diff < 0.001f) { // grey
			h = 0.0f;
		} else { // color
			if(max == r) {
				h = 60.0f/360.0f * (g - b)/diff;
				if(h < 0.0f)
				{
					h += 360.0f/360.0f;
				}
			} else if(max == g) {
				h = 60.0f/360.0f * (2 + (b - r)/diff);
            } else {
                h = 60.0f/360.0f * (4 + (r - g)/diff);
            }
		}
    }

	float4 pixel = (float4)(h, s, v, 1.0f);
	write_imagef(outputImage, pos, pixel);
}

__kernel void BGRAToHSV(read_only image2d_t inputImage,
					write_only image2d_t outputImage)
{
	const int2 pos = (int2)(get_global_id(0), get_global_id(1) );

	float4 image_pixel = read_imagef(inputImage, sampler, pos);

	float r,g,b;
	b = image_pixel.x;
        g = image_pixel.y;
        r = image_pixel.z;

	float max = fmax(r, fmax(g, b));
        float min = fmin(r, fmin(g, b));
        float diff = max - min;

	float h,s,v;
        v = max;

    if(v == 0.0f) { // black
		h = s = 0.0f;
    } else {
		s = diff / v;
		if(diff < 0.001f) { // grey
			h = 0.0f;
		} else { // color
			if(max == r) {
				h = 60.0f/360.0f * (g - b)/diff;
				if(h < 0.0f)
				{
					h += 360.0f/360.0f;
				}
			} else if(max == g) {
				h = 60.0f/360.0f * (2 + (b - r)/diff);
            } else {
                h = 60.0f/360.0f * (4 + (r - g)/diff);
            }
		}
    }

	float4 pixel = (float4)(h, s, v, 1.0f);
	write_imagef(outputImage, pos, pixel);
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
