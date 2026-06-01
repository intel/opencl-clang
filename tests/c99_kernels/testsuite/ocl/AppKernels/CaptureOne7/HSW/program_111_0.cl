#define zbc6516e8d5 1

#ifndef zbc6516e8d5
#define zbc6516e8d5 1
#endif
float4 z03aeac13a1(float4 z493deefb55){if(z493deefb55.x>=65535.0f||z493deefb55.y
>=65535.0f||z493deefb55.z>=65535.0f){
float z06f2e71fdd=z493deefb55.x;float zac51b39fd1=z493deefb55.y;float
z84b5b281c7=z493deefb55.z;if(z06f2e71fdd>65535.0f)z06f2e71fdd=65535.0f;if(
zac51b39fd1>65535.0f)zac51b39fd1=65535.0f;if(z84b5b281c7>65535.0f)z84b5b281c7=
65535.0f;
float z90e1a42944=(z493deefb55.x+z493deefb55.y+z493deefb55.z)/(z06f2e71fdd+
zac51b39fd1+z84b5b281c7);z493deefb55.x=z06f2e71fdd*z90e1a42944;z493deefb55.y=
zac51b39fd1*z90e1a42944;z493deefb55.z=z84b5b281c7*z90e1a42944;}return
z493deefb55;}
#if zbc6516e8d5
float z9a1a30fb74(__local float*z395b96baac,int z1d8bd19892,int zbced03a0bf,int
z6d30cd5dec,float4 ze83f365f7a)
#else
float z9a1a30fb74(__global float*z395b96baac,int z1d8bd19892,int zbced03a0bf,int
 z6d30cd5dec,float4 ze83f365f7a)
