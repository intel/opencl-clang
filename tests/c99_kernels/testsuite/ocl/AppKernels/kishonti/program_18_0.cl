__kernel void AtomicGlobalSum( __global const uint *restrict sequence,
								__global uint *sum)
{
	const uint global_id = get_global_id(0);

	atomic_add(sum, sequence[global_id]);
}


// buildOptions=-cl-std=CL1.1
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-std=CL1.1" %cfg_path --cl-device=%cl_device 2>&1
