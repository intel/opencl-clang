float zec15f7fa83(float4 z205d564e2f){return dot(z205d564e2f,(float4)(0.299f,
0.587f,0.114f,0.0f));}float zccc9dfa0f4(float4 z205d564e2f){return dot(
z205d564e2f,(float4)(0.596f,-0.275f,-0.321f,0.0f));}float z7f23f2b4e7(float4
z205d564e2f){return dot(z205d564e2f,(float4)(0.212f,-0.523f,0.311f,0.0f));}float
 zabeb4c7584(float4 ze28128c2dd){return dot(ze28128c2dd,(float4)(1.0f,0.956f,
0.621f,0.0f));}float z4da1a9cacc(float4 ze28128c2dd){return dot(ze28128c2dd,(
float4)(1.0f,-0.272f,-0.647f,0.0f));}float za939104fcd(float4 ze28128c2dd){
return dot(ze28128c2dd,(float4)(1.0f,-1.105f,1.702f,0.0f));}__kernel void
z7c242b1d55(__global ushort4*zf8d9fd6cb8,__global ushort4*z718a062ddd,int4
z30eaaf69b7,uint z45c01651ac,uint z745057f086,__global float*z3ad6f7586a,uint
zb85bf64f18,float z3ee057f4d6,int2 zd72c7cd02e,__global uchar*zec145e35cf,int16
z3576e84f20,float16 z4af71b4d47){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)
return;int2 zdc2396006d=(int2)(get_global_id(0),get_global_id(1));zba94ee46da+=
z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;int2 z9b046bc3a1=z83640e5796;
int zfcaa177308=z3576e84f20.sa;int z98cd6733c3=z9b046bc3a1.x+z9b046bc3a1.y*
zfcaa177308;int*z6016b79538=(int*)&z3576e84f20;float*za22b597f84=(float*)&
z4af71b4d47;
#define z38c913a03a 10
for(int z1d8bd19892=0;z1d8bd19892<z38c913a03a;z1d8bd19892++){if(fabs(za22b597f84
[z1d8bd19892])>=0.00001&&z6016b79538[z1d8bd19892]>=0){__global uchar*zdd12fcd6f3
=zec145e35cf+z6016b79538[z1d8bd19892];uchar za097e3cbf4=zdd12fcd6f3[z98cd6733c3]
;if(za097e3cbf4>0)z3ee057f4d6+=(convert_float(za097e3cbf4)/255.0f)*za22b597f84[
z1d8bd19892];}}ushort4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(
z45c01651ac/4)];float4 z1ba64f1f2a=convert_float4(z493deefb55);int z0b6cb751d4=
zb85bf64f18;__global float*z1765c59f1b=z3ad6f7586a;zdc2396006d+=zd72c7cd02e.xy;
int z910b0f86fe=zdc2396006d.y>>3;int zad47d72831=zdc2396006d.x>>3;

float z5ab765f3ab=z1765c59f1b[(z910b0f86fe)*z0b6cb751d4+(zad47d72831)];float
z2704b555ed=z1765c59f1b[(z910b0f86fe)*z0b6cb751d4+(zad47d72831+1)];float
z0326abd708=z1765c59f1b[(z910b0f86fe+1)*z0b6cb751d4+(zad47d72831)];float
zf8ab21b848=z1765c59f1b[(z910b0f86fe+1)*z0b6cb751d4+(zad47d72831+1)];

int z4d3b2249aa=zdc2396006d.x&7;int z49c0b18d74=8-z4d3b2249aa;int zc2bc58c52c=
zdc2396006d.y&7;int z981b814bdd=8-zc2bc58c52c;float zc20893b06d=z4d3b2249aa*
z2704b555ed+z49c0b18d74*z5ab765f3ab;float z976c4c4519=z4d3b2249aa*zf8ab21b848+
z49c0b18d74*z0326abd708;float z069e59924c=z981b814bdd*zc20893b06d+zc2bc58c52c*
z976c4c4519;
z069e59924c=z069e59924c*(1.0f/(64.0f*4096.0f));float Y=zec15f7fa83(z1ba64f1f2a);
float z68bae40cb3=zccc9dfa0f4(z1ba64f1f2a);float z9386a0103f=z7f23f2b4e7(
z1ba64f1f2a);float z0769e9b6f8=Y-z069e59924c;Y=Y+z0769e9b6f8*z3ee057f4d6;
float z77b77068b3=zabeb4c7584((float4)(Y,z68bae40cb3,z9386a0103f,0.0f));float
z49863d9014=z4da1a9cacc((float4)(Y,z68bae40cb3,z9386a0103f,0.0f));float
z585b87d822=za939104fcd((float4)(Y,z68bae40cb3,z9386a0103f,0.0f));if(z77b77068b3
<0.0f)z77b77068b3=0.0f;else if(z77b77068b3>65535.0f)z77b77068b3=65535.0f;if(
z49863d9014<0.0f)z49863d9014=0.0f;else if(z49863d9014>65535.0f)z49863d9014=
65535.0f;if(z585b87d822<0.0f)z585b87d822=0.0f;else if(z585b87d822>65535.0f)
z585b87d822=65535.0f;


z493deefb55=convert_ushort4((float4)(z77b77068b3,z49863d9014,z585b87d822,
z1ba64f1f2a.w));
int z77f8ae3448=zba94ee46da.x+zba94ee46da.y*(z745057f086/4);z718a062ddd[
z77f8ae3448]=z493deefb55;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
