/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/aggregate/float8_g.c'  */

int float8_a_1291c() {

  float8 var1 = (float8) (-1.23,1.0,-12345.032,-12345.032,123455.134,0.0,0.0,2.0);
  float8 var2 = (float8) (-12345.032,-12345.032,0.0,2.0,-1.23,2.0,1.0,123455.134);
  int i = printf("float8_a_1291c===%-v8hla===%-v8hla===\n",var1,var2);
  return i;
}

int float8_a_1292c() {

  float8 var1 = (float8) (-1.23,123455.134,-12345.032,-1.23,2.0,-12345.032,-12345.032,-12345.032);
  float8 var2 = (float8) (0.0,2.0,-12345.032,1.0,2.0,123455.134,-1.23,-1.23);
  int i = printf("float8_a_1292c===%-.1v8hla===%-.1v8hla===\n",var1,var2);
  return i;
}

int float8_a_1293c() {

  float8 var1 = (float8) (1.0,-12345.032,0.0,-1.23,1.0,0.0,-1.23,0.0);
  float8 var2 = (float8) (2.0,2.0,1.0,-12345.032,0.0,2.0,-1.23,123455.134);
  int i = printf("float8_a_1293c===%-.2v8hla===%-.2v8hla===\n",var1,var2);
  return i;
}

int float8_a_1294c() {

  float8 var1 = (float8) (2.0,1.0,-12345.032,-1.23,2.0,2.0,123455.134,123455.134);
  float8 var2 = (float8) (-12345.032,0.0,2.0,2.0,-1.23,2.0,-1.23,2.0);
  int i = printf("float8_a_1294c===%-.3v8hla===%-.3v8hla===\n",var1,var2);
  return i;
}

int float8_a_1295c() {

  float8 var1 = (float8) (123455.134,-1.23,-12345.032,123455.134,123455.134,1.0,-12345.032,123455.134);
  float8 var2 = (float8) (123455.134,-12345.032,-12345.032,0.0,1.0,-1.23,0.0,2.0);
  int i = printf("float8_a_1295c===%-.10v8hla===%-.10v8hla===\n",var1,var2);
  return i;
}

int float8_a_1296c() {

  float8 var1 = (float8) (1.0,1.0,1.0,1.0,-1.23,0.0,1.0,-1.23);
  float8 var2 = (float8) (0.0,123455.134,2.0,0.0,-12345.032,-12345.032,2.0,123455.134);
  int i = printf("float8_a_1296c===%-v8hlA===%-v8hlA===\n",var1,var2);
  return i;
}

int float8_a_1297c() {

  float8 var1 = (float8) (123455.134,123455.134,-1.23,2.0,1.0,123455.134,0.0,-1.23);
  float8 var2 = (float8) (2.0,-1.23,0.0,2.0,-1.23,2.0,123455.134,1.0);
  int i = printf("float8_a_1297c===%-.1v8hlA===%-.1v8hlA===\n",var1,var2);
  return i;
}

int float8_a_1298c() {

  float8 var1 = (float8) (0.0,-1.23,0.0,-12345.032,2.0,2.0,-12345.032,2.0);
  float8 var2 = (float8) (-12345.032,1.0,1.0,-12345.032,1.0,2.0,1.0,-12345.032);
  int i = printf("float8_a_1298c===%-.2v8hlA===%-.2v8hlA===\n",var1,var2);
  return i;
}

int float8_a_1299c() {

  float8 var1 = (float8) (-12345.032,0.0,2.0,2.0,123455.134,2.0,0.0,0.0);
  float8 var2 = (float8) (-12345.032,-12345.032,-12345.032,-1.23,-1.23,123455.134,-12345.032,1.0);
  int i = printf("float8_a_1299c===%-.3v8hlA===%-.3v8hlA===\n",var1,var2);
  return i;
}

int float8_a_1300c() {

  float8 var1 = (float8) (0.0,123455.134,1.0,1.0,1.0,-12345.032,2.0,1.0);
  float8 var2 = (float8) (-1.23,123455.134,0.0,0.0,123455.134,0.0,1.0,123455.134);
  int i = printf("float8_a_1300c===%-.10v8hlA===%-.10v8hlA===\n",var1,var2);
  return i;
}

int float8_a_2051c() {

  float8 var1 = (float8) (0.0,0.0,-1.23,0.0,1.0,0.0,-1.23,1.0);
  float8 var2 = (float8) (-12345.032,-12345.032,2.0,0.0,2.0,0.0,1.0,-1.23);
  int i = printf("float8_a_2051c===%+v8hla===%+v8hla===\n",var1,var2);
  return i;
}

int float8_a_2052c() {

  float8 var1 = (float8) (1.0,1.0,0.0,2.0,2.0,-1.23,1.0,0.0);
  float8 var2 = (float8) (-1.23,123455.134,1.0,123455.134,0.0,-1.23,-1.23,0.0);
  int i = printf("float8_a_2052c===%+.1v8hla===%+.1v8hla===\n",var1,var2);
  return i;
}

int float8_a_2053c() {

  float8 var1 = (float8) (1.0,1.0,123455.134,-1.23,0.0,2.0,2.0,-1.23);
  float8 var2 = (float8) (123455.134,123455.134,1.0,0.0,2.0,-1.23,0.0,2.0);
  int i = printf("float8_a_2053c===%+.2v8hla===%+.2v8hla===\n",var1,var2);
  return i;
}

int float8_a_2054c() {

  float8 var1 = (float8) (1.0,1.0,0.0,2.0,1.0,123455.134,-1.23,2.0);
  float8 var2 = (float8) (-1.23,123455.134,0.0,123455.134,2.0,-1.23,-1.23,2.0);
  int i = printf("float8_a_2054c===%+.3v8hla===%+.3v8hla===\n",var1,var2);
  return i;
}

int float8_a_2055c() {

  float8 var1 = (float8) (-12345.032,2.0,123455.134,0.0,0.0,2.0,123455.134,-12345.032);
  float8 var2 = (float8) (123455.134,-12345.032,0.0,2.0,-1.23,0.0,-1.23,123455.134);
  int i = printf("float8_a_2055c===%+.10v8hla===%+.10v8hla===\n",var1,var2);
  return i;
}

int float8_a_2056c() {

  float8 var1 = (float8) (123455.134,-12345.032,-12345.032,123455.134,1.0,-1.23,1.0,-12345.032);
  float8 var2 = (float8) (2.0,0.0,2.0,-12345.032,2.0,2.0,0.0,-12345.032);
  int i = printf("float8_a_2056c===%+v8hlA===%+v8hlA===\n",var1,var2);
  return i;
}

int float8_a_2057c() {

  float8 var1 = (float8) (1.0,-1.23,0.0,2.0,-12345.032,0.0,123455.134,1.0);
  float8 var2 = (float8) (-12345.032,-1.23,2.0,-1.23,1.0,-1.23,-1.23,-1.23);
  int i = printf("float8_a_2057c===%+.1v8hlA===%+.1v8hlA===\n",var1,var2);
  return i;
}

int float8_a_2058c() {

  float8 var1 = (float8) (2.0,-12345.032,-12345.032,-1.23,1.0,123455.134,-12345.032,-1.23);
  float8 var2 = (float8) (1.0,2.0,123455.134,123455.134,0.0,2.0,-12345.032,2.0);
  int i = printf("float8_a_2058c===%+.2v8hlA===%+.2v8hlA===\n",var1,var2);
  return i;
}

int float8_a_2059c() {

  float8 var1 = (float8) (0.0,-1.23,123455.134,-12345.032,2.0,2.0,123455.134,-1.23);
  float8 var2 = (float8) (-1.23,-12345.032,123455.134,-12345.032,0.0,123455.134,0.0,-1.23);
  int i = printf("float8_a_2059c===%+.3v8hlA===%+.3v8hlA===\n",var1,var2);
  return i;
}

int float8_a_2060c() {

  float8 var1 = (float8) (0.0,1.0,1.0,-12345.032,2.0,1.0,0.0,-1.23);
  float8 var2 = (float8) (1.0,2.0,-1.23,-1.23,2.0,2.0,-1.23,-1.23);
  int i = printf("float8_a_2060c===%+.10v8hlA===%+.10v8hlA===\n",var1,var2);
  return i;
}

int float8_a_2811c() {

  float8 var1 = (float8) (-1.23,-12345.032,2.0,2.0,0.0,123455.134,-12345.032,123455.134);
  float8 var2 = (float8) (1.0,1.0,123455.134,-12345.032,1.0,123455.134,1.0,-12345.032);
  int i = printf("float8_a_2811c===%#v8hla===%#v8hla===\n",var1,var2);
  return i;
}

int float8_a_2812c() {

  float8 var1 = (float8) (-12345.032,2.0,-1.23,2.0,-1.23,-1.23,123455.134,-12345.032);
  float8 var2 = (float8) (-12345.032,-1.23,2.0,0.0,1.0,-1.23,123455.134,123455.134);
  int i = printf("float8_a_2812c===%#.1v8hla===%#.1v8hla===\n",var1,var2);
  return i;
}

int float8_a_2813c() {

  float8 var1 = (float8) (-1.23,123455.134,-12345.032,2.0,-1.23,-1.23,0.0,-1.23);
  float8 var2 = (float8) (2.0,-1.23,1.0,123455.134,-12345.032,0.0,2.0,123455.134);
  int i = printf("float8_a_2813c===%#.2v8hla===%#.2v8hla===\n",var1,var2);
  return i;
}

int float8_a_2814c() {

  float8 var1 = (float8) (0.0,-1.23,-1.23,-12345.032,-1.23,1.0,-12345.032,1.0);
  float8 var2 = (float8) (123455.134,-12345.032,2.0,2.0,0.0,2.0,123455.134,0.0);
  int i = printf("float8_a_2814c===%#.3v8hla===%#.3v8hla===\n",var1,var2);
  return i;
}

int float8_a_2815c() {

  float8 var1 = (float8) (123455.134,123455.134,0.0,2.0,2.0,1.0,-1.23,1.0);
  float8 var2 = (float8) (0.0,1.0,2.0,0.0,123455.134,2.0,0.0,-1.23);
  int i = printf("float8_a_2815c===%#.10v8hla===%#.10v8hla===\n",var1,var2);
  return i;
}

int float8_a_2816c() {

  float8 var1 = (float8) (-1.23,0.0,-1.23,0.0,1.0,-1.23,-12345.032,-1.23);
  float8 var2 = (float8) (123455.134,1.0,-12345.032,-12345.032,-12345.032,-12345.032,-1.23,1.0);
  int i = printf("float8_a_2816c===%#v8hlA===%#v8hlA===\n",var1,var2);
  return i;
}

int float8_a_2817c() {

  float8 var1 = (float8) (2.0,0.0,-12345.032,0.0,-12345.032,1.0,0.0,0.0);
  float8 var2 = (float8) (-1.23,-1.23,0.0,-12345.032,2.0,-1.23,0.0,-1.23);
  int i = printf("float8_a_2817c===%#.1v8hlA===%#.1v8hlA===\n",var1,var2);
  return i;
}

int float8_a_2818c() {

  float8 var1 = (float8) (123455.134,-1.23,-1.23,2.0,-1.23,-1.23,2.0,-1.23);
  float8 var2 = (float8) (123455.134,2.0,-1.23,-1.23,1.0,-1.23,-12345.032,123455.134);
  int i = printf("float8_a_2818c===%#.2v8hlA===%#.2v8hlA===\n",var1,var2);
  return i;
}

int float8_a_2819c() {

  float8 var1 = (float8) (1.0,-12345.032,-1.23,-12345.032,-1.23,1.0,-12345.032,1.0);
  float8 var2 = (float8) (2.0,1.0,0.0,1.0,-12345.032,0.0,-1.23,-12345.032);
  int i = printf("float8_a_2819c===%#.3v8hlA===%#.3v8hlA===\n",var1,var2);
  return i;
}

int float8_a_2820c() {

  float8 var1 = (float8) (-12345.032,123455.134,-1.23,-12345.032,1.0,2.0,-1.23,-1.23);
  float8 var2 = (float8) (0.0,1.0,1.0,2.0,123455.134,0.0,0.0,-1.23);
  int i = printf("float8_a_2820c===%#.10v8hlA===%#.10v8hlA===\n",var1,var2);
  return i;
}

int float8_a_3571c() {

  float8 var1 = (float8) (123455.134,-12345.032,0.0,2.0,2.0,-1.23,-12345.032,2.0);
  float8 var2 = (float8) (2.0,0.0,2.0,-1.23,-1.23,0.0,123455.134,-12345.032);
  int i = printf("float8_a_3571c===%-+v8hla===%-+v8hla===\n",var1,var2);
  return i;
}

int float8_a_3572c() {

  float8 var1 = (float8) (-12345.032,-12345.032,-12345.032,2.0,-12345.032,-12345.032,-1.23,123455.134);
  float8 var2 = (float8) (-1.23,-1.23,-12345.032,2.0,-12345.032,1.0,0.0,0.0);
  int i = printf("float8_a_3572c===%-+.1v8hla===%-+.1v8hla===\n",var1,var2);
  return i;
}

int float8_a_3573c() {

  float8 var1 = (float8) (0.0,123455.134,0.0,0.0,123455.134,1.0,1.0,2.0);
  float8 var2 = (float8) (1.0,1.0,-1.23,2.0,-1.23,123455.134,-1.23,1.0);
  int i = printf("float8_a_3573c===%-+.2v8hla===%-+.2v8hla===\n",var1,var2);
  return i;
}

int float8_a_3574c() {

  float8 var1 = (float8) (123455.134,-12345.032,2.0,0.0,123455.134,-12345.032,-1.23,123455.134);
  float8 var2 = (float8) (2.0,0.0,1.0,2.0,0.0,1.0,-1.23,-12345.032);
  int i = printf("float8_a_3574c===%-+.3v8hla===%-+.3v8hla===\n",var1,var2);
  return i;
}

int float8_a_3575c() {

  float8 var1 = (float8) (-12345.032,-12345.032,2.0,-12345.032,123455.134,0.0,1.0,1.0);
  float8 var2 = (float8) (2.0,-12345.032,2.0,1.0,0.0,1.0,-12345.032,2.0);
  int i = printf("float8_a_3575c===%-+.10v8hla===%-+.10v8hla===\n",var1,var2);
  return i;
}

int float8_a_3576c() {

  float8 var1 = (float8) (123455.134,2.0,123455.134,-12345.032,-12345.032,2.0,1.0,-12345.032);
  float8 var2 = (float8) (-12345.032,0.0,0.0,-1.23,-12345.032,2.0,123455.134,-1.23);
  int i = printf("float8_a_3576c===%-+v8hlA===%-+v8hlA===\n",var1,var2);
  return i;
}

int float8_a_3577c() {

  float8 var1 = (float8) (123455.134,2.0,1.0,-12345.032,0.0,-12345.032,0.0,1.0);
  float8 var2 = (float8) (-1.23,2.0,123455.134,0.0,-12345.032,-1.23,-12345.032,0.0);
  int i = printf("float8_a_3577c===%-+.1v8hlA===%-+.1v8hlA===\n",var1,var2);
  return i;
}

int float8_a_3578c() {

  float8 var1 = (float8) (1.0,0.0,0.0,1.0,123455.134,-1.23,-1.23,0.0);
  float8 var2 = (float8) (123455.134,2.0,2.0,1.0,-1.23,1.0,-1.23,2.0);
  int i = printf("float8_a_3578c===%-+.2v8hlA===%-+.2v8hlA===\n",var1,var2);
  return i;
}

int float8_a_3579c() {

  float8 var1 = (float8) (2.0,-12345.032,-1.23,-12345.032,123455.134,-1.23,1.0,2.0);
  float8 var2 = (float8) (123455.134,2.0,1.0,1.0,2.0,-1.23,0.0,-12345.032);
  int i = printf("float8_a_3579c===%-+.3v8hlA===%-+.3v8hlA===\n",var1,var2);
  return i;
}

int float8_a_3580c() {

  float8 var1 = (float8) (-12345.032,-12345.032,-1.23,2.0,-1.23,0.0,-12345.032,2.0);
  float8 var2 = (float8) (-1.23,2.0,1.0,1.0,-12345.032,1.0,-12345.032,0.0);
  int i = printf("float8_a_3580c===%-+.10v8hlA===%-+.10v8hlA===\n",var1,var2);
  return i;
}

int float8_a_4331c() {

  float8 var1 = (float8) (123455.134,1.0,-12345.032,1.0,0.0,2.0,123455.134,1.0);
  float8 var2 = (float8) (2.0,-12345.032,1.0,123455.134,-1.23,-12345.032,1.0,123455.134);
  int i = printf("float8_a_4331c===% 10v8hla===% 10v8hla===\n",var1,var2);
  return i;
}

int float8_a_4332c() {

  float8 var1 = (float8) (1.0,123455.134,1.0,-1.23,1.0,123455.134,1.0,-12345.032);
  float8 var2 = (float8) (1.0,-1.23,123455.134,-1.23,123455.134,2.0,123455.134,-12345.032);
  int i = printf("float8_a_4332c===% 10.1v8hla===% 10.1v8hla===\n",var1,var2);
  return i;
}

int float8_a_4333c() {

  float8 var1 = (float8) (-1.23,1.0,123455.134,2.0,123455.134,2.0,0.0,0.0);
  float8 var2 = (float8) (2.0,-12345.032,0.0,123455.134,0.0,0.0,1.0,0.0);
  int i = printf("float8_a_4333c===% 10.2v8hla===% 10.2v8hla===\n",var1,var2);
  return i;
}

int float8_a_4334c() {

  float8 var1 = (float8) (2.0,-12345.032,0.0,123455.134,-1.23,-1.23,-1.23,2.0);
  float8 var2 = (float8) (0.0,1.0,-1.23,-1.23,0.0,123455.134,-1.23,0.0);
  int i = printf("float8_a_4334c===% 10.3v8hla===% 10.3v8hla===\n",var1,var2);
  return i;
}

int float8_a_4335c() {

  float8 var1 = (float8) (-1.23,2.0,2.0,123455.134,1.0,0.0,-1.23,-12345.032);
  float8 var2 = (float8) (-12345.032,-12345.032,-1.23,2.0,-12345.032,-1.23,1.0,2.0);
  int i = printf("float8_a_4335c===% 10.10v8hla===% 10.10v8hla===\n",var1,var2);
  return i;
}

int float8_a_4336c() {

  float8 var1 = (float8) (2.0,0.0,-1.23,-12345.032,2.0,2.0,-12345.032,-12345.032);
  float8 var2 = (float8) (1.0,-1.23,123455.134,2.0,-12345.032,2.0,123455.134,-12345.032);
  int i = printf("float8_a_4336c===% 10v8hlA===% 10v8hlA===\n",var1,var2);
  return i;
}

int float8_a_4337c() {

  float8 var1 = (float8) (0.0,-1.23,0.0,0.0,1.0,1.0,2.0,2.0);
  float8 var2 = (float8) (123455.134,0.0,0.0,1.0,-12345.032,1.0,0.0,1.0);
  int i = printf("float8_a_4337c===% 10.1v8hlA===% 10.1v8hlA===\n",var1,var2);
  return i;
}

int float8_a_4338c() {

  float8 var1 = (float8) (1.0,-12345.032,-12345.032,-12345.032,2.0,2.0,-1.23,-12345.032);
  float8 var2 = (float8) (0.0,0.0,1.0,-1.23,0.0,123455.134,0.0,2.0);
  int i = printf("float8_a_4338c===% 10.2v8hlA===% 10.2v8hlA===\n",var1,var2);
  return i;
}

int float8_a_4339c() {

  float8 var1 = (float8) (-12345.032,2.0,0.0,-1.23,0.0,-1.23,1.0,2.0);
  float8 var2 = (float8) (0.0,2.0,123455.134,0.0,-12345.032,1.0,123455.134,0.0);
  int i = printf("float8_a_4339c===% 10.3v8hlA===% 10.3v8hlA===\n",var1,var2);
  return i;
}

int float8_a_4340c() {

  float8 var1 = (float8) (-12345.032,2.0,2.0,2.0,2.0,123455.134,2.0,1.0);
  float8 var2 = (float8) (123455.134,1.0,1.0,123455.134,2.0,0.0,0.0,-1.23);
  int i = printf("float8_a_4340c===% 10.10v8hlA===% 10.10v8hlA===\n",var1,var2);
  return i;
}

int float8_a_5091c() {

  float8 var1 = (float8) (1.0,2.0,1.0,-1.23,-12345.032,1.0,-12345.032,-1.23);
  float8 var2 = (float8) (-12345.032,2.0,-1.23,-1.23,-12345.032,-1.23,2.0,0.0);
  int i = printf("float8_a_5091c===%010v8hla===%010v8hla===\n",var1,var2);
  return i;
}

int float8_a_5092c() {

  float8 var1 = (float8) (0.0,0.0,2.0,2.0,123455.134,2.0,123455.134,-1.23);
  float8 var2 = (float8) (-12345.032,-12345.032,0.0,-1.23,0.0,123455.134,-1.23,1.0);
  int i = printf("float8_a_5092c===%010.1v8hla===%010.1v8hla===\n",var1,var2);
  return i;
}

int float8_a_5093c() {

  float8 var1 = (float8) (1.0,123455.134,2.0,-12345.032,-12345.032,-12345.032,1.0,0.0);
  float8 var2 = (float8) (0.0,-12345.032,0.0,0.0,-1.23,2.0,-12345.032,1.0);
  int i = printf("float8_a_5093c===%010.2v8hla===%010.2v8hla===\n",var1,var2);
  return i;
}

int float8_a_5094c() {

  float8 var1 = (float8) (2.0,1.0,-12345.032,1.0,123455.134,123455.134,2.0,123455.134);
  float8 var2 = (float8) (0.0,1.0,1.0,123455.134,2.0,2.0,1.0,-12345.032);
  int i = printf("float8_a_5094c===%010.3v8hla===%010.3v8hla===\n",var1,var2);
  return i;
}

int float8_a_5095c() {

  float8 var1 = (float8) (123455.134,0.0,123455.134,123455.134,1.0,-1.23,2.0,-12345.032);
  float8 var2 = (float8) (2.0,0.0,2.0,123455.134,0.0,-12345.032,1.0,-12345.032);
  int i = printf("float8_a_5095c===%010.10v8hla===%010.10v8hla===\n",var1,var2);
  return i;
}

int float8_a_5096c() {

  float8 var1 = (float8) (0.0,123455.134,0.0,1.0,-12345.032,0.0,0.0,-1.23);
  float8 var2 = (float8) (-12345.032,2.0,-1.23,0.0,2.0,2.0,2.0,-12345.032);
  int i = printf("float8_a_5096c===%010v8hlA===%010v8hlA===\n",var1,var2);
  return i;
}

int float8_a_5097c() {

  float8 var1 = (float8) (-1.23,-1.23,-12345.032,-1.23,123455.134,-12345.032,0.0,123455.134);
  float8 var2 = (float8) (123455.134,0.0,2.0,123455.134,2.0,-12345.032,2.0,1.0);
  int i = printf("float8_a_5097c===%010.1v8hlA===%010.1v8hlA===\n",var1,var2);
  return i;
}

int float8_a_5098c() {

  float8 var1 = (float8) (-1.23,0.0,0.0,1.0,0.0,123455.134,1.0,-1.23);
  float8 var2 = (float8) (123455.134,1.0,-12345.032,1.0,-1.23,2.0,2.0,1.0);
  int i = printf("float8_a_5098c===%010.2v8hlA===%010.2v8hlA===\n",var1,var2);
  return i;
}

int float8_a_5099c() {

  float8 var1 = (float8) (2.0,-12345.032,2.0,-12345.032,123455.134,-12345.032,2.0,2.0);
  float8 var2 = (float8) (123455.134,0.0,-12345.032,2.0,1.0,1.0,123455.134,123455.134);
  int i = printf("float8_a_5099c===%010.3v8hlA===%010.3v8hlA===\n",var1,var2);
  return i;
}

