/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/int4.c'  */

int int4_d_1141c() {
  // { dg-printf "int4_d_1141c===4,-123455,8,0===123445,-2,-5,8===" }
  int4 var1 = (int4) (4,-123455,8,0);
  int4 var2 = (int4) (123445,-2,-5,8);
  int i = printf("int4_d_1141c===%-v4hld===%-v4hld===\n",var1,var2);
  return i;
}

int int4_d_1901c() {
  // { dg-printf "int4_d_1901c===-7,+3,+7,+123445===+5,-6,-4,-1===" }
  int4 var1 = (int4) (-7,3,7,123445);
  int4 var2 = (int4) (5,-6,-4,-1);
  int i = printf("int4_d_1901c===%+v4hld===%+v4hld===\n",var1,var2);
  return i;
}

int int4_d_2661c() {
  // { dg-printf "int4_d_2661c===-3,-2,-8,3===-6,1,-3,123445===" }
  int4 var1 = (int4) (-3,-2,-8,3);
  int4 var2 = (int4) (-6,1,-3,123445);
  int i = printf("int4_d_2661c===%#v4hld===%#v4hld===\n",var1,var2);
  return i;
}

int int4_d_3421c() {
  // { dg-printf "int4_d_3421c===+4,-1,+123445,-3===+2,+2,-123455,+8===" }
  int4 var1 = (int4) (4,-1,123445,-3);
  int4 var2 = (int4) (2,2,-123455,8);
  int i = printf("int4_d_3421c===%-+v4hld===%-+v4hld===\n",var1,var2);
  return i;
}

int int4_d_381c() {
  // { dg-printf "int4_d_381c===-123455,-8,4,-4===3,3,5,-5===" }
  int4 var1 = (int4) (-123455,-8,4,-4);
  int4 var2 = (int4) (3,3,5,-5);
  int i = printf("int4_d_381c===%v4hld===%v4hld===\n",var1,var2);
  return i;
}

int int4_d_4181c() {
  // { dg-printf "int4_d_4181c===         7,        -5,         6,        -8===         0,        -4,        -8,         5===" }
  int4 var1 = (int4) (7,-5,6,-8);
  int4 var2 = (int4) (0,-4,-8,5);
  int i = printf("int4_d_4181c===% 10v4hld===% 10v4hld===\n",var1,var2);
  return i;
}

int int4_d_4941c() {
  // { dg-printf "int4_d_4941c===-000000004,-000000001,0000000003,0000000006===0000000007,0000000003,-000000006,-000000007===" }
  int4 var1 = (int4) (-4,-1,3,6);
  int4 var2 = (int4) (7,3,-6,-7);
  int i = printf("int4_d_4941c===%010v4hld===%010v4hld===\n",var1,var2);
  return i;
}

int int4_d_5701c() {
  // { dg-printf "int4_d_5701c===-123455   , 2        ,-4        ,-6        === 2        , 3        ,-3        ,-5        ===" }
  int4 var1 = (int4) (-123455,2,-4,-6);
  int4 var2 = (int4) (2,3,-3,-5);
  int i = printf("int4_d_5701c===%- 10v4hld===%- 10v4hld===\n",var1,var2);
  return i;
}

int int4_d_6461c() {
  // { dg-printf "int4_d_6461c===        +3,   +123445,        -1,        -1===        +1,        +0,        -5,        +8===" }
  int4 var1 = (int4) (3,123445,-1,-1);
  int4 var2 = (int4) (1,0,-5,8);
  int i = printf("int4_d_6461c===%+ 10v4hld===%+ 10v4hld===\n",var1,var2);
  return i;
}

int int4_d_7221c() {
  // { dg-printf "int4_d_7221c===+000000003,-000000002,-000000003,+000000002===-000000001,-000000001,-000123455,-000123455===" }
  int4 var1 = (int4) (3,-2,-3,2);
  int4 var2 = (int4) (-1,-1,-123455,-123455);
  int i = printf("int4_d_7221c===%+010v4hld===%+010v4hld===\n",var1,var2);
  return i;
}

