#define z3dbd1ff682 1

#ifndef zbc6516e8d5
#define zbc6516e8d5 0
#endif
#ifndef z3dbd1ff682
#define z3dbd1ff682 1
#endif
#if zbc6516e8d5
#define z385d574baf __local ushort*
#define z633bdc4c82 __global float4
#else
#define z385d574baf __global ushort*
#define z633bdc4c82 __global float4
#endif
#define z23ae35c8d7	1
#define z54fd70a5dd	2
#define zfc1306fadf		3
#define z17a97266e2         4
#define zfba2891dc6         5
#define z2384ffc1b4          6
#define z73a6d0c759 6
typedef ushort z51b7908a0d;typedef int za6c557b086;typedef int zdba6b93f69;
#define z4fdcfcf0e9 (-z796a73b2c0)
#define z4c70486185 ( 1)
#define z6eebed00b3 (-2*z796a73b2c0)
#define z756232d8e6 (2)
#define ze261664410 (-3*z796a73b2c0)
#define z70247fd350 (3)
#define z6c007decc5 (-4*z796a73b2c0)
#define zd14c739350 (4)
#define z6b234fa5a3   (z4fdcfcf0e9  )
#define zcef8626eaf  (z6eebed00b3)
#define z4148ece2f1  (ze261664410)
#define z5c4d632ac9  (z6c007decc5)
#define zb767d36134  (-z4fdcfcf0e9 )
#define zac4e39e0d0 (-z6eebed00b3)
#define z157c52d688 (-ze261664410)
#define zac30ce32c0 (-z6c007decc5)
#define z4de79dda32  (  z4c70486185  )
#define za3ec544751 (  z756232d8e6)
#define z09f3c16c74 (  z70247fd350)
#define z498261d44a (  zd14c739350)
#define ze47876acc4  (-z4c70486185  )
#define z1105c4312f (-z756232d8e6)
#define zeaa352d583 (-z70247fd350)
#define ze5ce7c4547 (-zd14c739350)
#define zc0fe77b86e  ( -z4c70486185+ z4fdcfcf0e9)
#define ze5ecae5f4a ( -z756232d8e6+ z4fdcfcf0e9)
#define z744af0be01 ( -z70247fd350+ z4fdcfcf0e9)
#define z7093c6ea9c  (  z4c70486185+ z4fdcfcf0e9)
#define zd048bbd8bf (  z756232d8e6+ z4fdcfcf0e9)
#define za37a5bc70a (  z70247fd350+ z4fdcfcf0e9)
#define z51de9d7ecb  ( -  z4c70486185 -z4fdcfcf0e9)
#define z584852e281 ( -z756232d8e6 -z4fdcfcf0e9)
#define ze6dda9e426 ( -z70247fd350 -z4fdcfcf0e9)
#define z67edf2c3ff  (   z4c70486185 -z4fdcfcf0e9)
#define zb7dad7dd8c (  z756232d8e6 -z4fdcfcf0e9)
#define za7a45dcee0 (  z70247fd350 -z4fdcfcf0e9)
#define zb52b81f28a (  z4c70486185+ z6eebed00b3)
#define zf1f111fb4f ( -z4c70486185+ z6eebed00b3)
#define z88f43ba9a0 (  z4c70486185 -z6eebed00b3)
#define z9db4aac011 ( -z4c70486185 -z6eebed00b3)
#define z3f955f28ed (  z4c70486185+ ze261664410)
#define z88e9100dc1 ( -z4c70486185+ ze261664410)
#define zc80dd99c41 (  z4c70486185 -ze261664410)
#define zd2110934e3 ( -z4c70486185 -ze261664410)

