#define z3dbd1ff682 1

#ifndef z3dbd1ff682
#define z3dbd1ff682 0
#endif
#define zec15f7fa83(zff400e9e97, z305d891f1d, za3158292ce) (zff400e9e97 * 0.299f\
 + z305d891f1d *  0.587f + za3158292ce *  0.114f)
#define z38c913a03a 10
float z3741ed4e99(float z64e69d3b08){float z55c265223f=z64e69d3b08*0.012f;if(
z55c265223f<0)z55c265223f=z64e69d3b08*0.003f;return z55c265223f;}float4
z03aeac13a1(float4 z395b96baac,float4 z7c54807ee5){float z06a814d67d=z7c54807ee5
.x;float za6bdffcee5=z7c54807ee5.y;float z0c1a1e3a50=z7c54807ee5.z;float
zb9abd16234=z7c54807ee5.w;float ze4b052164b=z395b96baac.s0;float z2e91460297=
z395b96baac.s1;float z7e674d442a=z395b96baac.s2;float z93751f94c0=ze4b052164b;
float z73c543363e=z2e91460297;float zacde091c32=z7e674d442a;if(ze4b052164b>
z06a814d67d){float zec65e8d581=(ze4b052164b-z06a814d67d)*(zb9abd16234/
z06a814d67d);zec65e8d581*=min(z2e91460297,z7e674d442a)/ze4b052164b;
zec65e8d581=min(zec65e8d581,1.f);z93751f94c0=(z2e91460297+z7e674d442a)*0.5f*
zec65e8d581+ze4b052164b*(1.f-zec65e8d581);}if(z2e91460297>za6bdffcee5){float
zec65e8d581=(z2e91460297-za6bdffcee5)*(zb9abd16234/za6bdffcee5);zec65e8d581*=min
(ze4b052164b,z7e674d442a)/z2e91460297;
zec65e8d581=min(zec65e8d581,1.f);z73c543363e=(ze4b052164b+z7e674d442a)*0.5*
zec65e8d581+z2e91460297*(1.f-zec65e8d581);}if(z7e674d442a>z0c1a1e3a50){float
zec65e8d581=(z7e674d442a-z0c1a1e3a50)*(zb9abd16234/z0c1a1e3a50);zec65e8d581*=min
(z2e91460297,ze4b052164b)/z7e674d442a;
zec65e8d581=min(zec65e8d581,1.f);zacde091c32=(z2e91460297+ze4b052164b)*0.5*
zec65e8d581+z7e674d442a*(1.f-zec65e8d581);}return(float4)(z93751f94c0,
z73c543363e,zacde091c32,0.0f);}
#if (z3dbd1ff682==0 )
#define z84a1826b4b 0
__kernel void zb0e1f01eac(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,uint z021babbfad,uint z958df11031,float4
z1850220e50,__global float*z9466dfc077,int4 z51da8fcd33,__global float*
za2de0f1b59,int4 z446ab76a49,__global uchar*zec145e35cf,int16 z3576e84f20,
float16 z4af71b4d47){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));
if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7
.s01;int2 zdc2396006d=zba94ee46da+z51da8fcd33.xy;int4 z23c2aac8ba=z51da8fcd33;
__global float*z4db505aa5b=z9466dfc077;float4 z395b96baac=zf8d9fd6cb8[
z83640e5796.x+z83640e5796.y*(z021babbfad)];float z55c265223f=z1850220e50.s0;

