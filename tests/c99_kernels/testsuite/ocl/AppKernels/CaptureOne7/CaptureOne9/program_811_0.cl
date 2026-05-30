#define zbc6516e8d5  0














#define zdcc1f6f2eb(z95287ec68e,zf8d9fd6cb8,z718a062ddd,z3b23994384, z77f8ae3448\
, zb3ec2e5425, z975716b4ab, zf77c7f8449, z47728d2efe, z77c9074137) \
 z95287ec68e(&z718a062ddd[z77f8ae3448], &zf8d9fd6cb8[z3b23994384] ); \
 if (zf77c7f8449.x < z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448-z975716b4ab.x], & zf8d9fd6cb8[z3b23994384-\
zb3ec2e5425.x]); \
 if (zf77c7f8449.y < z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448-z975716b4ab.y], & zf8d9fd6cb8[z3b23994384-\
zb3ec2e5425.y]); \
 if (zf77c7f8449.x >= z47728d2efe.x-z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448+z975716b4ab.x], & zf8d9fd6cb8[z3b23994384+\
zb3ec2e5425.x]); \
 if (zf77c7f8449.y >= z47728d2efe.y-z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448+z975716b4ab.y], & zf8d9fd6cb8[z3b23994384+\
zb3ec2e5425.y]); \
 if (zf77c7f8449.x < z77c9074137 && zf77c7f8449.y < z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448-z975716b4ab.x-z975716b4ab.y], & \
zf8d9fd6cb8[z3b23994384-zb3ec2e5425.x-zb3ec2e5425.y]); \
 if (zf77c7f8449.x >= z47728d2efe.x-z77c9074137 && zf77c7f8449.y < z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448+z975716b4ab.x-z975716b4ab.y], & \
zf8d9fd6cb8[z3b23994384+zb3ec2e5425.x-zb3ec2e5425.y]); \
 if (zf77c7f8449.x < z77c9074137 && zf77c7f8449.y >= z47728d2efe.y-z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448-z975716b4ab.x+z975716b4ab.y], & \
zf8d9fd6cb8[z3b23994384-zb3ec2e5425.x+zb3ec2e5425.y]); \
 if (zf77c7f8449.x >= z47728d2efe.x-z77c9074137 && zf77c7f8449.y >= z47728d2efe.\
y-z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448+z975716b4ab.x+z975716b4ab.y], & \
zf8d9fd6cb8[z3b23994384+zb3ec2e5425.x+zb3ec2e5425.y]); \

