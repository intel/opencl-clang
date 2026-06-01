#define z3dbd1ff682 2

#ifndef z3dbd1ff682
#define z3dbd1ff682 5
#endif
#ifndef zbc6516e8d5
#define zbc6516e8d5 0
#endif
#define MAX max
#define zba5c6acf5c fabs
#define zf0531aada3 32.0f
void z1c06a63f34(__local float4*zf485e5e12c,int ze12af1c5cf,__global float4*
zf8d9fd6cb8,int zc9d655d235){zf485e5e12c[ze12af1c5cf]=zf8d9fd6cb8[zc9d655d235];}
#if (z3dbd1ff682==0)
__kernel void z4d7244ce93(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13){int2 zba94ee46da=(
int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=z30eaaf69b7.s45+
zba94ee46da;__global float4*z395b96baac=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*
z2824fcf57d;int2 zaaf414d14e=z30eaaf69b7.s01+zba94ee46da;__global float4*
ze4351005bc=z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*z9562068e13;ze4351005bc[0]=
z395b96baac[0];}
#endif
#if (z3dbd1ff682==1)
__kernel void z4d7244ce93(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,__global uchar*
z749ad23d69,int4 zddebabba4e){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.
s3)return;const float z758719f481=(float)(zf0531aada3);int2 z83640e5796=
z30eaaf69b7.s45+zba94ee46da;__global float4*z395b96baac=zf8d9fd6cb8+z83640e5796.
x+z83640e5796.y*z2824fcf57d;int2 zaaf414d14e=z30eaaf69b7.s01+zba94ee46da;
__global float4*ze4351005bc=z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*z9562068e13;
int2 za523f29d90=zddebabba4e.s01+zba94ee46da;__global uchar*z353235e1f9=
z749ad23d69+za523f29d90.x+za523f29d90.y*zddebabba4e.s2;float4 z00cdc99c5b=
z395b96baac[0];

float zac5cffb9fe=z00cdc99c5b.x;
float z78e5f3d8ec=z00cdc99c5b.y;
float z09a63c2436=z00cdc99c5b.z;
float zc1a7596d5d=(zac5cffb9fe+2.f*z78e5f3d8ec+z09a63c2436)*0.25f+z758719f481;
float z2dd09f3226=zac5cffb9fe-z78e5f3d8ec;float za3158292ce=z09a63c2436-
z78e5f3d8ec;
float z5b72300895=1.f/zc1a7596d5d;z2dd09f3226=z2dd09f3226*z5b72300895;
za3158292ce=za3158292ce*z5b72300895;






float z7ff15748f5=convert_float(z353235e1f9[0])*(1.f/255.f);
ze4351005bc[0]=(float4)(zc1a7596d5d,z2dd09f3226,za3158292ce,z7ff15748f5);}
#endif
#if (z3dbd1ff682==2)
__kernel void z4d7244ce93(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13){int2 zba94ee46da=(
int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=z30eaaf69b7.s45+
zba94ee46da;__global float4*z395b96baac=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*
z2824fcf57d;int2 zaaf414d14e=z30eaaf69b7.s01+zba94ee46da;__global float4*
ze4351005bc=z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*z9562068e13;float4
z00cdc99c5b=z395b96baac[0];











float zf8bc541aad=z00cdc99c5b.s0;
float z08ef030ac3=z00cdc99c5b.s1;
float z7e674d442a=z00cdc99c5b.s2;

float z78e5f3d8ec=ze4351005bc[0].y;
float zac5cffb9fe=z08ef030ac3*zf8bc541aad+z78e5f3d8ec;float z09a63c2436=
z7e674d442a*zf8bc541aad+z78e5f3d8ec;zac5cffb9fe=MAX(zac5cffb9fe,1.f);z09a63c2436
=MAX(z09a63c2436,1.f);
#if 0
if(FALSE&&z033ebfdc7e){const float zbfb6939efb=1.5f;const float z758719f481=(
float)(zf0531aada3);float zff5c9644ab=zec15f7fa83(zac5cffb9fe,z78e5f3d8ec,
z09a63c2436)+z758719f481;float z86dd029962=zf8bc541aad/zff5c9644ab;
z86dd029962=min(z86dd029962,zbfb6939efb);zac5cffb9fe*=z86dd029962;z78e5f3d8ec*=
z86dd029962;z09a63c2436*=z86dd029962;z68e8e377e1[x]=zac5cffb9fe;z6439dcde4e[x]=
z78e5f3d8ec;ze8085abd9e[x]=z09a63c2436;}else{z68e8e377e1[x]=zac5cffb9fe;
ze8085abd9e[x]=z09a63c2436;}
#endif


ze4351005bc[0]=(float4)(zac5cffb9fe,z78e5f3d8ec,z09a63c2436,z00cdc99c5b.w);}
#endif
#if (z3dbd1ff682==3)
__kernel void z4d7244ce93(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13){int2 zba94ee46da=(
int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=z30eaaf69b7.s45+
zba94ee46da.yx;__global float4*z395b96baac=zf8d9fd6cb8+z83640e5796.x+z83640e5796
.y*z2824fcf57d;int2 zaaf414d14e=z30eaaf69b7.s01+zba94ee46da.xy;__global float4*
ze4351005bc=z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*z9562068e13;ze4351005bc[0]=
z395b96baac[0];}
#endif
#if (z3dbd1ff682==4)
__kernel void z4d7244ce93(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int4 zce3d260fdf,
float4 z123a07a2f7){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));
if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=z30eaaf69b7.s45+zba94ee46da;__global float4*z395b96baac=zf8d9fd6cb8+
z83640e5796.x+z83640e5796.y*z2824fcf57d;int2 zaaf414d14e=z30eaaf69b7.s01+
zba94ee46da;__global float4*ze4351005bc=z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*
z9562068e13;
const int z87fea0548d=zce3d260fdf.s0;const int z6cdb1f0aed=zce3d260fdf.s1;const
int zecbdd27030=zce3d260fdf.s2;
const float zf1575a1a99=z123a07a2f7.s0;const float zed39ca7843=z123a07a2f7.s1;
const float z42a80e5650=z123a07a2f7.s2;

























float4 z00cdc99c5b=z395b96baac[0];float z5f14ce5e19=z00cdc99c5b.s0;
float zaf2e2538a2=z00cdc99c5b.s1;
float zeea1a40014=z00cdc99c5b.s2;
float zda4c2e638c=z00cdc99c5b.s3;
if(zda4c2e638c<0.001f){





ze4351005bc[0]=(float4)(z5f14ce5e19,zaf2e2538a2,zeea1a40014,zda4c2e638c);return;
}
zaf2e2538a2=zaf2e2538a2*z5f14ce5e19;zeea1a40014=zeea1a40014*z5f14ce5e19;
float zb629aa6c5d=0.f;float za9066c96b3=0.f;float z0d786ca617=0.f;
for(int z88fa33d26d=-zecbdd27030;z88fa33d26d<=zecbdd27030;z88fa33d26d+=
z6cdb1f0aed){
float za1d72ab7f4,z296e23b2ca,z4de4bc135a,zf6750b1e9b;z00cdc99c5b=z395b96baac[
z88fa33d26d*z2824fcf57d];za1d72ab7f4=z00cdc99c5b.s0;
z296e23b2ca=z00cdc99c5b.s1;
z4de4bc135a=z00cdc99c5b.s2;
zf6750b1e9b=z00cdc99c5b.s3;
if(z88fa33d26d==0){
zb629aa6c5d+=z296e23b2ca;za9066c96b3+=z4de4bc135a;z0d786ca617+=1.f;continue;}

float zfdb1df39f0=zba5c6acf5c(za1d72ab7f4-z5f14ce5e19);float z7508e1a9d3=
zba5c6acf5c(z296e23b2ca*z5f14ce5e19-zaf2e2538a2);float z7b02732f1f=zba5c6acf5c(
z4de4bc135a*z5f14ce5e19-zeea1a40014);
float zec65e8d581=0.f;if(zfdb1df39f0<zf1575a1a99&&z7508e1a9d3<zed39ca7843&&
z7b02732f1f<z42a80e5650){
zec65e8d581=zf6750b1e9b;}
zb629aa6c5d+=z296e23b2ca*zec65e8d581;za9066c96b3+=z4de4bc135a*zec65e8d581;
z0d786ca617+=zec65e8d581;}

float z22dadf6692=1.f/(z0d786ca617);float zf313576c29=zb629aa6c5d*z22dadf6692;
float zd234db771d=za9066c96b3*z22dadf6692;



ze4351005bc[0]=(float4)(z5f14ce5e19,zf313576c29,zd234db771d,zda4c2e638c);

}
#endif
#if (z3dbd1ff682==5)
__kernel void z4d7244ce93(__global uchar*zf8d9fd6cb8,__global uchar*z718a062ddd,
int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,uchar z4633c865c6){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;__global uchar*z395b96baac=zf8d9fd6cb8+z83640e5796.x
+z83640e5796.y*z2824fcf57d;z395b96baac[0]=z4633c865c6;}
#endif
#if (z3dbd1ff682==6)
__kernel void z4d7244ce93(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,__global uchar*
z749ad23d69,int4 zddebabba4e){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.
s3)return;int2 z83640e5796=z30eaaf69b7.s45+zba94ee46da;__global float4*
z6c960de7e7=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z2824fcf57d;int2 zaaf414d14e
=z30eaaf69b7.s01+zba94ee46da;__global float4*z66aba1df8e=z718a062ddd+zaaf414d14e
.x+zaaf414d14e.y*z9562068e13;int2 za523f29d90=zddebabba4e.s01+zba94ee46da;
__global uchar*z37573045bb=z749ad23d69+za523f29d90.x+za523f29d90.y*zddebabba4e.
s2;float4 z395b96baac=z6c960de7e7[0];float4 ze4351005bc=z66aba1df8e[0];
float z1fc64dcf1f=ze4351005bc.s0;
float zecbdbb7cb9=ze4351005bc.s1;
float zd725a7f198=ze4351005bc.s2;

