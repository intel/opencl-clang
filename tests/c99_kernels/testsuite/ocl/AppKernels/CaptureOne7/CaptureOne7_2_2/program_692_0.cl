#define z3dbd1ff682 0

#ifndef z3dbd1ff682
#define z3dbd1ff682 2
#endif
#define z9050d7d057(zff400e9e97,z305d891f1d,za3158292ce)    ( (zff400e9e97)*\
0.299f + (z305d891f1d)*0.587f + (za3158292ce)*0.114f )
#if (z3dbd1ff682==0)
__kernel void za248650b6b(__global float4*zf8d9fd6cb8,__global float*z718a062ddd
,int8 z30eaaf69b7,uint z021babbfad,uint z958df11031){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;
zba94ee46da+=z30eaaf69b7.s01;
float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad)];float
z5413c0ac97=z9050d7d057(z493deefb55.x,z493deefb55.y,z493deefb55.z)+1.f;
z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031)]=z5413c0ac97;}
#endif
#if (z3dbd1ff682==1)
__kernel void za248650b6b(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,uint z021babbfad,uint z958df11031,float8 z3c211c8179,float4
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
z718a062ddd,int8 z30eaaf69b7,uint z021babbfad,uint z958df11031,float8
z0a1dda9ae0,__global float*z5413c0ac97,int4 z0cda232ab2,__global float*
z6dbcfbb363,int4 zf719ec198f,__global float*zeb6ed3bc69,int4 z4a87411fef){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int2
zdc2396006d=zba94ee46da+z0cda232ab2.xy;int2 z40c99fd15e=zba94ee46da+zf719ec198f.
xy;int2 z40d52bb17d=zba94ee46da+z4a87411fef.xy;int z0b6cb751d4=z0cda232ab2.z;int
 z4a8c908862=zf719ec198f.z;int z4dbb7d147e=z4a87411fef.z;bool z1efba975ec=
zf719ec198f.w!=0;bool z74d3ea7a94=z4a87411fef.w!=0;float4 z395b96baac=
zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad)];float z2416fbcc28=
z5413c0ac97[zdc2396006d.x+zdc2396006d.y*z0b6cb751d4];float z6d76673a36=-1.0f;if(
z1efba975ec)z6d76673a36=z6dbcfbb363[z40c99fd15e.x+z40c99fd15e.y*z4a8c908862];
float z8172194062=-1.0f;if(z74d3ea7a94)z8172194062=zeb6ed3bc69[z40d52bb17d.x+
z40d52bb17d.y*z4dbb7d147e];
const float z7357ed03c0=z0a1dda9ae0.s0;const float z34aee0e668=z0a1dda9ae0.s1;
const float z7fb3735657=z0a1dda9ae0.s2;const float z5eacb1dcf1=z0a1dda9ae0.s3;
const float z9f2409475e=z0a1dda9ae0.s4;








float ze4b052164b=z395b96baac.x;
float z2e91460297=z395b96baac.y;
float z7e674d442a=z395b96baac.z;

float z7e68956b16=z9050d7d057(ze4b052164b,z2e91460297,z7e674d442a)+1.f;
float z99e3d023d3=z2416fbcc28;
float zce1f48b26b;if(z74d3ea7a94)zce1f48b26b=z8172194062;
else zce1f48b26b=z7e68956b16;

float zac03b8df64=z5eacb1dcf1+z9f2409475e*zce1f48b26b;
float zec65e8d581=(z99e3d023d3-zce1f48b26b)*(1.f/z7357ed03c0);zec65e8d581*=
zec65e8d581;
zec65e8d581=z7fb3735657*zac03b8df64/(zac03b8df64+zec65e8d581);

if(z1efba975ec){z99e3d023d3*=z6d76673a36;}

z99e3d023d3=z99e3d023d3*zec65e8d581+(zce1f48b26b*z7fb3735657+z7e68956b16*(1.f-
z7fb3735657))*(1.f-zec65e8d581);

float4 ze4351005bc;if(z99e3d023d3<z7e68956b16*1.5f){float z86dd029962=
z99e3d023d3/z7e68956b16;ze4351005bc.s0=ze4b052164b*z86dd029962;ze4351005bc.s1=
z2e91460297*z86dd029962;ze4351005bc.s2=z7e674d442a*z86dd029962;}else{float
z3a2fa68d0e=(z99e3d023d3-z7e68956b16*1.5f);ze4351005bc.s0=ze4b052164b*1.5f+
z3a2fa68d0e;ze4351005bc.s1=z2e91460297*1.5f+z3a2fa68d0e;ze4351005bc.s2=
z7e674d442a*1.5f+z3a2fa68d0e;}ze4351005bc.s3=0.0f;z718a062ddd[zaaf414d14e.x+
zaaf414d14e.y*(z958df11031)]=ze4351005bc;







}
#endif
#if (z3dbd1ff682==3)

__kernel void za248650b6b(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,uint ze265e77baa,uint z9daa334467,float2 zfb81b1b9ea){int2
z945895b462=(int2)(get_global_id(0),get_global_id(1));if(z945895b462.x>
z30eaaf69b7.s2||z945895b462.y>z30eaaf69b7.s3)return;int2 z83640e5796=z945895b462
+z30eaaf69b7.s01;int2 zaaf414d14e=z945895b462+z30eaaf69b7.s45;const float
zea34483265=zfb81b1b9ea.x;const float z38c36eec91=zfb81b1b9ea.y;int zc9d655d235=
zaaf414d14e.x+zaaf414d14e.y*ze265e77baa;float z9697e8d76f=zf8d9fd6cb8[
zc9d655d235];float z609bdd34e0=FLT_MIN;float zbf66fbcae1=FLT_MIN;float
z97ee951852=FLT_MAX;float z2ed1af3fb8=FLT_MAX;for(int z1d8bd19892=-1;z1d8bd19892
<=1;z1d8bd19892++){for(int zdbc3421475=-1;zdbc3421475<=1;zdbc3421475++){float
z88dce4da4d=zf8d9fd6cb8[zc9d655d235+zdbc3421475+z1d8bd19892*ze265e77baa];if(
z88dce4da4d>z609bdd34e0){zbf66fbcae1=z609bdd34e0;z609bdd34e0=z88dce4da4d;}else
if(z88dce4da4d>zbf66fbcae1)zbf66fbcae1=z88dce4da4d;if(z88dce4da4d<z97ee951852){
z2ed1af3fb8=z97ee951852;z97ee951852=z88dce4da4d;}else if(z88dce4da4d<z2ed1af3fb8
)z2ed1af3fb8=z88dce4da4d;}}if(z9697e8d76f>=zbf66fbcae1)z9697e8d76f=z609bdd34e0*
zea34483265+zbf66fbcae1*z38c36eec91;if(z9697e8d76f<=z2ed1af3fb8)z9697e8d76f=
z97ee951852*zea34483265+z2ed1af3fb8*z38c36eec91;z718a062ddd[zaaf414d14e.x+
zaaf414d14e.y*z9daa334467]=z9697e8d76f;}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
