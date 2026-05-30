#define z164047dc0a 12
 #define zbbb185011f  2
 #define z8b6bce8773 1
#define zbc6516e8d5 0

#ifndef zbc6516e8d5
#define zbc6516e8d5 1
#endif
#ifndef z164047dc0a
#define z164047dc0a 12
#endif
#ifndef zbbb185011f
#define zbbb185011f 2
#endif
void z1c06a63f34(__local float*zf485e5e12c,int ze12af1c5cf,__global float*
zf8d9fd6cb8,int zc9d655d235){zf485e5e12c[ze12af1c5cf]=zf8d9fd6cb8[zc9d655d235];}
__kernel void z49ba3f0948(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int4 z30eaaf69b7,uint z021babbfad,uint z958df11031,int z336555f76e,int
zbedd831684,float4 z39adf5ef88
#if zbc6516e8d5
,__local float*z01612e015a
#endif
){int2 z945895b462=(int2)(get_global_id(0),get_global_id(1));int2 zba94ee46da=
z945895b462+z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;
#ifdef z8b6bce8773
int z47728d2efe=get_local_size(1);
#else
int z47728d2efe=get_local_size(0);
#endif
int z740d84c71c=z47728d2efe+2*z164047dc0a;
#ifdef z8b6bce8773
int z13d44342d1=get_local_id(0);int zc9d655d235=z83640e5796.x+z83640e5796.y*
z021babbfad;int z38a89f6944=get_local_id(1);int zb3ec2e5425=z021babbfad;
#else
int z13d44342d1=get_local_id(1);int zc9d655d235=z83640e5796.x+z83640e5796.y*
z021babbfad;int z38a89f6944=get_local_id(0);int zb3ec2e5425=1;
#endif
#if zbc6516e8d5
__local float*zf485e5e12c=z01612e015a+z13d44342d1*z740d84c71c+z164047dc0a;if(
z945895b462.x<z30eaaf69b7.s2&&z945895b462.y<z30eaaf69b7.s3){int ze12af1c5cf=
z38a89f6944;z1c06a63f34(zf485e5e12c,ze12af1c5cf,zf8d9fd6cb8,zc9d655d235);if(
z38a89f6944<=z164047dc0a)z1c06a63f34(zf485e5e12c,ze12af1c5cf-z164047dc0a,
zf8d9fd6cb8,zc9d655d235-zb3ec2e5425*z164047dc0a);if(z38a89f6944>z47728d2efe-
z164047dc0a)z1c06a63f34(zf485e5e12c,ze12af1c5cf+z164047dc0a,zf8d9fd6cb8,
zc9d655d235+zb3ec2e5425*z164047dc0a);}barrier(CLK_LOCAL_MEM_FENCE);int
z8ea92fe60a=1;
#else
int z8ea92fe60a=zb3ec2e5425;z38a89f6944=zc9d655d235;__global float*zf485e5e12c=
zf8d9fd6cb8;
#endif
if(z945895b462.x>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return;float
z8dc2b0e47c=zf485e5e12c[z38a89f6944];float ze78627bef0=0.0f;float zb1ae4cc284=
0.0f;for(int z1d8bd19892=-z164047dc0a;z1d8bd19892<=z164047dc0a;z1d8bd19892+=
zbbb185011f){float zde53234008=zf485e5e12c[z38a89f6944+z1d8bd19892*z8ea92fe60a];
if(fabs(z8dc2b0e47c-zde53234008)<z39adf5ef88.x){zb1ae4cc284+=zde53234008;
ze78627bef0+=1.0f;}}z718a062ddd[zba94ee46da.x+zba94ee46da.y*z958df11031]=
zb1ae4cc284/ze78627bef0;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
