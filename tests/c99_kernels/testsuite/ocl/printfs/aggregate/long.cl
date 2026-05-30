/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/long.c'  */

int long_d_139c() {
  // { dg-printf "long_d_139c===-4===5===" }
  long var1 = (long) (-4);
  long var2 = (long) (5);
  int i = printf("long_d_139c===%ld===%ld===\n",var1,var2);
  return i;
}

int long_d_1659c() {
  // { dg-printf "long_d_1659c===+8===+123445===" }
  long var1 = (long) (8);
  long var2 = (long) (123445);
  int i = printf("long_d_1659c===%+ld===%+ld===\n",var1,var2);
  return i;
}

int long_d_2419c() {
  // { dg-printf "long_d_2419c===6===-1===" }
  long var1 = (long) (6);
  long var2 = (long) (-1);
  int i = printf("long_d_2419c===%#ld===%#ld===\n",var1,var2);
  return i;
}

int long_d_3179c() {
  // { dg-printf "long_d_3179c===-1===+5===" }
  long var1 = (long) (-1);
  long var2 = (long) (5);
  int i = printf("long_d_3179c===%-+ld===%-+ld===\n",var1,var2);
  return i;
}

int long_d_3939c() {
  // { dg-printf "long_d_3939c===         5===         0===" }
  long var1 = (long) (5);
  long var2 = (long) (0);
  int i = printf("long_d_3939c===% 10ld===% 10ld===\n",var1,var2);
  return i;
}

int long_d_4699c() {
  // { dg-printf "long_d_4699c===-000000008===-000000005===" }
  long var1 = (long) (-8);
  long var2 = (long) (-5);
  int i = printf("long_d_4699c===%010ld===%010ld===\n",var1,var2);
  return i;
}

int long_d_5459c() {
  // { dg-printf "long_d_5459c===-6        === 7        ===" }
  long var1 = (long) (-6);
  long var2 = (long) (7);
  int i = printf("long_d_5459c===%- 10ld===%- 10ld===\n",var1,var2);
  return i;
}

int long_d_6219c() {
  // { dg-printf "long_d_6219c===        +3===        -2===" }
  long var1 = (long) (3);
  long var2 = (long) (-2);
  int i = printf("long_d_6219c===%+ 10ld===%+ 10ld===\n",var1,var2);
  return i;
}

int long_d_6979c() {
  // { dg-printf "long_d_6979c===-000123455===+000000008===" }
  long var1 = (long) (-123455);
  long var2 = (long) (8);
  int i = printf("long_d_6979c===%+010ld===%+010ld===\n",var1,var2);
  return i;
}

int long_d_899c() {
  // { dg-printf "long_d_899c===4===-7===" }
  long var1 = (long) (4);
  long var2 = (long) (-7);
  int i = printf("long_d_899c===%-ld===%-ld===\n",var1,var2);
  return i;
}

int long_i_140c() {
  // { dg-printf "long_i_140c===2===-4===" }
  long var1 = (long) (2);
  long var2 = (long) (-4);
  int i = printf("long_i_140c===%li===%li===\n",var1,var2);
  return i;
}

int long_i_1660c() {
  // { dg-printf "long_i_1660c===+5===+4===" }
  long var1 = (long) (5);
  long var2 = (long) (4);
  int i = printf("long_i_1660c===%+li===%+li===\n",var1,var2);
  return i;
}

int long_i_2420c() {
  // { dg-printf "long_i_2420c===-2===8===" }
  long var1 = (long) (-2);
  long var2 = (long) (8);
  int i = printf("long_i_2420c===%#li===%#li===\n",var1,var2);
  return i;
}

int long_i_3180c() {
  // { dg-printf "long_i_3180c===+3===-6===" }
  long var1 = (long) (3);
  long var2 = (long) (-6);
  int i = printf("long_i_3180c===%-+li===%-+li===\n",var1,var2);
  return i;
}

int long_i_3940c() {
  // { dg-printf "long_i_3940c===        -3===   -123455===" }
  long var1 = (long) (-3);
  long var2 = (long) (-123455);
  int i = printf("long_i_3940c===% 10li===% 10li===\n",var1,var2);
  return i;
}

int long_i_4700c() {
  // { dg-printf "long_i_4700c===-000000004===-000000005===" }
  long var1 = (long) (-4);
  long var2 = (long) (-5);
  int i = printf("long_i_4700c===%010li===%010li===\n",var1,var2);
  return i;
}

int long_i_5460c() {
  // { dg-printf "long_i_5460c=== 4        ===-5        ===" }
  long var1 = (long) (4);
  long var2 = (long) (-5);
  int i = printf("long_i_5460c===%- 10li===%- 10li===\n",var1,var2);
  return i;
}

