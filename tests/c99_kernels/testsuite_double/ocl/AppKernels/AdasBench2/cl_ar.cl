
#line 3 "ar.cl"

kernel void YUV2RGB2LAB(const global uchar* restrict Ogg_Y, const global uchar* restrict Ogg_u, const global uchar* restrict Ogg_v,
						const int stride_Y, const int stride_u, const int stride_v, const int hdec, const int vdec,
						write_only image2d_t rgb, global float4* restrict LAB)
{
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);

	const int sizeX = get_global_size(0);

	const int id = (idY * sizeX) + idX;

	float4 RGB;
	RGB.x = (1904000 * Ogg_Y[idX + idY*stride_Y] + 2609823 * Ogg_v[idY/2 * stride_v + idX/2] - 363703744) / 1635200;
	RGB.y = (3827562 * Ogg_Y[idX + idY*stride_Y] - 1287801 * Ogg_u[idY/2 * stride_u + idX/2] - 2672387 * Ogg_v[idY/2 * stride_v + idX/2] + 447306710) / 3287200;
	RGB.z = (952000  * Ogg_Y[idX + idY*stride_Y] + 1649289 * Ogg_u[idY/2 * stride_u + idX/2] - 225932192) / 817600;

	RGB.x = clamp(RGB.x, 0.0f, 255.0f);
	RGB.y = clamp(RGB.y, 0.0f, 255.0f);
	RGB.z = clamp(RGB.z, 0.0f, 255.0f);

	RGB.x = RGB.x / 255.0f;
	RGB.y = RGB.y / 255.0f;
	RGB.z = RGB.z / 255.0f;
	RGB.w = 1.0f;

	write_imagef(rgb, (int2)(idX,idY), RGB);

	float XYZ[3];
	float4 Lab;

	RGB.x = (RGB.x > 0.04045f) ? powr((RGB.x + 0.055f) / 1.055f, 2.4f) : RGB.x / 12.92f;
	RGB.y = (RGB.y > 0.04045f) ? powr((RGB.y + 0.055f) / 1.055f, 2.4f) : RGB.y / 12.92f;
	RGB.z = (RGB.z > 0.04045f) ? powr((RGB.z + 0.055f) / 1.055f, 2.4f) : RGB.z / 12.92f;

	XYZ[0] = (RGB.x * 0.4124f + RGB.y * 0.3576f + RGB.z * 0.1805f) / 0.95047f;
	XYZ[1] = (RGB.x * 0.2126f + RGB.y * 0.7152f + RGB.z * 0.0722f) / 1.00000f;
	XYZ[2] = (RGB.x * 0.0193f + RGB.y * 0.1192f + RGB.z * 0.9505f) / 1.08883f;

	float n = 1.0f / 3.0f;
	XYZ[0] = (XYZ[0] > 0.008856f) ? powr(XYZ[0], n) : (7.787f * XYZ[0]) + 16.0f / 116.0f;
	XYZ[1] = (XYZ[1] > 0.008856f) ? powr(XYZ[1], n) : (7.787f * XYZ[1]) + 16.0f / 116.0f;
	XYZ[2] = (XYZ[2] > 0.008856f) ? powr(XYZ[2], n) : (7.787f * XYZ[2]) + 16.0f / 116.0f;

	Lab.x = (116.0f * XYZ[1]) - 16.0f;
	Lab.y = 500.0f * (XYZ[0] - XYZ[1]);
	Lab.z = 200.0f * (XYZ[1] - XYZ[2]);

	//Lab.xyz = (Lab.x*(Lab.y+Lab.z)+5000)/10000;
	LAB[id] = Lab;
	//write_imagef(rgb, (int2)(idX,idY), Lab);
}

void AtomicAdd(volatile __global float *val, const float delta)
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

inline void AtomicMax(volatile __global float *source, const float operand)
{
    union
	{
        unsigned int intVal;
        float floatVal;
    } newVal;

    union
	{
        unsigned int intVal;
        float floatVal;
    } prevVal;

    do
	{
        prevVal.floatVal = *source;
        newVal.floatVal = max(prevVal.floatVal,operand);
    }
	while (atomic_cmpxchg((volatile __global unsigned int *)source, prevVal.intVal, newVal.intVal) != prevVal.intVal);
}

