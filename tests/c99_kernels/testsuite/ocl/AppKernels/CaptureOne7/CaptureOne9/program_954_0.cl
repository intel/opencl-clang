#define zbc6516e8d5  0
#define zdbe1efdb26  0
#define z93a6893130 8

#ifndef zbc6516e8d5
#define zbc6516e8d5 1
#endif
#ifndef z93a6893130
#define z38c913a03a 0
#else
#define z38c913a03a z93a6893130
#endif
float z6d7333005c(float16 z2dd09f3226,float16 za3158292ce){
#if   (z38c913a03a==16)
return dot(z2dd09f3226.s0123,za3158292ce.s0123)+dot(z2dd09f3226.s4567,
za3158292ce.s4567)+dot(z2dd09f3226.s89ab,za3158292ce.s89ab)+dot(z2dd09f3226.
scdef,za3158292ce.scdef);
#elif (z38c913a03a>10)
return dot(z2dd09f3226.s0123,za3158292ce.s0123)+dot(z2dd09f3226.s4567,
za3158292ce.s4567)+dot(z2dd09f3226.s89ab,za3158292ce.s89ab);
#elif (z38c913a03a>8)
return dot(z2dd09f3226.s0123,za3158292ce.s0123)+dot(z2dd09f3226.s4567,
za3158292ce.s4567)+dot(z2dd09f3226.s89,za3158292ce.s89);
#elif (z38c913a03a>6)
return dot(z2dd09f3226.s0123,za3158292ce.s0123)+dot(z2dd09f3226.s4567,
za3158292ce.s4567);
#elif (z38c913a03a>4)
return dot(z2dd09f3226.s0123,za3158292ce.s0123)+dot(z2dd09f3226.s45,za3158292ce.
s45);
#elif (z38c913a03a>2)
return dot(z2dd09f3226.s0123,za3158292ce.s0123);
#elif (z38c913a03a>0)
return dot(z2dd09f3226.s01,za3158292ce.s012);
#endif
return 0.0f;}__kernel void z417133f7e8(__global ushort4*zf8d9fd6cb8,__global
ushort4*z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,__global
float*z3ad6f7586a,int4 z5208a911f3,float4 z3c211c8179,float8 ze7168fc0b9
#if zbc6516e8d5
,__constant ushort4*zad841da1f7,__local float*z01612e015a,__local ushort*
zd6906769c1
#else
,__constant ushort*zad841da1f7
#endif
#if (z38c913a03a>0)
,__global uchar*zec145e35cf,int16 z7f76fb323c,int4 z3576e84f20,float16
z4af71b4d47
#endif
){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));bool zc80cdffc13=(
zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3+8);bool zdfd2b18d8e
=(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3);int2 z83640e5796
=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int2
zdc2396006d=zba94ee46da+z5208a911f3.s01;
#if zbc6516e8d5

zd6906769c1[1024]=30339;zd6906769c1[1025]=30375;int z8b1bb737a4=get_local_id(0)+
get_local_size(0)*get_local_id(1);if(z8b1bb737a4<256){



ushort4 z305d891f1d=zad841da1f7[z8b1bb737a4];zd6906769c1[4*z8b1bb737a4]=
z305d891f1d.s0;zd6906769c1[4*z8b1bb737a4+1]=z305d891f1d.s1;zd6906769c1[4*
z8b1bb737a4+2]=z305d891f1d.s2;zd6906769c1[4*z8b1bb737a4+3]=z305d891f1d.s3;}
#else
__constant ushort*zd6906769c1=zad841da1f7;
#endif
#if zbc6516e8d5
int z47728d2efe=get_local_size(1);int z3902475141=get_local_size(0);int
z62a8006ca5=(z47728d2efe+2*4);
int zc9d655d235=zdc2396006d.x+zdc2396006d.y*z5208a911f3.z;int z38a89f6944=
get_local_id(1);int zb3ec2e5425=z5208a911f3.z;__local float*zf485e5e12c=
z01612e015a+get_local_id(0)*z62a8006ca5+4;int ze12af1c5cf=z38a89f6944;if(!
zc80cdffc13)zf485e5e12c[ze12af1c5cf]=z3ad6f7586a[zc9d655d235];if(z38a89f6944<4&&
!zc80cdffc13)zf485e5e12c[ze12af1c5cf-4]=z3ad6f7586a[zc9d655d235-zb3ec2e5425*4];
if(z38a89f6944>=z47728d2efe-4&&!zc80cdffc13)zf485e5e12c[ze12af1c5cf+4]=
z3ad6f7586a[zc9d655d235+zb3ec2e5425*4];
int z8ea92fe60a=1;barrier(CLK_LOCAL_MEM_FENCE);
#else
int z8ea92fe60a=z5208a911f3.z;int z38a89f6944=zdc2396006d.x+zdc2396006d.y*
z5208a911f3.z;__global float*zf485e5e12c=z3ad6f7586a;
#endif
if(zdfd2b18d8e)return;ushort4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.
y*z2824fcf57d];float z55c265223f=z3c211c8179.x;float z2e83c0ac43=z3c211c8179.y;
float z37a59f57c4=z3c211c8179.z;



