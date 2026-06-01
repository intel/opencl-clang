/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/long8.c'  */

int long8_d_1331c() {
  // { dg-printf "long8_d_1331c===-123455,8,4,-5,8,-123455,-6,6===2,-2,7,-6,-7,8,-7,3===" }
  long8 var1 = (long8) (-123455,8,4,-5,8,-123455,-6,6);
  long8 var2 = (long8) (2,-2,7,-6,-7,8,-7,3);
  int i = printf("long8_d_1331c===%-v8ld===%-v8ld===\n",var1,var2);
  return i;
}

int long8_d_2091c() {
  // { dg-printf "long8_d_2091c===+123445,-6,-6,+123445,+0,-123455,-4,+6===+7,+3,+4,+2,-2,-8,+5,-2===" }
  long8 var1 = (long8) (123445,-6,-6,123445,0,-123455,-4,6);
  long8 var2 = (long8) (7,3,4,2,-2,-8,5,-2);
  int i = printf("long8_d_2091c===%+v8ld===%+v8ld===\n",var1,var2);
  return i;
}

int long8_d_2851c() {
  // { dg-printf "long8_d_2851c===5,0,-123455,-123455,7,-3,1,-2===4,2,6,8,-2,4,0,4===" }
  long8 var1 = (long8) (5,0,-123455,-123455,7,-3,1,-2);
  long8 var2 = (long8) (4,2,6,8,-2,4,0,4);
  int i = printf("long8_d_2851c===%#v8ld===%#v8ld===\n",var1,var2);
  return i;
}

int long8_d_3611c() {
  // { dg-printf "long8_d_3611c===-7,-5,-3,+5,+6,+5,-7,+4===-2,+0,-123455,-6,+0,+123445,+0,+6===" }
  long8 var1 = (long8) (-7,-5,-3,5,6,5,-7,4);
  long8 var2 = (long8) (-2,0,-123455,-6,0,123445,0,6);
  int i = printf("long8_d_3611c===%-+v8ld===%-+v8ld===\n",var1,var2);
  return i;
}

int long8_d_4371c() {
  // { dg-printf "long8_d_4371c===        -3,         6,         0,        -2,        -2,        -6,        -8,         5===         8,   -123455,         5,    123445,    123445,         2,         0,    123445===" }
  long8 var1 = (long8) (-3,6,0,-2,-2,-6,-8,5);
  long8 var2 = (long8) (8,-123455,5,123445,123445,2,0,123445);
  int i = printf("long8_d_4371c===% 10v8ld===% 10v8ld===\n",var1,var2);
  return i;
}

int long8_d_5131c() {
  // { dg-printf "long8_d_5131c===-000000007,-000000005,0000000008,0000000003,0000000001,0000000001,0000000005,0000000000===0000000001,0000000001,0000000006,-000000004,-000000002,0000000000,0000000006,0000000001===" }
  long8 var1 = (long8) (-7,-5,8,3,1,1,5,0);
  long8 var2 = (long8) (1,1,6,-4,-2,0,6,1);
  int i = printf("long8_d_5131c===%010v8ld===%010v8ld===\n",var1,var2);
  return i;
}

int long8_d_571c() {
  // { dg-printf "long8_d_571c===3,-123455,-6,6,7,8,0,-7===8,2,5,-2,2,0,-5,3===" }
  long8 var1 = (long8) (3,-123455,-6,6,7,8,0,-7);
  long8 var2 = (long8) (8,2,5,-2,2,0,-5,3);
  int i = printf("long8_d_571c===%v8ld===%v8ld===\n",var1,var2);
  return i;
}

int long8_d_5891c() {
  // { dg-printf "long8_d_5891c=== 2        , 123445   ,-2        , 5        ,-2        , 1        ,-8        , 123445   ===-5        , 0        ,-2        , 0        ,-5        , 4        ,-123455   ,-5        ===" }
  long8 var1 = (long8) (2,123445,-2,5,-2,1,-8,123445);
  long8 var2 = (long8) (-5,0,-2,0,-5,4,-123455,-5);
  int i = printf("long8_d_5891c===%- 10v8ld===%- 10v8ld===\n",var1,var2);
  return i;
}

int long8_d_6651c() {
  // { dg-printf "long8_d_6651c===        +4,        +3,        -6,        +8,        -3,        +8,   +123445,        -2===        +8,        +3,        +8,        +1,        -2,        -3,        +6,        -6===" }
  long8 var1 = (long8) (4,3,-6,8,-3,8,123445,-2);
  long8 var2 = (long8) (8,3,8,1,-2,-3,6,-6);
  int i = printf("long8_d_6651c===%+ 10v8ld===%+ 10v8ld===\n",var1,var2);
  return i;
}