int int4_i_1142c() {
  // { dg-printf "int4_i_1142c===5,123445,-123455,-8===-7,1,5,-3===" }
  int4 var1 = (int4) (5,123445,-123455,-8);
  int4 var2 = (int4) (-7,1,5,-3);
  int i = printf("int4_i_1142c===%-v4hli===%-v4hli===\n",var1,var2);
  return i;
}

int int4_i_1902c() {
  // { dg-printf "int4_i_1902c===+0,+4,+5,-5===+0,+6,+3,+5===" }
  int4 var1 = (int4) (0,4,5,-5);
  int4 var2 = (int4) (0,6,3,5);
  int i = printf("int4_i_1902c===%+v4hli===%+v4hli===\n",var1,var2);
  return i;
}

int int4_i_2662c() {
  // { dg-printf "int4_i_2662c===6,-7,5,-4===6,7,2,123445===" }
  int4 var1 = (int4) (6,-7,5,-4);
  int4 var2 = (int4) (6,7,2,123445);
  int i = printf("int4_i_2662c===%#v4hli===%#v4hli===\n",var1,var2);
  return i;
}

int int4_i_3422c() {
  // { dg-printf "int4_i_3422c===-4,+123445,-1,-1===+8,-2,-8,-4===" }
  int4 var1 = (int4) (-4,123445,-1,-1);
  int4 var2 = (int4) (8,-2,-8,-4);
  int i = printf("int4_i_3422c===%-+v4hli===%-+v4hli===\n",var1,var2);
  return i;
}

int int4_i_382c() {
  // { dg-printf "int4_i_382c===-1,6,0,-123455===123445,-4,-4,-5===" }
  int4 var1 = (int4) (-1,6,0,-123455);
  int4 var2 = (int4) (123445,-4,-4,-5);
  int i = printf("int4_i_382c===%v4hli===%v4hli===\n",var1,var2);
  return i;
}

int int4_i_4182c() {
  // { dg-printf "int4_i_4182c===         8,        -7,        -2,         1===   -123455,        -3,         3,        -7===" }
  int4 var1 = (int4) (8,-7,-2,1);
  int4 var2 = (int4) (-123455,-3,3,-7);
  int i = printf("int4_i_4182c===% 10v4hli===% 10v4hli===\n",var1,var2);
  return i;
}

int int4_i_4942c() {
  // { dg-printf "int4_i_4942c===0000000005,0000000004,-000123455,-000000003===0000000000,0000000005,-000000007,-000123455===" }
  int4 var1 = (int4) (5,4,-123455,-3);
  int4 var2 = (int4) (0,5,-7,-123455);
  int i = printf("int4_i_4942c===%010v4hli===%010v4hli===\n",var1,var2);
  return i;
}

int int4_i_5702c() {
  // { dg-printf "int4_i_5702c===-7        ,-5        , 4        ,-3        === 2        , 8        ,-4        ,-4        ===" }
  int4 var1 = (int4) (-7,-5,4,-3);
  int4 var2 = (int4) (2,8,-4,-4);
  int i = printf("int4_i_5702c===%- 10v4hli===%- 10v4hli===\n",var1,var2);
  return i;
}

int int4_i_6462c() {
  // { dg-printf "int4_i_6462c===        -3,        +4,   -123455,        -6===        +1,        +3,        +2,        -2===" }
  int4 var1 = (int4) (-3,4,-123455,-6);
  int4 var2 = (int4) (1,3,2,-2);
  int i = printf("int4_i_6462c===%+ 10v4hli===%+ 10v4hli===\n",var1,var2);
  return i;
}

