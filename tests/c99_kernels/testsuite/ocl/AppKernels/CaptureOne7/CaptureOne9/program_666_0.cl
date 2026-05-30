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
#if ze9fed095f7==13
typedef ushort z6aa1f558f1;
#endif
__kernel void zbaa3412dfe(__global z6aa1f558f1*zba15fb8bb8,__global z6aa1f558f1*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float2 z8a7ff02448,
float2 z5462909dc1){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));
if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;__global
z6aa1f558f1*zf8d9fd6cb8=zba15fb8bb8+z30eaaf69b7.s4+z30eaaf69b7.s5*z2824fcf57d;
float2 z4377fdece7=convert_float2(zba94ee46da)+(float2)0.5f;




float2 z9a28cfd3ec=(z4377fdece7-z5462909dc1)/z8a7ff02448;
#if 0
int2 z83640e5796=convert_int2_rte(z7feea6d54c);
z6aa1f558f1 z9697e8d76f=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];
#else
z9a28cfd3ec-=(float2)0.5f;z9a28cfd3ec=max(min(z9a28cfd3ec,convert_float2(
z30eaaf69b7.s67)-(float2)1),(float2)0);float2 zca6bcf4b34;float2 z67ced5074b=
fract(z9a28cfd3ec,&zca6bcf4b34);int2 z7d4224f715=convert_int2_rtz(zca6bcf4b34);


float2 z716146ae96=1.0f-z67ced5074b;float z648af8356b=z716146ae96.x*z716146ae96.
y;float z7afaa48361=z67ced5074b.x*z716146ae96.y;float zd62711b375=z716146ae96.x*
z67ced5074b.y;float zcbfc8e3590=z67ced5074b.x*z67ced5074b.y;
#if (ze9fed095f7==13)
ushort2 zef2e9e39bb=vload2(0,zf8d9fd6cb8+z7d4224f715.x+z7d4224f715.y*z2824fcf57d
);ushort2 z8aefd2cd3d=vload2(0,zf8d9fd6cb8+z7d4224f715.x+(z7d4224f715.y+1)*
z2824fcf57d);z6aa1f558f1 z9d6d310443=zef2e9e39bb.x;
z6aa1f558f1 z10f7a29f4f=z8aefd2cd3d.x;
z6aa1f558f1 z05b9b9f342=zef2e9e39bb.y;
z6aa1f558f1 z6c4fb551d9=z8aefd2cd3d.y;
#else
z6aa1f558f1 z9d6d310443=zf8d9fd6cb8[z7d4224f715.x+z7d4224f715.y*z2824fcf57d];
z6aa1f558f1 z10f7a29f4f=zf8d9fd6cb8[z7d4224f715.x+(1+z7d4224f715.y)*z2824fcf57d]
;z6aa1f558f1 z05b9b9f342=zf8d9fd6cb8[z7d4224f715.x+1+z7d4224f715.y*z2824fcf57d];
z6aa1f558f1 z6c4fb551d9=zf8d9fd6cb8[z7d4224f715.x+1+(1+z7d4224f715.y)*
z2824fcf57d];
#endif
#if (ze9fed095f7==16)
z6aa1f558f1 z9697e8d76f=convert_short2_sat(z648af8356b*convert_float2(
z9d6d310443)+z7afaa48361*convert_float2(z05b9b9f342)+zd62711b375*convert_float2(
z10f7a29f4f)+zcbfc8e3590*convert_float2(z6c4fb551d9));
#elif (ze9fed095f7==13)
z6aa1f558f1 z9697e8d76f=convert_ushort_sat(z648af8356b*convert_float(z9d6d310443
)+z7afaa48361*convert_float(z05b9b9f342)+zd62711b375*convert_float(z10f7a29f4f)+
zcbfc8e3590*convert_float(z6c4fb551d9));
#else
z6aa1f558f1 z9697e8d76f=z648af8356b*z9d6d310443+z7afaa48361*z05b9b9f342+
zd62711b375*z10f7a29f4f+zcbfc8e3590*z6c4fb551d9;
#endif
#endif
zba94ee46da+=z30eaaf69b7.s01;z718a062ddd[zba94ee46da.x+zba94ee46da.y*z9562068e13
]=z9697e8d76f;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
