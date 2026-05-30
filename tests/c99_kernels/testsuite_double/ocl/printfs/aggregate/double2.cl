/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/double2.c'  */

int double2_a_1049c() {
  // { dg-printf "double2_a_1049c===0x1.0000000000000p+0,-0x1.3ae147ae147aep+0===0x1.0000000000000p+0,-0x1.81c84189374bcp+13===" }
  double2 var1 = (double2) (1.0,-1.23);
  double2 var2 = (double2) (1.0,-12345.032);
  int i = printf("double2_a_1049c===%-v2la===%-v2la===\n",var1,var2);
  return i;
}

int double2_a_1050c() {
  // { dg-printf "double2_a_1050c===-0x1.4p+0,-0x1.4p+0===-0x1.4p+0,-0x1.8p+13===" }
  double2 var1 = (double2) (-1.23,-1.23);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_a_1050c===%-.1v2la===%-.1v2la===\n",var1,var2);
  return i;
}

int double2_a_1051c() {
  // { dg-printf "double2_a_1051c===0x1.00p+0,0x1.00p+0===0x0.00p+0,0x1.e2p+16===" }
  double2 var1 = (double2) (1.0,1.0);
  double2 var2 = (double2) (0.0,123455.134);
  int i = printf("double2_a_1051c===%-.2v2la===%-.2v2la===\n",var1,var2);
  return i;
}

int double2_a_1052c() {
  // { dg-printf "double2_a_1052c===0x0.000p+0,0x1.000p+1===-0x1.81cp+13,0x1.000p+0===" }
  double2 var1 = (double2) (0.0,2.0);
  double2 var2 = (double2) (-12345.032,1.0);
  int i = printf("double2_a_1052c===%-.3v2la===%-.3v2la===\n",var1,var2);
  return i;
}

int double2_a_1053c() {
  // { dg-printf "double2_a_1053c===0x1.0000000000p+1,-0x1.81c8418937p+13===0x1.0000000000p+1,0x1.0000000000p+0===" }
  double2 var1 = (double2) (2.0,-12345.032);
  double2 var2 = (double2) (2.0,1.0);
  int i = printf("double2_a_1053c===%-.10v2la===%-.10v2la===\n",var1,var2);
  return i;
}

int double2_a_1054c() {
  // { dg-printf "double2_a_1054c===-0X1.81C84189374BCP+13,0X1.0000000000000P+1===0X1.E23F224DD2F1BP+16,-0X1.3AE147AE147AEP+0===" }
  double2 var1 = (double2) (-12345.032,2.0);
  double2 var2 = (double2) (123455.134,-1.23);
  int i = printf("double2_a_1054c===%-v2lA===%-v2lA===\n",var1,var2);
  return i;
}

int double2_a_1055c() {
  // { dg-printf "double2_a_1055c===0X1.EP+16,-0X1.8P+13===0X1.0P+1,-0X1.4P+0===" }
  double2 var1 = (double2) (123455.134,-12345.032);
  double2 var2 = (double2) (2.0,-1.23);
  int i = printf("double2_a_1055c===%-.1v2lA===%-.1v2lA===\n",var1,var2);
  return i;
}

int double2_a_1056c() {
  // { dg-printf "double2_a_1056c===0X1.00P+0,0X0.00P+0===0X1.00P+1,0X1.00P+1===" }
  double2 var1 = (double2) (1.0,0.0);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_a_1056c===%-.2v2lA===%-.2v2lA===\n",var1,var2);
  return i;
}

int double2_a_1057c() {
  // { dg-printf "double2_a_1057c===-0X1.3AEP+0,0X1.000P+0===0X0.000P+0,-0X1.81CP+13===" }
  double2 var1 = (double2) (-1.23,1.0);
  double2 var2 = (double2) (0.0,-12345.032);
  int i = printf("double2_a_1057c===%-.3v2lA===%-.3v2lA===\n",var1,var2);
  return i;
}

int double2_a_1058c() {
  // { dg-printf "double2_a_1058c===0X0.0000000000P+0,0X0.0000000000P+0===0X1.0000000000P+0,0X1.0000000000P+1===" }
  double2 var1 = (double2) (0.0,0.0);
  double2 var2 = (double2) (1.0,2.0);
  int i = printf("double2_a_1058c===%-.10v2lA===%-.10v2lA===\n",var1,var2);
  return i;
}

int double2_a_1809c() {
  // { dg-printf "double2_a_1809c===+0x1.e23f224dd2f1bp+16,+0x0.0000000000000p+0===-0x1.3ae147ae147aep+0,+0x0.0000000000000p+0===" }
  double2 var1 = (double2) (123455.134,0.0);
  double2 var2 = (double2) (-1.23,0.0);
  int i = printf("double2_a_1809c===%+v2la===%+v2la===\n",var1,var2);
  return i;
}

int double2_a_1810c() {
  // { dg-printf "double2_a_1810c===+0x1.0p+1,+0x1.0p+1===+0x1.ep+16,+0x1.0p+0===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (123455.134,1.0);
  int i = printf("double2_a_1810c===%+.1v2la===%+.1v2la===\n",var1,var2);
  return i;
}

int double2_a_1811c() {
  // { dg-printf "double2_a_1811c===-0x1.3bp+0,+0x1.00p+0===+0x1.e2p+16,+0x1.00p+0===" }
  double2 var1 = (double2) (-1.23,1.0);
  double2 var2 = (double2) (123455.134,1.0);
  int i = printf("double2_a_1811c===%+.2v2la===%+.2v2la===\n",var1,var2);
  return i;
}

int double2_a_1812c() {
  // { dg-printf "double2_a_1812c===-0x1.3aep+0,-0x1.81cp+13===+0x0.000p+0,+0x0.000p+0===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (0.0,0.0);
  int i = printf("double2_a_1812c===%+.3v2la===%+.3v2la===\n",var1,var2);
  return i;
}

int double2_a_1813c() {
  // { dg-printf "double2_a_1813c===+0x0.0000000000p+0,-0x1.3ae147ae14p+0===-0x1.3ae147ae14p+0,-0x1.81c8418937p+13===" }
  double2 var1 = (double2) (0.0,-1.23);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_a_1813c===%+.10v2la===%+.10v2la===\n",var1,var2);
  return i;
}

int double2_a_1814c() {
  // { dg-printf "double2_a_1814c===-0X1.3AE147AE147AEP+0,+0X1.E23F224DD2F1BP+16===+0X1.0000000000000P+0,-0X1.81C84189374BCP+13===" }
  double2 var1 = (double2) (-1.23,123455.134);
  double2 var2 = (double2) (1.0,-12345.032);
  int i = printf("double2_a_1814c===%+v2lA===%+v2lA===\n",var1,var2);
  return i;
}

int double2_a_1815c() {
  // { dg-printf "double2_a_1815c===+0X1.0P+0,-0X1.4P+0===+0X1.0P+0,-0X1.8P+13===" }
  double2 var1 = (double2) (1.0,-1.23);
  double2 var2 = (double2) (1.0,-12345.032);
  int i = printf("double2_a_1815c===%+.1v2lA===%+.1v2lA===\n",var1,var2);
  return i;
}

int double2_a_1816c() {
  // { dg-printf "double2_a_1816c===-0X1.82P+13,-0X1.82P+13===+0X1.00P+1,+0X1.00P+0===" }
  double2 var1 = (double2) (-12345.032,-12345.032);
  double2 var2 = (double2) (2.0,1.0);
  int i = printf("double2_a_1816c===%+.2v2lA===%+.2v2lA===\n",var1,var2);
  return i;
}

int double2_a_1817c() {
  // { dg-printf "double2_a_1817c===+0X1.000P+0,+0X1.000P+0===-0X1.81CP+13,-0X1.3AEP+0===" }
  double2 var1 = (double2) (1.0,1.0);
  double2 var2 = (double2) (-12345.032,-1.23);
  int i = printf("double2_a_1817c===%+.3v2lA===%+.3v2lA===\n",var1,var2);
  return i;
}

int double2_a_1818c() {
  // { dg-printf "double2_a_1818c===+0X1.E23F224DD3P+16,-0X1.3AE147AE14P+0===+0X1.0000000000P+1,-0X1.3AE147AE14P+0===" }
  double2 var1 = (double2) (123455.134,-1.23);
  double2 var2 = (double2) (2.0,-1.23);
  int i = printf("double2_a_1818c===%+.10v2lA===%+.10v2lA===\n",var1,var2);
  return i;
}

int double2_a_2569c() {
  // { dg-printf "double2_a_2569c===-0x1.81c84189374bcp+13,0x1.e23f224dd2f1bp+16===-0x1.3ae147ae147aep+0,-0x1.3ae147ae147aep+0===" }
  double2 var1 = (double2) (-12345.032,123455.134);
  double2 var2 = (double2) (-1.23,-1.23);
  int i = printf("double2_a_2569c===%#v2la===%#v2la===\n",var1,var2);
  return i;
}

int double2_a_2570c() {
  // { dg-printf "double2_a_2570c===0x1.ep+16,0x1.0p+0===0x1.0p+1,-0x1.4p+0===" }
  double2 var1 = (double2) (123455.134,1.0);
  double2 var2 = (double2) (2.0,-1.23);
  int i = printf("double2_a_2570c===%#.1v2la===%#.1v2la===\n",var1,var2);
  return i;
}

int double2_a_2571c() {
  // { dg-printf "double2_a_2571c===-0x1.82p+13,-0x1.3bp+0===0x1.00p+1,-0x1.3bp+0===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (2.0,-1.23);
  int i = printf("double2_a_2571c===%#.2v2la===%#.2v2la===\n",var1,var2);
  return i;
}

int double2_a_2572c() {
  // { dg-printf "double2_a_2572c===-0x1.3aep+0,0x1.000p+0===0x1.000p+0,0x1.e24p+16===" }
  double2 var1 = (double2) (-1.23,1.0);
  double2 var2 = (double2) (1.0,123455.134);
  int i = printf("double2_a_2572c===%#.3v2la===%#.3v2la===\n",var1,var2);
  return i;
}

int double2_a_2573c() {
  // { dg-printf "double2_a_2573c===-0x1.3ae147ae14p+0,0x1.0000000000p+1===-0x1.3ae147ae14p+0,0x1.0000000000p+1===" }
  double2 var1 = (double2) (-1.23,2.0);
  double2 var2 = (double2) (-1.23,2.0);
  int i = printf("double2_a_2573c===%#.10v2la===%#.10v2la===\n",var1,var2);
  return i;
}

int double2_a_2574c() {
  // { dg-printf "double2_a_2574c===-0X1.81C84189374BCP+13,-0X1.81C84189374BCP+13===0X0.0000000000000P+0,0X1.0000000000000P+0===" }
  double2 var1 = (double2) (-12345.032,-12345.032);
  double2 var2 = (double2) (0.0,1.0);
  int i = printf("double2_a_2574c===%#v2lA===%#v2lA===\n",var1,var2);
  return i;
}

int double2_a_2575c() {
  // { dg-printf "double2_a_2575c===0X1.0P+0,0X0.0P+0===-0X1.4P+0,0X1.0P+1===" }
  double2 var1 = (double2) (1.0,0.0);
  double2 var2 = (double2) (-1.23,2.0);
  int i = printf("double2_a_2575c===%#.1v2lA===%#.1v2lA===\n",var1,var2);
  return i;
}

int double2_a_2576c() {
  // { dg-printf "double2_a_2576c===0X1.E2P+16,0X0.00P+0===0X1.E2P+16,-0X1.82P+13===" }
  double2 var1 = (double2) (123455.134,0.0);
  double2 var2 = (double2) (123455.134,-12345.032);
  int i = printf("double2_a_2576c===%#.2v2lA===%#.2v2lA===\n",var1,var2);
  return i;
}

int double2_a_2577c() {
  // { dg-printf "double2_a_2577c===-0X1.81CP+13,-0X1.81CP+13===-0X1.81CP+13,-0X1.81CP+13===" }
  double2 var1 = (double2) (-12345.032,-12345.032);
  double2 var2 = (double2) (-12345.032,-12345.032);
  int i = printf("double2_a_2577c===%#.3v2lA===%#.3v2lA===\n",var1,var2);
  return i;
}

int double2_a_2578c() {
  // { dg-printf "double2_a_2578c===0X1.E23F224DD3P+16,-0X1.81C8418937P+13===-0X1.81C8418937P+13,0X1.E23F224DD3P+16===" }
  double2 var1 = (double2) (123455.134,-12345.032);
  double2 var2 = (double2) (-12345.032,123455.134);
  int i = printf("double2_a_2578c===%#.10v2lA===%#.10v2lA===\n",var1,var2);
  return i;
}

int double2_a_289c() {
  // { dg-printf "double2_a_289c===0x0.0000000000000p+0,0x1.0000000000000p+0===0x1.0000000000000p+1,0x1.0000000000000p+1===" }
  double2 var1 = (double2) (0.0,1.0);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_a_289c===%v2la===%v2la===\n",var1,var2);
  return i;
}

int double2_a_290c() {
  // { dg-printf "double2_a_290c===-0x1.8p+13,-0x1.8p+13===0x1.0p+1,-0x1.4p+0===" }
  double2 var1 = (double2) (-12345.032,-12345.032);
  double2 var2 = (double2) (2.0,-1.23);
  int i = printf("double2_a_290c===%.1v2la===%.1v2la===\n",var1,var2);
  return i;
}

int double2_a_291c() {
  // { dg-printf "double2_a_291c===-0x1.3bp+0,0x1.00p+1===0x0.00p+0,0x1.e2p+16===" }
  double2 var1 = (double2) (-1.23,2.0);
  double2 var2 = (double2) (0.0,123455.134);
  int i = printf("double2_a_291c===%.2v2la===%.2v2la===\n",var1,var2);
  return i;
}

int double2_a_292c() {
  // { dg-printf "double2_a_292c===0x1.000p+1,-0x1.3aep+0===0x1.e24p+16,0x0.000p+0===" }
  double2 var1 = (double2) (2.0,-1.23);
  double2 var2 = (double2) (123455.134,0.0);
  int i = printf("double2_a_292c===%.3v2la===%.3v2la===\n",var1,var2);
  return i;
}

int double2_a_293c() {
  // { dg-printf "double2_a_293c===0x1.e23f224dd3p+16,0x1.0000000000p+1===0x1.0000000000p+0,0x1.e23f224dd3p+16===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (1.0,123455.134);
  int i = printf("double2_a_293c===%.10v2la===%.10v2la===\n",var1,var2);
  return i;
}

int double2_a_294c() {
  // { dg-printf "double2_a_294c===-0X1.3AE147AE147AEP+0,0X1.0000000000000P+0===0X0.0000000000000P+0,-0X1.3AE147AE147AEP+0===" }
  double2 var1 = (double2) (-1.23,1.0);
  double2 var2 = (double2) (0.0,-1.23);
  int i = printf("double2_a_294c===%v2lA===%v2lA===\n",var1,var2);
  return i;
}

int double2_a_295c() {
  // { dg-printf "double2_a_295c===-0X1.4P+0,0X1.0P+1===0X1.EP+16,0X0.0P+0===" }
  double2 var1 = (double2) (-1.23,2.0);
  double2 var2 = (double2) (123455.134,0.0);
  int i = printf("double2_a_295c===%.1v2lA===%.1v2lA===\n",var1,var2);
  return i;
}

int double2_a_296c() {
  // { dg-printf "double2_a_296c===0X0.00P+0,0X0.00P+0===0X1.00P+0,-0X1.82P+13===" }
  double2 var1 = (double2) (0.0,0.0);
  double2 var2 = (double2) (1.0,-12345.032);
  int i = printf("double2_a_296c===%.2v2lA===%.2v2lA===\n",var1,var2);
  return i;
}

int double2_a_297c() {
  // { dg-printf "double2_a_297c===-0X1.3AEP+0,0X1.000P+0===0X0.000P+0,-0X1.3AEP+0===" }
  double2 var1 = (double2) (-1.23,1.0);
  double2 var2 = (double2) (0.0,-1.23);
  int i = printf("double2_a_297c===%.3v2lA===%.3v2lA===\n",var1,var2);
  return i;
}

int double2_a_298c() {
  // { dg-printf "double2_a_298c===-0X1.3AE147AE14P+0,0X0.0000000000P+0===0X1.0000000000P+0,-0X1.3AE147AE14P+0===" }
  double2 var1 = (double2) (-1.23,0.0);
  double2 var2 = (double2) (1.0,-1.23);
  int i = printf("double2_a_298c===%.10v2lA===%.10v2lA===\n",var1,var2);
  return i;
}

int double2_a_3329c() {
  // { dg-printf "double2_a_3329c===+0x1.e23f224dd2f1bp+16,-0x1.81c84189374bcp+13===+0x0.0000000000000p+0,+0x1.0000000000000p+1===" }
  double2 var1 = (double2) (123455.134,-12345.032);
  double2 var2 = (double2) (0.0,2.0);
  int i = printf("double2_a_3329c===%-+v2la===%-+v2la===\n",var1,var2);
  return i;
}

int double2_a_3330c() {
  // { dg-printf "double2_a_3330c===+0x0.0p+0,+0x1.0p+1===-0x1.8p+13,-0x1.8p+13===" }
  double2 var1 = (double2) (0.0,2.0);
  double2 var2 = (double2) (-12345.032,-12345.032);
  int i = printf("double2_a_3330c===%-+.1v2la===%-+.1v2la===\n",var1,var2);
  return i;
}

int double2_a_3331c() {
  // { dg-printf "double2_a_3331c===-0x1.82p+13,-0x1.3bp+0===+0x1.e2p+16,-0x1.3bp+0===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (123455.134,-1.23);
  int i = printf("double2_a_3331c===%-+.2v2la===%-+.2v2la===\n",var1,var2);
  return i;
}

int double2_a_3332c() {
  // { dg-printf "double2_a_3332c===+0x1.000p+1,+0x1.000p+1===+0x1.000p+1,-0x1.81cp+13===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (2.0,-12345.032);
  int i = printf("double2_a_3332c===%-+.3v2la===%-+.3v2la===\n",var1,var2);
  return i;
}

int double2_a_3333c() {
  // { dg-printf "double2_a_3333c===+0x0.0000000000p+0,-0x1.81c8418937p+13===-0x1.81c8418937p+13,+0x0.0000000000p+0===" }
  double2 var1 = (double2) (0.0,-12345.032);
  double2 var2 = (double2) (-12345.032,0.0);
  int i = printf("double2_a_3333c===%-+.10v2la===%-+.10v2la===\n",var1,var2);
  return i;
}

int double2_a_3334c() {
  // { dg-printf "double2_a_3334c===+0X1.E23F224DD2F1BP+16,+0X1.E23F224DD2F1BP+16===+0X1.0000000000000P+0,+0X1.0000000000000P+1===" }
  double2 var1 = (double2) (123455.134,123455.134);
  double2 var2 = (double2) (1.0,2.0);
  int i = printf("double2_a_3334c===%-+v2lA===%-+v2lA===\n",var1,var2);
  return i;
}

int double2_a_3335c() {
  // { dg-printf "double2_a_3335c===+0X1.0P+0,-0X1.4P+0===+0X1.0P+0,-0X1.8P+13===" }
  double2 var1 = (double2) (1.0,-1.23);
  double2 var2 = (double2) (1.0,-12345.032);
  int i = printf("double2_a_3335c===%-+.1v2lA===%-+.1v2lA===\n",var1,var2);
  return i;
}

int double2_a_3336c() {
  // { dg-printf "double2_a_3336c===-0X1.3BP+0,+0X1.00P+1===-0X1.3BP+0,+0X1.E2P+16===" }
  double2 var1 = (double2) (-1.23,2.0);
  double2 var2 = (double2) (-1.23,123455.134);
  int i = printf("double2_a_3336c===%-+.2v2lA===%-+.2v2lA===\n",var1,var2);
  return i;
}

int double2_a_3337c() {
  // { dg-printf "double2_a_3337c===-0X1.81CP+13,-0X1.3AEP+0===+0X1.000P+0,-0X1.3AEP+0===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (1.0,-1.23);
  int i = printf("double2_a_3337c===%-+.3v2lA===%-+.3v2lA===\n",var1,var2);
  return i;
}

