/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/short8.c'  */

int short8_d_1239c() {
  // { dg-printf "short8_d_1239c===4,1,1,-8,5,8,7,8===7617,3,7,-3,-6,8,0,-1===" }
  short8 var1 = (short8) (4,1,1,-8,5,8,7,8);
  short8 var2 = (short8) (-123455,3,7,-3,-6,8,0,-1);
  int i = printf("short8_d_1239c===%-v8hd===%-v8hd===\n",var1,var2);
  return i;
}

int short8_d_1999c() {
  // { dg-printf "short8_d_1999c===+7617,-1,+5,-5,+6,+3,+8,+2===-6,+6,+6,-8,-3,-2,-3,+3===" }
  short8 var1 = (short8) (-123455,-1,5,-5,6,3,8,2);
  short8 var2 = (short8) (-6,6,6,-8,-3,-2,-3,3);
  int i = printf("short8_d_1999c===%+v8hd===%+v8hd===\n",var1,var2);
  return i;
}

int short8_d_2759c() {
  // { dg-printf "short8_d_2759c===-4,8,4,8,7617,0,-5,-4===3,-2,7617,-8,7617,1,-6,-6===" }
  short8 var1 = (short8) (-4,8,4,8,-123455,0,-5,-4);
  short8 var2 = (short8) (3,-2,-123455,-8,-123455,1,-6,-6);
  int i = printf("short8_d_2759c===%#v8hd===%#v8hd===\n",var1,var2);
  return i;
}

int short8_d_3519c() {
  // { dg-printf "short8_d_3519c===-4,+7,-3,-2,-3,-6,-7627,+5===-4,+1,-1,+3,+1,+7,+3,+0===" }
  short8 var1 = (short8) (-4,7,-3,-2,-3,-6,123445,5);
  short8 var2 = (short8) (-4,1,-1,3,1,7,3,0);
  int i = printf("short8_d_3519c===%-+v8hd===%-+v8hd===\n",var1,var2);
  return i;
}

int short8_d_4279c() {
  // { dg-printf "short8_d_4279c===         1,     -7627,      7617,        -8,         8,        -1,        -4,         1===        -1,         2,         2,         6,         5,         5,        -1,        -3===" }
  short8 var1 = (short8) (1,123445,-123455,-8,8,-1,-4,1);
  short8 var2 = (short8) (-1,2,2,6,5,5,-1,-3);
  int i = printf("short8_d_4279c===% 10v8hd===% 10v8hd===\n",var1,var2);
  return i;
}

int short8_d_479c() {
  // { dg-printf "short8_d_479c===7617,-7,-7627,1,-5,-3,2,-3===-7,-4,5,7,-6,-8,-8,6===" }
  short8 var1 = (short8) (-123455,-7,123445,1,-5,-3,2,-3);
  short8 var2 = (short8) (-7,-4,5,7,-6,-8,-8,6);
  int i = printf("short8_d_479c===%v8hd===%v8hd===\n",var1,var2);
  return i;
}

int short8_d_5039c() {
  // { dg-printf "short8_d_5039c===-000000003,0000000004,0000000003,0000000007,0000000002,-000000008,-000000001,0000000002===0000000007,-000000007,0000000006,-000007627,0000000004,-000000003,0000000005,-000000004===" }
  short8 var1 = (short8) (-3,4,3,7,2,-8,-1,2);
  short8 var2 = (short8) (7,-7,6,123445,4,-3,5,-4);
  int i = printf("short8_d_5039c===%010v8hd===%010v8hd===\n",var1,var2);
  return i;
}

int short8_d_5799c() {
  // { dg-printf "short8_d_5799c=== 5        , 2        , 1        , 1        ,-3        ,-6        ,-6        , 2        === 6        ,-1        , 8        ,-1        ,-5        ,-3        , 2        , 0        ===" }
  short8 var1 = (short8) (5,2,1,1,-3,-6,-6,2);
  short8 var2 = (short8) (6,-1,8,-1,-5,-3,2,0);
  int i = printf("short8_d_5799c===%- 10v8hd===%- 10v8hd===\n",var1,var2);
  return i;
}

