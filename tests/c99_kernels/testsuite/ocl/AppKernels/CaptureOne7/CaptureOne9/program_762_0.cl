#define ze9fed095f7 float
#define zaede7752ba float
#define z6713806723
#define zc4eb78778c(S,D) D = (log(max(0.00001f, S)) * 0.090168566f);

#ifndef ze9fed095f7
#define ze9fed095f7 float4
#endif
#ifndef zaede7752ba
#define zaede7752ba float4
#endif
#ifndef z6713806723
#define z6713806723 , float4 z510a0f1615
#endif
#ifndef zc4eb78778c
#define zc4eb78778c(zc6c715f5ba,z9413b196a2) z9413b196a2 = zc6c715f5ba * \
z510a0f1615;
#endif
__kernel void zf721141961(__global ze9fed095f7*zf8d9fd6cb8,__global zaede7752ba*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13 z6713806723){int2
zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;
ze9fed095f7 z2dd09f3226=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];int
 z77f8ae3448=zaaf414d14e.x+zaaf414d14e.y*z9562068e13;zaede7752ba za3158292ce=
z718a062ddd[z77f8ae3448];zc4eb78778c(z2dd09f3226,za3158292ce)z718a062ddd[
z77f8ae3448]=za3158292ce;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
