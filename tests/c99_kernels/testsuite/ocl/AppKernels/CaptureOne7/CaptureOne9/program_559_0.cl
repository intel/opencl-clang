#define z164047dc0a 21
#define ze78198c35f 1
#define z8b6bce8773 1
#define z370db0e88a 1
#define zbc6516e8d5 0

#ifndef ze78198c35f
#define ze78198c35f 0
#endif
#ifndef zbc6516e8d5
#define zbc6516e8d5 0
#endif
#ifndef z370db0e88a
#define z370db0e88a 0
#endif
#ifndef z164047dc0a
#define z164047dc0a 5
#endif
#ifndef zc14a71b5d0
#define zc14a71b5d0 0
#endif
#ifdef ze9fed095f7
#define z6b86550a5e ze9fed095f7
#define z335bcfbc77 float
#define ze610541d08 zaede7752ba
#define z716bd44946 1
#else
#if zc14a71b5d0
#define z6b86550a5e float4
#define ze610541d08 float
#define z716bd44946 4
#else
#if ze78198c35f
#define z6b86550a5e float4
#define ze610541d08 float4
#define z716bd44946 1
#else
#define z6b86550a5e float
#define ze610541d08 float
#define z716bd44946 1
#endif
#endif
#define z335bcfbc77 ze610541d08
#define zc4eb78778c
#endif
#if (z164047dc0a>32)
#undef zbc6516e8d5
#define zbc6516e8d5 0
#endif
void z1c06a63f34(__local ze610541d08*zf485e5e12c,int ze12af1c5cf,__global
z6b86550a5e*zf8d9fd6cb8,int zc9d655d235){
#if 0
float4 z493deefb55;z493deefb55.x=zf8d9fd6cb8[zc9d655d235];z493deefb55.y=
zf8d9fd6cb8[zc9d655d235+1];z493deefb55.z=zf8d9fd6cb8[zc9d655d235+2];float4
zf49d599761=pow(z493deefb55/65535.0f,(float4)(1.8f,1.8f,1.8f,1.8f));float
z498bde0636=zec15f7fa83(zf49d599761);float z045b183f80=pow(z498bde0636,1.0f/2.2f
);zf485e5e12c[ze12af1c5cf]=z045b183f80;
#else
#if zc14a71b5d0
zf485e5e12c[ze12af1c5cf]=zf8d9fd6cb8[zc9d655d235].y;
#else
zf485e5e12c[ze12af1c5cf]=zf8d9fd6cb8[zc9d655d235];
#endif
#endif
}
#ifdef ze9fed095f7
#define zab67f6b64e(z493deefb55) convert_float(z493deefb55)
#else
#define zab67f6b64e(z493deefb55) z493deefb55
#endif
#if (zc14a71b5d0 && !zbc6516e8d5)
#undef zab67f6b64e
#define zab67f6b64e(z493deefb55) z493deefb55.y
#endif
#if z370db0e88a
typedef int8 z885654560c;
#else
typedef int4 z885654560c;
#endif
#define z9d76d2f2e7(z1d8bd19892) ( zab67f6b64e(zf485e5e12c[z38a89f6944-(\
z1d8bd19892)*z8ea92fe60a] ) + zab67f6b64e(zf485e5e12c[z38a89f6944+(z1d8bd19892)*\
z8ea92fe60a] ) )

