
  __kernel void ocl_test_kernel(__global int *ocl_test_results)
  {
    int ret=-1;
    local int z[localWorkSize];
    for(int i=0; i<LOOP; i++) {
      if( get_local_id(0)==0)
        for(int i =0;i<localWorkSize;i++) z[i]=i;

      barrier(CLK_LOCAL_MEM_FENCE);

      int num = get_local_id(0);
      ret = z[num]-num;
      z[num]=0;

      barrier(CLK_LOCAL_MEM_FENCE);
    }


    constant char *args[] = {"ocl", "c99", "gcc"};
    ocl_test_results[get_global_id(0)*4] = 1; //kernel started
    ocl_test_results[get_global_id(0)*4+3] = ret;
    barrier(CLK_LOCAL_MEM_FENCE);
    ocl_test_results[get_global_id(0)*4] = 2; //kernel finished
  }



// buildOptions=-D localWorkSize=100 -D LOOP=120000
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D localWorkSize=100 -D LOOP=120000" %cfg_path --cl-device=%cl_device 2>&1
// From groups/CPUoccupancy.lst: status: , errorcode: , message: 