int int4_i_7222c() {
  // { dg-printf "int4_i_7222c===+000123445,+000000007,+000123445,+000000001===-000000003,+000000000,-000000003,+000000007===" }
  int4 var1 = (int4) (123445,7,123445,1);
  int4 var2 = (int4) (-3,0,-3,7);
  int i = printf("int4_i_7222c===%+010v4hli===%+010v4hli===\n",var1,var2);
  return i;
}

int int4_o_1143c() {
  // { dg-printf "int4_o_1143c===37777777776,37777777776,37777777774,37777777774===0,37777777777,361065,37777777771===" }
  int4 var1 = (int4) (-2,-2,-4,-4);
  int4 var2 = (int4) (0,-1,123445,-7);
  int i = printf("int4_o_1143c===%-v4hlo===%-v4hlo===\n",var1,var2);
  return i;
}

int int4_o_1903c() {
  // { dg-printf "int4_o_1903c===37777777770,0,3,4===361065,361065,37777777776,3===" }
  int4 var1 = (int4) (-8,0,3,4);
  int4 var2 = (int4) (123445,123445,-2,3);
  int i = printf("int4_o_1903c===%+v4hlo===%+v4hlo===\n",var1,var2);
  return i;
}

int int4_o_2663c() {
  // { dg-printf "int4_o_2663c===03,037777416701,037777777777,037777777774===05,0361065,03,037777777770===" }
  int4 var1 = (int4) (3,-123455,-1,-4);
  int4 var2 = (int4) (5,123445,3,-8);
  int i = printf("int4_o_2663c===%#v4hlo===%#v4hlo===\n",var1,var2);
  return i;
}

int int4_o_3423c() {
  // { dg-printf "int4_o_3423c===3,3,0,37777416701===4,5,6,361065===" }
  int4 var1 = (int4) (3,3,0,-123455);
  int4 var2 = (int4) (4,5,6,123445);
  int i = printf("int4_o_3423c===%-+v4hlo===%-+v4hlo===\n",var1,var2);
  return i;
}

int int4_o_383c() {
  // { dg-printf "int4_o_383c===37777416701,6,3,3===37777777777,1,37777416701,4===" }
  int4 var1 = (int4) (-123455,6,3,3);
  int4 var2 = (int4) (-1,1,-123455,4);
  int i = printf("int4_o_383c===%v4hlo===%v4hlo===\n",var1,var2);
  return i;
}

int int4_o_4183c() {
  // { dg-printf "int4_o_4183c===37777777776,         2,         4,37777777772===37777777773,         5,         1,37777416701===" }
  int4 var1 = (int4) (-2,2,4,-6);
  int4 var2 = (int4) (-5,5,1,-123455);
  int i = printf("int4_o_4183c===% 10v4hlo===% 10v4hlo===\n",var1,var2);
  return i;
}

int int4_o_4943c() {
  // { dg-printf "int4_o_4943c===37777777770,37777777770,37777777777,0000000003===37777777775,0000000001,0000000007,37777777775===" }
  int4 var1 = (int4) (-8,-8,-1,3);
  int4 var2 = (int4) (-3,1,7,-3);
  int i = printf("int4_o_4943c===%010v4hlo===%010v4hlo===\n",var1,var2);
  return i;
}

int int4_o_5703c() {
  // { dg-printf "int4_o_5703c===37777777776,2         ,6         ,37777416701===37777777776,7         ,37777777776,1         ===" }
  int4 var1 = (int4) (-2,2,6,-123455);
  int4 var2 = (int4) (-2,7,-2,1);
  int i = printf("int4_o_5703c===%- 10v4hlo===%- 10v4hlo===\n",var1,var2);
  return i;
}

int int4_o_6463c() {
  // { dg-printf "int4_o_6463c===37777777774,37777777773,         7,37777777776===        10,         4,        10,         7===" }
  int4 var1 = (int4) (-4,-5,7,-2);
  int4 var2 = (int4) (8,4,8,7);
  int i = printf("int4_o_6463c===%+ 10v4hlo===%+ 10v4hlo===\n",var1,var2);
  return i;
}

