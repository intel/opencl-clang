__kernel void zb3045b4704(__global float4*zf8d9fd6cb8,__global float*z718a062ddd
,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;float4 z493deefb55=zf8d9fd6cb8[
z83640e5796.x+z83640e5796.y*(z2824fcf57d)];z718a062ddd+=3*zaaf414d14e.x+
zaaf414d14e.y*z9562068e13*4;z718a062ddd[0]=z493deefb55.x;z718a062ddd[1]=
z493deefb55.y;z718a062ddd[2]=z493deefb55.z;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
