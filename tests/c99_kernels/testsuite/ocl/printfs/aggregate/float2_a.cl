/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/float2_a.c'  */

int float2_a_1003c() {
  // { dg-printf "float2_a_1003c===0x1.0000000000000p+0,-0x1.81c8420000000p+13===0x1.0000000000000p+1,0x1.0000000000000p+0===" }
  float2 var1 = (float2) (1.0,-12345.032);
  float2 var2 = (float2) (2.0,1.0);
  int i = printf("float2_a_1003c===%-v2hla===%-v2hla===\n",var1,var2);
  return i;
}

int float2_a_1004c() {
  // { dg-printf "float2_a_1004c===0x1.0p+1,0x1.ep+16===-0x1.8p+13,-0x1.4p+0===" }
  float2 var1 = (float2) (2.0,123455.134);
  float2 var2 = (float2) (-12345.032,-1.23);
  int i = printf("float2_a_1004c===%-.1v2hla===%-.1v2hla===\n",var1,var2);
  return i;
}

int float2_a_1005c() {
  // { dg-printf "float2_a_1005c===-0x1.3bp+0,0x1.00p+1===0x1.00p+0,0x0.00p+0===" }
  float2 var1 = (float2) (-1.23,2.0);
  float2 var2 = (float2) (1.0,0.0);
  int i = printf("float2_a_1005c===%-.2v2hla===%-.2v2hla===\n",var1,var2);
  return i;
}

int float2_a_1006c() {
  // { dg-printf "float2_a_1006c===0x0.000p+0,0x1.000p+0===-0x1.81cp+13,-0x1.3aep+0===" }
  float2 var1 = (float2) (0.0,1.0);
  float2 var2 = (float2) (-12345.032,-1.23);
  int i = printf("float2_a_1006c===%-.3v2hla===%-.3v2hla===\n",var1,var2);
  return i;
}

int float2_a_1007c() {
  // { dg-printf "float2_a_1007c===0x1.0000000000p+0,0x1.e23f220000p+16===-0x1.81c8420000p+13,-0x1.81c8420000p+13===" }
  float2 var1 = (float2) (1.0,123455.134);
  float2 var2 = (float2) (-12345.032,-12345.032);
  int i = printf("float2_a_1007c===%-.10v2hla===%-.10v2hla===\n",var1,var2);
  return i;
}

int float2_a_1008c() {
  // { dg-printf "float2_a_1008c===-0X1.81C8420000000P+13,0X1.0000000000000P+1===0X1.0000000000000P+0,0X1.E23F220000000P+16===" }
  float2 var1 = (float2) (-12345.032,2.0);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_a_1008c===%-v2hlA===%-v2hlA===\n",var1,var2);
  return i;
}

int float2_a_1009c() {
  // { dg-printf "float2_a_1009c===-0X1.8P+13,0X1.0P+0===0X1.EP+16,-0X1.8P+13===" }
  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (123455.134,-12345.032);
  int i = printf("float2_a_1009c===%-.1v2hlA===%-.1v2hlA===\n",var1,var2);
  return i;
}

int float2_a_1010c() {
  // { dg-printf "float2_a_1010c===-0X1.82P+13,0X0.00P+0===-0X1.82P+13,0X1.E2P+16===" }
  float2 var1 = (float2) (-12345.032,0.0);
  float2 var2 = (float2) (-12345.032,123455.134);
  int i = printf("float2_a_1010c===%-.2v2hlA===%-.2v2hlA===\n",var1,var2);
  return i;
}

int float2_a_1011c() {
  // { dg-printf "float2_a_1011c===0X0.000P+0,0X1.E24P+16===0X1.000P+1,0X1.E24P+16===" }
  float2 var1 = (float2) (0.0,123455.134);
  float2 var2 = (float2) (2.0,123455.134);
  int i = printf("float2_a_1011c===%-.3v2hlA===%-.3v2hlA===\n",var1,var2);
  return i;
}

int float2_a_1012c() {
  // { dg-printf "float2_a_1012c===-0X1.81C8420000P+13,-0X1.81C8420000P+13===0X1.E23F220000P+16,0X1.0000000000P+0===" }
  float2 var1 = (float2) (-12345.032,-12345.032);
  float2 var2 = (float2) (123455.134,1.0);
  int i = printf("float2_a_1012c===%-.10v2hlA===%-.10v2hlA===\n",var1,var2);
  return i;
}

int float2_a_1763c() {
  // { dg-printf "float2_a_1763c===-0x1.3ae1480000000p+0,+0x1.0000000000000p+1===+0x1.0000000000000p+0,+0x0.0000000000000p+0===" }
  float2 var1 = (float2) (-1.23,2.0);
  float2 var2 = (float2) (1.0,0.0);
  int i = printf("float2_a_1763c===%+v2hla===%+v2hla===\n",var1,var2);
  return i;
}

int float2_a_1764c() {
  // { dg-printf "float2_a_1764c===+0x0.0p+0,+0x1.0p+1===+0x0.0p+0,+0x1.0p+0===" }
  float2 var1 = (float2) (0.0,2.0);
  float2 var2 = (float2) (0.0,1.0);
  int i = printf("float2_a_1764c===%+.1v2hla===%+.1v2hla===\n",var1,var2);
  return i;
}

int float2_a_1765c() {
  // { dg-printf "float2_a_1765c===+0x1.e2p+16,+0x1.00p+1===+0x1.00p+0,+0x0.00p+0===" }
  float2 var1 = (float2) (123455.134,2.0);
  float2 var2 = (float2) (1.0,0.0);
  int i = printf("float2_a_1765c===%+.2v2hla===%+.2v2hla===\n",var1,var2);
  return i;
}

int float2_a_1766c() {
  // { dg-printf "float2_a_1766c===+0x1.e24p+16,-0x1.3aep+0===+0x1.000p+1,-0x1.81cp+13===" }
  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (2.0,-12345.032);
  int i = printf("float2_a_1766c===%+.3v2hla===%+.3v2hla===\n",var1,var2);
  return i;
}

int float2_a_1767c() {
  // { dg-printf "float2_a_1767c===-0x1.81c8420000p+13,+0x1.0000000000p+0===+0x0.0000000000p+0,+0x1.0000000000p+0===" }
  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (0.0,1.0);
  int i = printf("float2_a_1767c===%+.10v2hla===%+.10v2hla===\n",var1,var2);
  return i;
}

int float2_a_1768c() {
  // { dg-printf "float2_a_1768c===-0X1.3AE1480000000P+0,+0X0.0000000000000P+0===+0X1.E23F220000000P+16,-0X1.3AE1480000000P+0===" }
  float2 var1 = (float2) (-1.23,0.0);
  float2 var2 = (float2) (123455.134,-1.23);
  int i = printf("float2_a_1768c===%+v2hlA===%+v2hlA===\n",var1,var2);
  return i;
}

int float2_a_1769c() {
  // { dg-printf "float2_a_1769c===-0X1.4P+0,+0X1.0P+0===+0X1.0P+1,+0X1.0P+1===" }
  float2 var1 = (float2) (-1.23,1.0);
  float2 var2 = (float2) (2.0,2.0);
  int i = printf("float2_a_1769c===%+.1v2hlA===%+.1v2hlA===\n",var1,var2);
  return i;
}

int float2_a_1770c() {
  // { dg-printf "float2_a_1770c===+0X0.00P+0,+0X1.00P+0===+0X0.00P+0,-0X1.82P+13===" }
  float2 var1 = (float2) (0.0,1.0);
  float2 var2 = (float2) (0.0,-12345.032);
  int i = printf("float2_a_1770c===%+.2v2hlA===%+.2v2hlA===\n",var1,var2);
  return i;
}

int float2_a_1771c() {
  // { dg-printf "float2_a_1771c===+0X0.000P+0,-0X1.3AEP+0===+0X1.000P+1,+0X1.E24P+16===" }
  float2 var1 = (float2) (0.0,-1.23);
  float2 var2 = (float2) (2.0,123455.134);
  int i = printf("float2_a_1771c===%+.3v2hlA===%+.3v2hlA===\n",var1,var2);
  return i;
}

int float2_a_1772c() {
  // { dg-printf "float2_a_1772c===-0X1.81C8420000P+13,-0X1.81C8420000P+13===-0X1.3AE1480000P+0,+0X0.0000000000P+0===" }
  float2 var1 = (float2) (-12345.032,-12345.032);
  float2 var2 = (float2) (-1.23,0.0);
  int i = printf("float2_a_1772c===%+.10v2hlA===%+.10v2hlA===\n",var1,var2);
  return i;
}

int float2_a_243c() {
  // { dg-printf "float2_a_243c===0x1.e23f220000000p+16,0x1.e23f220000000p+16===0x1.0000000000000p+1,0x1.e23f220000000p+16===" }
  float2 var1 = (float2) (123455.134,123455.134);
  float2 var2 = (float2) (2.0,123455.134);
  int i = printf("float2_a_243c===%v2hla===%v2hla===\n",var1,var2);
  return i;
}

int float2_a_244c() {
  // { dg-printf "float2_a_244c===0x1.0p+0,-0x1.8p+13===0x1.0p+0,0x1.0p+1===" }
  float2 var1 = (float2) (1.0,-12345.032);
  float2 var2 = (float2) (1.0,2.0);
  int i = printf("float2_a_244c===%.1v2hla===%.1v2hla===\n",var1,var2);
  return i;
}

int float2_a_245c() {
  // { dg-printf "float2_a_245c===0x0.00p+0,0x1.e2p+16===0x1.00p+0,0x0.00p+0===" }
  float2 var1 = (float2) (0.0,123455.134);
  float2 var2 = (float2) (1.0,0.0);
  int i = printf("float2_a_245c===%.2v2hla===%.2v2hla===\n",var1,var2);
  return i;
}

int float2_a_246c() {
  // { dg-printf "float2_a_246c===0x1.000p+0,-0x1.81cp+13===0x0.000p+0,0x1.000p+0===" }
  float2 var1 = (float2) (1.0,-12345.032);
  float2 var2 = (float2) (0.0,1.0);
  int i = printf("float2_a_246c===%.3v2hla===%.3v2hla===\n",var1,var2);
  return i;
}

int float2_a_247c() {
  // { dg-printf "float2_a_247c===-0x1.3ae1480000p+0,0x1.e23f220000p+16===0x1.0000000000p+1,-0x1.3ae1480000p+0===" }
  float2 var1 = (float2) (-1.23,123455.134);
  float2 var2 = (float2) (2.0,-1.23);
  int i = printf("float2_a_247c===%.10v2hla===%.10v2hla===\n",var1,var2);
  return i;
}

int float2_a_248c() {
  // { dg-printf "float2_a_248c===0X1.E23F220000000P+16,-0X1.81C8420000000P+13===0X1.E23F220000000P+16,-0X1.81C8420000000P+13===" }
  float2 var1 = (float2) (123455.134,-12345.032);
  float2 var2 = (float2) (123455.134,-12345.032);
  int i = printf("float2_a_248c===%v2hlA===%v2hlA===\n",var1,var2);
  return i;
}

int float2_a_249c() {
  // { dg-printf "float2_a_249c===-0X1.8P+13,0X1.EP+16===0X1.0P+1,-0X1.4P+0===" }
  float2 var1 = (float2) (-12345.032,123455.134);
  float2 var2 = (float2) (2.0,-1.23);
  int i = printf("float2_a_249c===%.1v2hlA===%.1v2hlA===\n",var1,var2);
  return i;
}

int float2_a_250c() {
  // { dg-printf "float2_a_250c===0X1.E2P+16,0X1.00P+1===0X1.00P+1,-0X1.3BP+0===" }
  float2 var1 = (float2) (123455.134,2.0);
  float2 var2 = (float2) (2.0,-1.23);
  int i = printf("float2_a_250c===%.2v2hlA===%.2v2hlA===\n",var1,var2);
  return i;
}

int float2_a_251c() {
  // { dg-printf "float2_a_251c===0X1.E24P+16,-0X1.3AEP+0===0X1.E24P+16,0X1.000P+0===" }
  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (123455.134,1.0);
  int i = printf("float2_a_251c===%.3v2hlA===%.3v2hlA===\n",var1,var2);
  return i;
}

int float2_a_252c() {
  // { dg-printf "float2_a_252c===-0X1.81C8420000P+13,0X1.0000000000P+0===0X1.E23F220000P+16,0X0.0000000000P+0===" }
  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (123455.134,0.0);
  int i = printf("float2_a_252c===%.10v2hlA===%.10v2hlA===\n",var1,var2);
  return i;
}

int float2_a_2523c() {
  // { dg-printf "float2_a_2523c===-0x1.81c8420000000p+13,0x0.0000000000000p+0===-0x1.81c8420000000p+13,-0x1.81c8420000000p+13===" }
  float2 var1 = (float2) (-12345.032,0.0);
  float2 var2 = (float2) (-12345.032,-12345.032);
  int i = printf("float2_a_2523c===%#v2hla===%#v2hla===\n",var1,var2);
  return i;
}

int float2_a_2524c() {
  // { dg-printf "float2_a_2524c===0x1.0p+1,0x1.0p+1===0x1.ep+16,0x1.ep+16===" }
  float2 var1 = (float2) (2.0,2.0);
  float2 var2 = (float2) (123455.134,123455.134);
  int i = printf("float2_a_2524c===%#.1v2hla===%#.1v2hla===\n",var1,var2);
  return i;
}

int float2_a_2525c() {
  // { dg-printf "float2_a_2525c===0x1.e2p+16,0x1.e2p+16===0x1.e2p+16,0x1.e2p+16===" }
  float2 var1 = (float2) (123455.134,123455.134);
  float2 var2 = (float2) (123455.134,123455.134);
  int i = printf("float2_a_2525c===%#.2v2hla===%#.2v2hla===\n",var1,var2);
  return i;
}

int float2_a_2526c() {
  // { dg-printf "float2_a_2526c===0x0.000p+0,0x1.e24p+16===0x0.000p+0,-0x1.3aep+0===" }
  float2 var1 = (float2) (0.0,123455.134);
  float2 var2 = (float2) (0.0,-1.23);
  int i = printf("float2_a_2526c===%#.3v2hla===%#.3v2hla===\n",var1,var2);
  return i;
}

int float2_a_2527c() {
  // { dg-printf "float2_a_2527c===0x1.e23f220000p+16,-0x1.81c8420000p+13===-0x1.81c8420000p+13,0x1.e23f220000p+16===" }
  float2 var1 = (float2) (123455.134,-12345.032);
  float2 var2 = (float2) (-12345.032,123455.134);
  int i = printf("float2_a_2527c===%#.10v2hla===%#.10v2hla===\n",var1,var2);
  return i;
}

int float2_a_2528c() {
  // { dg-printf "float2_a_2528c===0X0.0000000000000P+0,-0X1.81C8420000000P+13===-0X1.81C8420000000P+13,0X1.0000000000000P+1===" }
  float2 var1 = (float2) (0.0,-12345.032);
  float2 var2 = (float2) (-12345.032,2.0);
  int i = printf("float2_a_2528c===%#v2hlA===%#v2hlA===\n",var1,var2);
  return i;
}

int float2_a_2529c() {
  // { dg-printf "float2_a_2529c===0X1.0P+1,-0X1.8P+13===-0X1.4P+0,0X1.0P+0===" }
  float2 var1 = (float2) (2.0,-12345.032);
  float2 var2 = (float2) (-1.23,1.0);
  int i = printf("float2_a_2529c===%#.1v2hlA===%#.1v2hlA===\n",var1,var2);
  return i;
}

