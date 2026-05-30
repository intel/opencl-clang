/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/int2.c'  */

int int2_d_1757c() {
  // { dg-printf "int2_d_1757c===-7,+123445===+5,-8===" }
  int2 var1 = (int2) (-7,123445);
  int2 var2 = (int2) (5,-8);
  int i = printf("int2_d_1757c===%+v2hld===%+v2hld===\n",var1,var2);
  return i;
}

int int2_d_237c() {
  // { dg-printf "int2_d_237c===-3,-3===-4,7===" }
  int2 var1 = (int2) (-3,-3);
  int2 var2 = (int2) (-4,7);
  int i = printf("int2_d_237c===%v2hld===%v2hld===\n",var1,var2);
  return i;
}

int int2_d_2517c() {
  // { dg-printf "int2_d_2517c===-2,3===-8,-123455===" }
  int2 var1 = (int2) (-2,3);
  int2 var2 = (int2) (-8,-123455);
  int i = printf("int2_d_2517c===%#v2hld===%#v2hld===\n",var1,var2);
  return i;
}

int int2_d_3277c() {
  // { dg-printf "int2_d_3277c===-1,+1===-1,+4===" }
  int2 var1 = (int2) (-1,1);
  int2 var2 = (int2) (-1,4);
  int i = printf("int2_d_3277c===%-+v2hld===%-+v2hld===\n",var1,var2);
  return i;
}

int int2_d_4037c() {
  // { dg-printf "int2_d_4037c===        -6,        -2===        -3,        -7===" }
  int2 var1 = (int2) (-6,-2);
  int2 var2 = (int2) (-3,-7);
  int i = printf("int2_d_4037c===% 10v2hld===% 10v2hld===\n",var1,var2);
  return i;
}

int int2_d_4797c() {
  // { dg-printf "int2_d_4797c===-000000007,-000000005===-000000003,0000000001===" }
  int2 var1 = (int2) (-7,-5);
  int2 var2 = (int2) (-3,1);
  int i = printf("int2_d_4797c===%010v2hld===%010v2hld===\n",var1,var2);
  return i;
}

int int2_d_5557c() {
  // { dg-printf "int2_d_5557c===-7        ,-6        === 7        ,-8        ===" }
  int2 var1 = (int2) (-7,-6);
  int2 var2 = (int2) (7,-8);
  int i = printf("int2_d_5557c===%- 10v2hld===%- 10v2hld===\n",var1,var2);
  return i;
}

int int2_d_6317c() {
  // { dg-printf "int2_d_6317c===        -1,        -3===   -123455,        +7===" }
  int2 var1 = (int2) (-1,-3);
  int2 var2 = (int2) (-123455,7);
  int i = printf("int2_d_6317c===%+ 10v2hld===%+ 10v2hld===\n",var1,var2);
  return i;
}

int int2_d_7077c() {
  // { dg-printf "int2_d_7077c===-000000001,+000000000===-000000005,-000000005===" }
  int2 var1 = (int2) (-1,0);
  int2 var2 = (int2) (-5,-5);
  int i = printf("int2_d_7077c===%+010v2hld===%+010v2hld===\n",var1,var2);
  return i;
}

int int2_d_997c() {
  // { dg-printf "int2_d_997c===4,4===8,5===" }
  int2 var1 = (int2) (4,4);
  int2 var2 = (int2) (8,5);
  int i = printf("int2_d_997c===%-v2hld===%-v2hld===\n",var1,var2);
  return i;
}

int int2_i_1758c() {
  // { dg-printf "int2_i_1758c===+6,-5===+4,-3===" }
  int2 var1 = (int2) (6,-5);
  int2 var2 = (int2) (4,-3);
  int i = printf("int2_i_1758c===%+v2hli===%+v2hli===\n",var1,var2);
  return i;
}

int int2_i_238c() {
  // { dg-printf "int2_i_238c===-7,123445===-123455,-123455===" }
  int2 var1 = (int2) (-7,123445);
  int2 var2 = (int2) (-123455,-123455);
  int i = printf("int2_i_238c===%v2hli===%v2hli===\n",var1,var2);
  return i;
}

int int2_i_2518c() {
  // { dg-printf "int2_i_2518c===-4,5===8,-8===" }
  int2 var1 = (int2) (-4,5);
  int2 var2 = (int2) (8,-8);
  int i = printf("int2_i_2518c===%#v2hli===%#v2hli===\n",var1,var2);
  return i;
}

