
/* 1=2-1 */
__kernel void
test_arg_1_1_kern(
	__global int* a0,
	__global int* b0
)
{
	uint gtid = get_global_id(0);
	int tmp0 = a0[gtid] + 0;
	b0[gtid] = (0+1)*(+tmp0);
}

/* 2=3-1 */
__kernel void
test_arg_1_2_kern(
	__global int* a0,
	__global int* b0,
	__global int* b1
)
{
	uint gtid = get_global_id(0);
	int tmp0 = a0[gtid] + 0;
	b0[gtid] = (0+1)*(+tmp0);
	b1[gtid] = (1+1)*(+tmp0);
}

/* 1=3-2 */
__kernel void
test_arg_2_1_kern(
	__global int* a0,
	__global int* a1,
	__global int* b0
)
{
	uint gtid = get_global_id(0);
	int tmp0 = a0[gtid] + 0;
	int tmp1 = a1[gtid] + 1;
	b0[gtid] = (0+1)*(+tmp0+tmp1);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