int float2_a_2530c() {
  // { dg-printf "float2_a_2530c===0X1.E2P+16,-0X1.82P+13===0X0.00P+0,-0X1.3BP+0===" }
  float2 var1 = (float2) (123455.134,-12345.032);
  float2 var2 = (float2) (0.0,-1.23);
  int i = printf("float2_a_2530c===%#.2v2hlA===%#.2v2hlA===\n",var1,var2);
  return i;
}

int float2_a_2531c() {
  // { dg-printf "float2_a_2531c===0X1.000P+1,-0X1.3AEP+0===-0X1.81CP+13,0X0.000P+0===" }
  float2 var1 = (float2) (2.0,-1.23);
  float2 var2 = (float2) (-12345.032,0.0);
  int i = printf("float2_a_2531c===%#.3v2hlA===%#.3v2hlA===\n",var1,var2);
  return i;
}

int float2_a_2532c() {
  // { dg-printf "float2_a_2532c===-0X1.3AE1480000P+0,0X0.0000000000P+0===0X0.0000000000P+0,0X1.0000000000P+1===" }
  float2 var1 = (float2) (-1.23,0.0);
  float2 var2 = (float2) (0.0,2.0);
  int i = printf("float2_a_2532c===%#.10v2hlA===%#.10v2hlA===\n",var1,var2);
  return i;
}

int float2_a_3283c() {
  // { dg-printf "float2_a_3283c===+0x0.0000000000000p+0,+0x0.0000000000000p+0===-0x1.81c8420000000p+13,+0x0.0000000000000p+0===" }
  float2 var1 = (float2) (0.0,0.0);
  float2 var2 = (float2) (-12345.032,0.0);
  int i = printf("float2_a_3283c===%-+v2hla===%-+v2hla===\n",var1,var2);
  return i;
}

int float2_a_3284c() {
  // { dg-printf "float2_a_3284c===+0x0.0p+0,+0x0.0p+0===+0x1.ep+16,+0x1.0p+0===" }
  float2 var1 = (float2) (0.0,0.0);
  float2 var2 = (float2) (123455.134,1.0);
  int i = printf("float2_a_3284c===%-+.1v2hla===%-+.1v2hla===\n",var1,var2);
  return i;
}

int float2_a_3285c() {
  // { dg-printf "float2_a_3285c===+0x0.00p+0,+0x0.00p+0===+0x1.00p+0,+0x1.e2p+16===" }
  float2 var1 = (float2) (0.0,0.0);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_a_3285c===%-+.2v2hla===%-+.2v2hla===\n",var1,var2);
  return i;
}

int float2_a_3286c() {
  // { dg-printf "float2_a_3286c===-0x1.3aep+0,-0x1.81cp+13===-0x1.81cp+13,-0x1.81cp+13===" }
  float2 var1 = (float2) (-1.23,-12345.032);
  float2 var2 = (float2) (-12345.032,-12345.032);
  int i = printf("float2_a_3286c===%-+.3v2hla===%-+.3v2hla===\n",var1,var2);
  return i;
}

int float2_a_3287c() {
  // { dg-printf "float2_a_3287c===-0x1.81c8420000p+13,-0x1.81c8420000p+13===+0x1.0000000000p+1,+0x1.0000000000p+0===" }
  float2 var1 = (float2) (-12345.032,-12345.032);
  float2 var2 = (float2) (2.0,1.0);
  int i = printf("float2_a_3287c===%-+.10v2hla===%-+.10v2hla===\n",var1,var2);
  return i;
}

int float2_a_3288c() {
  // { dg-printf "float2_a_3288c===+0X1.0000000000000P+0,+0X1.0000000000000P+0===-0X1.81C8420000000P+13,+0X0.0000000000000P+0===" }
  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (-12345.032,0.0);
  int i = printf("float2_a_3288c===%-+v2hlA===%-+v2hlA===\n",var1,var2);
  return i;
}

int float2_a_3289c() {
  // { dg-printf "float2_a_3289c===-0X1.4P+0,-0X1.8P+13===+0X1.0P+1,+0X1.0P+1===" }
  float2 var1 = (float2) (-1.23,-12345.032);
  float2 var2 = (float2) (2.0,2.0);
  int i = printf("float2_a_3289c===%-+.1v2hlA===%-+.1v2hlA===\n",var1,var2);
  return i;
}

int float2_a_3290c() {
  // { dg-printf "float2_a_3290c===+0X1.00P+0,+0X1.00P+0===+0X1.00P+1,+0X1.E2P+16===" }
  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (2.0,123455.134);
  int i = printf("float2_a_3290c===%-+.2v2hlA===%-+.2v2hlA===\n",var1,var2);
  return i;
}

int float2_a_3291c() {
  // { dg-printf "float2_a_3291c===+0X1.000P+1,-0X1.3AEP+0===-0X1.81CP+13,-0X1.3AEP+0===" }
  float2 var1 = (float2) (2.0,-1.23);
  float2 var2 = (float2) (-12345.032,-1.23);
  int i = printf("float2_a_3291c===%-+.3v2hlA===%-+.3v2hlA===\n",var1,var2);
  return i;
}

int float2_a_3292c() {
  // { dg-printf "float2_a_3292c===-0X1.81C8420000P+13,-0X1.81C8420000P+13===+0X1.E23F220000P+16,-0X1.3AE1480000P+0===" }
  float2 var1 = (float2) (-12345.032,-12345.032);
  float2 var2 = (float2) (123455.134,-1.23);
  int i = printf("float2_a_3292c===%-+.10v2hlA===%-+.10v2hlA===\n",var1,var2);
  return i;
}

int float2_a_4043c() {
  // { dg-printf "float2_a_4043c=== 0x0.0000000000000p+0, 0x1.0000000000000p+1===-0x1.81c8420000000p+13, 0x0.0000000000000p+0===" }
  float2 var1 = (float2) (0.0,2.0);
  float2 var2 = (float2) (-12345.032,0.0);
  int i = printf("float2_a_4043c===% 10v2hla===% 10v2hla===\n",var1,var2);
  return i;
}

int float2_a_4044c() {
  // { dg-printf "float2_a_4044c=== 0x1.ep+16,  0x1.0p+0=== -0x1.4p+0, 0x1.ep+16===" }
  float2 var1 = (float2) (123455.134,1.0);
  float2 var2 = (float2) (-1.23,123455.134);
  int i = printf("float2_a_4044c===% 10.1v2hla===% 10.1v2hla===\n",var1,var2);
  return i;
}

int float2_a_4045c() {
  // { dg-printf "float2_a_4045c=== 0x1.e2p+16,-0x1.3bp+0===-0x1.82p+13, 0x1.e2p+16===" }
  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (-12345.032,123455.134);
  int i = printf("float2_a_4045c===% 10.2v2hla===% 10.2v2hla===\n",var1,var2);
  return i;
}

int float2_a_4046c() {
  // { dg-printf "float2_a_4046c=== 0x1.000p+0, 0x1.000p+0=== 0x1.e24p+16,-0x1.81cp+13===" }
  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (123455.134,-12345.032);
  int i = printf("float2_a_4046c===% 10.3v2hla===% 10.3v2hla===\n",var1,var2);
  return i;
}

int float2_a_4047c() {
  // { dg-printf "float2_a_4047c===-0x1.3ae1480000p+0, 0x0.0000000000p+0===-0x1.3ae1480000p+0, 0x0.0000000000p+0===" }
  float2 var1 = (float2) (-1.23,0.0);
  float2 var2 = (float2) (-1.23,0.0);
  int i = printf("float2_a_4047c===% 10.10v2hla===% 10.10v2hla===\n",var1,var2);
  return i;
}

int float2_a_4048c() {
  // { dg-printf "float2_a_4048c=== 0X1.E23F220000000P+16,-0X1.3AE1480000000P+0=== 0X1.E23F220000000P+16,-0X1.81C8420000000P+13===" }
  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (123455.134,-12345.032);
  int i = printf("float2_a_4048c===% 10v2hlA===% 10v2hlA===\n",var1,var2);
  return i;
}

int float2_a_4049c() {
  // { dg-printf "float2_a_4049c===  0X1.0P+1,  0X0.0P+0===-0X1.8P+13, 0X1.EP+16===" }
  float2 var1 = (float2) (2.0,0.0);
  float2 var2 = (float2) (-12345.032,123455.134);
  int i = printf("float2_a_4049c===% 10.1v2hlA===% 10.1v2hlA===\n",var1,var2);
  return i;
}

int float2_a_4050c() {
  // { dg-printf "float2_a_4050c=== 0X1.E2P+16,-0X1.3BP+0===-0X1.3BP+0, 0X1.00P+0===" }
  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (-1.23,1.0);
  int i = printf("float2_a_4050c===% 10.2v2hlA===% 10.2v2hlA===\n",var1,var2);
  return i;
}

int float2_a_4051c() {
  // { dg-printf "float2_a_4051c===-0X1.81CP+13, 0X0.000P+0===-0X1.3AEP+0, 0X1.E24P+16===" }
  float2 var1 = (float2) (-12345.032,0.0);
  float2 var2 = (float2) (-1.23,123455.134);
  int i = printf("float2_a_4051c===% 10.3v2hlA===% 10.3v2hlA===\n",var1,var2);
  return i;
}

int float2_a_4052c() {
  // { dg-printf "float2_a_4052c=== 0X1.0000000000P+0,-0X1.3AE1480000P+0=== 0X1.0000000000P+0, 0X1.0000000000P+0===" }
  float2 var1 = (float2) (1.0,-1.23);
  float2 var2 = (float2) (1.0,1.0);
  int i = printf("float2_a_4052c===% 10.10v2hlA===% 10.10v2hlA===\n",var1,var2);
  return i;
}

int float2_a_4803c() {
  // { dg-printf "float2_a_4803c===0x1.e23f220000000p+16,-0x1.81c8420000000p+13===-0x1.81c8420000000p+13,0x1.0000000000000p+0===" }
  float2 var1 = (float2) (123455.134,-12345.032);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_a_4803c===%010v2hla===%010v2hla===\n",var1,var2);
  return i;
}

int float2_a_4804c() {
  // { dg-printf "float2_a_4804c===0x000.0p+0,0x001.0p+1===-0x01.4p+0,0x001.0p+1===" }
  float2 var1 = (float2) (0.0,2.0);
  float2 var2 = (float2) (-1.23,2.0);
  int i = printf("float2_a_4804c===%010.1v2hla===%010.1v2hla===\n",var1,var2);
  return i;
}

int float2_a_4805c() {
  // { dg-printf "float2_a_4805c===-0x1.82p+13,0x00.00p+0===0x00.00p+0,0x01.00p+0===" }
  float2 var1 = (float2) (-12345.032,0.0);
  float2 var2 = (float2) (0.0,1.0);
  int i = printf("float2_a_4805c===%010.2v2hla===%010.2v2hla===\n",var1,var2);
  return i;
}

int float2_a_4806c() {
  // { dg-printf "float2_a_4806c===-0x1.81cp+13,0x1.000p+0===0x1.e24p+16,0x1.000p+1===" }
  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (123455.134,2.0);
  int i = printf("float2_a_4806c===%010.3v2hla===%010.3v2hla===\n",var1,var2);
  return i;
}

int float2_a_4807c() {
  // { dg-printf "float2_a_4807c===0x1.e23f220000p+16,-0x1.81c8420000p+13===0x1.0000000000p+0,0x0.0000000000p+0===" }
  float2 var1 = (float2) (123455.134,-12345.032);
  float2 var2 = (float2) (1.0,0.0);
  int i = printf("float2_a_4807c===%010.10v2hla===%010.10v2hla===\n",var1,var2);
  return i;
}

int float2_a_4808c() {
  // { dg-printf "float2_a_4808c===-0X1.81C8420000000P+13,0X1.0000000000000P+1===0X1.0000000000000P+0,0X1.E23F220000000P+16===" }
  float2 var1 = (float2) (-12345.032,2.0);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_a_4808c===%010v2hlA===%010v2hlA===\n",var1,var2);
  return i;
}

int float2_a_4809c() {
  // { dg-printf "float2_a_4809c===0X001.0P+0,-0X1.8P+13===0X000.0P+0,-0X1.8P+13===" }
  float2 var1 = (float2) (1.0,-12345.032);
  float2 var2 = (float2) (0.0,-12345.032);
  int i = printf("float2_a_4809c===%010.1v2hlA===%010.1v2hlA===\n",var1,var2);
  return i;
}

int float2_a_4810c() {
  // { dg-printf "float2_a_4810c===0X01.00P+1,-0X1.3BP+0===0X1.E2P+16,0X01.00P+1===" }
  float2 var1 = (float2) (2.0,-1.23);
  float2 var2 = (float2) (123455.134,2.0);
  int i = printf("float2_a_4810c===%010.2v2hlA===%010.2v2hlA===\n",var1,var2);
  return i;
}

int float2_a_4811c() {
  // { dg-printf "float2_a_4811c===-0X1.81CP+13,0X1.000P+0===-0X1.81CP+13,0X1.E24P+16===" }
  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (-12345.032,123455.134);
  int i = printf("float2_a_4811c===%010.3v2hlA===%010.3v2hlA===\n",var1,var2);
  return i;
}

int float2_a_4812c() {
  // { dg-printf "float2_a_4812c===0X1.0000000000P+0,-0X1.3AE1480000P+0===0X0.0000000000P+0,0X1.E23F220000P+16===" }
  float2 var1 = (float2) (1.0,-1.23);
  float2 var2 = (float2) (0.0,123455.134);
  int i = printf("float2_a_4812c===%010.10v2hlA===%010.10v2hlA===\n",var1,var2);
  return i;
}

int float2_a_5563c() {
  // { dg-printf "float2_a_5563c===-0x1.81c8420000000p+13,-0x1.3ae1480000000p+0===-0x1.81c8420000000p+13, 0x1.0000000000000p+0===" }
  float2 var1 = (float2) (-12345.032,-1.23);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_a_5563c===%- 10v2hla===%- 10v2hla===\n",var1,var2);
  return i;
}

int float2_a_5564c() {
  // { dg-printf "float2_a_5564c=== 0x1.0p+0 , 0x1.0p+0 === 0x1.0p+1 , 0x1.ep+16===" }
  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (2.0,123455.134);
  int i = printf("float2_a_5564c===%- 10.1v2hla===%- 10.1v2hla===\n",var1,var2);
  return i;
}

int float2_a_5565c() {
  // { dg-printf "float2_a_5565c=== 0x1.e2p+16,-0x1.82p+13=== 0x1.00p+0, 0x1.e2p+16===" }
  float2 var1 = (float2) (123455.134,-12345.032);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_a_5565c===%- 10.2v2hla===%- 10.2v2hla===\n",var1,var2);
  return i;
}

int float2_a_5566c() {
  // { dg-printf "float2_a_5566c=== 0x1.000p+1,-0x1.81cp+13=== 0x1.000p+1, 0x1.000p+1===" }
  float2 var1 = (float2) (2.0,-12345.032);
  float2 var2 = (float2) (2.0,2.0);
  int i = printf("float2_a_5566c===%- 10.3v2hla===%- 10.3v2hla===\n",var1,var2);
  return i;
}

