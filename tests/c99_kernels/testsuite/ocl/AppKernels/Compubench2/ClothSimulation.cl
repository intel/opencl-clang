// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
#define KSSTRUCT 50.75f
#define KDSTRUCT -0.25f
#define KSSHEAR 50.75f
#define KDSHEAR -0.25f
#define KSBEND 50.95f
#define KDBEND -0.25f

__constant float KsStruct = KSSTRUCT;
__constant float KdStruct = KDSTRUCT;
__constant float KsShear = KSSHEAR;
__constant float KdShear = KDSHEAR;
__constant float KsBend = KSBEND;
__constant float KdBend = KDBEND;

__constant float springStiffnes[12] =
{
	KSSTRUCT,
	KSSTRUCT,
	KSSTRUCT,
	KSSTRUCT,
	KSSHEAR,
	KSSHEAR,
	KSSHEAR,
	KSSHEAR,
	KSBEND,
	KSBEND,
	KSBEND,
	KSBEND
};

__constant float springDamping[12] =
{
	KDSTRUCT,
	KDSTRUCT,
	KDSTRUCT,
	KDSTRUCT,
	KDSHEAR,
	KDSHEAR,
	KDSHEAR,
	KDSHEAR,
	KDBEND,
	KDBEND,
	KDBEND,
	KDBEND
};

__constant int springCoord[2*12] =
{
	 1, 0,
	 0,-1,
	-1, 0,
	 0, 1,
	 1,-1,
	-1,-1,
	-1, 1,
	 1, 1,
	 2, 0,
	 0,-2,
	-2, 0,
	 0, 2
};

//structural springs (adjacent neighbors)
//        o
//        |
//     o--m--o
//        |
//        o

//shear springs (diagonal neighbors)
//     o  o  o
//      \   /
//     o  m  o
//      /   \
//     o  o  o

//bend spring (adjacent neighbors 1 node away)
//
//o   o   o   o   o
//        |
//o   o   |   o   o
//        |
//o-------m-------o
//        |
//o   o   |   o   o
//        |
//o   o   o   o   o

inline void getSpringCoord(int k, int* x, int* y)
{
	*x = springCoord[k * 2 + 0];
	*y = springCoord[k * 2 + 1];
}

inline void getSpringCoeff(int k, float* ks, float* kd)
{
	*ks = springStiffnes[k];
	*kd = springDamping[k];
}

__kernel
void verlet(__global const float4* restrict g_pos_in, __global const float4* restrict g_pos_old_in, __global float4* restrict g_pos_out, __global float4* restrict g_pos_old_out, __global float4* restrict g_normals_out,
			__global const float* restrict g_mass_in, float damp, float dt, float stepX, float stepY)
{
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);

	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	int index = (idY * sizeX) + idX;

	float mass = g_mass_in[index];

	float4 posData = g_pos_in[index];
	float4 posOldData = g_pos_old_in[index];

	float4 pos = posData;
	float4 pos_old = posOldData;
	float4 vel = (pos - pos_old) / dt;

	const float4 gravity = (float4)(0.0f,-0.00981f,0.0f,0.0f);
	float4 force = gravity*mass + vel*damp;

	float ks, kd;
	int x, y;

	for (int k = 0; k < 12; ++k)
	{
		getSpringCoord(k, &x, &y);
		getSpringCoeff(k, &ks, &kd);

		if (((idX + x) < 0) || ((idX + x) > (sizeX - 1)))
			continue;

		if (((idY + y) < 0) || ((idY + y) > (sizeY - 1)))
			continue;

		int index_neigh = (idY + y) * sizeX + (idX + x);

		float rest_length = length((float2)((float)(x) * stepX, (float)(y) * stepY));

		float4 pos_neighData = g_pos_in[index_neigh];
		float4 pos_lastData = g_pos_old_in[index_neigh];

		float4 p2 = pos_neighData;
		float4 p2_last = pos_lastData;

		float4 v2 = (p2- p2_last) / dt;
		float4 deltaP = pos - p2;
		float4 deltaV = vel - v2;
		float dist = length(deltaP);

		float leftTerm = -ks * (dist-rest_length);
		float rightTerm = kd * (dot(deltaV, deltaP)/dist);
		float4 springForce = (leftTerm + rightTerm)*normalize(deltaP);
		force += springForce;
	}

	float4 normal;

	{
		int index_neigh_left = (idY) * sizeX + max((idX - 1), 0);
		int index_neigh_right = (idY) * sizeX + min((idX + 1), sizeX-1);
		int index_neigh_bottom = max((idY - 1), 0) * sizeX + (idX);
		int index_neigh_top = min((idY + 1), sizeY-1) * sizeX + (idX);

		float4 left = g_pos_in[index_neigh_left];
		float4 right = g_pos_in[index_neigh_right];
		float4 bottom = g_pos_in[index_neigh_bottom];
		float4 top = g_pos_in[index_neigh_top];

		float4 tangentX = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
		float4 tangentY = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

		tangentX += right - pos;
		tangentX += pos - left;

		if (dot(tangentX, tangentX) < 1e-10f)
			tangentX = (float4)(1.0f, 0.0f, 0.0f, 0.0f);
		else
			tangentX = normalize(tangentX);

		tangentY += bottom - pos;
		tangentY += pos - top;

		if (dot(tangentY, tangentY) < 1e-10f)
			tangentY = (float4)(0.0f, 1.0f, 0.0f, 0.0f);
		else
			tangentY = normalize(tangentY);

		normal = cross(tangentX, tangentY);
	}

	float4 acc = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
	if(mass!=0.0f)
		acc = force / mass;

	// verlet
	float4 tmp = pos;
	pos = pos * 2.0f - pos_old + acc * dt * dt;
	pos_old = tmp;

	float cf = 0.75f;
	float4 d = pos - pos_old;
	float4 rt = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	// y-up world plane
	{
		if (pos.y < 0.0f)
		{
			// collision
			float4 coll_dir = (float4)(0.0f, 1.0f, 0.0f, 0.0f);
			pos.y = 0.0f;

			float4 dt = d - coll_dir * dot(d, coll_dir);
			rt += -cf*dt;
		}
	}

	// sphere
	{
		float4 center = (float4)(0.0f, 2.0f, 0.0f, 1.0f);
		float radius = 1.75f;

		if (length(pos - center) < radius)
		{
			// collision
			float4 coll_dir = normalize(pos - center);
			pos = center + coll_dir * radius;

			float4 dt = d - coll_dir * dot(d, coll_dir);
			rt += -cf*dt;
		}
	}

	g_pos_out[index] = pos + rt;
	g_pos_old_out[index] = pos_old;

	g_normals_out[index] = normalize(normal);
}
