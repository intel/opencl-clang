/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/float_a.c'  */

int float_a_10c() {
  // { dg-printf "float_a_10c===0x1.e24p+16===0x0.000p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_a_10c===%.3a===%.3a===\n",var1,var2);
  return i;
}

int float_a_100c() {
  // { dg-printf "float_a_100c===0x1.ep+16===0x0.0p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_a_100c===%.1ha===%.1ha===\n",var1,var2);
  return i;
}

int float_a_101c() {
  // { dg-printf "float_a_101c===0x1.00p+1===-0x1.3bp+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_101c===%.2ha===%.2ha===\n",var1,var2);
  return i;
}

int float_a_102c() {
  // { dg-printf "float_a_102c===0x1.e24p+16===-0x1.3aep+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_a_102c===%.3ha===%.3ha===\n",var1,var2);
  return i;
}

int float_a_103c() {
  // { dg-printf "float_a_103c===-0x1.81c8420000p+13===0x1.0000000000p+1===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_a_103c===%.10ha===%.10ha===\n",var1,var2);
  return i;
}

int float_a_104c() {
  // { dg-printf "float_a_104c===0X1.E23F220000000P+16===-0X1.81C8420000000P+13===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_104c===%hA===%hA===\n",var1,var2);
  return i;
}

int float_a_105c() {
  // { dg-printf "float_a_105c===-0X1.8P+13===-0X1.4P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_a_105c===%.1hA===%.1hA===\n",var1,var2);
  return i;
}

int float_a_106c() {
  // { dg-printf "float_a_106c===0X1.E2P+16===-0X1.82P+13===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_106c===%.2hA===%.2hA===\n",var1,var2);
  return i;
}

int float_a_107c() {
  // { dg-printf "float_a_107c===0X1.000P+0===0X0.000P+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_107c===%.3hA===%.3hA===\n",var1,var2);
  return i;
}

int float_a_108c() {
  // { dg-printf "float_a_108c===0X1.E23F220000P+16===-0X1.81C8420000P+13===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_108c===%.10hA===%.10hA===\n",var1,var2);
  return i;
}

int float_a_11c() {
  // { dg-printf "float_a_11c===0x0.0000000000p+0===0x1.0000000000p+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_11c===%.10a===%.10a===\n",var1,var2);
  return i;
}

int float_a_12c() {
  // { dg-printf "float_a_12c===0X1.E23F220000000P+16===0X1.0000000000000P+1===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_a_12c===%A===%A===\n",var1,var2);
  return i;
}

int float_a_13c() {
  // { dg-printf "float_a_13c===-0X1.8P+13===0X1.0P+1===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_a_13c===%.1A===%.1A===\n",var1,var2);
  return i;
}

int float_a_14c() {
  // { dg-printf "float_a_14c===0X1.00P+0===0X1.E2P+16===" }
  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_14c===%.2A===%.2A===\n",var1,var2);
  return i;
}

int float_a_145c() {
  // { dg-printf "float_a_145c===-0x1.81c8420000000p+13===0x1.0000000000000p+1===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_a_145c===%a===%a===\n",var1,var2);
  return i;
}

int float_a_146c() {
  // { dg-printf "float_a_146c===0x1.0p+1===-0x1.4p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_146c===%.1a===%.1a===\n",var1,var2);
  return i;
}

int float_a_147c() {
  // { dg-printf "float_a_147c===0x1.e2p+16===0x0.00p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_a_147c===%.2a===%.2a===\n",var1,var2);
  return i;
}

int float_a_148c() {
  // { dg-printf "float_a_148c===-0x1.81cp+13===-0x1.3aep+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_a_148c===%.3a===%.3a===\n",var1,var2);
  return i;
}

int float_a_149c() {
  // { dg-printf "float_a_149c===0x1.0000000000p+1===0x0.0000000000p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_149c===%.10a===%.10a===\n",var1,var2);
  return i;
}

int float_a_15c() {
  // { dg-printf "float_a_15c===0X0.000P+0===0X0.000P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_15c===%.3A===%.3A===\n",var1,var2);
  return i;
}

int float_a_150c() {
  // { dg-printf "float_a_150c===0X0.0000000000000P+0===0X1.0000000000000P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_150c===%A===%A===\n",var1,var2);
  return i;
}

int float_a_151c() {
  // { dg-printf "float_a_151c===0X1.EP+16===0X1.0P+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_a_151c===%.1A===%.1A===\n",var1,var2);
  return i;
}

int float_a_152c() {
  // { dg-printf "float_a_152c===0X1.E2P+16===0X0.00P+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_a_152c===%.2A===%.2A===\n",var1,var2);
  return i;
}

int float_a_1527c() {
  // { dg-printf "float_a_1527c===+0x1.0000000000000p+1===-0x1.81c8420000000p+13===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_1527c===%+a===%+a===\n",var1,var2);
  return i;
}

int float_a_1528c() {
  // { dg-printf "float_a_1528c===-0x1.8p+13===+0x1.ep+16===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_a_1528c===%+.1a===%+.1a===\n",var1,var2);
  return i;
}

int float_a_1529c() {
  // { dg-printf "float_a_1529c===-0x1.3bp+0===+0x0.00p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_a_1529c===%+.2a===%+.2a===\n",var1,var2);
  return i;
}

int float_a_153c() {
  // { dg-printf "float_a_153c===-0X1.81CP+13===0X1.000P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_153c===%.3A===%.3A===\n",var1,var2);
  return i;
}

int float_a_1530c() {
  // { dg-printf "float_a_1530c===+0x1.000p+1===+0x1.e24p+16===" }
  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_1530c===%+.3a===%+.3a===\n",var1,var2);
  return i;
}

int float_a_1531c() {
  // { dg-printf "float_a_1531c===-0x1.3ae1480000p+0===+0x1.0000000000p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_a_1531c===%+.10a===%+.10a===\n",var1,var2);
  return i;
}

int float_a_1532c() {
  // { dg-printf "float_a_1532c===-0X1.81C8420000000P+13===-0X1.3AE1480000000P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_a_1532c===%+A===%+A===\n",var1,var2);
  return i;
}

int float_a_1533c() {
  // { dg-printf "float_a_1533c===+0X1.EP+16===-0X1.4P+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_a_1533c===%+.1A===%+.1A===\n",var1,var2);
  return i;
}

int float_a_1534c() {
  // { dg-printf "float_a_1534c===-0X1.82P+13===+0X0.00P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_a_1534c===%+.2A===%+.2A===\n",var1,var2);
  return i;
}

int float_a_1535c() {
  // { dg-printf "float_a_1535c===+0X1.000P+0===+0X1.000P+1===" }
  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_1535c===%+.3A===%+.3A===\n",var1,var2);
  return i;
}

int float_a_1536c() {
  // { dg-printf "float_a_1536c===+0X1.0000000000P+0===-0X1.81C8420000P+13===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_1536c===%+.10A===%+.10A===\n",var1,var2);
  return i;
}

int float_a_154c() {
  // { dg-printf "float_a_154c===-0X1.3AE1480000P+0===-0X1.3AE1480000P+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_a_154c===%.10A===%.10A===\n",var1,var2);
  return i;
}

int float_a_1573c() {
  // { dg-printf "float_a_1573c===-0x1.3ae1480000000p+0===-0x1.81c8420000000p+13===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_1573c===%+hha===%+hha===\n",var1,var2);
  return i;
}

int float_a_1574c() {
  // { dg-printf "float_a_1574c===+0x0.0p+0===-0x1.4p+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_1574c===%+.1hha===%+.1hha===\n",var1,var2);
  return i;
}

int float_a_1575c() {
  // { dg-printf "float_a_1575c===+0x1.00p+1===+0x0.00p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_1575c===%+.2hha===%+.2hha===\n",var1,var2);
  return i;
}

int float_a_1576c() {
  // { dg-printf "float_a_1576c===+0x1.000p+1===+0x1.000p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_1576c===%+.3hha===%+.3hha===\n",var1,var2);
  return i;
}

int float_a_1577c() {
  // { dg-printf "float_a_1577c===-0x1.3ae1480000p+0===+0x0.0000000000p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_a_1577c===%+.10hha===%+.10hha===\n",var1,var2);
  return i;
}

int float_a_1578c() {
  // { dg-printf "float_a_1578c===+0X1.E23F220000000P+16===+0X1.0000000000000P+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_a_1578c===%+hhA===%+hhA===\n",var1,var2);
  return i;
}

int float_a_1579c() {
  // { dg-printf "float_a_1579c===-0X1.8P+13===+0X0.0P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_a_1579c===%+.1hhA===%+.1hhA===\n",var1,var2);
  return i;
}

int float_a_1580c() {
  // { dg-printf "float_a_1580c===+0X0.00P+0===+0X1.00P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_1580c===%+.2hhA===%+.2hhA===\n",var1,var2);
  return i;
}

int float_a_1581c() {
  // { dg-printf "float_a_1581c===-0X1.81CP+13===-0X1.3AEP+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_a_1581c===%+.3hhA===%+.3hhA===\n",var1,var2);
  return i;
}

int float_a_1582c() {
  // { dg-printf "float_a_1582c===+0X0.0000000000P+0===+0X0.0000000000P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_1582c===%+.10hhA===%+.10hhA===\n",var1,var2);
  return i;
}

int float_a_16c() {
  // { dg-printf "float_a_16c===0X0.0000000000P+0===0X1.0000000000P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_16c===%.10A===%.10A===\n",var1,var2);
  return i;
}

int float_a_1619c() {
  // { dg-printf "float_a_1619c===+0x1.0000000000000p+0===+0x1.0000000000000p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_1619c===%+ha===%+ha===\n",var1,var2);
  return i;
}

int float_a_1620c() {
  // { dg-printf "float_a_1620c===+0x1.ep+16===+0x1.0p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_a_1620c===%+.1ha===%+.1ha===\n",var1,var2);
  return i;
}

int float_a_1621c() {
  // { dg-printf "float_a_1621c===+0x1.00p+0===+0x1.00p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_1621c===%+.2ha===%+.2ha===\n",var1,var2);
  return i;
}

int float_a_1622c() {
  // { dg-printf "float_a_1622c===+0x1.000p+0===+0x0.000p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_1622c===%+.3ha===%+.3ha===\n",var1,var2);
  return i;
}

int float_a_1623c() {
  // { dg-printf "float_a_1623c===+0x1.0000000000p+0===+0x1.0000000000p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_1623c===%+.10ha===%+.10ha===\n",var1,var2);
  return i;
}

int float_a_1624c() {
  // { dg-printf "float_a_1624c===+0X0.0000000000000P+0===+0X1.0000000000000P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_1624c===%+hA===%+hA===\n",var1,var2);
  return i;
}

int float_a_1625c() {
  // { dg-printf "float_a_1625c===-0X1.4P+0===-0X1.8P+13===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_1625c===%+.1hA===%+.1hA===\n",var1,var2);
  return i;
}

int float_a_1626c() {
  // { dg-printf "float_a_1626c===+0X1.00P+0===-0X1.82P+13===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_1626c===%+.2hA===%+.2hA===\n",var1,var2);
  return i;
}

int float_a_1627c() {
  // { dg-printf "float_a_1627c===-0X1.81CP+13===+0X1.000P+1===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_a_1627c===%+.3hA===%+.3hA===\n",var1,var2);
  return i;
}

int float_a_1628c() {
  // { dg-printf "float_a_1628c===+0X0.0000000000P+0===-0X1.81C8420000P+13===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_1628c===%+.10hA===%+.10hA===\n",var1,var2);
  return i;
}

int float_a_1665c() {
  // { dg-printf "float_a_1665c===-0x1.81c8420000000p+13===-0x1.81c8420000000p+13===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_1665c===%+a===%+a===\n",var1,var2);
  return i;
}

int float_a_1666c() {
  // { dg-printf "float_a_1666c===-0x1.8p+13===+0x1.0p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_1666c===%+.1a===%+.1a===\n",var1,var2);
  return i;
}

int float_a_1667c() {
  // { dg-printf "float_a_1667c===-0x1.82p+13===-0x1.3bp+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_a_1667c===%+.2a===%+.2a===\n",var1,var2);
  return i;
}

int float_a_1668c() {
  // { dg-printf "float_a_1668c===+0x1.000p+0===+0x0.000p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_1668c===%+.3a===%+.3a===\n",var1,var2);
  return i;
}

int float_a_1669c() {
  // { dg-printf "float_a_1669c===-0x1.81c8420000p+13===-0x1.81c8420000p+13===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_1669c===%+.10a===%+.10a===\n",var1,var2);
  return i;
}

int float_a_1670c() {
  // { dg-printf "float_a_1670c===+0X1.E23F220000000P+16===+0X1.E23F220000000P+16===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_a_1670c===%+A===%+A===\n",var1,var2);
  return i;
}

int float_a_1671c() {
  // { dg-printf "float_a_1671c===+0X1.0P+0===+0X1.0P+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_1671c===%+.1A===%+.1A===\n",var1,var2);
  return i;
}

int float_a_1672c() {
  // { dg-printf "float_a_1672c===-0X1.3BP+0===+0X1.E2P+16===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_a_1672c===%+.2A===%+.2A===\n",var1,var2);
  return i;
}

int float_a_1673c() {
  // { dg-printf "float_a_1673c===-0X1.81CP+13===+0X1.E24P+16===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_a_1673c===%+.3A===%+.3A===\n",var1,var2);
  return i;
}

int float_a_1674c() {
  // { dg-printf "float_a_1674c===+0X0.0000000000P+0===-0X1.3AE1480000P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_1674c===%+.10A===%+.10A===\n",var1,var2);
  return i;
}

int float_a_2287c() {
  // { dg-printf "float_a_2287c===0x0.0000000000000p+0===-0x1.3ae1480000000p+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_2287c===%#a===%#a===\n",var1,var2);
  return i;
}

int float_a_2288c() {
  // { dg-printf "float_a_2288c===0x1.0p+1===-0x1.4p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_2288c===%#.1a===%#.1a===\n",var1,var2);
  return i;
}

int float_a_2289c() {
  // { dg-printf "float_a_2289c===0x0.00p+0===0x1.00p+1===" }
  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_2289c===%#.2a===%#.2a===\n",var1,var2);
  return i;
}

int float_a_2290c() {
  // { dg-printf "float_a_2290c===-0x1.81cp+13===0x1.000p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_2290c===%#.3a===%#.3a===\n",var1,var2);
  return i;
}

int float_a_2291c() {
  // { dg-printf "float_a_2291c===0x0.0000000000p+0===0x1.0000000000p+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_2291c===%#.10a===%#.10a===\n",var1,var2);
  return i;
}

int float_a_2292c() {
  // { dg-printf "float_a_2292c===0X1.0000000000000P+1===-0X1.81C8420000000P+13===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_2292c===%#A===%#A===\n",var1,var2);
  return i;
}

int float_a_2293c() {
  // { dg-printf "float_a_2293c===0X1.0P+1===-0X1.4P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_2293c===%#.1A===%#.1A===\n",var1,var2);
  return i;
}

int float_a_2294c() {
  // { dg-printf "float_a_2294c===0X0.00P+0===-0X1.82P+13===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_2294c===%#.2A===%#.2A===\n",var1,var2);
  return i;
}

int float_a_2295c() {
  // { dg-printf "float_a_2295c===0X1.000P+1===-0X1.81CP+13===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_2295c===%#.3A===%#.3A===\n",var1,var2);
  return i;
}

int float_a_2296c() {
  // { dg-printf "float_a_2296c===0X1.0000000000P+1===0X1.0000000000P+1===" }
  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_2296c===%#.10A===%#.10A===\n",var1,var2);
  return i;
}

int float_a_2333c() {
  // { dg-printf "float_a_2333c===0x1.0000000000000p+0===-0x1.3ae1480000000p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_2333c===%#hha===%#hha===\n",var1,var2);
  return i;
}

int float_a_2334c() {
  // { dg-printf "float_a_2334c===0x0.0p+0===0x1.0p+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_2334c===%#.1hha===%#.1hha===\n",var1,var2);
  return i;
}

int float_a_2335c() {
  // { dg-printf "float_a_2335c===0x1.00p+0===0x1.00p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_2335c===%#.2hha===%#.2hha===\n",var1,var2);
  return i;
}

int float_a_2336c() {
  // { dg-printf "float_a_2336c===-0x1.3aep+0===-0x1.3aep+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_a_2336c===%#.3hha===%#.3hha===\n",var1,var2);
  return i;
}

int float_a_2337c() {
  // { dg-printf "float_a_2337c===0x1.0000000000p+1===0x1.e23f220000p+16===" }
  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_2337c===%#.10hha===%#.10hha===\n",var1,var2);
  return i;
}

int float_a_2338c() {
  // { dg-printf "float_a_2338c===0X0.0000000000000P+0===0X0.0000000000000P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_2338c===%#hhA===%#hhA===\n",var1,var2);
  return i;
}

int float_a_2339c() {
  // { dg-printf "float_a_2339c===0X1.0P+1===0X0.0P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_2339c===%#.1hhA===%#.1hhA===\n",var1,var2);
  return i;
}

int float_a_2340c() {
  // { dg-printf "float_a_2340c===0X0.00P+0===0X1.E2P+16===" }
  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_2340c===%#.2hhA===%#.2hhA===\n",var1,var2);
  return i;
}

int float_a_2341c() {
  // { dg-printf "float_a_2341c===0X1.000P+1===0X1.000P+1===" }
  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_2341c===%#.3hhA===%#.3hhA===\n",var1,var2);
  return i;
}

int float_a_2342c() {
  // { dg-printf "float_a_2342c===0X1.0000000000P+1===0X1.E23F220000P+16===" }
  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_2342c===%#.10hhA===%#.10hhA===\n",var1,var2);
  return i;
}

int float_a_2379c() {
  // { dg-printf "float_a_2379c===0x0.0000000000000p+0===0x0.0000000000000p+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_2379c===%#ha===%#ha===\n",var1,var2);
  return i;
}

int float_a_2380c() {
  // { dg-printf "float_a_2380c===0x1.ep+16===-0x1.8p+13===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_2380c===%#.1ha===%#.1ha===\n",var1,var2);
  return i;
}

int float_a_2381c() {
  // { dg-printf "float_a_2381c===0x1.00p+1===-0x1.82p+13===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_2381c===%#.2ha===%#.2ha===\n",var1,var2);
  return i;
}

int float_a_2382c() {
  // { dg-printf "float_a_2382c===-0x1.3aep+0===-0x1.3aep+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_a_2382c===%#.3ha===%#.3ha===\n",var1,var2);
  return i;
}

int float_a_2383c() {
  // { dg-printf "float_a_2383c===-0x1.3ae1480000p+0===0x1.0000000000p+1===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_a_2383c===%#.10ha===%#.10ha===\n",var1,var2);
  return i;
}

int float_a_2384c() {
  // { dg-printf "float_a_2384c===0X0.0000000000000P+0===0X1.0000000000000P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_2384c===%#hA===%#hA===\n",var1,var2);
  return i;
}

int float_a_2385c() {
  // { dg-printf "float_a_2385c===0X1.0P+0===0X1.0P+1===" }
  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_2385c===%#.1hA===%#.1hA===\n",var1,var2);
  return i;
}

int float_a_2386c() {
  // { dg-printf "float_a_2386c===-0X1.82P+13===0X1.00P+1===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_a_2386c===%#.2hA===%#.2hA===\n",var1,var2);
  return i;
}

int float_a_2387c() {
  // { dg-printf "float_a_2387c===-0X1.81CP+13===0X1.E24P+16===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_a_2387c===%#.3hA===%#.3hA===\n",var1,var2);
  return i;
}

int float_a_2388c() {
  // { dg-printf "float_a_2388c===-0X1.3AE1480000P+0===0X1.0000000000P+1===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_a_2388c===%#.10hA===%#.10hA===\n",var1,var2);
  return i;
}

int float_a_2425c() {
  // { dg-printf "float_a_2425c===-0x1.3ae1480000000p+0===0x0.0000000000000p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_a_2425c===%#a===%#a===\n",var1,var2);
  return i;
}

int float_a_2426c() {
  // { dg-printf "float_a_2426c===-0x1.8p+13===0x1.ep+16===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_a_2426c===%#.1a===%#.1a===\n",var1,var2);
  return i;
}

int float_a_2427c() {
  // { dg-printf "float_a_2427c===-0x1.3bp+0===0x1.e2p+16===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_a_2427c===%#.2a===%#.2a===\n",var1,var2);
  return i;
}

int float_a_2428c() {
  // { dg-printf "float_a_2428c===-0x1.81cp+13===-0x1.81cp+13===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_2428c===%#.3a===%#.3a===\n",var1,var2);
  return i;
}

int float_a_2429c() {
  // { dg-printf "float_a_2429c===0x1.0000000000p+1===0x0.0000000000p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_2429c===%#.10a===%#.10a===\n",var1,var2);
  return i;
}

int float_a_2430c() {
  // { dg-printf "float_a_2430c===-0X1.81C8420000000P+13===0X1.E23F220000000P+16===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_a_2430c===%#A===%#A===\n",var1,var2);
  return i;
}

int float_a_2431c() {
  // { dg-printf "float_a_2431c===0X1.EP+16===0X0.0P+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_a_2431c===%#.1A===%#.1A===\n",var1,var2);
  return i;
}

int float_a_2432c() {
  // { dg-printf "float_a_2432c===0X0.00P+0===0X1.E2P+16===" }
  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_2432c===%#.2A===%#.2A===\n",var1,var2);
  return i;
}

int float_a_2433c() {
  // { dg-printf "float_a_2433c===0X1.E24P+16===-0X1.81CP+13===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_2433c===%#.3A===%#.3A===\n",var1,var2);
  return i;
}

int float_a_2434c() {
  // { dg-printf "float_a_2434c===0X1.E23F220000P+16===0X0.0000000000P+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_a_2434c===%#.10A===%#.10A===\n",var1,var2);
  return i;
}

int float_a_3047c() {
  // { dg-printf "float_a_3047c===-0x1.3ae1480000000p+0===+0x1.e23f220000000p+16===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_a_3047c===%-+a===%-+a===\n",var1,var2);
  return i;
}

int float_a_3048c() {
  // { dg-printf "float_a_3048c===-0x1.8p+13===+0x1.0p+1===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_a_3048c===%-+.1a===%-+.1a===\n",var1,var2);
  return i;
}

int float_a_3049c() {
  // { dg-printf "float_a_3049c===+0x1.00p+1===-0x1.3bp+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_3049c===%-+.2a===%-+.2a===\n",var1,var2);
  return i;
}

int float_a_3050c() {
  // { dg-printf "float_a_3050c===+0x1.000p+1===-0x1.3aep+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_3050c===%-+.3a===%-+.3a===\n",var1,var2);
  return i;
}

int float_a_3051c() {
  // { dg-printf "float_a_3051c===-0x1.3ae1480000p+0===+0x1.0000000000p+1===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_a_3051c===%-+.10a===%-+.10a===\n",var1,var2);
  return i;
}

int float_a_3052c() {
  // { dg-printf "float_a_3052c===+0X1.E23F220000000P+16===-0X1.3AE1480000000P+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_a_3052c===%-+A===%-+A===\n",var1,var2);
  return i;
}

int float_a_3053c() {
  // { dg-printf "float_a_3053c===-0X1.8P+13===+0X0.0P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_a_3053c===%-+.1A===%-+.1A===\n",var1,var2);
  return i;
}

int float_a_3054c() {
  // { dg-printf "float_a_3054c===-0X1.3BP+0===-0X1.82P+13===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3054c===%-+.2A===%-+.2A===\n",var1,var2);
  return i;
}

int float_a_3055c() {
  // { dg-printf "float_a_3055c===-0X1.3AEP+0===+0X1.E24P+16===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_a_3055c===%-+.3A===%-+.3A===\n",var1,var2);
  return i;
}

int float_a_3056c() {
  // { dg-printf "float_a_3056c===-0X1.81C8420000P+13===+0X1.0000000000P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_3056c===%-+.10A===%-+.10A===\n",var1,var2);
  return i;
}

int float_a_3093c() {
  // { dg-printf "float_a_3093c===-0x1.81c8420000000p+13===+0x1.0000000000000p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_3093c===%-+hha===%-+hha===\n",var1,var2);
  return i;
}

int float_a_3094c() {
  // { dg-printf "float_a_3094c===+0x1.ep+16===+0x0.0p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_a_3094c===%-+.1hha===%-+.1hha===\n",var1,var2);
  return i;
}

int float_a_3095c() {
  // { dg-printf "float_a_3095c===+0x0.00p+0===-0x1.82p+13===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3095c===%-+.2hha===%-+.2hha===\n",var1,var2);
  return i;
}

int float_a_3096c() {
  // { dg-printf "float_a_3096c===+0x1.000p+0===-0x1.3aep+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_3096c===%-+.3hha===%-+.3hha===\n",var1,var2);
  return i;
}

int float_a_3097c() {
  // { dg-printf "float_a_3097c===+0x1.0000000000p+0===-0x1.3ae1480000p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_3097c===%-+.10hha===%-+.10hha===\n",var1,var2);
  return i;
}

int float_a_3098c() {
  // { dg-printf "float_a_3098c===+0X1.0000000000000P+0===+0X0.0000000000000P+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_3098c===%-+hhA===%-+hhA===\n",var1,var2);
  return i;
}

int float_a_3099c() {
  // { dg-printf "float_a_3099c===-0X1.4P+0===+0X1.0P+1===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_a_3099c===%-+.1hhA===%-+.1hhA===\n",var1,var2);
  return i;
}

int float_a_3100c() {
  // { dg-printf "float_a_3100c===-0X1.82P+13===+0X0.00P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_a_3100c===%-+.2hhA===%-+.2hhA===\n",var1,var2);
  return i;
}

int float_a_3101c() {
  // { dg-printf "float_a_3101c===-0X1.81CP+13===-0X1.81CP+13===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3101c===%-+.3hhA===%-+.3hhA===\n",var1,var2);
  return i;
}

int float_a_3102c() {
  // { dg-printf "float_a_3102c===+0X1.0000000000P+0===+0X1.0000000000P+1===" }
  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_3102c===%-+.10hhA===%-+.10hhA===\n",var1,var2);
  return i;
}

int float_a_3139c() {
  // { dg-printf "float_a_3139c===-0x1.81c8420000000p+13===+0x1.0000000000000p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_3139c===%-+ha===%-+ha===\n",var1,var2);
  return i;
}

int float_a_3140c() {
  // { dg-printf "float_a_3140c===+0x1.ep+16===-0x1.4p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_a_3140c===%-+.1ha===%-+.1ha===\n",var1,var2);
  return i;
}

int float_a_3141c() {
  // { dg-printf "float_a_3141c===-0x1.82p+13===-0x1.82p+13===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3141c===%-+.2ha===%-+.2ha===\n",var1,var2);
  return i;
}

int float_a_3142c() {
  // { dg-printf "float_a_3142c===+0x1.000p+1===+0x0.000p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_3142c===%-+.3ha===%-+.3ha===\n",var1,var2);
  return i;
}

int float_a_3143c() {
  // { dg-printf "float_a_3143c===+0x1.0000000000p+1===+0x1.0000000000p+1===" }
  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_3143c===%-+.10ha===%-+.10ha===\n",var1,var2);
  return i;
}

int float_a_3144c() {
  // { dg-printf "float_a_3144c===+0X1.E23F220000000P+16===+0X1.0000000000000P+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_a_3144c===%-+hA===%-+hA===\n",var1,var2);
  return i;
}

int float_a_3145c() {
  // { dg-printf "float_a_3145c===-0X1.8P+13===+0X1.0P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_3145c===%-+.1hA===%-+.1hA===\n",var1,var2);
  return i;
}

int float_a_3146c() {
  // { dg-printf "float_a_3146c===-0X1.3BP+0===-0X1.3BP+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_a_3146c===%-+.2hA===%-+.2hA===\n",var1,var2);
  return i;
}

int float_a_3147c() {
  // { dg-printf "float_a_3147c===+0X1.000P+0===+0X1.E24P+16===" }
  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_3147c===%-+.3hA===%-+.3hA===\n",var1,var2);
  return i;
}

int float_a_3148c() {
  // { dg-printf "float_a_3148c===+0X1.E23F220000P+16===+0X0.0000000000P+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_a_3148c===%-+.10hA===%-+.10hA===\n",var1,var2);
  return i;
}

int float_a_3185c() {
  // { dg-printf "float_a_3185c===+0x1.e23f220000000p+16===+0x0.0000000000000p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_a_3185c===%-+a===%-+a===\n",var1,var2);
  return i;
}

int float_a_3186c() {
  // { dg-printf "float_a_3186c===-0x1.4p+0===-0x1.8p+13===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3186c===%-+.1a===%-+.1a===\n",var1,var2);
  return i;
}

