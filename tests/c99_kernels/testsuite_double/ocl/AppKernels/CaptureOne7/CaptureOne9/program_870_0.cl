#define z370db0e88a 1
 #define z3dbd1ff682 101
 #define z164047dc0a 5

#ifndef z3dbd1ff682
#define z3dbd1ff682 0
#endif
#define zba5c6acf5c fabs
#define MIN min
#define MAX max
#define z121e64db3b sqrt
#define z205bcb857e floor
#define zb990c47a0c ceil
#define __INLINE__ inline
#define zf76fcfe641
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

#define z558ec19d7e float
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
#if 0
if(fabs(X-z6624dbc6f0)<0.0001f)return z1409a29adb;
if(X<z6624dbc6f0)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;
#else

if(fabs(X-z6624dbc6f0)<0.0001f){
z7d07bb3247=z1409a29adb;zbf32ff9ae0=-1;}else{
if(X<z6624dbc6f0)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;}
#endif
}return z7d07bb3247;}int ze94c3fdd77(z558ec19d7e ze7168fc0b9[3],z558ec19d7e
zff400e9e97[2]){
z558ec19d7e zf793de71f2=ze7168fc0b9[1]*ze7168fc0b9[1]-4*ze7168fc0b9[0]*
ze7168fc0b9[2];if(zf793de71f2<0)return 0;
z558ec19d7e z11fc704ac4=sqrt(zf793de71f2);if(ze7168fc0b9[1]<0)z11fc704ac4=(
z558ec19d7e)-0.5*(ze7168fc0b9[1]-z11fc704ac4);else z11fc704ac4=(z558ec19d7e)-0.5
*(ze7168fc0b9[1]+z11fc704ac4);
zff400e9e97[0]=z11fc704ac4/ze7168fc0b9[2];zff400e9e97[1]=ze7168fc0b9[0]/
z11fc704ac4;return 2;}int zda883a2d9b(z558ec19d7e ze7168fc0b9[4],z558ec19d7e
zff400e9e97[3]){z558ec19d7e z2dd09f3226=ze7168fc0b9[2]/ze7168fc0b9[3];
z558ec19d7e za3158292ce=ze7168fc0b9[1]/ze7168fc0b9[3];z558ec19d7e ze28128c2dd=
ze7168fc0b9[0]/ze7168fc0b9[3];z558ec19d7e z4a8d526d4d=z2dd09f3226*z2dd09f3226;
z558ec19d7e z9386a0103f=(z4a8d526d4d-(z558ec19d7e)3*za3158292ce)/(z558ec19d7e)
9.0;z558ec19d7e ze4b052164b=((z558ec19d7e)2.0*z2dd09f3226*z4a8d526d4d-(
z558ec19d7e)9.0*z2dd09f3226*za3158292ce+(z558ec19d7e)27.0*ze28128c2dd)/(
z558ec19d7e)54.0;z558ec19d7e z86e6c4db76=z9386a0103f*z9386a0103f*z9386a0103f;
z558ec19d7e z154167adc5=ze4b052164b*ze4b052164b;z558ec19d7e zef36d9b1e8=
z2dd09f3226*(z558ec19d7e)(1.0/3.0);
if(z154167adc5<z86e6c4db76){z558ec19d7e za95a1cf587=acos(ze4b052164b/sqrt(
z86e6c4db76));z558ec19d7e z84a0cd7974=za95a1cf587*(z558ec19d7e)(1.0/3.0);
z558ec19d7e z90e1a42944=-(z558ec19d7e)2.0*sqrt(z9386a0103f);zff400e9e97[0]=
z90e1a42944*cos(z84a0cd7974)-zef36d9b1e8;z558ec19d7e zb8acde8c14=z84735a7cc1*(
z558ec19d7e)(2.0/3.0);zff400e9e97[1]=z90e1a42944*cos(z84a0cd7974+zb8acde8c14)-
zef36d9b1e8;zff400e9e97[2]=z90e1a42944*cos(z84a0cd7974-zb8acde8c14)-zef36d9b1e8;
return 3;}
z558ec19d7e z08ef030ac3=cbrt(fabs(ze4b052164b)+sqrt(z154167adc5-z86e6c4db76));
z558ec19d7e z7e674d442a=0;if(ze4b052164b>(z558ec19d7e)0.0)z08ef030ac3=(-
z08ef030ac3);if(z08ef030ac3!=(z558ec19d7e)0.0)z7e674d442a=z9386a0103f/
z08ef030ac3;zff400e9e97[0]=(z08ef030ac3+z7e674d442a)-zef36d9b1e8;return 1;}int
z8eaf63a1e7(int z88fa33d26d,z558ec19d7e*ze7168fc0b9,z558ec19d7e*zff400e9e97){
switch(z88fa33d26d){case 1:zff400e9e97[0]=-ze7168fc0b9[0]/ze7168fc0b9[1];return
1;case 2:return ze94c3fdd77(ze7168fc0b9,zff400e9e97);case 3:return zda883a2d9b(
ze7168fc0b9,zff400e9e97);default:return-1;}}void z5417645477(ze9dc86233a*
z493deefb55,z558ec19d7e*z5462909dc1,z558ec19d7e*z2dd09f3226){
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
#if 0
if(fabs(y-z23774b5397)<0.0001f)return z1409a29adb;
if(y<z23774b5397)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;
#else

if(fabs(y-z23774b5397)<0.0001f){
z7d07bb3247=z1409a29adb;zbf32ff9ae0=-1;}else{
if(y<z23774b5397)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;}
#endif
}return z7d07bb3247;}else if(z63da1ee795==zbbe33f9ac3){
while(zbf32ff9ae0-z7d07bb3247>1){int z1409a29adb=(z7d07bb3247+zbf32ff9ae0)/2;
z558ec19d7e z23774b5397=zcb1b02776b[z1409a29adb].y;
#if 0
if(fabs(y-z23774b5397)<0.0001f)return z1409a29adb;
if(y<z23774b5397)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;
#else

if(fabs(y-z23774b5397)<0.0001f){
z7d07bb3247=z1409a29adb;zbf32ff9ae0=-1;}else{
if(y<z23774b5397)zbf32ff9ae0=z1409a29adb;else z7d07bb3247=z1409a29adb;}
#endif
}return z7d07bb3247;}
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
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float2 zde7902c213,
int4 zed48be3170,float4 z29926d82e3,float4 z73899febe7,float16 z9a4cdc708f,
float4 z73759bbb15,int8 zc8bf9b79e6,__constant float4*z526ad5087b,int2
ze6493c8bac,__global ushort*z93a08e63a7,int4 zd42d42cbea,__global float*
z65a765f11f,int4 ze51e508e66,__global float*z1fd6f3ce38,int4 z20d3340563){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));float2 z0223c8cb53=
convert_float2((int2)(get_global_id(0),get_global_id(1)));if(z0223c8cb53.x>=
z30eaaf69b7.s2||z0223c8cb53.y>=z30eaaf69b7.s3)return;float2 z83640e5796=
z0223c8cb53;float2 zcdc63e27b9=(z83640e5796)+(float2)(.5f,.5f);

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