int float8_a_5100c() {

  float8 var1 = (float8) (123455.134,-12345.032,-1.23,123455.134,-1.23,0.0,-12345.032,123455.134);
  float8 var2 = (float8) (-12345.032,-12345.032,123455.134,-12345.032,0.0,1.0,-1.23,1.0);
  int i = printf("float8_a_5100c===%010.10v8hlA===%010.10v8hlA===\n",var1,var2);
  return i;
}

int float8_a_531c() {

  float8 var1 = (float8) (0.0,1.0,123455.134,-12345.032,1.0,-12345.032,1.0,2.0);
  float8 var2 = (float8) (0.0,123455.134,0.0,2.0,-12345.032,123455.134,-12345.032,0.0);
  int i = printf("float8_a_531c===%v8hla===%v8hla===\n",var1,var2);
  return i;
}

int float8_a_532c() {

  float8 var1 = (float8) (-12345.032,123455.134,0.0,1.0,2.0,123455.134,-1.23,-12345.032);
  float8 var2 = (float8) (123455.134,0.0,-1.23,123455.134,-1.23,-12345.032,123455.134,2.0);
  int i = printf("float8_a_532c===%.1v8hla===%.1v8hla===\n",var1,var2);
  return i;
}

int float8_a_533c() {

  float8 var1 = (float8) (0.0,2.0,-1.23,123455.134,0.0,2.0,123455.134,-1.23);
  float8 var2 = (float8) (2.0,2.0,-1.23,-12345.032,2.0,2.0,123455.134,-12345.032);
  int i = printf("float8_a_533c===%.2v8hla===%.2v8hla===\n",var1,var2);
  return i;
}

int float8_a_534c() {

  float8 var1 = (float8) (0.0,-1.23,-12345.032,123455.134,123455.134,2.0,2.0,123455.134);
  float8 var2 = (float8) (2.0,1.0,-1.23,-12345.032,1.0,-1.23,1.0,2.0);
  int i = printf("float8_a_534c===%.3v8hla===%.3v8hla===\n",var1,var2);
  return i;
}

int float8_a_535c() {

  float8 var1 = (float8) (2.0,0.0,-12345.032,2.0,0.0,-12345.032,0.0,-12345.032);
  float8 var2 = (float8) (0.0,1.0,123455.134,-12345.032,123455.134,-1.23,123455.134,2.0);
  int i = printf("float8_a_535c===%.10v8hla===%.10v8hla===\n",var1,var2);
  return i;
}

int float8_a_536c() {

  float8 var1 = (float8) (-12345.032,-1.23,-1.23,-1.23,-12345.032,1.0,2.0,-1.23);
  float8 var2 = (float8) (-1.23,-12345.032,123455.134,-1.23,123455.134,0.0,-12345.032,0.0);
  int i = printf("float8_a_536c===%v8hlA===%v8hlA===\n",var1,var2);
  return i;
}

int float8_a_537c() {

  float8 var1 = (float8) (2.0,123455.134,1.0,0.0,-1.23,-12345.032,-12345.032,-12345.032);
  float8 var2 = (float8) (2.0,1.0,-12345.032,-12345.032,-12345.032,-1.23,1.0,-1.23);
  int i = printf("float8_a_537c===%.1v8hlA===%.1v8hlA===\n",var1,var2);
  return i;
}

int float8_a_538c() {

  float8 var1 = (float8) (2.0,1.0,0.0,1.0,1.0,2.0,123455.134,2.0);
  float8 var2 = (float8) (0.0,1.0,-1.23,2.0,2.0,0.0,-12345.032,-1.23);
  int i = printf("float8_a_538c===%.2v8hlA===%.2v8hlA===\n",var1,var2);
  return i;
}

int float8_a_539c() {

  float8 var1 = (float8) (-12345.032,-1.23,1.0,1.0,2.0,-12345.032,-12345.032,-1.23);
  float8 var2 = (float8) (123455.134,-12345.032,123455.134,-1.23,123455.134,1.0,-1.23,-12345.032);
  int i = printf("float8_a_539c===%.3v8hlA===%.3v8hlA===\n",var1,var2);
  return i;
}

int float8_a_540c() {

  float8 var1 = (float8) (2.0,2.0,123455.134,123455.134,-12345.032,123455.134,1.0,-1.23);
  float8 var2 = (float8) (0.0,1.0,1.0,-1.23,2.0,-12345.032,-1.23,1.0);
  int i = printf("float8_a_540c===%.10v8hlA===%.10v8hlA===\n",var1,var2);
  return i;
}

int float8_a_5851c() {

  float8 var1 = (float8) (123455.134,1.0,1.0,123455.134,2.0,-12345.032,-12345.032,0.0);
  float8 var2 = (float8) (2.0,0.0,0.0,2.0,0.0,1.0,123455.134,-12345.032);
  int i = printf("float8_a_5851c===%- 10v8hla===%- 10v8hla===\n",var1,var2);
  return i;
}

int float8_a_5852c() {

  float8 var1 = (float8) (0.0,2.0,-1.23,0.0,-1.23,2.0,123455.134,0.0);
  float8 var2 = (float8) (0.0,-1.23,-1.23,-1.23,1.0,-1.23,-1.23,2.0);
  int i = printf("float8_a_5852c===%- 10.1v8hla===%- 10.1v8hla===\n",var1,var2);
  return i;
}

int float8_a_5853c() {

  float8 var1 = (float8) (-1.23,1.0,2.0,123455.134,-12345.032,0.0,-1.23,-12345.032);
  float8 var2 = (float8) (123455.134,1.0,0.0,-12345.032,-12345.032,0.0,1.0,0.0);
  int i = printf("float8_a_5853c===%- 10.2v8hla===%- 10.2v8hla===\n",var1,var2);
  return i;
}

int float8_a_5854c() {

  float8 var1 = (float8) (123455.134,123455.134,-12345.032,2.0,0.0,1.0,123455.134,2.0);
  float8 var2 = (float8) (123455.134,-1.23,123455.134,0.0,1.0,123455.134,2.0,-1.23);
  int i = printf("float8_a_5854c===%- 10.3v8hla===%- 10.3v8hla===\n",var1,var2);
  return i;
}

int float8_a_5855c() {

  float8 var1 = (float8) (-1.23,0.0,123455.134,1.0,2.0,-12345.032,-1.23,123455.134);
  float8 var2 = (float8) (123455.134,-1.23,1.0,0.0,-12345.032,-1.23,2.0,0.0);
  int i = printf("float8_a_5855c===%- 10.10v8hla===%- 10.10v8hla===\n",var1,var2);
  return i;
}

int float8_a_5856c() {

  float8 var1 = (float8) (0.0,-12345.032,1.0,1.0,-12345.032,2.0,0.0,-1.23);
  float8 var2 = (float8) (-12345.032,-1.23,123455.134,2.0,-1.23,-12345.032,123455.134,-1.23);
  int i = printf("float8_a_5856c===%- 10v8hlA===%- 10v8hlA===\n",var1,var2);
  return i;
}

int float8_a_5857c() {

  float8 var1 = (float8) (-12345.032,123455.134,-1.23,2.0,-12345.032,0.0,1.0,0.0);
  float8 var2 = (float8) (1.0,123455.134,123455.134,1.0,-12345.032,123455.134,123455.134,-12345.032);
  int i = printf("float8_a_5857c===%- 10.1v8hlA===%- 10.1v8hlA===\n",var1,var2);
  return i;
}

int float8_a_5858c() {

  float8 var1 = (float8) (-1.23,1.0,123455.134,0.0,123455.134,-12345.032,0.0,-1.23);
  float8 var2 = (float8) (123455.134,2.0,0.0,2.0,1.0,2.0,-12345.032,2.0);
  int i = printf("float8_a_5858c===%- 10.2v8hlA===%- 10.2v8hlA===\n",var1,var2);
  return i;
}

int float8_a_5859c() {

  float8 var1 = (float8) (123455.134,123455.134,2.0,-1.23,1.0,-1.23,123455.134,-1.23);
  float8 var2 = (float8) (123455.134,2.0,-1.23,2.0,1.0,1.0,-12345.032,2.0);
  int i = printf("float8_a_5859c===%- 10.3v8hlA===%- 10.3v8hlA===\n",var1,var2);
  return i;
}

int float8_a_5860c() {

  float8 var1 = (float8) (0.0,-12345.032,0.0,-12345.032,123455.134,123455.134,0.0,123455.134);
  float8 var2 = (float8) (2.0,1.0,1.0,1.0,123455.134,123455.134,0.0,0.0);
  int i = printf("float8_a_5860c===%- 10.10v8hlA===%- 10.10v8hlA===\n",var1,var2);
  return i;
}

int float8_a_6611c() {

  float8 var1 = (float8) (-12345.032,123455.134,123455.134,-12345.032,-1.23,-12345.032,1.0,0.0);
  float8 var2 = (float8) (0.0,0.0,1.0,1.0,-1.23,-12345.032,123455.134,123455.134);
  int i = printf("float8_a_6611c===%+ 10v8hla===%+ 10v8hla===\n",var1,var2);
  return i;
}

int float8_a_6612c() {

  float8 var1 = (float8) (-1.23,-12345.032,0.0,1.0,123455.134,-12345.032,-1.23,2.0);
  float8 var2 = (float8) (-1.23,2.0,1.0,123455.134,-12345.032,-1.23,1.0,123455.134);
  int i = printf("float8_a_6612c===%+ 10.1v8hla===%+ 10.1v8hla===\n",var1,var2);
  return i;
}

int float8_a_6613c() {

  float8 var1 = (float8) (1.0,-12345.032,123455.134,123455.134,-12345.032,1.0,0.0,123455.134);
  float8 var2 = (float8) (-1.23,-12345.032,2.0,2.0,-1.23,-1.23,-1.23,1.0);
  int i = printf("float8_a_6613c===%+ 10.2v8hla===%+ 10.2v8hla===\n",var1,var2);
  return i;
}

int float8_a_6614c() {

  float8 var1 = (float8) (0.0,-1.23,1.0,123455.134,2.0,1.0,0.0,2.0);
  float8 var2 = (float8) (0.0,2.0,0.0,-1.23,-12345.032,0.0,0.0,1.0);
  int i = printf("float8_a_6614c===%+ 10.3v8hla===%+ 10.3v8hla===\n",var1,var2);
  return i;
}

int float8_a_6615c() {

  float8 var1 = (float8) (-1.23,1.0,1.0,-1.23,1.0,2.0,1.0,0.0);
  float8 var2 = (float8) (-12345.032,123455.134,1.0,-12345.032,-1.23,-1.23,2.0,-12345.032);
  int i = printf("float8_a_6615c===%+ 10.10v8hla===%+ 10.10v8hla===\n",var1,var2);
  return i;
}

int float8_a_6616c() {

  float8 var1 = (float8) (-12345.032,-1.23,2.0,1.0,-12345.032,-1.23,1.0,1.0);
  float8 var2 = (float8) (1.0,-12345.032,123455.134,123455.134,-12345.032,-1.23,0.0,-12345.032);
  int i = printf("float8_a_6616c===%+ 10v8hlA===%+ 10v8hlA===\n",var1,var2);
  return i;
}

int float8_a_6617c() {

  float8 var1 = (float8) (0.0,123455.134,0.0,-1.23,123455.134,2.0,2.0,1.0);
  float8 var2 = (float8) (-12345.032,-12345.032,0.0,-12345.032,2.0,123455.134,2.0,123455.134);
  int i = printf("float8_a_6617c===%+ 10.1v8hlA===%+ 10.1v8hlA===\n",var1,var2);
  return i;
}

int float8_a_6618c() {

  float8 var1 = (float8) (-12345.032,123455.134,-12345.032,-1.23,1.0,2.0,1.0,2.0);
  float8 var2 = (float8) (-12345.032,-1.23,2.0,123455.134,-1.23,-12345.032,-12345.032,123455.134);
  int i = printf("float8_a_6618c===%+ 10.2v8hlA===%+ 10.2v8hlA===\n",var1,var2);
  return i;
}

int float8_a_6619c() {

  float8 var1 = (float8) (-12345.032,-12345.032,-12345.032,0.0,-12345.032,2.0,0.0,-1.23);
  float8 var2 = (float8) (-12345.032,1.0,123455.134,123455.134,-1.23,1.0,-1.23,0.0);
  int i = printf("float8_a_6619c===%+ 10.3v8hlA===%+ 10.3v8hlA===\n",var1,var2);
  return i;
}

int float8_a_6620c() {

  float8 var1 = (float8) (123455.134,-12345.032,-12345.032,0.0,1.0,2.0,-1.23,123455.134);
  float8 var2 = (float8) (2.0,123455.134,2.0,0.0,2.0,123455.134,0.0,-12345.032);
  int i = printf("float8_a_6620c===%+ 10.10v8hlA===%+ 10.10v8hlA===\n",var1,var2);
  return i;
}

int float8_a_7371c() {

  float8 var1 = (float8) (123455.134,123455.134,0.0,1.0,1.0,0.0,1.0,-12345.032);
  float8 var2 = (float8) (-1.23,-1.23,123455.134,-1.23,123455.134,-12345.032,1.0,1.0);
  int i = printf("float8_a_7371c===%+010v8hla===%+010v8hla===\n",var1,var2);
  return i;
}

int float8_a_7372c() {

  float8 var1 = (float8) (2.0,1.0,-1.23,2.0,0.0,123455.134,123455.134,-1.23);
  float8 var2 = (float8) (123455.134,0.0,-12345.032,2.0,2.0,1.0,-12345.032,2.0);
  int i = printf("float8_a_7372c===%+010.1v8hla===%+010.1v8hla===\n",var1,var2);
  return i;
}

int float8_a_7373c() {

  float8 var1 = (float8) (-12345.032,123455.134,0.0,1.0,2.0,123455.134,1.0,1.0);
  float8 var2 = (float8) (-1.23,2.0,0.0,2.0,0.0,2.0,2.0,1.0);
  int i = printf("float8_a_7373c===%+010.2v8hla===%+010.2v8hla===\n",var1,var2);
  return i;
}

int float8_a_7374c() {

  float8 var1 = (float8) (1.0,-1.23,1.0,1.0,2.0,-1.23,2.0,123455.134);
  float8 var2 = (float8) (0.0,1.0,0.0,0.0,0.0,-1.23,-1.23,2.0);
  int i = printf("float8_a_7374c===%+010.3v8hla===%+010.3v8hla===\n",var1,var2);
  return i;
}

int float8_a_7375c() {

  float8 var1 = (float8) (0.0,2.0,123455.134,2.0,1.0,123455.134,2.0,0.0);
  float8 var2 = (float8) (123455.134,2.0,0.0,0.0,123455.134,123455.134,-1.23,2.0);
  int i = printf("float8_a_7375c===%+010.10v8hla===%+010.10v8hla===\n",var1,var2);
  return i;
}

int float8_a_7376c() {

  float8 var1 = (float8) (1.0,0.0,-1.23,0.0,0.0,-1.23,-12345.032,123455.134);
  float8 var2 = (float8) (-12345.032,0.0,-1.23,0.0,1.0,123455.134,-12345.032,0.0);
  int i = printf("float8_a_7376c===%+010v8hlA===%+010v8hlA===\n",var1,var2);
  return i;
}

int float8_a_7377c() {

  float8 var1 = (float8) (2.0,0.0,123455.134,1.0,0.0,0.0,1.0,0.0);
  float8 var2 = (float8) (-12345.032,-12345.032,-12345.032,1.0,1.0,123455.134,1.0,2.0);
  int i = printf("float8_a_7377c===%+010.1v8hlA===%+010.1v8hlA===\n",var1,var2);
  return i;
}

int float8_a_7378c() {

  float8 var1 = (float8) (2.0,123455.134,-12345.032,-12345.032,0.0,-12345.032,2.0,123455.134);
  float8 var2 = (float8) (1.0,123455.134,0.0,-12345.032,2.0,-12345.032,2.0,-12345.032);
  int i = printf("float8_a_7378c===%+010.2v8hlA===%+010.2v8hlA===\n",var1,var2);
  return i;
}

int float8_a_7379c() {

  float8 var1 = (float8) (-1.23,2.0,0.0,0.0,0.0,0.0,123455.134,0.0);
  float8 var2 = (float8) (0.0,2.0,-1.23,2.0,123455.134,2.0,-1.23,123455.134);
  int i = printf("float8_a_7379c===%+010.3v8hlA===%+010.3v8hlA===\n",var1,var2);
  return i;
}

int float8_a_7380c() {

  float8 var1 = (float8) (0.0,123455.134,0.0,-1.23,0.0,123455.134,-1.23,-1.23);
  float8 var2 = (float8) (123455.134,123455.134,2.0,-1.23,-1.23,1.0,123455.134,-12345.032);
  int i = printf("float8_a_7380c===%+010.10v8hlA===%+010.10v8hlA===\n",var1,var2);
  return i;
}

int float8_e_1301c() {

  float8 var1 = (float8) (1.0,-1.23,123455.134,1.0,-1.23,2.0,0.0,123455.134);
  float8 var2 = (float8) (-1.23,1.0,0.0,123455.134,2.0,-1.23,1.0,0.0);
  int i = printf("float8_e_1301c===%-v8hle===%-v8hle===\n",var1,var2);
  return i;
}

int float8_e_1302c() {

  float8 var1 = (float8) (-1.23,0.0,123455.134,-1.23,-1.23,1.0,-1.23,2.0);
  float8 var2 = (float8) (123455.134,0.0,-12345.032,-1.23,-1.23,0.0,-12345.032,123455.134);
  int i = printf("float8_e_1302c===%-.1v8hle===%-.1v8hle===\n",var1,var2);
  return i;
}

int float8_e_1303c() {

  float8 var1 = (float8) (-1.23,-1.23,-1.23,2.0,1.0,-12345.032,0.0,1.0);
  float8 var2 = (float8) (2.0,123455.134,0.0,2.0,123455.134,0.0,-1.23,0.0);
  int i = printf("float8_e_1303c===%-.2v8hle===%-.2v8hle===\n",var1,var2);
  return i;
}

int float8_e_1304c() {

  float8 var1 = (float8) (-12345.032,123455.134,-12345.032,0.0,2.0,1.0,0.0,123455.134);
  float8 var2 = (float8) (0.0,0.0,-12345.032,1.0,-12345.032,2.0,-12345.032,2.0);
  int i = printf("float8_e_1304c===%-.3v8hle===%-.3v8hle===\n",var1,var2);
  return i;
}

int float8_e_1305c() {

  float8 var1 = (float8) (-1.23,123455.134,-1.23,0.0,1.0,0.0,123455.134,-1.23);
  float8 var2 = (float8) (0.0,2.0,1.0,2.0,-1.23,-12345.032,0.0,-12345.032);
  int i = printf("float8_e_1305c===%-.10v8hle===%-.10v8hle===\n",var1,var2);
  return i;
}

int float8_e_1306c() {

  float8 var1 = (float8) (0.0,-12345.032,0.0,-12345.032,0.0,123455.134,123455.134,-12345.032);
  float8 var2 = (float8) (-12345.032,123455.134,-12345.032,1.0,0.0,-12345.032,-12345.032,-1.23);
  int i = printf("float8_e_1306c===%-v8hlE===%-v8hlE===\n",var1,var2);
  return i;
}

int float8_e_1307c() {

  float8 var1 = (float8) (2.0,123455.134,-1.23,0.0,-12345.032,1.0,2.0,2.0);
  float8 var2 = (float8) (-12345.032,1.0,0.0,123455.134,2.0,2.0,0.0,0.0);
  int i = printf("float8_e_1307c===%-.1v8hlE===%-.1v8hlE===\n",var1,var2);
  return i;
}

int float8_e_1308c() {

  float8 var1 = (float8) (2.0,1.0,123455.134,123455.134,1.0,123455.134,-12345.032,2.0);
  float8 var2 = (float8) (-12345.032,123455.134,-1.23,123455.134,123455.134,1.0,1.0,2.0);
  int i = printf("float8_e_1308c===%-.2v8hlE===%-.2v8hlE===\n",var1,var2);
  return i;
}

int float8_e_1309c() {

  float8 var1 = (float8) (2.0,0.0,-1.23,123455.134,1.0,-12345.032,2.0,-1.23);
  float8 var2 = (float8) (2.0,1.0,0.0,-12345.032,-1.23,-12345.032,0.0,-12345.032);
  int i = printf("float8_e_1309c===%-.3v8hlE===%-.3v8hlE===\n",var1,var2);
  return i;
}

int float8_e_1310c() {

  float8 var1 = (float8) (2.0,-12345.032,0.0,123455.134,-1.23,123455.134,123455.134,-1.23);
  float8 var2 = (float8) (123455.134,0.0,-1.23,2.0,2.0,2.0,0.0,1.0);
  int i = printf("float8_e_1310c===%-.10v8hlE===%-.10v8hlE===\n",var1,var2);
  return i;
}

int float8_e_2061c() {

  float8 var1 = (float8) (1.0,2.0,-1.23,-12345.032,123455.134,-12345.032,1.0,1.0);
  float8 var2 = (float8) (2.0,2.0,0.0,2.0,0.0,123455.134,0.0,-1.23);
  int i = printf("float8_e_2061c===%+v8hle===%+v8hle===\n",var1,var2);
  return i;
}

int float8_e_2062c() {

  float8 var1 = (float8) (0.0,1.0,1.0,-12345.032,1.0,1.0,123455.134,-12345.032);
  float8 var2 = (float8) (1.0,1.0,0.0,-12345.032,-12345.032,0.0,123455.134,2.0);
  int i = printf("float8_e_2062c===%+.1v8hle===%+.1v8hle===\n",var1,var2);
  return i;
}

int float8_e_2063c() {

  float8 var1 = (float8) (123455.134,-12345.032,123455.134,1.0,-12345.032,-1.23,0.0,1.0);
  float8 var2 = (float8) (1.0,1.0,-12345.032,-12345.032,2.0,0.0,-12345.032,-1.23);
  int i = printf("float8_e_2063c===%+.2v8hle===%+.2v8hle===\n",var1,var2);
  return i;
}

int float8_e_2064c() {

  float8 var1 = (float8) (2.0,-12345.032,2.0,-12345.032,-1.23,123455.134,0.0,123455.134);
  float8 var2 = (float8) (-1.23,-1.23,1.0,1.0,2.0,-1.23,1.0,2.0);
  int i = printf("float8_e_2064c===%+.3v8hle===%+.3v8hle===\n",var1,var2);
  return i;
}

int float8_e_2065c() {

  float8 var1 = (float8) (-1.23,-12345.032,2.0,-12345.032,-12345.032,0.0,2.0,2.0);
  float8 var2 = (float8) (-12345.032,0.0,0.0,-1.23,123455.134,-12345.032,0.0,2.0);
  int i = printf("float8_e_2065c===%+.10v8hle===%+.10v8hle===\n",var1,var2);
  return i;
}

int float8_e_2066c() {

  float8 var1 = (float8) (1.0,-1.23,1.0,2.0,123455.134,-1.23,123455.134,1.0);
  float8 var2 = (float8) (-12345.032,1.0,-1.23,-12345.032,-12345.032,123455.134,2.0,1.0);
  int i = printf("float8_e_2066c===%+v8hlE===%+v8hlE===\n",var1,var2);
  return i;
}

int float8_e_2067c() {

  float8 var1 = (float8) (1.0,2.0,1.0,0.0,-1.23,1.0,-1.23,0.0);
  float8 var2 = (float8) (2.0,-12345.032,-1.23,1.0,-12345.032,123455.134,2.0,0.0);
  int i = printf("float8_e_2067c===%+.1v8hlE===%+.1v8hlE===\n",var1,var2);
  return i;
}

