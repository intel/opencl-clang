#define z87ea09080d 0
#define z4f3854e40b 64

#ifndef z4f3854e40b
#define z4f3854e40b 64
#endif
#ifndef z93a6893130
#define z93a6893130 0
#endif
#if z87ea09080d
#define z1b5dd6e9b8 __read_only image3d_t
ushort4 z0976606ba6(float4 z2db40d4819,z1b5dd6e9b8 z8d2c41abac){z2db40d4819*=
convert_float(z4f3854e40b);
z2db40d4819=clamp(z2db40d4819,(float4)0.5f,(float4)(z4f3854e40b-0.5f));
z2db40d4819.w=1.0f;const sampler_t zde11d8c31a=CLK_NORMALIZED_COORDS_FALSE|
CLK_ADDRESS_NONE|CLK_FILTER_LINEAR;float4 z51eadf1cec=read_imagef(z8d2c41abac,
zde11d8c31a,z2db40d4819);z51eadf1cec*=(float4)65535.0f;float4 z48c7a50fca=(
float4)65535.0f-z51eadf1cec;float4 w=(float4)2.0f*max((float4)0,z2db40d4819-(
float4)(z4f3854e40b)+(float4)0.5f);z51eadf1cec+=z48c7a50fca*w;z48c7a50fca=
z51eadf1cec;w=(float4)2.0f*min((float4)0,z2db40d4819-(float4)0.5f);z51eadf1cec+=
z48c7a50fca*w;return convert_ushort4_sat(z51eadf1cec);}
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
floor(zbb28f69e95));int4 z3931fc4ce8=(int4)(1)+z2d351c5ace;z2d351c5ace=max((int4
)0,min((int4)(z4f3854e40b-1),z2d351c5ace));
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
z*ze88f8271c7+z0807ab855c.x*z0807ab855c.y*z0807ab855c.z*zd0f9dfebc6;
float4 z51eadf1cec=(z6aa1f558f1*(65535.0f/255.0f));
#if 1
float4 z48c7a50fca=(float4)65535.0f-z51eadf1cec;const float z57c12506db=2.0f*
256.0f;float4 w=(float4)2.0f*max((float4)0,z2db40d4819-(float4)(z4f3854e40b)+(
float4)0.5f);if(z48c7a50fca.x<=z57c12506db)z51eadf1cec.x+=z48c7a50fca.x*w.x;if(
z48c7a50fca.y<=z57c12506db)z51eadf1cec.y+=z48c7a50fca.y*w.y;if(z48c7a50fca.z<=
z57c12506db)z51eadf1cec.z+=z48c7a50fca.z*w.z;z48c7a50fca=z51eadf1cec;w=(float4)
2.0f*min((float4)0,z2db40d4819-(float4)0.5f);if(z48c7a50fca.x<=z57c12506db)
z51eadf1cec.x+=z48c7a50fca.x*w.x;if(z48c7a50fca.y<=z57c12506db)z51eadf1cec.y+=
z48c7a50fca.y*w.y;if(z48c7a50fca.z<=z57c12506db)z51eadf1cec.z+=z48c7a50fca.z*w.z
;
#endif
return convert_ushort4_sat(z51eadf1cec);
#endif
}
#endif
uint4 z54d6ebd1d5(uchar za1b2cb34f0,uint4 z6a80e4e489,uint4 zd30cb40f88){uint
z631d63f33d=convert_uint(za1b2cb34f0);uint z89b16fd076=(z631d63f33d<<8)|
z631d63f33d;uint z2e782e999d=65536-z89b16fd076;return(z6a80e4e489*z89b16fd076+
zd30cb40f88*z2e782e999d)>>(uint4)(16,16,16,16);}__kernel void zc4d2e7eae2(
__global ushort4*zf8d9fd6cb8,__global ushort4*z718a062ddd,int8 z30eaaf69b7,int
z2824fcf57d,int z9562068e13,z1b5dd6e9b8 z8d2c41abac
#if z93a6893130>0
,__global uchar*zec145e35cf,int z7f76fb323c,int4 z3576e84f20
#endif
){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 zaaf414d14e=
zba94ee46da+z30eaaf69b7.s01;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;ushort4
 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];float4
z2db40d4819=convert_float4(z493deefb55)/65535.0f;z2db40d4819.w=1.0f;
#if z93a6893130<1
z493deefb55=z0976606ba6(z2db40d4819,z8d2c41abac);
#else
z493deefb55=z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13];int2
z9b046bc3a1=zba94ee46da+z3576e84f20.s01;int z3fdc4b790f=z9b046bc3a1.x+
z9b046bc3a1.y*z3576e84f20.s2;uchar za1b2cb34f0=zec145e35cf[z3fdc4b790f+
z7f76fb323c];if(za1b2cb34f0>0){uint4 zd30cb40f88=convert_uint4(z493deefb55);
uint4 z6a80e4e489=convert_uint4(z0976606ba6(z2db40d4819,z8d2c41abac));
zd30cb40f88=z54d6ebd1d5(za1b2cb34f0,z6a80e4e489,zd30cb40f88);z493deefb55=
convert_ushort4(zd30cb40f88);}
#endif
z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=z493deefb55;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