float2 zc66d8605a0=1.0f-z67ced5074b;float z648af8356b=zc66d8605a0.x*zc66d8605a0.
y;float z7afaa48361=z67ced5074b.x*zc66d8605a0.y;float zd62711b375=zc66d8605a0.x*
z67ced5074b.y;float zcbfc8e3590=z67ced5074b.x*z67ced5074b.y;float4 z7e839aad5b=
z648af8356b*z9d6d310443+z7afaa48361*z05b9b9f342;float4 z10f7a29f4f=zf8d9fd6cb8[
z7d4224f715.x+(1+z7d4224f715.y)*(z2824fcf57d)];float4 z6c4fb551d9=zf8d9fd6cb8[1+
z7d4224f715.x+(1+z7d4224f715.y)*(z2824fcf57d)];z7e839aad5b+=zd62711b375*
z10f7a29f4f+zcbfc8e3590*z6c4fb551d9;
#endif
int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int2 z9b046bc3a1=zba94ee46da+
zd42d42cbea.xy;z93a08e63a7[z9b046bc3a1.x+z9b046bc3a1.y*zd42d42cbea.z]=(
z8b96ed4ce7?0:z30701fddb8);if(ze51e508e66.z>0){int2 z1ee546fd1e=zba94ee46da+
ze51e508e66.xy;int2 z29e3a634be=zba94ee46da+z20d3340563.xy;float z5d882dbfe4=
2.0f*z67ced5074b.x-1.0f;float z00153ac6f8=2.0f*z67ced5074b.y-1.0f;float
z90e1a42944=0.1367865147f;

z90e1a42944=z90e1a42944*ze8342c1e32;
z65a765f11f[z1ee546fd1e.x+z1ee546fd1e.y*ze51e508e66.z]=z90e1a42944*(1.0f-
z5d882dbfe4*z5d882dbfe4);z1fd6f3ce38[z29e3a634be.x+z29e3a634be.y*z20d3340563.z]=
z90e1a42944*(1.0f-z00153ac6f8*z00153ac6f8);}z718a062ddd[zaaf414d14e.x+
zaaf414d14e.y*(z9562068e13)]=z7e839aad5b;}
#endif
#if (z3dbd1ff682==1)
__kernel void z596e9c7f2c(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z958df11031,__global float*
z9e020017f8,int4 z3c88059b64){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>z30eaaf69b7.s2||zba94ee46da.y>z30eaaf69b7.s3)
return;__global float4*zba15fb8bb8=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*
z021babbfad;__global float4*zddaa6f652d=z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.
s1*z958df11031;int x=zba94ee46da.s0;int y=zba94ee46da.s1;__global float4*
z395b96baac=&zba15fb8bb8[y*z021babbfad];__global float4*ze4351005bc=&zddaa6f652d
[y*z958df11031];

float4 z2d351c5ace=z395b96baac[x];int2 z07156354c2=zba94ee46da.xy+z3c88059b64.xy
;float z842f1c9b69=z9e020017f8[z07156354c2.x+z07156354c2.y*z3c88059b64.z];float
z908a899bab=1.0f+2.0f*z842f1c9b69;float4 za04ba6a9e8=z395b96baac[x-1];float4
z101baeb487=z395b96baac[x+1];ze4351005bc[x]=(float4)z908a899bab*z2d351c5ace-(
float4)z842f1c9b69*(za04ba6a9e8+z101baeb487);}
#endif
#if (z3dbd1ff682==2)
__kernel void z596e9c7f2c(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z958df11031,__global float*
z9e020017f8,int4 z3c88059b64){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>z30eaaf69b7.s2||zba94ee46da.y>z30eaaf69b7.s3)
return;__global float4*zba15fb8bb8=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*
z021babbfad;__global float4*zddaa6f652d=z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.
s1*z958df11031;int x=zba94ee46da.s0;int y=zba94ee46da.s1;__global float4*
z395b96baac=&zba15fb8bb8[y*z021babbfad];__global float4*ze4351005bc=&zddaa6f652d
[y*z958df11031];
float4 z2d351c5ace=z395b96baac[x];int2 z07156354c2=zba94ee46da.xy+z3c88059b64.xy
;float z842f1c9b69=z9e020017f8[z07156354c2.x+z07156354c2.y*z3c88059b64.z];float
z908a899bab=1.0f+2.0f*z842f1c9b69;float4 za04ba6a9e8=z395b96baac[x-z021babbfad];
float4 z101baeb487=z395b96baac[x+z021babbfad];ze4351005bc[x]=max((float4)0,(
float4)z908a899bab*z2d351c5ace-(float4)z842f1c9b69*(za04ba6a9e8+z101baeb487));}
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
int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float2 zde7902c213,int4
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
z526ad5087b,ze6493c8bac);int z6146937a2a=z2824fcf57d;int zb52f3b2f15=z9562068e13
;__global float*zc59b2e75c3=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*
z2824fcf57d;__global float*zf3880bb344=z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.s1
*z9562068e13;zc59b2e75c3[z6146937a2a*zba94ee46da.y+zba94ee46da.x]=zab9b0f50a3*
z5b8c31c8e4;zf3880bb344[zb52f3b2f15*zba94ee46da.y+zba94ee46da.x]=zb782d7612b*
z5b8c31c8e4;}
#endif
#if (z3dbd1ff682==4)
__kernel void z224644bb34(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z958df11031,__global float*
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
z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z958df11031,__global float*
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
float zad9f0eecea(const float x,const float z9c33dc0de6){const float zd5fcb412ee
=z9c33dc0de6+(float)ze124eee453;const float z746f1c669d=(float)(-ze124eee453);
const float z35bf29e99b=MIN(zd5fcb412ee,x);const float z2c865879a0=z9c33dc0de6-
zba5c6acf5c(z9c33dc0de6-z35bf29e99b);const float z6624dbc6f0=MAX(z746f1c669d,
z2c865879a0);const float zd649de2ebe=zba5c6acf5c(z6624dbc6f0);return zd649de2ebe
;}
#define z980c02f290 rint
#if (z3dbd1ff682==6)
__kernel void z596e9c7f2c(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int4 zc8bf9b79e6,
float8 ze0995e6531){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));
if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;__global
float4*zba15fb8bb8=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*z2824fcf57d;
__global float4*zddaa6f652d=z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.s1*
z9562068e13;int x=zba94ee46da.s0;int y=zba94ee46da.s1;

const float zbbe9048962=ze0995e6531.s0;const float zbd04edcdf2=ze0995e6531.s1;
const float z8eb50cfcf6=ze0995e6531.s2;const float z6a7650c31d=ze0995e6531.s3;
const float zead889caaa=ze0995e6531.s4;const float z3e5fa7191f=ze0995e6531.s5;
const float zcd810bcd22=ze0995e6531.s6;const int z574cdf3aac=zc8bf9b79e6.s0;
const int z761d6c2502=zc8bf9b79e6.s1;const float z9a112927fc=zad9f0eecea(
zbd04edcdf2+y*z6a7650c31d,z761d6c2502);const int zd83784f0e8=z980c02f290(
z9a112927fc*zcd810bcd22+z3e5fa7191f);const float zbae767834f=zad9f0eecea(
zbbe9048962+x*z8eb50cfcf6,z574cdf3aac);const int z061d543957=z980c02f290(
zbae767834f*zcd810bcd22+zead889caaa);float4 z2d351c5ace=zba15fb8bb8[z061d543957+
zd83784f0e8*z2824fcf57d];zddaa6f652d[x+y*z9562068e13]=z2d351c5ace;}
#endif
#if (z3dbd1ff682 == 7)
__kernel void z596e9c7f2c(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int4 zc8bf9b79e6,
float8 ze0995e6531){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));
if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;__global
float4*zba15fb8bb8=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*z2824fcf57d;
__global float4*zddaa6f652d=z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.s1*
z9562068e13;int x=zba94ee46da.s0;int y=zba94ee46da.s1;

const float zbbe9048962=ze0995e6531.s0;const float zbd04edcdf2=ze0995e6531.s1;
const float z63ad970f59=ze0995e6531.s2;const float z12923ac1c4=ze0995e6531.s3;
const float zead889caaa=ze0995e6531.s4;const float z3e5fa7191f=ze0995e6531.s5;
const float zcd810bcd22=ze0995e6531.s6;const int z574cdf3aac=zc8bf9b79e6.s0;
const int z761d6c2502=zc8bf9b79e6.s1;const float z9a112927fc=zad9f0eecea(
zbd04edcdf2+x*z63ad970f59,z761d6c2502);const int z061d543957=rint(z9a112927fc*
zcd810bcd22+z3e5fa7191f);

const float zbae767834f=zad9f0eecea(zbbe9048962+y*z12923ac1c4,z574cdf3aac);const
 int zd83784f0e8=rint(zbae767834f*zcd810bcd22+zead889caaa);

