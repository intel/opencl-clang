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
#ifndef DIST_TYPE
#define DIST_TYPE 0
#endif
#if   (DIST_TYPE == 0)
#   ifdef T_FLOAT
#       define DIST(x, y) fabs((x) - (y))
typedef float value_type;
typedef float result_type;
#   else
#       define DIST(x, y) abs((x) - (y))
typedef int value_type;
typedef int result_type;
#   endif
#define DIST_RES(x) (x)
#elif (DIST_TYPE == 1)
#define DIST(x, y) (((x) - (y)) * ((x) - (y)))
typedef float value_type;
typedef float result_type;
#define DIST_RES(x) sqrt(x)
#elif (DIST_TYPE == 2)
inline int bit1Count(int v)
{
v = v - ((v >> 1) & 0x55555555);
v = (v & 0x33333333) + ((v >> 2) & 0x33333333);
return ((v + (v >> 4) & 0xF0F0F0F) * 0x1010101) >> 24;
}
#define DIST(x, y) bit1Count( (x) ^ (y) )
typedef int value_type;
typedef int result_type;
#define DIST_RES(x) (x)
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
result += DIST(
s_query[lidy * BLOCK_SIZE + j],
s_train[j * BLOCK_SIZE + lidx]);
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
result += DIST(
s_query[lidy * BLOCK_SIZE + j],
s_train[j * BLOCK_SIZE + lidx]);
}
return (result);
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
result += DIST(
s_query[lidy * MAX_DESC_LEN + block_index * BLOCK_SIZE + j],
s_train[j * BLOCK_SIZE + lidx]);
}
return result;
}
__kernel void BruteForceMatch_UnrollMatch(
__global T *query,
__global T *train,
__global int *bestTrainIdx,
__global float *bestDistance,
__local float *sharebuffer,
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
__local value_type *s_query = (__local value_type *)sharebuffer;
__local value_type *s_train = (__local value_type *)sharebuffer + BLOCK_SIZE * MAX_DESC_LEN;
int queryIdx = groupidx * BLOCK_SIZE + lidy;
#pragma unroll
for (int i = 0 ;  i <  MAX_DESC_LEN / BLOCK_SIZE; i ++)
{
int loadx = lidx + i * BLOCK_SIZE;
s_query[lidy * MAX_DESC_LEN + loadx] = loadx < query_cols ? query[min(queryIdx, query_rows - 1)  * (step / sizeof(float)) + loadx] : 0;
}
float myBestDistance = MAX_FLOAT;
int myBestTrainIdx = -1;
for (int t = 0, endt = (train_rows + BLOCK_SIZE - 1) / BLOCK_SIZE; t < endt; t++)
{
result_type result = 0;
#pragma unroll
for (int i = 0 ; i < MAX_DESC_LEN / BLOCK_SIZE ; i++)
{
const int loadx = lidx + i * BLOCK_SIZE;
s_train[lidx * BLOCK_SIZE + lidy] = loadx < train_cols ? train[min(t * BLOCK_SIZE + lidy, train_rows - 1) * (step / sizeof(float)) + loadx] : 0;
barrier(CLK_LOCAL_MEM_FENCE);
result += reduce_multi_block(s_query, s_train, i, lidx, lidy);
barrier(CLK_LOCAL_MEM_FENCE);
}
result = DIST_RES(result);
int trainIdx = t * BLOCK_SIZE + lidx;
if (queryIdx < query_rows && trainIdx < train_rows && result < myBestDistance)
{
myBestDistance = result;
myBestTrainIdx = trainIdx;
}
}
barrier(CLK_LOCAL_MEM_FENCE);
__local float *s_distance = (__local float*)(sharebuffer);
__local int* s_trainIdx = (__local int *)(sharebuffer + BLOCK_SIZE * BLOCK_SIZE);
s_distance += lidy * BLOCK_SIZE;
s_trainIdx += lidy * BLOCK_SIZE;
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
__kernel void BruteForceMatch_Match(
__global T *query,
__global T *train,
__global int *bestTrainIdx,
__global float *bestDistance,
__local float *sharebuffer,
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
const int queryIdx = groupidx * BLOCK_SIZE + lidy;
float myBestDistance = MAX_FLOAT;
int myBestTrainIdx = -1;
__local value_type *s_query = (__local value_type *)sharebuffer;
__local value_type *s_train = (__local value_type *)sharebuffer + BLOCK_SIZE * BLOCK_SIZE;
for (int t = 0 ;  t < (train_rows + BLOCK_SIZE - 1) / BLOCK_SIZE ; t++)
{
result_type result = 0;
for (int i = 0 ; i < (query_cols + BLOCK_SIZE - 1) / BLOCK_SIZE ; i++)
{
const int loadx = lidx + i * BLOCK_SIZE;
s_query[lidy * BLOCK_SIZE + lidx] = 0;
s_train[lidx * BLOCK_SIZE + lidy] = 0;
if (loadx < query_cols)
{
s_query[lidy * BLOCK_SIZE + lidx] = query[min(queryIdx, query_rows - 1) * (step / sizeof(float)) + loadx];
s_train[lidx * BLOCK_SIZE + lidy] = train[min(t * BLOCK_SIZE + lidy, train_rows - 1) * (step / sizeof(float)) + loadx];
}
barrier(CLK_LOCAL_MEM_FENCE);
result += reduce_block_match(s_query, s_train, lidx, lidy);
barrier(CLK_LOCAL_MEM_FENCE);
}
result = DIST_RES(result);
const int trainIdx = t * BLOCK_SIZE + lidx;
if (queryIdx < query_rows && trainIdx < train_rows && result < myBestDistance )
{
myBestDistance = result;
myBestTrainIdx = trainIdx;
}
}
barrier(CLK_LOCAL_MEM_FENCE);
__local float *s_distance = (__local float *)sharebuffer;
__local int *s_trainIdx = (__local int *)(sharebuffer + BLOCK_SIZE * BLOCK_SIZE);
s_distance += lidy * BLOCK_SIZE;
s_trainIdx += lidy * BLOCK_SIZE;
s_distance[lidx] = myBestDistance;
s_trainIdx[lidx] = myBestTrainIdx;
barrier(CLK_LOCAL_MEM_FENCE);
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
__kernel void BruteForceMatch_RadiusUnrollMatch(
__global T *query,
__global T *train,
float maxDistance,
__global int *bestTrainIdx,
__global float *bestDistance,
__global int *nMatches,
__local float *sharebuffer,
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
const int queryIdx = groupidy * BLOCK_SIZE + lidy;
const int trainIdx = groupidx * BLOCK_SIZE + lidx;
__local value_type *s_query = (__local value_type *)sharebuffer;
__local value_type *s_train = (__local value_type *)sharebuffer + BLOCK_SIZE * BLOCK_SIZE;
result_type result = 0;
for (int i = 0 ; i < MAX_DESC_LEN / BLOCK_SIZE ; ++i)
{
const int loadx = lidx + i * BLOCK_SIZE;
s_query[lidy * BLOCK_SIZE + lidx] = loadx < query_cols ? query[min(queryIdx, query_rows - 1)  * (step / sizeof(float)) + loadx] : 0;
s_train[lidx * BLOCK_SIZE + lidy] = loadx < query_cols ? train[min(groupidx * BLOCK_SIZE + lidy, train_rows - 1)  * (step / sizeof(float)) + loadx] : 0;
barrier(CLK_LOCAL_MEM_FENCE);
result += reduce_block(s_query, s_train, lidx, lidy);
barrier(CLK_LOCAL_MEM_FENCE);
}
if (queryIdx < query_rows && trainIdx < train_rows &&
convert_float(result) < maxDistance)
{
int ind = atom_inc(nMatches + queryIdx);
if(ind < bestTrainIdx_cols)
{
bestTrainIdx[queryIdx * (ostep / sizeof(int)) + ind] = trainIdx;
bestDistance[queryIdx * (ostep / sizeof(float)) + ind] = result;
}
}
}
__kernel void BruteForceMatch_RadiusMatch(
__global T *query,
__global T *train,
float maxDistance,
__global int *bestTrainIdx,
__global float *bestDistance,
__global int *nMatches,
__local float *sharebuffer,
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
const int queryIdx = groupidy * BLOCK_SIZE + lidy;
const int trainIdx = groupidx * BLOCK_SIZE + lidx;
__local value_type *s_query = (__local value_type *)sharebuffer;
__local value_type *s_train = (__local value_type *)sharebuffer + BLOCK_SIZE * BLOCK_SIZE;
result_type result = 0;
for (int i = 0 ; i < (query_cols + BLOCK_SIZE - 1) / BLOCK_SIZE ; ++i)
{
const int loadx = lidx + i * BLOCK_SIZE;
s_query[lidy * BLOCK_SIZE + lidx] = loadx < query_cols ? query[min(queryIdx, query_rows - 1)  * (step / sizeof(float)) + loadx] : 0;
s_train[lidx * BLOCK_SIZE + lidy] = loadx < query_cols ? train[min(groupidx * BLOCK_SIZE + lidy, train_rows - 1)  * (step / sizeof(float)) + loadx] : 0;
barrier(CLK_LOCAL_MEM_FENCE);
result += reduce_block(s_query, s_train, lidx, lidy);
barrier(CLK_LOCAL_MEM_FENCE);
}
if (queryIdx < query_rows && trainIdx < train_rows &&
convert_float(result) < maxDistance)
{
int ind = atom_inc(nMatches + queryIdx);
if(ind < bestTrainIdx_cols)
{
bestTrainIdx[queryIdx * (ostep / sizeof(int)) + ind] = trainIdx;
bestDistance[queryIdx * (ostep / sizeof(float)) + ind] = result;
}
}
}
__kernel void BruteForceMatch_knnUnrollMatch(
__global T *query,
__global T *train,
__global int2 *bestTrainIdx,
__global float2 *bestDistance,
__local float *sharebuffer,
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
const int queryIdx = groupidx * BLOCK_SIZE + lidy;
__local value_type *s_query = (__local value_type *)sharebuffer;
__local value_type *s_train = (__local value_type *)sharebuffer + BLOCK_SIZE * MAX_DESC_LEN;
for (int i = 0 ;  i <  MAX_DESC_LEN / BLOCK_SIZE; i ++)
{
int loadx = lidx + i * BLOCK_SIZE;
s_query[lidy * MAX_DESC_LEN + loadx] = loadx < query_cols ? query[min(queryIdx, query_rows - 1)  * (step / sizeof(float)) + loadx] : 0;
}
float myBestDistance1 = MAX_FLOAT;
float myBestDistance2 = MAX_FLOAT;
int myBestTrainIdx1 = -1;
int myBestTrainIdx2 = -1;
for (int t = 0 ; t < (train_rows + BLOCK_SIZE - 1) / BLOCK_SIZE ; t++)
{
result_type result = 0;
for (int i = 0 ; i < MAX_DESC_LEN / BLOCK_SIZE ; i++)
{
const int loadx = lidx + i * BLOCK_SIZE;
s_train[lidx * BLOCK_SIZE + lidy] = loadx < train_cols ? train[min(t * BLOCK_SIZE + lidy, train_rows - 1) * (step / sizeof(float)) + loadx] : 0;
barrier(CLK_LOCAL_MEM_FENCE);
result += reduce_multi_block(s_query, s_train, i, lidx, lidy);
barrier(CLK_LOCAL_MEM_FENCE);
}
result = DIST_RES(result);
const int trainIdx = t * BLOCK_SIZE + lidx;
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
__local float *s_distance = (local float *)sharebuffer;
__local int *s_trainIdx = (local int *)(sharebuffer + BLOCK_SIZE * BLOCK_SIZE);
s_distance += lidy * BLOCK_SIZE;
s_trainIdx += lidy * BLOCK_SIZE;
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
__kernel void BruteForceMatch_knnMatch(
__global T *query,
__global T *train,
__global int2 *bestTrainIdx,
__global float2 *bestDistance,
__local float *sharebuffer,
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
const int queryIdx = groupidx * BLOCK_SIZE + lidy;
__local value_type *s_query = (__local value_type *)sharebuffer;
__local value_type *s_train = (__local value_type *)sharebuffer + BLOCK_SIZE * BLOCK_SIZE;
float myBestDistance1 = MAX_FLOAT;
float myBestDistance2 = MAX_FLOAT;
int myBestTrainIdx1 = -1;
int myBestTrainIdx2 = -1;
for (int  t = 0 ; t < (train_rows + BLOCK_SIZE - 1) / BLOCK_SIZE ; t++)
{
result_type result = 0.0f;
for (int i = 0 ; i < (query_cols + BLOCK_SIZE -1) / BLOCK_SIZE ; i++)
{
const int loadx = lidx + i * BLOCK_SIZE;
s_query[lidy * BLOCK_SIZE + lidx] = 0;
s_train[lidx * BLOCK_SIZE + lidy] = 0;
if (loadx < query_cols)
{
s_query[lidy * BLOCK_SIZE + lidx] = query[min(queryIdx, query_rows - 1) * (step / sizeof(float)) + loadx];
s_train[lidx * BLOCK_SIZE + lidy] = train[min(t * BLOCK_SIZE + lidy, train_rows - 1) * (step / sizeof(float)) + loadx];
}
barrier(CLK_LOCAL_MEM_FENCE);
result += reduce_block_match(s_query, s_train, lidx, lidy);
barrier(CLK_LOCAL_MEM_FENCE);
}
result = DIST_RES(result);
const int trainIdx = t * BLOCK_SIZE + lidx;
if (queryIdx < query_rows && trainIdx < train_rows )
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
__local int *s_trainIdx = (__local int *)(sharebuffer + BLOCK_SIZE * BLOCK_SIZE);
s_distance += lidy * BLOCK_SIZE;
s_trainIdx += lidy * BLOCK_SIZE;
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
kernel void BruteForceMatch_calcDistanceUnrolled(
__global T *query,
__global T *train,
__global float *allDist,
__local float *sharebuffer,
int query_rows,
int query_cols,
int train_rows,
int train_cols,
int step)
{
}
kernel void BruteForceMatch_calcDistance(
__global T *query,
__global T *train,
__global float *allDist,
__local float *sharebuffer,
int query_rows,
int query_cols,
int train_rows,
int train_cols,
int step)
{
}
kernel void BruteForceMatch_findBestMatch(
__global float *allDist,
__global int *bestTrainIdx,
__global float *bestDistance,
int k
)
{
}


// buildOptions= -D INTEL_DEVICE -D T=float -D T_FLOAT -D DIST_TYPE=1 -D BLOCK_SIZE=16 -D MAX_DESC_LEN=128
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D T=float -D T_FLOAT -D DIST_TYPE=1 -D BLOCK_SIZE=16 -D MAX_DESC_LEN=128" %cfg_path --cl-device=%cl_device 2>&1
