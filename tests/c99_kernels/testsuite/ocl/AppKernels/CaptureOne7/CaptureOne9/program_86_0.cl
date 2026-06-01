#define z3dbd1ff682 3
typedef int zdba6b93f69;typedef uint za6c557b086;typedef ushort z51b7908a0d;
#define __INLINE__ inline
#define z4cf7f11883 inline
#define MIN min
#define MAX max
#define zed8b49ee23 		16
#define zd3e3eedb0a 	 32767
#define z12cbbf15c0					65535
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
z52ab5b652a;}z4cf7f11883 za6c557b086 z3b10f0a171(za6c557b086 z2dd09f3226,
za6c557b086 za3158292ce){return(((z2dd09f3226)+(za3158292ce)+1)/2);}z4cf7f11883
float z9f0278e73e(z51b7908a0d z2dd09f3226,z51b7908a0d za3158292ce){return
convert_float((convert_uint(z2dd09f3226)+convert_uint(za3158292ce)+1)/2);}
#if (z3dbd1ff682==0)
__kernel void zcf439563b5(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,za6c557b086
zb2bb80cc80){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;const int
z45c01651ac=z2824fcf57d;__global ushort*zba15fb8bb8=zf8d9fd6cb8+z30eaaf69b7.s4+
z30eaaf69b7.s5*z45c01651ac;const int zb41a4b7008=z9562068e13;__global ushort*
zddaa6f652d=z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.s1*zb41a4b7008;const int x=
zba94ee46da.x;const int y=zba94ee46da.y;za6c557b086 z4633c865c6=z3b10f0a171(
convert_uint(zba15fb8bb8[x+y*z45c01651ac]),zb2bb80cc80);zddaa6f652d[x+y*
zb41a4b7008]=z84b9fa11d0(z4633c865c6);}
#endif
#if (z3dbd1ff682==1)
__kernel void zcf439563b5(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13){int2 zba94ee46da=(
int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;__global ushort*z395b96baac=zf8d9fd6cb8+
z30eaaf69b7.s4+(z30eaaf69b7.s5+zba94ee46da.y)*z2824fcf57d;const int x=
zba94ee46da.x;
z51b7908a0d z4633c865c6=z5e89fa040b(z395b96baac[x]);z395b96baac[x]=z4633c865c6;}
#endif
#if (z3dbd1ff682==2)
__kernel void zcf439563b5(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int8 zfb81b1b9ea){
int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;const int z45c01651ac=z2824fcf57d;__global ushort*
zba15fb8bb8=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z45c01651ac;int2 zaaf414d14e
=zba94ee46da+z30eaaf69b7.s01;const int zb41a4b7008=z9562068e13;__global ushort*
zddaa6f652d=z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*zb41a4b7008;

const int z908a899bab=zfb81b1b9ea.s0;const int z842f1c9b69=zfb81b1b9ea.s1;const
int ze5a637a73c=zfb81b1b9ea.s2;const int z66bce7320d=zfb81b1b9ea.s3;const int
step=zfb81b1b9ea.s4;const int z2b634fbc4b=zfb81b1b9ea.s5;zdba6b93f69 z4633c865c6
=z908a899bab*convert_int(zba15fb8bb8[0]);z4633c865c6+=z842f1c9b69*(convert_int(
zba15fb8bb8[-step])+convert_int(zba15fb8bb8[step]));z4633c865c6+=ze5a637a73c*(
convert_int(zba15fb8bb8[-z2b634fbc4b])+convert_int(zba15fb8bb8[z2b634fbc4b]));
zddaa6f652d[0]=convert_ushort_sat(z4633c865c6/z66bce7320d);}
#endif
#if (z3dbd1ff682==3)
__kernel void zcf439563b5(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,__global ushort*
z183b3dcb4c,int4 z80f5c89694,int zd72c7cd02e){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int x=zba94ee46da.x;int y=zba94ee46da.y;const int
z45c01651ac=z2824fcf57d;const int z4effb6cc69=z9562068e13;const int z2c5645a135=
z80f5c89694.s2;__global z51b7908a0d*z395b96baac=zf8d9fd6cb8+z30eaaf69b7.s4+(
z30eaaf69b7.s5+y)*z45c01651ac;__global z51b7908a0d*zffe3bfa5e0=z718a062ddd+
z30eaaf69b7.s0+(z30eaaf69b7.s1+y)*z4effb6cc69;__global z51b7908a0d*z3033916ec2=
z183b3dcb4c+z80f5c89694.s0+(z80f5c89694.s1+y)*z2c5645a135;za6c557b086
zc20893b06d=convert_uint(z395b96baac[x-z45c01651ac]);za6c557b086 zb50ecc48f0=
convert_uint(z395b96baac[x-1]);za6c557b086 z42d7c57a56=convert_uint(z395b96baac[
x]);za6c557b086 z2e95bfd385=convert_uint(z395b96baac[x+1]);za6c557b086
z976c4c4519=convert_uint(z395b96baac[x+z45c01651ac]);
za6c557b086 ze37c1ce2bd=z3b10f0a171(zb50ecc48f0,z2e95bfd385);za6c557b086
zd57bfb9f94=z3b10f0a171(zc20893b06d,z976c4c4519);
za6c557b086 zaf38ae93a5=MAX(ze37c1ce2bd,z42d7c57a56);za6c557b086 z90ccf1b9c0=MAX
(zd57bfb9f94,z42d7c57a56);za6c557b086 z631d8f47c5=MIN(ze37c1ce2bd,z42d7c57a56);
za6c557b086 z5d67b670f6=MIN(zd57bfb9f94,z42d7c57a56);za6c557b086 z696edae02a=(
zaf38ae93a5-z631d8f47c5)+zd72c7cd02e;za6c557b086 zf411bdf53a=(z90ccf1b9c0-
z5d67b670f6)+zd72c7cd02e;


zffe3bfa5e0[x]=convert_ushort_sat(z696edae02a);z3033916ec2[x]=convert_ushort_sat
(zf411bdf53a);}
#endif
#if (z3dbd1ff682==4)
__kernel void zcf439563b5(__global ushort*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,__global ushort*
zaf2d7b2229,int4 z23a124eb78,__global ushort*z0b2bcf3c7c,int4 z4f06d7a38f,
__global ushort*z183b3dcb4c,int4 z80f5c89694){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;const int x=zba94ee46da.x*2;const int y=zba94ee46da.y*
2;const int z45c01651ac=z2824fcf57d;const int zb41a4b7008=z9562068e13;const int
z0b6cb751d4=z23a124eb78.s2;const int z4effb6cc69=z4f06d7a38f.s2;const int
z2c5645a135=z80f5c89694.s2;__global z51b7908a0d*z395b96baac=zf8d9fd6cb8+
z30eaaf69b7.s4+(z30eaaf69b7.s5+y)*z45c01651ac;__global ushort4*ze4351005bc=
z718a062ddd+z30eaaf69b7.s0+(z30eaaf69b7.s1+y)*zb41a4b7008;__global z51b7908a0d*
z2416fbcc28=zaf2d7b2229+z23a124eb78.s0+(z23a124eb78.s1+y)*z0b6cb751d4;__global
z51b7908a0d*zffe3bfa5e0=z0b2bcf3c7c+z4f06d7a38f.s0+(z4f06d7a38f.s1+y)*
z4effb6cc69;__global z51b7908a0d*z3033916ec2=z183b3dcb4c+z80f5c89694.s0+(
z80f5c89694.s1+y)*z2c5645a135;


z51b7908a0d zf676f3c90e=z395b96baac[x];z51b7908a0d z50476d8c40=z395b96baac[x+1];
z51b7908a0d z54f271389d=(z2416fbcc28[x]);z51b7908a0d ze2b2743c1a=(z2416fbcc28[x+
1]);float z6ba2e3231d=z9f0278e73e(z395b96baac[x-z45c01651ac],z395b96baac[x+
z45c01651ac]);float z7b940113a7=z9f0278e73e(z395b96baac[x-z45c01651ac-1],
z395b96baac[x+z45c01651ac-1]);float z99dc430100=z9f0278e73e(z395b96baac[x-
z45c01651ac+1],z395b96baac[x+z45c01651ac+1]);float zf06b5bee70=z9f0278e73e(
z395b96baac[x-1],z50476d8c40);float zcd5bebbd58=z9f0278e73e(zf676f3c90e,
z395b96baac[x+1+1]);float z743d1a3a1f=z9f0278e73e(z2416fbcc28[x-z0b6cb751d4],
z2416fbcc28[x+z0b6cb751d4]);float zdb3e608402=z9f0278e73e(z2416fbcc28[x-
z0b6cb751d4-1],z2416fbcc28[x+z0b6cb751d4-1]);float z104d7d0057=z9f0278e73e(
z2416fbcc28[x-z0b6cb751d4+1],z2416fbcc28[x+z0b6cb751d4+1]);float z728a11ff70=
z9f0278e73e(z2416fbcc28[x-1],ze2b2743c1a);float za342478133=z9f0278e73e(
z54f271389d,z2416fbcc28[x+1+1]);


{
za6c557b086 z696edae02a=MAX((za6c557b086)1,convert_uint(zffe3bfa5e0[x]));
za6c557b086 zf411bdf53a=MAX((za6c557b086)1,convert_uint(z3033916ec2[x]));float
z657e1a72e9,zde289c21d6;float ze4b052164b,z2e91460297,z7e674d442a;
{
z657e1a72e9=(float)zf411bdf53a;zde289c21d6=(float)z696edae02a;z657e1a72e9=
z657e1a72e9*z657e1a72e9*z657e1a72e9;zde289c21d6=zde289c21d6*zde289c21d6*
zde289c21d6;}
{float za9445b3cd5=zf06b5bee70*z657e1a72e9;float z2cbb0949ed=z6ba2e3231d*
zde289c21d6;float z3356f0b0e4=convert_float(z54f271389d)/((float)z728a11ff70*
z657e1a72e9+(float)z743d1a3a1f*zde289c21d6);float zfd84819d76=convert_float(
z54f271389d)/((float)zdb3e608402+(float)z104d7d0057);z2e91460297=((float)
za9445b3cd5+(float)z2cbb0949ed)*z3356f0b0e4;z7e674d442a=((float)z7b940113a7+(
float)z99dc430100)*zfd84819d76;}



ushort4 z194e3d317e;z194e3d317e.s0=zf676f3c90e;z194e3d317e.s1=convert_ushort_sat
(z2e91460297);z194e3d317e.s2=convert_ushort_sat(z7e674d442a);ze4351005bc[x]=
z194e3d317e;


{float z892e795d04=convert_float(ze2b2743c1a)/(float)(za342478133);float
zfd84819d76=convert_float(ze2b2743c1a)/(float)(z104d7d0057);ze4b052164b=
zcd5bebbd58*z892e795d04;z7e674d442a=z99dc430100*zfd84819d76;}



z194e3d317e.s0=convert_ushort_sat(ze4b052164b);z194e3d317e.s1=z50476d8c40;
z194e3d317e.s2=convert_ushort_sat(z7e674d442a);ze4351005bc[x+1]=z194e3d317e;}


z395b96baac+=z45c01651ac;ze4351005bc+=zb41a4b7008;z2416fbcc28+=z0b6cb751d4;
zffe3bfa5e0+=z4effb6cc69;z3033916ec2+=z2c5645a135;


zf676f3c90e=z395b96baac[x];z50476d8c40=z395b96baac[x+1];z54f271389d=(z2416fbcc28
[x]);ze2b2743c1a=(z2416fbcc28[x+1]);z6ba2e3231d=z9f0278e73e(z395b96baac[x-
z45c01651ac],z395b96baac[x+z45c01651ac]);
float z6848451961=z9f0278e73e(z395b96baac[x-z45c01651ac+2],z395b96baac[x+
z45c01651ac+2]);z99dc430100=z9f0278e73e(z395b96baac[x-z45c01651ac+1],z395b96baac
[x+z45c01651ac+1]);zf06b5bee70=z9f0278e73e(z395b96baac[x-1],z50476d8c40);
zcd5bebbd58=z9f0278e73e(zf676f3c90e,z395b96baac[x+1+1]);z743d1a3a1f=z9f0278e73e(
z2416fbcc28[x-z0b6cb751d4],z2416fbcc28[x+z0b6cb751d4]);
float z9f0824b0d9=z9f0278e73e(z2416fbcc28[x-z0b6cb751d4+2],z2416fbcc28[x+
z0b6cb751d4+2]);z104d7d0057=z9f0278e73e(z2416fbcc28[x-z0b6cb751d4+1],z2416fbcc28
[x+z0b6cb751d4+1]);z728a11ff70=z9f0278e73e(z2416fbcc28[x-1],ze2b2743c1a);
za342478133=z9f0278e73e(z54f271389d,z2416fbcc28[x+1+1]);
{float ze4b052164b,z2e91460297,z7e674d442a;float z657e1a72e9,zde289c21d6;
za6c557b086 z696edae02a=MAX((za6c557b086)1,convert_uint(zffe3bfa5e0[x]));
za6c557b086 zf411bdf53a=MAX((za6c557b086)1,convert_uint(z3033916ec2[x]));
{
z657e1a72e9=(float)zf411bdf53a;zde289c21d6=(float)z696edae02a;z657e1a72e9=
z657e1a72e9*z657e1a72e9*z657e1a72e9;zde289c21d6=zde289c21d6*zde289c21d6*
zde289c21d6;}
{float zfd84819d76=convert_float(z54f271389d)/convert_float(z728a11ff70);float
z892e795d04=convert_float(z54f271389d)/convert_float(z743d1a3a1f);z7e674d442a=
zf06b5bee70*zfd84819d76;ze4b052164b=z6ba2e3231d*z892e795d04;}



ushort4 z194e3d317e;z194e3d317e.s0=convert_ushort_sat(ze4b052164b);z194e3d317e.
s1=zf676f3c90e;z194e3d317e.s2=convert_ushort_sat(z7e674d442a);ze4351005bc[x]=
z194e3d317e;


{float za9445b3cd5=zcd5bebbd58*z657e1a72e9;float z2cbb0949ed=z99dc430100*
zde289c21d6;float z3356f0b0e4=convert_float(ze2b2743c1a)/(za342478133*
z657e1a72e9+(float)z104d7d0057*zde289c21d6);float z892e795d04=convert_float(
ze2b2743c1a)/(z743d1a3a1f+(float)z9f0824b0d9);z2e91460297=((float)za9445b3cd5+(
float)z2cbb0949ed)*z3356f0b0e4;ze4b052164b=((float)z6ba2e3231d+(float)
z6848451961)*z892e795d04;}



z194e3d317e.s0=convert_ushort_sat(ze4b052164b);z194e3d317e.s1=convert_ushort_sat
(z2e91460297);z194e3d317e.s2=z50476d8c40;ze4351005bc[x+1]=z194e3d317e;}}
#endif
#if (z3dbd1ff682==5)
__kernel void zcf439563b5(__global ushort*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float4 zfb81b1b9ea)
{int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;__global ushort*z395b96baac
=zf8d9fd6cb8+z30eaaf69b7.s4+(z30eaaf69b7.s5+zba94ee46da.y)*z2824fcf57d;__global
ushort4*ze4351005bc=z718a062ddd+z30eaaf69b7.s0+(z30eaaf69b7.s1+zba94ee46da.y)*
z9562068e13;const int x=zba94ee46da.x;
float z42758a01e0=zfb81b1b9ea.s0;float z4ac43cf202=zfb81b1b9ea.s1;float
z14bbce87c1=zfb81b1b9ea.s2;



float z4633c865c6=convert_float(z395b96baac[x]);float4 z194e3d317e;z194e3d317e.
s0=z4633c865c6*z42758a01e0;z194e3d317e.s1=z4633c865c6*z4ac43cf202;z194e3d317e.s2
=z4633c865c6*z14bbce87c1;ze4351005bc[x]=convert_ushort4_sat(z194e3d317e);}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
