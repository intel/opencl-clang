typedef ushort z51b7908a0d;typedef int zdba6b93f69;typedef uint za6c557b086;
__kernel void z6fb2d7f2ba(__global z51b7908a0d*z6533f4e792,__global z51b7908a0d*
zd30cb40f88,int4 z30eaaf69b7,int z58c1e26fb1,int zb41a4b7008,int16 z2e7b344b9f,
int16 z2a397cc1d3,int16 zde48601fb5,int16 z9459255e92,int16 zec06efc795,int
z11b544ce85,__global z51b7908a0d*zc57132e640){int2 zba94ee46da=(int2)(
get_global_id(0),get_global_id(1));if(zba94ee46da.x>=z30eaaf69b7.z||zba94ee46da.
y>=z30eaaf69b7.w)return;int z4d5680d21d=zba94ee46da.x;int z278ea663fa=
zba94ee46da.y;zba94ee46da+=z30eaaf69b7.xy;int2 z83640e5796=zba94ee46da;int
z8dd6fa68b0=-1;int zc180b9cdc9=0;int za3584c0652=0;int w=0;int z1976b04399[16]={
z2e7b344b9f.s0,z2e7b344b9f.s1,z2e7b344b9f.s2,z2e7b344b9f.s3,z2e7b344b9f.s4,
z2e7b344b9f.s5,z2e7b344b9f.s6,z2e7b344b9f.s7,z2e7b344b9f.s8,z2e7b344b9f.s9,
z2e7b344b9f.sa,z2e7b344b9f.sb,z2e7b344b9f.sc,z2e7b344b9f.sd,z2e7b344b9f.se,
z2e7b344b9f.sf};int z1215af94df[16]={z2a397cc1d3.s0,z2a397cc1d3.s1,z2a397cc1d3.
s2,z2a397cc1d3.s3,z2a397cc1d3.s4,z2a397cc1d3.s5,z2a397cc1d3.s6,z2a397cc1d3.s7,
z2a397cc1d3.s8,z2a397cc1d3.s9,z2a397cc1d3.sa,z2a397cc1d3.sb,z2a397cc1d3.sc,
z2a397cc1d3.sd,z2a397cc1d3.se,z2a397cc1d3.sf};int z1499aed669[16]={zde48601fb5.
s0,zde48601fb5.s1,zde48601fb5.s2,zde48601fb5.s3,zde48601fb5.s4,zde48601fb5.s5,
zde48601fb5.s6,zde48601fb5.s7,zde48601fb5.s8,zde48601fb5.s9,zde48601fb5.sa,
zde48601fb5.sb,zde48601fb5.sc,zde48601fb5.sd,zde48601fb5.se,zde48601fb5.sf};int
z4b78dd4406[16]={z9459255e92.s0,z9459255e92.s1,z9459255e92.s2,z9459255e92.s3,
z9459255e92.s4,z9459255e92.s5,z9459255e92.s6,z9459255e92.s7,z9459255e92.s8,
z9459255e92.s9,z9459255e92.sa,z9459255e92.sb,z9459255e92.sc,z9459255e92.sd,
z9459255e92.se,z9459255e92.sf};int za4bf013d38[16]={zec06efc795.s0,zec06efc795.
s1,zec06efc795.s2,zec06efc795.s3,zec06efc795.s4,zec06efc795.s5,zec06efc795.s6,
zec06efc795.s7,zec06efc795.s8,zec06efc795.s9,zec06efc795.sa,zec06efc795.sb,
zec06efc795.sc,zec06efc795.sd,zec06efc795.se,zec06efc795.sf};for(int z2bf1a46fdf
=0;z2bf1a46fdf<z11b544ce85;z2bf1a46fdf++){if(z4d5680d21d>=z1976b04399[
z2bf1a46fdf]&&z4d5680d21d<z1499aed669[z2bf1a46fdf]){if(z278ea663fa>=z1215af94df[
z2bf1a46fdf]&&z278ea663fa<z4b78dd4406[z2bf1a46fdf]){z8dd6fa68b0=za4bf013d38[
z2bf1a46fdf];zc180b9cdc9=z1976b04399[z2bf1a46fdf];za3584c0652=z1215af94df[
z2bf1a46fdf];w=z1499aed669[z2bf1a46fdf]-zc180b9cdc9;continue;}}}if(z8dd6fa68b0<0
)return;

#if 1
__global z51b7908a0d*z171ba455b1=zc57132e640+z8dd6fa68b0;

z51b7908a0d z86dd029962=z171ba455b1[(z278ea663fa-za3584c0652)*w+(z4d5680d21d-
zc180b9cdc9)];z51b7908a0d z4633c865c6=zd30cb40f88[z83640e5796.y*zb41a4b7008+
z83640e5796.x];za6c557b086 z6a38e699a2=convert_uint(z4633c865c6)*convert_uint(
z86dd029962);

zd30cb40f88[z83640e5796.y*zb41a4b7008+z83640e5796.x]=convert_ushort_sat(
z6a38e699a2>>12);

#endif




}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
