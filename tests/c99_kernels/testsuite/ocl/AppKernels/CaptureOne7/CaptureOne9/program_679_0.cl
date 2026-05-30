#define z3dbd1ff682 0

#define z12cbbf15c0					65535.0f
#define zec15f7fa83(zff400e9e97, z305d891f1d, za3158292ce) (zff400e9e97 * 0.299f\
 + z305d891f1d *  0.587f + za3158292ce *  0.114f)
#define MIN min
#define MAX max
#define zba5c6acf5c fabs
#define z09727749e1 pow
#ifndef z3dbd1ff682
#define z3dbd1ff682 0
#endif
void z9b2bb14f40(float*ze4b052164b,float*z2e91460297,float*z7e674d442a,const
float z86dd029962,const float z2e83c0ac43){const float z37a59f57c4=z86dd029962;
const float za3584c0652=z2e83c0ac43;
const float z08ef030ac3=(z37a59f57c4-za3584c0652)*(1.f-za3584c0652);const float
ze7168fc0b9=(z37a59f57c4-1.f);


*ze4b052164b=za3584c0652+(z08ef030ac3*(*ze4b052164b-za3584c0652))/(z08ef030ac3+
ze7168fc0b9*MAX(0.f,*ze4b052164b-za3584c0652));*z2e91460297=za3584c0652+(
z08ef030ac3*(*z2e91460297-za3584c0652))/(z08ef030ac3+ze7168fc0b9*MAX(0.f,*
z2e91460297-za3584c0652));*z7e674d442a=za3584c0652+(z08ef030ac3*(*z7e674d442a-
za3584c0652))/(z08ef030ac3+ze7168fc0b9*MAX(0.f,*z7e674d442a-za3584c0652));return
;}
#if ( z3dbd1ff682==0 )
__kernel void z81e7c53ee0(__global ushort4*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float16 ze0995e6531
,float8 z73759bbb15){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));
if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7
.s01;const float z7a38bbd129=ze0995e6531.s0;const float zbdf9655391=ze0995e6531.
s1;const float z12ff88c38b=ze0995e6531.s2;const float zcdfc9aee83=ze0995e6531.s3
;const float za976571924=ze0995e6531.s4;const float zb0a79c6874=ze0995e6531.s5;
const float z4aba5001fb=ze0995e6531.s6;const float loG=ze0995e6531.s7;const
float z3b4729962d=ze0995e6531.s8;const float z03677c2d6b=ze0995e6531.s9;const
float zaf22ff8d1c=ze0995e6531.sa;const float zc86dc34be1=ze0995e6531.sb;const
float z196411a672=ze0995e6531.sc;const float ze8e8979cb3=ze0995e6531.sd;const
float z4173c23083=ze0995e6531.se;const float z504aaa19c9=ze0995e6531.sf;const
float zf45a6de2ba=z73759bbb15.s0;const float z5400bf6c30=z73759bbb15.s1;const
float zee383c9280=z73759bbb15.s2;const float z893160dda2=z73759bbb15.s3;const
float zb29420da64=z73759bbb15.s4;const float z8959edc9b0=z73759bbb15.s5;const
float z26703b7deb=z73759bbb15.s6;const float z6dddb2bae0=z73759bbb15.s7;ushort4
z395b96baac=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];



