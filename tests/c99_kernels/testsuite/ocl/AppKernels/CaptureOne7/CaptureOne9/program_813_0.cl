#define zbc6516e8d5  0

#ifndef zbc6516e8d5
#define zbc6516e8d5 1
#endif
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

void zb03b560df4(__local ushort2*z718a062ddd,__global ushort2*zf8d9fd6cb8){
z718a062ddd[0]=zf8d9fd6cb8[0];}
#define z73a6d0c759 1
#define z6e29e29e19 18
__kernel void z51d529f502(__global ushort2*zf8d9fd6cb8,__global float*
z718a062ddd,int4 z30eaaf69b7,int z021babbfad,int z958df11031
#if zbc6516e8d5
,__local ushort2*z845f6c4669
#endif
){int2 z945895b462=(int2)(get_global_id(0),get_global_id(1));int2 zba94ee46da=
z945895b462+z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;int zc9d655d235=
z83640e5796.x+z83640e5796.y*z021babbfad;int2 z47728d2efe=(int2)(get_local_size(0
),get_local_size(1));
int2 z3fee8e0edb=(int2)(get_local_id(0),get_local_id(1));int2 zb3ec2e5425=(int2)
(z73a6d0c759,z73a6d0c759*z021babbfad);
#if zbc6516e8d5
__local ushort2*zf282cd8203=z845f6c4669+z73a6d0c759+z73a6d0c759*z6e29e29e19;int2
 z8ea92fe60a=(int2)(z73a6d0c759,z73a6d0c759*z6e29e29e19);int zd72c7cd02e=
z3fee8e0edb.x+z3fee8e0edb.y*z6e29e29e19;
if(z945895b462.x<z30eaaf69b7.s2&&z945895b462.y<z30eaaf69b7.s3){zdcc1f6f2eb(
zb03b560df4,zf8d9fd6cb8,zf282cd8203,zc9d655d235,zd72c7cd02e,zb3ec2e5425,
z8ea92fe60a,z3fee8e0edb,z47728d2efe,z73a6d0c759)}barrier(CLK_LOCAL_MEM_FENCE);
#endif
if(z945895b462.x>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return;ushort2
z51eadf1cec=(ushort2)(65535,65535);for(int z1d8bd19892=-1;z1d8bd19892<=1;
z1d8bd19892++){for(int zdbc3421475=-1;zdbc3421475<=1;zdbc3421475++){
#if zbc6516e8d5
ushort2 z493deefb55=zf282cd8203[zd72c7cd02e+zdbc3421475+z1d8bd19892*z6e29e29e19]
;
#else
ushort2 z493deefb55=zf8d9fd6cb8[zc9d655d235+zdbc3421475+z1d8bd19892*z021babbfad]
;
#endif
z51eadf1cec=min(z51eadf1cec,z493deefb55);}}ushort z6b9506c215=min(z51eadf1cec.x,
z51eadf1cec.y);float zcf4f23fb5a=convert_float(z6b9506c215);z718a062ddd[
zba94ee46da.x+zba94ee46da.y*z958df11031]=zcf4f23fb5a;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