int int4_o_7223c() {
  // { dg-printf "int4_o_7223c===0000000002,0000000003,37777777777,0000000004===0000000004,37777777776,37777777776,0000000007===" }
  int4 var1 = (int4) (2,3,-1,4);
  int4 var2 = (int4) (4,-2,-2,7);
  int i = printf("int4_o_7223c===%+010v4hlo===%+010v4hlo===\n",var1,var2);
  return i;
}

int int4_u_1144c() {
  // { dg-printf "int4_u_1144c===3,4,2,3===123445,8,4,4294967292===" }
  int4 var1 = (int4) (3,4,2,3);
  int4 var2 = (int4) (123445,8,4,-4);
  int i = printf("int4_u_1144c===%-v4hlu===%-v4hlu===\n",var1,var2);
  return i;
}

int int4_u_1904c() {
  // { dg-printf "int4_u_1904c===2,5,0,6===123445,4294967288,3,1===" }
  int4 var1 = (int4) (2,5,0,6);
  int4 var2 = (int4) (123445,-8,3,1);
  int i = printf("int4_u_1904c===%+v4hlu===%+v4hlu===\n",var1,var2);
  return i;
}

int int4_u_2664c() {
  // { dg-printf "int4_u_2664c===4294967288,5,7,8===3,4,5,5===" }
  int4 var1 = (int4) (-8,5,7,8);
  int4 var2 = (int4) (3,4,5,5);
  int i = printf("int4_u_2664c===%#v4hlu===%#v4hlu===\n",var1,var2);
  return i;
}

int int4_u_3424c() {
  // { dg-printf "int4_u_3424c===4294843841,4294967289,2,4===4294967292,6,0,2===" }
  int4 var1 = (int4) (-123455,-7,2,4);
  int4 var2 = (int4) (-4,6,0,2);
  int i = printf("int4_u_3424c===%-+v4hlu===%-+v4hlu===\n",var1,var2);
  return i;
}

int int4_u_384c() {
  // { dg-printf "int4_u_384c===2,4294967292,4294967290,1===4294967295,6,7,4294967294===" }
  int4 var1 = (int4) (2,-4,-6,1);
  int4 var2 = (int4) (-1,6,7,-2);
  int i = printf("int4_u_384c===%v4hlu===%v4hlu===\n",var1,var2);
  return i;
}

int int4_u_4184c() {
  // { dg-printf "int4_u_4184c===4294967294,4294967292,         8,4294967293===         2,    123445,         4,         0===" }
  int4 var1 = (int4) (-2,-4,8,-3);
  int4 var2 = (int4) (2,123445,4,0);
  int i = printf("int4_u_4184c===% 10v4hlu===% 10v4hlu===\n",var1,var2);
  return i;
}

int int4_u_4944c() {
  // { dg-printf "int4_u_4944c===0000123445,0000123445,4294967293,4294967290===4294967293,4294967288,0000000000,0000000001===" }
  int4 var1 = (int4) (123445,123445,-3,-6);
  int4 var2 = (int4) (-3,-8,0,1);
  int i = printf("int4_u_4944c===%010v4hlu===%010v4hlu===\n",var1,var2);
  return i;
}

int int4_u_5704c() {
  // { dg-printf "int4_u_5704c===1         ,6         ,4         ,7         ===4294967292,4294967293,3         ,4294967288===" }
  int4 var1 = (int4) (1,6,4,7);
  int4 var2 = (int4) (-4,-3,3,-8);
  int i = printf("int4_u_5704c===%- 10v4hlu===%- 10v4hlu===\n",var1,var2);
  return i;
}

int int4_u_6464c() {
  // { dg-printf "int4_u_6464c===4294967295,4294967292,         4,         2===4294967292,4294967293,4294843841,4294967292===" }
  int4 var1 = (int4) (-1,-4,4,2);
  int4 var2 = (int4) (-4,-3,-123455,-4);
  int i = printf("int4_u_6464c===%+ 10v4hlu===%+ 10v4hlu===\n",var1,var2);
  return i;
}