int float2_a_5567c() {
  // { dg-printf "float2_a_5567c===-0x1.81c8420000p+13, 0x0.0000000000p+0=== 0x1.0000000000p+1, 0x1.0000000000p+1===" }
  float2 var1 = (float2) (-12345.032,0.0);
  float2 var2 = (float2) (2.0,2.0);
  int i = printf("float2_a_5567c===%- 10.10v2hla===%- 10.10v2hla===\n",var1,var2);
  return i;
}

int float2_a_5568c() {
  // { dg-printf "float2_a_5568c=== 0X0.0000000000000P+0, 0X1.0000000000000P+1=== 0X0.0000000000000P+0, 0X0.0000000000000P+0===" }
  float2 var1 = (float2) (0.0,2.0);
  float2 var2 = (float2) (0.0,0.0);
  int i = printf("float2_a_5568c===%- 10v2hlA===%- 10v2hlA===\n",var1,var2);
  return i;
}

int float2_a_5569c() {
  // { dg-printf "float2_a_5569c===-0X1.4P+0 ,-0X1.4P+0 === 0X1.EP+16, 0X1.0P+1 ===" }
  float2 var1 = (float2) (-1.23,-1.23);
  float2 var2 = (float2) (123455.134,2.0);
  int i = printf("float2_a_5569c===%- 10.1v2hlA===%- 10.1v2hlA===\n",var1,var2);
  return i;
}

int float2_a_5570c() {
  // { dg-printf "float2_a_5570c===-0X1.82P+13, 0X1.00P+0=== 0X0.00P+0,-0X1.82P+13===" }
  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (0.0,-12345.032);
  int i = printf("float2_a_5570c===%- 10.2v2hlA===%- 10.2v2hlA===\n",var1,var2);
  return i;
}

int float2_a_5571c() {
  // { dg-printf "float2_a_5571c=== 0X1.E24P+16, 0X0.000P+0=== 0X1.000P+1, 0X1.E24P+16===" }
  float2 var1 = (float2) (123455.134,0.0);
  float2 var2 = (float2) (2.0,123455.134);
  int i = printf("float2_a_5571c===%- 10.3v2hlA===%- 10.3v2hlA===\n",var1,var2);
  return i;
}

int float2_a_5572c() {
  // { dg-printf "float2_a_5572c=== 0X1.0000000000P+0, 0X1.0000000000P+0=== 0X1.E23F220000P+16, 0X0.0000000000P+0===" }
  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (123455.134,0.0);
  int i = printf("float2_a_5572c===%- 10.10v2hlA===%- 10.10v2hlA===\n",var1,var2);
  return i;
}

int float2_a_6323c() {
  // { dg-printf "float2_a_6323c===+0x1.e23f220000000p+16,+0x1.e23f220000000p+16===+0x1.e23f220000000p+16,-0x1.3ae1480000000p+0===" }
  float2 var1 = (float2) (123455.134,123455.134);
  float2 var2 = (float2) (123455.134,-1.23);
  int i = printf("float2_a_6323c===%+ 10v2hla===%+ 10v2hla===\n",var1,var2);
  return i;
}

int float2_a_6324c() {
  // { dg-printf "float2_a_6324c=== +0x0.0p+0, +0x1.0p+1=== -0x1.4p+0, +0x0.0p+0===" }
  float2 var1 = (float2) (0.0,2.0);
  float2 var2 = (float2) (-1.23,0.0);
  int i = printf("float2_a_6324c===%+ 10.1v2hla===%+ 10.1v2hla===\n",var1,var2);
  return i;
}

int float2_a_6325c() {
  // { dg-printf "float2_a_6325c===-0x1.82p+13,-0x1.82p+13===+0x1.00p+1,+0x1.e2p+16===" }
  float2 var1 = (float2) (-12345.032,-12345.032);
  float2 var2 = (float2) (2.0,123455.134);
  int i = printf("float2_a_6325c===%+ 10.2v2hla===%+ 10.2v2hla===\n",var1,var2);
  return i;
}

int float2_a_6326c() {
  // { dg-printf "float2_a_6326c===+0x0.000p+0,-0x1.3aep+0===+0x1.000p+0,-0x1.3aep+0===" }
  float2 var1 = (float2) (0.0,-1.23);
  float2 var2 = (float2) (1.0,-1.23);
  int i = printf("float2_a_6326c===%+ 10.3v2hla===%+ 10.3v2hla===\n",var1,var2);
  return i;
}

int float2_a_6327c() {
  // { dg-printf "float2_a_6327c===-0x1.81c8420000p+13,+0x1.0000000000p+0===+0x1.e23f220000p+16,+0x1.0000000000p+0===" }
  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (123455.134,1.0);
  int i = printf("float2_a_6327c===%+ 10.10v2hla===%+ 10.10v2hla===\n",var1,var2);
  return i;
}

int float2_a_6328c() {
  // { dg-printf "float2_a_6328c===+0X1.E23F220000000P+16,+0X0.0000000000000P+0===+0X1.0000000000000P+1,+0X1.0000000000000P+0===" }
  float2 var1 = (float2) (123455.134,0.0);
  float2 var2 = (float2) (2.0,1.0);
  int i = printf("float2_a_6328c===%+ 10v2hlA===%+ 10v2hlA===\n",var1,var2);
  return i;
}

int float2_a_6329c() {
  // { dg-printf "float2_a_6329c=== -0X1.4P+0,-0X1.8P+13=== +0X0.0P+0, +0X1.0P+1===" }
  float2 var1 = (float2) (-1.23,-12345.032);
  float2 var2 = (float2) (0.0,2.0);
  int i = printf("float2_a_6329c===%+ 10.1v2hlA===%+ 10.1v2hlA===\n",var1,var2);
  return i;
}

int float2_a_6330c() {
  // { dg-printf "float2_a_6330c===-0X1.82P+13,+0X1.00P+0===-0X1.3BP+0,+0X0.00P+0===" }
  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (-1.23,0.0);
  int i = printf("float2_a_6330c===%+ 10.2v2hlA===%+ 10.2v2hlA===\n",var1,var2);
  return i;
}

int float2_a_6331c() {
  // { dg-printf "float2_a_6331c===+0X0.000P+0,+0X1.E24P+16===-0X1.81CP+13,+0X1.E24P+16===" }
  float2 var1 = (float2) (0.0,123455.134);
  float2 var2 = (float2) (-12345.032,123455.134);
  int i = printf("float2_a_6331c===%+ 10.3v2hlA===%+ 10.3v2hlA===\n",var1,var2);
  return i;
}

int float2_a_6332c() {
  // { dg-printf "float2_a_6332c===-0X1.3AE1480000P+0,+0X1.E23F220000P+16===-0X1.3AE1480000P+0,-0X1.3AE1480000P+0===" }
  float2 var1 = (float2) (-1.23,123455.134);
  float2 var2 = (float2) (-1.23,-1.23);
  int i = printf("float2_a_6332c===%+ 10.10v2hlA===%+ 10.10v2hlA===\n",var1,var2);
  return i;
}

int float2_a_7083c() {
  // { dg-printf "float2_a_7083c===-0x1.3ae1480000000p+0,+0x1.0000000000000p+0===+0x1.e23f220000000p+16,+0x1.e23f220000000p+16===" }
  float2 var1 = (float2) (-1.23,1.0);
  float2 var2 = (float2) (123455.134,123455.134);
  int i = printf("float2_a_7083c===%+010v2hla===%+010v2hla===\n",var1,var2);
  return i;
}

int float2_a_7084c() {
  // { dg-printf "float2_a_7084c===+0x00.0p+0,+0x00.0p+0===-0x01.4p+0,+0x00.0p+0===" }
  float2 var1 = (float2) (0.0,0.0);
  float2 var2 = (float2) (-1.23,0.0);
  int i = printf("float2_a_7084c===%+010.1v2hla===%+010.1v2hla===\n",var1,var2);
  return i;
}

int float2_a_7085c() {
  // { dg-printf "float2_a_7085c===+0x1.e2p+16,+0x1.00p+1===-0x1.3bp+0,-0x1.82p+13===" }
  float2 var1 = (float2) (123455.134,2.0);
  float2 var2 = (float2) (-1.23,-12345.032);
  int i = printf("float2_a_7085c===%+010.2v2hla===%+010.2v2hla===\n",var1,var2);
  return i;
}

int float2_a_7086c() {
  // { dg-printf "float2_a_7086c===+0x1.000p+1,-0x1.81cp+13===+0x1.000p+1,+0x1.000p+1===" }
  float2 var1 = (float2) (2.0,-12345.032);
  float2 var2 = (float2) (2.0,2.0);
  int i = printf("float2_a_7086c===%+010.3v2hla===%+010.3v2hla===\n",var1,var2);
  return i;
}

int float2_a_7087c() {
  // { dg-printf "float2_a_7087c===+0x1.0000000000p+1,+0x1.e23f220000p+16===-0x1.81c8420000p+13,+0x1.e23f220000p+16===" }
  float2 var1 = (float2) (2.0,123455.134);
  float2 var2 = (float2) (-12345.032,123455.134);
  int i = printf("float2_a_7087c===%+010.10v2hla===%+010.10v2hla===\n",var1,var2);
  return i;
}

int float2_a_7088c() {
  // { dg-printf "float2_a_7088c===-0X1.3AE1480000000P+0,-0X1.3AE1480000000P+0===+0X1.0000000000000P+0,+0X1.E23F220000000P+16===" }
  float2 var1 = (float2) (-1.23,-1.23);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_a_7088c===%+010v2hlA===%+010v2hlA===\n",var1,var2);
  return i;
}

int float2_a_7089c() {
  // { dg-printf "float2_a_7089c===-0X01.4P+0,+0X01.0P+0===-0X01.4P+0,-0X1.8P+13===" }
  float2 var1 = (float2) (-1.23,1.0);
  float2 var2 = (float2) (-1.23,-12345.032);
  int i = printf("float2_a_7089c===%+010.1v2hlA===%+010.1v2hlA===\n",var1,var2);
  return i;
}

int float2_a_7090c() {
  // { dg-printf "float2_a_7090c===+0X1.00P+0,+0X1.00P+1===+0X1.00P+1,-0X1.82P+13===" }
  float2 var1 = (float2) (1.0,2.0);
  float2 var2 = (float2) (2.0,-12345.032);
  int i = printf("float2_a_7090c===%+010.2v2hlA===%+010.2v2hlA===\n",var1,var2);
  return i;
}

int float2_a_7091c() {
  // { dg-printf "float2_a_7091c===-0X1.3AEP+0,-0X1.81CP+13===-0X1.3AEP+0,+0X1.000P+0===" }
  float2 var1 = (float2) (-1.23,-12345.032);
  float2 var2 = (float2) (-1.23,1.0);
  int i = printf("float2_a_7091c===%+010.3v2hlA===%+010.3v2hlA===\n",var1,var2);
  return i;
}

int float2_a_7092c() {
  // { dg-printf "float2_a_7092c===-0X1.3AE1480000P+0,+0X0.0000000000P+0===-0X1.3AE1480000P+0,-0X1.81C8420000P+13===" }
  float2 var1 = (float2) (-1.23,0.0);
  float2 var2 = (float2) (-1.23,-12345.032);
  int i = printf("float2_a_7092c===%+010.10v2hlA===%+010.10v2hlA===\n",var1,var2);
  return i;
}

int float2_e_1013c() {

  float2 var1 = (float2) (1.0,123455.134);
  float2 var2 = (float2) (0.0,2.0);
  int i = printf("float2_e_1013c===%-v2hle===%-v2hle===\n",var1,var2);
  return i;
}

int float2_e_1014c() {

  float2 var1 = (float2) (2.0,123455.134);
  float2 var2 = (float2) (-12345.032,123455.134);
  int i = printf("float2_e_1014c===%-.1v2hle===%-.1v2hle===\n",var1,var2);
  return i;
}

int float2_e_1015c() {

  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (2.0,2.0);
  int i = printf("float2_e_1015c===%-.2v2hle===%-.2v2hle===\n",var1,var2);
  return i;
}

int float2_e_1016c() {

  float2 var1 = (float2) (0.0,1.0);
  float2 var2 = (float2) (1.0,1.0);
  int i = printf("float2_e_1016c===%-.3v2hle===%-.3v2hle===\n",var1,var2);
  return i;
}

int float2_e_1017c() {

  float2 var1 = (float2) (1.0,-12345.032);
  float2 var2 = (float2) (1.0,1.0);
  int i = printf("float2_e_1017c===%-.10v2hle===%-.10v2hle===\n",var1,var2);
  return i;
}

int float2_e_1018c() {

  float2 var1 = (float2) (1.0,123455.134);
  float2 var2 = (float2) (-12345.032,-12345.032);
  int i = printf("float2_e_1018c===%-v2hlE===%-v2hlE===\n",var1,var2);
  return i;
}

int float2_e_1019c() {

  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (-1.23,2.0);
  int i = printf("float2_e_1019c===%-.1v2hlE===%-.1v2hlE===\n",var1,var2);
  return i;
}

int float2_e_1020c() {

  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (0.0,-12345.032);
  int i = printf("float2_e_1020c===%-.2v2hlE===%-.2v2hlE===\n",var1,var2);
  return i;
}

int float2_e_1021c() {

  float2 var1 = (float2) (-12345.032,2.0);
  float2 var2 = (float2) (2.0,-12345.032);
  int i = printf("float2_e_1021c===%-.3v2hlE===%-.3v2hlE===\n",var1,var2);
  return i;
}

int float2_e_1022c() {

  float2 var1 = (float2) (-12345.032,0.0);
  float2 var2 = (float2) (0.0,0.0);
  int i = printf("float2_e_1022c===%-.10v2hlE===%-.10v2hlE===\n",var1,var2);
  return i;
}

int float2_e_1773c() {

  float2 var1 = (float2) (2.0,2.0);
  float2 var2 = (float2) (2.0,123455.134);
  int i = printf("float2_e_1773c===%+v2hle===%+v2hle===\n",var1,var2);
  return i;
}

int float2_e_1774c() {

  float2 var1 = (float2) (1.0,-12345.032);
  float2 var2 = (float2) (2.0,-1.23);
  int i = printf("float2_e_1774c===%+.1v2hle===%+.1v2hle===\n",var1,var2);
  return i;
}

int float2_e_1775c() {

  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (123455.134,-1.23);
  int i = printf("float2_e_1775c===%+.2v2hle===%+.2v2hle===\n",var1,var2);
  return i;
}

int float2_e_1776c() {

  float2 var1 = (float2) (-12345.032,-1.23);
  float2 var2 = (float2) (-12345.032,2.0);
  int i = printf("float2_e_1776c===%+.3v2hle===%+.3v2hle===\n",var1,var2);
  return i;
}

int float2_e_1777c() {

  float2 var1 = (float2) (1.0,123455.134);
  float2 var2 = (float2) (2.0,123455.134);
  int i = printf("float2_e_1777c===%+.10v2hle===%+.10v2hle===\n",var1,var2);
  return i;
}

int float2_e_1778c() {

  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (1.0,2.0);
  int i = printf("float2_e_1778c===%+v2hlE===%+v2hlE===\n",var1,var2);
  return i;
}

int float2_e_1779c() {

  float2 var1 = (float2) (-12345.032,-12345.032);
  float2 var2 = (float2) (-1.23,1.0);
  int i = printf("float2_e_1779c===%+.1v2hlE===%+.1v2hlE===\n",var1,var2);
  return i;
}

