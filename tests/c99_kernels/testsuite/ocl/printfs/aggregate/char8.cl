/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/char8.c'  */

int char8_d_1233c() {
  // { dg-printf "char8_d_1233c===-7,-4,-8,53,0,-6,2,-5===5,-1,-1,-4,-2,-1,0,1===" }
  char8 var1 = (char8) (-7,-4,-8,123445,0,-6,2,-5);
  char8 var2 = (char8) (5,-1,-1,-4,-2,-1,0,1);
  int i = printf("char8_d_1233c===%-v8hhd===%-v8hhd===\n",var1,var2);
  return i;
}

int char8_d_1993c() {
  // { dg-printf "char8_d_1993c===+0,+53,-5,-2,+3,+53,+53,-2===-5,-5,-2,+4,+2,+8,+53,-63===" }
  char8 var1 = (char8) (0,123445,-5,-2,3,123445,123445,-2);
  char8 var2 = (char8) (-5,-5,-2,4,2,8,123445,-123455);
  int i = printf("char8_d_1993c===%+v8hhd===%+v8hhd===\n",var1,var2);
  return i;
}

int char8_d_2753c() {
  // { dg-printf "char8_d_2753c===-6,-7,-1,-4,4,6,1,-6===1,3,-8,7,1,-63,6,-6===" }
  char8 var1 = (char8) (-6,-7,-1,-4,4,6,1,-6);
  char8 var2 = (char8) (1,3,-8,7,1,-123455,6,-6);
  int i = printf("char8_d_2753c===%#v8hhd===%#v8hhd===\n",var1,var2);
  return i;
}

int char8_d_3513c() {
  // { dg-printf "char8_d_3513c===+0,-63,+7,-3,+3,+2,-2,+3===-7,-1,+6,+3,+5,-5,-8,-7===" }
  char8 var1 = (char8) (0,-123455,7,-3,3,2,-2,3);
  char8 var2 = (char8) (-7,-1,6,3,5,-5,-8,-7);
  int i = printf("char8_d_3513c===%-+v8hhd===%-+v8hhd===\n",var1,var2);
  return i;
}

int char8_d_4273c() {
  // { dg-printf "char8_d_4273c===         7,         6,        -1,         1,         0,         0,        -7,         2===       -63,        -6,        -6,         1,         7,       -63,        53,         2===" }
  char8 var1 = (char8) (7,6,-1,1,0,0,-7,2);
  char8 var2 = (char8) (-123455,-6,-6,1,7,-123455,123445,2);
  int i = printf("char8_d_4273c===% 10v8hhd===% 10v8hhd===\n",var1,var2);
  return i;
}

int char8_d_473c() {
  // { dg-printf "char8_d_473c===8,6,1,7,-8,-4,-7,53===1,4,1,53,-6,1,0,0===" }
  char8 var1 = (char8) (8,6,1,7,-8,-4,-7,123445);
  char8 var2 = (char8) (1,4,1,123445,-6,1,0,0);
  int i = printf("char8_d_473c===%v8hhd===%v8hhd===\n",var1,var2);
  return i;
}

int char8_d_5033c() {
  // { dg-printf "char8_d_5033c===-000000006,0000000006,0000000004,-000000006,-000000008,-000000003,0000000006,-000000063===-000000005,-000000001,0000000000,0000000003,0000000008,-000000007,-000000005,-000000008===" }
  char8 var1 = (char8) (-6,6,4,-6,-8,-3,6,-123455);
  char8 var2 = (char8) (-5,-1,0,3,8,-7,-5,-8);
  int i = printf("char8_d_5033c===%010v8hhd===%010v8hhd===\n",var1,var2);
  return i;
}

int char8_d_5793c() {
  // { dg-printf "char8_d_5793c=== 5        , 5        , 1        , 1        , 8        ,-4        ,-6        , 1        ===-63       ,-1        , 53       , 2        , 6        , 53       ,-8        , 4        ===" }
  char8 var1 = (char8) (5,5,1,1,8,-4,-6,1);
  char8 var2 = (char8) (-123455,-1,123445,2,6,123445,-8,4);
  int i = printf("char8_d_5793c===%- 10v8hhd===%- 10v8hhd===\n",var1,var2);
  return i;
}

