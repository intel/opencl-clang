__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSamplerNoClamp = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_NONE | CLK_FILTER_NEAREST;


//		pre-calculate "blurRadius" so that the blur diameter is less than or equal to the width and height of buffers!
__kernel void Blur_Horizontal_Gray_Buffer_Simple(__read_only image2d_t src, __global uint* accum
                                                    , int width, int height, int offsetX, int blurRadius) {

    int x = get_global_id(0) + offsetX;
    int y = get_global_id(1);

    // first pixel to load
    int xLeft = x - blurRadius;
    int2 coord = {0, y};

    uint SumGray = 0;
    for (int i = 0; i < (2*blurRadius+1); i++) {

        // the actual x coordinate of the pixel to load
        int currentX = xLeft + i;

        // clamp the x value and load the pixel
        int clampedX = clamp(currentX, 0, width-1);
        coord.x = clampedX;
        uint4 t = read_imageui(src, imageSamplerNoClamp, coord);

        // only add the gray value if it's within bound (currentX==clampedX)
        SumGray += (currentX==clampedX)?t.x:0;
    }
    accum[y*width+x] = SumGray;
}


//		pre-calculate "blurRadius" so that the blur diameter is less than or equal to the width and height of buffers!
#define BLUR_HORIZONTAL_GRAY_OPT_NUM             8    // # of elements computed per work item
#define BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE   7

// !!!  This kernel produces BLUR_HORIZONTAL_GRAY_OPT_NUM results per work item
__kernel void Blur_Horizontal_Gray_Buffer_Simple_Opt(__read_only image2d_t src, __global uint* accum, int width, int height, int blurRadius) {

    // coordindate of the first element to compute
    int x = get_global_id(0)*BLUR_HORIZONTAL_GRAY_OPT_NUM;
    int y = get_global_id(1);

    uint accumulator[BLUR_HORIZONTAL_GRAY_OPT_NUM];
    uint tempValues[BLUR_HORIZONTAL_GRAY_OPT_NUM];

    // x coordinate of the pixel to load from the image
    int tx = x - blurRadius;
    int2 coord = {0, y};

    // initialize the accumulators and temp array
#pragma unroll BLUR_HORIZONTAL_GRAY_OPT_NUM
    for (int i = 0; i < BLUR_HORIZONTAL_GRAY_OPT_NUM; i++) {
        // detect loading out-of-bound pixel
        coord.x = clamp(tx, 0, width-1);
        uint4 t = read_imageui(src, imageSamplerNoClamp, coord);
        accumulator[i] = tempValues[i] = (coord.x==tx)?t.x:0;
        tx++;
    }

    // Compute all the reduction adds (accumulator) in parallel
    // Algorithm:
    // For each iteration, shift all the tempValues to the left by one slot, the rightmost slot gets a value from the image.
    // Add the tempValues to the corresponding accumulators.
    // Repeat 2*blurRadius times to get the final result
    for (int i = 0; i < 2*blurRadius; i++) {
#pragma unroll BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE
        for (int j = 0; j < BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE; j++) {
            // shift left all the temp values by one slot
            tempValues[j] = tempValues[j+1];
            // add the temp values to the acccumulator
            accumulator[j] += tempValues[j];
        }

        // for the last slot of the tempValues, we need to load a new pixel from
        // the image
        coord.x = clamp(tx, 0, width-1);
        uint4 t = read_imageui(src, imageSamplerNoClamp, coord);
        tempValues[BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE] = (coord.x==tx)?t.x:0;
        accumulator[BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE]+=tempValues[BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE];
        tx++;
    }

    // store the results
#pragma unroll BLUR_HORIZONTAL_GRAY_OPT_NUM
    for (int i = 0; i < BLUR_HORIZONTAL_GRAY_OPT_NUM; i++) {
        accum[y*width+x+i] = accumulator[i];
    }
}