int int2_i_3278c() {
  // { dg-printf "int2_i_3278c===+5,+2===+4,-8===" }
  int2 var1 = (int2) (5,2);
  int2 var2 = (int2) (4,-8);
  int i = printf("int2_i_3278c===%-+v2hli===%-+v2hli===\n",var1,var2);
  return i;
}

int int2_i_4038c() {
  // { dg-printf "int2_i_4038c===        -4,         7===         5,        -5===" }
  int2 var1 = (int2) (-4,7);
  int2 var2 = (int2) (5,-5);
  int i = printf("int2_i_4038c===% 10v2hli===% 10v2hli===\n",var1,var2);
  return i;
}

int int2_i_4798c() {
  // { dg-printf "int2_i_4798c===-000000007,0000000005===0000000004,-000000006===" }
  int2 var1 = (int2) (-7,5);
  int2 var2 = (int2) (4,-6);
  int i = printf("int2_i_4798c===%010v2hli===%010v2hli===\n",var1,var2);
  return i;
}

int int2_i_5558c() {
  // { dg-printf "int2_i_5558c=== 3        , 4        === 8        , 5        ===" }
  int2 var1 = (int2) (3,4);
  int2 var2 = (int2) (8,5);
  int i = printf("int2_i_5558c===%- 10v2hli===%- 10v2hli===\n",var1,var2);
  return i;
}

int int2_i_6318c() {
  // { dg-printf "int2_i_6318c===        -4,        -1===        +1,        +4===" }
  int2 var1 = (int2) (-4,-1);
  int2 var2 = (int2) (1,4);
  int i = printf("int2_i_6318c===%+ 10v2hli===%+ 10v2hli===\n",var1,var2);
  return i;
}

int int2_i_7078c() {
  // { dg-printf "int2_i_7078c===+000000000,-000000006===+000000004,+000000007===" }
  int2 var1 = (int2) (0,-6);
  int2 var2 = (int2) (4,7);
  int i = printf("int2_i_7078c===%+010v2hli===%+010v2hli===\n",var1,var2);
  return i;
}

int int2_i_998c() {
  // { dg-printf "int2_i_998c===-1,-2===-2,6===" }
  int2 var1 = (int2) (-1,-2);
  int2 var2 = (int2) (-2,6);
  int i = printf("int2_i_998c===%-v2hli===%-v2hli===\n",var1,var2);
  return i;
}

int int2_o_1759c() {
  // { dg-printf "int2_o_1759c===37777777770,6===37777777770,3===" }
  int2 var1 = (int2) (-8,6);
  int2 var2 = (int2) (-8,3);
  int i = printf("int2_o_1759c===%+v2hlo===%+v2hlo===\n",var1,var2);
  return i;
}

int int2_o_239c() {
  // { dg-printf "int2_o_239c===10,361065===37777777774,37777777777===" }
  int2 var1 = (int2) (8,123445);
  int2 var2 = (int2) (-4,-1);
  int i = printf("int2_o_239c===%v2hlo===%v2hlo===\n",var1,var2);
  return i;
}

int int2_o_2519c() {
  // { dg-printf "int2_o_2519c===04,037777777772===037777777776,037777777772===" }
  int2 var1 = (int2) (4,-6);
  int2 var2 = (int2) (-2,-6);
  int i = printf("int2_o_2519c===%#v2hlo===%#v2hlo===\n",var1,var2);
  return i;
}

int int2_o_3279c() {
  // { dg-printf "int2_o_3279c===6,37777777777===5,37777777776===" }
  int2 var1 = (int2) (6,-1);
  int2 var2 = (int2) (5,-2);
  int i = printf("int2_o_3279c===%-+v2hlo===%-+v2hlo===\n",var1,var2);
  return i;
}

int int2_o_4039c() {
  // { dg-printf "int2_o_4039c===37777777770,37777777772===         5,         4===" }
  int2 var1 = (int2) (-8,-6);
  int2 var2 = (int2) (5,4);
  int i = printf("int2_o_4039c===% 10v2hlo===% 10v2hlo===\n",var1,var2);
  return i;
}

int int2_o_4799c() {
  // { dg-printf "int2_o_4799c===0000000001,37777777774===0000000000,37777777777===" }
  int2 var1 = (int2) (1,-4);
  int2 var2 = (int2) (0,-1);
  int i = printf("int2_o_4799c===%010v2hlo===%010v2hlo===\n",var1,var2);
  return i;
}

int int2_o_5559c() {
  // { dg-printf "int2_o_5559c===7         ,0         ===361065    ,3         ===" }
  int2 var1 = (int2) (7,0);
  int2 var2 = (int2) (123445,3);
  int i = printf("int2_o_5559c===%- 10v2hlo===%- 10v2hlo===\n",var1,var2);
  return i;
}

