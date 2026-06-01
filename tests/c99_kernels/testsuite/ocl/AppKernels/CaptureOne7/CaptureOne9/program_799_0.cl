#define z3dbd1ff682 5
#define z93a6893130 16

#ifndef z3dbd1ff682
#define z3dbd1ff682 2
#endif
#define z9050d7d057(zff400e9e97,z305d891f1d,za3158292ce)    ( (zff400e9e97)*\
0.299f + (z305d891f1d)*0.587f + (za3158292ce)*0.114f )
#if (z3dbd1ff682==0)
__kernel void za248650b6b(__global float4*zf8d9fd6cb8,__global float*z718a062ddd
,int8 z30eaaf69b7,int z021babbfad,int z958df11031,float zd72c7cd02e){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;zba94ee46da+=z30eaaf69b7.s01;
float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad)];float
z5413c0ac97=z9050d7d057(z493deefb55.x,z493deefb55.y,z493deefb55.z)+zd72c7cd02e;
z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031)]=z5413c0ac97;}
#endif
#if (z3dbd1ff682==1)
__kernel void za248650b6b(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int z021babbfad,int z958df11031,float8 z3c211c8179,float4
z0a1dda9ae0){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=zba94ee46da+z30eaaf69b7.s45;zba94ee46da+=z30eaaf69b7.s01;const float
 zaf4cd759d5=z0a1dda9ae0.s0;const float z5eacb1dcf1=z0a1dda9ae0.s1;const float
z9f2409475e=z0a1dda9ae0.s2;const float z6eb931d3c7=z3c211c8179.s0;const float
zc10d38c99c=z3c211c8179.s1;const float zea34483265=z3c211c8179.s2;const float
z38c36eec91=z3c211c8179.s3;const float z9620af80c4=z3c211c8179.s4;const float
z6d1149f124=z3c211c8179.s5;const float z0b500db18c=z3c211c8179.s6;__global float
*z24a89f7513=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*(z021babbfad);__global
float*ze4351005bc=z718a062ddd+zba94ee46da.x+zba94ee46da.y*(z958df11031);int
zaeb9783789=z021babbfad;






float z7e68956b16=z24a89f7513[0];

float z19731b763d[5];float z4a1516272a[5];float z33592e8600[5];float z3b40ecc762
[5];for(int z1d8bd19892=-2;z1d8bd19892<=2;z1d8bd19892++){z19731b763d[z1d8bd19892
+2]=z24a89f7513[z1d8bd19892];z4a1516272a[z1d8bd19892+2]=z24a89f7513[zaeb9783789*
z1d8bd19892];z33592e8600[z1d8bd19892+2]=z24a89f7513[(1+zaeb9783789)*z1d8bd19892]
;z3b40ecc762[z1d8bd19892+2]=z24a89f7513[(1-zaeb9783789)*z1d8bd19892];}
float z77c830e1b7=z19731b763d[0]*z38c36eec91+z19731b763d[1]*zea34483265+
z19731b763d[2]*zc10d38c99c+z19731b763d[3]*zea34483265+z19731b763d[4]*z38c36eec91
;float z000f6d59de=z4a1516272a[0]*z38c36eec91+z4a1516272a[1]*zea34483265+
z4a1516272a[2]*zc10d38c99c+z4a1516272a[3]*zea34483265+z4a1516272a[4]*z38c36eec91
;float z508d1e06ee=z33592e8600[0]*z0b500db18c+z33592e8600[1]*z6d1149f124+
z33592e8600[2]*z9620af80c4+z33592e8600[3]*z6d1149f124+z33592e8600[4]*z0b500db18c
;float zea7bf504e4=z3b40ecc762[0]*z0b500db18c+z3b40ecc762[1]*z6d1149f124+
z3b40ecc762[2]*z9620af80c4+z3b40ecc762[3]*z6d1149f124+z3b40ecc762[4]*z0b500db18c
;float z657e1a72e9;float zde289c21d6;float zad455ed369;float zf021daf0b7;
for(int z1d8bd19892=0;z1d8bd19892<5;z1d8bd19892++){z19731b763d[z1d8bd19892]-=
z77c830e1b7;z4a1516272a[z1d8bd19892]-=z000f6d59de;z33592e8600[z1d8bd19892]-=
z508d1e06ee;z3b40ecc762[z1d8bd19892]-=zea7bf504e4;}
z657e1a72e9=z19731b763d[2]*z19731b763d[2]*zc10d38c99c+(z19731b763d[1]*
z19731b763d[1]+z19731b763d[3]*z19731b763d[3])*zea34483265+(z19731b763d[0]*
z19731b763d[0]+z19731b763d[4]*z19731b763d[4])*z38c36eec91;zde289c21d6=
z4a1516272a[2]*z4a1516272a[2]*zc10d38c99c+(z4a1516272a[1]*z4a1516272a[1]+
z4a1516272a[3]*z4a1516272a[3])*zea34483265+(z4a1516272a[0]*z4a1516272a[0]+
z4a1516272a[4]*z4a1516272a[4])*z38c36eec91;zad455ed369=z33592e8600[2]*
z33592e8600[2]*z9620af80c4+(z33592e8600[1]*z33592e8600[1]+z33592e8600[3]*
z33592e8600[3])*z6d1149f124+(z33592e8600[0]*z33592e8600[0]+z33592e8600[4]*
z33592e8600[4])*z0b500db18c;zf021daf0b7=z3b40ecc762[2]*z3b40ecc762[2]*
z9620af80c4+(z3b40ecc762[1]*z3b40ecc762[1]+z3b40ecc762[3]*z3b40ecc762[3])*
z6d1149f124+(z3b40ecc762[0]*z3b40ecc762[0]+z3b40ecc762[4]*z3b40ecc762[4])*
z0b500db18c;
float z06bf2e3f26=8.f/((z5eacb1dcf1+z9f2409475e*z7e68956b16));z06bf2e3f26*=
z6eb931d3c7;z657e1a72e9=z657e1a72e9*z06bf2e3f26;zde289c21d6=zde289c21d6*
z06bf2e3f26;zad455ed369=zad455ed369*z06bf2e3f26;zf021daf0b7=zf021daf0b7*
z06bf2e3f26;z657e1a72e9=1.f/(1.f+z657e1a72e9+z657e1a72e9*z657e1a72e9);
zde289c21d6=1.f/(1.f+zde289c21d6+zde289c21d6*zde289c21d6);zad455ed369=1.f/(1.f+
zad455ed369+zad455ed369*zad455ed369);zf021daf0b7=1.f/(1.f+zf021daf0b7+
zf021daf0b7*zf021daf0b7);float z26cc9604bc=z657e1a72e9+zde289c21d6+zad455ed369+
zf021daf0b7+zaf4cd759d5;ze4351005bc[0]=(z77c830e1b7*z657e1a72e9+z000f6d59de*
zde289c21d6+z508d1e06ee*zad455ed369+zea7bf504e4*zf021daf0b7+z7e68956b16*
zaf4cd759d5)/(z26cc9604bc);




}
#endif
#if (z3dbd1ff682==2)
__kernel void za248650b6b(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z958df11031,float8 z0a1dda9ae0,
__global float*z5413c0ac97,int4 z0cda232ab2,__global float*z6dbcfbb363,int4
zf719ec198f,__global float*zeb6ed3bc69,int4 z4a87411fef,__global float*
z8ade1c6c19,int4 z7a9bb7a861){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.
s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=
zba94ee46da+z30eaaf69b7.s01;int2 zdc2396006d=zba94ee46da+z0cda232ab2.xy;int2
z40c99fd15e=zba94ee46da+zf719ec198f.xy;int2 z40d52bb17d=zba94ee46da+z4a87411fef.
xy;int2 z62e897781c=zba94ee46da+z7a9bb7a861.xy;int z0b6cb751d4=z0cda232ab2.z;int
 z4a8c908862=zf719ec198f.z;int z4dbb7d147e=z4a87411fef.z;int zf69fb57d32=
z7a9bb7a861.z;bool zddaf4de511=z0cda232ab2.w!=0;bool z1efba975ec=zf719ec198f.w!=
0;bool zd9046860d9=z7a9bb7a861.w!=0;float4 z395b96baac=zf8d9fd6cb8[z83640e5796.x
+z83640e5796.y*(z021babbfad)];float z2416fbcc28=z5413c0ac97[zdc2396006d.x+
zdc2396006d.y*z0b6cb751d4];float z6d76673a36=-1.0f;if(z1efba975ec)z6d76673a36=
z6dbcfbb363[z40c99fd15e.x+z40c99fd15e.y*z4a8c908862];float z8172194062=
z8172194062=zeb6ed3bc69[z40d52bb17d.x+z40d52bb17d.y*z4dbb7d147e];float
z1d7e69a7ee=0.0f;if(zd9046860d9)z1d7e69a7ee=z8ade1c6c19[z62e897781c.x+
z62e897781c.y*zf69fb57d32];
const float z7357ed03c0=z0a1dda9ae0.s0;const float z34aee0e668=z0a1dda9ae0.s1;
const float z7fb3735657=z0a1dda9ae0.s2;const float z5eacb1dcf1=z0a1dda9ae0.s3;
const float z9f2409475e=z0a1dda9ae0.s4;const float z28dfa3cab8=z0a1dda9ae0.s5;








float ze4b052164b=z395b96baac.x;
float z2e91460297=z395b96baac.y;
float z7e674d442a=z395b96baac.z;

float z7e68956b16=z9050d7d057(ze4b052164b,z2e91460297,z7e674d442a)+1.f;
float z99e3d023d3=z2416fbcc28;
float zce1f48b26b;zce1f48b26b=z8172194062;
if(zddaf4de511){
float zac03b8df64=z5eacb1dcf1+z9f2409475e*zce1f48b26b;
float zec65e8d581=(z99e3d023d3-zce1f48b26b)*z28dfa3cab8;zec65e8d581*=zec65e8d581
;
zec65e8d581=z7fb3735657*zac03b8df64/(zac03b8df64+zec65e8d581);

if(z1efba975ec){z99e3d023d3*=z6d76673a36;}

z99e3d023d3=z99e3d023d3*zec65e8d581+(zce1f48b26b*z7fb3735657+z7e68956b16*(1.f-
z7fb3735657))*(1.f-zec65e8d581);}else if(zd9046860d9){
if(z1efba975ec){z99e3d023d3*=z6d76673a36;}float zec65e8d581=z1d7e69a7ee*0.01f;

z99e3d023d3=z99e3d023d3*zec65e8d581+(zce1f48b26b*zec65e8d581+z7e68956b16*(1.f-
zec65e8d581))*(1.f-zec65e8d581);}else{
if(z1efba975ec){z99e3d023d3*=z6d76673a36;}

z99e3d023d3=z99e3d023d3*z7fb3735657+(zce1f48b26b*z7fb3735657+z7e68956b16*(1.f-
z7fb3735657))*(1.f-z7fb3735657);}float4 ze4351005bc;if(z99e3d023d3<z7e68956b16*
1.5f){float z86dd029962=z99e3d023d3/z7e68956b16;ze4351005bc.s0=ze4b052164b*
z86dd029962;ze4351005bc.s1=z2e91460297*z86dd029962;ze4351005bc.s2=z7e674d442a*
z86dd029962;}else{float z3a2fa68d0e=(z99e3d023d3-z7e68956b16*1.5f);ze4351005bc.
s0=ze4b052164b*1.5f+z3a2fa68d0e;ze4351005bc.s1=z2e91460297*1.5f+z3a2fa68d0e;
ze4351005bc.s2=z7e674d442a*1.5f+z3a2fa68d0e;}ze4351005bc.s3=0.0f;z718a062ddd[
zaaf414d14e.x+zaaf414d14e.y*(z958df11031)]=ze4351005bc;







}
#endif
#if (z3dbd1ff682==3)
#define MAX max
#define MIN min

