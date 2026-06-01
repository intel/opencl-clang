#define z3dbd1ff682 0

#if (z3dbd1ff682==0)
__kernel void zee95a9233c(__global float4*z718a062ddd,__global float4*
zf8d9fd6cb8,int8 z30eaaf69b7,int z9562068e13,int z2824fcf57d,int4 z026bfe707b,
__global uchar*z2fb27c8d6a,int4 z3576e84f20){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));zba94ee46da+=z026bfe707b.xy;if(zba94ee46da.x
>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;if(zba94ee46da.x>=
z026bfe707b.z||zba94ee46da.y>=z026bfe707b.w)return;int2 z83640e5796=zba94ee46da+
z30eaaf69b7.s01;float4 ze4351005bc=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*
z2824fcf57d];int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s45;
float4 z93cee39c44=z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13];int2
z9b046bc3a1=zba94ee46da+z3576e84f20.xy;int zfcaa177308=z3576e84f20.z;int
z98cd6733c3=z9b046bc3a1.x+z9b046bc3a1.y*zfcaa177308;z98cd6733c3+=z3576e84f20.w;
uchar zd2b92ba4f5=z2fb27c8d6a[z98cd6733c3];
float z1fc64dcf1f=ze4351005bc.x;
float zecbdbb7cb9=ze4351005bc.y;
float zd725a7f198=ze4351005bc.z;

float zdcbbd8dac8=z93cee39c44.x;
float z8315075b1c=z93cee39c44.y;
float zf967161892=z93cee39c44.z;

float z88dce4da4d=convert_float(zd2b92ba4f5);

float z96ba5d4482=z88dce4da4d*(1.0f/255.0f);float zd30ddce833=1.0f-z96ba5d4482;
ze4351005bc.x=z1fc64dcf1f*zd30ddce833+zdcbbd8dac8*z96ba5d4482;ze4351005bc.y=
zecbdbb7cb9*zd30ddce833+z8315075b1c*z96ba5d4482;ze4351005bc.z=zd725a7f198*
zd30ddce833+zf967161892*z96ba5d4482;zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*
z2824fcf57d]=ze4351005bc;}
#endif
#if (z3dbd1ff682==1)
__kernel void zee95a9233c(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float8 ze0995e6531)
{int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;float4 z071225e979=zf8d9fd6cb8[z83640e5796.x+
z83640e5796.y*z2824fcf57d];float z447f0a5e7f=ze0995e6531.s0;float zc36f1050d5=
ze0995e6531.s1;float z734efc75b7=ze0995e6531.s2;float z154167adc5=ze0995e6531.s3
;float z22f061b814=ze0995e6531.s4;float z1b190a1f8d=ze0995e6531.s5;float
ze4b052164b=z447f0a5e7f+z154167adc5*z071225e979.x;
float z2e91460297=zc36f1050d5+z22f061b814*z071225e979.y;
float z7e674d442a=z734efc75b7+z1b190a1f8d*z071225e979.z;
if(ze4b052164b<0)ze4b052164b=0;if(z2e91460297<0)z2e91460297=0;if(z7e674d442a<0)
z7e674d442a=0;


zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d]=(float4)(ze4b052164b,
z2e91460297,z7e674d442a,0.0f);}
#endif
#if (z3dbd1ff682==2)
__kernel void zee95a9233c(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int2 zc8bf9b79e6,
float4 ze0995e6531,__global float*z1c882b83a2){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;const int
 x=zba94ee46da.x;const int y=zba94ee46da.y;const int z033bb5ee12=zc8bf9b79e6.s0;
const int zeed0cad714=zc8bf9b79e6.s1;const float z6f92f65ca8=convert_float(
zc8bf9b79e6.s0);const float z949ff0ba7a=convert_float(zc8bf9b79e6.s1);float
zec9a49d132=ze0995e6531.s0;float zf5a4715ee3=ze0995e6531.s1;float z6165ae6f97=
ze0995e6531.s2;float z49ece45ccc=ze0995e6531.s3;
float zce1f5221b4=convert_float(x)*zec9a49d132+z6165ae6f97;float za4bdb0e8d2=
convert_float(y)*zf5a4715ee3+z49ece45ccc;

if(zce1f5221b4<0)zce1f5221b4=0.0f;if(za4bdb0e8d2<0)za4bdb0e8d2=0.0f;if(
zce1f5221b4>=z6f92f65ca8-1.001f)zce1f5221b4=z6f92f65ca8-1.001f;if(za4bdb0e8d2>=
z949ff0ba7a-1.001f)za4bdb0e8d2=z949ff0ba7a-1.001f;
int ze42119811c=convert_int_rtz(zce1f5221b4);int z41ff065880=convert_int_rtz(
za4bdb0e8d2);float z8b626b2823=zce1f5221b4-convert_float(ze42119811c);float
za3b89d13ec=za4bdb0e8d2-convert_float(z41ff065880);float z9789164f71=1.f-
z8b626b2823;float zd0d24a0a66=1.f-za3b89d13ec;int z43b9f3f550=3*z033bb5ee12*
z41ff065880+3*ze42119811c;int z9f8689f3c3=z43b9f3f550+3;int z838d05ac34=
z43b9f3f550+3*z033bb5ee12;int z7f8e0cb7ae=z838d05ac34+3;float z0208401a34=
z1c882b83a2[z43b9f3f550+0]*z9789164f71+z1c882b83a2[z9f8689f3c3+0]*z8b626b2823;
float zef79fabeed=z1c882b83a2[z838d05ac34+0]*z9789164f71+z1c882b83a2[z7f8e0cb7ae
+0]*z8b626b2823;float z154167adc5=z0208401a34*zd0d24a0a66+zef79fabeed*
za3b89d13ec;float z3de0c217fe=z1c882b83a2[z43b9f3f550+1]*z9789164f71+z1c882b83a2
[z9f8689f3c3+1]*z8b626b2823;float z5f868f462b=z1c882b83a2[z838d05ac34+1]*
z9789164f71+z1c882b83a2[z7f8e0cb7ae+1]*z8b626b2823;float z22f061b814=z3de0c217fe
*zd0d24a0a66+z5f868f462b*za3b89d13ec;float z8f43c63f3e=z1c882b83a2[z43b9f3f550+2
]*z9789164f71+z1c882b83a2[z9f8689f3c3+2]*z8b626b2823;float z7f6e2bd811=
z1c882b83a2[z838d05ac34+2]*z9789164f71+z1c882b83a2[z7f8e0cb7ae+2]*z8b626b2823;
float z1b190a1f8d=z8f43c63f3e*zd0d24a0a66+z7f6e2bd811*za3b89d13ec;
const bool z9ec4766d4d=false;if(z9ec4766d4d){z154167adc5=z1c882b83a2[3*
z033bb5ee12*z41ff065880+3*ze42119811c+0];z22f061b814=z1c882b83a2[3*z033bb5ee12*
z41ff065880+3*ze42119811c+1];z1b190a1f8d=z1c882b83a2[3*z033bb5ee12*z41ff065880+3
*ze42119811c+2];}



float4 z51eadf1cec=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];
z51eadf1cec*=(float4)(z154167adc5,z22f061b814,z1b190a1f8d,1.0f);zf8d9fd6cb8[
z83640e5796.x+z83640e5796.y*z2824fcf57d]=z51eadf1cec;}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
