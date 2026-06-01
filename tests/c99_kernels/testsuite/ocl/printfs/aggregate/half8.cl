/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/half8.c'  */

int half8_a_1245c() {
  // { dg-printf -re "half8_a_1245c===.*===.*===" }
  half8 var1 = (half8) (7,8,-6,-2,-8,-7,3,-5);
  half8 var2 = (half8) (-6,-3,-6,3,2,-3,5,4);
  int i = printf("half8_a_1245c===%-v8ha===%-v8ha===\n",var1,var2);
  return i;
}

int half8_a_1246c() {
  // { dg-printf -re "half8_a_1246c===.*===.*===" }
  half8 var1 = (half8) (3,8,0,6,-4,-4,-1,-8);
  half8 var2 = (half8) (7,2,-6,-8,2,-3,-6,-5);
  int i = printf("half8_a_1246c===%-.1v8ha===%-.1v8ha===\n",var1,var2);
  return i;
}

int half8_a_1247c() {
  // { dg-printf -re "half8_a_1247c===.*===.*===" }
  half8 var1 = (half8) (4,-1,-6,-7,-2,123445,-3,-5);
  half8 var2 = (half8) (8,7,6,8,0,5,5,-4);
  int i = printf("half8_a_1247c===%-.2v8ha===%-.2v8ha===\n",var1,var2);
  return i;
}

int half8_a_1248c() {
  // { dg-printf -re "half8_a_1248c===.*===.*===" }
  half8 var1 = (half8) (-1,4,-3,7,4,-8,3,-7);
  half8 var2 = (half8) (0,2,4,123445,-6,-6,-123455,8);
  int i = printf("half8_a_1248c===%-.3v8ha===%-.3v8ha===\n",var1,var2);
  return i;
}

int half8_a_1249c() {
  // { dg-printf -re "half8_a_1249c===.*===.*===" }
  half8 var1 = (half8) (1,123445,0,123445,-6,3,2,-3);
  half8 var2 = (half8) (4,1,1,5,2,-1,3,0);
  int i = printf("half8_a_1249c===%-.10v8ha===%-.10v8ha===\n",var1,var2);
  return i;
}

int half8_a_1250c() {
  // { dg-printf -re "half8_a_1250c===.*===.*===" }
  half8 var1 = (half8) (-2,-123455,7,-5,7,-5,-123455,5);
  half8 var2 = (half8) (0,-6,7,-3,0,3,-2,-6);
  int i = printf("half8_a_1250c===%-v8hA===%-v8hA===\n",var1,var2);
  return i;
}

int half8_a_1251c() {
  // { dg-printf -re "half8_a_1251c===.*===.*===" }
  half8 var1 = (half8) (-6,-2,-2,-4,6,0,4,1);
  half8 var2 = (half8) (6,123445,123445,-3,4,-3,-6,1);
  int i = printf("half8_a_1251c===%-.1v8hA===%-.1v8hA===\n",var1,var2);
  return i;
}

int half8_a_1252c() {
  // { dg-printf -re "half8_a_1252c===.*===.*===" }
  half8 var1 = (half8) (-4,-2,-5,2,5,-3,123445,-123455);
  half8 var2 = (half8) (1,1,-6,-1,4,6,4,-4);
  int i = printf("half8_a_1252c===%-.2v8hA===%-.2v8hA===\n",var1,var2);
  return i;
}

int half8_a_1253c() {
  // { dg-printf -re "half8_a_1253c===.*===.*===" }
  half8 var1 = (half8) (-1,123445,8,6,123445,2,-5,-7);
  half8 var2 = (half8) (4,0,1,-4,-123455,8,4,-5);
  int i = printf("half8_a_1253c===%-.3v8hA===%-.3v8hA===\n",var1,var2);
  return i;
}

int half8_a_1254c() {
  // { dg-printf -re "half8_a_1254c===.*===.*===" }
  half8 var1 = (half8) (4,4,-2,-4,3,-4,4,-5);
  half8 var2 = (half8) (1,-123455,-123455,-2,-5,-5,-2,-2);
  int i = printf("half8_a_1254c===%-.10v8hA===%-.10v8hA===\n",var1,var2);
  return i;
}

int half8_a_2005c() {
  // { dg-printf -re "half8_a_2005c===.*===.*===" }
  half8 var1 = (half8) (-1,-4,-8,2,2,-6,123445,123445);
  half8 var2 = (half8) (123445,-5,7,-3,5,8,-2,-6);
  int i = printf("half8_a_2005c===%+v8ha===%+v8ha===\n",var1,var2);
  return i;
}

int half8_a_2006c() {
  // { dg-printf -re "half8_a_2006c===.*===.*===" }
  half8 var1 = (half8) (2,7,123445,4,-5,-123455,-3,3);
  half8 var2 = (half8) (3,-5,8,1,-2,-4,0,3);
  int i = printf("half8_a_2006c===%+.1v8ha===%+.1v8ha===\n",var1,var2);
  return i;
}

int half8_a_2007c() {
  // { dg-printf -re "half8_a_2007c===.*===.*===" }
  half8 var1 = (half8) (2,8,-3,-5,-6,4,2,3);
  half8 var2 = (half8) (-5,-1,7,-4,-4,-6,-7,-123455);
  int i = printf("half8_a_2007c===%+.2v8ha===%+.2v8ha===\n",var1,var2);
  return i;
}

int half8_a_2008c() {
  // { dg-printf -re "half8_a_2008c===.*===.*===" }
  half8 var1 = (half8) (-123455,3,-6,5,-4,0,1,-4);
  half8 var2 = (half8) (123445,0,-4,-8,8,1,-4,8);
  int i = printf("half8_a_2008c===%+.3v8ha===%+.3v8ha===\n",var1,var2);
  return i;
}

int half8_a_2009c() {
  // { dg-printf -re "half8_a_2009c===.*===.*===" }
  half8 var1 = (half8) (-7,-2,6,4,6,-4,-5,0);
  half8 var2 = (half8) (-6,-123455,-4,5,-3,-2,2,123445);
  int i = printf("half8_a_2009c===%+.10v8ha===%+.10v8ha===\n",var1,var2);
  return i;
}

int half8_a_2010c() {
  // { dg-printf -re "half8_a_2010c===.*===.*===" }
  half8 var1 = (half8) (2,-6,-7,0,2,-7,7,-5);
  half8 var2 = (half8) (-5,8,-7,6,123445,5,6,-1);
  int i = printf("half8_a_2010c===%+v8hA===%+v8hA===\n",var1,var2);
  return i;
}

int half8_a_2011c() {
  // { dg-printf -re "half8_a_2011c===.*===.*===" }
  half8 var1 = (half8) (3,-7,8,0,2,1,0,8);
  half8 var2 = (half8) (-5,4,-8,2,123445,-123455,-3,5);
  int i = printf("half8_a_2011c===%+.1v8hA===%+.1v8hA===\n",var1,var2);
  return i;
}

int half8_a_2012c() {
  // { dg-printf -re "half8_a_2012c===.*===.*===" }
  half8 var1 = (half8) (7,123445,8,4,-1,1,-7,-5);
  half8 var2 = (half8) (-2,-5,-4,-3,-7,-7,-7,1);
  int i = printf("half8_a_2012c===%+.2v8hA===%+.2v8hA===\n",var1,var2);
  return i;
}

int half8_a_2013c() {
  // { dg-printf -re "half8_a_2013c===.*===.*===" }
  half8 var1 = (half8) (-2,3,0,1,3,-3,7,-5);
  half8 var2 = (half8) (123445,4,-7,1,1,-123455,-8,-2);
  int i = printf("half8_a_2013c===%+.3v8hA===%+.3v8hA===\n",var1,var2);
  return i;
}

int half8_a_2014c() {
  // { dg-printf -re "half8_a_2014c===.*===.*===" }
  half8 var1 = (half8) (0,2,6,4,-5,6,3,-2);
  half8 var2 = (half8) (8,4,2,-3,-7,5,-6,3);
  int i = printf("half8_a_2014c===%+.10v8hA===%+.10v8hA===\n",var1,var2);
  return i;
}

int half8_a_2765c() {
  // { dg-printf -re "half8_a_2765c===.*===.*===" }
  half8 var1 = (half8) (1,-1,-2,-5,5,-3,123445,2);
  half8 var2 = (half8) (-2,1,4,0,2,-7,-4,8);
  int i = printf("half8_a_2765c===%#v8ha===%#v8ha===\n",var1,var2);
  return i;
}

int half8_a_2766c() {
  // { dg-printf -re "half8_a_2766c===.*===.*===" }
  half8 var1 = (half8) (8,-4,-123455,-7,7,8,2,-3);
  half8 var2 = (half8) (-1,2,3,0,8,-7,-4,2);
  int i = printf("half8_a_2766c===%#.1v8ha===%#.1v8ha===\n",var1,var2);
  return i;
}

int half8_a_2767c() {
  // { dg-printf -re "half8_a_2767c===.*===.*===" }
  half8 var1 = (half8) (-3,-123455,-1,1,2,2,0,0);
  half8 var2 = (half8) (-3,-1,-6,-7,3,4,5,6);
  int i = printf("half8_a_2767c===%#.2v8ha===%#.2v8ha===\n",var1,var2);
  return i;
}

int half8_a_2768c() {
  // { dg-printf -re "half8_a_2768c===.*===.*===" }
  half8 var1 = (half8) (-4,123445,-3,-7,-2,-2,-6,-6);
  half8 var2 = (half8) (-3,8,2,2,6,-7,-1,7);
  int i = printf("half8_a_2768c===%#.3v8ha===%#.3v8ha===\n",var1,var2);
  return i;
}

int half8_a_2769c() {
  // { dg-printf -re "half8_a_2769c===.*===.*===" }
  half8 var1 = (half8) (7,-2,-2,-123455,-6,-4,123445,5);
  half8 var2 = (half8) (4,7,8,-123455,-123455,-2,1,-8);
  int i = printf("half8_a_2769c===%#.10v8ha===%#.10v8ha===\n",var1,var2);
  return i;
}

int half8_a_2770c() {
  // { dg-printf -re "half8_a_2770c===.*===.*===" }
  half8 var1 = (half8) (-8,-2,-8,7,-123455,8,4,123445);
  half8 var2 = (half8) (8,-123455,5,-3,-8,-6,-8,-2);
  int i = printf("half8_a_2770c===%#v8hA===%#v8hA===\n",var1,var2);
  return i;
}

int half8_a_2771c() {
  // { dg-printf -re "half8_a_2771c===.*===.*===" }
  half8 var1 = (half8) (-5,1,-123455,2,1,7,1,-6);
  half8 var2 = (half8) (0,5,1,6,-8,-4,-1,123445);
  int i = printf("half8_a_2771c===%#.1v8hA===%#.1v8hA===\n",var1,var2);
  return i;
}

int half8_a_2772c() {
  // { dg-printf -re "half8_a_2772c===.*===.*===" }
  half8 var1 = (half8) (1,-3,-3,1,3,-4,0,-6);
  half8 var2 = (half8) (1,-4,2,4,8,1,123445,-5);
  int i = printf("half8_a_2772c===%#.2v8hA===%#.2v8hA===\n",var1,var2);
  return i;
}

int half8_a_2773c() {
  // { dg-printf -re "half8_a_2773c===.*===.*===" }
  half8 var1 = (half8) (4,2,-6,5,7,5,7,-5);
  half8 var2 = (half8) (-3,0,5,-8,8,-3,-123455,3);
  int i = printf("half8_a_2773c===%#.3v8hA===%#.3v8hA===\n",var1,var2);
  return i;
}

int half8_a_2774c() {
  // { dg-printf -re "half8_a_2774c===.*===.*===" }
  half8 var1 = (half8) (2,-2,7,3,0,7,123445,-7);
  half8 var2 = (half8) (-8,3,-1,8,0,-3,5,123445);
  int i = printf("half8_a_2774c===%#.10v8hA===%#.10v8hA===\n",var1,var2);
  return i;
}

int half8_a_3525c() {
  // { dg-printf -re "half8_a_3525c===.*===.*===" }
  half8 var1 = (half8) (4,-7,-123455,2,6,0,-8,6);
  half8 var2 = (half8) (-2,8,7,0,-7,1,4,-8);
  int i = printf("half8_a_3525c===%-+v8ha===%-+v8ha===\n",var1,var2);
  return i;
}

int half8_a_3526c() {
  // { dg-printf -re "half8_a_3526c===.*===.*===" }
  half8 var1 = (half8) (8,-5,5,0,-6,-123455,-4,-2);
  half8 var2 = (half8) (6,-123455,5,-6,-6,-4,2,5);
  int i = printf("half8_a_3526c===%-+.1v8ha===%-+.1v8ha===\n",var1,var2);
  return i;
}

int half8_a_3527c() {
  // { dg-printf -re "half8_a_3527c===.*===.*===" }
  half8 var1 = (half8) (-2,3,-2,-6,3,-123455,0,6);
  half8 var2 = (half8) (123445,-6,5,-5,-8,8,-6,-123455);
  int i = printf("half8_a_3527c===%-+.2v8ha===%-+.2v8ha===\n",var1,var2);
  return i;
}

int half8_a_3528c() {
  // { dg-printf -re "half8_a_3528c===.*===.*===" }
  half8 var1 = (half8) (-3,7,123445,8,8,6,123445,7);
  half8 var2 = (half8) (-123455,-2,-123455,-6,3,123445,3,-2);
  int i = printf("half8_a_3528c===%-+.3v8ha===%-+.3v8ha===\n",var1,var2);
  return i;
}

int half8_a_3529c() {
  // { dg-printf -re "half8_a_3529c===.*===.*===" }
  half8 var1 = (half8) (2,0,3,-6,3,6,0,123445);
  half8 var2 = (half8) (-2,1,6,5,1,-3,3,4);
  int i = printf("half8_a_3529c===%-+.10v8ha===%-+.10v8ha===\n",var1,var2);
  return i;
}

int half8_a_3530c() {
  // { dg-printf -re "half8_a_3530c===.*===.*===" }
  half8 var1 = (half8) (-8,-1,7,0,5,-123455,3,4);
  half8 var2 = (half8) (1,-5,1,3,1,-1,-1,-4);
  int i = printf("half8_a_3530c===%-+v8hA===%-+v8hA===\n",var1,var2);
  return i;
}

int half8_a_3531c() {
  // { dg-printf -re "half8_a_3531c===.*===.*===" }
  half8 var1 = (half8) (123445,123445,6,-6,3,-2,5,-1);
  half8 var2 = (half8) (123445,-1,-2,-5,3,4,123445,3);
  int i = printf("half8_a_3531c===%-+.1v8hA===%-+.1v8hA===\n",var1,var2);
  return i;
}

int half8_a_3532c() {
  // { dg-printf -re "half8_a_3532c===.*===.*===" }
  half8 var1 = (half8) (-1,2,-5,-6,-6,-1,-6,2);
  half8 var2 = (half8) (-5,-1,3,123445,-3,2,-3,-4);
  int i = printf("half8_a_3532c===%-+.2v8hA===%-+.2v8hA===\n",var1,var2);
  return i;
}

int half8_a_3533c() {
  // { dg-printf -re "half8_a_3533c===.*===.*===" }
  half8 var1 = (half8) (-7,4,123445,8,7,0,6,7);
  half8 var2 = (half8) (-7,1,0,-6,-5,3,1,5);
  int i = printf("half8_a_3533c===%-+.3v8hA===%-+.3v8hA===\n",var1,var2);
  return i;
}

int half8_a_3534c() {
  // { dg-printf -re "half8_a_3534c===.*===.*===" }
  half8 var1 = (half8) (1,123445,-4,-1,-1,-123455,-8,1);
  half8 var2 = (half8) (8,3,-5,123445,-5,8,-2,-5);
  int i = printf("half8_a_3534c===%-+.10v8hA===%-+.10v8hA===\n",var1,var2);
  return i;
}

int half8_a_4285c() {
  // { dg-printf -re "half8_a_4285c===.*===.*===" }
  half8 var1 = (half8) (-5,-6,6,3,-6,-123455,-123455,4);
  half8 var2 = (half8) (6,3,-2,3,-5,-7,-5,3);
  int i = printf("half8_a_4285c===% 10v8ha===% 10v8ha===\n",var1,var2);
  return i;
}

int half8_a_4286c() {
  // { dg-printf -re "half8_a_4286c===.*===.*===" }
  half8 var1 = (half8) (8,-7,-6,0,5,5,-123455,6);
  half8 var2 = (half8) (-3,-5,5,1,2,-8,-8,-4);
  int i = printf("half8_a_4286c===% 10.1v8ha===% 10.1v8ha===\n",var1,var2);
  return i;
}

int half8_a_4287c() {
  // { dg-printf -re "half8_a_4287c===.*===.*===" }
  half8 var1 = (half8) (-123455,-5,4,-1,-3,3,6,4);
  half8 var2 = (half8) (-4,-4,-2,1,-6,-8,-6,8);
  int i = printf("half8_a_4287c===% 10.2v8ha===% 10.2v8ha===\n",var1,var2);
  return i;
}

int half8_a_4288c() {
  // { dg-printf -re "half8_a_4288c===.*===.*===" }
  half8 var1 = (half8) (-8,1,6,-5,-3,5,-8,-6);
  half8 var2 = (half8) (-5,0,-6,5,6,7,-2,5);
  int i = printf("half8_a_4288c===% 10.3v8ha===% 10.3v8ha===\n",var1,var2);
  return i;
}

int half8_a_4289c() {
  // { dg-printf -re "half8_a_4289c===.*===.*===" }
  half8 var1 = (half8) (-1,5,4,-1,6,6,8,6);
  half8 var2 = (half8) (-3,-3,0,-1,6,6,4,123445);
  int i = printf("half8_a_4289c===% 10.10v8ha===% 10.10v8ha===\n",var1,var2);
  return i;
}

int half8_a_4290c() {
  // { dg-printf -re "half8_a_4290c===.*===.*===" }
  half8 var1 = (half8) (8,-5,-5,-123455,-1,-6,-3,8);
  half8 var2 = (half8) (5,-2,6,7,-3,-2,4,-8);
  int i = printf("half8_a_4290c===% 10v8hA===% 10v8hA===\n",var1,var2);
  return i;
}

int half8_a_4291c() {
  // { dg-printf -re "half8_a_4291c===.*===.*===" }
  half8 var1 = (half8) (-2,8,-7,8,-2,3,-123455,3);
  half8 var2 = (half8) (3,1,-2,4,-2,-8,-7,4);
  int i = printf("half8_a_4291c===% 10.1v8hA===% 10.1v8hA===\n",var1,var2);
  return i;
}

int half8_a_4292c() {
  // { dg-printf -re "half8_a_4292c===.*===.*===" }
  half8 var1 = (half8) (-123455,5,-8,4,-1,8,-7,-123455);
  half8 var2 = (half8) (123445,2,8,-5,7,-4,-123455,-6);
  int i = printf("half8_a_4292c===% 10.2v8hA===% 10.2v8hA===\n",var1,var2);
  return i;
}

int half8_a_4293c() {
  // { dg-printf -re "half8_a_4293c===.*===.*===" }
  half8 var1 = (half8) (6,-3,-1,123445,-123455,-4,-4,4);
  half8 var2 = (half8) (-7,-8,1,-7,2,-2,-2,-123455);
  int i = printf("half8_a_4293c===% 10.3v8hA===% 10.3v8hA===\n",var1,var2);
  return i;
}

int half8_a_4294c() {
  // { dg-printf -re "half8_a_4294c===.*===.*===" }
  half8 var1 = (half8) (6,5,-5,2,2,-4,-7,-5);
  half8 var2 = (half8) (-5,-1,-6,-6,-2,-6,123445,-6);
  int i = printf("half8_a_4294c===% 10.10v8hA===% 10.10v8hA===\n",var1,var2);
  return i;
}

int half8_a_485c() {
  // { dg-printf -re "half8_a_485c===.*===.*===" }
  half8 var1 = (half8) (-7,2,8,7,-3,123445,-6,-5);
  half8 var2 = (half8) (-2,-123455,-6,7,-123455,-1,123445,3);
  int i = printf("half8_a_485c===%v8ha===%v8ha===\n",var1,var2);
  return i;
}

int half8_a_486c() {
  // { dg-printf -re "half8_a_486c===.*===.*===" }
  half8 var1 = (half8) (-8,-5,6,-123455,-6,8,-5,-6);
  half8 var2 = (half8) (3,4,-7,-6,4,-6,-5,-2);
  int i = printf("half8_a_486c===%.1v8ha===%.1v8ha===\n",var1,var2);
  return i;
}

int half8_a_487c() {
  // { dg-printf -re "half8_a_487c===.*===.*===" }
  half8 var1 = (half8) (-6,-8,123445,-8,-1,3,7,7);
  half8 var2 = (half8) (2,-8,8,7,-4,-123455,2,0);
  int i = printf("half8_a_487c===%.2v8ha===%.2v8ha===\n",var1,var2);
  return i;
}

