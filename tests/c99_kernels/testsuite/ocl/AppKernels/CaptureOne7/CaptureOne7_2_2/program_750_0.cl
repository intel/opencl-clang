__kernel void zca545b8b04(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,uint z021babbfad,uint z958df11031,float z83c650c0f1
){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.xy;
int2 z83640e5796=zba94ee46da;
float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad/4)];
if(z83c650c0f1<1.0f){
float4 z559f74432b=z493deefb55*z83c650c0f1;
float zdb93fba832=z559f74432b.x+z559f74432b.y+z559f74432b.z;
z493deefb55=clamp(z493deefb55,(float4)0.0f,(float4)65535.0f);
float zd9765ce672=z493deefb55.x+z493deefb55.y+z493deefb55.z+0.0001f;
float z5b8c31c8e4=zdb93fba832/zd9765ce672;z493deefb55*=z5b8c31c8e4;}else{
z493deefb55*=z83c650c0f1;z493deefb55=clamp(z493deefb55,(float4)0.0f,(float4)
65535.0f);}z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z493deefb55;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
