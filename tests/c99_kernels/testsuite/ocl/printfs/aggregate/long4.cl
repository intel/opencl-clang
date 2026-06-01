/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/long4.c'  */

int long4_d_1187c() {
  // { dg-printf "long4_d_1187c===2,2,-123455,-1===6,123445,-2,-123455===" }
  long4 var1 = (long4) (2,2,-123455,-1);
  long4 var2 = (long4) (6,123445,-2,-123455);
  int i = printf("long4_d_1187c===%-v4ld===%-v4ld===\n",var1,var2);
  return i;
}

int long4_d_1947c() {
  // { dg-printf "long4_d_1947c===+0,+5,+8,-8===+0,+6,+0,-123455===" }
  long4 var1 = (long4) (0,5,8,-8);
  long4 var2 = (long4) (0,6,0,-123455);
  int i = printf("long4_d_1947c===%+v4ld===%+v4ld===\n",var1,var2);
  return i;
}

int long4_d_2707c() {
  // { dg-printf "long4_d_2707c===1,6,2,1===-1,6,2,4===" }
  long4 var1 = (long4) (1,6,2,1);
  long4 var2 = (long4) (-1,6,2,4);
  int i = printf("long4_d_2707c===%#v4ld===%#v4ld===\n",var1,var2);
  return i;
}

int long4_d_3467c() {
  // { dg-printf "long4_d_3467c===-4,+123445,+4,+6===+4,+4,+2,+7===" }
  long4 var1 = (long4) (-4,123445,4,6);
  long4 var2 = (long4) (4,4,2,7);
  int i = printf("long4_d_3467c===%-+v4ld===%-+v4ld===\n",var1,var2);
  return i;
}

int long4_d_4227c() {
  // { dg-printf "long4_d_4227c===        -8,         1,         5,         0===   -123455,         5,        -2,         7===" }
  long4 var1 = (long4) (-8,1,5,0);
  long4 var2 = (long4) (-123455,5,-2,7);
  int i = printf("long4_d_4227c===% 10v4ld===% 10v4ld===\n",var1,var2);
  return i;
}

int long4_d_427c() {
  // { dg-printf "long4_d_427c===-5,0,-6,-6===8,-3,5,8===" }
  long4 var1 = (long4) (-5,0,-6,-6);
  long4 var2 = (long4) (8,-3,5,8);
  int i = printf("long4_d_427c===%v4ld===%v4ld===\n",var1,var2);
  return i;
}

int long4_d_4987c() {
  // { dg-printf "long4_d_4987c===-000000008,0000000005,-000000003,0000000001===0000000004,0000123445,0000000002,-000000003===" }
  long4 var1 = (long4) (-8,5,-3,1);
  long4 var2 = (long4) (4,123445,2,-3);
  int i = printf("long4_d_4987c===%010v4ld===%010v4ld===\n",var1,var2);
  return i;
}

int long4_d_5747c() {
  // { dg-printf "long4_d_5747c=== 5        , 0        ,-4        , 123445   === 4        , 8        ,-123455   ,-1        ===" }
  long4 var1 = (long4) (5,0,-4,123445);
  long4 var2 = (long4) (4,8,-123455,-1);
  int i = printf("long4_d_5747c===%- 10v4ld===%- 10v4ld===\n",var1,var2);
  return i;
}

int long4_d_6507c() {
  // { dg-printf "long4_d_6507c===        +1,   -123455,        -4,        -7===        -8,        -8,   +123445,        +4===" }
  long4 var1 = (long4) (1,-123455,-4,-7);
  long4 var2 = (long4) (-8,-8,123445,4);
  int i = printf("long4_d_6507c===%+ 10v4ld===%+ 10v4ld===\n",var1,var2);
  return i;
}

int long4_d_7267c() {
  // { dg-printf "long4_d_7267c===-000000007,+000123445,+000000002,-000000001===+000000000,-000000002,-000000007,-000000001===" }
  long4 var1 = (long4) (-7,123445,2,-1);
  long4 var2 = (long4) (0,-2,-7,-1);
  int i = printf("long4_d_7267c===%+010v4ld===%+010v4ld===\n",var1,var2);
  return i;
}

