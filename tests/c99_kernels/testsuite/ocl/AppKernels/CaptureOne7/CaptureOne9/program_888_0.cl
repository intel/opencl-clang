__kernel void ze819ec540d(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,int z021babbfad,int z958df11031,__global float*
zaf2d7b2229,int zb538c8cd88,float z83c650c0f1,float2 x,float2 z44b11b06b9,float2
 z01f61a9fc1,float2 z817fef5f36,float z1cc99a6dfb,float zd95454867f){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.xy;
int2 z83640e5796=zba94ee46da;float4 z9697e8d76f;


z9697e8d76f=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad/4)];z9697e8d76f
.w=0.0f;float4 z0fa7c64251;float z5413c0ac97=zaf2d7b2229[zba94ee46da.x+
zba94ee46da.y*zb538c8cd88];float2 z86dd029962=z44b11b06b9+z01f61a9fc1*
z5413c0ac97+z817fef5f36*(z5413c0ac97*z5413c0ac97);z86dd029962.x=min(z86dd029962.
x,zd95454867f);float z35bf29e99b=x.x;float z2c865879a0=x.y;if(z5413c0ac97>=
z35bf29e99b)z86dd029962.x=1.0f;if(z5413c0ac97>=z2c865879a0)z86dd029962.y=
z1cc99a6dfb;float z84595a1a4c=z86dd029962.x*z86dd029962.y*z83c650c0f1;
if(z84595a1a4c<1.0f){
float4 z34a2a8bed8=(z84595a1a4c*z9697e8d76f);
z34a2a8bed8=clamp(z34a2a8bed8,(float4)0.0f,(float4)65535.0f);
float zdb93fba832=dot(z34a2a8bed8,(float4)(1,1,1,0));



z9697e8d76f=clamp(z9697e8d76f,(float4)0.0f,(float4)65535.0f);

float zd9765ce672=dot(z9697e8d76f,(float4)(1,1,1,0))+0.00001f;
float z5b8c31c8e4=zdb93fba832/zd9765ce672;


z0fa7c64251=z5b8c31c8e4*z9697e8d76f;}else{





z0fa7c64251=z84595a1a4c*z9697e8d76f;}




z0fa7c64251=clamp(z0fa7c64251,(float4)0.0f,(float4)65535.0f);
z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z0fa7c64251;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
