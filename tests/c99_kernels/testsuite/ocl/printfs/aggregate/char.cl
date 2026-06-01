/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/char.c'  */

int char_d_1567c() {
  // { dg-printf "char_d_1567c===+3===-7===" }
  char var1 = (char) (3);
  char var2 = (char) (-7);
  int i = printf("char_d_1567c===%+hhd===%+hhd===\n",var1,var2);
  return i;
}

int char_d_2327c() {
  // { dg-printf "char_d_2327c===-2===7===" }
  char var1 = (char) (-2);
  char var2 = (char) (7);
  int i = printf("char_d_2327c===%#hhd===%#hhd===\n",var1,var2);
  return i;
}

int char_d_3087c() {
  // { dg-printf "char_d_3087c===-7===+6===" }
  char var1 = (char) (-7);
  char var2 = (char) (6);
  int i = printf("char_d_3087c===%-+hhd===%-+hhd===\n",var1,var2);
  return i;
}

int char_d_3847c() {
  // { dg-printf "char_d_3847c===        -3===         7===" }
  char var1 = (char) (-3);
  char var2 = (char) (7);
  int i = printf("char_d_3847c===% 10hhd===% 10hhd===\n",var1,var2);
  return i;
}

int char_d_4607c() {
  // { dg-printf "char_d_4607c===0000000053===-000000003===" }
  char var1 = (char) (123445);
  char var2 = (char) (-3);
  int i = printf("char_d_4607c===%010hhd===%010hhd===\n",var1,var2);
  return i;
}

int char_d_47c() {
  // { dg-printf "char_d_47c===-3===2===" }
  char var1 = (char) (-3);
  char var2 = (char) (2);
  int i = printf("char_d_47c===%hhd===%hhd===\n",var1,var2);
  return i;
}

int char_d_5367c() {
  // { dg-printf "char_d_5367c===-3        === 5        ===" }
  char var1 = (char) (-3);
  char var2 = (char) (5);
  int i = printf("char_d_5367c===%- 10hhd===%- 10hhd===\n",var1,var2);
  return i;
}

int char_d_6127c() {
  // { dg-printf "char_d_6127c===        +7===        +4===" }
  char var1 = (char) (7);
  char var2 = (char) (4);
  int i = printf("char_d_6127c===%+ 10hhd===%+ 10hhd===\n",var1,var2);
  return i;
}

int char_d_6887c() {
  // { dg-printf "char_d_6887c===+000000004===-000000001===" }
  char var1 = (char) (4);
  char var2 = (char) (-1);
  int i = printf("char_d_6887c===%+010hhd===%+010hhd===\n",var1,var2);
  return i;
}

int char_d_807c() {
  // { dg-printf "char_d_807c===7===-5===" }
  char var1 = (char) (7);
  char var2 = (char) (-5);
  int i = printf("char_d_807c===%-hhd===%-hhd===\n",var1,var2);
  return i;
}

int char_i_1568c() {
  // { dg-printf "char_i_1568c===+3===+0===" }
  char var1 = (char) (3);
  char var2 = (char) (0);
  int i = printf("char_i_1568c===%+hhi===%+hhi===\n",var1,var2);
  return i;
}

int char_i_2328c() {
  // { dg-printf "char_i_2328c===-63===-8===" }
  char var1 = (char) (-123455);
  char var2 = (char) (-8);
  int i = printf("char_i_2328c===%#hhi===%#hhi===\n",var1,var2);
  return i;
}

int char_i_3088c() {
  // { dg-printf "char_i_3088c===+2===-2===" }
  char var1 = (char) (2);
  char var2 = (char) (-2);
  int i = printf("char_i_3088c===%-+hhi===%-+hhi===\n",var1,var2);
  return i;
}

int char_i_3848c() {
  // { dg-printf "char_i_3848c===         6===        -7===" }
  char var1 = (char) (6);
  char var2 = (char) (-7);
  int i = printf("char_i_3848c===% 10hhi===% 10hhi===\n",var1,var2);
  return i;
}

int char_i_4608c() {
  // { dg-printf "char_i_4608c===-000000008===-000000002===" }
  char var1 = (char) (-8);
  char var2 = (char) (-2);
  int i = printf("char_i_4608c===%010hhi===%010hhi===\n",var1,var2);
  return i;
}

int char_i_48c() {
  // { dg-printf "char_i_48c===4===-4===" }
  char var1 = (char) (4);
  char var2 = (char) (-4);
  int i = printf("char_i_48c===%hhi===%hhi===\n",var1,var2);
  return i;
}

