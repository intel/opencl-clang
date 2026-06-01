#define z3dbd1ff682 3
#define  z3dbd1ff682 3

#define z51b7908a0d __global ushort
#define za6c557b086 int
#ifndef z3dbd1ff682
#define z3dbd1ff682 3
#endif
#define z0624ab24e5 6
#if (z3dbd1ff682==0 || z3dbd1ff682==3 )
#define z9a0625b8f9 1
#define z85df37f325 8
#else
#define z9a0625b8f9 8
#define z85df37f325 1
#endif
#if (z3dbd1ff682==0)



#define z9eb93ebd55 ((z85df37f325*z0624ab24e5+4) *3)
__kernel void za681ce06f0(__global ushort*zcd420da6ce,__global ushort4*
z718a062ddd,int4 z30eaaf69b7,int z45c01651ac,int z745057f086,int4 zcf4670ee56,
int z579efb067a,int4 z5db4aa8097,int2 zbcfd028ae9,__global ushort*z415f880817,
int zeb5cf63993){if(z9a0625b8f9*get_global_id(0)>=z30eaaf69b7.z)return;if(
z85df37f325*get_global_id(1)>=z30eaaf69b7.w)return;z51b7908a0d*zba15fb8bb8=
zcd420da6ce+zcf4670ee56.x+(zcf4670ee56.y*z45c01651ac);__private uint z12e774ad89
[z9eb93ebd55];__private za6c557b086*z6b4f1eb563=z12e774ad89+3*2;
int zb6170e4cc6=z5db4aa8097.x;int zc8435b5afd=z5db4aa8097.y+z85df37f325*
get_global_id(1)*z579efb067a;int z80dd2bd3eb=zcf4670ee56.z;int z995f1680f0=
zcf4670ee56.w;int z0259df5e2e=z30eaaf69b7.z;int z352f9282d1=z85df37f325;__global
 ushort4*zddaa6f652d=z718a062ddd+z30eaaf69b7.x+(z30eaaf69b7.y+z85df37f325*
get_global_id(1))*z745057f086/4;int x=get_global_id(0);
{

for(int z1d8bd19892=0;z1d8bd19892<z9eb93ebd55;z1d8bd19892++)z12e774ad89[
z1d8bd19892]=0;
for(int zc180b9cdc9=-1;zc180b9cdc9<=z579efb067a;zc180b9cdc9++){
int z4d5680d21d=zb6170e4cc6+x*z579efb067a+zc180b9cdc9;if(z4d5680d21d<0)
z4d5680d21d=-z4d5680d21d;if(z4d5680d21d>=z80dd2bd3eb)z4d5680d21d=(2*z80dd2bd3eb-
2)-z4d5680d21d;
int zcecd661e11,z2a634d5ab4,zb4f6f0dfd9;int z8e4230b470=(z4d5680d21d+zbcfd028ae9
.x)&1;int z32b93551cc=(zc8435b5afd+zbcfd028ae9.y)&1;if(z8e4230b470==0){
zb4f6f0dfd9=0;z2a634d5ab4=-z32b93551cc;zcecd661e11=z32b93551cc-1;}else{
zb4f6f0dfd9=2;z2a634d5ab4=z32b93551cc-1;zcecd661e11=-z32b93551cc;}
za6c557b086 z6eb677052d=6;za6c557b086 zc754583208=1;if(zc180b9cdc9==0||
zc180b9cdc9==z579efb067a-1)z6eb677052d=5;if(zc180b9cdc9<0||zc180b9cdc9>
z579efb067a-1){z6eb677052d=1;zc754583208=0;}{
for(int za3584c0652=zcecd661e11;za3584c0652<=z352f9282d1*z579efb067a;za3584c0652
+=2){
int z278ea663fa=zc8435b5afd+za3584c0652;if(z278ea663fa<0)z278ea663fa=-
z278ea663fa;if(z278ea663fa>=z995f1680f0)z278ea663fa=(2*z995f1680f0-2)-
z278ea663fa;
za6c557b086 z4633c865c6=zba15fb8bb8[z278ea663fa*z45c01651ac+z4d5680d21d];
z6b4f1eb563[3*(za3584c0652-1)+1]+=z4633c865c6*zc754583208;z6b4f1eb563[3*(
za3584c0652+0)+1]+=z4633c865c6*z6eb677052d;z6b4f1eb563[3*(za3584c0652+1)+1]+=
z4633c865c6*zc754583208;}}
za6c557b086 z9dcfca5e38=8;za6c557b086 zfee4324e6a=4;if(zc180b9cdc9==0||
zc180b9cdc9==z579efb067a-1){z9dcfca5e38=6;zfee4324e6a=3;}if(zc180b9cdc9<0||
zc180b9cdc9>z579efb067a-1){z9dcfca5e38=2;zfee4324e6a=1;}
{
for(int za3584c0652=z2a634d5ab4;za3584c0652<=z352f9282d1*z579efb067a;za3584c0652
+=2){
int z278ea663fa=zc8435b5afd+za3584c0652;if(z278ea663fa<0)z278ea663fa=-
z278ea663fa;if(z278ea663fa>=z995f1680f0)z278ea663fa=(2*z995f1680f0-2)-
z278ea663fa;
za6c557b086 z4633c865c6=zba15fb8bb8[z278ea663fa*z45c01651ac+z4d5680d21d];
z6b4f1eb563[3*(za3584c0652-1)+zb4f6f0dfd9]+=z4633c865c6*zfee4324e6a;z6b4f1eb563[
3*(za3584c0652+0)+zb4f6f0dfd9]+=z4633c865c6*z9dcfca5e38;z6b4f1eb563[3*(
za3584c0652+1)+zb4f6f0dfd9]+=z4633c865c6*zfee4324e6a;}}}za6c557b086 z5b8c31c8e4=
4*z579efb067a*z579efb067a;if(z5b8c31c8e4<4)z5b8c31c8e4=4;for(int y=0;y<
z352f9282d1;y++){
za6c557b086 zff400e9e97=0;za6c557b086 z305d891f1d=0;za6c557b086 za3158292ce=0;
for(int za3584c0652=0;za3584c0652<z579efb067a;za3584c0652++){zff400e9e97+=
z6b4f1eb563[3*(y*z579efb067a+za3584c0652)+0];z305d891f1d+=z6b4f1eb563[3*(y*
z579efb067a+za3584c0652)+1];za3158292ce+=z6b4f1eb563[3*(y*z579efb067a+
za3584c0652)+2];}
zddaa6f652d[y*z745057f086/4+x]=convert_ushort4((uint4)(zff400e9e97,z305d891f1d,
za3158292ce,0)/z5b8c31c8e4);}}

}
#endif
#if (z3dbd1ff682==1)



