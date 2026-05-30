#define z1e1205338a  float4

#ifndef zbc6516e8d5
#define zbc6516e8d5 1
#endif
float zec15f7fa83(float4 z205d564e2f){return dot(z205d564e2f,(float4)(0.299f,
0.587f,0.114f,0.0f));}
#ifndef z1e1205338a
#define z1e1205338a ushort4
#endif
__kernel void zb06dcbd038(__global z1e1205338a*zf8d9fd6cb8,__global float*
z718a062ddd,int4 z30eaaf69b7,uint z45c01651ac,uint z958df11031){int2 zba94ee46da
=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.z||
zba94ee46da.y>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.xy;int2 z83640e5796
=zba94ee46da;
z1e1205338a z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z45c01651ac/4)]
;float Y=zec15f7fa83(convert_float4(z493deefb55));z718a062ddd[zba94ee46da.x+
zba94ee46da.y*z958df11031]=Y;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
