#define zbc6516e8d5  0

#define z73a6d0c759 2
#define z6e29e29e19 20
#ifndef zbc6516e8d5
#define zbc6516e8d5 1
#endif
typedef int zdba6b93f69;typedef short2 z1b3183787b;
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

void zb03b560df4(__local z1b3183787b*z718a062ddd,__global z1b3183787b*
zf8d9fd6cb8){z718a062ddd[0]=zf8d9fd6cb8[0];}
#define s2(z2dd09f3226, za3158292ce)				zc9d80d25d3 = z2dd09f3226; z2dd09f3226 =\
 min(z2dd09f3226, za3158292ce); za3158292ce = max(zc9d80d25d3, za3158292ce);
#define z5cc5ab02f7(z2dd09f3226, za3158292ce)				s2(z493deefb55[z2dd09f3226], \
z493deefb55[za3158292ce]);
#define z3c1d011953(z2dd09f3226, za3158292ce, ze28128c2dd, z593fa3cb41, \
ze384962f2b, z90e1a42944, z305d891f1d, z99cf4fd6fe)			z5cc5ab02f7(z2dd09f3226, \
za3158292ce); z5cc5ab02f7(ze28128c2dd, z593fa3cb41); z5cc5ab02f7(ze384962f2b, \
z90e1a42944); z5cc5ab02f7(z305d891f1d, z99cf4fd6fe);
#define z6ecb4e6010(z2dd09f3226, za3158292ce, ze28128c2dd, z593fa3cb41, \
ze384962f2b, z90e1a42944, z305d891f1d, z99cf4fd6fe, z1d8bd19892, zdbc3421475)		\
z3c1d011953(z2dd09f3226, za3158292ce, ze28128c2dd, z593fa3cb41, ze384962f2b, \
z90e1a42944, z305d891f1d, z99cf4fd6fe); z5cc5ab02f7(z1d8bd19892, zdbc3421475);
#define z59f0e8c1e0(z2dd09f3226,za3158292ce,zb058c18cb2, z58bd06307e) \
 {z1b3183787b zf79fc28d19 = max(z2dd09f3226,za3158292ce); \
 zb058c18cb2 = min(z2dd09f3226,za3158292ce); \
 z58bd06307e = zf79fc28d19; } \

#define z274e18ad48(z2dd09f3226,za3158292ce,ze28128c2dd,zb058c18cb2,z9065779e18,\
z58bd06307e,z2ae56adba2) \
 z59f0e8c1e0(z2dd09f3226   , za3158292ce   , z2ae56adba2, z9065779e18); \
 z59f0e8c1e0(z9065779e18, ze28128c2dd   , z9065779e18, z58bd06307e); \
 z59f0e8c1e0(z2ae56adba2, z9065779e18, zb058c18cb2, z9065779e18); \

