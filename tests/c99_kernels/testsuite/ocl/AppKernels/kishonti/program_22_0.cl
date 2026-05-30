typedef struct
{
	int val;
	int parent;
	int child_idx;
	int child[3];
} node;

__kernel void depthFirstSearch(	__global node *tree,
								__global const int * restrict searched_values,
								__global int *indexes)
{
	const size_t id = get_global_id(0);
	const int searched_value = searched_values[id];

	node n = tree[0];
	uint idx = 0;
	while(n.val != searched_value)
	{
		if (n.child[0] != -1)
		{
			idx = n.child[0];
			n = tree[idx];
		} else
		{
			int child_idx;
			do
			{
				child_idx = n.child_idx;
				idx = n.parent;
				n = tree[idx];
			} while (!(child_idx != 2 && n.child[child_idx + 1] != -1) && n.parent != -1);

			if (n.parent == -1 && (child_idx == 2 || n.child[child_idx + 1] == -1))
			{
				indexes[id] = -1;
				return;
			}

			idx = n.child[child_idx + 1];
			n = tree[idx];
		}
	}

	indexes[id] = idx;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
