__kernel void z165d18a6e4(__global ushort*zf8d9fd6cb8,__global ushort2*
z718a062ddd,int4 z30eaaf69b7,int z58c1e26fb1,int z745057f086,float z86dd029962){
int2 zba94ee46da=(int2)(2*get_global_id(0),get_global_id(1));if(zba94ee46da.x+1
>=z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.xy
;int2 z83640e5796=zba94ee46da;int z3b23994384=z83640e5796.x+z83640e5796.y*
z58c1e26fb1;ushort2 z493deefb55=vload2(0,zf8d9fd6cb8+z3b23994384);float2
zec3db0ba8e=convert_float2(z493deefb55)*z86dd029962;z493deefb55=
convert_ushort2_sat(zec3db0ba8e);
int z77f8ae3448=(zba94ee46da.x/2)+zba94ee46da.y*(z745057f086/2);z718a062ddd[
z77f8ae3448]=z493deefb55;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