int half8_a_488c() {
  // { dg-printf -re "half8_a_488c===.*===.*===" }
  half8 var1 = (half8) (7,-5,-8,8,-5,2,-1,0);
  half8 var2 = (half8) (-7,-5,8,-2,1,-7,-6,-8);
  int i = printf("half8_a_488c===%.3v8ha===%.3v8ha===\n",var1,var2);
  return i;
}

int half8_a_489c() {
  // { dg-printf -re "half8_a_489c===.*===.*===" }
  half8 var1 = (half8) (2,-4,7,8,-123455,4,7,2);
  half8 var2 = (half8) (123445,-3,-2,123445,-123455,8,5,3);
  int i = printf("half8_a_489c===%.10v8ha===%.10v8ha===\n",var1,var2);
  return i;
}

int half8_a_490c() {
  // { dg-printf -re "half8_a_490c===.*===.*===" }
  half8 var1 = (half8) (-3,-1,2,2,2,123445,-3,-3);
  half8 var2 = (half8) (5,-3,-5,2,-4,-1,-8,5);
  int i = printf("half8_a_490c===%v8hA===%v8hA===\n",var1,var2);
  return i;
}

int half8_a_491c() {
  // { dg-printf -re "half8_a_491c===.*===.*===" }
  half8 var1 = (half8) (0,1,4,0,8,-123455,5,-4);
  half8 var2 = (half8) (-8,123445,3,-7,-3,-2,-2,-3);
  int i = printf("half8_a_491c===%.1v8hA===%.1v8hA===\n",var1,var2);
  return i;
}

int half8_a_492c() {
  // { dg-printf -re "half8_a_492c===.*===.*===" }
  half8 var1 = (half8) (-123455,-4,-3,0,-7,6,0,-1);
  half8 var2 = (half8) (-8,5,-5,8,-7,8,-3,-3);
  int i = printf("half8_a_492c===%.2v8hA===%.2v8hA===\n",var1,var2);
  return i;
}

int half8_a_493c() {
  // { dg-printf -re "half8_a_493c===.*===.*===" }
  half8 var1 = (half8) (-123455,-7,0,-1,6,-2,7,-7);
  half8 var2 = (half8) (-4,-4,123445,123445,2,5,-8,-8);
  int i = printf("half8_a_493c===%.3v8hA===%.3v8hA===\n",var1,var2);
  return i;
}

int half8_a_494c() {
  // { dg-printf -re "half8_a_494c===.*===.*===" }
  half8 var1 = (half8) (-123455,8,-2,1,6,2,2,-123455);
  half8 var2 = (half8) (-7,0,123445,5,3,-3,0,-1);
  int i = printf("half8_a_494c===%.10v8hA===%.10v8hA===\n",var1,var2);
  return i;
}

int half8_a_5045c() {
  // { dg-printf -re "half8_a_5045c===.*===.*===" }
  half8 var1 = (half8) (2,-5,-8,-6,3,123445,7,4);
  half8 var2 = (half8) (7,2,-7,-3,-1,4,4,-6);
  int i = printf("half8_a_5045c===%010v8ha===%010v8ha===\n",var1,var2);
  return i;
}

int half8_a_5046c() {
  // { dg-printf -re "half8_a_5046c===.*===.*===" }
  half8 var1 = (half8) (5,7,123445,-1,-123455,-7,-7,-2);
  half8 var2 = (half8) (-123455,4,-5,0,6,7,-2,1);
  int i = printf("half8_a_5046c===%010.1v8ha===%010.1v8ha===\n",var1,var2);
  return i;
}

int half8_a_5047c() {
  // { dg-printf -re "half8_a_5047c===.*===.*===" }
  half8 var1 = (half8) (4,8,3,8,-6,3,-7,-8);
  half8 var2 = (half8) (0,123445,6,5,123445,8,-4,1);
  int i = printf("half8_a_5047c===%010.2v8ha===%010.2v8ha===\n",var1,var2);
  return i;
}

int half8_a_5048c() {
  // { dg-printf -re "half8_a_5048c===.*===.*===" }
  half8 var1 = (half8) (-123455,-2,123445,123445,3,-7,5,-3);
  half8 var2 = (half8) (3,-6,-2,2,-123455,-2,-1,-6);
  int i = printf("half8_a_5048c===%010.3v8ha===%010.3v8ha===\n",var1,var2);
  return i;
}

int half8_a_5049c() {
  // { dg-printf -re "half8_a_5049c===.*===.*===" }
  half8 var1 = (half8) (-123455,-5,-123455,5,-6,8,2,-2);
  half8 var2 = (half8) (-3,123445,8,6,-2,5,6,-5);
  int i = printf("half8_a_5049c===%010.10v8ha===%010.10v8ha===\n",var1,var2);
  return i;
}

int half8_a_5050c() {
  // { dg-printf -re "half8_a_5050c===.*===.*===" }
  half8 var1 = (half8) (8,-6,-6,-123455,4,1,123445,-6);
  half8 var2 = (half8) (123445,2,8,7,7,-8,-6,0);
  int i = printf("half8_a_5050c===%010v8hA===%010v8hA===\n",var1,var2);
  return i;
}

int half8_a_5051c() {
  // { dg-printf -re "half8_a_5051c===.*===.*===" }
  half8 var1 = (half8) (2,-123455,-1,2,-1,2,1,-5);
  half8 var2 = (half8) (6,0,-3,5,0,-4,4,-123455);
  int i = printf("half8_a_5051c===%010.1v8hA===%010.1v8hA===\n",var1,var2);
  return i;
}

int half8_a_5052c() {
  // { dg-printf -re "half8_a_5052c===.*===.*===" }
  half8 var1 = (half8) (2,123445,8,-5,6,-6,-5,1);
  half8 var2 = (half8) (5,8,5,-2,-6,6,1,123445);
  int i = printf("half8_a_5052c===%010.2v8hA===%010.2v8hA===\n",var1,var2);
  return i;
}

int half8_a_5053c() {
  // { dg-printf -re "half8_a_5053c===.*===.*===" }
  half8 var1 = (half8) (-1,123445,7,1,5,6,0,8);
  half8 var2 = (half8) (2,2,4,-7,7,6,-123455,0);
  int i = printf("half8_a_5053c===%010.3v8hA===%010.3v8hA===\n",var1,var2);
  return i;
}

int half8_a_5054c() {
  // { dg-printf -re "half8_a_5054c===.*===.*===" }
  half8 var1 = (half8) (3,-4,1,123445,123445,6,4,3);
  half8 var2 = (half8) (-8,-6,-4,1,-1,8,3,6);
  int i = printf("half8_a_5054c===%010.10v8hA===%010.10v8hA===\n",var1,var2);
  return i;
}

int half8_a_5805c() {
  // { dg-printf -re "half8_a_5805c===.*===.*===" }
  half8 var1 = (half8) (3,123445,-6,3,-4,3,1,8);
  half8 var2 = (half8) (8,3,-5,-1,0,-3,-4,-1);
  int i = printf("half8_a_5805c===%- 10v8ha===%- 10v8ha===\n",var1,var2);
  return i;
}

int half8_a_5806c() {
  // { dg-printf -re "half8_a_5806c===.*===.*===" }
  half8 var1 = (half8) (-7,-7,2,-123455,6,2,-2,-123455);
  half8 var2 = (half8) (7,1,-6,123445,-5,-6,8,0);
  int i = printf("half8_a_5806c===%- 10.1v8ha===%- 10.1v8ha===\n",var1,var2);
  return i;
}

int half8_a_5807c() {
  // { dg-printf -re "half8_a_5807c===.*===.*===" }
  half8 var1 = (half8) (2,-4,8,123445,-2,0,-3,-1);
  half8 var2 = (half8) (-6,-7,5,2,-123455,-4,-5,-2);
  int i = printf("half8_a_5807c===%- 10.2v8ha===%- 10.2v8ha===\n",var1,var2);
  return i;
}

int half8_a_5808c() {
  // { dg-printf -re "half8_a_5808c===.*===.*===" }
  half8 var1 = (half8) (-123455,-7,-5,7,5,-8,-1,-3);
  half8 var2 = (half8) (4,-1,-5,6,-7,-2,7,123445);
  int i = printf("half8_a_5808c===%- 10.3v8ha===%- 10.3v8ha===\n",var1,var2);
  return i;
}

int half8_a_5809c() {
  // { dg-printf -re "half8_a_5809c===.*===.*===" }
  half8 var1 = (half8) (2,6,-123455,2,7,123445,-7,6);
  half8 var2 = (half8) (-7,-5,-8,-123455,6,123445,-1,7);
  int i = printf("half8_a_5809c===%- 10.10v8ha===%- 10.10v8ha===\n",var1,var2);
  return i;
}

int half8_a_5810c() {
  // { dg-printf -re "half8_a_5810c===.*===.*===" }
  half8 var1 = (half8) (8,4,-1,1,-5,-5,-3,5);
  half8 var2 = (half8) (123445,7,5,2,-8,8,-2,-4);
  int i = printf("half8_a_5810c===%- 10v8hA===%- 10v8hA===\n",var1,var2);
  return i;
}

int half8_a_5811c() {
  // { dg-printf -re "half8_a_5811c===.*===.*===" }
  half8 var1 = (half8) (0,1,-4,-7,-7,-6,-3,7);
  half8 var2 = (half8) (-3,123445,6,-6,-3,123445,3,-8);
  int i = printf("half8_a_5811c===%- 10.1v8hA===%- 10.1v8hA===\n",var1,var2);
  return i;
}

int half8_a_5812c() {
  // { dg-printf -re "half8_a_5812c===.*===.*===" }
  half8 var1 = (half8) (-8,-6,-2,-123455,-7,123445,2,-8);
  half8 var2 = (half8) (-5,0,4,1,-2,-2,-6,4);
  int i = printf("half8_a_5812c===%- 10.2v8hA===%- 10.2v8hA===\n",var1,var2);
  return i;
}

int half8_a_5813c() {
  // { dg-printf -re "half8_a_5813c===.*===.*===" }
  half8 var1 = (half8) (-1,-6,7,0,-123455,4,0,7);
  half8 var2 = (half8) (-123455,-5,-7,6,8,5,-1,6);
  int i = printf("half8_a_5813c===%- 10.3v8hA===%- 10.3v8hA===\n",var1,var2);
  return i;
}

int half8_a_5814c() {
  // { dg-printf -re "half8_a_5814c===.*===.*===" }
  half8 var1 = (half8) (5,4,6,-7,-4,6,2,-6);
  half8 var2 = (half8) (3,-123455,-3,-2,-4,8,8,-3);
  int i = printf("half8_a_5814c===%- 10.10v8hA===%- 10.10v8hA===\n",var1,var2);
  return i;
}

int half8_a_6565c() {
  // { dg-printf -re "half8_a_6565c===.*===.*===" }
  half8 var1 = (half8) (-4,0,-123455,-6,4,6,-2,6);
  half8 var2 = (half8) (-6,-3,0,-5,3,-4,1,0);
  int i = printf("half8_a_6565c===%+ 10v8ha===%+ 10v8ha===\n",var1,var2);
  return i;
}

int half8_a_6566c() {
  // { dg-printf -re "half8_a_6566c===.*===.*===" }
  half8 var1 = (half8) (-2,4,-8,4,-3,0,123445,-3);
  half8 var2 = (half8) (-7,4,4,1,6,-7,5,-123455);
  int i = printf("half8_a_6566c===%+ 10.1v8ha===%+ 10.1v8ha===\n",var1,var2);
  return i;
}

int half8_a_6567c() {
  // { dg-printf -re "half8_a_6567c===.*===.*===" }
  half8 var1 = (half8) (5,8,-6,-3,6,6,0,123445);
  half8 var2 = (half8) (-6,-6,123445,-6,-5,2,-1,1);
  int i = printf("half8_a_6567c===%+ 10.2v8ha===%+ 10.2v8ha===\n",var1,var2);
  return i;
}

int half8_a_6568c() {
  // { dg-printf -re "half8_a_6568c===.*===.*===" }
  half8 var1 = (half8) (-1,4,-7,123445,0,-7,-6,-2);
  half8 var2 = (half8) (123445,-123455,123445,-4,7,7,0,2);
  int i = printf("half8_a_6568c===%+ 10.3v8ha===%+ 10.3v8ha===\n",var1,var2);
  return i;
}

int half8_a_6569c() {
  // { dg-printf -re "half8_a_6569c===.*===.*===" }
  half8 var1 = (half8) (2,7,-3,123445,-1,8,-8,6);
  half8 var2 = (half8) (-8,2,3,4,-1,1,6,2);
  int i = printf("half8_a_6569c===%+ 10.10v8ha===%+ 10.10v8ha===\n",var1,var2);
  return i;
}

int half8_a_6570c() {
  // { dg-printf -re "half8_a_6570c===.*===.*===" }
  half8 var1 = (half8) (2,1,-4,123445,-5,8,6,-6);
  half8 var2 = (half8) (-1,3,-5,1,6,6,123445,6);
  int i = printf("half8_a_6570c===%+ 10v8hA===%+ 10v8hA===\n",var1,var2);
  return i;
}

int half8_a_6571c() {
  // { dg-printf -re "half8_a_6571c===.*===.*===" }
  half8 var1 = (half8) (3,2,7,-6,-6,6,123445,2);
  half8 var2 = (half8) (123445,-5,3,5,8,6,-6,-2);
  int i = printf("half8_a_6571c===%+ 10.1v8hA===%+ 10.1v8hA===\n",var1,var2);
  return i;
}

int half8_a_6572c() {
  // { dg-printf -re "half8_a_6572c===.*===.*===" }
  half8 var1 = (half8) (-5,-2,-8,-6,-2,6,-3,1);
  half8 var2 = (half8) (-7,-6,-3,-1,-4,123445,1,-1);
  int i = printf("half8_a_6572c===%+ 10.2v8hA===%+ 10.2v8hA===\n",var1,var2);
  return i;
}

int half8_a_6573c() {
  // { dg-printf -re "half8_a_6573c===.*===.*===" }
  half8 var1 = (half8) (-3,-8,2,2,5,3,7,-123455);
  half8 var2 = (half8) (4,-8,4,2,1,0,8,-3);
  int i = printf("half8_a_6573c===%+ 10.3v8hA===%+ 10.3v8hA===\n",var1,var2);
  return i;
}

int half8_a_6574c() {
  // { dg-printf -re "half8_a_6574c===.*===.*===" }
  half8 var1 = (half8) (-6,5,6,0,-1,8,-3,5);
  half8 var2 = (half8) (7,123445,8,4,-2,4,7,-6);
  int i = printf("half8_a_6574c===%+ 10.10v8hA===%+ 10.10v8hA===\n",var1,var2);
  return i;
}

int half8_a_7325c() {
  // { dg-printf -re "half8_a_7325c===.*===.*===" }
  half8 var1 = (half8) (2,-123455,8,-2,-5,-6,1,0);
  half8 var2 = (half8) (-1,0,-1,1,6,2,-2,3);
  int i = printf("half8_a_7325c===%+010v8ha===%+010v8ha===\n",var1,var2);
  return i;
}

int half8_a_7326c() {
  // { dg-printf -re "half8_a_7326c===.*===.*===" }
  half8 var1 = (half8) (0,6,5,-123455,-1,2,2,0);
  half8 var2 = (half8) (4,6,0,-1,1,-6,6,-123455);
  int i = printf("half8_a_7326c===%+010.1v8ha===%+010.1v8ha===\n",var1,var2);
  return i;
}

int half8_a_7327c() {
  // { dg-printf -re "half8_a_7327c===.*===.*===" }
  half8 var1 = (half8) (-123455,7,3,0,123445,-5,-2,8);
  half8 var2 = (half8) (3,8,-1,-5,2,-4,-123455,-4);
  int i = printf("half8_a_7327c===%+010.2v8ha===%+010.2v8ha===\n",var1,var2);
  return i;
}

int half8_a_7328c() {
  // { dg-printf -re "half8_a_7328c===.*===.*===" }
  half8 var1 = (half8) (-1,-8,-1,6,7,-7,8,-123455);
  half8 var2 = (half8) (-1,-3,4,-1,6,3,2,6);
  int i = printf("half8_a_7328c===%+010.3v8ha===%+010.3v8ha===\n",var1,var2);
  return i;
}

int half8_a_7329c() {
  // { dg-printf -re "half8_a_7329c===.*===.*===" }
  half8 var1 = (half8) (-5,-3,3,-2,123445,123445,4,-5);
  half8 var2 = (half8) (1,-2,0,5,0,4,-6,-123455);
  int i = printf("half8_a_7329c===%+010.10v8ha===%+010.10v8ha===\n",var1,var2);
  return i;
}

int half8_a_7330c() {
  // { dg-printf -re "half8_a_7330c===.*===.*===" }
  half8 var1 = (half8) (-2,3,-7,-123455,4,-6,7,-6);
  half8 var2 = (half8) (6,123445,-2,2,-123455,7,-2,2);
  int i = printf("half8_a_7330c===%+010v8hA===%+010v8hA===\n",var1,var2);
  return i;
}

int half8_a_7331c() {
  // { dg-printf -re "half8_a_7331c===.*===.*===" }
  half8 var1 = (half8) (4,-4,1,6,8,-2,6,-1);
  half8 var2 = (half8) (123445,123445,7,-4,8,-123455,-2,123445);
  int i = printf("half8_a_7331c===%+010.1v8hA===%+010.1v8hA===\n",var1,var2);
  return i;
}

int half8_a_7332c() {
  // { dg-printf -re "half8_a_7332c===.*===.*===" }
  half8 var1 = (half8) (5,-6,-6,2,8,5,-5,7);
  half8 var2 = (half8) (3,-1,7,-4,-6,1,-8,6);
  int i = printf("half8_a_7332c===%+010.2v8hA===%+010.2v8hA===\n",var1,var2);
  return i;
}

int half8_a_7333c() {
  // { dg-printf -re "half8_a_7333c===.*===.*===" }
  half8 var1 = (half8) (2,-8,8,2,-8,3,123445,3);
  half8 var2 = (half8) (-5,0,-7,-123455,8,-123455,7,-3);
  int i = printf("half8_a_7333c===%+010.3v8hA===%+010.3v8hA===\n",var1,var2);
  return i;
}

int half8_a_7334c() {
  // { dg-printf -re "half8_a_7334c===.*===.*===" }
  half8 var1 = (half8) (6,5,2,4,3,6,-7,-4);
  half8 var2 = (half8) (5,-4,-4,-123455,6,1,5,-4);
  int i = printf("half8_a_7334c===%+010.10v8hA===%+010.10v8hA===\n",var1,var2);
  return i;
}

int half8_e_1255c() {
  // { dg-printf -re "half8_e_1255c===.*===.*===" }
  half8 var1 = (half8) (-4,2,123445,0,-2,4,-123455,6);
  half8 var2 = (half8) (-123455,-8,1,0,123445,-6,5,-3);
  int i = printf("half8_e_1255c===%-v8he===%-v8he===\n",var1,var2);
  return i;
}

int half8_e_1256c() {
  // { dg-printf -re "half8_e_1256c===.*===.*===" }
  half8 var1 = (half8) (-7,123445,-4,5,3,-6,-123455,3);
  half8 var2 = (half8) (-1,-6,6,-5,-123455,6,7,-123455);
  int i = printf("half8_e_1256c===%-.1v8he===%-.1v8he===\n",var1,var2);
  return i;
}

int half8_e_1257c() {
  // { dg-printf -re "half8_e_1257c===.*===.*===" }
  half8 var1 = (half8) (2,6,6,0,-8,-8,-3,1);
  half8 var2 = (half8) (8,8,-3,-4,3,-8,6,-7);
  int i = printf("half8_e_1257c===%-.2v8he===%-.2v8he===\n",var1,var2);
  return i;
}

int half8_e_1258c() {
  // { dg-printf -re "half8_e_1258c===.*===.*===" }
  half8 var1 = (half8) (-1,3,6,-5,2,123445,5,0);
  half8 var2 = (half8) (-6,3,7,-5,-123455,6,-2,-5);
  int i = printf("half8_e_1258c===%-.3v8he===%-.3v8he===\n",var1,var2);
  return i;
}

int half8_e_1259c() {
  // { dg-printf -re "half8_e_1259c===.*===.*===" }
  half8 var1 = (half8) (3,-8,-5,3,-3,7,-123455,0);
  half8 var2 = (half8) (123445,-8,5,-123455,123445,123445,1,-7);
  int i = printf("half8_e_1259c===%-.10v8he===%-.10v8he===\n",var1,var2);
  return i;
}

int half8_e_1260c() {
  // { dg-printf -re "half8_e_1260c===.*===.*===" }
  half8 var1 = (half8) (-4,8,8,-1,4,2,6,6);
  half8 var2 = (half8) (2,-123455,-6,-7,-5,0,-8,-123455);
  int i = printf("half8_e_1260c===%-v8hE===%-v8hE===\n",var1,var2);
  return i;
}

int half8_e_1261c() {
  // { dg-printf -re "half8_e_1261c===.*===.*===" }
  half8 var1 = (half8) (8,-7,-123455,7,2,-6,6,3);
  half8 var2 = (half8) (-4,-1,-1,6,3,-6,123445,-3);
  int i = printf("half8_e_1261c===%-.1v8hE===%-.1v8hE===\n",var1,var2);
  return i;
}

