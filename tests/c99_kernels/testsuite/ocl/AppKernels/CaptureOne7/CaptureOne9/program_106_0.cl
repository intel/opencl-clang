#define z3dbd1ff682 0
typedef ushort z51b7908a0d;__kernel void zf8f401eaf5(__global ushort4*
zf8d9fd6cb8,__global ushort4*z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int
z9562068e13,int4 zc8bf9b79e6,int4 z93d11ec35a,int4 zc0ace1d2c7,int4 ze6b0451f42,
int4 zcbc1f27e7d,__global ushort*zcc6993f31f){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int2
z83640e5796=zba94ee46da+z30eaaf69b7.s45;const bool z037316df7a=zc8bf9b79e6.x>0;
const int z0ef4274f3d=zc8bf9b79e6.y;const int z5b58121f6e=zc8bf9b79e6.z;const
int z847f9665cc=zc8bf9b79e6.w;ushort4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+
z83640e5796.y*z2824fcf57d];

int z4633c865c6=convert_int(z493deefb55.x)<<z847f9665cc;uint z86b36b953e,
zd2940ad387,z36a2642e12;if(z037316df7a){
if(z4633c865c6>262140)z4633c865c6=262140;if(z4633c865c6<z5b58121f6e){
z86b36b953e=(ze6b0451f42.x*z4633c865c6)/8192;zd2940ad387=(ze6b0451f42.y*
z4633c865c6)/8192;z36a2642e12=(ze6b0451f42.z*z4633c865c6)/8192;}else if(
z4633c865c6>z0ef4274f3d){
z86b36b953e=(zcbc1f27e7d.x*z4633c865c6)/8192;zd2940ad387=(zcbc1f27e7d.y*
z4633c865c6)/8192;z36a2642e12=(zcbc1f27e7d.z*z4633c865c6)/8192;}else{
int z56807b5599=z4633c865c6-z5b58121f6e;int z52ab5b652a=(z0ef4274f3d-z5b58121f6e
)-z56807b5599;z86b36b953e=(zc0ace1d2c7.x*z52ab5b652a+z93d11ec35a.x*z56807b5599)/
8192;zd2940ad387=(zc0ace1d2c7.y*z52ab5b652a+z93d11ec35a.y*z56807b5599)/8192;
z36a2642e12=(zc0ace1d2c7.z*z52ab5b652a+z93d11ec35a.z*z56807b5599)/8192;}if(
z86b36b953e>65535)z86b36b953e=65535;if(zd2940ad387>65535)zd2940ad387=65535;if(
z36a2642e12>65535)z36a2642e12=65535;
z86b36b953e=zcc6993f31f[z86b36b953e];zd2940ad387=zcc6993f31f[zd2940ad387];
z36a2642e12=zcc6993f31f[z36a2642e12];}else{
if(z4633c865c6>65535)z4633c865c6=65535;z4633c865c6=zcc6993f31f[z4633c865c6];
z86b36b953e=z4633c865c6;zd2940ad387=z4633c865c6;z36a2642e12=z4633c865c6;}



z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=(ushort4)(z86b36b953e,
zd2940ad387,z36a2642e12,0);}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
