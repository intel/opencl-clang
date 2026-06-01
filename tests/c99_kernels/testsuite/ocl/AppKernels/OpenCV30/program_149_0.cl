inline int idx_row_low(int y, int last_row)
{
return abs(y) % (last_row + 1);
}
inline int idx_row_high(int y, int last_row)
{
return abs(last_row - (int)abs(last_row - y)) % (last_row + 1);
}
inline int idx_row(int y, int last_row)
{
return idx_row_low(idx_row_high(y, last_row), last_row);
}
inline int idx_col_low(int x, int last_col)
{
return abs(x) % (last_col + 1);
}
inline int idx_col_high(int x, int last_col)
{
return abs(last_col - (int)abs(last_col - x)) % (last_col + 1);
}
inline int idx_col(int x, int last_col)
{
return idx_col_low(idx_col_high(x, last_col), last_col);
}
__kernel void pyrDown_C1_D0(__global uchar * srcData, int srcStep, int srcRows, int srcCols, __global uchar *dst, int dstStep, int dstCols)
{
const int x = get_global_id(0);
const int y = get_group_id(1);
__local float smem[256 + 4];
float sum;
const int src_y = 2*y;
const int last_row = srcRows - 1;
const int last_col = srcCols - 1;
if (src_y >= 2 && src_y < srcRows - 2 && x >= 2 && x < srcCols - 2)
{
sum =       0.0625f * (((srcData + (src_y - 2) * srcStep))[x]);
sum = sum + 0.25f   * (((srcData + (src_y - 1) * srcStep))[x]);
sum = sum + 0.375f  * (((srcData + (src_y    ) * srcStep))[x]);
sum = sum + 0.25f   * (((srcData + (src_y + 1) * srcStep))[x]);
sum = sum + 0.0625f * (((srcData + (src_y + 2) * srcStep))[x]);
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
sum =       0.0625f * (((srcData + (src_y - 2) * srcStep))[left_x]);
sum = sum + 0.25f   * (((srcData + (src_y - 1) * srcStep))[left_x]);
sum = sum + 0.375f  * (((srcData + (src_y    ) * srcStep))[left_x]);
sum = sum + 0.25f   * (((srcData + (src_y + 1) * srcStep))[left_x]);
sum = sum + 0.0625f * (((srcData + (src_y + 2) * srcStep))[left_x]);
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
sum =       0.0625f * (((srcData + (src_y - 2) * srcStep))[right_x]);
sum = sum + 0.25f   * (((srcData + (src_y - 1) * srcStep))[right_x]);
sum = sum + 0.375f  * (((srcData + (src_y    ) * srcStep))[right_x]);
sum = sum + 0.25f   * (((srcData + (src_y + 1) * srcStep))[right_x]);
sum = sum + 0.0625f * (((srcData + (src_y + 2) * srcStep))[right_x]);
smem[4 + get_local_id(0)] = sum;
}
}
else
{
int col = idx_col(x, last_col);
sum =       0.0625f * (((srcData + idx_row(src_y - 2, last_row) * srcStep))[col]);
sum = sum + 0.25f   * (((srcData + idx_row(src_y - 1, last_row) * srcStep))[col]);
sum = sum + 0.375f  * (((srcData + idx_row(src_y    , last_row) * srcStep))[col]);
sum = sum + 0.25f   * (((srcData + idx_row(src_y + 1, last_row) * srcStep))[col]);
sum = sum + 0.0625f * (((srcData + idx_row(src_y + 2, last_row) * srcStep))[col]);
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
col = idx_col(left_x, last_col);
sum =       0.0625f * (((srcData + idx_row(src_y - 2, last_row) * srcStep))[col]);
sum = sum + 0.25f   * (((srcData + idx_row(src_y - 1, last_row) * srcStep))[col]);
sum = sum + 0.375f  * (((srcData + idx_row(src_y    , last_row) * srcStep))[col]);
sum = sum + 0.25f   * (((srcData + idx_row(src_y + 1, last_row) * srcStep))[col]);
sum = sum + 0.0625f * (((srcData + idx_row(src_y + 2, last_row) * srcStep))[col]);
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
col = idx_col(right_x, last_col);
sum =       0.0625f * (((srcData + idx_row(src_y - 2, last_row) * srcStep))[col]);
sum = sum + 0.25f   * (((srcData + idx_row(src_y - 1, last_row) * srcStep))[col]);
sum = sum + 0.375f  * (((srcData + idx_row(src_y    , last_row) * srcStep))[col]);
sum = sum + 0.25f   * (((srcData + idx_row(src_y + 1, last_row) * srcStep))[col]);
sum = sum + 0.0625f * (((srcData + idx_row(src_y + 2, last_row) * srcStep))[col]);
smem[4 + get_local_id(0)] = sum;
}
}
barrier(CLK_LOCAL_MEM_FENCE);
if (get_local_id(0) < 128)
{
const int tid2 = get_local_id(0) * 2;
sum =       0.0625f * smem[2 + tid2 - 2];
sum = sum + 0.25f   * smem[2 + tid2 - 1];
sum = sum + 0.375f  * smem[2 + tid2    ];
sum = sum + 0.25f   * smem[2 + tid2 + 1];
sum = sum + 0.0625f * smem[2 + tid2 + 2];
const int dst_x = (get_group_id(0) * get_local_size(0) + tid2) / 2;
if (dst_x < dstCols)
dst[y * dstStep + dst_x] = convert_uchar_sat_rte(sum);
}
}
__kernel void pyrDown_C4_D0(__global uchar4 * srcData, int srcStep, int srcRows, int srcCols, __global uchar4 *dst, int dstStep, int dstCols)
{
const int x = get_global_id(0);
const int y = get_group_id(1);
__local float4 smem[256 + 4];
float4 sum;
const int src_y = 2*y;
const int last_row = srcRows - 1;
const int last_col = srcCols - 1;
float4 co1 = 0.375f;
float4 co2 = 0.25f;
float4 co3 = 0.0625f;
if (src_y >= 2 && src_y < srcRows - 2 && x >= 2 && x < srcCols - 2)
{
sum =       co3 * convert_float4((((srcData + (src_y - 2) * srcStep / 4))[x]));
sum = sum + co2 * convert_float4((((srcData + (src_y - 1) * srcStep / 4))[x]));
sum = sum + co1 * convert_float4((((srcData + (src_y    ) * srcStep / 4))[x]));
sum = sum + co2 * convert_float4((((srcData + (src_y + 1) * srcStep / 4))[x]));
sum = sum + co3 * convert_float4((((srcData + (src_y + 2) * srcStep / 4))[x]));
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
sum =       co3 * convert_float4((((srcData + (src_y - 2) * srcStep / 4))[left_x]));
sum = sum + co2 * convert_float4((((srcData + (src_y - 1) * srcStep / 4))[left_x]));
sum = sum + co1 * convert_float4((((srcData + (src_y    ) * srcStep / 4))[left_x]));
sum = sum + co2 * convert_float4((((srcData + (src_y + 1) * srcStep / 4))[left_x]));
sum = sum + co3 * convert_float4((((srcData + (src_y + 2) * srcStep / 4))[left_x]));
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
sum =       co3 * convert_float4((((srcData + (src_y - 2) * srcStep / 4))[right_x]));
sum = sum + co2 * convert_float4((((srcData + (src_y - 1) * srcStep / 4))[right_x]));
sum = sum + co1 * convert_float4((((srcData + (src_y    ) * srcStep / 4))[right_x]));
sum = sum + co2 * convert_float4((((srcData + (src_y + 1) * srcStep / 4))[right_x]));
sum = sum + co3 * convert_float4((((srcData + (src_y + 2) * srcStep / 4))[right_x]));
smem[4 + get_local_id(0)] = sum;
}
}
else
{
int col = idx_col(x, last_col);
sum =       co3 * convert_float4((((srcData + idx_row(src_y - 2, last_row) * srcStep / 4))[col]));
sum = sum + co2 * convert_float4((((srcData + idx_row(src_y - 1, last_row) * srcStep / 4))[col]));
sum = sum + co1 * convert_float4((((srcData + idx_row(src_y    , last_row) * srcStep / 4))[col]));
sum = sum + co2 * convert_float4((((srcData + idx_row(src_y + 1, last_row) * srcStep / 4))[col]));
sum = sum + co3 * convert_float4((((srcData + idx_row(src_y + 2, last_row) * srcStep / 4))[col]));
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
col = idx_col(left_x, last_col);
sum =       co3 * convert_float4((((srcData + idx_row(src_y - 2, last_row) * srcStep / 4))[col]));
sum = sum + co2 * convert_float4((((srcData + idx_row(src_y - 1, last_row) * srcStep / 4))[col]));
sum = sum + co1 * convert_float4((((srcData + idx_row(src_y    , last_row) * srcStep / 4))[col]));
sum = sum + co2 * convert_float4((((srcData + idx_row(src_y + 1, last_row) * srcStep / 4))[col]));
sum = sum + co3 * convert_float4((((srcData + idx_row(src_y + 2, last_row) * srcStep / 4))[col]));
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
col = idx_col(right_x, last_col);
sum =       co3 * convert_float4((((srcData + idx_row(src_y - 2, last_row) * srcStep / 4))[col]));
sum = sum + co2 * convert_float4((((srcData + idx_row(src_y - 1, last_row) * srcStep / 4))[col]));
sum = sum + co1 * convert_float4((((srcData + idx_row(src_y    , last_row) * srcStep / 4))[col]));
sum = sum + co2 * convert_float4((((srcData + idx_row(src_y + 1, last_row) * srcStep / 4))[col]));
sum = sum + co3 * convert_float4((((srcData + idx_row(src_y + 2, last_row) * srcStep / 4))[col]));
smem[4 + get_local_id(0)] = sum;
}
}
barrier(CLK_LOCAL_MEM_FENCE);
if (get_local_id(0) < 128)
{
const int tid2 = get_local_id(0) * 2;
sum =       co3 * smem[2 + tid2 - 2];
sum = sum + co2 * smem[2 + tid2 - 1];
sum = sum + co1 * smem[2 + tid2    ];
sum = sum + co2 * smem[2 + tid2 + 1];
sum = sum + co3 * smem[2 + tid2 + 2];
const int dst_x = (get_group_id(0) * get_local_size(0) + tid2) / 2;
if (dst_x < dstCols)
dst[y * dstStep / 4 + dst_x] = convert_uchar4_sat_rte(sum);
}
}
__kernel void pyrDown_C1_D2(__global ushort * srcData, int srcStep, int srcRows, int srcCols, __global ushort *dst, int dstStep, int dstCols)
{
const int x = get_global_id(0);
const int y = get_group_id(1);
__local float smem[256 + 4];
float sum;
const int src_y = 2*y;
const int last_row = srcRows - 1;
const int last_col = srcCols - 1;
if (src_y >= 2 && src_y < srcRows - 2 && x >= 2 && x < srcCols - 2)
{
sum =       0.0625f * ((__global ushort*)((__global char*)srcData + (src_y - 2) * srcStep))[x];
sum = sum + 0.25f   * ((__global ushort*)((__global char*)srcData + (src_y - 1) * srcStep))[x];
sum = sum + 0.375f  * ((__global ushort*)((__global char*)srcData + (src_y    ) * srcStep))[x];
sum = sum + 0.25f   * ((__global ushort*)((__global char*)srcData + (src_y + 1) * srcStep))[x];
sum = sum + 0.0625f * ((__global ushort*)((__global char*)srcData + (src_y + 2) * srcStep))[x];
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
sum =       0.0625f * ((__global ushort*)((__global char*)srcData + (src_y - 2) * srcStep))[left_x];
sum = sum + 0.25f   * ((__global ushort*)((__global char*)srcData + (src_y - 1) * srcStep))[left_x];
sum = sum + 0.375f  * ((__global ushort*)((__global char*)srcData + (src_y    ) * srcStep))[left_x];
sum = sum + 0.25f   * ((__global ushort*)((__global char*)srcData + (src_y + 1) * srcStep))[left_x];
sum = sum + 0.0625f * ((__global ushort*)((__global char*)srcData + (src_y + 2) * srcStep))[left_x];
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
sum =       0.0625f * ((__global ushort*)((__global char*)srcData + (src_y - 2) * srcStep))[right_x];
sum = sum + 0.25f   * ((__global ushort*)((__global char*)srcData + (src_y - 1) * srcStep))[right_x];
sum = sum + 0.375f  * ((__global ushort*)((__global char*)srcData + (src_y    ) * srcStep))[right_x];
sum = sum + 0.25f   * ((__global ushort*)((__global char*)srcData + (src_y + 1) * srcStep))[right_x];
sum = sum + 0.0625f * ((__global ushort*)((__global char*)srcData + (src_y + 2) * srcStep))[right_x];
smem[4 + get_local_id(0)] = sum;
}
}
else
{
int col = idx_col(x, last_col);
sum =       0.0625f * ((__global ushort*)((__global char*)srcData + idx_row(src_y - 2, last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global ushort*)((__global char*)srcData + idx_row(src_y - 1, last_row) * srcStep))[col];
sum = sum + 0.375f  * ((__global ushort*)((__global char*)srcData + idx_row(src_y    , last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global ushort*)((__global char*)srcData + idx_row(src_y + 1, last_row) * srcStep))[col];
sum = sum + 0.0625f * ((__global ushort*)((__global char*)srcData + idx_row(src_y + 2, last_row) * srcStep))[col];
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
col = idx_col(left_x, last_col);
sum =       0.0625f * ((__global ushort*)((__global char*)srcData + idx_row(src_y - 2, last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global ushort*)((__global char*)srcData + idx_row(src_y - 1, last_row) * srcStep))[col];
sum = sum + 0.375f  * ((__global ushort*)((__global char*)srcData + idx_row(src_y    , last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global ushort*)((__global char*)srcData + idx_row(src_y + 1, last_row) * srcStep))[col];
sum = sum + 0.0625f * ((__global ushort*)((__global char*)srcData + idx_row(src_y + 2, last_row) * srcStep))[col];
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
col = idx_col(right_x, last_col);
sum =       0.0625f * ((__global ushort*)((__global char*)srcData + idx_row(src_y - 2, last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global ushort*)((__global char*)srcData + idx_row(src_y - 1, last_row) * srcStep))[col];
sum = sum + 0.375f  * ((__global ushort*)((__global char*)srcData + idx_row(src_y    , last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global ushort*)((__global char*)srcData + idx_row(src_y + 1, last_row) * srcStep))[col];
sum = sum + 0.0625f * ((__global ushort*)((__global char*)srcData + idx_row(src_y + 2, last_row) * srcStep))[col];
smem[4 + get_local_id(0)] = sum;
}
}
barrier(CLK_LOCAL_MEM_FENCE);
if (get_local_id(0) < 128)
{
const int tid2 = get_local_id(0) * 2;
sum =       0.0625f * smem[2 + tid2 - 2];
sum = sum + 0.25f   * smem[2 + tid2 - 1];
sum = sum + 0.375f  * smem[2 + tid2    ];
sum = sum + 0.25f   * smem[2 + tid2 + 1];
sum = sum + 0.0625f * smem[2 + tid2 + 2];
const int dst_x = (get_group_id(0) * get_local_size(0) + tid2) / 2;
if (dst_x < dstCols)
dst[y * dstStep / 2 + dst_x] = convert_ushort_sat_rte(sum);
}
}
__kernel void pyrDown_C4_D2(__global ushort4 * srcData, int srcStep, int srcRows, int srcCols, __global ushort4 *dst, int dstStep, int dstCols)
{
const int x = get_global_id(0);
const int y = get_group_id(1);
__local float4 smem[256 + 4];
float4 sum;
const int src_y = 2*y;
const int last_row = srcRows - 1;
const int last_col = srcCols - 1;
float4 co1 = 0.375f;
float4 co2 = 0.25f;
float4 co3 = 0.0625f;
if (src_y >= 2 && src_y < srcRows - 2 && x >= 2 && x < srcCols - 2)
{
sum =       co3 * convert_float4(((__global ushort4*)((__global char4*)srcData + (src_y - 2) * srcStep / 4))[x]);
sum = sum + co2 * convert_float4(((__global ushort4*)((__global char4*)srcData + (src_y - 1) * srcStep / 4))[x]);
sum = sum + co1 * convert_float4(((__global ushort4*)((__global char4*)srcData + (src_y    ) * srcStep / 4))[x]);
sum = sum + co2 * convert_float4(((__global ushort4*)((__global char4*)srcData + (src_y + 1) * srcStep / 4))[x]);
sum = sum + co3 * convert_float4(((__global ushort4*)((__global char4*)srcData + (src_y + 2) * srcStep / 4))[x]);
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
sum =       co3 * convert_float4(((__global ushort4*)((__global char4*)srcData + (src_y - 2) * srcStep / 4))[left_x]);
sum = sum + co2 * convert_float4(((__global ushort4*)((__global char4*)srcData + (src_y - 1) * srcStep / 4))[left_x]);
sum = sum + co1 * convert_float4(((__global ushort4*)((__global char4*)srcData + (src_y    ) * srcStep / 4))[left_x]);
sum = sum + co2 * convert_float4(((__global ushort4*)((__global char4*)srcData + (src_y + 1) * srcStep / 4))[left_x]);
sum = sum + co3 * convert_float4(((__global ushort4*)((__global char4*)srcData + (src_y + 2) * srcStep / 4))[left_x]);
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
sum =       co3 * convert_float4(((__global ushort4*)((__global char4*)srcData + (src_y - 2) * srcStep / 4))[right_x]);
sum = sum + co2 * convert_float4(((__global ushort4*)((__global char4*)srcData + (src_y - 1) * srcStep / 4))[right_x]);
sum = sum + co1 * convert_float4(((__global ushort4*)((__global char4*)srcData + (src_y    ) * srcStep / 4))[right_x]);
sum = sum + co2 * convert_float4(((__global ushort4*)((__global char4*)srcData + (src_y + 1) * srcStep / 4))[right_x]);
sum = sum + co3 * convert_float4(((__global ushort4*)((__global char4*)srcData + (src_y + 2) * srcStep / 4))[right_x]);
smem[4 + get_local_id(0)] = sum;
}
}
else
{
int col = idx_col(x, last_col);
sum =       co3 * convert_float4(((__global ushort4*)((__global char4*)srcData + idx_row(src_y - 2, last_row) * srcStep / 4))[col]);
sum = sum + co2 * convert_float4(((__global ushort4*)((__global char4*)srcData + idx_row(src_y - 1, last_row) * srcStep / 4))[col]);
sum = sum + co1 * convert_float4(((__global ushort4*)((__global char4*)srcData + idx_row(src_y    , last_row) * srcStep / 4))[col]);
sum = sum + co2 * convert_float4(((__global ushort4*)((__global char4*)srcData + idx_row(src_y + 1, last_row) * srcStep / 4))[col]);
sum = sum + co3 * convert_float4(((__global ushort4*)((__global char4*)srcData + idx_row(src_y + 2, last_row) * srcStep / 4))[col]);
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
col = idx_col(left_x, last_col);
sum =       co3 * convert_float4(((__global ushort4*)((__global char4*)srcData + idx_row(src_y - 2, last_row) * srcStep / 4))[col]);
sum = sum + co2 * convert_float4(((__global ushort4*)((__global char4*)srcData + idx_row(src_y - 1, last_row) * srcStep / 4))[col]);
sum = sum + co1 * convert_float4(((__global ushort4*)((__global char4*)srcData + idx_row(src_y    , last_row) * srcStep / 4))[col]);
sum = sum + co2 * convert_float4(((__global ushort4*)((__global char4*)srcData + idx_row(src_y + 1, last_row) * srcStep / 4))[col]);
sum = sum + co3 * convert_float4(((__global ushort4*)((__global char4*)srcData + idx_row(src_y + 2, last_row) * srcStep / 4))[col]);
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
col = idx_col(right_x, last_col);
sum =       co3 * convert_float4(((__global ushort4*)((__global char4*)srcData + idx_row(src_y - 2, last_row) * srcStep / 4))[col]);
sum = sum + co2 * convert_float4(((__global ushort4*)((__global char4*)srcData + idx_row(src_y - 1, last_row) * srcStep / 4))[col]);
sum = sum + co1 * convert_float4(((__global ushort4*)((__global char4*)srcData + idx_row(src_y    , last_row) * srcStep / 4))[col]);
sum = sum + co2 * convert_float4(((__global ushort4*)((__global char4*)srcData + idx_row(src_y + 1, last_row) * srcStep / 4))[col]);
sum = sum + co3 * convert_float4(((__global ushort4*)((__global char4*)srcData + idx_row(src_y + 2, last_row) * srcStep / 4))[col]);
smem[4 + get_local_id(0)] = sum;
}
}
barrier(CLK_LOCAL_MEM_FENCE);
if (get_local_id(0) < 128)
{
const int tid2 = get_local_id(0) * 2;
sum =       co3 * smem[2 + tid2 - 2];
sum = sum + co2 * smem[2 + tid2 - 1];
sum = sum + co1 * smem[2 + tid2    ];
sum = sum + co2 * smem[2 + tid2 + 1];
sum = sum + co3 * smem[2 + tid2 + 2];
const int dst_x = (get_group_id(0) * get_local_size(0) + tid2) / 2;
if (dst_x < dstCols)
dst[y * dstStep / 8 + dst_x] = convert_ushort4_sat_rte(sum);
}
}
__kernel void pyrDown_C1_D3(__global short * srcData, int srcStep, int srcRows, int srcCols, __global short *dst, int dstStep, int dstCols)
{
const int x = get_global_id(0);
const int y = get_group_id(1);
__local float smem[256 + 4];
float sum;
const int src_y = 2*y;
const int last_row = srcRows - 1;
const int last_col = srcCols - 1;
if (src_y >= 2 && src_y < srcRows - 2 && x >= 2 && x < srcCols - 2)
{
sum =       0.0625f * ((__global short*)((__global char*)srcData + (src_y - 2) * srcStep))[x];
sum = sum + 0.25f   * ((__global short*)((__global char*)srcData + (src_y - 1) * srcStep))[x];
sum = sum + 0.375f  * ((__global short*)((__global char*)srcData + (src_y    ) * srcStep))[x];
sum = sum + 0.25f   * ((__global short*)((__global char*)srcData + (src_y + 1) * srcStep))[x];
sum = sum + 0.0625f * ((__global short*)((__global char*)srcData + (src_y + 2) * srcStep))[x];
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
sum =       0.0625f * ((__global short*)((__global char*)srcData + (src_y - 2) * srcStep))[left_x];
sum = sum + 0.25f   * ((__global short*)((__global char*)srcData + (src_y - 1) * srcStep))[left_x];
sum = sum + 0.375f  * ((__global short*)((__global char*)srcData + (src_y    ) * srcStep))[left_x];
sum = sum + 0.25f   * ((__global short*)((__global char*)srcData + (src_y + 1) * srcStep))[left_x];
sum = sum + 0.0625f * ((__global short*)((__global char*)srcData + (src_y + 2) * srcStep))[left_x];
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
sum =       0.0625f * ((__global short*)((__global char*)srcData + (src_y - 2) * srcStep))[right_x];
sum = sum + 0.25f   * ((__global short*)((__global char*)srcData + (src_y - 1) * srcStep))[right_x];
sum = sum + 0.375f  * ((__global short*)((__global char*)srcData + (src_y    ) * srcStep))[right_x];
sum = sum + 0.25f   * ((__global short*)((__global char*)srcData + (src_y + 1) * srcStep))[right_x];
sum = sum + 0.0625f * ((__global short*)((__global char*)srcData + (src_y + 2) * srcStep))[right_x];
smem[4 + get_local_id(0)] = sum;
}
}
else
{
int col = idx_col(x, last_col);
sum =       0.0625f * ((__global short*)((__global char*)srcData + idx_row(src_y - 2, last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global short*)((__global char*)srcData + idx_row(src_y - 1, last_row) * srcStep))[col];
sum = sum + 0.375f  * ((__global short*)((__global char*)srcData + idx_row(src_y    , last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global short*)((__global char*)srcData + idx_row(src_y + 1, last_row) * srcStep))[col];
sum = sum + 0.0625f * ((__global short*)((__global char*)srcData + idx_row(src_y + 2, last_row) * srcStep))[col];
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
col = idx_col(left_x, last_col);
sum =       0.0625f * ((__global short*)((__global char*)srcData + idx_row(src_y - 2, last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global short*)((__global char*)srcData + idx_row(src_y - 1, last_row) * srcStep))[col];
sum = sum + 0.375f  * ((__global short*)((__global char*)srcData + idx_row(src_y    , last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global short*)((__global char*)srcData + idx_row(src_y + 1, last_row) * srcStep))[col];
sum = sum + 0.0625f * ((__global short*)((__global char*)srcData + idx_row(src_y + 2, last_row) * srcStep))[col];
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
col = idx_col(right_x, last_col);
sum =       0.0625f * ((__global short*)((__global char*)srcData + idx_row(src_y - 2, last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global short*)((__global char*)srcData + idx_row(src_y - 1, last_row) * srcStep))[col];
sum = sum + 0.375f  * ((__global short*)((__global char*)srcData + idx_row(src_y    , last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global short*)((__global char*)srcData + idx_row(src_y + 1, last_row) * srcStep))[col];
sum = sum + 0.0625f * ((__global short*)((__global char*)srcData + idx_row(src_y + 2, last_row) * srcStep))[col];
smem[4 + get_local_id(0)] = sum;
}
}
barrier(CLK_LOCAL_MEM_FENCE);
if (get_local_id(0) < 128)
{
const int tid2 = get_local_id(0) * 2;
sum =       0.0625f * smem[2 + tid2 - 2];
sum = sum + 0.25f   * smem[2 + tid2 - 1];
sum = sum + 0.375f  * smem[2 + tid2    ];
sum = sum + 0.25f   * smem[2 + tid2 + 1];
sum = sum + 0.0625f * smem[2 + tid2 + 2];
const int dst_x = (get_group_id(0) * get_local_size(0) + tid2) / 2;
if (dst_x < dstCols)
dst[y * dstStep / 2 + dst_x] = convert_short_sat_rte(sum);
}
}
__kernel void pyrDown_C4_D3(__global short4 * srcData, int srcStep, int srcRows, int srcCols, __global short4 *dst, int dstStep, int dstCols)
{
const int x = get_global_id(0);
const int y = get_group_id(1);
__local float4 smem[256 + 4];
float4 sum;
const int src_y = 2*y;
const int last_row = srcRows - 1;
const int last_col = srcCols - 1;
float4 co1 = 0.375f;
float4 co2 = 0.25f;
float4 co3 = 0.0625f;
if (src_y >= 2 && src_y < srcRows - 2 && x >= 2 && x < srcCols - 2)
{
sum =       co3 * convert_float4(((__global short4*)((__global char4*)srcData + (src_y - 2) * srcStep / 4))[x]);
sum = sum + co2 * convert_float4(((__global short4*)((__global char4*)srcData + (src_y - 1) * srcStep / 4))[x]);
sum = sum + co1 * convert_float4(((__global short4*)((__global char4*)srcData + (src_y    ) * srcStep / 4))[x]);
sum = sum + co2 * convert_float4(((__global short4*)((__global char4*)srcData + (src_y + 1) * srcStep / 4))[x]);
sum = sum + co3 * convert_float4(((__global short4*)((__global char4*)srcData + (src_y + 2) * srcStep / 4))[x]);
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
sum =       co3 * convert_float4(((__global short4*)((__global char4*)srcData + (src_y - 2) * srcStep / 4))[left_x]);
sum = sum + co2 * convert_float4(((__global short4*)((__global char4*)srcData + (src_y - 1) * srcStep / 4))[left_x]);
sum = sum + co1 * convert_float4(((__global short4*)((__global char4*)srcData + (src_y    ) * srcStep / 4))[left_x]);
sum = sum + co2 * convert_float4(((__global short4*)((__global char4*)srcData + (src_y + 1) * srcStep / 4))[left_x]);
sum = sum + co3 * convert_float4(((__global short4*)((__global char4*)srcData + (src_y + 2) * srcStep / 4))[left_x]);
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
sum =       co3 * convert_float4(((__global short4*)((__global char4*)srcData + (src_y - 2) * srcStep / 4))[right_x]);
sum = sum + co2 * convert_float4(((__global short4*)((__global char4*)srcData + (src_y - 1) * srcStep / 4))[right_x]);
sum = sum + co1 * convert_float4(((__global short4*)((__global char4*)srcData + (src_y    ) * srcStep / 4))[right_x]);
sum = sum + co2 * convert_float4(((__global short4*)((__global char4*)srcData + (src_y + 1) * srcStep / 4))[right_x]);
sum = sum + co3 * convert_float4(((__global short4*)((__global char4*)srcData + (src_y + 2) * srcStep / 4))[right_x]);
smem[4 + get_local_id(0)] = sum;
}
}
else
{
int col = idx_col(x, last_col);
sum =       co3 * convert_float4(((__global short4*)((__global char4*)srcData + idx_row(src_y - 2, last_row) * srcStep / 4))[col]);
sum = sum + co2 * convert_float4(((__global short4*)((__global char4*)srcData + idx_row(src_y - 1, last_row) * srcStep / 4))[col]);
sum = sum + co1 * convert_float4(((__global short4*)((__global char4*)srcData + idx_row(src_y    , last_row) * srcStep / 4))[col]);
sum = sum + co2 * convert_float4(((__global short4*)((__global char4*)srcData + idx_row(src_y + 1, last_row) * srcStep / 4))[col]);
sum = sum + co3 * convert_float4(((__global short4*)((__global char4*)srcData + idx_row(src_y + 2, last_row) * srcStep / 4))[col]);
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
col = idx_col(left_x, last_col);
sum =       co3 * convert_float4(((__global short4*)((__global char4*)srcData + idx_row(src_y - 2, last_row) * srcStep / 4))[col]);
sum = sum + co2 * convert_float4(((__global short4*)((__global char4*)srcData + idx_row(src_y - 1, last_row) * srcStep / 4))[col]);
sum = sum + co1 * convert_float4(((__global short4*)((__global char4*)srcData + idx_row(src_y    , last_row) * srcStep / 4))[col]);
sum = sum + co2 * convert_float4(((__global short4*)((__global char4*)srcData + idx_row(src_y + 1, last_row) * srcStep / 4))[col]);
sum = sum + co3 * convert_float4(((__global short4*)((__global char4*)srcData + idx_row(src_y + 2, last_row) * srcStep / 4))[col]);
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
col = idx_col(right_x, last_col);
sum =       co3 * convert_float4(((__global short4*)((__global char4*)srcData + idx_row(src_y - 2, last_row) * srcStep / 4))[col]);
sum = sum + co2 * convert_float4(((__global short4*)((__global char4*)srcData + idx_row(src_y - 1, last_row) * srcStep / 4))[col]);
sum = sum + co1 * convert_float4(((__global short4*)((__global char4*)srcData + idx_row(src_y    , last_row) * srcStep / 4))[col]);
sum = sum + co2 * convert_float4(((__global short4*)((__global char4*)srcData + idx_row(src_y + 1, last_row) * srcStep / 4))[col]);
sum = sum + co3 * convert_float4(((__global short4*)((__global char4*)srcData + idx_row(src_y + 2, last_row) * srcStep / 4))[col]);
smem[4 + get_local_id(0)] = sum;
}
}
barrier(CLK_LOCAL_MEM_FENCE);
if (get_local_id(0) < 128)
{
const int tid2 = get_local_id(0) * 2;
sum =       co3 * smem[2 + tid2 - 2];
sum = sum + co2 * smem[2 + tid2 - 1];
sum = sum + co1 * smem[2 + tid2    ];
sum = sum + co2 * smem[2 + tid2 + 1];
sum = sum + co3 * smem[2 + tid2 + 2];
const int dst_x = (get_group_id(0) * get_local_size(0) + tid2) / 2;
if (dst_x < dstCols)
dst[y * dstStep / 8 + dst_x] = convert_short4_sat_rte(sum);
}
}
__kernel void pyrDown_C1_D5(__global float * srcData, int srcStep, int srcRows, int srcCols, __global float *dst, int dstStep, int dstCols)
{
const int x = get_global_id(0);
const int y = get_group_id(1);
__local float smem[256 + 4];
float sum;
const int src_y = 2*y;
const int last_row = srcRows - 1;
const int last_col = srcCols - 1;
if (src_y >= 2 && src_y < srcRows - 2 && x >= 2 && x < srcCols - 2)
{
sum =       0.0625f * ((__global float*)((__global char*)srcData + (src_y - 2) * srcStep))[x];
sum = sum + 0.25f   * ((__global float*)((__global char*)srcData + (src_y - 1) * srcStep))[x];
sum = sum + 0.375f  * ((__global float*)((__global char*)srcData + (src_y    ) * srcStep))[x];
sum = sum + 0.25f   * ((__global float*)((__global char*)srcData + (src_y + 1) * srcStep))[x];
sum = sum + 0.0625f * ((__global float*)((__global char*)srcData + (src_y + 2) * srcStep))[x];
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
sum =       0.0625f * ((__global float*)((__global char*)srcData + (src_y - 2) * srcStep))[left_x];
sum = sum + 0.25f   * ((__global float*)((__global char*)srcData + (src_y - 1) * srcStep))[left_x];
sum = sum + 0.375f  * ((__global float*)((__global char*)srcData + (src_y    ) * srcStep))[left_x];
sum = sum + 0.25f   * ((__global float*)((__global char*)srcData + (src_y + 1) * srcStep))[left_x];
sum = sum + 0.0625f * ((__global float*)((__global char*)srcData + (src_y + 2) * srcStep))[left_x];
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
sum =       0.0625f * ((__global float*)((__global char*)srcData + (src_y - 2) * srcStep))[right_x];
sum = sum + 0.25f   * ((__global float*)((__global char*)srcData + (src_y - 1) * srcStep))[right_x];
sum = sum + 0.375f  * ((__global float*)((__global char*)srcData + (src_y    ) * srcStep))[right_x];
sum = sum + 0.25f   * ((__global float*)((__global char*)srcData + (src_y + 1) * srcStep))[right_x];
sum = sum + 0.0625f * ((__global float*)((__global char*)srcData + (src_y + 2) * srcStep))[right_x];
smem[4 + get_local_id(0)] = sum;
}
}
else
{
int col = idx_col(x, last_col);
sum =       0.0625f * ((__global float*)((__global char*)srcData + idx_row(src_y - 2, last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global float*)((__global char*)srcData + idx_row(src_y - 1, last_row) * srcStep))[col];
sum = sum + 0.375f  * ((__global float*)((__global char*)srcData + idx_row(src_y    , last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global float*)((__global char*)srcData + idx_row(src_y + 1, last_row) * srcStep))[col];
sum = sum + 0.0625f * ((__global float*)((__global char*)srcData + idx_row(src_y + 2, last_row) * srcStep))[col];
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
col = idx_col(left_x, last_col);
sum =       0.0625f * ((__global float*)((__global char*)srcData + idx_row(src_y - 2, last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global float*)((__global char*)srcData + idx_row(src_y - 1, last_row) * srcStep))[col];
sum = sum + 0.375f  * ((__global float*)((__global char*)srcData + idx_row(src_y    , last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global float*)((__global char*)srcData + idx_row(src_y + 1, last_row) * srcStep))[col];
sum = sum + 0.0625f * ((__global float*)((__global char*)srcData + idx_row(src_y + 2, last_row) * srcStep))[col];
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
col = idx_col(right_x, last_col);
sum =       0.0625f * ((__global float*)((__global char*)srcData + idx_row(src_y - 2, last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global float*)((__global char*)srcData + idx_row(src_y - 1, last_row) * srcStep))[col];
sum = sum + 0.375f  * ((__global float*)((__global char*)srcData + idx_row(src_y    , last_row) * srcStep))[col];
sum = sum + 0.25f   * ((__global float*)((__global char*)srcData + idx_row(src_y + 1, last_row) * srcStep))[col];
sum = sum + 0.0625f * ((__global float*)((__global char*)srcData + idx_row(src_y + 2, last_row) * srcStep))[col];
smem[4 + get_local_id(0)] = sum;
}
}
barrier(CLK_LOCAL_MEM_FENCE);
if (get_local_id(0) < 128)
{
const int tid2 = get_local_id(0) * 2;
sum =       0.0625f * smem[2 + tid2 - 2];
sum = sum + 0.25f   * smem[2 + tid2 - 1];
sum = sum + 0.375f  * smem[2 + tid2    ];
sum = sum + 0.25f   * smem[2 + tid2 + 1];
sum = sum + 0.0625f * smem[2 + tid2 + 2];
const int dst_x = (get_group_id(0) * get_local_size(0) + tid2) / 2;
if (dst_x < dstCols)
dst[y * dstStep / 4 + dst_x] = sum;
}
}
__kernel void pyrDown_C4_D5(__global float4 * srcData, int srcStep, int srcRows, int srcCols, __global float4 *dst, int dstStep, int dstCols)
{
const int x = get_global_id(0);
const int y = get_group_id(1);
__local float4 smem[256 + 4];
float4 sum;
const int src_y = 2*y;
const int last_row = srcRows - 1;
const int last_col = srcCols - 1;
float4 co1 = 0.375f;
float4 co2 = 0.25f;
float4 co3 = 0.0625f;
if (src_y >= 2 && src_y < srcRows - 2 && x >= 2 && x < srcCols - 2)
{
sum =       co3 * ((__global float4*)((__global char4*)srcData + (src_y - 2) * srcStep / 4))[x];
sum = sum + co2 * ((__global float4*)((__global char4*)srcData + (src_y - 1) * srcStep / 4))[x];
sum = sum + co1 * ((__global float4*)((__global char4*)srcData + (src_y    ) * srcStep / 4))[x];
sum = sum + co2 * ((__global float4*)((__global char4*)srcData + (src_y + 1) * srcStep / 4))[x];
sum = sum + co3 * ((__global float4*)((__global char4*)srcData + (src_y + 2) * srcStep / 4))[x];
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
sum =       co3 * ((__global float4*)((__global char4*)srcData + (src_y - 2) * srcStep / 4))[left_x];
sum = sum + co2 * ((__global float4*)((__global char4*)srcData + (src_y - 1) * srcStep / 4))[left_x];
sum = sum + co1 * ((__global float4*)((__global char4*)srcData + (src_y    ) * srcStep / 4))[left_x];
sum = sum + co2 * ((__global float4*)((__global char4*)srcData + (src_y + 1) * srcStep / 4))[left_x];
sum = sum + co3 * ((__global float4*)((__global char4*)srcData + (src_y + 2) * srcStep / 4))[left_x];
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
sum =       co3 * ((__global float4*)((__global char4*)srcData + (src_y - 2) * srcStep / 4))[right_x];
sum = sum + co2 * ((__global float4*)((__global char4*)srcData + (src_y - 1) * srcStep / 4))[right_x];
sum = sum + co1 * ((__global float4*)((__global char4*)srcData + (src_y    ) * srcStep / 4))[right_x];
sum = sum + co2 * ((__global float4*)((__global char4*)srcData + (src_y + 1) * srcStep / 4))[right_x];
sum = sum + co3 * ((__global float4*)((__global char4*)srcData + (src_y + 2) * srcStep / 4))[right_x];
smem[4 + get_local_id(0)] = sum;
}
}
else
{
int col = idx_col(x, last_col);
sum =       co3 * ((__global float4*)((__global char4*)srcData + idx_row(src_y - 2, last_row) * srcStep / 4))[col];
sum = sum + co2 * ((__global float4*)((__global char4*)srcData + idx_row(src_y - 1, last_row) * srcStep / 4))[col];
sum = sum + co1 * ((__global float4*)((__global char4*)srcData + idx_row(src_y    , last_row) * srcStep / 4))[col];
sum = sum + co2 * ((__global float4*)((__global char4*)srcData + idx_row(src_y + 1, last_row) * srcStep / 4))[col];
sum = sum + co3 * ((__global float4*)((__global char4*)srcData + idx_row(src_y + 2, last_row) * srcStep / 4))[col];
smem[2 + get_local_id(0)] = sum;
if (get_local_id(0) < 2)
{
const int left_x = x - 2;
col = idx_col(left_x, last_col);
sum =       co3 * ((__global float4*)((__global char4*)srcData + idx_row(src_y - 2, last_row) * srcStep / 4))[col];
sum = sum + co2 * ((__global float4*)((__global char4*)srcData + idx_row(src_y - 1, last_row) * srcStep / 4))[col];
sum = sum + co1 * ((__global float4*)((__global char4*)srcData + idx_row(src_y    , last_row) * srcStep / 4))[col];
sum = sum + co2 * ((__global float4*)((__global char4*)srcData + idx_row(src_y + 1, last_row) * srcStep / 4))[col];
sum = sum + co3 * ((__global float4*)((__global char4*)srcData + idx_row(src_y + 2, last_row) * srcStep / 4))[col];
smem[get_local_id(0)] = sum;
}
if (get_local_id(0) > 253)
{
const int right_x = x + 2;
col = idx_col(right_x, last_col);
sum =       co3 * ((__global float4*)((__global char4*)srcData + idx_row(src_y - 2, last_row) * srcStep / 4))[col];
sum = sum + co2 * ((__global float4*)((__global char4*)srcData + idx_row(src_y - 1, last_row) * srcStep / 4))[col];
sum = sum + co1 * ((__global float4*)((__global char4*)srcData + idx_row(src_y    , last_row) * srcStep / 4))[col];
sum = sum + co2 * ((__global float4*)((__global char4*)srcData + idx_row(src_y + 1, last_row) * srcStep / 4))[col];
sum = sum + co3 * ((__global float4*)((__global char4*)srcData + idx_row(src_y + 2, last_row) * srcStep / 4))[col];
smem[4 + get_local_id(0)] = sum;
}
}
barrier(CLK_LOCAL_MEM_FENCE);
if (get_local_id(0) < 128)
{
const int tid2 = get_local_id(0) * 2;
sum =       co3 * smem[2 + tid2 - 2];
sum = sum + co2 * smem[2 + tid2 - 1];
sum = sum + co1 * smem[2 + tid2    ];
sum = sum + co2 * smem[2 + tid2 + 1];
sum = sum + co3 * smem[2 + tid2 + 2];
const int dst_x = (get_group_id(0) * get_local_size(0) + tid2) / 2;
if (dst_x < dstCols)
dst[y * dstStep / 16 + dst_x] = sum;
}
}


// buildOptions= -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
