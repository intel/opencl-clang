
__kernel void zf94a20ad81(__global ushort2*zf8d9fd6cb8,__global ushort*
z718a062ddd,int4 z30eaaf69b7,uint z58c1e26fb1,uint z745057f086,int za3584c0652,
float z84a1e6ab82,__constant short8*z14a03878d2,int z4f40d28469){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;short8 z635b0b1840=
z14a03878d2[2*zba94ee46da.x+z4f40d28469];zba94ee46da+=z30eaaf69b7.xy;zba94ee46da
.x=z635b0b1840.s6;int2 z83640e5796=zba94ee46da;int z3b23994384=z83640e5796.x/2+
z83640e5796.y*z58c1e26fb1;float2 z493deefb55=convert_float2(zf8d9fd6cb8[
z3b23994384]);float4 ze7168fc0b9;if((zba94ee46da.y&1))ze7168fc0b9=convert_float4
(z635b0b1840.s3457);else ze7168fc0b9=convert_float4(z635b0b1840.s0127);
ze7168fc0b9/=(float4)16384.0f;float z8d007bcae6=(z83640e5796.y-za3584c0652)*
z84a1e6ab82;float z2f9b04fc4f=1.0f-z8d007bcae6;float z778c582bcd=z8d007bcae6*
z2f9b04fc4f*4.0f;float z305d891f1d=1.0f+z8d007bcae6*ze7168fc0b9.s0+z2f9b04fc4f*
ze7168fc0b9.s1+z778c582bcd*ze7168fc0b9.s2;if(z83640e5796.x&1)z493deefb55.y*=
z305d891f1d;else z493deefb55.x*=z305d891f1d;zf8d9fd6cb8[z3b23994384]=
convert_ushort2_sat(z493deefb55);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
