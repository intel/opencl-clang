__kernel void zf213f57bd3(__global float4*zf8d9fd6cb8,__global float*z718a062ddd
,int4 z30eaaf69b7,uint z021babbfad,uint z958df11031,float4 z510a0f1615){int2
zba94ee46da=(int2)(2*get_global_id(0),2*get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.xy;
int2 z83640e5796=zba94ee46da;
float z395b96baac[12];const int z45c01651ac=6;int zc9d655d235=z83640e5796.x+
z83640e5796.y*(z021babbfad/4);z395b96baac[0]=zf8d9fd6cb8[zc9d655d235].x;
z395b96baac[1]=zf8d9fd6cb8[zc9d655d235].y;z395b96baac[2]=zf8d9fd6cb8[zc9d655d235
].z;z395b96baac[4]=zf8d9fd6cb8[zc9d655d235+1].y;z395b96baac[z45c01651ac+1]=
zf8d9fd6cb8[zc9d655d235+z021babbfad/4].y;z395b96baac[z45c01651ac+3]=zf8d9fd6cb8[
1+zc9d655d235+z021babbfad/4].x;z395b96baac[z45c01651ac+4]=zf8d9fd6cb8[1+
zc9d655d235+z021babbfad/4].y;z395b96baac[z45c01651ac+5]=zf8d9fd6cb8[1+
zc9d655d235+z021babbfad/4].z;


z395b96baac[2]*=z510a0f1615.y;
z395b96baac[1]*=z510a0f1615.y;
z395b96baac[z45c01651ac+3]*=z510a0f1615.y;
z395b96baac[z45c01651ac+4]*=z510a0f1615.y;
z395b96baac[4]*=z510a0f1615.y;
z395b96baac[z45c01651ac+1]*=z510a0f1615.y;
float zd42c65dbd7=z395b96baac[0]*z510a0f1615.x;float z55b126dfb1=z395b96baac[
z45c01651ac+5]*z510a0f1615.z;float z58337ed22d=zd42c65dbd7-z395b96baac[2];
float ze9376e93c6=z55b126dfb1-z395b96baac[z45c01651ac+3];
float z8b894cdd31=zd42c65dbd7-z395b96baac[1];
float z43c3d58ea8=z55b126dfb1-z395b96baac[z45c01651ac+4];
float z3cb50157cd=fabs(z58337ed22d);float zdb4f697174=fabs(ze9376e93c6);float
z42cb58752e=fabs(z8b894cdd31);float zc8696c379c=fabs(z43c3d58ea8);float
z739c65fcf1=z42cb58752e<z3cb50157cd?z8b894cdd31:z58337ed22d;float z09eee172bf=
zc8696c379c<zdb4f697174?z43c3d58ea8:ze9376e93c6;z395b96baac[0]=z739c65fcf1;
z395b96baac[z45c01651ac+5]=z09eee172bf;__global float*ze4351005bc=z718a062ddd+3*
zba94ee46da.x+zba94ee46da.y*z958df11031;ze4351005bc[0]=z395b96baac[0];
ze4351005bc[1]=z395b96baac[1];ze4351005bc[2]=z395b96baac[2];ze4351005bc[4]=
z395b96baac[4];ze4351005bc[z958df11031+3]=z395b96baac[z45c01651ac+3];ze4351005bc
[z958df11031+4]=z395b96baac[z45c01651ac+4];ze4351005bc[z958df11031+1]=
z395b96baac[z45c01651ac+1];ze4351005bc[z958df11031+5]=z395b96baac[z45c01651ac+5]
;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