int double2_a_3338c() {
  // { dg-printf "double2_a_3338c===-0X1.81C8418937P+13,-0X1.81C8418937P+13===-0X1.81C8418937P+13,+0X1.0000000000P+0===" }
  double2 var1 = (double2) (-12345.032,-12345.032);
  double2 var2 = (double2) (-12345.032,1.0);
  int i = printf("double2_a_3338c===%-+.10v2lA===%-+.10v2lA===\n",var1,var2);
  return i;
}

int double2_a_4089c() {
  // { dg-printf "double2_a_4089c=== 0x1.e23f224dd2f1bp+16, 0x1.e23f224dd2f1bp+16===-0x1.3ae147ae147aep+0,-0x1.3ae147ae147aep+0===" }
  double2 var1 = (double2) (123455.134,123455.134);
  double2 var2 = (double2) (-1.23,-1.23);
  int i = printf("double2_a_4089c===% 10v2la===% 10v2la===\n",var1,var2);
  return i;
}

int double2_a_4090c() {
  // { dg-printf "double2_a_4090c=== 0x1.ep+16,  0x0.0p+0===-0x1.8p+13,  0x0.0p+0===" }
  double2 var1 = (double2) (123455.134,0.0);
  double2 var2 = (double2) (-12345.032,0.0);
  int i = printf("double2_a_4090c===% 10.1v2la===% 10.1v2la===\n",var1,var2);
  return i;
}

int double2_a_4091c() {
  // { dg-printf "double2_a_4091c=== 0x1.e2p+16, 0x1.00p+1===-0x1.3bp+0, 0x1.00p+0===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (-1.23,1.0);
  int i = printf("double2_a_4091c===% 10.2v2la===% 10.2v2la===\n",var1,var2);
  return i;
}

int double2_a_4092c() {
  // { dg-printf "double2_a_4092c===-0x1.3aep+0,-0x1.3aep+0=== 0x1.000p+1, 0x0.000p+0===" }
  double2 var1 = (double2) (-1.23,-1.23);
  double2 var2 = (double2) (2.0,0.0);
  int i = printf("double2_a_4092c===% 10.3v2la===% 10.3v2la===\n",var1,var2);
  return i;
}

int double2_a_4093c() {
  // { dg-printf "double2_a_4093c=== 0x1.0000000000p+0, 0x1.0000000000p+0=== 0x0.0000000000p+0,-0x1.81c8418937p+13===" }
  double2 var1 = (double2) (1.0,1.0);
  double2 var2 = (double2) (0.0,-12345.032);
  int i = printf("double2_a_4093c===% 10.10v2la===% 10.10v2la===\n",var1,var2);
  return i;
}

int double2_a_4094c() {
  // { dg-printf "double2_a_4094c===-0X1.3AE147AE147AEP+0,-0X1.3AE147AE147AEP+0===-0X1.81C84189374BCP+13, 0X1.0000000000000P+0===" }
  double2 var1 = (double2) (-1.23,-1.23);
  double2 var2 = (double2) (-12345.032,1.0);
  int i = printf("double2_a_4094c===% 10v2lA===% 10v2lA===\n",var1,var2);
  return i;
}

int double2_a_4095c() {
  // { dg-printf "double2_a_4095c===  0X1.0P+1,  0X1.0P+1===  0X1.0P+0, 0X1.EP+16===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (1.0,123455.134);
  int i = printf("double2_a_4095c===% 10.1v2lA===% 10.1v2lA===\n",var1,var2);
  return i;
}

int double2_a_4096c() {
  // { dg-printf "double2_a_4096c=== 0X0.00P+0,-0X1.82P+13=== 0X1.00P+0, 0X1.00P+0===" }
  double2 var1 = (double2) (0.0,-12345.032);
  double2 var2 = (double2) (1.0,1.0);
  int i = printf("double2_a_4096c===% 10.2v2lA===% 10.2v2lA===\n",var1,var2);
  return i;
}

int double2_a_4097c() {
  // { dg-printf "double2_a_4097c=== 0X1.000P+1,-0X1.3AEP+0=== 0X1.E24P+16,-0X1.81CP+13===" }
  double2 var1 = (double2) (2.0,-1.23);
  double2 var2 = (double2) (123455.134,-12345.032);
  int i = printf("double2_a_4097c===% 10.3v2lA===% 10.3v2lA===\n",var1,var2);
  return i;
}

int double2_a_4098c() {
  // { dg-printf "double2_a_4098c===-0X1.3AE147AE14P+0,-0X1.81C8418937P+13=== 0X0.0000000000P+0, 0X1.0000000000P+0===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (0.0,1.0);
  int i = printf("double2_a_4098c===% 10.10v2lA===% 10.10v2lA===\n",var1,var2);
  return i;
}

int double2_a_4849c() {
  // { dg-printf "double2_a_4849c===0x1.0000000000000p+1,0x1.0000000000000p+1===0x1.0000000000000p+1,-0x1.81c84189374bcp+13===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (2.0,-12345.032);
  int i = printf("double2_a_4849c===%010v2la===%010v2la===\n",var1,var2);
  return i;
}

int double2_a_4850c() {
  // { dg-printf "double2_a_4850c===-0x1.8p+13,0x01.ep+16===0x000.0p+0,-0x01.4p+0===" }
  double2 var1 = (double2) (-12345.032,123455.134);
  double2 var2 = (double2) (0.0,-1.23);
  int i = printf("double2_a_4850c===%010.1v2la===%010.1v2la===\n",var1,var2);
  return i;
}

int double2_a_4851c() {
  // { dg-printf "double2_a_4851c===0x01.00p+0,0x1.e2p+16===-0x1.3bp+0,0x00.00p+0===" }
  double2 var1 = (double2) (1.0,123455.134);
  double2 var2 = (double2) (-1.23,0.0);
  int i = printf("double2_a_4851c===%010.2v2la===%010.2v2la===\n",var1,var2);
  return i;
}

int double2_a_4852c() {
  // { dg-printf "double2_a_4852c===0x0.000p+0,0x1.000p+0===0x1.e24p+16,-0x1.81cp+13===" }
  double2 var1 = (double2) (0.0,1.0);
  double2 var2 = (double2) (123455.134,-12345.032);
  int i = printf("double2_a_4852c===%010.3v2la===%010.3v2la===\n",var1,var2);
  return i;
}

int double2_a_4853c() {
  // { dg-printf "double2_a_4853c===0x1.e23f224dd3p+16,0x1.e23f224dd3p+16===-0x1.3ae147ae14p+0,0x1.e23f224dd3p+16===" }
  double2 var1 = (double2) (123455.134,123455.134);
  double2 var2 = (double2) (-1.23,123455.134);
  int i = printf("double2_a_4853c===%010.10v2la===%010.10v2la===\n",var1,var2);
  return i;
}

int double2_a_4854c() {
  // { dg-printf "double2_a_4854c===0X1.E23F224DD2F1BP+16,0X1.0000000000000P+1===0X1.E23F224DD2F1BP+16,0X1.E23F224DD2F1BP+16===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (123455.134,123455.134);
  int i = printf("double2_a_4854c===%010v2lA===%010v2lA===\n",var1,var2);
  return i;
}

int double2_a_4855c() {
  // { dg-printf "double2_a_4855c===-0X01.4P+0,0X000.0P+0===0X001.0P+1,0X01.EP+16===" }
  double2 var1 = (double2) (-1.23,0.0);
  double2 var2 = (double2) (2.0,123455.134);
  int i = printf("double2_a_4855c===%010.1v2lA===%010.1v2lA===\n",var1,var2);
  return i;
}

int double2_a_4856c() {
  // { dg-printf "double2_a_4856c===-0X1.82P+13,-0X1.3BP+0===-0X1.82P+13,0X01.00P+0===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (-12345.032,1.0);
  int i = printf("double2_a_4856c===%010.2v2lA===%010.2v2lA===\n",var1,var2);
  return i;
}

int double2_a_4857c() {
  // { dg-printf "double2_a_4857c===-0X1.81CP+13,-0X1.81CP+13===0X0.000P+0,0X1.000P+0===" }
  double2 var1 = (double2) (-12345.032,-12345.032);
  double2 var2 = (double2) (0.0,1.0);
  int i = printf("double2_a_4857c===%010.3v2lA===%010.3v2lA===\n",var1,var2);
  return i;
}

int double2_a_4858c() {
  // { dg-printf "double2_a_4858c===-0X1.81C8418937P+13,-0X1.81C8418937P+13===-0X1.3AE147AE14P+0,0X1.0000000000P+0===" }
  double2 var1 = (double2) (-12345.032,-12345.032);
  double2 var2 = (double2) (-1.23,1.0);
  int i = printf("double2_a_4858c===%010.10v2lA===%010.10v2lA===\n",var1,var2);
  return i;
}

int double2_a_5609c() {
  // { dg-printf "double2_a_5609c===-0x1.3ae147ae147aep+0, 0x1.e23f224dd2f1bp+16=== 0x1.0000000000000p+1, 0x1.0000000000000p+1===" }
  double2 var1 = (double2) (-1.23,123455.134);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_a_5609c===%- 10v2la===%- 10v2la===\n",var1,var2);
  return i;
}

int double2_a_5610c() {
  // { dg-printf "double2_a_5610c=== 0x1.0p+1 , 0x1.ep+16===-0x1.4p+0 ,-0x1.4p+0 ===" }
  double2 var1 = (double2) (2.0,123455.134);
  double2 var2 = (double2) (-1.23,-1.23);
  int i = printf("double2_a_5610c===%- 10.1v2la===%- 10.1v2la===\n",var1,var2);
  return i;
}

int double2_a_5611c() {
  // { dg-printf "double2_a_5611c=== 0x0.00p+0, 0x1.00p+1===-0x1.3bp+0, 0x0.00p+0===" }
  double2 var1 = (double2) (0.0,2.0);
  double2 var2 = (double2) (-1.23,0.0);
  int i = printf("double2_a_5611c===%- 10.2v2la===%- 10.2v2la===\n",var1,var2);
  return i;
}

int double2_a_5612c() {
  // { dg-printf "double2_a_5612c===-0x1.81cp+13, 0x1.e24p+16===-0x1.81cp+13, 0x0.000p+0===" }
  double2 var1 = (double2) (-12345.032,123455.134);
  double2 var2 = (double2) (-12345.032,0.0);
  int i = printf("double2_a_5612c===%- 10.3v2la===%- 10.3v2la===\n",var1,var2);
  return i;
}

int double2_a_5613c() {
  // { dg-printf "double2_a_5613c===-0x1.3ae147ae14p+0, 0x0.0000000000p+0=== 0x1.0000000000p+0, 0x1.0000000000p+0===" }
  double2 var1 = (double2) (-1.23,0.0);
  double2 var2 = (double2) (1.0,1.0);
  int i = printf("double2_a_5613c===%- 10.10v2la===%- 10.10v2la===\n",var1,var2);
  return i;
}

int double2_a_5614c() {
  // { dg-printf "double2_a_5614c=== 0X1.E23F224DD2F1BP+16, 0X0.0000000000000P+0=== 0X1.0000000000000P+1, 0X1.0000000000000P+1===" }
  double2 var1 = (double2) (123455.134,0.0);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_a_5614c===%- 10v2lA===%- 10v2lA===\n",var1,var2);
  return i;
}

int double2_a_5615c() {
  // { dg-printf "double2_a_5615c===-0X1.4P+0 , 0X1.0P+1 === 0X1.EP+16, 0X1.0P+1 ===" }
  double2 var1 = (double2) (-1.23,2.0);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_a_5615c===%- 10.1v2lA===%- 10.1v2lA===\n",var1,var2);
  return i;
}

int double2_a_5616c() {
  // { dg-printf "double2_a_5616c=== 0X1.00P+1, 0X1.00P+1=== 0X1.00P+0,-0X1.82P+13===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (1.0,-12345.032);
  int i = printf("double2_a_5616c===%- 10.2v2lA===%- 10.2v2lA===\n",var1,var2);
  return i;
}

int double2_a_5617c() {
  // { dg-printf "double2_a_5617c=== 0X1.E24P+16, 0X1.000P+0=== 0X1.E24P+16, 0X1.000P+1===" }
  double2 var1 = (double2) (123455.134,1.0);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_a_5617c===%- 10.3v2lA===%- 10.3v2lA===\n",var1,var2);
  return i;
}

int double2_a_5618c() {
  // { dg-printf "double2_a_5618c=== 0X1.E23F224DD3P+16, 0X0.0000000000P+0===-0X1.3AE147AE14P+0, 0X1.0000000000P+1===" }
  double2 var1 = (double2) (123455.134,0.0);
  double2 var2 = (double2) (-1.23,2.0);
  int i = printf("double2_a_5618c===%- 10.10v2lA===%- 10.10v2lA===\n",var1,var2);
  return i;
}

int double2_a_6369c() {
  // { dg-printf "double2_a_6369c===+0x1.0000000000000p+0,+0x1.0000000000000p+0===+0x1.0000000000000p+0,-0x1.3ae147ae147aep+0===" }
  double2 var1 = (double2) (1.0,1.0);
  double2 var2 = (double2) (1.0,-1.23);
  int i = printf("double2_a_6369c===%+ 10v2la===%+ 10v2la===\n",var1,var2);
  return i;
}

int double2_a_6370c() {
  // { dg-printf "double2_a_6370c=== -0x1.4p+0,-0x1.8p+13=== +0x1.0p+1, +0x1.0p+0===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (2.0,1.0);
  int i = printf("double2_a_6370c===%+ 10.1v2la===%+ 10.1v2la===\n",var1,var2);
  return i;
}

int double2_a_6371c() {
  // { dg-printf "double2_a_6371c===+0x1.00p+1,-0x1.3bp+0===+0x1.00p+1,+0x0.00p+0===" }
  double2 var1 = (double2) (2.0,-1.23);
  double2 var2 = (double2) (2.0,0.0);
  int i = printf("double2_a_6371c===%+ 10.2v2la===%+ 10.2v2la===\n",var1,var2);
  return i;
}

int double2_a_6372c() {
  // { dg-printf "double2_a_6372c===-0x1.3aep+0,+0x1.e24p+16===+0x0.000p+0,-0x1.3aep+0===" }
  double2 var1 = (double2) (-1.23,123455.134);
  double2 var2 = (double2) (0.0,-1.23);
  int i = printf("double2_a_6372c===%+ 10.3v2la===%+ 10.3v2la===\n",var1,var2);
  return i;
}

int double2_a_6373c() {
  // { dg-printf "double2_a_6373c===+0x1.e23f224dd3p+16,-0x1.3ae147ae14p+0===-0x1.3ae147ae14p+0,+0x1.e23f224dd3p+16===" }
  double2 var1 = (double2) (123455.134,-1.23);
  double2 var2 = (double2) (-1.23,123455.134);
  int i = printf("double2_a_6373c===%+ 10.10v2la===%+ 10.10v2la===\n",var1,var2);
  return i;
}

int double2_a_6374c() {
  // { dg-printf "double2_a_6374c===-0X1.3AE147AE147AEP+0,+0X1.E23F224DD2F1BP+16===+0X1.0000000000000P+0,+0X1.E23F224DD2F1BP+16===" }
  double2 var1 = (double2) (-1.23,123455.134);
  double2 var2 = (double2) (1.0,123455.134);
  int i = printf("double2_a_6374c===%+ 10v2lA===%+ 10v2lA===\n",var1,var2);
  return i;
}

int double2_a_6375c() {
  // { dg-printf "double2_a_6375c=== +0X0.0P+0, +0X1.0P+0===+0X1.EP+16, +0X1.0P+1===" }
  double2 var1 = (double2) (0.0,1.0);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_a_6375c===%+ 10.1v2lA===%+ 10.1v2lA===\n",var1,var2);
  return i;
}

int double2_a_6376c() {
  // { dg-printf "double2_a_6376c===+0X1.00P+1,+0X0.00P+0===+0X1.00P+1,+0X0.00P+0===" }
  double2 var1 = (double2) (2.0,0.0);
  double2 var2 = (double2) (2.0,0.0);
  int i = printf("double2_a_6376c===%+ 10.2v2lA===%+ 10.2v2lA===\n",var1,var2);
  return i;
}

int double2_a_6377c() {
  // { dg-printf "double2_a_6377c===-0X1.81CP+13,+0X1.E24P+16===-0X1.81CP+13,+0X1.E24P+16===" }
  double2 var1 = (double2) (-12345.032,123455.134);
  double2 var2 = (double2) (-12345.032,123455.134);
  int i = printf("double2_a_6377c===%+ 10.3v2lA===%+ 10.3v2lA===\n",var1,var2);
  return i;
}

int double2_a_6378c() {
  // { dg-printf "double2_a_6378c===-0X1.81C8418937P+13,+0X1.0000000000P+0===+0X1.E23F224DD3P+16,+0X0.0000000000P+0===" }
  double2 var1 = (double2) (-12345.032,1.0);
  double2 var2 = (double2) (123455.134,0.0);
  int i = printf("double2_a_6378c===%+ 10.10v2lA===%+ 10.10v2lA===\n",var1,var2);
  return i;
}

int double2_a_7129c() {
  // { dg-printf "double2_a_7129c===+0x0.0000000000000p+0,+0x0.0000000000000p+0===+0x1.0000000000000p+1,+0x1.0000000000000p+1===" }
  double2 var1 = (double2) (0.0,0.0);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_a_7129c===%+010v2la===%+010v2la===\n",var1,var2);
  return i;
}

int double2_a_7130c() {
  // { dg-printf "double2_a_7130c===+0x01.0p+1,+0x01.0p+1===+0x01.0p+0,+0x1.ep+16===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (1.0,123455.134);
  int i = printf("double2_a_7130c===%+010.1v2la===%+010.1v2la===\n",var1,var2);
  return i;
}

int double2_a_7131c() {
  // { dg-printf "double2_a_7131c===+0x1.00p+0,+0x1.00p+0===-0x1.82p+13,-0x1.3bp+0===" }
  double2 var1 = (double2) (1.0,1.0);
  double2 var2 = (double2) (-12345.032,-1.23);
  int i = printf("double2_a_7131c===%+010.2v2la===%+010.2v2la===\n",var1,var2);
  return i;
}

int double2_a_7132c() {
  // { dg-printf "double2_a_7132c===-0x1.3aep+0,-0x1.81cp+13===+0x0.000p+0,+0x1.000p+1===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (0.0,2.0);
  int i = printf("double2_a_7132c===%+010.3v2la===%+010.3v2la===\n",var1,var2);
  return i;
}

int double2_a_7133c() {
  // { dg-printf "double2_a_7133c===+0x1.e23f224dd3p+16,+0x1.e23f224dd3p+16===-0x1.81c8418937p+13,+0x1.e23f224dd3p+16===" }
  double2 var1 = (double2) (123455.134,123455.134);
  double2 var2 = (double2) (-12345.032,123455.134);
  int i = printf("double2_a_7133c===%+010.10v2la===%+010.10v2la===\n",var1,var2);
  return i;
}

int double2_a_7134c() {
  // { dg-printf "double2_a_7134c===-0X1.81C84189374BCP+13,+0X0.0000000000000P+0===-0X1.81C84189374BCP+13,-0X1.3AE147AE147AEP+0===" }
  double2 var1 = (double2) (-12345.032,0.0);
  double2 var2 = (double2) (-12345.032,-1.23);
  int i = printf("double2_a_7134c===%+010v2lA===%+010v2lA===\n",var1,var2);
  return i;
}

int double2_a_7135c() {
  // { dg-printf "double2_a_7135c===+0X01.0P+1,+0X01.0P+1===+0X1.EP+16,-0X1.8P+13===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (123455.134,-12345.032);
  int i = printf("double2_a_7135c===%+010.1v2lA===%+010.1v2lA===\n",var1,var2);
  return i;
}

