#define zdca52365bc  0
float4 z03aeac13a1(float4 z493deefb55){if(z493deefb55.x>=65535.0f||z493deefb55.y
>=65535.0f||z493deefb55.z>=65535.0f){
float z06f2e71fdd=z493deefb55.x;float zac51b39fd1=z493deefb55.y;float
z84b5b281c7=z493deefb55.z;if(z06f2e71fdd>65535.0f)z06f2e71fdd=65535.0f;if(
zac51b39fd1>65535.0f)zac51b39fd1=65535.0f;if(z84b5b281c7>65535.0f)z84b5b281c7=
65535.0f;
float z90e1a42944=(z493deefb55.x+z493deefb55.y+z493deefb55.z)/(z06f2e71fdd+
zac51b39fd1+z84b5b281c7);z493deefb55.x=z06f2e71fdd*z90e1a42944;z493deefb55.y=
zac51b39fd1*z90e1a42944;z493deefb55.z=z84b5b281c7*z90e1a42944;}return
z493deefb55;}
#ifndef zdca52365bc
#define zdca52365bc 0
#endif
__kernel void z894da16246(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13
#if (zdca52365bc == 0)
,__global uchar*zec145e35cf,int4 z3576e84f20,int z7f76fb323c,float4 z91974ef09f,
int z12603651a6,int zf7fa99786b
#endif
){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 zaaf414d14e=
zba94ee46da+z30eaaf69b7.s01;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;
float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];
#if (zdca52365bc == 0)
int2 z9b046bc3a1=zba94ee46da+z3576e84f20.s01;int zfcaa177308=z3576e84f20.s2;int
z98cd6733c3=z9b046bc3a1.x+z9b046bc3a1.y*zfcaa177308;
uchar zbd7b15dc4f=zec145e35cf[z98cd6733c3+z7f76fb323c];float4 zdf7b4567e6=(
float4)0.0f;if(z12603651a6!=1)zdf7b4567e6=z718a062ddd[zaaf414d14e.x+zaaf414d14e.
y*z9562068e13];





if(zbd7b15dc4f>0){







float w=convert_float(zbd7b15dc4f)*(1.f/255.f);float4 ze4568915c4=(float4)(w*w);
ze4568915c4.w=0.0f;



zdf7b4567e6+=z91974ef09f*ze4568915c4+((float4)w-ze4568915c4);}if(zf7fa99786b){
float z22dadf6692=zdf7b4567e6.w;if(z22dadf6692<0.01f){



zdf7b4567e6=(float4)1.0f;
}else{
z22dadf6692=1.f/z22dadf6692;


zdf7b4567e6=z22dadf6692*zdf7b4567e6;}z493deefb55*=zdf7b4567e6;}else z493deefb55=
zdf7b4567e6;
#endif
#if zdca52365bc
z493deefb55=z03aeac13a1(z493deefb55);
#endif
z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=z493deefb55;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
