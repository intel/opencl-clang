#define zbc6516e8d5  0
typedef ushort z51b7908a0d;
#define z2aa2c7749d	0.3328f
#define z2666327427	0.6121f
#define z8ecb59eba0	0.0551f
z51b7908a0d zcc6993f31f(z51b7908a0d z88dce4da4d){float x=convert_float(
z88dce4da4d)/65535.0f;float y=65535.0f*pow(x,1.0f/2.2f);
return convert_ushort(y);}__kernel void zfc1c1aa575(__global ushort4*zf8d9fd6cb8
,__global ushort4*z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,
int16 z7c54807ee5,int4 z44c248420b,int4 zeae12e3706,__global ushort*z6a5bee82a4)
{int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 zaaf414d14e=
zba94ee46da+z30eaaf69b7.s01;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;
#if 1
ushort4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];
z51b7908a0d ze4b052164b=z493deefb55.x;
z51b7908a0d z2e91460297=z493deefb55.y;
z51b7908a0d z7e674d442a=z493deefb55.z;
int z6533f4e792[4]={ze4b052164b,z2e91460297,z7e674d442a,0};int zdfcc7a6581[4]={
z44c248420b.x,z44c248420b.y,z44c248420b.z,z44c248420b.w};int z20a687db73[4]={
zeae12e3706.x,zeae12e3706.y,zeae12e3706.z,zeae12e3706.w};int z5b58121f6e=
z7c54807ee5.s0,z0ef4274f3d=z7c54807ee5.s1;int z11c90e648a=z7c54807ee5.s2,
z011a5338eb=z7c54807ee5.s3,z9853417519=z7c54807ee5.s4;int z5c1f59751e=
z7c54807ee5.s5,zddd992721c=z7c54807ee5.s6,zd0ee2dc7c4=z7c54807ee5.s7;int
z309f0ed7e8=z7c54807ee5.s8,zd90ebc9ce4=z7c54807ee5.s9,z2d4ea3f71c=z7c54807ee5.sa
;int z70d96b4d62=z7c54807ee5.sb,z06dcd48fcf=z7c54807ee5.sc,z1adc258756=
z7c54807ee5.sd;bool z037316df7a=z7c54807ee5.se;
int zb61bdb1b25=0,z2d9e5ddcd2=ze4b052164b;if(z2e91460297<z2d9e5ddcd2){
z2d9e5ddcd2=z2e91460297;zb61bdb1b25=1;}if(z7e674d442a<z2d9e5ddcd2){z2d9e5ddcd2=
z7e674d442a;zb61bdb1b25=2;}int z891146990b=2,z397dd5ce09=z7e674d442a;if(
ze4b052164b>z397dd5ce09){z397dd5ce09=ze4b052164b;z891146990b=0;}if(z2e91460297>
z397dd5ce09){z397dd5ce09=z2e91460297;z891146990b=1;}int z7a611221b0=3-(
zb61bdb1b25+z891146990b);int z805dbb88cb=z6533f4e792[z7a611221b0];

int z39650b5679=z2d9e5ddcd2;int z0ea05bb513=z805dbb88cb-z2d9e5ddcd2;int
z4fdc876c61=z397dd5ce09-z805dbb88cb;
int z4633c865c6=z39650b5679+(z0ea05bb513*zdfcc7a6581[zb61bdb1b25]+z4fdc876c61*
z20a687db73[z891146990b])/1024;
unsigned zc1315f74d7=(ze4b052164b*(unsigned)(z2aa2c7749d*1024.0f)+z2e91460297*(
unsigned)(z2666327427*1024.0f)+z7e674d442a*(unsigned)(z8ecb59eba0*1024.0f))/1024
;
if(z4633c865c6*8<(int)zc1315f74d7){unsigned zbda684ca95=(zc1315f74d7*zc1315f74d7
>>5)*25;unsigned za2a87e6e07=1+((unsigned)(zc1315f74d7*288-z4633c865c6*1024)>>5)
;z4633c865c6=(int)(zbda684ca95/za2a87e6e07)-zc1315f74d7/32;if(z4633c865c6<0)
z4633c865c6=0;}unsigned z86b36b953e,zd2940ad387,z36a2642e12;if(z037316df7a){
if(z4633c865c6>262140)z4633c865c6=262140;if(z4633c865c6<z5b58121f6e){
z86b36b953e=(z309f0ed7e8*z4633c865c6)/8192;zd2940ad387=(zd90ebc9ce4*z4633c865c6)
/8192;z36a2642e12=(z2d4ea3f71c*z4633c865c6)/8192;}else if(z4633c865c6>
z0ef4274f3d){
z86b36b953e=(z70d96b4d62*z4633c865c6)/8192;zd2940ad387=(z06dcd48fcf*z4633c865c6)
/8192;z36a2642e12=(z1adc258756*z4633c865c6)/8192;}else{
int z56807b5599=z4633c865c6-z5b58121f6e;int z52ab5b652a=(z0ef4274f3d-z5b58121f6e
)-z56807b5599;z86b36b953e=(z5c1f59751e*z52ab5b652a+z11c90e648a*z56807b5599)/8192
;zd2940ad387=(zddd992721c*z52ab5b652a+z011a5338eb*z56807b5599)/8192;z36a2642e12=
(zd0ee2dc7c4*z52ab5b652a+z9853417519*z56807b5599)/8192;}if(z86b36b953e>65535)
z86b36b953e=65535;if(zd2940ad387>65535)zd2940ad387=65535;if(z36a2642e12>65535)
z36a2642e12=65535;



z86b36b953e=z6a5bee82a4[z86b36b953e];zd2940ad387=z6a5bee82a4[zd2940ad387];
z36a2642e12=z6a5bee82a4[z36a2642e12];}else{
if(z4633c865c6>65535)z4633c865c6=65535;
z4633c865c6=z6a5bee82a4[z4633c865c6];z86b36b953e=z4633c865c6;zd2940ad387=
z4633c865c6;z36a2642e12=z4633c865c6;}



#endif
int z77f8ae3448=zaaf414d14e.x+zaaf414d14e.y*z9562068e13;z718a062ddd[z77f8ae3448]
=(ushort4)(z86b36b953e,zd2940ad387,z36a2642e12,0);}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
