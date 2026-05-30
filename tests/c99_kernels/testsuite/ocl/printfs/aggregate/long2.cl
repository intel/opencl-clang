/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/long2.c'  */

int long2_d_1043c() {
  // { dg-printf "long2_d_1043c===-123455,-2===-123455,-123455===" }
  long2 var1 = (long2) (-123455,-2);
  long2 var2 = (long2) (-123455,-123455);
  int i = printf("long2_d_1043c===%-v2ld===%-v2ld===\n",var1,var2);
  return i;
}

int long2_d_1803c() {
  // { dg-printf "long2_d_1803c===+1,-8===+6,-6===" }
  long2 var1 = (long2) (1,-8);
  long2 var2 = (long2) (6,-6);
  int i = printf("long2_d_1803c===%+v2ld===%+v2ld===\n",var1,var2);
  return i;
}

int long2_d_2563c() {
  // { dg-printf "long2_d_2563c===-7,2===2,-3===" }
  long2 var1 = (long2) (-7,2);
  long2 var2 = (long2) (2,-3);
  int i = printf("long2_d_2563c===%#v2ld===%#v2ld===\n",var1,var2);
  return i;
}

int long2_d_283c() {
  // { dg-printf "long2_d_283c===123445,0===2,123445===" }
  long2 var1 = (long2) (123445,0);
  long2 var2 = (long2) (2,123445);
  int i = printf("long2_d_283c===%v2ld===%v2ld===\n",var1,var2);
  return i;
}

int long2_d_3323c() {
  // { dg-printf "long2_d_3323c===+123445,-4===+123445,-123455===" }
  long2 var1 = (long2) (123445,-4);
  long2 var2 = (long2) (123445,-123455);
  int i = printf("long2_d_3323c===%-+v2ld===%-+v2ld===\n",var1,var2);
  return i;
}

int long2_d_4083c() {
  // { dg-printf "long2_d_4083c===        -6,         3===        -5,        -8===" }
  long2 var1 = (long2) (-6,3);
  long2 var2 = (long2) (-5,-8);
  int i = printf("long2_d_4083c===% 10v2ld===% 10v2ld===\n",var1,var2);
  return i;
}

int long2_d_4843c() {
  // { dg-printf "long2_d_4843c===0000123445,0000000006===0000000007,-000000005===" }
  long2 var1 = (long2) (123445,6);
  long2 var2 = (long2) (7,-5);
  int i = printf("long2_d_4843c===%010v2ld===%010v2ld===\n",var1,var2);
  return i;
}

int long2_d_5603c() {
  // { dg-printf "long2_d_5603c===-8        , 8        === 0        ,-7        ===" }
  long2 var1 = (long2) (-8,8);
  long2 var2 = (long2) (0,-7);
  int i = printf("long2_d_5603c===%- 10v2ld===%- 10v2ld===\n",var1,var2);
  return i;
}

int long2_d_6363c() {
  // { dg-printf "long2_d_6363c===        -3,        +1===        +2,   +123445===" }
  long2 var1 = (long2) (-3,1);
  long2 var2 = (long2) (2,123445);
  int i = printf("long2_d_6363c===%+ 10v2ld===%+ 10v2ld===\n",var1,var2);
  return i;
}

int long2_d_7123c() {
  // { dg-printf "long2_d_7123c===-000000006,+000000002===-000123455,+000000006===" }
  long2 var1 = (long2) (-6,2);
  long2 var2 = (long2) (-123455,6);
  int i = printf("long2_d_7123c===%+010v2ld===%+010v2ld===\n",var1,var2);
  return i;
}

int long2_i_1044c() {
  // { dg-printf "long2_i_1044c===-123455,-5===-5,8===" }
  long2 var1 = (long2) (-123455,-5);
  long2 var2 = (long2) (-5,8);
  int i = printf("long2_i_1044c===%-v2li===%-v2li===\n",var1,var2);
  return i;
}

