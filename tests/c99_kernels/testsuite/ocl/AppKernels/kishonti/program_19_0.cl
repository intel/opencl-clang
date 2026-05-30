__kernel void AtomicLocalSum(	__global const uint *restrict sequence,
								__global uint *sum)
{
	const uint	group_id = get_group_id(0),
				global_id = get_global_id(0),
				local_id = get_local_id(0);

	__local uint counter;
	if(local_id == 0)
	{
		counter = 0;
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	atomic_add(&counter, sequence[global_id]);
	barrier(CLK_LOCAL_MEM_FENCE);

	if(local_id == 0)
	{
		sum[group_id] = counter;
	}
}


// buildOptions=-cl-std=CL1.1
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-std=CL1.1" %cfg_path --cl-device=%cl_device 2>&1