// Same algorithm as Blur_Horizontal_Gray_Buffer_Simple_Opt but with the main loop partially unrolled
#define BLUR_HORIZONTAL_GRAY_UNROLL  8   //  unrolling factor used in partial unrolling
__kernel void Blur_Horizontal_Gray_Buffer_Simple_Opt_Unroll(__read_only image2d_t src, __global uint* accum, int width, int height, int blurRadius) {

    // coordindate of the first element to compute
    int x = get_global_id(0)*BLUR_HORIZONTAL_GRAY_OPT_NUM;
    int y = get_global_id(1);

    uint accumulator[BLUR_HORIZONTAL_GRAY_OPT_NUM];
    uint tempValues[BLUR_HORIZONTAL_GRAY_OPT_NUM];

    // x coordinate of the pixel to load from the image
    int tx = x - blurRadius;
    int2 coord = {0, y};

    // initialize the accumulators and temp array
#pragma unroll BLUR_HORIZONTAL_GRAY_OPT_NUM
    for (int i = 0; i < BLUR_HORIZONTAL_GRAY_OPT_NUM; i++) {
        // detect loading out-of-bound pixel
        coord.x = clamp(tx, 0, width-1);
        uint4 t = read_imageui(src, imageSamplerNoClamp, coord);
        accumulator[i] = tempValues[i] = (coord.x==tx)?t.x:0;
        tx++;
    }

    // Compute all the reduction adds (accumulator) in parallel
    // Algorithm:
    // For each iteration, shift all the tempValues to the left by one slot, the rightmost slot gets a value from the image.
    // Add the tempValues to the corresponding accumulators.
    // Repeat 2*blurRadius times to get the final result
    int i = 0;

    // !!! Partial unrolling optimization has been applied to this computation loop.
    // The unrolled loop is guarded by loop guard (the while loop) and will be executed multiple times
    // until the remaining (original) iteration count is less than BLUR_HORIZONTAL_GRAY_UNROLL.
    // The remaining iterations will be executed by the residue loop.

    // guard for the unrolled loop
    while ((i+BLUR_HORIZONTAL_GRAY_UNROLL) < 2*blurRadius) {

#pragma unroll BLUR_HORIZONTAL_GRAY_UNROLL
        for (int n=0; n<BLUR_HORIZONTAL_GRAY_UNROLL; n++,i++) {
#pragma unroll BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE
            for (int j = 0; j < BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE; j++) {
                // shift left all the temp values by one slot
                tempValues[j] = tempValues[j+1];
                // add the temp values to the acccumulator
                accumulator[j] += tempValues[j];
            }

            // for the last slot of the tempValues, we need to load a new pixel from
            // the image
            coord.x = clamp(tx, 0, width-1);
            uint4 t = read_imageui(src, imageSamplerNoClamp, coord);
            tempValues[BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE] = (coord.x==tx)?t.x:0;
            accumulator[BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE]+=tempValues[BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE];
            tx++;
        }
    }  // while ((i+BLUR_HORIZONTAL_GRAY_UNROLL) < 2*blurRadius)
    // !!! The following is the residue loop, which execute one value at a time.
    for (; i < 2*blurRadius; i++) {
#pragma unroll BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE
        for (int j = 0; j < BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE; j++) {
            // shift left all the temp values by one slot
            tempValues[j] = tempValues[j+1];
            // add the temp values to the acccumulator
            accumulator[j] += tempValues[j];
        }

        // for the last slot of the tempValues, we need to load a new pixel from
        // the image
        coord.x = clamp(tx, 0, width-1);
        uint4 t = read_imageui(src, imageSamplerNoClamp, coord);
        tempValues[BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE] = (coord.x==tx)?t.x:0;
        accumulator[BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE]+=tempValues[BLUR_HORIZONTAL_GRAY_OPT_NUM_MINUS_ONE];
        tx++;
    }

    // store the results
#pragma unroll BLUR_HORIZONTAL_GRAY_OPT_NUM
    for (int i = 0; i < BLUR_HORIZONTAL_GRAY_OPT_NUM; i++) {
        accum[y*width+x+i] = accumulator[i];
    }
}



__kernel void Blur_Vertical_Gray_Buffer_Simple(__global uint* accum, __write_only image2d_t dst, int width, int height, int offsetY, int blurRadius) {

    int x = get_global_id(0);
    int y = get_global_id(1) + offsetY;

    // first pixel to load
    int ty = y - blurRadius;
    uint sumGray = 0;
    for (int i = 0; i < (2*blurRadius+1); i++,ty++) {

        // clamp ty to avoid out-of-bound load
        int clampedY = clamp(ty, 0, height-1);
        uint t = accum[clampedY*width + x];

        // only add the gray value if it's within bound (currentY==clampedY)
        sumGray += ((clampedY==ty)?t:0);
    }

    int leftX =  max(0, x-blurRadius);
    int rightX = min(width-1, x+blurRadius);

    int topY =    max(0, y-blurRadius);
    int bottomY = min(height-1, y+blurRadius);

    int divisor = (rightX-leftX+1)*(bottomY-topY+1);

    uint4 result = (uint4)0;
    result.x = sumGray/divisor;
    int2 coord;
    coord.x = x;
    coord.y = y;
    write_imageui(dst, coord, result);
}


