__kernel void zb3045b4704(__global float4*zf8d9fd6cb8,__global float*z718a062ddd
,int4 z30eaaf69b7,uint z021babbfad,uint z958df11031){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.z||zba94ee46da.
y>=z30eaaf69b7.w)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.xy;zba94ee46da
+=z30eaaf69b7.xy;float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(
z021babbfad/4)];z718a062ddd+=3*zba94ee46da.x+zba94ee46da.y*z958df11031;
z718a062ddd[0]=z493deefb55.x;z718a062ddd[1]=z493deefb55.y;z718a062ddd[2]=
z493deefb55.z;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
