__kernel void z23ac93e2aa(__global float*zf8d9fd6cb8,__global float4*z718a062ddd
,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;zf8d9fd6cb8+=3*z83640e5796.x+z83640e5796
.y*(z2824fcf57d*4);float z2d351c5ace=zf8d9fd6cb8[0];float z3931fc4ce8=
zf8d9fd6cb8[1];float z963ba64275=zf8d9fd6cb8[2];z718a062ddd[zaaf414d14e.x+
zaaf414d14e.y*z9562068e13]=(float4)(z2d351c5ace,z3931fc4ce8,z963ba64275,0.0f);}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