int half8_e_1262c() {
  // { dg-printf -re "half8_e_1262c===.*===.*===" }
  half8 var1 = (half8) (0,5,123445,2,7,-3,-4,-4);
  half8 var2 = (half8) (5,8,2,8,5,-2,-8,2);
  int i = printf("half8_e_1262c===%-.2v8hE===%-.2v8hE===\n",var1,var2);
  return i;
}

int half8_e_1263c() {
  // { dg-printf -re "half8_e_1263c===.*===.*===" }
  half8 var1 = (half8) (-8,-4,0,4,-5,4,-4,6);
  half8 var2 = (half8) (0,6,5,6,-2,-6,-3,-7);
  int i = printf("half8_e_1263c===%-.3v8hE===%-.3v8hE===\n",var1,var2);
  return i;
}

int half8_e_1264c() {
  // { dg-printf -re "half8_e_1264c===.*===.*===" }
  half8 var1 = (half8) (8,-123455,8,-5,7,-4,1,7);
  half8 var2 = (half8) (7,0,-7,6,-2,-4,6,7);
  int i = printf("half8_e_1264c===%-.10v8hE===%-.10v8hE===\n",var1,var2);
  return i;
}

int half8_e_2015c() {
  // { dg-printf -re "half8_e_2015c===.*===.*===" }
  half8 var1 = (half8) (-5,-5,-4,2,-8,-6,6,4);
  half8 var2 = (half8) (-6,-3,7,-4,-7,-2,6,-6);
  int i = printf("half8_e_2015c===%+v8he===%+v8he===\n",var1,var2);
  return i;
}

int half8_e_2016c() {
  // { dg-printf -re "half8_e_2016c===.*===.*===" }
  half8 var1 = (half8) (-6,-7,7,-123455,123445,4,-1,2);
  half8 var2 = (half8) (-6,-8,2,-3,-3,-1,123445,-5);
  int i = printf("half8_e_2016c===%+.1v8he===%+.1v8he===\n",var1,var2);
  return i;
}

int half8_e_2017c() {
  // { dg-printf -re "half8_e_2017c===.*===.*===" }
  half8 var1 = (half8) (7,123445,3,123445,3,1,6,2);
  half8 var2 = (half8) (7,7,7,2,5,-5,1,-4);
  int i = printf("half8_e_2017c===%+.2v8he===%+.2v8he===\n",var1,var2);
  return i;
}

int half8_e_2018c() {
  // { dg-printf -re "half8_e_2018c===.*===.*===" }
  half8 var1 = (half8) (5,-123455,2,-8,8,-5,-6,8);
  half8 var2 = (half8) (-5,5,5,-8,-8,-5,-3,-4);
  int i = printf("half8_e_2018c===%+.3v8he===%+.3v8he===\n",var1,var2);
  return i;
}

int half8_e_2019c() {
  // { dg-printf -re "half8_e_2019c===.*===.*===" }
  half8 var1 = (half8) (4,-4,123445,-8,-123455,8,-7,7);
  half8 var2 = (half8) (-6,3,2,123445,5,6,-7,4);
  int i = printf("half8_e_2019c===%+.10v8he===%+.10v8he===\n",var1,var2);
  return i;
}

int half8_e_2020c() {
  // { dg-printf -re "half8_e_2020c===.*===.*===" }
  half8 var1 = (half8) (-2,-8,3,3,4,-1,-1,-4);
  half8 var2 = (half8) (3,6,-7,0,-4,-8,-1,2);
  int i = printf("half8_e_2020c===%+v8hE===%+v8hE===\n",var1,var2);
  return i;
}

int half8_e_2021c() {
  // { dg-printf -re "half8_e_2021c===.*===.*===" }
  half8 var1 = (half8) (-3,-4,-8,0,8,123445,-2,8);
  half8 var2 = (half8) (4,-4,-7,-8,-5,2,0,-2);
  int i = printf("half8_e_2021c===%+.1v8hE===%+.1v8hE===\n",var1,var2);
  return i;
}

int half8_e_2022c() {
  // { dg-printf -re "half8_e_2022c===.*===.*===" }
  half8 var1 = (half8) (123445,-8,7,4,-2,-3,4,-7);
  half8 var2 = (half8) (-1,-1,2,2,-8,-7,123445,-1);
  int i = printf("half8_e_2022c===%+.2v8hE===%+.2v8hE===\n",var1,var2);
  return i;
}

int half8_e_2023c() {
  // { dg-printf -re "half8_e_2023c===.*===.*===" }
  half8 var1 = (half8) (-8,-123455,1,-7,-5,3,-8,-2);
  half8 var2 = (half8) (5,5,7,4,-4,-4,6,-123455);
  int i = printf("half8_e_2023c===%+.3v8hE===%+.3v8hE===\n",var1,var2);
  return i;
}

int half8_e_2024c() {
  // { dg-printf -re "half8_e_2024c===.*===.*===" }
  half8 var1 = (half8) (-123455,-3,-1,-4,-3,123445,5,-1);
  half8 var2 = (half8) (7,-3,-123455,7,8,8,-4,-1);
  int i = printf("half8_e_2024c===%+.10v8hE===%+.10v8hE===\n",var1,var2);
  return i;
}

int half8_e_2775c() {
  // { dg-printf -re "half8_e_2775c===.*===.*===" }
  half8 var1 = (half8) (2,2,5,-6,-123455,-7,3,123445);
  half8 var2 = (half8) (7,8,0,5,-7,-8,1,1);
  int i = printf("half8_e_2775c===%#v8he===%#v8he===\n",var1,var2);
  return i;
}

int half8_e_2776c() {
  // { dg-printf -re "half8_e_2776c===.*===.*===" }
  half8 var1 = (half8) (1,123445,1,123445,0,-7,6,1);
  half8 var2 = (half8) (-5,6,5,-1,-123455,7,7,-4);
  int i = printf("half8_e_2776c===%#.1v8he===%#.1v8he===\n",var1,var2);
  return i;
}

int half8_e_2777c() {
  // { dg-printf -re "half8_e_2777c===.*===.*===" }
  half8 var1 = (half8) (-7,-3,-8,2,4,-1,-3,0);
  half8 var2 = (half8) (3,-2,-1,-4,8,6,-3,6);
  int i = printf("half8_e_2777c===%#.2v8he===%#.2v8he===\n",var1,var2);
  return i;
}

int half8_e_2778c() {
  // { dg-printf -re "half8_e_2778c===.*===.*===" }
  half8 var1 = (half8) (-4,-4,5,-1,5,-1,2,-8);
  half8 var2 = (half8) (-1,-2,-8,7,-3,-4,4,1);
  int i = printf("half8_e_2778c===%#.3v8he===%#.3v8he===\n",var1,var2);
  return i;
}

int half8_e_2779c() {
  // { dg-printf -re "half8_e_2779c===.*===.*===" }
  half8 var1 = (half8) (7,-1,7,6,-1,4,4,-3);
  half8 var2 = (half8) (-4,3,4,0,-5,0,0,123445);
  int i = printf("half8_e_2779c===%#.10v8he===%#.10v8he===\n",var1,var2);
  return i;
}

int half8_e_2780c() {
  // { dg-printf -re "half8_e_2780c===.*===.*===" }
  half8 var1 = (half8) (-7,123445,-3,6,-4,123445,-1,2);
  half8 var2 = (half8) (6,-6,-3,-7,4,8,8,5);
  int i = printf("half8_e_2780c===%#v8hE===%#v8hE===\n",var1,var2);
  return i;
}

int half8_e_2781c() {
  // { dg-printf -re "half8_e_2781c===.*===.*===" }
  half8 var1 = (half8) (-2,6,-1,3,0,-3,6,7);
  half8 var2 = (half8) (0,3,-2,-7,-5,-5,-6,8);
  int i = printf("half8_e_2781c===%#.1v8hE===%#.1v8hE===\n",var1,var2);
  return i;
}

int half8_e_2782c() {
  // { dg-printf -re "half8_e_2782c===.*===.*===" }
  half8 var1 = (half8) (4,123445,-123455,-6,-2,-8,4,1);
  half8 var2 = (half8) (6,-8,-123455,-5,3,4,-7,-2);
  int i = printf("half8_e_2782c===%#.2v8hE===%#.2v8hE===\n",var1,var2);
  return i;
}

int half8_e_2783c() {
  // { dg-printf -re "half8_e_2783c===.*===.*===" }
  half8 var1 = (half8) (2,1,3,1,-6,5,5,6);
  half8 var2 = (half8) (-123455,-3,7,7,-6,0,4,-4);
  int i = printf("half8_e_2783c===%#.3v8hE===%#.3v8hE===\n",var1,var2);
  return i;
}

int half8_e_2784c() {
  // { dg-printf -re "half8_e_2784c===.*===.*===" }
  half8 var1 = (half8) (8,-7,-5,4,-3,4,-4,-3);
  half8 var2 = (half8) (2,123445,-6,7,4,-5,2,3);
  int i = printf("half8_e_2784c===%#.10v8hE===%#.10v8hE===\n",var1,var2);
  return i;
}

int half8_e_3535c() {
  // { dg-printf -re "half8_e_3535c===.*===.*===" }
  half8 var1 = (half8) (8,-8,-3,-2,-123455,2,-7,0);
  half8 var2 = (half8) (3,-7,-123455,-6,-3,7,-6,2);
  int i = printf("half8_e_3535c===%-+v8he===%-+v8he===\n",var1,var2);
  return i;
}

int half8_e_3536c() {
  // { dg-printf -re "half8_e_3536c===.*===.*===" }
  half8 var1 = (half8) (-1,-2,1,-1,-7,6,-8,123445);
  half8 var2 = (half8) (-6,-2,-6,2,-2,-7,6,-3);
  int i = printf("half8_e_3536c===%-+.1v8he===%-+.1v8he===\n",var1,var2);
  return i;
}

int half8_e_3537c() {
  // { dg-printf -re "half8_e_3537c===.*===.*===" }
  half8 var1 = (half8) (4,-2,-2,6,-1,-3,-4,7);
  half8 var2 = (half8) (-3,5,-3,-3,-4,3,-8,-3);
  int i = printf("half8_e_3537c===%-+.2v8he===%-+.2v8he===\n",var1,var2);
  return i;
}

int half8_e_3538c() {
  // { dg-printf -re "half8_e_3538c===.*===.*===" }
  half8 var1 = (half8) (7,-123455,-7,1,-4,4,6,0);
  half8 var2 = (half8) (3,-6,6,1,5,-123455,5,6);
  int i = printf("half8_e_3538c===%-+.3v8he===%-+.3v8he===\n",var1,var2);
  return i;
}

int half8_e_3539c() {
  // { dg-printf -re "half8_e_3539c===.*===.*===" }
  half8 var1 = (half8) (5,-5,4,-4,3,123445,-6,0);
  half8 var2 = (half8) (-7,-7,-123455,7,6,-1,-123455,7);
  int i = printf("half8_e_3539c===%-+.10v8he===%-+.10v8he===\n",var1,var2);
  return i;
}

int half8_e_3540c() {
  // { dg-printf -re "half8_e_3540c===.*===.*===" }
  half8 var1 = (half8) (2,-4,2,1,-4,-2,0,-8);
  half8 var2 = (half8) (7,5,1,7,6,2,-8,-123455);
  int i = printf("half8_e_3540c===%-+v8hE===%-+v8hE===\n",var1,var2);
  return i;
}

int half8_e_3541c() {
  // { dg-printf -re "half8_e_3541c===.*===.*===" }
  half8 var1 = (half8) (-8,-123455,5,-2,8,-8,-3,-3);
  half8 var2 = (half8) (-7,2,3,5,-1,-1,4,-7);
  int i = printf("half8_e_3541c===%-+.1v8hE===%-+.1v8hE===\n",var1,var2);
  return i;
}

int half8_e_3542c() {
  // { dg-printf -re "half8_e_3542c===.*===.*===" }
  half8 var1 = (half8) (4,-1,3,-7,123445,-6,2,3);
  half8 var2 = (half8) (-5,123445,3,-6,-2,-1,-5,4);
  int i = printf("half8_e_3542c===%-+.2v8hE===%-+.2v8hE===\n",var1,var2);
  return i;
}

int half8_e_3543c() {
  // { dg-printf -re "half8_e_3543c===.*===.*===" }
  half8 var1 = (half8) (3,1,6,8,-2,1,6,-2);
  half8 var2 = (half8) (2,6,0,7,0,-7,5,7);
  int i = printf("half8_e_3543c===%-+.3v8hE===%-+.3v8hE===\n",var1,var2);
  return i;
}

int half8_e_3544c() {
  // { dg-printf -re "half8_e_3544c===.*===.*===" }
  half8 var1 = (half8) (-123455,-123455,7,-4,0,-3,4,6);
  half8 var2 = (half8) (8,-7,1,6,0,-6,-7,-123455);
  int i = printf("half8_e_3544c===%-+.10v8hE===%-+.10v8hE===\n",var1,var2);
  return i;
}

int half8_e_4295c() {
  // { dg-printf -re "half8_e_4295c===.*===.*===" }
  half8 var1 = (half8) (0,6,7,123445,-6,-5,-2,-8);
  half8 var2 = (half8) (5,5,-5,-3,-3,3,6,7);
  int i = printf("half8_e_4295c===% 10v8he===% 10v8he===\n",var1,var2);
  return i;
}

int half8_e_4296c() {
  // { dg-printf -re "half8_e_4296c===.*===.*===" }
  half8 var1 = (half8) (8,-4,123445,-3,-2,-4,-1,0);
  half8 var2 = (half8) (1,2,4,1,123445,-6,2,-5);
  int i = printf("half8_e_4296c===% 10.1v8he===% 10.1v8he===\n",var1,var2);
  return i;
}

int half8_e_4297c() {
  // { dg-printf -re "half8_e_4297c===.*===.*===" }
  half8 var1 = (half8) (-3,4,1,-123455,-5,-8,6,-4);
  half8 var2 = (half8) (4,-5,123445,-6,4,-8,1,2);
  int i = printf("half8_e_4297c===% 10.2v8he===% 10.2v8he===\n",var1,var2);
  return i;
}

int half8_e_4298c() {
  // { dg-printf -re "half8_e_4298c===.*===.*===" }
  half8 var1 = (half8) (5,-123455,-8,-7,-6,-6,-2,4);
  half8 var2 = (half8) (-3,5,-2,0,-6,4,4,-123455);
  int i = printf("half8_e_4298c===% 10.3v8he===% 10.3v8he===\n",var1,var2);
  return i;
}

int half8_e_4299c() {
  // { dg-printf -re "half8_e_4299c===.*===.*===" }
  half8 var1 = (half8) (-5,5,3,6,-6,-1,5,-7);
  half8 var2 = (half8) (5,-4,-4,-1,-7,-5,8,-5);
  int i = printf("half8_e_4299c===% 10.10v8he===% 10.10v8he===\n",var1,var2);
  return i;
}

int half8_e_4300c() {
  // { dg-printf -re "half8_e_4300c===.*===.*===" }
  half8 var1 = (half8) (6,0,0,-4,-3,4,-123455,0);
  half8 var2 = (half8) (0,123445,8,-1,8,8,-7,8);
  int i = printf("half8_e_4300c===% 10v8hE===% 10v8hE===\n",var1,var2);
  return i;
}

int half8_e_4301c() {
  // { dg-printf -re "half8_e_4301c===.*===.*===" }
  half8 var1 = (half8) (123445,6,3,-1,1,-3,-7,8);
  half8 var2 = (half8) (5,123445,-3,4,5,1,8,0);
  int i = printf("half8_e_4301c===% 10.1v8hE===% 10.1v8hE===\n",var1,var2);
  return i;
}

int half8_e_4302c() {
  // { dg-printf -re "half8_e_4302c===.*===.*===" }
  half8 var1 = (half8) (-6,2,-1,3,-7,3,5,5);
  half8 var2 = (half8) (-2,6,-6,-7,5,-3,-8,-1);
  int i = printf("half8_e_4302c===% 10.2v8hE===% 10.2v8hE===\n",var1,var2);
  return i;
}

int half8_e_4303c() {
  // { dg-printf -re "half8_e_4303c===.*===.*===" }
  half8 var1 = (half8) (-2,1,-6,-1,8,-4,-8,3);
  half8 var2 = (half8) (2,-2,-2,123445,-8,2,-4,-8);
  int i = printf("half8_e_4303c===% 10.3v8hE===% 10.3v8hE===\n",var1,var2);
  return i;
}

int half8_e_4304c() {
  // { dg-printf -re "half8_e_4304c===.*===.*===" }
  half8 var1 = (half8) (-2,-2,-123455,123445,-123455,7,8,-3);
  half8 var2 = (half8) (8,8,-8,-4,-4,8,123445,-2);
  int i = printf("half8_e_4304c===% 10.10v8hE===% 10.10v8hE===\n",var1,var2);
  return i;
}

int half8_e_495c() {
  // { dg-printf -re "half8_e_495c===.*===.*===" }
  half8 var1 = (half8) (0,4,-6,6,-5,123445,1,-7);
  half8 var2 = (half8) (1,-4,4,7,-5,5,-1,-1);
  int i = printf("half8_e_495c===%v8he===%v8he===\n",var1,var2);
  return i;
}

int half8_e_496c() {
  // { dg-printf -re "half8_e_496c===.*===.*===" }
  half8 var1 = (half8) (7,123445,-6,5,-7,-8,2,123445);
  half8 var2 = (half8) (8,-123455,-1,-3,-4,-8,0,5);
  int i = printf("half8_e_496c===%.1v8he===%.1v8he===\n",var1,var2);
  return i;
}

int half8_e_497c() {
  // { dg-printf -re "half8_e_497c===.*===.*===" }
  half8 var1 = (half8) (-4,2,-2,123445,0,-1,-1,-4);
  half8 var2 = (half8) (0,0,-1,8,5,-4,-8,8);
  int i = printf("half8_e_497c===%.2v8he===%.2v8he===\n",var1,var2);
  return i;
}

int half8_e_498c() {
  // { dg-printf -re "half8_e_498c===.*===.*===" }
  half8 var1 = (half8) (6,5,2,0,-4,-7,1,-4);
  half8 var2 = (half8) (-4,-5,-4,-7,123445,0,-7,4);
  int i = printf("half8_e_498c===%.3v8he===%.3v8he===\n",var1,var2);
  return i;
}

int half8_e_499c() {
  // { dg-printf -re "half8_e_499c===.*===.*===" }
  half8 var1 = (half8) (2,123445,-6,-2,8,7,-4,3);
  half8 var2 = (half8) (3,-1,-2,3,1,-123455,-7,-4);
  int i = printf("half8_e_499c===%.10v8he===%.10v8he===\n",var1,var2);
  return i;
}

int half8_e_500c() {
  // { dg-printf -re "half8_e_500c===.*===.*===" }
  half8 var1 = (half8) (1,1,1,-6,123445,-4,3,2);
  half8 var2 = (half8) (4,-2,-3,-8,4,1,7,-7);
  int i = printf("half8_e_500c===%v8hE===%v8hE===\n",var1,var2);
  return i;
}

int half8_e_501c() {
  // { dg-printf -re "half8_e_501c===.*===.*===" }
  half8 var1 = (half8) (-8,-1,-1,-1,1,-6,-7,3);
  half8 var2 = (half8) (-3,2,-7,7,-7,6,8,5);
  int i = printf("half8_e_501c===%.1v8hE===%.1v8hE===\n",var1,var2);
  return i;
}

int half8_e_502c() {
  // { dg-printf -re "half8_e_502c===.*===.*===" }
  half8 var1 = (half8) (1,-8,0,-5,-6,3,123445,8);
  half8 var2 = (half8) (123445,7,5,5,8,6,-5,-2);
  int i = printf("half8_e_502c===%.2v8hE===%.2v8hE===\n",var1,var2);
  return i;
}

int half8_e_503c() {
  // { dg-printf -re "half8_e_503c===.*===.*===" }
  half8 var1 = (half8) (123445,-8,2,6,-2,-1,-3,123445);
  half8 var2 = (half8) (2,-1,-7,123445,-3,7,-2,4);
  int i = printf("half8_e_503c===%.3v8hE===%.3v8hE===\n",var1,var2);
  return i;
}

int half8_e_504c() {
  // { dg-printf -re "half8_e_504c===.*===.*===" }
  half8 var1 = (half8) (-5,123445,-7,1,7,0,-7,7);
  half8 var2 = (half8) (7,8,2,0,-5,-3,6,-5);
  int i = printf("half8_e_504c===%.10v8hE===%.10v8hE===\n",var1,var2);
  return i;
}

int half8_e_5055c() {
  // { dg-printf -re "half8_e_5055c===.*===.*===" }
  half8 var1 = (half8) (6,-3,-1,-1,3,-6,-1,1);
  half8 var2 = (half8) (123445,-2,-5,-1,6,-5,2,5);
  int i = printf("half8_e_5055c===%010v8he===%010v8he===\n",var1,var2);
  return i;
}

