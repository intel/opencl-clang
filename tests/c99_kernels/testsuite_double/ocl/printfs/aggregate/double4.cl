/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/double4.c'  */

int double4_a_1193c() {
  // { dg-printf "double4_a_1193c===0x1.0000000000000p+1,0x1.e23f224dd2f1bp+16,0x1.0000000000000p+1,0x1.0000000000000p+1===0x0.0000000000000p+0,0x0.0000000000000p+0,0x0.0000000000000p+0,0x1.0000000000000p+1===" }
  double4 var1 = (double4) (2.0,123455.134,2.0,2.0);
  double4 var2 = (double4) (0.0,0.0,0.0,2.0);
  int i = printf("double4_a_1193c===%-v4la===%-v4la===\n",var1,var2);
  return i;
}

int double4_a_1194c() {
  // { dg-printf "double4_a_1194c===-0x1.8p+13,0x1.0p+0,-0x1.4p+0,0x1.ep+16===-0x1.4p+0,-0x1.8p+13,-0x1.4p+0,0x0.0p+0===" }
  double4 var1 = (double4) (-12345.032,1.0,-1.23,123455.134);
  double4 var2 = (double4) (-1.23,-12345.032,-1.23,0.0);
  int i = printf("double4_a_1194c===%-.1v4la===%-.1v4la===\n",var1,var2);
  return i;
}

int double4_a_1195c() {
  // { dg-printf "double4_a_1195c===0x1.00p+1,-0x1.82p+13,-0x1.3bp+0,0x0.00p+0===0x1.e2p+16,0x0.00p+0,0x1.e2p+16,0x1.e2p+16===" }
  double4 var1 = (double4) (2.0,-12345.032,-1.23,0.0);
  double4 var2 = (double4) (123455.134,0.0,123455.134,123455.134);
  int i = printf("double4_a_1195c===%-.2v4la===%-.2v4la===\n",var1,var2);
  return i;
}

int double4_a_1196c() {
  // { dg-printf "double4_a_1196c===0x0.000p+0,-0x1.81cp+13,0x0.000p+0,0x1.e24p+16===-0x1.81cp+13,0x1.e24p+16,-0x1.3aep+0,-0x1.81cp+13===" }
  double4 var1 = (double4) (0.0,-12345.032,0.0,123455.134);
  double4 var2 = (double4) (-12345.032,123455.134,-1.23,-12345.032);
  int i = printf("double4_a_1196c===%-.3v4la===%-.3v4la===\n",var1,var2);
  return i;
}

int double4_a_1197c() {
  // { dg-printf "double4_a_1197c===-0x1.81c8418937p+13,-0x1.3ae147ae14p+0,0x0.0000000000p+0,0x1.0000000000p+1===0x1.e23f224dd3p+16,-0x1.81c8418937p+13,0x1.0000000000p+1,-0x1.81c8418937p+13===" }
  double4 var1 = (double4) (-12345.032,-1.23,0.0,2.0);
  double4 var2 = (double4) (123455.134,-12345.032,2.0,-12345.032);
  int i = printf("double4_a_1197c===%-.10v4la===%-.10v4la===\n",var1,var2);
  return i;
}

int double4_a_1198c() {
  // { dg-printf "double4_a_1198c===0X1.0000000000000P+0,0X0.0000000000000P+0,0X1.0000000000000P+1,0X0.0000000000000P+0===0X1.E23F224DD2F1BP+16,0X1.0000000000000P+1,-0X1.81C84189374BCP+13,-0X1.81C84189374BCP+13===" }
  double4 var1 = (double4) (1.0,0.0,2.0,0.0);
  double4 var2 = (double4) (123455.134,2.0,-12345.032,-12345.032);
  int i = printf("double4_a_1198c===%-v4lA===%-v4lA===\n",var1,var2);
  return i;
}

int double4_a_1199c() {
  // { dg-printf "double4_a_1199c===-0X1.8P+13,0X0.0P+0,-0X1.4P+0,0X0.0P+0===-0X1.8P+13,0X0.0P+0,0X1.0P+0,0X1.0P+0===" }
  double4 var1 = (double4) (-12345.032,0.0,-1.23,0.0);
  double4 var2 = (double4) (-12345.032,0.0,1.0,1.0);
  int i = printf("double4_a_1199c===%-.1v4lA===%-.1v4lA===\n",var1,var2);
  return i;
}

int double4_a_1200c() {
  // { dg-printf "double4_a_1200c===-0X1.82P+13,-0X1.3BP+0,0X0.00P+0,0X1.00P+0===-0X1.82P+13,-0X1.3BP+0,-0X1.82P+13,0X0.00P+0===" }
  double4 var1 = (double4) (-12345.032,-1.23,0.0,1.0);
  double4 var2 = (double4) (-12345.032,-1.23,-12345.032,0.0);
  int i = printf("double4_a_1200c===%-.2v4lA===%-.2v4lA===\n",var1,var2);
  return i;
}

int double4_a_1201c() {
  // { dg-printf "double4_a_1201c===0X1.000P+1,0X1.000P+1,-0X1.81CP+13,0X0.000P+0===-0X1.81CP+13,0X1.000P+1,-0X1.3AEP+0,0X1.000P+1===" }
  double4 var1 = (double4) (2.0,2.0,-12345.032,0.0);
  double4 var2 = (double4) (-12345.032,2.0,-1.23,2.0);
  int i = printf("double4_a_1201c===%-.3v4lA===%-.3v4lA===\n",var1,var2);
  return i;
}

int double4_a_1202c() {
  // { dg-printf "double4_a_1202c===-0X1.3AE147AE14P+0,0X1.0000000000P+1,0X1.E23F224DD3P+16,-0X1.3AE147AE14P+0===0X1.0000000000P+0,-0X1.3AE147AE14P+0,0X1.E23F224DD3P+16,-0X1.3AE147AE14P+0===" }
  double4 var1 = (double4) (-1.23,2.0,123455.134,-1.23);
  double4 var2 = (double4) (1.0,-1.23,123455.134,-1.23);
  int i = printf("double4_a_1202c===%-.10v4lA===%-.10v4lA===\n",var1,var2);
  return i;
}

int double4_a_1953c() {
  // { dg-printf "double4_a_1953c===+0x1.0000000000000p+0,-0x1.3ae147ae147aep+0,+0x1.e23f224dd2f1bp+16,-0x1.81c84189374bcp+13===+0x1.e23f224dd2f1bp+16,-0x1.3ae147ae147aep+0,+0x1.0000000000000p+1,-0x1.81c84189374bcp+13===" }
  double4 var1 = (double4) (1.0,-1.23,123455.134,-12345.032);
  double4 var2 = (double4) (123455.134,-1.23,2.0,-12345.032);
  int i = printf("double4_a_1953c===%+v4la===%+v4la===\n",var1,var2);
  return i;
}

int double4_a_1954c() {
  // { dg-printf "double4_a_1954c===-0x1.4p+0,+0x1.0p+0,+0x1.0p+1,-0x1.8p+13===+0x0.0p+0,-0x1.8p+13,+0x1.0p+1,+0x1.ep+16===" }
  double4 var1 = (double4) (-1.23,1.0,2.0,-12345.032);
  double4 var2 = (double4) (0.0,-12345.032,2.0,123455.134);
  int i = printf("double4_a_1954c===%+.1v4la===%+.1v4la===\n",var1,var2);
  return i;
}

int double4_a_1955c() {
  // { dg-printf "double4_a_1955c===+0x1.00p+0,+0x1.e2p+16,+0x1.00p+0,+0x1.00p+1===-0x1.82p+13,+0x1.e2p+16,+0x1.e2p+16,-0x1.82p+13===" }
  double4 var1 = (double4) (1.0,123455.134,1.0,2.0);
  double4 var2 = (double4) (-12345.032,123455.134,123455.134,-12345.032);
  int i = printf("double4_a_1955c===%+.2v4la===%+.2v4la===\n",var1,var2);
  return i;
}

int double4_a_1956c() {
  // { dg-printf "double4_a_1956c===-0x1.3aep+0,+0x1.000p+1,+0x1.000p+0,+0x1.e24p+16===-0x1.81cp+13,+0x1.000p+1,+0x1.e24p+16,-0x1.3aep+0===" }
  double4 var1 = (double4) (-1.23,2.0,1.0,123455.134);
  double4 var2 = (double4) (-12345.032,2.0,123455.134,-1.23);
  int i = printf("double4_a_1956c===%+.3v4la===%+.3v4la===\n",var1,var2);
  return i;
}

int double4_a_1957c() {
  // { dg-printf "double4_a_1957c===-0x1.81c8418937p+13,-0x1.81c8418937p+13,+0x1.e23f224dd3p+16,+0x1.0000000000p+0===+0x1.e23f224dd3p+16,+0x0.0000000000p+0,+0x1.e23f224dd3p+16,-0x1.3ae147ae14p+0===" }
  double4 var1 = (double4) (-12345.032,-12345.032,123455.134,1.0);
  double4 var2 = (double4) (123455.134,0.0,123455.134,-1.23);
  int i = printf("double4_a_1957c===%+.10v4la===%+.10v4la===\n",var1,var2);
  return i;
}

int double4_a_1958c() {
  // { dg-printf "double4_a_1958c===+0X1.0000000000000P+1,+0X1.0000000000000P+1,+0X1.0000000000000P+1,-0X1.81C84189374BCP+13===+0X0.0000000000000P+0,+0X1.0000000000000P+1,+0X0.0000000000000P+0,-0X1.81C84189374BCP+13===" }
  double4 var1 = (double4) (2.0,2.0,2.0,-12345.032);
  double4 var2 = (double4) (0.0,2.0,0.0,-12345.032);
  int i = printf("double4_a_1958c===%+v4lA===%+v4lA===\n",var1,var2);
  return i;
}

int double4_a_1959c() {
  // { dg-printf "double4_a_1959c===+0X1.0P+0,+0X1.0P+0,+0X1.0P+1,+0X0.0P+0===+0X1.EP+16,-0X1.8P+13,+0X1.0P+0,+0X1.0P+0===" }
  double4 var1 = (double4) (1.0,1.0,2.0,0.0);
  double4 var2 = (double4) (123455.134,-12345.032,1.0,1.0);
  int i = printf("double4_a_1959c===%+.1v4lA===%+.1v4lA===\n",var1,var2);
  return i;
}

int double4_a_1960c() {
  // { dg-printf "double4_a_1960c===+0X1.00P+1,+0X1.00P+0,-0X1.3BP+0,-0X1.3BP+0===+0X0.00P+0,+0X1.00P+1,+0X1.E2P+16,+0X1.00P+1===" }
  double4 var1 = (double4) (2.0,1.0,-1.23,-1.23);
  double4 var2 = (double4) (0.0,2.0,123455.134,2.0);
  int i = printf("double4_a_1960c===%+.2v4lA===%+.2v4lA===\n",var1,var2);
  return i;
}

int double4_a_1961c() {
  // { dg-printf "double4_a_1961c===+0X1.E24P+16,+0X0.000P+0,-0X1.3AEP+0,+0X1.000P+0===+0X1.000P+0,+0X0.000P+0,+0X1.000P+0,-0X1.3AEP+0===" }
  double4 var1 = (double4) (123455.134,0.0,-1.23,1.0);
  double4 var2 = (double4) (1.0,0.0,1.0,-1.23);
  int i = printf("double4_a_1961c===%+.3v4lA===%+.3v4lA===\n",var1,var2);
  return i;
}

int double4_a_1962c() {
  // { dg-printf "double4_a_1962c===-0X1.81C8418937P+13,+0X1.0000000000P+0,+0X1.0000000000P+1,+0X0.0000000000P+0===-0X1.81C8418937P+13,-0X1.81C8418937P+13,+0X1.0000000000P+1,-0X1.81C8418937P+13===" }
  double4 var1 = (double4) (-12345.032,1.0,2.0,0.0);
  double4 var2 = (double4) (-12345.032,-12345.032,2.0,-12345.032);
  int i = printf("double4_a_1962c===%+.10v4lA===%+.10v4lA===\n",var1,var2);
  return i;
}

int double4_a_2713c() {
  // { dg-printf "double4_a_2713c===0x0.0000000000000p+0,0x0.0000000000000p+0,-0x1.3ae147ae147aep+0,0x0.0000000000000p+0===0x1.0000000000000p+1,0x1.e23f224dd2f1bp+16,-0x1.81c84189374bcp+13,-0x1.3ae147ae147aep+0===" }
  double4 var1 = (double4) (0.0,0.0,-1.23,0.0);
  double4 var2 = (double4) (2.0,123455.134,-12345.032,-1.23);
  int i = printf("double4_a_2713c===%#v4la===%#v4la===\n",var1,var2);
  return i;
}

int double4_a_2714c() {
  // { dg-printf "double4_a_2714c===-0x1.4p+0,0x0.0p+0,-0x1.8p+13,-0x1.8p+13===0x1.ep+16,-0x1.4p+0,0x1.ep+16,0x1.ep+16===" }
  double4 var1 = (double4) (-1.23,0.0,-12345.032,-12345.032);
  double4 var2 = (double4) (123455.134,-1.23,123455.134,123455.134);
  int i = printf("double4_a_2714c===%#.1v4la===%#.1v4la===\n",var1,var2);
  return i;
}

int double4_a_2715c() {
  // { dg-printf "double4_a_2715c===0x1.e2p+16,0x1.e2p+16,-0x1.3bp+0,0x0.00p+0===0x1.00p+1,0x0.00p+0,-0x1.3bp+0,-0x1.82p+13===" }
  double4 var1 = (double4) (123455.134,123455.134,-1.23,0.0);
  double4 var2 = (double4) (2.0,0.0,-1.23,-12345.032);
  int i = printf("double4_a_2715c===%#.2v4la===%#.2v4la===\n",var1,var2);
  return i;
}

int double4_a_2716c() {
  // { dg-printf "double4_a_2716c===-0x1.3aep+0,0x1.000p+0,0x1.e24p+16,0x1.000p+0===0x1.000p+1,0x1.000p+1,0x1.e24p+16,0x1.e24p+16===" }
  double4 var1 = (double4) (-1.23,1.0,123455.134,1.0);
  double4 var2 = (double4) (2.0,2.0,123455.134,123455.134);
  int i = printf("double4_a_2716c===%#.3v4la===%#.3v4la===\n",var1,var2);
  return i;
}

int double4_a_2717c() {
  // { dg-printf "double4_a_2717c===0x1.e23f224dd3p+16,0x1.e23f224dd3p+16,0x1.0000000000p+0,-0x1.3ae147ae14p+0===-0x1.3ae147ae14p+0,0x0.0000000000p+0,-0x1.3ae147ae14p+0,0x1.e23f224dd3p+16===" }
  double4 var1 = (double4) (123455.134,123455.134,1.0,-1.23);
  double4 var2 = (double4) (-1.23,0.0,-1.23,123455.134);
  int i = printf("double4_a_2717c===%#.10v4la===%#.10v4la===\n",var1,var2);
  return i;
}

int double4_a_2718c() {
  // { dg-printf "double4_a_2718c===0X1.0000000000000P+0,0X1.E23F224DD2F1BP+16,0X1.E23F224DD2F1BP+16,0X1.E23F224DD2F1BP+16===0X0.0000000000000P+0,0X1.E23F224DD2F1BP+16,-0X1.81C84189374BCP+13,0X0.0000000000000P+0===" }
  double4 var1 = (double4) (1.0,123455.134,123455.134,123455.134);
  double4 var2 = (double4) (0.0,123455.134,-12345.032,0.0);
  int i = printf("double4_a_2718c===%#v4lA===%#v4lA===\n",var1,var2);
  return i;
}

int double4_a_2719c() {
  // { dg-printf "double4_a_2719c===0X1.EP+16,-0X1.4P+0,0X1.0P+1,0X1.EP+16===-0X1.8P+13,0X1.0P+0,-0X1.8P+13,-0X1.4P+0===" }
  double4 var1 = (double4) (123455.134,-1.23,2.0,123455.134);
  double4 var2 = (double4) (-12345.032,1.0,-12345.032,-1.23);
  int i = printf("double4_a_2719c===%#.1v4lA===%#.1v4lA===\n",var1,var2);
  return i;
}

int double4_a_2720c() {
  // { dg-printf "double4_a_2720c===0X0.00P+0,-0X1.3BP+0,0X0.00P+0,0X1.00P+0===-0X1.3BP+0,0X1.00P+1,-0X1.82P+13,0X1.E2P+16===" }
  double4 var1 = (double4) (0.0,-1.23,0.0,1.0);
  double4 var2 = (double4) (-1.23,2.0,-12345.032,123455.134);
  int i = printf("double4_a_2720c===%#.2v4lA===%#.2v4lA===\n",var1,var2);
  return i;
}

int double4_a_2721c() {
  // { dg-printf "double4_a_2721c===0X1.000P+1,0X0.000P+0,0X0.000P+0,0X1.E24P+16===-0X1.3AEP+0,-0X1.81CP+13,0X1.000P+1,-0X1.81CP+13===" }
  double4 var1 = (double4) (2.0,0.0,0.0,123455.134);
  double4 var2 = (double4) (-1.23,-12345.032,2.0,-12345.032);
  int i = printf("double4_a_2721c===%#.3v4lA===%#.3v4lA===\n",var1,var2);
  return i;
}

int double4_a_2722c() {
  // { dg-printf "double4_a_2722c===-0X1.3AE147AE14P+0,0X1.0000000000P+1,0X1.0000000000P+0,0X1.0000000000P+1===-0X1.81C8418937P+13,-0X1.81C8418937P+13,0X1.0000000000P+1,-0X1.3AE147AE14P+0===" }
  double4 var1 = (double4) (-1.23,2.0,1.0,2.0);
  double4 var2 = (double4) (-12345.032,-12345.032,2.0,-1.23);
  int i = printf("double4_a_2722c===%#.10v4lA===%#.10v4lA===\n",var1,var2);
  return i;
}

int double4_a_3473c() {
  // { dg-printf "double4_a_3473c===-0x1.81c84189374bcp+13,+0x1.e23f224dd2f1bp+16,-0x1.81c84189374bcp+13,+0x1.e23f224dd2f1bp+16===-0x1.3ae147ae147aep+0,-0x1.81c84189374bcp+13,-0x1.3ae147ae147aep+0,-0x1.3ae147ae147aep+0===" }
  double4 var1 = (double4) (-12345.032,123455.134,-12345.032,123455.134);
  double4 var2 = (double4) (-1.23,-12345.032,-1.23,-1.23);
  int i = printf("double4_a_3473c===%-+v4la===%-+v4la===\n",var1,var2);
  return i;
}

int double4_a_3474c() {
  // { dg-printf "double4_a_3474c===-0x1.4p+0,+0x1.0p+0,-0x1.4p+0,+0x1.0p+0===+0x1.0p+1,+0x0.0p+0,-0x1.4p+0,+0x1.ep+16===" }
  double4 var1 = (double4) (-1.23,1.0,-1.23,1.0);
  double4 var2 = (double4) (2.0,0.0,-1.23,123455.134);
  int i = printf("double4_a_3474c===%-+.1v4la===%-+.1v4la===\n",var1,var2);
  return i;
}

int double4_a_3475c() {
  // { dg-printf "double4_a_3475c===+0x1.00p+1,-0x1.3bp+0,+0x1.00p+0,+0x1.00p+1===-0x1.82p+13,-0x1.82p+13,-0x1.3bp+0,+0x0.00p+0===" }
  double4 var1 = (double4) (2.0,-1.23,1.0,2.0);
  double4 var2 = (double4) (-12345.032,-12345.032,-1.23,0.0);
  int i = printf("double4_a_3475c===%-+.2v4la===%-+.2v4la===\n",var1,var2);
  return i;
}

int double4_a_3476c() {
  // { dg-printf "double4_a_3476c===+0x1.e24p+16,-0x1.3aep+0,-0x1.81cp+13,-0x1.3aep+0===+0x1.e24p+16,-0x1.81cp+13,+0x1.e24p+16,-0x1.3aep+0===" }
  double4 var1 = (double4) (123455.134,-1.23,-12345.032,-1.23);
  double4 var2 = (double4) (123455.134,-12345.032,123455.134,-1.23);
  int i = printf("double4_a_3476c===%-+.3v4la===%-+.3v4la===\n",var1,var2);
  return i;
}

int double4_a_3477c() {
  // { dg-printf "double4_a_3477c===-0x1.81c8418937p+13,+0x1.0000000000p+1,-0x1.81c8418937p+13,-0x1.81c8418937p+13===-0x1.3ae147ae14p+0,+0x1.e23f224dd3p+16,-0x1.81c8418937p+13,+0x1.0000000000p+1===" }
  double4 var1 = (double4) (-12345.032,2.0,-12345.032,-12345.032);
  double4 var2 = (double4) (-1.23,123455.134,-12345.032,2.0);
  int i = printf("double4_a_3477c===%-+.10v4la===%-+.10v4la===\n",var1,var2);
  return i;
}

int double4_a_3478c() {
  // { dg-printf "double4_a_3478c===+0X1.0000000000000P+0,-0X1.81C84189374BCP+13,+0X1.0000000000000P+0,+0X1.0000000000000P+1===-0X1.3AE147AE147AEP+0,+0X1.E23F224DD2F1BP+16,-0X1.81C84189374BCP+13,-0X1.81C84189374BCP+13===" }
  double4 var1 = (double4) (1.0,-12345.032,1.0,2.0);
  double4 var2 = (double4) (-1.23,123455.134,-12345.032,-12345.032);
  int i = printf("double4_a_3478c===%-+v4lA===%-+v4lA===\n",var1,var2);
  return i;
}

int double4_a_3479c() {
  // { dg-printf "double4_a_3479c===+0X1.0P+1,+0X1.0P+0,-0X1.8P+13,+0X0.0P+0===+0X1.0P+1,+0X1.EP+16,+0X0.0P+0,+0X0.0P+0===" }
  double4 var1 = (double4) (2.0,1.0,-12345.032,0.0);
  double4 var2 = (double4) (2.0,123455.134,0.0,0.0);
  int i = printf("double4_a_3479c===%-+.1v4lA===%-+.1v4lA===\n",var1,var2);
  return i;
}

int double4_a_3480c() {
  // { dg-printf "double4_a_3480c===-0X1.3BP+0,+0X1.E2P+16,+0X1.E2P+16,+0X1.E2P+16===-0X1.3BP+0,+0X1.00P+0,+0X1.E2P+16,+0X1.E2P+16===" }
  double4 var1 = (double4) (-1.23,123455.134,123455.134,123455.134);
  double4 var2 = (double4) (-1.23,1.0,123455.134,123455.134);
  int i = printf("double4_a_3480c===%-+.2v4lA===%-+.2v4lA===\n",var1,var2);
  return i;
}

int double4_a_3481c() {
  // { dg-printf "double4_a_3481c===+0X0.000P+0,+0X1.E24P+16,-0X1.81CP+13,-0X1.81CP+13===+0X0.000P+0,-0X1.3AEP+0,+0X1.E24P+16,+0X0.000P+0===" }
  double4 var1 = (double4) (0.0,123455.134,-12345.032,-12345.032);
  double4 var2 = (double4) (0.0,-1.23,123455.134,0.0);
  int i = printf("double4_a_3481c===%-+.3v4lA===%-+.3v4lA===\n",var1,var2);
  return i;
}

int double4_a_3482c() {
  // { dg-printf "double4_a_3482c===+0X1.0000000000P+1,+0X1.0000000000P+0,+0X1.0000000000P+0,+0X0.0000000000P+0===+0X1.0000000000P+0,+0X1.0000000000P+1,+0X0.0000000000P+0,+0X0.0000000000P+0===" }
  double4 var1 = (double4) (2.0,1.0,1.0,0.0);
  double4 var2 = (double4) (1.0,2.0,0.0,0.0);
  int i = printf("double4_a_3482c===%-+.10v4lA===%-+.10v4lA===\n",var1,var2);
  return i;
}

int double4_a_4233c() {
  // { dg-printf "double4_a_4233c===-0x1.81c84189374bcp+13, 0x0.0000000000000p+0, 0x1.0000000000000p+1, 0x1.0000000000000p+1===-0x1.3ae147ae147aep+0, 0x1.0000000000000p+0,-0x1.3ae147ae147aep+0, 0x1.0000000000000p+1===" }
  double4 var1 = (double4) (-12345.032,0.0,2.0,2.0);
  double4 var2 = (double4) (-1.23,1.0,-1.23,2.0);
  int i = printf("double4_a_4233c===% 10v4la===% 10v4la===\n",var1,var2);
  return i;
}

int double4_a_4234c() {
  // { dg-printf "double4_a_4234c===-0x1.8p+13,  0x0.0p+0,  0x1.0p+1,  0x0.0p+0=== -0x1.4p+0,-0x1.8p+13, 0x1.ep+16,  0x1.0p+0===" }
  double4 var1 = (double4) (-12345.032,0.0,2.0,0.0);
  double4 var2 = (double4) (-1.23,-12345.032,123455.134,1.0);
  int i = printf("double4_a_4234c===% 10.1v4la===% 10.1v4la===\n",var1,var2);
  return i;
}

int double4_a_4235c() {
  // { dg-printf "double4_a_4235c===-0x1.82p+13,-0x1.3bp+0, 0x1.00p+0,-0x1.3bp+0=== 0x1.00p+1, 0x1.e2p+16, 0x1.e2p+16,-0x1.82p+13===" }
  double4 var1 = (double4) (-12345.032,-1.23,1.0,-1.23);
  double4 var2 = (double4) (2.0,123455.134,123455.134,-12345.032);
  int i = printf("double4_a_4235c===% 10.2v4la===% 10.2v4la===\n",var1,var2);
  return i;
}

int double4_a_4236c() {
  // { dg-printf "double4_a_4236c===-0x1.3aep+0, 0x1.000p+1, 0x1.000p+1,-0x1.3aep+0===-0x1.81cp+13, 0x0.000p+0,-0x1.3aep+0, 0x1.000p+1===" }
  double4 var1 = (double4) (-1.23,2.0,2.0,-1.23);
  double4 var2 = (double4) (-12345.032,0.0,-1.23,2.0);
  int i = printf("double4_a_4236c===% 10.3v4la===% 10.3v4la===\n",var1,var2);
  return i;
}

int double4_a_4237c() {
  // { dg-printf "double4_a_4237c===-0x1.3ae147ae14p+0, 0x1.e23f224dd3p+16, 0x1.0000000000p+0, 0x1.0000000000p+0===-0x1.81c8418937p+13, 0x1.0000000000p+0,-0x1.3ae147ae14p+0, 0x0.0000000000p+0===" }
  double4 var1 = (double4) (-1.23,123455.134,1.0,1.0);
  double4 var2 = (double4) (-12345.032,1.0,-1.23,0.0);
  int i = printf("double4_a_4237c===% 10.10v4la===% 10.10v4la===\n",var1,var2);
  return i;
}

int double4_a_4238c() {
  // { dg-printf "double4_a_4238c=== 0X1.E23F224DD2F1BP+16, 0X1.0000000000000P+1, 0X1.0000000000000P+0, 0X1.0000000000000P+1===-0X1.3AE147AE147AEP+0, 0X0.0000000000000P+0, 0X1.E23F224DD2F1BP+16, 0X1.0000000000000P+0===" }
  double4 var1 = (double4) (123455.134,2.0,1.0,2.0);
  double4 var2 = (double4) (-1.23,0.0,123455.134,1.0);
  int i = printf("double4_a_4238c===% 10v4lA===% 10v4lA===\n",var1,var2);
  return i;
}

