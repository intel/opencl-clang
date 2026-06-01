/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/int8.c'  */

int int8_d_1285c() {
  // { dg-printf "int8_d_1285c===6,7,-1,-4,-123455,-3,-123455,-8===-5,-7,4,-8,3,3,8,5===" }
  int8 var1 = (int8) (6,7,-1,-4,-123455,-3,-123455,-8);
  int8 var2 = (int8) (-5,-7,4,-8,3,3,8,5);
  int i = printf("int8_d_1285c===%-v8hld===%-v8hld===\n",var1,var2);
  return i;
}

int int8_d_2045c() {
  // { dg-printf "int8_d_2045c===-6,+123445,+6,-8,+5,+4,-123455,+123445===+4,-4,+5,-3,-5,-1,-8,+6===" }
  int8 var1 = (int8) (-6,123445,6,-8,5,4,-123455,123445);
  int8 var2 = (int8) (4,-4,5,-3,-5,-1,-8,6);
  int i = printf("int8_d_2045c===%+v8hld===%+v8hld===\n",var1,var2);
  return i;
}

int int8_d_2805c() {
  // { dg-printf "int8_d_2805c===1,-8,-7,-6,-4,7,8,-4===6,-123455,-1,-3,-4,-3,-123455,0===" }
  int8 var1 = (int8) (1,-8,-7,-6,-4,7,8,-4);
  int8 var2 = (int8) (6,-123455,-1,-3,-4,-3,-123455,0);
  int i = printf("int8_d_2805c===%#v8hld===%#v8hld===\n",var1,var2);
  return i;
}

int int8_d_3565c() {
  // { dg-printf "int8_d_3565c===-5,-2,-1,+7,+2,+4,-5,-7===+4,+1,-4,-123455,-2,-4,+2,+5===" }
  int8 var1 = (int8) (-5,-2,-1,7,2,4,-5,-7);
  int8 var2 = (int8) (4,1,-4,-123455,-2,-4,2,5);
  int i = printf("int8_d_3565c===%-+v8hld===%-+v8hld===\n",var1,var2);
  return i;
}

int int8_d_4325c() {
  // { dg-printf "int8_d_4325c===         5,        -8,        -5,         1,         6,         2,         3,         7===   -123455,         7,        -5,        -4,    123445,         3,         0,   -123455===" }
  int8 var1 = (int8) (5,-8,-5,1,6,2,3,7);
  int8 var2 = (int8) (-123455,7,-5,-4,123445,3,0,-123455);
  int i = printf("int8_d_4325c===% 10v8hld===% 10v8hld===\n",var1,var2);
  return i;
}

int int8_d_5085c() {
  // { dg-printf "int8_d_5085c===-000000002,0000000008,0000000000,-000000001,0000000005,0000000007,0000000000,-000000006===-000000007,0000000007,-000000008,-000000008,-000000003,0000000001,0000000002,-000000006===" }
  int8 var1 = (int8) (-2,8,0,-1,5,7,0,-6);
  int8 var2 = (int8) (-7,7,-8,-8,-3,1,2,-6);
  int i = printf("int8_d_5085c===%010v8hld===%010v8hld===\n",var1,var2);
  return i;
}

int int8_d_525c() {
  // { dg-printf "int8_d_525c===8,5,-123455,-8,-8,-3,0,1===4,4,1,123445,-6,-5,1,5===" }
  int8 var1 = (int8) (8,5,-123455,-8,-8,-3,0,1);
  int8 var2 = (int8) (4,4,1,123445,-6,-5,1,5);
  int i = printf("int8_d_525c===%v8hld===%v8hld===\n",var1,var2);
  return i;
}

int int8_d_5845c() {
  // { dg-printf "int8_d_5845c===-6        , 6        ,-8        , 2        ,-8        , 8        ,-5        , 7        === 3        ,-7        ,-3        ,-7        ,-1        , 6        ,-123455   ,-3        ===" }
  int8 var1 = (int8) (-6,6,-8,2,-8,8,-5,7);
  int8 var2 = (int8) (3,-7,-3,-7,-1,6,-123455,-3);
  int i = printf("int8_d_5845c===%- 10v8hld===%- 10v8hld===\n",var1,var2);
  return i;
}