int float_a_3187c() {
  // { dg-printf "float_a_3187c===+0x1.00p+0===+0x0.00p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_3187c===%-+.2a===%-+.2a===\n",var1,var2);
  return i;
}

int float_a_3188c() {
  // { dg-printf "float_a_3188c===+0x1.e24p+16===-0x1.3aep+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_a_3188c===%-+.3a===%-+.3a===\n",var1,var2);
  return i;
}

int float_a_3189c() {
  // { dg-printf "float_a_3189c===+0x1.0000000000p+1===-0x1.3ae1480000p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_3189c===%-+.10a===%-+.10a===\n",var1,var2);
  return i;
}

int float_a_3190c() {
  // { dg-printf "float_a_3190c===+0X1.0000000000000P+0===-0X1.81C8420000000P+13===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3190c===%-+A===%-+A===\n",var1,var2);
  return i;
}

int float_a_3191c() {
  // { dg-printf "float_a_3191c===+0X1.0P+1===-0X1.8P+13===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3191c===%-+.1A===%-+.1A===\n",var1,var2);
  return i;
}

int float_a_3192c() {
  // { dg-printf "float_a_3192c===+0X0.00P+0===+0X0.00P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_3192c===%-+.2A===%-+.2A===\n",var1,var2);
  return i;
}

int float_a_3193c() {
  // { dg-printf "float_a_3193c===+0X1.000P+1===+0X1.E24P+16===" }
  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_3193c===%-+.3A===%-+.3A===\n",var1,var2);
  return i;
}

int float_a_3194c() {
  // { dg-printf "float_a_3194c===+0X1.0000000000P+1===+0X0.0000000000P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_3194c===%-+.10A===%-+.10A===\n",var1,var2);
  return i;
}

int float_a_3807c() {
  // { dg-printf "float_a_3807c===-0x1.3ae1480000000p+0===-0x1.81c8420000000p+13===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3807c===% 10a===% 10a===\n",var1,var2);
  return i;
}

int float_a_3808c() {
  // { dg-printf "float_a_3808c===-0x1.8p+13===  0x1.0p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_3808c===% 10.1a===% 10.1a===\n",var1,var2);
  return i;
}

int float_a_3809c() {
  // { dg-printf "float_a_3809c===-0x1.82p+13=== 0x1.00p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_3809c===% 10.2a===% 10.2a===\n",var1,var2);
  return i;
}

int float_a_3810c() {
  // { dg-printf "float_a_3810c=== 0x1.000p+1===-0x1.3aep+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_3810c===% 10.3a===% 10.3a===\n",var1,var2);
  return i;
}

int float_a_3811c() {
  // { dg-printf "float_a_3811c=== 0x1.0000000000p+0=== 0x1.0000000000p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_3811c===% 10.10a===% 10.10a===\n",var1,var2);
  return i;
}

int float_a_3812c() {
  // { dg-printf "float_a_3812c=== 0X1.E23F220000000P+16=== 0X0.0000000000000P+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_a_3812c===% 10A===% 10A===\n",var1,var2);
  return i;
}

int float_a_3813c() {
  // { dg-printf "float_a_3813c=== -0X1.4P+0===  0X1.0P+1===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_a_3813c===% 10.1A===% 10.1A===\n",var1,var2);
  return i;
}

int float_a_3814c() {
  // { dg-printf "float_a_3814c=== 0X1.E2P+16=== 0X1.00P+1===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_a_3814c===% 10.2A===% 10.2A===\n",var1,var2);
  return i;
}

int float_a_3815c() {
  // { dg-printf "float_a_3815c=== 0X1.000P+0=== 0X1.000P+1===" }
  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_3815c===% 10.3A===% 10.3A===\n",var1,var2);
  return i;
}

int float_a_3816c() {
  // { dg-printf "float_a_3816c===-0X1.3AE1480000P+0=== 0X1.E23F220000P+16===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_a_3816c===% 10.10A===% 10.10A===\n",var1,var2);
  return i;
}

int float_a_3853c() {
  // { dg-printf "float_a_3853c=== 0x1.0000000000000p+1=== 0x1.0000000000000p+1===" }
  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_3853c===% 10hha===% 10hha===\n",var1,var2);
  return i;
}

int float_a_3854c() {
  // { dg-printf "float_a_3854c===-0x1.8p+13===  0x0.0p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_a_3854c===% 10.1hha===% 10.1hha===\n",var1,var2);
  return i;
}

int float_a_3855c() {
  // { dg-printf "float_a_3855c=== 0x0.00p+0=== 0x1.e2p+16===" }
  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_3855c===% 10.2hha===% 10.2hha===\n",var1,var2);
  return i;
}

int float_a_3856c() {
  // { dg-printf "float_a_3856c=== 0x1.e24p+16=== 0x1.000p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_a_3856c===% 10.3hha===% 10.3hha===\n",var1,var2);
  return i;
}

int float_a_3857c() {
  // { dg-printf "float_a_3857c=== 0x1.0000000000p+1=== 0x1.0000000000p+1===" }
  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_3857c===% 10.10hha===% 10.10hha===\n",var1,var2);
  return i;
}

int float_a_3858c() {
  // { dg-printf "float_a_3858c=== 0X0.0000000000000P+0===-0X1.81C8420000000P+13===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3858c===% 10hhA===% 10hhA===\n",var1,var2);
  return i;
}

int float_a_3859c() {
  // { dg-printf "float_a_3859c===-0X1.8P+13===-0X1.8P+13===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3859c===% 10.1hhA===% 10.1hhA===\n",var1,var2);
  return i;
}

int float_a_3860c() {
  // { dg-printf "float_a_3860c=== 0X1.E2P+16===-0X1.82P+13===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3860c===% 10.2hhA===% 10.2hhA===\n",var1,var2);
  return i;
}

int float_a_3861c() {
  // { dg-printf "float_a_3861c===-0X1.3AEP+0=== 0X1.E24P+16===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_a_3861c===% 10.3hhA===% 10.3hhA===\n",var1,var2);
  return i;
}

int float_a_3862c() {
  // { dg-printf "float_a_3862c=== 0X1.0000000000P+0=== 0X1.0000000000P+1===" }
  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_3862c===% 10.10hhA===% 10.10hhA===\n",var1,var2);
  return i;
}

int float_a_3899c() {
  // { dg-printf "float_a_3899c===-0x1.3ae1480000000p+0===-0x1.3ae1480000000p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_a_3899c===% 10ha===% 10ha===\n",var1,var2);
  return i;
}

int float_a_3900c() {
  // { dg-printf "float_a_3900c=== 0x1.ep+16===  0x1.0p+1===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_a_3900c===% 10.1ha===% 10.1ha===\n",var1,var2);
  return i;
}

int float_a_3901c() {
  // { dg-printf "float_a_3901c=== 0x1.00p+0===-0x1.3bp+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_3901c===% 10.2ha===% 10.2ha===\n",var1,var2);
  return i;
}

int float_a_3902c() {
  // { dg-printf "float_a_3902c=== 0x1.000p+0=== 0x1.e24p+16===" }
  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_3902c===% 10.3ha===% 10.3ha===\n",var1,var2);
  return i;
}

int float_a_3903c() {
  // { dg-printf "float_a_3903c=== 0x0.0000000000p+0=== 0x1.0000000000p+1===" }
  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_3903c===% 10.10ha===% 10.10ha===\n",var1,var2);
  return i;
}

int float_a_3904c() {
  // { dg-printf "float_a_3904c=== 0X1.0000000000000P+1===-0X1.81C8420000000P+13===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3904c===% 10hA===% 10hA===\n",var1,var2);
  return i;
}

int float_a_3905c() {
  // { dg-printf "float_a_3905c===  0X0.0P+0===  0X0.0P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_3905c===% 10.1hA===% 10.1hA===\n",var1,var2);
  return i;
}

int float_a_3906c() {
  // { dg-printf "float_a_3906c===-0X1.3BP+0===-0X1.82P+13===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3906c===% 10.2hA===% 10.2hA===\n",var1,var2);
  return i;
}

int float_a_3907c() {
  // { dg-printf "float_a_3907c=== 0X1.000P+1=== 0X1.000P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_3907c===% 10.3hA===% 10.3hA===\n",var1,var2);
  return i;
}

int float_a_3908c() {
  // { dg-printf "float_a_3908c=== 0X0.0000000000P+0=== 0X1.E23F220000P+16===" }
  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_3908c===% 10.10hA===% 10.10hA===\n",var1,var2);
  return i;
}

int float_a_3945c() {
  // { dg-printf "float_a_3945c=== 0x0.0000000000000p+0=== 0x1.0000000000000p+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_3945c===% 10a===% 10a===\n",var1,var2);
  return i;
}

int float_a_3946c() {
  // { dg-printf "float_a_3946c=== 0x1.ep+16=== 0x1.ep+16===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_a_3946c===% 10.1a===% 10.1a===\n",var1,var2);
  return i;
}

int float_a_3947c() {
  // { dg-printf "float_a_3947c=== 0x1.00p+1=== 0x1.00p+1===" }
  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_3947c===% 10.2a===% 10.2a===\n",var1,var2);
  return i;
}

int float_a_3948c() {
  // { dg-printf "float_a_3948c===-0x1.3aep+0===-0x1.81cp+13===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3948c===% 10.3a===% 10.3a===\n",var1,var2);
  return i;
}

int float_a_3949c() {
  // { dg-printf "float_a_3949c=== 0x1.0000000000p+0=== 0x1.0000000000p+1===" }
  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_3949c===% 10.10a===% 10.10a===\n",var1,var2);
  return i;
}

int float_a_3950c() {
  // { dg-printf "float_a_3950c=== 0X1.0000000000000P+1===-0X1.81C8420000000P+13===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3950c===% 10A===% 10A===\n",var1,var2);
  return i;
}

int float_a_3951c() {
  // { dg-printf "float_a_3951c===  0X1.0P+1===  0X0.0P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_3951c===% 10.1A===% 10.1A===\n",var1,var2);
  return i;
}

int float_a_3952c() {
  // { dg-printf "float_a_3952c===-0X1.82P+13=== 0X1.00P+1===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_a_3952c===% 10.2A===% 10.2A===\n",var1,var2);
  return i;
}

int float_a_3953c() {
  // { dg-printf "float_a_3953c=== 0X1.000P+1=== 0X0.000P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_3953c===% 10.3A===% 10.3A===\n",var1,var2);
  return i;
}

int float_a_3954c() {
  // { dg-printf "float_a_3954c===-0X1.3AE1480000P+0===-0X1.81C8420000P+13===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_3954c===% 10.10A===% 10.10A===\n",var1,var2);
  return i;
}

int float_a_4567c() {
  // { dg-printf "float_a_4567c===0x1.e23f220000000p+16===0x0.0000000000000p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_a_4567c===%010a===%010a===\n",var1,var2);
  return i;
}

int float_a_4568c() {
  // { dg-printf "float_a_4568c===-0x01.4p+0===0x001.0p+1===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_a_4568c===%010.1a===%010.1a===\n",var1,var2);
  return i;
}

int float_a_4569c() {
  // { dg-printf "float_a_4569c===0x01.00p+1===0x00.00p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_4569c===%010.2a===%010.2a===\n",var1,var2);
  return i;
}

int float_a_4570c() {
  // { dg-printf "float_a_4570c===0x1.000p+1===-0x1.81cp+13===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_4570c===%010.3a===%010.3a===\n",var1,var2);
  return i;
}

int float_a_4571c() {
  // { dg-printf "float_a_4571c===-0x1.81c8420000p+13===0x1.0000000000p+1===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_a_4571c===%010.10a===%010.10a===\n",var1,var2);
  return i;
}

int float_a_4572c() {
  // { dg-printf "float_a_4572c===0X1.0000000000000P+1===0X1.0000000000000P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_4572c===%010A===%010A===\n",var1,var2);
  return i;
}

int float_a_4573c() {
  // { dg-printf "float_a_4573c===0X001.0P+1===0X000.0P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_4573c===%010.1A===%010.1A===\n",var1,var2);
  return i;
}

int float_a_4574c() {
  // { dg-printf "float_a_4574c===-0X1.3BP+0===-0X1.3BP+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_a_4574c===%010.2A===%010.2A===\n",var1,var2);
  return i;
}

int float_a_4575c() {
  // { dg-printf "float_a_4575c===-0X1.81CP+13===0X1.E24P+16===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_a_4575c===%010.3A===%010.3A===\n",var1,var2);
  return i;
}

int float_a_4576c() {
  // { dg-printf "float_a_4576c===0X1.0000000000P+0===0X1.0000000000P+1===" }
  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_4576c===%010.10A===%010.10A===\n",var1,var2);
  return i;
}

int float_a_4613c() {
  // { dg-printf "float_a_4613c===-0x1.3ae1480000000p+0===0x1.e23f220000000p+16===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_a_4613c===%010hha===%010hha===\n",var1,var2);
  return i;
}

int float_a_4614c() {
  // { dg-printf "float_a_4614c===-0x01.4p+0===0x001.0p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_a_4614c===%010.1hha===%010.1hha===\n",var1,var2);
  return i;
}

int float_a_4615c() {
  // { dg-printf "float_a_4615c===0x01.00p+1===0x01.00p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_4615c===%010.2hha===%010.2hha===\n",var1,var2);
  return i;
}

int float_a_4616c() {
  // { dg-printf "float_a_4616c===-0x1.81cp+13===-0x1.81cp+13===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_4616c===%010.3hha===%010.3hha===\n",var1,var2);
  return i;
}

int float_a_4617c() {
  // { dg-printf "float_a_4617c===-0x1.81c8420000p+13===0x0.0000000000p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_a_4617c===%010.10hha===%010.10hha===\n",var1,var2);
  return i;
}

int float_a_4618c() {
  // { dg-printf "float_a_4618c===-0X1.3AE1480000000P+0===0X1.0000000000000P+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_a_4618c===%010hhA===%010hhA===\n",var1,var2);
  return i;
}

int float_a_4619c() {
  // { dg-printf "float_a_4619c===0X001.0P+0===-0X01.4P+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_4619c===%010.1hhA===%010.1hhA===\n",var1,var2);
  return i;
}

int float_a_4620c() {
  // { dg-printf "float_a_4620c===0X00.00P+0===-0X1.82P+13===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_4620c===%010.2hhA===%010.2hhA===\n",var1,var2);
  return i;
}

int float_a_4621c() {
  // { dg-printf "float_a_4621c===0X1.E24P+16===-0X1.3AEP+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_a_4621c===%010.3hhA===%010.3hhA===\n",var1,var2);
  return i;
}

int float_a_4622c() {
  // { dg-printf "float_a_4622c===0X1.0000000000P+0===0X1.0000000000P+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_4622c===%010.10hhA===%010.10hhA===\n",var1,var2);
  return i;
}

int float_a_4659c() {
  // { dg-printf "float_a_4659c===0x0.0000000000000p+0===0x1.0000000000000p+1===" }
  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_4659c===%010ha===%010ha===\n",var1,var2);
  return i;
}

int float_a_4660c() {
  // { dg-printf "float_a_4660c===-0x1.8p+13===0x001.0p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_4660c===%010.1ha===%010.1ha===\n",var1,var2);
  return i;
}

int float_a_4661c() {
  // { dg-printf "float_a_4661c===-0x1.82p+13===0x01.00p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_4661c===%010.2ha===%010.2ha===\n",var1,var2);
  return i;
}

int float_a_4662c() {
  // { dg-printf "float_a_4662c===-0x1.3aep+0===-0x1.3aep+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_a_4662c===%010.3ha===%010.3ha===\n",var1,var2);
  return i;
}

int float_a_4663c() {
  // { dg-printf "float_a_4663c===0x1.e23f220000p+16===0x1.0000000000p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_a_4663c===%010.10ha===%010.10ha===\n",var1,var2);
  return i;
}

int float_a_4664c() {
  // { dg-printf "float_a_4664c===0X1.0000000000000P+1===0X0.0000000000000P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_4664c===%010hA===%010hA===\n",var1,var2);
  return i;
}

int float_a_4665c() {
  // { dg-printf "float_a_4665c===0X001.0P+0===-0X01.4P+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_4665c===%010.1hA===%010.1hA===\n",var1,var2);
  return i;
}

int float_a_4666c() {
  // { dg-printf "float_a_4666c===0X00.00P+0===0X01.00P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_4666c===%010.2hA===%010.2hA===\n",var1,var2);
  return i;
}

int float_a_4667c() {
  // { dg-printf "float_a_4667c===0X1.E24P+16===0X1.E24P+16===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_a_4667c===%010.3hA===%010.3hA===\n",var1,var2);
  return i;
}

int float_a_4668c() {
  // { dg-printf "float_a_4668c===0X1.0000000000P+1===0X1.E23F220000P+16===" }
  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_4668c===%010.10hA===%010.10hA===\n",var1,var2);
  return i;
}

int float_a_4705c() {
  // { dg-printf "float_a_4705c===0x1.0000000000000p+0===0x0.0000000000000p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_4705c===%010a===%010a===\n",var1,var2);
  return i;
}

int float_a_4706c() {
  // { dg-printf "float_a_4706c===0x000.0p+0===0x000.0p+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_4706c===%010.1a===%010.1a===\n",var1,var2);
  return i;
}

int float_a_4707c() {
  // { dg-printf "float_a_4707c===-0x1.82p+13===0x01.00p+1===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_a_4707c===%010.2a===%010.2a===\n",var1,var2);
  return i;
}

int float_a_4708c() {
  // { dg-printf "float_a_4708c===0x0.000p+0===0x1.000p+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_4708c===%010.3a===%010.3a===\n",var1,var2);
  return i;
}

int float_a_4709c() {
  // { dg-printf "float_a_4709c===0x1.0000000000p+1===-0x1.3ae1480000p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_4709c===%010.10a===%010.10a===\n",var1,var2);
  return i;
}

int float_a_4710c() {
  // { dg-printf "float_a_4710c===0X1.0000000000000P+1===0X1.0000000000000P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_4710c===%010A===%010A===\n",var1,var2);
  return i;
}

int float_a_4711c() {
  // { dg-printf "float_a_4711c===0X001.0P+1===0X01.EP+16===" }
  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_4711c===%010.1A===%010.1A===\n",var1,var2);
  return i;
}

int float_a_4712c() {
  // { dg-printf "float_a_4712c===0X1.E2P+16===-0X1.3BP+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_a_4712c===%010.2A===%010.2A===\n",var1,var2);
  return i;
}

int float_a_4713c() {
  // { dg-printf "float_a_4713c===-0X1.3AEP+0===0X1.000P+1===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_a_4713c===%010.3A===%010.3A===\n",var1,var2);
  return i;
}

int float_a_4714c() {
  // { dg-printf "float_a_4714c===0X1.0000000000P+0===0X0.0000000000P+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_4714c===%010.10A===%010.10A===\n",var1,var2);
  return i;
}

int float_a_53c() {
  // { dg-printf "float_a_53c===0x1.0000000000000p+1===0x1.e23f220000000p+16===" }
  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_53c===%hha===%hha===\n",var1,var2);
  return i;
}

int float_a_5327c() {
  // { dg-printf "float_a_5327c=== 0x1.e23f220000000p+16===-0x1.81c8420000000p+13===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_5327c===%- 10a===%- 10a===\n",var1,var2);
  return i;
}

int float_a_5328c() {
  // { dg-printf "float_a_5328c=== 0x0.0p+0 === 0x0.0p+0 ===" }
  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_5328c===%- 10.1a===%- 10.1a===\n",var1,var2);
  return i;
}

int float_a_5329c() {
  // { dg-printf "float_a_5329c=== 0x1.e2p+16=== 0x1.00p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_a_5329c===%- 10.2a===%- 10.2a===\n",var1,var2);
  return i;
}

int float_a_5330c() {
  // { dg-printf "float_a_5330c=== 0x1.000p+0=== 0x0.000p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_5330c===%- 10.3a===%- 10.3a===\n",var1,var2);
  return i;
}

int float_a_5331c() {
  // { dg-printf "float_a_5331c=== 0x1.0000000000p+0=== 0x1.0000000000p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_5331c===%- 10.10a===%- 10.10a===\n",var1,var2);
  return i;
}

int float_a_5332c() {
  // { dg-printf "float_a_5332c=== 0X1.0000000000000P+1===-0X1.3AE1480000000P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_5332c===%- 10A===%- 10A===\n",var1,var2);
  return i;
}

int float_a_5333c() {
  // { dg-printf "float_a_5333c=== 0X1.0P+0 === 0X1.0P+0 ===" }
  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_5333c===%- 10.1A===%- 10.1A===\n",var1,var2);
  return i;
}

int float_a_5334c() {
  // { dg-printf "float_a_5334c=== 0X1.00P+1===-0X1.3BP+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_5334c===%- 10.2A===%- 10.2A===\n",var1,var2);
  return i;
}

int float_a_5335c() {
  // { dg-printf "float_a_5335c=== 0X1.000P+1=== 0X1.E24P+16===" }
  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_5335c===%- 10.3A===%- 10.3A===\n",var1,var2);
  return i;
}

int float_a_5336c() {
  // { dg-printf "float_a_5336c=== 0X1.0000000000P+1=== 0X1.E23F220000P+16===" }
  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_5336c===%- 10.10A===%- 10.10A===\n",var1,var2);
  return i;
}

int float_a_5373c() {
  // { dg-printf "float_a_5373c=== 0x1.0000000000000p+1===-0x1.81c8420000000p+13===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_5373c===%- 10hha===%- 10hha===\n",var1,var2);
  return i;
}

int float_a_5374c() {
  // { dg-printf "float_a_5374c=== 0x0.0p+0 === 0x1.0p+1 ===" }
  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_5374c===%- 10.1hha===%- 10.1hha===\n",var1,var2);
  return i;
}

int float_a_5375c() {
  // { dg-printf "float_a_5375c=== 0x1.00p+1===-0x1.3bp+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_5375c===%- 10.2hha===%- 10.2hha===\n",var1,var2);
  return i;
}

int float_a_5376c() {
  // { dg-printf "float_a_5376c===-0x1.3aep+0=== 0x0.000p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_a_5376c===%- 10.3hha===%- 10.3hha===\n",var1,var2);
  return i;
}

int float_a_5377c() {
  // { dg-printf "float_a_5377c=== 0x1.0000000000p+1=== 0x1.0000000000p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_5377c===%- 10.10hha===%- 10.10hha===\n",var1,var2);
  return i;
}

int float_a_5378c() {
  // { dg-printf "float_a_5378c===-0X1.81C8420000000P+13=== 0X1.0000000000000P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_5378c===%- 10hhA===%- 10hhA===\n",var1,var2);
  return i;
}

int float_a_5379c() {
  // { dg-printf "float_a_5379c===-0X1.4P+0 === 0X1.0P+0 ===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_a_5379c===%- 10.1hhA===%- 10.1hhA===\n",var1,var2);
  return i;
}

int float_a_5380c() {
  // { dg-printf "float_a_5380c===-0X1.82P+13===-0X1.3BP+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_a_5380c===%- 10.2hhA===%- 10.2hhA===\n",var1,var2);
  return i;
}

int float_a_5381c() {
  // { dg-printf "float_a_5381c===-0X1.81CP+13=== 0X1.000P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_5381c===%- 10.3hhA===%- 10.3hhA===\n",var1,var2);
  return i;
}

int float_a_5382c() {
  // { dg-printf "float_a_5382c===-0X1.81C8420000P+13=== 0X1.0000000000P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_5382c===%- 10.10hhA===%- 10.10hhA===\n",var1,var2);
  return i;
}

int float_a_54c() {
  // { dg-printf "float_a_54c===0x1.0p+0===-0x1.8p+13===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_54c===%.1hha===%.1hha===\n",var1,var2);
  return i;
}

int float_a_5419c() {
  // { dg-printf "float_a_5419c===-0x1.81c8420000000p+13===-0x1.81c8420000000p+13===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_5419c===%- 10ha===%- 10ha===\n",var1,var2);
  return i;
}

int float_a_5420c() {
  // { dg-printf "float_a_5420c===-0x1.4p+0 ===-0x1.4p+0 ===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_a_5420c===%- 10.1ha===%- 10.1ha===\n",var1,var2);
  return i;
}

int float_a_5421c() {
  // { dg-printf "float_a_5421c=== 0x0.00p+0===-0x1.3bp+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_5421c===%- 10.2ha===%- 10.2ha===\n",var1,var2);
  return i;
}

int float_a_5422c() {
  // { dg-printf "float_a_5422c=== 0x1.000p+0=== 0x1.000p+1===" }
  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_5422c===%- 10.3ha===%- 10.3ha===\n",var1,var2);
  return i;
}

int float_a_5423c() {
  // { dg-printf "float_a_5423c===-0x1.3ae1480000p+0===-0x1.81c8420000p+13===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_5423c===%- 10.10ha===%- 10.10ha===\n",var1,var2);
  return i;
}

int float_a_5424c() {
  // { dg-printf "float_a_5424c=== 0X0.0000000000000P+0===-0X1.3AE1480000000P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_5424c===%- 10hA===%- 10hA===\n",var1,var2);
  return i;
}

int float_a_5425c() {
  // { dg-printf "float_a_5425c=== 0X1.0P+1 === 0X1.0P+0 ===" }
  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_5425c===%- 10.1hA===%- 10.1hA===\n",var1,var2);
  return i;
}

int float_a_5426c() {
  // { dg-printf "float_a_5426c=== 0X1.00P+0=== 0X1.E2P+16===" }
  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_5426c===%- 10.2hA===%- 10.2hA===\n",var1,var2);
  return i;
}

int float_a_5427c() {
  // { dg-printf "float_a_5427c===-0X1.3AEP+0=== 0X1.E24P+16===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_a_5427c===%- 10.3hA===%- 10.3hA===\n",var1,var2);
  return i;
}

int float_a_5428c() {
  // { dg-printf "float_a_5428c=== 0X0.0000000000P+0===-0X1.81C8420000P+13===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_5428c===%- 10.10hA===%- 10.10hA===\n",var1,var2);
  return i;
}

int float_a_5465c() {
  // { dg-printf "float_a_5465c===-0x1.81c8420000000p+13===-0x1.3ae1480000000p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_a_5465c===%- 10a===%- 10a===\n",var1,var2);
  return i;
}

int float_a_5466c() {
  // { dg-printf "float_a_5466c=== 0x1.ep+16=== 0x1.ep+16===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_a_5466c===%- 10.1a===%- 10.1a===\n",var1,var2);
  return i;
}

int float_a_5467c() {
  // { dg-printf "float_a_5467c===-0x1.3bp+0=== 0x1.00p+1===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_a_5467c===%- 10.2a===%- 10.2a===\n",var1,var2);
  return i;
}

int float_a_5468c() {
  // { dg-printf "float_a_5468c===-0x1.3aep+0=== 0x0.000p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_a_5468c===%- 10.3a===%- 10.3a===\n",var1,var2);
  return i;
}

int float_a_5469c() {
  // { dg-printf "float_a_5469c===-0x1.81c8420000p+13=== 0x1.0000000000p+1===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_a_5469c===%- 10.10a===%- 10.10a===\n",var1,var2);
  return i;
}

int float_a_5470c() {
  // { dg-printf "float_a_5470c=== 0X1.0000000000000P+1=== 0X1.0000000000000P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_5470c===%- 10A===%- 10A===\n",var1,var2);
  return i;
}

int float_a_5471c() {
  // { dg-printf "float_a_5471c=== 0X1.EP+16=== 0X1.0P+1 ===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_a_5471c===%- 10.1A===%- 10.1A===\n",var1,var2);
  return i;
}

int float_a_5472c() {
  // { dg-printf "float_a_5472c===-0X1.82P+13=== 0X1.E2P+16===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_a_5472c===%- 10.2A===%- 10.2A===\n",var1,var2);
  return i;
}

int float_a_5473c() {
  // { dg-printf "float_a_5473c=== 0X0.000P+0=== 0X1.000P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_5473c===%- 10.3A===%- 10.3A===\n",var1,var2);
  return i;
}

int float_a_5474c() {
  // { dg-printf "float_a_5474c=== 0X1.0000000000P+0=== 0X1.0000000000P+1===" }
  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_5474c===%- 10.10A===%- 10.10A===\n",var1,var2);
  return i;
}

int float_a_55c() {
  // { dg-printf "float_a_55c===0x1.00p+0===-0x1.3bp+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_55c===%.2hha===%.2hha===\n",var1,var2);
  return i;
}

int float_a_56c() {
  // { dg-printf "float_a_56c===-0x1.3aep+0===0x1.000p+1===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_a_56c===%.3hha===%.3hha===\n",var1,var2);
  return i;
}

