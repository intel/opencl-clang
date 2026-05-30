__kernel void boxFilter( __global const  uint *usSource, __global uint *usDest,
						  int pitch_x, int pitch_y, int size_x, int size_y, int d, int r)
{
	__global const uint *id = usSource + get_global_id(1) * pitch_y + get_global_id(0);
	__global uint *od = usDest + get_global_id(1) * pitch_y + get_global_id(0);

	if (get_global_id(1) < size_y && get_global_id(0) < d) {
		uint t;
		// do left edge
		t = id[0] * r;
		for (int x = 0; x < r + 1; x++) {
			t += id[x * pitch_x];
		}
		od[0] = t;

		for(int x = 1; x < r + 1; x++) {
			t += id[(x + r) * pitch_x];
			t -= id[0];
			od[x * pitch_x] = t;
		}

		// main loop
		for(int x = r + 1; x < size_x - r; x++) {
			t += id[(x + r) * pitch_x];
			t -= id[(x - r - 1) * pitch_x];
			od[x * pitch_x] = t;
		}

		// do right edge
		for (int x = size_x - r; x < size_x; x++) {
			t += id[(size_x - 1) * pitch_x];
			t -= id[(x - r - 1) * pitch_x];
			od[x * pitch_x] = t;
		}
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