int double2_a_7136c() {
  // { dg-printf "double2_a_7136c===-0X1.3BP+0,+0X0.00P+0===+0X1.E2P+16,-0X1.3BP+0===" }
  double2 var1 = (double2) (-1.23,0.0);
  double2 var2 = (double2) (123455.134,-1.23);
  int i = printf("double2_a_7136c===%+010.2v2lA===%+010.2v2lA===\n",var1,var2);
  return i;
}

int double2_a_7137c() {
  // { dg-printf "double2_a_7137c===+0X1.E24P+16,+0X1.000P+1===+0X1.E24P+16,-0X1.81CP+13===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (123455.134,-12345.032);
  int i = printf("double2_a_7137c===%+010.3v2lA===%+010.3v2lA===\n",var1,var2);
  return i;
}

int double2_a_7138c() {
  // { dg-printf "double2_a_7138c===+0X1.0000000000P+0,-0X1.3AE147AE14P+0===+0X1.0000000000P+1,+0X1.0000000000P+1===" }
  double2 var1 = (double2) (1.0,-1.23);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_a_7138c===%+010.10v2lA===%+010.10v2lA===\n",var1,var2);
  return i;
}

int double2_e_1059c() {
  // { dg-printf "double2_e_1059c===0.000000e+00,1.234551e+05===1.000000e+00,2.000000e+00===" }
  double2 var1 = (double2) (0.0,123455.134);
  double2 var2 = (double2) (1.0,2.0);
  int i = printf("double2_e_1059c===%-v2le===%-v2le===\n",var1,var2);
  return i;
}

int double2_e_1060c() {
  // { dg-printf "double2_e_1060c===-1.2e+04,0.0e+00===-1.2e+04,-1.2e+04===" }
  double2 var1 = (double2) (-12345.032,0.0);
  double2 var2 = (double2) (-12345.032,-12345.032);
  int i = printf("double2_e_1060c===%-.1v2le===%-.1v2le===\n",var1,var2);
  return i;
}

int double2_e_1061c() {
  // { dg-printf "double2_e_1061c===1.23e+05,2.00e+00===0.00e+00,-1.23e+00===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (0.0,-1.23);
  int i = printf("double2_e_1061c===%-.2v2le===%-.2v2le===\n",var1,var2);
  return i;
}

int double2_e_1062c() {
  // { dg-printf "double2_e_1062c===0.000e+00,1.235e+05===-1.235e+04,1.000e+00===" }
  double2 var1 = (double2) (0.0,123455.134);
  double2 var2 = (double2) (-12345.032,1.0);
  int i = printf("double2_e_1062c===%-.3v2le===%-.3v2le===\n",var1,var2);
  return i;
}

int double2_e_1063c() {
  // { dg-printf "double2_e_1063c===0.0000000000e+00,-1.2345032000e+04===2.0000000000e+00,1.0000000000e+00===" }
  double2 var1 = (double2) (0.0,-12345.032);
  double2 var2 = (double2) (2.0,1.0);
  int i = printf("double2_e_1063c===%-.10v2le===%-.10v2le===\n",var1,var2);
  return i;
}

int double2_e_1064c() {
  // { dg-printf "double2_e_1064c===-1.234503E+04,1.234551E+05===1.234551E+05,1.000000E+00===" }
  double2 var1 = (double2) (-12345.032,123455.134);
  double2 var2 = (double2) (123455.134,1.0);
  int i = printf("double2_e_1064c===%-v2lE===%-v2lE===\n",var1,var2);
  return i;
}

int double2_e_1065c() {
  // { dg-printf "double2_e_1065c===2.0E+00,1.0E+00===1.2E+05,2.0E+00===" }
  double2 var1 = (double2) (2.0,1.0);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_e_1065c===%-.1v2lE===%-.1v2lE===\n",var1,var2);
  return i;
}

int double2_e_1066c() {
  // { dg-printf "double2_e_1066c===-1.23E+04,1.00E+00===-1.23E+04,0.00E+00===" }
  double2 var1 = (double2) (-12345.032,1.0);
  double2 var2 = (double2) (-12345.032,0.0);
  int i = printf("double2_e_1066c===%-.2v2lE===%-.2v2lE===\n",var1,var2);
  return i;
}

int double2_e_1067c() {
  // { dg-printf "double2_e_1067c===0.000E+00,0.000E+00===2.000E+00,2.000E+00===" }
  double2 var1 = (double2) (0.0,0.0);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_e_1067c===%-.3v2lE===%-.3v2lE===\n",var1,var2);
  return i;
}

int double2_e_1068c() {
  // { dg-printf "double2_e_1068c===-1.2300000000E+00,-1.2345032000E+04===-1.2345032000E+04,2.0000000000E+00===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (-12345.032,2.0);
  int i = printf("double2_e_1068c===%-.10v2lE===%-.10v2lE===\n",var1,var2);
  return i;
}

int double2_e_1819c() {
  // { dg-printf "double2_e_1819c===-1.230000e+00,+0.000000e+00===-1.234503e+04,+0.000000e+00===" }
  double2 var1 = (double2) (-1.23,0.0);
  double2 var2 = (double2) (-12345.032,0.0);
  int i = printf("double2_e_1819c===%+v2le===%+v2le===\n",var1,var2);
  return i;
}

int double2_e_1820c() {
  // { dg-printf "double2_e_1820c===+1.2e+05,+2.0e+00===-1.2e+04,-1.2e+04===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (-12345.032,-12345.032);
  int i = printf("double2_e_1820c===%+.1v2le===%+.1v2le===\n",var1,var2);
  return i;
}

int double2_e_1821c() {
  // { dg-printf "double2_e_1821c===+1.00e+00,+0.00e+00===+2.00e+00,-1.23e+04===" }
  double2 var1 = (double2) (1.0,0.0);
  double2 var2 = (double2) (2.0,-12345.032);
  int i = printf("double2_e_1821c===%+.2v2le===%+.2v2le===\n",var1,var2);
  return i;
}

int double2_e_1822c() {
  // { dg-printf "double2_e_1822c===-1.235e+04,+2.000e+00===+1.000e+00,-1.230e+00===" }
  double2 var1 = (double2) (-12345.032,2.0);
  double2 var2 = (double2) (1.0,-1.23);
  int i = printf("double2_e_1822c===%+.3v2le===%+.3v2le===\n",var1,var2);
  return i;
}

int double2_e_1823c() {
  // { dg-printf "double2_e_1823c===+2.0000000000e+00,+1.2345513400e+05===-1.2345032000e+04,-1.2345032000e+04===" }
  double2 var1 = (double2) (2.0,123455.134);
  double2 var2 = (double2) (-12345.032,-12345.032);
  int i = printf("double2_e_1823c===%+.10v2le===%+.10v2le===\n",var1,var2);
  return i;
}

int double2_e_1824c() {
  // { dg-printf "double2_e_1824c===-1.230000E+00,-1.234503E+04===+1.234551E+05,-1.230000E+00===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (123455.134,-1.23);
  int i = printf("double2_e_1824c===%+v2lE===%+v2lE===\n",var1,var2);
  return i;
}

int double2_e_1825c() {
  // { dg-printf "double2_e_1825c===+2.0E+00,+1.0E+00===-1.2E+00,-1.2E+04===" }
  double2 var1 = (double2) (2.0,1.0);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_e_1825c===%+.1v2lE===%+.1v2lE===\n",var1,var2);
  return i;
}

int double2_e_1826c() {
  // { dg-printf "double2_e_1826c===-1.23E+00,+0.00E+00===+1.23E+05,+0.00E+00===" }
  double2 var1 = (double2) (-1.23,0.0);
  double2 var2 = (double2) (123455.134,0.0);
  int i = printf("double2_e_1826c===%+.2v2lE===%+.2v2lE===\n",var1,var2);
  return i;
}

int double2_e_1827c() {
  // { dg-printf "double2_e_1827c===+1.235E+05,+1.235E+05===+1.235E+05,-1.230E+00===" }
  double2 var1 = (double2) (123455.134,123455.134);
  double2 var2 = (double2) (123455.134,-1.23);
  int i = printf("double2_e_1827c===%+.3v2lE===%+.3v2lE===\n",var1,var2);
  return i;
}

int double2_e_1828c() {
  // { dg-printf "double2_e_1828c===-1.2300000000E+00,-1.2300000000E+00===-1.2300000000E+00,-1.2345032000E+04===" }
  double2 var1 = (double2) (-1.23,-1.23);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_e_1828c===%+.10v2lE===%+.10v2lE===\n",var1,var2);
  return i;
}

int double2_e_2579c() {
  // { dg-printf "double2_e_2579c===1.000000e+00,1.000000e+00===1.234551e+05,2.000000e+00===" }
  double2 var1 = (double2) (1.0,1.0);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_e_2579c===%#v2le===%#v2le===\n",var1,var2);
  return i;
}

int double2_e_2580c() {
  // { dg-printf "double2_e_2580c===-1.2e+04,-1.2e+00===-1.2e+00,0.0e+00===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (-1.23,0.0);
  int i = printf("double2_e_2580c===%#.1v2le===%#.1v2le===\n",var1,var2);
  return i;
}

int double2_e_2581c() {
  // { dg-printf "double2_e_2581c===2.00e+00,1.23e+05===-1.23e+04,-1.23e+00===" }
  double2 var1 = (double2) (2.0,123455.134);
  double2 var2 = (double2) (-12345.032,-1.23);
  int i = printf("double2_e_2581c===%#.2v2le===%#.2v2le===\n",var1,var2);
  return i;
}

int double2_e_2582c() {
  // { dg-printf "double2_e_2582c===0.000e+00,0.000e+00===1.000e+00,-1.235e+04===" }
  double2 var1 = (double2) (0.0,0.0);
  double2 var2 = (double2) (1.0,-12345.032);
  int i = printf("double2_e_2582c===%#.3v2le===%#.3v2le===\n",var1,var2);
  return i;
}

int double2_e_2583c() {
  // { dg-printf "double2_e_2583c===-1.2345032000e+04,2.0000000000e+00===1.2345513400e+05,-1.2345032000e+04===" }
  double2 var1 = (double2) (-12345.032,2.0);
  double2 var2 = (double2) (123455.134,-12345.032);
  int i = printf("double2_e_2583c===%#.10v2le===%#.10v2le===\n",var1,var2);
  return i;
}

int double2_e_2584c() {
  // { dg-printf "double2_e_2584c===-1.234503E+04,1.234551E+05===0.000000E+00,-1.234503E+04===" }
  double2 var1 = (double2) (-12345.032,123455.134);
  double2 var2 = (double2) (0.0,-12345.032);
  int i = printf("double2_e_2584c===%#v2lE===%#v2lE===\n",var1,var2);
  return i;
}

int double2_e_2585c() {
  // { dg-printf "double2_e_2585c===0.0E+00,2.0E+00===1.0E+00,2.0E+00===" }
  double2 var1 = (double2) (0.0,2.0);
  double2 var2 = (double2) (1.0,2.0);
  int i = printf("double2_e_2585c===%#.1v2lE===%#.1v2lE===\n",var1,var2);
  return i;
}

int double2_e_2586c() {
  // { dg-printf "double2_e_2586c===1.00E+00,2.00E+00===1.00E+00,1.23E+05===" }
  double2 var1 = (double2) (1.0,2.0);
  double2 var2 = (double2) (1.0,123455.134);
  int i = printf("double2_e_2586c===%#.2v2lE===%#.2v2lE===\n",var1,var2);
  return i;
}

int double2_e_2587c() {
  // { dg-printf "double2_e_2587c===0.000E+00,1.000E+00===-1.235E+04,1.000E+00===" }
  double2 var1 = (double2) (0.0,1.0);
  double2 var2 = (double2) (-12345.032,1.0);
  int i = printf("double2_e_2587c===%#.3v2lE===%#.3v2lE===\n",var1,var2);
  return i;
}

int double2_e_2588c() {
  // { dg-printf "double2_e_2588c===1.2345513400E+05,2.0000000000E+00===-1.2345032000E+04,2.0000000000E+00===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (-12345.032,2.0);
  int i = printf("double2_e_2588c===%#.10v2lE===%#.10v2lE===\n",var1,var2);
  return i;
}

int double2_e_299c() {
  // { dg-printf "double2_e_299c===1.234551e+05,-1.234503e+04===2.000000e+00,-1.234503e+04===" }
  double2 var1 = (double2) (123455.134,-12345.032);
  double2 var2 = (double2) (2.0,-12345.032);
  int i = printf("double2_e_299c===%v2le===%v2le===\n",var1,var2);
  return i;
}

int double2_e_300c() {
  // { dg-printf "double2_e_300c===-1.2e+00,-1.2e+00===-1.2e+00,0.0e+00===" }
  double2 var1 = (double2) (-1.23,-1.23);
  double2 var2 = (double2) (-1.23,0.0);
  int i = printf("double2_e_300c===%.1v2le===%.1v2le===\n",var1,var2);
  return i;
}

int double2_e_301c() {
  // { dg-printf "double2_e_301c===0.00e+00,1.23e+05===1.00e+00,1.00e+00===" }
  double2 var1 = (double2) (0.0,123455.134);
  double2 var2 = (double2) (1.0,1.0);
  int i = printf("double2_e_301c===%.2v2le===%.2v2le===\n",var1,var2);
  return i;
}

int double2_e_302c() {
  // { dg-printf "double2_e_302c===2.000e+00,0.000e+00===2.000e+00,1.000e+00===" }
  double2 var1 = (double2) (2.0,0.0);
  double2 var2 = (double2) (2.0,1.0);
  int i = printf("double2_e_302c===%.3v2le===%.3v2le===\n",var1,var2);
  return i;
}

int double2_e_303c() {
  // { dg-printf "double2_e_303c===0.0000000000e+00,-1.2300000000e+00===0.0000000000e+00,-1.2300000000e+00===" }
  double2 var1 = (double2) (0.0,-1.23);
  double2 var2 = (double2) (0.0,-1.23);
  int i = printf("double2_e_303c===%.10v2le===%.10v2le===\n",var1,var2);
  return i;
}

int double2_e_304c() {
  // { dg-printf "double2_e_304c===2.000000E+00,2.000000E+00===-1.234503E+04,1.234551E+05===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (-12345.032,123455.134);
  int i = printf("double2_e_304c===%v2lE===%v2lE===\n",var1,var2);
  return i;
}

int double2_e_305c() {
  // { dg-printf "double2_e_305c===1.0E+00,1.2E+05===0.0E+00,2.0E+00===" }
  double2 var1 = (double2) (1.0,123455.134);
  double2 var2 = (double2) (0.0,2.0);
  int i = printf("double2_e_305c===%.1v2lE===%.1v2lE===\n",var1,var2);
  return i;
}

int double2_e_306c() {
  // { dg-printf "double2_e_306c===0.00E+00,1.23E+05===0.00E+00,-1.23E+04===" }
  double2 var1 = (double2) (0.0,123455.134);
  double2 var2 = (double2) (0.0,-12345.032);
  int i = printf("double2_e_306c===%.2v2lE===%.2v2lE===\n",var1,var2);
  return i;
}

int double2_e_307c() {
  // { dg-printf "double2_e_307c===2.000E+00,-1.235E+04===1.000E+00,2.000E+00===" }
  double2 var1 = (double2) (2.0,-12345.032);
  double2 var2 = (double2) (1.0,2.0);
  int i = printf("double2_e_307c===%.3v2lE===%.3v2lE===\n",var1,var2);
  return i;
}

int double2_e_308c() {
  // { dg-printf "double2_e_308c===1.2345513400E+05,2.0000000000E+00===1.2345513400E+05,1.2345513400E+05===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (123455.134,123455.134);
  int i = printf("double2_e_308c===%.10v2lE===%.10v2lE===\n",var1,var2);
  return i;
}

int double2_e_3339c() {
  // { dg-printf "double2_e_3339c===-1.230000e+00,+2.000000e+00===-1.230000e+00,+0.000000e+00===" }
  double2 var1 = (double2) (-1.23,2.0);
  double2 var2 = (double2) (-1.23,0.0);
  int i = printf("double2_e_3339c===%-+v2le===%-+v2le===\n",var1,var2);
  return i;
}

int double2_e_3340c() {
  // { dg-printf "double2_e_3340c===+1.2e+05,-1.2e+00===+1.2e+05,-1.2e+04===" }
  double2 var1 = (double2) (123455.134,-1.23);
  double2 var2 = (double2) (123455.134,-12345.032);
  int i = printf("double2_e_3340c===%-+.1v2le===%-+.1v2le===\n",var1,var2);
  return i;
}

int double2_e_3341c() {
  // { dg-printf "double2_e_3341c===+2.00e+00,+2.00e+00===+2.00e+00,-1.23e+04===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (2.0,-12345.032);
  int i = printf("double2_e_3341c===%-+.2v2le===%-+.2v2le===\n",var1,var2);
  return i;
}

int double2_e_3342c() {
  // { dg-printf "double2_e_3342c===+1.000e+00,+2.000e+00===+1.235e+05,+2.000e+00===" }
  double2 var1 = (double2) (1.0,2.0);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_e_3342c===%-+.3v2le===%-+.3v2le===\n",var1,var2);
  return i;
}

int double2_e_3343c() {
  // { dg-printf "double2_e_3343c===-1.2345032000e+04,+0.0000000000e+00===-1.2345032000e+04,+1.2345513400e+05===" }
  double2 var1 = (double2) (-12345.032,0.0);
  double2 var2 = (double2) (-12345.032,123455.134);
  int i = printf("double2_e_3343c===%-+.10v2le===%-+.10v2le===\n",var1,var2);
  return i;
}

int double2_e_3344c() {
  // { dg-printf "double2_e_3344c===+0.000000E+00,-1.230000E+00===+1.000000E+00,+1.234551E+05===" }
  double2 var1 = (double2) (0.0,-1.23);
  double2 var2 = (double2) (1.0,123455.134);
  int i = printf("double2_e_3344c===%-+v2lE===%-+v2lE===\n",var1,var2);
  return i;
}

int double2_e_3345c() {
  // { dg-printf "double2_e_3345c===+1.2E+05,-1.2E+00===+1.0E+00,-1.2E+04===" }
  double2 var1 = (double2) (123455.134,-1.23);
  double2 var2 = (double2) (1.0,-12345.032);
  int i = printf("double2_e_3345c===%-+.1v2lE===%-+.1v2lE===\n",var1,var2);
  return i;
}

int double2_e_3346c() {
  // { dg-printf "double2_e_3346c===-1.23E+04,-1.23E+00===+2.00E+00,+2.00E+00===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_e_3346c===%-+.2v2lE===%-+.2v2lE===\n",var1,var2);
  return i;
}

int double2_e_3347c() {
  // { dg-printf "double2_e_3347c===-1.230E+00,-1.235E+04===+1.235E+05,+2.000E+00===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_e_3347c===%-+.3v2lE===%-+.3v2lE===\n",var1,var2);
  return i;
}

int double2_e_3348c() {
  // { dg-printf "double2_e_3348c===-1.2345032000E+04,-1.2300000000E+00===-1.2300000000E+00,+1.2345513400E+05===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (-1.23,123455.134);
  int i = printf("double2_e_3348c===%-+.10v2lE===%-+.10v2lE===\n",var1,var2);
  return i;
}

int double2_e_4099c() {
  // { dg-printf "double2_e_4099c=== 1.234551e+05, 0.000000e+00=== 1.234551e+05,-1.234503e+04===" }
  double2 var1 = (double2) (123455.134,0.0);
  double2 var2 = (double2) (123455.134,-12345.032);
  int i = printf("double2_e_4099c===% 10v2le===% 10v2le===\n",var1,var2);
  return i;
}

int double2_e_4100c() {
  // { dg-printf "double2_e_4100c===   1.2e+05,  -1.2e+00===  -1.2e+00,  -1.2e+00===" }
  double2 var1 = (double2) (123455.134,-1.23);
  double2 var2 = (double2) (-1.23,-1.23);
  int i = printf("double2_e_4100c===% 10.1v2le===% 10.1v2le===\n",var1,var2);
  return i;
}

