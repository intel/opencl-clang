/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/half2.c'  */

int half2_a_1717c() {
  // { dg-printf -re "half2_a_1717c===.*===.*===" }
  half2 var1 = (half2) (0,-5);
  half2 var2 = (half2) (8,1);
  int i = printf("half2_a_1717c===%+v2ha===%+v2ha===\n",var1,var2);
  return i;
}

int half2_a_1718c() {
  // { dg-printf -re "half2_a_1718c===.*===.*===" }
  half2 var1 = (half2) (-8,-3);
  half2 var2 = (half2) (1,-3);
  int i = printf("half2_a_1718c===%+.1v2ha===%+.1v2ha===\n",var1,var2);
  return i;
}

int half2_a_1719c() {
  // { dg-printf -re "half2_a_1719c===.*===.*===" }
  half2 var1 = (half2) (0,2);
  half2 var2 = (half2) (4,1);
  int i = printf("half2_a_1719c===%+.2v2ha===%+.2v2ha===\n",var1,var2);
  return i;
}

int half2_a_1720c() {
  // { dg-printf -re "half2_a_1720c===.*===.*===" }
  half2 var1 = (half2) (6,2);
  half2 var2 = (half2) (-2,-6);
  int i = printf("half2_a_1720c===%+.3v2ha===%+.3v2ha===\n",var1,var2);
  return i;
}

int half2_a_1721c() {
  // { dg-printf -re "half2_a_1721c===.*===.*===" }
  half2 var1 = (half2) (0,-123455);
  half2 var2 = (half2) (8,0);
  int i = printf("half2_a_1721c===%+.10v2ha===%+.10v2ha===\n",var1,var2);
  return i;
}

int half2_a_1722c() {
  // { dg-printf -re "half2_a_1722c===.*===.*===" }
  half2 var1 = (half2) (-7,2);
  half2 var2 = (half2) (-1,4);
  int i = printf("half2_a_1722c===%+v2hA===%+v2hA===\n",var1,var2);
  return i;
}

int half2_a_1723c() {
  // { dg-printf -re "half2_a_1723c===.*===.*===" }
  half2 var1 = (half2) (4,8);
  half2 var2 = (half2) (-8,-3);
  int i = printf("half2_a_1723c===%+.1v2hA===%+.1v2hA===\n",var1,var2);
  return i;
}

int half2_a_1724c() {
  // { dg-printf -re "half2_a_1724c===.*===.*===" }
  half2 var1 = (half2) (-8,-6);
  half2 var2 = (half2) (4,-6);
  int i = printf("half2_a_1724c===%+.2v2hA===%+.2v2hA===\n",var1,var2);
  return i;
}

int half2_a_1725c() {
  // { dg-printf -re "half2_a_1725c===.*===.*===" }
  half2 var1 = (half2) (5,-1);
  half2 var2 = (half2) (-6,-5);
  int i = printf("half2_a_1725c===%+.3v2hA===%+.3v2hA===\n",var1,var2);
  return i;
}

int half2_a_1726c() {
  // { dg-printf -re "half2_a_1726c===.*===.*===" }
  half2 var1 = (half2) (-2,0);
  half2 var2 = (half2) (-3,-3);
  int i = printf("half2_a_1726c===%+.10v2hA===%+.10v2hA===\n",var1,var2);
  return i;
}

int half2_a_197c() {
  // { dg-printf -re "half2_a_197c===.*===.*===" }
  half2 var1 = (half2) (7,-4);
  half2 var2 = (half2) (4,-4);
  int i = printf("half2_a_197c===%v2ha===%v2ha===\n",var1,var2);
  return i;
}

int half2_a_198c() {
  // { dg-printf -re "half2_a_198c===.*===.*===" }
  half2 var1 = (half2) (-1,4);
  half2 var2 = (half2) (1,6);
  int i = printf("half2_a_198c===%.1v2ha===%.1v2ha===\n",var1,var2);
  return i;
}

int half2_a_199c() {
  // { dg-printf -re "half2_a_199c===.*===.*===" }
  half2 var1 = (half2) (5,3);
  half2 var2 = (half2) (123445,0);
  int i = printf("half2_a_199c===%.2v2ha===%.2v2ha===\n",var1,var2);
  return i;
}

int half2_a_200c() {
  // { dg-printf -re "half2_a_200c===.*===.*===" }
  half2 var1 = (half2) (-1,2);
  half2 var2 = (half2) (3,-6);
  int i = printf("half2_a_200c===%.3v2ha===%.3v2ha===\n",var1,var2);
  return i;
}

int half2_a_201c() {
  // { dg-printf -re "half2_a_201c===.*===.*===" }
  half2 var1 = (half2) (-1,-4);
  half2 var2 = (half2) (-8,4);
  int i = printf("half2_a_201c===%.10v2ha===%.10v2ha===\n",var1,var2);
  return i;
}

int half2_a_202c() {
  // { dg-printf -re "half2_a_202c===.*===.*===" }
  half2 var1 = (half2) (-7,4);
  half2 var2 = (half2) (4,-1);
  int i = printf("half2_a_202c===%v2hA===%v2hA===\n",var1,var2);
  return i;
}

int half2_a_203c() {
  // { dg-printf -re "half2_a_203c===.*===.*===" }
  half2 var1 = (half2) (4,-123455);
  half2 var2 = (half2) (-1,-7);
  int i = printf("half2_a_203c===%.1v2hA===%.1v2hA===\n",var1,var2);
  return i;
}

int half2_a_204c() {
  // { dg-printf -re "half2_a_204c===.*===.*===" }
  half2 var1 = (half2) (7,-123455);
  half2 var2 = (half2) (-4,4);
  int i = printf("half2_a_204c===%.2v2hA===%.2v2hA===\n",var1,var2);
  return i;
}

int half2_a_205c() {
  // { dg-printf -re "half2_a_205c===.*===.*===" }
  half2 var1 = (half2) (123445,-1);
  half2 var2 = (half2) (-6,2);
  int i = printf("half2_a_205c===%.3v2hA===%.3v2hA===\n",var1,var2);
  return i;
}

int half2_a_206c() {
  // { dg-printf -re "half2_a_206c===.*===.*===" }
  half2 var1 = (half2) (-2,0);
  half2 var2 = (half2) (-7,123445);
  int i = printf("half2_a_206c===%.10v2hA===%.10v2hA===\n",var1,var2);
  return i;
}

int half2_a_2477c() {
  // { dg-printf -re "half2_a_2477c===.*===.*===" }
  half2 var1 = (half2) (-7,-7);
  half2 var2 = (half2) (-3,2);
  int i = printf("half2_a_2477c===%#v2ha===%#v2ha===\n",var1,var2);
  return i;
}

int half2_a_2478c() {
  // { dg-printf -re "half2_a_2478c===.*===.*===" }
  half2 var1 = (half2) (-2,-7);
  half2 var2 = (half2) (-1,4);
  int i = printf("half2_a_2478c===%#.1v2ha===%#.1v2ha===\n",var1,var2);
  return i;
}

int half2_a_2479c() {
  // { dg-printf -re "half2_a_2479c===.*===.*===" }
  half2 var1 = (half2) (-7,6);
  half2 var2 = (half2) (5,5);
  int i = printf("half2_a_2479c===%#.2v2ha===%#.2v2ha===\n",var1,var2);
  return i;
}

int half2_a_2480c() {
  // { dg-printf -re "half2_a_2480c===.*===.*===" }
  half2 var1 = (half2) (-8,-1);
  half2 var2 = (half2) (4,6);
  int i = printf("half2_a_2480c===%#.3v2ha===%#.3v2ha===\n",var1,var2);
  return i;
}

int half2_a_2481c() {
  // { dg-printf -re "half2_a_2481c===.*===.*===" }
  half2 var1 = (half2) (123445,-8);
  half2 var2 = (half2) (-7,0);
  int i = printf("half2_a_2481c===%#.10v2ha===%#.10v2ha===\n",var1,var2);
  return i;
}

int half2_a_2482c() {
  // { dg-printf -re "half2_a_2482c===.*===.*===" }
  half2 var1 = (half2) (4,-5);
  half2 var2 = (half2) (-123455,0);
  int i = printf("half2_a_2482c===%#v2hA===%#v2hA===\n",var1,var2);
  return i;
}

int half2_a_2483c() {
  // { dg-printf -re "half2_a_2483c===.*===.*===" }
  half2 var1 = (half2) (2,-2);
  half2 var2 = (half2) (3,4);
  int i = printf("half2_a_2483c===%#.1v2hA===%#.1v2hA===\n",var1,var2);
  return i;
}

int half2_a_2484c() {
  // { dg-printf -re "half2_a_2484c===.*===.*===" }
  half2 var1 = (half2) (-8,5);
  half2 var2 = (half2) (-6,-7);
  int i = printf("half2_a_2484c===%#.2v2hA===%#.2v2hA===\n",var1,var2);
  return i;
}

int half2_a_2485c() {
  // { dg-printf -re "half2_a_2485c===.*===.*===" }
  half2 var1 = (half2) (-8,1);
  half2 var2 = (half2) (-7,-2);
  int i = printf("half2_a_2485c===%#.3v2hA===%#.3v2hA===\n",var1,var2);
  return i;
}

int half2_a_2486c() {
  // { dg-printf -re "half2_a_2486c===.*===.*===" }
  half2 var1 = (half2) (-6,-7);
  half2 var2 = (half2) (0,-7);
  int i = printf("half2_a_2486c===%#.10v2hA===%#.10v2hA===\n",var1,var2);
  return i;
}

int half2_a_3237c() {
  // { dg-printf -re "half2_a_3237c===.*===.*===" }
  half2 var1 = (half2) (-8,-2);
  half2 var2 = (half2) (3,-8);
  int i = printf("half2_a_3237c===%-+v2ha===%-+v2ha===\n",var1,var2);
  return i;
}

int half2_a_3238c() {
  // { dg-printf -re "half2_a_3238c===.*===.*===" }
  half2 var1 = (half2) (5,-2);
  half2 var2 = (half2) (6,-2);
  int i = printf("half2_a_3238c===%-+.1v2ha===%-+.1v2ha===\n",var1,var2);
  return i;
}

int half2_a_3239c() {
  // { dg-printf -re "half2_a_3239c===.*===.*===" }
  half2 var1 = (half2) (3,-3);
  half2 var2 = (half2) (-6,-7);
  int i = printf("half2_a_3239c===%-+.2v2ha===%-+.2v2ha===\n",var1,var2);
  return i;
}

int half2_a_3240c() {
  // { dg-printf -re "half2_a_3240c===.*===.*===" }
  half2 var1 = (half2) (3,4);
  half2 var2 = (half2) (-4,-5);
  int i = printf("half2_a_3240c===%-+.3v2ha===%-+.3v2ha===\n",var1,var2);
  return i;
}

int half2_a_3241c() {
  // { dg-printf -re "half2_a_3241c===.*===.*===" }
  half2 var1 = (half2) (3,-1);
  half2 var2 = (half2) (2,8);
  int i = printf("half2_a_3241c===%-+.10v2ha===%-+.10v2ha===\n",var1,var2);
  return i;
}

int half2_a_3242c() {
  // { dg-printf -re "half2_a_3242c===.*===.*===" }
  half2 var1 = (half2) (-5,0);
  half2 var2 = (half2) (3,8);
  int i = printf("half2_a_3242c===%-+v2hA===%-+v2hA===\n",var1,var2);
  return i;
}

int half2_a_3243c() {
  // { dg-printf -re "half2_a_3243c===.*===.*===" }
  half2 var1 = (half2) (3,8);
  half2 var2 = (half2) (7,-3);
  int i = printf("half2_a_3243c===%-+.1v2hA===%-+.1v2hA===\n",var1,var2);
  return i;
}

int half2_a_3244c() {
  // { dg-printf -re "half2_a_3244c===.*===.*===" }
  half2 var1 = (half2) (2,-2);
  half2 var2 = (half2) (-8,-123455);
  int i = printf("half2_a_3244c===%-+.2v2hA===%-+.2v2hA===\n",var1,var2);
  return i;
}

int half2_a_3245c() {
  // { dg-printf -re "half2_a_3245c===.*===.*===" }
  half2 var1 = (half2) (2,2);
  half2 var2 = (half2) (-3,7);
  int i = printf("half2_a_3245c===%-+.3v2hA===%-+.3v2hA===\n",var1,var2);
  return i;
}

int half2_a_3246c() {
  // { dg-printf -re "half2_a_3246c===.*===.*===" }
  half2 var1 = (half2) (3,-1);
  half2 var2 = (half2) (2,-7);
  int i = printf("half2_a_3246c===%-+.10v2hA===%-+.10v2hA===\n",var1,var2);
  return i;
}

int half2_a_3997c() {
  // { dg-printf -re "half2_a_3997c===.*===.*===" }
  half2 var1 = (half2) (-4,-4);
  half2 var2 = (half2) (-5,-3);
  int i = printf("half2_a_3997c===% 10v2ha===% 10v2ha===\n",var1,var2);
  return i;
}

int half2_a_3998c() {
  // { dg-printf -re "half2_a_3998c===.*===.*===" }
  half2 var1 = (half2) (-7,5);
  half2 var2 = (half2) (4,3);
  int i = printf("half2_a_3998c===% 10.1v2ha===% 10.1v2ha===\n",var1,var2);
  return i;
}

int half2_a_3999c() {
  // { dg-printf -re "half2_a_3999c===.*===.*===" }
  half2 var1 = (half2) (-123455,6);
  half2 var2 = (half2) (5,-8);
  int i = printf("half2_a_3999c===% 10.2v2ha===% 10.2v2ha===\n",var1,var2);
  return i;
}

int half2_a_4000c() {
  // { dg-printf -re "half2_a_4000c===.*===.*===" }
  half2 var1 = (half2) (8,-8);
  half2 var2 = (half2) (7,-6);
  int i = printf("half2_a_4000c===% 10.3v2ha===% 10.3v2ha===\n",var1,var2);
  return i;
}

int half2_a_4001c() {
  // { dg-printf -re "half2_a_4001c===.*===.*===" }
  half2 var1 = (half2) (-8,-123455);
  half2 var2 = (half2) (-5,6);
  int i = printf("half2_a_4001c===% 10.10v2ha===% 10.10v2ha===\n",var1,var2);
  return i;
}

int half2_a_4002c() {
  // { dg-printf -re "half2_a_4002c===.*===.*===" }
  half2 var1 = (half2) (6,-5);
  half2 var2 = (half2) (-2,1);
  int i = printf("half2_a_4002c===% 10v2hA===% 10v2hA===\n",var1,var2);
  return i;
}

int half2_a_4003c() {
  // { dg-printf -re "half2_a_4003c===.*===.*===" }
  half2 var1 = (half2) (-2,1);
  half2 var2 = (half2) (-5,-5);
  int i = printf("half2_a_4003c===% 10.1v2hA===% 10.1v2hA===\n",var1,var2);
  return i;
}

int half2_a_4004c() {
  // { dg-printf -re "half2_a_4004c===.*===.*===" }
  half2 var1 = (half2) (-1,-6);
  half2 var2 = (half2) (-6,-6);
  int i = printf("half2_a_4004c===% 10.2v2hA===% 10.2v2hA===\n",var1,var2);
  return i;
}

int half2_a_4005c() {
  // { dg-printf -re "half2_a_4005c===.*===.*===" }
  half2 var1 = (half2) (6,8);
  half2 var2 = (half2) (7,5);
  int i = printf("half2_a_4005c===% 10.3v2hA===% 10.3v2hA===\n",var1,var2);
  return i;
}

int half2_a_4006c() {
  // { dg-printf -re "half2_a_4006c===.*===.*===" }
  half2 var1 = (half2) (-4,-2);
  half2 var2 = (half2) (-4,3);
  int i = printf("half2_a_4006c===% 10.10v2hA===% 10.10v2hA===\n",var1,var2);
  return i;
}

int half2_a_4757c() {
  // { dg-printf -re "half2_a_4757c===.*===.*===" }
  half2 var1 = (half2) (4,4);
  half2 var2 = (half2) (123445,3);
  int i = printf("half2_a_4757c===%010v2ha===%010v2ha===\n",var1,var2);
  return i;
}

int half2_a_4758c() {
  // { dg-printf -re "half2_a_4758c===.*===.*===" }
  half2 var1 = (half2) (3,4);
  half2 var2 = (half2) (-3,4);
  int i = printf("half2_a_4758c===%010.1v2ha===%010.1v2ha===\n",var1,var2);
  return i;
}

int half2_a_4759c() {
  // { dg-printf -re "half2_a_4759c===.*===.*===" }
  half2 var1 = (half2) (-6,-123455);
  half2 var2 = (half2) (5,-1);
  int i = printf("half2_a_4759c===%010.2v2ha===%010.2v2ha===\n",var1,var2);
  return i;
}

int half2_a_4760c() {
  // { dg-printf -re "half2_a_4760c===.*===.*===" }
  half2 var1 = (half2) (7,1);
  half2 var2 = (half2) (-8,0);
  int i = printf("half2_a_4760c===%010.3v2ha===%010.3v2ha===\n",var1,var2);
  return i;
}

int half2_a_4761c() {
  // { dg-printf -re "half2_a_4761c===.*===.*===" }
  half2 var1 = (half2) (-6,-4);
  half2 var2 = (half2) (3,6);
  int i = printf("half2_a_4761c===%010.10v2ha===%010.10v2ha===\n",var1,var2);
  return i;
}