int char8_d_6553c() {
  // { dg-printf "char8_d_6553c===        +8,        +5,        +3,        -6,        +5,        +0,        +7,        +2===        +8,        +7,       +53,        -1,        -6,        +1,       -63,        +8===" }
  char8 var1 = (char8) (8,5,3,-6,5,0,7,2);
  char8 var2 = (char8) (8,7,123445,-1,-6,1,-123455,8);
  int i = printf("char8_d_6553c===%+ 10v8hhd===%+ 10v8hhd===\n",var1,var2);
  return i;
}

int char8_d_7313c() {
  // { dg-printf "char8_d_7313c===+000000001,+000000002,+000000004,+000000002,+000000001,+000000007,-000000002,+000000007===-000000004,+000000002,+000000008,-000000063,+000000006,+000000000,+000000004,+000000004===" }
  char8 var1 = (char8) (1,2,4,2,1,7,-2,7);
  char8 var2 = (char8) (-4,2,8,-123455,6,0,4,4);
  int i = printf("char8_d_7313c===%+010v8hhd===%+010v8hhd===\n",var1,var2);
  return i;
}

int char8_i_1234c() {
  // { dg-printf "char8_i_1234c===2,8,-7,3,0,-63,-63,-8===4,1,3,-63,8,-1,53,-1===" }
  char8 var1 = (char8) (2,8,-7,3,0,-123455,-123455,-8);
  char8 var2 = (char8) (4,1,3,-123455,8,-1,123445,-1);
  int i = printf("char8_i_1234c===%-v8hhi===%-v8hhi===\n",var1,var2);
  return i;
}

int char8_i_1994c() {
  // { dg-printf "char8_i_1994c===+53,+1,+7,+0,-4,-63,+0,-3===+5,-8,+6,+8,-3,+8,+6,-3===" }
  char8 var1 = (char8) (123445,1,7,0,-4,-123455,0,-3);
  char8 var2 = (char8) (5,-8,6,8,-3,8,6,-3);
  int i = printf("char8_i_1994c===%+v8hhi===%+v8hhi===\n",var1,var2);
  return i;
}

int char8_i_2754c() {
  // { dg-printf "char8_i_2754c===0,-6,-1,-2,53,-63,7,-4===1,-6,-2,-8,-3,8,-3,8===" }
  char8 var1 = (char8) (0,-6,-1,-2,123445,-123455,7,-4);
  char8 var2 = (char8) (1,-6,-2,-8,-3,8,-3,8);
  int i = printf("char8_i_2754c===%#v8hhi===%#v8hhi===\n",var1,var2);
  return i;
}

int char8_i_3514c() {
  // { dg-printf "char8_i_3514c===-63,+8,-1,-8,+2,-1,+2,-6===+53,-5,-63,+7,+5,+5,-1,-3===" }
  char8 var1 = (char8) (-123455,8,-1,-8,2,-1,2,-6);
  char8 var2 = (char8) (123445,-5,-123455,7,5,5,-1,-3);
  int i = printf("char8_i_3514c===%-+v8hhi===%-+v8hhi===\n",var1,var2);
  return i;
}

int char8_i_4274c() {
  // { dg-printf "char8_i_4274c===        -7,         6,         5,         3,        -1,        53,        53,        -3===        -6,         8,         8,        -8,         1,         5,        53,         3===" }
  char8 var1 = (char8) (-7,6,5,3,-1,123445,123445,-3);
  char8 var2 = (char8) (-6,8,8,-8,1,5,123445,3);
  int i = printf("char8_i_4274c===% 10v8hhi===% 10v8hhi===\n",var1,var2);
  return i;
}

int char8_i_474c() {
  // { dg-printf "char8_i_474c===53,-7,-3,-2,-8,8,6,-3===-5,5,0,8,53,-4,-63,-2===" }
  char8 var1 = (char8) (123445,-7,-3,-2,-8,8,6,-3);
  char8 var2 = (char8) (-5,5,0,8,123445,-4,-123455,-2);
  int i = printf("char8_i_474c===%v8hhi===%v8hhi===\n",var1,var2);
  return i;
}

