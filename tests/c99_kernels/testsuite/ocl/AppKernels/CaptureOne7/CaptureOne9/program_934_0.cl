#define z3dbd1ff682 6

#ifndef z3dbd1ff682
#define z3dbd1ff682 14
#endif
#define zff1f756ad9(z2dd09f3226,za3158292ce) { float z99e2655378=(z2dd09f3226);(\
z2dd09f3226)=(za3158292ce);(za3158292ce)=z99e2655378; }
#define z6891786495(z2dd09f3226,za3158292ce) { if ((z2dd09f3226)>(za3158292ce)) \
zff1f756ad9((z2dd09f3226),(za3158292ce)); }
inline float z3eb04b929e(float8 z493deefb55){z6891786495(z493deefb55.s0,
z493deefb55.s1);z6891786495(z493deefb55.s3,z493deefb55.s4);z6891786495(
z493deefb55.s0,z493deefb55.s3);z6891786495(z493deefb55.s1,z493deefb55.s4);
z6891786495(z493deefb55.s1,z493deefb55.s2);z6891786495(z493deefb55.s2,
z493deefb55.s3);z6891786495(z493deefb55.s1,z493deefb55.s2);return(z493deefb55.s2
);}
#define zec15f7fa83(zff400e9e97,z305d891f1d,za3158292ce)    ( (zff400e9e97)*\
0.299f + (z305d891f1d)*0.587f + (za3158292ce)*0.114f )
#define MAX max
#define MIN min