void zdf309a99fd(__local float2*z718a062ddd,__global float4*zf8d9fd6cb8){
z718a062ddd[0].x=zf8d9fd6cb8[0].y;}void z6878568759(__local float2*z718a062ddd,
__global float*zf8d9fd6cb8){z718a062ddd[0].y=zf8d9fd6cb8[0]-z718a062ddd[0].x;}
#define z73a6d0c759 2
#ifndef zbc6516e8d5
#define zbc6516e8d5 0
#endif
__kernel void zd451af273c(__global float4*zf8d9fd6cb8,__global ushort2*
z718a062ddd,int4 z30eaaf69b7,int zd3738b8753,int z7288390569,__global float*
z11bbcb74ec,int ze72ac44423
#if zbc6516e8d5
,__local float2*z845f6c4669
#endif
){int2 z945895b462=(int2)(get_global_id(0),get_global_id(1));int2 zba94ee46da=
z945895b462+z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;int zc9d655d235=
z83640e5796.x+z83640e5796.y*(zd3738b8753);int2 zb3ec2e5425=(int2)(z73a6d0c759,
z73a6d0c759*zd3738b8753);int2 z9428a91e19=zba94ee46da;
int z3ec0685773=z9428a91e19.x+z9428a91e19.y*ze72ac44423;int2 z046982b753=(int2)(
z73a6d0c759,z73a6d0c759*ze72ac44423);
#if zbc6516e8d5
#define z6e29e29e19 20
#define z4525f4e9ce 40
int2 z47728d2efe=(int2)(get_local_size(0),get_local_size(1));
int2 z3fee8e0edb=(int2)(get_local_id(0),get_local_id(1));__local float2*
zf282cd8203=z845f6c4669+z73a6d0c759+z73a6d0c759*z6e29e29e19;int2 z8ea92fe60a=(
int2)(z73a6d0c759,z73a6d0c759*z6e29e29e19);int zd72c7cd02e=z3fee8e0edb.x+
z3fee8e0edb.y*z6e29e29e19;
if(z945895b462.x<z30eaaf69b7.s2&&z945895b462.y<z30eaaf69b7.s3){zdcc1f6f2eb(
zdf309a99fd,zf8d9fd6cb8,zf282cd8203,zc9d655d235,zd72c7cd02e,zb3ec2e5425,
z8ea92fe60a,z3fee8e0edb,z47728d2efe,z73a6d0c759)}barrier(CLK_LOCAL_MEM_FENCE);if
(z945895b462.x<z30eaaf69b7.s2&&z945895b462.y<z30eaaf69b7.s3){zdcc1f6f2eb(
z6878568759,z11bbcb74ec,zf282cd8203,z3ec0685773,zd72c7cd02e,z046982b753,
z8ea92fe60a,z3fee8e0edb,z47728d2efe,z73a6d0c759)}barrier(CLK_LOCAL_MEM_FENCE);
#endif
if(z945895b462.x>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return;float4
z51eadf1cec=(float4)0.0f;
#if zbc6516e8d5

z51eadf1cec+=-6.0f*(((float4)(zf282cd8203[zd72c7cd02e-z4525f4e9ce],zf282cd8203[
zd72c7cd02e-2])).xzyw-((float4)(zf282cd8203[zd72c7cd02e+z4525f4e9ce],zf282cd8203
[zd72c7cd02e+2])).xzyw);
z51eadf1cec+=-12.0f*(((float4)(zf282cd8203[zd72c7cd02e-z6e29e29e19],zf282cd8203[
zd72c7cd02e-1])).xzyw-((float4)(zf282cd8203[zd72c7cd02e+z6e29e29e19],zf282cd8203
[zd72c7cd02e+1])).xzyw);
z51eadf1cec+=-4.0f*(((float4)(zf282cd8203[zd72c7cd02e+1-z4525f4e9ce],zf282cd8203
[zd72c7cd02e-2+z6e29e29e19])).xzyw-
((float4)(zf282cd8203[zd72c7cd02e+1+z4525f4e9ce],zf282cd8203[zd72c7cd02e+2+
z6e29e29e19])).xzyw+((float4)(zf282cd8203[zd72c7cd02e-1-z4525f4e9ce],zf282cd8203
[zd72c7cd02e-2-z6e29e29e19])).xzyw-((float4)(zf282cd8203[zd72c7cd02e-1+
z4525f4e9ce],zf282cd8203[zd72c7cd02e+2-z6e29e29e19])).xzyw);
z51eadf1cec+=-1.0f*(((float4)(zf282cd8203[zd72c7cd02e+2-z4525f4e9ce],zf282cd8203
[zd72c7cd02e-2+z4525f4e9ce])).xzyw-((float4)(zf282cd8203[zd72c7cd02e+2+
z4525f4e9ce],zf282cd8203[zd72c7cd02e+2+z4525f4e9ce])).xzyw+((float4)(zf282cd8203
[zd72c7cd02e-2-z4525f4e9ce],zf282cd8203[zd72c7cd02e-2-z4525f4e9ce])).xzyw-((
float4)(zf282cd8203[zd72c7cd02e-2+z4525f4e9ce],zf282cd8203[zd72c7cd02e+2-
z4525f4e9ce])).xzyw);
z51eadf1cec+=-8.0f*(((float4)(zf282cd8203[zd72c7cd02e+1-z6e29e29e19],zf282cd8203
[zd72c7cd02e-1+z6e29e29e19])).xzyw-((float4)(zf282cd8203[zd72c7cd02e+1+
z6e29e29e19],zf282cd8203[zd72c7cd02e+1+z6e29e29e19])).xzyw+((float4)(zf282cd8203
[zd72c7cd02e-1-z6e29e29e19],zf282cd8203[zd72c7cd02e-1-z6e29e29e19])).xzyw-((
float4)(zf282cd8203[zd72c7cd02e-1+z6e29e29e19],zf282cd8203[zd72c7cd02e+1-
z6e29e29e19])).xzyw);
z51eadf1cec+=-2.0f*(((float4)(zf282cd8203[zd72c7cd02e+2-z6e29e29e19],zf282cd8203
[zd72c7cd02e-1+z4525f4e9ce])).xzyw-((float4)(zf282cd8203[zd72c7cd02e+2+
z6e29e29e19],zf282cd8203[zd72c7cd02e+1+z4525f4e9ce])).xzyw+((float4)(zf282cd8203
[zd72c7cd02e-2-z6e29e29e19],zf282cd8203[zd72c7cd02e-1-z4525f4e9ce])).xzyw-((
float4)(zf282cd8203[zd72c7cd02e-2+z6e29e29e19],zf282cd8203[zd72c7cd02e+1-
z4525f4e9ce])).xzyw);
#else
int zd72c7cd02e=zc9d655d235;int z6e29e29e19=zd3738b8753;int z4525f4e9ce=2*
z6e29e29e19;int zfacd472d32=ze72ac44423;int z4d8953c392=2*zfacd472d32;float
z703b6495e8=zf8d9fd6cb8[zd72c7cd02e-2-z4525f4e9ce].y;float zc152a63684=
zf8d9fd6cb8[zd72c7cd02e-1-z4525f4e9ce].y;float z1cd8dd5067=zf8d9fd6cb8[
zd72c7cd02e-z4525f4e9ce].y;float za753539080=zf8d9fd6cb8[zd72c7cd02e+1-
z4525f4e9ce].y;float zc55f82f30e=zf8d9fd6cb8[zd72c7cd02e+2-z4525f4e9ce].y;float
z87bef8be28=zf8d9fd6cb8[zd72c7cd02e-2-z6e29e29e19].y;float z43010b02d9=
zf8d9fd6cb8[zd72c7cd02e-1-z6e29e29e19].y;float z726758e1e5=zf8d9fd6cb8[
zd72c7cd02e-z6e29e29e19].y;float z4a072e3680=zf8d9fd6cb8[zd72c7cd02e+1-
z6e29e29e19].y;float z392b8cf7fd=zf8d9fd6cb8[zd72c7cd02e+2-z6e29e29e19].y;float
zf12cecf808=zf8d9fd6cb8[zd72c7cd02e-2].y;float z8da7f3eeb4=zf8d9fd6cb8[
zd72c7cd02e-1].y;float zae23e8111a=zf8d9fd6cb8[zd72c7cd02e+1].y;float
z3be02e7b8e=zf8d9fd6cb8[zd72c7cd02e+2].y;float zee9bf5bf55=zf8d9fd6cb8[
zd72c7cd02e-2+z6e29e29e19].y;float z77032a7845=zf8d9fd6cb8[zd72c7cd02e-1+
z6e29e29e19].y;float z6a27d687e7=zf8d9fd6cb8[zd72c7cd02e+z6e29e29e19].y;float
z4ca05972a2=zf8d9fd6cb8[zd72c7cd02e+1+z6e29e29e19].y;float z38434b227d=
zf8d9fd6cb8[zd72c7cd02e+2+z6e29e29e19].y;float zbd648da9b6=zf8d9fd6cb8[
zd72c7cd02e-2+z4525f4e9ce].y;float zb982ca4cfa=zf8d9fd6cb8[zd72c7cd02e-1+
z4525f4e9ce].y;float zf5e5f4c934=zf8d9fd6cb8[zd72c7cd02e+z4525f4e9ce].y;float
z9781ab2ad2=zf8d9fd6cb8[zd72c7cd02e+1+z4525f4e9ce].y;float z9e0b90977f=
zf8d9fd6cb8[zd72c7cd02e+2+z4525f4e9ce].y;float z02138225b2=z11bbcb74ec[
z3ec0685773-2-z4d8953c392]-z703b6495e8;float z008e3f1054=z11bbcb74ec[z3ec0685773
-1-z4d8953c392]-zc152a63684;float za9cf982911=z11bbcb74ec[z3ec0685773-
z4d8953c392]-z1cd8dd5067;float zf053b51fd5=z11bbcb74ec[z3ec0685773+1-z4d8953c392
]-za753539080;float z50f26d6d49=z11bbcb74ec[z3ec0685773+2-z4d8953c392]-
zc55f82f30e;float z9d394c14c3=z11bbcb74ec[z3ec0685773-2-zfacd472d32]-z87bef8be28
;float z1859c47068=z11bbcb74ec[z3ec0685773-1-zfacd472d32]-z43010b02d9;float
z117bdabca6=z11bbcb74ec[z3ec0685773-zfacd472d32]-z726758e1e5;float z918c693b87=
z11bbcb74ec[z3ec0685773+1-zfacd472d32]-z4a072e3680;float z30aa29080b=z11bbcb74ec
[z3ec0685773+2-zfacd472d32]-z392b8cf7fd;float z65e93e40a3=z11bbcb74ec[
z3ec0685773-2]-zf12cecf808;float z4ee14bfb06=z11bbcb74ec[z3ec0685773-1]-
z8da7f3eeb4;float zbaa82922e6=z11bbcb74ec[z3ec0685773+1]-zae23e8111a;float
z46d13dc5a1=z11bbcb74ec[z3ec0685773+2]-z3be02e7b8e;float z645620fb5d=z11bbcb74ec
[z3ec0685773-2+zfacd472d32]-zee9bf5bf55;float zd9b391431c=z11bbcb74ec[
z3ec0685773-1+zfacd472d32]-z77032a7845;float z9e19b8f60c=z11bbcb74ec[z3ec0685773
+zfacd472d32]-z6a27d687e7;float z21a3ff4b45=z11bbcb74ec[z3ec0685773+1+
zfacd472d32]-z4ca05972a2;float z82a926181d=z11bbcb74ec[z3ec0685773+2+zfacd472d32
]-z38434b227d;float z3efe95b262=z11bbcb74ec[z3ec0685773-2+z4d8953c392]-
zbd648da9b6;float zb3aa62f07f=z11bbcb74ec[z3ec0685773-1+z4d8953c392]-zb982ca4cfa
;float z92a34c7878=z11bbcb74ec[z3ec0685773+z4d8953c392]-zf5e5f4c934;float
zea93dabd45=z11bbcb74ec[z3ec0685773+1+z4d8953c392]-z9781ab2ad2;float z40fc80d794
=z11bbcb74ec[z3ec0685773+2+z4d8953c392]-z9e0b90977f;z51eadf1cec+=-6.0f*(((float4
)(z1cd8dd5067,za9cf982911,zf12cecf808,z65e93e40a3)).xzyw-((float4)(zf5e5f4c934,
z92a34c7878,z3be02e7b8e,z46d13dc5a1)).xzyw);
z51eadf1cec+=-12.0f*(((float4)(z726758e1e5,z117bdabca6,z8da7f3eeb4,z4ee14bfb06))
.xzyw-((float4)(z6a27d687e7,z9e19b8f60c,zae23e8111a,zbaa82922e6)).xzyw);
z51eadf1cec+=-4.0f*(((float4)(za753539080,zf053b51fd5,zee9bf5bf55,z645620fb5d)).
xzyw-
((float4)(z9781ab2ad2,zea93dabd45,z38434b227d,z82a926181d)).xzyw+((float4)(
zc152a63684,z008e3f1054,z87bef8be28,z9d394c14c3)).xzyw-((float4)(zb982ca4cfa,
zb3aa62f07f,z392b8cf7fd,z30aa29080b)).xzyw);
z51eadf1cec+=-1.0f*(((float4)(zc55f82f30e,z50f26d6d49,zbd648da9b6,z3efe95b262)).
xzyw-((float4)(z9e0b90977f,z40fc80d794,z9e0b90977f,z40fc80d794)).xzyw+((float4)(
z703b6495e8,z02138225b2,z703b6495e8,z02138225b2)).xzyw-((float4)(zbd648da9b6,
z3efe95b262,zc55f82f30e,z50f26d6d49)).xzyw);
z51eadf1cec+=-8.0f*(((float4)(z4a072e3680,z918c693b87,z77032a7845,zd9b391431c)).
xzyw-((float4)(z4ca05972a2,z21a3ff4b45,z4ca05972a2,z21a3ff4b45)).xzyw+((float4)(
z43010b02d9,z1859c47068,z43010b02d9,z1859c47068)).xzyw-((float4)(z77032a7845,
zd9b391431c,z4a072e3680,z918c693b87)).xzyw);
z51eadf1cec+=-2.0f*(((float4)(z392b8cf7fd,z30aa29080b,zb982ca4cfa,zb3aa62f07f)).
xzyw-((float4)(z38434b227d,z82a926181d,z9781ab2ad2,zea93dabd45)).xzyw+((float4)(
z87bef8be28,z9d394c14c3,zc152a63684,z008e3f1054)).xzyw-((float4)(zee9bf5bf55,
z645620fb5d,za753539080,zf053b51fd5)).xzyw);
#endif
float2 z5083031dab=(float2)(length(z51eadf1cec.xy),length(z51eadf1cec.zw));
ushort2 z20b29b6aff=convert_ushort2_sat(z5083031dab);

z718a062ddd[zba94ee46da.x+zba94ee46da.y*z7288390569]=z20b29b6aff;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
