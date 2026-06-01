#define z3dbd1ff682 0

#define z12cbbf15c0					65535.0f
#define MIN min
#define MAX max
#define z121e64db3b sqrt
#define z09727749e1 pow
#define z93187ccfd7 exp2
#define zba5c6acf5c fabs
#ifndef z3dbd1ff682
#define z3dbd1ff682 0
#endif
#if ( z3dbd1ff682==3 )
float8 z07f76dfe04(float X,float16 z448a3dde4b,float16 ze7c57fc5f9,float16
z765d00e62f){if(X<=z448a3dde4b.s1)return(float8)(z448a3dde4b.s01,ze7c57fc5f9.s01
,z765d00e62f.s01,0.0f,0.0f);if(X<=z448a3dde4b.s2)return(float8)(z448a3dde4b.s12,
ze7c57fc5f9.s12,z765d00e62f.s12,0.0f,0.0f);if(X<=z448a3dde4b.s3)return(float8)(
z448a3dde4b.s23,ze7c57fc5f9.s23,z765d00e62f.s23,0.0f,0.0f);if(X<=z448a3dde4b.s4)
return(float8)(z448a3dde4b.s34,ze7c57fc5f9.s34,z765d00e62f.s34,0.0f,0.0f);if(X<=
z448a3dde4b.s5)return(float8)(z448a3dde4b.s45,ze7c57fc5f9.s45,z765d00e62f.s45,
0.0f,0.0f);if(X<=z448a3dde4b.s6)return(float8)(z448a3dde4b.s56,ze7c57fc5f9.s56,
z765d00e62f.s56,0.0f,0.0f);if(X<=z448a3dde4b.s7)return(float8)(z448a3dde4b.s67,
ze7c57fc5f9.s67,z765d00e62f.s67,0.0f,0.0f);if(X<=z448a3dde4b.s8)return(float8)(
z448a3dde4b.s78,ze7c57fc5f9.s78,z765d00e62f.s78,0.0f,0.0f);if(X<=z448a3dde4b.s9)
return(float8)(z448a3dde4b.s89,ze7c57fc5f9.s89,z765d00e62f.s89,0.0f,0.0f);if(X<=
z448a3dde4b.sa)return(float8)(z448a3dde4b.s9a,ze7c57fc5f9.s9a,z765d00e62f.s9a,
0.0f,0.0f);if(X<=z448a3dde4b.sb)return(float8)(z448a3dde4b.sab,ze7c57fc5f9.sab,
z765d00e62f.sab,0.0f,0.0f);if(X<=z448a3dde4b.sc)return(float8)(z448a3dde4b.sbc,
ze7c57fc5f9.sbc,z765d00e62f.sbc,0.0f,0.0f);if(X<=z448a3dde4b.sd)return(float8)(
z448a3dde4b.scd,ze7c57fc5f9.scd,z765d00e62f.scd,0.0f,0.0f);if(X<=z448a3dde4b.se)
return(float8)(z448a3dde4b.sde,ze7c57fc5f9.sde,z765d00e62f.sde,0.0f,0.0f);
return(float8)(z448a3dde4b.sef,ze7c57fc5f9.sef,z765d00e62f.sef,0.0f,0.0f);}float
 z9369a44638(float X,int zf71a2be2d9,float16 z448a3dde4b,float16 ze7c57fc5f9,
float16 z765d00e62f){
float8 z1fb3c58410=z07f76dfe04(X,z448a3dde4b,ze7c57fc5f9,z765d00e62f);float
zc180b9cdc9=z1fb3c58410.s0,za3584c0652=z1fb3c58410.s2,z16e127a2c9=z1fb3c58410.s4
;float z35bf29e99b=z1fb3c58410.s1,z1a6f4c4c08=z1fb3c58410.s3,z635f0a0757=
z1fb3c58410.s5;
float z52ab5b652a=z35bf29e99b-zc180b9cdc9;if(fabs(z52ab5b652a)<0.0001f)return((
za3584c0652+z1a6f4c4c08)+(X-zc180b9cdc9)*(z16e127a2c9+z635f0a0757))*0.5f;
float z56807b5599=(X-zc180b9cdc9)/z52ab5b652a;float z3e7daabbc6=z56807b5599-1.0f
;
float z99cf4fd6fe=z56807b5599*z56807b5599*(z1a6f4c4c08-za3584c0652)*(3.0f-2.0f*
z56807b5599)+za3584c0652;float z593fa3cb41=(z16e127a2c9*z3e7daabbc6+z635f0a0757*
z56807b5599)*z56807b5599*z3e7daabbc6*z52ab5b652a;float Y=z99cf4fd6fe+z593fa3cb41
;return Y;}
#endif
#if ( z3dbd1ff682==0 )
__kernel void z5a01a3b6f8(__global float4*zf8d9fd6cb8,__global float*z718a062ddd
,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int2 zf4b6f4e6d6){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;float4
z395b96baac=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];__global float*
z68e8e377e1=z718a062ddd+zaaf414d14e.x+(zba94ee46da.y+z30eaaf69b7.s1)*z9562068e13
;__global float*z6439dcde4e=z718a062ddd+zaaf414d14e.x+(zba94ee46da.y+zf4b6f4e6d6
.s0)*z9562068e13;__global float*ze8085abd9e=z718a062ddd+zaaf414d14e.x+(
zba94ee46da.y+zf4b6f4e6d6.s1)*z9562068e13;z68e8e377e1[0]=z395b96baac.s0;
z6439dcde4e[0]=z395b96baac.s1;ze8085abd9e[0]=z395b96baac.s2;}
#endif
#if ( z3dbd1ff682==1 )
__kernel void zcfafe1e63e(__global float4*zf8d9fd6cb8,__global float*z718a062ddd
,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int2 zf4b6f4e6d6){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;float4
z395b96baac;__global float*z68e8e377e1=z718a062ddd+zaaf414d14e.x+(zba94ee46da.y+
z30eaaf69b7.s1)*z9562068e13;__global float*z6439dcde4e=z718a062ddd+zaaf414d14e.x
+(zba94ee46da.y+zf4b6f4e6d6.s0)*z9562068e13;__global float*ze8085abd9e=
z718a062ddd+zaaf414d14e.x+(zba94ee46da.y+zf4b6f4e6d6.s1)*z9562068e13;z395b96baac
.s0=z68e8e377e1[0];z395b96baac.s1=z6439dcde4e[0];z395b96baac.s2=ze8085abd9e[0];
zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d]=z395b96baac;}
#endif
#if ( z3dbd1ff682==2 )
__kernel void zcfafe1e63e(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float2 ze0995e6531){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;
__global float*z395b96baac=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z2824fcf57d;
__global float*ze4351005bc=z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*z9562068e13;
const float z5b8c31c8e4=ze0995e6531.s0;const float z7e9b0c5db9=ze0995e6531.s1;
ze4351005bc[0]=z395b96baac[0]*z5b8c31c8e4-(z7e9b0c5db9);}
#endif
#if ( z3dbd1ff682==3 )
__kernel void zcfafe1e63e(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float16 z448a3dde4b,float16
ze7c57fc5f9,float16 z765d00e62f,int zf71a2be2d9){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;__global float*z395b96baac=zf8d9fd6cb8+
z83640e5796.x+z83640e5796.y*z2824fcf57d;__global float*ze4351005bc=z718a062ddd+
zaaf414d14e.x+zaaf414d14e.y*z9562068e13;ze4351005bc[0]=z9369a44638(z395b96baac[0
],zf71a2be2d9,z448a3dde4b,ze7c57fc5f9,z765d00e62f);}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
