float zec15f7fa83(float4 z205d564e2f){return dot(z205d564e2f,(float4)(0.299f,
0.587f,0.114f,0.0f));}__kernel void z906da05d53(__global ushort4*zf8d9fd6cb8,
__global float*z718a062ddd,int4 z30eaaf69b7,int z45c01651ac,int z958df11031,int2
 zd72c7cd02e){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;int2
z83640e5796=zba94ee46da*(int2)(8,8)+zd72c7cd02e.xy;int z0b6cb751d4=z958df11031;
__global float*z1765c59f1b=z718a062ddd;
float z5413c0ac97=0.0f;
__global ushort4*z6533f4e792=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*(
z45c01651ac/4);for(int z04337ebea9=-7;z04337ebea9<=7;z04337ebea9++){float
z785feecec0=8.0f-fabs(convert_float(z04337ebea9));int line=(z45c01651ac/4)*
z04337ebea9;for(int z6a957fe2f1=(-7);z6a957fe2f1<(-3);z6a957fe2f1++){float
zdf8f02136c=8.0f-fabs(convert_float(z6a957fe2f1));ushort4 z493deefb55=
z6533f4e792[line+z6a957fe2f1];z5413c0ac97+=zec15f7fa83(convert_float4(
z493deefb55))*zdf8f02136c*z785feecec0;}for(int z6a957fe2f1=(-3);z6a957fe2f1<0;
z6a957fe2f1++){float zdf8f02136c=8.0f-fabs(convert_float(z6a957fe2f1));ushort4
z493deefb55=z6533f4e792[line+z6a957fe2f1];z5413c0ac97+=zec15f7fa83(
convert_float4(z493deefb55))*zdf8f02136c*z785feecec0;}for(int z6a957fe2f1=0;
z6a957fe2f1<4;z6a957fe2f1++){float zdf8f02136c=8.0f-fabs(convert_float(
z6a957fe2f1));ushort4 z493deefb55=z6533f4e792[line+z6a957fe2f1];z5413c0ac97+=
zec15f7fa83(convert_float4(z493deefb55))*zdf8f02136c*z785feecec0;}for(int
z6a957fe2f1=4;z6a957fe2f1<=7;z6a957fe2f1++){float zdf8f02136c=8.0f-fabs(
convert_float(z6a957fe2f1));ushort4 z493deefb55=z6533f4e792[line+z6a957fe2f1];
z5413c0ac97+=zec15f7fa83(convert_float4(z493deefb55))*zdf8f02136c*z785feecec0;}}
z1765c59f1b[zba94ee46da.y*z0b6cb751d4+zba94ee46da.x]=z5413c0ac97;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
