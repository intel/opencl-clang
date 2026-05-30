#define ze78198c35f 1
 #define z370db0e88a 1
 #define  z3dbd1ff682 4

#ifndef z3dbd1ff682
#define z3dbd1ff682 0
#endif
#define z84735a7cc1 3.14159265358979323846
typedef enum{
z56dc5b3b1a=1,
z561e37e37a=2,
zb4066a3c9c=3,

z4489fbac91=3,
z4b0f83193b=2,

z65651d298f=0,
z58c8b63e42=256
}zb68017ad55;
#if 0
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
typedef double z558ec19d7e;
#define z8ac300e171 DBL_EPSILON
#else
typedef float z558ec19d7e;
#define z8ac300e171 FLT_EPSILON
#endif
typedef uint za6c557b086;typedef struct{z558ec19d7e x;z558ec19d7e y;z558ec19d7e
zbdb4f199ce;}ze9dc86233a;
typedef struct{

int zf352921518,zbac83770ff;int zd79caea3d7,zed30332b1a;

z558ec19d7e zc0d94c7cf2;



z558ec19d7e z8fa4e208cf,z562deb28a6;

z558ec19d7e zdfd20e76d0;z558ec19d7e ze47baa5dfe;

z558ec19d7e z41de5a2e21;
z558ec19d7e zf6c4585975,z308ac999d5;
z558ec19d7e zedad526c61;

bool zf3080330b7;
bool zadc09b44d2;




z558ec19d7e zf544d6517b[3],z018277c676[3];
z558ec19d7e z38190a079a;z558ec19d7e z03a1bfc64a;


z558ec19d7e z752a8e518e;

uint zb3ba66c6db;
z558ec19d7e z9da154f764,zf1519608a0;z558ec19d7e zdf5124debe,zd527de668d;}
zc950100d2f;
#define z8af28b51db		(0<<8)
#define zf09c5890b1	(1<<8)
#define z485b6cbcb8	(2<<8)
#define zbbe33f9ac3	(3<<8)
#define zeab3ed8942		(3<<8)
int z07f76dfe04(float X,int z7d07bb3247,int zbf32ff9ae0,__constant float4*
zcb1b02776b){while(zbf32ff9ae0-z7d07bb3247>1){int z1409a29adb=(z7d07bb3247+
zbf32ff9ae0)/2;float z6624dbc6f0=zcb1b02776b[z1409a29adb].x;
if(fabs(X-z6624dbc6f0)<0.0001f)return z1409a29adb;
if(X<z6624dbc6f0)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;}return
z7d07bb3247;}int ze94c3fdd77(z558ec19d7e ze7168fc0b9[3],z558ec19d7e zff400e9e97[
2]){
z558ec19d7e zf793de71f2=ze7168fc0b9[1]*ze7168fc0b9[1]-4*ze7168fc0b9[0]*
ze7168fc0b9[2];if(zf793de71f2<0)return 0;
z558ec19d7e z11fc704ac4=sqrt(zf793de71f2);if(ze7168fc0b9[1]<0)z11fc704ac4=-0.5*(
ze7168fc0b9[1]-z11fc704ac4);else z11fc704ac4=-0.5*(ze7168fc0b9[1]+z11fc704ac4);
zff400e9e97[0]=z11fc704ac4/ze7168fc0b9[2];zff400e9e97[1]=ze7168fc0b9[0]/
z11fc704ac4;return 2;}int zda883a2d9b(z558ec19d7e ze7168fc0b9[4],z558ec19d7e
zff400e9e97[3]){z558ec19d7e z2dd09f3226=ze7168fc0b9[2]/ze7168fc0b9[3];
z558ec19d7e za3158292ce=ze7168fc0b9[1]/ze7168fc0b9[3];z558ec19d7e ze28128c2dd=
ze7168fc0b9[0]/ze7168fc0b9[3];z558ec19d7e z4a8d526d4d=z2dd09f3226*z2dd09f3226;
z558ec19d7e z9386a0103f=(z4a8d526d4d-3*za3158292ce)/9.0;z558ec19d7e ze4b052164b=
(2.0*z2dd09f3226*z4a8d526d4d-9.0*z2dd09f3226*za3158292ce+27.0*ze28128c2dd)/54.0;
z558ec19d7e z86e6c4db76=z9386a0103f*z9386a0103f*z9386a0103f;z558ec19d7e
z154167adc5=ze4b052164b*ze4b052164b;z558ec19d7e zef36d9b1e8=z2dd09f3226*(1.0/3.0
);
if(z154167adc5<z86e6c4db76){z558ec19d7e za95a1cf587=acos(ze4b052164b/sqrt(
z86e6c4db76));z558ec19d7e z84a0cd7974=za95a1cf587*(1.0/3.0);z558ec19d7e
z90e1a42944=-2.0*sqrt(z9386a0103f);zff400e9e97[0]=z90e1a42944*cos(z84a0cd7974)-
zef36d9b1e8;z558ec19d7e zb8acde8c14=z84735a7cc1*(2.0/3.0);zff400e9e97[1]=
z90e1a42944*cos(z84a0cd7974+zb8acde8c14)-zef36d9b1e8;zff400e9e97[2]=z90e1a42944*
cos(z84a0cd7974-zb8acde8c14)-zef36d9b1e8;return 3;}
z558ec19d7e z08ef030ac3=cbrt(fabs(ze4b052164b)+sqrt(z154167adc5-z86e6c4db76));
z558ec19d7e z7e674d442a=0;if(ze4b052164b>0.0)z08ef030ac3=-z08ef030ac3;if(
z08ef030ac3!=0.0)z7e674d442a=z9386a0103f/z08ef030ac3;zff400e9e97[0]=(z08ef030ac3
+z7e674d442a)-zef36d9b1e8;return 1;}int z8eaf63a1e7(int z88fa33d26d,z558ec19d7e*
ze7168fc0b9,z558ec19d7e*zff400e9e97){switch(z88fa33d26d){case 1:zff400e9e97[0]=-
ze7168fc0b9[0]/ze7168fc0b9[1];return 1;case 2:return ze94c3fdd77(ze7168fc0b9,
zff400e9e97);case 3:return zda883a2d9b(ze7168fc0b9,zff400e9e97);default:return-1
;}}void z5417645477(ze9dc86233a*z493deefb55,z558ec19d7e*z5462909dc1,z558ec19d7e*
z2dd09f3226){
z558ec19d7e zc180b9cdc9=z493deefb55[0].x,za3584c0652=z493deefb55[0].y,
z16e127a2c9=z493deefb55[0].zbdb4f199ce;z558ec19d7e z35bf29e99b=z493deefb55[1].x,
z1a6f4c4c08=z493deefb55[1].y,z635f0a0757=z493deefb55[1].zbdb4f199ce;
*z5462909dc1=(zc180b9cdc9+z35bf29e99b)*.5;z558ec19d7e z56807b5599=(z35bf29e99b-
zc180b9cdc9)*.5;

if(z56807b5599==0){z2dd09f3226[0]=(za3584c0652+z1a6f4c4c08)*.5;
z2dd09f3226[1]=(z16e127a2c9+z635f0a0757)*.5;
z2dd09f3226[2]=z2dd09f3226[3]=0;return;}
z558ec19d7e z35ace4f815=1.0/z56807b5599;z558ec19d7e z721963480c=z1a6f4c4c08+
za3584c0652,z910b0f86fe=z1a6f4c4c08-za3584c0652;z558ec19d7e z563443c69b=
z635f0a0757+z16e127a2c9,zb61033396f=z635f0a0757-z16e127a2c9;z2dd09f3226[0]=.50*
z721963480c-.25*zb61033396f*z56807b5599;z2dd09f3226[1]=.75*z910b0f86fe*
z35ace4f815-.25*z563443c69b;z2dd09f3226[2]=(.25*z35ace4f815)*zb61033396f;
z2dd09f3226[3]=(.25*z35ace4f815)*z35ace4f815*(z563443c69b-z910b0f86fe*
z35ace4f815);}int z40b897fe28(z558ec19d7e y,int z7d07bb3247,int zbf32ff9ae0,
__constant float4*zcb1b02776b,int zd5275ae723,int z23d17e91e7){za6c557b086
z63da1ee795=z23d17e91e7&zeab3ed8942;if(z63da1ee795==z485b6cbcb8){
while(zbf32ff9ae0-z7d07bb3247>1){int z1409a29adb=(z7d07bb3247+zbf32ff9ae0)/2;
z558ec19d7e z23774b5397=zcb1b02776b[z1409a29adb].y;
if(y==z23774b5397)return z1409a29adb;
if(y<z23774b5397)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;}return
z7d07bb3247;}else if(z63da1ee795==zbbe33f9ac3){
while(zbf32ff9ae0-z7d07bb3247>1){int z1409a29adb=(z7d07bb3247+zbf32ff9ae0)/2;
z558ec19d7e z23774b5397=zcb1b02776b[z1409a29adb].y;
if(y==z23774b5397)return z1409a29adb;
if(y>z23774b5397)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;}return
z7d07bb3247;}
return-1;}z558ec19d7e ze90fbb0fd1(z558ec19d7e y,__constant float4*zcb1b02776b,
int2 zb93c16b5cc){int zd5275ae723=zb93c16b5cc.x;int z23d17e91e7=zb93c16b5cc.y;

if(zd5275ae723<2)return y;
int z7d07bb3247=z40b897fe28(y,0,zd5275ae723-1,zcb1b02776b,zd5275ae723,
z23d17e91e7);int zbf32ff9ae0=z7d07bb3247+1;if(z7d07bb3247<0)return 0.0;
z558ec19d7e zc180b9cdc9=zcb1b02776b[z7d07bb3247].x,za3584c0652=zcb1b02776b[
z7d07bb3247].y,z16e127a2c9=zcb1b02776b[z7d07bb3247].z;
z558ec19d7e z35bf29e99b=zcb1b02776b[zbf32ff9ae0].x,z1a6f4c4c08=zcb1b02776b[
zbf32ff9ae0].y,z635f0a0757=zcb1b02776b[zbf32ff9ae0].z;


za3584c0652=za3584c0652-y;z1a6f4c4c08=z1a6f4c4c08-y;if(z1a6f4c4c08<za3584c0652){
za3584c0652=-za3584c0652;z16e127a2c9=-z16e127a2c9;z1a6f4c4c08=-z1a6f4c4c08;
z635f0a0757=-z635f0a0757;}
z558ec19d7e z5462909dc1,z2dd09f3226[4];ze9dc86233a z5c3222b171[2]={{zc180b9cdc9,
za3584c0652,z16e127a2c9},{z35bf29e99b,z1a6f4c4c08,z635f0a0757}};z5417645477(
z5c3222b171,&z5462909dc1,z2dd09f3226);zc180b9cdc9=zc180b9cdc9-z5462909dc1;
z35bf29e99b=z35bf29e99b-z5462909dc1;
int z48f8bbf83f=3;z558ec19d7e z8f05bab56b=fabs(zc180b9cdc9)+fabs(z35bf29e99b)+
fabs(z16e127a2c9+z635f0a0757);z558ec19d7e za1fa8bdb4f=(fabs(za3584c0652)+fabs(
z1a6f4c4c08))*1e-8;z558ec19d7e z65a0201994=z8f05bab56b*z8f05bab56b;z558ec19d7e
z7868bde062=z8f05bab56b*z65a0201994;if(fabs(z2dd09f3226[3])*z7868bde062<=
za1fa8bdb4f){z48f8bbf83f=2;if(fabs(z2dd09f3226[2])*z65a0201994<=za1fa8bdb4f){
z48f8bbf83f=1;if(fabs(z2dd09f3226[1])*z8f05bab56b<=za1fa8bdb4f){

return z5462909dc1;}}}
z558ec19d7e zff400e9e97[3];int zef35eaad8b=z8eaf63a1e7(z48f8bbf83f,z2dd09f3226,
zff400e9e97);if(zef35eaad8b==1)return z5462909dc1+zff400e9e97[0];
if(zef35eaad8b==0)return z5462909dc1;

z558ec19d7e ze27e281071=zff400e9e97[0];z558ec19d7e z6d4cfb07f8=zff400e9e97[0];
for(int z1d8bd19892=0;z1d8bd19892<zef35eaad8b;z1d8bd19892++){
if(zff400e9e97[z1d8bd19892]>=zc180b9cdc9&&zff400e9e97[z1d8bd19892]<=z35bf29e99b)
return z5462909dc1+zff400e9e97[z1d8bd19892];
if(zff400e9e97[z1d8bd19892]<ze27e281071)ze27e281071=zff400e9e97[z1d8bd19892];if(
zff400e9e97[z1d8bd19892]>z6d4cfb07f8)z6d4cfb07f8=zff400e9e97[z1d8bd19892];}
z558ec19d7e z6ccb577c20=ze27e281071;z558ec19d7e z4612bbd565=z6d4cfb07f8;for(int
z1d8bd19892=0;z1d8bd19892<zef35eaad8b;z1d8bd19892++){if(zff400e9e97[z1d8bd19892]
<zc180b9cdc9&&zff400e9e97[z1d8bd19892]>z6ccb577c20)z6ccb577c20=zff400e9e97[
z1d8bd19892];if(zff400e9e97[z1d8bd19892]>z35bf29e99b&&zff400e9e97[z1d8bd19892]<
z4612bbd565)z4612bbd565=zff400e9e97[z1d8bd19892];}
za6c557b086 z63da1ee795=z23d17e91e7&zeab3ed8942;if(z63da1ee795==z485b6cbcb8)
return z5462909dc1+z4612bbd565;if(z63da1ee795==zbbe33f9ac3)return z5462909dc1+
z6ccb577c20;

return z5462909dc1+zff400e9e97[0];}float z9369a44638(float X,__constant float4*
zcb1b02776b,int2 zb93c16b5cc){int zd5275ae723=zb93c16b5cc.x;

if(zd5275ae723<2)return X;
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
#define za6925373f4				2.00f
#define z355aeb6d3b				0.50f
#define ze124eee453 100.0f
#define z30701fddb8      1
#define zfe907af8b2  2
#define z110b189e8c 4

bool ze1a90497f6(z558ec19d7e*x,z558ec19d7e*y,zc950100d2f*z40a38d3b9e,__constant
float4*zd2ade392dc,int2 z395c239ef8);bool z5638d497cd(z558ec19d7e*x,z558ec19d7e*
y,zc950100d2f*z40a38d3b9e,__constant float4*zd2ade392dc,int2 z395c239ef8);bool
zd6bc1d1ede(z558ec19d7e*x,z558ec19d7e*y,zc950100d2f*z40a38d3b9e,__constant
float4*zd2ade392dc,int2 z395c239ef8);bool z273c93e8cd(z558ec19d7e*x,z558ec19d7e*
y,zc950100d2f*z40a38d3b9e,__constant float4*zd2ade392dc,int2 z395c239ef8);bool
z9183321bad(z558ec19d7e*x,z558ec19d7e*y,zc950100d2f*z40a38d3b9e,__constant
float4*zd2ade392dc,int2 z395c239ef8);bool zb6c309e7f7(z558ec19d7e*x,z558ec19d7e*
y,zc950100d2f*z40a38d3b9e,__constant float4*zd2ade392dc,int2 z395c239ef8);bool
z5e5d2d8371(z558ec19d7e*x,z558ec19d7e*y,zc950100d2f*z40a38d3b9e,__constant
float4*zd2ade392dc,int2 z395c239ef8);bool z8c89a55fb4(z558ec19d7e*x,z558ec19d7e*
y,zc950100d2f*z40a38d3b9e,__constant float4*zd2ade392dc,int2 z395c239ef8);
void zf0b437e9ad(){}int z979ad56c58(const z558ec19d7e*z08ef030ac3,z558ec19d7e*x,
const z558ec19d7e*za3158292ce){z558ec19d7e z02702dd463=z08ef030ac3[0]*
z08ef030ac3[3];z558ec19d7e z5cc5ab02f7=z08ef030ac3[2]*z08ef030ac3[1];z558ec19d7e
 zf793de71f2=z02702dd463-z5cc5ab02f7;x[0]=(za3158292ce[0]*z08ef030ac3[3]-
za3158292ce[1]*z08ef030ac3[2])/zf793de71f2;x[1]=(za3158292ce[1]*z08ef030ac3[0]-
za3158292ce[0]*z08ef030ac3[1])/zf793de71f2;z558ec19d7e z98253c1678=z8ac300e171*
50.0;return(fabs(zf793de71f2)<=(fabs(z02702dd463)+fabs(z5cc5ab02f7))*z98253c1678
)?-1:0;}bool ze1a90497f6(z558ec19d7e*z4d5680d21d,z558ec19d7e*z278ea663fa,
zc950100d2f*z40a38d3b9e,__constant float4*zd2ade392dc,int2 z395c239ef8){bool
z73e4351cc7=false;z73e4351cc7=z8c89a55fb4(z4d5680d21d,z278ea663fa,z40a38d3b9e,
zd2ade392dc,z395c239ef8)||z73e4351cc7;z73e4351cc7=zb6c309e7f7(z4d5680d21d,
z278ea663fa,z40a38d3b9e,zd2ade392dc,z395c239ef8)||z73e4351cc7;return z73e4351cc7
;}bool z5638d497cd(z558ec19d7e*z4d5680d21d,z558ec19d7e*z278ea663fa,zc950100d2f*
z40a38d3b9e,__constant float4*zd2ade392dc,int2 z395c239ef8){bool z73e4351cc7=
false;z73e4351cc7=z9183321bad(z4d5680d21d,z278ea663fa,z40a38d3b9e,zd2ade392dc,
z395c239ef8)||z73e4351cc7;z73e4351cc7=z5e5d2d8371(z4d5680d21d,z278ea663fa,
z40a38d3b9e,zd2ade392dc,z395c239ef8)||z73e4351cc7;return z73e4351cc7;}
bool z9183321bad(z558ec19d7e*z4d5680d21d,z558ec19d7e*z278ea663fa,zc950100d2f*
z40a38d3b9e,__constant float4*zd2ade392dc,int2 z395c239ef8){


z558ec19d7e x=*z4d5680d21d;z558ec19d7e y=*z278ea663fa;
bool z73e4351cc7=false;if(x<(*z40a38d3b9e).zf352921518||x>=(*z40a38d3b9e).
zbac83770ff||y<(*z40a38d3b9e).zd79caea3d7||y>(*z40a38d3b9e).zed30332b1a)
z73e4351cc7=true;
x=x-(*z40a38d3b9e).z8fa4e208cf;y=y-(*z40a38d3b9e).z562deb28a6;
z558ec19d7e z404799e2cf=sqrt(x*x+y*y);if(z404799e2cf>1.0){z558ec19d7e
z40bb6aa633=ze90fbb0fd1(z404799e2cf,zd2ade392dc,z395c239ef8);z558ec19d7e
z305d891f1d=z40bb6aa633/z404799e2cf;x=x*z305d891f1d;y=y*z305d891f1d;}
if((*z40a38d3b9e).zb3ba66c6db&z4b0f83193b){if(x<(*z40a38d3b9e).z9da154f764||x>(*
z40a38d3b9e).zf1519608a0||y<(*z40a38d3b9e).zdf5124debe||y>(*z40a38d3b9e).
zd527de668d)z73e4351cc7=true;}
*z4d5680d21d=x;*z278ea663fa=y;return z73e4351cc7;}bool zb6c309e7f7(z558ec19d7e*
z4d5680d21d,z558ec19d7e*z278ea663fa,zc950100d2f*z40a38d3b9e,__constant float4*
zd2ade392dc,int2 z395c239ef8){


z558ec19d7e x=*z4d5680d21d;z558ec19d7e y=*z278ea663fa;
bool z73e4351cc7=false;if((*z40a38d3b9e).zb3ba66c6db&z4b0f83193b){if(x<(*
z40a38d3b9e).z9da154f764||x>(*z40a38d3b9e).zf1519608a0||y<(*z40a38d3b9e).
zdf5124debe||y>(*z40a38d3b9e).zd527de668d)z73e4351cc7=true;}
z558ec19d7e z40bb6aa633=sqrt(x*x+y*y);if(z40bb6aa633>1.0){
z558ec19d7e z404799e2cf=z9369a44638(z40bb6aa633,zd2ade392dc,z395c239ef8);
z558ec19d7e z305d891f1d=z404799e2cf/z40bb6aa633;x=x*z305d891f1d;y=y*z305d891f1d;
}
x=x+(*z40a38d3b9e).z8fa4e208cf;y=y+(*z40a38d3b9e).z562deb28a6;
if(x<(*z40a38d3b9e).zf352921518||x>=(*z40a38d3b9e).zbac83770ff||y<(*z40a38d3b9e)
.zd79caea3d7||y>(*z40a38d3b9e).zed30332b1a)z73e4351cc7=true;
*z4d5680d21d=x;*z278ea663fa=y;return z73e4351cc7;}bool z8c89a55fb4(z558ec19d7e*
z4d5680d21d,z558ec19d7e*z278ea663fa,zc950100d2f*z40a38d3b9e,__constant float4*
zd2ade392dc,int2 z395c239ef8){



z558ec19d7e x=(*z4d5680d21d)+(*z40a38d3b9e).z38190a079a;z558ec19d7e y=(*
z278ea663fa)+(*z40a38d3b9e).z03a1bfc64a;
if((*z40a38d3b9e).zf3080330b7)x=-x;if((*z40a38d3b9e).zadc09b44d2)y=-y;
if((*z40a38d3b9e).zedad526c61>1){z558ec19d7e z52ab5b652a=+x*(*z40a38d3b9e).
zf6c4585975+y*(*z40a38d3b9e).z308ac999d5;z558ec19d7e z56807b5599=-x*(*
z40a38d3b9e).z308ac999d5+y*(*z40a38d3b9e).zf6c4585975;z56807b5599=z56807b5599*(*
z40a38d3b9e).zedad526c61;x=(*z40a38d3b9e).zf6c4585975*z52ab5b652a-(*z40a38d3b9e)
.z308ac999d5*z56807b5599;y=(*z40a38d3b9e).z308ac999d5*z52ab5b652a+(*z40a38d3b9e)
.zf6c4585975*z56807b5599;}
z558ec19d7e z1ca8e02bf0=(*z40a38d3b9e).zf544d6517b[0]*x+(*z40a38d3b9e).
z018277c676[0]*y;z558ec19d7e zf45616962c=(*z40a38d3b9e).zf544d6517b[1]*x+(*
z40a38d3b9e).z018277c676[1]*y;z558ec19d7e zb9cf30781b=(*z40a38d3b9e).zf544d6517b
[2]*x+(*z40a38d3b9e).z018277c676[2]*y;

z558ec19d7e z5083031dab=1.0/(1.0+zb9cf30781b);z1ca8e02bf0=z1ca8e02bf0*
z5083031dab;zf45616962c=zf45616962c*z5083031dab;
*z4d5680d21d=z1ca8e02bf0;*z278ea663fa=zf45616962c;return false;}
bool z5e5d2d8371(z558ec19d7e*z4d5680d21d,z558ec19d7e*z278ea663fa,zc950100d2f*
z40a38d3b9e,__constant float4*zd2ade392dc,int2 z395c239ef8){



z558ec19d7e x=*z4d5680d21d;z558ec19d7e y=*z278ea663fa;
z558ec19d7e z90e1a42944=1.0;z558ec19d7e z08ef030ac3[4]={(*z40a38d3b9e).
zf544d6517b[0]-(x/z90e1a42944)*(*z40a38d3b9e).zf544d6517b[2],(*z40a38d3b9e).
zf544d6517b[1]-(y/z90e1a42944)*(*z40a38d3b9e).zf544d6517b[2],(*z40a38d3b9e).
z018277c676[0]-(x/z90e1a42944)*(*z40a38d3b9e).z018277c676[2],(*z40a38d3b9e).
z018277c676[1]-(y/z90e1a42944)*(*z40a38d3b9e).z018277c676[2]};z558ec19d7e
za3158292ce[2]={x,y};z558ec19d7e zff400e9e97[2];z979ad56c58(z08ef030ac3,
zff400e9e97,za3158292ce);x=zff400e9e97[0];y=zff400e9e97[1];
if((*z40a38d3b9e).zedad526c61>1){z558ec19d7e z52ab5b652a=+x*(*z40a38d3b9e).
zf6c4585975+y*(*z40a38d3b9e).z308ac999d5;z558ec19d7e z56807b5599=-x*(*
z40a38d3b9e).z308ac999d5+y*(*z40a38d3b9e).zf6c4585975;z56807b5599=z56807b5599/(*
z40a38d3b9e).zedad526c61;x=(*z40a38d3b9e).zf6c4585975*z52ab5b652a-(*z40a38d3b9e)
.z308ac999d5*z56807b5599;y=(*z40a38d3b9e).z308ac999d5*z52ab5b652a+(*z40a38d3b9e)
.zf6c4585975*z56807b5599;}
if((*z40a38d3b9e).zf3080330b7)x=-x;if((*z40a38d3b9e).zadc09b44d2)y=-y;
*z4d5680d21d=x-(*z40a38d3b9e).z38190a079a;*z278ea663fa=y-(*z40a38d3b9e).
z03a1bfc64a;return false;}bool z273c93e8cd(z558ec19d7e*z4d5680d21d,z558ec19d7e*
z278ea663fa,zc950100d2f*z40a38d3b9e,__constant float4*zd2ade392dc,int2
z395c239ef8){
(*z4d5680d21d)*=(*z40a38d3b9e).z752a8e518e;(*z278ea663fa)*=(*z40a38d3b9e).
z752a8e518e;
bool z0958ad1650=ze1a90497f6(z4d5680d21d,z278ea663fa,z40a38d3b9e,zd2ade392dc,
z395c239ef8);return z0958ad1650;}bool zd6bc1d1ede(z558ec19d7e*z4d5680d21d,
z558ec19d7e*z278ea663fa,zc950100d2f*z40a38d3b9e,__constant float4*zd2ade392dc,
int2 z395c239ef8){bool z0958ad1650=z5638d497cd(z4d5680d21d,z278ea663fa,
z40a38d3b9e,zd2ade392dc,z395c239ef8);(*z4d5680d21d)*=(*z40a38d3b9e).zc0d94c7cf2;
(*z278ea663fa)*=(*z40a38d3b9e).zc0d94c7cf2;return z0958ad1650;}void z570c3238d2(
float*X,float*Y,int z80dd2bd3eb,int z995f1680f0){if(*X<0.0f){if(*X<-ze124eee453)
*X=-ze124eee453;*X=-*X;}else if(*X>=z80dd2bd3eb){if(*X>z80dd2bd3eb+ze124eee453)*
X=z80dd2bd3eb+ze124eee453;*X=(2*z80dd2bd3eb-1)-*X;}if(*Y<0.0f){if(*Y<-
ze124eee453)*Y=-ze124eee453;*Y=-*Y;}else if(*Y>=z995f1680f0){if(*Y>z995f1680f0+
ze124eee453)*Y=z995f1680f0+ze124eee453;*Y=(2*z995f1680f0-1)-*Y;}}
#if (z3dbd1ff682==0)
__kernel void z596e9c7f2c(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,uint z2824fcf57d,uint z9562068e13,float2
zde7902c213,int4 zed48be3170,float4 z29926d82e3,float4 z73899febe7,float16
z9a4cdc708f,float4 z73759bbb15,int8 zc8bf9b79e6,__constant float4*z526ad5087b,
int2 ze6493c8bac,__global int*z93a08e63a7,int4 zd42d42cbea,__global float*
z1fd6f3ce38,int4 z20d3340563){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));float2 z0223c8cb53=convert_float2((int2)(get_global_id(0),
get_global_id(1)));if(z0223c8cb53.x>=z30eaaf69b7.s2||z0223c8cb53.y>=z30eaaf69b7.
s3)return;float2 z83640e5796=z0223c8cb53;float2 zcdc63e27b9=(z83640e5796)+(
float2)(.5f,.5f);

