#define MY_PIf 3.14159f
#define MY_2PIf 6.28319f
#define MY_1_PIf 0.31831f
#define MY_1_2PIf 0.159155f
#define RATGPU_TILE_WIDTH 256U
#define RATGPU_TILE_WIDTHi 256
#define RATGPU_TILE_HEIGHT 128U
#define RATGPU_TILE_HEIGHTi 128
#define RATGPU_TILE_SIZE 32768U
#define RATGPU_TILE_SIZEi 32768
#define RATGPU_RT_MAXDEPTH 64U
#define RATGPU_RTTEX_WIDTH 2048
#define RATGPU_RTTEX_HEIGHT 2048
#define RATGPU_RTTEX_HEIGHT_RHS 11
#define RATGPU_RTTEX_SIZE 4194304U
#define RATGPU_MAX_MATS 256U
#define RATGPU_WORK_WIDTH 16U
#define RATGPU_WORK_HEIGHT 8U
#define RATGPU_WORK_SIZE 128U
#define RATGPU_WORK_SIZEi 128
#ifndef OPENCL_NO_IMAGE_SUPPORT
    #ifdef OPENCL_ATI
        __constant sampler_t imgSamplerInt2 = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_NONE | CLK_FILTER_NEAREST;
    #else
        const sampler_t imgSamplerInt2 = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_NONE | CLK_FILTER_NEAREST;
    #endif
#endif

#define MYRESTRICT restrict

typedef struct tvec3
{
    float x, y, z;
}vec3;

inline float MyDot3 ( const float4 v1, const float4 v2 )
{
    return v1.x*v2.x + v1.y*v2.y + v1.z*v2.z;
}

bool tx_b ( const float4 xo, const float4 xd, const float xdi,
    const vec3 *MYRESTRICT pmi, const vec3 *MYRESTRICT pma,
    float *MYRESTRICT tmin, float *MYRESTRICT tmax )
{
	float ri = native_recip ( xd.x );
    float l1 = (pmi->x - xo.x) * ri;
	float l2 = (pma->x - xo.x) * ri;
	float lmin = min(l1,l2);
	float lmax = max(l1,l2);

    ri = native_recip ( xd.y );
	l1	= (pmi->y - xo.y) * ri;
	l2	= (pma->y - xo.y) * ri;
	lmin	= max(min(l1,l2), lmin);
	lmax	= min(max(l1,l2), lmax);

    ri = native_recip ( xd.z );
	l1	= (pmi->z - xo.z) * ri;
	l2	= (pma->z - xo.z) * ri;
	lmin	= max(min(l1,l2), lmin);
	lmax	= min(max(l1,l2), lmax);

	*tmin = max ( 0.0f, lmin );
	*tmax = lmax;

	return ( lmax>=-0.0f && lmax>=lmin && lmin<=xdi );
}

bool tx_s
(
    const __global float4 *MYRESTRICT pE1,
	const __global float4 *MYRESTRICT pE2,
	const __global float4 *MYRESTRICT pV0M,

    const int ti,

   	const float4 xo,
   	const float4 xd,

   	const float xdi
)
{
	const float4 s1 = cross(xd, pE2[ti]);
	const float divisor = MyDot3(s1, pE1[ti]);

	const float invDivisor = 1.0f / divisor;

	const float4 d = xo - pV0M[ti];
	const float b1 = MyDot3(d, s1) * invDivisor;

	const float4 s2 = cross(d, pE1[ti]);
	const float b2 = MyDot3(xd, s2) * invDivisor;

    const float b0 = 1.0f - b1 - b2;
	const float tt = MyDot3(pE2[ti], s2) * invDivisor;
	return ( b1>=-0.0f && b2>=-0.0f && b0>=-0.0f && tt>0.0f && tt<=xdi );
}

void tx_c
(
    const __global float4 *MYRESTRICT pE1,
	const __global float4 *MYRESTRICT pE2,
	const __global float4 *MYRESTRICT pV0M,

    const int ti,

   	const float4 xo,
   	const float4 xd,

   	float *MYRESTRICT xdi,
   	const size_t g1D,
   	__global float4 *MYRESTRICT ro
)
{
	const float4 s1 = cross(xd, pE2[ti]);
	const float divisor = MyDot3(s1, pE1[ti]);

	const float invDivisor = 1.0f / divisor;

	const float4 d = xo - pV0M[ti];
	const float b1 = MyDot3(d, s1) * invDivisor;

	const float4 s2 = cross(d, pE1[ti]);
	const float b2 = MyDot3(xd, s2) * invDivisor;

    const float b0 = 1.0f - b1 - b2;

	const float tt = MyDot3(pE2[ti], s2) * invDivisor;

	if ( b1>=-0.0f && b2>=-0.0f && b0>=-0.0f && tt>0.0f && tt<*xdi )
	{
	    ro[g1D] = (float4) ( b1, b2, tt, as_float(ti) );
        *xdi = tt;
    }
}

#ifdef OPENCL_NO_IMAGE_SUPPORT
    inline int2 rn ( const __global int4 *MYRESTRICT ss, const int idx, vec3 *MYRESTRICT pmi, vec3 *MYRESTRICT pma )
    {
        int2 res;
	    {
            const int4 val = ss[idx];
            pmi->x = as_float ( val.x );
            pmi->y = as_float ( val.y );
            pmi->z = as_float ( val.z );
            res.x = val.w;
        }

        {
            const int4 val = ss[idx+1];
            pma->x = as_float ( val.x );
            pma->y = as_float ( val.y );
            pma->z = as_float ( val.z );
            res.y = val.w;
        }

        return res;
    }

    inline int rrn ( const __global int4 *MYRESTRICT ss )
    {
        return ss[0].w;
    }