int char_i_5368c() {
  // { dg-printf "char_i_5368c=== 53       ===-2        ===" }
  char var1 = (char) (123445);
  char var2 = (char) (-2);
  int i = printf("char_i_5368c===%- 10hhi===%- 10hhi===\n",var1,var2);
  return i;
}

int char_i_6128c() {
  // { dg-printf "char_i_6128c===        +8===        +7===" }
  char var1 = (char) (8);
  char var2 = (char) (7);
  int i = printf("char_i_6128c===%+ 10hhi===%+ 10hhi===\n",var1,var2);
  return i;
}

int char_i_6888c() {
  // { dg-printf "char_i_6888c===-000000063===+000000002===" }
  char var1 = (char) (-123455);
  char var2 = (char) (2);
  int i = printf("char_i_6888c===%+010hhi===%+010hhi===\n",var1,var2);
  return i;
}

int char_i_808c() {
  // { dg-printf "char_i_808c===2===-2===" }
  char var1 = (char) (2);
  char var2 = (char) (-2);
  int i = printf("char_i_808c===%-hhi===%-hhi===\n",var1,var2);
  return i;
}

int char_o_1569c() {
  // { dg-printf "char_o_1569c===3===65===" }
  char var1 = (char) (3);
  char var2 = (char) (123445);
  int i = printf("char_o_1569c===%+hho===%+hho===\n",var1,var2);
  return i;
}

int char_o_2329c() {
  // { dg-printf "char_o_2329c===06===0===" }
  char var1 = (char) (6);
  char var2 = (char) (0);
  int i = printf("char_o_2329c===%#hho===%#hho===\n",var1,var2);
  return i;
}

int char_o_3089c() {
  // { dg-printf "char_o_3089c===4===377===" }
  char var1 = (char) (4);
  char var2 = (char) (-1);
  int i = printf("char_o_3089c===%-+hho===%-+hho===\n",var1,var2);
  return i;
}

int char_o_3849c() {
  // { dg-printf "char_o_3849c===       371===         2===" }
  char var1 = (char) (-7);
  char var2 = (char) (2);
  int i = printf("char_o_3849c===% 10hho===% 10hho===\n",var1,var2);
  return i;
}

int char_o_4609c() {
  // { dg-printf "char_o_4609c===0000000301===0000000002===" }
  char var1 = (char) (-123455);
  char var2 = (char) (2);
  int i = printf("char_o_4609c===%010hho===%010hho===\n",var1,var2);
  return i;
}

int char_o_49c() {
  // { dg-printf "char_o_49c===375===370===" }
  char var1 = (char) (-3);
  char var2 = (char) (-8);
  int i = printf("char_o_49c===%hho===%hho===\n",var1,var2);
  return i;
}

int char_o_5369c() {
  // { dg-printf "char_o_5369c===371       ===374       ===" }
  char var1 = (char) (-7);
  char var2 = (char) (-4);
  int i = printf("char_o_5369c===%- 10hho===%- 10hho===\n",var1,var2);
  return i;
}

int char_o_6129c() {
  // { dg-printf "char_o_6129c===         0===       376===" }
  char var1 = (char) (0);
  char var2 = (char) (-2);
  int i = printf("char_o_6129c===%+ 10hho===%+ 10hho===\n",var1,var2);
  return i;
}

int char_o_6889c() {
  // { dg-printf "char_o_6889c===0000000001===0000000301===" }
  char var1 = (char) (1);
  char var2 = (char) (-123455);
  int i = printf("char_o_6889c===%+010hho===%+010hho===\n",var1,var2);
  return i;
}

int char_o_809c() {
  // { dg-printf "char_o_809c===372===2===" }
  char var1 = (char) (-6);
  char var2 = (char) (2);
  int i = printf("char_o_809c===%-hho===%-hho===\n",var1,var2);
  return i;
}

int char_u_1570c() {
  // { dg-printf "char_u_1570c===1===193===" }
  char var1 = (char) (1);
  char var2 = (char) (-123455);
  int i = printf("char_u_1570c===%+hhu===%+hhu===\n",var1,var2);
  return i;
}

int char_u_2330c() {
  // { dg-printf "char_u_2330c===255===2===" }
  char var1 = (char) (-1);
  char var2 = (char) (2);
  int i = printf("char_u_2330c===%#hhu===%#hhu===\n",var1,var2);
  return i;
}

int char_u_3090c() {
  // { dg-printf "char_u_3090c===7===249===" }
  char var1 = (char) (7);
  char var2 = (char) (-7);
  int i = printf("char_u_3090c===%-+hhu===%-+hhu===\n",var1,var2);
  return i;
}