int half8_e_5056c() {
  // { dg-printf -re "half8_e_5056c===.*===.*===" }
  half8 var1 = (half8) (0,-3,-2,0,-1,7,-7,-3);
  half8 var2 = (half8) (3,-1,3,-6,-4,0,2,2);
  int i = printf("half8_e_5056c===%010.1v8he===%010.1v8he===\n",var1,var2);
  return i;
}

int half8_e_5057c() {
  // { dg-printf -re "half8_e_5057c===.*===.*===" }
  half8 var1 = (half8) (-5,123445,123445,-123455,-7,3,4,0);
  half8 var2 = (half8) (-1,123445,8,2,4,3,-6,5);
  int i = printf("half8_e_5057c===%010.2v8he===%010.2v8he===\n",var1,var2);
  return i;
}

int half8_e_5058c() {
  // { dg-printf -re "half8_e_5058c===.*===.*===" }
  half8 var1 = (half8) (6,-8,5,-8,123445,7,4,-6);
  half8 var2 = (half8) (5,-5,-7,-7,-7,6,-123455,-8);
  int i = printf("half8_e_5058c===%010.3v8he===%010.3v8he===\n",var1,var2);
  return i;
}

int half8_e_5059c() {
  // { dg-printf -re "half8_e_5059c===.*===.*===" }
  half8 var1 = (half8) (-1,4,-4,3,123445,6,5,1);
  half8 var2 = (half8) (-2,-5,3,7,3,-6,5,3);
  int i = printf("half8_e_5059c===%010.10v8he===%010.10v8he===\n",var1,var2);
  return i;
}

int half8_e_5060c() {
  // { dg-printf -re "half8_e_5060c===.*===.*===" }
  half8 var1 = (half8) (123445,123445,5,-123455,-8,123445,5,6);
  half8 var2 = (half8) (-4,0,8,123445,-2,-123455,0,5);
  int i = printf("half8_e_5060c===%010v8hE===%010v8hE===\n",var1,var2);
  return i;
}

int half8_e_5061c() {
  // { dg-printf -re "half8_e_5061c===.*===.*===" }
  half8 var1 = (half8) (-8,6,1,7,8,-2,5,1);
  half8 var2 = (half8) (3,-7,-1,-7,1,-1,7,-6);
  int i = printf("half8_e_5061c===%010.1v8hE===%010.1v8hE===\n",var1,var2);
  return i;
}

int half8_e_5062c() {
  // { dg-printf -re "half8_e_5062c===.*===.*===" }
  half8 var1 = (half8) (7,1,-5,-123455,-5,-2,-6,0);
  half8 var2 = (half8) (3,0,-2,-4,-8,-5,-5,-123455);
  int i = printf("half8_e_5062c===%010.2v8hE===%010.2v8hE===\n",var1,var2);
  return i;
}

int half8_e_5063c() {
  // { dg-printf -re "half8_e_5063c===.*===.*===" }
  half8 var1 = (half8) (-7,-5,-3,8,-7,4,2,-2);
  half8 var2 = (half8) (-2,7,-2,-1,-123455,2,0,7);
  int i = printf("half8_e_5063c===%010.3v8hE===%010.3v8hE===\n",var1,var2);
  return i;
}

int half8_e_5064c() {
  // { dg-printf -re "half8_e_5064c===.*===.*===" }
  half8 var1 = (half8) (8,6,5,-6,6,5,123445,7);
  half8 var2 = (half8) (-8,0,-5,1,-1,2,5,-123455);
  int i = printf("half8_e_5064c===%010.10v8hE===%010.10v8hE===\n",var1,var2);
  return i;
}

int half8_e_5815c() {
  // { dg-printf -re "half8_e_5815c===.*===.*===" }
  half8 var1 = (half8) (-1,2,1,-123455,1,-4,7,7);
  half8 var2 = (half8) (7,-8,4,-3,6,4,-8,7);
  int i = printf("half8_e_5815c===%- 10v8he===%- 10v8he===\n",var1,var2);
  return i;
}

int half8_e_5816c() {
  // { dg-printf -re "half8_e_5816c===.*===.*===" }
  half8 var1 = (half8) (-123455,2,-5,-7,4,-2,4,-3);
  half8 var2 = (half8) (1,-6,-8,-123455,1,0,-2,-4);
  int i = printf("half8_e_5816c===%- 10.1v8he===%- 10.1v8he===\n",var1,var2);
  return i;
}

int half8_e_5817c() {
  // { dg-printf -re "half8_e_5817c===.*===.*===" }
  half8 var1 = (half8) (4,-6,7,7,-2,7,-5,0);
  half8 var2 = (half8) (0,-3,3,-3,-6,-1,-8,-8);
  int i = printf("half8_e_5817c===%- 10.2v8he===%- 10.2v8he===\n",var1,var2);
  return i;
}

int half8_e_5818c() {
  // { dg-printf -re "half8_e_5818c===.*===.*===" }
  half8 var1 = (half8) (-3,-123455,-6,123445,2,-6,-8,-4);
  half8 var2 = (half8) (1,6,4,8,1,123445,3,1);
  int i = printf("half8_e_5818c===%- 10.3v8he===%- 10.3v8he===\n",var1,var2);
  return i;
}

int half8_e_5819c() {
  // { dg-printf -re "half8_e_5819c===.*===.*===" }
  half8 var1 = (half8) (5,-7,0,-8,-7,-6,123445,-3);
  half8 var2 = (half8) (2,-6,3,-2,3,-2,-4,2);
  int i = printf("half8_e_5819c===%- 10.10v8he===%- 10.10v8he===\n",var1,var2);
  return i;
}

int half8_e_5820c() {
  // { dg-printf -re "half8_e_5820c===.*===.*===" }
  half8 var1 = (half8) (4,-4,1,1,-5,-8,3,-1);
  half8 var2 = (half8) (3,5,-3,-6,5,-1,-3,8);
  int i = printf("half8_e_5820c===%- 10v8hE===%- 10v8hE===\n",var1,var2);
  return i;
}

int half8_e_5821c() {
  // { dg-printf -re "half8_e_5821c===.*===.*===" }
  half8 var1 = (half8) (-2,7,-123455,0,-3,-123455,-8,3);
  half8 var2 = (half8) (0,7,-1,-3,-6,6,-6,8);
  int i = printf("half8_e_5821c===%- 10.1v8hE===%- 10.1v8hE===\n",var1,var2);
  return i;
}

int half8_e_5822c() {
  // { dg-printf -re "half8_e_5822c===.*===.*===" }
  half8 var1 = (half8) (-2,3,8,-1,0,1,-3,-6);
  half8 var2 = (half8) (-7,1,1,3,0,-123455,3,123445);
  int i = printf("half8_e_5822c===%- 10.2v8hE===%- 10.2v8hE===\n",var1,var2);
  return i;
}

int half8_e_5823c() {
  // { dg-printf -re "half8_e_5823c===.*===.*===" }
  half8 var1 = (half8) (6,2,3,5,-1,7,1,7);
  half8 var2 = (half8) (6,-2,-7,-3,-6,123445,7,7);
  int i = printf("half8_e_5823c===%- 10.3v8hE===%- 10.3v8hE===\n",var1,var2);
  return i;
}

int half8_e_5824c() {
  // { dg-printf -re "half8_e_5824c===.*===.*===" }
  half8 var1 = (half8) (-5,6,2,7,-3,-123455,0,8);
  half8 var2 = (half8) (3,-1,0,3,6,3,0,6);
  int i = printf("half8_e_5824c===%- 10.10v8hE===%- 10.10v8hE===\n",var1,var2);
  return i;
}

int half8_e_6575c() {
  // { dg-printf -re "half8_e_6575c===.*===.*===" }
  half8 var1 = (half8) (-8,-3,7,5,0,-6,7,-7);
  half8 var2 = (half8) (-6,-123455,1,6,4,8,5,-3);
  int i = printf("half8_e_6575c===%+ 10v8he===%+ 10v8he===\n",var1,var2);
  return i;
}

int half8_e_6576c() {
  // { dg-printf -re "half8_e_6576c===.*===.*===" }
  half8 var1 = (half8) (5,4,3,2,2,-3,-2,123445);
  half8 var2 = (half8) (5,-3,6,6,0,7,-1,-5);
  int i = printf("half8_e_6576c===%+ 10.1v8he===%+ 10.1v8he===\n",var1,var2);
  return i;
}

int half8_e_6577c() {
  // { dg-printf -re "half8_e_6577c===.*===.*===" }
  half8 var1 = (half8) (-5,-123455,8,1,-6,4,5,-7);
  half8 var2 = (half8) (8,-4,-6,7,-5,1,-7,-6);
  int i = printf("half8_e_6577c===%+ 10.2v8he===%+ 10.2v8he===\n",var1,var2);
  return i;
}

int half8_e_6578c() {
  // { dg-printf -re "half8_e_6578c===.*===.*===" }
  half8 var1 = (half8) (5,-8,4,0,-123455,6,-8,-3);
  half8 var2 = (half8) (1,3,-5,5,7,123445,-3,-4);
  int i = printf("half8_e_6578c===%+ 10.3v8he===%+ 10.3v8he===\n",var1,var2);
  return i;
}

int half8_e_6579c() {
  // { dg-printf -re "half8_e_6579c===.*===.*===" }
  half8 var1 = (half8) (-123455,4,2,-4,-6,0,6,-1);
  half8 var2 = (half8) (7,4,-7,4,7,3,123445,8);
  int i = printf("half8_e_6579c===%+ 10.10v8he===%+ 10.10v8he===\n",var1,var2);
  return i;
}

int half8_e_6580c() {
  // { dg-printf -re "half8_e_6580c===.*===.*===" }
  half8 var1 = (half8) (7,8,6,2,-7,123445,8,-5);
  half8 var2 = (half8) (0,123445,0,-7,0,-6,-7,-4);
  int i = printf("half8_e_6580c===%+ 10v8hE===%+ 10v8hE===\n",var1,var2);
  return i;
}

int half8_e_6581c() {
  // { dg-printf -re "half8_e_6581c===.*===.*===" }
  half8 var1 = (half8) (5,-7,5,-123455,-8,3,-3,-6);
  half8 var2 = (half8) (7,8,-123455,-5,5,-7,-123455,5);
  int i = printf("half8_e_6581c===%+ 10.1v8hE===%+ 10.1v8hE===\n",var1,var2);
  return i;
}

int half8_e_6582c() {
  // { dg-printf -re "half8_e_6582c===.*===.*===" }
  half8 var1 = (half8) (-1,-7,-8,3,5,123445,4,-6);
  half8 var2 = (half8) (5,123445,0,-5,-6,1,-3,7);
  int i = printf("half8_e_6582c===%+ 10.2v8hE===%+ 10.2v8hE===\n",var1,var2);
  return i;
}

int half8_e_6583c() {
  // { dg-printf -re "half8_e_6583c===.*===.*===" }
  half8 var1 = (half8) (-7,-2,8,123445,3,5,-3,123445);
  half8 var2 = (half8) (-6,0,-8,-123455,-4,-1,7,5);
  int i = printf("half8_e_6583c===%+ 10.3v8hE===%+ 10.3v8hE===\n",var1,var2);
  return i;
}

int half8_e_6584c() {
  // { dg-printf -re "half8_e_6584c===.*===.*===" }
  half8 var1 = (half8) (-123455,-5,-5,-6,3,0,-123455,-4);
  half8 var2 = (half8) (4,3,-6,8,-8,1,-6,6);
  int i = printf("half8_e_6584c===%+ 10.10v8hE===%+ 10.10v8hE===\n",var1,var2);
  return i;
}

int half8_e_7335c() {
  // { dg-printf -re "half8_e_7335c===.*===.*===" }
  half8 var1 = (half8) (-123455,-1,-8,-123455,6,-7,-7,-6);
  half8 var2 = (half8) (5,-6,-8,8,-2,1,-6,5);
  int i = printf("half8_e_7335c===%+010v8he===%+010v8he===\n",var1,var2);
  return i;
}

int half8_e_7336c() {
  // { dg-printf -re "half8_e_7336c===.*===.*===" }
  half8 var1 = (half8) (-123455,-2,123445,-6,123445,-123455,-123455,7);
  half8 var2 = (half8) (6,-4,-3,0,123445,-8,2,-7);
  int i = printf("half8_e_7336c===%+010.1v8he===%+010.1v8he===\n",var1,var2);
  return i;
}

int half8_e_7337c() {
  // { dg-printf -re "half8_e_7337c===.*===.*===" }
  half8 var1 = (half8) (-1,-6,-7,-8,7,123445,-7,-6);
  half8 var2 = (half8) (4,6,4,-7,-1,-3,0,0);
  int i = printf("half8_e_7337c===%+010.2v8he===%+010.2v8he===\n",var1,var2);
  return i;
}

int half8_e_7338c() {
  // { dg-printf -re "half8_e_7338c===.*===.*===" }
  half8 var1 = (half8) (5,-7,-6,6,-3,3,6,123445);
  half8 var2 = (half8) (2,8,1,123445,-7,0,123445,-8);
  int i = printf("half8_e_7338c===%+010.3v8he===%+010.3v8he===\n",var1,var2);
  return i;
}

int half8_e_7339c() {
  // { dg-printf -re "half8_e_7339c===.*===.*===" }
  half8 var1 = (half8) (-2,-6,5,0,4,-4,-3,123445);
  half8 var2 = (half8) (1,5,8,-1,-4,1,1,2);
  int i = printf("half8_e_7339c===%+010.10v8he===%+010.10v8he===\n",var1,var2);
  return i;
}

int half8_e_7340c() {
  // { dg-printf -re "half8_e_7340c===.*===.*===" }
  half8 var1 = (half8) (8,-4,-8,-2,-5,-1,4,1);
  half8 var2 = (half8) (-3,4,-3,-7,2,-7,-2,4);
  int i = printf("half8_e_7340c===%+010v8hE===%+010v8hE===\n",var1,var2);
  return i;
}

int half8_e_7341c() {
  // { dg-printf -re "half8_e_7341c===.*===.*===" }
  half8 var1 = (half8) (3,-2,-3,-123455,7,-4,-3,-123455);
  half8 var2 = (half8) (2,7,8,4,-7,8,6,8);
  int i = printf("half8_e_7341c===%+010.1v8hE===%+010.1v8hE===\n",var1,var2);
  return i;
}

int half8_e_7342c() {
  // { dg-printf -re "half8_e_7342c===.*===.*===" }
  half8 var1 = (half8) (1,-5,8,2,-6,4,3,-6);
  half8 var2 = (half8) (-4,7,8,-7,5,-6,123445,-6);
  int i = printf("half8_e_7342c===%+010.2v8hE===%+010.2v8hE===\n",var1,var2);
  return i;
}

int half8_e_7343c() {
  // { dg-printf -re "half8_e_7343c===.*===.*===" }
  half8 var1 = (half8) (-123455,123445,0,3,123445,2,5,123445);
  half8 var2 = (half8) (3,2,-123455,-7,2,-7,-123455,-123455);
  int i = printf("half8_e_7343c===%+010.3v8hE===%+010.3v8hE===\n",var1,var2);
  return i;
}

int half8_e_7344c() {
  // { dg-printf -re "half8_e_7344c===.*===.*===" }
  half8 var1 = (half8) (-7,-3,-123455,123445,8,5,-2,5);
  half8 var2 = (half8) (-123455,-7,-8,-3,8,-7,-5,123445);
  int i = printf("half8_e_7344c===%+010.10v8hE===%+010.10v8hE===\n",var1,var2);
  return i;
}

int half8_f_1265c() {
  // { dg-printf -re "half8_f_1265c===.*===.*===" }
  half8 var1 = (half8) (-6,8,8,7,-123455,0,-1,2);
  half8 var2 = (half8) (-4,0,-2,1,2,5,-4,-3);
  int i = printf("half8_f_1265c===%-v8hf===%-v8hf===\n",var1,var2);
  return i;
}

int half8_f_1266c() {
  // { dg-printf -re "half8_f_1266c===.*===.*===" }
  half8 var1 = (half8) (5,-2,-7,2,1,-2,5,-8);
  half8 var2 = (half8) (-5,5,7,-1,-4,-5,-6,-123455);
  int i = printf("half8_f_1266c===%-.1v8hf===%-.1v8hf===\n",var1,var2);
  return i;
}

int half8_f_1267c() {
  // { dg-printf -re "half8_f_1267c===.*===.*===" }
  half8 var1 = (half8) (-3,4,-123455,4,3,7,-1,-6);
  half8 var2 = (half8) (123445,-4,4,3,-6,5,3,-2);
  int i = printf("half8_f_1267c===%-.2v8hf===%-.2v8hf===\n",var1,var2);
  return i;
}

int half8_f_1268c() {
  // { dg-printf -re "half8_f_1268c===.*===.*===" }
  half8 var1 = (half8) (2,-4,-4,-8,8,7,2,-4);
  half8 var2 = (half8) (1,-123455,-123455,4,-8,-2,7,6);
  int i = printf("half8_f_1268c===%-.3v8hf===%-.3v8hf===\n",var1,var2);
  return i;
}

int half8_f_1269c() {
  // { dg-printf -re "half8_f_1269c===.*===.*===" }
  half8 var1 = (half8) (-5,2,-4,-8,-1,7,-1,-1);
  half8 var2 = (half8) (8,4,2,6,-123455,-1,8,-2);
  int i = printf("half8_f_1269c===%-.10v8hf===%-.10v8hf===\n",var1,var2);
  return i;
}

int half8_f_1270c() {
  // { dg-printf -re "half8_f_1270c===.*===.*===" }
  half8 var1 = (half8) (1,-123455,0,-3,6,7,7,8);
  half8 var2 = (half8) (8,5,1,1,123445,3,-5,-5);
  int i = printf("half8_f_1270c===%-v8hF===%-v8hF===\n",var1,var2);
  return i;
}

int half8_f_1271c() {
  // { dg-printf -re "half8_f_1271c===.*===.*===" }
  half8 var1 = (half8) (123445,-123455,8,3,-4,-3,8,-8);
  half8 var2 = (half8) (-6,123445,2,8,-1,-3,-5,-2);
  int i = printf("half8_f_1271c===%-.1v8hF===%-.1v8hF===\n",var1,var2);
  return i;
}

int half8_f_1272c() {
  // { dg-printf -re "half8_f_1272c===.*===.*===" }
  half8 var1 = (half8) (-1,8,-2,3,-3,-1,7,7);
  half8 var2 = (half8) (0,-7,-3,-5,-2,-1,123445,-8);
  int i = printf("half8_f_1272c===%-.2v8hF===%-.2v8hF===\n",var1,var2);
  return i;
}

int half8_f_1273c() {
  // { dg-printf -re "half8_f_1273c===.*===.*===" }
  half8 var1 = (half8) (-3,1,123445,-123455,-2,-8,0,5);
  half8 var2 = (half8) (5,123445,-8,-8,-6,-1,7,-1);
  int i = printf("half8_f_1273c===%-.3v8hF===%-.3v8hF===\n",var1,var2);
  return i;
}

int half8_f_1274c() {
  // { dg-printf -re "half8_f_1274c===.*===.*===" }
  half8 var1 = (half8) (-7,3,123445,6,-123455,5,0,4);
  half8 var2 = (half8) (-1,1,-4,-1,0,0,123445,5);
  int i = printf("half8_f_1274c===%-.10v8hF===%-.10v8hF===\n",var1,var2);
  return i;
}

int half8_f_2025c() {
  // { dg-printf -re "half8_f_2025c===.*===.*===" }
  half8 var1 = (half8) (7,-2,1,-123455,3,-123455,5,8);
  half8 var2 = (half8) (-6,3,1,3,8,-7,-3,-7);
  int i = printf("half8_f_2025c===%+v8hf===%+v8hf===\n",var1,var2);
  return i;
}

int half8_f_2026c() {
  // { dg-printf -re "half8_f_2026c===.*===.*===" }
  half8 var1 = (half8) (-123455,5,8,2,6,-5,7,4);
  half8 var2 = (half8) (1,5,-5,-3,5,-1,-4,8);
  int i = printf("half8_f_2026c===%+.1v8hf===%+.1v8hf===\n",var1,var2);
  return i;
}

int half8_f_2027c() {
  // { dg-printf -re "half8_f_2027c===.*===.*===" }
  half8 var1 = (half8) (-123455,-7,-6,8,123445,-4,-1,-5);
  half8 var2 = (half8) (5,8,3,0,-1,-8,-123455,5);
  int i = printf("half8_f_2027c===%+.2v8hf===%+.2v8hf===\n",var1,var2);
  return i;
}

int half8_f_2028c() {
  // { dg-printf -re "half8_f_2028c===.*===.*===" }
  half8 var1 = (half8) (5,8,-5,5,4,-7,3,5);
  half8 var2 = (half8) (2,5,-3,7,5,2,-3,-5);
  int i = printf("half8_f_2028c===%+.3v8hf===%+.3v8hf===\n",var1,var2);
  return i;
}

int half8_f_2029c() {
  // { dg-printf -re "half8_f_2029c===.*===.*===" }
  half8 var1 = (half8) (-1,-2,-1,4,-4,123445,4,-6);
  half8 var2 = (half8) (-6,-1,0,-4,-7,-123455,1,-5);
  int i = printf("half8_f_2029c===%+.10v8hf===%+.10v8hf===\n",var1,var2);
  return i;
}