int long_i_6220c() {
  // { dg-printf "long_i_6220c===        -8===        -2===" }
  long var1 = (long) (-8);
  long var2 = (long) (-2);
  int i = printf("long_i_6220c===%+ 10li===%+ 10li===\n",var1,var2);
  return i;
}

int long_i_6980c() {
  // { dg-printf "long_i_6980c===+000000005===+000000007===" }
  long var1 = (long) (5);
  long var2 = (long) (7);
  int i = printf("long_i_6980c===%+010li===%+010li===\n",var1,var2);
  return i;
}

int long_i_900c() {
  // { dg-printf "long_i_900c===-5===-6===" }
  long var1 = (long) (-5);
  long var2 = (long) (-6);
  int i = printf("long_i_900c===%-li===%-li===\n",var1,var2);
  return i;
}

int long_o_141c() {
  // { dg-printf "long_o_141c===7===6===" }
  long var1 = (long) (7);
  long var2 = (long) (6);
  int i = printf("long_o_141c===%lo===%lo===\n",var1,var2);
  return i;
}

int long_o_1661c() {
  // { dg-printf "long_o_1661c===2===1777777777777777416701===" }
  long var1 = (long) (2);
  long var2 = (long) (-123455);
  int i = printf("long_o_1661c===%+lo===%+lo===\n",var1,var2);
  return i;
}

int long_o_2421c() {
  // { dg-printf "long_o_2421c===01777777777777777416701===07===" }
  long var1 = (long) (-123455);
  long var2 = (long) (7);
  int i = printf("long_o_2421c===%#lo===%#lo===\n",var1,var2);
  return i;
}

int long_o_3181c() {
  // { dg-printf "long_o_3181c===1777777777777777777777===1777777777777777416701===" }
  long var1 = (long) (-1);
  long var2 = (long) (-123455);
  int i = printf("long_o_3181c===%-+lo===%-+lo===\n",var1,var2);
  return i;
}

int long_o_3941c() {
  // { dg-printf "long_o_3941c===1777777777777777777775===         1===" }
  long var1 = (long) (-3);
  long var2 = (long) (1);
  int i = printf("long_o_3941c===% 10lo===% 10lo===\n",var1,var2);
  return i;
}

int long_o_4701c() {
  // { dg-printf "long_o_4701c===0000000002===1777777777777777777770===" }
  long var1 = (long) (2);
  long var2 = (long) (-8);
  int i = printf("long_o_4701c===%010lo===%010lo===\n",var1,var2);
  return i;
}

int long_o_5461c() {
  // { dg-printf "long_o_5461c===3         ===5         ===" }
  long var1 = (long) (3);
  long var2 = (long) (5);
  int i = printf("long_o_5461c===%- 10lo===%- 10lo===\n",var1,var2);
  return i;
}

int long_o_6221c() {
  // { dg-printf "long_o_6221c===1777777777777777777773===         3===" }
  long var1 = (long) (-5);
  long var2 = (long) (3);
  int i = printf("long_o_6221c===%+ 10lo===%+ 10lo===\n",var1,var2);
  return i;
}

int long_o_6981c() {
  // { dg-printf "long_o_6981c===1777777777777777777776===1777777777777777416701===" }
  long var1 = (long) (-2);
  long var2 = (long) (-123455);
  int i = printf("long_o_6981c===%+010lo===%+010lo===\n",var1,var2);
  return i;
}

int long_o_901c() {
  // { dg-printf "long_o_901c===361065===1777777777777777777771===" }
  long var1 = (long) (123445);
  long var2 = (long) (-7);
  int i = printf("long_o_901c===%-lo===%-lo===\n",var1,var2);
  return i;
}

int long_u_142c() {
  // { dg-printf "long_u_142c===4===4===" }
  long var1 = (long) (4);
  long var2 = (long) (4);
  int i = printf("long_u_142c===%lu===%lu===\n",var1,var2);
  return i;
}

int long_u_1662c() {
  // { dg-printf "long_u_1662c===18446744073709551608===7===" }
  long var1 = (long) (-8);
  long var2 = (long) (7);
  int i = printf("long_u_1662c===%+lu===%+lu===\n",var1,var2);
  return i;
}

int long_u_2422c() {
  // { dg-printf "long_u_2422c===6===18446744073709551614===" }
  long var1 = (long) (6);
  long var2 = (long) (-2);
  int i = printf("long_u_2422c===%#lu===%#lu===\n",var1,var2);
  return i;
}