int long2_i_1804c() {
  // { dg-printf "long2_i_1804c===+1,+7===+6,+1===" }
  long2 var1 = (long2) (1,7);
  long2 var2 = (long2) (6,1);
  int i = printf("long2_i_1804c===%+v2li===%+v2li===\n",var1,var2);
  return i;
}

int long2_i_2564c() {
  // { dg-printf "long2_i_2564c===5,-1===-5,123445===" }
  long2 var1 = (long2) (5,-1);
  long2 var2 = (long2) (-5,123445);
  int i = printf("long2_i_2564c===%#v2li===%#v2li===\n",var1,var2);
  return i;
}

int long2_i_284c() {
  // { dg-printf "long2_i_284c===8,8===-4,3===" }
  long2 var1 = (long2) (8,8);
  long2 var2 = (long2) (-4,3);
  int i = printf("long2_i_284c===%v2li===%v2li===\n",var1,var2);
  return i;
}

int long2_i_3324c() {
  // { dg-printf "long2_i_3324c===+6,+4===-8,-5===" }
  long2 var1 = (long2) (6,4);
  long2 var2 = (long2) (-8,-5);
  int i = printf("long2_i_3324c===%-+v2li===%-+v2li===\n",var1,var2);
  return i;
}

int long2_i_4084c() {
  // { dg-printf "long2_i_4084c===         6,         7===        -5,         2===" }
  long2 var1 = (long2) (6,7);
  long2 var2 = (long2) (-5,2);
  int i = printf("long2_i_4084c===% 10v2li===% 10v2li===\n",var1,var2);
  return i;
}

int long2_i_4844c() {
  // { dg-printf "long2_i_4844c===0000000005,0000000007===-000000005,0000000005===" }
  long2 var1 = (long2) (5,7);
  long2 var2 = (long2) (-5,5);
  int i = printf("long2_i_4844c===%010v2li===%010v2li===\n",var1,var2);
  return i;
}

int long2_i_5604c() {
  // { dg-printf "long2_i_5604c===-4        , 8        ===-6        , 3        ===" }
  long2 var1 = (long2) (-4,8);
  long2 var2 = (long2) (-6,3);
  int i = printf("long2_i_5604c===%- 10v2li===%- 10v2li===\n",var1,var2);
  return i;
}

int long2_i_6364c() {
  // { dg-printf "long2_i_6364c===        +1,        +2===        -7,        +4===" }
  long2 var1 = (long2) (1,2);
  long2 var2 = (long2) (-7,4);
  int i = printf("long2_i_6364c===%+ 10v2li===%+ 10v2li===\n",var1,var2);
  return i;
}

int long2_i_7124c() {
  // { dg-printf "long2_i_7124c===+000000005,+000000003===-000000005,+000000001===" }
  long2 var1 = (long2) (5,3);
  long2 var2 = (long2) (-5,1);
  int i = printf("long2_i_7124c===%+010v2li===%+010v2li===\n",var1,var2);
  return i;
}

int long2_o_1045c() {
  // { dg-printf "long2_o_1045c===10,1777777777777777777773===1777777777777777777776,1777777777777777777774===" }
  long2 var1 = (long2) (8,-5);
  long2 var2 = (long2) (-2,-4);
  int i = printf("long2_o_1045c===%-v2lo===%-v2lo===\n",var1,var2);
  return i;
}

int long2_o_1805c() {
  // { dg-printf "long2_o_1805c===4,1777777777777777777771===1777777777777777777774,5===" }
  long2 var1 = (long2) (4,-7);
  long2 var2 = (long2) (-4,5);
  int i = printf("long2_o_1805c===%+v2lo===%+v2lo===\n",var1,var2);
  return i;
}

int long2_o_2565c() {
  // { dg-printf "long2_o_2565c===0,0===03,01777777777777777777772===" }
  long2 var1 = (long2) (0,0);
  long2 var2 = (long2) (3,-6);
  int i = printf("long2_o_2565c===%#v2lo===%#v2lo===\n",var1,var2);
  return i;
}