float4 z2d351c5ace=zba15fb8bb8[zd83784f0e8+z061d543957*z2824fcf57d];zddaa6f652d[
x+y*z9562068e13]=z2d351c5ace;}
#endif
#if (z3dbd1ff682==8)
__kernel void z596e9c7f2c(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float16 z9a4cdc708f,float4
z73759bbb15,int8 zc8bf9b79e6,__constant float4*z526ad5087b,int2 ze6493c8bac,
float4 zc6fd911d65,__global ushort*z93a08e63a7,int4 zd42d42cbea){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int zc180b9cdc9=zba94ee46da
.x;int za3584c0652=zba94ee46da.y;__global float*z12eec47f12=zf8d9fd6cb8+
z30eaaf69b7.s4+(z30eaaf69b7.s5+za3584c0652)*z2824fcf57d;__global float*
zd34cab886b=z718a062ddd+z30eaaf69b7.s0+(z30eaaf69b7.s1+za3584c0652)*z9562068e13;
zc950100d2f zff400e9e97;zff400e9e97.z752a8e518e=z9a4cdc708f.s1;zff400e9e97.
zf544d6517b[0]=z9a4cdc708f.s2;zff400e9e97.zf544d6517b[1]=z9a4cdc708f.s3;
zff400e9e97.zf544d6517b[2]=z9a4cdc708f.s4;zff400e9e97.z018277c676[0]=z9a4cdc708f
.s5;zff400e9e97.z018277c676[1]=z9a4cdc708f.s6;zff400e9e97.z018277c676[2]=
z9a4cdc708f.s7;zff400e9e97.z38190a079a=z9a4cdc708f.s8;zff400e9e97.z03a1bfc64a=
z9a4cdc708f.s9;zff400e9e97.z8fa4e208cf=z9a4cdc708f.sa;zff400e9e97.z562deb28a6=
z9a4cdc708f.sb;zff400e9e97.zf6c4585975=z9a4cdc708f.sc;zff400e9e97.z308ac999d5=
z9a4cdc708f.sd;zff400e9e97.zedad526c61=z9a4cdc708f.se;zff400e9e97.z9da154f764=
z73759bbb15.s0;zff400e9e97.zf1519608a0=z73759bbb15.s1;zff400e9e97.zdf5124debe=
z73759bbb15.s2;zff400e9e97.zd527de668d=z73759bbb15.s3;zff400e9e97.zf3080330b7=
zc8bf9b79e6.s0;zff400e9e97.zadc09b44d2=zc8bf9b79e6.s1;zff400e9e97.zf352921518=
zc8bf9b79e6.s2;zff400e9e97.zbac83770ff=zc8bf9b79e6.s3;zff400e9e97.zd79caea3d7=
zc8bf9b79e6.s4;zff400e9e97.zed30332b1a=zc8bf9b79e6.s5;zff400e9e97.zb3ba66c6db=
zc8bf9b79e6.s6;float zb6676bb400=zc6fd911d65.s0;float zd2d7040261=zc6fd911d65.s1
;float zf565ea5a2a=zc6fd911d65.s2;float z2c2d794fae=zc6fd911d65.s3;z558ec19d7e y
=(z558ec19d7e)za3584c0652+zd2d7040261;z558ec19d7e x=(z558ec19d7e)zc180b9cdc9+
zb6676bb400;bool z8b96ed4ce7=!z273c93e8cd(&x,&y,&zff400e9e97,z526ad5087b,
ze6493c8bac);z12eec47f12[zc180b9cdc9]=(float)(x+zf565ea5a2a);zd34cab886b[
zc180b9cdc9]=(float)(y+z2c2d794fae);int2 z9b046bc3a1=zba94ee46da+zd42d42cbea.s01
;z93a08e63a7[z9b046bc3a1.x+z9b046bc3a1.y*zd42d42cbea.s2]=(z8b96ed4ce7?0:
z30701fddb8);}
#endif
#if (z3dbd1ff682==9)
__kernel void z596e9c7f2c(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,__global float*
zddbf98e21d,int8 zbae6ee51b7){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.
s3)return;int x=zba94ee46da.s0;int y=zba94ee46da.s1;


const int zf2c75e3cd1=zbae6ee51b7.s0;const int z9cc106d220=zbae6ee51b7.s1;const
int z51ef4c4ebd=zbae6ee51b7.s2;const int za0b3cde972=zbae6ee51b7.s3;const int
z7f5f59b77c=zbae6ee51b7.s4;__global float4*zba15fb8bb8=zf8d9fd6cb8+z30eaaf69b7.
s4+z30eaaf69b7.s5*z2824fcf57d;__global float*z52077cad84=zddbf98e21d+z9cc106d220
+(z51ef4c4ebd+y)*zf2c75e3cd1;__global float*z6b0dceb4ea=zddbf98e21d+z9cc106d220+
(za0b3cde972+y)*zf2c75e3cd1;__global float*zea2e8553bf=zddbf98e21d+z9cc106d220+(
z7f5f59b77c+y)*zf2c75e3cd1;













float4 z2d351c5ace=zba15fb8bb8[x+y*z2824fcf57d];z52077cad84[x]=cbrt(z2d351c5ace.
x);z6b0dceb4ea[x]=cbrt(z2d351c5ace.y);zea2e8553bf[x]=cbrt(z2d351c5ace.z);}
#endif
__INLINE__ float4 zca5c310c08(const float zbbe9048962,const float zbd04edcdf2,
const float zf0790ba3c5,const float zf660093704,const float ze360d54d02,const
float z4c3252cf74,const float z9c8040ead6,const float z1b3334b467)




{const float zebefb7edbe=ze360d54d02-zf0790ba3c5;const float z8f86fc8ce4=
z9c8040ead6-zbbe9048962;const float zc6255ab9b1=z4c3252cf74-zf660093704;const
float z2b8d4a5519=z1b3334b467-zbd04edcdf2;const float z2dd09f3226=0.25f*(
z8f86fc8ce4-zebefb7edbe);const float za3158292ce=0.25f*(z8f86fc8ce4+zebefb7edbe)
;const float z593fa3cb41=0.25f*(z2b8d4a5519+zc6255ab9b1);const float ze28128c2dd
=0.25f*(z2b8d4a5519-zc6255ab9b1);const float zff88a1e0c7=z2dd09f3226+z593fa3cb41
;const float ze4b4ecbbba=z2dd09f3226-z593fa3cb41;const float z722ec4c00b=
za3158292ce+ze28128c2dd;const float z649951b108=za3158292ce-ze28128c2dd;const
float z42dfa411be=z2dd09f3226*z2dd09f3226+za3158292ce*za3158292ce;const float
z4b49e923c5=ze28128c2dd*ze28128c2dd+z593fa3cb41*z593fa3cb41;const float
zc0b900064e=z2dd09f3226*ze28128c2dd+za3158292ce*z593fa3cb41;const float
zd4d63551ea=zff88a1e0c7*zff88a1e0c7+z649951b108*z649951b108;const float
z422526741d=ze4b4ecbbba*ze4b4ecbbba+z722ec4c00b*z722ec4c00b;const float
zea5fafa82b=zd4d63551ea*z422526741d;const float zc29971f180=z121e64db3b(
zea5fafa82b);const float zdd16d470f8=z42dfa411be+z4b49e923c5;float zb7dace4788=
0.5f*(zdd16d470f8+zc29971f180);float z1bb890fec3=0.5f*(zdd16d470f8-zc29971f180);
const float z0443d892e5=zb7dace4788-z42dfa411be;const float z8588743754=
zb7dace4788-z4b49e923c5;const float za1e5e44425=z0443d892e5*z0443d892e5;const
float z72b55f7128=z8588743754*z8588743754;const float zccd1e9da07=za1e5e44425>=
z72b55f7128?zc0b900064e:z8588743754;const float z5352b77a74=za1e5e44425>=
z72b55f7128?z0443d892e5:zc0b900064e;const float zb91f5c522e=zccd1e9da07*
zccd1e9da07+z5352b77a74*z5352b77a74;const float z79c385fdc9=1.f/z121e64db3b(
zb91f5c522e);float z003900f736=zb91f5c522e!=0.f?zccd1e9da07*z79c385fdc9:1.0f;
float z2502ed1f1b=zb91f5c522e!=0.f?z5352b77a74*z79c385fdc9:0.0f;return(float4)(
z003900f736,z2502ed1f1b,zb7dace4788,z1bb890fec3);}
#if (z3dbd1ff682==10)
__kernel void z596e9c7f2c(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float4 ze0995e6531,__global
float*z5246f68abf,__global float*z888cc57c38,int8 z5cd6a7ca74,__global uchar*
z93a08e63a7,int4 zd42d42cbea){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.
s3)return;int zc180b9cdc9=zba94ee46da.s0;int za3584c0652=zba94ee46da.s1;
const float zcd810bcd22=ze0995e6531.s0;const float z2f8cd4a634=ze0995e6531.s1;
const float z46a4100279=ze0995e6531.s2;const int zaef4813949=z9562068e13;
const int zbced03a0bf=z5cd6a7ca74.s0;


__global float*z51f03ba75e=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*zaef4813949
;__global float*zd7178d015e=z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.s1*
zaef4813949;float z4fd5a567c8=0.f;



