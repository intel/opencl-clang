
#define EPSILON 0.00001f
#define OVERLAP 0.00001f
#define AOOFFSET 0.001f
#define PI 3.14159265358979323846f
#define CUTOFF 0.0039f
#define REFLECT(i, n) (i - 2*dot(n,i)*n)
#define TMIN 100000.f
#define TMAX 100000.f
#define BVH_STACK_SIZE 64

float3 mNormalize(float3 in) {
	float n = sqrt(dot(in, in));
	return (in/n);
}

float clamp1(float a, float min, float max) {
	if (a<min) return min;
	if (a>max) return max;
	return a;
}

float3 mClamp(float3 a, float min, float max) {
	return (float3)(clamp1(a.x,min,max),clamp1(a.y,min,max),clamp1(a.z,min,max));
}

float mLength(float3 a) {
	return sqrt(dot(a,a));
	}

float3 mCross(float3 a, float3 b) {
	return (float3)(a.y*b.z-a.z*b.y, a.z*b.x-a.x*b.z, a.x*b.y-a.y*b.x);
	}

float mMin(float a, float b) {
	if (a<b) return a;
	else return b;
	}

typedef struct {

	float			f[3];

} cl_f3; // Used as a point or vector



typedef struct {

	float			ambient[3];
    float           diffuse[3];
    float           specular[3];
	float			reflect;
	float			refract;
	float			refract_index;
	float			shiny;
	float			glossy;
	float			trans;

} cl_material;


typedef struct {


	float			v0[3];
	float			v1[3];
	float			v2[3];

	uint            normalIdx[3];
	uint            materialIdx;

} cl_triangle;



typedef struct {

	uint			n;
	uint			index;
	float           minCorner[3];
	float           maxCorner[3];

} cl_node;


typedef struct {

					float3 origin;
					float3 direction;
} Ray;


typedef struct {

	float4			viewProjectionInverse[4];
    int             oc;
    int             shadow;
    int             phong;
    int             ao_rays;
    float           ao_radius;
	float          light_positionx;
		float          light_positiony;
			float          light_positionz;

} Constants;


float4 MatMulVec4(__constant float4* matrix, float4 v)
{
	return (float4)(dot(v, matrix[0]), dot(v, matrix[1]), dot(v, matrix[2]), dot(v, matrix[3]));
}

float3 shade(	float3 direction,
				float3 lightVector,
				float3 normal,
				__global cl_material* materials,
                int matIdx,
                int phong)
{
    float specularStrength = 0.1f;
    float d = 0.3f;
	float ka = 0.6f;
	//float3 ambient = (float3)(materials[matIdx].ambient[0], materials[matIdx].ambient[1], materials[matIdx].ambient[2]);
	float3 ambient = (float3)(materials[matIdx].diffuse[0], materials[matIdx].diffuse[1], materials[matIdx].diffuse[2]);
    float3 diffuse = mClamp((float3)(materials[matIdx].diffuse[0], materials[matIdx].diffuse[1], materials[matIdx].diffuse[2]) * dot(normal,lightVector), 0, 1);
    float power = dot(lightVector, normal) > 0 ? pow( dot( REFLECT(direction, normal) , lightVector ), materials[matIdx].shiny) : 0;
    float3 specular = mClamp((float3)(materials[matIdx].specular[0], materials[matIdx].specular[1], materials[matIdx].specular[2]) * power, 0, 1);
    if(phong)
        return mClamp((ka*ambient + d*diffuse + specularStrength*specular), 0 ,1);
    else
        return (float3)(materials[matIdx].diffuse[0], materials[matIdx].diffuse[1], materials[matIdx].diffuse[2]);
}


