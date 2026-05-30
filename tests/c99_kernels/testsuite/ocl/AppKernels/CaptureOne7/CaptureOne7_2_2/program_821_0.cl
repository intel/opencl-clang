
#ifndef z30701fddb8
#define z30701fddb8      1
#define zfe907af8b2  2
#define z110b189e8c 4
#define zc5290d2f34     (1<<14)
#endif
__kernel void zab1a5c57e3(__global ushort4*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int4 z30eaaf69b7,uint z58c1e26fb1,uint z745057f086,__global int*
z93a08e63a7,uint zcbd83efe5f,ushort4 zc301712045){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.z||zba94ee46da.
y>=z30eaaf69b7.w)return;ushort z8b6e8f21ea=zc301712045.x;ushort z23b9dbff35=
zc301712045.y;bool ze4d4057b69=zc301712045.z>0;bool zbb289a6c05=zc301712045.w>0;
zba94ee46da+=z30eaaf69b7.xy;int z182ef46077=z93a08e63a7[zba94ee46da.x+
zba94ee46da.y*zcbd83efe5f];int2 z83640e5796=zba94ee46da;
ushort4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z58c1e26fb1/4)];
ushort z7fb8bf6fd3=max(z493deefb55.x,max(z493deefb55.y,z493deefb55.z));if(
ze4d4057b69&&z7fb8bf6fd3>=z8b6e8f21ea)z182ef46077+=zfe907af8b2;if(zbb289a6c05&&
z7fb8bf6fd3<=z23b9dbff35)z182ef46077+=z110b189e8c;z93a08e63a7[zba94ee46da.x+
zba94ee46da.y*zcbd83efe5f]=z182ef46077;z718a062ddd[zba94ee46da.x+zba94ee46da.y*(
z745057f086/4)]=z493deefb55;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