int long_u_3182c() {
  // { dg-printf "long_u_3182c===18446744073709551609===2===" }
  long var1 = (long) (-7);
  long var2 = (long) (2);
  int i = printf("long_u_3182c===%-+lu===%-+lu===\n",var1,var2);
  return i;
}

int long_u_3942c() {
  // { dg-printf "long_u_3942c===18446744073709551612===18446744073709551608===" }
  long var1 = (long) (-4);
  long var2 = (long) (-8);
  int i = printf("long_u_3942c===% 10lu===% 10lu===\n",var1,var2);
  return i;
}

int long_u_4702c() {
  // { dg-printf "long_u_4702c===18446744073709551615===0000000000===" }
  long var1 = (long) (-1);
  long var2 = (long) (0);
  int i = printf("long_u_4702c===%010lu===%010lu===\n",var1,var2);
  return i;
}

int long_u_5462c() {
  // { dg-printf "long_u_5462c===8         ===18446744073709551610===" }
  long var1 = (long) (8);
  long var2 = (long) (-6);
  int i = printf("long_u_5462c===%- 10lu===%- 10lu===\n",var1,var2);
  return i;
}

int long_u_6222c() {
  // { dg-printf "long_u_6222c===         0===         8===" }
  long var1 = (long) (0);
  long var2 = (long) (8);
  int i = printf("long_u_6222c===%+ 10lu===%+ 10lu===\n",var1,var2);
  return i;
}

int long_u_6982c() {
  // { dg-printf "long_u_6982c===0000000008===18446744073709551611===" }
  long var1 = (long) (8);
  long var2 = (long) (-5);
  int i = printf("long_u_6982c===%+010lu===%+010lu===\n",var1,var2);
  return i;
}

int long_u_902c() {
  // { dg-printf "long_u_902c===4===3===" }
  long var1 = (long) (4);
  long var2 = (long) (3);
  int i = printf("long_u_902c===%-lu===%-lu===\n",var1,var2);
  return i;
}

int long_x_143c() {
  // { dg-printf "long_x_143c===fffffffffffffffb===3===" }
  long var1 = (long) (-5);
  long var2 = (long) (3);
  int i = printf("long_x_143c===%lx===%lx===\n",var1,var2);
  return i;
}

int long_x_144c() {
  // { dg-printf "long_x_144c===0===5===" }
  long var1 = (long) (0);
  long var2 = (long) (5);
  int i = printf("long_x_144c===%lX===%lX===\n",var1,var2);
  return i;
}

int long_x_1663c() {
  // { dg-printf "long_x_1663c===fffffffffffffffe===fffffffffffe1dc1===" }
  long var1 = (long) (-2);
  long var2 = (long) (-123455);
  int i = printf("long_x_1663c===%+lx===%+lx===\n",var1,var2);
  return i;
}

int long_x_1664c() {
  // { dg-printf "long_x_1664c===FFFFFFFFFFFFFFFF===FFFFFFFFFFFFFFFD===" }
  long var1 = (long) (-1);
  long var2 = (long) (-3);
  int i = printf("long_x_1664c===%+lX===%+lX===\n",var1,var2);
  return i;
}

int long_x_2423c() {
  // { dg-printf "long_x_2423c===0===0xfffffffffffffffa===" }
  long var1 = (long) (0);
  long var2 = (long) (-6);
  int i = printf("long_x_2423c===%#lx===%#lx===\n",var1,var2);
  return i;
}

int long_x_2424c() {
  // { dg-printf "long_x_2424c===0XFFFFFFFFFFFFFFFF===0X5===" }
  long var1 = (long) (-1);
  long var2 = (long) (5);
  int i = printf("long_x_2424c===%#lX===%#lX===\n",var1,var2);
  return i;
}

int long_x_3183c() {
  // { dg-printf "long_x_3183c===fffffffffffffffa===5===" }
  long var1 = (long) (-6);
  long var2 = (long) (5);
  int i = printf("long_x_3183c===%-+lx===%-+lx===\n",var1,var2);
  return i;
}

int long_x_3184c() {
  // { dg-printf "long_x_3184c===FFFFFFFFFFFFFFF8===5===" }
  long var1 = (long) (-8);
  long var2 = (long) (5);
  int i = printf("long_x_3184c===%-+lX===%-+lX===\n",var1,var2);
  return i;
}

int long_x_3943c() {
  // { dg-printf "long_x_3943c===         0===         2===" }
  long var1 = (long) (0);
  long var2 = (long) (2);
  int i = printf("long_x_3943c===% 10lx===% 10lx===\n",var1,var2);
  return i;
}

int long_x_3944c() {
  // { dg-printf "long_x_3944c===FFFFFFFFFFFFFFFA===FFFFFFFFFFFFFFF8===" }
  long var1 = (long) (-6);
  long var2 = (long) (-8);
  int i = printf("long_x_3944c===% 10lX===% 10lX===\n",var1,var2);
  return i;
}

