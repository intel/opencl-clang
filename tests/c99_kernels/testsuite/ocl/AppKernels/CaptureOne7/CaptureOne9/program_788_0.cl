#define z3dbd1ff682 13
#define z93a6893130 16
typedef uint za6c557b086;typedef ushort z51b7908a0d;
#define __INLINE__ inline
#define MIN min
#define MAX max
#define zed8b49ee23 		16
#define zd3e3eedb0a 	 32767
#define z12cbbf15c0					65535
#define z93187ccfd7 exp2
#ifndef z93a6893130
#define z38c913a03a 0
#else
#define z38c913a03a z93a6893130
#endif
__INLINE__ z51b7908a0d zf463e0ea09(z51b7908a0d x){z51b7908a0d z52ab5b652a=x;
z51b7908a0d zc1a7596d5d=61440;if(z52ab5b652a<(1<<8)){zc1a7596d5d=zc1a7596d5d-8*
4096;z52ab5b652a=(z52ab5b652a<<8);}if(z52ab5b652a<(1<<12)){zc1a7596d5d=
zc1a7596d5d-4*4096;z52ab5b652a=(z52ab5b652a<<4);}if(z52ab5b652a<(1<<14)){
zc1a7596d5d=zc1a7596d5d-2*4096;z52ab5b652a=(z52ab5b652a<<2);}if(z52ab5b652a<(1<<
15)){zc1a7596d5d=zc1a7596d5d-1*4096;z52ab5b652a=(z52ab5b652a<<1);}
z51b7908a0d z0bfca2daed=(z52ab5b652a&0x7FFF)>>3;z52ab5b652a=zc1a7596d5d+
z0bfca2daed;return z52ab5b652a;}__INLINE__ z51b7908a0d z5e89fa040b(z51b7908a0d x
){const z51b7908a0d z08ef030ac3=(z51b7908a0d)(65535*0.6959290);const z51b7908a0d
 z7e674d442a=(z51b7908a0d)(65535*0.2249460);const z51b7908a0d z136720eb4b=(
z51b7908a0d)(65535*0.0791254);z51b7908a0d z6cc366383f=(x&0xFFF);
z51b7908a0d zf53ecc0c10=(x>>12);

za6c557b086 zc9d80d25d3=1<<(zf53ecc0c10);
za6c557b086 z997ede1cab=z6cc366383f<<4;za6c557b086 z3d8ee63fd8=(z997ede1cab*
z997ede1cab)>>16;za6c557b086 z143339fb90=(z3d8ee63fd8*z997ede1cab)>>16;
za6c557b086 z61717442fa=((z08ef030ac3*z997ede1cab)>>16)+((z7e674d442a*
z3d8ee63fd8)>>16)+((z136720eb4b*z143339fb90)>>16);z61717442fa=(zc9d80d25d3*
z61717442fa)>>16;x=(zc9d80d25d3+z61717442fa);x=MIN(x,(z51b7908a0d)0xFFFF);return
 x;}