int int8_d_6605c() {
  // { dg-printf "int8_d_6605c===        -7,        +3,        -5,        -5,        -6,        +1,        -5,   -123455===        +8,        -4,        -8,        +3,        +8,        +3,   +123445,        +4===" }
  int8 var1 = (int8) (-7,3,-5,-5,-6,1,-5,-123455);
  int8 var2 = (int8) (8,-4,-8,3,8,3,123445,4);
  int i = printf("int8_d_6605c===%+ 10v8hld===%+ 10v8hld===\n",var1,var2);
  return i;
}

int int8_d_7365c() {
  // { dg-printf "int8_d_7365c===+000000008,-000123455,-000000002,+000000007,-000000002,-000123455,-000000004,+000000007===-000123455,-000123455,+000000003,+000000001,-000000003,-000000003,-000000006,-000000003===" }
  int8 var1 = (int8) (8,-123455,-2,7,-2,-123455,-4,7);
  int8 var2 = (int8) (-123455,-123455,3,1,-3,-3,-6,-3);
  int i = printf("int8_d_7365c===%+010v8hld===%+010v8hld===\n",var1,var2);
  return i;
}

int int8_i_1286c() {
  // { dg-printf "int8_i_1286c===1,-4,1,5,-8,-5,2,-8===6,3,-5,-5,3,6,3,4===" }
  int8 var1 = (int8) (1,-4,1,5,-8,-5,2,-8);
  int8 var2 = (int8) (6,3,-5,-5,3,6,3,4);
  int i = printf("int8_i_1286c===%-v8hli===%-v8hli===\n",var1,var2);
  return i;
}

int int8_i_2046c() {
  // { dg-printf "int8_i_2046c===+123445,+5,-8,-1,+4,-2,-8,-5===-4,+2,+1,+123445,+2,+8,-4,-3===" }
  int8 var1 = (int8) (123445,5,-8,-1,4,-2,-8,-5);
  int8 var2 = (int8) (-4,2,1,123445,2,8,-4,-3);
  int i = printf("int8_i_2046c===%+v8hli===%+v8hli===\n",var1,var2);
  return i;
}

int int8_i_2806c() {
  // { dg-printf "int8_i_2806c===8,-3,-7,-8,-3,7,-3,3===1,4,5,-6,-2,2,-8,-123455===" }
  int8 var1 = (int8) (8,-3,-7,-8,-3,7,-3,3);
  int8 var2 = (int8) (1,4,5,-6,-2,2,-8,-123455);
  int i = printf("int8_i_2806c===%#v8hli===%#v8hli===\n",var1,var2);
  return i;
}

int int8_i_3566c() {
  // { dg-printf "int8_i_3566c===+6,+7,+5,+2,+1,+1,+5,+5===+4,+2,+3,+5,-3,+2,+5,-123455===" }
  int8 var1 = (int8) (6,7,5,2,1,1,5,5);
  int8 var2 = (int8) (4,2,3,5,-3,2,5,-123455);
  int i = printf("int8_i_3566c===%-+v8hli===%-+v8hli===\n",var1,var2);
  return i;
}

int int8_i_4326c() {
  // { dg-printf "int8_i_4326c===         2,   -123455,         6,         0,        -8,         4,        -4,         0===        -8,        -8,        -4,         2,        -4,        -3,        -4,         7===" }
  int8 var1 = (int8) (2,-123455,6,0,-8,4,-4,0);
  int8 var2 = (int8) (-8,-8,-4,2,-4,-3,-4,7);
  int i = printf("int8_i_4326c===% 10v8hli===% 10v8hli===\n",var1,var2);
  return i;
}

int int8_i_5086c() {
  // { dg-printf "int8_i_5086c===-000000003,0000000002,0000000005,0000000005,-000000004,0000000007,-000123455,-000000003===-000000004,0000000000,-000123455,0000000008,0000000002,-000000001,-000123455,-000000008===" }
  int8 var1 = (int8) (-3,2,5,5,-4,7,-123455,-3);
  int8 var2 = (int8) (-4,0,-123455,8,2,-1,-123455,-8);
  int i = printf("int8_i_5086c===%010v8hli===%010v8hli===\n",var1,var2);
  return i;
}

int int8_i_526c() {
  // { dg-printf "int8_i_526c===123445,-123455,4,-6,0,-7,7,-8===4,-123455,5,-7,-2,7,5,3===" }
  int8 var1 = (int8) (123445,-123455,4,-6,0,-7,7,-8);
  int8 var2 = (int8) (4,-123455,5,-7,-2,7,5,3);
  int i = printf("int8_i_526c===%v8hli===%v8hli===\n",var1,var2);
  return i;
}

