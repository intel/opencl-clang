//Primary input is original surface
__kernel void specialKernel0(read_only image2d_t inputImage, write_only image2d_t outputImage)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
    int i = get_global_id(0);
    int j = get_global_id(1);
    //if (i>=src[0]) return;
    //if (j>=src[1]) return;
    float accumWeights = 0;
    float4 pixel_orig=read_imagef(inputImage,sampler,(int2)(i,j));
    //long4 pixel_orig_long=convert_long4(pixel_orig);
    float pixel_diffR = fabs(pixel_orig.x- (float)175);
    float pixel_diffG = fabs(pixel_orig.y- (float) 7);
    float pixel_diffB = fabs(pixel_orig.z- (float) 33);
    float pixel_diffA = fabs(pixel_orig.w- (float) 255);
    if ((pixel_diffR<300)&&(pixel_diffG< 80)&&(pixel_diffB< 80 )&&(pixel_diffA< 10)){
	    float4 pixel_new = (float4)(255, 255, 0, 255);
    pixel_new = fabs(pixel_new);
    if (pixel_new.x>255) pixel_new.x = 255;
    if (pixel_new.y>255) pixel_new.y = 255;
    if (pixel_new.z>255) pixel_new.z = 255;
    pixel_new.w = 255;
    write_imagef(outputImage,(int2)(i,j), pixel_new);
    }
    else
    {
        write_imagef(outputImage,(int2)(i,j), pixel_orig);
    }
};


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