int int2_o_6319c() {
  // { dg-printf "int2_o_6319c===    361065,37777777776===37777416701,37777777773===" }
  int2 var1 = (int2) (123445,-2);
  int2 var2 = (int2) (-123455,-5);
  int i = printf("int2_o_6319c===%+ 10v2hlo===%+ 10v2hlo===\n",var1,var2);
  return i;
}

int int2_o_7079c() {
  // { dg-printf "int2_o_7079c===0000000006,0000000007===0000000005,0000000001===" }
  int2 var1 = (int2) (6,7);
  int2 var2 = (int2) (5,1);
  int i = printf("int2_o_7079c===%+010v2hlo===%+010v2hlo===\n",var1,var2);
  return i;
}

int int2_o_999c() {
  // { dg-printf "int2_o_999c===361065,0===37777777770,37777777774===" }
  int2 var1 = (int2) (123445,0);
  int2 var2 = (int2) (-8,-4);
  int i = printf("int2_o_999c===%-v2hlo===%-v2hlo===\n",var1,var2);
  return i;
}

int int2_u_1000c() {
  // { dg-printf "int2_u_1000c===4294967292,7===3,4===" }
  int2 var1 = (int2) (-4,7);
  int2 var2 = (int2) (3,4);
  int i = printf("int2_u_1000c===%-v2hlu===%-v2hlu===\n",var1,var2);
  return i;
}

int int2_u_1760c() {
  // { dg-printf "int2_u_1760c===1,4294967292===4294967290,1===" }
  int2 var1 = (int2) (1,-4);
  int2 var2 = (int2) (-6,1);
  int i = printf("int2_u_1760c===%+v2hlu===%+v2hlu===\n",var1,var2);
  return i;
}

int int2_u_240c() {
  // { dg-printf "int2_u_240c===4294967291,8===4,4294843841===" }
  int2 var1 = (int2) (-5,8);
  int2 var2 = (int2) (4,-123455);
  int i = printf("int2_u_240c===%v2hlu===%v2hlu===\n",var1,var2);
  return i;
}

int int2_u_2520c() {
  // { dg-printf "int2_u_2520c===4294967293,4294967291===6,6===" }
  int2 var1 = (int2) (-3,-5);
  int2 var2 = (int2) (6,6);
  int i = printf("int2_u_2520c===%#v2hlu===%#v2hlu===\n",var1,var2);
  return i;
}

int int2_u_3280c() {
  // { dg-printf "int2_u_3280c===4294967292,3===4294967293,8===" }
  int2 var1 = (int2) (-4,3);
  int2 var2 = (int2) (-3,8);
  int i = printf("int2_u_3280c===%-+v2hlu===%-+v2hlu===\n",var1,var2);
  return i;
}

int int2_u_4040c() {
  // { dg-printf "int2_u_4040c===    123445,4294967293===4294967294,4294967294===" }
  int2 var1 = (int2) (123445,-3);
  int2 var2 = (int2) (-2,-2);
  int i = printf("int2_u_4040c===% 10v2hlu===% 10v2hlu===\n",var1,var2);
  return i;
}

int int2_u_4800c() {
  // { dg-printf "int2_u_4800c===4294967292,4294843841===4294967290,4294967291===" }
  int2 var1 = (int2) (-4,-123455);
  int2 var2 = (int2) (-6,-5);
  int i = printf("int2_u_4800c===%010v2hlu===%010v2hlu===\n",var1,var2);
  return i;
}

int int2_u_5560c() {
  // { dg-printf "int2_u_5560c===4294967289,1         ===0         ,2         ===" }
  int2 var1 = (int2) (-7,1);
  int2 var2 = (int2) (0,2);
  int i = printf("int2_u_5560c===%- 10v2hlu===%- 10v2hlu===\n",var1,var2);
  return i;
}

int int2_u_6320c() {
  // { dg-printf "int2_u_6320c===         5,         2===4294967291,4294967291===" }
  int2 var1 = (int2) (5,2);
  int2 var2 = (int2) (-5,-5);
  int i = printf("int2_u_6320c===%+ 10v2hlu===%+ 10v2hlu===\n",var1,var2);
  return i;
}

int int2_u_7080c() {
  // { dg-printf "int2_u_7080c===4294967292,4294967294===0000123445,4294967293===" }
  int2 var1 = (int2) (-4,-2);
  int2 var2 = (int2) (123445,-3);
  int i = printf("int2_u_7080c===%+010v2hlu===%+010v2hlu===\n",var1,var2);
  return i;
}

