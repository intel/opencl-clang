#define ze9fed095f7 15

#ifndef ze9fed095f7
#define ze9fed095f7 14
typedef float z6aa1f558f1;
#endif
#if ze9fed095f7==15
typedef float4 z6aa1f558f1;
#endif
#if ze9fed095f7==16
typedef short2 z6aa1f558f1;
#endif
__kernel void zbaa3412dfe(__global z6aa1f558f1*zf8d9fd6cb8,__global z6aa1f558f1*
z718a062ddd,int8 z30eaaf69b7,uint z2824fcf57d,uint z9562068e13,float z5b8c31c8e4
){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;float2 z7feea6d54c=(
convert_float2(zba94ee46da)+(float2)0.5f)/(float2)z5b8c31c8e4;z7feea6d54c+=
convert_float2(z30eaaf69b7.s45);
#if 0
int2 z83640e5796=convert_int2_rte(z7feea6d54c);
z6aa1f558f1 z9697e8d76f=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];
#else
z7feea6d54c-=(float2)0.5f;float2 zca6bcf4b34;float2 z67ced5074b=fract(
z7feea6d54c,&zca6bcf4b34);int2 z7d4224f715=convert_int2_rtz(zca6bcf4b34);


float2 z716146ae96=1.0f-z67ced5074b;float z648af8356b=z716146ae96.x*z716146ae96.
y;float z7afaa48361=z67ced5074b.x*z716146ae96.y;float zd62711b375=z716146ae96.x*
z67ced5074b.y;float zcbfc8e3590=z67ced5074b.x*z67ced5074b.y;
z6aa1f558f1 z9d6d310443=zf8d9fd6cb8[z7d4224f715.x+z7d4224f715.y*z2824fcf57d];
z6aa1f558f1 z10f7a29f4f=zf8d9fd6cb8[z7d4224f715.x+(1+z7d4224f715.y)*z2824fcf57d]
;z6aa1f558f1 z05b9b9f342=zf8d9fd6cb8[z7d4224f715.x+1+z7d4224f715.y*z2824fcf57d];
z6aa1f558f1 z6c4fb551d9=zf8d9fd6cb8[z7d4224f715.x+1+(1+z7d4224f715.y)*
z2824fcf57d];
#if (ze9fed095f7==16)
z6aa1f558f1 z9697e8d76f=convert_short2_sat(z648af8356b*convert_float2(
z9d6d310443)+z7afaa48361*convert_float2(z05b9b9f342)+zd62711b375*convert_float2(
z10f7a29f4f)+zcbfc8e3590*convert_float2(z6c4fb551d9));
#else
z6aa1f558f1 z9697e8d76f=z648af8356b*z9d6d310443+z7afaa48361*z05b9b9f342+
zd62711b375*z10f7a29f4f+zcbfc8e3590*z6c4fb551d9;
#endif
#endif
zba94ee46da+=z30eaaf69b7.s01;z718a062ddd[zba94ee46da.x+zba94ee46da.y*z9562068e13
]=z9697e8d76f;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