float zdcbbd8dac8=z395b96baac.s0;
float z8315075b1c=z395b96baac.s1;
float zf967161892=z395b96baac.s2;

float z88dce4da4d=convert_float(z37573045bb[0]);

float z96ba5d4482=z88dce4da4d*(1.0f/255.0f);float zd30ddce833=1.0f-z96ba5d4482;


ze4351005bc.s0=z1fc64dcf1f*zd30ddce833+zdcbbd8dac8*z96ba5d4482;ze4351005bc.s1=
zecbdbb7cb9*zd30ddce833+z8315075b1c*z96ba5d4482;ze4351005bc.s2=zd725a7f198*
zd30ddce833+zf967161892*z96ba5d4482;z66aba1df8e[0]=ze4351005bc;}
#endif
#if 0
__kernel void z7dd414228f(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,int z021babbfad,int z958df11031,int z336555f76e,int
 zbedd831684,z870da0e49c z428dac3911
#if zbc6516e8d5
,__local float4*z01612e015a
#endif
){int2 z945895b462=(int2)(get_global_id(0),get_global_id(1));int2 zba94ee46da=
z945895b462+z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;int ze623780ac4=
z336555f76e;
#ifdef z8b6bce8773
int z47728d2efe=get_local_size(1);int z1569e4557f=get_local_id(0);int
z38a89f6944=get_local_id(1);int zb3ec2e5425=z021babbfad/4;
#else
int z47728d2efe=get_local_size(0);int z1569e4557f=get_local_id(1);int
z38a89f6944=get_local_id(0);int zb3ec2e5425=1;
#endif
int z740d84c71c=(z47728d2efe+2*(ze623780ac4));int zc9d655d235=z83640e5796.x+
z83640e5796.y*(z021babbfad/4);
#if zbc6516e8d5
__local float4*zf485e5e12c=z01612e015a+z1569e4557f*z740d84c71c+(ze623780ac4);if(
z945895b462.x<z30eaaf69b7.s2&&z945895b462.y<z30eaaf69b7.s3){int ze12af1c5cf=
z38a89f6944;z8221728b77(zf485e5e12c,ze12af1c5cf,zf8d9fd6cb8,zc9d655d235);if(
z38a89f6944<=ze623780ac4)z8221728b77(zf485e5e12c,ze12af1c5cf-ze623780ac4,
zf8d9fd6cb8,zc9d655d235-zb3ec2e5425*ze623780ac4);if(z38a89f6944>=z47728d2efe-
ze623780ac4)z8221728b77(zf485e5e12c,ze12af1c5cf+ze623780ac4,zf8d9fd6cb8,
zc9d655d235+zb3ec2e5425*ze623780ac4);}barrier(CLK_LOCAL_MEM_FENCE);zb3ec2e5425=1
;
#else
__global float4*zf485e5e12c=zf8d9fd6cb8+zc9d655d235;z38a89f6944=0;
#endif
if(z945895b462.x>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return;
z870da0e49c z36db46d6df=z6cc1e8bdad(zf485e5e12c[(z38a89f6944)]);
z870da0e49c z6c1fbf0a77={0.0f,0.0f,0.0f,0.0f};
for(int z1d8bd19892=-z336555f76e;z1d8bd19892<=z336555f76e;z1d8bd19892+=
zbedd831684){
z870da0e49c z448a3dde4b=z6cc1e8bdad(zf485e5e12c[(z38a89f6944+z1d8bd19892*
zb3ec2e5425)]);




float zec65e8d581=0.0f;if(z1d8bd19892==0){zec65e8d581=1.0f;}else{float
zfdb1df39f0=zba5c6acf5c(z448a3dde4b.w-z36db46d6df.w);float z7508e1a9d3=
zba5c6acf5c(z448a3dde4b.x*z36db46d6df.w-z36db46d6df.x);float z7b02732f1f=
zba5c6acf5c(z448a3dde4b.z*z36db46d6df.w-z36db46d6df.z);if(z7508e1a9d3<
z428dac3911.x&&z7b02732f1f<z428dac3911.z&&zfdb1df39f0<z428dac3911.w){zec65e8d581
=1.0f;}}z6c1fbf0a77+=zec65e8d581*(z870da0e49c)(z448a3dde4b.xyz,1.0f);}
z6c1fbf0a77.w=max(1.0f,z6c1fbf0a77.w);z870da0e49c z2f06f3d292=z36db46d6df;float2
 z593fa3cb41=z6c1fbf0a77.xz/z6c1fbf0a77.ww;z2f06f3d292.xz=z593fa3cb41;


#ifdef z8b6bce8773
float zf8bc541aad=z2f06f3d292.w;
float z08ef030ac3=z2f06f3d292.x;
float z7e674d442a=z2f06f3d292.z;

float z78e5f3d8ec=z2f06f3d292.y;
float zac5cffb9fe=z08ef030ac3*zf8bc541aad+z78e5f3d8ec;float z09a63c2436=
z7e674d442a*zf8bc541aad+z78e5f3d8ec;zac5cffb9fe=MAX(zac5cffb9fe,1.f);z09a63c2436
=MAX(z09a63c2436,1.f);float4 z205d564e2f=(float4)(zac5cffb9fe,z78e5f3d8ec,
z09a63c2436,0.0f);int2 z9b046bc3a1=z83640e5796;
int zfcaa177308=z3576e84f20.s0;if(z3576e84f20.s1>=0){uchar za097e3cbf4=
zec145e35cf[z9b046bc3a1.x+z9b046bc3a1.y*zfcaa177308+z3576e84f20.s1];if(
za097e3cbf4>0){float4 zbeb390e590=z718a062ddd[zba94ee46da.x+zba94ee46da.y*(
z958df11031/4)];






float4 z8c24f6307d=z205d564e2f;
const bool zd18679a402=false;if(zd18679a402){


z8c24f6307d*=(float4)(2.0f,0.5f,2.0f,1.0f);}
uchar z88dce4da4d=za097e3cbf4;

float z96ba5d4482=convert_float(z88dce4da4d)*(1.0f/255.0f);float zd30ddce833=
1.0f-z96ba5d4482;


z205d564e2f=zbeb390e590*zd30ddce833+z8c24f6307d*z96ba5d4482;z718a062ddd[
zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z205d564e2f;}}else z718a062ddd[
zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z205d564e2f;
#else

z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z2f06f3d292;
#endif
}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
