#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#define noconvert
#if cn != 3
#define loadpix(addr) *(__global const T *)(addr)
#define storepix(val, addr)  *(__global T *)(addr) = val
#define TSIZE (int)sizeof(T)
#else
#define loadpix(addr) vload3(0, (__global const T1 *)(addr))
#define storepix(val, addr) vstore3(val, 0, (__global T1 *)(addr))
#define TSIZE ((int)sizeof(T1)*3)
#endif
#ifdef DEPTH_0
#define MIN_VAL 0
#define MAX_VAL UCHAR_MAX
#elif defined DEPTH_1
#define MIN_VAL SCHAR_MIN
#define MAX_VAL SCHAR_MAX
#elif defined DEPTH_2
#define MIN_VAL 0
#define MAX_VAL USHRT_MAX
#elif defined DEPTH_3
#define MIN_VAL SHRT_MIN
#define MAX_VAL SHRT_MAX
#elif defined DEPTH_4
#define MIN_VAL INT_MIN
#define MAX_VAL INT_MAX
#elif defined DEPTH_5
#define MIN_VAL (-FLT_MAX)
#define MAX_VAL FLT_MAX
#elif defined DEPTH_6
#define MIN_VAL (-DBL_MAX)
#define MAX_VAL DBL_MAX
#endif
#ifdef OP_ERODE
#define VAL MAX_VAL
#elif defined OP_DILATE
#define VAL MIN_VAL
#else
#error "Unknown operation"
#endif
#ifdef OP_ERODE
#if defined INTEL_DEVICE && defined DEPTH_0
#define MORPH_OP(A, B) ((A) < (B) ? (A) : (B))
#else
#define MORPH_OP(A, B) min((A), (B))
#endif
#endif
#ifdef OP_DILATE
#define MORPH_OP(A, B) max((A), (B))
#endif
#define PROCESS(y, x) \
temp = LDS_DAT[mad24(l_y + y, width, l_x + x)]; \
res = MORPH_OP(res, temp);
#define ELEM(i, l_edge, r_edge, elem1, elem2) (i) < (l_edge) | (i) >= (r_edge) ? (elem1) : (elem2)
#if defined OP_GRADIENT || defined OP_TOPHAT || defined OP_BLACKHAT
#define EXTRA_PARAMS , __global const uchar * matptr, int mat_step, int mat_offset
#else
#define EXTRA_PARAMS
#endif
__kernel void morph(__global const uchar * srcptr, int src_step, int src_offset,
__global uchar * dstptr, int dst_step, int dst_offset,
int src_offset_x, int src_offset_y, int cols, int rows,
int src_whole_cols, int src_whole_rows EXTRA_PARAMS)
{
int gidx = get_global_id(0), gidy = get_global_id(1);
int l_x = get_local_id(0), l_y = get_local_id(1);
int x = get_group_id(0) * LSIZE0, y = get_group_id(1) * LSIZE1;
int start_x = x + src_offset_x - RADIUSX;
int width = mad24(RADIUSX, 2, LSIZE0 + 1);
int start_y = y + src_offset_y - RADIUSY;
int point1 = mad24(l_y, LSIZE0, l_x);
int point2 = point1 + LSIZE0 * LSIZE1;
int tl_x = point1 % width, tl_y = point1 / width;
int tl_x2 = point2 % width, tl_y2 = point2 / width;
int cur_x = start_x + tl_x, cur_y = start_y + tl_y;
int cur_x2 = start_x + tl_x2, cur_y2 = start_y + tl_y2;
int start_addr = mad24(cur_y, src_step, cur_x * TSIZE);
int start_addr2 = mad24(cur_y2, src_step, cur_x2 * TSIZE);
__local T LDS_DAT[2 * LSIZE1 * LSIZE0];
int end_addr = mad24(src_whole_rows - 1, src_step, src_whole_cols * TSIZE);
start_addr = start_addr < end_addr && start_addr > 0 ? start_addr : 0;
start_addr2 = start_addr2 < end_addr && start_addr2 > 0 ? start_addr2 : 0;
T temp0 = loadpix(srcptr + start_addr);
T temp1 = loadpix(srcptr + start_addr2);
temp0 = ELEM(cur_x, 0, src_whole_cols, (T)(VAL), temp0);
temp0 = ELEM(cur_y, 0, src_whole_rows, (T)(VAL), temp0);
temp1 = ELEM(cur_x2, 0, src_whole_cols, (T)(VAL), temp1);
temp1 = ELEM(cur_y2, 0, src_whole_rows, (T)(VAL), temp1);
LDS_DAT[point1] = temp0;
LDS_DAT[point2] = temp1;
barrier(CLK_LOCAL_MEM_FENCE);
if (gidx < cols && gidy < rows)
{
T res = (T)(VAL), temp;
PROCESS_ELEMS;
int dst_index = mad24(gidy, dst_step, mad24(gidx, TSIZE, dst_offset));
#if defined OP_GRADIENT || defined OP_TOPHAT || defined OP_BLACKHAT
int mat_index =  mad24(gidy, mat_step, mad24(gidx, TSIZE, mat_offset));
T value = loadpix(matptr + mat_index);
#ifdef OP_GRADIENT
storepix(convertToT(convertToWT(res) - convertToWT(value)), dstptr + dst_index);
#elif defined OP_TOPHAT
storepix(convertToT(convertToWT(value) - convertToWT(res)), dstptr + dst_index);
#elif defined OP_BLACKHAT
storepix(convertToT(convertToWT(res) - convertToWT(value)), dstptr + dst_index);
#endif
#else
storepix(res, dstptr + dst_index);
#endif
}
}


// buildOptions=-D RADIUSX=1 -D RADIUSY=1 -D LSIZE0=16 -D LSIZE1=16 -D OP_ERODE -D PROCESS_ELEMS=PROCESS(0,0)PROCESS(0,1)PROCESS(0,2)PROCESS(1,0)PROCESS(1,1)PROCESS(1,2)PROCESS(2,0)PROCESS(2,1)PROCESS(2,2) -D T=float4 -D DEPTH_5 -D cn=4 -D T1=float -D convertToWT=noconvert -D convertToT=noconvert -D ST=float4 -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D RADIUSX=1 -D RADIUSY=1 -D LSIZE0=16 -D LSIZE1=16 -D OP_ERODE -D PROCESS_ELEMS=PROCESS(0,0)PROCESS(0,1)PROCESS(0,2)PROCESS(1,0)PROCESS(1,1)PROCESS(1,2)PROCESS(2,0)PROCESS(2,1)PROCESS(2,2) -D T=float4 -D DEPTH_5 -D cn=4 -D T1=float -D convertToWT=noconvert -D convertToT=noconvert -D ST=float4 -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
