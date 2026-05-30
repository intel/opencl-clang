
typedef struct
{
	uint minCornerX;
	uint minCornerY;
	uint maxCornerX;
	uint maxCornerY;
	uint pointsNum;
	uint width;
	uint height;
	uint pad;

} CLDetectedObject;

//http://www.equasys.de/colorconversion.html
//inline float4 RGB_to_YCbCr(float4 RGB)
//{
//	float Y  = dot(RGB, (float4)( 0.257f,  0.504f,  0.098f, 0.0f)) + 0.0625f;
//	float Cb = dot(RGB, (float4)(-0.149f, -0.291f,  0.439f, 0.0f)) + 0.5f;
//	float Cr = dot(RGB, (float4)( 0.439f, -0.368f, -0.071f, 0.0f)) + 0.5f;
//
//	return (float4)(Y, Cb, Cr, 0.0f);
//}
//
//inline float4 YCbCr_to_RGB(float4 YCbCr)
//{
//	YCbCr-=(float4)(0.0625f, 0.5f, 0.5f, 0.0f);
//
//	float R = dot(YCbCr, (float4)(1.164f,  0.000f,   1.596f, 0.0f)) ;
//	float G = dot(YCbCr, (float4)(1.164f, -0.392f,  -0.813f, 0.0f)) ;
//	float B = dot(YCbCr, (float4)(1.164f,  2.017f,   0.000f, 0.0f)) ;
//
//	return (float4)(R, G, B, 0.0f);
//}

inline float4 RGB_to_YCbCr(float4 RGB)
{
	float Y  = dot(RGB, (float4)( 0.299f,  0.587f,  0.114f, 0.0f)) + 0.0f;
	float Cb = dot(RGB, (float4)(-0.169f, -0.331f,  0.500f, 0.0f)) + 0.5f;
	float Cr = dot(RGB, (float4)( 0.500f, -0.419f, -0.081f, 0.0f)) + 0.5f;

	return (float4)(Y, Cb, Cr, 0.0f);
}

inline float4 YCbCr_to_RGB(float4 YCbCr)
{
	YCbCr-=(float4)(0.0f, 0.5f, 0.5f, 0.0f);

	float R = dot(YCbCr, (float4)(1.000f,  0.000f,   1.400f, 0.0f)) ;
	float G = dot(YCbCr, (float4)(1.000f, -0.343f,  -0.711f, 0.0f)) ;
	float B = dot(YCbCr, (float4)(1.000f,  1.765f,   0.000f, 0.0f)) ;

	return (float4)(R, G, B, 0.0f);
}

//http://www.had2know.com/technology/hsi-rgb-color-converter-equations.html
inline float4 RGB_to_HSI(float4 RGB)
{
	float H,S,I;
	float RGB_sum = RGB.x + RGB.y +RGB.z;

	float r = RGB.x / RGB_sum;
	float g = RGB.y / RGB_sum;
	float b = RGB.z / RGB_sum;

	H = acos(clamp((r - 0.5f*g - 0.5f*b) / (sqrt(r*r + g*g + b*b - r*g - r*b - g*b)), -1.0f, 1.0f));
	H = b > g ? 2.0f * M_PI_F - H : H;

	S = 1.0f - 3.0f * min(r, min(g, b));

	I = RGB_sum / 3.0f;

	return (float4)(H, S, I, 0.0f);
}

inline float4 HSI_to_RGB(float4 HSI)
{
	float R,G,B;
	float H = HSI.x;
	float S = HSI.y;
	float I = HSI.z;

	float x = I * (1.0f - S);
	if(H < 2.0f * M_PI_F / 3.0f)
	{
		float y = I * (1 + (S * cos(H)) / (cos(M_PI_F / 3.0f - H)));
		float z = 3.0f * I - (x + y);
		B = x; R = y; G = z;
	}
	else if(H < 4.0f * M_PI_F / 3.0f)
	{
		float y = I * (1.0f + (S * cos(H - 2.0f * M_PI_F / 3.0f)) / (cos(M_PI_F / 3.0f - (H  - 2.0f * M_PI_F / 3.0f))));
		float z = 3.0f * I - (x + y);
		R = x; G = y; B = z;
	}
	else
	{
		float y = I * (1.0f + (S * cos(H - 4.0f * M_PI_F / 3.0f)) / (cos(M_PI_F / 3.0f - (H  - 4.0f * M_PI_F / 3.0f))));
		float z = 3.0f * I - (x + y);
		R = z; G = x; B = y;
	}

	return (float4)(R, G, B, 0.0f);
}

inline float4 RGB_to_HSV(float4 RGB)
{
	float4 K = (float4)(0.0f, -1.0f / 3.0f, 2.0f / 3.0f, -1.0f);
    float4 p = RGB.y < RGB.z ? (float4)(RGB.zy, K.wz) : (float4)(RGB.yz, K.xy);
    float4 q = RGB.x < p.x ? (float4)(p.xyw, RGB.x) : (float4)(RGB.x, p.yzx);

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10f;
    return (float4)(fabs(q.z + (q.w - q.y) / (6.0f * d + e)), d / (q.x + e), q.x, 0.0f);
}

inline float4 HSV_to_RGB(float4 HSV)
{
	float3 tmp;
	float4 K = (float4)(1.0f, 2.0f / 3.0f, 1.0f / 3.0f, 3.0f);
    float3 p = fabs(fract(HSV.xxx + K.xyz, &tmp) * 6.0f - K.www);
    return (float4)(HSV.z * mix(K.xxx, clamp(p - K.xxx, 0.0f, 1.0f), HSV.y), 0.0f);
}

inline float4 RGB_to_YIQ(float4 RGB)
{
	float Y = dot(RGB, (float4)( 0.299f,  0.587f,  0.114f, 0.0f));
	float I = dot(RGB, (float4)( 0.595f, -0.274f, -0.321f, 0.0f));
	float Q = dot(RGB, (float4)( 0.211f, -0.522f,  0.311f, 0.0f));

	return (float4)(Y, I, Q, 0.0f);
}

inline float Luminance(float4 color)
{
	return dot(color, (float4)(0.2126729f, 0.7151522f, 0.0721750f, 0.0f));
}
#define SAMPLER_MACRO const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
#define GLOBAL_ID_2D_MACRO const uint idX = get_global_id(0); const uint idY = get_global_id(1); const uint sizeX = get_global_size(0); const uint sizeY = get_global_size(1); const uint currIndex = idY * sizeX + idX;
#define LOCAL_ID_2D_MACRO const uint l_idX = get_local_id(0); const uint l_idY = get_local_id(1); const uint l_sizeX = get_local_size(0); const uint l_sizeY = get_local_size(1); const uint g_idX = get_group_id(0); const uint g_idY = get_group_id(1); const uint currLIndex = l_idY * l_sizeX + l_idX;

__kernel
void convertOggYuvtoRGB(__global uchar* restrict Ogg_Y, __global uchar* restrict Ogg_u, __global uchar* restrict Ogg_v,
						const int stride_Y, const int stride_u, const int stride_v, const int hdec, const int vdec,
						__global uchar4* restrict sourceImage)
{
	GLOBAL_ID_2D_MACRO

	const uint indexY = idX + idY*stride_Y;
	const uint indexU = idY/2 * stride_u + idX/2;
	const uint indexV = idY/2 * stride_v + idX/2;

	int r = (1904000 * Ogg_Y[indexY] + 2609823 * Ogg_v[indexV] - 363703744) / 1635200;
	int g = (3827562 * Ogg_Y[indexY] - 1287801 * Ogg_u[indexU] - 2672387 * Ogg_v[indexV] + 447306710) / 3287200;
	int b = (952000  * Ogg_Y[indexY] + 1649289 * Ogg_u[indexU] - 225932192) / 817600;

	sourceImage[currIndex] = (uchar4)( clamp(r, 0, 255), clamp(g, 0, 255),  clamp(b, 0, 255), 255);
}

__kernel void hsv(__global uchar4* restrict sourceImage, __write_only image2d_t value)
{
	GLOBAL_ID_2D_MACRO

	float4 RGB = convert_float4(sourceImage[currIndex]) / 255.0f;
	float4 HSV = RGB_to_HSV(RGB);

	write_imageui(value, (int2)(idX, idY), (uint)(HSV.z*255));
}

__constant int xShift[4] = {-8,  0,  -8, 0};
__constant int yShift[4] = {-8, -8,   0, 0};