int long8_d_7411c() {
  // { dg-printf "long8_d_7411c===+000000000,-000000001,-000000008,+000000006,+000123445,+000000000,-000000004,+000123445===+000123445,-000000006,+000000008,-000000005,+000000002,+000000002,+000000001,+000000000===" }
  long8 var1 = (long8) (0,-1,-8,6,123445,0,-4,123445);
  long8 var2 = (long8) (123445,-6,8,-5,2,2,1,0);
  int i = printf("long8_d_7411c===%+010v8ld===%+010v8ld===\n",var1,var2);
  return i;
}

int long8_i_1332c() {
  // { dg-printf "long8_i_1332c===-5,123445,6,-123455,-1,-7,-2,-123455===0,5,6,8,-7,1,-123455,-8===" }
  long8 var1 = (long8) (-5,123445,6,-123455,-1,-7,-2,-123455);
  long8 var2 = (long8) (0,5,6,8,-7,1,-123455,-8);
  int i = printf("long8_i_1332c===%-v8li===%-v8li===\n",var1,var2);
  return i;
}

int long8_i_2092c() {
  // { dg-printf "long8_i_2092c===+2,+8,-2,+0,+3,-4,+0,-4===-5,+2,+7,-6,+5,+1,+6,-5===" }
  long8 var1 = (long8) (2,8,-2,0,3,-4,0,-4);
  long8 var2 = (long8) (-5,2,7,-6,5,1,6,-5);
  int i = printf("long8_i_2092c===%+v8li===%+v8li===\n",var1,var2);
  return i;
}

int long8_i_2852c() {
  // { dg-printf "long8_i_2852c===8,6,7,4,1,-123455,2,6===1,-123455,123445,0,-123455,7,-3,4===" }
  long8 var1 = (long8) (8,6,7,4,1,-123455,2,6);
  long8 var2 = (long8) (1,-123455,123445,0,-123455,7,-3,4);
  int i = printf("long8_i_2852c===%#v8li===%#v8li===\n",var1,var2);
  return i;
}

int long8_i_3612c() {
  // { dg-printf "long8_i_3612c===+8,+123445,-8,-4,-3,-5,-1,+8===-4,+4,+3,+5,-6,+5,-7,+5===" }
  long8 var1 = (long8) (8,123445,-8,-4,-3,-5,-1,8);
  long8 var2 = (long8) (-4,4,3,5,-6,5,-7,5);
  int i = printf("long8_i_3612c===%-+v8li===%-+v8li===\n",var1,var2);
  return i;
}

int long8_i_4372c() {
  // { dg-printf "long8_i_4372c===   -123455,         3,        -4,         8,         1,         0,   -123455,        -7===         3,         0,         2,         7,        -2,        -2,         4,        -1===" }
  long8 var1 = (long8) (-123455,3,-4,8,1,0,-123455,-7);
  long8 var2 = (long8) (3,0,2,7,-2,-2,4,-1);
  int i = printf("long8_i_4372c===% 10v8li===% 10v8li===\n",var1,var2);
  return i;
}

int long8_i_5132c() {
  // { dg-printf "long8_i_5132c===0000000001,0000000002,-000000001,0000000005,-000000003,-000000001,-000000007,-000000001===0000000001,0000000008,-000000008,0000000000,0000000007,-000000001,0000000006,-000000008===" }
  long8 var1 = (long8) (1,2,-1,5,-3,-1,-7,-1);
  long8 var2 = (long8) (1,8,-8,0,7,-1,6,-8);
  int i = printf("long8_i_5132c===%010v8li===%010v8li===\n",var1,var2);
  return i;
}

int long8_i_572c() {
  // { dg-printf "long8_i_572c===0,7,-123455,-4,7,123445,-2,2===6,-4,7,-7,-123455,8,-1,3===" }
  long8 var1 = (long8) (0,7,-123455,-4,7,123445,-2,2);
  long8 var2 = (long8) (6,-4,7,-7,-123455,8,-1,3);
  int i = printf("long8_i_572c===%v8li===%v8li===\n",var1,var2);
  return i;
}

int long8_i_5892c() {
  // { dg-printf "long8_i_5892c=== 123445   , 1        ,-2        ,-3        ,-8        ,-7        , 1        ,-1        === 5        ,-6        ,-2        , 0        , 4        , 5        , 0        , 7        ===" }
  long8 var1 = (long8) (123445,1,-2,-3,-8,-7,1,-1);
  long8 var2 = (long8) (5,-6,-2,0,4,5,0,7);
  int i = printf("long8_i_5892c===%- 10v8li===%- 10v8li===\n",var1,var2);
  return i;
}

