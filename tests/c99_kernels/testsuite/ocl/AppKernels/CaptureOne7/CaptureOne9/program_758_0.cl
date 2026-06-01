#define zbc6516e8d5 0
typedef int zdba6b93f69;
#ifndef zbc6516e8d5
#define zbc6516e8d5 1
#endif
#define z73a6d0c759 2
__kernel void z4850e1bcf4(__global ushort*zf8d9fd6cb8,__global ushort2*
z718a062ddd,int4 z30eaaf69b7,int z58c1e26fb1,int z745057f086,int z10b3b0563a,
float z04b9d3f380,float zaca3d516df
#if zbc6516e8d5
,__local ushort*zf485e5e12c
#endif
){int2 zba94ee46da=(int2)(2*get_global_id(0),get_global_id(1));if(zba94ee46da.x+
1>=z30eaaf69b7.z||zba94ee46da.y>=z30eaaf69b7.w)return;zba94ee46da+=z30eaaf69b7.
xy;int2 z83640e5796=zba94ee46da;zdba6b93f69 z198f8f5bb8=2;zdba6b93f69
z796a73b2c0=z58c1e26fb1;zdba6b93f69 z9a4358f233=1;
#if zbc6516e8d5
int z6e29e29e19=2*get_local_size(0)+2*z73a6d0c759;__local ushort*zad17306490=
zf485e5e12c;int2 z7cdb6ae8dd=(int2)(2*get_local_id(0)+z73a6d0c759,get_local_id(1
)+z73a6d0c759);int2 z61bac1bc70=z83640e5796-z7cdb6ae8dd;int z2cf8520e42=
z61bac1bc70.x+z61bac1bc70.y*z796a73b2c0;int zf54614f74b=(z30eaaf69b7.z-1)+
z796a73b2c0*(z30eaaf69b7.w-1);int z8b1bb737a4=get_local_id(0)+get_local_id(1)*
get_local_size(0);int z4b946a6906=3*z8b1bb737a4;int za6fbfbc4c3=(z73a6d0c759+
get_local_size(1)+z73a6d0c759)*z6e29e29e19;for(int z8dd6fa68b0=0;z8dd6fa68b0<3;
z8dd6fa68b0++){int z38a89f6944=z4b946a6906+z8dd6fa68b0;if(z38a89f6944<
za6fbfbc4c3){int z4a5805e56d=z38a89f6944%z6e29e29e19;int zd47cd65624=z38a89f6944
/z6e29e29e19;int z95a479821b=z4a5805e56d+zd47cd65624*z796a73b2c0;z95a479821b=
clamp(z95a479821b+z2cf8520e42,0,zf54614f74b);zf485e5e12c[z38a89f6944]=
zf8d9fd6cb8[z95a479821b];}}barrier(CLK_LOCAL_MEM_FENCE);zad17306490+=z7cdb6ae8dd
.x+z7cdb6ae8dd.y*z6e29e29e19;z796a73b2c0=z6e29e29e19;
#else
__global ushort*zad17306490=zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z796a73b2c0;
#endif
zdba6b93f69 z7d816a67dd=z796a73b2c0*2;int z493deefb55[2];int Y=zba94ee46da.y;for
(int X=0;X<2;X++){zad17306490+=X;z493deefb55[X]=(zdba6b93f69)zad17306490[0];
zdba6b93f69 ze28128c2dd=(zdba6b93f69)zad17306490[0];zdba6b93f69 ze384962f2b=(
zdba6b93f69)zad17306490[z198f8f5bb8];zdba6b93f69 w=(zdba6b93f69)zad17306490[-
z198f8f5bb8];zdba6b93f69 z88fa33d26d=(zdba6b93f69)zad17306490[-z7d816a67dd];
zdba6b93f69 z5083031dab=(zdba6b93f69)zad17306490[z7d816a67dd];zdba6b93f69
zfc9f904fb9=(z88fa33d26d+ze384962f2b+w+z5083031dab)>>2;if((fabs((float)
zfc9f904fb9/(float)(ze28128c2dd)-1.0f)>z04b9d3f380)&&(abs(zfc9f904fb9-
ze28128c2dd)>z10b3b0563a)){
bool z043ee102e7=(X^Y)&1;if(z043ee102e7){
zdba6b93f69 z7c83382301=(zdba6b93f69)zad17306490[-z796a73b2c0-z9a4358f233];
zdba6b93f69 z2495fb4eee=(zdba6b93f69)zad17306490[-z796a73b2c0+z9a4358f233];
zdba6b93f69 z46d4ed32bc=(zdba6b93f69)zad17306490[z796a73b2c0-z9a4358f233];
zdba6b93f69 z88370fd9e8=(zdba6b93f69)zad17306490[z796a73b2c0+z9a4358f233];
zdba6b93f69 z5599ea8cc5=min(z88fa33d26d,min(z5083031dab,min(ze384962f2b,w)));if(
ze28128c2dd<z5599ea8cc5){
zdba6b93f69 z90374fbe92=z5599ea8cc5-ze28128c2dd;float zade837448c=(float)
z90374fbe92/(float)z5599ea8cc5;if(zade837448c>zaca3d516df)
{
zdba6b93f69 z73cfbbb622=(ze384962f2b+w)>>1;zdba6b93f69 z1827aa525e=(z88fa33d26d+
z5083031dab)>>1;if(z73cfbbb622<z1827aa525e)z493deefb55[X]=z73cfbbb622;
else z493deefb55[X]=z1827aa525e;

}}else{
zfc9f904fb9=(z7c83382301+z2495fb4eee+z46d4ed32bc+z88370fd9e8)>>2;zdba6b93f69
z174ca09f47=(z88fa33d26d+z5083031dab+ze384962f2b+w+z7c83382301+z2495fb4eee+
z46d4ed32bc+z88370fd9e8)>>3;zdba6b93f69 z3c794c31a3=abs(z7c83382301-z174ca09f47)
+abs(z2495fb4eee-z174ca09f47)+abs(z46d4ed32bc-z174ca09f47)+abs(z88370fd9e8-
z174ca09f47)+abs(z88fa33d26d-z174ca09f47)+abs(z5083031dab-z174ca09f47)+abs(
ze384962f2b-z174ca09f47)+abs(w-z174ca09f47);if((ze28128c2dd>z174ca09f47+(
z3c794c31a3<<1)))
{


z493deefb55[X]=zfc9f904fb9;}}}else{
zdba6b93f69 z88fa33d26d=(zdba6b93f69)zad17306490[-z7d816a67dd];zdba6b93f69
z5083031dab=(zdba6b93f69)zad17306490[z7d816a67dd];zdba6b93f69 z7c83382301=(
zdba6b93f69)zad17306490[-z7d816a67dd-z198f8f5bb8];zdba6b93f69 z2495fb4eee=(
zdba6b93f69)zad17306490[-z7d816a67dd+z198f8f5bb8];zdba6b93f69 z46d4ed32bc=(
zdba6b93f69)zad17306490[z7d816a67dd-z198f8f5bb8];zdba6b93f69 z88370fd9e8=(
zdba6b93f69)zad17306490[z7d816a67dd+z198f8f5bb8];zdba6b93f69 z5599ea8cc5=min(
z88fa33d26d,min(z5083031dab,min(ze384962f2b,w)));zdba6b93f69 zfc9f904fb9=(
z88fa33d26d+z5083031dab+ze384962f2b+w)>>2;if(ze28128c2dd<z5599ea8cc5){
zdba6b93f69 z90374fbe92=z5599ea8cc5-ze28128c2dd;float zade837448c=(float)
z90374fbe92/(float)z5599ea8cc5;if((zade837448c>zaca3d516df))
{
zdba6b93f69 z73cfbbb622=(ze384962f2b+w)>>1;zdba6b93f69 z1827aa525e=(z88fa33d26d+
z5083031dab)>>1;if(z73cfbbb622<z1827aa525e)z493deefb55[X]=z73cfbbb622;
else z493deefb55[X]=z1827aa525e;

}}else{
zfc9f904fb9=(z7c83382301+z2495fb4eee+z46d4ed32bc+z88370fd9e8)>>2;zdba6b93f69
z174ca09f47=(z88fa33d26d+z5083031dab+ze384962f2b+w+z7c83382301+z2495fb4eee+
z46d4ed32bc+z88370fd9e8)>>3;zdba6b93f69 z3c794c31a3=abs(z7c83382301-z174ca09f47)
+abs(z2495fb4eee-z174ca09f47)+abs(z46d4ed32bc-z174ca09f47)+abs(z88370fd9e8-
z174ca09f47)+abs(z88fa33d26d-z174ca09f47)+abs(z5083031dab-z174ca09f47)+abs(
ze384962f2b-z174ca09f47)+abs(w-z174ca09f47);if((ze28128c2dd>z174ca09f47+(
z3c794c31a3<<1)))
{


z493deefb55[X]=zfc9f904fb9;}}}}}int z77f8ae3448=(zba94ee46da.x/2)+zba94ee46da.y*
(z745057f086/2);z718a062ddd[z77f8ae3448]=(ushort2)(z493deefb55[0],z493deefb55[1]
);}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
