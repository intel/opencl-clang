//#define DAMP 0.85f
//#define CENTER_FORCE	0.01f
//#define RADIUS_SQ  200.0f*200.0f


#define DAMP 0.79f
#define CENTER_FORCE	0.05f
#define RADIUS_SQ  200.0f*200.0f
#define MASS_F 0.9f



typedef struct
{
	float2 pos, accel, vel;
	float mass;
	float radius;
} Particle;


__kernel void updateParticleWithoutCollision(__global Particle* pIn, __global float2* pOut, const unsigned int particleCount, const float2 mousePos, const float2 dimensions, const float time)
{
	int id = get_global_id(0);
	__global Particle *p = &pIn[id];

	float distSQ, invDistSQ; //, dist, forceAmount, distNorm;
	float2 diff;
	float2 force;
	diff = mousePos - pOut[id].xy;
	distSQ = dot(diff, diff);
	force = (dimensions*0.5f - pOut[id].xy) * CENTER_FORCE;
	if(distSQ < RADIUS_SQ)
  {
		invDistSQ = 1.0f / (distSQ + 0.000001f);
		diff *= 300.0f * invDistSQ;
		force -= diff * p->mass * MASS_F;
	}
	p->vel += force * p->mass * MASS_F;
	pOut[id] += p->vel;
	p->vel *= DAMP;

}






#define DAMP_S 0.42f
#define CENTER_FORCE_S	0.01f
#define RADIUS_SQ_S  100.0f*100.0f


__kernel void updateParticleWithoutCollisionSin(__global Particle* pIn, __global float2* pOut, const unsigned int particleCount, const float2 mousePos, const float2 dimensions,  const float time)
{
	int id = get_global_id(0);
	__global Particle *p = &pIn[id];

	float distSQ, invDistSQ; //, dist, forceAmount, distNorm;
	float2 diff;
	float2 force;
	diff = mousePos - pOut[id].xy;
	distSQ = dot(diff, diff);
	force = (dimensions*0.5f - pOut[id].xy) * CENTER_FORCE_S;
	if(distSQ < RADIUS_SQ_S)
  {
		invDistSQ = 1.0f / (distSQ + 0.000001f);
		diff *= 300.0f * invDistSQ;
		force -= diff * p->mass;
	}
	p->vel += force * p->mass;
	//pOut[id] += p->vel * sin((float)(id));
  pOut[id] += sin(p->vel * cos(time * 0.5f));
	p->vel *= DAMP_S;
}

__kernel void updateParticleWithoutCollisionNativeSin(__global Particle* pIn, __global float2* pOut, const unsigned int particleCount, const float2 mousePos, const float2 dimensions,  const float time)
{
	int id = get_global_id(0);
	__global Particle *p = &pIn[id];

	float distSQ, invDistSQ; //, dist, forceAmount, distNorm;
	float2 diff;
	float2 force;
	diff = mousePos - pOut[id].xy;
	distSQ = dot(diff, diff);
	force = (dimensions*0.5f - pOut[id].xy) * CENTER_FORCE_S;
	if(distSQ < RADIUS_SQ_S)
  {
		invDistSQ = 1.0f / (distSQ + 0.000001f);
		diff *= 300.0f * invDistSQ;
		force -= diff * p->mass;
	}
	p->vel += force * p->mass;
	//pOut[id] += p->vel * native_sin((float)(id));
  pOut[id] += native_sin(p->vel * native_cos(time * 0.5f));
	p->vel *= DAMP_S;

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
