__kernel void z2b33661b75(__global ushort*zcd420da6ce,__global ushort*
zddaa6f652d,int4 z30eaaf69b7,uint z58c1e26fb1,uint z745057f086,int4 zcf4670ee56,
int4 z9b669cf1d5,__global ushort*z415f880817,int zeb5cf63993){ushort2
z963ba64275;ushort*z493deefb55=(ushort*)&z963ba64275;int2 za1542d3bfb=(int2)(
get_global_id(0),get_global_id(1));if(2*za1542d3bfb.x+1>=z30eaaf69b7.z||
za1542d3bfb.y>=z30eaaf69b7.w)return;int2 zba94ee46da=(int2)(2*za1542d3bfb.x,
za1542d3bfb.y);int2 z83640e5796=zba94ee46da+z9b669cf1d5.xy;if(z83640e5796.y<0)
z83640e5796.y=(-z83640e5796.y);if(z83640e5796.y>=zcf4670ee56.s3)z83640e5796.y=2*
zcf4670ee56.s3-z83640e5796.y-2;__global ushort*zf8d9fd6cb8=zcd420da6ce;if(
zeb5cf63993>0&&z83640e5796.y>=zeb5cf63993){zf8d9fd6cb8=z415f880817;z83640e5796.y
-=zeb5cf63993;}zf8d9fd6cb8+=zcf4670ee56.x+(zcf4670ee56.y*z58c1e26fb1);for(int
z1d8bd19892=0;z1d8bd19892<2;z1d8bd19892++){z83640e5796.x+=z1d8bd19892;if(
z83640e5796.x<0)z83640e5796.x=(-z83640e5796.x);if(z83640e5796.x>=zcf4670ee56.s2)
z83640e5796.x=2*zcf4670ee56.s2-z83640e5796.x-2;z493deefb55[z1d8bd19892]=
zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z58c1e26fb1];}int z77f8ae3448=2*
za1542d3bfb.x+z30eaaf69b7.x+(za1542d3bfb.y+z30eaaf69b7.y)*z745057f086;__global
ushort*ze4351005bc=zddaa6f652d+z77f8ae3448;ze4351005bc[0]=z963ba64275.x;
ze4351005bc[1]=z963ba64275.y;


}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
