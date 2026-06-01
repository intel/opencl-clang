#define z3dbd1ff682 11

#ifndef z3dbd1ff682
#define z3dbd1ff682 10
#endif
typedef ushort z51b7908a0d;typedef uint za6c557b086;
#define MAX max
#define MIN min
#define z43136ee60e(z2dd09f3226,za3158292ce)							\
				do {								\
					z51b7908a0d zc52664cd38 = (z2dd09f3226);			\
					z51b7908a0d z1874fc64eb = (za3158292ce);			\
					z51b7908a0d zafd0702979 = zc52664cd38;			\
					z51b7908a0d z0d5263203e = zc52664cd38;			\
					if (zc52664cd38 < z1874fc64eb) z0d5263203e = z1874fc64eb;		\
					if (zc52664cd38 > z1874fc64eb) zafd0702979 = z1874fc64eb;		\
					z2dd09f3226 = zafd0702979;					\
					za3158292ce = z0d5263203e;					\
				} while(0)
inline z51b7908a0d z21338c67a8(z51b7908a0d*z493deefb55){z43136ee60e(z493deefb55[
0],z493deefb55[1]);z43136ee60e(z493deefb55[3],z493deefb55[4]);z43136ee60e(
z493deefb55[0],z493deefb55[3]);z43136ee60e(z493deefb55[1],z493deefb55[4]);
z43136ee60e(z493deefb55[1],z493deefb55[2]);z43136ee60e(z493deefb55[2],
z493deefb55[3]);z43136ee60e(z493deefb55[1],z493deefb55[2]);return(z493deefb55[2]
);}int zba6aaab12d(float4 z8c716e52d2,int z1d8bd19892){

int z4633c865c6=convert_int(sqrt(z8c716e52d2.x+z8c716e52d2.y*convert_float(
z1d8bd19892*256)));return z4633c865c6;}
#if (z3dbd1ff682==0 || z3dbd1ff682==2 || z3dbd1ff682==3 || z3dbd1ff682==4 || \
z3dbd1ff682==5 || z3dbd1ff682==11)
#define za3052e06bb , uint4 zfb81b1b9ea
#endif
#if (z3dbd1ff682==1)
#define za3052e06bb , float4 z8c716e52d2
#endif
#if (z3dbd1ff682==6 || z3dbd1ff682==7 || z3dbd1ff682==10)
#define za3052e06bb , __global ushort* zf259c820fa, uint4 zfb81b1b9ea
#endif
#if (z3dbd1ff682==8 || z3dbd1ff682==9 || z3dbd1ff682 == 13)
#define za3052e06bb , uint4 zfb81b1b9ea, float4 z8c716e52d2
#endif
#if (z3dbd1ff682==12)
#define za3052e06bb , uint4 z7c54807ee5, __global ushort* zef5c0838c9, uint4 \
za5c0e06566,  __global ushort* za094d838aa, uint4 zc13e46b8b7,  __global ushort*\
 z84c52984ba, uint4 z50c7af9a55, uint4 zd221a2c87e
