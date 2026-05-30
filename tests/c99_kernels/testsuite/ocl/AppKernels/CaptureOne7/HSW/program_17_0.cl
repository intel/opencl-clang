typedef ushort z51b7908a0d;typedef int zdba6b93f69;typedef uint za6c557b086;
__kernel void z4e6d4abd39(__global ushort4*z6533f4e792,__global ushort4*
zd30cb40f88,int4 z30eaaf69b7,uint z58c1e26fb1,uint z745057f086,int4 z0d2345ac0b,
int4 z810ee6d0d3,float z6df7ccb0a4,__global z51b7908a0d*z5f01a29db5,int4
za962b1d638){int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));float2
z0223c8cb53=convert_float2((int2)(get_global_id(0),get_global_id(1)));if(
z0223c8cb53.x>=z30eaaf69b7.z||z0223c8cb53.y>=z30eaaf69b7.w)return;zba94ee46da+=
z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;__global z51b7908a0d*z5881fbd8bc=
z5f01a29db5;__global z51b7908a0d*z402831b2a1=z5f01a29db5+1;int z32f37e29d7=
z83640e5796.x;int zbaf2748fed=z83640e5796.y;
zdba6b93f69 zbb645b9c50=z810ee6d0d3.x;
zdba6b93f69 z2cb648a1f3=z810ee6d0d3.y;
zdba6b93f69 z7e2b2d4a24=z810ee6d0d3.z;
zdba6b93f69 za08de3da7f=z810ee6d0d3.w;

int z39f1535455=z0d2345ac0b.x;
int z9528763067=z0d2345ac0b.y;

int zbb8d7369a9=za962b1d638.x;
int z2c03006207=za962b1d638.y;
int z80dd2bd3eb=za962b1d638.z;
int z995f1680f0=za962b1d638.w;


__global ushort4*z395b96baac=z6533f4e792+zbaf2748fed*z58c1e26fb1/4;__global
ushort4*ze4351005bc=zd30cb40f88+zbaf2748fed*z745057f086/4;ushort4 z300bbfbf0b=
z395b96baac[z32f37e29d7];ushort4 z310a4d7815=z300bbfbf0b;
zdba6b93f69 z2a34d91aeb=convert_int((float)(zbaf2748fed+z9528763067)*z6df7ccb0a4
);if(z2a34d91aeb<0)z2a34d91aeb=-z2a34d91aeb;if(z2a34d91aeb>=z995f1680f0)
z2a34d91aeb=(2*z995f1680f0-2)-z2a34d91aeb;z2a34d91aeb+=z2c03006207;
zdba6b93f69 ze21fd04bcf=z2a34d91aeb/za08de3da7f;if(ze21fd04bcf>z2cb648a1f3-2)
ze21fd04bcf=z2cb648a1f3-2;


zdba6b93f69 z911cb3715b=convert_int((float)(z32f37e29d7+z39f1535455)*z6df7ccb0a4
);if(z911cb3715b<0)z911cb3715b=-z911cb3715b;if(z911cb3715b>=z80dd2bd3eb)
z911cb3715b=(z80dd2bd3eb*2-2)-z911cb3715b;z911cb3715b+=zbb8d7369a9;
zdba6b93f69 z6710d89f27=z911cb3715b/z7e2b2d4a24;if(z6710d89f27>zbb645b9c50-2)
z6710d89f27=zbb645b9c50-2;
zdba6b93f69 zd0d7c66ccb=z6710d89f27+ze21fd04bcf*zbb645b9c50;zdba6b93f69
z218b76c157=zd0d7c66ccb+zbb645b9c50;zdba6b93f69 ze1a2da7b01=zd0d7c66ccb+1;
zdba6b93f69 z9a10ffe149=z218b76c157+1;
int z4c8643d5c1,z488d92cc23,zfb5690d775,z3ce07f8940;
zdba6b93f69 z12db629aff=((z911cb3715b-z6710d89f27*z7e2b2d4a24)<<13)/z7e2b2d4a24;
zdba6b93f69 zab1ddc3da8=((z2a34d91aeb-ze21fd04bcf*za08de3da7f)<<13)/za08de3da7f;




z4c8643d5c1=z5881fbd8bc[zd0d7c66ccb<<1];z488d92cc23=z5881fbd8bc[ze1a2da7b01<<1];
zfb5690d775=z5881fbd8bc[z218b76c157<<1];z3ce07f8940=z5881fbd8bc[z9a10ffe149<<1];
zdba6b93f69 ze9c58a84c0=(((z488d92cc23-z4c8643d5c1)*z12db629aff)>>13)+
z4c8643d5c1;zdba6b93f69 z1076e938e5=(((z3ce07f8940-zfb5690d775)*z12db629aff)>>13
)+zfb5690d775;za6c557b086 z81b762f6a9=(((z1076e938e5-ze9c58a84c0)*zab1ddc3da8)>>
13)+ze9c58a84c0;za6c557b086 z88dce4da4d=convert_uint(z300bbfbf0b.x);za6c557b086
zd00f1a7efe=(z88dce4da4d*z81b762f6a9+(za6c557b086)(16384))>>15;
z310a4d7815.x=convert_ushort_sat(zd00f1a7efe);
z4c8643d5c1=z402831b2a1[zd0d7c66ccb<<1];z488d92cc23=z402831b2a1[ze1a2da7b01<<1];
zfb5690d775=z402831b2a1[z218b76c157<<1];z3ce07f8940=z402831b2a1[z9a10ffe149<<1];
ze9c58a84c0=(((z488d92cc23-z4c8643d5c1)*z12db629aff)>>13)+z4c8643d5c1;
z1076e938e5=(((z3ce07f8940-zfb5690d775)*z12db629aff)>>13)+zfb5690d775;
z81b762f6a9=(((z1076e938e5-ze9c58a84c0)*zab1ddc3da8)>>13)+ze9c58a84c0;
z88dce4da4d=convert_uint(z300bbfbf0b.z);zd00f1a7efe=(z88dce4da4d*z81b762f6a9+(
za6c557b086)(16384))>>15;
z310a4d7815.z=convert_ushort_sat(zd00f1a7efe);ze4351005bc[z32f37e29d7]=
z310a4d7815;}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
