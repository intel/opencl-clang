#include "clpp.cl.h"

__kernel
void RunFixedFilter(__global uchar* src, __global short* dst, uint width, uint height, uint srcStride, uint dstStride, uint addressMode, clpp_kernel_type kernelType)
{
	uint2 coords = (uint2)(get_group_id(0) * BLK_X, get_group_id(1) * BLK_Y);

	clpp_buffer2d_desc src_desc;
	src_desc.ptr = src;
	src_desc.width = width;
	src_desc.height = height;
	src_desc.stride = srcStride;

	clpp_buffer2d_desc dst_desc;
	dst_desc.ptr = (global uchar*)dst;
	dst_desc.width = width;
	dst_desc.height = height;
	dst_desc.stride = dstStride * 2;

	local uchar4 lmemA4[ CLPP_LMEM_U8_SIZE( BLK_X, BLK_Y, K3X3 ) >> 2 ];
	local uchar* lmemA = (local uchar*)lmemA4;

	local short2 lmemB2[ CLPP_LMEM_S16_SIZE( BLK_X, BLK_Y, K3X3 ) >> 1 ];
	local short* lmemB = (local short*)lmemB2;

	clpp_read_block_8u_wg(
		src_desc,
		lmemA,
		coords,
		CLPP_LMEM_BLK_ID( BLK_X, BLK_Y, K3X3 ),
		addressMode
		);

	// Synchronize the read into LMEM
	barrier(CLK_LOCAL_MEM_FENCE);

  // Pre-processing code
  // ...

	clpp_filter_fixed_3x3_8u16s_wg(
		lmemA,
		lmemB,
		kernelType,
		CLPP_LMEM_BLK_ID( BLK_X, BLK_Y, K3X3 )
		);

  // Post-processing code
  // ...

	clpp_write_block_16s_wg(
		lmemB,
		dst_desc,
		coords,
		CLPP_LMEM_BLK_ID( BLK_X, BLK_Y, K3X3 )
		);
}

/*****************************************************************************

Copyright 2012 - 2013 Intel Corporation All Rights Reserved.

    The source code contained or described herein and all documents related to
    the source code ("Material") are owned by Intel Corporation or its suppliers
    or licensors. Title to the Material remains with Intel Corporation or its
    suppliers and licensors. The Material contains trade secrets and proprietary
    and confidential information of Intel or its suppliers and licensors. The
    Material is protected by worldwide copyright and trade secret laws and
    treaty provisions. No part of the Material may be used, copied, reproduced,
    modified, published, uploaded, posted, transmitted, distributed, or
    disclosed in any way without Intel's prior express written permission.

    No license under any patent, copyright, trade secret or other intellectual
    property right is granted to or conferred upon you by disclosure or delivery
    of the Materials, either expressly, by implication, inducement, estoppel or
    otherwise. Any license under such intellectual property rights must be
    express and approved by Intel in writing.

File Name: clpp.cl

Version:
	0.5
Abstract:
	The following is additional round of tunning the HPP Device-side APIs to
	Better match Intel GPU hardware.
*****************************************************************************/

#include "clpp.cl.h"

// ---------------------------- CLPP Internal Helper APIs ---------------------------
//
// --------------------------------------------------------------------
uint getBlockSizeX(uint block_id) {
	uint res = block_id >> CLPP_BLK_BLK_X_OFFSET;
	res = res & 0xF;
	res = 16 << res;
	return res;
}

uint getBlockSizeY(uint block_id) {
	uint res = block_id >> CLPP_BLK_BLK_Y_OFFSET;
	res = res & 0xF;
	res = 1 << res;
	return res;
}

uint getBlockBorderX(uint block_id, size_t elementSize) {
	uint res = block_id >> CLPP_BLK_BORDER_OFFSET;
	res = res & 0xF;
	res = elementSize * res;
	res = CLPP_ROUNDTO4(res);
	return res;
}

uint getBlockBorderY(uint block_id) {
	uint res = block_id >> CLPP_BLK_BORDER_OFFSET;
	res = res & 0xF;
	return res;
}

uint getBlockStride(uint block_id, size_t elementSize) {
	uint blkX = getBlockSizeX(block_id);
	uint borderX = getBlockBorderX(block_id, elementSize);
	uint res = elementSize * blkX + 2 * borderX;
	return res;
}

