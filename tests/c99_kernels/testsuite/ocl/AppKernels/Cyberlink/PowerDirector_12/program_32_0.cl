#define HLSMAX 65532	// H,L, and S vary over 0-HLSMAX.
#define RGBMAX 255	// R,G, and B vary over 0-RGBMAX. HLSMAX BEST if DIVISIBLE BY 6. RGBMAX, HLSMAX must each fit in a byte.
#define HLSMAX_DIV2 32766
#define HLSMAX_DIV3 21844
#define HLSMAX_DIV6 10922
#define HLSMAX_DIV12 5461
#define HLSMAX_DIV3_MUL2 43688
#define RGBMAX_MUL2 510

__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSamplerNoClamp = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_NONE | CLK_FILTER_NEAREST;


inline int4 adjustLevelInt4(int4 input, int4 inputBlack, int4 inputWhite, int4 outputBlack, int4 outputWhite) {
    int4 output;
    int4 adjustedLevel = outputBlack + (outputWhite - outputBlack) * (input - inputBlack) / (inputWhite - inputBlack);
    output = (input<=inputBlack)?outputBlack:(input>=inputWhite)?outputWhite:adjustedLevel;
    return output;
}

inline uint4 adjustLevelUint4(uint4 input, uint4 inputBlack, uint4 inputWhite, uint4 outputBlack, uint4 outputWhite) {
    uint4 output;
    uint4 adjustedLevel = outputBlack + (outputWhite - outputBlack) * (input - inputBlack) / (inputWhite - inputBlack);
    output = (input<=inputBlack)?outputBlack:(input>=inputWhite)?outputWhite:adjustedLevel;
    return output;
}

inline uint3 adjustLevelUint3(uint3 input, uint3 inputBlack, uint3 inputWhite, uint3 outputBlack, uint3 outputWhite) {
    uint3 output;
    uint3 adjustedLevel = outputBlack + (outputWhite - outputBlack) * (input - inputBlack) / (inputWhite - inputBlack);
    output = (input<=inputBlack)?outputBlack:(input>=inputWhite)?outputWhite:adjustedLevel;
    return output;
}

inline int adjustLevelInt(int input, int inputBlack, int inputWhite, int outputBlack, int outputWhite) {
    int output;
    int adjustedLevel = outputBlack + (outputWhite - outputBlack) * (input - inputBlack) / (inputWhite - inputBlack);
    output = (input<=inputBlack)?outputBlack:(input>=inputWhite)?outputWhite:adjustedLevel;
    return output;
}


#define PENINK_UNSHARPMASK_UNROLL  12
__kernel void PenInk_UnSharpMask_AdjustLevel_Case2_Part1_Simple(__read_only image2d_t src
                                                                , __write_only image2d_t dst
                                                                , __global int* restrict FxMatrix
                                                                , int width, int height
                                                                , int MatrixLength, int MatrixLength_Half) {

    int x = get_global_id(0);
    int y = get_global_id(1);
    int2 coord;

    uint4 fxSum = {0, 0, 0, 0};
    uint fxScale = 0;
    bool outOfBound = false;
    int srcX = x - MatrixLength_Half;

    int j = 0;
    while (j+PENINK_UNSHARPMASK_UNROLL<MatrixLength) {
#pragma unroll PENINK_UNSHARPMASK_UNROLL
        for (int i = 0; i < PENINK_UNSHARPMASK_UNROLL; i++,j++,srcX++) {
            int clampedSrcX = clamp(srcX,0,width-1);
            coord = (int2)(clampedSrcX, y);
	        uint4 tempSrc = read_imageui(src, imageSamplerNoClamp, coord);

            outOfBound|=(clampedSrcX==srcX);
            tempSrc = (clampedSrcX==srcX)?tempSrc:(uint4)0;

            int matrixValue = *(FxMatrix+j);
            fxScale+=(clampedSrcX==srcX)?matrixValue:0;

            fxSum.x += matrixValue * tempSrc.x;
            fxSum.y += matrixValue * tempSrc.y;
            fxSum.z += matrixValue * tempSrc.z;
        }
    }
    for (; j < MatrixLength; j++, srcX++) {

        int clampedSrcX = clamp(srcX,0,width-1);
        coord = (int2)(clampedSrcX, y);
	    uint4 tempSrc = read_imageui(src, imageSamplerNoClamp, coord);

        outOfBound|=(clampedSrcX==srcX);
        tempSrc = (clampedSrcX==srcX)?tempSrc:(uint4)0;

        int matrixValue = *(FxMatrix+j);
        fxScale+=(clampedSrcX==srcX)?matrixValue:0;

        fxSum.x += matrixValue * tempSrc.x;
        fxSum.y += matrixValue * tempSrc.y;
        fxSum.z += matrixValue * tempSrc.z;
    }

    uint divisor = outOfBound?fxScale:65536;
    fxSum/=divisor;
    coord = (int2)(x,y);
    write_imageui(dst, coord, fxSum);
}