int double2_e_4101c() {
  // { dg-printf "double2_e_4101c=== -1.23e+00, -1.23e+00===  2.00e+00, -1.23e+00===" }
  double2 var1 = (double2) (-1.23,-1.23);
  double2 var2 = (double2) (2.0,-1.23);
  int i = printf("double2_e_4101c===% 10.2v2le===% 10.2v2le===\n",var1,var2);
  return i;
}

int double2_e_4102c() {
  // { dg-printf "double2_e_4102c=== 1.235e+05,-1.230e+00=== 1.000e+00,-1.235e+04===" }
  double2 var1 = (double2) (123455.134,-1.23);
  double2 var2 = (double2) (1.0,-12345.032);
  int i = printf("double2_e_4102c===% 10.3v2le===% 10.3v2le===\n",var1,var2);
  return i;
}

int double2_e_4103c() {
  // { dg-printf "double2_e_4103c===-1.2345032000e+04, 1.2345513400e+05=== 1.0000000000e+00, 0.0000000000e+00===" }
  double2 var1 = (double2) (-12345.032,123455.134);
  double2 var2 = (double2) (1.0,0.0);
  int i = printf("double2_e_4103c===% 10.10v2le===% 10.10v2le===\n",var1,var2);
  return i;
}

int double2_e_4104c() {
  // { dg-printf "double2_e_4104c===-1.234503E+04, 2.000000E+00=== 1.234551E+05,-1.234503E+04===" }
  double2 var1 = (double2) (-12345.032,2.0);
  double2 var2 = (double2) (123455.134,-12345.032);
  int i = printf("double2_e_4104c===% 10v2lE===% 10v2lE===\n",var1,var2);
  return i;
}

int double2_e_4105c() {
  // { dg-printf "double2_e_4105c===   1.2E+05,  -1.2E+04===   1.0E+00,   1.0E+00===" }
  double2 var1 = (double2) (123455.134,-12345.032);
  double2 var2 = (double2) (1.0,1.0);
  int i = printf("double2_e_4105c===% 10.1v2lE===% 10.1v2lE===\n",var1,var2);
  return i;
}

int double2_e_4106c() {
  // { dg-printf "double2_e_4106c===  2.00E+00, -1.23E+00===  2.00E+00, -1.23E+00===" }
  double2 var1 = (double2) (2.0,-1.23);
  double2 var2 = (double2) (2.0,-1.23);
  int i = printf("double2_e_4106c===% 10.2v2lE===% 10.2v2lE===\n",var1,var2);
  return i;
}

int double2_e_4107c() {
  // { dg-printf "double2_e_4107c=== 0.000E+00, 0.000E+00=== 0.000E+00, 1.000E+00===" }
  double2 var1 = (double2) (0.0,0.0);
  double2 var2 = (double2) (0.0,1.0);
  int i = printf("double2_e_4107c===% 10.3v2lE===% 10.3v2lE===\n",var1,var2);
  return i;
}

int double2_e_4108c() {
  // { dg-printf "double2_e_4108c=== 2.0000000000E+00,-1.2345032000E+04=== 1.2345513400E+05, 2.0000000000E+00===" }
  double2 var1 = (double2) (2.0,-12345.032);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_e_4108c===% 10.10v2lE===% 10.10v2lE===\n",var1,var2);
  return i;
}

int double2_e_4859c() {
  // { dg-printf "double2_e_4859c===0.000000e+00,-1.234503e+04===1.000000e+00,-1.230000e+00===" }
  double2 var1 = (double2) (0.0,-12345.032);
  double2 var2 = (double2) (1.0,-1.23);
  int i = printf("double2_e_4859c===%010v2le===%010v2le===\n",var1,var2);
  return i;
}

int double2_e_4860c() {
  // { dg-printf "double2_e_4860c===0001.2e+05,-001.2e+04===-001.2e+00,0000.0e+00===" }
  double2 var1 = (double2) (123455.134,-12345.032);
  double2 var2 = (double2) (-1.23,0.0);
  int i = printf("double2_e_4860c===%010.1v2le===%010.1v2le===\n",var1,var2);
  return i;
}

int double2_e_4861c() {
  // { dg-printf "double2_e_4861c===-01.23e+00,-01.23e+04===002.00e+00,000.00e+00===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (2.0,0.0);
  int i = printf("double2_e_4861c===%010.2v2le===%010.2v2le===\n",var1,var2);
  return i;
}

int double2_e_4862c() {
  // { dg-printf "double2_e_4862c===02.000e+00,00.000e+00===02.000e+00,01.000e+00===" }
  double2 var1 = (double2) (2.0,0.0);
  double2 var2 = (double2) (2.0,1.0);
  int i = printf("double2_e_4862c===%010.3v2le===%010.3v2le===\n",var1,var2);
  return i;
}

int double2_e_4863c() {
  // { dg-printf "double2_e_4863c===-1.2345032000e+04,-1.2300000000e+00===2.0000000000e+00,-1.2300000000e+00===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (2.0,-1.23);
  int i = printf("double2_e_4863c===%010.10v2le===%010.10v2le===\n",var1,var2);
  return i;
}

int double2_e_4864c() {
  // { dg-printf "double2_e_4864c===0.000000E+00,1.234551E+05===-1.234503E+04,0.000000E+00===" }
  double2 var1 = (double2) (0.0,123455.134);
  double2 var2 = (double2) (-12345.032,0.0);
  int i = printf("double2_e_4864c===%010v2lE===%010v2lE===\n",var1,var2);
  return i;
}

int double2_e_4865c() {
  // { dg-printf "double2_e_4865c===0001.2E+05,0002.0E+00===-001.2E+00,-001.2E+04===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_e_4865c===%010.1v2lE===%010.1v2lE===\n",var1,var2);
  return i;
}

int double2_e_4866c() {
  // { dg-printf "double2_e_4866c===002.00E+00,001.00E+00===002.00E+00,000.00E+00===" }
  double2 var1 = (double2) (2.0,1.0);
  double2 var2 = (double2) (2.0,0.0);
  int i = printf("double2_e_4866c===%010.2v2lE===%010.2v2lE===\n",var1,var2);
  return i;
}

int double2_e_4867c() {
  // { dg-printf "double2_e_4867c===-1.230E+00,02.000E+00===-1.235E+04,00.000E+00===" }
  double2 var1 = (double2) (-1.23,2.0);
  double2 var2 = (double2) (-12345.032,0.0);
  int i = printf("double2_e_4867c===%010.3v2lE===%010.3v2lE===\n",var1,var2);
  return i;
}

int double2_e_4868c() {
  // { dg-printf "double2_e_4868c===0.0000000000E+00,2.0000000000E+00===2.0000000000E+00,0.0000000000E+00===" }
  double2 var1 = (double2) (0.0,2.0);
  double2 var2 = (double2) (2.0,0.0);
  int i = printf("double2_e_4868c===%010.10v2lE===%010.10v2lE===\n",var1,var2);
  return i;
}

int double2_e_5619c() {
  // { dg-printf "double2_e_5619c=== 1.234551e+05, 0.000000e+00=== 0.000000e+00, 0.000000e+00===" }
  double2 var1 = (double2) (123455.134,0.0);
  double2 var2 = (double2) (0.0,0.0);
  int i = printf("double2_e_5619c===%- 10v2le===%- 10v2le===\n",var1,var2);
  return i;
}

int double2_e_5620c() {
  // { dg-printf "double2_e_5620c=== 2.0e+00  ,-1.2e+04  ===-1.2e+00  , 1.0e+00  ===" }
  double2 var1 = (double2) (2.0,-12345.032);
  double2 var2 = (double2) (-1.23,1.0);
  int i = printf("double2_e_5620c===%- 10.1v2le===%- 10.1v2le===\n",var1,var2);
  return i;
}

int double2_e_5621c() {
  // { dg-printf "double2_e_5621c=== 0.00e+00 , 0.00e+00 === 1.23e+05 , 0.00e+00 ===" }
  double2 var1 = (double2) (0.0,0.0);
  double2 var2 = (double2) (123455.134,0.0);
  int i = printf("double2_e_5621c===%- 10.2v2le===%- 10.2v2le===\n",var1,var2);
  return i;
}

int double2_e_5622c() {
  // { dg-printf "double2_e_5622c=== 2.000e+00, 2.000e+00=== 1.000e+00, 1.235e+05===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (1.0,123455.134);
  int i = printf("double2_e_5622c===%- 10.3v2le===%- 10.3v2le===\n",var1,var2);
  return i;
}

int double2_e_5623c() {
  // { dg-printf "double2_e_5623c=== 2.0000000000e+00, 0.0000000000e+00===-1.2300000000e+00,-1.2300000000e+00===" }
  double2 var1 = (double2) (2.0,0.0);
  double2 var2 = (double2) (-1.23,-1.23);
  int i = printf("double2_e_5623c===%- 10.10v2le===%- 10.10v2le===\n",var1,var2);
  return i;
}

int double2_e_5624c() {
  // { dg-printf "double2_e_5624c=== 0.000000E+00,-1.230000E+00=== 1.234551E+05, 0.000000E+00===" }
  double2 var1 = (double2) (0.0,-1.23);
  double2 var2 = (double2) (123455.134,0.0);
  int i = printf("double2_e_5624c===%- 10v2lE===%- 10v2lE===\n",var1,var2);
  return i;
}

int double2_e_5625c() {
  // { dg-printf "double2_e_5625c=== 1.0E+00  , 2.0E+00  === 1.2E+05  ,-1.2E+04  ===" }
  double2 var1 = (double2) (1.0,2.0);
  double2 var2 = (double2) (123455.134,-12345.032);
  int i = printf("double2_e_5625c===%- 10.1v2lE===%- 10.1v2lE===\n",var1,var2);
  return i;
}

int double2_e_5626c() {
  // { dg-printf "double2_e_5626c=== 1.00E+00 ,-1.23E+00 ===-1.23E+04 ,-1.23E+00 ===" }
  double2 var1 = (double2) (1.0,-1.23);
  double2 var2 = (double2) (-12345.032,-1.23);
  int i = printf("double2_e_5626c===%- 10.2v2lE===%- 10.2v2lE===\n",var1,var2);
  return i;
}

int double2_e_5627c() {
  // { dg-printf "double2_e_5627c===-1.235E+04,-1.230E+00===-1.230E+00, 2.000E+00===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (-1.23,2.0);
  int i = printf("double2_e_5627c===%- 10.3v2lE===%- 10.3v2lE===\n",var1,var2);
  return i;
}

int double2_e_5628c() {
  // { dg-printf "double2_e_5628c=== 2.0000000000E+00, 2.0000000000E+00===-1.2345032000E+04, 2.0000000000E+00===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (-12345.032,2.0);
  int i = printf("double2_e_5628c===%- 10.10v2lE===%- 10.10v2lE===\n",var1,var2);
  return i;
}

int double2_e_6379c() {
  // { dg-printf "double2_e_6379c===+1.234551e+05,+1.000000e+00===+0.000000e+00,+0.000000e+00===" }
  double2 var1 = (double2) (123455.134,1.0);
  double2 var2 = (double2) (0.0,0.0);
  int i = printf("double2_e_6379c===%+ 10v2le===%+ 10v2le===\n",var1,var2);
  return i;
}

int double2_e_6380c() {
  // { dg-printf "double2_e_6380c===  +1.2e+05,  +1.0e+00===  -1.2e+04,  +0.0e+00===" }
  double2 var1 = (double2) (123455.134,1.0);
  double2 var2 = (double2) (-12345.032,0.0);
  int i = printf("double2_e_6380c===%+ 10.1v2le===%+ 10.1v2le===\n",var1,var2);
  return i;
}

int double2_e_6381c() {
  // { dg-printf "double2_e_6381c=== -1.23e+00, -1.23e+00=== +2.00e+00, +2.00e+00===" }
  double2 var1 = (double2) (-1.23,-1.23);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_e_6381c===%+ 10.2v2le===%+ 10.2v2le===\n",var1,var2);
  return i;
}

int double2_e_6382c() {
  // { dg-printf "double2_e_6382c===+2.000e+00,+0.000e+00===+2.000e+00,+1.000e+00===" }
  double2 var1 = (double2) (2.0,0.0);
  double2 var2 = (double2) (2.0,1.0);
  int i = printf("double2_e_6382c===%+ 10.3v2le===%+ 10.3v2le===\n",var1,var2);
  return i;
}

int double2_e_6383c() {
  // { dg-printf "double2_e_6383c===-1.2345032000e+04,-1.2300000000e+00===+1.2345513400e+05,-1.2345032000e+04===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (123455.134,-12345.032);
  int i = printf("double2_e_6383c===%+ 10.10v2le===%+ 10.10v2le===\n",var1,var2);
  return i;
}

int double2_e_6384c() {
  // { dg-printf "double2_e_6384c===-1.234503E+04,+1.234551E+05===+1.000000E+00,-1.230000E+00===" }
  double2 var1 = (double2) (-12345.032,123455.134);
  double2 var2 = (double2) (1.0,-1.23);
  int i = printf("double2_e_6384c===%+ 10v2lE===%+ 10v2lE===\n",var1,var2);
  return i;
}

int double2_e_6385c() {
  // { dg-printf "double2_e_6385c===  +1.0E+00,  +1.2E+05===  +1.0E+00,  +1.2E+05===" }
  double2 var1 = (double2) (1.0,123455.134);
  double2 var2 = (double2) (1.0,123455.134);
  int i = printf("double2_e_6385c===%+ 10.1v2lE===%+ 10.1v2lE===\n",var1,var2);
  return i;
}

int double2_e_6386c() {
  // { dg-printf "double2_e_6386c=== -1.23E+04, +1.00E+00=== -1.23E+00, +1.23E+05===" }
  double2 var1 = (double2) (-12345.032,1.0);
  double2 var2 = (double2) (-1.23,123455.134);
  int i = printf("double2_e_6386c===%+ 10.2v2lE===%+ 10.2v2lE===\n",var1,var2);
  return i;
}

int double2_e_6387c() {
  // { dg-printf "double2_e_6387c===+0.000E+00,+1.235E+05===-1.235E+04,+1.000E+00===" }
  double2 var1 = (double2) (0.0,123455.134);
  double2 var2 = (double2) (-12345.032,1.0);
  int i = printf("double2_e_6387c===%+ 10.3v2lE===%+ 10.3v2lE===\n",var1,var2);
  return i;
}

int double2_e_6388c() {
  // { dg-printf "double2_e_6388c===+1.2345513400E+05,-1.2345032000E+04===-1.2345032000E+04,+0.0000000000E+00===" }
  double2 var1 = (double2) (123455.134,-12345.032);
  double2 var2 = (double2) (-12345.032,0.0);
  int i = printf("double2_e_6388c===%+ 10.10v2lE===%+ 10.10v2lE===\n",var1,var2);
  return i;
}

int double2_e_7139c() {
  // { dg-printf "double2_e_7139c===+0.000000e+00,+2.000000e+00===+0.000000e+00,+1.000000e+00===" }
  double2 var1 = (double2) (0.0,2.0);
  double2 var2 = (double2) (0.0,1.0);
  int i = printf("double2_e_7139c===%+010v2le===%+010v2le===\n",var1,var2);
  return i;
}

int double2_e_7140c() {
  // { dg-printf "double2_e_7140c===+000.0e+00,+000.0e+00===+001.2e+05,-001.2e+00===" }
  double2 var1 = (double2) (0.0,0.0);
  double2 var2 = (double2) (123455.134,-1.23);
  int i = printf("double2_e_7140c===%+010.1v2le===%+010.1v2le===\n",var1,var2);
  return i;
}

int double2_e_7141c() {
  // { dg-printf "double2_e_7141c===+01.00e+00,+00.00e+00===+01.23e+05,+01.23e+05===" }
  double2 var1 = (double2) (1.0,0.0);
  double2 var2 = (double2) (123455.134,123455.134);
  int i = printf("double2_e_7141c===%+010.2v2le===%+010.2v2le===\n",var1,var2);
  return i;
}

int double2_e_7142c() {
  // { dg-printf "double2_e_7142c===+1.235e+05,+1.000e+00===+1.000e+00,+2.000e+00===" }
  double2 var1 = (double2) (123455.134,1.0);
  double2 var2 = (double2) (1.0,2.0);
  int i = printf("double2_e_7142c===%+010.3v2le===%+010.3v2le===\n",var1,var2);
  return i;
}

int double2_e_7143c() {
  // { dg-printf "double2_e_7143c===+1.2345513400e+05,-1.2345032000e+04===+2.0000000000e+00,+1.2345513400e+05===" }
  double2 var1 = (double2) (123455.134,-12345.032);
  double2 var2 = (double2) (2.0,123455.134);
  int i = printf("double2_e_7143c===%+010.10v2le===%+010.10v2le===\n",var1,var2);
  return i;
}

int double2_e_7144c() {
  // { dg-printf "double2_e_7144c===+0.000000E+00,+1.000000E+00===-1.234503E+04,+0.000000E+00===" }
  double2 var1 = (double2) (0.0,1.0);
  double2 var2 = (double2) (-12345.032,0.0);
  int i = printf("double2_e_7144c===%+010v2lE===%+010v2lE===\n",var1,var2);
  return i;
}

int double2_e_7145c() {
  // { dg-printf "double2_e_7145c===-001.2E+00,+001.2E+05===+002.0E+00,+001.2E+05===" }
  double2 var1 = (double2) (-1.23,123455.134);
  double2 var2 = (double2) (2.0,123455.134);
  int i = printf("double2_e_7145c===%+010.1v2lE===%+010.1v2lE===\n",var1,var2);
  return i;
}

int double2_e_7146c() {
  // { dg-printf "double2_e_7146c===+02.00E+00,-01.23E+04===+01.23E+05,+01.23E+05===" }
  double2 var1 = (double2) (2.0,-12345.032);
  double2 var2 = (double2) (123455.134,123455.134);
  int i = printf("double2_e_7146c===%+010.2v2lE===%+010.2v2lE===\n",var1,var2);
  return i;
}

int double2_e_7147c() {
  // { dg-printf "double2_e_7147c===-1.230E+00,+1.235E+05===+1.235E+05,+2.000E+00===" }
  double2 var1 = (double2) (-1.23,123455.134);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_e_7147c===%+010.3v2lE===%+010.3v2lE===\n",var1,var2);
  return i;
}

int double2_e_7148c() {
  // { dg-printf "double2_e_7148c===-1.2345032000E+04,+2.0000000000E+00===+0.0000000000E+00,+2.0000000000E+00===" }
  double2 var1 = (double2) (-12345.032,2.0);
  double2 var2 = (double2) (0.0,2.0);
  int i = printf("double2_e_7148c===%+010.10v2lE===%+010.10v2lE===\n",var1,var2);
  return i;
}

int double2_f_1069c() {
  // { dg-printf "double2_f_1069c===123455.134000,0.000000===-1.230000,2.000000===" }
  double2 var1 = (double2) (123455.134,0.0);
  double2 var2 = (double2) (-1.23,2.0);
  int i = printf("double2_f_1069c===%-v2lf===%-v2lf===\n",var1,var2);
  return i;
}

int double2_f_1070c() {
  // { dg-printf "double2_f_1070c===-1.2,2.0===1.0,-1.2===" }
  double2 var1 = (double2) (-1.23,2.0);
  double2 var2 = (double2) (1.0,-1.23);
  int i = printf("double2_f_1070c===%-.1v2lf===%-.1v2lf===\n",var1,var2);
  return i;
}

int double2_f_1071c() {
  // { dg-printf "double2_f_1071c===1.00,2.00===-12345.03,2.00===" }
  double2 var1 = (double2) (1.0,2.0);
  double2 var2 = (double2) (-12345.032,2.0);
  int i = printf("double2_f_1071c===%-.2v2lf===%-.2v2lf===\n",var1,var2);
  return i;
}

int double2_f_1072c() {
  // { dg-printf "double2_f_1072c===-12345.032,-1.230===-1.230,2.000===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (-1.23,2.0);
  int i = printf("double2_f_1072c===%-.3v2lf===%-.3v2lf===\n",var1,var2);
  return i;
}

