#define z3dbd1ff682 1

#ifndef z3dbd1ff682
#define z3dbd1ff682 5
#endif
typedef int zdba6b93f69;typedef uint za6c557b086;
#define zcd5e728791 4
#define zec15f7fa83(zff400e9e97,z305d891f1d,za3158292ce)    ( (zff400e9e97)*\
0.299f + (z305d891f1d)*0.587f + (za3158292ce)*0.114f )
#if (z3dbd1ff682==0)
__kernel void z9ef724f834(__global float4*zf8d9fd6cb8,__global float*z718a062ddd
,int8 z30eaaf69b7,uint z021babbfad,uint z958df11031,float2 z431d666cb4){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;zba94ee46da+=z30eaaf69b7.s01;
float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad)];float
z4d67078869=zec15f7fa83(z493deefb55.x,z493deefb55.y,z493deefb55.z)+1.f;
z4d67078869=(z4d67078869>z431d666cb4.s0)?z4d67078869:z431d666cb4.s0;
z4d67078869=(z4d67078869<z431d666cb4.s1)?z4d67078869:z431d666cb4.s1;
z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031)]=z4d67078869;}
#endif
#if (z3dbd1ff682==1)
__kernel void z9ef724f834(__global float*zf8d9fd6cb8,__global float*z5413c0ac97,
int8 z30eaaf69b7,uint z021babbfad,uint z958df11031,__global float*z22dadf6692,
int8 z3c211c8179,float zcb1cc4fb2f){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.
s3)return;

int z1d0320a710=z021babbfad;int za01322c1f8=z958df11031;int za0279b8644=
z958df11031;int z70d029cd37=z3c211c8179.s0;int zf11f4d523d=z3c211c8179.s1;int
za484757648=z3c211c8179.s2;int zbec298a923=z3c211c8179.s3;int zaa4ddceb0c=
z3c211c8179.s4;int z857f3d7595=zba94ee46da.s0;int z48fe826dec=zba94ee46da.s1;
__global float*zda4322ccc1=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*z1d0320a710
;__global float*z2d31b241a9=z5413c0ac97+z30eaaf69b7.s0+z30eaaf69b7.s1*
za01322c1f8;__global float*z7c6cc08834=z22dadf6692+z30eaaf69b7.s0+z30eaaf69b7.s1
*za0279b8644;

int z48d8271f66=z48fe826dec*za01322c1f8;int z7d5b5371b1=z48fe826dec*za0279b8644;
zdba6b93f69 za3584c0652=(z48fe826dec*zcd5e728791)-(zcd5e728791/2);
int z8c90152c92=z48d8271f66+z857f3d7595;int zc25e74444c=z7d5b5371b1+z857f3d7595;

