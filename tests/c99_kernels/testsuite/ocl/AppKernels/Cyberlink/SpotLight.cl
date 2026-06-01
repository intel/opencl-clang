// 2D iteration
__kernel void SpotLight_RGB(__global const uchar4* src, __global uchar4* dst, int width, int height,
			   int centerX,	int centerY, int sqrWidth, int sqrHeight,
		  	   int nLengthUV, int nThreUV, int nThreL, int LY,
			   int shiftU, int shiftV, float scaleUV, int depth, __constant float* Table,
                           unsigned char getAlphaType)
{
	//int index = get_global_id(0);

	uchar4 tempSrc;
	uchar4 tempDst;

	int tx = get_global_id(0);
	int ty = get_global_id(1);
	int index = ty*width+tx;

	tempSrc = src[index];

	//uint ty = index / width;
	//uint tx = index % width;


	int newY = ty - centerY;
	int newX = tx - centerX;
	float t = (float)(newX * newX) / (float)sqrWidth + (float)(newY * newY) / (float)sqrHeight;

	float Y, U, V;

	uint uiY = 0.257f * (float)tempSrc.z + 0.504f * (float)tempSrc.y + 0.098f * (float)tempSrc.x + 16.0f;
	uint uiU = -0.148f * (float)tempSrc.z - 0.291f * (float)tempSrc.y + 0.439f * (float)tempSrc.x + 128.0f;
	uint uiV = 0.439f * (float)tempSrc.z - 0.368f * (float)tempSrc.y - 0.071f * (float)tempSrc.x + 128.0f;

	if(t < 1.0f)
	{
		if(nLengthUV > nThreUV  && LY > nThreL)
		{
			Y = Table[uiY];
			U = uiU * scaleUV + shiftU;
			V = uiV * scaleUV + shiftV;

			U = uiU * 0.5f + U * 0.5f;
			V = uiV * 0.5f + V * 0.5f;

			uiV = max(min(V, 255.0f), 0.0f);
			uiU = max(min(U, 255.0f), 0.0f);
			uiY = Y;
		}
		else
		{
			uiY = (uint)Table[uiY];
		}
	}
	else if(t < depth)
	{
		if(nLengthUV > nThreUV  && LY > nThreL)
		{
			float sat = 1.0f - (t - 1.0f) / (float)depth;
			Y = uiY + (Table[uiY] - uiY) * sat;

			sat = sat * 0.5f;

			U = uiU * scaleUV + shiftU;
			V = uiV * scaleUV + shiftV;

			U = uiU *(1-sat)  + U * sat;
			V = uiV *(1-sat)  + V * sat ;

			uiV = max(min(V, 255.0f), 0.0f);
			uiU = max(min(U, 255.0f), 0.0f);
			uiY = max(min(Y, 255.0f), 0.0f);
		}
		else
		{
			float sat = 1.0f - (t - 1.0f) / (float)depth;
			Y = uiY + (Table[uiY] - uiY) * sat;
			uiY = max(min(Y, 255.0f), 0.0f);
		}
	}

	tempDst.z = max(min((int)(1.164f * (float)((int)uiY - 16) + 1.596f * (float)((int)uiV - 128)), 255), 0);
	tempDst.y = max(min((int)(1.164f * (float)((int)uiY - 16) - 0.391f * (float)((int)uiU - 128) - 0.813f * (float)((int)uiV - 128)), 255), 0);
	tempDst.x = max(min((int)(1.164f * (float)((int)uiY - 16) + 2.018f * (float)((int)uiU - 128)), 255), 0);

	if(getAlphaType == 1)
	{
		tempDst.w = tempSrc.w;
	}
	else if(getAlphaType == 2)
	{
		tempDst.w = 255;
	}

	dst[index] = tempDst;

}