int2 z9b046bc3a1=z83640e5796;
int zfcaa177308=z3576e84f20.sa;int z98cd6733c3=z9b046bc3a1.x+z9b046bc3a1.y*
zfcaa177308;int*z6016b79538=(int*)&z3576e84f20;float*z41d2ba07fc=(float*)&
z4af71b4d47;for(int z1d8bd19892=0;z1d8bd19892<z38c913a03a;z1d8bd19892++){if(fabs
(z41d2ba07fc[z1d8bd19892])>=0.00001&&z6016b79538[z1d8bd19892]>=0){__global uchar
*zdd12fcd6f3=zec145e35cf+z6016b79538[z1d8bd19892];uchar za097e3cbf4=zdd12fcd6f3[
z98cd6733c3];if(za097e3cbf4>0)z55c265223f+=(convert_float(za097e3cbf4)/255.0f)*
z41d2ba07fc[z1d8bd19892];}}z55c265223f=z3741ed4e99(z55c265223f);if(z55c265223f<
0.f){
z23c2aac8ba=z446ab76a49;z4db505aa5b=za2de0f1b59;}int2 z3d0133158d=zba94ee46da+
z23c2aac8ba.xy;int z97e9e3592b=z23c2aac8ba.z;float z99e3d023d3=z4db505aa5b[
z3d0133158d.x+z3d0133158d.y*z97e9e3592b];const float z2e75598026=z1850220e50.s1;
float ze4b052164b=z395b96baac.x;
float z2e91460297=z395b96baac.y;
float z7e674d442a=z395b96baac.z;
float z5413c0ac97=zec15f7fa83(ze4b052164b,z2e91460297,z7e674d442a)+16.f;

float z86dd029962=1.f;
if(z55c265223f>0.f){
z99e3d023d3*=z99e3d023d3;
float z430ec6620e=(z5413c0ac97-z99e3d023d3)*z55c265223f/z5413c0ac97;
if(z430ec6620e>0.f)z430ec6620e=z430ec6620e/(1.f+(z430ec6620e)*z2e75598026);else
z430ec6620e=z430ec6620e/(1.f-(z430ec6620e)*(z2e75598026*16.f));z86dd029962=1.f+
z430ec6620e;}else{
float z0ec27a7836=sqrt(z5413c0ac97);float z430ec6620e=(z0ec27a7836-z99e3d023d3)*
z55c265223f/z0ec27a7836;z86dd029962=(1.f+z430ec6620e);z86dd029962*=z86dd029962;}
ze4b052164b*=z86dd029962;z2e91460297*=z86dd029962;z7e674d442a*=z86dd029962;








z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*(z958df11031)]=max((float4)(ze4b052164b,
z2e91460297,z7e674d442a,0.0f),(float4)0.0f);}
#endif
#if (z3dbd1ff682==1 || z3dbd1ff682==4 )
#if (z3dbd1ff682==4)
typedef float4 z49bb0c3142;
#else
typedef float z49bb0c3142;
#endif
__kernel void zb0e1f01eac(__global ushort*zf8d9fd6cb8,__global z49bb0c3142*
zda4322ccc1,int8 z30eaaf69b7,uint z45c01651ac,uint z1d0320a710,float4
z510a0f1615,int8 z3c211c8179,int2 zc43d31b365,float4 z877643e334){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;
int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;__global ushort*zafc1b9c03d=
zf8d9fd6cb8+z30eaaf69b7.s4+z45c01651ac*z30eaaf69b7.s5;int z9ff4c70178=
zaaf414d14e.x;int zdd2d930402=zaaf414d14e.y;int z39f1535455=zc43d31b365.x;int
z9528763067=zc43d31b365.y;int z3a51e9cb82=z3c211c8179.s0;int z7ae4f3acb1=
z3c211c8179.s1;int step=z3c211c8179.s2;int z3818e6672f=z3c211c8179.s3;int
z16820f51cd=z3c211c8179.s4;int ze9c8bebcb5=z3c211c8179.s5;int z392c295a21=
z3c211c8179.s6;int zc49375bee7=z3c211c8179.s7;float z2aebdcc884=z510a0f1615.x;
float zb02ae78c47=z510a0f1615.y;float za5d7afb225=z510a0f1615.z;z49bb0c3142
z6c1fbf0a77=(z49bb0c3142)0.0f;int za3584c0652=2+8*zba94ee46da.y;int zc180b9cdc9=
2+8*zba94ee46da.x;for(int y=za3584c0652;y<=za3584c0652+4;y+=4){for(int x=
zc180b9cdc9;x<=zc180b9cdc9+4;x+=4){
int z4fbbccd16f=min(max(y+z9528763067,step*2),z7ae4f3acb1);int ze2316382b7=(x+
z39f1535455>step*2)?min(x+z39f1535455,z3a51e9cb82):(step*2);__global ushort*
z3fd5faa76d=zafc1b9c03d+z392c295a21*z4fbbccd16f+step*ze2316382b7;
z3fd5faa76d+=z3818e6672f;float ze4b052164b=z2aebdcc884*convert_float(z3fd5faa76d
[z16820f51cd]);float z2e91460297=zb02ae78c47*convert_float(z3fd5faa76d[
ze9c8bebcb5]);float z7e674d442a=za5d7afb225*convert_float(z3fd5faa76d[
zc49375bee7]);
#if (z3dbd1ff682==4)
z6c1fbf0a77+=(float4)(ze4b052164b,z2e91460297,z7e674d442a,0.0f);
#else
float z5413c0ac97=zec15f7fa83(ze4b052164b,z2e91460297,z7e674d442a);z6c1fbf0a77+=
z5413c0ac97;
#endif
}}z6c1fbf0a77=(z6c1fbf0a77+16.0f)*0.25f;
#if (z3dbd1ff682==4)
z6c1fbf0a77=z03aeac13a1(z6c1fbf0a77,z877643e334);
#endif
z6c1fbf0a77=sqrt(z6c1fbf0a77);zda4322ccc1[(zdd2d930402)*z1d0320a710+(z9ff4c70178
)]=z6c1fbf0a77;}