int char_u_3850c() {
  // { dg-printf "char_u_3850c===         1===       193===" }
  char var1 = (char) (1);
  char var2 = (char) (-123455);
  int i = printf("char_u_3850c===% 10hhu===% 10hhu===\n",var1,var2);
  return i;
}

int char_u_4610c() {
  // { dg-printf "char_u_4610c===0000000008===0000000005===" }
  char var1 = (char) (8);
  char var2 = (char) (5);
  int i = printf("char_u_4610c===%010hhu===%010hhu===\n",var1,var2);
  return i;
}

int char_u_50c() {
  // { dg-printf "char_u_50c===255===4===" }
  char var1 = (char) (-1);
  char var2 = (char) (4);
  int i = printf("char_u_50c===%hhu===%hhu===\n",var1,var2);
  return i;
}

int char_u_5370c() {
  // { dg-printf "char_u_5370c===3         ===255       ===" }
  char var1 = (char) (3);
  char var2 = (char) (-1);
  int i = printf("char_u_5370c===%- 10hhu===%- 10hhu===\n",var1,var2);
  return i;
}

int char_u_6130c() {
  // { dg-printf "char_u_6130c===       193===         1===" }
  char var1 = (char) (-123455);
  char var2 = (char) (1);
  int i = printf("char_u_6130c===%+ 10hhu===%+ 10hhu===\n",var1,var2);
  return i;
}

int char_u_6890c() {
  // { dg-printf "char_u_6890c===0000000254===0000000254===" }
  char var1 = (char) (-2);
  char var2 = (char) (-2);
  int i = printf("char_u_6890c===%+010hhu===%+010hhu===\n",var1,var2);
  return i;
}

int char_u_810c() {
  // { dg-printf "char_u_810c===251===53===" }
  char var1 = (char) (-5);
  char var2 = (char) (123445);
  int i = printf("char_u_810c===%-hhu===%-hhu===\n",var1,var2);
  return i;
}

int char_x_1571c() {
  // { dg-printf "char_x_1571c===ff===2===" }
  char var1 = (char) (-1);
  char var2 = (char) (2);
  int i = printf("char_x_1571c===%+hhx===%+hhx===\n",var1,var2);
  return i;
}

int char_x_1572c() {
  // { dg-printf "char_x_1572c===FF===6===" }
  char var1 = (char) (-1);
  char var2 = (char) (6);
  int i = printf("char_x_1572c===%+hhX===%+hhX===\n",var1,var2);
  return i;
}

int char_x_2331c() {
  // { dg-printf "char_x_2331c===0x35===0===" }
  char var1 = (char) (123445);
  char var2 = (char) (0);
  int i = printf("char_x_2331c===%#hhx===%#hhx===\n",var1,var2);
  return i;
}

int char_x_2332c() {
  // { dg-printf "char_x_2332c===0X8===0X6===" }
  char var1 = (char) (8);
  char var2 = (char) (6);
  int i = printf("char_x_2332c===%#hhX===%#hhX===\n",var1,var2);
  return i;
}

int char_x_3091c() {
  // { dg-printf "char_x_3091c===fa===fe===" }
  char var1 = (char) (-6);
  char var2 = (char) (-2);
  int i = printf("char_x_3091c===%-+hhx===%-+hhx===\n",var1,var2);
  return i;
}

int char_x_3092c() {
  // { dg-printf "char_x_3092c===FB===FB===" }
  char var1 = (char) (-5);
  char var2 = (char) (-5);
  int i = printf("char_x_3092c===%-+hhX===%-+hhX===\n",var1,var2);
  return i;
}

int char_x_3851c() {
  // { dg-printf "char_x_3851c===         5===         7===" }
  char var1 = (char) (5);
  char var2 = (char) (7);
  int i = printf("char_x_3851c===% 10hhx===% 10hhx===\n",var1,var2);
  return i;
}

int char_x_3852c() {
  // { dg-printf "char_x_3852c===        FC===         2===" }
  char var1 = (char) (-4);
  char var2 = (char) (2);
  int i = printf("char_x_3852c===% 10hhX===% 10hhX===\n",var1,var2);
  return i;
}

int char_x_4611c() {
  // { dg-printf "char_x_4611c===00000000ff===0000000003===" }
  char var1 = (char) (-1);
  char var2 = (char) (3);
  int i = printf("char_x_4611c===%010hhx===%010hhx===\n",var1,var2);
  return i;
}