int char8_i_5034c() {
  // { dg-printf "char8_i_5034c===-000000005,-000000001,-000000008,-000000008,-000000007,0000000003,-000000008,-000000006===0000000006,0000000053,0000000000,0000000005,0000000001,0000000001,0000000053,-000000003===" }
  char8 var1 = (char8) (-5,-1,-8,-8,-7,3,-8,-6);
  char8 var2 = (char8) (6,123445,0,5,1,1,123445,-3);
  int i = printf("char8_i_5034c===%010v8hhi===%010v8hhi===\n",var1,var2);
  return i;
}

int char8_i_5794c() {
  // { dg-printf "char8_i_5794c=== 53       ,-6        , 7        , 0        , 5        ,-5        , 53       ,-5        === 6        , 0        ,-5        ,-7        , 3        ,-4        ,-3        , 53       ===" }
  char8 var1 = (char8) (123445,-6,7,0,5,-5,123445,-5);
  char8 var2 = (char8) (6,0,-5,-7,3,-4,-3,123445);
  int i = printf("char8_i_5794c===%- 10v8hhi===%- 10v8hhi===\n",var1,var2);
  return i;
}

int char8_i_6554c() {
  // { dg-printf "char8_i_6554c===        +4,        +2,        -1,        -2,        +0,        +6,        -8,        -1===        -6,        -7,        -3,        +7,        -7,        -2,        +1,       -63===" }
  char8 var1 = (char8) (4,2,-1,-2,0,6,-8,-1);
  char8 var2 = (char8) (-6,-7,-3,7,-7,-2,1,-123455);
  int i = printf("char8_i_6554c===%+ 10v8hhi===%+ 10v8hhi===\n",var1,var2);
  return i;
}

int char8_i_7314c() {
  // { dg-printf "char8_i_7314c===-000000006,+000000001,+000000005,-000000001,+000000003,+000000003,-000000007,-000000006===+000000006,-000000004,+000000000,-000000003,-000000007,+000000003,-000000003,+000000000===" }
  char8 var1 = (char8) (-6,1,5,-1,3,3,-7,-6);
  char8 var2 = (char8) (6,-4,0,-3,-7,3,-3,0);
  int i = printf("char8_i_7314c===%+010v8hhi===%+010v8hhi===\n",var1,var2);
  return i;
}

int char8_o_1235c() {
  // { dg-printf "char8_o_1235c===6,370,375,5,377,10,65,376===370,0,3,371,10,3,375,65===" }
  char8 var1 = (char8) (6,-8,-3,5,-1,8,123445,-2);
  char8 var2 = (char8) (-8,0,3,-7,8,3,-3,123445);
  int i = printf("char8_o_1235c===%-v8hho===%-v8hho===\n",var1,var2);
  return i;
}

int char8_o_1995c() {
  // { dg-printf "char8_o_1995c===370,375,2,4,10,65,65,3===370,370,65,376,0,374,374,7===" }
  char8 var1 = (char8) (-8,-3,2,4,8,123445,123445,3);
  char8 var2 = (char8) (-8,-8,123445,-2,0,-4,-4,7);
  int i = printf("char8_o_1995c===%+v8hho===%+v8hho===\n",var1,var2);
  return i;
}

int char8_o_2755c() {
  // { dg-printf "char8_o_2755c===0,0372,03,065,0373,0373,07,07===02,0377,0376,0301,0370,0376,065,0374===" }
  char8 var1 = (char8) (0,-6,3,123445,-5,-5,7,7);
  char8 var2 = (char8) (2,-1,-2,-123455,-8,-2,123445,-4);
  int i = printf("char8_o_2755c===%#v8hho===%#v8hho===\n",var1,var2);
  return i;
}

int char8_o_3515c() {
  // { dg-printf "char8_o_3515c===301,372,1,373,6,376,371,2===377,1,370,4,1,5,7,6===" }
  char8 var1 = (char8) (-123455,-6,1,-5,6,-2,-7,2);
  char8 var2 = (char8) (-1,1,-8,4,1,5,7,6);
  int i = printf("char8_o_3515c===%-+v8hho===%-+v8hho===\n",var1,var2);
  return i;
}

