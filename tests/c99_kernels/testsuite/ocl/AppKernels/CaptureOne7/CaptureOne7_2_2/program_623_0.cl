

#define z2ecf1ed8a5(z88dce4da4d) ((z88dce4da4d)*4 + 2)
#define z4db691d11f(z2dd09f3226,za3158292ce,ze28128c2dd,z593fa3cb41) ((\
z2dd09f3226<<24) | (za3158292ce<<16) | (ze28128c2dd<<8) | z593fa3cb41)
__kernel void z1fda381729(__global ushort4*zf8d9fd6cb8,__global uchar4*
z718a062ddd,int8 z30eaaf69b7,uint z2824fcf57d,uint z9562068e13,int2 z3f816b30a5)
{int2 zba94ee46da=(int2)(get_global_id(0),get_global_id(1));if(zba94ee46da.x>=
z30eaaf69b7.s2||zba94ee46da.y>=z30eaaf69b7.s3)return;int2 z83640e5796=
zba94ee46da+z30eaaf69b7.s45;int2 zaaf414d14e=zba94ee46da+z30eaaf69b7.s01;int
zb6170e4cc6=z3f816b30a5.x;int zc8435b5afd=z3f816b30a5.y;uint16 z3a77d297f7=(
uint16)(z4db691d11f(z2ecf1ed8a5(0),z2ecf1ed8a5(48),z2ecf1ed8a5(12),z2ecf1ed8a5(
60)),z4db691d11f(z2ecf1ed8a5(3),z2ecf1ed8a5(51),z2ecf1ed8a5(15),z2ecf1ed8a5(63))
,z4db691d11f(z2ecf1ed8a5(32),z2ecf1ed8a5(16),z2ecf1ed8a5(44),z2ecf1ed8a5(28)),
z4db691d11f(z2ecf1ed8a5(35),z2ecf1ed8a5(19),z2ecf1ed8a5(47),z2ecf1ed8a5(31)),
z4db691d11f(z2ecf1ed8a5(8),z2ecf1ed8a5(56),z2ecf1ed8a5(4),z2ecf1ed8a5(52)),
z4db691d11f(z2ecf1ed8a5(11),z2ecf1ed8a5(59),z2ecf1ed8a5(7),z2ecf1ed8a5(55)),
z4db691d11f(z2ecf1ed8a5(40),z2ecf1ed8a5(24),z2ecf1ed8a5(36),z2ecf1ed8a5(20)),
z4db691d11f(z2ecf1ed8a5(43),z2ecf1ed8a5(27),z2ecf1ed8a5(39),z2ecf1ed8a5(23)),
z4db691d11f(z2ecf1ed8a5(2),z2ecf1ed8a5(50),z2ecf1ed8a5(14),z2ecf1ed8a5(62)),
z4db691d11f(z2ecf1ed8a5(1),z2ecf1ed8a5(49),z2ecf1ed8a5(13),z2ecf1ed8a5(61)),
z4db691d11f(z2ecf1ed8a5(34),z2ecf1ed8a5(18),z2ecf1ed8a5(46),z2ecf1ed8a5(30)),
z4db691d11f(z2ecf1ed8a5(33),z2ecf1ed8a5(17),z2ecf1ed8a5(45),z2ecf1ed8a5(29)),
z4db691d11f(z2ecf1ed8a5(10),z2ecf1ed8a5(58),z2ecf1ed8a5(6),z2ecf1ed8a5(54)),
z4db691d11f(z2ecf1ed8a5(9),z2ecf1ed8a5(57),z2ecf1ed8a5(5),z2ecf1ed8a5(53)),
z4db691d11f(z2ecf1ed8a5(42),z2ecf1ed8a5(26),z2ecf1ed8a5(38),z2ecf1ed8a5(22)),
z4db691d11f(z2ecf1ed8a5(41),z2ecf1ed8a5(25),z2ecf1ed8a5(37),z2ecf1ed8a5(21)));
uchar*z029e22e660=(uchar*)&z3a77d297f7;int z2523506dd2=(zba94ee46da.y+
zc8435b5afd)&7;int z49cb77b4dc=(zba94ee46da.x+zb6170e4cc6)&7;int z8dd6fa68b0=
clamp(z2523506dd2*8+z49cb77b4dc,0,63);ushort z877643e334=convert_ushort(
z029e22e660[z8dd6fa68b0]);ushort4 z3931fc4ce8=zf8d9fd6cb8[z83640e5796.x+
z83640e5796.y*z2824fcf57d];z3931fc4ce8=add_sat(z3931fc4ce8,(ushort4)z877643e334)
>>(ushort4)8;z718a062ddd[zaaf414d14e.x+zaaf414d14e.y*z9562068e13]=
convert_uchar4_sat(z3931fc4ce8);}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
