#define USE_LOCAL 0

#define zbc6516e8d5 0

#define z51a98521ee 15000
#define zdcc1f6f2eb(z95287ec68e,zf8d9fd6cb8,z718a062ddd,z3b23994384, z77f8ae3448\
, zb3ec2e5425, z975716b4ab, zf77c7f8449, z47728d2efe, z77c9074137) \
 z95287ec68e(&z718a062ddd[z77f8ae3448], &zf8d9fd6cb8[z3b23994384] ); \
 if (zf77c7f8449.x < z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448-z975716b4ab.x], & zf8d9fd6cb8[z3b23994384-\
zb3ec2e5425.x]); \
 if (zf77c7f8449.y < z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448-z975716b4ab.y], & zf8d9fd6cb8[z3b23994384-\
zb3ec2e5425.y]); \
 if (zf77c7f8449.x >= z47728d2efe.x-z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448+z975716b4ab.x], & zf8d9fd6cb8[z3b23994384+\
zb3ec2e5425.x]); \
 if (zf77c7f8449.y >= z47728d2efe.y-z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448+z975716b4ab.y], & zf8d9fd6cb8[z3b23994384+\
zb3ec2e5425.y]); \
 if (zf77c7f8449.x < z77c9074137 && zf77c7f8449.y < z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448-z975716b4ab.x-z975716b4ab.y], & \
zf8d9fd6cb8[z3b23994384-zb3ec2e5425.x-zb3ec2e5425.y]); \
 if (zf77c7f8449.x >= z47728d2efe.x-z77c9074137 && zf77c7f8449.y < z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448+z975716b4ab.x-z975716b4ab.y], & \
zf8d9fd6cb8[z3b23994384+zb3ec2e5425.x-zb3ec2e5425.y]); \
 if (zf77c7f8449.x < z77c9074137 && zf77c7f8449.y >= z47728d2efe.y-z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448-z975716b4ab.x+z975716b4ab.y], & \
zf8d9fd6cb8[z3b23994384-zb3ec2e5425.x+zb3ec2e5425.y]); \
 if (zf77c7f8449.x >= z47728d2efe.x-z77c9074137 && zf77c7f8449.y >= z47728d2efe.\
y-z77c9074137) \
	z95287ec68e(&z718a062ddd[z77f8ae3448+z975716b4ab.x+z975716b4ab.y], & \
zf8d9fd6cb8[z3b23994384+zb3ec2e5425.x+zb3ec2e5425.y]); \

void zb03b560df4(__local ushort2*z718a062ddd,__global ushort2*zf8d9fd6cb8){
z718a062ddd[0]=zf8d9fd6cb8[0];}
#define z73a6d0c759 2
__kernel void z220c584f94(__global ushort*zf8d9fd6cb8,__global ushort2*
z718a062ddd,int4 z30eaaf69b7,int z58c1e26fb1,int z745057f086,float z226e55a344,
float z6cb277757e
#if 0
,__local ushort*z845f6c4669
#endif
){int2 z945895b462=(int2)(2*get_global_id(0),2*get_global_id(1));int2
zba94ee46da=z945895b462+z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;int
zc9d655d235=z83640e5796.x+z83640e5796.y*z58c1e26fb1;int2 z47728d2efe=(int2)(
get_local_size(0),get_local_size(1));
const int z6e29e29e19=get_local_size(0)+2*z73a6d0c759;int2 z3fee8e0edb=(int2)(
get_local_id(0),get_local_id(1));int2 zb3ec2e5425=(int2)(z73a6d0c759,z73a6d0c759
*z58c1e26fb1);
#if zbc6516e8d5
__local ushort*zf282cd8203=z845f6c4669+z73a6d0c759+z73a6d0c759*z6e29e29e19;int2
z8ea92fe60a=(int2)(z73a6d0c759,z73a6d0c759*z6e29e29e19);int zd72c7cd02e=
z3fee8e0edb.x+z3fee8e0edb.y*z6e29e29e19;
if(z945895b462.x<z30eaaf69b7.s2&&z945895b462.y<z30eaaf69b7.s3){zdcc1f6f2eb(
zb03b560df4,zf8d9fd6cb8,zf282cd8203,zc9d655d235,zd72c7cd02e,zb3ec2e5425,
z8ea92fe60a,z3fee8e0edb,z47728d2efe,z73a6d0c759)}barrier(CLK_LOCAL_MEM_FENCE);
#endif
if(z945895b462.x>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return;




int z9e3745df27=z58c1e26fb1;
__global ushort*z1105e7a757=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z58c1e26fb1;
;__global ushort2*z01c61887e6=z718a062ddd+z83640e5796.x/2+z83640e5796.y*
z745057f086/2;

uint2 z1b1d165636=(uint2)(z1105e7a757[(-2)*z9e3745df27+(1)],z1105e7a757[(-1)*
z9e3745df27+(0)]);uint2 zfa6e2e08da=(uint2)(z1b1d165636.y,z1105e7a757[(0)*
z9e3745df27+(-1)]);uint2 z35e1372aeb=(uint2)(z1105e7a757[(-1)*z9e3745df27+(2)],
z1105e7a757[(0)*z9e3745df27+(1)]);uint2 z28198ad47e=(uint2)(zfa6e2e08da.y,
z1105e7a757[(1)*z9e3745df27+(-2)]);uint2 z967de87243=(uint2)(z35e1372aeb.y,
z1105e7a757[(1)*z9e3745df27+(0)]);uint2 zed64b74eb7=(uint2)(z1105e7a757[(0)*
z9e3745df27+(3)],z1105e7a757[(1)*z9e3745df27+(2)]);uint2 z7d8d12dd83=(uint2)(
z967de87243.y,z1105e7a757[(2)*z9e3745df27+(-1)]);uint2 z3076548639=(uint2)(
zed64b74eb7.y,z1105e7a757[(2)*z9e3745df27+(1)]);uint2 za3f9fd8b88=(uint2)(
z3076548639.y,z1105e7a757[(3)*z9e3745df27+(0)]);
uint2 z778c582bcd=(2*zfa6e2e08da+2*z35e1372aeb+2*z7d8d12dd83+2*z3076548639+4*
z967de87243+(uint2)3+z1b1d165636+zed64b74eb7+za3f9fd8b88+z28198ad47e)>>(uint2)4;
float2 z3724ae3b8c=fabs(convert_float2(zfa6e2e08da+z7d8d12dd83+(uint2)
z51a98521ee)/convert_float2(z35e1372aeb+z3076548639+(uint2)z51a98521ee)-(float2)
1);float2 za3a9f9a4b5=fabs(convert_float2(zfa6e2e08da+z35e1372aeb+(uint2)
z51a98521ee)/convert_float2(z7d8d12dd83+z3076548639+(uint2)z51a98521ee)-(float2)
1);ushort2 z51eadf1cec=convert_ushort2_sat(mix(convert_float2(z967de87243),
convert_float2(z778c582bcd),(float2)z6cb277757e));if(z3724ae3b8c.x<z226e55a344&&
za3a9f9a4b5.x<z226e55a344)z01c61887e6[0]=(ushort2)(z1105e7a757[0],z51eadf1cec.x)
;else z01c61887e6[0]=(ushort2)(z1105e7a757[0],z967de87243.x);if(z3724ae3b8c.y<
z226e55a344&&za3a9f9a4b5.y<z226e55a344)z01c61887e6[z745057f086/2]=(ushort2)(
z51eadf1cec.y,z1105e7a757[z9e3745df27+1]);else z01c61887e6[z745057f086/2]=(
ushort2)(z967de87243.y,z1105e7a757[z9e3745df27+1]);}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