int double2_f_1073c() {
  // { dg-printf "double2_f_1073c===-12345.0320000000,1.0000000000===-1.2300000000,123455.1340000000===" }
  double2 var1 = (double2) (-12345.032,1.0);
  double2 var2 = (double2) (-1.23,123455.134);
  int i = printf("double2_f_1073c===%-.10v2lf===%-.10v2lf===\n",var1,var2);
  return i;
}

int double2_f_1074c() {
  // { dg-printf "double2_f_1074c===0.000000,2.000000===-1.230000,-12345.032000===" }
  double2 var1 = (double2) (0.0,2.0);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_f_1074c===%-v2lF===%-v2lF===\n",var1,var2);
  return i;
}

int double2_f_1075c() {
  // { dg-printf "double2_f_1075c===0.0,0.0===0.0,1.0===" }
  double2 var1 = (double2) (0.0,0.0);
  double2 var2 = (double2) (0.0,1.0);
  int i = printf("double2_f_1075c===%-.1v2lF===%-.1v2lF===\n",var1,var2);
  return i;
}

int double2_f_1076c() {
  // { dg-printf "double2_f_1076c===1.00,0.00===-12345.03,123455.13===" }
  double2 var1 = (double2) (1.0,0.0);
  double2 var2 = (double2) (-12345.032,123455.134);
  int i = printf("double2_f_1076c===%-.2v2lF===%-.2v2lF===\n",var1,var2);
  return i;
}

int double2_f_1077c() {
  // { dg-printf "double2_f_1077c===2.000,1.000===0.000,-12345.032===" }
  double2 var1 = (double2) (2.0,1.0);
  double2 var2 = (double2) (0.0,-12345.032);
  int i = printf("double2_f_1077c===%-.3v2lF===%-.3v2lF===\n",var1,var2);
  return i;
}

int double2_f_1078c() {
  // { dg-printf "double2_f_1078c===0.0000000000,1.0000000000===1.0000000000,1.0000000000===" }
  double2 var1 = (double2) (0.0,1.0);
  double2 var2 = (double2) (1.0,1.0);
  int i = printf("double2_f_1078c===%-.10v2lF===%-.10v2lF===\n",var1,var2);
  return i;
}

int double2_f_1829c() {
  // { dg-printf "double2_f_1829c===+2.000000,-12345.032000===+123455.134000,+0.000000===" }
  double2 var1 = (double2) (2.0,-12345.032);
  double2 var2 = (double2) (123455.134,0.0);
  int i = printf("double2_f_1829c===%+v2lf===%+v2lf===\n",var1,var2);
  return i;
}

int double2_f_1830c() {
  // { dg-printf "double2_f_1830c===+123455.1,+2.0===+1.0,+1.0===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (1.0,1.0);
  int i = printf("double2_f_1830c===%+.1v2lf===%+.1v2lf===\n",var1,var2);
  return i;
}

int double2_f_1831c() {
  // { dg-printf "double2_f_1831c===+2.00,+123455.13===+123455.13,+2.00===" }
  double2 var1 = (double2) (2.0,123455.134);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_f_1831c===%+.2v2lf===%+.2v2lf===\n",var1,var2);
  return i;
}

int double2_f_1832c() {
  // { dg-printf "double2_f_1832c===+0.000,+2.000===+123455.134,+0.000===" }
  double2 var1 = (double2) (0.0,2.0);
  double2 var2 = (double2) (123455.134,0.0);
  int i = printf("double2_f_1832c===%+.3v2lf===%+.3v2lf===\n",var1,var2);
  return i;
}

int double2_f_1833c() {
  // { dg-printf "double2_f_1833c===+1.0000000000,+123455.1340000000===+0.0000000000,-1.2300000000===" }
  double2 var1 = (double2) (1.0,123455.134);
  double2 var2 = (double2) (0.0,-1.23);
  int i = printf("double2_f_1833c===%+.10v2lf===%+.10v2lf===\n",var1,var2);
  return i;
}

int double2_f_1834c() {
  // { dg-printf "double2_f_1834c===+0.000000,+2.000000===+123455.134000,+2.000000===" }
  double2 var1 = (double2) (0.0,2.0);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_f_1834c===%+v2lF===%+v2lF===\n",var1,var2);
  return i;
}

int double2_f_1835c() {
  // { dg-printf "double2_f_1835c===+2.0,-12345.0===-12345.0,+123455.1===" }
  double2 var1 = (double2) (2.0,-12345.032);
  double2 var2 = (double2) (-12345.032,123455.134);
  int i = printf("double2_f_1835c===%+.1v2lF===%+.1v2lF===\n",var1,var2);
  return i;
}

int double2_f_1836c() {
  // { dg-printf "double2_f_1836c===+2.00,+0.00===+0.00,+2.00===" }
  double2 var1 = (double2) (2.0,0.0);
  double2 var2 = (double2) (0.0,2.0);
  int i = printf("double2_f_1836c===%+.2v2lF===%+.2v2lF===\n",var1,var2);
  return i;
}

int double2_f_1837c() {
  // { dg-printf "double2_f_1837c===-12345.032,+2.000===+2.000,+0.000===" }
  double2 var1 = (double2) (-12345.032,2.0);
  double2 var2 = (double2) (2.0,0.0);
  int i = printf("double2_f_1837c===%+.3v2lF===%+.3v2lF===\n",var1,var2);
  return i;
}

int double2_f_1838c() {
  // { dg-printf "double2_f_1838c===+123455.1340000000,-1.2300000000===-12345.0320000000,-1.2300000000===" }
  double2 var1 = (double2) (123455.134,-1.23);
  double2 var2 = (double2) (-12345.032,-1.23);
  int i = printf("double2_f_1838c===%+.10v2lF===%+.10v2lF===\n",var1,var2);
  return i;
}

int double2_f_2589c() {
  // { dg-printf "double2_f_2589c===123455.134000,-1.230000===1.000000,1.000000===" }
  double2 var1 = (double2) (123455.134,-1.23);
  double2 var2 = (double2) (1.0,1.0);
  int i = printf("double2_f_2589c===%#v2lf===%#v2lf===\n",var1,var2);
  return i;
}

int double2_f_2590c() {
  // { dg-printf "double2_f_2590c===123455.1,1.0===2.0,1.0===" }
  double2 var1 = (double2) (123455.134,1.0);
  double2 var2 = (double2) (2.0,1.0);
  int i = printf("double2_f_2590c===%#.1v2lf===%#.1v2lf===\n",var1,var2);
  return i;
}

int double2_f_2591c() {
  // { dg-printf "double2_f_2591c===0.00,-12345.03===-12345.03,1.00===" }
  double2 var1 = (double2) (0.0,-12345.032);
  double2 var2 = (double2) (-12345.032,1.0);
  int i = printf("double2_f_2591c===%#.2v2lf===%#.2v2lf===\n",var1,var2);
  return i;
}

int double2_f_2592c() {
  // { dg-printf "double2_f_2592c===1.000,-12345.032===123455.134,2.000===" }
  double2 var1 = (double2) (1.0,-12345.032);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_f_2592c===%#.3v2lf===%#.3v2lf===\n",var1,var2);
  return i;
}

int double2_f_2593c() {
  // { dg-printf "double2_f_2593c===1.0000000000,2.0000000000===2.0000000000,1.0000000000===" }
  double2 var1 = (double2) (1.0,2.0);
  double2 var2 = (double2) (2.0,1.0);
  int i = printf("double2_f_2593c===%#.10v2lf===%#.10v2lf===\n",var1,var2);
  return i;
}

int double2_f_2594c() {
  // { dg-printf "double2_f_2594c===2.000000,2.000000===1.000000,-12345.032000===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (1.0,-12345.032);
  int i = printf("double2_f_2594c===%#v2lF===%#v2lF===\n",var1,var2);
  return i;
}

int double2_f_2595c() {
  // { dg-printf "double2_f_2595c===-1.2,-12345.0===1.0,1.0===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (1.0,1.0);
  int i = printf("double2_f_2595c===%#.1v2lF===%#.1v2lF===\n",var1,var2);
  return i;
}

int double2_f_2596c() {
  // { dg-printf "double2_f_2596c===0.00,123455.13===2.00,-1.23===" }
  double2 var1 = (double2) (0.0,123455.134);
  double2 var2 = (double2) (2.0,-1.23);
  int i = printf("double2_f_2596c===%#.2v2lF===%#.2v2lF===\n",var1,var2);
  return i;
}

int double2_f_2597c() {
  // { dg-printf "double2_f_2597c===-1.230,-1.230===123455.134,123455.134===" }
  double2 var1 = (double2) (-1.23,-1.23);
  double2 var2 = (double2) (123455.134,123455.134);
  int i = printf("double2_f_2597c===%#.3v2lF===%#.3v2lF===\n",var1,var2);
  return i;
}

int double2_f_2598c() {
  // { dg-printf "double2_f_2598c===-12345.0320000000,2.0000000000===123455.1340000000,0.0000000000===" }
  double2 var1 = (double2) (-12345.032,2.0);
  double2 var2 = (double2) (123455.134,0.0);
  int i = printf("double2_f_2598c===%#.10v2lF===%#.10v2lF===\n",var1,var2);
  return i;
}

int double2_f_309c() {
  // { dg-printf "double2_f_309c===2.000000,123455.134000===123455.134000,123455.134000===" }
  double2 var1 = (double2) (2.0,123455.134);
  double2 var2 = (double2) (123455.134,123455.134);
  int i = printf("double2_f_309c===%v2lf===%v2lf===\n",var1,var2);
  return i;
}

int double2_f_310c() {
  // { dg-printf "double2_f_310c===2.0,0.0===2.0,-12345.0===" }
  double2 var1 = (double2) (2.0,0.0);
  double2 var2 = (double2) (2.0,-12345.032);
  int i = printf("double2_f_310c===%.1v2lf===%.1v2lf===\n",var1,var2);
  return i;
}

int double2_f_311c() {
  // { dg-printf "double2_f_311c===1.00,123455.13===1.00,-1.23===" }
  double2 var1 = (double2) (1.0,123455.134);
  double2 var2 = (double2) (1.0,-1.23);
  int i = printf("double2_f_311c===%.2v2lf===%.2v2lf===\n",var1,var2);
  return i;
}

int double2_f_312c() {
  // { dg-printf "double2_f_312c===-12345.032,-1.230===0.000,0.000===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (0.0,0.0);
  int i = printf("double2_f_312c===%.3v2lf===%.3v2lf===\n",var1,var2);
  return i;
}

int double2_f_313c() {
  // { dg-printf "double2_f_313c===-12345.0320000000,0.0000000000===0.0000000000,1.0000000000===" }
  double2 var1 = (double2) (-12345.032,0.0);
  double2 var2 = (double2) (0.0,1.0);
  int i = printf("double2_f_313c===%.10v2lf===%.10v2lf===\n",var1,var2);
  return i;
}

int double2_f_314c() {
  // { dg-printf "double2_f_314c===1.000000,2.000000===1.000000,1.000000===" }
  double2 var1 = (double2) (1.0,2.0);
  double2 var2 = (double2) (1.0,1.0);
  int i = printf("double2_f_314c===%v2lF===%v2lF===\n",var1,var2);
  return i;
}

int double2_f_315c() {
  // { dg-printf "double2_f_315c===123455.1,-1.2===1.0,-1.2===" }
  double2 var1 = (double2) (123455.134,-1.23);
  double2 var2 = (double2) (1.0,-1.23);
  int i = printf("double2_f_315c===%.1v2lF===%.1v2lF===\n",var1,var2);
  return i;
}

int double2_f_316c() {
  // { dg-printf "double2_f_316c===123455.13,2.00===2.00,2.00===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_f_316c===%.2v2lF===%.2v2lF===\n",var1,var2);
  return i;
}

int double2_f_317c() {
  // { dg-printf "double2_f_317c===-12345.032,2.000===0.000,-1.230===" }
  double2 var1 = (double2) (-12345.032,2.0);
  double2 var2 = (double2) (0.0,-1.23);
  int i = printf("double2_f_317c===%.3v2lF===%.3v2lF===\n",var1,var2);
  return i;
}

int double2_f_318c() {
  // { dg-printf "double2_f_318c===1.0000000000,2.0000000000===-1.2300000000,1.0000000000===" }
  double2 var1 = (double2) (1.0,2.0);
  double2 var2 = (double2) (-1.23,1.0);
  int i = printf("double2_f_318c===%.10v2lF===%.10v2lF===\n",var1,var2);
  return i;
}

int double2_f_3349c() {
  // { dg-printf "double2_f_3349c===+1.000000,+0.000000===-1.230000,-12345.032000===" }
  double2 var1 = (double2) (1.0,0.0);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_f_3349c===%-+v2lf===%-+v2lf===\n",var1,var2);
  return i;
}

int double2_f_3350c() {
  // { dg-printf "double2_f_3350c===-1.2,-12345.0===-1.2,+1.0===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (-1.23,1.0);
  int i = printf("double2_f_3350c===%-+.1v2lf===%-+.1v2lf===\n",var1,var2);
  return i;
}

int double2_f_3351c() {
  // { dg-printf "double2_f_3351c===+2.00,+1.00===+0.00,-12345.03===" }
  double2 var1 = (double2) (2.0,1.0);
  double2 var2 = (double2) (0.0,-12345.032);
  int i = printf("double2_f_3351c===%-+.2v2lf===%-+.2v2lf===\n",var1,var2);
  return i;
}

int double2_f_3352c() {
  // { dg-printf "double2_f_3352c===+123455.134,-1.230===-1.230,-12345.032===" }
  double2 var1 = (double2) (123455.134,-1.23);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_f_3352c===%-+.3v2lf===%-+.3v2lf===\n",var1,var2);
  return i;
}

int double2_f_3353c() {
  // { dg-printf "double2_f_3353c===+2.0000000000,-1.2300000000===+2.0000000000,+0.0000000000===" }
  double2 var1 = (double2) (2.0,-1.23);
  double2 var2 = (double2) (2.0,0.0);
  int i = printf("double2_f_3353c===%-+.10v2lf===%-+.10v2lf===\n",var1,var2);
  return i;
}

int double2_f_3354c() {
  // { dg-printf "double2_f_3354c===-12345.032000,+123455.134000===+2.000000,-1.230000===" }
  double2 var1 = (double2) (-12345.032,123455.134);
  double2 var2 = (double2) (2.0,-1.23);
  int i = printf("double2_f_3354c===%-+v2lF===%-+v2lF===\n",var1,var2);
  return i;
}

int double2_f_3355c() {
  // { dg-printf "double2_f_3355c===+1.0,-12345.0===-1.2,+0.0===" }
  double2 var1 = (double2) (1.0,-12345.032);
  double2 var2 = (double2) (-1.23,0.0);
  int i = printf("double2_f_3355c===%-+.1v2lF===%-+.1v2lF===\n",var1,var2);
  return i;
}

int double2_f_3356c() {
  // { dg-printf "double2_f_3356c===-12345.03,-1.23===+2.00,+2.00===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_f_3356c===%-+.2v2lF===%-+.2v2lF===\n",var1,var2);
  return i;
}

int double2_f_3357c() {
  // { dg-printf "double2_f_3357c===+2.000,+2.000===+2.000,-1.230===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (2.0,-1.23);
  int i = printf("double2_f_3357c===%-+.3v2lF===%-+.3v2lF===\n",var1,var2);
  return i;
}

int double2_f_3358c() {
  // { dg-printf "double2_f_3358c===+0.0000000000,-1.2300000000===+123455.1340000000,+1.0000000000===" }
  double2 var1 = (double2) (0.0,-1.23);
  double2 var2 = (double2) (123455.134,1.0);
  int i = printf("double2_f_3358c===%-+.10v2lF===%-+.10v2lF===\n",var1,var2);
  return i;
}

int double2_f_4109c() {
  // { dg-printf "double2_f_4109c===  1.000000, -1.230000===-12345.032000, -1.230000===" }
  double2 var1 = (double2) (1.0,-1.23);
  double2 var2 = (double2) (-12345.032,-1.23);
  int i = printf("double2_f_4109c===% 10v2lf===% 10v2lf===\n",var1,var2);
  return i;
}

int double2_f_4110c() {
  // { dg-printf "double2_f_4110c===  -12345.0,  123455.1===      -1.2,  -12345.0===" }
  double2 var1 = (double2) (-12345.032,123455.134);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_f_4110c===% 10.1v2lf===% 10.1v2lf===\n",var1,var2);
  return i;
}

int double2_f_4111c() {
  // { dg-printf "double2_f_4111c===      2.00, 123455.13===      1.00,      1.00===" }
  double2 var1 = (double2) (2.0,123455.134);
  double2 var2 = (double2) (1.0,1.0);
  int i = printf("double2_f_4111c===% 10.2v2lf===% 10.2v2lf===\n",var1,var2);
  return i;
}

int double2_f_4112c() {
  // { dg-printf "double2_f_4112c===     1.000,     0.000===     0.000,     1.000===" }
  double2 var1 = (double2) (1.0,0.0);
  double2 var2 = (double2) (0.0,1.0);
  int i = printf("double2_f_4112c===% 10.3v2lf===% 10.3v2lf===\n",var1,var2);
  return i;
}

int double2_f_4113c() {
  // { dg-printf "double2_f_4113c=== 1.0000000000, 123455.1340000000=== 123455.1340000000, 2.0000000000===" }
  double2 var1 = (double2) (1.0,123455.134);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_f_4113c===% 10.10v2lf===% 10.10v2lf===\n",var1,var2);
  return i;
}

int double2_f_4114c() {
  // { dg-printf "double2_f_4114c===  1.000000,  2.000000=== 123455.134000, -1.230000===" }
  double2 var1 = (double2) (1.0,2.0);
  double2 var2 = (double2) (123455.134,-1.23);
  int i = printf("double2_f_4114c===% 10v2lF===% 10v2lF===\n",var1,var2);
  return i;
}

int double2_f_4115c() {
  // { dg-printf "double2_f_4115c===  -12345.0,  123455.1===  -12345.0,       2.0===" }
  double2 var1 = (double2) (-12345.032,123455.134);
  double2 var2 = (double2) (-12345.032,2.0);
  int i = printf("double2_f_4115c===% 10.1v2lF===% 10.1v2lF===\n",var1,var2);
  return i;
}

int double2_f_4116c() {
  // { dg-printf "double2_f_4116c===     -1.23,     -1.23===      2.00,      0.00===" }
  double2 var1 = (double2) (-1.23,-1.23);
  double2 var2 = (double2) (2.0,0.0);
  int i = printf("double2_f_4116c===% 10.2v2lF===% 10.2v2lF===\n",var1,var2);
  return i;
}

int double2_f_4117c() {
  // { dg-printf "double2_f_4117c===     1.000,     2.000=== 123455.134,     0.000===" }
  double2 var1 = (double2) (1.0,2.0);
  double2 var2 = (double2) (123455.134,0.0);
  int i = printf("double2_f_4117c===% 10.3v2lF===% 10.3v2lF===\n",var1,var2);
  return i;
}

int double2_f_4118c() {
  // { dg-printf "double2_f_4118c=== 2.0000000000, 2.0000000000===-1.2300000000,-12345.0320000000===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_f_4118c===% 10.10v2lF===% 10.10v2lF===\n",var1,var2);
  return i;
}

int double2_f_4869c() {
  // { dg-printf "double2_f_4869c===-01.230000,002.000000===123455.134000,123455.134000===" }
  double2 var1 = (double2) (-1.23,2.0);
  double2 var2 = (double2) (123455.134,123455.134);
  int i = printf("double2_f_4869c===%010v2lf===%010v2lf===\n",var1,var2);
  return i;
}

int double2_f_4870c() {
  // { dg-printf "double2_f_4870c===00000002.0,00000001.0===-0012345.0,-0000001.2===" }
  double2 var1 = (double2) (2.0,1.0);
  double2 var2 = (double2) (-12345.032,-1.23);
  int i = printf("double2_f_4870c===%010.1v2lf===%010.1v2lf===\n",var1,var2);
  return i;
}

