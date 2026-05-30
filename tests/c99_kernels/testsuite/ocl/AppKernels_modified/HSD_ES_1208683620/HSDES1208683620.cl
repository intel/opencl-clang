__kernel void Add(__global int* pA, __global int* pB, __global int* pC)
{
const int x = get_global_id(0);
const int y = get_global_id(1);
const int width = get_global_size(0);

const int id = y * width + x;

pC[id] = pA[id] + pB[id];

if (x == 0 && y == 0) {
__private char states[10];
for (int i = 0; i < 10; i++)
states[i] = 0;

//states[6] = 0;
states[7] = (char)(8);

for (int i = 0; i < 10; i++)
printf("states[%i] = %p = %i\n", i, &states[i], states[i]);
return;
}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