inline void AtomicMin(volatile __global float *source, const float operand)
{
    union
	{
        unsigned int intVal;
        float floatVal;
    } newVal;

    union
	{
        unsigned int intVal;
        float floatVal;
    } prevVal;

    do
	{
        prevVal.floatVal = *source;
        newVal.floatVal = min(prevVal.floatVal,operand);
    }
	while (atomic_cmpxchg((volatile __global unsigned int *)source, prevVal.intVal, newVal.intVal) != prevVal.intVal);
}

inline void AtomicMaxLocal(volatile __local float *source, const float operand)
{
    union
	{
        unsigned int intVal;
        float floatVal;
    } newVal;

    union
	{
        unsigned int intVal;
        float floatVal;
    } prevVal;

    do
	{
        prevVal.floatVal = *source;
        newVal.floatVal = max(prevVal.floatVal,operand);
    }
	while (atomic_cmpxchg((volatile __local unsigned int *)source, prevVal.intVal, newVal.intVal) != prevVal.intVal);
}

inline void AtomicMinLocal(volatile __local float *source, const float operand)
{
    union
	{
        unsigned int intVal;
        float floatVal;
    } newVal;

    union
	{
        unsigned int intVal;
        float floatVal;
    } prevVal;

    do
	{
        prevVal.floatVal = *source;
        newVal.floatVal = min(prevVal.floatVal,operand);
    }
	while (atomic_cmpxchg((volatile __local unsigned int *)source, prevVal.intVal, newVal.intVal) != prevVal.intVal);
}

kernel void SepareteShinyParts(const global float4* restrict LAB, global float* restrict RGYB, global float* restrict RGmask, global float* restrict RGmax_mask, global float* restrict YBmask, global float* restrict YBmax_mask/*, write_only image2d_t debug*/)
{
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int lidX = get_local_id(0);
	const int lidY = get_local_id(1);

	const int sizeX = get_global_size(0);

	const int id = (idY * sizeX) + idX;

	const float4 Lab = LAB[id];
	const float ab = Lab.y+Lab.z;

	float rgyb = ab*Lab.x;
	local float maxv, minv;
	if(lidX == 0) {maxv = 0; minv = 0;}
	barrier(CLK_LOCAL_MEM_FENCE);
	AtomicMaxLocal(&maxv,rgyb);
	AtomicMinLocal(&minv,rgyb);
	barrier(CLK_LOCAL_MEM_FENCE);

	float2 RG = Lab.x > 90 && ab > 0 && ab < 30 /*&& maxv/Lab.x-minv > 20*/ ? (float2)(1,maxv) : (float2)(0,0);
	float2 YB = Lab.x > 90 && ab < 0 && ab > -30 /*&& minv/Lab.x-maxv < -20*/ ? (float2)(1,minv) : (float2)(0,0);

	rgyb *= (1.0f-RG.x)*(1.0f-YB.x);
	RGmask[id] = RG.x;
	RGmax_mask[id] = RG.y;
	YBmask[id] = YB.x;
	YBmax_mask[id] = YB.y;
	RGYB[id] = 0;
	//write_imagef(debug, (int2)(idX,idY), /*(YB.y+RG.y)/1000*/0);
}

#define STR_EL_R 11
/*constant int str_el[STR_EL_R][STR_EL_R] = {{0,0,1,0,0},
							 			   {0,1,1,1,0},
							 			   {1,1,1,1,1},
							 			   {0,1,1,1,0},
							 			   {0,0,1,0,0}
							 			  };*/
