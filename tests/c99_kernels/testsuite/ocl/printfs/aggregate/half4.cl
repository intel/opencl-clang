/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/half4.c'  */

int half4_a_1101c() {
  // { dg-printf -re "half4_a_1101c===.*===.*===" }
  half4 var1 = (half4) (-6,7,-1,-8);
  half4 var2 = (half4) (-5,-2,-8,-6);
  int i = printf("half4_a_1101c===%-v4ha===%-v4ha===\n",var1,var2);
  return i;
}

int half4_a_1102c() {
  // { dg-printf -re "half4_a_1102c===.*===.*===" }
  half4 var1 = (half4) (6,7,4,-5);
  half4 var2 = (half4) (123445,-4,0,8);
  int i = printf("half4_a_1102c===%-.1v4ha===%-.1v4ha===\n",var1,var2);
  return i;
}

int half4_a_1103c() {
  // { dg-printf -re "half4_a_1103c===.*===.*===" }
  half4 var1 = (half4) (0,-2,-8,-3);
  half4 var2 = (half4) (1,5,-2,-123455);
  int i = printf("half4_a_1103c===%-.2v4ha===%-.2v4ha===\n",var1,var2);
  return i;
}

int half4_a_1104c() {
  // { dg-printf -re "half4_a_1104c===.*===.*===" }
  half4 var1 = (half4) (-2,-6,8,5);
  half4 var2 = (half4) (6,-6,2,5);
  int i = printf("half4_a_1104c===%-.3v4ha===%-.3v4ha===\n",var1,var2);
  return i;
}

int half4_a_1105c() {
  // { dg-printf -re "half4_a_1105c===.*===.*===" }
  half4 var1 = (half4) (0,-3,-123455,123445);
  half4 var2 = (half4) (7,7,-3,-1);
  int i = printf("half4_a_1105c===%-.10v4ha===%-.10v4ha===\n",var1,var2);
  return i;
}

int half4_a_1106c() {
  // { dg-printf -re "half4_a_1106c===.*===.*===" }
  half4 var1 = (half4) (2,3,-3,3);
  half4 var2 = (half4) (-6,8,-2,-6);
  int i = printf("half4_a_1106c===%-v4hA===%-v4hA===\n",var1,var2);
  return i;
}

int half4_a_1107c() {
  // { dg-printf -re "half4_a_1107c===.*===.*===" }
  half4 var1 = (half4) (-7,123445,-1,-1);
  half4 var2 = (half4) (-4,-8,-123455,-8);
  int i = printf("half4_a_1107c===%-.1v4hA===%-.1v4hA===\n",var1,var2);
  return i;
}

int half4_a_1108c() {
  // { dg-printf -re "half4_a_1108c===.*===.*===" }
  half4 var1 = (half4) (-2,0,-2,1);
  half4 var2 = (half4) (7,-2,-2,-4);
  int i = printf("half4_a_1108c===%-.2v4hA===%-.2v4hA===\n",var1,var2);
  return i;
}

int half4_a_1109c() {
  // { dg-printf -re "half4_a_1109c===.*===.*===" }
  half4 var1 = (half4) (-3,123445,5,0);
  half4 var2 = (half4) (7,2,4,-4);
  int i = printf("half4_a_1109c===%-.3v4hA===%-.3v4hA===\n",var1,var2);
  return i;
}

int half4_a_1110c() {
  // { dg-printf -re "half4_a_1110c===.*===.*===" }
  half4 var1 = (half4) (6,-2,1,-8);
  half4 var2 = (half4) (2,1,-1,6);
  int i = printf("half4_a_1110c===%-.10v4hA===%-.10v4hA===\n",var1,var2);
  return i;
}

int half4_a_1861c() {
  // { dg-printf -re "half4_a_1861c===.*===.*===" }
  half4 var1 = (half4) (-2,0,1,123445);
  half4 var2 = (half4) (4,-3,-5,-3);
  int i = printf("half4_a_1861c===%+v4ha===%+v4ha===\n",var1,var2);
  return i;
}

int half4_a_1862c() {
  // { dg-printf -re "half4_a_1862c===.*===.*===" }
  half4 var1 = (half4) (-6,5,8,7);
  half4 var2 = (half4) (-3,4,7,123445);
  int i = printf("half4_a_1862c===%+.1v4ha===%+.1v4ha===\n",var1,var2);
  return i;
}

int half4_a_1863c() {
  // { dg-printf -re "half4_a_1863c===.*===.*===" }
  half4 var1 = (half4) (-7,2,-3,-123455);
  half4 var2 = (half4) (-2,-6,-5,-8);
  int i = printf("half4_a_1863c===%+.2v4ha===%+.2v4ha===\n",var1,var2);
  return i;
}

int half4_a_1864c() {
  // { dg-printf -re "half4_a_1864c===.*===.*===" }
  half4 var1 = (half4) (-1,-7,3,-123455);
  half4 var2 = (half4) (-4,8,-6,5);
  int i = printf("half4_a_1864c===%+.3v4ha===%+.3v4ha===\n",var1,var2);
  return i;
}

int half4_a_1865c() {
  // { dg-printf -re "half4_a_1865c===.*===.*===" }
  half4 var1 = (half4) (5,-7,123445,7);
  half4 var2 = (half4) (-7,1,-5,6);
  int i = printf("half4_a_1865c===%+.10v4ha===%+.10v4ha===\n",var1,var2);
  return i;
}

int half4_a_1866c() {
  // { dg-printf -re "half4_a_1866c===.*===.*===" }
  half4 var1 = (half4) (-1,6,-1,123445);
  half4 var2 = (half4) (-3,8,-3,7);
  int i = printf("half4_a_1866c===%+v4hA===%+v4hA===\n",var1,var2);
  return i;
}

int half4_a_1867c() {
  // { dg-printf -re "half4_a_1867c===.*===.*===" }
  half4 var1 = (half4) (-1,1,7,7);
  half4 var2 = (half4) (-5,0,7,123445);
  int i = printf("half4_a_1867c===%+.1v4hA===%+.1v4hA===\n",var1,var2);
  return i;
}

int half4_a_1868c() {
  // { dg-printf -re "half4_a_1868c===.*===.*===" }
  half4 var1 = (half4) (1,-123455,-6,4);
  half4 var2 = (half4) (5,-5,-7,0);
  int i = printf("half4_a_1868c===%+.2v4hA===%+.2v4hA===\n",var1,var2);
  return i;
}

int half4_a_1869c() {
  // { dg-printf -re "half4_a_1869c===.*===.*===" }
  half4 var1 = (half4) (7,-3,-2,7);
  half4 var2 = (half4) (8,-4,1,4);
  int i = printf("half4_a_1869c===%+.3v4hA===%+.3v4hA===\n",var1,var2);
  return i;
}

int half4_a_1870c() {
  // { dg-printf -re "half4_a_1870c===.*===.*===" }
  half4 var1 = (half4) (123445,-123455,-123455,4);
  half4 var2 = (half4) (4,8,7,4);
  int i = printf("half4_a_1870c===%+.10v4hA===%+.10v4hA===\n",var1,var2);
  return i;
}

int half4_a_2621c() {
  // { dg-printf -re "half4_a_2621c===.*===.*===" }
  half4 var1 = (half4) (-1,-123455,1,-123455);
  half4 var2 = (half4) (-6,6,-7,-8);
  int i = printf("half4_a_2621c===%#v4ha===%#v4ha===\n",var1,var2);
  return i;
}

int half4_a_2622c() {
  // { dg-printf -re "half4_a_2622c===.*===.*===" }
  half4 var1 = (half4) (1,1,-2,4);
  half4 var2 = (half4) (123445,0,1,-5);
  int i = printf("half4_a_2622c===%#.1v4ha===%#.1v4ha===\n",var1,var2);
  return i;
}

int half4_a_2623c() {
  // { dg-printf -re "half4_a_2623c===.*===.*===" }
  half4 var1 = (half4) (-8,6,7,8);
  half4 var2 = (half4) (123445,1,-5,-7);
  int i = printf("half4_a_2623c===%#.2v4ha===%#.2v4ha===\n",var1,var2);
  return i;
}

int half4_a_2624c() {
  // { dg-printf -re "half4_a_2624c===.*===.*===" }
  half4 var1 = (half4) (5,4,-4,-5);
  half4 var2 = (half4) (1,-8,7,-8);
  int i = printf("half4_a_2624c===%#.3v4ha===%#.3v4ha===\n",var1,var2);
  return i;
}

int half4_a_2625c() {
  // { dg-printf -re "half4_a_2625c===.*===.*===" }
  half4 var1 = (half4) (-5,2,1,-7);
  half4 var2 = (half4) (-8,-1,-3,-4);
  int i = printf("half4_a_2625c===%#.10v4ha===%#.10v4ha===\n",var1,var2);
  return i;
}

int half4_a_2626c() {
  // { dg-printf -re "half4_a_2626c===.*===.*===" }
  half4 var1 = (half4) (8,-5,8,-8);
  half4 var2 = (half4) (-123455,-2,1,3);
  int i = printf("half4_a_2626c===%#v4hA===%#v4hA===\n",var1,var2);
  return i;
}

int half4_a_2627c() {
  // { dg-printf -re "half4_a_2627c===.*===.*===" }
  half4 var1 = (half4) (-5,-4,4,-4);
  half4 var2 = (half4) (5,1,2,3);
  int i = printf("half4_a_2627c===%#.1v4hA===%#.1v4hA===\n",var1,var2);
  return i;
}

int half4_a_2628c() {
  // { dg-printf -re "half4_a_2628c===.*===.*===" }
  half4 var1 = (half4) (5,-6,-7,4);
  half4 var2 = (half4) (-4,-7,-1,6);
  int i = printf("half4_a_2628c===%#.2v4hA===%#.2v4hA===\n",var1,var2);
  return i;
}

int half4_a_2629c() {
  // { dg-printf -re "half4_a_2629c===.*===.*===" }
  half4 var1 = (half4) (2,7,-8,-2);
  half4 var2 = (half4) (5,-3,-6,6);
  int i = printf("half4_a_2629c===%#.3v4hA===%#.3v4hA===\n",var1,var2);
  return i;
}

int half4_a_2630c() {
  // { dg-printf -re "half4_a_2630c===.*===.*===" }
  half4 var1 = (half4) (123445,3,1,123445);
  half4 var2 = (half4) (1,-2,123445,-3);
  int i = printf("half4_a_2630c===%#.10v4hA===%#.10v4hA===\n",var1,var2);
  return i;
}

int half4_a_3381c() {
  // { dg-printf -re "half4_a_3381c===.*===.*===" }
  half4 var1 = (half4) (-5,-4,1,2);
  half4 var2 = (half4) (-1,0,4,-6);
  int i = printf("half4_a_3381c===%-+v4ha===%-+v4ha===\n",var1,var2);
  return i;
}

int half4_a_3382c() {
  // { dg-printf -re "half4_a_3382c===.*===.*===" }
  half4 var1 = (half4) (1,-123455,3,3);
  half4 var2 = (half4) (4,-3,-6,7);
  int i = printf("half4_a_3382c===%-+.1v4ha===%-+.1v4ha===\n",var1,var2);
  return i;
}

int half4_a_3383c() {
  // { dg-printf -re "half4_a_3383c===.*===.*===" }
  half4 var1 = (half4) (8,123445,-1,-7);
  half4 var2 = (half4) (-2,2,-123455,123445);
  int i = printf("half4_a_3383c===%-+.2v4ha===%-+.2v4ha===\n",var1,var2);
  return i;
}

int half4_a_3384c() {
  // { dg-printf -re "half4_a_3384c===.*===.*===" }
  half4 var1 = (half4) (8,1,-5,1);
  half4 var2 = (half4) (-7,8,-6,7);
  int i = printf("half4_a_3384c===%-+.3v4ha===%-+.3v4ha===\n",var1,var2);
  return i;
}

int half4_a_3385c() {
  // { dg-printf -re "half4_a_3385c===.*===.*===" }
  half4 var1 = (half4) (7,7,0,-8);
  half4 var2 = (half4) (0,-6,-6,6);
  int i = printf("half4_a_3385c===%-+.10v4ha===%-+.10v4ha===\n",var1,var2);
  return i;
}

int half4_a_3386c() {
  // { dg-printf -re "half4_a_3386c===.*===.*===" }
  half4 var1 = (half4) (-3,5,2,0);
  half4 var2 = (half4) (1,6,123445,-2);
  int i = printf("half4_a_3386c===%-+v4hA===%-+v4hA===\n",var1,var2);
  return i;
}

int half4_a_3387c() {
  // { dg-printf -re "half4_a_3387c===.*===.*===" }
  half4 var1 = (half4) (4,-1,1,-3);
  half4 var2 = (half4) (-123455,3,123445,4);
  int i = printf("half4_a_3387c===%-+.1v4hA===%-+.1v4hA===\n",var1,var2);
  return i;
}

int half4_a_3388c() {
  // { dg-printf -re "half4_a_3388c===.*===.*===" }
  half4 var1 = (half4) (-7,-5,-123455,7);
  half4 var2 = (half4) (5,0,4,-123455);
  int i = printf("half4_a_3388c===%-+.2v4hA===%-+.2v4hA===\n",var1,var2);
  return i;
}

int half4_a_3389c() {
  // { dg-printf -re "half4_a_3389c===.*===.*===" }
  half4 var1 = (half4) (-4,0,-2,3);
  half4 var2 = (half4) (2,-123455,8,2);
  int i = printf("half4_a_3389c===%-+.3v4hA===%-+.3v4hA===\n",var1,var2);
  return i;
}

int half4_a_3390c() {
  // { dg-printf -re "half4_a_3390c===.*===.*===" }
  half4 var1 = (half4) (5,-5,2,-7);
  half4 var2 = (half4) (7,-8,-2,-1);
  int i = printf("half4_a_3390c===%-+.10v4hA===%-+.10v4hA===\n",var1,var2);
  return i;
}

int half4_a_341c() {
  // { dg-printf -re "half4_a_341c===.*===.*===" }
  half4 var1 = (half4) (-4,-4,123445,-123455);
  half4 var2 = (half4) (-5,5,0,1);
  int i = printf("half4_a_341c===%v4ha===%v4ha===\n",var1,var2);
  return i;
}

int half4_a_342c() {
  // { dg-printf -re "half4_a_342c===.*===.*===" }
  half4 var1 = (half4) (5,4,0,-3);
  half4 var2 = (half4) (0,-3,-8,-5);
  int i = printf("half4_a_342c===%.1v4ha===%.1v4ha===\n",var1,var2);
  return i;
}

int half4_a_343c() {
  // { dg-printf -re "half4_a_343c===.*===.*===" }
  half4 var1 = (half4) (6,0,0,7);
  half4 var2 = (half4) (-1,-2,4,-4);
  int i = printf("half4_a_343c===%.2v4ha===%.2v4ha===\n",var1,var2);
  return i;
}

int half4_a_344c() {
  // { dg-printf -re "half4_a_344c===.*===.*===" }
  half4 var1 = (half4) (6,-5,-2,1);
  half4 var2 = (half4) (5,5,123445,-123455);
  int i = printf("half4_a_344c===%.3v4ha===%.3v4ha===\n",var1,var2);
  return i;
}

int half4_a_345c() {
  // { dg-printf -re "half4_a_345c===.*===.*===" }
  half4 var1 = (half4) (123445,4,-1,-5);
  half4 var2 = (half4) (-2,4,-2,6);
  int i = printf("half4_a_345c===%.10v4ha===%.10v4ha===\n",var1,var2);
  return i;
}

int half4_a_346c() {
  // { dg-printf -re "half4_a_346c===.*===.*===" }
  half4 var1 = (half4) (-1,6,8,0);
  half4 var2 = (half4) (0,-2,-6,-1);
  int i = printf("half4_a_346c===%v4hA===%v4hA===\n",var1,var2);
  return i;
}

int half4_a_347c() {
  // { dg-printf -re "half4_a_347c===.*===.*===" }
  half4 var1 = (half4) (-6,-2,-1,4);
  half4 var2 = (half4) (0,-8,-6,-7);
  int i = printf("half4_a_347c===%.1v4hA===%.1v4hA===\n",var1,var2);
  return i;
}

int half4_a_348c() {
  // { dg-printf -re "half4_a_348c===.*===.*===" }
  half4 var1 = (half4) (-8,5,123445,4);
  half4 var2 = (half4) (-5,7,1,-2);
  int i = printf("half4_a_348c===%.2v4hA===%.2v4hA===\n",var1,var2);
  return i;
}

int half4_a_349c() {
  // { dg-printf -re "half4_a_349c===.*===.*===" }
  half4 var1 = (half4) (5,-2,6,-1);
  half4 var2 = (half4) (-2,-1,4,1);
  int i = printf("half4_a_349c===%.3v4hA===%.3v4hA===\n",var1,var2);
  return i;
}

int half4_a_350c() {
  // { dg-printf -re "half4_a_350c===.*===.*===" }
  half4 var1 = (half4) (2,-2,8,-5);
  half4 var2 = (half4) (-3,-3,-3,-7);
  int i = printf("half4_a_350c===%.10v4hA===%.10v4hA===\n",var1,var2);
  return i;
}

int half4_a_4141c() {
  // { dg-printf -re "half4_a_4141c===.*===.*===" }
  half4 var1 = (half4) (0,-7,4,8);
  half4 var2 = (half4) (8,-4,-123455,-7);
  int i = printf("half4_a_4141c===% 10v4ha===% 10v4ha===\n",var1,var2);
  return i;
}

int half4_a_4142c() {
  // { dg-printf -re "half4_a_4142c===.*===.*===" }
  half4 var1 = (half4) (0,4,-3,0);
  half4 var2 = (half4) (-8,4,-7,4);
  int i = printf("half4_a_4142c===% 10.1v4ha===% 10.1v4ha===\n",var1,var2);
  return i;
}

int half4_a_4143c() {
  // { dg-printf -re "half4_a_4143c===.*===.*===" }
  half4 var1 = (half4) (-5,123445,-3,-5);
  half4 var2 = (half4) (4,2,4,-3);
  int i = printf("half4_a_4143c===% 10.2v4ha===% 10.2v4ha===\n",var1,var2);
  return i;
}

int half4_a_4144c() {
  // { dg-printf -re "half4_a_4144c===.*===.*===" }
  half4 var1 = (half4) (-3,3,0,0);
  half4 var2 = (half4) (-4,-2,-7,-6);
  int i = printf("half4_a_4144c===% 10.3v4ha===% 10.3v4ha===\n",var1,var2);
  return i;
}

