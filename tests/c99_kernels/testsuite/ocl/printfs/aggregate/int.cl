/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/int.c'  */

int int_d_1c() {
  // { dg-printf "int_d_1c===-1===0===" }
  int var1 = (int) (-1);
  int var2 = (int) (0);
  int i = printf("int_d_1c===%d===%d===\n",var1,var2);
  return i;
}

int int_d_1521c() {
  // { dg-printf "int_d_1521c===-6===-8===" }
  int var1 = (int) (-6);
  int var2 = (int) (-8);
  int i = printf("int_d_1521c===%+d===%+d===\n",var1,var2);
  return i;
}

int int_d_2281c() {
  // { dg-printf "int_d_2281c===2===-1===" }
  int var1 = (int) (2);
  int var2 = (int) (-1);
  int i = printf("int_d_2281c===%#d===%#d===\n",var1,var2);
  return i;
}

int int_d_3041c() {
  // { dg-printf "int_d_3041c===-4===-4===" }
  int var1 = (int) (-4);
  int var2 = (int) (-4);
  int i = printf("int_d_3041c===%-+d===%-+d===\n",var1,var2);
  return i;
}

int int_d_3801c() {
  // { dg-printf "int_d_3801c===        -6===        -3===" }
  int var1 = (int) (-6);
  int var2 = (int) (-3);
  int i = printf("int_d_3801c===% 10d===% 10d===\n",var1,var2);
  return i;
}

int int_d_4561c() {
  // { dg-printf "int_d_4561c===-000000001===-000000008===" }
  int var1 = (int) (-1);
  int var2 = (int) (-8);
  int i = printf("int_d_4561c===%010d===%010d===\n",var1,var2);
  return i;
}

int int_d_5321c() {
  // { dg-printf "int_d_5321c===-3        ===-3        ===" }
  int var1 = (int) (-3);
  int var2 = (int) (-3);
  int i = printf("int_d_5321c===%- 10d===%- 10d===\n",var1,var2);
  return i;
}

int int_d_6081c() {
  // { dg-printf "int_d_6081c===        +1===        -6===" }
  int var1 = (int) (1);
  int var2 = (int) (-6);
  int i = printf("int_d_6081c===%+ 10d===%+ 10d===\n",var1,var2);
  return i;
}

int int_d_6841c() {
  // { dg-printf "int_d_6841c===+000000005===+000123445===" }
  int var1 = (int) (5);
  int var2 = (int) (123445);
  int i = printf("int_d_6841c===%+010d===%+010d===\n",var1,var2);
  return i;
}

int int_d_761c() {
  // { dg-printf "int_d_761c===2===4===" }
  int var1 = (int) (2);
  int var2 = (int) (4);
  int i = printf("int_d_761c===%-d===%-d===\n",var1,var2);
  return i;
}

int int_i_1522c() {
  // { dg-printf "int_i_1522c===-5===-7===" }
  int var1 = (int) (-5);
  int var2 = (int) (-7);
  int i = printf("int_i_1522c===%+i===%+i===\n",var1,var2);
  return i;
}

int int_i_2c() {
  // { dg-printf "int_i_2c===-4===-2===" }
  int var1 = (int) (-4);
  int var2 = (int) (-2);
  int i = printf("int_i_2c===%i===%i===\n",var1,var2);
  return i;
}

int int_i_2282c() {
  // { dg-printf "int_i_2282c===6===-7===" }
  int var1 = (int) (6);
  int var2 = (int) (-7);
  int i = printf("int_i_2282c===%#i===%#i===\n",var1,var2);
  return i;
}

int int_i_3042c() {
  // { dg-printf "int_i_3042c===-5===+4===" }
  int var1 = (int) (-5);
  int var2 = (int) (4);
  int i = printf("int_i_3042c===%-+i===%-+i===\n",var1,var2);
  return i;
}

int int_i_3802c() {
  // { dg-printf "int_i_3802c===         4===        -4===" }
  int var1 = (int) (4);
  int var2 = (int) (-4);
  int i = printf("int_i_3802c===% 10i===% 10i===\n",var1,var2);
  return i;
}

int int_i_4562c() {
  // { dg-printf "int_i_4562c===-000000008===0000000002===" }
  int var1 = (int) (-8);
  int var2 = (int) (2);
  int i = printf("int_i_4562c===%010i===%010i===\n",var1,var2);
  return i;
}