__kernel void lumEnhancementLoc(__read_only image2d_t value, __write_only image2d_t output, __global uchar* restrict lumEnhancement, __global float* restrict histout)
{
	GLOBAL_ID_2D_MACRO
	LOCAL_ID_2D_MACRO
	SAMPLER_MACRO

	__local uint hist[256];
	__local float cdf[256];
	__local float x[4];
	__local uint lumIndex;

	for(int i=0; i<4; i++)
	{
		hist[currLIndex] = 0;
		barrier(CLK_LOCAL_MEM_FENCE);

		atomic_inc( hist + read_imageui(value, sampler, (int2)(idX+xShift[i], idY+yShift[i])).x );
		barrier(CLK_LOCAL_MEM_FENCE);

		cdf[currLIndex] = hist[currLIndex]/256.0f;
		barrier(CLK_LOCAL_MEM_FENCE);

		//scan
		if (currLIndex%2 == 0)
		{
			int thid = currLIndex/2;
			int offset = 1;
			int n=l_sizeX*l_sizeY;

			for (int d = n>>1; d > 0; d >>= 1)
			{
				barrier(CLK_LOCAL_MEM_FENCE);
				if (thid < d)
				{
					int ai = offset*(2*thid+1)-1;
					int bi = offset*(2*thid+2)-1;
					cdf[bi] += cdf[ai];
				}
				offset *= 2;
			}

			if (thid == 0)
			{
				cdf[n - 1] = 0;
			}

			for (int d = 1; d < n; d *= 2)
			{
				offset >>= 1;
				barrier(CLK_LOCAL_MEM_FENCE);
				if (thid < d)
				{
					int ai = offset*(2*thid+1)-1;
					int bi = offset*(2*thid+2)-1;

					float t = cdf[ai];
					cdf[ai] = cdf[bi];
					cdf[bi] += t;
				}
			}
		}

		barrier(CLK_LOCAL_MEM_FENCE);


		//search L value corresponding cdf(0.1)
		if(currLIndex == 0)
		{
			lumIndex = UINT_MAX;
		}
		barrier(CLK_LOCAL_MEM_FENCE);

		if( cdf[currLIndex] > 0.1f )
		{
			atomic_min(&lumIndex, currLIndex);
		}
		barrier(CLK_LOCAL_MEM_FENCE);

		if(currLIndex == 0)
		{
			//x[i] = (lumIndex <= 50) ? 0.0f : (lumIndex > 150) ? 1.0f : (lumIndex-50.0f)/100.0f;
			x[i] = clamp(1.0f / ( 1.0f + exp(-0.01f*(lumIndex-127.0f))), 0.0f, 1.0f);
			//x[i] = lumIndex/255.0f;
		}
		barrier(CLK_LOCAL_MEM_FENCE);
	}


	//float2 ratio = (float2)((float)l_idX / (float)(l_sizeX-1), (float)l_idY / (float)(l_sizeY-1));
	//float2 opposite = 1.0f - ratio;
	//
    //float xBi = (x[0] * opposite.x  + x[1] * ratio.x) * opposite.y + (x[2] * opposite.x  + x[3] * ratio.x) * ratio.y;

	//histout[g_idX*l_sizeX*l_sizeY + currLIndex] = 0.0f;



	if( (g_idX*l_sizeX < sizeX-16) && (g_idY*l_sizeY < sizeY-16))
	{
	if(currLIndex == 0)
		histout[g_idY*l_sizeY*(sizeX-16) + g_idX*l_sizeX] = x[0];
	if(currLIndex == 7)
		histout[g_idY*l_sizeY*(sizeX-16) + g_idX*l_sizeX+8] = x[1];
	if(currLIndex == 112)
		histout[(g_idY*l_sizeY+8)*(sizeX-16) + g_idX*l_sizeX] = x[2];
	if(currLIndex == 119)
		histout[(g_idY*l_sizeY+8)*(sizeX-16) + g_idX*l_sizeX+8] = x[3];
	}
	else if (g_idX*l_sizeX >= sizeX-16)
	{
		histout[g_idY*l_sizeY*(sizeX-16)+ g_idX*l_sizeX-1] = x[0];
		histout[(g_idY*l_sizeY+8)*(sizeX-16)+ g_idX*l_sizeX-1] = x[2];
	}
	else if (g_idY*l_sizeY >= sizeY-16)
	{
		histout[(g_idY*l_sizeY-1)*(sizeX-16) + g_idX*l_sizeX] = x[0];
		histout[(g_idY*l_sizeY-1)*(sizeX-16) + g_idX*l_sizeX+8] = x[1];
	}
	return;

	histout[(sizeY-16)*(sizeX-16)-1] = x[3];


	//histout[g_idX*l_sizeX*l_sizeY + currLIndex] = cdf[currLIndex];
	//write_imageui(output, (int2)(idX, idY), (uint)(x[0]*255.0f));
}

__kernel void lumEnhancementLoc1(__write_only image2d_t output, __global float* restrict histout, __read_only image2d_t value, __global uchar4* restrict sourceImage, __global float* restrict valueout)
{
	GLOBAL_ID_2D_MACRO
	LOCAL_ID_2D_MACRO
	SAMPLER_MACRO

	float xBi = histout[currIndex];

	__local float x[4];
	if(currLIndex == 0)
	{
		x[0] = histout[g_idY*l_sizeY*sizeX + g_idX*l_sizeX];
		x[1] = histout[g_idY*l_sizeY*sizeX + g_idX*l_sizeX+8];
		x[2] = histout[(g_idY*l_sizeY+8)*sizeX + g_idX*l_sizeX];
		x[3] = histout[(g_idY*l_sizeY+8)*sizeX + g_idX*l_sizeX+8];
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	if(xBi >= 0.0f)
	{
		float2 ratio = (float2)((float)(idX%8) / (float)(8), (float)(idY%8) / (float)(8));
		float2 opposite = 1.0f - ratio;

		xBi = (x[0] * opposite.x  + x[1] * ratio.x) * opposite.y + (x[2] * opposite.x  + x[3] * ratio.x) * ratio.y;
	}

	float v = read_imageui(value, sampler, (int2)(idX, idY)).x / 255.0f;
	float HSVz = (pow(v, 0.75f*xBi + 0.25f) + 0.4f*(1.0f-xBi)*(1.0f-v) + pow(v, 2.0f -xBi)) / 2.0f;
	//float HSVz = v *( 1.0f - xBi);
	//float HSVz = pow(v, 0.75f*xBi + 0.25f);
	//HSVz/=2.0f;
	//HSVz = clamp(HSVz, 0.0f, 1.0f);
	//float HSVz = (1.0f-xBi)*(1.0f-v);

	//int flip_index = (sizeY-idY) * sizeX + sizeX-idX;
	int flip_index = currIndex;

	uchar4 RGB = sourceImage[currIndex];
	float4 RGB_f4 = convert_float4(RGB) / 255.0f;
	float4 HSV = RGB_to_HSV(RGB_f4);
	HSV.z = HSVz;
	RGB_f4 = HSV_to_RGB(HSV);

	//write_imageui(output, (int2)(idX, idY), (convert_uint4)(RGB_f4));
	valueout[currIndex] = HSVz;
	//write_imageui(output, (int2)(idX, idY), (convert_uint4)(HSVz));
}


__kernel void contEnhancement(__read_only image2d_t gauss, __global float* restrict sum, __global uchar4* restrict sourceImage, __global float* restrict value, __write_only image2d_t output, __global uchar* restrict lumEnhancement)
{
	GLOBAL_ID_2D_MACRO

	SAMPLER_MACRO

	float gaussPix = read_imageui(gauss, sampler, (int2)(idX, idY)).x / 255.0f;

	//int flip_index = (sizeY-idY) * sizeX + sizeX-idX;
	int flip_index = currIndex;

	uchar4 RGB = sourceImage[currIndex];
	float4 RGB_f4 = convert_float4(RGB) / 255.0f;
	float4 HSV = RGB_to_HSV(RGB_f4);

	float modValue = value[currIndex];

	int2 imgDim = get_image_dim(gauss);

	HSV.z = pow(modValue, pow(gaussPix/HSV.z, (sum[0]/(imgDim.x*imgDim.y))/255.0f) );
	RGB_f4 = HSV_to_RGB(HSV);

	lumEnhancement[4*flip_index + 0] = RGB_f4.x * 255.0f;
	lumEnhancement[4*flip_index + 1] = RGB_f4.y * 255.0f;
	lumEnhancement[4*flip_index + 2] = RGB_f4.z * 255.0f;

	//write_imageui(output, (int2)(idX, idY), (convert_uint4)(RGB_f4));
}

inline void AtomicAdd(volatile __global float *val, const float delta)
{
	union
	{
		float f;
		unsigned int i;
	} oldVal;

	union
	{
		float f;
		unsigned int i;
	} newVal;

	do
	{
		oldVal.f = *val;
		newVal.f = oldVal.f + delta;
	}
	while (atomic_cmpxchg((volatile __global unsigned int *)val, oldVal.i, newVal.i) != oldVal.i);
}

__kernel
void reductionSum(const int loopIter, __read_only image2d_t in, __global float* restrict resultSum)
{
	const uint gid = get_global_id(0);
	const uint xSize = get_global_size(0);
	const uint lid = get_local_id(0);

	int2 imgDim = get_image_dim(in);

	SAMPLER_MACRO

	if (gid == 0)
	{
		resultSum[0] = 0.0f;
	}

	__local float sdataSum[256];
	sdataSum[lid] = 0.0f;

	for(int i=0; i < loopIter; i++)
	{
		const uint id = i*xSize + gid;

		float currItem = id < imgDim.x*imgDim.y ? read_imageui(in, sampler, (int2)(id%imgDim.x, id/imgDim.x)).x : 0.0f;

		sdataSum[lid] += currItem;
	}

	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 128)
	{
		sdataSum[lid] += sdataSum[lid + 128];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 64)
	{
		sdataSum[lid] += sdataSum[lid + 64];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 32)
	{
		sdataSum[lid] += sdataSum[lid + 32];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 16)
	{
		sdataSum[lid] += sdataSum[lid + 16];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 8)
	{
		sdataSum[lid] += sdataSum[lid + 8];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 4)
	{
		sdataSum[lid] += sdataSum[lid + 4];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 2)
	{
		sdataSum[lid] += sdataSum[lid + 2];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid == 0)
	{
		AtomicAdd(resultSum, sdataSum[0] + sdataSum[1]);
	}
}