constant int str_el[STR_EL_R][STR_EL_R] = {{0,0,0,0,1,1,1,0,0,0,0},
							 			   {0,0,1,1,1,1,1,1,1,0,0},
							 			   {0,1,1,1,1,1,1,1,1,1,0},
							 			   {0,1,1,1,1,1,1,1,1,1,0},
							 			   {1,1,1,1,1,1,1,1,1,1,1},
							 			   {1,1,1,1,1,1,1,1,1,1,1},
							 			   {1,1,1,1,1,1,1,1,1,1,1},
							 			   {0,1,1,1,1,1,1,1,1,1,0},
							 			   {0,1,1,1,1,1,1,1,1,1,0},
							 			   {0,0,1,1,1,1,1,1,1,0,0},
							 			   {0,0,0,0,1,1,1,0,0,0,0}
							 			  };

//faster with many 0-values
kernel void Dilate(global float* restrict RGmask, global float* restrict YBmask, global float* restrict mask_dil/*, write_only image2d_t debug*/)
{
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);

	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int id = (idY * sizeX) + idX;

	//write_imagef(debug, (int2)(idX,idY), mask[id]);
	if(RGmask[id] < 1 && YBmask[id] < 1)
	{
		//write_imagef(debug, (int2)(idX,idY), 0);
		//RGmask_dil[id] = YBmask_dil[id] = 0;
		return;
	}

	const int str_el_x = STR_EL_R/2;
	const int str_el_y = STR_EL_R/2;

	for(int i = -str_el_y; i <= str_el_y; i++)
	{
		const int y = idY + i;
		if(y < 0 || y >= sizeY)
			continue;
		for(int j = -str_el_x; j <= str_el_x; j++)
		{
			const int x = idX + j;
			if(x < 0 || x >= sizeX)
				continue;

			const int dId = x + y*sizeX;
			if(str_el[str_el_y+i][str_el_x+j] > 0)
			{
				//write_imagef(debug, (int2)(x,y), 1.0f);
				mask_dil[dId] = 1;
			}
		}
	}
}

kernel void MaxMin(global float* restrict mask, global float* restrict RGmax_mask, global float* restrict YBmax_mask, global float* restrict gmax, global float* restrict gmin)
{
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);

	const int sizeX = get_global_size(0);

	const int id = (idY * sizeX) + idX;

	local float lmin, lmax;
	if(get_local_id(0) == 0)
	{
		lmin = lmax = 0.0f;
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	if(mask[id] > 0)
	{
		AtomicMaxLocal(&lmax,RGmax_mask[id]);
		AtomicMinLocal(&lmin,YBmax_mask[id]);
	}
	barrier(CLK_LOCAL_MEM_FENCE);


	if(get_local_id(0) == 0)
	{
		float mmax = lmax, mmin = lmin;
		AtomicMax(gmax,mmax);
		AtomicMin(gmin,mmin);
	}

}

#define NH_SIZE 51

kernel void HoleFill(global float* restrict RGYB,
					 global float* restrict mask, global float* restrict RGmax_mask, global float* restrict YBmax_mask,
					 global float* restrict gmax, global float* restrict gmin/*, write_only image2d_t debug*/)
{
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int lidX = get_local_id(0);
	const int lidY = get_local_id(1);

	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int id = (idY * sizeX) + idX;

	if(mask[id] < 1)
	{
		//RGYB[id] = 0;
		//write_imagef(debug, (int2)(idX,idY), (-*gmin)/(*gmax-*gmin));
		return;
	}

	const int str_el_x = NH_SIZE/2;
	const int str_el_y = NH_SIZE/2;

	float maxRG = 0.0f;
	float maxYB = 0.0f;
	for(int i = -str_el_y; i <= str_el_y; i++)
	{
		const int y = idY + i;
		if(y < 0 || y >= sizeY)
			continue;
		for(int j = -str_el_x; j <= str_el_x; j++)
		{
			const int x = idX + j;
			if(x < 0 || x >= sizeX)
				continue;

			const int dId = x + y*sizeX;

			float c = RGmax_mask[dId];
			maxRG = max(maxRG,c);
			c = YBmax_mask[dId];
			maxYB = min(maxYB,c);
		}
	}
	maxRG = maxRG >= 0.8*(*gmax) ? *gmax : 0.0f;
	maxYB = maxYB <= 0.5*(*gmin) ? *gmin : 0.0f;
	RGYB[id] = maxRG + maxYB;
	//write_imagef(debug, (int2)(idX,idY), (maxRG+maxYB -*gmin)/(*gmax-*gmin));
	//write_imagef(debug, (int2)(idX,idY), (maxRG+maxYB + fabs(*gmin))/(fabs(*gmin)+fabs(*gmax)));
	//write_imagef(debug, (int2)(idX,idY), RGmask[id] + YBmask[id]);
}