zcdc63e27b9=zcdc63e27b9+z73899febe7.xy;zc950100d2f zff400e9e97;float zcd810bcd22
=z9a4cdc708f.s0;zff400e9e97.z752a8e518e=z9a4cdc708f.s1;zff400e9e97.zf544d6517b[0
]=z9a4cdc708f.s2;zff400e9e97.zf544d6517b[1]=z9a4cdc708f.s3;zff400e9e97.
zf544d6517b[2]=z9a4cdc708f.s4;zff400e9e97.z018277c676[0]=z9a4cdc708f.s5;
zff400e9e97.z018277c676[1]=z9a4cdc708f.s6;zff400e9e97.z018277c676[2]=z9a4cdc708f
.s7;zff400e9e97.z38190a079a=z9a4cdc708f.s8;zff400e9e97.z03a1bfc64a=z9a4cdc708f.
s9;zff400e9e97.z8fa4e208cf=z9a4cdc708f.sa;zff400e9e97.z562deb28a6=z9a4cdc708f.sb
;zff400e9e97.zf6c4585975=z9a4cdc708f.sc;zff400e9e97.z308ac999d5=z9a4cdc708f.sd;
zff400e9e97.zedad526c61=z9a4cdc708f.se;float ze8342c1e32=z9a4cdc708f.sf;
zff400e9e97.z9da154f764=z73759bbb15.s0;zff400e9e97.zf1519608a0=z73759bbb15.s1;
zff400e9e97.zdf5124debe=z73759bbb15.s2;zff400e9e97.zd527de668d=z73759bbb15.s3;
zff400e9e97.zf3080330b7=zc8bf9b79e6.s0;zff400e9e97.zadc09b44d2=zc8bf9b79e6.s1;
zff400e9e97.zf352921518=zc8bf9b79e6.s2;zff400e9e97.zbac83770ff=zc8bf9b79e6.s3;
zff400e9e97.zd79caea3d7=zc8bf9b79e6.s4;zff400e9e97.zed30332b1a=zc8bf9b79e6.s5;
zff400e9e97.zb3ba66c6db=zc8bf9b79e6.s6;z558ec19d7e z448a3dde4b=zcdc63e27b9.x;
z558ec19d7e ze7c57fc5f9=zcdc63e27b9.y;bool z8b96ed4ce7=!z273c93e8cd(&z448a3dde4b
,&ze7c57fc5f9,&zff400e9e97,z526ad5087b,ze6493c8bac);z570c3238d2(&z448a3dde4b,&
ze7c57fc5f9,(int)zde7902c213.x,(int)zde7902c213.y);zcdc63e27b9.x=z448a3dde4b;
zcdc63e27b9.y=ze7c57fc5f9;zcdc63e27b9*=zcd810bcd22;zcdc63e27b9-=z29926d82e3.xy;
zcdc63e27b9-=(float2)(.5f,.5f);
#if 1
int2 z7d4224f715=convert_int2(floor(zcdc63e27b9));z7d4224f715+=(zed48be3170.xy);
float4 z9d6d310443=zf8d9fd6cb8[z7d4224f715.x+z7d4224f715.y*(z2824fcf57d)];float4
 z05b9b9f342=zf8d9fd6cb8[1+z7d4224f715.x+z7d4224f715.y*(z2824fcf57d)];float2
