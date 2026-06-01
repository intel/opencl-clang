#define zbc6516e8d5  0

#ifndef zbc6516e8d5
#define zbc6516e8d5 0
#endif
#ifndef za38f45ad91
#define za38f45ad91 1
#endif
typedef int zdba6b93f69;typedef uint za6c557b086;typedef ushort z51b7908a0d;
#define		z946d5fd014			 8192
__kernel void z1bd2a27656(__global ushort*zf8d9fd6cb8,__global ushort2*
z718a062ddd,int4 z30eaaf69b7,uint z58c1e26fb1,uint z745057f086){int2 zba94ee46da
=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.z||
zba94ee46da.y>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.xy;
int2 z83640e5796=(int2)(2,1)*zba94ee46da;z745057f086/=2;


__global ushort*z2fecbfdf48=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z58c1e26fb1;
__global ushort*z30b3f149d4=z2fecbfdf48+1;__global ushort2*z559a36834b=
z718a062ddd+z83640e5796.x/2+z83640e5796.y*z745057f086;zdba6b93f69 zac4e39e0d0=
z58c1e26fb1;zdba6b93f69 zcad8124a8f=-1;zdba6b93f69 zabcbae3fb5=+1;zdba6b93f69
zd8146dde32=-zac4e39e0d0;zdba6b93f69 zec6f5ab25e=+zac4e39e0d0;zdba6b93f69
z0a90335373=-1-zac4e39e0d0;zdba6b93f69 za2c6ad4e57=+1-zac4e39e0d0;zdba6b93f69
zc2a17a2cca=-1+zac4e39e0d0;zdba6b93f69 z39caaa6425=+1+zac4e39e0d0;int2
z20021f8985=(int2)(z2fecbfdf48[zcad8124a8f],z30b3f149d4[zcad8124a8f])+(int2)(
z2fecbfdf48[zabcbae3fb5],z30b3f149d4[zabcbae3fb5])+(int2)(z2fecbfdf48[
zd8146dde32],z30b3f149d4[zd8146dde32])+(int2)(z2fecbfdf48[zec6f5ab25e],
z30b3f149d4[zec6f5ab25e]);int2 z02a20e592f=(int2)(z2fecbfdf48[z0a90335373],
z30b3f149d4[z0a90335373])+(int2)(z2fecbfdf48[za2c6ad4e57],z30b3f149d4[
za2c6ad4e57])+(int2)(z2fecbfdf48[zc2a17a2cca],z30b3f149d4[zc2a17a2cca])+(int2)(
z2fecbfdf48[z39caaa6425],z30b3f149d4[z39caaa6425]);z559a36834b[0]=
convert_ushort2(((int2)(z2fecbfdf48[0],z30b3f149d4[0])+(z20021f8985-z02a20e592f)
/8+(int2)z946d5fd014)>>1);}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