#else
    inline int2 rn ( __read_only image2d_t ss, const int idx, vec3 *MYRESTRICT pmi, vec3 *MYRESTRICT pma )
    {
	    int2 xy;
	    int2 res;

        xy.x = idx & (RATGPU_RTTEX_WIDTH-1);
        xy.y = idx >> RATGPU_RTTEX_HEIGHT_RHS;
        {
            const int4 val = read_imagei ( ss, imgSamplerInt2, xy );
            pmi->x = as_float ( val.x );
            pmi->y = as_float ( val.y );
            pmi->z = as_float ( val.z );
            res.x = val.w;
        }

        ++xy.x;
        {
            const int4 val = read_imagei ( ss, imgSamplerInt2, xy );
            pma->x = as_float ( val.x );
            pma->y = as_float ( val.y );
            pma->z = as_float ( val.z );
            res.y = val.w;
        }

        return res;
    }

    inline int rrn ( __read_only image2d_t ss )
    {
        return read_imagei ( ss, imgSamplerInt2, (int2)(0) ).w;
    }
#endif

float t_s
(
    const __global float4 *MYRESTRICT pE1,
    const __global float4 *MYRESTRICT pE2,
    const __global float4 *MYRESTRICT pV0M,

    #ifdef OPENCL_NO_IMAGE_SUPPORT
        const __global int4 *MYRESTRICT ss,
    #else
        __read_only image2d_t ss,
    #endif

    const float4 xo,
    const float4 xd,
    const float xdi,

    const size_t g1D,
    __global int2 *MYRESTRICT s
)
{
    int2 se = (int2)(rrn(ss),2);
    size_t cur = 0U;

    while ( true )
    {
        if ( se.x<0 )
        {
            float lmi, lma;
            int2 lse;
            bool l;
            {
                vec3 pmi, pma;
                lse = rn ( ss, se.y, &pmi, &pma );
                l = tx_b ( xo, xd, xdi, &pmi, &pma, &lmi, &lma );
            }

            float rmi, rma;
            int2 rse;
            bool r;
            {
                vec3 pmi, pma;
                rse = rn ( ss, se.y+2, &pmi, &pma );
                r = tx_b ( xo, xd, xdi, &pmi, &pma, &rmi, &rma );
            }

            if ( l )
            {
                if ( r )
                {
                    if ( lmi<rmi )
                    {
                        s[g1D+(cur*RATGPU_TILE_SIZE)] = rse;
                        se = lse;
                        ++cur;
                    }
                    else
                    {
                        if ( rmi<lmi )
                        {
                            s[g1D+(cur*RATGPU_TILE_SIZE)] = lse;
                            se = rse;
                            ++cur;
                        }
                        else
                        {
                            if ( lma < rma )
                            {
                                s[g1D+(cur*RATGPU_TILE_SIZE)] = rse;
                                se = lse;
                                ++cur;
                            }
                            else
                            {
                                s[g1D+(cur*RATGPU_TILE_SIZE)] = lse;
                                se = rse;
                                ++cur;
                            }
                        }
                    }
                }
                else
                {
                    se = lse;
                }
            }
            else
            {
                if ( r )
                {
                    se = rse;
                }
                else
                {
                    if ( 0U==cur ) return 0.0f;
                    --cur;
                    se = s[g1D+(cur*RATGPU_TILE_SIZE)];
                }
            }
        }
        else
        {
            int i;
            for ( i=se.y; i<=se.x; ++i )
            {
                if ( tx_s ( pE1, pE2, pV0M, i, xo, xd, xdi ) )
                {
                    return 1.0f;
                }
            }

            if ( 0U==cur ) return 0.0f;
            --cur;
            se = s[g1D+(cur*RATGPU_TILE_SIZE)];
        }
    }
}

void t_c
(
    const __global float4 *MYRESTRICT pE1,
    const __global float4 *MYRESTRICT pE2,
    const __global float4 *MYRESTRICT pV0M,

    #ifdef OPENCL_NO_IMAGE_SUPPORT
        const __global int4 *MYRESTRICT ss,
    #else
        __read_only image2d_t ss,
    #endif

    const float4 xo,
    const float4 xd,
    const float xdit,

    const size_t g1D,
    __global float4 *MYRESTRICT ro,

    __global int2 *MYRESTRICT s
)
{
    int2 se = (int2)(rrn(ss),2);
    size_t cur = 0U;
    float xdi = xdit;

    while ( true )
    {
        if ( se.x<0 )
        {
            float lmi, lma;
            int2 lse;
            bool l;
            {
                vec3 pmi, pma;
                lse = rn ( ss, se.y, &pmi, &pma );
                l = tx_b ( xo, xd, xdi, &pmi, &pma, &lmi, &lma );
            }

            float rmi, rma;
            int2 rse;
            bool r;
            {
                vec3 pmi, pma;
                rse = rn ( ss, se.y+2, &pmi, &pma );
                r = tx_b ( xo, xd, xdi, &pmi, &pma, &rmi, &rma );
            }

            if ( l )
            {
                if ( r )
                {
                    if ( lmi<rmi )
                    {
                        s[g1D+(cur*RATGPU_TILE_SIZE)] = rse;
                        se = lse;
                        ++cur;
                    }
                    else
                    {
                        if ( rmi<lmi )
                        {
                            s[g1D+(cur*RATGPU_TILE_SIZE)] = lse;
                            se = rse;
                            ++cur;
                        }
                        else
                        {
                            if ( lma<rma )
                            {
                                s[g1D+(cur*RATGPU_TILE_SIZE)] = rse;
                                se = lse;
                                ++cur;
                            }
                            else
                            {
                                s[g1D+(cur*RATGPU_TILE_SIZE)] = lse;
                                se = rse;
                                ++cur;
                            }
                        }
                    }
                }
                else
                {
                    se = lse;
                }
           }
           else
           {
                if ( r )
                {
                    se = rse;
                }
                else
                {
                    if ( 0U==cur ) return;
                    --cur;
                    se = s[g1D+(cur*RATGPU_TILE_SIZE)];
                }
            }
        }
        else
        {
            int i;
            for ( i=se.y; i<=se.x; ++i )
            {
                tx_c ( pE1, pE2, pV0M, i, xo, xd, &xdi, g1D, ro );
            }

            if ( 0U==cur ) return;
            --cur;
            se = s[g1D+(cur*RATGPU_TILE_SIZE)];
        }
    }
}


