#define z3dbd1ff682 2
typedef uint za6c557b086;typedef ushort z51b7908a0d;
#define __INLINE__ inline
#define MIN min
#define MAX max
#define zed8b49ee23 		16
#define zd3e3eedb0a 	 32767
#define z12cbbf15c0					65535
#ifndef z93a6893130
#define z38c913a03a 0
#else
#define z38c913a03a z93a6893130
#endif
__INLINE__ z51b7908a0d z5e89fa040b(z51b7908a0d x){const z51b7908a0d z08ef030ac3=
(z51b7908a0d)(65535*0.6959290);const z51b7908a0d z7e674d442a=(z51b7908a0d)(65535
*0.2249460);const z51b7908a0d z136720eb4b=(z51b7908a0d)(65535*0.0791254);
z51b7908a0d z6cc366383f=(x&0xFFF);
z51b7908a0d zf53ecc0c10=(x>>12);

za6c557b086 zc9d80d25d3=1<<(zf53ecc0c10);
za6c557b086 z997ede1cab=z6cc366383f<<4;za6c557b086 z3d8ee63fd8=(z997ede1cab*
z997ede1cab)>>16;za6c557b086 z143339fb90=(z3d8ee63fd8*z997ede1cab)>>16;
za6c557b086 z61717442fa=((z08ef030ac3*z997ede1cab)>>16)+((z7e674d442a*
z3d8ee63fd8)>>16)+((z136720eb4b*z143339fb90)>>16);z61717442fa=(zc9d80d25d3*
z61717442fa)>>16;x=(zc9d80d25d3+z61717442fa);x=MIN(x,(z51b7908a0d)0xFFFF);return
 x;}
