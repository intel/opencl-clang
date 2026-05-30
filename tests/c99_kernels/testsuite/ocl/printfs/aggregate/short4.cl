/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/short4.c'  */

int short4_d_1095c() {
  // { dg-printf "short4_d_1095c===4,0,7,0===8,7,-3,-7627===" }
  short4 var1 = (short4) (4,0,7,0);
  short4 var2 = (short4) (8,7,-3,123445);
  int i = printf("short4_d_1095c===%-v4hd===%-v4hd===\n",var1,var2);
  return i;
}

int short4_d_1855c() {
  // { dg-printf "short4_d_1855c===-5,-6,-4,+8===+2,-5,-2,-1===" }
  short4 var1 = (short4) (-5,-6,-4,8);
  short4 var2 = (short4) (2,-5,-2,-1);
  int i = printf("short4_d_1855c===%+v4hd===%+v4hd===\n",var1,var2);
  return i;
}

int short4_d_2615c() {
  // { dg-printf "short4_d_2615c===7617,-2,-2,-1===6,1,3,-2===" }
  short4 var1 = (short4) (-123455,-2,-2,-1);
  short4 var2 = (short4) (6,1,3,-2);
  int i = printf("short4_d_2615c===%#v4hd===%#v4hd===\n",var1,var2);
  return i;
}

int short4_d_335c() {
  // { dg-printf "short4_d_335c===0,-6,5,8===-8,-7627,4,5===" }
  short4 var1 = (short4) (0,-6,5,8);
  short4 var2 = (short4) (-8,123445,4,5);
  int i = printf("short4_d_335c===%v4hd===%v4hd===\n",var1,var2);
  return i;
}

int short4_d_3375c() {
  // { dg-printf "short4_d_3375c===+3,+2,+5,-7===+1,-7627,-7,+1===" }
  short4 var1 = (short4) (3,2,5,-7);
  short4 var2 = (short4) (1,123445,-7,1);
  int i = printf("short4_d_3375c===%-+v4hd===%-+v4hd===\n",var1,var2);
  return i;
}

int short4_d_4135c() {
  // { dg-printf "short4_d_4135c===        -1,        -4,        -2,         5===        -8,        -2,         7,         1===" }
  short4 var1 = (short4) (-1,-4,-2,5);
  short4 var2 = (short4) (-8,-2,7,1);
  int i = printf("short4_d_4135c===% 10v4hd===% 10v4hd===\n",var1,var2);
  return i;
}

int short4_d_4895c() {
  // { dg-printf "short4_d_4895c===0000000001,0000007617,0000000006,-000000006===0000000008,0000000003,-000000002,0000000000===" }
  short4 var1 = (short4) (1,-123455,6,-6);
  short4 var2 = (short4) (8,3,-2,0);
  int i = printf("short4_d_4895c===%010v4hd===%010v4hd===\n",var1,var2);
  return i;
}

int short4_d_5655c() {
  // { dg-printf "short4_d_5655c===-8        ,-3        , 4        ,-6        === 7        ,-7        , 7617     , 1        ===" }
  short4 var1 = (short4) (-8,-3,4,-6);
  short4 var2 = (short4) (7,-7,-123455,1);
  int i = printf("short4_d_5655c===%- 10v4hd===%- 10v4hd===\n",var1,var2);
  return i;
}

int short4_d_6415c() {
  // { dg-printf "short4_d_6415c===     +7617,        +2,        +2,        -3===        +8,        -3,        -4,        +6===" }
  short4 var1 = (short4) (-123455,2,2,-3);
  short4 var2 = (short4) (8,-3,-4,6);
  int i = printf("short4_d_6415c===%+ 10v4hd===%+ 10v4hd===\n",var1,var2);
  return i;
}

int short4_d_7175c() {
  // { dg-printf "short4_d_7175c===+000000006,-000000006,-000007627,+000000007===+000000006,-000000007,+000000007,+000000008===" }
  short4 var1 = (short4) (6,-6,123445,7);
  short4 var2 = (short4) (6,-7,7,8);
  int i = printf("short4_d_7175c===%+010v4hd===%+010v4hd===\n",var1,var2);
  return i;
}

int short4_i_1096c() {
  // { dg-printf "short4_i_1096c===2,-8,-7,-8===-7,3,5,3===" }
  short4 var1 = (short4) (2,-8,-7,-8);
  short4 var2 = (short4) (-7,3,5,3);
  int i = printf("short4_i_1096c===%-v4hi===%-v4hi===\n",var1,var2);
  return i;
}