float16 zaa15324b3a=(float16)(0);float16 zef47ae1f38=(float16)(0);float*
z4be7906387=(float*)&zaa15324b3a;float*z00103b37bd=(float*)&zef47ae1f38;
zdba6b93f69 zc180b9cdc9=(z857f3d7595*zcd5e728791)-(zcd5e728791/2);zdba6b93f69 y=
za3584c0652+2;
{if(y>=0&&y<zbec298a923){__global float*zb42e1e374e=zda4322ccc1+y*z1d0320a710;
zdba6b93f69 x=zc180b9cdc9+2;
{if(x>=0&&x<za484757648){float z4d67078869=zb42e1e374e[x];z4d67078869=clamp(
z4d67078869,0.0f,15.0f);
int z97795347e2=(int)floor(z4d67078869*zcb1cc4fb2f)+zaa4ddceb0c;z97795347e2=
clamp(z97795347e2,0,10);float z562f2e87c4=z4d67078869*zcb1cc4fb2f-floor(
z4d67078869*zcb1cc4fb2f);
z00103b37bd[z97795347e2]+=(1.f-z562f2e87c4);z4be7906387[z97795347e2]+=
z4d67078869*(1.f-z562f2e87c4);z00103b37bd[z97795347e2+1]+=z562f2e87c4;
z4be7906387[z97795347e2+1]+=z4d67078869*z562f2e87c4;}}}}for(zdba6b93f69 z=0;z<12
;z++){
z2d31b241a9[z*z70d029cd37+z8c90152c92]=z4be7906387[z];
z7c6cc08834[z*zf11f4d523d+zc25e74444c]=z00103b37bd[z];}

}
#endif
#if (z3dbd1ff682==2)
__kernel void z9ef724f834(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,uint z021babbfad,uint z958df11031,int zb69fd7a1b9){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;

int zaeb9783789=z021babbfad;int zaef4813949=z958df11031;__global float*
z6d1e7e5295=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*zaeb9783789;__global float
*z5b71b59642=z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.s1*zaef4813949;int x=
zba94ee46da.s0;int y=zba94ee46da.s1;
int z6725567d80=y*zaeb9783789;float ze6ee5ad5cd;z6725567d80+=x;
ze6ee5ad5cd=0.0544887f*z6d1e7e5295[(-2)*zb69fd7a1b9+z6725567d80];ze6ee5ad5cd+=
0.2442020f*z6d1e7e5295[(-1)*zb69fd7a1b9+z6725567d80];ze6ee5ad5cd+=0.4026200f*
z6d1e7e5295[(0)*zb69fd7a1b9+z6725567d80];ze6ee5ad5cd+=0.2442020f*z6d1e7e5295[(1)
*zb69fd7a1b9+z6725567d80];ze6ee5ad5cd+=0.0544887f*z6d1e7e5295[(2)*zb69fd7a1b9+
z6725567d80];z5b71b59642[x+y*zaef4813949]=ze6ee5ad5cd;



}
#endif
#if (z3dbd1ff682==3)
__kernel void z9ef724f834(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,uint z021babbfad,uint z958df11031,__global float*z358ba919f0,
int4 zc34e9a4fe0,float4 z71f48900a0){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>z30eaaf69b7.s2||zba94ee46da.y>z30eaaf69b7.s3)
return;int z1d0320a710=z021babbfad;int za4f316aa52=z958df11031;__global float*
zda4322ccc1=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*z1d0320a710;__global float
*z8d9b56ddd4=z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.s1*za4f316aa52;int x=
zba94ee46da.s0;int y=zba94ee46da.s1;
float zcc124a3325=z71f48900a0.s0;float zcb1cc4fb2f=z71f48900a0.s1;float
zaa4ddceb0c=z71f48900a0.s2;
int za01322c1f8=zc34e9a4fe0.s2;int z70d029cd37=zc34e9a4fe0.s3;__global float*
z2d31b241a9=z358ba919f0+zc34e9a4fe0.s0+zc34e9a4fe0.s1*za01322c1f8;

__global float*z7f3194e771=z8d9b56ddd4+y*za4f316aa52;__global float*zffc5ca53fa=
zda4322ccc1+y*z1d0320a710;
float z42a5c91ed9=convert_float(y)*zcc124a3325;int z04337ebea9=y/zcd5e728791;
int z0bfe7eaf74=z04337ebea9+1;
int zba1eb71a28=z04337ebea9*za01322c1f8;int z5b977d5c23=z0bfe7eaf74*za01322c1f8;
float z69626cf441,z514ce0ce01;int z6a957fe2f1,zd95e72d374,zea2c30a4b7,
zeace4d4062;z69626cf441=convert_float(x)*zcc124a3325;z6a957fe2f1=x/zcd5e728791;
zd95e72d374=z6a957fe2f1+1;
float z6cf4aac658=zffc5ca53fa[x];z514ce0ce01=z6cf4aac658*(zcb1cc4fb2f)+
zaa4ddceb0c;zea2c30a4b7=convert_int(floor(z514ce0ce01));zea2c30a4b7=clamp(
zea2c30a4b7,0,10);zeace4d4062=zea2c30a4b7+1;float z648af8356b,z7afaa48361,
zd62711b375,zcbfc8e3590;z648af8356b=z7afaa48361=convert_float(zd95e72d374)-
z69626cf441;zcbfc8e3590=zd62711b375=z69626cf441-convert_float(z6a957fe2f1);
z648af8356b*=(convert_float(z0bfe7eaf74)-z42a5c91ed9);zd62711b375*=(
convert_float(z0bfe7eaf74)-z42a5c91ed9);z7afaa48361*=(z42a5c91ed9-convert_float(
z04337ebea9));zcbfc8e3590*=(z42a5c91ed9-convert_float(z04337ebea9));
#if 1

