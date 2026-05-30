/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/float4_a.c'  */

int float4_a_1147c() {
  // { dg-printf "float4_a_1147c===-0x1.3ae1480000000p+0,0x1.0000000000000p+1,0x1.0000000000000p+0,-0x1.81c8420000000p+13===0x1.0000000000000p+0,0x1.0000000000000p+1,0x0.0000000000000p+0,0x1.0000000000000p+0===" }
  float4 var1 = (float4) (-1.23,2.0,1.0,-12345.032);
  float4 var2 = (float4) (1.0,2.0,0.0,1.0);
  int i = printf("float4_a_1147c===%-v4hla===%-v4hla===\n",var1,var2);
  return i;
}

int float4_a_1148c() {
  // { dg-printf "float4_a_1148c===0x1.ep+16,-0x1.8p+13,0x1.0p+1,-0x1.4p+0===-0x1.8p+13,0x1.ep+16,0x1.0p+0,0x1.ep+16===" }
  float4 var1 = (float4) (123455.134,-12345.032,2.0,-1.23);
  float4 var2 = (float4) (-12345.032,123455.134,1.0,123455.134);
  int i = printf("float4_a_1148c===%-.1v4hla===%-.1v4hla===\n",var1,var2);
  return i;
}

int float4_a_1149c() {
  // { dg-printf "float4_a_1149c===0x1.00p+0,0x1.e2p+16,-0x1.82p+13,0x1.00p+0===0x1.e2p+16,0x0.00p+0,0x1.00p+0,-0x1.82p+13===" }
  float4 var1 = (float4) (1.0,123455.134,-12345.032,1.0);
  float4 var2 = (float4) (123455.134,0.0,1.0,-12345.032);
  int i = printf("float4_a_1149c===%-.2v4hla===%-.2v4hla===\n",var1,var2);
  return i;
}

int float4_a_1150c() {
  // { dg-printf "float4_a_1150c===0x0.000p+0,0x1.e24p+16,0x1.000p+1,0x1.000p+0===0x1.000p+0,0x1.e24p+16,0x1.000p+0,0x0.000p+0===" }
  float4 var1 = (float4) (0.0,123455.134,2.0,1.0);
  float4 var2 = (float4) (1.0,123455.134,1.0,0.0);
  int i = printf("float4_a_1150c===%-.3v4hla===%-.3v4hla===\n",var1,var2);
  return i;
}

int float4_a_1151c() {
  // { dg-printf "float4_a_1151c===0x1.0000000000p+0,0x0.0000000000p+0,-0x1.3ae1480000p+0,0x1.0000000000p+0===0x1.0000000000p+0,-0x1.81c8420000p+13,0x1.0000000000p+1,-0x1.81c8420000p+13===" }
  float4 var1 = (float4) (1.0,0.0,-1.23,1.0);
  float4 var2 = (float4) (1.0,-12345.032,2.0,-12345.032);
  int i = printf("float4_a_1151c===%-.10v4hla===%-.10v4hla===\n",var1,var2);
  return i;
}

int float4_a_1152c() {
  // { dg-printf "float4_a_1152c===0X1.E23F220000000P+16,-0X1.3AE1480000000P+0,-0X1.3AE1480000000P+0,0X1.0000000000000P+0===0X0.0000000000000P+0,0X1.E23F220000000P+16,-0X1.3AE1480000000P+0,0X1.0000000000000P+0===" }
  float4 var1 = (float4) (123455.134,-1.23,-1.23,1.0);
  float4 var2 = (float4) (0.0,123455.134,-1.23,1.0);
  int i = printf("float4_a_1152c===%-v4hlA===%-v4hlA===\n",var1,var2);
  return i;
}

int float4_a_1153c() {
  // { dg-printf "float4_a_1153c===0X1.0P+0,0X1.0P+1,-0X1.4P+0,0X0.0P+0===-0X1.8P+13,0X0.0P+0,-0X1.8P+13,0X1.EP+16===" }
  float4 var1 = (float4) (1.0,2.0,-1.23,0.0);
  float4 var2 = (float4) (-12345.032,0.0,-12345.032,123455.134);
  int i = printf("float4_a_1153c===%-.1v4hlA===%-.1v4hlA===\n",var1,var2);
  return i;
}

int float4_a_1154c() {
  // { dg-printf "float4_a_1154c===0X1.E2P+16,-0X1.3BP+0,0X0.00P+0,-0X1.82P+13===0X0.00P+0,-0X1.3BP+0,0X0.00P+0,-0X1.82P+13===" }
  float4 var1 = (float4) (123455.134,-1.23,0.0,-12345.032);
  float4 var2 = (float4) (0.0,-1.23,0.0,-12345.032);
  int i = printf("float4_a_1154c===%-.2v4hlA===%-.2v4hlA===\n",var1,var2);
  return i;
}

int float4_a_1155c() {
  // { dg-printf "float4_a_1155c===0X1.000P+0,-0X1.81CP+13,0X0.000P+0,0X0.000P+0===-0X1.81CP+13,-0X1.81CP+13,0X1.000P+0,-0X1.81CP+13===" }
  float4 var1 = (float4) (1.0,-12345.032,0.0,0.0);
  float4 var2 = (float4) (-12345.032,-12345.032,1.0,-12345.032);
  int i = printf("float4_a_1155c===%-.3v4hlA===%-.3v4hlA===\n",var1,var2);
  return i;
}

int float4_a_1156c() {
  // { dg-printf "float4_a_1156c===0X1.E23F220000P+16,0X1.E23F220000P+16,0X1.0000000000P+1,-0X1.3AE1480000P+0===0X1.0000000000P+1,-0X1.3AE1480000P+0,-0X1.3AE1480000P+0,-0X1.81C8420000P+13===" }
  float4 var1 = (float4) (123455.134,123455.134,2.0,-1.23);
  float4 var2 = (float4) (2.0,-1.23,-1.23,-12345.032);
  int i = printf("float4_a_1156c===%-.10v4hlA===%-.10v4hlA===\n",var1,var2);
  return i;
}

int float4_a_1907c() {
  // { dg-printf "float4_a_1907c===+0x0.0000000000000p+0,+0x1.e23f220000000p+16,+0x1.0000000000000p+0,+0x0.0000000000000p+0===-0x1.81c8420000000p+13,+0x1.0000000000000p+0,+0x1.e23f220000000p+16,+0x1.0000000000000p+1===" }
  float4 var1 = (float4) (0.0,123455.134,1.0,0.0);
  float4 var2 = (float4) (-12345.032,1.0,123455.134,2.0);
  int i = printf("float4_a_1907c===%+v4hla===%+v4hla===\n",var1,var2);
  return i;
}

int float4_a_1908c() {
  // { dg-printf "float4_a_1908c===+0x1.ep+16,+0x1.ep+16,+0x1.0p+1,+0x1.ep+16===+0x1.ep+16,-0x1.4p+0,+0x0.0p+0,+0x0.0p+0===" }
  float4 var1 = (float4) (123455.134,123455.134,2.0,123455.134);
  float4 var2 = (float4) (123455.134,-1.23,0.0,0.0);
  int i = printf("float4_a_1908c===%+.1v4hla===%+.1v4hla===\n",var1,var2);
  return i;
}

int float4_a_1909c() {
  // { dg-printf "float4_a_1909c===+0x0.00p+0,+0x1.00p+1,+0x1.e2p+16,-0x1.82p+13===-0x1.3bp+0,+0x1.00p+1,+0x1.00p+1,-0x1.3bp+0===" }
  float4 var1 = (float4) (0.0,2.0,123455.134,-12345.032);
  float4 var2 = (float4) (-1.23,2.0,2.0,-1.23);
  int i = printf("float4_a_1909c===%+.2v4hla===%+.2v4hla===\n",var1,var2);
  return i;
}

int float4_a_1910c() {
  // { dg-printf "float4_a_1910c===-0x1.3aep+0,-0x1.3aep+0,+0x1.000p+0,-0x1.81cp+13===-0x1.3aep+0,+0x1.e24p+16,+0x1.e24p+16,-0x1.81cp+13===" }
  float4 var1 = (float4) (-1.23,-1.23,1.0,-12345.032);
  float4 var2 = (float4) (-1.23,123455.134,123455.134,-12345.032);
  int i = printf("float4_a_1910c===%+.3v4hla===%+.3v4hla===\n",var1,var2);
  return i;
}

int float4_a_1911c() {
  // { dg-printf "float4_a_1911c===-0x1.81c8420000p+13,-0x1.81c8420000p+13,-0x1.3ae1480000p+0,+0x1.0000000000p+1===+0x1.e23f220000p+16,-0x1.81c8420000p+13,+0x1.e23f220000p+16,-0x1.81c8420000p+13===" }
  float4 var1 = (float4) (-12345.032,-12345.032,-1.23,2.0);
  float4 var2 = (float4) (123455.134,-12345.032,123455.134,-12345.032);
  int i = printf("float4_a_1911c===%+.10v4hla===%+.10v4hla===\n",var1,var2);
  return i;
}

int float4_a_1912c() {
  // { dg-printf "float4_a_1912c===+0X1.0000000000000P+1,+0X1.0000000000000P+1,+0X1.0000000000000P+1,+0X0.0000000000000P+0===-0X1.3AE1480000000P+0,+0X1.0000000000000P+0,+0X1.0000000000000P+0,-0X1.3AE1480000000P+0===" }
  float4 var1 = (float4) (2.0,2.0,2.0,0.0);
  float4 var2 = (float4) (-1.23,1.0,1.0,-1.23);
  int i = printf("float4_a_1912c===%+v4hlA===%+v4hlA===\n",var1,var2);
  return i;
}

int float4_a_1913c() {
  // { dg-printf "float4_a_1913c===+0X0.0P+0,+0X1.0P+1,+0X1.EP+16,-0X1.4P+0===+0X1.0P+0,-0X1.8P+13,+0X1.0P+1,+0X0.0P+0===" }
  float4 var1 = (float4) (0.0,2.0,123455.134,-1.23);
  float4 var2 = (float4) (1.0,-12345.032,2.0,0.0);
  int i = printf("float4_a_1913c===%+.1v4hlA===%+.1v4hlA===\n",var1,var2);
  return i;
}

int float4_a_1914c() {
  // { dg-printf "float4_a_1914c===+0X1.00P+0,+0X1.E2P+16,-0X1.3BP+0,+0X1.00P+1===-0X1.82P+13,-0X1.82P+13,-0X1.3BP+0,+0X1.00P+1===" }
  float4 var1 = (float4) (1.0,123455.134,-1.23,2.0);
  float4 var2 = (float4) (-12345.032,-12345.032,-1.23,2.0);
  int i = printf("float4_a_1914c===%+.2v4hlA===%+.2v4hlA===\n",var1,var2);
  return i;
}

int float4_a_1915c() {
  // { dg-printf "float4_a_1915c===-0X1.81CP+13,+0X1.000P+1,+0X1.E24P+16,+0X0.000P+0===+0X1.000P+0,+0X1.E24P+16,+0X1.E24P+16,+0X1.000P+1===" }
  float4 var1 = (float4) (-12345.032,2.0,123455.134,0.0);
  float4 var2 = (float4) (1.0,123455.134,123455.134,2.0);
  int i = printf("float4_a_1915c===%+.3v4hlA===%+.3v4hlA===\n",var1,var2);
  return i;
}

int float4_a_1916c() {
  // { dg-printf "float4_a_1916c===+0X1.0000000000P+1,+0X1.E23F220000P+16,+0X1.0000000000P+1,+0X1.0000000000P+0===+0X1.E23F220000P+16,-0X1.3AE1480000P+0,+0X1.0000000000P+1,+0X1.E23F220000P+16===" }
  float4 var1 = (float4) (2.0,123455.134,2.0,1.0);
  float4 var2 = (float4) (123455.134,-1.23,2.0,123455.134);
  int i = printf("float4_a_1916c===%+.10v4hlA===%+.10v4hlA===\n",var1,var2);
  return i;
}

int float4_a_2667c() {
  // { dg-printf "float4_a_2667c===0x0.0000000000000p+0,-0x1.81c8420000000p+13,0x0.0000000000000p+0,0x1.0000000000000p+1===-0x1.81c8420000000p+13,-0x1.3ae1480000000p+0,0x1.0000000000000p+0,-0x1.81c8420000000p+13===" }
  float4 var1 = (float4) (0.0,-12345.032,0.0,2.0);
  float4 var2 = (float4) (-12345.032,-1.23,1.0,-12345.032);
  int i = printf("float4_a_2667c===%#v4hla===%#v4hla===\n",var1,var2);
  return i;
}

int float4_a_2668c() {
  // { dg-printf "float4_a_2668c===0x1.ep+16,0x1.0p+0,0x0.0p+0,-0x1.8p+13===0x1.0p+0,-0x1.4p+0,0x0.0p+0,-0x1.8p+13===" }
  float4 var1 = (float4) (123455.134,1.0,0.0,-12345.032);
  float4 var2 = (float4) (1.0,-1.23,0.0,-12345.032);
  int i = printf("float4_a_2668c===%#.1v4hla===%#.1v4hla===\n",var1,var2);
  return i;
}

int float4_a_2669c() {
  // { dg-printf "float4_a_2669c===0x1.00p+1,0x1.e2p+16,-0x1.3bp+0,-0x1.3bp+0===0x1.00p+0,0x0.00p+0,0x1.00p+1,-0x1.82p+13===" }
  float4 var1 = (float4) (2.0,123455.134,-1.23,-1.23);
  float4 var2 = (float4) (1.0,0.0,2.0,-12345.032);
  int i = printf("float4_a_2669c===%#.2v4hla===%#.2v4hla===\n",var1,var2);
  return i;
}

int float4_a_2670c() {
  // { dg-printf "float4_a_2670c===-0x1.81cp+13,0x1.e24p+16,0x0.000p+0,0x1.000p+1===0x1.000p+0,-0x1.3aep+0,-0x1.3aep+0,0x1.000p+0===" }
  float4 var1 = (float4) (-12345.032,123455.134,0.0,2.0);
  float4 var2 = (float4) (1.0,-1.23,-1.23,1.0);
  int i = printf("float4_a_2670c===%#.3v4hla===%#.3v4hla===\n",var1,var2);
  return i;
}

int float4_a_2671c() {
  // { dg-printf "float4_a_2671c===-0x1.3ae1480000p+0,-0x1.81c8420000p+13,0x1.e23f220000p+16,0x1.0000000000p+0===0x1.e23f220000p+16,0x0.0000000000p+0,0x0.0000000000p+0,0x1.0000000000p+0===" }
  float4 var1 = (float4) (-1.23,-12345.032,123455.134,1.0);
  float4 var2 = (float4) (123455.134,0.0,0.0,1.0);
  int i = printf("float4_a_2671c===%#.10v4hla===%#.10v4hla===\n",var1,var2);
  return i;
}

int float4_a_2672c() {
  // { dg-printf "float4_a_2672c===-0X1.81C8420000000P+13,-0X1.3AE1480000000P+0,0X1.E23F220000000P+16,0X1.0000000000000P+0===0X1.E23F220000000P+16,-0X1.3AE1480000000P+0,0X1.E23F220000000P+16,0X1.0000000000000P+1===" }
  float4 var1 = (float4) (-12345.032,-1.23,123455.134,1.0);
  float4 var2 = (float4) (123455.134,-1.23,123455.134,2.0);
  int i = printf("float4_a_2672c===%#v4hlA===%#v4hlA===\n",var1,var2);
  return i;
}

int float4_a_2673c() {
  // { dg-printf "float4_a_2673c===0X1.EP+16,0X1.0P+1,0X1.0P+0,0X0.0P+0===0X1.0P+0,0X0.0P+0,-0X1.8P+13,-0X1.8P+13===" }
  float4 var1 = (float4) (123455.134,2.0,1.0,0.0);
  float4 var2 = (float4) (1.0,0.0,-12345.032,-12345.032);
  int i = printf("float4_a_2673c===%#.1v4hlA===%#.1v4hlA===\n",var1,var2);
  return i;
}

int float4_a_2674c() {
  // { dg-printf "float4_a_2674c===0X1.E2P+16,0X1.E2P+16,0X1.00P+0,0X1.00P+1===0X1.00P+0,0X1.E2P+16,0X1.E2P+16,-0X1.3BP+0===" }
  float4 var1 = (float4) (123455.134,123455.134,1.0,2.0);
  float4 var2 = (float4) (1.0,123455.134,123455.134,-1.23);
  int i = printf("float4_a_2674c===%#.2v4hlA===%#.2v4hlA===\n",var1,var2);
  return i;
}

int float4_a_2675c() {
  // { dg-printf "float4_a_2675c===-0X1.81CP+13,0X0.000P+0,0X0.000P+0,0X1.E24P+16===-0X1.3AEP+0,0X0.000P+0,-0X1.81CP+13,0X0.000P+0===" }
  float4 var1 = (float4) (-12345.032,0.0,0.0,123455.134);
  float4 var2 = (float4) (-1.23,0.0,-12345.032,0.0);
  int i = printf("float4_a_2675c===%#.3v4hlA===%#.3v4hlA===\n",var1,var2);
  return i;
}

int float4_a_2676c() {
  // { dg-printf "float4_a_2676c===0X1.0000000000P+0,-0X1.81C8420000P+13,0X1.E23F220000P+16,0X0.0000000000P+0===0X1.0000000000P+1,-0X1.3AE1480000P+0,0X0.0000000000P+0,0X0.0000000000P+0===" }
  float4 var1 = (float4) (1.0,-12345.032,123455.134,0.0);
  float4 var2 = (float4) (2.0,-1.23,0.0,0.0);
  int i = printf("float4_a_2676c===%#.10v4hlA===%#.10v4hlA===\n",var1,var2);
  return i;
}

int float4_a_3427c() {
  // { dg-printf "float4_a_3427c===+0x1.0000000000000p+0,-0x1.81c8420000000p+13,-0x1.81c8420000000p+13,-0x1.81c8420000000p+13===+0x0.0000000000000p+0,+0x1.0000000000000p+1,+0x0.0000000000000p+0,+0x1.e23f220000000p+16===" }
  float4 var1 = (float4) (1.0,-12345.032,-12345.032,-12345.032);
  float4 var2 = (float4) (0.0,2.0,0.0,123455.134);
  int i = printf("float4_a_3427c===%-+v4hla===%-+v4hla===\n",var1,var2);
  return i;
}

int float4_a_3428c() {
  // { dg-printf "float4_a_3428c===+0x1.ep+16,+0x1.0p+1,+0x1.0p+1,-0x1.4p+0===+0x0.0p+0,-0x1.4p+0,+0x1.0p+1,-0x1.4p+0===" }
  float4 var1 = (float4) (123455.134,2.0,2.0,-1.23);
  float4 var2 = (float4) (0.0,-1.23,2.0,-1.23);
  int i = printf("float4_a_3428c===%-+.1v4hla===%-+.1v4hla===\n",var1,var2);
  return i;
}

int float4_a_3429c() {
  // { dg-printf "float4_a_3429c===+0x1.00p+1,-0x1.3bp+0,+0x1.00p+0,+0x0.00p+0===-0x1.82p+13,-0x1.3bp+0,+0x1.00p+0,+0x1.00p+0===" }
  float4 var1 = (float4) (2.0,-1.23,1.0,0.0);
  float4 var2 = (float4) (-12345.032,-1.23,1.0,1.0);
  int i = printf("float4_a_3429c===%-+.2v4hla===%-+.2v4hla===\n",var1,var2);
  return i;
}