z67ced5074b=zcdc63e27b9-floor(zcdc63e27b9);

float2 W=1.0f-z67ced5074b;float z648af8356b=W.x*W.y;float z7afaa48361=
z67ced5074b.x*W.y;float zd62711b375=W.x*z67ced5074b.y;float zcbfc8e3590=
z67ced5074b.x*z67ced5074b.y;float4 z7e839aad5b=z648af8356b*z9d6d310443+
z7afaa48361*z05b9b9f342;float4 z10f7a29f4f=zf8d9fd6cb8[z7d4224f715.x+(1+
z7d4224f715.y)*(z2824fcf57d)];float4 z6c4fb551d9=zf8d9fd6cb8[1+z7d4224f715.x+(1+
z7d4224f715.y)*(z2824fcf57d)];z7e839aad5b+=zd62711b375*z10f7a29f4f+zcbfc8e3590*
z6c4fb551d9;
#endif
int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int2 z9b046bc3a1=zba94ee46da+
zd42d42cbea.xy;z93a08e63a7[z9b046bc3a1.x+z9b046bc3a1.y*zd42d42cbea.z]=(
z8b96ed4ce7?0:1);if(z20d3340563.z>0){int2 z29e3a634be=zba94ee46da+z20d3340563.xy
;float z5d882dbfe4=2.0f*z67ced5074b.x-1.0f;float z00153ac6f8=2.0f*z67ced5074b.y-
1.0f;float z90e1a42944=0.1367865147f;

z90e1a42944=z90e1a42944*ze8342c1e32;
z7e839aad5b.w=z90e1a42944*(1.0f-z5d882dbfe4*z5d882dbfe4);z1fd6f3ce38[z29e3a634be
.x+z29e3a634be.y*z20d3340563.z]=z90e1a42944*(1.0f-z00153ac6f8*z00153ac6f8);}
z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*(z9562068e13)]=z7e839aad5b;}
#endif
#if (z3dbd1ff682==1)
__kernel void z596e9c7f2c(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,uint z021babbfad,uint z958df11031){int2 zba94ee46da
=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>z30eaaf69b7.s2||
zba94ee46da.y>z30eaaf69b7.s3)return;__global float4*zba15fb8bb8=zf8d9fd6cb8+
z30eaaf69b7.s4+z30eaaf69b7.s5*z021babbfad;__global float4*zddaa6f652d=
z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.s1*z958df11031;int x=zba94ee46da.s0;int y
=zba94ee46da.s1;__global float4*z395b96baac=&zba15fb8bb8[y*z021babbfad];__global
 float4*ze4351005bc=&zddaa6f652d[y*z958df11031];