__kernel void za248650b6b(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int ze265e77baa,int z9daa334467,float2 zfb81b1b9ea){int2
z945895b462=(int2)(get_global_id(0),get_global_id(1));if(z945895b462.x>
z30eaaf69b7.s2||z945895b462.y>z30eaaf69b7.s3)return;int2 z83640e5796=z945895b462
+z30eaaf69b7.s01;int2 zaaf414d14e=z945895b462+z30eaaf69b7.s45;const float
z63cd9b76fa=zfb81b1b9ea.x;const float z283dbdacb6=zfb81b1b9ea.y;__global float*
z395b96baac=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*ze265e77baa;__global float*
ze4351005bc=z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*z9daa334467;const int
z45c01651ac=ze265e77baa;const int x=0;
float zd095913c8a=z395b96baac[x-1-z45c01651ac];float zdf516a31d2=z395b96baac[x-
z45c01651ac];float ze6239aa706=z395b96baac[x+1-z45c01651ac];float z472a64058d=
z395b96baac[x-1];float zcbdd216f8c=z395b96baac[x];float zc174ada40c=z395b96baac[
x+1];float z0326239fd0=z395b96baac[x-1+z45c01651ac];float z03f0788244=
z395b96baac[x+z45c01651ac];float z1dbcfc5d62=z395b96baac[x+1+z45c01651ac];
float zd8e18175c0=MAX(zd095913c8a,zdf516a31d2);float z39f117b1fe=MIN(zd095913c8a
,zdf516a31d2);zd8e18175c0=MAX(zd8e18175c0,ze6239aa706);z39f117b1fe=MIN(
z39f117b1fe,ze6239aa706);zd8e18175c0=MAX(zd8e18175c0,z472a64058d);z39f117b1fe=
MIN(z39f117b1fe,z472a64058d);zd8e18175c0=MAX(zd8e18175c0,zc174ada40c);
z39f117b1fe=MIN(z39f117b1fe,zc174ada40c);zd8e18175c0=MAX(zd8e18175c0,z0326239fd0
);z39f117b1fe=MIN(z39f117b1fe,z0326239fd0);zd8e18175c0=MAX(zd8e18175c0,
z03f0788244);z39f117b1fe=MIN(z39f117b1fe,z03f0788244);zd8e18175c0=MAX(
zd8e18175c0,z1dbcfc5d62);z39f117b1fe=MIN(z39f117b1fe,z1dbcfc5d62);
float zb92ef29b4b=MIN(MAX(z39f117b1fe,zcbdd216f8c),zd8e18175c0);
ze4351005bc[x]=zcbdd216f8c*z63cd9b76fa+zb92ef29b4b*z283dbdacb6;}
#endif
#if (z3dbd1ff682==4)
#define MAX max
__kernel void za248650b6b(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int z4f2f9f25cc,int zd9ed4f0969,float8 z3c211c8179,float4
z0a1dda9ae0,__global float*z8ade1c6c19,int4 z7a9bb7a861){int2 zba94ee46da=(int2)
(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.
s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int z45c01651ac=(int)
z4f2f9f25cc;int zb41a4b7008=(int)zd9ed4f0969;float zaf4cd759d5=z0a1dda9ae0.s0;
const float z5eacb1dcf1=z0a1dda9ae0.s1;const float z9f2409475e=z0a1dda9ae0.s2;
const float z6eb931d3c7=z3c211c8179.s0;float za0ff5ea62f=z3c211c8179.s1;float
z3db2187833=z3c211c8179.s2;const float zc080bfaa90=z3c211c8179.s3;const float
z470633ef56=z3c211c8179.s4;const float zf7bd8b4b63=z3c211c8179.s5;const float
zb729614b82=z3c211c8179.s6;__global float*z395b96baac=zf8d9fd6cb8+z83640e5796.x+
z83640e5796.y*(z45c01651ac);__global float*ze4351005bc=z718a062ddd+zaaf414d14e.x
+zaaf414d14e.y*(zb41a4b7008);int2 z62e897781c=zba94ee46da+z7a9bb7a861.xy;
__global float*z8b3fb6656c=z8ade1c6c19+z62e897781c.x+z62e897781c.y*z7a9bb7a861.z
;bool zd9046860d9=z7a9bb7a861.w!=0;




const int x=0;

float z7e68956b16=z395b96baac[0];
float z19731b763d[5];float z4a1516272a[5];float z33592e8600[5];float z3b40ecc762
[5];for(int z1d8bd19892=-2;z1d8bd19892<=2;z1d8bd19892++){z19731b763d[z1d8bd19892
+2]=z395b96baac[z1d8bd19892];z4a1516272a[z1d8bd19892+2]=z395b96baac[z45c01651ac*
z1d8bd19892];z33592e8600[z1d8bd19892+2]=z395b96baac[(1+z45c01651ac)*z1d8bd19892]
;z3b40ecc762[z1d8bd19892+2]=z395b96baac[(1-z45c01651ac)*z1d8bd19892];}
float z8fc8a0f770=z5eacb1dcf1+z9f2409475e*z7e68956b16;
float z77c830e1b7=z19731b763d[0];float z000f6d59de=z4a1516272a[0];float
z508d1e06ee=z33592e8600[0];float zea7bf504e4=z3b40ecc762[0];float z657e1a72e9=
z19731b763d[0]*z19731b763d[0];float zde289c21d6=z4a1516272a[0]*z4a1516272a[0];
float zad455ed369=z33592e8600[0]*z33592e8600[0];float zf021daf0b7=z3b40ecc762[0]
*z3b40ecc762[0];
for(int z1d8bd19892=1;z1d8bd19892<5;z1d8bd19892++){z77c830e1b7+=z19731b763d[
z1d8bd19892];z000f6d59de+=z4a1516272a[z1d8bd19892];z508d1e06ee+=z33592e8600[
z1d8bd19892];zea7bf504e4+=z3b40ecc762[z1d8bd19892];z657e1a72e9+=z19731b763d[
z1d8bd19892]*z19731b763d[z1d8bd19892];zde289c21d6+=z4a1516272a[z1d8bd19892]*
z4a1516272a[z1d8bd19892];zad455ed369+=z33592e8600[z1d8bd19892]*z33592e8600[
z1d8bd19892];zf021daf0b7+=z3b40ecc762[z1d8bd19892]*z3b40ecc762[z1d8bd19892];}
z77c830e1b7*=0.2f;z000f6d59de*=0.2f;z508d1e06ee*=0.2f;zea7bf504e4*=0.2f;
z657e1a72e9=z657e1a72e9*0.2f-z77c830e1b7*z77c830e1b7;zde289c21d6=zde289c21d6*
0.2f-z000f6d59de*z000f6d59de;zad455ed369=zad455ed369*0.2f-z508d1e06ee*
z508d1e06ee;zf021daf0b7=zf021daf0b7*0.2f-zea7bf504e4*zea7bf504e4;
{float z3b2e9d0ca6=((z19731b763d[4]-z19731b763d[0])*2.f+(z19731b763d[3]-
z19731b763d[1]))*0.2f;float z413c27534d=((z4a1516272a[4]-z4a1516272a[0])*2.f+(
z4a1516272a[3]-z4a1516272a[1]))*0.2f;float z9e54d295ff=((z33592e8600[4]-
z33592e8600[0])*2.f+(z33592e8600[3]-z33592e8600[1]))*0.2f;float zc780c2a3a7=((
z3b40ecc762[4]-z3b40ecc762[0])*2.f+(z3b40ecc762[3]-z3b40ecc762[1]))*0.2f;
z657e1a72e9-=0.5f*z3b2e9d0ca6*z3b2e9d0ca6;zde289c21d6-=0.5f*z413c27534d*
z413c27534d;zad455ed369-=0.5f*z9e54d295ff*z9e54d295ff;zf021daf0b7-=0.5f*
zc780c2a3a7*zc780c2a3a7;}
{float zd80de598c8=(zd9046860d9)?z8b3fb6656c[x]:zb729614b82;float z70ac623225=
MAX(z657e1a72e9,zde289c21d6)+MAX(zad455ed369,zf021daf0b7);float z89b61921f9=
100.f*z70ac623225/(z70ac623225+z8fc8a0f770)+zd80de598c8;z3db2187833=zc080bfaa90-
z89b61921f9*z470633ef56;z3db2187833=MAX(z3db2187833,zf7bd8b4b63);za0ff5ea62f=(
1.f/3.f)-z3db2187833*(2.f/3.f);}
float z5b8c31c8e4=(1.f/(8.f*z6eb931d3c7))*z8fc8a0f770;z5b8c31c8e4*=z5b8c31c8e4;

float z757eb08fe3=(z19731b763d[0]+z19731b763d[4])*(z3db2187833-za0ff5ea62f)+
z77c830e1b7*(za0ff5ea62f*5.f);float zecbe22ad45=(z4a1516272a[0]+z4a1516272a[4])*
(z3db2187833-za0ff5ea62f)+z000f6d59de*(za0ff5ea62f*5.f);float z0287b4dada=(
z33592e8600[0]+z33592e8600[4])*(z3db2187833-za0ff5ea62f)+z508d1e06ee*(
za0ff5ea62f*5.f);float z9bd34c7f83=(z3b40ecc762[0]+z3b40ecc762[4])*(z3db2187833-
za0ff5ea62f)+zea7bf504e4*(za0ff5ea62f*5.f);
z657e1a72e9=z5b8c31c8e4/(z5b8c31c8e4+8.f*z657e1a72e9*z657e1a72e9);zde289c21d6=
z5b8c31c8e4/(z5b8c31c8e4+8.f*zde289c21d6*zde289c21d6);zad455ed369=z5b8c31c8e4/(
z5b8c31c8e4+8.f*zad455ed369*zad455ed369);zf021daf0b7=z5b8c31c8e4/(z5b8c31c8e4+
8.f*zf021daf0b7*zf021daf0b7);float z26cc9604bc=z657e1a72e9+zde289c21d6+
zad455ed369+zf021daf0b7+zaf4cd759d5;ze4351005bc[x]=(z757eb08fe3*z657e1a72e9+
zecbe22ad45*zde289c21d6+z0287b4dada*zad455ed369+z9bd34c7f83*zf021daf0b7+
z7e68956b16*zaf4cd759d5)/(z26cc9604bc);




}
#endif
#if (z3dbd1ff682==5)
#ifndef z93a6893130
#define z38c913a03a 0
#else
#define z38c913a03a z93a6893130
#endif
float z6d7333005c(float16 z2dd09f3226,float16 za3158292ce){
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
return dot(z2dd09f3226.s01,za3158292ce.s012);
#endif
return 0.0f;}__kernel void za248650b6b(__global float*zf8d9fd6cb8,__global float
*z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z745057f086,float z258a407c2d,
__global uchar*zec145e35cf,int16 z7f76fb323c,int4 z3576e84f20,float16
zd8b21bfb9c){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 z9b046bc3a1=zba94ee46da+z3576e84f20
.s01;int zfcaa177308=z3576e84f20.s2;int z98cd6733c3=z9b046bc3a1.x+z9b046bc3a1.y*
zfcaa177308;int*z6016b79538=(int*)&z7f76fb323c;float16 z305c8a97dc;float*
zbd7b15dc4f=(float*)&z305c8a97dc;for(int z1d8bd19892=0;z1d8bd19892<z38c913a03a;
z1d8bd19892++)zbd7b15dc4f[z1d8bd19892]=convert_float(z6016b79538[z1d8bd19892]>=0
?zec145e35cf[z98cd6733c3+z6016b79538[z1d8bd19892]]:0);float zec2cea3690=
z6d7333005c(zd8b21bfb9c,z305c8a97dc);zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*
z021babbfad]=min(100.0f,zec2cea3690+z258a407c2d);}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