int long4_i_1188c() {
  // { dg-printf "long4_i_1188c===-3,-5,-7,6===3,6,2,-123455===" }
  long4 var1 = (long4) (-3,-5,-7,6);
  long4 var2 = (long4) (3,6,2,-123455);
  int i = printf("long4_i_1188c===%-v4li===%-v4li===\n",var1,var2);
  return i;
}

int long4_i_1948c() {
  // { dg-printf "long4_i_1948c===+3,+1,+3,+123445===+5,+3,-3,+3===" }
  long4 var1 = (long4) (3,1,3,123445);
  long4 var2 = (long4) (5,3,-3,3);
  int i = printf("long4_i_1948c===%+v4li===%+v4li===\n",var1,var2);
  return i;
}

int long4_i_2708c() {
  // { dg-printf "long4_i_2708c===5,-7,-7,-4===-5,-5,-4,4===" }
  long4 var1 = (long4) (5,-7,-7,-4);
  long4 var2 = (long4) (-5,-5,-4,4);
  int i = printf("long4_i_2708c===%#v4li===%#v4li===\n",var1,var2);
  return i;
}

int long4_i_3468c() {
  // { dg-printf "long4_i_3468c===-2,-8,+123445,+123445===-1,-5,-4,+6===" }
  long4 var1 = (long4) (-2,-8,123445,123445);
  long4 var2 = (long4) (-1,-5,-4,6);
  int i = printf("long4_i_3468c===%-+v4li===%-+v4li===\n",var1,var2);
  return i;
}

int long4_i_4228c() {
  // { dg-printf "long4_i_4228c===         2,        -2,        -2,        -8===    123445,        -4,        -7,        -6===" }
  long4 var1 = (long4) (2,-2,-2,-8);
  long4 var2 = (long4) (123445,-4,-7,-6);
  int i = printf("long4_i_4228c===% 10v4li===% 10v4li===\n",var1,var2);
  return i;
}

int long4_i_428c() {
  // { dg-printf "long4_i_428c===123445,-1,-8,-7===7,1,-7,-1===" }
  long4 var1 = (long4) (123445,-1,-8,-7);
  long4 var2 = (long4) (7,1,-7,-1);
  int i = printf("long4_i_428c===%v4li===%v4li===\n",var1,var2);
  return i;
}

int long4_i_4988c() {
  // { dg-printf "long4_i_4988c===0000000007,0000000002,-000000007,-000000001===-000000008,0000000003,0000000007,0000000008===" }
  long4 var1 = (long4) (7,2,-7,-1);
  long4 var2 = (long4) (-8,3,7,8);
  int i = printf("long4_i_4988c===%010v4li===%010v4li===\n",var1,var2);
  return i;
}

int long4_i_5748c() {
  // { dg-printf "long4_i_5748c=== 5        ,-6        ,-7        ,-123455   === 4        , 123445   ,-1        , 2        ===" }
  long4 var1 = (long4) (5,-6,-7,-123455);
  long4 var2 = (long4) (4,123445,-1,2);
  int i = printf("long4_i_5748c===%- 10v4li===%- 10v4li===\n",var1,var2);
  return i;
}

int long4_i_6508c() {
  // { dg-printf "long4_i_6508c===        +2,        +7,        -2,        -7===        +6,        -2,        -6,        -1===" }
  long4 var1 = (long4) (2,7,-2,-7);
  long4 var2 = (long4) (6,-2,-6,-1);
  int i = printf("long4_i_6508c===%+ 10v4li===%+ 10v4li===\n",var1,var2);
  return i;
}

int long4_i_7268c() {
  // { dg-printf "long4_i_7268c===+000000005,-000000006,+000000007,-000000008===+000000005,+000000001,-000000006,+000000008===" }
  long4 var1 = (long4) (5,-6,7,-8);
  long4 var2 = (long4) (5,1,-6,8);
  int i = printf("long4_i_7268c===%+010v4li===%+010v4li===\n",var1,var2);
  return i;
}

