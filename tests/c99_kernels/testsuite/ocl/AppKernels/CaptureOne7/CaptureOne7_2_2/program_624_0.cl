
#define z17a085e5c8			3.0f
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
;return Y;}
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
float zcfffc38948(float zc57e25437f,__constant float4*z2edf709f19,int
zc3a80cbc58){float z5462909dc1=z9369a44638(zc57e25437f,z2edf709f19,zc3a80cbc58);
if(z5462909dc1>+z17a085e5c8)z5462909dc1=+z17a085e5c8;if(z5462909dc1<-z17a085e5c8
)z5462909dc1=-z17a085e5c8;return z5462909dc1;}__kernel void z88d05a530c(__global
 float4*zf8d9fd6cb8,__global float4*z718a062ddd,int4 z30eaaf69b7,uint
z021babbfad,uint z958df11031,float2 zfe5849ca60,float2 zf897261185,float
z6df7ccb0a4,float zcd810bcd22,__constant float4*za80b27518d,int z7054fd23fd,
__constant float4*z4135b87944,int zb049e6b30d){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));float2 z0223c8cb53=convert_float2((int2)(
get_global_id(0),get_global_id(1)));if(z0223c8cb53.x>=z30eaaf69b7.z||z0223c8cb53
.y>=z30eaaf69b7.w)return;

float2 z2e91460297=z0223c8cb53+zfe5849ca60;
z2e91460297=z6df7ccb0a4*z2e91460297;

zba94ee46da+=z30eaaf69b7.xy;float4 z01c4ded5fa=zf8d9fd6cb8[zba94ee46da.x+
zba94ee46da.y*(z021babbfad/4)];



float2 z2dff091eda=z2e91460297-zf897261185;float zc57e25437f=length(z2dff091eda)
;
if(zc57e25437f<0.001f){z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=
z01c4ded5fa;return;}float z90e1a42944=1.0f/zc57e25437f;z2dff091eda=z90e1a42944*
z2dff091eda;


float2 z5083031dab;z5083031dab.x=zcfffc38948(zc57e25437f,za80b27518d,z7054fd23fd
);z5083031dab.y=zcfffc38948(zc57e25437f,z4135b87944,zb049e6b30d);z5083031dab=
zcd810bcd22*z5083031dab;float2 ze4b052164b=z5083031dab.x*z2dff091eda;float2
z7e674d442a=z5083031dab.y*z2dff091eda;



int2 zedcf14f019=convert_int2(floor(ze4b052164b));float2 zaec20d4434=ze4b052164b
-floor(ze4b052164b);int2 z7d4224f715=zba94ee46da+zedcf14f019;float4 z9d6d310443=
zf8d9fd6cb8[z7d4224f715.x+z7d4224f715.y*(z021babbfad/4)];float4 z05b9b9f342=
zf8d9fd6cb8[1+z7d4224f715.x+z7d4224f715.y*(z021babbfad/4)];float4 z10f7a29f4f=
zf8d9fd6cb8[z7d4224f715.x+(1+z7d4224f715.y)*(z021babbfad/4)];float4 z6c4fb551d9=
zf8d9fd6cb8[1+z7d4224f715.x+(1+z7d4224f715.y)*(z021babbfad/4)];float z447f0a5e7f
=z9d6d310443.x+(z05b9b9f342.x-z9d6d310443.x)*zaec20d4434.x;float z910bdf5bb9=
z10f7a29f4f.x+(z6c4fb551d9.x-z10f7a29f4f.x)*zaec20d4434.x;z01c4ded5fa.x=
z447f0a5e7f+(z910bdf5bb9-z447f0a5e7f)*zaec20d4434.y;int2 z917aea50ed=
convert_int2(floor(z7e674d442a));float2 z02168f5f79=z7e674d442a-floor(
z7e674d442a);z7d4224f715=zba94ee46da+z917aea50ed;z9d6d310443=zf8d9fd6cb8[
z7d4224f715.x+z7d4224f715.y*(z021babbfad/4)];z05b9b9f342=zf8d9fd6cb8[1+
z7d4224f715.x+z7d4224f715.y*(z021babbfad/4)];z10f7a29f4f=zf8d9fd6cb8[z7d4224f715
.x+(1+z7d4224f715.y)*(z021babbfad/4)];z6c4fb551d9=zf8d9fd6cb8[1+z7d4224f715.x+(1
+z7d4224f715.y)*(z021babbfad/4)];float z734efc75b7=z9d6d310443.z+(z05b9b9f342.z-
z9d6d310443.z)*z02168f5f79.x;float z1f81140e38=z10f7a29f4f.z+(z6c4fb551d9.z-
z10f7a29f4f.z)*z02168f5f79.x;z01c4ded5fa.z=z734efc75b7+(z1f81140e38-z734efc75b7)
*z02168f5f79.y;
#if 0
float*zc2a6e800a9=(float*)((z0f1072850a*)z5fbd1d8e7c+z733454c341*zcf71a4cbd5)+3*
za4829e5199;float z2e91460297=zc2a6e800a9[1];
{int z054221b964=z22f801d94a(zdff1277f95);int z66e6cddb23=z22f801d94a(
z1a8b9fdd0c);float z36e6bfdfbb=zdff1277f95-z054221b964;float z2fcefb9f13=
z1a8b9fdd0c-z66e6cddb23;float*zb94873c904=(float*)((z0f1072850a*)zc2a6e800a9+
z733454c341*z66e6cddb23)+3*z054221b964;float*z3e6e8dbac0=(float*)((z0f1072850a*)
zb94873c904+z733454c341);float z447f0a5e7f=zb94873c904[0]+(zb94873c904[3]-
zb94873c904[0])*z36e6bfdfbb;float z910bdf5bb9=z3e6e8dbac0[0]+(z3e6e8dbac0[3]-
z3e6e8dbac0[0])*z36e6bfdfbb;ze4b052164b=z447f0a5e7f+(z910bdf5bb9-z447f0a5e7f)*
z2fcefb9f13;}
{int z70fc1c8a91=z22f801d94a(z90973db381);int z2806aa0a65=z22f801d94a(
zc454b6f6b8);float ze528aac2d1=z90973db381-z70fc1c8a91;float z4cb27e511f=
zc454b6f6b8-z2806aa0a65;float*zb3b26d5875=(float*)((z0f1072850a*)zc2a6e800a9+
z733454c341*z2806aa0a65)+3*z70fc1c8a91;float*z9adbc629d6=(float*)((z0f1072850a*)
zb3b26d5875+z733454c341);float z734efc75b7=zb3b26d5875[2]+(zb3b26d5875[5]-
zb3b26d5875[2])*ze528aac2d1;float z1f81140e38=z9adbc629d6[2]+(z9adbc629d6[5]-
z9adbc629d6[2])*ze528aac2d1;z7e674d442a=z734efc75b7+(z1f81140e38-z734efc75b7)*
z4cb27e511f;}
#endif

z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z01c4ded5fa;

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