#define BLUR_VERTICAL_GRAY_OPT_NUM             8    // # of elements computed per work item
#define BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE   7

// !!!  This kernel produces BLUR_VERTICAL_GRAY_OPT_NUM results per work item
__kernel void Blur_Vertical_Gray_Buffer_Simple_Opt(__global uint* accum, __write_only image2d_t dst, int width, int height, int blurRadius) {

   int x = get_global_id(0);
   int y = get_global_id(1)*BLUR_VERTICAL_GRAY_OPT_NUM;

   uint accumulator[BLUR_VERTICAL_GRAY_OPT_NUM];
   uint tempValues[BLUR_VERTICAL_GRAY_OPT_NUM];

   int ty = y - blurRadius;
#pragma unroll BLUR_VERTICAL_GRAY_OPT_NUM
   for (int i = 0; i < BLUR_VERTICAL_GRAY_OPT_NUM; i++, ty++) {
     int clampedY = clamp(ty, 0, height-1);
     uint t = accum[clampedY*width+x];
     accumulator[i] = tempValues[i] = (ty==clampedY)?t:0;
   }

   for (int i = 0; i < 2*blurRadius; i++, ty++) {
#pragma unroll BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE
       for (int j = 0; j < BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE; j++) {
            tempValues[j] = tempValues[j+1];
            accumulator[j]+=tempValues[j];
       }
       int clampedY = clamp(ty, 0, height-1);
       uint t = accum[clampedY*width+x];
       tempValues[BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE] = (ty==clampedY)?t:0;
       accumulator[BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE]+=tempValues[BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE];
   }


   int leftX =  max(0, x-blurRadius);
   int rightX = min(width-1, x+blurRadius);
#pragma unroll BLUR_VERTICAL_GRAY_OPT_NUM
   for (int i = 0; i < BLUR_VERTICAL_GRAY_OPT_NUM; i++) {
        int topY =    max(0, y+i-blurRadius);
        int bottomY = min(height-1, y+i+blurRadius);
        int divisor = (rightX-leftX+1)*(bottomY-topY+1);
        accumulator[i]/=divisor;
   }

#pragma unroll BLUR_VERTICAL_GRAY_OPT_NUM
   for (int i = 0; i < BLUR_VERTICAL_GRAY_OPT_NUM; i++) {
       int2 coord = {x, y+i};
       uint4 result = (uint4)0;
       result.x = accumulator[i];
       write_imageui(dst, coord, result);
   }
}


