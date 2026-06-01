#define zbc6516e8d5 1

#ifndef zbc6516e8d5
#define zbc6516e8d5 0
#endif
#define z23ae35c8d7	1
#define z54fd70a5dd	2
#define zfc1306fadf		3
#define z17a97266e2         4
#define zfba2891dc6         5
#define z2384ffc1b4          6
#define z73a6d0c759 6
typedef int zdba6b93f69;__kernel void zb4a41b922a(__global ushort*zf8d9fd6cb8,
__global float4*z718a062ddd,int4 z30eaaf69b7,uint z58c1e26fb1,uint z958df11031,
float2 zf184786901,float z4b359ac3f7
#if zbc6516e8d5
,__local ushort*zf485e5e12c
#endif
){int2 zba94ee46da=(int2)(2*get_global_id(0),get_global_id(1));if(zba94ee46da.x+
1>=z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.
xy;int2 z83640e5796=zba94ee46da;zdba6b93f69 z198f8f5bb8=2;zdba6b93f69
z796a73b2c0=z58c1e26fb1;zdba6b93f69 z9a4358f233=1;
#if zbc6516e8d5
int z6e29e29e19=2*get_local_size(0)+2*z73a6d0c759;__local ushort*z395b96baac=
zf485e5e12c;int2 z7cdb6ae8dd=(int2)(2*get_local_id(0)+z73a6d0c759,get_local_id(1
)+z73a6d0c759);int2 z61bac1bc70=z83640e5796-z7cdb6ae8dd;int z1d2006e0ae=
z61bac1bc70.x+z61bac1bc70.y*z796a73b2c0;__global ushort*za1a97eb1a6=zf8d9fd6cb8+
z1d2006e0ae;int z8b1bb737a4=get_local_id(0)+get_local_id(1)*get_local_size(0);
int z4b946a6906=4*z8b1bb737a4;int za6fbfbc4c3=(z73a6d0c759+get_local_size(1)+
z73a6d0c759)*z6e29e29e19;for(int z8dd6fa68b0=0;z8dd6fa68b0<4;z8dd6fa68b0++){int
z38a89f6944=z4b946a6906+z8dd6fa68b0;if(z38a89f6944<za6fbfbc4c3){int z4a5805e56d=
z38a89f6944%z6e29e29e19;int zd47cd65624=z38a89f6944/z6e29e29e19;int z95a479821b=
z4a5805e56d+zd47cd65624*z796a73b2c0;zf485e5e12c[z38a89f6944]=za1a97eb1a6[
z95a479821b];}}barrier(CLK_LOCAL_MEM_FENCE);z395b96baac+=z7cdb6ae8dd.x+
z7cdb6ae8dd.y*z6e29e29e19;z796a73b2c0=z6e29e29e19;
#else
__global ushort*z395b96baac=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z796a73b2c0;
#endif

const int z4fdcfcf0e9=-z796a73b2c0;const int z4c70486185=1;const int z6eebed00b3
=-2*z796a73b2c0;const int z756232d8e6=2;const int ze261664410=-3*z796a73b2c0;
const int z70247fd350=3;const int z6c007decc5=-4*z796a73b2c0;const int
zd14c739350=4;const int z45c01651ac=z796a73b2c0;float zf9b3bef17e=zf184786901.x;
if(zba94ee46da.y&1)
{z395b96baac+=1;zf9b3bef17e=zf184786901.y;}typedef ushort z51b7908a0d;typedef
int za6c557b086;typedef int zdba6b93f69;int z6b234fa5a3=z4fdcfcf0e9;int
zcef8626eaf=z6eebed00b3;int z4148ece2f1=ze261664410;int z5c4d632ac9=z6c007decc5;
int zb767d36134=-z4fdcfcf0e9;int zac4e39e0d0=-z6eebed00b3;int z157c52d688=-
ze261664410;int zac30ce32c0=-z6c007decc5;int z4de79dda32=z4c70486185;int
za3ec544751=z756232d8e6;int z09f3c16c74=z70247fd350;int z498261d44a=zd14c739350;
int ze47876acc4=-z4c70486185;int z1105c4312f=-z756232d8e6;int zeaa352d583=-
z70247fd350;int ze5ce7c4547=-zd14c739350;int zc0fe77b86e=-z4c70486185+
z4fdcfcf0e9;int ze5ecae5f4a=-z756232d8e6+z4fdcfcf0e9;int z744af0be01=-
z70247fd350+z4fdcfcf0e9;int z7093c6ea9c=z4c70486185+z4fdcfcf0e9;int zd048bbd8bf=
z756232d8e6+z4fdcfcf0e9;int za37a5bc70a=z70247fd350+z4fdcfcf0e9;int z51de9d7ecb=
-z4c70486185-z4fdcfcf0e9;int z584852e281=-z756232d8e6-z4fdcfcf0e9;int
ze6dda9e426=-z70247fd350-z4fdcfcf0e9;int z67edf2c3ff=z4c70486185-z4fdcfcf0e9;int
 zb7dad7dd8c=z756232d8e6-z4fdcfcf0e9;int za7a45dcee0=z70247fd350-z4fdcfcf0e9;int
 zb52b81f28a=z4c70486185+z6eebed00b3;int zf1f111fb4f=-z4c70486185+z6eebed00b3;
int z88f43ba9a0=z4c70486185-z6eebed00b3;int z9db4aac011=-z4c70486185-z6eebed00b3
;int z3f955f28ed=z4c70486185+ze261664410;int z88e9100dc1=-z4c70486185+
ze261664410;int zc80dd99c41=z4c70486185-ze261664410;int zd2110934e3=-z4c70486185
-ze261664410;
int zeb2a12fe40=-z756232d8e6+z6eebed00b3;z51b7908a0d z234809fd59=0;

#if zbc6516e8d5
__local ushort*zba15fb8bb8=z395b96baac;
#else
__global ushort*zba15fb8bb8=z395b96baac;
#endif

const za6c557b086 ze28128c2dd=convert_uint(floor(convert_float(z395b96baac[0])*
zf9b3bef17e));
za6c557b086 zc20893b06d=0,z2e95bfd385=0,zb50ecc48f0=0,z976c4c4519=0;
za6c557b086 z8b418de27c,z93d66aa12c;
za6c557b086 z4e601f9b2d,z5c2c3bdbd0;
za6c557b086 ze4d2e61ee9=0,zd4b983e425=0;
za6c557b086 z5efcf3d363=convert_int(floor(zf9b3bef17e*16.f));


const zdba6b93f69 z7b53cda41d=convert_int(z395b96baac[z6b234fa5a3])-ze28128c2dd;
const zdba6b93f69 z7f9c6e51f2=convert_int(z395b96baac[zb767d36134])-ze28128c2dd;
const zdba6b93f69 z4e5f41cd31=convert_int(z395b96baac[ze47876acc4])-ze28128c2dd;
const zdba6b93f69 z2cee7760dd=convert_int(z395b96baac[z4de79dda32])-ze28128c2dd;
zdba6b93f69 ze4b052164b;
for(int zdbc3421475=-4;zdbc3421475<=4;zdbc3421475+=2){ze4b052164b=(z395b96baac[(
z45c01651ac*zdbc3421475)]*z5efcf3d363)/16;
zc20893b06d+=abs(z395b96baac[(z45c01651ac*zdbc3421475)-z45c01651ac]-ze4b052164b-
z7b53cda41d);
z976c4c4519+=abs(z395b96baac[(z45c01651ac*zdbc3421475)+z45c01651ac]-ze4b052164b-
z7f9c6e51f2);
ze4b052164b=(z395b96baac[zdbc3421475]*z5efcf3d363)/16;
zb50ecc48f0+=abs(z395b96baac[zdbc3421475-1]-ze4b052164b-z4e5f41cd31);
z2e95bfd385+=abs(z395b96baac[zdbc3421475+1]-ze4b052164b-z2cee7760dd);
ze4d2e61ee9+=abs(z395b96baac[zdbc3421475-1]-z395b96baac[zdbc3421475+1]);
zd4b983e425+=abs(z395b96baac[(z45c01651ac*zdbc3421475)-z45c01651ac]-z395b96baac[
(z45c01651ac*zdbc3421475)+z45c01651ac]);
}

za6c557b086 z998165f8ed;z998165f8ed=abs(z395b96baac[ze47876acc4]-z395b96baac[
zf1f111fb4f])+abs(z395b96baac[ze47876acc4]-z395b96baac[z9db4aac011])+abs(
z395b96baac[z4de79dda32]-z395b96baac[zb52b81f28a])+abs(z395b96baac[z4de79dda32]-
z395b96baac[z88f43ba9a0]);
zd4b983e425+=z998165f8ed;zc20893b06d+=z998165f8ed;z976c4c4519+=z998165f8ed;
z998165f8ed=abs(z395b96baac[z6b234fa5a3]-z395b96baac[ze5ecae5f4a])+abs(
z395b96baac[z6b234fa5a3]-z395b96baac[zd048bbd8bf])+abs(z395b96baac[zb767d36134]-
z395b96baac[z584852e281])+abs(z395b96baac[zb767d36134]-z395b96baac[zb7dad7dd8c])
;
ze4d2e61ee9+=z998165f8ed;z2e95bfd385+=z998165f8ed;zb50ecc48f0+=z998165f8ed;
z395b96baac=&zba15fb8bb8[zeb2a12fe40];
for(int z1d8bd19892=0;z1d8bd19892<2;z1d8bd19892++){for(int zdbc3421475=0;
zdbc3421475<2;zdbc3421475++){ze4b052164b=(z395b96baac[0]*z5efcf3d363)/16;
zb50ecc48f0+=abs(z395b96baac[ze47876acc4]-ze4b052164b-z4e5f41cd31);
z2e95bfd385+=abs(z395b96baac[z4de79dda32]-ze4b052164b-z2cee7760dd);
zc20893b06d+=abs(z395b96baac[z6b234fa5a3]-ze4b052164b-z7b53cda41d);
z976c4c4519+=abs(z395b96baac[zb767d36134]-ze4b052164b-z7f9c6e51f2);
ze4d2e61ee9+=abs(z395b96baac[ze47876acc4]-z395b96baac[z4de79dda32]);
zd4b983e425+=abs(z395b96baac[z6b234fa5a3]-z395b96baac[zb767d36134]);
z395b96baac+=4;
}z395b96baac+=zac4e39e0d0-(3*2);
}
if(zb50ecc48f0>z2e95bfd385){z8b418de27c=zb50ecc48f0;z93d66aa12c=z2e95bfd385;}
else{z8b418de27c=z2e95bfd385;z93d66aa12c=zb50ecc48f0;}
if(zc20893b06d>z976c4c4519){z4e601f9b2d=zc20893b06d;z5c2c3bdbd0=z976c4c4519;}
else{z4e601f9b2d=z976c4c4519;z5c2c3bdbd0=zc20893b06d;}
if(z8b418de27c<z5c2c3bdbd0&&ze4d2e61ee9<zd4b983e425)z234809fd59=z23ae35c8d7;else
 if(z4e601f9b2d<z93d66aa12c&&zd4b983e425<ze4d2e61ee9)z234809fd59=z54fd70a5dd;
else{z234809fd59=zfc1306fadf;


z395b96baac=&zba15fb8bb8[0];int z16a7d312e0=abs(z395b96baac[ze47876acc4]+
z395b96baac[z4de79dda32]-z395b96baac[z6b234fa5a3]-z395b96baac[zb767d36134])/2;
z16a7d312e0*=z16a7d312e0;
int z907af15509=(z395b96baac[ze47876acc4]+z395b96baac[z4de79dda32]+z395b96baac[
z6b234fa5a3]+z395b96baac[zb767d36134]);if(z16a7d312e0<z907af15509)
{;
}else
{zc20893b06d=z976c4c4519=zb50ecc48f0=z2e95bfd385=0;
z395b96baac=&zba15fb8bb8[zc0fe77b86e*4];
for(int z1d8bd19892=0;z1d8bd19892<5;z1d8bd19892++){for(int zdbc3421475=0;
zdbc3421475<5;zdbc3421475++){ze4b052164b=(z395b96baac[0]*z5efcf3d363)/16;
zb50ecc48f0+=abs(z395b96baac[ze47876acc4]-ze4b052164b-z4e5f41cd31);
z2e95bfd385+=abs(z395b96baac[z4de79dda32]-ze4b052164b-z2cee7760dd);
zc20893b06d+=abs(z395b96baac[z6b234fa5a3]-ze4b052164b-z7b53cda41d);
z976c4c4519+=abs(z395b96baac[zb767d36134]-ze4b052164b-z7f9c6e51f2);
z395b96baac+=2;
}z395b96baac+=zac4e39e0d0-(5*2);
}
if(zb50ecc48f0>z2e95bfd385){z8b418de27c=zb50ecc48f0;z93d66aa12c=z2e95bfd385;}
else{z8b418de27c=z2e95bfd385;z93d66aa12c=zb50ecc48f0;}
if(zc20893b06d>z976c4c4519){z4e601f9b2d=zc20893b06d;z5c2c3bdbd0=z976c4c4519;}
else{z4e601f9b2d=z976c4c4519;z5c2c3bdbd0=zc20893b06d;}
if(z8b418de27c<z5c2c3bdbd0)z234809fd59=z23ae35c8d7;else if(z93d66aa12c>
z4e601f9b2d)z234809fd59=z54fd70a5dd;else z234809fd59=zfc1306fadf;}}z395b96baac=&
zba15fb8bb8[0];float z73bd47ca91,z4d9b897b52,z52e6ffcce2,zd5e143f145;
float za7246face5;const z51b7908a0d z50b2db83cb=z395b96baac[0];
float zf772fd3417,z5a73c2eb51,zb7915840d3,zc59eb8d52e;

switch(z234809fd59){float zd3f49919e3,z526d36e43c;case z23ae35c8d7:

zb7915840d3=convert_float((z50b2db83cb+z395b96baac[z1105c4312f])/2);
zc59eb8d52e=convert_float((z50b2db83cb+z395b96baac[za3ec544751])/2);

z52e6ffcce2=convert_float(1+abs(z395b96baac[zeaa352d583]-z395b96baac[ze47876acc4
])+abs(z395b96baac[ze47876acc4]-z395b96baac[z4de79dda32])+abs(z395b96baac[
ze5ecae5f4a]-z395b96baac[z6b234fa5a3])+abs(z395b96baac[z584852e281]-z395b96baac[
zb767d36134]))+convert_float(abs(z395b96baac[z1105c4312f]-z50b2db83cb))*
zf9b3bef17e;
zd5e143f145=convert_float(1+abs(z395b96baac[z09f3c16c74]-z395b96baac[z4de79dda32
])+abs(z395b96baac[ze47876acc4]-z395b96baac[z4de79dda32])+abs(z395b96baac[
zd048bbd8bf]-z395b96baac[z6b234fa5a3])+abs(z395b96baac[zb7dad7dd8c]-z395b96baac[
zb767d36134]))+convert_float(abs(z395b96baac[za3ec544751]-z50b2db83cb))*
zf9b3bef17e;zd3f49919e3=zd5e143f145*convert_float(z395b96baac[ze47876acc4])+
z52e6ffcce2*convert_float(z395b96baac[z4de79dda32])+(z52e6ffcce2+zd5e143f145)*
z4b359ac3f7;z526d36e43c=zd5e143f145*zb7915840d3+z52e6ffcce2*zc59eb8d52e+(
zd5e143f145+z52e6ffcce2)*z4b359ac3f7;za7246face5=(zd3f49919e3/z526d36e43c)*(
convert_float(z50b2db83cb)+z4b359ac3f7);za7246face5=(za7246face5>z4b359ac3f7)?
za7246face5-z4b359ac3f7:0.0f;break;case z54fd70a5dd:

zf772fd3417=convert_float((z50b2db83cb+z395b96baac[zcef8626eaf])/2);
z5a73c2eb51=convert_float((z50b2db83cb+z395b96baac[zac4e39e0d0])/2);

z73bd47ca91=convert_float(1+abs(z395b96baac[z4148ece2f1]-z395b96baac[z6b234fa5a3
])+abs(z395b96baac[zf1f111fb4f]-z395b96baac[ze47876acc4])+abs(z395b96baac[
zb52b81f28a]-z395b96baac[z4de79dda32])
+abs(z395b96baac[z6b234fa5a3]-z395b96baac[zb767d36134]))
+convert_float(abs(z395b96baac[zcef8626eaf]-z50b2db83cb))*zf9b3bef17e;
z4d9b897b52=convert_float(1+abs(z395b96baac[z157c52d688]-z395b96baac[zb767d36134
])+abs(z395b96baac[z9db4aac011]-z395b96baac[ze47876acc4])+abs(z395b96baac[
z88f43ba9a0]-z395b96baac[z4de79dda32])+abs(z395b96baac[z6b234fa5a3]-z395b96baac[
zb767d36134]))+convert_float(abs(z395b96baac[zac4e39e0d0]-z50b2db83cb))*
zf9b3bef17e;zd3f49919e3=z4d9b897b52*convert_float(z395b96baac[z6b234fa5a3])+
z73bd47ca91*convert_float(z395b96baac[zb767d36134])+(z73bd47ca91+z4d9b897b52)*
z4b359ac3f7;z526d36e43c=z4d9b897b52*zf772fd3417+z73bd47ca91*z5a73c2eb51+(
z4d9b897b52+z73bd47ca91)*z4b359ac3f7;za7246face5=zd3f49919e3/z526d36e43c*(
convert_float(z50b2db83cb)+z4b359ac3f7);za7246face5=(za7246face5>z4b359ac3f7)?
za7246face5-z4b359ac3f7:0.0f;break;case zfc1306fadf:

zf772fd3417=convert_float((z50b2db83cb+z395b96baac[zcef8626eaf])/2);
z5a73c2eb51=convert_float((z50b2db83cb+z395b96baac[zac4e39e0d0])/2);
zb7915840d3=convert_float((z50b2db83cb+z395b96baac[z1105c4312f])/2);
zc59eb8d52e=convert_float((z50b2db83cb+z395b96baac[za3ec544751])/2);

z73bd47ca91=convert_float(1+abs(z395b96baac[z4148ece2f1]-z395b96baac[z6b234fa5a3
])+abs(z395b96baac[zf1f111fb4f]-z395b96baac[ze47876acc4])+abs(z395b96baac[
zb52b81f28a]-z395b96baac[z4de79dda32])
+abs(z395b96baac[z6b234fa5a3]-z395b96baac[zb767d36134]))
+convert_float(abs(z395b96baac[zcef8626eaf]-z50b2db83cb))*zf9b3bef17e;
z73bd47ca91=1.f/z73bd47ca91;
z4d9b897b52=convert_float(1+abs(z395b96baac[z157c52d688]-z395b96baac[zb767d36134
])+abs(z395b96baac[z9db4aac011]-z395b96baac[ze47876acc4])+abs(z395b96baac[
z88f43ba9a0]-z395b96baac[z4de79dda32])+abs(z395b96baac[z6b234fa5a3]-z395b96baac[
zb767d36134]))+convert_float(abs(z395b96baac[zac4e39e0d0]-z50b2db83cb))*
zf9b3bef17e;z4d9b897b52=1.f/z4d9b897b52;
z52e6ffcce2=convert_float(1+abs(z395b96baac[zeaa352d583]-z395b96baac[ze47876acc4
])+abs(z395b96baac[ze47876acc4]-z395b96baac[z4de79dda32])+abs(z395b96baac[
ze5ecae5f4a]-z395b96baac[z6b234fa5a3])+abs(z395b96baac[z584852e281]-z395b96baac[
zb767d36134]))+convert_float(abs(z395b96baac[z1105c4312f]-z50b2db83cb))*
zf9b3bef17e;z52e6ffcce2=1.f/z52e6ffcce2;
zd5e143f145=convert_float(1+abs(z395b96baac[z09f3c16c74]-z395b96baac[z4de79dda32
])+abs(z395b96baac[ze47876acc4]-z395b96baac[z4de79dda32])+abs(z395b96baac[
zd048bbd8bf]-z395b96baac[z6b234fa5a3])+abs(z395b96baac[zb7dad7dd8c]-z395b96baac[
zb767d36134]))+convert_float(abs(z395b96baac[za3ec544751]-z50b2db83cb))*
zf9b3bef17e;zd5e143f145=1.f/zd5e143f145;zd3f49919e3=z73bd47ca91*convert_float(
z395b96baac[z6b234fa5a3])+z4d9b897b52*convert_float(z395b96baac[zb767d36134])+
z52e6ffcce2*convert_float(z395b96baac[ze47876acc4])+zd5e143f145*convert_float(
z395b96baac[z4de79dda32]);zd3f49919e3+=(z52e6ffcce2+zd5e143f145+z73bd47ca91+
z4d9b897b52)*z4b359ac3f7;z526d36e43c=z73bd47ca91*zf772fd3417+z4d9b897b52*
z5a73c2eb51+z52e6ffcce2*zb7915840d3+zd5e143f145*zc59eb8d52e;z526d36e43c+=(
z52e6ffcce2+zd5e143f145+z73bd47ca91+z4d9b897b52)*z4b359ac3f7;za7246face5=
zd3f49919e3/z526d36e43c*(convert_float(z50b2db83cb)+z4b359ac3f7);za7246face5=(
za7246face5>z4b359ac3f7)?za7246face5-z4b359ac3f7:0.0f;break;}float zde4c1607da=
convert_float(z234809fd59);int zcdf189b12e=(zba94ee46da.x)+zba94ee46da.y*
z958df11031/4;if(zba94ee46da.y&1)
{


z718a062ddd[0+zcdf189b12e]=(float4)(0.0f,convert_float(z395b96baac[-1]),0.0f,
0.0f);z718a062ddd[1+zcdf189b12e]=(float4)(zde4c1607da,za7246face5,z395b96baac[0]
,0.0f);}else{


z718a062ddd[0+zcdf189b12e]=(float4)(convert_float(z395b96baac[0]),za7246face5,
zde4c1607da,0.0f);z718a062ddd[1+zcdf189b12e]=(float4)(0.0f,convert_float(
z395b96baac[1]),0.0f,0.0f);}}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