#define z9eb93ebd55 ((z9a0625b8f9*z0624ab24e5+4) *3)
__kernel void z074bd0758c(__global ushort*zcd420da6ce,__global ushort4*
z718a062ddd,int4 z30eaaf69b7,int z45c01651ac,int z745057f086,int4 zcf4670ee56,
int z579efb067a,int4 z5db4aa8097,int2 zbcfd028ae9,__global ushort*z415f880817,
int zeb5cf63993){if(z9a0625b8f9*get_global_id(0)>=z30eaaf69b7.z)return;if(
z85df37f325*get_global_id(1)>=z30eaaf69b7.w)return;z51b7908a0d*zba15fb8bb8=
zcd420da6ce+zcf4670ee56.x+(zcf4670ee56.y*z45c01651ac);__private uint z12e774ad89
[z9eb93ebd55];__private za6c557b086*z6b4f1eb563=z12e774ad89+3*2;
int zb6170e4cc6=z5db4aa8097.x+z9a0625b8f9*get_global_id(0)*z579efb067a;int
zc8435b5afd=z5db4aa8097.y;int z80dd2bd3eb=zcf4670ee56.z;int z995f1680f0=
zcf4670ee56.w;int z0259df5e2e=z9a0625b8f9;int z352f9282d1=z30eaaf69b7.w;__global
 ushort4*zddaa6f652d=z718a062ddd+z30eaaf69b7.x+z9a0625b8f9*get_global_id(0)+(
z30eaaf69b7.y)*z745057f086/4;int y=get_global_id(1);


for(int z1d8bd19892=0;z1d8bd19892<z9eb93ebd55;z1d8bd19892++)z12e774ad89[
z1d8bd19892]=0;
for(int za3584c0652=0;za3584c0652<z579efb067a;za3584c0652++){
int z278ea663fa=zc8435b5afd+y*z579efb067a+za3584c0652;if(z278ea663fa<0)
z278ea663fa=-z278ea663fa;if(z278ea663fa>=z995f1680f0)z278ea663fa=(2*z995f1680f0-
2)-z278ea663fa;
bool z2686a8d879=true;if(zb6170e4cc6-1<0||zb6170e4cc6+z0259df5e2e*z579efb067a>=
z80dd2bd3eb)z2686a8d879=false;
for(int zc180b9cdc9=0;zc180b9cdc9<=z0259df5e2e*z579efb067a;zc180b9cdc9++){
int z4d5680d21d=zb6170e4cc6+zc180b9cdc9;if(z4d5680d21d<0)z4d5680d21d=-
z4d5680d21d;if(z4d5680d21d>=z80dd2bd3eb)z4d5680d21d=(2*z80dd2bd3eb-2)-
z4d5680d21d;
za6c557b086 ze4b052164b=zba15fb8bb8[z278ea663fa*z45c01651ac+3*z4d5680d21d+0];
za6c557b086 z2e91460297=zba15fb8bb8[z278ea663fa*z45c01651ac+3*z4d5680d21d+1];
za6c557b086 z7e674d442a=zba15fb8bb8[z278ea663fa*z45c01651ac+3*z4d5680d21d+2];
z6b4f1eb563[3*zc180b9cdc9+0]+=ze4b052164b;z6b4f1eb563[3*zc180b9cdc9+1]+=
z2e91460297;z6b4f1eb563[3*zc180b9cdc9+2]+=z7e674d442a;}}za6c557b086 z5b8c31c8e4=
z579efb067a*z579efb067a;if(z5b8c31c8e4<1)z5b8c31c8e4=1;for(int x=0;x<z0259df5e2e
;x++){
za6c557b086 zff400e9e97=0,z305d891f1d=0,za3158292ce=0;for(int zc180b9cdc9=0;
zc180b9cdc9<z579efb067a;zc180b9cdc9++){zff400e9e97+=z6b4f1eb563[3*(x*z579efb067a
+zc180b9cdc9)+0];z305d891f1d+=z6b4f1eb563[3*(x*z579efb067a+zc180b9cdc9)+1];
za3158292ce+=z6b4f1eb563[3*(x*z579efb067a+zc180b9cdc9)+2];}
zddaa6f652d[y*z745057f086/4+x]=convert_ushort4((uint4)(zff400e9e97,z305d891f1d,
za3158292ce,0)/z5b8c31c8e4);}}
#endif
#if (z3dbd1ff682==2)