#define z54bb56a77c(z08ef030ac3) (z08ef030ac3)*(z08ef030ac3)
float zfb1b5df3f5(int z8dd6fa68b0){float za17decad7b=(float)(2047/2);float
z1d8bd19892=(float)z8dd6fa68b0-za17decad7b;return exp(-0.1f*z54bb56a77c(
z1d8bd19892/64.0f));
}inline int2 z3f6fae1051(float2 z90e1a42944){int2 z96a2929ccd=convert_int2(
z90e1a42944);
z96a2929ccd=min(max(z96a2929ccd,(int2)0),(int2)65535);return z96a2929ccd;}
__kernel void z888adc9231(__global z1b3183787b*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int4 z30eaaf69b7,int z2824fcf57d,int z745057f086,float z99b1fb12fb,
int z3b6d99000e
#if zbc6516e8d5
,__local z1b3183787b*zf485e5e12c
#endif
){int2 z945895b462=(int2)(get_global_id(0),get_global_id(1));int2 zba94ee46da=
z945895b462+z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;int z796a73b2c0=
z2824fcf57d;
int zc9d655d235=z83640e5796.x+z83640e5796.y*z796a73b2c0;
#if zbc6516e8d5
int2 z47728d2efe=(int2)(get_local_size(0),get_local_size(1));
int2 z3fee8e0edb=(int2)(get_local_id(0),get_local_id(1));int2 zb3ec2e5425=(int2)
(z73a6d0c759,z73a6d0c759*z796a73b2c0);__local z1b3183787b*zad17306490=
zf485e5e12c+z73a6d0c759+z73a6d0c759*z6e29e29e19;int2 z8ea92fe60a=(int2)(
z73a6d0c759,z73a6d0c759*z6e29e29e19);int zd72c7cd02e=z3fee8e0edb.x+z3fee8e0edb.y
*z6e29e29e19;if(z945895b462.x<z30eaaf69b7.s2&&z945895b462.y<z30eaaf69b7.s3){
zdcc1f6f2eb(zb03b560df4,zf8d9fd6cb8,zad17306490,zc9d655d235,zd72c7cd02e,
zb3ec2e5425,z8ea92fe60a,z3fee8e0edb,z47728d2efe,z73a6d0c759)}barrier(
CLK_LOCAL_MEM_FENCE);zad17306490+=zd72c7cd02e;z796a73b2c0=z6e29e29e19;
#else
__global z1b3183787b*zad17306490=zf8d9fd6cb8+zc9d655d235;
#endif
if(z945895b462.x>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return;z1b3183787b
 z064b3082fe,zc9d80d25d3;if(z3b6d99000e==9){z1b3183787b z2d351c5ace=zad17306490[
0];z1b3183787b z3931fc4ce8=zad17306490[-1];z1b3183787b z963ba64275=zad17306490[1
];z1b3183787b z9d0886a4aa=zad17306490[-z796a73b2c0];z1b3183787b zbed769e4d8=
zad17306490[z796a73b2c0];z1b3183787b ze859817222=zad17306490[-2-2*z796a73b2c0];
z1b3183787b z7ca5ed27d2=zad17306490[-2+2*z796a73b2c0];z1b3183787b z00d609d8d3=
zad17306490[2-2*z796a73b2c0];z1b3183787b zb45b9718bd=zad17306490[2+2*z796a73b2c0
];z1b3183787b z08ef030ac3,z7e674d442a,z136720eb4b,zd2a6f93bee,z2e91460297,
zfb6d42c5b0,z2672389cdd,zf8bc541aad,zda3c7269eb;z274e18ad48(z2d351c5ace,
z3931fc4ce8,z963ba64275,z08ef030ac3,z7e674d442a,z136720eb4b,zc9d80d25d3)
z274e18ad48(z9d0886a4aa,zbed769e4d8,ze859817222,zd2a6f93bee,z2e91460297,
zfb6d42c5b0,zc9d80d25d3)z274e18ad48(z7ca5ed27d2,z00d609d8d3,zb45b9718bd,
z2672389cdd,zf8bc541aad,zda3c7269eb,zc9d80d25d3)z274e18ad48(z7e674d442a,
z2e91460297,zf8bc541aad,z9d0886a4aa,zbed769e4d8,ze859817222,zc9d80d25d3)
z59f0e8c1e0(z08ef030ac3,zd2a6f93bee,z2d351c5ace,z3931fc4ce8)z59f0e8c1e0(
z3931fc4ce8,z2672389cdd,z2d351c5ace,z963ba64275)z59f0e8c1e0(zfb6d42c5b0,
zda3c7269eb,z7ca5ed27d2,z00d609d8d3)z59f0e8c1e0(z136720eb4b,z7ca5ed27d2,
z00d609d8d3,zb45b9718bd)z274e18ad48(z963ba64275,zbed769e4d8,z00d609d8d3,
z9d0886a4aa,z064b3082fe,ze859817222,zc9d80d25d3)}else{z1b3183787b z493deefb55[25
];z493deefb55[0]=zad17306490[0];z493deefb55[1]=zad17306490[-1];z493deefb55[2]=
zad17306490[1];z493deefb55[3]=zad17306490[-z796a73b2c0];z493deefb55[4]=
zad17306490[z796a73b2c0];z493deefb55[5]=zad17306490[-2-2*z796a73b2c0];
z493deefb55[6]=zad17306490[2-2*z796a73b2c0];z493deefb55[7]=zad17306490[-2+2*
z796a73b2c0];z493deefb55[8]=zad17306490[2+2*z796a73b2c0];z493deefb55[9]=
zad17306490[-2];z493deefb55[10]=zad17306490[2];z493deefb55[11]=zad17306490[-
z796a73b2c0-2];z493deefb55[12]=zad17306490[-z796a73b2c0-1];z493deefb55[13]=
zad17306490[-z796a73b2c0+1];z493deefb55[14]=zad17306490[-z796a73b2c0+2];
z493deefb55[15]=zad17306490[z796a73b2c0-2];z493deefb55[16]=zad17306490[
z796a73b2c0-1];z493deefb55[17]=zad17306490[z796a73b2c0+1];z493deefb55[18]=
zad17306490[z796a73b2c0+2];z493deefb55[19]=zad17306490[-1-2*z796a73b2c0];
z493deefb55[20]=zad17306490[-2*z796a73b2c0];z493deefb55[21]=zad17306490[1-2*
z796a73b2c0];z493deefb55[22]=zad17306490[-1+2*z796a73b2c0];z493deefb55[23]=
zad17306490[2*z796a73b2c0];z493deefb55[24]=zad17306490[1+2*z796a73b2c0];
z6ecb4e6010(0,1,3,4,2,4,2,3,6,7);z6ecb4e6010(5,7,5,6,9,7,1,7,1,4);z6ecb4e6010(12
,13,11,13,11,12,15,16,14,16);z6ecb4e6010(14,15,18,19,17,19,17,18,21,22);
z6ecb4e6010(20,22,20,21,23,24,2,5,3,6);z6ecb4e6010(0,6,0,3,4,7,1,7,1,4);
z6ecb4e6010(11,14,8,14,8,11,12,15,9,15);z6ecb4e6010(9,12,13,16,10,16,10,13,20,23
);z6ecb4e6010(17,23,17,20,21,24,18,24,18,21);z6ecb4e6010(19,22,8,17,9,18,0,18,0,
9);z6ecb4e6010(10,19,1,19,1,10,11,20,2,20);z6ecb4e6010(2,11,12,21,3,21,3,12,13,
22);z6ecb4e6010(4,22,4,13,14,23,5,23,5,14);z6ecb4e6010(15,24,6,24,6,15,7,16,7,19
);z6ecb4e6010(3,11,5,17,11,17,9,17,4,10);z6ecb4e6010(6,12,7,14,4,6,4,7,12,14);
z6ecb4e6010(10,14,6,7,10,12,6,10,6,17);z6ecb4e6010(12,17,7,17,7,10,12,18,7,12);
z3c1d011953(10,18,12,20,10,20,10,12);z064b3082fe=z493deefb55[12];}int
z9e4ef3c6b4=zba94ee46da.x+zba94ee46da.y*(z745057f086/4);const float z997ede1cab=
0.001f;const int2 za17decad7b=(int2)1024;const int2 z0353ccb3d8=(int2)2047;
float2 z20ebce136a=(float2)0.0f;{
ushort4 zad17306490=z718a062ddd[z9e4ef3c6b4];int4 z39e3dfa8a9;zdba6b93f69
z78e5f3d8ec=convert_int(zad17306490.s1);int2 z4fd4e5fa4c=convert_int2(
z064b3082fe);
int2 zcf650820a3=za17decad7b+(z4fd4e5fa4c<<((int2)6))/(int2)(z78e5f3d8ec+1);
zcf650820a3=min(max(zcf650820a3,(int2)0),z0353ccb3d8);z20ebce136a.x=zfb1b5df3f5(
zcf650820a3.x);z20ebce136a.y=zfb1b5df3f5(zcf650820a3.y);float2 zbc55f31c1a=
z20ebce136a*(float2)z99b1fb12fb;float2 z288bfc2f06=(float2)1.0f-zbc55f31c1a;
z39e3dfa8a9.s02=z3f6fae1051(zbc55f31c1a*convert_float2((z4fd4e5fa4c<<((int2)1))+
(int2)z78e5f3d8ec)+z288bfc2f06*convert_float2(zad17306490.s02));z39e3dfa8a9.s1=
z78e5f3d8ec;
z718a062ddd[z9e4ef3c6b4]=convert_ushort4_sat(z39e3dfa8a9);}}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