__global float*zab76a4492b=z5246f68abf+z5cd6a7ca74.s1+z5cd6a7ca74.s2*zbced03a0bf
;__global float*z9ecf4c1465=z5246f68abf+z5cd6a7ca74.s1+z5cd6a7ca74.s3*
zbced03a0bf;__global float*zd1931edaaa=z888cc57c38+z5cd6a7ca74.s1+z5cd6a7ca74.s4
*zbced03a0bf;__global float*zedd19ca28d=z888cc57c38+z5cd6a7ca74.s1+z5cd6a7ca74.
s5*zbced03a0bf;
const int z71b6ccdbcf=za3584c0652*zaef4813949;const int zaf11e526b2=za3584c0652*
zbced03a0bf;__global float*zf76fcfe641 z3ce0bac028=z51f03ba75e+z71b6ccdbcf;
__global float*zf76fcfe641 zd34cab886b=zd7178d015e+z71b6ccdbcf;__global float*
zf76fcfe641 z1d022fc4f3=zab76a4492b+zaf11e526b2;__global float*zf76fcfe641
z141819dd30=z9ecf4c1465+zaf11e526b2;__global float*zf76fcfe641 z45c162d8d3=
zd1931edaaa+zaf11e526b2;__global float*zf76fcfe641 z67f3ec7803=zedd19ca28d+
zaf11e526b2;
const int zc6dd35c7b8=zc180b9cdc9-zaef4813949;const int z07363baf9d=zc180b9cdc9+
zaef4813949;const int zac555974e9=zc6dd35c7b8-1;const int ze97bf8c67f=
zc6dd35c7b8+1;const int z89fdf5cb26=z07363baf9d-1;const int z774d22cd14=
z07363baf9d+1;const float zbbe9048962=z3ce0bac028[zac555974e9];const float
zbd04edcdf2=zd34cab886b[zac555974e9];const float zf0790ba3c5=z3ce0bac028[
ze97bf8c67f];const float zf660093704=zd34cab886b[ze97bf8c67f];const float
ze360d54d02=z3ce0bac028[z89fdf5cb26];const float z4c3252cf74=zd34cab886b[
z89fdf5cb26];const float z9c8040ead6=z3ce0bac028[z774d22cd14];const float
z1b3334b467=zd34cab886b[z774d22cd14];float4 z2ca2af4680=zca5c310c08(zbbe9048962,
zbd04edcdf2,zf0790ba3c5,zf660093704,ze360d54d02,z4c3252cf74,z9c8040ead6,
z1b3334b467);




float z003900f736=z2ca2af4680.s0;float z2502ed1f1b=z2ca2af4680.s1;float
zb7dace4788=z2ca2af4680.s2;float z1bb890fec3=z2ca2af4680.s3;z1d022fc4f3[
zc180b9cdc9]=z003900f736;z141819dd30[zc180b9cdc9]=z2502ed1f1b;z45c162d8d3[
zc180b9cdc9]=zb7dace4788;z67f3ec7803[zc180b9cdc9]=z1bb890fec3;const float
zbec3220266=zb7dace4788<z46a4100279?z46a4100279:zb7dace4788;const float
z0137fcc451=z1bb890fec3<z46a4100279?z46a4100279:z1bb890fec3;const float
zb525df138f=z003900f736*z003900f736;const float zfbf4cc682b=z003900f736*
z2502ed1f1b;const float zcd08a60679=z2502ed1f1b*z2502ed1f1b;const float
z32b57fa63f=zbec3220266*z0137fcc451;const float zf584145c27=zcd08a60679*
zbec3220266+zb525df138f*z0137fcc451;const float z1da53b3cf0=zb525df138f*
zbec3220266+zcd08a60679*z0137fcc451;const float z5603d7fb5b=zfbf4cc682b*(
zbec3220266-z0137fcc451);
const float z02f521c25c=zcd08a60679>=zb525df138f?zf584145c27:z1da53b3cf0;const
float zc322f2a612=(z02f521c25c/(z1da53b3cf0*zf584145c27-z5603d7fb5b*z5603d7fb5b)
)*z32b57fa63f;const float z1d663a8132=MIN(zbec3220266,zc322f2a612);z4fd5a567c8=
MAX(z1d663a8132,z4fd5a567c8);