int double4_a_4239c() {
  // { dg-printf "double4_a_4239c=== 0X1.EP+16,  0X0.0P+0,  0X1.0P+0, -0X1.4P+0===-0X1.8P+13,-0X1.8P+13,  0X1.0P+0, -0X1.4P+0===" }
  double4 var1 = (double4) (123455.134,0.0,1.0,-1.23);
  double4 var2 = (double4) (-12345.032,-12345.032,1.0,-1.23);
  int i = printf("double4_a_4239c===% 10.1v4lA===% 10.1v4lA===\n",var1,var2);
  return i;
}

int double4_a_4240c() {
  // { dg-printf "double4_a_4240c===-0X1.3BP+0, 0X1.E2P+16, 0X1.E2P+16, 0X1.00P+1===-0X1.82P+13, 0X1.00P+1,-0X1.3BP+0,-0X1.3BP+0===" }
  double4 var1 = (double4) (-1.23,123455.134,123455.134,2.0);
  double4 var2 = (double4) (-12345.032,2.0,-1.23,-1.23);
  int i = printf("double4_a_4240c===% 10.2v4lA===% 10.2v4lA===\n",var1,var2);
  return i;
}

int double4_a_4241c() {
  // { dg-printf "double4_a_4241c=== 0X0.000P+0,-0X1.81CP+13, 0X1.E24P+16,-0X1.81CP+13=== 0X0.000P+0, 0X1.E24P+16, 0X1.E24P+16, 0X1.E24P+16===" }
  double4 var1 = (double4) (0.0,-12345.032,123455.134,-12345.032);
  double4 var2 = (double4) (0.0,123455.134,123455.134,123455.134);
  int i = printf("double4_a_4241c===% 10.3v4lA===% 10.3v4lA===\n",var1,var2);
  return i;
}

int double4_a_4242c() {
  // { dg-printf "double4_a_4242c=== 0X1.E23F224DD3P+16, 0X1.0000000000P+0,-0X1.81C8418937P+13, 0X1.0000000000P+1===-0X1.81C8418937P+13, 0X1.E23F224DD3P+16, 0X0.0000000000P+0, 0X1.0000000000P+1===" }
  double4 var1 = (double4) (123455.134,1.0,-12345.032,2.0);
  double4 var2 = (double4) (-12345.032,123455.134,0.0,2.0);
  int i = printf("double4_a_4242c===% 10.10v4lA===% 10.10v4lA===\n",var1,var2);
  return i;
}

int double4_a_433c() {
  // { dg-printf "double4_a_433c===0x1.0000000000000p+0,0x1.e23f224dd2f1bp+16,-0x1.3ae147ae147aep+0,-0x1.81c84189374bcp+13===0x1.e23f224dd2f1bp+16,0x1.0000000000000p+0,0x1.0000000000000p+1,0x0.0000000000000p+0===" }
  double4 var1 = (double4) (1.0,123455.134,-1.23,-12345.032);
  double4 var2 = (double4) (123455.134,1.0,2.0,0.0);
  int i = printf("double4_a_433c===%v4la===%v4la===\n",var1,var2);
  return i;
}

int double4_a_434c() {
  // { dg-printf "double4_a_434c===0x1.ep+16,0x0.0p+0,0x1.0p+1,0x1.0p+1===0x1.ep+16,0x0.0p+0,0x1.0p+0,0x1.ep+16===" }
  double4 var1 = (double4) (123455.134,0.0,2.0,2.0);
  double4 var2 = (double4) (123455.134,0.0,1.0,123455.134);
  int i = printf("double4_a_434c===%.1v4la===%.1v4la===\n",var1,var2);
  return i;
}

int double4_a_435c() {
  // { dg-printf "double4_a_435c===-0x1.82p+13,0x1.e2p+16,0x1.e2p+16,0x1.00p+0===0x1.e2p+16,0x1.00p+1,-0x1.82p+13,0x1.00p+1===" }
  double4 var1 = (double4) (-12345.032,123455.134,123455.134,1.0);
  double4 var2 = (double4) (123455.134,2.0,-12345.032,2.0);
  int i = printf("double4_a_435c===%.2v4la===%.2v4la===\n",var1,var2);
  return i;
}

int double4_a_436c() {
  // { dg-printf "double4_a_436c===-0x1.3aep+0,0x1.000p+0,-0x1.81cp+13,0x1.e24p+16===0x1.e24p+16,-0x1.81cp+13,-0x1.3aep+0,0x1.e24p+16===" }
  double4 var1 = (double4) (-1.23,1.0,-12345.032,123455.134);
  double4 var2 = (double4) (123455.134,-12345.032,-1.23,123455.134);
  int i = printf("double4_a_436c===%.3v4la===%.3v4la===\n",var1,var2);
  return i;
}

int double4_a_437c() {
  // { dg-printf "double4_a_437c===0x1.e23f224dd3p+16,-0x1.81c8418937p+13,0x1.e23f224dd3p+16,0x1.e23f224dd3p+16===0x1.0000000000p+1,0x1.e23f224dd3p+16,-0x1.81c8418937p+13,0x1.e23f224dd3p+16===" }
  double4 var1 = (double4) (123455.134,-12345.032,123455.134,123455.134);
  double4 var2 = (double4) (2.0,123455.134,-12345.032,123455.134);
  int i = printf("double4_a_437c===%.10v4la===%.10v4la===\n",var1,var2);
  return i;
}

int double4_a_438c() {
  // { dg-printf "double4_a_438c===0X0.0000000000000P+0,-0X1.3AE147AE147AEP+0,0X0.0000000000000P+0,0X0.0000000000000P+0===-0X1.81C84189374BCP+13,-0X1.3AE147AE147AEP+0,-0X1.81C84189374BCP+13,0X0.0000000000000P+0===" }
  double4 var1 = (double4) (0.0,-1.23,0.0,0.0);
  double4 var2 = (double4) (-12345.032,-1.23,-12345.032,0.0);
  int i = printf("double4_a_438c===%v4lA===%v4lA===\n",var1,var2);
  return i;
}

int double4_a_439c() {
  // { dg-printf "double4_a_439c===0X1.0P+0,0X1.0P+1,0X1.EP+16,0X1.EP+16===0X1.0P+0,0X0.0P+0,-0X1.8P+13,0X0.0P+0===" }
  double4 var1 = (double4) (1.0,2.0,123455.134,123455.134);
  double4 var2 = (double4) (1.0,0.0,-12345.032,0.0);
  int i = printf("double4_a_439c===%.1v4lA===%.1v4lA===\n",var1,var2);
  return i;
}

int double4_a_440c() {
  // { dg-printf "double4_a_440c===-0X1.3BP+0,0X0.00P+0,0X0.00P+0,0X1.00P+0===-0X1.3BP+0,0X1.E2P+16,0X1.00P+1,0X0.00P+0===" }
  double4 var1 = (double4) (-1.23,0.0,0.0,1.0);
  double4 var2 = (double4) (-1.23,123455.134,2.0,0.0);
  int i = printf("double4_a_440c===%.2v4lA===%.2v4lA===\n",var1,var2);
  return i;
}

int double4_a_441c() {
  // { dg-printf "double4_a_441c===0X1.E24P+16,-0X1.81CP+13,0X1.000P+0,0X1.E24P+16===0X1.000P+0,-0X1.3AEP+0,-0X1.81CP+13,0X1.000P+0===" }
  double4 var1 = (double4) (123455.134,-12345.032,1.0,123455.134);
  double4 var2 = (double4) (1.0,-1.23,-12345.032,1.0);
  int i = printf("double4_a_441c===%.3v4lA===%.3v4lA===\n",var1,var2);
  return i;
}

int double4_a_442c() {
  // { dg-printf "double4_a_442c===-0X1.81C8418937P+13,0X1.0000000000P+0,0X1.0000000000P+0,-0X1.3AE147AE14P+0===-0X1.81C8418937P+13,0X1.E23F224DD3P+16,0X1.E23F224DD3P+16,-0X1.3AE147AE14P+0===" }
  double4 var1 = (double4) (-12345.032,1.0,1.0,-1.23);
  double4 var2 = (double4) (-12345.032,123455.134,123455.134,-1.23);
  int i = printf("double4_a_442c===%.10v4lA===%.10v4lA===\n",var1,var2);
  return i;
}

int double4_a_4993c() {
  // { dg-printf "double4_a_4993c===0x1.0000000000000p+1,0x1.e23f224dd2f1bp+16,0x1.0000000000000p+1,0x1.0000000000000p+1===0x0.0000000000000p+0,-0x1.81c84189374bcp+13,-0x1.3ae147ae147aep+0,-0x1.3ae147ae147aep+0===" }
  double4 var1 = (double4) (2.0,123455.134,2.0,2.0);
  double4 var2 = (double4) (0.0,-12345.032,-1.23,-1.23);
  int i = printf("double4_a_4993c===%010v4la===%010v4la===\n",var1,var2);
  return i;
}

int double4_a_4994c() {
  // { dg-printf "double4_a_4994c===-0x1.8p+13,0x001.0p+0,-0x1.8p+13,0x001.0p+0===0x01.ep+16,-0x1.8p+13,0x001.0p+0,0x000.0p+0===" }
  double4 var1 = (double4) (-12345.032,1.0,-12345.032,1.0);
  double4 var2 = (double4) (123455.134,-12345.032,1.0,0.0);
  int i = printf("double4_a_4994c===%010.1v4la===%010.1v4la===\n",var1,var2);
  return i;
}

int double4_a_4995c() {
  // { dg-printf "double4_a_4995c===0x00.00p+0,-0x1.3bp+0,0x01.00p+0,0x01.00p+1===0x01.00p+1,-0x1.82p+13,0x1.e2p+16,-0x1.82p+13===" }
  double4 var1 = (double4) (0.0,-1.23,1.0,2.0);
  double4 var2 = (double4) (2.0,-12345.032,123455.134,-12345.032);
  int i = printf("double4_a_4995c===%010.2v4la===%010.2v4la===\n",var1,var2);
  return i;
}

int double4_a_4996c() {
  // { dg-printf "double4_a_4996c===-0x1.81cp+13,-0x1.81cp+13,0x0.000p+0,0x1.000p+1===-0x1.81cp+13,0x1.000p+1,0x1.000p+1,0x1.e24p+16===" }
  double4 var1 = (double4) (-12345.032,-12345.032,0.0,2.0);
  double4 var2 = (double4) (-12345.032,2.0,2.0,123455.134);
  int i = printf("double4_a_4996c===%010.3v4la===%010.3v4la===\n",var1,var2);
  return i;
}

int double4_a_4997c() {
  // { dg-printf "double4_a_4997c===-0x1.3ae147ae14p+0,0x0.0000000000p+0,0x1.0000000000p+0,0x0.0000000000p+0===-0x1.3ae147ae14p+0,0x0.0000000000p+0,0x1.0000000000p+1,-0x1.3ae147ae14p+0===" }
  double4 var1 = (double4) (-1.23,0.0,1.0,0.0);
  double4 var2 = (double4) (-1.23,0.0,2.0,-1.23);
  int i = printf("double4_a_4997c===%010.10v4la===%010.10v4la===\n",var1,var2);
  return i;
}

int double4_a_4998c() {
  // { dg-printf "double4_a_4998c===0X1.E23F224DD2F1BP+16,-0X1.3AE147AE147AEP+0,-0X1.81C84189374BCP+13,0X0.0000000000000P+0===0X1.0000000000000P+1,-0X1.3AE147AE147AEP+0,0X1.0000000000000P+0,0X1.0000000000000P+1===" }
  double4 var1 = (double4) (123455.134,-1.23,-12345.032,0.0);
  double4 var2 = (double4) (2.0,-1.23,1.0,2.0);
  int i = printf("double4_a_4998c===%010v4lA===%010v4lA===\n",var1,var2);
  return i;
}

int double4_a_4999c() {
  // { dg-printf "double4_a_4999c===0X001.0P+1,0X01.EP+16,-0X1.8P+13,0X01.EP+16===-0X01.4P+0,0X001.0P+0,0X001.0P+1,0X01.EP+16===" }
  double4 var1 = (double4) (2.0,123455.134,-12345.032,123455.134);
  double4 var2 = (double4) (-1.23,1.0,2.0,123455.134);
  int i = printf("double4_a_4999c===%010.1v4lA===%010.1v4lA===\n",var1,var2);
  return i;
}

int double4_a_5000c() {
  // { dg-printf "double4_a_5000c===-0X1.82P+13,-0X1.3BP+0,0X01.00P+0,-0X1.82P+13===0X01.00P+0,0X00.00P+0,0X1.E2P+16,0X1.E2P+16===" }
  double4 var1 = (double4) (-12345.032,-1.23,1.0,-12345.032);
  double4 var2 = (double4) (1.0,0.0,123455.134,123455.134);
  int i = printf("double4_a_5000c===%010.2v4lA===%010.2v4lA===\n",var1,var2);
  return i;
}

int double4_a_5001c() {
  // { dg-printf "double4_a_5001c===0X1.000P+0,0X1.000P+0,0X0.000P+0,-0X1.81CP+13===0X1.E24P+16,0X1.000P+0,0X1.000P+0,-0X1.81CP+13===" }
  double4 var1 = (double4) (1.0,1.0,0.0,-12345.032);
  double4 var2 = (double4) (123455.134,1.0,1.0,-12345.032);
  int i = printf("double4_a_5001c===%010.3v4lA===%010.3v4lA===\n",var1,var2);
  return i;
}

int double4_a_5002c() {
  // { dg-printf "double4_a_5002c===0X0.0000000000P+0,0X1.E23F224DD3P+16,0X1.0000000000P+0,-0X1.81C8418937P+13===0X0.0000000000P+0,0X1.0000000000P+0,0X1.0000000000P+1,0X0.0000000000P+0===" }
  double4 var1 = (double4) (0.0,123455.134,1.0,-12345.032);
  double4 var2 = (double4) (0.0,1.0,2.0,0.0);
  int i = printf("double4_a_5002c===%010.10v4lA===%010.10v4lA===\n",var1,var2);
  return i;
}

int double4_a_5753c() {
  // { dg-printf "double4_a_5753c===-0x1.3ae147ae147aep+0, 0x1.0000000000000p+1, 0x0.0000000000000p+0, 0x0.0000000000000p+0=== 0x0.0000000000000p+0, 0x1.e23f224dd2f1bp+16, 0x0.0000000000000p+0, 0x1.0000000000000p+0===" }
  double4 var1 = (double4) (-1.23,2.0,0.0,0.0);
  double4 var2 = (double4) (0.0,123455.134,0.0,1.0);
  int i = printf("double4_a_5753c===%- 10v4la===%- 10v4la===\n",var1,var2);
  return i;
}

int double4_a_5754c() {
  // { dg-printf "double4_a_5754c=== 0x0.0p+0 , 0x1.ep+16, 0x0.0p+0 , 0x1.ep+16=== 0x0.0p+0 , 0x0.0p+0 ,-0x1.8p+13,-0x1.4p+0 ===" }
  double4 var1 = (double4) (0.0,123455.134,0.0,123455.134);
  double4 var2 = (double4) (0.0,0.0,-12345.032,-1.23);
  int i = printf("double4_a_5754c===%- 10.1v4la===%- 10.1v4la===\n",var1,var2);
  return i;
}

int double4_a_5755c() {
  // { dg-printf "double4_a_5755c=== 0x1.e2p+16, 0x1.e2p+16, 0x1.00p+1,-0x1.82p+13=== 0x0.00p+0,-0x1.82p+13,-0x1.3bp+0, 0x1.00p+1===" }
  double4 var1 = (double4) (123455.134,123455.134,2.0,-12345.032);
  double4 var2 = (double4) (0.0,-12345.032,-1.23,2.0);
  int i = printf("double4_a_5755c===%- 10.2v4la===%- 10.2v4la===\n",var1,var2);
  return i;
}

int double4_a_5756c() {
  // { dg-printf "double4_a_5756c=== 0x1.e24p+16, 0x1.000p+1, 0x1.000p+1, 0x1.000p+0=== 0x1.000p+0, 0x1.e24p+16, 0x1.e24p+16,-0x1.81cp+13===" }
  double4 var1 = (double4) (123455.134,2.0,2.0,1.0);
  double4 var2 = (double4) (1.0,123455.134,123455.134,-12345.032);
  int i = printf("double4_a_5756c===%- 10.3v4la===%- 10.3v4la===\n",var1,var2);
  return i;
}

int double4_a_5757c() {
  // { dg-printf "double4_a_5757c=== 0x1.0000000000p+1, 0x1.0000000000p+1,-0x1.3ae147ae14p+0, 0x1.e23f224dd3p+16=== 0x0.0000000000p+0, 0x1.0000000000p+1, 0x1.0000000000p+0,-0x1.81c8418937p+13===" }
  double4 var1 = (double4) (2.0,2.0,-1.23,123455.134);
  double4 var2 = (double4) (0.0,2.0,1.0,-12345.032);
  int i = printf("double4_a_5757c===%- 10.10v4la===%- 10.10v4la===\n",var1,var2);
  return i;
}

int double4_a_5758c() {
  // { dg-printf "double4_a_5758c=== 0X1.0000000000000P+0, 0X1.E23F224DD2F1BP+16,-0X1.3AE147AE147AEP+0, 0X1.E23F224DD2F1BP+16=== 0X1.E23F224DD2F1BP+16, 0X1.0000000000000P+0,-0X1.81C84189374BCP+13, 0X0.0000000000000P+0===" }
  double4 var1 = (double4) (1.0,123455.134,-1.23,123455.134);
  double4 var2 = (double4) (123455.134,1.0,-12345.032,0.0);
  int i = printf("double4_a_5758c===%- 10v4lA===%- 10v4lA===\n",var1,var2);
  return i;
}

int double4_a_5759c() {
  // { dg-printf "double4_a_5759c===-0X1.4P+0 , 0X1.EP+16,-0X1.4P+0 ,-0X1.4P+0 === 0X1.EP+16, 0X1.0P+0 , 0X1.0P+1 ,-0X1.8P+13===" }
  double4 var1 = (double4) (-1.23,123455.134,-1.23,-1.23);
  double4 var2 = (double4) (123455.134,1.0,2.0,-12345.032);
  int i = printf("double4_a_5759c===%- 10.1v4lA===%- 10.1v4lA===\n",var1,var2);
  return i;
}

int double4_a_5760c() {
  // { dg-printf "double4_a_5760c===-0X1.82P+13, 0X1.00P+0, 0X1.E2P+16, 0X1.00P+0=== 0X1.00P+0, 0X1.00P+1, 0X0.00P+0,-0X1.82P+13===" }
  double4 var1 = (double4) (-12345.032,1.0,123455.134,1.0);
  double4 var2 = (double4) (1.0,2.0,0.0,-12345.032);
  int i = printf("double4_a_5760c===%- 10.2v4lA===%- 10.2v4lA===\n",var1,var2);
  return i;
}

int double4_a_5761c() {
  // { dg-printf "double4_a_5761c===-0X1.81CP+13, 0X1.000P+1, 0X1.000P+0,-0X1.3AEP+0=== 0X1.E24P+16, 0X1.000P+0, 0X1.000P+1, 0X0.000P+0===" }
  double4 var1 = (double4) (-12345.032,2.0,1.0,-1.23);
  double4 var2 = (double4) (123455.134,1.0,2.0,0.0);
  int i = printf("double4_a_5761c===%- 10.3v4lA===%- 10.3v4lA===\n",var1,var2);
  return i;
}

int double4_a_5762c() {
  // { dg-printf "double4_a_5762c===-0X1.3AE147AE14P+0, 0X1.0000000000P+0, 0X1.E23F224DD3P+16, 0X0.0000000000P+0=== 0X1.0000000000P+1, 0X1.0000000000P+0,-0X1.3AE147AE14P+0,-0X1.81C8418937P+13===" }
  double4 var1 = (double4) (-1.23,1.0,123455.134,0.0);
  double4 var2 = (double4) (2.0,1.0,-1.23,-12345.032);
  int i = printf("double4_a_5762c===%- 10.10v4lA===%- 10.10v4lA===\n",var1,var2);
  return i;
}

int double4_a_6513c() {
  // { dg-printf "double4_a_6513c===+0x1.0000000000000p+1,+0x1.0000000000000p+1,+0x1.e23f224dd2f1bp+16,+0x1.0000000000000p+1===+0x1.0000000000000p+0,+0x1.0000000000000p+0,-0x1.3ae147ae147aep+0,+0x1.e23f224dd2f1bp+16===" }
  double4 var1 = (double4) (2.0,2.0,123455.134,2.0);
  double4 var2 = (double4) (1.0,1.0,-1.23,123455.134);
  int i = printf("double4_a_6513c===%+ 10v4la===%+ 10v4la===\n",var1,var2);
  return i;
}

int double4_a_6514c() {
  // { dg-printf "double4_a_6514c=== -0x1.4p+0, +0x1.0p+0,+0x1.ep+16, +0x1.0p+1===-0x1.8p+13, -0x1.4p+0,-0x1.8p+13, +0x1.0p+1===" }
  double4 var1 = (double4) (-1.23,1.0,123455.134,2.0);
  double4 var2 = (double4) (-12345.032,-1.23,-12345.032,2.0);
  int i = printf("double4_a_6514c===%+ 10.1v4la===%+ 10.1v4la===\n",var1,var2);
  return i;
}

int double4_a_6515c() {
  // { dg-printf "double4_a_6515c===-0x1.82p+13,+0x1.00p+1,+0x1.e2p+16,+0x1.00p+1===+0x1.e2p+16,+0x1.00p+0,-0x1.82p+13,+0x1.e2p+16===" }
  double4 var1 = (double4) (-12345.032,2.0,123455.134,2.0);
  double4 var2 = (double4) (123455.134,1.0,-12345.032,123455.134);
  int i = printf("double4_a_6515c===%+ 10.2v4la===%+ 10.2v4la===\n",var1,var2);
  return i;
}

int double4_a_6516c() {
  // { dg-printf "double4_a_6516c===-0x1.3aep+0,-0x1.81cp+13,+0x1.e24p+16,+0x1.e24p+16===+0x0.000p+0,-0x1.3aep+0,+0x1.e24p+16,+0x0.000p+0===" }
  double4 var1 = (double4) (-1.23,-12345.032,123455.134,123455.134);
  double4 var2 = (double4) (0.0,-1.23,123455.134,0.0);
  int i = printf("double4_a_6516c===%+ 10.3v4la===%+ 10.3v4la===\n",var1,var2);
  return i;
}

int double4_a_6517c() {
  // { dg-printf "double4_a_6517c===+0x1.e23f224dd3p+16,+0x1.0000000000p+0,+0x1.0000000000p+0,+0x1.0000000000p+0===+0x1.0000000000p+0,+0x1.0000000000p+1,+0x1.e23f224dd3p+16,+0x0.0000000000p+0===" }
  double4 var1 = (double4) (123455.134,1.0,1.0,1.0);
  double4 var2 = (double4) (1.0,2.0,123455.134,0.0);
  int i = printf("double4_a_6517c===%+ 10.10v4la===%+ 10.10v4la===\n",var1,var2);
  return i;
}

int double4_a_6518c() {
  // { dg-printf "double4_a_6518c===-0X1.3AE147AE147AEP+0,-0X1.81C84189374BCP+13,+0X1.0000000000000P+0,+0X1.0000000000000P+1===-0X1.3AE147AE147AEP+0,+0X0.0000000000000P+0,-0X1.81C84189374BCP+13,+0X0.0000000000000P+0===" }
  double4 var1 = (double4) (-1.23,-12345.032,1.0,2.0);
  double4 var2 = (double4) (-1.23,0.0,-12345.032,0.0);
  int i = printf("double4_a_6518c===%+ 10v4lA===%+ 10v4lA===\n",var1,var2);
  return i;
}

int double4_a_6519c() {
  // { dg-printf "double4_a_6519c=== +0X1.0P+1, -0X1.4P+0,+0X1.EP+16,-0X1.8P+13=== +0X1.0P+1, +0X0.0P+0,-0X1.8P+13, +0X1.0P+0===" }
  double4 var1 = (double4) (2.0,-1.23,123455.134,-12345.032);
  double4 var2 = (double4) (2.0,0.0,-12345.032,1.0);
  int i = printf("double4_a_6519c===%+ 10.1v4lA===%+ 10.1v4lA===\n",var1,var2);
  return i;
}

int double4_a_6520c() {
  // { dg-printf "double4_a_6520c===-0X1.3BP+0,-0X1.82P+13,+0X1.E2P+16,+0X0.00P+0===+0X0.00P+0,+0X1.E2P+16,-0X1.3BP+0,+0X0.00P+0===" }
  double4 var1 = (double4) (-1.23,-12345.032,123455.134,0.0);
  double4 var2 = (double4) (0.0,123455.134,-1.23,0.0);
  int i = printf("double4_a_6520c===%+ 10.2v4lA===%+ 10.2v4lA===\n",var1,var2);
  return i;
}

int double4_a_6521c() {
  // { dg-printf "double4_a_6521c===-0X1.81CP+13,+0X1.000P+1,+0X0.000P+0,-0X1.81CP+13===-0X1.81CP+13,-0X1.3AEP+0,+0X1.E24P+16,+0X1.E24P+16===" }
  double4 var1 = (double4) (-12345.032,2.0,0.0,-12345.032);
  double4 var2 = (double4) (-12345.032,-1.23,123455.134,123455.134);
  int i = printf("double4_a_6521c===%+ 10.3v4lA===%+ 10.3v4lA===\n",var1,var2);
  return i;
}

int double4_a_6522c() {
  // { dg-printf "double4_a_6522c===+0X0.0000000000P+0,+0X1.0000000000P+0,+0X1.0000000000P+1,+0X1.E23F224DD3P+16===+0X1.0000000000P+0,-0X1.81C8418937P+13,+0X1.0000000000P+0,-0X1.81C8418937P+13===" }
  double4 var1 = (double4) (0.0,1.0,2.0,123455.134);
  double4 var2 = (double4) (1.0,-12345.032,1.0,-12345.032);
  int i = printf("double4_a_6522c===%+ 10.10v4lA===%+ 10.10v4lA===\n",var1,var2);
  return i;
}

int double4_a_7273c() {
  // { dg-printf "double4_a_7273c===+0x1.0000000000000p+1,-0x1.3ae147ae147aep+0,-0x1.81c84189374bcp+13,+0x1.0000000000000p+1===+0x1.0000000000000p+1,+0x1.e23f224dd2f1bp+16,+0x1.0000000000000p+0,+0x1.0000000000000p+1===" }
  double4 var1 = (double4) (2.0,-1.23,-12345.032,2.0);
  double4 var2 = (double4) (2.0,123455.134,1.0,2.0);
  int i = printf("double4_a_7273c===%+010v4la===%+010v4la===\n",var1,var2);
  return i;
}