int half2_a_4762c() {
  // { dg-printf -re "half2_a_4762c===.*===.*===" }
  half2 var1 = (half2) (3,7);
  half2 var2 = (half2) (-123455,-4);
  int i = printf("half2_a_4762c===%010v2hA===%010v2hA===\n",var1,var2);
  return i;
}

int half2_a_4763c() {
  // { dg-printf -re "half2_a_4763c===.*===.*===" }
  half2 var1 = (half2) (-6,-2);
  half2 var2 = (half2) (-3,1);
  int i = printf("half2_a_4763c===%010.1v2hA===%010.1v2hA===\n",var1,var2);
  return i;
}

int half2_a_4764c() {
  // { dg-printf -re "half2_a_4764c===.*===.*===" }
  half2 var1 = (half2) (0,1);
  half2 var2 = (half2) (-1,-3);
  int i = printf("half2_a_4764c===%010.2v2hA===%010.2v2hA===\n",var1,var2);
  return i;
}

int half2_a_4765c() {
  // { dg-printf -re "half2_a_4765c===.*===.*===" }
  half2 var1 = (half2) (7,-1);
  half2 var2 = (half2) (7,-3);
  int i = printf("half2_a_4765c===%010.3v2hA===%010.3v2hA===\n",var1,var2);
  return i;
}

int half2_a_4766c() {
  // { dg-printf -re "half2_a_4766c===.*===.*===" }
  half2 var1 = (half2) (-7,7);
  half2 var2 = (half2) (0,0);
  int i = printf("half2_a_4766c===%010.10v2hA===%010.10v2hA===\n",var1,var2);
  return i;
}

int half2_a_5517c() {
  // { dg-printf -re "half2_a_5517c===.*===.*===" }
  half2 var1 = (half2) (7,-3);
  half2 var2 = (half2) (-6,5);
  int i = printf("half2_a_5517c===%- 10v2ha===%- 10v2ha===\n",var1,var2);
  return i;
}

int half2_a_5518c() {
  // { dg-printf -re "half2_a_5518c===.*===.*===" }
  half2 var1 = (half2) (-5,-3);
  half2 var2 = (half2) (-6,6);
  int i = printf("half2_a_5518c===%- 10.1v2ha===%- 10.1v2ha===\n",var1,var2);
  return i;
}

int half2_a_5519c() {
  // { dg-printf -re "half2_a_5519c===.*===.*===" }
  half2 var1 = (half2) (0,1);
  half2 var2 = (half2) (6,123445);
  int i = printf("half2_a_5519c===%- 10.2v2ha===%- 10.2v2ha===\n",var1,var2);
  return i;
}

int half2_a_5520c() {
  // { dg-printf -re "half2_a_5520c===.*===.*===" }
  half2 var1 = (half2) (4,4);
  half2 var2 = (half2) (1,5);
  int i = printf("half2_a_5520c===%- 10.3v2ha===%- 10.3v2ha===\n",var1,var2);
  return i;
}

int half2_a_5521c() {
  // { dg-printf -re "half2_a_5521c===.*===.*===" }
  half2 var1 = (half2) (123445,-1);
  half2 var2 = (half2) (0,-8);
  int i = printf("half2_a_5521c===%- 10.10v2ha===%- 10.10v2ha===\n",var1,var2);
  return i;
}

int half2_a_5522c() {
  // { dg-printf -re "half2_a_5522c===.*===.*===" }
  half2 var1 = (half2) (-4,-7);
  half2 var2 = (half2) (0,-7);
  int i = printf("half2_a_5522c===%- 10v2hA===%- 10v2hA===\n",var1,var2);
  return i;
}

int half2_a_5523c() {
  // { dg-printf -re "half2_a_5523c===.*===.*===" }
  half2 var1 = (half2) (123445,123445);
  half2 var2 = (half2) (-123455,3);
  int i = printf("half2_a_5523c===%- 10.1v2hA===%- 10.1v2hA===\n",var1,var2);
  return i;
}

int half2_a_5524c() {
  // { dg-printf -re "half2_a_5524c===.*===.*===" }
  half2 var1 = (half2) (123445,-6);
  half2 var2 = (half2) (7,-6);
  int i = printf("half2_a_5524c===%- 10.2v2hA===%- 10.2v2hA===\n",var1,var2);
  return i;
}

int half2_a_5525c() {
  // { dg-printf -re "half2_a_5525c===.*===.*===" }
  half2 var1 = (half2) (-3,-5);
  half2 var2 = (half2) (-6,1);
  int i = printf("half2_a_5525c===%- 10.3v2hA===%- 10.3v2hA===\n",var1,var2);
  return i;
}

int half2_a_5526c() {
  // { dg-printf -re "half2_a_5526c===.*===.*===" }
  half2 var1 = (half2) (7,0);
  half2 var2 = (half2) (-123455,123445);
  int i = printf("half2_a_5526c===%- 10.10v2hA===%- 10.10v2hA===\n",var1,var2);
  return i;
}

int half2_a_6277c() {
  // { dg-printf -re "half2_a_6277c===.*===.*===" }
  half2 var1 = (half2) (3,3);
  half2 var2 = (half2) (123445,3);
  int i = printf("half2_a_6277c===%+ 10v2ha===%+ 10v2ha===\n",var1,var2);
  return i;
}

int half2_a_6278c() {
  // { dg-printf -re "half2_a_6278c===.*===.*===" }
  half2 var1 = (half2) (-8,3);
  half2 var2 = (half2) (-6,-1);
  int i = printf("half2_a_6278c===%+ 10.1v2ha===%+ 10.1v2ha===\n",var1,var2);
  return i;
}

int half2_a_6279c() {
  // { dg-printf -re "half2_a_6279c===.*===.*===" }
  half2 var1 = (half2) (1,-5);
  half2 var2 = (half2) (-5,-123455);
  int i = printf("half2_a_6279c===%+ 10.2v2ha===%+ 10.2v2ha===\n",var1,var2);
  return i;
}

int half2_a_6280c() {
  // { dg-printf -re "half2_a_6280c===.*===.*===" }
  half2 var1 = (half2) (3,8);
  half2 var2 = (half2) (6,-3);
  int i = printf("half2_a_6280c===%+ 10.3v2ha===%+ 10.3v2ha===\n",var1,var2);
  return i;
}

int half2_a_6281c() {
  // { dg-printf -re "half2_a_6281c===.*===.*===" }
  half2 var1 = (half2) (-2,4);
  half2 var2 = (half2) (2,6);
  int i = printf("half2_a_6281c===%+ 10.10v2ha===%+ 10.10v2ha===\n",var1,var2);
  return i;
}

int half2_a_6282c() {
  // { dg-printf -re "half2_a_6282c===.*===.*===" }
  half2 var1 = (half2) (-1,-1);
  half2 var2 = (half2) (-7,123445);
  int i = printf("half2_a_6282c===%+ 10v2hA===%+ 10v2hA===\n",var1,var2);
  return i;
}

int half2_a_6283c() {
  // { dg-printf -re "half2_a_6283c===.*===.*===" }
  half2 var1 = (half2) (8,-3);
  half2 var2 = (half2) (123445,-6);
  int i = printf("half2_a_6283c===%+ 10.1v2hA===%+ 10.1v2hA===\n",var1,var2);
  return i;
}

int half2_a_6284c() {
  // { dg-printf -re "half2_a_6284c===.*===.*===" }
  half2 var1 = (half2) (-5,123445);
  half2 var2 = (half2) (3,7);
  int i = printf("half2_a_6284c===%+ 10.2v2hA===%+ 10.2v2hA===\n",var1,var2);
  return i;
}

int half2_a_6285c() {
  // { dg-printf -re "half2_a_6285c===.*===.*===" }
  half2 var1 = (half2) (5,-4);
  half2 var2 = (half2) (-5,-4);
  int i = printf("half2_a_6285c===%+ 10.3v2hA===%+ 10.3v2hA===\n",var1,var2);
  return i;
}

int half2_a_6286c() {
  // { dg-printf -re "half2_a_6286c===.*===.*===" }
  half2 var1 = (half2) (-7,1);
  half2 var2 = (half2) (7,123445);
  int i = printf("half2_a_6286c===%+ 10.10v2hA===%+ 10.10v2hA===\n",var1,var2);
  return i;
}

int half2_a_7037c() {
  // { dg-printf -re "half2_a_7037c===.*===.*===" }
  half2 var1 = (half2) (6,5);
  half2 var2 = (half2) (-3,2);
  int i = printf("half2_a_7037c===%+010v2ha===%+010v2ha===\n",var1,var2);
  return i;
}

int half2_a_7038c() {
  // { dg-printf -re "half2_a_7038c===.*===.*===" }
  half2 var1 = (half2) (4,-2);
  half2 var2 = (half2) (6,5);
  int i = printf("half2_a_7038c===%+010.1v2ha===%+010.1v2ha===\n",var1,var2);
  return i;
}

int half2_a_7039c() {
  // { dg-printf -re "half2_a_7039c===.*===.*===" }
  half2 var1 = (half2) (3,123445);
  half2 var2 = (half2) (8,-4);
  int i = printf("half2_a_7039c===%+010.2v2ha===%+010.2v2ha===\n",var1,var2);
  return i;
}

int half2_a_7040c() {
  // { dg-printf -re "half2_a_7040c===.*===.*===" }
  half2 var1 = (half2) (123445,5);
  half2 var2 = (half2) (-6,-7);
  int i = printf("half2_a_7040c===%+010.3v2ha===%+010.3v2ha===\n",var1,var2);
  return i;
}

int half2_a_7041c() {
  // { dg-printf -re "half2_a_7041c===.*===.*===" }
  half2 var1 = (half2) (4,8);
  half2 var2 = (half2) (4,4);
  int i = printf("half2_a_7041c===%+010.10v2ha===%+010.10v2ha===\n",var1,var2);
  return i;
}

int half2_a_7042c() {
  // { dg-printf -re "half2_a_7042c===.*===.*===" }
  half2 var1 = (half2) (2,-1);
  half2 var2 = (half2) (-3,-123455);
  int i = printf("half2_a_7042c===%+010v2hA===%+010v2hA===\n",var1,var2);
  return i;
}

int half2_a_7043c() {
  // { dg-printf -re "half2_a_7043c===.*===.*===" }
  half2 var1 = (half2) (0,123445);
  half2 var2 = (half2) (-1,-7);
  int i = printf("half2_a_7043c===%+010.1v2hA===%+010.1v2hA===\n",var1,var2);
  return i;
}

int half2_a_7044c() {
  // { dg-printf -re "half2_a_7044c===.*===.*===" }
  half2 var1 = (half2) (-8,-1);
  half2 var2 = (half2) (-1,-123455);
  int i = printf("half2_a_7044c===%+010.2v2hA===%+010.2v2hA===\n",var1,var2);
  return i;
}

int half2_a_7045c() {
  // { dg-printf -re "half2_a_7045c===.*===.*===" }
  half2 var1 = (half2) (-7,-6);
  half2 var2 = (half2) (1,123445);
  int i = printf("half2_a_7045c===%+010.3v2hA===%+010.3v2hA===\n",var1,var2);
  return i;
}

int half2_a_7046c() {
  // { dg-printf -re "half2_a_7046c===.*===.*===" }
  half2 var1 = (half2) (7,-5);
  half2 var2 = (half2) (-123455,-6);
  int i = printf("half2_a_7046c===%+010.10v2hA===%+010.10v2hA===\n",var1,var2);
  return i;
}

int half2_a_957c() {
  // { dg-printf -re "half2_a_957c===.*===.*===" }
  half2 var1 = (half2) (1,123445);
  half2 var2 = (half2) (-3,8);
  int i = printf("half2_a_957c===%-v2ha===%-v2ha===\n",var1,var2);
  return i;
}

int half2_a_958c() {
  // { dg-printf -re "half2_a_958c===.*===.*===" }
  half2 var1 = (half2) (1,6);
  half2 var2 = (half2) (123445,-2);
  int i = printf("half2_a_958c===%-.1v2ha===%-.1v2ha===\n",var1,var2);
  return i;
}

int half2_a_959c() {
  // { dg-printf -re "half2_a_959c===.*===.*===" }
  half2 var1 = (half2) (-4,-3);
  half2 var2 = (half2) (-2,-3);
  int i = printf("half2_a_959c===%-.2v2ha===%-.2v2ha===\n",var1,var2);
  return i;
}

int half2_a_960c() {
  // { dg-printf -re "half2_a_960c===.*===.*===" }
  half2 var1 = (half2) (-2,8);
  half2 var2 = (half2) (0,2);
  int i = printf("half2_a_960c===%-.3v2ha===%-.3v2ha===\n",var1,var2);
  return i;
}

int half2_a_961c() {
  // { dg-printf -re "half2_a_961c===.*===.*===" }
  half2 var1 = (half2) (8,-7);
  half2 var2 = (half2) (-1,3);
  int i = printf("half2_a_961c===%-.10v2ha===%-.10v2ha===\n",var1,var2);
  return i;
}

int half2_a_962c() {
  // { dg-printf -re "half2_a_962c===.*===.*===" }
  half2 var1 = (half2) (1,-2);
  half2 var2 = (half2) (-2,-6);
  int i = printf("half2_a_962c===%-v2hA===%-v2hA===\n",var1,var2);
  return i;
}

int half2_a_963c() {
  // { dg-printf -re "half2_a_963c===.*===.*===" }
  half2 var1 = (half2) (-4,-8);
  half2 var2 = (half2) (2,-1);
  int i = printf("half2_a_963c===%-.1v2hA===%-.1v2hA===\n",var1,var2);
  return i;
}

int half2_a_964c() {
  // { dg-printf -re "half2_a_964c===.*===.*===" }
  half2 var1 = (half2) (8,0);
  half2 var2 = (half2) (1,-7);
  int i = printf("half2_a_964c===%-.2v2hA===%-.2v2hA===\n",var1,var2);
  return i;
}

int half2_a_965c() {
  // { dg-printf -re "half2_a_965c===.*===.*===" }
  half2 var1 = (half2) (-6,3);
  half2 var2 = (half2) (-1,8);
  int i = printf("half2_a_965c===%-.3v2hA===%-.3v2hA===\n",var1,var2);
  return i;
}

int half2_a_966c() {
  // { dg-printf -re "half2_a_966c===.*===.*===" }
  half2 var1 = (half2) (-3,4);
  half2 var2 = (half2) (-5,1);
  int i = printf("half2_a_966c===%-.10v2hA===%-.10v2hA===\n",var1,var2);
  return i;
}

int half2_e_1727c() {
  // { dg-printf -re "half2_e_1727c===.*===.*===" }
  half2 var1 = (half2) (-8,6);
  half2 var2 = (half2) (2,123445);
  int i = printf("half2_e_1727c===%+v2he===%+v2he===\n",var1,var2);
  return i;
}

int half2_e_1728c() {
  // { dg-printf -re "half2_e_1728c===.*===.*===" }
  half2 var1 = (half2) (-3,-8);
  half2 var2 = (half2) (7,-3);
  int i = printf("half2_e_1728c===%+.1v2he===%+.1v2he===\n",var1,var2);
  return i;
}

int half2_e_1729c() {
  // { dg-printf -re "half2_e_1729c===.*===.*===" }
  half2 var1 = (half2) (6,-123455);
  half2 var2 = (half2) (-7,8);
  int i = printf("half2_e_1729c===%+.2v2he===%+.2v2he===\n",var1,var2);
  return i;
}

int half2_e_1730c() {
  // { dg-printf -re "half2_e_1730c===.*===.*===" }
  half2 var1 = (half2) (-7,8);
  half2 var2 = (half2) (6,1);
  int i = printf("half2_e_1730c===%+.3v2he===%+.3v2he===\n",var1,var2);
  return i;
}

int half2_e_1731c() {
  // { dg-printf -re "half2_e_1731c===.*===.*===" }
  half2 var1 = (half2) (3,-4);
  half2 var2 = (half2) (8,-4);
  int i = printf("half2_e_1731c===%+.10v2he===%+.10v2he===\n",var1,var2);
  return i;
}

int half2_e_1732c() {
  // { dg-printf -re "half2_e_1732c===.*===.*===" }
  half2 var1 = (half2) (1,123445);
  half2 var2 = (half2) (-8,123445);
  int i = printf("half2_e_1732c===%+v2hE===%+v2hE===\n",var1,var2);
  return i;
}

int half2_e_1733c() {
  // { dg-printf -re "half2_e_1733c===.*===.*===" }
  half2 var1 = (half2) (5,-8);
  half2 var2 = (half2) (-2,-7);
  int i = printf("half2_e_1733c===%+.1v2hE===%+.1v2hE===\n",var1,var2);
  return i;
}

int half2_e_1734c() {
  // { dg-printf -re "half2_e_1734c===.*===.*===" }
  half2 var1 = (half2) (123445,-6);
  half2 var2 = (half2) (-1,4);
  int i = printf("half2_e_1734c===%+.2v2hE===%+.2v2hE===\n",var1,var2);
  return i;
}

int half2_e_1735c() {
  // { dg-printf -re "half2_e_1735c===.*===.*===" }
  half2 var1 = (half2) (3,5);
  half2 var2 = (half2) (-123455,-6);
  int i = printf("half2_e_1735c===%+.3v2hE===%+.3v2hE===\n",var1,var2);
  return i;
}