int half4_a_4145c() {
  // { dg-printf -re "half4_a_4145c===.*===.*===" }
  half4 var1 = (half4) (-5,2,8,-6);
  half4 var2 = (half4) (7,-5,6,0);
  int i = printf("half4_a_4145c===% 10.10v4ha===% 10.10v4ha===\n",var1,var2);
  return i;
}

int half4_a_4146c() {
  // { dg-printf -re "half4_a_4146c===.*===.*===" }
  half4 var1 = (half4) (8,6,6,-6);
  half4 var2 = (half4) (-3,6,8,8);
  int i = printf("half4_a_4146c===% 10v4hA===% 10v4hA===\n",var1,var2);
  return i;
}

int half4_a_4147c() {
  // { dg-printf -re "half4_a_4147c===.*===.*===" }
  half4 var1 = (half4) (-1,8,123445,1);
  half4 var2 = (half4) (-7,-3,-7,-3);
  int i = printf("half4_a_4147c===% 10.1v4hA===% 10.1v4hA===\n",var1,var2);
  return i;
}

int half4_a_4148c() {
  // { dg-printf -re "half4_a_4148c===.*===.*===" }
  half4 var1 = (half4) (7,8,-2,8);
  half4 var2 = (half4) (-6,6,8,4);
  int i = printf("half4_a_4148c===% 10.2v4hA===% 10.2v4hA===\n",var1,var2);
  return i;
}

int half4_a_4149c() {
  // { dg-printf -re "half4_a_4149c===.*===.*===" }
  half4 var1 = (half4) (8,-123455,-3,-2);
  half4 var2 = (half4) (3,3,0,-3);
  int i = printf("half4_a_4149c===% 10.3v4hA===% 10.3v4hA===\n",var1,var2);
  return i;
}

int half4_a_4150c() {
  // { dg-printf -re "half4_a_4150c===.*===.*===" }
  half4 var1 = (half4) (7,-5,6,-6);
  half4 var2 = (half4) (6,1,-3,5);
  int i = printf("half4_a_4150c===% 10.10v4hA===% 10.10v4hA===\n",var1,var2);
  return i;
}

int half4_a_4901c() {
  // { dg-printf -re "half4_a_4901c===.*===.*===" }
  half4 var1 = (half4) (6,5,1,-1);
  half4 var2 = (half4) (123445,5,1,-3);
  int i = printf("half4_a_4901c===%010v4ha===%010v4ha===\n",var1,var2);
  return i;
}

int half4_a_4902c() {
  // { dg-printf -re "half4_a_4902c===.*===.*===" }
  half4 var1 = (half4) (6,-2,-3,-2);
  half4 var2 = (half4) (-5,-5,123445,7);
  int i = printf("half4_a_4902c===%010.1v4ha===%010.1v4ha===\n",var1,var2);
  return i;
}

int half4_a_4903c() {
  // { dg-printf -re "half4_a_4903c===.*===.*===" }
  half4 var1 = (half4) (0,1,-1,-123455);
  half4 var2 = (half4) (-123455,5,-123455,1);
  int i = printf("half4_a_4903c===%010.2v4ha===%010.2v4ha===\n",var1,var2);
  return i;
}

int half4_a_4904c() {
  // { dg-printf -re "half4_a_4904c===.*===.*===" }
  half4 var1 = (half4) (-2,1,0,-123455);
  half4 var2 = (half4) (0,-2,-5,-4);
  int i = printf("half4_a_4904c===%010.3v4ha===%010.3v4ha===\n",var1,var2);
  return i;
}

int half4_a_4905c() {
  // { dg-printf -re "half4_a_4905c===.*===.*===" }
  half4 var1 = (half4) (5,-6,-6,-5);
  half4 var2 = (half4) (-3,5,2,-1);
  int i = printf("half4_a_4905c===%010.10v4ha===%010.10v4ha===\n",var1,var2);
  return i;
}

int half4_a_4906c() {
  // { dg-printf -re "half4_a_4906c===.*===.*===" }
  half4 var1 = (half4) (-123455,-123455,6,-2);
  half4 var2 = (half4) (-2,-8,-3,2);
  int i = printf("half4_a_4906c===%010v4hA===%010v4hA===\n",var1,var2);
  return i;
}

int half4_a_4907c() {
  // { dg-printf -re "half4_a_4907c===.*===.*===" }
  half4 var1 = (half4) (7,-4,8,0);
  half4 var2 = (half4) (-7,-4,-4,-6);
  int i = printf("half4_a_4907c===%010.1v4hA===%010.1v4hA===\n",var1,var2);
  return i;
}

int half4_a_4908c() {
  // { dg-printf -re "half4_a_4908c===.*===.*===" }
  half4 var1 = (half4) (2,-7,8,-1);
  half4 var2 = (half4) (-7,-7,8,4);
  int i = printf("half4_a_4908c===%010.2v4hA===%010.2v4hA===\n",var1,var2);
  return i;
}

int half4_a_4909c() {
  // { dg-printf -re "half4_a_4909c===.*===.*===" }
  half4 var1 = (half4) (8,-123455,-7,-8);
  half4 var2 = (half4) (-123455,-4,5,1);
  int i = printf("half4_a_4909c===%010.3v4hA===%010.3v4hA===\n",var1,var2);
  return i;
}

int half4_a_4910c() {
  // { dg-printf -re "half4_a_4910c===.*===.*===" }
  half4 var1 = (half4) (1,-6,1,-4);
  half4 var2 = (half4) (123445,-5,123445,5);
  int i = printf("half4_a_4910c===%010.10v4hA===%010.10v4hA===\n",var1,var2);
  return i;
}

int half4_a_5661c() {
  // { dg-printf -re "half4_a_5661c===.*===.*===" }
  half4 var1 = (half4) (-5,5,3,-7);
  half4 var2 = (half4) (7,5,-123455,-7);
  int i = printf("half4_a_5661c===%- 10v4ha===%- 10v4ha===\n",var1,var2);
  return i;
}

int half4_a_5662c() {
  // { dg-printf -re "half4_a_5662c===.*===.*===" }
  half4 var1 = (half4) (3,-3,123445,5);
  half4 var2 = (half4) (-5,7,-8,-4);
  int i = printf("half4_a_5662c===%- 10.1v4ha===%- 10.1v4ha===\n",var1,var2);
  return i;
}

int half4_a_5663c() {
  // { dg-printf -re "half4_a_5663c===.*===.*===" }
  half4 var1 = (half4) (-2,8,-123455,-4);
  half4 var2 = (half4) (3,-1,-1,-5);
  int i = printf("half4_a_5663c===%- 10.2v4ha===%- 10.2v4ha===\n",var1,var2);
  return i;
}

int half4_a_5664c() {
  // { dg-printf -re "half4_a_5664c===.*===.*===" }
  half4 var1 = (half4) (-7,-5,-3,-3);
  half4 var2 = (half4) (3,-5,4,-3);
  int i = printf("half4_a_5664c===%- 10.3v4ha===%- 10.3v4ha===\n",var1,var2);
  return i;
}

int half4_a_5665c() {
  // { dg-printf -re "half4_a_5665c===.*===.*===" }
  half4 var1 = (half4) (123445,7,123445,2);
  half4 var2 = (half4) (-8,-8,7,-5);
  int i = printf("half4_a_5665c===%- 10.10v4ha===%- 10.10v4ha===\n",var1,var2);
  return i;
}

int half4_a_5666c() {
  // { dg-printf -re "half4_a_5666c===.*===.*===" }
  half4 var1 = (half4) (-2,-1,-2,-7);
  half4 var2 = (half4) (5,0,2,2);
  int i = printf("half4_a_5666c===%- 10v4hA===%- 10v4hA===\n",var1,var2);
  return i;
}

int half4_a_5667c() {
  // { dg-printf -re "half4_a_5667c===.*===.*===" }
  half4 var1 = (half4) (2,-2,-6,-5);
  half4 var2 = (half4) (-5,-4,-6,-2);
  int i = printf("half4_a_5667c===%- 10.1v4hA===%- 10.1v4hA===\n",var1,var2);
  return i;
}

int half4_a_5668c() {
  // { dg-printf -re "half4_a_5668c===.*===.*===" }
  half4 var1 = (half4) (-3,4,-4,6);
  half4 var2 = (half4) (6,-123455,2,2);
  int i = printf("half4_a_5668c===%- 10.2v4hA===%- 10.2v4hA===\n",var1,var2);
  return i;
}

int half4_a_5669c() {
  // { dg-printf -re "half4_a_5669c===.*===.*===" }
  half4 var1 = (half4) (2,-123455,8,-7);
  half4 var2 = (half4) (-1,-123455,-2,1);
  int i = printf("half4_a_5669c===%- 10.3v4hA===%- 10.3v4hA===\n",var1,var2);
  return i;
}

int half4_a_5670c() {
  // { dg-printf -re "half4_a_5670c===.*===.*===" }
  half4 var1 = (half4) (-8,6,-7,8);
  half4 var2 = (half4) (3,4,3,2);
  int i = printf("half4_a_5670c===%- 10.10v4hA===%- 10.10v4hA===\n",var1,var2);
  return i;
}

int half4_a_6421c() {
  // { dg-printf -re "half4_a_6421c===.*===.*===" }
  half4 var1 = (half4) (5,7,-2,3);
  half4 var2 = (half4) (123445,-4,1,-7);
  int i = printf("half4_a_6421c===%+ 10v4ha===%+ 10v4ha===\n",var1,var2);
  return i;
}

int half4_a_6422c() {
  // { dg-printf -re "half4_a_6422c===.*===.*===" }
  half4 var1 = (half4) (5,-1,-8,0);
  half4 var2 = (half4) (-5,3,-8,5);
  int i = printf("half4_a_6422c===%+ 10.1v4ha===%+ 10.1v4ha===\n",var1,var2);
  return i;
}

int half4_a_6423c() {
  // { dg-printf -re "half4_a_6423c===.*===.*===" }
  half4 var1 = (half4) (5,4,-6,8);
  half4 var2 = (half4) (-1,-8,8,3);
  int i = printf("half4_a_6423c===%+ 10.2v4ha===%+ 10.2v4ha===\n",var1,var2);
  return i;
}

int half4_a_6424c() {
  // { dg-printf -re "half4_a_6424c===.*===.*===" }
  half4 var1 = (half4) (-6,-2,1,-123455);
  half4 var2 = (half4) (-2,-1,-7,5);
  int i = printf("half4_a_6424c===%+ 10.3v4ha===%+ 10.3v4ha===\n",var1,var2);
  return i;
}

int half4_a_6425c() {
  // { dg-printf -re "half4_a_6425c===.*===.*===" }
  half4 var1 = (half4) (5,-7,8,0);
  half4 var2 = (half4) (3,-2,-1,-3);
  int i = printf("half4_a_6425c===%+ 10.10v4ha===%+ 10.10v4ha===\n",var1,var2);
  return i;
}

int half4_a_6426c() {
  // { dg-printf -re "half4_a_6426c===.*===.*===" }
  half4 var1 = (half4) (-8,-3,-7,-5);
  half4 var2 = (half4) (1,-123455,4,6);
  int i = printf("half4_a_6426c===%+ 10v4hA===%+ 10v4hA===\n",var1,var2);
  return i;
}

int half4_a_6427c() {
  // { dg-printf -re "half4_a_6427c===.*===.*===" }
  half4 var1 = (half4) (2,-8,-1,-5);
  half4 var2 = (half4) (4,8,-2,4);
  int i = printf("half4_a_6427c===%+ 10.1v4hA===%+ 10.1v4hA===\n",var1,var2);
  return i;
}

int half4_a_6428c() {
  // { dg-printf -re "half4_a_6428c===.*===.*===" }
  half4 var1 = (half4) (123445,3,-1,0);
  half4 var2 = (half4) (7,7,-123455,-1);
  int i = printf("half4_a_6428c===%+ 10.2v4hA===%+ 10.2v4hA===\n",var1,var2);
  return i;
}

int half4_a_6429c() {
  // { dg-printf -re "half4_a_6429c===.*===.*===" }
  half4 var1 = (half4) (-7,-4,-7,-7);
  half4 var2 = (half4) (-4,0,-5,123445);
  int i = printf("half4_a_6429c===%+ 10.3v4hA===%+ 10.3v4hA===\n",var1,var2);
  return i;
}

int half4_a_6430c() {
  // { dg-printf -re "half4_a_6430c===.*===.*===" }
  half4 var1 = (half4) (5,5,1,5);
  half4 var2 = (half4) (-2,-7,-5,-3);
  int i = printf("half4_a_6430c===%+ 10.10v4hA===%+ 10.10v4hA===\n",var1,var2);
  return i;
}

int half4_a_7181c() {
  // { dg-printf -re "half4_a_7181c===.*===.*===" }
  half4 var1 = (half4) (123445,1,-5,-6);
  half4 var2 = (half4) (-4,1,-2,-6);
  int i = printf("half4_a_7181c===%+010v4ha===%+010v4ha===\n",var1,var2);
  return i;
}

int half4_a_7182c() {
  // { dg-printf -re "half4_a_7182c===.*===.*===" }
  half4 var1 = (half4) (0,3,6,2);
  half4 var2 = (half4) (-6,-6,-5,-7);
  int i = printf("half4_a_7182c===%+010.1v4ha===%+010.1v4ha===\n",var1,var2);
  return i;
}

int half4_a_7183c() {
  // { dg-printf -re "half4_a_7183c===.*===.*===" }
  half4 var1 = (half4) (0,-1,5,-5);
  half4 var2 = (half4) (-4,-2,-3,-8);
  int i = printf("half4_a_7183c===%+010.2v4ha===%+010.2v4ha===\n",var1,var2);
  return i;
}

int half4_a_7184c() {
  // { dg-printf -re "half4_a_7184c===.*===.*===" }
  half4 var1 = (half4) (-8,-2,-8,3);
  half4 var2 = (half4) (123445,0,-1,-6);
  int i = printf("half4_a_7184c===%+010.3v4ha===%+010.3v4ha===\n",var1,var2);
  return i;
}

int half4_a_7185c() {
  // { dg-printf -re "half4_a_7185c===.*===.*===" }
  half4 var1 = (half4) (-3,-5,-1,-6);
  half4 var2 = (half4) (-5,-4,5,123445);
  int i = printf("half4_a_7185c===%+010.10v4ha===%+010.10v4ha===\n",var1,var2);
  return i;
}

int half4_a_7186c() {
  // { dg-printf -re "half4_a_7186c===.*===.*===" }
  half4 var1 = (half4) (8,7,5,6);
  half4 var2 = (half4) (5,6,1,0);
  int i = printf("half4_a_7186c===%+010v4hA===%+010v4hA===\n",var1,var2);
  return i;
}

int half4_a_7187c() {
  // { dg-printf -re "half4_a_7187c===.*===.*===" }
  half4 var1 = (half4) (123445,6,0,1);
  half4 var2 = (half4) (-3,-6,-2,8);
  int i = printf("half4_a_7187c===%+010.1v4hA===%+010.1v4hA===\n",var1,var2);
  return i;
}

int half4_a_7188c() {
  // { dg-printf -re "half4_a_7188c===.*===.*===" }
  half4 var1 = (half4) (-4,-6,123445,-123455);
  half4 var2 = (half4) (-123455,-7,4,-6);
  int i = printf("half4_a_7188c===%+010.2v4hA===%+010.2v4hA===\n",var1,var2);
  return i;
}

int half4_a_7189c() {
  // { dg-printf -re "half4_a_7189c===.*===.*===" }
  half4 var1 = (half4) (3,4,6,-7);
  half4 var2 = (half4) (2,123445,8,-2);
  int i = printf("half4_a_7189c===%+010.3v4hA===%+010.3v4hA===\n",var1,var2);
  return i;
}

int half4_a_7190c() {
  // { dg-printf -re "half4_a_7190c===.*===.*===" }
  half4 var1 = (half4) (-5,2,-7,-6);
  half4 var2 = (half4) (6,-3,5,-1);
  int i = printf("half4_a_7190c===%+010.10v4hA===%+010.10v4hA===\n",var1,var2);
  return i;
}

int half4_e_1111c() {
  // { dg-printf -re "half4_e_1111c===.*===.*===" }
  half4 var1 = (half4) (-3,-4,-1,0);
  half4 var2 = (half4) (-2,5,0,8);
  int i = printf("half4_e_1111c===%-v4he===%-v4he===\n",var1,var2);
  return i;
}

int half4_e_1112c() {
  // { dg-printf -re "half4_e_1112c===.*===.*===" }
  half4 var1 = (half4) (6,-4,-3,2);
  half4 var2 = (half4) (1,-8,1,4);
  int i = printf("half4_e_1112c===%-.1v4he===%-.1v4he===\n",var1,var2);
  return i;
}

int half4_e_1113c() {
  // { dg-printf -re "half4_e_1113c===.*===.*===" }
  half4 var1 = (half4) (-6,6,-123455,-4);
  half4 var2 = (half4) (7,-6,4,5);
  int i = printf("half4_e_1113c===%-.2v4he===%-.2v4he===\n",var1,var2);
  return i;
}

int half4_e_1114c() {
  // { dg-printf -re "half4_e_1114c===.*===.*===" }
  half4 var1 = (half4) (-5,4,-8,7);
  half4 var2 = (half4) (5,3,1,-5);
  int i = printf("half4_e_1114c===%-.3v4he===%-.3v4he===\n",var1,var2);
  return i;
}

int half4_e_1115c() {
  // { dg-printf -re "half4_e_1115c===.*===.*===" }
  half4 var1 = (half4) (-123455,-8,-1,-8);
  half4 var2 = (half4) (7,4,-2,-5);
  int i = printf("half4_e_1115c===%-.10v4he===%-.10v4he===\n",var1,var2);
  return i;
}

int half4_e_1116c() {
  // { dg-printf -re "half4_e_1116c===.*===.*===" }
  half4 var1 = (half4) (2,3,123445,123445);
  half4 var2 = (half4) (-3,7,1,123445);
  int i = printf("half4_e_1116c===%-v4hE===%-v4hE===\n",var1,var2);
  return i;
}

int half4_e_1117c() {
  // { dg-printf -re "half4_e_1117c===.*===.*===" }
  half4 var1 = (half4) (-6,8,-4,-8);
  half4 var2 = (half4) (-2,5,2,-4);
  int i = printf("half4_e_1117c===%-.1v4hE===%-.1v4hE===\n",var1,var2);
  return i;
}

int half4_e_1118c() {
  // { dg-printf -re "half4_e_1118c===.*===.*===" }
  half4 var1 = (half4) (2,2,-6,4);
  half4 var2 = (half4) (0,-123455,-8,-123455);
  int i = printf("half4_e_1118c===%-.2v4hE===%-.2v4hE===\n",var1,var2);
  return i;
}