int short8_d_6559c() {
  // { dg-printf "short8_d_6559c===     -7627,        +7,        -8,        +2,        +5,        +6,        -5,        +8===        -6,        -7,        -8,        -7,        +2,        -8,        +1,        -8===" }
  short8 var1 = (short8) (123445,7,-8,2,5,6,-5,8);
  short8 var2 = (short8) (-6,-7,-8,-7,2,-8,1,-8);
  int i = printf("short8_d_6559c===%+ 10v8hd===%+ 10v8hd===\n",var1,var2);
  return i;
}

int short8_d_7319c() {
  // { dg-printf "short8_d_7319c===+000000005,-000000007,-000000004,+000000008,-000007627,-000000004,+000007617,+000000005===+000000001,+000000000,-000000006,+000000002,+000000007,-000000006,+000000000,-000000006===" }
  short8 var1 = (short8) (5,-7,-4,8,123445,-4,-123455,5);
  short8 var2 = (short8) (1,0,-6,2,7,-6,0,-6);
  int i = printf("short8_d_7319c===%+010v8hd===%+010v8hd===\n",var1,var2);
  return i;
}

int short8_i_1240c() {
  // { dg-printf "short8_i_1240c===-8,-4,-7,-2,8,-2,-1,-1===3,2,-2,6,-4,-2,2,-1===" }
  short8 var1 = (short8) (-8,-4,-7,-2,8,-2,-1,-1);
  short8 var2 = (short8) (3,2,-2,6,-4,-2,2,-1);
  int i = printf("short8_i_1240c===%-v8hi===%-v8hi===\n",var1,var2);
  return i;
}

int short8_i_2000c() {
  // { dg-printf "short8_i_2000c===+3,-7627,-7,-1,+3,+8,-6,+4===-5,-6,+1,+7617,-1,-5,+6,-3===" }
  short8 var1 = (short8) (3,123445,-7,-1,3,8,-6,4);
  short8 var2 = (short8) (-5,-6,1,-123455,-1,-5,6,-3);
  int i = printf("short8_i_2000c===%+v8hi===%+v8hi===\n",var1,var2);
  return i;
}

int short8_i_2760c() {
  // { dg-printf "short8_i_2760c===8,0,-4,-5,0,-5,-4,0===7617,-7,-8,8,-1,2,-6,-3===" }
  short8 var1 = (short8) (8,0,-4,-5,0,-5,-4,0);
  short8 var2 = (short8) (-123455,-7,-8,8,-1,2,-6,-3);
  int i = printf("short8_i_2760c===%#v8hi===%#v8hi===\n",var1,var2);
  return i;
}

int short8_i_3520c() {
  // { dg-printf "short8_i_3520c===-3,+2,-8,+5,-8,-7,-2,-3===+4,-6,+8,+5,+8,-8,-7,-7627===" }
  short8 var1 = (short8) (-3,2,-8,5,-8,-7,-2,-3);
  short8 var2 = (short8) (4,-6,8,5,8,-8,-7,123445);
  int i = printf("short8_i_3520c===%-+v8hi===%-+v8hi===\n",var1,var2);
  return i;
}

int short8_i_4280c() {
  // { dg-printf "short8_i_4280c===         3,         2,      7617,         7,        -7,        -4,         0,         4===         2,        -1,        -6,      7617,     -7627,        -1,         3,         0===" }
  short8 var1 = (short8) (3,2,-123455,7,-7,-4,0,4);
  short8 var2 = (short8) (2,-1,-6,-123455,123445,-1,3,0);
  int i = printf("short8_i_4280c===% 10v8hi===% 10v8hi===\n",var1,var2);
  return i;
}

int short8_i_480c() {
  // { dg-printf "short8_i_480c===5,2,8,1,-7,-4,1,4===8,8,-5,-6,-6,7,0,-8===" }
  short8 var1 = (short8) (5,2,8,1,-7,-4,1,4);
  short8 var2 = (short8) (8,8,-5,-6,-6,7,0,-8);
  int i = printf("short8_i_480c===%v8hi===%v8hi===\n",var1,var2);
  return i;
}

