__kernel void SequentialScan(__global uint *sequence,
							 __global uint *partialSums,
							 uint subSequenceSize)
{
	const uint 	global_id = get_global_id(0),
		 	start_index = global_id*subSequenceSize,
		 	end_index = start_index + subSequenceSize;
	const uint prec_end_index = end_index - 1;

	for (uint i = start_index; i < prec_end_index; ++i)
	{
		sequence[i+1] += sequence[i];
	}

	partialSums[global_id] = sequence[prec_end_index];
}

__kernel void FinalSum(__global uint *sequence,
					   __global uint *partialSums,
					   uint subSequenceSize)
{
	uint partial_sum = 0,
		 global_id = get_global_id(0),
		 start_index = global_id*subSequenceSize,
		 end_index = start_index+subSequenceSize;

	for (int i=0; i<global_id; ++i)
	{
		partial_sum += partialSums[i];
	}

	for (int i=start_index; i<end_index; ++i)
	{
		sequence[i] += partial_sum;
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
