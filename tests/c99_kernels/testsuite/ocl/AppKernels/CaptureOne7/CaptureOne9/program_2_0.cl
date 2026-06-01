#define zbc6516e8d5 0

#ifndef zbc6516e8d5
#define zbc6516e8d5 0
#endif
#define		z946d5fd014			 8192
#define		zee1539f3bd	   13
#define		z8d03b06a7c	   11
#define		ze0a293662f	   15
#define		z3cacb7b3e7		 5461
#define		z641fc100fa		12288
#define		zf367aca852	 6553
#define		zd89fccbf4b	10240
typedef int zdba6b93f69;typedef uint za6c557b086;typedef ushort z51b7908a0d;
__kernel void z2a200da58b(__global ushort*zf8d9fd6cb8,__global ushort2*
z718a062ddd,int4 z30eaaf69b7,int z58c1e26fb1,int z745057f086,int2 z3b23994384,
int z5f291d10aa){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;int
z77c9074137=2;
int zd584e52585=4;
int2 z83640e5796=(int2)(4,2)*zba94ee46da.xy+z3b23994384.xy-(int2)zd584e52585;
zdba6b93f69 z9e3745df27=z58c1e26fb1;__global ushort*z71974023df;if(z5f291d10aa==
1)z71974023df=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z58c1e26fb1+1;else
z71974023df=zf8d9fd6cb8+z83640e5796.x+(z83640e5796.y+1)*z58c1e26fb1;__global
ushort*zddb0c6015b=z71974023df+2;ushort2 zad7cf55e92=(ushort2)z946d5fd014;

if(z83640e5796.x<zd584e52585||z83640e5796.y<zd584e52585||z83640e5796.x>=4*
z30eaaf69b7.z-zd584e52585||z83640e5796.y>=2*z30eaaf69b7.w-zd584e52585){
z718a062ddd[zba94ee46da.x+zba94ee46da.y*z745057f086/2]=zad7cf55e92;return;}
za6c557b086 z8ea65047ab=1;

zdba6b93f69 z0a90335373=-1-z9e3745df27;zdba6b93f69 za2c6ad4e57=+1-z9e3745df27;
zdba6b93f69 zc2a17a2cca=-1+z9e3745df27;zdba6b93f69 z39caaa6425=+1+z9e3745df27;
zdba6b93f69 zb145fbf2ff=-2-2*z9e3745df27;zdba6b93f69 z535952de7a=+2-2*
z9e3745df27;zdba6b93f69 ze3a85f0036=-2+2*z9e3745df27;zdba6b93f69 zcabbaaf9d9=+2+
2*z9e3745df27;uint2 z8a5c7786c8=(uint2)(z71974023df[0],zddb0c6015b[0]);int2
z1610b3029e=(int2)(z71974023df[zb145fbf2ff],zddb0c6015b[zb145fbf2ff]);int2
zdf61a10657=(int2)(z71974023df[z535952de7a],zddb0c6015b[z535952de7a]);int2
z87afd1c652=(int2)(z71974023df[ze3a85f0036],zddb0c6015b[ze3a85f0036]);int2
z635b8b6a7e=(int2)(z71974023df[zcabbaaf9d9],zddb0c6015b[zcabbaaf9d9]);int2
z4a771957d5=(int2)(z71974023df[z0a90335373],zddb0c6015b[z0a90335373]);int2
z72b83ee08f=(int2)(z71974023df[za2c6ad4e57],zddb0c6015b[za2c6ad4e57]);int2
za9f1a56ac2=(int2)(z71974023df[zc2a17a2cca],zddb0c6015b[zc2a17a2cca]);int2
z4a4ec6c1bd=(int2)(z71974023df[z39caaa6425],zddb0c6015b[z39caaa6425]);
int2 z82e3ac1505=max(max(max(z1610b3029e,z87afd1c652),zdf61a10657),z635b8b6a7e);
int2 z4ed7854a97=min(min(min(z1610b3029e,z87afd1c652),zdf61a10657),z635b8b6a7e);
uint2 z8e5d1aaece=convert_uint2(z4a771957d5+za9f1a56ac2+z72b83ee08f+z4a4ec6c1bd)
;uint2 zf833f0cac4=convert_uint2(z1610b3029e+z87afd1c652+zdf61a10657+z635b8b6a7e
)>>(uint2)1;if(z5f291d10aa==1){uint2 z4633c865c6=(z8e5d1aaece<<(uint2)
z8d03b06a7c)/((z8a5c7786c8+zf833f0cac4)/(uint2)3+(uint2)1);zad7cf55e92=
convert_ushort2_sat(min(max(z4633c865c6,(uint2)z3cacb7b3e7),(uint2)z641fc100fa))
;}else{uint2 z4633c865c6=(((z8a5c7786c8+zf833f0cac4)/(uint2)3)<<(uint2)
ze0a293662f)/(z8e5d1aaece+(uint2)1);zad7cf55e92=convert_ushort2_sat(min(max(
z4633c865c6,(uint2)zf367aca852),(uint2)zd89fccbf4b));}int2 za77496f82e=
z82e3ac1505-z4ed7854a97;if(za77496f82e.x>z8a5c7786c8.x)zad7cf55e92.x=(ushort)
z946d5fd014;if(za77496f82e.y>z8a5c7786c8.y)zad7cf55e92.y=(ushort)z946d5fd014;
z718a062ddd[zba94ee46da.x+zba94ee46da.y*z745057f086/2]=zad7cf55e92;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