__kernel void skinThreshold(__global uchar4* restrict sourceImage, __global uchar4* restrict lumEnhancement, __write_only image2d_t output, __write_only image2d_t skinImage,
                            __write_only image2d_t luminance, __write_only image2d_t mouth)
{
	GLOBAL_ID_2D_MACRO

	uchar4 RGB = sourceImage[currIndex];
	//uchar4 RGB = lumEnhancement[currIndex];

	float4 RGB_f4 = convert_float4(RGB) / 255.0f;

	uchar R = RGB.x;
	uchar G = RGB.y;
	uchar B = RGB.z;
	uchar maxRGB = max(max(R, G), B);
	uchar minRGB = min(min(R, G), B);
	uchar absRG = abs(R-G);
	uchar skin=0;

	if ( (R > 95) && (G > 40) && (B > 20) && (maxRGB-minRGB > 15) && (absRG > 15) && (R > G) && (R > B)
		/*|| (R > 220) && (G > 210) && (B > 170) && (absRG <= 15) && (R > B) && (G > B)*/)
	{
		skin++;
	}

	//YCbCr
	float4 YCbCr = RGB_to_YCbCr(RGB_f4)*255.0f;

	if ( (YCbCr.z <= ( 1.5862f * YCbCr.y + 20.0f)) && (YCbCr.z >= (0.3448f * YCbCr.y + 76.2069f)) && (YCbCr.z >= (-4.5652f * YCbCr.y + 234.5652f)) &&
         (YCbCr.z <= (-1.15f * YCbCr.y + 301.75f)) && (YCbCr.z <= (-2.2857f * YCbCr.y + 432.85f)) )
	{
		skin++;
	}

	////HSI
	float4 HSI = RGB_to_HSI(RGB_f4);
	float h = degrees(HSI.x);

	if ( (h < 25.0f) || h > 230.0f)
	{
		skin++;
	}

	skin = (skin == 3) ? 1 : 0;
	float lips2 = clamp(2.0f * atan((float)(R-G)/R)/M_PI_F, 0.0f, 1.0f);

	write_imageui(skinImage, (int2)(idX, idY), skin*255);
	write_imageui(mouth, (int2)(idX, idY), (lips2*lips2*10.0f)*255.0f);
	write_imageui(luminance, (int2)(idX, idY), Luminance(RGB_f4)*255);
	write_imageui(output, (int2)(idX, idY), convert_uint4(RGB)  );
}

__kernel
void mouthHist(__global CLDetectedObject* faceObject, __global int* faceID, __read_only image2d_t mouth, __global int* restrict hist, __write_only image2d_t output, __global int* histIndex)
{
	GLOBAL_ID_2D_MACRO
	SAMPLER_MACRO

	int _faceID = faceID[0];

	if(_faceID != -1)
	{
		int minX = faceObject[_faceID].minCornerX;
		int minY = faceObject[_faceID].minCornerY;
		int maxX = faceObject[_faceID].maxCornerX;
		int maxY = faceObject[_faceID].maxCornerY;

		if( currIndex == 0 )
			histIndex[0] = INT_MAX;

		if (!( minX < idX && idX < maxX && minY < idY && idY < maxY))
			return;

		uchar mouthPix = read_imageui(mouth, sampler, (int2)(idX, idY)).x ;

		atomic_inc(hist+mouthPix);
	}

	//write_imageui(output, (int2)(idX, idY), mouthPix  );
}

#define HIST_CDF_LOCAL_SIZE 128
__kernel
void mouthHistCDF(__global CLDetectedObject* faceObject, __global int* faceID, __global int* restrict hist, __global int* histIndex)
{
	uint currIndex = get_global_id(0);
	uint currLIndex = get_local_id(0);

	__local float l_cdf[HIST_CDF_LOCAL_SIZE*2];

	int _faceID = faceID[0];

	if (_faceID != -1)
	{
		CLDetectedObject currObj = faceObject[_faceID];
		float boxWidth  = currObj.maxCornerX - currObj.minCornerX;
		float boxHeight = currObj.maxCornerY - currObj.minCornerY;

		l_cdf[2*currLIndex+0] = hist[2*currLIndex+0] / (boxWidth*boxHeight);
		l_cdf[2*currLIndex+1] = hist[2*currLIndex+1] / (boxWidth*boxHeight);
		barrier(CLK_LOCAL_MEM_FENCE);

		//scan
		{
			int thid = currLIndex;
			int offset = 1;
			int n=HIST_CDF_LOCAL_SIZE*2;

			for (int d = n>>1; d > 0; d >>= 1)
			{
				barrier(CLK_LOCAL_MEM_FENCE);
				if (thid < d)
				{
					int ai = offset*(2*thid+1)-1;
					int bi = offset*(2*thid+2)-1;
					l_cdf[bi] += l_cdf[ai];
				}
				offset *= 2;
			}

			if (thid == 0)
			{
				l_cdf[n - 1] = 0;
			}

			for (int d = 1; d < n; d *= 2)
			{
				offset >>= 1;
				barrier(CLK_LOCAL_MEM_FENCE);
				if (thid < d)
				{
					int ai = offset*(2*thid+1)-1;
					int bi = offset*(2*thid+2)-1;

					float t = l_cdf[ai];
					l_cdf[ai] = l_cdf[bi];
					l_cdf[bi] += t;
				}
			}
		}

		barrier(CLK_LOCAL_MEM_FENCE);

		//search index value corresponding cdf(0.96)
		if( l_cdf[2*currLIndex + 0] > 0.96f )
		{
			atomic_min(histIndex, 2*currLIndex);
		}
		if( l_cdf[2*currLIndex + 1] > 0.96f )
		{
			atomic_min(histIndex, 2*currLIndex+1);
		}
	}
}

__kernel
void mouthThres(__global int* restrict histIndex, __global CLDetectedObject* faceObject, __global int* faceID, __read_only image2d_t mouth, __write_only image2d_t output, __write_only image2d_t mouthOut)
{
	GLOBAL_ID_2D_MACRO
	SAMPLER_MACRO

	int _faceID = faceID[0];

	if (_faceID != -1)
	{
		int minX = faceObject[_faceID].minCornerX;
		int minY = faceObject[_faceID].minCornerY;
		int maxX = faceObject[_faceID].maxCornerX;
		int maxY = faceObject[_faceID].maxCornerY;

		uchar mouthPix = read_imageui(mouth, sampler, (int2)(idX, idY)).x ;
		uchar out = (!( minX < idX && idX < maxX && minY + (maxY-minY)/2.5f < idY && idY < maxY) || mouthPix < histIndex[0]) ? 0 : 255;

		//write_imageui(output, (int2)(idX, idY), (uint4)(out, 0, 0, 0)  );
		write_imageui(mouthOut, (int2)(idX, idY), out  );
	}
	else
	{
		write_imageui(mouthOut, (int2)(idX, idY), 0);
	}
}

