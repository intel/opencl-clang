
#ifndef z30701fddb8
#define z30701fddb8      (1)
#define zfe907af8b2  (2)
#define z110b189e8c (4)
#define zc5290d2f34     (1<<14)
#endif
#ifdef z370db0e88a
#define zc16cd55d87 (100 << 8)
#endif
#if (zc16cd55d87>0)
__kernel void zb24112f1df(__global ushort4*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,__global ushort*
z93a08e63a7,int zcbd83efe5f){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.
s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=
zba94ee46da+z30eaaf69b7.s01;
ushort4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];int2
z9b046bc3a1=z83640e5796;
int zbf07c83f29=0;if(z93a08e63a7){__global ushort*z37573045bb=z93a08e63a7+
z9b046bc3a1.x+z9b046bc3a1.y*zcbd83efe5f;zbf07c83f29=convert_int(z37573045bb[0]);
}if(zbf07c83f29==z30701fddb8)z493deefb55=(ushort4)(zc16cd55d87);z718a062ddd[
zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=z493deefb55;}
#else
__kernel void z70edf0b1e6(__global uchar4*zf8d9fd6cb8,__global uchar4*
z718a062ddd,int4 z30eaaf69b7,int z45c01651ac,int zb41a4b7008,__global ushort*
z93a08e63a7,int zcbd83efe5f,float4 z7e63fa890b,uchar4 z4234ea1e5b,uchar4
zf951091970,int4 z3841125904,__global uchar*zdd12fcd6f3,int2 z16ea3be7d3,float4
z6c588b2e56){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;int2
z83640e5796=zba94ee46da+z3841125904.xy;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.
xy;
uchar4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z45c01651ac/4];
z493deefb55.w=255;int2 z9b046bc3a1=z83640e5796;
int zbf07c83f29=0;if(z93a08e63a7){__global ushort*z37573045bb=z93a08e63a7+
z9b046bc3a1.x+z9b046bc3a1.y*zcbd83efe5f;zbf07c83f29=convert_int(z37573045bb[0]);
}if(zbf07c83f29&z30701fddb8)z493deefb55=(uchar4)(0,0,0,0);else{int zfcaa177308=
z16ea3be7d3.s0;if(z16ea3be7d3.s1>=0){uchar za097e3cbf4=zdd12fcd6f3[z9b046bc3a1.x
+z9b046bc3a1.y*zfcaa177308+z16ea3be7d3.s1];if(za097e3cbf4>0){float z1d45dfff76=
z6c588b2e56.w;float z90e1a42944=convert_float(za097e3cbf4)*z1d45dfff76;float
zc1a7596d5d=1.0f-z90e1a42944;float4 z1ba64f1f2a=z6c588b2e56*z90e1a42944+
convert_float4(z493deefb55)*zc1a7596d5d;z493deefb55=convert_uchar4_sat(
z1ba64f1f2a);z493deefb55.w=255;}}switch(zbf07c83f29){case zfe907af8b2:
z493deefb55=z4234ea1e5b;break;case z110b189e8c:z493deefb55=zf951091970;break;
case zc5290d2f34:{float z90e1a42944=z7e63fa890b.w;float zc1a7596d5d=1.0f-
z90e1a42944;float4 z1ba64f1f2a=z7e63fa890b*z90e1a42944+convert_float4(
z493deefb55)*zc1a7596d5d;z493deefb55=convert_uchar4_sat(z1ba64f1f2a);z493deefb55
.w=255;


}break;default:break;}}
#if zeea09a7c2c
z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*zb41a4b7008/4]=z493deefb55.wxyz;
#else

z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*zb41a4b7008/4]=z493deefb55.zyxw;
#endif
}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
