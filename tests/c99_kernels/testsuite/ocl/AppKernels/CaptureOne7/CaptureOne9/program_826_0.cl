#define z3dbd1ff682 5

#ifndef z3dbd1ff682
#define z3dbd1ff682 5
#endif
#define z55ba8bc0b4 0
#define z16120c8028 1
#define z501cf4f677 2
#define zba28350a32 3
#define za809d8fb8f 4
#define z6c04799cd1 5
#define ze4592bb8c3 6
#define za10dfaa2be 7
#define z4937348432 8
#define z9050d7d057(zff400e9e97,z305d891f1d,za3158292ce)    ( (zff400e9e97)*\
0.299f + (z305d891f1d)*0.587f + (za3158292ce)*0.114f )
#if (z3dbd1ff682==z55ba8bc0b4)
__kernel void zc20949a44d(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z958df11031){int2 zba94ee46da=(
int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.
s45;zba94ee46da+=z30eaaf69b7.s01;
float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad)];float
ze4b052164b=z493deefb55.s0;float z2e91460297=z493deefb55.s1;float z7e674d442a=
z493deefb55.s2;

float z5413c0ac97=(ze4b052164b+2.f*z2e91460297+z7e674d442a)+50.f;
float z0e19826f79=32767.f/z5413c0ac97;
z493deefb55.s0=(ze4b052164b-z2e91460297)*z0e19826f79;z493deefb55.s1=z5413c0ac97;
z493deefb55.s2=(z7e674d442a-z2e91460297)*z0e19826f79;z718a062ddd[zba94ee46da.x+
zba94ee46da.y*(z958df11031)]=z493deefb55;}
#endif
#if (z3dbd1ff682==z16120c8028)
__kernel void zc20949a44d(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z958df11031){int2 zba94ee46da=(
int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.
s45;zba94ee46da+=z30eaaf69b7.s01;
float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad)];int
z77f8ae3448=zba94ee46da.x+zba94ee46da.y*(z958df11031);float4 zd30cb40f88=
z718a062ddd[z77f8ae3448];float zdbf287f806=zd30cb40f88.x;float z5413c0ac97=
zd30cb40f88.y*(1.0f/32767.0f);float ze88d9ff858=zd30cb40f88.z;float ze4b052164b=
z493deefb55.x;float z2e91460297=z493deefb55.y;float z7e674d442a=z493deefb55.z;
float z55015f140e=(zdbf287f806*z5413c0ac97+z2e91460297);float z454281a538=(
ze88d9ff858*z5413c0ac97+z2e91460297);z55015f140e=(z55015f140e>0.0f)?z55015f140e:
0.0f;z454281a538=(z454281a538>0.0f)?z454281a538:0.0f;float z233197dcf4=(
ze4b052164b+z2e91460297+z2e91460297+z7e674d442a)+1.0f;float zff5c9644ab=(
z55015f140e+z2e91460297+z2e91460297+z454281a538)+1.0f;float z86dd029962=
z233197dcf4/zff5c9644ab;
zd30cb40f88.x=z55015f140e*z86dd029962;zd30cb40f88.y=z2e91460297*z86dd029962;
zd30cb40f88.z=z454281a538*z86dd029962;z718a062ddd[z77f8ae3448]=zd30cb40f88;}
#endif
#if (z3dbd1ff682==za10dfaa2be)
#define zec15f7fa83(zff400e9e97, z305d891f1d, za3158292ce) (zff400e9e97 * 0.299f\
 + z305d891f1d *  0.587f + za3158292ce *  0.114f)
