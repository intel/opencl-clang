__kernel void z32d529e176(__global ushort*zf8d9fd6cb8,__global ushort2*
z718a062ddd,int4 z30eaaf69b7,int z58c1e26fb1,int z745057f086){int2 zba94ee46da=(
int2)(2*get_global_id(0),2*get_global_id(1));if(zba94ee46da.x+1>=z30eaaf69b7.z||
zba94ee46da.y+1>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.xy;int2
z83640e5796=zba94ee46da;int z3b23994384=z83640e5796.x+(1+z83640e5796.y)*
z58c1e26fb1;ushort2 z493deefb55=vload2(0,zf8d9fd6cb8+z3b23994384);int
z88dce4da4d=0;
#if 1
z88dce4da4d=convert_int(zf8d9fd6cb8[z3b23994384+2*z58c1e26fb1+3]);z88dce4da4d+=3
*convert_int(zf8d9fd6cb8[z3b23994384+2*z58c1e26fb1+1]);z88dce4da4d+=3*
convert_int(zf8d9fd6cb8[z3b23994384+1]);z88dce4da4d+=9*convert_int(z493deefb55.y
);
#else
z88dce4da4d=convert_int(zf8d9fd6cb8[z3b23994384-2*z58c1e26fb1-1]);z88dce4da4d+=3
*convert_int(zf8d9fd6cb8[z3b23994384-2*z58c1e26fb1+1]);z88dce4da4d+=3*
convert_int(zf8d9fd6cb8[z3b23994384-1]);z88dce4da4d+=9*convert_int(z493deefb55.y
);
#endif
z493deefb55.y=convert_ushort_sat(z88dce4da4d/16);
int z77f8ae3448=(zba94ee46da.x/2)+(1+zba94ee46da.y)*(z745057f086/2);z718a062ddd[
z77f8ae3448]=z493deefb55;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
