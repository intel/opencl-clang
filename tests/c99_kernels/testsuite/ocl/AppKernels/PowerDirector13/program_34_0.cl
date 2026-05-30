#define LIGHT_LEVEL 250
#define MEDIUM_LEVEL 170
#define DARK_LEVEL  120
#define DIFF_BRUSH_LENGTH 4

__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;


__kernel void initRandomShift2(__global int* restrict RandomTable
                                ,__global int4* restrict RandomTableLevel
                                , int width) {

    int id = get_global_id(0);
    int4 t = RandomTableLevel[id];

    int x = t.x;
    int y = t.y;
    int intensity = t.z;
    int sign = t.w;

    intensity = (sign)?intensity:-intensity;


    //this line does not work on NV 8800GTX, so we have to workaround it.
    //atomic_min(RandomTable+y*width+x, intensity);
    int temp = *(RandomTable+y*width+x);

    if(temp > intensity)
		*(RandomTable+y*width+x) = intensity;
}


__kernel void initRandomShift(__global int* RandomTable, int v) {
    int id = get_global_id(0);
    RandomTable[id] = v;
}



__kernel void PencilSketch2_Level1_Part1_Opt(__read_only image2d_t TempBuffer
                                            , __global int * RandomTable
                                            , __global int * RandomShift
                                            , int width, int height) {
	if((get_global_id(0) >= width) || (get_global_id(1) >= height))
		return;

	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int nIndex = get_global_id(0) + get_global_id(1) * width;

	uint4 TempValue;
	TempValue = read_imageui(TempBuffer, imageSampler, coord);
	int iIntensity = (int)TempValue.x;

	int nRandomShift = RandomShift[nIndex];
    iIntensity+=nRandomShift;
    int clampedIntensity = clamp(iIntensity, 0, 255);
    int random = (nRandomShift==256)?-1
                                    :(iIntensity>LIGHT_LEVEL)?-1:clampedIntensity;
    RandomTable[nIndex] = random;
}



__kernel void PencilSketch2_Level1_Part2_Opt(__read_only image2d_t OriDst
                                            , __read_only image2d_t TempBuffer
                                            , __write_only image2d_t WriteDst
                                            , __global int* RandomTable
                                            , int width, int height, int nLightBrushLength)	{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int2 TempCoord;
	int nIndex = get_global_id(0) + get_global_id(1) * width;
	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 TempValue;
	TempValue = read_imageui(OriDst, imageSampler, coord);

	int nFinalValue = (int)TempValue.x;

	int nHalf = nLightBrushLength / 2;
	for(int i = 0; i < nLightBrushLength; i++)
	{
//		int newX = w - OffsetLongLength[i];
//		int newY = h - OffsetLongLength[i];
		int newX = w - (i - nHalf);
		int newY = h - (i - nHalf);


        int clampedX = clamp(newX,0,width-1);
        int clampedY = clamp(newY,0,height-1);

        TempCoord = (int2)(clampedX, clampedY);
	    TempValue = read_imageui(TempBuffer, imageSampler, TempCoord);
	    int iOriIntensity = (int)TempValue.x;
	    int nIntensityValue = RandomTable[clampedY*width + clampedX];

        bool update = (newX==clampedX)&&(newY==clampedY)
                        &&(iOriIntensity <= LIGHT_LEVEL)
                        &&(nIntensityValue!=-1)&&(nIntensityValue<nFinalValue);
        nFinalValue = update?nIntensityValue:nFinalValue;
	}

	TempValue.x = (uint)nFinalValue;
	TempValue.y = (uint)nFinalValue;
	TempValue.z = (uint)nFinalValue;
	TempValue.w = 255;

	write_imageui(WriteDst, coord, TempValue);
}



__kernel void PencilSketch2_Level2_Part1_Opt(__read_only image2d_t TempBuffer
                                            , __global int * RandomTable
                                            , __global int * RandomShift
                                            , int width, int height)
{
	if((get_global_id(0) >= width) || (get_global_id(1) >= height))
		return;

	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int nIndex = get_global_id(0) + get_global_id(1) * width;

	uint4 TempValue;
	TempValue = read_imageui(TempBuffer, imageSampler, coord);
	int iIntensity = (int)TempValue.x;

	int nRandomShift = RandomShift[nIndex];

    int random = -1;

    iIntensity+=nRandomShift;
    iIntensity =clamp(iIntensity, 0, 255);

    random = (nRandomShift == 256)?random
                                  :(iIntensity>LIGHT_LEVEL)?random
                                                           :(iIntensity <= MEDIUM_LEVEL)?iIntensity:random;

    RandomTable[nIndex] = random;
}