int float4_a_3430c() {
  // { dg-printf "float4_a_3430c===+0x0.000p+0,+0x1.000p+0,+0x1.e24p+16,-0x1.81cp+13===+0x1.000p+1,+0x1.000p+1,-0x1.3aep+0,+0x0.000p+0===" }
  float4 var1 = (float4) (0.0,1.0,123455.134,-12345.032);
  float4 var2 = (float4) (2.0,2.0,-1.23,0.0);
  int i = printf("float4_a_3430c===%-+.3v4hla===%-+.3v4hla===\n",var1,var2);
  return i;
}

int float4_a_3431c() {
  // { dg-printf "float4_a_3431c===+0x0.0000000000p+0,+0x1.0000000000p+0,+0x1.0000000000p+0,-0x1.81c8420000p+13===+0x1.e23f220000p+16,+0x1.0000000000p+0,+0x0.0000000000p+0,+0x1.0000000000p+1===" }
  float4 var1 = (float4) (0.0,1.0,1.0,-12345.032);
  float4 var2 = (float4) (123455.134,1.0,0.0,2.0);
  int i = printf("float4_a_3431c===%-+.10v4hla===%-+.10v4hla===\n",var1,var2);
  return i;
}

int float4_a_3432c() {
  // { dg-printf "float4_a_3432c===+0X1.0000000000000P+0,+0X1.E23F220000000P+16,-0X1.3AE1480000000P+0,-0X1.81C8420000000P+13===-0X1.3AE1480000000P+0,-0X1.81C8420000000P+13,+0X0.0000000000000P+0,-0X1.3AE1480000000P+0===" }
  float4 var1 = (float4) (1.0,123455.134,-1.23,-12345.032);
  float4 var2 = (float4) (-1.23,-12345.032,0.0,-1.23);
  int i = printf("float4_a_3432c===%-+v4hlA===%-+v4hlA===\n",var1,var2);
  return i;
}

int float4_a_3433c() {
  // { dg-printf "float4_a_3433c===+0X1.0P+1,+0X0.0P+0,+0X1.EP+16,-0X1.8P+13===+0X1.0P+0,+0X1.EP+16,-0X1.4P+0,+0X1.0P+0===" }
  float4 var1 = (float4) (2.0,0.0,123455.134,-12345.032);
  float4 var2 = (float4) (1.0,123455.134,-1.23,1.0);
  int i = printf("float4_a_3433c===%-+.1v4hlA===%-+.1v4hlA===\n",var1,var2);
  return i;
}

int float4_a_3434c() {
  // { dg-printf "float4_a_3434c===-0X1.3BP+0,+0X1.E2P+16,-0X1.3BP+0,+0X1.E2P+16===-0X1.3BP+0,-0X1.82P+13,+0X0.00P+0,-0X1.3BP+0===" }
  float4 var1 = (float4) (-1.23,123455.134,-1.23,123455.134);
  float4 var2 = (float4) (-1.23,-12345.032,0.0,-1.23);
  int i = printf("float4_a_3434c===%-+.2v4hlA===%-+.2v4hlA===\n",var1,var2);
  return i;
}

int float4_a_3435c() {
  // { dg-printf "float4_a_3435c===+0X1.000P+0,+0X1.E24P+16,-0X1.81CP+13,+0X1.000P+0===-0X1.3AEP+0,+0X1.000P+0,+0X0.000P+0,-0X1.3AEP+0===" }
  float4 var1 = (float4) (1.0,123455.134,-12345.032,1.0);
  float4 var2 = (float4) (-1.23,1.0,0.0,-1.23);
  int i = printf("float4_a_3435c===%-+.3v4hlA===%-+.3v4hlA===\n",var1,var2);
  return i;
}

int float4_a_3436c() {
  // { dg-printf "float4_a_3436c===+0X1.0000000000P+1,+0X1.E23F220000P+16,+0X1.0000000000P+1,+0X1.0000000000P+1===+0X0.0000000000P+0,+0X1.0000000000P+0,+0X1.E23F220000P+16,+0X1.0000000000P+0===" }
  float4 var1 = (float4) (2.0,123455.134,2.0,2.0);
  float4 var2 = (float4) (0.0,1.0,123455.134,1.0);
  int i = printf("float4_a_3436c===%-+.10v4hlA===%-+.10v4hlA===\n",var1,var2);
  return i;
}

int float4_a_387c() {
  // { dg-printf "float4_a_387c===-0x1.81c8420000000p+13,-0x1.3ae1480000000p+0,-0x1.81c8420000000p+13,0x1.0000000000000p+1===0x1.e23f220000000p+16,0x0.0000000000000p+0,0x0.0000000000000p+0,-0x1.81c8420000000p+13===" }
  float4 var1 = (float4) (-12345.032,-1.23,-12345.032,2.0);
  float4 var2 = (float4) (123455.134,0.0,0.0,-12345.032);
  int i = printf("float4_a_387c===%v4hla===%v4hla===\n",var1,var2);
  return i;
}

int float4_a_388c() {
  // { dg-printf "float4_a_388c===0x1.ep+16,0x0.0p+0,0x1.0p+0,0x1.0p+0===0x1.0p+0,-0x1.4p+0,-0x1.4p+0,0x1.ep+16===" }
  float4 var1 = (float4) (123455.134,0.0,1.0,1.0);
  float4 var2 = (float4) (1.0,-1.23,-1.23,123455.134);
  int i = printf("float4_a_388c===%.1v4hla===%.1v4hla===\n",var1,var2);
  return i;
}

int float4_a_389c() {
  // { dg-printf "float4_a_389c===-0x1.82p+13,-0x1.82p+13,0x1.e2p+16,0x0.00p+0===-0x1.82p+13,0x1.00p+0,0x1.e2p+16,-0x1.82p+13===" }
  float4 var1 = (float4) (-12345.032,-12345.032,123455.134,0.0);
  float4 var2 = (float4) (-12345.032,1.0,123455.134,-12345.032);
  int i = printf("float4_a_389c===%.2v4hla===%.2v4hla===\n",var1,var2);
  return i;
}

int float4_a_390c() {
  // { dg-printf "float4_a_390c===-0x1.81cp+13,0x0.000p+0,0x1.e24p+16,-0x1.81cp+13===0x0.000p+0,0x1.e24p+16,0x0.000p+0,0x1.e24p+16===" }
  float4 var1 = (float4) (-12345.032,0.0,123455.134,-12345.032);
  float4 var2 = (float4) (0.0,123455.134,0.0,123455.134);
  int i = printf("float4_a_390c===%.3v4hla===%.3v4hla===\n",var1,var2);
  return i;
}

int float4_a_391c() {
  // { dg-printf "float4_a_391c===-0x1.3ae1480000p+0,0x1.0000000000p+0,-0x1.3ae1480000p+0,0x1.0000000000p+1===0x1.0000000000p+0,0x0.0000000000p+0,0x1.0000000000p+0,0x0.0000000000p+0===" }
  float4 var1 = (float4) (-1.23,1.0,-1.23,2.0);
  float4 var2 = (float4) (1.0,0.0,1.0,0.0);
  int i = printf("float4_a_391c===%.10v4hla===%.10v4hla===\n",var1,var2);
  return i;
}

int float4_a_392c() {
  // { dg-printf "float4_a_392c===-0X1.3AE1480000000P+0,0X1.E23F220000000P+16,0X1.E23F220000000P+16,0X1.E23F220000000P+16===-0X1.81C8420000000P+13,0X1.E23F220000000P+16,-0X1.81C8420000000P+13,-0X1.3AE1480000000P+0===" }
  float4 var1 = (float4) (-1.23,123455.134,123455.134,123455.134);
  float4 var2 = (float4) (-12345.032,123455.134,-12345.032,-1.23);
  int i = printf("float4_a_392c===%v4hlA===%v4hlA===\n",var1,var2);
  return i;
}

int float4_a_393c() {
  // { dg-printf "float4_a_393c===0X1.0P+1,-0X1.4P+0,0X1.0P+1,0X1.0P+0===0X1.0P+0,0X1.0P+0,0X0.0P+0,0X1.0P+0===" }
  float4 var1 = (float4) (2.0,-1.23,2.0,1.0);
  float4 var2 = (float4) (1.0,1.0,0.0,1.0);
  int i = printf("float4_a_393c===%.1v4hlA===%.1v4hlA===\n",var1,var2);
  return i;
}

int float4_a_394c() {
  // { dg-printf "float4_a_394c===-0X1.82P+13,0X0.00P+0,0X1.E2P+16,0X0.00P+0===0X1.E2P+16,-0X1.82P+13,-0X1.3BP+0,-0X1.3BP+0===" }
  float4 var1 = (float4) (-12345.032,0.0,123455.134,0.0);
  float4 var2 = (float4) (123455.134,-12345.032,-1.23,-1.23);
  int i = printf("float4_a_394c===%.2v4hlA===%.2v4hlA===\n",var1,var2);
  return i;
}

int float4_a_395c() {
  // { dg-printf "float4_a_395c===0X1.000P+0,0X1.E24P+16,0X1.000P+1,0X1.000P+0===0X1.E24P+16,0X1.E24P+16,0X0.000P+0,0X0.000P+0===" }
  float4 var1 = (float4) (1.0,123455.134,2.0,1.0);
  float4 var2 = (float4) (123455.134,123455.134,0.0,0.0);
  int i = printf("float4_a_395c===%.3v4hlA===%.3v4hlA===\n",var1,var2);
  return i;
}

int float4_a_396c() {
  // { dg-printf "float4_a_396c===-0X1.3AE1480000P+0,0X0.0000000000P+0,0X1.0000000000P+0,-0X1.3AE1480000P+0===0X1.0000000000P+1,0X1.E23F220000P+16,0X1.0000000000P+0,0X1.E23F220000P+16===" }
  float4 var1 = (float4) (-1.23,0.0,1.0,-1.23);
  float4 var2 = (float4) (2.0,123455.134,1.0,123455.134);
  int i = printf("float4_a_396c===%.10v4hlA===%.10v4hlA===\n",var1,var2);
  return i;
}

int float4_a_4187c() {
  // { dg-printf "float4_a_4187c=== 0x0.0000000000000p+0, 0x1.e23f220000000p+16, 0x0.0000000000000p+0, 0x1.0000000000000p+0=== 0x1.0000000000000p+0, 0x0.0000000000000p+0,-0x1.81c8420000000p+13,-0x1.3ae1480000000p+0===" }
  float4 var1 = (float4) (0.0,123455.134,0.0,1.0);
  float4 var2 = (float4) (1.0,0.0,-12345.032,-1.23);
  int i = printf("float4_a_4187c===% 10v4hla===% 10v4hla===\n",var1,var2);
  return i;
}

int float4_a_4188c() {
  // { dg-printf "float4_a_4188c===  0x0.0p+0,  0x0.0p+0, 0x1.ep+16,  0x0.0p+0=== -0x1.4p+0,  0x1.0p+0, 0x1.ep+16,  0x1.0p+0===" }
  float4 var1 = (float4) (0.0,0.0,123455.134,0.0);
  float4 var2 = (float4) (-1.23,1.0,123455.134,1.0);
  int i = printf("float4_a_4188c===% 10.1v4hla===% 10.1v4hla===\n",var1,var2);
  return i;
}

int float4_a_4189c() {
  // { dg-printf "float4_a_4189c=== 0x1.00p+0,-0x1.82p+13,-0x1.3bp+0, 0x1.00p+1=== 0x1.00p+1,-0x1.82p+13, 0x0.00p+0, 0x0.00p+0===" }
  float4 var1 = (float4) (1.0,-12345.032,-1.23,2.0);
  float4 var2 = (float4) (2.0,-12345.032,0.0,0.0);
  int i = printf("float4_a_4189c===% 10.2v4hla===% 10.2v4hla===\n",var1,var2);
  return i;
}

int float4_a_4190c() {
  // { dg-printf "float4_a_4190c===-0x1.81cp+13,-0x1.81cp+13,-0x1.3aep+0, 0x0.000p+0=== 0x1.e24p+16,-0x1.81cp+13, 0x1.000p+1, 0x1.e24p+16===" }
  float4 var1 = (float4) (-12345.032,-12345.032,-1.23,0.0);
  float4 var2 = (float4) (123455.134,-12345.032,2.0,123455.134);
  int i = printf("float4_a_4190c===% 10.3v4hla===% 10.3v4hla===\n",var1,var2);
  return i;
}

int float4_a_4191c() {
  // { dg-printf "float4_a_4191c=== 0x1.0000000000p+0,-0x1.3ae1480000p+0, 0x0.0000000000p+0, 0x1.0000000000p+1===-0x1.3ae1480000p+0, 0x1.0000000000p+1, 0x1.e23f220000p+16, 0x0.0000000000p+0===" }
  float4 var1 = (float4) (1.0,-1.23,0.0,2.0);
  float4 var2 = (float4) (-1.23,2.0,123455.134,0.0);
  int i = printf("float4_a_4191c===% 10.10v4hla===% 10.10v4hla===\n",var1,var2);
  return i;
}

int float4_a_4192c() {
  // { dg-printf "float4_a_4192c=== 0X1.0000000000000P+0, 0X1.0000000000000P+0,-0X1.81C8420000000P+13, 0X1.E23F220000000P+16=== 0X1.0000000000000P+0, 0X1.0000000000000P+0, 0X0.0000000000000P+0, 0X1.0000000000000P+1===" }
  float4 var1 = (float4) (1.0,1.0,-12345.032,123455.134);
  float4 var2 = (float4) (1.0,1.0,0.0,2.0);
  int i = printf("float4_a_4192c===% 10v4hlA===% 10v4hlA===\n",var1,var2);
  return i;
}

int float4_a_4193c() {
  // { dg-printf "float4_a_4193c=== 0X1.EP+16, -0X1.4P+0,  0X0.0P+0,  0X0.0P+0=== 0X1.EP+16,  0X0.0P+0, 0X1.EP+16,  0X0.0P+0===" }
  float4 var1 = (float4) (123455.134,-1.23,0.0,0.0);
  float4 var2 = (float4) (123455.134,0.0,123455.134,0.0);
  int i = printf("float4_a_4193c===% 10.1v4hlA===% 10.1v4hlA===\n",var1,var2);
  return i;
}

int float4_a_4194c() {
  // { dg-printf "float4_a_4194c=== 0X1.00P+1, 0X0.00P+0, 0X0.00P+0, 0X1.00P+0=== 0X1.00P+0, 0X1.00P+0,-0X1.82P+13, 0X1.00P+1===" }
  float4 var1 = (float4) (2.0,0.0,0.0,1.0);
  float4 var2 = (float4) (1.0,1.0,-12345.032,2.0);
  int i = printf("float4_a_4194c===% 10.2v4hlA===% 10.2v4hlA===\n",var1,var2);
  return i;
}

int float4_a_4195c() {
  // { dg-printf "float4_a_4195c=== 0X0.000P+0, 0X1.E24P+16,-0X1.3AEP+0, 0X1.000P+0=== 0X1.000P+0, 0X1.000P+1, 0X1.000P+1, 0X1.E24P+16===" }
  float4 var1 = (float4) (0.0,123455.134,-1.23,1.0);
  float4 var2 = (float4) (1.0,2.0,2.0,123455.134);
  int i = printf("float4_a_4195c===% 10.3v4hlA===% 10.3v4hlA===\n",var1,var2);
  return i;
}

int float4_a_4196c() {
  // { dg-printf "float4_a_4196c===-0X1.81C8420000P+13, 0X1.0000000000P+0, 0X0.0000000000P+0,-0X1.81C8420000P+13=== 0X1.0000000000P+1, 0X1.0000000000P+1,-0X1.81C8420000P+13,-0X1.3AE1480000P+0===" }
  float4 var1 = (float4) (-12345.032,1.0,0.0,-12345.032);
  float4 var2 = (float4) (2.0,2.0,-12345.032,-1.23);
  int i = printf("float4_a_4196c===% 10.10v4hlA===% 10.10v4hlA===\n",var1,var2);
  return i;
}

int float4_a_4947c() {
  // { dg-printf "float4_a_4947c===0x1.0000000000000p+0,0x1.0000000000000p+0,0x0.0000000000000p+0,0x1.e23f220000000p+16===-0x1.3ae1480000000p+0,0x0.0000000000000p+0,0x0.0000000000000p+0,0x1.e23f220000000p+16===" }
  float4 var1 = (float4) (1.0,1.0,0.0,123455.134);
  float4 var2 = (float4) (-1.23,0.0,0.0,123455.134);
  int i = printf("float4_a_4947c===%010v4hla===%010v4hla===\n",var1,var2);
  return i;
}

int float4_a_4948c() {
  // { dg-printf "float4_a_4948c===0x001.0p+1,0x001.0p+0,-0x1.8p+13,0x001.0p+0===0x001.0p+0,0x01.ep+16,0x01.ep+16,0x01.ep+16===" }
  float4 var1 = (float4) (2.0,1.0,-12345.032,1.0);
  float4 var2 = (float4) (1.0,123455.134,123455.134,123455.134);
  int i = printf("float4_a_4948c===%010.1v4hla===%010.1v4hla===\n",var1,var2);
  return i;
}

int float4_a_4949c() {
  // { dg-printf "float4_a_4949c===0x1.e2p+16,-0x1.82p+13,-0x1.3bp+0,-0x1.82p+13===0x01.00p+1,0x01.00p+0,0x01.00p+0,0x1.e2p+16===" }
  float4 var1 = (float4) (123455.134,-12345.032,-1.23,-12345.032);
  float4 var2 = (float4) (2.0,1.0,1.0,123455.134);
  int i = printf("float4_a_4949c===%010.2v4hla===%010.2v4hla===\n",var1,var2);
  return i;
}

int float4_a_4950c() {
  // { dg-printf "float4_a_4950c===0x1.e24p+16,0x1.000p+1,0x1.000p+1,-0x1.81cp+13===0x0.000p+0,0x1.000p+0,0x1.000p+0,-0x1.81cp+13===" }
  float4 var1 = (float4) (123455.134,2.0,2.0,-12345.032);
  float4 var2 = (float4) (0.0,1.0,1.0,-12345.032);
  int i = printf("float4_a_4950c===%010.3v4hla===%010.3v4hla===\n",var1,var2);
  return i;
}

int float4_a_4951c() {
  // { dg-printf "float4_a_4951c===0x1.e23f220000p+16,0x0.0000000000p+0,0x1.e23f220000p+16,0x0.0000000000p+0===-0x1.81c8420000p+13,-0x1.81c8420000p+13,-0x1.3ae1480000p+0,0x0.0000000000p+0===" }
  float4 var1 = (float4) (123455.134,0.0,123455.134,0.0);
  float4 var2 = (float4) (-12345.032,-12345.032,-1.23,0.0);
  int i = printf("float4_a_4951c===%010.10v4hla===%010.10v4hla===\n",var1,var2);
  return i;
}

int float4_a_4952c() {
  // { dg-printf "float4_a_4952c===-0X1.3AE1480000000P+0,0X1.0000000000000P+0,0X1.0000000000000P+1,0X0.0000000000000P+0===0X1.E23F220000000P+16,0X1.0000000000000P+1,0X1.0000000000000P+1,-0X1.3AE1480000000P+0===" }
  float4 var1 = (float4) (-1.23,1.0,2.0,0.0);
  float4 var2 = (float4) (123455.134,2.0,2.0,-1.23);
  int i = printf("float4_a_4952c===%010v4hlA===%010v4hlA===\n",var1,var2);
  return i;
}

int float4_a_4953c() {
  // { dg-printf "float4_a_4953c===0X001.0P+0,0X01.EP+16,0X000.0P+0,0X001.0P+1===0X01.EP+16,-0X1.8P+13,0X001.0P+1,0X01.EP+16===" }
  float4 var1 = (float4) (1.0,123455.134,0.0,2.0);
  float4 var2 = (float4) (123455.134,-12345.032,2.0,123455.134);
  int i = printf("float4_a_4953c===%010.1v4hlA===%010.1v4hlA===\n",var1,var2);
  return i;
}