float4 z2d351c5ace=z395b96baac[x];float z842f1c9b69=z2d351c5ace.w;float
z908a899bab=1.0f+2.0f*z842f1c9b69;float4 za04ba6a9e8=z395b96baac[x-1];float4
z101baeb487=z395b96baac[x+1];ze4351005bc[x]=z2d351c5ace*z908a899bab-z842f1c9b69*
(za04ba6a9e8+z101baeb487);}
#endif
#if (z3dbd1ff682==2)
__kernel void z596e9c7f2c(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,uint z021babbfad,uint z958df11031,__global float*
z1fd6f3ce38,int4 z20d3340563){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>z30eaaf69b7.s2||zba94ee46da.y>z30eaaf69b7.s3)
return;__global float4*zba15fb8bb8=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*
z021babbfad;__global float4*zddaa6f652d=z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.
s1*z958df11031;int x=zba94ee46da.s0;int y=zba94ee46da.s1;__global float4*
z395b96baac=&zba15fb8bb8[y*z021babbfad];__global float4*ze4351005bc=&zddaa6f652d
[y*z958df11031];
float4 z2d351c5ace=z395b96baac[x];int2 zc250b10c7f=zba94ee46da.s01+z20d3340563.
s01;float z842f1c9b69=z1fd6f3ce38[zc250b10c7f.s0+z20d3340563.s1*z20d3340563.s2];
float z908a899bab=1.0f+2.0f*z842f1c9b69;float4 za04ba6a9e8=z395b96baac[x-
z021babbfad];float4 z101baeb487=z395b96baac[x+z021babbfad];ze4351005bc[x]=
z2d351c5ace*z908a899bab-z842f1c9b69*(za04ba6a9e8+z101baeb487);}
#endif
void z7e098fcf37(float x,float y,float*zab9b0f50a3,float*zb782d7612b,zc950100d2f
*z40a38d3b9e,__constant float4*zd2ade392dc,int2 z395c239ef8){




z558ec19d7e z1086bfcf32=x-0.5f,zb0f9f41f0d=y-0.5f;z558ec19d7e ze18efc33c6=x+0.5f
,z1e7b78e3ef=y-0.5f;z558ec19d7e zc676cc51f4=x-0.5f,zf31ea9d409=y+0.5f;
z558ec19d7e z754365ae2f=x+0.5f,zeb3e878ba1=y+0.5f;z273c93e8cd(&z1086bfcf32,&
zb0f9f41f0d,z40a38d3b9e,zd2ade392dc,z395c239ef8);z273c93e8cd(&ze18efc33c6,&
z1e7b78e3ef,z40a38d3b9e,zd2ade392dc,z395c239ef8);z273c93e8cd(&zc676cc51f4,&
zf31ea9d409,z40a38d3b9e,zd2ade392dc,z395c239ef8);z273c93e8cd(&z754365ae2f,&
zeb3e878ba1,z40a38d3b9e,zd2ade392dc,z395c239ef8);z558ec19d7e z8dc4385abe=((
ze18efc33c6-z1086bfcf32)+(z754365ae2f-zc676cc51f4))*0.25f;z558ec19d7e
z60a7a37073=((z1e7b78e3ef-zb0f9f41f0d)+(zeb3e878ba1-zf31ea9d409))*0.25f;
z558ec19d7e z31e5f43094=((zc676cc51f4-z1086bfcf32)+(z754365ae2f-ze18efc33c6))*
0.25f;z558ec19d7e z9fef73c85a=((zf31ea9d409-zb0f9f41f0d)+(zeb3e878ba1-
z1e7b78e3ef))*0.25f;z558ec19d7e z08ef030ac3[4]={z8dc4385abe*z8dc4385abe,
z31e5f43094*z31e5f43094,z60a7a37073*z60a7a37073,z9fef73c85a*z9fef73c85a};
z558ec19d7e za3158292ce[2]={0.25,0.25};z558ec19d7e zb1707240ed[2];
z558ec19d7e zd6753a3858=(z08ef030ac3[0]+z08ef030ac3[1]+z08ef030ac3[2]+
z08ef030ac3[3])*1.0e-6;z08ef030ac3[0]+=zd6753a3858;z08ef030ac3[3]+=zd6753a3858;
if(z979ad56c58(z08ef030ac3,zb1707240ed,za3158292ce)>=0&&zb1707240ed[0]>0.0&&
zb1707240ed[1]>0.0){
*zab9b0f50a3=1.0/sqrt(zb1707240ed[0]);*zb782d7612b=1.0/sqrt(zb1707240ed[1]);}
else{*zab9b0f50a3=sqrt(z8dc4385abe*z8dc4385abe+z60a7a37073*z60a7a37073);*
zb782d7612b=sqrt(z31e5f43094*z31e5f43094+z9fef73c85a*z9fef73c85a);}}
#if (z3dbd1ff682 == 3)
__kernel void z224644bb34(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,uint z2824fcf57d,uint z9562068e13,float2 zde7902c213,int4
z3f816b30a5,float16 z9a4cdc708f,float4 z73759bbb15,int8 zc8bf9b79e6,__constant
float4*z526ad5087b,int2 ze6493c8bac){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.
s3)return;float2 z0223c8cb53=convert_float2(zba94ee46da);zc950100d2f zff400e9e97
;float z32d38a8179=1.f/z9a4cdc708f.s0;float z5b8c31c8e4=z9a4cdc708f.s0;
zff400e9e97.z752a8e518e=z9a4cdc708f.s1;zff400e9e97.zf544d6517b[0]=z9a4cdc708f.s2
;zff400e9e97.zf544d6517b[1]=z9a4cdc708f.s3;zff400e9e97.zf544d6517b[2]=
z9a4cdc708f.s4;zff400e9e97.z018277c676[0]=z9a4cdc708f.s5;zff400e9e97.z018277c676
[1]=z9a4cdc708f.s6;zff400e9e97.z018277c676[2]=z9a4cdc708f.s7;zff400e9e97.
z38190a079a=z9a4cdc708f.s8;zff400e9e97.z03a1bfc64a=z9a4cdc708f.s9;zff400e9e97.
z8fa4e208cf=z9a4cdc708f.sa;zff400e9e97.z562deb28a6=z9a4cdc708f.sb;zff400e9e97.
zf6c4585975=z9a4cdc708f.sc;zff400e9e97.z308ac999d5=z9a4cdc708f.sd;zff400e9e97.
zedad526c61=z9a4cdc708f.se;float ze8342c1e32=z9a4cdc708f.sf;zff400e9e97.
z9da154f764=z73759bbb15.s0;zff400e9e97.zf1519608a0=z73759bbb15.s1;zff400e9e97.
zdf5124debe=z73759bbb15.s2;zff400e9e97.zd527de668d=z73759bbb15.s3;zff400e9e97.
zf3080330b7=zc8bf9b79e6.s0;zff400e9e97.zadc09b44d2=zc8bf9b79e6.s1;zff400e9e97.
zf352921518=zc8bf9b79e6.s2;zff400e9e97.zbac83770ff=zc8bf9b79e6.s3;zff400e9e97.
zd79caea3d7=zc8bf9b79e6.s4;zff400e9e97.zed30332b1a=zc8bf9b79e6.s5;zff400e9e97.
zb3ba66c6db=zc8bf9b79e6.s6;float zd95e72d374=(z3f816b30a5.x+z0223c8cb53.x)*
z32d38a8179;float z0bfe7eaf74=(z3f816b30a5.y+z0223c8cb53.y)*z32d38a8179;
zd6bc1d1ede(&zd95e72d374,&z0bfe7eaf74,&zff400e9e97,z526ad5087b,ze6493c8bac);
float zab9b0f50a3,zb782d7612b;
z7e098fcf37(zd95e72d374,z0bfe7eaf74,&zab9b0f50a3,&zb782d7612b,&zff400e9e97,
z526ad5087b,ze6493c8bac);uint z6146937a2a=z2824fcf57d;uint zb52f3b2f15=
z9562068e13;__global float*zc59b2e75c3=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5
*z2824fcf57d;__global float*zf3880bb344=z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.
s1*z9562068e13;zc59b2e75c3[z6146937a2a*zba94ee46da.y+zba94ee46da.x]=zab9b0f50a3*
z5b8c31c8e4;zf3880bb344[zb52f3b2f15*zba94ee46da.y+zba94ee46da.x]=zb782d7612b*
z5b8c31c8e4;}
#endif
#if (z3dbd1ff682==4)
__kernel void z224644bb34(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,uint z021babbfad,uint z958df11031,__global float*
zbc3880f44e,int4 zf51d96f0b4){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>z30eaaf69b7.s2||zba94ee46da.y>z30eaaf69b7.s3)
return;__global float4*zba15fb8bb8=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*
z021babbfad;__global float4*zddaa6f652d=z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.
s1*z958df11031;int x=zba94ee46da.s0;int y=zba94ee46da.s1;__global float4*
z395b96baac=&zba15fb8bb8[y*z021babbfad];__global float4*ze4351005bc=&zddaa6f652d
[y*z958df11031];

