#define zbc6516e8d5 0

#ifndef zbc6516e8d5
#define zbc6516e8d5 1
#endif
#if zbc6516e8d5
#define z633bdc4c82 __local float4
#else
#define z633bdc4c82 __global float4
#endif

inline int z468ddbc850(float zc180b9cdc9,float z35bf29e99b,float z2c865879a0,
float z6624dbc6f0,float zd649de2ebe,float zf81de5afde,float z2d7aa8b761,float
zf32497f338){float z7edad8b3b7=zc180b9cdc9;
int z1d8bd19892=0;
if(z35bf29e99b<z7edad8b3b7){z7edad8b3b7=z35bf29e99b;z1d8bd19892=1;}if(
z2c865879a0<z7edad8b3b7){z7edad8b3b7=z2c865879a0;z1d8bd19892=2;}if(z6624dbc6f0<
z7edad8b3b7){z7edad8b3b7=z6624dbc6f0;z1d8bd19892=3;}if(zd649de2ebe<z7edad8b3b7){
z7edad8b3b7=zd649de2ebe;z1d8bd19892=4;}if(zf81de5afde<z7edad8b3b7){z7edad8b3b7=
zf81de5afde;z1d8bd19892=5;}if(z2d7aa8b761<z7edad8b3b7){z7edad8b3b7=z2d7aa8b761;
z1d8bd19892=6;}if(zf32497f338<z7edad8b3b7){z1d8bd19892=7;}return z1d8bd19892;}
float zbac28489bf(z633bdc4c82*zf8d9fd6cb8,int zbced03a0bf){float z88fa33d26d=(
zf8d9fd6cb8[-zbced03a0bf].y);float z5083031dab=(zf8d9fd6cb8[zbced03a0bf].y);
float ze384962f2b=(zf8d9fd6cb8[1].y);float w=(zf8d9fd6cb8[-1].y);float
z7c83382301=(zf8d9fd6cb8[-zbced03a0bf-1].y);float z2495fb4eee=(zf8d9fd6cb8[-
zbced03a0bf+1].y);float z46d4ed32bc=(zf8d9fd6cb8[zbced03a0bf-1].y);float
z88370fd9e8=(zf8d9fd6cb8[zbced03a0bf+1].y);float4 zea34483265=(float4)(
z88fa33d26d,w,z7c83382301,z2495fb4eee);float4 z38c36eec91=convert_float(
zf8d9fd6cb8[0].y);
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
#define z57f8d3ba0a(z493deefb55, ze28128c2dd) (ze28128c2dd<0 ? z493deefb55.x : \
z493deefb55.z)
float zbfabcb1781(z633bdc4c82*zf8d9fd6cb8,int zbced03a0bf,int z8e54004f94){float
 z96a2929ccd=0.0f;int z6d30cd5dec=zbced03a0bf+zbced03a0bf;float4 z9697e8d76f=
zf8d9fd6cb8[0];float z309a2a3e3f=z9697e8d76f.y;
float zf9c08fffd8=z57f8d3ba0a(z9697e8d76f,z8e54004f94);float z0a46e115e3,
zc2c5772781,z353c959062,z131c211e99;
float z4e0a7bfe9f[8];
float zb814869a21=(zf8d9fd6cb8[-zbced03a0bf].y);float z45a66c22e9=(zf8d9fd6cb8[
zbced03a0bf].y);float z18196d1954=(zf8d9fd6cb8[1].y);float z27ef23bf23=(
zf8d9fd6cb8[-1].y);float z45105e84b1=(zf8d9fd6cb8[-z6d30cd5dec-1].y);float
z8231789b88=(zf8d9fd6cb8[-z6d30cd5dec+1].y);float zb94ecaa51d=(zf8d9fd6cb8[
z6d30cd5dec-1].y);float z6bd8d3aad2=(zf8d9fd6cb8[z6d30cd5dec+1].y);float
z259943a429=(zf8d9fd6cb8[zbced03a0bf+2].y);float z918bb3a157=(zf8d9fd6cb8[
zbced03a0bf-2].y);float z5c5e89e9a5=(zf8d9fd6cb8[-zbced03a0bf-2].y);float
zf59885dae9=(zf8d9fd6cb8[-zbced03a0bf+2].y);float4 z105f9ec709=zf8d9fd6cb8[-
zbced03a0bf-1];float4 za1f05c5e24=zf8d9fd6cb8[-zbced03a0bf+1];float4 z543620ea9e
=zf8d9fd6cb8[zbced03a0bf-1];float4 zdc70b86b39=zf8d9fd6cb8[zbced03a0bf+1];float
z491efe2f4b=z105f9ec709.y;float z3913b3943a=za1f05c5e24.y;float z5249ee8f4a=
z543620ea9e.y;float z1b0ee0eb9c=zdc70b86b39.y;float z4f219a5b8b=z57f8d3ba0a(
z105f9ec709,-z8e54004f94);float z74f7346062=z57f8d3ba0a(za1f05c5e24,-z8e54004f94
);float z0dddc839fe=z57f8d3ba0a(z543620ea9e,-z8e54004f94);float zd75dd63979=
z57f8d3ba0a(zdc70b86b39,-z8e54004f94);float4 z6318bc09c5=zf8d9fd6cb8[-
z6d30cd5dec-2];float4 ze170652acd=zf8d9fd6cb8[-z6d30cd5dec+2];float4 z4bc171496b
=zf8d9fd6cb8[z6d30cd5dec-2];float4 zac005d64da=zf8d9fd6cb8[z6d30cd5dec+2];float
z74ab0cb826=z57f8d3ba0a(z6318bc09c5,z8e54004f94);float z543a5f0595=z57f8d3ba0a(
ze170652acd,z8e54004f94);float z6c1fe7b17f=z57f8d3ba0a(z4bc171496b,z8e54004f94);
float z557ef84e08=z57f8d3ba0a(zac005d64da,z8e54004f94);
z4e0a7bfe9f[0]=(zb814869a21+z309a2a3e3f+z45a66c22e9)*(1.f/3.f);z0a46e115e3=fabs(
zb814869a21-z309a2a3e3f)+fabs(z45a66c22e9-z309a2a3e3f);z4e0a7bfe9f[1]=(
z27ef23bf23+z309a2a3e3f+z18196d1954)*(1.f/3.f);zc2c5772781=fabs(z27ef23bf23-
z309a2a3e3f)+fabs(z18196d1954-z309a2a3e3f);
z4e0a7bfe9f[2]=(z3913b3943a+2.f*z309a2a3e3f+z5249ee8f4a)*0.25f;z353c959062=fabs(
z543a5f0595-zf9c08fffd8)+fabs(z6c1fe7b17f-zf9c08fffd8)
+fabs(z0dddc839fe-z74f7346062)
+fabs(zb814869a21-z27ef23bf23)+fabs(z45a66c22e9-z18196d1954);
z4e0a7bfe9f[3]=(z491efe2f4b+2.f*z309a2a3e3f+z1b0ee0eb9c)*0.25f;z131c211e99=fabs(
z74ab0cb826-zf9c08fffd8)+fabs(z557ef84e08-zf9c08fffd8)
+fabs(z4f219a5b8b-zd75dd63979)
+fabs(zb814869a21-z18196d1954)+fabs(z45a66c22e9-z27ef23bf23);

float z702e9c26b6,z7b5240a423,z9b1902c67e,z0145c1097a;
z4e0a7bfe9f[4]=(zb94ecaa51d+z309a2a3e3f+z8231789b88)*0.3333333f;z702e9c26b6=fabs
(zb94ecaa51d-z309a2a3e3f)+fabs(z8231789b88-z309a2a3e3f)
+fabs(zb814869a21-z5249ee8f4a)
+fabs(z45a66c22e9-z3913b3943a);
z4e0a7bfe9f[5]=(z918bb3a157+z309a2a3e3f+zf59885dae9)*0.3333333f;z7b5240a423=fabs
(z918bb3a157-z309a2a3e3f)+fabs(zf59885dae9-z309a2a3e3f)
+fabs(z27ef23bf23-z3913b3943a)
+fabs(z18196d1954-z5249ee8f4a);
z4e0a7bfe9f[6]=(z45105e84b1+z309a2a3e3f+z6bd8d3aad2)*0.3333333f;z0145c1097a=fabs
(z45105e84b1-z309a2a3e3f)+fabs(z6bd8d3aad2-z309a2a3e3f)
+fabs(z45a66c22e9-z491efe2f4b)
+fabs(zb814869a21-z1b0ee0eb9c);
z4e0a7bfe9f[7]=(z5c5e89e9a5+z309a2a3e3f+z259943a429)*0.3333333f;z9b1902c67e=fabs
(z5c5e89e9a5-z309a2a3e3f)+fabs(z259943a429-z309a2a3e3f)
+fabs(z18196d1954-z491efe2f4b)
+fabs(z27ef23bf23-z1b0ee0eb9c);

int z7abd6531b3=(z0a46e115e3<zc2c5772781)?0:1;int zee9619014d=z468ddbc850(
z0a46e115e3,zc2c5772781,z353c959062,z131c211e99,z702e9c26b6,z7b5240a423,
z0145c1097a,z9b1902c67e);if(zee9619014d<2)
{z96a2929ccd=z309a2a3e3f;
}else
{z96a2929ccd=(z4e0a7bfe9f[zee9619014d]+z4e0a7bfe9f[z7abd6531b3])*0.5f;
}return z96a2929ccd;}
#define z73a6d0c759 2
__kernel void z13bff1d853(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,uint z021babbfad,uint z958df11031
#if zbc6516e8d5
,__local float4*zf485e5e12c
#endif
){int2 z945895b462=(int2)(2*get_global_id(0),get_global_id(1));int2 zba94ee46da=
z945895b462+z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;int z796a73b2c0=
z021babbfad/4;
#if zbc6516e8d5
int z6e29e29e19=2*get_local_size(0)+2*z73a6d0c759;__local float4*zb5c34da6f7=
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
__global float4*zb5c34da6f7=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z796a73b2c0;
#endif
if(z945895b462.x>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return;int
zcdf189b12e=zba94ee46da.x+zba94ee46da.y*z958df11031/4;int zbdf9ccc6ff=0;if(
z945895b462.y&1)
zbdf9ccc6ff=1;float4 z53cdc3ccd8=(zb5c34da6f7[zbdf9ccc6ff]);float4 zd835bc29db=(
zb5c34da6f7[1-zbdf9ccc6ff]);z718a062ddd[zcdf189b12e+1-zbdf9ccc6ff]=(float4)(0.0f
,zd835bc29db.y,0.0f,0.0f);if(z945895b462.y&1)
{z53cdc3ccd8.x=0.0f;
}else z53cdc3ccd8.z=0.0f;

int z8e54004f94=zbdf9ccc6ff*2-1;z53cdc3ccd8.y=zbfabcb1781(zb5c34da6f7+
zbdf9ccc6ff,z796a73b2c0,z8e54004f94);

z718a062ddd[zcdf189b12e+zbdf9ccc6ff]=z53cdc3ccd8;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