int float4_a_4954c() {
  // { dg-printf "float4_a_4954c===0X01.00P+1,-0X1.82P+13,0X1.E2P+16,-0X1.82P+13===0X00.00P+0,0X01.00P+1,0X01.00P+1,0X01.00P+1===" }
  float4 var1 = (float4) (2.0,-12345.032,123455.134,-12345.032);
  float4 var2 = (float4) (0.0,2.0,2.0,2.0);
  int i = printf("float4_a_4954c===%010.2v4hlA===%010.2v4hlA===\n",var1,var2);
  return i;
}

int float4_a_4955c() {
  // { dg-printf "float4_a_4955c===0X1.000P+1,0X1.000P+0,0X1.000P+1,0X1.000P+1===-0X1.81CP+13,0X0.000P+0,0X1.000P+0,0X1.000P+1===" }
  float4 var1 = (float4) (2.0,1.0,2.0,2.0);
  float4 var2 = (float4) (-12345.032,0.0,1.0,2.0);
  int i = printf("float4_a_4955c===%010.3v4hlA===%010.3v4hlA===\n",var1,var2);
  return i;
}

int float4_a_4956c() {
  // { dg-printf "float4_a_4956c===-0X1.81C8420000P+13,0X1.0000000000P+0,0X0.0000000000P+0,0X1.E23F220000P+16===0X0.0000000000P+0,0X1.E23F220000P+16,0X0.0000000000P+0,-0X1.3AE1480000P+0===" }
  float4 var1 = (float4) (-12345.032,1.0,0.0,123455.134);
  float4 var2 = (float4) (0.0,123455.134,0.0,-1.23);
  int i = printf("float4_a_4956c===%010.10v4hlA===%010.10v4hlA===\n",var1,var2);
  return i;
}

int float4_a_5707c() {
  // { dg-printf "float4_a_5707c=== 0x1.0000000000000p+0,-0x1.3ae1480000000p+0, 0x0.0000000000000p+0, 0x1.0000000000000p+1===-0x1.3ae1480000000p+0, 0x1.0000000000000p+0, 0x1.0000000000000p+0, 0x1.0000000000000p+0===" }
  float4 var1 = (float4) (1.0,-1.23,0.0,2.0);
  float4 var2 = (float4) (-1.23,1.0,1.0,1.0);
  int i = printf("float4_a_5707c===%- 10v4hla===%- 10v4hla===\n",var1,var2);
  return i;
}

int float4_a_5708c() {
  // { dg-printf "float4_a_5708c===-0x1.4p+0 , 0x1.ep+16, 0x1.ep+16,-0x1.4p+0 === 0x1.0p+1 , 0x1.0p+0 , 0x1.ep+16, 0x1.ep+16===" }
  float4 var1 = (float4) (-1.23,123455.134,123455.134,-1.23);
  float4 var2 = (float4) (2.0,1.0,123455.134,123455.134);
  int i = printf("float4_a_5708c===%- 10.1v4hla===%- 10.1v4hla===\n",var1,var2);
  return i;
}

int float4_a_5709c() {
  // { dg-printf "float4_a_5709c=== 0x1.00p+1, 0x1.e2p+16, 0x1.00p+1, 0x0.00p+0=== 0x1.00p+1, 0x1.e2p+16, 0x1.00p+0, 0x1.00p+1===" }
  float4 var1 = (float4) (2.0,123455.134,2.0,0.0);
  float4 var2 = (float4) (2.0,123455.134,1.0,2.0);
  int i = printf("float4_a_5709c===%- 10.2v4hla===%- 10.2v4hla===\n",var1,var2);
  return i;
}

int float4_a_5710c() {
  // { dg-printf "float4_a_5710c===-0x1.81cp+13, 0x1.e24p+16, 0x0.000p+0, 0x1.000p+1=== 0x0.000p+0,-0x1.81cp+13, 0x1.000p+1, 0x1.e24p+16===" }
  float4 var1 = (float4) (-12345.032,123455.134,0.0,2.0);
  float4 var2 = (float4) (0.0,-12345.032,2.0,123455.134);
  int i = printf("float4_a_5710c===%- 10.3v4hla===%- 10.3v4hla===\n",var1,var2);
  return i;
}

int float4_a_5711c() {
  // { dg-printf "float4_a_5711c=== 0x1.0000000000p+0,-0x1.3ae1480000p+0,-0x1.81c8420000p+13,-0x1.3ae1480000p+0===-0x1.81c8420000p+13,-0x1.3ae1480000p+0, 0x1.e23f220000p+16,-0x1.3ae1480000p+0===" }
  float4 var1 = (float4) (1.0,-1.23,-12345.032,-1.23);
  float4 var2 = (float4) (-12345.032,-1.23,123455.134,-1.23);
  int i = printf("float4_a_5711c===%- 10.10v4hla===%- 10.10v4hla===\n",var1,var2);
  return i;
}

int float4_a_5712c() {
  // { dg-printf "float4_a_5712c=== 0X0.0000000000000P+0,-0X1.3AE1480000000P+0,-0X1.3AE1480000000P+0, 0X0.0000000000000P+0===-0X1.81C8420000000P+13, 0X1.0000000000000P+1,-0X1.3AE1480000000P+0,-0X1.3AE1480000000P+0===" }
  float4 var1 = (float4) (0.0,-1.23,-1.23,0.0);
  float4 var2 = (float4) (-12345.032,2.0,-1.23,-1.23);
  int i = printf("float4_a_5712c===%- 10v4hlA===%- 10v4hlA===\n",var1,var2);
  return i;
}

int float4_a_5713c() {
  // { dg-printf "float4_a_5713c===-0X1.8P+13, 0X1.0P+0 , 0X1.0P+0 , 0X1.0P+1 === 0X0.0P+0 , 0X1.EP+16, 0X1.0P+0 , 0X1.EP+16===" }
  float4 var1 = (float4) (-12345.032,1.0,1.0,2.0);
  float4 var2 = (float4) (0.0,123455.134,1.0,123455.134);
  int i = printf("float4_a_5713c===%- 10.1v4hlA===%- 10.1v4hlA===\n",var1,var2);
  return i;
}

int float4_a_5714c() {
  // { dg-printf "float4_a_5714c=== 0X1.00P+0,-0X1.3BP+0,-0X1.3BP+0, 0X0.00P+0===-0X1.82P+13, 0X1.E2P+16,-0X1.3BP+0, 0X1.00P+1===" }
  float4 var1 = (float4) (1.0,-1.23,-1.23,0.0);
  float4 var2 = (float4) (-12345.032,123455.134,-1.23,2.0);
  int i = printf("float4_a_5714c===%- 10.2v4hlA===%- 10.2v4hlA===\n",var1,var2);
  return i;
}

int float4_a_5715c() {
  // { dg-printf "float4_a_5715c=== 0X0.000P+0, 0X1.000P+1, 0X1.000P+1, 0X1.E24P+16=== 0X1.000P+0, 0X1.000P+1,-0X1.3AEP+0, 0X1.E24P+16===" }
  float4 var1 = (float4) (0.0,2.0,2.0,123455.134);
  float4 var2 = (float4) (1.0,2.0,-1.23,123455.134);
  int i = printf("float4_a_5715c===%- 10.3v4hlA===%- 10.3v4hlA===\n",var1,var2);
  return i;
}

int float4_a_5716c() {
  // { dg-printf "float4_a_5716c=== 0X1.E23F220000P+16,-0X1.81C8420000P+13, 0X1.0000000000P+1, 0X1.0000000000P+1===-0X1.3AE1480000P+0, 0X1.0000000000P+1,-0X1.81C8420000P+13, 0X1.0000000000P+1===" }
  float4 var1 = (float4) (123455.134,-12345.032,2.0,2.0);
  float4 var2 = (float4) (-1.23,2.0,-12345.032,2.0);
  int i = printf("float4_a_5716c===%- 10.10v4hlA===%- 10.10v4hlA===\n",var1,var2);
  return i;
}

int float4_a_6467c() {
  // { dg-printf "float4_a_6467c===+0x1.0000000000000p+1,+0x1.0000000000000p+0,-0x1.81c8420000000p+13,-0x1.3ae1480000000p+0===+0x1.e23f220000000p+16,-0x1.3ae1480000000p+0,-0x1.3ae1480000000p+0,-0x1.81c8420000000p+13===" }
  float4 var1 = (float4) (2.0,1.0,-12345.032,-1.23);
  float4 var2 = (float4) (123455.134,-1.23,-1.23,-12345.032);
  int i = printf("float4_a_6467c===%+ 10v4hla===%+ 10v4hla===\n",var1,var2);
  return i;
}

int float4_a_6468c() {
  // { dg-printf "float4_a_6468c===+0x1.ep+16, -0x1.4p+0, -0x1.4p+0,+0x1.ep+16=== +0x1.0p+1,+0x1.ep+16, +0x1.0p+1, +0x0.0p+0===" }
  float4 var1 = (float4) (123455.134,-1.23,-1.23,123455.134);
  float4 var2 = (float4) (2.0,123455.134,2.0,0.0);
  int i = printf("float4_a_6468c===%+ 10.1v4hla===%+ 10.1v4hla===\n",var1,var2);
  return i;
}

int float4_a_6469c() {
  // { dg-printf "float4_a_6469c===+0x1.00p+0,-0x1.82p+13,+0x1.e2p+16,-0x1.82p+13===-0x1.82p+13,+0x1.00p+1,+0x1.e2p+16,+0x0.00p+0===" }
  float4 var1 = (float4) (1.0,-12345.032,123455.134,-12345.032);
  float4 var2 = (float4) (-12345.032,2.0,123455.134,0.0);
  int i = printf("float4_a_6469c===%+ 10.2v4hla===%+ 10.2v4hla===\n",var1,var2);
  return i;
}

int float4_a_6470c() {
  // { dg-printf "float4_a_6470c===+0x0.000p+0,+0x1.000p+0,+0x0.000p+0,-0x1.3aep+0===+0x1.000p+0,+0x0.000p+0,+0x1.000p+0,+0x0.000p+0===" }
  float4 var1 = (float4) (0.0,1.0,0.0,-1.23);
  float4 var2 = (float4) (1.0,0.0,1.0,0.0);
  int i = printf("float4_a_6470c===%+ 10.3v4hla===%+ 10.3v4hla===\n",var1,var2);
  return i;
}

int float4_a_6471c() {
  // { dg-printf "float4_a_6471c===+0x1.e23f220000p+16,+0x1.e23f220000p+16,+0x1.e23f220000p+16,-0x1.81c8420000p+13===+0x1.e23f220000p+16,+0x1.0000000000p+0,+0x1.e23f220000p+16,+0x1.0000000000p+1===" }
  float4 var1 = (float4) (123455.134,123455.134,123455.134,-12345.032);
  float4 var2 = (float4) (123455.134,1.0,123455.134,2.0);
  int i = printf("float4_a_6471c===%+ 10.10v4hla===%+ 10.10v4hla===\n",var1,var2);
  return i;
}

int float4_a_6472c() {
  // { dg-printf "float4_a_6472c===+0X0.0000000000000P+0,-0X1.3AE1480000000P+0,-0X1.3AE1480000000P+0,-0X1.81C8420000000P+13===+0X1.0000000000000P+0,+0X1.E23F220000000P+16,-0X1.81C8420000000P+13,+0X0.0000000000000P+0===" }
  float4 var1 = (float4) (0.0,-1.23,-1.23,-12345.032);
  float4 var2 = (float4) (1.0,123455.134,-12345.032,0.0);
  int i = printf("float4_a_6472c===%+ 10v4hlA===%+ 10v4hlA===\n",var1,var2);
  return i;
}

int float4_a_6473c() {
  // { dg-printf "float4_a_6473c=== -0X1.4P+0,-0X1.8P+13, -0X1.4P+0, +0X1.0P+1===+0X1.EP+16, +0X0.0P+0, -0X1.4P+0, +0X1.0P+1===" }
  float4 var1 = (float4) (-1.23,-12345.032,-1.23,2.0);
  float4 var2 = (float4) (123455.134,0.0,-1.23,2.0);
  int i = printf("float4_a_6473c===%+ 10.1v4hlA===%+ 10.1v4hlA===\n",var1,var2);
  return i;
}

int float4_a_6474c() {
  // { dg-printf "float4_a_6474c===+0X0.00P+0,+0X1.00P+0,-0X1.3BP+0,-0X1.3BP+0===+0X1.00P+1,+0X1.00P+1,+0X1.00P+0,+0X0.00P+0===" }
  float4 var1 = (float4) (0.0,1.0,-1.23,-1.23);
  float4 var2 = (float4) (2.0,2.0,1.0,0.0);
  int i = printf("float4_a_6474c===%+ 10.2v4hlA===%+ 10.2v4hlA===\n",var1,var2);
  return i;
}

int float4_a_6475c() {
  // { dg-printf "float4_a_6475c===-0X1.81CP+13,+0X1.E24P+16,-0X1.3AEP+0,-0X1.3AEP+0===+0X1.000P+0,+0X1.000P+1,+0X1.000P+1,+0X0.000P+0===" }
  float4 var1 = (float4) (-12345.032,123455.134,-1.23,-1.23);
  float4 var2 = (float4) (1.0,2.0,2.0,0.0);
  int i = printf("float4_a_6475c===%+ 10.3v4hlA===%+ 10.3v4hlA===\n",var1,var2);
  return i;
}

int float4_a_6476c() {
  // { dg-printf "float4_a_6476c===+0X1.0000000000P+1,-0X1.81C8420000P+13,+0X1.0000000000P+0,-0X1.3AE1480000P+0===-0X1.3AE1480000P+0,+0X0.0000000000P+0,+0X1.0000000000P+0,-0X1.3AE1480000P+0===" }
  float4 var1 = (float4) (2.0,-12345.032,1.0,-1.23);
  float4 var2 = (float4) (-1.23,0.0,1.0,-1.23);
  int i = printf("float4_a_6476c===%+ 10.10v4hlA===%+ 10.10v4hlA===\n",var1,var2);
  return i;
}

int float4_a_7227c() {
  // { dg-printf "float4_a_7227c===-0x1.81c8420000000p+13,+0x1.e23f220000000p+16,-0x1.81c8420000000p+13,+0x0.0000000000000p+0===+0x1.e23f220000000p+16,+0x1.e23f220000000p+16,-0x1.81c8420000000p+13,+0x1.0000000000000p+1===" }
  float4 var1 = (float4) (-12345.032,123455.134,-12345.032,0.0);
  float4 var2 = (float4) (123455.134,123455.134,-12345.032,2.0);
  int i = printf("float4_a_7227c===%+010v4hla===%+010v4hla===\n",var1,var2);
  return i;
}

int float4_a_7228c() {
  // { dg-printf "float4_a_7228c===-0x01.4p+0,-0x01.4p+0,-0x01.4p+0,+0x1.ep+16===+0x01.0p+0,-0x01.4p+0,+0x00.0p+0,-0x1.8p+13===" }
  float4 var1 = (float4) (-1.23,-1.23,-1.23,123455.134);
  float4 var2 = (float4) (1.0,-1.23,0.0,-12345.032);
  int i = printf("float4_a_7228c===%+010.1v4hla===%+010.1v4hla===\n",var1,var2);
  return i;
}

int float4_a_7229c() {
  // { dg-printf "float4_a_7229c===-0x1.3bp+0,+0x1.e2p+16,-0x1.3bp+0,-0x1.3bp+0===-0x1.82p+13,-0x1.3bp+0,+0x1.e2p+16,+0x1.e2p+16===" }
  float4 var1 = (float4) (-1.23,123455.134,-1.23,-1.23);
  float4 var2 = (float4) (-12345.032,-1.23,123455.134,123455.134);
  int i = printf("float4_a_7229c===%+010.2v4hla===%+010.2v4hla===\n",var1,var2);
  return i;
}

int float4_a_7230c() {
  // { dg-printf "float4_a_7230c===+0x1.000p+1,-0x1.81cp+13,+0x0.000p+0,-0x1.81cp+13===+0x1.000p+0,+0x1.000p+0,+0x0.000p+0,+0x1.000p+0===" }
  float4 var1 = (float4) (2.0,-12345.032,0.0,-12345.032);
  float4 var2 = (float4) (1.0,1.0,0.0,1.0);
  int i = printf("float4_a_7230c===%+010.3v4hla===%+010.3v4hla===\n",var1,var2);
  return i;
}

int float4_a_7231c() {
  // { dg-printf "float4_a_7231c===+0x1.e23f220000p+16,+0x1.e23f220000p+16,+0x1.0000000000p+1,-0x1.3ae1480000p+0===+0x0.0000000000p+0,-0x1.3ae1480000p+0,+0x1.0000000000p+0,+0x1.0000000000p+1===" }
  float4 var1 = (float4) (123455.134,123455.134,2.0,-1.23);
  float4 var2 = (float4) (0.0,-1.23,1.0,2.0);
  int i = printf("float4_a_7231c===%+010.10v4hla===%+010.10v4hla===\n",var1,var2);
  return i;
}

int float4_a_7232c() {
  // { dg-printf "float4_a_7232c===+0X1.E23F220000000P+16,+0X1.E23F220000000P+16,-0X1.81C8420000000P+13,+0X1.0000000000000P+0===+0X0.0000000000000P+0,+0X0.0000000000000P+0,+0X1.0000000000000P+1,-0X1.3AE1480000000P+0===" }
  float4 var1 = (float4) (123455.134,123455.134,-12345.032,1.0);
  float4 var2 = (float4) (0.0,0.0,2.0,-1.23);
  int i = printf("float4_a_7232c===%+010v4hlA===%+010v4hlA===\n",var1,var2);
  return i;
}

int float4_a_7233c() {
  // { dg-printf "float4_a_7233c===-0X01.4P+0,-0X01.4P+0,+0X01.0P+1,+0X01.0P+0===-0X01.4P+0,+0X1.EP+16,+0X01.0P+0,+0X1.EP+16===" }
  float4 var1 = (float4) (-1.23,-1.23,2.0,1.0);
  float4 var2 = (float4) (-1.23,123455.134,1.0,123455.134);
  int i = printf("float4_a_7233c===%+010.1v4hlA===%+010.1v4hlA===\n",var1,var2);
  return i;
}

int float4_a_7234c() {
  // { dg-printf "float4_a_7234c===+0X1.00P+0,-0X1.3BP+0,+0X0.00P+0,+0X0.00P+0===+0X1.E2P+16,-0X1.3BP+0,+0X1.00P+1,+0X0.00P+0===" }
  float4 var1 = (float4) (1.0,-1.23,0.0,0.0);
  float4 var2 = (float4) (123455.134,-1.23,2.0,0.0);
  int i = printf("float4_a_7234c===%+010.2v4hlA===%+010.2v4hlA===\n",var1,var2);
  return i;
}

int float4_a_7235c() {
  // { dg-printf "float4_a_7235c===+0X1.000P+1,+0X1.E24P+16,+0X1.000P+0,+0X1.000P+0===-0X1.3AEP+0,-0X1.81CP+13,+0X1.000P+0,+0X0.000P+0===" }
  float4 var1 = (float4) (2.0,123455.134,1.0,1.0);
  float4 var2 = (float4) (-1.23,-12345.032,1.0,0.0);
  int i = printf("float4_a_7235c===%+010.3v4hlA===%+010.3v4hlA===\n",var1,var2);
  return i;
}

int float4_a_7236c() {
  // { dg-printf "float4_a_7236c===+0X0.0000000000P+0,-0X1.3AE1480000P+0,+0X1.0000000000P+0,-0X1.81C8420000P+13===+0X1.0000000000P+0,+0X1.E23F220000P+16,+0X1.E23F220000P+16,+0X1.0000000000P+0===" }
  float4 var1 = (float4) (0.0,-1.23,1.0,-12345.032);
  float4 var2 = (float4) (1.0,123455.134,123455.134,1.0);
  int i = printf("float4_a_7236c===%+010.10v4hlA===%+010.10v4hlA===\n",var1,var2);
  return i;
}

