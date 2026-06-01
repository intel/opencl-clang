#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics:enable
#define MAX_FLOAT 3.40282e+038f
#ifndef T
#define T float
#endif
#ifndef BLOCK_SIZE
#define BLOCK_SIZE 16
#endif
#ifndef MAX_DESC_LEN
#define MAX_DESC_LEN 64
#endif
#define BLOCK_SIZE_ODD          (BLOCK_SIZE + 1)
#ifndef SHARED_MEM_SZ
#  if (BLOCK_SIZE < MAX_DESC_LEN)
#    define SHARED_MEM_SZ      (kercn * (BLOCK_SIZE * MAX_DESC_LEN + BLOCK_SIZE * BLOCK_SIZE))
#  else
#    define SHARED_MEM_SZ      (kercn * 2 * BLOCK_SIZE_ODD * BLOCK_SIZE)
#  endif
#endif
#ifndef DIST_TYPE
#define DIST_TYPE 2
#endif
#if (DIST_TYPE == 2)
#   ifdef T_FLOAT
typedef float result_type;
#       if (8 == kercn)
typedef float8 value_type;
#           define DIST(x, y) {value_type d = fabs((x) - (y)); result += d.s0 + d.s1 + d.s2 + d.s3 + d.s4 + d.s5 + d.s6 + d.s7;}
#       elif (4 == kercn)
typedef float4 value_type;
#           define DIST(x, y) {value_type d = fabs((x) - (y)); result += d.s0 + d.s1 + d.s2 + d.s3;}
#       else
typedef float value_type;
#           define DIST(x, y) result += fabs((x) - (y))
#       endif
#   else
typedef int result_type;
#       if (8 == kercn)
typedef int8 value_type;
#           define DIST(x, y) {value_type d = abs((x) - (y)); result += d.s0 + d.s1 + d.s2 + d.s3 + d.s4 + d.s5 + d.s6 + d.s7;}
#       elif (4 == kercn)
typedef int4 value_type;
#           define DIST(x, y) {value_type d = abs((x) - (y)); result += d.s0 + d.s1 + d.s2 + d.s3;}
#       else
typedef int  value_type;
#           define DIST(x, y) result += abs((x) - (y))
#       endif
#   endif
#   define DIST_RES(x) (x)
#elif (DIST_TYPE == 4)
typedef float result_type;
#   if (8 == kercn)
typedef float8 value_type;
#       define DIST(x, y)   {value_type d = ((x) - (y)); result += dot(d.s0123, d.s0123) + dot(d.s4567, d.s4567);}
#   elif (4 == kercn)
typedef float4      value_type;
#       define DIST(x, y)   {value_type d = ((x) - (y)); result += dot(d, d);}
#   else
typedef float       value_type;
#       define DIST(x, y)   {value_type d = ((x) - (y)); result = mad(d, d, result);}
#   endif
#   define DIST_RES(x) sqrt(x)
#elif (DIST_TYPE == 6)
#   if (8 == kercn)
typedef int8 value_type;
#   elif (4 == kercn)
typedef int4 value_type;
#   else
typedef int value_type;
#   endif
typedef int result_type;
#   define DIST(x, y) result += popcount( (x) ^ (y) )
#   define DIST_RES(x) (x)
#endif
inline result_type reduce_block(
__local value_type *s_query,
__local value_type *s_train,
int lidx,
int lidy
)
{
result_type result = 0;
#pragma unroll
for (int j = 0 ; j < BLOCK_SIZE ; j++)
{
DIST(s_query[lidy * BLOCK_SIZE_ODD + j], s_train[j * BLOCK_SIZE_ODD + lidx]);
}
return DIST_RES(result);
}
inline result_type reduce_block_match(
__local value_type *s_query,
__local value_type *s_train,
int lidx,
int lidy
)
{
result_type result = 0;
#pragma unroll
for (int j = 0 ; j < BLOCK_SIZE ; j++)
{
DIST(s_query[lidy * BLOCK_SIZE_ODD + j], s_train[j * BLOCK_SIZE_ODD + lidx]);
}
return result;
}
inline result_type reduce_multi_block(
__local value_type *s_query,
__local value_type *s_train,
int block_index,
int lidx,
int lidy
)
{
result_type result = 0;
#pragma unroll
for (int j = 0 ; j < BLOCK_SIZE ; j++)
{
DIST(s_query[lidy * MAX_DESC_LEN + block_index * BLOCK_SIZE + j], s_train[j * BLOCK_SIZE + lidx]);
}
return result;
}
__kernel void BruteForceMatch_Match(
__global T *query,
__global T *train,
__global int *bestTrainIdx,
__global float *bestDistance,
int query_rows,
int query_cols,
int train_rows,
int train_cols,
int step
)
{
const int lidx = get_local_id(0);
const int lidy = get_local_id(1);
const int groupidx = get_group_id(0);
const int queryIdx = mad24(BLOCK_SIZE, groupidx, lidy);
const int queryOffset = min(queryIdx, query_rows - 1) * step;
__global TN *query_vec = (__global TN *)(query + queryOffset);
query_cols /= kercn;
__local float sharebuffer[SHARED_MEM_SZ];
__local value_type *s_query = (__local value_type *)sharebuffer;
#if 0 < MAX_DESC_LEN
__local value_type *s_train = (__local value_type *)sharebuffer + BLOCK_SIZE * MAX_DESC_LEN;
#pragma unroll
for (int i = 0; i < MAX_DESC_LEN / BLOCK_SIZE; i++)
{
const int loadx = mad24(BLOCK_SIZE, i, lidx);
s_query[mad24(MAX_DESC_LEN, lidy, loadx)] = loadx < query_cols ? query_vec[loadx] : 0;
}
#else
__local value_type *s_train = (__local value_type *)sharebuffer + BLOCK_SIZE_ODD * BLOCK_SIZE;
const int s_query_i = mad24(BLOCK_SIZE_ODD, lidy, lidx);
const int s_train_i = mad24(BLOCK_SIZE_ODD, lidx, lidy);
#endif
float myBestDistance = MAX_FLOAT;
int myBestTrainIdx = -1;
for (int t = 0, endt = (train_rows + BLOCK_SIZE - 1) / BLOCK_SIZE; t < endt; t++)
{
result_type result = 0;
const int trainOffset = min(mad24(BLOCK_SIZE, t, lidy), train_rows - 1) * step;
__global TN *train_vec = (__global TN *)(train + trainOffset);
#if 0 < MAX_DESC_LEN
#pragma unroll
for (int i = 0; i < MAX_DESC_LEN / BLOCK_SIZE; i++)
{
const int loadx = mad24(BLOCK_SIZE, i, lidx);
s_train[mad24(BLOCK_SIZE, lidx, lidy)] = loadx < train_cols ? train_vec[loadx] : 0;
barrier(CLK_LOCAL_MEM_FENCE);
result += reduce_multi_block(s_query, s_train, i, lidx, lidy);
barrier(CLK_LOCAL_MEM_FENCE);
}
#else
for (int i = 0, endq = (query_cols + BLOCK_SIZE - 1) / BLOCK_SIZE; i < endq; i++)
{
const int loadx = mad24(i, BLOCK_SIZE, lidx);
if (loadx < query_cols)
{
s_query[s_query_i] = query_vec[loadx];
s_train[s_train_i] = train_vec[loadx];
}
else
{
s_query[s_query_i] = 0;
s_train[s_train_i] = 0;
}
barrier(CLK_LOCAL_MEM_FENCE);
result += reduce_block_match(s_query, s_train, lidx, lidy);
barrier(CLK_LOCAL_MEM_FENCE);
}
#endif
result = DIST_RES(result);
const int trainIdx = mad24(BLOCK_SIZE, t, lidx);
if (queryIdx < query_rows && trainIdx < train_rows && result < myBestDistance )
{
myBestDistance = result;
myBestTrainIdx = trainIdx;
}
}
barrier(CLK_LOCAL_MEM_FENCE);
__local float *s_distance = (__local float *)sharebuffer;
__local int *s_trainIdx = (__local int *)(sharebuffer + BLOCK_SIZE_ODD * BLOCK_SIZE);
s_distance += lidy * BLOCK_SIZE_ODD;
s_trainIdx += lidy * BLOCK_SIZE_ODD;
s_distance[lidx] = myBestDistance;
s_trainIdx[lidx] = myBestTrainIdx;
barrier(CLK_LOCAL_MEM_FENCE);
#pragma unroll
for (int k = 0 ; k < BLOCK_SIZE; k++)
{
if (myBestDistance > s_distance[k])
{
myBestDistance = s_distance[k];
myBestTrainIdx = s_trainIdx[k];
}
}
if (queryIdx < query_rows && lidx == 0)
{
bestTrainIdx[queryIdx] = myBestTrainIdx;
bestDistance[queryIdx] = myBestDistance;
}
}
__kernel void BruteForceMatch_RadiusMatch(
__global T *query,
__global T *train,
float maxDistance,
__global int *bestTrainIdx,
__global float *bestDistance,
__global int *nMatches,
int query_rows,
int query_cols,
int train_rows,
int train_cols,
int bestTrainIdx_cols,
int step,
int ostep
)
{
const int lidx = get_local_id(0);
const int lidy = get_local_id(1);
const int groupidx = get_group_id(0);
const int groupidy = get_group_id(1);
const int queryIdx = mad24(BLOCK_SIZE, groupidy, lidy);
const int queryOffset = min(queryIdx, query_rows - 1) * step;
__global TN *query_vec = (__global TN *)(query + queryOffset);
const int trainIdx = mad24(BLOCK_SIZE, groupidx, lidx);
const int trainOffset = min(mad24(BLOCK_SIZE, groupidx, lidy), train_rows - 1) * step;
__global TN *train_vec = (__global TN *)(train + trainOffset);
query_cols /= kercn;
__local float sharebuffer[SHARED_MEM_SZ];
__local value_type *s_query = (__local value_type *)sharebuffer;
__local value_type *s_train = (__local value_type *)sharebuffer + BLOCK_SIZE_ODD * BLOCK_SIZE;
result_type result = 0;
const int s_query_i = mad24(BLOCK_SIZE_ODD, lidy, lidx);
const int s_train_i = mad24(BLOCK_SIZE_ODD, lidx, lidy);
for (int i = 0 ; i < (query_cols + BLOCK_SIZE - 1) / BLOCK_SIZE ; ++i)
{
const int loadx = mad24(BLOCK_SIZE, i, lidx);
if (loadx < query_cols)
{
s_query[s_query_i] = query_vec[loadx];
s_train[s_train_i] = train_vec[loadx];
}
else
{
s_query[s_query_i] = 0;
s_train[s_train_i] = 0;
}
barrier(CLK_LOCAL_MEM_FENCE);
result += reduce_block(s_query, s_train, lidx, lidy);
barrier(CLK_LOCAL_MEM_FENCE);
}
if (queryIdx < query_rows && trainIdx < train_rows && convert_float(result) < maxDistance)
{
int ind = atom_inc(nMatches + queryIdx);
if(ind < bestTrainIdx_cols)
{
bestTrainIdx[mad24(queryIdx, ostep, ind)] = trainIdx;
bestDistance[mad24(queryIdx, ostep, ind)] = result;
}
}
}
__kernel void BruteForceMatch_knnMatch(
__global T *query,
__global T *train,
__global int2 *bestTrainIdx,
__global float2 *bestDistance,
int query_rows,
int query_cols,
int train_rows,
int train_cols,
int step
)
{
const int lidx = get_local_id(0);
const int lidy = get_local_id(1);
const int groupidx = get_group_id(0);
const int queryIdx = mad24(BLOCK_SIZE, groupidx, lidy);
const int queryOffset = min(queryIdx, query_rows - 1) * step;
__global TN *query_vec = (__global TN *)(query + queryOffset);
query_cols /= kercn;
__local float sharebuffer[SHARED_MEM_SZ];
__local value_type *s_query = (__local value_type *)sharebuffer;
#if 0 < MAX_DESC_LEN
__local value_type *s_train = (__local value_type *)sharebuffer + BLOCK_SIZE * MAX_DESC_LEN;
#pragma unroll
for (int i = 0 ;  i <  MAX_DESC_LEN / BLOCK_SIZE; i ++)
{
int loadx = mad24(BLOCK_SIZE, i, lidx);
s_query[mad24(MAX_DESC_LEN, lidy, loadx)] = loadx < query_cols ? query_vec[loadx] : 0;
}
#else
__local value_type *s_train = (__local value_type *)sharebuffer + BLOCK_SIZE_ODD * BLOCK_SIZE;
const int s_query_i = mad24(BLOCK_SIZE_ODD, lidy, lidx);
const int s_train_i = mad24(BLOCK_SIZE_ODD, lidx, lidy);
#endif
float myBestDistance1 = MAX_FLOAT;
float myBestDistance2 = MAX_FLOAT;
int myBestTrainIdx1 = -1;
int myBestTrainIdx2 = -1;
for (int t = 0, endt = (train_rows + BLOCK_SIZE - 1) / BLOCK_SIZE; t < endt ; t++)
{
result_type result = 0;
int trainOffset = min(mad24(BLOCK_SIZE, t, lidy), train_rows - 1) * step;
__global TN *train_vec = (__global TN *)(train + trainOffset);
#if 0 < MAX_DESC_LEN
#pragma unroll
for (int i = 0 ; i < MAX_DESC_LEN / BLOCK_SIZE ; i++)
{
const int loadx = mad24(BLOCK_SIZE, i, lidx);
s_train[mad24(BLOCK_SIZE, lidx, lidy)] = loadx < train_cols ? train_vec[loadx] : 0;
barrier(CLK_LOCAL_MEM_FENCE);
result += reduce_multi_block(s_query, s_train, i, lidx, lidy);
barrier(CLK_LOCAL_MEM_FENCE);
}
#else
for (int i = 0, endq = (query_cols + BLOCK_SIZE -1) / BLOCK_SIZE; i < endq ; i++)
{
const int loadx = mad24(BLOCK_SIZE, i, lidx);
if (loadx < query_cols)
{
s_query[s_query_i] = query_vec[loadx];
s_train[s_train_i] = train_vec[loadx];
}
else
{
s_query[s_query_i] = 0;
s_train[s_train_i] = 0;
}
barrier(CLK_LOCAL_MEM_FENCE);
result += reduce_block_match(s_query, s_train, lidx, lidy);
barrier(CLK_LOCAL_MEM_FENCE);
}
#endif
result = DIST_RES(result);
const int trainIdx = mad24(BLOCK_SIZE, t, lidx);
if (queryIdx < query_rows && trainIdx < train_rows)
{
if (result < myBestDistance1)
{
myBestDistance2 = myBestDistance1;
myBestTrainIdx2 = myBestTrainIdx1;
myBestDistance1 = result;
myBestTrainIdx1 = trainIdx;
}
else if (result < myBestDistance2)
{
myBestDistance2 = result;
myBestTrainIdx2 = trainIdx;
}
}
}
barrier(CLK_LOCAL_MEM_FENCE);
__local float *s_distance = (__local float *)sharebuffer;
__local int *s_trainIdx = (__local int *)(sharebuffer + BLOCK_SIZE_ODD * BLOCK_SIZE);
s_distance += lidy * BLOCK_SIZE_ODD;
s_trainIdx += lidy * BLOCK_SIZE_ODD;
s_distance[lidx] = myBestDistance1;
s_trainIdx[lidx] = myBestTrainIdx1;
float bestDistance1 = MAX_FLOAT;
float bestDistance2 = MAX_FLOAT;
int bestTrainIdx1 = -1;
int bestTrainIdx2 = -1;
barrier(CLK_LOCAL_MEM_FENCE);
if (lidx == 0)
{
for (int i = 0 ; i < BLOCK_SIZE ; i++)
{
float val = s_distance[i];
if (val < bestDistance1)
{
bestDistance2 = bestDistance1;
bestTrainIdx2 = bestTrainIdx1;
bestDistance1 = val;
bestTrainIdx1 = s_trainIdx[i];
}
else if (val < bestDistance2)
{
bestDistance2 = val;
bestTrainIdx2 = s_trainIdx[i];
}
}
}
barrier(CLK_LOCAL_MEM_FENCE);
s_distance[lidx] = myBestDistance2;
s_trainIdx[lidx] = myBestTrainIdx2;
barrier(CLK_LOCAL_MEM_FENCE);
if (lidx == 0)
{
for (int i = 0 ; i < BLOCK_SIZE ; i++)
{
float val = s_distance[i];
if (val < bestDistance2)
{
bestDistance2 = val;
bestTrainIdx2 = s_trainIdx[i];
}
}
}
myBestDistance1 = bestDistance1;
myBestDistance2 = bestDistance2;
myBestTrainIdx1 = bestTrainIdx1;
myBestTrainIdx2 = bestTrainIdx2;
if (queryIdx < query_rows && lidx == 0)
{
bestTrainIdx[queryIdx] = (int2)(myBestTrainIdx1, myBestTrainIdx2);
bestDistance[queryIdx] = (float2)(myBestDistance1, myBestDistance2);
}
}


// buildOptions=-D T=float -D TN=float -D kercn=1 -D T_FLOAT -D DIST_TYPE=4 -D BLOCK_SIZE=16 -D MAX_DESC_LEN=64 -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D T=float -D TN=float -D kercn=1 -D T_FLOAT -D DIST_TYPE=4 -D BLOCK_SIZE=16 -D MAX_DESC_LEN=64 -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