int char8_o_4275c() {
  // { dg-printf "char8_o_4275c===         4,        10,       373,       373,         3,       370,       371,        10===       301,       370,         3,       375,         6,       375,       370,       372===" }
  char8 var1 = (char8) (4,8,-5,-5,3,-8,-7,8);
  char8 var2 = (char8) (-123455,-8,3,-3,6,-3,-8,-6);
  int i = printf("char8_o_4275c===% 10v8hho===% 10v8hho===\n",var1,var2);
  return i;
}

int char8_o_475c() {
  // { dg-printf "char8_o_475c===373,5,7,6,374,301,375,373===376,6,301,10,6,301,377,375===" }
  char8 var1 = (char8) (-5,5,7,6,-4,-123455,-3,-5);
  char8 var2 = (char8) (-2,6,-123455,8,6,-123455,-1,-3);
  int i = printf("char8_o_475c===%v8hho===%v8hho===\n",var1,var2);
  return i;
}

int char8_o_5035c() {
  // { dg-printf "char8_o_5035c===0000000376,0000000000,0000000065,0000000372,0000000065,0000000010,0000000373,0000000005===0000000000,0000000065,0000000371,0000000377,0000000374,0000000372,0000000005,0000000007===" }
  char8 var1 = (char8) (-2,0,123445,-6,123445,8,-5,5);
  char8 var2 = (char8) (0,123445,-7,-1,-4,-6,5,7);
  int i = printf("char8_o_5035c===%010v8hho===%010v8hho===\n",var1,var2);
  return i;
}

int char8_o_5795c() {
  // { dg-printf "char8_o_5795c===2         ,373       ,65        ,1         ,4         ,4         ,374       ,4         ===374       ,0         ,4         ,65        ,65        ,5         ,65        ,376       ===" }
  char8 var1 = (char8) (2,-5,123445,1,4,4,-4,4);
  char8 var2 = (char8) (-4,0,4,123445,123445,5,123445,-2);
  int i = printf("char8_o_5795c===%- 10v8hho===%- 10v8hho===\n",var1,var2);
  return i;
}

int char8_o_6555c() {
  // { dg-printf "char8_o_6555c===         7,       370,         4,       371,         7,       371,       372,       370===       372,       375,       373,         6,        10,       374,       374,         1===" }
  char8 var1 = (char8) (7,-8,4,-7,7,-7,-6,-8);
  char8 var2 = (char8) (-6,-3,-5,6,8,-4,-4,1);
  int i = printf("char8_o_6555c===%+ 10v8hho===%+ 10v8hho===\n",var1,var2);
  return i;
}

int char8_o_7315c() {
  // { dg-printf "char8_o_7315c===0000000376,0000000373,0000000003,0000000007,0000000001,0000000001,0000000007,0000000005===0000000371,0000000065,0000000065,0000000377,0000000372,0000000005,0000000370,0000000010===" }
  char8 var1 = (char8) (-2,-5,3,7,1,1,7,5);
  char8 var2 = (char8) (-7,123445,123445,-1,-6,5,-8,8);
  int i = printf("char8_o_7315c===%+010v8hho===%+010v8hho===\n",var1,var2);
  return i;
}

int char8_u_1236c() {
  // { dg-printf "char8_u_1236c===254,252,1,248,4,248,253,1===53,252,0,4,252,0,255,193===" }
  char8 var1 = (char8) (-2,-4,1,-8,4,-8,-3,1);
  char8 var2 = (char8) (123445,-4,0,4,-4,0,-1,-123455);
  int i = printf("char8_u_1236c===%-v8hhu===%-v8hhu===\n",var1,var2);
  return i;
}

int char8_u_1996c() {
  // { dg-printf "char8_u_1996c===193,250,1,6,255,6,250,249===4,4,248,250,1,53,251,8===" }
  char8 var1 = (char8) (-123455,-6,1,6,-1,6,-6,-7);
  char8 var2 = (char8) (4,4,-8,-6,1,123445,-5,8);
  int i = printf("char8_u_1996c===%+v8hhu===%+v8hhu===\n",var1,var2);
  return i;
}