int float4_e_1157c() {

  float4 var1 = (float4) (123455.134,-1.23,1.0,123455.134);
  float4 var2 = (float4) (-12345.032,2.0,123455.134,1.0);
  int i = printf("float4_e_1157c===%-v4hle===%-v4hle===\n",var1,var2);
  return i;
}

int float4_e_1158c() {

  float4 var1 = (float4) (-12345.032,1.0,2.0,2.0);
  float4 var2 = (float4) (-12345.032,123455.134,123455.134,-1.23);
  int i = printf("float4_e_1158c===%-.1v4hle===%-.1v4hle===\n",var1,var2);
  return i;
}

int float4_e_1159c() {

  float4 var1 = (float4) (-12345.032,-1.23,2.0,1.0);
  float4 var2 = (float4) (-1.23,1.0,-1.23,-1.23);
  int i = printf("float4_e_1159c===%-.2v4hle===%-.2v4hle===\n",var1,var2);
  return i;
}

int float4_e_1160c() {

  float4 var1 = (float4) (123455.134,123455.134,-12345.032,0.0);
  float4 var2 = (float4) (-1.23,-12345.032,1.0,123455.134);
  int i = printf("float4_e_1160c===%-.3v4hle===%-.3v4hle===\n",var1,var2);
  return i;
}

int float4_e_1161c() {

  float4 var1 = (float4) (123455.134,123455.134,2.0,-1.23);
  float4 var2 = (float4) (-1.23,123455.134,1.0,-12345.032);
  int i = printf("float4_e_1161c===%-.10v4hle===%-.10v4hle===\n",var1,var2);
  return i;
}

int float4_e_1162c() {

  float4 var1 = (float4) (1.0,-12345.032,2.0,123455.134);
  float4 var2 = (float4) (2.0,2.0,0.0,0.0);
  int i = printf("float4_e_1162c===%-v4hlE===%-v4hlE===\n",var1,var2);
  return i;
}

int float4_e_1163c() {

  float4 var1 = (float4) (-12345.032,0.0,2.0,1.0);
  float4 var2 = (float4) (0.0,123455.134,2.0,0.0);
  int i = printf("float4_e_1163c===%-.1v4hlE===%-.1v4hlE===\n",var1,var2);
  return i;
}

int float4_e_1164c() {

  float4 var1 = (float4) (-12345.032,0.0,0.0,1.0);
  float4 var2 = (float4) (-1.23,123455.134,-1.23,1.0);
  int i = printf("float4_e_1164c===%-.2v4hlE===%-.2v4hlE===\n",var1,var2);
  return i;
}

int float4_e_1165c() {

  float4 var1 = (float4) (0.0,123455.134,-12345.032,-1.23);
  float4 var2 = (float4) (-12345.032,2.0,1.0,2.0);
  int i = printf("float4_e_1165c===%-.3v4hlE===%-.3v4hlE===\n",var1,var2);
  return i;
}

int float4_e_1166c() {

  float4 var1 = (float4) (123455.134,-12345.032,-12345.032,1.0);
  float4 var2 = (float4) (2.0,123455.134,2.0,123455.134);
  int i = printf("float4_e_1166c===%-.10v4hlE===%-.10v4hlE===\n",var1,var2);
  return i;
}

int float4_e_1917c() {

  float4 var1 = (float4) (0.0,2.0,123455.134,2.0);
  float4 var2 = (float4) (-12345.032,123455.134,-1.23,1.0);
  int i = printf("float4_e_1917c===%+v4hle===%+v4hle===\n",var1,var2);
  return i;
}

int float4_e_1918c() {

  float4 var1 = (float4) (1.0,2.0,-12345.032,1.0);
  float4 var2 = (float4) (1.0,123455.134,123455.134,2.0);
  int i = printf("float4_e_1918c===%+.1v4hle===%+.1v4hle===\n",var1,var2);
  return i;
}

int float4_e_1919c() {

  float4 var1 = (float4) (123455.134,0.0,-1.23,2.0);
  float4 var2 = (float4) (-1.23,0.0,1.0,123455.134);
  int i = printf("float4_e_1919c===%+.2v4hle===%+.2v4hle===\n",var1,var2);
  return i;
}

int float4_e_1920c() {

  float4 var1 = (float4) (1.0,-12345.032,123455.134,-1.23);
  float4 var2 = (float4) (-1.23,2.0,-1.23,123455.134);
  int i = printf("float4_e_1920c===%+.3v4hle===%+.3v4hle===\n",var1,var2);
  return i;
}

int float4_e_1921c() {

  float4 var1 = (float4) (-12345.032,-12345.032,0.0,2.0);
  float4 var2 = (float4) (-12345.032,0.0,-12345.032,0.0);
  int i = printf("float4_e_1921c===%+.10v4hle===%+.10v4hle===\n",var1,var2);
  return i;
}

int float4_e_1922c() {

  float4 var1 = (float4) (123455.134,2.0,1.0,-12345.032);
  float4 var2 = (float4) (2.0,123455.134,-1.23,1.0);
  int i = printf("float4_e_1922c===%+v4hlE===%+v4hlE===\n",var1,var2);
  return i;
}

int float4_e_1923c() {

  float4 var1 = (float4) (123455.134,1.0,1.0,1.0);
  float4 var2 = (float4) (-12345.032,1.0,123455.134,-12345.032);
  int i = printf("float4_e_1923c===%+.1v4hlE===%+.1v4hlE===\n",var1,var2);
  return i;
}

int float4_e_1924c() {

  float4 var1 = (float4) (1.0,-1.23,1.0,-12345.032);
  float4 var2 = (float4) (1.0,2.0,-12345.032,0.0);
  int i = printf("float4_e_1924c===%+.2v4hlE===%+.2v4hlE===\n",var1,var2);
  return i;
}

int float4_e_1925c() {

  float4 var1 = (float4) (0.0,0.0,-12345.032,123455.134);
  float4 var2 = (float4) (-1.23,1.0,0.0,0.0);
  int i = printf("float4_e_1925c===%+.3v4hlE===%+.3v4hlE===\n",var1,var2);
  return i;
}

int float4_e_1926c() {

  float4 var1 = (float4) (-12345.032,1.0,-1.23,-12345.032);
  float4 var2 = (float4) (-1.23,1.0,0.0,0.0);
  int i = printf("float4_e_1926c===%+.10v4hlE===%+.10v4hlE===\n",var1,var2);
  return i;
}

int float4_e_2677c() {

  float4 var1 = (float4) (0.0,2.0,2.0,0.0);
  float4 var2 = (float4) (1.0,-1.23,-1.23,2.0);
  int i = printf("float4_e_2677c===%#v4hle===%#v4hle===\n",var1,var2);
  return i;
}

int float4_e_2678c() {

  float4 var1 = (float4) (0.0,123455.134,0.0,-12345.032);
  float4 var2 = (float4) (1.0,-12345.032,123455.134,123455.134);
  int i = printf("float4_e_2678c===%#.1v4hle===%#.1v4hle===\n",var1,var2);
  return i;
}

int float4_e_2679c() {

  float4 var1 = (float4) (-12345.032,-1.23,-12345.032,-1.23);
  float4 var2 = (float4) (1.0,123455.134,0.0,2.0);
  int i = printf("float4_e_2679c===%#.2v4hle===%#.2v4hle===\n",var1,var2);
  return i;
}

int float4_e_2680c() {

  float4 var1 = (float4) (123455.134,2.0,-1.23,123455.134);
  float4 var2 = (float4) (123455.134,123455.134,-12345.032,2.0);
  int i = printf("float4_e_2680c===%#.3v4hle===%#.3v4hle===\n",var1,var2);
  return i;
}

int float4_e_2681c() {

  float4 var1 = (float4) (1.0,1.0,123455.134,0.0);
  float4 var2 = (float4) (0.0,-12345.032,2.0,123455.134);
  int i = printf("float4_e_2681c===%#.10v4hle===%#.10v4hle===\n",var1,var2);
  return i;
}

int float4_e_2682c() {

  float4 var1 = (float4) (2.0,1.0,-1.23,-1.23);
  float4 var2 = (float4) (0.0,123455.134,0.0,-12345.032);
  int i = printf("float4_e_2682c===%#v4hlE===%#v4hlE===\n",var1,var2);
  return i;
}

int float4_e_2683c() {

  float4 var1 = (float4) (-1.23,0.0,-1.23,0.0);
  float4 var2 = (float4) (2.0,2.0,1.0,123455.134);
  int i = printf("float4_e_2683c===%#.1v4hlE===%#.1v4hlE===\n",var1,var2);
  return i;
}

int float4_e_2684c() {

  float4 var1 = (float4) (1.0,0.0,-12345.032,2.0);
  float4 var2 = (float4) (-1.23,1.0,2.0,2.0);
  int i = printf("float4_e_2684c===%#.2v4hlE===%#.2v4hlE===\n",var1,var2);
  return i;
}

int float4_e_2685c() {

  float4 var1 = (float4) (123455.134,123455.134,-1.23,-12345.032);
  float4 var2 = (float4) (123455.134,1.0,0.0,0.0);
  int i = printf("float4_e_2685c===%#.3v4hlE===%#.3v4hlE===\n",var1,var2);
  return i;
}

int float4_e_2686c() {

  float4 var1 = (float4) (-1.23,1.0,123455.134,1.0);
  float4 var2 = (float4) (0.0,-12345.032,1.0,0.0);
  int i = printf("float4_e_2686c===%#.10v4hlE===%#.10v4hlE===\n",var1,var2);
  return i;
}

int float4_e_3437c() {

  float4 var1 = (float4) (-1.23,0.0,1.0,1.0);
  float4 var2 = (float4) (1.0,123455.134,2.0,0.0);
  int i = printf("float4_e_3437c===%-+v4hle===%-+v4hle===\n",var1,var2);
  return i;
}

int float4_e_3438c() {

  float4 var1 = (float4) (-12345.032,2.0,1.0,-1.23);
  float4 var2 = (float4) (0.0,123455.134,0.0,0.0);
  int i = printf("float4_e_3438c===%-+.1v4hle===%-+.1v4hle===\n",var1,var2);
  return i;
}

int float4_e_3439c() {

  float4 var1 = (float4) (123455.134,2.0,0.0,1.0);
  float4 var2 = (float4) (2.0,1.0,123455.134,-12345.032);
  int i = printf("float4_e_3439c===%-+.2v4hle===%-+.2v4hle===\n",var1,var2);
  return i;
}

int float4_e_3440c() {

  float4 var1 = (float4) (1.0,-12345.032,123455.134,1.0);
  float4 var2 = (float4) (2.0,0.0,2.0,0.0);
  int i = printf("float4_e_3440c===%-+.3v4hle===%-+.3v4hle===\n",var1,var2);
  return i;
}

int float4_e_3441c() {

  float4 var1 = (float4) (-1.23,-1.23,123455.134,123455.134);
  float4 var2 = (float4) (2.0,123455.134,-12345.032,-1.23);
  int i = printf("float4_e_3441c===%-+.10v4hle===%-+.10v4hle===\n",var1,var2);
  return i;
}

int float4_e_3442c() {

  float4 var1 = (float4) (-1.23,2.0,2.0,1.0);
  float4 var2 = (float4) (0.0,-12345.032,2.0,-1.23);
  int i = printf("float4_e_3442c===%-+v4hlE===%-+v4hlE===\n",var1,var2);
  return i;
}

int float4_e_3443c() {

  float4 var1 = (float4) (2.0,123455.134,0.0,-1.23);
  float4 var2 = (float4) (1.0,0.0,2.0,-1.23);
  int i = printf("float4_e_3443c===%-+.1v4hlE===%-+.1v4hlE===\n",var1,var2);
  return i;
}

int float4_e_3444c() {

  float4 var1 = (float4) (2.0,2.0,123455.134,2.0);
  float4 var2 = (float4) (1.0,2.0,-1.23,0.0);
  int i = printf("float4_e_3444c===%-+.2v4hlE===%-+.2v4hlE===\n",var1,var2);
  return i;
}

int float4_e_3445c() {

  float4 var1 = (float4) (2.0,2.0,0.0,2.0);
  float4 var2 = (float4) (1.0,0.0,2.0,-12345.032);
  int i = printf("float4_e_3445c===%-+.3v4hlE===%-+.3v4hlE===\n",var1,var2);
  return i;
}

int float4_e_3446c() {

  float4 var1 = (float4) (2.0,0.0,0.0,2.0);
  float4 var2 = (float4) (1.0,-12345.032,2.0,2.0);
  int i = printf("float4_e_3446c===%-+.10v4hlE===%-+.10v4hlE===\n",var1,var2);
  return i;
}

int float4_e_397c() {

  float4 var1 = (float4) (1.0,-12345.032,-12345.032,2.0);
  float4 var2 = (float4) (-12345.032,0.0,2.0,-1.23);
  int i = printf("float4_e_397c===%v4hle===%v4hle===\n",var1,var2);
  return i;
}

int float4_e_398c() {

  float4 var1 = (float4) (1.0,2.0,-1.23,1.0);
  float4 var2 = (float4) (-1.23,2.0,123455.134,-12345.032);
  int i = printf("float4_e_398c===%.1v4hle===%.1v4hle===\n",var1,var2);
  return i;
}

int float4_e_399c() {

  float4 var1 = (float4) (1.0,123455.134,123455.134,-1.23);
  float4 var2 = (float4) (1.0,2.0,0.0,123455.134);
  int i = printf("float4_e_399c===%.2v4hle===%.2v4hle===\n",var1,var2);
  return i;
}

int float4_e_400c() {

  float4 var1 = (float4) (1.0,-1.23,-12345.032,-12345.032);
  float4 var2 = (float4) (123455.134,123455.134,-12345.032,2.0);
  int i = printf("float4_e_400c===%.3v4hle===%.3v4hle===\n",var1,var2);
  return i;
}

int float4_e_401c() {

  float4 var1 = (float4) (-1.23,2.0,123455.134,0.0);
  float4 var2 = (float4) (0.0,-1.23,1.0,1.0);
  int i = printf("float4_e_401c===%.10v4hle===%.10v4hle===\n",var1,var2);
  return i;
}

int float4_e_402c() {

  float4 var1 = (float4) (1.0,2.0,-12345.032,-1.23);
  float4 var2 = (float4) (-12345.032,-1.23,0.0,2.0);
  int i = printf("float4_e_402c===%v4hlE===%v4hlE===\n",var1,var2);
  return i;
}

int float4_e_403c() {

  float4 var1 = (float4) (-1.23,0.0,-1.23,123455.134);
  float4 var2 = (float4) (2.0,-1.23,-12345.032,2.0);
  int i = printf("float4_e_403c===%.1v4hlE===%.1v4hlE===\n",var1,var2);
  return i;
}

int float4_e_404c() {

  float4 var1 = (float4) (-1.23,123455.134,1.0,0.0);
  float4 var2 = (float4) (-12345.032,2.0,123455.134,2.0);
  int i = printf("float4_e_404c===%.2v4hlE===%.2v4hlE===\n",var1,var2);
  return i;
}

int float4_e_405c() {

  float4 var1 = (float4) (0.0,2.0,123455.134,123455.134);
  float4 var2 = (float4) (2.0,0.0,123455.134,-12345.032);
  int i = printf("float4_e_405c===%.3v4hlE===%.3v4hlE===\n",var1,var2);
  return i;
}

int float4_e_406c() {

  float4 var1 = (float4) (-12345.032,123455.134,-12345.032,-1.23);
  float4 var2 = (float4) (0.0,-1.23,2.0,-1.23);
  int i = printf("float4_e_406c===%.10v4hlE===%.10v4hlE===\n",var1,var2);
  return i;
}

int float4_e_4197c() {

  float4 var1 = (float4) (-12345.032,2.0,-12345.032,123455.134);
  float4 var2 = (float4) (123455.134,-1.23,-1.23,1.0);
  int i = printf("float4_e_4197c===% 10v4hle===% 10v4hle===\n",var1,var2);
  return i;
}

int float4_e_4198c() {

  float4 var1 = (float4) (-1.23,123455.134,-12345.032,2.0);
  float4 var2 = (float4) (-1.23,2.0,1.0,-12345.032);
  int i = printf("float4_e_4198c===% 10.1v4hle===% 10.1v4hle===\n",var1,var2);
  return i;
}

int float4_e_4199c() {

  float4 var1 = (float4) (-1.23,-1.23,0.0,2.0);
  float4 var2 = (float4) (2.0,1.0,123455.134,-1.23);
  int i = printf("float4_e_4199c===% 10.2v4hle===% 10.2v4hle===\n",var1,var2);
  return i;
}

int float4_e_4200c() {

  float4 var1 = (float4) (1.0,0.0,-1.23,2.0);
  float4 var2 = (float4) (2.0,2.0,2.0,1.0);
  int i = printf("float4_e_4200c===% 10.3v4hle===% 10.3v4hle===\n",var1,var2);
  return i;
}

int float4_e_4201c() {

  float4 var1 = (float4) (1.0,0.0,123455.134,-12345.032);
  float4 var2 = (float4) (-1.23,-1.23,-1.23,-1.23);
  int i = printf("float4_e_4201c===% 10.10v4hle===% 10.10v4hle===\n",var1,var2);
  return i;
}

int float4_e_4202c() {

  float4 var1 = (float4) (-12345.032,0.0,-12345.032,1.0);
  float4 var2 = (float4) (0.0,1.0,2.0,1.0);
  int i = printf("float4_e_4202c===% 10v4hlE===% 10v4hlE===\n",var1,var2);
  return i;
}

int float4_e_4203c() {

  float4 var1 = (float4) (2.0,0.0,0.0,0.0);
  float4 var2 = (float4) (0.0,123455.134,0.0,-1.23);
  int i = printf("float4_e_4203c===% 10.1v4hlE===% 10.1v4hlE===\n",var1,var2);
  return i;
}

int float4_e_4204c() {

  float4 var1 = (float4) (1.0,0.0,0.0,-12345.032);
  float4 var2 = (float4) (-1.23,2.0,-1.23,0.0);
  int i = printf("float4_e_4204c===% 10.2v4hlE===% 10.2v4hlE===\n",var1,var2);
  return i;
}

int float4_e_4205c() {

  float4 var1 = (float4) (-12345.032,-12345.032,-1.23,-1.23);
  float4 var2 = (float4) (2.0,123455.134,123455.134,1.0);
  int i = printf("float4_e_4205c===% 10.3v4hlE===% 10.3v4hlE===\n",var1,var2);
  return i;
}

int float4_e_4206c() {

  float4 var1 = (float4) (-12345.032,-12345.032,2.0,0.0);
  float4 var2 = (float4) (1.0,2.0,-12345.032,0.0);
  int i = printf("float4_e_4206c===% 10.10v4hlE===% 10.10v4hlE===\n",var1,var2);
  return i;
}

int float4_e_4957c() {

  float4 var1 = (float4) (123455.134,0.0,0.0,1.0);
  float4 var2 = (float4) (0.0,2.0,123455.134,123455.134);
  int i = printf("float4_e_4957c===%010v4hle===%010v4hle===\n",var1,var2);
  return i;
}

int float4_e_4958c() {

  float4 var1 = (float4) (2.0,1.0,-1.23,123455.134);
  float4 var2 = (float4) (123455.134,-12345.032,1.0,-1.23);
  int i = printf("float4_e_4958c===%010.1v4hle===%010.1v4hle===\n",var1,var2);
  return i;
}