int short8_i_5040c() {
  // { dg-printf "short8_i_5040c===-000000008,0000007617,0000000008,-000000007,-000000001,-000000006,0000000007,-000000001===0000000000,-000000005,0000000005,0000000004,-000007627,0000000005,-000000007,0000000005===" }
  short8 var1 = (short8) (-8,-123455,8,-7,-1,-6,7,-1);
  short8 var2 = (short8) (0,-5,5,4,123445,5,-7,5);
  int i = printf("short8_i_5040c===%010v8hi===%010v8hi===\n",var1,var2);
  return i;
}

int short8_i_5800c() {
  // { dg-printf "short8_i_5800c===-1        ,-8        , 1        , 1        , 8        , 2        , 3        ,-8        ===-3        , 0        ,-4        ,-4        ,-8        , 7        ,-4        ,-1        ===" }
  short8 var1 = (short8) (-1,-8,1,1,8,2,3,-8);
  short8 var2 = (short8) (-3,0,-4,-4,-8,7,-4,-1);
  int i = printf("short8_i_5800c===%- 10v8hi===%- 10v8hi===\n",var1,var2);
  return i;
}

int short8_i_6560c() {
  // { dg-printf "short8_i_6560c===        +7,        +3,        -2,        +5,        -3,        +7,     -7627,        +6===     -7627,     -7627,        +4,        -8,        +2,        -1,        +6,        -6===" }
  short8 var1 = (short8) (7,3,-2,5,-3,7,123445,6);
  short8 var2 = (short8) (123445,123445,4,-8,2,-1,6,-6);
  int i = printf("short8_i_6560c===%+ 10v8hi===%+ 10v8hi===\n",var1,var2);
  return i;
}

int short8_i_7320c() {
  // { dg-printf "short8_i_7320c===+000000004,+000000005,-000000008,+000000001,+000000002,+000000008,+000000006,-000000001===-000000002,+000000006,-000000004,+000000004,-000000007,+000000001,-000000006,+000000004===" }
  short8 var1 = (short8) (4,5,-8,1,2,8,6,-1);
  short8 var2 = (short8) (-2,6,-4,4,-7,1,-6,4);
  int i = printf("short8_i_7320c===%+010v8hi===%+010v8hi===\n",var1,var2);
  return i;
}

int short8_o_1241c() {
  // { dg-printf "short8_o_1241c===16701,2,2,177772,7,10,177774,6===6,177774,177771,5,177772,177775,177771,161065===" }
  short8 var1 = (short8) (-123455,2,2,-6,7,8,-4,6);
  short8 var2 = (short8) (6,-4,-7,5,-6,-3,-7,123445);
  int i = printf("short8_o_1241c===%-v8ho===%-v8ho===\n",var1,var2);
  return i;
}

int short8_o_2001c() {
  // { dg-printf "short8_o_2001c===177775,177772,177771,3,1,5,177770,3===177774,10,6,1,10,5,2,177770===" }
  short8 var1 = (short8) (-3,-6,-7,3,1,5,-8,3);
  short8 var2 = (short8) (-4,8,6,1,8,5,2,-8);
  int i = printf("short8_o_2001c===%+v8ho===%+v8ho===\n",var1,var2);
  return i;
}

int short8_o_2761c() {
  // { dg-printf "short8_o_2761c===016701,02,0177775,07,03,0177772,0177777,04===07,0177777,0177772,016701,0,0,06,0161065===" }
  short8 var1 = (short8) (-123455,2,-3,7,3,-6,-1,4);
  short8 var2 = (short8) (7,-1,-6,-123455,0,0,6,123445);
  int i = printf("short8_o_2761c===%#v8ho===%#v8ho===\n",var1,var2);
  return i;
}

int short8_o_3521c() {
  // { dg-printf "short8_o_3521c===177774,177774,2,161065,177771,2,177771,177774===177777,177772,161065,7,177774,1,177773,1===" }
  short8 var1 = (short8) (-4,-4,2,123445,-7,2,-7,-4);
  short8 var2 = (short8) (-1,-6,123445,7,-4,1,-5,1);
  int i = printf("short8_o_3521c===%-+v8ho===%-+v8ho===\n",var1,var2);
  return i;
}