int char8_u_2756c() {
  // { dg-printf "char8_u_2756c===254,254,252,8,251,249,3,6===254,8,250,252,252,7,249,3===" }
  char8 var1 = (char8) (-2,-2,-4,8,-5,-7,3,6);
  char8 var2 = (char8) (-2,8,-6,-4,-4,7,-7,3);
  int i = printf("char8_u_2756c===%#v8hhu===%#v8hhu===\n",var1,var2);
  return i;
}

int char8_u_3516c() {
  // { dg-printf "char8_u_3516c===254,4,255,255,6,6,6,253===7,250,2,0,254,4,248,3===" }
  char8 var1 = (char8) (-2,4,-1,-1,6,6,6,-3);
  char8 var2 = (char8) (7,-6,2,0,-2,4,-8,3);
  int i = printf("char8_u_3516c===%-+v8hhu===%-+v8hhu===\n",var1,var2);
  return i;
}

int char8_u_4276c() {
  // { dg-printf "char8_u_4276c===       193,         1,       193,       248,         4,         6,       254,       249===       193,       252,         0,       251,       250,        53,       253,       193===" }
  char8 var1 = (char8) (-123455,1,-123455,-8,4,6,-2,-7);
  char8 var2 = (char8) (-123455,-4,0,-5,-6,123445,-3,-123455);
  int i = printf("char8_u_4276c===% 10v8hhu===% 10v8hhu===\n",var1,var2);
  return i;
}

int char8_u_476c() {
  // { dg-printf "char8_u_476c===248,5,193,193,1,53,6,252===252,2,8,2,1,193,2,193===" }
  char8 var1 = (char8) (-8,5,-123455,-123455,1,123445,6,-4);
  char8 var2 = (char8) (-4,2,8,2,1,-123455,2,-123455);
  int i = printf("char8_u_476c===%v8hhu===%v8hhu===\n",var1,var2);
  return i;
}

int char8_u_5036c() {
  // { dg-printf "char8_u_5036c===0000000251,0000000250,0000000254,0000000004,0000000007,0000000006,0000000005,0000000254===0000000001,0000000255,0000000004,0000000254,0000000004,0000000004,0000000008,0000000250===" }
  char8 var1 = (char8) (-5,-6,-2,4,7,6,5,-2);
  char8 var2 = (char8) (1,-1,4,-2,4,4,8,-6);
  int i = printf("char8_u_5036c===%010v8hhu===%010v8hhu===\n",var1,var2);
  return i;
}

int char8_u_5796c() {
  // { dg-printf "char8_u_5796c===2         ,254       ,251       ,2         ,254       ,248       ,251       ,0         ===2         ,249       ,248       ,254       ,250       ,5         ,5         ,2         ===" }
  char8 var1 = (char8) (2,-2,-5,2,-2,-8,-5,0);
  char8 var2 = (char8) (2,-7,-8,-2,-6,5,5,2);
  int i = printf("char8_u_5796c===%- 10v8hhu===%- 10v8hhu===\n",var1,var2);
  return i;
}

int char8_u_6556c() {
  // { dg-printf "char8_u_6556c===         7,       254,       193,       249,         6,       252,         4,       251===       250,       255,         0,       255,         3,         5,       249,       255===" }
  char8 var1 = (char8) (7,-2,-123455,-7,6,-4,4,-5);
  char8 var2 = (char8) (-6,-1,0,-1,3,5,-7,-1);
  int i = printf("char8_u_6556c===%+ 10v8hhu===%+ 10v8hhu===\n",var1,var2);
  return i;
}

int char8_u_7316c() {
  // { dg-printf "char8_u_7316c===0000000252,0000000252,0000000005,0000000252,0000000250,0000000000,0000000248,0000000001===0000000250,0000000002,0000000002,0000000007,0000000255,0000000252,0000000249,0000000003===" }
  char8 var1 = (char8) (-4,-4,5,-4,-6,0,-8,1);
  char8 var2 = (char8) (-6,2,2,7,-1,-4,-7,3);
  int i = printf("char8_u_7316c===%+010v8hhu===%+010v8hhu===\n",var1,var2);
  return i;
}