constant int4 nInputBlack = {0,0,0,0};
constant int4 nInputWhite = {255,255,255,255};
constant int4 nOutputBlack = {0,0,0,0};
constant int4 nOutputWhite = {225,225,225,225};
__kernel void PenInk_UnSharpMask_AdjustLevel_Case2_Part2_Simple(__read_only image2d_t OriginalSrc
                                                                , __read_only image2d_t src
                                                                , __write_only image2d_t dst
                                                                , __global int* restrict FxMatrix
                                                                , int width, int height
                                                                , int MatrixLength, int MatrixLength_Half
                                                                , int Threshold, int fxAmount) {

    int x = get_global_id(0);
    int y = get_global_id(1);

    int4 fxSum = {0, 0, 0, 0};
    uint fxScale = 0;
    bool outOfBound = false;
    int srcY = y - MatrixLength_Half;


    int j = 0;
    while (j+PENINK_UNSHARPMASK_UNROLL < MatrixLength) {
#pragma unroll PENINK_UNSHARPMASK_UNROLL
        for (int i=0; i<PENINK_UNSHARPMASK_UNROLL; i++,j++,srcY++) {

            int clampedSrcY = clamp(srcY,0,height-1);
            int2 coord = (int2)(x,clampedSrcY);
            uint4 tempSrc =  read_imageui(src, imageSamplerNoClamp, coord);

            outOfBound|=(clampedSrcY==srcY);
            tempSrc = (clampedSrcY==srcY)?tempSrc:(uint4)0;

            int matrixValue = *(FxMatrix+j);
            fxScale+=(clampedSrcY==srcY)?matrixValue:0;

            fxSum.x += matrixValue * tempSrc.x;
            fxSum.y += matrixValue * tempSrc.y;
            fxSum.z += matrixValue * tempSrc.z;
        }
    }
    for (; j < MatrixLength; j++, srcY++) {

        int clampedSrcY = clamp(srcY,0,height-1);
        int2 coord = (int2)(x,clampedSrcY);
        uint4 tempSrc =  read_imageui(src, imageSamplerNoClamp, coord);

        outOfBound|=(clampedSrcY==srcY);
        tempSrc = (clampedSrcY==srcY)?tempSrc:(uint4)0;

        int matrixValue = *(FxMatrix+j);
        fxScale+=(clampedSrcY==srcY)?matrixValue:0;

        fxSum.x += matrixValue * tempSrc.x;
        fxSum.y += matrixValue * tempSrc.y;
        fxSum.z += matrixValue * tempSrc.z;
    }

    int divisor = outOfBound?fxScale:65536;
    int4 tempResult = fxSum/divisor;

    int4 tempOriginalSrc = convert_int4(read_imageui(OriginalSrc, imageSamplerNoClamp, (int2)(x,y)));
    int4 nDiff = tempOriginalSrc - tempResult;
    nDiff = select(nDiff, (int4)0, abs((int4)2*nDiff)<(uint4)Threshold);

    tempResult = tempOriginalSrc + (((int4)fxAmount * nDiff) >> (int4)16);
    tempResult = clamp(tempResult,0,255);

    tempResult = adjustLevelInt4(tempResult, nInputBlack, nInputWhite, nOutputBlack, nOutputWhite);
    write_imageui(dst, (int2)(x,y), convert_uint4(tempResult));
}


#define INVERT_BLUR_ADJLVL_P1_SIMPLE_UNROLL 32