int float8_e_2068c() {

  float8 var1 = (float8) (-1.23,123455.134,0.0,123455.134,123455.134,1.0,1.0,123455.134);
  float8 var2 = (float8) (1.0,-1.23,0.0,2.0,0.0,1.0,2.0,2.0);
  int i = printf("float8_e_2068c===%+.2v8hlE===%+.2v8hlE===\n",var1,var2);
  return i;
}

int float8_e_2069c() {

  float8 var1 = (float8) (123455.134,-12345.032,2.0,0.0,2.0,0.0,-1.23,-1.23);
  float8 var2 = (float8) (0.0,123455.134,2.0,0.0,123455.134,123455.134,-12345.032,123455.134);
  int i = printf("float8_e_2069c===%+.3v8hlE===%+.3v8hlE===\n",var1,var2);
  return i;
}

int float8_e_2070c() {

  float8 var1 = (float8) (1.0,123455.134,-1.23,-1.23,1.0,-12345.032,1.0,-1.23);
  float8 var2 = (float8) (2.0,1.0,2.0,0.0,1.0,0.0,2.0,1.0);
  int i = printf("float8_e_2070c===%+.10v8hlE===%+.10v8hlE===\n",var1,var2);
  return i;
}

int float8_e_2821c() {

  float8 var1 = (float8) (2.0,-12345.032,-1.23,-12345.032,1.0,123455.134,-12345.032,-12345.032);
  float8 var2 = (float8) (1.0,-1.23,0.0,-1.23,0.0,-12345.032,-1.23,1.0);
  int i = printf("float8_e_2821c===%#v8hle===%#v8hle===\n",var1,var2);
  return i;
}

int float8_e_2822c() {

  float8 var1 = (float8) (-1.23,-1.23,2.0,2.0,123455.134,123455.134,-12345.032,2.0);
  float8 var2 = (float8) (-1.23,1.0,123455.134,1.0,0.0,0.0,0.0,0.0);
  int i = printf("float8_e_2822c===%#.1v8hle===%#.1v8hle===\n",var1,var2);
  return i;
}

int float8_e_2823c() {

  float8 var1 = (float8) (2.0,-12345.032,0.0,1.0,0.0,0.0,-12345.032,2.0);
  float8 var2 = (float8) (-1.23,123455.134,2.0,2.0,0.0,2.0,-12345.032,-12345.032);
  int i = printf("float8_e_2823c===%#.2v8hle===%#.2v8hle===\n",var1,var2);
  return i;
}

int float8_e_2824c() {

  float8 var1 = (float8) (1.0,1.0,-12345.032,0.0,0.0,1.0,123455.134,123455.134);
  float8 var2 = (float8) (-1.23,0.0,123455.134,-12345.032,-1.23,1.0,2.0,123455.134);
  int i = printf("float8_e_2824c===%#.3v8hle===%#.3v8hle===\n",var1,var2);
  return i;
}

int float8_e_2825c() {

  float8 var1 = (float8) (2.0,0.0,123455.134,123455.134,1.0,2.0,0.0,-12345.032);
  float8 var2 = (float8) (-1.23,123455.134,1.0,123455.134,123455.134,-1.23,0.0,2.0);
  int i = printf("float8_e_2825c===%#.10v8hle===%#.10v8hle===\n",var1,var2);
  return i;
}

int float8_e_2826c() {

  float8 var1 = (float8) (-12345.032,0.0,123455.134,123455.134,2.0,1.0,-12345.032,123455.134);
  float8 var2 = (float8) (-1.23,-1.23,1.0,1.0,123455.134,-1.23,123455.134,123455.134);
  int i = printf("float8_e_2826c===%#v8hlE===%#v8hlE===\n",var1,var2);
  return i;
}

int float8_e_2827c() {

  float8 var1 = (float8) (123455.134,1.0,1.0,1.0,-12345.032,123455.134,-12345.032,0.0);
  float8 var2 = (float8) (0.0,-1.23,-1.23,0.0,-12345.032,-1.23,123455.134,123455.134);
  int i = printf("float8_e_2827c===%#.1v8hlE===%#.1v8hlE===\n",var1,var2);
  return i;
}

int float8_e_2828c() {

  float8 var1 = (float8) (0.0,123455.134,-12345.032,123455.134,1.0,2.0,1.0,123455.134);
  float8 var2 = (float8) (123455.134,0.0,1.0,-1.23,-12345.032,-12345.032,123455.134,-1.23);
  int i = printf("float8_e_2828c===%#.2v8hlE===%#.2v8hlE===\n",var1,var2);
  return i;
}

int float8_e_2829c() {

  float8 var1 = (float8) (2.0,2.0,2.0,-12345.032,-12345.032,-1.23,1.0,1.0);
  float8 var2 = (float8) (-1.23,-12345.032,2.0,2.0,1.0,-12345.032,-1.23,0.0);
  int i = printf("float8_e_2829c===%#.3v8hlE===%#.3v8hlE===\n",var1,var2);
  return i;
}

int float8_e_2830c() {

  float8 var1 = (float8) (123455.134,1.0,0.0,-1.23,1.0,123455.134,-12345.032,-1.23);
  float8 var2 = (float8) (1.0,0.0,-1.23,1.0,0.0,-12345.032,2.0,1.0);
  int i = printf("float8_e_2830c===%#.10v8hlE===%#.10v8hlE===\n",var1,var2);
  return i;
}

int float8_e_3581c() {

  float8 var1 = (float8) (-12345.032,0.0,-1.23,2.0,123455.134,1.0,123455.134,-12345.032);
  float8 var2 = (float8) (0.0,2.0,0.0,-1.23,1.0,-1.23,-1.23,0.0);
  int i = printf("float8_e_3581c===%-+v8hle===%-+v8hle===\n",var1,var2);
  return i;
}

int float8_e_3582c() {

  float8 var1 = (float8) (-1.23,-12345.032,2.0,2.0,1.0,0.0,0.0,-1.23);
  float8 var2 = (float8) (0.0,-12345.032,2.0,2.0,123455.134,-12345.032,2.0,123455.134);
  int i = printf("float8_e_3582c===%-+.1v8hle===%-+.1v8hle===\n",var1,var2);
  return i;
}

int float8_e_3583c() {

  float8 var1 = (float8) (0.0,-1.23,0.0,-1.23,2.0,1.0,123455.134,2.0);
  float8 var2 = (float8) (1.0,123455.134,1.0,2.0,1.0,0.0,-1.23,2.0);
  int i = printf("float8_e_3583c===%-+.2v8hle===%-+.2v8hle===\n",var1,var2);
  return i;
}

int float8_e_3584c() {

  float8 var1 = (float8) (-1.23,1.0,-12345.032,123455.134,123455.134,2.0,-12345.032,-12345.032);
  float8 var2 = (float8) (0.0,123455.134,-1.23,1.0,2.0,-12345.032,-12345.032,123455.134);
  int i = printf("float8_e_3584c===%-+.3v8hle===%-+.3v8hle===\n",var1,var2);
  return i;
}

int float8_e_3585c() {

  float8 var1 = (float8) (-12345.032,-1.23,2.0,-1.23,2.0,2.0,2.0,-12345.032);
  float8 var2 = (float8) (123455.134,1.0,1.0,0.0,1.0,123455.134,123455.134,1.0);
  int i = printf("float8_e_3585c===%-+.10v8hle===%-+.10v8hle===\n",var1,var2);
  return i;
}

int float8_e_3586c() {

  float8 var1 = (float8) (2.0,-12345.032,1.0,2.0,-12345.032,0.0,-12345.032,2.0);
  float8 var2 = (float8) (-12345.032,2.0,-12345.032,0.0,0.0,2.0,2.0,0.0);
  int i = printf("float8_e_3586c===%-+v8hlE===%-+v8hlE===\n",var1,var2);
  return i;
}

int float8_e_3587c() {

  float8 var1 = (float8) (2.0,1.0,2.0,0.0,123455.134,-1.23,2.0,123455.134);
  float8 var2 = (float8) (0.0,0.0,123455.134,-12345.032,0.0,0.0,123455.134,-1.23);
  int i = printf("float8_e_3587c===%-+.1v8hlE===%-+.1v8hlE===\n",var1,var2);
  return i;
}

int float8_e_3588c() {

  float8 var1 = (float8) (-12345.032,2.0,123455.134,1.0,1.0,0.0,0.0,1.0);
  float8 var2 = (float8) (1.0,-1.23,-1.23,0.0,0.0,123455.134,123455.134,0.0);
  int i = printf("float8_e_3588c===%-+.2v8hlE===%-+.2v8hlE===\n",var1,var2);
  return i;
}

int float8_e_3589c() {

  float8 var1 = (float8) (123455.134,123455.134,0.0,1.0,2.0,-1.23,1.0,-1.23);
  float8 var2 = (float8) (-12345.032,1.0,0.0,-1.23,0.0,2.0,-12345.032,1.0);
  int i = printf("float8_e_3589c===%-+.3v8hlE===%-+.3v8hlE===\n",var1,var2);
  return i;
}

int float8_e_3590c() {

  float8 var1 = (float8) (-1.23,2.0,0.0,123455.134,0.0,2.0,2.0,-1.23);
  float8 var2 = (float8) (1.0,-12345.032,-12345.032,-12345.032,123455.134,2.0,123455.134,1.0);
  int i = printf("float8_e_3590c===%-+.10v8hlE===%-+.10v8hlE===\n",var1,var2);
  return i;
}

int float8_e_4341c() {

  float8 var1 = (float8) (2.0,0.0,123455.134,2.0,0.0,2.0,0.0,-12345.032);
  float8 var2 = (float8) (2.0,-1.23,2.0,123455.134,1.0,-1.23,2.0,1.0);
  int i = printf("float8_e_4341c===% 10v8hle===% 10v8hle===\n",var1,var2);
  return i;
}

int float8_e_4342c() {

  float8 var1 = (float8) (2.0,2.0,-12345.032,123455.134,-1.23,-1.23,0.0,123455.134);
  float8 var2 = (float8) (-12345.032,0.0,123455.134,-12345.032,123455.134,-1.23,0.0,-12345.032);
  int i = printf("float8_e_4342c===% 10.1v8hle===% 10.1v8hle===\n",var1,var2);
  return i;
}

int float8_e_4343c() {

  float8 var1 = (float8) (1.0,123455.134,0.0,123455.134,2.0,0.0,-1.23,1.0);
  float8 var2 = (float8) (-12345.032,1.0,123455.134,123455.134,1.0,1.0,2.0,-12345.032);
  int i = printf("float8_e_4343c===% 10.2v8hle===% 10.2v8hle===\n",var1,var2);
  return i;
}

int float8_e_4344c() {

  float8 var1 = (float8) (123455.134,2.0,-12345.032,1.0,-12345.032,123455.134,123455.134,2.0);
  float8 var2 = (float8) (2.0,-1.23,123455.134,0.0,0.0,0.0,123455.134,-1.23);
  int i = printf("float8_e_4344c===% 10.3v8hle===% 10.3v8hle===\n",var1,var2);
  return i;
}

int float8_e_4345c() {

  float8 var1 = (float8) (-1.23,1.0,0.0,-12345.032,2.0,0.0,123455.134,-12345.032);
  float8 var2 = (float8) (123455.134,-12345.032,-1.23,-12345.032,-12345.032,2.0,123455.134,123455.134);
  int i = printf("float8_e_4345c===% 10.10v8hle===% 10.10v8hle===\n",var1,var2);
  return i;
}

int float8_e_4346c() {

  float8 var1 = (float8) (0.0,1.0,0.0,-12345.032,-12345.032,-12345.032,-12345.032,-12345.032);
  float8 var2 = (float8) (-1.23,0.0,-1.23,123455.134,0.0,123455.134,-12345.032,2.0);
  int i = printf("float8_e_4346c===% 10v8hlE===% 10v8hlE===\n",var1,var2);
  return i;
}

int float8_e_4347c() {

  float8 var1 = (float8) (-12345.032,1.0,0.0,1.0,123455.134,-12345.032,0.0,-1.23);
  float8 var2 = (float8) (2.0,1.0,-1.23,-12345.032,123455.134,2.0,-12345.032,-12345.032);
  int i = printf("float8_e_4347c===% 10.1v8hlE===% 10.1v8hlE===\n",var1,var2);
  return i;
}

int float8_e_4348c() {

  float8 var1 = (float8) (1.0,123455.134,2.0,1.0,-12345.032,-1.23,-12345.032,2.0);
  float8 var2 = (float8) (-12345.032,2.0,0.0,-12345.032,123455.134,0.0,-1.23,123455.134);
  int i = printf("float8_e_4348c===% 10.2v8hlE===% 10.2v8hlE===\n",var1,var2);
  return i;
}

int float8_e_4349c() {

  float8 var1 = (float8) (-1.23,-12345.032,0.0,123455.134,2.0,0.0,123455.134,2.0);
  float8 var2 = (float8) (-12345.032,123455.134,-1.23,-12345.032,-12345.032,-12345.032,1.0,123455.134);
  int i = printf("float8_e_4349c===% 10.3v8hlE===% 10.3v8hlE===\n",var1,var2);
  return i;
}

int float8_e_4350c() {

  float8 var1 = (float8) (1.0,-12345.032,-1.23,1.0,2.0,0.0,0.0,1.0);
  float8 var2 = (float8) (2.0,0.0,2.0,123455.134,0.0,0.0,123455.134,1.0);
  int i = printf("float8_e_4350c===% 10.10v8hlE===% 10.10v8hlE===\n",var1,var2);
  return i;
}

int float8_e_5101c() {

  float8 var1 = (float8) (1.0,0.0,-12345.032,0.0,1.0,123455.134,-12345.032,2.0);
  float8 var2 = (float8) (2.0,1.0,123455.134,123455.134,1.0,0.0,0.0,-12345.032);
  int i = printf("float8_e_5101c===%010v8hle===%010v8hle===\n",var1,var2);
  return i;
}

int float8_e_5102c() {

  float8 var1 = (float8) (1.0,-12345.032,2.0,0.0,-12345.032,1.0,-12345.032,-1.23);
  float8 var2 = (float8) (1.0,-12345.032,1.0,0.0,1.0,0.0,2.0,-12345.032);
  int i = printf("float8_e_5102c===%010.1v8hle===%010.1v8hle===\n",var1,var2);
  return i;
}

int float8_e_5103c() {

  float8 var1 = (float8) (-12345.032,0.0,1.0,0.0,-1.23,123455.134,1.0,2.0);
  float8 var2 = (float8) (-12345.032,-12345.032,-12345.032,2.0,2.0,1.0,-12345.032,123455.134);
  int i = printf("float8_e_5103c===%010.2v8hle===%010.2v8hle===\n",var1,var2);
  return i;
}

int float8_e_5104c() {

  float8 var1 = (float8) (2.0,2.0,-1.23,123455.134,-12345.032,-1.23,0.0,2.0);
  float8 var2 = (float8) (-12345.032,1.0,-1.23,1.0,2.0,-12345.032,0.0,1.0);
  int i = printf("float8_e_5104c===%010.3v8hle===%010.3v8hle===\n",var1,var2);
  return i;
}

int float8_e_5105c() {

  float8 var1 = (float8) (123455.134,0.0,123455.134,2.0,-12345.032,-12345.032,1.0,2.0);
  float8 var2 = (float8) (-1.23,1.0,-12345.032,2.0,2.0,123455.134,2.0,2.0);
  int i = printf("float8_e_5105c===%010.10v8hle===%010.10v8hle===\n",var1,var2);
  return i;
}

int float8_e_5106c() {

  float8 var1 = (float8) (123455.134,2.0,123455.134,0.0,-1.23,0.0,-1.23,2.0);
  float8 var2 = (float8) (123455.134,-12345.032,123455.134,2.0,-12345.032,0.0,1.0,2.0);
  int i = printf("float8_e_5106c===%010v8hlE===%010v8hlE===\n",var1,var2);
  return i;
}

int float8_e_5107c() {

  float8 var1 = (float8) (1.0,123455.134,-1.23,123455.134,1.0,0.0,0.0,-1.23);
  float8 var2 = (float8) (0.0,-12345.032,123455.134,-12345.032,1.0,1.0,0.0,1.0);
  int i = printf("float8_e_5107c===%010.1v8hlE===%010.1v8hlE===\n",var1,var2);
  return i;
}

int float8_e_5108c() {

  float8 var1 = (float8) (-1.23,-1.23,1.0,123455.134,-12345.032,1.0,0.0,2.0);
  float8 var2 = (float8) (123455.134,-1.23,123455.134,2.0,123455.134,0.0,-1.23,123455.134);
  int i = printf("float8_e_5108c===%010.2v8hlE===%010.2v8hlE===\n",var1,var2);
  return i;
}

int float8_e_5109c() {

  float8 var1 = (float8) (-1.23,1.0,0.0,-1.23,123455.134,123455.134,123455.134,123455.134);
  float8 var2 = (float8) (1.0,123455.134,1.0,2.0,2.0,2.0,1.0,123455.134);
  int i = printf("float8_e_5109c===%010.3v8hlE===%010.3v8hlE===\n",var1,var2);
  return i;
}

int float8_e_5110c() {

  float8 var1 = (float8) (123455.134,0.0,2.0,0.0,0.0,-1.23,123455.134,-12345.032);
  float8 var2 = (float8) (2.0,123455.134,-1.23,0.0,2.0,1.0,1.0,0.0);
  int i = printf("float8_e_5110c===%010.10v8hlE===%010.10v8hlE===\n",var1,var2);
  return i;
}

int float8_e_541c() {

  float8 var1 = (float8) (-12345.032,1.0,-1.23,1.0,123455.134,1.0,-1.23,0.0);
  float8 var2 = (float8) (123455.134,123455.134,0.0,1.0,1.0,2.0,123455.134,123455.134);
  int i = printf("float8_e_541c===%v8hle===%v8hle===\n",var1,var2);
  return i;
}

int float8_e_542c() {

  float8 var1 = (float8) (2.0,2.0,123455.134,0.0,2.0,2.0,123455.134,-12345.032);
  float8 var2 = (float8) (0.0,1.0,-12345.032,-12345.032,2.0,-12345.032,-12345.032,-12345.032);
  int i = printf("float8_e_542c===%.1v8hle===%.1v8hle===\n",var1,var2);
  return i;
}

int float8_e_543c() {

  float8 var1 = (float8) (0.0,0.0,1.0,123455.134,-1.23,0.0,-12345.032,2.0);
  float8 var2 = (float8) (2.0,-1.23,123455.134,-12345.032,1.0,-1.23,-12345.032,-12345.032);
  int i = printf("float8_e_543c===%.2v8hle===%.2v8hle===\n",var1,var2);
  return i;
}

int float8_e_544c() {

  float8 var1 = (float8) (1.0,2.0,1.0,1.0,-12345.032,0.0,1.0,2.0);
  float8 var2 = (float8) (1.0,2.0,123455.134,-12345.032,-1.23,0.0,1.0,-12345.032);
  int i = printf("float8_e_544c===%.3v8hle===%.3v8hle===\n",var1,var2);
  return i;
}

int float8_e_545c() {

  float8 var1 = (float8) (-12345.032,-1.23,-12345.032,-1.23,1.0,0.0,-1.23,1.0);
  float8 var2 = (float8) (2.0,-12345.032,123455.134,0.0,-1.23,2.0,-1.23,-1.23);
  int i = printf("float8_e_545c===%.10v8hle===%.10v8hle===\n",var1,var2);
  return i;
}

int float8_e_546c() {

  float8 var1 = (float8) (-1.23,2.0,2.0,123455.134,0.0,0.0,-1.23,-12345.032);
  float8 var2 = (float8) (1.0,-12345.032,0.0,0.0,123455.134,-1.23,-1.23,2.0);
  int i = printf("float8_e_546c===%v8hlE===%v8hlE===\n",var1,var2);
  return i;
}

int float8_e_547c() {

  float8 var1 = (float8) (-1.23,2.0,2.0,123455.134,123455.134,0.0,1.0,123455.134);
  float8 var2 = (float8) (2.0,123455.134,-12345.032,1.0,1.0,-12345.032,123455.134,-12345.032);
  int i = printf("float8_e_547c===%.1v8hlE===%.1v8hlE===\n",var1,var2);
  return i;
}

int float8_e_548c() {

  float8 var1 = (float8) (-1.23,-1.23,123455.134,2.0,2.0,0.0,123455.134,2.0);
  float8 var2 = (float8) (-12345.032,2.0,0.0,1.0,-12345.032,2.0,-1.23,123455.134);
  int i = printf("float8_e_548c===%.2v8hlE===%.2v8hlE===\n",var1,var2);
  return i;
}

int float8_e_549c() {

  float8 var1 = (float8) (-12345.032,1.0,2.0,0.0,0.0,2.0,1.0,1.0);
  float8 var2 = (float8) (2.0,1.0,123455.134,123455.134,123455.134,123455.134,2.0,0.0);
  int i = printf("float8_e_549c===%.3v8hlE===%.3v8hlE===\n",var1,var2);
  return i;
}

int float8_e_550c() {

  float8 var1 = (float8) (0.0,0.0,-12345.032,123455.134,1.0,123455.134,0.0,1.0);
  float8 var2 = (float8) (123455.134,1.0,2.0,123455.134,2.0,-1.23,2.0,-1.23);
  int i = printf("float8_e_550c===%.10v8hlE===%.10v8hlE===\n",var1,var2);
  return i;
}

int float8_e_5861c() {

  float8 var1 = (float8) (2.0,0.0,-1.23,1.0,123455.134,-1.23,-1.23,-12345.032);
  float8 var2 = (float8) (-1.23,-1.23,1.0,-12345.032,123455.134,2.0,2.0,123455.134);
  int i = printf("float8_e_5861c===%- 10v8hle===%- 10v8hle===\n",var1,var2);
  return i;
}

int float8_e_5862c() {

  float8 var1 = (float8) (0.0,1.0,123455.134,1.0,-1.23,0.0,-12345.032,-1.23);
  float8 var2 = (float8) (1.0,123455.134,-12345.032,-12345.032,-12345.032,123455.134,2.0,2.0);
  int i = printf("float8_e_5862c===%- 10.1v8hle===%- 10.1v8hle===\n",var1,var2);
  return i;
}

int float8_e_5863c() {

  float8 var1 = (float8) (0.0,1.0,123455.134,-1.23,1.0,1.0,-1.23,-1.23);
  float8 var2 = (float8) (123455.134,123455.134,-1.23,2.0,123455.134,1.0,-1.23,0.0);
  int i = printf("float8_e_5863c===%- 10.2v8hle===%- 10.2v8hle===\n",var1,var2);
  return i;
}

int float8_e_5864c() {

  float8 var1 = (float8) (0.0,1.0,2.0,2.0,123455.134,-1.23,123455.134,1.0);
  float8 var2 = (float8) (1.0,-12345.032,0.0,0.0,2.0,-12345.032,0.0,0.0);
  int i = printf("float8_e_5864c===%- 10.3v8hle===%- 10.3v8hle===\n",var1,var2);
  return i;
}

int float8_e_5865c() {

  float8 var1 = (float8) (-12345.032,-1.23,1.0,0.0,0.0,-12345.032,-1.23,1.0);
  float8 var2 = (float8) (-1.23,-1.23,0.0,-12345.032,2.0,0.0,-12345.032,123455.134);
  int i = printf("float8_e_5865c===%- 10.10v8hle===%- 10.10v8hle===\n",var1,var2);
  return i;
}

int float8_e_5866c() {

  float8 var1 = (float8) (-1.23,123455.134,0.0,2.0,2.0,1.0,-12345.032,-12345.032);
  float8 var2 = (float8) (0.0,2.0,-1.23,123455.134,-12345.032,-12345.032,0.0,-1.23);
  int i = printf("float8_e_5866c===%- 10v8hlE===%- 10v8hlE===\n",var1,var2);
  return i;
}