int int4_u_7224c() {
  // { dg-printf "int4_u_7224c===4294843841,4294967289,4294843841,4294967294===4294967292,4294967291,4294967290,0000000003===" }
  int4 var1 = (int4) (-123455,-7,-123455,-2);
  int4 var2 = (int4) (-4,-5,-6,3);
  int i = printf("int4_u_7224c===%+010v4hlu===%+010v4hlu===\n",var1,var2);
  return i;
}

int int4_x_1145c() {
  // { dg-printf "int4_x_1145c===8,6,1e235,8===fffffffc,1,3,1===" }
  int4 var1 = (int4) (8,6,123445,8);
  int4 var2 = (int4) (-4,1,3,1);
  int i = printf("int4_x_1145c===%-v4hlx===%-v4hlx===\n",var1,var2);
  return i;
}

int int4_x_1146c() {
  // { dg-printf "int4_x_1146c===FFFFFFFA,2,FFFFFFFC,1===1E235,2,5,5===" }
  int4 var1 = (int4) (-6,2,-4,1);
  int4 var2 = (int4) (123445,2,5,5);
  int i = printf("int4_x_1146c===%-v4hlX===%-v4hlX===\n",var1,var2);
  return i;
}

int int4_x_1905c() {
  // { dg-printf "int4_x_1905c===fffffffb,8,fffffff8,fffffffd===fffffffd,fffffff8,7,1===" }
  int4 var1 = (int4) (-5,8,-8,-3);
  int4 var2 = (int4) (-3,-8,7,1);
  int i = printf("int4_x_1905c===%+v4hlx===%+v4hlx===\n",var1,var2);
  return i;
}

int int4_x_1906c() {
  // { dg-printf "int4_x_1906c===FFFE1DC1,4,FFFFFFFF,FFFFFFFA===FFFE1DC1,FFFFFFFD,4,3===" }
  int4 var1 = (int4) (-123455,4,-1,-6);
  int4 var2 = (int4) (-123455,-3,4,3);
  int i = printf("int4_x_1906c===%+v4hlX===%+v4hlX===\n",var1,var2);
  return i;
}

int int4_x_2665c() {
  // { dg-printf "int4_x_2665c===0xfffffff9,0xfffffffe,0xfffffffd,0xfffffffe===0xffffffff,0x7,0xfffffffb,0x1e235===" }
  int4 var1 = (int4) (-7,-2,-3,-2);
  int4 var2 = (int4) (-1,7,-5,123445);
  int i = printf("int4_x_2665c===%#v4hlx===%#v4hlx===\n",var1,var2);
  return i;
}

int int4_x_2666c() {
  // { dg-printf "int4_x_2666c===0X2,0XFFFFFFFD,0X5,0X4===0X2,0XFFFFFFF9,0XFFFFFFF8,0X1E235===" }
  int4 var1 = (int4) (2,-3,5,4);
  int4 var2 = (int4) (2,-7,-8,123445);
  int i = printf("int4_x_2666c===%#v4hlX===%#v4hlX===\n",var1,var2);
  return i;
}

int int4_x_3425c() {
  // { dg-printf "int4_x_3425c===fffe1dc1,fffe1dc1,ffffffff,2===4,7,3,0===" }
  int4 var1 = (int4) (-123455,-123455,-1,2);
  int4 var2 = (int4) (4,7,3,0);
  int i = printf("int4_x_3425c===%-+v4hlx===%-+v4hlx===\n",var1,var2);
  return i;
}

int int4_x_3426c() {
  // { dg-printf "int4_x_3426c===1,FFFFFFFF,7,6===0,FFFFFFFC,8,4===" }
  int4 var1 = (int4) (1,-1,7,6);
  int4 var2 = (int4) (0,-4,8,4);
  int i = printf("int4_x_3426c===%-+v4hlX===%-+v4hlX===\n",var1,var2);
  return i;
}