int double4_a_7274c() {
  // { dg-printf "double4_a_7274c===+0x01.0p+0,-0x01.4p+0,-0x01.4p+0,+0x01.0p+0===+0x01.0p+1,+0x01.0p+1,+0x01.0p+1,+0x01.0p+1===" }
  double4 var1 = (double4) (1.0,-1.23,-1.23,1.0);
  double4 var2 = (double4) (2.0,2.0,2.0,2.0);
  int i = printf("double4_a_7274c===%+010.1v4la===%+010.1v4la===\n",var1,var2);
  return i;
}

int double4_a_7275c() {
  // { dg-printf "double4_a_7275c===-0x1.3bp+0,+0x1.00p+1,-0x1.82p+13,+0x0.00p+0===+0x1.e2p+16,+0x1.e2p+16,+0x0.00p+0,-0x1.82p+13===" }
  double4 var1 = (double4) (-1.23,2.0,-12345.032,0.0);
  double4 var2 = (double4) (123455.134,123455.134,0.0,-12345.032);
  int i = printf("double4_a_7275c===%+010.2v4la===%+010.2v4la===\n",var1,var2);
  return i;
}

int double4_a_7276c() {
  // { dg-printf "double4_a_7276c===+0x1.000p+0,+0x1.000p+0,+0x1.000p+0,+0x1.000p+1===+0x1.000p+0,-0x1.81cp+13,-0x1.81cp+13,+0x0.000p+0===" }
  double4 var1 = (double4) (1.0,1.0,1.0,2.0);
  double4 var2 = (double4) (1.0,-12345.032,-12345.032,0.0);
  int i = printf("double4_a_7276c===%+010.3v4la===%+010.3v4la===\n",var1,var2);
  return i;
}

int double4_a_7277c() {
  // { dg-printf "double4_a_7277c===+0x1.0000000000p+1,+0x1.0000000000p+1,+0x1.0000000000p+1,+0x1.0000000000p+0===+0x1.0000000000p+1,+0x0.0000000000p+0,+0x1.0000000000p+1,-0x1.3ae147ae14p+0===" }
  double4 var1 = (double4) (2.0,2.0,2.0,1.0);
  double4 var2 = (double4) (2.0,0.0,2.0,-1.23);
  int i = printf("double4_a_7277c===%+010.10v4la===%+010.10v4la===\n",var1,var2);
  return i;
}

int double4_a_7278c() {
  // { dg-printf "double4_a_7278c===+0X0.0000000000000P+0,-0X1.3AE147AE147AEP+0,+0X0.0000000000000P+0,-0X1.3AE147AE147AEP+0===+0X1.E23F224DD2F1BP+16,+0X1.0000000000000P+1,+0X1.0000000000000P+1,+0X1.0000000000000P+1===" }
  double4 var1 = (double4) (0.0,-1.23,0.0,-1.23);
  double4 var2 = (double4) (123455.134,2.0,2.0,2.0);
  int i = printf("double4_a_7278c===%+010v4lA===%+010v4lA===\n",var1,var2);
  return i;
}

int double4_a_7279c() {
  // { dg-printf "double4_a_7279c===-0X01.4P+0,+0X00.0P+0,+0X01.0P+1,+0X1.EP+16===-0X1.8P+13,+0X00.0P+0,-0X01.4P+0,+0X01.0P+0===" }
  double4 var1 = (double4) (-1.23,0.0,2.0,123455.134);
  double4 var2 = (double4) (-12345.032,0.0,-1.23,1.0);
  int i = printf("double4_a_7279c===%+010.1v4lA===%+010.1v4lA===\n",var1,var2);
  return i;
}

int double4_a_7280c() {
  // { dg-printf "double4_a_7280c===+0X1.E2P+16,-0X1.82P+13,-0X1.82P+13,-0X1.82P+13===+0X1.00P+1,+0X0.00P+0,+0X1.00P+1,+0X0.00P+0===" }
  double4 var1 = (double4) (123455.134,-12345.032,-12345.032,-12345.032);
  double4 var2 = (double4) (2.0,0.0,2.0,0.0);
  int i = printf("double4_a_7280c===%+010.2v4lA===%+010.2v4lA===\n",var1,var2);
  return i;
}

int double4_a_7281c() {
  // { dg-printf "double4_a_7281c===+0X1.E24P+16,+0X1.000P+0,+0X1.E24P+16,+0X0.000P+0===+0X0.000P+0,+0X0.000P+0,+0X0.000P+0,+0X1.E24P+16===" }
  double4 var1 = (double4) (123455.134,1.0,123455.134,0.0);
  double4 var2 = (double4) (0.0,0.0,0.0,123455.134);
  int i = printf("double4_a_7281c===%+010.3v4lA===%+010.3v4lA===\n",var1,var2);
  return i;
}

int double4_a_7282c() {
  // { dg-printf "double4_a_7282c===+0X0.0000000000P+0,-0X1.81C8418937P+13,+0X1.0000000000P+0,+0X1.E23F224DD3P+16===+0X1.E23F224DD3P+16,-0X1.81C8418937P+13,+0X1.0000000000P+0,+0X1.0000000000P+1===" }
  double4 var1 = (double4) (0.0,-12345.032,1.0,123455.134);
  double4 var2 = (double4) (123455.134,-12345.032,1.0,2.0);
  int i = printf("double4_a_7282c===%+010.10v4lA===%+010.10v4lA===\n",var1,var2);
  return i;
}

int double4_e_1203c() {
  // { dg-printf "double4_e_1203c===1.234551e+05,-1.234503e+04,1.000000e+00,1.000000e+00===1.234551e+05,1.000000e+00,1.000000e+00,2.000000e+00===" }
  double4 var1 = (double4) (123455.134,-12345.032,1.0,1.0);
  double4 var2 = (double4) (123455.134,1.0,1.0,2.0);
  int i = printf("double4_e_1203c===%-v4le===%-v4le===\n",var1,var2);
  return i;
}

int double4_e_1204c() {
  // { dg-printf "double4_e_1204c===1.0e+00,-1.2e+00,0.0e+00,0.0e+00===0.0e+00,1.2e+05,-1.2e+04,1.0e+00===" }
  double4 var1 = (double4) (1.0,-1.23,0.0,0.0);
  double4 var2 = (double4) (0.0,123455.134,-12345.032,1.0);
  int i = printf("double4_e_1204c===%-.1v4le===%-.1v4le===\n",var1,var2);
  return i;
}

int double4_e_1205c() {
  // { dg-printf "double4_e_1205c===1.23e+05,2.00e+00,-1.23e+04,1.23e+05===2.00e+00,-1.23e+00,1.23e+05,-1.23e+04===" }
  double4 var1 = (double4) (123455.134,2.0,-12345.032,123455.134);
  double4 var2 = (double4) (2.0,-1.23,123455.134,-12345.032);
  int i = printf("double4_e_1205c===%-.2v4le===%-.2v4le===\n",var1,var2);
  return i;
}

int double4_e_1206c() {
  // { dg-printf "double4_e_1206c===1.235e+05,-1.235e+04,1.000e+00,2.000e+00===-1.230e+00,1.235e+05,-1.235e+04,-1.235e+04===" }
  double4 var1 = (double4) (123455.134,-12345.032,1.0,2.0);
  double4 var2 = (double4) (-1.23,123455.134,-12345.032,-12345.032);
  int i = printf("double4_e_1206c===%-.3v4le===%-.3v4le===\n",var1,var2);
  return i;
}

int double4_e_1207c() {
  // { dg-printf "double4_e_1207c===1.0000000000e+00,1.2345513400e+05,-1.2345032000e+04,0.0000000000e+00===1.0000000000e+00,0.0000000000e+00,0.0000000000e+00,1.0000000000e+00===" }
  double4 var1 = (double4) (1.0,123455.134,-12345.032,0.0);
  double4 var2 = (double4) (1.0,0.0,0.0,1.0);
  int i = printf("double4_e_1207c===%-.10v4le===%-.10v4le===\n",var1,var2);
  return i;
}

int double4_e_1208c() {
  // { dg-printf "double4_e_1208c===-1.234503E+04,1.000000E+00,-1.230000E+00,2.000000E+00===-1.234503E+04,2.000000E+00,-1.234503E+04,1.000000E+00===" }
  double4 var1 = (double4) (-12345.032,1.0,-1.23,2.0);
  double4 var2 = (double4) (-12345.032,2.0,-12345.032,1.0);
  int i = printf("double4_e_1208c===%-v4lE===%-v4lE===\n",var1,var2);
  return i;
}

int double4_e_1209c() {
  // { dg-printf "double4_e_1209c===1.0E+00,-1.2E+00,1.2E+05,2.0E+00===2.0E+00,2.0E+00,0.0E+00,2.0E+00===" }
  double4 var1 = (double4) (1.0,-1.23,123455.134,2.0);
  double4 var2 = (double4) (2.0,2.0,0.0,2.0);
  int i = printf("double4_e_1209c===%-.1v4lE===%-.1v4lE===\n",var1,var2);
  return i;
}

int double4_e_1210c() {
  // { dg-printf "double4_e_1210c===-1.23E+04,2.00E+00,1.00E+00,1.23E+05===-1.23E+00,1.00E+00,1.23E+05,1.23E+05===" }
  double4 var1 = (double4) (-12345.032,2.0,1.0,123455.134);
  double4 var2 = (double4) (-1.23,1.0,123455.134,123455.134);
  int i = printf("double4_e_1210c===%-.2v4lE===%-.2v4lE===\n",var1,var2);
  return i;
}

int double4_e_1211c() {
  // { dg-printf "double4_e_1211c===0.000E+00,-1.235E+04,1.000E+00,0.000E+00===2.000E+00,1.000E+00,0.000E+00,0.000E+00===" }
  double4 var1 = (double4) (0.0,-12345.032,1.0,0.0);
  double4 var2 = (double4) (2.0,1.0,0.0,0.0);
  int i = printf("double4_e_1211c===%-.3v4lE===%-.3v4lE===\n",var1,var2);
  return i;
}

int double4_e_1212c() {
  // { dg-printf "double4_e_1212c===1.0000000000E+00,0.0000000000E+00,2.0000000000E+00,2.0000000000E+00===2.0000000000E+00,-1.2345032000E+04,-1.2345032000E+04,0.0000000000E+00===" }
  double4 var1 = (double4) (1.0,0.0,2.0,2.0);
  double4 var2 = (double4) (2.0,-12345.032,-12345.032,0.0);
  int i = printf("double4_e_1212c===%-.10v4lE===%-.10v4lE===\n",var1,var2);
  return i;
}

int double4_e_1963c() {
  // { dg-printf "double4_e_1963c===+1.234551e+05,+1.000000e+00,-1.230000e+00,+1.000000e+00===-1.234503e+04,+1.000000e+00,-1.230000e+00,-1.234503e+04===" }
  double4 var1 = (double4) (123455.134,1.0,-1.23,1.0);
  double4 var2 = (double4) (-12345.032,1.0,-1.23,-12345.032);
  int i = printf("double4_e_1963c===%+v4le===%+v4le===\n",var1,var2);
  return i;
}

int double4_e_1964c() {
  // { dg-printf "double4_e_1964c===-1.2e+00,+2.0e+00,-1.2e+04,+0.0e+00===+1.0e+00,+0.0e+00,+1.0e+00,+0.0e+00===" }
  double4 var1 = (double4) (-1.23,2.0,-12345.032,0.0);
  double4 var2 = (double4) (1.0,0.0,1.0,0.0);
  int i = printf("double4_e_1964c===%+.1v4le===%+.1v4le===\n",var1,var2);
  return i;
}

int double4_e_1965c() {
  // { dg-printf "double4_e_1965c===-1.23e+04,+2.00e+00,+2.00e+00,-1.23e+04===+0.00e+00,+1.23e+05,-1.23e+04,-1.23e+04===" }
  double4 var1 = (double4) (-12345.032,2.0,2.0,-12345.032);
  double4 var2 = (double4) (0.0,123455.134,-12345.032,-12345.032);
  int i = printf("double4_e_1965c===%+.2v4le===%+.2v4le===\n",var1,var2);
  return i;
}

int double4_e_1966c() {
  // { dg-printf "double4_e_1966c===+2.000e+00,-1.235e+04,+1.000e+00,-1.235e+04===+1.000e+00,-1.230e+00,+1.235e+05,+2.000e+00===" }
  double4 var1 = (double4) (2.0,-12345.032,1.0,-12345.032);
  double4 var2 = (double4) (1.0,-1.23,123455.134,2.0);
  int i = printf("double4_e_1966c===%+.3v4le===%+.3v4le===\n",var1,var2);
  return i;
}

int double4_e_1967c() {
  // { dg-printf "double4_e_1967c===+1.0000000000e+00,-1.2345032000e+04,+1.0000000000e+00,+1.2345513400e+05===-1.2300000000e+00,+2.0000000000e+00,+0.0000000000e+00,+2.0000000000e+00===" }
  double4 var1 = (double4) (1.0,-12345.032,1.0,123455.134);
  double4 var2 = (double4) (-1.23,2.0,0.0,2.0);
  int i = printf("double4_e_1967c===%+.10v4le===%+.10v4le===\n",var1,var2);
  return i;
}

int double4_e_1968c() {
  // { dg-printf "double4_e_1968c===+2.000000E+00,+0.000000E+00,+2.000000E+00,-1.230000E+00===-1.230000E+00,+1.000000E+00,+0.000000E+00,+1.000000E+00===" }
  double4 var1 = (double4) (2.0,0.0,2.0,-1.23);
  double4 var2 = (double4) (-1.23,1.0,0.0,1.0);
  int i = printf("double4_e_1968c===%+v4lE===%+v4lE===\n",var1,var2);
  return i;
}

int double4_e_1969c() {
  // { dg-printf "double4_e_1969c===+0.0E+00,+0.0E+00,+1.2E+05,-1.2E+04===+1.2E+05,-1.2E+00,+1.0E+00,+1.2E+05===" }
  double4 var1 = (double4) (0.0,0.0,123455.134,-12345.032);
  double4 var2 = (double4) (123455.134,-1.23,1.0,123455.134);
  int i = printf("double4_e_1969c===%+.1v4lE===%+.1v4lE===\n",var1,var2);
  return i;
}

int double4_e_1970c() {
  // { dg-printf "double4_e_1970c===+2.00E+00,-1.23E+00,+1.23E+05,+0.00E+00===+1.00E+00,-1.23E+04,-1.23E+00,-1.23E+04===" }
  double4 var1 = (double4) (2.0,-1.23,123455.134,0.0);
  double4 var2 = (double4) (1.0,-12345.032,-1.23,-12345.032);
  int i = printf("double4_e_1970c===%+.2v4lE===%+.2v4lE===\n",var1,var2);
  return i;
}

int double4_e_1971c() {
  // { dg-printf "double4_e_1971c===+2.000E+00,+2.000E+00,+0.000E+00,+1.235E+05===+2.000E+00,-1.235E+04,+1.000E+00,+2.000E+00===" }
  double4 var1 = (double4) (2.0,2.0,0.0,123455.134);
  double4 var2 = (double4) (2.0,-12345.032,1.0,2.0);
  int i = printf("double4_e_1971c===%+.3v4lE===%+.3v4lE===\n",var1,var2);
  return i;
}

int double4_e_1972c() {
  // { dg-printf "double4_e_1972c===+2.0000000000E+00,+1.0000000000E+00,+1.0000000000E+00,-1.2300000000E+00===+2.0000000000E+00,+1.2345513400E+05,+1.2345513400E+05,-1.2300000000E+00===" }
  double4 var1 = (double4) (2.0,1.0,1.0,-1.23);
  double4 var2 = (double4) (2.0,123455.134,123455.134,-1.23);
  int i = printf("double4_e_1972c===%+.10v4lE===%+.10v4lE===\n",var1,var2);
  return i;
}

int double4_e_2723c() {
  // { dg-printf "double4_e_2723c===2.000000e+00,0.000000e+00,2.000000e+00,0.000000e+00===-1.234503e+04,1.234551e+05,1.000000e+00,0.000000e+00===" }
  double4 var1 = (double4) (2.0,0.0,2.0,0.0);
  double4 var2 = (double4) (-12345.032,123455.134,1.0,0.0);
  int i = printf("double4_e_2723c===%#v4le===%#v4le===\n",var1,var2);
  return i;
}

int double4_e_2724c() {
  // { dg-printf "double4_e_2724c===1.2e+05,1.0e+00,0.0e+00,2.0e+00===-1.2e+04,-1.2e+04,0.0e+00,1.2e+05===" }
  double4 var1 = (double4) (123455.134,1.0,0.0,2.0);
  double4 var2 = (double4) (-12345.032,-12345.032,0.0,123455.134);
  int i = printf("double4_e_2724c===%#.1v4le===%#.1v4le===\n",var1,var2);
  return i;
}

int double4_e_2725c() {
  // { dg-printf "double4_e_2725c===2.00e+00,1.23e+05,-1.23e+00,2.00e+00===2.00e+00,0.00e+00,1.00e+00,-1.23e+04===" }
  double4 var1 = (double4) (2.0,123455.134,-1.23,2.0);
  double4 var2 = (double4) (2.0,0.0,1.0,-12345.032);
  int i = printf("double4_e_2725c===%#.2v4le===%#.2v4le===\n",var1,var2);
  return i;
}

int double4_e_2726c() {
  // { dg-printf "double4_e_2726c===-1.230e+00,2.000e+00,-1.230e+00,0.000e+00===-1.235e+04,-1.230e+00,0.000e+00,1.235e+05===" }
  double4 var1 = (double4) (-1.23,2.0,-1.23,0.0);
  double4 var2 = (double4) (-12345.032,-1.23,0.0,123455.134);
  int i = printf("double4_e_2726c===%#.3v4le===%#.3v4le===\n",var1,var2);
  return i;
}

int double4_e_2727c() {
  // { dg-printf "double4_e_2727c===-1.2345032000e+04,-1.2345032000e+04,-1.2300000000e+00,-1.2300000000e+00===-1.2300000000e+00,0.0000000000e+00,-1.2345032000e+04,1.0000000000e+00===" }
  double4 var1 = (double4) (-12345.032,-12345.032,-1.23,-1.23);
  double4 var2 = (double4) (-1.23,0.0,-12345.032,1.0);
  int i = printf("double4_e_2727c===%#.10v4le===%#.10v4le===\n",var1,var2);
  return i;
}

int double4_e_2728c() {
  // { dg-printf "double4_e_2728c===-1.234503E+04,-1.234503E+04,-1.234503E+04,1.000000E+00===1.000000E+00,-1.234503E+04,1.234551E+05,-1.234503E+04===" }
  double4 var1 = (double4) (-12345.032,-12345.032,-12345.032,1.0);
  double4 var2 = (double4) (1.0,-12345.032,123455.134,-12345.032);
  int i = printf("double4_e_2728c===%#v4lE===%#v4lE===\n",var1,var2);
  return i;
}

int double4_e_2729c() {
  // { dg-printf "double4_e_2729c===1.2E+05,2.0E+00,2.0E+00,2.0E+00===-1.2E+00,1.2E+05,2.0E+00,1.0E+00===" }
  double4 var1 = (double4) (123455.134,2.0,2.0,2.0);
  double4 var2 = (double4) (-1.23,123455.134,2.0,1.0);
  int i = printf("double4_e_2729c===%#.1v4lE===%#.1v4lE===\n",var1,var2);
  return i;
}

int double4_e_2730c() {
  // { dg-printf "double4_e_2730c===0.00E+00,2.00E+00,2.00E+00,-1.23E+00===2.00E+00,1.23E+05,-1.23E+04,-1.23E+04===" }
  double4 var1 = (double4) (0.0,2.0,2.0,-1.23);
  double4 var2 = (double4) (2.0,123455.134,-12345.032,-12345.032);
  int i = printf("double4_e_2730c===%#.2v4lE===%#.2v4lE===\n",var1,var2);
  return i;
}

int double4_e_2731c() {
  // { dg-printf "double4_e_2731c===1.235E+05,1.000E+00,-1.230E+00,1.235E+05===1.000E+00,-1.230E+00,2.000E+00,1.235E+05===" }
  double4 var1 = (double4) (123455.134,1.0,-1.23,123455.134);
  double4 var2 = (double4) (1.0,-1.23,2.0,123455.134);
  int i = printf("double4_e_2731c===%#.3v4lE===%#.3v4lE===\n",var1,var2);
  return i;
}

int double4_e_2732c() {
  // { dg-printf "double4_e_2732c===2.0000000000E+00,-1.2300000000E+00,-1.2300000000E+00,-1.2345032000E+04===1.2345513400E+05,1.0000000000E+00,2.0000000000E+00,-1.2345032000E+04===" }
  double4 var1 = (double4) (2.0,-1.23,-1.23,-12345.032);
  double4 var2 = (double4) (123455.134,1.0,2.0,-12345.032);
  int i = printf("double4_e_2732c===%#.10v4lE===%#.10v4lE===\n",var1,var2);
  return i;
}

int double4_e_3483c() {
  // { dg-printf "double4_e_3483c===-1.230000e+00,+2.000000e+00,+1.000000e+00,-1.230000e+00===-1.230000e+00,-1.230000e+00,+2.000000e+00,+0.000000e+00===" }
  double4 var1 = (double4) (-1.23,2.0,1.0,-1.23);
  double4 var2 = (double4) (-1.23,-1.23,2.0,0.0);
  int i = printf("double4_e_3483c===%-+v4le===%-+v4le===\n",var1,var2);
  return i;
}

int double4_e_3484c() {
  // { dg-printf "double4_e_3484c===+1.0e+00,-1.2e+00,+2.0e+00,-1.2e+00===+1.0e+00,-1.2e+00,+1.0e+00,+2.0e+00===" }
  double4 var1 = (double4) (1.0,-1.23,2.0,-1.23);
  double4 var2 = (double4) (1.0,-1.23,1.0,2.0);
  int i = printf("double4_e_3484c===%-+.1v4le===%-+.1v4le===\n",var1,var2);
  return i;
}

int double4_e_3485c() {
  // { dg-printf "double4_e_3485c===-1.23e+00,+1.23e+05,+2.00e+00,-1.23e+04===+1.23e+05,+1.00e+00,+1.00e+00,-1.23e+04===" }
  double4 var1 = (double4) (-1.23,123455.134,2.0,-12345.032);
  double4 var2 = (double4) (123455.134,1.0,1.0,-12345.032);
  int i = printf("double4_e_3485c===%-+.2v4le===%-+.2v4le===\n",var1,var2);
  return i;
}

int double4_e_3486c() {
  // { dg-printf "double4_e_3486c===-1.235e+04,+1.235e+05,-1.235e+04,-1.230e+00===+1.235e+05,+1.235e+05,-1.230e+00,+1.235e+05===" }
  double4 var1 = (double4) (-12345.032,123455.134,-12345.032,-1.23);
  double4 var2 = (double4) (123455.134,123455.134,-1.23,123455.134);
  int i = printf("double4_e_3486c===%-+.3v4le===%-+.3v4le===\n",var1,var2);
  return i;
}

int double4_e_3487c() {
  // { dg-printf "double4_e_3487c===-1.2300000000e+00,+1.0000000000e+00,-1.2345032000e+04,+2.0000000000e+00===+0.0000000000e+00,+0.0000000000e+00,+1.0000000000e+00,-1.2300000000e+00===" }
  double4 var1 = (double4) (-1.23,1.0,-12345.032,2.0);
  double4 var2 = (double4) (0.0,0.0,1.0,-1.23);
  int i = printf("double4_e_3487c===%-+.10v4le===%-+.10v4le===\n",var1,var2);
  return i;
}

int double4_e_3488c() {
  // { dg-printf "double4_e_3488c===-1.230000E+00,+1.234551E+05,-1.234503E+04,+0.000000E+00===+1.000000E+00,-1.230000E+00,-1.230000E+00,+2.000000E+00===" }
  double4 var1 = (double4) (-1.23,123455.134,-12345.032,0.0);
  double4 var2 = (double4) (1.0,-1.23,-1.23,2.0);
  int i = printf("double4_e_3488c===%-+v4lE===%-+v4lE===\n",var1,var2);
  return i;
}

int double4_e_3489c() {
  // { dg-printf "double4_e_3489c===+0.0E+00,+2.0E+00,+1.2E+05,+1.0E+00===+0.0E+00,+0.0E+00,-1.2E+04,-1.2E+04===" }
  double4 var1 = (double4) (0.0,2.0,123455.134,1.0);
  double4 var2 = (double4) (0.0,0.0,-12345.032,-12345.032);
  int i = printf("double4_e_3489c===%-+.1v4lE===%-+.1v4lE===\n",var1,var2);
  return i;
}

int double4_e_3490c() {
  // { dg-printf "double4_e_3490c===-1.23E+04,+2.00E+00,+0.00E+00,+2.00E+00===+1.00E+00,+1.23E+05,-1.23E+00,-1.23E+00===" }
  double4 var1 = (double4) (-12345.032,2.0,0.0,2.0);
  double4 var2 = (double4) (1.0,123455.134,-1.23,-1.23);
  int i = printf("double4_e_3490c===%-+.2v4lE===%-+.2v4lE===\n",var1,var2);
  return i;
}

int double4_e_3491c() {
  // { dg-printf "double4_e_3491c===+1.000E+00,-1.230E+00,+0.000E+00,+1.235E+05===+2.000E+00,-1.235E+04,-1.235E+04,+1.000E+00===" }
  double4 var1 = (double4) (1.0,-1.23,0.0,123455.134);
  double4 var2 = (double4) (2.0,-12345.032,-12345.032,1.0);
  int i = printf("double4_e_3491c===%-+.3v4lE===%-+.3v4lE===\n",var1,var2);
  return i;
}

int double4_e_3492c() {
  // { dg-printf "double4_e_3492c===+2.0000000000E+00,+0.0000000000E+00,-1.2300000000E+00,+1.2345513400E+05===+1.2345513400E+05,-1.2300000000E+00,-1.2345032000E+04,+1.0000000000E+00===" }
  double4 var1 = (double4) (2.0,0.0,-1.23,123455.134);
  double4 var2 = (double4) (123455.134,-1.23,-12345.032,1.0);
  int i = printf("double4_e_3492c===%-+.10v4lE===%-+.10v4lE===\n",var1,var2);
  return i;
}

int double4_e_4243c() {
  // { dg-printf "double4_e_4243c=== 2.000000e+00, 1.000000e+00,-1.230000e+00, 2.000000e+00===-1.234503e+04, 0.000000e+00,-1.230000e+00,-1.230000e+00===" }
  double4 var1 = (double4) (2.0,1.0,-1.23,2.0);
  double4 var2 = (double4) (-12345.032,0.0,-1.23,-1.23);
  int i = printf("double4_e_4243c===% 10v4le===% 10v4le===\n",var1,var2);
  return i;
}

int double4_e_4244c() {
  // { dg-printf "double4_e_4244c===  -1.2e+00,   1.0e+00,  -1.2e+00,  -1.2e+04===   2.0e+00,   1.0e+00,   0.0e+00,   0.0e+00===" }
  double4 var1 = (double4) (-1.23,1.0,-1.23,-12345.032);
  double4 var2 = (double4) (2.0,1.0,0.0,0.0);
  int i = printf("double4_e_4244c===% 10.1v4le===% 10.1v4le===\n",var1,var2);
  return i;
}