int short4_i_1856c() {
  // { dg-printf "short4_i_1856c===-6,+5,-1,+5===-8,-8,+7,-7627===" }
  short4 var1 = (short4) (-6,5,-1,5);
  short4 var2 = (short4) (-8,-8,7,123445);
  int i = printf("short4_i_1856c===%+v4hi===%+v4hi===\n",var1,var2);
  return i;
}

int short4_i_2616c() {
  // { dg-printf "short4_i_2616c===-4,3,3,-2===-3,-8,7617,0===" }
  short4 var1 = (short4) (-4,3,3,-2);
  short4 var2 = (short4) (-3,-8,-123455,0);
  int i = printf("short4_i_2616c===%#v4hi===%#v4hi===\n",var1,var2);
  return i;
}

int short4_i_336c() {
  // { dg-printf "short4_i_336c===-6,-6,-8,6===6,5,4,7617===" }
  short4 var1 = (short4) (-6,-6,-8,6);
  short4 var2 = (short4) (6,5,4,-123455);
  int i = printf("short4_i_336c===%v4hi===%v4hi===\n",var1,var2);
  return i;
}

int short4_i_3376c() {
  // { dg-printf "short4_i_3376c===+8,+1,-6,+7617===-4,-5,+2,-1===" }
  short4 var1 = (short4) (8,1,-6,-123455);
  short4 var2 = (short4) (-4,-5,2,-1);
  int i = printf("short4_i_3376c===%-+v4hi===%-+v4hi===\n",var1,var2);
  return i;
}

int short4_i_4136c() {
  // { dg-printf "short4_i_4136c===        -8,         3,         5,         1===        -2,         1,        -1,        -4===" }
  short4 var1 = (short4) (-8,3,5,1);
  short4 var2 = (short4) (-2,1,-1,-4);
  int i = printf("short4_i_4136c===% 10v4hi===% 10v4hi===\n",var1,var2);
  return i;
}

int short4_i_4896c() {
  // { dg-printf "short4_i_4896c===0000000002,0000007617,-000000004,-000000004===0000000008,0000000001,0000000007,0000000000===" }
  short4 var1 = (short4) (2,-123455,-4,-4);
  short4 var2 = (short4) (8,1,7,0);
  int i = printf("short4_i_4896c===%010v4hi===%010v4hi===\n",var1,var2);
  return i;
}

int short4_i_5656c() {
  // { dg-printf "short4_i_5656c===-2        , 5        , 3        , 7        === 8        ,-1        , 4        , 1        ===" }
  short4 var1 = (short4) (-2,5,3,7);
  short4 var2 = (short4) (8,-1,4,1);
  int i = printf("short4_i_5656c===%- 10v4hi===%- 10v4hi===\n",var1,var2);
  return i;
}

int short4_i_6416c() {
  // { dg-printf "short4_i_6416c===        -6,        -5,        -5,        -4===        +6,        -3,        -6,        -1===" }
  short4 var1 = (short4) (-6,-5,-5,-4);
  short4 var2 = (short4) (6,-3,-6,-1);
  int i = printf("short4_i_6416c===%+ 10v4hi===%+ 10v4hi===\n",var1,var2);
  return i;
}

int short4_i_7176c() {
  // { dg-printf "short4_i_7176c===+000000008,-000000005,-000000002,+000000005===-000000004,+000000000,+000000003,-000000005===" }
  short4 var1 = (short4) (8,-5,-2,5);
  short4 var2 = (short4) (-4,0,3,-5);
  int i = printf("short4_i_7176c===%+010v4hi===%+010v4hi===\n",var1,var2);
  return i;
}

int short4_o_1097c() {
  // { dg-printf "short4_o_1097c===6,0,1,0===177773,1,177774,5===" }
  short4 var1 = (short4) (6,0,1,0);
  short4 var2 = (short4) (-5,1,-4,5);
  int i = printf("short4_o_1097c===%-v4ho===%-v4ho===\n",var1,var2);
  return i;
}

int short4_o_1857c() {
  // { dg-printf "short4_o_1857c===161065,4,177774,4===6,16701,0,177773===" }
  short4 var1 = (short4) (123445,4,-4,4);
  short4 var2 = (short4) (6,-123455,0,-5);
  int i = printf("short4_o_1857c===%+v4ho===%+v4ho===\n",var1,var2);
  return i;
}