int float2_e_1780c() {

  float2 var1 = (float2) (-12345.032,0.0);
  float2 var2 = (float2) (-12345.032,-12345.032);
  int i = printf("float2_e_1780c===%+.2v2hlE===%+.2v2hlE===\n",var1,var2);
  return i;
}

int float2_e_1781c() {

  float2 var1 = (float2) (123455.134,123455.134);
  float2 var2 = (float2) (2.0,0.0);
  int i = printf("float2_e_1781c===%+.3v2hlE===%+.3v2hlE===\n",var1,var2);
  return i;
}

int float2_e_1782c() {

  float2 var1 = (float2) (-1.23,0.0);
  float2 var2 = (float2) (2.0,1.0);
  int i = printf("float2_e_1782c===%+.10v2hlE===%+.10v2hlE===\n",var1,var2);
  return i;
}

int float2_e_253c() {

  float2 var1 = (float2) (1.0,2.0);
  float2 var2 = (float2) (2.0,-12345.032);
  int i = printf("float2_e_253c===%v2hle===%v2hle===\n",var1,var2);
  return i;
}

int float2_e_2533c() {

  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (-1.23,1.0);
  int i = printf("float2_e_2533c===%#v2hle===%#v2hle===\n",var1,var2);
  return i;
}

int float2_e_2534c() {

  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (1.0,2.0);
  int i = printf("float2_e_2534c===%#.1v2hle===%#.1v2hle===\n",var1,var2);
  return i;
}

int float2_e_2535c() {

  float2 var1 = (float2) (123455.134,0.0);
  float2 var2 = (float2) (2.0,1.0);
  int i = printf("float2_e_2535c===%#.2v2hle===%#.2v2hle===\n",var1,var2);
  return i;
}

int float2_e_2536c() {

  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (-12345.032,-12345.032);
  int i = printf("float2_e_2536c===%#.3v2hle===%#.3v2hle===\n",var1,var2);
  return i;
}

int float2_e_2537c() {

  float2 var1 = (float2) (0.0,1.0);
  float2 var2 = (float2) (1.0,-1.23);
  int i = printf("float2_e_2537c===%#.10v2hle===%#.10v2hle===\n",var1,var2);
  return i;
}

int float2_e_2538c() {

  float2 var1 = (float2) (2.0,-12345.032);
  float2 var2 = (float2) (0.0,-12345.032);
  int i = printf("float2_e_2538c===%#v2hlE===%#v2hlE===\n",var1,var2);
  return i;
}

int float2_e_2539c() {

  float2 var1 = (float2) (0.0,-12345.032);
  float2 var2 = (float2) (123455.134,2.0);
  int i = printf("float2_e_2539c===%#.1v2hlE===%#.1v2hlE===\n",var1,var2);
  return i;
}

int float2_e_254c() {

  float2 var1 = (float2) (-1.23,-12345.032);
  float2 var2 = (float2) (123455.134,-1.23);
  int i = printf("float2_e_254c===%.1v2hle===%.1v2hle===\n",var1,var2);
  return i;
}

int float2_e_2540c() {

  float2 var1 = (float2) (0.0,1.0);
  float2 var2 = (float2) (-1.23,0.0);
  int i = printf("float2_e_2540c===%#.2v2hlE===%#.2v2hlE===\n",var1,var2);
  return i;
}

int float2_e_2541c() {

  float2 var1 = (float2) (-1.23,2.0);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_e_2541c===%#.3v2hlE===%#.3v2hlE===\n",var1,var2);
  return i;
}

int float2_e_2542c() {

  float2 var1 = (float2) (0.0,123455.134);
  float2 var2 = (float2) (2.0,-12345.032);
  int i = printf("float2_e_2542c===%#.10v2hlE===%#.10v2hlE===\n",var1,var2);
  return i;
}

int float2_e_255c() {

  float2 var1 = (float2) (-1.23,1.0);
  float2 var2 = (float2) (1.0,-1.23);
  int i = printf("float2_e_255c===%.2v2hle===%.2v2hle===\n",var1,var2);
  return i;
}

int float2_e_256c() {

  float2 var1 = (float2) (1.0,123455.134);
  float2 var2 = (float2) (0.0,-1.23);
  int i = printf("float2_e_256c===%.3v2hle===%.3v2hle===\n",var1,var2);
  return i;
}

int float2_e_257c() {

  float2 var1 = (float2) (1.0,2.0);
  float2 var2 = (float2) (2.0,2.0);
  int i = printf("float2_e_257c===%.10v2hle===%.10v2hle===\n",var1,var2);
  return i;
}

int float2_e_258c() {

  float2 var1 = (float2) (2.0,2.0);
  float2 var2 = (float2) (-1.23,0.0);
  int i = printf("float2_e_258c===%v2hlE===%v2hlE===\n",var1,var2);
  return i;
}

int float2_e_259c() {

  float2 var1 = (float2) (123455.134,2.0);
  float2 var2 = (float2) (-12345.032,-1.23);
  int i = printf("float2_e_259c===%.1v2hlE===%.1v2hlE===\n",var1,var2);
  return i;
}

int float2_e_260c() {

  float2 var1 = (float2) (1.0,2.0);
  float2 var2 = (float2) (0.0,123455.134);
  int i = printf("float2_e_260c===%.2v2hlE===%.2v2hlE===\n",var1,var2);
  return i;
}

int float2_e_261c() {

  float2 var1 = (float2) (0.0,-1.23);
  float2 var2 = (float2) (0.0,-12345.032);
  int i = printf("float2_e_261c===%.3v2hlE===%.3v2hlE===\n",var1,var2);
  return i;
}

int float2_e_262c() {

  float2 var1 = (float2) (1.0,0.0);
  float2 var2 = (float2) (-12345.032,123455.134);
  int i = printf("float2_e_262c===%.10v2hlE===%.10v2hlE===\n",var1,var2);
  return i;
}

int float2_e_3293c() {

  float2 var1 = (float2) (2.0,-12345.032);
  float2 var2 = (float2) (-1.23,-1.23);
  int i = printf("float2_e_3293c===%-+v2hle===%-+v2hle===\n",var1,var2);
  return i;
}

int float2_e_3294c() {

  float2 var1 = (float2) (123455.134,1.0);
  float2 var2 = (float2) (123455.134,1.0);
  int i = printf("float2_e_3294c===%-+.1v2hle===%-+.1v2hle===\n",var1,var2);
  return i;
}

int float2_e_3295c() {

  float2 var1 = (float2) (2.0,2.0);
  float2 var2 = (float2) (0.0,0.0);
  int i = printf("float2_e_3295c===%-+.2v2hle===%-+.2v2hle===\n",var1,var2);
  return i;
}

int float2_e_3296c() {

  float2 var1 = (float2) (-12345.032,-12345.032);
  float2 var2 = (float2) (2.0,-1.23);
  int i = printf("float2_e_3296c===%-+.3v2hle===%-+.3v2hle===\n",var1,var2);
  return i;
}

int float2_e_3297c() {

  float2 var1 = (float2) (123455.134,2.0);
  float2 var2 = (float2) (2.0,0.0);
  int i = printf("float2_e_3297c===%-+.10v2hle===%-+.10v2hle===\n",var1,var2);
  return i;
}

int float2_e_3298c() {

  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (-1.23,2.0);
  int i = printf("float2_e_3298c===%-+v2hlE===%-+v2hlE===\n",var1,var2);
  return i;
}

int float2_e_3299c() {

  float2 var1 = (float2) (1.0,2.0);
  float2 var2 = (float2) (-12345.032,123455.134);
  int i = printf("float2_e_3299c===%-+.1v2hlE===%-+.1v2hlE===\n",var1,var2);
  return i;
}

int float2_e_3300c() {

  float2 var1 = (float2) (-1.23,0.0);
  float2 var2 = (float2) (123455.134,1.0);
  int i = printf("float2_e_3300c===%-+.2v2hlE===%-+.2v2hlE===\n",var1,var2);
  return i;
}

int float2_e_3301c() {

  float2 var1 = (float2) (0.0,-12345.032);
  float2 var2 = (float2) (123455.134,-1.23);
  int i = printf("float2_e_3301c===%-+.3v2hlE===%-+.3v2hlE===\n",var1,var2);
  return i;
}

int float2_e_3302c() {

  float2 var1 = (float2) (2.0,1.0);
  float2 var2 = (float2) (2.0,1.0);
  int i = printf("float2_e_3302c===%-+.10v2hlE===%-+.10v2hlE===\n",var1,var2);
  return i;
}

int float2_e_4053c() {

  float2 var1 = (float2) (-1.23,123455.134);
  float2 var2 = (float2) (0.0,1.0);
  int i = printf("float2_e_4053c===% 10v2hle===% 10v2hle===\n",var1,var2);
  return i;
}

int float2_e_4054c() {

  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (-12345.032,-1.23);
  int i = printf("float2_e_4054c===% 10.1v2hle===% 10.1v2hle===\n",var1,var2);
  return i;
}

int float2_e_4055c() {

  float2 var1 = (float2) (2.0,-12345.032);
  float2 var2 = (float2) (-1.23,-12345.032);
  int i = printf("float2_e_4055c===% 10.2v2hle===% 10.2v2hle===\n",var1,var2);
  return i;
}

int float2_e_4056c() {

  float2 var1 = (float2) (1.0,-12345.032);
  float2 var2 = (float2) (1.0,-12345.032);
  int i = printf("float2_e_4056c===% 10.3v2hle===% 10.3v2hle===\n",var1,var2);
  return i;
}

int float2_e_4057c() {

  float2 var1 = (float2) (-12345.032,-1.23);
  float2 var2 = (float2) (2.0,-1.23);
  int i = printf("float2_e_4057c===% 10.10v2hle===% 10.10v2hle===\n",var1,var2);
  return i;
}

int float2_e_4058c() {

  float2 var1 = (float2) (-12345.032,-12345.032);
  float2 var2 = (float2) (-12345.032,2.0);
  int i = printf("float2_e_4058c===% 10v2hlE===% 10v2hlE===\n",var1,var2);
  return i;
}

int float2_e_4059c() {

  float2 var1 = (float2) (1.0,123455.134);
  float2 var2 = (float2) (2.0,-12345.032);
  int i = printf("float2_e_4059c===% 10.1v2hlE===% 10.1v2hlE===\n",var1,var2);
  return i;
}

int float2_e_4060c() {

  float2 var1 = (float2) (-12345.032,0.0);
  float2 var2 = (float2) (-12345.032,-12345.032);
  int i = printf("float2_e_4060c===% 10.2v2hlE===% 10.2v2hlE===\n",var1,var2);
  return i;
}

int float2_e_4061c() {

  float2 var1 = (float2) (0.0,1.0);
  float2 var2 = (float2) (123455.134,2.0);
  int i = printf("float2_e_4061c===% 10.3v2hlE===% 10.3v2hlE===\n",var1,var2);
  return i;
}

int float2_e_4062c() {

  float2 var1 = (float2) (1.0,2.0);
  float2 var2 = (float2) (2.0,-1.23);
  int i = printf("float2_e_4062c===% 10.10v2hlE===% 10.10v2hlE===\n",var1,var2);
  return i;
}

int float2_e_4813c() {

  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (2.0,1.0);
  int i = printf("float2_e_4813c===%010v2hle===%010v2hle===\n",var1,var2);
  return i;
}

int float2_e_4814c() {

  float2 var1 = (float2) (123455.134,-12345.032);
  float2 var2 = (float2) (1.0,1.0);
  int i = printf("float2_e_4814c===%010.1v2hle===%010.1v2hle===\n",var1,var2);
  return i;
}

int float2_e_4815c() {

  float2 var1 = (float2) (-1.23,123455.134);
  float2 var2 = (float2) (0.0,123455.134);
  int i = printf("float2_e_4815c===%010.2v2hle===%010.2v2hle===\n",var1,var2);
  return i;
}

int float2_e_4816c() {

  float2 var1 = (float2) (1.0,2.0);
  float2 var2 = (float2) (-1.23,1.0);
  int i = printf("float2_e_4816c===%010.3v2hle===%010.3v2hle===\n",var1,var2);
  return i;
}

int float2_e_4817c() {

  float2 var1 = (float2) (0.0,-1.23);
  float2 var2 = (float2) (-1.23,123455.134);
  int i = printf("float2_e_4817c===%010.10v2hle===%010.10v2hle===\n",var1,var2);
  return i;
}

int float2_e_4818c() {

  float2 var1 = (float2) (1.0,0.0);
  float2 var2 = (float2) (0.0,-12345.032);
  int i = printf("float2_e_4818c===%010v2hlE===%010v2hlE===\n",var1,var2);
  return i;
}

int float2_e_4819c() {

  float2 var1 = (float2) (2.0,1.0);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_e_4819c===%010.1v2hlE===%010.1v2hlE===\n",var1,var2);
  return i;
}

int float2_e_4820c() {

  float2 var1 = (float2) (123455.134,0.0);
  float2 var2 = (float2) (1.0,-12345.032);
  int i = printf("float2_e_4820c===%010.2v2hlE===%010.2v2hlE===\n",var1,var2);
  return i;
}

int float2_e_4821c() {

  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (-1.23,0.0);
  int i = printf("float2_e_4821c===%010.3v2hlE===%010.3v2hlE===\n",var1,var2);
  return i;
}

int float2_e_4822c() {

  float2 var1 = (float2) (-12345.032,123455.134);
  float2 var2 = (float2) (123455.134,123455.134);
  int i = printf("float2_e_4822c===%010.10v2hlE===%010.10v2hlE===\n",var1,var2);
  return i;
}

int float2_e_5573c() {

  float2 var1 = (float2) (123455.134,2.0);
  float2 var2 = (float2) (123455.134,2.0);
  int i = printf("float2_e_5573c===%- 10v2hle===%- 10v2hle===\n",var1,var2);
  return i;
}

int float2_e_5574c() {

  float2 var1 = (float2) (-1.23,2.0);
  float2 var2 = (float2) (-1.23,-1.23);
  int i = printf("float2_e_5574c===%- 10.1v2hle===%- 10.1v2hle===\n",var1,var2);
  return i;
}

int float2_e_5575c() {

  float2 var1 = (float2) (1.0,-12345.032);
  float2 var2 = (float2) (0.0,-12345.032);
  int i = printf("float2_e_5575c===%- 10.2v2hle===%- 10.2v2hle===\n",var1,var2);
  return i;
}

int float2_e_5576c() {

  float2 var1 = (float2) (-1.23,1.0);
  float2 var2 = (float2) (0.0,-1.23);
  int i = printf("float2_e_5576c===%- 10.3v2hle===%- 10.3v2hle===\n",var1,var2);
  return i;
}

int float2_e_5577c() {

  float2 var1 = (float2) (-12345.032,2.0);
  float2 var2 = (float2) (1.0,1.0);
  int i = printf("float2_e_5577c===%- 10.10v2hle===%- 10.10v2hle===\n",var1,var2);
  return i;
}

int float2_e_5578c() {

  float2 var1 = (float2) (123455.134,0.0);
  float2 var2 = (float2) (-1.23,123455.134);
  int i = printf("float2_e_5578c===%- 10v2hlE===%- 10v2hlE===\n",var1,var2);
  return i;
}