int int_i_5322c() {
  // { dg-printf "int_i_5322c=== 6        ===-1        ===" }
  int var1 = (int) (6);
  int var2 = (int) (-1);
  int i = printf("int_i_5322c===%- 10i===%- 10i===\n",var1,var2);
  return i;
}

int int_i_6082c() {
  // { dg-printf "int_i_6082c===        +5===        +6===" }
  int var1 = (int) (5);
  int var2 = (int) (6);
  int i = printf("int_i_6082c===%+ 10i===%+ 10i===\n",var1,var2);
  return i;
}

int int_i_6842c() {
  // { dg-printf "int_i_6842c===-000000003===-000000004===" }
  int var1 = (int) (-3);
  int var2 = (int) (-4);
  int i = printf("int_i_6842c===%+010i===%+010i===\n",var1,var2);
  return i;
}

int int_i_762c() {
  // { dg-printf "int_i_762c===-8===1===" }
  int var1 = (int) (-8);
  int var2 = (int) (1);
  int i = printf("int_i_762c===%-i===%-i===\n",var1,var2);
  return i;
}

int int_o_1523c() {
  // { dg-printf "int_o_1523c===7===37777777772===" }
  int var1 = (int) (7);
  int var2 = (int) (-6);
  int i = printf("int_o_1523c===%+o===%+o===\n",var1,var2);
  return i;
}

int int_o_2283c() {
  // { dg-printf "int_o_2283c===07===010===" }
  int var1 = (int) (7);
  int var2 = (int) (8);
  int i = printf("int_o_2283c===%#o===%#o===\n",var1,var2);
  return i;
}

int int_o_3c() {
  // { dg-printf "int_o_3c===3===37777416701===" }
  int var1 = (int) (3);
  int var2 = (int) (-123455);
  int i = printf("int_o_3c===%o===%o===\n",var1,var2);
  return i;
}

int int_o_3043c() {
  // { dg-printf "int_o_3043c===7===1===" }
  int var1 = (int) (7);
  int var2 = (int) (1);
  int i = printf("int_o_3043c===%-+o===%-+o===\n",var1,var2);
  return i;
}

int int_o_3803c() {
  // { dg-printf "int_o_3803c===37777777776===37777777774===" }
  int var1 = (int) (-2);
  int var2 = (int) (-4);
  int i = printf("int_o_3803c===% 10o===% 10o===\n",var1,var2);
  return i;
}

int int_o_4563c() {
  // { dg-printf "int_o_4563c===0000000006===0000000005===" }
  int var1 = (int) (6);
  int var2 = (int) (5);
  int i = printf("int_o_4563c===%010o===%010o===\n",var1,var2);
  return i;
}

int int_o_5323c() {
  // { dg-printf "int_o_5323c===0         ===37777777775===" }
  int var1 = (int) (0);
  int var2 = (int) (-3);
  int i = printf("int_o_5323c===%- 10o===%- 10o===\n",var1,var2);
  return i;
}

int int_o_6083c() {
  // { dg-printf "int_o_6083c===         0===37777777777===" }
  int var1 = (int) (0);
  int var2 = (int) (-1);
  int i = printf("int_o_6083c===%+ 10o===%+ 10o===\n",var1,var2);
  return i;
}

int int_o_6843c() {
  // { dg-printf "int_o_6843c===0000361065===37777777772===" }
  int var1 = (int) (123445);
  int var2 = (int) (-6);
  int i = printf("int_o_6843c===%+010o===%+010o===\n",var1,var2);
  return i;
}

int int_o_763c() {
  // { dg-printf "int_o_763c===6===0===" }
  int var1 = (int) (6);
  int var2 = (int) (0);
  int i = printf("int_o_763c===%-o===%-o===\n",var1,var2);
  return i;
}

int int_u_1524c() {
  // { dg-printf "int_u_1524c===6===0===" }
  int var1 = (int) (6);
  int var2 = (int) (0);
  int i = printf("int_u_1524c===%+u===%+u===\n",var1,var2);
  return i;
}

int int_u_2284c() {
  // { dg-printf "int_u_2284c===4294967293===6===" }
  int var1 = (int) (-3);
  int var2 = (int) (6);
  int i = printf("int_u_2284c===%#u===%#u===\n",var1,var2);
  return i;
}

int int_u_3044c() {
  // { dg-printf "int_u_3044c===4294967289===4294967290===" }
  int var1 = (int) (-7);
  int var2 = (int) (-6);
  int i = printf("int_u_3044c===%-+u===%-+u===\n",var1,var2);
  return i;
}