#endif
#if (z3dbd1ff682==14)
#define za3052e06bb , uint8 z7c54807ee5, __global ushort* ze8c3195457, uint4 \
z8e0918e682, __global ushort* za094d838aa, uint4 zc13e46b8b7
#endif
__kernel void za144fb1bc0(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,uint ze265e77baa,uint z9daa334467 za3052e06bb){int2
 z945895b462=(int2)(get_global_id(0),get_global_id(1));if(z945895b462.x>
z30eaaf69b7.s2||z945895b462.y>z30eaaf69b7.s3)return;int2 z83640e5796=(int2)(0,
z945895b462.y)+(int2)z30eaaf69b7.s45;int2 zaaf414d14e=(int2)(0,z945895b462.y)+(
int2)z30eaaf69b7.s01;__global ushort*z395b96baac=zf8d9fd6cb8+(z83640e5796.x+
z83640e5796.y*(ze265e77baa));__global ushort*ze4351005bc=z718a062ddd+(
zaaf414d14e.x+zaaf414d14e.y*(z9daa334467));const int x=z945895b462.x;const int
z45c01651ac=ze265e77baa;
#if (z3dbd1ff682==0)
const uint zea34483265=zfb81b1b9ea.x;const uint z38c36eec91=zfb81b1b9ea.y;
z51b7908a0d zd095913c8a=z395b96baac[x-1-z45c01651ac];z51b7908a0d zdf516a31d2=
z395b96baac[x-z45c01651ac];z51b7908a0d ze6239aa706=z395b96baac[x+1-z45c01651ac];
z51b7908a0d z472a64058d=z395b96baac[x-1];z51b7908a0d zcbdd216f8c=z395b96baac[x];
z51b7908a0d zc174ada40c=z395b96baac[x+1];z51b7908a0d z0326239fd0=z395b96baac[x-1
+z45c01651ac];z51b7908a0d z03f0788244=z395b96baac[x+z45c01651ac];z51b7908a0d
z1dbcfc5d62=z395b96baac[x+1+z45c01651ac];
z51b7908a0d zd8e18175c0=MAX(zd095913c8a,zdf516a31d2);z51b7908a0d z39f117b1fe=MIN
(zd095913c8a,zdf516a31d2);zd8e18175c0=MAX(zd8e18175c0,ze6239aa706);z39f117b1fe=
MIN(z39f117b1fe,ze6239aa706);zd8e18175c0=MAX(zd8e18175c0,z472a64058d);
z39f117b1fe=MIN(z39f117b1fe,z472a64058d);zd8e18175c0=MAX(zd8e18175c0,zc174ada40c
);z39f117b1fe=MIN(z39f117b1fe,zc174ada40c);zd8e18175c0=MAX(zd8e18175c0,
z0326239fd0);z39f117b1fe=MIN(z39f117b1fe,z0326239fd0);zd8e18175c0=MAX(
zd8e18175c0,z03f0788244);z39f117b1fe=MIN(z39f117b1fe,z03f0788244);zd8e18175c0=
MAX(zd8e18175c0,z1dbcfc5d62);z39f117b1fe=MIN(z39f117b1fe,z1dbcfc5d62);
z51b7908a0d ze405977494=MIN(MAX(z39f117b1fe,zcbdd216f8c),zd8e18175c0);int
z0f1493ae07=MIN(((int)zcbdd216f8c-(int)ze405977494)/8,ze405977494/8);
if(zcbdd216f8c*z38c36eec91<ze405977494*zea34483265||zcbdd216f8c*zea34483265>
ze405977494*z38c36eec91)ze405977494=(int)ze405977494+z0f1493ae07;else
ze405977494=zcbdd216f8c;ze4351005bc[x]=ze405977494;
#endif

#if (z3dbd1ff682==1)


z51b7908a0d zd095913c8a=z395b96baac[x-1-z45c01651ac];z51b7908a0d zdf516a31d2=
z395b96baac[x-z45c01651ac];z51b7908a0d ze6239aa706=z395b96baac[x+1-z45c01651ac];
z51b7908a0d z472a64058d=z395b96baac[x-1];z51b7908a0d zcbdd216f8c=z395b96baac[x];
z51b7908a0d zc174ada40c=z395b96baac[x+1];z51b7908a0d z0326239fd0=z395b96baac[x-1
+z45c01651ac];z51b7908a0d z03f0788244=z395b96baac[x+z45c01651ac];z51b7908a0d
z1dbcfc5d62=z395b96baac[x+1+z45c01651ac];
z51b7908a0d zd8e18175c0=MAX(zd095913c8a,zdf516a31d2);z51b7908a0d z39f117b1fe=MIN
(zd095913c8a,zdf516a31d2);zd8e18175c0=MAX(zd8e18175c0,ze6239aa706);z39f117b1fe=
MIN(z39f117b1fe,ze6239aa706);zd8e18175c0=MAX(zd8e18175c0,z472a64058d);
z39f117b1fe=MIN(z39f117b1fe,z472a64058d);zd8e18175c0=MAX(zd8e18175c0,zc174ada40c
);z39f117b1fe=MIN(z39f117b1fe,zc174ada40c);zd8e18175c0=MAX(zd8e18175c0,
z0326239fd0);z39f117b1fe=MIN(z39f117b1fe,z0326239fd0);zd8e18175c0=MAX(
zd8e18175c0,z03f0788244);z39f117b1fe=MIN(z39f117b1fe,z03f0788244);zd8e18175c0=
MAX(zd8e18175c0,z1dbcfc5d62);z39f117b1fe=MIN(z39f117b1fe,z1dbcfc5d62);
z51b7908a0d ze405977494=MIN(MAX(z39f117b1fe,zcbdd216f8c),zd8e18175c0);int
z758719f481=zba6aaab12d(z8c716e52d2,convert_int(ze405977494)/256);int
z02702dd463=(int)z39f117b1fe-z758719f481;int z5cc5ab02f7=(int)zd8e18175c0+
z758719f481;
int z7c7d2fc602=MIN(MAX(convert_int(zcbdd216f8c),z02702dd463),z5cc5ab02f7);
ze4351005bc[x]=convert_ushort(z7c7d2fc602);
#endif

#if (z3dbd1ff682==2)
z395b96baac=zf8d9fd6cb8+(z30eaaf69b7.s4+z30eaaf69b7.s5*(ze265e77baa));
ze4351005bc=z718a062ddd+(z30eaaf69b7.s0+z30eaaf69b7.s1*(z9daa334467));const int
y=z945895b462.y;
const int z0ffc526c28=z9daa334467;const int zbab0071853=z9daa334467;const int
z4a4c8f07e6=z9daa334467;const int zf4a6c2b4b7=z9daa334467;
__global ushort*za9eb19d2b7=z718a062ddd+z30eaaf69b7.s0+zfb81b1b9ea.x*zbab0071853
;__global ushort*z9292b4041d=z718a062ddd+z30eaaf69b7.s0+zfb81b1b9ea.y*
z4a4c8f07e6;__global ushort*zc08b80f59d=ze4351005bc;__global ushort*zd1c7a0cd10=
z718a062ddd+z30eaaf69b7.s0+zfb81b1b9ea.z*zf4a6c2b4b7;
zc08b80f59d[x+y*z0ffc526c28]=z395b96baac[(x+z45c01651ac*y)*2+0];za9eb19d2b7[x+y*
zbab0071853]=z395b96baac[(x+z45c01651ac*y)*2+1];z9292b4041d[x+y*z4a4c8f07e6]=
z395b96baac[(x+z45c01651ac*y)*2+z45c01651ac];zd1c7a0cd10[x+y*zf4a6c2b4b7]=
z395b96baac[(x+z45c01651ac*y)*2+z45c01651ac+1];
#endif

#if (z3dbd1ff682==3)
z395b96baac=zf8d9fd6cb8+(z30eaaf69b7.s4+z30eaaf69b7.s5*(ze265e77baa));
ze4351005bc=z718a062ddd+(z30eaaf69b7.s0+z30eaaf69b7.s1*(z9daa334467));const int
y=z945895b462.y;
const int z0ffc526c28=z9daa334467;const int zbab0071853=z9daa334467;const int
z4a4c8f07e6=z9daa334467;const int zf4a6c2b4b7=z9daa334467;
__global ushort*za9eb19d2b7=z718a062ddd+z30eaaf69b7.s0+zfb81b1b9ea.x*zbab0071853
;__global ushort*z9292b4041d=z718a062ddd+z30eaaf69b7.s0+zfb81b1b9ea.y*
z4a4c8f07e6;__global ushort*zc08b80f59d=ze4351005bc;__global ushort*zd1c7a0cd10=
z718a062ddd+z30eaaf69b7.s0+zfb81b1b9ea.z*zf4a6c2b4b7;z395b96baac[2*(x+y*
z45c01651ac)]=zc08b80f59d[x+y*z0ffc526c28];z395b96baac[2*(x+y*z45c01651ac)+1]=
za9eb19d2b7[x+y*zbab0071853];z395b96baac[2*(x+y*z45c01651ac)+z45c01651ac]=
z9292b4041d[x+y*z4a4c8f07e6];z395b96baac[2*(x+y*z45c01651ac)+z45c01651ac+1]=
zd1c7a0cd10[x+y*zf4a6c2b4b7];
#endif



#if (z3dbd1ff682==4)
__global ushort*z9292b4041d=zf8d9fd6cb8+(zfb81b1b9ea.x+(z945895b462.y+
zfb81b1b9ea.y)*(ze265e77baa));__global ushort*za9eb19d2b7=z395b96baac;__global
ushort*z93d0f05404=ze4351005bc;z93d0f05404[x]=MAX(za9eb19d2b7[x],z9292b4041d[x])
;
#endif



#if (z3dbd1ff682==5)
__global ushort*z9292b4041d=zf8d9fd6cb8+(zfb81b1b9ea.x+(z945895b462.y+
zfb81b1b9ea.y)*(ze265e77baa));__global ushort*za9eb19d2b7=z395b96baac;__global
ushort*z93d0f05404=ze4351005bc;z93d0f05404[x]=MIN(za9eb19d2b7[x],z9292b4041d[x])
;
#endif



#if (z3dbd1ff682 == 6)
int2 z454a20b335=(int2)(0,z945895b462.y)+convert_int2(zfb81b1b9ea.xy);__global
ushort*z12c9d780d7=zf259c820fa+(z454a20b335.x+z454a20b335.y*zfb81b1b9ea.z);const
 z51b7908a0d za6fed374b1=65535/2;
if(z395b96baac[x]<z12c9d780d7[x]){
ze4351005bc[x]=z395b96baac[x];}else if(z395b96baac[x]>za6fed374b1){

z51b7908a0d z75caa5a034;z75caa5a034=MAX(z395b96baac[x-1-z45c01651ac],z395b96baac
[x-z45c01651ac]);z75caa5a034=MAX(z75caa5a034,z395b96baac[x+1-z45c01651ac]);
z75caa5a034=MAX(z75caa5a034,z395b96baac[x-1]);z75caa5a034=MAX(z75caa5a034,
z395b96baac[x+1]);z75caa5a034=MAX(z75caa5a034,z395b96baac[x-1+z45c01651ac]);
z75caa5a034=MAX(z75caa5a034,z395b96baac[x+z45c01651ac]);z75caa5a034=MAX(
z75caa5a034,z395b96baac[x+1+z45c01651ac]);ze4351005bc[x]=z75caa5a034;}else{
ze4351005bc[x]=MAX(z395b96baac[x-z45c01651ac],z395b96baac[x+1]);}
#endif



#if (z3dbd1ff682 == 7)
int2 z454a20b335=(int2)(0,z945895b462.y)+convert_int2(zfb81b1b9ea.xy);__global
ushort*z12c9d780d7=zf259c820fa+(z454a20b335.x+z454a20b335.y*zfb81b1b9ea.z);
if(z395b96baac[x]<=z12c9d780d7[x])ze4351005bc[x]=MAX(z395b96baac[x-z45c01651ac],
z395b96baac[x+1]);else ze4351005bc[x]=z395b96baac[x];
#endif






#if (z3dbd1ff682 == 8)
__global ushort*z12c9d780d7=ze4351005bc;const uint zea34483265=zfb81b1b9ea.x;
const uint z38c36eec91=zfb81b1b9ea.y;bool z474e0df53b=zfb81b1b9ea.z!=0;if(
z474e0df53b){
if(z395b96baac[x]*zea34483265>z12c9d780d7[x]*z38c36eec91){z395b96baac[x]=MIN(
convert_ushort(z12c9d780d7[x]+zba6aaab12d(z8c716e52d2,z12c9d780d7[x]/256)),
z395b96baac[x]);}}else{
if(z395b96baac[x]*zea34483265>z12c9d780d7[x]*z38c36eec91){z395b96baac[x]=
z12c9d780d7[x]+MIN(convert_ushort(z395b96baac[x]-z12c9d780d7[x]),z12c9d780d7[x])
/8;}}
#endif
#if (z3dbd1ff682 == 9)
__global ushort*z12c9d780d7=ze4351005bc;const int zea34483265=convert_int(
zfb81b1b9ea.x);const int z38c36eec91=convert_int(zfb81b1b9ea.y);bool z474e0df53b
=zfb81b1b9ea.z!=0;int z244efa2f9e=convert_int(z395b96baac[x]);int z90df530851=
convert_int(z12c9d780d7[x]);if(z474e0df53b){
if(z244efa2f9e*z38c36eec91<z90df530851*zea34483265){
z395b96baac[x]=convert_ushort(MAX(z90df530851-zba6aaab12d(z8c716e52d2,
z90df530851/256),z244efa2f9e));}}else{
if(z244efa2f9e*z38c36eec91<z90df530851*zea34483265){z395b96baac[x]=
convert_ushort(z90df530851-(z90df530851-z244efa2f9e)/8);}}
#endif




#if (z3dbd1ff682 == 10)
int zc46cab0dde=zfb81b1b9ea.z;int2 z454a20b335=(int2)(0,z945895b462.y)+
convert_int2(zfb81b1b9ea.xy);__global ushort*z12c9d780d7=zf259c820fa+(
z454a20b335.x+z454a20b335.y*zc46cab0dde);
if(z395b96baac[x]>=z12c9d780d7[x]){z51b7908a0d z67f31e3266=z395b96baac[x];
z51b7908a0d z82f1ab7d6b=0;z51b7908a0d z9a37790081=0;for(int za3584c0652=-1;
za3584c0652<=1;za3584c0652++){for(int zc180b9cdc9=-1;zc180b9cdc9<=1;zc180b9cdc9
++){bool zc69c0751fe=(z395b96baac[x+zc180b9cdc9+za3584c0652*z45c01651ac]>=
z67f31e3266);z82f1ab7d6b+=(zc69c0751fe?1:0);bool z93a08e63a7=(!zc69c0751fe)||(
z82f1ab7d6b>2);

z9a37790081=z93a08e63a7?MAX(z9a37790081,z395b96baac[x+zc180b9cdc9+za3584c0652*
z45c01651ac]):z9a37790081;}}ze4351005bc[x]=z9a37790081;}else ze4351005bc[x]=
z395b96baac[x];
#endif
#if (z3dbd1ff682 == 11)
__global ushort*zd128a2a95a=z395b96baac;__global ushort*z45925d5e78=ze4351005bc;
const ushort zd72c7cd02e=(ushort)zfb81b1b9ea.x;const ushort za82003f7cf=(ushort)
zfb81b1b9ea.y;if(zd72c7cd02e<=1)z45925d5e78[x]=zd128a2a95a[x];else if(
za82003f7cf!=5)z45925d5e78[x]=(zd128a2a95a[x]*(za6c557b086)1024)/MAX(z45925d5e78
[x],zd72c7cd02e);else z45925d5e78[x]=((zd128a2a95a[x]+zd72c7cd02e)*(za6c557b086)
1024)/(z45925d5e78[x]+zd72c7cd02e);
#endif
#if (z3dbd1ff682 == 12)
const int y=z945895b462.y;

const uint z5b8c31c8e4=zd221a2c87e.x;const uint zf60b01e068=zd221a2c87e.y;const
uint zcc07561cc9=zd221a2c87e.z;
z395b96baac=zf8d9fd6cb8+(z30eaaf69b7.s4+z30eaaf69b7.s5*z45c01651ac);z395b96baac
+=2*x+y*z45c01651ac*2;__global ushort*zd128a2a95a=z395b96baac;
__global ushort*zc08b80f59d=ze4351005bc+x;__global ushort*za9eb19d2b7=
z718a062ddd+z30eaaf69b7.s0+x+(z7c54807ee5.x+y)*z9daa334467;__global ushort*
z9292b4041d=z718a062ddd+z30eaaf69b7.s0+x+(z7c54807ee5.y+y)*z9daa334467;__global
ushort*zd1c7a0cd10=z718a062ddd+z30eaaf69b7.s0+x+(z7c54807ee5.z+y)*z9daa334467;
__global ushort*z93d0f05404=z718a062ddd+z30eaaf69b7.s0+x+(z7c54807ee5.w+y)*
z9daa334467;
__global ushort*z4121c3b36f=zef5c0838c9+z30eaaf69b7.s0+x+(za5c0e06566.x+y)*
za5c0e06566.w;__global ushort*z47d9dcfc3f=zef5c0838c9+z30eaaf69b7.s0+x+(
za5c0e06566.y+y)*za5c0e06566.w;__global ushort*z1a7b681120=zef5c0838c9+
z30eaaf69b7.s0+x+(za5c0e06566.z+y)*za5c0e06566.w;
__global ushort*za858c09078=za094d838aa+z30eaaf69b7.s0+x+(zc13e46b8b7.x+y)*
zc13e46b8b7.w;__global ushort*zc4d762a86d=za094d838aa+z30eaaf69b7.s0+x+(
zc13e46b8b7.y+y)*zc13e46b8b7.w;__global ushort*zf5b9022273=za094d838aa+
z30eaaf69b7.s0+x+(zc13e46b8b7.z+y)*zc13e46b8b7.w;
__global ushort*zad2a2fb936=z84c52984ba+z30eaaf69b7.s0+x+(z50c7af9a55.x+y)*
z50c7af9a55.w;__global ushort*z10f3064f5e=z84c52984ba+z30eaaf69b7.s0+x+(
z50c7af9a55.y+y)*z50c7af9a55.w;__global ushort*zcd8688255a=z84c52984ba+
z30eaaf69b7.s0+x+(z50c7af9a55.z+y)*z50c7af9a55.w;int z2580cb545f=(za858c09078[0]
>zf5b9022273[0])?MAX(za858c09078[0],zc4d762a86d[0]):MAX(zf5b9022273[0],
zc4d762a86d[0]);int z45e3075ad3=z5b8c31c8e4*z2580cb545f+zcc07561cc9;int
z85f943e4c6=z2580cb545f+zcc07561cc9;if(zad2a2fb936[0]*z85f943e4c6>z45e3075ad3*
MAX(zcd8688255a[0],z10f3064f5e[0])){if(zc08b80f59d[0]>(za858c09078[0]/2)&&(
za858c09078[0]/2)>z4121c3b36f[0]&&zc08b80f59d[0]>(zc4d762a86d[0]+zf5b9022273[0])
*zf60b01e068){z51b7908a0d z8b313e1809=MIN(z93d0f05404[0],zd1c7a0cd10[0]);
z8b313e1809=MAX(zc4d762a86d[0],zf5b9022273[0]);
z395b96baac[0]=z8b313e1809;}}else if(z10f3064f5e[0]*z85f943e4c6>z45e3075ad3*MAX(
zad2a2fb936[0],zcd8688255a[0])){
if(za9eb19d2b7[0]>(zc4d762a86d[0]/2)&&(zc4d762a86d[0]/2)>z47d9dcfc3f[0]&&
za9eb19d2b7[0]>(za858c09078[0]+zf5b9022273[0])*zf60b01e068){z51b7908a0d
z8b313e1809=MIN(zc08b80f59d[0],zd1c7a0cd10[0]);z8b313e1809=MAX(za858c09078[0],
zf5b9022273[0]);
z395b96baac[1]=z8b313e1809;}
if(z9292b4041d[0]>(zc4d762a86d[0]/2)&&(zc4d762a86d[0]/2)>z47d9dcfc3f[0]&&
z9292b4041d[0]>(za858c09078[0]+zf5b9022273[0])*zf60b01e068){z51b7908a0d
z8b313e1809=MIN(zc08b80f59d[0],zd1c7a0cd10[0]);z8b313e1809=MAX(za858c09078[0],
zf5b9022273[0]);
z395b96baac[z45c01651ac]=z8b313e1809;}}else if(zcd8688255a[0]*z85f943e4c6>
z45e3075ad3*MAX(zad2a2fb936[0],z10f3064f5e[0])){if(zd1c7a0cd10[0]>(zf5b9022273[0
]/2)&&(zf5b9022273[0]/2)>z1a7b681120[0]&&zd1c7a0cd10[0]>(zc4d762a86d[0]+
za858c09078[0])*zf60b01e068){z51b7908a0d z8b313e1809=MIN(zc08b80f59d[0],
z93d0f05404[0]);z8b313e1809=MAX(za858c09078[0],zc4d762a86d[0]);
z395b96baac[z45c01651ac+1]=z8b313e1809;}}
#endif
#if  (z3dbd1ff682 == 13)

const uint z1cd5a9c537=zfb81b1b9ea.x;const int zeb414bf071=zfb81b1b9ea.y;const
int z89a0b6b08b=zfb81b1b9ea.z;const int z6e34086862=zfb81b1b9ea.w;
__global ushort*z4ec3cdd8de=z395b96baac+x;int ze93c1c2b84=convert_int(
z4ec3cdd8de[0]);
int z906ca65729=zba6aaab12d(z8c716e52d2,(ze93c1c2b84)/256);z906ca65729*=3;
z51b7908a0d z0fbc86da55=convert_ushort((ze93c1c2b84*z89a0b6b08b)/1024+
z906ca65729);z51b7908a0d z919a3a2527=convert_ushort((ze93c1c2b84*z6e34086862)/
1024-z906ca65729);uint zf71a2be2d9=0;z51b7908a0d z98c5ff8b51=65535;
z51b7908a0d z75caa5a034=0;
for(int za3584c0652=-zeb414bf071;za3584c0652<=zeb414bf071;za3584c0652++){for(int
 zc180b9cdc9=-zeb414bf071;zc180b9cdc9<=zeb414bf071;zc180b9cdc9++){z51b7908a0d
zaa528dde47=z4ec3cdd8de[zc180b9cdc9+za3584c0652*z45c01651ac];if(zaa528dde47>
z919a3a2527&&zaa528dde47<z0fbc86da55){zf71a2be2d9++;}else{z98c5ff8b51=MIN(
z98c5ff8b51,zaa528dde47);z75caa5a034=MAX(z75caa5a034,zaa528dde47);}}if(
zf71a2be2d9>z1cd5a9c537)break;}z51b7908a0d z544ba87ecd=convert_ushort(
ze93c1c2b84);
if(zf71a2be2d9<=z1cd5a9c537){
if(z544ba87ecd>z75caa5a034){z51b7908a0d z1c57214747[5]={z4ec3cdd8de[-z45c01651ac
],z4ec3cdd8de[-1],z4ec3cdd8de[0],z4ec3cdd8de[1],z4ec3cdd8de[z45c01651ac]};
z51b7908a0d zd2c8734740[5]={z4ec3cdd8de[-z45c01651ac-1],z4ec3cdd8de[-z45c01651ac
+1],z4ec3cdd8de[0],z4ec3cdd8de[z45c01651ac-1],z4ec3cdd8de[z45c01651ac+1]};
z544ba87ecd=MIN(z21338c67a8(z1c57214747),z21338c67a8(zd2c8734740));}else if(
z544ba87ecd<z98c5ff8b51){z51b7908a0d z1c57214747[5]={z4ec3cdd8de[-z45c01651ac],
z4ec3cdd8de[-1],z4ec3cdd8de[0],z4ec3cdd8de[1],z4ec3cdd8de[z45c01651ac]};
z51b7908a0d zd2c8734740[5]={z4ec3cdd8de[-z45c01651ac-1],z4ec3cdd8de[-z45c01651ac
+1],z4ec3cdd8de[0],z4ec3cdd8de[z45c01651ac-1],z4ec3cdd8de[z45c01651ac+1]};
z544ba87ecd=MAX(z21338c67a8(z1c57214747),z21338c67a8(zd2c8734740));}}

ze4351005bc[x]=z544ba87ecd;
#endif
#if  (z3dbd1ff682 == 14)
const int y=z945895b462.y;uint zfb3c18405c=z7c54807ee5.s0;uint z3e8cd15f3c=
z7c54807ee5.s1;uint z984bdf7c9c=z7c54807ee5.s2;uint zf5970556d7=z7c54807ee5.s3;
uint zf24c02a99a=z7c54807ee5.s4;const uint z12cbbf15c0=65535;__global ushort*
z57f6961530=za094d838aa+z30eaaf69b7.s0+x+(zc13e46b8b7.x+y)*zc13e46b8b7.z;
__global ushort*z2687853585=za094d838aa+z30eaaf69b7.s0+x+(zc13e46b8b7.y+y)*
zc13e46b8b7.z;__global ushort*zb711881d11=ze8c3195457+z30eaaf69b7.s0+x+(
z8e0918e682.x+y)*z8e0918e682.z;__global ushort*za17d1a8f35=ze8c3195457+
z30eaaf69b7.s0+x+(z8e0918e682.y+y)*z8e0918e682.z;
z395b96baac=zf8d9fd6cb8+(z30eaaf69b7.s4+z30eaaf69b7.s5*z45c01651ac)+zf24c02a99a;
z395b96baac+=2*x+y*z45c01651ac*2;__global ushort*z9a9f4b7f55=ze4351005bc;
z51b7908a0d z215cdeceb9=z395b96baac[x*2];z51b7908a0d z6181f17c28=z9a9f4b7f55[x];
if(z6181f17c28<z215cdeceb9){z51b7908a0d z8c79cf87fe=MIN((z57f6961530[x]*
zfb3c18405c)/1024,z12cbbf15c0);z51b7908a0d z72d41bcab4=MIN((z2687853585[x]*
z3e8cd15f3c)/1024,z12cbbf15c0);if(z215cdeceb9*zf5970556d7>(z8c79cf87fe+
z72d41bcab4)*z984bdf7c9c)z395b96baac[x*2]=MAX(z6181f17c28,MAX(z8c79cf87fe,
z72d41bcab4));}else if(z6181f17c28>z215cdeceb9){z51b7908a0d z8e1db83364=(
zb711881d11[x]<za17d1a8f35[x])?MIN((zb711881d11[x]*zfb3c18405c)/1024,z12cbbf15c0
):MIN((za17d1a8f35[x]*z3e8cd15f3c)/1024,z12cbbf15c0);if(z215cdeceb9*2<
z8e1db83364)z395b96baac[x*2]=MIN(z6181f17c28,z8e1db83364);}
#endif
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
