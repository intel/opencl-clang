
//#pragma OPENCL EXTENSION cl_amd_printf : enable

// The number of threads to use for triangle generation (limited by shared memory size)
#define NTHREADS 32

// volume data
__constant sampler_t volumeSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

__constant int triTable[256][16] =
{{-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{0, 8, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{0, 1, 9, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{1, 8, 3, 9, 8, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{1, 2, 10, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{0, 8, 3, 1, 2, 10, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{9, 2, 10, 0, 2, 9, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{2, 8, 3, 2, 10, 8, 10, 9, 8, -1, -1, -1, -1, -1, -1, -1},
{3, 11, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{0, 11, 2, 8, 11, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{1, 9, 0, 2, 3, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{1, 11, 2, 1, 9, 11, 9, 8, 11, -1, -1, -1, -1, -1, -1, -1},
{3, 10, 1, 11, 10, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{0, 10, 1, 0, 8, 10, 8, 11, 10, -1, -1, -1, -1, -1, -1, -1},
{3, 9, 0, 3, 11, 9, 11, 10, 9, -1, -1, -1, -1, -1, -1, -1},
{9, 8, 10, 10, 8, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{4, 7, 8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{4, 3, 0, 7, 3, 4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{0, 1, 9, 8, 4, 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{4, 1, 9, 4, 7, 1, 7, 3, 1, -1, -1, -1, -1, -1, -1, -1},
{1, 2, 10, 8, 4, 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{3, 4, 7, 3, 0, 4, 1, 2, 10, -1, -1, -1, -1, -1, -1, -1},
{9, 2, 10, 9, 0, 2, 8, 4, 7, -1, -1, -1, -1, -1, -1, -1},
{2, 10, 9, 2, 9, 7, 2, 7, 3, 7, 9, 4, -1, -1, -1, -1},
{8, 4, 7, 3, 11, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{11, 4, 7, 11, 2, 4, 2, 0, 4, -1, -1, -1, -1, -1, -1, -1},
{9, 0, 1, 8, 4, 7, 2, 3, 11, -1, -1, -1, -1, -1, -1, -1},
{4, 7, 11, 9, 4, 11, 9, 11, 2, 9, 2, 1, -1, -1, -1, -1},
{3, 10, 1, 3, 11, 10, 7, 8, 4, -1, -1, -1, -1, -1, -1, -1},
{1, 11, 10, 1, 4, 11, 1, 0, 4, 7, 11, 4, -1, -1, -1, -1},
{4, 7, 8, 9, 0, 11, 9, 11, 10, 11, 0, 3, -1, -1, -1, -1},
{4, 7, 11, 4, 11, 9, 9, 11, 10, -1, -1, -1, -1, -1, -1, -1},
{9, 5, 4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{9, 5, 4, 0, 8, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{0, 5, 4, 1, 5, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{8, 5, 4, 8, 3, 5, 3, 1, 5, -1, -1, -1, -1, -1, -1, -1},
{1, 2, 10, 9, 5, 4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{3, 0, 8, 1, 2, 10, 4, 9, 5, -1, -1, -1, -1, -1, -1, -1},
{5, 2, 10, 5, 4, 2, 4, 0, 2, -1, -1, -1, -1, -1, -1, -1},
{2, 10, 5, 3, 2, 5, 3, 5, 4, 3, 4, 8, -1, -1, -1, -1},
{9, 5, 4, 2, 3, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{0, 11, 2, 0, 8, 11, 4, 9, 5, -1, -1, -1, -1, -1, -1, -1},
{0, 5, 4, 0, 1, 5, 2, 3, 11, -1, -1, -1, -1, -1, -1, -1},
{2, 1, 5, 2, 5, 8, 2, 8, 11, 4, 8, 5, -1, -1, -1, -1},
{10, 3, 11, 10, 1, 3, 9, 5, 4, -1, -1, -1, -1, -1, -1, -1},
{4, 9, 5, 0, 8, 1, 8, 10, 1, 8, 11, 10, -1, -1, -1, -1},
{5, 4, 0, 5, 0, 11, 5, 11, 10, 11, 0, 3, -1, -1, -1, -1},
{5, 4, 8, 5, 8, 10, 10, 8, 11, -1, -1, -1, -1, -1, -1, -1},
{9, 7, 8, 5, 7, 9, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{9, 3, 0, 9, 5, 3, 5, 7, 3, -1, -1, -1, -1, -1, -1, -1},
{0, 7, 8, 0, 1, 7, 1, 5, 7, -1, -1, -1, -1, -1, -1, -1},
{1, 5, 3, 3, 5, 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{9, 7, 8, 9, 5, 7, 10, 1, 2, -1, -1, -1, -1, -1, -1, -1},
{10, 1, 2, 9, 5, 0, 5, 3, 0, 5, 7, 3, -1, -1, -1, -1},
{8, 0, 2, 8, 2, 5, 8, 5, 7, 10, 5, 2, -1, -1, -1, -1},
{2, 10, 5, 2, 5, 3, 3, 5, 7, -1, -1, -1, -1, -1, -1, -1},
{7, 9, 5, 7, 8, 9, 3, 11, 2, -1, -1, -1, -1, -1, -1, -1},
{9, 5, 7, 9, 7, 2, 9, 2, 0, 2, 7, 11, -1, -1, -1, -1},
{2, 3, 11, 0, 1, 8, 1, 7, 8, 1, 5, 7, -1, -1, -1, -1},
{11, 2, 1, 11, 1, 7, 7, 1, 5, -1, -1, -1, -1, -1, -1, -1},
{9, 5, 8, 8, 5, 7, 10, 1, 3, 10, 3, 11, -1, -1, -1, -1},
{5, 7, 0, 5, 0, 9, 7, 11, 0, 1, 0, 10, 11, 10, 0, -1},
{11, 10, 0, 11, 0, 3, 10, 5, 0, 8, 0, 7, 5, 7, 0, -1},
{11, 10, 5, 7, 11, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{10, 6, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{0, 8, 3, 5, 10, 6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{9, 0, 1, 5, 10, 6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{1, 8, 3, 1, 9, 8, 5, 10, 6, -1, -1, -1, -1, -1, -1, -1},
{1, 6, 5, 2, 6, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{1, 6, 5, 1, 2, 6, 3, 0, 8, -1, -1, -1, -1, -1, -1, -1},
{9, 6, 5, 9, 0, 6, 0, 2, 6, -1, -1, -1, -1, -1, -1, -1},
{5, 9, 8, 5, 8, 2, 5, 2, 6, 3, 2, 8, -1, -1, -1, -1},
{2, 3, 11, 10, 6, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{11, 0, 8, 11, 2, 0, 10, 6, 5, -1, -1, -1, -1, -1, -1, -1},
{0, 1, 9, 2, 3, 11, 5, 10, 6, -1, -1, -1, -1, -1, -1, -1},
{5, 10, 6, 1, 9, 2, 9, 11, 2, 9, 8, 11, -1, -1, -1, -1},
{6, 3, 11, 6, 5, 3, 5, 1, 3, -1, -1, -1, -1, -1, -1, -1},
{0, 8, 11, 0, 11, 5, 0, 5, 1, 5, 11, 6, -1, -1, -1, -1},
{3, 11, 6, 0, 3, 6, 0, 6, 5, 0, 5, 9, -1, -1, -1, -1},
{6, 5, 9, 6, 9, 11, 11, 9, 8, -1, -1, -1, -1, -1, -1, -1},
{5, 10, 6, 4, 7, 8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{4, 3, 0, 4, 7, 3, 6, 5, 10, -1, -1, -1, -1, -1, -1, -1},
{1, 9, 0, 5, 10, 6, 8, 4, 7, -1, -1, -1, -1, -1, -1, -1},
{10, 6, 5, 1, 9, 7, 1, 7, 3, 7, 9, 4, -1, -1, -1, -1},
{6, 1, 2, 6, 5, 1, 4, 7, 8, -1, -1, -1, -1, -1, -1, -1},
{1, 2, 5, 5, 2, 6, 3, 0, 4, 3, 4, 7, -1, -1, -1, -1},
{8, 4, 7, 9, 0, 5, 0, 6, 5, 0, 2, 6, -1, -1, -1, -1},
{7, 3, 9, 7, 9, 4, 3, 2, 9, 5, 9, 6, 2, 6, 9, -1},
{3, 11, 2, 7, 8, 4, 10, 6, 5, -1, -1, -1, -1, -1, -1, -1},
{5, 10, 6, 4, 7, 2, 4, 2, 0, 2, 7, 11, -1, -1, -1, -1},
{0, 1, 9, 4, 7, 8, 2, 3, 11, 5, 10, 6, -1, -1, -1, -1},
{9, 2, 1, 9, 11, 2, 9, 4, 11, 7, 11, 4, 5, 10, 6, -1},
{8, 4, 7, 3, 11, 5, 3, 5, 1, 5, 11, 6, -1, -1, -1, -1},
{5, 1, 11, 5, 11, 6, 1, 0, 11, 7, 11, 4, 0, 4, 11, -1},
{0, 5, 9, 0, 6, 5, 0, 3, 6, 11, 6, 3, 8, 4, 7, -1},
{6, 5, 9, 6, 9, 11, 4, 7, 9, 7, 11, 9, -1, -1, -1, -1},
{10, 4, 9, 6, 4, 10, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{4, 10, 6, 4, 9, 10, 0, 8, 3, -1, -1, -1, -1, -1, -1, -1},
{10, 0, 1, 10, 6, 0, 6, 4, 0, -1, -1, -1, -1, -1, -1, -1},
{8, 3, 1, 8, 1, 6, 8, 6, 4, 6, 1, 10, -1, -1, -1, -1},
{1, 4, 9, 1, 2, 4, 2, 6, 4, -1, -1, -1, -1, -1, -1, -1},
{3, 0, 8, 1, 2, 9, 2, 4, 9, 2, 6, 4, -1, -1, -1, -1},
{0, 2, 4, 4, 2, 6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{8, 3, 2, 8, 2, 4, 4, 2, 6, -1, -1, -1, -1, -1, -1, -1},
{10, 4, 9, 10, 6, 4, 11, 2, 3, -1, -1, -1, -1, -1, -1, -1},
{0, 8, 2, 2, 8, 11, 4, 9, 10, 4, 10, 6, -1, -1, -1, -1},
{3, 11, 2, 0, 1, 6, 0, 6, 4, 6, 1, 10, -1, -1, -1, -1},
{6, 4, 1, 6, 1, 10, 4, 8, 1, 2, 1, 11, 8, 11, 1, -1},
{9, 6, 4, 9, 3, 6, 9, 1, 3, 11, 6, 3, -1, -1, -1, -1},
{8, 11, 1, 8, 1, 0, 11, 6, 1, 9, 1, 4, 6, 4, 1, -1},
{3, 11, 6, 3, 6, 0, 0, 6, 4, -1, -1, -1, -1, -1, -1, -1},
{6, 4, 8, 11, 6, 8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{7, 10, 6, 7, 8, 10, 8, 9, 10, -1, -1, -1, -1, -1, -1, -1},
{0, 7, 3, 0, 10, 7, 0, 9, 10, 6, 7, 10, -1, -1, -1, -1},
{10, 6, 7, 1, 10, 7, 1, 7, 8, 1, 8, 0, -1, -1, -1, -1},
{10, 6, 7, 10, 7, 1, 1, 7, 3, -1, -1, -1, -1, -1, -1, -1},
{1, 2, 6, 1, 6, 8, 1, 8, 9, 8, 6, 7, -1, -1, -1, -1},
{2, 6, 9, 2, 9, 1, 6, 7, 9, 0, 9, 3, 7, 3, 9, -1},
{7, 8, 0, 7, 0, 6, 6, 0, 2, -1, -1, -1, -1, -1, -1, -1},
{7, 3, 2, 6, 7, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{2, 3, 11, 10, 6, 8, 10, 8, 9, 8, 6, 7, -1, -1, -1, -1},
{2, 0, 7, 2, 7, 11, 0, 9, 7, 6, 7, 10, 9, 10, 7, -1},
{1, 8, 0, 1, 7, 8, 1, 10, 7, 6, 7, 10, 2, 3, 11, -1},
{11, 2, 1, 11, 1, 7, 10, 6, 1, 6, 7, 1, -1, -1, -1, -1},
{8, 9, 6, 8, 6, 7, 9, 1, 6, 11, 6, 3, 1, 3, 6, -1},
{0, 9, 1, 11, 6, 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{7, 8, 0, 7, 0, 6, 3, 11, 0, 11, 6, 0, -1, -1, -1, -1},
{7, 11, 6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{7, 6, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{3, 0, 8, 11, 7, 6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{0, 1, 9, 11, 7, 6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{8, 1, 9, 8, 3, 1, 11, 7, 6, -1, -1, -1, -1, -1, -1, -1},
{10, 1, 2, 6, 11, 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{1, 2, 10, 3, 0, 8, 6, 11, 7, -1, -1, -1, -1, -1, -1, -1},
{2, 9, 0, 2, 10, 9, 6, 11, 7, -1, -1, -1, -1, -1, -1, -1},
{6, 11, 7, 2, 10, 3, 10, 8, 3, 10, 9, 8, -1, -1, -1, -1},
{7, 2, 3, 6, 2, 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{7, 0, 8, 7, 6, 0, 6, 2, 0, -1, -1, -1, -1, -1, -1, -1},
{2, 7, 6, 2, 3, 7, 0, 1, 9, -1, -1, -1, -1, -1, -1, -1},
{1, 6, 2, 1, 8, 6, 1, 9, 8, 8, 7, 6, -1, -1, -1, -1},
{10, 7, 6, 10, 1, 7, 1, 3, 7, -1, -1, -1, -1, -1, -1, -1},
{10, 7, 6, 1, 7, 10, 1, 8, 7, 1, 0, 8, -1, -1, -1, -1},
{0, 3, 7, 0, 7, 10, 0, 10, 9, 6, 10, 7, -1, -1, -1, -1},
{7, 6, 10, 7, 10, 8, 8, 10, 9, -1, -1, -1, -1, -1, -1, -1},
{6, 8, 4, 11, 8, 6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{3, 6, 11, 3, 0, 6, 0, 4, 6, -1, -1, -1, -1, -1, -1, -1},
{8, 6, 11, 8, 4, 6, 9, 0, 1, -1, -1, -1, -1, -1, -1, -1},
{9, 4, 6, 9, 6, 3, 9, 3, 1, 11, 3, 6, -1, -1, -1, -1},
{6, 8, 4, 6, 11, 8, 2, 10, 1, -1, -1, -1, -1, -1, -1, -1},
{1, 2, 10, 3, 0, 11, 0, 6, 11, 0, 4, 6, -1, -1, -1, -1},
{4, 11, 8, 4, 6, 11, 0, 2, 9, 2, 10, 9, -1, -1, -1, -1},
{10, 9, 3, 10, 3, 2, 9, 4, 3, 11, 3, 6, 4, 6, 3, -1},
{8, 2, 3, 8, 4, 2, 4, 6, 2, -1, -1, -1, -1, -1, -1, -1},
{0, 4, 2, 4, 6, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{1, 9, 0, 2, 3, 4, 2, 4, 6, 4, 3, 8, -1, -1, -1, -1},
{1, 9, 4, 1, 4, 2, 2, 4, 6, -1, -1, -1, -1, -1, -1, -1},
{8, 1, 3, 8, 6, 1, 8, 4, 6, 6, 10, 1, -1, -1, -1, -1},
{10, 1, 0, 10, 0, 6, 6, 0, 4, -1, -1, -1, -1, -1, -1, -1},
{4, 6, 3, 4, 3, 8, 6, 10, 3, 0, 3, 9, 10, 9, 3, -1},
{10, 9, 4, 6, 10, 4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{4, 9, 5, 7, 6, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{0, 8, 3, 4, 9, 5, 11, 7, 6, -1, -1, -1, -1, -1, -1, -1},
{5, 0, 1, 5, 4, 0, 7, 6, 11, -1, -1, -1, -1, -1, -1, -1},
{11, 7, 6, 8, 3, 4, 3, 5, 4, 3, 1, 5, -1, -1, -1, -1},
{9, 5, 4, 10, 1, 2, 7, 6, 11, -1, -1, -1, -1, -1, -1, -1},
{6, 11, 7, 1, 2, 10, 0, 8, 3, 4, 9, 5, -1, -1, -1, -1},
{7, 6, 11, 5, 4, 10, 4, 2, 10, 4, 0, 2, -1, -1, -1, -1},
{3, 4, 8, 3, 5, 4, 3, 2, 5, 10, 5, 2, 11, 7, 6, -1},
{7, 2, 3, 7, 6, 2, 5, 4, 9, -1, -1, -1, -1, -1, -1, -1},
{9, 5, 4, 0, 8, 6, 0, 6, 2, 6, 8, 7, -1, -1, -1, -1},
{3, 6, 2, 3, 7, 6, 1, 5, 0, 5, 4, 0, -1, -1, -1, -1},
{6, 2, 8, 6, 8, 7, 2, 1, 8, 4, 8, 5, 1, 5, 8, -1},
{9, 5, 4, 10, 1, 6, 1, 7, 6, 1, 3, 7, -1, -1, -1, -1},
{1, 6, 10, 1, 7, 6, 1, 0, 7, 8, 7, 0, 9, 5, 4, -1},
{4, 0, 10, 4, 10, 5, 0, 3, 10, 6, 10, 7, 3, 7, 10, -1},
{7, 6, 10, 7, 10, 8, 5, 4, 10, 4, 8, 10, -1, -1, -1, -1},
{6, 9, 5, 6, 11, 9, 11, 8, 9, -1, -1, -1, -1, -1, -1, -1},
{3, 6, 11, 0, 6, 3, 0, 5, 6, 0, 9, 5, -1, -1, -1, -1},
{0, 11, 8, 0, 5, 11, 0, 1, 5, 5, 6, 11, -1, -1, -1, -1},
{6, 11, 3, 6, 3, 5, 5, 3, 1, -1, -1, -1, -1, -1, -1, -1},
{1, 2, 10, 9, 5, 11, 9, 11, 8, 11, 5, 6, -1, -1, -1, -1},
{0, 11, 3, 0, 6, 11, 0, 9, 6, 5, 6, 9, 1, 2, 10, -1},
{11, 8, 5, 11, 5, 6, 8, 0, 5, 10, 5, 2, 0, 2, 5, -1},
{6, 11, 3, 6, 3, 5, 2, 10, 3, 10, 5, 3, -1, -1, -1, -1},
{5, 8, 9, 5, 2, 8, 5, 6, 2, 3, 8, 2, -1, -1, -1, -1},
{9, 5, 6, 9, 6, 0, 0, 6, 2, -1, -1, -1, -1, -1, -1, -1},
{1, 5, 8, 1, 8, 0, 5, 6, 8, 3, 8, 2, 6, 2, 8, -1},
{1, 5, 6, 2, 1, 6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{1, 3, 6, 1, 6, 10, 3, 8, 6, 5, 6, 9, 8, 9, 6, -1},
{10, 1, 0, 10, 0, 6, 9, 5, 0, 5, 6, 0, -1, -1, -1, -1},
{0, 3, 8, 5, 6, 10, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{10, 5, 6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{11, 5, 10, 7, 5, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{11, 5, 10, 11, 7, 5, 8, 3, 0, -1, -1, -1, -1, -1, -1, -1},
{5, 11, 7, 5, 10, 11, 1, 9, 0, -1, -1, -1, -1, -1, -1, -1},
{10, 7, 5, 10, 11, 7, 9, 8, 1, 8, 3, 1, -1, -1, -1, -1},
{11, 1, 2, 11, 7, 1, 7, 5, 1, -1, -1, -1, -1, -1, -1, -1},
{0, 8, 3, 1, 2, 7, 1, 7, 5, 7, 2, 11, -1, -1, -1, -1},
{9, 7, 5, 9, 2, 7, 9, 0, 2, 2, 11, 7, -1, -1, -1, -1},
{7, 5, 2, 7, 2, 11, 5, 9, 2, 3, 2, 8, 9, 8, 2, -1},
{2, 5, 10, 2, 3, 5, 3, 7, 5, -1, -1, -1, -1, -1, -1, -1},
{8, 2, 0, 8, 5, 2, 8, 7, 5, 10, 2, 5, -1, -1, -1, -1},
{9, 0, 1, 5, 10, 3, 5, 3, 7, 3, 10, 2, -1, -1, -1, -1},
{9, 8, 2, 9, 2, 1, 8, 7, 2, 10, 2, 5, 7, 5, 2, -1},
{1, 3, 5, 3, 7, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{0, 8, 7, 0, 7, 1, 1, 7, 5, -1, -1, -1, -1, -1, -1, -1},
{9, 0, 3, 9, 3, 5, 5, 3, 7, -1, -1, -1, -1, -1, -1, -1},
{9, 8, 7, 5, 9, 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{5, 8, 4, 5, 10, 8, 10, 11, 8, -1, -1, -1, -1, -1, -1, -1},
{5, 0, 4, 5, 11, 0, 5, 10, 11, 11, 3, 0, -1, -1, -1, -1},
{0, 1, 9, 8, 4, 10, 8, 10, 11, 10, 4, 5, -1, -1, -1, -1},
{10, 11, 4, 10, 4, 5, 11, 3, 4, 9, 4, 1, 3, 1, 4, -1},
{2, 5, 1, 2, 8, 5, 2, 11, 8, 4, 5, 8, -1, -1, -1, -1},
{0, 4, 11, 0, 11, 3, 4, 5, 11, 2, 11, 1, 5, 1, 11, -1},
{0, 2, 5, 0, 5, 9, 2, 11, 5, 4, 5, 8, 11, 8, 5, -1},
{9, 4, 5, 2, 11, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{2, 5, 10, 3, 5, 2, 3, 4, 5, 3, 8, 4, -1, -1, -1, -1},
{5, 10, 2, 5, 2, 4, 4, 2, 0, -1, -1, -1, -1, -1, -1, -1},
{3, 10, 2, 3, 5, 10, 3, 8, 5, 4, 5, 8, 0, 1, 9, -1},
{5, 10, 2, 5, 2, 4, 1, 9, 2, 9, 4, 2, -1, -1, -1, -1},
{8, 4, 5, 8, 5, 3, 3, 5, 1, -1, -1, -1, -1, -1, -1, -1},
{0, 4, 5, 1, 0, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{8, 4, 5, 8, 5, 3, 9, 0, 5, 0, 3, 5, -1, -1, -1, -1},
{9, 4, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{4, 11, 7, 4, 9, 11, 9, 10, 11, -1, -1, -1, -1, -1, -1, -1},
{0, 8, 3, 4, 9, 7, 9, 11, 7, 9, 10, 11, -1, -1, -1, -1},
{1, 10, 11, 1, 11, 4, 1, 4, 0, 7, 4, 11, -1, -1, -1, -1},
{3, 1, 4, 3, 4, 8, 1, 10, 4, 7, 4, 11, 10, 11, 4, -1},
{4, 11, 7, 9, 11, 4, 9, 2, 11, 9, 1, 2, -1, -1, -1, -1},
{9, 7, 4, 9, 11, 7, 9, 1, 11, 2, 11, 1, 0, 8, 3, -1},
{11, 7, 4, 11, 4, 2, 2, 4, 0, -1, -1, -1, -1, -1, -1, -1},
{11, 7, 4, 11, 4, 2, 8, 3, 4, 3, 2, 4, -1, -1, -1, -1},
{2, 9, 10, 2, 7, 9, 2, 3, 7, 7, 4, 9, -1, -1, -1, -1},
{9, 10, 7, 9, 7, 4, 10, 2, 7, 8, 7, 0, 2, 0, 7, -1},
{3, 7, 10, 3, 10, 2, 7, 4, 10, 1, 10, 0, 4, 0, 10, -1},
{1, 10, 2, 8, 7, 4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{4, 9, 1, 4, 1, 7, 7, 1, 3, -1, -1, -1, -1, -1, -1, -1},
{4, 9, 1, 4, 1, 7, 0, 8, 1, 8, 7, 1, -1, -1, -1, -1},
{4, 0, 3, 7, 4, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{4, 8, 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{9, 10, 8, 10, 11, 8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{3, 0, 9, 3, 9, 11, 11, 9, 10, -1, -1, -1, -1, -1, -1, -1},
{0, 1, 10, 0, 10, 8, 8, 10, 11, -1, -1, -1, -1, -1, -1, -1},
{3, 1, 10, 11, 3, 10, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{1, 2, 11, 1, 11, 9, 9, 11, 8, -1, -1, -1, -1, -1, -1, -1},
{3, 0, 9, 3, 9, 11, 1, 2, 9, 2, 11, 9, -1, -1, -1, -1},
{0, 2, 11, 8, 0, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{3, 2, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{2, 3, 8, 2, 8, 10, 10, 8, 9, -1, -1, -1, -1, -1, -1, -1},
{9, 10, 2, 0, 9, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{2, 3, 8, 2, 8, 10, 0, 1, 8, 1, 10, 8, -1, -1, -1, -1},
{1, 10, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{1, 3, 8, 9, 1, 8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{0, 9, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{0, 3, 8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
{-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1}};
__constant int numVertsTable[256] = {
    0,    3,    3,    6,    3,    6,    6,    9,    3,    6,    6,    9,    6,    9,    9,    6,
    3,    6,    6,    9,    6,    9,    9,    12,   6,    9,    9,    12,   9,    12,   12,   9,
    3,    6,    6,    9,    6,    9,    9,    12,   6,    9,    9,    12,   9,    12,   12,   9,
    6,    9,    9,    6,    9,    12,   12,   9,    9,    12,   12,   9,    12,   15,   15,   6,
    3,    6,    6,    9,    6,    9,    9,    12,   6,    9,    9,    12,   9,    12,   12,   9,
    6,    9,    9,    12,   9,    12,   12,   15,   9,    12,   12,   15,   12,   15,   15,   12,
    6,    9,    9,    12,   9,    12,   6,    9,    9,    12,   12,   15,   12,   15,   9,    6,
    9,    12,   12,   9,    12,   15,   9,    6,    12,   15,   15,   12,   15,   6,    12,   3,
    3,    6,    6,    9,    6,    9,    9,    12,   6,    9,    9,    12,   9,    12,   12,   9,
    6,    9,    9,    12,   9,    12,   12,   15,   9,    6,    12,   9,    12,   9,    15,   6,
    6,    9,    9,    12,   9,    12,   12,   15,   9,    12,   12,   15,   12,   15,   15,   12,
    9,    12,   12,   9,    12,   15,   15,   12,   12,   9,    15,   6,    15,   12,   6,    3,
    6,    9,    9,    12,   9,    12,   12,   15,   9,    12,   12,   15,   6,    9,    9,    6,
    9,    12,   12,   15,   12,   15,   15,   6,    12,   9,    15,   12,   9,    6,    12,   3,
    9,    12,   12,   15,   12,   15,   9,    12,   12,   15,   15,   6,    9,    12,   6,    3,
    6,    9,    9,    6,    9,    12,   6,    3,    9,    6,    12,   3,    6,    3,    3,    0,
};
__constant int edgeInfo[24] = {

    0,1,
    1,2,
    2,3,
    3,0,
    4,5,
    5,6,
    6,7,
    7,4,
    0,4,
    1,5,
    2,6,
    3,7,

};
__constant float weight0 = 0.98f;
__constant float weight1 = 0.02f;

// classify voxel based on number of vertices it will generate
// one thread per voxel
__kernel
void
classifyVoxel(__global uint* voxelVerts, __global uint *voxelOccupied, __read_only image3d_t volume,
              uint chunkSizeReal, uint4 chunkSizeShiftPlus, uint4 volumeChunkShiftPlus, uint4 volumeChunkMask,	//(5,10,15),(2,3,4),(2-1,1-1,1-1) if (7,6,6)
              float isoValue )
{
    // use 1 dim group(group[0] to sore chunk_id) to avoid wasting threads on null chunk
    // use group[1,2] to represent y,z of a chunk in order to avoid work_group_size exceeding 1024(CL_MAX_WORK_GROUP_SIZE)
    uint groupId = get_group_id(0);
    int4 localId = (int4)(	get_local_id(0),
    						get_global_id(1),
							get_global_id(2),
							0);
		int4 voxelOfs = (int4)(	((groupId)&volumeChunkMask.x),
							((groupId>>volumeChunkShiftPlus.x)&volumeChunkMask.y),
							((groupId>>volumeChunkShiftPlus.y)&volumeChunkMask.z),
							0);
		int4 voxelPos = (int4)(chunkSizeReal*voxelOfs.x+localId.x+1,
							chunkSizeReal*voxelOfs.y+localId.y+1,
							chunkSizeReal*voxelOfs.z+localId.z+1,
							0);	//voxelOfs*35+ofs

    // read field values at neighbouring grid vertices
    float field[8];
    	field[0] = read_imagef(volume, volumeSampler, voxelPos).x;
    	field[1] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 0, 0, 0)).x;
    	field[2] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 1, 0, 0)).x;
    	field[3] = read_imagef(volume, volumeSampler, voxelPos + (int4)(0, 1, 0, 0)).x;
    	field[4] = read_imagef(volume, volumeSampler, voxelPos + (int4)(0, 0, 1, 0)).x;
    	field[5] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 0, 1, 0)).x;
    	field[6] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 1, 1, 0)).x;
    	field[7] = read_imagef(volume, volumeSampler, voxelPos + (int4)(0, 1, 1, 0)).x;

    // calculate flag indicating if each vertex is inside or outside isosurface
    int cubeindex;
		cubeindex =  (field[0] < isoValue);
		cubeindex += (field[1] < isoValue)*2;
		cubeindex += (field[2] < isoValue)*4;
		cubeindex += (field[3] < isoValue)*8;
		cubeindex += (field[4] < isoValue)*16;
		cubeindex += (field[5] < isoValue)*32;
		cubeindex += (field[6] < isoValue)*64;
		cubeindex += (field[7] < isoValue)*128;

    // read number of vertices from texture
    uint numVerts = numVertsTable[cubeindex];

    uint i = (groupId<<chunkSizeShiftPlus.z) + (localId.z<<chunkSizeShiftPlus.y) + (localId.y<<chunkSizeShiftPlus.x) + localId.x;
    voxelVerts[i] = numVerts;
    voxelOccupied[i] = (numVerts > 0);
}

// compact voxel array
__kernel
void
compactVoxels(__global uint *compactedVoxelArray, __global uint *voxelOccupied, __global uint *voxelOccupiedScan, uint4 chunkSizeShiftPlus)
{
    uint i = (get_group_id(0)<<chunkSizeShiftPlus.z) + (get_global_id(2)<<chunkSizeShiftPlus.y) + (get_global_id(1)<<chunkSizeShiftPlus.x) + get_local_id(0);

    if (voxelOccupied[i]) {
        compactedVoxelArray[ voxelOccupiedScan[i] ] = i;
    }
}

// compute interpolated vertex along an edge
float4 vertexInterp(float isolevel, float4 p0, float4 p1, float f0, float f1)
{
    float t = (isolevel - f0) / (f1 - f0);
    //return mix(p0, p1, t);
    return p0 + (p1-p0)*t;
}

// calculate triangle normal
float4 calcNormal(float4 v0, float4 v1, float4 v2)
{
    float4 edge0 = v1 - v0;
    float4 edge1 = v2 - v0;
    // note - it's faster to perform normalization in vertex shader rather than here
    return cross(edge0, edge1);
}

// version that calculates flat surface normal for each triangle -- out an array of float
__kernel
void
generateTriangles2_vec3(__global float *pos, __global float *norm01, __global float *norm2t, __global uint *compactedVoxelArray, __global uint *numVertsScanned, __read_only image3d_t volume,
                   		uint chunkSizeReal, uint chunkSizeMask, uint4 chunkSizeShiftPlus, uint4 volumeChunkShiftPlus, uint4 volumeChunkMask,
			        				float isoValue, uint activeVoxels, uint maxVerts )
{
    uint i = get_global_id(0) + get_global_id(1)*get_global_size(0);
    uint tid = get_local_id(0);

    if (i >= activeVoxels) {
        i = activeVoxels - 1;
    }
    uint voxelId = compactedVoxelArray[i];
    uint groupId = voxelId>>chunkSizeShiftPlus.z;
    int4 localId = (int4)(	(voxelId)&chunkSizeMask,
							(voxelId>>chunkSizeShiftPlus.x)&chunkSizeMask,
							(voxelId>>chunkSizeShiftPlus.y)&chunkSizeMask,
							0);
    int4 voxelOfs = (int4)(	((groupId)&volumeChunkMask.x),
							((groupId>>volumeChunkShiftPlus.x)&volumeChunkMask.y),
							((groupId>>volumeChunkShiftPlus.y)&volumeChunkMask.z),
							0);
		int4 voxelPos = (int4)(chunkSizeReal*voxelOfs.x+localId.x+1,
							chunkSizeReal*voxelOfs.y+localId.y+1,
							chunkSizeReal*voxelOfs.z+localId.z+1,
							0);	//voxelOfs*35+ofs

    float4 p; // original ver has an offset of(-1,-1,-1)
    p.x = localId.x;
    p.y = localId.y;
    p.z = localId.z;
    p.w = 1.0f;

    // calculate cell vertex positions
    float4 v[8];
    v[0] = p;
    v[1] = p + (float4)(1, 0, 0,0);
    v[2] = p + (float4)(1, 1, 0,0);
    v[3] = p + (float4)(0, 1, 0,0);
    v[4] = p + (float4)(0, 0, 1,0);
    v[5] = p + (float4)(1, 0, 1,0);
    v[6] = p + (float4)(1, 1, 1,0);
    v[7] = p + (float4)(0, 1, 1,0);

    //0, 1, 5, 4, 3, 2, 6, 7

    float voxelType[8];
    voxelType[ 0] = read_imagef(volume, volumeSampler, voxelPos).y;
    voxelType[ 1] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 0, 0, 0)).y;
    voxelType[ 2] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 1, 0, 0)).y;
    voxelType[ 3] = read_imagef(volume, volumeSampler, voxelPos + (int4)(0, 1, 0, 0)).y;
    voxelType[ 4] = read_imagef(volume, volumeSampler, voxelPos + (int4)(0, 0, 1, 0)).y;
    voxelType[ 5] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 0, 1, 0)).y;
    voxelType[ 6] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 1, 1, 0)).y;
    voxelType[ 7] = read_imagef(volume, volumeSampler, voxelPos + (int4)(0, 1, 1, 0)).y;

    float field[32];
    field[ 0] = read_imagef(volume, volumeSampler, voxelPos).x;
    field[ 1] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 0, 0, 0)).x;
    field[ 2] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 1, 0, 0)).x;
    field[ 3] = read_imagef(volume, volumeSampler, voxelPos + (int4)(0, 1, 0, 0)).x;
    field[ 4] = read_imagef(volume, volumeSampler, voxelPos + (int4)(0, 0, 1, 0)).x;
    field[ 5] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 0, 1, 0)).x;
    field[ 6] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 1, 1, 0)).x;
    field[ 7] = read_imagef(volume, volumeSampler, voxelPos + (int4)(0, 1, 1, 0)).x;

		field[ 8] = read_imagef(volume, volumeSampler, voxelPos + (int4)(-1, 0, 0, 0)).x;
    field[ 9] = read_imagef(volume, volumeSampler, voxelPos + (int4)(-1, 1, 0, 0)).x;
    field[10] = read_imagef(volume, volumeSampler, voxelPos + (int4)(-1, 0, 1, 0)).x;
    field[11] = read_imagef(volume, volumeSampler, voxelPos + (int4)( 0,-1, 0, 0)).x;
    field[12] = read_imagef(volume, volumeSampler, voxelPos + (int4)( 1,-1, 0, 0)).x;
    field[13] = read_imagef(volume, volumeSampler, voxelPos + (int4)( 0,-1, 1, 0)).x;
    field[14] = read_imagef(volume, volumeSampler, voxelPos + (int4)( 0, 0,-1, 0)).x;
    field[15] = read_imagef(volume, volumeSampler, voxelPos + (int4)( 1, 0,-1, 0)).x;
    field[16] = read_imagef(volume, volumeSampler, voxelPos + (int4)( 0, 1,-1, 0)).x;
    field[17] = read_imagef(volume, volumeSampler, voxelPos + (int4)(-1, 1, 1, 0)).x;
    field[18] = read_imagef(volume, volumeSampler, voxelPos + (int4)( 1,-1, 1, 0)).x;
    field[19] = read_imagef(volume, volumeSampler, voxelPos + (int4)( 1, 1,-1, 0)).x;

		field[20] = read_imagef(volume, volumeSampler, voxelPos + (int4)(2, 0, 0, 0)).x;
    field[21] = read_imagef(volume, volumeSampler, voxelPos + (int4)(2, 1, 0, 0)).x;
    field[22] = read_imagef(volume, volumeSampler, voxelPos + (int4)(0, 2, 0, 0)).x;
    field[23] = read_imagef(volume, volumeSampler, voxelPos + (int4)(0, 0, 2, 0)).x;
    field[24] = read_imagef(volume, volumeSampler, voxelPos + (int4)(2, 0, 1, 0)).x;
    field[25] = read_imagef(volume, volumeSampler, voxelPos + (int4)(2, 1, 1, 0)).x;
    field[26] = read_imagef(volume, volumeSampler, voxelPos + (int4)(0, 2, 1, 0)).x;
    field[27] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 2, 0, 0)).x;
    field[28] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 0, 2, 0)).x;
    field[29] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 2, 1, 0)).x;
    field[30] = read_imagef(volume, volumeSampler, voxelPos + (int4)(1, 1, 2, 0)).x;
    field[31] = read_imagef(volume, volumeSampler, voxelPos + (int4)(0, 1, 2, 0)).x;

    // recalculate flag
    int cubeindex;
		cubeindex =  (field[0] < isoValue);
		cubeindex += (field[1] < isoValue)*2;
		cubeindex += (field[2] < isoValue)*4;
		cubeindex += (field[3] < isoValue)*8;
		cubeindex += (field[4] < isoValue)*16;
		cubeindex += (field[5] < isoValue)*32;
		cubeindex += (field[6] < isoValue)*64;
		cubeindex += (field[7] < isoValue)*128;

		// find the vertices where the surface intersects the cube
		// Save share memory and keep size of shared memory used less than 0x4000(threshold of GTX240)
		__local float4 vertlist[12*NTHREADS];
		__local float4 normlist[12*NTHREADS];

		vertlist[tid] = vertexInterp(isoValue, v[0], v[1], field[0], field[1]);
		vertlist[NTHREADS+tid] = vertexInterp(isoValue, v[1], v[2], field[1], field[2]);
		vertlist[(NTHREADS*2)+tid] = vertexInterp(isoValue, v[2], v[3], field[2], field[3]);
		vertlist[(NTHREADS*3)+tid] = vertexInterp(isoValue, v[3], v[0], field[3], field[0]);
		vertlist[(NTHREADS*4)+tid] = vertexInterp(isoValue, v[4], v[5], field[4], field[5]);
		vertlist[(NTHREADS*5)+tid] = vertexInterp(isoValue, v[5], v[6], field[5], field[6]);
		vertlist[(NTHREADS*6)+tid] = vertexInterp(isoValue, v[6], v[7], field[6], field[7]);
		vertlist[(NTHREADS*7)+tid] = vertexInterp(isoValue, v[7], v[4], field[7], field[4]);
		vertlist[(NTHREADS*8)+tid] = vertexInterp(isoValue, v[0], v[4], field[0], field[4]);
		vertlist[(NTHREADS*9)+tid] = vertexInterp(isoValue, v[1], v[5], field[1], field[5]);
		vertlist[(NTHREADS*10)+tid] = vertexInterp(isoValue, v[2], v[6], field[2], field[6]);
		vertlist[(NTHREADS*11)+tid] = vertexInterp(isoValue, v[3], v[7], field[3], field[7]);

		// ofs is same as field[0-7]
    float4 n[8];
    n[0] = (float4)(	(field[ 8]*weight0+field[ 0]*weight1) - field[ 1],			(field[11]*weight0+field[ 0]*weight1) - field[ 3],			(field[14]*weight0+field[ 0]*weight1) - field[ 4],			0	);
    n[1] = (float4)(	field[ 0] - (field[20]*weight0+field[ 1]*weight1),			(field[12]*weight0+field[ 1]*weight1) - field[ 2],			(field[15]*weight0+field[ 1]*weight1) - field[ 5],			0	);
    n[3] = (float4)(	(field[ 9]*weight0+field[ 3]*weight1) - field[ 2],			field[ 0] - (field[22]*weight0+field[ 3]*weight1),			(field[16]*weight0+field[ 3]*weight1) - field[ 7],			0	);
    n[4] = (float4)(	(field[10]*weight0+field[ 4]*weight1) - field[ 5],			(field[13]*weight0+field[ 4]*weight1) - field[ 7],			field[ 0] - (field[23]*weight0+field[ 4]*weight1),			0	);
    n[2] = (float4)(	field[ 3] - (field[21]*weight0+field[ 2]*weight1),			field[ 1] - (field[27]*weight0+field[ 2]*weight1),			(field[19]*weight0+field[ 2]*weight1) - field[ 6],			0	);
    n[5] = (float4)(	field[ 4] - (field[24]*weight0+field[ 5]*weight1),			(field[18]*weight0+field[ 5]*weight1) - field[ 6],			field[ 1] - (field[28]*weight0+field[ 5]*weight1),			0	);
    n[6] = (float4)(	field[ 7] - (field[25]*weight0+field[ 6]*weight1),			field[ 5] - (field[29]*weight0+field[ 6]*weight1),			field[ 2] - (field[30]*weight0+field[ 6]*weight1),			0	);
    n[7] = (float4)(	(field[17]*weight0+field[ 7]*weight1) - field[ 6],			field[ 4] - (field[26]*weight0+field[ 7]*weight1),			field[ 3] - (field[31]*weight0+field[ 7]*weight1),			0	);

		normlist[tid] = vertexInterp(isoValue, n[0], n[1], field[0], field[1]);
		normlist[NTHREADS+tid] = vertexInterp(isoValue, n[1], n[2], field[1], field[2]);
		normlist[(NTHREADS*2)+tid] = vertexInterp(isoValue, n[2], n[3], field[2], field[3]);
		normlist[(NTHREADS*3)+tid] = vertexInterp(isoValue, n[3], n[0], field[3], field[0]);
		normlist[(NTHREADS*4)+tid] = vertexInterp(isoValue, n[4], n[5], field[4], field[5]);
		normlist[(NTHREADS*5)+tid] = vertexInterp(isoValue, n[5], n[6], field[5], field[6]);
		normlist[(NTHREADS*6)+tid] = vertexInterp(isoValue, n[6], n[7], field[6], field[7]);
		normlist[(NTHREADS*7)+tid] = vertexInterp(isoValue, n[7], n[4], field[7], field[4]);
		normlist[(NTHREADS*8)+tid] = vertexInterp(isoValue, n[0], n[4], field[0], field[4]);
		normlist[(NTHREADS*9)+tid] = vertexInterp(isoValue, n[1], n[5], field[1], field[5]);
		normlist[(NTHREADS*10)+tid] = vertexInterp(isoValue, n[2], n[6], field[2], field[6]);
		normlist[(NTHREADS*11)+tid] = vertexInterp(isoValue, n[3], n[7], field[3], field[7]);
		barrier(CLK_LOCAL_MEM_FENCE);

    // output triangle vertices
    uint numVerts = numVertsTable[cubeindex];

    for(int i=0; i<numVerts; i+=3) {
        uint index = numVertsScanned[voxelId] + i;

        float4 v[3];
        float4 n[3];
        uint matIdx[3];
        uint edge;
        edge = triTable[cubeindex][i];
        v[0] = vertlist[(edge*NTHREADS)+tid];
        n[0] = normlist[(edge*NTHREADS)+tid];

        int one = edgeInfo[triTable[cubeindex][i] * 2];
        int two = edgeInfo[triTable[cubeindex][i] * 2 + 1];
        matIdx[0] = voxelType[((cubeindex & (1 << one)) == 0)? one:two]*255;

        edge = triTable[cubeindex][i+1];
        v[1] = vertlist[(edge*NTHREADS)+tid];
        n[1] = normlist[(edge*NTHREADS)+tid];

        one = edgeInfo[triTable[cubeindex][i + 1] * 2];
        two = edgeInfo[triTable[cubeindex][i + 1] * 2 + 1];
        matIdx[1] = voxelType[((cubeindex & (1 << one)) == 0)? one:two]*255;

        edge = triTable[cubeindex][i+2];
        v[2] = vertlist[(edge*NTHREADS)+tid];
        n[2] = normlist[(edge*NTHREADS)+tid];

        one = edgeInfo[triTable[cubeindex][i + 2] * 2];
        two = edgeInfo[triTable[cubeindex][i + 2] * 2 + 1];
        matIdx[2] = voxelType[((cubeindex & (1 << one)) == 0)? one:two]*255;

        // calculate triangle surface normal
        //n[0] = n[1] = n[2] = calcNormal(v[0], v[1], v[2]);

        //if (index < (maxVerts-2)) // 0, 1, 2
        {
        	uint f3idx = index*3;
        	uint f2idx = index*2;
        	uint mat0  = matIdx[0]*4 + 2;
        	uint mat12 = matIdx[1]*256 + matIdx[2];

            pos[f3idx] = v[0].x;			pos[f3idx+1] = v[0].y;		pos[f3idx+2] = v[0].z;
            norm01[f2idx] = n[0].x;			norm01[f2idx+1] = n[0].y;
            norm2t[f2idx] = mat0+n[0].z;	norm2t[f2idx+1] = mat12+0.0f;//materialIndices[0];

            pos[f3idx+3] = v[1].x;			pos[f3idx+4] = v[1].y;		pos[f3idx+5] = v[1].z;
            norm01[f2idx+2] = n[1].x;		norm01[f2idx+3] = n[1].y;
            norm2t[f2idx+2] = mat0+n[1].z;	norm2t[f2idx+3] = mat12+0.1f;//materialIndices[1];

            pos[f3idx+6] = v[2].x;			pos[f3idx+7] = v[2].y;		pos[f3idx+8] = v[2].z;
            norm01[f2idx+4] = n[2].x;		norm01[f2idx+5] = n[2].y;
            norm2t[f2idx+4] = mat0+n[2].z;	norm2t[f2idx+5] = mat12+0.2f;//materialIndices[2];
        }
    }
}


// buildOptions=-cl-mad-enable
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-mad-enable" %cfg_path --cl-device=%cl_device 2>&1