float z52ab5b652a;z52ab5b652a=ze7168fc0b9.s4*zf485e5e12c[z38a89f6944];
z52ab5b652a+=ze7168fc0b9.s3*(zf485e5e12c[z38a89f6944-z8ea92fe60a]+zf485e5e12c[
z38a89f6944+z8ea92fe60a]);z52ab5b652a+=ze7168fc0b9.s2*(zf485e5e12c[z38a89f6944-2
*z8ea92fe60a]+zf485e5e12c[z38a89f6944+2*z8ea92fe60a]);z52ab5b652a+=ze7168fc0b9.
s1*(zf485e5e12c[z38a89f6944-3*z8ea92fe60a]+zf485e5e12c[z38a89f6944+3*z8ea92fe60a
]);z52ab5b652a+=ze7168fc0b9.s0*(zf485e5e12c[z38a89f6944-4*z8ea92fe60a]+
zf485e5e12c[z38a89f6944+4*z8ea92fe60a]);float z045b183f80=convert_float(
z493deefb55.w)/65535.0f;float z333a226d58=z045b183f80-z52ab5b652a;float
z2be91451f0=1.0f;if(z333a226d58>z2e83c0ac43||z333a226d58<-z2e83c0ac43){float
zcab1063e9d=0.0f;if(z333a226d58>z2e83c0ac43)zcab1063e9d=(z333a226d58-z2e83c0ac43
)*z37a59f57c4;if(z333a226d58<-z2e83c0ac43)zcab1063e9d=(z333a226d58+z2e83c0ac43)*
z37a59f57c4;
#if (z38c913a03a>0)

int2 z9b046bc3a1=z83640e5796;
int zfcaa177308=z3576e84f20.s2;int z98cd6733c3=z9b046bc3a1.x+z9b046bc3a1.y*
zfcaa177308;int*z6016b79538=(int*)&z7f76fb323c;float*z41d2ba07fc=(float*)&
z4af71b4d47;float16 z305c8a97dc;float*zbd7b15dc4f=(float*)&z305c8a97dc;for(int
z1d8bd19892=0;z1d8bd19892<z38c913a03a;z1d8bd19892++)zbd7b15dc4f[z1d8bd19892]=
convert_float(z6016b79538[z1d8bd19892]>=0?zec145e35cf[z98cd6733c3+z6016b79538[
z1d8bd19892]]:0);z55c265223f+=(z6d7333005c(z4af71b4d47,z305c8a97dc)/255.0f);
#endif

float zab4422a17d=z045b183f80+zcab1063e9d*z55c265223f;float z1d795de651;if(
zab4422a17d<=0)z1d795de651=0;else if(zab4422a17d>=z045b183f80*16.0f)z1d795de651=
16.0f;else z1d795de651=zab4422a17d/z045b183f80;





#if 0
z2be91451f0=pow(z1d795de651,2.2f/1.8f);
#else

int z6b5a2d9b66=convert_int(z1d795de651*65535.0f);uint za8094f0b11=z6b5a2d9b66>>
10;uint z1e5d7bbab3=z6b5a2d9b66&0x3ff;uint z42d7c57a56=zd6906769c1[za8094f0b11];
uint zf974cebfd3=zd6906769c1[za8094f0b11+1];int z8f205157f9=z42d7c57a56+(
z1e5d7bbab3*(zf974cebfd3-z42d7c57a56)>>10);z2be91451f0=convert_float(z8f205157f9
)/1024.0f;
#endif
}float4 z1ba64f1f2a=(convert_float4(z493deefb55)*(float4)z2be91451f0);
z493deefb55=convert_ushort4_sat(z1ba64f1f2a);z718a062ddd[zaaf414d14e.x+
zaaf414d14e.y*z9562068e13]=z493deefb55;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