int float_a_57c() {
  // { dg-printf "float_a_57c===0x1.0000000000p+0===-0x1.3ae1480000p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_57c===%.10hha===%.10hha===\n",var1,var2);
  return i;
}

int float_a_58c() {
  // { dg-printf "float_a_58c===0X1.E23F220000000P+16===0X1.E23F220000000P+16===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_a_58c===%hhA===%hhA===\n",var1,var2);
  return i;
}

int float_a_59c() {
  // { dg-printf "float_a_59c===0X1.0P+1===0X1.0P+1===" }
  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_59c===%.1hhA===%.1hhA===\n",var1,var2);
  return i;
}

int float_a_60c() {
  // { dg-printf "float_a_60c===0X0.00P+0===0X0.00P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_60c===%.2hhA===%.2hhA===\n",var1,var2);
  return i;
}

int float_a_6087c() {
  // { dg-printf "float_a_6087c===+0x1.0000000000000p+1===+0x1.0000000000000p+1===" }
  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_6087c===%+ 10a===%+ 10a===\n",var1,var2);
  return i;
}

int float_a_6088c() {
  // { dg-printf "float_a_6088c=== -0x1.4p+0===+0x1.ep+16===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_a_6088c===%+ 10.1a===%+ 10.1a===\n",var1,var2);
  return i;
}

int float_a_6089c() {
  // { dg-printf "float_a_6089c===-0x1.3bp+0===+0x1.00p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_a_6089c===%+ 10.2a===%+ 10.2a===\n",var1,var2);
  return i;
}

int float_a_6090c() {
  // { dg-printf "float_a_6090c===+0x1.000p+1===+0x1.000p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_6090c===%+ 10.3a===%+ 10.3a===\n",var1,var2);
  return i;
}

int float_a_6091c() {
  // { dg-printf "float_a_6091c===+0x1.0000000000p+0===-0x1.81c8420000p+13===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_6091c===%+ 10.10a===%+ 10.10a===\n",var1,var2);
  return i;
}

int float_a_6092c() {
  // { dg-printf "float_a_6092c===+0X1.0000000000000P+0===+0X1.E23F220000000P+16===" }
  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_6092c===%+ 10A===%+ 10A===\n",var1,var2);
  return i;
}

int float_a_6093c() {
  // { dg-printf "float_a_6093c=== -0X1.4P+0=== -0X1.4P+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_a_6093c===%+ 10.1A===%+ 10.1A===\n",var1,var2);
  return i;
}

int float_a_6094c() {
  // { dg-printf "float_a_6094c===-0X1.3BP+0===-0X1.82P+13===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_6094c===%+ 10.2A===%+ 10.2A===\n",var1,var2);
  return i;
}

int float_a_6095c() {
  // { dg-printf "float_a_6095c===-0X1.3AEP+0===+0X1.000P+1===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_a_6095c===%+ 10.3A===%+ 10.3A===\n",var1,var2);
  return i;
}

int float_a_6096c() {
  // { dg-printf "float_a_6096c===+0X1.0000000000P+1===+0X1.0000000000P+1===" }
  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_6096c===%+ 10.10A===%+ 10.10A===\n",var1,var2);
  return i;
}

int float_a_61c() {
  // { dg-printf "float_a_61c===-0X1.81CP+13===0X1.000P+1===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_a_61c===%.3hhA===%.3hhA===\n",var1,var2);
  return i;
}

int float_a_6133c() {
  // { dg-printf "float_a_6133c===+0x1.0000000000000p+1===+0x1.e23f220000000p+16===" }
  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_6133c===%+ 10hha===%+ 10hha===\n",var1,var2);
  return i;
}

int float_a_6134c() {
  // { dg-printf "float_a_6134c===-0x1.8p+13=== +0x1.0p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_6134c===%+ 10.1hha===%+ 10.1hha===\n",var1,var2);
  return i;
}

int float_a_6135c() {
  // { dg-printf "float_a_6135c===-0x1.3bp+0===+0x1.00p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_a_6135c===%+ 10.2hha===%+ 10.2hha===\n",var1,var2);
  return i;
}

int float_a_6136c() {
  // { dg-printf "float_a_6136c===-0x1.81cp+13===+0x1.000p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_6136c===%+ 10.3hha===%+ 10.3hha===\n",var1,var2);
  return i;
}

int float_a_6137c() {
  // { dg-printf "float_a_6137c===-0x1.3ae1480000p+0===+0x0.0000000000p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_a_6137c===%+ 10.10hha===%+ 10.10hha===\n",var1,var2);
  return i;
}

int float_a_6138c() {
  // { dg-printf "float_a_6138c===-0X1.3AE1480000000P+0===+0X1.0000000000000P+1===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_a_6138c===%+ 10hhA===%+ 10hhA===\n",var1,var2);
  return i;
}

int float_a_6139c() {
  // { dg-printf "float_a_6139c=== +0X1.0P+1=== +0X0.0P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_6139c===%+ 10.1hhA===%+ 10.1hhA===\n",var1,var2);
  return i;
}

int float_a_6140c() {
  // { dg-printf "float_a_6140c===+0X1.00P+0===-0X1.3BP+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_6140c===%+ 10.2hhA===%+ 10.2hhA===\n",var1,var2);
  return i;
}

int float_a_6141c() {
  // { dg-printf "float_a_6141c===+0X1.000P+1===+0X1.E24P+16===" }
  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_6141c===%+ 10.3hhA===%+ 10.3hhA===\n",var1,var2);
  return i;
}

int float_a_6142c() {
  // { dg-printf "float_a_6142c===-0X1.81C8420000P+13===+0X1.0000000000P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_6142c===%+ 10.10hhA===%+ 10.10hhA===\n",var1,var2);
  return i;
}

int float_a_6179c() {
  // { dg-printf "float_a_6179c===+0x1.0000000000000p+1===+0x1.0000000000000p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_6179c===%+ 10ha===%+ 10ha===\n",var1,var2);
  return i;
}

int float_a_6180c() {
  // { dg-printf "float_a_6180c===+0x1.ep+16=== -0x1.4p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_a_6180c===%+ 10.1ha===%+ 10.1ha===\n",var1,var2);
  return i;
}

int float_a_6181c() {
  // { dg-printf "float_a_6181c===+0x0.00p+0===-0x1.82p+13===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_6181c===%+ 10.2ha===%+ 10.2ha===\n",var1,var2);
  return i;
}

int float_a_6182c() {
  // { dg-printf "float_a_6182c===+0x1.000p+0===-0x1.81cp+13===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_6182c===%+ 10.3ha===%+ 10.3ha===\n",var1,var2);
  return i;
}

int float_a_6183c() {
  // { dg-printf "float_a_6183c===+0x1.0000000000p+1===-0x1.81c8420000p+13===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_6183c===%+ 10.10ha===%+ 10.10ha===\n",var1,var2);
  return i;
}

int float_a_6184c() {
  // { dg-printf "float_a_6184c===+0X1.0000000000000P+1===-0X1.81C8420000000P+13===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_6184c===%+ 10hA===%+ 10hA===\n",var1,var2);
  return i;
}

int float_a_6185c() {
  // { dg-printf "float_a_6185c===-0X1.8P+13===+0X1.EP+16===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_a_6185c===%+ 10.1hA===%+ 10.1hA===\n",var1,var2);
  return i;
}

int float_a_6186c() {
  // { dg-printf "float_a_6186c===-0X1.3BP+0===+0X1.E2P+16===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_a_6186c===%+ 10.2hA===%+ 10.2hA===\n",var1,var2);
  return i;
}

int float_a_6187c() {
  // { dg-printf "float_a_6187c===+0X1.000P+0===+0X1.000P+1===" }
  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_6187c===%+ 10.3hA===%+ 10.3hA===\n",var1,var2);
  return i;
}

int float_a_6188c() {
  // { dg-printf "float_a_6188c===-0X1.81C8420000P+13===+0X1.E23F220000P+16===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_a_6188c===%+ 10.10hA===%+ 10.10hA===\n",var1,var2);
  return i;
}

int float_a_62c() {
  // { dg-printf "float_a_62c===0X1.0000000000P+1===-0X1.3AE1480000P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_62c===%.10hhA===%.10hhA===\n",var1,var2);
  return i;
}

int float_a_6225c() {
  // { dg-printf "float_a_6225c===-0x1.81c8420000000p+13===+0x1.0000000000000p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_6225c===%+ 10a===%+ 10a===\n",var1,var2);
  return i;
}

int float_a_6226c() {
  // { dg-printf "float_a_6226c=== +0x1.0p+0=== +0x1.0p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_6226c===%+ 10.1a===%+ 10.1a===\n",var1,var2);
  return i;
}

int float_a_6227c() {
  // { dg-printf "float_a_6227c===+0x0.00p+0===+0x1.00p+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_6227c===%+ 10.2a===%+ 10.2a===\n",var1,var2);
  return i;
}

int float_a_6228c() {
  // { dg-printf "float_a_6228c===-0x1.3aep+0===+0x0.000p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_a_6228c===%+ 10.3a===%+ 10.3a===\n",var1,var2);
  return i;
}

int float_a_6229c() {
  // { dg-printf "float_a_6229c===-0x1.81c8420000p+13===+0x1.0000000000p+1===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_a_6229c===%+ 10.10a===%+ 10.10a===\n",var1,var2);
  return i;
}

int float_a_6230c() {
  // { dg-printf "float_a_6230c===+0X1.0000000000000P+1===+0X0.0000000000000P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_6230c===%+ 10A===%+ 10A===\n",var1,var2);
  return i;
}

int float_a_6231c() {
  // { dg-printf "float_a_6231c=== +0X0.0P+0=== +0X0.0P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_6231c===%+ 10.1A===%+ 10.1A===\n",var1,var2);
  return i;
}

int float_a_6232c() {
  // { dg-printf "float_a_6232c===+0X1.00P+1===+0X1.00P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_6232c===%+ 10.2A===%+ 10.2A===\n",var1,var2);
  return i;
}

int float_a_6233c() {
  // { dg-printf "float_a_6233c===-0X1.81CP+13===+0X0.000P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_a_6233c===%+ 10.3A===%+ 10.3A===\n",var1,var2);
  return i;
}

int float_a_6234c() {
  // { dg-printf "float_a_6234c===+0X1.E23F220000P+16===+0X1.0000000000P+1===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_a_6234c===%+ 10.10A===%+ 10.10A===\n",var1,var2);
  return i;
}

int float_a_6847c() {
  // { dg-printf "float_a_6847c===+0x1.e23f220000000p+16===+0x1.0000000000000p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_a_6847c===%+010a===%+010a===\n",var1,var2);
  return i;
}

int float_a_6848c() {
  // { dg-printf "float_a_6848c===-0x01.4p+0===+0x00.0p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_a_6848c===%+010.1a===%+010.1a===\n",var1,var2);
  return i;
}

int float_a_6849c() {
  // { dg-printf "float_a_6849c===+0x1.00p+1===+0x0.00p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_6849c===%+010.2a===%+010.2a===\n",var1,var2);
  return i;
}

int float_a_6850c() {
  // { dg-printf "float_a_6850c===+0x0.000p+0===+0x1.000p+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_6850c===%+010.3a===%+010.3a===\n",var1,var2);
  return i;
}

int float_a_6851c() {
  // { dg-printf "float_a_6851c===-0x1.3ae1480000p+0===+0x1.0000000000p+1===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_a_6851c===%+010.10a===%+010.10a===\n",var1,var2);
  return i;
}

int float_a_6852c() {
  // { dg-printf "float_a_6852c===-0X1.3AE1480000000P+0===+0X1.0000000000000P+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_a_6852c===%+010A===%+010A===\n",var1,var2);
  return i;
}

int float_a_6853c() {
  // { dg-printf "float_a_6853c===+0X00.0P+0===+0X01.0P+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_6853c===%+010.1A===%+010.1A===\n",var1,var2);
  return i;
}

int float_a_6854c() {
  // { dg-printf "float_a_6854c===-0X1.82P+13===+0X1.00P+1===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_a_6854c===%+010.2A===%+010.2A===\n",var1,var2);
  return i;
}

int float_a_6855c() {
  // { dg-printf "float_a_6855c===+0X1.E24P+16===+0X0.000P+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_a_6855c===%+010.3A===%+010.3A===\n",var1,var2);
  return i;
}

int float_a_6856c() {
  // { dg-printf "float_a_6856c===+0X0.0000000000P+0===-0X1.81C8420000P+13===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_6856c===%+010.10A===%+010.10A===\n",var1,var2);
  return i;
}

int float_a_6893c() {
  // { dg-printf "float_a_6893c===+0x1.e23f220000000p+16===-0x1.3ae1480000000p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_a_6893c===%+010hha===%+010hha===\n",var1,var2);
  return i;
}

int float_a_6894c() {
  // { dg-printf "float_a_6894c===-0x01.4p+0===+0x01.0p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_a_6894c===%+010.1hha===%+010.1hha===\n",var1,var2);
  return i;
}

int float_a_6895c() {
  // { dg-printf "float_a_6895c===+0x1.00p+0===-0x1.82p+13===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_6895c===%+010.2hha===%+010.2hha===\n",var1,var2);
  return i;
}

int float_a_6896c() {
  // { dg-printf "float_a_6896c===-0x1.81cp+13===-0x1.3aep+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_a_6896c===%+010.3hha===%+010.3hha===\n",var1,var2);
  return i;
}

int float_a_6897c() {
  // { dg-printf "float_a_6897c===+0x1.e23f220000p+16===+0x0.0000000000p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_a_6897c===%+010.10hha===%+010.10hha===\n",var1,var2);
  return i;
}

int float_a_6898c() {
  // { dg-printf "float_a_6898c===+0X1.0000000000000P+0===-0X1.3AE1480000000P+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_6898c===%+010hhA===%+010hhA===\n",var1,var2);
  return i;
}

int float_a_6899c() {
  // { dg-printf "float_a_6899c===+0X1.EP+16===+0X1.EP+16===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_a_6899c===%+010.1hhA===%+010.1hhA===\n",var1,var2);
  return i;
}

int float_a_6900c() {
  // { dg-printf "float_a_6900c===+0X1.00P+0===-0X1.3BP+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_6900c===%+010.2hhA===%+010.2hhA===\n",var1,var2);
  return i;
}

int float_a_6901c() {
  // { dg-printf "float_a_6901c===-0X1.3AEP+0===+0X1.000P+1===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_a_6901c===%+010.3hhA===%+010.3hhA===\n",var1,var2);
  return i;
}

int float_a_6902c() {
  // { dg-printf "float_a_6902c===-0X1.81C8420000P+13===-0X1.81C8420000P+13===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_6902c===%+010.10hhA===%+010.10hhA===\n",var1,var2);
  return i;
}

int float_a_6939c() {
  // { dg-printf "float_a_6939c===-0x1.3ae1480000000p+0===+0x1.0000000000000p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_a_6939c===%+010ha===%+010ha===\n",var1,var2);
  return i;
}

int float_a_6940c() {
  // { dg-printf "float_a_6940c===+0x00.0p+0===+0x01.0p+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_6940c===%+010.1ha===%+010.1ha===\n",var1,var2);
  return i;
}

int float_a_6941c() {
  // { dg-printf "float_a_6941c===-0x1.3bp+0===-0x1.82p+13===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_6941c===%+010.2ha===%+010.2ha===\n",var1,var2);
  return i;
}

int float_a_6942c() {
  // { dg-printf "float_a_6942c===-0x1.3aep+0===-0x1.81cp+13===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_6942c===%+010.3ha===%+010.3ha===\n",var1,var2);
  return i;
}

int float_a_6943c() {
  // { dg-printf "float_a_6943c===+0x1.e23f220000p+16===+0x1.e23f220000p+16===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_a_6943c===%+010.10ha===%+010.10ha===\n",var1,var2);
  return i;
}

int float_a_6944c() {
  // { dg-printf "float_a_6944c===-0X1.3AE1480000000P+0===+0X1.0000000000000P+1===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_a_6944c===%+010hA===%+010hA===\n",var1,var2);
  return i;
}

int float_a_6945c() {
  // { dg-printf "float_a_6945c===+0X01.0P+1===+0X01.0P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_6945c===%+010.1hA===%+010.1hA===\n",var1,var2);
  return i;
}

int float_a_6946c() {
  // { dg-printf "float_a_6946c===+0X1.00P+0===+0X1.00P+1===" }
  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_a_6946c===%+010.2hA===%+010.2hA===\n",var1,var2);
  return i;
}

int float_a_6947c() {
  // { dg-printf "float_a_6947c===+0X1.000P+1===-0X1.3AEP+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_6947c===%+010.3hA===%+010.3hA===\n",var1,var2);
  return i;
}

int float_a_6948c() {
  // { dg-printf "float_a_6948c===-0X1.81C8420000P+13===+0X1.E23F220000P+16===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_a_6948c===%+010.10hA===%+010.10hA===\n",var1,var2);
  return i;
}

int float_a_6985c() {
  // { dg-printf "float_a_6985c===+0x1.0000000000000p+0===-0x1.81c8420000000p+13===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_6985c===%+010a===%+010a===\n",var1,var2);
  return i;
}

int float_a_6986c() {
  // { dg-printf "float_a_6986c===-0x1.8p+13===+0x00.0p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_a_6986c===%+010.1a===%+010.1a===\n",var1,var2);
  return i;
}

int float_a_6987c() {
  // { dg-printf "float_a_6987c===+0x1.00p+0===+0x1.e2p+16===" }
  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_6987c===%+010.2a===%+010.2a===\n",var1,var2);
  return i;
}

int float_a_6988c() {
  // { dg-printf "float_a_6988c===+0x1.e24p+16===+0x1.000p+1===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_a_6988c===%+010.3a===%+010.3a===\n",var1,var2);
  return i;
}

int float_a_6989c() {
  // { dg-printf "float_a_6989c===+0x1.e23f220000p+16===+0x1.e23f220000p+16===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_a_6989c===%+010.10a===%+010.10a===\n",var1,var2);
  return i;
}

int float_a_6990c() {
  // { dg-printf "float_a_6990c===+0X0.0000000000000P+0===+0X1.E23F220000000P+16===" }
  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_6990c===%+010A===%+010A===\n",var1,var2);
  return i;
}

int float_a_6991c() {
  // { dg-printf "float_a_6991c===+0X01.0P+1===-0X01.4P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_6991c===%+010.1A===%+010.1A===\n",var1,var2);
  return i;
}

int float_a_6992c() {
  // { dg-printf "float_a_6992c===-0X1.82P+13===+0X1.E2P+16===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_a_6992c===%+010.2A===%+010.2A===\n",var1,var2);
  return i;
}

int float_a_6993c() {
  // { dg-printf "float_a_6993c===-0X1.3AEP+0===+0X0.000P+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_a_6993c===%+010.3A===%+010.3A===\n",var1,var2);
  return i;
}

int float_a_6994c() {
  // { dg-printf "float_a_6994c===+0X0.0000000000P+0===-0X1.81C8420000P+13===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_6994c===%+010.10A===%+010.10A===\n",var1,var2);
  return i;
}

int float_a_7c() {
  // { dg-printf "float_a_7c===-0x1.81c8420000000p+13===-0x1.3ae1480000000p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_a_7c===%a===%a===\n",var1,var2);
  return i;
}

int float_a_767c() {
  // { dg-printf "float_a_767c===0x1.e23f220000000p+16===-0x1.3ae1480000000p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_a_767c===%-a===%-a===\n",var1,var2);
  return i;
}

int float_a_768c() {
  // { dg-printf "float_a_768c===0x1.0p+1===-0x1.4p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_768c===%-.1a===%-.1a===\n",var1,var2);
  return i;
}

int float_a_769c() {
  // { dg-printf "float_a_769c===0x1.e2p+16===-0x1.3bp+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_a_769c===%-.2a===%-.2a===\n",var1,var2);
  return i;
}

int float_a_770c() {
  // { dg-printf "float_a_770c===0x1.000p+0===-0x1.81cp+13===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_770c===%-.3a===%-.3a===\n",var1,var2);
  return i;
}

int float_a_771c() {
  // { dg-printf "float_a_771c===0x1.0000000000p+0===-0x1.81c8420000p+13===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_771c===%-.10a===%-.10a===\n",var1,var2);
  return i;
}

int float_a_772c() {
  // { dg-printf "float_a_772c===-0X1.3AE1480000000P+0===-0X1.81C8420000000P+13===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_772c===%-A===%-A===\n",var1,var2);
  return i;
}

int float_a_773c() {
  // { dg-printf "float_a_773c===-0X1.4P+0===0X1.0P+1===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_a_773c===%-.1A===%-.1A===\n",var1,var2);
  return i;
}

int float_a_774c() {
  // { dg-printf "float_a_774c===-0X1.3BP+0===0X0.00P+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_a_774c===%-.2A===%-.2A===\n",var1,var2);
  return i;
}

int float_a_775c() {
  // { dg-printf "float_a_775c===0X1.E24P+16===0X0.000P+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_a_775c===%-.3A===%-.3A===\n",var1,var2);
  return i;
}

int float_a_776c() {
  // { dg-printf "float_a_776c===-0X1.81C8420000P+13===0X1.0000000000P+1===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_a_776c===%-.10A===%-.10A===\n",var1,var2);
  return i;
}

int float_a_8c() {
  // { dg-printf "float_a_8c===-0x1.8p+13===0x0.0p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_a_8c===%.1a===%.1a===\n",var1,var2);
  return i;
}

int float_a_813c() {
  // { dg-printf "float_a_813c===0x0.0000000000000p+0===0x1.e23f220000000p+16===" }
  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_813c===%-hha===%-hha===\n",var1,var2);
  return i;
}

int float_a_814c() {
  // { dg-printf "float_a_814c===0x1.ep+16===0x1.0p+1===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_a_814c===%-.1hha===%-.1hha===\n",var1,var2);
  return i;
}

int float_a_815c() {
  // { dg-printf "float_a_815c===-0x1.82p+13===-0x1.3bp+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_a_815c===%-.2hha===%-.2hha===\n",var1,var2);
  return i;
}

int float_a_816c() {
  // { dg-printf "float_a_816c===0x1.000p+0===0x0.000p+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_816c===%-.3hha===%-.3hha===\n",var1,var2);
  return i;
}

int float_a_817c() {
  // { dg-printf "float_a_817c===0x1.0000000000p+0===-0x1.81c8420000p+13===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_817c===%-.10hha===%-.10hha===\n",var1,var2);
  return i;
}

int float_a_818c() {
  // { dg-printf "float_a_818c===-0X1.3AE1480000000P+0===-0X1.81C8420000000P+13===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_818c===%-hhA===%-hhA===\n",var1,var2);
  return i;
}

int float_a_819c() {
  // { dg-printf "float_a_819c===0X1.0P+0===-0X1.4P+0===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_819c===%-.1hhA===%-.1hhA===\n",var1,var2);
  return i;
}

int float_a_820c() {
  // { dg-printf "float_a_820c===0X1.00P+1===0X0.00P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_a_820c===%-.2hhA===%-.2hhA===\n",var1,var2);
  return i;
}

int float_a_821c() {
  // { dg-printf "float_a_821c===0X0.000P+0===-0X1.3AEP+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_a_821c===%-.3hhA===%-.3hhA===\n",var1,var2);
  return i;
}

int float_a_822c() {
  // { dg-printf "float_a_822c===-0X1.81C8420000P+13===0X1.0000000000P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_822c===%-.10hhA===%-.10hhA===\n",var1,var2);
  return i;
}

int float_a_859c() {
  // { dg-printf "float_a_859c===0x1.0000000000000p+0===0x1.e23f220000000p+16===" }
  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_859c===%-ha===%-ha===\n",var1,var2);
  return i;
}

int float_a_860c() {
  // { dg-printf "float_a_860c===0x1.ep+16===-0x1.8p+13===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_860c===%-.1ha===%-.1ha===\n",var1,var2);
  return i;
}

int float_a_861c() {
  // { dg-printf "float_a_861c===0x1.00p+1===0x1.00p+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_861c===%-.2ha===%-.2ha===\n",var1,var2);
  return i;
}

int float_a_862c() {
  // { dg-printf "float_a_862c===0x1.000p+1===0x1.e24p+16===" }
  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_862c===%-.3ha===%-.3ha===\n",var1,var2);
  return i;
}

int float_a_863c() {
  // { dg-printf "float_a_863c===-0x1.3ae1480000p+0===-0x1.3ae1480000p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_a_863c===%-.10ha===%-.10ha===\n",var1,var2);
  return i;
}

int float_a_864c() {
  // { dg-printf "float_a_864c===0X1.0000000000000P+0===-0X1.81C8420000000P+13===" }
  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_864c===%-hA===%-hA===\n",var1,var2);
  return i;
}

int float_a_865c() {
  // { dg-printf "float_a_865c===-0X1.8P+13===0X1.0P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_865c===%-.1hA===%-.1hA===\n",var1,var2);
  return i;
}

int float_a_866c() {
  // { dg-printf "float_a_866c===-0X1.3BP+0===0X0.00P+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_a_866c===%-.2hA===%-.2hA===\n",var1,var2);
  return i;
}

int float_a_867c() {
  // { dg-printf "float_a_867c===0X1.000P+0===0X1.E24P+16===" }
  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_867c===%-.3hA===%-.3hA===\n",var1,var2);
  return i;
}

int float_a_868c() {
  // { dg-printf "float_a_868c===0X1.0000000000P+1===0X1.0000000000P+0===" }
  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_868c===%-.10hA===%-.10hA===\n",var1,var2);
  return i;
}

int float_a_9c() {
  // { dg-printf "float_a_9c===0x1.e2p+16===0x1.00p+0===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_a_9c===%.2a===%.2a===\n",var1,var2);
  return i;
}

int float_a_905c() {
  // { dg-printf "float_a_905c===0x1.e23f220000000p+16===0x1.0000000000000p+1===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_a_905c===%-a===%-a===\n",var1,var2);
  return i;
}

int float_a_906c() {
  // { dg-printf "float_a_906c===0x0.0p+0===0x1.ep+16===" }
  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_a_906c===%-.1a===%-.1a===\n",var1,var2);
  return i;
}

int float_a_907c() {
  // { dg-printf "float_a_907c===-0x1.82p+13===0x1.00p+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_907c===%-.2a===%-.2a===\n",var1,var2);
  return i;
}

int float_a_908c() {
  // { dg-printf "float_a_908c===0x1.e24p+16===0x1.e24p+16===" }
  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_a_908c===%-.3a===%-.3a===\n",var1,var2);
  return i;
}

int float_a_909c() {
  // { dg-printf "float_a_909c===0x0.0000000000p+0===0x1.0000000000p+0===" }
  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_a_909c===%-.10a===%-.10a===\n",var1,var2);
  return i;
}

int float_a_910c() {
  // { dg-printf "float_a_910c===-0X1.81C8420000000P+13===-0X1.81C8420000000P+13===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_910c===%-A===%-A===\n",var1,var2);
  return i;
}

int float_a_911c() {
  // { dg-printf "float_a_911c===-0X1.8P+13===0X1.0P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_a_911c===%-.1A===%-.1A===\n",var1,var2);
  return i;
}

int float_a_912c() {
  // { dg-printf "float_a_912c===-0X1.3BP+0===0X0.00P+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_a_912c===%-.2A===%-.2A===\n",var1,var2);
  return i;
}

int float_a_913c() {
  // { dg-printf "float_a_913c===0X0.000P+0===-0X1.81CP+13===" }
  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_a_913c===%-.3A===%-.3A===\n",var1,var2);
  return i;
}

int float_a_914c() {
  // { dg-printf "float_a_914c===-0X1.81C8420000P+13===0X0.0000000000P+0===" }
  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_a_914c===%-.10A===%-.10A===\n",var1,var2);
  return i;
}

int float_a_99c() {
  // { dg-printf "float_a_99c===-0x1.3ae1480000000p+0===-0x1.3ae1480000000p+0===" }
  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_a_99c===%ha===%ha===\n",var1,var2);
  return i;
}

int float_e_109c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_109c===%he===%he===\n",var1,var2);
  return i;
}

int float_e_110c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_110c===%.1he===%.1he===\n",var1,var2);
  return i;
}

int float_e_111c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_111c===%.2he===%.2he===\n",var1,var2);
  return i;
}

int float_e_112c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_112c===%.3he===%.3he===\n",var1,var2);
  return i;
}

int float_e_113c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_e_113c===%.10he===%.10he===\n",var1,var2);
  return i;
}

int float_e_114c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_114c===%hE===%hE===\n",var1,var2);
  return i;
}

int float_e_115c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_e_115c===%.1hE===%.1hE===\n",var1,var2);
  return i;
}

int float_e_116c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_e_116c===%.2hE===%.2hE===\n",var1,var2);
  return i;
}