int float8_e_5867c() {

  float8 var1 = (float8) (-12345.032,0.0,123455.134,0.0,-1.23,-12345.032,0.0,-1.23);
  float8 var2 = (float8) (2.0,-1.23,2.0,-12345.032,-12345.032,0.0,-12345.032,1.0);
  int i = printf("float8_e_5867c===%- 10.1v8hlE===%- 10.1v8hlE===\n",var1,var2);
  return i;
}

int float8_e_5868c() {

  float8 var1 = (float8) (0.0,123455.134,123455.134,-12345.032,-12345.032,1.0,-1.23,-12345.032);
  float8 var2 = (float8) (0.0,-1.23,123455.134,123455.134,0.0,-1.23,123455.134,-1.23);
  int i = printf("float8_e_5868c===%- 10.2v8hlE===%- 10.2v8hlE===\n",var1,var2);
  return i;
}

int float8_e_5869c() {

  float8 var1 = (float8) (1.0,1.0,123455.134,-1.23,2.0,-12345.032,0.0,1.0);
  float8 var2 = (float8) (-12345.032,0.0,123455.134,123455.134,-1.23,-1.23,123455.134,0.0);
  int i = printf("float8_e_5869c===%- 10.3v8hlE===%- 10.3v8hlE===\n",var1,var2);
  return i;
}

int float8_e_5870c() {

  float8 var1 = (float8) (1.0,-12345.032,0.0,1.0,1.0,123455.134,2.0,0.0);
  float8 var2 = (float8) (0.0,123455.134,-1.23,1.0,1.0,-1.23,1.0,-12345.032);
  int i = printf("float8_e_5870c===%- 10.10v8hlE===%- 10.10v8hlE===\n",var1,var2);
  return i;
}

int float8_e_6621c() {

  float8 var1 = (float8) (2.0,-1.23,-1.23,2.0,1.0,-12345.032,1.0,-12345.032);
  float8 var2 = (float8) (0.0,-1.23,0.0,0.0,-1.23,0.0,123455.134,1.0);
  int i = printf("float8_e_6621c===%+ 10v8hle===%+ 10v8hle===\n",var1,var2);
  return i;
}

int float8_e_6622c() {

  float8 var1 = (float8) (-1.23,1.0,1.0,0.0,123455.134,-1.23,0.0,123455.134);
  float8 var2 = (float8) (1.0,-1.23,123455.134,123455.134,-1.23,-12345.032,-12345.032,0.0);
  int i = printf("float8_e_6622c===%+ 10.1v8hle===%+ 10.1v8hle===\n",var1,var2);
  return i;
}

int float8_e_6623c() {

  float8 var1 = (float8) (1.0,-1.23,-12345.032,2.0,-12345.032,0.0,-1.23,-1.23);
  float8 var2 = (float8) (123455.134,-12345.032,-1.23,123455.134,-1.23,-12345.032,-1.23,-1.23);
  int i = printf("float8_e_6623c===%+ 10.2v8hle===%+ 10.2v8hle===\n",var1,var2);
  return i;
}

int float8_e_6624c() {

  float8 var1 = (float8) (2.0,0.0,2.0,-1.23,123455.134,-1.23,-1.23,1.0);
  float8 var2 = (float8) (1.0,1.0,-12345.032,-1.23,2.0,-12345.032,2.0,123455.134);
  int i = printf("float8_e_6624c===%+ 10.3v8hle===%+ 10.3v8hle===\n",var1,var2);
  return i;
}

int float8_e_6625c() {

  float8 var1 = (float8) (0.0,0.0,2.0,-1.23,1.0,2.0,123455.134,123455.134);
  float8 var2 = (float8) (0.0,2.0,2.0,2.0,0.0,123455.134,0.0,0.0);
  int i = printf("float8_e_6625c===%+ 10.10v8hle===%+ 10.10v8hle===\n",var1,var2);
  return i;
}

int float8_e_6626c() {

  float8 var1 = (float8) (-12345.032,1.0,-12345.032,123455.134,2.0,0.0,2.0,123455.134);
  float8 var2 = (float8) (2.0,0.0,-12345.032,1.0,-12345.032,0.0,1.0,-12345.032);
  int i = printf("float8_e_6626c===%+ 10v8hlE===%+ 10v8hlE===\n",var1,var2);
  return i;
}

int float8_e_6627c() {

  float8 var1 = (float8) (0.0,123455.134,2.0,1.0,1.0,-1.23,1.0,2.0);
  float8 var2 = (float8) (-12345.032,0.0,-1.23,0.0,1.0,123455.134,1.0,-12345.032);
  int i = printf("float8_e_6627c===%+ 10.1v8hlE===%+ 10.1v8hlE===\n",var1,var2);
  return i;
}

int float8_e_6628c() {

  float8 var1 = (float8) (-1.23,-1.23,1.0,2.0,-12345.032,-12345.032,1.0,123455.134);
  float8 var2 = (float8) (-1.23,123455.134,-12345.032,2.0,1.0,0.0,1.0,1.0);
  int i = printf("float8_e_6628c===%+ 10.2v8hlE===%+ 10.2v8hlE===\n",var1,var2);
  return i;
}

int float8_e_6629c() {

  float8 var1 = (float8) (-12345.032,1.0,123455.134,123455.134,-12345.032,0.0,0.0,0.0);
  float8 var2 = (float8) (1.0,123455.134,2.0,1.0,-12345.032,-1.23,1.0,-12345.032);
  int i = printf("float8_e_6629c===%+ 10.3v8hlE===%+ 10.3v8hlE===\n",var1,var2);
  return i;
}

int float8_e_6630c() {

  float8 var1 = (float8) (-12345.032,2.0,-12345.032,123455.134,123455.134,-12345.032,-12345.032,1.0);
  float8 var2 = (float8) (-12345.032,1.0,0.0,0.0,-12345.032,-12345.032,-1.23,1.0);
  int i = printf("float8_e_6630c===%+ 10.10v8hlE===%+ 10.10v8hlE===\n",var1,var2);
  return i;
}

int float8_e_7381c() {

  float8 var1 = (float8) (0.0,1.0,123455.134,-1.23,-12345.032,-1.23,1.0,-12345.032);
  float8 var2 = (float8) (0.0,-1.23,-12345.032,2.0,1.0,2.0,-1.23,-12345.032);
  int i = printf("float8_e_7381c===%+010v8hle===%+010v8hle===\n",var1,var2);
  return i;
}

int float8_e_7382c() {

  float8 var1 = (float8) (-12345.032,2.0,-12345.032,-1.23,-12345.032,1.0,-1.23,0.0);
  float8 var2 = (float8) (2.0,-1.23,1.0,-12345.032,-12345.032,-12345.032,123455.134,1.0);
  int i = printf("float8_e_7382c===%+010.1v8hle===%+010.1v8hle===\n",var1,var2);
  return i;
}

int float8_e_7383c() {

  float8 var1 = (float8) (1.0,0.0,1.0,-1.23,0.0,123455.134,2.0,1.0);
  float8 var2 = (float8) (1.0,1.0,123455.134,123455.134,2.0,2.0,-12345.032,-1.23);
  int i = printf("float8_e_7383c===%+010.2v8hle===%+010.2v8hle===\n",var1,var2);
  return i;
}

int float8_e_7384c() {

  float8 var1 = (float8) (-1.23,2.0,2.0,1.0,1.0,-1.23,0.0,1.0);
  float8 var2 = (float8) (-1.23,2.0,-12345.032,2.0,1.0,123455.134,1.0,1.0);
  int i = printf("float8_e_7384c===%+010.3v8hle===%+010.3v8hle===\n",var1,var2);
  return i;
}

int float8_e_7385c() {

  float8 var1 = (float8) (2.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0);
  float8 var2 = (float8) (2.0,0.0,-12345.032,0.0,123455.134,-1.23,1.0,0.0);
  int i = printf("float8_e_7385c===%+010.10v8hle===%+010.10v8hle===\n",var1,var2);
  return i;
}

int float8_e_7386c() {

  float8 var1 = (float8) (-12345.032,0.0,-1.23,2.0,-12345.032,123455.134,1.0,-1.23);
  float8 var2 = (float8) (1.0,-12345.032,2.0,-12345.032,0.0,1.0,-1.23,1.0);
  int i = printf("float8_e_7386c===%+010v8hlE===%+010v8hlE===\n",var1,var2);
  return i;
}

int float8_e_7387c() {

  float8 var1 = (float8) (1.0,2.0,0.0,-1.23,2.0,123455.134,2.0,0.0);
  float8 var2 = (float8) (123455.134,2.0,123455.134,-12345.032,2.0,-12345.032,-12345.032,123455.134);
  int i = printf("float8_e_7387c===%+010.1v8hlE===%+010.1v8hlE===\n",var1,var2);
  return i;
}

int float8_e_7388c() {

  float8 var1 = (float8) (1.0,-1.23,2.0,2.0,123455.134,-1.23,2.0,-1.23);
  float8 var2 = (float8) (2.0,-12345.032,1.0,-1.23,0.0,1.0,-12345.032,-12345.032);
  int i = printf("float8_e_7388c===%+010.2v8hlE===%+010.2v8hlE===\n",var1,var2);
  return i;
}

int float8_e_7389c() {

  float8 var1 = (float8) (123455.134,-1.23,123455.134,123455.134,2.0,1.0,2.0,-1.23);
  float8 var2 = (float8) (2.0,-12345.032,0.0,-12345.032,123455.134,-1.23,0.0,-12345.032);
  int i = printf("float8_e_7389c===%+010.3v8hlE===%+010.3v8hlE===\n",var1,var2);
  return i;
}

int float8_e_7390c() {

  float8 var1 = (float8) (0.0,123455.134,1.0,123455.134,0.0,1.0,1.0,1.0);
  float8 var2 = (float8) (-1.23,2.0,-1.23,1.0,0.0,-1.23,-1.23,-12345.032);
  int i = printf("float8_e_7390c===%+010.10v8hlE===%+010.10v8hlE===\n",var1,var2);
  return i;
}

int float8_f_1311c() {

  float8 var1 = (float8) (-12345.032,123455.134,1.0,123455.134,-1.23,123455.134,123455.134,-12345.032);
  float8 var2 = (float8) (-1.23,1.0,123455.134,2.0,-1.23,123455.134,0.0,1.0);
  int i = printf("float8_f_1311c===%-v8hlf===%-v8hlf===\n",var1,var2);
  return i;
}

int float8_f_1312c() {

  float8 var1 = (float8) (2.0,0.0,123455.134,-1.23,123455.134,2.0,-1.23,-12345.032);
  float8 var2 = (float8) (2.0,0.0,0.0,2.0,2.0,-12345.032,2.0,0.0);
  int i = printf("float8_f_1312c===%-.1v8hlf===%-.1v8hlf===\n",var1,var2);
  return i;
}

int float8_f_1313c() {

  float8 var1 = (float8) (-12345.032,0.0,-12345.032,-12345.032,123455.134,123455.134,2.0,2.0);
  float8 var2 = (float8) (0.0,123455.134,-1.23,123455.134,2.0,2.0,-12345.032,-1.23);
  int i = printf("float8_f_1313c===%-.2v8hlf===%-.2v8hlf===\n",var1,var2);
  return i;
}

int float8_f_1314c() {

  float8 var1 = (float8) (1.0,2.0,0.0,-12345.032,2.0,123455.134,-1.23,0.0);
  float8 var2 = (float8) (1.0,-1.23,-12345.032,0.0,-1.23,1.0,2.0,-12345.032);
  int i = printf("float8_f_1314c===%-.3v8hlf===%-.3v8hlf===\n",var1,var2);
  return i;
}

int float8_f_1315c() {

  float8 var1 = (float8) (123455.134,0.0,123455.134,-12345.032,1.0,123455.134,1.0,-12345.032);
  float8 var2 = (float8) (2.0,1.0,2.0,123455.134,-12345.032,1.0,-12345.032,-1.23);
  int i = printf("float8_f_1315c===%-.10v8hlf===%-.10v8hlf===\n",var1,var2);
  return i;
}

int float8_f_1316c() {

  float8 var1 = (float8) (1.0,0.0,0.0,-12345.032,-1.23,0.0,123455.134,0.0);
  float8 var2 = (float8) (-12345.032,0.0,-1.23,0.0,2.0,123455.134,123455.134,-1.23);
  int i = printf("float8_f_1316c===%-v8hlF===%-v8hlF===\n",var1,var2);
  return i;
}

int float8_f_1317c() {

  float8 var1 = (float8) (1.0,123455.134,-1.23,123455.134,-12345.032,-1.23,123455.134,-12345.032);
  float8 var2 = (float8) (0.0,-12345.032,1.0,0.0,1.0,-12345.032,1.0,1.0);
  int i = printf("float8_f_1317c===%-.1v8hlF===%-.1v8hlF===\n",var1,var2);
  return i;
}

int float8_f_1318c() {

  float8 var1 = (float8) (-1.23,123455.134,123455.134,-12345.032,-1.23,-1.23,-12345.032,0.0);
  float8 var2 = (float8) (123455.134,-1.23,-1.23,2.0,1.0,2.0,-12345.032,0.0);
  int i = printf("float8_f_1318c===%-.2v8hlF===%-.2v8hlF===\n",var1,var2);
  return i;
}

int float8_f_1319c() {

  float8 var1 = (float8) (2.0,0.0,0.0,123455.134,-1.23,123455.134,2.0,1.0);
  float8 var2 = (float8) (-12345.032,123455.134,-1.23,123455.134,1.0,2.0,-1.23,1.0);
  int i = printf("float8_f_1319c===%-.3v8hlF===%-.3v8hlF===\n",var1,var2);
  return i;
}

int float8_f_1320c() {

  float8 var1 = (float8) (123455.134,0.0,-12345.032,2.0,-12345.032,2.0,0.0,-12345.032);
  float8 var2 = (float8) (0.0,0.0,-12345.032,2.0,123455.134,0.0,-12345.032,123455.134);
  int i = printf("float8_f_1320c===%-.10v8hlF===%-.10v8hlF===\n",var1,var2);
  return i;
}

int float8_f_2071c() {

  float8 var1 = (float8) (1.0,-1.23,-1.23,-1.23,0.0,2.0,1.0,0.0);
  float8 var2 = (float8) (123455.134,1.0,0.0,1.0,0.0,2.0,0.0,2.0);
  int i = printf("float8_f_2071c===%+v8hlf===%+v8hlf===\n",var1,var2);
  return i;
}

int float8_f_2072c() {

  float8 var1 = (float8) (0.0,-1.23,-1.23,-1.23,0.0,-12345.032,0.0,-1.23);
  float8 var2 = (float8) (2.0,1.0,-1.23,123455.134,2.0,123455.134,2.0,0.0);
  int i = printf("float8_f_2072c===%+.1v8hlf===%+.1v8hlf===\n",var1,var2);
  return i;
}

int float8_f_2073c() {

  float8 var1 = (float8) (123455.134,-12345.032,123455.134,2.0,1.0,1.0,123455.134,-1.23);
  float8 var2 = (float8) (1.0,0.0,-1.23,1.0,2.0,0.0,123455.134,0.0);
  int i = printf("float8_f_2073c===%+.2v8hlf===%+.2v8hlf===\n",var1,var2);
  return i;
}

int float8_f_2074c() {

  float8 var1 = (float8) (-12345.032,2.0,1.0,-1.23,-12345.032,-1.23,123455.134,0.0);
  float8 var2 = (float8) (123455.134,1.0,2.0,-12345.032,123455.134,1.0,0.0,0.0);
  int i = printf("float8_f_2074c===%+.3v8hlf===%+.3v8hlf===\n",var1,var2);
  return i;
}

int float8_f_2075c() {

  float8 var1 = (float8) (123455.134,-1.23,123455.134,2.0,-12345.032,0.0,0.0,1.0);
  float8 var2 = (float8) (-1.23,123455.134,2.0,1.0,123455.134,2.0,123455.134,0.0);
  int i = printf("float8_f_2075c===%+.10v8hlf===%+.10v8hlf===\n",var1,var2);
  return i;
}

int float8_f_2076c() {

  float8 var1 = (float8) (-12345.032,123455.134,-1.23,123455.134,0.0,1.0,123455.134,-1.23);
  float8 var2 = (float8) (2.0,123455.134,123455.134,-1.23,-12345.032,-1.23,-1.23,2.0);
  int i = printf("float8_f_2076c===%+v8hlF===%+v8hlF===\n",var1,var2);
  return i;
}

int float8_f_2077c() {

  float8 var1 = (float8) (-12345.032,0.0,2.0,-12345.032,-1.23,2.0,123455.134,123455.134);
  float8 var2 = (float8) (1.0,1.0,2.0,2.0,-12345.032,-1.23,0.0,2.0);
  int i = printf("float8_f_2077c===%+.1v8hlF===%+.1v8hlF===\n",var1,var2);
  return i;
}

int float8_f_2078c() {

  float8 var1 = (float8) (123455.134,123455.134,123455.134,-12345.032,-1.23,123455.134,1.0,123455.134);
  float8 var2 = (float8) (1.0,0.0,-12345.032,123455.134,123455.134,1.0,0.0,123455.134);
  int i = printf("float8_f_2078c===%+.2v8hlF===%+.2v8hlF===\n",var1,var2);
  return i;
}

int float8_f_2079c() {

  float8 var1 = (float8) (123455.134,-1.23,-12345.032,-12345.032,1.0,2.0,-12345.032,1.0);
  float8 var2 = (float8) (1.0,-12345.032,-1.23,2.0,-1.23,1.0,123455.134,-12345.032);
  int i = printf("float8_f_2079c===%+.3v8hlF===%+.3v8hlF===\n",var1,var2);
  return i;
}

int float8_f_2080c() {

  float8 var1 = (float8) (1.0,2.0,-12345.032,0.0,1.0,123455.134,0.0,-1.23);
  float8 var2 = (float8) (0.0,2.0,1.0,0.0,-1.23,1.0,1.0,0.0);
  int i = printf("float8_f_2080c===%+.10v8hlF===%+.10v8hlF===\n",var1,var2);
  return i;
}

int float8_f_2831c() {

  float8 var1 = (float8) (1.0,0.0,-1.23,123455.134,123455.134,-12345.032,2.0,2.0);
  float8 var2 = (float8) (-12345.032,-1.23,1.0,-1.23,-1.23,1.0,2.0,123455.134);
  int i = printf("float8_f_2831c===%#v8hlf===%#v8hlf===\n",var1,var2);
  return i;
}

int float8_f_2832c() {

  float8 var1 = (float8) (-1.23,0.0,0.0,123455.134,-12345.032,-12345.032,1.0,2.0);
  float8 var2 = (float8) (0.0,0.0,0.0,-1.23,123455.134,123455.134,-12345.032,0.0);
  int i = printf("float8_f_2832c===%#.1v8hlf===%#.1v8hlf===\n",var1,var2);
  return i;
}

int float8_f_2833c() {

  float8 var1 = (float8) (-1.23,-12345.032,-12345.032,0.0,-12345.032,123455.134,-1.23,0.0);
  float8 var2 = (float8) (0.0,2.0,-1.23,1.0,123455.134,-1.23,1.0,123455.134);
  int i = printf("float8_f_2833c===%#.2v8hlf===%#.2v8hlf===\n",var1,var2);
  return i;
}

int float8_f_2834c() {

  float8 var1 = (float8) (-12345.032,123455.134,1.0,0.0,1.0,0.0,2.0,-12345.032);
  float8 var2 = (float8) (-12345.032,123455.134,0.0,-1.23,123455.134,-12345.032,-12345.032,-1.23);
  int i = printf("float8_f_2834c===%#.3v8hlf===%#.3v8hlf===\n",var1,var2);
  return i;
}

int float8_f_2835c() {

  float8 var1 = (float8) (2.0,2.0,0.0,0.0,1.0,-12345.032,123455.134,0.0);
  float8 var2 = (float8) (1.0,-12345.032,123455.134,2.0,-1.23,123455.134,1.0,0.0);
  int i = printf("float8_f_2835c===%#.10v8hlf===%#.10v8hlf===\n",var1,var2);
  return i;
}

int float8_f_2836c() {

  float8 var1 = (float8) (1.0,2.0,123455.134,1.0,-1.23,-1.23,1.0,-1.23);
  float8 var2 = (float8) (0.0,123455.134,0.0,123455.134,-1.23,-1.23,123455.134,-12345.032);
  int i = printf("float8_f_2836c===%#v8hlF===%#v8hlF===\n",var1,var2);
  return i;
}

int float8_f_2837c() {

  float8 var1 = (float8) (2.0,-12345.032,2.0,0.0,-12345.032,2.0,2.0,123455.134);
  float8 var2 = (float8) (-12345.032,2.0,0.0,-12345.032,-1.23,-1.23,123455.134,1.0);
  int i = printf("float8_f_2837c===%#.1v8hlF===%#.1v8hlF===\n",var1,var2);
  return i;
}

int float8_f_2838c() {

  float8 var1 = (float8) (1.0,-1.23,2.0,-1.23,-12345.032,123455.134,-12345.032,-12345.032);
  float8 var2 = (float8) (-12345.032,2.0,-12345.032,0.0,2.0,-12345.032,-12345.032,-1.23);
  int i = printf("float8_f_2838c===%#.2v8hlF===%#.2v8hlF===\n",var1,var2);
  return i;
}

int float8_f_2839c() {

  float8 var1 = (float8) (1.0,0.0,0.0,123455.134,-12345.032,0.0,123455.134,-1.23);
  float8 var2 = (float8) (2.0,0.0,-12345.032,-1.23,-1.23,-1.23,-12345.032,-12345.032);
  int i = printf("float8_f_2839c===%#.3v8hlF===%#.3v8hlF===\n",var1,var2);
  return i;
}

int float8_f_2840c() {

  float8 var1 = (float8) (-12345.032,-12345.032,2.0,1.0,1.0,123455.134,0.0,-12345.032);
  float8 var2 = (float8) (123455.134,123455.134,2.0,0.0,0.0,0.0,-1.23,0.0);
  int i = printf("float8_f_2840c===%#.10v8hlF===%#.10v8hlF===\n",var1,var2);
  return i;
}

int float8_f_3591c() {

  float8 var1 = (float8) (-1.23,-1.23,123455.134,0.0,-1.23,2.0,123455.134,123455.134);
  float8 var2 = (float8) (1.0,-12345.032,123455.134,2.0,-1.23,0.0,0.0,1.0);
  int i = printf("float8_f_3591c===%-+v8hlf===%-+v8hlf===\n",var1,var2);
  return i;
}

int float8_f_3592c() {

  float8 var1 = (float8) (123455.134,123455.134,2.0,-1.23,2.0,2.0,1.0,0.0);
  float8 var2 = (float8) (1.0,1.0,-12345.032,1.0,-1.23,2.0,-12345.032,123455.134);
  int i = printf("float8_f_3592c===%-+.1v8hlf===%-+.1v8hlf===\n",var1,var2);
  return i;
}

int float8_f_3593c() {

  float8 var1 = (float8) (0.0,123455.134,-1.23,-12345.032,-1.23,2.0,1.0,0.0);
  float8 var2 = (float8) (-12345.032,1.0,1.0,2.0,-12345.032,1.0,-12345.032,2.0);
  int i = printf("float8_f_3593c===%-+.2v8hlf===%-+.2v8hlf===\n",var1,var2);
  return i;
}

int float8_f_3594c() {

  float8 var1 = (float8) (1.0,-1.23,2.0,0.0,123455.134,2.0,-12345.032,0.0);
  float8 var2 = (float8) (1.0,-1.23,-1.23,1.0,1.0,-1.23,1.0,1.0);
  int i = printf("float8_f_3594c===%-+.3v8hlf===%-+.3v8hlf===\n",var1,var2);
  return i;
}