int long2_o_285c() {
  // { dg-printf "long2_o_285c===1777777777777777777774,1777777777777777777770===1777777777777777416701,1777777777777777777777===" }
  long2 var1 = (long2) (-4,-8);
  long2 var2 = (long2) (-123455,-1);
  int i = printf("long2_o_285c===%v2lo===%v2lo===\n",var1,var2);
  return i;
}

int long2_o_3325c() {
  // { dg-printf "long2_o_3325c===1777777777777777777772,10===1777777777777777416701,1777777777777777777777===" }
  long2 var1 = (long2) (-6,8);
  long2 var2 = (long2) (-123455,-1);
  int i = printf("long2_o_3325c===%-+v2lo===%-+v2lo===\n",var1,var2);
  return i;
}

int long2_o_4085c() {
  // { dg-printf "long2_o_4085c===         7,1777777777777777777777===         1,1777777777777777416701===" }
  long2 var1 = (long2) (7,-1);
  long2 var2 = (long2) (1,-123455);
  int i = printf("long2_o_4085c===% 10v2lo===% 10v2lo===\n",var1,var2);
  return i;
}

int long2_o_4845c() {
  // { dg-printf "long2_o_4845c===0000361065,0000361065===1777777777777777777770,0000361065===" }
  long2 var1 = (long2) (123445,123445);
  long2 var2 = (long2) (-8,123445);
  int i = printf("long2_o_4845c===%010v2lo===%010v2lo===\n",var1,var2);
  return i;
}

int long2_o_5605c() {
  // { dg-printf "long2_o_5605c===10        ,7         ===10        ,1777777777777777416701===" }
  long2 var1 = (long2) (8,7);
  long2 var2 = (long2) (8,-123455);
  int i = printf("long2_o_5605c===%- 10v2lo===%- 10v2lo===\n",var1,var2);
  return i;
}

int long2_o_6365c() {
  // { dg-printf "long2_o_6365c===         5,         1===1777777777777777777774,         6===" }
  long2 var1 = (long2) (5,1);
  long2 var2 = (long2) (-4,6);
  int i = printf("long2_o_6365c===%+ 10v2lo===%+ 10v2lo===\n",var1,var2);
  return i;
}

int long2_o_7125c() {
  // { dg-printf "long2_o_7125c===1777777777777777777775,0000000005===0000361065,0000000003===" }
  long2 var1 = (long2) (-3,5);
  long2 var2 = (long2) (123445,3);
  int i = printf("long2_o_7125c===%+010v2lo===%+010v2lo===\n",var1,var2);
  return i;
}

int long2_u_1046c() {
  // { dg-printf "long2_u_1046c===18446744073709551609,5===0,18446744073709551608===" }
  long2 var1 = (long2) (-7,5);
  long2 var2 = (long2) (0,-8);
  int i = printf("long2_u_1046c===%-v2lu===%-v2lu===\n",var1,var2);
  return i;
}

int long2_u_1806c() {
  // { dg-printf "long2_u_1806c===18446744073709551609,4===18446744073709551610,3===" }
  long2 var1 = (long2) (-7,4);
  long2 var2 = (long2) (-6,3);
  int i = printf("long2_u_1806c===%+v2lu===%+v2lu===\n",var1,var2);
  return i;
}

int long2_u_2566c() {
  // { dg-printf "long2_u_2566c===3,18446744073709551610===18446744073709551613,123445===" }
  long2 var1 = (long2) (3,-6);
  long2 var2 = (long2) (-3,123445);
  int i = printf("long2_u_2566c===%#v2lu===%#v2lu===\n",var1,var2);
  return i;
}