#define z9eb93ebd55 ((z9a0625b8f9*z0624ab24e5+4) )
__kernel void zcda66d2452(__global ushort*zcd420da6ce,__global ushort4*
z718a062ddd,int4 z30eaaf69b7,int z45c01651ac,int z745057f086,int4 zcf4670ee56,
int z579efb067a,int4 z5db4aa8097,int2 zbcfd028ae9,__global ushort*z415f880817,
int zeb5cf63993){if(z9a0625b8f9*get_global_id(0)>=z30eaaf69b7.z)return;if(
z85df37f325*get_global_id(1)>=z30eaaf69b7.w)return;z51b7908a0d*zba15fb8bb8=
zcd420da6ce+zcf4670ee56.x+(zcf4670ee56.y*z45c01651ac);__private uint z12e774ad89
[z9eb93ebd55];__private za6c557b086*z6b4f1eb563=z12e774ad89+3*2;
int zb6170e4cc6=z5db4aa8097.x+z9a0625b8f9*get_global_id(0)*z579efb067a;int
zc8435b5afd=z5db4aa8097.y;int z80dd2bd3eb=zcf4670ee56.z;int z995f1680f0=
zcf4670ee56.w;int z0259df5e2e=z9a0625b8f9;int z352f9282d1=z30eaaf69b7.w;__global
 ushort4*zddaa6f652d=z718a062ddd+z30eaaf69b7.x+z9a0625b8f9*get_global_id(0)+(
z30eaaf69b7.y)*z745057f086/4;int y=get_global_id(1);
{

for(int z1d8bd19892=0;z1d8bd19892<z9eb93ebd55;z1d8bd19892++)z12e774ad89[
z1d8bd19892]=0;
for(int za3584c0652=0;za3584c0652<z579efb067a;za3584c0652++){
int z278ea663fa=zc8435b5afd+y*z579efb067a+za3584c0652;if(z278ea663fa<0)
z278ea663fa=-z278ea663fa;if(z278ea663fa>=z995f1680f0)z278ea663fa=(2*z995f1680f0-
2)-z278ea663fa;{
for(int zc180b9cdc9=0;zc180b9cdc9<=z0259df5e2e*z579efb067a;zc180b9cdc9++){
int z4d5680d21d=zb6170e4cc6+zc180b9cdc9;if(z4d5680d21d<0)z4d5680d21d=-
z4d5680d21d;if(z4d5680d21d>=z80dd2bd3eb)z4d5680d21d=(2*z80dd2bd3eb-2)-
z4d5680d21d;
za6c557b086 z4633c865c6=zba15fb8bb8[z278ea663fa*z45c01651ac+z4d5680d21d];
z6b4f1eb563[zc180b9cdc9]+=z4633c865c6;}}}za6c557b086 z5b8c31c8e4=z579efb067a*
z579efb067a;if(z5b8c31c8e4<1)z5b8c31c8e4=1;for(int x=0;x<z0259df5e2e;x++){
za6c557b086 z9d5dae389a=0;for(int zc180b9cdc9=0;zc180b9cdc9<z579efb067a;
zc180b9cdc9++){z9d5dae389a+=z6b4f1eb563[x*z579efb067a+zc180b9cdc9];}
z9d5dae389a/=z5b8c31c8e4;zddaa6f652d[y*z745057f086/4+x]=convert_ushort4((uint4)(
z9d5dae389a,z9d5dae389a,z9d5dae389a,0));}}

}
#endif
#if (z3dbd1ff682==3)