int double2_f_4871c() {
  // { dg-printf "double2_f_4871c===0000000.00,0000000.00===-000001.23,0123455.13===" }
  double2 var1 = (double2) (0.0,0.0);
  double2 var2 = (double2) (-1.23,123455.134);
  int i = printf("double2_f_4871c===%010.2v2lf===%010.2v2lf===\n",var1,var2);
  return i;
}

int double2_f_4872c() {
  // { dg-printf "double2_f_4872c===000000.000,000000.000===000002.000,000000.000===" }
  double2 var1 = (double2) (0.0,0.0);
  double2 var2 = (double2) (2.0,0.0);
  int i = printf("double2_f_4872c===%010.3v2lf===%010.3v2lf===\n",var1,var2);
  return i;
}

int double2_f_4873c() {
  // { dg-printf "double2_f_4873c===1.0000000000,0.0000000000===0.0000000000,0.0000000000===" }
  double2 var1 = (double2) (1.0,0.0);
  double2 var2 = (double2) (0.0,0.0);
  int i = printf("double2_f_4873c===%010.10v2lf===%010.10v2lf===\n",var1,var2);
  return i;
}

int double2_f_4874c() {
  // { dg-printf "double2_f_4874c===-01.230000,002.000000===001.000000,-01.230000===" }
  double2 var1 = (double2) (-1.23,2.0);
  double2 var2 = (double2) (1.0,-1.23);
  int i = printf("double2_f_4874c===%010v2lF===%010v2lF===\n",var1,var2);
  return i;
}

int double2_f_4875c() {
  // { dg-printf "double2_f_4875c===-0012345.0,00000002.0===00123455.1,00000002.0===" }
  double2 var1 = (double2) (-12345.032,2.0);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_f_4875c===%010.1v2lF===%010.1v2lF===\n",var1,var2);
  return i;
}

int double2_f_4876c() {
  // { dg-printf "double2_f_4876c===0000001.00,0123455.13===0000002.00,0000002.00===" }
  double2 var1 = (double2) (1.0,123455.134);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_f_4876c===%010.2v2lF===%010.2v2lF===\n",var1,var2);
  return i;
}

int double2_f_4877c() {
  // { dg-printf "double2_f_4877c===000002.000,000000.000===123455.134,000001.000===" }
  double2 var1 = (double2) (2.0,0.0);
  double2 var2 = (double2) (123455.134,1.0);
  int i = printf("double2_f_4877c===%010.3v2lF===%010.3v2lF===\n",var1,var2);
  return i;
}

int double2_f_4878c() {
  // { dg-printf "double2_f_4878c===1.0000000000,-12345.0320000000===-12345.0320000000,-1.2300000000===" }
  double2 var1 = (double2) (1.0,-12345.032);
  double2 var2 = (double2) (-12345.032,-1.23);
  int i = printf("double2_f_4878c===%010.10v2lF===%010.10v2lF===\n",var1,var2);
  return i;
}

int double2_f_5629c() {
  // { dg-printf "double2_f_5629c=== 0.000000 , 1.000000 ===-1.230000 ,-1.230000 ===" }
  double2 var1 = (double2) (0.0,1.0);
  double2 var2 = (double2) (-1.23,-1.23);
  int i = printf("double2_f_5629c===%- 10v2lf===%- 10v2lf===\n",var1,var2);
  return i;
}

int double2_f_5630c() {
  // { dg-printf "double2_f_5630c=== 123455.1 , 1.0      === 0.0      , 1.0      ===" }
  double2 var1 = (double2) (123455.134,1.0);
  double2 var2 = (double2) (0.0,1.0);
  int i = printf("double2_f_5630c===%- 10.1v2lf===%- 10.1v2lf===\n",var1,var2);
  return i;
}

int double2_f_5631c() {
  // { dg-printf "double2_f_5631c===-12345.03 ,-12345.03 ===-1.23     ,-1.23     ===" }
  double2 var1 = (double2) (-12345.032,-12345.032);
  double2 var2 = (double2) (-1.23,-1.23);
  int i = printf("double2_f_5631c===%- 10.2v2lf===%- 10.2v2lf===\n",var1,var2);
  return i;
}

int double2_f_5632c() {
  // { dg-printf "double2_f_5632c===-1.230    ,-12345.032===-1.230    ,-1.230    ===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (-1.23,-1.23);
  int i = printf("double2_f_5632c===%- 10.3v2lf===%- 10.3v2lf===\n",var1,var2);
  return i;
}

int double2_f_5633c() {
  // { dg-printf "double2_f_5633c===-12345.0320000000, 123455.1340000000=== 2.0000000000, 0.0000000000===" }
  double2 var1 = (double2) (-12345.032,123455.134);
  double2 var2 = (double2) (2.0,0.0);
  int i = printf("double2_f_5633c===%- 10.10v2lf===%- 10.10v2lf===\n",var1,var2);
  return i;
}

int double2_f_5634c() {
  // { dg-printf "double2_f_5634c===-1.230000 ,-1.230000 === 0.000000 , 1.000000 ===" }
  double2 var1 = (double2) (-1.23,-1.23);
  double2 var2 = (double2) (0.0,1.0);
  int i = printf("double2_f_5634c===%- 10v2lF===%- 10v2lF===\n",var1,var2);
  return i;
}

int double2_f_5635c() {
  // { dg-printf "double2_f_5635c===-1.2      , 123455.1 === 123455.1 , 1.0      ===" }
  double2 var1 = (double2) (-1.23,123455.134);
  double2 var2 = (double2) (123455.134,1.0);
  int i = printf("double2_f_5635c===%- 10.1v2lF===%- 10.1v2lF===\n",var1,var2);
  return i;
}

int double2_f_5636c() {
  // { dg-printf "double2_f_5636c===-1.23     ,-12345.03 === 123455.13,-1.23     ===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (123455.134,-1.23);
  int i = printf("double2_f_5636c===%- 10.2v2lF===%- 10.2v2lF===\n",var1,var2);
  return i;
}

int double2_f_5637c() {
  // { dg-printf "double2_f_5637c=== 1.000    , 123455.134=== 0.000    , 0.000    ===" }
  double2 var1 = (double2) (1.0,123455.134);
  double2 var2 = (double2) (0.0,0.0);
  int i = printf("double2_f_5637c===%- 10.3v2lF===%- 10.3v2lF===\n",var1,var2);
  return i;
}

int double2_f_5638c() {
  // { dg-printf "double2_f_5638c=== 0.0000000000,-1.2300000000=== 2.0000000000,-12345.0320000000===" }
  double2 var1 = (double2) (0.0,-1.23);
  double2 var2 = (double2) (2.0,-12345.032);
  int i = printf("double2_f_5638c===%- 10.10v2lF===%- 10.10v2lF===\n",var1,var2);
  return i;
}

int double2_f_6389c() {
  // { dg-printf "double2_f_6389c===-12345.032000, +1.000000=== +1.000000, +1.000000===" }
  double2 var1 = (double2) (-12345.032,1.0);
  double2 var2 = (double2) (1.0,1.0);
  int i = printf("double2_f_6389c===%+ 10v2lf===%+ 10v2lf===\n",var1,var2);
  return i;
}

int double2_f_6390c() {
  // { dg-printf "double2_f_6390c===      -1.2,  -12345.0=== +123455.1,      -1.2===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (123455.134,-1.23);
  int i = printf("double2_f_6390c===%+ 10.1v2lf===%+ 10.1v2lf===\n",var1,var2);
  return i;
}

int double2_f_6391c() {
  // { dg-printf "double2_f_6391c===     +2.00,     +2.00===     -1.23,     +0.00===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (-1.23,0.0);
  int i = printf("double2_f_6391c===%+ 10.2v2lf===%+ 10.2v2lf===\n",var1,var2);
  return i;
}

int double2_f_6392c() {
  // { dg-printf "double2_f_6392c===    -1.230,-12345.032===    -1.230,-12345.032===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_f_6392c===%+ 10.3v2lf===%+ 10.3v2lf===\n",var1,var2);
  return i;
}

int double2_f_6393c() {
  // { dg-printf "double2_f_6393c===+1.0000000000,+123455.1340000000===+0.0000000000,+2.0000000000===" }
  double2 var1 = (double2) (1.0,123455.134);
  double2 var2 = (double2) (0.0,2.0);
  int i = printf("double2_f_6393c===%+ 10.10v2lf===%+ 10.10v2lf===\n",var1,var2);
  return i;
}

int double2_f_6394c() {
  // { dg-printf "double2_f_6394c=== -1.230000, +0.000000=== +1.000000,-12345.032000===" }
  double2 var1 = (double2) (-1.23,0.0);
  double2 var2 = (double2) (1.0,-12345.032);
  int i = printf("double2_f_6394c===%+ 10v2lF===%+ 10v2lF===\n",var1,var2);
  return i;
}

int double2_f_6395c() {
  // { dg-printf "double2_f_6395c===      +1.0,      -1.2===      -1.2,      -1.2===" }
  double2 var1 = (double2) (1.0,-1.23);
  double2 var2 = (double2) (-1.23,-1.23);
  int i = printf("double2_f_6395c===%+ 10.1v2lF===%+ 10.1v2lF===\n",var1,var2);
  return i;
}

int double2_f_6396c() {
  // { dg-printf "double2_f_6396c===     +2.00, -12345.03=== -12345.03,     +0.00===" }
  double2 var1 = (double2) (2.0,-12345.032);
  double2 var2 = (double2) (-12345.032,0.0);
  int i = printf("double2_f_6396c===%+ 10.2v2lF===%+ 10.2v2lF===\n",var1,var2);
  return i;
}

int double2_f_6397c() {
  // { dg-printf "double2_f_6397c===    +2.000,    +2.000===    +0.000,    +1.000===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (0.0,1.0);
  int i = printf("double2_f_6397c===%+ 10.3v2lF===%+ 10.3v2lF===\n",var1,var2);
  return i;
}

int double2_f_6398c() {
  // { dg-printf "double2_f_6398c===+2.0000000000,+0.0000000000===+2.0000000000,+2.0000000000===" }
  double2 var1 = (double2) (2.0,0.0);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_f_6398c===%+ 10.10v2lF===%+ 10.10v2lF===\n",var1,var2);
  return i;
}

int double2_f_7149c() {
  // { dg-printf "double2_f_7149c===+123455.134000,+02.000000===-01.230000,+123455.134000===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (-1.23,123455.134);
  int i = printf("double2_f_7149c===%+010v2lf===%+010v2lf===\n",var1,var2);
  return i;
}

int double2_f_7150c() {
  // { dg-printf "double2_f_7150c===+0000000.0,-0012345.0===+0000000.0,-0012345.0===" }
  double2 var1 = (double2) (0.0,-12345.032);
  double2 var2 = (double2) (0.0,-12345.032);
  int i = printf("double2_f_7150c===%+010.1v2lf===%+010.1v2lf===\n",var1,var2);
  return i;
}

int double2_f_7151c() {
  // { dg-printf "double2_f_7151c===+123455.13,+000000.00===+000000.00,-012345.03===" }
  double2 var1 = (double2) (123455.134,0.0);
  double2 var2 = (double2) (0.0,-12345.032);
  int i = printf("double2_f_7151c===%+010.2v2lf===%+010.2v2lf===\n",var1,var2);
  return i;
}

int double2_f_7152c() {
  // { dg-printf "double2_f_7152c===-12345.032,+00000.000===+00001.000,-00001.230===" }
  double2 var1 = (double2) (-12345.032,0.0);
  double2 var2 = (double2) (1.0,-1.23);
  int i = printf("double2_f_7152c===%+010.3v2lf===%+010.3v2lf===\n",var1,var2);
  return i;
}

int double2_f_7153c() {
  // { dg-printf "double2_f_7153c===-12345.0320000000,+123455.1340000000===+1.0000000000,-1.2300000000===" }
  double2 var1 = (double2) (-12345.032,123455.134);
  double2 var2 = (double2) (1.0,-1.23);
  int i = printf("double2_f_7153c===%+010.10v2lf===%+010.10v2lf===\n",var1,var2);
  return i;
}

int double2_f_7154c() {
  // { dg-printf "double2_f_7154c===+02.000000,-01.230000===-12345.032000,+123455.134000===" }
  double2 var1 = (double2) (2.0,-1.23);
  double2 var2 = (double2) (-12345.032,123455.134);
  int i = printf("double2_f_7154c===%+010v2lF===%+010v2lF===\n",var1,var2);
  return i;
}

int double2_f_7155c() {
  // { dg-printf "double2_f_7155c===+0000002.0,+0000002.0===-0000001.2,-0000001.2===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (-1.23,-1.23);
  int i = printf("double2_f_7155c===%+010.1v2lF===%+010.1v2lF===\n",var1,var2);
  return i;
}

int double2_f_7156c() {
  // { dg-printf "double2_f_7156c===+000001.00,+000000.00===+123455.13,+123455.13===" }
  double2 var1 = (double2) (1.0,0.0);
  double2 var2 = (double2) (123455.134,123455.134);
  int i = printf("double2_f_7156c===%+010.2v2lF===%+010.2v2lF===\n",var1,var2);
  return i;
}

int double2_f_7157c() {
  // { dg-printf "double2_f_7157c===+00000.000,+123455.134===+00002.000,+00002.000===" }
  double2 var1 = (double2) (0.0,123455.134);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_f_7157c===%+010.3v2lF===%+010.3v2lF===\n",var1,var2);
  return i;
}

int double2_f_7158c() {
  // { dg-printf "double2_f_7158c===+0.0000000000,+0.0000000000===+0.0000000000,+0.0000000000===" }
  double2 var1 = (double2) (0.0,0.0);
  double2 var2 = (double2) (0.0,0.0);
  int i = printf("double2_f_7158c===%+010.10v2lF===%+010.10v2lF===\n",var1,var2);
  return i;
}

int double2_g_1079c() {
  // { dg-printf "double2_g_1079c===1,2===123455,-12345===" }
  double2 var1 = (double2) (1.0,2.0);
  double2 var2 = (double2) (123455.134,-12345.032);
  int i = printf("double2_g_1079c===%-v2lg===%-v2lg===\n",var1,var2);
  return i;
}

int double2_g_1080c() {
  // { dg-printf "double2_g_1080c===-1,2===-1e+04,1e+05===" }
  double2 var1 = (double2) (-1.23,2.0);
  double2 var2 = (double2) (-12345.032,123455.134);
  int i = printf("double2_g_1080c===%-.1v2lg===%-.1v2lg===\n",var1,var2);
  return i;
}

int double2_g_1081c() {
  // { dg-printf "double2_g_1081c===-1.2e+04,1===1.2e+05,-1.2===" }
  double2 var1 = (double2) (-12345.032,1.0);
  double2 var2 = (double2) (123455.134,-1.23);
  int i = printf("double2_g_1081c===%-.2v2lg===%-.2v2lg===\n",var1,var2);
  return i;
}

int double2_g_1082c() {
  // { dg-printf "double2_g_1082c===1.23e+05,0===-1.23,1.23e+05===" }
  double2 var1 = (double2) (123455.134,0.0);
  double2 var2 = (double2) (-1.23,123455.134);
  int i = printf("double2_g_1082c===%-.3v2lg===%-.3v2lg===\n",var1,var2);
  return i;
}

int double2_g_1083c() {
  // { dg-printf "double2_g_1083c===2,-12345.032===0,123455.134===" }
  double2 var1 = (double2) (2.0,-12345.032);
  double2 var2 = (double2) (0.0,123455.134);
  int i = printf("double2_g_1083c===%-.10v2lg===%-.10v2lg===\n",var1,var2);
  return i;
}

int double2_g_1084c() {
  // { dg-printf "double2_g_1084c===1,2===1,0===" }
  double2 var1 = (double2) (1.0,2.0);
  double2 var2 = (double2) (1.0,0.0);
  int i = printf("double2_g_1084c===%-v2lG===%-v2lG===\n",var1,var2);
  return i;
}

int double2_g_1085c() {
  // { dg-printf "double2_g_1085c===-1E+04,1E+05===1E+05,-1===" }
  double2 var1 = (double2) (-12345.032,123455.134);
  double2 var2 = (double2) (123455.134,-1.23);
  int i = printf("double2_g_1085c===%-.1v2lG===%-.1v2lG===\n",var1,var2);
  return i;
}

int double2_g_1086c() {
  // { dg-printf "double2_g_1086c===0,-1.2===-1.2E+04,1===" }
  double2 var1 = (double2) (0.0,-1.23);
  double2 var2 = (double2) (-12345.032,1.0);
  int i = printf("double2_g_1086c===%-.2v2lG===%-.2v2lG===\n",var1,var2);
  return i;
}

int double2_g_1087c() {
  // { dg-printf "double2_g_1087c===2,2===-1.23,-1.23E+04===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_g_1087c===%-.3v2lG===%-.3v2lG===\n",var1,var2);
  return i;
}

int double2_g_1088c() {
  // { dg-printf "double2_g_1088c===-1.23,-12345.032===-1.23,2===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (-1.23,2.0);
  int i = printf("double2_g_1088c===%-.10v2lG===%-.10v2lG===\n",var1,var2);
  return i;
}

int double2_g_1839c() {
  // { dg-printf "double2_g_1839c===-12345,+1===-1.23,+0===" }
  double2 var1 = (double2) (-12345.032,1.0);
  double2 var2 = (double2) (-1.23,0.0);
  int i = printf("double2_g_1839c===%+v2lg===%+v2lg===\n",var1,var2);
  return i;
}

int double2_g_1840c() {
  // { dg-printf "double2_g_1840c===+2,+1===+2,+0===" }
  double2 var1 = (double2) (2.0,1.0);
  double2 var2 = (double2) (2.0,0.0);
  int i = printf("double2_g_1840c===%+.1v2lg===%+.1v2lg===\n",var1,var2);
  return i;
}

int double2_g_1841c() {
  // { dg-printf "double2_g_1841c===-1.2e+04,+2===+1,+1===" }
  double2 var1 = (double2) (-12345.032,2.0);
  double2 var2 = (double2) (1.0,1.0);
  int i = printf("double2_g_1841c===%+.2v2lg===%+.2v2lg===\n",var1,var2);
  return i;
}

int double2_g_1842c() {
  // { dg-printf "double2_g_1842c===+0,-1.23e+04===-1.23e+04,+1===" }
  double2 var1 = (double2) (0.0,-12345.032);
  double2 var2 = (double2) (-12345.032,1.0);
  int i = printf("double2_g_1842c===%+.3v2lg===%+.3v2lg===\n",var1,var2);
  return i;
}

int double2_g_1843c() {
  // { dg-printf "double2_g_1843c===+0,+2===+2,+2===" }
  double2 var1 = (double2) (0.0,2.0);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_g_1843c===%+.10v2lg===%+.10v2lg===\n",var1,var2);
  return i;
}

int double2_g_1844c() {
  // { dg-printf "double2_g_1844c===+1,-12345===-1.23,+1===" }
  double2 var1 = (double2) (1.0,-12345.032);
  double2 var2 = (double2) (-1.23,1.0);
  int i = printf("double2_g_1844c===%+v2lG===%+v2lG===\n",var1,var2);
  return i;
}

int double2_g_1845c() {
  // { dg-printf "double2_g_1845c===+2,-1E+04===+1,+0===" }
  double2 var1 = (double2) (2.0,-12345.032);
  double2 var2 = (double2) (1.0,0.0);
  int i = printf("double2_g_1845c===%+.1v2lG===%+.1v2lG===\n",var1,var2);
  return i;
}

int double2_g_1846c() {
  // { dg-printf "double2_g_1846c===-1.2E+04,-1.2===-1.2E+04,+1===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (-12345.032,1.0);
  int i = printf("double2_g_1846c===%+.2v2lG===%+.2v2lG===\n",var1,var2);
  return i;
}

int double2_g_1847c() {
  // { dg-printf "double2_g_1847c===+0,-1.23E+04===+1,-1.23===" }
  double2 var1 = (double2) (0.0,-12345.032);
  double2 var2 = (double2) (1.0,-1.23);
  int i = printf("double2_g_1847c===%+.3v2lG===%+.3v2lG===\n",var1,var2);
  return i;
}

