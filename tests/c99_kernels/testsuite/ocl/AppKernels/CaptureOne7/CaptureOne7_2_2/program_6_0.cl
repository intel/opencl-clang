#define zdca52365bc  1
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
z718a062ddd,int4 z30eaaf69b7,uint z021babbfad,uint z958df11031,float4
z510a0f1615){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;int2
z83640e5796=zba94ee46da+z30eaaf69b7.xy;zba94ee46da+=z30eaaf69b7.xy;bool
z16aa2e8ca7=(z510a0f1615.w>0.0f);z510a0f1615.w=1.0f;
float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad/4)];
z493deefb55*=z510a0f1615;
#if zdca52365bc
if(z16aa2e8ca7)z493deefb55=z03aeac13a1(z493deefb55);
#endif
z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z493deefb55;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
