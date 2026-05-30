#define z8b6bce8773 1
#define zbc6516e8d5 0

#ifndef zbc6516e8d5
#define zbc6516e8d5 1
#endif
#define zbf428ecccb float
#define z870da0e49c float4
#define z2eceb88eb2 float2
bool z2eafd010fc(z870da0e49c z6d6e188e03,z870da0e49c z428dac3911){return(
z6d6e188e03.x<z428dac3911.x&&z6d6e188e03.z<z428dac3911.z&&z6d6e188e03.w<
z428dac3911.w);}float4 z159d5c2a6f(float4 z205d564e2f){float4 z73dd7cdafb;
z73dd7cdafb.xz=z205d564e2f.xz-z205d564e2f.yy;
z73dd7cdafb.y=z205d564e2f.y;
z73dd7cdafb.w=dot(z205d564e2f,(float4)(0.299f,0.587f,0.114f,0.0f));return
z73dd7cdafb;}void z8221728b77(__local z870da0e49c*zf485e5e12c,int ze12af1c5cf,
__global z870da0e49c*zf8d9fd6cb8,int zc9d655d235){float4 z73dd7cdafb;
#ifdef z8b6bce8773
z73dd7cdafb=zf8d9fd6cb8[zc9d655d235];
#else
float4 z205d564e2f=zf8d9fd6cb8[zc9d655d235];z73dd7cdafb=z159d5c2a6f(z205d564e2f)
;
#endif
zf485e5e12c[ze12af1c5cf]=z73dd7cdafb;}
#define z6cc1e8bdad(z493deefb55) z493deefb55
#ifndef z8b6bce8773
#if !zbc6516e8d5
#undef z6cc1e8bdad
#define z6cc1e8bdad(z493deefb55) z159d5c2a6f(z493deefb55)
#endif
#endif
__kernel void z7dd414228f(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,uint z021babbfad,uint z958df11031,int z336555f76e,
int zbedd831684,z870da0e49c z428dac3911
#if zbc6516e8d5
,__local float4*z01612e015a
#endif
#ifdef z8b6bce8773
,__global uchar*zec145e35cf,int2 z3576e84f20
#endif
){int2 z945895b462=(int2)(get_global_id(0),get_global_id(1));int2 zba94ee46da=
z945895b462+z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;int ze623780ac4=
z336555f76e;
#ifdef z8b6bce8773
int z47728d2efe=get_local_size(1);int z1569e4557f=get_local_id(0);int
z38a89f6944=get_local_id(1);int zb3ec2e5425=z021babbfad/4;
#else
int z47728d2efe=get_local_size(0);int z1569e4557f=get_local_id(1);int
z38a89f6944=get_local_id(0);int zb3ec2e5425=1;
#endif
int z740d84c71c=(z47728d2efe+2*(ze623780ac4));int zc9d655d235=z83640e5796.x+
z83640e5796.y*(z021babbfad/4);
#if zbc6516e8d5
__local float4*zf485e5e12c=z01612e015a+z1569e4557f*z740d84c71c+(ze623780ac4);if(
z945895b462.x<z30eaaf69b7.s2&&z945895b462.y<z30eaaf69b7.s3){int ze12af1c5cf=
z38a89f6944;z8221728b77(zf485e5e12c,ze12af1c5cf,zf8d9fd6cb8,zc9d655d235);if(
z38a89f6944<=ze623780ac4)z8221728b77(zf485e5e12c,ze12af1c5cf-ze623780ac4,
zf8d9fd6cb8,zc9d655d235-zb3ec2e5425*ze623780ac4);if(z38a89f6944>=z47728d2efe-
ze623780ac4)z8221728b77(zf485e5e12c,ze12af1c5cf+ze623780ac4,zf8d9fd6cb8,
zc9d655d235+zb3ec2e5425*ze623780ac4);}barrier(CLK_LOCAL_MEM_FENCE);zb3ec2e5425=1
;
#else
__global float4*zf485e5e12c=zf8d9fd6cb8+zc9d655d235;z38a89f6944=0;
#endif
if(z945895b462.x>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return;
z870da0e49c z36db46d6df=z6cc1e8bdad(zf485e5e12c[(z38a89f6944)]);
z870da0e49c z3076f7e73f=z36db46d6df+z428dac3911;z870da0e49c z75a804bec7=
z36db46d6df-z428dac3911;
z870da0e49c z6c1fbf0a77={0.0f,0.0f,0.0f,0.0f};
for(int z1d8bd19892=-z336555f76e;z1d8bd19892<=z336555f76e;z1d8bd19892+=
zbedd831684){
z870da0e49c z448a3dde4b=z6cc1e8bdad(zf485e5e12c[(z38a89f6944+z1d8bd19892*
zb3ec2e5425)]);



zbf428ecccb zfc63e3af37=(z2eafd010fc(fabs(z36db46d6df-z448a3dde4b),z428dac3911)?
1.0f:0.0f);z6c1fbf0a77+=zfc63e3af37*(z870da0e49c)(z448a3dde4b.xyz,1.0f);}
z6c1fbf0a77.w=max(1.0f,z6c1fbf0a77.w);z870da0e49c z2f06f3d292=z36db46d6df;float2
 z593fa3cb41=z6c1fbf0a77.xz/z6c1fbf0a77.ww;z2f06f3d292.xz=z593fa3cb41;


#ifdef z8b6bce8773
float4 z205d564e2f;z205d564e2f.y=z2f06f3d292.y;z205d564e2f.xz=z2f06f3d292.xz+
z205d564e2f.yy;int2 z9b046bc3a1=z83640e5796;
int zfcaa177308=z3576e84f20.s0;if(z3576e84f20.s1>=0){uchar za097e3cbf4=
zec145e35cf[z9b046bc3a1.x+z9b046bc3a1.y*zfcaa177308+z3576e84f20.s1];if(
za097e3cbf4>0){float4 zbeb390e590=z718a062ddd[zba94ee46da.x+zba94ee46da.y*(
z958df11031/4)];






float4 z8c24f6307d=z205d564e2f;
const bool zd18679a402=false;if(zd18679a402){


z8c24f6307d*=(float4)(2.0f,0.5f,2.0f,1.0f);}
uchar z88dce4da4d=za097e3cbf4;

float z96ba5d4482=convert_float(z88dce4da4d)*(1.0f/255.0f);float zd30ddce833=
1.0f-z96ba5d4482;


z205d564e2f=zbeb390e590*zd30ddce833+z8c24f6307d*z96ba5d4482;}}z718a062ddd[
zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z205d564e2f;
#else

z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z2f06f3d292;
#endif
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