int long8_i_6652c() {
  // { dg-printf "long8_i_6652c===        +5,        -6,        -2,        -3,        +4,   -123455,        +0,   -123455===        -8,        -7,        -5,        +1,        -4,        -3,        -2,        +7===" }
  long8 var1 = (long8) (5,-6,-2,-3,4,-123455,0,-123455);
  long8 var2 = (long8) (-8,-7,-5,1,-4,-3,-2,7);
  int i = printf("long8_i_6652c===%+ 10v8li===%+ 10v8li===\n",var1,var2);
  return i;
}

int long8_i_7412c() {
  // { dg-printf "long8_i_7412c===+000000000,+000000000,+000000008,-000000007,+000000005,+000000006,+000000004,+000000005===+000000004,+000000006,+000000008,-000000002,+000000002,+000000003,+000000001,-000000005===" }
  long8 var1 = (long8) (0,0,8,-7,5,6,4,5);
  long8 var2 = (long8) (4,6,8,-2,2,3,1,-5);
  int i = printf("long8_i_7412c===%+010v8li===%+010v8li===\n",var1,var2);
  return i;
}

int long8_o_1333c() {
  // { dg-printf "long8_o_1333c===1777777777777777777771,1777777777777777777776,361065,1777777777777777777773,5,1777777777777777777777,1,0===0,1777777777777777777773,1777777777777777777776,2,1777777777777777777775,3,5,3===" }
  long8 var1 = (long8) (-7,-2,123445,-5,5,-1,1,0);
  long8 var2 = (long8) (0,-5,-2,2,-3,3,5,3);
  int i = printf("long8_o_1333c===%-v8lo===%-v8lo===\n",var1,var2);
  return i;
}

int long8_o_2093c() {
  // { dg-printf "long8_o_2093c===1777777777777777777774,1777777777777777777773,1777777777777777777773,5,1777777777777777777771,2,10,7===5,10,6,1777777777777777777772,1777777777777777777773,1777777777777777777775,10,361065===" }
  long8 var1 = (long8) (-4,-5,-5,5,-7,2,8,7);
  long8 var2 = (long8) (5,8,6,-6,-5,-3,8,123445);
  int i = printf("long8_o_2093c===%+v8lo===%+v8lo===\n",var1,var2);
  return i;
}

int long8_o_2853c() {
  // { dg-printf "long8_o_2853c===01777777777777777777772,03,05,010,01777777777777777777776,01777777777777777777770,010,01===01777777777777777777775,04,03,05,01777777777777777777776,01777777777777777777771,01777777777777777777772,010===" }
  long8 var1 = (long8) (-6,3,5,8,-2,-8,8,1);
  long8 var2 = (long8) (-3,4,3,5,-2,-7,-6,8);
  int i = printf("long8_o_2853c===%#v8lo===%#v8lo===\n",var1,var2);
  return i;
}

int long8_o_3613c() {
  // { dg-printf "long8_o_3613c===1777777777777777777774,5,1777777777777777777777,1777777777777777777773,7,1777777777777777777775,1777777777777777777770,7===2,2,6,1777777777777777416701,4,5,2,3===" }
  long8 var1 = (long8) (-4,5,-1,-5,7,-3,-8,7);
  long8 var2 = (long8) (2,2,6,-123455,4,5,2,3);
  int i = printf("long8_o_3613c===%-+v8lo===%-+v8lo===\n",var1,var2);
  return i;
}

int long8_o_4373c() {
  // { dg-printf "long8_o_4373c===         2,         1,         2,         3,    361065,         1,1777777777777777777777,        10===1777777777777777416701,1777777777777777777773,         3,         5,         0,         0,    361065,         2===" }
  long8 var1 = (long8) (2,1,2,3,123445,1,-1,8);
  long8 var2 = (long8) (-123455,-5,3,5,0,0,123445,2);
  int i = printf("long8_o_4373c===% 10v8lo===% 10v8lo===\n",var1,var2);
  return i;
}

int long8_o_5133c() {
  // { dg-printf "long8_o_5133c===1777777777777777777774,1777777777777777777773,0000000004,0000000005,1777777777777777777771,1777777777777777777772,0000361065,1777777777777777777773===0000000006,0000000005,0000000003,0000000005,1777777777777777777773,0000000005,1777777777777777777777,0000000002===" }
  long8 var1 = (long8) (-4,-5,4,5,-7,-6,123445,-5);
  long8 var2 = (long8) (6,5,3,5,-5,5,-1,2);
  int i = printf("long8_o_5133c===%010v8lo===%010v8lo===\n",var1,var2);
  return i;
}

int long8_o_573c() {
  // { dg-printf "long8_o_573c===1777777777777777777774,1,4,1777777777777777777773,1777777777777777416701,1777777777777777777775,1,5===1777777777777777777771,1777777777777777777773,361065,1,1777777777777777777776,7,2,1777777777777777777772===" }
  long8 var1 = (long8) (-4,1,4,-5,-123455,-3,1,5);
  long8 var2 = (long8) (-7,-5,123445,1,-2,7,2,-6);
  int i = printf("long8_o_573c===%v8lo===%v8lo===\n",var1,var2);
  return i;
}