float z447f0a5e7f=z395b96baac.x*(1.f/65535.f);float zc36f1050d5=z395b96baac.y*(
1.f/65535.f);float z734efc75b7=z395b96baac.z*(1.f/65535.f);float ze4b052164b=
z447f0a5e7f;float z2e91460297=zc36f1050d5;float z7e674d442a=z734efc75b7;
float ze2f88ca65c=MAX(zec15f7fa83(z447f0a5e7f,zc36f1050d5,z734efc75b7),
z6dddb2bae0);float zf0a1e896b2=(z447f0a5e7f/ze2f88ca65c);float z2836e3011b=(
zc36f1050d5/ze2f88ca65c);float zd0e5d67024=(z734efc75b7/ze2f88ca65c);
float zcfa0ff05ef=0.f;if(z4173c23083-zc86dc34be1>0.001f){float zd72c7cd02e=
ze2f88ca65c*ze2f88ca65c;
float w=(ze2f88ca65c>zf45a6de2ba)?(z504aaa19c9-ze2f88ca65c)*(1.f/(z504aaa19c9-
zf45a6de2ba)):1.f;float zef32575209=(z7a38bbd129-1.f)*w+1.f;
float zfd87a1f0b2=(zbdf9655391-1.f)*w+1.f;float z1a672a6e0b=(z12ff88c38b-1.f)*w+
1.f;float z8f83964991=MIN(zef32575209,MIN(zfd87a1f0b2,z1a672a6e0b));float
za20d4e555f=zd72c7cd02e*(zef32575209-z8f83964991)*(1.f/z8f83964991)*zf0a1e896b2;
float z1bb646811a=zd72c7cd02e*(zfd87a1f0b2-z8f83964991)*(1.f/z8f83964991)*
z2836e3011b;float zf5d684d711=zd72c7cd02e*(z1a672a6e0b-z8f83964991)*(1.f/
z8f83964991)*zd0e5d67024;
zcfa0ff05ef=zd72c7cd02e;ze4b052164b=ze4b052164b+za20d4e555f;z2e91460297=
z2e91460297+z1bb646811a;z7e674d442a=z7e674d442a+zf5d684d711;}
float z7f77bb9830=0.f;if(ze8e8979cb3-zaf22ff8d1c>0.001f){float zd72c7cd02e=4.f*
ze2f88ca65c*(1.f-ze2f88ca65c);
zd72c7cd02e=zd72c7cd02e*zd72c7cd02e*zd72c7cd02e;
zd72c7cd02e*=0.5f;

z7f77bb9830=zd72c7cd02e;float za20d4e555f=zd72c7cd02e*((zcdfc9aee83-zaf22ff8d1c)
/zaf22ff8d1c)*zf0a1e896b2;float z1bb646811a=zd72c7cd02e*((za976571924-
zaf22ff8d1c)/zaf22ff8d1c)*z2836e3011b;float zf5d684d711=zd72c7cd02e*((
zb0a79c6874-zaf22ff8d1c)/zaf22ff8d1c)*zd0e5d67024;ze4b052164b=ze4b052164b+
za20d4e555f;z2e91460297=z2e91460297+z1bb646811a;z7e674d442a=z7e674d442a+
zf5d684d711;}
float z0e39924154=0.f;if(z196411a672-z03677c2d6b>0.001f){float zd72c7cd02e=(1.f-
ze2f88ca65c)*(1.f-ze2f88ca65c);zd72c7cd02e=zd72c7cd02e*0.5f;float za20d4e555f=(
zd72c7cd02e*((z4aba5001fb-z03677c2d6b)/z03677c2d6b))*zf0a1e896b2;float
z1bb646811a=(zd72c7cd02e*((loG-z03677c2d6b)/z03677c2d6b))*z2836e3011b;float
zf5d684d711=(zd72c7cd02e*((z3b4729962d-z03677c2d6b)/z03677c2d6b))*zd0e5d67024;
z0e39924154=zd72c7cd02e;ze4b052164b=ze4b052164b+za20d4e555f;z2e91460297=
z2e91460297+z1bb646811a;z7e674d442a=z7e674d442a+zf5d684d711;}
{
float zb54a79ca93=zec15f7fa83(ze4b052164b,z2e91460297,z7e674d442a);
ze2f88ca65c+=(z5400bf6c30/65535.f);zb54a79ca93+=(z5400bf6c30/65535.f);float
z86dd029962=ze2f88ca65c/zb54a79ca93;ze4b052164b=ze4b052164b*z86dd029962;
z2e91460297=z2e91460297*z86dd029962;z7e674d442a=z7e674d442a*z86dd029962;}
float z19e9dd86b8=1.f;
if(zba5c6acf5c(zb29420da64-1.f)>0.001f){z19e9dd86b8*=(zb29420da64*z0e39924154+(
1.f-z0e39924154));}
if(zba5c6acf5c(z8959edc9b0-1.f)>0.001f){float z34a5633ad3=z09727749e1(
ze2f88ca65c,z8959edc9b0-1.f);z19e9dd86b8*=z34a5633ad3;}
if(zba5c6acf5c(z26703b7deb-1.f)>0.001f){float zf1396ed097=((ze2f88ca65c-1.f)*
z26703b7deb+1.f)-ze2f88ca65c;zf1396ed097*=zcfa0ff05ef;z19e9dd86b8*=(ze2f88ca65c+
zf1396ed097)*(1.f/MAX(ze2f88ca65c,1e-6f));}
ze4b052164b*=z19e9dd86b8;z2e91460297*=z19e9dd86b8;z7e674d442a*=z19e9dd86b8;
if(ze4b052164b>zf45a6de2ba||z2e91460297>zf45a6de2ba||z7e674d442a>zf45a6de2ba){
float z23c05397a2=(ze4b052164b+z6dddb2bae0)/MIN(ze4b052164b+z6dddb2bae0,
zf45a6de2ba);z23c05397a2=MAX(z23c05397a2,(z2e91460297+z6dddb2bae0)/MIN(
z2e91460297+z6dddb2bae0,zf45a6de2ba));z23c05397a2=MAX(z23c05397a2,(z7e674d442a+
z6dddb2bae0)/MIN(z7e674d442a+z6dddb2bae0,zf45a6de2ba));z9b2bb14f40(&ze4b052164b,
&z2e91460297,&z7e674d442a,z23c05397a2,zee383c9280);}ze4b052164b=MIN(z12cbbf15c0,
ze4b052164b*65535.f+0.5f);z2e91460297=MIN(z12cbbf15c0,z2e91460297*65535.f+0.5f);
z7e674d442a=MIN(z12cbbf15c0,z7e674d442a*65535.f+0.5f);



