__kernel void z24d61569fd(__global ushort4*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int4 z30eaaf69b7,int z58c1e26fb1,int z745057f086,float z86dd029962){
int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x+1>=
z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.xy;
int2 z83640e5796=zba94ee46da;ushort4 z3931fc4ce8=zf8d9fd6cb8[z83640e5796.x+
z83640e5796.y*(z58c1e26fb1/4)];z3931fc4ce8.w=0;float4 z21852c2870=convert_float4
(z3931fc4ce8)*z86dd029962;z3931fc4ce8=convert_ushort4_sat(z21852c2870);
int z77f8ae3448=zba94ee46da.x+zba94ee46da.y*(z745057f086/4);z718a062ddd[
z77f8ae3448]=z3931fc4ce8;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