int int8_i_5846c() {
  // { dg-printf "int8_i_5846c===-4        , 123445   , 5        ,-6        ,-1        , 2        , 1        ,-123455   === 2        , 7        , 1        , 7        , 5        , 6        , 7        ,-6        ===" }
  int8 var1 = (int8) (-4,123445,5,-6,-1,2,1,-123455);
  int8 var2 = (int8) (2,7,1,7,5,6,7,-6);
  int i = printf("int8_i_5846c===%- 10v8hli===%- 10v8hli===\n",var1,var2);
  return i;
}

int int8_i_6606c() {
  // { dg-printf "int8_i_6606c===        +1,        +5,        +7,        -3,        +6,        -1,        -6,        +8===        -3,        -8,        +3,        -8,        +4,   -123455,        +2,        +3===" }
  int8 var1 = (int8) (1,5,7,-3,6,-1,-6,8);
  int8 var2 = (int8) (-3,-8,3,-8,4,-123455,2,3);
  int i = printf("int8_i_6606c===%+ 10v8hli===%+ 10v8hli===\n",var1,var2);
  return i;
}

int int8_i_7366c() {
  // { dg-printf "int8_i_7366c===+000000004,+000000008,+000000002,-000000001,-000000007,-000000004,+000000008,+000000008===+000000007,+000000005,-000123455,+000000000,-000000001,-000000004,+000000004,-000000006===" }
  int8 var1 = (int8) (4,8,2,-1,-7,-4,8,8);
  int8 var2 = (int8) (7,5,-123455,0,-1,-4,4,-6);
  int i = printf("int8_i_7366c===%+010v8hli===%+010v8hli===\n",var1,var2);
  return i;
}

int int8_o_1287c() {
  // { dg-printf "int8_o_1287c===37777777772,7,37777777771,10,37777777772,37777777776,4,37777777776===37777777772,0,4,37777777773,37777777776,5,37777777777,37777777775===" }
  int8 var1 = (int8) (-6,7,-7,8,-6,-2,4,-2);
  int8 var2 = (int8) (-6,0,4,-5,-2,5,-1,-3);
  int i = printf("int8_o_1287c===%-v8hlo===%-v8hlo===\n",var1,var2);
  return i;
}

int int8_o_2047c() {
  // { dg-printf "int8_o_2047c===10,37777777770,361065,10,3,37777777774,37777777770,37777777773===37777777775,37777777775,37777777777,37777777772,6,3,7,3===" }
  int8 var1 = (int8) (8,-8,123445,8,3,-4,-8,-5);
  int8 var2 = (int8) (-3,-3,-1,-6,6,3,7,3);
  int i = printf("int8_o_2047c===%+v8hlo===%+v8hlo===\n",var1,var2);
  return i;
}

int int8_o_2807c() {
  // { dg-printf "int8_o_2807c===02,03,037777777777,05,037777777775,037777777774,037777777771,04===037777777773,02,037777777771,04,04,037777777774,03,04===" }
  int8 var1 = (int8) (2,3,-1,5,-3,-4,-7,4);
  int8 var2 = (int8) (-5,2,-7,4,4,-4,3,4);
  int i = printf("int8_o_2807c===%#v8hlo===%#v8hlo===\n",var1,var2);
  return i;
}

int int8_o_3567c() {
  // { dg-printf "int8_o_3567c===7,361065,37777777774,361065,3,37777416701,7,37777777771===361065,10,37777777777,37777777774,37777416701,6,37777777775,1===" }
  int8 var1 = (int8) (7,123445,-4,123445,3,-123455,7,-7);
  int8 var2 = (int8) (123445,8,-1,-4,-123455,6,-3,1);
  int i = printf("int8_o_3567c===%-+v8hlo===%-+v8hlo===\n",var1,var2);
  return i;
}

int int8_o_4327c() {
  // { dg-printf "int8_o_4327c===         1,         1,37777777772,37777777770,         4,        10,         0,         6===        10,37777777773,         3,         6,37777777771,37777777775,37777777774,37777777776===" }
  int8 var1 = (int8) (1,1,-6,-8,4,8,0,6);
  int8 var2 = (int8) (8,-5,3,6,-7,-3,-4,-2);
  int i = printf("int8_o_4327c===% 10v8hlo===% 10v8hlo===\n",var1,var2);
  return i;
}