int half4_e_1119c() {
  // { dg-printf -re "half4_e_1119c===.*===.*===" }
  half4 var1 = (half4) (6,-8,-123455,-4);
  half4 var2 = (half4) (-123455,-8,-4,2);
  int i = printf("half4_e_1119c===%-.3v4hE===%-.3v4hE===\n",var1,var2);
  return i;
}

int half4_e_1120c() {
  // { dg-printf -re "half4_e_1120c===.*===.*===" }
  half4 var1 = (half4) (7,-5,2,123445);
  half4 var2 = (half4) (5,2,-4,-123455);
  int i = printf("half4_e_1120c===%-.10v4hE===%-.10v4hE===\n",var1,var2);
  return i;
}

int half4_e_1871c() {
  // { dg-printf -re "half4_e_1871c===.*===.*===" }
  half4 var1 = (half4) (4,-1,0,5);
  half4 var2 = (half4) (123445,0,-5,1);
  int i = printf("half4_e_1871c===%+v4he===%+v4he===\n",var1,var2);
  return i;
}

int half4_e_1872c() {
  // { dg-printf -re "half4_e_1872c===.*===.*===" }
  half4 var1 = (half4) (7,-3,4,0);
  half4 var2 = (half4) (6,-1,3,0);
  int i = printf("half4_e_1872c===%+.1v4he===%+.1v4he===\n",var1,var2);
  return i;
}

int half4_e_1873c() {
  // { dg-printf -re "half4_e_1873c===.*===.*===" }
  half4 var1 = (half4) (-2,-2,7,1);
  half4 var2 = (half4) (-123455,5,-1,-3);
  int i = printf("half4_e_1873c===%+.2v4he===%+.2v4he===\n",var1,var2);
  return i;
}

int half4_e_1874c() {
  // { dg-printf -re "half4_e_1874c===.*===.*===" }
  half4 var1 = (half4) (-8,3,5,-1);
  half4 var2 = (half4) (-8,-6,8,3);
  int i = printf("half4_e_1874c===%+.3v4he===%+.3v4he===\n",var1,var2);
  return i;
}

int half4_e_1875c() {
  // { dg-printf -re "half4_e_1875c===.*===.*===" }
  half4 var1 = (half4) (-6,6,0,7);
  half4 var2 = (half4) (1,4,3,8);
  int i = printf("half4_e_1875c===%+.10v4he===%+.10v4he===\n",var1,var2);
  return i;
}

int half4_e_1876c() {
  // { dg-printf -re "half4_e_1876c===.*===.*===" }
  half4 var1 = (half4) (0,7,0,2);
  half4 var2 = (half4) (-6,-5,-2,0);
  int i = printf("half4_e_1876c===%+v4hE===%+v4hE===\n",var1,var2);
  return i;
}

int half4_e_1877c() {
  // { dg-printf -re "half4_e_1877c===.*===.*===" }
  half4 var1 = (half4) (3,0,5,123445);
  half4 var2 = (half4) (-8,5,7,0);
  int i = printf("half4_e_1877c===%+.1v4hE===%+.1v4hE===\n",var1,var2);
  return i;
}

int half4_e_1878c() {
  // { dg-printf -re "half4_e_1878c===.*===.*===" }
  half4 var1 = (half4) (0,1,123445,4);
  half4 var2 = (half4) (6,2,8,1);
  int i = printf("half4_e_1878c===%+.2v4hE===%+.2v4hE===\n",var1,var2);
  return i;
}

int half4_e_1879c() {
  // { dg-printf -re "half4_e_1879c===.*===.*===" }
  half4 var1 = (half4) (123445,2,5,0);
  half4 var2 = (half4) (-3,1,1,8);
  int i = printf("half4_e_1879c===%+.3v4hE===%+.3v4hE===\n",var1,var2);
  return i;
}

int half4_e_1880c() {
  // { dg-printf -re "half4_e_1880c===.*===.*===" }
  half4 var1 = (half4) (-7,-123455,4,-2);
  half4 var2 = (half4) (3,-8,123445,-2);
  int i = printf("half4_e_1880c===%+.10v4hE===%+.10v4hE===\n",var1,var2);
  return i;
}

int half4_e_2631c() {
  // { dg-printf -re "half4_e_2631c===.*===.*===" }
  half4 var1 = (half4) (5,-1,0,0);
  half4 var2 = (half4) (6,5,-4,6);
  int i = printf("half4_e_2631c===%#v4he===%#v4he===\n",var1,var2);
  return i;
}

int half4_e_2632c() {
  // { dg-printf -re "half4_e_2632c===.*===.*===" }
  half4 var1 = (half4) (4,-7,6,8);
  half4 var2 = (half4) (-4,1,-6,-7);
  int i = printf("half4_e_2632c===%#.1v4he===%#.1v4he===\n",var1,var2);
  return i;
}

int half4_e_2633c() {
  // { dg-printf -re "half4_e_2633c===.*===.*===" }
  half4 var1 = (half4) (-6,5,1,-8);
  half4 var2 = (half4) (-2,-123455,-2,-1);
  int i = printf("half4_e_2633c===%#.2v4he===%#.2v4he===\n",var1,var2);
  return i;
}

int half4_e_2634c() {
  // { dg-printf -re "half4_e_2634c===.*===.*===" }
  half4 var1 = (half4) (-7,8,-123455,-5);
  half4 var2 = (half4) (-3,-5,-3,5);
  int i = printf("half4_e_2634c===%#.3v4he===%#.3v4he===\n",var1,var2);
  return i;
}

int half4_e_2635c() {
  // { dg-printf -re "half4_e_2635c===.*===.*===" }
  half4 var1 = (half4) (2,5,-1,-2);
  half4 var2 = (half4) (-4,-1,1,2);
  int i = printf("half4_e_2635c===%#.10v4he===%#.10v4he===\n",var1,var2);
  return i;
}

int half4_e_2636c() {
  // { dg-printf -re "half4_e_2636c===.*===.*===" }
  half4 var1 = (half4) (1,-3,-8,-123455);
  half4 var2 = (half4) (1,-4,6,1);
  int i = printf("half4_e_2636c===%#v4hE===%#v4hE===\n",var1,var2);
  return i;
}

int half4_e_2637c() {
  // { dg-printf -re "half4_e_2637c===.*===.*===" }
  half4 var1 = (half4) (123445,0,7,1);
  half4 var2 = (half4) (7,-123455,-3,3);
  int i = printf("half4_e_2637c===%#.1v4hE===%#.1v4hE===\n",var1,var2);
  return i;
}

int half4_e_2638c() {
  // { dg-printf -re "half4_e_2638c===.*===.*===" }
  half4 var1 = (half4) (3,-123455,-123455,6);
  half4 var2 = (half4) (7,123445,123445,4);
  int i = printf("half4_e_2638c===%#.2v4hE===%#.2v4hE===\n",var1,var2);
  return i;
}

int half4_e_2639c() {
  // { dg-printf -re "half4_e_2639c===.*===.*===" }
  half4 var1 = (half4) (0,2,-4,-8);
  half4 var2 = (half4) (-5,0,7,123445);
  int i = printf("half4_e_2639c===%#.3v4hE===%#.3v4hE===\n",var1,var2);
  return i;
}

int half4_e_2640c() {
  // { dg-printf -re "half4_e_2640c===.*===.*===" }
  half4 var1 = (half4) (-5,-3,4,-2);
  half4 var2 = (half4) (-2,-8,2,0);
  int i = printf("half4_e_2640c===%#.10v4hE===%#.10v4hE===\n",var1,var2);
  return i;
}

int half4_e_3391c() {
  // { dg-printf -re "half4_e_3391c===.*===.*===" }
  half4 var1 = (half4) (123445,2,8,0);
  half4 var2 = (half4) (-8,8,0,-7);
  int i = printf("half4_e_3391c===%-+v4he===%-+v4he===\n",var1,var2);
  return i;
}

int half4_e_3392c() {
  // { dg-printf -re "half4_e_3392c===.*===.*===" }
  half4 var1 = (half4) (2,6,-4,5);
  half4 var2 = (half4) (-123455,-8,0,-5);
  int i = printf("half4_e_3392c===%-+.1v4he===%-+.1v4he===\n",var1,var2);
  return i;
}

int half4_e_3393c() {
  // { dg-printf -re "half4_e_3393c===.*===.*===" }
  half4 var1 = (half4) (8,8,7,1);
  half4 var2 = (half4) (1,-8,-3,0);
  int i = printf("half4_e_3393c===%-+.2v4he===%-+.2v4he===\n",var1,var2);
  return i;
}

int half4_e_3394c() {
  // { dg-printf -re "half4_e_3394c===.*===.*===" }
  half4 var1 = (half4) (-2,3,-3,1);
  half4 var2 = (half4) (-5,-2,0,-123455);
  int i = printf("half4_e_3394c===%-+.3v4he===%-+.3v4he===\n",var1,var2);
  return i;
}

int half4_e_3395c() {
  // { dg-printf -re "half4_e_3395c===.*===.*===" }
  half4 var1 = (half4) (-3,0,123445,2);
  half4 var2 = (half4) (6,2,-1,-4);
  int i = printf("half4_e_3395c===%-+.10v4he===%-+.10v4he===\n",var1,var2);
  return i;
}

int half4_e_3396c() {
  // { dg-printf -re "half4_e_3396c===.*===.*===" }
  half4 var1 = (half4) (-2,-1,5,-4);
  half4 var2 = (half4) (7,6,-8,-8);
  int i = printf("half4_e_3396c===%-+v4hE===%-+v4hE===\n",var1,var2);
  return i;
}

int half4_e_3397c() {
  // { dg-printf -re "half4_e_3397c===.*===.*===" }
  half4 var1 = (half4) (-6,6,0,6);
  half4 var2 = (half4) (7,2,-2,-8);
  int i = printf("half4_e_3397c===%-+.1v4hE===%-+.1v4hE===\n",var1,var2);
  return i;
}

int half4_e_3398c() {
  // { dg-printf -re "half4_e_3398c===.*===.*===" }
  half4 var1 = (half4) (123445,1,-1,-1);
  half4 var2 = (half4) (0,5,7,1);
  int i = printf("half4_e_3398c===%-+.2v4hE===%-+.2v4hE===\n",var1,var2);
  return i;
}

int half4_e_3399c() {
  // { dg-printf -re "half4_e_3399c===.*===.*===" }
  half4 var1 = (half4) (7,-6,1,-1);
  half4 var2 = (half4) (-2,3,1,-123455);
  int i = printf("half4_e_3399c===%-+.3v4hE===%-+.3v4hE===\n",var1,var2);
  return i;
}

int half4_e_3400c() {
  // { dg-printf -re "half4_e_3400c===.*===.*===" }
  half4 var1 = (half4) (4,123445,-4,2);
  half4 var2 = (half4) (0,-3,-2,5);
  int i = printf("half4_e_3400c===%-+.10v4hE===%-+.10v4hE===\n",var1,var2);
  return i;
}

int half4_e_351c() {
  // { dg-printf -re "half4_e_351c===.*===.*===" }
  half4 var1 = (half4) (5,-123455,-4,6);
  half4 var2 = (half4) (7,-6,2,3);
  int i = printf("half4_e_351c===%v4he===%v4he===\n",var1,var2);
  return i;
}

int half4_e_352c() {
  // { dg-printf -re "half4_e_352c===.*===.*===" }
  half4 var1 = (half4) (6,-7,8,-1);
  half4 var2 = (half4) (-1,8,0,-123455);
  int i = printf("half4_e_352c===%.1v4he===%.1v4he===\n",var1,var2);
  return i;
}

int half4_e_353c() {
  // { dg-printf -re "half4_e_353c===.*===.*===" }
  half4 var1 = (half4) (-123455,-8,6,-7);
  half4 var2 = (half4) (-6,0,5,-6);
  int i = printf("half4_e_353c===%.2v4he===%.2v4he===\n",var1,var2);
  return i;
}

int half4_e_354c() {
  // { dg-printf -re "half4_e_354c===.*===.*===" }
  half4 var1 = (half4) (1,2,5,1);
  half4 var2 = (half4) (-8,7,-2,0);
  int i = printf("half4_e_354c===%.3v4he===%.3v4he===\n",var1,var2);
  return i;
}

int half4_e_355c() {
  // { dg-printf -re "half4_e_355c===.*===.*===" }
  half4 var1 = (half4) (7,-123455,-3,-4);
  half4 var2 = (half4) (-1,-1,123445,-6);
  int i = printf("half4_e_355c===%.10v4he===%.10v4he===\n",var1,var2);
  return i;
}

int half4_e_356c() {
  // { dg-printf -re "half4_e_356c===.*===.*===" }
  half4 var1 = (half4) (-6,-6,-2,-6);
  half4 var2 = (half4) (3,-123455,-2,-5);
  int i = printf("half4_e_356c===%v4hE===%v4hE===\n",var1,var2);
  return i;
}

int half4_e_357c() {
  // { dg-printf -re "half4_e_357c===.*===.*===" }
  half4 var1 = (half4) (-8,-6,1,4);
  half4 var2 = (half4) (-123455,-8,1,123445);
  int i = printf("half4_e_357c===%.1v4hE===%.1v4hE===\n",var1,var2);
  return i;
}

int half4_e_358c() {
  // { dg-printf -re "half4_e_358c===.*===.*===" }
  half4 var1 = (half4) (3,-8,-7,-123455);
  half4 var2 = (half4) (6,-8,7,-5);
  int i = printf("half4_e_358c===%.2v4hE===%.2v4hE===\n",var1,var2);
  return i;
}

int half4_e_359c() {
  // { dg-printf -re "half4_e_359c===.*===.*===" }
  half4 var1 = (half4) (-2,4,0,1);
  half4 var2 = (half4) (0,3,8,123445);
  int i = printf("half4_e_359c===%.3v4hE===%.3v4hE===\n",var1,var2);
  return i;
}

int half4_e_360c() {
  // { dg-printf -re "half4_e_360c===.*===.*===" }
  half4 var1 = (half4) (6,123445,-3,-2);
  half4 var2 = (half4) (-5,6,-3,7);
  int i = printf("half4_e_360c===%.10v4hE===%.10v4hE===\n",var1,var2);
  return i;
}

int half4_e_4151c() {
  // { dg-printf -re "half4_e_4151c===.*===.*===" }
  half4 var1 = (half4) (5,-7,-3,123445);
  half4 var2 = (half4) (7,-7,-123455,2);
  int i = printf("half4_e_4151c===% 10v4he===% 10v4he===\n",var1,var2);
  return i;
}

int half4_e_4152c() {
  // { dg-printf -re "half4_e_4152c===.*===.*===" }
  half4 var1 = (half4) (5,3,-7,-7);
  half4 var2 = (half4) (2,0,123445,5);
  int i = printf("half4_e_4152c===% 10.1v4he===% 10.1v4he===\n",var1,var2);
  return i;
}

int half4_e_4153c() {
  // { dg-printf -re "half4_e_4153c===.*===.*===" }
  half4 var1 = (half4) (0,-4,6,2);
  half4 var2 = (half4) (-3,-123455,4,2);
  int i = printf("half4_e_4153c===% 10.2v4he===% 10.2v4he===\n",var1,var2);
  return i;
}

int half4_e_4154c() {
  // { dg-printf -re "half4_e_4154c===.*===.*===" }
  half4 var1 = (half4) (-2,8,3,-1);
  half4 var2 = (half4) (-5,8,4,-6);
  int i = printf("half4_e_4154c===% 10.3v4he===% 10.3v4he===\n",var1,var2);
  return i;
}

int half4_e_4155c() {
  // { dg-printf -re "half4_e_4155c===.*===.*===" }
  half4 var1 = (half4) (7,-6,-8,-3);
  half4 var2 = (half4) (-5,-8,8,5);
  int i = printf("half4_e_4155c===% 10.10v4he===% 10.10v4he===\n",var1,var2);
  return i;
}

int half4_e_4156c() {
  // { dg-printf -re "half4_e_4156c===.*===.*===" }
  half4 var1 = (half4) (-8,-4,0,3);
  half4 var2 = (half4) (-8,-5,-3,-5);
  int i = printf("half4_e_4156c===% 10v4hE===% 10v4hE===\n",var1,var2);
  return i;
}

int half4_e_4157c() {
  // { dg-printf -re "half4_e_4157c===.*===.*===" }
  half4 var1 = (half4) (-5,4,-7,1);
  half4 var2 = (half4) (-7,-2,123445,-123455);
  int i = printf("half4_e_4157c===% 10.1v4hE===% 10.1v4hE===\n",var1,var2);
  return i;
}

int half4_e_4158c() {
  // { dg-printf -re "half4_e_4158c===.*===.*===" }
  half4 var1 = (half4) (5,8,1,-6);
  half4 var2 = (half4) (2,7,-5,-5);
  int i = printf("half4_e_4158c===% 10.2v4hE===% 10.2v4hE===\n",var1,var2);
  return i;
}

int half4_e_4159c() {
  // { dg-printf -re "half4_e_4159c===.*===.*===" }
  half4 var1 = (half4) (5,8,-6,4);
  half4 var2 = (half4) (0,-1,-8,-8);
  int i = printf("half4_e_4159c===% 10.3v4hE===% 10.3v4hE===\n",var1,var2);
  return i;
}

int half4_e_4160c() {
  // { dg-printf -re "half4_e_4160c===.*===.*===" }
  half4 var1 = (half4) (-123455,-2,-8,0);
  half4 var2 = (half4) (-8,-6,8,-3);
  int i = printf("half4_e_4160c===% 10.10v4hE===% 10.10v4hE===\n",var1,var2);
  return i;
}

int half4_e_4911c() {
  // { dg-printf -re "half4_e_4911c===.*===.*===" }
  half4 var1 = (half4) (5,6,-1,-1);
  half4 var2 = (half4) (3,7,1,-3);
  int i = printf("half4_e_4911c===%010v4he===%010v4he===\n",var1,var2);
  return i;
}

int half4_e_4912c() {
  // { dg-printf -re "half4_e_4912c===.*===.*===" }
  half4 var1 = (half4) (123445,6,4,-7);
  half4 var2 = (half4) (0,6,-8,-5);
  int i = printf("half4_e_4912c===%010.1v4he===%010.1v4he===\n",var1,var2);
  return i;
}

int half4_e_4913c() {
  // { dg-printf -re "half4_e_4913c===.*===.*===" }
  half4 var1 = (half4) (-4,-123455,3,0);
  half4 var2 = (half4) (1,-7,2,-123455);
  int i = printf("half4_e_4913c===%010.2v4he===%010.2v4he===\n",var1,var2);
  return i;
}

