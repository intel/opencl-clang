__kernel void memzero(__global uint *sum, int size)
{
	int nchunks = (size + get_global_size(0) - 1) / get_global_size(0);
	int id = get_global_id(0);
	for (int k = 0; k < nchunks; k++) {
		if (id < size)
			sum[id] = 0;
		id += get_global_size(0);
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