__kernel void PenInk_Invert_Blur_AdjustLevel_Part1_Simple(__read_only image2d_t src
                                                        , __global uint4* dst
                                                        , int width, int height, int offsetX, int blurRadius) {
    int x = get_global_id(0) + offsetX;
    int y = get_global_id(1);

    uint4 result = (uint4)0;
    int currentX = x - blurRadius;
    int2 coord;
    coord.y = y;
    for (int i = 0; i < (2*blurRadius+1); i++, currentX++) {
        int clampedX = clamp(currentX, 0, width-1);
        coord.x = clampedX;
        uint4 pixel = read_imageui(src, imageSamplerNoClamp, coord);
        pixel.xyz = ((uint3)255 - pixel.xyz);
        pixel = (currentX==clampedX)?pixel:(uint4)0;
        result.xyz += pixel.xyz;
    }
    *(dst + y*width + x) = result;
}


__kernel void PenInk_Invert_Blur_AdjustLevel_Part2_Simple(__global uint4* src
                                                        , __write_only image2d_t dst
                                                        , int width, int height, int offsetY, int blurRadius) {

    int x = get_global_id(0);
    int y = get_global_id(1)+offsetY;

    uint4 sum = (uint4)0;
    int currentY = y - blurRadius;
    int i = 0;
    while (i+INVERT_BLUR_ADJLVL_P1_SIMPLE_UNROLL < (2*blurRadius+1)) {
#pragma unroll INVERT_BLUR_ADJLVL_P1_SIMPLE_UNROLL
        for (int j=0; j<INVERT_BLUR_ADJLVL_P1_SIMPLE_UNROLL; j++,i++,currentY++) {
            int clampedY = clamp(currentY, 0, height-1);
            uint4 v = *(src + clampedY*width + x);
            v = (currentY==clampedY)?v:(uint4)0;
            sum.xyz+=v.xyz;
        }
    }
    for (; i < (2*blurRadius+1); i++, currentY++) {
        int clampedY = clamp(currentY, 0, height-1);
        uint4 v = *(src + clampedY*width + x);
        v = (currentY==clampedY)?v:(uint4)0;
        sum.xyz+=v.xyz;
    }

    int numX = min(x+blurRadius, width-1) - max(x-blurRadius, 0) + 1;
    int numY = min(y+blurRadius, height-1) - max(y-blurRadius, 0) + 1;
    uint weight = (uint)(numX*numY);

    uint4 result;
    result.xyz = (uint3)sum.xyz/(uint3)weight;
    result.xyz = adjustLevelUint3(result.xyz, (uint3)0, (uint3)255, (uint3)0, (uint3)225);
    result.w = 0;

    int2 coord = (int2)(x,y);
    write_imageui(dst, coord, result);
}


