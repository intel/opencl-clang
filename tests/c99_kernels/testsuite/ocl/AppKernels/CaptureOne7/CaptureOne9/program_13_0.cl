typedef short2 z1b3183787b;
__kernel void z9ddd33f70c(__global ushort4*zf8d9fd6cb8,__global z1b3183787b*
z718a062ddd,int4 z30eaaf69b7,int z58c1e26fb1,int z9562068e13){int2 zba94ee46da=(
int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.z||
zba94ee46da.y>=z30eaaf69b7.w)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.xy;
zba94ee46da+=z30eaaf69b7.xy;ushort4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+
z83640e5796.y*(z58c1e26fb1/4)];short4 za44700ff9d=convert_short4(z493deefb55>>(
ushort4)(1,1,1,1));
z1b3183787b z4fd4e5fa4c=za44700ff9d.xz-za44700ff9d.yy;z718a062ddd[zba94ee46da.x+
zba94ee46da.y*z9562068e13]=z4fd4e5fa4c;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
