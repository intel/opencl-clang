#define z93a6893130 16
float zec15f7fa83(float4 z205d564e2f){return dot(z205d564e2f,(float4)(0.299f,
0.587f,0.114f,0.0f));}float zccc9dfa0f4(float4 z205d564e2f){return dot(
z205d564e2f,(float4)(0.596f,-0.275f,-0.321f,0.0f));}float z7f23f2b4e7(float4
z205d564e2f){return dot(z205d564e2f,(float4)(0.212f,-0.523f,0.311f,0.0f));}float
 zabeb4c7584(float4 ze28128c2dd){return dot(ze28128c2dd,(float4)(1.0f,0.956f,
0.621f,0.0f));}float z4da1a9cacc(float4 ze28128c2dd){return dot(ze28128c2dd,(
float4)(1.0f,-0.272f,-0.647f,0.0f));}float za939104fcd(float4 ze28128c2dd){
return dot(ze28128c2dd,(float4)(1.0f,-1.105f,1.702f,0.0f));}
#ifndef z93a6893130
#define z38c913a03a 0
#else
#define z38c913a03a z93a6893130
#endif
#define	z8cdb3022d5 0
#define	ze0f4d56203 1
#define	z7d2f9d68f2 2
#define	zdb8ca4979c 3
inline float z3741ed4e99(int zf807cc0b86,float z64e69d3b08){float z55c265223f=
z64e69d3b08*0.005f;if(z55c265223f<0)z55c265223f*=0.5f;if(zf807cc0b86==
ze0f4d56203)z55c265223f*=1.2f;return z55c265223f;}inline float zed389ca108(int
zf807cc0b86,float z64e69d3b08){return z3741ed4e99(zf807cc0b86,z64e69d3b08)*2.0f;
}__kernel void z1a1bdd4bc6(__global ushort4*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int4 z30eaaf69b7,int z45c01651ac,int zb41a4b7008,__global float4*
z758a551ffb,int z13849615d3,float zf7fc1a6db6,int2 zd72c7cd02e,int zce7e428e71,
int z5599675f2e,__global uchar*zec145e35cf,int16 z7f76fb323c,int4 z3576e84f20,
float16 z4af71b4d47,int zf807cc0b86){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)
return;int2 z1b328e7f39=(int2)(get_global_id(0),get_global_id(1));zba94ee46da+=
z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;int z3b23994384=z83640e5796.x+
z83640e5796.y*(z45c01651ac/4);int z77f8ae3448=z83640e5796.x+z83640e5796.y*(
zb41a4b7008/4);ushort4 z493deefb55=zf8d9fd6cb8[z3b23994384];float4 z1ba64f1f2a=
convert_float4(z493deefb55);__global float4*zc30f8887ef=z758a551ffb;z1b328e7f39
+=zd72c7cd02e.xy;int z910b0f86fe=z1b328e7f39.y/zce7e428e71;int zad47d72831=
z1b328e7f39.x/zce7e428e71;

float4 z5ab765f3ab=zc30f8887ef[(z910b0f86fe)*z13849615d3+(zad47d72831)];float4
z2704b555ed=zc30f8887ef[(z910b0f86fe)*z13849615d3+(zad47d72831+1)];float4
z0326abd708=zc30f8887ef[(z910b0f86fe+1)*z13849615d3+(zad47d72831)];float4
zf8ab21b848=zc30f8887ef[(z910b0f86fe+1)*z13849615d3+(zad47d72831+1)];

float z4d3b2249aa=convert_float(z1b328e7f39.x&(zce7e428e71-1));float z49c0b18d74
=convert_float(zce7e428e71)-z4d3b2249aa;float zc2bc58c52c=convert_float(
z1b328e7f39.y&(zce7e428e71-1));float z981b814bdd=convert_float(zce7e428e71)-
zc2bc58c52c;float4 zc20893b06d=z4d3b2249aa*z2704b555ed+z49c0b18d74*z5ab765f3ab;
float4 z976c4c4519=z4d3b2249aa*zf8ab21b848+z49c0b18d74*z0326abd708;float4
z0d8849857d=z981b814bdd*zc20893b06d+zc2bc58c52c*z976c4c4519;float z56abd2ad9d=
convert_float(zce7e428e71*zce7e428e71);float z9c02de091b=z56abd2ad9d*z56abd2ad9d
;
z0d8849857d=z0d8849857d*(1.0f/(z56abd2ad9d*z9c02de091b));int2 z9b046bc3a1=
z83640e5796;
int zfcaa177308=z3576e84f20.s2;int z98cd6733c3=z9b046bc3a1.x+z9b046bc3a1.y*
zfcaa177308;int*z6016b79538=(int*)&z7f76fb323c;float*za22b597f84=(float*)&
z4af71b4d47;for(int z1d8bd19892=0;z1d8bd19892<z38c913a03a;z1d8bd19892++){if(fabs
(za22b597f84[z1d8bd19892])>=0.00001&&z6016b79538[z1d8bd19892]>=0){__global uchar
*zdd12fcd6f3=zec145e35cf+z6016b79538[z1d8bd19892];uchar za097e3cbf4=zdd12fcd6f3[
z98cd6733c3];if(za097e3cbf4>0)zf7fc1a6db6+=(convert_float(za097e3cbf4)/255.0f)*
za22b597f84[z1d8bd19892];}}if(zce7e428e71<8)
zf7fc1a6db6=zed389ca108(zf807cc0b86,zf7fc1a6db6);else zf7fc1a6db6=z3741ed4e99(
zf807cc0b86,zf7fc1a6db6);
float4 za67066c246=z1ba64f1f2a-z0d8849857d;if(z5599675f2e==1)z1ba64f1f2a=
convert_float4(z718a062ddd[z77f8ae3448]);z1ba64f1f2a=z1ba64f1f2a+za67066c246*
zf7fc1a6db6;z1ba64f1f2a=clamp(z1ba64f1f2a,(float4)0.0f,(float4)65535.0f);
z718a062ddd[z77f8ae3448]=convert_ushort4(z1ba64f1f2a);}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
