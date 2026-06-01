__kernel void za681ce06f0(__global ushort*zcd420da6ce,__global ushort4*
z718a062ddd,int4 z30eaaf69b7,uint z58c1e26fb1,uint z745057f086,int4 zcf4670ee56,
int zf11d612476,float4 z29926d82e3,int4 z2e16c81e83,int z0f0af5965d,int
z98ea7b8fe6,__global ushort*z415f880817,uint zeb5cf63993){int2 zba94ee46da=(int2
)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.z||
zba94ee46da.y>=z30eaaf69b7.w)return;int2 z83640e5796=zf11d612476*zba94ee46da+
convert_int2(z29926d82e3.xy);int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.xy;if(
z83640e5796.x<0)z83640e5796.x=-z83640e5796.x;if(z83640e5796.y<0)z83640e5796.y=-
z83640e5796.y;if(z83640e5796.x>=zcf4670ee56.s2)z83640e5796.x=2*zcf4670ee56.s2-
z83640e5796.x-2;if(z83640e5796.y>=zcf4670ee56.s3)z83640e5796.y=2*zcf4670ee56.s3-
z83640e5796.y-2;__global ushort*zf8d9fd6cb8=zcd420da6ce;if(zeb5cf63993>0&&
z83640e5796.y>=zeb5cf63993){zf8d9fd6cb8=z415f880817;z83640e5796.y-=zeb5cf63993;}
zf8d9fd6cb8+=zcf4670ee56.x+(zcf4670ee56.y*z58c1e26fb1);int ze4b052164b=
z2e16c81e83.s0;int zfc397c3985=z2e16c81e83.s1;int zef38832825=z2e16c81e83.s2;int
 z7e674d442a=z2e16c81e83.s3;ushort4 z493deefb55;if(!z0f0af5965d){int zc9d655d235
=3*z83640e5796.x+z83640e5796.y*z58c1e26fb1;ushort4 zc49fd590d9=(ushort4)(
zf8d9fd6cb8[zc9d655d235],zf8d9fd6cb8[1+zc9d655d235],zf8d9fd6cb8[2+zc9d655d235],0
);ushort4 z0b527eaaf8=(ushort4)(zf8d9fd6cb8[3+zc9d655d235],zf8d9fd6cb8[4+
zc9d655d235],zf8d9fd6cb8[5+zc9d655d235],0);zc9d655d235+=z58c1e26fb1;ushort4
zf49d599761=(ushort4)(zf8d9fd6cb8[zc9d655d235],zf8d9fd6cb8[1+zc9d655d235],
zf8d9fd6cb8[2+zc9d655d235],0);ushort4 z537ce686e7=(ushort4)(zf8d9fd6cb8[3+
zc9d655d235],zf8d9fd6cb8[4+zc9d655d235],zf8d9fd6cb8[5+zc9d655d235],0);uint4
z57105a580b=convert_uint4(zc49fd590d9)+convert_uint4(z0b527eaaf8)+convert_uint4(
zf49d599761)+convert_uint4(z537ce686e7);z493deefb55=convert_ushort4_sat(
z57105a580b/(uint4)(4,4,4,0));}else{z493deefb55.x=zf8d9fd6cb8[ze4b052164b+
z83640e5796.x+z83640e5796.y*z58c1e26fb1];z493deefb55.y=convert_ushort_sat((
convert_uint(zf8d9fd6cb8[zfc397c3985+z83640e5796.x+z83640e5796.y*z58c1e26fb1])+
convert_uint(zf8d9fd6cb8[zef38832825+z83640e5796.x+z83640e5796.y*z58c1e26fb1]))/
2);z493deefb55.z=zf8d9fd6cb8[z7e674d442a+z83640e5796.x+z83640e5796.y*z58c1e26fb1
];}if(z98ea7b8fe6){uint4 z57105a580b=convert_uint4(z493deefb55);uint z88dce4da4d
=z57105a580b.x+z57105a580b.y*2+z57105a580b.z;z493deefb55=convert_ushort4_sat((
uint4)(z88dce4da4d/4));}z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*(z745057f086/4)]
=z493deefb55;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