float z4a8e5a4934=0.f,z39df10196f=0.f;z39df10196f+=z2d31b241a9[zea2c30a4b7*
z70d029cd37+z6a957fe2f1+zba1eb71a28]*z648af8356b;z39df10196f+=z2d31b241a9[
zea2c30a4b7*z70d029cd37+z6a957fe2f1+z5b977d5c23]*z7afaa48361;z39df10196f+=
z2d31b241a9[zea2c30a4b7*z70d029cd37+zd95e72d374+zba1eb71a28]*zd62711b375;
z39df10196f+=z2d31b241a9[zea2c30a4b7*z70d029cd37+zd95e72d374+z5b977d5c23]*
zcbfc8e3590;z39df10196f*=(zeace4d4062-z514ce0ce01);z4a8e5a4934+=z2d31b241a9[
zeace4d4062*z70d029cd37+z6a957fe2f1+zba1eb71a28]*z648af8356b;z4a8e5a4934+=
z2d31b241a9[zeace4d4062*z70d029cd37+z6a957fe2f1+z5b977d5c23]*z7afaa48361;
z4a8e5a4934+=z2d31b241a9[zeace4d4062*z70d029cd37+zd95e72d374+zba1eb71a28]*
zd62711b375;z4a8e5a4934+=z2d31b241a9[zeace4d4062*z70d029cd37+zd95e72d374+
z5b977d5c23]*zcbfc8e3590;z4a8e5a4934*=(z514ce0ce01-zea2c30a4b7);float
z96a2929ccd=z4a8e5a4934+z39df10196f;
#else
float z96a2929ccd=0.5f;
#endif

z7f3194e771[x]=z96a2929ccd;

}
#endif
#if (z3dbd1ff682==4)
__kernel void z9ef724f834(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,uint z021babbfad,uint z958df11031,float16 z7c54807ee5){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>
z30eaaf69b7.s2||zba94ee46da.y>z30eaaf69b7.s3)return;int z1d0320a710=z021babbfad;
int za4f316aa52=z958df11031;__global float*z8d9b56ddd4=zf8d9fd6cb8+z30eaaf69b7.
s4+z30eaaf69b7.s5*z1d0320a710;__global float*z48c3ca1667=z718a062ddd+z30eaaf69b7
.s0+z30eaaf69b7.s1*za4f316aa52;int x=zba94ee46da.s0;int y=zba94ee46da.s1;const
float zebdffbfa04=z7c54807ee5.s0;const float z9c5f143fe0=z7c54807ee5.s1;const
float z9ffe223c45=z7c54807ee5.s2;const float z56e0d1296f=z7c54807ee5.s3;const
float z9a65daabdd=z7c54807ee5.s4;const float z9c75c72c21=z7c54807ee5.s5;const
float z68bdfec722=z7c54807ee5.s6;const float zd9b65df469=z7c54807ee5.s7;const
float z55d046342f=z7c54807ee5.s8;const float zc180b9cdc9=z7c54807ee5.s9;const
float za7b4aa39db=z7c54807ee5.sa;









