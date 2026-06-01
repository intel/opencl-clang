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
    float4 pixel_new = (float4)(0, 0, 0, 255);
    float4 pixel0 = read_imagef(inputImage,sampler,(int2)(i-0,j+0));
    float4 pixel1 = read_imagef(inputImage,sampler,(int2)(i+2,j+2));
    float4 pixel2 = read_imagef(inputImage,sampler,(int2)(i+1,j+2));
    float4 pixel3 = read_imagef(inputImage,sampler,(int2)(i-0,j+2));
    float4 pixel4 = read_imagef(inputImage,sampler,(int2)(i-1,j+2));
    float4 pixel5 = read_imagef(inputImage,sampler,(int2)(i-2,j+2));
    float4 pixel6 = read_imagef(inputImage,sampler,(int2)(i-2,j+1));
    float4 pixel7 = read_imagef(inputImage,sampler,(int2)(i-2,j+0));
    float4 pixel8 = read_imagef(inputImage,sampler,(int2)(i-2,j-1));
    float4 pixel9 = read_imagef(inputImage,sampler,(int2)(i-2,j-2));
    float4 pixel10 = read_imagef(inputImage,sampler,(int2)(i-1,j-2));
    float4 pixel11 = read_imagef(inputImage,sampler,(int2)(i+1,j-2));
    float4 pixel12 = read_imagef(inputImage,sampler,(int2)(i-0,j-2));
    float4 pixel13 = read_imagef(inputImage,sampler,(int2)(i+2,j-2));
    float4 pixel14 = read_imagef(inputImage,sampler,(int2)(i+2,j-1));
    float4 pixel15 = read_imagef(inputImage,sampler,(int2)(i+2,j+0));
    float4 pixel16 = read_imagef(inputImage,sampler,(int2)(i+2,j+1));
    float4 pixel17 = read_imagef(inputImage,sampler,(int2)(i+1,j+0));
    float4 pixel18 = read_imagef(inputImage,sampler,(int2)(i+1,j-1));
    float4 pixel19 = read_imagef(inputImage,sampler,(int2)(i-0,j-1));
    float4 pixel20 = read_imagef(inputImage,sampler,(int2)(i-1,j-1));
    float4 pixel21 = read_imagef(inputImage,sampler,(int2)(i-1,j+0));
    float4 pixel22 = read_imagef(inputImage,sampler,(int2)(i-1,j+1));
    float4 pixel23 = read_imagef(inputImage,sampler,(int2)(i-0,j+1));
    float4 pixel24 = read_imagef(inputImage,sampler,(int2)(i+1,j+1));
    pixel_new += (pixel0)*(float)24.0; accumWeights += 24;
    pixel_new -= (pixel1)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel2)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel3)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel4)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel5)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel6)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel7)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel8)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel9)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel10)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel11)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel12)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel13)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel14)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel15)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel16)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel17)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel18)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel19)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel20)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel21)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel22)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel23)*(float)1.0; accumWeights -= 1;
    pixel_new -= (pixel24)*(float)1.0; accumWeights -= 1;
    pixel_new = fabs(pixel_new);
    if (pixel_new.x>255) pixel_new.x = 255;
    if (pixel_new.y>255) pixel_new.y = 255;
    if (pixel_new.z>255) pixel_new.z = 255;
    pixel_new.w = 255;
    write_imagef(outputImage,(int2)(i,j), pixel_new);
};


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