int float8_f_3595c() {

  float8 var1 = (float8) (-1.23,1.0,1.0,123455.134,-1.23,-1.23,-1.23,0.0);
  float8 var2 = (float8) (1.0,2.0,0.0,-1.23,0.0,1.0,1.0,0.0);
  int i = printf("float8_f_3595c===%-+.10v8hlf===%-+.10v8hlf===\n",var1,var2);
  return i;
}

int float8_f_3596c() {

  float8 var1 = (float8) (-1.23,-1.23,0.0,2.0,123455.134,0.0,123455.134,2.0);
  float8 var2 = (float8) (0.0,1.0,0.0,0.0,123455.134,1.0,123455.134,-12345.032);
  int i = printf("float8_f_3596c===%-+v8hlF===%-+v8hlF===\n",var1,var2);
  return i;
}

int float8_f_3597c() {

  float8 var1 = (float8) (2.0,-12345.032,123455.134,123455.134,123455.134,-12345.032,2.0,123455.134);
  float8 var2 = (float8) (-12345.032,-1.23,-1.23,2.0,-1.23,-12345.032,0.0,0.0);
  int i = printf("float8_f_3597c===%-+.1v8hlF===%-+.1v8hlF===\n",var1,var2);
  return i;
}

int float8_f_3598c() {

  float8 var1 = (float8) (0.0,-1.23,-12345.032,1.0,-1.23,-1.23,2.0,123455.134);
  float8 var2 = (float8) (-1.23,-12345.032,2.0,1.0,0.0,2.0,123455.134,2.0);
  int i = printf("float8_f_3598c===%-+.2v8hlF===%-+.2v8hlF===\n",var1,var2);
  return i;
}

int float8_f_3599c() {

  float8 var1 = (float8) (-12345.032,-12345.032,-1.23,1.0,2.0,-1.23,-12345.032,2.0);
  float8 var2 = (float8) (0.0,123455.134,2.0,-12345.032,1.0,-12345.032,123455.134,-12345.032);
  int i = printf("float8_f_3599c===%-+.3v8hlF===%-+.3v8hlF===\n",var1,var2);
  return i;
}

int float8_f_3600c() {

  float8 var1 = (float8) (-12345.032,1.0,2.0,123455.134,1.0,2.0,1.0,2.0);
  float8 var2 = (float8) (-1.23,0.0,2.0,1.0,-1.23,-12345.032,123455.134,-1.23);
  int i = printf("float8_f_3600c===%-+.10v8hlF===%-+.10v8hlF===\n",var1,var2);
  return i;
}

int float8_f_4351c() {

  float8 var1 = (float8) (-12345.032,123455.134,-12345.032,1.0,-12345.032,123455.134,1.0,-12345.032);
  float8 var2 = (float8) (1.0,2.0,1.0,-12345.032,-1.23,2.0,123455.134,123455.134);
  int i = printf("float8_f_4351c===% 10v8hlf===% 10v8hlf===\n",var1,var2);
  return i;
}

int float8_f_4352c() {

  float8 var1 = (float8) (-1.23,-1.23,123455.134,-12345.032,2.0,123455.134,-1.23,2.0);
  float8 var2 = (float8) (-12345.032,2.0,123455.134,2.0,-12345.032,123455.134,-12345.032,1.0);
  int i = printf("float8_f_4352c===% 10.1v8hlf===% 10.1v8hlf===\n",var1,var2);
  return i;
}

int float8_f_4353c() {

  float8 var1 = (float8) (2.0,123455.134,-12345.032,0.0,0.0,123455.134,1.0,2.0);
  float8 var2 = (float8) (0.0,-12345.032,0.0,2.0,1.0,0.0,123455.134,0.0);
  int i = printf("float8_f_4353c===% 10.2v8hlf===% 10.2v8hlf===\n",var1,var2);
  return i;
}

int float8_f_4354c() {

  float8 var1 = (float8) (123455.134,0.0,1.0,-1.23,1.0,-1.23,0.0,123455.134);
  float8 var2 = (float8) (2.0,2.0,1.0,1.0,1.0,1.0,-12345.032,0.0);
  int i = printf("float8_f_4354c===% 10.3v8hlf===% 10.3v8hlf===\n",var1,var2);
  return i;
}

int float8_f_4355c() {

  float8 var1 = (float8) (0.0,123455.134,-12345.032,0.0,-12345.032,-1.23,2.0,1.0);
  float8 var2 = (float8) (0.0,-1.23,123455.134,-12345.032,-1.23,-1.23,-1.23,123455.134);
  int i = printf("float8_f_4355c===% 10.10v8hlf===% 10.10v8hlf===\n",var1,var2);
  return i;
}

int float8_f_4356c() {

  float8 var1 = (float8) (0.0,2.0,2.0,-12345.032,1.0,0.0,-1.23,2.0);
  float8 var2 = (float8) (-12345.032,2.0,2.0,1.0,0.0,2.0,0.0,0.0);
  int i = printf("float8_f_4356c===% 10v8hlF===% 10v8hlF===\n",var1,var2);
  return i;
}

int float8_f_4357c() {

  float8 var1 = (float8) (1.0,-1.23,0.0,-1.23,0.0,0.0,1.0,0.0);
  float8 var2 = (float8) (-1.23,123455.134,-12345.032,123455.134,-12345.032,123455.134,2.0,1.0);
  int i = printf("float8_f_4357c===% 10.1v8hlF===% 10.1v8hlF===\n",var1,var2);
  return i;
}

int float8_f_4358c() {

  float8 var1 = (float8) (-1.23,-12345.032,123455.134,2.0,0.0,123455.134,-1.23,123455.134);
  float8 var2 = (float8) (2.0,2.0,0.0,123455.134,1.0,1.0,-1.23,1.0);
  int i = printf("float8_f_4358c===% 10.2v8hlF===% 10.2v8hlF===\n",var1,var2);
  return i;
}

int float8_f_4359c() {

  float8 var1 = (float8) (123455.134,-1.23,123455.134,2.0,-1.23,-1.23,0.0,123455.134);
  float8 var2 = (float8) (-12345.032,-1.23,-12345.032,0.0,-12345.032,1.0,-1.23,123455.134);
  int i = printf("float8_f_4359c===% 10.3v8hlF===% 10.3v8hlF===\n",var1,var2);
  return i;
}

int float8_f_4360c() {

  float8 var1 = (float8) (123455.134,123455.134,123455.134,2.0,123455.134,2.0,-1.23,1.0);
  float8 var2 = (float8) (-1.23,2.0,-12345.032,0.0,-12345.032,123455.134,0.0,-12345.032);
  int i = printf("float8_f_4360c===% 10.10v8hlF===% 10.10v8hlF===\n",var1,var2);
  return i;
}

int float8_f_5111c() {

  float8 var1 = (float8) (0.0,-1.23,123455.134,1.0,2.0,2.0,-12345.032,-12345.032);
  float8 var2 = (float8) (-12345.032,1.0,1.0,0.0,0.0,2.0,1.0,0.0);
  int i = printf("float8_f_5111c===%010v8hlf===%010v8hlf===\n",var1,var2);
  return i;
}

int float8_f_5112c() {

  float8 var1 = (float8) (123455.134,0.0,0.0,123455.134,2.0,123455.134,-1.23,1.0);
  float8 var2 = (float8) (1.0,2.0,1.0,2.0,-1.23,-12345.032,0.0,1.0);
  int i = printf("float8_f_5112c===%010.1v8hlf===%010.1v8hlf===\n",var1,var2);
  return i;
}

int float8_f_5113c() {

  float8 var1 = (float8) (0.0,1.0,123455.134,-1.23,0.0,-12345.032,-12345.032,-12345.032);
  float8 var2 = (float8) (1.0,-12345.032,2.0,-1.23,0.0,-1.23,1.0,-1.23);
  int i = printf("float8_f_5113c===%010.2v8hlf===%010.2v8hlf===\n",var1,var2);
  return i;
}

int float8_f_5114c() {

  float8 var1 = (float8) (1.0,1.0,123455.134,1.0,2.0,2.0,0.0,-1.23);
  float8 var2 = (float8) (0.0,2.0,-12345.032,1.0,0.0,-12345.032,2.0,123455.134);
  int i = printf("float8_f_5114c===%010.3v8hlf===%010.3v8hlf===\n",var1,var2);
  return i;
}

int float8_f_5115c() {

  float8 var1 = (float8) (1.0,123455.134,1.0,2.0,0.0,0.0,1.0,-12345.032);
  float8 var2 = (float8) (2.0,0.0,-1.23,123455.134,0.0,1.0,-1.23,2.0);
  int i = printf("float8_f_5115c===%010.10v8hlf===%010.10v8hlf===\n",var1,var2);
  return i;
}

int float8_f_5116c() {

  float8 var1 = (float8) (0.0,-12345.032,123455.134,123455.134,0.0,-12345.032,2.0,1.0);
  float8 var2 = (float8) (123455.134,2.0,1.0,2.0,123455.134,1.0,1.0,1.0);
  int i = printf("float8_f_5116c===%010v8hlF===%010v8hlF===\n",var1,var2);
  return i;
}

int float8_f_5117c() {

  float8 var1 = (float8) (123455.134,123455.134,2.0,-12345.032,-1.23,-12345.032,-12345.032,-1.23);
  float8 var2 = (float8) (-12345.032,-1.23,2.0,-1.23,123455.134,0.0,2.0,123455.134);
  int i = printf("float8_f_5117c===%010.1v8hlF===%010.1v8hlF===\n",var1,var2);
  return i;
}

int float8_f_5118c() {

  float8 var1 = (float8) (1.0,-1.23,2.0,-12345.032,1.0,-1.23,2.0,2.0);
  float8 var2 = (float8) (1.0,-12345.032,1.0,-1.23,1.0,0.0,0.0,1.0);
  int i = printf("float8_f_5118c===%010.2v8hlF===%010.2v8hlF===\n",var1,var2);
  return i;
}

int float8_f_5119c() {

  float8 var1 = (float8) (-1.23,-12345.032,123455.134,123455.134,123455.134,-1.23,123455.134,2.0);
  float8 var2 = (float8) (-1.23,123455.134,-12345.032,1.0,-12345.032,-12345.032,1.0,123455.134);
  int i = printf("float8_f_5119c===%010.3v8hlF===%010.3v8hlF===\n",var1,var2);
  return i;
}

int float8_f_5120c() {

  float8 var1 = (float8) (-1.23,1.0,-1.23,2.0,0.0,-12345.032,-1.23,-1.23);
  float8 var2 = (float8) (2.0,-1.23,-1.23,2.0,-12345.032,0.0,-12345.032,2.0);
  int i = printf("float8_f_5120c===%010.10v8hlF===%010.10v8hlF===\n",var1,var2);
  return i;
}

int float8_f_551c() {

  float8 var1 = (float8) (-12345.032,-12345.032,-12345.032,2.0,2.0,1.0,0.0,123455.134);
  float8 var2 = (float8) (-1.23,0.0,123455.134,0.0,0.0,-1.23,1.0,2.0);
  int i = printf("float8_f_551c===%v8hlf===%v8hlf===\n",var1,var2);
  return i;
}

int float8_f_552c() {

  float8 var1 = (float8) (0.0,123455.134,2.0,-1.23,123455.134,2.0,123455.134,-12345.032);
  float8 var2 = (float8) (-12345.032,2.0,-1.23,123455.134,1.0,0.0,123455.134,2.0);
  int i = printf("float8_f_552c===%.1v8hlf===%.1v8hlf===\n",var1,var2);
  return i;
}

int float8_f_553c() {

  float8 var1 = (float8) (-12345.032,-1.23,-12345.032,0.0,123455.134,1.0,0.0,-12345.032);
  float8 var2 = (float8) (1.0,-1.23,1.0,-12345.032,123455.134,2.0,-1.23,123455.134);
  int i = printf("float8_f_553c===%.2v8hlf===%.2v8hlf===\n",var1,var2);
  return i;
}

int float8_f_554c() {

  float8 var1 = (float8) (-12345.032,2.0,-12345.032,-12345.032,0.0,1.0,-1.23,-1.23);
  float8 var2 = (float8) (-1.23,1.0,-1.23,2.0,0.0,-1.23,0.0,-12345.032);
  int i = printf("float8_f_554c===%.3v8hlf===%.3v8hlf===\n",var1,var2);
  return i;
}

int float8_f_555c() {

  float8 var1 = (float8) (0.0,-12345.032,-12345.032,2.0,-12345.032,-1.23,-1.23,123455.134);
  float8 var2 = (float8) (2.0,0.0,2.0,0.0,2.0,-1.23,123455.134,-12345.032);
  int i = printf("float8_f_555c===%.10v8hlf===%.10v8hlf===\n",var1,var2);
  return i;
}

int float8_f_556c() {

  float8 var1 = (float8) (0.0,-12345.032,-1.23,2.0,123455.134,-1.23,-1.23,0.0);
  float8 var2 = (float8) (123455.134,0.0,-12345.032,123455.134,2.0,-12345.032,-1.23,-12345.032);
  int i = printf("float8_f_556c===%v8hlF===%v8hlF===\n",var1,var2);
  return i;
}

int float8_f_557c() {

  float8 var1 = (float8) (123455.134,123455.134,1.0,-1.23,1.0,0.0,2.0,2.0);
  float8 var2 = (float8) (-1.23,0.0,-1.23,-1.23,123455.134,0.0,0.0,-12345.032);
  int i = printf("float8_f_557c===%.1v8hlF===%.1v8hlF===\n",var1,var2);
  return i;
}

int float8_f_558c() {

  float8 var1 = (float8) (-1.23,123455.134,0.0,0.0,-1.23,2.0,0.0,0.0);
  float8 var2 = (float8) (123455.134,0.0,-12345.032,123455.134,123455.134,0.0,123455.134,123455.134);
  int i = printf("float8_f_558c===%.2v8hlF===%.2v8hlF===\n",var1,var2);
  return i;
}

int float8_f_559c() {

  float8 var1 = (float8) (2.0,0.0,1.0,-12345.032,2.0,0.0,1.0,0.0);
  float8 var2 = (float8) (1.0,0.0,0.0,0.0,0.0,-1.23,1.0,1.0);
  int i = printf("float8_f_559c===%.3v8hlF===%.3v8hlF===\n",var1,var2);
  return i;
}

int float8_f_560c() {

  float8 var1 = (float8) (1.0,1.0,0.0,1.0,123455.134,1.0,1.0,1.0);
  float8 var2 = (float8) (0.0,-1.23,123455.134,123455.134,1.0,-1.23,123455.134,0.0);
  int i = printf("float8_f_560c===%.10v8hlF===%.10v8hlF===\n",var1,var2);
  return i;
}

int float8_f_5871c() {

  float8 var1 = (float8) (1.0,2.0,0.0,-1.23,0.0,-12345.032,-1.23,-1.23);
  float8 var2 = (float8) (-1.23,123455.134,123455.134,123455.134,0.0,-1.23,0.0,0.0);
  int i = printf("float8_f_5871c===%- 10v8hlf===%- 10v8hlf===\n",var1,var2);
  return i;
}

int float8_f_5872c() {

  float8 var1 = (float8) (-1.23,123455.134,1.0,123455.134,123455.134,2.0,2.0,0.0);
  float8 var2 = (float8) (123455.134,0.0,2.0,0.0,-12345.032,-12345.032,0.0,2.0);
  int i = printf("float8_f_5872c===%- 10.1v8hlf===%- 10.1v8hlf===\n",var1,var2);
  return i;
}

int float8_f_5873c() {

  float8 var1 = (float8) (1.0,0.0,0.0,-1.23,2.0,1.0,2.0,-12345.032);
  float8 var2 = (float8) (-1.23,-12345.032,2.0,-1.23,0.0,-1.23,2.0,2.0);
  int i = printf("float8_f_5873c===%- 10.2v8hlf===%- 10.2v8hlf===\n",var1,var2);
  return i;
}

int float8_f_5874c() {

  float8 var1 = (float8) (1.0,-12345.032,2.0,1.0,1.0,2.0,-1.23,0.0);
  float8 var2 = (float8) (1.0,0.0,123455.134,1.0,2.0,-1.23,0.0,-1.23);
  int i = printf("float8_f_5874c===%- 10.3v8hlf===%- 10.3v8hlf===\n",var1,var2);
  return i;
}

int float8_f_5875c() {

  float8 var1 = (float8) (123455.134,1.0,0.0,-1.23,-12345.032,123455.134,2.0,1.0);
  float8 var2 = (float8) (-12345.032,1.0,2.0,1.0,-12345.032,0.0,2.0,1.0);
  int i = printf("float8_f_5875c===%- 10.10v8hlf===%- 10.10v8hlf===\n",var1,var2);
  return i;
}

int float8_f_5876c() {

  float8 var1 = (float8) (2.0,-12345.032,-1.23,123455.134,2.0,-1.23,2.0,-1.23);
  float8 var2 = (float8) (0.0,123455.134,2.0,2.0,1.0,2.0,2.0,1.0);
  int i = printf("float8_f_5876c===%- 10v8hlF===%- 10v8hlF===\n",var1,var2);
  return i;
}

int float8_f_5877c() {

  float8 var1 = (float8) (2.0,2.0,-1.23,0.0,-12345.032,0.0,-12345.032,1.0);
  float8 var2 = (float8) (123455.134,-12345.032,0.0,-1.23,123455.134,0.0,-1.23,-1.23);
  int i = printf("float8_f_5877c===%- 10.1v8hlF===%- 10.1v8hlF===\n",var1,var2);
  return i;
}

int float8_f_5878c() {

  float8 var1 = (float8) (0.0,0.0,123455.134,-1.23,-1.23,123455.134,0.0,123455.134);
  float8 var2 = (float8) (2.0,0.0,-1.23,123455.134,-1.23,-1.23,-12345.032,-1.23);
  int i = printf("float8_f_5878c===%- 10.2v8hlF===%- 10.2v8hlF===\n",var1,var2);
  return i;
}

int float8_f_5879c() {

  float8 var1 = (float8) (0.0,1.0,123455.134,-12345.032,-12345.032,1.0,0.0,123455.134);
  float8 var2 = (float8) (-1.23,-12345.032,-1.23,1.0,123455.134,-1.23,2.0,0.0);
  int i = printf("float8_f_5879c===%- 10.3v8hlF===%- 10.3v8hlF===\n",var1,var2);
  return i;
}

int float8_f_5880c() {

  float8 var1 = (float8) (-1.23,1.0,0.0,1.0,2.0,123455.134,2.0,2.0);
  float8 var2 = (float8) (1.0,0.0,2.0,-12345.032,-1.23,-12345.032,-1.23,2.0);
  int i = printf("float8_f_5880c===%- 10.10v8hlF===%- 10.10v8hlF===\n",var1,var2);
  return i;
}

int float8_f_6631c() {

  float8 var1 = (float8) (0.0,-1.23,0.0,-1.23,0.0,1.0,-12345.032,-1.23);
  float8 var2 = (float8) (0.0,123455.134,123455.134,2.0,-1.23,1.0,123455.134,2.0);
  int i = printf("float8_f_6631c===%+ 10v8hlf===%+ 10v8hlf===\n",var1,var2);
  return i;
}

int float8_f_6632c() {

  float8 var1 = (float8) (1.0,-1.23,-12345.032,2.0,1.0,-12345.032,-12345.032,2.0);
  float8 var2 = (float8) (123455.134,1.0,-12345.032,-12345.032,1.0,2.0,-1.23,-1.23);
  int i = printf("float8_f_6632c===%+ 10.1v8hlf===%+ 10.1v8hlf===\n",var1,var2);
  return i;
}

int float8_f_6633c() {

  float8 var1 = (float8) (2.0,2.0,-1.23,1.0,123455.134,1.0,-1.23,1.0);
  float8 var2 = (float8) (-12345.032,2.0,-1.23,0.0,-12345.032,123455.134,1.0,1.0);
  int i = printf("float8_f_6633c===%+ 10.2v8hlf===%+ 10.2v8hlf===\n",var1,var2);
  return i;
}

int float8_f_6634c() {

  float8 var1 = (float8) (123455.134,1.0,123455.134,2.0,-12345.032,2.0,2.0,1.0);
  float8 var2 = (float8) (123455.134,2.0,123455.134,2.0,-12345.032,2.0,-1.23,-1.23);
  int i = printf("float8_f_6634c===%+ 10.3v8hlf===%+ 10.3v8hlf===\n",var1,var2);
  return i;
}

int float8_f_6635c() {

  float8 var1 = (float8) (123455.134,-12345.032,2.0,-1.23,-12345.032,0.0,2.0,1.0);
  float8 var2 = (float8) (1.0,0.0,-12345.032,-12345.032,123455.134,-1.23,0.0,0.0);
  int i = printf("float8_f_6635c===%+ 10.10v8hlf===%+ 10.10v8hlf===\n",var1,var2);
  return i;
}

int float8_f_6636c() {

  float8 var1 = (float8) (0.0,1.0,1.0,0.0,0.0,2.0,-12345.032,1.0);
  float8 var2 = (float8) (1.0,123455.134,-1.23,-12345.032,-1.23,1.0,0.0,1.0);
  int i = printf("float8_f_6636c===%+ 10v8hlF===%+ 10v8hlF===\n",var1,var2);
  return i;
}

int float8_f_6637c() {

  float8 var1 = (float8) (-1.23,1.0,-12345.032,1.0,-1.23,2.0,-1.23,0.0);
  float8 var2 = (float8) (1.0,-12345.032,0.0,1.0,-12345.032,-12345.032,0.0,123455.134);
  int i = printf("float8_f_6637c===%+ 10.1v8hlF===%+ 10.1v8hlF===\n",var1,var2);
  return i;
}

int float8_f_6638c() {

  float8 var1 = (float8) (2.0,-1.23,-12345.032,-12345.032,1.0,-1.23,-12345.032,2.0);
  float8 var2 = (float8) (2.0,123455.134,0.0,-12345.032,2.0,-12345.032,-1.23,-12345.032);
  int i = printf("float8_f_6638c===%+ 10.2v8hlF===%+ 10.2v8hlF===\n",var1,var2);
  return i;
}

int float8_f_6639c() {

  float8 var1 = (float8) (-1.23,-12345.032,2.0,123455.134,-1.23,-1.23,-12345.032,1.0);
  float8 var2 = (float8) (0.0,0.0,-1.23,-12345.032,-1.23,2.0,-12345.032,1.0);
  int i = printf("float8_f_6639c===%+ 10.3v8hlF===%+ 10.3v8hlF===\n",var1,var2);
  return i;
}

int float8_f_6640c() {

  float8 var1 = (float8) (123455.134,0.0,-1.23,-12345.032,-1.23,-12345.032,2.0,1.0);
  float8 var2 = (float8) (2.0,-12345.032,1.0,123455.134,2.0,0.0,2.0,2.0);
  int i = printf("float8_f_6640c===%+ 10.10v8hlF===%+ 10.10v8hlF===\n",var1,var2);
  return i;
}

int float8_f_7391c() {

  float8 var1 = (float8) (0.0,-1.23,123455.134,1.0,123455.134,1.0,123455.134,2.0);
  float8 var2 = (float8) (-12345.032,0.0,2.0,-12345.032,1.0,-12345.032,2.0,-1.23);
  int i = printf("float8_f_7391c===%+010v8hlf===%+010v8hlf===\n",var1,var2);
  return i;
}

int float8_f_7392c() {

  float8 var1 = (float8) (-12345.032,-12345.032,-12345.032,2.0,1.0,123455.134,-1.23,0.0);
  float8 var2 = (float8) (2.0,-12345.032,-1.23,2.0,1.0,1.0,2.0,1.0);
  int i = printf("float8_f_7392c===%+010.1v8hlf===%+010.1v8hlf===\n",var1,var2);
  return i;
}

