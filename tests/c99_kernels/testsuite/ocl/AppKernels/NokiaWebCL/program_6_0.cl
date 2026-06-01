
              __kernel void ckVectorAdd(__global unsigned int* vectorIn1, __global unsigned int* vectorIn2,
                                        __global unsigned int* vectorOut, unsigned int uiVectorWidth)
              {
                 unsigned int x = get_global_id(0);
                 if (x >= (uiVectorWidth))
                 {
                   return;
                }
                // add the vector elements
                vectorOut[x] = vectorIn1[x] + vectorIn2[x];
              }


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
