/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/short.c'  */

int short_d_1613c() {
  // { dg-printf "short_d_1613c===+7617===+5===" }
  short var1 = (short) (-123455);
  short var2 = (short) (5);
  int i = printf("short_d_1613c===%+hd===%+hd===\n",var1,var2);
  return i;
}

int short_d_2373c() {
  // { dg-printf "short_d_2373c===1===0===" }
  short var1 = (short) (1);
  short var2 = (short) (0);
  int i = printf("short_d_2373c===%#hd===%#hd===\n",var1,var2);
  return i;
}

int short_d_3133c() {
  // { dg-printf "short_d_3133c===+7===-4===" }
  short var1 = (short) (7);
  short var2 = (short) (-4);
  int i = printf("short_d_3133c===%-+hd===%-+hd===\n",var1,var2);
  return i;
}

int short_d_3893c() {
  // { dg-printf "short_d_3893c===         0===         5===" }
  short var1 = (short) (0);
  short var2 = (short) (5);
  int i = printf("short_d_3893c===% 10hd===% 10hd===\n",var1,var2);
  return i;
}

int short_d_4653c() {
  // { dg-printf "short_d_4653c===-000000002===-000007627===" }
  short var1 = (short) (-2);
  short var2 = (short) (123445);
  int i = printf("short_d_4653c===%010hd===%010hd===\n",var1,var2);
  return i;
}

int short_d_5413c() {
  // { dg-printf "short_d_5413c=== 7617     ===-4        ===" }
  short var1 = (short) (-123455);
  short var2 = (short) (-4);
  int i = printf("short_d_5413c===%- 10hd===%- 10hd===\n",var1,var2);
  return i;
}

int short_d_6173c() {
  // { dg-printf "short_d_6173c===     -7627===        +5===" }
  short var1 = (short) (123445);
  short var2 = (short) (5);
  int i = printf("short_d_6173c===%+ 10hd===%+ 10hd===\n",var1,var2);
  return i;
}

int short_d_6933c() {
  // { dg-printf "short_d_6933c===+000000003===+000000002===" }
  short var1 = (short) (3);
  short var2 = (short) (2);
  int i = printf("short_d_6933c===%+010hd===%+010hd===\n",var1,var2);
  return i;
}

int short_d_853c() {
  // { dg-printf "short_d_853c===-6===-7===" }
  short var1 = (short) (-6);
  short var2 = (short) (-7);
  int i = printf("short_d_853c===%-hd===%-hd===\n",var1,var2);
  return i;
}

int short_d_93c() {
  // { dg-printf "short_d_93c===8===-7===" }
  short var1 = (short) (8);
  short var2 = (short) (-7);
  int i = printf("short_d_93c===%hd===%hd===\n",var1,var2);
  return i;
}

int short_i_1614c() {
  // { dg-printf "short_i_1614c===-7627===+5===" }
  short var1 = (short) (123445);
  short var2 = (short) (5);
  int i = printf("short_i_1614c===%+hi===%+hi===\n",var1,var2);
  return i;
}

int short_i_2374c() {
  // { dg-printf "short_i_2374c===7===-5===" }
  short var1 = (short) (7);
  short var2 = (short) (-5);
  int i = printf("short_i_2374c===%#hi===%#hi===\n",var1,var2);
  return i;
}

int short_i_3134c() {
  // { dg-printf "short_i_3134c===-2===+7===" }
  short var1 = (short) (-2);
  short var2 = (short) (7);
  int i = printf("short_i_3134c===%-+hi===%-+hi===\n",var1,var2);
  return i;
}

int short_i_3894c() {
  // { dg-printf "short_i_3894c===        -5===         3===" }
  short var1 = (short) (-5);
  short var2 = (short) (3);
  int i = printf("short_i_3894c===% 10hi===% 10hi===\n",var1,var2);
  return i;
}

int short_i_4654c() {
  // { dg-printf "short_i_4654c===0000000008===-000000006===" }
  short var1 = (short) (8);
  short var2 = (short) (-6);
  int i = printf("short_i_4654c===%010hi===%010hi===\n",var1,var2);
  return i;
}

int short_i_5414c() {
  // { dg-printf "short_i_5414c===-4        === 8        ===" }
  short var1 = (short) (-4);
  short var2 = (short) (8);
  int i = printf("short_i_5414c===%- 10hi===%- 10hi===\n",var1,var2);
  return i;
}

