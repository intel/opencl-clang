/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/short2.c'  */

int short2_d_1711c() {
  // { dg-printf "short2_d_1711c===-2,+1===+3,+7617===" }
  short2 var1 = (short2) (-2,1);
  short2 var2 = (short2) (3,-123455);
  int i = printf("short2_d_1711c===%+v2hd===%+v2hd===\n",var1,var2);
  return i;
}

int short2_d_191c() {
  // { dg-printf "short2_d_191c===7617,8===6,-6===" }
  short2 var1 = (short2) (-123455,8);
  short2 var2 = (short2) (6,-6);
  int i = printf("short2_d_191c===%v2hd===%v2hd===\n",var1,var2);
  return i;
}

int short2_d_2471c() {
  // { dg-printf "short2_d_2471c===-2,0===-5,-8===" }
  short2 var1 = (short2) (-2,0);
  short2 var2 = (short2) (-5,-8);
  int i = printf("short2_d_2471c===%#v2hd===%#v2hd===\n",var1,var2);
  return i;
}

int short2_d_3231c() {
  // { dg-printf "short2_d_3231c===-7,-3===+8,-8===" }
  short2 var1 = (short2) (-7,-3);
  short2 var2 = (short2) (8,-8);
  int i = printf("short2_d_3231c===%-+v2hd===%-+v2hd===\n",var1,var2);
  return i;
}

int short2_d_3991c() {
  // { dg-printf "short2_d_3991c===         2,         0===        -4,      7617===" }
  short2 var1 = (short2) (2,0);
  short2 var2 = (short2) (-4,-123455);
  int i = printf("short2_d_3991c===% 10v2hd===% 10v2hd===\n",var1,var2);
  return i;
}

int short2_d_4751c() {
  // { dg-printf "short2_d_4751c===-000007627,-000007627===0000000005,0000000002===" }
  short2 var1 = (short2) (123445,123445);
  short2 var2 = (short2) (5,2);
  int i = printf("short2_d_4751c===%010v2hd===%010v2hd===\n",var1,var2);
  return i;
}

int short2_d_5511c() {
  // { dg-printf "short2_d_5511c=== 5        , 3        === 3        ,-4        ===" }
  short2 var1 = (short2) (5,3);
  short2 var2 = (short2) (3,-4);
  int i = printf("short2_d_5511c===%- 10v2hd===%- 10v2hd===\n",var1,var2);
  return i;
}

int short2_d_6271c() {
  // { dg-printf "short2_d_6271c===        -2,        +2===        -5,        -6===" }
  short2 var1 = (short2) (-2,2);
  short2 var2 = (short2) (-5,-6);
  int i = printf("short2_d_6271c===%+ 10v2hd===%+ 10v2hd===\n",var1,var2);
  return i;
}

int short2_d_7031c() {
  // { dg-printf "short2_d_7031c===-000000006,-000000002===-000000007,+000007617===" }
  short2 var1 = (short2) (-6,-2);
  short2 var2 = (short2) (-7,-123455);
  int i = printf("short2_d_7031c===%+010v2hd===%+010v2hd===\n",var1,var2);
  return i;
}

int short2_d_951c() {
  // { dg-printf "short2_d_951c===5,5===4,0===" }
  short2 var1 = (short2) (5,5);
  short2 var2 = (short2) (4,0);
  int i = printf("short2_d_951c===%-v2hd===%-v2hd===\n",var1,var2);
  return i;
}

int short2_i_1712c() {
  // { dg-printf "short2_i_1712c===-2,-5===+3,-1===" }
  short2 var1 = (short2) (-2,-5);
  short2 var2 = (short2) (3,-1);
  int i = printf("short2_i_1712c===%+v2hi===%+v2hi===\n",var1,var2);
  return i;
}

int short2_i_192c() {
  // { dg-printf "short2_i_192c===8,8===7,-7627===" }
  short2 var1 = (short2) (8,8);
  short2 var2 = (short2) (7,123445);
  int i = printf("short2_i_192c===%v2hi===%v2hi===\n",var1,var2);
  return i;
}

int short2_i_2472c() {
  // { dg-printf "short2_i_2472c===6,2===7,2===" }
  short2 var1 = (short2) (6,2);
  short2 var2 = (short2) (7,2);
  int i = printf("short2_i_2472c===%#v2hi===%#v2hi===\n",var1,var2);
  return i;
}