// Same algorithm as Blur_Vertical_Gray_Buffer_Simple_Opt but with the main loop partially unrolled
#define BLUR_VERTICAL_GRAY_UNROLL  8
__kernel void Blur_Vertical_Gray_Buffer_Simple_Opt_Unroll(__global uint* accum, __write_only image2d_t dst, int width, int height, int blurRadius) {

   int x = get_global_id(0);
   int y = get_global_id(1)*BLUR_VERTICAL_GRAY_OPT_NUM;

   uint accumulator[BLUR_VERTICAL_GRAY_OPT_NUM];
   uint tempValues[BLUR_VERTICAL_GRAY_OPT_NUM];

   int ty = y - blurRadius;
#pragma unroll BLUR_VERTICAL_GRAY_OPT_NUM
   for (int i = 0; i < BLUR_VERTICAL_GRAY_OPT_NUM; i++, ty++) {
     int clampedY = clamp(ty, 0, height-1);
     uint t = accum[clampedY*width+x];
     accumulator[i] = tempValues[i] = (ty==clampedY)?t:0;
   }

   int i = 0;

    // !!! Partial unrolling optimization has been applied to this computation loop.
    // The unrolled loop is guarded by loop guard (the while loop) and will be executed multiple times
    // until the remaining (original) iteration count is less than BLUR_VERTICAL_GRAY_UNROLL.
    // The remaining iterations will be executed by the residue loop.

    // guard for the unrolled loop
   while (i+BLUR_VERTICAL_GRAY_UNROLL < 2*blurRadius) {
#pragma unroll BLUR_VERTICAL_GRAY_UNROLL
      for (int n=0; n<BLUR_VERTICAL_GRAY_UNROLL; n++,i++, ty++) {
#pragma unroll BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE
        for (int j = 0; j < BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE; j++) {
            tempValues[j] = tempValues[j+1];
            accumulator[j]+=tempValues[j];
        }
        int clampedY = clamp(ty, 0, height-1);
        uint t = accum[clampedY*width+x];
        tempValues[BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE] = (ty==clampedY)?t:0;
        accumulator[BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE]+=tempValues[BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE];
      }
   } // while (i+BLUR_VERTICAL_GRAY_UNROLL < 2*blurRadius)
   // !!! The following is the residue loop, which execute one value at a time.
   for (; i < 2*blurRadius; i++, ty++) {
#pragma unroll BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE
       for (int j = 0; j < BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE; j++) {
            tempValues[j] = tempValues[j+1];
            accumulator[j]+=tempValues[j];
       }
       int clampedY = clamp(ty, 0, height-1);
       uint t = accum[clampedY*width+x];
       tempValues[BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE] = (ty==clampedY)?t:0;
       accumulator[BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE]+=tempValues[BLUR_VERTICAL_GRAY_OPT_NUM_MINUS_ONE];
   }


   int leftX =  max(0, x-blurRadius);
   int rightX = min(width-1, x+blurRadius);
#pragma unroll BLUR_VERTICAL_GRAY_OPT_NUM
   for (int i = 0; i < BLUR_VERTICAL_GRAY_OPT_NUM; i++) {
        int topY =    max(0, y+i-blurRadius);
        int bottomY = min(height-1, y+i+blurRadius);
        int divisor = (rightX-leftX+1)*(bottomY-topY+1);
        accumulator[i]/=divisor;
   }

#pragma unroll BLUR_VERTICAL_GRAY_OPT_NUM
   for (int i = 0; i < BLUR_VERTICAL_GRAY_OPT_NUM; i++) {
       int2 coord = {x, y+i};
       uint4 result = (uint4)0;
       result.x = accumulator[i];
       write_imageui(dst, coord, result);
   }
}



// Simple implementation of the Blur Horizontal ARGB filter, which calculates 1 pixel per work item
__kernel  void Blur_Horizontal_ARGB_Buffer_Simple( __read_only image2d_t src, __global uint4 * accum, int width, int height, int offsetX, int blurRadius) {

    int x = get_global_id(0) + offsetX;
    int y = get_global_id(1);

    uint4 sumARGB = (uint4)0;
    int tx = x - blurRadius;
    for (int i = 0; i < 2*blurRadius+1; i++, tx++) {

        // Detect out-of-bound pixel load.
        int clampedTx = clamp(tx,0,width-1);
        int2 coord = {clampedTx, y};
        uint4 pixel = read_imageui(src, imageSamplerNoClamp, coord);

        // if it's out-of-bound, set pixel to zero
        pixel = (tx==clampedTx)?pixel:(uint4)0;

        sumARGB.x += pixel.x;
        sumARGB.y += pixel.y;
        sumARGB.z += pixel.z;
    }
    accum[y*width + x] = sumARGB;
}


#define BLUR_HORIZONTAL_ARGB_OPT_NUM             8    // # of elements computed per work item
#define BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE   7
// This kernel is similar to Blur_Horizontal_Gray_Buffer_Simple_Opt but it works with ARGB image
__kernel  void Blur_Horizontal_ARGB_Buffer_Simple_Opt( __read_only image2d_t src, __global uint4 * accum, int width, int height, int blurRadius) {

    int x = get_global_id(0) * BLUR_HORIZONTAL_ARGB_OPT_NUM;
    int y = get_global_id(1);

    uint4 sumARGB[BLUR_HORIZONTAL_ARGB_OPT_NUM];
    uint4 tempValues[BLUR_HORIZONTAL_ARGB_OPT_NUM];

    // initialize the sums and temp value array
    int tx = x - blurRadius;
#pragma unroll BLUR_HORIZONTAL_ARGB_OPT_NUM
    for (int i = 0; i < BLUR_HORIZONTAL_ARGB_OPT_NUM; i++, tx++) {

        int clampedTx = clamp(tx, 0, width-1);
        int2 coord = {clampedTx, y};
        uint4 pixel = read_imageui(src, imageSamplerNoClamp, coord);
        pixel = (tx==clampedTx)?pixel:(uint4)0;

        sumARGB[i] = tempValues[i] = pixel;
    }

    // Compute all the reduction sums in parallel
    // Algorithm:
    // For each iteration, shift all the tempValues to the left by one slot, the rightmost slot gets a value from the image.
    // Add the tempValues to the corresponding accumulators.
    // Repeat 2*blurRadius times to get the final result
    for (int i = 0; i < 2*blurRadius; i++, tx++) {
#pragma unroll BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE
        for (int j = 0; j < BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE; j++) {
            tempValues[j] = tempValues[j+1];
            sumARGB[j] += tempValues[j];
        }

        int clampedTx = clamp(tx, 0, width-1);
        int2 coord = {clampedTx, y};
        uint4 pixel = read_imageui(src, imageSamplerNoClamp, coord);
        pixel = (tx==clampedTx)?pixel:(uint4)0;
        tempValues[BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE] = pixel;
        sumARGB[BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE]+=tempValues[BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE];
    }

#pragma unroll BLUR_HORIZONTAL_ARGB_OPT_NUM
    for (int i = 0; i < BLUR_HORIZONTAL_ARGB_OPT_NUM; i++) {
        accum[y*width + x + i] = sumARGB[i];
    }
}


