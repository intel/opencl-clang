#define z3dbd1ff682 0

#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : enable
#ifndef z3dbd1ff682
#define z3dbd1ff682 2
#endif
#if (z3dbd1ff682 == 0)
__kernel void zf94a20ad81(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int za2ebed4c3d,int z745057f086,__global short*
zcb1b02776b,int zbb8d7369a9,int z8dd6fa68b0,int za3584c0652,int zfc80d29315,
float z84a1e6ab82,int z478c3e7a7c){int2 zba94ee46da=(int2)(get_global_id(0),
get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.
s3)return;int z7facb167c6=z30eaaf69b7.s0;int ze28128c2dd=zba94ee46da.x+
z7facb167c6;int x=convert_int(zcb1b02776b[z8dd6fa68b0+ze28128c2dd*7])-
zbb8d7369a9;__global ushort*z9823cd7c39=zf8d9fd6cb8+z30eaaf69b7.s4+z30eaaf69b7.
s5*za2ebed4c3d;
int z5083031dab=(zfc80d29315+z478c3e7a7c-za3584c0652)&1;float z908a899bab=
convert_float(zcb1b02776b[z8dd6fa68b0+ze28128c2dd*7+3*z5083031dab+1])*(1.0f/
16384.0f);float z842f1c9b69=convert_float(zcb1b02776b[z8dd6fa68b0+ze28128c2dd*7+
3*z5083031dab+2])*(1.0f/16384.0f);float ze5a637a73c=convert_float(zcb1b02776b[
z8dd6fa68b0+ze28128c2dd*7+3*z5083031dab+3])*(1.0f/16384.0f);
int y=2*zba94ee46da.y+zfc80d29315+z478c3e7a7c;
{float z8d007bcae6=convert_float(y-za3584c0652)*z84a1e6ab82;float z2f9b04fc4f=
1.0f-z8d007bcae6;float z778c582bcd=z8d007bcae6*z2f9b04fc4f*4.0f;float
z305d891f1d=1.0f+z8d007bcae6*z908a899bab+z2f9b04fc4f*z842f1c9b69+z778c582bcd*
ze5a637a73c;float z4633c865c6=convert_float(z9823cd7c39[y*za2ebed4c3d+x])*
z305d891f1d;


z9823cd7c39[y*za2ebed4c3d+x]=convert_ushort_sat(z4633c865c6);}}
#endif
#if (z3dbd1ff682 == 1)
__kernel void zf94a20ad81(__global ushort*zf8d9fd6cb8,__global ushort*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13){int2 zba94ee46da=(
int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||
zba94ee46da.y>=z30eaaf69b7.s3)return;
#define z164047dc0a 12
int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+
z30eaaf69b7.s01;__global ushort*z395b96baac=zf8d9fd6cb8+z83640e5796.x+
z83640e5796.y*z2824fcf57d;int z77f8ae3448=zaaf414d14e.x+zaaf414d14e.y*
z9562068e13;int z51eadf1cec=0;for(int z1d8bd19892=-z164047dc0a;z1d8bd19892<=
z164047dc0a;z1d8bd19892+=2)z51eadf1cec+=convert_int(z395b96baac[z1d8bd19892*
z2824fcf57d]);z51eadf1cec/=(z164047dc0a+1);z718a062ddd[z77f8ae3448]=
convert_ushort(z51eadf1cec);}
#endif
#if (z3dbd1ff682 == 2)
#define z8bfc8ebe5f(x,y,zc9d80d25d3) do { zc9d80d25d3 = x; x = y; y = \
zc9d80d25d3; } while(0)
#define z946301ebb2(x,y,zc9d80d25d3) do { if (x > y) { zc9d80d25d3 = x; x = y; y\
 = zc9d80d25d3; } } while(0)