int short2_i_3232c() {
  // { dg-printf "short2_i_3232c===-7,-2===+6,-6===" }
  short2 var1 = (short2) (-7,-2);
  short2 var2 = (short2) (6,-6);
  int i = printf("short2_i_3232c===%-+v2hi===%-+v2hi===\n",var1,var2);
  return i;
}

int short2_i_3992c() {
  // { dg-printf "short2_i_3992c===         4,        -7===        -2,         6===" }
  short2 var1 = (short2) (4,-7);
  short2 var2 = (short2) (-2,6);
  int i = printf("short2_i_3992c===% 10v2hi===% 10v2hi===\n",var1,var2);
  return i;
}

int short2_i_4752c() {
  // { dg-printf "short2_i_4752c===0000000002,-000000001===0000000000,-000000006===" }
  short2 var1 = (short2) (2,-1);
  short2 var2 = (short2) (0,-6);
  int i = printf("short2_i_4752c===%010v2hi===%010v2hi===\n",var1,var2);
  return i;
}

int short2_i_5512c() {
  // { dg-printf "short2_i_5512c=== 4        , 7617     ===-4        , 7617     ===" }
  short2 var1 = (short2) (4,-123455);
  short2 var2 = (short2) (-4,-123455);
  int i = printf("short2_i_5512c===%- 10v2hi===%- 10v2hi===\n",var1,var2);
  return i;
}

int short2_i_6272c() {
  // { dg-printf "short2_i_6272c===        +3,        -7===        +6,        +7===" }
  short2 var1 = (short2) (3,-7);
  short2 var2 = (short2) (6,7);
  int i = printf("short2_i_6272c===%+ 10v2hi===%+ 10v2hi===\n",var1,var2);
  return i;
}

int short2_i_7032c() {
  // { dg-printf "short2_i_7032c===-000000008,+000000001===+000000005,+000000006===" }
  short2 var1 = (short2) (-8,1);
  short2 var2 = (short2) (5,6);
  int i = printf("short2_i_7032c===%+010v2hi===%+010v2hi===\n",var1,var2);
  return i;
}

int short2_i_952c() {
  // { dg-printf "short2_i_952c===-2,-2===-4,5===" }
  short2 var1 = (short2) (-2,-2);
  short2 var2 = (short2) (-4,5);
  int i = printf("short2_i_952c===%-v2hi===%-v2hi===\n",var1,var2);
  return i;
}

int short2_o_1713c() {
  // { dg-printf "short2_o_1713c===177773,0===7,177777===" }
  short2 var1 = (short2) (-5,0);
  short2 var2 = (short2) (7,-1);
  int i = printf("short2_o_1713c===%+v2ho===%+v2ho===\n",var1,var2);
  return i;
}

int short2_o_193c() {
  // { dg-printf "short2_o_193c===10,2===177770,7===" }
  short2 var1 = (short2) (8,2);
  short2 var2 = (short2) (-8,7);
  int i = printf("short2_o_193c===%v2ho===%v2ho===\n",var1,var2);
  return i;
}

int short2_o_2473c() {
  // { dg-printf "short2_o_2473c===0177771,0177772===0177773,0177777===" }
  short2 var1 = (short2) (-7,-6);
  short2 var2 = (short2) (-5,-1);
  int i = printf("short2_o_2473c===%#v2ho===%#v2ho===\n",var1,var2);
  return i;
}

int short2_o_3233c() {
  // { dg-printf "short2_o_3233c===177773,177772===177773,161065===" }
  short2 var1 = (short2) (-5,-6);
  short2 var2 = (short2) (-5,123445);
  int i = printf("short2_o_3233c===%-+v2ho===%-+v2ho===\n",var1,var2);
  return i;
}

int short2_o_3993c() {
  // { dg-printf "short2_o_3993c===    177770,         1===        10,    177777===" }
  short2 var1 = (short2) (-8,1);
  short2 var2 = (short2) (8,-1);
  int i = printf("short2_o_3993c===% 10v2ho===% 10v2ho===\n",var1,var2);
  return i;
}

int short2_o_4753c() {
  // { dg-printf "short2_o_4753c===0000177773,0000177770===0000177775,0000177772===" }
  short2 var1 = (short2) (-5,-8);
  short2 var2 = (short2) (-3,-6);
  int i = printf("short2_o_4753c===%010v2ho===%010v2ho===\n",var1,var2);
  return i;
}

