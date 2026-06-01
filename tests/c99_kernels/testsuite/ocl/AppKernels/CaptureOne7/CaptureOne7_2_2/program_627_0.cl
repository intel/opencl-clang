#define zbc6516e8d5  0
#define  z3dbd1ff682 3

#ifndef z3dbd1ff682
#define z3dbd1ff682 1
#endif
#ifndef zbc6516e8d5
#define zbc6516e8d5 1
#endif
#define z77a8c59ed0      0.693147180559945309417f
#define z13958d8405 4
#if zbc6516e8d5
#define z0b2156ca40 __local float
#else
#define z0b2156ca40 __global float
#endif
int z8fc26b4348(int zbda684ca95,__private float*w,__private int*z319328ed61,
float zad5f1afb1c,int z68f06eec28){int z493deefb55=zbda684ca95;while(z493deefb55
>0){z493deefb55--;
if(z319328ed61[z493deefb55]==z68f06eec28){w[z493deefb55]+=zad5f1afb1c;return
zbda684ca95;}
if(z319328ed61[z493deefb55]<z68f06eec28){z493deefb55++;break;}}
for(int z1d8bd19892=zbda684ca95;z1d8bd19892>z493deefb55;z1d8bd19892--){
z319328ed61[z1d8bd19892]=z319328ed61[z1d8bd19892-1];w[z1d8bd19892]=w[z1d8bd19892
-1];}zbda684ca95++;
z319328ed61[z493deefb55]=z68f06eec28;w[z493deefb55]=zad5f1afb1c;return
zbda684ca95;}void zcc8eb43e59(z0b2156ca40*z010f2ad427,__global float*z7a4ed4e000
,int z733454c341,int z2f8830b574,float zdea682d051,float zd996fb0ed6){float
z566aaf9327=fabs(zdea682d051);float zc74c27bc65=fabs(zd996fb0ed6);if(z566aaf9327
+zc74c27bc65<0.1f){for(int z00153ac6f8=0;z00153ac6f8<z13958d8405;z00153ac6f8++){
z0b2156ca40*z42a7c075d0=z010f2ad427+z00153ac6f8*z733454c341;__global float*
z96cff2100c=z7a4ed4e000+z00153ac6f8*z2f8830b574;for(int z5d882dbfe4=0;
z5d882dbfe4<z13958d8405;z5d882dbfe4++)z96cff2100c[z5d882dbfe4]=z42a7c075d0[
z5d882dbfe4];}return;}
if(zd996fb0ed6<0){zdea682d051=-zdea682d051;zd996fb0ed6=-zd996fb0ed6;}float
z5b8c31c8e4=0.20f;if(z5b8c31c8e4*z566aaf9327>0.5f)z5b8c31c8e4=0.5f/z566aaf9327;
if(z5b8c31c8e4*zc74c27bc65>0.5f)z5b8c31c8e4=0.5f/zc74c27bc65;__private int
z319328ed61[40];__private float w[40];float ze894fbdecd=1.0f;int zbda684ca95=0;
for(int z1d8bd19892=1;z1d8bd19892<20;z1d8bd19892++){
float z593fa3cb41=z5b8c31c8e4*z1d8bd19892;float z6e66eb558e=z593fa3cb41*
zdea682d051;float z721963480c=z593fa3cb41*zd996fb0ed6;
float zad5f1afb1c=exp(z593fa3cb41*z593fa3cb41*(float)(-4.0f*z77a8c59ed0));if(
zad5f1afb1c<0.001f)break;ze894fbdecd+=2.0f*zad5f1afb1c;
float z49cb77b4dc=floor(z6e66eb558e);float z2523506dd2=floor(z721963480c);float
ze37e281576=z6e66eb558e-z49cb77b4dc;float zd3150154e9=z721963480c-z2523506dd2;
float z5b4d275414=1.0f-ze37e281576;float z829cd1d608=1.0f-zd3150154e9;int
z478c3e7a7c=z49cb77b4dc+z733454c341*z2523506dd2;zbda684ca95=z8fc26b4348(
zbda684ca95,w,z319328ed61,zad5f1afb1c*z5b4d275414*z829cd1d608,z478c3e7a7c);
zbda684ca95=z8fc26b4348(zbda684ca95,w,z319328ed61,zad5f1afb1c*ze37e281576*
z829cd1d608,z478c3e7a7c+1);zbda684ca95=z8fc26b4348(zbda684ca95,w,z319328ed61,
zad5f1afb1c*z5b4d275414*zd3150154e9,z478c3e7a7c+z733454c341);zbda684ca95=
z8fc26b4348(zbda684ca95,w,z319328ed61,zad5f1afb1c*ze37e281576*zd3150154e9,
z478c3e7a7c+z733454c341+1);
if(zbda684ca95>36)break;}
for(int z00153ac6f8=0;z00153ac6f8<z13958d8405;z00153ac6f8++){z0b2156ca40*
z42a7c075d0=z010f2ad427+z00153ac6f8*z733454c341;__global float*z96cff2100c=
z7a4ed4e000+z00153ac6f8*z2f8830b574;for(int z5d882dbfe4=0;z5d882dbfe4<
z13958d8405;z5d882dbfe4++){
float z041ea40b45=z42a7c075d0[z5d882dbfe4];for(int z1d8bd19892=0;z1d8bd19892<
zbda684ca95;z1d8bd19892++)z041ea40b45+=w[z1d8bd19892]*(z42a7c075d0[z5d882dbfe4+
z319328ed61[z1d8bd19892]]+z42a7c075d0[z5d882dbfe4-z319328ed61[z1d8bd19892]]);
z96cff2100c[z5d882dbfe4]=z041ea40b45*(1.0f/ze894fbdecd);}}}
#ifndef z73a6d0c759
#define z73a6d0c759 5
#endif
int z07f76dfe04(float X,int z7d07bb3247,int zbf32ff9ae0,__constant float4*
zcb1b02776b){while(zbf32ff9ae0-z7d07bb3247>1){int z1409a29adb=(z7d07bb3247+
zbf32ff9ae0)/2;float z6624dbc6f0=zcb1b02776b[z1409a29adb].x;
if(fabs(X-z6624dbc6f0)<0.0001f)return z1409a29adb;
if(X<z6624dbc6f0)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;}return
z7d07bb3247;}float z9369a44638(float X,__constant float4*zcb1b02776b,int
zd5275ae723){


int z7d07bb3247=z07f76dfe04(X,0,zd5275ae723-1,zcb1b02776b);int zbf32ff9ae0=
z7d07bb3247+1;float4 za851db5bb7=zcb1b02776b[z7d07bb3247];float4 z9aac9b026f=
zcb1b02776b[zbf32ff9ae0];float zc180b9cdc9=za851db5bb7.x,za3584c0652=za851db5bb7
.y,z16e127a2c9=za851db5bb7.z;float z35bf29e99b=z9aac9b026f.x,z1a6f4c4c08=
z9aac9b026f.y,z635f0a0757=z9aac9b026f.z;
float z52ab5b652a=z35bf29e99b-zc180b9cdc9;if(fabs(z52ab5b652a)<0.0001f)return((
za3584c0652+z1a6f4c4c08)+(X-zc180b9cdc9)*(z16e127a2c9+z635f0a0757))*0.5f;
float z56807b5599=(X-zc180b9cdc9)/z52ab5b652a;float z3e7daabbc6=z56807b5599-1.0f
;
float z99cf4fd6fe=z56807b5599*z56807b5599*(z1a6f4c4c08-za3584c0652)*(3.0f-2.0f*
z56807b5599)+za3584c0652;float z593fa3cb41=(z16e127a2c9*z3e7daabbc6+z635f0a0757*
z56807b5599)*z56807b5599*z3e7daabbc6*z52ab5b652a;float Y=z99cf4fd6fe+z593fa3cb41
;return Y;}__kernel void z4954f84bce(__global float4*zf8d9fd6cb8,__global float*
z718a062ddd,int4 z30eaaf69b7,uint zfe3c1221ad,uint z7fe39fb2e6,float zcd810bcd22
,float z4f54fb944c,float z03b4733edc,float z55c265223f,int4 z3f816b30a5,
__constant float4*z13d97504f0,int za845663167,__constant float4*zca91a75b2d,int
z0b27c729fa
#if zbc6516e8d5
,__local float*zf485e5e12c
#endif
){int2 z945895b462=(int2)(get_global_id(0),get_global_id(1));
#if (z3dbd1ff682==2 || z3dbd1ff682==3)
z945895b462*=(int2)(z13958d8405,z13958d8405);
#endif
int2 zba94ee46da=z945895b462+z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;int
z2f8830b574=z7fe39fb2e6/4;int z733454c341=z2f8830b574;int z3d02be960e=(
z30eaaf69b7.w/4)*z7fe39fb2e6;int z9ff4c70178=z83640e5796.x;int zdd2d930402=
z83640e5796.y;
#if zbc6516e8d5
int z6e29e29e19=4*get_local_size(0)+2*z73a6d0c759;int2 z7cdb6ae8dd=(int2)(4*
get_local_id(0)+z73a6d0c759,4*get_local_id(1)+z73a6d0c759);__local float*
z010f2ad427=zf485e5e12c;int2 z61bac1bc70=z83640e5796-z7cdb6ae8dd;
#if (z3dbd1ff682 < 3)
int z1d2006e0ae=z3d02be960e;
#else
int z1d2006e0ae=2*z3d02be960e;
#endif
int z2cf8520e42=z61bac1bc70.x+z61bac1bc70.y*z2f8830b574+z1d2006e0ae;int
zf54614f74b=(z30eaaf69b7.z-1)+z2f8830b574*(z30eaaf69b7.w-1)+z1d2006e0ae;int
z8b1bb737a4=get_local_id(0)+get_local_id(1)*get_local_size(0);const int
z8b148203c6=32;int z4b946a6906=z8b148203c6*z8b1bb737a4;int za6fbfbc4c3=(
z73a6d0c759+4*get_local_size(1)+z73a6d0c759)*z6e29e29e19;for(int z8dd6fa68b0=0;
z8dd6fa68b0<z8b148203c6;z8dd6fa68b0++){int z38a89f6944=z4b946a6906+z8dd6fa68b0;
if(z38a89f6944<za6fbfbc4c3){int z4a5805e56d=z38a89f6944%z6e29e29e19;int
zd47cd65624=z38a89f6944/z6e29e29e19;int z95a479821b=z4a5805e56d+zd47cd65624*
z733454c341;z95a479821b=clamp(z95a479821b+z2cf8520e42,0,zf54614f74b);zf485e5e12c
[z38a89f6944]=z718a062ddd[z95a479821b];}}barrier(CLK_LOCAL_MEM_FENCE);
z010f2ad427+=z7cdb6ae8dd.x+z7cdb6ae8dd.y*z6e29e29e19;z733454c341=z6e29e29e19;
#else
#if (z3dbd1ff682 < 3)
__global float*z010f2ad427=z718a062ddd+1*z3d02be960e+z2f8830b574*zdd2d930402+
z9ff4c70178;
#else
__global float*z010f2ad427=z718a062ddd+2*z3d02be960e+z2f8830b574*zdd2d930402+
z9ff4c70178;
#endif
#endif
#if (z3dbd1ff682 < 3)
__global float*z7a4ed4e000=z718a062ddd+2*z3d02be960e+z2f8830b574*zdd2d930402+
z9ff4c70178;
#else
__global float*z7a4ed4e000=z718a062ddd+1*z3d02be960e+z2f8830b574*zdd2d930402+
z9ff4c70178;
#endif
if(z945895b462.x>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return;int
z373b9d85c4=z3f816b30a5.x;int z529404f7d5=z3f816b30a5.y;__global float4*
z5fbd1d8e7c=zf8d9fd6cb8+zfe3c1221ad*zdd2d930402+z9ff4c70178;int z0c7f0430f0=
z7fe39fb2e6/4;__global float*z8a95627795=z718a062ddd+0*z3d02be960e+z0c7f0430f0*(
zdd2d930402/4)+4*(z9ff4c70178/4);
#if (z3dbd1ff682==1)
const float z94514af1c1=0.57735026918963f;const float z00f5f2656d=
0.70710678118655f;const float zba07f76658=0.40824829046386f;float4 z6533f4e792=
z5fbd1d8e7c[0];float zff400e9e97=z6533f4e792.x;float z305d891f1d=z6533f4e792.y;
float za3158292ce=z6533f4e792.z;
float Y=(zff400e9e97+z305d891f1d+za3158292ce)*z94514af1c1;float zb92205bc30=0.0f
,z6fe8a6369c=0.0f;if(Y>0.5f){zb92205bc30=(zff400e9e97-z305d891f1d)*z00f5f2656d*(
1.0f/Y);z6fe8a6369c=(zff400e9e97+z305d891f1d-2*za3158292ce)*zba07f76658*(1.0f/Y)
;}
z5fbd1d8e7c[0]=(float4)(Y,zb92205bc30,z6fe8a6369c,0);z010f2ad427[0]=Y;
#endif
#if (z3dbd1ff682==2)
float z32d38a8179=1.0f/zcd810bcd22;
float ze31f5244df=(z9ff4c70178+z373b9d85c4+z13958d8405/2)*z32d38a8179;float
zbf0eff9685=(zdd2d930402+z529404f7d5+z13958d8405/2)*z32d38a8179;
float z5af00db07f=ze31f5244df-z4f54fb944c;float z70d5a1d4dc=zbf0eff9685-
z03b4733edc;float z568715c0ca=1e-6f+sqrt(z5af00db07f*z5af00db07f+z70d5a1d4dc*
z70d5a1d4dc);z5af00db07f*=1.0f/z568715c0ca;z70d5a1d4dc*=1.0f/z568715c0ca;
float z7bdcdf8e59=z9369a44638(z568715c0ca,z13d97504f0,za845663167);float
zb058b4089a=z9369a44638(z568715c0ca,zca91a75b2d,z0b27c729fa);if(z7bdcdf8e59<0)
z7bdcdf8e59=0;if(zb058b4089a<0)zb058b4089a=0;
float zdea682d051=z7bdcdf8e59*z5af00db07f;float zd996fb0ed6=z7bdcdf8e59*
z70d5a1d4dc;float z4bcdbc4d23=-zb058b4089a*z70d5a1d4dc;float z5c8f98d456=
zb058b4089a*z5af00db07f;




zdea682d051*=zcd810bcd22;zd996fb0ed6*=zcd810bcd22;z4bcdbc4d23*=zcd810bcd22;
z5c8f98d456*=zcd810bcd22;
z8a95627795[0]=z4bcdbc4d23;z8a95627795[1]=z5c8f98d456;

zcc8eb43e59(z010f2ad427,z7a4ed4e000,z733454c341,z2f8830b574,zdea682d051,
zd996fb0ed6);
#endif
#if (z3dbd1ff682==3)

float z4bcdbc4d23=z8a95627795[0];float z5c8f98d456=z8a95627795[1];

zcc8eb43e59(z010f2ad427,z7a4ed4e000,z733454c341,z2f8830b574,z4bcdbc4d23,
z5c8f98d456);
#endif
#if (z3dbd1ff682==4)
const float z94514af1c1=0.57735026918963f;const float z00f5f2656d=
0.70710678118655f;const float zba07f76658=0.40824829046386f;float4 z6533f4e792=
z5fbd1d8e7c[0];float Y=z6533f4e792.x;float zb92205bc30=z6533f4e792.y;float
z6fe8a6369c=z6533f4e792.z;
float z707644e5be=z55c265223f;
Y=Y*(1.0f+z707644e5be)-z707644e5be*z7a4ed4e000[0];
zb92205bc30*=Y;z6fe8a6369c*=Y;float zff400e9e97=(z94514af1c1*Y+zba07f76658*
z6fe8a6369c)+z00f5f2656d*zb92205bc30;float z305d891f1d=(z94514af1c1*Y+
zba07f76658*z6fe8a6369c)-z00f5f2656d*zb92205bc30;float za3158292ce=z94514af1c1*Y
-(2*zba07f76658)*z6fe8a6369c;
z5fbd1d8e7c[0]=(float4)(zff400e9e97,z305d891f1d,za3158292ce,0);
#endif
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