int long2_u_286c() {
  // { dg-printf "long2_u_286c===18446744073709551612,7===18446744073709551609,18446744073709551611===" }
  long2 var1 = (long2) (-4,7);
  long2 var2 = (long2) (-7,-5);
  int i = printf("long2_u_286c===%v2lu===%v2lu===\n",var1,var2);
  return i;
}

int long2_u_3326c() {
  // { dg-printf "long2_u_3326c===18446744073709551609,18446744073709428161===2,18446744073709551608===" }
  long2 var1 = (long2) (-7,-123455);
  long2 var2 = (long2) (2,-8);
  int i = printf("long2_u_3326c===%-+v2lu===%-+v2lu===\n",var1,var2);
  return i;
}

int long2_u_4086c() {
  // { dg-printf "long2_u_4086c===18446744073709551610,18446744073709551613===         1,         4===" }
  long2 var1 = (long2) (-6,-3);
  long2 var2 = (long2) (1,4);
  int i = printf("long2_u_4086c===% 10v2lu===% 10v2lu===\n",var1,var2);
  return i;
}

int long2_u_4846c() {
  // { dg-printf "long2_u_4846c===0000000004,0000000004===0000000001,18446744073709551609===" }
  long2 var1 = (long2) (4,4);
  long2 var2 = (long2) (1,-7);
  int i = printf("long2_u_4846c===%010v2lu===%010v2lu===\n",var1,var2);
  return i;
}

int long2_u_5606c() {
  // { dg-printf "long2_u_5606c===18446744073709551615,7         ===5         ,1         ===" }
  long2 var1 = (long2) (-1,7);
  long2 var2 = (long2) (5,1);
  int i = printf("long2_u_5606c===%- 10v2lu===%- 10v2lu===\n",var1,var2);
  return i;
}

int long2_u_6366c() {
  // { dg-printf "long2_u_6366c===         2,18446744073709551613===         7,         3===" }
  long2 var1 = (long2) (2,-3);
  long2 var2 = (long2) (7,3);
  int i = printf("long2_u_6366c===%+ 10v2lu===%+ 10v2lu===\n",var1,var2);
  return i;
}

int long2_u_7126c() {
  // { dg-printf "long2_u_7126c===0000000002,18446744073709551613===0000000001,18446744073709551615===" }
  long2 var1 = (long2) (2,-3);
  long2 var2 = (long2) (1,-1);
  int i = printf("long2_u_7126c===%+010v2lu===%+010v2lu===\n",var1,var2);
  return i;
}

int long2_x_1047c() {
  // { dg-printf "long2_x_1047c===7,ffffffffffffffff===5,fffffffffffffffc===" }
  long2 var1 = (long2) (7,-1);
  long2 var2 = (long2) (5,-4);
  int i = printf("long2_x_1047c===%-v2lx===%-v2lx===\n",var1,var2);
  return i;
}

int long2_x_1048c() {
  // { dg-printf "long2_x_1048c===FFFFFFFFFFFFFFFF,FFFFFFFFFFFE1DC1===1,1===" }
  long2 var1 = (long2) (-1,-123455);
  long2 var2 = (long2) (1,1);
  int i = printf("long2_x_1048c===%-v2lX===%-v2lX===\n",var1,var2);
  return i;
}

int long2_x_1807c() {
  // { dg-printf "long2_x_1807c===fffffffffffffffd,5===6,8===" }
  long2 var1 = (long2) (-3,5);
  long2 var2 = (long2) (6,8);
  int i = printf("long2_x_1807c===%+v2lx===%+v2lx===\n",var1,var2);
  return i;
}

int long2_x_1808c() {
  // { dg-printf "long2_x_1808c===8,1E235===FFFFFFFFFFFFFFFE,1===" }
  long2 var1 = (long2) (8,123445);
  long2 var2 = (long2) (-2,1);
  int i = printf("long2_x_1808c===%+v2lX===%+v2lX===\n",var1,var2);
  return i;
}