#define zb73c59dab0 (1.f+z121e64db3b(1.1929093e-7f))*(1.f+z121e64db3b(\
1.1929093e-7f))
const float zfdf1479170=z121e64db3b(z4fd5a567c8);const float z821517f8f3=
zcd810bcd22*zfdf1479170;const int z533e0e7fd8=(int)zb990c47a0c(z821517f8f3*(2.f/
z121e64db3b(zb73c59dab0)));const int z5680c55191=MAX(2,z533e0e7fd8);int2
z9b046bc3a1=zba94ee46da+zd42d42cbea.s01;z93a08e63a7[z9b046bc3a1.x+z9b046bc3a1.y*
zd42d42cbea.s2]=(uchar)z5680c55191;}
#endif
#define z8c469bb68d(z0044d4473d) ((z0044d4473d)*(z0044d4473d)*(z0044d4473d))
#define zc94fd6c446 (0.4567966f)
__INLINE__ float2 z71c62107ab(const float za2af72823d)
{const float zff400e9e97=z121e64db3b(za2af72823d);const float z8bafd9f6b0=2.f-
zff400e9e97;const float zde305fb544=z8bafd9f6b0*z8bafd9f6b0;const float
z875364165b=(-4.f*zff400e9e97+2.f)*zde305fb544;const float zdf7ca794cf=
z8bafd9f6b0*zde305fb544;const float zbb2a25297e=(12.f*zff400e9e97+-18.f)*
za2af72823d+4.f;const float zc1046ba8ac=(-3.f*z8bafd9f6b0)*za2af72823d+4.f;const
 float za94e4e7a25=za2af72823d<4.f?z875364165b:0.f;const float zd84d7efc5a=
za2af72823d<4.f?zdf7ca794cf:0.f;const float z662a79b1a3=za2af72823d<1.f?
zbb2a25297e:za94e4e7a25;const float z872930e0c1=za2af72823d<1.f?zc1046ba8ac:
zd84d7efc5a;return(float2)(z872930e0c1,z662a79b1a3);}__INLINE__ float2
z13f4674fd0(const float z5083031dab,const float z52ab5b652a,

const float zd6d9e7658e,const float z1193a3c237,const float z8b908f69e3,const
float zb7f3da5b6d){const float z94514af1c1=z5083031dab*zd6d9e7658e+z52ab5b652a*
z1193a3c237;const float z00f5f2656d=z5083031dab*z8b908f69e3+z52ab5b652a*
zb7f3da5b6d;const float za2af72823d=z94514af1c1*z94514af1c1+z00f5f2656d*
z00f5f2656d;return z71c62107ab(za2af72823d);
}__INLINE__ float2 ze67153d947(const float z5083031dab,const float z0cfc29c876)
{const float za2af72823d=z5083031dab*z5083031dab+z0cfc29c876;return z71c62107ab(
za2af72823d);
}__INLINE__ float2 z21158c21ab(const float z5083031dab,const float z0cfc29c876,
const float ze594984af4)
{const float za2af72823d=(z5083031dab*z5083031dab+z0cfc29c876)*ze594984af4;
return z71c62107ab(za2af72823d);
}
#define z1786a3f362 z164047dc0a
#if (z3dbd1ff682 > 100)
#define ze41950934d 1
#else
#define ze41950934d 0
#endif
#if (z1786a3f362==1)
__kernel void z596e9c7f2c(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float16 ze0995e6531
,__global float*zddbf98e21d,int8 zbae6ee51b7,__global float*zd2f2d849cc,int4
z3781ffc818,
#if (ze41950934d)
float4 z331d256df1
#else
__global float*z5246f68abf,__global float*z888cc57c38,int8 z5cd6a7ca74,__global
uchar*z93a08e63a7,int4 zd42d42cbea
#endif
){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;
#if (!ze41950934d)
int2 z9b046bc3a1=zba94ee46da+zd42d42cbea.s01;uchar za1b2cb34f0=z93a08e63a7[
z9b046bc3a1.x+z9b046bc3a1.y*zd42d42cbea.s2];if(za1b2cb34f0!=2)return;
#endif
int za4829e5199=zba94ee46da.s0;int zcf71a4cbd5=zba94ee46da.s1;
const float z42cb1f4b53=ze0995e6531.s0;const float z21021b9bde=ze0995e6531.s1;
const float z574cdf3aac=ze0995e6531.s2;const float z761d6c2502=ze0995e6531.s3;
const float zf1e6224b84=ze0995e6531.s4;const float zd146110ba8=ze0995e6531.s5;
const float zcd810bcd22=ze0995e6531.s6;const float ze372c661b2=ze0995e6531.sa;
const float z13ca4801b7=ze0995e6531.sb;const float z4c80825e2d=ze0995e6531.sc;









const int zf2c75e3cd1=zbae6ee51b7.s0;const int z9cc106d220=zbae6ee51b7.s1;const
int z51ef4c4ebd=zbae6ee51b7.s2;const int za0b3cde972=zbae6ee51b7.s3;const int
z7f5f59b77c=zbae6ee51b7.s4;__global float4*zd30cb40f88=z718a062ddd+(z30eaaf69b7.
s0+za4829e5199)+(z30eaaf69b7.s1+zcf71a4cbd5)*z9562068e13;__global float*
z157aa567ef=zddbf98e21d+z9cc106d220+(z51ef4c4ebd)*zf2c75e3cd1;__global float*
z86beef2dd4=zddbf98e21d+z9cc106d220+(za0b3cde972)*zf2c75e3cd1;__global float*
z0913c7681b=zddbf98e21d+z9cc106d220+(z7f5f59b77c)*zf2c75e3cd1;const int
z677d1a3f87=zf2c75e3cd1;
const int zaef4813949=z3781ffc818.s0;


__global float*z8a40f9b480=zd2f2d849cc+z3781ffc818.s1+z3781ffc818.s2*zaef4813949
;__global float*zd7178d015e=zd2f2d849cc+z3781ffc818.s1+z3781ffc818.s3*
zaef4813949;
#if (!ze41950934d)
const int z933bff2c5a=z5cd6a7ca74.s0;

__global float*zedd19ca28d=z888cc57c38+z5cd6a7ca74.s1+z5cd6a7ca74.s5*z933bff2c5a
;const int z8c55ccd634=zcf71a4cbd5*z933bff2c5a;__global float*zf76fcfe641
z67f3ec7803=zedd19ca28d+z8c55ccd634;const float zcbaf92967b=z67f3ec7803[
za4829e5199];float zdc7eb31316=zcbaf92967b<1.f?zcbaf92967b:1.f;
#else
float zdc7eb31316=z331d256df1.s1;
#endif


const int z71b6ccdbcf=zcf71a4cbd5*zaef4813949;
__global float*zf76fcfe641 z12eec47f12=z8a40f9b480+z71b6ccdbcf;__global float*
zf76fcfe641 zd34cab886b=zd7178d015e+z71b6ccdbcf;


const float z8cfbf3788b=z21021b9bde+zd34cab886b[za4829e5199];const float
z489b9d39df=z42cb1f4b53+z12eec47f12[za4829e5199];const float z5bec6841ea=
zad9f0eecea(z8cfbf3788b,z761d6c2502);const float z5941299ad8=zad9f0eecea(
z489b9d39df,z574cdf3aac);const float zeec04eacff=z5bec6841ea-zd146110ba8;const
float z89d6e306b3=z5941299ad8-zf1e6224b84;const float z9a112927fc=z205bcb857e(
zeec04eacff);const float zbae767834f=z205bcb857e(z89d6e306b3);const int
zf696dae167=(int)z9a112927fc;const int z32fd4312e4=(int)zbae767834f;const float
zbdb4f199ce=zeec04eacff-z9a112927fc;const float z5fa3549b57=z89d6e306b3-
zbae767834f;float z73679d9508=0.f;float z44cb2f0650=0.f;float z17c5b58cf4=0.f;
float zacacf4ed08=0.f;float z447ecb5cd1=0.f;float z5d70610d3d=0.f;float
z53056fc041=0.f;float z70d336878b=0.f;float z17101d5990=0.f;float z9549b25956=
0.f;float z300b104d1f=0.f;for(int z1d8bd19892=-1;z1d8bd19892<=2;z1d8bd19892++){
const int z22b24a5adc=z677d1a3f87*(zf696dae167+(z1d8bd19892))+z32fd4312e4;
__global float*zf76fcfe641 zbe31d97d66=z157aa567ef+z22b24a5adc;__global float*
zf76fcfe641 z1a23e41359=z86beef2dd4+z22b24a5adc;__global float*zf76fcfe641
z5bc6e8b457=z0913c7681b+z22b24a5adc;const float z7d4224f715=(float)(z1d8bd19892)
;
#if (1)
const float za435aa036b=zbdb4f199ce-z7d4224f715;const float zf228130505=
za435aa036b*za435aa036b;
#else
const float zf228130505=0.f;
#endif
for(int z236fe34049=-1;z236fe34049<=2;z236fe34049++){const float ze4b052164b=
zbe31d97d66[z236fe34049];const float z2e91460297=z1a23e41359[z236fe34049];const
float z7e674d442a=z5bc6e8b457[z236fe34049];const float z1b45a402bd=(float)
z236fe34049;const float z9d966f7e11=z5fa3549b57-z1b45a402bd;float2 z49c0b18d74=
ze67153d947(z9d966f7e11,zf228130505);float z872930e0c1=z49c0b18d74.s0;float
z662a79b1a3=z49c0b18d74.s1;z53056fc041+=z662a79b1a3;z70d336878b+=z872930e0c1;
z17101d5990+=z662a79b1a3*z662a79b1a3;z9549b25956+=z872930e0c1*z662a79b1a3;
z300b104d1f+=z872930e0c1*z872930e0c1;z73679d9508+=z662a79b1a3*ze4b052164b;
z44cb2f0650+=z872930e0c1*ze4b052164b;z17c5b58cf4+=z662a79b1a3*z2e91460297;
zacacf4ed08+=z872930e0c1*z2e91460297;z447ecb5cd1+=z662a79b1a3*z7e674d442a;
z5d70610d3d+=z872930e0c1*z7e674d442a;}}const float z9b25756730=z53056fc041*
z53056fc041;const float z9cdce74d29=z53056fc041*z70d336878b;const float
zb43cdcdb88=z70d336878b*z70d336878b;const float zc6c715f5ba=z17101d5990-
z9b25756730*z4c80825e2d;const float z9413b196a2=z9549b25956-z9cdce74d29*
z4c80825e2d;const float z92b5a8073b=z300b104d1f-zb43cdcdb88*z4c80825e2d;const
float zea5fafa82b=z9413b196a2*z9413b196a2-zc6c715f5ba*z92b5a8073b;const float
zc29971f180=z121e64db3b(MAX(0.f,zea5fafa82b));const float za134538501=(
zc29971f180-z9413b196a2)/zc6c715f5ba;const float z4b00fe2b84=z13ca4801b7+
zdc7eb31316*(za134538501-z13ca4801b7);const float zd0caf32029=z4b00fe2b84*
z53056fc041+z70d336878b;const float z4d6fd48061=1.f/zd0caf32029;const float
zba0b8c7ab2=z4b00fe2b84*z73679d9508+z44cb2f0650;const float z290341d651=
z4b00fe2b84*z17c5b58cf4+zacacf4ed08;const float zad3d00bcb3=z4b00fe2b84*
z447ecb5cd1+z5d70610d3d;const float z163b246cf5=zba0b8c7ab2*z4d6fd48061;const
float z2db81e9dff=z290341d651*z4d6fd48061;const float z9bba47f2db=zad3d00bcb3*
z4d6fd48061;const float ze4b052164b=z8c469bb68d(z163b246cf5);
const float z2e91460297=z8c469bb68d(z2db81e9dff);
const float z7e674d442a=z8c469bb68d(z9bba47f2db);




zd30cb40f88[0]=(float4)(ze4b052164b,z2e91460297,z7e674d442a,0.0f);

}
#endif
#if (z1786a3f362>=2)
#if (ze41950934d)
#define zcb81a6585a ze765fb03ed
#else
#define zcb81a6585a z3800269d19
#endif
#define z3800269d19(zc7949d1067,z2961ac7796)	  \
	{ \
		const int z22b24a5adc = z677d1a3f87 * (zf696dae167+(zc7949d1067)) + \
z32fd4312e4; \
		__global float* zf76fcfe641 zbe31d97d66 = z157aa567ef + z22b24a5adc; \
		__global float* zf76fcfe641 z1a23e41359 = z86beef2dd4 + z22b24a5adc; \
		__global float* zf76fcfe641 z5bc6e8b457 = z0913c7681b + z22b24a5adc; \
		const float z7d4224f715 = (float)(zc7949d1067); \
		const float za435aa036b = zbdb4f199ce - z7d4224f715; \
		for (int z236fe34049=-(z2961ac7796); z236fe34049<=(z2961ac7796)+1; z236fe34049\
++) { \
			const float z163b246cf5 = zbe31d97d66[z236fe34049]; \
			const float z2db81e9dff = z1a23e41359[z236fe34049]; \
			const float z9bba47f2db = z5bc6e8b457[z236fe34049]; \
			const float za127db241b = z8c469bb68d( z163b246cf5 ); \
			const float z9236b3786d = z8c469bb68d( z2db81e9dff ); \
			const float z6902400148 = z8c469bb68d( z9bba47f2db ); \
			const float z1b45a402bd = (float)z236fe34049; \
			const float z9d966f7e11 = z5fa3549b57 - z1b45a402bd; \
			float2 z49c0b18d74 = z13f4674fd0(z5fa3549b57 - z1b45a402bd, zbdb4f199ce - \
z7d4224f715, ze90495e4f8, z3426d550f5, z3a830b343b, z2005388288); \
			float z872930e0c1 = z49c0b18d74.s0; \
			float z662a79b1a3 = z49c0b18d74.s1; \
			z70d336878b	 += z872930e0c1; \
			z53056fc041	 += z662a79b1a3; \
			z300b104d1f += z872930e0c1 * z872930e0c1; \
			z9549b25956 += z872930e0c1 * z662a79b1a3; \
			z17101d5990 += z662a79b1a3 * z662a79b1a3; \
			z6772c36fd5	 += z872930e0c1 * z163b246cf5; \
			z116133f400	 += z662a79b1a3 * z163b246cf5; \
			ze0bded566f	 += z872930e0c1 * z2db81e9dff; \
			zd32fea0c22	 += z662a79b1a3 * z2db81e9dff; \
			zf28a335a47	 += z872930e0c1 * z9bba47f2db; \
			z7a0972fa96	 += z662a79b1a3 * z9bba47f2db; \
			zea59dc92f4	 += z872930e0c1 * za127db241b; \
			z1463dc13f8	 += z662a79b1a3 * za127db241b; \
			z75937975b7	 += z872930e0c1 * z9236b3786d; \
			z42d761133f	 += z662a79b1a3 * z9236b3786d; \
			z13d5835fb6	 += z872930e0c1 * z6902400148; \
			z07cd3750c1	 += z662a79b1a3 * z6902400148; \
		} \
	}
