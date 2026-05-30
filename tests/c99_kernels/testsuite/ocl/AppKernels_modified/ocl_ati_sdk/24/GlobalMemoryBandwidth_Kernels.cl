#define STRIDE 512.f
#define STRIDE2 512

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
val = val + input[index + 0 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 1 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 2 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 3 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 4 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 5 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 6 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 7 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 8 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 9 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 10 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 11 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 12 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 13 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 14 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 15 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 16 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 17 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 18 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 19 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 20 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 21 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 22 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 23 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 24 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 25 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 26 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 27 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 28 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 29 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 30 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
val = val + input[index + 31 * (uint)(native_divide(STRIDE, sizeof(DATATYPE)))];
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
}

__kernel void write_linear(__constant DATATYPE *c0, __global DATATYPE *output)
{
uint gid = get_global_id(0);
output[gid + 0 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 1 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 2 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 3 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 4 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 5 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 6 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 7 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 8 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 9 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 10 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 11 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 12 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 13 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 14 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 15 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 16 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 17 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 18 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 19 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 20 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 21 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 22 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 23 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 24 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 25 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 26 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 27 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 28 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 29 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 30 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
output[gid + 31 * (STRIDE2 / sizeof(DATATYPE))] =  *c0;
}


// buildOptions= -D DATATYPE=float
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D DATATYPE=float" %cfg_path --cl-device=%cl_device 2>&1