#define zeb2a12fe40 ( -z756232d8e6+ z6eebed00b3)
z51b7908a0d ze5c34d6125(z385d574baf z395b96baac,const zdba6b93f69 z796a73b2c0,
float zf9b3bef17e){z385d574baf zba15fb8bb8=z395b96baac;const zdba6b93f69
z45c01651ac=z796a73b2c0;z51b7908a0d z234809fd59=0;

const zdba6b93f69 ze28128c2dd=convert_int(floor(convert_float(z395b96baac[0])*
zf9b3bef17e));
za6c557b086 zc20893b06d=0,z2e95bfd385=0,zb50ecc48f0=0,z976c4c4519=0;
za6c557b086 z8b418de27c,z93d66aa12c;
za6c557b086 z4e601f9b2d,z5c2c3bdbd0;
za6c557b086 ze4d2e61ee9=0,zd4b983e425=0;
const za6c557b086 z5efcf3d363=convert_int(floor(zf9b3bef17e*1024.f));
const za6c557b086 z065b20429e=convert_int(floor(zf9b3bef17e*1024.f*1.6f));


const zdba6b93f69 z7b53cda41d=convert_int(z395b96baac[z6b234fa5a3])-ze28128c2dd;
const zdba6b93f69 z7f9c6e51f2=convert_int(z395b96baac[zb767d36134])-ze28128c2dd;
const zdba6b93f69 z4e5f41cd31=convert_int(z395b96baac[ze47876acc4])-ze28128c2dd;
const zdba6b93f69 z2cee7760dd=convert_int(z395b96baac[z4de79dda32])-ze28128c2dd;
zdba6b93f69 ze4b052164b;
for(int zdbc3421475=-4;zdbc3421475<=4;zdbc3421475+=8){ze4b052164b=(z395b96baac[(
z45c01651ac*zdbc3421475)]*z5efcf3d363)/1024;
zc20893b06d+=abs(z395b96baac[(z45c01651ac*zdbc3421475)-z45c01651ac]-ze4b052164b-
z7b53cda41d);
z976c4c4519+=abs(z395b96baac[(z45c01651ac*zdbc3421475)+z45c01651ac]-ze4b052164b-
z7f9c6e51f2);
ze4b052164b=(z395b96baac[zdbc3421475]*z5efcf3d363)/1024;
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
z998165f8ed+=((abs(z395b96baac[zcef8626eaf]+z395b96baac[zac4e39e0d0]-2*
z395b96baac[0]))*z065b20429e)/1024;
zd4b983e425+=z998165f8ed;zc20893b06d+=z998165f8ed;z976c4c4519+=z998165f8ed;
z998165f8ed=abs(z395b96baac[z6b234fa5a3]-z395b96baac[ze5ecae5f4a])+abs(
z395b96baac[z6b234fa5a3]-z395b96baac[zd048bbd8bf])+abs(z395b96baac[zb767d36134]-
z395b96baac[z584852e281])+abs(z395b96baac[zb767d36134]-z395b96baac[zb7dad7dd8c])
;
z998165f8ed+=((abs(z395b96baac[z1105c4312f]+z395b96baac[za3ec544751]-2*
z395b96baac[0]))*z065b20429e)/1024;
ze4d2e61ee9+=z998165f8ed;z2e95bfd385+=z998165f8ed;zb50ecc48f0+=z998165f8ed;
z395b96baac=&zba15fb8bb8[zeb2a12fe40];
for(int z1d8bd19892=0;z1d8bd19892<3;z1d8bd19892++){z395b96baac=&zba15fb8bb8[(
zeb2a12fe40)+(zac4e39e0d0)*z1d8bd19892];
for(int zdbc3421475=0;zdbc3421475<3;zdbc3421475++){ze4b052164b=(z395b96baac[0]*
z5efcf3d363)/1024;
zb50ecc48f0+=abs(z395b96baac[ze47876acc4]-ze4b052164b-z4e5f41cd31);
z2e95bfd385+=abs(z395b96baac[z4de79dda32]-ze4b052164b-z2cee7760dd);
zc20893b06d+=abs(z395b96baac[z6b234fa5a3]-ze4b052164b-z7b53cda41d);
z976c4c4519+=abs(z395b96baac[zb767d36134]-ze4b052164b-z7f9c6e51f2);
ze4d2e61ee9+=abs(z395b96baac[ze47876acc4]-z395b96baac[z4de79dda32]);
zd4b983e425+=abs(z395b96baac[z6b234fa5a3]-z395b96baac[zb767d36134]);
z395b96baac+=2;
}
}
if(zb50ecc48f0>z2e95bfd385){z8b418de27c=zb50ecc48f0;z93d66aa12c=z2e95bfd385;}
else{z8b418de27c=z2e95bfd385;z93d66aa12c=zb50ecc48f0;}
if(zc20893b06d>z976c4c4519){z4e601f9b2d=zc20893b06d;z5c2c3bdbd0=z976c4c4519;}
else{z4e601f9b2d=z976c4c4519;z5c2c3bdbd0=zc20893b06d;}
if(z8b418de27c<z5c2c3bdbd0&&ze4d2e61ee9<zd4b983e425)return z23ae35c8d7;else if(
z4e601f9b2d<z93d66aa12c&&zd4b983e425<ze4d2e61ee9)return z54fd70a5dd;else{
z234809fd59=zfc1306fadf;


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
zdbc3421475<5;zdbc3421475++){ze4b052164b=(z395b96baac[0]*z5efcf3d363)/1024;
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
z4e601f9b2d)z234809fd59=z54fd70a5dd;else z234809fd59=zfc1306fadf;}}return
z234809fd59;}z51b7908a0d ze392e188bf(z385d574baf z395b96baac,const zdba6b93f69
z796a73b2c0,float zf9b3bef17e){z385d574baf zba15fb8bb8=z395b96baac;const
zdba6b93f69 z45c01651ac=z796a73b2c0;z51b7908a0d z234809fd59=0;

za6c557b086 zc20893b06d=0,z2e95bfd385=0,zb50ecc48f0=0,z976c4c4519=0;
za6c557b086 ze4d2e61ee9=0,zd4b983e425=0;
const za6c557b086 z065b20429e=convert_int(floor(zf9b3bef17e*1024.f*1.6f));


for(int zdbc3421475=-4;zdbc3421475<=4;zdbc3421475+=8){ze4d2e61ee9+=abs(
z395b96baac[zdbc3421475-1]-z395b96baac[zdbc3421475+1]);
zd4b983e425+=abs(z395b96baac[(z45c01651ac*zdbc3421475)-z45c01651ac]-z395b96baac[
(z45c01651ac*zdbc3421475)+z45c01651ac]);
}

za6c557b086 z998165f8ed;z998165f8ed=abs(z395b96baac[ze47876acc4]-z395b96baac[
zf1f111fb4f])+abs(z395b96baac[ze47876acc4]-z395b96baac[z9db4aac011])+abs(
z395b96baac[z4de79dda32]-z395b96baac[zb52b81f28a])+abs(z395b96baac[z4de79dda32]-
z395b96baac[z88f43ba9a0]);
z998165f8ed+=((abs(z395b96baac[zcef8626eaf]+z395b96baac[zac4e39e0d0]-2*
z395b96baac[0]))*z065b20429e)/1024;
zd4b983e425+=z998165f8ed;zc20893b06d+=z998165f8ed;z976c4c4519+=z998165f8ed;
z998165f8ed=abs(z395b96baac[z6b234fa5a3]-z395b96baac[ze5ecae5f4a])+abs(
z395b96baac[z6b234fa5a3]-z395b96baac[zd048bbd8bf])+abs(z395b96baac[zb767d36134]-
z395b96baac[z584852e281])+abs(z395b96baac[zb767d36134]-z395b96baac[zb7dad7dd8c])
;
z998165f8ed+=((abs(z395b96baac[z1105c4312f]+z395b96baac[za3ec544751]-2*
z395b96baac[0]))*z065b20429e)/1024;
ze4d2e61ee9+=z998165f8ed;z2e95bfd385+=z998165f8ed;zb50ecc48f0+=z998165f8ed;
z395b96baac=&zba15fb8bb8[zeb2a12fe40];
for(int z1d8bd19892=0;z1d8bd19892<3;z1d8bd19892++){z395b96baac=&zba15fb8bb8[(
zeb2a12fe40)+(zac4e39e0d0)*z1d8bd19892];
for(int zdbc3421475=0;zdbc3421475<3;zdbc3421475++){ze4d2e61ee9+=abs(z395b96baac[
ze47876acc4]-z395b96baac[z4de79dda32]);
zd4b983e425+=abs(z395b96baac[z6b234fa5a3]-z395b96baac[zb767d36134]);
z395b96baac+=2;
}
}
const int zb51acbd824=5;
const int z1941c0e649=4;
if(ze4d2e61ee9*zb51acbd824<zd4b983e425*z1941c0e649)return z23ae35c8d7;else if(
zd4b983e425*zb51acbd824<ze4d2e61ee9*z1941c0e649)return z54fd70a5dd;else return
zfc1306fadf;}float z9eb8e8653b(z385d574baf z395b96baac,const zdba6b93f69
z796a73b2c0,z51b7908a0d z234809fd59,float z5efcf3d363,float z4b359ac3f7){float
z73bd47ca91,z4d9b897b52,z52e6ffcce2,zd5e143f145;
float za7246face5;const z51b7908a0d z50b2db83cb=z395b96baac[0];
float zf772fd3417,z5a73c2eb51,zb7915840d3,zc59eb8d52e;

switch(z234809fd59){float zd3f49919e3,z526d36e43c;case z23ae35c8d7:

zb7915840d3=convert_float((z50b2db83cb+z395b96baac[z1105c4312f])/2);
zc59eb8d52e=convert_float((z50b2db83cb+z395b96baac[za3ec544751])/2);

z52e6ffcce2=convert_float(1+abs(z395b96baac[zeaa352d583]-z395b96baac[ze47876acc4
])+abs(z395b96baac[ze47876acc4]-z395b96baac[z4de79dda32])+abs(z395b96baac[
ze5ecae5f4a]-z395b96baac[z6b234fa5a3])+abs(z395b96baac[z584852e281]-z395b96baac[
zb767d36134]))+convert_float(abs(z395b96baac[z1105c4312f]-z50b2db83cb))*
z5efcf3d363;
zd5e143f145=convert_float(1+abs(z395b96baac[z09f3c16c74]-z395b96baac[z4de79dda32
])+abs(z395b96baac[ze47876acc4]-z395b96baac[z4de79dda32])+abs(z395b96baac[
zd048bbd8bf]-z395b96baac[z6b234fa5a3])+abs(z395b96baac[zb7dad7dd8c]-z395b96baac[
zb767d36134]))+convert_float(abs(z395b96baac[za3ec544751]-z50b2db83cb))*
z5efcf3d363;zd3f49919e3=zd5e143f145*convert_float(z395b96baac[ze47876acc4])+
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
+convert_float(abs(z395b96baac[zcef8626eaf]-z50b2db83cb))*z5efcf3d363;
z4d9b897b52=convert_float(1+abs(z395b96baac[z157c52d688]-z395b96baac[zb767d36134
])+abs(z395b96baac[z9db4aac011]-z395b96baac[ze47876acc4])+abs(z395b96baac[
z88f43ba9a0]-z395b96baac[z4de79dda32])+abs(z395b96baac[z6b234fa5a3]-z395b96baac[
zb767d36134]))+convert_float(abs(z395b96baac[zac4e39e0d0]-z50b2db83cb))*
z5efcf3d363;zd3f49919e3=z4d9b897b52*convert_float(z395b96baac[z6b234fa5a3])+
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
+convert_float(abs(z395b96baac[zcef8626eaf]-z50b2db83cb))*z5efcf3d363;
z73bd47ca91=1.f/z73bd47ca91;
z4d9b897b52=convert_float(1+abs(z395b96baac[z157c52d688]-z395b96baac[zb767d36134
])+abs(z395b96baac[z9db4aac011]-z395b96baac[ze47876acc4])+abs(z395b96baac[
z88f43ba9a0]-z395b96baac[z4de79dda32])+abs(z395b96baac[z6b234fa5a3]-z395b96baac[
zb767d36134]))+convert_float(abs(z395b96baac[zac4e39e0d0]-z50b2db83cb))*
z5efcf3d363;z4d9b897b52=1.f/z4d9b897b52;
z52e6ffcce2=convert_float(1+abs(z395b96baac[zeaa352d583]-z395b96baac[ze47876acc4
])+abs(z395b96baac[ze47876acc4]-z395b96baac[z4de79dda32])+abs(z395b96baac[
ze5ecae5f4a]-z395b96baac[z6b234fa5a3])+abs(z395b96baac[z584852e281]-z395b96baac[
zb767d36134]))+convert_float(abs(z395b96baac[z1105c4312f]-z50b2db83cb))*
z5efcf3d363;z52e6ffcce2=1.f/z52e6ffcce2;
zd5e143f145=convert_float(1+abs(z395b96baac[z09f3c16c74]-z395b96baac[z4de79dda32
])+abs(z395b96baac[ze47876acc4]-z395b96baac[z4de79dda32])+abs(z395b96baac[
zd048bbd8bf]-z395b96baac[z6b234fa5a3])+abs(z395b96baac[zb7dad7dd8c]-z395b96baac[
zb767d36134]))+convert_float(abs(z395b96baac[za3ec544751]-z50b2db83cb))*
z5efcf3d363;zd5e143f145=1.f/zd5e143f145;zd3f49919e3=z73bd47ca91*convert_float(
z395b96baac[z6b234fa5a3])+z4d9b897b52*convert_float(z395b96baac[zb767d36134])+
z52e6ffcce2*convert_float(z395b96baac[ze47876acc4])+zd5e143f145*convert_float(
z395b96baac[z4de79dda32]);zd3f49919e3+=(z52e6ffcce2+zd5e143f145+z73bd47ca91+
z4d9b897b52)*z4b359ac3f7;z526d36e43c=z73bd47ca91*zf772fd3417+z4d9b897b52*
z5a73c2eb51+z52e6ffcce2*zb7915840d3+zd5e143f145*zc59eb8d52e;z526d36e43c+=(
z52e6ffcce2+zd5e143f145+z73bd47ca91+z4d9b897b52)*z4b359ac3f7;za7246face5=
zd3f49919e3/z526d36e43c*(convert_float(z50b2db83cb)+z4b359ac3f7);za7246face5=(
za7246face5>z4b359ac3f7)?za7246face5-z4b359ac3f7:0.0f;break;}return za7246face5;
}
inline int z468ddbc850(float zc180b9cdc9,float z35bf29e99b,float z2c865879a0,
float z6624dbc6f0,float zd649de2ebe,float zf81de5afde,float z2d7aa8b761,float
zf32497f338){float z7edad8b3b7=zc180b9cdc9;
int z1d8bd19892=0;
if(z35bf29e99b<z7edad8b3b7){z7edad8b3b7=z35bf29e99b;z1d8bd19892=1;}if(
z2c865879a0<z7edad8b3b7){z7edad8b3b7=z2c865879a0;z1d8bd19892=2;}if(z6624dbc6f0<
z7edad8b3b7){z7edad8b3b7=z6624dbc6f0;z1d8bd19892=3;}if(zd649de2ebe<z7edad8b3b7){
z7edad8b3b7=zd649de2ebe;z1d8bd19892=4;}if(zf81de5afde<z7edad8b3b7){z7edad8b3b7=
zf81de5afde;z1d8bd19892=5;}if(z2d7aa8b761<z7edad8b3b7){z7edad8b3b7=z2d7aa8b761;
z1d8bd19892=6;}if(zf32497f338<z7edad8b3b7){z1d8bd19892=7;}return z1d8bd19892;}
#define z57f8d3ba0a(z493deefb55, ze28128c2dd) (z493deefb55.z)
#define z8e54004f94 0
float z36ca738a34(z633bdc4c82*zf8d9fd6cb8,int zbced03a0bf,float2 z62d43e0dd0)
{float z96a2929ccd=0.0f;int z6d30cd5dec=zbced03a0bf+zbced03a0bf;

float2 z353b46dbf7=(float2)(1.3f,1.3f);float4 z9697e8d76f=zf8d9fd6cb8[0];float
z309a2a3e3f=z9697e8d76f.y;
float zf9c08fffd8=z57f8d3ba0a(z9697e8d76f,z8e54004f94);float z0a46e115e3,
zc2c5772781,z353c959062,z131c211e99;
float z4e0a7bfe9f[8];
float zb814869a21=(zf8d9fd6cb8[-zbced03a0bf].y);float z45a66c22e9=(zf8d9fd6cb8[
zbced03a0bf].y);float z18196d1954=(zf8d9fd6cb8[1].y);float z27ef23bf23=(
zf8d9fd6cb8[-1].y);float z45105e84b1=(zf8d9fd6cb8[-z6d30cd5dec-1].y);float
z8231789b88=(zf8d9fd6cb8[-z6d30cd5dec+1].y);float zb94ecaa51d=(zf8d9fd6cb8[
z6d30cd5dec-1].y);float z6bd8d3aad2=(zf8d9fd6cb8[z6d30cd5dec+1].y);float
z259943a429=(zf8d9fd6cb8[zbced03a0bf+2].y);float z918bb3a157=(zf8d9fd6cb8[
zbced03a0bf-2].y);float z5c5e89e9a5=(zf8d9fd6cb8[-zbced03a0bf-2].y);float
zf59885dae9=(zf8d9fd6cb8[-zbced03a0bf+2].y);float4 z105f9ec709=zf8d9fd6cb8[-
zbced03a0bf-1];float4 za1f05c5e24=zf8d9fd6cb8[-zbced03a0bf+1];float4 z543620ea9e
=zf8d9fd6cb8[zbced03a0bf-1];float4 zdc70b86b39=zf8d9fd6cb8[zbced03a0bf+1];float
z491efe2f4b=z105f9ec709.y;float z3913b3943a=za1f05c5e24.y;float z5249ee8f4a=
z543620ea9e.y;float z1b0ee0eb9c=zdc70b86b39.y;float z0dddc839fe=z57f8d3ba0a(
z105f9ec709,-z8e54004f94);float z74f7346062=z57f8d3ba0a(za1f05c5e24,-z8e54004f94
);float z4f219a5b8b=z57f8d3ba0a(z543620ea9e,-z8e54004f94);float zd75dd63979=
z57f8d3ba0a(zdc70b86b39,-z8e54004f94);float4 z6318bc09c5=zf8d9fd6cb8[-
z6d30cd5dec-2];float4 ze170652acd=zf8d9fd6cb8[-z6d30cd5dec+2];float4 z4bc171496b
=zf8d9fd6cb8[z6d30cd5dec-2];float4 zac005d64da=zf8d9fd6cb8[z6d30cd5dec+2];float
z6c1fe7b17f=z57f8d3ba0a(z6318bc09c5,z8e54004f94);float z543a5f0595=z57f8d3ba0a(
ze170652acd,z8e54004f94);float z74ab0cb826=z57f8d3ba0a(z4bc171496b,z8e54004f94);
float z557ef84e08=z57f8d3ba0a(zac005d64da,z8e54004f94);float4 z24891de963=
zf8d9fd6cb8[-z6d30cd5dec];float4 zeb0f5cf3f6=zf8d9fd6cb8[-2];float4 z439f477542=
zf8d9fd6cb8[2];float4 z62eb447cbe=zf8d9fd6cb8[z6d30cd5dec];float z0863638fc7=
z57f8d3ba0a(z24891de963,z8e54004f94);float zec819acfd7=z57f8d3ba0a(zeb0f5cf3f6,
z8e54004f94);float z1d14f2822d=z57f8d3ba0a(z439f477542,z8e54004f94);float
z293d863b1c=z57f8d3ba0a(z62eb447cbe,z8e54004f94);
z4e0a7bfe9f[0]=(zb814869a21+z309a2a3e3f+z45a66c22e9)*(1.f/3.f);z0a46e115e3=fabs(
zb814869a21-z309a2a3e3f)+fabs(z45a66c22e9-z309a2a3e3f)+(fabs(z0863638fc7-
zf9c08fffd8)+fabs(z293d863b1c-zf9c08fffd8))*z62d43e0dd0.x;z4e0a7bfe9f[1]=(
z27ef23bf23+z309a2a3e3f+z18196d1954)*(1.f/3.f);zc2c5772781=fabs(z27ef23bf23-
z309a2a3e3f)+fabs(z18196d1954-z309a2a3e3f)+(fabs(z1d14f2822d-zf9c08fffd8)+fabs(
zec819acfd7-zf9c08fffd8))*z62d43e0dd0.y;
z4e0a7bfe9f[2]=(z3913b3943a+2.f*z309a2a3e3f+z5249ee8f4a)*0.25f;z353c959062=fabs(
z543a5f0595-zf9c08fffd8)+fabs(z6c1fe7b17f-zf9c08fffd8)
+fabs(z0dddc839fe-z74f7346062)
+fabs(zb814869a21-z27ef23bf23)+fabs(z45a66c22e9-z18196d1954);
z4e0a7bfe9f[3]=(z491efe2f4b+2.f*z309a2a3e3f+z1b0ee0eb9c)*0.25f;z131c211e99=fabs(
z74ab0cb826-zf9c08fffd8)+fabs(z557ef84e08-zf9c08fffd8)
+fabs(z4f219a5b8b-zd75dd63979)
+fabs(zb814869a21-z18196d1954)+fabs(z45a66c22e9-z27ef23bf23);

float z702e9c26b6,z7b5240a423,z9b1902c67e,z0145c1097a;
z4e0a7bfe9f[4]=(zb94ecaa51d+z309a2a3e3f+z8231789b88)*0.3333333f;z702e9c26b6=fabs
(zb94ecaa51d-z309a2a3e3f)+fabs(z8231789b88-z309a2a3e3f)
+fabs(zb814869a21-z5249ee8f4a)
+fabs(z45a66c22e9-z3913b3943a);
z4e0a7bfe9f[5]=(z918bb3a157+z309a2a3e3f+zf59885dae9)*0.3333333f;z7b5240a423=fabs
(z918bb3a157-z309a2a3e3f)+fabs(zf59885dae9-z309a2a3e3f)
+fabs(z27ef23bf23-z3913b3943a)
+fabs(z18196d1954-z5249ee8f4a);
z4e0a7bfe9f[6]=(z45105e84b1+z309a2a3e3f+z6bd8d3aad2)*0.3333333f;z0145c1097a=fabs
(z45105e84b1-z309a2a3e3f)+fabs(z6bd8d3aad2-z309a2a3e3f)
+fabs(z45a66c22e9-z491efe2f4b)
+fabs(zb814869a21-z1b0ee0eb9c);
z4e0a7bfe9f[7]=(z5c5e89e9a5+z309a2a3e3f+z259943a429)*0.3333333f;z9b1902c67e=fabs
(z5c5e89e9a5-z309a2a3e3f)+fabs(z259943a429-z309a2a3e3f)
+fabs(z18196d1954-z491efe2f4b)
+fabs(z27ef23bf23-z1b0ee0eb9c);

int z7abd6531b3=(z0a46e115e3<zc2c5772781)?0:1;int zee9619014d=z468ddbc850(
z0a46e115e3,zc2c5772781,z353c959062,z131c211e99,z702e9c26b6,z7b5240a423,
z0145c1097a,z9b1902c67e);if(zee9619014d<2)
{if(zee9619014d==0)z96a2929ccd=(z309a2a3e3f*z353b46dbf7.x+zb814869a21+
z45a66c22e9)/(2.0f+z353b46dbf7.x);else z96a2929ccd=(z309a2a3e3f*z353b46dbf7.y+
z27ef23bf23+z18196d1954)/(2.0f+z353b46dbf7.y);}else
{z96a2929ccd=(z4e0a7bfe9f[zee9619014d]+z4e0a7bfe9f[z7abd6531b3])*0.5f;
}return z96a2929ccd;}
#if (z3dbd1ff682==0)
__kernel void ze99c0282a3(__global ushort*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z58c1e26fb1,int z958df11031,float2 zf184786901,
float z4b359ac3f7
#if zbc6516e8d5
,__local ushort*zf485e5e12c
#endif
){int2 z945895b462=(int2)(2*get_global_id(0),get_global_id(1));if(z945895b462.x+
1>=z30eaaf69b7.s2||z945895b462.y>=z30eaaf69b7.s3)return;int2 zaaf414d14e=
z945895b462+z30eaaf69b7.s01;int2 z83640e5796=z945895b462+z30eaaf69b7.s45;
zdba6b93f69 z198f8f5bb8=2;zdba6b93f69 z796a73b2c0=z58c1e26fb1;zdba6b93f69
z9a4358f233=1;
#if zbc6516e8d5
int z6e29e29e19=2*get_local_size(0)+2*z73a6d0c759;__local ushort*z395b96baac=
zf485e5e12c;int2 z7cdb6ae8dd=(int2)(2*get_local_id(0)+z73a6d0c759,get_local_id(1
)+z73a6d0c759);int2 z61bac1bc70=z83640e5796-z7cdb6ae8dd;int z2cf8520e42=
z61bac1bc70.x+z61bac1bc70.y*z796a73b2c0;int zf54614f74b=(z30eaaf69b7.z-1)+
z796a73b2c0*(z30eaaf69b7.w-1);int z8b1bb737a4=get_local_id(0)+get_local_id(1)*
get_local_size(0);int z4b946a6906=4*z8b1bb737a4;int za6fbfbc4c3=(z73a6d0c759+
get_local_size(1)+z73a6d0c759)*z6e29e29e19;for(int z8dd6fa68b0=0;z8dd6fa68b0<4;
z8dd6fa68b0++){int z38a89f6944=z4b946a6906+z8dd6fa68b0;if(z38a89f6944<
za6fbfbc4c3){int z4a5805e56d=z38a89f6944%z6e29e29e19;int zd47cd65624=z38a89f6944
/z6e29e29e19;int z95a479821b=z4a5805e56d+zd47cd65624*z796a73b2c0;z95a479821b=
clamp(z95a479821b+z2cf8520e42,0,zf54614f74b);zf485e5e12c[z38a89f6944]=
zf8d9fd6cb8[z95a479821b];}}barrier(CLK_LOCAL_MEM_FENCE);z395b96baac+=z7cdb6ae8dd
.x+z7cdb6ae8dd.y*z6e29e29e19;z796a73b2c0=z6e29e29e19;
#else
__global ushort*z395b96baac=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z796a73b2c0;
#endif
z51b7908a0d z234809fd59=0;

float zf9b3bef17e=zf184786901.x;if(z945895b462.y&1)
{z395b96baac+=1;zf9b3bef17e=zf184786901.y;z234809fd59=ze392e188bf(z395b96baac,
z796a73b2c0,zf9b3bef17e);}else{z234809fd59=ze5c34d6125(z395b96baac,z796a73b2c0,
zf9b3bef17e);}float z305d891f1d=z9eb8e8653b(z395b96baac,z796a73b2c0,z234809fd59,
zf9b3bef17e,z4b359ac3f7);
float zde4c1607da=convert_float(z234809fd59);int zcdf189b12e=(zaaf414d14e.x)+
zaaf414d14e.y*z958df11031;if(z945895b462.y&1)
{


z718a062ddd[0+zcdf189b12e]=(float4)(0.0f,convert_float(z395b96baac[-1]),0.0f,
0.0f);z718a062ddd[1+zcdf189b12e]=(float4)(zde4c1607da,z305d891f1d,z395b96baac[0]
,0.0f);}else{


z718a062ddd[0+zcdf189b12e]=(float4)(convert_float(z395b96baac[0]),z305d891f1d,
zde4c1607da,0.0f);z718a062ddd[1+zcdf189b12e]=(float4)(0.0f,convert_float(
z395b96baac[1]),0.0f,0.0f);}}
#endif
#if (z3dbd1ff682==1)
__kernel void ze99c0282a3(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,uint z2824fcf57d,uint z9562068e13){int2 z945895b462
=(int2)(2*get_global_id(0),2*get_global_id(1));if(z945895b462.x>=z30eaaf69b7.s2
||z945895b462.y>=z30eaaf69b7.s3)return;int2 zaaf414d14e=z945895b462+z30eaaf69b7.
s01;int2 z83640e5796=z945895b462+z30eaaf69b7.s45;int z3b23994384=z83640e5796.x+
z83640e5796.y*z2824fcf57d;int z77f8ae3448=zaaf414d14e.x+zaaf414d14e.y*
z9562068e13;float4 ze4b052164b=zf8d9fd6cb8[z3b23994384];float4 zfc397c3985=
zf8d9fd6cb8[z3b23994384+1];float4 zef38832825=zf8d9fd6cb8[z3b23994384+
z2824fcf57d];float4 z7e674d442a=zf8d9fd6cb8[z3b23994384+z2824fcf57d+1];
z7e674d442a.y=z36ca738a34(zf8d9fd6cb8+z3b23994384+z2824fcf57d+1,z2824fcf57d,(
float2)(0.5f,0.5f));z718a062ddd[z77f8ae3448]=ze4b052164b;z718a062ddd[z77f8ae3448
+1]=zfc397c3985;z718a062ddd[z77f8ae3448+z9562068e13]=zef38832825;z718a062ddd[
z77f8ae3448+1+z9562068e13]=z7e674d442a;}
#endif
#if (z3dbd1ff682==2)
__kernel void ze99c0282a3(__global float4*zf8d9fd6cb8,__global float*z718a062ddd
,int8 z30eaaf69b7,uint z2824fcf57d,uint z9562068e13){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=((int2)(2,2))*zba94ee46da+(int2)(1,1)
+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;float4 z493deefb55
=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];z718a062ddd[zaaf414d14e.x+
zaaf414d14e.y*z9562068e13]=z493deefb55.z;}
#endif
#if (z3dbd1ff682==3)
__kernel void ze99c0282a3(__global float*zf8d9fd6cb8,__global float4*z718a062ddd
,int8 z30eaaf69b7,uint z2824fcf57d,uint z9562068e13){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(2*zba94ee46da.x>=z30eaaf69b7.s2||2*
zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.
s45;int2 zaaf414d14e=((int2)(2,2))*zba94ee46da+(int2)(1,1)+z30eaaf69b7.s01;
__global float4*zfb88e2e00d=z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*z9562068e13;
__global float*ze4351005bc=(__global float*)zfb88e2e00d;ze4351005bc[2]=
zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
