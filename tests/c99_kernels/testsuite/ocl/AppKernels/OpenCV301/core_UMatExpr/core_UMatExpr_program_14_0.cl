#if kercn != 3
#define storepix(val, addr)  *(__global T *)(addr) = val
#define TSIZE (int)sizeof(T)
#define scalar scalar_
#else
#define storepix(val, addr) vstore3(val, 0, (__global T1 *)(addr))
#define TSIZE ((int)sizeof(T1)*3)
#define scalar (T)(scalar_.x, scalar_.y, scalar_.z)
#endif
__kernel void setIdentity(__global uchar * srcptr, int src_step, int src_offset, int rows, int cols,
ST scalar_)
{
int x = get_global_id(0);
int y0 = get_global_id(1) * rowsPerWI;
if (x < cols)
{
int src_index = mad24(y0, src_step, mad24(x, TSIZE, src_offset));
#if kercn == cn
#pragma unroll
for (int y = y0, i = 0, y1 = min(rows, y0 + rowsPerWI); i < rowsPerWI; ++y, ++i, src_index += src_step)
if (y < y1)
storepix(x == y ? scalar : (T)(0), srcptr + src_index);
#elif kercn == 4 && cn == 1
if (y0 < rows)
{
storepix(x == y0 >> 2 ? (T)(scalar, 0, 0, 0) : (T)(0), srcptr + src_index);
if (++y0 < rows)
{
src_index += src_step;
storepix(x == y0 >> 2 ? (T)(0, scalar, 0, 0) : (T)(0), srcptr + src_index);
if (++y0 < rows)
{
src_index += src_step;
storepix(x == y0 >> 2 ? (T)(0, 0, scalar, 0) : (T)(0), srcptr + src_index);
if (++y0 < rows)
{
src_index += src_step;
storepix(x == y0 >> 2 ? (T)(0, 0, 0, scalar) : (T)(0), srcptr + src_index);
}
}
}
}
#else
#error "Incorrect combination of cn && kercn"
#endif
}
}


// buildOptions=-D T=short2 -D T1=short -D cn=2 -D ST=short2 -D kercn=2 -D rowsPerWI=4 -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D T=short2 -D T1=short -D cn=2 -D ST=short2 -D kercn=2 -D rowsPerWI=4 -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