int long2_x_2567c() {
  // { dg-printf "long2_x_2567c===0x2,0xfffffffffffffffc===0xfffffffffffffffc,0x8===" }
  long2 var1 = (long2) (2,-4);
  long2 var2 = (long2) (-4,8);
  int i = printf("long2_x_2567c===%#v2lx===%#v2lx===\n",var1,var2);
  return i;
}

int long2_x_2568c() {
  // { dg-printf "long2_x_2568c===0XFFFFFFFFFFFE1DC1,0XFFFFFFFFFFFFFFF8===0XFFFFFFFFFFFFFFF9,0X5===" }
  long2 var1 = (long2) (-123455,-8);
  long2 var2 = (long2) (-7,5);
  int i = printf("long2_x_2568c===%#v2lX===%#v2lX===\n",var1,var2);
  return i;
}

int long2_x_287c() {
  // { dg-printf "long2_x_287c===fffffffffffffffa,1e235===8,0===" }
  long2 var1 = (long2) (-6,123445);
  long2 var2 = (long2) (8,0);
  int i = printf("long2_x_287c===%v2lx===%v2lx===\n",var1,var2);
  return i;
}

int long2_x_288c() {
  // { dg-printf "long2_x_288c===4,8===3,4===" }
  long2 var1 = (long2) (4,8);
  long2 var2 = (long2) (3,4);
  int i = printf("long2_x_288c===%v2lX===%v2lX===\n",var1,var2);
  return i;
}

int long2_x_3327c() {
  // { dg-printf "long2_x_3327c===0,3===1e235,fffffffffffffffe===" }
  long2 var1 = (long2) (0,3);
  long2 var2 = (long2) (123445,-2);
  int i = printf("long2_x_3327c===%-+v2lx===%-+v2lx===\n",var1,var2);
  return i;
}

int long2_x_3328c() {
  // { dg-printf "long2_x_3328c===1E235,8===6,8===" }
  long2 var1 = (long2) (123445,8);
  long2 var2 = (long2) (6,8);
  int i = printf("long2_x_3328c===%-+v2lX===%-+v2lX===\n",var1,var2);
  return i;
}

int long2_x_4087c() {
  // { dg-printf "long2_x_4087c===         3,         4===fffffffffffffff8,fffffffffffffffb===" }
  long2 var1 = (long2) (3,4);
  long2 var2 = (long2) (-8,-5);
  int i = printf("long2_x_4087c===% 10v2lx===% 10v2lx===\n",var1,var2);
  return i;
}

int long2_x_4088c() {
  // { dg-printf "long2_x_4088c===         2,FFFFFFFFFFFFFFFE===         4,         6===" }
  long2 var1 = (long2) (2,-2);
  long2 var2 = (long2) (4,6);
  int i = printf("long2_x_4088c===% 10v2lX===% 10v2lX===\n",var1,var2);
  return i;
}

int long2_x_4847c() {
  // { dg-printf "long2_x_4847c===0000000005,0000000003===0000000000,fffffffffffffffd===" }
  long2 var1 = (long2) (5,3);
  long2 var2 = (long2) (0,-3);
  int i = printf("long2_x_4847c===%010v2lx===%010v2lx===\n",var1,var2);
  return i;
}

int long2_x_4848c() {
  // { dg-printf "long2_x_4848c===FFFFFFFFFFFFFFF8,FFFFFFFFFFFFFFFD===0000000008,FFFFFFFFFFFFFFFD===" }
  long2 var1 = (long2) (-8,-3);
  long2 var2 = (long2) (8,-3);
  int i = printf("long2_x_4848c===%010v2lX===%010v2lX===\n",var1,var2);
  return i;
}

int long2_x_5607c() {
  // { dg-printf "long2_x_5607c===fffffffffffffff9,7         ===7         ,fffffffffffffffe===" }
  long2 var1 = (long2) (-7,7);
  long2 var2 = (long2) (7,-2);
  int i = printf("long2_x_5607c===%- 10v2lx===%- 10v2lx===\n",var1,var2);
  return i;
}