int float4_e_4959c() {

  float4 var1 = (float4) (-12345.032,2.0,0.0,-1.23);
  float4 var2 = (float4) (123455.134,-1.23,1.0,-1.23);
  int i = printf("float4_e_4959c===%010.2v4hle===%010.2v4hle===\n",var1,var2);
  return i;
}

int float4_e_4960c() {

  float4 var1 = (float4) (123455.134,-1.23,-1.23,1.0);
  float4 var2 = (float4) (-12345.032,1.0,0.0,123455.134);
  int i = printf("float4_e_4960c===%010.3v4hle===%010.3v4hle===\n",var1,var2);
  return i;
}

int float4_e_4961c() {

  float4 var1 = (float4) (123455.134,1.0,-1.23,2.0);
  float4 var2 = (float4) (123455.134,-12345.032,1.0,0.0);
  int i = printf("float4_e_4961c===%010.10v4hle===%010.10v4hle===\n",var1,var2);
  return i;
}

int float4_e_4962c() {

  float4 var1 = (float4) (-12345.032,1.0,2.0,-12345.032);
  float4 var2 = (float4) (123455.134,0.0,2.0,2.0);
  int i = printf("float4_e_4962c===%010v4hlE===%010v4hlE===\n",var1,var2);
  return i;
}

int float4_e_4963c() {

  float4 var1 = (float4) (-12345.032,0.0,1.0,2.0);
  float4 var2 = (float4) (-1.23,-1.23,123455.134,1.0);
  int i = printf("float4_e_4963c===%010.1v4hlE===%010.1v4hlE===\n",var1,var2);
  return i;
}

int float4_e_4964c() {

  float4 var1 = (float4) (123455.134,-1.23,-12345.032,1.0);
  float4 var2 = (float4) (1.0,1.0,0.0,2.0);
  int i = printf("float4_e_4964c===%010.2v4hlE===%010.2v4hlE===\n",var1,var2);
  return i;
}

int float4_e_4965c() {

  float4 var1 = (float4) (-12345.032,2.0,0.0,-1.23);
  float4 var2 = (float4) (0.0,0.0,0.0,-12345.032);
  int i = printf("float4_e_4965c===%010.3v4hlE===%010.3v4hlE===\n",var1,var2);
  return i;
}

int float4_e_4966c() {

  float4 var1 = (float4) (-12345.032,-12345.032,2.0,-1.23);
  float4 var2 = (float4) (2.0,1.0,0.0,2.0);
  int i = printf("float4_e_4966c===%010.10v4hlE===%010.10v4hlE===\n",var1,var2);
  return i;
}

int float4_e_5717c() {

  float4 var1 = (float4) (123455.134,1.0,2.0,0.0);
  float4 var2 = (float4) (123455.134,123455.134,0.0,1.0);
  int i = printf("float4_e_5717c===%- 10v4hle===%- 10v4hle===\n",var1,var2);
  return i;
}

int float4_e_5718c() {

  float4 var1 = (float4) (-12345.032,-12345.032,-1.23,2.0);
  float4 var2 = (float4) (-1.23,123455.134,1.0,2.0);
  int i = printf("float4_e_5718c===%- 10.1v4hle===%- 10.1v4hle===\n",var1,var2);
  return i;
}

int float4_e_5719c() {

  float4 var1 = (float4) (1.0,1.0,0.0,123455.134);
  float4 var2 = (float4) (-12345.032,-12345.032,0.0,-12345.032);
  int i = printf("float4_e_5719c===%- 10.2v4hle===%- 10.2v4hle===\n",var1,var2);
  return i;
}

int float4_e_5720c() {

  float4 var1 = (float4) (0.0,-1.23,-12345.032,1.0);
  float4 var2 = (float4) (2.0,0.0,1.0,2.0);
  int i = printf("float4_e_5720c===%- 10.3v4hle===%- 10.3v4hle===\n",var1,var2);
  return i;
}

int float4_e_5721c() {

  float4 var1 = (float4) (123455.134,123455.134,2.0,-1.23);
  float4 var2 = (float4) (123455.134,2.0,-12345.032,1.0);
  int i = printf("float4_e_5721c===%- 10.10v4hle===%- 10.10v4hle===\n",var1,var2);
  return i;
}

int float4_e_5722c() {

  float4 var1 = (float4) (2.0,0.0,123455.134,2.0);
  float4 var2 = (float4) (2.0,1.0,1.0,1.0);
  int i = printf("float4_e_5722c===%- 10v4hlE===%- 10v4hlE===\n",var1,var2);
  return i;
}

int float4_e_5723c() {

  float4 var1 = (float4) (1.0,0.0,123455.134,0.0);
  float4 var2 = (float4) (2.0,-12345.032,123455.134,-12345.032);
  int i = printf("float4_e_5723c===%- 10.1v4hlE===%- 10.1v4hlE===\n",var1,var2);
  return i;
}

int float4_e_5724c() {

  float4 var1 = (float4) (123455.134,0.0,0.0,0.0);
  float4 var2 = (float4) (0.0,0.0,-12345.032,123455.134);
  int i = printf("float4_e_5724c===%- 10.2v4hlE===%- 10.2v4hlE===\n",var1,var2);
  return i;
}

int float4_e_5725c() {

  float4 var1 = (float4) (2.0,0.0,-1.23,-1.23);
  float4 var2 = (float4) (123455.134,1.0,123455.134,2.0);
  int i = printf("float4_e_5725c===%- 10.3v4hlE===%- 10.3v4hlE===\n",var1,var2);
  return i;
}

int float4_e_5726c() {

  float4 var1 = (float4) (2.0,2.0,-12345.032,123455.134);
  float4 var2 = (float4) (1.0,0.0,2.0,123455.134);
  int i = printf("float4_e_5726c===%- 10.10v4hlE===%- 10.10v4hlE===\n",var1,var2);
  return i;
}

int float4_e_6477c() {

  float4 var1 = (float4) (-1.23,123455.134,123455.134,-12345.032);
  float4 var2 = (float4) (2.0,123455.134,0.0,0.0);
  int i = printf("float4_e_6477c===%+ 10v4hle===%+ 10v4hle===\n",var1,var2);
  return i;
}

int float4_e_6478c() {

  float4 var1 = (float4) (123455.134,123455.134,-12345.032,2.0);
  float4 var2 = (float4) (2.0,-12345.032,-1.23,1.0);
  int i = printf("float4_e_6478c===%+ 10.1v4hle===%+ 10.1v4hle===\n",var1,var2);
  return i;
}

int float4_e_6479c() {

  float4 var1 = (float4) (-12345.032,123455.134,0.0,-1.23);
  float4 var2 = (float4) (-12345.032,2.0,-1.23,1.0);
  int i = printf("float4_e_6479c===%+ 10.2v4hle===%+ 10.2v4hle===\n",var1,var2);
  return i;
}

int float4_e_6480c() {

  float4 var1 = (float4) (0.0,0.0,-12345.032,0.0);
  float4 var2 = (float4) (1.0,0.0,1.0,2.0);
  int i = printf("float4_e_6480c===%+ 10.3v4hle===%+ 10.3v4hle===\n",var1,var2);
  return i;
}

int float4_e_6481c() {

  float4 var1 = (float4) (-1.23,1.0,-12345.032,123455.134);
  float4 var2 = (float4) (0.0,-12345.032,123455.134,2.0);
  int i = printf("float4_e_6481c===%+ 10.10v4hle===%+ 10.10v4hle===\n",var1,var2);
  return i;
}

int float4_e_6482c() {

  float4 var1 = (float4) (1.0,-1.23,-12345.032,123455.134);
  float4 var2 = (float4) (-12345.032,123455.134,1.0,-1.23);
  int i = printf("float4_e_6482c===%+ 10v4hlE===%+ 10v4hlE===\n",var1,var2);
  return i;
}

int float4_e_6483c() {

  float4 var1 = (float4) (1.0,-1.23,123455.134,-12345.032);
  float4 var2 = (float4) (123455.134,2.0,-12345.032,1.0);
  int i = printf("float4_e_6483c===%+ 10.1v4hlE===%+ 10.1v4hlE===\n",var1,var2);
  return i;
}

int float4_e_6484c() {

  float4 var1 = (float4) (-1.23,0.0,1.0,-1.23);
  float4 var2 = (float4) (0.0,-1.23,1.0,123455.134);
  int i = printf("float4_e_6484c===%+ 10.2v4hlE===%+ 10.2v4hlE===\n",var1,var2);
  return i;
}

int float4_e_6485c() {

  float4 var1 = (float4) (-1.23,-12345.032,2.0,0.0);
  float4 var2 = (float4) (0.0,-1.23,123455.134,-12345.032);
  int i = printf("float4_e_6485c===%+ 10.3v4hlE===%+ 10.3v4hlE===\n",var1,var2);
  return i;
}

int float4_e_6486c() {

  float4 var1 = (float4) (-12345.032,-12345.032,0.0,1.0);
  float4 var2 = (float4) (-1.23,-12345.032,123455.134,2.0);
  int i = printf("float4_e_6486c===%+ 10.10v4hlE===%+ 10.10v4hlE===\n",var1,var2);
  return i;
}

int float4_e_7237c() {

  float4 var1 = (float4) (123455.134,1.0,123455.134,0.0);
  float4 var2 = (float4) (2.0,1.0,2.0,2.0);
  int i = printf("float4_e_7237c===%+010v4hle===%+010v4hle===\n",var1,var2);
  return i;
}

int float4_e_7238c() {

  float4 var1 = (float4) (-1.23,-12345.032,0.0,-1.23);
  float4 var2 = (float4) (123455.134,-12345.032,123455.134,1.0);
  int i = printf("float4_e_7238c===%+010.1v4hle===%+010.1v4hle===\n",var1,var2);
  return i;
}

int float4_e_7239c() {

  float4 var1 = (float4) (123455.134,2.0,-1.23,0.0);
  float4 var2 = (float4) (-12345.032,1.0,2.0,-1.23);
  int i = printf("float4_e_7239c===%+010.2v4hle===%+010.2v4hle===\n",var1,var2);
  return i;
}

int float4_e_7240c() {

  float4 var1 = (float4) (123455.134,-12345.032,-1.23,1.0);
  float4 var2 = (float4) (2.0,2.0,-1.23,0.0);
  int i = printf("float4_e_7240c===%+010.3v4hle===%+010.3v4hle===\n",var1,var2);
  return i;
}

int float4_e_7241c() {

  float4 var1 = (float4) (2.0,123455.134,0.0,2.0);
  float4 var2 = (float4) (-1.23,-12345.032,-1.23,123455.134);
  int i = printf("float4_e_7241c===%+010.10v4hle===%+010.10v4hle===\n",var1,var2);
  return i;
}

int float4_e_7242c() {

  float4 var1 = (float4) (123455.134,123455.134,123455.134,-1.23);
  float4 var2 = (float4) (0.0,2.0,-1.23,123455.134);
  int i = printf("float4_e_7242c===%+010v4hlE===%+010v4hlE===\n",var1,var2);
  return i;
}

int float4_e_7243c() {

  float4 var1 = (float4) (-1.23,-1.23,1.0,-1.23);
  float4 var2 = (float4) (-12345.032,2.0,1.0,-1.23);
  int i = printf("float4_e_7243c===%+010.1v4hlE===%+010.1v4hlE===\n",var1,var2);
  return i;
}

int float4_e_7244c() {

  float4 var1 = (float4) (-12345.032,-12345.032,-1.23,0.0);
  float4 var2 = (float4) (123455.134,-1.23,1.0,1.0);
  int i = printf("float4_e_7244c===%+010.2v4hlE===%+010.2v4hlE===\n",var1,var2);
  return i;
}

int float4_e_7245c() {

  float4 var1 = (float4) (1.0,1.0,0.0,-12345.032);
  float4 var2 = (float4) (-12345.032,1.0,-1.23,1.0);
  int i = printf("float4_e_7245c===%+010.3v4hlE===%+010.3v4hlE===\n",var1,var2);
  return i;
}

int float4_e_7246c() {

  float4 var1 = (float4) (-1.23,123455.134,-1.23,123455.134);
  float4 var2 = (float4) (-1.23,1.0,-12345.032,123455.134);
  int i = printf("float4_e_7246c===%+010.10v4hlE===%+010.10v4hlE===\n",var1,var2);
  return i;
}

int float4_f_1167c() {

  float4 var1 = (float4) (-12345.032,123455.134,2.0,0.0);
  float4 var2 = (float4) (123455.134,1.0,-12345.032,-12345.032);
  int i = printf("float4_f_1167c===%-v4hlf===%-v4hlf===\n",var1,var2);
  return i;
}

int float4_f_1168c() {

  float4 var1 = (float4) (-12345.032,-12345.032,-1.23,1.0);
  float4 var2 = (float4) (1.0,0.0,1.0,1.0);
  int i = printf("float4_f_1168c===%-.1v4hlf===%-.1v4hlf===\n",var1,var2);
  return i;
}

int float4_f_1169c() {

  float4 var1 = (float4) (-1.23,-12345.032,0.0,1.0);
  float4 var2 = (float4) (1.0,-12345.032,-1.23,2.0);
  int i = printf("float4_f_1169c===%-.2v4hlf===%-.2v4hlf===\n",var1,var2);
  return i;
}

int float4_f_1170c() {

  float4 var1 = (float4) (123455.134,-1.23,0.0,0.0);
  float4 var2 = (float4) (-12345.032,-1.23,0.0,1.0);
  int i = printf("float4_f_1170c===%-.3v4hlf===%-.3v4hlf===\n",var1,var2);
  return i;
}

int float4_f_1171c() {

  float4 var1 = (float4) (1.0,-12345.032,-12345.032,2.0);
  float4 var2 = (float4) (123455.134,123455.134,123455.134,0.0);
  int i = printf("float4_f_1171c===%-.10v4hlf===%-.10v4hlf===\n",var1,var2);
  return i;
}

int float4_f_1172c() {

  float4 var1 = (float4) (1.0,-12345.032,0.0,0.0);
  float4 var2 = (float4) (2.0,123455.134,1.0,-1.23);
  int i = printf("float4_f_1172c===%-v4hlF===%-v4hlF===\n",var1,var2);
  return i;
}

int float4_f_1173c() {

  float4 var1 = (float4) (-1.23,0.0,-1.23,1.0);
  float4 var2 = (float4) (-12345.032,-1.23,123455.134,2.0);
  int i = printf("float4_f_1173c===%-.1v4hlF===%-.1v4hlF===\n",var1,var2);
  return i;
}

int float4_f_1174c() {

  float4 var1 = (float4) (1.0,-12345.032,-12345.032,0.0);
  float4 var2 = (float4) (-1.23,1.0,0.0,2.0);
  int i = printf("float4_f_1174c===%-.2v4hlF===%-.2v4hlF===\n",var1,var2);
  return i;
}

int float4_f_1175c() {

  float4 var1 = (float4) (0.0,2.0,123455.134,0.0);
  float4 var2 = (float4) (-1.23,-1.23,0.0,123455.134);
  int i = printf("float4_f_1175c===%-.3v4hlF===%-.3v4hlF===\n",var1,var2);
  return i;
}

int float4_f_1176c() {

  float4 var1 = (float4) (2.0,2.0,2.0,0.0);
  float4 var2 = (float4) (0.0,123455.134,123455.134,2.0);
  int i = printf("float4_f_1176c===%-.10v4hlF===%-.10v4hlF===\n",var1,var2);
  return i;
}

int float4_f_1927c() {

  float4 var1 = (float4) (2.0,2.0,-1.23,123455.134);
  float4 var2 = (float4) (2.0,-12345.032,1.0,0.0);
  int i = printf("float4_f_1927c===%+v4hlf===%+v4hlf===\n",var1,var2);
  return i;
}

int float4_f_1928c() {

  float4 var1 = (float4) (-12345.032,-12345.032,123455.134,0.0);
  float4 var2 = (float4) (2.0,1.0,1.0,0.0);
  int i = printf("float4_f_1928c===%+.1v4hlf===%+.1v4hlf===\n",var1,var2);
  return i;
}

int float4_f_1929c() {

  float4 var1 = (float4) (-12345.032,123455.134,0.0,0.0);
  float4 var2 = (float4) (2.0,-12345.032,-12345.032,123455.134);
  int i = printf("float4_f_1929c===%+.2v4hlf===%+.2v4hlf===\n",var1,var2);
  return i;
}

int float4_f_1930c() {

  float4 var1 = (float4) (123455.134,0.0,0.0,-12345.032);
  float4 var2 = (float4) (-1.23,0.0,-1.23,123455.134);
  int i = printf("float4_f_1930c===%+.3v4hlf===%+.3v4hlf===\n",var1,var2);
  return i;
}

int float4_f_1931c() {

  float4 var1 = (float4) (0.0,123455.134,-1.23,1.0);
  float4 var2 = (float4) (1.0,-1.23,-1.23,1.0);
  int i = printf("float4_f_1931c===%+.10v4hlf===%+.10v4hlf===\n",var1,var2);
  return i;
}

int float4_f_1932c() {

  float4 var1 = (float4) (-1.23,123455.134,-12345.032,123455.134);
  float4 var2 = (float4) (-12345.032,-12345.032,0.0,0.0);
  int i = printf("float4_f_1932c===%+v4hlF===%+v4hlF===\n",var1,var2);
  return i;
}

int float4_f_1933c() {

  float4 var1 = (float4) (0.0,0.0,123455.134,-12345.032);
  float4 var2 = (float4) (-12345.032,123455.134,0.0,123455.134);
  int i = printf("float4_f_1933c===%+.1v4hlF===%+.1v4hlF===\n",var1,var2);
  return i;
}

int float4_f_1934c() {

  float4 var1 = (float4) (2.0,1.0,0.0,1.0);
  float4 var2 = (float4) (123455.134,2.0,0.0,123455.134);
  int i = printf("float4_f_1934c===%+.2v4hlF===%+.2v4hlF===\n",var1,var2);
  return i;
}

int float4_f_1935c() {

  float4 var1 = (float4) (-12345.032,-12345.032,123455.134,-12345.032);
  float4 var2 = (float4) (1.0,1.0,1.0,2.0);
  int i = printf("float4_f_1935c===%+.3v4hlF===%+.3v4hlF===\n",var1,var2);
  return i;
}

int float4_f_1936c() {

  float4 var1 = (float4) (-1.23,0.0,2.0,2.0);
  float4 var2 = (float4) (1.0,-12345.032,-12345.032,-1.23);
  int i = printf("float4_f_1936c===%+.10v4hlF===%+.10v4hlF===\n",var1,var2);
  return i;
}

int float4_f_2687c() {

  float4 var1 = (float4) (2.0,-1.23,-1.23,123455.134);
  float4 var2 = (float4) (-12345.032,-1.23,1.0,2.0);
  int i = printf("float4_f_2687c===%#v4hlf===%#v4hlf===\n",var1,var2);
  return i;
}

int float4_f_2688c() {

  float4 var1 = (float4) (-1.23,-1.23,-1.23,-12345.032);
  float4 var2 = (float4) (123455.134,123455.134,-12345.032,-12345.032);
  int i = printf("float4_f_2688c===%#.1v4hlf===%#.1v4hlf===\n",var1,var2);
  return i;
}

int float4_f_2689c() {

  float4 var1 = (float4) (-1.23,-1.23,-1.23,123455.134);
  float4 var2 = (float4) (-1.23,-12345.032,2.0,-1.23);
  int i = printf("float4_f_2689c===%#.2v4hlf===%#.2v4hlf===\n",var1,var2);
  return i;
}

int float4_f_2690c() {

  float4 var1 = (float4) (-1.23,1.0,123455.134,123455.134);
  float4 var2 = (float4) (-1.23,-12345.032,2.0,0.0);
  int i = printf("float4_f_2690c===%#.3v4hlf===%#.3v4hlf===\n",var1,var2);
  return i;
}

