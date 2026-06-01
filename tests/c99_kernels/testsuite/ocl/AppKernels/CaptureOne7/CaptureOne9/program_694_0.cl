__kernel void z705c623769(__global ushort*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,int z58c1e26fb1,int z958df11031){int2 zba94ee46da=(
int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.z||
zba94ee46da.y>=z30eaaf69b7.w)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.xy;
zba94ee46da+=z30eaaf69b7.xy;ushort z493deefb55=zf8d9fd6cb8[+z83640e5796.x+
z83640e5796.y*(z58c1e26fb1)];z718a062ddd[zba94ee46da.x+zba94ee46da.y*z958df11031
/4]=convert_float4((ushort4)(z493deefb55,z493deefb55,z493deefb55,z493deefb55));}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