__INLINE__ z51b7908a0d z84b9fa11d0(za6c557b086 x){z51b7908a0d z52ab5b652a=
convert_ushort(x);z51b7908a0d zc1a7596d5d=65536-4096;if(z52ab5b652a<(1<<8)){
zc1a7596d5d=zc1a7596d5d-8*4096;z52ab5b652a=(z52ab5b652a<<8);}if(z52ab5b652a<(1<<
12)){zc1a7596d5d=zc1a7596d5d-4*4096;z52ab5b652a=(z52ab5b652a<<4);}if(z52ab5b652a
<(1<<14)){zc1a7596d5d=zc1a7596d5d-2*4096;z52ab5b652a=(z52ab5b652a<<2);}if(
z52ab5b652a<(1<<15)){zc1a7596d5d=zc1a7596d5d-1*4096;z52ab5b652a=(z52ab5b652a<<1)
;}
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
__kernel void z33f221006d(__global ushort4*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,__global ushort*
z2bd48d41f6,int4 z54b66a4e3e,__global ushort*z068c6cb297,int4 z8f6dacacc9){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;uint4 z395b96baac=convert_uint4(zf8d9fd6cb8[
z83640e5796.x+z83640e5796.y*z2824fcf57d]);const int z860092406f=z9562068e13;
__global ushort*zc86f602154=z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.s1*
z860092406f;const int z15e5f81573=z54b66a4e3e.s2;__global ushort*z5f9ee22bd9=
z2bd48d41f6+z54b66a4e3e.x+z54b66a4e3e.y*z15e5f81573;const int zac050f33fc=
z8f6dacacc9.s2;__global ushort*ze0f99cbd8e=z068c6cb297+z8f6dacacc9.x+z8f6dacacc9
.y*zac050f33fc;const int x=zba94ee46da.x;const int y=zba94ee46da.y;za6c557b086
zd576e0c0da=z395b96baac.x;
za6c557b086 z620a8801dd=z395b96baac.y;
zc86f602154[x+y*z860092406f]=zd576e0c0da;z620a8801dd=MIN((za6c557b086)
z12cbbf15c0,(z620a8801dd+zed8b49ee23));zd576e0c0da=MIN((za6c557b086)z12cbbf15c0,
(zd576e0c0da+zed8b49ee23));z5f9ee22bd9[x+y*z15e5f81573]=z84b9fa11d0(z620a8801dd)
;ze0f99cbd8e[x+y*zac050f33fc]=z84b9fa11d0(zd576e0c0da);}
#endif
#if (z3dbd1ff682==1)
__kernel void z33f221006d(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,__global ushort*
za4c3faf083,int4 zad88b44b72,__global ushort*z6df6a80d10,int4 z6e7dca6d84,
__global ushort*zd3b08394a9,int4 za2be284b26,__global ushort*z5bd44f774b,int4
zb852268dcd,__global ushort*za587b73fe4,int4 zeb578396dc){int2 zba94ee46da=(int2
)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;const int z45c01651ac=z2824fcf57d;__global
ushort*zba15fb8bb8=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*z45c01651ac;const
int z1d3a257ea4=z9562068e13;__global ushort*z899315f460=z718a062ddd+z30eaaf69b7.
s0+z30eaaf69b7.s1*z1d3a257ea4;const int zb6ea147856=zad88b44b72.s2;__global
ushort*z19affe52ae=za4c3faf083+zad88b44b72.x+zad88b44b72.y*zb6ea147856;const int
 zb2394e8127=z6e7dca6d84.s2;__global ushort*zf0507ee3f7=z6df6a80d10+z6e7dca6d84.
x+z6e7dca6d84.y*zb2394e8127;const int z87cd6f832a=za2be284b26.s2;__global ushort
*zf4152b2a29=zd3b08394a9+za2be284b26.x+za2be284b26.y*z87cd6f832a;const int
za8ae444e2b=zb852268dcd.s2;__global ushort*z07c0c4e340=z5bd44f774b+zb852268dcd.x
+zb852268dcd.y*za8ae444e2b;const int z3b0811e40b=zeb578396dc.s2;__global ushort*
z0127971638=za587b73fe4+zeb578396dc.x+zeb578396dc.y*z3b0811e40b;const int x=
zba94ee46da.x;const int y=zba94ee46da.y;za6c557b086 z5083031dab=convert_uint(
zba15fb8bb8[x+y*z45c01651ac]);za6c557b086 z305d891f1d=convert_uint(z899315f460[x
+y*z1d3a257ea4]);z19affe52ae[x+y*zb6ea147856]=convert_ushort(z5083031dab);
zf0507ee3f7[x+y*zb2394e8127]=convert_ushort(z305d891f1d);zf4152b2a29[x+y*
z87cd6f832a]=convert_ushort((z5083031dab*z5083031dab)>>16);z07c0c4e340[x+y*
za8ae444e2b]=convert_ushort((z5083031dab*z305d891f1d)>>16);z0127971638[x+y*
z3b0811e40b]=convert_ushort((z305d891f1d*z305d891f1d)>>16);}
#endif
#if (z3dbd1ff682==2)
__kernel void z33f221006d(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float8 zfb81b1b9ea,
__global ushort*zd3b08394a9,int4 za2be284b26,__global ushort*z5bd44f774b,int4
zb852268dcd,__global ushort*za587b73fe4,int4 zeb578396dc){int2 zba94ee46da=(int2
)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;const int zb6ea147856=z2824fcf57d;__global
ushort*z19affe52ae=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*zb6ea147856;const
int zb2394e8127=z9562068e13;__global ushort*zf0507ee3f7=z718a062ddd+z30eaaf69b7.
s0+z30eaaf69b7.s1*zb2394e8127;const int z87cd6f832a=za2be284b26.s2;__global
ushort*zf4152b2a29=zd3b08394a9+za2be284b26.x+za2be284b26.y*z87cd6f832a;const int
 za8ae444e2b=zb852268dcd.s2;__global ushort*z07c0c4e340=z5bd44f774b+zb852268dcd.
x+zb852268dcd.y*za8ae444e2b;const int z3b0811e40b=zeb578396dc.s2;__global ushort
*z0127971638=za587b73fe4+zeb578396dc.x+zeb578396dc.y*z3b0811e40b;const float
z4e441f596b=zfb81b1b9ea.s0;const float z73d05c17ee=zfb81b1b9ea.s1;const float
z19ccc1222b=zfb81b1b9ea.s2;const float z4c75307383=zfb81b1b9ea.s3;const float
zdc4702b894=zfb81b1b9ea.s4;const float z0d952d9cc7=zfb81b1b9ea.s5;const int x=
zba94ee46da.x;const int y=zba94ee46da.y;float z803e210ed0=convert_float(
z19affe52ae[x+y*zb6ea147856]);float z168e07ffbc=convert_float(zf0507ee3f7[x+y*
zb2394e8127]);float z60ff5a48f9=convert_float(z12cbbf15c0+(convert_uint(
zf4152b2a29[x+y*z87cd6f832a])<<16));float za53fea7a43=convert_float(z12cbbf15c0+
(convert_uint(z07c0c4e340[x+y*za8ae444e2b])<<16));float zb6c1b66053=
convert_float(z12cbbf15c0+(convert_uint(z0127971638[x+y*z3b0811e40b])<<16));
float z0ae901da89=z60ff5a48f9-z803e210ed0*z803e210ed0;float zc619996eb8=
zb6c1b66053-z168e07ffbc*z168e07ffbc;float zf670cfebb3=za53fea7a43-z803e210ed0*
z168e07ffbc;float z08ef030ac3=((z73d05c17ee*z4e441f596b)*(z0ae901da89+
z19ccc1222b)+z19ccc1222b*zf670cfebb3)/((zc619996eb8+z73d05c17ee)*(z0ae901da89+
z19ccc1222b)-zf670cfebb3*zf670cfebb3);
z08ef030ac3=MAX(z08ef030ac3,0.f);z08ef030ac3=MIN(z08ef030ac3,3.999f);float w=(
z0ae901da89-z08ef030ac3*zf670cfebb3)/(z0ae901da89+MIN(1.f,z08ef030ac3)*
z19ccc1222b);w=MAX(w,0.f);w=MIN(w,3.999f);float z7e674d442a=z803e210ed0*(1.f-w)-
z08ef030ac3*z168e07ffbc;z7e674d442a=z7e674d442a*zdc4702b894+zd3e3eedb0a;

z19affe52ae[x+y*zb6ea147856]=convert_ushort_sat(z08ef030ac3*z4c75307383);
zf0507ee3f7[x+y*zb2394e8127]=convert_ushort_sat(z7e674d442a);zf4152b2a29[x+y*
z87cd6f832a]=convert_ushort_sat(w*z0d952d9cc7);}
#endif
#if (z3dbd1ff682==4)
__kernel void z33f221006d(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,__global ushort*
za4c3faf083,int4 zad88b44b72,__global ushort*z6df6a80d10,int4 z6e7dca6d84,
__global ushort*zd3b08394a9,int4 za2be284b26){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;const int z710c07c058=z2824fcf57d;__global ushort*
z29021ac0ec=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.s5*z710c07c058;const int
z1d3a257ea4=z9562068e13;__global ushort*z899315f460=z718a062ddd+z30eaaf69b7.s0+
z30eaaf69b7.s1*z1d3a257ea4;const int zb6ea147856=zad88b44b72.s2;__global ushort*
z19affe52ae=za4c3faf083+zad88b44b72.x+zad88b44b72.y*zb6ea147856;const int
zb2394e8127=z6e7dca6d84.s2;__global ushort*zf0507ee3f7=z6df6a80d10+z6e7dca6d84.x
+z6e7dca6d84.y*zb2394e8127;const int z87cd6f832a=za2be284b26.s2;__global ushort*
zf4152b2a29=zd3b08394a9+za2be284b26.x+za2be284b26.y*z87cd6f832a;const int x=
zba94ee46da.x;const int y=zba94ee46da.y;za6c557b086 z08ef030ac3=convert_uint(
z19affe52ae[x+y*zb6ea147856]);int z7e674d442a=convert_int(zf0507ee3f7[x+y*
zb2394e8127])-zd3e3eedb0a;za6c557b086 W=convert_uint(zf4152b2a29[x+y*z87cd6f832a
]);za6c557b086 z96f44ff8b2=convert_uint(z899315f460[x+y*z1d3a257ea4]);
za6c557b086 z8ad2af685d=convert_uint(z29021ac0ec[x+y*z710c07c058]);int
z96a2929ccd=(((z08ef030ac3*z96f44ff8b2)+(W*z8ad2af685d))>>(14+3))+z7e674d442a;
z96a2929ccd=z96a2929ccd*8;z29021ac0ec[x+y*z710c07c058]=convert_ushort_sat(
z96a2929ccd);}
#endif
#if (z3dbd1ff682==3)
__kernel void z33f221006d(__global ushort*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,uint2 zfb81b1b9ea,
__global ushort*z068c6cb297,int4 z8f6dacacc9,__global ushort*z87e8da7987,int4
z6ad7d61954,__global ushort*z8ade1c6c19,int4 z7a9bb7a861){int2 zba94ee46da=(int2
)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;

const int zb41a4b7008=4*z9562068e13;__global ushort*zafac32c58b=(__global ushort
*)z718a062ddd+4*z30eaaf69b7.s0+z30eaaf69b7.s1*zb41a4b7008;

const int za4d0066122=z8f6dacacc9.s2;__global ushort*ze0f99cbd8e=z068c6cb297+
z8f6dacacc9.x+z8f6dacacc9.y*za4d0066122;const int zdf7c21e7e4=z6ad7d61954.s2;
__global ushort*z0c70c6e535=z87e8da7987+z6ad7d61954.x+z6ad7d61954.y*zdf7c21e7e4;
int2 z62e897781c=z7a9bb7a861.xy;int zb4cba240ea=z7a9bb7a861.z;__global ushort*
z538c0ea2b1=z8ade1c6c19+z62e897781c.x+z62e897781c.y*zb4cba240ea;bool z69caec77fd
=z7a9bb7a861.w!=0;const int x=zba94ee46da.x;const int y=zba94ee46da.y;
const za6c557b086 z4f88dba714=zfb81b1b9ea.s0;const za6c557b086 zd30ddce833=
zfb81b1b9ea.s1;za6c557b086 z4633c865c6;za6c557b086 za65f67c891=ze0f99cbd8e[x+y*
za4d0066122];za6c557b086 zbffecdf55d=z0c70c6e535[x+y*zdf7c21e7e4];if(!
z69caec77fd){z4633c865c6=(zbffecdf55d*z4f88dba714+za65f67c891*zd30ddce833)/65536
;z4633c865c6=z5e89fa040b(convert_ushort(z4633c865c6));}else{za6c557b086
z2307f10b1c=convert_uint(z538c0ea2b1[x+y*zb4cba240ea]);
z4633c865c6=(zbffecdf55d*z2307f10b1c+za65f67c891*((1<<12)-z2307f10b1c))>>12;
z4633c865c6=z5e89fa040b(z4633c865c6);}
z4633c865c6=(z4633c865c6>zed8b49ee23)?z4633c865c6-zed8b49ee23:0;


zafac32c58b[y*zb41a4b7008+4*x+0]=convert_ushort_sat(z4633c865c6);}
#endif
#if (z3dbd1ff682==5)
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
return 0;}__kernel void z33f221006d(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z745057f086,uint z258a407c2d,
__global uchar*zec145e35cf,int16 z7f76fb323c,int4 z3576e84f20,uint16 zd8b21bfb9c
){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 z9b046bc3a1=zba94ee46da+z3576e84f20.s01;int
zfcaa177308=z3576e84f20.s2;int z98cd6733c3=z9b046bc3a1.x+z9b046bc3a1.y*
zfcaa177308;int*z6016b79538=(int*)&z7f76fb323c;uint16 z305c8a97dc;uint*
zbd7b15dc4f=(uint*)&z305c8a97dc;for(int z1d8bd19892=0;z1d8bd19892<z38c913a03a;
z1d8bd19892++)zbd7b15dc4f[z1d8bd19892]=convert_uint(z6016b79538[z1d8bd19892]>=0?
zec145e35cf[z98cd6733c3+z6016b79538[z1d8bd19892]]:0);uint zec2cea3690=
z6d7333005c(zd8b21bfb9c,z305c8a97dc)/256;zf8d9fd6cb8[z83640e5796.x+z83640e5796.y
*z021babbfad]=convert_ushort_sat(zec2cea3690+z258a407c2d);}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
