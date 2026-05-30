//global include for a all OpenCL kernels programs

//This software contains source code provided by NVIDIA Corporation.
#define maxSteps 1000

typedef struct
{
    float4 xAxis;
    float4 yAxis;
    float4 zAxis;
    float4 ePos;
    float4 xAxisInv;
    float4 yAxisInv;
    float4 zAxisInv;
    float dFar;
    float dNear;
}
Camera;


typedef struct
{
	uint imageW;
	uint imageH;
	float density;
	float lower;
	float upper;
	float transferScale;
	uint lighting;
	float resolution;
}
Params;


// intersect ray with a box
// http://www.siggraph.org/education/materials/HyperGraph/raytrace/rtinter3.htm

int intersectBox(float4 r_o, float4 r_d, float4 boxmin, float4 boxmax, float *tnear, float *tfar)
{
    // compute intersection of ray with all six bbox planes
    float4 invR = (float4)(1.0f,1.0f,1.0f,1.0f) / r_d;
    float4 tbot = invR * (boxmin - r_o);
    float4 ttop = invR * (boxmax - r_o);

    // re-order intersections to find smallest and largest on each axis
    float4 tmin = min(ttop, tbot);
    float4 tmax = max(ttop, tbot);

    // find the largest tmin and the smallest tmax
    float largest_tmin = max(max(tmin.x, tmin.y), max(tmin.x, tmin.z));
    float smallest_tmax = min(min(tmax.x, tmax.y), min(tmax.x, tmax.z));

	*tnear = largest_tmin;
	*tfar = smallest_tmax;

	return smallest_tmax > largest_tmin;
}

float4 computeNormal(__read_only image3d_t volume, const sampler_t volumeSampler, float4 pos, float d)
{
	float4 posX = pos;
	posX.x += d;
	float4 xP = read_imagef(volume, volumeSampler, posX);
	posX.x -= 2*d;
	float4 xN = read_imagef(volume, volumeSampler, posX);

	float4 posY = pos;
	posY.y += d;
	float4 yP = read_imagef(volume, volumeSampler, posY);
	posY.y -= 2*d;
	float4 yN = read_imagef(volume, volumeSampler, posY);

	float4 posZ = pos;
	posZ.z += d;
	float4 zP = read_imagef(volume, volumeSampler, posZ);
	posZ.z -= 2*d;
	float4 zN = read_imagef(volume, volumeSampler, posZ);

	float4 lNormal = (float4)(xN.x - xP.x, yN.x - yP.x, zN.x - zP.x, 0);
	return normalize(lNormal);
}


__kernel void rendervolume(__write_only image2d_t diffuse,
						   __constant Params* params,
						   __constant Camera* camera,
						   __read_only image3d_t volume,
						   __read_only image2d_t transferFunc)

{
	const sampler_t volumeSampler = CLK_NORMALIZED_COORDS_TRUE | CLK_ADDRESS_CLAMP | CLK_FILTER_LINEAR;
	const sampler_t transferFuncSampler = CLK_NORMALIZED_COORDS_TRUE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_LINEAR;

    //float tstep = 0.01f;
    float4 boxMin = (float4)(-1.0f, -1.0f, -1.0f,1.0f);
    float4 boxMax = (float4)(1.0f, 1.0f, 1.0f,1.0f);

	uint x = get_global_id(0);
    uint y = get_global_id(1);

    float u = (x / (float) params->imageW)*2.0f-1.0f;
    float v = (y / (float) params->imageH)*2.0f-1.0f;

    // calculate eye ray in world space
    float4 eyeRay_o;
    float4 eyeRay_d;

    eyeRay_o = camera->ePos;
	eyeRay_d = normalize(-camera->zAxis + u*camera->xAxis + v*camera->yAxis);

    // find intersection with box
	float tnear, tfar;
	int hit = intersectBox(eyeRay_o, eyeRay_d, boxMin, boxMax, &tnear, &tfar);
    if (!hit)
	{
        if ((x < params->imageW) && (y < params->imageH))
		{
			write_imagef(diffuse,(int2)(x,y), (float4)1);
        }
        return;
    }


	float4 lightEye = (float4) (0, 1, 1, 0);

	//float4 lightVec = (float4)(camera->xAxisInv.x, camera->yAxisInv.x, camera->zAxisInv.x, 0);
	float4 lightVec;
	if (params->lighting)
	{
		lightVec.x = dot(lightEye, camera->xAxisInv);
		lightVec.y = dot(lightEye, camera->yAxisInv);
		lightVec.z = dot(lightEye, camera->zAxisInv);
		lightVec = normalize(lightVec);
	}

	if (tnear < 0.0f) tnear = 0.0f;     // clamp to near plane

    // march along ray from back to front, accumulating color
    float4 temp = (float4)(1.0f,1.0f,1.0f,0.0f);
    float t = tfar;
	for(uint i=0; i<maxSteps; i++)
	{
        float4 pos = eyeRay_o + eyeRay_d*t;
        pos = pos*0.5f+0.5f;    // map position to [0, 1] coordinates

        // read from 3D texture
        float4 sample = read_imagef(volume, volumeSampler, pos);

		if (sample.x >= params->lower && sample.x <= params->upper)
		{
			// lookup in transfer function texture
			float2 transfer_pos = (float2)(0.5f, sample.x*params->transferScale);
			float4 col = read_imagef(transferFunc, transferFuncSampler, transfer_pos);

			float intensity = 1.0;
			if (params->lighting)
			{
				float4 normal = computeNormal(volume, volumeSampler, pos, 2.0*params->resolution);
				intensity = clamp(dot(normal, lightVec)+0.2f, 0.0f, 1.0f);
			}

			temp = mix(temp, col*intensity, col.w*params->density);
		}

        t -= params->resolution;
        if (t < tnear)
		{
			break;
		}
    }

    if ((x < params->imageW) && (y < params->imageH))
	{
        write_imagef(diffuse,(int2)(x,y), temp);
    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
