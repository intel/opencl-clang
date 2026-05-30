__kernel void vectorAdd(__global const float *a, __global const float *b, __global float *c, const int iter)
{ int nIndex = get_global_id(0);
  float ra = a[nIndex];
  float rb = b[nIndex];
  float rc = 1.0f;
  for (int i=0; i<iter; i++)
  {
    rc = mad(ra,rb,rc) + mad(rb,rc,ra) + mad(rb,ra,rc) - mad(rc,rb,ra);
    rc = mad(rc,rb,ra) - mad(rc,ra,rb) + mad(rb,rc,ra) - mad(rc,ra,rb);
    rc = mad(ra,rb,rc) - mad(rb,ra,rc) - mad(rc,ra,rb) + mad(rc,rb,ra) - 2203;
    rc = mad(ra,rb,rc) - mad(rb,ra,rc) + mad(rc,ra,rb) - mad(ra,rb,rc);
    rc = mad(rc,ra,rb) - mad(ra,rb,rc) - mad(rb,rc,ra) + mad(rc,rb,ra);
    rc = mad(ra,rb,rc) - mad(rb,ra,rc) + mad(rc,ra,rb) - mad(ra,rb,rc) - 76499;
    rc = mad(ra,rc,rb) - mad(rb,rc,ra) + mad(ra,rb,rc) + mad(rb,ra,rc);
    rc = mad(rb,rc,ra) + mad(rc,rb,ra) - mad(rb,ra,rc) - mad(rc,rb,ra);
    rc = mad(rb,rc,ra) - mad(rc,rb,ra) + mad(rb,ra,rc) + mad(rc,rb,ra) - 46503;
    rc = mad(rb,rc,ra) + mad(rc,rb,ra) - mad(rb,ra,rc) - mad(rc,rb,ra) - 2111;
  }
  c[nIndex] = rc;
}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
