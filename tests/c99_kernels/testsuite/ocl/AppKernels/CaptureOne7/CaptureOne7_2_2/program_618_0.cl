__kernel void zb1d09abedd(__global ushort*zcd420da6ce,__global ushort4*
z718a062ddd,int4 z30eaaf69b7,uint z58c1e26fb1,uint z745057f086,int4 zcf4670ee56,
int4 z9b669cf1d5){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;int2
z83640e5796=zba94ee46da+z9b669cf1d5.xy;__global ushort*zf8d9fd6cb8=zcd420da6ce+3
*zcf4670ee56.x+(zcf4670ee56.y*z58c1e26fb1);zba94ee46da+=z30eaaf69b7.xy;if(
z83640e5796.x<0)z83640e5796.x=(-z83640e5796.x);if(z83640e5796.y<0)z83640e5796.y=
(-z83640e5796.y);if(z83640e5796.x>=zcf4670ee56.s2)z83640e5796.x=2*zcf4670ee56.s2
-z83640e5796.x-2;if(z83640e5796.y>=zcf4670ee56.s3)z83640e5796.y=2*zcf4670ee56.s3
-z83640e5796.y-2;ushort4 z493deefb55;int z3b23994384=3*z83640e5796.x+z83640e5796
.y*z58c1e26fb1;z493deefb55.x=zf8d9fd6cb8[z3b23994384];z493deefb55.y=zf8d9fd6cb8[
z3b23994384+1];z493deefb55.z=zf8d9fd6cb8[z3b23994384+2];z493deefb55.w=0;
z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z745057f086/4)]=z493deefb55;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