#endif
#if (z3dbd1ff682==2 || z3dbd1ff682==3)
#if (z3dbd1ff682==3)
typedef float4 z49bb0c3142;
#else
typedef float z49bb0c3142;
#endif
__kernel void zb0e1f01eac(__global ushort*zf8d9fd6cb8,__global z49bb0c3142*
zda4322ccc1,int8 z30eaaf69b7,uint z45c01651ac,uint z1d0320a710,float4
z510a0f1615,int8 z3c211c8179,int2 zc43d31b365,float4 z877643e334){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;
int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int z703bf69d7d=z3c211c8179.s0;int
z01dc47fd03=z3c211c8179.s1;int step=z3c211c8179.s2;int z392c295a21=z3c211c8179.
s3;__global ushort*zafc1b9c03d=zf8d9fd6cb8+3*z30eaaf69b7.s4+z45c01651ac*
z30eaaf69b7.s5;int z9ff4c70178=zaaf414d14e.x;int zdd2d930402=zaaf414d14e.y;int
z39f1535455=zc43d31b365.x;int z9528763067=zc43d31b365.y;float z2aebdcc884=
z510a0f1615.x;float zb02ae78c47=z510a0f1615.y;float za5d7afb225=z510a0f1615.z;
z49bb0c3142 z6c1fbf0a77=(z49bb0c3142)0.0f;int za3584c0652=2+8*zba94ee46da.y;int
zc180b9cdc9=2+8*zba94ee46da.x;for(int y=za3584c0652;y<=za3584c0652+4;y+=4){for(
int x=zc180b9cdc9;x<=zc180b9cdc9+4;x+=4){
int z4fbbccd16f=min(max(y+z9528763067,0),z01dc47fd03);int ze2316382b7=(x>-
z39f1535455)?min(x+z39f1535455,z703bf69d7d):0;__global ushort*z3fd5faa76d=
zafc1b9c03d+z392c295a21*z4fbbccd16f+step*ze2316382b7;float ze4b052164b=
z2aebdcc884*convert_float(z3fd5faa76d[0]);float z2e91460297=zb02ae78c47*
convert_float(z3fd5faa76d[1]);float z7e674d442a=za5d7afb225*convert_float(
z3fd5faa76d[2]);
#if (z3dbd1ff682==3)
z6c1fbf0a77+=(float4)(ze4b052164b,z2e91460297,z7e674d442a,0.0f);
#else
float z5413c0ac97=zec15f7fa83(ze4b052164b,z2e91460297,z7e674d442a);z6c1fbf0a77+=
z5413c0ac97;
#endif
}}z6c1fbf0a77=(z6c1fbf0a77+(z49bb0c3142)16.0f)*(z49bb0c3142)0.25f;
#if (z3dbd1ff682==3)
z6c1fbf0a77=z03aeac13a1(z6c1fbf0a77,z877643e334);
#endif
z6c1fbf0a77=sqrt(z6c1fbf0a77);zda4322ccc1[(zdd2d930402)*z1d0320a710+(z9ff4c70178
)]=z6c1fbf0a77;}




