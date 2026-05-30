#define zbc6516e8d5 1
 #define z3dbd1ff682 0

#ifndef zbc6516e8d5
#define zbc6516e8d5 0
#endif
#ifndef z3dbd1ff682
#define z3dbd1ff682 0
#endif
typedef int zdba6b93f69;typedef uint za6c557b086;typedef ushort z51b7908a0d;
__kernel void zf1be2a53f2(__global ushort*zf8d9fd6cb8,__global ushort2*
z718a062ddd,int4 z30eaaf69b7,uint z58c1e26fb1,uint z745057f086,float8
z493deefb55,__global float*zaf78d04f7a,int4 zfe3a33d5b9,__global float*
zdf9e18478b,int4 z6f8b05bdeb){
float z2251927697=z493deefb55.s0;float zd72c7cd02e=z493deefb55.s1;float
z3b9e4f8e6f=z493deefb55.s2;float z1ee53f6460=z493deefb55.s3;float zb32dcbfc8b=
z493deefb55.s4;uint z45c01651ac=z58c1e26fb1;uint zb41a4b7008=z745057f086;
__global ushort*zb5c34da6f7=zf8d9fd6cb8+z30eaaf69b7.y*z45c01651ac+z30eaaf69b7.x;
int2 zab74441ef0=zfe3a33d5b9.xy;int za57c5f2a7f=zfe3a33d5b9.z;int z28a30cf9ac=
zfe3a33d5b9.w;int2 z3bb0e75760=z6f8b05bdeb.xy;int z7429154e0f=z6f8b05bdeb.z;int
z09ee10c92e=z6f8b05bdeb.w;
#if (z3dbd1ff682==0)
int2 z945895b462=(int2)(2*get_global_id(0),2*get_global_id(1));if(z945895b462.x
>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return;int2 zba94ee46da=
z945895b462;
__global float*zb3414505e7=zaf78d04f7a+zab74441ef0.y*za57c5f2a7f+zab74441ef0.x;
uint za2ebed4c3d=za57c5f2a7f;__global float*zfc258515dc=zdf9e18478b+z3bb0e75760.
y*z7429154e0f+z3bb0e75760.x;uint zec5a718d02=z7429154e0f;float4 z9891304430=(
float4)(0,0,0,0);float4 z4e83d010c8=(float4)(0,0,0,0);for(int y=zba94ee46da.y;y
<=zba94ee46da.y+1;y++){
int z319328ed61=((y&1)?0:1);
int x=zba94ee46da.x+z319328ed61;
float z7c83382301=convert_float(zb5c34da6f7[z45c01651ac*(y-1)+x-1]);float
z2495fb4eee=convert_float(zb5c34da6f7[z45c01651ac*(y-1)+x+1]);float z46d4ed32bc=
convert_float(zb5c34da6f7[z45c01651ac*(y+1)+x-1]);float z88370fd9e8=
convert_float(zb5c34da6f7[z45c01651ac*(y+1)+x+1]);float z305d891f1d=
convert_float(zb5c34da6f7[z45c01651ac*y+x]);float z76bbc21c4f=convert_float(
zb5c34da6f7[z45c01651ac*(y-1)+x]);float z98fe53cb66=convert_float(zb5c34da6f7[
z45c01651ac*(y+1)+x]);float z0e72efc449=convert_float(zb5c34da6f7[z45c01651ac*(y
)+x-1]);float z58e175a810=convert_float(zb5c34da6f7[z45c01651ac*(y)+x+1]);float
z0a9586e100=z76bbc21c4f;float z7fbf05fae1=z98fe53cb66;if(z76bbc21c4f>z98fe53cb66
){z0a9586e100=z98fe53cb66;z7fbf05fae1=z76bbc21c4f;}float zef4325745d=z58e175a810
;float z653fc45d75=z0e72efc449;if(z58e175a810>z0e72efc449){zef4325745d=
z0e72efc449;z653fc45d75=z58e175a810;}
float zf786ae4fa3,z1e703f3bab;float zf40dfca713,z3d1b543592;float ze953a54ab2;if
(y&1){
zf786ae4fa3=z0a9586e100;z1e703f3bab=z7fbf05fae1;zf40dfca713=zef4325745d;
z3d1b543592=z653fc45d75;ze953a54ab2=-1.f;}else{
zf786ae4fa3=zef4325745d;z1e703f3bab=z653fc45d75;zf40dfca713=z0a9586e100;
z3d1b543592=z7fbf05fae1;ze953a54ab2=1.f;}
float zb4e50ac128=zd72c7cd02e+z305d891f1d*z1ee53f6460+(z1e703f3bab+z3d1b543592)*
z3b9e4f8e6f;float z59ce21f0bf=z305d891f1d-zb4e50ac128;float zab9d515758=
z305d891f1d+zb4e50ac128;
float z5c929f7b7d=(z7c83382301+z88370fd9e8)*0.5f;
float zea34483265=0.f;do{
if(z5c929f7b7d<z59ce21f0bf)break;if(z5c929f7b7d>zab9d515758)break;
float z569f87a832=convert_float(zb5c34da6f7[z45c01651ac*(y-2)+x-2]);float
z2c641ac0d3=convert_float(zb5c34da6f7[z45c01651ac*(y+2)+x+2]);float z48c7a50fca=
z7c83382301-z88370fd9e8;float z4f14030443=fabs((z569f87a832-z305d891f1d)-
z48c7a50fca);float zddff1ed921=fabs((z305d891f1d-z2c641ac0d3)-z48c7a50fca);
zea34483265=(z305d891f1d+zd72c7cd02e)/(z305d891f1d+zd72c7cd02e+fabs(z48c7a50fca)
+(z4f14030443+zddff1ed921)*10.0f);}while(0);float z2d54409aa9=(z2495fb4eee+
z46d4ed32bc)*0.5f;float z38c36eec91=0.f;do{
if(z2d54409aa9<z59ce21f0bf)break;if(z2d54409aa9>zab9d515758)break;
float z129a3f15b9=convert_float(zb5c34da6f7[z45c01651ac*(y-2)+x+2]);float
z4729294298=convert_float(zb5c34da6f7[z45c01651ac*(y+2)+x-2]);float z48c7a50fca=
z2495fb4eee-z46d4ed32bc;float z4f14030443=fabs((z129a3f15b9-z305d891f1d)-
z48c7a50fca);float zddff1ed921=fabs((z305d891f1d-z4729294298)-z48c7a50fca);
z38c36eec91=(z305d891f1d+zd72c7cd02e)/(z305d891f1d+zd72c7cd02e+fabs(z48c7a50fca)
+(z4f14030443+zddff1ed921)*10.0f);}while(0);
if(zea34483265<0.001f&&z38c36eec91<0.001f)continue;
float zdb32dd7bb1,w;if(zea34483265>2.0f*z38c36eec91+0.1f){w=zea34483265;
zdb32dd7bb1=z5c929f7b7d;}else if(z38c36eec91>2.0f*zea34483265+0.1f){w=
z38c36eec91;zdb32dd7bb1=z2d54409aa9;}else{float z02702dd463=zea34483265+0.1f;
float z5cc5ab02f7=z38c36eec91+0.1f;float z5083031dab=1.0f/(z02702dd463+
z5cc5ab02f7);zdb32dd7bb1=(z5c929f7b7d*z02702dd463+z2d54409aa9*z5cc5ab02f7)*
z5083031dab;w=(zea34483265*z02702dd463+z38c36eec91*z5cc5ab02f7)*z5083031dab;}
int z3cef639adb=z305d891f1d;if(z1e703f3bab>z3cef639adb)z3cef639adb=z1e703f3bab;
if(z3d1b543592>z3cef639adb)z3cef639adb=z3d1b543592;
if(w<0.001f)continue;float zff400e9e97=(zf786ae4fa3+z1e703f3bab)*0.5f;float
za3158292ce=(zf40dfca713+z3d1b543592)*0.5f;
float z52ab5b652a=1.0f/(zd72c7cd02e+z3cef639adb);w=w*z52ab5b652a;
float zd3768363a4=ze953a54ab2*z305d891f1d;float z6793b7a789=w*(zd72c7cd02e+
z305d891f1d)/(zd72c7cd02e+zff400e9e97+z305d891f1d+za3158292ce);z9891304430.y+=
z6793b7a789*zd3768363a4*(z305d891f1d-zdb32dd7bb1);z4e83d010c8.y+=z6793b7a789*
zd3768363a4*zd3768363a4;
if(zff400e9e97>z305d891f1d){float z7769a47b4f=ze953a54ab2*zff400e9e97;float
za461c91db7=w*(zf786ae4fa3+zd72c7cd02e)*(zff400e9e97-z305d891f1d)/((z1e703f3bab+
zd72c7cd02e)*(zd72c7cd02e+zff400e9e97));
z9891304430.x+=za461c91db7*z7769a47b4f*(z305d891f1d-zdb32dd7bb1);z4e83d010c8.x+=
za461c91db7*z7769a47b4f*z7769a47b4f;}
if(za3158292ce>z305d891f1d){float z07f5ecb949=ze953a54ab2*za3158292ce;float
z92eab012f7=w*(zf40dfca713+zd72c7cd02e)*(za3158292ce-z305d891f1d)/((z3d1b543592+
zd72c7cd02e)*(zd72c7cd02e+za3158292ce));
z9891304430.z+=z92eab012f7*z07f5ecb949*(z305d891f1d-zdb32dd7bb1);z4e83d010c8.z+=
z92eab012f7*z07f5ecb949*z07f5ecb949;}}zb3414505e7[z28a30cf9ac*0+za2ebed4c3d*(
zba94ee46da.y/2)+(zba94ee46da.x/2)]=z9891304430.x;zfc258515dc[z09ee10c92e*0+
zec5a718d02*(zba94ee46da.y/2)+(zba94ee46da.x/2)]=z4e83d010c8.x;zb3414505e7[
z28a30cf9ac*1+za2ebed4c3d*(zba94ee46da.y/2)+(zba94ee46da.x/2)]=z9891304430.y;
zfc258515dc[z09ee10c92e*1+zec5a718d02*(zba94ee46da.y/2)+(zba94ee46da.x/2)]=
z4e83d010c8.y;zb3414505e7[z28a30cf9ac*2+za2ebed4c3d*(zba94ee46da.y/2)+(
zba94ee46da.x/2)]=z9891304430.z;zfc258515dc[z09ee10c92e*2+zec5a718d02*(
zba94ee46da.y/2)+(zba94ee46da.x/2)]=z4e83d010c8.z;
#endif
#if (z3dbd1ff682==1)
int2 zba94ee46da=(int2)(2*get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;
__global float*zb3414505e7=zaf78d04f7a+zab74441ef0.y*za57c5f2a7f+zab74441ef0.x;
uint za2ebed4c3d=za57c5f2a7f;__global float*zfc258515dc=zdf9e18478b+zab74441ef0.
y*z7429154e0f+zab74441ef0.x;uint zec5a718d02=z7429154e0f;
int y=zba94ee46da.y;

int z319328ed61=(y&1)?0:1;int x=zba94ee46da.x+z319328ed61;
float z305d891f1d=convert_float(zb5c34da6f7[z45c01651ac*y+x]);float z1222273aee=
(convert_float(zb5c34da6f7[z45c01651ac*(y-1)+x])+convert_float(zb5c34da6f7[
z45c01651ac*(y+1)+x]))*0.5f;float z04e1b71f63=(convert_float(zb5c34da6f7[
z45c01651ac*(y)+x+1])+convert_float(zb5c34da6f7[z45c01651ac*(y)+x-1]))*0.5f;
float zff400e9e97,za3158292ce;if(y&1){
zff400e9e97=z1222273aee;za3158292ce=z04e1b71f63;}else{
zff400e9e97=z04e1b71f63;za3158292ce=z1222273aee;}
float z205d564e2f=zff400e9e97+z305d891f1d+za3158292ce;float z5083031dab=1.0f/(
z205d564e2f+zd72c7cd02e);float zbda684ca95=0.f;float za2a87e6e07=0.01f;
float z3cef639adb=z305d891f1d;if(zff400e9e97>z3cef639adb)z3cef639adb=zff400e9e97
;if(za3158292ce>z3cef639adb)z3cef639adb=za3158292ce;
float z6793b7a789=z305d891f1d/(zd72c7cd02e+z205d564e2f);zbda684ca95+=zb3414505e7
[z28a30cf9ac*1+za2ebed4c3d*(y/2)+x/2]*z6793b7a789*z305d891f1d;za2a87e6e07+=
zfc258515dc[z09ee10c92e*1+zec5a718d02*(y/2)+x/2]*z6793b7a789;
if(zff400e9e97>z305d891f1d){float za461c91db7=(zff400e9e97-z305d891f1d)/(
zd72c7cd02e+zff400e9e97);if(zff400e9e97>zb32dcbfc8b){float z90e1a42944=1.0f/(
65535.0f-zb32dcbfc8b);za461c91db7=za461c91db7*(65535.0f-zff400e9e97)*z90e1a42944
;}zbda684ca95+=zb3414505e7[z28a30cf9ac*0+za2ebed4c3d*(y/2)+x/2]*za461c91db7*
zff400e9e97;za2a87e6e07+=zfc258515dc[z09ee10c92e*0+zec5a718d02*(y/2)+x/2]*
za461c91db7;}
if(za3158292ce>z305d891f1d){float z92eab012f7=(za3158292ce-z305d891f1d)/(
zd72c7cd02e+za3158292ce);if(za3158292ce>zb32dcbfc8b){float z90e1a42944=1.0f/(
65535.0f-zb32dcbfc8b);z92eab012f7=z92eab012f7*(65535.0f-za3158292ce)*z90e1a42944
;}zbda684ca95+=zb3414505e7[z28a30cf9ac*2+za2ebed4c3d*(y/2)+x/2]*z92eab012f7*
za3158292ce;za2a87e6e07+=zfc258515dc[z09ee10c92e*2+zec5a718d02*(y/2)+x/2]*
z92eab012f7;}
int z03c51b73f6=-1;if(z03c51b73f6>=0){zbda684ca95=zb3414505e7[z28a30cf9ac*
z03c51b73f6+za2ebed4c3d*(y/2)+x/2];za2a87e6e07=zfc258515dc[z09ee10c92e*
z03c51b73f6+zec5a718d02*(y/2)+x/2];if(z03c51b73f6==0)zbda684ca95=zbda684ca95*
zff400e9e97;if(z03c51b73f6==1)zbda684ca95=zbda684ca95*z305d891f1d;if(z03c51b73f6
==2)zbda684ca95=zbda684ca95*za3158292ce;}
float z333a226d58=zbda684ca95/za2a87e6e07;float ze416d94584;if(y&1){
ze416d94584=z305d891f1d+z333a226d58*0.5f;}else{
ze416d94584=z305d891f1d-z333a226d58*0.5f;}
if(ze416d94584<0.f)ze416d94584=0.f;if(ze416d94584>65535.f)ze416d94584=65535.f;
float z4633c865c6=z305d891f1d;
if(z4633c865c6<4*z2251927697){
float z7c83382301=convert_float(zb5c34da6f7[z45c01651ac*(y-1)+x-1]);float
z2495fb4eee=convert_float(zb5c34da6f7[z45c01651ac*(y-1)+x+1]);float z46d4ed32bc=
convert_float(zb5c34da6f7[z45c01651ac*(y+1)+x-1]);float z88370fd9e8=
convert_float(zb5c34da6f7[z45c01651ac*(y+1)+x+1]);float z305d891f1d=
convert_float(zb5c34da6f7[z45c01651ac*y+x]);
float z478c3e7a7c=zd72c7cd02e+z4633c865c6*0.25f;float zf98571a4b2=z478c3e7a7c+
fabs(z305d891f1d-z7c83382301);float z213a394ff0=z478c3e7a7c+fabs(z305d891f1d-
z2495fb4eee);float z6f2fea7ce9=z478c3e7a7c+fabs(z305d891f1d-z46d4ed32bc);float
z5c9d0b5092=z478c3e7a7c+fabs(z305d891f1d-z88370fd9e8);
float z7a6160e01a=1.0f/zf98571a4b2;float z4677e2724d=1.0f/z213a394ff0;float
z4bcfcb36c4=1.0f/z6f2fea7ce9;float zfaaff35a25=1.0f/z5c9d0b5092;
float zbda684ca95=z7c83382301*z7a6160e01a+z2495fb4eee*z4677e2724d+z46d4ed32bc*
z4bcfcb36c4+z88370fd9e8*zfaaff35a25;float za2a87e6e07=z7a6160e01a+z4677e2724d+
z4bcfcb36c4+zfaaff35a25;float z066ba70285=((zbda684ca95/za2a87e6e07)+z305d891f1d
)*0.5f;if(z4633c865c6<z2251927697){ze416d94584=z066ba70285;}else{
float zea34483265=(z4633c865c6-z2251927697)*(1.f/(3.f*z2251927697));float
z38c36eec91=1.0f-zea34483265;ze416d94584=z066ba70285*z38c36eec91+ze416d94584*
zea34483265;}}int z9ff4c70178=zba94ee46da.x+(1-z319328ed61);
#if 0
__global ushort*zafac32c58b=z718a062ddd+z30eaaf69b7.y*zb41a4b7008+z30eaaf69b7.x;
zafac32c58b[zb41a4b7008*y+x]=convert_ushort(ze416d94584);zafac32c58b[zb41a4b7008
*y+z9ff4c70178]=zb5c34da6f7[z45c01651ac*y+z9ff4c70178];
#else
__global ushort2*zafac32c58b=z718a062ddd+z30eaaf69b7.y*zb41a4b7008/2+z30eaaf69b7
.x/2;ushort ze6ce98b61c=zb5c34da6f7[z45c01651ac*y+z9ff4c70178];zafac32c58b[
zb41a4b7008/2*y+zba94ee46da.x/2]=(z319328ed61==0?(ushort2)(ze416d94584,
ze6ce98b61c):(ushort2)(ze6ce98b61c,ze416d94584));
#endif
#endif
#if (z3dbd1ff682==2)












int2 zba94ee46da=(int2)(2*get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;int y=zba94ee46da.y;

int z319328ed61=(y&1)?0:1;int x=zba94ee46da.x+z319328ed61;
z51b7908a0d ze416d94584=zb5c34da6f7[z45c01651ac*y+x];float z305d891f1d=
convert_float(ze416d94584);float z4633c865c6=z305d891f1d;
if(z4633c865c6<4.0f*z2251927697){
float z7c83382301=convert_float(zb5c34da6f7[z45c01651ac*(y-1)+x-1]);float
z2495fb4eee=convert_float(zb5c34da6f7[z45c01651ac*(y-1)+x+1]);float z46d4ed32bc=
convert_float(zb5c34da6f7[z45c01651ac*(y+1)+x-1]);float z88370fd9e8=
convert_float(zb5c34da6f7[z45c01651ac*(y+1)+x+1]);

float z478c3e7a7c=zd72c7cd02e+z4633c865c6*0.25f;float zf98571a4b2=z478c3e7a7c+
fabs(z305d891f1d-z7c83382301);float z213a394ff0=z478c3e7a7c+fabs(z305d891f1d-
z2495fb4eee);float z6f2fea7ce9=z478c3e7a7c+fabs(z305d891f1d-z46d4ed32bc);float
z5c9d0b5092=z478c3e7a7c+fabs(z305d891f1d-z88370fd9e8);
float z7a6160e01a=1.0f/zf98571a4b2;float z4677e2724d=1.0f/z213a394ff0;float
z4bcfcb36c4=1.0f/z6f2fea7ce9;float zfaaff35a25=1.0f/z5c9d0b5092;
float zbda684ca95=z7c83382301*z7a6160e01a+z2495fb4eee*z4677e2724d+z46d4ed32bc*
z4bcfcb36c4+z88370fd9e8*zfaaff35a25;float za2a87e6e07=z7a6160e01a+z4677e2724d+
z4bcfcb36c4+zfaaff35a25;float z066ba70285=(zbda684ca95/za2a87e6e07)*0.5f+
z305d891f1d*0.5f;if(z4633c865c6<z2251927697){ze416d94584=convert_ushort(
z066ba70285);}else{
float zea34483265=(z4633c865c6-z2251927697)/(3*z2251927697);float z38c36eec91=
1.0f-zea34483265;ze416d94584=convert_ushort(z066ba70285*z38c36eec91+z305d891f1d*
zea34483265);}}int z9ff4c70178=zba94ee46da.x+(1-z319328ed61);
#if 0
__global ushort*zafac32c58b=z718a062ddd+z30eaaf69b7.y*zb41a4b7008+z30eaaf69b7.x;
zafac32c58b[zb41a4b7008*y+x]=convert_ushort(ze416d94584);zafac32c58b[zb41a4b7008
*y+z9ff4c70178]=zb5c34da6f7[z45c01651ac*y+z9ff4c70178];
#else
__global ushort2*zafac32c58b=z718a062ddd+z30eaaf69b7.y*zb41a4b7008/2+z30eaaf69b7
.x/2;ushort ze6ce98b61c=zb5c34da6f7[z45c01651ac*y+z9ff4c70178];zafac32c58b[
zb41a4b7008/2*y+zba94ee46da.x/2]=(z319328ed61==0?(ushort2)(ze416d94584,
ze6ce98b61c):(ushort2)(ze6ce98b61c,ze416d94584));
#endif


#endif
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