int float4_f_2691c() {

  float4 var1 = (float4) (2.0,0.0,-12345.032,-12345.032);
  float4 var2 = (float4) (2.0,0.0,2.0,123455.134);
  int i = printf("float4_f_2691c===%#.10v4hlf===%#.10v4hlf===\n",var1,var2);
  return i;
}

int float4_f_2692c() {

  float4 var1 = (float4) (1.0,1.0,-1.23,-12345.032);
  float4 var2 = (float4) (-1.23,1.0,-1.23,-1.23);
  int i = printf("float4_f_2692c===%#v4hlF===%#v4hlF===\n",var1,var2);
  return i;
}

int float4_f_2693c() {

  float4 var1 = (float4) (123455.134,-12345.032,-12345.032,1.0);
  float4 var2 = (float4) (-12345.032,2.0,-12345.032,1.0);
  int i = printf("float4_f_2693c===%#.1v4hlF===%#.1v4hlF===\n",var1,var2);
  return i;
}

int float4_f_2694c() {

  float4 var1 = (float4) (0.0,2.0,0.0,2.0);
  float4 var2 = (float4) (-12345.032,1.0,-12345.032,123455.134);
  int i = printf("float4_f_2694c===%#.2v4hlF===%#.2v4hlF===\n",var1,var2);
  return i;
}

int float4_f_2695c() {

  float4 var1 = (float4) (1.0,0.0,2.0,2.0);
  float4 var2 = (float4) (-12345.032,-1.23,2.0,2.0);
  int i = printf("float4_f_2695c===%#.3v4hlF===%#.3v4hlF===\n",var1,var2);
  return i;
}

int float4_f_2696c() {

  float4 var1 = (float4) (0.0,1.0,2.0,-1.23);
  float4 var2 = (float4) (-1.23,2.0,1.0,1.0);
  int i = printf("float4_f_2696c===%#.10v4hlF===%#.10v4hlF===\n",var1,var2);
  return i;
}

int float4_f_3447c() {

  float4 var1 = (float4) (0.0,-1.23,0.0,0.0);
  float4 var2 = (float4) (123455.134,-12345.032,-12345.032,0.0);
  int i = printf("float4_f_3447c===%-+v4hlf===%-+v4hlf===\n",var1,var2);
  return i;
}

int float4_f_3448c() {

  float4 var1 = (float4) (1.0,-1.23,2.0,2.0);
  float4 var2 = (float4) (0.0,0.0,2.0,-1.23);
  int i = printf("float4_f_3448c===%-+.1v4hlf===%-+.1v4hlf===\n",var1,var2);
  return i;
}

int float4_f_3449c() {

  float4 var1 = (float4) (-1.23,0.0,2.0,2.0);
  float4 var2 = (float4) (-12345.032,0.0,123455.134,2.0);
  int i = printf("float4_f_3449c===%-+.2v4hlf===%-+.2v4hlf===\n",var1,var2);
  return i;
}

int float4_f_3450c() {

  float4 var1 = (float4) (0.0,1.0,123455.134,0.0);
  float4 var2 = (float4) (0.0,0.0,-12345.032,2.0);
  int i = printf("float4_f_3450c===%-+.3v4hlf===%-+.3v4hlf===\n",var1,var2);
  return i;
}

int float4_f_3451c() {

  float4 var1 = (float4) (0.0,-12345.032,-12345.032,123455.134);
  float4 var2 = (float4) (123455.134,123455.134,0.0,2.0);
  int i = printf("float4_f_3451c===%-+.10v4hlf===%-+.10v4hlf===\n",var1,var2);
  return i;
}

int float4_f_3452c() {

  float4 var1 = (float4) (0.0,2.0,-12345.032,123455.134);
  float4 var2 = (float4) (-1.23,2.0,2.0,-12345.032);
  int i = printf("float4_f_3452c===%-+v4hlF===%-+v4hlF===\n",var1,var2);
  return i;
}

int float4_f_3453c() {

  float4 var1 = (float4) (-12345.032,-12345.032,-12345.032,-12345.032);
  float4 var2 = (float4) (1.0,0.0,2.0,2.0);
  int i = printf("float4_f_3453c===%-+.1v4hlF===%-+.1v4hlF===\n",var1,var2);
  return i;
}

int float4_f_3454c() {

  float4 var1 = (float4) (2.0,-12345.032,-1.23,-12345.032);
  float4 var2 = (float4) (-1.23,-12345.032,2.0,1.0);
  int i = printf("float4_f_3454c===%-+.2v4hlF===%-+.2v4hlF===\n",var1,var2);
  return i;
}

int float4_f_3455c() {

  float4 var1 = (float4) (0.0,-1.23,123455.134,0.0);
  float4 var2 = (float4) (123455.134,-1.23,1.0,1.0);
  int i = printf("float4_f_3455c===%-+.3v4hlF===%-+.3v4hlF===\n",var1,var2);
  return i;
}

int float4_f_3456c() {

  float4 var1 = (float4) (-1.23,0.0,123455.134,0.0);
  float4 var2 = (float4) (2.0,-1.23,1.0,2.0);
  int i = printf("float4_f_3456c===%-+.10v4hlF===%-+.10v4hlF===\n",var1,var2);
  return i;
}

int float4_f_407c() {

  float4 var1 = (float4) (-12345.032,-1.23,0.0,0.0);
  float4 var2 = (float4) (123455.134,-12345.032,123455.134,-12345.032);
  int i = printf("float4_f_407c===%v4hlf===%v4hlf===\n",var1,var2);
  return i;
}

int float4_f_408c() {

  float4 var1 = (float4) (0.0,123455.134,123455.134,-1.23);
  float4 var2 = (float4) (1.0,-1.23,0.0,-1.23);
  int i = printf("float4_f_408c===%.1v4hlf===%.1v4hlf===\n",var1,var2);
  return i;
}

int float4_f_409c() {

  float4 var1 = (float4) (-1.23,0.0,-1.23,-12345.032);
  float4 var2 = (float4) (1.0,-12345.032,0.0,0.0);
  int i = printf("float4_f_409c===%.2v4hlf===%.2v4hlf===\n",var1,var2);
  return i;
}

int float4_f_410c() {

  float4 var1 = (float4) (123455.134,2.0,1.0,2.0);
  float4 var2 = (float4) (123455.134,-1.23,123455.134,1.0);
  int i = printf("float4_f_410c===%.3v4hlf===%.3v4hlf===\n",var1,var2);
  return i;
}

int float4_f_411c() {

  float4 var1 = (float4) (1.0,2.0,123455.134,2.0);
  float4 var2 = (float4) (-12345.032,-1.23,-12345.032,1.0);
  int i = printf("float4_f_411c===%.10v4hlf===%.10v4hlf===\n",var1,var2);
  return i;
}

int float4_f_412c() {

  float4 var1 = (float4) (123455.134,1.0,2.0,0.0);
  float4 var2 = (float4) (-1.23,0.0,0.0,0.0);
  int i = printf("float4_f_412c===%v4hlF===%v4hlF===\n",var1,var2);
  return i;
}

int float4_f_413c() {

  float4 var1 = (float4) (1.0,1.0,123455.134,-1.23);
  float4 var2 = (float4) (2.0,2.0,-12345.032,-1.23);
  int i = printf("float4_f_413c===%.1v4hlF===%.1v4hlF===\n",var1,var2);
  return i;
}

int float4_f_414c() {

  float4 var1 = (float4) (1.0,-1.23,-12345.032,-12345.032);
  float4 var2 = (float4) (-1.23,0.0,-12345.032,123455.134);
  int i = printf("float4_f_414c===%.2v4hlF===%.2v4hlF===\n",var1,var2);
  return i;
}

int float4_f_415c() {

  float4 var1 = (float4) (0.0,-1.23,1.0,-12345.032);
  float4 var2 = (float4) (-12345.032,-1.23,-1.23,0.0);
  int i = printf("float4_f_415c===%.3v4hlF===%.3v4hlF===\n",var1,var2);
  return i;
}

int float4_f_416c() {

  float4 var1 = (float4) (1.0,-1.23,0.0,0.0);
  float4 var2 = (float4) (-1.23,1.0,2.0,-1.23);
  int i = printf("float4_f_416c===%.10v4hlF===%.10v4hlF===\n",var1,var2);
  return i;
}

int float4_f_4207c() {

  float4 var1 = (float4) (123455.134,0.0,0.0,0.0);
  float4 var2 = (float4) (-12345.032,-1.23,1.0,-12345.032);
  int i = printf("float4_f_4207c===% 10v4hlf===% 10v4hlf===\n",var1,var2);
  return i;
}

int float4_f_4208c() {

  float4 var1 = (float4) (1.0,2.0,-12345.032,0.0);
  float4 var2 = (float4) (123455.134,1.0,-1.23,123455.134);
  int i = printf("float4_f_4208c===% 10.1v4hlf===% 10.1v4hlf===\n",var1,var2);
  return i;
}

int float4_f_4209c() {

  float4 var1 = (float4) (0.0,1.0,-12345.032,-1.23);
  float4 var2 = (float4) (123455.134,0.0,1.0,-1.23);
  int i = printf("float4_f_4209c===% 10.2v4hlf===% 10.2v4hlf===\n",var1,var2);
  return i;
}

int float4_f_4210c() {

  float4 var1 = (float4) (-1.23,-1.23,-1.23,123455.134);
  float4 var2 = (float4) (123455.134,123455.134,1.0,123455.134);
  int i = printf("float4_f_4210c===% 10.3v4hlf===% 10.3v4hlf===\n",var1,var2);
  return i;
}

int float4_f_4211c() {

  float4 var1 = (float4) (-12345.032,-1.23,-1.23,2.0);
  float4 var2 = (float4) (-12345.032,-12345.032,123455.134,-12345.032);
  int i = printf("float4_f_4211c===% 10.10v4hlf===% 10.10v4hlf===\n",var1,var2);
  return i;
}

int float4_f_4212c() {

  float4 var1 = (float4) (123455.134,1.0,0.0,2.0);
  float4 var2 = (float4) (1.0,2.0,0.0,0.0);
  int i = printf("float4_f_4212c===% 10v4hlF===% 10v4hlF===\n",var1,var2);
  return i;
}

int float4_f_4213c() {

  float4 var1 = (float4) (123455.134,2.0,2.0,2.0);
  float4 var2 = (float4) (0.0,123455.134,-12345.032,-12345.032);
  int i = printf("float4_f_4213c===% 10.1v4hlF===% 10.1v4hlF===\n",var1,var2);
  return i;
}

int float4_f_4214c() {

  float4 var1 = (float4) (-1.23,-1.23,1.0,-1.23);
  float4 var2 = (float4) (0.0,1.0,-1.23,-1.23);
  int i = printf("float4_f_4214c===% 10.2v4hlF===% 10.2v4hlF===\n",var1,var2);
  return i;
}

int float4_f_4215c() {

  float4 var1 = (float4) (-1.23,-12345.032,1.0,1.0);
  float4 var2 = (float4) (2.0,0.0,2.0,2.0);
  int i = printf("float4_f_4215c===% 10.3v4hlF===% 10.3v4hlF===\n",var1,var2);
  return i;
}

int float4_f_4216c() {

  float4 var1 = (float4) (-1.23,2.0,-1.23,0.0);
  float4 var2 = (float4) (1.0,123455.134,1.0,-12345.032);
  int i = printf("float4_f_4216c===% 10.10v4hlF===% 10.10v4hlF===\n",var1,var2);
  return i;
}

int float4_f_4967c() {

  float4 var1 = (float4) (2.0,2.0,123455.134,-1.23);
  float4 var2 = (float4) (1.0,123455.134,1.0,2.0);
  int i = printf("float4_f_4967c===%010v4hlf===%010v4hlf===\n",var1,var2);
  return i;
}

int float4_f_4968c() {

  float4 var1 = (float4) (0.0,-12345.032,0.0,-12345.032);
  float4 var2 = (float4) (-1.23,2.0,123455.134,1.0);
  int i = printf("float4_f_4968c===%010.1v4hlf===%010.1v4hlf===\n",var1,var2);
  return i;
}

int float4_f_4969c() {

  float4 var1 = (float4) (1.0,-1.23,-1.23,-1.23);
  float4 var2 = (float4) (123455.134,0.0,-1.23,2.0);
  int i = printf("float4_f_4969c===%010.2v4hlf===%010.2v4hlf===\n",var1,var2);
  return i;
}

int float4_f_4970c() {

  float4 var1 = (float4) (0.0,-1.23,2.0,0.0);
  float4 var2 = (float4) (0.0,-1.23,-1.23,123455.134);
  int i = printf("float4_f_4970c===%010.3v4hlf===%010.3v4hlf===\n",var1,var2);
  return i;
}

int float4_f_4971c() {

  float4 var1 = (float4) (0.0,0.0,-1.23,0.0);
  float4 var2 = (float4) (0.0,123455.134,0.0,2.0);
  int i = printf("float4_f_4971c===%010.10v4hlf===%010.10v4hlf===\n",var1,var2);
  return i;
}

int float4_f_4972c() {

  float4 var1 = (float4) (-1.23,123455.134,2.0,123455.134);
  float4 var2 = (float4) (-1.23,-12345.032,123455.134,2.0);
  int i = printf("float4_f_4972c===%010v4hlF===%010v4hlF===\n",var1,var2);
  return i;
}

int float4_f_4973c() {

  float4 var1 = (float4) (1.0,2.0,2.0,123455.134);
  float4 var2 = (float4) (-1.23,-12345.032,0.0,1.0);
  int i = printf("float4_f_4973c===%010.1v4hlF===%010.1v4hlF===\n",var1,var2);
  return i;
}

int float4_f_4974c() {

  float4 var1 = (float4) (123455.134,-12345.032,-12345.032,-12345.032);
  float4 var2 = (float4) (0.0,123455.134,2.0,-12345.032);
  int i = printf("float4_f_4974c===%010.2v4hlF===%010.2v4hlF===\n",var1,var2);
  return i;
}

int float4_f_4975c() {

  float4 var1 = (float4) (123455.134,0.0,123455.134,-12345.032);
  float4 var2 = (float4) (-1.23,123455.134,0.0,-1.23);
  int i = printf("float4_f_4975c===%010.3v4hlF===%010.3v4hlF===\n",var1,var2);
  return i;
}

int float4_f_4976c() {

  float4 var1 = (float4) (0.0,-12345.032,0.0,2.0);
  float4 var2 = (float4) (0.0,123455.134,123455.134,0.0);
  int i = printf("float4_f_4976c===%010.10v4hlF===%010.10v4hlF===\n",var1,var2);
  return i;
}

int float4_f_5727c() {

  float4 var1 = (float4) (-12345.032,0.0,123455.134,0.0);
  float4 var2 = (float4) (2.0,123455.134,0.0,-1.23);
  int i = printf("float4_f_5727c===%- 10v4hlf===%- 10v4hlf===\n",var1,var2);
  return i;
}

int float4_f_5728c() {

  float4 var1 = (float4) (123455.134,2.0,1.0,-12345.032);
  float4 var2 = (float4) (2.0,2.0,2.0,2.0);
  int i = printf("float4_f_5728c===%- 10.1v4hlf===%- 10.1v4hlf===\n",var1,var2);
  return i;
}

int float4_f_5729c() {

  float4 var1 = (float4) (0.0,1.0,123455.134,1.0);
  float4 var2 = (float4) (-12345.032,2.0,0.0,-1.23);
  int i = printf("float4_f_5729c===%- 10.2v4hlf===%- 10.2v4hlf===\n",var1,var2);
  return i;
}

int float4_f_5730c() {

  float4 var1 = (float4) (0.0,2.0,2.0,123455.134);
  float4 var2 = (float4) (-12345.032,1.0,-12345.032,0.0);
  int i = printf("float4_f_5730c===%- 10.3v4hlf===%- 10.3v4hlf===\n",var1,var2);
  return i;
}

int float4_f_5731c() {

  float4 var1 = (float4) (-1.23,2.0,1.0,0.0);
  float4 var2 = (float4) (123455.134,-1.23,-1.23,123455.134);
  int i = printf("float4_f_5731c===%- 10.10v4hlf===%- 10.10v4hlf===\n",var1,var2);
  return i;
}

int float4_f_5732c() {

  float4 var1 = (float4) (-1.23,0.0,-12345.032,-1.23);
  float4 var2 = (float4) (0.0,-12345.032,1.0,-12345.032);
  int i = printf("float4_f_5732c===%- 10v4hlF===%- 10v4hlF===\n",var1,var2);
  return i;
}

int float4_f_5733c() {

  float4 var1 = (float4) (0.0,1.0,123455.134,-1.23);
  float4 var2 = (float4) (2.0,0.0,123455.134,2.0);
  int i = printf("float4_f_5733c===%- 10.1v4hlF===%- 10.1v4hlF===\n",var1,var2);
  return i;
}

int float4_f_5734c() {

  float4 var1 = (float4) (0.0,123455.134,123455.134,1.0);
  float4 var2 = (float4) (2.0,0.0,-12345.032,0.0);
  int i = printf("float4_f_5734c===%- 10.2v4hlF===%- 10.2v4hlF===\n",var1,var2);
  return i;
}

int float4_f_5735c() {

  float4 var1 = (float4) (-12345.032,2.0,-1.23,2.0);
  float4 var2 = (float4) (-12345.032,-1.23,-12345.032,0.0);
  int i = printf("float4_f_5735c===%- 10.3v4hlF===%- 10.3v4hlF===\n",var1,var2);
  return i;
}

int float4_f_5736c() {

  float4 var1 = (float4) (2.0,2.0,-12345.032,1.0);
  float4 var2 = (float4) (123455.134,123455.134,-12345.032,-1.23);
  int i = printf("float4_f_5736c===%- 10.10v4hlF===%- 10.10v4hlF===\n",var1,var2);
  return i;
}

int float4_f_6487c() {

  float4 var1 = (float4) (1.0,123455.134,123455.134,2.0);
  float4 var2 = (float4) (0.0,0.0,-12345.032,123455.134);
  int i = printf("float4_f_6487c===%+ 10v4hlf===%+ 10v4hlf===\n",var1,var2);
  return i;
}

int float4_f_6488c() {

  float4 var1 = (float4) (123455.134,0.0,2.0,-1.23);
  float4 var2 = (float4) (-12345.032,0.0,-12345.032,1.0);
  int i = printf("float4_f_6488c===%+ 10.1v4hlf===%+ 10.1v4hlf===\n",var1,var2);
  return i;
}

int float4_f_6489c() {

  float4 var1 = (float4) (-12345.032,1.0,2.0,0.0);
  float4 var2 = (float4) (2.0,0.0,-12345.032,1.0);
  int i = printf("float4_f_6489c===%+ 10.2v4hlf===%+ 10.2v4hlf===\n",var1,var2);
  return i;
}

int float4_f_6490c() {

  float4 var1 = (float4) (123455.134,2.0,-12345.032,123455.134);
  float4 var2 = (float4) (-1.23,-1.23,-1.23,-12345.032);
  int i = printf("float4_f_6490c===%+ 10.3v4hlf===%+ 10.3v4hlf===\n",var1,var2);
  return i;
}

int float4_f_6491c() {

  float4 var1 = (float4) (123455.134,2.0,-12345.032,1.0);
  float4 var2 = (float4) (123455.134,0.0,-12345.032,1.0);
  int i = printf("float4_f_6491c===%+ 10.10v4hlf===%+ 10.10v4hlf===\n",var1,var2);
  return i;
}

int float4_f_6492c() {

  float4 var1 = (float4) (-12345.032,1.0,-1.23,-1.23);
  float4 var2 = (float4) (0.0,0.0,2.0,123455.134);
  int i = printf("float4_f_6492c===%+ 10v4hlF===%+ 10v4hlF===\n",var1,var2);
  return i;
}