int short_i_6174c() {
  // { dg-printf "short_i_6174c===        -8===        +6===" }
  short var1 = (short) (-8);
  short var2 = (short) (6);
  int i = printf("short_i_6174c===%+ 10hi===%+ 10hi===\n",var1,var2);
  return i;
}

int short_i_6934c() {
  // { dg-printf "short_i_6934c===+000007617===+000000000===" }
  short var1 = (short) (-123455);
  short var2 = (short) (0);
  int i = printf("short_i_6934c===%+010hi===%+010hi===\n",var1,var2);
  return i;
}

int short_i_854c() {
  // { dg-printf "short_i_854c===-8===1===" }
  short var1 = (short) (-8);
  short var2 = (short) (1);
  int i = printf("short_i_854c===%-hi===%-hi===\n",var1,var2);
  return i;
}

int short_i_94c() {
  // { dg-printf "short_i_94c===3===1===" }
  short var1 = (short) (3);
  short var2 = (short) (1);
  int i = printf("short_i_94c===%hi===%hi===\n",var1,var2);
  return i;
}

int short_o_1615c() {
  // { dg-printf "short_o_1615c===161065===177775===" }
  short var1 = (short) (123445);
  short var2 = (short) (-3);
  int i = printf("short_o_1615c===%+ho===%+ho===\n",var1,var2);
  return i;
}

int short_o_2375c() {
  // { dg-printf "short_o_2375c===010===0177777===" }
  short var1 = (short) (8);
  short var2 = (short) (-1);
  int i = printf("short_o_2375c===%#ho===%#ho===\n",var1,var2);
  return i;
}

int short_o_3135c() {
  // { dg-printf "short_o_3135c===177775===10===" }
  short var1 = (short) (-3);
  short var2 = (short) (8);
  int i = printf("short_o_3135c===%-+ho===%-+ho===\n",var1,var2);
  return i;
}

int short_o_3895c() {
  // { dg-printf "short_o_3895c===         5===    177775===" }
  short var1 = (short) (5);
  short var2 = (short) (-3);
  int i = printf("short_o_3895c===% 10ho===% 10ho===\n",var1,var2);
  return i;
}

int short_o_4655c() {
  // { dg-printf "short_o_4655c===0000000005===0000161065===" }
  short var1 = (short) (5);
  short var2 = (short) (123445);
  int i = printf("short_o_4655c===%010ho===%010ho===\n",var1,var2);
  return i;
}

int short_o_5415c() {
  // { dg-printf "short_o_5415c===3         ===161065    ===" }
  short var1 = (short) (3);
  short var2 = (short) (123445);
  int i = printf("short_o_5415c===%- 10ho===%- 10ho===\n",var1,var2);
  return i;
}

int short_o_6175c() {
  // { dg-printf "short_o_6175c===    177771===    177772===" }
  short var1 = (short) (-7);
  short var2 = (short) (-6);
  int i = printf("short_o_6175c===%+ 10ho===%+ 10ho===\n",var1,var2);
  return i;
}

int short_o_6935c() {
  // { dg-printf "short_o_6935c===0000177772===0000000010===" }
  short var1 = (short) (-6);
  short var2 = (short) (8);
  int i = printf("short_o_6935c===%+010ho===%+010ho===\n",var1,var2);
  return i;
}

int short_o_855c() {
  // { dg-printf "short_o_855c===177771===6===" }
  short var1 = (short) (-7);
  short var2 = (short) (6);
  int i = printf("short_o_855c===%-ho===%-ho===\n",var1,var2);
  return i;
}

int short_o_95c() {
  // { dg-printf "short_o_95c===2===2===" }
  short var1 = (short) (2);
  short var2 = (short) (2);
  int i = printf("short_o_95c===%ho===%ho===\n",var1,var2);
  return i;
}

int short_u_1616c() {
  // { dg-printf "short_u_1616c===6===3===" }
  short var1 = (short) (6);
  short var2 = (short) (3);
  int i = printf("short_u_1616c===%+hu===%+hu===\n",var1,var2);
  return i;
}

int short_u_2376c() {
  // { dg-printf "short_u_2376c===65534===65535===" }
  short var1 = (short) (-2);
  short var2 = (short) (-1);
  int i = printf("short_u_2376c===%#hu===%#hu===\n",var1,var2);
  return i;
}

int short_u_3136c() {
  // { dg-printf "short_u_3136c===65528===65531===" }
  short var1 = (short) (-8);
  short var2 = (short) (-5);
  int i = printf("short_u_3136c===%-+hu===%-+hu===\n",var1,var2);
  return i;
}