float boxIntersection(	float3 o,
						float3 d,
						float3 inv_dir,
						const __global  cl_node *pNode	) {

	float tmin, ty_min, tz_min;
	float tmax, ty_max, tz_max;


	float fminc[3];
	float fmaxc[3];
	for (int cc=0; cc<3; cc++) {
		fminc[cc] = pNode->minCorner[cc];
		fmaxc[cc] = pNode->maxCorner[cc];
	}

	if( d.x >= 0) {
		tmin = ( fminc[0] - o.x ) * inv_dir.x;
		tmax = ( fmaxc[0] - o.x ) * inv_dir.x;
	} else {
		tmin = ( fmaxc[0] - o.x ) * inv_dir.x;
		tmax = ( fminc[0] - o.x ) * inv_dir.x;
	}


	if( d.y >= 0 ) {
		ty_min = ( fminc[1] - o.y ) * inv_dir.y;
		ty_max = ( fmaxc[1] - o.y ) * inv_dir.y;
	} else {
		ty_min = ( fmaxc[1] - o.y ) * inv_dir.y;
		ty_max = ( fminc[1] - o.y ) * inv_dir.y;
	}

	if ((tmin > ty_max) || (ty_min > tmax))
		return TMAX;

	if (ty_min > tmin)
		tmin = ty_min;
	if (ty_max < tmax)
		tmax = ty_max;

	if( d.z >= 0 ) {
		tz_min = ( fminc[2] - o.z ) * inv_dir.z;
		tz_max = ( fmaxc[2] - o.z ) * inv_dir.z;
	} else {
		tz_min = ( fmaxc[2] - o.z ) * inv_dir.z;
		tz_max = ( fminc[2] - o.z ) * inv_dir.z;
	}

	if ( (tmin > tz_max) || (tz_min > tmax) )
		return TMAX;

	if (tz_min > tmin)
		tmin = tz_min;
	if (tz_max < tmax)
		tmax = tz_max;

	if ( (tmin < TMAX) && (tmax > EPSILON) )
		return tmin;
	return TMAX;
}

float triangleIntersection(		float3 origin,
								float3 dir,
								__global  cl_triangle * pTriangle,
								__global  cl_f3* normals,
								float3 * normal,
								float3 * hitPosition,
								float * tmin) {

	float3 p0 = (float3)(pTriangle->v0[0], pTriangle->v0[1], pTriangle->v0[2]);
	float3 e1 = (float3)(pTriangle->v1[0], pTriangle->v1[1], pTriangle->v1[2]) - p0;
	float3 e2 = (float3)(pTriangle->v2[0], pTriangle->v2[1], pTriangle->v2[2]) - p0;

	float3 pvec = mCross(dir, e2);
	float det = dot(e1, pvec);
	if( det < EPSILON && det > -EPSILON )
		return 0;

	float inv_det = 1.0f / det;
	float3 tvec = origin - p0;

	float u = inv_det * dot(tvec, pvec);
	if( u < -OVERLAP || u > (1.0f+OVERLAP) )
		return 0;

	float3 qvec = mCross(tvec, e1);
	float v = inv_det * dot(dir, qvec);
	if( v < -OVERLAP || (u+v) > (1.0f+OVERLAP) )
		return 0;

	float t = inv_det * dot(e2, qvec);
	if( t < EPSILON || t >= TMAX )
		return 0;

	if(t < *tmin) {

		float3 n0 = (float3)(	normals[pTriangle->normalIdx[0]].f[0], normals[pTriangle->normalIdx[0]].f[1], normals[pTriangle->normalIdx[0]].f[2]	);
		float3 n1 = (float3)(	normals[pTriangle->normalIdx[1]].f[0], normals[pTriangle->normalIdx[1]].f[1], normals[pTriangle->normalIdx[1]].f[2]	);
		float3 n2 = (float3)(	normals[pTriangle->normalIdx[2]].f[0], normals[pTriangle->normalIdx[2]].f[1], normals[pTriangle->normalIdx[2]].f[2]	);

		*normal = mNormalize((1.0f - u - v) * n0 + u * n1 + v * n2);
		*hitPosition = origin + t * dir;
		*tmin = t;
		return t;
	}
	return 0;

}


