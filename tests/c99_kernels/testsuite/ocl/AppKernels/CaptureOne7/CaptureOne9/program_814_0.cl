__kernel void za278ad6fdd(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,int z021babbfad,int z958df11031,float z436ea607d2,
float ze3c92567c2,float z9ba460273b,__global float*zd1287efa9c,int zf33d42615d,
__global float*zf67cf6107d,int z244d20ca40,__global ushort*zbac0acc1a7){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.xy;
int2 z83640e5796=zba94ee46da;int zc9d655d235=z83640e5796.x+z83640e5796.y*(
z021babbfad/4);float z6b9506c215=zd1287efa9c[zba94ee46da.x+zba94ee46da.y*
zf33d42615d];
ushort z873ce3dac4=convert_ushort_sat(z6b9506c215*ze3c92567c2)>>3;if(z873ce3dac4
>8190)
z873ce3dac4=8190;ushort z261dd1775c=zbac0acc1a7[z873ce3dac4];
float zec65e8d581=((float)z261dd1775c/1023.0f);zec65e8d581-=(1.0f-z9ba460273b);
zec65e8d581=max(zec65e8d581,0.0f);float zadecae4e7d=zf67cf6107d[zba94ee46da.x+
zba94ee46da.y*z244d20ca40];float4 z493deefb55=zf8d9fd6cb8[zc9d655d235];
z493deefb55.y=mix(zadecae4e7d,z493deefb55.y,zec65e8d581);







z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z493deefb55;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