int half4_e_4914c() {
  // { dg-printf -re "half4_e_4914c===.*===.*===" }
  half4 var1 = (half4) (0,-5,8,-3);
  half4 var2 = (half4) (6,-6,0,4);
  int i = printf("half4_e_4914c===%010.3v4he===%010.3v4he===\n",var1,var2);
  return i;
}

int half4_e_4915c() {
  // { dg-printf -re "half4_e_4915c===.*===.*===" }
  half4 var1 = (half4) (-6,-8,-123455,1);
  half4 var2 = (half4) (-1,3,4,-5);
  int i = printf("half4_e_4915c===%010.10v4he===%010.10v4he===\n",var1,var2);
  return i;
}

int half4_e_4916c() {
  // { dg-printf -re "half4_e_4916c===.*===.*===" }
  half4 var1 = (half4) (8,-5,3,-5);
  half4 var2 = (half4) (4,-8,0,-8);
  int i = printf("half4_e_4916c===%010v4hE===%010v4hE===\n",var1,var2);
  return i;
}

int half4_e_4917c() {
  // { dg-printf -re "half4_e_4917c===.*===.*===" }
  half4 var1 = (half4) (-3,5,7,5);
  half4 var2 = (half4) (-6,-3,-7,1);
  int i = printf("half4_e_4917c===%010.1v4hE===%010.1v4hE===\n",var1,var2);
  return i;
}

int half4_e_4918c() {
  // { dg-printf -re "half4_e_4918c===.*===.*===" }
  half4 var1 = (half4) (-6,123445,123445,4);
  half4 var2 = (half4) (123445,-123455,1,8);
  int i = printf("half4_e_4918c===%010.2v4hE===%010.2v4hE===\n",var1,var2);
  return i;
}

int half4_e_4919c() {
  // { dg-printf -re "half4_e_4919c===.*===.*===" }
  half4 var1 = (half4) (5,4,8,2);
  half4 var2 = (half4) (8,1,123445,5);
  int i = printf("half4_e_4919c===%010.3v4hE===%010.3v4hE===\n",var1,var2);
  return i;
}

int half4_e_4920c() {
  // { dg-printf -re "half4_e_4920c===.*===.*===" }
  half4 var1 = (half4) (-123455,-8,-3,1);
  half4 var2 = (half4) (-123455,-2,-6,3);
  int i = printf("half4_e_4920c===%010.10v4hE===%010.10v4hE===\n",var1,var2);
  return i;
}

int half4_e_5671c() {
  // { dg-printf -re "half4_e_5671c===.*===.*===" }
  half4 var1 = (half4) (-3,-5,3,123445);
  half4 var2 = (half4) (-123455,3,123445,123445);
  int i = printf("half4_e_5671c===%- 10v4he===%- 10v4he===\n",var1,var2);
  return i;
}

int half4_e_5672c() {
  // { dg-printf -re "half4_e_5672c===.*===.*===" }
  half4 var1 = (half4) (8,-3,6,-7);
  half4 var2 = (half4) (7,0,3,3);
  int i = printf("half4_e_5672c===%- 10.1v4he===%- 10.1v4he===\n",var1,var2);
  return i;
}

int half4_e_5673c() {
  // { dg-printf -re "half4_e_5673c===.*===.*===" }
  half4 var1 = (half4) (3,-123455,3,-2);
  half4 var2 = (half4) (5,-123455,-8,1);
  int i = printf("half4_e_5673c===%- 10.2v4he===%- 10.2v4he===\n",var1,var2);
  return i;
}

int half4_e_5674c() {
  // { dg-printf -re "half4_e_5674c===.*===.*===" }
  half4 var1 = (half4) (-7,-4,-6,5);
  half4 var2 = (half4) (-5,3,7,2);
  int i = printf("half4_e_5674c===%- 10.3v4he===%- 10.3v4he===\n",var1,var2);
  return i;
}

int half4_e_5675c() {
  // { dg-printf -re "half4_e_5675c===.*===.*===" }
  half4 var1 = (half4) (-1,-7,0,3);
  half4 var2 = (half4) (-2,0,-123455,3);
  int i = printf("half4_e_5675c===%- 10.10v4he===%- 10.10v4he===\n",var1,var2);
  return i;
}

int half4_e_5676c() {
  // { dg-printf -re "half4_e_5676c===.*===.*===" }
  half4 var1 = (half4) (6,-7,5,-8);
  half4 var2 = (half4) (-1,-6,2,-2);
  int i = printf("half4_e_5676c===%- 10v4hE===%- 10v4hE===\n",var1,var2);
  return i;
}

int half4_e_5677c() {
  // { dg-printf -re "half4_e_5677c===.*===.*===" }
  half4 var1 = (half4) (-2,-6,-8,2);
  half4 var2 = (half4) (0,6,-6,-3);
  int i = printf("half4_e_5677c===%- 10.1v4hE===%- 10.1v4hE===\n",var1,var2);
  return i;
}

int half4_e_5678c() {
  // { dg-printf -re "half4_e_5678c===.*===.*===" }
  half4 var1 = (half4) (-7,4,3,123445);
  half4 var2 = (half4) (123445,-2,-5,123445);
  int i = printf("half4_e_5678c===%- 10.2v4hE===%- 10.2v4hE===\n",var1,var2);
  return i;
}

int half4_e_5679c() {
  // { dg-printf -re "half4_e_5679c===.*===.*===" }
  half4 var1 = (half4) (7,5,1,-6);
  half4 var2 = (half4) (123445,1,4,-7);
  int i = printf("half4_e_5679c===%- 10.3v4hE===%- 10.3v4hE===\n",var1,var2);
  return i;
}

int half4_e_5680c() {
  // { dg-printf -re "half4_e_5680c===.*===.*===" }
  half4 var1 = (half4) (-3,4,7,-6);
  half4 var2 = (half4) (-3,1,1,-8);
  int i = printf("half4_e_5680c===%- 10.10v4hE===%- 10.10v4hE===\n",var1,var2);
  return i;
}

int half4_e_6431c() {
  // { dg-printf -re "half4_e_6431c===.*===.*===" }
  half4 var1 = (half4) (1,-8,-6,7);
  half4 var2 = (half4) (-8,123445,-123455,7);
  int i = printf("half4_e_6431c===%+ 10v4he===%+ 10v4he===\n",var1,var2);
  return i;
}

int half4_e_6432c() {
  // { dg-printf -re "half4_e_6432c===.*===.*===" }
  half4 var1 = (half4) (8,4,-3,1);
  half4 var2 = (half4) (4,123445,-3,-1);
  int i = printf("half4_e_6432c===%+ 10.1v4he===%+ 10.1v4he===\n",var1,var2);
  return i;
}

int half4_e_6433c() {
  // { dg-printf -re "half4_e_6433c===.*===.*===" }
  half4 var1 = (half4) (1,123445,123445,6);
  half4 var2 = (half4) (-6,-8,123445,7);
  int i = printf("half4_e_6433c===%+ 10.2v4he===%+ 10.2v4he===\n",var1,var2);
  return i;
}

int half4_e_6434c() {
  // { dg-printf -re "half4_e_6434c===.*===.*===" }
  half4 var1 = (half4) (-2,-1,-1,8);
  half4 var2 = (half4) (4,4,0,5);
  int i = printf("half4_e_6434c===%+ 10.3v4he===%+ 10.3v4he===\n",var1,var2);
  return i;
}

int half4_e_6435c() {
  // { dg-printf -re "half4_e_6435c===.*===.*===" }
  half4 var1 = (half4) (123445,8,4,5);
  half4 var2 = (half4) (0,3,3,1);
  int i = printf("half4_e_6435c===%+ 10.10v4he===%+ 10.10v4he===\n",var1,var2);
  return i;
}

int half4_e_6436c() {
  // { dg-printf -re "half4_e_6436c===.*===.*===" }
  half4 var1 = (half4) (4,0,-1,-1);
  half4 var2 = (half4) (7,-2,-4,-7);
  int i = printf("half4_e_6436c===%+ 10v4hE===%+ 10v4hE===\n",var1,var2);
  return i;
}

int half4_e_6437c() {
  // { dg-printf -re "half4_e_6437c===.*===.*===" }
  half4 var1 = (half4) (-4,3,-123455,-6);
  half4 var2 = (half4) (-3,5,8,0);
  int i = printf("half4_e_6437c===%+ 10.1v4hE===%+ 10.1v4hE===\n",var1,var2);
  return i;
}

int half4_e_6438c() {
  // { dg-printf -re "half4_e_6438c===.*===.*===" }
  half4 var1 = (half4) (-3,-8,7,123445);
  half4 var2 = (half4) (123445,-4,-6,1);
  int i = printf("half4_e_6438c===%+ 10.2v4hE===%+ 10.2v4hE===\n",var1,var2);
  return i;
}

int half4_e_6439c() {
  // { dg-printf -re "half4_e_6439c===.*===.*===" }
  half4 var1 = (half4) (-123455,1,-1,-4);
  half4 var2 = (half4) (5,-6,-8,-3);
  int i = printf("half4_e_6439c===%+ 10.3v4hE===%+ 10.3v4hE===\n",var1,var2);
  return i;
}

int half4_e_6440c() {
  // { dg-printf -re "half4_e_6440c===.*===.*===" }
  half4 var1 = (half4) (-1,1,6,5);
  half4 var2 = (half4) (0,4,7,-5);
  int i = printf("half4_e_6440c===%+ 10.10v4hE===%+ 10.10v4hE===\n",var1,var2);
  return i;
}

int half4_e_7191c() {
  // { dg-printf -re "half4_e_7191c===.*===.*===" }
  half4 var1 = (half4) (7,-1,7,-2);
  half4 var2 = (half4) (-2,8,-6,5);
  int i = printf("half4_e_7191c===%+010v4he===%+010v4he===\n",var1,var2);
  return i;
}

int half4_e_7192c() {
  // { dg-printf -re "half4_e_7192c===.*===.*===" }
  half4 var1 = (half4) (-123455,-8,6,2);
  half4 var2 = (half4) (8,123445,7,5);
  int i = printf("half4_e_7192c===%+010.1v4he===%+010.1v4he===\n",var1,var2);
  return i;
}

int half4_e_7193c() {
  // { dg-printf -re "half4_e_7193c===.*===.*===" }
  half4 var1 = (half4) (-6,8,123445,-123455);
  half4 var2 = (half4) (-5,-3,-7,7);
  int i = printf("half4_e_7193c===%+010.2v4he===%+010.2v4he===\n",var1,var2);
  return i;
}

int half4_e_7194c() {
  // { dg-printf -re "half4_e_7194c===.*===.*===" }
  half4 var1 = (half4) (6,0,4,-2);
  half4 var2 = (half4) (-2,3,8,-3);
  int i = printf("half4_e_7194c===%+010.3v4he===%+010.3v4he===\n",var1,var2);
  return i;
}

int half4_e_7195c() {
  // { dg-printf -re "half4_e_7195c===.*===.*===" }
  half4 var1 = (half4) (-4,8,5,8);
  half4 var2 = (half4) (7,-3,-4,-1);
  int i = printf("half4_e_7195c===%+010.10v4he===%+010.10v4he===\n",var1,var2);
  return i;
}

int half4_e_7196c() {
  // { dg-printf -re "half4_e_7196c===.*===.*===" }
  half4 var1 = (half4) (-2,123445,2,-2);
  half4 var2 = (half4) (0,-7,-7,5);
  int i = printf("half4_e_7196c===%+010v4hE===%+010v4hE===\n",var1,var2);
  return i;
}

int half4_e_7197c() {
  // { dg-printf -re "half4_e_7197c===.*===.*===" }
  half4 var1 = (half4) (4,-6,-8,8);
  half4 var2 = (half4) (6,7,8,-2);
  int i = printf("half4_e_7197c===%+010.1v4hE===%+010.1v4hE===\n",var1,var2);
  return i;
}

int half4_e_7198c() {
  // { dg-printf -re "half4_e_7198c===.*===.*===" }
  half4 var1 = (half4) (7,1,5,-3);
  half4 var2 = (half4) (5,0,-6,123445);
  int i = printf("half4_e_7198c===%+010.2v4hE===%+010.2v4hE===\n",var1,var2);
  return i;
}

int half4_e_7199c() {
  // { dg-printf -re "half4_e_7199c===.*===.*===" }
  half4 var1 = (half4) (-5,6,4,0);
  half4 var2 = (half4) (-3,-5,2,7);
  int i = printf("half4_e_7199c===%+010.3v4hE===%+010.3v4hE===\n",var1,var2);
  return i;
}

int half4_e_7200c() {
  // { dg-printf -re "half4_e_7200c===.*===.*===" }
  half4 var1 = (half4) (-7,-2,6,8);
  half4 var2 = (half4) (7,-2,5,-4);
  int i = printf("half4_e_7200c===%+010.10v4hE===%+010.10v4hE===\n",var1,var2);
  return i;
}

int half4_f_1121c() {
  // { dg-printf -re "half4_f_1121c===.*===.*===" }
  half4 var1 = (half4) (2,-5,7,-3);
  half4 var2 = (half4) (-4,7,-7,-1);
  int i = printf("half4_f_1121c===%-v4hf===%-v4hf===\n",var1,var2);
  return i;
}

int half4_f_1122c() {
  // { dg-printf -re "half4_f_1122c===.*===.*===" }
  half4 var1 = (half4) (-5,4,-5,-3);
  half4 var2 = (half4) (-7,-4,5,3);
  int i = printf("half4_f_1122c===%-.1v4hf===%-.1v4hf===\n",var1,var2);
  return i;
}

int half4_f_1123c() {
  // { dg-printf -re "half4_f_1123c===.*===.*===" }
  half4 var1 = (half4) (8,1,-5,-8);
  half4 var2 = (half4) (-123455,2,8,-7);
  int i = printf("half4_f_1123c===%-.2v4hf===%-.2v4hf===\n",var1,var2);
  return i;
}

int half4_f_1124c() {
  // { dg-printf -re "half4_f_1124c===.*===.*===" }
  half4 var1 = (half4) (5,7,-2,-7);
  half4 var2 = (half4) (0,-5,8,2);
  int i = printf("half4_f_1124c===%-.3v4hf===%-.3v4hf===\n",var1,var2);
  return i;
}

int half4_f_1125c() {
  // { dg-printf -re "half4_f_1125c===.*===.*===" }
  half4 var1 = (half4) (-1,3,2,-1);
  half4 var2 = (half4) (3,-1,4,6);
  int i = printf("half4_f_1125c===%-.10v4hf===%-.10v4hf===\n",var1,var2);
  return i;
}

int half4_f_1126c() {
  // { dg-printf -re "half4_f_1126c===.*===.*===" }
  half4 var1 = (half4) (-8,-7,-6,7);
  half4 var2 = (half4) (0,-1,-2,-3);
  int i = printf("half4_f_1126c===%-v4hF===%-v4hF===\n",var1,var2);
  return i;
}

int half4_f_1127c() {
  // { dg-printf -re "half4_f_1127c===.*===.*===" }
  half4 var1 = (half4) (123445,7,-7,8);
  half4 var2 = (half4) (3,4,-3,123445);
  int i = printf("half4_f_1127c===%-.1v4hF===%-.1v4hF===\n",var1,var2);
  return i;
}

int half4_f_1128c() {
  // { dg-printf -re "half4_f_1128c===.*===.*===" }
  half4 var1 = (half4) (123445,-1,-3,1);
  half4 var2 = (half4) (6,123445,-3,123445);
  int i = printf("half4_f_1128c===%-.2v4hF===%-.2v4hF===\n",var1,var2);
  return i;
}

int half4_f_1129c() {
  // { dg-printf -re "half4_f_1129c===.*===.*===" }
  half4 var1 = (half4) (-7,-123455,123445,-2);
  half4 var2 = (half4) (-4,7,2,-3);
  int i = printf("half4_f_1129c===%-.3v4hF===%-.3v4hF===\n",var1,var2);
  return i;
}

int half4_f_1130c() {
  // { dg-printf -re "half4_f_1130c===.*===.*===" }
  half4 var1 = (half4) (-5,1,-8,4);
  half4 var2 = (half4) (123445,-5,1,2);
  int i = printf("half4_f_1130c===%-.10v4hF===%-.10v4hF===\n",var1,var2);
  return i;
}

int half4_f_1881c() {
  // { dg-printf -re "half4_f_1881c===.*===.*===" }
  half4 var1 = (half4) (-1,-123455,-3,8);
  half4 var2 = (half4) (-8,-2,-3,1);
  int i = printf("half4_f_1881c===%+v4hf===%+v4hf===\n",var1,var2);
  return i;
}

int half4_f_1882c() {
  // { dg-printf -re "half4_f_1882c===.*===.*===" }
  half4 var1 = (half4) (0,5,-1,-3);
  half4 var2 = (half4) (4,0,-8,5);
  int i = printf("half4_f_1882c===%+.1v4hf===%+.1v4hf===\n",var1,var2);
  return i;
}

int half4_f_1883c() {
  // { dg-printf -re "half4_f_1883c===.*===.*===" }
  half4 var1 = (half4) (7,6,1,7);
  half4 var2 = (half4) (-123455,5,0,-1);
  int i = printf("half4_f_1883c===%+.2v4hf===%+.2v4hf===\n",var1,var2);
  return i;
}

int half4_f_1884c() {
  // { dg-printf -re "half4_f_1884c===.*===.*===" }
  half4 var1 = (half4) (2,-123455,-4,123445);
  half4 var2 = (half4) (7,-7,-123455,5);
  int i = printf("half4_f_1884c===%+.3v4hf===%+.3v4hf===\n",var1,var2);
  return i;
}

int half4_f_1885c() {
  // { dg-printf -re "half4_f_1885c===.*===.*===" }
  half4 var1 = (half4) (-6,2,-3,-123455);
  half4 var2 = (half4) (-3,-8,-6,123445);
  int i = printf("half4_f_1885c===%+.10v4hf===%+.10v4hf===\n",var1,var2);
  return i;
}

int half4_f_1886c() {
  // { dg-printf -re "half4_f_1886c===.*===.*===" }
  half4 var1 = (half4) (4,-123455,-8,-2);
  half4 var2 = (half4) (7,-4,-7,8);
  int i = printf("half4_f_1886c===%+v4hF===%+v4hF===\n",var1,var2);
  return i;
}

int half4_f_1887c() {
  // { dg-printf -re "half4_f_1887c===.*===.*===" }
  half4 var1 = (half4) (-7,-4,2,-2);
  half4 var2 = (half4) (-123455,-5,-6,123445);
  int i = printf("half4_f_1887c===%+.1v4hF===%+.1v4hF===\n",var1,var2);
  return i;
}