int char8_x_1237c() {
  // { dg-printf "char8_x_1237c===ff,c1,1,7,f9,5,5,1===ff,3,7,c1,c1,5,f9,fc===" }
  char8 var1 = (char8) (-1,-123455,1,7,-7,5,5,1);
  char8 var2 = (char8) (-1,3,7,-123455,-123455,5,-7,-4);
  int i = printf("char8_x_1237c===%-v8hhx===%-v8hhx===\n",var1,var2);
  return i;
}

int char8_x_1238c() {
  // { dg-printf "char8_x_1238c===5,FD,F8,35,FE,5,FC,FB===35,FF,0,4,FA,FC,6,F9===" }
  char8 var1 = (char8) (5,-3,-8,123445,-2,5,-4,-5);
  char8 var2 = (char8) (123445,-1,0,4,-6,-4,6,-7);
  int i = printf("char8_x_1238c===%-v8hhX===%-v8hhX===\n",var1,var2);
  return i;
}

int char8_x_1997c() {
  // { dg-printf "char8_x_1997c===ff,c1,5,1,0,1,ff,c1===f8,2,fe,1,0,f8,ff,8===" }
  char8 var1 = (char8) (-1,-123455,5,1,0,1,-1,-123455);
  char8 var2 = (char8) (-8,2,-2,1,0,-8,-1,8);
  int i = printf("char8_x_1997c===%+v8hhx===%+v8hhx===\n",var1,var2);
  return i;
}

int char8_x_1998c() {
  // { dg-printf "char8_x_1998c===2,2,F9,7,2,6,FE,8===3,0,F8,0,F8,C1,FF,8===" }
  char8 var1 = (char8) (2,2,-7,7,2,6,-2,8);
  char8 var2 = (char8) (3,0,-8,0,-8,-123455,-1,8);
  int i = printf("char8_x_1998c===%+v8hhX===%+v8hhX===\n",var1,var2);
  return i;
}

int char8_x_2757c() {
  // { dg-printf "char8_x_2757c===0xfb,0xf9,0xfd,0x7,0x35,0x8,0x6,0xff===0xf9,0xfc,0x7,0xfe,0x7,0xfd,0xf8,0x4===" }
  char8 var1 = (char8) (-5,-7,-3,7,123445,8,6,-1);
  char8 var2 = (char8) (-7,-4,7,-2,7,-3,-8,4);
  int i = printf("char8_x_2757c===%#v8hhx===%#v8hhx===\n",var1,var2);
  return i;
}

int char8_x_2758c() {
  // { dg-printf "char8_x_2758c===0X1,0X7,0X5,0XF9,0X2,0X2,0X7,0X5===0XFE,0XC1,0XC1,0X4,0X35,0XFB,0XC1,0X35===" }
  char8 var1 = (char8) (1,7,5,-7,2,2,7,5);
  char8 var2 = (char8) (-2,-123455,-123455,4,123445,-5,-123455,123445);
  int i = printf("char8_x_2758c===%#v8hhX===%#v8hhX===\n",var1,var2);
  return i;
}

int char8_x_3517c() {
  // { dg-printf "char8_x_3517c===8,2,2,fb,fc,0,0,f8===4,2,f9,fb,c1,6,2,ff===" }
  char8 var1 = (char8) (8,2,2,-5,-4,0,0,-8);
  char8 var2 = (char8) (4,2,-7,-5,-123455,6,2,-1);
  int i = printf("char8_x_3517c===%-+v8hhx===%-+v8hhx===\n",var1,var2);
  return i;
}

int char8_x_3518c() {
  // { dg-printf "char8_x_3518c===F8,6,FF,7,35,FB,F8,C1===FF,FE,1,8,4,35,2,FE===" }
  char8 var1 = (char8) (-8,6,-1,7,123445,-5,-8,-123455);
  char8 var2 = (char8) (-1,-2,1,8,4,123445,2,-2);
  int i = printf("char8_x_3518c===%-+v8hhX===%-+v8hhX===\n",var1,var2);
  return i;
}