// This kernel implements the same algorithm as Blur_Horizontal_ARGB_Buffer_Simple_Opt, but with the main computation loop partially unrolled
#define BLUR_HORIZONTAL_ARGB_UNROLL  4
__kernel  void Blur_Horizontal_ARGB_Buffer_Simple_Opt_Unroll( __read_only image2d_t src, __global uint4 * accum, int width, int height, int blurRadius) {

    int x = get_global_id(0) * BLUR_HORIZONTAL_ARGB_OPT_NUM;
    int y = get_global_id(1);

    uint4 sumARGB[BLUR_HORIZONTAL_ARGB_OPT_NUM];
    uint4 tempValues[BLUR_HORIZONTAL_ARGB_OPT_NUM];

    // initialize the sums and temp value array
    int tx = x - blurRadius;
#pragma unroll BLUR_HORIZONTAL_ARGB_OPT_NUM
    for (int i = 0; i < BLUR_HORIZONTAL_ARGB_OPT_NUM; i++, tx++) {

        int clampedTx = clamp(tx, 0, width-1);
        int2 coord = {clampedTx, y};
        uint4 pixel = read_imageui(src, imageSamplerNoClamp, coord);
        pixel = (tx==clampedTx)?pixel:(uint4)0;

        sumARGB[i] = tempValues[i] = pixel;
    }


    // Compute all the reduction sums in parallel
    // Algorithm:
    // For each iteration, shift all the tempValues to the left by one slot, the rightmost slot gets a value from the image.
    // Add the tempValues to the corresponding accumulators.
    // Repeat 2*blurRadius times to get the final result


    int i = 0;
    while (i+BLUR_HORIZONTAL_ARGB_UNROLL < 2*blurRadius) {
#pragma unroll BLUR_HORIZONTAL_ARGB_UNROLL
        for (int n = 0; n < BLUR_HORIZONTAL_ARGB_UNROLL; n++, i++, tx++) {
#pragma unroll BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE
            for (int j = 0; j < BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE; j++) {
                tempValues[j] = tempValues[j+1];
                sumARGB[j] += tempValues[j];
            }

            int clampedTx = clamp(tx, 0, width-1);
            int2 coord = {clampedTx, y};
            uint4 pixel = read_imageui(src, imageSamplerNoClamp, coord);
            pixel = (tx==clampedTx)?pixel:(uint4)0;
            tempValues[BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE] = pixel;
            sumARGB[BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE]+=tempValues[BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE];
        }
    } // while (i+BLUR_HORIZONTAL_ARGB_UNROLL < 2*blurRadius)
    for (; i < 2*blurRadius; i++, tx++) {
#pragma unroll BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE
        for (int j = 0; j < BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE; j++) {
            tempValues[j] = tempValues[j+1];
            sumARGB[j] += tempValues[j];
        }

        int clampedTx = clamp(tx, 0, width-1);
        int2 coord = {clampedTx, y};
        uint4 pixel = read_imageui(src, imageSamplerNoClamp, coord);
        pixel = (tx==clampedTx)?pixel:(uint4)0;
        tempValues[BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE] = pixel;
        sumARGB[BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE]+=tempValues[BLUR_HORIZONTAL_ARGB_OPT_NUM_MINUS_ONE];
    }


#pragma unroll BLUR_HORIZONTAL_ARGB_OPT_NUM
    for (int i = 0; i < BLUR_HORIZONTAL_ARGB_OPT_NUM; i++) {
        accum[y*width + x + i] = sumARGB[i];
    }
}