__global float*z7f3194e771=&z8d9b56ddd4[y*za4f316aa52];__global float*
z6e49ab47a2=&z48c3ca1667[y*z1d0320a710];
float z99e3d023d3=z7f3194e771[x];
if(z99e3d023d3>zc180b9cdc9){
float z65ec87f65d=(z99e3d023d3-zc180b9cdc9)/(1.f+(z99e3d023d3-zc180b9cdc9)*(1.f/
zebdffbfa04)*z9c5f143fe0);z99e3d023d3=(z99e3d023d3-zc180b9cdc9)/(1.f+(
z99e3d023d3-zc180b9cdc9)*(1.f/zebdffbfa04)*z9ffe223c45);float z86dd029962=exp((
z65ec87f65d-z99e3d023d3)*za7b4aa39db);z6e49ab47a2[x]=z86dd029962;}else{
float z65ec87f65d=-(zc180b9cdc9-z99e3d023d3)/(1.f+(zc180b9cdc9-z99e3d023d3)*(1.f
/z56e0d1296f)*z9a65daabdd);z99e3d023d3=-(zc180b9cdc9-z99e3d023d3)/(1.f+(
zc180b9cdc9-z99e3d023d3)*(1.f/z56e0d1296f)*z9c75c72c21);float z90374fbe92=(
z65ec87f65d-z99e3d023d3);
if(z68bdfec722>zd9b65df469){z99e3d023d3=z7f3194e771[x]+z90374fbe92;z65ec87f65d=-
(zc180b9cdc9-z99e3d023d3)/(1.f+(zc180b9cdc9-z99e3d023d3)*(1.f/z56e0d1296f)*
z55d046342f);z99e3d023d3=-(zc180b9cdc9-z99e3d023d3)/(1.f+(zc180b9cdc9-
z99e3d023d3)*(1.f/z56e0d1296f)*z9c75c72c21);z90374fbe92+=(z65ec87f65d-
z99e3d023d3);}float z86dd029962=exp(z90374fbe92*za7b4aa39db);z6e49ab47a2[x]=
z86dd029962;}

}
#endif
#if (z3dbd1ff682==5)
__kernel void z9ef724f834(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,uint z021babbfad,uint z958df11031,__global float*
z50aea30d42,int4 zaeceab5193){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>z30eaaf69b7.s2||zba94ee46da.y>z30eaaf69b7.s3)
return;__global float4*zba15fb8bb8=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*
z021babbfad;__global float4*zddaa6f652d=z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.
s1*z958df11031;int x=zba94ee46da.s0;int y=zba94ee46da.s1;

int z87880d8ae7=zaeceab5193.s2;__global float*zcf73dcee57=z50aea30d42+
zaeceab5193.s0+zaeceab5193.s1*z87880d8ae7;

__global float4*z395b96baac=&zba15fb8bb8[y*z021babbfad];__global float4*
ze4351005bc=&zddaa6f652d[y*z958df11031];__global float*zc57132e640=&zcf73dcee57[
y*z87880d8ae7];
float z86dd029962=zc57132e640[x];




ze4351005bc[x]=z395b96baac[x]*z86dd029962;}
#endif
#if (z3dbd1ff682==6 || z3dbd1ff682==7)
__kernel void z9ef724f834(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,uint z2824fcf57d,uint z9562068e13){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;const float z908a899bab=0.49972358f;const float
z842f1c9b69=0.25013819f;
#if (z3dbd1ff682==6)
const int zd72c7cd02e=1;
#else
const int zd72c7cd02e=z2824fcf57d;
#endif
__global float*zba15fb8bb8=zf8d9fd6cb8+z30eaaf69b7.s4+zba94ee46da.x+(z30eaaf69b7
.s5+zba94ee46da.y)*z2824fcf57d;__global float*zddaa6f652d=z718a062ddd+
z30eaaf69b7.s0+zba94ee46da.x+(z30eaaf69b7.s1+zba94ee46da.y)*z9562068e13;float
z51eadf1cec=z908a899bab*zba15fb8bb8[0];z51eadf1cec+=z842f1c9b69*(zba15fb8bb8[-
zd72c7cd02e]+zba15fb8bb8[zd72c7cd02e]);zddaa6f652d[0]=z51eadf1cec;}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