int half4_f_1888c() {
  // { dg-printf -re "half4_f_1888c===.*===.*===" }
  half4 var1 = (half4) (6,-6,2,-4);
  half4 var2 = (half4) (-4,0,-8,7);
  int i = printf("half4_f_1888c===%+.2v4hF===%+.2v4hF===\n",var1,var2);
  return i;
}

int half4_f_1889c() {
  // { dg-printf -re "half4_f_1889c===.*===.*===" }
  half4 var1 = (half4) (7,7,5,123445);
  half4 var2 = (half4) (2,1,-8,-6);
  int i = printf("half4_f_1889c===%+.3v4hF===%+.3v4hF===\n",var1,var2);
  return i;
}

int half4_f_1890c() {
  // { dg-printf -re "half4_f_1890c===.*===.*===" }
  half4 var1 = (half4) (-7,8,-6,-123455);
  half4 var2 = (half4) (-3,-3,-4,-123455);
  int i = printf("half4_f_1890c===%+.10v4hF===%+.10v4hF===\n",var1,var2);
  return i;
}

int half4_f_2641c() {
  // { dg-printf -re "half4_f_2641c===.*===.*===" }
  half4 var1 = (half4) (-4,3,-7,1);
  half4 var2 = (half4) (8,-123455,-1,-123455);
  int i = printf("half4_f_2641c===%#v4hf===%#v4hf===\n",var1,var2);
  return i;
}

int half4_f_2642c() {
  // { dg-printf -re "half4_f_2642c===.*===.*===" }
  half4 var1 = (half4) (1,0,1,-3);
  half4 var2 = (half4) (-6,-123455,-2,-2);
  int i = printf("half4_f_2642c===%#.1v4hf===%#.1v4hf===\n",var1,var2);
  return i;
}

int half4_f_2643c() {
  // { dg-printf -re "half4_f_2643c===.*===.*===" }
  half4 var1 = (half4) (123445,-123455,-2,8);
  half4 var2 = (half4) (5,-6,7,-5);
  int i = printf("half4_f_2643c===%#.2v4hf===%#.2v4hf===\n",var1,var2);
  return i;
}

int half4_f_2644c() {
  // { dg-printf -re "half4_f_2644c===.*===.*===" }
  half4 var1 = (half4) (6,0,-123455,6);
  half4 var2 = (half4) (5,-8,3,4);
  int i = printf("half4_f_2644c===%#.3v4hf===%#.3v4hf===\n",var1,var2);
  return i;
}

int half4_f_2645c() {
  // { dg-printf -re "half4_f_2645c===.*===.*===" }
  half4 var1 = (half4) (8,5,2,-4);
  half4 var2 = (half4) (123445,-4,-8,-1);
  int i = printf("half4_f_2645c===%#.10v4hf===%#.10v4hf===\n",var1,var2);
  return i;
}

int half4_f_2646c() {
  // { dg-printf -re "half4_f_2646c===.*===.*===" }
  half4 var1 = (half4) (0,7,-4,-123455);
  half4 var2 = (half4) (2,-4,1,123445);
  int i = printf("half4_f_2646c===%#v4hF===%#v4hF===\n",var1,var2);
  return i;
}

int half4_f_2647c() {
  // { dg-printf -re "half4_f_2647c===.*===.*===" }
  half4 var1 = (half4) (-4,3,0,6);
  half4 var2 = (half4) (7,8,8,123445);
  int i = printf("half4_f_2647c===%#.1v4hF===%#.1v4hF===\n",var1,var2);
  return i;
}

int half4_f_2648c() {
  // { dg-printf -re "half4_f_2648c===.*===.*===" }
  half4 var1 = (half4) (2,-5,5,-6);
  half4 var2 = (half4) (-4,123445,123445,-123455);
  int i = printf("half4_f_2648c===%#.2v4hF===%#.2v4hF===\n",var1,var2);
  return i;
}

int half4_f_2649c() {
  // { dg-printf -re "half4_f_2649c===.*===.*===" }
  half4 var1 = (half4) (123445,-8,-123455,4);
  half4 var2 = (half4) (6,-123455,-3,3);
  int i = printf("half4_f_2649c===%#.3v4hF===%#.3v4hF===\n",var1,var2);
  return i;
}

int half4_f_2650c() {
  // { dg-printf -re "half4_f_2650c===.*===.*===" }
  half4 var1 = (half4) (1,-6,-123455,-8);
  half4 var2 = (half4) (8,-4,2,-4);
  int i = printf("half4_f_2650c===%#.10v4hF===%#.10v4hF===\n",var1,var2);
  return i;
}

int half4_f_3401c() {
  // { dg-printf -re "half4_f_3401c===.*===.*===" }
  half4 var1 = (half4) (-3,8,7,6);
  half4 var2 = (half4) (4,2,123445,8);
  int i = printf("half4_f_3401c===%-+v4hf===%-+v4hf===\n",var1,var2);
  return i;
}

int half4_f_3402c() {
  // { dg-printf -re "half4_f_3402c===.*===.*===" }
  half4 var1 = (half4) (-4,-8,-5,-3);
  half4 var2 = (half4) (-2,-7,2,4);
  int i = printf("half4_f_3402c===%-+.1v4hf===%-+.1v4hf===\n",var1,var2);
  return i;
}

int half4_f_3403c() {
  // { dg-printf -re "half4_f_3403c===.*===.*===" }
  half4 var1 = (half4) (-7,-1,-123455,-3);
  half4 var2 = (half4) (-3,2,4,-2);
  int i = printf("half4_f_3403c===%-+.2v4hf===%-+.2v4hf===\n",var1,var2);
  return i;
}

int half4_f_3404c() {
  // { dg-printf -re "half4_f_3404c===.*===.*===" }
  half4 var1 = (half4) (1,-123455,4,5);
  half4 var2 = (half4) (-123455,6,-6,-8);
  int i = printf("half4_f_3404c===%-+.3v4hf===%-+.3v4hf===\n",var1,var2);
  return i;
}

int half4_f_3405c() {
  // { dg-printf -re "half4_f_3405c===.*===.*===" }
  half4 var1 = (half4) (3,5,7,-3);
  half4 var2 = (half4) (2,1,-5,0);
  int i = printf("half4_f_3405c===%-+.10v4hf===%-+.10v4hf===\n",var1,var2);
  return i;
}

int half4_f_3406c() {
  // { dg-printf -re "half4_f_3406c===.*===.*===" }
  half4 var1 = (half4) (8,-123455,123445,2);
  half4 var2 = (half4) (7,-5,8,-123455);
  int i = printf("half4_f_3406c===%-+v4hF===%-+v4hF===\n",var1,var2);
  return i;
}

int half4_f_3407c() {
  // { dg-printf -re "half4_f_3407c===.*===.*===" }
  half4 var1 = (half4) (-7,-6,-2,8);
  half4 var2 = (half4) (3,-5,-3,-2);
  int i = printf("half4_f_3407c===%-+.1v4hF===%-+.1v4hF===\n",var1,var2);
  return i;
}

int half4_f_3408c() {
  // { dg-printf -re "half4_f_3408c===.*===.*===" }
  half4 var1 = (half4) (-6,4,-7,-6);
  half4 var2 = (half4) (-1,-7,123445,-2);
  int i = printf("half4_f_3408c===%-+.2v4hF===%-+.2v4hF===\n",var1,var2);
  return i;
}

int half4_f_3409c() {
  // { dg-printf -re "half4_f_3409c===.*===.*===" }
  half4 var1 = (half4) (-2,2,-6,123445);
  half4 var2 = (half4) (-3,-8,-2,-4);
  int i = printf("half4_f_3409c===%-+.3v4hF===%-+.3v4hF===\n",var1,var2);
  return i;
}

int half4_f_3410c() {
  // { dg-printf -re "half4_f_3410c===.*===.*===" }
  half4 var1 = (half4) (5,-6,-8,0);
  half4 var2 = (half4) (-1,6,-8,-2);
  int i = printf("half4_f_3410c===%-+.10v4hF===%-+.10v4hF===\n",var1,var2);
  return i;
}

int half4_f_361c() {
  // { dg-printf -re "half4_f_361c===.*===.*===" }
  half4 var1 = (half4) (1,5,2,0);
  half4 var2 = (half4) (-123455,-1,1,0);
  int i = printf("half4_f_361c===%v4hf===%v4hf===\n",var1,var2);
  return i;
}

int half4_f_362c() {
  // { dg-printf -re "half4_f_362c===.*===.*===" }
  half4 var1 = (half4) (-6,7,-2,1);
  half4 var2 = (half4) (-1,-5,3,-5);
  int i = printf("half4_f_362c===%.1v4hf===%.1v4hf===\n",var1,var2);
  return i;
}

int half4_f_363c() {
  // { dg-printf -re "half4_f_363c===.*===.*===" }
  half4 var1 = (half4) (-3,8,1,123445);
  half4 var2 = (half4) (8,0,-123455,1);
  int i = printf("half4_f_363c===%.2v4hf===%.2v4hf===\n",var1,var2);
  return i;
}

int half4_f_364c() {
  // { dg-printf -re "half4_f_364c===.*===.*===" }
  half4 var1 = (half4) (2,-6,-5,3);
  half4 var2 = (half4) (-2,-6,0,8);
  int i = printf("half4_f_364c===%.3v4hf===%.3v4hf===\n",var1,var2);
  return i;
}

int half4_f_365c() {
  // { dg-printf -re "half4_f_365c===.*===.*===" }
  half4 var1 = (half4) (3,5,-123455,-6);
  half4 var2 = (half4) (3,-4,0,7);
  int i = printf("half4_f_365c===%.10v4hf===%.10v4hf===\n",var1,var2);
  return i;
}

int half4_f_366c() {
  // { dg-printf -re "half4_f_366c===.*===.*===" }
  half4 var1 = (half4) (-123455,4,-3,-7);
  half4 var2 = (half4) (1,-7,-4,-4);
  int i = printf("half4_f_366c===%v4hF===%v4hF===\n",var1,var2);
  return i;
}

int half4_f_367c() {
  // { dg-printf -re "half4_f_367c===.*===.*===" }
  half4 var1 = (half4) (5,5,2,-6);
  half4 var2 = (half4) (3,2,-3,123445);
  int i = printf("half4_f_367c===%.1v4hF===%.1v4hF===\n",var1,var2);
  return i;
}

int half4_f_368c() {
  // { dg-printf -re "half4_f_368c===.*===.*===" }
  half4 var1 = (half4) (-6,2,8,-7);
  half4 var2 = (half4) (1,3,3,123445);
  int i = printf("half4_f_368c===%.2v4hF===%.2v4hF===\n",var1,var2);
  return i;
}

int half4_f_369c() {
  // { dg-printf -re "half4_f_369c===.*===.*===" }
  half4 var1 = (half4) (-123455,-7,7,3);
  half4 var2 = (half4) (0,-7,-7,-2);
  int i = printf("half4_f_369c===%.3v4hF===%.3v4hF===\n",var1,var2);
  return i;
}

int half4_f_370c() {
  // { dg-printf -re "half4_f_370c===.*===.*===" }
  half4 var1 = (half4) (-3,7,7,6);
  half4 var2 = (half4) (7,3,6,2);
  int i = printf("half4_f_370c===%.10v4hF===%.10v4hF===\n",var1,var2);
  return i;
}

int half4_f_4161c() {
  // { dg-printf -re "half4_f_4161c===.*===.*===" }
  half4 var1 = (half4) (2,4,0,0);
  half4 var2 = (half4) (-123455,-5,0,-5);
  int i = printf("half4_f_4161c===% 10v4hf===% 10v4hf===\n",var1,var2);
  return i;
}

int half4_f_4162c() {
  // { dg-printf -re "half4_f_4162c===.*===.*===" }
  half4 var1 = (half4) (-5,8,6,6);
  half4 var2 = (half4) (123445,-4,-2,-8);
  int i = printf("half4_f_4162c===% 10.1v4hf===% 10.1v4hf===\n",var1,var2);
  return i;
}

int half4_f_4163c() {
  // { dg-printf -re "half4_f_4163c===.*===.*===" }
  half4 var1 = (half4) (2,6,2,-8);
  half4 var2 = (half4) (-1,123445,123445,2);
  int i = printf("half4_f_4163c===% 10.2v4hf===% 10.2v4hf===\n",var1,var2);
  return i;
}

int half4_f_4164c() {
  // { dg-printf -re "half4_f_4164c===.*===.*===" }
  half4 var1 = (half4) (1,0,-5,1);
  half4 var2 = (half4) (7,5,123445,-3);
  int i = printf("half4_f_4164c===% 10.3v4hf===% 10.3v4hf===\n",var1,var2);
  return i;
}

int half4_f_4165c() {
  // { dg-printf -re "half4_f_4165c===.*===.*===" }
  half4 var1 = (half4) (6,-1,0,-5);
  half4 var2 = (half4) (4,-2,-123455,-6);
  int i = printf("half4_f_4165c===% 10.10v4hf===% 10.10v4hf===\n",var1,var2);
  return i;
}

int half4_f_4166c() {
  // { dg-printf -re "half4_f_4166c===.*===.*===" }
  half4 var1 = (half4) (-1,8,-7,1);
  half4 var2 = (half4) (-8,2,8,123445);
  int i = printf("half4_f_4166c===% 10v4hF===% 10v4hF===\n",var1,var2);
  return i;
}

int half4_f_4167c() {
  // { dg-printf -re "half4_f_4167c===.*===.*===" }
  half4 var1 = (half4) (4,5,-8,-123455);
  half4 var2 = (half4) (-3,-4,-8,-8);
  int i = printf("half4_f_4167c===% 10.1v4hF===% 10.1v4hF===\n",var1,var2);
  return i;
}

int half4_f_4168c() {
  // { dg-printf -re "half4_f_4168c===.*===.*===" }
  half4 var1 = (half4) (-3,-7,-2,-4);
  half4 var2 = (half4) (2,5,8,-5);
  int i = printf("half4_f_4168c===% 10.2v4hF===% 10.2v4hF===\n",var1,var2);
  return i;
}

int half4_f_4169c() {
  // { dg-printf -re "half4_f_4169c===.*===.*===" }
  half4 var1 = (half4) (-2,2,-1,-7);
  half4 var2 = (half4) (-7,3,-8,123445);
  int i = printf("half4_f_4169c===% 10.3v4hF===% 10.3v4hF===\n",var1,var2);
  return i;
}

int half4_f_4170c() {
  // { dg-printf -re "half4_f_4170c===.*===.*===" }
  half4 var1 = (half4) (2,-2,-123455,-7);
  half4 var2 = (half4) (-6,-5,6,6);
  int i = printf("half4_f_4170c===% 10.10v4hF===% 10.10v4hF===\n",var1,var2);
  return i;
}

int half4_f_4921c() {
  // { dg-printf -re "half4_f_4921c===.*===.*===" }
  half4 var1 = (half4) (2,8,-1,-7);
  half4 var2 = (half4) (7,6,-1,4);
  int i = printf("half4_f_4921c===%010v4hf===%010v4hf===\n",var1,var2);
  return i;
}

int half4_f_4922c() {
  // { dg-printf -re "half4_f_4922c===.*===.*===" }
  half4 var1 = (half4) (-3,4,6,2);
  half4 var2 = (half4) (-6,-1,-6,-2);
  int i = printf("half4_f_4922c===%010.1v4hf===%010.1v4hf===\n",var1,var2);
  return i;
}

int half4_f_4923c() {
  // { dg-printf -re "half4_f_4923c===.*===.*===" }
  half4 var1 = (half4) (-2,4,2,-4);
  half4 var2 = (half4) (0,-1,-3,-1);
  int i = printf("half4_f_4923c===%010.2v4hf===%010.2v4hf===\n",var1,var2);
  return i;
}

int half4_f_4924c() {
  // { dg-printf -re "half4_f_4924c===.*===.*===" }
  half4 var1 = (half4) (4,-6,-4,5);
  half4 var2 = (half4) (-2,-4,-2,1);
  int i = printf("half4_f_4924c===%010.3v4hf===%010.3v4hf===\n",var1,var2);
  return i;
}

int half4_f_4925c() {
  // { dg-printf -re "half4_f_4925c===.*===.*===" }
  half4 var1 = (half4) (4,4,4,2);
  half4 var2 = (half4) (-7,123445,5,-8);
  int i = printf("half4_f_4925c===%010.10v4hf===%010.10v4hf===\n",var1,var2);
  return i;
}

int half4_f_4926c() {
  // { dg-printf -re "half4_f_4926c===.*===.*===" }
  half4 var1 = (half4) (1,2,-123455,6);
  half4 var2 = (half4) (-8,-123455,8,-3);
  int i = printf("half4_f_4926c===%010v4hF===%010v4hF===\n",var1,var2);
  return i;
}

int half4_f_4927c() {
  // { dg-printf -re "half4_f_4927c===.*===.*===" }
  half4 var1 = (half4) (3,3,-5,2);
  half4 var2 = (half4) (-2,-8,-8,-8);
  int i = printf("half4_f_4927c===%010.1v4hF===%010.1v4hF===\n",var1,var2);
  return i;
}

int half4_f_4928c() {
  // { dg-printf -re "half4_f_4928c===.*===.*===" }
  half4 var1 = (half4) (-7,8,2,-123455);
  half4 var2 = (half4) (123445,-1,123445,3);
  int i = printf("half4_f_4928c===%010.2v4hF===%010.2v4hF===\n",var1,var2);
  return i;
}

int half4_f_4929c() {
  // { dg-printf -re "half4_f_4929c===.*===.*===" }
  half4 var1 = (half4) (-5,2,-3,-4);
  half4 var2 = (half4) (-123455,-123455,-5,-6);
  int i = printf("half4_f_4929c===%010.3v4hF===%010.3v4hF===\n",var1,var2);
  return i;
}

int half4_f_4930c() {
  // { dg-printf -re "half4_f_4930c===.*===.*===" }
  half4 var1 = (half4) (-2,0,-7,-8);
  half4 var2 = (half4) (8,-4,6,8);
  int i = printf("half4_f_4930c===%010.10v4hF===%010.10v4hF===\n",var1,var2);
  return i;
}

int half4_f_5681c() {
  // { dg-printf -re "half4_f_5681c===.*===.*===" }
  half4 var1 = (half4) (-5,123445,-5,3);
  half4 var2 = (half4) (7,-123455,5,4);
  int i = printf("half4_f_5681c===%- 10v4hf===%- 10v4hf===\n",var1,var2);
  return i;
}

int half4_f_5682c() {
  // { dg-printf -re "half4_f_5682c===.*===.*===" }
  half4 var1 = (half4) (8,-1,-123455,7);
  half4 var2 = (half4) (-6,4,-2,7);
  int i = printf("half4_f_5682c===%- 10.1v4hf===%- 10.1v4hf===\n",var1,var2);
  return i;
}