#define BLUR_HORIZONTAL_ARGB_OPT2_NUM 64
#define BLUR_HORIZONTAL_ARGB_OPT2_UNROLL 8

__kernel void Blur_Horizontal_ARGB_Buffer_Opt2( __read_only image2d_t src, __global uint4 * accum, int width, int height, int blurRadius) {

    int x = get_global_id(0)*BLUR_HORIZONTAL_ARGB_OPT2_NUM;
    int y = get_global_id(1);

    uint4 sum = (uint4)0;

    int startX = x - blurRadius;

    int i = 0;
    while (i+BLUR_HORIZONTAL_ARGB_OPT2_UNROLL < 2*blurRadius) {
#pragma unroll BLUR_HORIZONTAL_ARGB_OPT2_UNROLL
        for (int j=0; j<BLUR_HORIZONTAL_ARGB_OPT2_UNROLL; j++,i++) {
            int tx = startX+i;
            int clampedTx = clamp(tx, 0, width-1);
            int2 coord = {clampedTx,y};
            uint4 pixel = read_imageui(src, imageSamplerNoClamp, coord);
            pixel = (tx==clampedTx)?pixel:(uint4)0;
            sum+=pixel;
        }
    }
    for (; i < 2*blurRadius; i++) {
        int tx = startX+i;
        int clampedTx = clamp(tx, 0, width-1);
        int2 coord = {clampedTx,y};
        uint4 pixel = read_imageui(src, imageSamplerNoClamp, coord);
        pixel = (tx==clampedTx)?pixel:(uint4)0;
        sum+=pixel;
    }


    int addX = x + blurRadius;
    int removeX = x - blurRadius;
#pragma unroll BLUR_HORIZONTAL_ARGB_OPT2_UNROLL
    for (int i = 0; i < BLUR_HORIZONTAL_ARGB_OPT2_NUM; i++, addX++, removeX++) {

        int clampedAddX = clamp(addX, 0, width-1);
        int2 coord = {clampedAddX,y};
        uint4 pixel = read_imageui(src, imageSamplerNoClamp, coord);
        pixel = (addX==clampedAddX)?pixel:(uint4)0;
        sum+=pixel;

        accum[y*width+x+i] = sum;

        int clampedRemoveX = clamp(removeX, 0, width-1);
        int2 coord2 = {clampedRemoveX,y};
        uint4 pixel2 = read_imageui(src, imageSamplerNoClamp, coord2);
        pixel2 = (removeX==clampedRemoveX)?pixel2:(uint4)0;
        sum-=pixel2;
    }
}





__kernel  void Blur_Vertical_ARGB_Buffer_Simple(__global uint4 * accum, __write_only image2d_t dst, int width, int height, int offsetY, int blurRadius) {
    int x = get_global_id(0);
    int y = get_global_id(1) + offsetY;

    uint4 sumARGB = (uint4)0;
    int ty = y - blurRadius;
    for (int i = 0; i < 2*blurRadius+1; i++, ty++) {

        // Detect out-of-bound pixel load.
        int clampedTy = clamp(ty,0,height-1);
        uint4 pixel = accum[clampedTy * width + x];

        // if it's out-of-bound, set pixel to zero
        pixel = (ty==clampedTy)?pixel:(uint4)0;

        sumARGB.x += pixel.x;
        sumARGB.y += pixel.y;
        sumARGB.z += pixel.z;
    }
    int leftX =  max(0, x-blurRadius);
    int rightX = min(width-1, x+blurRadius);

    int topY =    max(0, y-blurRadius);
    int bottomY = min(height-1, y+blurRadius);

    int divisor = (rightX-leftX+1)*(bottomY-topY+1);

    sumARGB.x/=divisor;
    sumARGB.y/=divisor;
    sumARGB.z/=divisor;
    sumARGB.w = 0;

    int2 coord = {x,y};
    write_imageui(dst, coord, sumARGB);
}




#define BLUR_VERTICAL_ARGB_OPT_NUM             8    // # of elements computed per work item
#define BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE   7