int long_x_4703c() {
  // { dg-printf "long_x_4703c===0000000004===0000000000===" }
  long var1 = (long) (4);
  long var2 = (long) (0);
  int i = printf("long_x_4703c===%010lx===%010lx===\n",var1,var2);
  return i;
}

int long_x_4704c() {
  // { dg-printf "long_x_4704c===0000000003===000001E235===" }
  long var1 = (long) (3);
  long var2 = (long) (123445);
  int i = printf("long_x_4704c===%010lX===%010lX===\n",var1,var2);
  return i;
}

int long_x_5463c() {
  // { dg-printf "long_x_5463c===fffffffffffffffc===ffffffffffffffff===" }
  long var1 = (long) (-4);
  long var2 = (long) (-1);
  int i = printf("long_x_5463c===%- 10lx===%- 10lx===\n",var1,var2);
  return i;
}

int long_x_5464c() {
  // { dg-printf "long_x_5464c===3         ===5         ===" }
  long var1 = (long) (3);
  long var2 = (long) (5);
  int i = printf("long_x_5464c===%- 10lX===%- 10lX===\n",var1,var2);
  return i;
}

int long_x_6223c() {
  // { dg-printf "long_x_6223c===fffffffffffffff8===         6===" }
  long var1 = (long) (-8);
  long var2 = (long) (6);
  int i = printf("long_x_6223c===%+ 10lx===%+ 10lx===\n",var1,var2);
  return i;
}

int long_x_6224c() {
  // { dg-printf "long_x_6224c===     1E235===FFFFFFFFFFFFFFFF===" }
  long var1 = (long) (123445);
  long var2 = (long) (-1);
  int i = printf("long_x_6224c===%+ 10lX===%+ 10lX===\n",var1,var2);
  return i;
}

int long_x_6983c() {
  // { dg-printf "long_x_6983c===fffffffffffffff9===0000000003===" }
  long var1 = (long) (-7);
  long var2 = (long) (3);
  int i = printf("long_x_6983c===%+010lx===%+010lx===\n",var1,var2);
  return i;
}

int long_x_6984c() {
  // { dg-printf "long_x_6984c===FFFFFFFFFFFFFFFB===FFFFFFFFFFFFFFF9===" }
  long var1 = (long) (-5);
  long var2 = (long) (-7);
  int i = printf("long_x_6984c===%+010lX===%+010lX===\n",var1,var2);
  return i;
}

int long_x_903c() {
  // { dg-printf "long_x_903c===6===1e235===" }
  long var1 = (long) (6);
  long var2 = (long) (123445);
  int i = printf("long_x_903c===%-lx===%-lx===\n",var1,var2);
  return i;
}

int long_x_904c() {
  // { dg-printf "long_x_904c===1E235===3===" }
  long var1 = (long) (123445);
  long var2 = (long) (3);
  int i = printf("long_x_904c===%-lX===%-lX===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = long_d_139c();
i = long_d_1659c();
i = long_d_2419c();
i = long_d_3179c();
i = long_d_3939c();
i = long_d_4699c();
i = long_d_5459c();
i = long_d_6219c();
i = long_d_6979c();
i = long_d_899c();
i = long_i_140c();
i = long_i_1660c();
i = long_i_2420c();
i = long_i_3180c();
i = long_i_3940c();
i = long_i_4700c();
i = long_i_5460c();
i = long_i_6220c();
i = long_i_6980c();
i = long_i_900c();
i = long_o_141c();
i = long_o_1661c();
i = long_o_2421c();
i = long_o_3181c();
i = long_o_3941c();
i = long_o_4701c();
i = long_o_5461c();
i = long_o_6221c();
i = long_o_6981c();
i = long_o_901c();
i = long_u_142c();
i = long_u_1662c();
i = long_u_2422c();
i = long_u_3182c();
i = long_u_3942c();
i = long_u_4702c();
i = long_u_5462c();
i = long_u_6222c();
i = long_u_6982c();
i = long_u_902c();
i = long_x_143c();
i = long_x_144c();
i = long_x_1663c();
i = long_x_1664c();
i = long_x_2423c();
i = long_x_2424c();
i = long_x_3183c();
i = long_x_3184c();
i = long_x_3943c();
i = long_x_3944c();
i = long_x_4703c();
i = long_x_4704c();
i = long_x_5463c();
i = long_x_5464c();
i = long_x_6223c();
i = long_x_6224c();
i = long_x_6983c();
i = long_x_6984c();
i = long_x_903c();
i = long_x_904c();
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