int float8_f_7393c() {

  float8 var1 = (float8) (1.0,1.0,1.0,0.0,-12345.032,-12345.032,123455.134,2.0);
  float8 var2 = (float8) (-12345.032,1.0,0.0,1.0,0.0,-12345.032,123455.134,-1.23);
  int i = printf("float8_f_7393c===%+010.2v8hlf===%+010.2v8hlf===\n",var1,var2);
  return i;
}

int float8_f_7394c() {

  float8 var1 = (float8) (2.0,123455.134,-12345.032,1.0,123455.134,0.0,1.0,0.0);
  float8 var2 = (float8) (123455.134,-1.23,1.0,-1.23,1.0,123455.134,-12345.032,-12345.032);
  int i = printf("float8_f_7394c===%+010.3v8hlf===%+010.3v8hlf===\n",var1,var2);
  return i;
}

int float8_f_7395c() {

  float8 var1 = (float8) (0.0,-12345.032,-1.23,-12345.032,-12345.032,2.0,2.0,-1.23);
  float8 var2 = (float8) (-12345.032,-12345.032,0.0,0.0,123455.134,123455.134,-1.23,0.0);
  int i = printf("float8_f_7395c===%+010.10v8hlf===%+010.10v8hlf===\n",var1,var2);
  return i;
}

int float8_f_7396c() {

  float8 var1 = (float8) (1.0,1.0,-1.23,-1.23,-12345.032,-12345.032,123455.134,0.0);
  float8 var2 = (float8) (123455.134,-12345.032,1.0,0.0,1.0,1.0,1.0,123455.134);
  int i = printf("float8_f_7396c===%+010v8hlF===%+010v8hlF===\n",var1,var2);
  return i;
}

int float8_f_7397c() {

  float8 var1 = (float8) (-12345.032,-1.23,0.0,-1.23,1.0,0.0,-12345.032,1.0);
  float8 var2 = (float8) (123455.134,1.0,-1.23,-1.23,123455.134,123455.134,0.0,-1.23);
  int i = printf("float8_f_7397c===%+010.1v8hlF===%+010.1v8hlF===\n",var1,var2);
  return i;
}

int float8_f_7398c() {

  float8 var1 = (float8) (123455.134,0.0,-1.23,123455.134,-1.23,1.0,1.0,1.0);
  float8 var2 = (float8) (123455.134,-12345.032,1.0,-1.23,123455.134,0.0,123455.134,0.0);
  int i = printf("float8_f_7398c===%+010.2v8hlF===%+010.2v8hlF===\n",var1,var2);
  return i;
}

int float8_f_7399c() {

  float8 var1 = (float8) (0.0,2.0,123455.134,-12345.032,0.0,-12345.032,0.0,0.0);
  float8 var2 = (float8) (2.0,123455.134,1.0,-1.23,-1.23,-12345.032,-1.23,-12345.032);
  int i = printf("float8_f_7399c===%+010.3v8hlF===%+010.3v8hlF===\n",var1,var2);
  return i;
}

int float8_f_7400c() {

  float8 var1 = (float8) (2.0,1.0,-1.23,123455.134,1.0,-12345.032,123455.134,1.0);
  float8 var2 = (float8) (1.0,2.0,-12345.032,123455.134,123455.134,1.0,0.0,2.0);
  int i = printf("float8_f_7400c===%+010.10v8hlF===%+010.10v8hlF===\n",var1,var2);
  return i;
}

int float8_g_1321c() {
  // { dg-printf "float8_g_1321c===-1.23,-1.23,123455,-1.23,-12345,0,0,-12345===1,-1.23,1,123455,-1.23,0,-1.23,1===" }
  float8 var1 = (float8) (-1.23,-1.23,123455.134,-1.23,-12345.032,0.0,0.0,-12345.032);
  float8 var2 = (float8) (1.0,-1.23,1.0,123455.134,-1.23,0.0,-1.23,1.0);
  int i = printf("float8_g_1321c===%-v8hlg===%-v8hlg===\n",var1,var2);
  return i;
}

int float8_g_1322c() {
  // { dg-printf "float8_g_1322c===2,1e+05,2,-1e+04,1,2,2,1e+05===1e+05,2,-1,-1,0,1e+05,2,2===" }
  float8 var1 = (float8) (2.0,123455.134,2.0,-12345.032,1.0,2.0,2.0,123455.134);
  float8 var2 = (float8) (123455.134,2.0,-1.23,-1.23,0.0,123455.134,2.0,2.0);
  int i = printf("float8_g_1322c===%-.1v8hlg===%-.1v8hlg===\n",var1,var2);
  return i;
}

int float8_g_1323c() {
  // { dg-printf "float8_g_1323c===-1.2e+04,1,1,0,-1.2,-1.2e+04,1.2e+05,1.2e+05===1.2e+05,2,-1.2e+04,1.2e+05,0,-1.2e+04,2,1.2e+05===" }
  float8 var1 = (float8) (-12345.032,1.0,1.0,0.0,-1.23,-12345.032,123455.134,123455.134);
  float8 var2 = (float8) (123455.134,2.0,-12345.032,123455.134,0.0,-12345.032,2.0,123455.134);
  int i = printf("float8_g_1323c===%-.2v8hlg===%-.2v8hlg===\n",var1,var2);
  return i;
}

int float8_g_1324c() {
  // { dg-printf "float8_g_1324c===-1.23,1,-1.23,0,-1.23e+04,0,1.23e+05,1.23e+05===-1.23e+04,0,-1.23e+04,1,-1.23e+04,1,-1.23e+04,1===" }
  float8 var1 = (float8) (-1.23,1.0,-1.23,0.0,-12345.032,0.0,123455.134,123455.134);
  float8 var2 = (float8) (-12345.032,0.0,-12345.032,1.0,-12345.032,1.0,-12345.032,1.0);
  int i = printf("float8_g_1324c===%-.3v8hlg===%-.3v8hlg===\n",var1,var2);
  return i;
}

int float8_g_1325c() {
  // { dg-printf "float8_g_1325c===1,-1.230000019,-12345.03223,-1.230000019,-12345.03223,0,123455.1328,2===1,0,-12345.03223,2,2,2,0,1===" }
  float8 var1 = (float8) (1.0,-1.23,-12345.032,-1.23,-12345.032,0.0,123455.134,2.0);
  float8 var2 = (float8) (1.0,0.0,-12345.032,2.0,2.0,2.0,0.0,1.0);
  int i = printf("float8_g_1325c===%-.10v8hlg===%-.10v8hlg===\n",var1,var2);
  return i;
}

int float8_g_1326c() {
  // { dg-printf "float8_g_1326c===0,123455,0,1,0,123455,0,2===-1.23,1,-1.23,2,2,-12345,-1.23,2===" }
  float8 var1 = (float8) (0.0,123455.134,0.0,1.0,0.0,123455.134,0.0,2.0);
  float8 var2 = (float8) (-1.23,1.0,-1.23,2.0,2.0,-12345.032,-1.23,2.0);
  int i = printf("float8_g_1326c===%-v8hlG===%-v8hlG===\n",var1,var2);
  return i;
}

int float8_g_1327c() {
  // { dg-printf "float8_g_1327c===-1,-1,0,0,0,2,1,2===0,2,1E+05,-1E+04,2,2,-1,1E+05===" }
  float8 var1 = (float8) (-1.23,-1.23,0.0,0.0,0.0,2.0,1.0,2.0);
  float8 var2 = (float8) (0.0,2.0,123455.134,-12345.032,2.0,2.0,-1.23,123455.134);
  int i = printf("float8_g_1327c===%-.1v8hlG===%-.1v8hlG===\n",var1,var2);
  return i;
}

int float8_g_1328c() {
  // { dg-printf "float8_g_1328c===-1.2,-1.2,-1.2,-1.2,1.2E+05,2,1,0===-1.2E+04,-1.2E+04,0,2,1.2E+05,-1.2,2,0===" }
  float8 var1 = (float8) (-1.23,-1.23,-1.23,-1.23,123455.134,2.0,1.0,0.0);
  float8 var2 = (float8) (-12345.032,-12345.032,0.0,2.0,123455.134,-1.23,2.0,0.0);
  int i = printf("float8_g_1328c===%-.2v8hlG===%-.2v8hlG===\n",var1,var2);
  return i;
}

int float8_g_1329c() {
  // { dg-printf "float8_g_1329c===-1.23,0,-1.23E+04,1.23E+05,0,0,-1.23,1.23E+05===1.23E+05,0,-1.23E+04,0,-1.23E+04,2,2,1.23E+05===" }
  float8 var1 = (float8) (-1.23,0.0,-12345.032,123455.134,0.0,0.0,-1.23,123455.134);
  float8 var2 = (float8) (123455.134,0.0,-12345.032,0.0,-12345.032,2.0,2.0,123455.134);
  int i = printf("float8_g_1329c===%-.3v8hlG===%-.3v8hlG===\n",var1,var2);
  return i;
}

int float8_g_1330c() {
  // { dg-printf "float8_g_1330c===-1.230000019,-12345.03223,1,1,0,-12345.03223,-1.230000019,-12345.03223===1,1,-1.230000019,-12345.03223,2,1,-12345.03223,-12345.03223===" }
  float8 var1 = (float8) (-1.23,-12345.032,1.0,1.0,0.0,-12345.032,-1.23,-12345.032);
  float8 var2 = (float8) (1.0,1.0,-1.23,-12345.032,2.0,1.0,-12345.032,-12345.032);
  int i = printf("float8_g_1330c===%-.10v8hlG===%-.10v8hlG===\n",var1,var2);
  return i;
}

int float8_g_2081c() {
  // { dg-printf "float8_g_2081c===-1.23,-12345,+0,+2,+1,+1,-12345,+0===+2,+1,+2,+123455,+0,+0,+123455,+0===" }
  float8 var1 = (float8) (-1.23,-12345.032,0.0,2.0,1.0,1.0,-12345.032,0.0);
  float8 var2 = (float8) (2.0,1.0,2.0,123455.134,0.0,0.0,123455.134,0.0);
  int i = printf("float8_g_2081c===%+v8hlg===%+v8hlg===\n",var1,var2);
  return i;
}

int float8_g_2082c() {
  // { dg-printf "float8_g_2082c===+2,+1e+05,+0,-1,+1,+2,+0,-1===+1,+2,-1,+1,+1e+05,-1,+1,-1e+04===" }
  float8 var1 = (float8) (2.0,123455.134,0.0,-1.23,1.0,2.0,0.0,-1.23);
  float8 var2 = (float8) (1.0,2.0,-1.23,1.0,123455.134,-1.23,1.0,-12345.032);
  int i = printf("float8_g_2082c===%+.1v8hlg===%+.1v8hlg===\n",var1,var2);
  return i;
}

int float8_g_2083c() {
  // { dg-printf "float8_g_2083c===+2,-1.2,+1,+2,+1.2e+05,-1.2,-1.2e+04,+2===+0,-1.2e+04,-1.2,+2,+0,+2,+1,-1.2e+04===" }
  float8 var1 = (float8) (2.0,-1.23,1.0,2.0,123455.134,-1.23,-12345.032,2.0);
  float8 var2 = (float8) (0.0,-12345.032,-1.23,2.0,0.0,2.0,1.0,-12345.032);
  int i = printf("float8_g_2083c===%+.2v8hlg===%+.2v8hlg===\n",var1,var2);
  return i;
}

int float8_g_2084c() {
  // { dg-printf "float8_g_2084c===-1.23,+0,+1,+2,-1.23,+1.23e+05,+1,+2===-1.23,-1.23,-1.23e+04,+2,-1.23,-1.23,-1.23e+04,-1.23e+04===" }
  float8 var1 = (float8) (-1.23,0.0,1.0,2.0,-1.23,123455.134,1.0,2.0);
  float8 var2 = (float8) (-1.23,-1.23,-12345.032,2.0,-1.23,-1.23,-12345.032,-12345.032);
  int i = printf("float8_g_2084c===%+.3v8hlg===%+.3v8hlg===\n",var1,var2);
  return i;
}

int float8_g_2085c() {
  // { dg-printf "float8_g_2085c===+1,+123455.1328,+0,+2,-1.230000019,+1,+2,+123455.1328===-1.230000019,+123455.1328,+123455.1328,-12345.03223,-12345.03223,+2,+1,+0===" }
  float8 var1 = (float8) (1.0,123455.134,0.0,2.0,-1.23,1.0,2.0,123455.134);
  float8 var2 = (float8) (-1.23,123455.134,123455.134,-12345.032,-12345.032,2.0,1.0,0.0);
  int i = printf("float8_g_2085c===%+.10v8hlg===%+.10v8hlg===\n",var1,var2);
  return i;
}

int float8_g_2086c() {
  // { dg-printf "float8_g_2086c===-12345,-1.23,+123455,-12345,+123455,-1.23,-1.23,-12345===+0,+2,+1,+2,+0,-1.23,+2,+1===" }
  float8 var1 = (float8) (-12345.032,-1.23,123455.134,-12345.032,123455.134,-1.23,-1.23,-12345.032);
  float8 var2 = (float8) (0.0,2.0,1.0,2.0,0.0,-1.23,2.0,1.0);
  int i = printf("float8_g_2086c===%+v8hlG===%+v8hlG===\n",var1,var2);
  return i;
}

int float8_g_2087c() {
  // { dg-printf "float8_g_2087c===+1,+1E+05,+0,-1E+04,+1E+05,+2,+1E+05,-1E+04===+1,+1E+05,+1E+05,-1E+04,-1E+04,+1E+05,+1,-1===" }
  float8 var1 = (float8) (1.0,123455.134,0.0,-12345.032,123455.134,2.0,123455.134,-12345.032);
  float8 var2 = (float8) (1.0,123455.134,123455.134,-12345.032,-12345.032,123455.134,1.0,-1.23);
  int i = printf("float8_g_2087c===%+.1v8hlG===%+.1v8hlG===\n",var1,var2);
  return i;
}

int float8_g_2088c() {
  // { dg-printf "float8_g_2088c===+2,+1,-1.2,+2,+2,+1.2E+05,+0,-1.2===+1,-1.2,+1,-1.2,-1.2E+04,+2,-1.2,+0===" }
  float8 var1 = (float8) (2.0,1.0,-1.23,2.0,2.0,123455.134,0.0,-1.23);
  float8 var2 = (float8) (1.0,-1.23,1.0,-1.23,-12345.032,2.0,-1.23,0.0);
  int i = printf("float8_g_2088c===%+.2v8hlG===%+.2v8hlG===\n",var1,var2);
  return i;
}

int float8_g_2089c() {
  // { dg-printf "float8_g_2089c===-1.23E+04,+2,+1,+1,+1.23E+05,+1.23E+05,+1.23E+05,-1.23===+1,+1.23E+05,+2,-1.23,+1,+1,-1.23,-1.23===" }
  float8 var1 = (float8) (-12345.032,2.0,1.0,1.0,123455.134,123455.134,123455.134,-1.23);
  float8 var2 = (float8) (1.0,123455.134,2.0,-1.23,1.0,1.0,-1.23,-1.23);
  int i = printf("float8_g_2089c===%+.3v8hlG===%+.3v8hlG===\n",var1,var2);
  return i;
}

int float8_g_2090c() {
  // { dg-printf "float8_g_2090c===-12345.03223,+2,+1,+0,+123455.1328,+123455.1328,+1,-1.230000019===-12345.03223,+1,+123455.1328,-1.230000019,+0,+123455.1328,+123455.1328,+0===" }
  float8 var1 = (float8) (-12345.032,2.0,1.0,0.0,123455.134,123455.134,1.0,-1.23);
  float8 var2 = (float8) (-12345.032,1.0,123455.134,-1.23,0.0,123455.134,123455.134,0.0);
  int i = printf("float8_g_2090c===%+.10v8hlG===%+.10v8hlG===\n",var1,var2);
  return i;
}

int float8_g_2841c() {
  // { dg-printf "float8_g_2841c===1.00000,0.000000,2.00000,1.00000,1.00000,123455.,0.000000,123455.===0.000000,0.000000,2.00000,0.000000,123455.,2.00000,-1.23000,-1.23000===" }
  float8 var1 = (float8) (1.0,0.0,2.0,1.0,1.0,123455.134,0.0,123455.134);
  float8 var2 = (float8) (0.0,0.0,2.0,0.0,123455.134,2.0,-1.23,-1.23);
  int i = printf("float8_g_2841c===%#v8hlg===%#v8hlg===\n",var1,var2);
  return i;
}

int float8_g_2842c() {
  // { dg-printf "float8_g_2842c===1.e+05,1.,-1.e+04,-1.e+04,-1.e+04,1.e+05,0.0,0.0===0.0,-1.,0.0,-1.e+04,-1.,2.,-1.,2.===" }
  float8 var1 = (float8) (123455.134,1.0,-12345.032,-12345.032,-12345.032,123455.134,0.0,0.0);
  float8 var2 = (float8) (0.0,-1.23,0.0,-12345.032,-1.23,2.0,-1.23,2.0);
  int i = printf("float8_g_2842c===%#.1v8hlg===%#.1v8hlg===\n",var1,var2);
  return i;
}

int float8_g_2843c() {
  // { dg-printf "float8_g_2843c===0.00,0.00,-1.2e+04,1.2e+05,-1.2,-1.2,-1.2,2.0===1.2e+05,1.0,-1.2e+04,2.0,1.2e+05,2.0,2.0,-1.2===" }
  float8 var1 = (float8) (0.0,0.0,-12345.032,123455.134,-1.23,-1.23,-1.23,2.0);
  float8 var2 = (float8) (123455.134,1.0,-12345.032,2.0,123455.134,2.0,2.0,-1.23);
  int i = printf("float8_g_2843c===%#.2v8hlg===%#.2v8hlg===\n",var1,var2);
  return i;
}

int float8_g_2844c() {
  // { dg-printf "float8_g_2844c===1.00,1.00,2.00,-1.23,-1.23e+04,2.00,-1.23e+04,1.23e+05===1.23e+05,1.00,-1.23e+04,-1.23e+04,1.00,1.23e+05,-1.23e+04,-1.23e+04===" }
  float8 var1 = (float8) (1.0,1.0,2.0,-1.23,-12345.032,2.0,-12345.032,123455.134);
  float8 var2 = (float8) (123455.134,1.0,-12345.032,-12345.032,1.0,123455.134,-12345.032,-12345.032);
  int i = printf("float8_g_2844c===%#.3v8hlg===%#.3v8hlg===\n",var1,var2);
  return i;
}

int float8_g_2845c() {
  // { dg-printf "float8_g_2845c===2.000000000,1.000000000,2.000000000,0.0000000000,123455.1328,-1.230000019,0.0000000000,0.0000000000===-12345.03223,0.0000000000,1.000000000,0.0000000000,0.0000000000,1.000000000,1.000000000,123455.1328===" }
  float8 var1 = (float8) (2.0,1.0,2.0,0.0,123455.134,-1.23,0.0,0.0);
  float8 var2 = (float8) (-12345.032,0.0,1.0,0.0,0.0,1.0,1.0,123455.134);
  int i = printf("float8_g_2845c===%#.10v8hlg===%#.10v8hlg===\n",var1,var2);
  return i;
}

int float8_g_2846c() {
  // { dg-printf "float8_g_2846c===-12345.0,123455.,123455.,2.00000,1.00000,2.00000,0.000000,-12345.0===1.00000,123455.,-12345.0,123455.,0.000000,-12345.0,123455.,-12345.0===" }
  float8 var1 = (float8) (-12345.032,123455.134,123455.134,2.0,1.0,2.0,0.0,-12345.032);
  float8 var2 = (float8) (1.0,123455.134,-12345.032,123455.134,0.0,-12345.032,123455.134,-12345.032);
  int i = printf("float8_g_2846c===%#v8hlG===%#v8hlG===\n",var1,var2);
  return i;
}

int float8_g_2847c() {
  // { dg-printf "float8_g_2847c===-1.,-1.E+04,1.,2.,-1.E+04,1.E+05,2.,1.E+05===0.0,1.,-1.E+04,1.,0.0,-1.E+04,-1.E+04,-1.===" }
  float8 var1 = (float8) (-1.23,-12345.032,1.0,2.0,-12345.032,123455.134,2.0,123455.134);
  float8 var2 = (float8) (0.0,1.0,-12345.032,1.0,0.0,-12345.032,-12345.032,-1.23);
  int i = printf("float8_g_2847c===%#.1v8hlG===%#.1v8hlG===\n",var1,var2);
  return i;
}

int float8_g_2848c() {
  // { dg-printf "float8_g_2848c===2.0,2.0,1.0,0.00,-1.2,-1.2,1.2E+05,-1.2===-1.2E+04,2.0,0.00,-1.2,1.0,1.0,1.0,1.2E+05===" }
  float8 var1 = (float8) (2.0,2.0,1.0,0.0,-1.23,-1.23,123455.134,-1.23);
  float8 var2 = (float8) (-12345.032,2.0,0.0,-1.23,1.0,1.0,1.0,123455.134);
  int i = printf("float8_g_2848c===%#.2v8hlG===%#.2v8hlG===\n",var1,var2);
  return i;
}

int float8_g_2849c() {
  // { dg-printf "float8_g_2849c===-1.23,-1.23,2.00,-1.23E+04,-1.23E+04,1.00,-1.23E+04,-1.23E+04===1.23E+05,-1.23E+04,-1.23E+04,1.00,-1.23,0.000,1.00,1.23E+05===" }
  float8 var1 = (float8) (-1.23,-1.23,2.0,-12345.032,-12345.032,1.0,-12345.032,-12345.032);
  float8 var2 = (float8) (123455.134,-12345.032,-12345.032,1.0,-1.23,0.0,1.0,123455.134);
  int i = printf("float8_g_2849c===%#.3v8hlG===%#.3v8hlG===\n",var1,var2);
  return i;
}

int float8_g_2850c() {
  // { dg-printf "float8_g_2850c===1.000000000,-1.230000019,0.0000000000,0.0000000000,2.000000000,2.000000000,123455.1328,123455.1328===2.000000000,123455.1328,2.000000000,-12345.03223,2.000000000,1.000000000,0.0000000000,2.000000000===" }
  float8 var1 = (float8) (1.0,-1.23,0.0,0.0,2.0,2.0,123455.134,123455.134);
  float8 var2 = (float8) (2.0,123455.134,2.0,-12345.032,2.0,1.0,0.0,2.0);
  int i = printf("float8_g_2850c===%#.10v8hlG===%#.10v8hlG===\n",var1,var2);
  return i;
}

int float8_g_3601c() {
  // { dg-printf "float8_g_3601c===-12345,+2,+123455,+1,+123455,-12345,+0,+0===-1.23,+2,+2,+0,+0,+2,-1.23,-12345===" }
  float8 var1 = (float8) (-12345.032,2.0,123455.134,1.0,123455.134,-12345.032,0.0,0.0);
  float8 var2 = (float8) (-1.23,2.0,2.0,0.0,0.0,2.0,-1.23,-12345.032);
  int i = printf("float8_g_3601c===%-+v8hlg===%-+v8hlg===\n",var1,var2);
  return i;
}

int float8_g_3602c() {
  // { dg-printf "float8_g_3602c===+0,-1e+04,+2,+1e+05,+2,+2,-1,+1e+05===+2,-1,+0,+1,+2,-1,+2,-1e+04===" }
  float8 var1 = (float8) (0.0,-12345.032,2.0,123455.134,2.0,2.0,-1.23,123455.134);
  float8 var2 = (float8) (2.0,-1.23,0.0,1.0,2.0,-1.23,2.0,-12345.032);
  int i = printf("float8_g_3602c===%-+.1v8hlg===%-+.1v8hlg===\n",var1,var2);
  return i;
}

