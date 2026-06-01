__kernel void VectorAdd(__global const float8* a, __global const float8* b, __global float8* c GUID_ARG) { int iGID = get_global_id(0); if (iGID>=100000) return; c[iGID] = a[iGID] + b[iGID]; }


// buildOptions=-DGUID_ARG=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -DGUID_ARG=" %cfg_path --cl-device=%cl_device 2>&1