int long8_o_5893c() {
  // { dg-printf "long8_o_5893c===1777777777777777777773,3         ,7         ,1777777777777777777770,361065    ,1777777777777777777775,6         ,0         ===7         ,6         ,0         ,5         ,1777777777777777416701,1777777777777777777776,1777777777777777777772,1777777777777777777772===" }
  long8 var1 = (long8) (-5,3,7,-8,123445,-3,6,0);
  long8 var2 = (long8) (7,6,0,5,-123455,-2,-6,-6);
  int i = printf("long8_o_5893c===%- 10v8lo===%- 10v8lo===\n",var1,var2);
  return i;
}

int long8_o_6653c() {
  // { dg-printf "long8_o_6653c===1777777777777777777775,1777777777777777777776,         7,         3,         6,         0,1777777777777777777772,         3===    361065,1777777777777777777770,1777777777777777777773,1777777777777777777774,1777777777777777777774,1777777777777777777777,1777777777777777416701,         7===" }
  long8 var1 = (long8) (-3,-2,7,3,6,0,-6,3);
  long8 var2 = (long8) (123445,-8,-5,-4,-4,-1,-123455,7);
  int i = printf("long8_o_6653c===%+ 10v8lo===%+ 10v8lo===\n",var1,var2);
  return i;
}

int long8_o_7413c() {
  // { dg-printf "long8_o_7413c===1777777777777777416701,0000000006,0000000003,0000000002,0000000004,0000000000,1777777777777777777770,1777777777777777777774===0000000000,0000000001,0000361065,1777777777777777777774,0000361065,0000000010,1777777777777777777771,1777777777777777777771===" }
  long8 var1 = (long8) (-123455,6,3,2,4,0,-8,-4);
  long8 var2 = (long8) (0,1,123445,-4,123445,8,-7,-7);
  int i = printf("long8_o_7413c===%+010v8lo===%+010v8lo===\n",var1,var2);
  return i;
}

int long8_u_1334c() {
  // { dg-printf "long8_u_1334c===18446744073709551615,7,1,18446744073709551612,2,7,18446744073709551612,0===6,5,4,18446744073709551611,7,18446744073709551615,18446744073709551609,3===" }
  long8 var1 = (long8) (-1,7,1,-4,2,7,-4,0);
  long8 var2 = (long8) (6,5,4,-5,7,-1,-7,3);
  int i = printf("long8_u_1334c===%-v8lu===%-v8lu===\n",var1,var2);
  return i;
}

int long8_u_2094c() {
  // { dg-printf "long8_u_2094c===8,18446744073709428161,8,18446744073709551609,18446744073709551613,18446744073709551610,18446744073709551609,8===18446744073709428161,18446744073709551613,18446744073709551613,1,18446744073709551613,4,123445,18446744073709428161===" }
  long8 var1 = (long8) (8,-123455,8,-7,-3,-6,-7,8);
  long8 var2 = (long8) (-123455,-3,-3,1,-3,4,123445,-123455);
  int i = printf("long8_u_2094c===%+v8lu===%+v8lu===\n",var1,var2);
  return i;
}

int long8_u_2854c() {
  // { dg-printf "long8_u_2854c===18446744073709551613,18446744073709551614,4,123445,18446744073709551608,2,7,3===18446744073709551612,4,18446744073709551610,123445,3,18446744073709551610,123445,8===" }
  long8 var1 = (long8) (-3,-2,4,123445,-8,2,7,3);
  long8 var2 = (long8) (-4,4,-6,123445,3,-6,123445,8);
  int i = printf("long8_u_2854c===%#v8lu===%#v8lu===\n",var1,var2);
  return i;
}

int long8_u_3614c() {
  // { dg-printf "long8_u_3614c===18446744073709551612,18446744073709551609,123445,1,18446744073709428161,18446744073709551609,8,18446744073709551615===18446744073709551610,1,18446744073709551608,123445,5,18446744073709428161,18446744073709551615,1===" }
  long8 var1 = (long8) (-4,-7,123445,1,-123455,-7,8,-1);
  long8 var2 = (long8) (-6,1,-8,123445,5,-123455,-1,1);
  int i = printf("long8_u_3614c===%-+v8lu===%-+v8lu===\n",var1,var2);
  return i;
}

int long8_u_4374c() {
  // { dg-printf "long8_u_4374c===18446744073709428161,         1,18446744073709551613,         0,         1,         6,18446744073709428161,18446744073709551608===         5,18446744073709551610,18446744073709551612,18446744073709551613,18446744073709551609,         3,18446744073709551609,18446744073709428161===" }
  long8 var1 = (long8) (-123455,1,-3,0,1,6,-123455,-8);
  long8 var2 = (long8) (5,-6,-4,-3,-7,3,-7,-123455);
  int i = printf("long8_u_4374c===% 10v8lu===% 10v8lu===\n",var1,var2);
  return i;
}