int short4_o_2617c() {
  // { dg-printf "short4_o_2617c===05,0177774,0177774,0177776===0161065,02,0177772,06===" }
  short4 var1 = (short4) (5,-4,-4,-2);
  short4 var2 = (short4) (123445,2,-6,6);
  int i = printf("short4_o_2617c===%#v4ho===%#v4ho===\n",var1,var2);
  return i;
}

int short4_o_337c() {
  // { dg-printf "short4_o_337c===177774,2,16701,177771===5,177774,0,177772===" }
  short4 var1 = (short4) (-4,2,-123455,-7);
  short4 var2 = (short4) (5,-4,0,-6);
  int i = printf("short4_o_337c===%v4ho===%v4ho===\n",var1,var2);
  return i;
}

int short4_o_3377c() {
  // { dg-printf "short4_o_3377c===10,161065,177775,177777===177772,1,10,4===" }
  short4 var1 = (short4) (8,123445,-3,-1);
  short4 var2 = (short4) (-6,1,8,4);
  int i = printf("short4_o_3377c===%-+v4ho===%-+v4ho===\n",var1,var2);
  return i;
}

int short4_o_4137c() {
  // { dg-printf "short4_o_4137c===         0,         1,    177777,         1===     16701,         3,    177774,         0===" }
  short4 var1 = (short4) (0,1,-1,1);
  short4 var2 = (short4) (-123455,3,-4,0);
  int i = printf("short4_o_4137c===% 10v4ho===% 10v4ho===\n",var1,var2);
  return i;
}

int short4_o_4897c() {
  // { dg-printf "short4_o_4897c===0000000002,0000000000,0000177773,0000000005===0000177774,0000000001,0000000010,0000177770===" }
  short4 var1 = (short4) (2,0,-5,5);
  short4 var2 = (short4) (-4,1,8,-8);
  int i = printf("short4_o_4897c===%010v4ho===%010v4ho===\n",var1,var2);
  return i;
}

int short4_o_5657c() {
  // { dg-printf "short4_o_5657c===161065    ,177776    ,4         ,1         ===177771    ,177773    ,6         ,16701     ===" }
  short4 var1 = (short4) (123445,-2,4,1);
  short4 var2 = (short4) (-7,-5,6,-123455);
  int i = printf("short4_o_5657c===%- 10v4ho===%- 10v4ho===\n",var1,var2);
  return i;
}

int short4_o_6417c() {
  // { dg-printf "short4_o_6417c===    177770,         5,    161065,    177777===         7,    177773,         7,         3===" }
  short4 var1 = (short4) (-8,5,123445,-1);
  short4 var2 = (short4) (7,-5,7,3);
  int i = printf("short4_o_6417c===%+ 10v4ho===%+ 10v4ho===\n",var1,var2);
  return i;
}

int short4_o_7177c() {
  // { dg-printf "short4_o_7177c===0000016701,0000000004,0000177776,0000161065===0000177774,0000000004,0000000003,0000177770===" }
  short4 var1 = (short4) (-123455,4,-2,123445);
  short4 var2 = (short4) (-4,4,3,-8);
  int i = printf("short4_o_7177c===%+010v4ho===%+010v4ho===\n",var1,var2);
  return i;
}

int short4_u_1098c() {
  // { dg-printf "short4_u_1098c===65531,3,65534,3===65528,6,65531,65535===" }
  short4 var1 = (short4) (-5,3,-2,3);
  short4 var2 = (short4) (-8,6,-5,-1);
  int i = printf("short4_u_1098c===%-v4hu===%-v4hu===\n",var1,var2);
  return i;
}

int short4_u_1858c() {
  // { dg-printf "short4_u_1858c===0,1,0,57909===7,0,65531,1===" }
  short4 var1 = (short4) (0,1,0,123445);
  short4 var2 = (short4) (7,0,-5,1);
  int i = printf("short4_u_1858c===%+v4hu===%+v4hu===\n",var1,var2);
  return i;
}

int short4_u_2618c() {
  // { dg-printf "short4_u_2618c===4,65530,0,3===57909,65533,65531,65533===" }
  short4 var1 = (short4) (4,-6,0,3);
  short4 var2 = (short4) (123445,-3,-5,-3);
  int i = printf("short4_u_2618c===%#v4hu===%#v4hu===\n",var1,var2);
  return i;
}