global uchar* clpp_clamp(
	clpp_buffer2d_desc	src_desc,
	int2				coords,
	uint				addressMode,
	int					elementSize
	)
{
	int width = src_desc.width;
	int height = src_desc.height;
	int stride = src_desc.stride;

	global uchar* ptr = (global uchar*)src_desc.ptr;

	// If value falls within the image; then read the corresponding value;
	if( ( coords.x >= 0 &&  coords.x < width )&&
		( coords.y >= 0 &&  coords.y < height) )
	{
		int srcOffset = mad24( coords.y, (int)stride, coords.x * elementSize );
		return ptr + srcOffset;
	}


	// If value falls outside the boundries of the image

	// For these address modes just return '0'
	if (CLK_ADDRESS_CLAMP == addressMode ||
		CLK_ADDRESS_NONE == addressMode)
	{
		return 0;
	}

	int2 newCoord = coords;

	// Calculate the new coordinates for these address modes
	if (CLK_ADDRESS_MIRRORED_REPEAT == addressMode)
	{
		// Flip the image coordinate at every integer junction
		if (coords.x < 0) newCoord.x = -coords.x;
		if (coords.y < 0) newCoord.y = -coords.y;
		if (coords.x >= width) newCoord.x = 2 * (width - 1) - coords.x;
		if (coords.y >= height) newCoord.y = 2 * (height - 1) - coords.y;
	}

	if (CLK_ADDRESS_REPEAT == addressMode)
	{
		// out-of-range image coordinates are wrapped to the valid range
		if (coords.x < 0) newCoord.x = coords.x + width - 1;
		if (coords.y < 0) newCoord.y = coords.y + height - 1;
		if (coords.x >= width) newCoord.x = coords.x - width + 1;
		if (coords.y >= height) newCoord.y = coords.y - height + 1;
	}

	if (CLK_ADDRESS_CLAMP_TO_EDGE == addressMode)
	{
		// out-of-range image coordinates are clamped to the extent
		if (coords.x < 0) newCoord.x = 0;
		if (coords.y < 0) newCoord.y = 0;
		if (coords.x >= width) newCoord.x = width - 1;
		if (coords.y >= height) newCoord.y = height - 1;
	}

	int srcOffset = mad24( newCoord.y, (int)stride, newCoord.x * elementSize );
	return ptr + srcOffset;
}
// ---------------------------- read_block ----------------------------
//
// --------------------------------------------------------------------
void read_block_8u_wg(
	clpp_buffer2d_desc					src_desc,
	__local uchar*						dst,
	uint2								src_coords,
	uint								block_id,
	uint								address_mode
	)
{
	int lix = get_local_id(0);
	int liy = get_local_id(1);
	int maxX = get_local_size(0) - 1;
	int maxY = get_local_size(1) - 1;

	int elementSize = sizeof(uchar);

	int blkX = getBlockSizeX(block_id);
	int blkY = getBlockSizeY(block_id);
	int borderX = getBlockBorderX(block_id, elementSize);
	int borderY = getBlockBorderY(block_id);

	int wPItem = 8;//blkX / get_local_size(0);

	int srcStride		= src_desc.stride;
	int dstStride		= getBlockStride(block_id, elementSize);

	int2 myBaseCoords	= (int2)( src_coords.x, src_coords.y ) +
						  (int2)( lix * wPItem, liy);

	int src_offset		= mad24( myBaseCoords.y, srcStride, myBaseCoords.x ) & (~3);

	int dst_offset		= mad24( borderY, dstStride,
						  mad24( liy, dstStride,
						  mad24( lix, wPItem, borderX))) & (~3);

	int elem	= ((__global int*)(src_desc.ptr + src_offset))[0];
	((__local int*)(dst + dst_offset))[0] = elem;

	elem = ((__global int*)(src_desc.ptr + src_offset + 4))[0];
	((__local int*)(dst + dst_offset + 4))[0] = elem;

	if( lix == 0 )
	{
		int2 left = myBaseCoords + (int2)(-1,0);
		int dstPixOffset = dst_offset - 1;
		dst[ dstPixOffset ] = *clpp_clamp(src_desc, left, address_mode, sizeof(uchar));
	}

	if( lix == maxX )
	{
		int2 right = myBaseCoords + (int2)(wPItem,0);
		int dstPixOffset = dst_offset + wPItem;
		dst[ dstPixOffset ] = *clpp_clamp(src_desc, right, address_mode, sizeof(uchar));
	}

	if( liy == 0 )
	{
		int2 upi = myBaseCoords + (int2)(0,-1);
		if( ( upi.x >= 0 && ( upi.x + wPItem - 1) < src_desc.width ) && ( upi.y >= 0 ) )
		{
			vstore8( vload8( 0, src_desc.ptr + src_offset - srcStride ), 0, dst + dst_offset - dstStride );
		}
		else
		{
			for(int i = 0; i < wPItem; i++)
			{
				int2 upi = myBaseCoords + (int2)(i,-1);
				int dstPixOffset = dst_offset - dstStride + i;
				dst[ dstPixOffset ] = *clpp_clamp(src_desc, upi, address_mode, sizeof(uchar));
			}
		}
	}

	if( liy == maxY )
	{
		int2 upi = myBaseCoords + (int2)(0,1);
		if( ( upi.x >= 0 && ( upi.x + wPItem - 1) < src_desc.width ) && ( upi.y < src_desc.height ) )
		{
			vstore8( vload8( 0, src_desc.ptr + src_offset + srcStride ), 0, dst + dst_offset + dstStride );
		}
		else
		{
			for(int i = 0; i < wPItem; i++)
			{
				int2 bottomi = myBaseCoords + (int2)(i,1);
				int dstPixOffset = dst_offset + dstStride + i;
				dst[ dstPixOffset ] = *clpp_clamp(src_desc, bottomi, address_mode, sizeof(uchar));
			}
		}
	}

	if( lix == 0 && liy == 0 )
	{
		int2 upLeft = myBaseCoords + (int2)(-1,-1);
		int dstPixOffset = dst_offset - dstStride - 1;
		dst[ dstPixOffset ] = *clpp_clamp(src_desc, upLeft, address_mode, sizeof(uchar));
	}

	if( lix == 0 && liy == maxY )
	{
		int2 bottomLeft = myBaseCoords + (int2)(-1,1);
		int dstPixOffset = dst_offset + dstStride - 1;
		dst[ dstPixOffset ] = *clpp_clamp(src_desc, bottomLeft, address_mode, sizeof(uchar));
	}

	if( lix == maxX && liy == 0 )
	{
		int2 upRight = myBaseCoords + (int2)(wPItem,-1);
		int dstPixOffset = dst_offset - dstStride + wPItem;
		dst[ dstPixOffset ] = *clpp_clamp(src_desc, upRight, address_mode, sizeof(uchar));
	}

	if( lix == maxX && liy == maxY )
	{
		int2 bottomRight = myBaseCoords + (int2)(wPItem,1);
		int dstPixOffset = dst_offset + dstStride + wPItem;
		dst[ dstPixOffset ] = *clpp_clamp(src_desc, bottomRight, address_mode, sizeof(uchar));
	}
}