int int8_o_5087c() {
  // { dg-printf "int8_o_5087c===37777777770,0000000006,37777777772,37777777777,37777777776,0000000005,0000000003,37777777772===0000000005,0000000001,37777777771,0000000002,0000361065,37777777777,37777777775,0000000007===" }
  int8 var1 = (int8) (-8,6,-6,-1,-2,5,3,-6);
  int8 var2 = (int8) (5,1,-7,2,123445,-1,-3,7);
  int i = printf("int8_o_5087c===%010v8hlo===%010v8hlo===\n",var1,var2);
  return i;
}

int int8_o_527c() {
  // { dg-printf "int8_o_527c===2,2,7,37777777776,37777777774,37777777773,6,7===5,361065,37777777773,37777777777,5,2,2,10===" }
  int8 var1 = (int8) (2,2,7,-2,-4,-5,6,7);
  int8 var2 = (int8) (5,123445,-5,-1,5,2,2,8);
  int i = printf("int8_o_527c===%v8hlo===%v8hlo===\n",var1,var2);
  return i;
}

int int8_o_5847c() {
  // { dg-printf "int8_o_5847c===37777777771,37777777776,37777777777,2         ,361065    ,37777777772,37777777772,10        ===37777777771,37777416701,37777777776,3         ,37777777776,37777416701,37777416701,361065    ===" }
  int8 var1 = (int8) (-7,-2,-1,2,123445,-6,-6,8);
  int8 var2 = (int8) (-7,-123455,-2,3,-2,-123455,-123455,123445);
  int i = printf("int8_o_5847c===%- 10v8hlo===%- 10v8hlo===\n",var1,var2);
  return i;
}

int int8_o_6607c() {
  // { dg-printf "int8_o_6607c===         6,37777416701,37777777773,         5,37777777770,        10,37777777774,37777777775===         7,37777777771,37777777776,         1,37777777776,37777777775,    361065,37777777771===" }
  int8 var1 = (int8) (6,-123455,-5,5,-8,8,-4,-3);
  int8 var2 = (int8) (7,-7,-2,1,-2,-3,123445,-7);
  int i = printf("int8_o_6607c===%+ 10v8hlo===%+ 10v8hlo===\n",var1,var2);
  return i;
}

int int8_o_7367c() {
  // { dg-printf "int8_o_7367c===37777777775,37777777771,37777777774,0000000001,0000000005,37777777775,37777777775,0000000002===0000000002,37777777771,0000000007,0000000007,0000000004,0000000002,0000000004,0000000003===" }
  int8 var1 = (int8) (-3,-7,-4,1,5,-3,-3,2);
  int8 var2 = (int8) (2,-7,7,7,4,2,4,3);
  int i = printf("int8_o_7367c===%+010v8hlo===%+010v8hlo===\n",var1,var2);
  return i;
}

int int8_u_1288c() {
  // { dg-printf "int8_u_1288c===4294967294,4294967295,4294967294,8,4294843841,4294967289,4294843841,4294967293===1,4294967289,4294967292,4294967292,4294967289,1,5,4294967293===" }
  int8 var1 = (int8) (-2,-1,-2,8,-123455,-7,-123455,-3);
  int8 var2 = (int8) (1,-7,-4,-4,-7,1,5,-3);
  int i = printf("int8_u_1288c===%-v8hlu===%-v8hlu===\n",var1,var2);
  return i;
}

int int8_u_2048c() {
  // { dg-printf "int8_u_2048c===4294843841,4294967288,3,4294967292,5,4,7,4294967289===1,0,123445,4294967295,3,4294967289,4294967295,4===" }
  int8 var1 = (int8) (-123455,-8,3,-4,5,4,7,-7);
  int8 var2 = (int8) (1,0,123445,-1,3,-7,-1,4);
  int i = printf("int8_u_2048c===%+v8hlu===%+v8hlu===\n",var1,var2);
  return i;
}

int int8_u_2808c() {
  // { dg-printf "int8_u_2808c===4294967291,4294967289,123445,4294967293,7,123445,4294967294,4294967288===123445,4,4,123445,3,0,7,4294843841===" }
  int8 var1 = (int8) (-5,-7,123445,-3,7,123445,-2,-8);
  int8 var2 = (int8) (123445,4,4,123445,3,0,7,-123455);
  int i = printf("int8_u_2808c===%#v8hlu===%#v8hlu===\n",var1,var2);
  return i;
}

