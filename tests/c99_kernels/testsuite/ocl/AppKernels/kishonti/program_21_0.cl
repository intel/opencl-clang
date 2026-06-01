__kernel void GlobalMergeSort(__global int *sequence,
							  const int sequenceSize,
							  const int step,
							  const int substep )
{
	const int global_id = get_global_id(0);

	const int distance = 1 << step-substep;
	const int direction = (global_id >> step - 1 & 2) - 1;
	const int first_index = (global_id >> (step-substep))*distance + global_id;
	const int second_index = first_index + distance;

	const int val1 = sequence[first_index];
	const int val2 = sequence[second_index];
	const int swap = (val2-val1)*direction;

	if (swap>0)
	{
		sequence[first_index] = val2;
		sequence[second_index] = val1;
	}
}

__kernel void GlobalMergeSortStep(__global int *sequence,
								  const int sequenceSize,
								  const int orderedSequenceSize,
								  const int orderedSequenceSize_log )
{
	const int local_id = get_local_id(0);
	const int group_id = get_group_id(0);
	const int work_size = get_local_size(0);

	const int group_count = orderedSequenceSize/work_size;
	const int bufferOffset = orderedSequenceSize*group_id;
	const int step = orderedSequenceSize_log + 1;

	const int group_start_index = orderedSequenceSize*group_id;

	for (int substep=0; substep<step; ++substep)
	{
		const int distance = 1 << step-substep-1;

		for (int it=0; it<group_count; ++it)
		{
			const int id =  it*work_size + local_id;
			const int first_index = bufferOffset*2 + (id >> (step-substep-1))*distance + id;
			const int second_index = first_index+distance;

			const int direction = ((id + group_start_index) >> step - 2 & 2) - 1;

			int val1 = sequence[first_index];
			int val2 = sequence[second_index];
			int swap = (val2-val1)*direction;

			if (swap>0)
			{
				sequence[first_index] = val2;
				sequence[second_index] = val1;
			}
		}

		barrier(CLK_GLOBAL_MEM_FENCE);
	}
}

__kernel void LocalMergeSort(__global int *g,
						     int sequenceSize,
							 int itCount,
							 int logSequenceSize,
							 __local int *l )
{
	const int local_id = get_local_id(0);
	const int group_id = get_group_id(0);

	const int lSize = get_local_size(0);

	const int buffer_offset = sequenceSize*group_id;
	const int index_offset = buffer_offset >> 1;

	int lIndex = local_id;
	int gIndex = buffer_offset + local_id;
	for (int i=0; i<2*itCount; ++i)
	{
		l[lIndex] = g[gIndex];

		lIndex += lSize;
		gIndex += lSize;
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	for (int step=1; step<=logSequenceSize; ++step)
	{
		for (int substep=0; substep<step; ++substep)
		{
			const int distance = 1 << step-substep-1;

			int id = local_id;
			int direction_id = local_id + index_offset;

			for (int it=0; it<itCount; ++it)
			{
				const int first_index = (id >> (step-substep-1))*distance + id;
				const int second_index = first_index + distance;

				const int direction = (step==1) ? (direction_id << 1) : (direction_id >> (step-2));

				int val1 = l[first_index];
				int val2 = l[second_index];
				int swap = (val2-val1)*((direction & 2) - 1);

				if (swap>0)
				{
					l[first_index] = val2;
					l[second_index] = val1;
				}

				id += lSize;
				direction_id += lSize;
			}

			barrier(CLK_LOCAL_MEM_FENCE);
		}
	}

	lIndex = local_id;
	gIndex = buffer_offset + local_id;
	for (int i=0; i<2*itCount; ++i)
	{
		g[gIndex] = l[lIndex];

		lIndex += lSize;
		gIndex += lSize;
	}
}



// buildOptions=-cl-std=CL1.1
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-std=CL1.1" %cfg_path --cl-device=%cl_device 2>&1
