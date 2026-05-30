/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/char4.c'  */

int char4_d_1089c() {
  // { dg-printf "char4_d_1089c===2,-1,-5,-1===1,-6,1,-6===" }
  char4 var1 = (char4) (2,-1,-5,-1);
  char4 var2 = (char4) (1,-6,1,-6);
  int i = printf("char4_d_1089c===%-v4hhd===%-v4hhd===\n",var1,var2);
  return i;
}

int char4_d_1849c() {
  // { dg-printf "char4_d_1849c===-4,+4,+3,+0===+2,-1,-6,+2===" }
  char4 var1 = (char4) (-4,4,3,0);
  char4 var2 = (char4) (2,-1,-6,2);
  int i = printf("char4_d_1849c===%+v4hhd===%+v4hhd===\n",var1,var2);
  return i;
}

int char4_d_2609c() {
  // { dg-printf "char4_d_2609c===4,7,0,4===-1,6,-1,5===" }
  char4 var1 = (char4) (4,7,0,4);
  char4 var2 = (char4) (-1,6,-1,5);
  int i = printf("char4_d_2609c===%#v4hhd===%#v4hhd===\n",var1,var2);
  return i;
}

int char4_d_329c() {
  // { dg-printf "char4_d_329c===7,-5,-4,-8===8,-6,4,2===" }
  char4 var1 = (char4) (7,-5,-4,-8);
  char4 var2 = (char4) (8,-6,4,2);
  int i = printf("char4_d_329c===%v4hhd===%v4hhd===\n",var1,var2);
  return i;
}

int char4_d_3369c() {
  // { dg-printf "char4_d_3369c===-5,-63,-6,-5===+3,-5,-63,-4===" }
  char4 var1 = (char4) (-5,-123455,-6,-5);
  char4 var2 = (char4) (3,-5,-123455,-4);
  int i = printf("char4_d_3369c===%-+v4hhd===%-+v4hhd===\n",var1,var2);
  return i;
}

int char4_d_4129c() {
  // { dg-printf "char4_d_4129c===        -6,         5,        -1,         4===        -5,        -6,        -7,        -1===" }
  char4 var1 = (char4) (-6,5,-1,4);
  char4 var2 = (char4) (-5,-6,-7,-1);
  int i = printf("char4_d_4129c===% 10v4hhd===% 10v4hhd===\n",var1,var2);
  return i;
}

int char4_d_4889c() {
  // { dg-printf "char4_d_4889c===0000000053,0000000001,-000000002,0000000007===0000000007,-000000003,0000000005,0000000006===" }
  char4 var1 = (char4) (123445,1,-2,7);
  char4 var2 = (char4) (7,-3,5,6);
  int i = printf("char4_d_4889c===%010v4hhd===%010v4hhd===\n",var1,var2);
  return i;
}

int char4_d_5649c() {
  // { dg-printf "char4_d_5649c===-63       ,-7        , 3        ,-5        === 5        , 53       , 1        , 53       ===" }
  char4 var1 = (char4) (-123455,-7,3,-5);
  char4 var2 = (char4) (5,123445,1,123445);
  int i = printf("char4_d_5649c===%- 10v4hhd===%- 10v4hhd===\n",var1,var2);
  return i;
}

int char4_d_6409c() {
  // { dg-printf "char4_d_6409c===        -7,        -8,        -8,        +6===        -2,        +5,        +6,       -63===" }
  char4 var1 = (char4) (-7,-8,-8,6);
  char4 var2 = (char4) (-2,5,6,-123455);
  int i = printf("char4_d_6409c===%+ 10v4hhd===%+ 10v4hhd===\n",var1,var2);
  return i;
}

int char4_d_7169c() {
  // { dg-printf "char4_d_7169c===-000000008,+000000053,+000000000,+000000002===-000000007,-000000008,+000000001,-000000006===" }
  char4 var1 = (char4) (-8,123445,0,2);
  char4 var2 = (char4) (-7,-8,1,-6);
  int i = printf("char4_d_7169c===%+010v4hhd===%+010v4hhd===\n",var1,var2);
  return i;
}

int char4_i_1090c() {
  // { dg-printf "char4_i_1090c===3,1,-2,5===-6,-6,8,3===" }
  char4 var1 = (char4) (3,1,-2,5);
  char4 var2 = (char4) (-6,-6,8,3);
  int i = printf("char4_i_1090c===%-v4hhi===%-v4hhi===\n",var1,var2);
  return i;
}