int double4_e_4245c() {
  // { dg-printf "double4_e_4245c===  2.00e+00, -1.23e+04,  0.00e+00, -1.23e+00=== -1.23e+04,  1.00e+00,  1.00e+00,  1.00e+00===" }
  double4 var1 = (double4) (2.0,-12345.032,0.0,-1.23);
  double4 var2 = (double4) (-12345.032,1.0,1.0,1.0);
  int i = printf("double4_e_4245c===% 10.2v4le===% 10.2v4le===\n",var1,var2);
  return i;
}

int double4_e_4246c() {
  // { dg-printf "double4_e_4246c=== 2.000e+00, 1.000e+00, 1.235e+05, 1.000e+00=== 1.235e+05, 1.235e+05, 1.000e+00, 2.000e+00===" }
  double4 var1 = (double4) (2.0,1.0,123455.134,1.0);
  double4 var2 = (double4) (123455.134,123455.134,1.0,2.0);
  int i = printf("double4_e_4246c===% 10.3v4le===% 10.3v4le===\n",var1,var2);
  return i;
}

int double4_e_4247c() {
  // { dg-printf "double4_e_4247c=== 0.0000000000e+00, 1.0000000000e+00, 1.2345513400e+05, 1.2345513400e+05=== 1.0000000000e+00,-1.2345032000e+04, 0.0000000000e+00,-1.2345032000e+04===" }
  double4 var1 = (double4) (0.0,1.0,123455.134,123455.134);
  double4 var2 = (double4) (1.0,-12345.032,0.0,-12345.032);
  int i = printf("double4_e_4247c===% 10.10v4le===% 10.10v4le===\n",var1,var2);
  return i;
}

int double4_e_4248c() {
  // { dg-printf "double4_e_4248c===-1.230000E+00,-1.230000E+00, 1.234551E+05,-1.230000E+00===-1.234503E+04, 2.000000E+00, 2.000000E+00, 0.000000E+00===" }
  double4 var1 = (double4) (-1.23,-1.23,123455.134,-1.23);
  double4 var2 = (double4) (-12345.032,2.0,2.0,0.0);
  int i = printf("double4_e_4248c===% 10v4lE===% 10v4lE===\n",var1,var2);
  return i;
}

int double4_e_4249c() {
  // { dg-printf "double4_e_4249c===  -1.2E+00,   2.0E+00,  -1.2E+04,   0.0E+00===   2.0E+00,   2.0E+00,   2.0E+00,   1.0E+00===" }
  double4 var1 = (double4) (-1.23,2.0,-12345.032,0.0);
  double4 var2 = (double4) (2.0,2.0,2.0,1.0);
  int i = printf("double4_e_4249c===% 10.1v4lE===% 10.1v4lE===\n",var1,var2);
  return i;
}

int double4_e_4250c() {
  // { dg-printf "double4_e_4250c=== -1.23E+04,  2.00E+00, -1.23E+00,  1.00E+00===  0.00E+00, -1.23E+04,  1.23E+05, -1.23E+00===" }
  double4 var1 = (double4) (-12345.032,2.0,-1.23,1.0);
  double4 var2 = (double4) (0.0,-12345.032,123455.134,-1.23);
  int i = printf("double4_e_4250c===% 10.2v4lE===% 10.2v4lE===\n",var1,var2);
  return i;
}

int double4_e_4251c() {
  // { dg-printf "double4_e_4251c===-1.230E+00,-1.230E+00,-1.235E+04, 1.235E+05=== 1.235E+05, 0.000E+00, 1.235E+05, 2.000E+00===" }
  double4 var1 = (double4) (-1.23,-1.23,-12345.032,123455.134);
  double4 var2 = (double4) (123455.134,0.0,123455.134,2.0);
  int i = printf("double4_e_4251c===% 10.3v4lE===% 10.3v4lE===\n",var1,var2);
  return i;
}

int double4_e_4252c() {
  // { dg-printf "double4_e_4252c===-1.2345032000E+04, 0.0000000000E+00, 0.0000000000E+00, 2.0000000000E+00=== 1.2345513400E+05,-1.2300000000E+00,-1.2300000000E+00,-1.2345032000E+04===" }
  double4 var1 = (double4) (-12345.032,0.0,0.0,2.0);
  double4 var2 = (double4) (123455.134,-1.23,-1.23,-12345.032);
  int i = printf("double4_e_4252c===% 10.10v4lE===% 10.10v4lE===\n",var1,var2);
  return i;
}

int double4_e_443c() {
  // { dg-printf "double4_e_443c===1.234551e+05,2.000000e+00,2.000000e+00,-1.230000e+00===0.000000e+00,1.000000e+00,-1.230000e+00,1.234551e+05===" }
  double4 var1 = (double4) (123455.134,2.0,2.0,-1.23);
  double4 var2 = (double4) (0.0,1.0,-1.23,123455.134);
  int i = printf("double4_e_443c===%v4le===%v4le===\n",var1,var2);
  return i;
}

int double4_e_444c() {
  // { dg-printf "double4_e_444c===-1.2e+00,1.2e+05,-1.2e+04,1.0e+00===1.0e+00,2.0e+00,-1.2e+00,0.0e+00===" }
  double4 var1 = (double4) (-1.23,123455.134,-12345.032,1.0);
  double4 var2 = (double4) (1.0,2.0,-1.23,0.0);
  int i = printf("double4_e_444c===%.1v4le===%.1v4le===\n",var1,var2);
  return i;
}

int double4_e_445c() {
  // { dg-printf "double4_e_445c===-1.23e+04,1.00e+00,1.23e+05,0.00e+00===2.00e+00,1.23e+05,-1.23e+04,2.00e+00===" }
  double4 var1 = (double4) (-12345.032,1.0,123455.134,0.0);
  double4 var2 = (double4) (2.0,123455.134,-12345.032,2.0);
  int i = printf("double4_e_445c===%.2v4le===%.2v4le===\n",var1,var2);
  return i;
}

int double4_e_446c() {
  // { dg-printf "double4_e_446c===-1.230e+00,-1.235e+04,-1.235e+04,2.000e+00===-1.235e+04,-1.235e+04,2.000e+00,1.235e+05===" }
  double4 var1 = (double4) (-1.23,-12345.032,-12345.032,2.0);
  double4 var2 = (double4) (-12345.032,-12345.032,2.0,123455.134);
  int i = printf("double4_e_446c===%.3v4le===%.3v4le===\n",var1,var2);
  return i;
}

int double4_e_447c() {
  // { dg-printf "double4_e_447c===1.0000000000e+00,-1.2345032000e+04,1.0000000000e+00,1.2345513400e+05===1.0000000000e+00,1.0000000000e+00,2.0000000000e+00,-1.2345032000e+04===" }
  double4 var1 = (double4) (1.0,-12345.032,1.0,123455.134);
  double4 var2 = (double4) (1.0,1.0,2.0,-12345.032);
  int i = printf("double4_e_447c===%.10v4le===%.10v4le===\n",var1,var2);
  return i;
}

int double4_e_448c() {
  // { dg-printf "double4_e_448c===0.000000E+00,1.000000E+00,1.234551E+05,1.234551E+05===0.000000E+00,1.000000E+00,-1.230000E+00,-1.234503E+04===" }
  double4 var1 = (double4) (0.0,1.0,123455.134,123455.134);
  double4 var2 = (double4) (0.0,1.0,-1.23,-12345.032);
  int i = printf("double4_e_448c===%v4lE===%v4lE===\n",var1,var2);
  return i;
}

int double4_e_449c() {
  // { dg-printf "double4_e_449c===1.2E+05,-1.2E+04,2.0E+00,1.0E+00===1.2E+05,1.2E+05,-1.2E+04,0.0E+00===" }
  double4 var1 = (double4) (123455.134,-12345.032,2.0,1.0);
  double4 var2 = (double4) (123455.134,123455.134,-12345.032,0.0);
  int i = printf("double4_e_449c===%.1v4lE===%.1v4lE===\n",var1,var2);
  return i;
}

int double4_e_450c() {
  // { dg-printf "double4_e_450c===2.00E+00,2.00E+00,-1.23E+04,0.00E+00===1.23E+05,2.00E+00,0.00E+00,-1.23E+04===" }
  double4 var1 = (double4) (2.0,2.0,-12345.032,0.0);
  double4 var2 = (double4) (123455.134,2.0,0.0,-12345.032);
  int i = printf("double4_e_450c===%.2v4lE===%.2v4lE===\n",var1,var2);
  return i;
}

int double4_e_451c() {
  // { dg-printf "double4_e_451c===1.235E+05,1.000E+00,2.000E+00,-1.230E+00===-1.230E+00,-1.230E+00,-1.235E+04,1.235E+05===" }
  double4 var1 = (double4) (123455.134,1.0,2.0,-1.23);
  double4 var2 = (double4) (-1.23,-1.23,-12345.032,123455.134);
  int i = printf("double4_e_451c===%.3v4lE===%.3v4lE===\n",var1,var2);
  return i;
}

int double4_e_452c() {
  // { dg-printf "double4_e_452c===1.0000000000E+00,1.2345513400E+05,1.2345513400E+05,2.0000000000E+00===-1.2345032000E+04,2.0000000000E+00,-1.2300000000E+00,-1.2300000000E+00===" }
  double4 var1 = (double4) (1.0,123455.134,123455.134,2.0);
  double4 var2 = (double4) (-12345.032,2.0,-1.23,-1.23);
  int i = printf("double4_e_452c===%.10v4lE===%.10v4lE===\n",var1,var2);
  return i;
}

int double4_e_5003c() {
  // { dg-printf "double4_e_5003c===-1.230000e+00,1.000000e+00,0.000000e+00,1.234551e+05===-1.230000e+00,1.234551e+05,1.000000e+00,-1.234503e+04===" }
  double4 var1 = (double4) (-1.23,1.0,0.0,123455.134);
  double4 var2 = (double4) (-1.23,123455.134,1.0,-12345.032);
  int i = printf("double4_e_5003c===%010v4le===%010v4le===\n",var1,var2);
  return i;
}

int double4_e_5004c() {
  // { dg-printf "double4_e_5004c===0001.2e+05,0000.0e+00,0001.0e+00,-001.2e+04===-001.2e+04,0001.0e+00,0002.0e+00,0001.0e+00===" }
  double4 var1 = (double4) (123455.134,0.0,1.0,-12345.032);
  double4 var2 = (double4) (-12345.032,1.0,2.0,1.0);
  int i = printf("double4_e_5004c===%010.1v4le===%010.1v4le===\n",var1,var2);
  return i;
}

int double4_e_5005c() {
  // { dg-printf "double4_e_5005c===-01.23e+00,001.23e+05,001.23e+05,002.00e+00===002.00e+00,001.23e+05,001.00e+00,002.00e+00===" }
  double4 var1 = (double4) (-1.23,123455.134,123455.134,2.0);
  double4 var2 = (double4) (2.0,123455.134,1.0,2.0);
  int i = printf("double4_e_5005c===%010.2v4le===%010.2v4le===\n",var1,var2);
  return i;
}

int double4_e_5006c() {
  // { dg-printf "double4_e_5006c===01.235e+05,00.000e+00,-1.230e+00,-1.235e+04===01.235e+05,02.000e+00,01.000e+00,02.000e+00===" }
  double4 var1 = (double4) (123455.134,0.0,-1.23,-12345.032);
  double4 var2 = (double4) (123455.134,2.0,1.0,2.0);
  int i = printf("double4_e_5006c===%010.3v4le===%010.3v4le===\n",var1,var2);
  return i;
}

int double4_e_5007c() {
  // { dg-printf "double4_e_5007c===0.0000000000e+00,-1.2300000000e+00,1.2345513400e+05,2.0000000000e+00===-1.2345032000e+04,-1.2300000000e+00,1.0000000000e+00,1.2345513400e+05===" }
  double4 var1 = (double4) (0.0,-1.23,123455.134,2.0);
  double4 var2 = (double4) (-12345.032,-1.23,1.0,123455.134);
  int i = printf("double4_e_5007c===%010.10v4le===%010.10v4le===\n",var1,var2);
  return i;
}

int double4_e_5008c() {
  // { dg-printf "double4_e_5008c===-1.234503E+04,-1.234503E+04,0.000000E+00,2.000000E+00===-1.234503E+04,0.000000E+00,-1.234503E+04,2.000000E+00===" }
  double4 var1 = (double4) (-12345.032,-12345.032,0.0,2.0);
  double4 var2 = (double4) (-12345.032,0.0,-12345.032,2.0);
  int i = printf("double4_e_5008c===%010v4lE===%010v4lE===\n",var1,var2);
  return i;
}

int double4_e_5009c() {
  // { dg-printf "double4_e_5009c===0001.2E+05,0000.0E+00,0001.2E+05,0002.0E+00===0001.2E+05,0001.0E+00,-001.2E+00,0002.0E+00===" }
  double4 var1 = (double4) (123455.134,0.0,123455.134,2.0);
  double4 var2 = (double4) (123455.134,1.0,-1.23,2.0);
  int i = printf("double4_e_5009c===%010.1v4lE===%010.1v4lE===\n",var1,var2);
  return i;
}

int double4_e_5010c() {
  // { dg-printf "double4_e_5010c===-01.23E+00,-01.23E+04,001.00E+00,-01.23E+04===002.00E+00,001.00E+00,-01.23E+04,001.00E+00===" }
  double4 var1 = (double4) (-1.23,-12345.032,1.0,-12345.032);
  double4 var2 = (double4) (2.0,1.0,-12345.032,1.0);
  int i = printf("double4_e_5010c===%010.2v4lE===%010.2v4lE===\n",var1,var2);
  return i;
}

int double4_e_5011c() {
  // { dg-printf "double4_e_5011c===-1.235E+04,-1.230E+00,00.000E+00,-1.235E+04===-1.230E+00,-1.235E+04,01.235E+05,01.000E+00===" }
  double4 var1 = (double4) (-12345.032,-1.23,0.0,-12345.032);
  double4 var2 = (double4) (-1.23,-12345.032,123455.134,1.0);
  int i = printf("double4_e_5011c===%010.3v4lE===%010.3v4lE===\n",var1,var2);
  return i;
}

int double4_e_5012c() {
  // { dg-printf "double4_e_5012c===-1.2345032000E+04,1.0000000000E+00,-1.2345032000E+04,1.0000000000E+00===2.0000000000E+00,2.0000000000E+00,0.0000000000E+00,1.2345513400E+05===" }
  double4 var1 = (double4) (-12345.032,1.0,-12345.032,1.0);
  double4 var2 = (double4) (2.0,2.0,0.0,123455.134);
  int i = printf("double4_e_5012c===%010.10v4lE===%010.10v4lE===\n",var1,var2);
  return i;
}

int double4_e_5763c() {
  // { dg-printf "double4_e_5763c=== 1.000000e+00,-1.234503e+04, 0.000000e+00, 2.000000e+00=== 1.000000e+00,-1.230000e+00,-1.230000e+00, 1.000000e+00===" }
  double4 var1 = (double4) (1.0,-12345.032,0.0,2.0);
  double4 var2 = (double4) (1.0,-1.23,-1.23,1.0);
  int i = printf("double4_e_5763c===%- 10v4le===%- 10v4le===\n",var1,var2);
  return i;
}

int double4_e_5764c() {
  // { dg-printf "double4_e_5764c=== 1.2e+05  , 1.2e+05  ,-1.2e+04  , 1.0e+00  === 2.0e+00  , 2.0e+00  ,-1.2e+04  ,-1.2e+04  ===" }
  double4 var1 = (double4) (123455.134,123455.134,-12345.032,1.0);
  double4 var2 = (double4) (2.0,2.0,-12345.032,-12345.032);
  int i = printf("double4_e_5764c===%- 10.1v4le===%- 10.1v4le===\n",var1,var2);
  return i;
}

int double4_e_5765c() {
  // { dg-printf "double4_e_5765c===-1.23e+04 ,-1.23e+00 , 0.00e+00 ,-1.23e+04 === 2.00e+00 , 1.23e+05 ,-1.23e+04 , 2.00e+00 ===" }
  double4 var1 = (double4) (-12345.032,-1.23,0.0,-12345.032);
  double4 var2 = (double4) (2.0,123455.134,-12345.032,2.0);
  int i = printf("double4_e_5765c===%- 10.2v4le===%- 10.2v4le===\n",var1,var2);
  return i;
}

int double4_e_5766c() {
  // { dg-printf "double4_e_5766c===-1.235e+04,-1.230e+00, 1.000e+00, 1.000e+00=== 1.235e+05,-1.230e+00,-1.235e+04, 0.000e+00===" }
  double4 var1 = (double4) (-12345.032,-1.23,1.0,1.0);
  double4 var2 = (double4) (123455.134,-1.23,-12345.032,0.0);
  int i = printf("double4_e_5766c===%- 10.3v4le===%- 10.3v4le===\n",var1,var2);
  return i;
}

int double4_e_5767c() {
  // { dg-printf "double4_e_5767c===-1.2345032000e+04, 2.0000000000e+00, 2.0000000000e+00, 1.0000000000e+00=== 2.0000000000e+00,-1.2345032000e+04,-1.2345032000e+04, 2.0000000000e+00===" }
  double4 var1 = (double4) (-12345.032,2.0,2.0,1.0);
  double4 var2 = (double4) (2.0,-12345.032,-12345.032,2.0);
  int i = printf("double4_e_5767c===%- 10.10v4le===%- 10.10v4le===\n",var1,var2);
  return i;
}

int double4_e_5768c() {
  // { dg-printf "double4_e_5768c===-1.234503E+04, 1.234551E+05, 0.000000E+00,-1.230000E+00=== 0.000000E+00,-1.234503E+04,-1.234503E+04,-1.230000E+00===" }
  double4 var1 = (double4) (-12345.032,123455.134,0.0,-1.23);
  double4 var2 = (double4) (0.0,-12345.032,-12345.032,-1.23);
  int i = printf("double4_e_5768c===%- 10v4lE===%- 10v4lE===\n",var1,var2);
  return i;
}

int double4_e_5769c() {
  // { dg-printf "double4_e_5769c=== 1.0E+00  , 2.0E+00  , 1.2E+05  , 1.2E+05  ===-1.2E+00  , 1.2E+05  ,-1.2E+00  , 1.2E+05  ===" }
  double4 var1 = (double4) (1.0,2.0,123455.134,123455.134);
  double4 var2 = (double4) (-1.23,123455.134,-1.23,123455.134);
  int i = printf("double4_e_5769c===%- 10.1v4lE===%- 10.1v4lE===\n",var1,var2);
  return i;
}

int double4_e_5770c() {
  // { dg-printf "double4_e_5770c===-1.23E+00 , 0.00E+00 , 0.00E+00 , 0.00E+00 ===-1.23E+00 ,-1.23E+00 , 2.00E+00 , 1.23E+05 ===" }
  double4 var1 = (double4) (-1.23,0.0,0.0,0.0);
  double4 var2 = (double4) (-1.23,-1.23,2.0,123455.134);
  int i = printf("double4_e_5770c===%- 10.2v4lE===%- 10.2v4lE===\n",var1,var2);
  return i;
}

int double4_e_5771c() {
  // { dg-printf "double4_e_5771c=== 1.000E+00, 1.000E+00, 2.000E+00, 2.000E+00=== 0.000E+00, 1.000E+00,-1.235E+04, 1.235E+05===" }
  double4 var1 = (double4) (1.0,1.0,2.0,2.0);
  double4 var2 = (double4) (0.0,1.0,-12345.032,123455.134);
  int i = printf("double4_e_5771c===%- 10.3v4lE===%- 10.3v4lE===\n",var1,var2);
  return i;
}

int double4_e_5772c() {
  // { dg-printf "double4_e_5772c=== 1.0000000000E+00, 0.0000000000E+00, 0.0000000000E+00, 2.0000000000E+00=== 1.2345513400E+05, 0.0000000000E+00,-1.2345032000E+04, 1.0000000000E+00===" }
  double4 var1 = (double4) (1.0,0.0,0.0,2.0);
  double4 var2 = (double4) (123455.134,0.0,-12345.032,1.0);
  int i = printf("double4_e_5772c===%- 10.10v4lE===%- 10.10v4lE===\n",var1,var2);
  return i;
}

int double4_e_6523c() {
  // { dg-printf "double4_e_6523c===-1.230000e+00,+1.234551e+05,+1.000000e+00,+0.000000e+00===+0.000000e+00,+2.000000e+00,-1.230000e+00,-1.230000e+00===" }
  double4 var1 = (double4) (-1.23,123455.134,1.0,0.0);
  double4 var2 = (double4) (0.0,2.0,-1.23,-1.23);
  int i = printf("double4_e_6523c===%+ 10v4le===%+ 10v4le===\n",var1,var2);
  return i;
}

int double4_e_6524c() {
  // { dg-printf "double4_e_6524c===  +1.2e+05,  -1.2e+00,  +0.0e+00,  +1.0e+00===  +1.2e+05,  +0.0e+00,  -1.2e+00,  +1.2e+05===" }
  double4 var1 = (double4) (123455.134,-1.23,0.0,1.0);
  double4 var2 = (double4) (123455.134,0.0,-1.23,123455.134);
  int i = printf("double4_e_6524c===%+ 10.1v4le===%+ 10.1v4le===\n",var1,var2);
  return i;
}

int double4_e_6525c() {
  // { dg-printf "double4_e_6525c=== +1.00e+00, -1.23e+04, -1.23e+00, +1.00e+00=== -1.23e+04, +1.00e+00, -1.23e+04, +1.23e+05===" }
  double4 var1 = (double4) (1.0,-12345.032,-1.23,1.0);
  double4 var2 = (double4) (-12345.032,1.0,-12345.032,123455.134);
  int i = printf("double4_e_6525c===%+ 10.2v4le===%+ 10.2v4le===\n",var1,var2);
  return i;
}

int double4_e_6526c() {
  // { dg-printf "double4_e_6526c===+1.235e+05,+1.000e+00,+2.000e+00,+2.000e+00===+1.000e+00,+1.235e+05,+1.235e+05,+1.000e+00===" }
  double4 var1 = (double4) (123455.134,1.0,2.0,2.0);
  double4 var2 = (double4) (1.0,123455.134,123455.134,1.0);
  int i = printf("double4_e_6526c===%+ 10.3v4le===%+ 10.3v4le===\n",var1,var2);
  return i;
}

int double4_e_6527c() {
  // { dg-printf "double4_e_6527c===+2.0000000000e+00,-1.2345032000e+04,-1.2300000000e+00,+1.2345513400e+05===-1.2345032000e+04,-1.2300000000e+00,-1.2300000000e+00,-1.2300000000e+00===" }
  double4 var1 = (double4) (2.0,-12345.032,-1.23,123455.134);
  double4 var2 = (double4) (-12345.032,-1.23,-1.23,-1.23);
  int i = printf("double4_e_6527c===%+ 10.10v4le===%+ 10.10v4le===\n",var1,var2);
  return i;
}

int double4_e_6528c() {
  // { dg-printf "double4_e_6528c===+1.000000E+00,-1.234503E+04,-1.234503E+04,-1.230000E+00===+1.000000E+00,+1.234551E+05,-1.234503E+04,+1.234551E+05===" }
  double4 var1 = (double4) (1.0,-12345.032,-12345.032,-1.23);
  double4 var2 = (double4) (1.0,123455.134,-12345.032,123455.134);
  int i = printf("double4_e_6528c===%+ 10v4lE===%+ 10v4lE===\n",var1,var2);
  return i;
}

int double4_e_6529c() {
  // { dg-printf "double4_e_6529c===  +1.2E+05,  +1.0E+00,  -1.2E+04,  +0.0E+00===  +2.0E+00,  -1.2E+04,  +1.0E+00,  +2.0E+00===" }
  double4 var1 = (double4) (123455.134,1.0,-12345.032,0.0);
  double4 var2 = (double4) (2.0,-12345.032,1.0,2.0);
  int i = printf("double4_e_6529c===%+ 10.1v4lE===%+ 10.1v4lE===\n",var1,var2);
  return i;
}

int double4_e_6530c() {
  // { dg-printf "double4_e_6530c=== -1.23E+00, -1.23E+00, +0.00E+00, -1.23E+04=== +0.00E+00, +1.00E+00, +1.23E+05, +1.23E+05===" }
  double4 var1 = (double4) (-1.23,-1.23,0.0,-12345.032);
  double4 var2 = (double4) (0.0,1.0,123455.134,123455.134);
  int i = printf("double4_e_6530c===%+ 10.2v4lE===%+ 10.2v4lE===\n",var1,var2);
  return i;
}

int double4_e_6531c() {
  // { dg-printf "double4_e_6531c===+1.000E+00,+1.235E+05,-1.230E+00,+1.235E+05===+0.000E+00,+1.000E+00,+0.000E+00,+1.000E+00===" }
  double4 var1 = (double4) (1.0,123455.134,-1.23,123455.134);
  double4 var2 = (double4) (0.0,1.0,0.0,1.0);
  int i = printf("double4_e_6531c===%+ 10.3v4lE===%+ 10.3v4lE===\n",var1,var2);
  return i;
}

int double4_e_6532c() {
  // { dg-printf "double4_e_6532c===-1.2300000000E+00,+2.0000000000E+00,+0.0000000000E+00,-1.2300000000E+00===+1.0000000000E+00,-1.2300000000E+00,+0.0000000000E+00,+1.2345513400E+05===" }
  double4 var1 = (double4) (-1.23,2.0,0.0,-1.23);
  double4 var2 = (double4) (1.0,-1.23,0.0,123455.134);
  int i = printf("double4_e_6532c===%+ 10.10v4lE===%+ 10.10v4lE===\n",var1,var2);
  return i;
}

int double4_e_7283c() {
  // { dg-printf "double4_e_7283c===+1.234551e+05,-1.234503e+04,-1.234503e+04,+1.000000e+00===+0.000000e+00,+1.234551e+05,-1.234503e+04,+0.000000e+00===" }
  double4 var1 = (double4) (123455.134,-12345.032,-12345.032,1.0);
  double4 var2 = (double4) (0.0,123455.134,-12345.032,0.0);
  int i = printf("double4_e_7283c===%+010v4le===%+010v4le===\n",var1,var2);
  return i;
}

int double4_e_7284c() {
  // { dg-printf "double4_e_7284c===+001.2e+05,+001.2e+05,+000.0e+00,+002.0e+00===+000.0e+00,+001.2e+05,+002.0e+00,-001.2e+00===" }
  double4 var1 = (double4) (123455.134,123455.134,0.0,2.0);
  double4 var2 = (double4) (0.0,123455.134,2.0,-1.23);
  int i = printf("double4_e_7284c===%+010.1v4le===%+010.1v4le===\n",var1,var2);
  return i;
}

int double4_e_7285c() {
  // { dg-printf "double4_e_7285c===+01.23e+05,+01.23e+05,+02.00e+00,-01.23e+00===+00.00e+00,-01.23e+00,+02.00e+00,-01.23e+00===" }
  double4 var1 = (double4) (123455.134,123455.134,2.0,-1.23);
  double4 var2 = (double4) (0.0,-1.23,2.0,-1.23);
  int i = printf("double4_e_7285c===%+010.2v4le===%+010.2v4le===\n",var1,var2);
  return i;
}