typedef ushort z6aa1f558f1;inline z6aa1f558f1 z150bc123ee(z6aa1f558f1
z2d351c5ace,z6aa1f558f1 z3931fc4ce8,z6aa1f558f1 z963ba64275,z6aa1f558f1
z9d0886a4aa,z6aa1f558f1 zbed769e4d8){z6aa1f558f1 z52ab5b652a;if(z2d351c5ace>
z3931fc4ce8){z8bfc8ebe5f(z2d351c5ace,z3931fc4ce8,z52ab5b652a);}if(z9d0886a4aa>
zbed769e4d8){z8bfc8ebe5f(z9d0886a4aa,zbed769e4d8,z52ab5b652a);}if(z2d351c5ace>
z9d0886a4aa){z8bfc8ebe5f(z2d351c5ace,z9d0886a4aa,z52ab5b652a);z8bfc8ebe5f(
z3931fc4ce8,zbed769e4d8,z52ab5b652a);}if(z3931fc4ce8>z963ba64275){z8bfc8ebe5f(
z3931fc4ce8,z963ba64275,z52ab5b652a);}if(z3931fc4ce8>z9d0886a4aa){z8bfc8ebe5f(
z3931fc4ce8,z9d0886a4aa,z52ab5b652a);z8bfc8ebe5f(z963ba64275,zbed769e4d8,
z52ab5b652a);}if(z963ba64275>z9d0886a4aa){z8bfc8ebe5f(z963ba64275,z9d0886a4aa,
z52ab5b652a);}return z963ba64275;}inline z6aa1f558f1 ze68b1201ae(z6aa1f558f1
z2d351c5ace,z6aa1f558f1 z3931fc4ce8,z6aa1f558f1 z963ba64275){z6aa1f558f1
z52ab5b652a;z946301ebb2(z2d351c5ace,z3931fc4ce8,z52ab5b652a);z946301ebb2(
z3931fc4ce8,z963ba64275,z52ab5b652a);z946301ebb2(z2d351c5ace,z3931fc4ce8,
z52ab5b652a);return z3931fc4ce8;}inline z6aa1f558f1 z72877633f9(z6aa1f558f1
z2d351c5ace,z6aa1f558f1 z3931fc4ce8,z6aa1f558f1 z963ba64275,z6aa1f558f1
z9d0886a4aa,z6aa1f558f1 zbed769e4d8,z6aa1f558f1 ze859817222,z6aa1f558f1
z7ca5ed27d2){z6aa1f558f1 z52ab5b652a;z946301ebb2(z2d351c5ace,ze859817222,
z52ab5b652a);z946301ebb2(z2d351c5ace,z9d0886a4aa,z52ab5b652a);z946301ebb2(
z3931fc4ce8,z7ca5ed27d2,z52ab5b652a);z946301ebb2(z963ba64275,zbed769e4d8,
z52ab5b652a);z946301ebb2(z2d351c5ace,z3931fc4ce8,z52ab5b652a);z946301ebb2(
z9d0886a4aa,ze859817222,z52ab5b652a);z946301ebb2(z963ba64275,z7ca5ed27d2,
z52ab5b652a);z946301ebb2(z963ba64275,z9d0886a4aa,z52ab5b652a);z946301ebb2(
z9d0886a4aa,z7ca5ed27d2,z52ab5b652a);z946301ebb2(zbed769e4d8,ze859817222,
z52ab5b652a);z946301ebb2(z3931fc4ce8,zbed769e4d8,z52ab5b652a);z946301ebb2(
z3931fc4ce8,z9d0886a4aa,z52ab5b652a);z946301ebb2(z9d0886a4aa,zbed769e4d8,
z52ab5b652a);return z9d0886a4aa;}__kernel void zf94a20ad81(__global ushort*
zf8d9fd6cb8,__global ushort*z718a062ddd,int8 z30eaaf69b7,int z45c01651ac,int
zb41a4b7008,int4 zf514a4249f,__global ushort*za4c3faf083,int4 zb75ceb4d9a,
__global ushort*z6df6a80d10,int z86949e2bb0){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da
.y>=z30eaaf69b7.s3)return;int2 z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2
zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int2 z001c901e15=zba94ee46da+zf514a4249f
.s01;int2 zd4dfd61c16=zba94ee46da+zb75ceb4d9a.s01;const int za2ebed4c3d=
zf514a4249f.z;const int zec5a718d02=zb75ceb4d9a.z;__global ushort*z6533f4e792=
zf8d9fd6cb8+z83640e5796.x+z83640e5796.y*z45c01651ac;__global ushort*zd30cb40f88=
z718a062ddd+zaaf414d14e.x+zaaf414d14e.y*zb41a4b7008;__global ushort*z9823cd7c39=
za4c3faf083+z001c901e15.x+z001c901e15.y*za2ebed4c3d;__global ushort*z825a8fbc0f=
z6df6a80d10+zd4dfd61c16.x+zd4dfd61c16.y*zec5a718d02;const int x=0;const int y=0;


