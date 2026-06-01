#define z3dbd1ff682 0

#ifndef z3dbd1ff682
#define z3dbd1ff682 1
#endif
#define z38c913a03a 10

#if 0
static float zed389ca108(z97dca13c13 zf807cc0b86,float z64e69d3b08){float
z55c265223f=z64e69d3b08*0.02f;if(z55c265223f<0)z55c265223f=z64e69d3b08*0.01f;
return z55c265223f;}
#else
float zed389ca108(float z64e69d3b08){if(z64e69d3b08<0.0f)return z64e69d3b08*
0.01f;else return z64e69d3b08*0.02f;}
#endif
#define zec15f7fa83(zff400e9e97, z305d891f1d, za3158292ce) (zff400e9e97 * 0.299f\
 + z305d891f1d *  0.587f + za3158292ce *  0.114f)
#if (z3dbd1ff682==0)
__kernel void z7b5890b626(__global float4*zf8d9fd6cb8,__global float*z718a062ddd
,int8 z30eaaf69b7,uint z021babbfad,uint z958df11031){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;
zba94ee46da+=z30eaaf69b7.s01;float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+
z83640e5796.y*(z021babbfad)];float z5413c0ac97=zec15f7fa83(z493deefb55.x,
z493deefb55.y,z493deefb55.z)+16.f;z718a062ddd[zba94ee46da.x+zba94ee46da.y*(
z958df11031)]=sqrt(z5413c0ac97);}
#endif
#if (z3dbd1ff682==1)
#define z84a1826b4b 0
#define MAX max
__kernel void z7b5890b626(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,uint z021babbfad,uint z958df11031,float4
zdcf7ad01e1,__global float*z5413c0ac97,int4 z0cda232ab2,__global float*
z6dbcfbb363,int4 zf719ec198f,__global uchar*zec145e35cf,int16 z3576e84f20,
float16 z4af71b4d47){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));
if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7
.s01;int2 zdc2396006d=zba94ee46da+z0cda232ab2.xy;int2 z40c99fd15e=zba94ee46da+
zf719ec198f.xy;int z0b6cb751d4=z0cda232ab2.z;int z4a8c908862=zf719ec198f.z;
float4 z395b96baac=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad)];float
z7e68956b16=z5413c0ac97[zdc2396006d.x+zdc2396006d.y*z0b6cb751d4];float
z99e3d023d3=z6dbcfbb363[z40c99fd15e.x+z40c99fd15e.y*z4a8c908862];
const float z2e75598026=zdcf7ad01e1.s1;float z55c265223f=zdcf7ad01e1.s0;int2
z9b046bc3a1=z83640e5796;
int zfcaa177308=z3576e84f20.sa;int z98cd6733c3=z9b046bc3a1.x+z9b046bc3a1.y*
zfcaa177308;int*z6016b79538=(int*)&z3576e84f20;float*z41d2ba07fc=(float*)&
z4af71b4d47;for(int z1d8bd19892=0;z1d8bd19892<z38c913a03a;z1d8bd19892++){if(fabs
(z41d2ba07fc[z1d8bd19892])>=0.00001&&z6016b79538[z1d8bd19892]>=0){__global uchar
*zdd12fcd6f3=zec145e35cf+z6016b79538[z1d8bd19892];uchar za097e3cbf4=zdd12fcd6f3[
z98cd6733c3];if(za097e3cbf4>0)z55c265223f+=(convert_float(za097e3cbf4)/255.0f)*
z41d2ba07fc[z1d8bd19892];}}z55c265223f=zed389ca108(z55c265223f);float
ze4b052164b=z395b96baac.x;
float z2e91460297=z395b96baac.y;
float z7e674d442a=z395b96baac.z;
#if 0
float z99e3d023d3=z7f3194e771[x];
float z7e68956b16=z2416fbcc28[x];
float ze4b052164b=z395b96baac[3*x];float z2e91460297=z395b96baac[3*x+1];float
z7e674d442a=z395b96baac[3*x+2];
#endif



float z430ec6620e=(z7e68956b16-z99e3d023d3)*z55c265223f/z7e68956b16;
if(z430ec6620e<0.f&&z55c265223f>0.f)z430ec6620e=z430ec6620e/(1.f-(z430ec6620e)*
z2e75598026);float z86dd029962=1.f+z430ec6620e;z86dd029962=MAX(z86dd029962,0.f);
z86dd029962*=z86dd029962;
ze4b052164b*=z86dd029962;z2e91460297*=z86dd029962;z7e674d442a*=z86dd029962;if(
z84a1826b4b==6){
ze4b052164b=z2e91460297=z7e674d442a=z99e3d023d3;}
#if 0
else{
float z977575c19f=zed389ca108(ze0f4d56203,z01f95b82e5[z182e74dd31*y+x]);float
z430ec6620e=(z7e68956b16-z99e3d023d3)*z977575c19f/z7e68956b16;
if(z430ec6620e<0.f&&z977575c19f>0.f)z430ec6620e=z430ec6620e/(1.f-(z430ec6620e)*
z2e75598026);float z86dd029962=1.f+z430ec6620e;z86dd029962=MAX(z86dd029962,0.f);
z86dd029962*=z86dd029962;
ze4b052164b*=z86dd029962;z2e91460297*=z86dd029962;z7e674d442a*=z86dd029962;}
#endif




z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*(z958df11031)]=(float4)(ze4b052164b,
z2e91460297,z7e674d442a,0.0f);}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