int short8_o_4281c() {
  // { dg-printf "short8_o_4281c===         7,    161065,         4,         2,         4,         1,    177776,    161065===        10,    177777,    177773,    177773,    161065,         5,         3,         1===" }
  short8 var1 = (short8) (7,123445,4,2,4,1,-2,123445);
  short8 var2 = (short8) (8,-1,-5,-5,123445,5,3,1);
  int i = printf("short8_o_4281c===% 10v8ho===% 10v8ho===\n",var1,var2);
  return i;
}

int short8_o_481c() {
  // { dg-printf "short8_o_481c===177775,16701,10,2,6,2,177772,3===6,177774,5,177770,177772,2,1,5===" }
  short8 var1 = (short8) (-3,-123455,8,2,6,2,-6,3);
  short8 var2 = (short8) (6,-4,5,-8,-6,2,1,5);
  int i = printf("short8_o_481c===%v8ho===%v8ho===\n",var1,var2);
  return i;
}

int short8_o_5041c() {
  // { dg-printf "short8_o_5041c===0000000010,0000177771,0000000006,0000000005,0000000004,0000177771,0000177770,0000177777===0000161065,0000000007,0000177773,0000000007,0000161065,0000000007,0000177773,0000000002===" }
  short8 var1 = (short8) (8,-7,6,5,4,-7,-8,-1);
  short8 var2 = (short8) (123445,7,-5,7,123445,7,-5,2);
  int i = printf("short8_o_5041c===%010v8ho===%010v8ho===\n",var1,var2);
  return i;
}

int short8_o_5801c() {
  // { dg-printf "short8_o_5801c===6         ,1         ,161065    ,5         ,1         ,16701     ,161065    ,177772    ===2         ,4         ,16701     ,177775    ,177775    ,4         ,1         ,177771    ===" }
  short8 var1 = (short8) (6,1,123445,5,1,-123455,123445,-6);
  short8 var2 = (short8) (2,4,-123455,-3,-3,4,1,-7);
  int i = printf("short8_o_5801c===%- 10v8ho===%- 10v8ho===\n",var1,var2);
  return i;
}

int short8_o_6561c() {
  // { dg-printf "short8_o_6561c===         7,    177776,    177771,    177772,         1,         0,    177773,    177775===    161065,         2,         6,         3,    177771,    177774,         6,         0===" }
  short8 var1 = (short8) (7,-2,-7,-6,1,0,-5,-3);
  short8 var2 = (short8) (123445,2,6,3,-7,-4,6,0);
  int i = printf("short8_o_6561c===%+ 10v8ho===%+ 10v8ho===\n",var1,var2);
  return i;
}

int short8_o_7321c() {
  // { dg-printf "short8_o_7321c===0000000003,0000000001,0000177773,0000177774,0000000001,0000000007,0000177777,0000000003===0000177777,0000177777,0000177774,0000177770,0000000004,0000000001,0000000007,0000177776===" }
  short8 var1 = (short8) (3,1,-5,-4,1,7,-1,3);
  short8 var2 = (short8) (-1,-1,-4,-8,4,1,7,-2);
  int i = printf("short8_o_7321c===%+010v8ho===%+010v8ho===\n",var1,var2);
  return i;
}

int short8_u_1242c() {
  // { dg-printf "short8_u_1242c===65531,7617,65532,65534,65532,5,65529,65530===7617,4,5,7617,1,57909,65531,65535===" }
  short8 var1 = (short8) (-5,-123455,-4,-2,-4,5,-7,-6);
  short8 var2 = (short8) (-123455,4,5,-123455,1,123445,-5,-1);
  int i = printf("short8_u_1242c===%-v8hu===%-v8hu===\n",var1,var2);
  return i;
}

int short8_u_2002c() {
  // { dg-printf "short8_u_2002c===5,65534,65531,65530,65533,7,3,65531===65528,65532,57909,57909,4,57909,57909,7617===" }
  short8 var1 = (short8) (5,-2,-5,-6,-3,7,3,-5);
  short8 var2 = (short8) (-8,-4,123445,123445,4,123445,123445,-123455);
  int i = printf("short8_u_2002c===%+v8hu===%+v8hu===\n",var1,var2);
  return i;
}

int short8_u_2762c() {
  // { dg-printf "short8_u_2762c===65530,0,65532,65532,65532,65535,65532,7617===65535,65532,5,65531,65529,2,65531,1===" }
  short8 var1 = (short8) (-6,0,-4,-4,-4,-1,-4,-123455);
  short8 var2 = (short8) (-1,-4,5,-5,-7,2,-5,1);
  int i = printf("short8_u_2762c===%#v8hu===%#v8hu===\n",var1,var2);
  return i;
}