int short4_u_3378c() {
  // { dg-printf "short4_u_3378c===0,57909,7,6===65532,65533,65529,4===" }
  short4 var1 = (short4) (0,123445,7,6);
  short4 var2 = (short4) (-4,-3,-7,4);
  int i = printf("short4_u_3378c===%-+v4hu===%-+v4hu===\n",var1,var2);
  return i;
}

int short4_u_338c() {
  // { dg-printf "short4_u_338c===7617,65534,65531,65534===1,65535,4,8===" }
  short4 var1 = (short4) (-123455,-2,-5,-2);
  short4 var2 = (short4) (1,-1,4,8);
  int i = printf("short4_u_338c===%v4hu===%v4hu===\n",var1,var2);
  return i;
}

int short4_u_4138c() {
  // { dg-printf "short4_u_4138c===     65535,     57909,         3,     65534===     65534,     65528,     65528,     65531===" }
  short4 var1 = (short4) (-1,123445,3,-2);
  short4 var2 = (short4) (-2,-8,-8,-5);
  int i = printf("short4_u_4138c===% 10v4hu===% 10v4hu===\n",var1,var2);
  return i;
}

int short4_u_4898c() {
  // { dg-printf "short4_u_4898c===0000065530,0000007617,0000065532,0000000003===0000000004,0000065535,0000057909,0000000002===" }
  short4 var1 = (short4) (-6,-123455,-4,3);
  short4 var2 = (short4) (4,-1,123445,2);
  int i = printf("short4_u_4898c===%010v4hu===%010v4hu===\n",var1,var2);
  return i;
}

int short4_u_5658c() {
  // { dg-printf "short4_u_5658c===0         ,65531     ,0         ,65533     ===65529     ,2         ,65534     ,0         ===" }
  short4 var1 = (short4) (0,-5,0,-3);
  short4 var2 = (short4) (-7,2,-2,0);
  int i = printf("short4_u_5658c===%- 10v4hu===%- 10v4hu===\n",var1,var2);
  return i;
}

int short4_u_6418c() {
  // { dg-printf "short4_u_6418c===         3,         5,     65528,     65529===         8,         2,      7617,         8===" }
  short4 var1 = (short4) (3,5,-8,-7);
  short4 var2 = (short4) (8,2,-123455,8);
  int i = printf("short4_u_6418c===%+ 10v4hu===%+ 10v4hu===\n",var1,var2);
  return i;
}

int short4_u_7178c() {
  // { dg-printf "short4_u_7178c===0000000003,0000065533,0000065534,0000007617===0000065529,0000000008,0000065534,0000007617===" }
  short4 var1 = (short4) (3,-3,-2,-123455);
  short4 var2 = (short4) (-7,8,-2,-123455);
  int i = printf("short4_u_7178c===%+010v4hu===%+010v4hu===\n",var1,var2);
  return i;
}

int short4_x_1099c() {
  // { dg-printf "short4_x_1099c===0,e235,e235,fff8===fffd,6,2,7===" }
  short4 var1 = (short4) (0,123445,123445,-8);
  short4 var2 = (short4) (-3,6,2,7);
  int i = printf("short4_x_1099c===%-v4hx===%-v4hx===\n",var1,var2);
  return i;
}

int short4_x_1100c() {
  // { dg-printf "short4_x_1100c===1,FFFE,FFFA,0===8,1DC1,2,3===" }
  short4 var1 = (short4) (1,-2,-6,0);
  short4 var2 = (short4) (8,-123455,2,3);
  int i = printf("short4_x_1100c===%-v4hX===%-v4hX===\n",var1,var2);
  return i;
}

int short4_x_1859c() {
  // { dg-printf "short4_x_1859c===fffa,fffb,2,fffa===fffe,ffff,1dc1,fffa===" }
  short4 var1 = (short4) (-6,-5,2,-6);
  short4 var2 = (short4) (-2,-1,-123455,-6);
  int i = printf("short4_x_1859c===%+v4hx===%+v4hx===\n",var1,var2);
  return i;
}