int int2_x_1001c() {
  // { dg-printf "int2_x_1001c===fffffffe,fffffff8===fffffffb,2===" }
  int2 var1 = (int2) (-2,-8);
  int2 var2 = (int2) (-5,2);
  int i = printf("int2_x_1001c===%-v2hlx===%-v2hlx===\n",var1,var2);
  return i;
}

int int2_x_1002c() {
  // { dg-printf "int2_x_1002c===FFFFFFFA,3===7,FFFFFFFC===" }
  int2 var1 = (int2) (-6,3);
  int2 var2 = (int2) (7,-4);
  int i = printf("int2_x_1002c===%-v2hlX===%-v2hlX===\n",var1,var2);
  return i;
}

int int2_x_1761c() {
  // { dg-printf "int2_x_1761c===4,fffffff8===fffffff8,fffffffb===" }
  int2 var1 = (int2) (4,-8);
  int2 var2 = (int2) (-8,-5);
  int i = printf("int2_x_1761c===%+v2hlx===%+v2hlx===\n",var1,var2);
  return i;
}

int int2_x_1762c() {
  // { dg-printf "int2_x_1762c===4,FFFFFFFC===0,FFFFFFFD===" }
  int2 var1 = (int2) (4,-4);
  int2 var2 = (int2) (0,-3);
  int i = printf("int2_x_1762c===%+v2hlX===%+v2hlX===\n",var1,var2);
  return i;
}

int int2_x_241c() {
  // { dg-printf "int2_x_241c===8,4===fffffff9,fffffffd===" }
  int2 var1 = (int2) (8,4);
  int2 var2 = (int2) (-7,-3);
  int i = printf("int2_x_241c===%v2hlx===%v2hlx===\n",var1,var2);
  return i;
}

int int2_x_242c() {
  // { dg-printf "int2_x_242c===FFFFFFFA,1E235===FFFFFFFD,6===" }
  int2 var1 = (int2) (-6,123445);
  int2 var2 = (int2) (-3,6);
  int i = printf("int2_x_242c===%v2hlX===%v2hlX===\n",var1,var2);
  return i;
}

int int2_x_2521c() {
  // { dg-printf "int2_x_2521c===0x6,0xfffffff9===0xfffe1dc1,0xfffffffd===" }
  int2 var1 = (int2) (6,-7);
  int2 var2 = (int2) (-123455,-3);
  int i = printf("int2_x_2521c===%#v2hlx===%#v2hlx===\n",var1,var2);
  return i;
}

int int2_x_2522c() {
  // { dg-printf "int2_x_2522c===0XFFFFFFF8,0X4===0X8,0XFFFFFFF8===" }
  int2 var1 = (int2) (-8,4);
  int2 var2 = (int2) (8,-8);
  int i = printf("int2_x_2522c===%#v2hlX===%#v2hlX===\n",var1,var2);
  return i;
}

int int2_x_3281c() {
  // { dg-printf "int2_x_3281c===4,fffffffe===1e235,fffe1dc1===" }
  int2 var1 = (int2) (4,-2);
  int2 var2 = (int2) (123445,-123455);
  int i = printf("int2_x_3281c===%-+v2hlx===%-+v2hlx===\n",var1,var2);
  return i;
}

int int2_x_3282c() {
  // { dg-printf "int2_x_3282c===FFFFFFFF,7===FFFFFFF8,FFFFFFFC===" }
  int2 var1 = (int2) (-1,7);
  int2 var2 = (int2) (-8,-4);
  int i = printf("int2_x_3282c===%-+v2hlX===%-+v2hlX===\n",var1,var2);
  return i;
}

int int2_x_4041c() {
  // { dg-printf "int2_x_4041c===         1,  fffffff8===  fffffff8,     1e235===" }
  int2 var1 = (int2) (1,-8);
  int2 var2 = (int2) (-8,123445);
  int i = printf("int2_x_4041c===% 10v2hlx===% 10v2hlx===\n",var1,var2);
  return i;
}

int int2_x_4042c() {
  // { dg-printf "int2_x_4042c===         8,  FFFFFFFE===         6,  FFFFFFFD===" }
  int2 var1 = (int2) (8,-2);
  int2 var2 = (int2) (6,-3);
  int i = printf("int2_x_4042c===% 10v2hlX===% 10v2hlX===\n",var1,var2);
  return i;
}