int long4_o_1189c() {
  // { dg-printf "long4_o_1189c===0,2,0,4===1777777777777777416701,3,1777777777777777777776,5===" }
  long4 var1 = (long4) (0,2,0,4);
  long4 var2 = (long4) (-123455,3,-2,5);
  int i = printf("long4_o_1189c===%-v4lo===%-v4lo===\n",var1,var2);
  return i;
}

int long4_o_1949c() {
  // { dg-printf "long4_o_1949c===361065,4,1777777777777777777773,1777777777777777777770===1777777777777777777775,7,0,2===" }
  long4 var1 = (long4) (123445,4,-5,-8);
  long4 var2 = (long4) (-3,7,0,2);
  int i = printf("long4_o_1949c===%+v4lo===%+v4lo===\n",var1,var2);
  return i;
}

int long4_o_2709c() {
  // { dg-printf "long4_o_2709c===01777777777777777777772,01777777777777777777773,05,010===02,0361065,01777777777777777416701,04===" }
  long4 var1 = (long4) (-6,-5,5,8);
  long4 var2 = (long4) (2,123445,-123455,4);
  int i = printf("long4_o_2709c===%#v4lo===%#v4lo===\n",var1,var2);
  return i;
}

int long4_o_3469c() {
  // { dg-printf "long4_o_3469c===10,4,361065,1777777777777777777775===3,2,1777777777777777777772,3===" }
  long4 var1 = (long4) (8,4,123445,-3);
  long4 var2 = (long4) (3,2,-6,3);
  int i = printf("long4_o_3469c===%-+v4lo===%-+v4lo===\n",var1,var2);
  return i;
}

int long4_o_4229c() {
  // { dg-printf "long4_o_4229c===        10,         5,1777777777777777777774,        10===         2,         3,1777777777777777777774,         2===" }
  long4 var1 = (long4) (8,5,-4,8);
  long4 var2 = (long4) (2,3,-4,2);
  int i = printf("long4_o_4229c===% 10v4lo===% 10v4lo===\n",var1,var2);
  return i;
}

int long4_o_429c() {
  // { dg-printf "long4_o_429c===7,10,6,1777777777777777777771===1777777777777777777770,1777777777777777777771,1777777777777777777773,2===" }
  long4 var1 = (long4) (7,8,6,-7);
  long4 var2 = (long4) (-8,-7,-5,2);
  int i = printf("long4_o_429c===%v4lo===%v4lo===\n",var1,var2);
  return i;
}

int long4_o_4989c() {
  // { dg-printf "long4_o_4989c===1777777777777777777774,1777777777777777777777,0000000006,1777777777777777777777===1777777777777777777773,0000000004,1777777777777777777770,0000000003===" }
  long4 var1 = (long4) (-4,-1,6,-1);
  long4 var2 = (long4) (-5,4,-8,3);
  int i = printf("long4_o_4989c===%010v4lo===%010v4lo===\n",var1,var2);
  return i;
}

int long4_o_5749c() {
  // { dg-printf "long4_o_5749c===4         ,1777777777777777777777,3         ,2         ===1777777777777777777775,2         ,1777777777777777777771,6         ===" }
  long4 var1 = (long4) (4,-1,3,2);
  long4 var2 = (long4) (-3,2,-7,6);
  int i = printf("long4_o_5749c===%- 10v4lo===%- 10v4lo===\n",var1,var2);
  return i;
}

int long4_o_6509c() {
  // { dg-printf "long4_o_6509c===         7,1777777777777777777774,         2,1777777777777777777775===         7,1777777777777777777770,1777777777777777777774,         6===" }
  long4 var1 = (long4) (7,-4,2,-3);
  long4 var2 = (long4) (7,-8,-4,6);
  int i = printf("long4_o_6509c===%+ 10v4lo===%+ 10v4lo===\n",var1,var2);
  return i;
}