typedef struct tMaterial
{
    float diffColR, diffColG, diffColB, pad0;

    float emissColR, emissColG, emissColB, pad1;

    int isEmissive;
    int texO;
    float texW, texH;

    float texWM1, texHM1, pad2, pad3;

    float drrProbDiffuse;
    float drrProbReflect;
    float drrProbRefract;
    float drrRefractIdx;

    int GEFlag;
    float invGEP1, invGEP2;
    int pad4;

} Material;

typedef struct tParamBlock
{
    float cr, padC0, padC1, padC2;

    float4 vFovH, vFovV, farCenter;
    float4 invViewSizeMul2;
    float4 cp;

    float sceneBias;
    float sceneRad2;
    float sceneRad2MinBias;
    float icr;

    float aoAngleCos1;
    float aoAngleCos2;
    float aoAngleCos3;
    float aoMaxDist;

    float aoAngleUni1;
    float aoAngleUni2;
    float aoAngleUni3;
    float invNPPP;

    float4 backCol;

    Material mats[RATGPU_MAX_MATS];

} ParamBlock;

inline float4 TriLSOA ( const float4 v0, const float4 v1, const float4 v2, const vec3 *MYRESTRICT b, const float w )
{
    return (float4) ( v0.x*b->x + v0.y*b->y + v0.z*b->z,
                      v1.x*b->x + v1.y*b->y + v1.z*b->z,
	                  v2.x*b->x + v2.y*b->y + v2.z*b->z,
		              w );
}

inline float2 TriLSOAt ( const float4 v0, const float4 v1, const vec3 *MYRESTRICT b )
{
    return (float2) ( v0.x*b->x + v0.y*b->y + v0.z*b->z,
                      v1.x*b->x + v1.y*b->y + v1.z*b->z );
}

inline float4 TriLSOAb ( const float4 v0, const float4 v1, const float4 v2, const size_t l1D, __local float *MYRESTRICT loc, const float w )
{
    return (float4) ( v0.x*(1.0f-loc[l1D]-loc[l1D+RATGPU_WORK_SIZE]) + v0.y*loc[l1D] + v0.z*loc[l1D+RATGPU_WORK_SIZE],
                      v1.x*(1.0f-loc[l1D]-loc[l1D+RATGPU_WORK_SIZE]) + v1.y*loc[l1D] + v1.z*loc[l1D+RATGPU_WORK_SIZE],
	                  v2.x*(1.0f-loc[l1D]-loc[l1D+RATGPU_WORK_SIZE]) + v2.y*loc[l1D] + v2.z*loc[l1D+RATGPU_WORK_SIZE],
		              w );
}

float4 gp ( const __global uint *MYRESTRICT tdat, const float x, const float y, const float w, const float wMin1, const float h, const float hMin1 )
{
    const float xx = min ( max ( 0.0f, x ), wMin1 );
    const float yy = min ( max ( 0.0f, y ), hMin1 );

    const int off = (int)(yy*w+xx);
    const uint argb = *(tdat+off);

    const float inv255 = 1.0f/255.0f;
    return (float4) (
         (float)((argb&0x00FF0000U)>>16U) * inv255,
         (float)((argb&0x0000FF00U)>>8U)  * inv255,
         (float)(argb&0x000000FFU)        * inv255,
         1.0f );
}

float4 tf ( const __global uint *MYRESTRICT tdat, const float w, const float wM1, const float h, const float hM1, const float2 uv )
{
    float l_flIntX, l_flIntY;
    const float u_ratio = fabs ( modf ( uv.x, &l_flIntX ) );
    const float v_ratio = fabs ( modf ( uv.y, &l_flIntY ) );
    const float u_opposite = 1.0f - u_ratio;
    const float v_opposite = 1.0f - v_ratio;
    const float xx = u_ratio*(w-1.0f);
    const float yy = v_ratio*(h-1.0f);
    const float x = trunc(xx);
    const float y = trunc(yy);

    return ( gp(tdat,x,y,w,wM1,h,hM1)*u_opposite       + gp(tdat,x+1.0f,y,w,wM1,h,hM1)*u_ratio  ) * v_opposite +
           ( gp(tdat,x,y+1.0f,w,wM1,h,hM1)*u_opposite  + gp(tdat,x+1.0f,y+1.0f,w,wM1,h,hM1)*u_ratio) * v_ratio;
}

typedef struct tRI
{
    float4 t;
    float4 o;
}RI;