int float_e_117c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_e_117c===%.3hE===%.3hE===\n",var1,var2);
  return i;
}

int float_e_118c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_118c===%.10hE===%.10hE===\n",var1,var2);
  return i;
}

int float_e_1537c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_e_1537c===%+e===%+e===\n",var1,var2);
  return i;
}

int float_e_1538c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_1538c===%+.1e===%+.1e===\n",var1,var2);
  return i;
}

int float_e_1539c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_1539c===%+.2e===%+.2e===\n",var1,var2);
  return i;
}

int float_e_1540c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_1540c===%+.3e===%+.3e===\n",var1,var2);
  return i;
}

int float_e_1541c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_1541c===%+.10e===%+.10e===\n",var1,var2);
  return i;
}

int float_e_1542c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_1542c===%+E===%+E===\n",var1,var2);
  return i;
}

int float_e_1543c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_e_1543c===%+.1E===%+.1E===\n",var1,var2);
  return i;
}

int float_e_1544c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_e_1544c===%+.2E===%+.2E===\n",var1,var2);
  return i;
}

int float_e_1545c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_1545c===%+.3E===%+.3E===\n",var1,var2);
  return i;
}

int float_e_1546c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_e_1546c===%+.10E===%+.10E===\n",var1,var2);
  return i;
}

int float_e_155c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_e_155c===%e===%e===\n",var1,var2);
  return i;
}

int float_e_156c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_156c===%.1e===%.1e===\n",var1,var2);
  return i;
}

int float_e_157c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_157c===%.2e===%.2e===\n",var1,var2);
  return i;
}

int float_e_158c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_158c===%.3e===%.3e===\n",var1,var2);
  return i;
}

int float_e_1583c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_e_1583c===%+hhe===%+hhe===\n",var1,var2);
  return i;
}

int float_e_1584c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_1584c===%+.1hhe===%+.1hhe===\n",var1,var2);
  return i;
}

int float_e_1585c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_e_1585c===%+.2hhe===%+.2hhe===\n",var1,var2);
  return i;
}

int float_e_1586c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_1586c===%+.3hhe===%+.3hhe===\n",var1,var2);
  return i;
}

int float_e_1587c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_1587c===%+.10hhe===%+.10hhe===\n",var1,var2);
  return i;
}

int float_e_1588c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_1588c===%+hhE===%+hhE===\n",var1,var2);
  return i;
}

int float_e_1589c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_1589c===%+.1hhE===%+.1hhE===\n",var1,var2);
  return i;
}

int float_e_159c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_159c===%.10e===%.10e===\n",var1,var2);
  return i;
}

int float_e_1590c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_1590c===%+.2hhE===%+.2hhE===\n",var1,var2);
  return i;
}

int float_e_1591c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_1591c===%+.3hhE===%+.3hhE===\n",var1,var2);
  return i;
}

int float_e_1592c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_e_1592c===%+.10hhE===%+.10hhE===\n",var1,var2);
  return i;
}

int float_e_160c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_e_160c===%E===%E===\n",var1,var2);
  return i;
}

int float_e_161c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_161c===%.1E===%.1E===\n",var1,var2);
  return i;
}

int float_e_162c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_162c===%.2E===%.2E===\n",var1,var2);
  return i;
}

int float_e_1629c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_e_1629c===%+he===%+he===\n",var1,var2);
  return i;
}

int float_e_163c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_163c===%.3E===%.3E===\n",var1,var2);
  return i;
}

int float_e_1630c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_1630c===%+.1he===%+.1he===\n",var1,var2);
  return i;
}

int float_e_1631c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_e_1631c===%+.2he===%+.2he===\n",var1,var2);
  return i;
}

int float_e_1632c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_1632c===%+.3he===%+.3he===\n",var1,var2);
  return i;
}

int float_e_1633c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_e_1633c===%+.10he===%+.10he===\n",var1,var2);
  return i;
}

int float_e_1634c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_1634c===%+hE===%+hE===\n",var1,var2);
  return i;
}

int float_e_1635c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_e_1635c===%+.1hE===%+.1hE===\n",var1,var2);
  return i;
}

int float_e_1636c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_1636c===%+.2hE===%+.2hE===\n",var1,var2);
  return i;
}

int float_e_1637c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_1637c===%+.3hE===%+.3hE===\n",var1,var2);
  return i;
}

int float_e_1638c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_e_1638c===%+.10hE===%+.10hE===\n",var1,var2);
  return i;
}

int float_e_164c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_164c===%.10E===%.10E===\n",var1,var2);
  return i;
}

int float_e_1675c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_e_1675c===%+e===%+e===\n",var1,var2);
  return i;
}

int float_e_1676c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_1676c===%+.1e===%+.1e===\n",var1,var2);
  return i;
}

int float_e_1677c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_1677c===%+.2e===%+.2e===\n",var1,var2);
  return i;
}

int float_e_1678c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_1678c===%+.3e===%+.3e===\n",var1,var2);
  return i;
}

int float_e_1679c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_1679c===%+.10e===%+.10e===\n",var1,var2);
  return i;
}

int float_e_1680c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_e_1680c===%+E===%+E===\n",var1,var2);
  return i;
}

int float_e_1681c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_1681c===%+.1E===%+.1E===\n",var1,var2);
  return i;
}

int float_e_1682c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_e_1682c===%+.2E===%+.2E===\n",var1,var2);
  return i;
}

int float_e_1683c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_1683c===%+.3E===%+.3E===\n",var1,var2);
  return i;
}

int float_e_1684c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_1684c===%+.10E===%+.10E===\n",var1,var2);
  return i;
}

int float_e_17c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_17c===%e===%e===\n",var1,var2);
  return i;
}

int float_e_18c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_18c===%.1e===%.1e===\n",var1,var2);
  return i;
}

int float_e_19c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_e_19c===%.2e===%.2e===\n",var1,var2);
  return i;
}

int float_e_20c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_20c===%.3e===%.3e===\n",var1,var2);
  return i;
}

int float_e_21c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_21c===%.10e===%.10e===\n",var1,var2);
  return i;
}

int float_e_22c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_22c===%E===%E===\n",var1,var2);
  return i;
}

int float_e_2297c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_2297c===%#e===%#e===\n",var1,var2);
  return i;
}

int float_e_2298c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_2298c===%#.1e===%#.1e===\n",var1,var2);
  return i;
}

int float_e_2299c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_2299c===%#.2e===%#.2e===\n",var1,var2);
  return i;
}

int float_e_23c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_e_23c===%.1E===%.1E===\n",var1,var2);
  return i;
}

int float_e_2300c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_e_2300c===%#.3e===%#.3e===\n",var1,var2);
  return i;
}

int float_e_2301c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_2301c===%#.10e===%#.10e===\n",var1,var2);
  return i;
}

int float_e_2302c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_e_2302c===%#E===%#E===\n",var1,var2);
  return i;
}

int float_e_2303c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_e_2303c===%#.1E===%#.1E===\n",var1,var2);
  return i;
}

int float_e_2304c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_e_2304c===%#.2E===%#.2E===\n",var1,var2);
  return i;
}

int float_e_2305c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_e_2305c===%#.3E===%#.3E===\n",var1,var2);
  return i;
}

int float_e_2306c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_2306c===%#.10E===%#.10E===\n",var1,var2);
  return i;
}

int float_e_2343c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_2343c===%#hhe===%#hhe===\n",var1,var2);
  return i;
}

int float_e_2344c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_e_2344c===%#.1hhe===%#.1hhe===\n",var1,var2);
  return i;
}

int float_e_2345c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_2345c===%#.2hhe===%#.2hhe===\n",var1,var2);
  return i;
}

int float_e_2346c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_2346c===%#.3hhe===%#.3hhe===\n",var1,var2);
  return i;
}

int float_e_2347c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_2347c===%#.10hhe===%#.10hhe===\n",var1,var2);
  return i;
}

int float_e_2348c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_2348c===%#hhE===%#hhE===\n",var1,var2);
  return i;
}

int float_e_2349c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_2349c===%#.1hhE===%#.1hhE===\n",var1,var2);
  return i;
}

int float_e_2350c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_2350c===%#.2hhE===%#.2hhE===\n",var1,var2);
  return i;
}

int float_e_2351c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_2351c===%#.3hhE===%#.3hhE===\n",var1,var2);
  return i;
}

int float_e_2352c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_2352c===%#.10hhE===%#.10hhE===\n",var1,var2);
  return i;
}

int float_e_2389c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_2389c===%#he===%#he===\n",var1,var2);
  return i;
}

int float_e_2390c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_2390c===%#.1he===%#.1he===\n",var1,var2);
  return i;
}

int float_e_2391c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_2391c===%#.2he===%#.2he===\n",var1,var2);
  return i;
}

int float_e_2392c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_2392c===%#.3he===%#.3he===\n",var1,var2);
  return i;
}

int float_e_2393c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_2393c===%#.10he===%#.10he===\n",var1,var2);
  return i;
}

int float_e_2394c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_e_2394c===%#hE===%#hE===\n",var1,var2);
  return i;
}

int float_e_2395c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_2395c===%#.1hE===%#.1hE===\n",var1,var2);
  return i;
}

int float_e_2396c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_2396c===%#.2hE===%#.2hE===\n",var1,var2);
  return i;
}

int float_e_2397c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_2397c===%#.3hE===%#.3hE===\n",var1,var2);
  return i;
}

int float_e_2398c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_2398c===%#.10hE===%#.10hE===\n",var1,var2);
  return i;
}

int float_e_24c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_e_24c===%.2E===%.2E===\n",var1,var2);
  return i;
}

int float_e_2435c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_e_2435c===%#e===%#e===\n",var1,var2);
  return i;
}

int float_e_2436c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_2436c===%#.1e===%#.1e===\n",var1,var2);
  return i;
}

int float_e_2437c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_2437c===%#.2e===%#.2e===\n",var1,var2);
  return i;
}

int float_e_2438c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_2438c===%#.3e===%#.3e===\n",var1,var2);
  return i;
}

int float_e_2439c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_e_2439c===%#.10e===%#.10e===\n",var1,var2);
  return i;
}

int float_e_2440c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_2440c===%#E===%#E===\n",var1,var2);
  return i;
}

int float_e_2441c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_2441c===%#.1E===%#.1E===\n",var1,var2);
  return i;
}

int float_e_2442c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_2442c===%#.2E===%#.2E===\n",var1,var2);
  return i;
}

int float_e_2443c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_2443c===%#.3E===%#.3E===\n",var1,var2);
  return i;
}

int float_e_2444c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_2444c===%#.10E===%#.10E===\n",var1,var2);
  return i;
}

int float_e_25c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_e_25c===%.3E===%.3E===\n",var1,var2);
  return i;
}

int float_e_26c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_e_26c===%.10E===%.10E===\n",var1,var2);
  return i;
}

int float_e_3057c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_e_3057c===%-+e===%-+e===\n",var1,var2);
  return i;
}

int float_e_3058c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3058c===%-+.1e===%-+.1e===\n",var1,var2);
  return i;
}

int float_e_3059c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_e_3059c===%-+.2e===%-+.2e===\n",var1,var2);
  return i;
}

int float_e_3060c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_e_3060c===%-+.3e===%-+.3e===\n",var1,var2);
  return i;
}

int float_e_3061c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_e_3061c===%-+.10e===%-+.10e===\n",var1,var2);
  return i;
}

int float_e_3062c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_3062c===%-+E===%-+E===\n",var1,var2);
  return i;
}

int float_e_3063c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3063c===%-+.1E===%-+.1E===\n",var1,var2);
  return i;
}

int float_e_3064c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3064c===%-+.2E===%-+.2E===\n",var1,var2);
  return i;
}

int float_e_3065c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_3065c===%-+.3E===%-+.3E===\n",var1,var2);
  return i;
}

int float_e_3066c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3066c===%-+.10E===%-+.10E===\n",var1,var2);
  return i;
}

int float_e_3103c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_3103c===%-+hhe===%-+hhe===\n",var1,var2);
  return i;
}

int float_e_3104c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3104c===%-+.1hhe===%-+.1hhe===\n",var1,var2);
  return i;
}

int float_e_3105c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_3105c===%-+.2hhe===%-+.2hhe===\n",var1,var2);
  return i;
}

int float_e_3106c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3106c===%-+.3hhe===%-+.3hhe===\n",var1,var2);
  return i;
}

int float_e_3107c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_e_3107c===%-+.10hhe===%-+.10hhe===\n",var1,var2);
  return i;
}

int float_e_3108c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_3108c===%-+hhE===%-+hhE===\n",var1,var2);
  return i;
}

int float_e_3109c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_e_3109c===%-+.1hhE===%-+.1hhE===\n",var1,var2);
  return i;
}

int float_e_3110c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_e_3110c===%-+.2hhE===%-+.2hhE===\n",var1,var2);
  return i;
}

int float_e_3111c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_e_3111c===%-+.3hhE===%-+.3hhE===\n",var1,var2);
  return i;
}

int float_e_3112c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_e_3112c===%-+.10hhE===%-+.10hhE===\n",var1,var2);
  return i;
}

int float_e_3149c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_3149c===%-+he===%-+he===\n",var1,var2);
  return i;
}

int float_e_3150c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_e_3150c===%-+.1he===%-+.1he===\n",var1,var2);
  return i;
}

int float_e_3151c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_3151c===%-+.2he===%-+.2he===\n",var1,var2);
  return i;
}

int float_e_3152c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_3152c===%-+.3he===%-+.3he===\n",var1,var2);
  return i;
}

int float_e_3153c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_e_3153c===%-+.10he===%-+.10he===\n",var1,var2);
  return i;
}

int float_e_3154c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_3154c===%-+hE===%-+hE===\n",var1,var2);
  return i;
}

int float_e_3155c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_3155c===%-+.1hE===%-+.1hE===\n",var1,var2);
  return i;
}

int float_e_3156c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_e_3156c===%-+.2hE===%-+.2hE===\n",var1,var2);
  return i;
}

int float_e_3157c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3157c===%-+.3hE===%-+.3hE===\n",var1,var2);
  return i;
}

int float_e_3158c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_3158c===%-+.10hE===%-+.10hE===\n",var1,var2);
  return i;
}

int float_e_3195c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_3195c===%-+e===%-+e===\n",var1,var2);
  return i;
}

int float_e_3196c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_e_3196c===%-+.1e===%-+.1e===\n",var1,var2);
  return i;
}

int float_e_3197c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_e_3197c===%-+.2e===%-+.2e===\n",var1,var2);
  return i;
}

int float_e_3198c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_e_3198c===%-+.3e===%-+.3e===\n",var1,var2);
  return i;
}

int float_e_3199c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_3199c===%-+.10e===%-+.10e===\n",var1,var2);
  return i;
}

int float_e_3200c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_e_3200c===%-+E===%-+E===\n",var1,var2);
  return i;
}

int float_e_3201c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_3201c===%-+.1E===%-+.1E===\n",var1,var2);
  return i;
}

int float_e_3202c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3202c===%-+.2E===%-+.2E===\n",var1,var2);
  return i;
}

int float_e_3203c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_3203c===%-+.3E===%-+.3E===\n",var1,var2);
  return i;
}

int float_e_3204c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3204c===%-+.10E===%-+.10E===\n",var1,var2);
  return i;
}

int float_e_3817c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_e_3817c===% 10e===% 10e===\n",var1,var2);
  return i;
}

int float_e_3818c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_3818c===% 10.1e===% 10.1e===\n",var1,var2);
  return i;
}

int float_e_3819c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3819c===% 10.2e===% 10.2e===\n",var1,var2);
  return i;
}

int float_e_3820c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_e_3820c===% 10.3e===% 10.3e===\n",var1,var2);
  return i;
}

int float_e_3821c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_3821c===% 10.10e===% 10.10e===\n",var1,var2);
  return i;
}

int float_e_3822c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_e_3822c===% 10E===% 10E===\n",var1,var2);
  return i;
}

int float_e_3823c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_e_3823c===% 10.1E===% 10.1E===\n",var1,var2);
  return i;
}

int float_e_3824c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3824c===% 10.2E===% 10.2E===\n",var1,var2);
  return i;
}

int float_e_3825c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3825c===% 10.3E===% 10.3E===\n",var1,var2);
  return i;
}

int float_e_3826c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_3826c===% 10.10E===% 10.10E===\n",var1,var2);
  return i;
}

int float_e_3863c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_e_3863c===% 10hhe===% 10hhe===\n",var1,var2);
  return i;
}

int float_e_3864c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_3864c===% 10.1hhe===% 10.1hhe===\n",var1,var2);
  return i;
}

int float_e_3865c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3865c===% 10.2hhe===% 10.2hhe===\n",var1,var2);
  return i;
}

int float_e_3866c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_3866c===% 10.3hhe===% 10.3hhe===\n",var1,var2);
  return i;
}

int float_e_3867c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_3867c===% 10.10hhe===% 10.10hhe===\n",var1,var2);
  return i;
}

int float_e_3868c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_3868c===% 10hhE===% 10hhE===\n",var1,var2);
  return i;
}

int float_e_3869c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3869c===% 10.1hhE===% 10.1hhE===\n",var1,var2);
  return i;
}

int float_e_3870c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_3870c===% 10.2hhE===% 10.2hhE===\n",var1,var2);
  return i;
}

int float_e_3871c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_e_3871c===% 10.3hhE===% 10.3hhE===\n",var1,var2);
  return i;
}

int float_e_3872c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_3872c===% 10.10hhE===% 10.10hhE===\n",var1,var2);
  return i;
}

int float_e_3909c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_3909c===% 10he===% 10he===\n",var1,var2);
  return i;
}

int float_e_3910c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_3910c===% 10.1he===% 10.1he===\n",var1,var2);
  return i;
}

int float_e_3911c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_e_3911c===% 10.2he===% 10.2he===\n",var1,var2);
  return i;
}

int float_e_3912c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_e_3912c===% 10.3he===% 10.3he===\n",var1,var2);
  return i;
}

int float_e_3913c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_3913c===% 10.10he===% 10.10he===\n",var1,var2);
  return i;
}

int float_e_3914c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_3914c===% 10hE===% 10hE===\n",var1,var2);
  return i;
}

int float_e_3915c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_e_3915c===% 10.1hE===% 10.1hE===\n",var1,var2);
  return i;
}

int float_e_3916c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_e_3916c===% 10.2hE===% 10.2hE===\n",var1,var2);
  return i;
}

int float_e_3917c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_3917c===% 10.3hE===% 10.3hE===\n",var1,var2);
  return i;
}

int float_e_3918c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_3918c===% 10.10hE===% 10.10hE===\n",var1,var2);
  return i;
}

int float_e_3955c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_3955c===% 10e===% 10e===\n",var1,var2);
  return i;
}

int float_e_3956c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3956c===% 10.1e===% 10.1e===\n",var1,var2);
  return i;
}

int float_e_3957c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_3957c===% 10.2e===% 10.2e===\n",var1,var2);
  return i;
}

int float_e_3958c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_3958c===% 10.3e===% 10.3e===\n",var1,var2);
  return i;
}

int float_e_3959c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_3959c===% 10.10e===% 10.10e===\n",var1,var2);
  return i;
}

int float_e_3960c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_e_3960c===% 10E===% 10E===\n",var1,var2);
  return i;
}

int float_e_3961c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_e_3961c===% 10.1E===% 10.1E===\n",var1,var2);
  return i;
}

int float_e_3962c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_e_3962c===% 10.2E===% 10.2E===\n",var1,var2);
  return i;
}

int float_e_3963c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_e_3963c===% 10.3E===% 10.3E===\n",var1,var2);
  return i;
}

int float_e_3964c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_3964c===% 10.10E===% 10.10E===\n",var1,var2);
  return i;
}

int float_e_4577c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_4577c===%010e===%010e===\n",var1,var2);
  return i;
}

int float_e_4578c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_4578c===%010.1e===%010.1e===\n",var1,var2);
  return i;
}

int float_e_4579c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_4579c===%010.2e===%010.2e===\n",var1,var2);
  return i;
}

int float_e_4580c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_4580c===%010.3e===%010.3e===\n",var1,var2);
  return i;
}

int float_e_4581c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_4581c===%010.10e===%010.10e===\n",var1,var2);
  return i;
}

int float_e_4582c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_4582c===%010E===%010E===\n",var1,var2);
  return i;
}

int float_e_4583c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_4583c===%010.1E===%010.1E===\n",var1,var2);
  return i;
}

int float_e_4584c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_e_4584c===%010.2E===%010.2E===\n",var1,var2);
  return i;
}

int float_e_4585c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_4585c===%010.3E===%010.3E===\n",var1,var2);
  return i;
}

int float_e_4586c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_e_4586c===%010.10E===%010.10E===\n",var1,var2);
  return i;
}

int float_e_4623c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_e_4623c===%010hhe===%010hhe===\n",var1,var2);
  return i;
}

int float_e_4624c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_4624c===%010.1hhe===%010.1hhe===\n",var1,var2);
  return i;
}

int float_e_4625c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_4625c===%010.2hhe===%010.2hhe===\n",var1,var2);
  return i;
}

int float_e_4626c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_e_4626c===%010.3hhe===%010.3hhe===\n",var1,var2);
  return i;
}

int float_e_4627c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_e_4627c===%010.10hhe===%010.10hhe===\n",var1,var2);
  return i;
}

int float_e_4628c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_4628c===%010hhE===%010hhE===\n",var1,var2);
  return i;
}

int float_e_4629c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_e_4629c===%010.1hhE===%010.1hhE===\n",var1,var2);
  return i;
}

int float_e_4630c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_e_4630c===%010.2hhE===%010.2hhE===\n",var1,var2);
  return i;
}

int float_e_4631c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_4631c===%010.3hhE===%010.3hhE===\n",var1,var2);
  return i;
}

int float_e_4632c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_4632c===%010.10hhE===%010.10hhE===\n",var1,var2);
  return i;
}

int float_e_4669c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_4669c===%010he===%010he===\n",var1,var2);
  return i;
}

int float_e_4670c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_e_4670c===%010.1he===%010.1he===\n",var1,var2);
  return i;
}

int float_e_4671c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_4671c===%010.2he===%010.2he===\n",var1,var2);
  return i;
}

int float_e_4672c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_4672c===%010.3he===%010.3he===\n",var1,var2);
  return i;
}

int float_e_4673c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_e_4673c===%010.10he===%010.10he===\n",var1,var2);
  return i;
}

int float_e_4674c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_4674c===%010hE===%010hE===\n",var1,var2);
  return i;
}

int float_e_4675c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_4675c===%010.1hE===%010.1hE===\n",var1,var2);
  return i;
}

int float_e_4676c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_4676c===%010.2hE===%010.2hE===\n",var1,var2);
  return i;
}

int float_e_4677c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_e_4677c===%010.3hE===%010.3hE===\n",var1,var2);
  return i;
}

int float_e_4678c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_e_4678c===%010.10hE===%010.10hE===\n",var1,var2);
  return i;
}

int float_e_4715c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_e_4715c===%010e===%010e===\n",var1,var2);
  return i;
}

int float_e_4716c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_4716c===%010.1e===%010.1e===\n",var1,var2);
  return i;
}

int float_e_4717c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_e_4717c===%010.2e===%010.2e===\n",var1,var2);
  return i;
}

int float_e_4718c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_4718c===%010.3e===%010.3e===\n",var1,var2);
  return i;
}

int float_e_4719c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_4719c===%010.10e===%010.10e===\n",var1,var2);
  return i;
}

int float_e_4720c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_4720c===%010E===%010E===\n",var1,var2);
  return i;
}

int float_e_4721c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_4721c===%010.1E===%010.1E===\n",var1,var2);
  return i;
}

int float_e_4722c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_4722c===%010.2E===%010.2E===\n",var1,var2);
  return i;
}

int float_e_4723c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_e_4723c===%010.3E===%010.3E===\n",var1,var2);
  return i;
}

int float_e_4724c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_4724c===%010.10E===%010.10E===\n",var1,var2);
  return i;
}

int float_e_5337c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_5337c===%- 10e===%- 10e===\n",var1,var2);
  return i;
}

int float_e_5338c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_5338c===%- 10.1e===%- 10.1e===\n",var1,var2);
  return i;
}

int float_e_5339c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_5339c===%- 10.2e===%- 10.2e===\n",var1,var2);
  return i;
}

int float_e_5340c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_5340c===%- 10.3e===%- 10.3e===\n",var1,var2);
  return i;
}

int float_e_5341c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_e_5341c===%- 10.10e===%- 10.10e===\n",var1,var2);
  return i;
}

int float_e_5342c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_5342c===%- 10E===%- 10E===\n",var1,var2);
  return i;
}

int float_e_5343c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_e_5343c===%- 10.1E===%- 10.1E===\n",var1,var2);
  return i;
}

int float_e_5344c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_e_5344c===%- 10.2E===%- 10.2E===\n",var1,var2);
  return i;
}

int float_e_5345c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_5345c===%- 10.3E===%- 10.3E===\n",var1,var2);
  return i;
}

int float_e_5346c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_5346c===%- 10.10E===%- 10.10E===\n",var1,var2);
  return i;
}

int float_e_5383c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_5383c===%- 10hhe===%- 10hhe===\n",var1,var2);
  return i;
}

int float_e_5384c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_e_5384c===%- 10.1hhe===%- 10.1hhe===\n",var1,var2);
  return i;
}

int float_e_5385c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_e_5385c===%- 10.2hhe===%- 10.2hhe===\n",var1,var2);
  return i;
}

int float_e_5386c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_5386c===%- 10.3hhe===%- 10.3hhe===\n",var1,var2);
  return i;
}

int float_e_5387c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_5387c===%- 10.10hhe===%- 10.10hhe===\n",var1,var2);
  return i;
}

int float_e_5388c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_5388c===%- 10hhE===%- 10hhE===\n",var1,var2);
  return i;
}

int float_e_5389c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_5389c===%- 10.1hhE===%- 10.1hhE===\n",var1,var2);
  return i;
}

int float_e_5390c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_5390c===%- 10.2hhE===%- 10.2hhE===\n",var1,var2);
  return i;
}

int float_e_5391c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_5391c===%- 10.3hhE===%- 10.3hhE===\n",var1,var2);
  return i;
}

int float_e_5392c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_5392c===%- 10.10hhE===%- 10.10hhE===\n",var1,var2);
  return i;
}

int float_e_5429c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_5429c===%- 10he===%- 10he===\n",var1,var2);
  return i;
}

int float_e_5430c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_5430c===%- 10.1he===%- 10.1he===\n",var1,var2);
  return i;
}

int float_e_5431c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_e_5431c===%- 10.2he===%- 10.2he===\n",var1,var2);
  return i;
}

int float_e_5432c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_e_5432c===%- 10.3he===%- 10.3he===\n",var1,var2);
  return i;
}

int float_e_5433c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_e_5433c===%- 10.10he===%- 10.10he===\n",var1,var2);
  return i;
}

int float_e_5434c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_e_5434c===%- 10hE===%- 10hE===\n",var1,var2);
  return i;
}

int float_e_5435c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_e_5435c===%- 10.1hE===%- 10.1hE===\n",var1,var2);
  return i;
}

int float_e_5436c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_5436c===%- 10.2hE===%- 10.2hE===\n",var1,var2);
  return i;
}

int float_e_5437c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_e_5437c===%- 10.3hE===%- 10.3hE===\n",var1,var2);
  return i;
}

int float_e_5438c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_5438c===%- 10.10hE===%- 10.10hE===\n",var1,var2);
  return i;
}

int float_e_5475c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_5475c===%- 10e===%- 10e===\n",var1,var2);
  return i;
}

int float_e_5476c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_5476c===%- 10.1e===%- 10.1e===\n",var1,var2);
  return i;
}

int float_e_5477c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_5477c===%- 10.2e===%- 10.2e===\n",var1,var2);
  return i;
}

int float_e_5478c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_e_5478c===%- 10.3e===%- 10.3e===\n",var1,var2);
  return i;
}

int float_e_5479c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_5479c===%- 10.10e===%- 10.10e===\n",var1,var2);
  return i;
}

int float_e_5480c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_5480c===%- 10E===%- 10E===\n",var1,var2);
  return i;
}

int float_e_5481c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_5481c===%- 10.1E===%- 10.1E===\n",var1,var2);
  return i;
}

int float_e_5482c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_5482c===%- 10.2E===%- 10.2E===\n",var1,var2);
  return i;
}

int float_e_5483c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_5483c===%- 10.3E===%- 10.3E===\n",var1,var2);
  return i;
}

int float_e_5484c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_5484c===%- 10.10E===%- 10.10E===\n",var1,var2);
  return i;
}

int float_e_6097c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_6097c===%+ 10e===%+ 10e===\n",var1,var2);
  return i;
}