int short_u_3896c() {
  // { dg-printf "short_u_3896c===     65529===         7===" }
  short var1 = (short) (-7);
  short var2 = (short) (7);
  int i = printf("short_u_3896c===% 10hu===% 10hu===\n",var1,var2);
  return i;
}

int short_u_4656c() {
  // { dg-printf "short_u_4656c===0000000004===0000065531===" }
  short var1 = (short) (4);
  short var2 = (short) (-5);
  int i = printf("short_u_4656c===%010hu===%010hu===\n",var1,var2);
  return i;
}

int short_u_5416c() {
  // { dg-printf "short_u_5416c===65530     ===65532     ===" }
  short var1 = (short) (-6);
  short var2 = (short) (-4);
  int i = printf("short_u_5416c===%- 10hu===%- 10hu===\n",var1,var2);
  return i;
}

int short_u_6176c() {
  // { dg-printf "short_u_6176c===         0===         3===" }
  short var1 = (short) (0);
  short var2 = (short) (3);
  int i = printf("short_u_6176c===%+ 10hu===%+ 10hu===\n",var1,var2);
  return i;
}

int short_u_6936c() {
  // { dg-printf "short_u_6936c===0000065530===0000000006===" }
  short var1 = (short) (-6);
  short var2 = (short) (6);
  int i = printf("short_u_6936c===%+010hu===%+010hu===\n",var1,var2);
  return i;
}

int short_u_856c() {
  // { dg-printf "short_u_856c===65532===1===" }
  short var1 = (short) (-4);
  short var2 = (short) (1);
  int i = printf("short_u_856c===%-hu===%-hu===\n",var1,var2);
  return i;
}

int short_u_96c() {
  // { dg-printf "short_u_96c===2===65533===" }
  short var1 = (short) (2);
  short var2 = (short) (-3);
  int i = printf("short_u_96c===%hu===%hu===\n",var1,var2);
  return i;
}

int short_x_1617c() {
  // { dg-printf "short_x_1617c===fffe===e235===" }
  short var1 = (short) (-2);
  short var2 = (short) (123445);
  int i = printf("short_x_1617c===%+hx===%+hx===\n",var1,var2);
  return i;
}

int short_x_1618c() {
  // { dg-printf "short_x_1618c===4===3===" }
  short var1 = (short) (4);
  short var2 = (short) (3);
  int i = printf("short_x_1618c===%+hX===%+hX===\n",var1,var2);
  return i;
}

int short_x_2377c() {
  // { dg-printf "short_x_2377c===0xfffa===0xfffb===" }
  short var1 = (short) (-6);
  short var2 = (short) (-5);
  int i = printf("short_x_2377c===%#hx===%#hx===\n",var1,var2);
  return i;
}

int short_x_2378c() {
  // { dg-printf "short_x_2378c===0XE235===0XFFFC===" }
  short var1 = (short) (123445);
  short var2 = (short) (-4);
  int i = printf("short_x_2378c===%#hX===%#hX===\n",var1,var2);
  return i;
}

int short_x_3137c() {
  // { dg-printf "short_x_3137c===8===3===" }
  short var1 = (short) (8);
  short var2 = (short) (3);
  int i = printf("short_x_3137c===%-+hx===%-+hx===\n",var1,var2);
  return i;
}

int short_x_3138c() {
  // { dg-printf "short_x_3138c===5===FFFE===" }
  short var1 = (short) (5);
  short var2 = (short) (-2);
  int i = printf("short_x_3138c===%-+hX===%-+hX===\n",var1,var2);
  return i;
}

int short_x_3897c() {
  // { dg-printf "short_x_3897c===         0===         1===" }
  short var1 = (short) (0);
  short var2 = (short) (1);
  int i = printf("short_x_3897c===% 10hx===% 10hx===\n",var1,var2);
  return i;
}

int short_x_3898c() {
  // { dg-printf "short_x_3898c===      FFFE===         3===" }
  short var1 = (short) (-2);
  short var2 = (short) (3);
  int i = printf("short_x_3898c===% 10hX===% 10hX===\n",var1,var2);
  return i;
}

int short_x_4657c() {
  // { dg-printf "short_x_4657c===0000000004===000000ffff===" }
  short var1 = (short) (4);
  short var2 = (short) (-1);
  int i = printf("short_x_4657c===%010hx===%010hx===\n",var1,var2);
  return i;
}

int short_x_4658c() {
  // { dg-printf "short_x_4658c===000000FFF8===000000FFFE===" }
  short var1 = (short) (-8);
  short var2 = (short) (-2);
  int i = printf("short_x_4658c===%010hX===%010hX===\n",var1,var2);
  return i;
}

