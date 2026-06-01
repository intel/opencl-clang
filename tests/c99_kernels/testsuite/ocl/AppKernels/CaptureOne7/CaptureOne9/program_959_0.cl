#define zeea09a7c2c 0
#define ze9fed095f7 ushort4

#ifndef ze9fed095f7
typedef uchar4 z6aa1f558f1;
#else
typedef ze9fed095f7 z6aa1f558f1;
#endif
typedef uchar4 z0f1072850a;__kernel void z07ca457b30(__global z6aa1f558f1*
zf8d9fd6cb8,__global z6aa1f558f1*z718a062ddd,int4 z30eaaf69b7,int z2824fcf57d,
int z9562068e13,float8 zfb81b1b9ea,int8 z0ed8459d33,__global uchar4*z054dfbff53)
{int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s01;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;
z6aa1f558f1 z9697e8d76f=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d/4];
float2 za7b33b613c=zfb81b1b9ea.s01;float zcbf92f9d99=zfb81b1b9ea.s2;float
z4a36cda3e7=zfb81b1b9ea.s3;int z9ec0103ab0=z0ed8459d33.s0;int ze4647265d1=
z0ed8459d33.s1;int2 z3f816b30a5=z0ed8459d33.s45;float2 zed03576563=(
convert_float2(zba94ee46da+z3f816b30a5.xy)+(float2)0.5f-za7b33b613c)/zcbf92f9d99
;if(zed03576563.x>=0.0f&&zed03576563.x<=z9ec0103ab0&&zed03576563.y>=0.0f&&
zed03576563.y<=ze4647265d1){__global z0f1072850a*z5fbd1d8e7c=z054dfbff53;int
z733454c341=z0ed8459d33.s6;int zc276dda26e=z0ed8459d33.s2;int z4f499db09c=
z0ed8459d33.s3;float zb35c081ca6=zfb81b1b9ea.s4;float zbae767834f=zed03576563.x;
float z9a112927fc=zed03576563.y;float2 zca6bcf4b34;float2 z67ced5074b=fract(
zed03576563,&zca6bcf4b34);int2 z7d4224f715=convert_int2_rtz(zca6bcf4b34);


float2 w=1.0f-z67ced5074b;float z648af8356b=w.x*w.y;float z7afaa48361=
z67ced5074b.x*w.y;float zd62711b375=w.x*z67ced5074b.y;float zcbfc8e3590=
z67ced5074b.x*z67ced5074b.y;__global z0f1072850a*z9d6d310443=z5fbd1d8e7c+
z733454c341*z7d4224f715.y+z7d4224f715.x;__global z0f1072850a*z10f7a29f4f=
z9d6d310443+(z7d4224f715.y<z4f499db09c?z733454c341:0);__global z0f1072850a*
z05b9b9f342=z9d6d310443+(z7d4224f715.x<zc276dda26e?1:0);__global z0f1072850a*
z6c4fb551d9=z10f7a29f4f+(z7d4224f715.x<zc276dda26e?1:0);float4 zfaa1b0dd3b=
z648af8356b*convert_float4(z9d6d310443[0])+z7afaa48361*convert_float4(
z05b9b9f342[0])+zd62711b375*convert_float4(z10f7a29f4f[0])+zcbfc8e3590*
convert_float4(z6c4fb551d9[0]);
#if zeea09a7c2c
zfaa1b0dd3b=zfaa1b0dd3b.yzwx;
#else
zfaa1b0dd3b=zfaa1b0dd3b.zyxw;
#endif
float z90e1a42944=zfaa1b0dd3b.w*z4a36cda3e7;
float zc1a7596d5d=1-z90e1a42944;z90e1a42944*=zb35c081ca6;float4 z395b96baac=
convert_float4(z9697e8d76f);z395b96baac=zfaa1b0dd3b*z90e1a42944+z395b96baac*
zc1a7596d5d;
#ifndef ze9fed095f7
z9697e8d76f=convert_uchar4(z395b96baac);
#else
z9697e8d76f=convert_ushort4(z395b96baac);
#endif
}z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13/4]=z9697e8d76f;}
#if 0
for(zdba6b93f69 y=0;y<z99cf4fd6fe;++y){z6aa1f558f1*z395b96baac=&zba15fb8bb8[y*
z45c01651ac];for(zdba6b93f69 x=0;x<w;++x){zdba6b93f69 z733454c341=z72a2db37b7;
z0f1072850a*z5fbd1d8e7c=z5e220bb017;



int z7c1b1c372d=(int)zbae767834f;int zc7f3e922c6=(int)z9a112927fc;float
z323c21652c=zbae767834f-z7c1b1c372d;float z0f72d9d574=z9a112927fc-zc7f3e922c6;

float zdf8f02136c=1.0f-z323c21652c;float z785feecec0=1.0f-z0f72d9d574;float
z648af8356b=zdf8f02136c*z785feecec0;float z7afaa48361=z323c21652c*z785feecec0;
float zd62711b375=zdf8f02136c*z0f72d9d574;float zcbfc8e3590=z323c21652c*
z0f72d9d574;z0f1072850a*z9d6d310443=z5fbd1d8e7c+z733454c341*zc7f3e922c6+4*
z7c1b1c372d;z0f1072850a*z10f7a29f4f=z9d6d310443+(zc7f3e922c6<z4f499db09c?
z733454c341:0);z0f1072850a*z05b9b9f342=z9d6d310443+(z7c1b1c372d<zc276dda26e?4:0)
;z0f1072850a*z6c4fb551d9=z10f7a29f4f+(z7c1b1c372d<zc276dda26e?4:0);
#ifdef WIN32
float za3158292ce=(z648af8356b*z9d6d310443[0]+z7afaa48361*z05b9b9f342[0])+(
zd62711b375*z10f7a29f4f[0]+zcbfc8e3590*z6c4fb551d9[0]);float z305d891f1d=(
z648af8356b*z9d6d310443[1]+z7afaa48361*z05b9b9f342[1])+(zd62711b375*z10f7a29f4f[
1]+zcbfc8e3590*z6c4fb551d9[1]);float zff400e9e97=(z648af8356b*z9d6d310443[2]+
z7afaa48361*z05b9b9f342[2])+(zd62711b375*z10f7a29f4f[2]+zcbfc8e3590*z6c4fb551d9[
2]);float z2dd09f3226=(z648af8356b*z9d6d310443[3]+z7afaa48361*z05b9b9f342[3])+(
zd62711b375*z10f7a29f4f[3]+zcbfc8e3590*z6c4fb551d9[3]);
#else
float z2dd09f3226=(z648af8356b*z9d6d310443[0]+z7afaa48361*z05b9b9f342[0])+(
zd62711b375*z10f7a29f4f[0]+zcbfc8e3590*z6c4fb551d9[0]);float zff400e9e97=(
z648af8356b*z9d6d310443[1]+z7afaa48361*z05b9b9f342[1])+(zd62711b375*z10f7a29f4f[
1]+zcbfc8e3590*z6c4fb551d9[1]);float z305d891f1d=(z648af8356b*z9d6d310443[2]+
z7afaa48361*z05b9b9f342[2])+(zd62711b375*z10f7a29f4f[2]+zcbfc8e3590*z6c4fb551d9[
2]);float za3158292ce=(z648af8356b*z9d6d310443[3]+z7afaa48361*z05b9b9f342[3])+(
zd62711b375*z10f7a29f4f[3]+zcbfc8e3590*z6c4fb551d9[3]);
#endif
float z90e1a42944=(z2dd09f3226*z4a36cda3e7)/255.0f;float zc1a7596d5d=1-
z90e1a42944;z90e1a42944*=zb35c081ca6;z395b96baac[0]=(z6aa1f558f1)(zff400e9e97*
z90e1a42944+z395b96baac[0]*zc1a7596d5d);z395b96baac[1]=(z6aa1f558f1)(z305d891f1d
*z90e1a42944+z395b96baac[1]*zc1a7596d5d);z395b96baac[2]=(z6aa1f558f1)(
za3158292ce*z90e1a42944+z395b96baac[2]*zc1a7596d5d);}z395b96baac+=3;}}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
