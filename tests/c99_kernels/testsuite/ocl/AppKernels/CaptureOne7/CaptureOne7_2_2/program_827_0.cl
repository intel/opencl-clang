#define zbc6516e8d5  0

#define z73a6d0c759 1
#define z6e29e29e19 18
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

void zb03b560df4(__local float4*z718a062ddd,__global float4*zf8d9fd6cb8){
z718a062ddd[0]=zf8d9fd6cb8[0];}__kernel void z76a681d3e8(__global float4*
zf8d9fd6cb8,__global float4*z718a062ddd,int4 z30eaaf69b7,uint z021babbfad,uint
z958df11031,float4 z7f23413daa,
float4 z051b1acf8c,
float z52335ad46d
#if zbc6516e8d5
,__local float4*zf485e5e12c
#endif
){int2 z945895b462=(int2)(get_global_id(0),get_global_id(1));int2 zba94ee46da=
z945895b462+z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;int z796a73b2c0=
z021babbfad/4;
int zc9d655d235=z83640e5796.x+z83640e5796.y*z796a73b2c0;
#if zbc6516e8d5
int2 z47728d2efe=(int2)(get_local_size(0),get_local_size(1));
int2 z3fee8e0edb=(int2)(get_local_id(0),get_local_id(1));int2 zb3ec2e5425=(int2)
(z73a6d0c759,z73a6d0c759*z796a73b2c0);__local float4*zad17306490=zf485e5e12c+
z73a6d0c759+z73a6d0c759*z6e29e29e19;int2 z8ea92fe60a=(int2)(z73a6d0c759,
z73a6d0c759*z6e29e29e19);int zd72c7cd02e=z3fee8e0edb.x+z3fee8e0edb.y*z6e29e29e19
;if(z945895b462.x<z30eaaf69b7.s2&&z945895b462.y<z30eaaf69b7.s3){zdcc1f6f2eb(
zb03b560df4,zf8d9fd6cb8,zad17306490,zc9d655d235,zd72c7cd02e,zb3ec2e5425,
z8ea92fe60a,z3fee8e0edb,z47728d2efe,z73a6d0c759)}barrier(CLK_LOCAL_MEM_FENCE);
zad17306490+=zd72c7cd02e;z796a73b2c0=z6e29e29e19;
#else
__global float4*zad17306490=zf8d9fd6cb8+zc9d655d235;
#endif
if(z945895b462.x>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return;int
zdd401c5ffa=z958df11031/4;float4 z44d9dd245a,z52ab5b652a,zff9b379451,zff400e9e97
,z872a4be821,za3158292ce,z9685e792dd,zc1a7596d5d;__global float4*z2677e74582=
z718a062ddd+zba94ee46da.x+zba94ee46da.y*zdd401c5ffa;float4 zfdd38d694f=
zad17306490[0].xyzy;zc1a7596d5d=zad17306490[-1].xyzy;zff400e9e97=zad17306490[1].
xyzy;float4 za65e33dd1b=zfdd38d694f+(float4)(zfdd38d694f.y,0.0f,zfdd38d694f.y,
0.0f);
int4 z93a08e63a7;z93a08e63a7=(fabs(zfdd38d694f-zc1a7596d5d)>=z7f23413daa)|(fabs(
zfdd38d694f-zff400e9e97)>=z7f23413daa);


z93a08e63a7.w=0;if(z93a08e63a7.y!=0||z93a08e63a7.x!=0||z93a08e63a7.z!=0){

z44d9dd245a=zad17306490[-z796a73b2c0-1].xyzy;z52ab5b652a=zad17306490[-
z796a73b2c0].xyzy;zff9b379451=zad17306490[-z796a73b2c0+1].xyzy;
z872a4be821=zad17306490[z796a73b2c0+1].xyzy;za3158292ce=zad17306490[z796a73b2c0]
.xyzy;z9685e792dd=zad17306490[z796a73b2c0-1].xyzy;
float4 ze9e6a5cf62=(z44d9dd245a+z52ab5b652a+zff9b379451+zff400e9e97+z872a4be821+
za3158292ce+z9685e792dd+zc1a7596d5d)/8.0f;ze9e6a5cf62.w=0.0f;
float4 z4a574cfbe6=fabs(zfdd38d694f-ze9e6a5cf62);z93a08e63a7=z93a08e63a7&(
z4a574cfbe6>z7f23413daa);


if(z93a08e63a7.y!=0||z93a08e63a7.x!=0||z93a08e63a7.z!=0){
float z6e16f05d64=0.0f,z46570487d7=65536.0f;z6e16f05d64=max(z6e16f05d64,
z44d9dd245a.y);z6e16f05d64=max(z6e16f05d64,z52ab5b652a.y);z6e16f05d64=max(
z6e16f05d64,zff9b379451.y);z6e16f05d64=max(z6e16f05d64,zff400e9e97.y);
z6e16f05d64=max(z6e16f05d64,z872a4be821.y);z6e16f05d64=max(z6e16f05d64,
za3158292ce.y);z6e16f05d64=max(z6e16f05d64,z9685e792dd.y);z6e16f05d64=max(
z6e16f05d64,zc1a7596d5d.y);z46570487d7=min(z46570487d7,z44d9dd245a.y);
z46570487d7=min(z46570487d7,z52ab5b652a.y);z46570487d7=min(z46570487d7,
zff9b379451.y);z46570487d7=min(z46570487d7,zff400e9e97.y);z46570487d7=min(
z46570487d7,z872a4be821.y);z46570487d7=min(z46570487d7,za3158292ce.y);
z46570487d7=min(z46570487d7,z9685e792dd.y);z46570487d7=min(z46570487d7,
zc1a7596d5d.y);
z44d9dd245a-=ze9e6a5cf62;z52ab5b652a-=ze9e6a5cf62;zff9b379451-=ze9e6a5cf62;
zff400e9e97-=ze9e6a5cf62;z872a4be821-=ze9e6a5cf62;za3158292ce-=ze9e6a5cf62;
z9685e792dd-=ze9e6a5cf62;zc1a7596d5d-=ze9e6a5cf62;float4 z3c794c31a3=(
z44d9dd245a*z44d9dd245a+z52ab5b652a*z52ab5b652a+zff9b379451*zff9b379451+
zff400e9e97*zff400e9e97+z872a4be821*z872a4be821+za3158292ce*za3158292ce+
z9685e792dd*z9685e792dd+zc1a7596d5d*zc1a7596d5d)/8.0f;z3c794c31a3=sqrt(
z3c794c31a3);
float4 zd96e9e01ee=z52335ad46d*z3c794c31a3;z93a08e63a7.xz=z93a08e63a7.xz&(
z4a574cfbe6.xz>zd96e9e01ee.xz);z93a08e63a7.y=z93a08e63a7.y&(z4a574cfbe6.y>
zd96e9e01ee.y);
z93a08e63a7.y=z93a08e63a7.y&(zfdd38d694f.y>z6e16f05d64|zfdd38d694f.y<z46570487d7
);z93a08e63a7.xz=z93a08e63a7.xz&(z3c794c31a3.xz<z051b1acf8c.xz);

if(z93a08e63a7.y!=0||z93a08e63a7.x!=0||z93a08e63a7.z!=0){



float z86930ac95a=fabs(zc1a7596d5d.w+z9685e792dd.w-z44d9dd245a.w-z44d9dd245a.w)+
fabs(z44d9dd245a.w+z9685e792dd.w-zc1a7596d5d.w-zc1a7596d5d.w)+fabs(z44d9dd245a.w
+zc1a7596d5d.w-z9685e792dd.w-z9685e792dd.w)+fabs(zff400e9e97.w+z872a4be821.w-
zff9b379451.w-zff9b379451.w)+fabs(zff9b379451.w+z872a4be821.w-zff400e9e97.w-
zff400e9e97.w)+fabs(zff9b379451.w+zff400e9e97.w-z872a4be821.w-z872a4be821.w);
float z1195f2d77d=fabs(z52ab5b652a.w+zff9b379451.w-z44d9dd245a.w-z44d9dd245a.w)+
fabs(z44d9dd245a.w+zff9b379451.w-z52ab5b652a.w-z52ab5b652a.w)+fabs(z44d9dd245a.w
+z52ab5b652a.w-zff9b379451.w-zff9b379451.w)+fabs(za3158292ce.w+z872a4be821.w-
z9685e792dd.w-z9685e792dd.w)+fabs(z9685e792dd.w+z872a4be821.w-za3158292ce.w-
za3158292ce.w)+fabs(z9685e792dd.w+za3158292ce.w-z872a4be821.w-z872a4be821.w);if(
z86930ac95a>z1195f2d77d)za65e33dd1b=(zc1a7596d5d.xwzw+zff400e9e97.xwzw)/2.0f;
else za65e33dd1b=(z52ab5b652a.xwzw+za3158292ce.xwzw)/2.0f;za65e33dd1b.xz+=
za65e33dd1b.ww+ze9e6a5cf62.xz;}}}za65e33dd1b.w=0.0f;z718a062ddd[zba94ee46da.x+
zba94ee46da.y*(z958df11031/4)]=za65e33dd1b;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