int long8_u_5134c() {
  // { dg-printf "long8_u_5134c===18446744073709551612,18446744073709551614,18446744073709551612,0000000006,0000000005,0000000008,0000000002,18446744073709551613===18446744073709551609,18446744073709551611,18446744073709551611,18446744073709551611,18446744073709551611,0000000004,0000000005,18446744073709551612===" }
  long8 var1 = (long8) (-4,-2,-4,6,5,8,2,-3);
  long8 var2 = (long8) (-7,-5,-5,-5,-5,4,5,-4);
  int i = printf("long8_u_5134c===%010v8lu===%010v8lu===\n",var1,var2);
  return i;
}

int long8_u_574c() {
  // { dg-printf "long8_u_574c===18446744073709551612,18446744073709551609,2,0,18446744073709428161,18446744073709551609,18446744073709551610,18446744073709551614===18446744073709551612,18446744073709551613,18446744073709551612,18446744073709551614,3,18446744073709551611,1,18446744073709551611===" }
  long8 var1 = (long8) (-4,-7,2,0,-123455,-7,-6,-2);
  long8 var2 = (long8) (-4,-3,-4,-2,3,-5,1,-5);
  int i = printf("long8_u_574c===%v8lu===%v8lu===\n",var1,var2);
  return i;
}

int long8_u_5894c() {
  // { dg-printf "long8_u_5894c===8         ,6         ,5         ,18446744073709551612,2         ,8         ,8         ,6         ===18446744073709551608,5         ,18446744073709551608,18446744073709551614,5         ,2         ,0         ,7         ===" }
  long8 var1 = (long8) (8,6,5,-4,2,8,8,6);
  long8 var2 = (long8) (-8,5,-8,-2,5,2,0,7);
  int i = printf("long8_u_5894c===%- 10v8lu===%- 10v8lu===\n",var1,var2);
  return i;
}

int long8_u_6654c() {
  // { dg-printf "long8_u_6654c===         8,18446744073709551612,18446744073709551615,18446744073709551615,         4,18446744073709551614,         3,18446744073709551608===         6,         0,18446744073709551615,         8,18446744073709428161,18446744073709551614,         8,         1===" }
  long8 var1 = (long8) (8,-4,-1,-1,4,-2,3,-8);
  long8 var2 = (long8) (6,0,-1,8,-123455,-2,8,1);
  int i = printf("long8_u_6654c===%+ 10v8lu===%+ 10v8lu===\n",var1,var2);
  return i;
}

int long8_u_7414c() {
  // { dg-printf "long8_u_7414c===18446744073709551608,18446744073709551613,18446744073709551611,18446744073709551614,0000000002,0000000002,18446744073709551611,0000000008===0000000000,0000000007,0000000002,18446744073709428161,18446744073709551610,0000000001,0000000004,18446744073709551612===" }
  long8 var1 = (long8) (-8,-3,-5,-2,2,2,-5,8);
  long8 var2 = (long8) (0,7,2,-123455,-6,1,4,-4);
  int i = printf("long8_u_7414c===%+010v8lu===%+010v8lu===\n",var1,var2);
  return i;
}

int long8_x_1335c() {
  // { dg-printf "long8_x_1335c===1,3,2,fffffffffffffffb,0,fffffffffffe1dc1,fffffffffffffff9,2===0,fffffffffffe1dc1,4,fffffffffffffffc,4,fffffffffffffff8,5,7===" }
  long8 var1 = (long8) (1,3,2,-5,0,-123455,-7,2);
  long8 var2 = (long8) (0,-123455,4,-4,4,-8,5,7);
  int i = printf("long8_x_1335c===%-v8lx===%-v8lx===\n",var1,var2);
  return i;
}

int long8_x_1336c() {
  // { dg-printf "long8_x_1336c===FFFFFFFFFFFFFFF8,8,FFFFFFFFFFFFFFFF,FFFFFFFFFFFFFFFA,FFFFFFFFFFFFFFFD,FFFFFFFFFFFFFFFB,4,FFFFFFFFFFFFFFFF===FFFFFFFFFFFE1DC1,7,FFFFFFFFFFFFFFFE,FFFFFFFFFFFE1DC1,1E235,FFFFFFFFFFFFFFFD,1,FFFFFFFFFFFFFFF9===" }
  long8 var1 = (long8) (-8,8,-1,-6,-3,-5,4,-1);
  long8 var2 = (long8) (-123455,7,-2,-123455,123445,-3,1,-7);
  int i = printf("long8_x_1336c===%-v8lX===%-v8lX===\n",var1,var2);
  return i;
}