__kernel void zc20949a44d(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z958df11031){int2 zba94ee46da=(
int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.
s45;zba94ee46da+=z30eaaf69b7.s01;
float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad)];int
z77f8ae3448=zba94ee46da.x+zba94ee46da.y*(z958df11031);float4 zd30cb40f88=
z718a062ddd[z77f8ae3448];float zdbf287f806=zd30cb40f88.x;float z5413c0ac97=
zd30cb40f88.y*(1.0f/32767.0f);float ze88d9ff858=zd30cb40f88.z;float ze4b052164b=
z493deefb55.x;float z2e91460297=z493deefb55.y;float z7e674d442a=z493deefb55.z;
float z0162a73c99=0.25f*max(z5413c0ac97*(32767.f-zdbf287f806-ze88d9ff858)-50.f,
0.f);float z55015f140e=(zdbf287f806*z5413c0ac97+z0162a73c99);float z454281a538=(
ze88d9ff858*z5413c0ac97+z0162a73c99);z55015f140e=(z55015f140e>0.0f)?z55015f140e:
0.0f;z454281a538=(z454281a538>0.0f)?z454281a538:0.0f;float z233197dcf4=
zec15f7fa83(ze4b052164b,z2e91460297,z7e674d442a)+1.f;float zff5c9644ab=
zec15f7fa83(z55015f140e,z0162a73c99,z454281a538)+1.f;float z86dd029962=
z233197dcf4/zff5c9644ab;
z86dd029962=min(z86dd029962,2.0f);zd30cb40f88.x=z55015f140e*z86dd029962;
zd30cb40f88.y=z0162a73c99*z86dd029962;zd30cb40f88.z=z454281a538*z86dd029962;
z718a062ddd[z77f8ae3448]=zd30cb40f88;}
#endif
#if (z3dbd1ff682==z501cf4f677)
__kernel void zc20949a44d(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z958df11031,float zab55369935){
int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;zba94ee46da+=z30eaaf69b7.s01;
float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad)];int
z77f8ae3448=zba94ee46da.x+zba94ee46da.y*(z958df11031);float4 zd30cb40f88=
z718a062ddd[z77f8ae3448];float ze4b052164b=z493deefb55.s0;float z2e91460297=
z493deefb55.s1;float z7e674d442a=z493deefb55.s2;float zdbf287f806=zd30cb40f88.s0
;float z5413c0ac97=zd30cb40f88.s1*(1.f/32767.f);float ze88d9ff858=zd30cb40f88.s2
;float z55015f140e=(zdbf287f806*z5413c0ac97+z2e91460297)*zab55369935+ze4b052164b
*(1.f-zab55369935);float z454281a538=(ze88d9ff858*z5413c0ac97+z2e91460297)*
zab55369935+z7e674d442a*(1.f-zab55369935);z55015f140e=(z55015f140e>0.f)?
z55015f140e:0.f;z454281a538=(z454281a538>0.f)?z454281a538:0.f;float z233197dcf4=
(ze4b052164b+z2e91460297+z2e91460297+z7e674d442a)+1.f;float zff5c9644ab=(
z55015f140e+z2e91460297+z2e91460297+z454281a538)+1.f;float z86dd029962=
z233197dcf4/zff5c9644ab;
zd30cb40f88.s0=z55015f140e*z86dd029962;zd30cb40f88.s1=z2e91460297*z86dd029962;
zd30cb40f88.s2=z454281a538*z86dd029962;z718a062ddd[z77f8ae3448]=zd30cb40f88;}
#endif
#if (z3dbd1ff682==z4937348432)
#define zec15f7fa83(zff400e9e97, z305d891f1d, za3158292ce) (zff400e9e97 * 0.299f\
 + z305d891f1d *  0.587f + za3158292ce *  0.114f)