int float_e_6098c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_6098c===%+ 10.1e===%+ 10.1e===\n",var1,var2);
  return i;
}

int float_e_6099c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_e_6099c===%+ 10.2e===%+ 10.2e===\n",var1,var2);
  return i;
}

int float_e_6100c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_6100c===%+ 10.3e===%+ 10.3e===\n",var1,var2);
  return i;
}

int float_e_6101c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_e_6101c===%+ 10.10e===%+ 10.10e===\n",var1,var2);
  return i;
}

int float_e_6102c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_6102c===%+ 10E===%+ 10E===\n",var1,var2);
  return i;
}

int float_e_6103c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_6103c===%+ 10.1E===%+ 10.1E===\n",var1,var2);
  return i;
}

int float_e_6104c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_6104c===%+ 10.2E===%+ 10.2E===\n",var1,var2);
  return i;
}

int float_e_6105c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_e_6105c===%+ 10.3E===%+ 10.3E===\n",var1,var2);
  return i;
}

int float_e_6106c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_6106c===%+ 10.10E===%+ 10.10E===\n",var1,var2);
  return i;
}

int float_e_6143c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_e_6143c===%+ 10hhe===%+ 10hhe===\n",var1,var2);
  return i;
}

int float_e_6144c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_6144c===%+ 10.1hhe===%+ 10.1hhe===\n",var1,var2);
  return i;
}

int float_e_6145c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_6145c===%+ 10.2hhe===%+ 10.2hhe===\n",var1,var2);
  return i;
}

int float_e_6146c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_6146c===%+ 10.3hhe===%+ 10.3hhe===\n",var1,var2);
  return i;
}

int float_e_6147c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_e_6147c===%+ 10.10hhe===%+ 10.10hhe===\n",var1,var2);
  return i;
}

int float_e_6148c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_6148c===%+ 10hhE===%+ 10hhE===\n",var1,var2);
  return i;
}

int float_e_6149c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_6149c===%+ 10.1hhE===%+ 10.1hhE===\n",var1,var2);
  return i;
}

int float_e_6150c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_6150c===%+ 10.2hhE===%+ 10.2hhE===\n",var1,var2);
  return i;
}

int float_e_6151c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_e_6151c===%+ 10.3hhE===%+ 10.3hhE===\n",var1,var2);
  return i;
}

int float_e_6152c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_e_6152c===%+ 10.10hhE===%+ 10.10hhE===\n",var1,var2);
  return i;
}

int float_e_6189c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_e_6189c===%+ 10he===%+ 10he===\n",var1,var2);
  return i;
}

int float_e_6190c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_6190c===%+ 10.1he===%+ 10.1he===\n",var1,var2);
  return i;
}

int float_e_6191c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_6191c===%+ 10.2he===%+ 10.2he===\n",var1,var2);
  return i;
}

int float_e_6192c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_6192c===%+ 10.3he===%+ 10.3he===\n",var1,var2);
  return i;
}

int float_e_6193c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_6193c===%+ 10.10he===%+ 10.10he===\n",var1,var2);
  return i;
}

int float_e_6194c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_6194c===%+ 10hE===%+ 10hE===\n",var1,var2);
  return i;
}

int float_e_6195c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_6195c===%+ 10.1hE===%+ 10.1hE===\n",var1,var2);
  return i;
}

int float_e_6196c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_e_6196c===%+ 10.2hE===%+ 10.2hE===\n",var1,var2);
  return i;
}

int float_e_6197c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_e_6197c===%+ 10.3hE===%+ 10.3hE===\n",var1,var2);
  return i;
}

int float_e_6198c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_6198c===%+ 10.10hE===%+ 10.10hE===\n",var1,var2);
  return i;
}

int float_e_6235c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_6235c===%+ 10e===%+ 10e===\n",var1,var2);
  return i;
}

int float_e_6236c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_6236c===%+ 10.1e===%+ 10.1e===\n",var1,var2);
  return i;
}

int float_e_6237c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_6237c===%+ 10.2e===%+ 10.2e===\n",var1,var2);
  return i;
}

int float_e_6238c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_6238c===%+ 10.3e===%+ 10.3e===\n",var1,var2);
  return i;
}

int float_e_6239c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_e_6239c===%+ 10.10e===%+ 10.10e===\n",var1,var2);
  return i;
}

int float_e_6240c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_6240c===%+ 10E===%+ 10E===\n",var1,var2);
  return i;
}

int float_e_6241c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_6241c===%+ 10.1E===%+ 10.1E===\n",var1,var2);
  return i;
}

int float_e_6242c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_e_6242c===%+ 10.2E===%+ 10.2E===\n",var1,var2);
  return i;
}

int float_e_6243c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_e_6243c===%+ 10.3E===%+ 10.3E===\n",var1,var2);
  return i;
}

int float_e_6244c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_6244c===%+ 10.10E===%+ 10.10E===\n",var1,var2);
  return i;
}

int float_e_63c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_63c===%hhe===%hhe===\n",var1,var2);
  return i;
}

int float_e_64c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_64c===%.1hhe===%.1hhe===\n",var1,var2);
  return i;
}

int float_e_65c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_65c===%.2hhe===%.2hhe===\n",var1,var2);
  return i;
}

int float_e_66c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_e_66c===%.3hhe===%.3hhe===\n",var1,var2);
  return i;
}

int float_e_67c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_67c===%.10hhe===%.10hhe===\n",var1,var2);
  return i;
}

int float_e_68c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_68c===%hhE===%hhE===\n",var1,var2);
  return i;
}

int float_e_6857c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_e_6857c===%+010e===%+010e===\n",var1,var2);
  return i;
}

int float_e_6858c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_6858c===%+010.1e===%+010.1e===\n",var1,var2);
  return i;
}

int float_e_6859c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_e_6859c===%+010.2e===%+010.2e===\n",var1,var2);
  return i;
}

int float_e_6860c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_e_6860c===%+010.3e===%+010.3e===\n",var1,var2);
  return i;
}

int float_e_6861c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_e_6861c===%+010.10e===%+010.10e===\n",var1,var2);
  return i;
}

int float_e_6862c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_6862c===%+010E===%+010E===\n",var1,var2);
  return i;
}

int float_e_6863c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_6863c===%+010.1E===%+010.1E===\n",var1,var2);
  return i;
}

int float_e_6864c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_e_6864c===%+010.2E===%+010.2E===\n",var1,var2);
  return i;
}

int float_e_6865c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_e_6865c===%+010.3E===%+010.3E===\n",var1,var2);
  return i;
}

int float_e_6866c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_e_6866c===%+010.10E===%+010.10E===\n",var1,var2);
  return i;
}

int float_e_69c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_69c===%.1hhE===%.1hhE===\n",var1,var2);
  return i;
}

int float_e_6903c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_6903c===%+010hhe===%+010hhe===\n",var1,var2);
  return i;
}

int float_e_6904c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_6904c===%+010.1hhe===%+010.1hhe===\n",var1,var2);
  return i;
}

int float_e_6905c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_6905c===%+010.2hhe===%+010.2hhe===\n",var1,var2);
  return i;
}

int float_e_6906c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_e_6906c===%+010.3hhe===%+010.3hhe===\n",var1,var2);
  return i;
}

int float_e_6907c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_e_6907c===%+010.10hhe===%+010.10hhe===\n",var1,var2);
  return i;
}

int float_e_6908c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_6908c===%+010hhE===%+010hhE===\n",var1,var2);
  return i;
}

int float_e_6909c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_6909c===%+010.1hhE===%+010.1hhE===\n",var1,var2);
  return i;
}

int float_e_6910c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_6910c===%+010.2hhE===%+010.2hhE===\n",var1,var2);
  return i;
}

int float_e_6911c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_e_6911c===%+010.3hhE===%+010.3hhE===\n",var1,var2);
  return i;
}

int float_e_6912c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_e_6912c===%+010.10hhE===%+010.10hhE===\n",var1,var2);
  return i;
}

int float_e_6949c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_6949c===%+010he===%+010he===\n",var1,var2);
  return i;
}

int float_e_6950c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_e_6950c===%+010.1he===%+010.1he===\n",var1,var2);
  return i;
}

int float_e_6951c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_6951c===%+010.2he===%+010.2he===\n",var1,var2);
  return i;
}

int float_e_6952c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_e_6952c===%+010.3he===%+010.3he===\n",var1,var2);
  return i;
}

int float_e_6953c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_e_6953c===%+010.10he===%+010.10he===\n",var1,var2);
  return i;
}

int float_e_6954c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_e_6954c===%+010hE===%+010hE===\n",var1,var2);
  return i;
}

int float_e_6955c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_6955c===%+010.1hE===%+010.1hE===\n",var1,var2);
  return i;
}

int float_e_6956c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_e_6956c===%+010.2hE===%+010.2hE===\n",var1,var2);
  return i;
}

int float_e_6957c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_e_6957c===%+010.3hE===%+010.3hE===\n",var1,var2);
  return i;
}

int float_e_6958c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_6958c===%+010.10hE===%+010.10hE===\n",var1,var2);
  return i;
}

int float_e_6995c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_6995c===%+010e===%+010e===\n",var1,var2);
  return i;
}

int float_e_6996c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_e_6996c===%+010.1e===%+010.1e===\n",var1,var2);
  return i;
}

int float_e_6997c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_e_6997c===%+010.2e===%+010.2e===\n",var1,var2);
  return i;
}

int float_e_6998c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_e_6998c===%+010.3e===%+010.3e===\n",var1,var2);
  return i;
}

int float_e_6999c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_6999c===%+010.10e===%+010.10e===\n",var1,var2);
  return i;
}

int float_e_70c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_e_70c===%.2hhE===%.2hhE===\n",var1,var2);
  return i;
}

int float_e_7000c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_e_7000c===%+010E===%+010E===\n",var1,var2);
  return i;
}

int float_e_7001c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_7001c===%+010.1E===%+010.1E===\n",var1,var2);
  return i;
}

int float_e_7002c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_7002c===%+010.2E===%+010.2E===\n",var1,var2);
  return i;
}

int float_e_7003c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_7003c===%+010.3E===%+010.3E===\n",var1,var2);
  return i;
}

int float_e_7004c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_e_7004c===%+010.10E===%+010.10E===\n",var1,var2);
  return i;
}

int float_e_71c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_e_71c===%.3hhE===%.3hhE===\n",var1,var2);
  return i;
}

int float_e_72c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_72c===%.10hhE===%.10hhE===\n",var1,var2);
  return i;
}

int float_e_777c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_777c===%-e===%-e===\n",var1,var2);
  return i;
}

int float_e_778c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_e_778c===%-.1e===%-.1e===\n",var1,var2);
  return i;
}

int float_e_779c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_779c===%-.2e===%-.2e===\n",var1,var2);
  return i;
}

int float_e_780c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_780c===%-.3e===%-.3e===\n",var1,var2);
  return i;
}

int float_e_781c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_781c===%-.10e===%-.10e===\n",var1,var2);
  return i;
}

int float_e_782c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_782c===%-E===%-E===\n",var1,var2);
  return i;
}

int float_e_783c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_e_783c===%-.1E===%-.1E===\n",var1,var2);
  return i;
}

int float_e_784c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_784c===%-.2E===%-.2E===\n",var1,var2);
  return i;
}

int float_e_785c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_e_785c===%-.3E===%-.3E===\n",var1,var2);
  return i;
}

int float_e_786c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_e_786c===%-.10E===%-.10E===\n",var1,var2);
  return i;
}

int float_e_823c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_823c===%-hhe===%-hhe===\n",var1,var2);
  return i;
}

int float_e_824c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_824c===%-.1hhe===%-.1hhe===\n",var1,var2);
  return i;
}

int float_e_825c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_e_825c===%-.2hhe===%-.2hhe===\n",var1,var2);
  return i;
}

int float_e_826c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_e_826c===%-.3hhe===%-.3hhe===\n",var1,var2);
  return i;
}

int float_e_827c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_e_827c===%-.10hhe===%-.10hhe===\n",var1,var2);
  return i;
}

int float_e_828c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_e_828c===%-hhE===%-hhE===\n",var1,var2);
  return i;
}

int float_e_829c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_e_829c===%-.1hhE===%-.1hhE===\n",var1,var2);
  return i;
}

int float_e_830c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_830c===%-.2hhE===%-.2hhE===\n",var1,var2);
  return i;
}

int float_e_831c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_e_831c===%-.3hhE===%-.3hhE===\n",var1,var2);
  return i;
}

int float_e_832c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_832c===%-.10hhE===%-.10hhE===\n",var1,var2);
  return i;
}

int float_e_869c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_869c===%-he===%-he===\n",var1,var2);
  return i;
}

int float_e_870c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_870c===%-.1he===%-.1he===\n",var1,var2);
  return i;
}

int float_e_871c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_e_871c===%-.2he===%-.2he===\n",var1,var2);
  return i;
}

int float_e_872c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_e_872c===%-.3he===%-.3he===\n",var1,var2);
  return i;
}

int float_e_873c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_e_873c===%-.10he===%-.10he===\n",var1,var2);
  return i;
}

int float_e_874c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_874c===%-hE===%-hE===\n",var1,var2);
  return i;
}

int float_e_875c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_e_875c===%-.1hE===%-.1hE===\n",var1,var2);
  return i;
}

int float_e_876c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_876c===%-.2hE===%-.2hE===\n",var1,var2);
  return i;
}

int float_e_877c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_e_877c===%-.3hE===%-.3hE===\n",var1,var2);
  return i;
}

int float_e_878c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_878c===%-.10hE===%-.10hE===\n",var1,var2);
  return i;
}

int float_e_915c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_915c===%-e===%-e===\n",var1,var2);
  return i;
}

int float_e_916c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_e_916c===%-.1e===%-.1e===\n",var1,var2);
  return i;
}

int float_e_917c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_917c===%-.2e===%-.2e===\n",var1,var2);
  return i;
}

int float_e_918c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_e_918c===%-.3e===%-.3e===\n",var1,var2);
  return i;
}

int float_e_919c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_e_919c===%-.10e===%-.10e===\n",var1,var2);
  return i;
}

int float_e_920c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_e_920c===%-E===%-E===\n",var1,var2);
  return i;
}

int float_e_921c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_e_921c===%-.1E===%-.1E===\n",var1,var2);
  return i;
}

int float_e_922c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_922c===%-.2E===%-.2E===\n",var1,var2);
  return i;
}

int float_e_923c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_e_923c===%-.3E===%-.3E===\n",var1,var2);
  return i;
}

int float_e_924c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_e_924c===%-.10E===%-.10E===\n",var1,var2);
  return i;
}

int float_f_119c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_119c===%hf===%hf===\n",var1,var2);
  return i;
}

int float_f_120c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_120c===%.1hf===%.1hf===\n",var1,var2);
  return i;
}

int float_f_121c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_121c===%.2hf===%.2hf===\n",var1,var2);
  return i;
}

int float_f_122c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_f_122c===%.3hf===%.3hf===\n",var1,var2);
  return i;
}

int float_f_123c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_f_123c===%.10hf===%.10hf===\n",var1,var2);
  return i;
}

int float_f_124c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_f_124c===%hF===%hF===\n",var1,var2);
  return i;
}

int float_f_125c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_f_125c===%.1hF===%.1hF===\n",var1,var2);
  return i;
}

int float_f_126c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_f_126c===%.2hF===%.2hF===\n",var1,var2);
  return i;
}

int float_f_127c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_127c===%.3hF===%.3hF===\n",var1,var2);
  return i;
}

int float_f_128c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_f_128c===%.10hF===%.10hF===\n",var1,var2);
  return i;
}

int float_f_1547c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_1547c===%+f===%+f===\n",var1,var2);
  return i;
}

int float_f_1548c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_1548c===%+.1f===%+.1f===\n",var1,var2);
  return i;
}

int float_f_1549c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_f_1549c===%+.2f===%+.2f===\n",var1,var2);
  return i;
}

int float_f_1550c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_1550c===%+.3f===%+.3f===\n",var1,var2);
  return i;
}

int float_f_1551c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_1551c===%+.10f===%+.10f===\n",var1,var2);
  return i;
}

int float_f_1552c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_f_1552c===%+F===%+F===\n",var1,var2);
  return i;
}

int float_f_1553c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_1553c===%+.1F===%+.1F===\n",var1,var2);
  return i;
}

int float_f_1554c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_1554c===%+.2F===%+.2F===\n",var1,var2);
  return i;
}

int float_f_1555c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_1555c===%+.3F===%+.3F===\n",var1,var2);
  return i;
}

int float_f_1556c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_f_1556c===%+.10F===%+.10F===\n",var1,var2);
  return i;
}

int float_f_1593c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_1593c===%+hhf===%+hhf===\n",var1,var2);
  return i;
}

int float_f_1594c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_1594c===%+.1hhf===%+.1hhf===\n",var1,var2);
  return i;
}

int float_f_1595c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_1595c===%+.2hhf===%+.2hhf===\n",var1,var2);
  return i;
}

int float_f_1596c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_1596c===%+.3hhf===%+.3hhf===\n",var1,var2);
  return i;
}

int float_f_1597c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_1597c===%+.10hhf===%+.10hhf===\n",var1,var2);
  return i;
}

int float_f_1598c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_f_1598c===%+hhF===%+hhF===\n",var1,var2);
  return i;
}

int float_f_1599c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_f_1599c===%+.1hhF===%+.1hhF===\n",var1,var2);
  return i;
}

int float_f_1600c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_f_1600c===%+.2hhF===%+.2hhF===\n",var1,var2);
  return i;
}

int float_f_1601c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_1601c===%+.3hhF===%+.3hhF===\n",var1,var2);
  return i;
}

int float_f_1602c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_f_1602c===%+.10hhF===%+.10hhF===\n",var1,var2);
  return i;
}

int float_f_1639c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_1639c===%+hf===%+hf===\n",var1,var2);
  return i;
}

int float_f_1640c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_f_1640c===%+.1hf===%+.1hf===\n",var1,var2);
  return i;
}

int float_f_1641c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_1641c===%+.2hf===%+.2hf===\n",var1,var2);
  return i;
}

int float_f_1642c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_f_1642c===%+.3hf===%+.3hf===\n",var1,var2);
  return i;
}

int float_f_1643c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_f_1643c===%+.10hf===%+.10hf===\n",var1,var2);
  return i;
}

int float_f_1644c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_1644c===%+hF===%+hF===\n",var1,var2);
  return i;
}

int float_f_1645c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_f_1645c===%+.1hF===%+.1hF===\n",var1,var2);
  return i;
}

int float_f_1646c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_f_1646c===%+.2hF===%+.2hF===\n",var1,var2);
  return i;
}

int float_f_1647c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_f_1647c===%+.3hF===%+.3hF===\n",var1,var2);
  return i;
}

int float_f_1648c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_1648c===%+.10hF===%+.10hF===\n",var1,var2);
  return i;
}

int float_f_165c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_165c===%f===%f===\n",var1,var2);
  return i;
}

int float_f_166c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_f_166c===%.1f===%.1f===\n",var1,var2);
  return i;
}

int float_f_167c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_167c===%.2f===%.2f===\n",var1,var2);
  return i;
}

int float_f_168c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_f_168c===%.3f===%.3f===\n",var1,var2);
  return i;
}

int float_f_1685c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_1685c===%+f===%+f===\n",var1,var2);
  return i;
}

int float_f_1686c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_1686c===%+.1f===%+.1f===\n",var1,var2);
  return i;
}

int float_f_1687c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_f_1687c===%+.2f===%+.2f===\n",var1,var2);
  return i;
}

int float_f_1688c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_f_1688c===%+.3f===%+.3f===\n",var1,var2);
  return i;
}

int float_f_1689c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_f_1689c===%+.10f===%+.10f===\n",var1,var2);
  return i;
}

int float_f_169c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_169c===%.10f===%.10f===\n",var1,var2);
  return i;
}

int float_f_1690c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_f_1690c===%+F===%+F===\n",var1,var2);
  return i;
}

int float_f_1691c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_1691c===%+.1F===%+.1F===\n",var1,var2);
  return i;
}

int float_f_1692c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_f_1692c===%+.2F===%+.2F===\n",var1,var2);
  return i;
}

int float_f_1693c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_1693c===%+.3F===%+.3F===\n",var1,var2);
  return i;
}

int float_f_1694c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_1694c===%+.10F===%+.10F===\n",var1,var2);
  return i;
}

int float_f_170c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_f_170c===%F===%F===\n",var1,var2);
  return i;
}

int float_f_171c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_171c===%.1F===%.1F===\n",var1,var2);
  return i;
}

int float_f_172c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_f_172c===%.2F===%.2F===\n",var1,var2);
  return i;
}

int float_f_173c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_173c===%.3F===%.3F===\n",var1,var2);
  return i;
}

int float_f_174c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_174c===%.10F===%.10F===\n",var1,var2);
  return i;
}

int float_f_2307c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_f_2307c===%#f===%#f===\n",var1,var2);
  return i;
}

int float_f_2308c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_f_2308c===%#.1f===%#.1f===\n",var1,var2);
  return i;
}

int float_f_2309c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_2309c===%#.2f===%#.2f===\n",var1,var2);
  return i;
}

int float_f_2310c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_2310c===%#.3f===%#.3f===\n",var1,var2);
  return i;
}

int float_f_2311c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_f_2311c===%#.10f===%#.10f===\n",var1,var2);
  return i;
}

int float_f_2312c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_f_2312c===%#F===%#F===\n",var1,var2);
  return i;
}

int float_f_2313c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_f_2313c===%#.1F===%#.1F===\n",var1,var2);
  return i;
}

int float_f_2314c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_2314c===%#.2F===%#.2F===\n",var1,var2);
  return i;
}

int float_f_2315c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_2315c===%#.3F===%#.3F===\n",var1,var2);
  return i;
}

int float_f_2316c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_2316c===%#.10F===%#.10F===\n",var1,var2);
  return i;
}

int float_f_2353c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_f_2353c===%#hhf===%#hhf===\n",var1,var2);
  return i;
}

int float_f_2354c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_f_2354c===%#.1hhf===%#.1hhf===\n",var1,var2);
  return i;
}

int float_f_2355c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_2355c===%#.2hhf===%#.2hhf===\n",var1,var2);
  return i;
}

int float_f_2356c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_f_2356c===%#.3hhf===%#.3hhf===\n",var1,var2);
  return i;
}

int float_f_2357c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_2357c===%#.10hhf===%#.10hhf===\n",var1,var2);
  return i;
}

int float_f_2358c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_2358c===%#hhF===%#hhF===\n",var1,var2);
  return i;
}

int float_f_2359c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_2359c===%#.1hhF===%#.1hhF===\n",var1,var2);
  return i;
}

int float_f_2360c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_f_2360c===%#.2hhF===%#.2hhF===\n",var1,var2);
  return i;
}

int float_f_2361c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_2361c===%#.3hhF===%#.3hhF===\n",var1,var2);
  return i;
}

int float_f_2362c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_f_2362c===%#.10hhF===%#.10hhF===\n",var1,var2);
  return i;
}

int float_f_2399c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_f_2399c===%#hf===%#hf===\n",var1,var2);
  return i;
}

int float_f_2400c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_f_2400c===%#.1hf===%#.1hf===\n",var1,var2);
  return i;
}

int float_f_2401c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_2401c===%#.2hf===%#.2hf===\n",var1,var2);
  return i;
}

int float_f_2402c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_f_2402c===%#.3hf===%#.3hf===\n",var1,var2);
  return i;
}

int float_f_2403c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_2403c===%#.10hf===%#.10hf===\n",var1,var2);
  return i;
}

int float_f_2404c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_2404c===%#hF===%#hF===\n",var1,var2);
  return i;
}

int float_f_2405c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_2405c===%#.1hF===%#.1hF===\n",var1,var2);
  return i;
}

int float_f_2406c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_f_2406c===%#.2hF===%#.2hF===\n",var1,var2);
  return i;
}

int float_f_2407c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_2407c===%#.3hF===%#.3hF===\n",var1,var2);
  return i;
}

int float_f_2408c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_2408c===%#.10hF===%#.10hF===\n",var1,var2);
  return i;
}

int float_f_2445c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_2445c===%#f===%#f===\n",var1,var2);
  return i;
}

int float_f_2446c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_f_2446c===%#.1f===%#.1f===\n",var1,var2);
  return i;
}

int float_f_2447c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_2447c===%#.2f===%#.2f===\n",var1,var2);
  return i;
}

int float_f_2448c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_2448c===%#.3f===%#.3f===\n",var1,var2);
  return i;
}

int float_f_2449c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_f_2449c===%#.10f===%#.10f===\n",var1,var2);
  return i;
}

int float_f_2450c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_2450c===%#F===%#F===\n",var1,var2);
  return i;
}

int float_f_2451c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_2451c===%#.1F===%#.1F===\n",var1,var2);
  return i;
}

int float_f_2452c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_2452c===%#.2F===%#.2F===\n",var1,var2);
  return i;
}

int float_f_2453c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_f_2453c===%#.3F===%#.3F===\n",var1,var2);
  return i;
}

int float_f_2454c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_f_2454c===%#.10F===%#.10F===\n",var1,var2);
  return i;
}

int float_f_27c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_27c===%f===%f===\n",var1,var2);
  return i;
}

int float_f_28c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_28c===%.1f===%.1f===\n",var1,var2);
  return i;
}

int float_f_29c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_29c===%.2f===%.2f===\n",var1,var2);
  return i;
}

int float_f_30c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_f_30c===%.3f===%.3f===\n",var1,var2);
  return i;
}

int float_f_3067c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_3067c===%-+f===%-+f===\n",var1,var2);
  return i;
}

int float_f_3068c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_3068c===%-+.1f===%-+.1f===\n",var1,var2);
  return i;
}

int float_f_3069c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_f_3069c===%-+.2f===%-+.2f===\n",var1,var2);
  return i;
}

int float_f_3070c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_f_3070c===%-+.3f===%-+.3f===\n",var1,var2);
  return i;
}

int float_f_3071c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_3071c===%-+.10f===%-+.10f===\n",var1,var2);
  return i;
}

int float_f_3072c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_3072c===%-+F===%-+F===\n",var1,var2);
  return i;
}

int float_f_3073c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_f_3073c===%-+.1F===%-+.1F===\n",var1,var2);
  return i;
}

int float_f_3074c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_3074c===%-+.2F===%-+.2F===\n",var1,var2);
  return i;
}

int float_f_3075c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_3075c===%-+.3F===%-+.3F===\n",var1,var2);
  return i;
}

int float_f_3076c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_3076c===%-+.10F===%-+.10F===\n",var1,var2);
  return i;
}

int float_f_31c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_31c===%.10f===%.10f===\n",var1,var2);
  return i;
}

int float_f_3113c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_3113c===%-+hhf===%-+hhf===\n",var1,var2);
  return i;
}

int float_f_3114c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_3114c===%-+.1hhf===%-+.1hhf===\n",var1,var2);
  return i;
}

int float_f_3115c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_f_3115c===%-+.2hhf===%-+.2hhf===\n",var1,var2);
  return i;
}

int float_f_3116c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_3116c===%-+.3hhf===%-+.3hhf===\n",var1,var2);
  return i;
}

int float_f_3117c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_f_3117c===%-+.10hhf===%-+.10hhf===\n",var1,var2);
  return i;
}

int float_f_3118c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_3118c===%-+hhF===%-+hhF===\n",var1,var2);
  return i;
}

int float_f_3119c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_3119c===%-+.1hhF===%-+.1hhF===\n",var1,var2);
  return i;
}

int float_f_3120c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_3120c===%-+.2hhF===%-+.2hhF===\n",var1,var2);
  return i;
}

int float_f_3121c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_3121c===%-+.3hhF===%-+.3hhF===\n",var1,var2);
  return i;
}

int float_f_3122c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_f_3122c===%-+.10hhF===%-+.10hhF===\n",var1,var2);
  return i;
}

int float_f_3159c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_3159c===%-+hf===%-+hf===\n",var1,var2);
  return i;
}

int float_f_3160c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_3160c===%-+.1hf===%-+.1hf===\n",var1,var2);
  return i;
}

int float_f_3161c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_3161c===%-+.2hf===%-+.2hf===\n",var1,var2);
  return i;
}

int float_f_3162c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_3162c===%-+.3hf===%-+.3hf===\n",var1,var2);
  return i;
}

int float_f_3163c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_3163c===%-+.10hf===%-+.10hf===\n",var1,var2);
  return i;
}

int float_f_3164c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_3164c===%-+hF===%-+hF===\n",var1,var2);
  return i;
}

int float_f_3165c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_3165c===%-+.1hF===%-+.1hF===\n",var1,var2);
  return i;
}

