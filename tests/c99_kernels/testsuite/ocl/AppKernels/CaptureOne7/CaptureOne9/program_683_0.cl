#define z93a6893130 8

#ifndef z93a6893130
#define z38c913a03a 0
#else
#define z38c913a03a z93a6893130
#endif
typedef uint za6c557b086;
#define MAX fmax
int z04a9540cbb(float z2dd09f3226,float za3158292ce,float z758719f481){float
z593fa3cb41=z2dd09f3226-za3158292ce;z593fa3cb41*=sign(z593fa3cb41);return
z593fa3cb41<z758719f481;}float4 ze796b120ff(float4 z205d564e2f){


float z99cf4fd6fe,z5083031dab,z88dce4da4d;float zff400e9e97=z205d564e2f.x;float
z305d891f1d=z205d564e2f.y;float za3158292ce=z205d564e2f.z;const float
z997ede1cab=0.0001f;float z5599ea8cc5=min(zff400e9e97,min(z305d891f1d,
za3158292ce));float zdb21e9209f=max(zff400e9e97,max(z305d891f1d,za3158292ce));
z88dce4da4d=zdb21e9209f;float z48c7a50fca=zdb21e9209f-z5599ea8cc5;if(!
z04a9540cbb(zdb21e9209f,0.0f,z997ede1cab))
{z5083031dab=z48c7a50fca/zdb21e9209f;
}else{
z5083031dab=0;z99cf4fd6fe=-1;return(float4)(z99cf4fd6fe,z5083031dab,z88dce4da4d,
z205d564e2f.w);}if(z04a9540cbb(zff400e9e97,zdb21e9209f,z997ede1cab))
z99cf4fd6fe=(z305d891f1d-za3158292ce)/z48c7a50fca;
else if(z04a9540cbb(z305d891f1d,zdb21e9209f,z997ede1cab))
z99cf4fd6fe=2.0f+(za3158292ce-zff400e9e97)/z48c7a50fca;
else z99cf4fd6fe=4.0f+(zff400e9e97-z305d891f1d)/z48c7a50fca;
z99cf4fd6fe*=60;
if(z99cf4fd6fe<0)z99cf4fd6fe+=360;return(float4)(z99cf4fd6fe,z5083031dab,
z88dce4da4d,z205d564e2f.w);}float4 za68156bd05(float4 z2d1fad4f44){


float zff400e9e97,z305d891f1d,za3158292ce;float z99cf4fd6fe=z2d1fad4f44.x;float
z5083031dab=z2d1fad4f44.y;float z88dce4da4d=z2d1fad4f44.z;const float
z997ede1cab=0.0001f;int z1d8bd19892;float z90e1a42944,z493deefb55,z11fc704ac4,
z52ab5b652a;if(z04a9540cbb(z5083031dab,0.0f,z997ede1cab))
{
zff400e9e97=z305d891f1d=za3158292ce=z88dce4da4d;return(float4)(zff400e9e97,
z305d891f1d,za3158292ce,z2d1fad4f44.w);}z99cf4fd6fe/=60.0f;
z1d8bd19892=floor(z99cf4fd6fe);z90e1a42944=z99cf4fd6fe-z1d8bd19892;
z493deefb55=z88dce4da4d*(1-z5083031dab);z11fc704ac4=z88dce4da4d*(1-z5083031dab*
z90e1a42944);z52ab5b652a=z88dce4da4d*(1-z5083031dab*(1-z90e1a42944));switch(
z1d8bd19892){case 0:zff400e9e97=z88dce4da4d;z305d891f1d=z52ab5b652a;za3158292ce=
z493deefb55;break;case 1:zff400e9e97=z11fc704ac4;z305d891f1d=z88dce4da4d;
za3158292ce=z493deefb55;break;case 2:zff400e9e97=z493deefb55;z305d891f1d=
z88dce4da4d;za3158292ce=z52ab5b652a;break;case 3:zff400e9e97=z493deefb55;
z305d891f1d=z11fc704ac4;za3158292ce=z88dce4da4d;break;case 4:zff400e9e97=
z52ab5b652a;z305d891f1d=z493deefb55;za3158292ce=z88dce4da4d;break;default:
zff400e9e97=z88dce4da4d;z305d891f1d=z493deefb55;za3158292ce=z11fc704ac4;break;}
return(float4)(zff400e9e97,z305d891f1d,za3158292ce,z2d1fad4f44.w);}int
z07f76dfe04(float X,int z7d07bb3247,int zbf32ff9ae0,__global float4*zcb1b02776b)
{while(zbf32ff9ae0-z7d07bb3247>1){int z1409a29adb=(z7d07bb3247+zbf32ff9ae0)/2;
float z6624dbc6f0=zcb1b02776b[z1409a29adb].x;
#if 0
if(fabs(X-z6624dbc6f0)<0.0001f)return z1409a29adb;
if(X<z6624dbc6f0)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;
#else

if(fabs(X-z6624dbc6f0)<0.0001f){
z7d07bb3247=z1409a29adb;zbf32ff9ae0=-1;}else{
if(X<z6624dbc6f0)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;}
#endif
}return z7d07bb3247;}float z9369a44638(float X,__global float4*zcb1b02776b,int
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
float4 z6425e694ab(float4 z493deefb55,const float z86dd029962,const float
z543f28509c,const float zb38b292eea,const float zf7ec53ff5e){float4 z4633c865c6=
MAX((float4)1.f,z493deefb55);
z4633c865c6=z4633c865c6*(float4)(z86dd029962/65535.f);
z4633c865c6=(float4)z543f28509c/z4633c865c6-(float4)zb38b292eea;



float4 z51eadf1cec=z4633c865c6*(float4)(65535.f/z86dd029962);return z51eadf1cec;
}float z6d7333005c(float16 z2dd09f3226,float16 za3158292ce){
#if   (z38c913a03a==16)
return dot(z2dd09f3226.s0123,za3158292ce.s0123)+dot(z2dd09f3226.s4567,
za3158292ce.s4567)+dot(z2dd09f3226.s89ab,za3158292ce.s89ab)+dot(z2dd09f3226.
scdef,za3158292ce.scdef);
#elif (z38c913a03a>10)
return dot(z2dd09f3226.s0123,za3158292ce.s0123)+dot(z2dd09f3226.s4567,
za3158292ce.s4567)+dot(z2dd09f3226.s89ab,za3158292ce.s89ab);
#elif (z38c913a03a>8)
return dot(z2dd09f3226.s0123,za3158292ce.s0123)+dot(z2dd09f3226.s4567,
za3158292ce.s4567)+dot(z2dd09f3226.s89,za3158292ce.s89);
#elif (z38c913a03a>6)
return dot(z2dd09f3226.s0123,za3158292ce.s0123)+dot(z2dd09f3226.s4567,
za3158292ce.s4567);
#elif (z38c913a03a>4)
return dot(z2dd09f3226.s0123,za3158292ce.s0123)+dot(z2dd09f3226.s45,za3158292ce.
s45);
#elif (z38c913a03a>2)
return dot(z2dd09f3226.s0123,za3158292ce.s0123);
#elif (z38c913a03a>0)
return dot(z2dd09f3226.s01,za3158292ce.s01);
#else
return 0.0f;
#endif
}__kernel void zefe087aadc(__global float4*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int4 z30eaaf69b7,int z021babbfad,int z745057f086,__global ushort*
zb54a28f8da,__global ushort*z0311be68ea,__global ushort*z27e65ce7e0,float16
z4c3d81cb02,float4 zfb81b1b9ea,__global float4*z671bb71270,int zd2a4f31fb5,float
 z5252c1704c
#if (z38c913a03a>0)
,__global uchar*zec145e35cf,int16 z7f76fb323c,int4 z3576e84f20,float16
zd8b21bfb9c,float16 z41f391612d,float16 zb273728874,float16 za999b48c18
#endif
){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.xy;
int2 z83640e5796=zba94ee46da;float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+
z83640e5796.y*(z021babbfad/4)];float zdd4e53cbfe=zfb81b1b9ea.s0;
if(zfb81b1b9ea.s1>0.0f){const float z86dd029962=zfb81b1b9ea.s1;

const float z543f28509c=zfb81b1b9ea.s2;
const float zb38b292eea=zfb81b1b9ea.s3;
const float zf7ec53ff5e=1.f;
z493deefb55=z6425e694ab(z493deefb55,z86dd029962,z543f28509c,zb38b292eea,
zf7ec53ff5e);}float4 zaaa7fd862e=(float4)(0.0f,0.0f,0.0f,0.0f);zaaa7fd862e.x=dot
(z4c3d81cb02.s0123,z493deefb55);zaaa7fd862e.y=dot(z4c3d81cb02.s4567,z493deefb55)
;zaaa7fd862e.z=dot(z4c3d81cb02.s89ab,z493deefb55);
#if (z38c913a03a>0)
int2 z9b046bc3a1=z83640e5796;
int zfcaa177308=z3576e84f20.s2;int2 ze2c89cc3be=(int2)(z3576e84f20.s01);int
z98cd6733c3=z9b046bc3a1.x+z9b046bc3a1.y*zfcaa177308;int*z6016b79538=(int*)&
z7f76fb323c;float16 z305c8a97dc;float*zbd7b15dc4f=(float*)&z305c8a97dc;for(int
z1d8bd19892=0;z1d8bd19892<z38c913a03a;z1d8bd19892++)zbd7b15dc4f[z1d8bd19892]=
convert_float(z6016b79538[z1d8bd19892]>=0?zec145e35cf[z98cd6733c3+z6016b79538[
z1d8bd19892]]:0);float zec2cea3690=z6d7333005c(zd8b21bfb9c,z305c8a97dc);
zaaa7fd862e*=exp(zec2cea3690);
#endif
if(zd2a4f31fb5>0){

float4 z2d1fad4f44=ze796b120ff(zaaa7fd862e/65535.0f);
z2d1fad4f44.y=z9369a44638(z2d1fad4f44.y,z671bb71270,zd2a4f31fb5);

zaaa7fd862e=za68156bd05(z2d1fad4f44)*65535.0f;z5252c1704c=0.0f;}zaaa7fd862e*=
zdd4e53cbfe;
#if (z38c913a03a>0)

float z1c19617292=z6d7333005c(z41f391612d,z305c8a97dc);bool z37e372661a=(fabs(
z1c19617292)>0.0f);
#else
const float z1c19617292=0.0f;const bool z37e372661a=false;
#endif
if(z37e372661a){z5252c1704c=z1c19617292;zaaa7fd862e=zaaa7fd862e/65535.0f;if(
z5252c1704c>0.0f){




float4 z2d1fad4f44=ze796b120ff(zaaa7fd862e);float z3987adcbb1=z2d1fad4f44.y;

float zccb7f8e67f=0.5f;float z5083031dab=1.0f+z5252c1704c*0.0064f;float
z448a3dde4b=zccb7f8e67f/z5083031dab;float ze7c57fc5f9=zccb7f8e67f;
if(z3987adcbb1<z448a3dde4b){z3987adcbb1=z3987adcbb1*z5083031dab;}else{float w=
z5083031dab*(1.0f-z448a3dde4b);float z20b29b6aff=w/(1.0f-ze7c57fc5f9);float z=
1.0f/(1.0f-z448a3dde4b);float z52ab5b652a=z20b29b6aff-1.0f;float z56807b5599=(
z3987adcbb1-z448a3dde4b)*z;z3987adcbb1=ze7c57fc5f9+(w*z56807b5599)/(z56807b5599*
z52ab5b652a+1.0f);}z2d1fad4f44.y=z3987adcbb1;

zaaa7fd862e=za68156bd05(z2d1fad4f44);}else{
if(z5252c1704c<-100.0f)z5252c1704c=-100.0f;


float Y=dot(zaaa7fd862e,(float4)(0.288047f,0.711861f,0.000092f,0.0f));
float z38c36eec91=-z5252c1704c*0.01f;float zea34483265=1.0f-z38c36eec91;


zaaa7fd862e=zea34483265*zaaa7fd862e+(float4)(Y*z38c36eec91);}zaaa7fd862e=
zaaa7fd862e*65535.0f;}
ushort4 z4633c865c6=convert_ushort4_sat_rte(zaaa7fd862e);
#if 1
z4633c865c6.x=zb54a28f8da[z4633c865c6.x];z4633c865c6.y=z0311be68ea[z4633c865c6.y
];z4633c865c6.z=z27e65ce7e0[z4633c865c6.z];
#endif
#if (z38c913a03a>0)
const float z0e9f85a3b3=z6d7333005c(za999b48c18,z305c8a97dc);const float
zdf15203512=z6d7333005c(zb273728874,z305c8a97dc);const bool z7b437af491=(fabs(
z0e9f85a3b3)>=0.001f);const bool zb696c584b7=(fabs(zdf15203512)>=0.001f);
#else
const float z0e9f85a3b3=0.0f;const float zdf15203512=0.0f;const bool z7b437af491
=false;const bool zb696c584b7=false;
#endif
float4 ze8a7296882=convert_float4(z4633c865c6);if(zb696c584b7){
float zccb7f8e67f=16384.0f;
float zf5ef026274=zdf15203512;


float z5083031dab;if(zf5ef026274>0)z5083031dab=1.0f+zf5ef026274*0.030f;else
z5083031dab=1.0f/(1.0f-zf5ef026274*0.015f);
float z448a3dde4b,ze7c57fc5f9;if(z5083031dab>1.0f){z448a3dde4b=zccb7f8e67f/
z5083031dab;ze7c57fc5f9=zccb7f8e67f;}else{z448a3dde4b=zccb7f8e67f;ze7c57fc5f9=
zccb7f8e67f*z5083031dab;}

float zaec20d4434=ze8a7296882.x;float z839bc2282c=ze8a7296882.y;float
z02168f5f79=ze8a7296882.z;
float z960fb238c4,zb0aa49bc8a,z9eb0d07847;float w=z5083031dab*(65535.0f-
z448a3dde4b);float z20b29b6aff=w/(65535.0f-ze7c57fc5f9);float z=1.0f/(65535.0f-
z448a3dde4b);float z52ab5b652a=z20b29b6aff-1.0f;if(zaec20d4434<z448a3dde4b){
z960fb238c4=zaec20d4434*z5083031dab;}else{float z56807b5599=(zaec20d4434-
z448a3dde4b)*z;z960fb238c4=ze7c57fc5f9+(w*z56807b5599)/(z56807b5599*z52ab5b652a+
1.0f);}if(z839bc2282c<z448a3dde4b){zb0aa49bc8a=z839bc2282c*z5083031dab;}else{
float z56807b5599=(z839bc2282c-z448a3dde4b)*z;zb0aa49bc8a=ze7c57fc5f9+(w*
z56807b5599)/(z56807b5599*z52ab5b652a+1.0f);}if(z02168f5f79<z448a3dde4b){
z9eb0d07847=z02168f5f79*z5083031dab;}else{float z56807b5599=(z02168f5f79-
z448a3dde4b)*z;z9eb0d07847=ze7c57fc5f9+(w*z56807b5599)/(z56807b5599*z52ab5b652a+
1.0f);}ze8a7296882=(float4)(z960fb238c4,zb0aa49bc8a,z9eb0d07847,0.0f);
ze8a7296882=clamp(ze8a7296882,(float4)0.0f,(float4)65535.0f);
}if(z7b437af491){float zafd99f89a4=65536.0f;float z493deefb55=32768.0f;


float zc226175807=z0e9f85a3b3;


float z5083031dab;if(zc226175807>0){float z52ab5b652a=zc226175807*0.0150f;
z5083031dab=1.0f+z52ab5b652a+z52ab5b652a*z52ab5b652a*.5f;}else{z5083031dab=1.0f/
(1.0f-zc226175807*0.0125f);}

float ze4b052164b=ze8a7296882.x;float z2e91460297=ze8a7296882.y;float
z7e674d442a=ze8a7296882.z;
float z960fb238c4,zb0aa49bc8a,z9eb0d07847;float z52ab5b652a=(1.0f-z5083031dab)*(
1.0f/z493deefb55);float z56807b5599=z5083031dab-1.0f;float z88dce4da4d=
zafd99f89a4-z493deefb55;float w=z88dce4da4d*z5083031dab;if(ze4b052164b<=
z493deefb55){z960fb238c4=ze4b052164b/(ze4b052164b*z52ab5b652a+z5083031dab);}else
{float x=ze4b052164b-z493deefb55;z960fb238c4=z493deefb55+w*x/(z56807b5599*x+
z88dce4da4d);}if(z2e91460297<=z493deefb55){zb0aa49bc8a=z2e91460297/(z2e91460297*
z52ab5b652a+z5083031dab);}else{float x=z2e91460297-z493deefb55;zb0aa49bc8a=
z493deefb55+w*x/(z56807b5599*x+z88dce4da4d);}if(z7e674d442a<=z493deefb55){
z9eb0d07847=z7e674d442a/(z7e674d442a*z52ab5b652a+z5083031dab);}else{float x=
z7e674d442a-z493deefb55;z9eb0d07847=z493deefb55+w*x/(z56807b5599*x+z88dce4da4d);
}
ze8a7296882=(float4)(z960fb238c4,zb0aa49bc8a,z9eb0d07847,0.0f);ze8a7296882=clamp
(ze8a7296882,(float4)0.0f,(float4)65535.0f);

}z4633c865c6=convert_ushort4(ze8a7296882);int z77f8ae3448=zba94ee46da.x+
zba94ee46da.y*(z745057f086/4);z718a062ddd[z77f8ae3448]=z4633c865c6;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
