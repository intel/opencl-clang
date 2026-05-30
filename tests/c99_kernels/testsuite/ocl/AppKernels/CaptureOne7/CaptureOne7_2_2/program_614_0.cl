__kernel void zaf5f4e726d(__global float4*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int4 z30eaaf69b7,uint z021babbfad,uint z745057f086){int2 zba94ee46da
=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.z||
zba94ee46da.y>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.xy;int2 z83640e5796
=zba94ee46da;ushort4 zbed769e4d8=convert_ushort4(zf8d9fd6cb8[z83640e5796.x+
z83640e5796.y*(z021babbfad/4)]);int z77f8ae3448=zba94ee46da.x+zba94ee46da.y*(
z745057f086/4);z718a062ddd[z77f8ae3448]=zbed769e4d8;

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