int double4_e_7286c() {
  // { dg-printf "double4_e_7286c===-1.230e+00,+0.000e+00,-1.230e+00,-1.235e+04===+2.000e+00,-1.230e+00,+1.000e+00,-1.235e+04===" }
  double4 var1 = (double4) (-1.23,0.0,-1.23,-12345.032);
  double4 var2 = (double4) (2.0,-1.23,1.0,-12345.032);
  int i = printf("double4_e_7286c===%+010.3v4le===%+010.3v4le===\n",var1,var2);
  return i;
}

int double4_e_7287c() {
  // { dg-printf "double4_e_7287c===+0.0000000000e+00,+0.0000000000e+00,-1.2345032000e+04,+0.0000000000e+00===+1.0000000000e+00,+1.2345513400e+05,+2.0000000000e+00,+1.0000000000e+00===" }
  double4 var1 = (double4) (0.0,0.0,-12345.032,0.0);
  double4 var2 = (double4) (1.0,123455.134,2.0,1.0);
  int i = printf("double4_e_7287c===%+010.10v4le===%+010.10v4le===\n",var1,var2);
  return i;
}

int double4_e_7288c() {
  // { dg-printf "double4_e_7288c===-1.230000E+00,+2.000000E+00,+1.234551E+05,+1.234551E+05===+2.000000E+00,+1.234551E+05,-1.230000E+00,+1.234551E+05===" }
  double4 var1 = (double4) (-1.23,2.0,123455.134,123455.134);
  double4 var2 = (double4) (2.0,123455.134,-1.23,123455.134);
  int i = printf("double4_e_7288c===%+010v4lE===%+010v4lE===\n",var1,var2);
  return i;
}

int double4_e_7289c() {
  // { dg-printf "double4_e_7289c===+001.2E+05,+001.2E+05,+001.2E+05,+002.0E+00===-001.2E+04,+001.0E+00,-001.2E+04,-001.2E+00===" }
  double4 var1 = (double4) (123455.134,123455.134,123455.134,2.0);
  double4 var2 = (double4) (-12345.032,1.0,-12345.032,-1.23);
  int i = printf("double4_e_7289c===%+010.1v4lE===%+010.1v4lE===\n",var1,var2);
  return i;
}

int double4_e_7290c() {
  // { dg-printf "double4_e_7290c===+00.00E+00,-01.23E+04,+01.23E+05,-01.23E+00===+01.00E+00,+01.00E+00,+00.00E+00,+02.00E+00===" }
  double4 var1 = (double4) (0.0,-12345.032,123455.134,-1.23);
  double4 var2 = (double4) (1.0,1.0,0.0,2.0);
  int i = printf("double4_e_7290c===%+010.2v4lE===%+010.2v4lE===\n",var1,var2);
  return i;
}

int double4_e_7291c() {
  // { dg-printf "double4_e_7291c===+1.000E+00,+1.235E+05,+0.000E+00,+1.235E+05===-1.235E+04,+1.235E+05,+2.000E+00,+1.235E+05===" }
  double4 var1 = (double4) (1.0,123455.134,0.0,123455.134);
  double4 var2 = (double4) (-12345.032,123455.134,2.0,123455.134);
  int i = printf("double4_e_7291c===%+010.3v4lE===%+010.3v4lE===\n",var1,var2);
  return i;
}

int double4_e_7292c() {
  // { dg-printf "double4_e_7292c===+1.0000000000E+00,-1.2300000000E+00,-1.2300000000E+00,+0.0000000000E+00===+0.0000000000E+00,-1.2300000000E+00,+0.0000000000E+00,+0.0000000000E+00===" }
  double4 var1 = (double4) (1.0,-1.23,-1.23,0.0);
  double4 var2 = (double4) (0.0,-1.23,0.0,0.0);
  int i = printf("double4_e_7292c===%+010.10v4lE===%+010.10v4lE===\n",var1,var2);
  return i;
}

int double4_f_1213c() {
  // { dg-printf "double4_f_1213c===2.000000,-12345.032000,-1.230000,-1.230000===0.000000,1.000000,-1.230000,123455.134000===" }
  double4 var1 = (double4) (2.0,-12345.032,-1.23,-1.23);
  double4 var2 = (double4) (0.0,1.0,-1.23,123455.134);
  int i = printf("double4_f_1213c===%-v4lf===%-v4lf===\n",var1,var2);
  return i;
}

int double4_f_1214c() {
  // { dg-printf "double4_f_1214c===1.0,-12345.0,1.0,1.0===0.0,-1.2,1.0,1.0===" }
  double4 var1 = (double4) (1.0,-12345.032,1.0,1.0);
  double4 var2 = (double4) (0.0,-1.23,1.0,1.0);
  int i = printf("double4_f_1214c===%-.1v4lf===%-.1v4lf===\n",var1,var2);
  return i;
}

int double4_f_1215c() {
  // { dg-printf "double4_f_1215c===1.00,-12345.03,2.00,2.00===123455.13,123455.13,123455.13,1.00===" }
  double4 var1 = (double4) (1.0,-12345.032,2.0,2.0);
  double4 var2 = (double4) (123455.134,123455.134,123455.134,1.0);
  int i = printf("double4_f_1215c===%-.2v4lf===%-.2v4lf===\n",var1,var2);
  return i;
}

int double4_f_1216c() {
  // { dg-printf "double4_f_1216c===1.000,0.000,1.000,-1.230===0.000,1.000,-1.230,2.000===" }
  double4 var1 = (double4) (1.0,0.0,1.0,-1.23);
  double4 var2 = (double4) (0.0,1.0,-1.23,2.0);
  int i = printf("double4_f_1216c===%-.3v4lf===%-.3v4lf===\n",var1,var2);
  return i;
}

int double4_f_1217c() {
  // { dg-printf "double4_f_1217c===-1.2300000000,1.0000000000,123455.1340000000,1.0000000000===0.0000000000,-1.2300000000,-12345.0320000000,-12345.0320000000===" }
  double4 var1 = (double4) (-1.23,1.0,123455.134,1.0);
  double4 var2 = (double4) (0.0,-1.23,-12345.032,-12345.032);
  int i = printf("double4_f_1217c===%-.10v4lf===%-.10v4lf===\n",var1,var2);
  return i;
}

int double4_f_1218c() {
  // { dg-printf "double4_f_1218c===0.000000,0.000000,-12345.032000,123455.134000===-1.230000,2.000000,1.000000,-12345.032000===" }
  double4 var1 = (double4) (0.0,0.0,-12345.032,123455.134);
  double4 var2 = (double4) (-1.23,2.0,1.0,-12345.032);
  int i = printf("double4_f_1218c===%-v4lF===%-v4lF===\n",var1,var2);
  return i;
}

int double4_f_1219c() {
  // { dg-printf "double4_f_1219c===2.0,0.0,0.0,1.0===2.0,123455.1,2.0,-12345.0===" }
  double4 var1 = (double4) (2.0,0.0,0.0,1.0);
  double4 var2 = (double4) (2.0,123455.134,2.0,-12345.032);
  int i = printf("double4_f_1219c===%-.1v4lF===%-.1v4lF===\n",var1,var2);
  return i;
}

int double4_f_1220c() {
  // { dg-printf "double4_f_1220c===1.00,0.00,-12345.03,-12345.03===2.00,1.00,-12345.03,2.00===" }
  double4 var1 = (double4) (1.0,0.0,-12345.032,-12345.032);
  double4 var2 = (double4) (2.0,1.0,-12345.032,2.0);
  int i = printf("double4_f_1220c===%-.2v4lF===%-.2v4lF===\n",var1,var2);
  return i;
}

int double4_f_1221c() {
  // { dg-printf "double4_f_1221c===1.000,0.000,1.000,123455.134===1.000,-12345.032,0.000,1.000===" }
  double4 var1 = (double4) (1.0,0.0,1.0,123455.134);
  double4 var2 = (double4) (1.0,-12345.032,0.0,1.0);
  int i = printf("double4_f_1221c===%-.3v4lF===%-.3v4lF===\n",var1,var2);
  return i;
}

int double4_f_1222c() {
  // { dg-printf "double4_f_1222c===2.0000000000,-12345.0320000000,-12345.0320000000,-1.2300000000===1.0000000000,2.0000000000,-1.2300000000,0.0000000000===" }
  double4 var1 = (double4) (2.0,-12345.032,-12345.032,-1.23);
  double4 var2 = (double4) (1.0,2.0,-1.23,0.0);
  int i = printf("double4_f_1222c===%-.10v4lF===%-.10v4lF===\n",var1,var2);
  return i;
}

int double4_f_1973c() {
  // { dg-printf "double4_f_1973c===+123455.134000,-1.230000,+0.000000,-12345.032000===+123455.134000,+0.000000,+1.000000,-1.230000===" }
  double4 var1 = (double4) (123455.134,-1.23,0.0,-12345.032);
  double4 var2 = (double4) (123455.134,0.0,1.0,-1.23);
  int i = printf("double4_f_1973c===%+v4lf===%+v4lf===\n",var1,var2);
  return i;
}

int double4_f_1974c() {
  // { dg-printf "double4_f_1974c===+2.0,+0.0,+123455.1,+0.0===+2.0,-1.2,-1.2,+0.0===" }
  double4 var1 = (double4) (2.0,0.0,123455.134,0.0);
  double4 var2 = (double4) (2.0,-1.23,-1.23,0.0);
  int i = printf("double4_f_1974c===%+.1v4lf===%+.1v4lf===\n",var1,var2);
  return i;
}

int double4_f_1975c() {
  // { dg-printf "double4_f_1975c===+2.00,+123455.13,+1.00,+0.00===+123455.13,+2.00,+123455.13,+0.00===" }
  double4 var1 = (double4) (2.0,123455.134,1.0,0.0);
  double4 var2 = (double4) (123455.134,2.0,123455.134,0.0);
  int i = printf("double4_f_1975c===%+.2v4lf===%+.2v4lf===\n",var1,var2);
  return i;
}

int double4_f_1976c() {
  // { dg-printf "double4_f_1976c===+0.000,+1.000,+1.000,+123455.134===+1.000,-12345.032,+123455.134,+0.000===" }
  double4 var1 = (double4) (0.0,1.0,1.0,123455.134);
  double4 var2 = (double4) (1.0,-12345.032,123455.134,0.0);
  int i = printf("double4_f_1976c===%+.3v4lf===%+.3v4lf===\n",var1,var2);
  return i;
}

int double4_f_1977c() {
  // { dg-printf "double4_f_1977c===-1.2300000000,-1.2300000000,-1.2300000000,+123455.1340000000===+1.0000000000,-1.2300000000,+123455.1340000000,-12345.0320000000===" }
  double4 var1 = (double4) (-1.23,-1.23,-1.23,123455.134);
  double4 var2 = (double4) (1.0,-1.23,123455.134,-12345.032);
  int i = printf("double4_f_1977c===%+.10v4lf===%+.10v4lf===\n",var1,var2);
  return i;
}

int double4_f_1978c() {
  // { dg-printf "double4_f_1978c===+2.000000,-12345.032000,+123455.134000,+123455.134000===+0.000000,+2.000000,+0.000000,-12345.032000===" }
  double4 var1 = (double4) (2.0,-12345.032,123455.134,123455.134);
  double4 var2 = (double4) (0.0,2.0,0.0,-12345.032);
  int i = printf("double4_f_1978c===%+v4lF===%+v4lF===\n",var1,var2);
  return i;
}

int double4_f_1979c() {
  // { dg-printf "double4_f_1979c===+2.0,-1.2,-1.2,-1.2===+0.0,+2.0,-12345.0,+1.0===" }
  double4 var1 = (double4) (2.0,-1.23,-1.23,-1.23);
  double4 var2 = (double4) (0.0,2.0,-12345.032,1.0);
  int i = printf("double4_f_1979c===%+.1v4lF===%+.1v4lF===\n",var1,var2);
  return i;
}

int double4_f_1980c() {
  // { dg-printf "double4_f_1980c===+2.00,-1.23,+0.00,+2.00===+123455.13,+2.00,+0.00,+0.00===" }
  double4 var1 = (double4) (2.0,-1.23,0.0,2.0);
  double4 var2 = (double4) (123455.134,2.0,0.0,0.0);
  int i = printf("double4_f_1980c===%+.2v4lF===%+.2v4lF===\n",var1,var2);
  return i;
}

int double4_f_1981c() {
  // { dg-printf "double4_f_1981c===+0.000,-12345.032,+2.000,+123455.134===-12345.032,+123455.134,+123455.134,+1.000===" }
  double4 var1 = (double4) (0.0,-12345.032,2.0,123455.134);
  double4 var2 = (double4) (-12345.032,123455.134,123455.134,1.0);
  int i = printf("double4_f_1981c===%+.3v4lF===%+.3v4lF===\n",var1,var2);
  return i;
}

int double4_f_1982c() {
  // { dg-printf "double4_f_1982c===+0.0000000000,+1.0000000000,+1.0000000000,+1.0000000000===+0.0000000000,-12345.0320000000,+2.0000000000,-1.2300000000===" }
  double4 var1 = (double4) (0.0,1.0,1.0,1.0);
  double4 var2 = (double4) (0.0,-12345.032,2.0,-1.23);
  int i = printf("double4_f_1982c===%+.10v4lF===%+.10v4lF===\n",var1,var2);
  return i;
}

int double4_f_2733c() {
  // { dg-printf "double4_f_2733c===-12345.032000,-12345.032000,-1.230000,1.000000===-1.230000,123455.134000,0.000000,-1.230000===" }
  double4 var1 = (double4) (-12345.032,-12345.032,-1.23,1.0);
  double4 var2 = (double4) (-1.23,123455.134,0.0,-1.23);
  int i = printf("double4_f_2733c===%#v4lf===%#v4lf===\n",var1,var2);
  return i;
}

int double4_f_2734c() {
  // { dg-printf "double4_f_2734c===123455.1,-12345.0,-12345.0,1.0===-1.2,1.0,-12345.0,-1.2===" }
  double4 var1 = (double4) (123455.134,-12345.032,-12345.032,1.0);
  double4 var2 = (double4) (-1.23,1.0,-12345.032,-1.23);
  int i = printf("double4_f_2734c===%#.1v4lf===%#.1v4lf===\n",var1,var2);
  return i;
}

int double4_f_2735c() {
  // { dg-printf "double4_f_2735c===0.00,1.00,0.00,0.00===-12345.03,-1.23,1.00,2.00===" }
  double4 var1 = (double4) (0.0,1.0,0.0,0.0);
  double4 var2 = (double4) (-12345.032,-1.23,1.0,2.0);
  int i = printf("double4_f_2735c===%#.2v4lf===%#.2v4lf===\n",var1,var2);
  return i;
}

int double4_f_2736c() {
  // { dg-printf "double4_f_2736c===-12345.032,1.000,2.000,-1.230===123455.134,1.000,123455.134,-1.230===" }
  double4 var1 = (double4) (-12345.032,1.0,2.0,-1.23);
  double4 var2 = (double4) (123455.134,1.0,123455.134,-1.23);
  int i = printf("double4_f_2736c===%#.3v4lf===%#.3v4lf===\n",var1,var2);
  return i;
}

int double4_f_2737c() {
  // { dg-printf "double4_f_2737c===123455.1340000000,1.0000000000,2.0000000000,123455.1340000000===-1.2300000000,-12345.0320000000,123455.1340000000,0.0000000000===" }
  double4 var1 = (double4) (123455.134,1.0,2.0,123455.134);
  double4 var2 = (double4) (-1.23,-12345.032,123455.134,0.0);
  int i = printf("double4_f_2737c===%#.10v4lf===%#.10v4lf===\n",var1,var2);
  return i;
}

int double4_f_2738c() {
  // { dg-printf "double4_f_2738c===-1.230000,1.000000,-1.230000,-1.230000===-1.230000,1.000000,0.000000,1.000000===" }
  double4 var1 = (double4) (-1.23,1.0,-1.23,-1.23);
  double4 var2 = (double4) (-1.23,1.0,0.0,1.0);
  int i = printf("double4_f_2738c===%#v4lF===%#v4lF===\n",var1,var2);
  return i;
}

int double4_f_2739c() {
  // { dg-printf "double4_f_2739c===0.0,-1.2,0.0,0.0===123455.1,0.0,123455.1,123455.1===" }
  double4 var1 = (double4) (0.0,-1.23,0.0,0.0);
  double4 var2 = (double4) (123455.134,0.0,123455.134,123455.134);
  int i = printf("double4_f_2739c===%#.1v4lF===%#.1v4lF===\n",var1,var2);
  return i;
}

int double4_f_2740c() {
  // { dg-printf "double4_f_2740c===-12345.03,123455.13,0.00,0.00===-1.23,1.00,123455.13,0.00===" }
  double4 var1 = (double4) (-12345.032,123455.134,0.0,0.0);
  double4 var2 = (double4) (-1.23,1.0,123455.134,0.0);
  int i = printf("double4_f_2740c===%#.2v4lF===%#.2v4lF===\n",var1,var2);
  return i;
}

int double4_f_2741c() {
  // { dg-printf "double4_f_2741c===-12345.032,-12345.032,-1.230,1.000===2.000,1.000,0.000,-12345.032===" }
  double4 var1 = (double4) (-12345.032,-12345.032,-1.23,1.0);
  double4 var2 = (double4) (2.0,1.0,0.0,-12345.032);
  int i = printf("double4_f_2741c===%#.3v4lF===%#.3v4lF===\n",var1,var2);
  return i;
}

int double4_f_2742c() {
  // { dg-printf "double4_f_2742c===123455.1340000000,-12345.0320000000,123455.1340000000,123455.1340000000===1.0000000000,123455.1340000000,-1.2300000000,-1.2300000000===" }
  double4 var1 = (double4) (123455.134,-12345.032,123455.134,123455.134);
  double4 var2 = (double4) (1.0,123455.134,-1.23,-1.23);
  int i = printf("double4_f_2742c===%#.10v4lF===%#.10v4lF===\n",var1,var2);
  return i;
}

int double4_f_3493c() {
  // { dg-printf "double4_f_3493c===+123455.134000,+2.000000,-1.230000,-12345.032000===+0.000000,-1.230000,-12345.032000,+0.000000===" }
  double4 var1 = (double4) (123455.134,2.0,-1.23,-12345.032);
  double4 var2 = (double4) (0.0,-1.23,-12345.032,0.0);
  int i = printf("double4_f_3493c===%-+v4lf===%-+v4lf===\n",var1,var2);
  return i;
}

int double4_f_3494c() {
  // { dg-printf "double4_f_3494c===+123455.1,+1.0,+2.0,-1.2===+123455.1,+0.0,+2.0,+1.0===" }
  double4 var1 = (double4) (123455.134,1.0,2.0,-1.23);
  double4 var2 = (double4) (123455.134,0.0,2.0,1.0);
  int i = printf("double4_f_3494c===%-+.1v4lf===%-+.1v4lf===\n",var1,var2);
  return i;
}

int double4_f_3495c() {
  // { dg-printf "double4_f_3495c===-1.23,+1.00,-12345.03,+123455.13===+1.00,+2.00,+123455.13,+0.00===" }
  double4 var1 = (double4) (-1.23,1.0,-12345.032,123455.134);
  double4 var2 = (double4) (1.0,2.0,123455.134,0.0);
  int i = printf("double4_f_3495c===%-+.2v4lf===%-+.2v4lf===\n",var1,var2);
  return i;
}

int double4_f_3496c() {
  // { dg-printf "double4_f_3496c===-1.230,+2.000,+0.000,-1.230===+2.000,-12345.032,+0.000,+2.000===" }
  double4 var1 = (double4) (-1.23,2.0,0.0,-1.23);
  double4 var2 = (double4) (2.0,-12345.032,0.0,2.0);
  int i = printf("double4_f_3496c===%-+.3v4lf===%-+.3v4lf===\n",var1,var2);
  return i;
}

int double4_f_3497c() {
  // { dg-printf "double4_f_3497c===+2.0000000000,+0.0000000000,-12345.0320000000,-1.2300000000===-1.2300000000,-1.2300000000,+123455.1340000000,+2.0000000000===" }
  double4 var1 = (double4) (2.0,0.0,-12345.032,-1.23);
  double4 var2 = (double4) (-1.23,-1.23,123455.134,2.0);
  int i = printf("double4_f_3497c===%-+.10v4lf===%-+.10v4lf===\n",var1,var2);
  return i;
}

int double4_f_3498c() {
  // { dg-printf "double4_f_3498c===+2.000000,-12345.032000,+2.000000,+0.000000===-12345.032000,+1.000000,+1.000000,-1.230000===" }
  double4 var1 = (double4) (2.0,-12345.032,2.0,0.0);
  double4 var2 = (double4) (-12345.032,1.0,1.0,-1.23);
  int i = printf("double4_f_3498c===%-+v4lF===%-+v4lF===\n",var1,var2);
  return i;
}

int double4_f_3499c() {
  // { dg-printf "double4_f_3499c===-1.2,+123455.1,+2.0,+1.0===-12345.0,+123455.1,+123455.1,-1.2===" }
  double4 var1 = (double4) (-1.23,123455.134,2.0,1.0);
  double4 var2 = (double4) (-12345.032,123455.134,123455.134,-1.23);
  int i = printf("double4_f_3499c===%-+.1v4lF===%-+.1v4lF===\n",var1,var2);
  return i;
}

int double4_f_3500c() {
  // { dg-printf "double4_f_3500c===+1.00,-1.23,+1.00,+2.00===+123455.13,+2.00,+0.00,+123455.13===" }
  double4 var1 = (double4) (1.0,-1.23,1.0,2.0);
  double4 var2 = (double4) (123455.134,2.0,0.0,123455.134);
  int i = printf("double4_f_3500c===%-+.2v4lF===%-+.2v4lF===\n",var1,var2);
  return i;
}

int double4_f_3501c() {
  // { dg-printf "double4_f_3501c===+123455.134,+0.000,+0.000,+1.000===+1.000,+0.000,+2.000,+0.000===" }
  double4 var1 = (double4) (123455.134,0.0,0.0,1.0);
  double4 var2 = (double4) (1.0,0.0,2.0,0.0);
  int i = printf("double4_f_3501c===%-+.3v4lF===%-+.3v4lF===\n",var1,var2);
  return i;
}

int double4_f_3502c() {
  // { dg-printf "double4_f_3502c===+1.0000000000,+123455.1340000000,+2.0000000000,-1.2300000000===+2.0000000000,+1.0000000000,+123455.1340000000,+2.0000000000===" }
  double4 var1 = (double4) (1.0,123455.134,2.0,-1.23);
  double4 var2 = (double4) (2.0,1.0,123455.134,2.0);
  int i = printf("double4_f_3502c===%-+.10v4lF===%-+.10v4lF===\n",var1,var2);
  return i;
}

int double4_f_4253c() {
  // { dg-printf "double4_f_4253c===-12345.032000,  0.000000,  2.000000, 123455.134000=== -1.230000, 123455.134000,  2.000000, -1.230000===" }
  double4 var1 = (double4) (-12345.032,0.0,2.0,123455.134);
  double4 var2 = (double4) (-1.23,123455.134,2.0,-1.23);
  int i = printf("double4_f_4253c===% 10v4lf===% 10v4lf===\n",var1,var2);
  return i;
}

int double4_f_4254c() {
  // { dg-printf "double4_f_4254c===       0.0,      -1.2,  123455.1,       0.0===      -1.2,       1.0,       2.0,       2.0===" }
  double4 var1 = (double4) (0.0,-1.23,123455.134,0.0);
  double4 var2 = (double4) (-1.23,1.0,2.0,2.0);
  int i = printf("double4_f_4254c===% 10.1v4lf===% 10.1v4lf===\n",var1,var2);
  return i;
}

int double4_f_4255c() {
  // { dg-printf "double4_f_4255c===      1.00,      1.00,      1.00, -12345.03=== 123455.13,      1.00,     -1.23,      2.00===" }
  double4 var1 = (double4) (1.0,1.0,1.0,-12345.032);
  double4 var2 = (double4) (123455.134,1.0,-1.23,2.0);
  int i = printf("double4_f_4255c===% 10.2v4lf===% 10.2v4lf===\n",var1,var2);
  return i;
}

int double4_f_4256c() {
  // { dg-printf "double4_f_4256c=== 123455.134,     1.000,-12345.032,     0.000===     1.000,     0.000, 123455.134,     0.000===" }
  double4 var1 = (double4) (123455.134,1.0,-12345.032,0.0);
  double4 var2 = (double4) (1.0,0.0,123455.134,0.0);
  int i = printf("double4_f_4256c===% 10.3v4lf===% 10.3v4lf===\n",var1,var2);
  return i;
}

int double4_f_4257c() {
  // { dg-printf "double4_f_4257c===-1.2300000000, 1.0000000000, 2.0000000000,-12345.0320000000=== 0.0000000000, 2.0000000000,-1.2300000000, 0.0000000000===" }
  double4 var1 = (double4) (-1.23,1.0,2.0,-12345.032);
  double4 var2 = (double4) (0.0,2.0,-1.23,0.0);
  int i = printf("double4_f_4257c===% 10.10v4lf===% 10.10v4lf===\n",var1,var2);
  return i;
}

int double4_f_4258c() {
  // { dg-printf "double4_f_4258c===  2.000000,-12345.032000,  2.000000,  2.000000===  0.000000,-12345.032000, -1.230000,-12345.032000===" }
  double4 var1 = (double4) (2.0,-12345.032,2.0,2.0);
  double4 var2 = (double4) (0.0,-12345.032,-1.23,-12345.032);
  int i = printf("double4_f_4258c===% 10v4lF===% 10v4lF===\n",var1,var2);
  return i;
}

int double4_f_4259c() {
  // { dg-printf "double4_f_4259c===  -12345.0,       1.0,  123455.1,       2.0===  -12345.0,       0.0,       2.0,       1.0===" }
  double4 var1 = (double4) (-12345.032,1.0,123455.134,2.0);
  double4 var2 = (double4) (-12345.032,0.0,2.0,1.0);
  int i = printf("double4_f_4259c===% 10.1v4lF===% 10.1v4lF===\n",var1,var2);
  return i;
}

int double4_f_4260c() {
  // { dg-printf "double4_f_4260c=== -12345.03,      2.00, 123455.13,      1.00===      0.00,     -1.23, 123455.13,     -1.23===" }
  double4 var1 = (double4) (-12345.032,2.0,123455.134,1.0);
  double4 var2 = (double4) (0.0,-1.23,123455.134,-1.23);
  int i = printf("double4_f_4260c===% 10.2v4lF===% 10.2v4lF===\n",var1,var2);
  return i;
}

int double4_f_4261c() {
  // { dg-printf "double4_f_4261c===     0.000,     1.000, 123455.134,    -1.230=== 123455.134, 123455.134,     2.000,    -1.230===" }
  double4 var1 = (double4) (0.0,1.0,123455.134,-1.23);
  double4 var2 = (double4) (123455.134,123455.134,2.0,-1.23);
  int i = printf("double4_f_4261c===% 10.3v4lF===% 10.3v4lF===\n",var1,var2);
  return i;
}

int double4_f_4262c() {
  // { dg-printf "double4_f_4262c===-1.2300000000, 1.0000000000, 1.0000000000,-12345.0320000000===-1.2300000000, 123455.1340000000, 123455.1340000000,-12345.0320000000===" }
  double4 var1 = (double4) (-1.23,1.0,1.0,-12345.032);
  double4 var2 = (double4) (-1.23,123455.134,123455.134,-12345.032);
  int i = printf("double4_f_4262c===% 10.10v4lF===% 10.10v4lF===\n",var1,var2);
  return i;
}