int char_x_4612c() {
  // { dg-printf "char_x_4612c===00000000FE===0000000007===" }
  char var1 = (char) (-2);
  char var2 = (char) (7);
  int i = printf("char_x_4612c===%010hhX===%010hhX===\n",var1,var2);
  return i;
}

int char_x_51c() {
  // { dg-printf "char_x_51c===f9===1===" }
  char var1 = (char) (-7);
  char var2 = (char) (1);
  int i = printf("char_x_51c===%hhx===%hhx===\n",var1,var2);
  return i;
}

int char_x_52c() {
  // { dg-printf "char_x_52c===2===8===" }
  char var1 = (char) (2);
  char var2 = (char) (8);
  int i = printf("char_x_52c===%hhX===%hhX===\n",var1,var2);
  return i;
}

int char_x_5371c() {
  // { dg-printf "char_x_5371c===5         ===5         ===" }
  char var1 = (char) (5);
  char var2 = (char) (5);
  int i = printf("char_x_5371c===%- 10hhx===%- 10hhx===\n",var1,var2);
  return i;
}

int char_x_5372c() {
  // { dg-printf "char_x_5372c===FC        ===FA        ===" }
  char var1 = (char) (-4);
  char var2 = (char) (-6);
  int i = printf("char_x_5372c===%- 10hhX===%- 10hhX===\n",var1,var2);
  return i;
}

int char_x_6131c() {
  // { dg-printf "char_x_6131c===         3===         2===" }
  char var1 = (char) (3);
  char var2 = (char) (2);
  int i = printf("char_x_6131c===%+ 10hhx===%+ 10hhx===\n",var1,var2);
  return i;
}

int char_x_6132c() {
  // { dg-printf "char_x_6132c===         5===         6===" }
  char var1 = (char) (5);
  char var2 = (char) (6);
  int i = printf("char_x_6132c===%+ 10hhX===%+ 10hhX===\n",var1,var2);
  return i;
}

int char_x_6891c() {
  // { dg-printf "char_x_6891c===00000000fc===0000000000===" }
  char var1 = (char) (-4);
  char var2 = (char) (0);
  int i = printf("char_x_6891c===%+010hhx===%+010hhx===\n",var1,var2);
  return i;
}

int char_x_6892c() {
  // { dg-printf "char_x_6892c===0000000008===0000000003===" }
  char var1 = (char) (8);
  char var2 = (char) (3);
  int i = printf("char_x_6892c===%+010hhX===%+010hhX===\n",var1,var2);
  return i;
}

int char_x_811c() {
  // { dg-printf "char_x_811c===3===4===" }
  char var1 = (char) (3);
  char var2 = (char) (4);
  int i = printf("char_x_811c===%-hhx===%-hhx===\n",var1,var2);
  return i;
}

int char_x_812c() {
  // { dg-printf "char_x_812c===0===8===" }
  char var1 = (char) (0);
  char var2 = (char) (8);
  int i = printf("char_x_812c===%-hhX===%-hhX===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = char_d_1567c();
i = char_d_2327c();
i = char_d_3087c();
i = char_d_3847c();
i = char_d_4607c();
i = char_d_47c();
i = char_d_5367c();
i = char_d_6127c();
i = char_d_6887c();
i = char_d_807c();
i = char_i_1568c();
i = char_i_2328c();
i = char_i_3088c();
i = char_i_3848c();
i = char_i_4608c();
i = char_i_48c();
i = char_i_5368c();
i = char_i_6128c();
i = char_i_6888c();
i = char_i_808c();
i = char_o_1569c();
i = char_o_2329c();
i = char_o_3089c();
i = char_o_3849c();
i = char_o_4609c();
i = char_o_49c();
i = char_o_5369c();
i = char_o_6129c();
i = char_o_6889c();
i = char_o_809c();
i = char_u_1570c();
i = char_u_2330c();
i = char_u_3090c();
i = char_u_3850c();
i = char_u_4610c();
i = char_u_50c();
i = char_u_5370c();
i = char_u_6130c();
i = char_u_6890c();
i = char_u_810c();
i = char_x_1571c();
i = char_x_1572c();
i = char_x_2331c();
i = char_x_2332c();
i = char_x_3091c();
i = char_x_3092c();
i = char_x_3851c();
i = char_x_3852c();
i = char_x_4611c();
i = char_x_4612c();
i = char_x_51c();
i = char_x_52c();
i = char_x_5371c();
i = char_x_5372c();
i = char_x_6131c();
i = char_x_6132c();
i = char_x_6891c();
i = char_x_6892c();
i = char_x_811c();
i = char_x_812c();
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