int char4_i_1850c() {
  // { dg-printf "char4_i_1850c===+3,-1,+53,+0===+6,+6,-4,+6===" }
  char4 var1 = (char4) (3,-1,123445,0);
  char4 var2 = (char4) (6,6,-4,6);
  int i = printf("char4_i_1850c===%+v4hhi===%+v4hhi===\n",var1,var2);
  return i;
}

int char4_i_2610c() {
  // { dg-printf "char4_i_2610c===3,7,-3,0===53,-4,-1,53===" }
  char4 var1 = (char4) (3,7,-3,0);
  char4 var2 = (char4) (123445,-4,-1,123445);
  int i = printf("char4_i_2610c===%#v4hhi===%#v4hhi===\n",var1,var2);
  return i;
}

int char4_i_330c() {
  // { dg-printf "char4_i_330c===6,-2,-6,-1===4,2,4,3===" }
  char4 var1 = (char4) (6,-2,-6,-1);
  char4 var2 = (char4) (4,2,4,3);
  int i = printf("char4_i_330c===%v4hhi===%v4hhi===\n",var1,var2);
  return i;
}

int char4_i_3370c() {
  // { dg-printf "char4_i_3370c===-1,+6,+7,+6===+8,-5,+8,+5===" }
  char4 var1 = (char4) (-1,6,7,6);
  char4 var2 = (char4) (8,-5,8,5);
  int i = printf("char4_i_3370c===%-+v4hhi===%-+v4hhi===\n",var1,var2);
  return i;
}

int char4_i_4130c() {
  // { dg-printf "char4_i_4130c===         4,         5,        53,        -6===        -7,         1,        -7,        -3===" }
  char4 var1 = (char4) (4,5,123445,-6);
  char4 var2 = (char4) (-7,1,-7,-3);
  int i = printf("char4_i_4130c===% 10v4hhi===% 10v4hhi===\n",var1,var2);
  return i;
}

int char4_i_4890c() {
  // { dg-printf "char4_i_4890c===-000000007,-000000007,0000000004,-000000063===-000000003,-000000004,-000000006,0000000001===" }
  char4 var1 = (char4) (-7,-7,4,-123455);
  char4 var2 = (char4) (-3,-4,-6,1);
  int i = printf("char4_i_4890c===%010v4hhi===%010v4hhi===\n",var1,var2);
  return i;
}

int char4_i_5650c() {
  // { dg-printf "char4_i_5650c===-6        ,-7        ,-2        , 1        === 5        , 53       ,-6        , 4        ===" }
  char4 var1 = (char4) (-6,-7,-2,1);
  char4 var2 = (char4) (5,123445,-6,4);
  int i = printf("char4_i_5650c===%- 10v4hhi===%- 10v4hhi===\n",var1,var2);
  return i;
}

int char4_i_6410c() {
  // { dg-printf "char4_i_6410c===        -5,        +6,        +8,        +8===        -5,        +4,        +1,        -3===" }
  char4 var1 = (char4) (-5,6,8,8);
  char4 var2 = (char4) (-5,4,1,-3);
  int i = printf("char4_i_6410c===%+ 10v4hhi===%+ 10v4hhi===\n",var1,var2);
  return i;
}

int char4_i_7170c() {
  // { dg-printf "char4_i_7170c===-000000007,+000000001,+000000005,+000000007===+000000004,+000000053,-000000005,-000000003===" }
  char4 var1 = (char4) (-7,1,5,7);
  char4 var2 = (char4) (4,123445,-5,-3);
  int i = printf("char4_i_7170c===%+010v4hhi===%+010v4hhi===\n",var1,var2);
  return i;
}

int char4_o_1091c() {
  // { dg-printf "char4_o_1091c===374,0,7,6===371,373,65,6===" }
  char4 var1 = (char4) (-4,0,7,6);
  char4 var2 = (char4) (-7,-5,123445,6);
  int i = printf("char4_o_1091c===%-v4hho===%-v4hho===\n",var1,var2);
  return i;
}