#define PENINK_INVERT_BLUR_ADJLVL_UNROLL   16
__kernel void PenInk_Invert_Blur_AdjustLevel_Part1_Opt2(__read_only image2d_t src
                                                        , __global uint4* dst
                                                        , int width, int height, int blurRadius) {

	int h = get_global_id(0);

	int nBound = width < height ? width : height;
	int nRealBlurRadius = blurRadius;
	if((nRealBlurRadius * 2 + 1) > nBound)
		nRealBlurRadius = (nBound - 1) / 2;

	nRealBlurRadius = nRealBlurRadius + 1;

    int2 coord = {0, 0};
	uint4 SumARGB = {0, 0, 0, 0};
	uint4 tempSrc;
	int index = 0;
	for (int x = 0; x < nRealBlurRadius; ++x) {
		coord = (int2)(index, h);
		tempSrc = read_imageui(src, imageSamplerNoClamp, coord);
        index++;

		SumARGB.x += (255 - (int)tempSrc.x);
		SumARGB.y += (255 - (int)tempSrc.y);
		SumARGB.z += (255 - (int)tempSrc.z);
	}

	int index_Dst = 0;
    *(dst + h*width + index_Dst) = SumARGB;
	index_Dst++;

	for(int x = 1; x < nRealBlurRadius; ++x) {
		coord = (int2)(index, h);
		tempSrc = read_imageui(src, imageSamplerNoClamp, coord);
        index++;

		SumARGB.x += (255 - (int)tempSrc.x);
		SumARGB.y += (255 - (int)tempSrc.y);
		SumARGB.z += (255 - (int)tempSrc.z);

        *(dst + h*width + index_Dst) = SumARGB;
		index_Dst++;
	}

    int index_Left = 0;


    int x = nRealBlurRadius;
    while (x+PENINK_INVERT_BLUR_ADJLVL_UNROLL<width-blurRadius) {
        for (int j=0; j<PENINK_INVERT_BLUR_ADJLVL_UNROLL; j++,++x) {
            coord = (int2)(index, h);
            tempSrc = read_imageui(src, imageSamplerNoClamp, coord);
            index++;

            SumARGB.x += (255 - (int)tempSrc.x);
            SumARGB.y += (255 - (int)tempSrc.y);
            SumARGB.z += (255 - (int)tempSrc.z);

            coord = (int2)(index_Left, h);
            tempSrc = read_imageui(src, imageSamplerNoClamp, coord);
            index_Left++;

            SumARGB.x -= (255 - (int)tempSrc.x);
            SumARGB.y -= (255 - (int)tempSrc.y);
            SumARGB.z -= (255 - (int)tempSrc.z);

            *(dst + h*width + index_Dst) = SumARGB;
            index_Dst++;
        }
    }
	for (; x < width-blurRadius; ++x) {
		coord = (int2)(index, h);
		tempSrc = read_imageui(src, imageSamplerNoClamp, coord);
        index++;

		SumARGB.x += (255 - (int)tempSrc.x);
		SumARGB.y += (255 - (int)tempSrc.y);
		SumARGB.z += (255 - (int)tempSrc.z);

		coord = (int2)(index_Left, h);
		tempSrc = read_imageui(src, imageSamplerNoClamp, coord);
        index_Left++;

		SumARGB.x -= (255 - (int)tempSrc.x);
		SumARGB.y -= (255 - (int)tempSrc.y);
		SumARGB.z -= (255 - (int)tempSrc.z);

        *(dst + h*width + index_Dst) = SumARGB;
		index_Dst++;
	}



	for (int x = width - blurRadius; x < width; ++x) {
		coord = (int2)(index_Left, h);
		tempSrc = read_imageui(src, imageSamplerNoClamp, coord);

		SumARGB.x -= (255 - (int)tempSrc.x);
		SumARGB.y -= (255 - (int)tempSrc.y);
		SumARGB.z -= (255 - (int)tempSrc.z);
		index_Left++;

        *(dst + h*width + index_Dst) = SumARGB;
		index_Dst++;
	}
}