int half8_f_2030c() {
  // { dg-printf -re "half8_f_2030c===.*===.*===" }
  half8 var1 = (half8) (123445,4,-1,5,7,1,-1,0);
  half8 var2 = (half8) (-5,123445,-6,5,123445,-1,-5,-123455);
  int i = printf("half8_f_2030c===%+v8hF===%+v8hF===\n",var1,var2);
  return i;
}

int half8_f_2031c() {
  // { dg-printf -re "half8_f_2031c===.*===.*===" }
  half8 var1 = (half8) (2,1,5,-2,8,123445,-123455,-3);
  half8 var2 = (half8) (-6,-4,4,2,-7,123445,5,-4);
  int i = printf("half8_f_2031c===%+.1v8hF===%+.1v8hF===\n",var1,var2);
  return i;
}

int half8_f_2032c() {
  // { dg-printf -re "half8_f_2032c===.*===.*===" }
  half8 var1 = (half8) (0,3,1,-6,3,-123455,-7,-2);
  half8 var2 = (half8) (-8,123445,2,7,123445,-8,-6,8);
  int i = printf("half8_f_2032c===%+.2v8hF===%+.2v8hF===\n",var1,var2);
  return i;
}

int half8_f_2033c() {
  // { dg-printf -re "half8_f_2033c===.*===.*===" }
  half8 var1 = (half8) (5,8,1,0,-3,-8,4,1);
  half8 var2 = (half8) (-4,-123455,4,-8,123445,-2,5,-3);
  int i = printf("half8_f_2033c===%+.3v8hF===%+.3v8hF===\n",var1,var2);
  return i;
}

int half8_f_2034c() {
  // { dg-printf -re "half8_f_2034c===.*===.*===" }
  half8 var1 = (half8) (123445,-2,123445,-3,0,-4,1,0);
  half8 var2 = (half8) (-7,-7,8,-7,0,0,-7,-7);
  int i = printf("half8_f_2034c===%+.10v8hF===%+.10v8hF===\n",var1,var2);
  return i;
}

int half8_f_2785c() {
  // { dg-printf -re "half8_f_2785c===.*===.*===" }
  half8 var1 = (half8) (-5,4,-5,-1,2,-7,1,8);
  half8 var2 = (half8) (-1,-8,1,1,4,2,5,-3);
  int i = printf("half8_f_2785c===%#v8hf===%#v8hf===\n",var1,var2);
  return i;
}

int half8_f_2786c() {
  // { dg-printf -re "half8_f_2786c===.*===.*===" }
  half8 var1 = (half8) (-5,1,-2,0,-8,0,6,-5);
  half8 var2 = (half8) (-8,-6,2,1,4,-5,4,-3);
  int i = printf("half8_f_2786c===%#.1v8hf===%#.1v8hf===\n",var1,var2);
  return i;
}

int half8_f_2787c() {
  // { dg-printf -re "half8_f_2787c===.*===.*===" }
  half8 var1 = (half8) (0,3,-8,5,-1,6,-4,-6);
  half8 var2 = (half8) (3,5,3,-8,-1,0,0,5);
  int i = printf("half8_f_2787c===%#.2v8hf===%#.2v8hf===\n",var1,var2);
  return i;
}

int half8_f_2788c() {
  // { dg-printf -re "half8_f_2788c===.*===.*===" }
  half8 var1 = (half8) (2,-8,-4,4,-5,6,4,-2);
  half8 var2 = (half8) (-8,1,-5,-1,-1,3,-1,-123455);
  int i = printf("half8_f_2788c===%#.3v8hf===%#.3v8hf===\n",var1,var2);
  return i;
}

int half8_f_2789c() {
  // { dg-printf -re "half8_f_2789c===.*===.*===" }
  half8 var1 = (half8) (-4,-5,-5,-4,-2,-6,-2,6);
  half8 var2 = (half8) (-8,8,-8,-6,-6,-7,6,4);
  int i = printf("half8_f_2789c===%#.10v8hf===%#.10v8hf===\n",var1,var2);
  return i;
}

int half8_f_2790c() {
  // { dg-printf -re "half8_f_2790c===.*===.*===" }
  half8 var1 = (half8) (8,8,4,1,-8,-1,-3,0);
  half8 var2 = (half8) (3,8,123445,1,2,0,-6,-4);
  int i = printf("half8_f_2790c===%#v8hF===%#v8hF===\n",var1,var2);
  return i;
}

int half8_f_2791c() {
  // { dg-printf -re "half8_f_2791c===.*===.*===" }
  half8 var1 = (half8) (-2,-2,-2,-8,5,7,2,2);
  half8 var2 = (half8) (7,4,-8,-5,-5,7,-3,7);
  int i = printf("half8_f_2791c===%#.1v8hF===%#.1v8hF===\n",var1,var2);
  return i;
}

int half8_f_2792c() {
  // { dg-printf -re "half8_f_2792c===.*===.*===" }
  half8 var1 = (half8) (2,8,123445,-123455,-2,-8,-7,2);
  half8 var2 = (half8) (2,123445,2,7,-4,4,8,3);
  int i = printf("half8_f_2792c===%#.2v8hF===%#.2v8hF===\n",var1,var2);
  return i;
}

int half8_f_2793c() {
  // { dg-printf -re "half8_f_2793c===.*===.*===" }
  half8 var1 = (half8) (4,-123455,-6,-5,-8,-123455,-123455,6);
  half8 var2 = (half8) (-5,-123455,-123455,5,0,-7,-8,-3);
  int i = printf("half8_f_2793c===%#.3v8hF===%#.3v8hF===\n",var1,var2);
  return i;
}

int half8_f_2794c() {
  // { dg-printf -re "half8_f_2794c===.*===.*===" }
  half8 var1 = (half8) (-5,-7,-123455,3,-123455,-4,6,-7);
  half8 var2 = (half8) (-5,5,-3,-3,-8,-1,1,1);
  int i = printf("half8_f_2794c===%#.10v8hF===%#.10v8hF===\n",var1,var2);
  return i;
}

int half8_f_3545c() {
  // { dg-printf -re "half8_f_3545c===.*===.*===" }
  half8 var1 = (half8) (1,-4,2,1,-8,-7,8,4);
  half8 var2 = (half8) (1,3,-8,0,0,-5,-4,4);
  int i = printf("half8_f_3545c===%-+v8hf===%-+v8hf===\n",var1,var2);
  return i;
}

int half8_f_3546c() {
  // { dg-printf -re "half8_f_3546c===.*===.*===" }
  half8 var1 = (half8) (123445,3,1,6,-3,-123455,2,6);
  half8 var2 = (half8) (-5,5,-6,6,8,2,-2,2);
  int i = printf("half8_f_3546c===%-+.1v8hf===%-+.1v8hf===\n",var1,var2);
  return i;
}

int half8_f_3547c() {
  // { dg-printf -re "half8_f_3547c===.*===.*===" }
  half8 var1 = (half8) (-3,0,123445,-123455,-8,-2,1,-1);
  half8 var2 = (half8) (-4,-3,8,1,123445,-2,3,7);
  int i = printf("half8_f_3547c===%-+.2v8hf===%-+.2v8hf===\n",var1,var2);
  return i;
}

int half8_f_3548c() {
  // { dg-printf -re "half8_f_3548c===.*===.*===" }
  half8 var1 = (half8) (8,7,-5,-8,8,-3,4,1);
  half8 var2 = (half8) (-2,-4,-3,2,6,-8,-6,2);
  int i = printf("half8_f_3548c===%-+.3v8hf===%-+.3v8hf===\n",var1,var2);
  return i;
}

int half8_f_3549c() {
  // { dg-printf -re "half8_f_3549c===.*===.*===" }
  half8 var1 = (half8) (6,7,3,6,-8,7,0,4);
  half8 var2 = (half8) (-4,-7,8,123445,6,8,3,-5);
  int i = printf("half8_f_3549c===%-+.10v8hf===%-+.10v8hf===\n",var1,var2);
  return i;
}

int half8_f_3550c() {
  // { dg-printf -re "half8_f_3550c===.*===.*===" }
  half8 var1 = (half8) (-123455,-7,-8,-6,0,8,3,5);
  half8 var2 = (half8) (-4,-1,-4,-8,0,4,-3,7);
  int i = printf("half8_f_3550c===%-+v8hF===%-+v8hF===\n",var1,var2);
  return i;
}

int half8_f_3551c() {
  // { dg-printf -re "half8_f_3551c===.*===.*===" }
  half8 var1 = (half8) (3,-5,123445,-123455,-2,3,2,-1);
  half8 var2 = (half8) (-123455,123445,-6,1,-7,5,4,-7);
  int i = printf("half8_f_3551c===%-+.1v8hF===%-+.1v8hF===\n",var1,var2);
  return i;
}

int half8_f_3552c() {
  // { dg-printf -re "half8_f_3552c===.*===.*===" }
  half8 var1 = (half8) (-123455,-5,-2,4,2,6,6,-4);
  half8 var2 = (half8) (2,-4,2,3,-4,123445,123445,123445);
  int i = printf("half8_f_3552c===%-+.2v8hF===%-+.2v8hF===\n",var1,var2);
  return i;
}

int half8_f_3553c() {
  // { dg-printf -re "half8_f_3553c===.*===.*===" }
  half8 var1 = (half8) (4,-6,123445,-123455,7,-2,-8,-6);
  half8 var2 = (half8) (-6,-3,-123455,-7,-123455,1,-3,-2);
  int i = printf("half8_f_3553c===%-+.3v8hF===%-+.3v8hF===\n",var1,var2);
  return i;
}

int half8_f_3554c() {
  // { dg-printf -re "half8_f_3554c===.*===.*===" }
  half8 var1 = (half8) (2,3,4,-7,2,7,-8,-123455);
  half8 var2 = (half8) (-8,8,-7,-3,-2,7,5,-4);
  int i = printf("half8_f_3554c===%-+.10v8hF===%-+.10v8hF===\n",var1,var2);
  return i;
}

int half8_f_4305c() {
  // { dg-printf -re "half8_f_4305c===.*===.*===" }
  half8 var1 = (half8) (1,6,-5,123445,2,3,-6,-7);
  half8 var2 = (half8) (-1,-7,8,-123455,1,-123455,6,-4);
  int i = printf("half8_f_4305c===% 10v8hf===% 10v8hf===\n",var1,var2);
  return i;
}

int half8_f_4306c() {
  // { dg-printf -re "half8_f_4306c===.*===.*===" }
  half8 var1 = (half8) (6,-3,5,123445,2,3,-1,3);
  half8 var2 = (half8) (5,-123455,8,123445,-7,2,2,-8);
  int i = printf("half8_f_4306c===% 10.1v8hf===% 10.1v8hf===\n",var1,var2);
  return i;
}

int half8_f_4307c() {
  // { dg-printf -re "half8_f_4307c===.*===.*===" }
  half8 var1 = (half8) (-6,0,1,4,123445,5,7,8);
  half8 var2 = (half8) (6,3,5,-4,7,5,7,-2);
  int i = printf("half8_f_4307c===% 10.2v8hf===% 10.2v8hf===\n",var1,var2);
  return i;
}

int half8_f_4308c() {
  // { dg-printf -re "half8_f_4308c===.*===.*===" }
  half8 var1 = (half8) (-7,-2,-123455,-2,-8,-1,123445,-3);
  half8 var2 = (half8) (3,-7,6,2,0,8,3,-1);
  int i = printf("half8_f_4308c===% 10.3v8hf===% 10.3v8hf===\n",var1,var2);
  return i;
}

int half8_f_4309c() {
  // { dg-printf -re "half8_f_4309c===.*===.*===" }
  half8 var1 = (half8) (2,2,4,1,-8,0,4,5);
  half8 var2 = (half8) (-8,-8,-5,5,-8,-5,123445,-4);
  int i = printf("half8_f_4309c===% 10.10v8hf===% 10.10v8hf===\n",var1,var2);
  return i;
}

int half8_f_4310c() {
  // { dg-printf -re "half8_f_4310c===.*===.*===" }
  half8 var1 = (half8) (-123455,-7,-4,-7,-6,123445,-6,-123455);
  half8 var2 = (half8) (3,-5,6,7,-1,5,4,4);
  int i = printf("half8_f_4310c===% 10v8hF===% 10v8hF===\n",var1,var2);
  return i;
}

int half8_f_4311c() {
  // { dg-printf -re "half8_f_4311c===.*===.*===" }
  half8 var1 = (half8) (123445,123445,-1,4,-8,4,5,-4);
  half8 var2 = (half8) (-1,5,-123455,-7,-123455,-123455,-8,7);
  int i = printf("half8_f_4311c===% 10.1v8hF===% 10.1v8hF===\n",var1,var2);
  return i;
}

int half8_f_4312c() {
  // { dg-printf -re "half8_f_4312c===.*===.*===" }
  half8 var1 = (half8) (123445,7,-7,-1,5,-3,-1,-123455);
  half8 var2 = (half8) (-5,6,-2,1,-8,-8,1,2);
  int i = printf("half8_f_4312c===% 10.2v8hF===% 10.2v8hF===\n",var1,var2);
  return i;
}

int half8_f_4313c() {
  // { dg-printf -re "half8_f_4313c===.*===.*===" }
  half8 var1 = (half8) (5,0,3,-5,3,0,-1,-3);
  half8 var2 = (half8) (7,2,1,8,0,-123455,-7,2);
  int i = printf("half8_f_4313c===% 10.3v8hF===% 10.3v8hF===\n",var1,var2);
  return i;
}

int half8_f_4314c() {
  // { dg-printf -re "half8_f_4314c===.*===.*===" }
  half8 var1 = (half8) (-6,-1,-8,7,-8,8,2,6);
  half8 var2 = (half8) (8,-123455,-3,-6,3,-1,7,-5);
  int i = printf("half8_f_4314c===% 10.10v8hF===% 10.10v8hF===\n",var1,var2);
  return i;
}

int half8_f_505c() {
  // { dg-printf -re "half8_f_505c===.*===.*===" }
  half8 var1 = (half8) (-5,-123455,3,-1,-123455,123445,-1,-123455);
  half8 var2 = (half8) (123445,7,0,-123455,6,-7,-4,123445);
  int i = printf("half8_f_505c===%v8hf===%v8hf===\n",var1,var2);
  return i;
}

int half8_f_506c() {
  // { dg-printf -re "half8_f_506c===.*===.*===" }
  half8 var1 = (half8) (-6,3,-3,0,-8,0,1,-123455);
  half8 var2 = (half8) (-7,2,2,-4,2,-4,4,0);
  int i = printf("half8_f_506c===%.1v8hf===%.1v8hf===\n",var1,var2);
  return i;
}

int half8_f_5065c() {
  // { dg-printf -re "half8_f_5065c===.*===.*===" }
  half8 var1 = (half8) (2,7,-2,3,1,-4,5,-4);
  half8 var2 = (half8) (3,4,-8,123445,-3,-123455,5,-3);
  int i = printf("half8_f_5065c===%010v8hf===%010v8hf===\n",var1,var2);
  return i;
}

int half8_f_5066c() {
  // { dg-printf -re "half8_f_5066c===.*===.*===" }
  half8 var1 = (half8) (7,6,-1,5,1,-6,-5,-8);
  half8 var2 = (half8) (-8,1,-3,0,-1,-123455,1,-123455);
  int i = printf("half8_f_5066c===%010.1v8hf===%010.1v8hf===\n",var1,var2);
  return i;
}

int half8_f_5067c() {
  // { dg-printf -re "half8_f_5067c===.*===.*===" }
  half8 var1 = (half8) (8,7,-4,5,-3,-5,123445,1);
  half8 var2 = (half8) (-8,-3,-6,6,-4,8,0,2);
  int i = printf("half8_f_5067c===%010.2v8hf===%010.2v8hf===\n",var1,var2);
  return i;
}

int half8_f_5068c() {
  // { dg-printf -re "half8_f_5068c===.*===.*===" }
  half8 var1 = (half8) (-6,-3,3,6,-1,4,-8,1);
  half8 var2 = (half8) (-3,-123455,5,-8,123445,3,-1,6);
  int i = printf("half8_f_5068c===%010.3v8hf===%010.3v8hf===\n",var1,var2);
  return i;
}

int half8_f_5069c() {
  // { dg-printf -re "half8_f_5069c===.*===.*===" }
  half8 var1 = (half8) (5,-1,-2,-123455,5,-5,-2,8);
  half8 var2 = (half8) (0,8,-3,0,4,6,-4,3);
  int i = printf("half8_f_5069c===%010.10v8hf===%010.10v8hf===\n",var1,var2);
  return i;
}

int half8_f_507c() {
  // { dg-printf -re "half8_f_507c===.*===.*===" }
  half8 var1 = (half8) (-3,-1,0,-4,123445,2,123445,-3);
  half8 var2 = (half8) (-1,-2,-4,3,-123455,-7,8,-6);
  int i = printf("half8_f_507c===%.2v8hf===%.2v8hf===\n",var1,var2);
  return i;
}

int half8_f_5070c() {
  // { dg-printf -re "half8_f_5070c===.*===.*===" }
  half8 var1 = (half8) (-3,8,123445,7,3,-6,-8,-8);
  half8 var2 = (half8) (1,-3,-5,6,-3,-123455,4,5);
  int i = printf("half8_f_5070c===%010v8hF===%010v8hF===\n",var1,var2);
  return i;
}

int half8_f_5071c() {
  // { dg-printf -re "half8_f_5071c===.*===.*===" }
  half8 var1 = (half8) (7,2,-1,-6,-7,8,-1,0);
  half8 var2 = (half8) (5,-5,7,123445,5,1,0,-1);
  int i = printf("half8_f_5071c===%010.1v8hF===%010.1v8hF===\n",var1,var2);
  return i;
}

int half8_f_5072c() {
  // { dg-printf -re "half8_f_5072c===.*===.*===" }
  half8 var1 = (half8) (-1,5,-6,6,-4,-2,-5,1);
  half8 var2 = (half8) (-3,6,2,-1,-7,-123455,1,7);
  int i = printf("half8_f_5072c===%010.2v8hF===%010.2v8hF===\n",var1,var2);
  return i;
}

int half8_f_5073c() {
  // { dg-printf -re "half8_f_5073c===.*===.*===" }
  half8 var1 = (half8) (0,2,-6,-5,-123455,-2,6,1);
  half8 var2 = (half8) (0,6,-4,4,3,8,-3,-5);
  int i = printf("half8_f_5073c===%010.3v8hF===%010.3v8hF===\n",var1,var2);
  return i;
}

int half8_f_5074c() {
  // { dg-printf -re "half8_f_5074c===.*===.*===" }
  half8 var1 = (half8) (4,5,6,6,1,-123455,6,4);
  half8 var2 = (half8) (8,-1,7,-8,-4,1,6,8);
  int i = printf("half8_f_5074c===%010.10v8hF===%010.10v8hF===\n",var1,var2);
  return i;
}

int half8_f_508c() {
  // { dg-printf -re "half8_f_508c===.*===.*===" }
  half8 var1 = (half8) (-2,1,-6,-8,0,4,123445,8);
  half8 var2 = (half8) (-6,-4,7,-3,1,2,3,4);
  int i = printf("half8_f_508c===%.3v8hf===%.3v8hf===\n",var1,var2);
  return i;
}

int half8_f_509c() {
  // { dg-printf -re "half8_f_509c===.*===.*===" }
  half8 var1 = (half8) (-8,6,123445,6,8,1,-3,3);
  half8 var2 = (half8) (-5,2,-8,8,-7,-3,-3,5);
  int i = printf("half8_f_509c===%.10v8hf===%.10v8hf===\n",var1,var2);
  return i;
}

int half8_f_510c() {
  // { dg-printf -re "half8_f_510c===.*===.*===" }
  half8 var1 = (half8) (-6,1,6,-6,2,123445,-3,5);
  half8 var2 = (half8) (-8,-123455,-5,-3,-2,7,4,-8);
  int i = printf("half8_f_510c===%v8hF===%v8hF===\n",var1,var2);
  return i;
}

int half8_f_511c() {
  // { dg-printf -re "half8_f_511c===.*===.*===" }
  half8 var1 = (half8) (-7,0,3,123445,-4,4,1,-4);
  half8 var2 = (half8) (8,2,-4,3,1,0,-5,-6);
  int i = printf("half8_f_511c===%.1v8hF===%.1v8hF===\n",var1,var2);
  return i;
}

int half8_f_512c() {
  // { dg-printf -re "half8_f_512c===.*===.*===" }
  half8 var1 = (half8) (-2,4,-3,-3,1,8,-5,-4);
  half8 var2 = (half8) (-6,-4,123445,-5,-3,4,0,6);
  int i = printf("half8_f_512c===%.2v8hF===%.2v8hF===\n",var1,var2);
  return i;
}

int half8_f_513c() {
  // { dg-printf -re "half8_f_513c===.*===.*===" }
  half8 var1 = (half8) (-3,4,8,8,-6,6,-4,8);
  half8 var2 = (half8) (0,6,-5,5,-4,1,-3,8);
  int i = printf("half8_f_513c===%.3v8hF===%.3v8hF===\n",var1,var2);
  return i;
}