__kernel  void Blur_Vertical_ARGB_Buffer_Simple_Opt(__global uint4 * accum, __write_only image2d_t dst, int width, int height, int blurRadius) {
    int x = get_global_id(0);
    int y = get_global_id(1)*BLUR_VERTICAL_ARGB_OPT_NUM;

    uint4 sumARGB[BLUR_VERTICAL_ARGB_OPT_NUM];
    uint4 tempValues[BLUR_VERTICAL_ARGB_OPT_NUM];

    int ty = y - blurRadius;
#pragma unroll BLUR_VERTICAL_ARGB_OPT_NUM
    for (int i = 0; i < BLUR_VERTICAL_ARGB_OPT_NUM; i++, ty++) {

        // Detect out-of-bound pixel load.
        int clampedTy = clamp(ty,0,height-1);
        uint4 pixel = accum[clampedTy * width + x];

        // if it's out-of-bound, set pixel to zero
        pixel = (ty==clampedTy)?pixel:(uint4)0;
        sumARGB[i] = tempValues[i] = pixel;
    }

    for (int i = 0; i < 2*blurRadius; i++, ty++) {
#pragma unroll BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE
        for (int j = 0; j < BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE; j++) {
            tempValues[j] = tempValues[j+1];
            sumARGB[j] += tempValues[j];
        }
        // Detect out-of-bound pixel load.
        int clampedTy = clamp(ty,0,height-1);
        uint4 pixel = accum[clampedTy * width + x];

        // if it's out-of-bound, set pixel to zero
        pixel = (ty==clampedTy)?pixel:(uint4)0;
        tempValues[BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE] = pixel;
        sumARGB[BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE]+=tempValues[BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE];
    }

    int leftX =  max(0, x-blurRadius);
    int rightX = min(width-1, x+blurRadius);
    int numX = (rightX-leftX+1);
#pragma unroll BLUR_VERTICAL_ARGB_OPT_NUM
    for (int i = 0; i < BLUR_VERTICAL_ARGB_OPT_NUM; i++) {

        int topY =    max(0, y+i-blurRadius);
        int bottomY = min(height-1, y+i+blurRadius);
        int divisor = numX*(bottomY-topY+1);

        sumARGB[i].x/=divisor;
        sumARGB[i].y/=divisor;
        sumARGB[i].z/=divisor;
        sumARGB[i].w = 0;
    }

#pragma unroll BLUR_VERTICAL_ARGB_OPT_NUM
    for (int i = 0; i < BLUR_VERTICAL_ARGB_OPT_NUM; i++) {
        int2 coord = {x,y+i};
        write_imageui(dst, coord, sumARGB[i]);
    }
}


// This kernel implements the same algorithm as Blur_Vertical_ARGB_Buffer_Simple_Opt, but with the main computation loop partially unrolled
#define BLUR_VERTICAL_ARGB_UNROLL  8
__kernel  void Blur_Vertical_ARGB_Buffer_Simple_Opt_Unroll(__global uint4 * accum, __write_only image2d_t dst, int width, int height, int blurRadius) {
    int x = get_global_id(0);
    int y = get_global_id(1)*BLUR_VERTICAL_ARGB_OPT_NUM;

    uint4 sumARGB[BLUR_VERTICAL_ARGB_OPT_NUM];
    uint4 tempValues[BLUR_VERTICAL_ARGB_OPT_NUM];

    int ty = y - blurRadius;
#pragma unroll BLUR_VERTICAL_ARGB_OPT_NUM
    for (int i = 0; i < BLUR_VERTICAL_ARGB_OPT_NUM; i++, ty++) {

        // Detect out-of-bound pixel load.
        int clampedTy = clamp(ty,0,height-1);
        uint4 pixel = accum[clampedTy * width + x];

        // if it's out-of-bound, set pixel to zero
        pixel = (ty==clampedTy)?pixel:(uint4)0;
        sumARGB[i] = tempValues[i] = pixel;
    }



    int i = 0;
    while (i + BLUR_VERTICAL_ARGB_UNROLL < 2*blurRadius) {
#pragma unroll BLUR_VERTICAL_ARGB_UNROLL
        for (int n = 0; n < BLUR_VERTICAL_ARGB_UNROLL; n++, i++, ty++) {
#pragma unroll BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE
            for (int j = 0; j < BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE; j++) {
                tempValues[j] = tempValues[j+1];
                sumARGB[j] += tempValues[j];
            }
            // Detect out-of-bound pixel load.
            int clampedTy = clamp(ty,0,height-1);
            uint4 pixel = accum[clampedTy * width + x];

            // if it's out-of-bound, set pixel to zero
            pixel = (ty==clampedTy)?pixel:(uint4)0;
            tempValues[BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE] = pixel;
            sumARGB[BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE]+=tempValues[BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE];
        }
    }
    for (; i < 2*blurRadius; i++, ty++) {
#pragma unroll BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE
        for (int j = 0; j < BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE; j++) {
            tempValues[j] = tempValues[j+1];
            sumARGB[j] += tempValues[j];
        }
        // Detect out-of-bound pixel load.
        int clampedTy = clamp(ty,0,height-1);
        uint4 pixel = accum[clampedTy * width + x];

        // if it's out-of-bound, set pixel to zero
        pixel = (ty==clampedTy)?pixel:(uint4)0;
        tempValues[BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE] = pixel;
        sumARGB[BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE]+=tempValues[BLUR_VERTICAL_ARGB_OPT_NUM_MINUS_ONE];
    }


    int leftX =  max(0, x-blurRadius);
    int rightX = min(width-1, x+blurRadius);
    int numX = (rightX-leftX+1);
#pragma unroll BLUR_VERTICAL_ARGB_OPT_NUM
    for (int i = 0; i < BLUR_VERTICAL_ARGB_OPT_NUM; i++) {

        int topY =    max(0, y+i-blurRadius);
        int bottomY = min(height-1, y+i+blurRadius);
        int divisor = numX*(bottomY-topY+1);

        sumARGB[i].x/=divisor;
        sumARGB[i].y/=divisor;
        sumARGB[i].z/=divisor;
        sumARGB[i].w = 0;
    }

#pragma unroll BLUR_VERTICAL_ARGB_OPT_NUM
    for (int i = 0; i < BLUR_VERTICAL_ARGB_OPT_NUM; i++) {
        int2 coord = {x,y+i};
        write_imageui(dst, coord, sumARGB[i]);
    }
}




