#define zbc6516e8d5  1
#define z8b6bce8773  1

#ifndef zbc6516e8d5
#define zbc6516e8d5 0
#endif
#ifndef z8b6bce8773
#define z8b6bce8773 0
#endif
#define z164047dc0a 5
__kernel void z1956f92cab(__global ushort*zf8d9fd6cb8,__global ushort2*
z718a062ddd,int4 z30eaaf69b7,uint z58c1e26fb1,uint z745057f086){int2 zba94ee46da
=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.z||
zba94ee46da.y>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.xy;int2 z83640e5796
=(int2)(2,1)*zba94ee46da;__global ushort*zad7cf55e92=zf8d9fd6cb8+z83640e5796.x+
z83640e5796.y*z58c1e26fb1;__global ushort2*z559a36834b=z718a062ddd+zba94ee46da.x
+zba94ee46da.y*z745057f086/2;int zac4e39e0d0=z58c1e26fb1;
#if z164047dc0a==3
#if z8b6bce8773
int z8ea92fe60a=zac4e39e0d0;
#else
int z8ea92fe60a=1;
#endif
za6c557b086 z5df120c718=zad7cf55e92[-z8ea92fe60a];za6c557b086 z6805d309c8=
zad7cf55e92[0];za6c557b086 z27d88062eb=zad7cf55e92[z8ea92fe60a];z559a36834b[0]=
convert_ushort(z5df120c718+z6805d309c8+z27d88062eb-min(min(z5df120c718,
z6805d309c8),z27d88062eb)-max(max(z5df120c718,z6805d309c8),z27d88062eb));
#else
#if	z8b6bce8773

uint za622bf1c3d=-1+zac4e39e0d0;
#else

uint za622bf1c3d=1+zac4e39e0d0;
#endif

__global ushort*z5519af8785=zad7cf55e92-2*za622bf1c3d;uint2 zab2c9ec183=(uint2)(
z5519af8785[0],z5519af8785[1]);uint2 z3fefbbad03=(uint2)(z5519af8785[0],
z5519af8785[1]);uint2 z33d1c12dd4=(uint2)(z5519af8785[0],z5519af8785[1]);for(int
 z78b1a4480b=0;z78b1a4480b<4;z78b1a4480b+=1){z5519af8785+=za622bf1c3d;
zab2c9ec183+=(uint2)(z5519af8785[0],z5519af8785[1]);z3fefbbad03=min(z3fefbbad03,
(uint2)(z5519af8785[0],z5519af8785[1]));z33d1c12dd4=max(z33d1c12dd4,(uint2)(
z5519af8785[0],z5519af8785[1]));}z559a36834b[0]=convert_ushort2((zab2c9ec183-
z3fefbbad03-z33d1c12dd4)/3);
#endif
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