__kernel void SpotLight_YUV(__global const uchar4* src, __global uchar4* dst, int width, int height,
			   int centerX,	int centerY, int sqrWidth, int sqrHeight,
		  	   int nLengthUV, int nThreUV, int nThreL, int LY,
			   int shiftU, int shiftV, float scaleUV, int depth, __constant float* Table,
                           unsigned char getAlphaType)
{
//	int index = get_global_id(0);

	int tx = get_global_id(0);
	int ty = get_global_id(1);
	int index = ty*width+tx;

	uchar4 tempSrc;
	uchar4 tempDst;

	tempSrc = src[index];

//	uint ty = index / width;
//	uint tx = index % width;

	int newY = ty - centerY;
	int newX = tx - centerX;
	float t = (float)(newX * newX) / (float)sqrWidth + (float)(newY * newY) / (float)sqrHeight;

	float Y, U, V;

	uint uiY = tempSrc.z;
	uint uiU = tempSrc.y;
	uint uiV = tempSrc.x;

	if(t < 1.0f)
	{
		if(nLengthUV > nThreUV  && LY > nThreL)
		{
			Y = Table[uiY];
			U = uiU * scaleUV + shiftU;
			V = uiV * scaleUV + shiftV;

			U = uiU * 0.5f + U * 0.5f;
			V = uiV * 0.5f + V * 0.5f;

			uiV = max(min(V, 255.0f), 0.0f);
			uiU = max(min(U, 255.0f), 0.0f);
			uiY = Y;
		}
		else
		{
			uiY = (uint)Table[uiY];
		}
	}
	else if(t < depth)
	{
		if(nLengthUV > nThreUV  && LY > nThreL)
		{
			float sat = 1.0f - (t - 1.0f) / (float)depth;
			Y = uiY + (Table[uiY] - uiY) * sat;

			sat = sat * 0.5f;

			U = uiU * scaleUV + shiftU;
			V = uiV * scaleUV + shiftV;

			U = uiU *(1-sat)  + U * sat;
			V = uiV *(1-sat)  + V * sat ;

			uiV = max(min(V, 255.0f), 0.0f);
			uiU = max(min(U, 255.0f), 0.0f);
			uiY = max(min(Y, 255.0f), 0.0f);
		}
		else
		{
			float sat = 1.0f - (t - 1.0f) / (float)depth;
			Y = uiY + (Table[uiY] - uiY) * sat;
			uiY = max(min(Y, 255.0f), 0.0f);
		}
	}

	tempDst.z = uiY;
	tempDst.y = uiU;
	tempDst.x = uiV;

	if(getAlphaType == 1)
	{
		tempDst.w = tempSrc.w;
	}
	else if(getAlphaType == 2)
	{
		tempDst.w = 255;
	}

	dst[index] = tempDst;
}

#if 0
// 1D iteration
__kernel void SpotLight_RGB(__global const uchar4* src, __global uchar4* dst, int width, int height,
			   int centerX,	int centerY, int sqrWidth, int sqrHeight,
		  	   int nLengthUV, int nThreUV, int nThreL, int LY,
			   int shiftU, int shiftV, float scaleUV, int depth, __constant float* Table,
                           unsigned char getAlphaType)
{
	int index = get_global_id(0);

	uchar4 tempSrc;
	uchar4 tempDst;

	tempSrc = src[index];

	uint ty = index / width;
	uint tx = index % width;

	int newY = ty - centerY;
	int newX = tx - centerX;
	float t = (float)(newX * newX) / (float)sqrWidth + (float)(newY * newY) / (float)sqrHeight;

	float Y, U, V;

	uint uiY = 0.257f * (float)tempSrc.z + 0.504f * (float)tempSrc.y + 0.098f * (float)tempSrc.x + 16.0f;
	uint uiU = -0.148f * (float)tempSrc.z - 0.291f * (float)tempSrc.y + 0.439f * (float)tempSrc.x + 128.0f;
	uint uiV = 0.439f * (float)tempSrc.z - 0.368f * (float)tempSrc.y - 0.071f * (float)tempSrc.x + 128.0f;

	if(t < 1.0f)
	{
		if(nLengthUV > nThreUV  && LY > nThreL)
		{
			Y = Table[uiY];
			U = uiU * scaleUV + shiftU;
			V = uiV * scaleUV + shiftV;

			U = uiU * 0.5f + U * 0.5f;
			V = uiV * 0.5f + V * 0.5f;

			uiV = max(min(V, 255.0f), 0.0f);
			uiU = max(min(U, 255.0f), 0.0f);
			uiY = Y;
		}
		else
		{
			uiY = (uint)Table[uiY];
		}
	}
	else if(t < depth)
	{
		if(nLengthUV > nThreUV  && LY > nThreL)
		{
			float sat = 1.0f - (t - 1.0f) / (float)depth;
			Y = uiY + (Table[uiY] - uiY) * sat;

			sat = sat * 0.5f;

			U = uiU * scaleUV + shiftU;
			V = uiV * scaleUV + shiftV;

			U = uiU *(1-sat)  + U * sat;
			V = uiV *(1-sat)  + V * sat ;

			uiV = max(min(V, 255.0f), 0.0f);
			uiU = max(min(U, 255.0f), 0.0f);
			uiY = max(min(Y, 255.0f), 0.0f);
		}
		else
		{
			float sat = 1.0f - (t - 1.0f) / (float)depth;
			Y = uiY + (Table[uiY] - uiY) * sat;
			uiY = max(min(Y, 255.0f), 0.0f);
		}
	}

	tempDst.z = max(min((int)(1.164f * (float)((int)uiY - 16) + 1.596f * (float)((int)uiV - 128)), 255), 0);
	tempDst.y = max(min((int)(1.164f * (float)((int)uiY - 16) - 0.391f * (float)((int)uiU - 128) - 0.813f * (float)((int)uiV - 128)), 255), 0);
	tempDst.x = max(min((int)(1.164f * (float)((int)uiY - 16) + 2.018f * (float)((int)uiU - 128)), 255), 0);

	if(getAlphaType == 1)
	{
		tempDst.w = tempSrc.w;
	}
	else if(getAlphaType == 2)
	{
		tempDst.w = 255;
	}

	dst[index] = tempDst;

}

