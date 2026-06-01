/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/char2.c'  */

int char2_d_1705c() {
  // { dg-printf "char2_d_1705c===+7,-7===+0,+6===" }
  char2 var1 = (char2) (7,-7);
  char2 var2 = (char2) (0,6);
  int i = printf("char2_d_1705c===%+v2hhd===%+v2hhd===\n",var1,var2);
  return i;
}

int char2_d_185c() {
  // { dg-printf "char2_d_185c===5,0===-5,5===" }
  char2 var1 = (char2) (5,0);
  char2 var2 = (char2) (-5,5);
  int i = printf("char2_d_185c===%v2hhd===%v2hhd===\n",var1,var2);
  return i;
}

int char2_d_2465c() {
  // { dg-printf "char2_d_2465c===-7,-5===-63,53===" }
  char2 var1 = (char2) (-7,-5);
  char2 var2 = (char2) (-123455,123445);
  int i = printf("char2_d_2465c===%#v2hhd===%#v2hhd===\n",var1,var2);
  return i;
}

int char2_d_3225c() {
  // { dg-printf "char2_d_3225c===-2,+4===-8,-3===" }
  char2 var1 = (char2) (-2,4);
  char2 var2 = (char2) (-8,-3);
  int i = printf("char2_d_3225c===%-+v2hhd===%-+v2hhd===\n",var1,var2);
  return i;
}

int char2_d_3985c() {
  // { dg-printf "char2_d_3985c===         2,        -5===        -8,        -8===" }
  char2 var1 = (char2) (2,-5);
  char2 var2 = (char2) (-8,-8);
  int i = printf("char2_d_3985c===% 10v2hhd===% 10v2hhd===\n",var1,var2);
  return i;
}

int char2_d_4745c() {
  // { dg-printf "char2_d_4745c===-000000004,-000000004===-000000007,0000000001===" }
  char2 var1 = (char2) (-4,-4);
  char2 var2 = (char2) (-7,1);
  int i = printf("char2_d_4745c===%010v2hhd===%010v2hhd===\n",var1,var2);
  return i;
}

int char2_d_5505c() {
  // { dg-printf "char2_d_5505c===-4        , 6        === 8        , 0        ===" }
  char2 var1 = (char2) (-4,6);
  char2 var2 = (char2) (8,0);
  int i = printf("char2_d_5505c===%- 10v2hhd===%- 10v2hhd===\n",var1,var2);
  return i;
}

int char2_d_6265c() {
  // { dg-printf "char2_d_6265c===        +7,       +53===       +53,        -3===" }
  char2 var1 = (char2) (7,123445);
  char2 var2 = (char2) (123445,-3);
  int i = printf("char2_d_6265c===%+ 10v2hhd===%+ 10v2hhd===\n",var1,var2);
  return i;
}

int char2_d_7025c() {
  // { dg-printf "char2_d_7025c===-000000004,+000000006===-000000008,-000000006===" }
  char2 var1 = (char2) (-4,6);
  char2 var2 = (char2) (-8,-6);
  int i = printf("char2_d_7025c===%+010v2hhd===%+010v2hhd===\n",var1,var2);
  return i;
}

int char2_d_945c() {
  // { dg-printf "char2_d_945c===-2,3===8,-5===" }
  char2 var1 = (char2) (-2,3);
  char2 var2 = (char2) (8,-5);
  int i = printf("char2_d_945c===%-v2hhd===%-v2hhd===\n",var1,var2);
  return i;
}

int char2_i_1706c() {
  // { dg-printf "char2_i_1706c===+2,-7===-6,+8===" }
  char2 var1 = (char2) (2,-7);
  char2 var2 = (char2) (-6,8);
  int i = printf("char2_i_1706c===%+v2hhi===%+v2hhi===\n",var1,var2);
  return i;
}

int char2_i_186c() {
  // { dg-printf "char2_i_186c===6,6===-5,4===" }
  char2 var1 = (char2) (6,6);
  char2 var2 = (char2) (-5,4);
  int i = printf("char2_i_186c===%v2hhi===%v2hhi===\n",var1,var2);
  return i;
}

int char2_i_2466c() {
  // { dg-printf "char2_i_2466c===8,-6===4,-7===" }
  char2 var1 = (char2) (8,-6);
  char2 var2 = (char2) (4,-7);
  int i = printf("char2_i_2466c===%#v2hhi===%#v2hhi===\n",var1,var2);
  return i;
}

