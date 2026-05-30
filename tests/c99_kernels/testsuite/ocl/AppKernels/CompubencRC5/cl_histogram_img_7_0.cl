__kernel
void histClear(
	__global uint* restrict gCDF
)
{
	uint idX = get_global_id(0);
	gCDF[idX] = 0;
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
