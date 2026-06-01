
#if (z3dbd1ff682==16)
#define z862d869b43 ushort4
#define z30075e0a44 ushort16
#else
#define z862d869b43 uchar4
#define z30075e0a44 uchar16
#endif
__kernel void z0aa6aa8c82(__global z862d869b43*zf8d9fd6cb8,__global z862d869b43*
z718a062ddd,int4 z30eaaf69b7,uint z45c01651ac,uint zb41a4b7008,int4 z7c7426cafd)
{int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(4*zba94ee46da.x>
z7c7426cafd.z||zba94ee46da.y>=z7c7426cafd.w)return;int2 z83640e5796=(int2)(4,1)*
zba94ee46da+z7c7426cafd.xy;zf8d9fd6cb8+=z83640e5796.x+z83640e5796.y*(z45c01651ac
/4);z30075e0a44 z493deefb55;z493deefb55.s0123=zf8d9fd6cb8[0];z493deefb55.s4567=
zf8d9fd6cb8[1];z493deefb55.s89ab=zf8d9fd6cb8[2];z493deefb55.scdef=zf8d9fd6cb8[3]
;


z718a062ddd+=3*zba94ee46da.x+zba94ee46da.y*(zb41a4b7008/4);z718a062ddd[0]=
z493deefb55.s0124;z718a062ddd[1]=z493deefb55.s5689;z718a062ddd[2]=z493deefb55.
sacde;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