void clpp_read_block_8u_wg(
	clpp_buffer2d_desc	src_desc,
	__local uchar*		dst,
	uint2				src_coords,
	uint				block_id,
	uint				address_mode
	)
{
	uint blkX = getBlockSizeX(block_id);
	uint blkY = getBlockSizeY(block_id);

	return read_block_8u_wg(src_desc, dst, src_coords, block_id, address_mode);
}
// ---------------------------- write_block ---------------------------
//
// --------------------------------------------------------------------
void write_block_8u_wg(
	local uchar*	src,
	global uchar*	dst,
	int				srcOffset,
	int				dstOffset
	)
{
	local uchar* srcPtr = (local uchar*)((intptr_t)(src + srcOffset) & (~3));
	global uchar* dstPtr = (global uchar*)((intptr_t)(dst + dstOffset) & (~3));
	vstore8( vload8(0, srcPtr), 0, dstPtr );
}

void write_block_16s_wg(
	local uchar*	src,
	global uchar*	dst,
	int				srcOffset,
	int				dstOffset
	)
{
	local short* srcPtr = (local short*)((intptr_t)(src + srcOffset) & (~3));
	global short* dstPtr = (global short*)((intptr_t)(dst + dstOffset) & (~3));
	vstore8( vload8(0, srcPtr), 0, dstPtr );
}

void clpp_write_block_8u_wg(
	__local uchar*			src,
	clpp_buffer2d_desc		dst_desc,
	uint2					dst_coords,
	uint					block_id
	)
{
	uint elementSize = sizeof(uchar);

	int lix = get_local_id(0);
	int liy = get_local_id(1);

	uint blkX = getBlockSizeX(block_id);
	uint blkY = getBlockSizeY(block_id);

	uint borderX = getBlockBorderX(block_id, elementSize);
	uint borderY = getBlockBorderY(block_id);

	int wPItem = blkX / get_local_size(0);

	int dstStride			= dst_desc.stride;
	int srcStride			= getBlockStride(block_id, elementSize);

	int srcOffset = ( borderY * srcStride +
		              borderX +
					  liy * srcStride +
					  lix * wPItem * elementSize
					 );

	int dstOffset = ( dst_coords.y * dstStride +
					  dst_coords.x * elementSize +
					  liy * dstStride +
					  lix * wPItem * elementSize
					 );

	return write_block_8u_wg(src, dst_desc.ptr, srcOffset, dstOffset);
}