int short_x_5417c() {
  // { dg-printf "short_x_5417c===ffff      ===fffb      ===" }
  short var1 = (short) (-1);
  short var2 = (short) (-5);
  int i = printf("short_x_5417c===%- 10hx===%- 10hx===\n",var1,var2);
  return i;
}

int short_x_5418c() {
  // { dg-printf "short_x_5418c===FFFC      ===FFFC      ===" }
  short var1 = (short) (-4);
  short var2 = (short) (-4);
  int i = printf("short_x_5418c===%- 10hX===%- 10hX===\n",var1,var2);
  return i;
}

int short_x_6177c() {
  // { dg-printf "short_x_6177c===      fffb===         7===" }
  short var1 = (short) (-5);
  short var2 = (short) (7);
  int i = printf("short_x_6177c===%+ 10hx===%+ 10hx===\n",var1,var2);
  return i;
}

int short_x_6178c() {
  // { dg-printf "short_x_6178c===      FFFE===      FFFC===" }
  short var1 = (short) (-2);
  short var2 = (short) (-4);
  int i = printf("short_x_6178c===%+ 10hX===%+ 10hX===\n",var1,var2);
  return i;
}

int short_x_6937c() {
  // { dg-printf "short_x_6937c===0000000005===000000fff8===" }
  short var1 = (short) (5);
  short var2 = (short) (-8);
  int i = printf("short_x_6937c===%+010hx===%+010hx===\n",var1,var2);
  return i;
}

int short_x_6938c() {
  // { dg-printf "short_x_6938c===000000FFF9===0000000007===" }
  short var1 = (short) (-7);
  short var2 = (short) (7);
  int i = printf("short_x_6938c===%+010hX===%+010hX===\n",var1,var2);
  return i;
}

int short_x_857c() {
  // { dg-printf "short_x_857c===8===fffe===" }
  short var1 = (short) (8);
  short var2 = (short) (-2);
  int i = printf("short_x_857c===%-hx===%-hx===\n",var1,var2);
  return i;
}

int short_x_858c() {
  // { dg-printf "short_x_858c===2===4===" }
  short var1 = (short) (2);
  short var2 = (short) (4);
  int i = printf("short_x_858c===%-hX===%-hX===\n",var1,var2);
  return i;
}

int short_x_97c() {
  // { dg-printf "short_x_97c===fffe===3===" }
  short var1 = (short) (-2);
  short var2 = (short) (3);
  int i = printf("short_x_97c===%hx===%hx===\n",var1,var2);
  return i;
}

int short_x_98c() {
  // { dg-printf "short_x_98c===E235===FFFE===" }
  short var1 = (short) (123445);
  short var2 = (short) (-2);
  int i = printf("short_x_98c===%hX===%hX===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = short_d_1613c();
i = short_d_2373c();
i = short_d_3133c();
i = short_d_3893c();
i = short_d_4653c();
i = short_d_5413c();
i = short_d_6173c();
i = short_d_6933c();
i = short_d_853c();
i = short_d_93c();
i = short_i_1614c();
i = short_i_2374c();
i = short_i_3134c();
i = short_i_3894c();
i = short_i_4654c();
i = short_i_5414c();
i = short_i_6174c();
i = short_i_6934c();
i = short_i_854c();
i = short_i_94c();
i = short_o_1615c();
i = short_o_2375c();
i = short_o_3135c();
i = short_o_3895c();
i = short_o_4655c();
i = short_o_5415c();
i = short_o_6175c();
i = short_o_6935c();
i = short_o_855c();
i = short_o_95c();
i = short_u_1616c();
i = short_u_2376c();
i = short_u_3136c();
i = short_u_3896c();
i = short_u_4656c();
i = short_u_5416c();
i = short_u_6176c();
i = short_u_6936c();
i = short_u_856c();
i = short_u_96c();
i = short_x_1617c();
i = short_x_1618c();
i = short_x_2377c();
i = short_x_2378c();
i = short_x_3137c();
i = short_x_3138c();
i = short_x_3897c();
i = short_x_3898c();
i = short_x_4657c();
i = short_x_4658c();
i = short_x_5417c();
i = short_x_5418c();
i = short_x_6177c();
i = short_x_6178c();
i = short_x_6937c();
i = short_x_6938c();
i = short_x_857c();
i = short_x_858c();
i = short_x_97c();
i = short_x_98c();
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
