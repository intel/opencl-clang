





#define GAUSSIANBLUR_Y_OPT1_NUM                 8
#define GAUSSIANBLUR_Y_OPT1_NUM_MINUS_ONE       7
kernel void GaussianBlur_Y_Opt1(__global uint* src
                                , __global uint* dst
                                , __global const int *Table
                                , __global const int *SumHeight
                                , int width, int height, int BlurRadius) {


    int x = get_global_id(0);
    int y = get_global_id(1)*GAUSSIANBLUR_Y_OPT1_NUM;

    float3 sums[GAUSSIANBLUR_Y_OPT1_NUM];
    float3 temps[GAUSSIANBLUR_Y_OPT1_NUM];

    int ti = 0;
    float f = *(Table+ti);
    ti++;

    int currentY = y - BlurRadius;
#pragma unroll GAUSSIANBLUR_Y_OPT1_NUM
    for (int i = 0; i < GAUSSIANBLUR_Y_OPT1_NUM; i++,currentY++) {
        int clampedY = clamp(currentY, 0, height-1);
        int pixel = *(src + clampedY*width + x);
        pixel = (clampedY==currentY)?pixel:0;
        temps[i].x = (float)(pixel&0x00ff);
        temps[i].y = (float)((pixel>>8)&0x00ff);
        temps[i].z = (float)((pixel>>16)&0x00ff);

        sums[i] = temps[i]*(float3)f;
    }

    for (int i = 0; i < 2*BlurRadius; i++,currentY++) {
        f = *(Table+ti);
        ti++;

#pragma unroll GAUSSIANBLUR_Y_OPT1_NUM_MINUS_ONE
        for (int j = 0; j < GAUSSIANBLUR_Y_OPT1_NUM_MINUS_ONE; j++) {
            temps[j] = temps[j+1];
            sums[j]+=temps[j]*f;
        }
        int clampedY = clamp(currentY, 0, height-1);
        int pixel = *(src + clampedY*width + x);
        pixel = (currentY==clampedY)?pixel:0;
        temps[GAUSSIANBLUR_Y_OPT1_NUM_MINUS_ONE].x = (float)(pixel&0x00ff);
        temps[GAUSSIANBLUR_Y_OPT1_NUM_MINUS_ONE].y = (float)((pixel>>8)&0x00ff);
        temps[GAUSSIANBLUR_Y_OPT1_NUM_MINUS_ONE].z = (float)((pixel>>16)&0x00ff);
        sums[GAUSSIANBLUR_Y_OPT1_NUM_MINUS_ONE]+=temps[GAUSSIANBLUR_Y_OPT1_NUM_MINUS_ONE]*(float3)f;
    }

    if (y + GAUSSIANBLUR_Y_OPT1_NUM - 1 < height)  {
        uint results[GAUSSIANBLUR_Y_OPT1_NUM];
#pragma unroll GAUSSIANBLUR_Y_OPT1_NUM
        for (int i = 0; i < GAUSSIANBLUR_Y_OPT1_NUM; i++) {
            float MaskWidth = 1.0f/(float)*(SumHeight+y+i);
            sums[i] *= MaskWidth;
            int3 r = min(convert_int3(sums[i]), (int3)255);
            results[i] = 255<<24|r.z<<16|r.y<<8|r.x;
        }

        __global uint* d = dst+y*width+x;
#pragma unroll GAUSSIANBLUR_Y_OPT1_NUM
        for (int i = 0; i < GAUSSIANBLUR_Y_OPT1_NUM; i++) {
            *(d + i*width) = results[i];
        }
    }
    else {
        __global uint* d = dst+y*width+x;
        // border case, use predecated store
#pragma unroll GAUSSIANBLUR_Y_OPT1_NUM
        for (int i = 0; i < GAUSSIANBLUR_Y_OPT1_NUM; i++) {
            if (y+i < height) {
                float MaskWidth = 1.0f/(float)*(SumHeight+y+i);
                sums[i] *= MaskWidth;
                int3 r = min(convert_int3(sums[i]), (int3)255);
                uint result = 255<<24|r.z<<16|r.y<<8|r.x;
                *(d + i*width) = result;
            }
        }
    }
}