int half2_e_1736c() {
  // { dg-printf -re "half2_e_1736c===.*===.*===" }
  half2 var1 = (half2) (0,1);
  half2 var2 = (half2) (6,8);
  int i = printf("half2_e_1736c===%+.10v2hE===%+.10v2hE===\n",var1,var2);
  return i;
}

int half2_e_207c() {
  // { dg-printf -re "half2_e_207c===.*===.*===" }
  half2 var1 = (half2) (7,7);
  half2 var2 = (half2) (3,-8);
  int i = printf("half2_e_207c===%v2he===%v2he===\n",var1,var2);
  return i;
}

int half2_e_208c() {
  // { dg-printf -re "half2_e_208c===.*===.*===" }
  half2 var1 = (half2) (4,1);
  half2 var2 = (half2) (123445,0);
  int i = printf("half2_e_208c===%.1v2he===%.1v2he===\n",var1,var2);
  return i;
}

int half2_e_209c() {
  // { dg-printf -re "half2_e_209c===.*===.*===" }
  half2 var1 = (half2) (-3,-2);
  half2 var2 = (half2) (3,-3);
  int i = printf("half2_e_209c===%.2v2he===%.2v2he===\n",var1,var2);
  return i;
}

int half2_e_210c() {
  // { dg-printf -re "half2_e_210c===.*===.*===" }
  half2 var1 = (half2) (-5,8);
  half2 var2 = (half2) (123445,4);
  int i = printf("half2_e_210c===%.3v2he===%.3v2he===\n",var1,var2);
  return i;
}

int half2_e_211c() {
  // { dg-printf -re "half2_e_211c===.*===.*===" }
  half2 var1 = (half2) (-123455,4);
  half2 var2 = (half2) (123445,-4);
  int i = printf("half2_e_211c===%.10v2he===%.10v2he===\n",var1,var2);
  return i;
}

int half2_e_212c() {
  // { dg-printf -re "half2_e_212c===.*===.*===" }
  half2 var1 = (half2) (8,7);
  half2 var2 = (half2) (2,-8);
  int i = printf("half2_e_212c===%v2hE===%v2hE===\n",var1,var2);
  return i;
}

int half2_e_213c() {
  // { dg-printf -re "half2_e_213c===.*===.*===" }
  half2 var1 = (half2) (-1,-5);
  half2 var2 = (half2) (-7,-4);
  int i = printf("half2_e_213c===%.1v2hE===%.1v2hE===\n",var1,var2);
  return i;
}

int half2_e_214c() {
  // { dg-printf -re "half2_e_214c===.*===.*===" }
  half2 var1 = (half2) (3,4);
  half2 var2 = (half2) (3,0);
  int i = printf("half2_e_214c===%.2v2hE===%.2v2hE===\n",var1,var2);
  return i;
}

int half2_e_215c() {
  // { dg-printf -re "half2_e_215c===.*===.*===" }
  half2 var1 = (half2) (1,7);
  half2 var2 = (half2) (4,123445);
  int i = printf("half2_e_215c===%.3v2hE===%.3v2hE===\n",var1,var2);
  return i;
}

int half2_e_216c() {
  // { dg-printf -re "half2_e_216c===.*===.*===" }
  half2 var1 = (half2) (8,6);
  half2 var2 = (half2) (3,-4);
  int i = printf("half2_e_216c===%.10v2hE===%.10v2hE===\n",var1,var2);
  return i;
}

int half2_e_2487c() {
  // { dg-printf -re "half2_e_2487c===.*===.*===" }
  half2 var1 = (half2) (-123455,4);
  half2 var2 = (half2) (6,0);
  int i = printf("half2_e_2487c===%#v2he===%#v2he===\n",var1,var2);
  return i;
}

int half2_e_2488c() {
  // { dg-printf -re "half2_e_2488c===.*===.*===" }
  half2 var1 = (half2) (1,-5);
  half2 var2 = (half2) (-7,-3);
  int i = printf("half2_e_2488c===%#.1v2he===%#.1v2he===\n",var1,var2);
  return i;
}

int half2_e_2489c() {
  // { dg-printf -re "half2_e_2489c===.*===.*===" }
  half2 var1 = (half2) (1,-3);
  half2 var2 = (half2) (-8,-8);
  int i = printf("half2_e_2489c===%#.2v2he===%#.2v2he===\n",var1,var2);
  return i;
}

int half2_e_2490c() {
  // { dg-printf -re "half2_e_2490c===.*===.*===" }
  half2 var1 = (half2) (6,3);
  half2 var2 = (half2) (7,3);
  int i = printf("half2_e_2490c===%#.3v2he===%#.3v2he===\n",var1,var2);
  return i;
}

int half2_e_2491c() {
  // { dg-printf -re "half2_e_2491c===.*===.*===" }
  half2 var1 = (half2) (-123455,1);
  half2 var2 = (half2) (-2,7);
  int i = printf("half2_e_2491c===%#.10v2he===%#.10v2he===\n",var1,var2);
  return i;
}

int half2_e_2492c() {
  // { dg-printf -re "half2_e_2492c===.*===.*===" }
  half2 var1 = (half2) (4,-7);
  half2 var2 = (half2) (-2,-8);
  int i = printf("half2_e_2492c===%#v2hE===%#v2hE===\n",var1,var2);
  return i;
}

int half2_e_2493c() {
  // { dg-printf -re "half2_e_2493c===.*===.*===" }
  half2 var1 = (half2) (2,5);
  half2 var2 = (half2) (-5,-5);
  int i = printf("half2_e_2493c===%#.1v2hE===%#.1v2hE===\n",var1,var2);
  return i;
}

int half2_e_2494c() {
  // { dg-printf -re "half2_e_2494c===.*===.*===" }
  half2 var1 = (half2) (-7,-3);
  half2 var2 = (half2) (123445,-3);
  int i = printf("half2_e_2494c===%#.2v2hE===%#.2v2hE===\n",var1,var2);
  return i;
}

int half2_e_2495c() {
  // { dg-printf -re "half2_e_2495c===.*===.*===" }
  half2 var1 = (half2) (-4,1);
  half2 var2 = (half2) (2,-4);
  int i = printf("half2_e_2495c===%#.3v2hE===%#.3v2hE===\n",var1,var2);
  return i;
}

int half2_e_2496c() {
  // { dg-printf -re "half2_e_2496c===.*===.*===" }
  half2 var1 = (half2) (-4,-2);
  half2 var2 = (half2) (2,5);
  int i = printf("half2_e_2496c===%#.10v2hE===%#.10v2hE===\n",var1,var2);
  return i;
}

int half2_e_3247c() {
  // { dg-printf -re "half2_e_3247c===.*===.*===" }
  half2 var1 = (half2) (123445,0);
  half2 var2 = (half2) (123445,6);
  int i = printf("half2_e_3247c===%-+v2he===%-+v2he===\n",var1,var2);
  return i;
}

int half2_e_3248c() {
  // { dg-printf -re "half2_e_3248c===.*===.*===" }
  half2 var1 = (half2) (3,5);
  half2 var2 = (half2) (-8,4);
  int i = printf("half2_e_3248c===%-+.1v2he===%-+.1v2he===\n",var1,var2);
  return i;
}

int half2_e_3249c() {
  // { dg-printf -re "half2_e_3249c===.*===.*===" }
  half2 var1 = (half2) (5,4);
  half2 var2 = (half2) (5,-4);
  int i = printf("half2_e_3249c===%-+.2v2he===%-+.2v2he===\n",var1,var2);
  return i;
}

int half2_e_3250c() {
  // { dg-printf -re "half2_e_3250c===.*===.*===" }
  half2 var1 = (half2) (-5,0);
  half2 var2 = (half2) (1,4);
  int i = printf("half2_e_3250c===%-+.3v2he===%-+.3v2he===\n",var1,var2);
  return i;
}

int half2_e_3251c() {
  // { dg-printf -re "half2_e_3251c===.*===.*===" }
  half2 var1 = (half2) (123445,5);
  half2 var2 = (half2) (1,2);
  int i = printf("half2_e_3251c===%-+.10v2he===%-+.10v2he===\n",var1,var2);
  return i;
}

int half2_e_3252c() {
  // { dg-printf -re "half2_e_3252c===.*===.*===" }
  half2 var1 = (half2) (123445,4);
  half2 var2 = (half2) (4,7);
  int i = printf("half2_e_3252c===%-+v2hE===%-+v2hE===\n",var1,var2);
  return i;
}

int half2_e_3253c() {
  // { dg-printf -re "half2_e_3253c===.*===.*===" }
  half2 var1 = (half2) (4,-8);
  half2 var2 = (half2) (4,-6);
  int i = printf("half2_e_3253c===%-+.1v2hE===%-+.1v2hE===\n",var1,var2);
  return i;
}

int half2_e_3254c() {
  // { dg-printf -re "half2_e_3254c===.*===.*===" }
  half2 var1 = (half2) (2,3);
  half2 var2 = (half2) (-6,3);
  int i = printf("half2_e_3254c===%-+.2v2hE===%-+.2v2hE===\n",var1,var2);
  return i;
}

int half2_e_3255c() {
  // { dg-printf -re "half2_e_3255c===.*===.*===" }
  half2 var1 = (half2) (5,1);
  half2 var2 = (half2) (8,-7);
  int i = printf("half2_e_3255c===%-+.3v2hE===%-+.3v2hE===\n",var1,var2);
  return i;
}

int half2_e_3256c() {
  // { dg-printf -re "half2_e_3256c===.*===.*===" }
  half2 var1 = (half2) (8,-7);
  half2 var2 = (half2) (-6,-1);
  int i = printf("half2_e_3256c===%-+.10v2hE===%-+.10v2hE===\n",var1,var2);
  return i;
}

int half2_e_4007c() {
  // { dg-printf -re "half2_e_4007c===.*===.*===" }
  half2 var1 = (half2) (2,-2);
  half2 var2 = (half2) (2,-1);
  int i = printf("half2_e_4007c===% 10v2he===% 10v2he===\n",var1,var2);
  return i;
}

int half2_e_4008c() {
  // { dg-printf -re "half2_e_4008c===.*===.*===" }
  half2 var1 = (half2) (-5,5);
  half2 var2 = (half2) (-123455,-123455);
  int i = printf("half2_e_4008c===% 10.1v2he===% 10.1v2he===\n",var1,var2);
  return i;
}

int half2_e_4009c() {
  // { dg-printf -re "half2_e_4009c===.*===.*===" }
  half2 var1 = (half2) (-1,3);
  half2 var2 = (half2) (-5,1);
  int i = printf("half2_e_4009c===% 10.2v2he===% 10.2v2he===\n",var1,var2);
  return i;
}

int half2_e_4010c() {
  // { dg-printf -re "half2_e_4010c===.*===.*===" }
  half2 var1 = (half2) (-2,-8);
  half2 var2 = (half2) (1,-6);
  int i = printf("half2_e_4010c===% 10.3v2he===% 10.3v2he===\n",var1,var2);
  return i;
}

int half2_e_4011c() {
  // { dg-printf -re "half2_e_4011c===.*===.*===" }
  half2 var1 = (half2) (-6,6);
  half2 var2 = (half2) (-3,5);
  int i = printf("half2_e_4011c===% 10.10v2he===% 10.10v2he===\n",var1,var2);
  return i;
}

int half2_e_4012c() {
  // { dg-printf -re "half2_e_4012c===.*===.*===" }
  half2 var1 = (half2) (-2,8);
  half2 var2 = (half2) (-3,5);
  int i = printf("half2_e_4012c===% 10v2hE===% 10v2hE===\n",var1,var2);
  return i;
}

int half2_e_4013c() {
  // { dg-printf -re "half2_e_4013c===.*===.*===" }
  half2 var1 = (half2) (1,8);
  half2 var2 = (half2) (-5,0);
  int i = printf("half2_e_4013c===% 10.1v2hE===% 10.1v2hE===\n",var1,var2);
  return i;
}

int half2_e_4014c() {
  // { dg-printf -re "half2_e_4014c===.*===.*===" }
  half2 var1 = (half2) (5,3);
  half2 var2 = (half2) (8,8);
  int i = printf("half2_e_4014c===% 10.2v2hE===% 10.2v2hE===\n",var1,var2);
  return i;
}

int half2_e_4015c() {
  // { dg-printf -re "half2_e_4015c===.*===.*===" }
  half2 var1 = (half2) (-1,-6);
  half2 var2 = (half2) (-123455,-6);
  int i = printf("half2_e_4015c===% 10.3v2hE===% 10.3v2hE===\n",var1,var2);
  return i;
}

int half2_e_4016c() {
  // { dg-printf -re "half2_e_4016c===.*===.*===" }
  half2 var1 = (half2) (-1,2);
  half2 var2 = (half2) (1,-5);
  int i = printf("half2_e_4016c===% 10.10v2hE===% 10.10v2hE===\n",var1,var2);
  return i;
}

int half2_e_4767c() {
  // { dg-printf -re "half2_e_4767c===.*===.*===" }
  half2 var1 = (half2) (1,1);
  half2 var2 = (half2) (4,-2);
  int i = printf("half2_e_4767c===%010v2he===%010v2he===\n",var1,var2);
  return i;
}

int half2_e_4768c() {
  // { dg-printf -re "half2_e_4768c===.*===.*===" }
  half2 var1 = (half2) (-123455,-5);
  half2 var2 = (half2) (-3,-7);
  int i = printf("half2_e_4768c===%010.1v2he===%010.1v2he===\n",var1,var2);
  return i;
}

int half2_e_4769c() {
  // { dg-printf -re "half2_e_4769c===.*===.*===" }
  half2 var1 = (half2) (5,6);
  half2 var2 = (half2) (4,-123455);
  int i = printf("half2_e_4769c===%010.2v2he===%010.2v2he===\n",var1,var2);
  return i;
}

int half2_e_4770c() {
  // { dg-printf -re "half2_e_4770c===.*===.*===" }
  half2 var1 = (half2) (3,7);
  half2 var2 = (half2) (3,-5);
  int i = printf("half2_e_4770c===%010.3v2he===%010.3v2he===\n",var1,var2);
  return i;
}

int half2_e_4771c() {
  // { dg-printf -re "half2_e_4771c===.*===.*===" }
  half2 var1 = (half2) (0,-123455);
  half2 var2 = (half2) (-123455,-1);
  int i = printf("half2_e_4771c===%010.10v2he===%010.10v2he===\n",var1,var2);
  return i;
}

int half2_e_4772c() {
  // { dg-printf -re "half2_e_4772c===.*===.*===" }
  half2 var1 = (half2) (4,2);
  half2 var2 = (half2) (-2,-2);
  int i = printf("half2_e_4772c===%010v2hE===%010v2hE===\n",var1,var2);
  return i;
}

int half2_e_4773c() {
  // { dg-printf -re "half2_e_4773c===.*===.*===" }
  half2 var1 = (half2) (5,-7);
  half2 var2 = (half2) (-3,8);
  int i = printf("half2_e_4773c===%010.1v2hE===%010.1v2hE===\n",var1,var2);
  return i;
}

int half2_e_4774c() {
  // { dg-printf -re "half2_e_4774c===.*===.*===" }
  half2 var1 = (half2) (123445,-123455);
  half2 var2 = (half2) (-3,-1);
  int i = printf("half2_e_4774c===%010.2v2hE===%010.2v2hE===\n",var1,var2);
  return i;
}

int half2_e_4775c() {
  // { dg-printf -re "half2_e_4775c===.*===.*===" }
  half2 var1 = (half2) (-4,2);
  half2 var2 = (half2) (8,-4);
  int i = printf("half2_e_4775c===%010.3v2hE===%010.3v2hE===\n",var1,var2);
  return i;
}

int half2_e_4776c() {
  // { dg-printf -re "half2_e_4776c===.*===.*===" }
  half2 var1 = (half2) (5,4);
  half2 var2 = (half2) (-123455,123445);
  int i = printf("half2_e_4776c===%010.10v2hE===%010.10v2hE===\n",var1,var2);
  return i;
}

int half2_e_5527c() {
  // { dg-printf -re "half2_e_5527c===.*===.*===" }
  half2 var1 = (half2) (7,8);
  half2 var2 = (half2) (123445,123445);
  int i = printf("half2_e_5527c===%- 10v2he===%- 10v2he===\n",var1,var2);
  return i;
}

int half2_e_5528c() {
  // { dg-printf -re "half2_e_5528c===.*===.*===" }
  half2 var1 = (half2) (6,4);
  half2 var2 = (half2) (-8,5);
  int i = printf("half2_e_5528c===%- 10.1v2he===%- 10.1v2he===\n",var1,var2);
  return i;
}

int half2_e_5529c() {
  // { dg-printf -re "half2_e_5529c===.*===.*===" }
  half2 var1 = (half2) (5,-3);
  half2 var2 = (half2) (7,-5);
  int i = printf("half2_e_5529c===%- 10.2v2he===%- 10.2v2he===\n",var1,var2);
  return i;
}

int half2_e_5530c() {
  // { dg-printf -re "half2_e_5530c===.*===.*===" }
  half2 var1 = (half2) (-5,-5);
  half2 var2 = (half2) (-5,6);
  int i = printf("half2_e_5530c===%- 10.3v2he===%- 10.3v2he===\n",var1,var2);
  return i;
}