int short4_x_1860c() {
  // { dg-printf "short4_x_1860c===FFF8,FFFB,FFFB,5===FFF9,E235,3,FFF9===" }
  short4 var1 = (short4) (-8,-5,-5,5);
  short4 var2 = (short4) (-7,123445,3,-7);
  int i = printf("short4_x_1860c===%+v4hX===%+v4hX===\n",var1,var2);
  return i;
}

int short4_x_2619c() {
  // { dg-printf "short4_x_2619c===0xfffc,0x8,0x2,0===0xe235,0x6,0x6,0x1dc1===" }
  short4 var1 = (short4) (-4,8,2,0);
  short4 var2 = (short4) (123445,6,6,-123455);
  int i = printf("short4_x_2619c===%#v4hx===%#v4hx===\n",var1,var2);
  return i;
}

int short4_x_2620c() {
  // { dg-printf "short4_x_2620c===0XFFFB,0XE235,0X6,0X8===0XFFF9,0X1DC1,0X5,0XFFFF===" }
  short4 var1 = (short4) (-5,123445,6,8);
  short4 var2 = (short4) (-7,-123455,5,-1);
  int i = printf("short4_x_2620c===%#v4hX===%#v4hX===\n",var1,var2);
  return i;
}

int short4_x_3379c() {
  // { dg-printf "short4_x_3379c===1dc1,5,fff8,1dc1===fff9,e235,4,0===" }
  short4 var1 = (short4) (-123455,5,-8,-123455);
  short4 var2 = (short4) (-7,123445,4,0);
  int i = printf("short4_x_3379c===%-+v4hx===%-+v4hx===\n",var1,var2);
  return i;
}

int short4_x_3380c() {
  // { dg-printf "short4_x_3380c===7,1DC1,FFFE,FFFC===5,1,7,4===" }
  short4 var1 = (short4) (7,-123455,-2,-4);
  short4 var2 = (short4) (5,1,7,4);
  int i = printf("short4_x_3380c===%-+v4hX===%-+v4hX===\n",var1,var2);
  return i;
}

int short4_x_339c() {
  // { dg-printf "short4_x_339c===5,fffa,1dc1,2===1dc1,ffff,5,fffb===" }
  short4 var1 = (short4) (5,-6,-123455,2);
  short4 var2 = (short4) (-123455,-1,5,-5);
  int i = printf("short4_x_339c===%v4hx===%v4hx===\n",var1,var2);
  return i;
}

int short4_x_340c() {
  // { dg-printf "short4_x_340c===7,E235,FFFC,E235===FFFD,2,3,E235===" }
  short4 var1 = (short4) (7,123445,-4,123445);
  short4 var2 = (short4) (-3,2,3,123445);
  int i = printf("short4_x_340c===%v4hX===%v4hX===\n",var1,var2);
  return i;
}

int short4_x_4139c() {
  // { dg-printf "short4_x_4139c===         3,      1dc1,      e235,      fffe===      fffa,         3,         3,      fff8===" }
  short4 var1 = (short4) (3,-123455,123445,-2);
  short4 var2 = (short4) (-6,3,3,-8);
  int i = printf("short4_x_4139c===% 10v4hx===% 10v4hx===\n",var1,var2);
  return i;
}

int short4_x_4140c() {
  // { dg-printf "short4_x_4140c===      FFF8,      FFF9,         0,         2===         4,         5,      FFFD,      FFFF===" }
  short4 var1 = (short4) (-8,-7,0,2);
  short4 var2 = (short4) (4,5,-3,-1);
  int i = printf("short4_x_4140c===% 10v4hX===% 10v4hX===\n",var1,var2);
  return i;
}

int short4_x_4899c() {
  // { dg-printf "short4_x_4899c===000000e235,000000fff8,000000fff8,0000000007===0000000008,000000fffe,000000fffe,0000000006===" }
  short4 var1 = (short4) (123445,-8,-8,7);
  short4 var2 = (short4) (8,-2,-2,6);
  int i = printf("short4_x_4899c===%010v4hx===%010v4hx===\n",var1,var2);
  return i;
}

int short4_x_4900c() {
  // { dg-printf "short4_x_4900c===0000000005,000000FFFB,0000000007,0000000006===0000000007,0000001DC1,0000000000,0000000001===" }
  short4 var1 = (short4) (5,-5,7,6);
  short4 var2 = (short4) (7,-123455,0,1);
  int i = printf("short4_x_4900c===%010v4hX===%010v4hX===\n",var1,var2);
  return i;
}