void clpp_write_block_16s_wg(
	__local short*		src,
	clpp_buffer2d_desc	dst_desc,
	uint2				dst_coords,
	uint				block_id
	)
{
	uint elementSize = sizeof(short);

	int lix = get_local_id(0);
	int liy = get_local_id(1);

	uint blkX = getBlockSizeX(block_id);
	uint blkY = getBlockSizeY(block_id);

	uint borderX = getBlockBorderX(block_id, elementSize);
	uint borderY = getBlockBorderY(block_id);

	int wPItem = blkX / get_local_size(0);

	int dstStride			= dst_desc.stride;
	int srcStride			= getBlockStride(block_id, elementSize);

	int srcOffset = ( borderY * srcStride +
		              borderX +
					  liy * srcStride +
					  lix * wPItem * elementSize
					 );

	int dstOffset = ( dst_coords.y * dstStride +
					  dst_coords.x * elementSize +
					  liy * dstStride +
					  lix * wPItem * elementSize
					 );

	return write_block_16s_wg((local uchar*)src, dst_desc.ptr, srcOffset, dstOffset);
}
// ---------------------------- filter_median--------------------------
//
// --------------------------------------------------------------------

void calc_filter_median_3x3_8u(
	__local uchar*	src,
	__local uchar*	dst,
	uint			srcStride)
{
    float16   x0, x1, x2;
    float16   t0, t1, t2;
    float16   mn0, mn1, mn2, md0, md1, md2, mx0, mx1, mx2, med;
    float16   mxmn, mdmd, mnmx;

    x0 = convert_float16(vload16(0, src));
    src += srcStride;
    x1 = convert_float16(vload16(0, src));
    src += srcStride;
    x2 = convert_float16(vload16(0, src));

    t0 = min(x0, x1);
    t1 = max(x0, x1);
    mn0 = min(t0, x2);
    t2 = max(t0, x2);
    md0 = min(t1, t2);
    mx0 = max(t1, t2);

    mn1.s01234567 = mn0.s456789AB;
    mn2.s01234567 = mn0.s56789ABC;
    mn0.s01234567 = mn0.s3456789A;

    md1.s01234567 = md0.s456789AB;
    md2.s01234567 = md0.s56789ABC;
    md0.s01234567 = md0.s3456789A;

    mx1.s01234567 = mx0.s456789AB;
    mx2.s01234567 = mx0.s56789ABC;
    mx0.s01234567 = mx0.s3456789A;

    mxmn = max(mn0, mn1);
    mxmn = max(mxmn, mn2);

    t0 = min(md0,md1);
    t1 = max(md0,md1);
    mdmd = max(t0,md2);
    mdmd = min(mdmd,t1);

    mnmx = min(mx0, mx1);
    mnmx = min(mnmx, mx2);

    t0 = min(mxmn,mdmd);
    t1 = max(mxmn,mdmd);
    med = max(t0,mnmx);
    med = min(med, t1);

    vstore8(convert_uchar8(med.s01234567), 0, dst);
}

void clpp_filter_median_3x3_8u_wg(
	__local uchar*	src,
	__local uchar*	dst,
	uint 			block_id)
{
	int lix = get_local_id(0);
	int liy = get_local_id(1);

	uint elementSize = sizeof(uchar);

	uint blkX = getBlockSizeX(block_id);
	uint blkY = getBlockSizeY(block_id);

	uint borderX = getBlockBorderX(block_id, elementSize);
	uint borderY = getBlockBorderY(block_id);

	int srcStride = getBlockStride(block_id, elementSize);
	int dstStride = getBlockStride(block_id, elementSize);

	int wPItem = blkX / get_local_size(0);

	uint srcOffset	= ( ( borderY - 1 ) * srcStride +
						( borderX - 1 ) +
						liy * srcStride +
						lix * wPItem * elementSize
					   ) & (~3);

	uint dstOffset	= ( borderY * srcStride +
						borderX +
						liy * dstStride +
						lix * wPItem * elementSize
					   ) & (~3);

	local uchar* dstPtr = dst + dstOffset;
	local uchar* srcPtr = src + srcOffset;

	calc_filter_median_3x3_8u(srcPtr, dstPtr, srcStride);
}
// ---------------------------- filter_fixed --------------------------
//
// --------------------------------------------------------------------