int half2_e_5531c() {
  // { dg-printf -re "half2_e_5531c===.*===.*===" }
  half2 var1 = (half2) (1,2);
  half2 var2 = (half2) (0,8);
  int i = printf("half2_e_5531c===%- 10.10v2he===%- 10.10v2he===\n",var1,var2);
  return i;
}

int half2_e_5532c() {
  // { dg-printf -re "half2_e_5532c===.*===.*===" }
  half2 var1 = (half2) (7,8);
  half2 var2 = (half2) (-123455,-3);
  int i = printf("half2_e_5532c===%- 10v2hE===%- 10v2hE===\n",var1,var2);
  return i;
}

int half2_e_5533c() {
  // { dg-printf -re "half2_e_5533c===.*===.*===" }
  half2 var1 = (half2) (-6,1);
  half2 var2 = (half2) (-2,0);
  int i = printf("half2_e_5533c===%- 10.1v2hE===%- 10.1v2hE===\n",var1,var2);
  return i;
}

int half2_e_5534c() {
  // { dg-printf -re "half2_e_5534c===.*===.*===" }
  half2 var1 = (half2) (7,7);
  half2 var2 = (half2) (0,-2);
  int i = printf("half2_e_5534c===%- 10.2v2hE===%- 10.2v2hE===\n",var1,var2);
  return i;
}

int half2_e_5535c() {
  // { dg-printf -re "half2_e_5535c===.*===.*===" }
  half2 var1 = (half2) (-7,4);
  half2 var2 = (half2) (7,123445);
  int i = printf("half2_e_5535c===%- 10.3v2hE===%- 10.3v2hE===\n",var1,var2);
  return i;
}

int half2_e_5536c() {
  // { dg-printf -re "half2_e_5536c===.*===.*===" }
  half2 var1 = (half2) (-7,-3);
  half2 var2 = (half2) (-5,123445);
  int i = printf("half2_e_5536c===%- 10.10v2hE===%- 10.10v2hE===\n",var1,var2);
  return i;
}

int half2_e_6287c() {
  // { dg-printf -re "half2_e_6287c===.*===.*===" }
  half2 var1 = (half2) (-6,7);
  half2 var2 = (half2) (5,-8);
  int i = printf("half2_e_6287c===%+ 10v2he===%+ 10v2he===\n",var1,var2);
  return i;
}

int half2_e_6288c() {
  // { dg-printf -re "half2_e_6288c===.*===.*===" }
  half2 var1 = (half2) (-2,2);
  half2 var2 = (half2) (1,-4);
  int i = printf("half2_e_6288c===%+ 10.1v2he===%+ 10.1v2he===\n",var1,var2);
  return i;
}

int half2_e_6289c() {
  // { dg-printf -re "half2_e_6289c===.*===.*===" }
  half2 var1 = (half2) (8,7);
  half2 var2 = (half2) (-1,5);
  int i = printf("half2_e_6289c===%+ 10.2v2he===%+ 10.2v2he===\n",var1,var2);
  return i;
}

int half2_e_6290c() {
  // { dg-printf -re "half2_e_6290c===.*===.*===" }
  half2 var1 = (half2) (-123455,-7);
  half2 var2 = (half2) (-1,-8);
  int i = printf("half2_e_6290c===%+ 10.3v2he===%+ 10.3v2he===\n",var1,var2);
  return i;
}

int half2_e_6291c() {
  // { dg-printf -re "half2_e_6291c===.*===.*===" }
  half2 var1 = (half2) (-7,-8);
  half2 var2 = (half2) (4,0);
  int i = printf("half2_e_6291c===%+ 10.10v2he===%+ 10.10v2he===\n",var1,var2);
  return i;
}

int half2_e_6292c() {
  // { dg-printf -re "half2_e_6292c===.*===.*===" }
  half2 var1 = (half2) (-8,123445);
  half2 var2 = (half2) (8,1);
  int i = printf("half2_e_6292c===%+ 10v2hE===%+ 10v2hE===\n",var1,var2);
  return i;
}

int half2_e_6293c() {
  // { dg-printf -re "half2_e_6293c===.*===.*===" }
  half2 var1 = (half2) (-7,7);
  half2 var2 = (half2) (4,-5);
  int i = printf("half2_e_6293c===%+ 10.1v2hE===%+ 10.1v2hE===\n",var1,var2);
  return i;
}

int half2_e_6294c() {
  // { dg-printf -re "half2_e_6294c===.*===.*===" }
  half2 var1 = (half2) (-6,-1);
  half2 var2 = (half2) (5,-4);
  int i = printf("half2_e_6294c===%+ 10.2v2hE===%+ 10.2v2hE===\n",var1,var2);
  return i;
}

int half2_e_6295c() {
  // { dg-printf -re "half2_e_6295c===.*===.*===" }
  half2 var1 = (half2) (-7,123445);
  half2 var2 = (half2) (2,-8);
  int i = printf("half2_e_6295c===%+ 10.3v2hE===%+ 10.3v2hE===\n",var1,var2);
  return i;
}

int half2_e_6296c() {
  // { dg-printf -re "half2_e_6296c===.*===.*===" }
  half2 var1 = (half2) (7,1);
  half2 var2 = (half2) (-5,-1);
  int i = printf("half2_e_6296c===%+ 10.10v2hE===%+ 10.10v2hE===\n",var1,var2);
  return i;
}

int half2_e_7047c() {
  // { dg-printf -re "half2_e_7047c===.*===.*===" }
  half2 var1 = (half2) (-4,-123455);
  half2 var2 = (half2) (-123455,8);
  int i = printf("half2_e_7047c===%+010v2he===%+010v2he===\n",var1,var2);
  return i;
}

int half2_e_7048c() {
  // { dg-printf -re "half2_e_7048c===.*===.*===" }
  half2 var1 = (half2) (0,123445);
  half2 var2 = (half2) (2,-8);
  int i = printf("half2_e_7048c===%+010.1v2he===%+010.1v2he===\n",var1,var2);
  return i;
}

int half2_e_7049c() {
  // { dg-printf -re "half2_e_7049c===.*===.*===" }
  half2 var1 = (half2) (1,4);
  half2 var2 = (half2) (7,0);
  int i = printf("half2_e_7049c===%+010.2v2he===%+010.2v2he===\n",var1,var2);
  return i;
}

int half2_e_7050c() {
  // { dg-printf -re "half2_e_7050c===.*===.*===" }
  half2 var1 = (half2) (-123455,6);
  half2 var2 = (half2) (-6,-6);
  int i = printf("half2_e_7050c===%+010.3v2he===%+010.3v2he===\n",var1,var2);
  return i;
}

int half2_e_7051c() {
  // { dg-printf -re "half2_e_7051c===.*===.*===" }
  half2 var1 = (half2) (6,-3);
  half2 var2 = (half2) (-5,-4);
  int i = printf("half2_e_7051c===%+010.10v2he===%+010.10v2he===\n",var1,var2);
  return i;
}

int half2_e_7052c() {
  // { dg-printf -re "half2_e_7052c===.*===.*===" }
  half2 var1 = (half2) (-4,-4);
  half2 var2 = (half2) (-8,-2);
  int i = printf("half2_e_7052c===%+010v2hE===%+010v2hE===\n",var1,var2);
  return i;
}

int half2_e_7053c() {
  // { dg-printf -re "half2_e_7053c===.*===.*===" }
  half2 var1 = (half2) (5,-4);
  half2 var2 = (half2) (-5,7);
  int i = printf("half2_e_7053c===%+010.1v2hE===%+010.1v2hE===\n",var1,var2);
  return i;
}

int half2_e_7054c() {
  // { dg-printf -re "half2_e_7054c===.*===.*===" }
  half2 var1 = (half2) (-6,1);
  half2 var2 = (half2) (-2,-8);
  int i = printf("half2_e_7054c===%+010.2v2hE===%+010.2v2hE===\n",var1,var2);
  return i;
}

int half2_e_7055c() {
  // { dg-printf -re "half2_e_7055c===.*===.*===" }
  half2 var1 = (half2) (6,3);
  half2 var2 = (half2) (1,-8);
  int i = printf("half2_e_7055c===%+010.3v2hE===%+010.3v2hE===\n",var1,var2);
  return i;
}

int half2_e_7056c() {
  // { dg-printf -re "half2_e_7056c===.*===.*===" }
  half2 var1 = (half2) (-8,-2);
  half2 var2 = (half2) (123445,2);
  int i = printf("half2_e_7056c===%+010.10v2hE===%+010.10v2hE===\n",var1,var2);
  return i;
}

int half2_e_967c() {
  // { dg-printf -re "half2_e_967c===.*===.*===" }
  half2 var1 = (half2) (-7,123445);
  half2 var2 = (half2) (1,1);
  int i = printf("half2_e_967c===%-v2he===%-v2he===\n",var1,var2);
  return i;
}

int half2_e_968c() {
  // { dg-printf -re "half2_e_968c===.*===.*===" }
  half2 var1 = (half2) (-5,8);
  half2 var2 = (half2) (3,3);
  int i = printf("half2_e_968c===%-.1v2he===%-.1v2he===\n",var1,var2);
  return i;
}

int half2_e_969c() {
  // { dg-printf -re "half2_e_969c===.*===.*===" }
  half2 var1 = (half2) (6,0);
  half2 var2 = (half2) (-123455,1);
  int i = printf("half2_e_969c===%-.2v2he===%-.2v2he===\n",var1,var2);
  return i;
}

int half2_e_970c() {
  // { dg-printf -re "half2_e_970c===.*===.*===" }
  half2 var1 = (half2) (4,1);
  half2 var2 = (half2) (3,-2);
  int i = printf("half2_e_970c===%-.3v2he===%-.3v2he===\n",var1,var2);
  return i;
}

int half2_e_971c() {
  // { dg-printf -re "half2_e_971c===.*===.*===" }
  half2 var1 = (half2) (-5,2);
  half2 var2 = (half2) (4,3);
  int i = printf("half2_e_971c===%-.10v2he===%-.10v2he===\n",var1,var2);
  return i;
}

int half2_e_972c() {
  // { dg-printf -re "half2_e_972c===.*===.*===" }
  half2 var1 = (half2) (4,-123455);
  half2 var2 = (half2) (-8,-1);
  int i = printf("half2_e_972c===%-v2hE===%-v2hE===\n",var1,var2);
  return i;
}

int half2_e_973c() {
  // { dg-printf -re "half2_e_973c===.*===.*===" }
  half2 var1 = (half2) (-7,-1);
  half2 var2 = (half2) (-2,-2);
  int i = printf("half2_e_973c===%-.1v2hE===%-.1v2hE===\n",var1,var2);
  return i;
}

int half2_e_974c() {
  // { dg-printf -re "half2_e_974c===.*===.*===" }
  half2 var1 = (half2) (0,-8);
  half2 var2 = (half2) (-123455,4);
  int i = printf("half2_e_974c===%-.2v2hE===%-.2v2hE===\n",var1,var2);
  return i;
}

int half2_e_975c() {
  // { dg-printf -re "half2_e_975c===.*===.*===" }
  half2 var1 = (half2) (-5,-4);
  half2 var2 = (half2) (-8,-123455);
  int i = printf("half2_e_975c===%-.3v2hE===%-.3v2hE===\n",var1,var2);
  return i;
}

int half2_e_976c() {
  // { dg-printf -re "half2_e_976c===.*===.*===" }
  half2 var1 = (half2) (-8,-7);
  half2 var2 = (half2) (-3,-6);
  int i = printf("half2_e_976c===%-.10v2hE===%-.10v2hE===\n",var1,var2);
  return i;
}

int half2_f_1737c() {
  // { dg-printf -re "half2_f_1737c===.*===.*===" }
  half2 var1 = (half2) (4,1);
  half2 var2 = (half2) (5,123445);
  int i = printf("half2_f_1737c===%+v2hf===%+v2hf===\n",var1,var2);
  return i;
}

int half2_f_1738c() {
  // { dg-printf -re "half2_f_1738c===.*===.*===" }
  half2 var1 = (half2) (-4,6);
  half2 var2 = (half2) (123445,-3);
  int i = printf("half2_f_1738c===%+.1v2hf===%+.1v2hf===\n",var1,var2);
  return i;
}

int half2_f_1739c() {
  // { dg-printf -re "half2_f_1739c===.*===.*===" }
  half2 var1 = (half2) (6,4);
  half2 var2 = (half2) (2,1);
  int i = printf("half2_f_1739c===%+.2v2hf===%+.2v2hf===\n",var1,var2);
  return i;
}

int half2_f_1740c() {
  // { dg-printf -re "half2_f_1740c===.*===.*===" }
  half2 var1 = (half2) (2,-8);
  half2 var2 = (half2) (-3,-1);
  int i = printf("half2_f_1740c===%+.3v2hf===%+.3v2hf===\n",var1,var2);
  return i;
}

int half2_f_1741c() {
  // { dg-printf -re "half2_f_1741c===.*===.*===" }
  half2 var1 = (half2) (-3,-1);
  half2 var2 = (half2) (8,-6);
  int i = printf("half2_f_1741c===%+.10v2hf===%+.10v2hf===\n",var1,var2);
  return i;
}

int half2_f_1742c() {
  // { dg-printf -re "half2_f_1742c===.*===.*===" }
  half2 var1 = (half2) (4,-8);
  half2 var2 = (half2) (4,2);
  int i = printf("half2_f_1742c===%+v2hF===%+v2hF===\n",var1,var2);
  return i;
}

int half2_f_1743c() {
  // { dg-printf -re "half2_f_1743c===.*===.*===" }
  half2 var1 = (half2) (2,-7);
  half2 var2 = (half2) (8,-8);
  int i = printf("half2_f_1743c===%+.1v2hF===%+.1v2hF===\n",var1,var2);
  return i;
}

int half2_f_1744c() {
  // { dg-printf -re "half2_f_1744c===.*===.*===" }
  half2 var1 = (half2) (123445,-5);
  half2 var2 = (half2) (2,123445);
  int i = printf("half2_f_1744c===%+.2v2hF===%+.2v2hF===\n",var1,var2);
  return i;
}

int half2_f_1745c() {
  // { dg-printf -re "half2_f_1745c===.*===.*===" }
  half2 var1 = (half2) (5,-8);
  half2 var2 = (half2) (123445,2);
  int i = printf("half2_f_1745c===%+.3v2hF===%+.3v2hF===\n",var1,var2);
  return i;
}

int half2_f_1746c() {
  // { dg-printf -re "half2_f_1746c===.*===.*===" }
  half2 var1 = (half2) (-3,5);
  half2 var2 = (half2) (123445,123445);
  int i = printf("half2_f_1746c===%+.10v2hF===%+.10v2hF===\n",var1,var2);
  return i;
}

int half2_f_217c() {
  // { dg-printf -re "half2_f_217c===.*===.*===" }
  half2 var1 = (half2) (-1,4);
  half2 var2 = (half2) (6,-2);
  int i = printf("half2_f_217c===%v2hf===%v2hf===\n",var1,var2);
  return i;
}

int half2_f_218c() {
  // { dg-printf -re "half2_f_218c===.*===.*===" }
  half2 var1 = (half2) (-7,6);
  half2 var2 = (half2) (123445,-1);
  int i = printf("half2_f_218c===%.1v2hf===%.1v2hf===\n",var1,var2);
  return i;
}

int half2_f_219c() {
  // { dg-printf -re "half2_f_219c===.*===.*===" }
  half2 var1 = (half2) (-123455,6);
  half2 var2 = (half2) (7,-123455);
  int i = printf("half2_f_219c===%.2v2hf===%.2v2hf===\n",var1,var2);
  return i;
}

int half2_f_220c() {
  // { dg-printf -re "half2_f_220c===.*===.*===" }
  half2 var1 = (half2) (2,3);
  half2 var2 = (half2) (-123455,-4);
  int i = printf("half2_f_220c===%.3v2hf===%.3v2hf===\n",var1,var2);
  return i;
}

int half2_f_221c() {
  // { dg-printf -re "half2_f_221c===.*===.*===" }
  half2 var1 = (half2) (2,7);
  half2 var2 = (half2) (4,-6);
  int i = printf("half2_f_221c===%.10v2hf===%.10v2hf===\n",var1,var2);
  return i;
}

int half2_f_222c() {
  // { dg-printf -re "half2_f_222c===.*===.*===" }
  half2 var1 = (half2) (-4,8);
  half2 var2 = (half2) (-4,-3);
  int i = printf("half2_f_222c===%v2hF===%v2hF===\n",var1,var2);
  return i;
}

int half2_f_223c() {
  // { dg-printf -re "half2_f_223c===.*===.*===" }
  half2 var1 = (half2) (7,0);
  half2 var2 = (half2) (-1,8);
  int i = printf("half2_f_223c===%.1v2hF===%.1v2hF===\n",var1,var2);
  return i;
}

int half2_f_224c() {
  // { dg-printf -re "half2_f_224c===.*===.*===" }
  half2 var1 = (half2) (-8,4);
  half2 var2 = (half2) (-6,5);
  int i = printf("half2_f_224c===%.2v2hF===%.2v2hF===\n",var1,var2);
  return i;
}

int half2_f_225c() {
  // { dg-printf -re "half2_f_225c===.*===.*===" }
  half2 var1 = (half2) (-123455,5);
  half2 var2 = (half2) (3,2);
  int i = printf("half2_f_225c===%.3v2hF===%.3v2hF===\n",var1,var2);
  return i;
}