int half4_f_5683c() {
  // { dg-printf -re "half4_f_5683c===.*===.*===" }
  half4 var1 = (half4) (123445,-3,6,-7);
  half4 var2 = (half4) (-1,1,2,-1);
  int i = printf("half4_f_5683c===%- 10.2v4hf===%- 10.2v4hf===\n",var1,var2);
  return i;
}

int half4_f_5684c() {
  // { dg-printf -re "half4_f_5684c===.*===.*===" }
  half4 var1 = (half4) (-2,3,-1,-1);
  half4 var2 = (half4) (5,3,3,-2);
  int i = printf("half4_f_5684c===%- 10.3v4hf===%- 10.3v4hf===\n",var1,var2);
  return i;
}

int half4_f_5685c() {
  // { dg-printf -re "half4_f_5685c===.*===.*===" }
  half4 var1 = (half4) (-1,-1,1,-2);
  half4 var2 = (half4) (-8,3,7,8);
  int i = printf("half4_f_5685c===%- 10.10v4hf===%- 10.10v4hf===\n",var1,var2);
  return i;
}

int half4_f_5686c() {
  // { dg-printf -re "half4_f_5686c===.*===.*===" }
  half4 var1 = (half4) (0,-3,-1,0);
  half4 var2 = (half4) (-5,1,8,-1);
  int i = printf("half4_f_5686c===%- 10v4hF===%- 10v4hF===\n",var1,var2);
  return i;
}

int half4_f_5687c() {
  // { dg-printf -re "half4_f_5687c===.*===.*===" }
  half4 var1 = (half4) (-8,0,-4,-2);
  half4 var2 = (half4) (6,-5,3,6);
  int i = printf("half4_f_5687c===%- 10.1v4hF===%- 10.1v4hF===\n",var1,var2);
  return i;
}

int half4_f_5688c() {
  // { dg-printf -re "half4_f_5688c===.*===.*===" }
  half4 var1 = (half4) (0,4,7,7);
  half4 var2 = (half4) (7,3,123445,5);
  int i = printf("half4_f_5688c===%- 10.2v4hF===%- 10.2v4hF===\n",var1,var2);
  return i;
}

int half4_f_5689c() {
  // { dg-printf -re "half4_f_5689c===.*===.*===" }
  half4 var1 = (half4) (0,-6,0,0);
  half4 var2 = (half4) (6,-6,7,123445);
  int i = printf("half4_f_5689c===%- 10.3v4hF===%- 10.3v4hF===\n",var1,var2);
  return i;
}

int half4_f_5690c() {
  // { dg-printf -re "half4_f_5690c===.*===.*===" }
  half4 var1 = (half4) (7,-7,-7,8);
  half4 var2 = (half4) (3,-4,123445,-2);
  int i = printf("half4_f_5690c===%- 10.10v4hF===%- 10.10v4hF===\n",var1,var2);
  return i;
}

int half4_f_6441c() {
  // { dg-printf -re "half4_f_6441c===.*===.*===" }
  half4 var1 = (half4) (-3,-123455,123445,6);
  half4 var2 = (half4) (3,-2,7,-1);
  int i = printf("half4_f_6441c===%+ 10v4hf===%+ 10v4hf===\n",var1,var2);
  return i;
}

int half4_f_6442c() {
  // { dg-printf -re "half4_f_6442c===.*===.*===" }
  half4 var1 = (half4) (5,-123455,-1,-5);
  half4 var2 = (half4) (-7,7,-4,0);
  int i = printf("half4_f_6442c===%+ 10.1v4hf===%+ 10.1v4hf===\n",var1,var2);
  return i;
}

int half4_f_6443c() {
  // { dg-printf -re "half4_f_6443c===.*===.*===" }
  half4 var1 = (half4) (-2,-7,-6,-4);
  half4 var2 = (half4) (-8,4,3,-8);
  int i = printf("half4_f_6443c===%+ 10.2v4hf===%+ 10.2v4hf===\n",var1,var2);
  return i;
}

int half4_f_6444c() {
  // { dg-printf -re "half4_f_6444c===.*===.*===" }
  half4 var1 = (half4) (-1,5,-123455,2);
  half4 var2 = (half4) (8,8,-8,-6);
  int i = printf("half4_f_6444c===%+ 10.3v4hf===%+ 10.3v4hf===\n",var1,var2);
  return i;
}

int half4_f_6445c() {
  // { dg-printf -re "half4_f_6445c===.*===.*===" }
  half4 var1 = (half4) (4,3,6,-3);
  half4 var2 = (half4) (-5,4,-8,-2);
  int i = printf("half4_f_6445c===%+ 10.10v4hf===%+ 10.10v4hf===\n",var1,var2);
  return i;
}

int half4_f_6446c() {
  // { dg-printf -re "half4_f_6446c===.*===.*===" }
  half4 var1 = (half4) (6,1,-7,5);
  half4 var2 = (half4) (4,-7,-7,-6);
  int i = printf("half4_f_6446c===%+ 10v4hF===%+ 10v4hF===\n",var1,var2);
  return i;
}

int half4_f_6447c() {
  // { dg-printf -re "half4_f_6447c===.*===.*===" }
  half4 var1 = (half4) (2,0,5,5);
  half4 var2 = (half4) (123445,5,-2,-8);
  int i = printf("half4_f_6447c===%+ 10.1v4hF===%+ 10.1v4hF===\n",var1,var2);
  return i;
}

int half4_f_6448c() {
  // { dg-printf -re "half4_f_6448c===.*===.*===" }
  half4 var1 = (half4) (-2,8,3,-5);
  half4 var2 = (half4) (7,123445,-1,-6);
  int i = printf("half4_f_6448c===%+ 10.2v4hF===%+ 10.2v4hF===\n",var1,var2);
  return i;
}

int half4_f_6449c() {
  // { dg-printf -re "half4_f_6449c===.*===.*===" }
  half4 var1 = (half4) (-1,-4,-6,-6);
  half4 var2 = (half4) (-4,-3,-3,1);
  int i = printf("half4_f_6449c===%+ 10.3v4hF===%+ 10.3v4hF===\n",var1,var2);
  return i;
}

int half4_f_6450c() {
  // { dg-printf -re "half4_f_6450c===.*===.*===" }
  half4 var1 = (half4) (-5,-1,-8,123445);
  half4 var2 = (half4) (-3,-6,4,-1);
  int i = printf("half4_f_6450c===%+ 10.10v4hF===%+ 10.10v4hF===\n",var1,var2);
  return i;
}

int half4_f_7201c() {
  // { dg-printf -re "half4_f_7201c===.*===.*===" }
  half4 var1 = (half4) (-1,5,123445,-3);
  half4 var2 = (half4) (-8,-1,4,1);
  int i = printf("half4_f_7201c===%+010v4hf===%+010v4hf===\n",var1,var2);
  return i;
}

int half4_f_7202c() {
  // { dg-printf -re "half4_f_7202c===.*===.*===" }
  half4 var1 = (half4) (-3,7,-123455,-7);
  half4 var2 = (half4) (4,3,3,1);
  int i = printf("half4_f_7202c===%+010.1v4hf===%+010.1v4hf===\n",var1,var2);
  return i;
}

int half4_f_7203c() {
  // { dg-printf -re "half4_f_7203c===.*===.*===" }
  half4 var1 = (half4) (8,-8,5,6);
  half4 var2 = (half4) (3,5,7,1);
  int i = printf("half4_f_7203c===%+010.2v4hf===%+010.2v4hf===\n",var1,var2);
  return i;
}

int half4_f_7204c() {
  // { dg-printf -re "half4_f_7204c===.*===.*===" }
  half4 var1 = (half4) (5,-7,-7,4);
  half4 var2 = (half4) (-7,-3,-2,1);
  int i = printf("half4_f_7204c===%+010.3v4hf===%+010.3v4hf===\n",var1,var2);
  return i;
}

int half4_f_7205c() {
  // { dg-printf -re "half4_f_7205c===.*===.*===" }
  half4 var1 = (half4) (2,6,4,-3);
  half4 var2 = (half4) (0,1,-3,-7);
  int i = printf("half4_f_7205c===%+010.10v4hf===%+010.10v4hf===\n",var1,var2);
  return i;
}

int half4_f_7206c() {
  // { dg-printf -re "half4_f_7206c===.*===.*===" }
  half4 var1 = (half4) (-6,-2,-8,-6);
  half4 var2 = (half4) (-8,6,-3,7);
  int i = printf("half4_f_7206c===%+010v4hF===%+010v4hF===\n",var1,var2);
  return i;
}

int half4_f_7207c() {
  // { dg-printf -re "half4_f_7207c===.*===.*===" }
  half4 var1 = (half4) (8,7,7,-2);
  half4 var2 = (half4) (8,-1,0,-5);
  int i = printf("half4_f_7207c===%+010.1v4hF===%+010.1v4hF===\n",var1,var2);
  return i;
}

int half4_f_7208c() {
  // { dg-printf -re "half4_f_7208c===.*===.*===" }
  half4 var1 = (half4) (7,-1,-6,8);
  half4 var2 = (half4) (3,-2,-1,6);
  int i = printf("half4_f_7208c===%+010.2v4hF===%+010.2v4hF===\n",var1,var2);
  return i;
}

int half4_f_7209c() {
  // { dg-printf -re "half4_f_7209c===.*===.*===" }
  half4 var1 = (half4) (5,-123455,5,-123455);
  half4 var2 = (half4) (-6,1,8,7);
  int i = printf("half4_f_7209c===%+010.3v4hF===%+010.3v4hF===\n",var1,var2);
  return i;
}

int half4_f_7210c() {
  // { dg-printf -re "half4_f_7210c===.*===.*===" }
  half4 var1 = (half4) (4,1,5,-3);
  half4 var2 = (half4) (-7,5,-5,5);
  int i = printf("half4_f_7210c===%+010.10v4hF===%+010.10v4hF===\n",var1,var2);
  return i;
}

int half4_g_1131c() {
  // { dg-printf -re "half4_g_1131c===.*===.*===" }
  half4 var1 = (half4) (5,-1,-4,-123455);
  half4 var2 = (half4) (123445,4,5,-1);
  int i = printf("half4_g_1131c===%-v4hg===%-v4hg===\n",var1,var2);
  return i;
}

int half4_g_1132c() {
  // { dg-printf -re "half4_g_1132c===.*===.*===" }
  half4 var1 = (half4) (-3,1,7,-3);
  half4 var2 = (half4) (-6,-5,2,123445);
  int i = printf("half4_g_1132c===%-.1v4hg===%-.1v4hg===\n",var1,var2);
  return i;
}

int half4_g_1133c() {
  // { dg-printf -re "half4_g_1133c===.*===.*===" }
  half4 var1 = (half4) (6,-7,-6,123445);
  half4 var2 = (half4) (1,-4,123445,-3);
  int i = printf("half4_g_1133c===%-.2v4hg===%-.2v4hg===\n",var1,var2);
  return i;
}

int half4_g_1134c() {
  // { dg-printf -re "half4_g_1134c===.*===.*===" }
  half4 var1 = (half4) (-3,6,3,3);
  half4 var2 = (half4) (-4,8,1,-7);
  int i = printf("half4_g_1134c===%-.3v4hg===%-.3v4hg===\n",var1,var2);
  return i;
}

int half4_g_1135c() {
  // { dg-printf -re "half4_g_1135c===.*===.*===" }
  half4 var1 = (half4) (5,-8,-5,8);
  half4 var2 = (half4) (6,-3,-7,-1);
  int i = printf("half4_g_1135c===%-.10v4hg===%-.10v4hg===\n",var1,var2);
  return i;
}

int half4_g_1136c() {
  // { dg-printf -re "half4_g_1136c===.*===.*===" }
  half4 var1 = (half4) (-3,123445,6,8);
  half4 var2 = (half4) (-123455,-1,-4,5);
  int i = printf("half4_g_1136c===%-v4hG===%-v4hG===\n",var1,var2);
  return i;
}

int half4_g_1137c() {
  // { dg-printf -re "half4_g_1137c===.*===.*===" }
  half4 var1 = (half4) (-7,7,-2,-7);
  half4 var2 = (half4) (-8,5,-3,6);
  int i = printf("half4_g_1137c===%-.1v4hG===%-.1v4hG===\n",var1,var2);
  return i;
}

int half4_g_1138c() {
  // { dg-printf -re "half4_g_1138c===.*===.*===" }
  half4 var1 = (half4) (-2,-3,1,4);
  half4 var2 = (half4) (4,-6,-123455,-7);
  int i = printf("half4_g_1138c===%-.2v4hG===%-.2v4hG===\n",var1,var2);
  return i;
}

int half4_g_1139c() {
  // { dg-printf -re "half4_g_1139c===.*===.*===" }
  half4 var1 = (half4) (6,123445,123445,-2);
  half4 var2 = (half4) (5,5,8,8);
  int i = printf("half4_g_1139c===%-.3v4hG===%-.3v4hG===\n",var1,var2);
  return i;
}

int half4_g_1140c() {
  // { dg-printf -re "half4_g_1140c===.*===.*===" }
  half4 var1 = (half4) (-4,123445,-1,0);
  half4 var2 = (half4) (8,4,8,0);
  int i = printf("half4_g_1140c===%-.10v4hG===%-.10v4hG===\n",var1,var2);
  return i;
}

int half4_g_1891c() {
  // { dg-printf -re "half4_g_1891c===.*===.*===" }
  half4 var1 = (half4) (4,4,-5,1);
  half4 var2 = (half4) (-2,6,-123455,-1);
  int i = printf("half4_g_1891c===%+v4hg===%+v4hg===\n",var1,var2);
  return i;
}

int half4_g_1892c() {
  // { dg-printf -re "half4_g_1892c===.*===.*===" }
  half4 var1 = (half4) (-1,3,-6,-1);
  half4 var2 = (half4) (-2,-4,8,4);
  int i = printf("half4_g_1892c===%+.1v4hg===%+.1v4hg===\n",var1,var2);
  return i;
}

int half4_g_1893c() {
  // { dg-printf -re "half4_g_1893c===.*===.*===" }
  half4 var1 = (half4) (-6,8,7,6);
  half4 var2 = (half4) (7,-7,6,-1);
  int i = printf("half4_g_1893c===%+.2v4hg===%+.2v4hg===\n",var1,var2);
  return i;
}

int half4_g_1894c() {
  // { dg-printf -re "half4_g_1894c===.*===.*===" }
  half4 var1 = (half4) (-2,-8,1,-8);
  half4 var2 = (half4) (4,8,-2,3);
  int i = printf("half4_g_1894c===%+.3v4hg===%+.3v4hg===\n",var1,var2);
  return i;
}

int half4_g_1895c() {
  // { dg-printf -re "half4_g_1895c===.*===.*===" }
  half4 var1 = (half4) (7,3,7,-6);
  half4 var2 = (half4) (4,-5,-1,5);
  int i = printf("half4_g_1895c===%+.10v4hg===%+.10v4hg===\n",var1,var2);
  return i;
}

int half4_g_1896c() {
  // { dg-printf -re "half4_g_1896c===.*===.*===" }
  half4 var1 = (half4) (4,-6,-123455,1);
  half4 var2 = (half4) (5,1,3,-6);
  int i = printf("half4_g_1896c===%+v4hG===%+v4hG===\n",var1,var2);
  return i;
}

int half4_g_1897c() {
  // { dg-printf -re "half4_g_1897c===.*===.*===" }
  half4 var1 = (half4) (7,2,2,-7);
  half4 var2 = (half4) (6,6,1,-7);
  int i = printf("half4_g_1897c===%+.1v4hG===%+.1v4hG===\n",var1,var2);
  return i;
}

int half4_g_1898c() {
  // { dg-printf -re "half4_g_1898c===.*===.*===" }
  half4 var1 = (half4) (1,-7,-2,-1);
  half4 var2 = (half4) (-2,4,-5,6);
  int i = printf("half4_g_1898c===%+.2v4hG===%+.2v4hG===\n",var1,var2);
  return i;
}

int half4_g_1899c() {
  // { dg-printf -re "half4_g_1899c===.*===.*===" }
  half4 var1 = (half4) (-7,4,-5,123445);
  half4 var2 = (half4) (-5,-8,8,-123455);
  int i = printf("half4_g_1899c===%+.3v4hG===%+.3v4hG===\n",var1,var2);
  return i;
}

int half4_g_1900c() {
  // { dg-printf -re "half4_g_1900c===.*===.*===" }
  half4 var1 = (half4) (123445,-2,7,3);
  half4 var2 = (half4) (1,3,5,7);
  int i = printf("half4_g_1900c===%+.10v4hG===%+.10v4hG===\n",var1,var2);
  return i;
}

int half4_g_2651c() {
  // { dg-printf -re "half4_g_2651c===.*===.*===" }
  half4 var1 = (half4) (0,-7,-5,0);
  half4 var2 = (half4) (123445,-3,123445,5);
  int i = printf("half4_g_2651c===%#v4hg===%#v4hg===\n",var1,var2);
  return i;
}

int half4_g_2652c() {
  // { dg-printf -re "half4_g_2652c===.*===.*===" }
  half4 var1 = (half4) (123445,3,4,123445);
  half4 var2 = (half4) (0,4,7,-7);
  int i = printf("half4_g_2652c===%#.1v4hg===%#.1v4hg===\n",var1,var2);
  return i;
}

int half4_g_2653c() {
  // { dg-printf -re "half4_g_2653c===.*===.*===" }
  half4 var1 = (half4) (4,-5,1,-1);
  half4 var2 = (half4) (-6,-8,1,3);
  int i = printf("half4_g_2653c===%#.2v4hg===%#.2v4hg===\n",var1,var2);
  return i;
}

int half4_g_2654c() {
  // { dg-printf -re "half4_g_2654c===.*===.*===" }
  half4 var1 = (half4) (-3,8,1,6);
  half4 var2 = (half4) (-5,-123455,-1,2);
  int i = printf("half4_g_2654c===%#.3v4hg===%#.3v4hg===\n",var1,var2);
  return i;
}

int half4_g_2655c() {
  // { dg-printf -re "half4_g_2655c===.*===.*===" }
  half4 var1 = (half4) (1,1,-2,-5);
  half4 var2 = (half4) (-1,6,8,0);
  int i = printf("half4_g_2655c===%#.10v4hg===%#.10v4hg===\n",var1,var2);
  return i;
}

int half4_g_2656c() {
  // { dg-printf -re "half4_g_2656c===.*===.*===" }
  half4 var1 = (half4) (-1,-7,3,123445);
  half4 var2 = (half4) (2,6,-2,5);
  int i = printf("half4_g_2656c===%#v4hG===%#v4hG===\n",var1,var2);
  return i;
}