int z4a54640119=convert_int(z6533f4e792[y*z45c01651ac+x]);int z7b178de028=
convert_int(z9823cd7c39[y*za2ebed4c3d+x]);
if(z86949e2bb0==4){int z4633c865c6=z7b178de028;if(z4a54640119!=z7b178de028)
z4633c865c6=convert_int(z825a8fbc0f[y*zec5a718d02+x]);zd30cb40f88[y*zb41a4b7008+
x]=convert_ushort(z4633c865c6);return;
}
int zc7afd6465e=0;int z0cfa73672c=0;for(int zbdb4f199ce=-1;zbdb4f199ce<=1;
zbdb4f199ce++){for(int z5fa3549b57=-1;z5fa3549b57<=1;z5fa3549b57++){int
z4a54640119=z6533f4e792[(y+zbdb4f199ce)*z45c01651ac+x+z5fa3549b57];int
z7b178de028=z9823cd7c39[(y+zbdb4f199ce)*za2ebed4c3d+x+z5fa3549b57];if(
z7b178de028>z4a54640119)zc7afd6465e+=z7b178de028-z4a54640119;if(z7b178de028<
z4a54640119)z0cfa73672c+=z7b178de028-z4a54640119;}}int z28bb02c08c=z6533f4e792[y
*z45c01651ac+x-2];int z094e61980f=z9823cd7c39[y*za2ebed4c3d+x-2];if(z094e61980f>
z28bb02c08c)zc7afd6465e+=z094e61980f-z28bb02c08c;if(z094e61980f<z28bb02c08c)
z0cfa73672c+=z094e61980f-z28bb02c08c;int z3198367bab=z6533f4e792[y*z45c01651ac+x
+2];int z743354ab3b=z9823cd7c39[y*za2ebed4c3d+x+2];if(z743354ab3b>z3198367bab)
zc7afd6465e+=z743354ab3b-z3198367bab;if(z743354ab3b<z3198367bab)z0cfa73672c+=
z743354ab3b-z3198367bab;
zc7afd6465e=(zc7afd6465e+2)/4;z0cfa73672c=(z0cfa73672c-2)/4;if(z0cfa73672c==0&&
zc7afd6465e==0){zd30cb40f88[y*zb41a4b7008+x]=z7b178de028;return;
}
int z57cb0e2f84=z825a8fbc0f[y*zec5a718d02+x-6];int z43989b7ef0=z825a8fbc0f[y*
zec5a718d02+x-4];int zdd23e04dee=z825a8fbc0f[y*zec5a718d02+x-2];int zd7dce79b23=
z825a8fbc0f[y*zec5a718d02+x];int z4597ef333d=z825a8fbc0f[y*zec5a718d02+x+2];int
z9ea543b11f=z825a8fbc0f[y*zec5a718d02+x+4];int za66b8e7b42=z825a8fbc0f[y*
zec5a718d02+x+6];
int z5cd989328f=zd7dce79b23;do{

int z9e113bd0bd=(zd7dce79b23*60)/64;int zf86c6ec234=(zd7dce79b23*68)/64;
if(zdd23e04dee<z9e113bd0bd||zdd23e04dee>zf86c6ec234||z4597ef333d<z9e113bd0bd||
z4597ef333d>zf86c6ec234)break;
if(z43989b7ef0<z9e113bd0bd||z43989b7ef0>zf86c6ec234||z9ea543b11f<z9e113bd0bd||
z9ea543b11f>zf86c6ec234){z5cd989328f=ze68b1201ae(zdd23e04dee,zd7dce79b23,
z4597ef333d);break;}
if(z57cb0e2f84<z9e113bd0bd||z57cb0e2f84>zf86c6ec234||za66b8e7b42<z9e113bd0bd||
za66b8e7b42>zf86c6ec234){z5cd989328f=z150bc123ee(z43989b7ef0,zdd23e04dee,
zd7dce79b23,z4597ef333d,z9ea543b11f);break;}
z5cd989328f=z72877633f9(z57cb0e2f84,z43989b7ef0,zdd23e04dee,zd7dce79b23,
z4597ef333d,z9ea543b11f,za66b8e7b42);}while(0);int zc3f8e43966=z5cd989328f-
zd7dce79b23;
if(zc3f8e43966<z0cfa73672c)zc3f8e43966=z0cfa73672c;if(zc3f8e43966>zc7afd6465e)
zc3f8e43966=zc7afd6465e;
int z9e729193d6=z7b178de028+zc3f8e43966;if(z9e729193d6<0)z9e729193d6=0;if(
z9e729193d6>65535)z9e729193d6=65535;zd30cb40f88[y*zb41a4b7008+x]=z9e729193d6;
if(z86949e2bb0==5)zd30cb40f88[y*zb41a4b7008+x]=z5cd989328f;

}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