int long8_x_2095c() {
  // { dg-printf "long8_x_2095c===1,fffffffffffffffb,8,0,3,ffffffffffffffff,fffffffffffffffa,fffffffffffffffd===0,6,1e235,2,fffffffffffffffe,6,7,fffffffffffe1dc1===" }
  long8 var1 = (long8) (1,-5,8,0,3,-1,-6,-3);
  long8 var2 = (long8) (0,6,123445,2,-2,6,7,-123455);
  int i = printf("long8_x_2095c===%+v8lx===%+v8lx===\n",var1,var2);
  return i;
}

int long8_x_2096c() {
  // { dg-printf "long8_x_2096c===2,FFFFFFFFFFFE1DC1,2,3,FFFFFFFFFFFFFFF9,0,FFFFFFFFFFFFFFF9,FFFFFFFFFFFFFFFB===FFFFFFFFFFFFFFF9,FFFFFFFFFFFFFFFA,FFFFFFFFFFFFFFFF,FFFFFFFFFFFFFFF9,1,7,1E235,0===" }
  long8 var1 = (long8) (2,-123455,2,3,-7,0,-7,-5);
  long8 var2 = (long8) (-7,-6,-1,-7,1,7,123445,0);
  int i = printf("long8_x_2096c===%+v8lX===%+v8lX===\n",var1,var2);
  return i;
}

int long8_x_2855c() {
  // { dg-printf "long8_x_2855c===0xfffffffffffffffd,0x1,0x2,0,0x7,0xfffffffffffffffd,0xfffffffffffffffc,0x7===0,0,0xffffffffffffffff,0xfffffffffffffff9,0xfffffffffffffffb,0xfffffffffffffffb,0xffffffffffffffff,0xfffffffffffffff9===" }
  long8 var1 = (long8) (-3,1,2,0,7,-3,-4,7);
  long8 var2 = (long8) (0,0,-1,-7,-5,-5,-1,-7);
  int i = printf("long8_x_2855c===%#v8lx===%#v8lx===\n",var1,var2);
  return i;
}

int long8_x_2856c() {
  // { dg-printf "long8_x_2856c===0XFFFFFFFFFFFFFFFB,0,0XFFFFFFFFFFFFFFFB,0X3,0X4,0XFFFFFFFFFFFFFFF8,0,0XFFFFFFFFFFFFFFFB===0XFFFFFFFFFFFFFFFB,0X1E235,0X1,0X1,0XFFFFFFFFFFFFFFFC,0X6,0XFFFFFFFFFFFFFFFD,0X8===" }
  long8 var1 = (long8) (-5,0,-5,3,4,-8,0,-5);
  long8 var2 = (long8) (-5,123445,1,1,-4,6,-3,8);
  int i = printf("long8_x_2856c===%#v8lX===%#v8lX===\n",var1,var2);
  return i;
}

int long8_x_3615c() {
  // { dg-printf "long8_x_3615c===0,5,ffffffffffffffff,fffffffffffffffd,fffffffffffffffa,1e235,fffffffffffe1dc1,1===7,1,fffffffffffffffe,fffffffffffffffe,3,2,fffffffffffffffd,4===" }
  long8 var1 = (long8) (0,5,-1,-3,-6,123445,-123455,1);
  long8 var2 = (long8) (7,1,-2,-2,3,2,-3,4);
  int i = printf("long8_x_3615c===%-+v8lx===%-+v8lx===\n",var1,var2);
  return i;
}

int long8_x_3616c() {
  // { dg-printf "long8_x_3616c===FFFFFFFFFFFFFFFF,FFFFFFFFFFFFFFFA,FFFFFFFFFFFFFFFE,FFFFFFFFFFFFFFF8,FFFFFFFFFFFFFFFF,2,2,FFFFFFFFFFFFFFFE===FFFFFFFFFFFFFFFE,6,FFFFFFFFFFFFFFFD,FFFFFFFFFFFFFFFE,FFFFFFFFFFFFFFFD,3,8,FFFFFFFFFFFE1DC1===" }
  long8 var1 = (long8) (-1,-6,-2,-8,-1,2,2,-2);
  long8 var2 = (long8) (-2,6,-3,-2,-3,3,8,-123455);
  int i = printf("long8_x_3616c===%-+v8lX===%-+v8lX===\n",var1,var2);
  return i;
}

int long8_x_4375c() {
  // { dg-printf "long8_x_4375c===         4,fffffffffffffff8,fffffffffffffffd,fffffffffffffffc,fffffffffffffff9,fffffffffffffff9,     1e235,fffffffffffffff8===fffffffffffffffd,         6,fffffffffffffffb,fffffffffffffff8,fffffffffffffffe,fffffffffffffffc,         0,         7===" }
  long8 var1 = (long8) (4,-8,-3,-4,-7,-7,123445,-8);
  long8 var2 = (long8) (-3,6,-5,-8,-2,-4,0,7);
  int i = printf("long8_x_4375c===% 10v8lx===% 10v8lx===\n",var1,var2);
  return i;
}