void calc_filter_fixed_3x3_8u16s(
	__local uchar*		src,
	__local short*		dst,
	uint				srcStride,
	clpp_kernel_type	kernel_type)
{
	float16 val;

	val = convert_float16(vload16(0, src));
	float8 u1, u2, u3;
	u1 = val.s3456789a;
	u2 = val.s456789ab;
	u3 = val.s56789abc;

	src += srcStride;
	val = convert_float16(vload16(0, src));
	float8 m1, m2, m3;
	m1 = val.s3456789a;
	m2 = val.s456789ab;
	m3 = val.s56789abc;

	src += srcStride;
	val = convert_float16(vload16(0, src));
	float8 b1, b2, b3;
	b1 = val.s3456789a;
	b2 = val.s456789ab;
	b3 = val.s56789abc;

	float8 output = 0;

	if( kernel_type == CLPP_KERNEL_SOBEL_H )
	{
		output = mad(2.0f, b2 - u2, b1 - u1 + b3 - u3);
	}
	else if( kernel_type == CLPP_KERNEL_SOBEL_V )
	{
		output = mad(2.0f, m1 - m3, u1 - u3 + b1 - b3);
	}
	else if( kernel_type == CLPP_KERNEL_SOBELNEG_V )
	{
		output = mad(2.0f, m3 - m1, u3 - u1 + b3 - b1 );
	}
	if( kernel_type == CLPP_KERNEL_SCHARR_H )
	{
		output = mad(3.0f, b1 - u1, mad(10.0f, b2 - u2, mad(3.0f, b3 - u3, 0)));
	}
	else if( kernel_type == CLPP_KERNEL_SCHARR_V )
	{
		output = mad(3.0f, u3 - u1, mad(10.0f, m3 - m1, mad(3.0f, b3 - b1, 0)));
	}
	else if( kernel_type == CLPP_KERNEL_LAPLACE )
	{
		output = mad(2.0f, u1 + b1, mad(-8.0f, m2, mad(2.0f, u3 + b3, 0)));
	}

	vstore8(convert_short8(output), 0, dst);
}

void clpp_filter_fixed_3x3_8u16s_wg(
	__local uchar*		src,
	__local short*		dst,
	clpp_kernel_type	kernel_type,
	uint				block_id)
{
	int lix = get_local_id(0);
	int liy = get_local_id(1);

	uint srcElementSize = sizeof(uchar);
	uint dstElementSize = sizeof(short);

	uint blkX = getBlockSizeX(block_id);
	uint blkY = getBlockSizeY(block_id);

	uint srcBorderX = getBlockBorderX(block_id, srcElementSize);
	uint dstBorderX = getBlockBorderX(block_id, dstElementSize);

	uint srcBorderY = getBlockBorderY(block_id);
	uint dstBorderY = getBlockBorderY(block_id);

	int srcStride = getBlockStride(block_id, srcElementSize);
	int dstStride = getBlockStride(block_id, dstElementSize);

	int wPItem = blkX / get_local_size(0);

	local uchar* tmpSrcPtr	= (local uchar*)src;
	local uchar* tmpDstPtr	= (local uchar*)dst;

	tmpSrcPtr	= tmpSrcPtr
				+ ( srcBorderY - 1 ) * srcStride
				+ ( srcBorderX - 4 )
				+ liy * srcStride
				+ lix * wPItem * srcElementSize;


	tmpDstPtr	= tmpDstPtr
				+ dstBorderY * dstStride
				+ dstBorderX
				+ liy * dstStride
				+ lix * wPItem * dstElementSize;

	local uchar* srcPtr = (local uchar*)((intptr_t)tmpSrcPtr & (~3));
	local short* dstPtr = (local short*)((intptr_t)tmpDstPtr & (~3));

	calc_filter_fixed_3x3_8u16s(srcPtr, dstPtr, srcStride, kernel_type);
}


// buildOptions= -I testsuite/ocl/hsd/5059075 -DBLK_X=128 -DBLK_Y=8
// RUN: %occ-cli %s --cl-options="-I%cwd -I%/S  -I testsuite/ocl/hsd/5059075 -DBLK_X=128 -DBLK_Y=8" %cfg_path --cl-device=%cl_device 2>&1