/*
    *********************************************************************************
    *********************************************************************************
    *********************************************************************************
*/
__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void p_s (
    const __global float4 *MYRESTRICT pE1,
	const __global float4 *MYRESTRICT pE2,
	const __global float4 *MYRESTRICT pV0M,

    #ifdef OPENCL_NO_IMAGE_SUPPORT
       const __global int4 *MYRESTRICT ss,
    #else
  	    __read_only image2d_t ss,
    #endif

    __global int2 *MYRESTRICT s,

	const __global RI *MYRESTRICT ri,
	__global float *MYRESTRICT ro )
{
    const size_t g1D = get_global_id(1U)*RATGPU_TILE_WIDTH + get_global_id(0U);

	float4 typeDir = ri[g1D].t;
    if ( typeDir.w>=-0.0f )
    {
        typeDir.w = 0.0f;

        float4 p = ri[g1D].o;
        float t = p.w;
        p.w = 0.0f;

        ro[g1D] = t_s ( pE1, pE2, pV0M, ss, p, typeDir, t, g1D, s );
    }
    else
    {
        ro[g1D] = -1.0f;
    }
}

__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void p_c (
    const __global float4 *MYRESTRICT pE1,
	const __global float4 *MYRESTRICT pE2,
	const __global float4 *MYRESTRICT pV0M,

    #ifdef OPENCL_NO_IMAGE_SUPPORT
       const __global int4 *MYRESTRICT ss,
    #else
  	    __read_only image2d_t ss,
    #endif

    __global int2 *MYRESTRICT s,

	const __global RI *MYRESTRICT ri,
	__global float4 *MYRESTRICT ro )
{
    const size_t g1D = get_global_id(1U)*RATGPU_TILE_WIDTH + get_global_id(0U);
	ro[g1D] = (float4)(-1.0f);

    float4 typeDir = ri[g1D].t;
    if ( typeDir.w>=-0.0f )
    {
        typeDir.w = 0.0f;

        float4 p = ri[g1D].o;
        const float t = p.w;
        ro[g1D] = (float4) ( -1.0f, -1.0f, t, as_float(-1) );
        p.w = 0.0f;

        t_c ( pE1, pE2, pV0M, ss, p, typeDir, t, g1D, ro, s );
    }
}

/*
    *********************************************************************************
    *********************************************************************************
    *********************************************************************************
*/
__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void f_n_A
(
    const __constant ParamBlock *MYRESTRICT PB,

    const float4 tXY,

   __global RI *MYRESTRICT ri
)
{
    const int x = (int)get_global_id(0U);
	const int y = (int)get_global_id(1U);
    const int g1D = y*RATGPU_TILE_WIDTHi + x;

	float2 xy = (float2) ( ((float)x) + tXY.x, ((float)y) + tXY.y );
	if ( xy.x<=PB->invViewSizeMul2.x && xy.y<=PB->invViewSizeMul2.y )
	{
	    xy *= PB->invViewSizeMul2.zw;
	    xy -= (float2)(1.0f);

	    const float4 ptf = PB->vFovH*xy.x + PB->vFovV*xy.y + PB->farCenter;
	    ri[g1D].t = normalize ( ptf - PB->cp );
        ri[g1D].o = (float4) ( PB->cp.x, PB->cp.y, PB->cp.z, PB->cr );
    }
    else
    {
        ri[g1D].t = (float4)(-1.0f);
    }
}

__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void f_n_B
(
    const __constant ParamBlock *MYRESTRICT PB,

    const __global float4 *MYRESTRICT n0,
	const __global float4 *MYRESTRICT n1,
	const __global float4 *MYRESTRICT n2,

   __global float4 *MYRESTRICT outImg,

    const __global float4 *MYRESTRICT xro
)
{
    const size_t g1D = get_global_id(1U)*RATGPU_TILE_WIDTH + get_global_id(0U);

    const float4 ro = xro[g1D];
    if ( ro.x>=-0.0f )
	{
        vec3 b;
        b.x = 1.0f - ro.x - ro.y;
        b.y = ro.x;
        b.z = ro.y;

        const int hti = as_int(ro.w);

        float4 hn = TriLSOA ( n0[hti], n1[hti], n2[hti], &b, 0.0f );

        hn = normalize(hn)*0.5f + 0.5f;
        hn.w = 1.0f;
        outImg[g1D] = hn;
    }
    else
    {
    	outImg[g1D] = PB->backCol;
    }
}

/*
    *********************************************************************************
    *********************************************************************************
    *********************************************************************************
*/
__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void f_m_A
(
    const __constant ParamBlock *MYRESTRICT PB,

    const float4 tXY,

   __global RI *MYRESTRICT ri
)
{
    const int x = (int)get_global_id(0U);
	const int y = (int)get_global_id(1U);
    const int g1D = y*RATGPU_TILE_WIDTHi + x;

	float2 xy = (float2) ( ((float)x) + tXY.x, ((float)y) + tXY.y );
	if ( xy.x<=PB->invViewSizeMul2.x && xy.y<=PB->invViewSizeMul2.y )
	{
        xy *= PB->invViewSizeMul2.zw;
	    xy -= (float2)(1.0f);

	    const float4 ptf = PB->vFovH*xy.x + PB->vFovV*xy.y + PB->farCenter;
	    ri[g1D].t = normalize ( ptf - PB->cp );
        ri[g1D].o = (float4) ( PB->cp.x, PB->cp.y, PB->cp.z, PB->cr );
    }
    else
    {
        ri[g1D].t = (float4)(-1.0f);
    }
}