int float2_e_5579c() {

  float2 var1 = (float2) (-1.23,1.0);
  float2 var2 = (float2) (-12345.032,-1.23);
  int i = printf("float2_e_5579c===%- 10.1v2hlE===%- 10.1v2hlE===\n",var1,var2);
  return i;
}

int float2_e_5580c() {

  float2 var1 = (float2) (1.0,0.0);
  float2 var2 = (float2) (2.0,0.0);
  int i = printf("float2_e_5580c===%- 10.2v2hlE===%- 10.2v2hlE===\n",var1,var2);
  return i;
}

int float2_e_5581c() {

  float2 var1 = (float2) (123455.134,0.0);
  float2 var2 = (float2) (-1.23,2.0);
  int i = printf("float2_e_5581c===%- 10.3v2hlE===%- 10.3v2hlE===\n",var1,var2);
  return i;
}

int float2_e_5582c() {

  float2 var1 = (float2) (0.0,2.0);
  float2 var2 = (float2) (2.0,-12345.032);
  int i = printf("float2_e_5582c===%- 10.10v2hlE===%- 10.10v2hlE===\n",var1,var2);
  return i;
}

int float2_e_6333c() {

  float2 var1 = (float2) (1.0,-12345.032);
  float2 var2 = (float2) (1.0,2.0);
  int i = printf("float2_e_6333c===%+ 10v2hle===%+ 10v2hle===\n",var1,var2);
  return i;
}

int float2_e_6334c() {

  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (-12345.032,-12345.032);
  int i = printf("float2_e_6334c===%+ 10.1v2hle===%+ 10.1v2hle===\n",var1,var2);
  return i;
}

int float2_e_6335c() {

  float2 var1 = (float2) (2.0,123455.134);
  float2 var2 = (float2) (-1.23,-1.23);
  int i = printf("float2_e_6335c===%+ 10.2v2hle===%+ 10.2v2hle===\n",var1,var2);
  return i;
}

int float2_e_6336c() {

  float2 var1 = (float2) (-1.23,1.0);
  float2 var2 = (float2) (-1.23,2.0);
  int i = printf("float2_e_6336c===%+ 10.3v2hle===%+ 10.3v2hle===\n",var1,var2);
  return i;
}

int float2_e_6337c() {

  float2 var1 = (float2) (0.0,-12345.032);
  float2 var2 = (float2) (123455.134,1.0);
  int i = printf("float2_e_6337c===%+ 10.10v2hle===%+ 10.10v2hle===\n",var1,var2);
  return i;
}

int float2_e_6338c() {

  float2 var1 = (float2) (1.0,-1.23);
  float2 var2 = (float2) (-12345.032,123455.134);
  int i = printf("float2_e_6338c===%+ 10v2hlE===%+ 10v2hlE===\n",var1,var2);
  return i;
}

int float2_e_6339c() {

  float2 var1 = (float2) (2.0,-12345.032);
  float2 var2 = (float2) (0.0,123455.134);
  int i = printf("float2_e_6339c===%+ 10.1v2hlE===%+ 10.1v2hlE===\n",var1,var2);
  return i;
}

int float2_e_6340c() {

  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (-1.23,1.0);
  int i = printf("float2_e_6340c===%+ 10.2v2hlE===%+ 10.2v2hlE===\n",var1,var2);
  return i;
}

int float2_e_6341c() {

  float2 var1 = (float2) (123455.134,1.0);
  float2 var2 = (float2) (2.0,-12345.032);
  int i = printf("float2_e_6341c===%+ 10.3v2hlE===%+ 10.3v2hlE===\n",var1,var2);
  return i;
}

int float2_e_6342c() {

  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (1.0,2.0);
  int i = printf("float2_e_6342c===%+ 10.10v2hlE===%+ 10.10v2hlE===\n",var1,var2);
  return i;
}

int float2_e_7093c() {

  float2 var1 = (float2) (0.0,0.0);
  float2 var2 = (float2) (-1.23,123455.134);
  int i = printf("float2_e_7093c===%+010v2hle===%+010v2hle===\n",var1,var2);
  return i;
}

int float2_e_7094c() {

  float2 var1 = (float2) (0.0,-12345.032);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_e_7094c===%+010.1v2hle===%+010.1v2hle===\n",var1,var2);
  return i;
}

int float2_e_7095c() {

  float2 var1 = (float2) (-12345.032,0.0);
  float2 var2 = (float2) (0.0,1.0);
  int i = printf("float2_e_7095c===%+010.2v2hle===%+010.2v2hle===\n",var1,var2);
  return i;
}

int float2_e_7096c() {

  float2 var1 = (float2) (-1.23,-12345.032);
  float2 var2 = (float2) (0.0,-1.23);
  int i = printf("float2_e_7096c===%+010.3v2hle===%+010.3v2hle===\n",var1,var2);
  return i;
}

int float2_e_7097c() {

  float2 var1 = (float2) (-1.23,0.0);
  float2 var2 = (float2) (123455.134,0.0);
  int i = printf("float2_e_7097c===%+010.10v2hle===%+010.10v2hle===\n",var1,var2);
  return i;
}

int float2_e_7098c() {

  float2 var1 = (float2) (2.0,0.0);
  float2 var2 = (float2) (-12345.032,2.0);
  int i = printf("float2_e_7098c===%+010v2hlE===%+010v2hlE===\n",var1,var2);
  return i;
}

int float2_e_7099c() {

  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (123455.134,2.0);
  int i = printf("float2_e_7099c===%+010.1v2hlE===%+010.1v2hlE===\n",var1,var2);
  return i;
}

int float2_e_7100c() {

  float2 var1 = (float2) (-1.23,1.0);
  float2 var2 = (float2) (-12345.032,-12345.032);
  int i = printf("float2_e_7100c===%+010.2v2hlE===%+010.2v2hlE===\n",var1,var2);
  return i;
}

int float2_e_7101c() {

  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (1.0,1.0);
  int i = printf("float2_e_7101c===%+010.3v2hlE===%+010.3v2hlE===\n",var1,var2);
  return i;
}

int float2_e_7102c() {

  float2 var1 = (float2) (-12345.032,-12345.032);
  float2 var2 = (float2) (-12345.032,-12345.032);
  int i = printf("float2_e_7102c===%+010.10v2hlE===%+010.10v2hlE===\n",var1,var2);
  return i;
}

int float2_f_1023c() {

  float2 var1 = (float2) (123455.134,123455.134);
  float2 var2 = (float2) (-1.23,2.0);
  int i = printf("float2_f_1023c===%-v2hlf===%-v2hlf===\n",var1,var2);
  return i;
}

int float2_f_1024c() {

  float2 var1 = (float2) (-1.23,1.0);
  float2 var2 = (float2) (2.0,-12345.032);
  int i = printf("float2_f_1024c===%-.1v2hlf===%-.1v2hlf===\n",var1,var2);
  return i;
}

int float2_f_1025c() {

  float2 var1 = (float2) (123455.134,0.0);
  float2 var2 = (float2) (123455.134,123455.134);
  int i = printf("float2_f_1025c===%-.2v2hlf===%-.2v2hlf===\n",var1,var2);
  return i;
}

int float2_f_1026c() {

  float2 var1 = (float2) (-12345.032,-12345.032);
  float2 var2 = (float2) (123455.134,1.0);
  int i = printf("float2_f_1026c===%-.3v2hlf===%-.3v2hlf===\n",var1,var2);
  return i;
}

int float2_f_1027c() {

  float2 var1 = (float2) (-12345.032,-1.23);
  float2 var2 = (float2) (123455.134,-12345.032);
  int i = printf("float2_f_1027c===%-.10v2hlf===%-.10v2hlf===\n",var1,var2);
  return i;
}

int float2_f_1028c() {

  float2 var1 = (float2) (2.0,-12345.032);
  float2 var2 = (float2) (2.0,-1.23);
  int i = printf("float2_f_1028c===%-v2hlF===%-v2hlF===\n",var1,var2);
  return i;
}

int float2_f_1029c() {

  float2 var1 = (float2) (-1.23,-12345.032);
  float2 var2 = (float2) (123455.134,-1.23);
  int i = printf("float2_f_1029c===%-.1v2hlF===%-.1v2hlF===\n",var1,var2);
  return i;
}

int float2_f_1030c() {

  float2 var1 = (float2) (-1.23,2.0);
  float2 var2 = (float2) (1.0,0.0);
  int i = printf("float2_f_1030c===%-.2v2hlF===%-.2v2hlF===\n",var1,var2);
  return i;
}

int float2_f_1031c() {

  float2 var1 = (float2) (1.0,2.0);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_f_1031c===%-.3v2hlF===%-.3v2hlF===\n",var1,var2);
  return i;
}

int float2_f_1032c() {

  float2 var1 = (float2) (123455.134,2.0);
  float2 var2 = (float2) (0.0,2.0);
  int i = printf("float2_f_1032c===%-.10v2hlF===%-.10v2hlF===\n",var1,var2);
  return i;
}

int float2_f_1783c() {

  float2 var1 = (float2) (2.0,1.0);
  float2 var2 = (float2) (1.0,-1.23);
  int i = printf("float2_f_1783c===%+v2hlf===%+v2hlf===\n",var1,var2);
  return i;
}

int float2_f_1784c() {

  float2 var1 = (float2) (2.0,0.0);
  float2 var2 = (float2) (123455.134,2.0);
  int i = printf("float2_f_1784c===%+.1v2hlf===%+.1v2hlf===\n",var1,var2);
  return i;
}

int float2_f_1785c() {

  float2 var1 = (float2) (1.0,123455.134);
  float2 var2 = (float2) (123455.134,-1.23);
  int i = printf("float2_f_1785c===%+.2v2hlf===%+.2v2hlf===\n",var1,var2);
  return i;
}

int float2_f_1786c() {

  float2 var1 = (float2) (2.0,-1.23);
  float2 var2 = (float2) (2.0,123455.134);
  int i = printf("float2_f_1786c===%+.3v2hlf===%+.3v2hlf===\n",var1,var2);
  return i;
}

int float2_f_1787c() {

  float2 var1 = (float2) (2.0,2.0);
  float2 var2 = (float2) (123455.134,1.0);
  int i = printf("float2_f_1787c===%+.10v2hlf===%+.10v2hlf===\n",var1,var2);
  return i;
}

int float2_f_1788c() {

  float2 var1 = (float2) (1.0,2.0);
  float2 var2 = (float2) (1.0,0.0);
  int i = printf("float2_f_1788c===%+v2hlF===%+v2hlF===\n",var1,var2);
  return i;
}

int float2_f_1789c() {

  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (123455.134,2.0);
  int i = printf("float2_f_1789c===%+.1v2hlF===%+.1v2hlF===\n",var1,var2);
  return i;
}

int float2_f_1790c() {

  float2 var1 = (float2) (2.0,1.0);
  float2 var2 = (float2) (-12345.032,-1.23);
  int i = printf("float2_f_1790c===%+.2v2hlF===%+.2v2hlF===\n",var1,var2);
  return i;
}

int float2_f_1791c() {

  float2 var1 = (float2) (-12345.032,-1.23);
  float2 var2 = (float2) (2.0,1.0);
  int i = printf("float2_f_1791c===%+.3v2hlF===%+.3v2hlF===\n",var1,var2);
  return i;
}

int float2_f_1792c() {

  float2 var1 = (float2) (123455.134,2.0);
  float2 var2 = (float2) (123455.134,1.0);
  int i = printf("float2_f_1792c===%+.10v2hlF===%+.10v2hlF===\n",var1,var2);
  return i;
}

int float2_f_2543c() {

  float2 var1 = (float2) (1.0,123455.134);
  float2 var2 = (float2) (0.0,-12345.032);
  int i = printf("float2_f_2543c===%#v2hlf===%#v2hlf===\n",var1,var2);
  return i;
}

int float2_f_2544c() {

  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (-1.23,123455.134);
  int i = printf("float2_f_2544c===%#.1v2hlf===%#.1v2hlf===\n",var1,var2);
  return i;
}

int float2_f_2545c() {

  float2 var1 = (float2) (-1.23,123455.134);
  float2 var2 = (float2) (0.0,-12345.032);
  int i = printf("float2_f_2545c===%#.2v2hlf===%#.2v2hlf===\n",var1,var2);
  return i;
}

int float2_f_2546c() {

  float2 var1 = (float2) (123455.134,2.0);
  float2 var2 = (float2) (2.0,2.0);
  int i = printf("float2_f_2546c===%#.3v2hlf===%#.3v2hlf===\n",var1,var2);
  return i;
}

int float2_f_2547c() {

  float2 var1 = (float2) (123455.134,1.0);
  float2 var2 = (float2) (-1.23,2.0);
  int i = printf("float2_f_2547c===%#.10v2hlf===%#.10v2hlf===\n",var1,var2);
  return i;
}

int float2_f_2548c() {

  float2 var1 = (float2) (0.0,123455.134);
  float2 var2 = (float2) (123455.134,0.0);
  int i = printf("float2_f_2548c===%#v2hlF===%#v2hlF===\n",var1,var2);
  return i;
}

int float2_f_2549c() {

  float2 var1 = (float2) (2.0,-12345.032);
  float2 var2 = (float2) (-1.23,-1.23);
  int i = printf("float2_f_2549c===%#.1v2hlF===%#.1v2hlF===\n",var1,var2);
  return i;
}

int float2_f_2550c() {

  float2 var1 = (float2) (1.0,-12345.032);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_f_2550c===%#.2v2hlF===%#.2v2hlF===\n",var1,var2);
  return i;
}

int float2_f_2551c() {

  float2 var1 = (float2) (123455.134,123455.134);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_f_2551c===%#.3v2hlF===%#.3v2hlF===\n",var1,var2);
  return i;
}

int float2_f_2552c() {

  float2 var1 = (float2) (123455.134,123455.134);
  float2 var2 = (float2) (1.0,-12345.032);
  int i = printf("float2_f_2552c===%#.10v2hlF===%#.10v2hlF===\n",var1,var2);
  return i;
}

int float2_f_263c() {

  float2 var1 = (float2) (-1.23,0.0);
  float2 var2 = (float2) (2.0,0.0);
  int i = printf("float2_f_263c===%v2hlf===%v2hlf===\n",var1,var2);
  return i;
}

int float2_f_264c() {

  float2 var1 = (float2) (-12345.032,2.0);
  float2 var2 = (float2) (1.0,-1.23);
  int i = printf("float2_f_264c===%.1v2hlf===%.1v2hlf===\n",var1,var2);
  return i;
}

int float2_f_265c() {

  float2 var1 = (float2) (-1.23,-12345.032);
  float2 var2 = (float2) (0.0,0.0);
  int i = printf("float2_f_265c===%.2v2hlf===%.2v2hlf===\n",var1,var2);
  return i;
}

int float2_f_266c() {

  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (0.0,-12345.032);
  int i = printf("float2_f_266c===%.3v2hlf===%.3v2hlf===\n",var1,var2);
  return i;
}

int float2_f_267c() {

  float2 var1 = (float2) (-1.23,2.0);
  float2 var2 = (float2) (123455.134,-12345.032);
  int i = printf("float2_f_267c===%.10v2hlf===%.10v2hlf===\n",var1,var2);
  return i;
}

int float2_f_268c() {

  float2 var1 = (float2) (123455.134,1.0);
  float2 var2 = (float2) (-1.23,-12345.032);
  int i = printf("float2_f_268c===%v2hlF===%v2hlF===\n",var1,var2);
  return i;
}

