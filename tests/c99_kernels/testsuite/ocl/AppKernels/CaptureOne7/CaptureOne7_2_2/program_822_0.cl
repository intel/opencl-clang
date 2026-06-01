#define zdbe1efdb26  0

#ifndef zdbe1efdb26
#define zdbe1efdb26 1
#endif
float zec15f7fa83(float4 z205d564e2f){return dot(z205d564e2f,(float4)(0.299f,
0.587f,0.114f,0.0f));}
#define z590e89f53c(zff400e9e97, z305d891f1d, za3158292ce) (zff400e9e97 * 306 + \
z305d891f1d *  601 + za3158292ce *  117)
__kernel void z05c0ee1c89(__global ushort4*zf8d9fd6cb8,__global float*
z718a062ddd,int8 z30eaaf69b7,uint z2824fcf57d,uint z9562068e13,__global ushort4*
zdcf3002ec9){
#if 1
__local ushort z0cffa083de[(257+63)&~63];__local ushort z8afe3db097[512];__local
 ushort zb9c8801f90[(257+63)&~63];z0cffa083de[256]=zb9c8801f90[256]=65535;int
z8b1bb737a4=get_local_id(0)+16*get_local_id(1);if(z8b1bb737a4<256){



ushort4 zf0e6526080=zdcf3002ec9[z8b1bb737a4];z8afe3db097[2*z8b1bb737a4]=
zf0e6526080.x;z8afe3db097[2*z8b1bb737a4+1]=zf0e6526080.y;z0cffa083de[z8b1bb737a4
]=zf0e6526080.z;zb9c8801f90[z8b1bb737a4]=zf0e6526080.w;}barrier(
CLK_LOCAL_MEM_FENCE);
#else



#endif
int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;ushort4
 za44700ff9d=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];
#if 0
float4 z493deefb55=convert_float4(za44700ff9d);float4 z91b264e62b=z493deefb55/(
float4)65535.0f;
float4 zf49d599761=pow(z91b264e62b,(float4)(1.8f,1.8f,1.8f,1.8f));float
z498bde0636=zec15f7fa83(zf49d599761);float z045b183f80=sqrt(z498bde0636);
z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=z045b183f80;za44700ff9d.w=
convert_ushort(z045b183f80*65535.0f);zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*
z2824fcf57d]=za44700ff9d;
#else

int z727421481f=za44700ff9d.x>>8,zaf5d0dd355=za44700ff9d.x&0xff;int z4bbe2765a0=
za44700ff9d.y>>8,z6892b82b12=za44700ff9d.y&0xff;int zde213c8de2=za44700ff9d.z>>8
,zd33a5dc2f2=za44700ff9d.z&0xff;int z8248b91cce=z0cffa083de[z727421481f]+(
zaf5d0dd355*(z0cffa083de[z727421481f+1]-z0cffa083de[z727421481f])>>8);int
z37ef40141d=z0cffa083de[z4bbe2765a0]+(z6892b82b12*(z0cffa083de[z4bbe2765a0+1]-
z0cffa083de[z4bbe2765a0])>>8);int z49ee2bf1c4=z0cffa083de[zde213c8de2]+(
zd33a5dc2f2*(z0cffa083de[zde213c8de2+1]-z0cffa083de[zde213c8de2])>>8);int
z498bde0636=z590e89f53c(z8248b91cce,z37ef40141d,z49ee2bf1c4)>>10;
int z045b183f80;if(z498bde0636<512){z045b183f80=z8afe3db097[z498bde0636];}else{
int ze17d37d6bc=z498bde0636>>8,z328edc60a1=z498bde0636&0xff;uint z42d7c57a56=
zb9c8801f90[ze17d37d6bc];uint zf974cebfd3=zb9c8801f90[ze17d37d6bc+1];z045b183f80
=z42d7c57a56+(z328edc60a1*(zf974cebfd3-z42d7c57a56)>>8);}
#endif
z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=convert_float(z045b183f80)/
65535.0f;za44700ff9d.w=z045b183f80;zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*
z2824fcf57d]=za44700ff9d;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