int short8_u_3522c() {
  // { dg-printf "short8_u_3522c===1,65529,8,7617,65533,6,65528,65529===8,8,4,65530,7,65530,2,8===" }
  short8 var1 = (short8) (1,-7,8,-123455,-3,6,-8,-7);
  short8 var2 = (short8) (8,8,4,-6,7,-6,2,8);
  int i = printf("short8_u_3522c===%-+v8hu===%-+v8hu===\n",var1,var2);
  return i;
}

int short8_u_4282c() {
  // { dg-printf "short8_u_4282c===      7617,     65532,     65528,     65528,         1,         4,         4,     65534===     65528,         2,      7617,         4,     65528,         4,      7617,         4===" }
  short8 var1 = (short8) (-123455,-4,-8,-8,1,4,4,-2);
  short8 var2 = (short8) (-8,2,-123455,4,-8,4,-123455,4);
  int i = printf("short8_u_4282c===% 10v8hu===% 10v8hu===\n",var1,var2);
  return i;
}

int short8_u_482c() {
  // { dg-printf "short8_u_482c===65534,65528,3,65535,7617,4,65529,7617===65529,7617,65532,65530,1,7,5,65532===" }
  short8 var1 = (short8) (-2,-8,3,-1,-123455,4,-7,-123455);
  short8 var2 = (short8) (-7,-123455,-4,-6,1,7,5,-4);
  int i = printf("short8_u_482c===%v8hu===%v8hu===\n",var1,var2);
  return i;
}

int short8_u_5042c() {
  // { dg-printf "short8_u_5042c===0000000006,0000000007,0000000000,0000065530,0000000007,0000065532,0000065529,0000000007===0000000003,0000000007,0000000000,0000000000,0000000001,0000000002,0000065533,0000000008===" }
  short8 var1 = (short8) (6,7,0,-6,7,-4,-7,7);
  short8 var2 = (short8) (3,7,0,0,1,2,-3,8);
  int i = printf("short8_u_5042c===%010v8hu===%010v8hu===\n",var1,var2);
  return i;
}

int short8_u_5802c() {
  // { dg-printf "short8_u_5802c===1         ,57909     ,2         ,65531     ,7         ,7617      ,8         ,65528     ===65528     ,65528     ,65534     ,65531     ,4         ,7         ,57909     ,3         ===" }
  short8 var1 = (short8) (1,123445,2,-5,7,-123455,8,-8);
  short8 var2 = (short8) (-8,-8,-2,-5,4,7,123445,3);
  int i = printf("short8_u_5802c===%- 10v8hu===%- 10v8hu===\n",var1,var2);
  return i;
}

int short8_u_6562c() {
  // { dg-printf "short8_u_6562c===     65535,     65528,     65530,         2,         8,     65534,     65528,         7===         6,      7617,     65528,         5,         4,     65534,     65531,         6===" }
  short8 var1 = (short8) (-1,-8,-6,2,8,-2,-8,7);
  short8 var2 = (short8) (6,-123455,-8,5,4,-2,-5,6);
  int i = printf("short8_u_6562c===%+ 10v8hu===%+ 10v8hu===\n",var1,var2);
  return i;
}

int short8_u_7322c() {
  // { dg-printf "short8_u_7322c===0000000000,0000065530,0000065533,0000065535,0000000005,0000007617,0000000008,0000057909===0000000000,0000007617,0000065529,0000065535,0000065534,0000065529,0000000005,0000000008===" }
  short8 var1 = (short8) (0,-6,-3,-1,5,-123455,8,123445);
  short8 var2 = (short8) (0,-123455,-7,-1,-2,-7,5,8);
  int i = printf("short8_u_7322c===%+010v8hu===%+010v8hu===\n",var1,var2);
  return i;
}