int long4_o_7269c() {
  // { dg-printf "long4_o_7269c===0000000006,1777777777777777777772,1777777777777777777773,1777777777777777777777===0000000010,0000000000,1777777777777777777773,1777777777777777416701===" }
  long4 var1 = (long4) (6,-6,-5,-1);
  long4 var2 = (long4) (8,0,-5,-123455);
  int i = printf("long4_o_7269c===%+010v4lo===%+010v4lo===\n",var1,var2);
  return i;
}

int long4_u_1190c() {
  // { dg-printf "long4_u_1190c===8,7,1,18446744073709551610===8,2,1,1===" }
  long4 var1 = (long4) (8,7,1,-6);
  long4 var2 = (long4) (8,2,1,1);
  int i = printf("long4_u_1190c===%-v4lu===%-v4lu===\n",var1,var2);
  return i;
}

int long4_u_1950c() {
  // { dg-printf "long4_u_1950c===18446744073709551608,18446744073709551609,0,8===4,6,18446744073709551611,5===" }
  long4 var1 = (long4) (-8,-7,0,8);
  long4 var2 = (long4) (4,6,-5,5);
  int i = printf("long4_u_1950c===%+v4lu===%+v4lu===\n",var1,var2);
  return i;
}

int long4_u_2710c() {
  // { dg-printf "long4_u_2710c===4,2,3,18446744073709551611===18446744073709551615,4,18446744073709551614,6===" }
  long4 var1 = (long4) (4,2,3,-5);
  long4 var2 = (long4) (-1,4,-2,6);
  int i = printf("long4_u_2710c===%#v4lu===%#v4lu===\n",var1,var2);
  return i;
}

int long4_u_3470c() {
  // { dg-printf "long4_u_3470c===8,18446744073709428161,4,4===4,2,18446744073709551612,1===" }
  long4 var1 = (long4) (8,-123455,4,4);
  long4 var2 = (long4) (4,2,-4,1);
  int i = printf("long4_u_3470c===%-+v4lu===%-+v4lu===\n",var1,var2);
  return i;
}

int long4_u_4230c() {
  // { dg-printf "long4_u_4230c===18446744073709428161,         7,18446744073709551611,18446744073709551611===18446744073709428161,         6,         1,         8===" }
  long4 var1 = (long4) (-123455,7,-5,-5);
  long4 var2 = (long4) (-123455,6,1,8);
  int i = printf("long4_u_4230c===% 10v4lu===% 10v4lu===\n",var1,var2);
  return i;
}

int long4_u_430c() {
  // { dg-printf "long4_u_430c===0,4,18446744073709551611,18446744073709551613===6,18446744073709551609,7,4===" }
  long4 var1 = (long4) (0,4,-5,-3);
  long4 var2 = (long4) (6,-7,7,4);
  int i = printf("long4_u_430c===%v4lu===%v4lu===\n",var1,var2);
  return i;
}

int long4_u_4990c() {
  // { dg-printf "long4_u_4990c===18446744073709551614,18446744073709551615,0000123445,0000000002===0000000001,18446744073709551608,18446744073709551615,18446744073709551613===" }
  long4 var1 = (long4) (-2,-1,123445,2);
  long4 var2 = (long4) (1,-8,-1,-3);
  int i = printf("long4_u_4990c===%010v4lu===%010v4lu===\n",var1,var2);
  return i;
}

int long4_u_5750c() {
  // { dg-printf "long4_u_5750c===7         ,18446744073709551611,123445    ,18446744073709551615===3         ,0         ,18446744073709551610,5         ===" }
  long4 var1 = (long4) (7,-5,123445,-1);
  long4 var2 = (long4) (3,0,-6,5);
  int i = printf("long4_u_5750c===%- 10v4lu===%- 10v4lu===\n",var1,var2);
  return i;
}

int long4_u_6510c() {
  // { dg-printf "long4_u_6510c===         5,         2,         1,         7===18446744073709551611,18446744073709551612,         0,18446744073709551614===" }
  long4 var1 = (long4) (5,2,1,7);
  long4 var2 = (long4) (-5,-4,0,-2);
  int i = printf("long4_u_6510c===%+ 10v4lu===%+ 10v4lu===\n",var1,var2);
  return i;
}