int int_u_3804c() {
  // { dg-printf "int_u_3804c===         2===4294967294===" }
  int var1 = (int) (2);
  int var2 = (int) (-2);
  int i = printf("int_u_3804c===% 10u===% 10u===\n",var1,var2);
  return i;
}

int int_u_4c() {
  // { dg-printf "int_u_4c===4294967290===8===" }
  int var1 = (int) (-6);
  int var2 = (int) (8);
  int i = printf("int_u_4c===%u===%u===\n",var1,var2);
  return i;
}

int int_u_4564c() {
  // { dg-printf "int_u_4564c===4294967289===4294967294===" }
  int var1 = (int) (-7);
  int var2 = (int) (-2);
  int i = printf("int_u_4564c===%010u===%010u===\n",var1,var2);
  return i;
}

int int_u_5324c() {
  // { dg-printf "int_u_5324c===4294967290===8         ===" }
  int var1 = (int) (-6);
  int var2 = (int) (8);
  int i = printf("int_u_5324c===%- 10u===%- 10u===\n",var1,var2);
  return i;
}

int int_u_6084c() {
  // { dg-printf "int_u_6084c===         6===         1===" }
  int var1 = (int) (6);
  int var2 = (int) (1);
  int i = printf("int_u_6084c===%+ 10u===%+ 10u===\n",var1,var2);
  return i;
}

int int_u_6844c() {
  // { dg-printf "int_u_6844c===0000123445===4294967291===" }
  int var1 = (int) (123445);
  int var2 = (int) (-5);
  int i = printf("int_u_6844c===%+010u===%+010u===\n",var1,var2);
  return i;
}

int int_u_764c() {
  // { dg-printf "int_u_764c===4294967292===4294843841===" }
  int var1 = (int) (-4);
  int var2 = (int) (-123455);
  int i = printf("int_u_764c===%-u===%-u===\n",var1,var2);
  return i;
}

int int_x_1525c() {
  // { dg-printf "int_x_1525c===2===4===" }
  int var1 = (int) (2);
  int var2 = (int) (4);
  int i = printf("int_x_1525c===%+x===%+x===\n",var1,var2);
  return i;
}

int int_x_1526c() {
  // { dg-printf "int_x_1526c===8===FFFFFFFF===" }
  int var1 = (int) (8);
  int var2 = (int) (-1);
  int i = printf("int_x_1526c===%+X===%+X===\n",var1,var2);
  return i;
}

int int_x_2285c() {
  // { dg-printf "int_x_2285c===0x2===0x5===" }
  int var1 = (int) (2);
  int var2 = (int) (5);
  int i = printf("int_x_2285c===%#x===%#x===\n",var1,var2);
  return i;
}

int int_x_2286c() {
  // { dg-printf "int_x_2286c===0XFFFFFFFE===0XFFFFFFFD===" }
  int var1 = (int) (-2);
  int var2 = (int) (-3);
  int i = printf("int_x_2286c===%#X===%#X===\n",var1,var2);
  return i;
}

int int_x_3045c() {
  // { dg-printf "int_x_3045c===fffffffa===fffffffd===" }
  int var1 = (int) (-6);
  int var2 = (int) (-3);
  int i = printf("int_x_3045c===%-+x===%-+x===\n",var1,var2);
  return i;
}

int int_x_3046c() {
  // { dg-printf "int_x_3046c===7===FFFFFFFB===" }
  int var1 = (int) (7);
  int var2 = (int) (-5);
  int i = printf("int_x_3046c===%-+X===%-+X===\n",var1,var2);
  return i;
}

int int_x_3805c() {
  // { dg-printf "int_x_3805c===  fffffffb===  fffffffd===" }
  int var1 = (int) (-5);
  int var2 = (int) (-3);
  int i = printf("int_x_3805c===% 10x===% 10x===\n",var1,var2);
  return i;
}

int int_x_3806c() {
  // { dg-printf "int_x_3806c===         6===         2===" }
  int var1 = (int) (6);
  int var2 = (int) (2);
  int i = printf("int_x_3806c===% 10X===% 10X===\n",var1,var2);
  return i;
}

int int_x_4565c() {
  // { dg-printf "int_x_4565c===00fffffffd===0000000005===" }
  int var1 = (int) (-3);
  int var2 = (int) (5);
  int i = printf("int_x_4565c===%010x===%010x===\n",var1,var2);
  return i;
}

