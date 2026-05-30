#define z3dbd1ff682 0
typedef ushort z51b7908a0d;
#define z2aa2c7749d	0.3328
#define z2666327427	0.6121
#define z8ecb59eba0	0.0551
__kernel void zd0ed4a519e(__global ushort4*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int4 z44c248420b,
int4 zeae12e3706){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int2 z83640e5796=zba94ee46da+z30eaaf69b7
.s45;

const int z847f9665cc=z44c248420b.w;int zdfcc7a6581[3]={z44c248420b.x,
z44c248420b.y,z44c248420b.z};int z20a687db73[3]={zeae12e3706.x,zeae12e3706.y,
zeae12e3706.z};ushort4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*
z2824fcf57d];
z51b7908a0d ze4b052164b=z493deefb55.x;
z51b7908a0d z2e91460297=z493deefb55.y;
z51b7908a0d z7e674d442a=z493deefb55.z;
int z6533f4e792[4]={ze4b052164b,z2e91460297,z7e674d442a,0};
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
unsigned zc1315f74d7=(ze4b052164b*(unsigned)(z2aa2c7749d*1024.0)+z2e91460297*(
unsigned)(z2666327427*1024.0)+z7e674d442a*(unsigned)(z8ecb59eba0*1024.0))/1024;
if(z4633c865c6*8<(int)zc1315f74d7){unsigned zbda684ca95=(zc1315f74d7*zc1315f74d7
>>5)*25;unsigned za2a87e6e07=1+((unsigned)(zc1315f74d7*288-z4633c865c6*1024)>>5)
;z4633c865c6=(int)(zbda684ca95/za2a87e6e07)-zc1315f74d7/32;if(z4633c865c6<0)
z4633c865c6=0;}



z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=(ushort4)((unsigned)
z4633c865c6>>z847f9665cc,(unsigned)zc1315f74d7>>z847f9665cc,0,0);}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