int float2_f_269c() {

  float2 var1 = (float2) (123455.134,2.0);
  float2 var2 = (float2) (1.0,-1.23);
  int i = printf("float2_f_269c===%.1v2hlF===%.1v2hlF===\n",var1,var2);
  return i;
}

int float2_f_270c() {

  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (1.0,-1.23);
  int i = printf("float2_f_270c===%.2v2hlF===%.2v2hlF===\n",var1,var2);
  return i;
}

int float2_f_271c() {

  float2 var1 = (float2) (-12345.032,-12345.032);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_f_271c===%.3v2hlF===%.3v2hlF===\n",var1,var2);
  return i;
}

int float2_f_272c() {

  float2 var1 = (float2) (2.0,2.0);
  float2 var2 = (float2) (-1.23,123455.134);
  int i = printf("float2_f_272c===%.10v2hlF===%.10v2hlF===\n",var1,var2);
  return i;
}

int float2_f_3303c() {

  float2 var1 = (float2) (0.0,-12345.032);
  float2 var2 = (float2) (123455.134,0.0);
  int i = printf("float2_f_3303c===%-+v2hlf===%-+v2hlf===\n",var1,var2);
  return i;
}

int float2_f_3304c() {

  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (2.0,-12345.032);
  int i = printf("float2_f_3304c===%-+.1v2hlf===%-+.1v2hlf===\n",var1,var2);
  return i;
}

int float2_f_3305c() {

  float2 var1 = (float2) (0.0,-1.23);
  float2 var2 = (float2) (1.0,-1.23);
  int i = printf("float2_f_3305c===%-+.2v2hlf===%-+.2v2hlf===\n",var1,var2);
  return i;
}

int float2_f_3306c() {

  float2 var1 = (float2) (1.0,-12345.032);
  float2 var2 = (float2) (0.0,-1.23);
  int i = printf("float2_f_3306c===%-+.3v2hlf===%-+.3v2hlf===\n",var1,var2);
  return i;
}

int float2_f_3307c() {

  float2 var1 = (float2) (-1.23,-1.23);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_f_3307c===%-+.10v2hlf===%-+.10v2hlf===\n",var1,var2);
  return i;
}

int float2_f_3308c() {

  float2 var1 = (float2) (2.0,-1.23);
  float2 var2 = (float2) (1.0,1.0);
  int i = printf("float2_f_3308c===%-+v2hlF===%-+v2hlF===\n",var1,var2);
  return i;
}

int float2_f_3309c() {

  float2 var1 = (float2) (1.0,123455.134);
  float2 var2 = (float2) (123455.134,-12345.032);
  int i = printf("float2_f_3309c===%-+.1v2hlF===%-+.1v2hlF===\n",var1,var2);
  return i;
}

int float2_f_3310c() {

  float2 var1 = (float2) (123455.134,123455.134);
  float2 var2 = (float2) (1.0,-12345.032);
  int i = printf("float2_f_3310c===%-+.2v2hlF===%-+.2v2hlF===\n",var1,var2);
  return i;
}

int float2_f_3311c() {

  float2 var1 = (float2) (2.0,-12345.032);
  float2 var2 = (float2) (0.0,1.0);
  int i = printf("float2_f_3311c===%-+.3v2hlF===%-+.3v2hlF===\n",var1,var2);
  return i;
}

int float2_f_3312c() {

  float2 var1 = (float2) (123455.134,1.0);
  float2 var2 = (float2) (1.0,2.0);
  int i = printf("float2_f_3312c===%-+.10v2hlF===%-+.10v2hlF===\n",var1,var2);
  return i;
}

int float2_f_4063c() {

  float2 var1 = (float2) (-1.23,1.0);
  float2 var2 = (float2) (123455.134,0.0);
  int i = printf("float2_f_4063c===% 10v2hlf===% 10v2hlf===\n",var1,var2);
  return i;
}

int float2_f_4064c() {

  float2 var1 = (float2) (2.0,-1.23);
  float2 var2 = (float2) (-12345.032,2.0);
  int i = printf("float2_f_4064c===% 10.1v2hlf===% 10.1v2hlf===\n",var1,var2);
  return i;
}

int float2_f_4065c() {

  float2 var1 = (float2) (-12345.032,-1.23);
  float2 var2 = (float2) (1.0,-1.23);
  int i = printf("float2_f_4065c===% 10.2v2hlf===% 10.2v2hlf===\n",var1,var2);
  return i;
}

int float2_f_4066c() {

  float2 var1 = (float2) (-1.23,-12345.032);
  float2 var2 = (float2) (123455.134,-1.23);
  int i = printf("float2_f_4066c===% 10.3v2hlf===% 10.3v2hlf===\n",var1,var2);
  return i;
}

int float2_f_4067c() {

  float2 var1 = (float2) (123455.134,1.0);
  float2 var2 = (float2) (-1.23,0.0);
  int i = printf("float2_f_4067c===% 10.10v2hlf===% 10.10v2hlf===\n",var1,var2);
  return i;
}

int float2_f_4068c() {

  float2 var1 = (float2) (0.0,2.0);
  float2 var2 = (float2) (-1.23,-12345.032);
  int i = printf("float2_f_4068c===% 10v2hlF===% 10v2hlF===\n",var1,var2);
  return i;
}

int float2_f_4069c() {

  float2 var1 = (float2) (0.0,2.0);
  float2 var2 = (float2) (0.0,2.0);
  int i = printf("float2_f_4069c===% 10.1v2hlF===% 10.1v2hlF===\n",var1,var2);
  return i;
}

int float2_f_4070c() {

  float2 var1 = (float2) (1.0,0.0);
  float2 var2 = (float2) (123455.134,123455.134);
  int i = printf("float2_f_4070c===% 10.2v2hlF===% 10.2v2hlF===\n",var1,var2);
  return i;
}

int float2_f_4071c() {

  float2 var1 = (float2) (-12345.032,123455.134);
  float2 var2 = (float2) (2.0,0.0);
  int i = printf("float2_f_4071c===% 10.3v2hlF===% 10.3v2hlF===\n",var1,var2);
  return i;
}

int float2_f_4072c() {

  float2 var1 = (float2) (123455.134,-12345.032);
  float2 var2 = (float2) (-12345.032,0.0);
  int i = printf("float2_f_4072c===% 10.10v2hlF===% 10.10v2hlF===\n",var1,var2);
  return i;
}

int float2_f_4823c() {

  float2 var1 = (float2) (0.0,123455.134);
  float2 var2 = (float2) (123455.134,2.0);
  int i = printf("float2_f_4823c===%010v2hlf===%010v2hlf===\n",var1,var2);
  return i;
}

int float2_f_4824c() {

  float2 var1 = (float2) (1.0,123455.134);
  float2 var2 = (float2) (0.0,123455.134);
  int i = printf("float2_f_4824c===%010.1v2hlf===%010.1v2hlf===\n",var1,var2);
  return i;
}

int float2_f_4825c() {

  float2 var1 = (float2) (1.0,0.0);
  float2 var2 = (float2) (1.0,1.0);
  int i = printf("float2_f_4825c===%010.2v2hlf===%010.2v2hlf===\n",var1,var2);
  return i;
}

int float2_f_4826c() {

  float2 var1 = (float2) (-1.23,-1.23);
  float2 var2 = (float2) (-1.23,0.0);
  int i = printf("float2_f_4826c===%010.3v2hlf===%010.3v2hlf===\n",var1,var2);
  return i;
}

int float2_f_4827c() {

  float2 var1 = (float2) (-12345.032,0.0);
  float2 var2 = (float2) (123455.134,2.0);
  int i = printf("float2_f_4827c===%010.10v2hlf===%010.10v2hlf===\n",var1,var2);
  return i;
}

int float2_f_4828c() {

  float2 var1 = (float2) (0.0,-12345.032);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_f_4828c===%010v2hlF===%010v2hlF===\n",var1,var2);
  return i;
}

int float2_f_4829c() {

  float2 var1 = (float2) (-12345.032,123455.134);
  float2 var2 = (float2) (0.0,0.0);
  int i = printf("float2_f_4829c===%010.1v2hlF===%010.1v2hlF===\n",var1,var2);
  return i;
}

int float2_f_4830c() {

  float2 var1 = (float2) (-12345.032,2.0);
  float2 var2 = (float2) (1.0,-1.23);
  int i = printf("float2_f_4830c===%010.2v2hlF===%010.2v2hlF===\n",var1,var2);
  return i;
}

int float2_f_4831c() {

  float2 var1 = (float2) (123455.134,1.0);
  float2 var2 = (float2) (2.0,-12345.032);
  int i = printf("float2_f_4831c===%010.3v2hlF===%010.3v2hlF===\n",var1,var2);
  return i;
}

int float2_f_4832c() {

  float2 var1 = (float2) (-1.23,123455.134);
  float2 var2 = (float2) (2.0,2.0);
  int i = printf("float2_f_4832c===%010.10v2hlF===%010.10v2hlF===\n",var1,var2);
  return i;
}

int float2_f_5583c() {

  float2 var1 = (float2) (-1.23,-1.23);
  float2 var2 = (float2) (-12345.032,-1.23);
  int i = printf("float2_f_5583c===%- 10v2hlf===%- 10v2hlf===\n",var1,var2);
  return i;
}

int float2_f_5584c() {

  float2 var1 = (float2) (-12345.032,2.0);
  float2 var2 = (float2) (0.0,0.0);
  int i = printf("float2_f_5584c===%- 10.1v2hlf===%- 10.1v2hlf===\n",var1,var2);
  return i;
}

int float2_f_5585c() {

  float2 var1 = (float2) (-1.23,-1.23);
  float2 var2 = (float2) (123455.134,2.0);
  int i = printf("float2_f_5585c===%- 10.2v2hlf===%- 10.2v2hlf===\n",var1,var2);
  return i;
}

int float2_f_5586c() {

  float2 var1 = (float2) (123455.134,1.0);
  float2 var2 = (float2) (-1.23,-12345.032);
  int i = printf("float2_f_5586c===%- 10.3v2hlf===%- 10.3v2hlf===\n",var1,var2);
  return i;
}

int float2_f_5587c() {

  float2 var1 = (float2) (1.0,2.0);
  float2 var2 = (float2) (0.0,123455.134);
  int i = printf("float2_f_5587c===%- 10.10v2hlf===%- 10.10v2hlf===\n",var1,var2);
  return i;
}

int float2_f_5588c() {

  float2 var1 = (float2) (-1.23,-12345.032);
  float2 var2 = (float2) (2.0,0.0);
  int i = printf("float2_f_5588c===%- 10v2hlF===%- 10v2hlF===\n",var1,var2);
  return i;
}

int float2_f_5589c() {

  float2 var1 = (float2) (-1.23,2.0);
  float2 var2 = (float2) (0.0,2.0);
  int i = printf("float2_f_5589c===%- 10.1v2hlF===%- 10.1v2hlF===\n",var1,var2);
  return i;
}

int float2_f_5590c() {

  float2 var1 = (float2) (-12345.032,-1.23);
  float2 var2 = (float2) (123455.134,123455.134);
  int i = printf("float2_f_5590c===%- 10.2v2hlF===%- 10.2v2hlF===\n",var1,var2);
  return i;
}

int float2_f_5591c() {

  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (-12345.032,2.0);
  int i = printf("float2_f_5591c===%- 10.3v2hlF===%- 10.3v2hlF===\n",var1,var2);
  return i;
}

int float2_f_5592c() {

  float2 var1 = (float2) (0.0,1.0);
  float2 var2 = (float2) (-1.23,0.0);
  int i = printf("float2_f_5592c===%- 10.10v2hlF===%- 10.10v2hlF===\n",var1,var2);
  return i;
}

int float2_f_6343c() {

  float2 var1 = (float2) (2.0,-12345.032);
  float2 var2 = (float2) (2.0,1.0);
  int i = printf("float2_f_6343c===%+ 10v2hlf===%+ 10v2hlf===\n",var1,var2);
  return i;
}

int float2_f_6344c() {

  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (123455.134,-1.23);
  int i = printf("float2_f_6344c===%+ 10.1v2hlf===%+ 10.1v2hlf===\n",var1,var2);
  return i;
}

int float2_f_6345c() {

  float2 var1 = (float2) (1.0,-1.23);
  float2 var2 = (float2) (0.0,-1.23);
  int i = printf("float2_f_6345c===%+ 10.2v2hlf===%+ 10.2v2hlf===\n",var1,var2);
  return i;
}

int float2_f_6346c() {

  float2 var1 = (float2) (-12345.032,1.0);
  float2 var2 = (float2) (2.0,123455.134);
  int i = printf("float2_f_6346c===%+ 10.3v2hlf===%+ 10.3v2hlf===\n",var1,var2);
  return i;
}

int float2_f_6347c() {

  float2 var1 = (float2) (0.0,-1.23);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_f_6347c===%+ 10.10v2hlf===%+ 10.10v2hlf===\n",var1,var2);
  return i;
}

int float2_f_6348c() {

  float2 var1 = (float2) (0.0,-12345.032);
  float2 var2 = (float2) (0.0,123455.134);
  int i = printf("float2_f_6348c===%+ 10v2hlF===%+ 10v2hlF===\n",var1,var2);
  return i;
}

int float2_f_6349c() {

  float2 var1 = (float2) (123455.134,123455.134);
  float2 var2 = (float2) (123455.134,-12345.032);
  int i = printf("float2_f_6349c===%+ 10.1v2hlF===%+ 10.1v2hlF===\n",var1,var2);
  return i;
}

int float2_f_6350c() {

  float2 var1 = (float2) (1.0,-12345.032);
  float2 var2 = (float2) (0.0,-1.23);
  int i = printf("float2_f_6350c===%+ 10.2v2hlF===%+ 10.2v2hlF===\n",var1,var2);
  return i;
}

int float2_f_6351c() {

  float2 var1 = (float2) (2.0,2.0);
  float2 var2 = (float2) (-1.23,-12345.032);
  int i = printf("float2_f_6351c===%+ 10.3v2hlF===%+ 10.3v2hlF===\n",var1,var2);
  return i;
}

int float2_f_6352c() {

  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (-12345.032,-12345.032);
  int i = printf("float2_f_6352c===%+ 10.10v2hlF===%+ 10.10v2hlF===\n",var1,var2);
  return i;
}

int float2_f_7103c() {

  float2 var1 = (float2) (-12345.032,2.0);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_f_7103c===%+010v2hlf===%+010v2hlf===\n",var1,var2);
  return i;
}

int float2_f_7104c() {

  float2 var1 = (float2) (0.0,-1.23);
  float2 var2 = (float2) (2.0,2.0);
  int i = printf("float2_f_7104c===%+010.1v2hlf===%+010.1v2hlf===\n",var1,var2);
  return i;
}

int float2_f_7105c() {

  float2 var1 = (float2) (123455.134,1.0);
  float2 var2 = (float2) (-1.23,-12345.032);
  int i = printf("float2_f_7105c===%+010.2v2hlf===%+010.2v2hlf===\n",var1,var2);
  return i;
}

int float2_f_7106c() {

  float2 var1 = (float2) (123455.134,-12345.032);
  float2 var2 = (float2) (-12345.032,-1.23);
  int i = printf("float2_f_7106c===%+010.3v2hlf===%+010.3v2hlf===\n",var1,var2);
  return i;
}