constant float g[3] = { 1, 1, 1 };
constant float h[3] = { -1, 0, 1 };

kernel void convolve2D(const global float* restrict in, global float* restrict out,
	const int pass, const int kernelSizeX, const int kernelSizeY)
{
	/* Originally this routine is written by Song Ho Ahn in 2005.
	* function changed from row-order storage to col-order storage in
	* order to be compatible with matlab storage.
	*/

	const int idX = get_global_id(0);
	const int idY = get_global_id(1);

	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int id = (idY * sizeX) + idX;

	/* find center position of kernel (half of kernel size) */
	int kCenterX = kernelSizeX >> 1;
	int kCenterY = kernelSizeY >> 1;

	/* init working  pointers */
	const global float *inPtr = in + id;
	constant float *kPtr;
	if(pass < 2)
		kPtr = h;
	else
		kPtr = g;

	float v = 0;

	/*int rowMax = min(idY + kCenterY,sizeY);
	int rowMin = max(idY - sizeY + kCenterY,-1);
	int colMax = min(idX + kCenterX,sizeX);
	int colMin = max(idX - sizeX + kCenterX,-1);

	for (int m = 0; m < kernelSizeY; ++m)
	{
		if (m <= rowMax && m > rowMin)
		{
			for (int n = 0; n < kernelSizeX; ++n)
			{
				if (n <= colMax && n > colMin)
					v += *(inPtr - n) * (*kPtr);
				++kPtr;
			}
		}
		else
			kPtr += kernelSizeX;
		inPtr -= sizeX;
	}*/

	int k = id;
	for (int m = 0; m < kernelSizeY; ++m)
	{
		for (int n = 0; n < kernelSizeX; ++n)
		{
			if(k-n >= 0)
				v += in[k-n] * (*kPtr);
			++kPtr;
		}
		kPtr += kernelSizeX;
		if(k - sizeX < 0)
			break;
		k -= sizeX;
	}

	out[id] = v;
}

kernel void Reset(global float* restrict in1, global float* restrict in2, global float* restrict in3, global float* restrict in4,
				  global float* restrict in5, global float* restrict in6, global float* restrict in7, global float* restrict in8,
				  global float* restrict in9, global float* restrict in10, global float* restrict in11, global float* restrict in12, global int* restrict in13)
{
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);

	const int sizeX = get_global_size(0);

	const int id = (idY * sizeX) + idX;

	in1[id] = in2[id] = in3[id] = in4[id] = in5[id] = in6[id] = in7[id] = in8[id] = in9[id] = in10[id] = in11[id] = in12[id] = in13[id] = 0;
}

kernel void FRST1(const global float* restrict gradXs, const global float* restrict gradYs, global int* restrict O,  global float* restrict M, const int r)
{
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);

	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int id = (idY * sizeX) + idX;

	float gradX = gradXs[id]*0.1768f;
	float gradY = gradYs[id]*0.1768f;
	const float mag = hypot(gradX,gradY);
	if(mag > 0)
	{
		gradX /= mag;
		gradY /= mag;
		int2 affectedInd;
		{

			int affectedPixX = clamp((int)((float)idX + gradY*r + 0.5f),1,sizeX-1);      // +0.5 is added to make the integer value equal to the rounded double value
			int affectedPixY = clamp((int)((float)idY + gradX*r + 0.5f),1,sizeY-1);      // +0.5 is added to make the integer value equal to the rounded double value
			affectedInd.y = (affectedPixY-1)*sizeX + affectedPixX;

			affectedPixX = clamp((int)((float)idX - gradY*r + 0.5f),1,sizeX-1);      // +0.5 is added to make the integer value equal to the rounded double value
			affectedPixY = clamp((int)((float)idY - gradX*r + 0.5f),1,sizeY-1);      // +0.5 is added to make the integer value equal to the rounded double value
			affectedInd.x = (affectedPixY-1)*sizeX + affectedPixX;
		}

		if(affectedInd.x != affectedInd.y)
		{
			atomic_inc(O+affectedInd.x);
			atomic_dec(O+affectedInd.y);

			AtomicAdd(M+affectedInd.x, mag);
			AtomicAdd(M+affectedInd.y, -mag);
		}
	}
}