int short2_o_5513c() {
  // { dg-printf "short2_o_5513c===177770    ,177774    ===7         ,177772    ===" }
  short2 var1 = (short2) (-8,-4);
  short2 var2 = (short2) (7,-6);
  int i = printf("short2_o_5513c===%- 10v2ho===%- 10v2ho===\n",var1,var2);
  return i;
}

int short2_o_6273c() {
  // { dg-printf "short2_o_6273c===    177776,         7===    177775,         4===" }
  short2 var1 = (short2) (-2,7);
  short2 var2 = (short2) (-3,4);
  int i = printf("short2_o_6273c===%+ 10v2ho===%+ 10v2ho===\n",var1,var2);
  return i;
}

int short2_o_7033c() {
  // { dg-printf "short2_o_7033c===0000000005,0000161065===0000177775,0000177771===" }
  short2 var1 = (short2) (5,123445);
  short2 var2 = (short2) (-3,-7);
  int i = printf("short2_o_7033c===%+010v2ho===%+010v2ho===\n",var1,var2);
  return i;
}

int short2_o_953c() {
  // { dg-printf "short2_o_953c===177773,161065===177774,177772===" }
  short2 var1 = (short2) (-5,123445);
  short2 var2 = (short2) (-4,-6);
  int i = printf("short2_o_953c===%-v2ho===%-v2ho===\n",var1,var2);
  return i;
}

int short2_u_1714c() {
  // { dg-printf "short2_u_1714c===4,3===0,65531===" }
  short2 var1 = (short2) (4,3);
  short2 var2 = (short2) (0,-5);
  int i = printf("short2_u_1714c===%+v2hu===%+v2hu===\n",var1,var2);
  return i;
}

int short2_u_194c() {
  // { dg-printf "short2_u_194c===4,57909===65534,65531===" }
  short2 var1 = (short2) (4,123445);
  short2 var2 = (short2) (-2,-5);
  int i = printf("short2_u_194c===%v2hu===%v2hu===\n",var1,var2);
  return i;
}

int short2_u_2474c() {
  // { dg-printf "short2_u_2474c===5,6===65530,7===" }
  short2 var1 = (short2) (5,6);
  short2 var2 = (short2) (-6,7);
  int i = printf("short2_u_2474c===%#v2hu===%#v2hu===\n",var1,var2);
  return i;
}

int short2_u_3234c() {
  // { dg-printf "short2_u_3234c===65533,7===7617,6===" }
  short2 var1 = (short2) (-3,7);
  short2 var2 = (short2) (-123455,6);
  int i = printf("short2_u_3234c===%-+v2hu===%-+v2hu===\n",var1,var2);
  return i;
}

int short2_u_3994c() {
  // { dg-printf "short2_u_3994c===         2,         7===     65535,     65529===" }
  short2 var1 = (short2) (2,7);
  short2 var2 = (short2) (-1,-7);
  int i = printf("short2_u_3994c===% 10v2hu===% 10v2hu===\n",var1,var2);
  return i;
}

int short2_u_4754c() {
  // { dg-printf "short2_u_4754c===0000000005,0000000007===0000065533,0000065528===" }
  short2 var1 = (short2) (5,7);
  short2 var2 = (short2) (-3,-8);
  int i = printf("short2_u_4754c===%010v2hu===%010v2hu===\n",var1,var2);
  return i;
}

int short2_u_5514c() {
  // { dg-printf "short2_u_5514c===65533     ,7617      ===7617      ,4         ===" }
  short2 var1 = (short2) (-3,-123455);
  short2 var2 = (short2) (-123455,4);
  int i = printf("short2_u_5514c===%- 10v2hu===%- 10v2hu===\n",var1,var2);
  return i;
}

int short2_u_6274c() {
  // { dg-printf "short2_u_6274c===         4,         5===         3,         6===" }
  short2 var1 = (short2) (4,5);
  short2 var2 = (short2) (3,6);
  int i = printf("short2_u_6274c===%+ 10v2hu===%+ 10v2hu===\n",var1,var2);
  return i;
}

int short2_u_7034c() {
  // { dg-printf "short2_u_7034c===0000000006,0000000003===0000065533,0000000000===" }
  short2 var1 = (short2) (6,3);
  short2 var2 = (short2) (-3,0);
  int i = printf("short2_u_7034c===%+010v2hu===%+010v2hu===\n",var1,var2);
  return i;
}

