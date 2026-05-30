inline float distance_(__global const float * center, __global const float * src, int feature_length)
{
float res = 0;
float4 v0, v1, v2;
int i = 0;
#ifdef L1_DIST
float4 sum = (float4)(0.0f);
#endif
for ( ; i <= feature_length - 4; i += 4)
{
v0 = vload4(0, center + i);
v1 = vload4(0, src + i);
v2 = v1 - v0;
#ifdef L1_DIST
v0 = fabs(v2);
sum += v0;
#else
res += dot(v2, v2);
#endif
}
#ifdef L1_DIST
res = sum.x + sum.y + sum.z + sum.w;
#endif
for ( ; i < feature_length; ++i)
{
float t0 = src[i];
float t1 = center[i];
#ifdef L1_DIST
res += fabs(t0 - t1);
#else
float t2 = t0 - t1;
res += t2 * t2;
#endif
}
return res;
}
__kernel void distanceToCenters(__global const float * src, __global const float * centers,
__global float * dists, int feature_length,
int src_step, int centers_step,
int features_count, int centers_count,
int src_offset, int centers_offset)
{
int gid = get_global_id(0);
if (gid < (features_count * centers_count))
{
int feature_index = gid / centers_count;
int center_index = gid % centers_count;
int center_idx = mad24(center_index, centers_step, centers_offset);
int src_idx = mad24(feature_index, src_step, src_offset);
dists[gid] = distance_(centers + center_idx, src + src_idx, feature_length);
}
}


// buildOptions= -D INTEL_DEVICE -D L1_DIST
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D L1_DIST" %cfg_path --cl-device=%cl_device 2>&1