int short8_x_1243c() {
  // { dg-printf "short8_x_1243c===3,ffff,8,e235,1,fffa,ffff,e235===fffc,8,e235,fffb,fff9,fffd,7,fffc===" }
  short8 var1 = (short8) (3,-1,8,123445,1,-6,-1,123445);
  short8 var2 = (short8) (-4,8,123445,-5,-7,-3,7,-4);
  int i = printf("short8_x_1243c===%-v8hx===%-v8hx===\n",var1,var2);
  return i;
}

int short8_x_1244c() {
  // { dg-printf "short8_x_1244c===2,3,FFFC,2,6,5,2,FFFC===1DC1,FFFB,FFFE,7,FFFA,2,FFF8,2===" }
  short8 var1 = (short8) (2,3,-4,2,6,5,2,-4);
  short8 var2 = (short8) (-123455,-5,-2,7,-6,2,-8,2);
  int i = printf("short8_x_1244c===%-v8hX===%-v8hX===\n",var1,var2);
  return i;
}

int short8_x_2003c() {
  // { dg-printf "short8_x_2003c===1dc1,e235,8,fffc,4,fffd,fffd,ffff===1dc1,7,1,fff9,1,1,7,fffd===" }
  short8 var1 = (short8) (-123455,123445,8,-4,4,-3,-3,-1);
  short8 var2 = (short8) (-123455,7,1,-7,1,1,7,-3);
  int i = printf("short8_x_2003c===%+v8hx===%+v8hx===\n",var1,var2);
  return i;
}

int short8_x_2004c() {
  // { dg-printf "short8_x_2004c===E235,FFFC,FFFE,4,E235,4,4,FFFD===FFF9,0,0,FFFF,6,2,1DC1,FFFD===" }
  short8 var1 = (short8) (123445,-4,-2,4,123445,4,4,-3);
  short8 var2 = (short8) (-7,0,0,-1,6,2,-123455,-3);
  int i = printf("short8_x_2004c===%+v8hX===%+v8hX===\n",var1,var2);
  return i;
}

int short8_x_2763c() {
  // { dg-printf "short8_x_2763c===0xffff,0xfffe,0xfffe,0x2,0x8,0xfff9,0x4,0xfffe===0x1,0x7,0x7,0xfffd,0xe235,0xfffd,0x8,0x6===" }
  short8 var1 = (short8) (-1,-2,-2,2,8,-7,4,-2);
  short8 var2 = (short8) (1,7,7,-3,123445,-3,8,6);
  int i = printf("short8_x_2763c===%#v8hx===%#v8hx===\n",var1,var2);
  return i;
}

int short8_x_2764c() {
  // { dg-printf "short8_x_2764c===0XFFF8,0XFFFA,0X8,0XFFFE,0XFFFA,0XFFF8,0XFFFE,0XE235===0XFFFF,0X6,0X5,0X4,0X2,0XFFFE,0XFFFB,0XFFF8===" }
  short8 var1 = (short8) (-8,-6,8,-2,-6,-8,-2,123445);
  short8 var2 = (short8) (-1,6,5,4,2,-2,-5,-8);
  int i = printf("short8_x_2764c===%#v8hX===%#v8hX===\n",var1,var2);
  return i;
}

int short8_x_3523c() {
  // { dg-printf "short8_x_3523c===fffd,2,0,fff8,3,5,1dc1,e235===7,4,fffd,0,fffc,fffb,1,5===" }
  short8 var1 = (short8) (-3,2,0,-8,3,5,-123455,123445);
  short8 var2 = (short8) (7,4,-3,0,-4,-5,1,5);
  int i = printf("short8_x_3523c===%-+v8hx===%-+v8hx===\n",var1,var2);
  return i;
}

int short8_x_3524c() {
  // { dg-printf "short8_x_3524c===6,FFFA,0,FFF9,FFFA,FFF9,4,2===FFF8,FFF8,6,E235,FFFB,8,FFFD,FFF8===" }
  short8 var1 = (short8) (6,-6,0,-7,-6,-7,4,2);
  short8 var2 = (short8) (-8,-8,6,123445,-5,8,-3,-8);
  int i = printf("short8_x_3524c===%-+v8hX===%-+v8hX===\n",var1,var2);
  return i;
}

