#ifdef OP_MERGE
#define DECLARE_SRC_PARAM(index) __global const uchar * src##index##ptr, int src##index##_step, int src##index##_offset,
#define DECLARE_INDEX(index) int src##index##_index = mad24(src##index##_step, y0, mad24(x, (int)sizeof(T) * scn##index, src##index##_offset));
#define PROCESS_ELEM(index) \
__global const T * src##index = (__global const T *)(src##index##ptr + src##index##_index); \
dst[index] = src##index[0]; \
src##index##_index += src##index##_step;
__kernel void merge(DECLARE_SRC_PARAMS_N
__global uchar * dstptr, int dst_step, int dst_offset,
int rows, int cols, int rowsPerWI)
{
int x = get_global_id(0);
int y0 = get_global_id(1) * rowsPerWI;
if (x < cols)
{
DECLARE_INDEX_N
int dst_index = mad24(dst_step, y0, mad24(x, (int)sizeof(T) * cn, dst_offset));
for (int y = y0, y1 = min(rows, y0 + rowsPerWI); y < y1; ++y, dst_index += dst_step)
{
__global T * dst = (__global T *)(dstptr + dst_index);
PROCESS_ELEMS_N
}
}
}
#elif defined OP_SPLIT
#define DECLARE_DST_PARAM(index) , __global uchar * dst##index##ptr, int dst##index##_step, int dst##index##_offset
#define DECLARE_INDEX(index) int dst##index##_index = mad24(y0, dst##index##_step, mad24(x, (int)sizeof(T), dst##index##_offset));
#define PROCESS_ELEM(index) \
__global T * dst##index = (__global T *)(dst##index##ptr + dst##index##_index); \
dst##index[0] = src[index]; \
dst##index##_index += dst##index##_step;
__kernel void split(__global uchar* srcptr, int src_step, int src_offset, int rows, int cols DECLARE_DST_PARAMS, int rowsPerWI)
{
int x = get_global_id(0);
int y0 = get_global_id(1) * rowsPerWI;
if (x < cols)
{
DECLARE_INDEX_N
int src_index = mad24(y0, src_step, mad24(x, cn * (int)sizeof(T), src_offset));
for (int y = y0, y1 = min(rows, y0 + rowsPerWI); y < y1; ++y, src_index += src_step)
{
__global const T * src = (__global const T *)(srcptr + src_index);
PROCESS_ELEMS_N
}
}
}
#else
#error "No operation"
#endif


// buildOptions=-D T=short -D OP_SPLIT -D cn=1 -D DECLARE_DST_PARAMS=DECLARE_DST_PARAM(0) -D PROCESS_ELEMS_N=PROCESS_ELEM(0) -D DECLARE_INDEX_N=DECLARE_INDEX(0) -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D T=short -D OP_SPLIT -D cn=1 -D DECLARE_DST_PARAMS=DECLARE_DST_PARAM(0) -D PROCESS_ELEMS_N=PROCESS_ELEM(0) -D DECLARE_INDEX_N=DECLARE_INDEX(0) -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