#define GAUSSIANBLUR_X_OPT1_NUM                 8
#define GAUSSIANBLUR_X_OPT1_NUM_MINUS_ONE       7
__kernel void GaussianBlur_X_Opt1(__global const uint * src
                                    , __global uint * dst
                                    , __global const int *Table
                                    , __global const int *SumWidth
                                    , int width, int height, int BlurRadius) {

    int x = get_global_id(0)*GAUSSIANBLUR_X_OPT1_NUM;
    int y = get_global_id(1);

    float3 sums[GAUSSIANBLUR_X_OPT1_NUM];
    float3 temps[GAUSSIANBLUR_X_OPT1_NUM];

    int ti = 0;
    float f = *(Table+ti);
    ti++;

    int currentX = x - BlurRadius;
#pragma unroll GAUSSIANBLUR_X_OPT1_NUM
    for (int i = 0; i < GAUSSIANBLUR_X_OPT1_NUM; i++,currentX++) {
        int clampedX = clamp(currentX, 0, width-1);
        int pixel = *(src + y*width + clampedX);
        pixel = (currentX==clampedX)?pixel:0;
        temps[i].x = (float)(pixel&0x00ff);
        temps[i].y = (float)((pixel>>8)&0x00ff);
        temps[i].z = (float)((pixel>>16)&0x00ff);

        sums[i] = temps[i]*(float3)f;;
    }

    for (int i = 0; i < 2*BlurRadius; i++, currentX++) {
        f = *(Table+ti);
        ti++;

#pragma unroll GAUSSIANBLUR_X_OPT1_NUM_MINUS_ONE
        for (int j = 0; j < GAUSSIANBLUR_X_OPT1_NUM_MINUS_ONE; j++) {
            temps[j] = temps[j+1];
            sums[j]+=temps[j]*(float3)f;
        }
        int clampedX = clamp(currentX, 0, width-1);
        int pixel = *(src + y*width + clampedX);
        pixel = (currentX==clampedX)?pixel:0;
        temps[GAUSSIANBLUR_X_OPT1_NUM_MINUS_ONE].x = (float)(pixel&0x00ff);
        temps[GAUSSIANBLUR_X_OPT1_NUM_MINUS_ONE].y = (float)((pixel>>8)&0x00ff);
        temps[GAUSSIANBLUR_X_OPT1_NUM_MINUS_ONE].z = (float)((pixel>>16)&0x00ff);
        sums[GAUSSIANBLUR_X_OPT1_NUM_MINUS_ONE]+=temps[GAUSSIANBLUR_X_OPT1_NUM_MINUS_ONE]*(float3)f;
    }


    // check if all results computed by this work item
    // are within bounds
    if (x + GAUSSIANBLUR_X_OPT1_NUM - 1 < width)  {
        // all the results are within bounds
        uint results[GAUSSIANBLUR_X_OPT1_NUM];
#pragma unroll GAUSSIANBLUR_X_OPT1_NUM
        for (int i = 0; i < GAUSSIANBLUR_X_OPT1_NUM; i++) {
            float MaskWidth = 1.0f/(float)*(SumWidth+x+i);
            sums[i] *= MaskWidth;
            int3 r = min(convert_int3(sums[i]), (int3)255);
            results[i] = r.z<<16|r.y<<8|r.x;
        }

        __global uint* d = dst+y*width+x;
#pragma unroll GAUSSIANBLUR_X_OPT1_NUM
        for (int i = 0; i < GAUSSIANBLUR_X_OPT1_NUM; i++) {
            *(d + i) = results[i];
        }
    }
    else {

        __global uint* d = dst+y*width+x;
        // some results are out-of-bound
#pragma unroll GAUSSIANBLUR_X_OPT1_NUM
        for (int i = 0; i < GAUSSIANBLUR_X_OPT1_NUM; i++) {
            if (x+i < width) {
                float MaskWidth = 1.0f/(float)*(SumWidth+x+i);
                sums[i] *= MaskWidth;
                int3 r = min(convert_int3(sums[i]), (int3)255);
                uint result = r.z<<16|r.y<<8|r.x;
                *(d + i) = result;
            }
        }
    }
}



__kernel void GaussianBlur_X_Simple(__global const uint * src
                                    , __global uint * dst
                                    , __global const int *Table
                                    , __global const int *SumWidth
                                    , int width, int height, int BlurRadius, int offsetX) {

    int x = get_global_id(0)+offsetX;
    int y = get_global_id(1);
    float3 sum = 0.0f;

    int currentX = x - BlurRadius;
    for (int i = 0; i < 2*BlurRadius+1; i++, currentX++) {
        int clampedX = clamp(currentX, 0, width-1);
        int pixel = *(src + y*width + clampedX);
        pixel = (currentX==clampedX)?pixel:0;
        float3 fPixel;
        fPixel.x = (float)(pixel&0x00ff);
        fPixel.y = (float)((pixel>>8)&0x00ff);
        fPixel.z = (float)((pixel>>16)&0x00ff);
        sum+=fPixel * (float3)(*(Table+i));
    }
    float MaskWidth = 1.0f/(float)*(SumWidth+x);
    sum *= MaskWidth;

    int3 r = min( convert_int3(sum), (int3)255);
    *(dst + y*width +x) = r.z<<16|r.y<<8|r.x;
}


__kernel void GaussianBlur_Y_Simple(__global const uint * src
                                    , __global uint * dst
                                    , __global const int *Table
                                    , __global const int *SumHeight
                                    , int width, int height, int BlurRadius, int offsetY) {

    int x = get_global_id(0);
    int y = get_global_id(1)+offsetY;
    float3 sum = 0.0f;

    int currentY = y - BlurRadius;
    for (int i = 0; i < 2*BlurRadius+1; i++, currentY++) {
        int clampedY = clamp(currentY, 0, height-1);
        int pixel = *(src + clampedY*width + x);
        pixel = (currentY==clampedY)?pixel:0;
        float3 fPixel;
        fPixel.x = (float)(pixel&0x00ff);
        fPixel.y = (float)((pixel>>8)&0x00ff);
        fPixel.z = (float)((pixel>>16)&0x00ff);
        sum+=fPixel * (float3)(*(Table+i));
    }
    float MaskWidth = 1.0f/(float)*(SumHeight+y);
    sum *= MaskWidth;

    int3 r = min( convert_int3(sum), (int3)255);
    *(dst + y*width +x) = 255<<24|r.z<<16|r.y<<8|r.x;
}










// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