__kernel void SpotLight_YUV(__global const uchar4* src, __global uchar4* dst, int width, int height,
			   int centerX,	int centerY, int sqrWidth, int sqrHeight,
		  	   int nLengthUV, int nThreUV, int nThreL, int LY,
			   int shiftU, int shiftV, float scaleUV, int depth, __constant float* Table,
                           unsigned char getAlphaType)
{
	int index = get_global_id(0);

	uchar4 tempSrc;
	uchar4 tempDst;

	tempSrc = src[index];

	uint ty = index / width;
	uint tx = index % width;

	int newY = ty - centerY;
	int newX = tx - centerX;
	float t = (float)(newX * newX) / (float)sqrWidth + (float)(newY * newY) / (float)sqrHeight;

	float Y, U, V;

	uint uiY = tempSrc.z;
	uint uiU = tempSrc.y;
	uint uiV = tempSrc.x;

	if(t < 1.0f)
	{
		if(nLengthUV > nThreUV  && LY > nThreL)
		{
			Y = Table[uiY];
			U = uiU * scaleUV + shiftU;
			V = uiV * scaleUV + shiftV;

			U = uiU * 0.5f + U * 0.5f;
			V = uiV * 0.5f + V * 0.5f;

			uiV = max(min(V, 255.0f), 0.0f);
			uiU = max(min(U, 255.0f), 0.0f);
			uiY = Y;
		}
		else
		{
			uiY = (uint)Table[uiY];
		}
	}
	else if(t < depth)
	{
		if(nLengthUV > nThreUV  && LY > nThreL)
		{
			float sat = 1.0f - (t - 1.0f) / (float)depth;
			Y = uiY + (Table[uiY] - uiY) * sat;

			sat = sat * 0.5f;

			U = uiU * scaleUV + shiftU;
			V = uiV * scaleUV + shiftV;

			U = uiU *(1-sat)  + U * sat;
			V = uiV *(1-sat)  + V * sat ;

			uiV = max(min(V, 255.0f), 0.0f);
			uiU = max(min(U, 255.0f), 0.0f);
			uiY = max(min(Y, 255.0f), 0.0f);
		}
		else
		{
			float sat = 1.0f - (t - 1.0f) / (float)depth;
			Y = uiY + (Table[uiY] - uiY) * sat;
			uiY = max(min(Y, 255.0f), 0.0f);
		}
	}

	tempDst.z = uiY;
	tempDst.y = uiU;
	tempDst.x = uiV;

	if(getAlphaType == 1)
	{
		tempDst.w = tempSrc.w;
	}
	else if(getAlphaType == 2)
	{
		tempDst.w = 255;
	}

	dst[index] = tempDst;
}

#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