int double2_g_1848c() {
  // { dg-printf "double2_g_1848c===-12345.032,-1.23===+1,-1.23===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (1.0,-1.23);
  int i = printf("double2_g_1848c===%+.10v2lG===%+.10v2lG===\n",var1,var2);
  return i;
}

int double2_g_2599c() {
  // { dg-printf "double2_g_2599c===2.00000,123455.===123455.,-12345.0===" }
  double2 var1 = (double2) (2.0,123455.134);
  double2 var2 = (double2) (123455.134,-12345.032);
  int i = printf("double2_g_2599c===%#v2lg===%#v2lg===\n",var1,var2);
  return i;
}

int double2_g_2600c() {
  // { dg-printf "double2_g_2600c===-1.e+04,0.0===1.,2.===" }
  double2 var1 = (double2) (-12345.032,0.0);
  double2 var2 = (double2) (1.0,2.0);
  int i = printf("double2_g_2600c===%#.1v2lg===%#.1v2lg===\n",var1,var2);
  return i;
}

int double2_g_2601c() {
  // { dg-printf "double2_g_2601c===-1.2e+04,-1.2===0.00,1.2e+05===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (0.0,123455.134);
  int i = printf("double2_g_2601c===%#.2v2lg===%#.2v2lg===\n",var1,var2);
  return i;
}

int double2_g_2602c() {
  // { dg-printf "double2_g_2602c===-1.23e+04,-1.23e+04===-1.23,2.00===" }
  double2 var1 = (double2) (-12345.032,-12345.032);
  double2 var2 = (double2) (-1.23,2.0);
  int i = printf("double2_g_2602c===%#.3v2lg===%#.3v2lg===\n",var1,var2);
  return i;
}

int double2_g_2603c() {
  // { dg-printf "double2_g_2603c===-1.230000000,-1.230000000===1.000000000,0.0000000000===" }
  double2 var1 = (double2) (-1.23,-1.23);
  double2 var2 = (double2) (1.0,0.0);
  int i = printf("double2_g_2603c===%#.10v2lg===%#.10v2lg===\n",var1,var2);
  return i;
}

int double2_g_2604c() {
  // { dg-printf "double2_g_2604c===0.000000,2.00000===-1.23000,-1.23000===" }
  double2 var1 = (double2) (0.0,2.0);
  double2 var2 = (double2) (-1.23,-1.23);
  int i = printf("double2_g_2604c===%#v2lG===%#v2lG===\n",var1,var2);
  return i;
}

int double2_g_2605c() {
  // { dg-printf "double2_g_2605c===1.,1.===2.,-1.E+04===" }
  double2 var1 = (double2) (1.0,1.0);
  double2 var2 = (double2) (2.0,-12345.032);
  int i = printf("double2_g_2605c===%#.1v2lG===%#.1v2lG===\n",var1,var2);
  return i;
}

int double2_g_2606c() {
  // { dg-printf "double2_g_2606c===1.2E+05,1.0===1.2E+05,2.0===" }
  double2 var1 = (double2) (123455.134,1.0);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_g_2606c===%#.2v2lG===%#.2v2lG===\n",var1,var2);
  return i;
}

int double2_g_2607c() {
  // { dg-printf "double2_g_2607c===-1.23E+04,0.000===1.23E+05,1.00===" }
  double2 var1 = (double2) (-12345.032,0.0);
  double2 var2 = (double2) (123455.134,1.0);
  int i = printf("double2_g_2607c===%#.3v2lG===%#.3v2lG===\n",var1,var2);
  return i;
}

int double2_g_2608c() {
  // { dg-printf "double2_g_2608c===-12345.03200,0.0000000000===0.0000000000,2.000000000===" }
  double2 var1 = (double2) (-12345.032,0.0);
  double2 var2 = (double2) (0.0,2.0);
  int i = printf("double2_g_2608c===%#.10v2lG===%#.10v2lG===\n",var1,var2);
  return i;
}

int double2_g_319c() {
  // { dg-printf "double2_g_319c===123455,1===123455,-1.23===" }
  double2 var1 = (double2) (123455.134,1.0);
  double2 var2 = (double2) (123455.134,-1.23);
  int i = printf("double2_g_319c===%v2lg===%v2lg===\n",var1,var2);
  return i;
}

int double2_g_320c() {
  // { dg-printf "double2_g_320c===1,-1e+04===1e+05,1===" }
  double2 var1 = (double2) (1.0,-12345.032);
  double2 var2 = (double2) (123455.134,1.0);
  int i = printf("double2_g_320c===%.1v2lg===%.1v2lg===\n",var1,var2);
  return i;
}

int double2_g_321c() {
  // { dg-printf "double2_g_321c===-1.2e+04,-1.2e+04===0,2===" }
  double2 var1 = (double2) (-12345.032,-12345.032);
  double2 var2 = (double2) (0.0,2.0);
  int i = printf("double2_g_321c===%.2v2lg===%.2v2lg===\n",var1,var2);
  return i;
}

int double2_g_322c() {
  // { dg-printf "double2_g_322c===-1.23e+04,-1.23e+04===1.23e+05,1.23e+05===" }
  double2 var1 = (double2) (-12345.032,-12345.032);
  double2 var2 = (double2) (123455.134,123455.134);
  int i = printf("double2_g_322c===%.3v2lg===%.3v2lg===\n",var1,var2);
  return i;
}

int double2_g_323c() {
  // { dg-printf "double2_g_323c===-1.23,0===-1.23,0===" }
  double2 var1 = (double2) (-1.23,0.0);
  double2 var2 = (double2) (-1.23,0.0);
  int i = printf("double2_g_323c===%.10v2lg===%.10v2lg===\n",var1,var2);
  return i;
}

int double2_g_324c() {
  // { dg-printf "double2_g_324c===123455,1===-1.23,-12345===" }
  double2 var1 = (double2) (123455.134,1.0);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_g_324c===%v2lG===%v2lG===\n",var1,var2);
  return i;
}

int double2_g_325c() {
  // { dg-printf "double2_g_325c===-1,1E+05===1,-1E+04===" }
  double2 var1 = (double2) (-1.23,123455.134);
  double2 var2 = (double2) (1.0,-12345.032);
  int i = printf("double2_g_325c===%.1v2lG===%.1v2lG===\n",var1,var2);
  return i;
}

int double2_g_326c() {
  // { dg-printf "double2_g_326c===1.2E+05,2===-1.2E+04,1.2E+05===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (-12345.032,123455.134);
  int i = printf("double2_g_326c===%.2v2lG===%.2v2lG===\n",var1,var2);
  return i;
}

int double2_g_327c() {
  // { dg-printf "double2_g_327c===2,-1.23E+04===0,-1.23===" }
  double2 var1 = (double2) (2.0,-12345.032);
  double2 var2 = (double2) (0.0,-1.23);
  int i = printf("double2_g_327c===%.3v2lG===%.3v2lG===\n",var1,var2);
  return i;
}

int double2_g_328c() {
  // { dg-printf "double2_g_328c===-12345.032,-1.23===123455.134,0===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (123455.134,0.0);
  int i = printf("double2_g_328c===%.10v2lG===%.10v2lG===\n",var1,var2);
  return i;
}

int double2_g_3359c() {
  // { dg-printf "double2_g_3359c===+1,+1===+1,+2===" }
  double2 var1 = (double2) (1.0,1.0);
  double2 var2 = (double2) (1.0,2.0);
  int i = printf("double2_g_3359c===%-+v2lg===%-+v2lg===\n",var1,var2);
  return i;
}

int double2_g_3360c() {
  // { dg-printf "double2_g_3360c===+0,+1e+05===+0,+2===" }
  double2 var1 = (double2) (0.0,123455.134);
  double2 var2 = (double2) (0.0,2.0);
  int i = printf("double2_g_3360c===%-+.1v2lg===%-+.1v2lg===\n",var1,var2);
  return i;
}

int double2_g_3361c() {
  // { dg-printf "double2_g_3361c===+1.2e+05,+1===-1.2,-1.2===" }
  double2 var1 = (double2) (123455.134,1.0);
  double2 var2 = (double2) (-1.23,-1.23);
  int i = printf("double2_g_3361c===%-+.2v2lg===%-+.2v2lg===\n",var1,var2);
  return i;
}

int double2_g_3362c() {
  // { dg-printf "double2_g_3362c===+1,-1.23e+04===-1.23,+2===" }
  double2 var1 = (double2) (1.0,-12345.032);
  double2 var2 = (double2) (-1.23,2.0);
  int i = printf("double2_g_3362c===%-+.3v2lg===%-+.3v2lg===\n",var1,var2);
  return i;
}

int double2_g_3363c() {
  // { dg-printf "double2_g_3363c===+123455.134,+1===+2,-12345.032===" }
  double2 var1 = (double2) (123455.134,1.0);
  double2 var2 = (double2) (2.0,-12345.032);
  int i = printf("double2_g_3363c===%-+.10v2lg===%-+.10v2lg===\n",var1,var2);
  return i;
}

int double2_g_3364c() {
  // { dg-printf "double2_g_3364c===-12345,+123455===-1.23,-1.23===" }
  double2 var1 = (double2) (-12345.032,123455.134);
  double2 var2 = (double2) (-1.23,-1.23);
  int i = printf("double2_g_3364c===%-+v2lG===%-+v2lG===\n",var1,var2);
  return i;
}

int double2_g_3365c() {
  // { dg-printf "double2_g_3365c===+1E+05,+1E+05===+1E+05,+2===" }
  double2 var1 = (double2) (123455.134,123455.134);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_g_3365c===%-+.1v2lG===%-+.1v2lG===\n",var1,var2);
  return i;
}

int double2_g_3366c() {
  // { dg-printf "double2_g_3366c===+2,+0===+1.2E+05,+2===" }
  double2 var1 = (double2) (2.0,0.0);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_g_3366c===%-+.2v2lG===%-+.2v2lG===\n",var1,var2);
  return i;
}

int double2_g_3367c() {
  // { dg-printf "double2_g_3367c===-1.23E+04,-1.23===+1.23E+05,+1.23E+05===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (123455.134,123455.134);
  int i = printf("double2_g_3367c===%-+.3v2lG===%-+.3v2lG===\n",var1,var2);
  return i;
}

int double2_g_3368c() {
  // { dg-printf "double2_g_3368c===+0,+1===+0,-1.23===" }
  double2 var1 = (double2) (0.0,1.0);
  double2 var2 = (double2) (0.0,-1.23);
  int i = printf("double2_g_3368c===%-+.10v2lG===%-+.10v2lG===\n",var1,var2);
  return i;
}

int double2_g_4119c() {
  // { dg-printf "double2_g_4119c===    -12345,         0===    123455,    -12345===" }
  double2 var1 = (double2) (-12345.032,0.0);
  double2 var2 = (double2) (123455.134,-12345.032);
  int i = printf("double2_g_4119c===% 10v2lg===% 10v2lg===\n",var1,var2);
  return i;
}

int double2_g_4120c() {
  // { dg-printf "double2_g_4120c===        -1,         2===        -1,         1===" }
  double2 var1 = (double2) (-1.23,2.0);
  double2 var2 = (double2) (-1.23,1.0);
  int i = printf("double2_g_4120c===% 10.1v2lg===% 10.1v2lg===\n",var1,var2);
  return i;
}

int double2_g_4121c() {
  // { dg-printf "double2_g_4121c===         2,         2===  -1.2e+04,  -1.2e+04===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (-12345.032,-12345.032);
  int i = printf("double2_g_4121c===% 10.2v2lg===% 10.2v2lg===\n",var1,var2);
  return i;
}

int double2_g_4122c() {
  // { dg-printf "double2_g_4122c===         1,     -1.23===         2,  1.23e+05===" }
  double2 var1 = (double2) (1.0,-1.23);
  double2 var2 = (double2) (2.0,123455.134);
  int i = printf("double2_g_4122c===% 10.3v2lg===% 10.3v2lg===\n",var1,var2);
  return i;
}

int double2_g_4123c() {
  // { dg-printf "double2_g_4123c===     -1.23, 123455.134=== 123455.134,         1===" }
  double2 var1 = (double2) (-1.23,123455.134);
  double2 var2 = (double2) (123455.134,1.0);
  int i = printf("double2_g_4123c===% 10.10v2lg===% 10.10v2lg===\n",var1,var2);
  return i;
}

int double2_g_4124c() {
  // { dg-printf "double2_g_4124c===    123455,    123455===    -12345,     -1.23===" }
  double2 var1 = (double2) (123455.134,123455.134);
  double2 var2 = (double2) (-12345.032,-1.23);
  int i = printf("double2_g_4124c===% 10v2lG===% 10v2lG===\n",var1,var2);
  return i;
}

int double2_g_4125c() {
  // { dg-printf "double2_g_4125c===         2,         1===     1E+05,         1===" }
  double2 var1 = (double2) (2.0,1.0);
  double2 var2 = (double2) (123455.134,1.0);
  int i = printf("double2_g_4125c===% 10.1v2lG===% 10.1v2lG===\n",var1,var2);
  return i;
}

int double2_g_4126c() {
  // { dg-printf "double2_g_4126c===   1.2E+05,   1.2E+05===      -1.2,         0===" }
  double2 var1 = (double2) (123455.134,123455.134);
  double2 var2 = (double2) (-1.23,0.0);
  int i = printf("double2_g_4126c===% 10.2v2lG===% 10.2v2lG===\n",var1,var2);
  return i;
}

int double2_g_4127c() {
  // { dg-printf "double2_g_4127c===     -1.23, -1.23E+04===         2,  1.23E+05===" }
  double2 var1 = (double2) (-1.23,-12345.032);
  double2 var2 = (double2) (2.0,123455.134);
  int i = printf("double2_g_4127c===% 10.3v2lG===% 10.3v2lG===\n",var1,var2);
  return i;
}

int double2_g_4128c() {
  // { dg-printf "double2_g_4128c===         1,         0=== 123455.134,         2===" }
  double2 var1 = (double2) (1.0,0.0);
  double2 var2 = (double2) (123455.134,2.0);
  int i = printf("double2_g_4128c===% 10.10v2lG===% 10.10v2lG===\n",var1,var2);
  return i;
}

int double2_g_4879c() {
  // { dg-printf "double2_g_4879c===0000123455,0000000002===0000123455,0000000001===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (123455.134,1.0);
  int i = printf("double2_g_4879c===%010v2lg===%010v2lg===\n",var1,var2);
  return i;
}

int double2_g_4880c() {
  // { dg-printf "double2_g_4880c===0000000001,0000000002===-000000001,-00001e+04===" }
  double2 var1 = (double2) (1.0,2.0);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_g_4880c===%010.1v2lg===%010.1v2lg===\n",var1,var2);
  return i;
}

int double2_g_4881c() {
  // { dg-printf "double2_g_4881c===0000000001,0001.2e+05===-001.2e+04,0000000000===" }
  double2 var1 = (double2) (1.0,123455.134);
  double2 var2 = (double2) (-12345.032,0.0);
  int i = printf("double2_g_4881c===%010.2v2lg===%010.2v2lg===\n",var1,var2);
  return i;
}

int double2_g_4882c() {
  // { dg-printf "double2_g_4882c===-000001.23,001.23e+05===-000001.23,-000001.23===" }
  double2 var1 = (double2) (-1.23,123455.134);
  double2 var2 = (double2) (-1.23,-1.23);
  int i = printf("double2_g_4882c===%010.3v2lg===%010.3v2lg===\n",var1,var2);
  return i;
}

int double2_g_4883c() {
  // { dg-printf "double2_g_4883c===-12345.032,0000000002===0000000000,-000001.23===" }
  double2 var1 = (double2) (-12345.032,2.0);
  double2 var2 = (double2) (0.0,-1.23);
  int i = printf("double2_g_4883c===%010.10v2lg===%010.10v2lg===\n",var1,var2);
  return i;
}

int double2_g_4884c() {
  // { dg-printf "double2_g_4884c===0000123455,0000000000===-000001.23,0000000000===" }
  double2 var1 = (double2) (123455.134,0.0);
  double2 var2 = (double2) (-1.23,0.0);
  int i = printf("double2_g_4884c===%010v2lG===%010v2lG===\n",var1,var2);
  return i;
}

int double2_g_4885c() {
  // { dg-printf "double2_g_4885c===0000000001,0000000001===0000000002,0000000001===" }
  double2 var1 = (double2) (1.0,1.0);
  double2 var2 = (double2) (2.0,1.0);
  int i = printf("double2_g_4885c===%010.1v2lG===%010.1v2lG===\n",var1,var2);
  return i;
}

int double2_g_4886c() {
  // { dg-printf "double2_g_4886c===0000000000,0000000002===-0000001.2,0000000001===" }
  double2 var1 = (double2) (0.0,2.0);
  double2 var2 = (double2) (-1.23,1.0);
  int i = printf("double2_g_4886c===%010.2v2lG===%010.2v2lG===\n",var1,var2);
  return i;
}

int double2_g_4887c() {
  // { dg-printf "double2_g_4887c===0000000000,0000000001===0000000001,-01.23E+04===" }
  double2 var1 = (double2) (0.0,1.0);
  double2 var2 = (double2) (1.0,-12345.032);
  int i = printf("double2_g_4887c===%010.3v2lG===%010.3v2lG===\n",var1,var2);
  return i;
}

int double2_g_4888c() {
  // { dg-printf "double2_g_4888c===-12345.032,0000000000===123455.134,0000000000===" }
  double2 var1 = (double2) (-12345.032,0.0);
  double2 var2 = (double2) (123455.134,0.0);
  int i = printf("double2_g_4888c===%010.10v2lG===%010.10v2lG===\n",var1,var2);
  return i;
}

int double2_g_5639c() {
  // { dg-printf "double2_g_5639c=== 0        , 0        ===-1.23     ,-12345    ===" }
  double2 var1 = (double2) (0.0,0.0);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_g_5639c===%- 10v2lg===%- 10v2lg===\n",var1,var2);
  return i;
}

int double2_g_5640c() {
  // { dg-printf "double2_g_5640c=== 1e+05    ,-1e+04    === 2        ,-1e+04    ===" }
  double2 var1 = (double2) (123455.134,-12345.032);
  double2 var2 = (double2) (2.0,-12345.032);
  int i = printf("double2_g_5640c===%- 10.1v2lg===%- 10.1v2lg===\n",var1,var2);
  return i;
}

int double2_g_5641c() {
  // { dg-printf "double2_g_5641c=== 1.2e+05  ,-1.2e+04  === 1        , 2        ===" }
  double2 var1 = (double2) (123455.134,-12345.032);
  double2 var2 = (double2) (1.0,2.0);
  int i = printf("double2_g_5641c===%- 10.2v2lg===%- 10.2v2lg===\n",var1,var2);
  return i;
}

int double2_g_5642c() {
  // { dg-printf "double2_g_5642c=== 1.23e+05 , 1.23e+05 === 1        , 1        ===" }
  double2 var1 = (double2) (123455.134,123455.134);
  double2 var2 = (double2) (1.0,1.0);
  int i = printf("double2_g_5642c===%- 10.3v2lg===%- 10.3v2lg===\n",var1,var2);
  return i;
}

int double2_g_5643c() {
  // { dg-printf "double2_g_5643c=== 2        , 1        ===-1.23     , 1        ===" }
  double2 var1 = (double2) (2.0,1.0);
  double2 var2 = (double2) (-1.23,1.0);
  int i = printf("double2_g_5643c===%- 10.10v2lg===%- 10.10v2lg===\n",var1,var2);
  return i;
}

int double2_g_5644c() {
  // { dg-printf "double2_g_5644c=== 123455   , 1        ===-12345    ,-12345    ===" }
  double2 var1 = (double2) (123455.134,1.0);
  double2 var2 = (double2) (-12345.032,-12345.032);
  int i = printf("double2_g_5644c===%- 10v2lG===%- 10v2lG===\n",var1,var2);
  return i;
}

int double2_g_5645c() {
  // { dg-printf "double2_g_5645c=== 0        ,-1E+04    ===-1E+04    , 0        ===" }
  double2 var1 = (double2) (0.0,-12345.032);
  double2 var2 = (double2) (-12345.032,0.0);
  int i = printf("double2_g_5645c===%- 10.1v2lG===%- 10.1v2lG===\n",var1,var2);
  return i;
}