int float8_g_3603c() {
  // { dg-printf "float8_g_3603c===-1.2,+0,-1.2e+04,+1,-1.2e+04,-1.2e+04,+0,-1.2===+1.2e+05,-1.2,+1.2e+05,-1.2,-1.2,+0,-1.2,-1.2===" }
  float8 var1 = (float8) (-1.23,0.0,-12345.032,1.0,-12345.032,-12345.032,0.0,-1.23);
  float8 var2 = (float8) (123455.134,-1.23,123455.134,-1.23,-1.23,0.0,-1.23,-1.23);
  int i = printf("float8_g_3603c===%-+.2v8hlg===%-+.2v8hlg===\n",var1,var2);
  return i;
}

int float8_g_3604c() {
  // { dg-printf "float8_g_3604c===+1,-1.23e+04,+1,+0,-1.23e+04,-1.23,+0,+0===+1,+1,-1.23,+0,+2,+0,-1.23,+0===" }
  float8 var1 = (float8) (1.0,-12345.032,1.0,0.0,-12345.032,-1.23,0.0,0.0);
  float8 var2 = (float8) (1.0,1.0,-1.23,0.0,2.0,0.0,-1.23,0.0);
  int i = printf("float8_g_3604c===%-+.3v8hlg===%-+.3v8hlg===\n",var1,var2);
  return i;
}

int float8_g_3605c() {
  // { dg-printf "float8_g_3605c===-1.230000019,+0,+1,+2,-1.230000019,-1.230000019,-1.230000019,+0===+2,-12345.03223,+2,+123455.1328,+1,-1.230000019,+1,+2===" }
  float8 var1 = (float8) (-1.23,0.0,1.0,2.0,-1.23,-1.23,-1.23,0.0);
  float8 var2 = (float8) (2.0,-12345.032,2.0,123455.134,1.0,-1.23,1.0,2.0);
  int i = printf("float8_g_3605c===%-+.10v8hlg===%-+.10v8hlg===\n",var1,var2);
  return i;
}

int float8_g_3606c() {
  // { dg-printf "float8_g_3606c===+1,+1,+1,+2,-1.23,+0,-12345,+1===-12345,+0,+123455,+123455,+1,+0,-1.23,+2===" }
  float8 var1 = (float8) (1.0,1.0,1.0,2.0,-1.23,0.0,-12345.032,1.0);
  float8 var2 = (float8) (-12345.032,0.0,123455.134,123455.134,1.0,0.0,-1.23,2.0);
  int i = printf("float8_g_3606c===%-+v8hlG===%-+v8hlG===\n",var1,var2);
  return i;
}

int float8_g_3607c() {
  // { dg-printf "float8_g_3607c===-1E+04,+0,+1,+2,+1E+05,-1E+04,+0,+1E+05===+2,+0,+1E+05,-1,-1,+0,+1E+05,+2===" }
  float8 var1 = (float8) (-12345.032,0.0,1.0,2.0,123455.134,-12345.032,0.0,123455.134);
  float8 var2 = (float8) (2.0,0.0,123455.134,-1.23,-1.23,0.0,123455.134,2.0);
  int i = printf("float8_g_3607c===%-+.1v8hlG===%-+.1v8hlG===\n",var1,var2);
  return i;
}

int float8_g_3608c() {
  // { dg-printf "float8_g_3608c===-1.2E+04,+1.2E+05,-1.2E+04,+2,+1.2E+05,+1.2E+05,-1.2E+04,-1.2===+1,+1,+0,-1.2E+04,+2,+2,+2,+1===" }
  float8 var1 = (float8) (-12345.032,123455.134,-12345.032,2.0,123455.134,123455.134,-12345.032,-1.23);
  float8 var2 = (float8) (1.0,1.0,0.0,-12345.032,2.0,2.0,2.0,1.0);
  int i = printf("float8_g_3608c===%-+.2v8hlG===%-+.2v8hlG===\n",var1,var2);
  return i;
}

int float8_g_3609c() {
  // { dg-printf "float8_g_3609c===+1.23E+05,-1.23E+04,+1.23E+05,+1.23E+05,-1.23E+04,+1,-1.23E+04,+2===-1.23E+04,-1.23,+0,+0,+2,+0,-1.23E+04,+2===" }
  float8 var1 = (float8) (123455.134,-12345.032,123455.134,123455.134,-12345.032,1.0,-12345.032,2.0);
  float8 var2 = (float8) (-12345.032,-1.23,0.0,0.0,2.0,0.0,-12345.032,2.0);
  int i = printf("float8_g_3609c===%-+.3v8hlG===%-+.3v8hlG===\n",var1,var2);
  return i;
}

int float8_g_3610c() {
  // { dg-printf "float8_g_3610c===+2,+123455.1328,+2,+123455.1328,+1,+2,-1.230000019,+0===+1,-1.230000019,+2,+2,-12345.03223,-1.230000019,-12345.03223,+1===" }
  float8 var1 = (float8) (2.0,123455.134,2.0,123455.134,1.0,2.0,-1.23,0.0);
  float8 var2 = (float8) (1.0,-1.23,2.0,2.0,-12345.032,-1.23,-12345.032,1.0);
  int i = printf("float8_g_3610c===%-+.10v8hlG===%-+.10v8hlG===\n",var1,var2);
  return i;
}

int float8_g_4361c() {
  // { dg-printf "float8_g_4361c===    -12345,         2,         1,     -1.23,         1,         1,    -12345,         0===     -1.23,     -1.23,     -1.23,         2,     -1.23,         2,         2,    -12345===" }
  float8 var1 = (float8) (-12345.032,2.0,1.0,-1.23,1.0,1.0,-12345.032,0.0);
  float8 var2 = (float8) (-1.23,-1.23,-1.23,2.0,-1.23,2.0,2.0,-12345.032);
  int i = printf("float8_g_4361c===% 10v8hlg===% 10v8hlg===\n",var1,var2);
  return i;
}

int float8_g_4362c() {
  // { dg-printf "float8_g_4362c===    -1e+04,         1,    -1e+04,    -1e+04,         2,         0,        -1,    -1e+04===         0,        -1,         2,         0,         0,     1e+05,     1e+05,         1===" }
  float8 var1 = (float8) (-12345.032,1.0,-12345.032,-12345.032,2.0,0.0,-1.23,-12345.032);
  float8 var2 = (float8) (0.0,-1.23,2.0,0.0,0.0,123455.134,123455.134,1.0);
  int i = printf("float8_g_4362c===% 10.1v8hlg===% 10.1v8hlg===\n",var1,var2);
  return i;
}

int float8_g_4363c() {
  // { dg-printf "float8_g_4363c===         0,   1.2e+05,         2,   1.2e+05,         2,         0,         0,         2===         0,  -1.2e+04,  -1.2e+04,         0,  -1.2e+04,         2,   1.2e+05,   1.2e+05===" }
  float8 var1 = (float8) (0.0,123455.134,2.0,123455.134,2.0,0.0,0.0,2.0);
  float8 var2 = (float8) (0.0,-12345.032,-12345.032,0.0,-12345.032,2.0,123455.134,123455.134);
  int i = printf("float8_g_4363c===% 10.2v8hlg===% 10.2v8hlg===\n",var1,var2);
  return i;
}

int float8_g_4364c() {
  // { dg-printf "float8_g_4364c===         0,         0,         1,         2,         2,     -1.23, -1.23e+04,         2===  1.23e+05,         2,         0,         1,         1,         0,  1.23e+05,     -1.23===" }
  float8 var1 = (float8) (0.0,0.0,1.0,2.0,2.0,-1.23,-12345.032,2.0);
  float8 var2 = (float8) (123455.134,2.0,0.0,1.0,1.0,0.0,123455.134,-1.23);
  int i = printf("float8_g_4364c===% 10.3v8hlg===% 10.3v8hlg===\n",var1,var2);
  return i;
}

int float8_g_4365c() {
  // { dg-printf "float8_g_4365c=== 123455.1328,-12345.03223,         1,         2, 123455.1328,         0,-1.230000019,         0=== 123455.1328,         1,-1.230000019,-12345.03223, 123455.1328,         2, 123455.1328,-12345.03223===" }
  float8 var1 = (float8) (123455.134,-12345.032,1.0,2.0,123455.134,0.0,-1.23,0.0);
  float8 var2 = (float8) (123455.134,1.0,-1.23,-12345.032,123455.134,2.0,123455.134,-12345.032);
  int i = printf("float8_g_4365c===% 10.10v8hlg===% 10.10v8hlg===\n",var1,var2);
  return i;
}

int float8_g_4366c() {
  // { dg-printf "float8_g_4366c===    123455,         1,         2,     -1.23,         1,         1,         0,         1===         0,         1,    123455,         0,         0,     -1.23,     -1.23,     -1.23===" }
  float8 var1 = (float8) (123455.134,1.0,2.0,-1.23,1.0,1.0,0.0,1.0);
  float8 var2 = (float8) (0.0,1.0,123455.134,0.0,0.0,-1.23,-1.23,-1.23);
  int i = printf("float8_g_4366c===% 10v8hlG===% 10v8hlG===\n",var1,var2);
  return i;
}

int float8_g_4367c() {
  // { dg-printf "float8_g_4367c===        -1,     1E+05,         1,         0,     1E+05,         0,         1,         2===         0,         2,    -1E+04,         2,         0,     1E+05,    -1E+04,     1E+05===" }
  float8 var1 = (float8) (-1.23,123455.134,1.0,0.0,123455.134,0.0,1.0,2.0);
  float8 var2 = (float8) (0.0,2.0,-12345.032,2.0,0.0,123455.134,-12345.032,123455.134);
  int i = printf("float8_g_4367c===% 10.1v8hlG===% 10.1v8hlG===\n",var1,var2);
  return i;
}

int float8_g_4368c() {
  // { dg-printf "float8_g_4368c===         0,         0,         0,   1.2E+05,      -1.2,   1.2E+05,  -1.2E+04,   1.2E+05===         0,         0,         1,   1.2E+05,   1.2E+05,         1,      -1.2,      -1.2===" }
  float8 var1 = (float8) (0.0,0.0,0.0,123455.134,-1.23,123455.134,-12345.032,123455.134);
  float8 var2 = (float8) (0.0,0.0,1.0,123455.134,123455.134,1.0,-1.23,-1.23);
  int i = printf("float8_g_4368c===% 10.2v8hlG===% 10.2v8hlG===\n",var1,var2);
  return i;
}

int float8_g_4369c() {
  // { dg-printf "float8_g_4369c===     -1.23,     -1.23,     -1.23, -1.23E+04,     -1.23, -1.23E+04, -1.23E+04,         2===  1.23E+05,         1,         1,         2,     -1.23,  1.23E+05, -1.23E+04,         0===" }
  float8 var1 = (float8) (-1.23,-1.23,-1.23,-12345.032,-1.23,-12345.032,-12345.032,2.0);
  float8 var2 = (float8) (123455.134,1.0,1.0,2.0,-1.23,123455.134,-12345.032,0.0);
  int i = printf("float8_g_4369c===% 10.3v8hlG===% 10.3v8hlG===\n",var1,var2);
  return i;
}

int float8_g_4370c() {
  // { dg-printf "float8_g_4370c===         2,         1,         2,         1,         0,-12345.03223,         0, 123455.1328===         2, 123455.1328,-1.230000019,-12345.03223,         0,-12345.03223,         1,-1.230000019===" }
  float8 var1 = (float8) (2.0,1.0,2.0,1.0,0.0,-12345.032,0.0,123455.134);
  float8 var2 = (float8) (2.0,123455.134,-1.23,-12345.032,0.0,-12345.032,1.0,-1.23);
  int i = printf("float8_g_4370c===% 10.10v8hlG===% 10.10v8hlG===\n",var1,var2);
  return i;
}

int float8_g_5121c() {
  // { dg-printf "float8_g_5121c===0000000002,0000123455,-000012345,0000123455,-000001.23,-000012345,0000123455,-000001.23===-000012345,0000000001,0000000000,-000012345,0000000001,0000000001,0000123455,0000000002===" }
  float8 var1 = (float8) (2.0,123455.134,-12345.032,123455.134,-1.23,-12345.032,123455.134,-1.23);
  float8 var2 = (float8) (-12345.032,1.0,0.0,-12345.032,1.0,1.0,123455.134,2.0);
  int i = printf("float8_g_5121c===%010v8hlg===%010v8hlg===\n",var1,var2);
  return i;
}

int float8_g_5122c() {
  // { dg-printf "float8_g_5122c===0000000002,0000000002,0000000000,0000000000,-000000001,-00001e+04,0000000000,0000000001===-00001e+04,000001e+05,0000000000,0000000002,0000000002,0000000002,-000000001,0000000002===" }
  float8 var1 = (float8) (2.0,2.0,0.0,0.0,-1.23,-12345.032,0.0,1.0);
  float8 var2 = (float8) (-12345.032,123455.134,0.0,2.0,2.0,2.0,-1.23,2.0);
  int i = printf("float8_g_5122c===%010.1v8hlg===%010.1v8hlg===\n",var1,var2);
  return i;
}

int float8_g_5123c() {
  // { dg-printf "float8_g_5123c===0000000000,-0000001.2,-001.2e+04,0000000002,-001.2e+04,0001.2e+05,0000000001,-001.2e+04===-001.2e+04,0000000002,0001.2e+05,0000000002,-001.2e+04,-0000001.2,0000000000,0001.2e+05===" }
  float8 var1 = (float8) (0.0,-1.23,-12345.032,2.0,-12345.032,123455.134,1.0,-12345.032);
  float8 var2 = (float8) (-12345.032,2.0,123455.134,2.0,-12345.032,-1.23,0.0,123455.134);
  int i = printf("float8_g_5123c===%010.2v8hlg===%010.2v8hlg===\n",var1,var2);
  return i;
}

int float8_g_5124c() {
  // { dg-printf "float8_g_5124c===001.23e+05,-01.23e+04,001.23e+05,0000000001,-000001.23,0000000000,0000000000,-000001.23===0000000002,0000000001,0000000001,-000001.23,0000000000,0000000000,0000000002,001.23e+05===" }
  float8 var1 = (float8) (123455.134,-12345.032,123455.134,1.0,-1.23,0.0,0.0,-1.23);
  float8 var2 = (float8) (2.0,1.0,1.0,-1.23,0.0,0.0,2.0,123455.134);
  int i = printf("float8_g_5124c===%010.3v8hlg===%010.3v8hlg===\n",var1,var2);
  return i;
}

int float8_g_5125c() {
  // { dg-printf "float8_g_5125c===-1.230000019,-12345.03223,-12345.03223,0000000001,0000000001,0000000002,123455.1328,0000000001===123455.1328,0000000000,-1.230000019,0000000002,0000000002,0000000001,0000000002,0000000002===" }
  float8 var1 = (float8) (-1.23,-12345.032,-12345.032,1.0,1.0,2.0,123455.134,1.0);
  float8 var2 = (float8) (123455.134,0.0,-1.23,2.0,2.0,1.0,2.0,2.0);
  int i = printf("float8_g_5125c===%010.10v8hlg===%010.10v8hlg===\n",var1,var2);
  return i;
}

int float8_g_5126c() {
  // { dg-printf "float8_g_5126c===0000000002,0000000002,0000123455,-000012345,0000123455,0000123455,0000000000,0000123455===0000123455,-000001.23,-000001.23,-000001.23,0000123455,0000123455,-000001.23,0000123455===" }
  float8 var1 = (float8) (2.0,2.0,123455.134,-12345.032,123455.134,123455.134,0.0,123455.134);
  float8 var2 = (float8) (123455.134,-1.23,-1.23,-1.23,123455.134,123455.134,-1.23,123455.134);
  int i = printf("float8_g_5126c===%010v8hlG===%010v8hlG===\n",var1,var2);
  return i;
}

int float8_g_5127c() {
  // { dg-printf "float8_g_5127c===0000000000,0000000001,0000000001,000001E+05,000001E+05,000001E+05,0000000001,0000000001===0000000000,0000000001,-00001E+04,-00001E+04,-00001E+04,0000000002,0000000001,0000000001===" }
  float8 var1 = (float8) (0.0,1.0,1.0,123455.134,123455.134,123455.134,1.0,1.0);
  float8 var2 = (float8) (0.0,1.0,-12345.032,-12345.032,-12345.032,2.0,1.0,1.0);
  int i = printf("float8_g_5127c===%010.1v8hlG===%010.1v8hlG===\n",var1,var2);
  return i;
}

int float8_g_5128c() {
  // { dg-printf "float8_g_5128c===0000000002,0001.2E+05,0000000002,-001.2E+04,0000000001,0000000001,0000000001,0000000002===0000000002,-0000001.2,0000000000,0001.2E+05,-0000001.2,0000000002,0000000000,0000000000===" }
  float8 var1 = (float8) (2.0,123455.134,2.0,-12345.032,1.0,1.0,1.0,2.0);
  float8 var2 = (float8) (2.0,-1.23,0.0,123455.134,-1.23,2.0,0.0,0.0);
  int i = printf("float8_g_5128c===%010.2v8hlG===%010.2v8hlG===\n",var1,var2);
  return i;
}

int float8_g_5129c() {
  // { dg-printf "float8_g_5129c===-01.23E+04,-000001.23,-000001.23,-000001.23,-000001.23,-000001.23,0000000000,0000000001===0000000002,-01.23E+04,-01.23E+04,0000000001,001.23E+05,0000000002,-01.23E+04,001.23E+05===" }
  float8 var1 = (float8) (-12345.032,-1.23,-1.23,-1.23,-1.23,-1.23,0.0,1.0);
  float8 var2 = (float8) (2.0,-12345.032,-12345.032,1.0,123455.134,2.0,-12345.032,123455.134);
  int i = printf("float8_g_5129c===%010.3v8hlG===%010.3v8hlG===\n",var1,var2);
  return i;
}

int float8_g_5130c() {
  // { dg-printf "float8_g_5130c===-12345.03223,0000000001,-12345.03223,123455.1328,-1.230000019,-1.230000019,-1.230000019,0000000002===0000000002,123455.1328,-12345.03223,0000000001,123455.1328,123455.1328,-1.230000019,123455.1328===" }
  float8 var1 = (float8) (-12345.032,1.0,-12345.032,123455.134,-1.23,-1.23,-1.23,2.0);
  float8 var2 = (float8) (2.0,123455.134,-12345.032,1.0,123455.134,123455.134,-1.23,123455.134);
  int i = printf("float8_g_5130c===%010.10v8hlG===%010.10v8hlG===\n",var1,var2);
  return i;
}

int float8_g_561c() {
  // { dg-printf "float8_g_561c===-1.23,2,-12345,123455,2,-12345,0,1===0,-1.23,2,1,-12345,-12345,-1.23,-1.23===" }
  float8 var1 = (float8) (-1.23,2.0,-12345.032,123455.134,2.0,-12345.032,0.0,1.0);
  float8 var2 = (float8) (0.0,-1.23,2.0,1.0,-12345.032,-12345.032,-1.23,-1.23);
  int i = printf("float8_g_561c===%v8hlg===%v8hlg===\n",var1,var2);
  return i;
}

int float8_g_562c() {
  // { dg-printf "float8_g_562c===-1,1,1e+05,1e+05,1e+05,0,2,-1e+04===-1e+04,1,-1,-1e+04,0,-1,1e+05,1===" }
  float8 var1 = (float8) (-1.23,1.0,123455.134,123455.134,123455.134,0.0,2.0,-12345.032);
  float8 var2 = (float8) (-12345.032,1.0,-1.23,-12345.032,0.0,-1.23,123455.134,1.0);
  int i = printf("float8_g_562c===%.1v8hlg===%.1v8hlg===\n",var1,var2);
  return i;
}

int float8_g_563c() {
  // { dg-printf "float8_g_563c===-1.2,-1.2,-1.2,0,-1.2,-1.2,-1.2e+04,1===0,2,0,-1.2,1,1.2e+05,1,-1.2===" }
  float8 var1 = (float8) (-1.23,-1.23,-1.23,0.0,-1.23,-1.23,-12345.032,1.0);
  float8 var2 = (float8) (0.0,2.0,0.0,-1.23,1.0,123455.134,1.0,-1.23);
  int i = printf("float8_g_563c===%.2v8hlg===%.2v8hlg===\n",var1,var2);
  return i;
}

int float8_g_564c() {
  // { dg-printf "float8_g_564c===-1.23,1.23e+05,-1.23e+04,0,0,2,-1.23,2===1.23e+05,1,2,2,1,1.23e+05,2,1.23e+05===" }
  float8 var1 = (float8) (-1.23,123455.134,-12345.032,0.0,0.0,2.0,-1.23,2.0);
  float8 var2 = (float8) (123455.134,1.0,2.0,2.0,1.0,123455.134,2.0,123455.134);
  int i = printf("float8_g_564c===%.3v8hlg===%.3v8hlg===\n",var1,var2);
  return i;
}

int float8_g_565c() {
  // { dg-printf "float8_g_565c===-12345.03223,-12345.03223,-12345.03223,123455.1328,123455.1328,2,1,0===123455.1328,2,0,2,2,2,-12345.03223,0===" }
  float8 var1 = (float8) (-12345.032,-12345.032,-12345.032,123455.134,123455.134,2.0,1.0,0.0);
  float8 var2 = (float8) (123455.134,2.0,0.0,2.0,2.0,2.0,-12345.032,0.0);
  int i = printf("float8_g_565c===%.10v8hlg===%.10v8hlg===\n",var1,var2);
  return i;
}

int float8_g_566c() {
  // { dg-printf "float8_g_566c===1,-12345,0,2,-12345,0,2,2===-1.23,-12345,0,0,123455,2,2,2===" }
  float8 var1 = (float8) (1.0,-12345.032,0.0,2.0,-12345.032,0.0,2.0,2.0);
  float8 var2 = (float8) (-1.23,-12345.032,0.0,0.0,123455.134,2.0,2.0,2.0);
  int i = printf("float8_g_566c===%v8hlG===%v8hlG===\n",var1,var2);
  return i;
}

int float8_g_567c() {
  // { dg-printf "float8_g_567c===-1,1,-1,0,-1,0,-1,1===2,1E+05,0,1,0,0,2,0===" }
  float8 var1 = (float8) (-1.23,1.0,-1.23,0.0,-1.23,0.0,-1.23,1.0);
  float8 var2 = (float8) (2.0,123455.134,0.0,1.0,0.0,0.0,2.0,0.0);
  int i = printf("float8_g_567c===%.1v8hlG===%.1v8hlG===\n",var1,var2);
  return i;
}

int float8_g_568c() {
  // { dg-printf "float8_g_568c===-1.2,2,1,-1.2E+04,-1.2,1,1.2E+05,1===0,2,2,0,1.2E+05,1,0,0===" }
  float8 var1 = (float8) (-1.23,2.0,1.0,-12345.032,-1.23,1.0,123455.134,1.0);
  float8 var2 = (float8) (0.0,2.0,2.0,0.0,123455.134,1.0,0.0,0.0);
  int i = printf("float8_g_568c===%.2v8hlG===%.2v8hlG===\n",var1,var2);
  return i;
}

int float8_g_569c() {
  // { dg-printf "float8_g_569c===2,-1.23,-1.23,1.23E+05,-1.23E+04,0,-1.23E+04,1.23E+05===-1.23,-1.23E+04,-1.23E+04,1.23E+05,-1.23,-1.23,0,-1.23E+04===" }
  float8 var1 = (float8) (2.0,-1.23,-1.23,123455.134,-12345.032,0.0,-12345.032,123455.134);
  float8 var2 = (float8) (-1.23,-12345.032,-12345.032,123455.134,-1.23,-1.23,0.0,-12345.032);
  int i = printf("float8_g_569c===%.3v8hlG===%.3v8hlG===\n",var1,var2);
  return i;
}