int short4_x_5659c() {
  // { dg-printf "short4_x_5659c===fffd      ,8         ,fff9      ,ffff      ===1dc1      ,fffd      ,5         ,5         ===" }
  short4 var1 = (short4) (-3,8,-7,-1);
  short4 var2 = (short4) (-123455,-3,5,5);
  int i = printf("short4_x_5659c===%- 10v4hx===%- 10v4hx===\n",var1,var2);
  return i;
}

int short4_x_5660c() {
  // { dg-printf "short4_x_5660c===FFFE      ,FFFF      ,FFFF      ,FFF8      ===FFFA      ,5         ,FFFC      ,FFFF      ===" }
  short4 var1 = (short4) (-2,-1,-1,-8);
  short4 var2 = (short4) (-6,5,-4,-1);
  int i = printf("short4_x_5660c===%- 10v4hX===%- 10v4hX===\n",var1,var2);
  return i;
}

int short4_x_6419c() {
  // { dg-printf "short4_x_6419c===         5,      fffe,         3,      fff9===      fffc,      fffd,         3,      ffff===" }
  short4 var1 = (short4) (5,-2,3,-7);
  short4 var2 = (short4) (-4,-3,3,-1);
  int i = printf("short4_x_6419c===%+ 10v4hx===%+ 10v4hx===\n",var1,var2);
  return i;
}

int short4_x_6420c() {
  // { dg-printf "short4_x_6420c===      FFF9,         7,      FFFF,         3===         0,         1,         2,         5===" }
  short4 var1 = (short4) (-7,7,-1,3);
  short4 var2 = (short4) (0,1,2,5);
  int i = printf("short4_x_6420c===%+ 10v4hX===%+ 10v4hX===\n",var1,var2);
  return i;
}

int short4_x_7179c() {
  // { dg-printf "short4_x_7179c===000000ffff,0000000008,0000000006,0000000003===000000ffff,0000001dc1,0000000001,0000000002===" }
  short4 var1 = (short4) (-1,8,6,3);
  short4 var2 = (short4) (-1,-123455,1,2);
  int i = printf("short4_x_7179c===%+010v4hx===%+010v4hx===\n",var1,var2);
  return i;
}

int short4_x_7180c() {
  // { dg-printf "short4_x_7180c===0000000006,000000E235,000000FFF8,0000000004===000000FFF8,000000FFFF,0000000001,0000000006===" }
  short4 var1 = (short4) (6,123445,-8,4);
  short4 var2 = (short4) (-8,-1,1,6);
  int i = printf("short4_x_7180c===%+010v4hX===%+010v4hX===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = short4_d_1095c();
i = short4_d_1855c();
i = short4_d_2615c();
i = short4_d_335c();
i = short4_d_3375c();
i = short4_d_4135c();
i = short4_d_4895c();
i = short4_d_5655c();
i = short4_d_6415c();
i = short4_d_7175c();
i = short4_i_1096c();
i = short4_i_1856c();
i = short4_i_2616c();
i = short4_i_336c();
i = short4_i_3376c();
i = short4_i_4136c();
i = short4_i_4896c();
i = short4_i_5656c();
i = short4_i_6416c();
i = short4_i_7176c();
i = short4_o_1097c();
i = short4_o_1857c();
i = short4_o_2617c();
i = short4_o_337c();
i = short4_o_3377c();
i = short4_o_4137c();
i = short4_o_4897c();
i = short4_o_5657c();
i = short4_o_6417c();
i = short4_o_7177c();
i = short4_u_1098c();
i = short4_u_1858c();
i = short4_u_2618c();
i = short4_u_3378c();
i = short4_u_338c();
i = short4_u_4138c();
i = short4_u_4898c();
i = short4_u_5658c();
i = short4_u_6418c();
i = short4_u_7178c();
i = short4_x_1099c();
i = short4_x_1100c();
i = short4_x_1859c();
i = short4_x_1860c();
i = short4_x_2619c();
i = short4_x_2620c();
i = short4_x_3379c();
i = short4_x_3380c();
i = short4_x_339c();
i = short4_x_340c();
i = short4_x_4139c();
i = short4_x_4140c();
i = short4_x_4899c();
i = short4_x_4900c();
i = short4_x_5659c();
i = short4_x_5660c();
i = short4_x_6419c();
i = short4_x_6420c();
i = short4_x_7179c();
i = short4_x_7180c();
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