#define ze765fb03ed(zc7949d1067,z2961ac7796)	  \
	{ \
		const int z22b24a5adc = z677d1a3f87 * (zf696dae167+(zc7949d1067)) + \
z32fd4312e4; \
		__global float* zf76fcfe641 zbe31d97d66 = z157aa567ef + z22b24a5adc; \
		__global float* zf76fcfe641 z1a23e41359 = z86beef2dd4 + z22b24a5adc; \
		__global float* zf76fcfe641 z5bc6e8b457 = z0913c7681b + z22b24a5adc; \
		const float z7d4224f715 = (float)(zc7949d1067); \
		const float za435aa036b = zbdb4f199ce - z7d4224f715; \
        const float zf228130505 = za435aa036b * za435aa036b; \
		for (int z236fe34049=-(z2961ac7796); z236fe34049<=(z2961ac7796)+1; z236fe34049\
++) { \
			const float z163b246cf5 = zbe31d97d66[z236fe34049]; \
			const float z2db81e9dff = z1a23e41359[z236fe34049]; \
			const float z9bba47f2db = z5bc6e8b457[z236fe34049]; \
			const float za127db241b = z8c469bb68d( z163b246cf5 ); \
			const float z9236b3786d = z8c469bb68d( z2db81e9dff ); \
			const float z6902400148 = z8c469bb68d( z9bba47f2db ); \
			const float z1b45a402bd = (float)z236fe34049; \
			const float z9d966f7e11 = z5fa3549b57 - z1b45a402bd; \
			float2 z49c0b18d74 = z21158c21ab(z9d966f7e11, zf228130505, ze594984af4); \
			float z872930e0c1 = z49c0b18d74.s0; \
			float z662a79b1a3 = z49c0b18d74.s1; \
			z70d336878b	 += z872930e0c1; \
			z53056fc041	 += z662a79b1a3; \
			z300b104d1f += z872930e0c1 * z872930e0c1; \
			z9549b25956 += z872930e0c1 * z662a79b1a3; \
			z17101d5990 += z662a79b1a3 * z662a79b1a3; \
			z6772c36fd5	 += z872930e0c1 * z163b246cf5; \
			z116133f400	 += z662a79b1a3 * z163b246cf5; \
			ze0bded566f	 += z872930e0c1 * z2db81e9dff; \
			zd32fea0c22	 += z662a79b1a3 * z2db81e9dff; \
			zf28a335a47	 += z872930e0c1 * z9bba47f2db; \
			z7a0972fa96	 += z662a79b1a3 * z9bba47f2db; \
			zea59dc92f4	 += z872930e0c1 * za127db241b; \
			z1463dc13f8	 += z662a79b1a3 * za127db241b; \
			z75937975b7	 += z872930e0c1 * z9236b3786d; \
			z42d761133f	 += z662a79b1a3 * z9236b3786d; \
			z13d5835fb6	 += z872930e0c1 * z6902400148; \
			z07cd3750c1	 += z662a79b1a3 * z6902400148; \
		} \
	}
