#define z87ea09080d 1
#define z93a6893130 10
#define z4f3854e40b 64

#ifndef z4f3854e40b
#define z4f3854e40b 64
#endif
#if z87ea09080d
#define z1b5dd6e9b8 __read_only image3d_t
ushort4 z0976606ba6(float4 z2db40d4819,z1b5dd6e9b8 z8d2c41abac){const float
z48c7a50fca=0.5f/(float)z4f3854e40b;z2db40d4819=clamp(z2db40d4819,(float4)
z48c7a50fca,(float4)(1.0f-z48c7a50fca));z2db40d4819.w=1.0f;const sampler_t
zde11d8c31a=CLK_NORMALIZED_COORDS_TRUE|CLK_ADDRESS_NONE|CLK_FILTER_LINEAR;float4
 z52ed04f00e=read_imagef(z8d2c41abac,zde11d8c31a,z2db40d4819);return
convert_ushort4(z52ed04f00e*(float4)65535.0f);}
#else
#define z1b5dd6e9b8 __global uchar4*
ushort4 z0976606ba6(float4 z2db40d4819,z1b5dd6e9b8 z8d2c41abac){z2db40d4819*=
convert_float(z4f3854e40b);
#if 0
int4 z7feea6d54c=convert_int4(floor(z2db40d4819));z7feea6d54c=max((int4)0,min((
int4)(z4f3854e40b-1),z7feea6d54c));
uchar4 z0976606ba6=z8d2c41abac[z7feea6d54c.x+z7feea6d54c.y*z4f3854e40b+
z7feea6d54c.z*z4f3854e40b*z4f3854e40b];return convert_ushort4(z0976606ba6)*256;
#else
float4 zbb28f69e95=z2db40d4819-(float4)(0.5f);int4 z2d351c5ace=convert_int4(
floor(zbb28f69e95));int4 z3931fc4ce8=(int4)(1)+convert_int4(floor(zbb28f69e95));
z2d351c5ace=max((int4)0,min((int4)(z4f3854e40b-1),z2d351c5ace));
z3931fc4ce8=max((int4)0,min((int4)(z4f3854e40b-1),z3931fc4ce8));
float4 z0807ab855c=zbb28f69e95-floor(zbb28f69e95);
float4 ze0043b18ea=convert_float4(z8d2c41abac[z2d351c5ace.x+z2d351c5ace.y*
z4f3854e40b+z2d351c5ace.z*z4f3854e40b*z4f3854e40b]);float4 z9c53c67fcc=
convert_float4(z8d2c41abac[z3931fc4ce8.x+z2d351c5ace.y*z4f3854e40b+z2d351c5ace.z
*z4f3854e40b*z4f3854e40b]);float4 z70f0fbbed2=convert_float4(z8d2c41abac[
z2d351c5ace.x+z3931fc4ce8.y*z4f3854e40b+z2d351c5ace.z*z4f3854e40b*z4f3854e40b]);
float4 zcbdbb5e521=convert_float4(z8d2c41abac[z3931fc4ce8.x+z3931fc4ce8.y*
z4f3854e40b+z2d351c5ace.z*z4f3854e40b*z4f3854e40b]);float4 z450ab3f39d=
convert_float4(z8d2c41abac[z2d351c5ace.x+z2d351c5ace.y*z4f3854e40b+z3931fc4ce8.z
*z4f3854e40b*z4f3854e40b]);float4 z0bb74c7ab2=convert_float4(z8d2c41abac[
z3931fc4ce8.x+z2d351c5ace.y*z4f3854e40b+z3931fc4ce8.z*z4f3854e40b*z4f3854e40b]);
float4 ze88f8271c7=convert_float4(z8d2c41abac[z2d351c5ace.x+z3931fc4ce8.y*
z4f3854e40b+z3931fc4ce8.z*z4f3854e40b*z4f3854e40b]);float4 zd0f9dfebc6=
convert_float4(z8d2c41abac[z3931fc4ce8.x+z3931fc4ce8.y*z4f3854e40b+z3931fc4ce8.z
*z4f3854e40b*z4f3854e40b]);float4 z6aa1f558f1;float4 zfd66bcac28=(float4)(1.0f)-
z0807ab855c;z6aa1f558f1=zfd66bcac28.x*zfd66bcac28.y*zfd66bcac28.z*ze0043b18ea+
z0807ab855c.x*zfd66bcac28.y*zfd66bcac28.z*z9c53c67fcc+zfd66bcac28.x*z0807ab855c.
y*zfd66bcac28.z*z70f0fbbed2+z0807ab855c.x*z0807ab855c.y*zfd66bcac28.z*
zcbdbb5e521+zfd66bcac28.x*zfd66bcac28.y*z0807ab855c.z*z450ab3f39d+z0807ab855c.x*
zfd66bcac28.y*z0807ab855c.z*z0bb74c7ab2+zfd66bcac28.x*z0807ab855c.y*z0807ab855c.
z*ze88f8271c7+z0807ab855c.x*z0807ab855c.y*z0807ab855c.z*zd0f9dfebc6;return
convert_ushort4(z6aa1f558f1*256.0f);
#endif
}
#endif
#ifndef z93a6893130
#define z93a6893130 0
#endif
uint4 z54d6ebd1d5(uchar za1b2cb34f0,uint4 z6a80e4e489,uint4 zd30cb40f88){uint
z631d63f33d=convert_uint(za1b2cb34f0);uint z89b16fd076=(z631d63f33d<<8)|
z631d63f33d;uint z2e782e999d=65536-z89b16fd076;return(z6a80e4e489*z89b16fd076+
zd30cb40f88*z2e782e999d)>>(uint4)(16,16,16,16);}__kernel void zc4d2e7eae2(
__global ushort4*zf8d9fd6cb8,__global ushort4*z718a062ddd,int4 z30eaaf69b7,uint
z58c1e26fb1,uint z745057f086,z1b5dd6e9b8 z8d2c41abac
#if z93a6893130==10
,int zed17defbb4,__global uchar*zec145e35cf,int16 z3576e84f20,z1b5dd6e9b8
z5f3d83765b,z1b5dd6e9b8 zbbb4606d93,z1b5dd6e9b8 z0a53d0c0ea,z1b5dd6e9b8
z240b968c9f,z1b5dd6e9b8 z0acbfa686b,z1b5dd6e9b8 zb5329c3ffd,z1b5dd6e9b8
z2089594064,z1b5dd6e9b8 z25f056de47,z1b5dd6e9b8 z37fbdbab93,z1b5dd6e9b8
z7072ad6abd
#endif
){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.xy;
int2 z83640e5796=zba94ee46da;
ushort4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z58c1e26fb1/4)];
float4 z2db40d4819=convert_float4(z493deefb55)/65535.0f;z2db40d4819.w=1.0f;
z493deefb55=z0976606ba6(z2db40d4819,z8d2c41abac);
#if z93a6893130==10
int2 z9b046bc3a1=z83640e5796;
int z3fdc4b790f=z9b046bc3a1.x+z9b046bc3a1.y*z3576e84f20.sa;int*z6016b79538=(int*
)&z3576e84f20;uint4 zd30cb40f88=convert_uint4(z493deefb55);if(zed17defbb4&1){
uint4 z6a80e4e489=convert_uint4(z0976606ba6(z2db40d4819,z5f3d83765b));
zd30cb40f88=z54d6ebd1d5(zec145e35cf[z3fdc4b790f+z6016b79538[0]],z6a80e4e489,
zd30cb40f88);}if(zed17defbb4&2){uint4 z6a80e4e489=convert_uint4(z0976606ba6(
z2db40d4819,zbbb4606d93));zd30cb40f88=z54d6ebd1d5(zec145e35cf[z3fdc4b790f+
z6016b79538[1]],z6a80e4e489,zd30cb40f88);}if(zed17defbb4&4){uint4 z6a80e4e489=
convert_uint4(z0976606ba6(z2db40d4819,z0a53d0c0ea));zd30cb40f88=z54d6ebd1d5(
zec145e35cf[z3fdc4b790f+z6016b79538[2]],z6a80e4e489,zd30cb40f88);}if(zed17defbb4
&8){uint4 z6a80e4e489=convert_uint4(z0976606ba6(z2db40d4819,z240b968c9f));
zd30cb40f88=z54d6ebd1d5(zec145e35cf[z3fdc4b790f+z6016b79538[3]],z6a80e4e489,
zd30cb40f88);}if(zed17defbb4&16){uint4 z6a80e4e489=convert_uint4(z0976606ba6(
z2db40d4819,z0acbfa686b));zd30cb40f88=z54d6ebd1d5(zec145e35cf[z3fdc4b790f+
z6016b79538[4]],z6a80e4e489,zd30cb40f88);}if(zed17defbb4&32){uint4 z6a80e4e489=
convert_uint4(z0976606ba6(z2db40d4819,zb5329c3ffd));zd30cb40f88=z54d6ebd1d5(
zec145e35cf[z3fdc4b790f+z6016b79538[5]],z6a80e4e489,zd30cb40f88);}if(zed17defbb4
&64){uint4 z6a80e4e489=convert_uint4(z0976606ba6(z2db40d4819,z2089594064));
zd30cb40f88=z54d6ebd1d5(zec145e35cf[z3fdc4b790f+z6016b79538[6]],z6a80e4e489,
zd30cb40f88);}if(zed17defbb4&128){uint4 z6a80e4e489=convert_uint4(z0976606ba6(
z2db40d4819,z25f056de47));zd30cb40f88=z54d6ebd1d5(zec145e35cf[z3fdc4b790f+
z6016b79538[7]],z6a80e4e489,zd30cb40f88);}if(zed17defbb4&256){uint4 z6a80e4e489=
convert_uint4(z0976606ba6(z2db40d4819,z37fbdbab93));zd30cb40f88=z54d6ebd1d5(
zec145e35cf[z3fdc4b790f+z6016b79538[8]],z6a80e4e489,zd30cb40f88);}if(zed17defbb4
&512){uint4 z6a80e4e489=convert_uint4(z0976606ba6(z2db40d4819,z7072ad6abd));
zd30cb40f88=z54d6ebd1d5(zec145e35cf[z3fdc4b790f+z6016b79538[9]],z6a80e4e489,
zd30cb40f88);}z493deefb55=convert_ushort4(zd30cb40f88);
#endif
z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z745057f086/4)]=z493deefb55;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