int triangleShadowIntersection(   float3 origin,
                                    float3 dir,
                                    __global  cl_triangle * pTriangle,
                                    float * tmin) {

	float3 p0 = (float3)(pTriangle->v0[0], pTriangle->v0[1], pTriangle->v0[2]);
	float3 e1 = (float3)(pTriangle->v1[0], pTriangle->v1[1], pTriangle->v1[2]) - p0;
	float3 e2 = (float3)(pTriangle->v2[0], pTriangle->v2[1], pTriangle->v2[2]) - p0;

	float3 pvec = mCross(dir, e2);
	float det = dot(e1, pvec);
	if( det < EPSILON && det > -EPSILON )
		return 0;

	float inv_det = 1.0f / det;
	float3 tvec = origin - p0;

	float u = inv_det * dot(tvec, pvec);
	if( u < -OVERLAP || u > (1.0f+OVERLAP) )
		return 0;

	float3 qvec = mCross(tvec, e1);
	float v = inv_det * dot(dir, qvec);
	if( v < -OVERLAP || (u+v) > (1.0f+OVERLAP) )
		return 0;

	float t = inv_det * dot(e2, qvec);
	if( t < EPSILON || t > *tmin )
		return 0;

	if(t < *tmin) {
		return 1; // occluded
	}
	return 0; // not occluded

}

//#define DEBUGTRACE

float traceRay(	Ray * pIncidentRay,
				__global   cl_triangle * triangles,
				__global   cl_node * nodes,
				__global   cl_f3 * normals,
				float3 * pNormal,
				float3 * pHitPosition,
				int * pTriangleIndex,
				unsigned int *pBox_intersections)
{
#ifdef DEBUGTRACE
	printf("starting traceRay %f,%f,%f\n",pIncidentRay->origin.x,pIncidentRay->origin.y,pIncidentRay->origin.z);
#endif
	float t;
	float tReturn = 0;
	float tmin = TMAX;
	int s = 0;
	 struct stack {
		int ptr;
		float t;
	} node_stack[BVH_STACK_SIZE];

	int stack_ptr = 0;

    cl_node node;
	node.index = 0;
	node.n = 0;

	float3 origin	=	pIncidentRay->origin;
	float3 d		=	pIncidentRay->direction;
    float3 inv_dir	=	1.0f/pIncidentRay->direction;

	int idx;
	bool cont = false;



//#define HITALL
#ifdef HITALL

	float ltmin = boxIntersection(origin, d, inv_dir, &nodes[ idx ]);
	float rtmin = boxIntersection(origin, d, inv_dir, &nodes[ idx + 1 ]);

	if ((ltmin<tmin)||(rtmin<tmin)){
		for (int i = 0; i < 12; i++ ) {
				pBox_intersections[1]++;
				t = triangleIntersection(	pIncidentRay->origin, pIncidentRay->direction, &triangles[i], normals, pNormal, pHitPosition,
&tmin);
				if(t) {
					*pTriangleIndex = i;
					tReturn = tmin;
				}
		}
	}
	return tReturn;
#endif


	int c = 0;

	for (;;) {
	//while (c<100) {
		c = c+1; if ( c>100000) printf("loop %d, ",c);
		cont=false;
		// If node is not a leaf
		if ( !(node.n) ) {

			idx = node.index;

			float ltmin = boxIntersection(origin, d, inv_dir, &nodes[ idx ]);
			float rtmin = boxIntersection(origin, d, inv_dir, &nodes[ idx + 1 ]);

			int lhit = (ltmin < tmin);
			int rhit = (rtmin < tmin);
			//printf("node %d, %s%s",idx,(lhit)?"lhit, ":"", (rhit)?"rhit, ":"");
			pBox_intersections[0] += 2; // Increase boxes intersected by 2

			if ( lhit && rhit ) {
			#ifdef DEBUGTRACE
			printf("node %d, l&rHit, ",idx);
			#endif
				//Both nodes are intersected - traverse near node and put far node on the stack
				if ( ltmin < rtmin) {
					// Put right on the stack and traverse left child
					node_stack[stack_ptr].ptr = idx+1;
					node_stack[stack_ptr++].t = rtmin;
					node = nodes[ idx ];
				} else {
					// Put left on the stack and traverse right child
					node_stack[stack_ptr].ptr = idx;
					node_stack[stack_ptr++].t = ltmin;
					node = nodes[ idx + 1 ];
				}
				continue;  // COMPILER CRASH - remove this line to stop the HD4000 OpenCL compiler from crashing
				cont = true;
			}
			else if (lhit) {
		#ifdef DEBUGTRACE
			printf("node %d, lHit, ",idx);
		#endif

				// Only the left node is intersected
				node = nodes[ idx ];
				continue;
			}
			else if (rhit) {
						#ifdef DEBUGTRACE
			printf("node %d, rHit, ",idx);
			#endif

				// Only the right node is intersected
				node = nodes[ idx + 1 ];
				continue;
			}
		} else {
            // Node is leaf, intersect triangles
			int n, i;
			idx = node.index;
			n = idx + node.n;
			//printf("node %d, tris %d, ",idx,n);
			for (i = idx; i < n; i++ ) {
				pBox_intersections[1]++;
				t = triangleIntersection(	pIncidentRay->origin,
											pIncidentRay->direction,
											&triangles[i],
											normals,
											pNormal,
											pHitPosition,
											&tmin);
				if(t) {
					*pTriangleIndex = i;
					tReturn = tmin;
					#ifdef DEBUGTRACE
					printf("hit %d, ",i);
					#endif
				}
			}
		}

		if (!cont) {

		for(;;) {
		//while (s<100 ) { // cannot increment and use a variable inside a while() statement??
			//s = s + 1;
			//printf("pop %d, ",s++);
            // Pop stack until box is not further away than tmin
			if(!stack_ptr) {
				#ifdef DEBUGTRACE
				printf("\n");
				#endif
				return tReturn;
			}

			if(node_stack[--stack_ptr].t < tmin) {
                pBox_intersections[2]++;
				node = nodes[node_stack[stack_ptr].ptr];
				break;
			}
		}
		}
	}
	#ifdef DEBUGTRACE
	//printf("\n");
	#endif
}