__kernel
void satVerticalImage(__read_only image2d_t srcSat, __write_only image2d_t sat)
{
	int x = get_global_id(0);
	int width = get_image_width(srcSat);
	int height = get_image_height(srcSat);

	SAMPLER_MACRO

	if (x >= width)
		return;

	int tmpSat = 0;

	for(int colId = 0; colId < height; ++colId)
	{
		const int2 coords = (int2)(x, colId);
		tmpSat += read_imageui(srcSat, sampler, coords).x;
		write_imageui(sat, coords, tmpSat);
	}
}

__kernel
void satHorizontalImage(__read_only image2d_t srcSat, __write_only image2d_t destSat)
{
	int x = get_global_id(0);
	int width = get_image_width(srcSat);
	int height = get_image_height(srcSat);

	SAMPLER_MACRO

	if (x >= height)
		return;

	int tmpSat = 0;

	for(int rowId = 0; rowId < width; ++rowId)
	{
		const int2 coords = (int2)(rowId, x);
		tmpSat += read_imageui(srcSat, sampler, coords).x;
		write_imageui(destSat, coords, tmpSat);
	}
}

inline int getSatImg(__read_only image2d_t satImg, sampler_t satSmp, int x, int y, int width, int height)
{
	return	read_imageui(satImg, satSmp, (int2)(x, y)).x +
			read_imageui(satImg, satSmp, (int2)(x + width, y + height)).x -
			read_imageui(satImg, satSmp, (int2)(x, y + height)).x -
			read_imageui(satImg, satSmp, (int2)(x + width, y)).x;
}

__kernel
void refinement(__read_only image2d_t Sat, __write_only image2d_t output)
{
	GLOBAL_ID_2D_MACRO
	SAMPLER_MACRO

	const int windowRad = 5;
	const float scaleFac = 0.8f;

	int sum = getSatImg(Sat, sampler, idX-windowRad, idY-windowRad, 2*windowRad+1, 2*windowRad+1);
	int fit = (sum >= (2*windowRad+1)*(2*windowRad+1)*scaleFac) ? 255 : 0;

	write_imageui(output, (int2)(idX, idY), fit);
}

__constant char gaussFilter[25] = { 2,  4,  5,  4,  2,
								    4,  9,  12, 9,  4,
								    5,  12, 15, 12, 5,
								    4,  9,  12, 9,  4,
								    2,  4,  5,  4,  2};

#define FILTER_RAD 2

__kernel
void gauss(__read_only image2d_t input, __write_only image2d_t output, __write_only image2d_t outputF)
{
	GLOBAL_ID_2D_MACRO
	SAMPLER_MACRO

	float out = 0.0f;

	for (int r = -FILTER_RAD; r <= FILTER_RAD; r++)
	{
		for (int c = -FILTER_RAD; c <= FILTER_RAD; c++)
		{
			out += read_imageui(input, sampler, (int2)(idX + r, idY + c)).x * gaussFilter[(r+2)*5 + (c+2)];
		}
	}

	out/=159.0f;

	uchar lum = read_imageui(input, sampler, (int2)(idX, idY)).x;
	write_imageui(output, (int2)(idX, idY), out);
	//write_imageui(output, (int2)(idX, idY), read_imageui(input, sampler, (int2)(idX, idY)).x);
	//write_imageui(outputF, (int2)(idX, idY), lum);
}

#define GAUSS_LOC_SIZE 16
__kernel
void gaussLoc(__read_only image2d_t input, __write_only image2d_t output, __write_only image2d_t outputF)
{
	GLOBAL_ID_2D_MACRO
	LOCAL_ID_2D_MACRO
	SAMPLER_MACRO

	__local uchar l_data[4*(GAUSS_LOC_SIZE)*(GAUSS_LOC_SIZE)];

	l_data[l_idY * l_sizeX * 2 + l_idX] = read_imageui(input, sampler, (int2)(idX-GAUSS_LOC_SIZE/2, idY-GAUSS_LOC_SIZE/2)).x;
	l_data[l_idY * l_sizeX * 2 + l_idX + GAUSS_LOC_SIZE] = read_imageui(input, sampler, (int2)(idX + GAUSS_LOC_SIZE/2, idY - GAUSS_LOC_SIZE/2)).x;
	l_data[(l_idY + GAUSS_LOC_SIZE) * l_sizeX * 2 + l_idX] = read_imageui(input, sampler, (int2)(idX - GAUSS_LOC_SIZE/2, idY + GAUSS_LOC_SIZE/2)).x;
	l_data[(l_idY + GAUSS_LOC_SIZE) * l_sizeX * 2 + l_idX + GAUSS_LOC_SIZE] = read_imageui(input, sampler, (int2)(idX + GAUSS_LOC_SIZE/2, idY + GAUSS_LOC_SIZE/2)).x;

	barrier(CLK_LOCAL_MEM_FENCE);

	int sum = 0;
	for (int r = -FILTER_RAD; r <= FILTER_RAD; r++)
	{
		for (int c = -FILTER_RAD; c <= FILTER_RAD; c++)
		{
			sum += l_data[(l_idY+8+c) * l_sizeX * 2 + (l_idX+8+r)] * gaussFilter[(r+2)*5 + (c+2)];
		}
	}
	sum/=159;

	write_imageui(output, (int2)(idX, idY), sum);
	//write_imageui(outputF, (int2)(idX, idY), sum);
}

__kernel
void sobel(__read_only image2d_t input, __write_only image2d_t gradXY, __write_only image2d_t angles, __write_only image2d_t outputF)
{
	GLOBAL_ID_2D_MACRO
	SAMPLER_MACRO

	uchar TL = read_imageui(input, sampler, (int2)(idX - 1, idY + 1)).x;
	uchar TR = read_imageui(input, sampler, (int2)(idX + 1, idY + 1)).x;
	uchar BL = read_imageui(input, sampler, (int2)(idX - 1, idY - 1)).x;
	uchar BR = read_imageui(input, sampler, (int2)(idX + 1, idY - 1)).x;

	float Gx = 0.0f;
	Gx -= BL;
	Gx -= read_imageui(input, sampler, (int2)(idX - 1, idY)).x * 2;
	Gx -= TL;
	Gx += BR;
	Gx += read_imageui(input, sampler, (int2)(idX + 1, idY)).x * 2;
	Gx += TR;

	float Gy = 0.0f;
	Gy += BL;
	Gy += read_imageui(input, sampler, (int2)(idX, idY - 1)).x * 2;
	Gy += BR;
	Gy -= TL;
	Gy -= read_imageui(input, sampler, (int2)(idX, idY + 1)).x * 2;
	Gy -= TR;

	uchar grad = clamp((int)hypot(Gx, Gy),0, 255);

	float angle = atan2(Gy,Gx);
	angle = angle < 0.0f ? fmod((angle + 2.0f*M_PI_F),(2.0f*M_PI_F)) : angle;
	uchar theta = ((uchar)(degrees(angle * (M_PI_F/8.0f) + M_PI_F/8.0f - 0.0001f) / 45.0f) * 45) % 180;

	write_imageui(gradXY, (int2)(idX, idY), grad);
	write_imageui(angles, (int2)(idX, idY), theta);

	//write_imageui(outputF, (int2)(idX, idY), theta);
}

__kernel
void nonMaximum(__read_only image2d_t gradXY, __read_only image2d_t angles, __write_only image2d_t output)
{
	GLOBAL_ID_2D_MACRO
	SAMPLER_MACRO

	uchar currGrad = read_imageui(gradXY, sampler, (int2)(idX, idY)).x;

	uchar currGradT = read_imageui(gradXY, sampler, (int2)(idX, idY+1)).x;
	uchar currGradB = read_imageui(gradXY, sampler, (int2)(idX, idY-1)).x;
	uchar currGradL = read_imageui(gradXY, sampler, (int2)(idX-1, idY)).x;
	uchar currGradR = read_imageui(gradXY, sampler, (int2)(idX+1, idY)).x;

	uchar currGradTL = read_imageui(gradXY, sampler, (int2)(idX-1, idY+1)).x;
	uchar currGradTR = read_imageui(gradXY, sampler, (int2)(idX+1, idY+1)).x;
	uchar currGradBL = read_imageui(gradXY, sampler, (int2)(idX-1, idY-1)).x;
	uchar currGradBR = read_imageui(gradXY, sampler, (int2)(idX+1, idY-1)).x;

	uchar out = 0;

	switch (read_imageui(angles, sampler, (int2)(idX, idY)).x)
    {
        case 0:
            if ( currGrad > currGradT && currGrad >= currGradB )
                out = currGrad;
            break;

        case 45:

            if ( currGrad > currGradTL && currGrad >= currGradBR )
                out = currGrad;
            break;

        case 90:
            if ( currGrad > currGradL && currGrad >= currGradR )
                out = currGrad;
            break;

        case 135:
            if ( currGrad > currGradBL && currGrad >= currGradTR )
                out = currGrad;
            break;

        default:
            out = currGrad;
            break;
    }

	write_imageui(output, (int2)(idX, idY), out);
	//write_imageui(output, (int2)(idX, idY), currGrad);
}