__kernel void PencilSketch2_Level2_Part2_Opt(__read_only image2d_t OriDst
                                            , __read_only image2d_t TempBuffer
                                            , __write_only image2d_t WriteDst
                                            , __global int * RandomTable
                                            /*, __read_only image2d_t RandomTableImg2D */
                                            , int width, int height, int nDarkBrushLength) {
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int2 TempCoord;
	int nIndex = get_global_id(0) + get_global_id(1) * width;
	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 TempValue;
	TempValue = read_imageui(OriDst, imageSampler, coord);

	int nFinalValue = (int)TempValue.x;

	int nHalf = nDarkBrushLength / 2;
	for(int i = 0; i < nDarkBrushLength; i++)
	{
	//	int newX = w - OffsetShortLength[i];
	//	int newY = h + OffsetShortLength[i];
		int newX = w - (i - nHalf);
		int newY = h + (i - nHalf);


        int clampedX = clamp(newX,0,width-1);
        int clampedY = clamp(newY,0,height-1);

        TempCoord = (int2)(clampedX, clampedY);
	    TempValue = read_imageui(TempBuffer, imageSampler, TempCoord);
	    int iOriIntensity = (int)TempValue.x;
	    int nIntensityValue = RandomTable[clampedY*width + clampedX];

        bool update = (newX==clampedX)&&(newY==clampedY)
                        &&(iOriIntensity <= MEDIUM_LEVEL)
                        &&(nIntensityValue!=-1)&&(nIntensityValue<nFinalValue);
        nFinalValue = update?nIntensityValue:nFinalValue;
	}

	TempValue.x = (uint)nFinalValue;
	TempValue.y = (uint)nFinalValue;
	TempValue.z = (uint)nFinalValue;
	TempValue.w = 255;

	write_imageui(WriteDst, coord, TempValue);
}





__kernel void PencilSketch2_Level3_Part1_Opt(__read_only image2d_t TempBuffer
                                            , __global int * RandomTable
                                            , __global int * RandomShift
                                            , int width, int height) {
	if((get_global_id(0) >= width) || (get_global_id(1) >= height))
		return;

	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int nIndex = get_global_id(0) + get_global_id(1) * width;

	uint4 TempValue;
	TempValue = read_imageui(TempBuffer, imageSampler, coord);
	int iIntensity = (int)TempValue.x;

	int nRandomShift = RandomShift[nIndex];

    int random = -1;

    iIntensity += nRandomShift;
    iIntensity = clamp(iIntensity, 0, 255);


    random = (nRandomShift == 256)?random
                                  :(iIntensity>MEDIUM_LEVEL)?random
                                                            :(iIntensity <= DARK_LEVEL)?iIntensity:random;
    RandomTable[nIndex] = random;
}

__kernel void PencilSketch2_Level3_Part2_Opt(__read_only image2d_t OriDst
                                            , __read_only image2d_t TempBuffer
                                            , __write_only image2d_t WriteDst
                                            , __global int * RandomTable
                                            , int width, int height, int nDarkBrushLength) {
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int2 TempCoord;
	int nIndex = get_global_id(0) + get_global_id(1) * width;
	int w = get_global_id(0);
	int h = get_global_id(1);

	uint4 TempValue;
	TempValue = read_imageui(OriDst, imageSampler, coord);

	int nFinalValue = (int)TempValue.x;

	int nHalf = nDarkBrushLength / 2;
	for(int i = 0; i < nDarkBrushLength; i++)
	{
	//	int newX = w - OffsetShortLength[i];
	//	int newY = h + OffsetShortLength[i];
		int newX = w - (i - nHalf);
		int newY = h + (i - nHalf);


        int clampedX = clamp(newX,0,width-1);
        int clampedY = clamp(newY,0,height-1);

        TempCoord = (int2)(clampedX, clampedY);
	    TempValue = read_imageui(TempBuffer, imageSampler, TempCoord);
	    int iOriIntensity = (int)TempValue.x;
	    int nIntensityValue = RandomTable[clampedY*width + clampedX];

        bool update = (newX==clampedX)&&(newY==clampedY)
                        &&(iOriIntensity <= MEDIUM_LEVEL)
                        &&(nIntensityValue!=-1)&&(nIntensityValue<nFinalValue);
        nFinalValue = update?nIntensityValue:nFinalValue;
	}

	TempValue.x = (uint)nFinalValue;
	TempValue.y = (uint)nFinalValue;
	TempValue.z = (uint)nFinalValue;
	TempValue.w = 255;

	write_imageui(WriteDst, coord, TempValue);
}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