//#define SDTRACE
#define TX 9
#define TY 9
#define CODE   if (c) hack = get_global_id(0);

int shadowRay(Ray * pIncidentRay,
                float ray_length,
                __global   cl_triangle * triangles,
                __global   cl_node * nodes)
{
	int gx = get_global_id(0);
	int gy = get_global_id(1);
	float t;
	cl_node node;
	bool cont = false;

	struct stack {
		int ptr;
		float t;
	} node_stack[BVH_STACK_SIZE];

	int stack_ptr = 0;
	node.index = 0;
	node.n = 0;
    float3 d		=	pIncidentRay->direction;
	float3 origin	=	pIncidentRay->origin;
	float3 inv_dir	=	1.0f/pIncidentRay->direction;

	int idx;
    int c = 0;
	int hack;

//	for (;;) {
while (c<100) {
	//printf("loop %d, ",c);
		c = c+1; if ( c>100000) printf("loop %d, ",c);
		if (c>100) {
			// if (get_global_id(0)==60)
			//printf("%d.%d, ",get_global_id(0),get_global_id(1));
			return 0;
		}
		cont = false;

		// If node is not a leaf
		if ( !(node.n) ) {

			idx = node.index;

			float ltmin = boxIntersection(origin, d, inv_dir, &nodes[ idx ]);
			float rtmin = boxIntersection(origin, d, inv_dir, &nodes[ idx + 1 ]);

			int lhit = (ltmin <= ray_length);
			int rhit = (rtmin <= ray_length);


#ifdef SDTRACE
			if ((gx==TX) && (gy==TY) ) {

				//printf(".");
				//if (c==1) printf("DIM%d.%d.%d:\n",get_global_size(0),get_group_id(0),get_num_groups(0));
				printf("%d.%d: ",get_global_id(0),get_global_id(1));
				printf("TRV%d l%d r%d idx %d stack %d\n",c,lhit,rhit,idx,stack_ptr);
			}
#endif
		//CODE
           // printf("%d %d %d %d, ",get_global_id(0),c,lhit,rhit);
			//printf("%s", (lhit)?"l":"" );
			//printf("%s", "l" );
			//pBox_intersections[0] += 2; // Increase boxes intersected by 2

			if ( lhit && rhit ) {
				//Both nodes are intersected - traverse near node and put far node on the stack
				if ( ltmin < rtmin) {
					// Put right on the stack and traverse left child
					node_stack[stack_ptr].ptr = idx+1;
					node_stack[stack_ptr++].t = rtmin;
					node = nodes[ idx ];
				} else {
					// Put left on the stack and traverse right child
					node_stack[stack_ptr].ptr = idx;
					node_stack[stack_ptr++].t = ltmin;
					node = nodes[ idx + 1 ];
				}
				//continue;
				cont = true;
			}
			else if (lhit) {
				// Only the left node is intersected
				node = nodes[ idx ];
				//continue;
				cont = true;
			}
			else if (rhit) {
				// Only the right node is intersected
				node = nodes[ idx + 1 ];
				//continue;
				cont = true;
			}
		} else {
            // Node is leaf, intersect triangles
			int n, i;
			idx = node.index;
			n = idx + node.n;
#ifdef SDTRACE
			if ((gx==TX) && (gy==TY) ) {
				//printf("-");
				printf("%d.%d: ",get_global_id(0),get_global_id(1));
				printf("TRIa%d idx %d n %d t %.1f stack %d\n",c,idx,n,t,stack_ptr);
			}
#endif
//CODE
			for (i = idx; i < n; i++ ) {
				//pBox_intersections[1]++;
				t = triangleShadowIntersection(	pIncidentRay->origin,
                                            pIncidentRay->direction,
                                            &triangles[i],
                                            &ray_length);
				if(t) {
					return 1; // MCDMCD hack - improves shadows
#ifdef SDTRACE
					if ((gx==TX) && (gy==TY) ) {
						printf("%d.%d: ",get_global_id(0),get_global_id(1));
						printf("HIT%d tri %d t %.1f\n",c,i,t);
					}
#endif
//CODE
				}
			}
#ifdef SDTRACE
			if ((gx==TX) && (gy==TY) ) {
				// if (t==1) printf("-"); // MCDMCD HACK needed to get some shadows to work???

				printf("%d.%d: ",get_global_id(0),get_global_id(1));
				printf("TRIb%d idx %d n %d t %.1f stack %d\n",c,idx,n,t,stack_ptr);
			}
#endif
CODE
		}
		if (!cont) {
			// Pop stack until box is not further away than tmin
			if(stack_ptr<=0) { // compiler bug!!! MCDMCD was !stack_ptr, but it somehow misses 0?
#ifdef SDTRACE
				if ((gx==TX) && (gy==TY) ) {
					//printf("=");
					printf("%d.%d: ",get_global_id(0),get_global_id(1));
					printf("STEMPTY%d stack %d\n",c,stack_ptr);
				}
#endif
CODE
				return 0;
			}
#ifdef SDTRACE
            if ((gx==TX) && (gy==TY) ) {
				//printf("=");
				printf("%d.%d: ",get_global_id(0),get_global_id(1));
				printf("POP%d stack %d\n",c,stack_ptr);
			}
#endif
//CODE
			node = nodes[node_stack[--stack_ptr].ptr];
		}

	}
}


