
__kernel void
copy_kern(
	int n,
	__global float4* b,
	__global float4* a
)
{
	int gti = get_global_id(0);

		b[gti] = a[gti];

}


__kernel void
nbody_kern(
	int n,
	float dt,
	float eps,
	__global float4* pp,
	__global float4* vv,
	__global float4* ppo
)
{
	const float4 zero4 = (float4){0.0f,0.0f,0.0f,0.0f};
	const float4 invtwo4 = (float4){0.5f,0.5f,0.5f,0.5f};
	const float4 dt4 = (float4){dt,dt,dt,0.0f};

	int gti = 2*get_global_id(0);

	int ti = get_local_id(0);

	float4 p0 = ppo[gti+0];
	float4 p1 = ppo[gti+1];

	float4 a0 = zero4;
	float4 a1 = zero4;

	int i;

	n *= 2;

	for(i=0;i<n;i+=8) {

		// loop within block accumulating acceleration of particles

			float4 p2 = ppo[i+0];
			float4 p3 = ppo[i+1];
			float4 p4 = ppo[i+2];
			float4 p5 = ppo[i+3];

			float4 p6 = ppo[i+4];
			float4 p7 = ppo[i+5];
			float4 p8 = ppo[i+6];
			float4 p9 = ppo[i+7];

			float4 dp = p2 - p0;
			float invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a0 += (p2.w * invr*invr*invr)*dp;
			dp = p2 - p1;
			invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a1 += (p2.w * invr*invr*invr)*dp;


			dp = p3 - p0;
			invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a0 += (p2.w * invr*invr*invr)*dp;
			dp = p3 - p1;
			invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a1 += (p2.w * invr*invr*invr)*dp;



			dp = p4 - p0;
			invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a0 += (p2.w * invr*invr*invr)*dp;
			dp = p4 - p1;
			invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a1 += (p2.w * invr*invr*invr)*dp;


			dp = p5 - p0;
			invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a0 += (p2.w * invr*invr*invr)*dp;
			dp = p5 - p1;
			invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a1 += (p2.w * invr*invr*invr)*dp;



			dp = p6 - p0;
			invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a0 += (p2.w * invr*invr*invr)*dp;
			dp = p6 - p1;
			invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a1 += (p2.w * invr*invr*invr)*dp;


			dp = p7 - p0;
			invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a0 += (p2.w * invr*invr*invr)*dp;
			dp = p7 - p1;
			invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a1 += (p2.w * invr*invr*invr)*dp;


			dp = p8 - p0;
			invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a0 += (p2.w * invr*invr*invr)*dp;
			dp = p8 - p1;
			invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a1 += (p2.w * invr*invr*invr)*dp;


			dp = p9 - p0;
			invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a0 += (p2.w * invr*invr*invr)*dp;
			dp = p9 - p1;
			invr = rsqrt(dp.x*dp.x + dp.y*dp.y + dp.z*dp.z + eps);
			a1 += (p2.w * invr*invr*invr)*dp;

	}

	// update position and velocity

	float4 v0 = vv[gti+0];
	float4 v1 = vv[gti+1];
   p0 += dt4*v0 + invtwo4*dt4*dt4*a0;
   p1 += dt4*v1 + invtwo4*dt4*dt4*a1;
   v0 += dt4*a0;
   v1 += dt4*a1;
	pp[gti+0] = p0;
	pp[gti+1] = p1;
	vv[gti+0] = v0;
	vv[gti+1] = v1;

	return;

}





// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
