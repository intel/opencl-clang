__kernel void z23ecde48f0(__global ushort4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,uint z45c01651ac,uint z1ed8995796,int2 zd72c7cd02e,
int zce7e428e71){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(
zba94ee46da.x>=z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;int2
z83640e5796=zba94ee46da*(int2)(zce7e428e71,zce7e428e71)+zd72c7cd02e.xy;float4
z51eadf1cec=0.0f;
__global ushort4*z6533f4e792=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*(
z45c01651ac/4);float z2ca92c5b7a=(float)zce7e428e71;for(int z04337ebea9=-(
zce7e428e71-1);z04337ebea9<=(zce7e428e71-1);z04337ebea9++){float z785feecec0=
z2ca92c5b7a-fabs(convert_float(z04337ebea9));int line=(z45c01651ac/4)*
z04337ebea9;for(int z6a957fe2f1=-(zce7e428e71-1);z6a957fe2f1<=(zce7e428e71-1);
z6a957fe2f1++){float zdf8f02136c=z2ca92c5b7a-fabs(convert_float(z6a957fe2f1));
ushort4 z493deefb55=z6533f4e792[line+z6a957fe2f1];z51eadf1cec+=convert_float4(
z493deefb55)*zdf8f02136c*z785feecec0;}}z718a062ddd[zba94ee46da.y*z1ed8995796+
zba94ee46da.x]=z51eadf1cec;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