int int8_u_3568c() {
  // { dg-printf "int8_u_3568c===4294843841,4294967292,7,123445,4294967289,2,4294967292,123445===6,2,0,6,7,7,5,4294967290===" }
  int8 var1 = (int8) (-123455,-4,7,123445,-7,2,-4,123445);
  int8 var2 = (int8) (6,2,0,6,7,7,5,-6);
  int i = printf("int8_u_3568c===%-+v8hlu===%-+v8hlu===\n",var1,var2);
  return i;
}

int int8_u_4328c() {
  // { dg-printf "int8_u_4328c===         7,    123445,4294967290,         7,         1,         0,4294967290,         5===4294967290,4294967288,         5,4294967288,         7,4294967290,4294967295,4294967289===" }
  int8 var1 = (int8) (7,123445,-6,7,1,0,-6,5);
  int8 var2 = (int8) (-6,-8,5,-8,7,-6,-1,-7);
  int i = printf("int8_u_4328c===% 10v8hlu===% 10v8hlu===\n",var1,var2);
  return i;
}

int int8_u_5088c() {
  // { dg-printf "int8_u_5088c===0000000000,4294967295,0000000006,0000000008,4294967291,0000000008,0000000003,4294967294===0000000004,0000000008,4294967293,0000000003,4294967288,4294967293,4294967291,4294967288===" }
  int8 var1 = (int8) (0,-1,6,8,-5,8,3,-2);
  int8 var2 = (int8) (4,8,-3,3,-8,-3,-5,-8);
  int i = printf("int8_u_5088c===%010v8hlu===%010v8hlu===\n",var1,var2);
  return i;
}

int int8_u_528c() {
  // { dg-printf "int8_u_528c===1,4294967288,4294967289,4294967295,3,7,2,1===4294967293,8,4294967295,2,4294967291,4294967294,2,123445===" }
  int8 var1 = (int8) (1,-8,-7,-1,3,7,2,1);
  int8 var2 = (int8) (-3,8,-1,2,-5,-2,2,123445);
  int i = printf("int8_u_528c===%v8hlu===%v8hlu===\n",var1,var2);
  return i;
}

int int8_u_5848c() {
  // { dg-printf "int8_u_5848c===4294967294,1         ,3         ,5         ,4294967293,4294967292,5         ,4294967289===3         ,7         ,2         ,3         ,4294967294,4294967288,4294967288,4294967288===" }
  int8 var1 = (int8) (-2,1,3,5,-3,-4,5,-7);
  int8 var2 = (int8) (3,7,2,3,-2,-8,-8,-8);
  int i = printf("int8_u_5848c===%- 10v8hlu===%- 10v8hlu===\n",var1,var2);
  return i;
}

int int8_u_6608c() {
  // { dg-printf "int8_u_6608c===         1,         5,4294967290,         7,         6,         7,         7,4294843841===         3,         8,4294967290,         4,4294967289,         4,         2,4294967294===" }
  int8 var1 = (int8) (1,5,-6,7,6,7,7,-123455);
  int8 var2 = (int8) (3,8,-6,4,-7,4,2,-2);
  int i = printf("int8_u_6608c===%+ 10v8hlu===%+ 10v8hlu===\n",var1,var2);
  return i;
}

int int8_u_7368c() {
  // { dg-printf "int8_u_7368c===0000000002,0000000001,4294967288,4294967288,0000000002,0000000002,4294967292,4294967289===4294967292,4294967288,0000123445,0000000007,0000000004,4294967289,0000000008,4294967289===" }
  int8 var1 = (int8) (2,1,-8,-8,2,2,-4,-7);
  int8 var2 = (int8) (-4,-8,123445,7,4,-7,8,-7);
  int i = printf("int8_u_7368c===%+010v8hlu===%+010v8hlu===\n",var1,var2);
  return i;
}

int int8_x_1289c() {
  // { dg-printf "int8_x_1289c===7,fffe1dc1,8,2,4,2,5,4===8,1,2,fffffff9,fffffffa,fffffffe,1,4===" }
  int8 var1 = (int8) (7,-123455,8,2,4,2,5,4);
  int8 var2 = (int8) (8,1,2,-7,-6,-2,1,4);
  int i = printf("int8_x_1289c===%-v8hlx===%-v8hlx===\n",var1,var2);
  return i;
}

int int8_x_1290c() {
  // { dg-printf "int8_x_1290c===6,8,0,3,1,5,6,FFFFFFF9===FFFFFFFA,FFFFFFF8,FFFFFFFC,1,1E235,1E235,FFFFFFF8,FFFE1DC1===" }
  int8 var1 = (int8) (6,8,0,3,1,5,6,-7);
  int8 var2 = (int8) (-6,-8,-4,1,123445,123445,-8,-123455);
  int i = printf("int8_x_1290c===%-v8hlX===%-v8hlX===\n",var1,var2);
  return i;
}