int char4_o_1851c() {
  // { dg-printf "char4_o_1851c===6,375,65,377===375,376,4,373===" }
  char4 var1 = (char4) (6,-3,123445,-1);
  char4 var2 = (char4) (-3,-2,4,-5);
  int i = printf("char4_o_1851c===%+v4hho===%+v4hho===\n",var1,var2);
  return i;
}

int char4_o_2611c() {
  // { dg-printf "char4_o_2611c===0377,0375,0375,01===0374,0373,03,0301===" }
  char4 var1 = (char4) (-1,-3,-3,1);
  char4 var2 = (char4) (-4,-5,3,-123455);
  int i = printf("char4_o_2611c===%#v4hho===%#v4hho===\n",var1,var2);
  return i;
}

int char4_o_331c() {
  // { dg-printf "char4_o_331c===374,1,371,4===2,370,375,4===" }
  char4 var1 = (char4) (-4,1,-7,4);
  char4 var2 = (char4) (2,-8,-3,4);
  int i = printf("char4_o_331c===%v4hho===%v4hho===\n",var1,var2);
  return i;
}

int char4_o_3371c() {
  // { dg-printf "char4_o_3371c===65,374,2,3===377,370,2,376===" }
  char4 var1 = (char4) (123445,-4,2,3);
  char4 var2 = (char4) (-1,-8,2,-2);
  int i = printf("char4_o_3371c===%-+v4hho===%-+v4hho===\n",var1,var2);
  return i;
}

int char4_o_4131c() {
  // { dg-printf "char4_o_4131c===        10,        65,       373,       375===       375,       374,       377,         2===" }
  char4 var1 = (char4) (8,123445,-5,-3);
  char4 var2 = (char4) (-3,-4,-1,2);
  int i = printf("char4_o_4131c===% 10v4hho===% 10v4hho===\n",var1,var2);
  return i;
}

int char4_o_4891c() {
  // { dg-printf "char4_o_4891c===0000000374,0000000375,0000000371,0000000003===0000000004,0000000010,0000000005,0000000010===" }
  char4 var1 = (char4) (-4,-3,-7,3);
  char4 var2 = (char4) (4,8,5,8);
  int i = printf("char4_o_4891c===%010v4hho===%010v4hho===\n",var1,var2);
  return i;
}

int char4_o_5651c() {
  // { dg-printf "char4_o_5651c===372       ,373       ,373       ,3         ===1         ,371       ,10        ,370       ===" }
  char4 var1 = (char4) (-6,-5,-5,3);
  char4 var2 = (char4) (1,-7,8,-8);
  int i = printf("char4_o_5651c===%- 10v4hho===%- 10v4hho===\n",var1,var2);
  return i;
}

int char4_o_6411c() {
  // { dg-printf "char4_o_6411c===         5,       370,         7,         2===       376,         3,         7,        65===" }
  char4 var1 = (char4) (5,-8,7,2);
  char4 var2 = (char4) (-2,3,7,123445);
  int i = printf("char4_o_6411c===%+ 10v4hho===%+ 10v4hho===\n",var1,var2);
  return i;
}

int char4_o_7171c() {
  // { dg-printf "char4_o_7171c===0000000370,0000000007,0000000000,0000000000===0000000005,0000000010,0000000065,0000000000===" }
  char4 var1 = (char4) (-8,7,0,0);
  char4 var2 = (char4) (5,8,123445,0);
  int i = printf("char4_o_7171c===%+010v4hho===%+010v4hho===\n",var1,var2);
  return i;
}

int char4_u_1092c() {
  // { dg-printf "char4_u_1092c===250,250,4,254===255,8,249,253===" }
  char4 var1 = (char4) (-6,-6,4,-2);
  char4 var2 = (char4) (-1,8,-7,-3);
  int i = printf("char4_u_1092c===%-v4hhu===%-v4hhu===\n",var1,var2);
  return i;
}

int char4_u_1852c() {
  // { dg-printf "char4_u_1852c===2,7,53,251===255,1,251,6===" }
  char4 var1 = (char4) (2,7,123445,-5);
  char4 var2 = (char4) (-1,1,-5,6);
  int i = printf("char4_u_1852c===%+v4hhu===%+v4hhu===\n",var1,var2);
  return i;
}