__kernel void zc20949a44d(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z958df11031,float zab55369935){
int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;zba94ee46da+=z30eaaf69b7.s01;
float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad)];int
z77f8ae3448=zba94ee46da.x+zba94ee46da.y*(z958df11031);float4 zd30cb40f88=
z718a062ddd[z77f8ae3448];float ze4b052164b=z493deefb55.s0;float z2e91460297=
z493deefb55.s1;float z7e674d442a=z493deefb55.s2;float zdbf287f806=zd30cb40f88.s0
;float z5413c0ac97=zd30cb40f88.s1*(1.f/32767.f);float ze88d9ff858=zd30cb40f88.s2
;float z0162a73c99=0.25f*max(z5413c0ac97*(32767.f-zdbf287f806-ze88d9ff858)-50.f,
0.f);
float z55015f140e=(zdbf287f806*z5413c0ac97+z0162a73c99);float z454281a538=(
ze88d9ff858*z5413c0ac97+z0162a73c99);z55015f140e=(z55015f140e>0.f)?z55015f140e:
0.f;z454281a538=(z454281a538>0.f)?z454281a538:0.f;
float z233197dcf4=zec15f7fa83(ze4b052164b,z2e91460297,z7e674d442a)+1.f;float
zff5c9644ab=zec15f7fa83(z55015f140e,z0162a73c99,z454281a538)+1.f;
float z86dd029962=z233197dcf4/zff5c9644ab;float z33dc800fb3;if(z86dd029962>1.f)
z33dc800fb3=min(1.f,zab55369935*z86dd029962*z86dd029962);else z33dc800fb3=
zab55369935;z86dd029962=min(z86dd029962,2.0f);
z55015f140e=z55015f140e*z86dd029962*z33dc800fb3+ze4b052164b*(1.f-z33dc800fb3);
z454281a538=z454281a538*z86dd029962*z33dc800fb3+z7e674d442a*(1.f-z33dc800fb3);
z2e91460297=z0162a73c99*z86dd029962*z33dc800fb3+z2e91460297*(1.f-z33dc800fb3);
zd30cb40f88.s0=z55015f140e;zd30cb40f88.s1=z2e91460297;zd30cb40f88.s2=z454281a538
;z718a062ddd[z77f8ae3448]=zd30cb40f88;}
#endif
#if (z3dbd1ff682==zba28350a32)
__kernel void zc20949a44d(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z958df11031,float2 z5b8c31c8e4,
float4 zed5a2cac4e){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));
if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=zba94ee46da+z30eaaf69b7.s45;zba94ee46da+=z30eaaf69b7.s01;float4
z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad)];float
ze4b052164b=z493deefb55.s0;float z2e91460297=z493deefb55.s1;float z7e674d442a=
z493deefb55.s2;

float z5413c0ac97=max(ze4b052164b*zed5a2cac4e.x+z2e91460297*zed5a2cac4e.y+
z7e674d442a*zed5a2cac4e.z,1.0f)+50.f;float z0e19826f79=1.f/z5413c0ac97;
z493deefb55.s0=(ze4b052164b-z2e91460297)*z0e19826f79*z5b8c31c8e4.s0;z493deefb55.
s1=z5413c0ac97;z493deefb55.s2=(z7e674d442a-z2e91460297)*z0e19826f79*z5b8c31c8e4.
s1;z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031)]=z493deefb55;}
#endif
#if (z3dbd1ff682==za809d8fb8f)
__kernel void zc20949a44d(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z958df11031,float2 z5b8c31c8e4,
float4 zed5a2cac4e){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));
if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=zba94ee46da+z30eaaf69b7.s45;zba94ee46da+=z30eaaf69b7.s01;float4
z324e6de430=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad)];float4
ze4351005bc;float zf58e28dfbc=z324e6de430.s0*(1.f/z5b8c31c8e4.s0);
float z99e3d023d3=max(z324e6de430.s1-50.f,1.f);
float zc213106141=z324e6de430.s2*(1.f/z5b8c31c8e4.s1);
float z73c543363e=max(z99e3d023d3*(1.f-zed5a2cac4e.x*zf58e28dfbc-zed5a2cac4e.z*
zc213106141),0.f);
float z93751f94c0=max(zf58e28dfbc*(z99e3d023d3+50.f)+z73c543363e,0.f);float
zacde091c32=max(zc213106141*(z99e3d023d3+50.f)+z73c543363e,0.f);
float z94923e72b2=max(z93751f94c0*zed5a2cac4e.x+z73c543363e*zed5a2cac4e.y+
zacde091c32*zed5a2cac4e.z,1.0f);
float z86dd029962=(z99e3d023d3/z94923e72b2);
ze4351005bc.s0=z93751f94c0*z86dd029962;ze4351005bc.s1=z73c543363e*z86dd029962;
ze4351005bc.s2=zacde091c32*z86dd029962;;z718a062ddd[zba94ee46da.x+zba94ee46da.y*
(z958df11031)]=ze4351005bc;}
#endif
#define zff1f756ad9(z2dd09f3226,za3158292ce) { float z99e2655378=(z2dd09f3226);(\
z2dd09f3226)=(za3158292ce);(za3158292ce)=z99e2655378; }
#define z6891786495(z2dd09f3226,za3158292ce) { if ((z2dd09f3226)>(za3158292ce)) \
zff1f756ad9((z2dd09f3226),(za3158292ce)); }
float z3eb04b929e(float*z493deefb55){z6891786495(z493deefb55[0],z493deefb55[1]);
z6891786495(z493deefb55[3],z493deefb55[4]);z6891786495(z493deefb55[0],
z493deefb55[3]);z6891786495(z493deefb55[1],z493deefb55[4]);z6891786495(
z493deefb55[1],z493deefb55[2]);z6891786495(z493deefb55[2],z493deefb55[3]);
z6891786495(z493deefb55[1],z493deefb55[2]);return(z493deefb55[2]);
}
#if (z3dbd1ff682==z6c04799cd1)
typedef ushort z51b7908a0d;__kernel void zc20949a44d(__global float4*zf8d9fd6cb8
,__global float4*z718a062ddd,int8 z30eaaf69b7,int z45c01651ac,int z958df11031){
int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;zba94ee46da+=z30eaaf69b7.s01;float4 z395b96baac=
zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z45c01651ac)];float4 ze4351005bc;



