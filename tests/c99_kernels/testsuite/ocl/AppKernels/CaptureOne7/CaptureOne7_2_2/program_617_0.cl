__kernel void zdfaa196318(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,uint z45c01651ac,uint zb41a4b7008){int2 zba94ee46da
=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.z||
zba94ee46da.y>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.xy;int2 z83640e5796
=zba94ee46da;float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(
z45c01651ac/4)];z718a062ddd[zba94ee46da.x+zba94ee46da.y*(zb41a4b7008/4)]=
z493deefb55.yyyy;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