int half2_f_226c() {
  // { dg-printf -re "half2_f_226c===.*===.*===" }
  half2 var1 = (half2) (-1,8);
  half2 var2 = (half2) (1,0);
  int i = printf("half2_f_226c===%.10v2hF===%.10v2hF===\n",var1,var2);
  return i;
}

int half2_f_2497c() {
  // { dg-printf -re "half2_f_2497c===.*===.*===" }
  half2 var1 = (half2) (-5,8);
  half2 var2 = (half2) (8,3);
  int i = printf("half2_f_2497c===%#v2hf===%#v2hf===\n",var1,var2);
  return i;
}

int half2_f_2498c() {
  // { dg-printf -re "half2_f_2498c===.*===.*===" }
  half2 var1 = (half2) (7,-8);
  half2 var2 = (half2) (6,-7);
  int i = printf("half2_f_2498c===%#.1v2hf===%#.1v2hf===\n",var1,var2);
  return i;
}

int half2_f_2499c() {
  // { dg-printf -re "half2_f_2499c===.*===.*===" }
  half2 var1 = (half2) (-4,-4);
  half2 var2 = (half2) (0,-1);
  int i = printf("half2_f_2499c===%#.2v2hf===%#.2v2hf===\n",var1,var2);
  return i;
}

int half2_f_2500c() {
  // { dg-printf -re "half2_f_2500c===.*===.*===" }
  half2 var1 = (half2) (4,5);
  half2 var2 = (half2) (123445,6);
  int i = printf("half2_f_2500c===%#.3v2hf===%#.3v2hf===\n",var1,var2);
  return i;
}

int half2_f_2501c() {
  // { dg-printf -re "half2_f_2501c===.*===.*===" }
  half2 var1 = (half2) (6,-6);
  half2 var2 = (half2) (-1,4);
  int i = printf("half2_f_2501c===%#.10v2hf===%#.10v2hf===\n",var1,var2);
  return i;
}

int half2_f_2502c() {
  // { dg-printf -re "half2_f_2502c===.*===.*===" }
  half2 var1 = (half2) (4,-3);
  half2 var2 = (half2) (-5,-3);
  int i = printf("half2_f_2502c===%#v2hF===%#v2hF===\n",var1,var2);
  return i;
}

int half2_f_2503c() {
  // { dg-printf -re "half2_f_2503c===.*===.*===" }
  half2 var1 = (half2) (4,4);
  half2 var2 = (half2) (-4,5);
  int i = printf("half2_f_2503c===%#.1v2hF===%#.1v2hF===\n",var1,var2);
  return i;
}

int half2_f_2504c() {
  // { dg-printf -re "half2_f_2504c===.*===.*===" }
  half2 var1 = (half2) (0,-4);
  half2 var2 = (half2) (1,-5);
  int i = printf("half2_f_2504c===%#.2v2hF===%#.2v2hF===\n",var1,var2);
  return i;
}

int half2_f_2505c() {
  // { dg-printf -re "half2_f_2505c===.*===.*===" }
  half2 var1 = (half2) (-8,1);
  half2 var2 = (half2) (0,2);
  int i = printf("half2_f_2505c===%#.3v2hF===%#.3v2hF===\n",var1,var2);
  return i;
}

int half2_f_2506c() {
  // { dg-printf -re "half2_f_2506c===.*===.*===" }
  half2 var1 = (half2) (6,-3);
  half2 var2 = (half2) (-4,5);
  int i = printf("half2_f_2506c===%#.10v2hF===%#.10v2hF===\n",var1,var2);
  return i;
}

int half2_f_3257c() {
  // { dg-printf -re "half2_f_3257c===.*===.*===" }
  half2 var1 = (half2) (-1,2);
  half2 var2 = (half2) (-7,-2);
  int i = printf("half2_f_3257c===%-+v2hf===%-+v2hf===\n",var1,var2);
  return i;
}

int half2_f_3258c() {
  // { dg-printf -re "half2_f_3258c===.*===.*===" }
  half2 var1 = (half2) (0,3);
  half2 var2 = (half2) (-2,8);
  int i = printf("half2_f_3258c===%-+.1v2hf===%-+.1v2hf===\n",var1,var2);
  return i;
}

int half2_f_3259c() {
  // { dg-printf -re "half2_f_3259c===.*===.*===" }
  half2 var1 = (half2) (7,123445);
  half2 var2 = (half2) (6,-6);
  int i = printf("half2_f_3259c===%-+.2v2hf===%-+.2v2hf===\n",var1,var2);
  return i;
}

int half2_f_3260c() {
  // { dg-printf -re "half2_f_3260c===.*===.*===" }
  half2 var1 = (half2) (7,6);
  half2 var2 = (half2) (123445,3);
  int i = printf("half2_f_3260c===%-+.3v2hf===%-+.3v2hf===\n",var1,var2);
  return i;
}

int half2_f_3261c() {
  // { dg-printf -re "half2_f_3261c===.*===.*===" }
  half2 var1 = (half2) (-2,6);
  half2 var2 = (half2) (-8,-2);
  int i = printf("half2_f_3261c===%-+.10v2hf===%-+.10v2hf===\n",var1,var2);
  return i;
}

int half2_f_3262c() {
  // { dg-printf -re "half2_f_3262c===.*===.*===" }
  half2 var1 = (half2) (1,-7);
  half2 var2 = (half2) (4,-1);
  int i = printf("half2_f_3262c===%-+v2hF===%-+v2hF===\n",var1,var2);
  return i;
}

int half2_f_3263c() {
  // { dg-printf -re "half2_f_3263c===.*===.*===" }
  half2 var1 = (half2) (-3,0);
  half2 var2 = (half2) (8,-8);
  int i = printf("half2_f_3263c===%-+.1v2hF===%-+.1v2hF===\n",var1,var2);
  return i;
}

int half2_f_3264c() {
  // { dg-printf -re "half2_f_3264c===.*===.*===" }
  half2 var1 = (half2) (-4,7);
  half2 var2 = (half2) (-8,-8);
  int i = printf("half2_f_3264c===%-+.2v2hF===%-+.2v2hF===\n",var1,var2);
  return i;
}

int half2_f_3265c() {
  // { dg-printf -re "half2_f_3265c===.*===.*===" }
  half2 var1 = (half2) (-2,8);
  half2 var2 = (half2) (5,-7);
  int i = printf("half2_f_3265c===%-+.3v2hF===%-+.3v2hF===\n",var1,var2);
  return i;
}

int half2_f_3266c() {
  // { dg-printf -re "half2_f_3266c===.*===.*===" }
  half2 var1 = (half2) (-6,6);
  half2 var2 = (half2) (-1,-8);
  int i = printf("half2_f_3266c===%-+.10v2hF===%-+.10v2hF===\n",var1,var2);
  return i;
}

int half2_f_4017c() {
  // { dg-printf -re "half2_f_4017c===.*===.*===" }
  half2 var1 = (half2) (-5,3);
  half2 var2 = (half2) (3,4);
  int i = printf("half2_f_4017c===% 10v2hf===% 10v2hf===\n",var1,var2);
  return i;
}

int half2_f_4018c() {
  // { dg-printf -re "half2_f_4018c===.*===.*===" }
  half2 var1 = (half2) (-2,4);
  half2 var2 = (half2) (123445,-6);
  int i = printf("half2_f_4018c===% 10.1v2hf===% 10.1v2hf===\n",var1,var2);
  return i;
}

int half2_f_4019c() {
  // { dg-printf -re "half2_f_4019c===.*===.*===" }
  half2 var1 = (half2) (-123455,123445);
  half2 var2 = (half2) (-4,2);
  int i = printf("half2_f_4019c===% 10.2v2hf===% 10.2v2hf===\n",var1,var2);
  return i;
}

int half2_f_4020c() {
  // { dg-printf -re "half2_f_4020c===.*===.*===" }
  half2 var1 = (half2) (6,-5);
  half2 var2 = (half2) (2,4);
  int i = printf("half2_f_4020c===% 10.3v2hf===% 10.3v2hf===\n",var1,var2);
  return i;
}

int half2_f_4021c() {
  // { dg-printf -re "half2_f_4021c===.*===.*===" }
  half2 var1 = (half2) (1,-3);
  half2 var2 = (half2) (-123455,8);
  int i = printf("half2_f_4021c===% 10.10v2hf===% 10.10v2hf===\n",var1,var2);
  return i;
}

int half2_f_4022c() {
  // { dg-printf -re "half2_f_4022c===.*===.*===" }
  half2 var1 = (half2) (2,1);
  half2 var2 = (half2) (-7,-123455);
  int i = printf("half2_f_4022c===% 10v2hF===% 10v2hF===\n",var1,var2);
  return i;
}

int half2_f_4023c() {
  // { dg-printf -re "half2_f_4023c===.*===.*===" }
  half2 var1 = (half2) (-3,8);
  half2 var2 = (half2) (2,-123455);
  int i = printf("half2_f_4023c===% 10.1v2hF===% 10.1v2hF===\n",var1,var2);
  return i;
}

int half2_f_4024c() {
  // { dg-printf -re "half2_f_4024c===.*===.*===" }
  half2 var1 = (half2) (-8,-8);
  half2 var2 = (half2) (2,6);
  int i = printf("half2_f_4024c===% 10.2v2hF===% 10.2v2hF===\n",var1,var2);
  return i;
}

int half2_f_4025c() {
  // { dg-printf -re "half2_f_4025c===.*===.*===" }
  half2 var1 = (half2) (4,-123455);
  half2 var2 = (half2) (5,-4);
  int i = printf("half2_f_4025c===% 10.3v2hF===% 10.3v2hF===\n",var1,var2);
  return i;
}

int half2_f_4026c() {
  // { dg-printf -re "half2_f_4026c===.*===.*===" }
  half2 var1 = (half2) (-2,123445);
  half2 var2 = (half2) (5,-5);
  int i = printf("half2_f_4026c===% 10.10v2hF===% 10.10v2hF===\n",var1,var2);
  return i;
}

int half2_f_4777c() {
  // { dg-printf -re "half2_f_4777c===.*===.*===" }
  half2 var1 = (half2) (-2,-6);
  half2 var2 = (half2) (-4,-4);
  int i = printf("half2_f_4777c===%010v2hf===%010v2hf===\n",var1,var2);
  return i;
}

int half2_f_4778c() {
  // { dg-printf -re "half2_f_4778c===.*===.*===" }
  half2 var1 = (half2) (2,-1);
  half2 var2 = (half2) (-6,-2);
  int i = printf("half2_f_4778c===%010.1v2hf===%010.1v2hf===\n",var1,var2);
  return i;
}

int half2_f_4779c() {
  // { dg-printf -re "half2_f_4779c===.*===.*===" }
  half2 var1 = (half2) (-8,-7);
  half2 var2 = (half2) (-1,-2);
  int i = printf("half2_f_4779c===%010.2v2hf===%010.2v2hf===\n",var1,var2);
  return i;
}

int half2_f_4780c() {
  // { dg-printf -re "half2_f_4780c===.*===.*===" }
  half2 var1 = (half2) (1,4);
  half2 var2 = (half2) (-5,0);
  int i = printf("half2_f_4780c===%010.3v2hf===%010.3v2hf===\n",var1,var2);
  return i;
}

int half2_f_4781c() {
  // { dg-printf -re "half2_f_4781c===.*===.*===" }
  half2 var1 = (half2) (0,6);
  half2 var2 = (half2) (-7,-2);
  int i = printf("half2_f_4781c===%010.10v2hf===%010.10v2hf===\n",var1,var2);
  return i;
}

int half2_f_4782c() {
  // { dg-printf -re "half2_f_4782c===.*===.*===" }
  half2 var1 = (half2) (4,6);
  half2 var2 = (half2) (-7,-3);
  int i = printf("half2_f_4782c===%010v2hF===%010v2hF===\n",var1,var2);
  return i;
}

int half2_f_4783c() {
  // { dg-printf -re "half2_f_4783c===.*===.*===" }
  half2 var1 = (half2) (2,3);
  half2 var2 = (half2) (123445,-7);
  int i = printf("half2_f_4783c===%010.1v2hF===%010.1v2hF===\n",var1,var2);
  return i;
}

int half2_f_4784c() {
  // { dg-printf -re "half2_f_4784c===.*===.*===" }
  half2 var1 = (half2) (-4,-1);
  half2 var2 = (half2) (-6,-2);
  int i = printf("half2_f_4784c===%010.2v2hF===%010.2v2hF===\n",var1,var2);
  return i;
}

int half2_f_4785c() {
  // { dg-printf -re "half2_f_4785c===.*===.*===" }
  half2 var1 = (half2) (7,-6);
  half2 var2 = (half2) (8,-123455);
  int i = printf("half2_f_4785c===%010.3v2hF===%010.3v2hF===\n",var1,var2);
  return i;
}

int half2_f_4786c() {
  // { dg-printf -re "half2_f_4786c===.*===.*===" }
  half2 var1 = (half2) (0,2);
  half2 var2 = (half2) (1,4);
  int i = printf("half2_f_4786c===%010.10v2hF===%010.10v2hF===\n",var1,var2);
  return i;
}

int half2_f_5537c() {
  // { dg-printf -re "half2_f_5537c===.*===.*===" }
  half2 var1 = (half2) (-4,2);
  half2 var2 = (half2) (0,-6);
  int i = printf("half2_f_5537c===%- 10v2hf===%- 10v2hf===\n",var1,var2);
  return i;
}

int half2_f_5538c() {
  // { dg-printf -re "half2_f_5538c===.*===.*===" }
  half2 var1 = (half2) (0,7);
  half2 var2 = (half2) (-8,6);
  int i = printf("half2_f_5538c===%- 10.1v2hf===%- 10.1v2hf===\n",var1,var2);
  return i;
}

int half2_f_5539c() {
  // { dg-printf -re "half2_f_5539c===.*===.*===" }
  half2 var1 = (half2) (3,3);
  half2 var2 = (half2) (-4,0);
  int i = printf("half2_f_5539c===%- 10.2v2hf===%- 10.2v2hf===\n",var1,var2);
  return i;
}

int half2_f_5540c() {
  // { dg-printf -re "half2_f_5540c===.*===.*===" }
  half2 var1 = (half2) (1,5);
  half2 var2 = (half2) (-7,8);
  int i = printf("half2_f_5540c===%- 10.3v2hf===%- 10.3v2hf===\n",var1,var2);
  return i;
}

int half2_f_5541c() {
  // { dg-printf -re "half2_f_5541c===.*===.*===" }
  half2 var1 = (half2) (-2,-5);
  half2 var2 = (half2) (2,-3);
  int i = printf("half2_f_5541c===%- 10.10v2hf===%- 10.10v2hf===\n",var1,var2);
  return i;
}

int half2_f_5542c() {
  // { dg-printf -re "half2_f_5542c===.*===.*===" }
  half2 var1 = (half2) (123445,4);
  half2 var2 = (half2) (7,-5);
  int i = printf("half2_f_5542c===%- 10v2hF===%- 10v2hF===\n",var1,var2);
  return i;
}

int half2_f_5543c() {
  // { dg-printf -re "half2_f_5543c===.*===.*===" }
  half2 var1 = (half2) (5,3);
  half2 var2 = (half2) (8,8);
  int i = printf("half2_f_5543c===%- 10.1v2hF===%- 10.1v2hF===\n",var1,var2);
  return i;
}

int half2_f_5544c() {
  // { dg-printf -re "half2_f_5544c===.*===.*===" }
  half2 var1 = (half2) (2,0);
  half2 var2 = (half2) (8,-123455);
  int i = printf("half2_f_5544c===%- 10.2v2hF===%- 10.2v2hF===\n",var1,var2);
  return i;
}

int half2_f_5545c() {
  // { dg-printf -re "half2_f_5545c===.*===.*===" }
  half2 var1 = (half2) (2,-1);
  half2 var2 = (half2) (-123455,4);
  int i = printf("half2_f_5545c===%- 10.3v2hF===%- 10.3v2hF===\n",var1,var2);
  return i;
}

int half2_f_5546c() {
  // { dg-printf -re "half2_f_5546c===.*===.*===" }
  half2 var1 = (half2) (-6,-5);
  half2 var2 = (half2) (8,-4);
  int i = printf("half2_f_5546c===%- 10.10v2hF===%- 10.10v2hF===\n",var1,var2);
  return i;
}

int half2_f_6297c() {
  // { dg-printf -re "half2_f_6297c===.*===.*===" }
  half2 var1 = (half2) (1,4);
  half2 var2 = (half2) (4,2);
  int i = printf("half2_f_6297c===%+ 10v2hf===%+ 10v2hf===\n",var1,var2);
  return i;
}

int half2_f_6298c() {
  // { dg-printf -re "half2_f_6298c===.*===.*===" }
  half2 var1 = (half2) (-4,-123455);
  half2 var2 = (half2) (1,3);
  int i = printf("half2_f_6298c===%+ 10.1v2hf===%+ 10.1v2hf===\n",var1,var2);
  return i;
}

int half2_f_6299c() {
  // { dg-printf -re "half2_f_6299c===.*===.*===" }
  half2 var1 = (half2) (1,-8);
  half2 var2 = (half2) (-3,-2);
  int i = printf("half2_f_6299c===%+ 10.2v2hf===%+ 10.2v2hf===\n",var1,var2);
  return i;
}