__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void f_m_B
(
    const __constant ParamBlock *MYRESTRICT PB,

    const __global float4 *MYRESTRICT pV0M,
    const __global float4 *MYRESTRICT n0,
	const __global float4 *MYRESTRICT n1,
	const __global float4 *MYRESTRICT n2,
    const __global float4 *MYRESTRICT t0,
	const __global float4 *MYRESTRICT t1,

	const __global uint *tex,

    __global float4 *MYRESTRICT outImg,

    const __global float4 *MYRESTRICT xro
)
{
    const size_t g1D = get_global_id(1U)*RATGPU_TILE_WIDTH + get_global_id(0U);

    const float4 ro = xro[g1D];
    if ( ro.x>=-0.0f )
	{
	     const int hti = as_int ( ro.w );
         const int hma = as_int ( pV0M[hti].w );

         float4 mCol = (float4)(1.0f);
         if ( PB->mats[hma].texO>0 )
         {
            vec3 b;
            b.x = 1.0f - ro.x - ro.y;
            b.y = ro.x;
            b.z = ro.y;

            const float2 uv = TriLSOAt ( t0[hti], t1[hti], &b );
            mCol *= tf ( tex+PB->mats[hma].texO, PB->mats[hma].texW, PB->mats[hma].texWM1, PB->mats[hma].texH, PB->mats[hma].texHM1, uv );
        }

         mCol.x *= PB->mats[hma].diffColR;
         mCol.y *= PB->mats[hma].diffColG;
         mCol.z *= PB->mats[hma].diffColB;

         outImg[g1D] = mCol;
    }
    else
    {
	    outImg[g1D] = PB->backCol;
    }
}

__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void f_d_A
(
    const __constant ParamBlock *MYRESTRICT PB,

    const float4 tXY,

   __global RI *MYRESTRICT ri
)
{
    const int x = (int)get_global_id(0U);
	const int y = (int)get_global_id(1U);
    const int g1D = y*RATGPU_TILE_WIDTHi + x;

	float2 xy = (float2) ( ((float)x) + tXY.x, ((float)y) + tXY.y );
	if ( xy.x<=PB->invViewSizeMul2.x && xy.y<=PB->invViewSizeMul2.y )
	{
        xy *= PB->invViewSizeMul2.zw;
	    xy -= (float2)(1.0f);

	    const float4 ptf = PB->vFovH*xy.x + PB->vFovV*xy.y + PB->farCenter;
	    ri[g1D].t = normalize ( ptf - PB->cp );
        ri[g1D].o = (float4) ( PB->cp.x, PB->cp.y, PB->cp.z, PB->cr );
    }
    else
    {
        ri[g1D].t = (float4)(-1.0f);
    }
}

__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void f_d_B
(
    const __constant ParamBlock *MYRESTRICT PB,

    const __global float4 *MYRESTRICT xro,

   __global float4 *MYRESTRICT outImg
)
{
	const size_t g1D = get_global_id(1U)*RATGPU_TILE_WIDTH + get_global_id(0U);

    const float4 ro = xro[g1D];
    if ( ro.x>=-0.0f )
	{
        const float d = max ( 0.0f, min ( 1.0f, ro.z*PB->icr ) );
        outImg[g1D] = (float4)(d,d,d,1.0f);
    }
    else
    {
	    outImg[g1D] = PB->backCol;
    }
}

/*
    *********************************************************************************
    *********************************************************************************
    *********************************************************************************
*/
#define LCG_A 1664525u
#define LCG_C 1013904223u
#define BIGNN 1.0f / ((float)0x01000000)

inline uint lcg ( uint *MYRESTRICT prev )
{
    uint res = *prev;
    res = (LCG_A * res) + LCG_C;
    *prev = res;
    return (res & 0x00FFFFFF);
}

inline float myr ( uint *MYRESTRICT prev )
{
    return ((float)lcg(prev)) * BIGNN;
}


inline void c_s_h ( const float r1, const float r2, const float aoAngle1, const float aoAngle2, float4 *MYRESTRICT res )
{
    const float lc_flSinMaxSqR2 = aoAngle1 * native_sqrt(r2);
    const float pi2r1 = MY_2PIf * r1;

    *res = (float4) ( native_sqrt ( max ( 0.0f, 1.0f-r2*aoAngle2 ) ),
                      native_sin(pi2r1) * lc_flSinMaxSqR2,
                      native_cos(pi2r1) * lc_flSinMaxSqR2,
                      0.0f );
}

inline void ctb ( const float4 n, float4 *MYRESTRICT t, float4 *MYRESTRICT b )
{
	*b = ( fabs(n.x) >= fabs(n.z) ) ? (float4)(-n.y, n.x, 0.0f, 0.0f) : (float4)( 0.0f, -n.z, n.y, 0.0f );
	*b = fast_normalize ( *b );
	*t = cross(*b,n);
}

__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void f_a_i_A
(
    const __constant ParamBlock *MYRESTRICT PB,

    const float4 tXY,

    __global uint *MYRESTRICT se,

    __global RI *MYRESTRICT ri,

    __global float2 *MYRESTRICT oa
)
{
    const int x = (int)get_global_id(0U);
	const int y = (int)get_global_id(1U);
    const int g1D = y*RATGPU_TILE_WIDTHi + x;

	if ( 0.0f==tXY.z )
    {
        oa[g1D] = (float2)(0.0f);
    }

    float2 xy = (float2) ( ((float)x) + tXY.x, ((float)y) + tXY.y );
    {
        uint s = se[g1D];
        const float r1 = myr(&s)*2.0f - 1.0f;
        const float r2 = myr(&s)*2.0f - 1.0f;
        se[g1D] = s;
        xy.x += r1*0.5f;
        xy.y += r2*0.5f;
    }

	if ( xy.x<=PB->invViewSizeMul2.x && xy.y<=PB->invViewSizeMul2.y )
	{
	    xy *= PB->invViewSizeMul2.zw;
	    xy -= (float2)(1.0f);

	    const float4 ptf = PB->vFovH*xy.x + PB->vFovV*xy.y + PB->farCenter;
	    ri[g1D].t = normalize ( ptf - PB->cp );
	    ri[g1D].o = (float4) ( PB->cp.x, PB->cp.y, PB->cp.z, PB->cr );
    }
    else
    {
        ri[g1D].t = (float4)(-1.0f);
    }
}

