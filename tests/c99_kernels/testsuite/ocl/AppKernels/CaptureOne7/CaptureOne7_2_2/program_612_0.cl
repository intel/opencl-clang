#define z4478f424ca 2

#ifndef z4478f424ca
#define z4478f424ca 0
#endif
#define zec15f7fa83(zff400e9e97, z305d891f1d, za3158292ce) (zff400e9e97 * 0.299f\
 + z305d891f1d *  0.587f + za3158292ce *  0.114f)
#define zf0531aada3 32.0f
__constant float z758719f481=(float)(zf0531aada3);__constant float zbfb6939efb=
1.5f;
#if (z4478f424ca==1)
__kernel void z35da5a4bdf(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,uint z021babbfad,uint z958df11031){int2 zba94ee46da
=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.z||
zba94ee46da.y>=z30eaaf69b7.w)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.xy;
zba94ee46da+=z30eaaf69b7.xy;float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+
z83640e5796.y*(z021babbfad/4)];float zac5cffb9fe=z493deefb55.x;
float z78e5f3d8ec=z493deefb55.y;
float z09a63c2436=z493deefb55.z;
float zc1a7596d5d=zec15f7fa83(zac5cffb9fe,z78e5f3d8ec,z09a63c2436)+z758719f481;
float z2dd09f3226=zac5cffb9fe-z78e5f3d8ec;float za3158292ce=z09a63c2436-
z78e5f3d8ec;
float z5b72300895=1.f/zc1a7596d5d;z2dd09f3226=z2dd09f3226*z5b72300895;
za3158292ce=za3158292ce*z5b72300895;


z493deefb55.x=zc1a7596d5d;z493deefb55.y=z2dd09f3226;z493deefb55.z=za3158292ce;
z493deefb55.w=z78e5f3d8ec;z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4
)]=z493deefb55;}
#else
#if (z4478f424ca==2)
__kernel void z35da5a4bdf(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,uint z021babbfad,uint z958df11031){int2 zba94ee46da
=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.z||
zba94ee46da.y>=z30eaaf69b7.w)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.xy;
zba94ee46da+=z30eaaf69b7.xy;float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+
z83640e5796.y*(z021babbfad/4)];const bool z033ebfdc7e=true;float zf8bc541aad=
z493deefb55.x;
float z08ef030ac3=z493deefb55.y;
float z7e674d442a=z493deefb55.z;