int float_f_3166c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_f_3166c===%-+.2hF===%-+.2hF===\n",var1,var2);
  return i;
}

int float_f_3167c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_f_3167c===%-+.3hF===%-+.3hF===\n",var1,var2);
  return i;
}

int float_f_3168c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_3168c===%-+.10hF===%-+.10hF===\n",var1,var2);
  return i;
}

int float_f_32c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_f_32c===%F===%F===\n",var1,var2);
  return i;
}

int float_f_3205c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_f_3205c===%-+f===%-+f===\n",var1,var2);
  return i;
}

int float_f_3206c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_f_3206c===%-+.1f===%-+.1f===\n",var1,var2);
  return i;
}

int float_f_3207c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_3207c===%-+.2f===%-+.2f===\n",var1,var2);
  return i;
}

int float_f_3208c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_3208c===%-+.3f===%-+.3f===\n",var1,var2);
  return i;
}

int float_f_3209c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_3209c===%-+.10f===%-+.10f===\n",var1,var2);
  return i;
}

int float_f_3210c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_3210c===%-+F===%-+F===\n",var1,var2);
  return i;
}

int float_f_3211c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_3211c===%-+.1F===%-+.1F===\n",var1,var2);
  return i;
}

int float_f_3212c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_3212c===%-+.2F===%-+.2F===\n",var1,var2);
  return i;
}

int float_f_3213c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_3213c===%-+.3F===%-+.3F===\n",var1,var2);
  return i;
}

int float_f_3214c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_3214c===%-+.10F===%-+.10F===\n",var1,var2);
  return i;
}

int float_f_33c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_33c===%.1F===%.1F===\n",var1,var2);
  return i;
}

int float_f_34c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_34c===%.2F===%.2F===\n",var1,var2);
  return i;
}

int float_f_35c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_35c===%.3F===%.3F===\n",var1,var2);
  return i;
}

int float_f_36c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_f_36c===%.10F===%.10F===\n",var1,var2);
  return i;
}

int float_f_3827c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_f_3827c===% 10f===% 10f===\n",var1,var2);
  return i;
}

int float_f_3828c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_3828c===% 10.1f===% 10.1f===\n",var1,var2);
  return i;
}

int float_f_3829c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_f_3829c===% 10.2f===% 10.2f===\n",var1,var2);
  return i;
}

int float_f_3830c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_f_3830c===% 10.3f===% 10.3f===\n",var1,var2);
  return i;
}

int float_f_3831c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_3831c===% 10.10f===% 10.10f===\n",var1,var2);
  return i;
}

int float_f_3832c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_3832c===% 10F===% 10F===\n",var1,var2);
  return i;
}

int float_f_3833c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_3833c===% 10.1F===% 10.1F===\n",var1,var2);
  return i;
}

int float_f_3834c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_3834c===% 10.2F===% 10.2F===\n",var1,var2);
  return i;
}

int float_f_3835c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_3835c===% 10.3F===% 10.3F===\n",var1,var2);
  return i;
}

int float_f_3836c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_3836c===% 10.10F===% 10.10F===\n",var1,var2);
  return i;
}

int float_f_3873c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_f_3873c===% 10hhf===% 10hhf===\n",var1,var2);
  return i;
}

int float_f_3874c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_3874c===% 10.1hhf===% 10.1hhf===\n",var1,var2);
  return i;
}

int float_f_3875c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_3875c===% 10.2hhf===% 10.2hhf===\n",var1,var2);
  return i;
}

int float_f_3876c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_3876c===% 10.3hhf===% 10.3hhf===\n",var1,var2);
  return i;
}

int float_f_3877c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_3877c===% 10.10hhf===% 10.10hhf===\n",var1,var2);
  return i;
}

int float_f_3878c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_3878c===% 10hhF===% 10hhF===\n",var1,var2);
  return i;
}

int float_f_3879c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_3879c===% 10.1hhF===% 10.1hhF===\n",var1,var2);
  return i;
}

int float_f_3880c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_3880c===% 10.2hhF===% 10.2hhF===\n",var1,var2);
  return i;
}

int float_f_3881c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_3881c===% 10.3hhF===% 10.3hhF===\n",var1,var2);
  return i;
}

int float_f_3882c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_3882c===% 10.10hhF===% 10.10hhF===\n",var1,var2);
  return i;
}

int float_f_3919c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_3919c===% 10hf===% 10hf===\n",var1,var2);
  return i;
}

int float_f_3920c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_3920c===% 10.1hf===% 10.1hf===\n",var1,var2);
  return i;
}

int float_f_3921c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_3921c===% 10.2hf===% 10.2hf===\n",var1,var2);
  return i;
}

int float_f_3922c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_f_3922c===% 10.3hf===% 10.3hf===\n",var1,var2);
  return i;
}

int float_f_3923c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_f_3923c===% 10.10hf===% 10.10hf===\n",var1,var2);
  return i;
}

int float_f_3924c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_3924c===% 10hF===% 10hF===\n",var1,var2);
  return i;
}

int float_f_3925c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_3925c===% 10.1hF===% 10.1hF===\n",var1,var2);
  return i;
}

int float_f_3926c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_3926c===% 10.2hF===% 10.2hF===\n",var1,var2);
  return i;
}

int float_f_3927c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_3927c===% 10.3hF===% 10.3hF===\n",var1,var2);
  return i;
}

int float_f_3928c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_3928c===% 10.10hF===% 10.10hF===\n",var1,var2);
  return i;
}

int float_f_3965c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_f_3965c===% 10f===% 10f===\n",var1,var2);
  return i;
}

int float_f_3966c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_3966c===% 10.1f===% 10.1f===\n",var1,var2);
  return i;
}

int float_f_3967c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_f_3967c===% 10.2f===% 10.2f===\n",var1,var2);
  return i;
}

int float_f_3968c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_f_3968c===% 10.3f===% 10.3f===\n",var1,var2);
  return i;
}

int float_f_3969c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_f_3969c===% 10.10f===% 10.10f===\n",var1,var2);
  return i;
}

int float_f_3970c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_3970c===% 10F===% 10F===\n",var1,var2);
  return i;
}

int float_f_3971c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_3971c===% 10.1F===% 10.1F===\n",var1,var2);
  return i;
}

int float_f_3972c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_3972c===% 10.2F===% 10.2F===\n",var1,var2);
  return i;
}

int float_f_3973c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_3973c===% 10.3F===% 10.3F===\n",var1,var2);
  return i;
}

int float_f_3974c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_3974c===% 10.10F===% 10.10F===\n",var1,var2);
  return i;
}

int float_f_4587c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_f_4587c===%010f===%010f===\n",var1,var2);
  return i;
}

int float_f_4588c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_4588c===%010.1f===%010.1f===\n",var1,var2);
  return i;
}

int float_f_4589c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_4589c===%010.2f===%010.2f===\n",var1,var2);
  return i;
}

int float_f_4590c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_f_4590c===%010.3f===%010.3f===\n",var1,var2);
  return i;
}

int float_f_4591c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_4591c===%010.10f===%010.10f===\n",var1,var2);
  return i;
}

int float_f_4592c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_4592c===%010F===%010F===\n",var1,var2);
  return i;
}

int float_f_4593c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_f_4593c===%010.1F===%010.1F===\n",var1,var2);
  return i;
}

int float_f_4594c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_4594c===%010.2F===%010.2F===\n",var1,var2);
  return i;
}

int float_f_4595c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_4595c===%010.3F===%010.3F===\n",var1,var2);
  return i;
}

int float_f_4596c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_4596c===%010.10F===%010.10F===\n",var1,var2);
  return i;
}

int float_f_4633c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_4633c===%010hhf===%010hhf===\n",var1,var2);
  return i;
}

int float_f_4634c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_4634c===%010.1hhf===%010.1hhf===\n",var1,var2);
  return i;
}

int float_f_4635c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_4635c===%010.2hhf===%010.2hhf===\n",var1,var2);
  return i;
}

int float_f_4636c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_f_4636c===%010.3hhf===%010.3hhf===\n",var1,var2);
  return i;
}

int float_f_4637c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_4637c===%010.10hhf===%010.10hhf===\n",var1,var2);
  return i;
}

int float_f_4638c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_4638c===%010hhF===%010hhF===\n",var1,var2);
  return i;
}

int float_f_4639c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_f_4639c===%010.1hhF===%010.1hhF===\n",var1,var2);
  return i;
}

int float_f_4640c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_4640c===%010.2hhF===%010.2hhF===\n",var1,var2);
  return i;
}

int float_f_4641c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_f_4641c===%010.3hhF===%010.3hhF===\n",var1,var2);
  return i;
}

int float_f_4642c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_f_4642c===%010.10hhF===%010.10hhF===\n",var1,var2);
  return i;
}

int float_f_4679c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_f_4679c===%010hf===%010hf===\n",var1,var2);
  return i;
}

int float_f_4680c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_4680c===%010.1hf===%010.1hf===\n",var1,var2);
  return i;
}

int float_f_4681c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_4681c===%010.2hf===%010.2hf===\n",var1,var2);
  return i;
}

int float_f_4682c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_f_4682c===%010.3hf===%010.3hf===\n",var1,var2);
  return i;
}

int float_f_4683c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_f_4683c===%010.10hf===%010.10hf===\n",var1,var2);
  return i;
}

int float_f_4684c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_4684c===%010hF===%010hF===\n",var1,var2);
  return i;
}

int float_f_4685c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_f_4685c===%010.1hF===%010.1hF===\n",var1,var2);
  return i;
}

int float_f_4686c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_4686c===%010.2hF===%010.2hF===\n",var1,var2);
  return i;
}

int float_f_4687c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_4687c===%010.3hF===%010.3hF===\n",var1,var2);
  return i;
}

int float_f_4688c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_4688c===%010.10hF===%010.10hF===\n",var1,var2);
  return i;
}

int float_f_4725c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_f_4725c===%010f===%010f===\n",var1,var2);
  return i;
}

int float_f_4726c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_4726c===%010.1f===%010.1f===\n",var1,var2);
  return i;
}

int float_f_4727c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_4727c===%010.2f===%010.2f===\n",var1,var2);
  return i;
}

int float_f_4728c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_4728c===%010.3f===%010.3f===\n",var1,var2);
  return i;
}

int float_f_4729c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_4729c===%010.10f===%010.10f===\n",var1,var2);
  return i;
}

int float_f_4730c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_4730c===%010F===%010F===\n",var1,var2);
  return i;
}

int float_f_4731c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_f_4731c===%010.1F===%010.1F===\n",var1,var2);
  return i;
}

int float_f_4732c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_4732c===%010.2F===%010.2F===\n",var1,var2);
  return i;
}

int float_f_4733c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_f_4733c===%010.3F===%010.3F===\n",var1,var2);
  return i;
}

int float_f_4734c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_4734c===%010.10F===%010.10F===\n",var1,var2);
  return i;
}

int float_f_5347c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_f_5347c===%- 10f===%- 10f===\n",var1,var2);
  return i;
}

int float_f_5348c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_5348c===%- 10.1f===%- 10.1f===\n",var1,var2);
  return i;
}

int float_f_5349c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_5349c===%- 10.2f===%- 10.2f===\n",var1,var2);
  return i;
}

int float_f_5350c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_5350c===%- 10.3f===%- 10.3f===\n",var1,var2);
  return i;
}

int float_f_5351c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_5351c===%- 10.10f===%- 10.10f===\n",var1,var2);
  return i;
}

int float_f_5352c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_5352c===%- 10F===%- 10F===\n",var1,var2);
  return i;
}

int float_f_5353c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_5353c===%- 10.1F===%- 10.1F===\n",var1,var2);
  return i;
}

int float_f_5354c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_f_5354c===%- 10.2F===%- 10.2F===\n",var1,var2);
  return i;
}

int float_f_5355c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_5355c===%- 10.3F===%- 10.3F===\n",var1,var2);
  return i;
}

int float_f_5356c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_5356c===%- 10.10F===%- 10.10F===\n",var1,var2);
  return i;
}

int float_f_5393c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_5393c===%- 10hhf===%- 10hhf===\n",var1,var2);
  return i;
}

int float_f_5394c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_5394c===%- 10.1hhf===%- 10.1hhf===\n",var1,var2);
  return i;
}

int float_f_5395c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_f_5395c===%- 10.2hhf===%- 10.2hhf===\n",var1,var2);
  return i;
}

int float_f_5396c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_5396c===%- 10.3hhf===%- 10.3hhf===\n",var1,var2);
  return i;
}

int float_f_5397c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_5397c===%- 10.10hhf===%- 10.10hhf===\n",var1,var2);
  return i;
}

int float_f_5398c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_5398c===%- 10hhF===%- 10hhF===\n",var1,var2);
  return i;
}

int float_f_5399c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_5399c===%- 10.1hhF===%- 10.1hhF===\n",var1,var2);
  return i;
}

int float_f_5400c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_5400c===%- 10.2hhF===%- 10.2hhF===\n",var1,var2);
  return i;
}

int float_f_5401c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_f_5401c===%- 10.3hhF===%- 10.3hhF===\n",var1,var2);
  return i;
}

int float_f_5402c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_5402c===%- 10.10hhF===%- 10.10hhF===\n",var1,var2);
  return i;
}

int float_f_5439c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_f_5439c===%- 10hf===%- 10hf===\n",var1,var2);
  return i;
}

int float_f_5440c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_5440c===%- 10.1hf===%- 10.1hf===\n",var1,var2);
  return i;
}

int float_f_5441c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_f_5441c===%- 10.2hf===%- 10.2hf===\n",var1,var2);
  return i;
}

int float_f_5442c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_5442c===%- 10.3hf===%- 10.3hf===\n",var1,var2);
  return i;
}

int float_f_5443c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_f_5443c===%- 10.10hf===%- 10.10hf===\n",var1,var2);
  return i;
}

int float_f_5444c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_5444c===%- 10hF===%- 10hF===\n",var1,var2);
  return i;
}

int float_f_5445c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_5445c===%- 10.1hF===%- 10.1hF===\n",var1,var2);
  return i;
}

int float_f_5446c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_5446c===%- 10.2hF===%- 10.2hF===\n",var1,var2);
  return i;
}

int float_f_5447c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_5447c===%- 10.3hF===%- 10.3hF===\n",var1,var2);
  return i;
}

int float_f_5448c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_5448c===%- 10.10hF===%- 10.10hF===\n",var1,var2);
  return i;
}

int float_f_5485c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_f_5485c===%- 10f===%- 10f===\n",var1,var2);
  return i;
}

int float_f_5486c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_5486c===%- 10.1f===%- 10.1f===\n",var1,var2);
  return i;
}

int float_f_5487c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_5487c===%- 10.2f===%- 10.2f===\n",var1,var2);
  return i;
}

int float_f_5488c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_5488c===%- 10.3f===%- 10.3f===\n",var1,var2);
  return i;
}

int float_f_5489c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_5489c===%- 10.10f===%- 10.10f===\n",var1,var2);
  return i;
}

int float_f_5490c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_5490c===%- 10F===%- 10F===\n",var1,var2);
  return i;
}

int float_f_5491c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_f_5491c===%- 10.1F===%- 10.1F===\n",var1,var2);
  return i;
}

int float_f_5492c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_5492c===%- 10.2F===%- 10.2F===\n",var1,var2);
  return i;
}

int float_f_5493c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_5493c===%- 10.3F===%- 10.3F===\n",var1,var2);
  return i;
}

int float_f_5494c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_5494c===%- 10.10F===%- 10.10F===\n",var1,var2);
  return i;
}

int float_f_6107c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_f_6107c===%+ 10f===%+ 10f===\n",var1,var2);
  return i;
}

int float_f_6108c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_6108c===%+ 10.1f===%+ 10.1f===\n",var1,var2);
  return i;
}

int float_f_6109c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_f_6109c===%+ 10.2f===%+ 10.2f===\n",var1,var2);
  return i;
}

int float_f_6110c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_f_6110c===%+ 10.3f===%+ 10.3f===\n",var1,var2);
  return i;
}

int float_f_6111c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_6111c===%+ 10.10f===%+ 10.10f===\n",var1,var2);
  return i;
}

int float_f_6112c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6112c===%+ 10F===%+ 10F===\n",var1,var2);
  return i;
}

int float_f_6113c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_6113c===%+ 10.1F===%+ 10.1F===\n",var1,var2);
  return i;
}

int float_f_6114c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6114c===%+ 10.2F===%+ 10.2F===\n",var1,var2);
  return i;
}

int float_f_6115c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6115c===%+ 10.3F===%+ 10.3F===\n",var1,var2);
  return i;
}

int float_f_6116c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6116c===%+ 10.10F===%+ 10.10F===\n",var1,var2);
  return i;
}

int float_f_6153c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6153c===%+ 10hhf===%+ 10hhf===\n",var1,var2);
  return i;
}

int float_f_6154c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6154c===%+ 10.1hhf===%+ 10.1hhf===\n",var1,var2);
  return i;
}

int float_f_6155c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_f_6155c===%+ 10.2hhf===%+ 10.2hhf===\n",var1,var2);
  return i;
}

int float_f_6156c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6156c===%+ 10.3hhf===%+ 10.3hhf===\n",var1,var2);
  return i;
}

int float_f_6157c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_6157c===%+ 10.10hhf===%+ 10.10hhf===\n",var1,var2);
  return i;
}

int float_f_6158c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_6158c===%+ 10hhF===%+ 10hhF===\n",var1,var2);
  return i;
}

int float_f_6159c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_6159c===%+ 10.1hhF===%+ 10.1hhF===\n",var1,var2);
  return i;
}

int float_f_6160c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_6160c===%+ 10.2hhF===%+ 10.2hhF===\n",var1,var2);
  return i;
}

int float_f_6161c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6161c===%+ 10.3hhF===%+ 10.3hhF===\n",var1,var2);
  return i;
}

int float_f_6162c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_6162c===%+ 10.10hhF===%+ 10.10hhF===\n",var1,var2);
  return i;
}

int float_f_6199c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_f_6199c===%+ 10hf===%+ 10hf===\n",var1,var2);
  return i;
}

int float_f_6200c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_f_6200c===%+ 10.1hf===%+ 10.1hf===\n",var1,var2);
  return i;
}

int float_f_6201c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_6201c===%+ 10.2hf===%+ 10.2hf===\n",var1,var2);
  return i;
}

int float_f_6202c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_f_6202c===%+ 10.3hf===%+ 10.3hf===\n",var1,var2);
  return i;
}

int float_f_6203c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_6203c===%+ 10.10hf===%+ 10.10hf===\n",var1,var2);
  return i;
}

int float_f_6204c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_f_6204c===%+ 10hF===%+ 10hF===\n",var1,var2);
  return i;
}

int float_f_6205c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_6205c===%+ 10.1hF===%+ 10.1hF===\n",var1,var2);
  return i;
}

int float_f_6206c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_f_6206c===%+ 10.2hF===%+ 10.2hF===\n",var1,var2);
  return i;
}

int float_f_6207c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_6207c===%+ 10.3hF===%+ 10.3hF===\n",var1,var2);
  return i;
}

int float_f_6208c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_6208c===%+ 10.10hF===%+ 10.10hF===\n",var1,var2);
  return i;
}

int float_f_6245c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_6245c===%+ 10f===%+ 10f===\n",var1,var2);
  return i;
}

int float_f_6246c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_6246c===%+ 10.1f===%+ 10.1f===\n",var1,var2);
  return i;
}

int float_f_6247c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_f_6247c===%+ 10.2f===%+ 10.2f===\n",var1,var2);
  return i;
}

int float_f_6248c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6248c===%+ 10.3f===%+ 10.3f===\n",var1,var2);
  return i;
}

int float_f_6249c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_6249c===%+ 10.10f===%+ 10.10f===\n",var1,var2);
  return i;
}

int float_f_6250c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_f_6250c===%+ 10F===%+ 10F===\n",var1,var2);
  return i;
}

int float_f_6251c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_6251c===%+ 10.1F===%+ 10.1F===\n",var1,var2);
  return i;
}

int float_f_6252c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_f_6252c===%+ 10.2F===%+ 10.2F===\n",var1,var2);
  return i;
}

int float_f_6253c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_6253c===%+ 10.3F===%+ 10.3F===\n",var1,var2);
  return i;
}

int float_f_6254c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_6254c===%+ 10.10F===%+ 10.10F===\n",var1,var2);
  return i;
}

int float_f_6867c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6867c===%+010f===%+010f===\n",var1,var2);
  return i;
}

int float_f_6868c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_6868c===%+010.1f===%+010.1f===\n",var1,var2);
  return i;
}

int float_f_6869c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_6869c===%+010.2f===%+010.2f===\n",var1,var2);
  return i;
}

int float_f_6870c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6870c===%+010.3f===%+010.3f===\n",var1,var2);
  return i;
}

int float_f_6871c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_f_6871c===%+010.10f===%+010.10f===\n",var1,var2);
  return i;
}

int float_f_6872c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6872c===%+010F===%+010F===\n",var1,var2);
  return i;
}

int float_f_6873c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_6873c===%+010.1F===%+010.1F===\n",var1,var2);
  return i;
}

int float_f_6874c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_f_6874c===%+010.2F===%+010.2F===\n",var1,var2);
  return i;
}

int float_f_6875c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_6875c===%+010.3F===%+010.3F===\n",var1,var2);
  return i;
}

int float_f_6876c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_6876c===%+010.10F===%+010.10F===\n",var1,var2);
  return i;
}

int float_f_6913c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_f_6913c===%+010hhf===%+010hhf===\n",var1,var2);
  return i;
}

int float_f_6914c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_6914c===%+010.1hhf===%+010.1hhf===\n",var1,var2);
  return i;
}

int float_f_6915c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_f_6915c===%+010.2hhf===%+010.2hhf===\n",var1,var2);
  return i;
}

int float_f_6916c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6916c===%+010.3hhf===%+010.3hhf===\n",var1,var2);
  return i;
}

int float_f_6917c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6917c===%+010.10hhf===%+010.10hhf===\n",var1,var2);
  return i;
}

int float_f_6918c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_f_6918c===%+010hhF===%+010hhF===\n",var1,var2);
  return i;
}

int float_f_6919c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_6919c===%+010.1hhF===%+010.1hhF===\n",var1,var2);
  return i;
}

int float_f_6920c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_6920c===%+010.2hhF===%+010.2hhF===\n",var1,var2);
  return i;
}

int float_f_6921c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_6921c===%+010.3hhF===%+010.3hhF===\n",var1,var2);
  return i;
}

int float_f_6922c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_f_6922c===%+010.10hhF===%+010.10hhF===\n",var1,var2);
  return i;
}

int float_f_6959c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_6959c===%+010hf===%+010hf===\n",var1,var2);
  return i;
}

int float_f_6960c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6960c===%+010.1hf===%+010.1hf===\n",var1,var2);
  return i;
}

int float_f_6961c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_6961c===%+010.2hf===%+010.2hf===\n",var1,var2);
  return i;
}

int float_f_6962c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6962c===%+010.3hf===%+010.3hf===\n",var1,var2);
  return i;
}

int float_f_6963c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_6963c===%+010.10hf===%+010.10hf===\n",var1,var2);
  return i;
}

int float_f_6964c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_6964c===%+010hF===%+010hF===\n",var1,var2);
  return i;
}

int float_f_6965c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6965c===%+010.1hF===%+010.1hF===\n",var1,var2);
  return i;
}

int float_f_6966c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_6966c===%+010.2hF===%+010.2hF===\n",var1,var2);
  return i;
}

int float_f_6967c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_6967c===%+010.3hF===%+010.3hF===\n",var1,var2);
  return i;
}

int float_f_6968c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_6968c===%+010.10hF===%+010.10hF===\n",var1,var2);
  return i;
}

int float_f_7005c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_f_7005c===%+010f===%+010f===\n",var1,var2);
  return i;
}

int float_f_7006c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_f_7006c===%+010.1f===%+010.1f===\n",var1,var2);
  return i;
}

int float_f_7007c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_f_7007c===%+010.2f===%+010.2f===\n",var1,var2);
  return i;
}

int float_f_7008c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_f_7008c===%+010.3f===%+010.3f===\n",var1,var2);
  return i;
}

int float_f_7009c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_7009c===%+010.10f===%+010.10f===\n",var1,var2);
  return i;
}

int float_f_7010c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_7010c===%+010F===%+010F===\n",var1,var2);
  return i;
}

int float_f_7011c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_7011c===%+010.1F===%+010.1F===\n",var1,var2);
  return i;
}

int float_f_7012c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_7012c===%+010.2F===%+010.2F===\n",var1,var2);
  return i;
}

int float_f_7013c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_f_7013c===%+010.3F===%+010.3F===\n",var1,var2);
  return i;
}

int float_f_7014c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_7014c===%+010.10F===%+010.10F===\n",var1,var2);
  return i;
}

int float_f_73c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_73c===%hhf===%hhf===\n",var1,var2);
  return i;
}

int float_f_74c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_74c===%.1hhf===%.1hhf===\n",var1,var2);
  return i;
}

int float_f_75c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_75c===%.2hhf===%.2hhf===\n",var1,var2);
  return i;
}

int float_f_76c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_76c===%.3hhf===%.3hhf===\n",var1,var2);
  return i;
}

int float_f_77c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_f_77c===%.10hhf===%.10hhf===\n",var1,var2);
  return i;
}

int float_f_78c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_78c===%hhF===%hhF===\n",var1,var2);
  return i;
}

int float_f_787c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_787c===%-f===%-f===\n",var1,var2);
  return i;
}

int float_f_788c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_788c===%-.1f===%-.1f===\n",var1,var2);
  return i;
}

int float_f_789c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_789c===%-.2f===%-.2f===\n",var1,var2);
  return i;
}

int float_f_79c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_f_79c===%.1hhF===%.1hhF===\n",var1,var2);
  return i;
}

int float_f_790c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_790c===%-.3f===%-.3f===\n",var1,var2);
  return i;
}

int float_f_791c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_791c===%-.10f===%-.10f===\n",var1,var2);
  return i;
}

int float_f_792c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_792c===%-F===%-F===\n",var1,var2);
  return i;
}

int float_f_793c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_f_793c===%-.1F===%-.1F===\n",var1,var2);
  return i;
}

int float_f_794c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_794c===%-.2F===%-.2F===\n",var1,var2);
  return i;
}

int float_f_795c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_795c===%-.3F===%-.3F===\n",var1,var2);
  return i;
}

int float_f_796c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_f_796c===%-.10F===%-.10F===\n",var1,var2);
  return i;
}

int float_f_80c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_f_80c===%.2hhF===%.2hhF===\n",var1,var2);
  return i;
}

int float_f_81c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_81c===%.3hhF===%.3hhF===\n",var1,var2);
  return i;
}

int float_f_82c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_82c===%.10hhF===%.10hhF===\n",var1,var2);
  return i;
}

int float_f_833c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_f_833c===%-hhf===%-hhf===\n",var1,var2);
  return i;
}

int float_f_834c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_834c===%-.1hhf===%-.1hhf===\n",var1,var2);
  return i;
}

int float_f_835c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_835c===%-.2hhf===%-.2hhf===\n",var1,var2);
  return i;
}

int float_f_836c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_836c===%-.3hhf===%-.3hhf===\n",var1,var2);
  return i;
}

int float_f_837c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_837c===%-.10hhf===%-.10hhf===\n",var1,var2);
  return i;
}

int float_f_838c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_838c===%-hhF===%-hhF===\n",var1,var2);
  return i;
}

int float_f_839c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_839c===%-.1hhF===%-.1hhF===\n",var1,var2);
  return i;
}

int float_f_840c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_f_840c===%-.2hhF===%-.2hhF===\n",var1,var2);
  return i;
}

int float_f_841c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_f_841c===%-.3hhF===%-.3hhF===\n",var1,var2);
  return i;
}

int float_f_842c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_842c===%-.10hhF===%-.10hhF===\n",var1,var2);
  return i;
}

int float_f_879c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_879c===%-hf===%-hf===\n",var1,var2);
  return i;
}

int float_f_880c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_880c===%-.1hf===%-.1hf===\n",var1,var2);
  return i;
}

int float_f_881c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_f_881c===%-.2hf===%-.2hf===\n",var1,var2);
  return i;
}

int float_f_882c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_882c===%-.3hf===%-.3hf===\n",var1,var2);
  return i;
}

int float_f_883c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_883c===%-.10hf===%-.10hf===\n",var1,var2);
  return i;
}

int float_f_884c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_884c===%-hF===%-hF===\n",var1,var2);
  return i;
}

int float_f_885c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_f_885c===%-.1hF===%-.1hF===\n",var1,var2);
  return i;
}

int float_f_886c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_886c===%-.2hF===%-.2hF===\n",var1,var2);
  return i;
}