int double4_f_453c() {
  // { dg-printf "double4_f_453c===2.000000,0.000000,123455.134000,1.000000===0.000000,-1.230000,123455.134000,123455.134000===" }
  double4 var1 = (double4) (2.0,0.0,123455.134,1.0);
  double4 var2 = (double4) (0.0,-1.23,123455.134,123455.134);
  int i = printf("double4_f_453c===%v4lf===%v4lf===\n",var1,var2);
  return i;
}

int double4_f_454c() {
  // { dg-printf "double4_f_454c===1.0,123455.1,0.0,0.0===-12345.0,-1.2,-12345.0,123455.1===" }
  double4 var1 = (double4) (1.0,123455.134,0.0,0.0);
  double4 var2 = (double4) (-12345.032,-1.23,-12345.032,123455.134);
  int i = printf("double4_f_454c===%.1v4lf===%.1v4lf===\n",var1,var2);
  return i;
}

int double4_f_455c() {
  // { dg-printf "double4_f_455c===1.00,1.00,123455.13,-12345.03===1.00,2.00,-1.23,123455.13===" }
  double4 var1 = (double4) (1.0,1.0,123455.134,-12345.032);
  double4 var2 = (double4) (1.0,2.0,-1.23,123455.134);
  int i = printf("double4_f_455c===%.2v4lf===%.2v4lf===\n",var1,var2);
  return i;
}

int double4_f_456c() {
  // { dg-printf "double4_f_456c===-12345.032,123455.134,1.000,1.000===-12345.032,2.000,123455.134,123455.134===" }
  double4 var1 = (double4) (-12345.032,123455.134,1.0,1.0);
  double4 var2 = (double4) (-12345.032,2.0,123455.134,123455.134);
  int i = printf("double4_f_456c===%.3v4lf===%.3v4lf===\n",var1,var2);
  return i;
}

int double4_f_457c() {
  // { dg-printf "double4_f_457c===-1.2300000000,0.0000000000,-12345.0320000000,-1.2300000000===2.0000000000,2.0000000000,2.0000000000,1.0000000000===" }
  double4 var1 = (double4) (-1.23,0.0,-12345.032,-1.23);
  double4 var2 = (double4) (2.0,2.0,2.0,1.0);
  int i = printf("double4_f_457c===%.10v4lf===%.10v4lf===\n",var1,var2);
  return i;
}

int double4_f_458c() {
  // { dg-printf "double4_f_458c===-12345.032000,1.000000,1.000000,-1.230000===-12345.032000,1.000000,1.000000,1.000000===" }
  double4 var1 = (double4) (-12345.032,1.0,1.0,-1.23);
  double4 var2 = (double4) (-12345.032,1.0,1.0,1.0);
  int i = printf("double4_f_458c===%v4lF===%v4lF===\n",var1,var2);
  return i;
}

int double4_f_459c() {
  // { dg-printf "double4_f_459c===-12345.0,-12345.0,1.0,-12345.0===2.0,-1.2,2.0,2.0===" }
  double4 var1 = (double4) (-12345.032,-12345.032,1.0,-12345.032);
  double4 var2 = (double4) (2.0,-1.23,2.0,2.0);
  int i = printf("double4_f_459c===%.1v4lF===%.1v4lF===\n",var1,var2);
  return i;
}

int double4_f_460c() {
  // { dg-printf "double4_f_460c===123455.13,2.00,0.00,-1.23===0.00,1.00,1.00,-1.23===" }
  double4 var1 = (double4) (123455.134,2.0,0.0,-1.23);
  double4 var2 = (double4) (0.0,1.0,1.0,-1.23);
  int i = printf("double4_f_460c===%.2v4lF===%.2v4lF===\n",var1,var2);
  return i;
}

int double4_f_461c() {
  // { dg-printf "double4_f_461c===-1.230,123455.134,-1.230,2.000===-12345.032,123455.134,-1.230,123455.134===" }
  double4 var1 = (double4) (-1.23,123455.134,-1.23,2.0);
  double4 var2 = (double4) (-12345.032,123455.134,-1.23,123455.134);
  int i = printf("double4_f_461c===%.3v4lF===%.3v4lF===\n",var1,var2);
  return i;
}

int double4_f_462c() {
  // { dg-printf "double4_f_462c===2.0000000000,2.0000000000,123455.1340000000,123455.1340000000===123455.1340000000,-1.2300000000,0.0000000000,0.0000000000===" }
  double4 var1 = (double4) (2.0,2.0,123455.134,123455.134);
  double4 var2 = (double4) (123455.134,-1.23,0.0,0.0);
  int i = printf("double4_f_462c===%.10v4lF===%.10v4lF===\n",var1,var2);
  return i;
}

int double4_f_5013c() {
  // { dg-printf "double4_f_5013c===002.000000,002.000000,002.000000,000.000000===-12345.032000,000.000000,-01.230000,123455.134000===" }
  double4 var1 = (double4) (2.0,2.0,2.0,0.0);
  double4 var2 = (double4) (-12345.032,0.0,-1.23,123455.134);
  int i = printf("double4_f_5013c===%010v4lf===%010v4lf===\n",var1,var2);
  return i;
}

int double4_f_5014c() {
  // { dg-printf "double4_f_5014c===00000001.0,00000000.0,00000000.0,00000001.0===00000001.0,-0012345.0,-0012345.0,-0000001.2===" }
  double4 var1 = (double4) (1.0,0.0,0.0,1.0);
  double4 var2 = (double4) (1.0,-12345.032,-12345.032,-1.23);
  int i = printf("double4_f_5014c===%010.1v4lf===%010.1v4lf===\n",var1,var2);
  return i;
}

int double4_f_5015c() {
  // { dg-printf "double4_f_5015c===0000000.00,0000000.00,-012345.03,0000001.00===-012345.03,-000001.23,-000001.23,0123455.13===" }
  double4 var1 = (double4) (0.0,0.0,-12345.032,1.0);
  double4 var2 = (double4) (-12345.032,-1.23,-1.23,123455.134);
  int i = printf("double4_f_5015c===%010.2v4lf===%010.2v4lf===\n",var1,var2);
  return i;
}

int double4_f_5016c() {
  // { dg-printf "double4_f_5016c===123455.134,123455.134,-00001.230,123455.134===000001.000,123455.134,-00001.230,000002.000===" }
  double4 var1 = (double4) (123455.134,123455.134,-1.23,123455.134);
  double4 var2 = (double4) (1.0,123455.134,-1.23,2.0);
  int i = printf("double4_f_5016c===%010.3v4lf===%010.3v4lf===\n",var1,var2);
  return i;
}

int double4_f_5017c() {
  // { dg-printf "double4_f_5017c===0.0000000000,123455.1340000000,123455.1340000000,1.0000000000===2.0000000000,123455.1340000000,-1.2300000000,123455.1340000000===" }
  double4 var1 = (double4) (0.0,123455.134,123455.134,1.0);
  double4 var2 = (double4) (2.0,123455.134,-1.23,123455.134);
  int i = printf("double4_f_5017c===%010.10v4lf===%010.10v4lf===\n",var1,var2);
  return i;
}

int double4_f_5018c() {
  // { dg-printf "double4_f_5018c===002.000000,-01.230000,000.000000,-12345.032000===001.000000,123455.134000,002.000000,-12345.032000===" }
  double4 var1 = (double4) (2.0,-1.23,0.0,-12345.032);
  double4 var2 = (double4) (1.0,123455.134,2.0,-12345.032);
  int i = printf("double4_f_5018c===%010v4lF===%010v4lF===\n",var1,var2);
  return i;
}

int double4_f_5019c() {
  // { dg-printf "double4_f_5019c===00000001.0,-0012345.0,-0012345.0,-0000001.2===-0012345.0,00123455.1,-0000001.2,-0012345.0===" }
  double4 var1 = (double4) (1.0,-12345.032,-12345.032,-1.23);
  double4 var2 = (double4) (-12345.032,123455.134,-1.23,-12345.032);
  int i = printf("double4_f_5019c===%010.1v4lF===%010.1v4lF===\n",var1,var2);
  return i;
}

int double4_f_5020c() {
  // { dg-printf "double4_f_5020c===-012345.03,-012345.03,-000001.23,0000000.00===0000002.00,-000001.23,-000001.23,0000002.00===" }
  double4 var1 = (double4) (-12345.032,-12345.032,-1.23,0.0);
  double4 var2 = (double4) (2.0,-1.23,-1.23,2.0);
  int i = printf("double4_f_5020c===%010.2v4lF===%010.2v4lF===\n",var1,var2);
  return i;
}

int double4_f_5021c() {
  // { dg-printf "double4_f_5021c===123455.134,000002.000,-12345.032,000001.000===000001.000,123455.134,000001.000,-12345.032===" }
  double4 var1 = (double4) (123455.134,2.0,-12345.032,1.0);
  double4 var2 = (double4) (1.0,123455.134,1.0,-12345.032);
  int i = printf("double4_f_5021c===%010.3v4lF===%010.3v4lF===\n",var1,var2);
  return i;
}

int double4_f_5022c() {
  // { dg-printf "double4_f_5022c===-1.2300000000,-1.2300000000,1.0000000000,-12345.0320000000===-12345.0320000000,2.0000000000,1.0000000000,-12345.0320000000===" }
  double4 var1 = (double4) (-1.23,-1.23,1.0,-12345.032);
  double4 var2 = (double4) (-12345.032,2.0,1.0,-12345.032);
  int i = printf("double4_f_5022c===%010.10v4lF===%010.10v4lF===\n",var1,var2);
  return i;
}

int double4_f_5773c() {
  // { dg-printf "double4_f_5773c=== 1.000000 , 123455.134000, 123455.134000, 2.000000 === 2.000000 ,-1.230000 , 0.000000 ,-1.230000 ===" }
  double4 var1 = (double4) (1.0,123455.134,123455.134,2.0);
  double4 var2 = (double4) (2.0,-1.23,0.0,-1.23);
  int i = printf("double4_f_5773c===%- 10v4lf===%- 10v4lf===\n",var1,var2);
  return i;
}

int double4_f_5774c() {
  // { dg-printf "double4_f_5774c===-12345.0  , 123455.1 ,-1.2      , 2.0      === 123455.1 , 2.0      , 0.0      , 2.0      ===" }
  double4 var1 = (double4) (-12345.032,123455.134,-1.23,2.0);
  double4 var2 = (double4) (123455.134,2.0,0.0,2.0);
  int i = printf("double4_f_5774c===%- 10.1v4lf===%- 10.1v4lf===\n",var1,var2);
  return i;
}

int double4_f_5775c() {
  // { dg-printf "double4_f_5775c===-1.23     , 2.00     , 1.00     , 2.00     === 1.00     , 2.00     , 123455.13, 0.00     ===" }
  double4 var1 = (double4) (-1.23,2.0,1.0,2.0);
  double4 var2 = (double4) (1.0,2.0,123455.134,0.0);
  int i = printf("double4_f_5775c===%- 10.2v4lf===%- 10.2v4lf===\n",var1,var2);
  return i;
}

int double4_f_5776c() {
  // { dg-printf "double4_f_5776c=== 2.000    , 2.000    , 2.000    , 1.000    ===-1.230    , 2.000    , 1.000    , 0.000    ===" }
  double4 var1 = (double4) (2.0,2.0,2.0,1.0);
  double4 var2 = (double4) (-1.23,2.0,1.0,0.0);
  int i = printf("double4_f_5776c===%- 10.3v4lf===%- 10.3v4lf===\n",var1,var2);
  return i;
}

int double4_f_5777c() {
  // { dg-printf "double4_f_5777c=== 123455.1340000000, 2.0000000000, 123455.1340000000, 0.0000000000=== 123455.1340000000, 0.0000000000, 123455.1340000000,-12345.0320000000===" }
  double4 var1 = (double4) (123455.134,2.0,123455.134,0.0);
  double4 var2 = (double4) (123455.134,0.0,123455.134,-12345.032);
  int i = printf("double4_f_5777c===%- 10.10v4lf===%- 10.10v4lf===\n",var1,var2);
  return i;
}

int double4_f_5778c() {
  // { dg-printf "double4_f_5778c=== 2.000000 , 123455.134000, 2.000000 , 0.000000 ===-12345.032000, 1.000000 , 0.000000 ,-1.230000 ===" }
  double4 var1 = (double4) (2.0,123455.134,2.0,0.0);
  double4 var2 = (double4) (-12345.032,1.0,0.0,-1.23);
  int i = printf("double4_f_5778c===%- 10v4lF===%- 10v4lF===\n",var1,var2);
  return i;
}

int double4_f_5779c() {
  // { dg-printf "double4_f_5779c=== 123455.1 , 1.0      ,-1.2      , 123455.1 === 1.0      ,-1.2      ,-12345.0  , 2.0      ===" }
  double4 var1 = (double4) (123455.134,1.0,-1.23,123455.134);
  double4 var2 = (double4) (1.0,-1.23,-12345.032,2.0);
  int i = printf("double4_f_5779c===%- 10.1v4lF===%- 10.1v4lF===\n",var1,var2);
  return i;
}

int double4_f_5780c() {
  // { dg-printf "double4_f_5780c===-12345.03 , 2.00     ,-12345.03 , 2.00     === 123455.13, 123455.13, 2.00     , 123455.13===" }
  double4 var1 = (double4) (-12345.032,2.0,-12345.032,2.0);
  double4 var2 = (double4) (123455.134,123455.134,2.0,123455.134);
  int i = printf("double4_f_5780c===%- 10.2v4lF===%- 10.2v4lF===\n",var1,var2);
  return i;
}

int double4_f_5781c() {
  // { dg-printf "double4_f_5781c=== 123455.134, 1.000    , 123455.134, 1.000    === 2.000    ,-12345.032,-1.230    ,-12345.032===" }
  double4 var1 = (double4) (123455.134,1.0,123455.134,1.0);
  double4 var2 = (double4) (2.0,-12345.032,-1.23,-12345.032);
  int i = printf("double4_f_5781c===%- 10.3v4lF===%- 10.3v4lF===\n",var1,var2);
  return i;
}

int double4_f_5782c() {
  // { dg-printf "double4_f_5782c===-1.2300000000, 0.0000000000, 123455.1340000000, 2.0000000000=== 0.0000000000, 2.0000000000, 0.0000000000,-12345.0320000000===" }
  double4 var1 = (double4) (-1.23,0.0,123455.134,2.0);
  double4 var2 = (double4) (0.0,2.0,0.0,-12345.032);
  int i = printf("double4_f_5782c===%- 10.10v4lF===%- 10.10v4lF===\n",var1,var2);
  return i;
}

int double4_f_6533c() {
  // { dg-printf "double4_f_6533c===+123455.134000, +2.000000, +1.000000,-12345.032000=== -1.230000,-12345.032000, +2.000000,+123455.134000===" }
  double4 var1 = (double4) (123455.134,2.0,1.0,-12345.032);
  double4 var2 = (double4) (-1.23,-12345.032,2.0,123455.134);
  int i = printf("double4_f_6533c===%+ 10v4lf===%+ 10v4lf===\n",var1,var2);
  return i;
}

int double4_f_6534c() {
  // { dg-printf "double4_f_6534c===  -12345.0,  -12345.0,      -1.2,  -12345.0===      -1.2,      +0.0,      +1.0,      +2.0===" }
  double4 var1 = (double4) (-12345.032,-12345.032,-1.23,-12345.032);
  double4 var2 = (double4) (-1.23,0.0,1.0,2.0);
  int i = printf("double4_f_6534c===%+ 10.1v4lf===%+ 10.1v4lf===\n",var1,var2);
  return i;
}

int double4_f_6535c() {
  // { dg-printf "double4_f_6535c===     +1.00,     +1.00,     -1.23,     +0.00===+123455.13, -12345.03, -12345.03, -12345.03===" }
  double4 var1 = (double4) (1.0,1.0,-1.23,0.0);
  double4 var2 = (double4) (123455.134,-12345.032,-12345.032,-12345.032);
  int i = printf("double4_f_6535c===%+ 10.2v4lf===%+ 10.2v4lf===\n",var1,var2);
  return i;
}

int double4_f_6536c() {
  // { dg-printf "double4_f_6536c===-12345.032,    -1.230,+123455.134,-12345.032===    +2.000,    -1.230,+123455.134,    +1.000===" }
  double4 var1 = (double4) (-12345.032,-1.23,123455.134,-12345.032);
  double4 var2 = (double4) (2.0,-1.23,123455.134,1.0);
  int i = printf("double4_f_6536c===%+ 10.3v4lf===%+ 10.3v4lf===\n",var1,var2);
  return i;
}

int double4_f_6537c() {
  // { dg-printf "double4_f_6537c===+1.0000000000,+1.0000000000,+2.0000000000,-1.2300000000===+2.0000000000,-1.2300000000,+2.0000000000,+1.0000000000===" }
  double4 var1 = (double4) (1.0,1.0,2.0,-1.23);
  double4 var2 = (double4) (2.0,-1.23,2.0,1.0);
  int i = printf("double4_f_6537c===%+ 10.10v4lf===%+ 10.10v4lf===\n",var1,var2);
  return i;
}

int double4_f_6538c() {
  // { dg-printf "double4_f_6538c===+123455.134000,-12345.032000, +0.000000, -1.230000=== +2.000000, +0.000000, +1.000000,-12345.032000===" }
  double4 var1 = (double4) (123455.134,-12345.032,0.0,-1.23);
  double4 var2 = (double4) (2.0,0.0,1.0,-12345.032);
  int i = printf("double4_f_6538c===%+ 10v4lF===%+ 10v4lF===\n",var1,var2);
  return i;
}

int double4_f_6539c() {
  // { dg-printf "double4_f_6539c===      +1.0,  -12345.0,      +0.0,  -12345.0===      +0.0, +123455.1, +123455.1,  -12345.0===" }
  double4 var1 = (double4) (1.0,-12345.032,0.0,-12345.032);
  double4 var2 = (double4) (0.0,123455.134,123455.134,-12345.032);
  int i = printf("double4_f_6539c===%+ 10.1v4lF===%+ 10.1v4lF===\n",var1,var2);
  return i;
}

int double4_f_6540c() {
  // { dg-printf "double4_f_6540c===+123455.13,     +1.00,     -1.23,     -1.23===+123455.13,     -1.23, -12345.03,     +1.00===" }
  double4 var1 = (double4) (123455.134,1.0,-1.23,-1.23);
  double4 var2 = (double4) (123455.134,-1.23,-12345.032,1.0);
  int i = printf("double4_f_6540c===%+ 10.2v4lF===%+ 10.2v4lF===\n",var1,var2);
  return i;
}

int double4_f_6541c() {
  // { dg-printf "double4_f_6541c===-12345.032,    +2.000,    +0.000,    -1.230===-12345.032,    -1.230,    +0.000,    -1.230===" }
  double4 var1 = (double4) (-12345.032,2.0,0.0,-1.23);
  double4 var2 = (double4) (-12345.032,-1.23,0.0,-1.23);
  int i = printf("double4_f_6541c===%+ 10.3v4lF===%+ 10.3v4lF===\n",var1,var2);
  return i;
}

int double4_f_6542c() {
  // { dg-printf "double4_f_6542c===+123455.1340000000,+2.0000000000,+0.0000000000,+0.0000000000===+2.0000000000,-1.2300000000,+0.0000000000,+2.0000000000===" }
  double4 var1 = (double4) (123455.134,2.0,0.0,0.0);
  double4 var2 = (double4) (2.0,-1.23,0.0,2.0);
  int i = printf("double4_f_6542c===%+ 10.10v4lF===%+ 10.10v4lF===\n",var1,var2);
  return i;
}

int double4_f_7293c() {
  // { dg-printf "double4_f_7293c===+02.000000,+01.000000,+00.000000,+123455.134000===-12345.032000,-01.230000,+123455.134000,-01.230000===" }
  double4 var1 = (double4) (2.0,1.0,0.0,123455.134);
  double4 var2 = (double4) (-12345.032,-1.23,123455.134,-1.23);
  int i = printf("double4_f_7293c===%+010v4lf===%+010v4lf===\n",var1,var2);
  return i;
}

int double4_f_7294c() {
  // { dg-printf "double4_f_7294c===-0012345.0,+0000002.0,+0000002.0,+0123455.1===+0000002.0,+0000001.0,-0012345.0,-0000001.2===" }
  double4 var1 = (double4) (-12345.032,2.0,2.0,123455.134);
  double4 var2 = (double4) (2.0,1.0,-12345.032,-1.23);
  int i = printf("double4_f_7294c===%+010.1v4lf===%+010.1v4lf===\n",var1,var2);
  return i;
}

int double4_f_7295c() {
  // { dg-printf "double4_f_7295c===-012345.03,-000001.23,+123455.13,+000001.00===+000002.00,+000000.00,+000001.00,+123455.13===" }
  double4 var1 = (double4) (-12345.032,-1.23,123455.134,1.0);
  double4 var2 = (double4) (2.0,0.0,1.0,123455.134);
  int i = printf("double4_f_7295c===%+010.2v4lf===%+010.2v4lf===\n",var1,var2);
  return i;
}

int double4_f_7296c() {
  // { dg-printf "double4_f_7296c===+00001.000,-00001.230,+00001.000,+00002.000===+00002.000,+123455.134,-00001.230,+123455.134===" }
  double4 var1 = (double4) (1.0,-1.23,1.0,2.0);
  double4 var2 = (double4) (2.0,123455.134,-1.23,123455.134);
  int i = printf("double4_f_7296c===%+010.3v4lf===%+010.3v4lf===\n",var1,var2);
  return i;
}

int double4_f_7297c() {
  // { dg-printf "double4_f_7297c===+1.0000000000,+123455.1340000000,+2.0000000000,-1.2300000000===+0.0000000000,+2.0000000000,-12345.0320000000,+2.0000000000===" }
  double4 var1 = (double4) (1.0,123455.134,2.0,-1.23);
  double4 var2 = (double4) (0.0,2.0,-12345.032,2.0);
  int i = printf("double4_f_7297c===%+010.10v4lf===%+010.10v4lf===\n",var1,var2);
  return i;
}

int double4_f_7298c() {
  // { dg-printf "double4_f_7298c===-01.230000,+123455.134000,-12345.032000,-01.230000===+123455.134000,+123455.134000,+00.000000,+01.000000===" }
  double4 var1 = (double4) (-1.23,123455.134,-12345.032,-1.23);
  double4 var2 = (double4) (123455.134,123455.134,0.0,1.0);
  int i = printf("double4_f_7298c===%+010v4lF===%+010v4lF===\n",var1,var2);
  return i;
}

int double4_f_7299c() {
  // { dg-printf "double4_f_7299c===-0012345.0,+0000002.0,-0000001.2,+0000002.0===-0000001.2,+0123455.1,+0123455.1,+0000001.0===" }
  double4 var1 = (double4) (-12345.032,2.0,-1.23,2.0);
  double4 var2 = (double4) (-1.23,123455.134,123455.134,1.0);
  int i = printf("double4_f_7299c===%+010.1v4lF===%+010.1v4lF===\n",var1,var2);
  return i;
}

int double4_f_7300c() {
  // { dg-printf "double4_f_7300c===-012345.03,+000002.00,+123455.13,+000000.00===+000000.00,-000001.23,+000001.00,+000001.00===" }
  double4 var1 = (double4) (-12345.032,2.0,123455.134,0.0);
  double4 var2 = (double4) (0.0,-1.23,1.0,1.0);
  int i = printf("double4_f_7300c===%+010.2v4lF===%+010.2v4lF===\n",var1,var2);
  return i;
}

int double4_f_7301c() {
  // { dg-printf "double4_f_7301c===+00000.000,-00001.230,-12345.032,+00000.000===-00001.230,+00000.000,+123455.134,+00002.000===" }
  double4 var1 = (double4) (0.0,-1.23,-12345.032,0.0);
  double4 var2 = (double4) (-1.23,0.0,123455.134,2.0);
  int i = printf("double4_f_7301c===%+010.3v4lF===%+010.3v4lF===\n",var1,var2);
  return i;
}

int double4_f_7302c() {
  // { dg-printf "double4_f_7302c===-12345.0320000000,-1.2300000000,-1.2300000000,+0.0000000000===+0.0000000000,+1.0000000000,+123455.1340000000,-12345.0320000000===" }
  double4 var1 = (double4) (-12345.032,-1.23,-1.23,0.0);
  double4 var2 = (double4) (0.0,1.0,123455.134,-12345.032);
  int i = printf("double4_f_7302c===%+010.10v4lF===%+010.10v4lF===\n",var1,var2);
  return i;
}

int double4_g_1223c() {
  // { dg-printf "double4_g_1223c===-1.23,1,0,-1.23===0,2,2,2===" }
  double4 var1 = (double4) (-1.23,1.0,0.0,-1.23);
  double4 var2 = (double4) (0.0,2.0,2.0,2.0);
  int i = printf("double4_g_1223c===%-v4lg===%-v4lg===\n",var1,var2);
  return i;
}

int double4_g_1224c() {
  // { dg-printf "double4_g_1224c===-1,1,1,-1e+04===-1e+04,1e+05,-1e+04,2===" }
  double4 var1 = (double4) (-1.23,1.0,1.0,-12345.032);
  double4 var2 = (double4) (-12345.032,123455.134,-12345.032,2.0);
  int i = printf("double4_g_1224c===%-.1v4lg===%-.1v4lg===\n",var1,var2);
  return i;
}

int double4_g_1225c() {
  // { dg-printf "double4_g_1225c===0,-1.2,0,-1.2===-1.2e+04,0,0,0===" }
  double4 var1 = (double4) (0.0,-1.23,0.0,-1.23);
  double4 var2 = (double4) (-12345.032,0.0,0.0,0.0);
  int i = printf("double4_g_1225c===%-.2v4lg===%-.2v4lg===\n",var1,var2);
  return i;
}

int double4_g_1226c() {
  // { dg-printf "double4_g_1226c===1,2,2,0===1,1,2,0===" }
  double4 var1 = (double4) (1.0,2.0,2.0,0.0);
  double4 var2 = (double4) (1.0,1.0,2.0,0.0);
  int i = printf("double4_g_1226c===%-.3v4lg===%-.3v4lg===\n",var1,var2);
  return i;
}

int double4_g_1227c() {
  // { dg-printf "double4_g_1227c===2,2,123455.134,-1.23===-1.23,1,-12345.032,123455.134===" }
  double4 var1 = (double4) (2.0,2.0,123455.134,-1.23);
  double4 var2 = (double4) (-1.23,1.0,-12345.032,123455.134);
  int i = printf("double4_g_1227c===%-.10v4lg===%-.10v4lg===\n",var1,var2);
  return i;
}

int double4_g_1228c() {
  // { dg-printf "double4_g_1228c===2,2,-1.23,-1.23===2,-12345,-1.23,1===" }
  double4 var1 = (double4) (2.0,2.0,-1.23,-1.23);
  double4 var2 = (double4) (2.0,-12345.032,-1.23,1.0);
  int i = printf("double4_g_1228c===%-v4lG===%-v4lG===\n",var1,var2);
  return i;
}