int char4_u_2612c() {
  // { dg-printf "char4_u_2612c===2,249,251,255===53,2,253,1===" }
  char4 var1 = (char4) (2,-7,-5,-1);
  char4 var2 = (char4) (123445,2,-3,1);
  int i = printf("char4_u_2612c===%#v4hhu===%#v4hhu===\n",var1,var2);
  return i;
}

int char4_u_332c() {
  // { dg-printf "char4_u_332c===252,250,4,250===250,255,3,7===" }
  char4 var1 = (char4) (-4,-6,4,-6);
  char4 var2 = (char4) (-6,-1,3,7);
  int i = printf("char4_u_332c===%v4hhu===%v4hhu===\n",var1,var2);
  return i;
}

int char4_u_3372c() {
  // { dg-printf "char4_u_3372c===2,252,1,7===248,252,193,4===" }
  char4 var1 = (char4) (2,-4,1,7);
  char4 var2 = (char4) (-8,-4,-123455,4);
  int i = printf("char4_u_3372c===%-+v4hhu===%-+v4hhu===\n",var1,var2);
  return i;
}

int char4_u_4132c() {
  // { dg-printf "char4_u_4132c===         2,         5,         1,       251===        53,         8,       250,       248===" }
  char4 var1 = (char4) (2,5,1,-5);
  char4 var2 = (char4) (123445,8,-6,-8);
  int i = printf("char4_u_4132c===% 10v4hhu===% 10v4hhu===\n",var1,var2);
  return i;
}

int char4_u_4892c() {
  // { dg-printf "char4_u_4892c===0000000001,0000000053,0000000251,0000000053===0000000002,0000000000,0000000003,0000000251===" }
  char4 var1 = (char4) (1,123445,-5,123445);
  char4 var2 = (char4) (2,0,3,-5);
  int i = printf("char4_u_4892c===%010v4hhu===%010v4hhu===\n",var1,var2);
  return i;
}

int char4_u_5652c() {
  // { dg-printf "char4_u_5652c===53        ,254       ,7         ,1         ===4         ,4         ,3         ,4         ===" }
  char4 var1 = (char4) (123445,-2,7,1);
  char4 var2 = (char4) (4,4,3,4);
  int i = printf("char4_u_5652c===%- 10v4hhu===%- 10v4hhu===\n",var1,var2);
  return i;
}

int char4_u_6412c() {
  // { dg-printf "char4_u_6412c===         6,       249,         2,         5===       250,         3,         5,       250===" }
  char4 var1 = (char4) (6,-7,2,5);
  char4 var2 = (char4) (-6,3,5,-6);
  int i = printf("char4_u_6412c===%+ 10v4hhu===%+ 10v4hhu===\n",var1,var2);
  return i;
}

int char4_u_7172c() {
  // { dg-printf "char4_u_7172c===0000000252,0000000193,0000000007,0000000253===0000000250,0000000249,0000000251,0000000249===" }
  char4 var1 = (char4) (-4,-123455,7,-3);
  char4 var2 = (char4) (-6,-7,-5,-7);
  int i = printf("char4_u_7172c===%+010v4hhu===%+010v4hhu===\n",var1,var2);
  return i;
}

int char4_x_1093c() {
  // { dg-printf "char4_x_1093c===3,8,0,fe===3,7,fd,fa===" }
  char4 var1 = (char4) (3,8,0,-2);
  char4 var2 = (char4) (3,7,-3,-6);
  int i = printf("char4_x_1093c===%-v4hhx===%-v4hhx===\n",var1,var2);
  return i;
}

int char4_x_1094c() {
  // { dg-printf "char4_x_1094c===FF,35,F9,FA===4,0,5,8===" }
  char4 var1 = (char4) (-1,123445,-7,-6);
  char4 var2 = (char4) (4,0,5,8);
  int i = printf("char4_x_1094c===%-v4hhX===%-v4hhX===\n",var1,var2);
  return i;
}

int char4_x_1853c() {
  // { dg-printf "char4_x_1853c===2,fb,2,8===35,6,3,3===" }
  char4 var1 = (char4) (2,-5,2,8);
  char4 var2 = (char4) (123445,6,3,3);
  int i = printf("char4_x_1853c===%+v4hhx===%+v4hhx===\n",var1,var2);
  return i;
}

