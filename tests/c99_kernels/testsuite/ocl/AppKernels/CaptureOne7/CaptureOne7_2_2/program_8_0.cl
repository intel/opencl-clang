__kernel void zba817fd993(__global ushort4*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int4 z30eaaf69b7,uint z58c1e26fb1,uint z745057f086,int2 zf09eb81885,
float2 z55c265223f,int z5ea67d3f25,__constant uchar*z2069498e76,__constant uchar
*zca451f09f4,__constant float*z6ec68f5a74,__constant ushort*zc66b54acb0){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;
int2 z733ab70e0a=zba94ee46da+zf09eb81885;zba94ee46da+=z30eaaf69b7.xy;int2
z83640e5796=zba94ee46da;float z566d227dec=z55c265223f.x;float zdc1bd90d17=
z55c265223f.y;ushort4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(
z58c1e26fb1/4)];
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
;z493deefb55=convert_ushort4_sat(zc6ff66a820);int z77f8ae3448=zba94ee46da.x+
zba94ee46da.y*(z745057f086/4);z718a062ddd[z77f8ae3448]=z493deefb55;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