int double4_g_1229c() {
  // { dg-printf "double4_g_1229c===1E+05,-1,-1,2===1E+05,1E+05,1,0===" }
  double4 var1 = (double4) (123455.134,-1.23,-1.23,2.0);
  double4 var2 = (double4) (123455.134,123455.134,1.0,0.0);
  int i = printf("double4_g_1229c===%-.1v4lG===%-.1v4lG===\n",var1,var2);
  return i;
}

int double4_g_1230c() {
  // { dg-printf "double4_g_1230c===-1.2E+04,1,1,-1.2E+04===-1.2E+04,1,-1.2,-1.2===" }
  double4 var1 = (double4) (-12345.032,1.0,1.0,-12345.032);
  double4 var2 = (double4) (-12345.032,1.0,-1.23,-1.23);
  int i = printf("double4_g_1230c===%-.2v4lG===%-.2v4lG===\n",var1,var2);
  return i;
}

int double4_g_1231c() {
  // { dg-printf "double4_g_1231c===2,-1.23E+04,2,-1.23E+04===0,0,1,0===" }
  double4 var1 = (double4) (2.0,-12345.032,2.0,-12345.032);
  double4 var2 = (double4) (0.0,0.0,1.0,0.0);
  int i = printf("double4_g_1231c===%-.3v4lG===%-.3v4lG===\n",var1,var2);
  return i;
}

int double4_g_1232c() {
  // { dg-printf "double4_g_1232c===-1.23,0,123455.134,-12345.032===-1.23,123455.134,2,1===" }
  double4 var1 = (double4) (-1.23,0.0,123455.134,-12345.032);
  double4 var2 = (double4) (-1.23,123455.134,2.0,1.0);
  int i = printf("double4_g_1232c===%-.10v4lG===%-.10v4lG===\n",var1,var2);
  return i;
}

int double4_g_1983c() {
  // { dg-printf "double4_g_1983c===+123455,+1,+123455,-12345===+0,+0,+2,+123455===" }
  double4 var1 = (double4) (123455.134,1.0,123455.134,-12345.032);
  double4 var2 = (double4) (0.0,0.0,2.0,123455.134);
  int i = printf("double4_g_1983c===%+v4lg===%+v4lg===\n",var1,var2);
  return i;
}

int double4_g_1984c() {
  // { dg-printf "double4_g_1984c===-1,+1e+05,+2,+0===+0,+1e+05,+0,+1===" }
  double4 var1 = (double4) (-1.23,123455.134,2.0,0.0);
  double4 var2 = (double4) (0.0,123455.134,0.0,1.0);
  int i = printf("double4_g_1984c===%+.1v4lg===%+.1v4lg===\n",var1,var2);
  return i;
}

int double4_g_1985c() {
  // { dg-printf "double4_g_1985c===-1.2e+04,-1.2e+04,+2,+1.2e+05===+2,-1.2,+1.2e+05,+0===" }
  double4 var1 = (double4) (-12345.032,-12345.032,2.0,123455.134);
  double4 var2 = (double4) (2.0,-1.23,123455.134,0.0);
  int i = printf("double4_g_1985c===%+.2v4lg===%+.2v4lg===\n",var1,var2);
  return i;
}

int double4_g_1986c() {
  // { dg-printf "double4_g_1986c===-1.23,+0,-1.23,+1===+1.23e+05,-1.23,+0,+1.23e+05===" }
  double4 var1 = (double4) (-1.23,0.0,-1.23,1.0);
  double4 var2 = (double4) (123455.134,-1.23,0.0,123455.134);
  int i = printf("double4_g_1986c===%+.3v4lg===%+.3v4lg===\n",var1,var2);
  return i;
}

int double4_g_1987c() {
  // { dg-printf "double4_g_1987c===+2,+2,-1.23,+2===-1.23,+0,-12345.032,-12345.032===" }
  double4 var1 = (double4) (2.0,2.0,-1.23,2.0);
  double4 var2 = (double4) (-1.23,0.0,-12345.032,-12345.032);
  int i = printf("double4_g_1987c===%+.10v4lg===%+.10v4lg===\n",var1,var2);
  return i;
}

int double4_g_1988c() {
  // { dg-printf "double4_g_1988c===-1.23,-12345,+1,+1===+2,+123455,+123455,+0===" }
  double4 var1 = (double4) (-1.23,-12345.032,1.0,1.0);
  double4 var2 = (double4) (2.0,123455.134,123455.134,0.0);
  int i = printf("double4_g_1988c===%+v4lG===%+v4lG===\n",var1,var2);
  return i;
}

int double4_g_1989c() {
  // { dg-printf "double4_g_1989c===+0,+1E+05,+0,+2===-1,-1E+04,+1,-1===" }
  double4 var1 = (double4) (0.0,123455.134,0.0,2.0);
  double4 var2 = (double4) (-1.23,-12345.032,1.0,-1.23);
  int i = printf("double4_g_1989c===%+.1v4lG===%+.1v4lG===\n",var1,var2);
  return i;
}

int double4_g_1990c() {
  // { dg-printf "double4_g_1990c===+1.2E+05,+0,-1.2,+0===+1,+1.2E+05,+0,+0===" }
  double4 var1 = (double4) (123455.134,0.0,-1.23,0.0);
  double4 var2 = (double4) (1.0,123455.134,0.0,0.0);
  int i = printf("double4_g_1990c===%+.2v4lG===%+.2v4lG===\n",var1,var2);
  return i;
}

int double4_g_1991c() {
  // { dg-printf "double4_g_1991c===+0,-1.23E+04,+2,+1.23E+05===-1.23E+04,-1.23,+1,+2===" }
  double4 var1 = (double4) (0.0,-12345.032,2.0,123455.134);
  double4 var2 = (double4) (-12345.032,-1.23,1.0,2.0);
  int i = printf("double4_g_1991c===%+.3v4lG===%+.3v4lG===\n",var1,var2);
  return i;
}

int double4_g_1992c() {
  // { dg-printf "double4_g_1992c===+2,+123455.134,+2,-1.23===+2,+123455.134,+0,+1===" }
  double4 var1 = (double4) (2.0,123455.134,2.0,-1.23);
  double4 var2 = (double4) (2.0,123455.134,0.0,1.0);
  int i = printf("double4_g_1992c===%+.10v4lG===%+.10v4lG===\n",var1,var2);
  return i;
}

int double4_g_2743c() {
  // { dg-printf "double4_g_2743c===-12345.0,2.00000,123455.,-1.23000===-12345.0,-12345.0,-12345.0,-1.23000===" }
  double4 var1 = (double4) (-12345.032,2.0,123455.134,-1.23);
  double4 var2 = (double4) (-12345.032,-12345.032,-12345.032,-1.23);
  int i = printf("double4_g_2743c===%#v4lg===%#v4lg===\n",var1,var2);
  return i;
}

int double4_g_2744c() {
  // { dg-printf "double4_g_2744c===-1.,-1.e+04,1.,1.===0.0,2.,0.0,2.===" }
  double4 var1 = (double4) (-1.23,-12345.032,1.0,1.0);
  double4 var2 = (double4) (0.0,2.0,0.0,2.0);
  int i = printf("double4_g_2744c===%#.1v4lg===%#.1v4lg===\n",var1,var2);
  return i;
}

int double4_g_2745c() {
  // { dg-printf "double4_g_2745c===1.0,2.0,0.00,0.00===1.0,-1.2e+04,-1.2,2.0===" }
  double4 var1 = (double4) (1.0,2.0,0.0,0.0);
  double4 var2 = (double4) (1.0,-12345.032,-1.23,2.0);
  int i = printf("double4_g_2745c===%#.2v4lg===%#.2v4lg===\n",var1,var2);
  return i;
}

int double4_g_2746c() {
  // { dg-printf "double4_g_2746c===1.23e+05,-1.23,1.00,1.23e+05===2.00,0.000,2.00,2.00===" }
  double4 var1 = (double4) (123455.134,-1.23,1.0,123455.134);
  double4 var2 = (double4) (2.0,0.0,2.0,2.0);
  int i = printf("double4_g_2746c===%#.3v4lg===%#.3v4lg===\n",var1,var2);
  return i;
}

int double4_g_2747c() {
  // { dg-printf "double4_g_2747c===1.000000000,2.000000000,-12345.03200,0.0000000000===123455.1340,1.000000000,1.000000000,2.000000000===" }
  double4 var1 = (double4) (1.0,2.0,-12345.032,0.0);
  double4 var2 = (double4) (123455.134,1.0,1.0,2.0);
  int i = printf("double4_g_2747c===%#.10v4lg===%#.10v4lg===\n",var1,var2);
  return i;
}

int double4_g_2748c() {
  // { dg-printf "double4_g_2748c===1.00000,-12345.0,-12345.0,0.000000===1.00000,123455.,2.00000,-12345.0===" }
  double4 var1 = (double4) (1.0,-12345.032,-12345.032,0.0);
  double4 var2 = (double4) (1.0,123455.134,2.0,-12345.032);
  int i = printf("double4_g_2748c===%#v4lG===%#v4lG===\n",var1,var2);
  return i;
}

int double4_g_2749c() {
  // { dg-printf "double4_g_2749c===0.0,-1.E+04,1.E+05,0.0===1.,1.,2.,2.===" }
  double4 var1 = (double4) (0.0,-12345.032,123455.134,0.0);
  double4 var2 = (double4) (1.0,1.0,2.0,2.0);
  int i = printf("double4_g_2749c===%#.1v4lG===%#.1v4lG===\n",var1,var2);
  return i;
}

int double4_g_2750c() {
  // { dg-printf "double4_g_2750c===1.0,1.2E+05,-1.2,-1.2E+04===1.2E+05,2.0,2.0,0.00===" }
  double4 var1 = (double4) (1.0,123455.134,-1.23,-12345.032);
  double4 var2 = (double4) (123455.134,2.0,2.0,0.0);
  int i = printf("double4_g_2750c===%#.2v4lG===%#.2v4lG===\n",var1,var2);
  return i;
}

int double4_g_2751c() {
  // { dg-printf "double4_g_2751c===-1.23E+04,1.00,-1.23E+04,1.23E+05===2.00,1.00,0.000,2.00===" }
  double4 var1 = (double4) (-12345.032,1.0,-12345.032,123455.134);
  double4 var2 = (double4) (2.0,1.0,0.0,2.0);
  int i = printf("double4_g_2751c===%#.3v4lG===%#.3v4lG===\n",var1,var2);
  return i;
}

int double4_g_2752c() {
  // { dg-printf "double4_g_2752c===-12345.03200,123455.1340,-12345.03200,2.000000000===123455.1340,0.0000000000,1.000000000,-12345.03200===" }
  double4 var1 = (double4) (-12345.032,123455.134,-12345.032,2.0);
  double4 var2 = (double4) (123455.134,0.0,1.0,-12345.032);
  int i = printf("double4_g_2752c===%#.10v4lG===%#.10v4lG===\n",var1,var2);
  return i;
}

int double4_g_3503c() {
  // { dg-printf "double4_g_3503c===+123455,+1,-1.23,-12345===+0,+1,-1.23,+1===" }
  double4 var1 = (double4) (123455.134,1.0,-1.23,-12345.032);
  double4 var2 = (double4) (0.0,1.0,-1.23,1.0);
  int i = printf("double4_g_3503c===%-+v4lg===%-+v4lg===\n",var1,var2);
  return i;
}

int double4_g_3504c() {
  // { dg-printf "double4_g_3504c===-1e+04,-1e+04,+1e+05,+0===+1,-1,+2,+0===" }
  double4 var1 = (double4) (-12345.032,-12345.032,123455.134,0.0);
  double4 var2 = (double4) (1.0,-1.23,2.0,0.0);
  int i = printf("double4_g_3504c===%-+.1v4lg===%-+.1v4lg===\n",var1,var2);
  return i;
}

int double4_g_3505c() {
  // { dg-printf "double4_g_3505c===+1.2e+05,+2,+0,+1.2e+05===+2,-1.2e+04,+1.2e+05,+1===" }
  double4 var1 = (double4) (123455.134,2.0,0.0,123455.134);
  double4 var2 = (double4) (2.0,-12345.032,123455.134,1.0);
  int i = printf("double4_g_3505c===%-+.2v4lg===%-+.2v4lg===\n",var1,var2);
  return i;
}

int double4_g_3506c() {
  // { dg-printf "double4_g_3506c===+2,+0,+1,+0===+1.23e+05,+2,-1.23e+04,+1===" }
  double4 var1 = (double4) (2.0,0.0,1.0,0.0);
  double4 var2 = (double4) (123455.134,2.0,-12345.032,1.0);
  int i = printf("double4_g_3506c===%-+.3v4lg===%-+.3v4lg===\n",var1,var2);
  return i;
}

int double4_g_3507c() {
  // { dg-printf "double4_g_3507c===+2,+0,+123455.134,+0===+123455.134,+0,-1.23,+123455.134===" }
  double4 var1 = (double4) (2.0,0.0,123455.134,0.0);
  double4 var2 = (double4) (123455.134,0.0,-1.23,123455.134);
  int i = printf("double4_g_3507c===%-+.10v4lg===%-+.10v4lg===\n",var1,var2);
  return i;
}

int double4_g_3508c() {
  // { dg-printf "double4_g_3508c===-1.23,+123455,+2,-12345===+1,+1,-1.23,+1===" }
  double4 var1 = (double4) (-1.23,123455.134,2.0,-12345.032);
  double4 var2 = (double4) (1.0,1.0,-1.23,1.0);
  int i = printf("double4_g_3508c===%-+v4lG===%-+v4lG===\n",var1,var2);
  return i;
}

int double4_g_3509c() {
  // { dg-printf "double4_g_3509c===+0,+1E+05,+2,+0===+2,+1,+0,-1===" }
  double4 var1 = (double4) (0.0,123455.134,2.0,0.0);
  double4 var2 = (double4) (2.0,1.0,0.0,-1.23);
  int i = printf("double4_g_3509c===%-+.1v4lG===%-+.1v4lG===\n",var1,var2);
  return i;
}

int double4_g_3510c() {
  // { dg-printf "double4_g_3510c===+1.2E+05,+1.2E+05,-1.2E+04,+1===-1.2E+04,+0,-1.2E+04,+1===" }
  double4 var1 = (double4) (123455.134,123455.134,-12345.032,1.0);
  double4 var2 = (double4) (-12345.032,0.0,-12345.032,1.0);
  int i = printf("double4_g_3510c===%-+.2v4lG===%-+.2v4lG===\n",var1,var2);
  return i;
}

int double4_g_3511c() {
  // { dg-printf "double4_g_3511c===-1.23,-1.23E+04,+0,+1===+2,+1.23E+05,+1,-1.23===" }
  double4 var1 = (double4) (-1.23,-12345.032,0.0,1.0);
  double4 var2 = (double4) (2.0,123455.134,1.0,-1.23);
  int i = printf("double4_g_3511c===%-+.3v4lG===%-+.3v4lG===\n",var1,var2);
  return i;
}

int double4_g_3512c() {
  // { dg-printf "double4_g_3512c===+2,+1,+123455.134,+0===+1,+1,-1.23,+1===" }
  double4 var1 = (double4) (2.0,1.0,123455.134,0.0);
  double4 var2 = (double4) (1.0,1.0,-1.23,1.0);
  int i = printf("double4_g_3512c===%-+.10v4lG===%-+.10v4lG===\n",var1,var2);
  return i;
}

int double4_g_4263c() {
  // { dg-printf "double4_g_4263c===    123455,         0,         1,     -1.23===         2,     -1.23,    -12345,         1===" }
  double4 var1 = (double4) (123455.134,0.0,1.0,-1.23);
  double4 var2 = (double4) (2.0,-1.23,-12345.032,1.0);
  int i = printf("double4_g_4263c===% 10v4lg===% 10v4lg===\n",var1,var2);
  return i;
}

int double4_g_4264c() {
  // { dg-printf "double4_g_4264c===         1,         1,         1,         1===    -1e+04,         2,     1e+05,     1e+05===" }
  double4 var1 = (double4) (1.0,1.0,1.0,1.0);
  double4 var2 = (double4) (-12345.032,2.0,123455.134,123455.134);
  int i = printf("double4_g_4264c===% 10.1v4lg===% 10.1v4lg===\n",var1,var2);
  return i;
}

int double4_g_4265c() {
  // { dg-printf "double4_g_4265c===   1.2e+05,      -1.2,   1.2e+05,         1===  -1.2e+04,  -1.2e+04,   1.2e+05,      -1.2===" }
  double4 var1 = (double4) (123455.134,-1.23,123455.134,1.0);
  double4 var2 = (double4) (-12345.032,-12345.032,123455.134,-1.23);
  int i = printf("double4_g_4265c===% 10.2v4lg===% 10.2v4lg===\n",var1,var2);
  return i;
}

int double4_g_4266c() {
  // { dg-printf "double4_g_4266c===         1,         1,     -1.23,         0===     -1.23,         0, -1.23e+04,         2===" }
  double4 var1 = (double4) (1.0,1.0,-1.23,0.0);
  double4 var2 = (double4) (-1.23,0.0,-12345.032,2.0);
  int i = printf("double4_g_4266c===% 10.3v4lg===% 10.3v4lg===\n",var1,var2);
  return i;
}

int double4_g_4267c() {
  // { dg-printf "double4_g_4267c===         2,         0,         1,         2===-12345.032,         2,-12345.032, 123455.134===" }
  double4 var1 = (double4) (2.0,0.0,1.0,2.0);
  double4 var2 = (double4) (-12345.032,2.0,-12345.032,123455.134);
  int i = printf("double4_g_4267c===% 10.10v4lg===% 10.10v4lg===\n",var1,var2);
  return i;
}

int double4_g_4268c() {
  // { dg-printf "double4_g_4268c===         2,    -12345,    123455,         0===    123455,    -12345,    123455,    -12345===" }
  double4 var1 = (double4) (2.0,-12345.032,123455.134,0.0);
  double4 var2 = (double4) (123455.134,-12345.032,123455.134,-12345.032);
  int i = printf("double4_g_4268c===% 10v4lG===% 10v4lG===\n",var1,var2);
  return i;
}

int double4_g_4269c() {
  // { dg-printf "double4_g_4269c===         1,         1,    -1E+04,     1E+05===         0,         2,    -1E+04,         2===" }
  double4 var1 = (double4) (1.0,1.0,-12345.032,123455.134);
  double4 var2 = (double4) (0.0,2.0,-12345.032,2.0);
  int i = printf("double4_g_4269c===% 10.1v4lG===% 10.1v4lG===\n",var1,var2);
  return i;
}

int double4_g_4270c() {
  // { dg-printf "double4_g_4270c===         2,         0,         1,   1.2E+05===         0,         2,         0,  -1.2E+04===" }
  double4 var1 = (double4) (2.0,0.0,1.0,123455.134);
  double4 var2 = (double4) (0.0,2.0,0.0,-12345.032);
  int i = printf("double4_g_4270c===% 10.2v4lG===% 10.2v4lG===\n",var1,var2);
  return i;
}

int double4_g_4271c() {
  // { dg-printf "double4_g_4271c=== -1.23E+04, -1.23E+04,         0,     -1.23===         1,     -1.23,         2,         2===" }
  double4 var1 = (double4) (-12345.032,-12345.032,0.0,-1.23);
  double4 var2 = (double4) (1.0,-1.23,2.0,2.0);
  int i = printf("double4_g_4271c===% 10.3v4lG===% 10.3v4lG===\n",var1,var2);
  return i;
}

int double4_g_4272c() {
  // { dg-printf "double4_g_4272c===-12345.032,         2,         0,     -1.23===     -1.23,-12345.032,-12345.032, 123455.134===" }
  double4 var1 = (double4) (-12345.032,2.0,0.0,-1.23);
  double4 var2 = (double4) (-1.23,-12345.032,-12345.032,123455.134);
  int i = printf("double4_g_4272c===% 10.10v4lG===% 10.10v4lG===\n",var1,var2);
  return i;
}

int double4_g_463c() {
  // { dg-printf "double4_g_463c===-1.23,0,-1.23,-12345===0,2,123455,123455===" }
  double4 var1 = (double4) (-1.23,0.0,-1.23,-12345.032);
  double4 var2 = (double4) (0.0,2.0,123455.134,123455.134);
  int i = printf("double4_g_463c===%v4lg===%v4lg===\n",var1,var2);
  return i;
}

int double4_g_464c() {
  // { dg-printf "double4_g_464c===1,1,-1e+04,2===-1e+04,-1,1e+05,1e+05===" }
  double4 var1 = (double4) (1.0,1.0,-12345.032,2.0);
  double4 var2 = (double4) (-12345.032,-1.23,123455.134,123455.134);
  int i = printf("double4_g_464c===%.1v4lg===%.1v4lg===\n",var1,var2);
  return i;
}

int double4_g_465c() {
  // { dg-printf "double4_g_465c===1,2,0,1.2e+05===0,2,1,1===" }
  double4 var1 = (double4) (1.0,2.0,0.0,123455.134);
  double4 var2 = (double4) (0.0,2.0,1.0,1.0);
  int i = printf("double4_g_465c===%.2v4lg===%.2v4lg===\n",var1,var2);
  return i;
}

int double4_g_466c() {
  // { dg-printf "double4_g_466c===-1.23,-1.23,2,1===-1.23,-1.23e+04,1,1.23e+05===" }
  double4 var1 = (double4) (-1.23,-1.23,2.0,1.0);
  double4 var2 = (double4) (-1.23,-12345.032,1.0,123455.134);
  int i = printf("double4_g_466c===%.3v4lg===%.3v4lg===\n",var1,var2);
  return i;
}

int double4_g_467c() {
  // { dg-printf "double4_g_467c===2,0,1,2===123455.134,-1.23,1,-1.23===" }
  double4 var1 = (double4) (2.0,0.0,1.0,2.0);
  double4 var2 = (double4) (123455.134,-1.23,1.0,-1.23);
  int i = printf("double4_g_467c===%.10v4lg===%.10v4lg===\n",var1,var2);
  return i;
}

int double4_g_468c() {
  // { dg-printf "double4_g_468c===123455,-12345,0,2===-1.23,1,-12345,-12345===" }
  double4 var1 = (double4) (123455.134,-12345.032,0.0,2.0);
  double4 var2 = (double4) (-1.23,1.0,-12345.032,-12345.032);
  int i = printf("double4_g_468c===%v4lG===%v4lG===\n",var1,var2);
  return i;
}

int double4_g_469c() {
  // { dg-printf "double4_g_469c===2,2,1E+05,-1E+04===1,0,1E+05,1E+05===" }
  double4 var1 = (double4) (2.0,2.0,123455.134,-12345.032);
  double4 var2 = (double4) (1.0,0.0,123455.134,123455.134);
  int i = printf("double4_g_469c===%.1v4lG===%.1v4lG===\n",var1,var2);
  return i;
}

int double4_g_470c() {
  // { dg-printf "double4_g_470c===-1.2,0,-1.2E+04,1===1.2E+05,1.2E+05,-1.2E+04,-1.2===" }
  double4 var1 = (double4) (-1.23,0.0,-12345.032,1.0);
  double4 var2 = (double4) (123455.134,123455.134,-12345.032,-1.23);
  int i = printf("double4_g_470c===%.2v4lG===%.2v4lG===\n",var1,var2);
  return i;
}

int double4_g_471c() {
  // { dg-printf "double4_g_471c===1,1,1.23E+05,1===1.23E+05,-1.23E+04,1,1===" }
  double4 var1 = (double4) (1.0,1.0,123455.134,1.0);
  double4 var2 = (double4) (123455.134,-12345.032,1.0,1.0);
  int i = printf("double4_g_471c===%.3v4lG===%.3v4lG===\n",var1,var2);
  return i;
}

int double4_g_472c() {
  // { dg-printf "double4_g_472c===2,-1.23,0,-1.23===123455.134,2,2,0===" }
  double4 var1 = (double4) (2.0,-1.23,0.0,-1.23);
  double4 var2 = (double4) (123455.134,2.0,2.0,0.0);
  int i = printf("double4_g_472c===%.10v4lG===%.10v4lG===\n",var1,var2);
  return i;
}

int double4_g_5023c() {
  // { dg-printf "double4_g_5023c===-000001.23,0000000000,0000000000,0000000001===0000000000,-000012345,0000000000,-000012345===" }
  double4 var1 = (double4) (-1.23,0.0,0.0,1.0);
  double4 var2 = (double4) (0.0,-12345.032,0.0,-12345.032);
  int i = printf("double4_g_5023c===%010v4lg===%010v4lg===\n",var1,var2);
  return i;
}

int double4_g_5024c() {
  // { dg-printf "double4_g_5024c===0000000002,0000000002,0000000001,0000000000===-00001e+04,0000000000,0000000001,000001e+05===" }
  double4 var1 = (double4) (2.0,2.0,1.0,0.0);
  double4 var2 = (double4) (-12345.032,0.0,1.0,123455.134);
  int i = printf("double4_g_5024c===%010.1v4lg===%010.1v4lg===\n",var1,var2);
  return i;
}

int double4_g_5025c() {
  // { dg-printf "double4_g_5025c===0000000002,0000000001,0000000000,0000000000===-0000001.2,0000000001,0000000002,0001.2e+05===" }
  double4 var1 = (double4) (2.0,1.0,0.0,0.0);
  double4 var2 = (double4) (-1.23,1.0,2.0,123455.134);
  int i = printf("double4_g_5025c===%010.2v4lg===%010.2v4lg===\n",var1,var2);
  return i;
}

int double4_g_5026c() {
  // { dg-printf "double4_g_5026c===0000000002,0000000001,0000000002,-000001.23===001.23e+05,-000001.23,0000000001,-000001.23===" }
  double4 var1 = (double4) (2.0,1.0,2.0,-1.23);
  double4 var2 = (double4) (123455.134,-1.23,1.0,-1.23);
  int i = printf("double4_g_5026c===%010.3v4lg===%010.3v4lg===\n",var1,var2);
  return i;
}

int double4_g_5027c() {
  // { dg-printf "double4_g_5027c===123455.134,-000001.23,0000000002,-12345.032===-000001.23,0000000002,-000001.23,0000000002===" }
  double4 var1 = (double4) (123455.134,-1.23,2.0,-12345.032);
  double4 var2 = (double4) (-1.23,2.0,-1.23,2.0);
  int i = printf("double4_g_5027c===%010.10v4lg===%010.10v4lg===\n",var1,var2);
  return i;
}

int double4_g_5028c() {
  // { dg-printf "double4_g_5028c===-000001.23,-000001.23,-000012345,0000000000===0000123455,0000000000,-000012345,-000001.23===" }
  double4 var1 = (double4) (-1.23,-1.23,-12345.032,0.0);
  double4 var2 = (double4) (123455.134,0.0,-12345.032,-1.23);
  int i = printf("double4_g_5028c===%010v4lG===%010v4lG===\n",var1,var2);
  return i;
}

int double4_g_5029c() {
  // { dg-printf "double4_g_5029c===0000000002,0000000001,-000000001,0000000001===-000000001,0000000002,-000000001,0000000002===" }
  double4 var1 = (double4) (2.0,1.0,-1.23,1.0);
  double4 var2 = (double4) (-1.23,2.0,-1.23,2.0);
  int i = printf("double4_g_5029c===%010.1v4lG===%010.1v4lG===\n",var1,var2);
  return i;
}

