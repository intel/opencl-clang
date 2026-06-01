#define z3dbd1ff682 1

#define z12cbbf15c0					65535.0f
#define MIN min
#define MAX max
#ifndef z3dbd1ff682
#define z3dbd1ff682 0
#endif
#if ( z3dbd1ff682==0 )
__kernel void zb2ad01792e(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float2 ze0995e6531)
{int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;const
float4 z61f704e443=(float4)ze0995e6531.s0;const float4 z5b8c31c8e4=(float4)
ze0995e6531.s1;float4 z395b96baac=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*
z2824fcf57d];z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=z61f704e443+
z395b96baac*z5b8c31c8e4;
}
#endif
#if ( z3dbd1ff682==1 )
__kernel void zb2ad01792e(__global float4*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13){int2 zba94ee46da=(
int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.
s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;float4 z4633c865c6=zf8d9fd6cb8[
z83640e5796.x+z83640e5796.y*z2824fcf57d];z4633c865c6*=(float4)(65535.0f);

z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=convert_ushort4_sat(
z4633c865c6);}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