int float4_f_6493c() {

  float4 var1 = (float4) (-12345.032,-12345.032,123455.134,-1.23);
  float4 var2 = (float4) (-1.23,1.0,-12345.032,123455.134);
  int i = printf("float4_f_6493c===%+ 10.1v4hlF===%+ 10.1v4hlF===\n",var1,var2);
  return i;
}

int float4_f_6494c() {

  float4 var1 = (float4) (123455.134,-1.23,-12345.032,-12345.032);
  float4 var2 = (float4) (0.0,1.0,1.0,0.0);
  int i = printf("float4_f_6494c===%+ 10.2v4hlF===%+ 10.2v4hlF===\n",var1,var2);
  return i;
}

int float4_f_6495c() {

  float4 var1 = (float4) (2.0,1.0,-1.23,123455.134);
  float4 var2 = (float4) (123455.134,1.0,1.0,-1.23);
  int i = printf("float4_f_6495c===%+ 10.3v4hlF===%+ 10.3v4hlF===\n",var1,var2);
  return i;
}

int float4_f_6496c() {

  float4 var1 = (float4) (1.0,0.0,2.0,1.0);
  float4 var2 = (float4) (0.0,123455.134,2.0,1.0);
  int i = printf("float4_f_6496c===%+ 10.10v4hlF===%+ 10.10v4hlF===\n",var1,var2);
  return i;
}

int float4_f_7247c() {

  float4 var1 = (float4) (0.0,0.0,-12345.032,-12345.032);
  float4 var2 = (float4) (2.0,1.0,1.0,0.0);
  int i = printf("float4_f_7247c===%+010v4hlf===%+010v4hlf===\n",var1,var2);
  return i;
}

int float4_f_7248c() {

  float4 var1 = (float4) (-12345.032,2.0,123455.134,-1.23);
  float4 var2 = (float4) (123455.134,-1.23,-12345.032,1.0);
  int i = printf("float4_f_7248c===%+010.1v4hlf===%+010.1v4hlf===\n",var1,var2);
  return i;
}

int float4_f_7249c() {

  float4 var1 = (float4) (123455.134,1.0,1.0,-12345.032);
  float4 var2 = (float4) (2.0,0.0,0.0,1.0);
  int i = printf("float4_f_7249c===%+010.2v4hlf===%+010.2v4hlf===\n",var1,var2);
  return i;
}

int float4_f_7250c() {

  float4 var1 = (float4) (1.0,-12345.032,1.0,-12345.032);
  float4 var2 = (float4) (1.0,2.0,1.0,2.0);
  int i = printf("float4_f_7250c===%+010.3v4hlf===%+010.3v4hlf===\n",var1,var2);
  return i;
}

int float4_f_7251c() {

  float4 var1 = (float4) (2.0,0.0,0.0,1.0);
  float4 var2 = (float4) (0.0,-12345.032,-12345.032,-1.23);
  int i = printf("float4_f_7251c===%+010.10v4hlf===%+010.10v4hlf===\n",var1,var2);
  return i;
}

int float4_f_7252c() {

  float4 var1 = (float4) (2.0,-12345.032,1.0,-1.23);
  float4 var2 = (float4) (0.0,-12345.032,1.0,1.0);
  int i = printf("float4_f_7252c===%+010v4hlF===%+010v4hlF===\n",var1,var2);
  return i;
}

int float4_f_7253c() {

  float4 var1 = (float4) (123455.134,0.0,2.0,-1.23);
  float4 var2 = (float4) (1.0,1.0,123455.134,2.0);
  int i = printf("float4_f_7253c===%+010.1v4hlF===%+010.1v4hlF===\n",var1,var2);
  return i;
}

int float4_f_7254c() {

  float4 var1 = (float4) (123455.134,2.0,123455.134,2.0);
  float4 var2 = (float4) (-1.23,-1.23,123455.134,1.0);
  int i = printf("float4_f_7254c===%+010.2v4hlF===%+010.2v4hlF===\n",var1,var2);
  return i;
}

int float4_f_7255c() {

  float4 var1 = (float4) (123455.134,2.0,2.0,-1.23);
  float4 var2 = (float4) (2.0,123455.134,1.0,1.0);
  int i = printf("float4_f_7255c===%+010.3v4hlF===%+010.3v4hlF===\n",var1,var2);
  return i;
}

int float4_f_7256c() {

  float4 var1 = (float4) (-12345.032,-1.23,-12345.032,123455.134);
  float4 var2 = (float4) (2.0,1.0,0.0,-12345.032);
  int i = printf("float4_f_7256c===%+010.10v4hlF===%+010.10v4hlF===\n",var1,var2);
  return i;
}

int float4_g_1177c() {

  float4 var1 = (float4) (-12345.032,0.0,-12345.032,123455.134);
  float4 var2 = (float4) (-12345.032,123455.134,-12345.032,-1.23);
  int i = printf("float4_g_1177c===%-v4hlg===%-v4hlg===\n",var1,var2);
  return i;
}

int float4_g_1178c() {

  float4 var1 = (float4) (-12345.032,-12345.032,-12345.032,-1.23);
  float4 var2 = (float4) (-1.23,-1.23,123455.134,1.0);
  int i = printf("float4_g_1178c===%-.1v4hlg===%-.1v4hlg===\n",var1,var2);
  return i;
}

int float4_g_1179c() {

  float4 var1 = (float4) (1.0,-12345.032,1.0,-1.23);
  float4 var2 = (float4) (-12345.032,0.0,0.0,-12345.032);
  int i = printf("float4_g_1179c===%-.2v4hlg===%-.2v4hlg===\n",var1,var2);
  return i;
}

int float4_g_1180c() {

  float4 var1 = (float4) (-1.23,1.0,0.0,2.0);
  float4 var2 = (float4) (123455.134,1.0,-12345.032,0.0);
  int i = printf("float4_g_1180c===%-.3v4hlg===%-.3v4hlg===\n",var1,var2);
  return i;
}

int float4_g_1181c() {

  float4 var1 = (float4) (1.0,2.0,0.0,1.0);
  float4 var2 = (float4) (-12345.032,-12345.032,123455.134,-1.23);
  int i = printf("float4_g_1181c===%-.10v4hlg===%-.10v4hlg===\n",var1,var2);
  return i;
}

int float4_g_1182c() {

  float4 var1 = (float4) (0.0,-12345.032,1.0,0.0);
  float4 var2 = (float4) (123455.134,-12345.032,-1.23,1.0);
  int i = printf("float4_g_1182c===%-v4hlG===%-v4hlG===\n",var1,var2);
  return i;
}

int float4_g_1183c() {

  float4 var1 = (float4) (2.0,-12345.032,-12345.032,0.0);
  float4 var2 = (float4) (0.0,2.0,2.0,2.0);
  int i = printf("float4_g_1183c===%-.1v4hlG===%-.1v4hlG===\n",var1,var2);
  return i;
}

int float4_g_1184c() {

  float4 var1 = (float4) (1.0,1.0,0.0,2.0);
  float4 var2 = (float4) (-12345.032,123455.134,0.0,0.0);
  int i = printf("float4_g_1184c===%-.2v4hlG===%-.2v4hlG===\n",var1,var2);
  return i;
}

int float4_g_1185c() {

  float4 var1 = (float4) (2.0,-1.23,-1.23,-1.23);
  float4 var2 = (float4) (1.0,-12345.032,2.0,1.0);
  int i = printf("float4_g_1185c===%-.3v4hlG===%-.3v4hlG===\n",var1,var2);
  return i;
}

int float4_g_1186c() {

  float4 var1 = (float4) (0.0,2.0,123455.134,0.0);
  float4 var2 = (float4) (2.0,2.0,1.0,123455.134);
  int i = printf("float4_g_1186c===%-.10v4hlG===%-.10v4hlG===\n",var1,var2);
  return i;
}

int float4_g_1937c() {

  float4 var1 = (float4) (2.0,1.0,-12345.032,123455.134);
  float4 var2 = (float4) (-12345.032,1.0,123455.134,1.0);
  int i = printf("float4_g_1937c===%+v4hlg===%+v4hlg===\n",var1,var2);
  return i;
}

int float4_g_1938c() {

  float4 var1 = (float4) (-12345.032,123455.134,2.0,-1.23);
  float4 var2 = (float4) (0.0,-12345.032,-12345.032,2.0);
  int i = printf("float4_g_1938c===%+.1v4hlg===%+.1v4hlg===\n",var1,var2);
  return i;
}

int float4_g_1939c() {

  float4 var1 = (float4) (-12345.032,0.0,-12345.032,0.0);
  float4 var2 = (float4) (-12345.032,1.0,1.0,-12345.032);
  int i = printf("float4_g_1939c===%+.2v4hlg===%+.2v4hlg===\n",var1,var2);
  return i;
}

int float4_g_1940c() {

  float4 var1 = (float4) (123455.134,-1.23,0.0,1.0);
  float4 var2 = (float4) (-12345.032,1.0,2.0,2.0);
  int i = printf("float4_g_1940c===%+.3v4hlg===%+.3v4hlg===\n",var1,var2);
  return i;
}

int float4_g_1941c() {

  float4 var1 = (float4) (-1.23,123455.134,123455.134,-12345.032);
  float4 var2 = (float4) (-1.23,-1.23,-1.23,2.0);
  int i = printf("float4_g_1941c===%+.10v4hlg===%+.10v4hlg===\n",var1,var2);
  return i;
}

int float4_g_1942c() {

  float4 var1 = (float4) (123455.134,-1.23,-1.23,123455.134);
  float4 var2 = (float4) (123455.134,-1.23,2.0,123455.134);
  int i = printf("float4_g_1942c===%+v4hlG===%+v4hlG===\n",var1,var2);
  return i;
}

int float4_g_1943c() {

  float4 var1 = (float4) (2.0,-1.23,-12345.032,-12345.032);
  float4 var2 = (float4) (-1.23,0.0,123455.134,0.0);
  int i = printf("float4_g_1943c===%+.1v4hlG===%+.1v4hlG===\n",var1,var2);
  return i;
}

int float4_g_1944c() {

  float4 var1 = (float4) (2.0,-12345.032,1.0,1.0);
  float4 var2 = (float4) (123455.134,0.0,0.0,-12345.032);
  int i = printf("float4_g_1944c===%+.2v4hlG===%+.2v4hlG===\n",var1,var2);
  return i;
}

int float4_g_1945c() {

  float4 var1 = (float4) (-12345.032,0.0,123455.134,123455.134);
  float4 var2 = (float4) (-12345.032,1.0,-1.23,2.0);
  int i = printf("float4_g_1945c===%+.3v4hlG===%+.3v4hlG===\n",var1,var2);
  return i;
}

int float4_g_1946c() {

  float4 var1 = (float4) (-1.23,1.0,0.0,0.0);
  float4 var2 = (float4) (2.0,-1.23,1.0,0.0);
  int i = printf("float4_g_1946c===%+.10v4hlG===%+.10v4hlG===\n",var1,var2);
  return i;
}

int float4_g_2697c() {

  float4 var1 = (float4) (-12345.032,0.0,-1.23,-1.23);
  float4 var2 = (float4) (2.0,-1.23,-12345.032,1.0);
  int i = printf("float4_g_2697c===%#v4hlg===%#v4hlg===\n",var1,var2);
  return i;
}

int float4_g_2698c() {

  float4 var1 = (float4) (-12345.032,-1.23,1.0,-12345.032);
  float4 var2 = (float4) (0.0,1.0,-12345.032,123455.134);
  int i = printf("float4_g_2698c===%#.1v4hlg===%#.1v4hlg===\n",var1,var2);
  return i;
}

int float4_g_2699c() {

  float4 var1 = (float4) (1.0,0.0,123455.134,0.0);
  float4 var2 = (float4) (-1.23,-12345.032,2.0,-12345.032);
  int i = printf("float4_g_2699c===%#.2v4hlg===%#.2v4hlg===\n",var1,var2);
  return i;
}

int float4_g_2700c() {

  float4 var1 = (float4) (-12345.032,-12345.032,-1.23,-1.23);
  float4 var2 = (float4) (1.0,-1.23,-12345.032,2.0);
  int i = printf("float4_g_2700c===%#.3v4hlg===%#.3v4hlg===\n",var1,var2);
  return i;
}

int float4_g_2701c() {

  float4 var1 = (float4) (0.0,123455.134,0.0,2.0);
  float4 var2 = (float4) (0.0,-1.23,1.0,-12345.032);
  int i = printf("float4_g_2701c===%#.10v4hlg===%#.10v4hlg===\n",var1,var2);
  return i;
}

int float4_g_2702c() {

  float4 var1 = (float4) (2.0,-12345.032,0.0,1.0);
  float4 var2 = (float4) (0.0,1.0,123455.134,-12345.032);
  int i = printf("float4_g_2702c===%#v4hlG===%#v4hlG===\n",var1,var2);
  return i;
}

int float4_g_2703c() {

  float4 var1 = (float4) (-12345.032,123455.134,-1.23,-12345.032);
  float4 var2 = (float4) (0.0,1.0,2.0,-1.23);
  int i = printf("float4_g_2703c===%#.1v4hlG===%#.1v4hlG===\n",var1,var2);
  return i;
}

int float4_g_2704c() {

  float4 var1 = (float4) (123455.134,-12345.032,-12345.032,1.0);
  float4 var2 = (float4) (123455.134,1.0,0.0,2.0);
  int i = printf("float4_g_2704c===%#.2v4hlG===%#.2v4hlG===\n",var1,var2);
  return i;
}

int float4_g_2705c() {

  float4 var1 = (float4) (2.0,-1.23,123455.134,2.0);
  float4 var2 = (float4) (-1.23,0.0,-1.23,1.0);
  int i = printf("float4_g_2705c===%#.3v4hlG===%#.3v4hlG===\n",var1,var2);
  return i;
}

int float4_g_2706c() {

  float4 var1 = (float4) (0.0,2.0,2.0,0.0);
  float4 var2 = (float4) (-1.23,123455.134,123455.134,-1.23);
  int i = printf("float4_g_2706c===%#.10v4hlG===%#.10v4hlG===\n",var1,var2);
  return i;
}

int float4_g_3457c() {

  float4 var1 = (float4) (0.0,-1.23,0.0,2.0);
  float4 var2 = (float4) (-12345.032,123455.134,1.0,0.0);
  int i = printf("float4_g_3457c===%-+v4hlg===%-+v4hlg===\n",var1,var2);
  return i;
}

int float4_g_3458c() {

  float4 var1 = (float4) (1.0,1.0,1.0,2.0);
  float4 var2 = (float4) (-12345.032,2.0,1.0,-1.23);
  int i = printf("float4_g_3458c===%-+.1v4hlg===%-+.1v4hlg===\n",var1,var2);
  return i;
}

int float4_g_3459c() {

  float4 var1 = (float4) (0.0,2.0,-12345.032,2.0);
  float4 var2 = (float4) (123455.134,123455.134,0.0,0.0);
  int i = printf("float4_g_3459c===%-+.2v4hlg===%-+.2v4hlg===\n",var1,var2);
  return i;
}

int float4_g_3460c() {

  float4 var1 = (float4) (-1.23,1.0,2.0,0.0);
  float4 var2 = (float4) (1.0,-12345.032,123455.134,1.0);
  int i = printf("float4_g_3460c===%-+.3v4hlg===%-+.3v4hlg===\n",var1,var2);
  return i;
}

int float4_g_3461c() {

  float4 var1 = (float4) (1.0,1.0,1.0,-1.23);
  float4 var2 = (float4) (123455.134,1.0,123455.134,-1.23);
  int i = printf("float4_g_3461c===%-+.10v4hlg===%-+.10v4hlg===\n",var1,var2);
  return i;
}

int float4_g_3462c() {

  float4 var1 = (float4) (2.0,-12345.032,-12345.032,0.0);
  float4 var2 = (float4) (-12345.032,0.0,-12345.032,123455.134);
  int i = printf("float4_g_3462c===%-+v4hlG===%-+v4hlG===\n",var1,var2);
  return i;
}

int float4_g_3463c() {

  float4 var1 = (float4) (0.0,0.0,123455.134,2.0);
  float4 var2 = (float4) (-12345.032,123455.134,1.0,-12345.032);
  int i = printf("float4_g_3463c===%-+.1v4hlG===%-+.1v4hlG===\n",var1,var2);
  return i;
}

int float4_g_3464c() {

  float4 var1 = (float4) (0.0,2.0,-1.23,0.0);
  float4 var2 = (float4) (1.0,123455.134,2.0,2.0);
  int i = printf("float4_g_3464c===%-+.2v4hlG===%-+.2v4hlG===\n",var1,var2);
  return i;
}

int float4_g_3465c() {

  float4 var1 = (float4) (123455.134,1.0,1.0,0.0);
  float4 var2 = (float4) (-12345.032,-12345.032,123455.134,-1.23);
  int i = printf("float4_g_3465c===%-+.3v4hlG===%-+.3v4hlG===\n",var1,var2);
  return i;
}

int float4_g_3466c() {

  float4 var1 = (float4) (0.0,0.0,123455.134,-12345.032);
  float4 var2 = (float4) (0.0,1.0,1.0,0.0);
  int i = printf("float4_g_3466c===%-+.10v4hlG===%-+.10v4hlG===\n",var1,var2);
  return i;
}

int float4_g_417c() {

  float4 var1 = (float4) (-12345.032,0.0,1.0,0.0);
  float4 var2 = (float4) (-1.23,-1.23,-12345.032,-12345.032);
  int i = printf("float4_g_417c===%v4hlg===%v4hlg===\n",var1,var2);
  return i;
}

int float4_g_418c() {

  float4 var1 = (float4) (2.0,-1.23,-1.23,-1.23);
  float4 var2 = (float4) (-1.23,123455.134,2.0,1.0);
  int i = printf("float4_g_418c===%.1v4hlg===%.1v4hlg===\n",var1,var2);
  return i;
}

int float4_g_419c() {

  float4 var1 = (float4) (123455.134,123455.134,-1.23,1.0);
  float4 var2 = (float4) (2.0,-12345.032,123455.134,2.0);
  int i = printf("float4_g_419c===%.2v4hlg===%.2v4hlg===\n",var1,var2);
  return i;
}

int float4_g_420c() {

  float4 var1 = (float4) (2.0,1.0,0.0,0.0);
  float4 var2 = (float4) (2.0,123455.134,1.0,2.0);
  int i = printf("float4_g_420c===%.3v4hlg===%.3v4hlg===\n",var1,var2);
  return i;
}

int float4_g_421c() {

  float4 var1 = (float4) (2.0,0.0,-1.23,-1.23);
  float4 var2 = (float4) (-12345.032,0.0,0.0,-12345.032);
  int i = printf("float4_g_421c===%.10v4hlg===%.10v4hlg===\n",var1,var2);
  return i;
}

int float4_g_4217c() {

  float4 var1 = (float4) (2.0,-1.23,-12345.032,1.0);
  float4 var2 = (float4) (1.0,0.0,123455.134,0.0);
  int i = printf("float4_g_4217c===% 10v4hlg===% 10v4hlg===\n",var1,var2);
  return i;
}

int float4_g_4218c() {

  float4 var1 = (float4) (123455.134,0.0,0.0,-1.23);
  float4 var2 = (float4) (123455.134,1.0,1.0,123455.134);
  int i = printf("float4_g_4218c===% 10.1v4hlg===% 10.1v4hlg===\n",var1,var2);
  return i;
}

int float4_g_4219c() {

  float4 var1 = (float4) (2.0,123455.134,2.0,-12345.032);
  float4 var2 = (float4) (1.0,1.0,2.0,123455.134);
  int i = printf("float4_g_4219c===% 10.2v4hlg===% 10.2v4hlg===\n",var1,var2);
  return i;
}