#define z9eb93ebd55 ((z85df37f325*z0624ab24e5+4) *3)
#define zaaa8814884 (z85df37f325*z0624ab24e5+4)
__kernel void zd812ee08a1(__global ushort*zcd420da6ce,__global ushort4*
z718a062ddd,int4 z30eaaf69b7,int z45c01651ac,int z745057f086,int4 zcf4670ee56,
int z579efb067a,int4 z5db4aa8097,int2 zbcfd028ae9,__global ushort*z415f880817,
int zeb5cf63993,int zb8f352ac4d,int16 zdc18cdcf8e,int16 z4bbf45626e,int16
zb5d9fd6902,int16 z8d2031dc57,int16 zf3d36792d2,__global short*zda7e9aa6bf){if(
z9a0625b8f9*get_global_id(0)>=z30eaaf69b7.z)return;if(z85df37f325*get_global_id(
1)>=z30eaaf69b7.w)return;z51b7908a0d*zba15fb8bb8=zcd420da6ce+zcf4670ee56.x+(
zcf4670ee56.y*z45c01651ac);__private uint z93ca5498a0[zaaa8814884];__private
za6c557b086*z15cfcf0c8e=z93ca5498a0+2;__private uint z12e774ad89[z9eb93ebd55];
__private za6c557b086*z6b4f1eb563=z12e774ad89+3*2;
int zb6170e4cc6=z5db4aa8097.x;int zc8435b5afd=z5db4aa8097.y+z85df37f325*
get_global_id(1)*z579efb067a;int z80dd2bd3eb=zcf4670ee56.z;int z995f1680f0=
zcf4670ee56.w;int z0259df5e2e=z30eaaf69b7.z;int z352f9282d1=z85df37f325;int
z6fa5659bb8=z5db4aa8097.z;int z22c51f4668=z85df37f325*z579efb067a;
int*zb71ad904a9=(int*)&zdc18cdcf8e;int*z53c5d7c3cc=(int*)&z4bbf45626e;int*
z7e0eec30bc=(int*)&zb5d9fd6902;int*zc2ab33128d=(int*)&z8d2031dc57;int*
z8a50010fae=(int*)&zf3d36792d2;__global ushort4*zddaa6f652d=z718a062ddd+
z30eaaf69b7.x+(z30eaaf69b7.y+z85df37f325*get_global_id(1))*z745057f086/4;int x=
get_global_id(0);
{

for(int z1d8bd19892=0;z1d8bd19892<z9eb93ebd55;z1d8bd19892++)z12e774ad89[
z1d8bd19892]=0;
for(int zc180b9cdc9=-1;zc180b9cdc9<=z579efb067a;zc180b9cdc9++){
int z4d5680d21d=zb6170e4cc6+x*z579efb067a+zc180b9cdc9;if(z4d5680d21d<0)
z4d5680d21d=-z4d5680d21d;if(z4d5680d21d>=z80dd2bd3eb)z4d5680d21d=(2*z80dd2bd3eb-
2)-z4d5680d21d;
int zcecd661e11,z2a634d5ab4,zb4f6f0dfd9;int z8e4230b470=(z4d5680d21d+zbcfd028ae9
.x)&1;int z32b93551cc=(zc8435b5afd+zbcfd028ae9.y)&1;if(z8e4230b470==0){
zb4f6f0dfd9=0;z2a634d5ab4=-z32b93551cc;zcecd661e11=z32b93551cc-1;}else{
zb4f6f0dfd9=2;z2a634d5ab4=z32b93551cc-1;zcecd661e11=-z32b93551cc;}bool
z0f4819c936=false;for(int zda08da2c59=0;zda08da2c59<zb8f352ac4d;zda08da2c59++){
int z7feea6d54c=z7e0eec30bc[zda08da2c59];int z8dd6fa68b0=zb71ad904a9[zda08da2c59
];int zb3384a3407=z53c5d7c3cc[zda08da2c59];
while(z7feea6d54c>z8dd6fa68b0&&z4d5680d21d<zda7e9aa6bf[z7feea6d54c+0])
z7feea6d54c-=7;while(z7feea6d54c<zb3384a3407&&z4d5680d21d>=zda7e9aa6bf[
z7feea6d54c+7])z7feea6d54c+=7;z7e0eec30bc[zda08da2c59]=z7feea6d54c;
if(zda7e9aa6bf[z7feea6d54c]!=z4d5680d21d)continue;
int zd26ed2c6ab=zc2ab33128d[zda08da2c59];int zfa9705370e=z8a50010fae[zda08da2c59
];float z84a1e6ab82=1.0f/convert_float(zfa9705370e-zd26ed2c6ab);for(int
z478c3e7a7c=0;z478c3e7a7c<2;z478c3e7a7c++){
int z5083031dab=(zc8435b5afd+z478c3e7a7c)&1;float z908a899bab=convert_float(
zda7e9aa6bf[z7feea6d54c+3*z5083031dab+1])*(1.0f/16384.0f);float z842f1c9b69=
convert_float(zda7e9aa6bf[z7feea6d54c+3*z5083031dab+2])*(1.0f/16384.0f);float
ze5a637a73c=convert_float(zda7e9aa6bf[z7feea6d54c+3*z5083031dab+3])*(1.0f/
16384.0f);for(int za3584c0652=z478c3e7a7c-2;za3584c0652<=z22c51f4668;za3584c0652
+=2){
int z278ea663fa=zc8435b5afd+za3584c0652;if(z278ea663fa<0)z278ea663fa=-
z278ea663fa;if(z278ea663fa>=z995f1680f0)z278ea663fa=(2*z995f1680f0-2)-
z278ea663fa;

float z4633c865c6=zba15fb8bb8[z278ea663fa*z45c01651ac+z4d5680d21d];if(
z0f4819c936){
z4633c865c6=z15cfcf0c8e[za3584c0652];}
if(zd26ed2c6ab<=z278ea663fa&&z278ea663fa<zfa9705370e){float z8d007bcae6=(
z278ea663fa-zd26ed2c6ab)*z84a1e6ab82;float z2f9b04fc4f=1.0f-z8d007bcae6;float
z778c582bcd=z8d007bcae6*z2f9b04fc4f*4.0f;float z305d891f1d=1.0f+z8d007bcae6*
z908a899bab+z2f9b04fc4f*z842f1c9b69+z778c582bcd*ze5a637a73c;z4633c865c6=
z4633c865c6*z305d891f1d;
if(z4633c865c6>65535)z4633c865c6=65535;}
z15cfcf0c8e[za3584c0652]=z4633c865c6;}}
z0f4819c936=true;
}
za6c557b086 z6eb677052d=6;za6c557b086 zc754583208=1;if(zc180b9cdc9==0||
zc180b9cdc9==z579efb067a-1)z6eb677052d=5;if(zc180b9cdc9<0||zc180b9cdc9>
z579efb067a-1){z6eb677052d=1;zc754583208=0;}if(z0f4819c936){
for(int za3584c0652=zcecd661e11;za3584c0652<=z22c51f4668;za3584c0652+=2){
za6c557b086 z4633c865c6=z15cfcf0c8e[za3584c0652];z6b4f1eb563[3*(za3584c0652-1)+1
]+=z4633c865c6*zc754583208;z6b4f1eb563[3*(za3584c0652+0)+1]+=z4633c865c6*
z6eb677052d;z6b4f1eb563[3*(za3584c0652+1)+1]+=z4633c865c6*zc754583208;}}else{
for(int za3584c0652=zcecd661e11;za3584c0652<=z22c51f4668;za3584c0652+=2){
int z278ea663fa=zc8435b5afd+za3584c0652;if(z278ea663fa<0)z278ea663fa=-
z278ea663fa;if(z278ea663fa>=z995f1680f0)z278ea663fa=(2*z995f1680f0-2)-
z278ea663fa;
za6c557b086 z4633c865c6=zba15fb8bb8[z278ea663fa*z45c01651ac+z4d5680d21d];
z6b4f1eb563[3*(za3584c0652-1)+1]+=z4633c865c6*zc754583208;z6b4f1eb563[3*(
za3584c0652+0)+1]+=z4633c865c6*z6eb677052d;z6b4f1eb563[3*(za3584c0652+1)+1]+=
z4633c865c6*zc754583208;}}
za6c557b086 z9dcfca5e38=8;za6c557b086 zfee4324e6a=4;if(zc180b9cdc9==0||
zc180b9cdc9==z579efb067a-1){z9dcfca5e38=6;zfee4324e6a=3;}if(zc180b9cdc9<0||
zc180b9cdc9>z579efb067a-1){z9dcfca5e38=2;zfee4324e6a=1;}if(z0f4819c936){
for(int za3584c0652=z2a634d5ab4;za3584c0652<=z22c51f4668;za3584c0652+=2){
za6c557b086 z4633c865c6=z15cfcf0c8e[za3584c0652];z6b4f1eb563[3*(za3584c0652-1)+
zb4f6f0dfd9]+=z4633c865c6*zfee4324e6a;z6b4f1eb563[3*(za3584c0652+0)+zb4f6f0dfd9]
+=z4633c865c6*z9dcfca5e38;z6b4f1eb563[3*(za3584c0652+1)+zb4f6f0dfd9]+=
z4633c865c6*zfee4324e6a;}}else{
for(int za3584c0652=z2a634d5ab4;za3584c0652<=z22c51f4668;za3584c0652+=2){
int z278ea663fa=zc8435b5afd+za3584c0652;if(z278ea663fa<0)z278ea663fa=-
z278ea663fa;if(z278ea663fa>=z995f1680f0)z278ea663fa=(2*z995f1680f0-2)-
z278ea663fa;
za6c557b086 z4633c865c6=zba15fb8bb8[z278ea663fa*z45c01651ac+z4d5680d21d];
z6b4f1eb563[3*(za3584c0652-1)+zb4f6f0dfd9]+=z4633c865c6*zfee4324e6a;z6b4f1eb563[
3*(za3584c0652+0)+zb4f6f0dfd9]+=z4633c865c6*z9dcfca5e38;z6b4f1eb563[3*(
za3584c0652+1)+zb4f6f0dfd9]+=z4633c865c6*zfee4324e6a;}}}za6c557b086 z5b8c31c8e4=
4*z579efb067a*z579efb067a;if(z5b8c31c8e4<4)z5b8c31c8e4=4;for(int y=0;y<
z352f9282d1;y++){
za6c557b086 zff400e9e97=0;za6c557b086 z305d891f1d=0;za6c557b086 za3158292ce=0;
for(int za3584c0652=0;za3584c0652<z579efb067a;za3584c0652++){zff400e9e97+=
z6b4f1eb563[3*(y*z579efb067a+za3584c0652)+0];z305d891f1d+=z6b4f1eb563[3*(y*
z579efb067a+za3584c0652)+1];za3158292ce+=z6b4f1eb563[3*(y*z579efb067a+
za3584c0652)+2];}
zddaa6f652d[y*z745057f086/4+x]=convert_ushort4((uint4)(zff400e9e97,z305d891f1d,
za3158292ce,0)/z5b8c31c8e4);}}

}
#endif
#if (z3dbd1ff682==4)
__kernel void z5a6fa89f11(__global ushort*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,int4 zfb81b1b9ea){
int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;const int z80dd2bd3eb=
zfb81b1b9ea.s0;const int z995f1680f0=zfb81b1b9ea.s1;const int zb6170e4cc6=
zfb81b1b9ea.s2;const int zc8435b5afd=zfb81b1b9ea.s3;const int zc180b9cdc9=
zba94ee46da.x;const int za3584c0652=zba94ee46da.y;const int z45c01651ac=
z2824fcf57d;__global ushort*zba15fb8bb8=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.
s5*z45c01651ac;const int zb41a4b7008=z9562068e13;__global ushort4*zddaa6f652d=
z718a062ddd+z30eaaf69b7.s0+z30eaaf69b7.s1*zb41a4b7008;

{int y=zc8435b5afd+za3584c0652*2;
if(y<+2)y=-(y-2);if(y>z995f1680f0-2)y=2*(z995f1680f0-2)-y;z51b7908a0d*
z395b96baac=&zba15fb8bb8[y*z45c01651ac];__global ushort4*ze4351005bc=&
zddaa6f652d[za3584c0652*zb41a4b7008];
{int x=zb6170e4cc6+zc180b9cdc9*2;
if(x<+2)x=-(x-2);if(x>z80dd2bd3eb-2)x=2*(z80dd2bd3eb-2)-x;
za6c557b086 zff400e9e97=convert_uint(z395b96baac[x]);
za6c557b086 z305d891f1d;z305d891f1d=convert_uint(z395b96baac[x-z45c01651ac]);
z305d891f1d+=convert_uint(z395b96baac[x-1]);z305d891f1d+=convert_uint(
z395b96baac[x+1]);z305d891f1d+=convert_uint(z395b96baac[x+z45c01651ac]);
z305d891f1d/=4;za6c557b086 za3158292ce;za3158292ce=convert_uint(z395b96baac[x+(-
1-z45c01651ac)]);za3158292ce+=convert_uint(z395b96baac[x+(+1-z45c01651ac)]);
za3158292ce+=convert_uint(z395b96baac[x+(-1+z45c01651ac)]);za3158292ce+=
convert_uint(z395b96baac[x+(+1+z45c01651ac)]);za3158292ce/=4;


ze4351005bc[zc180b9cdc9]=(ushort4)(zff400e9e97,z305d891f1d,za3158292ce,0);}}}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
