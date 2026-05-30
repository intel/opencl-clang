#define zbc6516e8d5  0

#ifndef zbc6516e8d5
#define zbc6516e8d5 1
#endif
__kernel void zb13006c72c(__global float*zf8d9fd6cb8,__global float*z718a062ddd,
int8 z30eaaf69b7,uint z021babbfad,uint z958df11031,float8 ze7168fc0b9
#if zbc6516e8d5
,__local float*z01612e015a
#endif
){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));bool zc80cdffc13=(
zba94ee46da.x>=z30eaaf69b7.s2+8||zba94ee46da.y>=z30eaaf69b7.s3);bool zdfd2b18d8e
=(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3);int2 z83640e5796
=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int
z47728d2efe=get_local_size(0);int z3902475141=get_local_size(1);int z62a8006ca5=
(z47728d2efe+2*4);int zc9d655d235=z83640e5796.x+z83640e5796.y*z021babbfad;int
z38a89f6944=get_local_id(0);int zb3ec2e5425=1;
#if zbc6516e8d5
__local float*zf485e5e12c=z01612e015a+get_local_id(1)*z62a8006ca5+4;int
ze12af1c5cf=z38a89f6944;
if(!zc80cdffc13)zf485e5e12c[ze12af1c5cf]=zf8d9fd6cb8[zc9d655d235];if(z38a89f6944
<4&&!zc80cdffc13)zf485e5e12c[ze12af1c5cf-4]=zf8d9fd6cb8[zc9d655d235-zb3ec2e5425*
4];
if(z38a89f6944>=z47728d2efe-4&&!zc80cdffc13)zf485e5e12c[ze12af1c5cf+4]=
zf8d9fd6cb8[zc9d655d235+zb3ec2e5425*4];
int z8ea92fe60a=1;barrier(CLK_LOCAL_MEM_FENCE);
#else
int z8ea92fe60a=zb3ec2e5425;z38a89f6944=zc9d655d235;__global float*zf485e5e12c=
zf8d9fd6cb8;
#endif
if(zdfd2b18d8e)return;

float z9697e8d76f;z9697e8d76f=ze7168fc0b9.s4*zf485e5e12c[z38a89f6944];
z9697e8d76f+=ze7168fc0b9.s3*(zf485e5e12c[z38a89f6944-z8ea92fe60a]+zf485e5e12c[
z38a89f6944+z8ea92fe60a]);z9697e8d76f+=ze7168fc0b9.s2*(zf485e5e12c[z38a89f6944-2
*z8ea92fe60a]+zf485e5e12c[z38a89f6944+2*z8ea92fe60a]);z9697e8d76f+=ze7168fc0b9.
s1*(zf485e5e12c[z38a89f6944-3*z8ea92fe60a]+zf485e5e12c[z38a89f6944+3*z8ea92fe60a
]);z9697e8d76f+=ze7168fc0b9.s0*(zf485e5e12c[z38a89f6944-4*z8ea92fe60a]+
zf485e5e12c[z38a89f6944+4*z8ea92fe60a]);z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*
z958df11031]=z9697e8d76f;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
