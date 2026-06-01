#define z3dbd1ff682 2

#define zec15f7fa83(zff400e9e97, z305d891f1d, za3158292ce) (zff400e9e97 * 0.299f\
 + z305d891f1d *  0.587f + za3158292ce *  0.114f)
#define MIN min
#define MAX max
#ifndef z3dbd1ff682
#define z3dbd1ff682 0
#endif
#if z3dbd1ff682==0
__kernel void z05fab7fbaa(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,uint z2824fcf57d,uint z9562068e13,float8
z3c211c8179){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7
.s01;float z64a05257f8=z3c211c8179.s0;float z947813c07b=z3c211c8179.s1;float
z19f71788a3=z3c211c8179.s2;float z76610c7332=z3c211c8179.s3;float ze82613f501=
z3c211c8179.s4;float z0a00e1c231=z3c211c8179.s5;
float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];float4
ze4351005bc=z493deefb55;float ze4b052164b=z493deefb55.x;
float z2e91460297=z493deefb55.y;
float z7e674d442a=z493deefb55.z;
if(z64a05257f8<MIN(z947813c07b,z19f71788a3)){if(z2e91460297/z947813c07b<
z76610c7332&&z2e91460297>ze4b052164b){float zcfff1e38a8=z2e91460297*(1.f/(
z76610c7332*z947813c07b));zcfff1e38a8=MAX(ze82613f501,MIN(1.f,zcfff1e38a8));
z2e91460297=zcfff1e38a8*z2e91460297+(1.f-zcfff1e38a8)*z2e91460297/z947813c07b;
z2e91460297=MAX(z2e91460297,ze4b052164b);}if(z7e674d442a/z19f71788a3<z76610c7332
&&z7e674d442a>ze4b052164b){float ze4d1094aab=z7e674d442a*(1.f/(z76610c7332*
z19f71788a3));ze4d1094aab=MAX(ze82613f501,MIN(1.f,ze4d1094aab));z7e674d442a=
ze4d1094aab*z7e674d442a+(1.f-ze4d1094aab)*z7e674d442a/z19f71788a3;z7e674d442a=
MAX(z7e674d442a,ze4b052164b);}}else if(z19f71788a3<MIN(z64a05257f8,z947813c07b))
{if(z2e91460297/z947813c07b<z76610c7332&&z2e91460297>z7e674d442a){float
zcfff1e38a8=z2e91460297*(1.f/(z76610c7332*z947813c07b));zcfff1e38a8=MAX(
ze82613f501,MIN(1.f,zcfff1e38a8));z2e91460297=zcfff1e38a8*z2e91460297+(1.f-
zcfff1e38a8)*z2e91460297/z947813c07b;z2e91460297=MAX(z2e91460297,z7e674d442a);}
if(ze4b052164b/z64a05257f8<z76610c7332&&ze4b052164b>z7e674d442a){float
zbffee8d12d=ze4b052164b*(1.f/(z76610c7332*z64a05257f8));zbffee8d12d=MAX(
ze82613f501,MIN(1.f,zbffee8d12d));ze4b052164b=zbffee8d12d*ze4b052164b+(1.f-
zbffee8d12d)*ze4b052164b/z64a05257f8;ze4b052164b=MAX(ze4b052164b,z7e674d442a);}}
else{
if(ze4b052164b/z64a05257f8<z76610c7332&&ze4b052164b>z2e91460297){float
zbffee8d12d=ze4b052164b*(1.f/(z76610c7332*z64a05257f8));zbffee8d12d=MAX(
ze82613f501,MIN(1.f,zbffee8d12d));ze4b052164b=zbffee8d12d*ze4b052164b+(1.f-
zbffee8d12d)*ze4b052164b/z64a05257f8;ze4b052164b=MAX(ze4b052164b,z2e91460297);}
if(z7e674d442a/z19f71788a3<z76610c7332&&z7e674d442a>z2e91460297){float
ze4d1094aab=z7e674d442a*(1.f/(z76610c7332*z19f71788a3));ze4d1094aab=MAX(
ze82613f501,MIN(1.f,ze4d1094aab));z7e674d442a=ze4d1094aab*z7e674d442a+(1.f-
ze4d1094aab)*z7e674d442a/z19f71788a3;z7e674d442a=MAX(z7e674d442a,z2e91460297);}}
float z5413c0ac97=zec15f7fa83(ze4b052164b,z2e91460297,z7e674d442a);float
z7a5269b418=MAX(ze4b052164b*(1.f/z64a05257f8),z2e91460297*(1.f/z947813c07b));
z7a5269b418=MAX(z7a5269b418,z7e674d442a*(1.f/z19f71788a3));
float z2da58847dd=(z7a5269b418)*(1.f/(z0a00e1c231));z2da58847dd=MAX(0.f,
z2da58847dd);
z2da58847dd=MIN(1.f,z2da58847dd);
float z1b7de220ba=1.f-z2da58847dd;ze4351005bc.s0=ze4b052164b*z2da58847dd+
z5413c0ac97*z1b7de220ba;ze4351005bc.s1=z2e91460297*z2da58847dd+z5413c0ac97*
z1b7de220ba;ze4351005bc.s2=z7e674d442a*z2da58847dd+z5413c0ac97*z1b7de220ba;
z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=ze4351005bc;}
#endif
#if (z3dbd1ff682==1 )
__kernel void z05fab7fbaa(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,uint z2824fcf57d,uint z9562068e13,__global float4*
zef5c0838c9,int4 z81d7a0be03,int z88a2348c53){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int2 z3ab3068e4a=zba94ee46da+z81d7a0be03
.s01;int z956e52b9fb=z81d7a0be03.s2;__global float4*z395b96baac=zf8d9fd6cb8+
z83640e5796.x+z83640e5796.y*z2824fcf57d;z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*
z9562068e13]=z395b96baac[0];float4 z493deefb55=(float4)0.0f;const int
zff400e9e97=z88a2348c53/2;for(int Y=-zff400e9e97;Y<=zff400e9e97;Y++)for(int X=-
zff400e9e97;X<=zff400e9e97;X++)z493deefb55+=z395b96baac[X+Y*z2824fcf57d];
zef5c0838c9[z3ab3068e4a.x+z3ab3068e4a.y*z956e52b9fb]=z493deefb55/convert_float(
z88a2348c53*z88a2348c53);
}
#endif
#if (z3dbd1ff682==2)
__kernel void z05fab7fbaa(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,uint z2824fcf57d,uint z9562068e13,__global float4*
zef5c0838c9,int4 z81d7a0be03,float4 z5efcf3d363,float4 z2e83c0ac43,uint
z252d4407c9,__constant float*ze905c2dc27){int2 zba94ee46da=(int2)(get_global_id(
0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=
z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int2 z3ab3068e4a=zba94ee46da+z81d7a0be03
.s01;int z956e52b9fb=z81d7a0be03.s2;float4 z95f01fc445=zef5c0838c9[z3ab3068e4a.x
+z3ab3068e4a.y*z956e52b9fb];float4 z4a812e6521=zf8d9fd6cb8[z83640e5796.x+
z83640e5796.y*z2824fcf57d];float4 z99d180a5e2=z718a062ddd[zaaf414d14e.x+
zaaf414d14e.y*z9562068e13];



float4 zd401781ea4=z4a812e6521.xxxx;if(z252d4407c9==1)zd401781ea4=z4a812e6521.
yyyy;if(z252d4407c9==2)zd401781ea4=z4a812e6521.zzzz;

z95f01fc445*=(1.f/(z5efcf3d363));
int4 z8dd6fa68b0=convert_int4(clamp(z95f01fc445,(float4)0.0f,(float4)511.0f));
float4 z4ff14c3041=(float4)(ze905c2dc27[z8dd6fa68b0.x],ze905c2dc27[z8dd6fa68b0.y
],ze905c2dc27[z8dd6fa68b0.z],0.0f);
float4 z62ca8b8eee=max(zd401781ea4,z4a812e6521-z5efcf3d363*z4ff14c3041+
z4ff14c3041);z62ca8b8eee.w=z99d180a5e2.w;z99d180a5e2=((z5efcf3d363>(float4)
1.001f&&z95f01fc445<=z2e83c0ac43&&z4a812e6521>=zd401781ea4)?z62ca8b8eee:
z99d180a5e2);z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=z99d180a5e2;}
#endif
#if z3dbd1ff682==3
__kernel void z05fab7fbaa(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,uint z2824fcf57d,uint z9562068e13,float z0a00e1c231
,float4 z3c211c8179){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));
if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7
.s01;float z64a05257f8=z3c211c8179.s0;float z947813c07b=z3c211c8179.s1;float
z19f71788a3=z3c211c8179.s2;
float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];float4
ze4351005bc=z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13];
float z58a4e67e73=z493deefb55.x;
float zd928a563e0=z493deefb55.y;
float z3c5db70fd3=z493deefb55.z;