int int4_x_385c() {
  // { dg-printf "int4_x_385c===ffffffff,8,1,fffffff9===2,7,fffe1dc1,fffe1dc1===" }
  int4 var1 = (int4) (-1,8,1,-7);
  int4 var2 = (int4) (2,7,-123455,-123455);
  int i = printf("int4_x_385c===%v4hlx===%v4hlx===\n",var1,var2);
  return i;
}

int int4_x_386c() {
  // { dg-printf "int4_x_386c===5,FFFE1DC1,FFFFFFFA,7===FFFFFFFC,FFFE1DC1,7,FFFFFFFD===" }
  int4 var1 = (int4) (5,-123455,-6,7);
  int4 var2 = (int4) (-4,-123455,7,-3);
  int i = printf("int4_x_386c===%v4hlX===%v4hlX===\n",var1,var2);
  return i;
}

int int4_x_4185c() {
  // { dg-printf "int4_x_4185c===  fffffffa,  ffffffff,         8,  fffffffa===  fffffffd,         5,         3,  fffffffb===" }
  int4 var1 = (int4) (-6,-1,8,-6);
  int4 var2 = (int4) (-3,5,3,-5);
  int i = printf("int4_x_4185c===% 10v4hlx===% 10v4hlx===\n",var1,var2);
  return i;
}

int int4_x_4186c() {
  // { dg-printf "int4_x_4186c===         7,  FFFFFFFC,  FFFFFFF9,  FFFFFFFC===  FFFFFFFE,         6,  FFFFFFFC,         6===" }
  int4 var1 = (int4) (7,-4,-7,-4);
  int4 var2 = (int4) (-2,6,-4,6);
  int i = printf("int4_x_4186c===% 10v4hlX===% 10v4hlX===\n",var1,var2);
  return i;
}

int int4_x_4945c() {
  // { dg-printf "int4_x_4945c===0000000001,0000000001,0000000005,0000000004===00fffffff8,00fffe1dc1,00fffffff9,0000000008===" }
  int4 var1 = (int4) (1,1,5,4);
  int4 var2 = (int4) (-8,-123455,-7,8);
  int i = printf("int4_x_4945c===%010v4hlx===%010v4hlx===\n",var1,var2);
  return i;
}

int int4_x_4946c() {
  // { dg-printf "int4_x_4946c===0000000005,00FFFFFFF9,000001E235,0000000000===00FFFFFFFD,00FFFFFFFB,00FFFFFFFA,0000000003===" }
  int4 var1 = (int4) (5,-7,123445,0);
  int4 var2 = (int4) (-3,-5,-6,3);
  int i = printf("int4_x_4946c===%010v4hlX===%010v4hlX===\n",var1,var2);
  return i;
}

int int4_x_5705c() {
  // { dg-printf "int4_x_5705c===fffe1dc1  ,1e235     ,1         ,fffe1dc1  ===8         ,5         ,ffffffff  ,fffffff9  ===" }
  int4 var1 = (int4) (-123455,123445,1,-123455);
  int4 var2 = (int4) (8,5,-1,-7);
  int i = printf("int4_x_5705c===%- 10v4hlx===%- 10v4hlx===\n",var1,var2);
  return i;
}

int int4_x_5706c() {
  // { dg-printf "int4_x_5706c===1         ,1         ,FFFFFFFC  ,FFFFFFFC  ===FFFFFFFB  ,FFFFFFFE  ,FFFFFFFB  ,8         ===" }
  int4 var1 = (int4) (1,1,-4,-4);
  int4 var2 = (int4) (-5,-2,-5,8);
  int i = printf("int4_x_5706c===%- 10v4hlX===%- 10v4hlX===\n",var1,var2);
  return i;
}