int char2_i_3226c() {
  // { dg-printf "char2_i_3226c===+3,+4===-4,+8===" }
  char2 var1 = (char2) (3,4);
  char2 var2 = (char2) (-4,8);
  int i = printf("char2_i_3226c===%-+v2hhi===%-+v2hhi===\n",var1,var2);
  return i;
}

int char2_i_3986c() {
  // { dg-printf "char2_i_3986c===        -1,        -2===        -7,         3===" }
  char2 var1 = (char2) (-1,-2);
  char2 var2 = (char2) (-7,3);
  int i = printf("char2_i_3986c===% 10v2hhi===% 10v2hhi===\n",var1,var2);
  return i;
}

int char2_i_4746c() {
  // { dg-printf "char2_i_4746c===-000000003,-000000005===0000000000,-000000006===" }
  char2 var1 = (char2) (-3,-5);
  char2 var2 = (char2) (0,-6);
  int i = printf("char2_i_4746c===%010v2hhi===%010v2hhi===\n",var1,var2);
  return i;
}

int char2_i_5506c() {
  // { dg-printf "char2_i_5506c===-3        ,-6        === 1        , 0        ===" }
  char2 var1 = (char2) (-3,-6);
  char2 var2 = (char2) (1,0);
  int i = printf("char2_i_5506c===%- 10v2hhi===%- 10v2hhi===\n",var1,var2);
  return i;
}

int char2_i_6266c() {
  // { dg-printf "char2_i_6266c===        -7,        +4===        +2,        -1===" }
  char2 var1 = (char2) (-7,4);
  char2 var2 = (char2) (2,-1);
  int i = printf("char2_i_6266c===%+ 10v2hhi===%+ 10v2hhi===\n",var1,var2);
  return i;
}

int char2_i_7026c() {
  // { dg-printf "char2_i_7026c===-000000005,+000000005===+000000008,+000000053===" }
  char2 var1 = (char2) (-5,5);
  char2 var2 = (char2) (8,123445);
  int i = printf("char2_i_7026c===%+010v2hhi===%+010v2hhi===\n",var1,var2);
  return i;
}

int char2_i_946c() {
  // { dg-printf "char2_i_946c===-7,-5===4,7===" }
  char2 var1 = (char2) (-7,-5);
  char2 var2 = (char2) (4,7);
  int i = printf("char2_i_946c===%-v2hhi===%-v2hhi===\n",var1,var2);
  return i;
}

int char2_o_1707c() {
  // { dg-printf "char2_o_1707c===377,375===7,7===" }
  char2 var1 = (char2) (-1,-3);
  char2 var2 = (char2) (7,7);
  int i = printf("char2_o_1707c===%+v2hho===%+v2hho===\n",var1,var2);
  return i;
}

int char2_o_187c() {
  // { dg-printf "char2_o_187c===10,371===65,1===" }
  char2 var1 = (char2) (8,-7);
  char2 var2 = (char2) (123445,1);
  int i = printf("char2_o_187c===%v2hho===%v2hho===\n",var1,var2);
  return i;
}

int char2_o_2467c() {
  // { dg-printf "char2_o_2467c===0374,03===06,06===" }
  char2 var1 = (char2) (-4,3);
  char2 var2 = (char2) (6,6);
  int i = printf("char2_o_2467c===%#v2hho===%#v2hho===\n",var1,var2);
  return i;
}

int char2_o_3227c() {
  // { dg-printf "char2_o_3227c===373,375===1,376===" }
  char2 var1 = (char2) (-5,-3);
  char2 var2 = (char2) (1,-2);
  int i = printf("char2_o_3227c===%-+v2hho===%-+v2hho===\n",var1,var2);
  return i;
}

int char2_o_3987c() {
  // { dg-printf "char2_o_3987c===       374,         4===         0,       372===" }
  char2 var1 = (char2) (-4,4);
  char2 var2 = (char2) (0,-6);
  int i = printf("char2_o_3987c===% 10v2hho===% 10v2hho===\n",var1,var2);
  return i;
}

int char2_o_4747c() {
  // { dg-printf "char2_o_4747c===0000000000,0000000005===0000000003,0000000372===" }
  char2 var1 = (char2) (0,5);
  char2 var2 = (char2) (3,-6);
  int i = printf("char2_o_4747c===%010v2hho===%010v2hho===\n",var1,var2);
  return i;
}