int char4_x_1854c() {
  // { dg-printf "char4_x_1854c===5,F9,F9,FA===FE,0,FF,6===" }
  char4 var1 = (char4) (5,-7,-7,-6);
  char4 var2 = (char4) (-2,0,-1,6);
  int i = printf("char4_x_1854c===%+v4hhX===%+v4hhX===\n",var1,var2);
  return i;
}

int char4_x_2613c() {
  // { dg-printf "char4_x_2613c===0xf8,0x1,0x3,0x8===0xfd,0xff,0x6,0xf8===" }
  char4 var1 = (char4) (-8,1,3,8);
  char4 var2 = (char4) (-3,-1,6,-8);
  int i = printf("char4_x_2613c===%#v4hhx===%#v4hhx===\n",var1,var2);
  return i;
}

int char4_x_2614c() {
  // { dg-printf "char4_x_2614c===0XFC,0XFA,0X6,0XFA===0XFB,0X7,0XFA,0XFC===" }
  char4 var1 = (char4) (-4,-6,6,-6);
  char4 var2 = (char4) (-5,7,-6,-4);
  int i = printf("char4_x_2614c===%#v4hhX===%#v4hhX===\n",var1,var2);
  return i;
}

int char4_x_333c() {
  // { dg-printf "char4_x_333c===fe,35,fd,8===c1,7,1,fb===" }
  char4 var1 = (char4) (-2,123445,-3,8);
  char4 var2 = (char4) (-123455,7,1,-5);
  int i = printf("char4_x_333c===%v4hhx===%v4hhx===\n",var1,var2);
  return i;
}

int char4_x_334c() {
  // { dg-printf "char4_x_334c===4,8,3,FD===8,FD,2,F9===" }
  char4 var1 = (char4) (4,8,3,-3);
  char4 var2 = (char4) (8,-3,2,-7);
  int i = printf("char4_x_334c===%v4hhX===%v4hhX===\n",var1,var2);
  return i;
}

int char4_x_3373c() {
  // { dg-printf "char4_x_3373c===fd,2,f8,6===7,5,f9,fd===" }
  char4 var1 = (char4) (-3,2,-8,6);
  char4 var2 = (char4) (7,5,-7,-3);
  int i = printf("char4_x_3373c===%-+v4hhx===%-+v4hhx===\n",var1,var2);
  return i;
}

int char4_x_3374c() {
  // { dg-printf "char4_x_3374c===7,FD,FD,3===FC,FD,4,FF===" }
  char4 var1 = (char4) (7,-3,-3,3);
  char4 var2 = (char4) (-4,-3,4,-1);
  int i = printf("char4_x_3374c===%-+v4hhX===%-+v4hhX===\n",var1,var2);
  return i;
}

int char4_x_4133c() {
  // { dg-printf "char4_x_4133c===        ff,        fd,         5,        c1===         0,        ff,        f9,        fd===" }
  char4 var1 = (char4) (-1,-3,5,-123455);
  char4 var2 = (char4) (0,-1,-7,-3);
  int i = printf("char4_x_4133c===% 10v4hhx===% 10v4hhx===\n",var1,var2);
  return i;
}

int char4_x_4134c() {
  // { dg-printf "char4_x_4134c===         7,        FA,         7,         5===         2,         3,        FA,        FB===" }
  char4 var1 = (char4) (7,-6,7,5);
  char4 var2 = (char4) (2,3,-6,-5);
  int i = printf("char4_x_4134c===% 10v4hhX===% 10v4hhX===\n",var1,var2);
  return i;
}

int char4_x_4893c() {
  // { dg-printf "char4_x_4893c===0000000005,0000000008,00000000c1,0000000004===0000000000,0000000006,0000000001,0000000007===" }
  char4 var1 = (char4) (5,8,-123455,4);
  char4 var2 = (char4) (0,6,1,7);
  int i = printf("char4_x_4893c===%010v4hhx===%010v4hhx===\n",var1,var2);
  return i;
}

int char4_x_4894c() {
  // { dg-printf "char4_x_4894c===00000000F9,0000000007,00000000C1,0000000008===0000000000,0000000003,0000000006,0000000005===" }
  char4 var1 = (char4) (-7,7,-123455,8);
  char4 var2 = (char4) (0,3,6,5);
  int i = printf("char4_x_4894c===%010v4hhX===%010v4hhX===\n",var1,var2);
  return i;
}