int double4_g_5030c() {
  // { dg-printf "double4_g_5030c===0000000000,0000000001,-001.2E+04,0000000001===0000000002,0000000002,0000000000,-0000001.2===" }
  double4 var1 = (double4) (0.0,1.0,-12345.032,1.0);
  double4 var2 = (double4) (2.0,2.0,0.0,-1.23);
  int i = printf("double4_g_5030c===%010.2v4lG===%010.2v4lG===\n",var1,var2);
  return i;
}

int double4_g_5031c() {
  // { dg-printf "double4_g_5031c===-000001.23,-01.23E+04,-01.23E+04,-000001.23===001.23E+05,0000000001,-01.23E+04,0000000001===" }
  double4 var1 = (double4) (-1.23,-12345.032,-12345.032,-1.23);
  double4 var2 = (double4) (123455.134,1.0,-12345.032,1.0);
  int i = printf("double4_g_5031c===%010.3v4lG===%010.3v4lG===\n",var1,var2);
  return i;
}

int double4_g_5032c() {
  // { dg-printf "double4_g_5032c===-12345.032,0000000002,0000000000,123455.134===0000000000,0000000002,0000000001,-12345.032===" }
  double4 var1 = (double4) (-12345.032,2.0,0.0,123455.134);
  double4 var2 = (double4) (0.0,2.0,1.0,-12345.032);
  int i = printf("double4_g_5032c===%010.10v4lG===%010.10v4lG===\n",var1,var2);
  return i;
}

int double4_g_5783c() {
  // { dg-printf "double4_g_5783c=== 1        , 1        , 1        , 123455   ===-12345    , 1        , 123455   ,-1.23     ===" }
  double4 var1 = (double4) (1.0,1.0,1.0,123455.134);
  double4 var2 = (double4) (-12345.032,1.0,123455.134,-1.23);
  int i = printf("double4_g_5783c===%- 10v4lg===%- 10v4lg===\n",var1,var2);
  return i;
}

int double4_g_5784c() {
  // { dg-printf "double4_g_5784c=== 0        ,-1        ,-1        , 1e+05    === 2        , 1e+05    ,-1        ,-1e+04    ===" }
  double4 var1 = (double4) (0.0,-1.23,-1.23,123455.134);
  double4 var2 = (double4) (2.0,123455.134,-1.23,-12345.032);
  int i = printf("double4_g_5784c===%- 10.1v4lg===%- 10.1v4lg===\n",var1,var2);
  return i;
}

int double4_g_5785c() {
  // { dg-printf "double4_g_5785c=== 2        , 1.2e+05  , 2        , 0        === 1.2e+05  , 0        ,-1.2e+04  , 1.2e+05  ===" }
  double4 var1 = (double4) (2.0,123455.134,2.0,0.0);
  double4 var2 = (double4) (123455.134,0.0,-12345.032,123455.134);
  int i = printf("double4_g_5785c===%- 10.2v4lg===%- 10.2v4lg===\n",var1,var2);
  return i;
}

int double4_g_5786c() {
  // { dg-printf "double4_g_5786c=== 1.23e+05 , 1        , 1.23e+05 , 1.23e+05 === 2        , 1.23e+05 ,-1.23e+04 ,-1.23     ===" }
  double4 var1 = (double4) (123455.134,1.0,123455.134,123455.134);
  double4 var2 = (double4) (2.0,123455.134,-12345.032,-1.23);
  int i = printf("double4_g_5786c===%- 10.3v4lg===%- 10.3v4lg===\n",var1,var2);
  return i;
}

int double4_g_5787c() {
  // { dg-printf "double4_g_5787c=== 2        , 0        , 0        ,-12345.032===-12345.032, 1        , 2        , 1        ===" }
  double4 var1 = (double4) (2.0,0.0,0.0,-12345.032);
  double4 var2 = (double4) (-12345.032,1.0,2.0,1.0);
  int i = printf("double4_g_5787c===%- 10.10v4lg===%- 10.10v4lg===\n",var1,var2);
  return i;
}

int double4_g_5788c() {
  // { dg-printf "double4_g_5788c=== 1        , 1        , 123455   , 2        ===-1.23     , 123455   , 1        , 2        ===" }
  double4 var1 = (double4) (1.0,1.0,123455.134,2.0);
  double4 var2 = (double4) (-1.23,123455.134,1.0,2.0);
  int i = printf("double4_g_5788c===%- 10v4lG===%- 10v4lG===\n",var1,var2);
  return i;
}

int double4_g_5789c() {
  // { dg-printf "double4_g_5789c=== 0        , 0        , 1        ,-1        ===-1        , 1        , 2        , 2        ===" }
  double4 var1 = (double4) (0.0,0.0,1.0,-1.23);
  double4 var2 = (double4) (-1.23,1.0,2.0,2.0);
  int i = printf("double4_g_5789c===%- 10.1v4lG===%- 10.1v4lG===\n",var1,var2);
  return i;
}

int double4_g_5790c() {
  // { dg-printf "double4_g_5790c===-1.2E+04  , 2        , 1        ,-1.2E+04  === 1        , 0        , 1        , 2        ===" }
  double4 var1 = (double4) (-12345.032,2.0,1.0,-12345.032);
  double4 var2 = (double4) (1.0,0.0,1.0,2.0);
  int i = printf("double4_g_5790c===%- 10.2v4lG===%- 10.2v4lG===\n",var1,var2);
  return i;
}

int double4_g_5791c() {
  // { dg-printf "double4_g_5791c=== 2        ,-1.23E+04 ,-1.23E+04 , 0        ===-1.23     , 0        , 0        , 2        ===" }
  double4 var1 = (double4) (2.0,-12345.032,-12345.032,0.0);
  double4 var2 = (double4) (-1.23,0.0,0.0,2.0);
  int i = printf("double4_g_5791c===%- 10.3v4lG===%- 10.3v4lG===\n",var1,var2);
  return i;
}

int double4_g_5792c() {
  // { dg-printf "double4_g_5792c=== 123455.134, 1        ,-1.23     , 0        === 1        ,-1.23     , 0        , 2        ===" }
  double4 var1 = (double4) (123455.134,1.0,-1.23,0.0);
  double4 var2 = (double4) (1.0,-1.23,0.0,2.0);
  int i = printf("double4_g_5792c===%- 10.10v4lG===%- 10.10v4lG===\n",var1,var2);
  return i;
}

int double4_g_6543c() {
  // { dg-printf "double4_g_6543c===        +1,     -1.23,        +2,    -12345===        +2,        +2,     -1.23,     -1.23===" }
  double4 var1 = (double4) (1.0,-1.23,2.0,-12345.032);
  double4 var2 = (double4) (2.0,2.0,-1.23,-1.23);
  int i = printf("double4_g_6543c===%+ 10v4lg===%+ 10v4lg===\n",var1,var2);
  return i;
}

int double4_g_6544c() {
  // { dg-printf "double4_g_6544c===        +2,        +1,        +0,    +1e+05===        +0,        +2,        +0,    -1e+04===" }
  double4 var1 = (double4) (2.0,1.0,0.0,123455.134);
  double4 var2 = (double4) (0.0,2.0,0.0,-12345.032);
  int i = printf("double4_g_6544c===%+ 10.1v4lg===%+ 10.1v4lg===\n",var1,var2);
  return i;
}

int double4_g_6545c() {
  // { dg-printf "double4_g_6545c===  -1.2e+04,  -1.2e+04,        +1,        +2===        +0,        +2,  -1.2e+04,        +1===" }
  double4 var1 = (double4) (-12345.032,-12345.032,1.0,2.0);
  double4 var2 = (double4) (0.0,2.0,-12345.032,1.0);
  int i = printf("double4_g_6545c===%+ 10.2v4lg===%+ 10.2v4lg===\n",var1,var2);
  return i;
}

int double4_g_6546c() {
  // { dg-printf "double4_g_6546c===        +1, +1.23e+05,     -1.23,        +1===        +2,        +1,        +2, -1.23e+04===" }
  double4 var1 = (double4) (1.0,123455.134,-1.23,1.0);
  double4 var2 = (double4) (2.0,1.0,2.0,-12345.032);
  int i = printf("double4_g_6546c===%+ 10.3v4lg===%+ 10.3v4lg===\n",var1,var2);
  return i;
}

int double4_g_6547c() {
  // { dg-printf "double4_g_6547c===        +0,+123455.134,+123455.134,        +0===     -1.23,        +0,        +2,+123455.134===" }
  double4 var1 = (double4) (0.0,123455.134,123455.134,0.0);
  double4 var2 = (double4) (-1.23,0.0,2.0,123455.134);
  int i = printf("double4_g_6547c===%+ 10.10v4lg===%+ 10.10v4lg===\n",var1,var2);
  return i;
}

int double4_g_6548c() {
  // { dg-printf "double4_g_6548c===   +123455,        +1,   +123455,        +1===    -12345,        +0,    -12345,        +1===" }
  double4 var1 = (double4) (123455.134,1.0,123455.134,1.0);
  double4 var2 = (double4) (-12345.032,0.0,-12345.032,1.0);
  int i = printf("double4_g_6548c===%+ 10v4lG===%+ 10v4lG===\n",var1,var2);
  return i;
}

int double4_g_6549c() {
  // { dg-printf "double4_g_6549c===        +1,    +1E+05,    -1E+04,        +2===    -1E+04,    +1E+05,        +0,    +1E+05===" }
  double4 var1 = (double4) (1.0,123455.134,-12345.032,2.0);
  double4 var2 = (double4) (-12345.032,123455.134,0.0,123455.134);
  int i = printf("double4_g_6549c===%+ 10.1v4lG===%+ 10.1v4lG===\n",var1,var2);
  return i;
}

int double4_g_6550c() {
  // { dg-printf "double4_g_6550c===      -1.2,      -1.2,        +0,      -1.2===        +1,        +1,        +1,      -1.2===" }
  double4 var1 = (double4) (-1.23,-1.23,0.0,-1.23);
  double4 var2 = (double4) (1.0,1.0,1.0,-1.23);
  int i = printf("double4_g_6550c===%+ 10.2v4lG===%+ 10.2v4lG===\n",var1,var2);
  return i;
}

int double4_g_6551c() {
  // { dg-printf "double4_g_6551c===        +2,        +2,        +1, -1.23E+04===        +0,        +2,        +2,     -1.23===" }
  double4 var1 = (double4) (2.0,2.0,1.0,-12345.032);
  double4 var2 = (double4) (0.0,2.0,2.0,-1.23);
  int i = printf("double4_g_6551c===%+ 10.3v4lG===%+ 10.3v4lG===\n",var1,var2);
  return i;
}

int double4_g_6552c() {
  // { dg-printf "double4_g_6552c===-12345.032,     -1.23,     -1.23,        +2===        +2,+123455.134,     -1.23,     -1.23===" }
  double4 var1 = (double4) (-12345.032,-1.23,-1.23,2.0);
  double4 var2 = (double4) (2.0,123455.134,-1.23,-1.23);
  int i = printf("double4_g_6552c===%+ 10.10v4lG===%+ 10.10v4lG===\n",var1,var2);
  return i;
}

int double4_g_7303c() {
  // { dg-printf "double4_g_7303c===+000123455,-000012345,-000012345,+000000001===+000000000,+000123455,+000123455,+000123455===" }
  double4 var1 = (double4) (123455.134,-12345.032,-12345.032,1.0);
  double4 var2 = (double4) (0.0,123455.134,123455.134,123455.134);
  int i = printf("double4_g_7303c===%+010v4lg===%+010v4lg===\n",var1,var2);
  return i;
}

int double4_g_7304c() {
  // { dg-printf "double4_g_7304c===-00001e+04,+00001e+05,+00001e+05,-00001e+04===+00001e+05,+000000002,+000000002,-00001e+04===" }
  double4 var1 = (double4) (-12345.032,123455.134,123455.134,-12345.032);
  double4 var2 = (double4) (123455.134,2.0,2.0,-12345.032);
  int i = printf("double4_g_7304c===%+010.1v4lg===%+010.1v4lg===\n",var1,var2);
  return i;
}

int double4_g_7305c() {
  // { dg-printf "double4_g_7305c===+000000001,-0000001.2,+000000001,-001.2e+04===-0000001.2,-0000001.2,-001.2e+04,+000000000===" }
  double4 var1 = (double4) (1.0,-1.23,1.0,-12345.032);
  double4 var2 = (double4) (-1.23,-1.23,-12345.032,0.0);
  int i = printf("double4_g_7305c===%+010.2v4lg===%+010.2v4lg===\n",var1,var2);
  return i;
}

int double4_g_7306c() {
  // { dg-printf "double4_g_7306c===+01.23e+05,+000000000,+000000002,-000001.23===+000000002,-01.23e+04,+000000001,+000000001===" }
  double4 var1 = (double4) (123455.134,0.0,2.0,-1.23);
  double4 var2 = (double4) (2.0,-12345.032,1.0,1.0);
  int i = printf("double4_g_7306c===%+010.3v4lg===%+010.3v4lg===\n",var1,var2);
  return i;
}

int double4_g_7307c() {
  // { dg-printf "double4_g_7307c===+123455.134,-12345.032,+123455.134,-12345.032===+123455.134,+000000002,+123455.134,-12345.032===" }
  double4 var1 = (double4) (123455.134,-12345.032,123455.134,-12345.032);
  double4 var2 = (double4) (123455.134,2.0,123455.134,-12345.032);
  int i = printf("double4_g_7307c===%+010.10v4lg===%+010.10v4lg===\n",var1,var2);
  return i;
}

int double4_g_7308c() {
  // { dg-printf "double4_g_7308c===+000000000,-000012345,+000123455,+000123455===+000000001,-000012345,+000000002,+000123455===" }
  double4 var1 = (double4) (0.0,-12345.032,123455.134,123455.134);
  double4 var2 = (double4) (1.0,-12345.032,2.0,123455.134);
  int i = printf("double4_g_7308c===%+010v4lG===%+010v4lG===\n",var1,var2);
  return i;
}

int double4_g_7309c() {
  // { dg-printf "double4_g_7309c===-000000001,+000000001,+00001E+05,+000000002===-000000001,+000000002,+00001E+05,+000000002===" }
  double4 var1 = (double4) (-1.23,1.0,123455.134,2.0);
  double4 var2 = (double4) (-1.23,2.0,123455.134,2.0);
  int i = printf("double4_g_7309c===%+010.1v4lG===%+010.1v4lG===\n",var1,var2);
  return i;
}

int double4_g_7310c() {
  // { dg-printf "double4_g_7310c===+000000001,-001.2E+04,+000000002,+000000001===+000000001,-0000001.2,-0000001.2,+000000000===" }
  double4 var1 = (double4) (1.0,-12345.032,2.0,1.0);
  double4 var2 = (double4) (1.0,-1.23,-1.23,0.0);
  int i = printf("double4_g_7310c===%+010.2v4lG===%+010.2v4lG===\n",var1,var2);
  return i;
}

int double4_g_7311c() {
  // { dg-printf "double4_g_7311c===+000000002,+01.23E+05,-000001.23,+000000000===-000001.23,+000000001,-000001.23,+000000002===" }
  double4 var1 = (double4) (2.0,123455.134,-1.23,0.0);
  double4 var2 = (double4) (-1.23,1.0,-1.23,2.0);
  int i = printf("double4_g_7311c===%+010.3v4lG===%+010.3v4lG===\n",var1,var2);
  return i;
}

int double4_g_7312c() {
  // { dg-printf "double4_g_7312c===+000000001,+000000002,+000000000,+123455.134===-12345.032,+123455.134,+000000001,+123455.134===" }
  double4 var1 = (double4) (1.0,2.0,0.0,123455.134);
  double4 var2 = (double4) (-12345.032,123455.134,1.0,123455.134);
  int i = printf("double4_g_7312c===%+010.10v4lG===%+010.10v4lG===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = double4_a_1193c();
i = double4_a_1194c();
i = double4_a_1195c();
i = double4_a_1196c();
i = double4_a_1197c();
i = double4_a_1198c();
i = double4_a_1199c();
i = double4_a_1200c();
i = double4_a_1201c();
i = double4_a_1202c();
i = double4_a_1953c();
i = double4_a_1954c();
i = double4_a_1955c();
i = double4_a_1956c();
i = double4_a_1957c();
i = double4_a_1958c();
i = double4_a_1959c();
i = double4_a_1960c();
i = double4_a_1961c();
i = double4_a_1962c();
i = double4_a_2713c();
i = double4_a_2714c();
i = double4_a_2715c();
i = double4_a_2716c();
i = double4_a_2717c();
i = double4_a_2718c();
i = double4_a_2719c();
i = double4_a_2720c();
i = double4_a_2721c();
i = double4_a_2722c();
i = double4_a_3473c();
i = double4_a_3474c();
i = double4_a_3475c();
i = double4_a_3476c();
i = double4_a_3477c();
i = double4_a_3478c();
i = double4_a_3479c();
i = double4_a_3480c();
i = double4_a_3481c();
i = double4_a_3482c();
i = double4_a_4233c();
i = double4_a_4234c();
i = double4_a_4235c();
i = double4_a_4236c();
i = double4_a_4237c();
i = double4_a_4238c();
i = double4_a_4239c();
i = double4_a_4240c();
i = double4_a_4241c();
i = double4_a_4242c();
i = double4_a_433c();
i = double4_a_434c();
i = double4_a_435c();
i = double4_a_436c();
i = double4_a_437c();
i = double4_a_438c();
i = double4_a_439c();
i = double4_a_440c();
i = double4_a_441c();
i = double4_a_442c();
i = double4_a_4993c();
i = double4_a_4994c();
i = double4_a_4995c();
i = double4_a_4996c();
i = double4_a_4997c();
i = double4_a_4998c();
i = double4_a_4999c();
i = double4_a_5000c();
i = double4_a_5001c();
i = double4_a_5002c();
i = double4_a_5753c();
i = double4_a_5754c();
i = double4_a_5755c();
i = double4_a_5756c();
i = double4_a_5757c();
i = double4_a_5758c();
i = double4_a_5759c();
i = double4_a_5760c();
i = double4_a_5761c();
i = double4_a_5762c();
i = double4_a_6513c();
i = double4_a_6514c();
i = double4_a_6515c();
i = double4_a_6516c();
i = double4_a_6517c();
i = double4_a_6518c();
i = double4_a_6519c();
i = double4_a_6520c();
i = double4_a_6521c();
i = double4_a_6522c();
i = double4_a_7273c();
i = double4_a_7274c();
i = double4_a_7275c();
i = double4_a_7276c();
i = double4_a_7277c();
i = double4_a_7278c();
i = double4_a_7279c();
i = double4_a_7280c();
i = double4_a_7281c();
i = double4_a_7282c();
i = double4_e_1203c();
i = double4_e_1204c();
i = double4_e_1205c();
i = double4_e_1206c();
i = double4_e_1207c();
i = double4_e_1208c();
i = double4_e_1209c();
i = double4_e_1210c();
i = double4_e_1211c();
i = double4_e_1212c();
i = double4_e_1963c();
i = double4_e_1964c();
i = double4_e_1965c();
i = double4_e_1966c();
i = double4_e_1967c();
i = double4_e_1968c();
i = double4_e_1969c();
i = double4_e_1970c();
i = double4_e_1971c();
i = double4_e_1972c();
i = double4_e_2723c();
i = double4_e_2724c();
i = double4_e_2725c();
i = double4_e_2726c();
i = double4_e_2727c();
i = double4_e_2728c();
i = double4_e_2729c();
i = double4_e_2730c();
i = double4_e_2731c();
i = double4_e_2732c();
i = double4_e_3483c();
i = double4_e_3484c();
i = double4_e_3485c();
i = double4_e_3486c();
i = double4_e_3487c();
i = double4_e_3488c();
i = double4_e_3489c();
i = double4_e_3490c();
i = double4_e_3491c();
i = double4_e_3492c();
i = double4_e_4243c();
i = double4_e_4244c();
i = double4_e_4245c();
i = double4_e_4246c();
i = double4_e_4247c();
i = double4_e_4248c();
i = double4_e_4249c();
i = double4_e_4250c();
i = double4_e_4251c();
i = double4_e_4252c();
i = double4_e_443c();
i = double4_e_444c();
i = double4_e_445c();
i = double4_e_446c();
i = double4_e_447c();
i = double4_e_448c();
i = double4_e_449c();
i = double4_e_450c();
i = double4_e_451c();
i = double4_e_452c();
i = double4_e_5003c();
i = double4_e_5004c();
i = double4_e_5005c();
i = double4_e_5006c();
i = double4_e_5007c();
i = double4_e_5008c();
i = double4_e_5009c();
i = double4_e_5010c();
i = double4_e_5011c();
i = double4_e_5012c();
i = double4_e_5763c();
i = double4_e_5764c();
i = double4_e_5765c();
i = double4_e_5766c();
i = double4_e_5767c();
i = double4_e_5768c();
i = double4_e_5769c();
i = double4_e_5770c();
i = double4_e_5771c();
i = double4_e_5772c();
i = double4_e_6523c();
i = double4_e_6524c();
i = double4_e_6525c();
i = double4_e_6526c();
i = double4_e_6527c();
i = double4_e_6528c();
i = double4_e_6529c();
i = double4_e_6530c();
i = double4_e_6531c();
i = double4_e_6532c();
i = double4_e_7283c();
i = double4_e_7284c();
i = double4_e_7285c();
i = double4_e_7286c();
i = double4_e_7287c();
i = double4_e_7288c();
i = double4_e_7289c();
i = double4_e_7290c();
i = double4_e_7291c();
i = double4_e_7292c();
i = double4_f_1213c();
i = double4_f_1214c();
i = double4_f_1215c();
i = double4_f_1216c();
i = double4_f_1217c();
i = double4_f_1218c();
i = double4_f_1219c();
i = double4_f_1220c();
i = double4_f_1221c();
i = double4_f_1222c();
i = double4_f_1973c();
i = double4_f_1974c();
i = double4_f_1975c();
i = double4_f_1976c();
i = double4_f_1977c();
i = double4_f_1978c();
i = double4_f_1979c();
i = double4_f_1980c();
i = double4_f_1981c();
i = double4_f_1982c();
i = double4_f_2733c();
i = double4_f_2734c();
i = double4_f_2735c();
i = double4_f_2736c();
i = double4_f_2737c();
i = double4_f_2738c();
i = double4_f_2739c();
i = double4_f_2740c();
i = double4_f_2741c();
i = double4_f_2742c();
i = double4_f_3493c();
i = double4_f_3494c();
i = double4_f_3495c();
i = double4_f_3496c();
i = double4_f_3497c();
i = double4_f_3498c();
i = double4_f_3499c();
i = double4_f_3500c();
i = double4_f_3501c();
i = double4_f_3502c();
i = double4_f_4253c();
i = double4_f_4254c();
i = double4_f_4255c();
i = double4_f_4256c();
i = double4_f_4257c();
i = double4_f_4258c();
i = double4_f_4259c();
i = double4_f_4260c();
i = double4_f_4261c();
i = double4_f_4262c();
i = double4_f_453c();
i = double4_f_454c();
i = double4_f_455c();
i = double4_f_456c();
i = double4_f_457c();
i = double4_f_458c();
i = double4_f_459c();
i = double4_f_460c();
i = double4_f_461c();
i = double4_f_462c();
i = double4_f_5013c();
i = double4_f_5014c();
i = double4_f_5015c();
i = double4_f_5016c();
i = double4_f_5017c();
i = double4_f_5018c();
i = double4_f_5019c();
i = double4_f_5020c();
i = double4_f_5021c();
i = double4_f_5022c();
i = double4_f_5773c();
i = double4_f_5774c();
i = double4_f_5775c();
i = double4_f_5776c();
i = double4_f_5777c();
i = double4_f_5778c();
i = double4_f_5779c();
i = double4_f_5780c();
i = double4_f_5781c();
i = double4_f_5782c();
i = double4_f_6533c();
i = double4_f_6534c();
i = double4_f_6535c();
i = double4_f_6536c();
i = double4_f_6537c();
i = double4_f_6538c();
i = double4_f_6539c();
i = double4_f_6540c();
i = double4_f_6541c();
i = double4_f_6542c();
i = double4_f_7293c();
i = double4_f_7294c();
i = double4_f_7295c();
i = double4_f_7296c();
i = double4_f_7297c();
i = double4_f_7298c();
i = double4_f_7299c();
i = double4_f_7300c();
i = double4_f_7301c();
i = double4_f_7302c();
i = double4_g_1223c();
i = double4_g_1224c();
i = double4_g_1225c();
i = double4_g_1226c();
i = double4_g_1227c();
i = double4_g_1228c();
i = double4_g_1229c();
i = double4_g_1230c();
i = double4_g_1231c();
i = double4_g_1232c();
i = double4_g_1983c();
i = double4_g_1984c();
i = double4_g_1985c();
i = double4_g_1986c();
i = double4_g_1987c();
i = double4_g_1988c();
i = double4_g_1989c();
i = double4_g_1990c();
i = double4_g_1991c();
i = double4_g_1992c();
i = double4_g_2743c();
i = double4_g_2744c();
i = double4_g_2745c();
i = double4_g_2746c();
i = double4_g_2747c();
i = double4_g_2748c();
i = double4_g_2749c();
i = double4_g_2750c();
i = double4_g_2751c();
i = double4_g_2752c();
i = double4_g_3503c();
i = double4_g_3504c();
i = double4_g_3505c();
i = double4_g_3506c();
i = double4_g_3507c();
i = double4_g_3508c();
i = double4_g_3509c();
i = double4_g_3510c();
i = double4_g_3511c();
i = double4_g_3512c();
i = double4_g_4263c();
i = double4_g_4264c();
i = double4_g_4265c();
i = double4_g_4266c();
i = double4_g_4267c();
i = double4_g_4268c();
i = double4_g_4269c();
i = double4_g_4270c();
i = double4_g_4271c();
i = double4_g_4272c();
i = double4_g_463c();
i = double4_g_464c();
i = double4_g_465c();
i = double4_g_466c();
i = double4_g_467c();
i = double4_g_468c();
i = double4_g_469c();
i = double4_g_470c();
i = double4_g_471c();
i = double4_g_472c();
i = double4_g_5023c();
i = double4_g_5024c();
i = double4_g_5025c();
i = double4_g_5026c();
i = double4_g_5027c();
i = double4_g_5028c();
i = double4_g_5029c();
i = double4_g_5030c();
i = double4_g_5031c();
i = double4_g_5032c();
i = double4_g_5783c();
i = double4_g_5784c();
i = double4_g_5785c();
i = double4_g_5786c();
i = double4_g_5787c();
i = double4_g_5788c();
i = double4_g_5789c();
i = double4_g_5790c();
i = double4_g_5791c();
i = double4_g_5792c();
i = double4_g_6543c();
i = double4_g_6544c();
i = double4_g_6545c();
i = double4_g_6546c();
i = double4_g_6547c();
i = double4_g_6548c();
i = double4_g_6549c();
i = double4_g_6550c();
i = double4_g_6551c();
i = double4_g_6552c();
i = double4_g_7303c();
i = double4_g_7304c();
i = double4_g_7305c();
i = double4_g_7306c();
i = double4_g_7307c();
i = double4_g_7308c();
i = double4_g_7309c();
i = double4_g_7310c();
i = double4_g_7311c();
i = double4_g_7312c();
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