float z7e68956b16=z395b96baac.s1;
float z19731b763d[3][5];float z4a1516272a[3][5];float z33592e8600[3][5];float
z3b40ecc762[3][5];__global float4*z9a9f4b7f55=zf8d9fd6cb8+z83640e5796.x+
z83640e5796.y*(z45c01651ac);for(int z1d8bd19892=-2;z1d8bd19892<=2;z1d8bd19892++)
{float4 z493deefb55=z9a9f4b7f55[z1d8bd19892];const int z8dd6fa68b0=z1d8bd19892+2
;z19731b763d[0][z8dd6fa68b0]=z493deefb55.x;z19731b763d[1][z8dd6fa68b0]=
z493deefb55.y;z19731b763d[2][z8dd6fa68b0]=z493deefb55.z;z493deefb55=z9a9f4b7f55[
z45c01651ac*z1d8bd19892];z4a1516272a[0][z8dd6fa68b0]=z493deefb55.x;z4a1516272a[1
][z8dd6fa68b0]=z493deefb55.y;z4a1516272a[2][z8dd6fa68b0]=z493deefb55.z;
z493deefb55=z9a9f4b7f55[(1+z45c01651ac)*z1d8bd19892];z33592e8600[0][z8dd6fa68b0]
=z493deefb55.x;z33592e8600[1][z8dd6fa68b0]=z493deefb55.y;z33592e8600[2][
z8dd6fa68b0]=z493deefb55.z;z493deefb55=z9a9f4b7f55[(1-z45c01651ac)*z1d8bd19892];
z3b40ecc762[0][z8dd6fa68b0]=z493deefb55.x;z3b40ecc762[1][z8dd6fa68b0]=
z493deefb55.y;z3b40ecc762[2][z8dd6fa68b0]=z493deefb55.z;}float z1246d82b99=
z3eb04b929e(z19731b763d[1]);float ze5c36daec4=z3eb04b929e(z4a1516272a[1]);float
za75c2b7b28=z3eb04b929e(z33592e8600[1]);float z959239d112=z3eb04b929e(
z3b40ecc762[1]);float z99e3d023d3[4]={z1246d82b99,ze5c36daec4,za75c2b7b28,
z959239d112};
float zcc218b12db[4];
zcc218b12db[0]=(z99e3d023d3[0]-z7e68956b16)*(z99e3d023d3[0]-z7e68956b16)+1.f;
zcc218b12db[1]=(z99e3d023d3[1]-z7e68956b16)*(z99e3d023d3[1]-z7e68956b16)+1.f;
zcc218b12db[2]=(z99e3d023d3[2]-z7e68956b16)*(z99e3d023d3[2]-z7e68956b16)+1.f;
zcc218b12db[3]=(z99e3d023d3[3]-z7e68956b16)*(z99e3d023d3[3]-z7e68956b16)+1.f;
z51b7908a0d z51810944b9=(zcc218b12db[0]<=zcc218b12db[1])?0:1;z51b7908a0d
zca404e2da5=(zcc218b12db[2]<=zcc218b12db[3])?2:3;float z59da5c1f43=1.f/(
zcc218b12db[zca404e2da5]+zcc218b12db[z51810944b9]);zcc218b12db[z51810944b9]*=
z59da5c1f43;zcc218b12db[zca404e2da5]*=z59da5c1f43;
float zff5c9644ab=(zcc218b12db[zca404e2da5]*z99e3d023d3[z51810944b9]+zcc218b12db
[z51810944b9]*z99e3d023d3[zca404e2da5]);
float z7e43544d97=(z51810944b9==0)?z3eb04b929e(z19731b763d[0]):z3eb04b929e(
z4a1516272a[0]);float z386d28d31b=(zca404e2da5==2)?z3eb04b929e(z33592e8600[0]):
z3eb04b929e(z3b40ecc762[0]);
float z5bbf12fa92=(zcc218b12db[zca404e2da5]*z7e43544d97+zcc218b12db[z51810944b9]
*z386d28d31b);
z7e43544d97=(z51810944b9==0)?z3eb04b929e(z19731b763d[2]):z3eb04b929e(z4a1516272a
[2]);z386d28d31b=(zca404e2da5==2)?z3eb04b929e(z33592e8600[2]):z3eb04b929e(
z3b40ecc762[2]);
float z4c014a17da=(zcc218b12db[zca404e2da5]*z7e43544d97+zcc218b12db[z51810944b9]
*z386d28d31b);
ze4351005bc.s0=z5bbf12fa92;ze4351005bc.s1=zff5c9644ab;ze4351005bc.s2=z4c014a17da
;z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031)]=ze4351005bc;}
#endif
#if (z3dbd1ff682==ze4592bb8c3)
__kernel void zc20949a44d(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z45c01651ac,int z958df11031,float4 z7c54807ee5)
{int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;zba94ee46da+=z30eaaf69b7.s01;float4 z395b96baac=
zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z45c01651ac)];float4 ze4351005bc=
z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031)];const float zdbd1b64bbd=
z7c54807ee5.s0;const float z0893e495b9=z7c54807ee5.s1;const float z9f2409475e=
z7c54807ee5.s2;const float z7c95d32f3a=z7c54807ee5.s3;
float z26223e2448=z395b96baac.s0;float z7e68956b16=z395b96baac.s1;float
z6815e0b2ba=z395b96baac.s2;
float zf58e28dfbc=ze4351005bc.s0;float z99e3d023d3=ze4351005bc.s1;float
zc213106141=ze4351005bc.s2;
float za48d1a3705=(z7e68956b16-z99e3d023d3)*(z7e68956b16-z99e3d023d3);
za48d1a3705+=(z26223e2448*z7e68956b16-zf58e28dfbc*z99e3d023d3)*(z26223e2448*
z7e68956b16-zf58e28dfbc*z99e3d023d3);za48d1a3705+=(z6815e0b2ba*z7e68956b16-
zc213106141*z99e3d023d3)*(z6815e0b2ba*z7e68956b16-zc213106141*z99e3d023d3);
float za872a1acf4=za48d1a3705*zdbd1b64bbd;float zc5c8f034dd=za48d1a3705*
z0893e495b9;
float zac03b8df64=((z7c95d32f3a*z7c95d32f3a)+z9f2409475e*z99e3d023d3);
float z0ced10a418=zac03b8df64*zac03b8df64;zc5c8f034dd=z0ced10a418/(z0ced10a418+
zc5c8f034dd*zac03b8df64+zc5c8f034dd*zc5c8f034dd);za872a1acf4=z0ced10a418/(
z0ced10a418+za872a1acf4*zac03b8df64+za872a1acf4*za872a1acf4);
ze4351005bc.s0=z26223e2448*(1.f-zc5c8f034dd)+zf58e28dfbc*zc5c8f034dd;ze4351005bc
.s1=z7e68956b16*(1.f-za872a1acf4)+z99e3d023d3*za872a1acf4;ze4351005bc.s2=
z6815e0b2ba*(1.f-zc5c8f034dd)+zc213106141*zc5c8f034dd;z718a062ddd[zba94ee46da.x+
zba94ee46da.y*(z958df11031)]=ze4351005bc;}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