int char4_x_5653c() {
  // { dg-printf "char4_x_5653c===fc        ,6         ,fe        ,fb        ===7         ,fc        ,8         ,5         ===" }
  char4 var1 = (char4) (-4,6,-2,-5);
  char4 var2 = (char4) (7,-4,8,5);
  int i = printf("char4_x_5653c===%- 10v4hhx===%- 10v4hhx===\n",var1,var2);
  return i;
}

int char4_x_5654c() {
  // { dg-printf "char4_x_5654c===2         ,C1        ,1         ,6         ===6         ,FA        ,5         ,C1        ===" }
  char4 var1 = (char4) (2,-123455,1,6);
  char4 var2 = (char4) (6,-6,5,-123455);
  int i = printf("char4_x_5654c===%- 10v4hhX===%- 10v4hhX===\n",var1,var2);
  return i;
}

int char4_x_6413c() {
  // { dg-printf "char4_x_6413c===         4,        c1,         0,        fb===        f8,         1,         3,        ff===" }
  char4 var1 = (char4) (4,-123455,0,-5);
  char4 var2 = (char4) (-8,1,3,-1);
  int i = printf("char4_x_6413c===%+ 10v4hhx===%+ 10v4hhx===\n",var1,var2);
  return i;
}

int char4_x_6414c() {
  // { dg-printf "char4_x_6414c===         4,        35,        FC,        FE===         3,        FB,         7,        FC===" }
  char4 var1 = (char4) (4,123445,-4,-2);
  char4 var2 = (char4) (3,-5,7,-4);
  int i = printf("char4_x_6414c===%+ 10v4hhX===%+ 10v4hhX===\n",var1,var2);
  return i;
}

int char4_x_7173c() {
  // { dg-printf "char4_x_7173c===00000000fd,0000000003,00000000c1,00000000fd===00000000c1,0000000001,00000000c1,0000000006===" }
  char4 var1 = (char4) (-3,3,-123455,-3);
  char4 var2 = (char4) (-123455,1,-123455,6);
  int i = printf("char4_x_7173c===%+010v4hhx===%+010v4hhx===\n",var1,var2);
  return i;
}

int char4_x_7174c() {
  // { dg-printf "char4_x_7174c===0000000008,00000000FC,0000000004,00000000FB===0000000008,0000000007,00000000FA,00000000FA===" }
  char4 var1 = (char4) (8,-4,4,-5);
  char4 var2 = (char4) (8,7,-6,-6);
  int i = printf("char4_x_7174c===%+010v4hhX===%+010v4hhX===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = char4_d_1089c();
i = char4_d_1849c();
i = char4_d_2609c();
i = char4_d_329c();
i = char4_d_3369c();
i = char4_d_4129c();
i = char4_d_4889c();
i = char4_d_5649c();
i = char4_d_6409c();
i = char4_d_7169c();
i = char4_i_1090c();
i = char4_i_1850c();
i = char4_i_2610c();
i = char4_i_330c();
i = char4_i_3370c();
i = char4_i_4130c();
i = char4_i_4890c();
i = char4_i_5650c();
i = char4_i_6410c();
i = char4_i_7170c();
i = char4_o_1091c();
i = char4_o_1851c();
i = char4_o_2611c();
i = char4_o_331c();
i = char4_o_3371c();
i = char4_o_4131c();
i = char4_o_4891c();
i = char4_o_5651c();
i = char4_o_6411c();
i = char4_o_7171c();
i = char4_u_1092c();
i = char4_u_1852c();
i = char4_u_2612c();
i = char4_u_332c();
i = char4_u_3372c();
i = char4_u_4132c();
i = char4_u_4892c();
i = char4_u_5652c();
i = char4_u_6412c();
i = char4_u_7172c();
i = char4_x_1093c();
i = char4_x_1094c();
i = char4_x_1853c();
i = char4_x_1854c();
i = char4_x_2613c();
i = char4_x_2614c();
i = char4_x_333c();
i = char4_x_334c();
i = char4_x_3373c();
i = char4_x_3374c();
i = char4_x_4133c();
i = char4_x_4134c();
i = char4_x_4893c();
i = char4_x_4894c();
i = char4_x_5653c();
i = char4_x_5654c();
i = char4_x_6413c();
i = char4_x_6414c();
i = char4_x_7173c();
i = char4_x_7174c();
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