int double2_g_5646c() {
  // { dg-printf "double2_g_5646c=== 2        , 1.2E+05  ===-1.2      ,-1.2E+04  ===" }
  double2 var1 = (double2) (2.0,123455.134);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_g_5646c===%- 10.2v2lG===%- 10.2v2lG===\n",var1,var2);
  return i;
}

int double2_g_5647c() {
  // { dg-printf "double2_g_5647c=== 1        , 0        === 2        ,-1.23E+04 ===" }
  double2 var1 = (double2) (1.0,0.0);
  double2 var2 = (double2) (2.0,-12345.032);
  int i = printf("double2_g_5647c===%- 10.3v2lG===%- 10.3v2lG===\n",var1,var2);
  return i;
}

int double2_g_5648c() {
  // { dg-printf "double2_g_5648c=== 1        ,-12345.032=== 2        , 2        ===" }
  double2 var1 = (double2) (1.0,-12345.032);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_g_5648c===%- 10.10v2lG===%- 10.10v2lG===\n",var1,var2);
  return i;
}

int double2_g_6399c() {
  // { dg-printf "double2_g_6399c===        +2,        +0===        +1,        +0===" }
  double2 var1 = (double2) (2.0,0.0);
  double2 var2 = (double2) (1.0,0.0);
  int i = printf("double2_g_6399c===%+ 10v2lg===%+ 10v2lg===\n",var1,var2);
  return i;
}

int double2_g_6400c() {
  // { dg-printf "double2_g_6400c===        +2,        +2===        +2,        +2===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_g_6400c===%+ 10.1v2lg===%+ 10.1v2lg===\n",var1,var2);
  return i;
}

int double2_g_6401c() {
  // { dg-printf "double2_g_6401c===  +1.2e+05,  -1.2e+04===        +2,      -1.2===" }
  double2 var1 = (double2) (123455.134,-12345.032);
  double2 var2 = (double2) (2.0,-1.23);
  int i = printf("double2_g_6401c===%+ 10.2v2lg===%+ 10.2v2lg===\n",var1,var2);
  return i;
}

int double2_g_6402c() {
  // { dg-printf "double2_g_6402c=== +1.23e+05,        +2=== -1.23e+04,        +1===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (-12345.032,1.0);
  int i = printf("double2_g_6402c===%+ 10.3v2lg===%+ 10.3v2lg===\n",var1,var2);
  return i;
}

int double2_g_6403c() {
  // { dg-printf "double2_g_6403c===        +0,        +1===        +0,-12345.032===" }
  double2 var1 = (double2) (0.0,1.0);
  double2 var2 = (double2) (0.0,-12345.032);
  int i = printf("double2_g_6403c===%+ 10.10v2lg===%+ 10.10v2lg===\n",var1,var2);
  return i;
}

int double2_g_6404c() {
  // { dg-printf "double2_g_6404c===   +123455,        +2===   +123455,        +1===" }
  double2 var1 = (double2) (123455.134,2.0);
  double2 var2 = (double2) (123455.134,1.0);
  int i = printf("double2_g_6404c===%+ 10v2lG===%+ 10v2lG===\n",var1,var2);
  return i;
}

int double2_g_6405c() {
  // { dg-printf "double2_g_6405c===        +1,        +2===    +1E+05,    +1E+05===" }
  double2 var1 = (double2) (1.0,2.0);
  double2 var2 = (double2) (123455.134,123455.134);
  int i = printf("double2_g_6405c===%+ 10.1v2lG===%+ 10.1v2lG===\n",var1,var2);
  return i;
}

int double2_g_6406c() {
  // { dg-printf "double2_g_6406c===        +2,      -1.2===  -1.2E+04,        +2===" }
  double2 var1 = (double2) (2.0,-1.23);
  double2 var2 = (double2) (-12345.032,2.0);
  int i = printf("double2_g_6406c===%+ 10.2v2lG===%+ 10.2v2lG===\n",var1,var2);
  return i;
}

int double2_g_6407c() {
  // { dg-printf "double2_g_6407c=== -1.23E+04,        +1===        +2,        +2===" }
  double2 var1 = (double2) (-12345.032,1.0);
  double2 var2 = (double2) (2.0,2.0);
  int i = printf("double2_g_6407c===%+ 10.3v2lG===%+ 10.3v2lG===\n",var1,var2);
  return i;
}

int double2_g_6408c() {
  // { dg-printf "double2_g_6408c===        +0,        +2===-12345.032,+123455.134===" }
  double2 var1 = (double2) (0.0,2.0);
  double2 var2 = (double2) (-12345.032,123455.134);
  int i = printf("double2_g_6408c===%+ 10.10v2lG===%+ 10.10v2lG===\n",var1,var2);
  return i;
}

int double2_g_7159c() {
  // { dg-printf "double2_g_7159c===+000000001,+000000000===+000123455,-000001.23===" }
  double2 var1 = (double2) (1.0,0.0);
  double2 var2 = (double2) (123455.134,-1.23);
  int i = printf("double2_g_7159c===%+010v2lg===%+010v2lg===\n",var1,var2);
  return i;
}

int double2_g_7160c() {
  // { dg-printf "double2_g_7160c===-00001e+04,-000000001===-000000001,-00001e+04===" }
  double2 var1 = (double2) (-12345.032,-1.23);
  double2 var2 = (double2) (-1.23,-12345.032);
  int i = printf("double2_g_7160c===%+010.1v2lg===%+010.1v2lg===\n",var1,var2);
  return i;
}

int double2_g_7161c() {
  // { dg-printf "double2_g_7161c===-001.2e+04,+000000001===+000000001,+000000000===" }
  double2 var1 = (double2) (-12345.032,1.0);
  double2 var2 = (double2) (1.0,0.0);
  int i = printf("double2_g_7161c===%+010.2v2lg===%+010.2v2lg===\n",var1,var2);
  return i;
}

int double2_g_7162c() {
  // { dg-printf "double2_g_7162c===+01.23e+05,-01.23e+04===-000001.23,+000000000===" }
  double2 var1 = (double2) (123455.134,-12345.032);
  double2 var2 = (double2) (-1.23,0.0);
  int i = printf("double2_g_7162c===%+010.3v2lg===%+010.3v2lg===\n",var1,var2);
  return i;
}

int double2_g_7163c() {
  // { dg-printf "double2_g_7163c===-000001.23,+123455.134===+000000000,-000001.23===" }
  double2 var1 = (double2) (-1.23,123455.134);
  double2 var2 = (double2) (0.0,-1.23);
  int i = printf("double2_g_7163c===%+010.10v2lg===%+010.10v2lg===\n",var1,var2);
  return i;
}

int double2_g_7164c() {
  // { dg-printf "double2_g_7164c===+000000002,+000000002===+000000001,-000001.23===" }
  double2 var1 = (double2) (2.0,2.0);
  double2 var2 = (double2) (1.0,-1.23);
  int i = printf("double2_g_7164c===%+010v2lG===%+010v2lG===\n",var1,var2);
  return i;
}

int double2_g_7165c() {
  // { dg-printf "double2_g_7165c===+00001E+05,+00001E+05===+00001E+05,+000000000===" }
  double2 var1 = (double2) (123455.134,123455.134);
  double2 var2 = (double2) (123455.134,0.0);
  int i = printf("double2_g_7165c===%+010.1v2lG===%+010.1v2lG===\n",var1,var2);
  return i;
}

int double2_g_7166c() {
  // { dg-printf "double2_g_7166c===-0000001.2,+001.2E+05===+000000002,+000000001===" }
  double2 var1 = (double2) (-1.23,123455.134);
  double2 var2 = (double2) (2.0,1.0);
  int i = printf("double2_g_7166c===%+010.2v2lG===%+010.2v2lG===\n",var1,var2);
  return i;
}

int double2_g_7167c() {
  // { dg-printf "double2_g_7167c===+000000002,-000001.23===+000000000,+000000000===" }
  double2 var1 = (double2) (2.0,-1.23);
  double2 var2 = (double2) (0.0,0.0);
  int i = printf("double2_g_7167c===%+010.3v2lG===%+010.3v2lG===\n",var1,var2);
  return i;
}

int double2_g_7168c() {
  // { dg-printf "double2_g_7168c===+000000001,+123455.134===+000000000,+000000001===" }
  double2 var1 = (double2) (1.0,123455.134);
  double2 var2 = (double2) (0.0,1.0);
  int i = printf("double2_g_7168c===%+010.10v2lG===%+010.10v2lG===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = double2_a_1049c();
i = double2_a_1050c();
i = double2_a_1051c();
i = double2_a_1052c();
i = double2_a_1053c();
i = double2_a_1054c();
i = double2_a_1055c();
i = double2_a_1056c();
i = double2_a_1057c();
i = double2_a_1058c();
i = double2_a_1809c();
i = double2_a_1810c();
i = double2_a_1811c();
i = double2_a_1812c();
i = double2_a_1813c();
i = double2_a_1814c();
i = double2_a_1815c();
i = double2_a_1816c();
i = double2_a_1817c();
i = double2_a_1818c();
i = double2_a_2569c();
i = double2_a_2570c();
i = double2_a_2571c();
i = double2_a_2572c();
i = double2_a_2573c();
i = double2_a_2574c();
i = double2_a_2575c();
i = double2_a_2576c();
i = double2_a_2577c();
i = double2_a_2578c();
i = double2_a_289c();
i = double2_a_290c();
i = double2_a_291c();
i = double2_a_292c();
i = double2_a_293c();
i = double2_a_294c();
i = double2_a_295c();
i = double2_a_296c();
i = double2_a_297c();
i = double2_a_298c();
i = double2_a_3329c();
i = double2_a_3330c();
i = double2_a_3331c();
i = double2_a_3332c();
i = double2_a_3333c();
i = double2_a_3334c();
i = double2_a_3335c();
i = double2_a_3336c();
i = double2_a_3337c();
i = double2_a_3338c();
i = double2_a_4089c();
i = double2_a_4090c();
i = double2_a_4091c();
i = double2_a_4092c();
i = double2_a_4093c();
i = double2_a_4094c();
i = double2_a_4095c();
i = double2_a_4096c();
i = double2_a_4097c();
i = double2_a_4098c();
i = double2_a_4849c();
i = double2_a_4850c();
i = double2_a_4851c();
i = double2_a_4852c();
i = double2_a_4853c();
i = double2_a_4854c();
i = double2_a_4855c();
i = double2_a_4856c();
i = double2_a_4857c();
i = double2_a_4858c();
i = double2_a_5609c();
i = double2_a_5610c();
i = double2_a_5611c();
i = double2_a_5612c();
i = double2_a_5613c();
i = double2_a_5614c();
i = double2_a_5615c();
i = double2_a_5616c();
i = double2_a_5617c();
i = double2_a_5618c();
i = double2_a_6369c();
i = double2_a_6370c();
i = double2_a_6371c();
i = double2_a_6372c();
i = double2_a_6373c();
i = double2_a_6374c();
i = double2_a_6375c();
i = double2_a_6376c();
i = double2_a_6377c();
i = double2_a_6378c();
i = double2_a_7129c();
i = double2_a_7130c();
i = double2_a_7131c();
i = double2_a_7132c();
i = double2_a_7133c();
i = double2_a_7134c();
i = double2_a_7135c();
i = double2_a_7136c();
i = double2_a_7137c();
i = double2_a_7138c();
i = double2_e_1059c();
i = double2_e_1060c();
i = double2_e_1061c();
i = double2_e_1062c();
i = double2_e_1063c();
i = double2_e_1064c();
i = double2_e_1065c();
i = double2_e_1066c();
i = double2_e_1067c();
i = double2_e_1068c();
i = double2_e_1819c();
i = double2_e_1820c();
i = double2_e_1821c();
i = double2_e_1822c();
i = double2_e_1823c();
i = double2_e_1824c();
i = double2_e_1825c();
i = double2_e_1826c();
i = double2_e_1827c();
i = double2_e_1828c();
i = double2_e_2579c();
i = double2_e_2580c();
i = double2_e_2581c();
i = double2_e_2582c();
i = double2_e_2583c();
i = double2_e_2584c();
i = double2_e_2585c();
i = double2_e_2586c();
i = double2_e_2587c();
i = double2_e_2588c();
i = double2_e_299c();
i = double2_e_300c();
i = double2_e_301c();
i = double2_e_302c();
i = double2_e_303c();
i = double2_e_304c();
i = double2_e_305c();
i = double2_e_306c();
i = double2_e_307c();
i = double2_e_308c();
i = double2_e_3339c();
i = double2_e_3340c();
i = double2_e_3341c();
i = double2_e_3342c();
i = double2_e_3343c();
i = double2_e_3344c();
i = double2_e_3345c();
i = double2_e_3346c();
i = double2_e_3347c();
i = double2_e_3348c();
i = double2_e_4099c();
i = double2_e_4100c();
i = double2_e_4101c();
i = double2_e_4102c();
i = double2_e_4103c();
i = double2_e_4104c();
i = double2_e_4105c();
i = double2_e_4106c();
i = double2_e_4107c();
i = double2_e_4108c();
i = double2_e_4859c();
i = double2_e_4860c();
i = double2_e_4861c();
i = double2_e_4862c();
i = double2_e_4863c();
i = double2_e_4864c();
i = double2_e_4865c();
i = double2_e_4866c();
i = double2_e_4867c();
i = double2_e_4868c();
i = double2_e_5619c();
i = double2_e_5620c();
i = double2_e_5621c();
i = double2_e_5622c();
i = double2_e_5623c();
i = double2_e_5624c();
i = double2_e_5625c();
i = double2_e_5626c();
i = double2_e_5627c();
i = double2_e_5628c();
i = double2_e_6379c();
i = double2_e_6380c();
i = double2_e_6381c();
i = double2_e_6382c();
i = double2_e_6383c();
i = double2_e_6384c();
i = double2_e_6385c();
i = double2_e_6386c();
i = double2_e_6387c();
i = double2_e_6388c();
i = double2_e_7139c();
i = double2_e_7140c();
i = double2_e_7141c();
i = double2_e_7142c();
i = double2_e_7143c();
i = double2_e_7144c();
i = double2_e_7145c();
i = double2_e_7146c();
i = double2_e_7147c();
i = double2_e_7148c();
i = double2_f_1069c();
i = double2_f_1070c();
i = double2_f_1071c();
i = double2_f_1072c();
i = double2_f_1073c();
i = double2_f_1074c();
i = double2_f_1075c();
i = double2_f_1076c();
i = double2_f_1077c();
i = double2_f_1078c();
i = double2_f_1829c();
i = double2_f_1830c();
i = double2_f_1831c();
i = double2_f_1832c();
i = double2_f_1833c();
i = double2_f_1834c();
i = double2_f_1835c();
i = double2_f_1836c();
i = double2_f_1837c();
i = double2_f_1838c();
i = double2_f_2589c();
i = double2_f_2590c();
i = double2_f_2591c();
i = double2_f_2592c();
i = double2_f_2593c();
i = double2_f_2594c();
i = double2_f_2595c();
i = double2_f_2596c();
i = double2_f_2597c();
i = double2_f_2598c();
i = double2_f_309c();
i = double2_f_310c();
i = double2_f_311c();
i = double2_f_312c();
i = double2_f_313c();
i = double2_f_314c();
i = double2_f_315c();
i = double2_f_316c();
i = double2_f_317c();
i = double2_f_318c();
i = double2_f_3349c();
i = double2_f_3350c();
i = double2_f_3351c();
i = double2_f_3352c();
i = double2_f_3353c();
i = double2_f_3354c();
i = double2_f_3355c();
i = double2_f_3356c();
i = double2_f_3357c();
i = double2_f_3358c();
i = double2_f_4109c();
i = double2_f_4110c();
i = double2_f_4111c();
i = double2_f_4112c();
i = double2_f_4113c();
i = double2_f_4114c();
i = double2_f_4115c();
i = double2_f_4116c();
i = double2_f_4117c();
i = double2_f_4118c();
i = double2_f_4869c();
i = double2_f_4870c();
i = double2_f_4871c();
i = double2_f_4872c();
i = double2_f_4873c();
i = double2_f_4874c();
i = double2_f_4875c();
i = double2_f_4876c();
i = double2_f_4877c();
i = double2_f_4878c();
i = double2_f_5629c();
i = double2_f_5630c();
i = double2_f_5631c();
i = double2_f_5632c();
i = double2_f_5633c();
i = double2_f_5634c();
i = double2_f_5635c();
i = double2_f_5636c();
i = double2_f_5637c();
i = double2_f_5638c();
i = double2_f_6389c();
i = double2_f_6390c();
i = double2_f_6391c();
i = double2_f_6392c();
i = double2_f_6393c();
i = double2_f_6394c();
i = double2_f_6395c();
i = double2_f_6396c();
i = double2_f_6397c();
i = double2_f_6398c();
i = double2_f_7149c();
i = double2_f_7150c();
i = double2_f_7151c();
i = double2_f_7152c();
i = double2_f_7153c();
i = double2_f_7154c();
i = double2_f_7155c();
i = double2_f_7156c();
i = double2_f_7157c();
i = double2_f_7158c();
i = double2_g_1079c();
i = double2_g_1080c();
i = double2_g_1081c();
i = double2_g_1082c();
i = double2_g_1083c();
i = double2_g_1084c();
i = double2_g_1085c();
i = double2_g_1086c();
i = double2_g_1087c();
i = double2_g_1088c();
i = double2_g_1839c();
i = double2_g_1840c();
i = double2_g_1841c();
i = double2_g_1842c();
i = double2_g_1843c();
i = double2_g_1844c();
i = double2_g_1845c();
i = double2_g_1846c();
i = double2_g_1847c();
i = double2_g_1848c();
i = double2_g_2599c();
i = double2_g_2600c();
i = double2_g_2601c();
i = double2_g_2602c();
i = double2_g_2603c();
i = double2_g_2604c();
i = double2_g_2605c();
i = double2_g_2606c();
i = double2_g_2607c();
i = double2_g_2608c();
i = double2_g_319c();
i = double2_g_320c();
i = double2_g_321c();
i = double2_g_322c();
i = double2_g_323c();
i = double2_g_324c();
i = double2_g_325c();
i = double2_g_326c();
i = double2_g_327c();
i = double2_g_328c();
i = double2_g_3359c();
i = double2_g_3360c();
i = double2_g_3361c();
i = double2_g_3362c();
i = double2_g_3363c();
i = double2_g_3364c();
i = double2_g_3365c();
i = double2_g_3366c();
i = double2_g_3367c();
i = double2_g_3368c();
i = double2_g_4119c();
i = double2_g_4120c();
i = double2_g_4121c();
i = double2_g_4122c();
i = double2_g_4123c();
i = double2_g_4124c();
i = double2_g_4125c();
i = double2_g_4126c();
i = double2_g_4127c();
i = double2_g_4128c();
i = double2_g_4879c();
i = double2_g_4880c();
i = double2_g_4881c();
i = double2_g_4882c();
i = double2_g_4883c();
i = double2_g_4884c();
i = double2_g_4885c();
i = double2_g_4886c();
i = double2_g_4887c();
i = double2_g_4888c();
i = double2_g_5639c();
i = double2_g_5640c();
i = double2_g_5641c();
i = double2_g_5642c();
i = double2_g_5643c();
i = double2_g_5644c();
i = double2_g_5645c();
i = double2_g_5646c();
i = double2_g_5647c();
i = double2_g_5648c();
i = double2_g_6399c();
i = double2_g_6400c();
i = double2_g_6401c();
i = double2_g_6402c();
i = double2_g_6403c();
i = double2_g_6404c();
i = double2_g_6405c();
i = double2_g_6406c();
i = double2_g_6407c();
i = double2_g_6408c();
i = double2_g_7159c();
i = double2_g_7160c();
i = double2_g_7161c();
i = double2_g_7162c();
i = double2_g_7163c();
i = double2_g_7164c();
i = double2_g_7165c();
i = double2_g_7166c();
i = double2_g_7167c();
i = double2_g_7168c();
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