int long4_u_7270c() {
  // { dg-printf "long4_u_7270c===18446744073709428161,0000000005,0000000007,0000000001===18446744073709551611,18446744073709551614,0000000003,0000000008===" }
  long4 var1 = (long4) (-123455,5,7,1);
  long4 var2 = (long4) (-5,-2,3,8);
  int i = printf("long4_u_7270c===%+010v4lu===%+010v4lu===\n",var1,var2);
  return i;
}

int long4_x_1191c() {
  // { dg-printf "long4_x_1191c===fffffffffffffffd,1,fffffffffffffffb,8===ffffffffffffffff,ffffffffffffffff,fffffffffffffffe,3===" }
  long4 var1 = (long4) (-3,1,-5,8);
  long4 var2 = (long4) (-1,-1,-2,3);
  int i = printf("long4_x_1191c===%-v4lx===%-v4lx===\n",var1,var2);
  return i;
}

int long4_x_1192c() {
  // { dg-printf "long4_x_1192c===FFFFFFFFFFFFFFFC,FFFFFFFFFFFFFFFE,FFFFFFFFFFFFFFFB,FFFFFFFFFFFFFFFB===4,4,FFFFFFFFFFFFFFFA,FFFFFFFFFFFFFFFB===" }
  long4 var1 = (long4) (-4,-2,-5,-5);
  long4 var2 = (long4) (4,4,-6,-5);
  int i = printf("long4_x_1192c===%-v4lX===%-v4lX===\n",var1,var2);
  return i;
}

int long4_x_1951c() {
  // { dg-printf "long4_x_1951c===0,fffffffffffffffb,fffffffffffe1dc1,2===fffffffffffffffc,fffffffffffffff8,fffffffffffffffc,fffffffffffffffc===" }
  long4 var1 = (long4) (0,-5,-123455,2);
  long4 var2 = (long4) (-4,-8,-4,-4);
  int i = printf("long4_x_1951c===%+v4lx===%+v4lx===\n",var1,var2);
  return i;
}

int long4_x_1952c() {
  // { dg-printf "long4_x_1952c===8,0,7,3===8,FFFFFFFFFFFE1DC1,FFFFFFFFFFFFFFFA,2===" }
  long4 var1 = (long4) (8,0,7,3);
  long4 var2 = (long4) (8,-123455,-6,2);
  int i = printf("long4_x_1952c===%+v4lX===%+v4lX===\n",var1,var2);
  return i;
}

int long4_x_2711c() {
  // { dg-printf "long4_x_2711c===0x1e235,0x2,0xfffffffffffe1dc1,0x7===0xfffffffffffffffc,0x5,0xfffffffffffffffe,0xfffffffffffffffa===" }
  long4 var1 = (long4) (123445,2,-123455,7);
  long4 var2 = (long4) (-4,5,-2,-6);
  int i = printf("long4_x_2711c===%#v4lx===%#v4lx===\n",var1,var2);
  return i;
}

int long4_x_2712c() {
  // { dg-printf "long4_x_2712c===0X1E235,0XFFFFFFFFFFFFFFFE,0XFFFFFFFFFFFE1DC1,0XFFFFFFFFFFFFFFFC===0X8,0X1E235,0,0X1===" }
  long4 var1 = (long4) (123445,-2,-123455,-4);
  long4 var2 = (long4) (8,123445,0,1);
  int i = printf("long4_x_2712c===%#v4lX===%#v4lX===\n",var1,var2);
  return i;
}

int long4_x_3471c() {
  // { dg-printf "long4_x_3471c===7,5,1,0===fffffffffffffffc,1e235,fffffffffffffffb,fffffffffffffffb===" }
  long4 var1 = (long4) (7,5,1,0);
  long4 var2 = (long4) (-4,123445,-5,-5);
  int i = printf("long4_x_3471c===%-+v4lx===%-+v4lx===\n",var1,var2);
  return i;
}