int int8_x_2049c() {
  // { dg-printf "int8_x_2049c===3,fffffffd,7,3,6,fffffffb,fffffffa,fffffffa===fffffff9,0,1,fffffffa,2,fffe1dc1,1,fffe1dc1===" }
  int8 var1 = (int8) (3,-3,7,3,6,-5,-6,-6);
  int8 var2 = (int8) (-7,0,1,-6,2,-123455,1,-123455);
  int i = printf("int8_x_2049c===%+v8hlx===%+v8hlx===\n",var1,var2);
  return i;
}

int int8_x_2050c() {
  // { dg-printf "int8_x_2050c===8,FFFFFFFB,FFFE1DC1,0,8,FFFFFFFF,FFFFFFF8,FFFFFFF8===0,FFFFFFFA,6,1,FFFFFFFE,1E235,FFFFFFFD,FFFFFFFC===" }
  int8 var1 = (int8) (8,-5,-123455,0,8,-1,-8,-8);
  int8 var2 = (int8) (0,-6,6,1,-2,123445,-3,-4);
  int i = printf("int8_x_2050c===%+v8hlX===%+v8hlX===\n",var1,var2);
  return i;
}

int int8_x_2809c() {
  // { dg-printf "int8_x_2809c===0x3,0xfffffff9,0xfffffffa,0x1,0xffffffff,0x2,0x6,0xfffe1dc1===0x2,0xfffffffa,0xfffffffe,0x1,0xfffffffa,0,0xfffffffb,0x3===" }
  int8 var1 = (int8) (3,-7,-6,1,-1,2,6,-123455);
  int8 var2 = (int8) (2,-6,-2,1,-6,0,-5,3);
  int i = printf("int8_x_2809c===%#v8hlx===%#v8hlx===\n",var1,var2);
  return i;
}

int int8_x_2810c() {
  // { dg-printf "int8_x_2810c===0XFFFFFFF8,0X3,0X4,0XFFFFFFFD,0XFFFFFFF8,0XFFFFFFFB,0X2,0X7===0XFFFFFFFB,0X2,0XFFFFFFF9,0X5,0X3,0X7,0XFFFFFFFD,0X3===" }
  int8 var1 = (int8) (-8,3,4,-3,-8,-5,2,7);
  int8 var2 = (int8) (-5,2,-7,5,3,7,-3,3);
  int i = printf("int8_x_2810c===%#v8hlX===%#v8hlX===\n",var1,var2);
  return i;
}

int int8_x_3569c() {
  // { dg-printf "int8_x_3569c===6,4,fffe1dc1,5,fffe1dc1,fffffffb,2,5===fffffffd,fffffffb,fffffff9,0,fffffffc,4,7,fffe1dc1===" }
  int8 var1 = (int8) (6,4,-123455,5,-123455,-5,2,5);
  int8 var2 = (int8) (-3,-5,-7,0,-4,4,7,-123455);
  int i = printf("int8_x_3569c===%-+v8hlx===%-+v8hlx===\n",var1,var2);
  return i;
}

int int8_x_3570c() {
  // { dg-printf "int8_x_3570c===FFFFFFF9,FFFFFFFA,FFFFFFF9,FFFFFFFA,FFFFFFFE,5,FFFFFFFE,FFFFFFF9===5,FFFE1DC1,FFFFFFFB,FFFFFFF9,4,8,2,FFFFFFFC===" }
  int8 var1 = (int8) (-7,-6,-7,-6,-2,5,-2,-7);
  int8 var2 = (int8) (5,-123455,-5,-7,4,8,2,-4);
  int i = printf("int8_x_3570c===%-+v8hlX===%-+v8hlX===\n",var1,var2);
  return i;
}

int int8_x_4329c() {
  // { dg-printf "int8_x_4329c===         7,         3,         7,         7,  fffffffd,  fffffff8,  fffffffd,     1e235===         1,         2,         1,  fffffffe,         6,  fffe1dc1,         3,         7===" }
  int8 var1 = (int8) (7,3,7,7,-3,-8,-3,123445);
  int8 var2 = (int8) (1,2,1,-2,6,-123455,3,7);
  int i = printf("int8_x_4329c===% 10v8hlx===% 10v8hlx===\n",var1,var2);
  return i;
}