int short2_u_954c() {
  // { dg-printf "short2_u_954c===65534,65534===8,5===" }
  short2 var1 = (short2) (-2,-2);
  short2 var2 = (short2) (8,5);
  int i = printf("short2_u_954c===%-v2hu===%-v2hu===\n",var1,var2);
  return i;
}

int short2_x_1715c() {
  // { dg-printf "short2_x_1715c===fffb,fffa===fffa,fffa===" }
  short2 var1 = (short2) (-5,-6);
  short2 var2 = (short2) (-6,-6);
  int i = printf("short2_x_1715c===%+v2hx===%+v2hx===\n",var1,var2);
  return i;
}

int short2_x_1716c() {
  // { dg-printf "short2_x_1716c===3,FFF8===FFF9,7===" }
  short2 var1 = (short2) (3,-8);
  short2 var2 = (short2) (-7,7);
  int i = printf("short2_x_1716c===%+v2hX===%+v2hX===\n",var1,var2);
  return i;
}

int short2_x_195c() {
  // { dg-printf "short2_x_195c===fffc,fffb===fffd,1===" }
  short2 var1 = (short2) (-4,-5);
  short2 var2 = (short2) (-3,1);
  int i = printf("short2_x_195c===%v2hx===%v2hx===\n",var1,var2);
  return i;
}

int short2_x_196c() {
  // { dg-printf "short2_x_196c===FFF8,7===5,0===" }
  short2 var1 = (short2) (-8,7);
  short2 var2 = (short2) (5,0);
  int i = printf("short2_x_196c===%v2hX===%v2hX===\n",var1,var2);
  return i;
}

int short2_x_2475c() {
  // { dg-printf "short2_x_2475c===0xfff8,0x1===0x4,0===" }
  short2 var1 = (short2) (-8,1);
  short2 var2 = (short2) (4,0);
  int i = printf("short2_x_2475c===%#v2hx===%#v2hx===\n",var1,var2);
  return i;
}

int short2_x_2476c() {
  // { dg-printf "short2_x_2476c===0X7,0XFFFD===0X6,0XFFF8===" }
  short2 var1 = (short2) (7,-3);
  short2 var2 = (short2) (6,-8);
  int i = printf("short2_x_2476c===%#v2hX===%#v2hX===\n",var1,var2);
  return i;
}

int short2_x_3235c() {
  // { dg-printf "short2_x_3235c===5,fffb===1,7===" }
  short2 var1 = (short2) (5,-5);
  short2 var2 = (short2) (1,7);
  int i = printf("short2_x_3235c===%-+v2hx===%-+v2hx===\n",var1,var2);
  return i;
}

int short2_x_3236c() {
  // { dg-printf "short2_x_3236c===5,4===FFFA,6===" }
  short2 var1 = (short2) (5,4);
  short2 var2 = (short2) (-6,6);
  int i = printf("short2_x_3236c===%-+v2hX===%-+v2hX===\n",var1,var2);
  return i;
}

int short2_x_3995c() {
  // { dg-printf "short2_x_3995c===      fffa,      e235===         8,         1===" }
  short2 var1 = (short2) (-6,123445);
  short2 var2 = (short2) (8,1);
  int i = printf("short2_x_3995c===% 10v2hx===% 10v2hx===\n",var1,var2);
  return i;
}

int short2_x_3996c() {
  // { dg-printf "short2_x_3996c===         3,         7===         7,         2===" }
  short2 var1 = (short2) (3,7);
  short2 var2 = (short2) (7,2);
  int i = printf("short2_x_3996c===% 10v2hX===% 10v2hX===\n",var1,var2);
  return i;
}

int short2_x_4755c() {
  // { dg-printf "short2_x_4755c===0000000007,0000000008===0000000008,000000fffa===" }
  short2 var1 = (short2) (7,8);
  short2 var2 = (short2) (8,-6);
  int i = printf("short2_x_4755c===%010v2hx===%010v2hx===\n",var1,var2);
  return i;
}

int short2_x_4756c() {
  // { dg-printf "short2_x_4756c===000000FFFA,000000FFFF===0000000007,0000000007===" }
  short2 var1 = (short2) (-6,-1);
  short2 var2 = (short2) (7,7);
  int i = printf("short2_x_4756c===%010v2hX===%010v2hX===\n",var1,var2);
  return i;
}