int long8_x_4376c() {
  // { dg-printf "long8_x_4376c===         4,FFFFFFFFFFFFFFFE,         2,FFFFFFFFFFFFFFFE,FFFFFFFFFFFFFFFC,         7,         8,         0===         1,         8,         7,         3,         3,FFFFFFFFFFFFFFFB,         8,         5===" }
  long8 var1 = (long8) (4,-2,2,-2,-4,7,8,0);
  long8 var2 = (long8) (1,8,7,3,3,-5,8,5);
  int i = printf("long8_x_4376c===% 10v8lX===% 10v8lX===\n",var1,var2);
  return i;
}

int long8_x_5135c() {
  // { dg-printf "long8_x_5135c===0000000007,0000000000,fffffffffffffff9,000001e235,0000000003,0000000000,fffffffffffffffd,0000000005===0000000004,fffffffffffffffd,fffffffffffffffb,fffffffffffffffe,0000000004,fffffffffffffffe,fffffffffffffffd,0000000005===" }
  long8 var1 = (long8) (7,0,-7,123445,3,0,-3,5);
  long8 var2 = (long8) (4,-3,-5,-2,4,-2,-3,5);
  int i = printf("long8_x_5135c===%010v8lx===%010v8lx===\n",var1,var2);
  return i;
}

int long8_x_5136c() {
  // { dg-printf "long8_x_5136c===0000000003,FFFFFFFFFFFFFFFF,FFFFFFFFFFFFFFFA,FFFFFFFFFFFFFFFC,FFFFFFFFFFFFFFF8,0000000008,000001E235,0000000003===FFFFFFFFFFFFFFF9,0000000007,FFFFFFFFFFFFFFF8,0000000004,FFFFFFFFFFFFFFFB,0000000003,FFFFFFFFFFFFFFF9,FFFFFFFFFFFFFFFA===" }
  long8 var1 = (long8) (3,-1,-6,-4,-8,8,123445,3);
  long8 var2 = (long8) (-7,7,-8,4,-5,3,-7,-6);
  int i = printf("long8_x_5136c===%010v8lX===%010v8lX===\n",var1,var2);
  return i;
}

int long8_x_575c() {
  // { dg-printf "long8_x_575c===3,fffffffffffffffc,fffffffffffffffe,5,ffffffffffffffff,5,ffffffffffffffff,3===fffffffffffffffa,8,fffffffffffffffa,fffffffffffffffe,fffffffffffffffa,1e235,6,4===" }
  long8 var1 = (long8) (3,-4,-2,5,-1,5,-1,3);
  long8 var2 = (long8) (-6,8,-6,-2,-6,123445,6,4);
  int i = printf("long8_x_575c===%v8lx===%v8lx===\n",var1,var2);
  return i;
}

int long8_x_576c() {
  // { dg-printf "long8_x_576c===2,0,1E235,4,7,FFFFFFFFFFFFFFFB,FFFFFFFFFFFFFFFC,FFFFFFFFFFFFFFFE===3,3,7,FFFFFFFFFFFE1DC1,8,4,1,0===" }
  long8 var1 = (long8) (2,0,123445,4,7,-5,-4,-2);
  long8 var2 = (long8) (3,3,7,-123455,8,4,1,0);
  int i = printf("long8_x_576c===%v8lX===%v8lX===\n",var1,var2);
  return i;
}

int long8_x_5895c() {
  // { dg-printf "long8_x_5895c===8         ,ffffffffffffffff,fffffffffffffffd,7         ,5         ,2         ,6         ,fffffffffffffffc===fffffffffffffffb,2         ,5         ,8         ,fffffffffffffffb,1e235     ,fffffffffffffffa,fffffffffffffffd===" }
  long8 var1 = (long8) (8,-1,-3,7,5,2,6,-4);
  long8 var2 = (long8) (-5,2,5,8,-5,123445,-6,-3);
  int i = printf("long8_x_5895c===%- 10v8lx===%- 10v8lx===\n",var1,var2);
  return i;
}

int long8_x_5896c() {
  // { dg-printf "long8_x_5896c===8         ,0         ,0         ,7         ,1E235     ,FFFFFFFFFFFFFFFA,3         ,6         ===FFFFFFFFFFFE1DC1,2         ,FFFFFFFFFFFFFFF9,1E235     ,5         ,1         ,2         ,1         ===" }
  long8 var1 = (long8) (8,0,0,7,123445,-6,3,6);
  long8 var2 = (long8) (-123455,2,-7,123445,5,1,2,1);
  int i = printf("long8_x_5896c===%- 10v8lX===%- 10v8lX===\n",var1,var2);
  return i;
}