int float8_g_570c() {
  // { dg-printf "float8_g_570c===2,123455.1328,2,2,-1.230000019,0,123455.1328,1===0,-1.230000019,-12345.03223,2,1,123455.1328,123455.1328,2===" }
  float8 var1 = (float8) (2.0,123455.134,2.0,2.0,-1.23,0.0,123455.134,1.0);
  float8 var2 = (float8) (0.0,-1.23,-12345.032,2.0,1.0,123455.134,123455.134,2.0);
  int i = printf("float8_g_570c===%.10v8hlG===%.10v8hlG===\n",var1,var2);
  return i;
}

int float8_g_5881c() {
  // { dg-printf "float8_g_5881c=== 0        , 123455   , 123455   ,-12345    ,-12345    , 1        , 1        ,-12345    ===-1.23     , 123455   ,-1.23     , 123455   , 0        , 0        ,-1.23     ,-1.23     ===" }
  float8 var1 = (float8) (0.0,123455.134,123455.134,-12345.032,-12345.032,1.0,1.0,-12345.032);
  float8 var2 = (float8) (-1.23,123455.134,-1.23,123455.134,0.0,0.0,-1.23,-1.23);
  int i = printf("float8_g_5881c===%- 10v8hlg===%- 10v8hlg===\n",var1,var2);
  return i;
}

int float8_g_5882c() {
  // { dg-printf "float8_g_5882c=== 1e+05    , 2        , 1e+05    , 1        , 1e+05    , 0        , 0        ,-1e+04    === 2        , 0        ,-1        , 0        , 1e+05    , 0        ,-1e+04    , 1        ===" }
  float8 var1 = (float8) (123455.134,2.0,123455.134,1.0,123455.134,0.0,0.0,-12345.032);
  float8 var2 = (float8) (2.0,0.0,-1.23,0.0,123455.134,0.0,-12345.032,1.0);
  int i = printf("float8_g_5882c===%- 10.1v8hlg===%- 10.1v8hlg===\n",var1,var2);
  return i;
}

int float8_g_5883c() {
  // { dg-printf "float8_g_5883c===-1.2e+04  ,-1.2e+04  , 2        , 1.2e+05  , 0        ,-1.2e+04  , 1        , 1        ===-1.2      , 2        , 0        , 0        , 1        ,-1.2e+04  , 0        ,-1.2      ===" }
  float8 var1 = (float8) (-12345.032,-12345.032,2.0,123455.134,0.0,-12345.032,1.0,1.0);
  float8 var2 = (float8) (-1.23,2.0,0.0,0.0,1.0,-12345.032,0.0,-1.23);
  int i = printf("float8_g_5883c===%- 10.2v8hlg===%- 10.2v8hlg===\n",var1,var2);
  return i;
}

int float8_g_5884c() {
  // { dg-printf "float8_g_5884c=== 1        , 1.23e+05 ,-1.23e+04 , 0        ,-1.23e+04 , 2        , 2        ,-1.23e+04 === 2        ,-1.23     , 1.23e+05 ,-1.23e+04 ,-1.23     , 0        , 2        , 0        ===" }
  float8 var1 = (float8) (1.0,123455.134,-12345.032,0.0,-12345.032,2.0,2.0,-12345.032);
  float8 var2 = (float8) (2.0,-1.23,123455.134,-12345.032,-1.23,0.0,2.0,0.0);
  int i = printf("float8_g_5884c===%- 10.3v8hlg===%- 10.3v8hlg===\n",var1,var2);
  return i;
}

int float8_g_5885c() {
  // { dg-printf "float8_g_5885c=== 0        , 0        , 123455.1328,-1.230000019,-1.230000019, 2        , 0        , 123455.1328===-12345.03223, 123455.1328, 0        ,-12345.03223,-12345.03223, 0        , 123455.1328,-12345.03223===" }
  float8 var1 = (float8) (0.0,0.0,123455.134,-1.23,-1.23,2.0,0.0,123455.134);
  float8 var2 = (float8) (-12345.032,123455.134,0.0,-12345.032,-12345.032,0.0,123455.134,-12345.032);
  int i = printf("float8_g_5885c===%- 10.10v8hlg===%- 10.10v8hlg===\n",var1,var2);
  return i;
}

int float8_g_5886c() {
  // { dg-printf "float8_g_5886c=== 0        ,-12345    , 2        , 1        , 1        ,-1.23     , 2        , 2        === 1        , 1        ,-12345    , 123455   , 1        , 2        , 2        , 1        ===" }
  float8 var1 = (float8) (0.0,-12345.032,2.0,1.0,1.0,-1.23,2.0,2.0);
  float8 var2 = (float8) (1.0,1.0,-12345.032,123455.134,1.0,2.0,2.0,1.0);
  int i = printf("float8_g_5886c===%- 10v8hlG===%- 10v8hlG===\n",var1,var2);
  return i;
}

int float8_g_5887c() {
  // { dg-printf "float8_g_5887c===-1E+04    ,-1        ,-1E+04    , 1E+05    , 1        , 2        , 1E+05    , 2        === 1E+05    ,-1        , 0        , 1E+05    ,-1E+04    ,-1        , 2        , 1E+05    ===" }
  float8 var1 = (float8) (-12345.032,-1.23,-12345.032,123455.134,1.0,2.0,123455.134,2.0);
  float8 var2 = (float8) (123455.134,-1.23,0.0,123455.134,-12345.032,-1.23,2.0,123455.134);
  int i = printf("float8_g_5887c===%- 10.1v8hlG===%- 10.1v8hlG===\n",var1,var2);
  return i;
}

int float8_g_5888c() {
  // { dg-printf "float8_g_5888c=== 1        ,-1.2E+04  , 1        , 1.2E+05  , 1.2E+05  , 1.2E+05  , 1        ,-1.2      ===-1.2E+04  ,-1.2E+04  , 2        , 0        , 2        , 0        , 2        ,-1.2      ===" }
  float8 var1 = (float8) (1.0,-12345.032,1.0,123455.134,123455.134,123455.134,1.0,-1.23);
  float8 var2 = (float8) (-12345.032,-12345.032,2.0,0.0,2.0,0.0,2.0,-1.23);
  int i = printf("float8_g_5888c===%- 10.2v8hlG===%- 10.2v8hlG===\n",var1,var2);
  return i;
}

int float8_g_5889c() {
  // { dg-printf "float8_g_5889c===-1.23E+04 ,-1.23E+04 , 1        , 1.23E+05 ,-1.23     , 0        , 0        , 1        === 1        , 2        ,-1.23E+04 , 1        , 0        ,-1.23     ,-1.23E+04 , 1.23E+05 ===" }
  float8 var1 = (float8) (-12345.032,-12345.032,1.0,123455.134,-1.23,0.0,0.0,1.0);
  float8 var2 = (float8) (1.0,2.0,-12345.032,1.0,0.0,-1.23,-12345.032,123455.134);
  int i = printf("float8_g_5889c===%- 10.3v8hlG===%- 10.3v8hlG===\n",var1,var2);
  return i;
}

int float8_g_5890c() {
  // { dg-printf "float8_g_5890c=== 2        ,-1.230000019, 2        , 2        , 0        ,-12345.03223,-12345.03223,-1.230000019===-1.230000019, 1        , 0        ,-1.230000019, 1        , 1        , 2        ,-12345.03223===" }
  float8 var1 = (float8) (2.0,-1.23,2.0,2.0,0.0,-12345.032,-12345.032,-1.23);
  float8 var2 = (float8) (-1.23,1.0,0.0,-1.23,1.0,1.0,2.0,-12345.032);
  int i = printf("float8_g_5890c===%- 10.10v8hlG===%- 10.10v8hlG===\n",var1,var2);
  return i;
}

int float8_g_6641c() {
  // { dg-printf "float8_g_6641c===    -12345,     -1.23,   +123455,        +0,        +0,        +2,        +1,    -12345===        +1,        +2,    -12345,     -1.23,        +2,        +1,        +0,        +2===" }
  float8 var1 = (float8) (-12345.032,-1.23,123455.134,0.0,0.0,2.0,1.0,-12345.032);
  float8 var2 = (float8) (1.0,2.0,-12345.032,-1.23,2.0,1.0,0.0,2.0);
  int i = printf("float8_g_6641c===%+ 10v8hlg===%+ 10v8hlg===\n",var1,var2);
  return i;
}

int float8_g_6642c() {
  // { dg-printf "float8_g_6642c===    +1e+05,        +2,    +1e+05,        +2,        +2,        -1,        -1,    +1e+05===        +0,        +1,    +1e+05,    +1e+05,        -1,    +1e+05,        -1,    -1e+04===" }
  float8 var1 = (float8) (123455.134,2.0,123455.134,2.0,2.0,-1.23,-1.23,123455.134);
  float8 var2 = (float8) (0.0,1.0,123455.134,123455.134,-1.23,123455.134,-1.23,-12345.032);
  int i = printf("float8_g_6642c===%+ 10.1v8hlg===%+ 10.1v8hlg===\n",var1,var2);
  return i;
}

int float8_g_6643c() {
  // { dg-printf "float8_g_6643c===      -1.2,        +1,        +0,        +0,      -1.2,        +2,  +1.2e+05,        +1===        +1,        +0,        +0,  +1.2e+05,  +1.2e+05,  +1.2e+05,      -1.2,  -1.2e+04===" }
  float8 var1 = (float8) (-1.23,1.0,0.0,0.0,-1.23,2.0,123455.134,1.0);
  float8 var2 = (float8) (1.0,0.0,0.0,123455.134,123455.134,123455.134,-1.23,-12345.032);
  int i = printf("float8_g_6643c===%+ 10.2v8hlg===%+ 10.2v8hlg===\n",var1,var2);
  return i;
}

int float8_g_6644c() {
  // { dg-printf "float8_g_6644c===     -1.23, +1.23e+05,        +2,        +1,        +0,        +2,        +1,     -1.23=== +1.23e+05,        +0,        +0,        +0,        +1,        +1,        +1,        +0===" }
  float8 var1 = (float8) (-1.23,123455.134,2.0,1.0,0.0,2.0,1.0,-1.23);
  float8 var2 = (float8) (123455.134,0.0,0.0,0.0,1.0,1.0,1.0,0.0);
  int i = printf("float8_g_6644c===%+ 10.3v8hlg===%+ 10.3v8hlg===\n",var1,var2);
  return i;
}

int float8_g_6645c() {
  // { dg-printf "float8_g_6645c===        +2,        +0,        +0,-12345.03223,-1.230000019,-1.230000019,+123455.1328,        +0===        +1,-12345.03223,        +1,+123455.1328,+123455.1328,+123455.1328,        +2,        +0===" }
  float8 var1 = (float8) (2.0,0.0,0.0,-12345.032,-1.23,-1.23,123455.134,0.0);
  float8 var2 = (float8) (1.0,-12345.032,1.0,123455.134,123455.134,123455.134,2.0,0.0);
  int i = printf("float8_g_6645c===%+ 10.10v8hlg===%+ 10.10v8hlg===\n",var1,var2);
  return i;
}

int float8_g_6646c() {
  // { dg-printf "float8_g_6646c===    -12345,     -1.23,   +123455,        +1,        +1,   +123455,    -12345,    -12345===   +123455,        +0,        +0,     -1.23,   +123455,     -1.23,        +0,        +1===" }
  float8 var1 = (float8) (-12345.032,-1.23,123455.134,1.0,1.0,123455.134,-12345.032,-12345.032);
  float8 var2 = (float8) (123455.134,0.0,0.0,-1.23,123455.134,-1.23,0.0,1.0);
  int i = printf("float8_g_6646c===%+ 10v8hlG===%+ 10v8hlG===\n",var1,var2);
  return i;
}

int float8_g_6647c() {
  // { dg-printf "float8_g_6647c===        -1,        +0,    +1E+05,    +1E+05,        -1,        +1,        +2,        +2===    -1E+04,        +2,    +1E+05,        -1,    +1E+05,        +2,        +1,        +0===" }
  float8 var1 = (float8) (-1.23,0.0,123455.134,123455.134,-1.23,1.0,2.0,2.0);
  float8 var2 = (float8) (-12345.032,2.0,123455.134,-1.23,123455.134,2.0,1.0,0.0);
  int i = printf("float8_g_6647c===%+ 10.1v8hlG===%+ 10.1v8hlG===\n",var1,var2);
  return i;
}

int float8_g_6648c() {
  // { dg-printf "float8_g_6648c===        +2,  +1.2E+05,      -1.2,        +1,        +2,        +2,  -1.2E+04,  +1.2E+05===        +2,      -1.2,  -1.2E+04,  +1.2E+05,        +0,        +0,  +1.2E+05,        +2===" }
  float8 var1 = (float8) (2.0,123455.134,-1.23,1.0,2.0,2.0,-12345.032,123455.134);
  float8 var2 = (float8) (2.0,-1.23,-12345.032,123455.134,0.0,0.0,123455.134,2.0);
  int i = printf("float8_g_6648c===%+ 10.2v8hlG===%+ 10.2v8hlG===\n",var1,var2);
  return i;
}

int float8_g_6649c() {
  // { dg-printf "float8_g_6649c===        +0,        +1,        +1, -1.23E+04,        +2,        +1,     -1.23,     -1.23=== +1.23E+05,        +1,        +1,     -1.23,        +1,        +1,        +0, +1.23E+05===" }
  float8 var1 = (float8) (0.0,1.0,1.0,-12345.032,2.0,1.0,-1.23,-1.23);
  float8 var2 = (float8) (123455.134,1.0,1.0,-1.23,1.0,1.0,0.0,123455.134);
  int i = printf("float8_g_6649c===%+ 10.3v8hlG===%+ 10.3v8hlG===\n",var1,var2);
  return i;
}

int float8_g_6650c() {
  // { dg-printf "float8_g_6650c===+123455.1328,        +0,        +0,-1.230000019,        +0,        +1,        +1,        +1===-1.230000019,-12345.03223,+123455.1328,        +1,        +2,+123455.1328,+123455.1328,        +1===" }
  float8 var1 = (float8) (123455.134,0.0,0.0,-1.23,0.0,1.0,1.0,1.0);
  float8 var2 = (float8) (-1.23,-12345.032,123455.134,1.0,2.0,123455.134,123455.134,1.0);
  int i = printf("float8_g_6650c===%+ 10.10v8hlG===%+ 10.10v8hlG===\n",var1,var2);
  return i;
}

int float8_g_7401c() {
  // { dg-printf "float8_g_7401c===+000123455,-000001.23,+000000000,-000012345,+000000001,+000123455,-000001.23,+000000002===-000001.23,-000001.23,+000000000,+000000002,+000000002,+000000002,-000012345,+000000002===" }
  float8 var1 = (float8) (123455.134,-1.23,0.0,-12345.032,1.0,123455.134,-1.23,2.0);
  float8 var2 = (float8) (-1.23,-1.23,0.0,2.0,2.0,2.0,-12345.032,2.0);
  int i = printf("float8_g_7401c===%+010v8hlg===%+010v8hlg===\n",var1,var2);
  return i;
}

int float8_g_7402c() {
  // { dg-printf "float8_g_7402c===+000000000,-00001e+04,+000000001,+000000000,-000000001,-000000001,+000000000,-000000001===+00001e+05,+000000002,+000000000,+00001e+05,+000000001,+000000002,+00001e+05,+000000000===" }
  float8 var1 = (float8) (0.0,-12345.032,1.0,0.0,-1.23,-1.23,0.0,-1.23);
  float8 var2 = (float8) (123455.134,2.0,0.0,123455.134,1.0,2.0,123455.134,0.0);
  int i = printf("float8_g_7402c===%+010.1v8hlg===%+010.1v8hlg===\n",var1,var2);
  return i;
}

int float8_g_7403c() {
  // { dg-printf "float8_g_7403c===+000000001,+001.2e+05,+000000000,+000000002,+000000000,+000000002,-001.2e+04,+000000002===+000000000,-0000001.2,+000000001,+000000001,+000000002,+000000001,+000000001,+000000001===" }
  float8 var1 = (float8) (1.0,123455.134,0.0,2.0,0.0,2.0,-12345.032,2.0);
  float8 var2 = (float8) (0.0,-1.23,1.0,1.0,2.0,1.0,1.0,1.0);
  int i = printf("float8_g_7403c===%+010.2v8hlg===%+010.2v8hlg===\n",var1,var2);
  return i;
}

int float8_g_7404c() {
  // { dg-printf "float8_g_7404c===+000000002,+01.23e+05,+000000000,+000000000,+01.23e+05,+000000000,+01.23e+05,+000000001===+000000000,-000001.23,+000000001,-000001.23,+01.23e+05,+000000002,+000000000,-000001.23===" }
  float8 var1 = (float8) (2.0,123455.134,0.0,0.0,123455.134,0.0,123455.134,1.0);
  float8 var2 = (float8) (0.0,-1.23,1.0,-1.23,123455.134,2.0,0.0,-1.23);
  int i = printf("float8_g_7404c===%+010.3v8hlg===%+010.3v8hlg===\n",var1,var2);
  return i;
}

int float8_g_7405c() {
  // { dg-printf "float8_g_7405c===+123455.1328,+123455.1328,+000000000,+000000000,+123455.1328,+000000000,-1.230000019,+000000001===+123455.1328,+000000002,+123455.1328,+123455.1328,+123455.1328,+000000002,-1.230000019,+000000002===" }
  float8 var1 = (float8) (123455.134,123455.134,0.0,0.0,123455.134,0.0,-1.23,1.0);
  float8 var2 = (float8) (123455.134,2.0,123455.134,123455.134,123455.134,2.0,-1.23,2.0);
  int i = printf("float8_g_7405c===%+010.10v8hlg===%+010.10v8hlg===\n",var1,var2);
  return i;
}

int float8_g_7406c() {
  // { dg-printf "float8_g_7406c===-000001.23,+000000001,+000000001,-000012345,+000000000,+000000002,-000001.23,+000000000===+000123455,+000000000,+000000001,+000123455,+000000002,-000012345,+000000000,+000000001===" }
  float8 var1 = (float8) (-1.23,1.0,1.0,-12345.032,0.0,2.0,-1.23,0.0);
  float8 var2 = (float8) (123455.134,0.0,1.0,123455.134,2.0,-12345.032,0.0,1.0);
  int i = printf("float8_g_7406c===%+010v8hlG===%+010v8hlG===\n",var1,var2);
  return i;
}

int float8_g_7407c() {
  // { dg-printf "float8_g_7407c===+00001E+05,+00001E+05,-00001E+04,+000000000,+000000000,-000000001,-000000001,-00001E+04===+000000002,+000000002,+000000001,+00001E+05,+000000001,-000000001,+000000000,-00001E+04===" }
  float8 var1 = (float8) (123455.134,123455.134,-12345.032,0.0,0.0,-1.23,-1.23,-12345.032);
  float8 var2 = (float8) (2.0,2.0,1.0,123455.134,1.0,-1.23,0.0,-12345.032);
  int i = printf("float8_g_7407c===%+010.1v8hlG===%+010.1v8hlG===\n",var1,var2);
  return i;
}

int float8_g_7408c() {
  // { dg-printf "float8_g_7408c===+000000002,-0000001.2,+000000002,-001.2E+04,-001.2E+04,-0000001.2,+001.2E+05,-001.2E+04===+000000001,-001.2E+04,+000000000,-001.2E+04,-001.2E+04,+001.2E+05,+000000002,+000000002===" }
  float8 var1 = (float8) (2.0,-1.23,2.0,-12345.032,-12345.032,-1.23,123455.134,-12345.032);
  float8 var2 = (float8) (1.0,-12345.032,0.0,-12345.032,-12345.032,123455.134,2.0,2.0);
  int i = printf("float8_g_7408c===%+010.2v8hlG===%+010.2v8hlG===\n",var1,var2);
  return i;
}

int float8_g_7409c() {
  // { dg-printf "float8_g_7409c===-01.23E+04,+01.23E+05,-01.23E+04,+000000000,+01.23E+05,-000001.23,+000000000,-000001.23===+01.23E+05,+000000002,+01.23E+05,+01.23E+05,+000000002,+000000001,+000000002,-000001.23===" }
  float8 var1 = (float8) (-12345.032,123455.134,-12345.032,0.0,123455.134,-1.23,0.0,-1.23);
  float8 var2 = (float8) (123455.134,2.0,123455.134,123455.134,2.0,1.0,2.0,-1.23);
  int i = printf("float8_g_7409c===%+010.3v8hlG===%+010.3v8hlG===\n",var1,var2);
  return i;
}

int float8_g_7410c() {
  // { dg-printf "float8_g_7410c===+000000002,+000000000,+000000001,+000000000,+000000002,+000000001,+000000000,+000000000===-1.230000019,+000000001,-1.230000019,+000000000,+000000002,+123455.1328,-1.230000019,+123455.1328===" }
  float8 var1 = (float8) (2.0,0.0,1.0,0.0,2.0,1.0,0.0,0.0);
  float8 var2 = (float8) (-1.23,1.0,-1.23,0.0,2.0,123455.134,-1.23,123455.134);
  int i = printf("float8_g_7410c===%+010.10v8hlG===%+010.10v8hlG===\n",var1,var2);
  return i;
}
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) { int i;











































































































































































































































































































i = float8_g_1321c();
i = float8_g_1322c();
i = float8_g_1323c();
i = float8_g_1324c();
i = float8_g_1325c();
i = float8_g_1326c();
i = float8_g_1327c();
i = float8_g_1328c();
i = float8_g_1329c();
i = float8_g_1330c();
i = float8_g_2081c();
i = float8_g_2082c();
i = float8_g_2083c();
i = float8_g_2084c();
i = float8_g_2085c();
i = float8_g_2086c();
i = float8_g_2087c();
i = float8_g_2088c();
i = float8_g_2089c();
i = float8_g_2090c();
i = float8_g_2841c();
i = float8_g_2842c();
i = float8_g_2843c();
i = float8_g_2844c();
i = float8_g_2845c();
i = float8_g_2846c();
i = float8_g_2847c();
i = float8_g_2848c();
i = float8_g_2849c();
i = float8_g_2850c();
i = float8_g_3601c();
i = float8_g_3602c();
i = float8_g_3603c();
i = float8_g_3604c();
i = float8_g_3605c();
i = float8_g_3606c();
i = float8_g_3607c();
i = float8_g_3608c();
i = float8_g_3609c();
i = float8_g_3610c();
i = float8_g_4361c();
i = float8_g_4362c();
i = float8_g_4363c();
i = float8_g_4364c();
i = float8_g_4365c();
i = float8_g_4366c();
i = float8_g_4367c();
i = float8_g_4368c();
i = float8_g_4369c();
i = float8_g_4370c();
i = float8_g_5121c();
i = float8_g_5122c();
i = float8_g_5123c();
i = float8_g_5124c();
i = float8_g_5125c();
i = float8_g_5126c();
i = float8_g_5127c();
i = float8_g_5128c();
i = float8_g_5129c();
i = float8_g_5130c();
i = float8_g_561c();
i = float8_g_562c();
i = float8_g_563c();
i = float8_g_564c();
i = float8_g_565c();
i = float8_g_566c();
i = float8_g_567c();
i = float8_g_568c();
i = float8_g_569c();
i = float8_g_570c();
i = float8_g_5881c();
i = float8_g_5882c();
i = float8_g_5883c();
i = float8_g_5884c();
i = float8_g_5885c();
i = float8_g_5886c();
i = float8_g_5887c();
i = float8_g_5888c();
i = float8_g_5889c();
i = float8_g_5890c();
i = float8_g_6641c();
i = float8_g_6642c();
i = float8_g_6643c();
i = float8_g_6644c();
i = float8_g_6645c();
i = float8_g_6646c();
i = float8_g_6647c();
i = float8_g_6648c();
i = float8_g_6649c();
i = float8_g_6650c();
i = float8_g_7401c();
i = float8_g_7402c();
i = float8_g_7403c();
i = float8_g_7404c();
i = float8_g_7405c();
i = float8_g_7406c();
i = float8_g_7407c();
i = float8_g_7408c();
i = float8_g_7409c();
i = float8_g_7410c();
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