int float2_f_7107c() {

  float2 var1 = (float2) (123455.134,-12345.032);
  float2 var2 = (float2) (-12345.032,123455.134);
  int i = printf("float2_f_7107c===%+010.10v2hlf===%+010.10v2hlf===\n",var1,var2);
  return i;
}

int float2_f_7108c() {

  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (-12345.032,0.0);
  int i = printf("float2_f_7108c===%+010v2hlF===%+010v2hlF===\n",var1,var2);
  return i;
}

int float2_f_7109c() {

  float2 var1 = (float2) (-1.23,2.0);
  float2 var2 = (float2) (2.0,-12345.032);
  int i = printf("float2_f_7109c===%+010.1v2hlF===%+010.1v2hlF===\n",var1,var2);
  return i;
}

int float2_f_7110c() {

  float2 var1 = (float2) (123455.134,-12345.032);
  float2 var2 = (float2) (-12345.032,-12345.032);
  int i = printf("float2_f_7110c===%+010.2v2hlF===%+010.2v2hlF===\n",var1,var2);
  return i;
}

int float2_f_7111c() {

  float2 var1 = (float2) (1.0,-1.23);
  float2 var2 = (float2) (-1.23,2.0);
  int i = printf("float2_f_7111c===%+010.3v2hlF===%+010.3v2hlF===\n",var1,var2);
  return i;
}

int float2_f_7112c() {

  float2 var1 = (float2) (0.0,-12345.032);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_f_7112c===%+010.10v2hlF===%+010.10v2hlF===\n",var1,var2);
  return i;
}

int float2_g_1033c() {

  float2 var1 = (float2) (-1.23,1.0);
  float2 var2 = (float2) (123455.134,0.0);
  int i = printf("float2_g_1033c===%-v2hlg===%-v2hlg===\n",var1,var2);
  return i;
}

int float2_g_1034c() {

  float2 var1 = (float2) (-1.23,0.0);
  float2 var2 = (float2) (1.0,0.0);
  int i = printf("float2_g_1034c===%-.1v2hlg===%-.1v2hlg===\n",var1,var2);
  return i;
}

int float2_g_1035c() {

  float2 var1 = (float2) (0.0,-1.23);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_g_1035c===%-.2v2hlg===%-.2v2hlg===\n",var1,var2);
  return i;
}

int float2_g_1036c() {

  float2 var1 = (float2) (-1.23,-12345.032);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_g_1036c===%-.3v2hlg===%-.3v2hlg===\n",var1,var2);
  return i;
}

int float2_g_1037c() {

  float2 var1 = (float2) (0.0,123455.134);
  float2 var2 = (float2) (0.0,-12345.032);
  int i = printf("float2_g_1037c===%-.10v2hlg===%-.10v2hlg===\n",var1,var2);
  return i;
}

int float2_g_1038c() {

  float2 var1 = (float2) (123455.134,2.0);
  float2 var2 = (float2) (-1.23,-1.23);
  int i = printf("float2_g_1038c===%-v2hlG===%-v2hlG===\n",var1,var2);
  return i;
}

int float2_g_1039c() {

  float2 var1 = (float2) (2.0,2.0);
  float2 var2 = (float2) (2.0,-12345.032);
  int i = printf("float2_g_1039c===%-.1v2hlG===%-.1v2hlG===\n",var1,var2);
  return i;
}

int float2_g_1040c() {

  float2 var1 = (float2) (2.0,-1.23);
  float2 var2 = (float2) (0.0,2.0);
  int i = printf("float2_g_1040c===%-.2v2hlG===%-.2v2hlG===\n",var1,var2);
  return i;
}

int float2_g_1041c() {

  float2 var1 = (float2) (2.0,1.0);
  float2 var2 = (float2) (123455.134,123455.134);
  int i = printf("float2_g_1041c===%-.3v2hlG===%-.3v2hlG===\n",var1,var2);
  return i;
}

int float2_g_1042c() {

  float2 var1 = (float2) (0.0,1.0);
  float2 var2 = (float2) (0.0,-1.23);
  int i = printf("float2_g_1042c===%-.10v2hlG===%-.10v2hlG===\n",var1,var2);
  return i;
}

int float2_g_1793c() {

  float2 var1 = (float2) (0.0,-12345.032);
  float2 var2 = (float2) (123455.134,1.0);
  int i = printf("float2_g_1793c===%+v2hlg===%+v2hlg===\n",var1,var2);
  return i;
}

int float2_g_1794c() {

  float2 var1 = (float2) (-1.23,2.0);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_g_1794c===%+.1v2hlg===%+.1v2hlg===\n",var1,var2);
  return i;
}

int float2_g_1795c() {

  float2 var1 = (float2) (2.0,-1.23);
  float2 var2 = (float2) (2.0,1.0);
  int i = printf("float2_g_1795c===%+.2v2hlg===%+.2v2hlg===\n",var1,var2);
  return i;
}

int float2_g_1796c() {

  float2 var1 = (float2) (2.0,0.0);
  float2 var2 = (float2) (-12345.032,123455.134);
  int i = printf("float2_g_1796c===%+.3v2hlg===%+.3v2hlg===\n",var1,var2);
  return i;
}

int float2_g_1797c() {

  float2 var1 = (float2) (1.0,-1.23);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_g_1797c===%+.10v2hlg===%+.10v2hlg===\n",var1,var2);
  return i;
}

int float2_g_1798c() {

  float2 var1 = (float2) (-1.23,-12345.032);
  float2 var2 = (float2) (-12345.032,-12345.032);
  int i = printf("float2_g_1798c===%+v2hlG===%+v2hlG===\n",var1,var2);
  return i;
}

int float2_g_1799c() {

  float2 var1 = (float2) (-12345.032,2.0);
  float2 var2 = (float2) (-1.23,2.0);
  int i = printf("float2_g_1799c===%+.1v2hlG===%+.1v2hlG===\n",var1,var2);
  return i;
}

int float2_g_1800c() {

  float2 var1 = (float2) (1.0,123455.134);
  float2 var2 = (float2) (0.0,1.0);
  int i = printf("float2_g_1800c===%+.2v2hlG===%+.2v2hlG===\n",var1,var2);
  return i;
}

int float2_g_1801c() {

  float2 var1 = (float2) (0.0,-1.23);
  float2 var2 = (float2) (-1.23,-1.23);
  int i = printf("float2_g_1801c===%+.3v2hlG===%+.3v2hlG===\n",var1,var2);
  return i;
}

int float2_g_1802c() {

  float2 var1 = (float2) (-12345.032,-12345.032);
  float2 var2 = (float2) (0.0,1.0);
  int i = printf("float2_g_1802c===%+.10v2hlG===%+.10v2hlG===\n",var1,var2);
  return i;
}

int float2_g_2553c() {

  float2 var1 = (float2) (123455.134,123455.134);
  float2 var2 = (float2) (1.0,-12345.032);
  int i = printf("float2_g_2553c===%#v2hlg===%#v2hlg===\n",var1,var2);
  return i;
}

int float2_g_2554c() {

  float2 var1 = (float2) (2.0,-12345.032);
  float2 var2 = (float2) (0.0,-12345.032);
  int i = printf("float2_g_2554c===%#.1v2hlg===%#.1v2hlg===\n",var1,var2);
  return i;
}

int float2_g_2555c() {

  float2 var1 = (float2) (2.0,2.0);
  float2 var2 = (float2) (-12345.032,2.0);
  int i = printf("float2_g_2555c===%#.2v2hlg===%#.2v2hlg===\n",var1,var2);
  return i;
}

int float2_g_2556c() {

  float2 var1 = (float2) (0.0,1.0);
  float2 var2 = (float2) (-1.23,1.0);
  int i = printf("float2_g_2556c===%#.3v2hlg===%#.3v2hlg===\n",var1,var2);
  return i;
}

int float2_g_2557c() {

  float2 var1 = (float2) (-12345.032,123455.134);
  float2 var2 = (float2) (123455.134,-1.23);
  int i = printf("float2_g_2557c===%#.10v2hlg===%#.10v2hlg===\n",var1,var2);
  return i;
}

int float2_g_2558c() {

  float2 var1 = (float2) (-1.23,123455.134);
  float2 var2 = (float2) (1.0,-1.23);
  int i = printf("float2_g_2558c===%#v2hlG===%#v2hlG===\n",var1,var2);
  return i;
}

int float2_g_2559c() {

  float2 var1 = (float2) (-1.23,0.0);
  float2 var2 = (float2) (1.0,2.0);
  int i = printf("float2_g_2559c===%#.1v2hlG===%#.1v2hlG===\n",var1,var2);
  return i;
}

int float2_g_2560c() {

  float2 var1 = (float2) (123455.134,2.0);
  float2 var2 = (float2) (0.0,0.0);
  int i = printf("float2_g_2560c===%#.2v2hlG===%#.2v2hlG===\n",var1,var2);
  return i;
}

int float2_g_2561c() {

  float2 var1 = (float2) (0.0,123455.134);
  float2 var2 = (float2) (0.0,1.0);
  int i = printf("float2_g_2561c===%#.3v2hlG===%#.3v2hlG===\n",var1,var2);
  return i;
}

int float2_g_2562c() {

  float2 var1 = (float2) (2.0,2.0);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_g_2562c===%#.10v2hlG===%#.10v2hlG===\n",var1,var2);
  return i;
}

int float2_g_273c() {

  float2 var1 = (float2) (-1.23,-1.23);
  float2 var2 = (float2) (2.0,-1.23);
  int i = printf("float2_g_273c===%v2hlg===%v2hlg===\n",var1,var2);
  return i;
}

int float2_g_274c() {

  float2 var1 = (float2) (123455.134,123455.134);
  float2 var2 = (float2) (-12345.032,2.0);
  int i = printf("float2_g_274c===%.1v2hlg===%.1v2hlg===\n",var1,var2);
  return i;
}

int float2_g_275c() {

  float2 var1 = (float2) (2.0,-1.23);
  float2 var2 = (float2) (2.0,-1.23);
  int i = printf("float2_g_275c===%.2v2hlg===%.2v2hlg===\n",var1,var2);
  return i;
}

int float2_g_276c() {

  float2 var1 = (float2) (1.0,-12345.032);
  float2 var2 = (float2) (1.0,2.0);
  int i = printf("float2_g_276c===%.3v2hlg===%.3v2hlg===\n",var1,var2);
  return i;
}

int float2_g_277c() {

  float2 var1 = (float2) (123455.134,0.0);
  float2 var2 = (float2) (123455.134,123455.134);
  int i = printf("float2_g_277c===%.10v2hlg===%.10v2hlg===\n",var1,var2);
  return i;
}

int float2_g_278c() {

  float2 var1 = (float2) (-1.23,0.0);
  float2 var2 = (float2) (0.0,-1.23);
  int i = printf("float2_g_278c===%v2hlG===%v2hlG===\n",var1,var2);
  return i;
}

int float2_g_279c() {

  float2 var1 = (float2) (2.0,123455.134);
  float2 var2 = (float2) (-1.23,123455.134);
  int i = printf("float2_g_279c===%.1v2hlG===%.1v2hlG===\n",var1,var2);
  return i;
}

int float2_g_280c() {

  float2 var1 = (float2) (-1.23,123455.134);
  float2 var2 = (float2) (-12345.032,0.0);
  int i = printf("float2_g_280c===%.2v2hlG===%.2v2hlG===\n",var1,var2);
  return i;
}

int float2_g_281c() {

  float2 var1 = (float2) (1.0,2.0);
  float2 var2 = (float2) (123455.134,0.0);
  int i = printf("float2_g_281c===%.3v2hlG===%.3v2hlG===\n",var1,var2);
  return i;
}

int float2_g_282c() {

  float2 var1 = (float2) (-12345.032,123455.134);
  float2 var2 = (float2) (123455.134,1.0);
  int i = printf("float2_g_282c===%.10v2hlG===%.10v2hlG===\n",var1,var2);
  return i;
}

int float2_g_3313c() {

  float2 var1 = (float2) (-1.23,0.0);
  float2 var2 = (float2) (-12345.032,-1.23);
  int i = printf("float2_g_3313c===%-+v2hlg===%-+v2hlg===\n",var1,var2);
  return i;
}

int float2_g_3314c() {

  float2 var1 = (float2) (2.0,2.0);
  float2 var2 = (float2) (-1.23,-1.23);
  int i = printf("float2_g_3314c===%-+.1v2hlg===%-+.1v2hlg===\n",var1,var2);
  return i;
}

int float2_g_3315c() {

  float2 var1 = (float2) (1.0,-12345.032);
  float2 var2 = (float2) (-1.23,2.0);
  int i = printf("float2_g_3315c===%-+.2v2hlg===%-+.2v2hlg===\n",var1,var2);
  return i;
}

int float2_g_3316c() {

  float2 var1 = (float2) (0.0,2.0);
  float2 var2 = (float2) (1.0,2.0);
  int i = printf("float2_g_3316c===%-+.3v2hlg===%-+.3v2hlg===\n",var1,var2);
  return i;
}

int float2_g_3317c() {

  float2 var1 = (float2) (-12345.032,-1.23);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_g_3317c===%-+.10v2hlg===%-+.10v2hlg===\n",var1,var2);
  return i;
}

int float2_g_3318c() {

  float2 var1 = (float2) (-1.23,-12345.032);
  float2 var2 = (float2) (123455.134,2.0);
  int i = printf("float2_g_3318c===%-+v2hlG===%-+v2hlG===\n",var1,var2);
  return i;
}

int float2_g_3319c() {

  float2 var1 = (float2) (123455.134,1.0);
  float2 var2 = (float2) (0.0,2.0);
  int i = printf("float2_g_3319c===%-+.1v2hlG===%-+.1v2hlG===\n",var1,var2);
  return i;
}

int float2_g_3320c() {

  float2 var1 = (float2) (0.0,2.0);
  float2 var2 = (float2) (123455.134,123455.134);
  int i = printf("float2_g_3320c===%-+.2v2hlG===%-+.2v2hlG===\n",var1,var2);
  return i;
}

int float2_g_3321c() {

  float2 var1 = (float2) (2.0,-1.23);
  float2 var2 = (float2) (0.0,1.0);
  int i = printf("float2_g_3321c===%-+.3v2hlG===%-+.3v2hlG===\n",var1,var2);
  return i;
}

int float2_g_3322c() {

  float2 var1 = (float2) (-1.23,-12345.032);
  float2 var2 = (float2) (1.0,2.0);
  int i = printf("float2_g_3322c===%-+.10v2hlG===%-+.10v2hlG===\n",var1,var2);
  return i;
}

int float2_g_4073c() {

  float2 var1 = (float2) (123455.134,2.0);
  float2 var2 = (float2) (-12345.032,0.0);
  int i = printf("float2_g_4073c===% 10v2hlg===% 10v2hlg===\n",var1,var2);
  return i;
}

int float2_g_4074c() {

  float2 var1 = (float2) (-1.23,123455.134);
  float2 var2 = (float2) (123455.134,-1.23);
  int i = printf("float2_g_4074c===% 10.1v2hlg===% 10.1v2hlg===\n",var1,var2);
  return i;
}

int float2_g_4075c() {

  float2 var1 = (float2) (1.0,0.0);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_g_4075c===% 10.2v2hlg===% 10.2v2hlg===\n",var1,var2);
  return i;
}