int char2_o_5507c() {
  // { dg-printf "char2_o_5507c===4         ,375       ===377       ,373       ===" }
  char2 var1 = (char2) (4,-3);
  char2 var2 = (char2) (-1,-5);
  int i = printf("char2_o_5507c===%- 10v2hho===%- 10v2hho===\n",var1,var2);
  return i;
}

int char2_o_6267c() {
  // { dg-printf "char2_o_6267c===         0,         4===         2,        10===" }
  char2 var1 = (char2) (0,4);
  char2 var2 = (char2) (2,8);
  int i = printf("char2_o_6267c===%+ 10v2hho===%+ 10v2hho===\n",var1,var2);
  return i;
}

int char2_o_7027c() {
  // { dg-printf "char2_o_7027c===0000000377,0000000000===0000000301,0000000006===" }
  char2 var1 = (char2) (-1,0);
  char2 var2 = (char2) (-123455,6);
  int i = printf("char2_o_7027c===%+010v2hho===%+010v2hho===\n",var1,var2);
  return i;
}

int char2_o_947c() {
  // { dg-printf "char2_o_947c===370,371===3,375===" }
  char2 var1 = (char2) (-8,-7);
  char2 var2 = (char2) (3,-3);
  int i = printf("char2_o_947c===%-v2hho===%-v2hho===\n",var1,var2);
  return i;
}

int char2_u_1708c() {
  // { dg-printf "char2_u_1708c===252,53===251,253===" }
  char2 var1 = (char2) (-4,123445);
  char2 var2 = (char2) (-5,-3);
  int i = printf("char2_u_1708c===%+v2hhu===%+v2hhu===\n",var1,var2);
  return i;
}

int char2_u_188c() {
  // { dg-printf "char2_u_188c===4,53===250,3===" }
  char2 var1 = (char2) (4,123445);
  char2 var2 = (char2) (-6,3);
  int i = printf("char2_u_188c===%v2hhu===%v2hhu===\n",var1,var2);
  return i;
}

int char2_u_2468c() {
  // { dg-printf "char2_u_2468c===193,249===251,2===" }
  char2 var1 = (char2) (-123455,-7);
  char2 var2 = (char2) (-5,2);
  int i = printf("char2_u_2468c===%#v2hhu===%#v2hhu===\n",var1,var2);
  return i;
}

int char2_u_3228c() {
  // { dg-printf "char2_u_3228c===253,255===5,0===" }
  char2 var1 = (char2) (-3,-1);
  char2 var2 = (char2) (5,0);
  int i = printf("char2_u_3228c===%-+v2hhu===%-+v2hhu===\n",var1,var2);
  return i;
}

int char2_u_3988c() {
  // { dg-printf "char2_u_3988c===         2,       253===         3,       249===" }
  char2 var1 = (char2) (2,-3);
  char2 var2 = (char2) (3,-7);
  int i = printf("char2_u_3988c===% 10v2hhu===% 10v2hhu===\n",var1,var2);
  return i;
}

int char2_u_4748c() {
  // { dg-printf "char2_u_4748c===0000000251,0000000002===0000000002,0000000053===" }
  char2 var1 = (char2) (-5,2);
  char2 var2 = (char2) (2,123445);
  int i = printf("char2_u_4748c===%010v2hhu===%010v2hhu===\n",var1,var2);
  return i;
}

int char2_u_5508c() {
  // { dg-printf "char2_u_5508c===6         ,7         ===193       ,2         ===" }
  char2 var1 = (char2) (6,7);
  char2 var2 = (char2) (-123455,2);
  int i = printf("char2_u_5508c===%- 10v2hhu===%- 10v2hhu===\n",var1,var2);
  return i;
}

int char2_u_6268c() {
  // { dg-printf "char2_u_6268c===         5,         6===        53,         7===" }
  char2 var1 = (char2) (5,6);
  char2 var2 = (char2) (123445,7);
  int i = printf("char2_u_6268c===%+ 10v2hhu===%+ 10v2hhu===\n",var1,var2);
  return i;
}

int char2_u_7028c() {
  // { dg-printf "char2_u_7028c===0000000251,0000000252===0000000001,0000000053===" }
  char2 var1 = (char2) (-5,-4);
  char2 var2 = (char2) (1,123445);
  int i = printf("char2_u_7028c===%+010v2hhu===%+010v2hhu===\n",var1,var2);
  return i;
}

