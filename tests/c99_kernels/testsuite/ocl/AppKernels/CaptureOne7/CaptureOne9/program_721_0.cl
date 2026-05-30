#define z3dbd1ff682 1

#ifndef z3dbd1ff682
#define z3dbd1ff682 1
#endif
typedef ushort z51b7908a0d;typedef uint za6c557b086;
#define MAX max
#define MIN min
#define z121e64db3b sqrt
#define z15c54146b5 exp
#define z205bcb857e(z2dd09f3226) convert_int(floor(z2dd09f3226))
#define z12cbbf15c0 65535
#define __INLINE__
#define zf6dfd69ac5
int zdc050cc189(const float x){return x>0?(int)x:(int)x-1;}float z9fee37be51(
__constant float*z305d891f1d,const float x,const float y,const float z){return
z305d891f1d[0]*x+z305d891f1d[1]*y+z305d891f1d[2]*z;}
__constant float zabc93eaba2[12][3]={{1.0f,1.0f,0.0f},{-1.0f,1.0f,0.0f},{1.0f,-
1.0f,0.0f},{-1.0f,-1.0f,0.0f},{1.0f,0.0f,1.0f},{-1.0f,0.0f,1.0f},{1.0f,0.0f,-
1.0f},{-1.0f,0.0f,-1.0f},{0.0f,1.0f,1.0f},{0.0f,-1.0f,1.0f},{0.0f,1.0f,-1.0f},{
0.0f,-1.0f,-1.0f}};__INLINE__ za6c557b086 z24baacaf5e(int z2dd09f3226){return
69069*z2dd09f3226+1234567;}__INLINE__ za6c557b086 zcb05287515(int z2dd09f3226){
z2dd09f3226=36969*(z2dd09f3226&0xFFFF)+(z2dd09f3226>>16);return z2dd09f3226;}
__INLINE__ za6c557b086 zd0efa19033(int z2dd09f3226){z2dd09f3226=18000*(
z2dd09f3226&0xFFFF)+(z2dd09f3226>>16);return z2dd09f3226;}__INLINE__ za6c557b086
 zcf6e5d12e2(int z2dd09f3226){z2dd09f3226=z2dd09f3226^(z2dd09f3226>>4);
z2dd09f3226=z2dd09f3226*0x27d4eb2d;z2dd09f3226=z2dd09f3226^(z2dd09f3226>>15);
return z2dd09f3226;}__INLINE__ za6c557b086 z44121cf414(int z2dd09f3226){
z2dd09f3226=z2dd09f3226^(z2dd09f3226>>4);z2dd09f3226=z2dd09f3226*16777619;
z2dd09f3226=z2dd09f3226^(z2dd09f3226>>15);return z2dd09f3226;}__INLINE__
za6c557b086 z3a31cb915d(int z2dd09f3226){z2dd09f3226=z2dd09f3226-(z2dd09f3226<<6
);z2dd09f3226=z2dd09f3226^(z2dd09f3226>>17);z2dd09f3226=z2dd09f3226-(z2dd09f3226
<<9);z2dd09f3226=z2dd09f3226^(z2dd09f3226<<4);z2dd09f3226=z2dd09f3226-(
z2dd09f3226<<3);z2dd09f3226=z2dd09f3226^(z2dd09f3226<<10);z2dd09f3226=
z2dd09f3226^(z2dd09f3226>>15);return z2dd09f3226;}int z306365a747(int x,int y){
unsigned int z941833a36d=z3a31cb915d(x+zcf6e5d12e2(y));unsigned int zba403f0a1f=
z3a31cb915d(y+z24baacaf5e(x));int zf71a2be2d9=0;
for(unsigned int z1d8bd19892=0;z1d8bd19892<2;z1d8bd19892++){z941833a36d=
zcb05287515(z941833a36d);zba403f0a1f=zd0efa19033(zba403f0a1f);unsigned int
za87f11b923=((z941833a36d<<16)+zba403f0a1f);
zf71a2be2d9+=((za87f11b923)&0x3FF);zf71a2be2d9+=((za87f11b923>>10)&0x3FF);
zf71a2be2d9+=((za87f11b923>>20)&0x3FF);}

zf71a2be2d9-=(6<<(10-1));zf71a2be2d9*=(int)((1<<(16-10))*z121e64db3b(12.f/6.f));
zf71a2be2d9+=(z941833a36d&0x3F)-(1<<(6-1));return zf71a2be2d9;}uint z6d1a5ca96f(
int x,int y,float z07b03f2ddc){unsigned int zba403f0a1f=z3a31cb915d(x+
zcf6e5d12e2(y));unsigned int zf71a2be2d9=0;unsigned int z877643e334=convert_uint
(z15c54146b5(-z07b03f2ddc)*z12cbbf15c0);unsigned int ze4b052164b=z12cbbf15c0;do{
zba403f0a1f=zd0efa19033(zba403f0a1f);unsigned int za87f11b923=(zba403f0a1f&
0xFFFF);ze4b052164b=(ze4b052164b*za87f11b923)>>16;zf71a2be2d9+=1;}while(
ze4b052164b>z877643e334);
return(zf71a2be2d9-1);}unsigned int ze8e0238739(int x,int y,float z07b03f2ddc){
const float z877643e334=4.f;
if(z07b03f2ddc<=z877643e334){return z6d1a5ca96f(x,y,z07b03f2ddc);}else if(
z07b03f2ddc<(2.f*z877643e334)){
int z029e2c74f8=z6d1a5ca96f(x,y,(2.f*z877643e334)-z07b03f2ddc);int z55ac45432e=(
z07b03f2ddc*2.f-(2.f*z877643e334)+0.5f)+z306365a747(x,y)*(1.f/65535.f)*
z121e64db3b(z07b03f2ddc*2.f-(2.f*z877643e334));return MAX(0,z029e2c74f8+
z55ac45432e);}else{
float z55ac45432e=z07b03f2ddc+0.5f+(z306365a747(x,y)*(1.f/65535.f))*z121e64db3b(
z07b03f2ddc);return MAX((uint)0,convert_uint(z55ac45432e));}}int z122c92f206(int
 x,int y){return z3a31cb915d(x+zcf6e5d12e2(y))&0xFFFF;}unsigned int z3f3f033c2f(
int x,int y,z51b7908a0d z493deefb55,unsigned int z88fa33d26d){
unsigned int zba403f0a1f=z3a31cb915d(x+zcf6e5d12e2(y));unsigned int zf71a2be2d9=
0;for(unsigned int z1d8bd19892=0;z1d8bd19892<z88fa33d26d;z1d8bd19892++){
zba403f0a1f=zd0efa19033(zba403f0a1f);zf71a2be2d9+=((z493deefb55>=(zba403f0a1f&
0xFFFF))?1:0);}return zf71a2be2d9;}unsigned int z8afc32ee66(int x,int y,
z51b7908a0d z493deefb55,unsigned int z88fa33d26d){if(z88fa33d26d<=8){
return z3f3f033c2f(x,y,z493deefb55,z88fa33d26d);}else if(z88fa33d26d<16){

int zb42dc7d1d8=16-z88fa33d26d;int zc4f0bd30e7=2*z88fa33d26d-16;int zcb3c0b2005=
z3f3f033c2f(x,y,z493deefb55,zb42dc7d1d8);float zdb5fae6624=z121e64db3b(
zc4f0bd30e7*(z493deefb55/65536.f)*(1.f-(z493deefb55/65536.f)));int z37f999a6ae=
MAX(0,(int)((zc4f0bd30e7*z493deefb55)+(int)(z306365a747(x,y)*zdb5fae6624)+(1<<15
)))>>16;z37f999a6ae=MIN(zc4f0bd30e7,z37f999a6ae);return zcb3c0b2005+z37f999a6ae;
}

const unsigned int z34307573bb=MIN(convert_int(0.1f*z12cbbf15c0),convert_int((
z12cbbf15c0*4)/z88fa33d26d));if(z493deefb55<z34307573bb){
int zb42dc7d1d8=(z88fa33d26d*z493deefb55)/z34307573bb;int zc4f0bd30e7=
z88fa33d26d-zb42dc7d1d8;float zdb5fae6624=z121e64db3b(zb42dc7d1d8*(z493deefb55/
65536.f)*(1.f-(z493deefb55/65536.f)));int zcb3c0b2005=MAX(0,(int)((zb42dc7d1d8*
z493deefb55)+(int)(z306365a747(x,y)*zdb5fae6624)+(1<<15)))>>16;zcb3c0b2005=MIN(
zb42dc7d1d8,zcb3c0b2005);int z37f999a6ae=MIN(zc4f0bd30e7,(int)z6d1a5ca96f(x,y,
z493deefb55/65535.f*zc4f0bd30e7));return zcb3c0b2005+z37f999a6ae;}else if(
z12cbbf15c0-z493deefb55<z34307573bb){
int z11fc704ac4=z12cbbf15c0-z493deefb55;int zb42dc7d1d8=(z88fa33d26d*z11fc704ac4
)/z34307573bb;int zc4f0bd30e7=z88fa33d26d-zb42dc7d1d8;float zdb5fae6624=
z121e64db3b(zb42dc7d1d8*(z493deefb55/65536.f)*(1.f-(z493deefb55/65536.f)));int
zcb3c0b2005=MAX(0,(int)((zb42dc7d1d8*z493deefb55)+(int)(z306365a747(x,y)*
zdb5fae6624)+(1<<15)))>>16;zcb3c0b2005=MIN(zb42dc7d1d8,zcb3c0b2005);int
z37f999a6ae=zc4f0bd30e7-MIN(zc4f0bd30e7,(int)z6d1a5ca96f(x,y,z11fc704ac4/65535.f
*zc4f0bd30e7));return zcb3c0b2005+z37f999a6ae;}else{
float zdb5fae6624=z121e64db3b(z88fa33d26d*(z493deefb55/65536.f)*(1.f-(
z493deefb55/65536.f)));int z96a2929ccd=MAX(0,(int)((z88fa33d26d*z493deefb55)+(
int)(z306365a747(x,y)*zdb5fae6624)+(1<<15)))>>16;z96a2929ccd=MIN((int)
z88fa33d26d,z96a2929ccd);return z96a2929ccd;}}float zf6dfd69ac5 z27db2b8f31(
const float x,const float y,const float z){float z73b0e56859,zb42dc7d1d8,
zc4f0bd30e7,zbfae3a4191;

const float z942f997bd1=1.f/3.f;float z5083031dab=convert_float(x+y+z)*
z942f997bd1;
int z1d8bd19892=z205bcb857e(x+z5083031dab);int zdbc3421475=z205bcb857e(y+
z5083031dab);int ze7168fc0b9=z205bcb857e(z+z5083031dab);const float zf7ee99daeb=
1.f/6.f;
float z52ab5b652a=convert_float(z1d8bd19892+zdbc3421475+ze7168fc0b9)*zf7ee99daeb
;float z857679e39d=convert_float(z1d8bd19892)-z52ab5b652a;
float z9f5c0d9c3f=convert_float(zdbc3421475)-z52ab5b652a;float z9ec90c8114=
convert_float(ze7168fc0b9)-z52ab5b652a;float zc180b9cdc9=x-z857679e39d;
float za3584c0652=y-z9f5c0d9c3f;float z51cddf54c8=z-z9ec90c8114;

int z7d07bb3247,z3b7e70c9c7,z842f1c9b69;
int zbf32ff9ae0,z721fa93515,ze5a637a73c;
if(zc180b9cdc9>=za3584c0652){if(za3584c0652>=z51cddf54c8){z7d07bb3247=1;
z3b7e70c9c7=0;z842f1c9b69=0;zbf32ff9ae0=1;z721fa93515=1;ze5a637a73c=0;}
else if(zc180b9cdc9>=z51cddf54c8){z7d07bb3247=1;z3b7e70c9c7=0;z842f1c9b69=0;
zbf32ff9ae0=1;z721fa93515=0;ze5a637a73c=1;}
else{z7d07bb3247=0;z3b7e70c9c7=0;z842f1c9b69=1;zbf32ff9ae0=1;z721fa93515=0;
ze5a637a73c=1;}
}else{
if(za3584c0652<z51cddf54c8){z7d07bb3247=0;z3b7e70c9c7=0;z842f1c9b69=1;
zbf32ff9ae0=0;z721fa93515=1;ze5a637a73c=1;}
else if(zc180b9cdc9<z51cddf54c8){z7d07bb3247=0;z3b7e70c9c7=1;z842f1c9b69=0;
zbf32ff9ae0=0;z721fa93515=1;ze5a637a73c=1;}
else{z7d07bb3247=0;z3b7e70c9c7=1;z842f1c9b69=0;zbf32ff9ae0=1;z721fa93515=1;
ze5a637a73c=0;}
}



float z35bf29e99b=zc180b9cdc9-convert_float(z7d07bb3247)+zf7ee99daeb;
float z1a6f4c4c08=za3584c0652-convert_float(z3b7e70c9c7)+zf7ee99daeb;float
z5a4e45a109=z51cddf54c8-convert_float(z842f1c9b69)+zf7ee99daeb;float z2c865879a0
=zc180b9cdc9-convert_float(zbf32ff9ae0)+2.f*zf7ee99daeb;
float z822c4d935e=za3584c0652-convert_float(z721fa93515)+2.f*zf7ee99daeb;float
z597c52797c=z51cddf54c8-convert_float(ze5a637a73c)+2.f*zf7ee99daeb;float
z6624dbc6f0=zc180b9cdc9-1.f+3.f*zf7ee99daeb;
float z23774b5397=za3584c0652-1.f+3.f*zf7ee99daeb;float z59abf8ea90=z51cddf54c8-
1.f+3.f*zf7ee99daeb;

int z2cd197c70f=z3a31cb915d(z1d8bd19892+zd0efa19033(zdbc3421475+zcb05287515(
ze7168fc0b9)));int z031d9ac63b=z3a31cb915d(z1d8bd19892+z7d07bb3247+zd0efa19033(
zdbc3421475+z3b7e70c9c7+zcb05287515(ze7168fc0b9+z842f1c9b69)));int z7e7cfd2729=
z3a31cb915d(z1d8bd19892+zbf32ff9ae0+zd0efa19033(zdbc3421475+z721fa93515+
zcb05287515(ze7168fc0b9+ze5a637a73c)));int zd6e410e58f=z3a31cb915d(z1d8bd19892+1
+zd0efa19033(zdbc3421475+1+zcb05287515(ze7168fc0b9+1)));z2cd197c70f=z2cd197c70f%
12;z031d9ac63b=z031d9ac63b%12;z7e7cfd2729=z7e7cfd2729%12;zd6e410e58f=zd6e410e58f
%12;
float z4afa277c82=0.6f-zc180b9cdc9*zc180b9cdc9-za3584c0652*za3584c0652-
z51cddf54c8*z51cddf54c8;if(z4afa277c82<0.f){z73b0e56859=0.f;}else{z4afa277c82*=
z4afa277c82;z73b0e56859=z4afa277c82*z4afa277c82*z9fee37be51(zabc93eaba2[
z2cd197c70f],zc180b9cdc9,za3584c0652,z51cddf54c8);}float z02702dd463=0.6f-
z35bf29e99b*z35bf29e99b-z1a6f4c4c08*z1a6f4c4c08-z5a4e45a109*z5a4e45a109;if(
z02702dd463<0.f){zb42dc7d1d8=0.f;}else{z02702dd463*=z02702dd463;zb42dc7d1d8=
z02702dd463*z02702dd463*z9fee37be51(zabc93eaba2[z031d9ac63b],z35bf29e99b,
z1a6f4c4c08,z5a4e45a109);}float z5cc5ab02f7=0.6f-z2c865879a0*z2c865879a0-
z822c4d935e*z822c4d935e-z597c52797c*z597c52797c;if(z5cc5ab02f7<0.f){zc4f0bd30e7=
0.f;}else{z5cc5ab02f7*=z5cc5ab02f7;zc4f0bd30e7=z5cc5ab02f7*z5cc5ab02f7*
z9fee37be51(zabc93eaba2[z7e7cfd2729],z2c865879a0,z822c4d935e,z597c52797c);}float
 za49431742a=0.6f-z6624dbc6f0*z6624dbc6f0-z23774b5397*z23774b5397-z59abf8ea90*
z59abf8ea90;if(za49431742a<0.f){zbfae3a4191=0.f;}else{za49431742a*=za49431742a;
zbfae3a4191=za49431742a*za49431742a*z9fee37be51(zabc93eaba2[zd6e410e58f],
z6624dbc6f0,z23774b5397,z59abf8ea90);}

return 32.f*(z73b0e56859+zb42dc7d1d8+zc4f0bd30e7+zbfae3a4191);}__INLINE__ float
z0a8899c69d(int x,int y,float z8e80b983e4){const float ze7dfbaf61f=0.5f;

float z16368368ff=z27db2b8f31((float)x*z8e80b983e4,(float)y*z8e80b983e4,1.f);if(
z8e80b983e4>ze7dfbaf61f)z16368368ff*=(ze7dfbaf61f/z8e80b983e4);

z8e80b983e4*=0.5f;float zfc4f6cf862=z27db2b8f31((float)x*z8e80b983e4,(float)y*
z8e80b983e4,10.f);if(z8e80b983e4>ze7dfbaf61f)zfc4f6cf862*=(ze7dfbaf61f/
z8e80b983e4);

return(z16368368ff*(2.f/3.f)+zfc4f6cf862*(1.f/3.f));}
#if (z3dbd1ff682==0 )
__kernel void z1b92ecfe7a(__global ushort4*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13){int2 zba94ee46da=(
int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.
s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;uint4 z493deefb55=convert_uint4
(zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z2824fcf57d)]);



