#define zbc6516e8d5 0

#ifndef zbc6516e8d5
#define zbc6516e8d5 0
#endif
#ifndef za38f45ad91
#define za38f45ad91 1
#endif
typedef int zdba6b93f69;typedef uint za6c557b086;typedef ushort z51b7908a0d;
#define		z946d5fd014			 8192
#define		zee1539f3bd	   13
#define		z8d03b06a7c	   11
#define		ze0a293662f	   15
__kernel void z0f585e00ae(__global ushort*zf8d9fd6cb8,__global ushort2*
z718a062ddd,int4 z30eaaf69b7,uint z58c1e26fb1,uint z745057f086,int z5f291d10aa){
int2 z945895b462=(int2)(2*get_global_id(0),2*get_global_id(1));if(z945895b462.x
>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return;int2 zba94ee46da=
z945895b462;int2 z83640e5796=zba94ee46da+z30eaaf69b7.xy;zdba6b93f69 zac4e39e0d0=
z58c1e26fb1;__global ushort*z559a36834b=zf8d9fd6cb8+2+zba94ee46da.x/2+(2+
zba94ee46da.y/2)*zac4e39e0d0;

za6c557b086 zb76d69c063=(za6c557b086)z559a36834b[-1]+3*z946d5fd014;za6c557b086
zbb18636fd5=(za6c557b086)z559a36834b[0]+3*z946d5fd014;za6c557b086 z4ad3f58747=(
za6c557b086)z559a36834b[-1+zac4e39e0d0]+3*z946d5fd014;za6c557b086 z3bfbd8c3d8=(
za6c557b086)z559a36834b[zac4e39e0d0]+3*z946d5fd014;if(z5f291d10aa==1){__global
ushort2*za5caec5431=z718a062ddd+z83640e5796.x/2+z83640e5796.y*z745057f086/2;
zdba6b93f69 zc2a17a2cca=z745057f086/2;
uint2 zfc397c3985=convert_uint2(za5caec5431[0]);zfc397c3985.y=(min((zfc397c3985.
y*(za6c557b086)(z559a36834b[0]))>>zee1539f3bd,(za6c557b086)65535));za5caec5431[0
]=convert_ushort2(zfc397c3985);
uint2 zef38832825=convert_uint2(za5caec5431[zc2a17a2cca]);zef38832825.x=min((
zef38832825.x<<ze0a293662f)/zb76d69c063,(za6c557b086)65535);zef38832825.x=min((
zef38832825.x<<ze0a293662f)/zbb18636fd5,(za6c557b086)65535);zef38832825.x=min((
zef38832825.x<<ze0a293662f)/z4ad3f58747,(za6c557b086)65535);zef38832825.x=min((
zef38832825.x<<ze0a293662f)/z3bfbd8c3d8,(za6c557b086)65535);za5caec5431[
zc2a17a2cca]=convert_ushort2(zef38832825);}else{__global ushort2*z1683ab8997=
z718a062ddd+z83640e5796.x/2+(z83640e5796.y+1)*z745057f086/2;zdba6b93f69
za2c6ad4e57=-z745057f086/2;
uint2 zef38832825=convert_uint2(z1683ab8997[0]);zef38832825.x=(min((zef38832825.
x<<zee1539f3bd)/(za6c557b086)(z559a36834b[0]),(za6c557b086)65535));z1683ab8997[0
]=convert_ushort2(zef38832825);uint2 zfc397c3985=convert_uint2(z1683ab8997[
za2c6ad4e57]);zfc397c3985.y=min((zfc397c3985.y*zb76d69c063)>>ze0a293662f,(
za6c557b086)65535);zfc397c3985.y=min((zfc397c3985.y*zbb18636fd5)>>ze0a293662f,(
za6c557b086)65535);zfc397c3985.y=min((zfc397c3985.y*z4ad3f58747)>>ze0a293662f,(
za6c557b086)65535);zfc397c3985.y=min((zfc397c3985.y*z3bfbd8c3d8)>>ze0a293662f,(
za6c557b086)65535);z1683ab8997[za2c6ad4e57]=convert_ushort2(zfc397c3985);}}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