typedef struct {
	unsigned int w;
	unsigned int z;
} random_t;

void random_init(random_t* r, int seed) {
	r->w = seed + 1;
	r->z = seed * seed + seed + 2;
}

int random_nextint(random_t* r) {
	r->z = 36969 * (r->z & 65535) + (r->z >> 16);
	r->w = 18000 * (r->w & 65535) + (r->w >> 16);

	return (r->z << 16) + r->w;
}

float random_nextfloat(random_t* r) {
	return (random_nextint(r) & 0xffff) / (float)0xffff;
}

// Constructs a basis around the normal.

void constructnormalbasis(float3 n, float3* outu, float3* outv) {
	float3 up;
	if (fabs(n.x) > 0.1f)
		up = (float3)(0.0f, 1.0f, 0.0f);
	else
		up = (float3)(1.0f, 0.0f, 0.0f);

	float3 u = mCross(up, n);
	u = mNormalize(u);

	float3 v = mCross(n, u);

	*outu = u;
	*outv = v;
}


float ao_sample(__global   cl_node * nodes , __global    cl_triangle * triangles, float3 n, float3 p, random_t* rnd, __constant Constants * c) {

	const float tmax = c->ao_radius;
	int rays = (int)c->ao_rays;
	float f = 0.0f;
	float samplecountroot;
	float3 u, v;
	constructnormalbasis(n, &u, &v);
	p = p + n*0.03f;
	while(rays > 3) {
		if(rays >= 144)
			samplecountroot = 12;
		else if(rays >= 121)
			samplecountroot = 11;
		else if(rays >= 100)
			samplecountroot = 10;
		else if(rays >= 81)
			samplecountroot = 9;
		else if(rays >= 64)
			samplecountroot = 8;
		else if(rays >= 49)
			samplecountroot = 7;
		else if(rays >= 36)
			samplecountroot = 6;
		else if(rays >= 25)
			samplecountroot = 5;
		else if(rays >= 16)
			samplecountroot = 4;
		else if(rays >= 9)
			samplecountroot = 3;
		else if(rays >= 4)
			samplecountroot = 2;

		rays -= samplecountroot*samplecountroot;

		for (int sy = 0; sy < samplecountroot; ++sy) {
			for (int sx = 0; sx < samplecountroot; ++sx) {
				float r1 = 2.0f*PI*(sx + random_nextfloat(rnd))/samplecountroot;
				float r2 = (sy + random_nextfloat(rnd))/samplecountroot;
				float r2s = sqrt(r2);

				float3 d = u*(cos(r1)*r2s) + v*(sin(r1)*r2s) + n*sqrt(1.0f-r2);
				d = mNormalize(d);

				//Ray r = {
				//	p,
				//	d,
				//};
				Ray r;
				r.direction = d;
				r.origin = p;
//				hit_t h;
//				if (bvh_intersect(root, triangles, &r, &h)) {
//					float d = r.t * (1.0f / tmax);
//					float d2 = d*d;
//					float d4 = d2*d2;
//					f += 1.0f - d4*d4;
//				}
		        f += (float)shadowRay(&r, tmax, triangles, nodes);
			}
		}
	}
	while(rays > 0) {
		rays--;
		float r1 = 2.0f*PI*(random_nextfloat(rnd));
		float r2 = random_nextfloat(rnd);
		float r2s = sqrt(r2);

		float3 d = u*(cos(r1)*r2s) + v*(sin(r1)*r2s) + n*sqrt(1.0f-r2);
		d = mNormalize(d);
		Ray r;
		r.direction = d;
		r.origin = p;
		f += (float)shadowRay(&r, tmax, triangles, nodes);
	}
	f = 1.0f - f * (1.0f / (float)(c->ao_rays));
	return f;
}