int half4_g_2657c() {
  // { dg-printf -re "half4_g_2657c===.*===.*===" }
  half4 var1 = (half4) (-3,123445,8,-6);
  half4 var2 = (half4) (2,-5,5,1);
  int i = printf("half4_g_2657c===%#.1v4hG===%#.1v4hG===\n",var1,var2);
  return i;
}

int half4_g_2658c() {
  // { dg-printf -re "half4_g_2658c===.*===.*===" }
  half4 var1 = (half4) (-1,123445,123445,-6);
  half4 var2 = (half4) (123445,-7,-2,-8);
  int i = printf("half4_g_2658c===%#.2v4hG===%#.2v4hG===\n",var1,var2);
  return i;
}

int half4_g_2659c() {
  // { dg-printf -re "half4_g_2659c===.*===.*===" }
  half4 var1 = (half4) (6,-5,4,8);
  half4 var2 = (half4) (-1,-123455,-5,-1);
  int i = printf("half4_g_2659c===%#.3v4hG===%#.3v4hG===\n",var1,var2);
  return i;
}

int half4_g_2660c() {
  // { dg-printf -re "half4_g_2660c===.*===.*===" }
  half4 var1 = (half4) (6,7,-6,-6);
  half4 var2 = (half4) (4,1,4,-123455);
  int i = printf("half4_g_2660c===%#.10v4hG===%#.10v4hG===\n",var1,var2);
  return i;
}

int half4_g_3411c() {
  // { dg-printf -re "half4_g_3411c===.*===.*===" }
  half4 var1 = (half4) (-123455,3,-1,-2);
  half4 var2 = (half4) (123445,-123455,-8,5);
  int i = printf("half4_g_3411c===%-+v4hg===%-+v4hg===\n",var1,var2);
  return i;
}

int half4_g_3412c() {
  // { dg-printf -re "half4_g_3412c===.*===.*===" }
  half4 var1 = (half4) (-1,0,-8,-8);
  half4 var2 = (half4) (123445,3,4,4);
  int i = printf("half4_g_3412c===%-+.1v4hg===%-+.1v4hg===\n",var1,var2);
  return i;
}

int half4_g_3413c() {
  // { dg-printf -re "half4_g_3413c===.*===.*===" }
  half4 var1 = (half4) (5,-6,123445,-8);
  half4 var2 = (half4) (-123455,7,6,8);
  int i = printf("half4_g_3413c===%-+.2v4hg===%-+.2v4hg===\n",var1,var2);
  return i;
}

int half4_g_3414c() {
  // { dg-printf -re "half4_g_3414c===.*===.*===" }
  half4 var1 = (half4) (-4,1,4,7);
  half4 var2 = (half4) (-3,-8,2,-1);
  int i = printf("half4_g_3414c===%-+.3v4hg===%-+.3v4hg===\n",var1,var2);
  return i;
}

int half4_g_3415c() {
  // { dg-printf -re "half4_g_3415c===.*===.*===" }
  half4 var1 = (half4) (0,-3,-2,2);
  half4 var2 = (half4) (0,3,-4,123445);
  int i = printf("half4_g_3415c===%-+.10v4hg===%-+.10v4hg===\n",var1,var2);
  return i;
}

int half4_g_3416c() {
  // { dg-printf -re "half4_g_3416c===.*===.*===" }
  half4 var1 = (half4) (-4,0,6,1);
  half4 var2 = (half4) (-4,6,2,-1);
  int i = printf("half4_g_3416c===%-+v4hG===%-+v4hG===\n",var1,var2);
  return i;
}

int half4_g_3417c() {
  // { dg-printf -re "half4_g_3417c===.*===.*===" }
  half4 var1 = (half4) (0,3,-3,-5);
  half4 var2 = (half4) (8,0,-3,-7);
  int i = printf("half4_g_3417c===%-+.1v4hG===%-+.1v4hG===\n",var1,var2);
  return i;
}

int half4_g_3418c() {
  // { dg-printf -re "half4_g_3418c===.*===.*===" }
  half4 var1 = (half4) (123445,8,-5,2);
  half4 var2 = (half4) (-6,-1,0,0);
  int i = printf("half4_g_3418c===%-+.2v4hG===%-+.2v4hG===\n",var1,var2);
  return i;
}

int half4_g_3419c() {
  // { dg-printf -re "half4_g_3419c===.*===.*===" }
  half4 var1 = (half4) (-7,123445,-1,0);
  half4 var2 = (half4) (-2,-4,-3,8);
  int i = printf("half4_g_3419c===%-+.3v4hG===%-+.3v4hG===\n",var1,var2);
  return i;
}

int half4_g_3420c() {
  // { dg-printf -re "half4_g_3420c===.*===.*===" }
  half4 var1 = (half4) (8,6,2,123445);
  half4 var2 = (half4) (4,8,6,7);
  int i = printf("half4_g_3420c===%-+.10v4hG===%-+.10v4hG===\n",var1,var2);
  return i;
}

int half4_g_371c() {
  // { dg-printf -re "half4_g_371c===.*===.*===" }
  half4 var1 = (half4) (8,0,0,-1);
  half4 var2 = (half4) (-123455,-6,-4,-1);
  int i = printf("half4_g_371c===%v4hg===%v4hg===\n",var1,var2);
  return i;
}

int half4_g_372c() {
  // { dg-printf -re "half4_g_372c===.*===.*===" }
  half4 var1 = (half4) (6,-7,-4,-6);
  half4 var2 = (half4) (-3,7,-3,-6);
  int i = printf("half4_g_372c===%.1v4hg===%.1v4hg===\n",var1,var2);
  return i;
}

int half4_g_373c() {
  // { dg-printf -re "half4_g_373c===.*===.*===" }
  half4 var1 = (half4) (1,8,-3,-3);
  half4 var2 = (half4) (-5,-123455,7,7);
  int i = printf("half4_g_373c===%.2v4hg===%.2v4hg===\n",var1,var2);
  return i;
}

int half4_g_374c() {
  // { dg-printf -re "half4_g_374c===.*===.*===" }
  half4 var1 = (half4) (6,2,-6,-1);
  half4 var2 = (half4) (-4,123445,4,-123455);
  int i = printf("half4_g_374c===%.3v4hg===%.3v4hg===\n",var1,var2);
  return i;
}

int half4_g_375c() {
  // { dg-printf -re "half4_g_375c===.*===.*===" }
  half4 var1 = (half4) (6,-4,3,4);
  half4 var2 = (half4) (6,0,-4,3);
  int i = printf("half4_g_375c===%.10v4hg===%.10v4hg===\n",var1,var2);
  return i;
}

int half4_g_376c() {
  // { dg-printf -re "half4_g_376c===.*===.*===" }
  half4 var1 = (half4) (-1,2,2,-6);
  half4 var2 = (half4) (-1,7,-3,-3);
  int i = printf("half4_g_376c===%v4hG===%v4hG===\n",var1,var2);
  return i;
}

int half4_g_377c() {
  // { dg-printf -re "half4_g_377c===.*===.*===" }
  half4 var1 = (half4) (5,7,-7,-2);
  half4 var2 = (half4) (5,-8,0,-6);
  int i = printf("half4_g_377c===%.1v4hG===%.1v4hG===\n",var1,var2);
  return i;
}

int half4_g_378c() {
  // { dg-printf -re "half4_g_378c===.*===.*===" }
  half4 var1 = (half4) (3,-7,3,2);
  half4 var2 = (half4) (-123455,123445,3,-2);
  int i = printf("half4_g_378c===%.2v4hG===%.2v4hG===\n",var1,var2);
  return i;
}

int half4_g_379c() {
  // { dg-printf -re "half4_g_379c===.*===.*===" }
  half4 var1 = (half4) (3,-6,2,-1);
  half4 var2 = (half4) (1,0,6,6);
  int i = printf("half4_g_379c===%.3v4hG===%.3v4hG===\n",var1,var2);
  return i;
}

int half4_g_380c() {
  // { dg-printf -re "half4_g_380c===.*===.*===" }
  half4 var1 = (half4) (3,-123455,8,8);
  half4 var2 = (half4) (2,123445,-1,-8);
  int i = printf("half4_g_380c===%.10v4hG===%.10v4hG===\n",var1,var2);
  return i;
}

int half4_g_4171c() {
  // { dg-printf -re "half4_g_4171c===.*===.*===" }
  half4 var1 = (half4) (-3,-2,-1,6);
  half4 var2 = (half4) (123445,-8,123445,5);
  int i = printf("half4_g_4171c===% 10v4hg===% 10v4hg===\n",var1,var2);
  return i;
}

int half4_g_4172c() {
  // { dg-printf -re "half4_g_4172c===.*===.*===" }
  half4 var1 = (half4) (-123455,3,-6,-2);
  half4 var2 = (half4) (3,5,-4,123445);
  int i = printf("half4_g_4172c===% 10.1v4hg===% 10.1v4hg===\n",var1,var2);
  return i;
}

int half4_g_4173c() {
  // { dg-printf -re "half4_g_4173c===.*===.*===" }
  half4 var1 = (half4) (-8,-4,7,-4);
  half4 var2 = (half4) (-3,-5,-8,-8);
  int i = printf("half4_g_4173c===% 10.2v4hg===% 10.2v4hg===\n",var1,var2);
  return i;
}

int half4_g_4174c() {
  // { dg-printf -re "half4_g_4174c===.*===.*===" }
  half4 var1 = (half4) (-6,5,-123455,1);
  half4 var2 = (half4) (-6,3,8,2);
  int i = printf("half4_g_4174c===% 10.3v4hg===% 10.3v4hg===\n",var1,var2);
  return i;
}

int half4_g_4175c() {
  // { dg-printf -re "half4_g_4175c===.*===.*===" }
  half4 var1 = (half4) (-1,7,-3,-123455);
  half4 var2 = (half4) (-2,123445,-5,4);
  int i = printf("half4_g_4175c===% 10.10v4hg===% 10.10v4hg===\n",var1,var2);
  return i;
}

int half4_g_4176c() {
  // { dg-printf -re "half4_g_4176c===.*===.*===" }
  half4 var1 = (half4) (3,-8,0,-4);
  half4 var2 = (half4) (-4,8,0,8);
  int i = printf("half4_g_4176c===% 10v4hG===% 10v4hG===\n",var1,var2);
  return i;
}

int half4_g_4177c() {
  // { dg-printf -re "half4_g_4177c===.*===.*===" }
  half4 var1 = (half4) (4,2,-123455,-123455);
  half4 var2 = (half4) (-5,2,123445,-7);
  int i = printf("half4_g_4177c===% 10.1v4hG===% 10.1v4hG===\n",var1,var2);
  return i;
}

int half4_g_4178c() {
  // { dg-printf -re "half4_g_4178c===.*===.*===" }
  half4 var1 = (half4) (6,1,5,-3);
  half4 var2 = (half4) (-7,-8,2,-3);
  int i = printf("half4_g_4178c===% 10.2v4hG===% 10.2v4hG===\n",var1,var2);
  return i;
}

int half4_g_4179c() {
  // { dg-printf -re "half4_g_4179c===.*===.*===" }
  half4 var1 = (half4) (123445,-123455,-3,3);
  half4 var2 = (half4) (8,-6,-8,-123455);
  int i = printf("half4_g_4179c===% 10.3v4hG===% 10.3v4hG===\n",var1,var2);
  return i;
}

int half4_g_4180c() {
  // { dg-printf -re "half4_g_4180c===.*===.*===" }
  half4 var1 = (half4) (-123455,-6,-123455,-4);
  half4 var2 = (half4) (-3,-4,-1,3);
  int i = printf("half4_g_4180c===% 10.10v4hG===% 10.10v4hG===\n",var1,var2);
  return i;
}

int half4_g_4931c() {
  // { dg-printf -re "half4_g_4931c===.*===.*===" }
  half4 var1 = (half4) (-6,-3,1,7);
  half4 var2 = (half4) (2,-1,-6,7);
  int i = printf("half4_g_4931c===%010v4hg===%010v4hg===\n",var1,var2);
  return i;
}

int half4_g_4932c() {
  // { dg-printf -re "half4_g_4932c===.*===.*===" }
  half4 var1 = (half4) (8,3,-5,-123455);
  half4 var2 = (half4) (4,-7,-8,-8);
  int i = printf("half4_g_4932c===%010.1v4hg===%010.1v4hg===\n",var1,var2);
  return i;
}

int half4_g_4933c() {
  // { dg-printf -re "half4_g_4933c===.*===.*===" }
  half4 var1 = (half4) (0,-123455,123445,-8);
  half4 var2 = (half4) (4,6,5,6);
  int i = printf("half4_g_4933c===%010.2v4hg===%010.2v4hg===\n",var1,var2);
  return i;
}

int half4_g_4934c() {
  // { dg-printf -re "half4_g_4934c===.*===.*===" }
  half4 var1 = (half4) (4,1,-5,-2);
  half4 var2 = (half4) (2,-4,4,-7);
  int i = printf("half4_g_4934c===%010.3v4hg===%010.3v4hg===\n",var1,var2);
  return i;
}

int half4_g_4935c() {
  // { dg-printf -re "half4_g_4935c===.*===.*===" }
  half4 var1 = (half4) (-3,-7,123445,3);
  half4 var2 = (half4) (-7,-3,-1,0);
  int i = printf("half4_g_4935c===%010.10v4hg===%010.10v4hg===\n",var1,var2);
  return i;
}

int half4_g_4936c() {
  // { dg-printf -re "half4_g_4936c===.*===.*===" }
  half4 var1 = (half4) (2,2,123445,8);
  half4 var2 = (half4) (7,2,-8,-7);
  int i = printf("half4_g_4936c===%010v4hG===%010v4hG===\n",var1,var2);
  return i;
}

int half4_g_4937c() {
  // { dg-printf -re "half4_g_4937c===.*===.*===" }
  half4 var1 = (half4) (-5,8,6,3);
  half4 var2 = (half4) (-3,0,-3,-2);
  int i = printf("half4_g_4937c===%010.1v4hG===%010.1v4hG===\n",var1,var2);
  return i;
}

int half4_g_4938c() {
  // { dg-printf -re "half4_g_4938c===.*===.*===" }
  half4 var1 = (half4) (6,-123455,-1,-7);
  half4 var2 = (half4) (3,-123455,-5,-3);
  int i = printf("half4_g_4938c===%010.2v4hG===%010.2v4hG===\n",var1,var2);
  return i;
}

int half4_g_4939c() {
  // { dg-printf -re "half4_g_4939c===.*===.*===" }
  half4 var1 = (half4) (-7,5,-3,6);
  half4 var2 = (half4) (6,6,123445,-2);
  int i = printf("half4_g_4939c===%010.3v4hG===%010.3v4hG===\n",var1,var2);
  return i;
}

int half4_g_4940c() {
  // { dg-printf -re "half4_g_4940c===.*===.*===" }
  half4 var1 = (half4) (123445,-7,2,7);
  half4 var2 = (half4) (7,-1,6,-7);
  int i = printf("half4_g_4940c===%010.10v4hG===%010.10v4hG===\n",var1,var2);
  return i;
}

int half4_g_5691c() {
  // { dg-printf -re "half4_g_5691c===.*===.*===" }
  half4 var1 = (half4) (-3,3,-3,-3);
  half4 var2 = (half4) (-7,-3,-4,-1);
  int i = printf("half4_g_5691c===%- 10v4hg===%- 10v4hg===\n",var1,var2);
  return i;
}

int half4_g_5692c() {
  // { dg-printf -re "half4_g_5692c===.*===.*===" }
  half4 var1 = (half4) (-5,-5,-1,7);
  half4 var2 = (half4) (3,-2,7,3);
  int i = printf("half4_g_5692c===%- 10.1v4hg===%- 10.1v4hg===\n",var1,var2);
  return i;
}

int half4_g_5693c() {
  // { dg-printf -re "half4_g_5693c===.*===.*===" }
  half4 var1 = (half4) (0,-2,-5,2);
  half4 var2 = (half4) (-123455,6,-7,-123455);
  int i = printf("half4_g_5693c===%- 10.2v4hg===%- 10.2v4hg===\n",var1,var2);
  return i;
}

int half4_g_5694c() {
  // { dg-printf -re "half4_g_5694c===.*===.*===" }
  half4 var1 = (half4) (123445,-5,2,3);
  half4 var2 = (half4) (5,-123455,-8,0);
  int i = printf("half4_g_5694c===%- 10.3v4hg===%- 10.3v4hg===\n",var1,var2);
  return i;
}

int half4_g_5695c() {
  // { dg-printf -re "half4_g_5695c===.*===.*===" }
  half4 var1 = (half4) (7,8,5,-7);
  half4 var2 = (half4) (6,5,7,1);
  int i = printf("half4_g_5695c===%- 10.10v4hg===%- 10.10v4hg===\n",var1,var2);
  return i;
}

int half4_g_5696c() {
  // { dg-printf -re "half4_g_5696c===.*===.*===" }
  half4 var1 = (half4) (-6,123445,1,8);
  half4 var2 = (half4) (7,-1,-6,-7);
  int i = printf("half4_g_5696c===%- 10v4hG===%- 10v4hG===\n",var1,var2);
  return i;
}

int half4_g_5697c() {
  // { dg-printf -re "half4_g_5697c===.*===.*===" }
  half4 var1 = (half4) (-2,-4,8,-6);
  half4 var2 = (half4) (1,0,-3,-8);
  int i = printf("half4_g_5697c===%- 10.1v4hG===%- 10.1v4hG===\n",var1,var2);
  return i;
}

int half4_g_5698c() {
  // { dg-printf -re "half4_g_5698c===.*===.*===" }
  half4 var1 = (half4) (-1,-3,5,-8);
  half4 var2 = (half4) (123445,-123455,-8,2);
  int i = printf("half4_g_5698c===%- 10.2v4hG===%- 10.2v4hG===\n",var1,var2);
  return i;
}

int half4_g_5699c() {
  // { dg-printf -re "half4_g_5699c===.*===.*===" }
  half4 var1 = (half4) (7,2,2,-2);
  half4 var2 = (half4) (7,-123455,-6,-6);
  int i = printf("half4_g_5699c===%- 10.3v4hG===%- 10.3v4hG===\n",var1,var2);
  return i;
}

int half4_g_5700c() {
  // { dg-printf -re "half4_g_5700c===.*===.*===" }
  half4 var1 = (half4) (-4,-1,3,-123455);
  half4 var2 = (half4) (-3,2,3,3);
  int i = printf("half4_g_5700c===%- 10.10v4hG===%- 10.10v4hG===\n",var1,var2);
  return i;
}