int long8_x_6655c() {
  // { dg-printf "long8_x_6655c===fffffffffffffffe,         8,fffffffffffffffb,         0,         5,ffffffffffffffff,fffffffffffffffe,     1e235===     1e235,fffffffffffffffb,         2,fffffffffffffff9,fffffffffffe1dc1,         8,fffffffffffffffc,ffffffffffffffff===" }
  long8 var1 = (long8) (-2,8,-5,0,5,-1,-2,123445);
  long8 var2 = (long8) (123445,-5,2,-7,-123455,8,-4,-1);
  int i = printf("long8_x_6655c===%+ 10v8lx===%+ 10v8lx===\n",var1,var2);
  return i;
}

int long8_x_6656c() {
  // { dg-printf "long8_x_6656c===FFFFFFFFFFFFFFF9,     1E235,FFFFFFFFFFFFFFFA,FFFFFFFFFFFFFFFA,         2,FFFFFFFFFFFFFFFD,         1,FFFFFFFFFFFFFFFB===         1,FFFFFFFFFFFFFFFA,     1E235,         1,FFFFFFFFFFFE1DC1,FFFFFFFFFFFFFFFA,FFFFFFFFFFFFFFF9,FFFFFFFFFFFFFFFF===" }
  long8 var1 = (long8) (-7,123445,-6,-6,2,-3,1,-5);
  long8 var2 = (long8) (1,-6,123445,1,-123455,-6,-7,-1);
  int i = printf("long8_x_6656c===%+ 10v8lX===%+ 10v8lX===\n",var1,var2);
  return i;
}

int long8_x_7415c() {
  // { dg-printf "long8_x_7415c===0000000006,0000000008,0000000006,0000000005,0000000002,fffffffffffffffa,0000000000,0000000001===fffffffffffffffd,fffffffffffffffc,0000000008,fffffffffffffffe,ffffffffffffffff,fffffffffffe1dc1,0000000006,fffffffffffffffd===" }
  long8 var1 = (long8) (6,8,6,5,2,-6,0,1);
  long8 var2 = (long8) (-3,-4,8,-2,-1,-123455,6,-3);
  int i = printf("long8_x_7415c===%+010v8lx===%+010v8lx===\n",var1,var2);
  return i;
}

int long8_x_7416c() {
  // { dg-printf "long8_x_7416c===FFFFFFFFFFFFFFFE,0000000005,0000000005,0000000004,000001E235,0000000003,FFFFFFFFFFFFFFF8,0000000005===0000000003,FFFFFFFFFFFFFFFF,FFFFFFFFFFFFFFF8,FFFFFFFFFFFFFFF8,FFFFFFFFFFFFFFFD,0000000005,0000000008,FFFFFFFFFFFFFFFD===" }
  long8 var1 = (long8) (-2,5,5,4,123445,3,-8,5);
  long8 var2 = (long8) (3,-1,-8,-8,-3,5,8,-3);
  int i = printf("long8_x_7416c===%+010v8lX===%+010v8lX===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = long8_d_1331c();
i = long8_d_2091c();
i = long8_d_2851c();
i = long8_d_3611c();
i = long8_d_4371c();
i = long8_d_5131c();
i = long8_d_571c();
i = long8_d_5891c();
i = long8_d_6651c();
i = long8_d_7411c();
i = long8_i_1332c();
i = long8_i_2092c();
i = long8_i_2852c();
i = long8_i_3612c();
i = long8_i_4372c();
i = long8_i_5132c();
i = long8_i_572c();
i = long8_i_5892c();
i = long8_i_6652c();
i = long8_i_7412c();
i = long8_o_1333c();
i = long8_o_2093c();
i = long8_o_2853c();
i = long8_o_3613c();
i = long8_o_4373c();
i = long8_o_5133c();
i = long8_o_573c();
i = long8_o_5893c();
i = long8_o_6653c();
i = long8_o_7413c();
i = long8_u_1334c();
i = long8_u_2094c();
i = long8_u_2854c();
i = long8_u_3614c();
i = long8_u_4374c();
i = long8_u_5134c();
i = long8_u_574c();
i = long8_u_5894c();
i = long8_u_6654c();
i = long8_u_7414c();
i = long8_x_1335c();
i = long8_x_1336c();
i = long8_x_2095c();
i = long8_x_2096c();
i = long8_x_2855c();
i = long8_x_2856c();
i = long8_x_3615c();
i = long8_x_3616c();
i = long8_x_4375c();
i = long8_x_4376c();
i = long8_x_5135c();
i = long8_x_5136c();
i = long8_x_575c();
i = long8_x_576c();
i = long8_x_5895c();
i = long8_x_5896c();
i = long8_x_6655c();
i = long8_x_6656c();
i = long8_x_7415c();
i = long8_x_7416c();
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