#define BLUR_VERTICAL_ARGB_OPT2_NUM 16
#define BLUR_VERTICAL_ARGB_OPT2_UNROLL 4

__kernel  void Blur_Vertical_ARGB_Buffer_Opt2(__global uint4 * accum, __write_only image2d_t dst, int width, int height, int blurRadius) {

    int x = get_global_id(0);
    int y = get_global_id(1)*BLUR_VERTICAL_ARGB_OPT2_NUM;

    uint4 sum = (uint4)0;
    int ty = y - blurRadius;
    //int i = 0;

    /*
    while (i+BLUR_VERTICAL_ARGB_OPT2_UNROLL < 2*blurRadius) {
#pragma unroll BLUR_VERTICAL_ARGB_OPT2_UNROLL

        for(int j=0; j < BLUR_VERTICAL_ARGB_OPT2_UNROLL; j++,i++,ty++) {
            int clampedTy = clamp(ty, 0, height-1);
            uint4 pixel = accum[clampedTy*width + x];
            pixel = (ty==clampedTy)?pixel:(uint4)0;
            sum+=pixel;
        }
    }
    */
    for(int i = 0; i < 2*blurRadius; i++,ty++) {
        int clampedTy = clamp(ty, 0, height-1);
        uint4 pixel = accum[clampedTy*width + x];
        pixel = (ty==clampedTy)?pixel:(uint4)0;
        sum+=pixel;
    }

    int leftX =  max(0, x-blurRadius);
    int rightX = min(width-1, x+blurRadius);
    int addY = y + blurRadius;
    int removeY = y - blurRadius;

#pragma unroll BLUR_VERTICAL_ARGB_OPT2_UNROLL
    for (int i = 0; i < BLUR_VERTICAL_ARGB_OPT2_NUM; i++,addY++,removeY++) {

        int clampedAddY = clamp(addY,0,height-1);
        uint4 pixel = accum[clampedAddY*width + x];
        pixel = (clampedAddY==addY)?pixel:(uint4)0;
        sum+=pixel;

        int topY =    max(0, y+i-blurRadius);
        int bottomY = min(height-1, y+i+blurRadius);
        int divisor = (rightX-leftX+1)*(bottomY-topY+1);
        uint4 result;
        result.x = sum.x/divisor;
        result.y = sum.y/divisor;
        result.z = sum.z/divisor;
        result.w = 0;
        int2 coord = {x,y+i};
        write_imageui(dst, coord, result);

        int clampedRemoveY = clamp(removeY,0,height-1);
        pixel = accum[clampedRemoveY*width + x];
        pixel = (clampedRemoveY==removeY)?pixel:(uint4)0;
        sum-=pixel;
    }
}





// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