int half4_g_6451c() {
  // { dg-printf -re "half4_g_6451c===.*===.*===" }
  half4 var1 = (half4) (3,-8,123445,-7);
  half4 var2 = (half4) (3,123445,-1,123445);
  int i = printf("half4_g_6451c===%+ 10v4hg===%+ 10v4hg===\n",var1,var2);
  return i;
}

int half4_g_6452c() {
  // { dg-printf -re "half4_g_6452c===.*===.*===" }
  half4 var1 = (half4) (-123455,-6,2,-7);
  half4 var2 = (half4) (1,1,-123455,7);
  int i = printf("half4_g_6452c===%+ 10.1v4hg===%+ 10.1v4hg===\n",var1,var2);
  return i;
}

int half4_g_6453c() {
  // { dg-printf -re "half4_g_6453c===.*===.*===" }
  half4 var1 = (half4) (-8,6,-5,-8);
  half4 var2 = (half4) (5,-8,4,-2);
  int i = printf("half4_g_6453c===%+ 10.2v4hg===%+ 10.2v4hg===\n",var1,var2);
  return i;
}

int half4_g_6454c() {
  // { dg-printf -re "half4_g_6454c===.*===.*===" }
  half4 var1 = (half4) (-7,6,-4,-6);
  half4 var2 = (half4) (-8,-5,-1,-1);
  int i = printf("half4_g_6454c===%+ 10.3v4hg===%+ 10.3v4hg===\n",var1,var2);
  return i;
}

int half4_g_6455c() {
  // { dg-printf -re "half4_g_6455c===.*===.*===" }
  half4 var1 = (half4) (-6,-6,1,1);
  half4 var2 = (half4) (-8,-5,-1,-123455);
  int i = printf("half4_g_6455c===%+ 10.10v4hg===%+ 10.10v4hg===\n",var1,var2);
  return i;
}

int half4_g_6456c() {
  // { dg-printf -re "half4_g_6456c===.*===.*===" }
  half4 var1 = (half4) (-3,1,-8,6);
  half4 var2 = (half4) (4,-3,-7,6);
  int i = printf("half4_g_6456c===%+ 10v4hG===%+ 10v4hG===\n",var1,var2);
  return i;
}

int half4_g_6457c() {
  // { dg-printf -re "half4_g_6457c===.*===.*===" }
  half4 var1 = (half4) (0,123445,4,8);
  half4 var2 = (half4) (5,8,-1,-4);
  int i = printf("half4_g_6457c===%+ 10.1v4hG===%+ 10.1v4hG===\n",var1,var2);
  return i;
}

int half4_g_6458c() {
  // { dg-printf -re "half4_g_6458c===.*===.*===" }
  half4 var1 = (half4) (3,123445,4,7);
  half4 var2 = (half4) (-3,-7,6,-6);
  int i = printf("half4_g_6458c===%+ 10.2v4hG===%+ 10.2v4hG===\n",var1,var2);
  return i;
}

int half4_g_6459c() {
  // { dg-printf -re "half4_g_6459c===.*===.*===" }
  half4 var1 = (half4) (2,-5,8,0);
  half4 var2 = (half4) (-6,-2,-123455,-7);
  int i = printf("half4_g_6459c===%+ 10.3v4hG===%+ 10.3v4hG===\n",var1,var2);
  return i;
}

int half4_g_6460c() {
  // { dg-printf -re "half4_g_6460c===.*===.*===" }
  half4 var1 = (half4) (8,-123455,4,7);
  half4 var2 = (half4) (-1,-4,-123455,-6);
  int i = printf("half4_g_6460c===%+ 10.10v4hG===%+ 10.10v4hG===\n",var1,var2);
  return i;
}

int half4_g_7211c() {
  // { dg-printf -re "half4_g_7211c===.*===.*===" }
  half4 var1 = (half4) (-5,-123455,7,-8);
  half4 var2 = (half4) (123445,6,123445,7);
  int i = printf("half4_g_7211c===%+010v4hg===%+010v4hg===\n",var1,var2);
  return i;
}

int half4_g_7212c() {
  // { dg-printf -re "half4_g_7212c===.*===.*===" }
  half4 var1 = (half4) (-8,1,5,-123455);
  half4 var2 = (half4) (5,-7,-3,6);
  int i = printf("half4_g_7212c===%+010.1v4hg===%+010.1v4hg===\n",var1,var2);
  return i;
}

int half4_g_7213c() {
  // { dg-printf -re "half4_g_7213c===.*===.*===" }
  half4 var1 = (half4) (1,2,0,8);
  half4 var2 = (half4) (3,-6,6,-1);
  int i = printf("half4_g_7213c===%+010.2v4hg===%+010.2v4hg===\n",var1,var2);
  return i;
}

int half4_g_7214c() {
  // { dg-printf -re "half4_g_7214c===.*===.*===" }
  half4 var1 = (half4) (-8,123445,-2,-1);
  half4 var2 = (half4) (-7,-4,-123455,-6);
  int i = printf("half4_g_7214c===%+010.3v4hg===%+010.3v4hg===\n",var1,var2);
  return i;
}

int half4_g_7215c() {
  // { dg-printf -re "half4_g_7215c===.*===.*===" }
  half4 var1 = (half4) (1,1,-6,5);
  half4 var2 = (half4) (123445,-4,123445,4);
  int i = printf("half4_g_7215c===%+010.10v4hg===%+010.10v4hg===\n",var1,var2);
  return i;
}

int half4_g_7216c() {
  // { dg-printf -re "half4_g_7216c===.*===.*===" }
  half4 var1 = (half4) (2,-123455,-123455,8);
  half4 var2 = (half4) (2,0,3,-3);
  int i = printf("half4_g_7216c===%+010v4hG===%+010v4hG===\n",var1,var2);
  return i;
}

int half4_g_7217c() {
  // { dg-printf -re "half4_g_7217c===.*===.*===" }
  half4 var1 = (half4) (8,2,-123455,4);
  half4 var2 = (half4) (-7,-3,6,-1);
  int i = printf("half4_g_7217c===%+010.1v4hG===%+010.1v4hG===\n",var1,var2);
  return i;
}

int half4_g_7218c() {
  // { dg-printf -re "half4_g_7218c===.*===.*===" }
  half4 var1 = (half4) (-7,-3,3,-3);
  half4 var2 = (half4) (2,-5,4,-3);
  int i = printf("half4_g_7218c===%+010.2v4hG===%+010.2v4hG===\n",var1,var2);
  return i;
}

int half4_g_7219c() {
  // { dg-printf -re "half4_g_7219c===.*===.*===" }
  half4 var1 = (half4) (7,-7,-5,4);
  half4 var2 = (half4) (-4,-2,8,2);
  int i = printf("half4_g_7219c===%+010.3v4hG===%+010.3v4hG===\n",var1,var2);
  return i;
}

int half4_g_7220c() {
  // { dg-printf -re "half4_g_7220c===.*===.*===" }
  half4 var1 = (half4) (-3,6,2,-3);
  half4 var2 = (half4) (-2,-8,1,5);
  int i = printf("half4_g_7220c===%+010.10v4hG===%+010.10v4hG===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = half4_a_1101c();
i = half4_a_1102c();
i = half4_a_1103c();
i = half4_a_1104c();
i = half4_a_1105c();
i = half4_a_1106c();
i = half4_a_1107c();
i = half4_a_1108c();
i = half4_a_1109c();
i = half4_a_1110c();
i = half4_a_1861c();
i = half4_a_1862c();
i = half4_a_1863c();
i = half4_a_1864c();
i = half4_a_1865c();
i = half4_a_1866c();
i = half4_a_1867c();
i = half4_a_1868c();
i = half4_a_1869c();
i = half4_a_1870c();
i = half4_a_2621c();
i = half4_a_2622c();
i = half4_a_2623c();
i = half4_a_2624c();
i = half4_a_2625c();
i = half4_a_2626c();
i = half4_a_2627c();
i = half4_a_2628c();
i = half4_a_2629c();
i = half4_a_2630c();
i = half4_a_3381c();
i = half4_a_3382c();
i = half4_a_3383c();
i = half4_a_3384c();
i = half4_a_3385c();
i = half4_a_3386c();
i = half4_a_3387c();
i = half4_a_3388c();
i = half4_a_3389c();
i = half4_a_3390c();
i = half4_a_341c();
i = half4_a_342c();
i = half4_a_343c();
i = half4_a_344c();
i = half4_a_345c();
i = half4_a_346c();
i = half4_a_347c();
i = half4_a_348c();
i = half4_a_349c();
i = half4_a_350c();
i = half4_a_4141c();
i = half4_a_4142c();
i = half4_a_4143c();
i = half4_a_4144c();
i = half4_a_4145c();
i = half4_a_4146c();
i = half4_a_4147c();
i = half4_a_4148c();
i = half4_a_4149c();
i = half4_a_4150c();
i = half4_a_4901c();
i = half4_a_4902c();
i = half4_a_4903c();
i = half4_a_4904c();
i = half4_a_4905c();
i = half4_a_4906c();
i = half4_a_4907c();
i = half4_a_4908c();
i = half4_a_4909c();
i = half4_a_4910c();
i = half4_a_5661c();
i = half4_a_5662c();
i = half4_a_5663c();
i = half4_a_5664c();
i = half4_a_5665c();
i = half4_a_5666c();
i = half4_a_5667c();
i = half4_a_5668c();
i = half4_a_5669c();
i = half4_a_5670c();
i = half4_a_6421c();
i = half4_a_6422c();
i = half4_a_6423c();
i = half4_a_6424c();
i = half4_a_6425c();
i = half4_a_6426c();
i = half4_a_6427c();
i = half4_a_6428c();
i = half4_a_6429c();
i = half4_a_6430c();
i = half4_a_7181c();
i = half4_a_7182c();
i = half4_a_7183c();
i = half4_a_7184c();
i = half4_a_7185c();
i = half4_a_7186c();
i = half4_a_7187c();
i = half4_a_7188c();
i = half4_a_7189c();
i = half4_a_7190c();
i = half4_e_1111c();
i = half4_e_1112c();
i = half4_e_1113c();
i = half4_e_1114c();
i = half4_e_1115c();
i = half4_e_1116c();
i = half4_e_1117c();
i = half4_e_1118c();
i = half4_e_1119c();
i = half4_e_1120c();
i = half4_e_1871c();
i = half4_e_1872c();
i = half4_e_1873c();
i = half4_e_1874c();
i = half4_e_1875c();
i = half4_e_1876c();
i = half4_e_1877c();
i = half4_e_1878c();
i = half4_e_1879c();
i = half4_e_1880c();
i = half4_e_2631c();
i = half4_e_2632c();
i = half4_e_2633c();
i = half4_e_2634c();
i = half4_e_2635c();
i = half4_e_2636c();
i = half4_e_2637c();
i = half4_e_2638c();
i = half4_e_2639c();
i = half4_e_2640c();
i = half4_e_3391c();
i = half4_e_3392c();
i = half4_e_3393c();
i = half4_e_3394c();
i = half4_e_3395c();
i = half4_e_3396c();
i = half4_e_3397c();
i = half4_e_3398c();
i = half4_e_3399c();
i = half4_e_3400c();
i = half4_e_351c();
i = half4_e_352c();
i = half4_e_353c();
i = half4_e_354c();
i = half4_e_355c();
i = half4_e_356c();
i = half4_e_357c();
i = half4_e_358c();
i = half4_e_359c();
i = half4_e_360c();
i = half4_e_4151c();
i = half4_e_4152c();
i = half4_e_4153c();
i = half4_e_4154c();
i = half4_e_4155c();
i = half4_e_4156c();
i = half4_e_4157c();
i = half4_e_4158c();
i = half4_e_4159c();
i = half4_e_4160c();
i = half4_e_4911c();
i = half4_e_4912c();
i = half4_e_4913c();
i = half4_e_4914c();
i = half4_e_4915c();
i = half4_e_4916c();
i = half4_e_4917c();
i = half4_e_4918c();
i = half4_e_4919c();
i = half4_e_4920c();
i = half4_e_5671c();
i = half4_e_5672c();
i = half4_e_5673c();
i = half4_e_5674c();
i = half4_e_5675c();
i = half4_e_5676c();
i = half4_e_5677c();
i = half4_e_5678c();
i = half4_e_5679c();
i = half4_e_5680c();
i = half4_e_6431c();
i = half4_e_6432c();
i = half4_e_6433c();
i = half4_e_6434c();
i = half4_e_6435c();
i = half4_e_6436c();
i = half4_e_6437c();
i = half4_e_6438c();
i = half4_e_6439c();
i = half4_e_6440c();
i = half4_e_7191c();
i = half4_e_7192c();
i = half4_e_7193c();
i = half4_e_7194c();
i = half4_e_7195c();
i = half4_e_7196c();
i = half4_e_7197c();
i = half4_e_7198c();
i = half4_e_7199c();
i = half4_e_7200c();
i = half4_f_1121c();
i = half4_f_1122c();
i = half4_f_1123c();
i = half4_f_1124c();
i = half4_f_1125c();
i = half4_f_1126c();
i = half4_f_1127c();
i = half4_f_1128c();
i = half4_f_1129c();
i = half4_f_1130c();
i = half4_f_1881c();
i = half4_f_1882c();
i = half4_f_1883c();
i = half4_f_1884c();
i = half4_f_1885c();
i = half4_f_1886c();
i = half4_f_1887c();
i = half4_f_1888c();
i = half4_f_1889c();
i = half4_f_1890c();
i = half4_f_2641c();
i = half4_f_2642c();
i = half4_f_2643c();
i = half4_f_2644c();
i = half4_f_2645c();
i = half4_f_2646c();
i = half4_f_2647c();
i = half4_f_2648c();
i = half4_f_2649c();
i = half4_f_2650c();
i = half4_f_3401c();
i = half4_f_3402c();
i = half4_f_3403c();
i = half4_f_3404c();
i = half4_f_3405c();
i = half4_f_3406c();
i = half4_f_3407c();
i = half4_f_3408c();
i = half4_f_3409c();
i = half4_f_3410c();
i = half4_f_361c();
i = half4_f_362c();
i = half4_f_363c();
i = half4_f_364c();
i = half4_f_365c();
i = half4_f_366c();
i = half4_f_367c();
i = half4_f_368c();
i = half4_f_369c();
i = half4_f_370c();
i = half4_f_4161c();
i = half4_f_4162c();
i = half4_f_4163c();
i = half4_f_4164c();
i = half4_f_4165c();
i = half4_f_4166c();
i = half4_f_4167c();
i = half4_f_4168c();
i = half4_f_4169c();
i = half4_f_4170c();
i = half4_f_4921c();
i = half4_f_4922c();
i = half4_f_4923c();
i = half4_f_4924c();
i = half4_f_4925c();
i = half4_f_4926c();
i = half4_f_4927c();
i = half4_f_4928c();
i = half4_f_4929c();
i = half4_f_4930c();
i = half4_f_5681c();
i = half4_f_5682c();
i = half4_f_5683c();
i = half4_f_5684c();
i = half4_f_5685c();
i = half4_f_5686c();
i = half4_f_5687c();
i = half4_f_5688c();
i = half4_f_5689c();
i = half4_f_5690c();
i = half4_f_6441c();
i = half4_f_6442c();
i = half4_f_6443c();
i = half4_f_6444c();
i = half4_f_6445c();
i = half4_f_6446c();
i = half4_f_6447c();
i = half4_f_6448c();
i = half4_f_6449c();
i = half4_f_6450c();
i = half4_f_7201c();
i = half4_f_7202c();
i = half4_f_7203c();
i = half4_f_7204c();
i = half4_f_7205c();
i = half4_f_7206c();
i = half4_f_7207c();
i = half4_f_7208c();
i = half4_f_7209c();
i = half4_f_7210c();
i = half4_g_1131c();
i = half4_g_1132c();
i = half4_g_1133c();
i = half4_g_1134c();
i = half4_g_1135c();
i = half4_g_1136c();
i = half4_g_1137c();
i = half4_g_1138c();
i = half4_g_1139c();
i = half4_g_1140c();
i = half4_g_1891c();
i = half4_g_1892c();
i = half4_g_1893c();
i = half4_g_1894c();
i = half4_g_1895c();
i = half4_g_1896c();
i = half4_g_1897c();
i = half4_g_1898c();
i = half4_g_1899c();
i = half4_g_1900c();
i = half4_g_2651c();
i = half4_g_2652c();
i = half4_g_2653c();
i = half4_g_2654c();
i = half4_g_2655c();
i = half4_g_2656c();
i = half4_g_2657c();
i = half4_g_2658c();
i = half4_g_2659c();
i = half4_g_2660c();
i = half4_g_3411c();
i = half4_g_3412c();
i = half4_g_3413c();
i = half4_g_3414c();
i = half4_g_3415c();
i = half4_g_3416c();
i = half4_g_3417c();
i = half4_g_3418c();
i = half4_g_3419c();
i = half4_g_3420c();
i = half4_g_371c();
i = half4_g_372c();
i = half4_g_373c();
i = half4_g_374c();
i = half4_g_375c();
i = half4_g_376c();
i = half4_g_377c();
i = half4_g_378c();
i = half4_g_379c();
i = half4_g_380c();
i = half4_g_4171c();
i = half4_g_4172c();
i = half4_g_4173c();
i = half4_g_4174c();
i = half4_g_4175c();
i = half4_g_4176c();
i = half4_g_4177c();
i = half4_g_4178c();
i = half4_g_4179c();
i = half4_g_4180c();
i = half4_g_4931c();
i = half4_g_4932c();
i = half4_g_4933c();
i = half4_g_4934c();
i = half4_g_4935c();
i = half4_g_4936c();
i = half4_g_4937c();
i = half4_g_4938c();
i = half4_g_4939c();
i = half4_g_4940c();
i = half4_g_5691c();
i = half4_g_5692c();
i = half4_g_5693c();
i = half4_g_5694c();
i = half4_g_5695c();
i = half4_g_5696c();
i = half4_g_5697c();
i = half4_g_5698c();
i = half4_g_5699c();
i = half4_g_5700c();
i = half4_g_6451c();
i = half4_g_6452c();
i = half4_g_6453c();
i = half4_g_6454c();
i = half4_g_6455c();
i = half4_g_6456c();
i = half4_g_6457c();
i = half4_g_6458c();
i = half4_g_6459c();
i = half4_g_6460c();
i = half4_g_7211c();
i = half4_g_7212c();
i = half4_g_7213c();
i = half4_g_7214c();
i = half4_g_7215c();
i = half4_g_7216c();
i = half4_g_7217c();
i = half4_g_7218c();
i = half4_g_7219c();
i = half4_g_7220c();
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
