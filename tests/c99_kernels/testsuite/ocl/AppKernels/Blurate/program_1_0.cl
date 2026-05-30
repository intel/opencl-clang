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
    float pixel_diffR = fabs(pixel_orig.x- (float)240);
    float pixel_diffG = fabs(pixel_orig.y- (float)203);
    float pixel_diffB = fabs(pixel_orig.z- (float)187);
    float pixel_diffA = fabs(pixel_orig.w- (float)255);
    if ((pixel_diffR<44)&&(pixel_diffG<44)&&(pixel_diffB<44 )&&(pixel_diffA<44)){
	    float4 pixel_new = (float4)(0, 0, 0, 255);
    float4 pixel0 = read_imagef(inputImage,sampler,(int2)(i-0,j+1));
    float4 pixel1 = read_imagef(inputImage,sampler,(int2)(i-1,j+1));
    float4 pixel2 = read_imagef(inputImage,sampler,(int2)(i+1,j-1));
    float4 pixel3 = read_imagef(inputImage,sampler,(int2)(i-0,j-1));
    float4 pixel4 = read_imagef(inputImage,sampler,(int2)(i+1,j+1));
    float4 pixel5 = read_imagef(inputImage,sampler,(int2)(i-1,j-1));
    float pixel0_diffR = fabs(pixel0.x- (float)240);
    float pixel0_diffG = fabs(pixel0.y- (float)203);
    float pixel0_diffB = fabs(pixel0.z- (float)187);
    float pixel0_diffA = fabs(pixel0.w- (float)255);
   if ((pixel0_diffR<44)&& (pixel0_diffG<44)&&(pixel0_diffB<44 )&&(pixel0_diffA<44)){
	    pixel_new += (pixel0)*(float)2.0; accumWeights += 2;
    }
    float pixel1_diffR = fabs(pixel1.x- (float)240);
    float pixel1_diffG = fabs(pixel1.y- (float)203);
    float pixel1_diffB = fabs(pixel1.z- (float)187);
    float pixel1_diffA = fabs(pixel1.w- (float)255);
   if ((pixel1_diffR<44)&& (pixel1_diffG<44)&&(pixel1_diffB<44 )&&(pixel1_diffA<44)){
	    pixel_new += (pixel1)*(float)1.0; accumWeights += 1;
    }
    float pixel2_diffR = fabs(pixel2.x- (float)240);
    float pixel2_diffG = fabs(pixel2.y- (float)203);
    float pixel2_diffB = fabs(pixel2.z- (float)187);
    float pixel2_diffA = fabs(pixel2.w- (float)255);
   if ((pixel2_diffR<44)&& (pixel2_diffG<44)&&(pixel2_diffB<44 )&&(pixel2_diffA<44)){
	    pixel_new -= (pixel2)*(float)1.0; accumWeights -= 1;
    }
    float pixel3_diffR = fabs(pixel3.x- (float)240);
    float pixel3_diffG = fabs(pixel3.y- (float)203);
    float pixel3_diffB = fabs(pixel3.z- (float)187);
    float pixel3_diffA = fabs(pixel3.w- (float)255);
   if ((pixel3_diffR<44)&& (pixel3_diffG<44)&&(pixel3_diffB<44 )&&(pixel3_diffA<44)){
	    pixel_new -= (pixel3)*(float)2.0; accumWeights -= 2;
    }
    float pixel4_diffR = fabs(pixel4.x- (float)240);
    float pixel4_diffG = fabs(pixel4.y- (float)203);
    float pixel4_diffB = fabs(pixel4.z- (float)187);
    float pixel4_diffA = fabs(pixel4.w- (float)255);
   if ((pixel4_diffR<44)&& (pixel4_diffG<44)&&(pixel4_diffB<44 )&&(pixel4_diffA<44)){
	    pixel_new += (pixel4)*(float)1.0; accumWeights += 1;
    }
    float pixel5_diffR = fabs(pixel5.x- (float)240);
    float pixel5_diffG = fabs(pixel5.y- (float)203);
    float pixel5_diffB = fabs(pixel5.z- (float)187);
    float pixel5_diffA = fabs(pixel5.w- (float)255);
   if ((pixel5_diffR<44)&& (pixel5_diffG<44)&&(pixel5_diffB<44 )&&(pixel5_diffA<44)){
	    pixel_new -= (pixel5)*(float)1.0; accumWeights -= 1;
    }
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