__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void f_a_i_B
(
    const __constant ParamBlock *MYRESTRICT PB,

    const __global float4 *MYRESTRICT n0,
	const __global float4 *MYRESTRICT n1,
	const __global float4 *MYRESTRICT n2,

    const __global RI *MYRESTRICT iri,
    __global float4 *MYRESTRICT op,
    __global float4 *MYRESTRICT on,
    __global float2 *MYRESTRICT oa,

    const __global float4 *MYRESTRICT xro
)
{
    const size_t g1D = get_global_id(1U)*RATGPU_TILE_WIDTH + get_global_id(0U);

	const float4 ro = xro[g1D];
	if ( ro.x>=-0.0f )
	{
	    oa[g1D].y += 1.0f;
	    op[g1D] = PB->cp + (iri[g1D].t*ro.z);

        vec3 b;
        b.x = 1.0f - ro.x - ro.y;
        b.y = ro.x;
        b.z = ro.y;

        const int hti = as_int(ro.w);
        on[g1D] = fast_normalize ( TriLSOA ( n0[hti], n1[hti], n2[hti], &b, 0.0f ) );
    }
    else
    {
        on[g1D] = (float4) ( 0.0f, 0.0f, 0.0f, -1.0f );
    }
}

__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void f_a_a_A
(
    const __constant ParamBlock *MYRESTRICT PB,

    const float4 tXY,

    __global uint *MYRESTRICT se,

    const __global float4 *MYRESTRICT ipp,
    const __global float4 *MYRESTRICT inn,

   __global RI *MYRESTRICT ri
)
{
	const size_t g1D = get_global_id(1U)*RATGPU_TILE_WIDTH + get_global_id(0U);

    const float4 hn = inn[g1D];
	if ( hn.w>=0.0f )
    {
		uint s = se[g1D];
        const float r1 = ( tXY.x + myr(&s) ) * tXY.z;
        const float r2 = ( tXY.y + myr(&s) ) * tXY.w;
        se[g1D] = s;

        float4 d;
        c_s_h ( r1, r2, PB->aoAngleCos1, PB->aoAngleCos2, &d );

        float4 t, b;
		ctb ( hn, &t, &b );

		d = fast_normalize ( hn*d.x + t*d.y + b*d.z );

        ri[g1D].t = d;

        const float4 p = ipp[g1D] + ( d*PB->sceneBias );
        ri[g1D].o = (float4) ( p.x, p.y, p.z, PB->aoMaxDist );
	}
	else
	{
	    ri[g1D].t = (float4)(-1.0f);
	}
}

__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void f_a_a_B
(
    __global float2 *MYRESTRICT a,
    const __global float *MYRESTRICT iro
)
{
    const size_t g1D = get_global_id(1U)*RATGPU_TILE_WIDTH + get_global_id(0U);
    if ( iro[g1D]>0.0f )
	{
	    a[g1D].x += 1.0f;
	}
}

__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void f_a_f
(
    const __constant ParamBlock *MYRESTRICT PB,

    const float4 tXY,

    const __global float2 *MYRESTRICT ina,
   __global float4 *MYRESTRICT outBuf

)
{
	const size_t g1D = get_global_id(1U)*RATGPU_TILE_WIDTH + get_global_id(0U);

	float2 at = ina[g1D];
    if ( at.y>0.0f )
    {
        at *= tXY.x;

        at.x = 1.0f - max ( 0.0f, min(1.0f,at.x) );
        at.y = max ( 0.0f, min(1.0f,at.y) );

        outBuf[g1D] = (float4)(at.x, at.x, at.x, at.y);
    }
    else
    {
        outBuf[g1D] = PB->backCol;
    }
}


/*
    *********************************************************************************
    *********************************************************************************
    *********************************************************************************
*/

inline float4 c_s_h180 ( const float r1, const float r2 )
{
    const float pi2r1 = MY_2PIf * r1;

    const float lc_flOneMinR2 = max ( 0.0f, 1.0f-r2 );
    const float lc_flSqFactor = native_sqrt(lc_flOneMinR2);

    return (float4) ( native_sqrt(r2),
                      native_sin(pi2r1)*lc_flSqFactor,
                      native_cos(pi2r1)*lc_flSqFactor,
                      0.0f );
}

inline float4 c_sg_h ( const float r1, const float r2, const float a, const float b )
{
    const float pi2r1 = MY_2PIf * r1;

    const float lc_flOneMinR2 = max ( 0.0f, 1.0f-native_powr(r2,b) );
    const float lc_flSqOneMsb = native_sqrt ( lc_flOneMinR2 );

    return (float4) ( native_powr ( r2, a ),
                      native_sin(pi2r1) * lc_flSqOneMsb,
                      native_cos(pi2r1) * lc_flSqOneMsb,
                      0.0f );
}

inline float4 Reflect ( const float4 n, const float4 l )
{
    float4 ret = l - (n*2.0f*dot(n,l));
    ret.w = 0.0f;
    return fast_normalize ( ret );
}

float4 myBDRF_Diffuse ( const float4 n, const float4 l, uint *MYRESTRICT s )
{
    const float r1 = myr ( s );
    const float r2 = myr ( s );

    const float4 d = c_s_h180 ( r1, r2 );

    float4 t, b;
    ctb ( n, &t, &b );

	float4 ret = fast_normalize ( n*d.x + t*d.y + b*d.z );
	ret.w = 0.0f;

    return ret;
}

