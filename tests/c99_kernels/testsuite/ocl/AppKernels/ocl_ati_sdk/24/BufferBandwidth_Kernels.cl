#pragma OPENCL EXTENSION cl_khr_local_int32_base_atomics : enable

__kernel void readKernel(volatile __global uint4 *in,
                         volatile __global uint  *out,
                         uint ni,
                         uint val,
                         uint nk)
{
    uint pcount = 0;
    __local uint lcount;
    uint i, idx;

   if(get_local_id(0) == 0)
      lcount = 0;

   barrier(CLK_LOCAL_MEM_FENCE);

   for(int n = 0; n < nk; n++)
   {
      for(i = 0, idx = get_global_id(0); i < ni; i++, idx += get_global_size(0))
      {
         if(in[idx].x == val)
             pcount++;
         if(in[idx].y == val)
             pcount++;
         if(in[idx].z == val)
             pcount++;
         if(in[idx].w == val)
             pcount++;
      }
   }

   (void)atomic_add(&lcount, pcount);

   barrier(CLK_LOCAL_MEM_FENCE);

   if(get_local_id(0) == 0)
      out[get_group_id(0)] = lcount / nk;

   if(get_global_id(0) == 0)
      out[get_num_groups(0) + 1] = val;

}

__kernel void writeKernel(volatile __global uint *in,
                          volatile __global uint4 *out,
                          uint ni,
                          uint val,
                          uint nk)
{
    uint4 pval;
    __local uint  lval;
    uint i, idx;

   if(get_local_id(0) == 0)
      lval = in[get_num_groups(0) + 1];

   barrier( CLK_LOCAL_MEM_FENCE );

   pval = (uint4)(lval, lval, lval, lval);

   for(int n = 0; n < nk; n++)
   {
      for(i = 0, idx = get_global_id(0); i < ni; i++, idx += get_global_size(0))
      {
         out[idx] = pval;
      }
   }
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