int long2_x_5608c() {
  // { dg-printf "long2_x_5608c===2         ,FFFFFFFFFFFFFFFA===FFFFFFFFFFFFFFFE,FFFFFFFFFFFFFFFC===" }
  long2 var1 = (long2) (2,-6);
  long2 var2 = (long2) (-2,-4);
  int i = printf("long2_x_5608c===%- 10v2lX===%- 10v2lX===\n",var1,var2);
  return i;
}

int long2_x_6367c() {
  // { dg-printf "long2_x_6367c===fffffffffffffff8,fffffffffffffffa===fffffffffffe1dc1,         7===" }
  long2 var1 = (long2) (-8,-6);
  long2 var2 = (long2) (-123455,7);
  int i = printf("long2_x_6367c===%+ 10v2lx===%+ 10v2lx===\n",var1,var2);
  return i;
}

int long2_x_6368c() {
  // { dg-printf "long2_x_6368c===FFFFFFFFFFFFFFFE,FFFFFFFFFFFFFFFB===         6,FFFFFFFFFFFFFFFD===" }
  long2 var1 = (long2) (-2,-5);
  long2 var2 = (long2) (6,-3);
  int i = printf("long2_x_6368c===%+ 10v2lX===%+ 10v2lX===\n",var1,var2);
  return i;
}

int long2_x_7127c() {
  // { dg-printf "long2_x_7127c===fffffffffffe1dc1,0000000008===fffffffffffffff8,0000000003===" }
  long2 var1 = (long2) (-123455,8);
  long2 var2 = (long2) (-8,3);
  int i = printf("long2_x_7127c===%+010v2lx===%+010v2lx===\n",var1,var2);
  return i;
}

int long2_x_7128c() {
  // { dg-printf "long2_x_7128c===FFFFFFFFFFFFFFFD,FFFFFFFFFFFFFFFD===0000000008,FFFFFFFFFFFFFFF8===" }
  long2 var1 = (long2) (-3,-3);
  long2 var2 = (long2) (8,-8);
  int i = printf("long2_x_7128c===%+010v2lX===%+010v2lX===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = long2_d_1043c();
i = long2_d_1803c();
i = long2_d_2563c();
i = long2_d_283c();
i = long2_d_3323c();
i = long2_d_4083c();
i = long2_d_4843c();
i = long2_d_5603c();
i = long2_d_6363c();
i = long2_d_7123c();
i = long2_i_1044c();
i = long2_i_1804c();
i = long2_i_2564c();
i = long2_i_284c();
i = long2_i_3324c();
i = long2_i_4084c();
i = long2_i_4844c();
i = long2_i_5604c();
i = long2_i_6364c();
i = long2_i_7124c();
i = long2_o_1045c();
i = long2_o_1805c();
i = long2_o_2565c();
i = long2_o_285c();
i = long2_o_3325c();
i = long2_o_4085c();
i = long2_o_4845c();
i = long2_o_5605c();
i = long2_o_6365c();
i = long2_o_7125c();
i = long2_u_1046c();
i = long2_u_1806c();
i = long2_u_2566c();
i = long2_u_286c();
i = long2_u_3326c();
i = long2_u_4086c();
i = long2_u_4846c();
i = long2_u_5606c();
i = long2_u_6366c();
i = long2_u_7126c();
i = long2_x_1047c();
i = long2_x_1048c();
i = long2_x_1807c();
i = long2_x_1808c();
i = long2_x_2567c();
i = long2_x_2568c();
i = long2_x_287c();
i = long2_x_288c();
i = long2_x_3327c();
i = long2_x_3328c();
i = long2_x_4087c();
i = long2_x_4088c();
i = long2_x_4847c();
i = long2_x_4848c();
i = long2_x_5607c();
i = long2_x_5608c();
i = long2_x_6367c();
i = long2_x_6368c();
i = long2_x_7127c();
i = long2_x_7128c();
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
