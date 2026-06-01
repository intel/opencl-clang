#define STRIDE 512

__kernel void read_linear(__global DATATYPE *input,__global DATATYPE *output)
{
DATATYPE val = (DATATYPE)(0.0f);
uint gid = get_global_id(0);
uint index = gid;
val = val + input[index + 0];
val = val + input[index + 1];
val = val + input[index + 2];
val = val + input[index + 3];
val = val + input[index + 4];
val = val + input[index + 5];
val = val + input[index + 6];
val = val + input[index + 7];
val = val + input[index + 8];
val = val + input[index + 9];
val = val + input[index + 10];
val = val + input[index + 11];
val = val + input[index + 12];
val = val + input[index + 13];
val = val + input[index + 14];
val = val + input[index + 15];
val = val + input[index + 16];
val = val + input[index + 17];
val = val + input[index + 18];
val = val + input[index + 19];
val = val + input[index + 20];
val = val + input[index + 21];
val = val + input[index + 22];
val = val + input[index + 23];
val = val + input[index + 24];
val = val + input[index + 25];
val = val + input[index + 26];
val = val + input[index + 27];
val = val + input[index + 28];
val = val + input[index + 29];
val = val + input[index + 30];
val = val + input[index + 31];
output[gid] = val;
}

__kernel void read_linear_uncached(__global DATATYPE *input,__global DATATYPE *output)
{
DATATYPE val = (DATATYPE)(0.0f);
uint gid = get_global_id(0);
uint index = gid;
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
val = val + input[index += OFFSET];
output[gid] = val;
}

__kernel void read_single(__global DATATYPE *input,__global DATATYPE *output)
{
DATATYPE val = (DATATYPE)(0.0f);
uint gid = get_global_id(0);
uint index = 0;
val = val + input[index + 0];
val = val + input[index + 1];
val = val + input[index + 2];
val = val + input[index + 3];
val = val + input[index + 4];
val = val + input[index + 5];
val = val + input[index + 6];
val = val + input[index + 7];
val = val + input[index + 8];
val = val + input[index + 9];
val = val + input[index + 10];
val = val + input[index + 11];
val = val + input[index + 12];
val = val + input[index + 13];
val = val + input[index + 14];
val = val + input[index + 15];
val = val + input[index + 16];
val = val + input[index + 17];
val = val + input[index + 18];
val = val + input[index + 19];
val = val + input[index + 20];
val = val + input[index + 21];
val = val + input[index + 22];
val = val + input[index + 23];
val = val + input[index + 24];
val = val + input[index + 25];
val = val + input[index + 26];
val = val + input[index + 27];
val = val + input[index + 28];
val = val + input[index + 29];
val = val + input[index + 30];
val = val + input[index + 31];
output[gid] = val;
//printf("%d - (%f, %f, %f)\n", gid, output[gid].x, output[gid].y, output[gid].z);
}

__kernel void write_linear(__constant DATATYPE *c0, __global DATATYPE *output)
{
uint gid = get_global_id(0);
output[gid + 0 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 1 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 2 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 3 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 4 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 5 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 6 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 7 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 8 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 9 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 10 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 11 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 12 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 13 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 14 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 15 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 16 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 17 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 18 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 19 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 20 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 21 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 22 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 23 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 24 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 25 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 26 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 27 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 28 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 29 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 30 * (STRIDE / sizeof(DATATYPE))] =  *c0;
output[gid + 31 * (STRIDE / sizeof(DATATYPE))] =  *c0;
}


// buildOptions=-D DATATYPE=float -D OFFSET=44
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D DATATYPE=float -D OFFSET=44" %cfg_path --cl-device=%cl_device 2>&1