float4 myBDRF_Reflect ( float4 n, const float4 l, const __constant Material *MYRESTRICT mat, uint *MYRESTRICT s )
{
    const float4 refl = Reflect ( n, l );

    if ( mat->GEFlag!=0 )
    {
        const float r1 = myr ( s );
        const float r2 = myr ( s );

        const float4 d = c_sg_h ( r1, r2, mat->invGEP1, mat->invGEP2 );

        float4 t, b;
        ctb ( refl, &t, &b );

	    float4 ret = fast_normalize ( refl*d.x + t*d.y + b*d.z );
	    ret.w = 0.0f;
	    return ret;
    }
    return refl;
}

float4 myBDRF_Dielectric ( const float4 n, const float4 l, const __constant Material *MYRESTRICT mat, uint *MYRESTRICT s )
{
    #if 0
        /* This code causes problems on ATIs */
        float coef;
        float nL, nTransmission;

        float cosRho1 = dot(n,l);
        bool outsideToInside;
        if ( cosRho1>=0.0f )
        {
            outsideToInside = false;

            cosRho1 = dot(-n,l);

            nL = mat->drrRefractIdx;
            nTransmission = 1.0f;
        }
        else
        {
            outsideToInside = true;
            nL = 1.0f;
            nTransmission = mat->drrRefractIdx;
        }
        coef = nL/nTransmission;

        float cosRho2 = coef*coef*(1.0f-cosRho1*cosRho1);
        if ( cosRho2>1.0f )
        {
            return Reflect(n,l);
        }


        cosRho2 = native_sqrt ( max(0.0f,1.0f-cosRho2) );

        float4 tdir;
        if ( outsideToInside )
        {
            tdir = (l*coef) - n*( coef*cosRho1 + cosRho2 );
        }
        else
        {
            tdir = (l*coef) + n*( coef*cosRho1 + cosRho2 );
        }
        tdir = fast_normalize(tdir);

        const float a=nTransmission-nL, b=nTransmission+nL, R0=(a*a)/(b*b);
        const float c = 1.0f - ( (into)?-cosRho1:dot(tdir,n) );
        float Re = R0 + ((1.0f-R0)*c*c*c*c*c);
    #else
        const float4 nl = (dot(n,l)<0.0f) ? n : -n;

        const bool into = (dot(n,nl)>=0.0f); /* Ray from outside going in? */
        const float nc=1.0f, nt=mat->drrRefractIdx, nnt=(into)?nc/nt:nt/nc, ddn=dot(l,nl);

        float cos2t = nnt*nnt*(1.0f-ddn*ddn);

        float4 tdir;
        if ( cos2t>1.0f )
        {
            /* TIR */
            tdir = Reflect(nl,l);
        }
        else
        {
            cos2t = native_sqrt ( max(0.0f,1.0f-cos2t) );
            tdir = (l*nnt) - nl*(ddn*nnt+cos2t);
            tdir = fast_normalize ( tdir );
        }

        const float a=nt-nc, b=nt+nc, R0=(a*a)/(b*b), c = 1.0f-((into)?-ddn:dot(tdir,n));
        float Re = R0 + ((1.0f-R0)*c*c*c*c*c);
    #endif

    Re = max(0.0f, min(1.0f,Re) );
    const float PRefl = Re*0.75f + 0.25f;
    if ( myr(s)<PRefl )
    {
        return Reflect(n,l);
    }
    return tdir;
}

float4 myBDRF ( const float4 n, const float4 l, const __constant Material *MYRESTRICT mat, uint *MYRESTRICT s )
{
    const float r = myr(s);

    if ( r < mat->drrProbDiffuse )
    {
        return myBDRF_Diffuse ( n, l, s );
    }
    else
    {
        if ( r < mat->drrProbDiffuse + mat->drrProbReflect )
        {
            return myBDRF_Reflect ( n, l, mat, s );
        }
        return myBDRF_Dielectric ( n, l, mat, s );
    }
}

__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void f_p_i_A
(
    const __constant ParamBlock *MYRESTRICT PB,

    const float4 tXY,

    __global uint *MYRESTRICT se,

    __global RI *MYRESTRICT outRI
)
{
	const int x = (int)get_global_id(0U);
	const int y = (int)get_global_id(1U);
    const int g1D = y*RATGPU_TILE_WIDTHi + x;

	float2 xy = (float2) ( ((float)x) + tXY.x, ((float)y) + tXY.y );
    {
        uint s = se[g1D];
        const float r1 = myr(&s)*2.0f - 1.0f;
        const float r2 = myr(&s)*2.0f - 1.0f;
        se[g1D] = s;
        xy.x += r1*0.5f;
        xy.y += r2*0.5f;
    }

	if ( xy.x<=PB->invViewSizeMul2.x && xy.y<=PB->invViewSizeMul2.y )
	{
	    xy *= PB->invViewSizeMul2.zw;
	    xy -= (float2)(1.0f);

	    const float4 ptf = PB->vFovH*xy.x + PB->vFovV*xy.y + PB->farCenter;
	    outRI[g1D].t = normalize ( ptf - PB->cp );
	    outRI[g1D].o = (float4) ( PB->cp.x, PB->cp.y, PB->cp.z, PB->cr );
    }
    else
    {
        outRI[g1D].t = (float4)(-1.0f);
    }
}

__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void f_p_i_B
(
    const __constant ParamBlock *MYRESTRICT PB,

    const float4 tXY,

    __global float4 *MYRESTRICT op,
    __global float4 *MYRESTRICT od,
    __global float4 *MYRESTRICT opc,
    __global float4 *MYRESTRICT ofc,

    const __global RI *MYRESTRICT ri,
    const __global float4 *MYRESTRICT iro
)
{
	const size_t g1D = get_global_id(1U)*RATGPU_TILE_WIDTH + get_global_id(0U);

    if ( 0.0f==tXY.z )
    {
        ofc[g1D] = (float4)(0.0f);
    }

    const float4 ro = iro[g1D];
    if ( ro.x>=-0.0f )
    {
        ofc[g1D].w += 1.0f;
        opc[g1D] = (float4)(1.0f);

	    od[g1D] = ri[g1D].t;
        op[g1D] = PB->cp;
    }
}