int int8_x_4330c() {
  // { dg-printf "int8_x_4330c===         2,         3,  FFFFFFF9,  FFFFFFF8,         4,  FFFFFFFF,  FFFFFFFD,         2===  FFFFFFF8,         4,  FFFFFFFC,         8,  FFFFFFFD,  FFFFFFF9,         7,  FFFFFFFC===" }
  int8 var1 = (int8) (2,3,-7,-8,4,-1,-3,2);
  int8 var2 = (int8) (-8,4,-4,8,-3,-7,7,-4);
  int i = printf("int8_x_4330c===% 10v8hlX===% 10v8hlX===\n",var1,var2);
  return i;
}

int int8_x_5089c() {
  // { dg-printf "int8_x_5089c===0000000007,00fffffffc,00fffe1dc1,00fffffffd,00fffffffb,00fffffffd,0000000004,0000000008===00fffffffb,0000000005,0000000008,00fffffffd,0000000001,0000000007,0000000007,00fffffffe===" }
  int8 var1 = (int8) (7,-4,-123455,-3,-5,-3,4,8);
  int8 var2 = (int8) (-5,5,8,-3,1,7,7,-2);
  int i = printf("int8_x_5089c===%010v8hlx===%010v8hlx===\n",var1,var2);
  return i;
}

int int8_x_5090c() {
  // { dg-printf "int8_x_5090c===0000000008,00FFFFFFFF,00FFFFFFF8,00FFFFFFFB,00FFFFFFFA,000001E235,000001E235,00FFFFFFFA===00FFFFFFFF,00FFFFFFF9,0000000008,00FFFFFFFA,0000000004,0000000000,00FFFFFFFB,00FFFFFFFA===" }
  int8 var1 = (int8) (8,-1,-8,-5,-6,123445,123445,-6);
  int8 var2 = (int8) (-1,-7,8,-6,4,0,-5,-6);
  int i = printf("int8_x_5090c===%010v8hlX===%010v8hlX===\n",var1,var2);
  return i;
}

int int8_x_529c() {
  // { dg-printf "int8_x_529c===ffffffff,2,fffe1dc1,3,6,fffffff9,6,6===1e235,2,fffffffc,2,fffe1dc1,8,2,5===" }
  int8 var1 = (int8) (-1,2,-123455,3,6,-7,6,6);
  int8 var2 = (int8) (123445,2,-4,2,-123455,8,2,5);
  int i = printf("int8_x_529c===%v8hlx===%v8hlx===\n",var1,var2);
  return i;
}

int int8_x_530c() {
  // { dg-printf "int8_x_530c===5,FFFFFFFC,8,FFFFFFFA,1E235,2,FFFFFFF9,1===FFFFFFFE,7,FFFFFFFC,FFFFFFF9,8,4,0,5===" }
  int8 var1 = (int8) (5,-4,8,-6,123445,2,-7,1);
  int8 var2 = (int8) (-2,7,-4,-7,8,4,0,5);
  int i = printf("int8_x_530c===%v8hlX===%v8hlX===\n",var1,var2);
  return i;
}

int int8_x_5849c() {
  // { dg-printf "int8_x_5849c===1         ,ffffffff  ,2         ,8         ,1e235     ,fffffff8  ,fffffff8  ,fffffffe  ===2         ,1         ,fffffff8  ,5         ,2         ,fffffffb  ,fffffff9  ,1e235     ===" }
  int8 var1 = (int8) (1,-1,2,8,123445,-8,-8,-2);
  int8 var2 = (int8) (2,1,-8,5,2,-5,-7,123445);
  int i = printf("int8_x_5849c===%- 10v8hlx===%- 10v8hlx===\n",var1,var2);
  return i;
}

int int8_x_5850c() {
  // { dg-printf "int8_x_5850c===4         ,FFFFFFFB  ,6         ,FFFFFFF8  ,FFFE1DC1  ,FFFFFFFC  ,1E235     ,1E235     ===FFFFFFFC  ,FFFFFFFA  ,1E235     ,7         ,FFFFFFF9  ,FFFFFFFC  ,FFFFFFFF  ,7         ===" }
  int8 var1 = (int8) (4,-5,6,-8,-123455,-4,123445,123445);
  int8 var2 = (int8) (-4,-6,123445,7,-7,-4,-1,7);
  int i = printf("int8_x_5850c===%- 10v8hlX===%- 10v8hlX===\n",var1,var2);
  return i;
}