int half2_f_6300c() {
  // { dg-printf -re "half2_f_6300c===.*===.*===" }
  half2 var1 = (half2) (-123455,3);
  half2 var2 = (half2) (8,6);
  int i = printf("half2_f_6300c===%+ 10.3v2hf===%+ 10.3v2hf===\n",var1,var2);
  return i;
}

int half2_f_6301c() {
  // { dg-printf -re "half2_f_6301c===.*===.*===" }
  half2 var1 = (half2) (0,-6);
  half2 var2 = (half2) (3,123445);
  int i = printf("half2_f_6301c===%+ 10.10v2hf===%+ 10.10v2hf===\n",var1,var2);
  return i;
}

int half2_f_6302c() {
  // { dg-printf -re "half2_f_6302c===.*===.*===" }
  half2 var1 = (half2) (-2,-3);
  half2 var2 = (half2) (-1,123445);
  int i = printf("half2_f_6302c===%+ 10v2hF===%+ 10v2hF===\n",var1,var2);
  return i;
}

int half2_f_6303c() {
  // { dg-printf -re "half2_f_6303c===.*===.*===" }
  half2 var1 = (half2) (123445,4);
  half2 var2 = (half2) (-7,-8);
  int i = printf("half2_f_6303c===%+ 10.1v2hF===%+ 10.1v2hF===\n",var1,var2);
  return i;
}

int half2_f_6304c() {
  // { dg-printf -re "half2_f_6304c===.*===.*===" }
  half2 var1 = (half2) (4,5);
  half2 var2 = (half2) (-4,-1);
  int i = printf("half2_f_6304c===%+ 10.2v2hF===%+ 10.2v2hF===\n",var1,var2);
  return i;
}

int half2_f_6305c() {
  // { dg-printf -re "half2_f_6305c===.*===.*===" }
  half2 var1 = (half2) (3,-1);
  half2 var2 = (half2) (4,1);
  int i = printf("half2_f_6305c===%+ 10.3v2hF===%+ 10.3v2hF===\n",var1,var2);
  return i;
}

int half2_f_6306c() {
  // { dg-printf -re "half2_f_6306c===.*===.*===" }
  half2 var1 = (half2) (2,8);
  half2 var2 = (half2) (7,-5);
  int i = printf("half2_f_6306c===%+ 10.10v2hF===%+ 10.10v2hF===\n",var1,var2);
  return i;
}

int half2_f_7057c() {
  // { dg-printf -re "half2_f_7057c===.*===.*===" }
  half2 var1 = (half2) (-8,-123455);
  half2 var2 = (half2) (-5,-8);
  int i = printf("half2_f_7057c===%+010v2hf===%+010v2hf===\n",var1,var2);
  return i;
}

int half2_f_7058c() {
  // { dg-printf -re "half2_f_7058c===.*===.*===" }
  half2 var1 = (half2) (-8,-4);
  half2 var2 = (half2) (2,-1);
  int i = printf("half2_f_7058c===%+010.1v2hf===%+010.1v2hf===\n",var1,var2);
  return i;
}

int half2_f_7059c() {
  // { dg-printf -re "half2_f_7059c===.*===.*===" }
  half2 var1 = (half2) (7,-5);
  half2 var2 = (half2) (4,-8);
  int i = printf("half2_f_7059c===%+010.2v2hf===%+010.2v2hf===\n",var1,var2);
  return i;
}

int half2_f_7060c() {
  // { dg-printf -re "half2_f_7060c===.*===.*===" }
  half2 var1 = (half2) (2,-123455);
  half2 var2 = (half2) (8,-5);
  int i = printf("half2_f_7060c===%+010.3v2hf===%+010.3v2hf===\n",var1,var2);
  return i;
}

int half2_f_7061c() {
  // { dg-printf -re "half2_f_7061c===.*===.*===" }
  half2 var1 = (half2) (3,-8);
  half2 var2 = (half2) (123445,0);
  int i = printf("half2_f_7061c===%+010.10v2hf===%+010.10v2hf===\n",var1,var2);
  return i;
}

int half2_f_7062c() {
  // { dg-printf -re "half2_f_7062c===.*===.*===" }
  half2 var1 = (half2) (8,-3);
  half2 var2 = (half2) (-7,-5);
  int i = printf("half2_f_7062c===%+010v2hF===%+010v2hF===\n",var1,var2);
  return i;
}

int half2_f_7063c() {
  // { dg-printf -re "half2_f_7063c===.*===.*===" }
  half2 var1 = (half2) (-8,2);
  half2 var2 = (half2) (6,-1);
  int i = printf("half2_f_7063c===%+010.1v2hF===%+010.1v2hF===\n",var1,var2);
  return i;
}

int half2_f_7064c() {
  // { dg-printf -re "half2_f_7064c===.*===.*===" }
  half2 var1 = (half2) (4,-4);
  half2 var2 = (half2) (4,0);
  int i = printf("half2_f_7064c===%+010.2v2hF===%+010.2v2hF===\n",var1,var2);
  return i;
}

int half2_f_7065c() {
  // { dg-printf -re "half2_f_7065c===.*===.*===" }
  half2 var1 = (half2) (2,8);
  half2 var2 = (half2) (-123455,-3);
  int i = printf("half2_f_7065c===%+010.3v2hF===%+010.3v2hF===\n",var1,var2);
  return i;
}

int half2_f_7066c() {
  // { dg-printf -re "half2_f_7066c===.*===.*===" }
  half2 var1 = (half2) (-5,4);
  half2 var2 = (half2) (-1,-5);
  int i = printf("half2_f_7066c===%+010.10v2hF===%+010.10v2hF===\n",var1,var2);
  return i;
}

int half2_f_977c() {
  // { dg-printf -re "half2_f_977c===.*===.*===" }
  half2 var1 = (half2) (0,-2);
  half2 var2 = (half2) (-3,-3);
  int i = printf("half2_f_977c===%-v2hf===%-v2hf===\n",var1,var2);
  return i;
}

int half2_f_978c() {
  // { dg-printf -re "half2_f_978c===.*===.*===" }
  half2 var1 = (half2) (5,-8);
  half2 var2 = (half2) (-1,-8);
  int i = printf("half2_f_978c===%-.1v2hf===%-.1v2hf===\n",var1,var2);
  return i;
}

int half2_f_979c() {
  // { dg-printf -re "half2_f_979c===.*===.*===" }
  half2 var1 = (half2) (123445,7);
  half2 var2 = (half2) (-3,-6);
  int i = printf("half2_f_979c===%-.2v2hf===%-.2v2hf===\n",var1,var2);
  return i;
}

int half2_f_980c() {
  // { dg-printf -re "half2_f_980c===.*===.*===" }
  half2 var1 = (half2) (-7,5);
  half2 var2 = (half2) (-3,7);
  int i = printf("half2_f_980c===%-.3v2hf===%-.3v2hf===\n",var1,var2);
  return i;
}

int half2_f_981c() {
  // { dg-printf -re "half2_f_981c===.*===.*===" }
  half2 var1 = (half2) (8,-7);
  half2 var2 = (half2) (6,-5);
  int i = printf("half2_f_981c===%-.10v2hf===%-.10v2hf===\n",var1,var2);
  return i;
}

int half2_f_982c() {
  // { dg-printf -re "half2_f_982c===.*===.*===" }
  half2 var1 = (half2) (-2,6);
  half2 var2 = (half2) (4,-2);
  int i = printf("half2_f_982c===%-v2hF===%-v2hF===\n",var1,var2);
  return i;
}

int half2_f_983c() {
  // { dg-printf -re "half2_f_983c===.*===.*===" }
  half2 var1 = (half2) (5,123445);
  half2 var2 = (half2) (123445,-1);
  int i = printf("half2_f_983c===%-.1v2hF===%-.1v2hF===\n",var1,var2);
  return i;
}

int half2_f_984c() {
  // { dg-printf -re "half2_f_984c===.*===.*===" }
  half2 var1 = (half2) (0,-4);
  half2 var2 = (half2) (-123455,5);
  int i = printf("half2_f_984c===%-.2v2hF===%-.2v2hF===\n",var1,var2);
  return i;
}

int half2_f_985c() {
  // { dg-printf -re "half2_f_985c===.*===.*===" }
  half2 var1 = (half2) (5,0);
  half2 var2 = (half2) (3,-4);
  int i = printf("half2_f_985c===%-.3v2hF===%-.3v2hF===\n",var1,var2);
  return i;
}

int half2_f_986c() {
  // { dg-printf -re "half2_f_986c===.*===.*===" }
  half2 var1 = (half2) (-1,4);
  half2 var2 = (half2) (7,-3);
  int i = printf("half2_f_986c===%-.10v2hF===%-.10v2hF===\n",var1,var2);
  return i;
}

int half2_g_1747c() {
  // { dg-printf -re "half2_g_1747c===.*===.*===" }
  half2 var1 = (half2) (-3,2);
  half2 var2 = (half2) (4,-5);
  int i = printf("half2_g_1747c===%+v2hg===%+v2hg===\n",var1,var2);
  return i;
}

int half2_g_1748c() {
  // { dg-printf -re "half2_g_1748c===.*===.*===" }
  half2 var1 = (half2) (-2,5);
  half2 var2 = (half2) (-8,2);
  int i = printf("half2_g_1748c===%+.1v2hg===%+.1v2hg===\n",var1,var2);
  return i;
}

int half2_g_1749c() {
  // { dg-printf -re "half2_g_1749c===.*===.*===" }
  half2 var1 = (half2) (-5,6);
  half2 var2 = (half2) (6,-2);
  int i = printf("half2_g_1749c===%+.2v2hg===%+.2v2hg===\n",var1,var2);
  return i;
}

int half2_g_1750c() {
  // { dg-printf -re "half2_g_1750c===.*===.*===" }
  half2 var1 = (half2) (-1,7);
  half2 var2 = (half2) (-4,0);
  int i = printf("half2_g_1750c===%+.3v2hg===%+.3v2hg===\n",var1,var2);
  return i;
}

int half2_g_1751c() {
  // { dg-printf -re "half2_g_1751c===.*===.*===" }
  half2 var1 = (half2) (2,-123455);
  half2 var2 = (half2) (-1,-7);
  int i = printf("half2_g_1751c===%+.10v2hg===%+.10v2hg===\n",var1,var2);
  return i;
}

int half2_g_1752c() {
  // { dg-printf -re "half2_g_1752c===.*===.*===" }
  half2 var1 = (half2) (-3,-6);
  half2 var2 = (half2) (-3,-4);
  int i = printf("half2_g_1752c===%+v2hG===%+v2hG===\n",var1,var2);
  return i;
}

int half2_g_1753c() {
  // { dg-printf -re "half2_g_1753c===.*===.*===" }
  half2 var1 = (half2) (8,-7);
  half2 var2 = (half2) (-2,-1);
  int i = printf("half2_g_1753c===%+.1v2hG===%+.1v2hG===\n",var1,var2);
  return i;
}

int half2_g_1754c() {
  // { dg-printf -re "half2_g_1754c===.*===.*===" }
  half2 var1 = (half2) (-2,-4);
  half2 var2 = (half2) (2,3);
  int i = printf("half2_g_1754c===%+.2v2hG===%+.2v2hG===\n",var1,var2);
  return i;
}

int half2_g_1755c() {
  // { dg-printf -re "half2_g_1755c===.*===.*===" }
  half2 var1 = (half2) (6,4);
  half2 var2 = (half2) (-123455,-123455);
  int i = printf("half2_g_1755c===%+.3v2hG===%+.3v2hG===\n",var1,var2);
  return i;
}

int half2_g_1756c() {
  // { dg-printf -re "half2_g_1756c===.*===.*===" }
  half2 var1 = (half2) (-7,-1);
  half2 var2 = (half2) (-6,7);
  int i = printf("half2_g_1756c===%+.10v2hG===%+.10v2hG===\n",var1,var2);
  return i;
}

int half2_g_227c() {
  // { dg-printf -re "half2_g_227c===.*===.*===" }
  half2 var1 = (half2) (-8,123445);
  half2 var2 = (half2) (6,-2);
  int i = printf("half2_g_227c===%v2hg===%v2hg===\n",var1,var2);
  return i;
}

int half2_g_228c() {
  // { dg-printf -re "half2_g_228c===.*===.*===" }
  half2 var1 = (half2) (7,-7);
  half2 var2 = (half2) (6,0);
  int i = printf("half2_g_228c===%.1v2hg===%.1v2hg===\n",var1,var2);
  return i;
}

int half2_g_229c() {
  // { dg-printf -re "half2_g_229c===.*===.*===" }
  half2 var1 = (half2) (5,2);
  half2 var2 = (half2) (-4,-4);
  int i = printf("half2_g_229c===%.2v2hg===%.2v2hg===\n",var1,var2);
  return i;
}

int half2_g_230c() {
  // { dg-printf -re "half2_g_230c===.*===.*===" }
  half2 var1 = (half2) (2,6);
  half2 var2 = (half2) (-5,3);
  int i = printf("half2_g_230c===%.3v2hg===%.3v2hg===\n",var1,var2);
  return i;
}

int half2_g_231c() {
  // { dg-printf -re "half2_g_231c===.*===.*===" }
  half2 var1 = (half2) (1,0);
  half2 var2 = (half2) (-5,-8);
  int i = printf("half2_g_231c===%.10v2hg===%.10v2hg===\n",var1,var2);
  return i;
}

int half2_g_232c() {
  // { dg-printf -re "half2_g_232c===.*===.*===" }
  half2 var1 = (half2) (5,-6);
  half2 var2 = (half2) (8,-2);
  int i = printf("half2_g_232c===%v2hG===%v2hG===\n",var1,var2);
  return i;
}

int half2_g_233c() {
  // { dg-printf -re "half2_g_233c===.*===.*===" }
  half2 var1 = (half2) (0,2);
  half2 var2 = (half2) (-6,-123455);
  int i = printf("half2_g_233c===%.1v2hG===%.1v2hG===\n",var1,var2);
  return i;
}

int half2_g_234c() {
  // { dg-printf -re "half2_g_234c===.*===.*===" }
  half2 var1 = (half2) (8,-2);
  half2 var2 = (half2) (123445,7);
  int i = printf("half2_g_234c===%.2v2hG===%.2v2hG===\n",var1,var2);
  return i;
}

int half2_g_235c() {
  // { dg-printf -re "half2_g_235c===.*===.*===" }
  half2 var1 = (half2) (123445,8);
  half2 var2 = (half2) (-6,4);
  int i = printf("half2_g_235c===%.3v2hG===%.3v2hG===\n",var1,var2);
  return i;
}

int half2_g_236c() {
  // { dg-printf -re "half2_g_236c===.*===.*===" }
  half2 var1 = (half2) (-2,5);
  half2 var2 = (half2) (8,-5);
  int i = printf("half2_g_236c===%.10v2hG===%.10v2hG===\n",var1,var2);
  return i;
}

int half2_g_2507c() {
  // { dg-printf -re "half2_g_2507c===.*===.*===" }
  half2 var1 = (half2) (0,7);
  half2 var2 = (half2) (-1,-123455);
  int i = printf("half2_g_2507c===%#v2hg===%#v2hg===\n",var1,var2);
  return i;
}

int half2_g_2508c() {
  // { dg-printf -re "half2_g_2508c===.*===.*===" }
  half2 var1 = (half2) (-5,-6);
  half2 var2 = (half2) (-7,-7);
  int i = printf("half2_g_2508c===%#.1v2hg===%#.1v2hg===\n",var1,var2);
  return i;
}

int half2_g_2509c() {
  // { dg-printf -re "half2_g_2509c===.*===.*===" }
  half2 var1 = (half2) (123445,-123455);
  half2 var2 = (half2) (-4,3);
  int i = printf("half2_g_2509c===%#.2v2hg===%#.2v2hg===\n",var1,var2);
  return i;
}

int half2_g_2510c() {
  // { dg-printf -re "half2_g_2510c===.*===.*===" }
  half2 var1 = (half2) (-123455,-7);
  half2 var2 = (half2) (-4,123445);
  int i = printf("half2_g_2510c===%#.3v2hg===%#.3v2hg===\n",var1,var2);
  return i;
}

int half2_g_2511c() {
  // { dg-printf -re "half2_g_2511c===.*===.*===" }
  half2 var1 = (half2) (3,1);
  half2 var2 = (half2) (-4,6);
  int i = printf("half2_g_2511c===%#.10v2hg===%#.10v2hg===\n",var1,var2);
  return i;
}

int half2_g_2512c() {
  // { dg-printf -re "half2_g_2512c===.*===.*===" }
  half2 var1 = (half2) (-1,-1);
  half2 var2 = (half2) (-7,-3);
  int i = printf("half2_g_2512c===%#v2hG===%#v2hG===\n",var1,var2);
  return i;
}

int half2_g_2513c() {
  // { dg-printf -re "half2_g_2513c===.*===.*===" }
  half2 var1 = (half2) (6,-2);
  half2 var2 = (half2) (7,8);
  int i = printf("half2_g_2513c===%#.1v2hG===%#.1v2hG===\n",var1,var2);
  return i;
}

int half2_g_2514c() {
  // { dg-printf -re "half2_g_2514c===.*===.*===" }
  half2 var1 = (half2) (-8,-6);
  half2 var2 = (half2) (3,0);
  int i = printf("half2_g_2514c===%#.2v2hG===%#.2v2hG===\n",var1,var2);
  return i;
}