int int_x_4566c() {
  // { dg-printf "int_x_4566c===0000000008===0000000002===" }
  int var1 = (int) (8);
  int var2 = (int) (2);
  int i = printf("int_x_4566c===%010X===%010X===\n",var1,var2);
  return i;
}

int int_x_5c() {
  // { dg-printf "int_x_5c===5===ffffffff===" }
  int var1 = (int) (5);
  int var2 = (int) (-1);
  int i = printf("int_x_5c===%x===%x===\n",var1,var2);
  return i;
}

int int_x_5325c() {
  // { dg-printf "int_x_5325c===1         ===fffe1dc1  ===" }
  int var1 = (int) (1);
  int var2 = (int) (-123455);
  int i = printf("int_x_5325c===%- 10x===%- 10x===\n",var1,var2);
  return i;
}

int int_x_5326c() {
  // { dg-printf "int_x_5326c===6         ===FFFFFFF8  ===" }
  int var1 = (int) (6);
  int var2 = (int) (-8);
  int i = printf("int_x_5326c===%- 10X===%- 10X===\n",var1,var2);
  return i;
}

int int_x_6c() {
  // { dg-printf "int_x_6c===5===3===" }
  int var1 = (int) (5);
  int var2 = (int) (3);
  int i = printf("int_x_6c===%X===%X===\n",var1,var2);
  return i;
}

int int_x_6085c() {
  // { dg-printf "int_x_6085c===  fffffffd===         0===" }
  int var1 = (int) (-3);
  int var2 = (int) (0);
  int i = printf("int_x_6085c===%+ 10x===%+ 10x===\n",var1,var2);
  return i;
}

int int_x_6086c() {
  // { dg-printf "int_x_6086c===         3===         1===" }
  int var1 = (int) (3);
  int var2 = (int) (1);
  int i = printf("int_x_6086c===%+ 10X===%+ 10X===\n",var1,var2);
  return i;
}

int int_x_6845c() {
  // { dg-printf "int_x_6845c===00fffffffa===0000000003===" }
  int var1 = (int) (-6);
  int var2 = (int) (3);
  int i = printf("int_x_6845c===%+010x===%+010x===\n",var1,var2);
  return i;
}

int int_x_6846c() {
  // { dg-printf "int_x_6846c===00FFFFFFFB===000001E235===" }
  int var1 = (int) (-5);
  int var2 = (int) (123445);
  int i = printf("int_x_6846c===%+010X===%+010X===\n",var1,var2);
  return i;
}

int int_x_765c() {
  // { dg-printf "int_x_765c===1e235===8===" }
  int var1 = (int) (123445);
  int var2 = (int) (8);
  int i = printf("int_x_765c===%-x===%-x===\n",var1,var2);
  return i;
}

int int_x_766c() {
  // { dg-printf "int_x_766c===8===0===" }
  int var1 = (int) (8);
  int var2 = (int) (0);
  int i = printf("int_x_766c===%-X===%-X===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = int_d_1c();
i = int_d_1521c();
i = int_d_2281c();
i = int_d_3041c();
i = int_d_3801c();
i = int_d_4561c();
i = int_d_5321c();
i = int_d_6081c();
i = int_d_6841c();
i = int_d_761c();
i = int_i_1522c();
i = int_i_2c();
i = int_i_2282c();
i = int_i_3042c();
i = int_i_3802c();
i = int_i_4562c();
i = int_i_5322c();
i = int_i_6082c();
i = int_i_6842c();
i = int_i_762c();
i = int_o_1523c();
i = int_o_2283c();
i = int_o_3c();
i = int_o_3043c();
i = int_o_3803c();
i = int_o_4563c();
i = int_o_5323c();
i = int_o_6083c();
i = int_o_6843c();
i = int_o_763c();
i = int_u_1524c();
i = int_u_2284c();
i = int_u_3044c();
i = int_u_3804c();
i = int_u_4c();
i = int_u_4564c();
i = int_u_5324c();
i = int_u_6084c();
i = int_u_6844c();
i = int_u_764c();
i = int_x_1525c();
i = int_x_1526c();
i = int_x_2285c();
i = int_x_2286c();
i = int_x_3045c();
i = int_x_3046c();
i = int_x_3805c();
i = int_x_3806c();
i = int_x_4565c();
i = int_x_4566c();
i = int_x_5c();
i = int_x_5325c();
i = int_x_5326c();
i = int_x_6c();
i = int_x_6085c();
i = int_x_6086c();
i = int_x_6845c();
i = int_x_6846c();
i = int_x_765c();
i = int_x_766c();
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