__kernel
void doubleThres(__read_only image2d_t nonMaximum, __write_only image2d_t edges, __write_only image2d_t outputF)
{
	GLOBAL_ID_2D_MACRO
	SAMPLER_MACRO

	float lowThresh = 10;
	float highThresh = 25;
    uchar grad = read_imageui(nonMaximum, sampler, (int2)(idX, idY)).x;

	uchar med = grad >= (highThresh + lowThresh)/2 ? 0 : 255;
	uchar edge = grad >= highThresh ? 0 : grad <= lowThresh ? 255 : med;

	write_imageui(edges, (int2)(idX, idY), edge);
	//write_imageui(outputF, (int2)(idX, idY), edge);
}

__kernel
void merge(__read_only image2d_t edges, __read_only image2d_t skin, __write_only image2d_t output, __write_only image2d_t outputF)
{
	GLOBAL_ID_2D_MACRO
	SAMPLER_MACRO

	uchar skinPix = read_imageui(skin, sampler, (int2)(idX, idY)).x;
	uchar out = read_imageui(edges, sampler, (int2)(idX, idY)).x;

	write_imageui(output, (int2)(idX, idY), out&skinPix);
	//write_imageui(outputF, (int2)(idX, idY), out&skinPix);
}

#define CLOSE_RAD 2

__kernel
void delation(__read_only image2d_t input, __write_only image2d_t output, __write_only image2d_t outputF)
{
	GLOBAL_ID_2D_MACRO
	SAMPLER_MACRO

	int counter=0;

	for (int r = -CLOSE_RAD; r <= CLOSE_RAD; r++)
	{
		for (int c = -CLOSE_RAD; c <= CLOSE_RAD; c++)
		{
			counter += read_imageui(input, sampler, (int2)(idX + r, idY + c)).x > 0 ? 1 : 0;
		}
	}

	uchar out = counter != 0 ? 255 : 0;

	write_imageui(output, (int2)(idX, idY), out);
	//write_imageui(outputF, (int2)(idX, idY), out);
}

__kernel
void erosion(__read_only image2d_t input, __write_only image2d_t output, __write_only image2d_t outputF)
{
	GLOBAL_ID_2D_MACRO
	SAMPLER_MACRO

	int counter=0;

	for (int r = -CLOSE_RAD; r <= CLOSE_RAD; r++)
	{
		for (int c = -CLOSE_RAD; c <= CLOSE_RAD; c++)
		{
			counter += read_imageui(input, sampler, (int2)(idX + r, idY + c)).x / 255;
		}
	}

	uchar out = counter == (2*CLOSE_RAD+1)*(2*CLOSE_RAD+1) ? 255 : 0;

	write_imageui(output, (int2)(idX, idY), out);
	//write_imageui(outputF, (int2)(idX, idY), out);
}

//delate and erosion

#define CLOSE_LOC_SIZE 16
#define CLOSE_LOC_RAD 2
__kernel
void delateLoc(__read_only image2d_t input, __write_only image2d_t output, __write_only image2d_t outputF)
{
	GLOBAL_ID_2D_MACRO
	LOCAL_ID_2D_MACRO
	SAMPLER_MACRO

	__local uchar l_data[4*(CLOSE_LOC_SIZE)*(CLOSE_LOC_SIZE)];

	l_data[l_idY * l_sizeX * 2 + l_idX] = read_imageui(input, sampler, (int2)(idX-CLOSE_LOC_SIZE/2, idY-CLOSE_LOC_SIZE/2)).x;
	l_data[l_idY * l_sizeX * 2 + l_idX + CLOSE_LOC_SIZE] = read_imageui(input, sampler, (int2)(idX + CLOSE_LOC_SIZE/2, idY - CLOSE_LOC_SIZE/2)).x;
	l_data[(l_idY + CLOSE_LOC_SIZE) * l_sizeX * 2 + l_idX] = read_imageui(input, sampler, (int2)(idX - CLOSE_LOC_SIZE/2, idY + CLOSE_LOC_SIZE/2)).x;
	l_data[(l_idY + CLOSE_LOC_SIZE) * l_sizeX * 2 + l_idX + CLOSE_LOC_SIZE] = read_imageui(input, sampler, (int2)(idX + CLOSE_LOC_SIZE/2, idY + CLOSE_LOC_SIZE/2)).x;

	barrier(CLK_LOCAL_MEM_FENCE);

	int sum = 0;
	for (int r = -CLOSE_LOC_RAD; r <= CLOSE_LOC_RAD; r++)
	{
		for (int c = -CLOSE_LOC_RAD; c <= CLOSE_LOC_RAD; c++)
		{
			sum += l_data[(l_idY+8+c) * l_sizeX * 2 + (l_idX+8+r)] > 0 ? 1 : 0;
		}
	}

	write_imageui(output, (int2)(idX, idY), sum == 0 ? 0 : 255);
	//write_imageui(outputF, (int2)(idX, idY), sum == 0 ? 0 : 255);
}

__kernel
void erosionLoc(__read_only image2d_t input, __write_only image2d_t output, __write_only image2d_t outputF)
{
	GLOBAL_ID_2D_MACRO
	LOCAL_ID_2D_MACRO
	SAMPLER_MACRO

	__local uchar l_data[4*(CLOSE_LOC_SIZE)*(CLOSE_LOC_SIZE)];

	l_data[l_idY * l_sizeX * 2 + l_idX] = read_imageui(input, sampler, (int2)(idX-CLOSE_LOC_SIZE/2, idY-CLOSE_LOC_SIZE/2)).x;
	l_data[l_idY * l_sizeX * 2 + l_idX + CLOSE_LOC_SIZE] = read_imageui(input, sampler, (int2)(idX + CLOSE_LOC_SIZE/2, idY - CLOSE_LOC_SIZE/2)).x;
	l_data[(l_idY + CLOSE_LOC_SIZE) * l_sizeX * 2 + l_idX] = read_imageui(input, sampler, (int2)(idX - CLOSE_LOC_SIZE/2, idY + CLOSE_LOC_SIZE/2)).x;
	l_data[(l_idY + CLOSE_LOC_SIZE) * l_sizeX * 2 + l_idX + CLOSE_LOC_SIZE] = read_imageui(input, sampler, (int2)(idX + CLOSE_LOC_SIZE/2, idY + CLOSE_LOC_SIZE/2)).x;

	barrier(CLK_LOCAL_MEM_FENCE);

	int sum = 0;
	for (int r = -CLOSE_LOC_RAD; r <= CLOSE_LOC_RAD; r++)
	{
		for (int c = -CLOSE_LOC_RAD; c <= CLOSE_LOC_RAD; c++)
		{
			sum += l_data[(l_idY+8+c) * l_sizeX * 2 + (l_idX+8+r)] > 0 ? 1 : 0;
		}
	}

	write_imageui(output, (int2)(idX, idY), sum == (2*CLOSE_LOC_RAD+1)*(2*CLOSE_LOC_RAD+1) ? 255 : 0);
	//write_imageui(outputF, (int2)(idX, idY), sum == (2*CLOSE_LOC_RAD+1)*(2*CLOSE_LOC_RAD+1) ? 255 : 0);
}