int2 zbe3cc94d74=zba94ee46da.s01+zf51d96f0b4.s01;float4 z2d351c5ace=z395b96baac[
x];float zf94fcc61e4=zbc3880f44e[zbe3cc94d74.s0+zf51d96f0b4.s1*zf51d96f0b4.s2];

zf94fcc61e4=clamp(zf94fcc61e4,1.0f,3.0f);float zc10d38c99c=1.0f/zf94fcc61e4;
float zea34483265=(1.0f-zc10d38c99c)*0.5f;float4 za04ba6a9e8=z395b96baac[x-1];
float4 z101baeb487=z395b96baac[x+1];ze4351005bc[x]=zc10d38c99c*z2d351c5ace+
zea34483265*(za04ba6a9e8+z101baeb487);}
#endif
#if (z3dbd1ff682==5)
__kernel void z224644bb34(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,uint z021babbfad,uint z958df11031,__global float*
zbc3880f44e,int4 zf51d96f0b4){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>z30eaaf69b7.s2||zba94ee46da.y>z30eaaf69b7.s3)
return;__global float4*zba15fb8bb8=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*
z021babbfad;__global float4*zddaa6f652d=z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.
s1*z958df11031;int x=zba94ee46da.s0;int y=zba94ee46da.s1;__global float4*
z395b96baac=&zba15fb8bb8[y*z021babbfad];__global float4*ze4351005bc=&zddaa6f652d
[y*z958df11031];float4 z2d351c5ace=z395b96baac[x];int2 zbe3cc94d74=zba94ee46da.
s01+zf51d96f0b4.s01;float zf94fcc61e4=zbc3880f44e[zbe3cc94d74.s0+zf51d96f0b4.s1*
zf51d96f0b4.s2];

zf94fcc61e4=clamp(zf94fcc61e4,1.0f,3.0f);float zc10d38c99c=1.0f/zf94fcc61e4;
float zea34483265=(1.0f-zc10d38c99c)*0.5f;float4 za04ba6a9e8=z395b96baac[x-
z021babbfad];float4 z101baeb487=z395b96baac[x+z021babbfad];ze4351005bc[x]=
zc10d38c99c*z2d351c5ace+zea34483265*(za04ba6a9e8+z101baeb487);}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