float z78e5f3d8ec=z493deefb55.w;
float zac5cffb9fe=z08ef030ac3*zf8bc541aad+z78e5f3d8ec;float z09a63c2436=
z7e674d442a*zf8bc541aad+z78e5f3d8ec;zac5cffb9fe=max(zac5cffb9fe,1.f);z09a63c2436
=max(z09a63c2436,1.f);if(z033ebfdc7e){float zff5c9644ab=zec15f7fa83(zac5cffb9fe,
z78e5f3d8ec,z09a63c2436)+z758719f481;float z86dd029962=zf8bc541aad/zff5c9644ab;
z86dd029962=min(z86dd029962,zbfb6939efb);zac5cffb9fe*=z86dd029962;z78e5f3d8ec*=
z86dd029962;z09a63c2436*=z86dd029962;


z493deefb55.x=zac5cffb9fe;z493deefb55.y=z78e5f3d8ec;z493deefb55.z=z09a63c2436;}
else{

z493deefb55.x=zac5cffb9fe;z493deefb55.z=z09a63c2436;}z718a062ddd[zba94ee46da.x+
zba94ee46da.y*(z958df11031/4)]=z493deefb55;}
#else
#ifndef zbc6516e8d5
#define zbc6516e8d5 1
#endif
#define zbf428ecccb float
#define z870da0e49c float4
#define z2eceb88eb2 float2
void z8221728b77(__local z870da0e49c*zf485e5e12c,int ze12af1c5cf,__global
z870da0e49c*zf8d9fd6cb8,int zc9d655d235){zf485e5e12c[ze12af1c5cf]=zf8d9fd6cb8[
zc9d655d235];}__kernel void z35da5a4bdf(__global float4*zf8d9fd6cb8,__global
float4*z718a062ddd,int4 z30eaaf69b7,uint z021babbfad,uint z958df11031,int
z336555f76e,int zbedd831684,float4 z3c211c8179,
#if zbc6516e8d5
,__local float4*z01612e015a,
#endif
float4 z2516a5e664){int2 z945895b462=(int2)(get_global_id(0),get_global_id(1));
int2 zba94ee46da=z945895b462+z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;int
ze623780ac4=z336555f76e;
#ifdef z8b6bce8773
int z47728d2efe=get_local_size(1);int z1569e4557f=get_local_id(0);int
z38a89f6944=get_local_id(1);int zb3ec2e5425=z021babbfad/4;
#else
int z47728d2efe=get_local_size(0);int z1569e4557f=get_local_id(1);int
z38a89f6944=get_local_id(0);int zb3ec2e5425=1;
#endif
int z740d84c71c=(z47728d2efe+2*(ze623780ac4));int zc9d655d235=z83640e5796.x+
z83640e5796.y*(z021babbfad/4);
#if zbc6516e8d5
__local float4*zf485e5e12c=z01612e015a+z1569e4557f*z740d84c71c+(ze623780ac4);if(
z945895b462.x<z30eaaf69b7.s2&&z945895b462.y<z30eaaf69b7.s3){int ze12af1c5cf=
z38a89f6944;z8221728b77(zf485e5e12c,ze12af1c5cf,zf8d9fd6cb8,zc9d655d235);if(
z38a89f6944<=ze623780ac4)z8221728b77(zf485e5e12c,ze12af1c5cf-ze623780ac4,
zf8d9fd6cb8,zc9d655d235-zb3ec2e5425*ze623780ac4);if(z38a89f6944>=z47728d2efe-
ze623780ac4)z8221728b77(zf485e5e12c,ze12af1c5cf+ze623780ac4,zf8d9fd6cb8,
zc9d655d235+zb3ec2e5425*ze623780ac4);}barrier(CLK_LOCAL_MEM_FENCE);zb3ec2e5425=1
;
#else
__global float4*zf485e5e12c=zf8d9fd6cb8+zc9d655d235;z38a89f6944=0;
#endif
if(z945895b462.x>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return;int
z87fea0548d=z336555f76e;int z6cdb1f0aed=zbedd831684;const float z0f4bb29e6d=
z3c211c8179.x;
const float z41260b8ff9=z3c211c8179.y;
const float z5eacb1dcf1=z3c211c8179.z;
const float z9f2409475e=z3c211c8179.w;const float z3560cbf2a8=z2516a5e664.x;
const float zc630f0aef1=z2516a5e664.y;const bool zba82919be1=z2516a5e664.z>0.0;
float z5f14ce5e19,zaf2e2538a2,zeea1a40014;float4 z493deefb55=zf485e5e12c[(
z38a89f6944)];z5f14ce5e19=z493deefb55.x;
zaf2e2538a2=z493deefb55.y;
zeea1a40014=z493deefb55.z;
float zebdaab65fa=(zba82919be1?(zaf2e2538a2*zaf2e2538a2+zeea1a40014*zeea1a40014+
z3560cbf2a8)*zc630f0aef1:0.0f);zaf2e2538a2=zaf2e2538a2*z5f14ce5e19;zeea1a40014=
zeea1a40014*z5f14ce5e19;


float zb629aa6c5d=0.f;float za9066c96b3=0.f;float z0d786ca617=0.f;float
z6ad5de8856=z5eacb1dcf1+z9f2409475e*z5f14ce5e19;z6ad5de8856=z6ad5de8856*
z6ad5de8856;

for(int z88fa33d26d=-z87fea0548d;z88fa33d26d<=z87fea0548d;z88fa33d26d+=
z6cdb1f0aed){
float za1d72ab7f4,z296e23b2ca,z4de4bc135a;float4 z448a3dde4b=zf485e5e12c[(
z38a89f6944+z88fa33d26d*zb3ec2e5425)];za1d72ab7f4=z448a3dde4b.x;
z296e23b2ca=z448a3dde4b.y;
z4de4bc135a=z448a3dde4b.z;



float zfdb1df39f0,z7508e1a9d3,z7b02732f1f;zfdb1df39f0=z5f14ce5e19-za1d72ab7f4;
z7508e1a9d3=zaf2e2538a2-z296e23b2ca*za1d72ab7f4;z7b02732f1f=zeea1a40014-
z4de4bc135a*za1d72ab7f4;
zfdb1df39f0=zfdb1df39f0*zfdb1df39f0;z7508e1a9d3=z7508e1a9d3*z7508e1a9d3;
z7b02732f1f=z7b02732f1f*z7b02732f1f;
z7508e1a9d3=z7508e1a9d3*z0f4bb29e6d;z7b02732f1f=z7b02732f1f*z41260b8ff9;

float z4a8d526d4d,z07f5ecb949;
float zec65e8d581=max(z7508e1a9d3,z7b02732f1f);zec65e8d581=max(zec65e8d581,
zfdb1df39f0);zec65e8d581=z6ad5de8856/(zec65e8d581*zec65e8d581+z6ad5de8856);

zec65e8d581=(zec65e8d581>0.01f)?zec65e8d581-0.01f:0.f;
if(zba82919be1)zec65e8d581*=zebdaab65fa/(zebdaab65fa+(z296e23b2ca*z296e23b2ca+
z4de4bc135a*z4de4bc135a));



z4a8d526d4d=(z296e23b2ca*zec65e8d581);z07f5ecb949=(z4de4bc135a*zec65e8d581);
zb629aa6c5d+=z4a8d526d4d;za9066c96b3+=z07f5ecb949;z0d786ca617+=zec65e8d581;}

float z22dadf6692=1.f/(z0d786ca617);float zf313576c29=zb629aa6c5d*z22dadf6692;
float zd234db771d=za9066c96b3*z22dadf6692;


z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=(float4)(z5f14ce5e19,
zf313576c29,zd234db771d,z493deefb55.w);
#if 0

z870da0e49c z36db46d6df=zf485e5e12c[(z38a89f6944)];
z870da0e49c z3076f7e73f=z36db46d6df+z428dac3911;z870da0e49c z75a804bec7=
z36db46d6df-z428dac3911;
z870da0e49c z6c1fbf0a77={0.0f,0.0f,0.0f,0.0f};
for(int z1d8bd19892=-z336555f76e;z1d8bd19892<=z336555f76e;z1d8bd19892+=
zbedd831684){
z870da0e49c z448a3dde4b=zf485e5e12c[(z38a89f6944+z1d8bd19892*zb3ec2e5425)];
zbf428ecccb zfc63e3af37=(z2eafd010fc(fabs(z36db46d6df-z448a3dde4b),z428dac3911)?
1.0f:0.0f);z6c1fbf0a77+=zfc63e3af37*(z870da0e49c)(z448a3dde4b.xyz,1.0f);}
z870da0e49c z2f06f3d292=z36db46d6df;float2 z593fa3cb41=z6c1fbf0a77.xz/
z6c1fbf0a77.ww;if(all(isfinite(z593fa3cb41))&&!any(isnan(z593fa3cb41)))
z2f06f3d292.xz=z593fa3cb41;



z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z2f06f3d292;
#endif
}
#endif
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