kernel void FRST2(global int* restrict O, global float* restrict M, /*const float alpha,
				  const global int* restrict gOmax, const global float* restrict gMmax,*/ global float* restrict S/*, write_only image2d_t debug*/)
{
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);

	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int id = (idY * sizeX) + idX;

	float asd = O[id];//(*gOmax+0.00001f);
	float Ot = powr(sqrt(asd*asd), 3.0f);
	float Mt = M[id];//(*gMmax+0.00001);

	S[id] = Ot*Mt;
	O[id] = 0;
	M[id] = 0.0f;
	//write_imagef(debug, (int2)(idX, idY), fabs((float)S[id]));
}

kernel void GaussBlur(const global float* restrict input, const global float* restrict kern, int offset, const int radius, global float* restrict output)
{
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);

	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int id = (idY * sizeX) + idX;
	const int idT = (idX * sizeY) + idY;

	float out = input[id];
	//if(fabs(out) <= 0.0)
	//	return;
	out *= kern[ radius ];

	for(int r = 0; r < radius; ++r)
	{
		const float c0 = input[idY * sizeX + max(idX + (r - radius),	   0)];
		const float c1 = input[idY * sizeX + min(idX + (radius - r), sizeX-1)];

		out += c0 * kern[ r + offset];
		out += c1 * kern[ r + offset];
	}

	// out = transposed in
	output[idT] = out;
}

kernel void Sum(const global float* restrict Sn, global float* restrict S, const int maxPasses, const int pass, global float* restrict gmax, global float* restrict gmin/*, write_only image2d_t debug*/)
{
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);

	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int id = (idY * sizeX) + idX;

	if(pass == 0)
		S[id] = Sn[id];
	else
		S[id] += Sn[id];

	//if(pass == maxPasses-1)
	//	write_imagef(debug, (int2)(idX,idY), (S[id]-*gmin)/(*gmax-*gmin));
}

kernel void NonMinMaxSupression(const global float* restrict S, global float2* restrict reds, global float2* restrict greens, global float* restrict gmax, global float* restrict gmin/*, write_only image2d_t debug*/)
{
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);

	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int id = (idY * sizeX) + idX;

	int dx1 = max(idX-1,0);
	int dx2 = min(idX+1,sizeX-1);
	int dy1 = max(idY-1,0);
	int dy2 = min(idY+1,sizeY-1);

	float s = S[id];
	//write_imagef(debug, (int2)(idX,idY), (s-*gmin)/(*gmax-*gmin));
	//return;
	reds[id] = greens[id] = (float2)(0,0);
	if(s < S[dx1 + idY*sizeX] && s < S[dx2 + idY*sizeX] && s < S[idX + dy1*sizeX] && s < S[idX + dy2*sizeX] && s < *gmin*0.5)
	{
		greens[id].x = fabs(s);
		greens[id].y = id;
		//write_imagef(debug, (int2)(idX,idY), (s-*gmin)/(*gmax-*gmin));
	}
	else if(s > S[dx1 + idY*sizeX] && s > S[dx2 + idY*sizeX] && s > S[idX + dy1*sizeX] && s > S[idX + dy2*sizeX] && s > *gmax*0.8)
	{
		reds[id].x = fabs(s);
		reds[id].y = id;
		//write_imagef(debug, (int2)(idX,idY), (s-*gmin)/(*gmax-*gmin));
	}
	//else
		//write_imagef(debug, (int2)(idX,idY), (-*gmin)/(*gmax-*gmin));
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