int long4_x_3472c() {
  // { dg-printf "long4_x_3472c===FFFFFFFFFFFFFFFD,1,FFFFFFFFFFFFFFFF,0===1E235,6,6,FFFFFFFFFFFE1DC1===" }
  long4 var1 = (long4) (-3,1,-1,0);
  long4 var2 = (long4) (123445,6,6,-123455);
  int i = printf("long4_x_3472c===%-+v4lX===%-+v4lX===\n",var1,var2);
  return i;
}

int long4_x_4231c() {
  // { dg-printf "long4_x_4231c===     1e235,fffffffffffe1dc1,         7,         8===     1e235,ffffffffffffffff,         7,         4===" }
  long4 var1 = (long4) (123445,-123455,7,8);
  long4 var2 = (long4) (123445,-1,7,4);
  int i = printf("long4_x_4231c===% 10v4lx===% 10v4lx===\n",var1,var2);
  return i;
}

int long4_x_4232c() {
  // { dg-printf "long4_x_4232c===         6,FFFFFFFFFFFFFFF8,         2,FFFFFFFFFFFE1DC1===FFFFFFFFFFFFFFFD,         6,FFFFFFFFFFFE1DC1,         3===" }
  long4 var1 = (long4) (6,-8,2,-123455);
  long4 var2 = (long4) (-3,6,-123455,3);
  int i = printf("long4_x_4232c===% 10v4lX===% 10v4lX===\n",var1,var2);
  return i;
}

int long4_x_431c() {
  // { dg-printf "long4_x_431c===3,1e235,3,4===fffffffffffffffb,4,8,7===" }
  long4 var1 = (long4) (3,123445,3,4);
  long4 var2 = (long4) (-5,4,8,7);
  int i = printf("long4_x_431c===%v4lx===%v4lx===\n",var1,var2);
  return i;
}

int long4_x_432c() {
  // { dg-printf "long4_x_432c===FFFFFFFFFFFE1DC1,1,FFFFFFFFFFFFFFFA,8===FFFFFFFFFFFFFFF8,1E235,FFFFFFFFFFFFFFFD,FFFFFFFFFFFFFFF8===" }
  long4 var1 = (long4) (-123455,1,-6,8);
  long4 var2 = (long4) (-8,123445,-3,-8);
  int i = printf("long4_x_432c===%v4lX===%v4lX===\n",var1,var2);
  return i;
}

int long4_x_4991c() {
  // { dg-printf "long4_x_4991c===0000000003,0000000003,fffffffffffe1dc1,fffffffffffffff8===fffffffffffffffe,0000000003,fffffffffffffff8,fffffffffffffffb===" }
  long4 var1 = (long4) (3,3,-123455,-8);
  long4 var2 = (long4) (-2,3,-8,-5);
  int i = printf("long4_x_4991c===%010v4lx===%010v4lx===\n",var1,var2);
  return i;
}

int long4_x_4992c() {
  // { dg-printf "long4_x_4992c===FFFFFFFFFFFFFFFE,0000000000,0000000006,FFFFFFFFFFFFFFFA===0000000003,0000000006,0000000003,FFFFFFFFFFFFFFFB===" }
  long4 var1 = (long4) (-2,0,6,-6);
  long4 var2 = (long4) (3,6,3,-5);
  int i = printf("long4_x_4992c===%010v4lX===%010v4lX===\n",var1,var2);
  return i;
}

int long4_x_5751c() {
  // { dg-printf "long4_x_5751c===fffffffffffe1dc1,fffffffffffffff8,2         ,2         ===ffffffffffffffff,2         ,fffffffffffffffb,fffffffffffffffe===" }
  long4 var1 = (long4) (-123455,-8,2,2);
  long4 var2 = (long4) (-1,2,-5,-2);
  int i = printf("long4_x_5751c===%- 10v4lx===%- 10v4lx===\n",var1,var2);
  return i;
}

