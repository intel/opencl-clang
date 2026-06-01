
#define ze0b3e74dde 700
int z07f76dfe04(float X,int z7d07bb3247,int zbf32ff9ae0,__global float4*
zcb1b02776b){while(zbf32ff9ae0-z7d07bb3247>1){int z1409a29adb=(z7d07bb3247+
zbf32ff9ae0)/2;float z6624dbc6f0=zcb1b02776b[z1409a29adb].x;
if(fabs(X-z6624dbc6f0)<0.0001f)return z1409a29adb;
if(X<z6624dbc6f0)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;}return
z7d07bb3247;}float z9369a44638(float X,__global float4*zcb1b02776b,int
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
;return Y;}float4 ze10a34b86c(float4 X,__global float4*zcb1b02776b,int
zd5275ae723){
if(zd5275ae723==0)return X;float4 z51eadf1cec;z51eadf1cec.x=z9369a44638(X.x,
zcb1b02776b,zd5275ae723);z51eadf1cec.y=z9369a44638(X.y,zcb1b02776b,zd5275ae723);
z51eadf1cec.z=z9369a44638(X.z,zcb1b02776b,zd5275ae723);z51eadf1cec.w=z9369a44638
(X.w,zcb1b02776b,zd5275ae723);return z51eadf1cec;}float4 z44df113a29(float4
z2dd09f3226,float4 za3158292ce,float4 z52ab5b652a){return((float4)1.0f-
z52ab5b652a)*z2dd09f3226+z52ab5b652a*za3158292ce;}float4 z20f7c21ce2(float4
zc6ff66a820){const float ze7168fc0b9=0.01947f;const float z6b7afb45c7=1.0f-
ze7168fc0b9;const float z45fdefb961=3.8521f;
const float4 zea271d90a7=(float4)(1.075f);const float4 zd3c0644703=(float4)(-
0.075f);
float4 z93a08e63a7=step(zc6ff66a820,(float4)(ze7168fc0b9,ze7168fc0b9,ze7168fc0b9
,ze7168fc0b9));float4 z6f583dca88=zea271d90a7*sqrt(zc6ff66a820)+zd3c0644703;
float4 z533201e483=z45fdefb961*zc6ff66a820;
zc6ff66a820=z44df113a29(z6f583dca88,z533201e483,z93a08e63a7);zc6ff66a820=clamp(
zc6ff66a820,(float4)0.0f,(float4)1.0f);return zc6ff66a820;}float4 z9d58790fd7(
float4 z2fbed55680,float z83c650c0f1){const float4 z37a59f57c4=(float4)
z83c650c0f1;
const float4 za3584c0652=(float4)0.5f;
const float4 zc180b9cdc9=za3584c0652/z37a59f57c4;const float4 z1206a65c97=
z37a59f57c4*((float4)1.0f-zc180b9cdc9)/((float4)1.0f-za3584c0652);const float4
z08ef030ac3=(float4)1.f-za3584c0652;float4 zb0d0e2be79=z2fbed55680*z37a59f57c4;
float4 z63f28d5c47=(float4)za3584c0652+(z08ef030ac3*z1206a65c97)*(z2fbed55680-
zc180b9cdc9)/(((float4)1.f-zc180b9cdc9)+(z1206a65c97-(float4)1.f)*(z2fbed55680-(
float4)zc180b9cdc9));
float4 zd6750bbf19;zd6750bbf19.x=(z2fbed55680.x<zc180b9cdc9.x?zb0d0e2be79.x:
z63f28d5c47.x);zd6750bbf19.y=(z2fbed55680.y<zc180b9cdc9.y?zb0d0e2be79.y:
z63f28d5c47.y);zd6750bbf19.z=(z2fbed55680.z<zc180b9cdc9.z?zb0d0e2be79.z:
z63f28d5c47.z);zd6750bbf19.w=(z2fbed55680.w<zc180b9cdc9.w?zb0d0e2be79.w:
z63f28d5c47.w);return zd6750bbf19;}__kernel void z465a403ee3(__global ushort4*
zb54a28f8da,float z86dd029962,float4 z61f704e443,float4 z5b8c31c8e4,float4
z8c894ba549,float4 z168b6d4c72,__global float4*z7e23fecd74,__global float4*
z06f65440fe,__global float4*z18172b051f,__global float4*z3a4ce6a4b2,__global
float4*z526e0a20fb,__global float4*z2eff277df8,__global float4*z22253e611a,
__global float4*zfc21f737d6,__global float4*z2329d52481,__global float4*
z65109f91ce,__global float4*z767917d467,__global float4*z8de83007b9,__global
float4*zaf7e394b28,int16 ze3d6faa719,int z356c788645){int zba94ee46da=4*
get_global_id(0);if(zba94ee46da>=65536){return;}float4 z9697e8d76f=(float4)(
zba94ee46da,zba94ee46da+1,zba94ee46da+2,zba94ee46da+3);z9697e8d76f/=(float4)
65535.0f;if(z356c788645<ze0b3e74dde)z9697e8d76f*=(float4)(z86dd029962);if(
z356c788645<ze0b3e74dde){z9697e8d76f=ze10a34b86c(z9697e8d76f,z7e23fecd74,
ze3d6faa719.s0);z9697e8d76f=ze10a34b86c(z9697e8d76f,z06f65440fe,ze3d6faa719.s1);
z9697e8d76f=ze10a34b86c(z9697e8d76f,z18172b051f,ze3d6faa719.s2);}else{if(
z86dd029962>1.f)z9697e8d76f=z9d58790fd7(z9697e8d76f,z86dd029962);z9697e8d76f=
ze10a34b86c(z9697e8d76f,z18172b051f,ze3d6faa719.s2);z9697e8d76f=ze10a34b86c(
z9697e8d76f,z06f65440fe,ze3d6faa719.s1);}z9697e8d76f=ze10a34b86c(z9697e8d76f,
z3a4ce6a4b2,ze3d6faa719.s3);z9697e8d76f=ze10a34b86c(z9697e8d76f,z526e0a20fb,
ze3d6faa719.s4);z9697e8d76f=z20f7c21ce2(z9697e8d76f);float4 zc86703a53f=(
z9697e8d76f-z61f704e443.s0)*z5b8c31c8e4.s0;
float4 zc38eea7454=(z9697e8d76f-z61f704e443.s1)*z5b8c31c8e4.s1;
float4 za79f679960=(z9697e8d76f-z61f704e443.s2)*z5b8c31c8e4.s2;
zc86703a53f=ze10a34b86c(zc86703a53f,z2eff277df8,ze3d6faa719.s5);zc38eea7454=
ze10a34b86c(zc38eea7454,z22253e611a,ze3d6faa719.s6);za79f679960=ze10a34b86c(
za79f679960,zfc21f737d6,ze3d6faa719.s7);if(z356c788645>=ze0b3e74dde){zc86703a53f
=z168b6d4c72.s0+(zc86703a53f*z8c894ba549.s0);
zc38eea7454=z168b6d4c72.s1+(zc38eea7454*z8c894ba549.s1);
za79f679960=z168b6d4c72.s2+(za79f679960*z8c894ba549.s2);
}zc86703a53f=(zc86703a53f-z61f704e443.s3)*z5b8c31c8e4.s3;
zc38eea7454=(zc38eea7454-z61f704e443.s3)*z5b8c31c8e4.s3;
za79f679960=(za79f679960-z61f704e443.s3)*z5b8c31c8e4.s3;
zc86703a53f=ze10a34b86c(zc86703a53f,z2329d52481,ze3d6faa719.s8);zc38eea7454=
ze10a34b86c(zc38eea7454,z2329d52481,ze3d6faa719.s8);za79f679960=ze10a34b86c(
za79f679960,z2329d52481,ze3d6faa719.s8);if(z356c788645<ze0b3e74dde){zc86703a53f=
z168b6d4c72.s0+(zc86703a53f*z8c894ba549.s0);
zc38eea7454=z168b6d4c72.s1+(zc38eea7454*z8c894ba549.s1);
za79f679960=z168b6d4c72.s2+(za79f679960*z8c894ba549.s2);
}zc86703a53f=ze10a34b86c(zc86703a53f,z65109f91ce,ze3d6faa719.s9);zc38eea7454=
ze10a34b86c(zc38eea7454,z767917d467,ze3d6faa719.sa);za79f679960=ze10a34b86c(
za79f679960,z8de83007b9,ze3d6faa719.sb);zc86703a53f=ze10a34b86c(zc86703a53f,
zaf7e394b28,ze3d6faa719.sc);zc38eea7454=ze10a34b86c(zc38eea7454,zaf7e394b28,
ze3d6faa719.sc);za79f679960=ze10a34b86c(za79f679960,zaf7e394b28,ze3d6faa719.sc);
zc86703a53f=z168b6d4c72.s3+(zc86703a53f*z8c894ba549.s3);
zc38eea7454=z168b6d4c72.s3+(zc38eea7454*z8c894ba549.s3);
za79f679960=z168b6d4c72.s3+(za79f679960*z8c894ba549.s3);

ushort4 zdb71c546a2=convert_ushort4_sat_rte(zc86703a53f*65535.0f);ushort4
zaaed6dc000=convert_ushort4_sat_rte(zc38eea7454*65535.0f);ushort4 ze9de842635=
convert_ushort4_sat_rte(za79f679960*65535.0f);zb54a28f8da[zba94ee46da]=(ushort4)
(zdb71c546a2.s0,zaaed6dc000.s0,ze9de842635.s0,0.0f);zb54a28f8da[zba94ee46da+1]=(
ushort4)(zdb71c546a2.s1,zaaed6dc000.s1,ze9de842635.s1,0.0f);zb54a28f8da[
zba94ee46da+2]=(ushort4)(zdb71c546a2.s2,zaaed6dc000.s2,ze9de842635.s2,0.0f);
zb54a28f8da[zba94ee46da+3]=(ushort4)(zdb71c546a2.s3,zaaed6dc000.s3,ze9de842635.
s3,0.0f);}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
