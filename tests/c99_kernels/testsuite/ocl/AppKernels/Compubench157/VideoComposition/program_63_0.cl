
__kernel void mosaicKernelHorizontal (
	read_only image2d_t imgIn,
	global uint4* restrict result,
	const int mosaicWidth,
	const int imgWidth)
{
	const sampler_t smp = CLK_ADDRESS_CLAMP;
	const int2 pos = (int2)(get_global_id(0), get_global_id(1));
	const int endX = min(imgWidth, (pos.x+1)*mosaicWidth);
	uint4 val = (uint4)(0,0,0,0);

	for (int x=pos.x*mosaicWidth; x<endX; x++)
		val += read_imageui(imgIn, smp, (int2)(x,pos.y));

	result[pos.y * get_global_size(0) + pos.x] = val;
}


__kernel void mosaicKernelVertical (
	global uint4 *data,
	const int mosaicHeight,
	const int mosaicSize,
	const int height)
{
	const int2 pos = (int2)(get_global_id(0), get_global_id(1));
	const int endY = min(height, (pos.y+1)*mosaicHeight);
	uint4 val = (uint4)(0,0,0,0);

	for (int y=pos.y*mosaicHeight; y<endY; y++)
		val += data[y * get_global_size(0) + pos.x];

	data[pos.y * get_global_size(0) * mosaicHeight + pos.x] = val / mosaicSize;
}


__kernel void mosaicKernelFinish (
	write_only image2d_t imgOut,
	global uint4 *data,
	const int mosaicSize,
	const int mosaicCountX,
	const int mosaicWidth,
	const int mosaicHeight)
{
	const int2 pos = (int2)(get_global_id(0), get_global_id(1));
	const uint4 color = data[(pos.y / mosaicHeight)*mosaicCountX*mosaicHeight + (pos.x / mosaicWidth)];

	write_imageui(imgOut, pos, color);
}


__kernel void mosaicKernel(
	read_only image2d_t imgIn,
	write_only image2d_t imgOut,
	const int w,
	const int h,
	const int width,
	const int height)
{
	const sampler_t smp = CLK_ADDRESS_CLAMP;
	int x = get_global_id(0);
	int y = get_global_id(1);
	int px, py;
	int xEnd = min((x+1)*w, width);
	int yEnd = min((y+1)*h, height);
	uint4 color = (uint4)(0,0,0,0);

	for (px=x*w; px<xEnd; px++)
		for (py=y*h; py<yEnd; py++) {
			uint4 c = read_imageui(imgIn, smp, (int2)(px, py));
			color += c;
		}

	color /= ((xEnd - x*w) * (yEnd - y*h));

	for (px=x*w; px<xEnd; px++)
		for (py=y*h; py<yEnd; py++)
			write_imageui(imgOut, (int2)(px, py), color);
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