__INLINE__ z51b7908a0d z84b9fa11d0(z51b7908a0d z52ab5b652a){
z51b7908a0d zc1a7596d5d=65536-4096;if(z52ab5b652a<(1<<8)){zc1a7596d5d=
zc1a7596d5d-8*4096;z52ab5b652a=(z52ab5b652a<<8);}if(z52ab5b652a<(1<<12)){
zc1a7596d5d=zc1a7596d5d-4*4096;z52ab5b652a=(z52ab5b652a<<4);}if(z52ab5b652a<(1<<
14)){zc1a7596d5d=zc1a7596d5d-2*4096;z52ab5b652a=(z52ab5b652a<<2);}if(z52ab5b652a
<(1<<15)){zc1a7596d5d=zc1a7596d5d-1*4096;z52ab5b652a=(z52ab5b652a<<1);}
const float ze7168fc0b9=0.158958f;const float zc180b9cdc9=2.654987f;const
za6c557b086 z842f1c9b69=convert_uint(convert_ushort((65536/2)*(1.0f+ze7168fc0b9*
zc180b9cdc9)));const za6c557b086 ze5a637a73c=convert_uint(convert_ushort((65536/
2)*(ze7168fc0b9+ze7168fc0b9*zc180b9cdc9)));
const za6c557b086 ze7197c4a18=convert_uint(convert_ushort((65536/2)*ze7168fc0b9)
);za6c557b086 z997ede1cab=convert_uint(z52ab5b652a-(1<<15))*2;za6c557b086
z3d8ee63fd8=(z997ede1cab*z997ede1cab)>>16;za6c557b086 z143339fb90=(z3d8ee63fd8*
z997ede1cab)>>16;z997ede1cab=(z997ede1cab*z842f1c9b69)>>16;z3d8ee63fd8=(
z3d8ee63fd8*ze5a637a73c)>>16;z143339fb90=(z143339fb90*ze7197c4a18)>>16;
int z0bfca2daed=(z997ede1cab-z3d8ee63fd8);z0bfca2daed=(z0bfca2daed+z143339fb90);
z0bfca2daed=(z0bfca2daed>>3);z52ab5b652a=zc1a7596d5d+z0bfca2daed;return
z52ab5b652a;}
#if (z3dbd1ff682==0)
uint z6d7333005c(uint16 z2dd09f3226,uint16 za3158292ce){
#if   (z38c913a03a==16)
return(z2dd09f3226.s0*za3158292ce.s0+z2dd09f3226.s1*za3158292ce.s1+z2dd09f3226.
s2*za3158292ce.s2+z2dd09f3226.s3*za3158292ce.s3+z2dd09f3226.s4*za3158292ce.s4+
z2dd09f3226.s5*za3158292ce.s5+z2dd09f3226.s6*za3158292ce.s6+z2dd09f3226.s7*
za3158292ce.s7+z2dd09f3226.s8*za3158292ce.s8+z2dd09f3226.s9*za3158292ce.s9+
z2dd09f3226.sa*za3158292ce.sa+z2dd09f3226.sb*za3158292ce.sb+z2dd09f3226.sc*
za3158292ce.sc+z2dd09f3226.sd*za3158292ce.sd+z2dd09f3226.se*za3158292ce.se+
z2dd09f3226.sf*za3158292ce.sf);
#elif (z38c913a03a>10)
return(z2dd09f3226.s0*za3158292ce.s0+z2dd09f3226.s1*za3158292ce.s1+z2dd09f3226.
s2*za3158292ce.s2+z2dd09f3226.s3*za3158292ce.s3+z2dd09f3226.s4*za3158292ce.s4+
z2dd09f3226.s5*za3158292ce.s5+z2dd09f3226.s6*za3158292ce.s6+z2dd09f3226.s7*
za3158292ce.s7+z2dd09f3226.s8*za3158292ce.s8+z2dd09f3226.s9*za3158292ce.s9+
z2dd09f3226.sa*za3158292ce.sa+z2dd09f3226.sb*za3158292ce.sb);
#elif (z38c913a03a>8)
return(z2dd09f3226.s0*za3158292ce.s0+z2dd09f3226.s1*za3158292ce.s1+z2dd09f3226.
s2*za3158292ce.s2+z2dd09f3226.s3*za3158292ce.s3+z2dd09f3226.s4*za3158292ce.s4+
z2dd09f3226.s5*za3158292ce.s5+z2dd09f3226.s6*za3158292ce.s6+z2dd09f3226.s7*
za3158292ce.s7+z2dd09f3226.s8*za3158292ce.s8+z2dd09f3226.s9*za3158292ce.s9);
#elif (z38c913a03a>6)
return(z2dd09f3226.s0*za3158292ce.s0+z2dd09f3226.s1*za3158292ce.s1+z2dd09f3226.
s2*za3158292ce.s2+z2dd09f3226.s3*za3158292ce.s3+z2dd09f3226.s4*za3158292ce.s4+
z2dd09f3226.s5*za3158292ce.s5+z2dd09f3226.s6*za3158292ce.s6+z2dd09f3226.s7*
za3158292ce.s7);
#elif (z38c913a03a>4)
return(z2dd09f3226.s0*za3158292ce.s0+z2dd09f3226.s1*za3158292ce.s1+z2dd09f3226.
s2*za3158292ce.s2+z2dd09f3226.s3*za3158292ce.s3+z2dd09f3226.s4*za3158292ce.s4+
z2dd09f3226.s5*za3158292ce.s5);
#elif (z38c913a03a>2)
return(z2dd09f3226.s0*za3158292ce.s0+z2dd09f3226.s1*za3158292ce.s1+z2dd09f3226.
s2*za3158292ce.s2+z2dd09f3226.s3*za3158292ce.s3);
#elif (z38c913a03a>0)
return(z2dd09f3226.s0*za3158292ce.s0+z2dd09f3226.s1*za3158292ce.s1);
#endif
return 0;}__kernel void z2aad4cbf97(__global ushort2*zf8d9fd6cb8,__global
ushort2*z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,uint2
z258a407c2d,__global uchar*zec145e35cf,int16 z7f76fb323c,int4 z3576e84f20,uint16
 zc35ce21b15,uint16 z44d99589db){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.
s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 z9b046bc3a1=
zba94ee46da+z3576e84f20.s01;int zfcaa177308=z3576e84f20.s2;int z98cd6733c3=
z9b046bc3a1.x+z9b046bc3a1.y*zfcaa177308;int*z6016b79538=(int*)&z7f76fb323c;
uint16 z305c8a97dc;uint*zbd7b15dc4f=(uint*)&z305c8a97dc;for(int z1d8bd19892=0;
z1d8bd19892<z38c913a03a;z1d8bd19892++)zbd7b15dc4f[z1d8bd19892]=convert_uint(
z6016b79538[z1d8bd19892]>=0?zec145e35cf[z98cd6733c3+z6016b79538[z1d8bd19892]]:0)
;uint2 z55c265223f;z55c265223f.x=z6d7333005c(zc35ce21b15,z305c8a97dc);
z55c265223f.y=z6d7333005c(z44d99589db,z305c8a97dc);zf8d9fd6cb8[z83640e5796.x+
z83640e5796.y*z2824fcf57d]=convert_ushort2_sat((z55c265223f+z258a407c2d)/(uint2)
(16,16));}
#endif
#if (z3dbd1ff682==1)
__kernel void z2aad4cbf97(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int8 zfb81b1b9ea){
int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;const int z8bb9232d55=
zfb81b1b9ea.s0;const int z2dc6065a6b=zfb81b1b9ea.s1;const int z2a745c1e58=
zfb81b1b9ea.s2;const int ze86e6ffe6b=zfb81b1b9ea.s3;const int z9b6f87a4dc=
zfb81b1b9ea.s4;const int y=zba94ee46da.y;const int z5e5a965a46=z2824fcf57d;
__global ushort*z2eba5e6752=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*
z5e5a965a46;const int zb41a4b7008=z9562068e13;__global ushort*ze4351005bc=
z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.s1*zb41a4b7008;
int zc76328fcde=z2dc6065a6b+y*z2a745c1e58;zc76328fcde=MAX(zc76328fcde,0);
zc76328fcde=MIN(zc76328fcde,z9b6f87a4dc);
__global z51b7908a0d*z7775ced675=&z2eba5e6752[zc76328fcde*z5e5a965a46];const int
 x=zba94ee46da.x;
{int z6e11fe901b=z8bb9232d55+x*z2a745c1e58;z6e11fe901b=MAX(z6e11fe901b,0);
z6e11fe901b=MIN(z6e11fe901b,ze86e6ffe6b);ze4351005bc[x+y*zb41a4b7008]=
z7775ced675[z6e11fe901b];}}
#endif
#if (z3dbd1ff682==2)
__kernel void z2aad4cbf97(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13){int2 zba94ee46da=(
int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.
s45;__global ushort*z395b96baac=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*
z2824fcf57d;const int x=0;

z51b7908a0d zcc45dc6811=MAX(z395b96baac[x],(z51b7908a0d)1);zcc45dc6811=
z84b9fa11d0(zcc45dc6811);

z395b96baac[x]=zcc45dc6811;}
#endif
#if (z3dbd1ff682==3)
__kernel void z2aad4cbf97(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,uint z947d1a489d){
int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;__global ushort*z395b96baac=zf8d9fd6cb8+z83640e5796.
x+z83640e5796.y*z2824fcf57d;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;
__global ushort*ze4351005bc=z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*z9562068e13;
uint z5083031dab=convert_uint(z395b96baac[0]);ze4351005bc[0]=convert_ushort_sat(
((z5083031dab*z5083031dab)>>z947d1a489d));}
#endif
#if (z3dbd1ff682==4)
__kernel void z2aad4cbf97(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13){int2 zba94ee46da=(
int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.
s45;__global ushort*z395b96baac=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*
z2824fcf57d;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;__global ushort*
z10c89e6dd1=z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*z9562068e13;const int x=0;
int z4633c865c6=convert_int(z395b96baac[x])-convert_int(z10c89e6dd1[x]);
z10c89e6dd1[x]=convert_ushort_sat(abs(z4633c865c6));}
#endif
#if (z3dbd1ff682==5)
__kernel void z2aad4cbf97(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,__global ushort*
za2784c2b9d,int4 z67cb755dbd,uint2 zfb81b1b9ea){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;__global
ushort*z10c89e6dd1=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z2824fcf57d;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;__global ushort*z56b077df14=z718a062ddd+
zaaf414d14e.x+zaaf414d14e.y*z9562068e13;int2 z258e995ef2=zba94ee46da+z67cb755dbd
.s01;__global ushort*z6501767b14=za2784c2b9d+z258e995ef2.x+z258e995ef2.y*
z67cb755dbd.s2;const uint zf5435dc4ff=zfb81b1b9ea.x;const uint z758719f481=
zfb81b1b9ea.y;



const int x=0;{za6c557b086 z07b03f2ddc=convert_uint(z10c89e6dd1[x]);za6c557b086
zac03b8df64=(convert_uint(z6501767b14[x])<<16)-(z07b03f2ddc*z07b03f2ddc);
za6c557b086 z8f0bccc487=convert_uint(z56b077df14[x]);zac03b8df64=MIN(zac03b8df64
,z8f0bccc487<<(16-convert_uint(zf5435dc4ff)));za6c557b086 z08ef030ac3=
zac03b8df64/((zac03b8df64>>16)+convert_uint(z758719f481));
z08ef030ac3=MIN(z08ef030ac3+(z08ef030ac3>>3),(uint)z12cbbf15c0);za6c557b086
z7e674d442a=((1<<16)-z08ef030ac3)*z07b03f2ddc;z56b077df14[x]=convert_ushort_sat(
z08ef030ac3);z6501767b14[x]=convert_ushort_sat(z7e674d442a>>16);}}
#endif
#if (z3dbd1ff682==6)
__kernel void z2aad4cbf97(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float z4633c865c6){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;__global float*z395b96baac=zf8d9fd6cb8+z83640e5796.x
+z83640e5796.y*z2824fcf57d;z395b96baac[0]=z4633c865c6;}
#endif
#if (z3dbd1ff682==7)
__kernel void z2aad4cbf97(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,ushort z4633c865c6)
{int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;__global ushort*z395b96baac=zf8d9fd6cb8+z83640e5796.
x+z83640e5796.y*z2824fcf57d;z395b96baac[0]=z4633c865c6;}
#endif
#if (z3dbd1ff682==8)
__kernel void z2aad4cbf97(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,__global ushort*
za2784c2b9d,int4 z67cb755dbd){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.
s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;__global ushort*
z56b077df14=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z2824fcf57d;int2 zaaf414d14e
=zba94ee46da+z30eaaf69b7.s01;__global ushort*ze4351005bc=z718a062ddd+zaaf414d14e
.x+zaaf414d14e.y*z9562068e13;int2 z258e995ef2=zba94ee46da+z67cb755dbd.s01;
__global ushort*z6501767b14=za2784c2b9d+z258e995ef2.x+z258e995ef2.y*z67cb755dbd.
s2;
const int x=0;{za6c557b086 z08ef030ac3=convert_uint(z56b077df14[x]);za6c557b086
z7e674d442a=convert_uint(z6501767b14[x]);za6c557b086 zade6fd72f4=((convert_uint(
ze4351005bc[x])*z08ef030ac3)>>16)+z7e674d442a;
ze4351005bc[x]=convert_ushort_sat(zade6fd72f4);}}
#endif
#if (z3dbd1ff682==9)
__kernel void z2aad4cbf97(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=z30eaaf69b7.s45;__global float*
z9a9f4b7f55=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z2824fcf57d;int2 zaaf414d14e
=z30eaaf69b7.s01;__global float*z171ba455b1=z718a062ddd+zaaf414d14e.x+
zaaf414d14e.y*z9562068e13;int zcd46fa0173=z9562068e13;int zbee2a0cade=
z2824fcf57d;const int x=zba94ee46da.x;const int y=zba94ee46da.y;z9a9f4b7f55[(x+y
*zbee2a0cade)*2]=z171ba455b1[x+y*zcd46fa0173];}
#endif
#if (z3dbd1ff682==10)
__kernel void z2aad4cbf97(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float8 ze7168fc0b9){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
z30eaaf69b7.s45;__global float*z395b96baac=zf8d9fd6cb8+z83640e5796.x+z83640e5796
.y*z2824fcf57d;int2 zaaf414d14e=z30eaaf69b7.s01;__global float*ze4351005bc=
z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*z9562068e13;z395b96baac+=zba94ee46da.x+
zba94ee46da.y*z2824fcf57d;ze4351005bc+=zba94ee46da.x+zba94ee46da.y*z9562068e13;
const int x=0;const int step=1;float z7f07af22da=z395b96baac[x-2*step];float
zf86ef79cd2=z395b96baac[x-step];float z88dce4da4d=z395b96baac[x];float
ze552ad9329=z395b96baac[x+step];float zde5f679ba3=z395b96baac[x+2*step];float
z51eadf1cec=ze7168fc0b9.s4*z7f07af22da;z51eadf1cec+=ze7168fc0b9.s3*zf86ef79cd2;
z51eadf1cec+=ze7168fc0b9.s2*z88dce4da4d;z51eadf1cec+=ze7168fc0b9.s1*ze552ad9329;
z51eadf1cec+=ze7168fc0b9.s0*zde5f679ba3;ze4351005bc[x]=z51eadf1cec;}
#endif
#if (z3dbd1ff682==11)
__kernel void z2aad4cbf97(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float8 ze7168fc0b9){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;__global float*z395b96baac=zf8d9fd6cb8+z83640e5796.x
+z83640e5796.y*z2824fcf57d;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;__global
 float*ze4351005bc=z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*z9562068e13;const int
 x=0;const int step=z2824fcf57d;float z7f07af22da=z395b96baac[x-2*step];float
zf86ef79cd2=z395b96baac[x-step];float z88dce4da4d=z395b96baac[x];float
ze552ad9329=z395b96baac[x+step];float zde5f679ba3=z395b96baac[x+2*step];float
z51eadf1cec=ze7168fc0b9.s4*z7f07af22da;z51eadf1cec+=ze7168fc0b9.s3*zf86ef79cd2;
z51eadf1cec+=ze7168fc0b9.s2*z88dce4da4d;z51eadf1cec+=ze7168fc0b9.s1*ze552ad9329;
z51eadf1cec+=ze7168fc0b9.s0*zde5f679ba3;ze4351005bc[x]=z51eadf1cec;}
#endif
#if (z3dbd1ff682==12 || z3dbd1ff682==14 )
__kernel void z2aad4cbf97(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float2 z7c54807ee5,
__global float*z655021c839,int4 zff2a9dff15,__global float*zd9d7f5f29d,int4
z117741ce0c
#if (z3dbd1ff682==14)
,__global ushort2*z8ade1c6c19,int4 z7a9bb7a861
#endif
){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;__global float4*z395b96baac=zf8d9fd6cb8+z83640e5796.
x+z83640e5796.y*z2824fcf57d;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;
__global float4*ze4351005bc=z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*z9562068e13;
const float z5256350bbc=z7c54807ee5.x;const float z6f15bcbaa5=z7c54807ee5.y;int2
 z8cd49f4412=zba94ee46da+zff2a9dff15.s01;__global float*z33dafa19dd=z655021c839+
z8cd49f4412.x+z8cd49f4412.y*zff2a9dff15.s2;int2 zdac41b416a=zba94ee46da+
z117741ce0c.s01;__global float*z8dd6cecdd9=zd9d7f5f29d+zdac41b416a.x+zdac41b416a
.y*z117741ce0c.s2;const int x=0;




#if (z3dbd1ff682==14)
int2 z62e897781c=zba94ee46da+z7a9bb7a861.xy;int zb4cba240ea=z7a9bb7a861.z;
__global ushort2*z8b3fb6656c=z8ade1c6c19+z62e897781c.x+z62e897781c.y*zb4cba240ea
;float2 z3ca98273cc=convert_float2(z8b3fb6656c[x]);float ze8a99ddab8=z3ca98273cc
.x*(0.01f*16.f/255.f);float zbbe604567e=z3ca98273cc.y*(0.01f*16.f/255.f);float
zc15fc2c536=ze8a99ddab8*z33dafa19dd[x]+(1.f-ze8a99ddab8);float zb4c2e65587=
zbbe604567e/z8dd6cecdd9[x]+(1.f-zbbe604567e);
#else
float zc15fc2c536=z6f15bcbaa5*z33dafa19dd[x]+(1.f-z6f15bcbaa5);float zb4c2e65587
=z5256350bbc/z8dd6cecdd9[x]+(1.f-z5256350bbc);
#endif



float z86dd029962=zc15fc2c536/zb4c2e65587;ze4351005bc[x]=z395b96baac[x]*(float4)
z86dd029962;}
#endif
#if (z3dbd1ff682==13)
__kernel void z2aad4cbf97(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float z0bd342105f,
__global float*z655021c839,int4 zff2a9dff15,__global float*zd9d7f5f29d,int4
z117741ce0c,__constant float*za59a697454,__constant float*z2760075321,__constant
 float*z9301e4e0f3,__constant float*zb819b53bf6){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;__global
ushort*z1fa6f91af2=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z2824fcf57d;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;__global ushort*z7f3194e771=z718a062ddd+
zaaf414d14e.x+zaaf414d14e.y*z9562068e13;int2 z8cd49f4412=zba94ee46da+zff2a9dff15
.s01;__global float*z52ff0efadb=z655021c839+z8cd49f4412.x+z8cd49f4412.y*
zff2a9dff15.s2;int2 zdac41b416a=zba94ee46da+z117741ce0c.s01;__global float*
z388bca4fc1=zd9d7f5f29d+zdac41b416a.x+zdac41b416a.y*z117741ce0c.s2;




const int x=0;{int z7e68956b16=convert_int(z1fa6f91af2[x]);int z99e3d023d3=
convert_int(z7f3194e771[x]);float z7c61017b09=convert_float(z7e68956b16-
z99e3d023d3);
int ze414080db5=z99e3d023d3-convert_int(z0bd342105f*convert_float(z12cbbf15c0));
ze414080db5=ze414080db5*256+(128*z12cbbf15c0);ze414080db5=MAX(ze414080db5,0);
za6c557b086 za0c878a51d=ze414080db5>>16;
za0c878a51d=MIN(za0c878a51d,(uint)255);za6c557b086 z1c01422ffb=za0c878a51d+1;

za6c557b086 z1ba94d11f9=ze414080db5&z12cbbf15c0;float z716146ae96=(float)
z1ba94d11f9*(1.f/65536.f);float zc15fc2c536=za59a697454[za0c878a51d]*(1.f-
z716146ae96)+za59a697454[z1c01422ffb]*z716146ae96;float zb4c2e65587=z9301e4e0f3[
za0c878a51d]*(1.f-z716146ae96)+z9301e4e0f3[z1c01422ffb]*z716146ae96;float
ze07d570690=z2760075321[za0c878a51d]*(1.f-z716146ae96)+z2760075321[z1c01422ffb]*
z716146ae96;float zd8318a5277=zb819b53bf6[za0c878a51d]*(1.f-z716146ae96)+
zb819b53bf6[z1c01422ffb]*z716146ae96;float z305f1dbdc6=z93187ccfd7(z7c61017b09*
ze07d570690);float z09c2123d65=z93187ccfd7(z7c61017b09*zd8318a5277);z52ff0efadb[
x]=zc15fc2c536*z305f1dbdc6;z388bca4fc1[x]=zb4c2e65587*z09c2123d65;}}
#endif
#if (z3dbd1ff682==15)
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
}return z7d07bb3247;}float z9369a44638(float x,__constant float4*zcb1b02776b,int
 zd5275ae723){


int z7d07bb3247=z07f76dfe04(x,0,zd5275ae723-1,zcb1b02776b);int zbf32ff9ae0=
z7d07bb3247+1;float4 za851db5bb7=zcb1b02776b[z7d07bb3247];float4 z9aac9b026f=
zcb1b02776b[zbf32ff9ae0];float zc180b9cdc9=za851db5bb7.x,za3584c0652=za851db5bb7
.y,z16e127a2c9=za851db5bb7.z;float z35bf29e99b=z9aac9b026f.x,z1a6f4c4c08=
z9aac9b026f.y,z635f0a0757=z9aac9b026f.z;
float z52ab5b652a=z35bf29e99b-zc180b9cdc9;if(fabs(z52ab5b652a)<0.0001f)return((
za3584c0652+z1a6f4c4c08)+(x-zc180b9cdc9)*(z16e127a2c9+z635f0a0757))*0.5f;
float z56807b5599=(x-zc180b9cdc9)/z52ab5b652a;float z3e7daabbc6=z56807b5599-1.0f
;
float z99cf4fd6fe=z56807b5599*z56807b5599*(z1a6f4c4c08-za3584c0652)*(3.0f-2.0f*
z56807b5599)+za3584c0652;float z593fa3cb41=(z16e127a2c9*z3e7daabbc6+z635f0a0757*
z56807b5599)*z56807b5599*z3e7daabbc6*z52ab5b652a;float y=z99cf4fd6fe+z593fa3cb41
;return y;}
#define z121e64db3b sqrt
__kernel void z2aad4cbf97(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z45c01651ac,int z9562068e13,int2 zb78e1f8f0a,
float2 zf897261185,float z6df7ccb0a4,__constant float4*z526ad5087b,int
za2be633d70){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;const int x=
zba94ee46da.x;const int y=zba94ee46da.y;const float z4f54fb944c=zf897261185.x;
const float z03b4733edc=zf897261185.y;const int z39f1535455=zb78e1f8f0a.x;const
int z9528763067=zb78e1f8f0a.y;__global ushort*ze4351005bc=z718a062ddd+
z30eaaf69b7.s0+(z30eaaf69b7.s1+y)*z9562068e13;

float ze31f5244df=z6df7ccb0a4*convert_float(z39f1535455+x*2)-z4f54fb944c;float
zbf0eff9685=z6df7ccb0a4*convert_float(z9528763067+y*2)-z03b4733edc;float
z568715c0ca=z121e64db3b(ze31f5244df*ze31f5244df+zbf0eff9685*zbf0eff9685);

float zcf626b3ff6=z9369a44638(z568715c0ca,z526ad5087b,za2be633d70);
float z833bd266ce=-zcf626b3ff6*4096.f;
int z96a2929ccd=convert_int(ze4351005bc[x])+convert_int(z833bd266ce);

ze4351005bc[x]=convert_ushort_sat(z96a2929ccd);}
#endif
#if (z3dbd1ff682 == 16)
__kernel void z2aad4cbf97(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z45c01651ac,int z9562068e13,int8 z3c63f15248,
float8 zabf72d7f49,__global float4*z97dbb0fc36){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;const int x=zba94ee46da.x;const int y=zba94ee46da.y;
const int zd1ed3ad5e0=z3c63f15248.s0;const int z600d9b6a25=z3c63f15248.s1;const
int z39f1535455=z3c63f15248.s2;const int z9528763067=z3c63f15248.s3;const int
zc0d781c351=z3c63f15248.s4;const float z6df7ccb0a4=zabf72d7f49.s0;const float
z55c265223f=zabf72d7f49.s1;const float z9a39af7e0e=zabf72d7f49.s2;const float
zdb58105f17=zabf72d7f49.s3;const float zed43525c26=zabf72d7f49.s4;const float
z857679e39d=zabf72d7f49.s5;const float z9f5c0d9c3f=zabf72d7f49.s6;__global
ushort*ze4351005bc=z718a062ddd+z30eaaf69b7.s0+(z30eaaf69b7.s1+y)*z9562068e13;

float ze31f5244df=z6df7ccb0a4*convert_float(z39f1535455+x*2)-z857679e39d;float
zbf0eff9685=z6df7ccb0a4*convert_float(z9528763067+y*2)-z9f5c0d9c3f;
float z895b87c65d=ze31f5244df*(1.0f/zdb58105f17);float ze895423148=zbf0eff9685*(
1.0f/zed43525c26);
int z32f37e29d7=convert_int(floor(z895b87c65d));int zbaf2748fed=convert_int(
floor(ze895423148));if(z32f37e29d7<0)z32f37e29d7=0;if(z32f37e29d7>zd1ed3ad5e0-2)
z32f37e29d7=zd1ed3ad5e0-2;if(zbaf2748fed<0)zbaf2748fed=0;if(zbaf2748fed>
z600d9b6a25-2)zbaf2748fed=z600d9b6a25-2;int z6bc2432b71=(z32f37e29d7+0)+(
zbaf2748fed+0)*zd1ed3ad5e0;int z2637e46901=(z32f37e29d7+1)+(zbaf2748fed+0)*
zd1ed3ad5e0;int z48cb11db8d=(z32f37e29d7+0)+(zbaf2748fed+1)*zd1ed3ad5e0;int
z36aa834a68=(z32f37e29d7+1)+(zbaf2748fed+1)*zd1ed3ad5e0;
float ze9339eed6c=z895b87c65d-convert_float(z32f37e29d7);float zddaada1939=1.0f-
ze9339eed6c;float z99040c5db9=ze895423148-convert_float(zbaf2748fed);float
zf7f7aaaa02=1.0f-z99040c5db9;
float4 z66eb7e7401=z97dbb0fc36[z6bc2432b71];float4 zb226bb23f4=z97dbb0fc36[
z2637e46901];float4 zfde9ace317=z97dbb0fc36[z48cb11db8d];float4 z5ed28e6c06=
z97dbb0fc36[z36aa834a68];
float zec7aae7a3b=z66eb7e7401.z;float z07bd4bfc55=zb226bb23f4.z;float
ze57fc3d318=zfde9ace317.z;float z8d13a50ad7=z5ed28e6c06.z;float zae22552573=
ze31f5244df-convert_float(z32f37e29d7)*zdb58105f17;float zc4519d190e=zbf0eff9685
-convert_float(zbaf2748fed)*zed43525c26;float zd424f4923b=z66eb7e7401.x*
zae22552573;float z239316a54f=z66eb7e7401.y*zc4519d190e;float z587af7cd31=
zb226bb23f4.x*(zae22552573-zdb58105f17);float z7cb500ea6a=zb226bb23f4.y*
zc4519d190e;float zc42f98d141=zfde9ace317.x*zae22552573;float z7448839200=
zfde9ace317.y*(zc4519d190e-zed43525c26);float z7847767e3c=z5ed28e6c06.x*(
zae22552573-zdb58105f17);float z2276e63f46=z5ed28e6c06.y*(zc4519d190e-
zed43525c26);
float zbae767834f=1.0f/zdb58105f17;float z9a112927fc=1.0f/zed43525c26;
zec7aae7a3b+=zd424f4923b*zbae767834f+z239316a54f*z9a112927fc;z07bd4bfc55+=
z587af7cd31*zbae767834f+z7cb500ea6a*z9a112927fc;ze57fc3d318+=zc42f98d141*
zbae767834f+z7448839200*z9a112927fc;z8d13a50ad7+=z7847767e3c*zbae767834f+
z2276e63f46*z9a112927fc;
float zf43f1ca64a=zec7aae7a3b*zf7f7aaaa02+ze57fc3d318*z99040c5db9;
float z3eecee7d95=z07bd4bfc55*zf7f7aaaa02+z8d13a50ad7*z99040c5db9;
float zcf626b3ff6=zf43f1ca64a*zddaada1939+z3eecee7d95*ze9339eed6c;
zcf626b3ff6=zcf626b3ff6*(1.0f/8192.0f);
float z833bd266ce=(z9a39af7e0e-zcf626b3ff6)*z55c265223f;if(z833bd266ce>3.0f){if(
zc0d781c351>0){
if(z833bd266ce>5.0f){z833bd266ce=4.0f;}else{float z52ab5b652a=z833bd266ce-3.0f;
z833bd266ce=z833bd266ce-0.25f*z52ab5b652a*z52ab5b652a;}}else{
z833bd266ce=3.0f;}}
z833bd266ce=z833bd266ce*4096.f;
int z96a2929ccd=convert_int(ze4351005bc[x])+convert_int(z833bd266ce);

ze4351005bc[x]=convert_ushort_sat(z96a2929ccd);}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