int float2_g_4076c() {

  float2 var1 = (float2) (-1.23,123455.134);
  float2 var2 = (float2) (-1.23,0.0);
  int i = printf("float2_g_4076c===% 10.3v2hlg===% 10.3v2hlg===\n",var1,var2);
  return i;
}

int float2_g_4077c() {

  float2 var1 = (float2) (123455.134,123455.134);
  float2 var2 = (float2) (1.0,0.0);
  int i = printf("float2_g_4077c===% 10.10v2hlg===% 10.10v2hlg===\n",var1,var2);
  return i;
}

int float2_g_4078c() {

  float2 var1 = (float2) (123455.134,0.0);
  float2 var2 = (float2) (2.0,2.0);
  int i = printf("float2_g_4078c===% 10v2hlG===% 10v2hlG===\n",var1,var2);
  return i;
}

int float2_g_4079c() {

  float2 var1 = (float2) (0.0,2.0);
  float2 var2 = (float2) (2.0,123455.134);
  int i = printf("float2_g_4079c===% 10.1v2hlG===% 10.1v2hlG===\n",var1,var2);
  return i;
}

int float2_g_4080c() {

  float2 var1 = (float2) (0.0,0.0);
  float2 var2 = (float2) (2.0,-12345.032);
  int i = printf("float2_g_4080c===% 10.2v2hlG===% 10.2v2hlG===\n",var1,var2);
  return i;
}

int float2_g_4081c() {

  float2 var1 = (float2) (-1.23,123455.134);
  float2 var2 = (float2) (-1.23,-12345.032);
  int i = printf("float2_g_4081c===% 10.3v2hlG===% 10.3v2hlG===\n",var1,var2);
  return i;
}

int float2_g_4082c() {

  float2 var1 = (float2) (1.0,123455.134);
  float2 var2 = (float2) (-1.23,-12345.032);
  int i = printf("float2_g_4082c===% 10.10v2hlG===% 10.10v2hlG===\n",var1,var2);
  return i;
}

int float2_g_4833c() {

  float2 var1 = (float2) (2.0,2.0);
  float2 var2 = (float2) (-12345.032,0.0);
  int i = printf("float2_g_4833c===%010v2hlg===%010v2hlg===\n",var1,var2);
  return i;
}

int float2_g_4834c() {

  float2 var1 = (float2) (-12345.032,123455.134);
  float2 var2 = (float2) (123455.134,2.0);
  int i = printf("float2_g_4834c===%010.1v2hlg===%010.1v2hlg===\n",var1,var2);
  return i;
}

int float2_g_4835c() {

  float2 var1 = (float2) (2.0,1.0);
  float2 var2 = (float2) (123455.134,-1.23);
  int i = printf("float2_g_4835c===%010.2v2hlg===%010.2v2hlg===\n",var1,var2);
  return i;
}

int float2_g_4836c() {

  float2 var1 = (float2) (2.0,-12345.032);
  float2 var2 = (float2) (123455.134,123455.134);
  int i = printf("float2_g_4836c===%010.3v2hlg===%010.3v2hlg===\n",var1,var2);
  return i;
}

int float2_g_4837c() {

  float2 var1 = (float2) (0.0,1.0);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_g_4837c===%010.10v2hlg===%010.10v2hlg===\n",var1,var2);
  return i;
}

int float2_g_4838c() {

  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (1.0,2.0);
  int i = printf("float2_g_4838c===%010v2hlG===%010v2hlG===\n",var1,var2);
  return i;
}

int float2_g_4839c() {

  float2 var1 = (float2) (1.0,123455.134);
  float2 var2 = (float2) (2.0,2.0);
  int i = printf("float2_g_4839c===%010.1v2hlG===%010.1v2hlG===\n",var1,var2);
  return i;
}

int float2_g_4840c() {

  float2 var1 = (float2) (-12345.032,2.0);
  float2 var2 = (float2) (-1.23,-12345.032);
  int i = printf("float2_g_4840c===%010.2v2hlG===%010.2v2hlG===\n",var1,var2);
  return i;
}

int float2_g_4841c() {

  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (-12345.032,-12345.032);
  int i = printf("float2_g_4841c===%010.3v2hlG===%010.3v2hlG===\n",var1,var2);
  return i;
}

int float2_g_4842c() {

  float2 var1 = (float2) (1.0,2.0);
  float2 var2 = (float2) (0.0,2.0);
  int i = printf("float2_g_4842c===%010.10v2hlG===%010.10v2hlG===\n",var1,var2);
  return i;
}

int float2_g_5593c() {

  float2 var1 = (float2) (123455.134,0.0);
  float2 var2 = (float2) (-1.23,-12345.032);
  int i = printf("float2_g_5593c===%- 10v2hlg===%- 10v2hlg===\n",var1,var2);
  return i;
}

int float2_g_5594c() {

  float2 var1 = (float2) (123455.134,-1.23);
  float2 var2 = (float2) (-1.23,-1.23);
  int i = printf("float2_g_5594c===%- 10.1v2hlg===%- 10.1v2hlg===\n",var1,var2);
  return i;
}

int float2_g_5595c() {

  float2 var1 = (float2) (123455.134,1.0);
  float2 var2 = (float2) (-12345.032,123455.134);
  int i = printf("float2_g_5595c===%- 10.2v2hlg===%- 10.2v2hlg===\n",var1,var2);
  return i;
}

int float2_g_5596c() {

  float2 var1 = (float2) (-12345.032,123455.134);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_g_5596c===%- 10.3v2hlg===%- 10.3v2hlg===\n",var1,var2);
  return i;
}

int float2_g_5597c() {

  float2 var1 = (float2) (2.0,-12345.032);
  float2 var2 = (float2) (-1.23,-1.23);
  int i = printf("float2_g_5597c===%- 10.10v2hlg===%- 10.10v2hlg===\n",var1,var2);
  return i;
}

int float2_g_5598c() {

  float2 var1 = (float2) (-12345.032,2.0);
  float2 var2 = (float2) (123455.134,0.0);
  int i = printf("float2_g_5598c===%- 10v2hlG===%- 10v2hlG===\n",var1,var2);
  return i;
}

int float2_g_5599c() {

  float2 var1 = (float2) (1.0,-12345.032);
  float2 var2 = (float2) (123455.134,-1.23);
  int i = printf("float2_g_5599c===%- 10.1v2hlG===%- 10.1v2hlG===\n",var1,var2);
  return i;
}

int float2_g_5600c() {

  float2 var1 = (float2) (0.0,123455.134);
  float2 var2 = (float2) (0.0,2.0);
  int i = printf("float2_g_5600c===%- 10.2v2hlG===%- 10.2v2hlG===\n",var1,var2);
  return i;
}

int float2_g_5601c() {

  float2 var1 = (float2) (0.0,-1.23);
  float2 var2 = (float2) (-12345.032,-1.23);
  int i = printf("float2_g_5601c===%- 10.3v2hlG===%- 10.3v2hlG===\n",var1,var2);
  return i;
}

int float2_g_5602c() {

  float2 var1 = (float2) (1.0,-1.23);
  float2 var2 = (float2) (1.0,-12345.032);
  int i = printf("float2_g_5602c===%- 10.10v2hlG===%- 10.10v2hlG===\n",var1,var2);
  return i;
}

int float2_g_6353c() {

  float2 var1 = (float2) (0.0,2.0);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_g_6353c===%+ 10v2hlg===%+ 10v2hlg===\n",var1,var2);
  return i;
}

int float2_g_6354c() {

  float2 var1 = (float2) (2.0,2.0);
  float2 var2 = (float2) (123455.134,-1.23);
  int i = printf("float2_g_6354c===%+ 10.1v2hlg===%+ 10.1v2hlg===\n",var1,var2);
  return i;
}

int float2_g_6355c() {

  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_g_6355c===%+ 10.2v2hlg===%+ 10.2v2hlg===\n",var1,var2);
  return i;
}

int float2_g_6356c() {

  float2 var1 = (float2) (-1.23,0.0);
  float2 var2 = (float2) (1.0,-12345.032);
  int i = printf("float2_g_6356c===%+ 10.3v2hlg===%+ 10.3v2hlg===\n",var1,var2);
  return i;
}

int float2_g_6357c() {

  float2 var1 = (float2) (0.0,0.0);
  float2 var2 = (float2) (2.0,1.0);
  int i = printf("float2_g_6357c===%+ 10.10v2hlg===%+ 10.10v2hlg===\n",var1,var2);
  return i;
}

int float2_g_6358c() {

  float2 var1 = (float2) (0.0,-1.23);
  float2 var2 = (float2) (-1.23,-1.23);
  int i = printf("float2_g_6358c===%+ 10v2hlG===%+ 10v2hlG===\n",var1,var2);
  return i;
}

int float2_g_6359c() {

  float2 var1 = (float2) (2.0,0.0);
  float2 var2 = (float2) (-1.23,-1.23);
  int i = printf("float2_g_6359c===%+ 10.1v2hlG===%+ 10.1v2hlG===\n",var1,var2);
  return i;
}

int float2_g_6360c() {

  float2 var1 = (float2) (2.0,-1.23);
  float2 var2 = (float2) (0.0,123455.134);
  int i = printf("float2_g_6360c===%+ 10.2v2hlG===%+ 10.2v2hlG===\n",var1,var2);
  return i;
}

int float2_g_6361c() {

  float2 var1 = (float2) (2.0,0.0);
  float2 var2 = (float2) (2.0,-12345.032);
  int i = printf("float2_g_6361c===%+ 10.3v2hlG===%+ 10.3v2hlG===\n",var1,var2);
  return i;
}

int float2_g_6362c() {

  float2 var1 = (float2) (123455.134,2.0);
  float2 var2 = (float2) (-1.23,123455.134);
  int i = printf("float2_g_6362c===%+ 10.10v2hlG===%+ 10.10v2hlG===\n",var1,var2);
  return i;
}

int float2_g_7113c() {

  float2 var1 = (float2) (0.0,1.0);
  float2 var2 = (float2) (-12345.032,0.0);
  int i = printf("float2_g_7113c===%+010v2hlg===%+010v2hlg===\n",var1,var2);
  return i;
}

int float2_g_7114c() {

  float2 var1 = (float2) (123455.134,-12345.032);
  float2 var2 = (float2) (1.0,2.0);
  int i = printf("float2_g_7114c===%+010.1v2hlg===%+010.1v2hlg===\n",var1,var2);
  return i;
}

int float2_g_7115c() {

  float2 var1 = (float2) (1.0,0.0);
  float2 var2 = (float2) (123455.134,123455.134);
  int i = printf("float2_g_7115c===%+010.2v2hlg===%+010.2v2hlg===\n",var1,var2);
  return i;
}

int float2_g_7116c() {

  float2 var1 = (float2) (0.0,-12345.032);
  float2 var2 = (float2) (123455.134,2.0);
  int i = printf("float2_g_7116c===%+010.3v2hlg===%+010.3v2hlg===\n",var1,var2);
  return i;
}

int float2_g_7117c() {

  float2 var1 = (float2) (-1.23,0.0);
  float2 var2 = (float2) (1.0,123455.134);
  int i = printf("float2_g_7117c===%+010.10v2hlg===%+010.10v2hlg===\n",var1,var2);
  return i;
}

int float2_g_7118c() {

  float2 var1 = (float2) (1.0,1.0);
  float2 var2 = (float2) (-1.23,-1.23);
  int i = printf("float2_g_7118c===%+010v2hlG===%+010v2hlG===\n",var1,var2);
  return i;
}

int float2_g_7119c() {

  float2 var1 = (float2) (-12345.032,0.0);
  float2 var2 = (float2) (-12345.032,0.0);
  int i = printf("float2_g_7119c===%+010.1v2hlG===%+010.1v2hlG===\n",var1,var2);
  return i;
}

int float2_g_7120c() {

  float2 var1 = (float2) (123455.134,1.0);
  float2 var2 = (float2) (123455.134,1.0);
  int i = printf("float2_g_7120c===%+010.2v2hlG===%+010.2v2hlG===\n",var1,var2);
  return i;
}

int float2_g_7121c() {

  float2 var1 = (float2) (1.0,0.0);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_g_7121c===%+010.3v2hlG===%+010.3v2hlG===\n",var1,var2);
  return i;
}

int float2_g_7122c() {

  float2 var1 = (float2) (2.0,1.0);
  float2 var2 = (float2) (-12345.032,1.0);
  int i = printf("float2_g_7122c===%+010.10v2hlG===%+010.10v2hlG===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = float2_a_1003c();
i = float2_a_1004c();
i = float2_a_1005c();
i = float2_a_1006c();
i = float2_a_1007c();
i = float2_a_1008c();
i = float2_a_1009c();
i = float2_a_1010c();
i = float2_a_1011c();
i = float2_a_1012c();
i = float2_a_1763c();
i = float2_a_1764c();
i = float2_a_1765c();
i = float2_a_1766c();
i = float2_a_1767c();
i = float2_a_1768c();
i = float2_a_1769c();
i = float2_a_1770c();
i = float2_a_1771c();
i = float2_a_1772c();
i = float2_a_243c();
i = float2_a_244c();
i = float2_a_245c();
i = float2_a_246c();
i = float2_a_247c();
i = float2_a_248c();
i = float2_a_249c();
i = float2_a_250c();
i = float2_a_251c();
i = float2_a_252c();
i = float2_a_2523c();
i = float2_a_2524c();
i = float2_a_2525c();
i = float2_a_2526c();
i = float2_a_2527c();
i = float2_a_2528c();
i = float2_a_2529c();
i = float2_a_2530c();
i = float2_a_2531c();
i = float2_a_2532c();
i = float2_a_3283c();
i = float2_a_3284c();
i = float2_a_3285c();
i = float2_a_3286c();
i = float2_a_3287c();
i = float2_a_3288c();
i = float2_a_3289c();
i = float2_a_3290c();
i = float2_a_3291c();
i = float2_a_3292c();
i = float2_a_4043c();
i = float2_a_4044c();
i = float2_a_4045c();
i = float2_a_4046c();
i = float2_a_4047c();
i = float2_a_4048c();
i = float2_a_4049c();
i = float2_a_4050c();
i = float2_a_4051c();
i = float2_a_4052c();
i = float2_a_4803c();
i = float2_a_4804c();
i = float2_a_4805c();
i = float2_a_4806c();
i = float2_a_4807c();
i = float2_a_4808c();
i = float2_a_4809c();
i = float2_a_4810c();
i = float2_a_4811c();
i = float2_a_4812c();
i = float2_a_5563c();
i = float2_a_5564c();
i = float2_a_5565c();
i = float2_a_5566c();
i = float2_a_5567c();
i = float2_a_5568c();
i = float2_a_5569c();
i = float2_a_5570c();
i = float2_a_5571c();
i = float2_a_5572c();
i = float2_a_6323c();
i = float2_a_6324c();
i = float2_a_6325c();
i = float2_a_6326c();
i = float2_a_6327c();
i = float2_a_6328c();
i = float2_a_6329c();
i = float2_a_6330c();
i = float2_a_6331c();
i = float2_a_6332c();
i = float2_a_7083c();
i = float2_a_7084c();
i = float2_a_7085c();
i = float2_a_7086c();
i = float2_a_7087c();
i = float2_a_7088c();
i = float2_a_7089c();
i = float2_a_7090c();
i = float2_a_7091c();
i = float2_a_7092c();












































































































































































































































































































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