z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=(ushort4)((ushort)
ze4b052164b,(ushort)z2e91460297,(ushort)z7e674d442a,z395b96baac.w);}
#endif
#if ( z3dbd1ff682==1 )
__kernel void z81e7c53ee0(__global ushort4*zf8d9fd6cb8,__global ushort4*
z718a062ddd,int8 z30eaaf69b7,int z2824fcf57d,int z9562068e13,float16 ze0995e6531
,float4 z73759bbb15){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));
if(zba94ee46da.x>=z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2
z83640e5796=zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7
.s01;const float z7a38bbd129=ze0995e6531.s0;const float zbdf9655391=ze0995e6531.
s1;const float z12ff88c38b=ze0995e6531.s2;const float zcdfc9aee83=ze0995e6531.s3
;const float za976571924=ze0995e6531.s4;const float zb0a79c6874=ze0995e6531.s5;
const float z4aba5001fb=ze0995e6531.s6;const float loG=ze0995e6531.s7;const
float z3b4729962d=ze0995e6531.s8;const float z03677c2d6b=ze0995e6531.s9;const
float zaf22ff8d1c=ze0995e6531.sa;const float zc86dc34be1=ze0995e6531.sb;const
float z196411a672=ze0995e6531.sc;const float ze8e8979cb3=ze0995e6531.sd;const
float z4173c23083=ze0995e6531.se;const float z7ec84e3d89=ze0995e6531.sf;const
float zf45a6de2ba=z73759bbb15.s0;const float z5400bf6c30=z73759bbb15.s1;const
float zee383c9280=z73759bbb15.s2;const float z893160dda2=z73759bbb15.s3;ushort4
z395b96baac=zf8d9fd6cb8[z83640e5796.x+z83640e5796.y*z2824fcf57d];



float z447f0a5e7f=z395b96baac.x*(1.f/65535.f);float zc36f1050d5=z395b96baac.y*(
1.f/65535.f);float z734efc75b7=z395b96baac.z*(1.f/65535.f);float ze4b052164b=
z447f0a5e7f;float z2e91460297=zc36f1050d5;float z7e674d442a=z734efc75b7;
float z5ea709a94f=MAX(z447f0a5e7f,MAX(zc36f1050d5,z734efc75b7));
float zcfa0ff05ef=0.f;{float zd72c7cd02e=z5ea709a94f*z5ea709a94f;float
za20d4e555f=zd72c7cd02e*((z7a38bbd129-zc86dc34be1)*(1.f/zc86dc34be1));float
z1bb646811a=zd72c7cd02e*((zbdf9655391-zc86dc34be1)*(1.f/zc86dc34be1));float
zf5d684d711=zd72c7cd02e*((z12ff88c38b-zc86dc34be1)*(1.f/zc86dc34be1));
zcfa0ff05ef=zd72c7cd02e;ze4b052164b=ze4b052164b+za20d4e555f;z2e91460297=
z2e91460297+z1bb646811a;z7e674d442a=z7e674d442a+zf5d684d711;}
float z7f77bb9830=0.f;{float zd72c7cd02e=4.f*z5ea709a94f*(1.f-z5ea709a94f);
zd72c7cd02e=zd72c7cd02e*zd72c7cd02e*zd72c7cd02e;
zd72c7cd02e*=0.5f;

z7f77bb9830=zd72c7cd02e;float za20d4e555f=zd72c7cd02e*((zcdfc9aee83-zaf22ff8d1c)
/zaf22ff8d1c);float z1bb646811a=zd72c7cd02e*((za976571924-zaf22ff8d1c)/
zaf22ff8d1c);float zf5d684d711=zd72c7cd02e*((zb0a79c6874-zaf22ff8d1c)/
zaf22ff8d1c);ze4b052164b=ze4b052164b+za20d4e555f;z2e91460297=z2e91460297+
z1bb646811a;z7e674d442a=z7e674d442a+zf5d684d711;}
float z0e39924154=0.f;{float zd72c7cd02e=(1.f-z5ea709a94f)*(1.f-z5ea709a94f);
zd72c7cd02e=zd72c7cd02e*0.5f;float za20d4e555f=zd72c7cd02e*((z4aba5001fb-
z03677c2d6b)/z03677c2d6b);float z1bb646811a=zd72c7cd02e*((loG-z03677c2d6b)/
z03677c2d6b);float zf5d684d711=zd72c7cd02e*((z3b4729962d-z03677c2d6b)/
z03677c2d6b);
z0e39924154=zd72c7cd02e;ze4b052164b=ze4b052164b+za20d4e555f;z2e91460297=
z2e91460297+z1bb646811a;z7e674d442a=z7e674d442a+zf5d684d711;}
{float ze2f88ca65c=zec15f7fa83(z447f0a5e7f,zc36f1050d5,z734efc75b7);
float zb54a79ca93=zec15f7fa83(ze4b052164b,z2e91460297,z7e674d442a);

if(zba5c6acf5c(z196411a672-1.f)>0.001f){float z9e55084404=(z196411a672-1.f)*
z0e39924154;ze2f88ca65c+=MAX(0.f,z9e55084404);zb54a79ca93+=MAX(0.f,z9e55084404);
ze4b052164b+=z9e55084404*(z4aba5001fb/z196411a672);z2e91460297+=z9e55084404*(loG
/z196411a672);z7e674d442a+=z9e55084404*(z3b4729962d/z196411a672);}
if(zba5c6acf5c(ze8e8979cb3-1.f)>0.001f){float zddab4e5029=(ze8e8979cb3-1.f)*
z7f77bb9830;
zddab4e5029*=(ze2f88ca65c/MAX(z5ea709a94f,1.f/65535.f));
ze2f88ca65c+=zddab4e5029;}
if(z4173c23083>1.001f){float z08b5412249=(z4173c23083-1.f)*zcfa0ff05ef;
ze4b052164b+=z08b5412249*(z7a38bbd129/z4173c23083);z2e91460297+=z08b5412249*(
zbdf9655391/z4173c23083);z7e674d442a+=z08b5412249*(z12ff88c38b/z4173c23083);}
else if(z4173c23083<0.999f){
float w=zcfa0ff05ef*(ze2f88ca65c*ze2f88ca65c);
float zf1396ed097=((ze2f88ca65c-1.f)*z7ec84e3d89+(z4173c23083*z893160dda2+(1.f-
z893160dda2)))-ze2f88ca65c;zf1396ed097*=w;
{ze4b052164b+=zf1396ed097*((1.f-(z7a38bbd129-zc86dc34be1)/z4173c23083));
z2e91460297+=zf1396ed097*((1.f-(zbdf9655391-zc86dc34be1)/z4173c23083));
z7e674d442a+=zf1396ed097*((1.f-(z12ff88c38b-zc86dc34be1)/z4173c23083));}}
ze2f88ca65c=MAX(0.f,ze2f88ca65c);zb54a79ca93=MAX(0.f,zb54a79ca93);ze4b052164b=
MAX(0.f,ze4b052164b);z2e91460297=MAX(0.f,z2e91460297);z7e674d442a=MAX(0.f,
z7e674d442a);
ze2f88ca65c+=(z5400bf6c30/65535.f);zb54a79ca93+=(z5400bf6c30/65535.f);
float z86dd029962=ze2f88ca65c/zb54a79ca93;ze4b052164b=ze4b052164b*z86dd029962;
z2e91460297=z2e91460297*z86dd029962;z7e674d442a=z7e674d442a*z86dd029962;}
if(ze4b052164b>zf45a6de2ba||z2e91460297>zf45a6de2ba||z7e674d442a>zf45a6de2ba){
const float z997ede1cab=1e-6f;float z23c05397a2=(ze4b052164b+z997ede1cab)/MIN(
ze4b052164b+z997ede1cab,zf45a6de2ba);z23c05397a2=MAX(z23c05397a2,(z2e91460297+
z997ede1cab)/MIN(z2e91460297+z997ede1cab,zf45a6de2ba));z23c05397a2=MAX(
z23c05397a2,(z7e674d442a+z997ede1cab)/MIN(z7e674d442a+z997ede1cab,zf45a6de2ba));
z9b2bb14f40(&ze4b052164b,&z2e91460297,&z7e674d442a,z23c05397a2,zee383c9280);}
ze4b052164b=MIN(z12cbbf15c0,ze4b052164b*65535.f+0.5f);z2e91460297=MIN(
z12cbbf15c0,z2e91460297*65535.f+0.5f);z7e674d442a=MIN(z12cbbf15c0,z7e674d442a*
65535.f+0.5f);



z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=(ushort4)((ushort)
ze4b052164b,(ushort)z2e91460297,(ushort)z7e674d442a,z395b96baac.w);}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