void zdddeaa69bf(__global float4*zd30cb40f88,const float z53056fc041,const float
 z1463dc13f8,const float z42d761133f,const float z07cd3750c1,const float
z116133f400,const float zd32fea0c22,const float z7a0972fa96,const float
z70d336878b,const float zea59dc92f4,const float z75937975b7,const float
z13d5835fb6,const float z6772c36fd5,const float ze0bded566f,const float
zf28a335a47,const float z17101d5990,const float z9549b25956,const float
z300b104d1f,const float z883a66951b,const float z13ca4801b7,const float
zc2d66ce02d,const float zc0c2afa721){const float z9b25756730=z53056fc041*
z53056fc041;const float z9cdce74d29=z53056fc041*z70d336878b;const float
zb43cdcdb88=z70d336878b*z70d336878b;const float zc6c715f5ba=z9b25756730*
z883a66951b-z17101d5990;const float z9413b196a2=z9cdce74d29*z883a66951b-
z9549b25956;const float z92b5a8073b=zb43cdcdb88*z883a66951b-z300b104d1f;const
float zea5fafa82b=z9413b196a2*z9413b196a2-zc6c715f5ba*z92b5a8073b;const float
zc29971f180=z121e64db3b(MAX(0.f,zea5fafa82b));const float za134538501=
z92b5a8073b/(zc29971f180-z9413b196a2);const float z4b00fe2b84=z13ca4801b7+
zc0c2afa721*(za134538501-z13ca4801b7);const float zd0caf32029=z4b00fe2b84*
z53056fc041+z70d336878b;const float z4d6fd48061=1.f/zd0caf32029;const float
zed33ecaba6=z4b00fe2b84*z116133f400+z6772c36fd5;const float zb9094442b8=
z4b00fe2b84*zd32fea0c22+ze0bded566f;const float zcb648ee53c=z4b00fe2b84*
z7a0972fa96+zf28a335a47;const float z43fe2df110=z4b00fe2b84*z1463dc13f8+
zea59dc92f4;const float za25aa0309f=z4b00fe2b84*z42d761133f+z75937975b7;const
float z9aab342b83=z4b00fe2b84*z07cd3750c1+z13d5835fb6;const float z163b246cf5=
zed33ecaba6*z4d6fd48061;const float z2db81e9dff=zb9094442b8*z4d6fd48061;const
float z9bba47f2db=zcb648ee53c*z4d6fd48061;const float za127db241b=z43fe2df110*
z4d6fd48061;const float z9236b3786d=za25aa0309f*z4d6fd48061;const float
z6902400148=z9aab342b83*z4d6fd48061;const float z45fcf65775=z8c469bb68d(
z163b246cf5);const float zc53d2759d6=z8c469bb68d(z2db81e9dff);const float
ze16b0c8590=z8c469bb68d(z9bba47f2db);const float ze4b052164b=za127db241b+
zc2d66ce02d*(z45fcf65775-za127db241b);const float z2e91460297=z9236b3786d+
zc2d66ce02d*(zc53d2759d6-z9236b3786d);const float z7e674d442a=z6902400148+
zc2d66ce02d*(ze16b0c8590-z6902400148);


zd30cb40f88[0]=(float4)(ze4b052164b,z2e91460297,z7e674d442a,0.0f);}__kernel void
 z596e9c7f2c(__global float4*zf8d9fd6cb8,__global float4*z718a062ddd,int8
z30eaaf69b7,int z2824fcf57d,int z9562068e13,float16 ze0995e6531,__global float*
zddbf98e21d,int8 zbae6ee51b7,__global float*zd2f2d849cc,int4 z3781ffc818,
#if (ze41950934d)
float4 z331d256df1
#else
__global float*z5246f68abf,__global float*z888cc57c38,int8 z5cd6a7ca74,__global
uchar*z93a08e63a7,int4 zd42d42cbea
#endif
){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;
#if (!ze41950934d)
int2 z9b046bc3a1=zba94ee46da+zd42d42cbea.s01;uchar za1b2cb34f0=z93a08e63a7[
z9b046bc3a1.x+z9b046bc3a1.y*zd42d42cbea.s2];
#if (z1786a3f362 == 12)
if(za1b2cb34f0<z1786a3f362)return;
#else
if(za1b2cb34f0!=z1786a3f362)return;
#endif
#endif
int za4829e5199=zba94ee46da.s0;int zcf71a4cbd5=zba94ee46da.s1;
const float z42cb1f4b53=ze0995e6531.s0;const float z21021b9bde=ze0995e6531.s1;
const float z574cdf3aac=ze0995e6531.s2;const float z761d6c2502=ze0995e6531.s3;
const float zf1e6224b84=ze0995e6531.s4;const float zd146110ba8=ze0995e6531.s5;
const float zcd810bcd22=ze0995e6531.s6;const float z2f8cd4a634=ze0995e6531.s7;
const float zf7dbdf9b58=ze0995e6531.s8;const float z46a4100279=ze0995e6531.s9;
const float ze372c661b2=ze0995e6531.sa;const float z13ca4801b7=ze0995e6531.sb;
const float z4c80825e2d=ze0995e6531.sc;float zc2d66ce02d;float zdc7eb31316;float
 ze594984af4;float z883a66951b;const int zf2c75e3cd1=zbae6ee51b7.s0;const int
z9cc106d220=zbae6ee51b7.s1;const int z51ef4c4ebd=zbae6ee51b7.s2;const int
za0b3cde972=zbae6ee51b7.s3;const int z7f5f59b77c=zbae6ee51b7.s4;__global float4*
zd30cb40f88=z718a062ddd+(z30eaaf69b7.s0+za4829e5199)+(z30eaaf69b7.s1+zcf71a4cbd5
)*z9562068e13;__global float*z157aa567ef=zddbf98e21d+z9cc106d220+(z51ef4c4ebd)*
zf2c75e3cd1;__global float*z86beef2dd4=zddbf98e21d+z9cc106d220+(za0b3cde972)*
zf2c75e3cd1;__global float*z0913c7681b=zddbf98e21d+z9cc106d220+(z7f5f59b77c)*
zf2c75e3cd1;const int z677d1a3f87=zf2c75e3cd1;
const int zaef4813949=z3781ffc818.s0;


__global float*z8a40f9b480=zd2f2d849cc+z3781ffc818.s1+z3781ffc818.s2*zaef4813949
;__global float*zd7178d015e=zd2f2d849cc+z3781ffc818.s1+z3781ffc818.s3*
zaef4813949;const int z71b6ccdbcf=zcf71a4cbd5*zaef4813949;__global float*
zf76fcfe641 z12eec47f12=z8a40f9b480+z71b6ccdbcf;__global float*zf76fcfe641
zd34cab886b=zd7178d015e+z71b6ccdbcf;
#if (!ze41950934d)
const int z933bff2c5a=z5cd6a7ca74.s0;

__global float*zab76a4492b=z5246f68abf+z5cd6a7ca74.s1+z5cd6a7ca74.s2*z933bff2c5a
;__global float*z9ecf4c1465=z5246f68abf+z5cd6a7ca74.s1+z5cd6a7ca74.s3*
z933bff2c5a;__global float*zd1931edaaa=z888cc57c38+z5cd6a7ca74.s1+z5cd6a7ca74.s4
*z933bff2c5a;__global float*zedd19ca28d=z888cc57c38+z5cd6a7ca74.s1+z5cd6a7ca74.
s5*z933bff2c5a;const int z8c55ccd634=zcf71a4cbd5*z933bff2c5a;__global float*
zf76fcfe641 z1d022fc4f3=zab76a4492b+z8c55ccd634;__global float*zf76fcfe641
z141819dd30=z9ecf4c1465+z8c55ccd634;__global float*zf76fcfe641 z45c162d8d3=
zd1931edaaa+z8c55ccd634;__global float*zf76fcfe641 z67f3ec7803=zedd19ca28d+
z8c55ccd634;
#endif
const float z8cfbf3788b=z21021b9bde+zd34cab886b[za4829e5199];const float
z489b9d39df=z42cb1f4b53+z12eec47f12[za4829e5199];const float z5bec6841ea=
zad9f0eecea(z8cfbf3788b,z761d6c2502);const float z5941299ad8=zad9f0eecea(
z489b9d39df,z574cdf3aac);const float zeec04eacff=z5bec6841ea*zcd810bcd22-
zd146110ba8;const float z89d6e306b3=z5941299ad8*zcd810bcd22-zf1e6224b84;const
float z9a112927fc=z205bcb857e(zeec04eacff);const float zbae767834f=z205bcb857e(
z89d6e306b3);const int zf696dae167=(int)z9a112927fc;const int z32fd4312e4=(int)
zbae767834f;const float zbdb4f199ce=zeec04eacff-z9a112927fc;const float
z5fa3549b57=z89d6e306b3-zbae767834f;float z3426d550f5;float ze90495e4f8;float
z2005388288;float z3a830b343b;
#if (ze41950934d)

zc2d66ce02d=z331d256df1.s0;zdc7eb31316=z331d256df1.s1;ze594984af4=z331d256df1.s2
;z883a66951b=z331d256df1.s3;
#else
const float zb7dace4788=z45c162d8d3[za4829e5199];const float z1bb890fec3=
z67f3ec7803[za4829e5199];const float z2502ed1f1b=z141819dd30[za4829e5199];const
float z003900f736=z1d022fc4f3[za4829e5199];const float z1ee3516372=1.f/
z121e64db3b(zb7dace4788);const float z1040f0ce38=1.f/z121e64db3b(z1bb890fec3);
const float zfdd8db1575=zb7dace4788<z46a4100279?zcd810bcd22:z1ee3516372;const
float zc66379e6e7=z1bb890fec3<z46a4100279?zcd810bcd22:z1040f0ce38;const float
zc0c2afa721=z1bb890fec3<z46a4100279?z1bb890fec3:z46a4100279;zc2d66ce02d=
z1bb890fec3<1.f?1.f:z1040f0ce38;zdc7eb31316=zc0c2afa721*z2f8cd4a634;const float
z875636de57=z2502ed1f1b*zf7dbdf9b58;const float zcfd61c3742=z003900f736*
zf7dbdf9b58;z3426d550f5=z875636de57*zfdd8db1575;ze90495e4f8=zcfd61c3742*
zfdd8db1575;z2005388288=zcfd61c3742*zc66379e6e7;z3a830b343b=-z875636de57*
zc66379e6e7;const float z70ab7df08c=zfdd8db1575*zc66379e6e7;z883a66951b=
z70ab7df08c*ze372c661b2;
#endif
float z1463dc13f8=0.f;float zea59dc92f4=0.f;float z42d761133f=0.f;float
z75937975b7=0.f;float z07cd3750c1=0.f;float z13d5835fb6=0.f;float z116133f400=
0.f;float z6772c36fd5=0.f;float zd32fea0c22=0.f;float ze0bded566f=0.f;float
z7a0972fa96=0.f;float zf28a335a47=0.f;float z53056fc041=0.f;float z70d336878b=
0.f;float z17101d5990=0.f;float z9549b25956=0.f;float z300b104d1f=0.f;
#if (z1786a3f362 == 2)
{for(int zdbc3421475=-1;zdbc3421475<=2;zdbc3421475++)zcb81a6585a(zdbc3421475,1);
}
#endif
#if (z1786a3f362 == 3)
{for(int zdbc3421475=-2;zdbc3421475<=3;zdbc3421475++)zcb81a6585a(zdbc3421475,2);
}
#endif
#if (z1786a3f362 == 4)
{zcb81a6585a(-3,2);for(int z1d8bd19892=-2;z1d8bd19892<=3;z1d8bd19892++)
zcb81a6585a(z1d8bd19892,3);zcb81a6585a(4,2);}
#endif
#if (z1786a3f362 == 5)
{zcb81a6585a(-4,2);zcb81a6585a(-3,3);for(int z1d8bd19892=-2;z1d8bd19892<=3;
z1d8bd19892++)zcb81a6585a(z1d8bd19892,4);zcb81a6585a(4,3);zcb81a6585a(5,2);}
#endif
#if (z1786a3f362 == 6)
{zcb81a6585a(-5,3);zcb81a6585a(-4,4);for(int z1d8bd19892=-3;z1d8bd19892<=4;
z1d8bd19892++)zcb81a6585a(z1d8bd19892,5);zcb81a6585a(5,4);zcb81a6585a(6,3);}
#endif
#if (z1786a3f362 == 7)
{zcb81a6585a(-6,3);zcb81a6585a(-5,4);zcb81a6585a(-4,5);for(int z1d8bd19892=-3;
z1d8bd19892<=4;z1d8bd19892++)zcb81a6585a(z1d8bd19892,6);zcb81a6585a(5,5);
zcb81a6585a(6,4);zcb81a6585a(7,3);}
#endif
#if (z1786a3f362 == 8)
{zcb81a6585a(-7,3);zcb81a6585a(-6,5);zcb81a6585a(-5,6);zcb81a6585a(-4,6);for(int
 z1d8bd19892=-3;z1d8bd19892<=4;z1d8bd19892++)zcb81a6585a(z1d8bd19892,7);
zcb81a6585a(5,6);zcb81a6585a(6,6);zcb81a6585a(7,5);zcb81a6585a(8,3);}
#endif
#if (z1786a3f362 == 9)
{zcb81a6585a(-8,4);zcb81a6585a(-7,5);zcb81a6585a(-6,6);zcb81a6585a(-5,7);for(int
 z1d8bd19892=-4;z1d8bd19892<=5;z1d8bd19892++)zcb81a6585a(z1d8bd19892,8);
zcb81a6585a(6,7);zcb81a6585a(7,6);zcb81a6585a(8,5);zcb81a6585a(9,4);}
#endif
#if (z1786a3f362 == 10)
{zcb81a6585a(-9,4);zcb81a6585a(-8,5);zcb81a6585a(-7,7);zcb81a6585a(-6,7);
zcb81a6585a(-5,8);for(int z1d8bd19892=-4;z1d8bd19892<=5;z1d8bd19892++)
zcb81a6585a(z1d8bd19892,9);zcb81a6585a(6,8);zcb81a6585a(7,7);zcb81a6585a(8,7);
zcb81a6585a(9,5);zcb81a6585a(10,4);}
#endif
#if (z1786a3f362 == 11)
{zcb81a6585a(-10,4);zcb81a6585a(-9,6);zcb81a6585a(-8,7);zcb81a6585a(-7,8);
zcb81a6585a(-6,9);zcb81a6585a(-5,9);for(int z1d8bd19892=-4;z1d8bd19892<=5;
z1d8bd19892++)zcb81a6585a(z1d8bd19892,10);zcb81a6585a(6,9);zcb81a6585a(7,9);
zcb81a6585a(8,8);zcb81a6585a(9,7);zcb81a6585a(10,6);zcb81a6585a(11,4);}
#endif
#if (z1786a3f362 == 12)
{zcb81a6585a(-11,4);zcb81a6585a(-10,6);zcb81a6585a(-9,7);zcb81a6585a(-8,8);
zcb81a6585a(-7,9);for(int z1d8bd19892=-6;z1d8bd19892<=-5;z1d8bd19892++)
zcb81a6585a(z1d8bd19892,10);for(int z1d8bd19892=-4;z1d8bd19892<=5;z1d8bd19892++)
zcb81a6585a(z1d8bd19892,11);for(int z1d8bd19892=6;z1d8bd19892<=7;z1d8bd19892++)
zcb81a6585a(z1d8bd19892,10);zcb81a6585a(8,9);zcb81a6585a(9,8);zcb81a6585a(10,7);
zcb81a6585a(11,6);zcb81a6585a(12,4);}
#endif
#if (z1786a3f362 == 13)
{zcb81a6585a(-12,4);zcb81a6585a(-11,6);zcb81a6585a(-10,8);zcb81a6585a(-9,9);
zcb81a6585a(-8,10);zcb81a6585a(-7,10);zcb81a6585a(-6,11);zcb81a6585a(-5,11);for(
int z1d8bd19892=-4;z1d8bd19892<=5;z1d8bd19892++)zcb81a6585a(z1d8bd19892,12);
zcb81a6585a(6,11);zcb81a6585a(7,11);zcb81a6585a(8,10);zcb81a6585a(9,10);
zcb81a6585a(10,9);zcb81a6585a(11,8);zcb81a6585a(12,6);zcb81a6585a(13,4);}
#endif
#if (z1786a3f362 == 14)
{zcb81a6585a(-13,5);zcb81a6585a(-12,7);zcb81a6585a(-11,8);zcb81a6585a(-10,9);
zcb81a6585a(-9,10);zcb81a6585a(-8,11);zcb81a6585a(-7,12);zcb81a6585a(-6,12);for(
int z1d8bd19892=-5;z1d8bd19892<=6;z1d8bd19892++)zcb81a6585a(z1d8bd19892,13);
zcb81a6585a(7,12);zcb81a6585a(8,12);zcb81a6585a(9,11);zcb81a6585a(10,10);
zcb81a6585a(11,9);zcb81a6585a(12,8);zcb81a6585a(13,7);zcb81a6585a(14,5);}
#endif
#if (z1786a3f362 == 15)
{zcb81a6585a(-14,5);zcb81a6585a(-13,7);zcb81a6585a(-12,8);zcb81a6585a(-11,10);
zcb81a6585a(-10,11);zcb81a6585a(-9,11);zcb81a6585a(-8,12);zcb81a6585a(-7,13);
zcb81a6585a(-6,13);for(int z1d8bd19892=-5;z1d8bd19892<=6;z1d8bd19892++)
zcb81a6585a(z1d8bd19892,14);zcb81a6585a(7,13);zcb81a6585a(8,13);zcb81a6585a(9,12
);zcb81a6585a(10,11);zcb81a6585a(11,11);zcb81a6585a(12,10);zcb81a6585a(13,8);
zcb81a6585a(14,7);zcb81a6585a(15,5);}
#endif
#if (z1786a3f362 == 16)
{zcb81a6585a(-15,5);zcb81a6585a(-14,7);zcb81a6585a(-13,9);zcb81a6585a(-12,10);
zcb81a6585a(-11,11);zcb81a6585a(-10,12);zcb81a6585a(-9,13);zcb81a6585a(-8,13);
zcb81a6585a(-7,14);zcb81a6585a(-6,14);for(int z1d8bd19892=-5;z1d8bd19892<=6;
z1d8bd19892++)zcb81a6585a(z1d8bd19892,15);zcb81a6585a(7,14);zcb81a6585a(8,14);
zcb81a6585a(9,13);zcb81a6585a(10,13);zcb81a6585a(11,12);zcb81a6585a(12,11);
zcb81a6585a(13,10);zcb81a6585a(14,9);zcb81a6585a(15,7);zcb81a6585a(16,5);}
#endif
zdddeaa69bf(zd30cb40f88,
z53056fc041,z1463dc13f8,z42d761133f,z07cd3750c1,z116133f400,zd32fea0c22,
z7a0972fa96,z70d336878b,zea59dc92f4,z75937975b7,z13d5835fb6,z6772c36fd5,
ze0bded566f,zf28a335a47,z17101d5990,z9549b25956,z300b104d1f,z883a66951b,
z13ca4801b7,zc2d66ce02d,zdc7eb31316);}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