int char8_x_4277c() {
  // { dg-printf "char8_x_4277c===        ff,         5,         5,        fb,        fc,        f8,         7,         1===         2,        f9,         2,        fe,         7,         1,         5,         4===" }
  char8 var1 = (char8) (-1,5,5,-5,-4,-8,7,1);
  char8 var2 = (char8) (2,-7,2,-2,7,1,5,4);
  int i = printf("char8_x_4277c===% 10v8hhx===% 10v8hhx===\n",var1,var2);
  return i;
}

int char8_x_4278c() {
  // { dg-printf "char8_x_4278c===        FD,         6,         5,         1,         8,        FD,        FC,         6===        FB,        FB,         7,         7,         5,         6,        FF,        FD===" }
  char8 var1 = (char8) (-3,6,5,1,8,-3,-4,6);
  char8 var2 = (char8) (-5,-5,7,7,5,6,-1,-3);
  int i = printf("char8_x_4278c===% 10v8hhX===% 10v8hhX===\n",var1,var2);
  return i;
}

int char8_x_477c() {
  // { dg-printf "char8_x_477c===35,fd,1,0,0,1,f8,fe===2,5,4,f8,fd,ff,ff,f8===" }
  char8 var1 = (char8) (123445,-3,1,0,0,1,-8,-2);
  char8 var2 = (char8) (2,5,4,-8,-3,-1,-1,-8);
  int i = printf("char8_x_477c===%v8hhx===%v8hhx===\n",var1,var2);
  return i;
}

int char8_x_478c() {
  // { dg-printf "char8_x_478c===FA,6,2,F9,FD,3,4,35===F8,7,7,4,1,F8,FE,F8===" }
  char8 var1 = (char8) (-6,6,2,-7,-3,3,4,123445);
  char8 var2 = (char8) (-8,7,7,4,1,-8,-2,-8);
  int i = printf("char8_x_478c===%v8hhX===%v8hhX===\n",var1,var2);
  return i;
}

int char8_x_5037c() {
  // { dg-printf "char8_x_5037c===0000000003,0000000003,0000000006,00000000fa,0000000007,00000000fc,00000000fc,00000000fa===0000000000,0000000008,00000000c1,0000000003,00000000fe,00000000fd,00000000c1,00000000fd===" }
  char8 var1 = (char8) (3,3,6,-6,7,-4,-4,-6);
  char8 var2 = (char8) (0,8,-123455,3,-2,-3,-123455,-3);
  int i = printf("char8_x_5037c===%010v8hhx===%010v8hhx===\n",var1,var2);
  return i;
}

int char8_x_5038c() {
  // { dg-printf "char8_x_5038c===00000000FE,0000000000,0000000004,00000000F8,0000000004,00000000FD,0000000008,0000000008===0000000005,0000000008,00000000F9,0000000006,0000000006,0000000007,0000000001,0000000002===" }
  char8 var1 = (char8) (-2,0,4,-8,4,-3,8,8);
  char8 var2 = (char8) (5,8,-7,6,6,7,1,2);
  int i = printf("char8_x_5038c===%010v8hhX===%010v8hhX===\n",var1,var2);
  return i;
}

int char8_x_5797c() {
  // { dg-printf "char8_x_5797c===fa        ,4         ,ff        ,35        ,c1        ,35        ,8         ,fb        ===fb        ,4         ,c1        ,2         ,35        ,fc        ,fa        ,f8        ===" }
  char8 var1 = (char8) (-6,4,-1,123445,-123455,123445,8,-5);
  char8 var2 = (char8) (-5,4,-123455,2,123445,-4,-6,-8);
  int i = printf("char8_x_5797c===%- 10v8hhx===%- 10v8hhx===\n",var1,var2);
  return i;
}

int char8_x_5798c() {
  // { dg-printf "char8_x_5798c===FA        ,FE        ,7         ,2         ,FE        ,4         ,C1        ,7         ===1         ,8         ,F8        ,FA        ,6         ,3         ,7         ,FC        ===" }
  char8 var1 = (char8) (-6,-2,7,2,-2,4,-123455,7);
  char8 var2 = (char8) (1,8,-8,-6,6,3,7,-4);
  int i = printf("char8_x_5798c===%- 10v8hhX===%- 10v8hhX===\n",var1,var2);
  return i;
}