__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void f_p_a
(
    const __constant ParamBlock *MYRESTRICT PB,

    const __global float4 *MYRESTRICT v0m,
	const __global float4 *MYRESTRICT n0,
	const __global float4 *MYRESTRICT n1,
	const __global float4 *MYRESTRICT n2,
    const __global float4 *MYRESTRICT t0,
	const __global float4 *MYRESTRICT t1,

	const __global uint *tex,

    __global uint *MYRESTRICT s,

    __global float4 *MYRESTRICT p,
    __global float4 *MYRESTRICT d,

    __global float4 *MYRESTRICT pc,
    __global float4 *MYRESTRICT fc,

    __global RI *MYRESTRICT ri,

     const __global float4 *MYRESTRICT iro
)
{
    const size_t g1D = get_global_id(1U)*RATGPU_TILE_WIDTH + get_global_id(0U);
    __local float loc [ RATGPU_WORK_SIZE*3U ];

    const float4 ro = iro[g1D];
    if ( ro.x>=-0.0f )
    {
        const int hti = as_int ( ro.w );
        const int hma = as_int ( v0m[hti].w );

        float4 mCol = (float4)(1.0f);
        if ( PB->mats[hma].texO>0 )
        {
            vec3 b;
            b.x = 1.0f - ro.x - ro.y;
            b.y = ro.x;
            b.z = ro.y;

            const float2 uv = TriLSOAt ( t0[hti], t1[hti], &b );
            mCol *= tf ( tex+PB->mats[hma].texO, PB->mats[hma].texW, PB->mats[hma].texWM1, PB->mats[hma].texH, PB->mats[hma].texHM1, uv );
        }

        if ( PB->mats[hma].isEmissive!=0 )
        {
            fc[g1D].x += pc[g1D].x * mCol.x * PB->mats[hma].emissColR;
            fc[g1D].y += pc[g1D].y * mCol.y * PB->mats[hma].emissColG;
            fc[g1D].z += pc[g1D].z * mCol.z * PB->mats[hma].emissColB;

            ri[g1D].t = (float4)(-1.0f);
        }
        else
        {
            pc[g1D].x *= mCol.x * PB->mats[hma].diffColR;
            pc[g1D].y *= mCol.y * PB->mats[hma].diffColG;
            pc[g1D].z *= mCol.z * PB->mats[hma].diffColB;

            float4 hn;
            {
                const size_t l1D = get_local_id(1U)*RATGPU_WORK_WIDTH + get_local_id(0U);
                loc[l1D] = ro.x;
                loc[l1D+RATGPU_WORK_SIZE] = ro.y;

                hn = fast_normalize ( TriLSOAb ( n0[hti], n1[hti], n2[hti], l1D, loc, 0.0f ) );
            }

            float4 xd = d[g1D];

            {
                const size_t l1D = get_local_id(1U)*RATGPU_WORK_WIDTH + get_local_id(0U);
                loc[l1D] = p[g1D].x + (xd.x*ro.z);
                loc[l1D+RATGPU_WORK_SIZE] = p[g1D].y + (xd.y*ro.z);
                loc[l1D+(RATGPU_WORK_SIZE<<1U)] = p[g1D].z + (xd.z*ro.z);
            }

            uint se = s[g1D];
            xd = myBDRF ( hn, xd, PB->mats+hma, &se );
            s[g1D] = se;
            d[g1D].x = xd.x;
            d[g1D].y = xd.y;
            d[g1D].z = xd.z;

            {
                const size_t l1D = get_local_id(1U)*RATGPU_WORK_WIDTH + get_local_id(0U);
                loc[l1D] += xd.x*PB->sceneBias;
                loc[l1D+RATGPU_WORK_SIZE] += xd.y*PB->sceneBias;
                loc[l1D+(RATGPU_WORK_SIZE<<1U)] += xd.z*PB->sceneBias;

                p[g1D].x = loc[l1D];
                p[g1D].y = loc[l1D+RATGPU_WORK_SIZE];
                p[g1D].z = loc[l1D+(RATGPU_WORK_SIZE<<1U)];
            }

            ri[g1D].t = xd;

            const size_t l1D = get_local_id(1U)*RATGPU_WORK_WIDTH + get_local_id(0U);
            ri[g1D].o = (float4) ( loc[l1D], loc[l1D+RATGPU_WORK_SIZE], loc[l1D+(RATGPU_WORK_SIZE<<1U)], PB->sceneRad2 );
        }
    }
    else
    {
        ri[g1D].t = (float4)(-1.0f);
    }
}

__kernel __attribute__((reqd_work_group_size(RATGPU_WORK_WIDTH,RATGPU_WORK_HEIGHT,1)))
void f_p_f
(
    const __constant ParamBlock *MYRESTRICT PB,

    const __global float4 *MYRESTRICT ifct,

   __global float4 *MYRESTRICT ofc
)
{
	const size_t g1D = get_global_id(1U)*RATGPU_TILE_WIDTH + get_global_id(0U);

    float4 fct = ifct[g1D];
	if ( fct.w>0.0f )
    {
        fct *= PB->invNPPP;
        ofc[g1D] = clamp ( fct, 0.0f, 1.0f );
    }
    else
    {
        ofc[g1D] = PB->backCol;
    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