int float4_g_422c() {

  float4 var1 = (float4) (1.0,0.0,2.0,2.0);
  float4 var2 = (float4) (123455.134,2.0,2.0,-12345.032);
  int i = printf("float4_g_422c===%v4hlG===%v4hlG===\n",var1,var2);
  return i;
}

int float4_g_4220c() {

  float4 var1 = (float4) (123455.134,0.0,0.0,-1.23);
  float4 var2 = (float4) (1.0,0.0,1.0,123455.134);
  int i = printf("float4_g_4220c===% 10.3v4hlg===% 10.3v4hlg===\n",var1,var2);
  return i;
}

int float4_g_4221c() {

  float4 var1 = (float4) (-12345.032,2.0,123455.134,2.0);
  float4 var2 = (float4) (-12345.032,-12345.032,2.0,-12345.032);
  int i = printf("float4_g_4221c===% 10.10v4hlg===% 10.10v4hlg===\n",var1,var2);
  return i;
}

int float4_g_4222c() {

  float4 var1 = (float4) (1.0,2.0,0.0,-12345.032);
  float4 var2 = (float4) (0.0,0.0,-12345.032,2.0);
  int i = printf("float4_g_4222c===% 10v4hlG===% 10v4hlG===\n",var1,var2);
  return i;
}

int float4_g_4223c() {

  float4 var1 = (float4) (123455.134,0.0,0.0,2.0);
  float4 var2 = (float4) (2.0,-1.23,123455.134,0.0);
  int i = printf("float4_g_4223c===% 10.1v4hlG===% 10.1v4hlG===\n",var1,var2);
  return i;
}

int float4_g_4224c() {

  float4 var1 = (float4) (123455.134,-1.23,0.0,123455.134);
  float4 var2 = (float4) (-12345.032,0.0,-1.23,2.0);
  int i = printf("float4_g_4224c===% 10.2v4hlG===% 10.2v4hlG===\n",var1,var2);
  return i;
}

int float4_g_4225c() {

  float4 var1 = (float4) (0.0,0.0,-1.23,2.0);
  float4 var2 = (float4) (-1.23,123455.134,1.0,1.0);
  int i = printf("float4_g_4225c===% 10.3v4hlG===% 10.3v4hlG===\n",var1,var2);
  return i;
}

int float4_g_4226c() {

  float4 var1 = (float4) (1.0,2.0,0.0,-1.23);
  float4 var2 = (float4) (-1.23,-1.23,0.0,-12345.032);
  int i = printf("float4_g_4226c===% 10.10v4hlG===% 10.10v4hlG===\n",var1,var2);
  return i;
}

int float4_g_423c() {

  float4 var1 = (float4) (-12345.032,2.0,2.0,-1.23);
  float4 var2 = (float4) (2.0,-1.23,123455.134,-1.23);
  int i = printf("float4_g_423c===%.1v4hlG===%.1v4hlG===\n",var1,var2);
  return i;
}

int float4_g_424c() {

  float4 var1 = (float4) (-1.23,123455.134,0.0,0.0);
  float4 var2 = (float4) (2.0,0.0,0.0,-12345.032);
  int i = printf("float4_g_424c===%.2v4hlG===%.2v4hlG===\n",var1,var2);
  return i;
}

int float4_g_425c() {

  float4 var1 = (float4) (0.0,2.0,-1.23,123455.134);
  float4 var2 = (float4) (1.0,-12345.032,-1.23,-12345.032);
  int i = printf("float4_g_425c===%.3v4hlG===%.3v4hlG===\n",var1,var2);
  return i;
}

int float4_g_426c() {

  float4 var1 = (float4) (-12345.032,2.0,1.0,123455.134);
  float4 var2 = (float4) (123455.134,-12345.032,123455.134,-12345.032);
  int i = printf("float4_g_426c===%.10v4hlG===%.10v4hlG===\n",var1,var2);
  return i;
}

int float4_g_4977c() {

  float4 var1 = (float4) (2.0,-1.23,0.0,-12345.032);
  float4 var2 = (float4) (-12345.032,2.0,0.0,2.0);
  int i = printf("float4_g_4977c===%010v4hlg===%010v4hlg===\n",var1,var2);
  return i;
}

int float4_g_4978c() {

  float4 var1 = (float4) (1.0,-1.23,0.0,123455.134);
  float4 var2 = (float4) (1.0,1.0,-1.23,123455.134);
  int i = printf("float4_g_4978c===%010.1v4hlg===%010.1v4hlg===\n",var1,var2);
  return i;
}

int float4_g_4979c() {

  float4 var1 = (float4) (-1.23,2.0,2.0,-12345.032);
  float4 var2 = (float4) (-1.23,1.0,2.0,1.0);
  int i = printf("float4_g_4979c===%010.2v4hlg===%010.2v4hlg===\n",var1,var2);
  return i;
}

int float4_g_4980c() {

  float4 var1 = (float4) (-12345.032,-12345.032,-1.23,1.0);
  float4 var2 = (float4) (1.0,2.0,-12345.032,123455.134);
  int i = printf("float4_g_4980c===%010.3v4hlg===%010.3v4hlg===\n",var1,var2);
  return i;
}

int float4_g_4981c() {

  float4 var1 = (float4) (123455.134,2.0,1.0,-1.23);
  float4 var2 = (float4) (0.0,2.0,-1.23,123455.134);
  int i = printf("float4_g_4981c===%010.10v4hlg===%010.10v4hlg===\n",var1,var2);
  return i;
}

int float4_g_4982c() {

  float4 var1 = (float4) (-12345.032,-12345.032,-12345.032,-1.23);
  float4 var2 = (float4) (-12345.032,0.0,2.0,2.0);
  int i = printf("float4_g_4982c===%010v4hlG===%010v4hlG===\n",var1,var2);
  return i;
}

int float4_g_4983c() {

  float4 var1 = (float4) (123455.134,-12345.032,2.0,123455.134);
  float4 var2 = (float4) (-12345.032,2.0,2.0,-1.23);
  int i = printf("float4_g_4983c===%010.1v4hlG===%010.1v4hlG===\n",var1,var2);
  return i;
}

int float4_g_4984c() {

  float4 var1 = (float4) (-1.23,123455.134,2.0,123455.134);
  float4 var2 = (float4) (-12345.032,2.0,0.0,123455.134);
  int i = printf("float4_g_4984c===%010.2v4hlG===%010.2v4hlG===\n",var1,var2);
  return i;
}

int float4_g_4985c() {

  float4 var1 = (float4) (0.0,-1.23,2.0,2.0);
  float4 var2 = (float4) (1.0,0.0,123455.134,-12345.032);
  int i = printf("float4_g_4985c===%010.3v4hlG===%010.3v4hlG===\n",var1,var2);
  return i;
}

int float4_g_4986c() {

  float4 var1 = (float4) (2.0,1.0,123455.134,123455.134);
  float4 var2 = (float4) (2.0,123455.134,-1.23,123455.134);
  int i = printf("float4_g_4986c===%010.10v4hlG===%010.10v4hlG===\n",var1,var2);
  return i;
}

int float4_g_5737c() {

  float4 var1 = (float4) (2.0,-12345.032,-12345.032,2.0);
  float4 var2 = (float4) (123455.134,0.0,1.0,123455.134);
  int i = printf("float4_g_5737c===%- 10v4hlg===%- 10v4hlg===\n",var1,var2);
  return i;
}

int float4_g_5738c() {

  float4 var1 = (float4) (-12345.032,1.0,-12345.032,-12345.032);
  float4 var2 = (float4) (123455.134,123455.134,2.0,0.0);
  int i = printf("float4_g_5738c===%- 10.1v4hlg===%- 10.1v4hlg===\n",var1,var2);
  return i;
}

int float4_g_5739c() {

  float4 var1 = (float4) (0.0,1.0,0.0,1.0);
  float4 var2 = (float4) (0.0,1.0,-1.23,2.0);
  int i = printf("float4_g_5739c===%- 10.2v4hlg===%- 10.2v4hlg===\n",var1,var2);
  return i;
}

int float4_g_5740c() {

  float4 var1 = (float4) (2.0,1.0,0.0,123455.134);
  float4 var2 = (float4) (-1.23,-1.23,2.0,0.0);
  int i = printf("float4_g_5740c===%- 10.3v4hlg===%- 10.3v4hlg===\n",var1,var2);
  return i;
}

int float4_g_5741c() {

  float4 var1 = (float4) (1.0,-12345.032,2.0,2.0);
  float4 var2 = (float4) (2.0,1.0,2.0,1.0);
  int i = printf("float4_g_5741c===%- 10.10v4hlg===%- 10.10v4hlg===\n",var1,var2);
  return i;
}

int float4_g_5742c() {

  float4 var1 = (float4) (0.0,2.0,1.0,2.0);
  float4 var2 = (float4) (0.0,-12345.032,0.0,2.0);
  int i = printf("float4_g_5742c===%- 10v4hlG===%- 10v4hlG===\n",var1,var2);
  return i;
}

int float4_g_5743c() {

  float4 var1 = (float4) (2.0,-12345.032,123455.134,1.0);
  float4 var2 = (float4) (0.0,0.0,123455.134,2.0);
  int i = printf("float4_g_5743c===%- 10.1v4hlG===%- 10.1v4hlG===\n",var1,var2);
  return i;
}

int float4_g_5744c() {

  float4 var1 = (float4) (1.0,2.0,1.0,0.0);
  float4 var2 = (float4) (2.0,1.0,1.0,-1.23);
  int i = printf("float4_g_5744c===%- 10.2v4hlG===%- 10.2v4hlG===\n",var1,var2);
  return i;
}

int float4_g_5745c() {

  float4 var1 = (float4) (1.0,123455.134,1.0,-12345.032);
  float4 var2 = (float4) (123455.134,0.0,2.0,-12345.032);
  int i = printf("float4_g_5745c===%- 10.3v4hlG===%- 10.3v4hlG===\n",var1,var2);
  return i;
}

int float4_g_5746c() {

  float4 var1 = (float4) (2.0,2.0,1.0,0.0);
  float4 var2 = (float4) (-12345.032,123455.134,1.0,0.0);
  int i = printf("float4_g_5746c===%- 10.10v4hlG===%- 10.10v4hlG===\n",var1,var2);
  return i;
}

int float4_g_6497c() {

  float4 var1 = (float4) (2.0,123455.134,2.0,0.0);
  float4 var2 = (float4) (123455.134,2.0,0.0,2.0);
  int i = printf("float4_g_6497c===%+ 10v4hlg===%+ 10v4hlg===\n",var1,var2);
  return i;
}

int float4_g_6498c() {

  float4 var1 = (float4) (1.0,2.0,1.0,-1.23);
  float4 var2 = (float4) (0.0,2.0,-1.23,123455.134);
  int i = printf("float4_g_6498c===%+ 10.1v4hlg===%+ 10.1v4hlg===\n",var1,var2);
  return i;
}

int float4_g_6499c() {

  float4 var1 = (float4) (1.0,-12345.032,0.0,123455.134);
  float4 var2 = (float4) (1.0,2.0,123455.134,-1.23);
  int i = printf("float4_g_6499c===%+ 10.2v4hlg===%+ 10.2v4hlg===\n",var1,var2);
  return i;
}

int float4_g_6500c() {

  float4 var1 = (float4) (2.0,123455.134,1.0,0.0);
  float4 var2 = (float4) (123455.134,1.0,-12345.032,1.0);
  int i = printf("float4_g_6500c===%+ 10.3v4hlg===%+ 10.3v4hlg===\n",var1,var2);
  return i;
}

int float4_g_6501c() {

  float4 var1 = (float4) (123455.134,123455.134,123455.134,-12345.032);
  float4 var2 = (float4) (0.0,-12345.032,2.0,0.0);
  int i = printf("float4_g_6501c===%+ 10.10v4hlg===%+ 10.10v4hlg===\n",var1,var2);
  return i;
}

int float4_g_6502c() {

  float4 var1 = (float4) (2.0,-12345.032,-1.23,-1.23);
  float4 var2 = (float4) (-12345.032,0.0,1.0,1.0);
  int i = printf("float4_g_6502c===%+ 10v4hlG===%+ 10v4hlG===\n",var1,var2);
  return i;
}

int float4_g_6503c() {

  float4 var1 = (float4) (2.0,123455.134,-12345.032,1.0);
  float4 var2 = (float4) (1.0,123455.134,0.0,2.0);
  int i = printf("float4_g_6503c===%+ 10.1v4hlG===%+ 10.1v4hlG===\n",var1,var2);
  return i;
}

int float4_g_6504c() {

  float4 var1 = (float4) (0.0,0.0,123455.134,-1.23);
  float4 var2 = (float4) (-12345.032,2.0,1.0,-1.23);
  int i = printf("float4_g_6504c===%+ 10.2v4hlG===%+ 10.2v4hlG===\n",var1,var2);
  return i;
}

int float4_g_6505c() {

  float4 var1 = (float4) (-12345.032,123455.134,123455.134,-12345.032);
  float4 var2 = (float4) (0.0,0.0,1.0,1.0);
  int i = printf("float4_g_6505c===%+ 10.3v4hlG===%+ 10.3v4hlG===\n",var1,var2);
  return i;
}

int float4_g_6506c() {

  float4 var1 = (float4) (-1.23,-12345.032,2.0,-1.23);
  float4 var2 = (float4) (123455.134,1.0,2.0,-12345.032);
  int i = printf("float4_g_6506c===%+ 10.10v4hlG===%+ 10.10v4hlG===\n",var1,var2);
  return i;
}

int float4_g_7257c() {

  float4 var1 = (float4) (123455.134,-1.23,2.0,-1.23);
  float4 var2 = (float4) (-12345.032,1.0,123455.134,1.0);
  int i = printf("float4_g_7257c===%+010v4hlg===%+010v4hlg===\n",var1,var2);
  return i;
}

int float4_g_7258c() {

  float4 var1 = (float4) (-12345.032,-12345.032,0.0,1.0);
  float4 var2 = (float4) (123455.134,123455.134,-12345.032,-12345.032);
  int i = printf("float4_g_7258c===%+010.1v4hlg===%+010.1v4hlg===\n",var1,var2);
  return i;
}

int float4_g_7259c() {

  float4 var1 = (float4) (0.0,2.0,2.0,1.0);
  float4 var2 = (float4) (0.0,-1.23,-1.23,1.0);
  int i = printf("float4_g_7259c===%+010.2v4hlg===%+010.2v4hlg===\n",var1,var2);
  return i;
}

int float4_g_7260c() {

  float4 var1 = (float4) (-1.23,-1.23,-1.23,-1.23);
  float4 var2 = (float4) (-1.23,-1.23,0.0,0.0);
  int i = printf("float4_g_7260c===%+010.3v4hlg===%+010.3v4hlg===\n",var1,var2);
  return i;
}

int float4_g_7261c() {

  float4 var1 = (float4) (0.0,2.0,-12345.032,1.0);
  float4 var2 = (float4) (-12345.032,2.0,0.0,2.0);
  int i = printf("float4_g_7261c===%+010.10v4hlg===%+010.10v4hlg===\n",var1,var2);
  return i;
}

int float4_g_7262c() {

  float4 var1 = (float4) (2.0,-1.23,0.0,-12345.032);
  float4 var2 = (float4) (123455.134,0.0,0.0,2.0);
  int i = printf("float4_g_7262c===%+010v4hlG===%+010v4hlG===\n",var1,var2);
  return i;
}

int float4_g_7263c() {

  float4 var1 = (float4) (2.0,-1.23,-12345.032,-12345.032);
  float4 var2 = (float4) (0.0,-1.23,-1.23,123455.134);
  int i = printf("float4_g_7263c===%+010.1v4hlG===%+010.1v4hlG===\n",var1,var2);
  return i;
}

int float4_g_7264c() {

  float4 var1 = (float4) (-1.23,-12345.032,1.0,-1.23);
  float4 var2 = (float4) (-1.23,-12345.032,1.0,-1.23);
  int i = printf("float4_g_7264c===%+010.2v4hlG===%+010.2v4hlG===\n",var1,var2);
  return i;
}

int float4_g_7265c() {

  float4 var1 = (float4) (-12345.032,-12345.032,123455.134,2.0);
  float4 var2 = (float4) (123455.134,0.0,-12345.032,2.0);
  int i = printf("float4_g_7265c===%+010.3v4hlG===%+010.3v4hlG===\n",var1,var2);
  return i;
}

int float4_g_7266c() {

  float4 var1 = (float4) (123455.134,2.0,2.0,123455.134);
  float4 var2 = (float4) (2.0,-1.23,-1.23,1.0);
  int i = printf("float4_g_7266c===%+010.10v4hlG===%+010.10v4hlG===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = float4_a_1147c();
i = float4_a_1148c();
i = float4_a_1149c();
i = float4_a_1150c();
i = float4_a_1151c();
i = float4_a_1152c();
i = float4_a_1153c();
i = float4_a_1154c();
i = float4_a_1155c();
i = float4_a_1156c();
i = float4_a_1907c();
i = float4_a_1908c();
i = float4_a_1909c();
i = float4_a_1910c();
i = float4_a_1911c();
i = float4_a_1912c();
i = float4_a_1913c();
i = float4_a_1914c();
i = float4_a_1915c();
i = float4_a_1916c();
i = float4_a_2667c();
i = float4_a_2668c();
i = float4_a_2669c();
i = float4_a_2670c();
i = float4_a_2671c();
i = float4_a_2672c();
i = float4_a_2673c();
i = float4_a_2674c();
i = float4_a_2675c();
i = float4_a_2676c();
i = float4_a_3427c();
i = float4_a_3428c();
i = float4_a_3429c();
i = float4_a_3430c();
i = float4_a_3431c();
i = float4_a_3432c();
i = float4_a_3433c();
i = float4_a_3434c();
i = float4_a_3435c();
i = float4_a_3436c();
i = float4_a_387c();
i = float4_a_388c();
i = float4_a_389c();
i = float4_a_390c();
i = float4_a_391c();
i = float4_a_392c();
i = float4_a_393c();
i = float4_a_394c();
i = float4_a_395c();
i = float4_a_396c();
i = float4_a_4187c();
i = float4_a_4188c();
i = float4_a_4189c();
i = float4_a_4190c();
i = float4_a_4191c();
i = float4_a_4192c();
i = float4_a_4193c();
i = float4_a_4194c();
i = float4_a_4195c();
i = float4_a_4196c();
i = float4_a_4947c();
i = float4_a_4948c();
i = float4_a_4949c();
i = float4_a_4950c();
i = float4_a_4951c();
i = float4_a_4952c();
i = float4_a_4953c();
i = float4_a_4954c();
i = float4_a_4955c();
i = float4_a_4956c();
i = float4_a_5707c();
i = float4_a_5708c();
i = float4_a_5709c();
i = float4_a_5710c();
i = float4_a_5711c();
i = float4_a_5712c();
i = float4_a_5713c();
i = float4_a_5714c();
i = float4_a_5715c();
i = float4_a_5716c();
i = float4_a_6467c();
i = float4_a_6468c();
i = float4_a_6469c();
i = float4_a_6470c();
i = float4_a_6471c();
i = float4_a_6472c();
i = float4_a_6473c();
i = float4_a_6474c();
i = float4_a_6475c();
i = float4_a_6476c();
i = float4_a_7227c();
i = float4_a_7228c();
i = float4_a_7229c();
i = float4_a_7230c();
i = float4_a_7231c();
i = float4_a_7232c();
i = float4_a_7233c();
i = float4_a_7234c();
i = float4_a_7235c();
i = float4_a_7236c();












































































































































































































































































































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
