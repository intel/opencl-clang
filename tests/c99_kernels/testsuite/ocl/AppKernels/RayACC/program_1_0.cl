
kernel
__attribute__((reqd_work_group_size(8, 1, 1)))
void clearKernel(global float4* buffer, int count) {
	int index = get_global_id(0);

	if (index >= count)
		return;

	buffer[index] = (float4){ 0.0f, 0.0f, 0.0f, 0.0f };
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