#endif
{float4 zfc397c3985=(float4)z395b96baac[z1d8bd19892];float4 zef38832825=(float4)
(z395b96baac[z1d8bd19892-zbced03a0bf],z395b96baac[z1d8bd19892+3],z395b96baac[
z1d8bd19892-3],z395b96baac[z1d8bd19892+zbced03a0bf]);float4 zf7ee99daeb=(float4)
(z395b96baac[z1d8bd19892-z6d30cd5dec],z395b96baac[z1d8bd19892+6],z395b96baac[
z1d8bd19892-6],z395b96baac[z1d8bd19892+z6d30cd5dec]);float4 z47d9dcfc3f=(
zfc397c3985+zef38832825+zf7ee99daeb)*0.3333f;float4 za108428313=fabs(z47d9dcfc3f
-zfc397c3985)+fabs(z47d9dcfc3f-zef38832825)+fabs(z47d9dcfc3f-zf7ee99daeb);
float zf18f143a6d[4]={za108428313.x,za108428313.y,za108428313.z,za108428313.w};
int z950bbd3d8e=0;for(int z1d8bd19892=1;z1d8bd19892<4;++z1d8bd19892){if(
zf18f143a6d[z1d8bd19892]<zf18f143a6d[z950bbd3d8e])z950bbd3d8e=z1d8bd19892;}int
zbf1bcb5911=1;if(zf18f143a6d[zbf1bcb5911]<=zf18f143a6d[z950bbd3d8e])zbf1bcb5911=
0;for(int z1d8bd19892=0;z1d8bd19892<4;++z1d8bd19892){if(zf18f143a6d[z1d8bd19892]
<zf18f143a6d[zbf1bcb5911]&&z1d8bd19892!=z950bbd3d8e)zbf1bcb5911=z1d8bd19892;}
float z1b92f6c35b[4]={ze83f365f7a.x,ze83f365f7a.y,ze83f365f7a.z,ze83f365f7a.w};
float z2ceefda761=zf18f143a6d[zbf1bcb5911]/(zf18f143a6d[z950bbd3d8e]+zf18f143a6d
[zbf1bcb5911]);
float z96a2929ccd=mix(z1b92f6c35b[z950bbd3d8e],z1b92f6c35b[zbf1bcb5911],
z2ceefda761);return z96a2929ccd;}float z55be8b4cfc(float z2dd09f3226,float
za3158292ce,float ze28128c2dd,float z593fa3cb41){if(fabs(fabs(z2dd09f3226)-fabs(
z593fa3cb41))<fabs(fabs(ze28128c2dd)-fabs(za3158292ce)))return(z2dd09f3226+
z593fa3cb41);else return(ze28128c2dd+za3158292ce);}
void z1c06a63f34(__local float*zf485e5e12c,int z182e74dd31,int zf9f9a2a7f6,
__global float4*zf8d9fd6cb8,int z021babbfad,int z0a187ec7ff,float4 z510a0f1615){
zf485e5e12c[zf9f9a2a7f6]=zf8d9fd6cb8[z0a187ec7ff].x;zf485e5e12c[1+zf9f9a2a7f6]=
zf8d9fd6cb8[z0a187ec7ff].y;zf485e5e12c[2+zf9f9a2a7f6]=zf8d9fd6cb8[z0a187ec7ff].z
;zf485e5e12c[4+zf9f9a2a7f6]=zf8d9fd6cb8[1+z0a187ec7ff].y;zf485e5e12c[1+
zf9f9a2a7f6+z182e74dd31]=zf8d9fd6cb8[z0a187ec7ff+z021babbfad].y;zf485e5e12c[3+
zf9f9a2a7f6+z182e74dd31]=zf8d9fd6cb8[1+z0a187ec7ff+z021babbfad].x;zf485e5e12c[4+
zf9f9a2a7f6+z182e74dd31]=zf8d9fd6cb8[1+z0a187ec7ff+z021babbfad].y;zf485e5e12c[5+
zf9f9a2a7f6+z182e74dd31]=zf8d9fd6cb8[1+z0a187ec7ff+z021babbfad].z;__local float*
z395b96baac=zf485e5e12c+zf9f9a2a7f6;int z45c01651ac=z182e74dd31;z395b96baac[2]*=
z510a0f1615.y;
z395b96baac[1]*=z510a0f1615.y;
z395b96baac[z45c01651ac+3]*=z510a0f1615.y;
z395b96baac[z45c01651ac+4]*=z510a0f1615.y;
z395b96baac[4]*=z510a0f1615.y;
z395b96baac[z45c01651ac+1]*=z510a0f1615.y;
float2 z61a6692f1e=(float2)(z395b96baac[0],z395b96baac[z45c01651ac+5])*
z510a0f1615.xz;float2 zefb03680bd=z61a6692f1e-(float2)(z395b96baac[2],
z395b96baac[z45c01651ac+3]);
float2 z728279fff6=z61a6692f1e-(float2)(z395b96baac[1],z395b96baac[z45c01651ac+4
]);
float2 z7fcd7d3ac3=fabs(zefb03680bd);float2 z129ee17a14=fabs(z728279fff6);float
z739c65fcf1=z129ee17a14.x<z7fcd7d3ac3.x?z728279fff6.x:zefb03680bd.x;float
z09eee172bf=z129ee17a14.y<z7fcd7d3ac3.y?z728279fff6.y:zefb03680bd.y;z395b96baac[
0]=z739c65fcf1;z395b96baac[z45c01651ac+5]=z09eee172bf;}
#if zbc6516e8d5
__kernel void z581c269416(__global float4*zf8d9fd6cb8,__global float4*
z718a062ddd,int4 z30eaaf69b7,uint z021babbfad,uint z958df11031,float zac84e30c58
,float4 z510a0f1615,__local float*zf485e5e12c){int2 z945895b462=(int2)(2*
get_global_id(0),2*get_global_id(1));int2 zba94ee46da=z945895b462+z30eaaf69b7.xy
;int2 z83640e5796=zba94ee46da;z021babbfad/=4;int zc9d655d235=z83640e5796.x+
z83640e5796.y*z021babbfad;
#define z77c9074137 2
int zeb7d0dc4d6=get_local_size(0);int z99db0f6e4c=get_local_size(1);int
z182e74dd31=(3*(2*zeb7d0dc4d6+2*z77c9074137));
int za4829e5199=2*get_local_id(0);int zcf71a4cbd5=2*get_local_id(1);int
z8dd6fa68b0=3*z77c9074137+z77c9074137*z182e74dd31;int ze12af1c5cf=z8dd6fa68b0+3*
za4829e5199+zcf71a4cbd5*z182e74dd31;z1c06a63f34(zf485e5e12c,z182e74dd31,
ze12af1c5cf,zf8d9fd6cb8,z021babbfad,zc9d655d235,z510a0f1615);if(za4829e5199==0)
z1c06a63f34(zf485e5e12c,z182e74dd31,ze12af1c5cf-6,zf8d9fd6cb8,z021babbfad,
zc9d655d235-2,z510a0f1615);if(zcf71a4cbd5==0)z1c06a63f34(zf485e5e12c,z182e74dd31
,ze12af1c5cf-2*z182e74dd31,zf8d9fd6cb8,z021babbfad,zc9d655d235-2*z021babbfad,
z510a0f1615);if(za4829e5199==2*zeb7d0dc4d6-2)z1c06a63f34(zf485e5e12c,z182e74dd31
,ze12af1c5cf+6,zf8d9fd6cb8,z021babbfad,zc9d655d235+2,z510a0f1615);if(zcf71a4cbd5
==2*z99db0f6e4c-2)z1c06a63f34(zf485e5e12c,z182e74dd31,ze12af1c5cf+2*z182e74dd31,
zf8d9fd6cb8,z021babbfad,zc9d655d235+2*z021babbfad,z510a0f1615);if(za4829e5199==2
&&zcf71a4cbd5==2)z1c06a63f34(zf485e5e12c,z182e74dd31,ze12af1c5cf-12-4*
z182e74dd31,zf8d9fd6cb8,z021babbfad,zc9d655d235-4-4*z021babbfad,z510a0f1615);if(
za4829e5199==2*zeb7d0dc4d6-4&&zcf71a4cbd5==2)z1c06a63f34(zf485e5e12c,z182e74dd31
,ze12af1c5cf+12-4*z182e74dd31,zf8d9fd6cb8,z021babbfad,zc9d655d235+4-4*
z021babbfad,z510a0f1615);if(za4829e5199==2&&zcf71a4cbd5==2*z99db0f6e4c-4)
z1c06a63f34(zf485e5e12c,z182e74dd31,ze12af1c5cf-12+4*z182e74dd31,zf8d9fd6cb8,
z021babbfad,zc9d655d235-4+4*z021babbfad,z510a0f1615);if(za4829e5199==2*
zeb7d0dc4d6-4&&zcf71a4cbd5==2*z99db0f6e4c-4)z1c06a63f34(zf485e5e12c,z182e74dd31,
ze12af1c5cf+12+4*z182e74dd31,zf8d9fd6cb8,z021babbfad,zc9d655d235+4+4*z021babbfad
,z510a0f1615);barrier(CLK_LOCAL_MEM_FENCE);__local float*z395b96baac=zf485e5e12c
+3*za4829e5199+zcf71a4cbd5*z182e74dd31;int z45c01651ac=z182e74dd31;
#else
__kernel void z581c269416(__global float*zf8d9fd6cb8,__global float4*z718a062ddd
,int4 z30eaaf69b7,uint z021babbfad,uint z958df11031,float zac84e30c58,float4
z510a0f1615){int2 z945895b462=(int2)(2*get_global_id(0),2*get_global_id(1));int2
 zba94ee46da=z945895b462+z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;int
zc9d655d235=3*z83640e5796.x+z83640e5796.y*z021babbfad;int z8dd6fa68b0=0;__global
 float*z395b96baac=zf8d9fd6cb8+3*z83640e5796.x+z83640e5796.y*z021babbfad;int
z45c01651ac=z021babbfad;
#endif
int z97d338c707=z45c01651ac*2;int z89757ee16d=z45c01651ac*3;int zb41a4b7008=
z958df11031;if(z945895b462.x>=z30eaaf69b7.z||z945895b462.y>=z30eaaf69b7.w)return
;float4 ze83f365f7a;float4 zfc397c3985,zef38832825,zf7ee99daeb;float z0e6ed93c67
=z395b96baac[z8dd6fa68b0+1];float z5c929f7b7d=z395b96baac[z8dd6fa68b0+4];float
z2d54409aa9=z395b96baac[z8dd6fa68b0+z45c01651ac+1];float z936c31ba92=z395b96baac
[z8dd6fa68b0+z45c01651ac+4];
float za2fc668164=z395b96baac[z8dd6fa68b0+0];float ze45e9d2aea;float zb871ae0493
;float zfc9d622ec8;float z9cab6cc4c9=z55be8b4cfc(z395b96baac[z8dd6fa68b0-
z97d338c707],za2fc668164,z395b96baac[z8dd6fa68b0-z97d338c707+6],z395b96baac[
z8dd6fa68b0+6])*0.5f;float ze780a785ac=z55be8b4cfc(z395b96baac[z8dd6fa68b0-6],
z395b96baac[z8dd6fa68b0+z97d338c707-6],za2fc668164,z395b96baac[z8dd6fa68b0+
z97d338c707])*0.5f;zfc9d622ec8=z55be8b4cfc(za2fc668164,z395b96baac[z8dd6fa68b0+
z97d338c707],z395b96baac[z8dd6fa68b0+6],z395b96baac[z8dd6fa68b0+z97d338c707+6])*
0.5f;float z9cd3602670;float z6ec73b5c46;
z9cd3602670=fabs(z9cab6cc4c9-zfc9d622ec8);z6ec73b5c46=fabs(z395b96baac[
z8dd6fa68b0+6]-za2fc668164);

if(fabs(z9cd3602670-z6ec73b5c46)<zac84e30c58&&fabs(za2fc668164-z9cab6cc4c9)>
zac84e30c58){ze83f365f7a.s0=z9cab6cc4c9;ze83f365f7a.s1=z395b96baac[z8dd6fa68b0+6
];ze83f365f7a.s2=za2fc668164;ze83f365f7a.s3=zfc9d622ec8;ze45e9d2aea=z9a1a30fb74(
z395b96baac,4+z8dd6fa68b0,z45c01651ac,z97d338c707,ze83f365f7a);
}else{ze45e9d2aea=z9cd3602670<z6ec73b5c46?z9cab6cc4c9+zfc9d622ec8:z395b96baac[
z8dd6fa68b0+6]+za2fc668164;ze45e9d2aea*=0.5f;}
z9cd3602670=fabs(za2fc668164-z395b96baac[z8dd6fa68b0+z97d338c707]);z6ec73b5c46=
fabs(zfc9d622ec8-ze780a785ac);

if(fabs(z9cd3602670-z6ec73b5c46)<zac84e30c58&&fabs(za2fc668164-ze780a785ac)>
zac84e30c58){ze83f365f7a.s0=za2fc668164;ze83f365f7a.s1=zfc9d622ec8;ze83f365f7a.
s2=ze780a785ac;ze83f365f7a.s3=z395b96baac[z8dd6fa68b0+z97d338c707];zb871ae0493=
z9a1a30fb74(z395b96baac,z45c01651ac+1+z8dd6fa68b0,z45c01651ac,z97d338c707,
ze83f365f7a);
}else{zb871ae0493=z9cd3602670<z6ec73b5c46?za2fc668164+z395b96baac[z8dd6fa68b0+
z97d338c707]:zfc9d622ec8+ze780a785ac;zb871ae0493*=0.5f;}
float z818b092eab;float ze85367d722;float z8e9f11bc1a;float z145c834154=
z395b96baac[z8dd6fa68b0+z45c01651ac+5];float za487bbc2fc=z55be8b4cfc(z395b96baac
[z8dd6fa68b0-z45c01651ac+5],z145c834154,z395b96baac[z8dd6fa68b0-z45c01651ac+11],
z395b96baac[z8dd6fa68b0+z45c01651ac+11])*0.5f;float z4c0d63cefd=z55be8b4cfc(
z395b96baac[z8dd6fa68b0+z45c01651ac-1],z395b96baac[z8dd6fa68b0+z89757ee16d-1],
z145c834154,z395b96baac[z8dd6fa68b0+z89757ee16d+5])*0.5f;z818b092eab=z55be8b4cfc
(z395b96baac[z8dd6fa68b0-z45c01651ac-1],z395b96baac[z8dd6fa68b0+z45c01651ac-1],
z395b96baac[z8dd6fa68b0-z45c01651ac+5],z145c834154)*0.5f;
z9cd3602670=fabs(z395b96baac[z8dd6fa68b0-z45c01651ac+5]-z145c834154);z6ec73b5c46
=fabs(za487bbc2fc-z818b092eab);

if(fabs(z9cd3602670-z6ec73b5c46)<zac84e30c58&&fabs(z818b092eab-za487bbc2fc)>
zac84e30c58){ze83f365f7a.s0=z395b96baac[z8dd6fa68b0-z45c01651ac+5];ze83f365f7a.
s1=za487bbc2fc;ze83f365f7a.s2=z818b092eab;ze83f365f7a.s3=z145c834154;ze85367d722
=z9a1a30fb74(z395b96baac,4+z8dd6fa68b0,z45c01651ac,z97d338c707,ze83f365f7a);
}else{ze85367d722=z9cd3602670<z6ec73b5c46?z395b96baac[z8dd6fa68b0-z45c01651ac+5]
+z145c834154:za487bbc2fc+z818b092eab;ze85367d722*=0.5f;}
z9cd3602670=fabs(z818b092eab-z4c0d63cefd);z6ec73b5c46=fabs(z145c834154-
z395b96baac[z8dd6fa68b0+z45c01651ac-1]);

if(fabs(z9cd3602670-z6ec73b5c46)<zac84e30c58&&fabs(z818b092eab-z145c834154)>
zac84e30c58){ze83f365f7a.s0=z818b092eab;ze83f365f7a.s1=z145c834154;ze83f365f7a.
s2=z395b96baac[z8dd6fa68b0+z45c01651ac-1];ze83f365f7a.s3=z4c0d63cefd;z8e9f11bc1a
=z9a1a30fb74(z395b96baac,z45c01651ac+1+z8dd6fa68b0,z45c01651ac,z97d338c707,
ze83f365f7a);
}else{z8e9f11bc1a=z9cd3602670<z6ec73b5c46?z818b092eab+z4c0d63cefd:z145c834154+
z395b96baac[z8dd6fa68b0+z45c01651ac-1];z8e9f11bc1a*=0.5f;}
za2fc668164=(za2fc668164+z0e6ed93c67);ze45e9d2aea=(ze45e9d2aea+z5c929f7b7d);
zb871ae0493=(zb871ae0493+z2d54409aa9);zfc9d622ec8=(zfc9d622ec8+z936c31ba92);
z818b092eab=(z818b092eab+z0e6ed93c67);ze85367d722=(ze85367d722+z5c929f7b7d);
z8e9f11bc1a=(z8e9f11bc1a+z2d54409aa9);z145c834154=(z145c834154+z936c31ba92);
z718a062ddd[zba94ee46da.x+zba94ee46da.y*(z958df11031/4)]=z03aeac13a1((float4)(
za2fc668164,z0e6ed93c67,z818b092eab,0.0f));z718a062ddd[1+zba94ee46da.x+
zba94ee46da.y*(z958df11031/4)]=z03aeac13a1((float4)(ze45e9d2aea,z5c929f7b7d,
ze85367d722,0.0f));z718a062ddd[zba94ee46da.x+(1+zba94ee46da.y)*(z958df11031/4)]=
z03aeac13a1((float4)(zb871ae0493,z2d54409aa9,z8e9f11bc1a,0.0f));z718a062ddd[1+
zba94ee46da.x+(1+zba94ee46da.y)*(z958df11031/4)]=z03aeac13a1((float4)(
zfc9d622ec8,z936c31ba92,z145c834154,0.0f));}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