__kernel
void pupilDetect(__read_only image2d_t bBoxes, __read_only image2d_t luminance, __write_only image2d_t output, __read_only image2d_t lumSAT, __write_only image2d_t eye,
__read_only image2d_t skin, __read_only image2d_t mouth, __global uchar4* restrict sourceImage, __global CLDetectedObject* faceObject, __global int* faceID,
__global int* leftEyePixNum, __global int* rightEyePixNum)
{
	GLOBAL_ID_2D_MACRO
	SAMPLER_MACRO

	uchar bbox = read_imageui(bBoxes, sampler, (int2)(idX, idY)).x;
	uchar eyePix = 0;

	int _faceID = faceID[0];

	if(currIndex == 0)
	{
		leftEyePixNum[0] = 0;
		rightEyePixNum[0] = 0;
	}

	if (_faceID != -1)
	{
		CLDetectedObject currObj = faceObject[_faceID];

		float boxHeight = currObj.maxCornerY - currObj.minCornerY;

		if( idX >= currObj.minCornerX && idX <= currObj.maxCornerX && idY >= currObj.minCornerY + boxHeight * 0.15f && idY <= currObj.minCornerY + boxHeight * 0.4f)
		{
			int x = 20;
			int y = x/3;

			float black = (float)(getSatImg(lumSAT, sampler, idX - x/6, idY-y/2, x/3, y) / (float)((x/3)*y));
			float white1 = ((float)getSatImg(lumSAT, sampler, idX-x/3, idY-y/2, x/6, y) / ((x/6)*y) + (float)getSatImg(lumSAT, sampler, idX-x/2, idY-y/4, x/6, y/2) / (float)((x/6)*(y/2))) / 2.0f;
			float white2 = ((float)getSatImg(lumSAT, sampler, idX+x/3, idY-y/2, x/6, y) / ((x/6)*y) + (float)getSatImg(lumSAT, sampler, idX+x/2, idY-y/4, x/6, y/2) / (float)((x/6)*(y/2))) / 2.0f;

			float ratio1 = black/white1;
			float ratio2 = black/white2;

			if (ratio1 * ratio2 < 0.7f)
			{
				eyePix = 255;
			}
			//write_imageui(output, (int2)(idX, idY), 255);
		}
	}

	write_imageui(eye, (int2)(idX, idY), eyePix);
}

__kernel
void printClean(__global int2* detecting)
{
	uint currIndex = get_global_id(0);

	detecting[currIndex] = (int2)(-1, -1);
}


__kernel
void print(const int eyeW, const int eyeH, __global int2* detecting, __write_only image2d_t output)
{
	uint currIndex = get_global_id(0);

	int2 currState = detecting[currIndex];
	int2 prevState = detecting[max(((int)currIndex-1), 0)];

	int2 diff = currState != -1 ? currState - prevState : 0;


	int idX = min((int)(eyeW+currIndex/2), (int)(get_global_size(0)-1));


	if(currState.x == 1 || diff.x )
	{
		write_imageui(output, (int2)(idX, eyeH/3), (uint4)(255, 0, 0, 0));
		if(diff.x != 0)
		{
			for(int i=eyeH; i>eyeH/3; i--)
			{
				write_imageui(output, (int2)(idX, i), (uint4)(255, 0, 0, 0));
			}
		}
	}
	else if (currState.x == 0)
		write_imageui(output, (int2)(idX, eyeH), (uint4)(255, 0, 0, 0));

	if(currState.y == 1 || diff.y)
	{
		write_imageui(output, (int2)(idX, eyeH/3 + eyeH), (uint4)(255, 0, 0, 0));
		if(diff.y != 0)
		{
			for(int i=eyeH; i>eyeH/3; i--)
			{
				write_imageui(output, (int2)(idX, i+eyeH), (uint4)(255, 0, 0, 0));
			}
		}
	}
	else if (currState.y == 0)
		write_imageui(output, (int2)(idX, eyeH+eyeH), (uint4)(255, 0, 0, 0));

}

__kernel
void copyRectangle(__global uchar4* restrict sourceImage,  const int writeX, const int writeY, /*const int offsetX, const int offsetY, const int eyeWidth,*/ __global float4* eyeBBox, __write_only image2d_t output,
                   __write_only image2d_t leftEyeROI, __read_only image2d_t eye)
{
	GLOBAL_ID_2D_MACRO
	SAMPLER_MACRO

	int2 imgDim = get_image_dim(output);
	int4 _eyeBBox = convert_int4(eyeBBox[0]);
	const uint currReadIndex = (idY+_eyeBBox.y) * imgDim.x + (idX+_eyeBBox.x);

	uint4 in = convert_uint4(sourceImage[currReadIndex]);

	float4 RGB = convert_float4(in)/255.0f;
	uchar eyePix = read_imageui(eye, sampler, (int2)(idX+_eyeBBox.x, idY+_eyeBBox.y)).x;

	if( (_eyeBBox.z - _eyeBBox.x) < idX)
	{
		eyePix = 0;
		RGB = 0.0f;
	}

	write_imageui(output, (int2)(idX+writeX, idY+writeY), in);
	write_imageui(leftEyeROI, (int2)(idX, idY), eyePix*255);
}

//Face select
#define FACE_OBJECT_SIZE 256

__kernel
void getFaceId(const int workWidth, const int workHeight, __global CLDetectedObject* faceObject, __global int* faceID, __global int* histIndex)
{
	uint currIndex = get_global_id(0);
	uint lid = get_local_id(0);

	__local float l_area[FACE_OBJECT_SIZE];
	__local float maxArea;
	__local int _faceID;
	int posibbleFaceId = 0;

	CLDetectedObject currObj = faceObject[currIndex];

	float boxWidth  = currObj.maxCornerX - currObj.minCornerX;
	float boxHeight = currObj.maxCornerY - currObj.minCornerY;
	float area = boxWidth*boxHeight;

	if ( (boxWidth * boxHeight > (workWidth*workHeight) / 100.0f) && (boxWidth / boxHeight > 0.5f) && (boxWidth / boxHeight < 1.1f) )
		posibbleFaceId = 1;

	l_area[lid] = posibbleFaceId ? area : 0.0f;
	maxArea = 0.0f;
	_faceID = -1;
	histIndex[currIndex] = 0;

	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 128)
	{
		l_area[lid] = l_area[lid] > l_area[lid + 128] ? l_area[lid] : l_area[lid + 128];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 64)
	{
		l_area[lid] = l_area[lid] > l_area[lid + 64] ? l_area[lid] : l_area[lid + 64];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 32)
	{
		l_area[lid] = l_area[lid] > l_area[lid + 32] ? l_area[lid] : l_area[lid + 32];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 16)
	{
		l_area[lid] = l_area[lid] > l_area[lid + 16] ? l_area[lid] : l_area[lid + 16];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 8)
	{
		l_area[lid] = l_area[lid] > l_area[lid + 8] ? l_area[lid] : l_area[lid + 8];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 4)
	{
		l_area[lid] = l_area[lid] > l_area[lid + 4] ? l_area[lid] : l_area[lid + 4];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 2)
	{
		l_area[lid] = l_area[lid] > l_area[lid + 2] ? l_area[lid] : l_area[lid + 2];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid == 0)
	{
		maxArea = l_area[0] > l_area[1] ? l_area[0] : l_area[1];
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	if( fabs(maxArea - area) < 0.0001f && area != 0.0f)
		_faceID = currIndex;

	barrier(CLK_LOCAL_MEM_FENCE);

	faceID[0] = _faceID;
}