#endif
#if ( z3dbd1ff682 ==5)
#define z84a1826b4b 0
typedef float4 zea5f14e1d1;__kernel void zb0e1f01eac(__global float4*zf8d9fd6cb8
,__global float4*z718a062ddd,int8 z30eaaf69b7,uint z021babbfad,uint z958df11031,
float4 z1850220e50,__global zea5f14e1d1*z9466dfc077,int4 z51da8fcd33,__global
zea5f14e1d1*za2de0f1b59,int4 z446ab76a49,__global uchar*zec145e35cf,int16
z3576e84f20,float16 z4af71b4d47){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.
s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=
zba94ee46da+z30eaaf69b7.s01;float4 z395b96baac=zf8d9fd6cb8[z83640e5796.x+
z83640e5796.y*(z021babbfad)];int4 z23c2aac8ba=z51da8fcd33;__global zea5f14e1d1*
z4db505aa5b=z9466dfc077;const float z258a407c2d=z1850220e50.s0;float z55c265223f
=z258a407c2d;

int2 z9b046bc3a1=z83640e5796;
int zfcaa177308=z3576e84f20.sa;int z98cd6733c3=z9b046bc3a1.x+z9b046bc3a1.y*
zfcaa177308;int*z6016b79538=(int*)&z3576e84f20;float*z41d2ba07fc=(float*)&
z4af71b4d47;for(int z1d8bd19892=0;z1d8bd19892<z38c913a03a;z1d8bd19892++){if(fabs
(z41d2ba07fc[z1d8bd19892])>=0.00001&&z6016b79538[z1d8bd19892]>=0){__global uchar
*zdd12fcd6f3=zec145e35cf+z6016b79538[z1d8bd19892];uchar za097e3cbf4=zdd12fcd6f3[
z98cd6733c3];if(za097e3cbf4>0)z55c265223f+=(convert_float(za097e3cbf4)/255.0f)*
z41d2ba07fc[z1d8bd19892];}}z55c265223f=z3741ed4e99(z55c265223f);if(z55c265223f<
0.f){
z23c2aac8ba=z446ab76a49;z4db505aa5b=za2de0f1b59;}int2 z3d0133158d=zba94ee46da+
z23c2aac8ba.xy;int z97e9e3592b=z23c2aac8ba.z;zea5f14e1d1 ze425b8a6d8=z4db505aa5b
[z3d0133158d.x+z3d0133158d.y*z97e9e3592b];const float z2e75598026=z1850220e50.s1
;float ze4b052164b=z395b96baac.x;
float z2e91460297=z395b96baac.y;
float z7e674d442a=z395b96baac.z;

ze425b8a6d8*=ze425b8a6d8;float z89bf92fb40=(ze4b052164b-ze425b8a6d8.x)*
z55c265223f;float z2512a48b1a=(z2e91460297-ze425b8a6d8.y)*z55c265223f;float
zd94f9d3bf8=(z7e674d442a-ze425b8a6d8.z)*z55c265223f;
if(z89bf92fb40<0.f)z89bf92fb40=z89bf92fb40*ze4b052164b/(ze4b052164b-(z89bf92fb40
)*z2e75598026);if(z2512a48b1a<0.f)z2512a48b1a=z2512a48b1a*z2e91460297/(
z2e91460297-(z2512a48b1a)*z2e75598026);if(zd94f9d3bf8<0.f)zd94f9d3bf8=
zd94f9d3bf8*z7e674d442a/(z7e674d442a-(zd94f9d3bf8)*z2e75598026);
ze4b052164b=ze4b052164b+z89bf92fb40-16.f;z2e91460297=z2e91460297+z2512a48b1a-
16.f;z7e674d442a=z7e674d442a+zd94f9d3bf8-16.f;



z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*(z958df11031)]=max((float4)(ze4b052164b,
z2e91460297,z7e674d442a,0.0f),(float4)0.0f);}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