int char8_x_6557c() {
  // { dg-printf "char8_x_6557c===         0,        fb,        ff,        fa,        fb,        fd,         3,        f8===         8,        fe,         5,         3,         1,         5,        35,        c1===" }
  char8 var1 = (char8) (0,-5,-1,-6,-5,-3,3,-8);
  char8 var2 = (char8) (8,-2,5,3,1,5,123445,-123455);
  int i = printf("char8_x_6557c===%+ 10v8hhx===%+ 10v8hhx===\n",var1,var2);
  return i;
}

int char8_x_6558c() {
  // { dg-printf "char8_x_6558c===         4,        FD,        35,        FE,         8,        35,         1,        FF===         8,         7,         0,         4,        C1,        FB,        FE,        FB===" }
  char8 var1 = (char8) (4,-3,123445,-2,8,123445,1,-1);
  char8 var2 = (char8) (8,7,0,4,-123455,-5,-2,-5);
  int i = printf("char8_x_6558c===%+ 10v8hhX===%+ 10v8hhX===\n",var1,var2);
  return i;
}

int char8_x_7317c() {
  // { dg-printf "char8_x_7317c===00000000fa,0000000005,0000000002,0000000004,0000000007,00000000ff,00000000f9,0000000002===00000000f9,0000000007,0000000005,00000000fc,00000000fd,0000000005,0000000001,00000000c1===" }
  char8 var1 = (char8) (-6,5,2,4,7,-1,-7,2);
  char8 var2 = (char8) (-7,7,5,-4,-3,5,1,-123455);
  int i = printf("char8_x_7317c===%+010v8hhx===%+010v8hhx===\n",var1,var2);
  return i;
}

int char8_x_7318c() {
  // { dg-printf "char8_x_7318c===00000000FA,00000000FC,00000000C1,00000000FA,00000000FE,0000000007,00000000FF,0000000001===00000000F8,0000000003,0000000035,0000000035,00000000FE,0000000004,00000000FB,0000000007===" }
  char8 var1 = (char8) (-6,-4,-123455,-6,-2,7,-1,1);
  char8 var2 = (char8) (-8,3,123445,123445,-2,4,-5,7);
  int i = printf("char8_x_7318c===%+010v8hhX===%+010v8hhX===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = char8_d_1233c();
i = char8_d_1993c();
i = char8_d_2753c();
i = char8_d_3513c();
i = char8_d_4273c();
i = char8_d_473c();
i = char8_d_5033c();
i = char8_d_5793c();
i = char8_d_6553c();
i = char8_d_7313c();
i = char8_i_1234c();
i = char8_i_1994c();
i = char8_i_2754c();
i = char8_i_3514c();
i = char8_i_4274c();
i = char8_i_474c();
i = char8_i_5034c();
i = char8_i_5794c();
i = char8_i_6554c();
i = char8_i_7314c();
i = char8_o_1235c();
i = char8_o_1995c();
i = char8_o_2755c();
i = char8_o_3515c();
i = char8_o_4275c();
i = char8_o_475c();
i = char8_o_5035c();
i = char8_o_5795c();
i = char8_o_6555c();
i = char8_o_7315c();
i = char8_u_1236c();
i = char8_u_1996c();
i = char8_u_2756c();
i = char8_u_3516c();
i = char8_u_4276c();
i = char8_u_476c();
i = char8_u_5036c();
i = char8_u_5796c();
i = char8_u_6556c();
i = char8_u_7316c();
i = char8_x_1237c();
i = char8_x_1238c();
i = char8_x_1997c();
i = char8_x_1998c();
i = char8_x_2757c();
i = char8_x_2758c();
i = char8_x_3517c();
i = char8_x_3518c();
i = char8_x_4277c();
i = char8_x_4278c();
i = char8_x_477c();
i = char8_x_478c();
i = char8_x_5037c();
i = char8_x_5038c();
i = char8_x_5797c();
i = char8_x_5798c();
i = char8_x_6557c();
i = char8_x_6558c();
i = char8_x_7317c();
i = char8_x_7318c();
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