int char2_u_948c() {
  // { dg-printf "char2_u_948c===250,251===193,5===" }
  char2 var1 = (char2) (-6,-5);
  char2 var2 = (char2) (-123455,5);
  int i = printf("char2_u_948c===%-v2hhu===%-v2hhu===\n",var1,var2);
  return i;
}

int char2_x_1709c() {
  // { dg-printf "char2_x_1709c===f9,f9===35,fe===" }
  char2 var1 = (char2) (-7,-7);
  char2 var2 = (char2) (123445,-2);
  int i = printf("char2_x_1709c===%+v2hhx===%+v2hhx===\n",var1,var2);
  return i;
}

int char2_x_1710c() {
  // { dg-printf "char2_x_1710c===FB,FD===0,1===" }
  char2 var1 = (char2) (-5,-3);
  char2 var2 = (char2) (0,1);
  int i = printf("char2_x_1710c===%+v2hhX===%+v2hhX===\n",var1,var2);
  return i;
}

int char2_x_189c() {
  // { dg-printf "char2_x_189c===fe,fe===f9,5===" }
  char2 var1 = (char2) (-2,-2);
  char2 var2 = (char2) (-7,5);
  int i = printf("char2_x_189c===%v2hhx===%v2hhx===\n",var1,var2);
  return i;
}

int char2_x_190c() {
  // { dg-printf "char2_x_190c===F9,35===0,7===" }
  char2 var1 = (char2) (-7,123445);
  char2 var2 = (char2) (0,7);
  int i = printf("char2_x_190c===%v2hhX===%v2hhX===\n",var1,var2);
  return i;
}

int char2_x_2469c() {
  // { dg-printf "char2_x_2469c===0xfb,0xfc===0xc1,0xfc===" }
  char2 var1 = (char2) (-5,-4);
  char2 var2 = (char2) (-123455,-4);
  int i = printf("char2_x_2469c===%#v2hhx===%#v2hhx===\n",var1,var2);
  return i;
}

int char2_x_2470c() {
  // { dg-printf "char2_x_2470c===0X7,0XFB===0XFB,0X2===" }
  char2 var1 = (char2) (7,-5);
  char2 var2 = (char2) (-5,2);
  int i = printf("char2_x_2470c===%#v2hhX===%#v2hhX===\n",var1,var2);
  return i;
}

int char2_x_3229c() {
  // { dg-printf "char2_x_3229c===fb,2===fb,ff===" }
  char2 var1 = (char2) (-5,2);
  char2 var2 = (char2) (-5,-1);
  int i = printf("char2_x_3229c===%-+v2hhx===%-+v2hhx===\n",var1,var2);
  return i;
}

int char2_x_3230c() {
  // { dg-printf "char2_x_3230c===F8,FB===FC,F9===" }
  char2 var1 = (char2) (-8,-5);
  char2 var2 = (char2) (-4,-7);
  int i = printf("char2_x_3230c===%-+v2hhX===%-+v2hhX===\n",var1,var2);
  return i;
}

int char2_x_3989c() {
  // { dg-printf "char2_x_3989c===        fe,        ff===         8,         2===" }
  char2 var1 = (char2) (-2,-1);
  char2 var2 = (char2) (8,2);
  int i = printf("char2_x_3989c===% 10v2hhx===% 10v2hhx===\n",var1,var2);
  return i;
}

int char2_x_3990c() {
  // { dg-printf "char2_x_3990c===         6,        FE===         0,         3===" }
  char2 var1 = (char2) (6,-2);
  char2 var2 = (char2) (0,3);
  int i = printf("char2_x_3990c===% 10v2hhX===% 10v2hhX===\n",var1,var2);
  return i;
}

int char2_x_4749c() {
  // { dg-printf "char2_x_4749c===0000000002,00000000fa===0000000002,00000000fb===" }
  char2 var1 = (char2) (2,-6);
  char2 var2 = (char2) (2,-5);
  int i = printf("char2_x_4749c===%010v2hhx===%010v2hhx===\n",var1,var2);
  return i;
}

int char2_x_4750c() {
  // { dg-printf "char2_x_4750c===0000000035,0000000007===0000000005,00000000F9===" }
  char2 var1 = (char2) (123445,7);
  char2 var2 = (char2) (5,-7);
  int i = printf("char2_x_4750c===%010v2hhX===%010v2hhX===\n",var1,var2);
  return i;
}

