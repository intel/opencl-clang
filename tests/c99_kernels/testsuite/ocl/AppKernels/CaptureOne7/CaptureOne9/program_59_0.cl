
#define z17a085e5c8			3.0f
int z07f76dfe04(float X,int z7d07bb3247,int zbf32ff9ae0,__constant float4*
zcb1b02776b){while(zbf32ff9ae0-z7d07bb3247>1){int z1409a29adb=(z7d07bb3247+
zbf32ff9ae0)/2;float z6624dbc6f0=zcb1b02776b[z1409a29adb].x;
#if 0
if(fabs(X-z6624dbc6f0)<0.0001f)return z1409a29adb;
if(X<z6624dbc6f0)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;
#else

if(fabs(X-z6624dbc6f0)<0.0001f){
z7d07bb3247=z1409a29adb;zbf32ff9ae0=-1;}else{
if(X<z6624dbc6f0)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;}
#endif
}return z7d07bb3247;}float z9369a44638(float X,__constant float4*zcb1b02776b,int
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
;return Y;}float zcfffc38948(float zc57e25437f,__constant float4*z2edf709f19,int
 zc3a80cbc58){float z5462909dc1=z9369a44638(zc57e25437f,z2edf709f19,zc3a80cbc58)
;
if(z5462909dc1>+z17a085e5c8)z5462909dc1=+z17a085e5c8;if(z5462909dc1<-z17a085e5c8
)z5462909dc1=-z17a085e5c8;return z5462909dc1;}__kernel void zceef100835(__global
 float4*zf8d9fd6cb8,__global float4*z718a062ddd,int4 z30eaaf69b7,int z021babbfad
,int z6d12415108,float2 zfe5849ca60,float2 zf897261185,__constant float4*
za80b27518d,int z7054fd23fd,__constant float4*z4135b87944,int zb049e6b30d){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));float2 z0223c8cb53=
convert_float2((int2)(8*get_global_id(0),8*get_global_id(1)));if(zba94ee46da.x>=
z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;

float2 z2e91460297=z0223c8cb53+zfe5849ca60+(float2)(0.5f,0.5f);







float2 z2dff091eda=z2e91460297-zf897261185;float zc57e25437f=length(z2dff091eda)
;






float2 z5083031dab;z5083031dab.x=zcfffc38948(zc57e25437f,za80b27518d,z7054fd23fd
);z5083031dab.y=zcfffc38948(zc57e25437f,z4135b87944,zb049e6b30d);



if(zc57e25437f<20.0f)z5083031dab=(float2)(0.0f,10000.0f);z718a062ddd[zba94ee46da
.x+zba94ee46da.y*(z6d12415108)]=(float4)(z5083031dab,0.0f,0.0f);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
