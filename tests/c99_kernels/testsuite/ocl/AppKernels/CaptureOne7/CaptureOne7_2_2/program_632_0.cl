typedef struct{float4 z70c20e9465[16];

}z7cd840ce22;int z07f76dfe04(float x,int z7d07bb3247,int zbf32ff9ae0,__constant
float4*zcb1b02776b){while(zbf32ff9ae0-z7d07bb3247>1){int z1409a29adb=(
z7d07bb3247+zbf32ff9ae0)/2;float z6624dbc6f0=zcb1b02776b[z1409a29adb].x;
if(fabs(x-z6624dbc6f0)<0.0001f)return z1409a29adb;
if(x<z6624dbc6f0)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;}return
z7d07bb3247;}float z9369a44638(float x,__constant float4*zcb1b02776b,int
zd5275ae723){


int z7d07bb3247=z07f76dfe04(x,0,zd5275ae723-1,zcb1b02776b);int zbf32ff9ae0=
z7d07bb3247+1;float4 za851db5bb7=zcb1b02776b[z7d07bb3247];float4 z9aac9b026f=
zcb1b02776b[zbf32ff9ae0];float zc180b9cdc9=za851db5bb7.x,za3584c0652=za851db5bb7
.y,z16e127a2c9=za851db5bb7.z;float z35bf29e99b=z9aac9b026f.x,z1a6f4c4c08=
z9aac9b026f.y,z635f0a0757=z9aac9b026f.z;
float z52ab5b652a=z35bf29e99b-zc180b9cdc9;if(fabs(z52ab5b652a)<0.0001f)return((
za3584c0652+z1a6f4c4c08)+(x-zc180b9cdc9)*(z16e127a2c9+z635f0a0757))*0.5f;
float z56807b5599=(x-zc180b9cdc9)/z52ab5b652a;float z3e7daabbc6=z56807b5599-1.0f
;
float z99cf4fd6fe=z56807b5599*z56807b5599*(z1a6f4c4c08-za3584c0652)*(3.0f-2.0f*
z56807b5599)+za3584c0652;float z593fa3cb41=(z16e127a2c9*z3e7daabbc6+z635f0a0757*
z56807b5599)*z56807b5599*z3e7daabbc6*z52ab5b652a;float y=z99cf4fd6fe+z593fa3cb41
;return y;}
#if 0
float z9369a44638(float z2fbed55680,__constant float4*z2edf709f19,int
z710c525abc){int zc3a80cbc58=z710c525abc;int z1d8bd19892=1;while((z1d8bd19892<(
zc3a80cbc58-1))&&(z2fbed55680>z2edf709f19[z1d8bd19892].x))z1d8bd19892++;float4
z2d351c5ace=z2edf709f19[z1d8bd19892-1];float4 z3931fc4ce8=z2edf709f19[
z1d8bd19892];z2d351c5ace.w=-z2d351c5ace.x;z3931fc4ce8.w=z2fbed55680;float4
ze6ee5ad5cd=z2d351c5ace+z3931fc4ce8;float4 z333a226d58=z3931fc4ce8-z2d351c5ace;


float z56807b5599=ze6ee5ad5cd.w/z333a226d58.x;float z3e7daabbc6=z56807b5599-1.0f
;float4 z7c852f09b4=z56807b5599*(float4)(z333a226d58.x,z333a226d58.y,2.0f,0.0f);
float z99cf4fd6fe=z56807b5599*z7c852f09b4.y*(3.0f-z7c852f09b4.z)+z2d351c5ace.y;
float z593fa3cb41=dot((float2)(z2d351c5ace.z,z3931fc4ce8.z),(float2)(z3e7daabbc6
,z56807b5599))*z3e7daabbc6*z7c852f09b4.x;float z455eeedfd5=z99cf4fd6fe+
z593fa3cb41;if(z333a226d58.x<0.0001f)z455eeedfd5=(ze6ee5ad5cd.y+ze6ee5ad5cd.w*
ze6ee5ad5cd.z)*0.5f;return z455eeedfd5;}
#endif
__kernel void z181b8373ba(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,uint z021babbfad,uint z958df11031,int2 zb78e1f8f0a,
float2 zf897261185,float z6df7ccb0a4,__constant float4*z526ad5087b,int
za2be633d70){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));float2
z0223c8cb53=convert_float2((int2)(get_global_id(0),get_global_id(1)));if(
z0223c8cb53.x>=z30eaaf69b7.z||z0223c8cb53.y>=z30eaaf69b7.w)return;zba94ee46da+=
z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;float4 z493deefb55=zf8d9fd6cb8[
z83640e5796.x+z83640e5796.y*(z021babbfad/4)];



float2 z5ab52425f2=z6df7ccb0a4*(convert_float2(zb78e1f8f0a)+z0223c8cb53)-
zf897261185;float z568715c0ca=length(z5ab52425f2);

float zcf626b3ff6=z9369a44638(z568715c0ca,z526ad5087b,za2be633d70);

float z86dd029962=exp(-0.69314718055994530942f*zcf626b3ff6);z493deefb55*=
z86dd029962;z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z493deefb55
;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
