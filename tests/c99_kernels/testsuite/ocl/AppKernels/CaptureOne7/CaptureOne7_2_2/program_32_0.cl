#define zbc6516e8d5 0

#ifndef zbc6516e8d5
#define zbc6516e8d5 1
#endif
#if zbc6516e8d5
#define z5908e84ae5 __local ushort4
#else
#define z5908e84ae5 __global ushort4
#endif
float zbac28489bf(z5908e84ae5*zf8d9fd6cb8,int zbced03a0bf){float z88fa33d26d=
convert_float(zf8d9fd6cb8[-zbced03a0bf].y);float z5083031dab=convert_float(
zf8d9fd6cb8[zbced03a0bf].y);float ze384962f2b=convert_float(zf8d9fd6cb8[1].y);
float w=convert_float(zf8d9fd6cb8[-1].y);float z7c83382301=convert_float(
zf8d9fd6cb8[-zbced03a0bf-1].y);float z2495fb4eee=convert_float(zf8d9fd6cb8[-
zbced03a0bf+1].y);float z46d4ed32bc=convert_float(zf8d9fd6cb8[zbced03a0bf-1].y);
float z88370fd9e8=convert_float(zf8d9fd6cb8[zbced03a0bf+1].y);float4 zea34483265
=(float4)(z88fa33d26d,w,z7c83382301,z2495fb4eee);float4 z38c36eec91=
convert_float(zf8d9fd6cb8[0].y);
float4 z8a30e7e6ed=(float4)(z5083031dab,ze384962f2b,z88370fd9e8,z46d4ed32bc);
const float z36122dfbb4=5.5f/16.0f;const float z2c43250851=5.0f/16.0f;float4
z28b616e646=z36122dfbb4*zea34483265+z2c43250851*z38c36eec91+z36122dfbb4*
z8a30e7e6ed;float4 zec65e8d581=fabs(z28b616e646-zea34483265)+fabs(z28b616e646-
z38c36eec91)+fabs(z28b616e646-z8a30e7e6ed);

float z1237f3d2b3=z28b616e646.x;float z134e9d9449=zec65e8d581.x;if(zec65e8d581.y
<zec65e8d581.x){z1237f3d2b3=z28b616e646.y;z134e9d9449=zec65e8d581.y;}float
z94474c6626=z28b616e646.z;float z2e6687317b=zec65e8d581.z;if(zec65e8d581.w<
zec65e8d581.z){z94474c6626=z28b616e646.w;z2e6687317b=zec65e8d581.w;}float
zd3113bb895=z1237f3d2b3;if(z2e6687317b<z134e9d9449){
zd3113bb895=dot((float2)(0.33333f,0.666666f),(float2)(z94474c6626,z1237f3d2b3));
}return zd3113bb895;}
#define z73a6d0c759 1
__kernel void zf8866112e4(__global ushort4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,uint z58c1e26fb1,uint z958df11031
#if zbc6516e8d5
,__local ushort4*zf485e5e12c
#endif
){int2 z945895b462=(int2)(2*get_global_id(0),get_global_id(1));int2 zba94ee46da=
z945895b462+z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;int z796a73b2c0=
z58c1e26fb1/4;
#if zbc6516e8d5
int z6e29e29e19=2*get_local_size(0)+2*z73a6d0c759;__local ushort4*zb5c34da6f7=
zf485e5e12c;int2 z7cdb6ae8dd=(int2)(2*get_local_id(0)+z73a6d0c759,get_local_id(1
)+z73a6d0c759);int2 z61bac1bc70=z83640e5796-z7cdb6ae8dd;int z2cf8520e42=
z61bac1bc70.x+z61bac1bc70.y*z796a73b2c0;int zf54614f74b=(z30eaaf69b7.z-1)+
z796a73b2c0*(z30eaaf69b7.w-1);int z8b1bb737a4=get_local_id(0)+get_local_id(1)*
get_local_size(0);int z4b946a6906=3*z8b1bb737a4;int za6fbfbc4c3=(z73a6d0c759+
get_local_size(1)+z73a6d0c759)*z6e29e29e19;for(int z8dd6fa68b0=0;z8dd6fa68b0<3;
z8dd6fa68b0++){int z38a89f6944=z4b946a6906+z8dd6fa68b0;if(z38a89f6944<
za6fbfbc4c3){int z4a5805e56d=z38a89f6944%z6e29e29e19;int zd47cd65624=z38a89f6944
/z6e29e29e19;int z95a479821b=z4a5805e56d+zd47cd65624*z796a73b2c0;z95a479821b=
clamp(z95a479821b+z2cf8520e42,0,zf54614f74b);zf485e5e12c[z38a89f6944]=
zf8d9fd6cb8[z95a479821b];}}barrier(CLK_LOCAL_MEM_FENCE);zb5c34da6f7+=z7cdb6ae8dd
.x+z7cdb6ae8dd.y*z6e29e29e19;z796a73b2c0=z6e29e29e19;
#else
__global ushort4*zb5c34da6f7=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z796a73b2c0
;
#endif
if(z945895b462.x>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return;int
zcdf189b12e=zba94ee46da.x+zba94ee46da.y*z958df11031/4;int zbdf9ccc6ff=0;if(
z945895b462.y&1)
zbdf9ccc6ff=1;float4 z53cdc3ccd8=convert_float4(zb5c34da6f7[zbdf9ccc6ff]);float4
 zd835bc29db=convert_float4(zb5c34da6f7[1-zbdf9ccc6ff]);z718a062ddd[zcdf189b12e+
1-zbdf9ccc6ff]=(float4)(0.0f,zd835bc29db.y,0.0f,0.0f);if(z945895b462.y&1)
z53cdc3ccd8.x=z53cdc3ccd8.y;else z53cdc3ccd8.z=z53cdc3ccd8.y;z53cdc3ccd8.y=
zbac28489bf(zb5c34da6f7+zbdf9ccc6ff,z796a73b2c0);z718a062ddd[zcdf189b12e+
zbdf9ccc6ff]=z53cdc3ccd8;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
