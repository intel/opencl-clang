#define z3dbd1ff682 0
typedef uint za6c557b086;typedef ushort z51b7908a0d;
#ifndef z3dbd1ff682
#define z3dbd1ff682 1
#endif
#define z12cbbf15c0 65535
#define MIN min
#if (z3dbd1ff682==0)
__kernel void zba817fd993(__global ushort4*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int2 zf09eb81885,
float2 z55c265223f,int z5ea67d3f25,__constant uchar*z2069498e76,__constant uchar
*zca451f09f4,__constant float*z6ec68f5a74,__constant ushort*zc66b54acb0){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;
int2 z733ab70e0a=zba94ee46da+zf09eb81885;int2 z83640e5796=zba94ee46da+
z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;float z566d227dec=
z55c265223f.x;float zdc1bd90d17=z55c265223f.y;ushort4 z493deefb55=zf8d9fd6cb8[
z83640e5796.x+z83640e5796.y*z2824fcf57d];
#define z2a7a5ebbcc 2.0f
const int zade1ec4319=2047;const float z2f6ebf4f11=z2a7a5ebbcc/2047.0f;

int z49cb77b4dc=z733ab70e0a.x;int z2523506dd2=z733ab70e0a.y;



int z6c1348502a=(z49cb77b4dc&0x0f)<<4|(z2523506dd2&0x0f);int z8acd4fa0c6=(
z49cb77b4dc&0xf0)>>4|(z2523506dd2&0xf0);int z64f8d93415=z2069498e76[z6c1348502a]
;int zabdc291adf=zca451f09f4[z6c1348502a];float zad2061debf=z6ec68f5a74[(
z8acd4fa0c6+z64f8d93415)&0xff]-z6ec68f5a74[(z8acd4fa0c6+zabdc291adf)&0xff];




int z1774071462=z8acd4fa0c6^0x08;
int z0cbbff90c0=z8acd4fa0c6^0x88;
int z835ba5e6fd=z8acd4fa0c6^0x80;
float4 za81ab74d5d;za81ab74d5d.x=z6ec68f5a74[(z1774071462+z64f8d93415)&0xff]-
z6ec68f5a74[(z1774071462+zabdc291adf)&0xff];za81ab74d5d.y=z6ec68f5a74[(
z0cbbff90c0+z64f8d93415)&0xff]-z6ec68f5a74[(z0cbbff90c0+zabdc291adf)&0xff];
za81ab74d5d.z=z6ec68f5a74[(z835ba5e6fd+z64f8d93415)&0xff]-z6ec68f5a74[(
z835ba5e6fd+zabdc291adf)&0xff];za81ab74d5d.w=0.0f;za81ab74d5d*=z566d227dec;
zad2061debf=zad2061debf*zdc1bd90d17;
int4 z205d564e2f=convert_int4(z493deefb55);float z8c25d690d5=1.0f;if(z5ea67d3f25
>0){





int z5266b9aae9=zc66b54acb0[(z205d564e2f.x+z205d564e2f.y+z205d564e2f.y+
z205d564e2f.z)>>7];
z8c25d690d5=z2f6ebf4f11*convert_float(zade1ec4319-z5266b9aae9);}int4 zc6ff66a820
=z205d564e2f+convert_int4((float4)z8c25d690d5*((float4)zad2061debf+za81ab74d5d))
;z493deefb55=convert_ushort4_sat(zc6ff66a820);z718a062ddd[zaaf414d14e.x+
zaaf414d14e.y*z9562068e13]=z493deefb55;}
#endif
#if z3dbd1ff682==1
inline za6c557b086 z061a86f68a(int z49cb77b4dc,int z2523506dd2,__constant uchar*
zbf08573773,__constant uchar*zb72766fcd3,__constant za6c557b086*z4124e043ed){int
 z6c1348502a=(z49cb77b4dc&0x0f)<<4|(z2523506dd2&0x0f);int z8acd4fa0c6=(
z49cb77b4dc&0xf0)>>4|(z2523506dd2&0xf0);int z64f8d93415=zbf08573773[z6c1348502a]
;int zabdc291adf=zb72766fcd3[z6c1348502a];return z4124e043ed[(z8acd4fa0c6+
z64f8d93415)&0xff]-z4124e043ed[(z8acd4fa0c6+zabdc291adf)&0xff];}__kernel void
zba817fd993(__global ushort4*zf8d9fd6cb8,__global ushort4*z718a062ddd,int8
z30eaaf69b7,int z2824fcf57d,int z9562068e13,int2 zf09eb81885,const int
z6649b418da,__constant uchar*z2069498e76,__constant uchar*zca451f09f4,__constant
 za6c557b086*z4124e043ed,const int z03769fd8d6,const int z9b2ebbd33f){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;
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
z6649b418da)>>z38d5e777b6);int4 z962ac9897b=convert_int4(z493deefb55);
int4 z0ced894e85=MIN((int4)z03769fd8d6,(int4)z12cbbf15c0-z962ac9897b)*(int4)
z9b2ebbd33f;z962ac9897b=z962ac9897b+(((int4)zfd43e2fb77*z0ced894e85)>>(int4)
z38d5e777b6);z493deefb55=convert_ushort4_sat(z962ac9897b);z718a062ddd[
zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=z493deefb55;}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