__kernel
void getMouthId(const int currIter, const int workWidth, const int workHeight, __global float2* preMouthCenter, __global CLDetectedObject* mouthObject, __global int* mouthID)
{
	uint currIndex = get_global_id(0);
	uint lid = get_local_id(0);

	__local float l_w[FACE_OBJECT_SIZE];
	__local float maxW;
	__local int _mouthID;

	l_w[lid] = 0.0f;
	maxW = 0.0f;
	_mouthID = -1;

	float2 pre = preMouthCenter[0];
	float w = 0.0f;
	CLDetectedObject currObj = mouthObject[currIndex];

	if(currObj.pointsNum != 0)
	{
		float boxWidth  = currObj.maxCornerX - currObj.minCornerX;
		float2 mid = (float2)((currObj.maxCornerX + currObj.minCornerX) / 2.0f, (currObj.maxCornerY + currObj.minCornerY) / 2.0f);
		float2 dist_tmp = (mid - pre)*(mid - pre);
		float dist = sqrt(dist_tmp.x + dist_tmp.y);

		if(currIter == 0)
			dist = 1.0f;

		w = boxWidth * (1.0f / dist);
		l_w[lid] = w;
	}

	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 128)
	{
		l_w[lid] = l_w[lid] > l_w[lid + 128] ? l_w[lid] : l_w[lid + 128];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 64)
	{
		l_w[lid] = l_w[lid] > l_w[lid + 64] ? l_w[lid] : l_w[lid + 64];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 32)
	{
		l_w[lid] = l_w[lid] > l_w[lid + 32] ? l_w[lid] : l_w[lid + 32];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 16)
	{
		l_w[lid] = l_w[lid] > l_w[lid + 16] ? l_w[lid] : l_w[lid + 16];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 8)
	{
		l_w[lid] = l_w[lid] > l_w[lid + 8] ? l_w[lid] : l_w[lid + 8];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 4)
	{
		l_w[lid] = l_w[lid] > l_w[lid + 4] ? l_w[lid] : l_w[lid + 4];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid < 2)
	{
		l_w[lid] = l_w[lid] > l_w[lid + 2] ? l_w[lid] : l_w[lid + 2];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if (lid == 0)
	{
		maxW = l_w[0] > l_w[1] ? l_w[0] : l_w[1];
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	if ( fabs(maxW - w) < 0.0001f && maxW != 0.0f)
		_mouthID = currIndex;

	barrier(CLK_LOCAL_MEM_FENCE);

	mouthID[0] = _mouthID;
}

__kernel
void drawBoundary(__global CLDetectedObject* faceObject, __global int* faceID, __write_only image2d_t output)
{
	GLOBAL_ID_2D_MACRO

	int _faceID = faceID[0];

	if (_faceID != -1)
	{
		CLDetectedObject currObj = faceObject[_faceID];

		if( ((idX == currObj.minCornerX || idX == currObj.maxCornerX) && idY >= currObj.minCornerY && idY <= currObj.maxCornerY) ||
		    ((idY == currObj.minCornerY || idY == currObj.maxCornerY) && idX >= currObj.minCornerX && idX <= currObj.maxCornerX)
		  )
		{
			write_imageui(output, (int2)(idX, idY), (uint4)(255, 0, 0, 0));
		}
	}
}

__kernel
void mouthRecalc(__global CLDetectedObject* faceObject, __global int* faceID, __global CLDetectedObject* mouthObject, __global int* mouthID, __global float2* preMouthCenter,
				 __global float4* leftEyeBBox, __global float4* rightEyeBBox, const int eyeW, const int eyeH)
{
	int _faceID = faceID[0];
	int _mouthID = mouthID[0];

	if(_mouthID != -1 && _faceID != -1)
	{
		CLDetectedObject mouthObj = mouthObject[_mouthID];
		CLDetectedObject faceObj = faceObject[_faceID];

		float faceWidth  = faceObj.maxCornerX - faceObj.minCornerX;
		float mouthWidth  = mouthObj.maxCornerX - mouthObj.minCornerX;

		if (mouthWidth < faceWidth/4.0f)
		{
			float2 center = (float2)((mouthObj.maxCornerX + mouthObj.minCornerX) / 2.0f, (mouthObj.maxCornerY + mouthObj.minCornerY) / 2.0f);
			mouthObj.minCornerX = center.x - faceWidth/8.0f;
			mouthObj.maxCornerX = center.x + faceWidth/8.0f;
		}

		preMouthCenter[0] = (float2)((mouthObj.maxCornerX + mouthObj.minCornerX) / 2.0f, (mouthObj.maxCornerY + mouthObj.minCornerY) / 2.0f);
		mouthObject[_mouthID] = mouthObj;

		//Eye ROIs
		float2 leftEye, rightEye;
		leftEye.x = mouthObj.minCornerX;
		leftEye.y = (mouthObj.maxCornerY + mouthObj.minCornerY) / 2.0f;
		rightEye.x = mouthObj.maxCornerX;
		rightEye.y = (mouthObj.maxCornerY + mouthObj.minCornerY) / 2.0f;

		leftEye.y -= (leftEye.y -  faceObj.minCornerY)*0.5f;
		rightEye.y -= (rightEye.y -  faceObj.minCornerY)*0.5f;

		leftEye.x -= faceWidth / 10.0f;
		rightEye.x += faceWidth / 10.0f;

		float4 _leftEyeBBox = (float4)(leftEye.x - eyeW/2.0f, leftEye.y - eyeH/2.0f, leftEye.x + eyeW/2.0f, leftEye.y + eyeH/2.0f);
		_leftEyeBBox.x = max(_leftEyeBBox.x, faceObj.minCornerX + 10.0f);

		float4 _rightEyeBBox = (float4)(rightEye.x - eyeW/2.0f, rightEye.y - eyeH/2.0f, rightEye.x + eyeW/2.0f, rightEye.y + eyeH/2.0f);
		_rightEyeBBox.z = min(_rightEyeBBox.z, faceObj.maxCornerX - 10.0f);

		leftEyeBBox[0] = _leftEyeBBox;
		rightEyeBBox[0] = _rightEyeBBox;
	}
}

__kernel
void countEyePix (__read_only image2d_t leftEyeROI, __read_only image2d_t rightEyeROI, __global int* leftEyePixNum, __global int* rightEyePixNum)
{
	GLOBAL_ID_2D_MACRO
	SAMPLER_MACRO

	uchar lEye = read_imageui(leftEyeROI, sampler, (int2)(idX, idY)).x;
	uchar rEye = read_imageui(rightEyeROI, sampler, (int2)(idX, idY)).x;

	if (lEye > 0)
		atomic_inc(leftEyePixNum);
	if (rEye > 0)
		atomic_inc(rightEyePixNum);
}

__kernel
void drawEyeBoundary (const int currIter, __global int* leftEyePixNum, __global int* rightEyePixNum, __global float4* leftEyeBBox, __global float4* rightEyeBBox, __write_only image2d_t output, __global int2* detecting)
{
	GLOBAL_ID_2D_MACRO

	int leftOpen = 255;
	int rightOpen = 255;
	int4 lEye = convert_int4(leftEyeBBox[0]);
	int4 rEye = convert_int4(rightEyeBBox[0]);

	if (leftEyePixNum[0] < 100 && rightEyePixNum[0] < 100)
	{
		leftOpen = 0;
		rightOpen = 0;
	}

	if( ((idX == lEye.x || idX == lEye.z) && idY >= lEye.y && idY <= lEye.w) ||
		((idY == lEye.y || idY == lEye.w) && idX >= lEye.x && idX <= lEye.z)
	  )
	{
		write_imageui(output, (int2)(idX, idY), (uint4)(255-leftOpen, leftOpen, 0, 0));
	}

	if( ((idX == rEye.x || idX == rEye.z) && idY >= rEye.y && idY <= rEye.w) ||
		((idY == rEye.y || idY == rEye.w) && idX >= rEye.x && idX <= rEye.z)
	  )
	{
		write_imageui(output, (int2)(idX, idY), (uint4)(255-leftOpen, leftOpen, 0, 0));
	}

	if(currIndex == 0)
	{
		detecting[currIter] = (int2)(leftOpen, rightOpen)/255;
	}
}

__kernel
void copyImage (__read_only image2d_t input, __write_only image2d_t output)
{
	GLOBAL_ID_2D_MACRO
	SAMPLER_MACRO

	uint4 in = read_imageui(input, sampler, (int2)(idX, idY));
	write_imagef(output, (int2)(idX, idY), convert_float4(in)/255.0f);
}

#define CCL_LOCAL_SIZE 16
__constant int neighborIndexX[4] = {1, -1, 0, 0};
__constant int neighborIndexY[4] = {0, 0, -1, 1};

__kernel
void localCCL(__read_only image2d_t input, __write_only image2d_t outputF, __global unsigned int* boarderPairs, __global float* result,
              __global unsigned int* equals, __global unsigned int* equalsTmp, __global unsigned int* labels, __global unsigned int* reLabels)
{
	GLOBAL_ID_2D_MACRO
	LOCAL_ID_2D_MACRO
	SAMPLER_MACRO

	__local uint l_index[CCL_LOCAL_SIZE * CCL_LOCAL_SIZE];
	__local uchar l_data[CCL_LOCAL_SIZE * CCL_LOCAL_SIZE];
	__local uint count;
	uint curr, neighbor;

	l_index[currLIndex] = 0;
	barrier(CLK_LOCAL_MEM_FENCE);

	l_index[currLIndex] = currIndex;
	l_data[currLIndex] = read_imageui(input, sampler, (int2)(idX, idY)).x;
	//l_data[currLIndex] = (idX % 8) / 4 == 0 && (idY % 8) / 4 == 0 ? 255 : 0;
	barrier(CLK_LOCAL_MEM_FENCE);

	//horizontal first row
	if (currLIndex == 0)
	{
		for (int i=1; i<CCL_LOCAL_SIZE; i++)
		{
			if(l_data[l_idY*l_sizeX + i] < 0 && l_data[l_idY*l_sizeX + i-1] < 0)
			{
				l_index[l_idY*l_sizeX + i] = l_index[l_idY*l_sizeX + i-1];
			}
		}
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	//vertical all column
	if (currLIndex < CCL_LOCAL_SIZE)
	{
		for (int i=1; i<CCL_LOCAL_SIZE; i++)
		{
			if(l_data[i*l_sizeX + l_idX] < 0 && l_data[(i-1)*l_sizeX + l_idX] < 0)
			{
				l_index[i*l_sizeX + l_idX] = l_index[(i-1)*l_sizeX + l_idX];
			}
		}
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	//water flow
	do
	{
		barrier(CLK_LOCAL_MEM_FENCE);
		count = 0;

		for(int i=0; i<4; i++)
		{
			uint neighborIndex = clamp(l_idY+neighborIndexY[i], (uint)0, (uint)CCL_LOCAL_SIZE-1) * l_sizeX + clamp(l_idX+neighborIndexX[i], (uint)0, (uint)CCL_LOCAL_SIZE-1);

			curr = l_index[currLIndex];
			neighbor = l_index[neighborIndex];
			barrier(CLK_LOCAL_MEM_FENCE);

			if(neighbor < curr && (l_data[currLIndex] > 0 && l_data[neighborIndex] > 0))
			{
				l_index[currLIndex] = neighbor;
				atomic_inc(&count);
			}
			barrier(CLK_LOCAL_MEM_FENCE);
		}
	} while(count);

	if(l_data[currLIndex] == 0 || idX == 0 || idY == 0)
		l_index[currLIndex] = UINT_MAX;

	barrier(CLK_LOCAL_MEM_FENCE);

	//save boarder pairs
	if(l_idX % CCL_LOCAL_SIZE == 0)
	{
		boarderPairs[ (g_idY*CCL_LOCAL_SIZE+l_idY)*(sizeX/CCL_LOCAL_SIZE*2) + 2*g_idX + 0 ] = l_index[l_idY*l_sizeX + 0];
		boarderPairs[ (g_idY*CCL_LOCAL_SIZE+l_idY)*(sizeX/CCL_LOCAL_SIZE*2) + 2*g_idX + 1 ] = l_index[l_idY*l_sizeX + CCL_LOCAL_SIZE-1];
	}

	if(l_idY % CCL_LOCAL_SIZE == 0)
	{
		boarderPairs[ sizeX*sizeY/CCL_LOCAL_SIZE*2 + (g_idX*CCL_LOCAL_SIZE+l_idX)*(sizeY/CCL_LOCAL_SIZE*2) + 2*g_idY + 0 ] = l_index[0*l_sizeX + l_idX];
		boarderPairs[ sizeX*sizeY/CCL_LOCAL_SIZE*2 + (g_idX*CCL_LOCAL_SIZE+l_idX)*(sizeY/CCL_LOCAL_SIZE*2) + 2*g_idY + 1 ] = l_index[(CCL_LOCAL_SIZE-1)*l_sizeX + l_idX];
	}

	equals[currIndex] = equalsTmp[currIndex] = currIndex;
	labels[currIndex] = l_index[currLIndex];

	float4 color = (float4)(l_index[currLIndex]%5 / 4.0f, l_index[currLIndex]%7 / 6.0f, l_index[currLIndex]%11 / 10.0f, 0.0f );

	result[currIndex] = l_index[currLIndex];
	reLabels[currIndex] = 0;
	//write_imageui(outputF, (int2)(idX, idY), convert_uint4(color));
	//write_imageui(outputF, (int2)(idX, idY), 0);
}

__kernel
void CCLNull(__global unsigned int* labelUpdate)
{
	labelUpdate[0] = 0;
}

__kernel
void equalLabels(__global unsigned int* boarderPairs, __write_only image2d_t outputF, __global unsigned int* equals, __global unsigned int* equalsTmp, __global unsigned int* labelUpdate, const int iter)
{
	uint currIndex = get_global_id(0);
	uint lid = get_local_id(0);

	__local uchar l_data[256];

	uint labelA = boarderPairs[(int)min((int)(2*currIndex+0 + 1), (int)(2*get_global_size(0)-1))];
	uint labelB = boarderPairs[(int)min((int)(2*currIndex+1 + 1), (int)(2*get_global_size(0)-1))];

	if( labelB != UINT_MAX && labelA != UINT_MAX)
	{
		uint labelMin = min(equals[labelA], equals[labelB]);

		uint prevLabelB = atomic_min(&equalsTmp[labelB], labelMin);
		uint prevLabelA = atomic_min(&equalsTmp[labelA], labelMin);
		l_data[lid] = (prevLabelB <= labelMin) && (prevLabelA <= labelMin) ? 0 : 1;
	}
	else
	{
		l_data[lid] = 0;
	}

	if(iter == 0)
	{
		barrier(CLK_LOCAL_MEM_FENCE);
		if (lid < 128)
		{
			l_data[lid] += l_data[lid + 128];
		}
		barrier(CLK_LOCAL_MEM_FENCE);
		if (lid < 64)
		{
			l_data[lid] += l_data[lid + 64];
		}
		barrier(CLK_LOCAL_MEM_FENCE);
		if (lid < 32)
		{
			l_data[lid] += l_data[lid + 32];
		}
		barrier(CLK_LOCAL_MEM_FENCE);
		if (lid < 16)
		{
			l_data[lid] += l_data[lid + 16];
		}
		barrier(CLK_LOCAL_MEM_FENCE);
		if (lid < 8)
		{
			l_data[lid] += l_data[lid + 8];
		}
		barrier(CLK_LOCAL_MEM_FENCE);
		if (lid < 4)
		{
			l_data[lid] += l_data[lid + 4];
		}
		barrier(CLK_LOCAL_MEM_FENCE);
		if (lid < 2)
		{
			l_data[lid] += l_data[lid + 2];
		}
		barrier(CLK_LOCAL_MEM_FENCE);
		if (lid == 0)
		{
			atomic_add(labelUpdate, l_data[0] + l_data[1] != 0 ? 1 : 0);
		}


	}
}

__kernel
void CCLCheck(__read_only image2d_t input, __write_only image2d_t outputF, __global unsigned int* equals, __global unsigned int* equalsB, __global unsigned int* labels)
{
	GLOBAL_ID_2D_MACRO
	SAMPLER_MACRO

	uint indexA = labels[currIndex];
	uint indexB = equals[indexA];

	if(indexA != UINT_MAX)
	{
		while(indexA != indexB)
		{
			indexA = indexB;
			indexB = equals[indexA];
		}

		float4 color = (float4)(indexB%5 / 4.0f, indexB%7 / 6.0f, indexB%11 / 10.0f, 0.0f );

		//write_imageui(outputF, (int2)(idX, idY), convert_uint4(color));
		equalsB[currIndex] = indexB;
	}
}

__kernel
void CCLRelabel(__global unsigned int* labels, __global unsigned int* equals, __global unsigned int* relabels, __write_only image2d_t outputF, __global unsigned int* gAtomic)
{
	GLOBAL_ID_2D_MACRO

	uint label = labels[currIndex];

	if(label != UINT_MAX)
	{
		label = equals[label];
		relabels[label] = 1;
	}

	if(currIndex == 0)
		gAtomic[0] = 0;
}

__kernel
void CCLRelabelStep2(__global unsigned int* labels, __global unsigned int* equals, __global unsigned int* relabels, __write_only image2d_t outputF, __global unsigned int* gAtomic)
{
	GLOBAL_ID_2D_MACRO

	uint reLabel = relabels[currIndex];

	if (reLabel)
	{
		relabels[currIndex] = atomic_inc(gAtomic);
	}
}

__kernel
void objectInit(__global CLDetectedObject* detectedObject)
{
	uint currIndex = get_global_id(0);
	CLDetectedObject currObj;

	currObj.minCornerX = UINT_MAX;
	currObj.minCornerY = UINT_MAX;
	currObj.maxCornerX = 0;
	currObj.maxCornerY = 0;
	currObj.pointsNum = 0;
	currObj.width = 0;
    currObj.height = 0;

	detectedObject[currIndex] = currObj;
}

__kernel
void objectCalc(__global unsigned int* labels, __global unsigned int* equals, __global unsigned int* relabels, __write_only image2d_t outputF, __global CLDetectedObject* faceObjects)
{
	GLOBAL_ID_2D_MACRO

	uint label = labels[currIndex];

	if(label != UINT_MAX)
	{
		label = equals[label];
		uint reLabel = relabels[label];

		atomic_min(&(faceObjects[reLabel].minCornerX), idX);
		atomic_min(&(faceObjects[reLabel].minCornerY), idY);
		atomic_max(&(faceObjects[reLabel].maxCornerX), idX);
		atomic_max(&(faceObjects[reLabel].maxCornerY), idY);

		atomic_inc(&(faceObjects[reLabel].pointsNum));
	}

}

__kernel
void CCLShow(__global unsigned int* labels, __global unsigned int* equals, __global unsigned int* relabels, __write_only image2d_t outputF, __global unsigned int* gAtomic)
{
	GLOBAL_ID_2D_MACRO

	uint label = labels[currIndex];

	if(label != UINT_MAX)
	{
		label = equals[label];
		uint reLabel = relabels[label];

		//write_imagef(outputF, (int2)(idX, idY), reLabel/(float)(gAtomic[0]));
	}
}




// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