int half8_f_514c() {
  // { dg-printf -re "half8_f_514c===.*===.*===" }
  half8 var1 = (half8) (-6,-123455,5,4,-5,4,-5,-123455);
  half8 var2 = (half8) (3,3,4,-4,4,-8,-123455,-1);
  int i = printf("half8_f_514c===%.10v8hF===%.10v8hF===\n",var1,var2);
  return i;
}

int half8_f_5825c() {
  // { dg-printf -re "half8_f_5825c===.*===.*===" }
  half8 var1 = (half8) (-5,3,-7,4,123445,-5,8,-123455);
  half8 var2 = (half8) (6,6,-1,7,2,1,5,5);
  int i = printf("half8_f_5825c===%- 10v8hf===%- 10v8hf===\n",var1,var2);
  return i;
}

int half8_f_5826c() {
  // { dg-printf -re "half8_f_5826c===.*===.*===" }
  half8 var1 = (half8) (-2,-3,1,-123455,7,1,4,1);
  half8 var2 = (half8) (-7,6,-7,-6,2,-8,-4,5);
  int i = printf("half8_f_5826c===%- 10.1v8hf===%- 10.1v8hf===\n",var1,var2);
  return i;
}

int half8_f_5827c() {
  // { dg-printf -re "half8_f_5827c===.*===.*===" }
  half8 var1 = (half8) (-1,-6,123445,-1,5,2,-2,-5);
  half8 var2 = (half8) (123445,2,3,-123455,-4,-3,-6,1);
  int i = printf("half8_f_5827c===%- 10.2v8hf===%- 10.2v8hf===\n",var1,var2);
  return i;
}

int half8_f_5828c() {
  // { dg-printf -re "half8_f_5828c===.*===.*===" }
  half8 var1 = (half8) (4,-3,3,-7,-2,2,2,1);
  half8 var2 = (half8) (6,-7,8,5,7,2,-1,4);
  int i = printf("half8_f_5828c===%- 10.3v8hf===%- 10.3v8hf===\n",var1,var2);
  return i;
}

int half8_f_5829c() {
  // { dg-printf -re "half8_f_5829c===.*===.*===" }
  half8 var1 = (half8) (-8,-2,1,8,-5,6,0,-5);
  half8 var2 = (half8) (2,0,123445,-3,4,-1,2,3);
  int i = printf("half8_f_5829c===%- 10.10v8hf===%- 10.10v8hf===\n",var1,var2);
  return i;
}

int half8_f_5830c() {
  // { dg-printf -re "half8_f_5830c===.*===.*===" }
  half8 var1 = (half8) (123445,-6,-7,3,4,5,-7,-1);
  half8 var2 = (half8) (2,3,-2,4,-6,5,-2,-6);
  int i = printf("half8_f_5830c===%- 10v8hF===%- 10v8hF===\n",var1,var2);
  return i;
}

int half8_f_5831c() {
  // { dg-printf -re "half8_f_5831c===.*===.*===" }
  half8 var1 = (half8) (-4,3,-6,7,0,8,1,-6);
  half8 var2 = (half8) (7,-8,7,6,5,-8,7,-3);
  int i = printf("half8_f_5831c===%- 10.1v8hF===%- 10.1v8hF===\n",var1,var2);
  return i;
}

int half8_f_5832c() {
  // { dg-printf -re "half8_f_5832c===.*===.*===" }
  half8 var1 = (half8) (0,-5,-1,-8,-7,0,123445,4);
  half8 var2 = (half8) (-1,8,8,1,-5,5,123445,6);
  int i = printf("half8_f_5832c===%- 10.2v8hF===%- 10.2v8hF===\n",var1,var2);
  return i;
}

int half8_f_5833c() {
  // { dg-printf -re "half8_f_5833c===.*===.*===" }
  half8 var1 = (half8) (-6,-5,-2,2,-3,8,-3,4);
  half8 var2 = (half8) (-7,-5,1,2,5,7,1,-4);
  int i = printf("half8_f_5833c===%- 10.3v8hF===%- 10.3v8hF===\n",var1,var2);
  return i;
}

int half8_f_5834c() {
  // { dg-printf -re "half8_f_5834c===.*===.*===" }
  half8 var1 = (half8) (-8,-7,3,123445,3,5,-8,2);
  half8 var2 = (half8) (7,5,4,-5,0,7,-6,4);
  int i = printf("half8_f_5834c===%- 10.10v8hF===%- 10.10v8hF===\n",var1,var2);
  return i;
}

int half8_f_6585c() {
  // { dg-printf -re "half8_f_6585c===.*===.*===" }
  half8 var1 = (half8) (-6,-1,0,-7,-7,-1,5,-3);
  half8 var2 = (half8) (-1,-8,-8,8,123445,-7,1,2);
  int i = printf("half8_f_6585c===%+ 10v8hf===%+ 10v8hf===\n",var1,var2);
  return i;
}

int half8_f_6586c() {
  // { dg-printf -re "half8_f_6586c===.*===.*===" }
  half8 var1 = (half8) (0,-123455,8,1,8,-7,-5,-2);
  half8 var2 = (half8) (-123455,7,5,5,3,0,3,1);
  int i = printf("half8_f_6586c===%+ 10.1v8hf===%+ 10.1v8hf===\n",var1,var2);
  return i;
}

int half8_f_6587c() {
  // { dg-printf -re "half8_f_6587c===.*===.*===" }
  half8 var1 = (half8) (-3,-6,6,123445,-5,-1,-3,-8);
  half8 var2 = (half8) (-4,1,6,1,123445,-123455,2,123445);
  int i = printf("half8_f_6587c===%+ 10.2v8hf===%+ 10.2v8hf===\n",var1,var2);
  return i;
}

int half8_f_6588c() {
  // { dg-printf -re "half8_f_6588c===.*===.*===" }
  half8 var1 = (half8) (1,5,-123455,8,4,-5,4,5);
  half8 var2 = (half8) (-5,1,4,6,-4,2,-7,-6);
  int i = printf("half8_f_6588c===%+ 10.3v8hf===%+ 10.3v8hf===\n",var1,var2);
  return i;
}

int half8_f_6589c() {
  // { dg-printf -re "half8_f_6589c===.*===.*===" }
  half8 var1 = (half8) (-7,-5,-7,-8,3,2,-5,2);
  half8 var2 = (half8) (-5,-8,2,1,0,-123455,-123455,-2);
  int i = printf("half8_f_6589c===%+ 10.10v8hf===%+ 10.10v8hf===\n",var1,var2);
  return i;
}

int half8_f_6590c() {
  // { dg-printf -re "half8_f_6590c===.*===.*===" }
  half8 var1 = (half8) (4,-4,-1,1,3,6,-123455,5);
  half8 var2 = (half8) (2,-2,123445,-2,7,1,6,-4);
  int i = printf("half8_f_6590c===%+ 10v8hF===%+ 10v8hF===\n",var1,var2);
  return i;
}

int half8_f_6591c() {
  // { dg-printf -re "half8_f_6591c===.*===.*===" }
  half8 var1 = (half8) (-3,5,6,-3,-1,-6,-3,-3);
  half8 var2 = (half8) (-8,-3,6,5,7,-5,6,-3);
  int i = printf("half8_f_6591c===%+ 10.1v8hF===%+ 10.1v8hF===\n",var1,var2);
  return i;
}

int half8_f_6592c() {
  // { dg-printf -re "half8_f_6592c===.*===.*===" }
  half8 var1 = (half8) (-1,8,5,-123455,-1,-8,-3,-3);
  half8 var2 = (half8) (8,-123455,-8,4,0,2,4,-2);
  int i = printf("half8_f_6592c===%+ 10.2v8hF===%+ 10.2v8hF===\n",var1,var2);
  return i;
}

int half8_f_6593c() {
  // { dg-printf -re "half8_f_6593c===.*===.*===" }
  half8 var1 = (half8) (4,123445,2,3,-2,2,-5,-123455);
  half8 var2 = (half8) (2,4,-8,-4,6,-5,-2,3);
  int i = printf("half8_f_6593c===%+ 10.3v8hF===%+ 10.3v8hF===\n",var1,var2);
  return i;
}

int half8_f_6594c() {
  // { dg-printf -re "half8_f_6594c===.*===.*===" }
  half8 var1 = (half8) (-123455,0,-2,1,2,2,-3,1);
  half8 var2 = (half8) (-7,-2,6,6,1,-7,3,6);
  int i = printf("half8_f_6594c===%+ 10.10v8hF===%+ 10.10v8hF===\n",var1,var2);
  return i;
}

int half8_f_7345c() {
  // { dg-printf -re "half8_f_7345c===.*===.*===" }
  half8 var1 = (half8) (4,-1,-5,-123455,6,-7,-1,1);
  half8 var2 = (half8) (-3,2,7,2,0,1,6,-1);
  int i = printf("half8_f_7345c===%+010v8hf===%+010v8hf===\n",var1,var2);
  return i;
}

int half8_f_7346c() {
  // { dg-printf -re "half8_f_7346c===.*===.*===" }
  half8 var1 = (half8) (4,3,123445,7,123445,-2,-123455,6);
  half8 var2 = (half8) (-8,3,7,-8,-3,-2,-4,6);
  int i = printf("half8_f_7346c===%+010.1v8hf===%+010.1v8hf===\n",var1,var2);
  return i;
}

int half8_f_7347c() {
  // { dg-printf -re "half8_f_7347c===.*===.*===" }
  half8 var1 = (half8) (-5,-3,4,4,1,-8,-123455,123445);
  half8 var2 = (half8) (-4,1,-1,8,-5,4,8,123445);
  int i = printf("half8_f_7347c===%+010.2v8hf===%+010.2v8hf===\n",var1,var2);
  return i;
}

int half8_f_7348c() {
  // { dg-printf -re "half8_f_7348c===.*===.*===" }
  half8 var1 = (half8) (8,3,-7,2,-7,3,2,5);
  half8 var2 = (half8) (-123455,-7,1,-7,-6,4,2,-2);
  int i = printf("half8_f_7348c===%+010.3v8hf===%+010.3v8hf===\n",var1,var2);
  return i;
}

int half8_f_7349c() {
  // { dg-printf -re "half8_f_7349c===.*===.*===" }
  half8 var1 = (half8) (5,4,-1,-6,-6,-1,3,-8);
  half8 var2 = (half8) (-6,-4,7,-3,-123455,-6,3,2);
  int i = printf("half8_f_7349c===%+010.10v8hf===%+010.10v8hf===\n",var1,var2);
  return i;
}

int half8_f_7350c() {
  // { dg-printf -re "half8_f_7350c===.*===.*===" }
  half8 var1 = (half8) (-3,0,-4,-7,4,7,5,-123455);
  half8 var2 = (half8) (-3,-1,7,-6,4,-7,-8,-6);
  int i = printf("half8_f_7350c===%+010v8hF===%+010v8hF===\n",var1,var2);
  return i;
}

int half8_f_7351c() {
  // { dg-printf -re "half8_f_7351c===.*===.*===" }
  half8 var1 = (half8) (4,-5,-3,-4,5,3,-1,-6);
  half8 var2 = (half8) (3,7,3,8,-1,-1,-5,-4);
  int i = printf("half8_f_7351c===%+010.1v8hF===%+010.1v8hF===\n",var1,var2);
  return i;
}

int half8_f_7352c() {
  // { dg-printf -re "half8_f_7352c===.*===.*===" }
  half8 var1 = (half8) (123445,-3,7,4,-3,7,7,5);
  half8 var2 = (half8) (-5,-123455,7,3,1,-123455,-3,5);
  int i = printf("half8_f_7352c===%+010.2v8hF===%+010.2v8hF===\n",var1,var2);
  return i;
}

int half8_f_7353c() {
  // { dg-printf -re "half8_f_7353c===.*===.*===" }
  half8 var1 = (half8) (-4,-7,4,3,1,-8,-8,-2);
  half8 var2 = (half8) (-4,123445,7,0,-8,-8,1,7);
  int i = printf("half8_f_7353c===%+010.3v8hF===%+010.3v8hF===\n",var1,var2);
  return i;
}

int half8_f_7354c() {
  // { dg-printf -re "half8_f_7354c===.*===.*===" }
  half8 var1 = (half8) (123445,-6,0,-3,4,-5,-123455,-8);
  half8 var2 = (half8) (4,123445,-2,7,5,-5,-123455,-3);
  int i = printf("half8_f_7354c===%+010.10v8hF===%+010.10v8hF===\n",var1,var2);
  return i;
}

int half8_g_1275c() {
  // { dg-printf -re "half8_g_1275c===.*===.*===" }
  half8 var1 = (half8) (-7,1,3,0,8,5,6,3);
  half8 var2 = (half8) (-6,0,-6,4,-4,-3,7,-5);
  int i = printf("half8_g_1275c===%-v8hg===%-v8hg===\n",var1,var2);
  return i;
}

int half8_g_1276c() {
  // { dg-printf -re "half8_g_1276c===.*===.*===" }
  half8 var1 = (half8) (5,8,-7,-7,5,-2,0,2);
  half8 var2 = (half8) (-8,-7,6,-4,-3,2,-7,-123455);
  int i = printf("half8_g_1276c===%-.1v8hg===%-.1v8hg===\n",var1,var2);
  return i;
}

int half8_g_1277c() {
  // { dg-printf -re "half8_g_1277c===.*===.*===" }
  half8 var1 = (half8) (2,-1,4,-8,2,3,-123455,1);
  half8 var2 = (half8) (-1,-3,7,-8,7,123445,-2,-7);
  int i = printf("half8_g_1277c===%-.2v8hg===%-.2v8hg===\n",var1,var2);
  return i;
}

int half8_g_1278c() {
  // { dg-printf -re "half8_g_1278c===.*===.*===" }
  half8 var1 = (half8) (3,-5,-123455,-7,2,5,5,-5);
  half8 var2 = (half8) (-2,-6,-1,-6,-2,7,-1,-2);
  int i = printf("half8_g_1278c===%-.3v8hg===%-.3v8hg===\n",var1,var2);
  return i;
}

int half8_g_1279c() {
  // { dg-printf -re "half8_g_1279c===.*===.*===" }
  half8 var1 = (half8) (4,5,0,-123455,5,4,-123455,-7);
  half8 var2 = (half8) (-7,-123455,-4,-3,-1,6,-1,1);
  int i = printf("half8_g_1279c===%-.10v8hg===%-.10v8hg===\n",var1,var2);
  return i;
}

int half8_g_1280c() {
  // { dg-printf -re "half8_g_1280c===.*===.*===" }
  half8 var1 = (half8) (-1,0,-6,-1,-6,-123455,6,-7);
  half8 var2 = (half8) (1,-4,-8,-123455,-5,1,-5,3);
  int i = printf("half8_g_1280c===%-v8hG===%-v8hG===\n",var1,var2);
  return i;
}

int half8_g_1281c() {
  // { dg-printf -re "half8_g_1281c===.*===.*===" }
  half8 var1 = (half8) (2,6,0,-7,4,3,-1,-8);
  half8 var2 = (half8) (-2,0,8,7,6,-3,-7,6);
  int i = printf("half8_g_1281c===%-.1v8hG===%-.1v8hG===\n",var1,var2);
  return i;
}

int half8_g_1282c() {
  // { dg-printf -re "half8_g_1282c===.*===.*===" }
  half8 var1 = (half8) (123445,123445,1,-5,-7,-2,7,-3);
  half8 var2 = (half8) (3,-5,-2,-4,-5,0,123445,-1);
  int i = printf("half8_g_1282c===%-.2v8hG===%-.2v8hG===\n",var1,var2);
  return i;
}

int half8_g_1283c() {
  // { dg-printf -re "half8_g_1283c===.*===.*===" }
  half8 var1 = (half8) (5,8,-2,3,3,7,123445,4);
  half8 var2 = (half8) (-8,2,-3,5,-123455,8,-1,3);
  int i = printf("half8_g_1283c===%-.3v8hG===%-.3v8hG===\n",var1,var2);
  return i;
}

int half8_g_1284c() {
  // { dg-printf -re "half8_g_1284c===.*===.*===" }
  half8 var1 = (half8) (6,-6,0,-6,-1,-8,4,5);
  half8 var2 = (half8) (-6,4,-123455,-123455,-123455,-2,-123455,3);
  int i = printf("half8_g_1284c===%-.10v8hG===%-.10v8hG===\n",var1,var2);
  return i;
}

int half8_g_2035c() {
  // { dg-printf -re "half8_g_2035c===.*===.*===" }
  half8 var1 = (half8) (-4,-4,4,7,0,-8,-123455,-123455);
  half8 var2 = (half8) (-7,-2,2,-1,5,-4,-7,0);
  int i = printf("half8_g_2035c===%+v8hg===%+v8hg===\n",var1,var2);
  return i;
}

int half8_g_2036c() {
  // { dg-printf -re "half8_g_2036c===.*===.*===" }
  half8 var1 = (half8) (123445,-123455,-7,-8,7,2,1,6);
  half8 var2 = (half8) (0,-2,-6,-2,0,7,2,-7);
  int i = printf("half8_g_2036c===%+.1v8hg===%+.1v8hg===\n",var1,var2);
  return i;
}

int half8_g_2037c() {
  // { dg-printf -re "half8_g_2037c===.*===.*===" }
  half8 var1 = (half8) (8,-3,4,-5,-6,-123455,1,4);
  half8 var2 = (half8) (-8,6,123445,-6,-8,1,-5,8);
  int i = printf("half8_g_2037c===%+.2v8hg===%+.2v8hg===\n",var1,var2);
  return i;
}

int half8_g_2038c() {
  // { dg-printf -re "half8_g_2038c===.*===.*===" }
  half8 var1 = (half8) (-3,-1,-1,-2,8,3,-5,0);
  half8 var2 = (half8) (-4,8,2,0,5,-8,5,123445);
  int i = printf("half8_g_2038c===%+.3v8hg===%+.3v8hg===\n",var1,var2);
  return i;
}

int half8_g_2039c() {
  // { dg-printf -re "half8_g_2039c===.*===.*===" }
  half8 var1 = (half8) (8,-123455,5,-123455,-5,5,-5,4);
  half8 var2 = (half8) (-123455,6,-4,2,0,123445,-4,-8);
  int i = printf("half8_g_2039c===%+.10v8hg===%+.10v8hg===\n",var1,var2);
  return i;
}

int half8_g_2040c() {
  // { dg-printf -re "half8_g_2040c===.*===.*===" }
  half8 var1 = (half8) (4,-2,3,-5,-8,-123455,4,-3);
  half8 var2 = (half8) (7,-2,-1,2,8,6,123445,-8);
  int i = printf("half8_g_2040c===%+v8hG===%+v8hG===\n",var1,var2);
  return i;
}

int half8_g_2041c() {
  // { dg-printf -re "half8_g_2041c===.*===.*===" }
  half8 var1 = (half8) (-123455,3,-2,3,123445,0,5,-8);
  half8 var2 = (half8) (-5,4,6,6,6,-4,0,-2);
  int i = printf("half8_g_2041c===%+.1v8hG===%+.1v8hG===\n",var1,var2);
  return i;
}

int half8_g_2042c() {
  // { dg-printf -re "half8_g_2042c===.*===.*===" }
  half8 var1 = (half8) (7,2,-1,2,-2,-4,3,-2);
  half8 var2 = (half8) (0,6,5,4,0,-1,-5,-1);
  int i = printf("half8_g_2042c===%+.2v8hG===%+.2v8hG===\n",var1,var2);
  return i;
}

int half8_g_2043c() {
  // { dg-printf -re "half8_g_2043c===.*===.*===" }
  half8 var1 = (half8) (3,-6,-1,-7,0,3,-4,-123455);
  half8 var2 = (half8) (2,-123455,-4,3,1,1,-3,6);
  int i = printf("half8_g_2043c===%+.3v8hG===%+.3v8hG===\n",var1,var2);
  return i;
}

int half8_g_2044c() {
  // { dg-printf -re "half8_g_2044c===.*===.*===" }
  half8 var1 = (half8) (-8,2,7,-8,-5,-123455,-3,4);
  half8 var2 = (half8) (123445,3,0,4,-3,-123455,-6,-5);
  int i = printf("half8_g_2044c===%+.10v8hG===%+.10v8hG===\n",var1,var2);
  return i;
}

int half8_g_2795c() {
  // { dg-printf -re "half8_g_2795c===.*===.*===" }
  half8 var1 = (half8) (1,3,6,-5,-6,-3,-5,6);
  half8 var2 = (half8) (6,-2,3,0,-8,-123455,6,-7);
  int i = printf("half8_g_2795c===%#v8hg===%#v8hg===\n",var1,var2);
  return i;
}

int half8_g_2796c() {
  // { dg-printf -re "half8_g_2796c===.*===.*===" }
  half8 var1 = (half8) (-123455,-6,123445,-5,-3,0,6,-4);
  half8 var2 = (half8) (-1,3,0,-4,-2,3,-123455,-123455);
  int i = printf("half8_g_2796c===%#.1v8hg===%#.1v8hg===\n",var1,var2);
  return i;
}