int half2_g_2515c() {
  // { dg-printf -re "half2_g_2515c===.*===.*===" }
  half2 var1 = (half2) (0,-8);
  half2 var2 = (half2) (-8,-123455);
  int i = printf("half2_g_2515c===%#.3v2hG===%#.3v2hG===\n",var1,var2);
  return i;
}

int half2_g_2516c() {
  // { dg-printf -re "half2_g_2516c===.*===.*===" }
  half2 var1 = (half2) (-4,2);
  half2 var2 = (half2) (-6,5);
  int i = printf("half2_g_2516c===%#.10v2hG===%#.10v2hG===\n",var1,var2);
  return i;
}

int half2_g_3267c() {
  // { dg-printf -re "half2_g_3267c===.*===.*===" }
  half2 var1 = (half2) (-123455,3);
  half2 var2 = (half2) (3,-8);
  int i = printf("half2_g_3267c===%-+v2hg===%-+v2hg===\n",var1,var2);
  return i;
}

int half2_g_3268c() {
  // { dg-printf -re "half2_g_3268c===.*===.*===" }
  half2 var1 = (half2) (3,-7);
  half2 var2 = (half2) (0,4);
  int i = printf("half2_g_3268c===%-+.1v2hg===%-+.1v2hg===\n",var1,var2);
  return i;
}

int half2_g_3269c() {
  // { dg-printf -re "half2_g_3269c===.*===.*===" }
  half2 var1 = (half2) (3,5);
  half2 var2 = (half2) (-123455,0);
  int i = printf("half2_g_3269c===%-+.2v2hg===%-+.2v2hg===\n",var1,var2);
  return i;
}

int half2_g_3270c() {
  // { dg-printf -re "half2_g_3270c===.*===.*===" }
  half2 var1 = (half2) (4,-7);
  half2 var2 = (half2) (-123455,3);
  int i = printf("half2_g_3270c===%-+.3v2hg===%-+.3v2hg===\n",var1,var2);
  return i;
}

int half2_g_3271c() {
  // { dg-printf -re "half2_g_3271c===.*===.*===" }
  half2 var1 = (half2) (-5,-7);
  half2 var2 = (half2) (-4,-2);
  int i = printf("half2_g_3271c===%-+.10v2hg===%-+.10v2hg===\n",var1,var2);
  return i;
}

int half2_g_3272c() {
  // { dg-printf -re "half2_g_3272c===.*===.*===" }
  half2 var1 = (half2) (6,-8);
  half2 var2 = (half2) (123445,-8);
  int i = printf("half2_g_3272c===%-+v2hG===%-+v2hG===\n",var1,var2);
  return i;
}

int half2_g_3273c() {
  // { dg-printf -re "half2_g_3273c===.*===.*===" }
  half2 var1 = (half2) (0,1);
  half2 var2 = (half2) (123445,6);
  int i = printf("half2_g_3273c===%-+.1v2hG===%-+.1v2hG===\n",var1,var2);
  return i;
}

int half2_g_3274c() {
  // { dg-printf -re "half2_g_3274c===.*===.*===" }
  half2 var1 = (half2) (8,123445);
  half2 var2 = (half2) (3,4);
  int i = printf("half2_g_3274c===%-+.2v2hG===%-+.2v2hG===\n",var1,var2);
  return i;
}

int half2_g_3275c() {
  // { dg-printf -re "half2_g_3275c===.*===.*===" }
  half2 var1 = (half2) (-4,3);
  half2 var2 = (half2) (7,4);
  int i = printf("half2_g_3275c===%-+.3v2hG===%-+.3v2hG===\n",var1,var2);
  return i;
}

int half2_g_3276c() {
  // { dg-printf -re "half2_g_3276c===.*===.*===" }
  half2 var1 = (half2) (2,-8);
  half2 var2 = (half2) (-6,8);
  int i = printf("half2_g_3276c===%-+.10v2hG===%-+.10v2hG===\n",var1,var2);
  return i;
}

int half2_g_4027c() {
  // { dg-printf -re "half2_g_4027c===.*===.*===" }
  half2 var1 = (half2) (-7,-1);
  half2 var2 = (half2) (5,7);
  int i = printf("half2_g_4027c===% 10v2hg===% 10v2hg===\n",var1,var2);
  return i;
}

int half2_g_4028c() {
  // { dg-printf -re "half2_g_4028c===.*===.*===" }
  half2 var1 = (half2) (4,-2);
  half2 var2 = (half2) (8,7);
  int i = printf("half2_g_4028c===% 10.1v2hg===% 10.1v2hg===\n",var1,var2);
  return i;
}

int half2_g_4029c() {
  // { dg-printf -re "half2_g_4029c===.*===.*===" }
  half2 var1 = (half2) (0,0);
  half2 var2 = (half2) (-4,-3);
  int i = printf("half2_g_4029c===% 10.2v2hg===% 10.2v2hg===\n",var1,var2);
  return i;
}

int half2_g_4030c() {
  // { dg-printf -re "half2_g_4030c===.*===.*===" }
  half2 var1 = (half2) (-4,-123455);
  half2 var2 = (half2) (-4,123445);
  int i = printf("half2_g_4030c===% 10.3v2hg===% 10.3v2hg===\n",var1,var2);
  return i;
}

int half2_g_4031c() {
  // { dg-printf -re "half2_g_4031c===.*===.*===" }
  half2 var1 = (half2) (5,3);
  half2 var2 = (half2) (4,123445);
  int i = printf("half2_g_4031c===% 10.10v2hg===% 10.10v2hg===\n",var1,var2);
  return i;
}

int half2_g_4032c() {
  // { dg-printf -re "half2_g_4032c===.*===.*===" }
  half2 var1 = (half2) (1,5);
  half2 var2 = (half2) (-7,5);
  int i = printf("half2_g_4032c===% 10v2hG===% 10v2hG===\n",var1,var2);
  return i;
}

int half2_g_4033c() {
  // { dg-printf -re "half2_g_4033c===.*===.*===" }
  half2 var1 = (half2) (1,-2);
  half2 var2 = (half2) (-7,-7);
  int i = printf("half2_g_4033c===% 10.1v2hG===% 10.1v2hG===\n",var1,var2);
  return i;
}

int half2_g_4034c() {
  // { dg-printf -re "half2_g_4034c===.*===.*===" }
  half2 var1 = (half2) (-1,5);
  half2 var2 = (half2) (-2,1);
  int i = printf("half2_g_4034c===% 10.2v2hG===% 10.2v2hG===\n",var1,var2);
  return i;
}

int half2_g_4035c() {
  // { dg-printf -re "half2_g_4035c===.*===.*===" }
  half2 var1 = (half2) (6,-123455);
  half2 var2 = (half2) (-7,4);
  int i = printf("half2_g_4035c===% 10.3v2hG===% 10.3v2hG===\n",var1,var2);
  return i;
}

int half2_g_4036c() {
  // { dg-printf -re "half2_g_4036c===.*===.*===" }
  half2 var1 = (half2) (-8,-5);
  half2 var2 = (half2) (-3,0);
  int i = printf("half2_g_4036c===% 10.10v2hG===% 10.10v2hG===\n",var1,var2);
  return i;
}

int half2_g_4787c() {
  // { dg-printf -re "half2_g_4787c===.*===.*===" }
  half2 var1 = (half2) (1,-2);
  half2 var2 = (half2) (0,7);
  int i = printf("half2_g_4787c===%010v2hg===%010v2hg===\n",var1,var2);
  return i;
}

int half2_g_4788c() {
  // { dg-printf -re "half2_g_4788c===.*===.*===" }
  half2 var1 = (half2) (-5,-7);
  half2 var2 = (half2) (-7,-123455);
  int i = printf("half2_g_4788c===%010.1v2hg===%010.1v2hg===\n",var1,var2);
  return i;
}

int half2_g_4789c() {
  // { dg-printf -re "half2_g_4789c===.*===.*===" }
  half2 var1 = (half2) (-123455,-4);
  half2 var2 = (half2) (-7,-6);
  int i = printf("half2_g_4789c===%010.2v2hg===%010.2v2hg===\n",var1,var2);
  return i;
}

int half2_g_4790c() {
  // { dg-printf -re "half2_g_4790c===.*===.*===" }
  half2 var1 = (half2) (7,-8);
  half2 var2 = (half2) (2,8);
  int i = printf("half2_g_4790c===%010.3v2hg===%010.3v2hg===\n",var1,var2);
  return i;
}

int half2_g_4791c() {
  // { dg-printf -re "half2_g_4791c===.*===.*===" }
  half2 var1 = (half2) (5,-5);
  half2 var2 = (half2) (-123455,-2);
  int i = printf("half2_g_4791c===%010.10v2hg===%010.10v2hg===\n",var1,var2);
  return i;
}

int half2_g_4792c() {
  // { dg-printf -re "half2_g_4792c===.*===.*===" }
  half2 var1 = (half2) (-4,1);
  half2 var2 = (half2) (-3,-6);
  int i = printf("half2_g_4792c===%010v2hG===%010v2hG===\n",var1,var2);
  return i;
}

int half2_g_4793c() {
  // { dg-printf -re "half2_g_4793c===.*===.*===" }
  half2 var1 = (half2) (-123455,4);
  half2 var2 = (half2) (-7,123445);
  int i = printf("half2_g_4793c===%010.1v2hG===%010.1v2hG===\n",var1,var2);
  return i;
}

int half2_g_4794c() {
  // { dg-printf -re "half2_g_4794c===.*===.*===" }
  half2 var1 = (half2) (1,8);
  half2 var2 = (half2) (-1,7);
  int i = printf("half2_g_4794c===%010.2v2hG===%010.2v2hG===\n",var1,var2);
  return i;
}

int half2_g_4795c() {
  // { dg-printf -re "half2_g_4795c===.*===.*===" }
  half2 var1 = (half2) (-123455,1);
  half2 var2 = (half2) (7,-4);
  int i = printf("half2_g_4795c===%010.3v2hG===%010.3v2hG===\n",var1,var2);
  return i;
}

int half2_g_4796c() {
  // { dg-printf -re "half2_g_4796c===.*===.*===" }
  half2 var1 = (half2) (-8,4);
  half2 var2 = (half2) (-4,5);
  int i = printf("half2_g_4796c===%010.10v2hG===%010.10v2hG===\n",var1,var2);
  return i;
}

int half2_g_5547c() {
  // { dg-printf -re "half2_g_5547c===.*===.*===" }
  half2 var1 = (half2) (1,2);
  half2 var2 = (half2) (-8,5);
  int i = printf("half2_g_5547c===%- 10v2hg===%- 10v2hg===\n",var1,var2);
  return i;
}

int half2_g_5548c() {
  // { dg-printf -re "half2_g_5548c===.*===.*===" }
  half2 var1 = (half2) (-4,0);
  half2 var2 = (half2) (6,0);
  int i = printf("half2_g_5548c===%- 10.1v2hg===%- 10.1v2hg===\n",var1,var2);
  return i;
}

int half2_g_5549c() {
  // { dg-printf -re "half2_g_5549c===.*===.*===" }
  half2 var1 = (half2) (-3,1);
  half2 var2 = (half2) (-8,-4);
  int i = printf("half2_g_5549c===%- 10.2v2hg===%- 10.2v2hg===\n",var1,var2);
  return i;
}

int half2_g_5550c() {
  // { dg-printf -re "half2_g_5550c===.*===.*===" }
  half2 var1 = (half2) (2,-5);
  half2 var2 = (half2) (-2,5);
  int i = printf("half2_g_5550c===%- 10.3v2hg===%- 10.3v2hg===\n",var1,var2);
  return i;
}

int half2_g_5551c() {
  // { dg-printf -re "half2_g_5551c===.*===.*===" }
  half2 var1 = (half2) (-7,-1);
  half2 var2 = (half2) (4,2);
  int i = printf("half2_g_5551c===%- 10.10v2hg===%- 10.10v2hg===\n",var1,var2);
  return i;
}

int half2_g_5552c() {
  // { dg-printf -re "half2_g_5552c===.*===.*===" }
  half2 var1 = (half2) (-7,-3);
  half2 var2 = (half2) (2,-8);
  int i = printf("half2_g_5552c===%- 10v2hG===%- 10v2hG===\n",var1,var2);
  return i;
}

int half2_g_5553c() {
  // { dg-printf -re "half2_g_5553c===.*===.*===" }
  half2 var1 = (half2) (4,123445);
  half2 var2 = (half2) (123445,4);
  int i = printf("half2_g_5553c===%- 10.1v2hG===%- 10.1v2hG===\n",var1,var2);
  return i;
}

int half2_g_5554c() {
  // { dg-printf -re "half2_g_5554c===.*===.*===" }
  half2 var1 = (half2) (-3,1);
  half2 var2 = (half2) (123445,3);
  int i = printf("half2_g_5554c===%- 10.2v2hG===%- 10.2v2hG===\n",var1,var2);
  return i;
}

int half2_g_5555c() {
  // { dg-printf -re "half2_g_5555c===.*===.*===" }
  half2 var1 = (half2) (8,-123455);
  half2 var2 = (half2) (-8,8);
  int i = printf("half2_g_5555c===%- 10.3v2hG===%- 10.3v2hG===\n",var1,var2);
  return i;
}

int half2_g_5556c() {
  // { dg-printf -re "half2_g_5556c===.*===.*===" }
  half2 var1 = (half2) (-5,-1);
  half2 var2 = (half2) (7,-3);
  int i = printf("half2_g_5556c===%- 10.10v2hG===%- 10.10v2hG===\n",var1,var2);
  return i;
}

int half2_g_6307c() {
  // { dg-printf -re "half2_g_6307c===.*===.*===" }
  half2 var1 = (half2) (1,-7);
  half2 var2 = (half2) (3,-2);
  int i = printf("half2_g_6307c===%+ 10v2hg===%+ 10v2hg===\n",var1,var2);
  return i;
}

int half2_g_6308c() {
  // { dg-printf -re "half2_g_6308c===.*===.*===" }
  half2 var1 = (half2) (-8,-3);
  half2 var2 = (half2) (5,1);
  int i = printf("half2_g_6308c===%+ 10.1v2hg===%+ 10.1v2hg===\n",var1,var2);
  return i;
}

int half2_g_6309c() {
  // { dg-printf -re "half2_g_6309c===.*===.*===" }
  half2 var1 = (half2) (-123455,-2);
  half2 var2 = (half2) (-5,-6);
  int i = printf("half2_g_6309c===%+ 10.2v2hg===%+ 10.2v2hg===\n",var1,var2);
  return i;
}

int half2_g_6310c() {
  // { dg-printf -re "half2_g_6310c===.*===.*===" }
  half2 var1 = (half2) (-1,-123455);
  half2 var2 = (half2) (5,-8);
  int i = printf("half2_g_6310c===%+ 10.3v2hg===%+ 10.3v2hg===\n",var1,var2);
  return i;
}

int half2_g_6311c() {
  // { dg-printf -re "half2_g_6311c===.*===.*===" }
  half2 var1 = (half2) (-8,123445);
  half2 var2 = (half2) (-8,8);
  int i = printf("half2_g_6311c===%+ 10.10v2hg===%+ 10.10v2hg===\n",var1,var2);
  return i;
}

int half2_g_6312c() {
  // { dg-printf -re "half2_g_6312c===.*===.*===" }
  half2 var1 = (half2) (1,5);
  half2 var2 = (half2) (1,8);
  int i = printf("half2_g_6312c===%+ 10v2hG===%+ 10v2hG===\n",var1,var2);
  return i;
}

int half2_g_6313c() {
  // { dg-printf -re "half2_g_6313c===.*===.*===" }
  half2 var1 = (half2) (-1,-6);
  half2 var2 = (half2) (0,-5);
  int i = printf("half2_g_6313c===%+ 10.1v2hG===%+ 10.1v2hG===\n",var1,var2);
  return i;
}

int half2_g_6314c() {
  // { dg-printf -re "half2_g_6314c===.*===.*===" }
  half2 var1 = (half2) (-6,-7);
  half2 var2 = (half2) (123445,6);
  int i = printf("half2_g_6314c===%+ 10.2v2hG===%+ 10.2v2hG===\n",var1,var2);
  return i;
}

int half2_g_6315c() {
  // { dg-printf -re "half2_g_6315c===.*===.*===" }
  half2 var1 = (half2) (-3,-5);
  half2 var2 = (half2) (123445,3);
  int i = printf("half2_g_6315c===%+ 10.3v2hG===%+ 10.3v2hG===\n",var1,var2);
  return i;
}

int half2_g_6316c() {
  // { dg-printf -re "half2_g_6316c===.*===.*===" }
  half2 var1 = (half2) (-4,-1);
  half2 var2 = (half2) (123445,5);
  int i = printf("half2_g_6316c===%+ 10.10v2hG===%+ 10.10v2hG===\n",var1,var2);
  return i;
}

int half2_g_7067c() {
  // { dg-printf -re "half2_g_7067c===.*===.*===" }
  half2 var1 = (half2) (0,-6);
  half2 var2 = (half2) (8,-4);
  int i = printf("half2_g_7067c===%+010v2hg===%+010v2hg===\n",var1,var2);
  return i;
}

int half2_g_7068c() {
  // { dg-printf -re "half2_g_7068c===.*===.*===" }
  half2 var1 = (half2) (-3,123445);
  half2 var2 = (half2) (7,5);
  int i = printf("half2_g_7068c===%+010.1v2hg===%+010.1v2hg===\n",var1,var2);
  return i;
}