__kernel void z2c7c072bf4(__global z6b86550a5e*zf8d9fd6cb8,__global ze610541d08*
z718a062ddd,z885654560c z30eaaf69b7,int z021babbfad,int z958df11031,float16
z6c760cbdc8
#if (z164047dc0a>15)
,float16 z381d9cf8f3
#endif
#if (z164047dc0a>31)
,float16 zf17a9262a6
#endif
#if (z164047dc0a>47)
,float16 z783e1b2966
#endif
#if (z164047dc0a>63)
,float16 z8091636af8
#endif
#if (z164047dc0a>79)
,float16 z9df40b9b3b
#endif
#if (z164047dc0a>95)
,float16 za858c1ee48
#endif
#if (z164047dc0a>111)
,float16 ze29c80eb62
#endif
#if zbc6516e8d5
,__local ze610541d08*z01612e015a
#endif
){int2 z945895b462=(int2)(get_global_id(0),get_global_id(1));int2 zba94ee46da=
z945895b462+z30eaaf69b7.s01;
#if z370db0e88a
int2 z83640e5796=z945895b462+z30eaaf69b7.s45;
#else
int2 z83640e5796=zba94ee46da;
#endif
#ifdef z8b6bce8773
int z47728d2efe=get_local_size(1);int z3902475141=get_local_size(0);
#else
int z47728d2efe=get_local_size(0);int z3902475141=get_local_size(1);
#endif
int z62a8006ca5=(z47728d2efe+2*(z164047dc0a));
int zc9d655d235=z83640e5796.x+z83640e5796.y*(z021babbfad/z716bd44946);
#ifdef z8b6bce8773
int z13d44342d1=get_local_id(0);int z38a89f6944=get_local_id(1);int zb3ec2e5425=
z021babbfad;bool zc80cdffc13=(z945895b462.x>=z30eaaf69b7.s2||z945895b462.y>=
z30eaaf69b7.s3+2*z164047dc0a);
#else
int z13d44342d1=get_local_id(1);int z38a89f6944=get_local_id(0);int zb3ec2e5425=
1;bool zc80cdffc13=(z945895b462.x>=z30eaaf69b7.s2+2*z164047dc0a||z945895b462.y>=
z30eaaf69b7.s3);
#endif
#if zbc6516e8d5
__local ze610541d08*zf485e5e12c=z01612e015a+z13d44342d1*z62a8006ca5+(z164047dc0a
);int ze12af1c5cf=z38a89f6944;if(!zc80cdffc13)z1c06a63f34(zf485e5e12c,
ze12af1c5cf,zf8d9fd6cb8,zc9d655d235);if(z38a89f6944<z164047dc0a&&!zc80cdffc13)
z1c06a63f34(zf485e5e12c,ze12af1c5cf-z164047dc0a,zf8d9fd6cb8,zc9d655d235-
zb3ec2e5425*z164047dc0a);if(z38a89f6944>=z47728d2efe-z164047dc0a&&!zc80cdffc13)
z1c06a63f34(zf485e5e12c,ze12af1c5cf+z164047dc0a,zf8d9fd6cb8,zc9d655d235+
zb3ec2e5425*z164047dc0a);int z8ea92fe60a=1;barrier(CLK_LOCAL_MEM_FENCE);
#else
int z8ea92fe60a=zb3ec2e5425;z38a89f6944=zc9d655d235;__global z6b86550a5e*
zf485e5e12c=zf8d9fd6cb8;
#endif
if(z945895b462.x>=z30eaaf69b7.s2||z945895b462.y>=z30eaaf69b7.s3)return;
z335bcfbc77 z9697e8d76f;z9697e8d76f=zab67f6b64e(zf485e5e12c[z38a89f6944]);
#if z164047dc0a>0
z9697e8d76f*=(z335bcfbc77)z6c760cbdc8.s0;z9697e8d76f+=z6c760cbdc8.s1*z9d76d2f2e7
(1);
#endif
#if z164047dc0a>1
z9697e8d76f+=z6c760cbdc8.s2*z9d76d2f2e7(2);
#endif
#if z164047dc0a>2
z9697e8d76f+=z6c760cbdc8.s3*(zab67f6b64e(zf485e5e12c[z38a89f6944-3*z8ea92fe60a])
+zab67f6b64e(zf485e5e12c[z38a89f6944+3*z8ea92fe60a]));
#endif
#if z164047dc0a>3
z9697e8d76f+=z6c760cbdc8.s4*(zab67f6b64e(zf485e5e12c[z38a89f6944-4*z8ea92fe60a])
+zab67f6b64e(zf485e5e12c[z38a89f6944+4*z8ea92fe60a]));
#endif
#if z164047dc0a>4
z9697e8d76f+=z6c760cbdc8.s5*(zab67f6b64e(zf485e5e12c[z38a89f6944-5*z8ea92fe60a])
+zab67f6b64e(zf485e5e12c[z38a89f6944+5*z8ea92fe60a]));
#endif
#if z164047dc0a>5
z9697e8d76f+=z6c760cbdc8.s6*(zab67f6b64e(zf485e5e12c[z38a89f6944-6*z8ea92fe60a])
+zab67f6b64e(zf485e5e12c[z38a89f6944+6*z8ea92fe60a]));
#endif
#if z164047dc0a>6
z9697e8d76f+=z6c760cbdc8.s7*(zab67f6b64e(zf485e5e12c[z38a89f6944-7*z8ea92fe60a])
+zab67f6b64e(zf485e5e12c[z38a89f6944+7*z8ea92fe60a]));
#endif
#if z164047dc0a>7
z9697e8d76f+=z6c760cbdc8.s8*(zab67f6b64e(zf485e5e12c[z38a89f6944-8*z8ea92fe60a])
+zab67f6b64e(zf485e5e12c[z38a89f6944+8*z8ea92fe60a]));
#endif
#if z164047dc0a>8
z9697e8d76f+=z6c760cbdc8.s9*(zab67f6b64e(zf485e5e12c[z38a89f6944-9*z8ea92fe60a])
+zab67f6b64e(zf485e5e12c[z38a89f6944+9*z8ea92fe60a]));
#endif
#if z164047dc0a>9
z9697e8d76f+=z6c760cbdc8.sa*(zab67f6b64e(zf485e5e12c[z38a89f6944-10*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+10*z8ea92fe60a]));
#endif
#if z164047dc0a>10
z9697e8d76f+=z6c760cbdc8.sb*(zab67f6b64e(zf485e5e12c[z38a89f6944-11*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+11*z8ea92fe60a]));
#endif
#if z164047dc0a>11
z9697e8d76f+=z6c760cbdc8.sc*(zab67f6b64e(zf485e5e12c[z38a89f6944-12*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+12*z8ea92fe60a]));
#endif
#if z164047dc0a>12
z9697e8d76f+=z6c760cbdc8.sd*(zab67f6b64e(zf485e5e12c[z38a89f6944-13*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+13*z8ea92fe60a]));
#endif
#if z164047dc0a>13
z9697e8d76f+=z6c760cbdc8.se*(zab67f6b64e(zf485e5e12c[z38a89f6944-14*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+14*z8ea92fe60a]));
#endif
#if z164047dc0a>14
z9697e8d76f+=z6c760cbdc8.sf*(zab67f6b64e(zf485e5e12c[z38a89f6944-15*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+15*z8ea92fe60a]));
#endif
#if z164047dc0a>15
z9697e8d76f+=z381d9cf8f3.s0*(zab67f6b64e(zf485e5e12c[z38a89f6944-16*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+16*z8ea92fe60a]));
#endif
#if (z164047dc0a>16)
z9697e8d76f+=z381d9cf8f3.s1*(zab67f6b64e(zf485e5e12c[z38a89f6944-17*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+17*z8ea92fe60a]));
#endif
#if (z164047dc0a>17)
z9697e8d76f+=z381d9cf8f3.s2*(zab67f6b64e(zf485e5e12c[z38a89f6944-18*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+18*z8ea92fe60a]));
#endif
#if (z164047dc0a>18)
z9697e8d76f+=z381d9cf8f3.s3*(zab67f6b64e(zf485e5e12c[z38a89f6944-19*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+19*z8ea92fe60a]));
#endif
#if (z164047dc0a>19)
z9697e8d76f+=z381d9cf8f3.s4*(zab67f6b64e(zf485e5e12c[z38a89f6944-20*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+20*z8ea92fe60a]));
#endif
#if (z164047dc0a>20)
z9697e8d76f+=z381d9cf8f3.s5*(zab67f6b64e(zf485e5e12c[z38a89f6944-21*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+21*z8ea92fe60a]));
#endif
#if (z164047dc0a>21)
z9697e8d76f+=z381d9cf8f3.s6*(zab67f6b64e(zf485e5e12c[z38a89f6944-22*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+22*z8ea92fe60a]));
#endif
#if (z164047dc0a>22)
z9697e8d76f+=z381d9cf8f3.s7*(zab67f6b64e(zf485e5e12c[z38a89f6944-23*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+23*z8ea92fe60a]));
#endif
#if (z164047dc0a>23)
z9697e8d76f+=z381d9cf8f3.s8*(zab67f6b64e(zf485e5e12c[z38a89f6944-24*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+24*z8ea92fe60a]));
#endif
#if (z164047dc0a>24)
z9697e8d76f+=z381d9cf8f3.s9*(zab67f6b64e(zf485e5e12c[z38a89f6944-25*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+25*z8ea92fe60a]));
#endif
#if (z164047dc0a>25)
z9697e8d76f+=z381d9cf8f3.sa*(zab67f6b64e(zf485e5e12c[z38a89f6944-26*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+26*z8ea92fe60a]));
#endif
#if (z164047dc0a>26)
z9697e8d76f+=z381d9cf8f3.sb*(zab67f6b64e(zf485e5e12c[z38a89f6944-27*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+27*z8ea92fe60a]));
#endif
#if (z164047dc0a>27)
z9697e8d76f+=z381d9cf8f3.sc*(zab67f6b64e(zf485e5e12c[z38a89f6944-28*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+28*z8ea92fe60a]));
#endif
#if (z164047dc0a>28)
z9697e8d76f+=z381d9cf8f3.sd*(zab67f6b64e(zf485e5e12c[z38a89f6944-29*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+29*z8ea92fe60a]));
#endif
#if (z164047dc0a>29)
z9697e8d76f+=z381d9cf8f3.se*(zab67f6b64e(zf485e5e12c[z38a89f6944-30*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+30*z8ea92fe60a]));
#endif
#if (z164047dc0a>30)
z9697e8d76f+=z381d9cf8f3.sf*(zab67f6b64e(zf485e5e12c[z38a89f6944-31*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+31*z8ea92fe60a]));
#endif
#if (z164047dc0a>31)
z9697e8d76f+=zf17a9262a6.s0*(zab67f6b64e(zf485e5e12c[z38a89f6944-32*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+32*z8ea92fe60a]));
#endif
#if (z164047dc0a>32)
z9697e8d76f+=zf17a9262a6.s1*(zab67f6b64e(zf485e5e12c[z38a89f6944-33*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+33*z8ea92fe60a]));
#endif
#if (z164047dc0a>33)
z9697e8d76f+=zf17a9262a6.s2*(zab67f6b64e(zf485e5e12c[z38a89f6944-34*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+34*z8ea92fe60a]));
#endif
#if (z164047dc0a>34)
z9697e8d76f+=zf17a9262a6.s3*(zab67f6b64e(zf485e5e12c[z38a89f6944-35*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+35*z8ea92fe60a]));
#endif
#if (z164047dc0a>35)
z9697e8d76f+=zf17a9262a6.s4*(zab67f6b64e(zf485e5e12c[z38a89f6944-36*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+36*z8ea92fe60a]));
#endif
#if (z164047dc0a>36)
z9697e8d76f+=zf17a9262a6.s5*(zab67f6b64e(zf485e5e12c[z38a89f6944-37*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+37*z8ea92fe60a]));
#endif
#if (z164047dc0a>37)
z9697e8d76f+=zf17a9262a6.s6*(zab67f6b64e(zf485e5e12c[z38a89f6944-38*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+38*z8ea92fe60a]));
#endif
#if (z164047dc0a>38)
z9697e8d76f+=zf17a9262a6.s7*(zab67f6b64e(zf485e5e12c[z38a89f6944-39*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+39*z8ea92fe60a]));
#endif
#if (z164047dc0a>39)
z9697e8d76f+=zf17a9262a6.s8*(zab67f6b64e(zf485e5e12c[z38a89f6944-40*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+40*z8ea92fe60a]));
#endif
#if (z164047dc0a>40)
z9697e8d76f+=zf17a9262a6.s9*(zab67f6b64e(zf485e5e12c[z38a89f6944-41*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+41*z8ea92fe60a]));
#endif
#if (z164047dc0a>41)
z9697e8d76f+=zf17a9262a6.sa*(zab67f6b64e(zf485e5e12c[z38a89f6944-42*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+42*z8ea92fe60a]));
#endif
#if (z164047dc0a>42)
z9697e8d76f+=zf17a9262a6.sb*(zab67f6b64e(zf485e5e12c[z38a89f6944-43*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+43*z8ea92fe60a]));
#endif
#if (z164047dc0a>43)
z9697e8d76f+=zf17a9262a6.sc*(zab67f6b64e(zf485e5e12c[z38a89f6944-44*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+44*z8ea92fe60a]));
#endif
#if (z164047dc0a>44)
z9697e8d76f+=zf17a9262a6.sd*(zab67f6b64e(zf485e5e12c[z38a89f6944-45*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+45*z8ea92fe60a]));
#endif
#if (z164047dc0a>45)
z9697e8d76f+=zf17a9262a6.se*(zab67f6b64e(zf485e5e12c[z38a89f6944-46*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+46*z8ea92fe60a]));
#endif
#if (z164047dc0a>46)
z9697e8d76f+=zf17a9262a6.sf*(zab67f6b64e(zf485e5e12c[z38a89f6944-47*z8ea92fe60a]
)+zab67f6b64e(zf485e5e12c[z38a89f6944+47*z8ea92fe60a]));
#endif

#if (z164047dc0a>47)
z9697e8d76f+=z783e1b2966.s0*z9d76d2f2e7(48);
#endif
#if (z164047dc0a>48)
z9697e8d76f+=z783e1b2966.s1*z9d76d2f2e7(49);
#endif
#if (z164047dc0a>16+33)
z9697e8d76f+=z783e1b2966.s2*z9d76d2f2e7(50);
#endif
#if (z164047dc0a>16+34)
z9697e8d76f+=z783e1b2966.s3*z9d76d2f2e7(51);
#endif
#if (z164047dc0a>16+35)
z9697e8d76f+=z783e1b2966.s4*z9d76d2f2e7(52);
#endif
#if (z164047dc0a>16+36)
z9697e8d76f+=z783e1b2966.s5*z9d76d2f2e7(53);
#endif
#if (z164047dc0a>16+37)
z9697e8d76f+=z783e1b2966.s6*z9d76d2f2e7(54);
#endif
#if (z164047dc0a>16+38)
z9697e8d76f+=z783e1b2966.s7*z9d76d2f2e7(55);
#endif
#if (z164047dc0a>16+39)
z9697e8d76f+=z783e1b2966.s8*z9d76d2f2e7(56);
#endif
#if (z164047dc0a>16+40)
z9697e8d76f+=z783e1b2966.s9*z9d76d2f2e7(57);
#endif
#if (z164047dc0a>16+41)
z9697e8d76f+=z783e1b2966.sa*z9d76d2f2e7(58);
#endif
#if (z164047dc0a>16+42)
z9697e8d76f+=z783e1b2966.sb*z9d76d2f2e7(59);
#endif
#if (z164047dc0a>16+43)
z9697e8d76f+=z783e1b2966.sc*z9d76d2f2e7(60);
#endif
#if (z164047dc0a>16+44)
z9697e8d76f+=z783e1b2966.sd*z9d76d2f2e7(61);
#endif
#if (z164047dc0a>16+45)
z9697e8d76f+=z783e1b2966.se*z9d76d2f2e7(62);
#endif
#if (z164047dc0a>16+46)
z9697e8d76f+=z783e1b2966.sf*z9d76d2f2e7(63);
#endif

#if (z164047dc0a>32+31)
z9697e8d76f+=z8091636af8.s0*z9d76d2f2e7(32+32);
#endif
#if (z164047dc0a>32+32)
z9697e8d76f+=z8091636af8.s1*z9d76d2f2e7(32+33);
#endif
#if (z164047dc0a>32+33)
z9697e8d76f+=z8091636af8.s2*z9d76d2f2e7(32+34);
#endif
#if (z164047dc0a>32+34)
z9697e8d76f+=z8091636af8.s3*z9d76d2f2e7(32+35);
#endif
#if (z164047dc0a>32+35)
z9697e8d76f+=z8091636af8.s4*z9d76d2f2e7(32+36);
#endif
#if (z164047dc0a>32+36)
z9697e8d76f+=z8091636af8.s5*z9d76d2f2e7(32+37);
#endif
#if (z164047dc0a>32+37)
z9697e8d76f+=z8091636af8.s6*z9d76d2f2e7(32+38);
#endif
#if (z164047dc0a>32+38)
z9697e8d76f+=z8091636af8.s7*z9d76d2f2e7(32+39);
#endif
#if (z164047dc0a>32+39)
z9697e8d76f+=z8091636af8.s8*z9d76d2f2e7(32+40);
#endif
#if (z164047dc0a>32+40)
z9697e8d76f+=z8091636af8.s9*z9d76d2f2e7(32+41);
#endif
#if (z164047dc0a>32+41)
z9697e8d76f+=z8091636af8.sa*z9d76d2f2e7(32+42);
#endif
#if (z164047dc0a>32+42)
z9697e8d76f+=z8091636af8.sb*z9d76d2f2e7(32+43);
#endif
#if (z164047dc0a>32+43)
z9697e8d76f+=z8091636af8.sc*z9d76d2f2e7(32+44);
#endif
#if (z164047dc0a>32+44)
z9697e8d76f+=z8091636af8.sd*z9d76d2f2e7(32+45);
#endif
#if (z164047dc0a>32+45)
z9697e8d76f+=z8091636af8.se*z9d76d2f2e7(32+46);
#endif
#if (z164047dc0a>32+46)
z9697e8d76f+=z8091636af8.sf*z9d76d2f2e7(32+47);
#endif

#if (z164047dc0a>48+31)
z9697e8d76f+=z9df40b9b3b.s0*z9d76d2f2e7(48+32);
#endif
#if (z164047dc0a>48+32)
z9697e8d76f+=z9df40b9b3b.s1*z9d76d2f2e7(48+33);
#endif
#if (z164047dc0a>48+33)
z9697e8d76f+=z9df40b9b3b.s2*z9d76d2f2e7(48+34);
#endif
#if (z164047dc0a>48+34)
z9697e8d76f+=z9df40b9b3b.s3*z9d76d2f2e7(48+35);
#endif
#if (z164047dc0a>48+35)
z9697e8d76f+=z9df40b9b3b.s4*z9d76d2f2e7(48+36);
#endif
#if (z164047dc0a>48+36)
z9697e8d76f+=z9df40b9b3b.s5*z9d76d2f2e7(48+37);
#endif
#if (z164047dc0a>48+37)
z9697e8d76f+=z9df40b9b3b.s6*z9d76d2f2e7(48+38);
#endif
#if (z164047dc0a>48+38)
z9697e8d76f+=z9df40b9b3b.s7*z9d76d2f2e7(48+39);
#endif
#if (z164047dc0a>48+39)
z9697e8d76f+=z9df40b9b3b.s8*z9d76d2f2e7(48+40);
#endif
#if (z164047dc0a>48+40)
z9697e8d76f+=z9df40b9b3b.s9*z9d76d2f2e7(48+41);
#endif
#if (z164047dc0a>48+41)
z9697e8d76f+=z9df40b9b3b.sa*z9d76d2f2e7(48+42);
#endif
#if (z164047dc0a>48+42)
z9697e8d76f+=z9df40b9b3b.sb*z9d76d2f2e7(48+43);
#endif
#if (z164047dc0a>48+43)
z9697e8d76f+=z9df40b9b3b.sc*z9d76d2f2e7(48+44);
#endif
#if (z164047dc0a>48+44)
z9697e8d76f+=z9df40b9b3b.sd*z9d76d2f2e7(48+45);
#endif
#if (z164047dc0a>48+45)
z9697e8d76f+=z9df40b9b3b.se*z9d76d2f2e7(48+46);
#endif
#if (z164047dc0a>48+46)
z9697e8d76f+=z9df40b9b3b.sf*z9d76d2f2e7(48+47);
#endif

#if (z164047dc0a>64+31)
z9697e8d76f+=za858c1ee48.s0*z9d76d2f2e7(64+32);
#endif
#if (z164047dc0a>64+32)
z9697e8d76f+=za858c1ee48.s1*z9d76d2f2e7(64+33);
#endif
#if (z164047dc0a>64+33)
z9697e8d76f+=za858c1ee48.s2*z9d76d2f2e7(64+34);
#endif
#if (z164047dc0a>64+34)
z9697e8d76f+=za858c1ee48.s3*z9d76d2f2e7(64+35);
#endif
#if (z164047dc0a>64+35)
z9697e8d76f+=za858c1ee48.s4*z9d76d2f2e7(64+36);
#endif
#if (z164047dc0a>64+36)
z9697e8d76f+=za858c1ee48.s5*z9d76d2f2e7(64+37);
#endif
#if (z164047dc0a>64+37)
z9697e8d76f+=za858c1ee48.s6*z9d76d2f2e7(64+38);
#endif
#if (z164047dc0a>64+38)
z9697e8d76f+=za858c1ee48.s7*z9d76d2f2e7(64+39);
#endif
#if (z164047dc0a>64+39)
z9697e8d76f+=za858c1ee48.s8*z9d76d2f2e7(64+40);
#endif
#if (z164047dc0a>64+40)
z9697e8d76f+=za858c1ee48.s9*z9d76d2f2e7(64+41);
#endif
#if (z164047dc0a>64+41)
z9697e8d76f+=za858c1ee48.sa*z9d76d2f2e7(64+42);
#endif
#if (z164047dc0a>64+42)
z9697e8d76f+=za858c1ee48.sb*z9d76d2f2e7(64+43);
#endif
#if (z164047dc0a>64+43)
z9697e8d76f+=za858c1ee48.sc*z9d76d2f2e7(64+44);
#endif
#if (z164047dc0a>64+44)
z9697e8d76f+=za858c1ee48.sd*z9d76d2f2e7(64+45);
#endif
#if (z164047dc0a>64+45)
z9697e8d76f+=za858c1ee48.se*z9d76d2f2e7(64+46);
#endif
#if (z164047dc0a>64+46)
z9697e8d76f+=za858c1ee48.sf*z9d76d2f2e7(64+47);
#endif

#if (z164047dc0a>80+31)
z9697e8d76f+=ze29c80eb62.s0*z9d76d2f2e7(80+32);
#endif
#if (z164047dc0a>80+32)
z9697e8d76f+=ze29c80eb62.s1*z9d76d2f2e7(80+33);
#endif
#if (z164047dc0a>80+33)
z9697e8d76f+=ze29c80eb62.s2*z9d76d2f2e7(80+34);
#endif
#if (z164047dc0a>80+34)
z9697e8d76f+=ze29c80eb62.s3*z9d76d2f2e7(80+35);
#endif
#if (z164047dc0a>80+35)
z9697e8d76f+=ze29c80eb62.s4*z9d76d2f2e7(80+36);
#endif
#if (z164047dc0a>80+36)
z9697e8d76f+=ze29c80eb62.s5*z9d76d2f2e7(80+37);
#endif
#if (z164047dc0a>80+37)
z9697e8d76f+=ze29c80eb62.s6*z9d76d2f2e7(80+38);
#endif
#if (z164047dc0a>80+38)
z9697e8d76f+=ze29c80eb62.s7*z9d76d2f2e7(80+39);
#endif
#if (z164047dc0a>80+39)
z9697e8d76f+=ze29c80eb62.s8*z9d76d2f2e7(80+40);
#endif
#if (z164047dc0a>80+40)
z9697e8d76f+=ze29c80eb62.s9*z9d76d2f2e7(80+41);
#endif
#if (z164047dc0a>80+41)
z9697e8d76f+=ze29c80eb62.sa*z9d76d2f2e7(80+42);
#endif
#if (z164047dc0a>80+42)
z9697e8d76f+=ze29c80eb62.sb*z9d76d2f2e7(80+43);
#endif
#if (z164047dc0a>80+43)
z9697e8d76f+=ze29c80eb62.sc*z9d76d2f2e7(80+44);
#endif
#if (z164047dc0a>80+44)
z9697e8d76f+=ze29c80eb62.sd*z9d76d2f2e7(80+45);
#endif
#if (z164047dc0a>80+45)
z9697e8d76f+=ze29c80eb62.se*z9d76d2f2e7(80+46);
#endif
#if (z164047dc0a>80+46)
z9697e8d76f+=ze29c80eb62.sf*z9d76d2f2e7(80+47);
#endif

z718a062ddd[zba94ee46da.x+zba94ee46da.y*z958df11031]=zc4eb78778c(z9697e8d76f);}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