int int2_x_4801c() {
  // { dg-printf "int2_x_4801c===0000000006,00fffffffb===0000000005,0000000007===" }
  int2 var1 = (int2) (6,-5);
  int2 var2 = (int2) (5,7);
  int i = printf("int2_x_4801c===%010v2hlx===%010v2hlx===\n",var1,var2);
  return i;
}

int int2_x_4802c() {
  // { dg-printf "int2_x_4802c===0000000004,0000000007===0000000001,00FFFFFFFC===" }
  int2 var1 = (int2) (4,7);
  int2 var2 = (int2) (1,-4);
  int i = printf("int2_x_4802c===%010v2hlX===%010v2hlX===\n",var1,var2);
  return i;
}

int int2_x_5561c() {
  // { dg-printf "int2_x_5561c===fffffffd  ,2         ===fffffffb  ,7         ===" }
  int2 var1 = (int2) (-3,2);
  int2 var2 = (int2) (-5,7);
  int i = printf("int2_x_5561c===%- 10v2hlx===%- 10v2hlx===\n",var1,var2);
  return i;
}

int int2_x_5562c() {
  // { dg-printf "int2_x_5562c===1         ,1         ===6         ,FFFFFFFB  ===" }
  int2 var1 = (int2) (1,1);
  int2 var2 = (int2) (6,-5);
  int i = printf("int2_x_5562c===%- 10v2hlX===%- 10v2hlX===\n",var1,var2);
  return i;
}

int int2_x_6321c() {
  // { dg-printf "int2_x_6321c===  fffffffc,  fffffffc===     1e235,     1e235===" }
  int2 var1 = (int2) (-4,-4);
  int2 var2 = (int2) (123445,123445);
  int i = printf("int2_x_6321c===%+ 10v2hlx===%+ 10v2hlx===\n",var1,var2);
  return i;
}

int int2_x_6322c() {
  // { dg-printf "int2_x_6322c===         0,  FFFE1DC1===     1E235,         2===" }
  int2 var1 = (int2) (0,-123455);
  int2 var2 = (int2) (123445,2);
  int i = printf("int2_x_6322c===%+ 10v2hlX===%+ 10v2hlX===\n",var1,var2);
  return i;
}

int int2_x_7081c() {
  // { dg-printf "int2_x_7081c===00fffffff8,00fffffff9===0000000006,0000000006===" }
  int2 var1 = (int2) (-8,-7);
  int2 var2 = (int2) (6,6);
  int i = printf("int2_x_7081c===%+010v2hlx===%+010v2hlx===\n",var1,var2);
  return i;
}

int int2_x_7082c() {
  // { dg-printf "int2_x_7082c===0000000000,00FFFFFFFA===0000000008,0000000002===" }
  int2 var1 = (int2) (0,-6);
  int2 var2 = (int2) (8,2);
  int i = printf("int2_x_7082c===%+010v2hlX===%+010v2hlX===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = int2_d_1757c();
i = int2_d_237c();
i = int2_d_2517c();
i = int2_d_3277c();
i = int2_d_4037c();
i = int2_d_4797c();
i = int2_d_5557c();
i = int2_d_6317c();
i = int2_d_7077c();
i = int2_d_997c();
i = int2_i_1758c();
i = int2_i_238c();
i = int2_i_2518c();
i = int2_i_3278c();
i = int2_i_4038c();
i = int2_i_4798c();
i = int2_i_5558c();
i = int2_i_6318c();
i = int2_i_7078c();
i = int2_i_998c();
i = int2_o_1759c();
i = int2_o_239c();
i = int2_o_2519c();
i = int2_o_3279c();
i = int2_o_4039c();
i = int2_o_4799c();
i = int2_o_5559c();
i = int2_o_6319c();
i = int2_o_7079c();
i = int2_o_999c();
i = int2_u_1000c();
i = int2_u_1760c();
i = int2_u_240c();
i = int2_u_2520c();
i = int2_u_3280c();
i = int2_u_4040c();
i = int2_u_4800c();
i = int2_u_5560c();
i = int2_u_6320c();
i = int2_u_7080c();
i = int2_x_1001c();
i = int2_x_1002c();
i = int2_x_1761c();
i = int2_x_1762c();
i = int2_x_241c();
i = int2_x_242c();
i = int2_x_2521c();
i = int2_x_2522c();
i = int2_x_3281c();
i = int2_x_3282c();
i = int2_x_4041c();
i = int2_x_4042c();
i = int2_x_4801c();
i = int2_x_4802c();
i = int2_x_5561c();
i = int2_x_5562c();
i = int2_x_6321c();
i = int2_x_6322c();
i = int2_x_7081c();
i = int2_x_7082c();
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