int half8_g_2797c() {
  // { dg-printf -re "half8_g_2797c===.*===.*===" }
  half8 var1 = (half8) (-123455,-6,-3,6,7,7,5,-123455);
  half8 var2 = (half8) (7,7,-4,-7,4,6,1,-1);
  int i = printf("half8_g_2797c===%#.2v8hg===%#.2v8hg===\n",var1,var2);
  return i;
}

int half8_g_2798c() {
  // { dg-printf -re "half8_g_2798c===.*===.*===" }
  half8 var1 = (half8) (-123455,-123455,-8,123445,1,-8,6,-6);
  half8 var2 = (half8) (-4,3,-7,-123455,2,5,1,-1);
  int i = printf("half8_g_2798c===%#.3v8hg===%#.3v8hg===\n",var1,var2);
  return i;
}

int half8_g_2799c() {
  // { dg-printf -re "half8_g_2799c===.*===.*===" }
  half8 var1 = (half8) (-2,-1,6,4,2,-4,1,-4);
  half8 var2 = (half8) (123445,3,6,-7,123445,-2,-6,8);
  int i = printf("half8_g_2799c===%#.10v8hg===%#.10v8hg===\n",var1,var2);
  return i;
}

int half8_g_2800c() {
  // { dg-printf -re "half8_g_2800c===.*===.*===" }
  half8 var1 = (half8) (0,-7,-4,-2,7,0,-3,-3);
  half8 var2 = (half8) (-3,0,2,-3,7,2,-6,-1);
  int i = printf("half8_g_2800c===%#v8hG===%#v8hG===\n",var1,var2);
  return i;
}

int half8_g_2801c() {
  // { dg-printf -re "half8_g_2801c===.*===.*===" }
  half8 var1 = (half8) (5,6,8,-123455,-3,-123455,-2,1);
  half8 var2 = (half8) (8,-123455,2,2,-2,-5,0,-2);
  int i = printf("half8_g_2801c===%#.1v8hG===%#.1v8hG===\n",var1,var2);
  return i;
}

int half8_g_2802c() {
  // { dg-printf -re "half8_g_2802c===.*===.*===" }
  half8 var1 = (half8) (1,-5,3,3,-123455,8,123445,8);
  half8 var2 = (half8) (-1,8,2,8,-2,4,123445,123445);
  int i = printf("half8_g_2802c===%#.2v8hG===%#.2v8hG===\n",var1,var2);
  return i;
}

int half8_g_2803c() {
  // { dg-printf -re "half8_g_2803c===.*===.*===" }
  half8 var1 = (half8) (-1,2,5,-8,-3,-5,-1,0);
  half8 var2 = (half8) (-4,-1,7,-2,2,2,-7,-6);
  int i = printf("half8_g_2803c===%#.3v8hG===%#.3v8hG===\n",var1,var2);
  return i;
}

int half8_g_2804c() {
  // { dg-printf -re "half8_g_2804c===.*===.*===" }
  half8 var1 = (half8) (5,-8,3,0,-1,-6,5,6);
  half8 var2 = (half8) (5,5,-6,-1,8,0,-7,2);
  int i = printf("half8_g_2804c===%#.10v8hG===%#.10v8hG===\n",var1,var2);
  return i;
}

int half8_g_3555c() {
  // { dg-printf -re "half8_g_3555c===.*===.*===" }
  half8 var1 = (half8) (-1,-7,2,-5,8,0,-7,-3);
  half8 var2 = (half8) (-7,-5,2,7,-1,6,-5,-6);
  int i = printf("half8_g_3555c===%-+v8hg===%-+v8hg===\n",var1,var2);
  return i;
}

int half8_g_3556c() {
  // { dg-printf -re "half8_g_3556c===.*===.*===" }
  half8 var1 = (half8) (7,7,-8,1,-123455,-5,8,-3);
  half8 var2 = (half8) (6,-2,123445,-1,123445,-5,2,1);
  int i = printf("half8_g_3556c===%-+.1v8hg===%-+.1v8hg===\n",var1,var2);
  return i;
}

int half8_g_3557c() {
  // { dg-printf -re "half8_g_3557c===.*===.*===" }
  half8 var1 = (half8) (-2,-7,6,-8,-5,6,-1,-7);
  half8 var2 = (half8) (6,2,-5,-6,-8,-4,-2,-1);
  int i = printf("half8_g_3557c===%-+.2v8hg===%-+.2v8hg===\n",var1,var2);
  return i;
}

int half8_g_3558c() {
  // { dg-printf -re "half8_g_3558c===.*===.*===" }
  half8 var1 = (half8) (7,6,-5,-123455,3,-1,8,-5);
  half8 var2 = (half8) (4,-5,5,3,-6,-1,-4,-4);
  int i = printf("half8_g_3558c===%-+.3v8hg===%-+.3v8hg===\n",var1,var2);
  return i;
}

int half8_g_3559c() {
  // { dg-printf -re "half8_g_3559c===.*===.*===" }
  half8 var1 = (half8) (7,6,0,4,-3,5,4,-7);
  half8 var2 = (half8) (2,3,4,-5,8,6,-6,-3);
  int i = printf("half8_g_3559c===%-+.10v8hg===%-+.10v8hg===\n",var1,var2);
  return i;
}

int half8_g_3560c() {
  // { dg-printf -re "half8_g_3560c===.*===.*===" }
  half8 var1 = (half8) (8,2,-4,4,-8,8,-4,123445);
  half8 var2 = (half8) (3,4,-6,-6,-6,6,2,123445);
  int i = printf("half8_g_3560c===%-+v8hG===%-+v8hG===\n",var1,var2);
  return i;
}

int half8_g_3561c() {
  // { dg-printf -re "half8_g_3561c===.*===.*===" }
  half8 var1 = (half8) (-2,-4,-7,1,8,-6,6,-6);
  half8 var2 = (half8) (1,6,123445,-2,4,1,-3,5);
  int i = printf("half8_g_3561c===%-+.1v8hG===%-+.1v8hG===\n",var1,var2);
  return i;
}

int half8_g_3562c() {
  // { dg-printf -re "half8_g_3562c===.*===.*===" }
  half8 var1 = (half8) (-3,5,6,6,7,6,-8,-2);
  half8 var2 = (half8) (-123455,8,-7,2,8,-5,1,1);
  int i = printf("half8_g_3562c===%-+.2v8hG===%-+.2v8hG===\n",var1,var2);
  return i;
}

int half8_g_3563c() {
  // { dg-printf -re "half8_g_3563c===.*===.*===" }
  half8 var1 = (half8) (-7,2,-4,-3,-5,8,-123455,-7);
  half8 var2 = (half8) (-123455,-4,5,123445,123445,-3,-3,6);
  int i = printf("half8_g_3563c===%-+.3v8hG===%-+.3v8hG===\n",var1,var2);
  return i;
}

int half8_g_3564c() {
  // { dg-printf -re "half8_g_3564c===.*===.*===" }
  half8 var1 = (half8) (-123455,8,4,-3,6,6,-1,-2);
  half8 var2 = (half8) (1,-7,-1,7,1,-123455,-5,3);
  int i = printf("half8_g_3564c===%-+.10v8hG===%-+.10v8hG===\n",var1,var2);
  return i;
}

int half8_g_4315c() {
  // { dg-printf -re "half8_g_4315c===.*===.*===" }
  half8 var1 = (half8) (0,5,1,0,2,5,-2,-3);
  half8 var2 = (half8) (-7,7,2,-2,-7,2,-8,-2);
  int i = printf("half8_g_4315c===% 10v8hg===% 10v8hg===\n",var1,var2);
  return i;
}

int half8_g_4316c() {
  // { dg-printf -re "half8_g_4316c===.*===.*===" }
  half8 var1 = (half8) (-3,5,-5,3,-5,4,6,4);
  half8 var2 = (half8) (123445,-1,-1,1,123445,-2,-6,8);
  int i = printf("half8_g_4316c===% 10.1v8hg===% 10.1v8hg===\n",var1,var2);
  return i;
}

int half8_g_4317c() {
  // { dg-printf -re "half8_g_4317c===.*===.*===" }
  half8 var1 = (half8) (5,-5,-8,3,0,-2,1,-7);
  half8 var2 = (half8) (7,7,-123455,4,-6,-5,-8,-1);
  int i = printf("half8_g_4317c===% 10.2v8hg===% 10.2v8hg===\n",var1,var2);
  return i;
}

int half8_g_4318c() {
  // { dg-printf -re "half8_g_4318c===.*===.*===" }
  half8 var1 = (half8) (0,123445,-2,-3,2,4,123445,7);
  half8 var2 = (half8) (0,-3,-1,-5,-123455,4,5,7);
  int i = printf("half8_g_4318c===% 10.3v8hg===% 10.3v8hg===\n",var1,var2);
  return i;
}

int half8_g_4319c() {
  // { dg-printf -re "half8_g_4319c===.*===.*===" }
  half8 var1 = (half8) (4,-3,6,-2,2,-7,123445,-1);
  half8 var2 = (half8) (5,-1,-7,-7,2,-2,0,-8);
  int i = printf("half8_g_4319c===% 10.10v8hg===% 10.10v8hg===\n",var1,var2);
  return i;
}

int half8_g_4320c() {
  // { dg-printf -re "half8_g_4320c===.*===.*===" }
  half8 var1 = (half8) (-6,-4,123445,-1,3,8,-2,-3);
  half8 var2 = (half8) (0,6,7,0,2,4,5,3);
  int i = printf("half8_g_4320c===% 10v8hG===% 10v8hG===\n",var1,var2);
  return i;
}

int half8_g_4321c() {
  // { dg-printf -re "half8_g_4321c===.*===.*===" }
  half8 var1 = (half8) (8,-3,-4,0,-4,5,8,-3);
  half8 var2 = (half8) (-3,2,-6,4,-2,-3,8,8);
  int i = printf("half8_g_4321c===% 10.1v8hG===% 10.1v8hG===\n",var1,var2);
  return i;
}

int half8_g_4322c() {
  // { dg-printf -re "half8_g_4322c===.*===.*===" }
  half8 var1 = (half8) (1,-6,-4,4,-5,0,-3,-5);
  half8 var2 = (half8) (-123455,-7,3,-6,2,4,3,3);
  int i = printf("half8_g_4322c===% 10.2v8hG===% 10.2v8hG===\n",var1,var2);
  return i;
}

int half8_g_4323c() {
  // { dg-printf -re "half8_g_4323c===.*===.*===" }
  half8 var1 = (half8) (-2,3,0,-1,-8,2,4,8);
  half8 var2 = (half8) (-2,-5,7,4,123445,7,-3,-3);
  int i = printf("half8_g_4323c===% 10.3v8hG===% 10.3v8hG===\n",var1,var2);
  return i;
}

int half8_g_4324c() {
  // { dg-printf -re "half8_g_4324c===.*===.*===" }
  half8 var1 = (half8) (8,-123455,123445,-3,-2,-4,-123455,-1);
  half8 var2 = (half8) (-123455,3,-8,-5,3,3,-4,-2);
  int i = printf("half8_g_4324c===% 10.10v8hG===% 10.10v8hG===\n",var1,var2);
  return i;
}

int half8_g_5075c() {
  // { dg-printf -re "half8_g_5075c===.*===.*===" }
  half8 var1 = (half8) (-4,2,-5,2,-2,-6,-1,2);
  half8 var2 = (half8) (-5,4,2,6,4,1,-5,5);
  int i = printf("half8_g_5075c===%010v8hg===%010v8hg===\n",var1,var2);
  return i;
}

int half8_g_5076c() {
  // { dg-printf -re "half8_g_5076c===.*===.*===" }
  half8 var1 = (half8) (-5,7,-6,-5,7,0,-4,6);
  half8 var2 = (half8) (1,5,7,123445,-2,2,-6,-2);
  int i = printf("half8_g_5076c===%010.1v8hg===%010.1v8hg===\n",var1,var2);
  return i;
}

int half8_g_5077c() {
  // { dg-printf -re "half8_g_5077c===.*===.*===" }
  half8 var1 = (half8) (123445,1,-3,-123455,-5,0,7,-5);
  half8 var2 = (half8) (2,-123455,0,6,-7,3,2,4);
  int i = printf("half8_g_5077c===%010.2v8hg===%010.2v8hg===\n",var1,var2);
  return i;
}

int half8_g_5078c() {
  // { dg-printf -re "half8_g_5078c===.*===.*===" }
  half8 var1 = (half8) (-5,-5,-3,-5,4,3,-3,3);
  half8 var2 = (half8) (6,4,3,-8,2,5,-7,8);
  int i = printf("half8_g_5078c===%010.3v8hg===%010.3v8hg===\n",var1,var2);
  return i;
}

int half8_g_5079c() {
  // { dg-printf -re "half8_g_5079c===.*===.*===" }
  half8 var1 = (half8) (-6,7,-3,-123455,8,-2,-1,-123455);
  half8 var2 = (half8) (-8,123445,2,-3,-6,8,6,5);
  int i = printf("half8_g_5079c===%010.10v8hg===%010.10v8hg===\n",var1,var2);
  return i;
}

int half8_g_5080c() {
  // { dg-printf -re "half8_g_5080c===.*===.*===" }
  half8 var1 = (half8) (4,7,-1,0,3,-3,-6,7);
  half8 var2 = (half8) (3,-2,-2,-3,-2,0,2,-123455);
  int i = printf("half8_g_5080c===%010v8hG===%010v8hG===\n",var1,var2);
  return i;
}

int half8_g_5081c() {
  // { dg-printf -re "half8_g_5081c===.*===.*===" }
  half8 var1 = (half8) (1,-3,1,8,2,-4,4,2);
  half8 var2 = (half8) (5,2,0,2,3,2,-7,7);
  int i = printf("half8_g_5081c===%010.1v8hG===%010.1v8hG===\n",var1,var2);
  return i;
}

int half8_g_5082c() {
  // { dg-printf -re "half8_g_5082c===.*===.*===" }
  half8 var1 = (half8) (-4,-3,123445,8,-5,-5,-3,3);
  half8 var2 = (half8) (0,-3,6,-5,-2,0,-5,-7);
  int i = printf("half8_g_5082c===%010.2v8hG===%010.2v8hG===\n",var1,var2);
  return i;
}

int half8_g_5083c() {
  // { dg-printf -re "half8_g_5083c===.*===.*===" }
  half8 var1 = (half8) (-4,0,7,4,-4,5,-1,6);
  half8 var2 = (half8) (5,2,6,6,0,8,6,-8);
  int i = printf("half8_g_5083c===%010.3v8hG===%010.3v8hG===\n",var1,var2);
  return i;
}

int half8_g_5084c() {
  // { dg-printf -re "half8_g_5084c===.*===.*===" }
  half8 var1 = (half8) (-4,-123455,6,1,2,-3,-4,1);
  half8 var2 = (half8) (2,-6,0,123445,-4,4,6,-3);
  int i = printf("half8_g_5084c===%010.10v8hG===%010.10v8hG===\n",var1,var2);
  return i;
}

int half8_g_515c() {
  // { dg-printf -re "half8_g_515c===.*===.*===" }
  half8 var1 = (half8) (-123455,4,-123455,-6,5,-1,3,-5);
  half8 var2 = (half8) (8,0,5,7,-8,-2,8,7);
  int i = printf("half8_g_515c===%v8hg===%v8hg===\n",var1,var2);
  return i;
}

int half8_g_516c() {
  // { dg-printf -re "half8_g_516c===.*===.*===" }
  half8 var1 = (half8) (-1,4,3,-5,8,7,4,3);
  half8 var2 = (half8) (5,123445,-1,-1,-4,-7,-2,-7);
  int i = printf("half8_g_516c===%.1v8hg===%.1v8hg===\n",var1,var2);
  return i;
}

int half8_g_517c() {
  // { dg-printf -re "half8_g_517c===.*===.*===" }
  half8 var1 = (half8) (-5,6,1,2,-3,2,-4,-123455);
  half8 var2 = (half8) (5,-3,123445,1,-1,-1,8,-5);
  int i = printf("half8_g_517c===%.2v8hg===%.2v8hg===\n",var1,var2);
  return i;
}

int half8_g_518c() {
  // { dg-printf -re "half8_g_518c===.*===.*===" }
  half8 var1 = (half8) (5,4,-4,-123455,-123455,1,123445,-4);
  half8 var2 = (half8) (2,3,-6,123445,-3,6,-123455,123445);
  int i = printf("half8_g_518c===%.3v8hg===%.3v8hg===\n",var1,var2);
  return i;
}

int half8_g_519c() {
  // { dg-printf -re "half8_g_519c===.*===.*===" }
  half8 var1 = (half8) (3,0,8,7,-123455,-123455,-5,-2);
  half8 var2 = (half8) (3,-8,-3,5,5,0,-3,5);
  int i = printf("half8_g_519c===%.10v8hg===%.10v8hg===\n",var1,var2);
  return i;
}

int half8_g_520c() {
  // { dg-printf -re "half8_g_520c===.*===.*===" }
  half8 var1 = (half8) (5,123445,-4,-2,-123455,-6,-8,0);
  half8 var2 = (half8) (-7,-8,123445,8,-123455,2,-3,1);
  int i = printf("half8_g_520c===%v8hG===%v8hG===\n",var1,var2);
  return i;
}

int half8_g_521c() {
  // { dg-printf -re "half8_g_521c===.*===.*===" }
  half8 var1 = (half8) (8,-4,7,-8,-1,0,7,-5);
  half8 var2 = (half8) (4,2,-5,-3,-8,-2,8,5);
  int i = printf("half8_g_521c===%.1v8hG===%.1v8hG===\n",var1,var2);
  return i;
}

int half8_g_522c() {
  // { dg-printf -re "half8_g_522c===.*===.*===" }
  half8 var1 = (half8) (-123455,-1,2,123445,8,123445,1,6);
  half8 var2 = (half8) (123445,-123455,-7,3,-4,-2,1,2);
  int i = printf("half8_g_522c===%.2v8hG===%.2v8hG===\n",var1,var2);
  return i;
}

int half8_g_523c() {
  // { dg-printf -re "half8_g_523c===.*===.*===" }
  half8 var1 = (half8) (-2,4,-7,5,-3,1,6,-4);
  half8 var2 = (half8) (5,8,-5,123445,-123455,-5,-1,-8);
  int i = printf("half8_g_523c===%.3v8hG===%.3v8hG===\n",var1,var2);
  return i;
}

int half8_g_524c() {
  // { dg-printf -re "half8_g_524c===.*===.*===" }
  half8 var1 = (half8) (-7,4,1,5,-7,7,3,-2);
  half8 var2 = (half8) (-2,4,-6,-6,4,-3,-1,8);
  int i = printf("half8_g_524c===%.10v8hG===%.10v8hG===\n",var1,var2);
  return i;
}

int half8_g_5835c() {
  // { dg-printf -re "half8_g_5835c===.*===.*===" }
  half8 var1 = (half8) (-4,-7,0,8,-123455,7,-8,-1);
  half8 var2 = (half8) (6,3,4,-1,-5,0,8,8);
  int i = printf("half8_g_5835c===%- 10v8hg===%- 10v8hg===\n",var1,var2);
  return i;
}

int half8_g_5836c() {
  // { dg-printf -re "half8_g_5836c===.*===.*===" }
  half8 var1 = (half8) (8,-7,-5,-3,8,-1,-3,-123455);
  half8 var2 = (half8) (0,-4,7,7,5,-123455,-1,5);
  int i = printf("half8_g_5836c===%- 10.1v8hg===%- 10.1v8hg===\n",var1,var2);
  return i;
}

int half8_g_5837c() {
  // { dg-printf -re "half8_g_5837c===.*===.*===" }
  half8 var1 = (half8) (6,-123455,7,2,7,2,-1,7);
  half8 var2 = (half8) (-1,-1,4,0,5,-5,2,-8);
  int i = printf("half8_g_5837c===%- 10.2v8hg===%- 10.2v8hg===\n",var1,var2);
  return i;
}

int half8_g_5838c() {
  // { dg-printf -re "half8_g_5838c===.*===.*===" }
  half8 var1 = (half8) (-4,-8,-7,-6,-1,-123455,3,-123455);
  half8 var2 = (half8) (0,-2,2,4,-6,-5,-5,4);
  int i = printf("half8_g_5838c===%- 10.3v8hg===%- 10.3v8hg===\n",var1,var2);
  return i;
}

int half8_g_5839c() {
  // { dg-printf -re "half8_g_5839c===.*===.*===" }
  half8 var1 = (half8) (5,-3,2,6,7,5,3,1);
  half8 var2 = (half8) (2,-4,-4,123445,-4,8,-3,-8);
  int i = printf("half8_g_5839c===%- 10.10v8hg===%- 10.10v8hg===\n",var1,var2);
  return i;
}

int half8_g_5840c() {
  // { dg-printf -re "half8_g_5840c===.*===.*===" }
  half8 var1 = (half8) (4,123445,1,-6,0,7,3,-2);
  half8 var2 = (half8) (-2,2,-8,5,2,-123455,6,123445);
  int i = printf("half8_g_5840c===%- 10v8hG===%- 10v8hG===\n",var1,var2);
  return i;
}