int short8_x_4283c() {
  // { dg-printf "short8_x_4283c===      fffc,      fff9,      e235,         6,         7,      fffe,         1,      fffc===         8,      fffa,         1,         8,         8,         4,         6,      fff8===" }
  short8 var1 = (short8) (-4,-7,123445,6,7,-2,1,-4);
  short8 var2 = (short8) (8,-6,1,8,8,4,6,-8);
  int i = printf("short8_x_4283c===% 10v8hx===% 10v8hx===\n",var1,var2);
  return i;
}

int short8_x_4284c() {
  // { dg-printf "short8_x_4284c===      FFFB,         6,         6,         3,         2,      FFFB,      FFFE,         1===      FFFD,      1DC1,         3,      FFFC,      FFFA,         7,      FFF9,         2===" }
  short8 var1 = (short8) (-5,6,6,3,2,-5,-2,1);
  short8 var2 = (short8) (-3,-123455,3,-4,-6,7,-7,2);
  int i = printf("short8_x_4284c===% 10v8hX===% 10v8hX===\n",var1,var2);
  return i;
}

int short8_x_483c() {
  // { dg-printf "short8_x_483c===1,7,7,ffff,7,fff9,5,4===fff9,fffa,fffa,8,fffe,fffc,fffc,1dc1===" }
  short8 var1 = (short8) (1,7,7,-1,7,-7,5,4);
  short8 var2 = (short8) (-7,-6,-6,8,-2,-4,-4,-123455);
  int i = printf("short8_x_483c===%v8hx===%v8hx===\n",var1,var2);
  return i;
}

int short8_x_484c() {
  // { dg-printf "short8_x_484c===3,FFFF,2,FFFD,2,FFFF,FFFD,2===1DC1,FFFF,FFFC,3,5,0,1DC1,FFFF===" }
  short8 var1 = (short8) (3,-1,2,-3,2,-1,-3,2);
  short8 var2 = (short8) (-123455,-1,-4,3,5,0,-123455,-1);
  int i = printf("short8_x_484c===%v8hX===%v8hX===\n",var1,var2);
  return i;
}

int short8_x_5043c() {
  // { dg-printf "short8_x_5043c===0000000007,000000fffc,000000ffff,000000ffff,000000fffe,0000000006,0000000002,0000000004===0000000008,0000001dc1,000000fff8,0000001dc1,0000000001,0000000003,0000000002,000000e235===" }
  short8 var1 = (short8) (7,-4,-1,-1,-2,6,2,4);
  short8 var2 = (short8) (8,-123455,-8,-123455,1,3,2,123445);
  int i = printf("short8_x_5043c===%010v8hx===%010v8hx===\n",var1,var2);
  return i;
}

int short8_x_5044c() {
  // { dg-printf "short8_x_5044c===000000FFFF,000000FFFC,0000000008,0000000001,000000FFFD,0000000006,000000FFFE,0000000002===000000FFFD,0000001DC1,0000000006,000000FFFA,000000FFFA,0000000004,0000001DC1,000000FFF9===" }
  short8 var1 = (short8) (-1,-4,8,1,-3,6,-2,2);
  short8 var2 = (short8) (-3,-123455,6,-6,-6,4,-123455,-7);
  int i = printf("short8_x_5044c===%010v8hX===%010v8hX===\n",var1,var2);
  return i;
}

int short8_x_5803c() {
  // { dg-printf "short8_x_5803c===1dc1      ,0         ,1         ,2         ,8         ,1dc1      ,4         ,0         ===1dc1      ,ffff      ,fff8      ,0         ,1         ,fffe      ,1dc1      ,fffd      ===" }
  short8 var1 = (short8) (-123455,0,1,2,8,-123455,4,0);
  short8 var2 = (short8) (-123455,-1,-8,0,1,-2,-123455,-3);
  int i = printf("short8_x_5803c===%- 10v8hx===%- 10v8hx===\n",var1,var2);
  return i;
}

int short8_x_5804c() {
  // { dg-printf "short8_x_5804c===3         ,0         ,4         ,FFF9      ,7         ,3         ,FFFD      ,FFFD      ===0         ,FFFD      ,7         ,6         ,1DC1      ,4         ,8         ,3         ===" }
  short8 var1 = (short8) (3,0,4,-7,7,3,-3,-3);
  short8 var2 = (short8) (0,-3,7,6,-123455,4,8,3);
  int i = printf("short8_x_5804c===%- 10v8hX===%- 10v8hX===\n",var1,var2);
  return i;
}

