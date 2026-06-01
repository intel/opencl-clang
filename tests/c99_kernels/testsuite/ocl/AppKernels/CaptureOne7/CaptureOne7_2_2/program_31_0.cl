#define zbc6516e8d5 0

#ifndef zbc6516e8d5
#define zbc6516e8d5 0
#endif
__kernel void zcdd5e46969(__global ushort*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int4 z30eaaf69b7,uint z58c1e26fb1,uint z745057f086
#if zbc6516e8d5
,__local ushort*z01612e015a
#endif
){int2 z945895b462=(int2)(2*get_global_id(0),get_global_id(1));int2 zba94ee46da=
z945895b462+z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;
#if zbc6516e8d5
int zeb7d0dc4d6=get_local_size(0);int z99db0f6e4c=get_local_size(1);int
z182e74dd31=2*zeb7d0dc4d6+4+4;
__local ushort*zf485e5e12c=z01612e015a+4+4*z182e74dd31;int za4829e5199=2*
get_local_id(0);int zcf71a4cbd5=get_local_id(1);int z3b23994384=z83640e5796.x+
z83640e5796.y*z58c1e26fb1;if(z945895b462.x<z30eaaf69b7.s2&&z945895b462.y<
z30eaaf69b7.s3){int ze12af1c5cf=za4829e5199+zcf71a4cbd5*z182e74dd31;zf485e5e12c[
ze12af1c5cf]=zf8d9fd6cb8[z3b23994384];zf485e5e12c[1+ze12af1c5cf]=zf8d9fd6cb8[1+
z3b23994384];if(za4829e5199<4){zf485e5e12c[ze12af1c5cf-4]=zf8d9fd6cb8[
z3b23994384-4];zf485e5e12c[ze12af1c5cf-3]=zf8d9fd6cb8[z3b23994384-3];}if(
zcf71a4cbd5<4){zf485e5e12c[ze12af1c5cf-4*z182e74dd31]=zf8d9fd6cb8[z3b23994384-4*
z58c1e26fb1];zf485e5e12c[1+ze12af1c5cf-4*z182e74dd31]=zf8d9fd6cb8[1+z3b23994384-
4*z58c1e26fb1];}if(za4829e5199>=2*zeb7d0dc4d6-4){zf485e5e12c[4+ze12af1c5cf]=
zf8d9fd6cb8[4+z3b23994384];zf485e5e12c[5+ze12af1c5cf]=zf8d9fd6cb8[5+z3b23994384]
;}if(zcf71a4cbd5>=z99db0f6e4c-4){zf485e5e12c[ze12af1c5cf+4*z182e74dd31]=
zf8d9fd6cb8[z3b23994384+4*z58c1e26fb1];zf485e5e12c[1+ze12af1c5cf+4*z182e74dd31]=
zf8d9fd6cb8[1+z3b23994384+4*z58c1e26fb1];}if(zcf71a4cbd5==4&&za4829e5199==4){int
 z99cb003774=z83640e5796.x-za4829e5199-1+(z83640e5796.y-zcf71a4cbd5-1)*
z58c1e26fb1;int zf4b326cdcd=-1-z182e74dd31;zf485e5e12c[zf4b326cdcd]=zf8d9fd6cb8[
z99cb003774];zf485e5e12c[-1+zf4b326cdcd]=zf8d9fd6cb8[-1+z99cb003774];zf485e5e12c
[-2+zf4b326cdcd]=zf8d9fd6cb8[-2+z99cb003774];zf485e5e12c[zf4b326cdcd-z182e74dd31
]=zf8d9fd6cb8[z99cb003774-z58c1e26fb1];zf485e5e12c[zf4b326cdcd-2*z182e74dd31]=
zf8d9fd6cb8[z99cb003774-2*z58c1e26fb1];}if(zcf71a4cbd5==5&&za4829e5199==4){int
z99cb003774=z83640e5796.x-za4829e5199-1+(z83640e5796.y-zcf71a4cbd5+z99db0f6e4c)*
z58c1e26fb1;int zf4b326cdcd=-1+z99db0f6e4c*z182e74dd31;zf485e5e12c[zf4b326cdcd]=
zf8d9fd6cb8[z99cb003774];zf485e5e12c[-1+zf4b326cdcd]=zf8d9fd6cb8[-1+z99cb003774]
;zf485e5e12c[-2+zf4b326cdcd]=zf8d9fd6cb8[-2+z99cb003774];zf485e5e12c[zf4b326cdcd
+z182e74dd31]=zf8d9fd6cb8[z99cb003774+z58c1e26fb1];zf485e5e12c[zf4b326cdcd+2*
z182e74dd31]=zf8d9fd6cb8[z99cb003774+2*z58c1e26fb1];}if(zcf71a4cbd5==4&&
za4829e5199==5){int z99cb003774=z83640e5796.x-za4829e5199+2*zeb7d0dc4d6+(
z83640e5796.y-zcf71a4cbd5-1)*z58c1e26fb1;int zf4b326cdcd=2*zeb7d0dc4d6-
z182e74dd31;zf485e5e12c[zf4b326cdcd]=zf8d9fd6cb8[z99cb003774];zf485e5e12c[1+
zf4b326cdcd]=zf8d9fd6cb8[1+z99cb003774];zf485e5e12c[2+zf4b326cdcd]=zf8d9fd6cb8[2
+z99cb003774];zf485e5e12c[zf4b326cdcd-z182e74dd31]=zf8d9fd6cb8[z99cb003774-
z58c1e26fb1];zf485e5e12c[zf4b326cdcd-2*z182e74dd31]=zf8d9fd6cb8[z99cb003774-2*
z58c1e26fb1];}if(zcf71a4cbd5==5&&za4829e5199==5){int z99cb003774=z83640e5796.x-
za4829e5199+2*zeb7d0dc4d6+(z83640e5796.y-zcf71a4cbd5+z99db0f6e4c)*z58c1e26fb1;
int zf4b326cdcd=2*zeb7d0dc4d6+z99db0f6e4c*z182e74dd31;zf485e5e12c[zf4b326cdcd]=
zf8d9fd6cb8[z99cb003774];zf485e5e12c[1+zf4b326cdcd]=zf8d9fd6cb8[1+z99cb003774];
zf485e5e12c[2+zf4b326cdcd]=zf8d9fd6cb8[2+z99cb003774];zf485e5e12c[zf4b326cdcd+
z182e74dd31]=zf8d9fd6cb8[z99cb003774+z58c1e26fb1];zf485e5e12c[zf4b326cdcd+2*
z182e74dd31]=zf8d9fd6cb8[z99cb003774+2*z58c1e26fb1];}}barrier(
CLK_LOCAL_MEM_FENCE);__local ushort*z395b96baac=zf485e5e12c+za4829e5199+
zcf71a4cbd5*z182e74dd31;const int z4fdcfcf0e9=-z182e74dd31;const int z4c70486185
=1;const int z6eebed00b3=-2*z182e74dd31;const int z756232d8e6=2;const int
ze261664410=-3*z182e74dd31;const int z70247fd350=3;const int z6c007decc5=-4*
z182e74dd31;const int zd14c739350=4;
#else
__global ushort*z395b96baac=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z58c1e26fb1;
const int z4fdcfcf0e9=-z58c1e26fb1;const int z4c70486185=1;const int z6eebed00b3
=-2*z58c1e26fb1;const int z756232d8e6=2;const int ze261664410=-3*z58c1e26fb1;
const int z70247fd350=3;const int z6c007decc5=-4*z58c1e26fb1;const int
zd14c739350=4;
#endif
if(z945895b462.x>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return;if(
z945895b462.y&1)
{z395b96baac+=1;}float4 zb250392d35=(float4)(convert_float(z395b96baac[0]));
ushort zb42dc7d1d8=z395b96baac[z4fdcfcf0e9];ushort zc4f0bd30e7=z395b96baac[
z6eebed00b3];ushort zbfae3a4191=z395b96baac[ze261664410];ushort z0904071eca=
z395b96baac[z6c007decc5];ushort z6fceb3ae45=z395b96baac[-z4fdcfcf0e9];ushort s2=
z395b96baac[-z6eebed00b3];ushort s3=z395b96baac[-ze261664410];ushort z89f3550198
=z395b96baac[-z6c007decc5];ushort z4f14030443=z395b96baac[z4c70486185];ushort
zddff1ed921=z395b96baac[z756232d8e6];ushort z7b24ad1307=z395b96baac[z70247fd350]
;ushort z09b108e425=z395b96baac[zd14c739350];ushort zea34483265=z395b96baac[-
z4c70486185];ushort z38c36eec91=z395b96baac[-z756232d8e6];ushort z8a30e7e6ed=
z395b96baac[-z70247fd350];ushort z2c63fce056=z395b96baac[-zd14c739350];ushort
z992974abbd=z395b96baac[-z4c70486185+z4fdcfcf0e9];ushort z184f71d66b=z395b96baac
[-z756232d8e6+z4fdcfcf0e9];ushort z6546588baa=z395b96baac[-z70247fd350+
z4fdcfcf0e9];ushort zc5460b9b60=z395b96baac[z4c70486185+z4fdcfcf0e9];ushort
ze48da66521=z395b96baac[z756232d8e6+z4fdcfcf0e9];ushort z49e4e28fce=z395b96baac[
z70247fd350+z4fdcfcf0e9];ushort zeb17c7a5f4=z395b96baac[-z4c70486185-z4fdcfcf0e9
];ushort z8e9f2c9a90=z395b96baac[-z756232d8e6-z4fdcfcf0e9];ushort zc4b269ad69=
z395b96baac[-z70247fd350-z4fdcfcf0e9];ushort zbc54e5fb6b=z395b96baac[z4c70486185
-z4fdcfcf0e9];ushort z8fa0170868=z395b96baac[z756232d8e6-z4fdcfcf0e9];ushort
ze1f393383c=z395b96baac[z70247fd350-z4fdcfcf0e9];ushort zdcca5f63c5=z395b96baac[
z4c70486185+z6eebed00b3];ushort z5e8a31c8a4=z395b96baac[-z4c70486185+z6eebed00b3
];ushort z0da45f9156=z395b96baac[z4c70486185-z6eebed00b3];ushort z60aa00702d=
z395b96baac[-z4c70486185-z6eebed00b3];ushort z31aa5c6d8b=z395b96baac[z4c70486185
+ze261664410];ushort zdbf3456de3=z395b96baac[-z4c70486185+ze261664410];ushort
z9a2789133e=z395b96baac[z4c70486185-ze261664410];ushort z06839ca3f4=z395b96baac[
-z4c70486185-ze261664410];float4 zbe9d9adc76=convert_float4((ushort4)(
zc4f0bd30e7,z38c36eec91,zddff1ed921,s2));float4 z02b92e6e20=convert_float4((
ushort4)(z0904071eca,z2c63fce056,z09b108e425,z89f3550198));float4 zfc397c3985=
convert_float4((ushort4)(z6fceb3ae45,z4f14030443,zea34483265,zb42dc7d1d8));
float4 zef38832825=convert_float4((ushort4)(zb42dc7d1d8,zea34483265,z4f14030443,
z6fceb3ae45));float4 zf7ee99daeb=convert_float4((ushort4)(zbfae3a4191,
z8a30e7e6ed,z7b24ad1307,s3));float4 z62d43e0dd0=convert_float4((ushort4)(
z992974abbd,z992974abbd,zc5460b9b60,zeb17c7a5f4));float4 z00ad023000=
convert_float4((ushort4)(zdbf3456de3,z6546588baa,z49e4e28fce,z06839ca3f4));
float4 z765fe32f43=convert_float4((ushort4)(zea34483265,zb42dc7d1d8,zb42dc7d1d8,
zea34483265));float4 z718b57d262=convert_float4((ushort4)(z5e8a31c8a4,
z184f71d66b,ze48da66521,z60aa00702d));float4 z92cf6e9a77=convert_float4((ushort4
)(zc5460b9b60,zeb17c7a5f4,zbc54e5fb6b,zbc54e5fb6b));float4 z8afb5019f8=
convert_float4((ushort4)(z31aa5c6d8b,zc4b269ad69,ze1f393383c,z9a2789133e));
float4 za53a6ca38d=convert_float4((ushort4)(z4f14030443,z6fceb3ae45,z6fceb3ae45,
z4f14030443));float4 z4af04adc6e=convert_float4((ushort4)(zdcca5f63c5,
z8e9f2c9a90,z8fa0170868,z0da45f9156));
float4 z8b1e2c48e3=(zb250392d35+zbe9d9adc76+z02b92e6e20)*0.3333f;
float4 z452c312fe6=(z62d43e0dd0+z00ad023000)*0.5f;
float4 z79e515beb2=(z92cf6e9a77+z8afb5019f8)*0.5f;

float4 z47d9dcfc3f=(zfc397c3985+zef38832825+zf7ee99daeb)*0.3333f;
float4 zcf7831d500=(z765fe32f43+z718b57d262)*0.5f;
float4 z4580c9eca2=(za53a6ca38d+z4af04adc6e)*0.5f;

float4 zeb52ec0999=fabs(z8b1e2c48e3-zb250392d35)+fabs(z8b1e2c48e3-zbe9d9adc76)+
fabs(z8b1e2c48e3-z02b92e6e20);zeb52ec0999/=z8b1e2c48e3;
float4 za4a1f0b780=fabs(z47d9dcfc3f-zfc397c3985)+fabs(z47d9dcfc3f-zef38832825)+
fabs(z47d9dcfc3f-zf7ee99daeb);za4a1f0b780/=z47d9dcfc3f;float4 z99d0d41bb2=fabs(
z452c312fe6-z62d43e0dd0)+fabs(z452c312fe6-z00ad023000);z99d0d41bb2/=z452c312fe6;
float4 z38671e31d3=fabs(z79e515beb2-z92cf6e9a77)+fabs(z79e515beb2-z8afb5019f8);
z38671e31d3/=z79e515beb2;float4 z7f8187b708=fabs(zcf7831d500-z765fe32f43)+fabs(
zcf7831d500-z718b57d262);z7f8187b708/=zcf7831d500;float4 z0891757818=fabs(
z4580c9eca2-za53a6ca38d)+fabs(z4580c9eca2-z4af04adc6e);z0891757818/=z4580c9eca2;
float4 zbfa585fbec=
(zeb52ec0999+z99d0d41bb2+z38671e31d3)+(za4a1f0b780+z7f8187b708+z0891757818);
float zf18f143a6d[4]={zbfa585fbec.x,zbfa585fbec.y,zbfa585fbec.z,zbfa585fbec.w};
int z950bbd3d8e=0;if(zf18f143a6d[1]<zf18f143a6d[z950bbd3d8e])z950bbd3d8e=1;if(
zf18f143a6d[2]<zf18f143a6d[z950bbd3d8e])z950bbd3d8e=2;if(zf18f143a6d[3]<
zf18f143a6d[z950bbd3d8e])z950bbd3d8e=3;int zbf1bcb5911=1;if(zf18f143a6d[
zbf1bcb5911]<=zf18f143a6d[z950bbd3d8e])zbf1bcb5911=0;if(zf18f143a6d[0]<
zf18f143a6d[zbf1bcb5911]&&0!=z950bbd3d8e)zbf1bcb5911=0;if(zf18f143a6d[1]<
zf18f143a6d[zbf1bcb5911]&&1!=z950bbd3d8e)zbf1bcb5911=1;if(zf18f143a6d[2]<
zf18f143a6d[zbf1bcb5911]&&2!=z950bbd3d8e)zbf1bcb5911=2;if(zf18f143a6d[3]<
zf18f143a6d[zbf1bcb5911]&&3!=z950bbd3d8e)zbf1bcb5911=3;float4 z34b048a503=
zb250392d35+zbe9d9adc76+(z02b92e6e20*0.5f);
float4 zd3f49919e3=(zfc397c3985*0.5f)+zef38832825+zf7ee99daeb;float4 z5bbf82a92b
=zd3f49919e3/z34b048a503*zb250392d35;float zc9fb84cd12[4]={z5bbf82a92b.x,
z5bbf82a92b.y,z5bbf82a92b.z,z5bbf82a92b.w};float z2ceefda761=zf18f143a6d[
zbf1bcb5911]/(zf18f143a6d[z950bbd3d8e]+zf18f143a6d[zbf1bcb5911]);
float z51eadf1cec=mix(zc9fb84cd12[zbf1bcb5911],zc9fb84cd12[z950bbd3d8e],
z2ceefda761);float zc3f0dd67c0=fmin(zfc397c3985.x,fmin(zfc397c3985.y,fmin(
zfc397c3985.z,zfc397c3985.w)));float z9e1a31e30a=fmax(zfc397c3985.x,fmax(
zfc397c3985.y,fmax(zfc397c3985.z,zfc397c3985.w)));z51eadf1cec=clamp(z51eadf1cec,
zc3f0dd67c0,z9e1a31e30a);int zcdf189b12e=(zba94ee46da.x)+zba94ee46da.y*
z745057f086/4;ushort z9a35c6bb1a=convert_ushort_sat(z51eadf1cec);if(z945895b462.
y&1)
{


z718a062ddd[0+zcdf189b12e]=(ushort4)(0,z395b96baac[-1],0,0);z718a062ddd[1+
zcdf189b12e]=(ushort4)(0,z9a35c6bb1a,z395b96baac[0],0);}else{


z718a062ddd[0+zcdf189b12e]=(ushort4)(z395b96baac[0],z9a35c6bb1a,0,0);z718a062ddd
[1+zcdf189b12e]=(ushort4)(0,z395b96baac[1],0,0);}}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