int half8_g_5841c() {
  // { dg-printf -re "half8_g_5841c===.*===.*===" }
  half8 var1 = (half8) (1,-6,-5,123445,1,0,7,-4);
  half8 var2 = (half8) (3,-123455,2,6,-1,2,-2,0);
  int i = printf("half8_g_5841c===%- 10.1v8hG===%- 10.1v8hG===\n",var1,var2);
  return i;
}

int half8_g_5842c() {
  // { dg-printf -re "half8_g_5842c===.*===.*===" }
  half8 var1 = (half8) (-123455,-6,123445,-3,3,5,1,123445);
  half8 var2 = (half8) (5,-4,-123455,-1,2,7,6,4);
  int i = printf("half8_g_5842c===%- 10.2v8hG===%- 10.2v8hG===\n",var1,var2);
  return i;
}

int half8_g_5843c() {
  // { dg-printf -re "half8_g_5843c===.*===.*===" }
  half8 var1 = (half8) (8,-4,0,5,4,-7,8,-1);
  half8 var2 = (half8) (3,-8,2,-8,6,5,-2,3);
  int i = printf("half8_g_5843c===%- 10.3v8hG===%- 10.3v8hG===\n",var1,var2);
  return i;
}

int half8_g_5844c() {
  // { dg-printf -re "half8_g_5844c===.*===.*===" }
  half8 var1 = (half8) (-8,-8,7,1,-6,7,-5,-6);
  half8 var2 = (half8) (8,2,6,-6,0,-2,-8,5);
  int i = printf("half8_g_5844c===%- 10.10v8hG===%- 10.10v8hG===\n",var1,var2);
  return i;
}

int half8_g_6595c() {
  // { dg-printf -re "half8_g_6595c===.*===.*===" }
  half8 var1 = (half8) (-5,123445,-123455,-1,-123455,-8,1,-5);
  half8 var2 = (half8) (2,-5,123445,-123455,1,3,-7,1);
  int i = printf("half8_g_6595c===%+ 10v8hg===%+ 10v8hg===\n",var1,var2);
  return i;
}

int half8_g_6596c() {
  // { dg-printf -re "half8_g_6596c===.*===.*===" }
  half8 var1 = (half8) (-8,4,-1,2,-5,-123455,-2,0);
  half8 var2 = (half8) (7,123445,1,123445,1,-5,2,123445);
  int i = printf("half8_g_6596c===%+ 10.1v8hg===%+ 10.1v8hg===\n",var1,var2);
  return i;
}

int half8_g_6597c() {
  // { dg-printf -re "half8_g_6597c===.*===.*===" }
  half8 var1 = (half8) (-2,-5,6,3,7,-4,2,-3);
  half8 var2 = (half8) (123445,-7,123445,-1,-2,-8,123445,-7);
  int i = printf("half8_g_6597c===%+ 10.2v8hg===%+ 10.2v8hg===\n",var1,var2);
  return i;
}

int half8_g_6598c() {
  // { dg-printf -re "half8_g_6598c===.*===.*===" }
  half8 var1 = (half8) (4,-123455,2,2,-123455,-6,4,-3);
  half8 var2 = (half8) (0,-8,4,-6,-7,5,-2,-5);
  int i = printf("half8_g_6598c===%+ 10.3v8hg===%+ 10.3v8hg===\n",var1,var2);
  return i;
}

int half8_g_6599c() {
  // { dg-printf -re "half8_g_6599c===.*===.*===" }
  half8 var1 = (half8) (4,-5,7,3,3,1,-7,2);
  half8 var2 = (half8) (123445,7,1,-5,8,-8,-5,-5);
  int i = printf("half8_g_6599c===%+ 10.10v8hg===%+ 10.10v8hg===\n",var1,var2);
  return i;
}

int half8_g_6600c() {
  // { dg-printf -re "half8_g_6600c===.*===.*===" }
  half8 var1 = (half8) (8,123445,7,6,123445,0,6,5);
  half8 var2 = (half8) (-8,123445,1,-7,0,-1,123445,123445);
  int i = printf("half8_g_6600c===%+ 10v8hG===%+ 10v8hG===\n",var1,var2);
  return i;
}

int half8_g_6601c() {
  // { dg-printf -re "half8_g_6601c===.*===.*===" }
  half8 var1 = (half8) (8,123445,-7,5,3,0,5,-1);
  half8 var2 = (half8) (-123455,-4,-3,-1,-4,123445,-5,2);
  int i = printf("half8_g_6601c===%+ 10.1v8hG===%+ 10.1v8hG===\n",var1,var2);
  return i;
}

int half8_g_6602c() {
  // { dg-printf -re "half8_g_6602c===.*===.*===" }
  half8 var1 = (half8) (-8,-2,8,-1,-2,0,-5,-2);
  half8 var2 = (half8) (-7,2,0,-3,-1,7,-5,-4);
  int i = printf("half8_g_6602c===%+ 10.2v8hG===%+ 10.2v8hG===\n",var1,var2);
  return i;
}

int half8_g_6603c() {
  // { dg-printf -re "half8_g_6603c===.*===.*===" }
  half8 var1 = (half8) (-123455,2,-4,1,8,0,-5,4);
  half8 var2 = (half8) (7,-4,-2,-8,-7,1,-7,123445);
  int i = printf("half8_g_6603c===%+ 10.3v8hG===%+ 10.3v8hG===\n",var1,var2);
  return i;
}

int half8_g_6604c() {
  // { dg-printf -re "half8_g_6604c===.*===.*===" }
  half8 var1 = (half8) (-4,1,2,-3,8,1,-8,-4);
  half8 var2 = (half8) (-3,-4,-6,2,4,-123455,1,3);
  int i = printf("half8_g_6604c===%+ 10.10v8hG===%+ 10.10v8hG===\n",var1,var2);
  return i;
}

int half8_g_7355c() {
  // { dg-printf -re "half8_g_7355c===.*===.*===" }
  half8 var1 = (half8) (-6,-8,-2,6,-4,123445,2,8);
  half8 var2 = (half8) (-6,-123455,8,123445,-7,-5,7,5);
  int i = printf("half8_g_7355c===%+010v8hg===%+010v8hg===\n",var1,var2);
  return i;
}

int half8_g_7356c() {
  // { dg-printf -re "half8_g_7356c===.*===.*===" }
  half8 var1 = (half8) (-5,-3,1,4,-123455,2,1,2);
  half8 var2 = (half8) (3,6,0,-3,-6,-5,3,1);
  int i = printf("half8_g_7356c===%+010.1v8hg===%+010.1v8hg===\n",var1,var2);
  return i;
}

int half8_g_7357c() {
  // { dg-printf -re "half8_g_7357c===.*===.*===" }
  half8 var1 = (half8) (-6,5,3,8,2,0,8,123445);
  half8 var2 = (half8) (5,-6,2,-5,4,2,5,-5);
  int i = printf("half8_g_7357c===%+010.2v8hg===%+010.2v8hg===\n",var1,var2);
  return i;
}

int half8_g_7358c() {
  // { dg-printf -re "half8_g_7358c===.*===.*===" }
  half8 var1 = (half8) (-4,-1,0,-7,-2,-6,-123455,1);
  half8 var2 = (half8) (5,5,4,-7,3,6,123445,-5);
  int i = printf("half8_g_7358c===%+010.3v8hg===%+010.3v8hg===\n",var1,var2);
  return i;
}

int half8_g_7359c() {
  // { dg-printf -re "half8_g_7359c===.*===.*===" }
  half8 var1 = (half8) (5,-3,-6,-7,-1,3,-3,5);
  half8 var2 = (half8) (-5,5,123445,8,2,3,-5,0);
  int i = printf("half8_g_7359c===%+010.10v8hg===%+010.10v8hg===\n",var1,var2);
  return i;
}

int half8_g_7360c() {
  // { dg-printf -re "half8_g_7360c===.*===.*===" }
  half8 var1 = (half8) (4,-1,-6,4,-1,-3,-2,6);
  half8 var2 = (half8) (-6,-123455,3,-2,2,5,0,-1);
  int i = printf("half8_g_7360c===%+010v8hG===%+010v8hG===\n",var1,var2);
  return i;
}

int half8_g_7361c() {
  // { dg-printf -re "half8_g_7361c===.*===.*===" }
  half8 var1 = (half8) (1,-5,123445,-1,-3,7,4,8);
  half8 var2 = (half8) (-1,6,7,-123455,7,1,-1,3);
  int i = printf("half8_g_7361c===%+010.1v8hG===%+010.1v8hG===\n",var1,var2);
  return i;
}

int half8_g_7362c() {
  // { dg-printf -re "half8_g_7362c===.*===.*===" }
  half8 var1 = (half8) (-3,0,-123455,1,6,-123455,6,1);
  half8 var2 = (half8) (4,0,0,-123455,-2,1,-4,-3);
  int i = printf("half8_g_7362c===%+010.2v8hG===%+010.2v8hG===\n",var1,var2);
  return i;
}

int half8_g_7363c() {
  // { dg-printf -re "half8_g_7363c===.*===.*===" }
  half8 var1 = (half8) (7,-4,-7,-5,-1,1,-1,3);
  half8 var2 = (half8) (0,8,0,-2,-8,-3,-7,5);
  int i = printf("half8_g_7363c===%+010.3v8hG===%+010.3v8hG===\n",var1,var2);
  return i;
}

int half8_g_7364c() {
  // { dg-printf -re "half8_g_7364c===.*===.*===" }
  half8 var1 = (half8) (-1,-5,123445,-8,-8,7,-4,-3);
  half8 var2 = (half8) (-5,3,-2,4,-3,-2,-6,-1);
  int i = printf("half8_g_7364c===%+010.10v8hG===%+010.10v8hG===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = half8_a_1245c();
i = half8_a_1246c();
i = half8_a_1247c();
i = half8_a_1248c();
i = half8_a_1249c();
i = half8_a_1250c();
i = half8_a_1251c();
i = half8_a_1252c();
i = half8_a_1253c();
i = half8_a_1254c();
i = half8_a_2005c();
i = half8_a_2006c();
i = half8_a_2007c();
i = half8_a_2008c();
i = half8_a_2009c();
i = half8_a_2010c();
i = half8_a_2011c();
i = half8_a_2012c();
i = half8_a_2013c();
i = half8_a_2014c();
i = half8_a_2765c();
i = half8_a_2766c();
i = half8_a_2767c();
i = half8_a_2768c();
i = half8_a_2769c();
i = half8_a_2770c();
i = half8_a_2771c();
i = half8_a_2772c();
i = half8_a_2773c();
i = half8_a_2774c();
i = half8_a_3525c();
i = half8_a_3526c();
i = half8_a_3527c();
i = half8_a_3528c();
i = half8_a_3529c();
i = half8_a_3530c();
i = half8_a_3531c();
i = half8_a_3532c();
i = half8_a_3533c();
i = half8_a_3534c();
i = half8_a_4285c();
i = half8_a_4286c();
i = half8_a_4287c();
i = half8_a_4288c();
i = half8_a_4289c();
i = half8_a_4290c();
i = half8_a_4291c();
i = half8_a_4292c();
i = half8_a_4293c();
i = half8_a_4294c();
i = half8_a_485c();
i = half8_a_486c();
i = half8_a_487c();
i = half8_a_488c();
i = half8_a_489c();
i = half8_a_490c();
i = half8_a_491c();
i = half8_a_492c();
i = half8_a_493c();
i = half8_a_494c();
i = half8_a_5045c();
i = half8_a_5046c();
i = half8_a_5047c();
i = half8_a_5048c();
i = half8_a_5049c();
i = half8_a_5050c();
i = half8_a_5051c();
i = half8_a_5052c();
i = half8_a_5053c();
i = half8_a_5054c();
i = half8_a_5805c();
i = half8_a_5806c();
i = half8_a_5807c();
i = half8_a_5808c();
i = half8_a_5809c();
i = half8_a_5810c();
i = half8_a_5811c();
i = half8_a_5812c();
i = half8_a_5813c();
i = half8_a_5814c();
i = half8_a_6565c();
i = half8_a_6566c();
i = half8_a_6567c();
i = half8_a_6568c();
i = half8_a_6569c();
i = half8_a_6570c();
i = half8_a_6571c();
i = half8_a_6572c();
i = half8_a_6573c();
i = half8_a_6574c();
i = half8_a_7325c();
i = half8_a_7326c();
i = half8_a_7327c();
i = half8_a_7328c();
i = half8_a_7329c();
i = half8_a_7330c();
i = half8_a_7331c();
i = half8_a_7332c();
i = half8_a_7333c();
i = half8_a_7334c();
i = half8_e_1255c();
i = half8_e_1256c();
i = half8_e_1257c();
i = half8_e_1258c();
i = half8_e_1259c();
i = half8_e_1260c();
i = half8_e_1261c();
i = half8_e_1262c();
i = half8_e_1263c();
i = half8_e_1264c();
i = half8_e_2015c();
i = half8_e_2016c();
i = half8_e_2017c();
i = half8_e_2018c();
i = half8_e_2019c();
i = half8_e_2020c();
i = half8_e_2021c();
i = half8_e_2022c();
i = half8_e_2023c();
i = half8_e_2024c();
i = half8_e_2775c();
i = half8_e_2776c();
i = half8_e_2777c();
i = half8_e_2778c();
i = half8_e_2779c();
i = half8_e_2780c();
i = half8_e_2781c();
i = half8_e_2782c();
i = half8_e_2783c();
i = half8_e_2784c();
i = half8_e_3535c();
i = half8_e_3536c();
i = half8_e_3537c();
i = half8_e_3538c();
i = half8_e_3539c();
i = half8_e_3540c();
i = half8_e_3541c();
i = half8_e_3542c();
i = half8_e_3543c();
i = half8_e_3544c();
i = half8_e_4295c();
i = half8_e_4296c();
i = half8_e_4297c();
i = half8_e_4298c();
i = half8_e_4299c();
i = half8_e_4300c();
i = half8_e_4301c();
i = half8_e_4302c();
i = half8_e_4303c();
i = half8_e_4304c();
i = half8_e_495c();
i = half8_e_496c();
i = half8_e_497c();
i = half8_e_498c();
i = half8_e_499c();
i = half8_e_500c();
i = half8_e_501c();
i = half8_e_502c();
i = half8_e_503c();
i = half8_e_504c();
i = half8_e_5055c();
i = half8_e_5056c();
i = half8_e_5057c();
i = half8_e_5058c();
i = half8_e_5059c();
i = half8_e_5060c();
i = half8_e_5061c();
i = half8_e_5062c();
i = half8_e_5063c();
i = half8_e_5064c();
i = half8_e_5815c();
i = half8_e_5816c();
i = half8_e_5817c();
i = half8_e_5818c();
i = half8_e_5819c();
i = half8_e_5820c();
i = half8_e_5821c();
i = half8_e_5822c();
i = half8_e_5823c();
i = half8_e_5824c();
i = half8_e_6575c();
i = half8_e_6576c();
i = half8_e_6577c();
i = half8_e_6578c();
i = half8_e_6579c();
i = half8_e_6580c();
i = half8_e_6581c();
i = half8_e_6582c();
i = half8_e_6583c();
i = half8_e_6584c();
i = half8_e_7335c();
i = half8_e_7336c();
i = half8_e_7337c();
i = half8_e_7338c();
i = half8_e_7339c();
i = half8_e_7340c();
i = half8_e_7341c();
i = half8_e_7342c();
i = half8_e_7343c();
i = half8_e_7344c();
i = half8_f_1265c();
i = half8_f_1266c();
i = half8_f_1267c();
i = half8_f_1268c();
i = half8_f_1269c();
i = half8_f_1270c();
i = half8_f_1271c();
i = half8_f_1272c();
i = half8_f_1273c();
i = half8_f_1274c();
i = half8_f_2025c();
i = half8_f_2026c();
i = half8_f_2027c();
i = half8_f_2028c();
i = half8_f_2029c();
i = half8_f_2030c();
i = half8_f_2031c();
i = half8_f_2032c();
i = half8_f_2033c();
i = half8_f_2034c();
i = half8_f_2785c();
i = half8_f_2786c();
i = half8_f_2787c();
i = half8_f_2788c();
i = half8_f_2789c();
i = half8_f_2790c();
i = half8_f_2791c();
i = half8_f_2792c();
i = half8_f_2793c();
i = half8_f_2794c();
i = half8_f_3545c();
i = half8_f_3546c();
i = half8_f_3547c();
i = half8_f_3548c();
i = half8_f_3549c();
i = half8_f_3550c();
i = half8_f_3551c();
i = half8_f_3552c();
i = half8_f_3553c();
i = half8_f_3554c();
i = half8_f_4305c();
i = half8_f_4306c();
i = half8_f_4307c();
i = half8_f_4308c();
i = half8_f_4309c();
i = half8_f_4310c();
i = half8_f_4311c();
i = half8_f_4312c();
i = half8_f_4313c();
i = half8_f_4314c();
i = half8_f_505c();
i = half8_f_506c();
i = half8_f_5065c();
i = half8_f_5066c();
i = half8_f_5067c();
i = half8_f_5068c();
i = half8_f_5069c();
i = half8_f_507c();
i = half8_f_5070c();
i = half8_f_5071c();
i = half8_f_5072c();
i = half8_f_5073c();
i = half8_f_5074c();
i = half8_f_508c();
i = half8_f_509c();
i = half8_f_510c();
i = half8_f_511c();
i = half8_f_512c();
i = half8_f_513c();
i = half8_f_514c();
i = half8_f_5825c();
i = half8_f_5826c();
i = half8_f_5827c();
i = half8_f_5828c();
i = half8_f_5829c();
i = half8_f_5830c();
i = half8_f_5831c();
i = half8_f_5832c();
i = half8_f_5833c();
i = half8_f_5834c();
i = half8_f_6585c();
i = half8_f_6586c();
i = half8_f_6587c();
i = half8_f_6588c();
i = half8_f_6589c();
i = half8_f_6590c();
i = half8_f_6591c();
i = half8_f_6592c();
i = half8_f_6593c();
i = half8_f_6594c();
i = half8_f_7345c();
i = half8_f_7346c();
i = half8_f_7347c();
i = half8_f_7348c();
i = half8_f_7349c();
i = half8_f_7350c();
i = half8_f_7351c();
i = half8_f_7352c();
i = half8_f_7353c();
i = half8_f_7354c();
i = half8_g_1275c();
i = half8_g_1276c();
i = half8_g_1277c();
i = half8_g_1278c();
i = half8_g_1279c();
i = half8_g_1280c();
i = half8_g_1281c();
i = half8_g_1282c();
i = half8_g_1283c();
i = half8_g_1284c();
i = half8_g_2035c();
i = half8_g_2036c();
i = half8_g_2037c();
i = half8_g_2038c();
i = half8_g_2039c();
i = half8_g_2040c();
i = half8_g_2041c();
i = half8_g_2042c();
i = half8_g_2043c();
i = half8_g_2044c();
i = half8_g_2795c();
i = half8_g_2796c();
i = half8_g_2797c();
i = half8_g_2798c();
i = half8_g_2799c();
i = half8_g_2800c();
i = half8_g_2801c();
i = half8_g_2802c();
i = half8_g_2803c();
i = half8_g_2804c();
i = half8_g_3555c();
i = half8_g_3556c();
i = half8_g_3557c();
i = half8_g_3558c();
i = half8_g_3559c();
i = half8_g_3560c();
i = half8_g_3561c();
i = half8_g_3562c();
i = half8_g_3563c();
i = half8_g_3564c();
i = half8_g_4315c();
i = half8_g_4316c();
i = half8_g_4317c();
i = half8_g_4318c();
i = half8_g_4319c();
i = half8_g_4320c();
i = half8_g_4321c();
i = half8_g_4322c();
i = half8_g_4323c();
i = half8_g_4324c();
i = half8_g_5075c();
i = half8_g_5076c();
i = half8_g_5077c();
i = half8_g_5078c();
i = half8_g_5079c();
i = half8_g_5080c();
i = half8_g_5081c();
i = half8_g_5082c();
i = half8_g_5083c();
i = half8_g_5084c();
i = half8_g_515c();
i = half8_g_516c();
i = half8_g_517c();
i = half8_g_518c();
i = half8_g_519c();
i = half8_g_520c();
i = half8_g_521c();
i = half8_g_522c();
i = half8_g_523c();
i = half8_g_524c();
i = half8_g_5835c();
i = half8_g_5836c();
i = half8_g_5837c();
i = half8_g_5838c();
i = half8_g_5839c();
i = half8_g_5840c();
i = half8_g_5841c();
i = half8_g_5842c();
i = half8_g_5843c();
i = half8_g_5844c();
i = half8_g_6595c();
i = half8_g_6596c();
i = half8_g_6597c();
i = half8_g_6598c();
i = half8_g_6599c();
i = half8_g_6600c();
i = half8_g_6601c();
i = half8_g_6602c();
i = half8_g_6603c();
i = half8_g_6604c();
i = half8_g_7355c();
i = half8_g_7356c();
i = half8_g_7357c();
i = half8_g_7358c();
i = half8_g_7359c();
i = half8_g_7360c();
i = half8_g_7361c();
i = half8_g_7362c();
i = half8_g_7363c();
i = half8_g_7364c();
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