float z5413c0ac97=(z58a4e67e73*(1.f/z64a05257f8)+zd928a563e0*(2.f/z947813c07b)+
z3c5db70fd3*(1.f/z19f71788a3))*0.25f;float z7a5269b418=max(z58a4e67e73*(1.f/
z64a05257f8),zd928a563e0*(1.f/z947813c07b));z7a5269b418=max(z7a5269b418,
z3c5db70fd3*(1.f/z19f71788a3));
if(z7a5269b418>z0a00e1c231)return;
float z2da58847dd=(z7a5269b418)*(1.f/(z0a00e1c231));z2da58847dd=max(0.f,
z2da58847dd);

float z1b7de220ba=1.f-z2da58847dd;
z1b7de220ba*=z1b7de220ba;z2da58847dd=1.f-z1b7de220ba;





ze4351005bc=z2da58847dd*ze4351005bc+z1b7de220ba*(float4)(z5413c0ac97);
z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=ze4351005bc;}
#endif
#if 0
float z043348f876[4]={z64a05257f8,z947813c07b,z19f71788a3,0.0f};float
z49f97ff670[4]={0.0f,0.0f,0.0f,0.0f};if(z272d3543ee){int zb93c16b5cc[4]={
zef5c0838c9->zaf1774923b(),zef5c0838c9->z98eb561e0d(),zef5c0838c9->z23f77c619d()
,0};z36bedad4c3*ze7168fc0b9=z272d3543ee->ze7168fc0b9->z294817e8db;ze7168fc0b9->
z6e3b7f6033(5,sizeof(cl_mem),(void*)&zef5c0838c9->z8f4b944278->z9afd92541d);
ze7168fc0b9->z6e3b7f6033(6,sizeof(zb93c16b5cc),zb93c16b5cc);ze7168fc0b9->
z6e3b7f6033(7,sizeof(z043348f876),(void*)z043348f876);ze7168fc0b9->z6e3b7f6033(8
,sizeof(z49f97ff670),(void*)z49f97ff670);ze7168fc0b9->z6e3b7f6033(9,sizeof(
cl_int),(void*)&z252d4407c9);za6c557b086 zbda684ca95=ze7168fc0b9->z6029443157(
zf8d9fd6cb8,z718a062ddd,z272d3543ee->z11fc704ac4,z272d3543ee->zd579e88598,
z6708f8db12);}else{
for(int za9922537b1=0;za9922537b1<3;za9922537b1++){float z5efcf3d363=z043348f876
[za9922537b1];float z2e83c0ac43=z49f97ff670[za9922537b1];if(z5efcf3d363>1.001f){
for(int y=0;y<z22c51f4668;y++){if(zaf13125e36)return;for(int x=0;x<z6fa5659bb8;x
++){float z95f01fc445=z1817b3ec89[3*x+y*z36948e92e2+za9922537b1];
if(z95f01fc445>z2e83c0ac43)continue;
float zd401781ea4=zba15fb8bb8[3*x+y*z45c01651ac+z252d4407c9];if(zba15fb8bb8[3*x+
y*z45c01651ac+za9922537b1]<zd401781ea4)continue;
z95f01fc445*=(1.f/(z5efcf3d363));ze4bbc40207(z95f01fc445<=z2e83c0ac43&&(int)
z95f01fc445>=0);float z4ff14c3041=ze905c2dc27[(int)(z95f01fc445)];
zddaa6f652d[3*x+y*zb41a4b7008+za9922537b1]=MAX(zd401781ea4,zba15fb8bb8[3*x+y*
z45c01651ac+za9922537b1]-z5efcf3d363*z4ff14c3041+z4ff14c3041);}}}}}
if(z272d3543ee){z36bedad4c3*ze7168fc0b9=z272d3543ee->ze7168fc0b9->z54b4afa6f6;
ze7168fc0b9->z6e3b7f6033(5,sizeof(float),(void*)&z0a00e1c231);ze7168fc0b9->
z6e3b7f6033(6,sizeof(z043348f876),(void*)z043348f876);za6c557b086 zbda684ca95=
ze7168fc0b9->z6029443157(zf8d9fd6cb8,z718a062ddd,z272d3543ee->z11fc704ac4,
z272d3543ee->zd579e88598,z6708f8db12);}else{for(int y=0;y<z22c51f4668;y++){if(
zaf13125e36)return;for(int x=0;x<z6fa5659bb8;x++){
float z58a4e67e73=zba15fb8bb8[3*x+y*z45c01651ac+0];float zd928a563e0=zba15fb8bb8
[3*x+y*z45c01651ac+1];float z3c5db70fd3=zba15fb8bb8[3*x+y*z45c01651ac+2];
float z5413c0ac97=(z58a4e67e73*(1.f/z64a05257f8)+zd928a563e0*(2.f/z947813c07b)+
z3c5db70fd3*(1.f/z19f71788a3))*0.25f;float z7a5269b418=MAX(z58a4e67e73*(1.f/
z64a05257f8),zd928a563e0*(1.f/z947813c07b));z7a5269b418=MAX(z7a5269b418,
z3c5db70fd3*(1.f/z19f71788a3));
if(z7a5269b418>z0a00e1c231)continue;float z2da58847dd=(z7a5269b418)*(1.f/(
z0a00e1c231));z2da58847dd=MAX(0.f,z2da58847dd);

float z1b7de220ba=1.f-z2da58847dd;
z1b7de220ba*=z1b7de220ba;z2da58847dd=1.f-z1b7de220ba;float z77b77068b3=
zddaa6f652d[3*x+y*zb41a4b7008+0];float z49863d9014=zddaa6f652d[3*x+y*zb41a4b7008
+1];float z585b87d822=zddaa6f652d[3*x+y*zb41a4b7008+2];zddaa6f652d[3*x+y*
zb41a4b7008+0]=z77b77068b3*z2da58847dd+(z5413c0ac97*z1b7de220ba);zddaa6f652d[3*x
+y*zb41a4b7008+1]=z49863d9014*z2da58847dd+(z5413c0ac97*z1b7de220ba);zddaa6f652d[
3*x+y*zb41a4b7008+2]=z585b87d822*z2da58847dd+(z5413c0ac97*z1b7de220ba);}}}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