#if (z3dbd1ff682==0 )
__kernel void ze7ed3fd93d(__global float4*zf8d9fd6cb8,__global float*z718a062ddd
,int8 z30eaaf69b7,int z45c01651ac,int zb41a4b7008){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;float4 z493deefb55=zf8d9fd6cb8[
z83640e5796.x+z83640e5796.y*(z45c01651ac)];float z5413c0ac97=zec15f7fa83(
z493deefb55.x,z493deefb55.y,z493deefb55.z);z718a062ddd[zaaf414d14e.x+zaaf414d14e
.y*(zb41a4b7008)]=MAX(z5413c0ac97,1.f);}
#endif
#if (z3dbd1ff682==1 )
__kernel void ze7ed3fd93d(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int z45c01651ac,int zb41a4b7008){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int z3bd1cc3b01=z83640e5796.x+
z83640e5796.y*(z45c01651ac);float z2d351c5ace=zf8d9fd6cb8[z3bd1cc3b01-1];float
z3931fc4ce8=zf8d9fd6cb8[z3bd1cc3b01];float z963ba64275=zf8d9fd6cb8[z3bd1cc3b01+1
];z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*(zb41a4b7008)]=min(z2d351c5ace,min(
z3931fc4ce8,z963ba64275));}
#endif
#if (z3dbd1ff682==2 )
__kernel void ze7ed3fd93d(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int z45c01651ac,int zb41a4b7008){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int z3bd1cc3b01=z83640e5796.x+
z83640e5796.y*(z45c01651ac);float z2d351c5ace=zf8d9fd6cb8[z3bd1cc3b01-
z45c01651ac];float z3931fc4ce8=zf8d9fd6cb8[z3bd1cc3b01];float z963ba64275=
zf8d9fd6cb8[z3bd1cc3b01+z45c01651ac];z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*(
zb41a4b7008)]=min(z2d351c5ace,min(z3931fc4ce8,z963ba64275));}
#endif
#if (z3dbd1ff682==3 )
__kernel void ze7ed3fd93d(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int z45c01651ac,int zb41a4b7008){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int z3bd1cc3b01=z83640e5796.x+
z83640e5796.y*(z45c01651ac);float z2d351c5ace=zf8d9fd6cb8[z3bd1cc3b01-1];float
z3931fc4ce8=zf8d9fd6cb8[z3bd1cc3b01];float z963ba64275=zf8d9fd6cb8[z3bd1cc3b01+1
];z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*(zb41a4b7008)]=max(z2d351c5ace,max(
z3931fc4ce8,z963ba64275));}
#endif
#if (z3dbd1ff682==4 )
__kernel void ze7ed3fd93d(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int z45c01651ac,int zb41a4b7008){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int z3bd1cc3b01=z83640e5796.x+
z83640e5796.y*(z45c01651ac);float z2d351c5ace=zf8d9fd6cb8[z3bd1cc3b01-
z45c01651ac];float z3931fc4ce8=zf8d9fd6cb8[z3bd1cc3b01];float z963ba64275=
zf8d9fd6cb8[z3bd1cc3b01+z45c01651ac];z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*(
zb41a4b7008)]=max(z2d351c5ace,max(z3931fc4ce8,z963ba64275));}
#endif
#if (z3dbd1ff682==5 )
__kernel void ze7ed3fd93d(__global float*zba15fb8bb8,__global float*zddaa6f652d,
int8 z30eaaf69b7,int z45c01651ac,int zb41a4b7008,__global float*zf259c820fa,int4
 z3ed97a150f){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7
.s01;int2 z454a20b335=zba94ee46da+z3ed97a150f.s01;



__global float*z395b96baac=zba15fb8bb8+z83640e5796.x+z83640e5796.y*z45c01651ac;
__global float*ze4351005bc=zddaa6f652d+zaaf414d14e.x+zaaf414d14e.y*zb41a4b7008;;
__global float*z12c9d780d7=zf259c820fa+z454a20b335.x+z454a20b335.y*z3ed97a150f.
s2;

if(z395b96baac[0]>=z12c9d780d7[0])ze4351005bc[0]=MAX(z395b96baac[-1],z395b96baac
[z45c01651ac]);else ze4351005bc[0]=z395b96baac[0];




}
#endif
#if (z3dbd1ff682==6 )
__kernel void ze7ed3fd93d(__global float*zba15fb8bb8,__global float*zddaa6f652d,
int8 z30eaaf69b7,int z45c01651ac,int zb41a4b7008,__global float*zf259c820fa,int4
 z3ed97a150f){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7
.s01;int2 z454a20b335=zba94ee46da+z3ed97a150f.s01;



__global float*z395b96baac=zba15fb8bb8+z83640e5796.x+z83640e5796.y*z45c01651ac;
__global float*ze4351005bc=zddaa6f652d+zaaf414d14e.x+zaaf414d14e.y*zb41a4b7008;;
__global float*z12c9d780d7=zf259c820fa+z454a20b335.x+z454a20b335.y*z3ed97a150f.
s2;

if(z395b96baac[0]<=z12c9d780d7[0])ze4351005bc[0]=MIN(z395b96baac[-1],z395b96baac
[z45c01651ac]);else ze4351005bc[0]=z395b96baac[0];




}
#endif
#if (z3dbd1ff682==7 )
__kernel void ze7ed3fd93d(__global float*zba15fb8bb8,__global float*zddaa6f652d,
int8 z30eaaf69b7,int z45c01651ac,int zb41a4b7008,float4 zfb81b1b9ea){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;float
z63cd9b76fa=zfb81b1b9ea.s0;float z283dbdacb6=zfb81b1b9ea.s1;float z6cc6f061a0=
zfb81b1b9ea.s2;


__global float*z395b96baac=zba15fb8bb8+z83640e5796.x+z83640e5796.y*z45c01651ac;
__global float*z12c9d780d7=zddaa6f652d+zaaf414d14e.x+zaaf414d14e.y*zb41a4b7008;;

if(z395b96baac[0]>=z12c9d780d7[0]*z6cc6f061a0){z395b96baac[0]=z395b96baac[0]*
z63cd9b76fa+z12c9d780d7[0]*z283dbdacb6;}



}
#endif
#if (z3dbd1ff682==8 )
__kernel void ze7ed3fd93d(__global float*zba15fb8bb8,__global float*zddaa6f652d,
int8 z30eaaf69b7,int z45c01651ac,int zb41a4b7008,float4 zfb81b1b9ea){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;float
z63cd9b76fa=zfb81b1b9ea.s0;float z283dbdacb6=zfb81b1b9ea.s1;float z6cc6f061a0=
zfb81b1b9ea.s2;


__global float*z395b96baac=zba15fb8bb8+z83640e5796.x+z83640e5796.y*z45c01651ac;
__global float*z12c9d780d7=zddaa6f652d+zaaf414d14e.x+zaaf414d14e.y*zb41a4b7008;;

if(z395b96baac[0]*z6cc6f061a0<=z12c9d780d7[0]){
z395b96baac[0]=z395b96baac[0]*z63cd9b76fa+z12c9d780d7[0]*z283dbdacb6;}



}
#endif
#if (z3dbd1ff682==9 )
__kernel void ze7ed3fd93d(__global float4*zba15fb8bb8,__global float4*
zddaa6f652d,int8 z30eaaf69b7,int z45c01651ac,int zb41a4b7008,__global float*
z9a076bc279,int4 z0cda232ab2){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.
s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=
zba94ee46da+z30eaaf69b7.s01;int2 zdc2396006d=zba94ee46da+z0cda232ab2.s01;



__global float4*z395b96baac=zba15fb8bb8+z83640e5796.x+z83640e5796.y*z45c01651ac;
__global float4*ze4351005bc=zddaa6f652d+zaaf414d14e.x+zaaf414d14e.y*zb41a4b7008;
__global float*z2416fbcc28=z9a076bc279+zdc2396006d.x+zdc2396006d.y*z0cda232ab2.
s2;
float z99e3d023d3=z2416fbcc28[0];


float4 z74152a2373=z395b96baac[0];float z7e68956b16=zec15f7fa83(z74152a2373.x,
z74152a2373.y,z74152a2373.z);
z7e68956b16=MAX(z7e68956b16,1.f);float4 zc097b3a911;if(z99e3d023d3<z7e68956b16*
1.5f){float z86dd029962=z99e3d023d3/z7e68956b16;


zc097b3a911=z74152a2373*z86dd029962;}else{float z3a2fa68d0e=(z99e3d023d3-
z7e68956b16*1.5f);


zc097b3a911=z74152a2373*1.5f+(float4)(z3a2fa68d0e);}ze4351005bc[0]=zc097b3a911;

}
#endif
#if (z3dbd1ff682==10 )
__kernel void ze7ed3fd93d(__global float*zba15fb8bb8,__global float*zddaa6f652d,
int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int z6d21f948f8){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;
__global float*z395b96baac=zba15fb8bb8+4*z83640e5796.x+z83640e5796.y*(
z2824fcf57d*4)+z6d21f948f8;__global float*ze4351005bc=zddaa6f652d+zaaf414d14e.x+
zaaf414d14e.y*z9562068e13;ze4351005bc[0]=z395b96baac[0];}
#endif
#if (z3dbd1ff682==11 || z3dbd1ff682==14 )
#if (z3dbd1ff682==14)
#define z34484eef75 float4
#else
#define z34484eef75 float
#endif
__kernel void ze7ed3fd93d(__global z34484eef75*zba15fb8bb8,__global z34484eef75*
zddaa6f652d,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float16 z17d4425141
){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;float16
 z1940a8ef21=z17d4425141;int z45c01651ac=z2824fcf57d;int zb41a4b7008=z9562068e13
;__global z34484eef75*z395b96baac=zba15fb8bb8+z83640e5796.x+z83640e5796.y*
z45c01651ac;__global z34484eef75*ze4351005bc=zddaa6f652d+zaaf414d14e.x+
zaaf414d14e.y*zb41a4b7008;z34484eef75 z6181f17c28;z6181f17c28=z395b96baac[-1-
z45c01651ac]*(z34484eef75)z1940a8ef21.s0+z395b96baac[-z45c01651ac]*(z34484eef75)
z1940a8ef21.s1+z395b96baac[1-z45c01651ac]*(z34484eef75)z1940a8ef21.s2+
z395b96baac[-1]*(z34484eef75)z1940a8ef21.s3+z395b96baac[0]*(z34484eef75)
z1940a8ef21.s4+z395b96baac[1]*(z34484eef75)z1940a8ef21.s5+z395b96baac[-1+
z45c01651ac]*(z34484eef75)z1940a8ef21.s6+z395b96baac[z45c01651ac]*(z34484eef75)
z1940a8ef21.s7+z395b96baac[1+z45c01651ac]*(z34484eef75)z1940a8ef21.s8;
ze4351005bc[0]=z6181f17c28;
}
#endif
#if (z3dbd1ff682==12 )
__kernel void ze7ed3fd93d(__global float*zba15fb8bb8,__global float*zddaa6f652d,
int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,__global float*zbe4695287b,int4
 z4516a315bc,float16 z17d4425141){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.
s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=
zba94ee46da+z30eaaf69b7.s01;int2 z86f8f77612=zba94ee46da+z4516a315bc.s01;float16
 z1940a8ef21=z17d4425141;float z7c95d32f3a=z17d4425141.s9;int za9922537b1=
z4516a315bc.s3;int z45c01651ac=z2824fcf57d*4;int zb41a4b7008=z9562068e13*4;
__global float*z395b96baac=zba15fb8bb8+4*z83640e5796.x+z83640e5796.y*z45c01651ac
+za9922537b1;__global float*ze4351005bc=zddaa6f652d+4*zaaf414d14e.x+zaaf414d14e.
y*zb41a4b7008+za9922537b1;__global float*z3749b906a5=zbe4695287b+z86f8f77612.x+
z86f8f77612.y*z4516a315bc.s2;



int x=0;{float z6181f17c28=z3749b906a5[x];
__global float*z4ec3cdd8de=&z395b96baac[x*4];
z6181f17c28=z6181f17c28+z4ec3cdd8de[-4-z45c01651ac]*(-z1940a8ef21.s0)+
z4ec3cdd8de[-z45c01651ac]*(-z1940a8ef21.s1)+z4ec3cdd8de[4-z45c01651ac]*(-
z1940a8ef21.s2)+z4ec3cdd8de[-4]*(-z1940a8ef21.s3)+z4ec3cdd8de[4]*(-z1940a8ef21.
s5)+z4ec3cdd8de[-4+z45c01651ac]*(-z1940a8ef21.s6)+z4ec3cdd8de[z45c01651ac]*(-
z1940a8ef21.s7)+z4ec3cdd8de[4+z45c01651ac]*(-z1940a8ef21.s8);z6181f17c28*=(1.f/
z1940a8ef21.s4);
if(z6181f17c28>z4ec3cdd8de[0]){z6181f17c28=MAX(z4ec3cdd8de[0],z6181f17c28-(
z7c95d32f3a*0.5f));}else if(z6181f17c28<z4ec3cdd8de[0]){z6181f17c28=MIN(
z4ec3cdd8de[0],z6181f17c28+(z7c95d32f3a*0.5f));}ze4351005bc[4*x]=z6181f17c28;}}
#endif
#if (z3dbd1ff682==13 )
__kernel void ze7ed3fd93d(__global float*z4b4c7876db,__global float*z7e7947e8ff,
int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float4 z17d4425141,const int
step){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.
x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;
float z63cd9b76fa=z17d4425141.x;float z283dbdacb6=z17d4425141.y;float
z6cc6f061a0=z17d4425141.z;int z45c01651ac=z2824fcf57d*step;int zb41a4b7008=
z9562068e13*step;__global float*z395b96baac=z4b4c7876db+z83640e5796.x*step+
z83640e5796.y*z45c01651ac;__global float*ze4351005bc=z7e7947e8ff+zaaf414d14e.x*
step+zaaf414d14e.y*zb41a4b7008;const int y=0;for(int x=0;x<step;x++){
float zd095913c8a=z395b96baac[x-step-z45c01651ac];float zdf516a31d2=z395b96baac[
x-z45c01651ac];float ze6239aa706=z395b96baac[x+step-z45c01651ac];float
z472a64058d=z395b96baac[x-step];float zcbdd216f8c=z395b96baac[x];float
zc174ada40c=z395b96baac[x+step];float z0326239fd0=z395b96baac[x-step+z45c01651ac
];float z03f0788244=z395b96baac[x+z45c01651ac];float z1dbcfc5d62=z395b96baac[x+
step+z45c01651ac];
float zd8e18175c0=MAX(zd095913c8a,zdf516a31d2);float z39f117b1fe=MIN(zd095913c8a
,zdf516a31d2);zd8e18175c0=MAX(zd8e18175c0,ze6239aa706);z39f117b1fe=MIN(
z39f117b1fe,ze6239aa706);zd8e18175c0=MAX(zd8e18175c0,z472a64058d);z39f117b1fe=
MIN(z39f117b1fe,z472a64058d);zd8e18175c0=MAX(zd8e18175c0,zc174ada40c);
z39f117b1fe=MIN(z39f117b1fe,zc174ada40c);zd8e18175c0=MAX(zd8e18175c0,z0326239fd0
);z39f117b1fe=MIN(z39f117b1fe,z0326239fd0);zd8e18175c0=MAX(zd8e18175c0,
z03f0788244);z39f117b1fe=MIN(z39f117b1fe,z03f0788244);zd8e18175c0=MAX(
zd8e18175c0,z1dbcfc5d62);z39f117b1fe=MIN(z39f117b1fe,z1dbcfc5d62);
float zb92ef29b4b=MIN(MAX(z39f117b1fe,zcbdd216f8c),zd8e18175c0);
if(zcbdd216f8c>=zd8e18175c0*z6cc6f061a0||zcbdd216f8c*z6cc6f061a0<=z39f117b1fe)
zb92ef29b4b=zcbdd216f8c*z63cd9b76fa+zb92ef29b4b*z283dbdacb6;else zb92ef29b4b=
zcbdd216f8c;ze4351005bc[x]=zb92ef29b4b;}}
#endif
#if (z3dbd1ff682==15 )
__kernel void ze7ed3fd93d(__global float4*zba15fb8bb8,__global float4*
zddaa6f652d,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,__global float4*
z82e11e6cde,int4 z55cd7b7566,float2 z17d4425141){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int2 z7401af1f13=zba94ee46da+z55cd7b7566
.s01;float4 z36c5f1fc7b=(float4)z17d4425141.s0;float4 z11ffdd8969=(float4)
z17d4425141.s1;int z45c01651ac=z2824fcf57d;int zb41a4b7008=z9562068e13;__global
float4*z395b96baac=zba15fb8bb8+z83640e5796.x+z83640e5796.y*z45c01651ac;__global
float4*ze4351005bc=zddaa6f652d+zaaf414d14e.x+zaaf414d14e.y*zb41a4b7008;__global
float4*zf1cf7d51e7=z82e11e6cde+z7401af1f13.x+z7401af1f13.y*z55cd7b7566.s2;const
int x=0;{
{float4 z6181f17c28=(zf1cf7d51e7[x]+ze4351005bc[x])*z36c5f1fc7b;float4
zf6aaf1ce37=z395b96baac[x];
float4 zf33d9bb9c3=z6181f17c28-z11ffdd8969;float4 ze39d3fb59f=z6181f17c28+
z11ffdd8969;zf33d9bb9c3=MAX(zf33d9bb9c3,zf6aaf1ce37);ze39d3fb59f=MIN(ze39d3fb59f
,zf6aaf1ce37);
zf6aaf1ce37.x=(z6181f17c28.x>zf6aaf1ce37.x)?zf33d9bb9c3.x:ze39d3fb59f.x;
zf6aaf1ce37.y=(z6181f17c28.y>zf6aaf1ce37.y)?zf33d9bb9c3.y:ze39d3fb59f.y;
zf6aaf1ce37.z=(z6181f17c28.z>zf6aaf1ce37.z)?zf33d9bb9c3.z:ze39d3fb59f.z;
ze4351005bc[x]=zf6aaf1ce37;}}}
#endif
#if (z3dbd1ff682==16 )
__kernel void ze7ed3fd93d(__global float*z4b4c7876db,__global float*z7e7947e8ff,
int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float8 z17d4425141){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;
float z6b0d0c1ef9=z17d4425141.s0;float z7c95d32f3a=z17d4425141.s1;float
z5eacb1dcf1=z17d4425141.s2;float z7243ea85a8=z17d4425141.s3;float z6cc6f061a0=
z17d4425141.s4;float z74cb8a4bdd=z17d4425141.s5;const int step=4;int z45c01651ac
=z2824fcf57d*step;int zb41a4b7008=z9562068e13*step;__global float*z395b96baac=
z4b4c7876db+z83640e5796.x*step+z83640e5796.y*z45c01651ac;__global float*
ze4351005bc=z7e7947e8ff+zaaf414d14e.x*step+zaaf414d14e.y*zb41a4b7008;for(int x=0
;x<3;x++){
float8 z63b0e5289e=(float8)(z395b96baac[x-z45c01651ac],z395b96baac[x-step],
z395b96baac[x],z395b96baac[x+step],z395b96baac[x+z45c01651ac],0,0,0);float
z988b6b7451=z3eb04b929e(z63b0e5289e);
if(fabs(z988b6b7451-z395b96baac[x])<z988b6b7451*0.5f+z7243ea85a8){ze4351005bc[x]
=z395b96baac[x];continue;}
float8 z7d3f2d5059=(float8)(z395b96baac[x-step-z45c01651ac],z395b96baac[x+step-
z45c01651ac],z395b96baac[x],z395b96baac[x-step+z45c01651ac],z395b96baac[x+step+
z45c01651ac],0,0,0);float zf348940d5e=z3eb04b929e(z7d3f2d5059);
float z9238df27c4=(fabs(z988b6b7451-z395b96baac[x])<fabs(zf348940d5e-z395b96baac
[x]))?z988b6b7451:zf348940d5e;
float z906ca65729=(z9238df27c4>0.f)?sqrt(z5eacb1dcf1+z6b0d0c1ef9*z9238df27c4):
z7c95d32f3a;float z96a2929ccd=z395b96baac[x];
if(z9238df27c4>(z395b96baac[x]+z906ca65729)*z6cc6f061a0)z96a2929ccd=MAX(
z395b96baac[x],z9238df27c4-(z906ca65729*0.5f)*(1.f+z74cb8a4bdd));else if(
z9238df27c4<(z395b96baac[x]-z906ca65729)*z6cc6f061a0)z96a2929ccd=MIN(z395b96baac
[x],z9238df27c4+(z906ca65729*0.5f)*(1.f+z74cb8a4bdd));ze4351005bc[x]=z96a2929ccd
;}ze4351005bc[3]=z395b96baac[3];}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
