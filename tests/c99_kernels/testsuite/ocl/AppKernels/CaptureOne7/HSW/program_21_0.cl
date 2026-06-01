__kernel void z52276c8188(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,uint z021babbfad,uint z958df11031,float z6df7ccb0a4
,float z8f262ec28f,float zcd11991aeb,float2 z7f10bac07c,float2 z7bcfe1c307,int2
zaaf414d14e){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;int2
z83640e5796=zba94ee46da;


float2 z96f81dcdd2=z6df7ccb0a4*convert_float2(zaaf414d14e+z83640e5796)-
z7f10bac07c;



float2 z5083031dab=z96f81dcdd2*z7bcfe1c307;
float zebdaeff46d=length(z5083031dab);
float z86dd029962;if(zebdaeff46d<z8f262ec28f){float z52ab5b652a=cos(zebdaeff46d)
;z52ab5b652a=z52ab5b652a*z52ab5b652a;z52ab5b652a=z52ab5b652a*z52ab5b652a;if(
zcd11991aeb>0.0f)z52ab5b652a=1.0f/z52ab5b652a;z86dd029962=z52ab5b652a;}else{
if(zcd11991aeb<0.0f)z86dd029962=1.0f/16.0f;else z86dd029962=16.0f;}zba94ee46da+=
z30eaaf69b7.xy;z83640e5796+=z30eaaf69b7.xy;
float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad/4)];



z493deefb55*=z86dd029962;

z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z493deefb55;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
