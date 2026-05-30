__kernel void GlobalMergeSort(__global int *sequence,
							  unsigned int sequenceSize,
							  //unsigned int sequenceSize_log,
							  unsigned int orderedSequenceSize,
							  unsigned int orderedSequenceSize_log,
							  unsigned int contextNumber)
{
	const int local_id = get_local_id(0);
	const int group_id = get_group_id(0);
	const int work_size = get_local_size(0);

	const int group_count = convert_int(orderedSequenceSize)/convert_int(work_size);
	const int bufferOffset = orderedSequenceSize*group_id;
	const int step = orderedSequenceSize_log + 1;

	for (int substep=0; substep<step; ++substep)
	{
		const int distance = 1 << step-substep-1;

		for (int it=0; it<group_count; ++it)
		{

			int id =  it*work_size + local_id;
			int start_index = bufferOffset*2 + (id >> (step-substep-1))*distance + id;

			int direction_id = id + orderedSequenceSize*group_id; //work_size*group_count*contextNumber;
			int direction = (direction_id >> step - 2 & 2) - 1;

			int val1 = sequence[start_index];
			int val2 = sequence[start_index+distance];
			int swap = (val2-val1)*direction;

			if (swap>0)
			{
				sequence[start_index] = val2;
				sequence[start_index+distance] = val1;
			}
		}

		barrier(CLK_GLOBAL_MEM_FENCE);
	}
}

__kernel void LocalMergeSort(__global int *g,
						     unsigned int sequenceSize,
							 unsigned int itCount,
							 unsigned int logSequenceSize,
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

	barrier(CLK_GLOBAL_MEM_FENCE);

	for (int step=1; step<=logSequenceSize; ++step)
	{
		for (int substep=0; substep<step; ++substep)
		{
			const int distance = 1 << step-substep-1;

			int id = local_id;
			int direction_id = local_id + index_offset;

			for (int it=0; it<itCount; ++it)
			{
				int start_index = (id >> (step-substep-1))*distance + id;
				int direction = (step==1) ? (direction_id << 1) : (direction_id >> (step-2));

				int val1 = l[start_index];
				int val2 = l[start_index+distance];
				int swap = (val2-val1)*((direction & 2) - 1);

				if (swap>0)
				{
					l[start_index] = val2;
					l[start_index+distance] = val1;
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