int float_f_887c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_f_887c===%-.3hF===%-.3hF===\n",var1,var2);
  return i;
}

int float_f_888c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_f_888c===%-.10hF===%-.10hF===\n",var1,var2);
  return i;
}

int float_f_925c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_925c===%-f===%-f===\n",var1,var2);
  return i;
}

int float_f_926c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_f_926c===%-.1f===%-.1f===\n",var1,var2);
  return i;
}

int float_f_927c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_f_927c===%-.2f===%-.2f===\n",var1,var2);
  return i;
}

int float_f_928c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_f_928c===%-.3f===%-.3f===\n",var1,var2);
  return i;
}

int float_f_929c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_929c===%-.10f===%-.10f===\n",var1,var2);
  return i;
}

int float_f_930c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_f_930c===%-F===%-F===\n",var1,var2);
  return i;
}

int float_f_931c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_f_931c===%-.1F===%-.1F===\n",var1,var2);
  return i;
}

int float_f_932c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_932c===%-.2F===%-.2F===\n",var1,var2);
  return i;
}

int float_f_933c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_f_933c===%-.3F===%-.3F===\n",var1,var2);
  return i;
}

int float_f_934c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_f_934c===%-.10F===%-.10F===\n",var1,var2);
  return i;
}

int float_g_129c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_g_129c===%hg===%hg===\n",var1,var2);
  return i;
}

int float_g_130c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_130c===%.1hg===%.1hg===\n",var1,var2);
  return i;
}

int float_g_131c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_131c===%.2hg===%.2hg===\n",var1,var2);
  return i;
}

int float_g_132c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_132c===%.3hg===%.3hg===\n",var1,var2);
  return i;
}

int float_g_133c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_g_133c===%.10hg===%.10hg===\n",var1,var2);
  return i;
}

int float_g_134c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_134c===%hG===%hG===\n",var1,var2);
  return i;
}

int float_g_135c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_135c===%.1hG===%.1hG===\n",var1,var2);
  return i;
}

int float_g_136c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_136c===%.2hG===%.2hG===\n",var1,var2);
  return i;
}

int float_g_137c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_137c===%.3hG===%.3hG===\n",var1,var2);
  return i;
}

int float_g_138c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_138c===%.10hG===%.10hG===\n",var1,var2);
  return i;
}

int float_g_1557c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_1557c===%+g===%+g===\n",var1,var2);
  return i;
}

int float_g_1558c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_1558c===%+.1g===%+.1g===\n",var1,var2);
  return i;
}

int float_g_1559c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_1559c===%+.2g===%+.2g===\n",var1,var2);
  return i;
}

int float_g_1560c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_g_1560c===%+.3g===%+.3g===\n",var1,var2);
  return i;
}

int float_g_1561c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_1561c===%+.10g===%+.10g===\n",var1,var2);
  return i;
}

int float_g_1562c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_1562c===%+G===%+G===\n",var1,var2);
  return i;
}

int float_g_1563c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_1563c===%+.1G===%+.1G===\n",var1,var2);
  return i;
}

int float_g_1564c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_1564c===%+.2G===%+.2G===\n",var1,var2);
  return i;
}

int float_g_1565c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_1565c===%+.3G===%+.3G===\n",var1,var2);
  return i;
}

int float_g_1566c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_g_1566c===%+.10G===%+.10G===\n",var1,var2);
  return i;
}

int float_g_1603c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_g_1603c===%+hhg===%+hhg===\n",var1,var2);
  return i;
}

int float_g_1604c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_g_1604c===%+.1hhg===%+.1hhg===\n",var1,var2);
  return i;
}

int float_g_1605c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_g_1605c===%+.2hhg===%+.2hhg===\n",var1,var2);
  return i;
}

int float_g_1606c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_g_1606c===%+.3hhg===%+.3hhg===\n",var1,var2);
  return i;
}

int float_g_1607c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_1607c===%+.10hhg===%+.10hhg===\n",var1,var2);
  return i;
}

int float_g_1608c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_1608c===%+hhG===%+hhG===\n",var1,var2);
  return i;
}

int float_g_1609c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_1609c===%+.1hhG===%+.1hhG===\n",var1,var2);
  return i;
}

int float_g_1610c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_1610c===%+.2hhG===%+.2hhG===\n",var1,var2);
  return i;
}

int float_g_1611c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_1611c===%+.3hhG===%+.3hhG===\n",var1,var2);
  return i;
}

int float_g_1612c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_1612c===%+.10hhG===%+.10hhG===\n",var1,var2);
  return i;
}

int float_g_1649c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_g_1649c===%+hg===%+hg===\n",var1,var2);
  return i;
}

int float_g_1650c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_g_1650c===%+.1hg===%+.1hg===\n",var1,var2);
  return i;
}

int float_g_1651c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_g_1651c===%+.2hg===%+.2hg===\n",var1,var2);
  return i;
}

int float_g_1652c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_g_1652c===%+.3hg===%+.3hg===\n",var1,var2);
  return i;
}

int float_g_1653c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_1653c===%+.10hg===%+.10hg===\n",var1,var2);
  return i;
}

int float_g_1654c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_1654c===%+hG===%+hG===\n",var1,var2);
  return i;
}

int float_g_1655c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_1655c===%+.1hG===%+.1hG===\n",var1,var2);
  return i;
}

int float_g_1656c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_1656c===%+.2hG===%+.2hG===\n",var1,var2);
  return i;
}

int float_g_1657c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_g_1657c===%+.3hG===%+.3hG===\n",var1,var2);
  return i;
}

int float_g_1658c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_1658c===%+.10hG===%+.10hG===\n",var1,var2);
  return i;
}

int float_g_1695c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_1695c===%+g===%+g===\n",var1,var2);
  return i;
}

int float_g_1696c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_1696c===%+.1g===%+.1g===\n",var1,var2);
  return i;
}

int float_g_1697c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_g_1697c===%+.2g===%+.2g===\n",var1,var2);
  return i;
}

int float_g_1698c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_g_1698c===%+.3g===%+.3g===\n",var1,var2);
  return i;
}

int float_g_1699c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_1699c===%+.10g===%+.10g===\n",var1,var2);
  return i;
}

int float_g_1700c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_g_1700c===%+G===%+G===\n",var1,var2);
  return i;
}

int float_g_1701c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_1701c===%+.1G===%+.1G===\n",var1,var2);
  return i;
}

int float_g_1702c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_1702c===%+.2G===%+.2G===\n",var1,var2);
  return i;
}

int float_g_1703c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_g_1703c===%+.3G===%+.3G===\n",var1,var2);
  return i;
}

int float_g_1704c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_g_1704c===%+.10G===%+.10G===\n",var1,var2);
  return i;
}

int float_g_175c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_175c===%g===%g===\n",var1,var2);
  return i;
}

int float_g_176c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_g_176c===%.1g===%.1g===\n",var1,var2);
  return i;
}

int float_g_177c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_g_177c===%.2g===%.2g===\n",var1,var2);
  return i;
}

int float_g_178c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_178c===%.3g===%.3g===\n",var1,var2);
  return i;
}

int float_g_179c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_179c===%.10g===%.10g===\n",var1,var2);
  return i;
}

int float_g_180c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_180c===%G===%G===\n",var1,var2);
  return i;
}

int float_g_181c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_181c===%.1G===%.1G===\n",var1,var2);
  return i;
}

int float_g_182c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_182c===%.2G===%.2G===\n",var1,var2);
  return i;
}

int float_g_183c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_183c===%.3G===%.3G===\n",var1,var2);
  return i;
}

int float_g_184c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_g_184c===%.10G===%.10G===\n",var1,var2);
  return i;
}

int float_g_2317c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_2317c===%#g===%#g===\n",var1,var2);
  return i;
}

int float_g_2318c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_2318c===%#.1g===%#.1g===\n",var1,var2);
  return i;
}

int float_g_2319c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_g_2319c===%#.2g===%#.2g===\n",var1,var2);
  return i;
}

int float_g_2320c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_2320c===%#.3g===%#.3g===\n",var1,var2);
  return i;
}

int float_g_2321c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_2321c===%#.10g===%#.10g===\n",var1,var2);
  return i;
}

int float_g_2322c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_2322c===%#G===%#G===\n",var1,var2);
  return i;
}

int float_g_2323c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_2323c===%#.1G===%#.1G===\n",var1,var2);
  return i;
}

int float_g_2324c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_2324c===%#.2G===%#.2G===\n",var1,var2);
  return i;
}

int float_g_2325c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_g_2325c===%#.3G===%#.3G===\n",var1,var2);
  return i;
}

int float_g_2326c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_2326c===%#.10G===%#.10G===\n",var1,var2);
  return i;
}

int float_g_2363c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_g_2363c===%#hhg===%#hhg===\n",var1,var2);
  return i;
}

int float_g_2364c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_g_2364c===%#.1hhg===%#.1hhg===\n",var1,var2);
  return i;
}

int float_g_2365c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_g_2365c===%#.2hhg===%#.2hhg===\n",var1,var2);
  return i;
}

int float_g_2366c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_2366c===%#.3hhg===%#.3hhg===\n",var1,var2);
  return i;
}

int float_g_2367c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_g_2367c===%#.10hhg===%#.10hhg===\n",var1,var2);
  return i;
}

int float_g_2368c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_2368c===%#hhG===%#hhG===\n",var1,var2);
  return i;
}

int float_g_2369c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_2369c===%#.1hhG===%#.1hhG===\n",var1,var2);
  return i;
}

int float_g_2370c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_2370c===%#.2hhG===%#.2hhG===\n",var1,var2);
  return i;
}

int float_g_2371c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_g_2371c===%#.3hhG===%#.3hhG===\n",var1,var2);
  return i;
}

int float_g_2372c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_g_2372c===%#.10hhG===%#.10hhG===\n",var1,var2);
  return i;
}

int float_g_2409c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_2409c===%#hg===%#hg===\n",var1,var2);
  return i;
}

int float_g_2410c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_2410c===%#.1hg===%#.1hg===\n",var1,var2);
  return i;
}

int float_g_2411c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_g_2411c===%#.2hg===%#.2hg===\n",var1,var2);
  return i;
}

int float_g_2412c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_g_2412c===%#.3hg===%#.3hg===\n",var1,var2);
  return i;
}

int float_g_2413c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_g_2413c===%#.10hg===%#.10hg===\n",var1,var2);
  return i;
}

int float_g_2414c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_g_2414c===%#hG===%#hG===\n",var1,var2);
  return i;
}

int float_g_2415c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_2415c===%#.1hG===%#.1hG===\n",var1,var2);
  return i;
}

int float_g_2416c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_2416c===%#.2hG===%#.2hG===\n",var1,var2);
  return i;
}

int float_g_2417c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_2417c===%#.3hG===%#.3hG===\n",var1,var2);
  return i;
}

int float_g_2418c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_2418c===%#.10hG===%#.10hG===\n",var1,var2);
  return i;
}

int float_g_2455c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_2455c===%#g===%#g===\n",var1,var2);
  return i;
}

int float_g_2456c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_g_2456c===%#.1g===%#.1g===\n",var1,var2);
  return i;
}

int float_g_2457c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_g_2457c===%#.2g===%#.2g===\n",var1,var2);
  return i;
}

int float_g_2458c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_2458c===%#.3g===%#.3g===\n",var1,var2);
  return i;
}

int float_g_2459c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_2459c===%#.10g===%#.10g===\n",var1,var2);
  return i;
}

int float_g_2460c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_2460c===%#G===%#G===\n",var1,var2);
  return i;
}

int float_g_2461c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_2461c===%#.1G===%#.1G===\n",var1,var2);
  return i;
}

int float_g_2462c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_2462c===%#.2G===%#.2G===\n",var1,var2);
  return i;
}

int float_g_2463c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_2463c===%#.3G===%#.3G===\n",var1,var2);
  return i;
}

int float_g_2464c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_g_2464c===%#.10G===%#.10G===\n",var1,var2);
  return i;
}

int float_g_3077c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_g_3077c===%-+g===%-+g===\n",var1,var2);
  return i;
}

int float_g_3078c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_g_3078c===%-+.1g===%-+.1g===\n",var1,var2);
  return i;
}

int float_g_3079c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_3079c===%-+.2g===%-+.2g===\n",var1,var2);
  return i;
}

int float_g_3080c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_g_3080c===%-+.3g===%-+.3g===\n",var1,var2);
  return i;
}

int float_g_3081c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_3081c===%-+.10g===%-+.10g===\n",var1,var2);
  return i;
}

int float_g_3082c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_3082c===%-+G===%-+G===\n",var1,var2);
  return i;
}

int float_g_3083c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_3083c===%-+.1G===%-+.1G===\n",var1,var2);
  return i;
}

int float_g_3084c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_3084c===%-+.2G===%-+.2G===\n",var1,var2);
  return i;
}

int float_g_3085c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_g_3085c===%-+.3G===%-+.3G===\n",var1,var2);
  return i;
}

int float_g_3086c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_g_3086c===%-+.10G===%-+.10G===\n",var1,var2);
  return i;
}

int float_g_3123c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_3123c===%-+hhg===%-+hhg===\n",var1,var2);
  return i;
}

int float_g_3124c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_3124c===%-+.1hhg===%-+.1hhg===\n",var1,var2);
  return i;
}

int float_g_3125c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_g_3125c===%-+.2hhg===%-+.2hhg===\n",var1,var2);
  return i;
}

int float_g_3126c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_3126c===%-+.3hhg===%-+.3hhg===\n",var1,var2);
  return i;
}

int float_g_3127c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_g_3127c===%-+.10hhg===%-+.10hhg===\n",var1,var2);
  return i;
}

int float_g_3128c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_3128c===%-+hhG===%-+hhG===\n",var1,var2);
  return i;
}

int float_g_3129c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_3129c===%-+.1hhG===%-+.1hhG===\n",var1,var2);
  return i;
}

int float_g_3130c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_3130c===%-+.2hhG===%-+.2hhG===\n",var1,var2);
  return i;
}

int float_g_3131c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_3131c===%-+.3hhG===%-+.3hhG===\n",var1,var2);
  return i;
}

int float_g_3132c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_g_3132c===%-+.10hhG===%-+.10hhG===\n",var1,var2);
  return i;
}

int float_g_3169c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_3169c===%-+hg===%-+hg===\n",var1,var2);
  return i;
}

int float_g_3170c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_g_3170c===%-+.1hg===%-+.1hg===\n",var1,var2);
  return i;
}

int float_g_3171c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_g_3171c===%-+.2hg===%-+.2hg===\n",var1,var2);
  return i;
}

int float_g_3172c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_3172c===%-+.3hg===%-+.3hg===\n",var1,var2);
  return i;
}

int float_g_3173c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_g_3173c===%-+.10hg===%-+.10hg===\n",var1,var2);
  return i;
}

int float_g_3174c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_3174c===%-+hG===%-+hG===\n",var1,var2);
  return i;
}

int float_g_3175c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_g_3175c===%-+.1hG===%-+.1hG===\n",var1,var2);
  return i;
}

int float_g_3176c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_g_3176c===%-+.2hG===%-+.2hG===\n",var1,var2);
  return i;
}

int float_g_3177c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_3177c===%-+.3hG===%-+.3hG===\n",var1,var2);
  return i;
}

int float_g_3178c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_g_3178c===%-+.10hG===%-+.10hG===\n",var1,var2);
  return i;
}

int float_g_3215c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_g_3215c===%-+g===%-+g===\n",var1,var2);
  return i;
}

int float_g_3216c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_g_3216c===%-+.1g===%-+.1g===\n",var1,var2);
  return i;
}

int float_g_3217c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_3217c===%-+.2g===%-+.2g===\n",var1,var2);
  return i;
}

int float_g_3218c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_3218c===%-+.3g===%-+.3g===\n",var1,var2);
  return i;
}

int float_g_3219c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_g_3219c===%-+.10g===%-+.10g===\n",var1,var2);
  return i;
}

int float_g_3220c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_g_3220c===%-+G===%-+G===\n",var1,var2);
  return i;
}

int float_g_3221c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_g_3221c===%-+.1G===%-+.1G===\n",var1,var2);
  return i;
}

int float_g_3222c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_g_3222c===%-+.2G===%-+.2G===\n",var1,var2);
  return i;
}

int float_g_3223c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_3223c===%-+.3G===%-+.3G===\n",var1,var2);
  return i;
}

int float_g_3224c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_g_3224c===%-+.10G===%-+.10G===\n",var1,var2);
  return i;
}

int float_g_37c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_37c===%g===%g===\n",var1,var2);
  return i;
}

int float_g_38c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_g_38c===%.1g===%.1g===\n",var1,var2);
  return i;
}

int float_g_3837c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_g_3837c===% 10g===% 10g===\n",var1,var2);
  return i;
}

int float_g_3838c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_3838c===% 10.1g===% 10.1g===\n",var1,var2);
  return i;
}

int float_g_3839c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_g_3839c===% 10.2g===% 10.2g===\n",var1,var2);
  return i;
}

int float_g_3840c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_3840c===% 10.3g===% 10.3g===\n",var1,var2);
  return i;
}

int float_g_3841c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_3841c===% 10.10g===% 10.10g===\n",var1,var2);
  return i;
}

int float_g_3842c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_3842c===% 10G===% 10G===\n",var1,var2);
  return i;
}

int float_g_3843c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_3843c===% 10.1G===% 10.1G===\n",var1,var2);
  return i;
}

int float_g_3844c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_3844c===% 10.2G===% 10.2G===\n",var1,var2);
  return i;
}

int float_g_3845c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_3845c===% 10.3G===% 10.3G===\n",var1,var2);
  return i;
}

int float_g_3846c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_3846c===% 10.10G===% 10.10G===\n",var1,var2);
  return i;
}

int float_g_3883c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_g_3883c===% 10hhg===% 10hhg===\n",var1,var2);
  return i;
}

int float_g_3884c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_g_3884c===% 10.1hhg===% 10.1hhg===\n",var1,var2);
  return i;
}

int float_g_3885c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_g_3885c===% 10.2hhg===% 10.2hhg===\n",var1,var2);
  return i;
}

int float_g_3886c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_3886c===% 10.3hhg===% 10.3hhg===\n",var1,var2);
  return i;
}

int float_g_3887c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_3887c===% 10.10hhg===% 10.10hhg===\n",var1,var2);
  return i;
}

int float_g_3888c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_3888c===% 10hhG===% 10hhG===\n",var1,var2);
  return i;
}

int float_g_3889c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_3889c===% 10.1hhG===% 10.1hhG===\n",var1,var2);
  return i;
}

int float_g_3890c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_g_3890c===% 10.2hhG===% 10.2hhG===\n",var1,var2);
  return i;
}

int float_g_3891c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_g_3891c===% 10.3hhG===% 10.3hhG===\n",var1,var2);
  return i;
}

int float_g_3892c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_3892c===% 10.10hhG===% 10.10hhG===\n",var1,var2);
  return i;
}

int float_g_39c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_39c===%.2g===%.2g===\n",var1,var2);
  return i;
}

int float_g_3929c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_g_3929c===% 10hg===% 10hg===\n",var1,var2);
  return i;
}

int float_g_3930c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_g_3930c===% 10.1hg===% 10.1hg===\n",var1,var2);
  return i;
}

int float_g_3931c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_g_3931c===% 10.2hg===% 10.2hg===\n",var1,var2);
  return i;
}

int float_g_3932c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_3932c===% 10.3hg===% 10.3hg===\n",var1,var2);
  return i;
}

int float_g_3933c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_g_3933c===% 10.10hg===% 10.10hg===\n",var1,var2);
  return i;
}

int float_g_3934c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_g_3934c===% 10hG===% 10hG===\n",var1,var2);
  return i;
}

int float_g_3935c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_3935c===% 10.1hG===% 10.1hG===\n",var1,var2);
  return i;
}

int float_g_3936c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_3936c===% 10.2hG===% 10.2hG===\n",var1,var2);
  return i;
}

int float_g_3937c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_3937c===% 10.3hG===% 10.3hG===\n",var1,var2);
  return i;
}

int float_g_3938c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_3938c===% 10.10hG===% 10.10hG===\n",var1,var2);
  return i;
}

int float_g_3975c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_g_3975c===% 10g===% 10g===\n",var1,var2);
  return i;
}

int float_g_3976c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_3976c===% 10.1g===% 10.1g===\n",var1,var2);
  return i;
}

int float_g_3977c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_g_3977c===% 10.2g===% 10.2g===\n",var1,var2);
  return i;
}

int float_g_3978c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_3978c===% 10.3g===% 10.3g===\n",var1,var2);
  return i;
}

int float_g_3979c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_3979c===% 10.10g===% 10.10g===\n",var1,var2);
  return i;
}

int float_g_3980c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_g_3980c===% 10G===% 10G===\n",var1,var2);
  return i;
}

int float_g_3981c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_g_3981c===% 10.1G===% 10.1G===\n",var1,var2);
  return i;
}

int float_g_3982c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_g_3982c===% 10.2G===% 10.2G===\n",var1,var2);
  return i;
}

int float_g_3983c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_3983c===% 10.3G===% 10.3G===\n",var1,var2);
  return i;
}

int float_g_3984c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_3984c===% 10.10G===% 10.10G===\n",var1,var2);
  return i;
}

int float_g_40c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_40c===%.3g===%.3g===\n",var1,var2);
  return i;
}

int float_g_41c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_g_41c===%.10g===%.10g===\n",var1,var2);
  return i;
}

int float_g_42c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_g_42c===%G===%G===\n",var1,var2);
  return i;
}

int float_g_43c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_43c===%.1G===%.1G===\n",var1,var2);
  return i;
}

int float_g_44c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_g_44c===%.2G===%.2G===\n",var1,var2);
  return i;
}

int float_g_45c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_45c===%.3G===%.3G===\n",var1,var2);
  return i;
}

int float_g_4597c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_4597c===%010g===%010g===\n",var1,var2);
  return i;
}

int float_g_4598c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_g_4598c===%010.1g===%010.1g===\n",var1,var2);
  return i;
}

int float_g_4599c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_g_4599c===%010.2g===%010.2g===\n",var1,var2);
  return i;
}

int float_g_46c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_46c===%.10G===%.10G===\n",var1,var2);
  return i;
}

int float_g_4600c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_4600c===%010.3g===%010.3g===\n",var1,var2);
  return i;
}

int float_g_4601c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_g_4601c===%010.10g===%010.10g===\n",var1,var2);
  return i;
}

int float_g_4602c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_g_4602c===%010G===%010G===\n",var1,var2);
  return i;
}

int float_g_4603c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_g_4603c===%010.1G===%010.1G===\n",var1,var2);
  return i;
}

int float_g_4604c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_4604c===%010.2G===%010.2G===\n",var1,var2);
  return i;
}

int float_g_4605c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_4605c===%010.3G===%010.3G===\n",var1,var2);
  return i;
}

int float_g_4606c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_4606c===%010.10G===%010.10G===\n",var1,var2);
  return i;
}

int float_g_4643c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_g_4643c===%010hhg===%010hhg===\n",var1,var2);
  return i;
}

int float_g_4644c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_g_4644c===%010.1hhg===%010.1hhg===\n",var1,var2);
  return i;
}

int float_g_4645c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_4645c===%010.2hhg===%010.2hhg===\n",var1,var2);
  return i;
}

int float_g_4646c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_g_4646c===%010.3hhg===%010.3hhg===\n",var1,var2);
  return i;
}

int float_g_4647c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_4647c===%010.10hhg===%010.10hhg===\n",var1,var2);
  return i;
}

int float_g_4648c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_4648c===%010hhG===%010hhG===\n",var1,var2);
  return i;
}

int float_g_4649c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_g_4649c===%010.1hhG===%010.1hhG===\n",var1,var2);
  return i;
}

int float_g_4650c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_4650c===%010.2hhG===%010.2hhG===\n",var1,var2);
  return i;
}

int float_g_4651c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_g_4651c===%010.3hhG===%010.3hhG===\n",var1,var2);
  return i;
}

int float_g_4652c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_4652c===%010.10hhG===%010.10hhG===\n",var1,var2);
  return i;
}

int float_g_4689c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_4689c===%010hg===%010hg===\n",var1,var2);
  return i;
}

int float_g_4690c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_g_4690c===%010.1hg===%010.1hg===\n",var1,var2);
  return i;
}

int float_g_4691c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_4691c===%010.2hg===%010.2hg===\n",var1,var2);
  return i;
}

int float_g_4692c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_g_4692c===%010.3hg===%010.3hg===\n",var1,var2);
  return i;
}

int float_g_4693c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_4693c===%010.10hg===%010.10hg===\n",var1,var2);
  return i;
}

int float_g_4694c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_g_4694c===%010hG===%010hG===\n",var1,var2);
  return i;
}

int float_g_4695c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_g_4695c===%010.1hG===%010.1hG===\n",var1,var2);
  return i;
}

int float_g_4696c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_4696c===%010.2hG===%010.2hG===\n",var1,var2);
  return i;
}

int float_g_4697c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_g_4697c===%010.3hG===%010.3hG===\n",var1,var2);
  return i;
}

int float_g_4698c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_4698c===%010.10hG===%010.10hG===\n",var1,var2);
  return i;
}

int float_g_4735c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_g_4735c===%010g===%010g===\n",var1,var2);
  return i;
}

int float_g_4736c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_g_4736c===%010.1g===%010.1g===\n",var1,var2);
  return i;
}

int float_g_4737c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_4737c===%010.2g===%010.2g===\n",var1,var2);
  return i;
}

int float_g_4738c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_g_4738c===%010.3g===%010.3g===\n",var1,var2);
  return i;
}

int float_g_4739c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_g_4739c===%010.10g===%010.10g===\n",var1,var2);
  return i;
}

int float_g_4740c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_g_4740c===%010G===%010G===\n",var1,var2);
  return i;
}

int float_g_4741c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_4741c===%010.1G===%010.1G===\n",var1,var2);
  return i;
}

int float_g_4742c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_4742c===%010.2G===%010.2G===\n",var1,var2);
  return i;
}

int float_g_4743c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_g_4743c===%010.3G===%010.3G===\n",var1,var2);
  return i;
}

int float_g_4744c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_4744c===%010.10G===%010.10G===\n",var1,var2);
  return i;
}

int float_g_5357c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_5357c===%- 10g===%- 10g===\n",var1,var2);
  return i;
}

int float_g_5358c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_5358c===%- 10.1g===%- 10.1g===\n",var1,var2);
  return i;
}

int float_g_5359c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_5359c===%- 10.2g===%- 10.2g===\n",var1,var2);
  return i;
}

int float_g_5360c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (0.0);
  int i = printf("float_g_5360c===%- 10.3g===%- 10.3g===\n",var1,var2);
  return i;
}

int float_g_5361c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_5361c===%- 10.10g===%- 10.10g===\n",var1,var2);
  return i;
}

int float_g_5362c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_5362c===%- 10G===%- 10G===\n",var1,var2);
  return i;
}

int float_g_5363c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_5363c===%- 10.1G===%- 10.1G===\n",var1,var2);
  return i;
}

int float_g_5364c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_g_5364c===%- 10.2G===%- 10.2G===\n",var1,var2);
  return i;
}

int float_g_5365c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_g_5365c===%- 10.3G===%- 10.3G===\n",var1,var2);
  return i;
}

int float_g_5366c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_5366c===%- 10.10G===%- 10.10G===\n",var1,var2);
  return i;
}

int float_g_5403c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_5403c===%- 10hhg===%- 10hhg===\n",var1,var2);
  return i;
}

int float_g_5404c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_5404c===%- 10.1hhg===%- 10.1hhg===\n",var1,var2);
  return i;
}

int float_g_5405c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_5405c===%- 10.2hhg===%- 10.2hhg===\n",var1,var2);
  return i;
}

int float_g_5406c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_g_5406c===%- 10.3hhg===%- 10.3hhg===\n",var1,var2);
  return i;
}

int float_g_5407c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_g_5407c===%- 10.10hhg===%- 10.10hhg===\n",var1,var2);
  return i;
}

int float_g_5408c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_5408c===%- 10hhG===%- 10hhG===\n",var1,var2);
  return i;
}

int float_g_5409c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_5409c===%- 10.1hhG===%- 10.1hhG===\n",var1,var2);
  return i;
}

int float_g_5410c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_5410c===%- 10.2hhG===%- 10.2hhG===\n",var1,var2);
  return i;
}

int float_g_5411c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_5411c===%- 10.3hhG===%- 10.3hhG===\n",var1,var2);
  return i;
}

int float_g_5412c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_5412c===%- 10.10hhG===%- 10.10hhG===\n",var1,var2);
  return i;
}

int float_g_5449c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_g_5449c===%- 10hg===%- 10hg===\n",var1,var2);
  return i;
}