int int8_x_6609c() {
  // { dg-printf "int8_x_6609c===  fffffffe,         5,         4,         6,  fffffffd,  fffe1dc1,         6,  fffffffa===  fffffffa,         0,         8,         5,  fffffffa,  fffffff8,  fffe1dc1,         4===" }
  int8 var1 = (int8) (-2,5,4,6,-3,-123455,6,-6);
  int8 var2 = (int8) (-6,0,8,5,-6,-8,-123455,4);
  int i = printf("int8_x_6609c===%+ 10v8hlx===%+ 10v8hlx===\n",var1,var2);
  return i;
}

int int8_x_6610c() {
  // { dg-printf "int8_x_6610c===         5,         4,  FFFE1DC1,  FFFFFFFF,         7,  FFFE1DC1,  FFFFFFF9,  FFFFFFFA===  FFFFFFF9,         7,         4,  FFFFFFFD,         6,  FFFFFFFA,  FFFFFFFB,         1===" }
  int8 var1 = (int8) (5,4,-123455,-1,7,-123455,-7,-6);
  int8 var2 = (int8) (-7,7,4,-3,6,-6,-5,1);
  int i = printf("int8_x_6610c===%+ 10v8hlX===%+ 10v8hlX===\n",var1,var2);
  return i;
}

int int8_x_7369c() {
  // { dg-printf "int8_x_7369c===00fffffffa,0000000001,0000000005,00fffffffe,0000000007,0000000007,00fffffffe,0000000003===0000000001,00fffffffd,00fffffffd,0000000001,00fffffffe,00fffffffd,00fffffffa,0000000006===" }
  int8 var1 = (int8) (-6,1,5,-2,7,7,-2,3);
  int8 var2 = (int8) (1,-3,-3,1,-2,-3,-6,6);
  int i = printf("int8_x_7369c===%+010v8hlx===%+010v8hlx===\n",var1,var2);
  return i;
}

int int8_x_7370c() {
  // { dg-printf "int8_x_7370c===00FFFE1DC1,0000000005,00FFFFFFFB,00FFFFFFF8,00FFFFFFFE,00FFFFFFFE,00FFFFFFF9,00FFFFFFFD===00FFFFFFFA,0000000001,00FFFFFFFC,00FFFFFFFB,0000000000,00FFFFFFF8,00FFFFFFFB,0000000006===" }
  int8 var1 = (int8) (-123455,5,-5,-8,-2,-2,-7,-3);
  int8 var2 = (int8) (-6,1,-4,-5,0,-8,-5,6);
  int i = printf("int8_x_7370c===%+010v8hlX===%+010v8hlX===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = int8_d_1285c();
i = int8_d_2045c();
i = int8_d_2805c();
i = int8_d_3565c();
i = int8_d_4325c();
i = int8_d_5085c();
i = int8_d_525c();
i = int8_d_5845c();
i = int8_d_6605c();
i = int8_d_7365c();
i = int8_i_1286c();
i = int8_i_2046c();
i = int8_i_2806c();
i = int8_i_3566c();
i = int8_i_4326c();
i = int8_i_5086c();
i = int8_i_526c();
i = int8_i_5846c();
i = int8_i_6606c();
i = int8_i_7366c();
i = int8_o_1287c();
i = int8_o_2047c();
i = int8_o_2807c();
i = int8_o_3567c();
i = int8_o_4327c();
i = int8_o_5087c();
i = int8_o_527c();
i = int8_o_5847c();
i = int8_o_6607c();
i = int8_o_7367c();
i = int8_u_1288c();
i = int8_u_2048c();
i = int8_u_2808c();
i = int8_u_3568c();
i = int8_u_4328c();
i = int8_u_5088c();
i = int8_u_528c();
i = int8_u_5848c();
i = int8_u_6608c();
i = int8_u_7368c();
i = int8_x_1289c();
i = int8_x_1290c();
i = int8_x_2049c();
i = int8_x_2050c();
i = int8_x_2809c();
i = int8_x_2810c();
i = int8_x_3569c();
i = int8_x_3570c();
i = int8_x_4329c();
i = int8_x_4330c();
i = int8_x_5089c();
i = int8_x_5090c();
i = int8_x_529c();
i = int8_x_530c();
i = int8_x_5849c();
i = int8_x_5850c();
i = int8_x_6609c();
i = int8_x_6610c();
i = int8_x_7369c();
i = int8_x_7370c();
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