__kernel void PenInk_Invert_Blur_AdjustLevel_Part2_Opt2(__global uint4* src
                                                        , __write_only image2d_t dst
                                                        , int width, int height, int blurRadius) {
	int w = get_global_id(0);
	int2 coord = {0, 0};

	int nBound = width < height ? width : height;
	int nRealBlurRadius = blurRadius;
	if((nRealBlurRadius * 2 + 1) > nBound)
		nRealBlurRadius = (nBound - 1) / 2;

	nRealBlurRadius = nRealBlurRadius + 1;

	uint4 SumARGB = {0, 0, 0, 0};
    uint4 tempResult;
	int index = 0;
	for (int y = 0; y < nRealBlurRadius; ++y) {
        tempResult = *(src + index*width + w);
		SumARGB.x += tempResult.x;
		SumARGB.y += tempResult.y;
		SumARGB.z += tempResult.z;
		index++;
	}

	int num = nRealBlurRadius;
    int numX = min(w+blurRadius, width-1) - max(w-blurRadius, 0) + 1;
    int weighting = numX*num;

	tempResult.x = SumARGB.x / weighting;
	tempResult.y = SumARGB.y / weighting;
	tempResult.z = SumARGB.z / weighting;
    tempResult.xyz = adjustLevelUint3(tempResult.xyz, (uint3)0, (uint3)255, (uint3)0, (uint3)225);

    int index_Dst = 0;
    coord = (int2)(w, index_Dst);
	write_imageui(dst, coord, tempResult);
	index_Dst++;

	// top
	for(int x = 1; x < nRealBlurRadius; ++x) {

        tempResult = *(src + index*width + w);
		SumARGB.x += tempResult.x;
		SumARGB.y += tempResult.y;
		SumARGB.z += tempResult.z;

		index++;
		num += 1;

		weighting = num * numX;

		tempResult.x = SumARGB.x / weighting;
		tempResult.y = SumARGB.y / weighting;
		tempResult.z = SumARGB.z / weighting;

        tempResult.xyz = adjustLevelUint3(tempResult.xyz, (uint3)0, (uint3)255, (uint3)0, (uint3)225);
		coord = (int2)(w, index_Dst);
		write_imageui(dst, coord, tempResult);
		index_Dst++;
	}

	// middle
	int index_Top = 0;
    weighting = num * numX;


    int x = nRealBlurRadius;
    while (x+PENINK_INVERT_BLUR_ADJLVL_UNROLL < height - blurRadius) {
        for (int j=0; j<PENINK_INVERT_BLUR_ADJLVL_UNROLL; j++,++x) {

            tempResult = *(src + index*width + w);
            SumARGB.x += tempResult.x;
            SumARGB.y += tempResult.y;
            SumARGB.z += tempResult.z;
            index++;

            tempResult = *(src + index_Top*width + w);
            SumARGB.x -= tempResult.x;
            SumARGB.y -= tempResult.y;
            SumARGB.z -= tempResult.z;
            index_Top++;

            tempResult.x = SumARGB.x / weighting;
            tempResult.y = SumARGB.y / weighting;
            tempResult.z = SumARGB.z / weighting;
            tempResult.xyz = adjustLevelUint3(tempResult.xyz, (uint3)0, (uint3)255, (uint3)0, (uint3)225);

            coord = (int2)(w, index_Dst);
            write_imageui(dst, coord, tempResult);
            index_Dst++;
        }
    }
	for (; x < height - blurRadius; ++x) {

        tempResult = *(src + index*width + w);
		SumARGB.x += tempResult.x;
		SumARGB.y += tempResult.y;
		SumARGB.z += tempResult.z;
        index++;

        tempResult = *(src + index_Top*width + w);
		SumARGB.x -= tempResult.x;
		SumARGB.y -= tempResult.y;
		SumARGB.z -= tempResult.z;
		index_Top++;

		tempResult.x = SumARGB.x / weighting;
		tempResult.y = SumARGB.y / weighting;
		tempResult.z = SumARGB.z / weighting;
        tempResult.xyz = adjustLevelUint3(tempResult.xyz, (uint3)0, (uint3)255, (uint3)0, (uint3)225);

		coord = (int2)(w, index_Dst);
		write_imageui(dst, coord, tempResult);
		index_Dst++;
	}

	// bottom
	for (int x = height - nRealBlurRadius; x < height; ++x) {

        tempResult = *(src + index_Top*width + w);
		SumARGB.x -= tempResult.x;
		SumARGB.y -= tempResult.y;
		SumARGB.z -= tempResult.z;

		index_Top++;
		num -= 1;

		weighting = num * numX;

		tempResult.x = SumARGB.x / weighting;
		tempResult.y = SumARGB.y / weighting;
		tempResult.z = SumARGB.z / weighting;

        tempResult.xyz = adjustLevelUint3(tempResult.xyz, (uint3)0, (uint3)255, (uint3)0, (uint3)225);
		coord = (int2)(w, index_Dst);
		write_imageui(dst, coord, tempResult);
		index_Dst++;
	}
}


__kernel void PenInk_Blend_GrayLevel_AdjustLevel_Simple(__read_only image2d_t ImageDst
                                                        , __read_only image2d_t ImageColorDodge
                                                        , __write_only image2d_t ImageResult
                                                        , int width, int height, float AdjustLevel) {

	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int4 tempImageDst = convert_int4(read_imageui(ImageDst, imageSampler, coord));
    int3  tempImageDst3 = tempImageDst.xyz;

	int3 tempColorDodge = convert_int4(read_imageui(ImageColorDodge, imageSampler, coord)).xyz;
    int3 tempResult = clamp((tempImageDst3<<8)/(255 - tempColorDodge), 0, 255);

	int nGray = (( 1053 * (int)(tempResult.z) + 2064 * (int)(tempResult.y) +  401 * (int)(tempResult.x) +  67584 ) >> 12);

    nGray = adjustLevelInt(nGray, 128.0f*AdjustLevel, 255, 0, 225);

	tempImageDst.x = nGray;
	write_imageui(ImageResult, coord, convert_uint4(tempImageDst));
}



inline int HueToRGB(int n1, int n2, int h)
{
	// Range check: note values passed add/subtract thirds of range.
    h += (h<0)?HLSMAX:(h>HLSMAX)?-HLSMAX:0;

	// Return r, g, or b value from this tridrant.
    int t1 = (HLSMAX_DIV3_MUL2 - h);
        t1 = (h < HLSMAX_DIV6)?h:t1;
        t1 = (n1 + (((n2 - n1) * t1 + HLSMAX_DIV12) / HLSMAX_DIV6));

    int result = (h < HLSMAX_DIV6)?t1
                                  :(h < HLSMAX_DIV2)?n2
                                                    :(h < HLSMAX_DIV3_MUL2)?t1:n1;
    return result;
}