int float_g_5450c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_g_5450c===%- 10.1hg===%- 10.1hg===\n",var1,var2);
  return i;
}

int float_g_5451c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_5451c===%- 10.2hg===%- 10.2hg===\n",var1,var2);
  return i;
}

int float_g_5452c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_5452c===%- 10.3hg===%- 10.3hg===\n",var1,var2);
  return i;
}

int float_g_5453c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_g_5453c===%- 10.10hg===%- 10.10hg===\n",var1,var2);
  return i;
}

int float_g_5454c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_5454c===%- 10hG===%- 10hG===\n",var1,var2);
  return i;
}

int float_g_5455c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_5455c===%- 10.1hG===%- 10.1hG===\n",var1,var2);
  return i;
}

int float_g_5456c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_5456c===%- 10.2hG===%- 10.2hG===\n",var1,var2);
  return i;
}

int float_g_5457c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_g_5457c===%- 10.3hG===%- 10.3hG===\n",var1,var2);
  return i;
}

int float_g_5458c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_5458c===%- 10.10hG===%- 10.10hG===\n",var1,var2);
  return i;
}

int float_g_5495c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_5495c===%- 10g===%- 10g===\n",var1,var2);
  return i;
}

int float_g_5496c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_g_5496c===%- 10.1g===%- 10.1g===\n",var1,var2);
  return i;
}

int float_g_5497c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_5497c===%- 10.2g===%- 10.2g===\n",var1,var2);
  return i;
}

int float_g_5498c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_g_5498c===%- 10.3g===%- 10.3g===\n",var1,var2);
  return i;
}

int float_g_5499c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_5499c===%- 10.10g===%- 10.10g===\n",var1,var2);
  return i;
}

int float_g_5500c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_5500c===%- 10G===%- 10G===\n",var1,var2);
  return i;
}

int float_g_5501c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_5501c===%- 10.1G===%- 10.1G===\n",var1,var2);
  return i;
}

int float_g_5502c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_g_5502c===%- 10.2G===%- 10.2G===\n",var1,var2);
  return i;
}

int float_g_5503c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_5503c===%- 10.3G===%- 10.3G===\n",var1,var2);
  return i;
}

int float_g_5504c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_g_5504c===%- 10.10G===%- 10.10G===\n",var1,var2);
  return i;
}

int float_g_6117c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_6117c===%+ 10g===%+ 10g===\n",var1,var2);
  return i;
}

int float_g_6118c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_6118c===%+ 10.1g===%+ 10.1g===\n",var1,var2);
  return i;
}

int float_g_6119c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6119c===%+ 10.2g===%+ 10.2g===\n",var1,var2);
  return i;
}

int float_g_6120c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (1.0);
  int i = printf("float_g_6120c===%+ 10.3g===%+ 10.3g===\n",var1,var2);
  return i;
}

int float_g_6121c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_g_6121c===%+ 10.10g===%+ 10.10g===\n",var1,var2);
  return i;
}

int float_g_6122c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_6122c===%+ 10G===%+ 10G===\n",var1,var2);
  return i;
}

int float_g_6123c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_6123c===%+ 10.1G===%+ 10.1G===\n",var1,var2);
  return i;
}

int float_g_6124c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_6124c===%+ 10.2G===%+ 10.2G===\n",var1,var2);
  return i;
}

int float_g_6125c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_6125c===%+ 10.3G===%+ 10.3G===\n",var1,var2);
  return i;
}

int float_g_6126c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_g_6126c===%+ 10.10G===%+ 10.10G===\n",var1,var2);
  return i;
}

int float_g_6163c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_6163c===%+ 10hhg===%+ 10hhg===\n",var1,var2);
  return i;
}

int float_g_6164c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_g_6164c===%+ 10.1hhg===%+ 10.1hhg===\n",var1,var2);
  return i;
}

int float_g_6165c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (2.0);
  int i = printf("float_g_6165c===%+ 10.2hhg===%+ 10.2hhg===\n",var1,var2);
  return i;
}

int float_g_6166c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_g_6166c===%+ 10.3hhg===%+ 10.3hhg===\n",var1,var2);
  return i;
}

int float_g_6167c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6167c===%+ 10.10hhg===%+ 10.10hhg===\n",var1,var2);
  return i;
}

int float_g_6168c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6168c===%+ 10hhG===%+ 10hhG===\n",var1,var2);
  return i;
}

int float_g_6169c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6169c===%+ 10.1hhG===%+ 10.1hhG===\n",var1,var2);
  return i;
}

int float_g_6170c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6170c===%+ 10.2hhG===%+ 10.2hhG===\n",var1,var2);
  return i;
}

int float_g_6171c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6171c===%+ 10.3hhG===%+ 10.3hhG===\n",var1,var2);
  return i;
}

int float_g_6172c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_6172c===%+ 10.10hhG===%+ 10.10hhG===\n",var1,var2);
  return i;
}

int float_g_6209c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_6209c===%+ 10hg===%+ 10hg===\n",var1,var2);
  return i;
}

int float_g_6210c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6210c===%+ 10.1hg===%+ 10.1hg===\n",var1,var2);
  return i;
}

int float_g_6211c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_6211c===%+ 10.2hg===%+ 10.2hg===\n",var1,var2);
  return i;
}

int float_g_6212c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_g_6212c===%+ 10.3hg===%+ 10.3hg===\n",var1,var2);
  return i;
}

int float_g_6213c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6213c===%+ 10.10hg===%+ 10.10hg===\n",var1,var2);
  return i;
}

int float_g_6214c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6214c===%+ 10hG===%+ 10hG===\n",var1,var2);
  return i;
}

int float_g_6215c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6215c===%+ 10.1hG===%+ 10.1hG===\n",var1,var2);
  return i;
}

int float_g_6216c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6216c===%+ 10.2hG===%+ 10.2hG===\n",var1,var2);
  return i;
}

int float_g_6217c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6217c===%+ 10.3hG===%+ 10.3hG===\n",var1,var2);
  return i;
}

int float_g_6218c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_6218c===%+ 10.10hG===%+ 10.10hG===\n",var1,var2);
  return i;
}

int float_g_6255c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6255c===%+ 10g===%+ 10g===\n",var1,var2);
  return i;
}

int float_g_6256c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_6256c===%+ 10.1g===%+ 10.1g===\n",var1,var2);
  return i;
}

int float_g_6257c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6257c===%+ 10.2g===%+ 10.2g===\n",var1,var2);
  return i;
}

int float_g_6258c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6258c===%+ 10.3g===%+ 10.3g===\n",var1,var2);
  return i;
}

int float_g_6259c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_g_6259c===%+ 10.10g===%+ 10.10g===\n",var1,var2);
  return i;
}

int float_g_6260c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6260c===%+ 10G===%+ 10G===\n",var1,var2);
  return i;
}

int float_g_6261c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6261c===%+ 10.1G===%+ 10.1G===\n",var1,var2);
  return i;
}

int float_g_6262c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6262c===%+ 10.2G===%+ 10.2G===\n",var1,var2);
  return i;
}

int float_g_6263c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6263c===%+ 10.3G===%+ 10.3G===\n",var1,var2);
  return i;
}

int float_g_6264c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6264c===%+ 10.10G===%+ 10.10G===\n",var1,var2);
  return i;
}

int float_g_6877c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6877c===%+010g===%+010g===\n",var1,var2);
  return i;
}

int float_g_6878c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_6878c===%+010.1g===%+010.1g===\n",var1,var2);
  return i;
}

int float_g_6879c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6879c===%+010.2g===%+010.2g===\n",var1,var2);
  return i;
}

int float_g_6880c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6880c===%+010.3g===%+010.3g===\n",var1,var2);
  return i;
}

int float_g_6881c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_g_6881c===%+010.10g===%+010.10g===\n",var1,var2);
  return i;
}

int float_g_6882c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6882c===%+010G===%+010G===\n",var1,var2);
  return i;
}

int float_g_6883c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_g_6883c===%+010.1G===%+010.1G===\n",var1,var2);
  return i;
}

int float_g_6884c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_g_6884c===%+010.2G===%+010.2G===\n",var1,var2);
  return i;
}

int float_g_6885c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6885c===%+010.3G===%+010.3G===\n",var1,var2);
  return i;
}

int float_g_6886c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_6886c===%+010.10G===%+010.10G===\n",var1,var2);
  return i;
}

int float_g_6923c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6923c===%+010hhg===%+010hhg===\n",var1,var2);
  return i;
}

int float_g_6924c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6924c===%+010.1hhg===%+010.1hhg===\n",var1,var2);
  return i;
}

int float_g_6925c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_6925c===%+010.2hhg===%+010.2hhg===\n",var1,var2);
  return i;
}

int float_g_6926c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_6926c===%+010.3hhg===%+010.3hhg===\n",var1,var2);
  return i;
}

int float_g_6927c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_g_6927c===%+010.10hhg===%+010.10hhg===\n",var1,var2);
  return i;
}

int float_g_6928c() {

  float var1 = (float) (0.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_6928c===%+010hhG===%+010hhG===\n",var1,var2);
  return i;
}

int float_g_6929c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_g_6929c===%+010.1hhG===%+010.1hhG===\n",var1,var2);
  return i;
}

int float_g_6930c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_6930c===%+010.2hhG===%+010.2hhG===\n",var1,var2);
  return i;
}

int float_g_6931c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6931c===%+010.3hhG===%+010.3hhG===\n",var1,var2);
  return i;
}

int float_g_6932c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6932c===%+010.10hhG===%+010.10hhG===\n",var1,var2);
  return i;
}

int float_g_6969c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_g_6969c===%+010hg===%+010hg===\n",var1,var2);
  return i;
}

int float_g_6970c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_6970c===%+010.1hg===%+010.1hg===\n",var1,var2);
  return i;
}

int float_g_6971c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_g_6971c===%+010.2hg===%+010.2hg===\n",var1,var2);
  return i;
}

int float_g_6972c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (1.0);
  int i = printf("float_g_6972c===%+010.3hg===%+010.3hg===\n",var1,var2);
  return i;
}

int float_g_6973c() {

  float var1 = (float) (0.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_6973c===%+010.10hg===%+010.10hg===\n",var1,var2);
  return i;
}

int float_g_6974c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6974c===%+010hG===%+010hG===\n",var1,var2);
  return i;
}

int float_g_6975c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_6975c===%+010.1hG===%+010.1hG===\n",var1,var2);
  return i;
}

int float_g_6976c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_6976c===%+010.2hG===%+010.2hG===\n",var1,var2);
  return i;
}

int float_g_6977c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_g_6977c===%+010.3hG===%+010.3hG===\n",var1,var2);
  return i;
}

int float_g_6978c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_6978c===%+010.10hG===%+010.10hG===\n",var1,var2);
  return i;
}

int float_g_7015c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_7015c===%+010g===%+010g===\n",var1,var2);
  return i;
}

int float_g_7016c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_g_7016c===%+010.1g===%+010.1g===\n",var1,var2);
  return i;
}

int float_g_7017c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_7017c===%+010.2g===%+010.2g===\n",var1,var2);
  return i;
}

int float_g_7018c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_g_7018c===%+010.3g===%+010.3g===\n",var1,var2);
  return i;
}

int float_g_7019c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_7019c===%+010.10g===%+010.10g===\n",var1,var2);
  return i;
}

int float_g_7020c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (123455.134);
  int i = printf("float_g_7020c===%+010G===%+010G===\n",var1,var2);
  return i;
}

int float_g_7021c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_g_7021c===%+010.1G===%+010.1G===\n",var1,var2);
  return i;
}

int float_g_7022c() {

  float var1 = (float) (2.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_7022c===%+010.2G===%+010.2G===\n",var1,var2);
  return i;
}

int float_g_7023c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_7023c===%+010.3G===%+010.3G===\n",var1,var2);
  return i;
}

int float_g_7024c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_g_7024c===%+010.10G===%+010.10G===\n",var1,var2);
  return i;
}

int float_g_797c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_797c===%-g===%-g===\n",var1,var2);
  return i;
}

int float_g_798c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_798c===%-.1g===%-.1g===\n",var1,var2);
  return i;
}

int float_g_799c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_799c===%-.2g===%-.2g===\n",var1,var2);
  return i;
}

int float_g_800c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_800c===%-.3g===%-.3g===\n",var1,var2);
  return i;
}

int float_g_801c() {

  float var1 = (float) (2.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_801c===%-.10g===%-.10g===\n",var1,var2);
  return i;
}

int float_g_802c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_g_802c===%-G===%-G===\n",var1,var2);
  return i;
}

int float_g_803c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_g_803c===%-.1G===%-.1G===\n",var1,var2);
  return i;
}

int float_g_804c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_804c===%-.2G===%-.2G===\n",var1,var2);
  return i;
}

int float_g_805c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_g_805c===%-.3G===%-.3G===\n",var1,var2);
  return i;
}

int float_g_806c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (123455.134);
  int i = printf("float_g_806c===%-.10G===%-.10G===\n",var1,var2);
  return i;
}

int float_g_83c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-1.23);
  int i = printf("float_g_83c===%hhg===%hhg===\n",var1,var2);
  return i;
}

int float_g_84c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_g_84c===%.1hhg===%.1hhg===\n",var1,var2);
  return i;
}

int float_g_843c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (2.0);
  int i = printf("float_g_843c===%-hhg===%-hhg===\n",var1,var2);
  return i;
}

int float_g_844c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_844c===%-.1hhg===%-.1hhg===\n",var1,var2);
  return i;
}

int float_g_845c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_845c===%-.2hhg===%-.2hhg===\n",var1,var2);
  return i;
}

int float_g_846c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_846c===%-.3hhg===%-.3hhg===\n",var1,var2);
  return i;
}

int float_g_847c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_847c===%-.10hhg===%-.10hhg===\n",var1,var2);
  return i;
}

int float_g_848c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_g_848c===%-hhG===%-hhG===\n",var1,var2);
  return i;
}

int float_g_849c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_849c===%-.1hhG===%-.1hhG===\n",var1,var2);
  return i;
}

int float_g_85c() {

  float var1 = (float) (0.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_85c===%.2hhg===%.2hhg===\n",var1,var2);
  return i;
}

int float_g_850c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_g_850c===%-.2hhG===%-.2hhG===\n",var1,var2);
  return i;
}

int float_g_851c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_851c===%-.3hhG===%-.3hhG===\n",var1,var2);
  return i;
}

int float_g_852c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_852c===%-.10hhG===%-.10hhG===\n",var1,var2);
  return i;
}

int float_g_86c() {

  float var1 = (float) (0.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_86c===%.3hhg===%.3hhg===\n",var1,var2);
  return i;
}

int float_g_87c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_87c===%.10hhg===%.10hhg===\n",var1,var2);
  return i;
}

int float_g_88c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_88c===%hhG===%hhG===\n",var1,var2);
  return i;
}

int float_g_889c() {

  float var1 = (float) (1.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_889c===%-hg===%-hg===\n",var1,var2);
  return i;
}

int float_g_89c() {

  float var1 = (float) (0.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_89c===%.1hhG===%.1hhG===\n",var1,var2);
  return i;
}

int float_g_890c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_890c===%-.1hg===%-.1hg===\n",var1,var2);
  return i;
}

int float_g_891c() {

  float var1 = (float) (2.0);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_891c===%-.2hg===%-.2hg===\n",var1,var2);
  return i;
}

int float_g_892c() {

  float var1 = (float) (1.0);
  float var2 = (float) (1.0);
  int i = printf("float_g_892c===%-.3hg===%-.3hg===\n",var1,var2);
  return i;
}

int float_g_893c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (1.0);
  int i = printf("float_g_893c===%-.10hg===%-.10hg===\n",var1,var2);
  return i;
}

int float_g_894c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_g_894c===%-hG===%-hG===\n",var1,var2);
  return i;
}

int float_g_895c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_895c===%-.1hG===%-.1hG===\n",var1,var2);
  return i;
}

int float_g_896c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (2.0);
  int i = printf("float_g_896c===%-.2hG===%-.2hG===\n",var1,var2);
  return i;
}

int float_g_897c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_897c===%-.3hG===%-.3hG===\n",var1,var2);
  return i;
}

int float_g_898c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (0.0);
  int i = printf("float_g_898c===%-.10hG===%-.10hG===\n",var1,var2);
  return i;
}

int float_g_90c() {

  float var1 = (float) (-1.23);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_90c===%.2hhG===%.2hhG===\n",var1,var2);
  return i;
}

int float_g_91c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (-12345.032);
  int i = printf("float_g_91c===%.3hhG===%.3hhG===\n",var1,var2);
  return i;
}

int float_g_92c() {

  float var1 = (float) (1.0);
  float var2 = (float) (-1.23);
  int i = printf("float_g_92c===%.10hhG===%.10hhG===\n",var1,var2);
  return i;
}

int float_g_935c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_935c===%-g===%-g===\n",var1,var2);
  return i;
}

int float_g_936c() {

  float var1 = (float) (1.0);
  float var2 = (float) (2.0);
  int i = printf("float_g_936c===%-.1g===%-.1g===\n",var1,var2);
  return i;
}

int float_g_937c() {

  float var1 = (float) (2.0);
  float var2 = (float) (0.0);
  int i = printf("float_g_937c===%-.2g===%-.2g===\n",var1,var2);
  return i;
}

int float_g_938c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_g_938c===%-.3g===%-.3g===\n",var1,var2);
  return i;
}

int float_g_939c() {

  float var1 = (float) (1.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_939c===%-.10g===%-.10g===\n",var1,var2);
  return i;
}

int float_g_940c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (123455.134);
  int i = printf("float_g_940c===%-G===%-G===\n",var1,var2);
  return i;
}

int float_g_941c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_g_941c===%-.1G===%-.1G===\n",var1,var2);
  return i;
}

int float_g_942c() {

  float var1 = (float) (123455.134);
  float var2 = (float) (-1.23);
  int i = printf("float_g_942c===%-.2G===%-.2G===\n",var1,var2);
  return i;
}

int float_g_943c() {

  float var1 = (float) (-12345.032);
  float var2 = (float) (0.0);
  int i = printf("float_g_943c===%-.3G===%-.3G===\n",var1,var2);
  return i;
}

int float_g_944c() {

  float var1 = (float) (2.0);
  float var2 = (float) (123455.134);
  int i = printf("float_g_944c===%-.10G===%-.10G===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;i = float_a_10c();
i = float_a_100c();
i = float_a_101c();
i = float_a_102c();
i = float_a_103c();
i = float_a_104c();
i = float_a_105c();
i = float_a_106c();
i = float_a_107c();
i = float_a_108c();
i = float_a_11c();
i = float_a_12c();
i = float_a_13c();
i = float_a_14c();
i = float_a_145c();
i = float_a_146c();
i = float_a_147c();
i = float_a_148c();
i = float_a_149c();
i = float_a_15c();
i = float_a_150c();
i = float_a_151c();
i = float_a_152c();
i = float_a_1527c();
i = float_a_1528c();
i = float_a_1529c();
i = float_a_153c();
i = float_a_1530c();
i = float_a_1531c();
i = float_a_1532c();
i = float_a_1533c();
i = float_a_1534c();
i = float_a_1535c();
i = float_a_1536c();
i = float_a_154c();
i = float_a_1573c();
i = float_a_1574c();
i = float_a_1575c();
i = float_a_1576c();
i = float_a_1577c();
i = float_a_1578c();
i = float_a_1579c();
i = float_a_1580c();
i = float_a_1581c();
i = float_a_1582c();
i = float_a_16c();
i = float_a_1619c();
i = float_a_1620c();
i = float_a_1621c();
i = float_a_1622c();
i = float_a_1623c();
i = float_a_1624c();
i = float_a_1625c();
i = float_a_1626c();
i = float_a_1627c();
i = float_a_1628c();
i = float_a_1665c();
i = float_a_1666c();
i = float_a_1667c();
i = float_a_1668c();
i = float_a_1669c();
i = float_a_1670c();
i = float_a_1671c();
i = float_a_1672c();
i = float_a_1673c();
i = float_a_1674c();
i = float_a_2287c();
i = float_a_2288c();
i = float_a_2289c();
i = float_a_2290c();
i = float_a_2291c();
i = float_a_2292c();
i = float_a_2293c();
i = float_a_2294c();
i = float_a_2295c();
i = float_a_2296c();
i = float_a_2333c();
i = float_a_2334c();
i = float_a_2335c();
i = float_a_2336c();
i = float_a_2337c();
i = float_a_2338c();
i = float_a_2339c();
i = float_a_2340c();
i = float_a_2341c();
i = float_a_2342c();
i = float_a_2379c();
i = float_a_2380c();
i = float_a_2381c();
i = float_a_2382c();
i = float_a_2383c();
i = float_a_2384c();
i = float_a_2385c();
i = float_a_2386c();
i = float_a_2387c();
i = float_a_2388c();
i = float_a_2425c();
i = float_a_2426c();
i = float_a_2427c();
i = float_a_2428c();
i = float_a_2429c();
i = float_a_2430c();
i = float_a_2431c();
i = float_a_2432c();
i = float_a_2433c();
i = float_a_2434c();
i = float_a_3047c();
i = float_a_3048c();
i = float_a_3049c();
i = float_a_3050c();
i = float_a_3051c();
i = float_a_3052c();
i = float_a_3053c();
i = float_a_3054c();
i = float_a_3055c();
i = float_a_3056c();
i = float_a_3093c();
i = float_a_3094c();
i = float_a_3095c();
i = float_a_3096c();
i = float_a_3097c();
i = float_a_3098c();
i = float_a_3099c();
i = float_a_3100c();
i = float_a_3101c();
i = float_a_3102c();
i = float_a_3139c();
i = float_a_3140c();
i = float_a_3141c();
i = float_a_3142c();
i = float_a_3143c();
i = float_a_3144c();
i = float_a_3145c();
i = float_a_3146c();
i = float_a_3147c();
i = float_a_3148c();
i = float_a_3185c();
i = float_a_3186c();
i = float_a_3187c();
i = float_a_3188c();
i = float_a_3189c();
i = float_a_3190c();
i = float_a_3191c();
i = float_a_3192c();
i = float_a_3193c();
i = float_a_3194c();
i = float_a_3807c();
i = float_a_3808c();
i = float_a_3809c();
i = float_a_3810c();
i = float_a_3811c();
i = float_a_3812c();
i = float_a_3813c();
i = float_a_3814c();
i = float_a_3815c();
i = float_a_3816c();
i = float_a_3853c();
i = float_a_3854c();
i = float_a_3855c();
i = float_a_3856c();
i = float_a_3857c();
i = float_a_3858c();
i = float_a_3859c();
i = float_a_3860c();
i = float_a_3861c();
i = float_a_3862c();
i = float_a_3899c();
i = float_a_3900c();
i = float_a_3901c();
i = float_a_3902c();
i = float_a_3903c();
i = float_a_3904c();
i = float_a_3905c();
i = float_a_3906c();
i = float_a_3907c();
i = float_a_3908c();
i = float_a_3945c();
i = float_a_3946c();
i = float_a_3947c();
i = float_a_3948c();
i = float_a_3949c();
i = float_a_3950c();
i = float_a_3951c();
i = float_a_3952c();
i = float_a_3953c();
i = float_a_3954c();
i = float_a_4567c();
i = float_a_4568c();
i = float_a_4569c();
i = float_a_4570c();
i = float_a_4571c();
i = float_a_4572c();
i = float_a_4573c();
i = float_a_4574c();
i = float_a_4575c();
i = float_a_4576c();
i = float_a_4613c();
i = float_a_4614c();
i = float_a_4615c();
i = float_a_4616c();
i = float_a_4617c();
i = float_a_4618c();
i = float_a_4619c();
i = float_a_4620c();
i = float_a_4621c();
i = float_a_4622c();
i = float_a_4659c();
i = float_a_4660c();
i = float_a_4661c();
i = float_a_4662c();
i = float_a_4663c();
i = float_a_4664c();
i = float_a_4665c();
i = float_a_4666c();
i = float_a_4667c();
i = float_a_4668c();
i = float_a_4705c();
i = float_a_4706c();
i = float_a_4707c();
i = float_a_4708c();
i = float_a_4709c();
i = float_a_4710c();
i = float_a_4711c();
i = float_a_4712c();
i = float_a_4713c();
i = float_a_4714c();
i = float_a_53c();
i = float_a_5327c();
i = float_a_5328c();
i = float_a_5329c();
i = float_a_5330c();
i = float_a_5331c();
i = float_a_5332c();
i = float_a_5333c();
i = float_a_5334c();
i = float_a_5335c();
i = float_a_5336c();
i = float_a_5373c();
i = float_a_5374c();
i = float_a_5375c();
i = float_a_5376c();
i = float_a_5377c();
i = float_a_5378c();
i = float_a_5379c();
i = float_a_5380c();
i = float_a_5381c();
i = float_a_5382c();
i = float_a_54c();
i = float_a_5419c();
i = float_a_5420c();
i = float_a_5421c();
i = float_a_5422c();
i = float_a_5423c();
i = float_a_5424c();
i = float_a_5425c();
i = float_a_5426c();
i = float_a_5427c();
i = float_a_5428c();
i = float_a_5465c();
i = float_a_5466c();
i = float_a_5467c();
i = float_a_5468c();
i = float_a_5469c();
i = float_a_5470c();
i = float_a_5471c();
i = float_a_5472c();
i = float_a_5473c();
i = float_a_5474c();
i = float_a_55c();
i = float_a_56c();
i = float_a_57c();
i = float_a_58c();
i = float_a_59c();
i = float_a_60c();
i = float_a_6087c();
i = float_a_6088c();
i = float_a_6089c();
i = float_a_6090c();
i = float_a_6091c();
i = float_a_6092c();
i = float_a_6093c();
i = float_a_6094c();
i = float_a_6095c();
i = float_a_6096c();
i = float_a_61c();
i = float_a_6133c();
i = float_a_6134c();
i = float_a_6135c();
i = float_a_6136c();
i = float_a_6137c();
i = float_a_6138c();
i = float_a_6139c();
i = float_a_6140c();
i = float_a_6141c();
i = float_a_6142c();
i = float_a_6179c();
i = float_a_6180c();
i = float_a_6181c();
i = float_a_6182c();
i = float_a_6183c();
i = float_a_6184c();
i = float_a_6185c();
i = float_a_6186c();
i = float_a_6187c();
i = float_a_6188c();
i = float_a_62c();
i = float_a_6225c();
i = float_a_6226c();
i = float_a_6227c();
i = float_a_6228c();
i = float_a_6229c();
i = float_a_6230c();
i = float_a_6231c();
i = float_a_6232c();
i = float_a_6233c();
i = float_a_6234c();
i = float_a_6847c();
i = float_a_6848c();
i = float_a_6849c();
i = float_a_6850c();
i = float_a_6851c();
i = float_a_6852c();
i = float_a_6853c();
i = float_a_6854c();
i = float_a_6855c();
i = float_a_6856c();
i = float_a_6893c();
i = float_a_6894c();
i = float_a_6895c();
i = float_a_6896c();
i = float_a_6897c();
i = float_a_6898c();
i = float_a_6899c();
i = float_a_6900c();
i = float_a_6901c();
i = float_a_6902c();
i = float_a_6939c();
i = float_a_6940c();
i = float_a_6941c();
i = float_a_6942c();
i = float_a_6943c();
i = float_a_6944c();
i = float_a_6945c();
i = float_a_6946c();
i = float_a_6947c();
i = float_a_6948c();
i = float_a_6985c();
i = float_a_6986c();
i = float_a_6987c();
i = float_a_6988c();
i = float_a_6989c();
i = float_a_6990c();
i = float_a_6991c();
i = float_a_6992c();
i = float_a_6993c();
i = float_a_6994c();
i = float_a_7c();
i = float_a_767c();
i = float_a_768c();
i = float_a_769c();
i = float_a_770c();
i = float_a_771c();
i = float_a_772c();
i = float_a_773c();
i = float_a_774c();
i = float_a_775c();
i = float_a_776c();
i = float_a_8c();
i = float_a_813c();
i = float_a_814c();
i = float_a_815c();
i = float_a_816c();
i = float_a_817c();
i = float_a_818c();
i = float_a_819c();
i = float_a_820c();
i = float_a_821c();
i = float_a_822c();
i = float_a_859c();
i = float_a_860c();
i = float_a_861c();
i = float_a_862c();
i = float_a_863c();
i = float_a_864c();
i = float_a_865c();
i = float_a_866c();
i = float_a_867c();
i = float_a_868c();
i = float_a_9c();
i = float_a_905c();
i = float_a_906c();
i = float_a_907c();
i = float_a_908c();
i = float_a_909c();
i = float_a_910c();
i = float_a_911c();
i = float_a_912c();
i = float_a_913c();
i = float_a_914c();
i = float_a_99c();
















































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































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
