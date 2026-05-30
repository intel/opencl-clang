
#define zec15f7fa83(zff400e9e97, z305d891f1d, za3158292ce) (zff400e9e97 * 0.299f\
 + z305d891f1d *  0.587f + za3158292ce *  0.114f)
#define MIN min
__kernel void z03df67c650(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,uint z021babbfad,uint z958df11031,float16
z3c211c8179){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;int2
z83640e5796=zba94ee46da+z30eaaf69b7.xy;zba94ee46da+=z30eaaf69b7.xy;float
z06a814d67d=z3c211c8179.s0;float za6bdffcee5=z3c211c8179.s1;float z0c1a1e3a50=
z3c211c8179.s2;float zb9abd16234=z3c211c8179.s3;float z2e28fb73c3=z3c211c8179.s4
;float z9299b1f4d6=z3c211c8179.s5;float ze838ba31a6=z3c211c8179.s6;float
zcf95e3c298=z3c211c8179.s7;float ze91364bca3=z3c211c8179.s8;float z9602e36c3f=
z3c211c8179.s9;float z4b0090a329=z3c211c8179.sa;

float4 z493deefb55=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*(z021babbfad/4)];
#if 1
float ze4b052164b=z493deefb55.x;
float z2e91460297=z493deefb55.y;
float z7e674d442a=z493deefb55.z;
float z93751f94c0=ze4b052164b;float z73c543363e=z2e91460297;float zacde091c32=
z7e674d442a;if(ze4b052164b>z06a814d67d){float zec65e8d581=(ze4b052164b-
z06a814d67d)*(zb9abd16234/z06a814d67d);zec65e8d581*=MIN(z2e91460297,z7e674d442a)
/ze4b052164b;
zec65e8d581=MIN(zec65e8d581,1.f);z93751f94c0=(z2e91460297+z7e674d442a)*0.5f*
zec65e8d581+ze4b052164b*(1.f-zec65e8d581);}if(z2e91460297>za6bdffcee5){float
zec65e8d581=(z2e91460297-za6bdffcee5)*(zb9abd16234/za6bdffcee5);zec65e8d581*=MIN
(ze4b052164b,z7e674d442a)/z2e91460297;
zec65e8d581=MIN(zec65e8d581,1.f);z73c543363e=(ze4b052164b+z7e674d442a)*0.5*
zec65e8d581+z2e91460297*(1.f-zec65e8d581);}if(z7e674d442a>z0c1a1e3a50){float
zec65e8d581=(z7e674d442a-z0c1a1e3a50)*(zb9abd16234/z0c1a1e3a50);zec65e8d581*=MIN
(z2e91460297,ze4b052164b)/z7e674d442a;
zec65e8d581=MIN(zec65e8d581,1.f);zacde091c32=(z2e91460297+ze4b052164b)*0.5*
zec65e8d581+z7e674d442a*(1.f-zec65e8d581);}
if(z93751f94c0>z06a814d67d||z73c543363e>za6bdffcee5||zacde091c32>z0c1a1e3a50){
float z76f2f5d119;z76f2f5d119=(z93751f94c0>z06a814d67d)?(z93751f94c0-z06a814d67d
)*(1.f/z2e28fb73c3):0.f;z76f2f5d119+=(z73c543363e>za6bdffcee5)?(z73c543363e-
za6bdffcee5)*(1.f/z9299b1f4d6):0.f;z76f2f5d119+=(zacde091c32>z0c1a1e3a50)?(
zacde091c32-z0c1a1e3a50)*(1.f/ze838ba31a6):0.f;float z27645b1339=MIN(MIN(
z93751f94c0*zcf95e3c298,z73c543363e*ze91364bca3),zacde091c32*z9602e36c3f)*
z4b0090a329;

z76f2f5d119*=z27645b1339;
z76f2f5d119*=z76f2f5d119;
z76f2f5d119=MIN(1.f,z76f2f5d119);float z5413c0ac97=zec15f7fa83(z93751f94c0,
z73c543363e,zacde091c32);z93751f94c0=z93751f94c0*(1.f-z76f2f5d119)+z5413c0ac97*
z76f2f5d119;z73c543363e=z73c543363e*(1.f-z76f2f5d119)+z5413c0ac97*z76f2f5d119;
zacde091c32=zacde091c32*(1.f-z76f2f5d119)+z5413c0ac97*z76f2f5d119;}
z493deefb55.x=z93751f94c0;z493deefb55.y=z73c543363e;z493deefb55.z=zacde091c32;
#endif
z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z493deefb55;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