__kernel
void Trace(         __global uchar4 * pixel,
					__global   cl_triangle * triangles,
					__global   cl_node * nodes,
					__global   cl_f3 * normals,
                    __global  cl_material * materials,
                    __constant int * seed,
                    __constant Constants* c)
{

	unsigned int x = get_global_id(0);
    unsigned int y = get_global_id(1);
	float fx = (float)x / (float)get_global_size(0) * 2.0f - 1.0f;
	float fy = (float)y / (float)get_global_size(1) * 2.0f - 1.0f;
	float t;
	float3 finalColor = (float3)(0.95f, 0.95f, 0.95f);
	//float3 lightPosition = (float3)(25.f, 150.f, 15.0f);
	//float3 lightPosition = (float3)(-20.f, 23.5f, 0.f);
	float3 lightPosition = (float3)(c->light_positionx, c->light_positiony, c->light_positionz);

	//printf("Trace %d,%d ",x,y);
	// Camera position
	float4 o = MatMulVec4(c->viewProjectionInverse, (float4)(fx, fy, 0.0f, 1.0f));
	o = o/o.w;
	// Pixel world position
	float4 r = MatMulVec4(c->viewProjectionInverse, (float4)(fx, fy, 1.0f, 1.0f));
	r = r/r.w;

	// Generate perspective correct ray
	float3 direction = mNormalize((r - o).xyz);

	Ray ray;
	ray.direction = direction;
	ray.origin = o.xyz;


	int triangleIndex;
	float3 hitPosition;
	float3 hitNormal;
	//int changeFace = 0;
	unsigned int intersections[3] = {0,0,0};
    int s = get_global_id(0);
    random_t rnd;
    random_init(&rnd, seed[(x%64) + (y%64)*64] + s*s);

	t = traceRay(	&ray,
					triangles,
					nodes,
					normals,
					&hitNormal,
					&hitPosition,
					&triangleIndex,
					intersections);


    if( t )
	{
        Ray lightVector;
		lightVector.origin = hitPosition+hitNormal;
		lightVector.direction = mNormalize(lightPosition - hitPosition);
        float shadowTmax = sqrt(dot(lightPosition - hitPosition,lightPosition - hitPosition));

        float occlusion_weight = 1;
		int sr = shadowRay(&lightVector, shadowTmax, triangles, nodes);


/*
            if (sr ) { // && (get_global_id(0)==TX) && (get_global_id(1)==TY) ) {
				printf("SR%d.%d\n",get_global_id(0),get_global_id(1));
				//printf("shadow\n");
			}
*/


        if(c->shadow && sr) {
            occlusion_weight = 0.5f;
        }
        if(c->oc) {
            occlusion_weight = occlusion_weight*ao_sample(nodes, triangles, hitNormal, hitPosition, &rnd, c);
        }
		//float3 triColor = (float3)(materials[triangles[triangleIndex].materialIdx].r, materials[triangles[triangleIndex].materialIdx].g, materials[triangles[triangleIndex].materialIdx].b,0);
		finalColor = shade(	ray.direction,
							lightVector.direction,
							hitNormal,
							materials,
							triangles[triangleIndex].materialIdx,
                            c->phong);
        finalColor = occlusion_weight*finalColor;
	}
	else
	{
		//printf("!R%d.%d\n",get_global_id(0),get_global_id(1));
	}

		pixel[y*get_global_size(0) + x] = (uchar4)((finalColor.x)*255.0f, (finalColor.y)*255.0f, (finalColor.z)*255.0f, 255);



	//bvh_intensity
	float3 RGB;
	RGB.x = mMin(intersections[0], 255);
	RGB.y = mMin(intersections[0] - RGB.x, 255);
	RGB.z = mMin(intersections[0] - RGB.y - RGB.x, 255);

	RGB.x = RGB.x - RGB.y;
	RGB.y = RGB.y - RGB.z;

    //pixel[y*get_global_size(0) + x] = (uchar4)(intersections[0], intersections[2], intersections[1], 255);
    //pixel[y*get_global_size(0) + x] = (uchar4)(0, intersections[0], 0, 255);

//	pixel[y*get_global_size(0) + x] = (uchar4)(RGB.z, RGB.y, RGB.x, 255);
	//traversalIntensity[y*get_global_size(0) + x] = intersections[0];
	//intersectionIntensity[y*get_global_size(0) + x] = intersections[1];

//	pixel[y*get_global_size(0) + x] = (uchar4)(ray.direction.x*255, ray.direction.y*255, ray.direction.z*255, 255);
//	pixel[y*get_global_size(0) + x] = (uchar4)(ray.origin.x*255, ray.origin.y*255, ray.origin.z*255, 255);
	//	pixel[y*get_global_size(0) + x] = (uchar4)(r.x*255, r.y*255, r.z*255, 255);
	//gg
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