int half2_g_7069c() {
  // { dg-printf -re "half2_g_7069c===.*===.*===" }
  half2 var1 = (half2) (7,0);
  half2 var2 = (half2) (-5,3);
  int i = printf("half2_g_7069c===%+010.2v2hg===%+010.2v2hg===\n",var1,var2);
  return i;
}

int half2_g_7070c() {
  // { dg-printf -re "half2_g_7070c===.*===.*===" }
  half2 var1 = (half2) (123445,-1);
  half2 var2 = (half2) (5,6);
  int i = printf("half2_g_7070c===%+010.3v2hg===%+010.3v2hg===\n",var1,var2);
  return i;
}

int half2_g_7071c() {
  // { dg-printf -re "half2_g_7071c===.*===.*===" }
  half2 var1 = (half2) (123445,-123455);
  half2 var2 = (half2) (7,6);
  int i = printf("half2_g_7071c===%+010.10v2hg===%+010.10v2hg===\n",var1,var2);
  return i;
}

int half2_g_7072c() {
  // { dg-printf -re "half2_g_7072c===.*===.*===" }
  half2 var1 = (half2) (-123455,2);
  half2 var2 = (half2) (-1,6);
  int i = printf("half2_g_7072c===%+010v2hG===%+010v2hG===\n",var1,var2);
  return i;
}

int half2_g_7073c() {
  // { dg-printf -re "half2_g_7073c===.*===.*===" }
  half2 var1 = (half2) (-3,5);
  half2 var2 = (half2) (-1,-123455);
  int i = printf("half2_g_7073c===%+010.1v2hG===%+010.1v2hG===\n",var1,var2);
  return i;
}

int half2_g_7074c() {
  // { dg-printf -re "half2_g_7074c===.*===.*===" }
  half2 var1 = (half2) (8,7);
  half2 var2 = (half2) (0,8);
  int i = printf("half2_g_7074c===%+010.2v2hG===%+010.2v2hG===\n",var1,var2);
  return i;
}

int half2_g_7075c() {
  // { dg-printf -re "half2_g_7075c===.*===.*===" }
  half2 var1 = (half2) (-7,2);
  half2 var2 = (half2) (8,0);
  int i = printf("half2_g_7075c===%+010.3v2hG===%+010.3v2hG===\n",var1,var2);
  return i;
}

int half2_g_7076c() {
  // { dg-printf -re "half2_g_7076c===.*===.*===" }
  half2 var1 = (half2) (-3,8);
  half2 var2 = (half2) (-4,0);
  int i = printf("half2_g_7076c===%+010.10v2hG===%+010.10v2hG===\n",var1,var2);
  return i;
}

int half2_g_987c() {
  // { dg-printf -re "half2_g_987c===.*===.*===" }
  half2 var1 = (half2) (6,-4);
  half2 var2 = (half2) (-4,-5);
  int i = printf("half2_g_987c===%-v2hg===%-v2hg===\n",var1,var2);
  return i;
}

int half2_g_988c() {
  // { dg-printf -re "half2_g_988c===.*===.*===" }
  half2 var1 = (half2) (3,0);
  half2 var2 = (half2) (4,5);
  int i = printf("half2_g_988c===%-.1v2hg===%-.1v2hg===\n",var1,var2);
  return i;
}

int half2_g_989c() {
  // { dg-printf -re "half2_g_989c===.*===.*===" }
  half2 var1 = (half2) (7,-5);
  half2 var2 = (half2) (4,-2);
  int i = printf("half2_g_989c===%-.2v2hg===%-.2v2hg===\n",var1,var2);
  return i;
}

int half2_g_990c() {
  // { dg-printf -re "half2_g_990c===.*===.*===" }
  half2 var1 = (half2) (0,6);
  half2 var2 = (half2) (0,-1);
  int i = printf("half2_g_990c===%-.3v2hg===%-.3v2hg===\n",var1,var2);
  return i;
}

int half2_g_991c() {
  // { dg-printf -re "half2_g_991c===.*===.*===" }
  half2 var1 = (half2) (4,-6);
  half2 var2 = (half2) (5,0);
  int i = printf("half2_g_991c===%-.10v2hg===%-.10v2hg===\n",var1,var2);
  return i;
}

int half2_g_992c() {
  // { dg-printf -re "half2_g_992c===.*===.*===" }
  half2 var1 = (half2) (-1,-2);
  half2 var2 = (half2) (-5,-6);
  int i = printf("half2_g_992c===%-v2hG===%-v2hG===\n",var1,var2);
  return i;
}

int half2_g_993c() {
  // { dg-printf -re "half2_g_993c===.*===.*===" }
  half2 var1 = (half2) (4,-1);
  half2 var2 = (half2) (8,1);
  int i = printf("half2_g_993c===%-.1v2hG===%-.1v2hG===\n",var1,var2);
  return i;
}

int half2_g_994c() {
  // { dg-printf -re "half2_g_994c===.*===.*===" }
  half2 var1 = (half2) (-5,-6);
  half2 var2 = (half2) (4,1);
  int i = printf("half2_g_994c===%-.2v2hG===%-.2v2hG===\n",var1,var2);
  return i;
}

int half2_g_995c() {
  // { dg-printf -re "half2_g_995c===.*===.*===" }
  half2 var1 = (half2) (-5,1);
  half2 var2 = (half2) (-7,-5);
  int i = printf("half2_g_995c===%-.3v2hG===%-.3v2hG===\n",var1,var2);
  return i;
}

int half2_g_996c() {
  // { dg-printf -re "half2_g_996c===.*===.*===" }
  half2 var1 = (half2) (-1,4);
  half2 var2 = (half2) (1,2);
  int i = printf("half2_g_996c===%-.10v2hG===%-.10v2hG===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = half2_a_1717c();
i = half2_a_1718c();
i = half2_a_1719c();
i = half2_a_1720c();
i = half2_a_1721c();
i = half2_a_1722c();
i = half2_a_1723c();
i = half2_a_1724c();
i = half2_a_1725c();
i = half2_a_1726c();
i = half2_a_197c();
i = half2_a_198c();
i = half2_a_199c();
i = half2_a_200c();
i = half2_a_201c();
i = half2_a_202c();
i = half2_a_203c();
i = half2_a_204c();
i = half2_a_205c();
i = half2_a_206c();
i = half2_a_2477c();
i = half2_a_2478c();
i = half2_a_2479c();
i = half2_a_2480c();
i = half2_a_2481c();
i = half2_a_2482c();
i = half2_a_2483c();
i = half2_a_2484c();
i = half2_a_2485c();
i = half2_a_2486c();
i = half2_a_3237c();
i = half2_a_3238c();
i = half2_a_3239c();
i = half2_a_3240c();
i = half2_a_3241c();
i = half2_a_3242c();
i = half2_a_3243c();
i = half2_a_3244c();
i = half2_a_3245c();
i = half2_a_3246c();
i = half2_a_3997c();
i = half2_a_3998c();
i = half2_a_3999c();
i = half2_a_4000c();
i = half2_a_4001c();
i = half2_a_4002c();
i = half2_a_4003c();
i = half2_a_4004c();
i = half2_a_4005c();
i = half2_a_4006c();
i = half2_a_4757c();
i = half2_a_4758c();
i = half2_a_4759c();
i = half2_a_4760c();
i = half2_a_4761c();
i = half2_a_4762c();
i = half2_a_4763c();
i = half2_a_4764c();
i = half2_a_4765c();
i = half2_a_4766c();
i = half2_a_5517c();
i = half2_a_5518c();
i = half2_a_5519c();
i = half2_a_5520c();
i = half2_a_5521c();
i = half2_a_5522c();
i = half2_a_5523c();
i = half2_a_5524c();
i = half2_a_5525c();
i = half2_a_5526c();
i = half2_a_6277c();
i = half2_a_6278c();
i = half2_a_6279c();
i = half2_a_6280c();
i = half2_a_6281c();
i = half2_a_6282c();
i = half2_a_6283c();
i = half2_a_6284c();
i = half2_a_6285c();
i = half2_a_6286c();
i = half2_a_7037c();
i = half2_a_7038c();
i = half2_a_7039c();
i = half2_a_7040c();
i = half2_a_7041c();
i = half2_a_7042c();
i = half2_a_7043c();
i = half2_a_7044c();
i = half2_a_7045c();
i = half2_a_7046c();
i = half2_a_957c();
i = half2_a_958c();
i = half2_a_959c();
i = half2_a_960c();
i = half2_a_961c();
i = half2_a_962c();
i = half2_a_963c();
i = half2_a_964c();
i = half2_a_965c();
i = half2_a_966c();
i = half2_e_1727c();
i = half2_e_1728c();
i = half2_e_1729c();
i = half2_e_1730c();
i = half2_e_1731c();
i = half2_e_1732c();
i = half2_e_1733c();
i = half2_e_1734c();
i = half2_e_1735c();
i = half2_e_1736c();
i = half2_e_207c();
i = half2_e_208c();
i = half2_e_209c();
i = half2_e_210c();
i = half2_e_211c();
i = half2_e_212c();
i = half2_e_213c();
i = half2_e_214c();
i = half2_e_215c();
i = half2_e_216c();
i = half2_e_2487c();
i = half2_e_2488c();
i = half2_e_2489c();
i = half2_e_2490c();
i = half2_e_2491c();
i = half2_e_2492c();
i = half2_e_2493c();
i = half2_e_2494c();
i = half2_e_2495c();
i = half2_e_2496c();
i = half2_e_3247c();
i = half2_e_3248c();
i = half2_e_3249c();
i = half2_e_3250c();
i = half2_e_3251c();
i = half2_e_3252c();
i = half2_e_3253c();
i = half2_e_3254c();
i = half2_e_3255c();
i = half2_e_3256c();
i = half2_e_4007c();
i = half2_e_4008c();
i = half2_e_4009c();
i = half2_e_4010c();
i = half2_e_4011c();
i = half2_e_4012c();
i = half2_e_4013c();
i = half2_e_4014c();
i = half2_e_4015c();
i = half2_e_4016c();
i = half2_e_4767c();
i = half2_e_4768c();
i = half2_e_4769c();
i = half2_e_4770c();
i = half2_e_4771c();
i = half2_e_4772c();
i = half2_e_4773c();
i = half2_e_4774c();
i = half2_e_4775c();
i = half2_e_4776c();
i = half2_e_5527c();
i = half2_e_5528c();
i = half2_e_5529c();
i = half2_e_5530c();
i = half2_e_5531c();
i = half2_e_5532c();
i = half2_e_5533c();
i = half2_e_5534c();
i = half2_e_5535c();
i = half2_e_5536c();
i = half2_e_6287c();
i = half2_e_6288c();
i = half2_e_6289c();
i = half2_e_6290c();
i = half2_e_6291c();
i = half2_e_6292c();
i = half2_e_6293c();
i = half2_e_6294c();
i = half2_e_6295c();
i = half2_e_6296c();
i = half2_e_7047c();
i = half2_e_7048c();
i = half2_e_7049c();
i = half2_e_7050c();
i = half2_e_7051c();
i = half2_e_7052c();
i = half2_e_7053c();
i = half2_e_7054c();
i = half2_e_7055c();
i = half2_e_7056c();
i = half2_e_967c();
i = half2_e_968c();
i = half2_e_969c();
i = half2_e_970c();
i = half2_e_971c();
i = half2_e_972c();
i = half2_e_973c();
i = half2_e_974c();
i = half2_e_975c();
i = half2_e_976c();
i = half2_f_1737c();
i = half2_f_1738c();
i = half2_f_1739c();
i = half2_f_1740c();
i = half2_f_1741c();
i = half2_f_1742c();
i = half2_f_1743c();
i = half2_f_1744c();
i = half2_f_1745c();
i = half2_f_1746c();
i = half2_f_217c();
i = half2_f_218c();
i = half2_f_219c();
i = half2_f_220c();
i = half2_f_221c();
i = half2_f_222c();
i = half2_f_223c();
i = half2_f_224c();
i = half2_f_225c();
i = half2_f_226c();
i = half2_f_2497c();
i = half2_f_2498c();
i = half2_f_2499c();
i = half2_f_2500c();
i = half2_f_2501c();
i = half2_f_2502c();
i = half2_f_2503c();
i = half2_f_2504c();
i = half2_f_2505c();
i = half2_f_2506c();
i = half2_f_3257c();
i = half2_f_3258c();
i = half2_f_3259c();
i = half2_f_3260c();
i = half2_f_3261c();
i = half2_f_3262c();
i = half2_f_3263c();
i = half2_f_3264c();
i = half2_f_3265c();
i = half2_f_3266c();
i = half2_f_4017c();
i = half2_f_4018c();
i = half2_f_4019c();
i = half2_f_4020c();
i = half2_f_4021c();
i = half2_f_4022c();
i = half2_f_4023c();
i = half2_f_4024c();
i = half2_f_4025c();
i = half2_f_4026c();
i = half2_f_4777c();
i = half2_f_4778c();
i = half2_f_4779c();
i = half2_f_4780c();
i = half2_f_4781c();
i = half2_f_4782c();
i = half2_f_4783c();
i = half2_f_4784c();
i = half2_f_4785c();
i = half2_f_4786c();
i = half2_f_5537c();
i = half2_f_5538c();
i = half2_f_5539c();
i = half2_f_5540c();
i = half2_f_5541c();
i = half2_f_5542c();
i = half2_f_5543c();
i = half2_f_5544c();
i = half2_f_5545c();
i = half2_f_5546c();
i = half2_f_6297c();
i = half2_f_6298c();
i = half2_f_6299c();
i = half2_f_6300c();
i = half2_f_6301c();
i = half2_f_6302c();
i = half2_f_6303c();
i = half2_f_6304c();
i = half2_f_6305c();
i = half2_f_6306c();
i = half2_f_7057c();
i = half2_f_7058c();
i = half2_f_7059c();
i = half2_f_7060c();
i = half2_f_7061c();
i = half2_f_7062c();
i = half2_f_7063c();
i = half2_f_7064c();
i = half2_f_7065c();
i = half2_f_7066c();
i = half2_f_977c();
i = half2_f_978c();
i = half2_f_979c();
i = half2_f_980c();
i = half2_f_981c();
i = half2_f_982c();
i = half2_f_983c();
i = half2_f_984c();
i = half2_f_985c();
i = half2_f_986c();
i = half2_g_1747c();
i = half2_g_1748c();
i = half2_g_1749c();
i = half2_g_1750c();
i = half2_g_1751c();
i = half2_g_1752c();
i = half2_g_1753c();
i = half2_g_1754c();
i = half2_g_1755c();
i = half2_g_1756c();
i = half2_g_227c();
i = half2_g_228c();
i = half2_g_229c();
i = half2_g_230c();
i = half2_g_231c();
i = half2_g_232c();
i = half2_g_233c();
i = half2_g_234c();
i = half2_g_235c();
i = half2_g_236c();
i = half2_g_2507c();
i = half2_g_2508c();
i = half2_g_2509c();
i = half2_g_2510c();
i = half2_g_2511c();
i = half2_g_2512c();
i = half2_g_2513c();
i = half2_g_2514c();
i = half2_g_2515c();
i = half2_g_2516c();
i = half2_g_3267c();
i = half2_g_3268c();
i = half2_g_3269c();
i = half2_g_3270c();
i = half2_g_3271c();
i = half2_g_3272c();
i = half2_g_3273c();
i = half2_g_3274c();
i = half2_g_3275c();
i = half2_g_3276c();
i = half2_g_4027c();
i = half2_g_4028c();
i = half2_g_4029c();
i = half2_g_4030c();
i = half2_g_4031c();
i = half2_g_4032c();
i = half2_g_4033c();
i = half2_g_4034c();
i = half2_g_4035c();
i = half2_g_4036c();
i = half2_g_4787c();
i = half2_g_4788c();
i = half2_g_4789c();
i = half2_g_4790c();
i = half2_g_4791c();
i = half2_g_4792c();
i = half2_g_4793c();
i = half2_g_4794c();
i = half2_g_4795c();
i = half2_g_4796c();
i = half2_g_5547c();
i = half2_g_5548c();
i = half2_g_5549c();
i = half2_g_5550c();
i = half2_g_5551c();
i = half2_g_5552c();
i = half2_g_5553c();
i = half2_g_5554c();
i = half2_g_5555c();
i = half2_g_5556c();
i = half2_g_6307c();
i = half2_g_6308c();
i = half2_g_6309c();
i = half2_g_6310c();
i = half2_g_6311c();
i = half2_g_6312c();
i = half2_g_6313c();
i = half2_g_6314c();
i = half2_g_6315c();
i = half2_g_6316c();
i = half2_g_7067c();
i = half2_g_7068c();
i = half2_g_7069c();
i = half2_g_7070c();
i = half2_g_7071c();
i = half2_g_7072c();
i = half2_g_7073c();
i = half2_g_7074c();
i = half2_g_7075c();
i = half2_g_7076c();
i = half2_g_987c();
i = half2_g_988c();
i = half2_g_989c();
i = half2_g_990c();
i = half2_g_991c();
i = half2_g_992c();
i = half2_g_993c();
i = half2_g_994c();
i = half2_g_995c();
i = half2_g_996c();
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
// From groups/PrintfHalf.lst: status: , errorcode: , message: 