int long4_x_5752c() {
  // { dg-printf "long4_x_5752c===3         ,FFFFFFFFFFFFFFFA,4         ,2         ===FFFFFFFFFFFFFFFC,1E235     ,FFFFFFFFFFFFFFFE,6         ===" }
  long4 var1 = (long4) (3,-6,4,2);
  long4 var2 = (long4) (-4,123445,-2,6);
  int i = printf("long4_x_5752c===%- 10v4lX===%- 10v4lX===\n",var1,var2);
  return i;
}

int long4_x_6511c() {
  // { dg-printf "long4_x_6511c===fffffffffffffffc,         0,         4,     1e235===         1,         6,ffffffffffffffff,         4===" }
  long4 var1 = (long4) (-4,0,4,123445);
  long4 var2 = (long4) (1,6,-1,4);
  int i = printf("long4_x_6511c===%+ 10v4lx===%+ 10v4lx===\n",var1,var2);
  return i;
}

int long4_x_6512c() {
  // { dg-printf "long4_x_6512c===FFFFFFFFFFFFFFF8,         2,         7,         6===FFFFFFFFFFFFFFFF,FFFFFFFFFFFFFFFB,         4,         2===" }
  long4 var1 = (long4) (-8,2,7,6);
  long4 var2 = (long4) (-1,-5,4,2);
  int i = printf("long4_x_6512c===%+ 10v4lX===%+ 10v4lX===\n",var1,var2);
  return i;
}

int long4_x_7271c() {
  // { dg-printf "long4_x_7271c===000001e235,fffffffffffffffa,fffffffffffe1dc1,0000000005===fffffffffffffffc,fffffffffffffff9,0000000000,ffffffffffffffff===" }
  long4 var1 = (long4) (123445,-6,-123455,5);
  long4 var2 = (long4) (-4,-7,0,-1);
  int i = printf("long4_x_7271c===%+010v4lx===%+010v4lx===\n",var1,var2);
  return i;
}

int long4_x_7272c() {
  // { dg-printf "long4_x_7272c===FFFFFFFFFFFFFFFA,0000000006,0000000005,FFFFFFFFFFFFFFFF===0000000000,0000000006,0000000006,FFFFFFFFFFFFFFFB===" }
  long4 var1 = (long4) (-6,6,5,-1);
  long4 var2 = (long4) (0,6,6,-5);
  int i = printf("long4_x_7272c===%+010v4lX===%+010v4lX===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = long4_d_1187c();
i = long4_d_1947c();
i = long4_d_2707c();
i = long4_d_3467c();
i = long4_d_4227c();
i = long4_d_427c();
i = long4_d_4987c();
i = long4_d_5747c();
i = long4_d_6507c();
i = long4_d_7267c();
i = long4_i_1188c();
i = long4_i_1948c();
i = long4_i_2708c();
i = long4_i_3468c();
i = long4_i_4228c();
i = long4_i_428c();
i = long4_i_4988c();
i = long4_i_5748c();
i = long4_i_6508c();
i = long4_i_7268c();
i = long4_o_1189c();
i = long4_o_1949c();
i = long4_o_2709c();
i = long4_o_3469c();
i = long4_o_4229c();
i = long4_o_429c();
i = long4_o_4989c();
i = long4_o_5749c();
i = long4_o_6509c();
i = long4_o_7269c();
i = long4_u_1190c();
i = long4_u_1950c();
i = long4_u_2710c();
i = long4_u_3470c();
i = long4_u_4230c();
i = long4_u_430c();
i = long4_u_4990c();
i = long4_u_5750c();
i = long4_u_6510c();
i = long4_u_7270c();
i = long4_x_1191c();
i = long4_x_1192c();
i = long4_x_1951c();
i = long4_x_1952c();
i = long4_x_2711c();
i = long4_x_2712c();
i = long4_x_3471c();
i = long4_x_3472c();
i = long4_x_4231c();
i = long4_x_4232c();
i = long4_x_431c();
i = long4_x_432c();
i = long4_x_4991c();
i = long4_x_4992c();
i = long4_x_5751c();
i = long4_x_5752c();
i = long4_x_6511c();
i = long4_x_6512c();
i = long4_x_7271c();
i = long4_x_7272c();
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