int char2_x_5509c() {
  // { dg-printf "char2_x_5509c===5         ,3         ===f8        ,c1        ===" }
  char2 var1 = (char2) (5,3);
  char2 var2 = (char2) (-8,-123455);
  int i = printf("char2_x_5509c===%- 10v2hhx===%- 10v2hhx===\n",var1,var2);
  return i;
}

int char2_x_5510c() {
  // { dg-printf "char2_x_5510c===F9        ,FE        ===1         ,FE        ===" }
  char2 var1 = (char2) (-7,-2);
  char2 var2 = (char2) (1,-2);
  int i = printf("char2_x_5510c===%- 10v2hhX===%- 10v2hhX===\n",var1,var2);
  return i;
}

int char2_x_6269c() {
  // { dg-printf "char2_x_6269c===        fe,        fa===         1,        35===" }
  char2 var1 = (char2) (-2,-6);
  char2 var2 = (char2) (1,123445);
  int i = printf("char2_x_6269c===%+ 10v2hhx===%+ 10v2hhx===\n",var1,var2);
  return i;
}

int char2_x_6270c() {
  // { dg-printf "char2_x_6270c===        FD,         7===        FF,         7===" }
  char2 var1 = (char2) (-3,7);
  char2 var2 = (char2) (-1,7);
  int i = printf("char2_x_6270c===%+ 10v2hhX===%+ 10v2hhX===\n",var1,var2);
  return i;
}

int char2_x_7029c() {
  // { dg-printf "char2_x_7029c===00000000fe,00000000fb===0000000008,0000000005===" }
  char2 var1 = (char2) (-2,-5);
  char2 var2 = (char2) (8,5);
  int i = printf("char2_x_7029c===%+010v2hhx===%+010v2hhx===\n",var1,var2);
  return i;
}

int char2_x_7030c() {
  // { dg-printf "char2_x_7030c===0000000006,00000000FE===0000000002,00000000F9===" }
  char2 var1 = (char2) (6,-2);
  char2 var2 = (char2) (2,-7);
  int i = printf("char2_x_7030c===%+010v2hhX===%+010v2hhX===\n",var1,var2);
  return i;
}

int char2_x_949c() {
  // { dg-printf "char2_x_949c===7,fc===6,f9===" }
  char2 var1 = (char2) (7,-4);
  char2 var2 = (char2) (6,-7);
  int i = printf("char2_x_949c===%-v2hhx===%-v2hhx===\n",var1,var2);
  return i;
}

int char2_x_950c() {
  // { dg-printf "char2_x_950c===FC,FB===FE,FA===" }
  char2 var1 = (char2) (-4,-5);
  char2 var2 = (char2) (-2,-6);
  int i = printf("char2_x_950c===%-v2hhX===%-v2hhX===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = char2_d_1705c();
i = char2_d_185c();
i = char2_d_2465c();
i = char2_d_3225c();
i = char2_d_3985c();
i = char2_d_4745c();
i = char2_d_5505c();
i = char2_d_6265c();
i = char2_d_7025c();
i = char2_d_945c();
i = char2_i_1706c();
i = char2_i_186c();
i = char2_i_2466c();
i = char2_i_3226c();
i = char2_i_3986c();
i = char2_i_4746c();
i = char2_i_5506c();
i = char2_i_6266c();
i = char2_i_7026c();
i = char2_i_946c();
i = char2_o_1707c();
i = char2_o_187c();
i = char2_o_2467c();
i = char2_o_3227c();
i = char2_o_3987c();
i = char2_o_4747c();
i = char2_o_5507c();
i = char2_o_6267c();
i = char2_o_7027c();
i = char2_o_947c();
i = char2_u_1708c();
i = char2_u_188c();
i = char2_u_2468c();
i = char2_u_3228c();
i = char2_u_3988c();
i = char2_u_4748c();
i = char2_u_5508c();
i = char2_u_6268c();
i = char2_u_7028c();
i = char2_u_948c();
i = char2_x_1709c();
i = char2_x_1710c();
i = char2_x_189c();
i = char2_x_190c();
i = char2_x_2469c();
i = char2_x_2470c();
i = char2_x_3229c();
i = char2_x_3230c();
i = char2_x_3989c();
i = char2_x_3990c();
i = char2_x_4749c();
i = char2_x_4750c();
i = char2_x_5509c();
i = char2_x_5510c();
i = char2_x_6269c();
i = char2_x_6270c();
i = char2_x_7029c();
i = char2_x_7030c();
i = char2_x_949c();
i = char2_x_950c();
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
