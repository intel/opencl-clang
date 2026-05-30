#define zbc6516e8d5 0

#ifndef zbc6516e8d5
#define zbc6516e8d5 1
#endif
#if zbc6516e8d5
#define z633bdc4c82 __local float4
#else
#define z633bdc4c82 __global float4
#endif
#ifndef z3dbd1ff682
#define z3dbd1ff682 -1
#endif
#define z1d4ca9f47c 0
#define z9df8abda08 1
#define z2cfb95721f 2
#if z3dbd1ff682==-1
float4 z03aeac13a1(float4 z493deefb55){
if(any(isgreaterequal(z493deefb55,(float4)(65535.0f,65535.0f,65535.0f,-1.0f)))){
float4 z2ca2af4680=min(z493deefb55,65535.0f);float z90e1a42944=dot((float4)(1.0f
,1.0f,1.0f,0.0f),z493deefb55)/dot((float4)(1.0f,1.0f,1.0f,0.0f),z2ca2af4680);
z493deefb55=z2ca2af4680*z90e1a42944;}return z493deefb55;}int z33abbb27ee(float
z2dd09f3226,float za3158292ce,float ze28128c2dd,float z593fa3cb41){float
z46f2f55f18=z2dd09f3226;
int z1d8bd19892=0;
if(za3158292ce>z46f2f55f18){z46f2f55f18=za3158292ce;z1d8bd19892=1;}if(
ze28128c2dd>z46f2f55f18){z46f2f55f18=ze28128c2dd;z1d8bd19892=2;}if(z593fa3cb41>
z46f2f55f18){z1d8bd19892=3;}return z1d8bd19892;}
#define z57f8d3ba0a(z493deefb55, ze28128c2dd) (ze28128c2dd<0 ? z493deefb55.x : \
z493deefb55.z)
typedef short z6d9b655c10;
float z58d502d555(z633bdc4c82*zf8d9fd6cb8,int zbced03a0bf,int z8e54004f94,float4
 z3d94c6ec01){float zd0d24a0a66,za3b89d13ec,z9789164f71,z8b626b2823;
float z26cc9604bc;float ze28128c2dd;
z8e54004f94-=1;int z6d30cd5dec=zbced03a0bf+zbced03a0bf;float z70269ede93=
z3d94c6ec01.x;float ze33fe18116=z3d94c6ec01.y;float zf18505e1f9=z3d94c6ec01.z;

float4 z746b33d470=zf8d9fd6cb8[-zbced03a0bf];float4 z86181ad2e8=zf8d9fd6cb8[1];
float4 z1baf94ce60=zf8d9fd6cb8[-1];float4 z4cb2da67bc=zf8d9fd6cb8[zbced03a0bf];
float z8837d6468f=z746b33d470.y;float z3b8f6b3beb=z86181ad2e8.y;float
z4cf2cb8cff=z1baf94ce60.y;float z2da2f9c45c=z4cb2da67bc.y;float z0b1c670ab9=
z57f8d3ba0a(z4cb2da67bc,z8e54004f94);float zba09ba1db7=z57f8d3ba0a(z746b33d470,
z8e54004f94);float z0a85050f3e=z57f8d3ba0a(z1baf94ce60,z8e54004f94);float
zdfe7a0ea49=z57f8d3ba0a(z86181ad2e8,z8e54004f94);float4 z24891de963=zf8d9fd6cb8[
-z6d30cd5dec];float4 z439f477542=zf8d9fd6cb8[2];float4 zeb0f5cf3f6=zf8d9fd6cb8[-
2];float4 z62eb447cbe=zf8d9fd6cb8[z6d30cd5dec];float z20e3ed04c5=z24891de963.y;
float zb8c68d4688=z439f477542.y;float z7f0f7e737c=zeb0f5cf3f6.y;float
z320bd92528=z62eb447cbe.y;float4 z7391587de4=zf8d9fd6cb8[0];float z78e5f3d8ec=
z7391587de4.y;
zd0d24a0a66=za3b89d13ec=1.f+fabs(z8837d6468f-z2da2f9c45c);zd0d24a0a66+=fabs(
z20e3ed04c5-z78e5f3d8ec);za3b89d13ec+=fabs(z320bd92528-z78e5f3d8ec);z9789164f71=
z8b626b2823=1.f+fabs(z4cf2cb8cff-z3b8f6b3beb);z9789164f71+=fabs(z7f0f7e737c-
z78e5f3d8ec);z8b626b2823+=fabs(zb8c68d4688-z78e5f3d8ec);
float z301bc0b035=zba09ba1db7+z0a85050f3e+zdfe7a0ea49+z0b1c670ab9;z301bc0b035*=
z70269ede93;float z767ac95197=z8837d6468f+z2da2f9c45c+z3b8f6b3beb+z4cf2cb8cff;if
(z767ac95197>z301bc0b035){zd0d24a0a66*=ze33fe18116+fabs(z8837d6468f-zba09ba1db7)
/(1.f+z8837d6468f+zba09ba1db7);za3b89d13ec*=ze33fe18116+fabs(z2da2f9c45c-
z0b1c670ab9)/(1.f+z2da2f9c45c+z0b1c670ab9);z8b626b2823*=ze33fe18116+fabs(
z3b8f6b3beb-zdfe7a0ea49)/(1.f+z3b8f6b3beb+zdfe7a0ea49);z9789164f71*=ze33fe18116+
fabs(z4cf2cb8cff-z0a85050f3e)/(1.f+z4cf2cb8cff+z0a85050f3e);}
zd0d24a0a66=1.f/zd0d24a0a66;
za3b89d13ec=1.f/za3b89d13ec;
z9789164f71=1.f/z9789164f71;
z8b626b2823=1.f/z8b626b2823;
z26cc9604bc=zd0d24a0a66+za3b89d13ec+z8b626b2823+z9789164f71;ze28128c2dd=
zd0d24a0a66*zba09ba1db7+za3b89d13ec*z0b1c670ab9+z9789164f71*z0a85050f3e+
z8b626b2823*zdfe7a0ea49+z26cc9604bc*zf18505e1f9;
ze28128c2dd/=(zd0d24a0a66*z8837d6468f+za3b89d13ec*z2da2f9c45c+z9789164f71*
z4cf2cb8cff+z8b626b2823*z3b8f6b3beb+z26cc9604bc*zf18505e1f9);
ze28128c2dd*=(z78e5f3d8ec+zf18505e1f9);
float z04f9657056=ze28128c2dd-zf18505e1f9;ze28128c2dd=max(z04f9657056,0.0f);
return ze28128c2dd;}
#define z73a6d0c759 2
__kernel void z48dd14e643(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z958df11031,float4 z3d94c6ec01
#if zbc6516e8d5
,__local float4*zf485e5e12c
#endif
){int2 z945895b462=(int2)(2*get_global_id(0),2*get_global_id(1));int2
zba94ee46da=z945895b462+z30eaaf69b7.s01;int2 z83640e5796=z945895b462+z30eaaf69b7
.s45;int z796a73b2c0=z021babbfad;
#if zbc6516e8d5
int z6e29e29e19=2*get_local_size(0)+2*z73a6d0c759;__local float4*z99ea074086=
zf485e5e12c;int2 z7cdb6ae8dd=(int2)(2*get_local_id(0)+z73a6d0c759,2*get_local_id
(1)+z73a6d0c759);int2 z61bac1bc70=z83640e5796-z7cdb6ae8dd;int z2cf8520e42=
z61bac1bc70.x+z61bac1bc70.y*z796a73b2c0;int zf54614f74b=(z30eaaf69b7.z-1)+
z796a73b2c0*(z30eaaf69b7.w-1);int z8b1bb737a4=get_local_id(0)+get_local_id(1)*
get_local_size(0);int z4b946a6906=6*z8b1bb737a4;int za6fbfbc4c3=(z73a6d0c759+2*
get_local_size(1)+z73a6d0c759)*z6e29e29e19;for(int z8dd6fa68b0=0;z8dd6fa68b0<6;
z8dd6fa68b0++){int z38a89f6944=z4b946a6906+z8dd6fa68b0;if(z38a89f6944<
za6fbfbc4c3){int z4a5805e56d=z38a89f6944%z6e29e29e19;int zd47cd65624=z38a89f6944
/z6e29e29e19;int z95a479821b=z4a5805e56d+zd47cd65624*z796a73b2c0;z95a479821b=
clamp(z95a479821b+z2cf8520e42,0,zf54614f74b);zf485e5e12c[z38a89f6944]=
zf8d9fd6cb8[z95a479821b];}}barrier(CLK_LOCAL_MEM_FENCE);z99ea074086+=z7cdb6ae8dd
.x+z7cdb6ae8dd.y*z6e29e29e19;z796a73b2c0=z6e29e29e19;
#else
__global float4*z99ea074086=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z796a73b2c0;
#endif
if(z945895b462.x>=z30eaaf69b7.s2||z945895b462.y>=z30eaaf69b7.s3)return;int
z9562068e13=z958df11031;int zcdf189b12e=zba94ee46da.x+zba94ee46da.y*z9562068e13;
float4 z23f640cecd=z99ea074086[0];float4 ze3582107ea=z99ea074086[1];float4
z39ca04a0da=z99ea074086[z796a73b2c0];float4 z825c4b13fc=z99ea074086[z796a73b2c0+
1];ze3582107ea.x=z58d502d555(z99ea074086+1,z796a73b2c0,0,z3d94c6ec01);
ze3582107ea.z=z58d502d555(z99ea074086+1,z796a73b2c0,2,z3d94c6ec01);z39ca04a0da.x
=z58d502d555(z99ea074086+z796a73b2c0,z796a73b2c0,0,z3d94c6ec01);z39ca04a0da.z=
z58d502d555(z99ea074086+z796a73b2c0,z796a73b2c0,2,z3d94c6ec01);z718a062ddd[
zcdf189b12e]=z23f640cecd;
z718a062ddd[1+zcdf189b12e]=ze3582107ea;
z718a062ddd[zcdf189b12e+z9562068e13]=z39ca04a0da;
z718a062ddd[1+zcdf189b12e+z9562068e13]=z825c4b13fc;
}
#endif
#if (z3dbd1ff682==z1d4ca9f47c)
__kernel void z3c857c4320(__global float4*zf8d9fd6cb8,__global float*z718a062ddd
,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float4 zed5a2cac4e){int2
z945895b462=(int2)(2*get_global_id(0),2*get_global_id(1));int2 zba94ee46da=
z945895b462+z30eaaf69b7.s01;int2 z83640e5796=z945895b462+z30eaaf69b7.s45;if(
z945895b462.x>z30eaaf69b7.s2||z945895b462.y>z30eaaf69b7.s3)return;int
z3b23994384=z83640e5796.x+z83640e5796.y*z2824fcf57d;int z77f8ae3448=zba94ee46da.
x+zba94ee46da.y*z9562068e13;z718a062ddd[z77f8ae3448]=0.0f;z718a062ddd[
z77f8ae3448+1]=zf8d9fd6cb8[z3b23994384+1].s1*zed5a2cac4e.s1;z718a062ddd[
z77f8ae3448+z9562068e13]=zf8d9fd6cb8[z3b23994384+z2824fcf57d].s1*zed5a2cac4e.s1;
z718a062ddd[z77f8ae3448+1+z9562068e13]=0.0f;
#if 0
if(z2a2627745b<7){
z24a89f7513[0]=0.f;z24a89f7513[1]=ze4351005bc[3+1]*(1.f/z947813c07b);z24a89f7513
[zaeb9783789]=ze4351005bc[zb41a4b7008+1]*(1.f/z947813c07b);z24a89f7513[
zaeb9783789+1]=0.f;}else{z24a89f7513[0]=ze4351005bc[0]*(1.f/z64a05257f8);
z24a89f7513[1]=ze4351005bc[3+1]*(1.f/z947813c07b);z24a89f7513[zaeb9783789]=
ze4351005bc[zb41a4b7008+1]*(1.f/z947813c07b);z24a89f7513[zaeb9783789+1]=
ze4351005bc[zb41a4b7008+3+2]*(1.f/z19f71788a3);}
#endif
}
#endif
#if (z3dbd1ff682==z9df8abda08)
__kernel void z3c857c4320(__global float4*zf8d9fd6cb8,__global float*z718a062ddd
,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float4 zed5a2cac4e){int2
z945895b462=(int2)(get_global_id(0),get_global_id(1));int2 zba94ee46da=
z945895b462+z30eaaf69b7.s01;int2 z83640e5796=z945895b462+z30eaaf69b7.s45;if(
z945895b462.x>z30eaaf69b7.s2||z945895b462.y>z30eaaf69b7.s3)return;int
z3b23994384=z83640e5796.x+z83640e5796.y*z2824fcf57d;int z77f8ae3448=zba94ee46da.
x+zba94ee46da.y*z9562068e13;float4 ze4351005bc=zf8d9fd6cb8[z3b23994384];
z718a062ddd[z77f8ae3448]=ze4351005bc.s0*zed5a2cac4e.s0+ze4351005bc.s1*2.0f*
zed5a2cac4e.s1+ze4351005bc.s2*zed5a2cac4e.s2+1.f;}
#endif
#if (z3dbd1ff682==z2cfb95721f)
#define z2a2627745b 0
__kernel void z3c857c4320(__global float*zf8d9fd6cb8,__global float4*z718a062ddd
,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float4 z0a1dda9ae0,__global
float*z5413c0ac97,int4 z0cda232ab2){int2 z945895b462=(int2)(get_global_id(0),
get_global_id(1));int2 zba94ee46da=z945895b462+z30eaaf69b7.s01;int2 z83640e5796=
z945895b462+z30eaaf69b7.s45;if(z945895b462.x>z30eaaf69b7.s2||z945895b462.y>
z30eaaf69b7.s3)return;int z3b23994384=z83640e5796.x+z83640e5796.y*z2824fcf57d;
int z77f8ae3448=zba94ee46da.x+zba94ee46da.y*z9562068e13;__global float*
z5cf6e12f2f=zf8d9fd6cb8+z3b23994384;int2 zdc2396006d=z945895b462+z0cda232ab2.xy;
int z0b6cb751d4=z0cda232ab2.z;__global float*z2416fbcc28=z5413c0ac97+zdc2396006d
.x+zdc2396006d.y*z0b6cb751d4;
float z7c95d32f3a=z0a1dda9ae0.s0;float zcfae0cdc1a=z0a1dda9ae0.s1;float
z94594bc139=z0a1dda9ae0.s2;float zab55369935=0.f;
if(z5cf6e12f2f[0]<zcfae0cdc1a){
zab55369935=1.f;}else if(z5cf6e12f2f[0]<4.f*zcfae0cdc1a){
zab55369935=(4.f*zcfae0cdc1a-z5cf6e12f2f[0])*(1.f/(3.f*zcfae0cdc1a));}else if(
z2a2627745b==0){
return;}
if(z2a2627745b==2||z2a2627745b==4)zab55369935=1.f;else if(z2a2627745b==5)
zab55369935=0.f;
float z993e2a8e77=z2416fbcc28[-z0b6cb751d4-1];float z67d5c68d16=z2416fbcc28[-
z0b6cb751d4+1];float z86db0c794e=z2416fbcc28[0];float z1a30d46fe0=z2416fbcc28[
z0b6cb751d4-1];float z4ec3d8ad93=z2416fbcc28[z0b6cb751d4+1];float z6dbcfbb363;
if(fabs(2.f*z86db0c794e-z993e2a8e77-z4ec3d8ad93)<fabs(2.f*z86db0c794e-
z67d5c68d16-z1a30d46fe0)){z6dbcfbb363=(z86db0c794e-(z993e2a8e77+z4ec3d8ad93+2.f*
z86db0c794e)*0.25f)*20.f;float z056147f791=min(z86db0c794e,z7c95d32f3a);
z6dbcfbb363=z6dbcfbb363*z056147f791/(z056147f791+fabs(z6dbcfbb363));}else{
z6dbcfbb363=(z86db0c794e-(z67d5c68d16+z1a30d46fe0+2.f*z86db0c794e)*0.25f)*20.f;
float z056147f791=min(z86db0c794e,z7c95d32f3a);z6dbcfbb363=z6dbcfbb363*
z056147f791/(z056147f791+fabs(z6dbcfbb363));}
float z758923af9b=z86db0c794e+z6dbcfbb363*zab55369935*z94594bc139;float
z86dd029962=z758923af9b/z86db0c794e;z718a062ddd[z77f8ae3448]*=z86dd029962;


}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
