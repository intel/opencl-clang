#define zbc6516e8d5 0

#ifndef zbc6516e8d5
#define zbc6516e8d5 1
#endif
#if zbc6516e8d5
#define z633bdc4c82 __local float4
#else
#define z633bdc4c82 __global float4
#endif
#define z57f8d3ba0a(z493deefb55, ze28128c2dd) (ze28128c2dd<0 ? z493deefb55.x : \
z493deefb55.z)
typedef short z6d9b655c10;float zd3a7d82bde(z633bdc4c82*zf8d9fd6cb8,int
zbced03a0bf,int z48fc9628f1,float4 z3d94c6ec01){float zff400e9e97;float
z73d3582446,z4fe00ffb85,zea34483265,z38c36eec91,z26cc9604bc;int z6d30cd5dec=
zbced03a0bf+zbced03a0bf;float z70269ede93=z3d94c6ec01.x;float ze33fe18116=
z3d94c6ec01.y;float zf18505e1f9=z3d94c6ec01.z;float zce1543a1d0=z3d94c6ec01.w;
z6d9b655c10 zac5cffb9fe=z48fc9628f1-1;
z6d9b655c10 z09a63c2436=1-z48fc9628f1;


float4 z105f9ec709=zf8d9fd6cb8[-zbced03a0bf-1];float4 za1f05c5e24=zf8d9fd6cb8[-
zbced03a0bf+1];float4 z543620ea9e=zf8d9fd6cb8[zbced03a0bf-1];float4 zdc70b86b39=
zf8d9fd6cb8[zbced03a0bf+1];float z233f7204bc=z105f9ec709.y;float zac430137e3=
za1f05c5e24.y;float ze856f4c96d=z543620ea9e.y;float z89af6ffa48=zdc70b86b39.y;
float zbdb100f278=z57f8d3ba0a(z543620ea9e,zac5cffb9fe);float zfe8c52342a=
z57f8d3ba0a(za1f05c5e24,zac5cffb9fe);float z2431271211=z57f8d3ba0a(z105f9ec709,
zac5cffb9fe);float z5ae98f8509=z57f8d3ba0a(zdc70b86b39,zac5cffb9fe);float4
z6318bc09c5=zf8d9fd6cb8[-z6d30cd5dec-2];float4 ze170652acd=zf8d9fd6cb8[-
z6d30cd5dec+2];float4 z4bc171496b=zf8d9fd6cb8[z6d30cd5dec-2];float4 zac005d64da=
zf8d9fd6cb8[z6d30cd5dec+2];float z4589f2ec12=z57f8d3ba0a(z6318bc09c5,z09a63c2436
);float zeefb63acf3=z57f8d3ba0a(zac005d64da,z09a63c2436);float za8076b06f2=
z57f8d3ba0a(z4bc171496b,z09a63c2436);float zf26ab07707=z57f8d3ba0a(ze170652acd,
z09a63c2436);float4 z7391587de4=zf8d9fd6cb8[0];float z78e5f3d8ec=z7391587de4.y;
float ze5510583f5=z57f8d3ba0a(z7391587de4,z09a63c2436);
z73d3582446=fabs(z2431271211-z5ae98f8509);z4fe00ffb85=fabs(zbdb100f278-
zfe8c52342a);



float z301bc0b035=z2431271211+zfe8c52342a+zbdb100f278+z5ae98f8509;z301bc0b035*=
z70269ede93;float z767ac95197=z233f7204bc+z89af6ffa48+zac430137e3+ze856f4c96d;
if(z73d3582446<z4fe00ffb85){

z38c36eec91=(zce1543a1d0+fabs(z233f7204bc-z78e5f3d8ec)+fabs(z4589f2ec12-
ze5510583f5));zea34483265=(zce1543a1d0+fabs(z89af6ffa48-z78e5f3d8ec)+fabs(
zeefb63acf3-ze5510583f5));if(z767ac95197>z301bc0b035){z38c36eec91*=ze33fe18116+
fabs(z2431271211-z233f7204bc)/(1.f+z2431271211+z233f7204bc);zea34483265*=
ze33fe18116+fabs(z5ae98f8509-z89af6ffa48)/(1.f+z5ae98f8509+z89af6ffa48);}
z26cc9604bc=zea34483265+z38c36eec91;zff400e9e97=zea34483265*z2431271211+
z38c36eec91*z5ae98f8509+z26cc9604bc*zf18505e1f9;zff400e9e97/=(zea34483265*
z233f7204bc+z38c36eec91*z89af6ffa48+z26cc9604bc*zf18505e1f9);zff400e9e97*=(
z78e5f3d8ec+zf18505e1f9);}else{

z38c36eec91=(zce1543a1d0+fabs(ze856f4c96d-z78e5f3d8ec)+fabs(za8076b06f2-
ze5510583f5));zea34483265=(zce1543a1d0+fabs(zac430137e3-z78e5f3d8ec)+fabs(
zf26ab07707-ze5510583f5));if(z767ac95197>z301bc0b035){z38c36eec91*=ze33fe18116+
fabs(zbdb100f278-ze856f4c96d)/(1.f+zbdb100f278+ze856f4c96d);zea34483265*=
ze33fe18116+fabs(zfe8c52342a-zac430137e3)/(1.f+zfe8c52342a+zac430137e3);}
z26cc9604bc=zea34483265+z38c36eec91;zff400e9e97=zea34483265*zbdb100f278+
z38c36eec91*zfe8c52342a+z26cc9604bc*zf18505e1f9;zff400e9e97/=(zea34483265*
ze856f4c96d+z38c36eec91*zac430137e3+z26cc9604bc*zf18505e1f9);zff400e9e97*=(
z78e5f3d8ec+zf18505e1f9);}zff400e9e97=(zff400e9e97>zf18505e1f9)?(zff400e9e97-
zf18505e1f9):0.0f;
return zff400e9e97;}
#define z73a6d0c759 2
__kernel void z95ba5a4538(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z021babbfad,int z958df11031,float4 z3d94c6ec01
#if zbc6516e8d5
,__local float4*zf485e5e12c
#endif
){int2 z945895b462=(int2)(2*get_global_id(0),2*get_global_id(1));int2
zba94ee46da=z945895b462+z30eaaf69b7.s01;int2 z83640e5796=z945895b462+z30eaaf69b7
.s45;int z796a73b2c0=z021babbfad;
#if zbc6516e8d5
int z6e29e29e19=2*get_local_size(0)+2*z73a6d0c759;__local float4*z99ea074086=
zf485e5e12c;int2 z7cdb6ae8dd=(int2)(2*get_local_id(0)+z73a6d0c759,2*get_local_id
(1)+z73a6d0c759);int2 z61bac1bc70=z83640e5796-z7cdb6ae8dd;int z2cf8520e42=
z61bac1bc70.x+z61bac1bc70.y*z796a73b2c0;int zf54614f74b=(z30eaaf69b7.s2-1)+
z796a73b2c0*(z30eaaf69b7.s3-1);int z8b1bb737a4=get_local_id(0)+get_local_id(1)*
get_local_size(0);int z4b946a6906=6*z8b1bb737a4;int za6fbfbc4c3=(z73a6d0c759+2*
get_local_size(1)+z73a6d0c759)*z6e29e29e19;for(int z8dd6fa68b0=0;z8dd6fa68b0<6;
z8dd6fa68b0++){int z38a89f6944=z4b946a6906+z8dd6fa68b0;if(z38a89f6944<
za6fbfbc4c3){int z4a5805e56d=z38a89f6944%z6e29e29e19;int zd47cd65624=z38a89f6944
/z6e29e29e19;int z95a479821b=z4a5805e56d+zd47cd65624*z796a73b2c0;z95a479821b=
clamp(z95a479821b+z2cf8520e42,0,zf54614f74b);zf485e5e12c[z38a89f6944]=
zf8d9fd6cb8[z95a479821b];}}barrier(CLK_LOCAL_MEM_FENCE);z99ea074086+=z7cdb6ae8dd
.x+z7cdb6ae8dd.y*z6e29e29e19;z796a73b2c0=z6e29e29e19;
#else
__global float4*z99ea074086=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z796a73b2c0;
#endif
int z9562068e13=z958df11031;__global float4*ze4351005bc=z718a062ddd+zba94ee46da.
x+zba94ee46da.y*z9562068e13;if(z945895b462.x>=z30eaaf69b7.s2||z945895b462.y>=
z30eaaf69b7.s3)return;float4 z23f640cecd=z99ea074086[0];z23f640cecd.z=
zd3a7d82bde(z99ea074086,z796a73b2c0,2,z3d94c6ec01);float4 ze3582107ea=
z99ea074086[1];float4 z39ca04a0da=z99ea074086[z796a73b2c0];float4 z825c4b13fc=
z99ea074086[1+z796a73b2c0];z99ea074086+=1+z796a73b2c0;z825c4b13fc.x=zd3a7d82bde(
z99ea074086,z796a73b2c0,0,z3d94c6ec01);ze4351005bc[0]=z23f640cecd;ze4351005bc[1]
=ze3582107ea;ze4351005bc[z9562068e13]=z39ca04a0da;ze4351005bc[1+z9562068e13]=
z825c4b13fc;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