int short2_x_5515c() {
  // { dg-printf "short2_x_5515c===6         ,1dc1      ===6         ,6         ===" }
  short2 var1 = (short2) (6,-123455);
  short2 var2 = (short2) (6,6);
  int i = printf("short2_x_5515c===%- 10v2hx===%- 10v2hx===\n",var1,var2);
  return i;
}

int short2_x_5516c() {
  // { dg-printf "short2_x_5516c===1DC1      ,7         ===8         ,2         ===" }
  short2 var1 = (short2) (-123455,7);
  short2 var2 = (short2) (8,2);
  int i = printf("short2_x_5516c===%- 10v2hX===%- 10v2hX===\n",var1,var2);
  return i;
}

int short2_x_6275c() {
  // { dg-printf "short2_x_6275c===      fffd,         7===      fff8,      fff8===" }
  short2 var1 = (short2) (-3,7);
  short2 var2 = (short2) (-8,-8);
  int i = printf("short2_x_6275c===%+ 10v2hx===%+ 10v2hx===\n",var1,var2);
  return i;
}

int short2_x_6276c() {
  // { dg-printf "short2_x_6276c===      FFF8,         1===      FFFF,      FFFC===" }
  short2 var1 = (short2) (-8,1);
  short2 var2 = (short2) (-1,-4);
  int i = printf("short2_x_6276c===%+ 10v2hX===%+ 10v2hX===\n",var1,var2);
  return i;
}

int short2_x_7035c() {
  // { dg-printf "short2_x_7035c===0000000001,0000000000===0000000004,0000000001===" }
  short2 var1 = (short2) (1,0);
  short2 var2 = (short2) (4,1);
  int i = printf("short2_x_7035c===%+010v2hx===%+010v2hx===\n",var1,var2);
  return i;
}

int short2_x_7036c() {
  // { dg-printf "short2_x_7036c===0000000001,0000000004===000000FFFC,000000FFF9===" }
  short2 var1 = (short2) (1,4);
  short2 var2 = (short2) (-4,-7);
  int i = printf("short2_x_7036c===%+010v2hX===%+010v2hX===\n",var1,var2);
  return i;
}

int short2_x_955c() {
  // { dg-printf "short2_x_955c===1,8===fffe,5===" }
  short2 var1 = (short2) (1,8);
  short2 var2 = (short2) (-2,5);
  int i = printf("short2_x_955c===%-v2hx===%-v2hx===\n",var1,var2);
  return i;
}

int short2_x_956c() {
  // { dg-printf "short2_x_956c===FFF9,FFFF===0,8===" }
  short2 var1 = (short2) (-7,-1);
  short2 var2 = (short2) (0,8);
  int i = printf("short2_x_956c===%-v2hX===%-v2hX===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = short2_d_1711c();
i = short2_d_191c();
i = short2_d_2471c();
i = short2_d_3231c();
i = short2_d_3991c();
i = short2_d_4751c();
i = short2_d_5511c();
i = short2_d_6271c();
i = short2_d_7031c();
i = short2_d_951c();
i = short2_i_1712c();
i = short2_i_192c();
i = short2_i_2472c();
i = short2_i_3232c();
i = short2_i_3992c();
i = short2_i_4752c();
i = short2_i_5512c();
i = short2_i_6272c();
i = short2_i_7032c();
i = short2_i_952c();
i = short2_o_1713c();
i = short2_o_193c();
i = short2_o_2473c();
i = short2_o_3233c();
i = short2_o_3993c();
i = short2_o_4753c();
i = short2_o_5513c();
i = short2_o_6273c();
i = short2_o_7033c();
i = short2_o_953c();
i = short2_u_1714c();
i = short2_u_194c();
i = short2_u_2474c();
i = short2_u_3234c();
i = short2_u_3994c();
i = short2_u_4754c();
i = short2_u_5514c();
i = short2_u_6274c();
i = short2_u_7034c();
i = short2_u_954c();
i = short2_x_1715c();
i = short2_x_1716c();
i = short2_x_195c();
i = short2_x_196c();
i = short2_x_2475c();
i = short2_x_2476c();
i = short2_x_3235c();
i = short2_x_3236c();
i = short2_x_3995c();
i = short2_x_3996c();
i = short2_x_4755c();
i = short2_x_4756c();
i = short2_x_5515c();
i = short2_x_5516c();
i = short2_x_6275c();
i = short2_x_6276c();
i = short2_x_7035c();
i = short2_x_7036c();
i = short2_x_955c();
i = short2_x_956c();
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