__kernel void PenInk_ModifyHSL_Opt1(__read_only image2d_t ImageSrc
                                    , __read_only image2d_t ImageLuminance
                                    , __write_only image2d_t ImageDst) {

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc = read_imageui(ImageSrc, imageSampler, coord);
	uint4 tempLuminance = read_imageui(ImageLuminance, imageSampler, coord);
	uint4 tempResult;

	//RGB to HSL
	int H, L, S;
	int cMax, cMin;	// Max and min RGB values.

	// Calculate lightness.
    cMax = max(tempSrc.x,max(tempSrc.y,tempSrc.z));
    cMin = min(tempSrc.x,min(tempSrc.y,tempSrc.z));

	int diff = cMax - cMin;

	L = (((cMax + cMin) * HLSMAX) + RGBMAX) / RGBMAX_MUL2;

    // Chromatic case.

    // Saturation.
    int ts0 = cMax + cMin;
    int ts1 = RGBMAX_MUL2 - cMax - cMin;
    int tempS = (L <= HLSMAX_DIV2)?ts0:ts1;
    S = (diff * HLSMAX + (tempS >> 1)) / tempS;

    // Hue.
    H = (tempSrc.z == cMax)?0:(tempSrc.y == cMax)?HLSMAX_DIV3:HLSMAX_DIV3_MUL2;

    int t0 = (int)tempSrc.y - (int)tempSrc.x;
    int t1 = (int)tempSrc.x - (int)tempSrc.z;
    int t2 = (int)tempSrc.z - (int)tempSrc.y;
    int temp = (tempSrc.z == cMax)?t0:(tempSrc.y == cMax)?t1:t2;

    //Note: hack to avoid divide-by-zero later on (although currently no consequence on GPU...)
    //      It only happens in the achromatic case (cMax == cMin), which doesn't rely on the value of diff anyway.
    diff = (diff==0)?1:diff;

    H += (temp * HLSMAX_DIV6 + (diff >> 1)) / diff;
    H += (H<0)?HLSMAX:(H>HLSMAX)?-HLSMAX:0;

    // r = g = b --> achromatic case.
    S = (cMax == cMin)?0:S;
    H = (cMax == cMin)?HLSMAX_DIV3_MUL2:H;


	H = min(H >> 8, 255);
	S = min(S >> 8, 255);
	H = H << 8;
	S = S << 8;

	L = (int)tempLuminance.x << 8;

	int Magic1, Magic2;	// Calculated magic numbers (really!).

    // Chromatic case.
    // Set up magic numbers.
    Magic2  = L+S;
    Magic2  =   (L <= HLSMAX_DIV2)?0:Magic2;
    int tm2 =   (L <= HLSMAX_DIV2)?HLSMAX:0;
    tm2 = (L*(tm2+S) + HLSMAX_DIV2) / HLSMAX;
    tm2 = (L <= HLSMAX_DIV2)?tm2:-tm2;
    Magic2 += tm2;

    Magic1 = 2 * L - Magic2;
    Magic1 += (Magic1<0)?HLSMAX:(Magic1>HLSMAX)?-HLSMAX:0;

    Magic2 += (Magic2<0)?HLSMAX:(Magic2>HLSMAX)?-HLSMAX:0;


    // Get RGB, change units from HLSMAX to RGBMAX.
    tempResult.z = ((HueToRGB(Magic1, Magic2, H + HLSMAX_DIV3) * RGBMAX + HLSMAX_DIV2) / HLSMAX);
    tempResult.y = ((HueToRGB(Magic1, Magic2, H) * RGBMAX + HLSMAX_DIV2) / HLSMAX);
    tempResult.x = ((HueToRGB(Magic1, Magic2, H - HLSMAX_DIV3) * RGBMAX + HLSMAX_DIV2) / HLSMAX);

    // Achromatic case.
    int tr = L * RGBMAX / HLSMAX;
    tempResult.x = (S == 0)?tr:tempResult.x;
    tempResult.y = (S == 0)?tr:tempResult.y;
    tempResult.z = (S == 0)?tr:tempResult.z;

	tempResult.w = 255;

	write_imageui(ImageDst, coord, tempResult);

}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