int short8_x_6563c() {
  // { dg-printf "short8_x_6563c===      ffff,      fffa,      1dc1,      1dc1,      ffff,      e235,      fffb,      ffff===         1,         6,         2,      fffc,         3,         7,         0,      1dc1===" }
  short8 var1 = (short8) (-1,-6,-123455,-123455,-1,123445,-5,-1);
  short8 var2 = (short8) (1,6,2,-4,3,7,0,-123455);
  int i = printf("short8_x_6563c===%+ 10v8hx===%+ 10v8hx===\n",var1,var2);
  return i;
}

int short8_x_6564c() {
  // { dg-printf "short8_x_6564c===      1DC1,         6,      1DC1,      FFFE,      1DC1,      1DC1,         8,         6===      FFFF,      FFFD,      FFF8,         5,         4,         5,         1,      FFFD===" }
  short8 var1 = (short8) (-123455,6,-123455,-2,-123455,-123455,8,6);
  short8 var2 = (short8) (-1,-3,-8,5,4,5,1,-3);
  int i = printf("short8_x_6564c===%+ 10v8hX===%+ 10v8hX===\n",var1,var2);
  return i;
}

int short8_x_7323c() {
  // { dg-printf "short8_x_7323c===0000000004,000000fffb,000000fff8,000000fffd,0000000000,0000000005,0000000006,0000000008===000000fff9,000000fffc,000000ffff,000000fff9,000000e235,0000000004,0000001dc1,000000fff9===" }
  short8 var1 = (short8) (4,-5,-8,-3,0,5,6,8);
  short8 var2 = (short8) (-7,-4,-1,-7,123445,4,-123455,-7);
  int i = printf("short8_x_7323c===%+010v8hx===%+010v8hx===\n",var1,var2);
  return i;
}

int short8_x_7324c() {
  // { dg-printf "short8_x_7324c===000000FFFA,0000000001,0000000001,000000E235,0000000004,0000000004,000000E235,000000FFFD===000000FFFB,000000FFF8,000000FFF8,000000FFF9,0000000002,0000000006,0000000003,000000FFFE===" }
  short8 var1 = (short8) (-6,1,1,123445,4,4,123445,-3);
  short8 var2 = (short8) (-5,-8,-8,-7,2,6,3,-2);
  int i = printf("short8_x_7324c===%+010v8hX===%+010v8hX===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = short8_d_1239c();
i = short8_d_1999c();
i = short8_d_2759c();
i = short8_d_3519c();
i = short8_d_4279c();
i = short8_d_479c();
i = short8_d_5039c();
i = short8_d_5799c();
i = short8_d_6559c();
i = short8_d_7319c();
i = short8_i_1240c();
i = short8_i_2000c();
i = short8_i_2760c();
i = short8_i_3520c();
i = short8_i_4280c();
i = short8_i_480c();
i = short8_i_5040c();
i = short8_i_5800c();
i = short8_i_6560c();
i = short8_i_7320c();
i = short8_o_1241c();
i = short8_o_2001c();
i = short8_o_2761c();
i = short8_o_3521c();
i = short8_o_4281c();
i = short8_o_481c();
i = short8_o_5041c();
i = short8_o_5801c();
i = short8_o_6561c();
i = short8_o_7321c();
i = short8_u_1242c();
i = short8_u_2002c();
i = short8_u_2762c();
i = short8_u_3522c();
i = short8_u_4282c();
i = short8_u_482c();
i = short8_u_5042c();
i = short8_u_5802c();
i = short8_u_6562c();
i = short8_u_7322c();
i = short8_x_1243c();
i = short8_x_1244c();
i = short8_x_2003c();
i = short8_x_2004c();
i = short8_x_2763c();
i = short8_x_2764c();
i = short8_x_3523c();
i = short8_x_3524c();
i = short8_x_4283c();
i = short8_x_4284c();
i = short8_x_483c();
i = short8_x_484c();
i = short8_x_5043c();
i = short8_x_5044c();
i = short8_x_5803c();
i = short8_x_5804c();
i = short8_x_6563c();
i = short8_x_6564c();
i = short8_x_7323c();
i = short8_x_7324c();
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