int int4_x_6465c() {
  // { dg-printf "int4_x_6465c===  ffffffff,         7,         8,  fffffffa===         6,  ffffffff,         0,         0===" }
  int4 var1 = (int4) (-1,7,8,-6);
  int4 var2 = (int4) (6,-1,0,0);
  int i = printf("int4_x_6465c===%+ 10v4hlx===%+ 10v4hlx===\n",var1,var2);
  return i;
}

int int4_x_6466c() {
  // { dg-printf "int4_x_6466c===         7,         3,  FFFFFFFB,         1===  FFFFFFFD,  FFFFFFFF,         8,  FFFFFFFA===" }
  int4 var1 = (int4) (7,3,-5,1);
  int4 var2 = (int4) (-3,-1,8,-6);
  int i = printf("int4_x_6466c===%+ 10v4hlX===%+ 10v4hlX===\n",var1,var2);
  return i;
}

int int4_x_7225c() {
  // { dg-printf "int4_x_7225c===00fffffffe,0000000003,0000000004,00fffe1dc1===0000000007,00fffffffa,00fffffffd,0000000003===" }
  int4 var1 = (int4) (-2,3,4,-123455);
  int4 var2 = (int4) (7,-6,-3,3);
  int i = printf("int4_x_7225c===%+010v4hlx===%+010v4hlx===\n",var1,var2);
  return i;
}

int int4_x_7226c() {
  // { dg-printf "int4_x_7226c===00FFFFFFFF,0000000004,000001E235,00FFFFFFFA===0000000008,0000000003,00FFFFFFFA,0000000001===" }
  int4 var1 = (int4) (-1,4,123445,-6);
  int4 var2 = (int4) (8,3,-6,1);
  int i = printf("int4_x_7226c===%+010v4hlX===%+010v4hlX===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = int4_d_1141c();
i = int4_d_1901c();
i = int4_d_2661c();
i = int4_d_3421c();
i = int4_d_381c();
i = int4_d_4181c();
i = int4_d_4941c();
i = int4_d_5701c();
i = int4_d_6461c();
i = int4_d_7221c();
i = int4_i_1142c();
i = int4_i_1902c();
i = int4_i_2662c();
i = int4_i_3422c();
i = int4_i_382c();
i = int4_i_4182c();
i = int4_i_4942c();
i = int4_i_5702c();
i = int4_i_6462c();
i = int4_i_7222c();
i = int4_o_1143c();
i = int4_o_1903c();
i = int4_o_2663c();
i = int4_o_3423c();
i = int4_o_383c();
i = int4_o_4183c();
i = int4_o_4943c();
i = int4_o_5703c();
i = int4_o_6463c();
i = int4_o_7223c();
i = int4_u_1144c();
i = int4_u_1904c();
i = int4_u_2664c();
i = int4_u_3424c();
i = int4_u_384c();
i = int4_u_4184c();
i = int4_u_4944c();
i = int4_u_5704c();
i = int4_u_6464c();
i = int4_u_7224c();
i = int4_x_1145c();
i = int4_x_1146c();
i = int4_x_1905c();
i = int4_x_1906c();
i = int4_x_2665c();
i = int4_x_2666c();
i = int4_x_3425c();
i = int4_x_3426c();
i = int4_x_385c();
i = int4_x_386c();
i = int4_x_4185c();
i = int4_x_4186c();
i = int4_x_4945c();
i = int4_x_4946c();
i = int4_x_5705c();
i = int4_x_5706c();
i = int4_x_6465c();
i = int4_x_6466c();
i = int4_x_7225c();
i = int4_x_7226c();
return 0;}
__kernel void ocl_test_kernel(__global int *ocl_test_results)
{
  const constant char *args[] = {"ocl", "c99", "gcc"};
  ocl_test_results[0] = 1; //kernel started
  ocl_test_results[3] = main_function_ocl(3,args,ocl_test_results);
  ocl_test_results[0] = 2; //kernel finished
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
// From groups/PrintfSuite.lst: status: , errorcode: , message: 