uint z5ea709a94f=MAX(MAX(z493deefb55.x,z493deefb55.y),z493deefb55.z);

z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*(z9562068e13)]=convert_ushort_sat((
z493deefb55.x+z493deefb55.z+2*z5ea709a94f)/4);}
#endif
#if (z3dbd1ff682==1 )
__kernel void z1b92ecfe7a(__global float*zf8d9fd6cb8,__global ushort*z718a062ddd
,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;__global float*zbfd4c3fe43=zf8d9fd6cb8+
z83640e5796.x+z83640e5796.y*(z2824fcf57d);__global ushort*z2b523c57b1=
z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*(z9562068e13);

float z7adb1ae31c=convert_float(z2b523c57b1[0])*zbfd4c3fe43[0];z2b523c57b1[0]=
convert_ushort_sat(z7adb1ae31c);}
#endif
#if (z3dbd1ff682==2 )
__kernel void z1b92ecfe7a(__global float*zf8d9fd6cb8,__global ushort*z718a062ddd
,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int2 zfb81b1b9ea,float2
ze0995e6531){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=z30eaaf69b7.s45;int2 zaaf414d14e=z30eaaf69b7.s01;__global float*
zbfd4c3fe43=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*(z2824fcf57d);int
z546dd50799=z2824fcf57d;float zc0d4bd2024=ze0995e6531.x;float zc73cfabb51=
ze0995e6531.y;const int x=zba94ee46da.x;const int y=zba94ee46da.y;const int
zb6170e4cc6=zfb81b1b9ea.s0;
const int zc8435b5afd=zfb81b1b9ea.s1;







float z6c623bbec0=ze8e0238739(y+zc8435b5afd,x+zb6170e4cc6,zc0d4bd2024)*
zc73cfabb51;
zbfd4c3fe43[x+y*z546dd50799]=z6c623bbec0;

}
#endif
#if (z3dbd1ff682==3 )
__kernel void z1b92ecfe7a(__global float*zf8d9fd6cb8,__global ushort*z718a062ddd
,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int4 zfb81b1b9ea,float8
ze0995e6531){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=z30eaaf69b7.s45;int2 zaaf414d14e=z30eaaf69b7.s01;__global float*
zbfd4c3fe43=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*(z2824fcf57d);int
z546dd50799=z2824fcf57d;float z1106d3aec0=ze0995e6531.s0;float z0c34d1fa3a=
ze0995e6531.s1;float z042a3b0455=ze0995e6531.s2;float z42d7c57a56=ze0995e6531.s3
;float z14852fdafc=ze0995e6531.s4;float z59da5c1f43=ze0995e6531.s5;float
zc0d4bd2024=ze0995e6531.s6;float zb9bd72c454=ze0995e6531.s7;const int x=
zba94ee46da.x;const int y=zba94ee46da.y;

const int zb6170e4cc6=zfb81b1b9ea.s0;
const int zc8435b5afd=zfb81b1b9ea.s1;
const int z670449bc7c=zfb81b1b9ea.s2;
const int z31e368e94c=zfb81b1b9ea.s3;







int zf2099d2feb=z122c92f206(13*(y+zc8435b5afd),13*(x+zb6170e4cc6));float
z27147f029b=z306365a747(y+zc8435b5afd,x+zb6170e4cc6)*(1.f/65536.f);float
z6c623bbec0;
if(z670449bc7c<2){
if(zf2099d2feb<convert_int(z1106d3aec0*z12cbbf15c0)){z27147f029b=MAX(0.f,
z0c34d1fa3a+z27147f029b*z042a3b0455);}z6c623bbec0=zc0d4bd2024+z27147f029b*
z121e64db3b(zc0d4bd2024);z6c623bbec0=z6c623bbec0*(z31e368e94c/zc0d4bd2024)*
z59da5c1f43;}else{

int z1cd5a9c537=z8afc32ee66((x+zb6170e4cc6)*3,(y+zc8435b5afd)*5,(z1106d3aec0*
z12cbbf15c0),z670449bc7c);const float zd4e4b280e7=1.f;const float z8a4ebaa104=
zc0d4bd2024/(zc0d4bd2024+z121e64db3b(zc0d4bd2024)*z0c34d1fa3a*z1106d3aec0);

float z3b420eed55=(z1cd5a9c537*zb9bd72c454+(z670449bc7c-z1cd5a9c537)*zd4e4b280e7
)*(1.f/(z670449bc7c));z27147f029b=z0c34d1fa3a*z1cd5a9c537*(1.f/z670449bc7c)+
z27147f029b*z121e64db3b(z3b420eed55);z6c623bbec0=zc0d4bd2024+z27147f029b*
z121e64db3b(zc0d4bd2024);z6c623bbec0=z6c623bbec0*(z31e368e94c/zc0d4bd2024)*
z8a4ebaa104;}
zbfd4c3fe43[x+y*z546dd50799]=z6c623bbec0;

}
#endif
#if (z3dbd1ff682==4 )
__kernel void z1b92ecfe7a(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int2 zfb81b1b9ea,float4
ze0995e6531){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=z30eaaf69b7.s45;int2 zaaf414d14e=z30eaaf69b7.s01;__global float*
zbfd4c3fe43=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*(z2824fcf57d);int
z546dd50799=z2824fcf57d;

float zc0d4bd2024=ze0995e6531.s0;float z4e2994031c=ze0995e6531.s1;float
ze2795900ea=ze0995e6531.s2;float zca02680fe3=ze0995e6531.s3;const int x=
zba94ee46da.x;const int y=zba94ee46da.y;const int zb6170e4cc6=zfb81b1b9ea.s0;
const int zc8435b5afd=zfb81b1b9ea.s1;







float z6c623bbec0;z6c623bbec0=zc0d4bd2024+z0a8899c69d(y+zc8435b5afd,x+
zb6170e4cc6,zca02680fe3)*ze2795900ea;z6c623bbec0=z6c623bbec0*(z4e2994031c);
zbfd4c3fe43[x+y*z546dd50799]=z6c623bbec0;

}
#endif
#if (z3dbd1ff682==5 )
__kernel void z1b92ecfe7a(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int4 zc8bf9b79e6,
uint2 z930d306fac){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if
(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=z30eaaf69b7.s45;int2 zaaf414d14e=z30eaaf69b7.s01;__global ushort*
z2b523c57b1=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*(z2824fcf57d);int
z710c07c058=z2824fcf57d;const int x=zba94ee46da.x;const int y=zba94ee46da.y;

const int zb6170e4cc6=zc8bf9b79e6.s0;const int zc8435b5afd=zc8bf9b79e6.s1;const
int z02abb11b5e=zc8bf9b79e6.s2;const int zb08da79df7=zc8bf9b79e6.s3;const uint
z31e368e94c=z930d306fac.s0;const uint z4073a13fe9=z930d306fac.s1;






int z5413c0ac97=convert_int(z2b523c57b1[x+y*z710c07c058]);
int z29318da304=z8afc32ee66(x+zb6170e4cc6,y+zc8435b5afd,z5413c0ac97,z02abb11b5e)
;
z29318da304=z29318da304*((int)z12cbbf15c0/z02abb11b5e);

if(z31e368e94c<16&&z31e368e94c*256<z4073a13fe9){int z9ab3acb7e2=z8afc32ee66(x+
zb6170e4cc6,y+zc8435b5afd,z5413c0ac97,z02abb11b5e+1);z9ab3acb7e2=z9ab3acb7e2*((
int)z12cbbf15c0/(z31e368e94c+1));unsigned int z5e985e5327=z4073a13fe9&0xFF;
z29318da304=(z9ab3acb7e2*z5e985e5327+z29318da304*(256-z5e985e5327))/256;}else if
(z31e368e94c>256){
z29318da304=z5413c0ac97+((z29318da304-z5413c0ac97)*zb08da79df7)/1024;
}
z2b523c57b1[x+y*z710c07c058]=MIN(z12cbbf15c0,MAX(0,z29318da304));

}
#endif
#if (z3dbd1ff682 == 6 )
__kernel void z1b92ecfe7a(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float4 zd7d3eeba57)
{int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;
__global ushort*z395b96baac=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*(z2824fcf57d
);float ze28128c2dd;ze28128c2dd=zd7d3eeba57.s2*convert_float(z395b96baac[0]);
ze28128c2dd+=zd7d3eeba57.s0*(convert_float(z395b96baac[-1-z2824fcf57d])+
convert_float(z395b96baac[1-z2824fcf57d])+convert_float(z395b96baac[-1+
z2824fcf57d])+convert_float(z395b96baac[1+z2824fcf57d]));ze28128c2dd+=
zd7d3eeba57.s1*(convert_float(z395b96baac[-z2824fcf57d])+convert_float(
z395b96baac[-1])+convert_float(z395b96baac[1])+convert_float(z395b96baac[
z2824fcf57d]));z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*(z9562068e13)]=
convert_ushort_sat(ze28128c2dd);}
#endif
#if (z3dbd1ff682 == 7 )
__kernel void z1b92ecfe7a(__global ushort4*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,uint2 zfb81b1b9ea,
__global ushort*z0b22c1a6db,int4 z0c2498a95e){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;uint zc10d38c99c=zfb81b1b9ea.s0;uint zea34483265=
zfb81b1b9ea.s1;const int z45c01651ac=z2824fcf57d;const int zb41a4b7008=
z9562068e13;const int z8afa62305c=z0c2498a95e.s2;int2 z83640e5796=zba94ee46da+
z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int2 z6f927cf304=
zba94ee46da+z0c2498a95e.s01;uint4 z395b96baac=convert_uint4(zf8d9fd6cb8[
z83640e5796.x+z83640e5796.y*z45c01651ac]);uint4 ze4351005bc;__global ushort*
ze747d6dfdc=z0b22c1a6db+z6f927cf304.x+z6f927cf304.y*z8afa62305c;
unsigned int ze4b052164b=z395b96baac.x;
unsigned int z2e91460297=z395b96baac.y;
unsigned int z7e674d442a=z395b96baac.z;
unsigned int z5ea709a94f=MAX(MAX(ze4b052164b,z2e91460297),z7e674d442a);
unsigned int z233197dcf4=(ze4b052164b+z7e674d442a+2*z5ea709a94f)/4;unsigned int
zff5c9644ab=convert_uint(ze747d6dfdc[0]);

if(zff5c9644ab>=z233197dcf4){int zf1396ed097=(int)zff5c9644ab-(int)z233197dcf4;
zf1396ed097=(zf1396ed097*zea34483265)/1024;ze4351005bc.x=MIN(z12cbbf15c0,MAX(0,(
int)ze4b052164b+zf1396ed097));ze4351005bc.y=MIN(z12cbbf15c0,MAX(0,(int)
z2e91460297+zf1396ed097));ze4351005bc.z=MIN(z12cbbf15c0,MAX(0,(int)z7e674d442a+
zf1396ed097));}else{unsigned int z86dd029962=(zff5c9644ab*zea34483265)/
z233197dcf4+zc10d38c99c;ze4351005bc.x=MIN((uint)z12cbbf15c0,(ze4b052164b*
z86dd029962)/1024);ze4351005bc.y=MIN((uint)z12cbbf15c0,(z2e91460297*z86dd029962)
/1024);ze4351005bc.z=MIN((uint)z12cbbf15c0,(z7e674d442a*z86dd029962)/1024);}
z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=convert_ushort4(ze4351005bc
);}
#endif
#if (z3dbd1ff682 == 8)
__constant ushort z94048668db[257]={32,509,684,810,908,990,1060,1120,1173,1220,
1262,1300,1334,1364,1392,1417,1440,1461,1479,1496,1512,1526,1538,1550,1560,1569,
1577,1584,1590,1595,1599,1603,1606,1608,1610,1611,1611,1611,1611,1610,1608,1606,
1604,1601,1598,1595,1591,1587,1582,1578,1573,1567,1562,1556,1550,1544,1537,1531,
1524,1517,1510,1503,1495,1487,1480,1472,1464,1456,1447,1439,1430,1422,1413,1404,
1396,1387,1378,1369,1359,1350,1341,1332,1322,1313,1303,1294,1284,1275,1265,1256,
1246,1236,1227,1217,1207,1197,1188,1178,1168,1158,1149,1139,1129,1119,1110,1100,
1090,1080,1071,1061,1051,1041,1032,1022,1012,1003,993,984,974,965,955,945,936,
927,917,908,898,889,880,871,861,852,843,834,825,816,807,798,789,780,771,762,753,
744,736,727,718,710,701,693,684,676,667,659,651,642,634,626,618,610,602,594,586,
578,570,562,554,547,539,531,524,516,509,501,494,486,479,472,464,457,450,443,436,
429,422,415,408,401,394,388,381,374,368,361,354,348,341,335,329,322,316,310,304,
298,292,285,279,273,268,262,256,250,244,239,233,227,222,216,211,205,200,194,189,
184,179,173,168,163,158,153,148,143,138,133,128,124,119,114,109,105,100,96,91,87
,82,78,73,69,65,60,56,52,48,44,40,36,32};
#define zec2537fa23 1
__kernel void z1b92ecfe7a(__global ushort*zf8d9fd6cb8,__global float*z718a062ddd
,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int ze0359bef12,float2
zfb81b1b9ea){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7
.s01;__global ushort*z2416fbcc28=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*(
z2824fcf57d);__global float*zbfd4c3fe43=z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*
(z9562068e13);const float zc0d4bd2024=zfb81b1b9ea.s0;const float z31e368e94c=
zfb81b1b9ea.s1;const float z03df4431c9=1.0f/1611.0f;unsigned int z5413c0ac97=
z2416fbcc28[0];
float z6c623bbec0=zbfd4c3fe43[0];

float z716146ae96=convert_float(z94048668db[z5413c0ac97/256])*z03df4431c9;
z716146ae96=MIN(z716146ae96,1.f);if(ze0359bef12==zec2537fa23){if(zc0d4bd2024<1.f
){z716146ae96*=(1.f/zc0d4bd2024);z716146ae96=MIN(1.f,z716146ae96);}z6c623bbec0=
z6c623bbec0*z716146ae96+(1.f-z716146ae96);}else{z6c623bbec0=z6c623bbec0*
z716146ae96+z31e368e94c*(1.f-z716146ae96);z6c623bbec0=MAX(z6c623bbec0,0.f);
z6c623bbec0*=(1.f/z31e368e94c);}
zbfd4c3fe43[0]=z6c623bbec0;}
#endif
#if z3dbd1ff682==9
inline za6c557b086 z061a86f68a(int z49cb77b4dc,int z2523506dd2,__constant uchar*
zbf08573773,__constant uchar*zb72766fcd3,__constant za6c557b086*z4124e043ed){int
 z6c1348502a=(z49cb77b4dc&0x0f)<<4|(z2523506dd2&0x0f);int z8acd4fa0c6=(
z49cb77b4dc&0xf0)>>4|(z2523506dd2&0xf0);int z64f8d93415=zbf08573773[z6c1348502a]
;int zabdc291adf=zb72766fcd3[z6c1348502a];return z4124e043ed[(z8acd4fa0c6+
z64f8d93415)&0xff]-z4124e043ed[(z8acd4fa0c6+zabdc291adf)&0xff];}__kernel void
z1b92ecfe7a(__global ushort4*zf8d9fd6cb8,__global ushort4*z718a062ddd,int8
z30eaaf69b7,int z2824fcf57d,int z9562068e13,int2 zf09eb81885,const int
z6649b418da,__constant uchar*z2069498e76,__constant uchar*zca451f09f4,__constant
 za6c557b086*z4124e043ed){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id
(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;
int2 z733ab70e0a=zba94ee46da+zf09eb81885;int2 z83640e5796=zba94ee46da+
z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;const int
z38d5e777b6=16;ushort4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*
z2824fcf57d];int z49cb77b4dc=z733ab70e0a.x;int z2523506dd2=z733ab70e0a.y;
za6c557b086 z48b640b98b=z061a86f68a((z49cb77b4dc&(~1)),z2523506dd2,z2069498e76,
zca451f09f4,z4124e043ed);
z51b7908a0d z77c46cf647=(z49cb77b4dc&1)?z48b640b98b>>16:z48b640b98b&0xffff;
int zd0615a467f=z77c46cf647>>8;
int z79ab751a59=z77c46cf647&0xff;

int zfd43e2fb77=((zd0615a467f*z6649b418da)>>z38d5e777b6)-((z79ab751a59*
z6649b418da)>>z38d5e777b6);
int4 z205d564e2f=convert_int4(z493deefb55)+(int4)zfd43e2fb77;z493deefb55=
convert_ushort4_sat(z205d564e2f);z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*
z9562068e13]=z493deefb55;}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
