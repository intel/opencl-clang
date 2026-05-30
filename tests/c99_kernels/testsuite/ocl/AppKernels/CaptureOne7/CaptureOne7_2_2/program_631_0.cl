__kernel void z5523e58be8(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,uint z021babbfad,uint z958df11031,int4 z0d2345ac0b,
int4 z810ee6d0d3,float z6df7ccb0a4,__global float4*z97dbb0fc36,float z55c265223f
,float z9a39af7e0e,int zc0d781c351){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));float2 z0223c8cb53=convert_float2((int2)(get_global_id(0),
get_global_id(1)));if(z0223c8cb53.x>=z30eaaf69b7.z||z0223c8cb53.y>=z30eaaf69b7.w
)return;zba94ee46da+=z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;float4
z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad/4)];


float2 z5ab52425f2=z6df7ccb0a4*(convert_float2(z0d2345ac0b.xy)+z0223c8cb53)-
convert_float2(z0d2345ac0b.zw);


float2 zae8d15d292=z5ab52425f2/convert_float2(z810ee6d0d3.zw);


int2 z1d8bd19892=convert_int2(zae8d15d292);



z1d8bd19892=max((int2)(0,0),min(z1d8bd19892,z810ee6d0d3.xy-(int2)(2,2)));



int2 z3e5fa9e507=(int2)(0,1);int4 z026bfe707b=z1d8bd19892.xxxx+z3e5fa9e507.xyxy+
(z1d8bd19892.yyyy+z3e5fa9e507.xxyy)*z810ee6d0d3.xxxx;




float4 w;w.xy=zae8d15d292-convert_float2(z1d8bd19892);w.zw=(float2)(1.0f,1.0f)-w
.xy;




float4 zcf626b3ff6;zcf626b3ff6.x=z97dbb0fc36[z026bfe707b.s0].z;zcf626b3ff6.y=
z97dbb0fc36[z026bfe707b.s1].z;zcf626b3ff6.z=z97dbb0fc36[z026bfe707b.s2].z;
zcf626b3ff6.w=z97dbb0fc36[z026bfe707b.s3].z;

float2 zf793de71f2=z5ab52425f2-convert_float2(z1d8bd19892*z810ee6d0d3.zw);float4
 za63bc82156=(float4)(zf793de71f2,(zf793de71f2-convert_float2(z810ee6d0d3.zw)));







float4 ze6f307796f=(float4)(z97dbb0fc36[z026bfe707b.s0].x,z97dbb0fc36[
z026bfe707b.s1].x,z97dbb0fc36[z026bfe707b.s2].x,z97dbb0fc36[z026bfe707b.s3].x)*
za63bc82156.xzxz;float4 zae83d44a37=(float4)(z97dbb0fc36[z026bfe707b.s0].y,
z97dbb0fc36[z026bfe707b.s1].y,z97dbb0fc36[z026bfe707b.s2].y,z97dbb0fc36[
z026bfe707b.s3].y)*za63bc82156.yyww;


float2 z90e1a42944=1.0f/convert_float2(z810ee6d0d3.zw);




zcf626b3ff6+=ze6f307796f*z90e1a42944.x+zae83d44a37*z90e1a42944.y;













float4 za85ea87383=zcf626b3ff6*w.wwyy;float2 zc97c98155f=za85ea87383.s01+
za85ea87383.s23;
float ze83efc3a4d=dot(w.zx,zc97c98155f);
ze83efc3a4d=ze83efc3a4d*(1.0f/8192.0f);
float z833bd266ce=(z9a39af7e0e-ze83efc3a4d)*z55c265223f;if(z833bd266ce>3.0f){if(
zc0d781c351){
if(z833bd266ce>5.0f){z833bd266ce=4.0f;}else{float z52ab5b652a=z833bd266ce-3.0f;
z833bd266ce=z833bd266ce-0.25f*z52ab5b652a*z52ab5b652a;}}else{
z833bd266ce=3.0f;}}
float z86dd029962=exp(0.69314718055994530942f*z833bd266ce);z493deefb55*=
z86dd029962;z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z493deefb55
;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
