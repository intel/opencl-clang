#include "VCA.h"

__kernel void ocl_test_kernel(__global int* x) {
  *x=2;
  *(x+3)=0;
}

global uchar* vca_clamp( dspp_buffer2d_desc src_desc, int2 coords, uint addressMode, int elementSize )
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

void dspp_read_block_8u_wg(
	__local uchar*						dst,
	dspp_local2d_desc					dst_lmem_desc,
	dspp_buffer2d_desc					src_desc,
	uint2 								src_coords,
	uint 								address_mode
	)
{

	int lix = get_local_id(0);
	int liy = get_local_id(1);
	int srcStride4	= src_desc.stride;
	int dstStride4	= dst_lmem_desc.stride;
	int border4		= dst_lmem_desc.border_width;
	int LMEM_16x8_3x3_U8_SIZE = DSPP_LMEM_3X3_U8_BLK_SIZE(16,8) << 2;
	int blkWidth4 = dst_lmem_desc.width;

	int2 blockEnd = (int2)((int)src_coords.x,(int)src_coords.y) + (int2)((int)dst_lmem_desc.width,(int)dst_lmem_desc.height)- (int2)1;

	// every work-item is processing 4-byte wide elements
	// calculate block start-pixel and end-pixel
	int2 lmemBlockStart	= (int2)((int)src_coords.x,(int)src_coords.y)-(int2)(dst_lmem_desc.border_width,1);
	int2 lmemBlockEnd	= lmemBlockStart + (int2)(24, 10) - (int2)1;

	// My own pixel coordinates at src buffer
	int srcLmemBlockOffset  = mad24( lmemBlockStart.y, (int)src_desc.stride, lmemBlockStart.x );
	int srcLmemBlockOffset4 = srcLmemBlockOffset;
	int srcBlockOffset4		= mad24( (int)src_coords.y, (int)srcStride4, (int)src_coords.x );

    // BWOB - Block without borders
    // This is not ideal but good enough
    bool BWOB = ( (int)src_coords.x >= 0 &&
                  (int)src_coords.y >= 0 &&
                  blockEnd.x <= ( src_desc.width  - 1 ) &&
                  blockEnd.y <= ( src_desc.height - 1 ) );

    int2 rcStart	= (int2)(blockEnd.x+1, src_coords.y);
    int2 rcEnd		= (int2)(rcStart.x + dst_lmem_desc.border_width-1, blockEnd.y);

    int2 lcStart	= (int2)(lmemBlockStart.x, src_coords.y);
    int2 lcEnd		= (int2)(src_coords.x-1, blockEnd.y);

    if( BWOB )
    {
        if( get_local_id(1) == 0 )	// HW #0
        {
            return;
        }
    }

    int dstStride = dst_lmem_desc.stride;

    bool RB = ( rcStart.x >= 0 &&
                rcStart.y >= 0 &&
                rcEnd.x <= ( src_desc.width  - 1 ) &&
                rcEnd.y <= ( src_desc.height - 1 ) );

    if( RB )
    {
        if( get_local_id(1) == 1 )	// HW #1
        {
            return;
        }
    }
    else
    {
        if( get_local_id(1) == 1 )	// HW #3
        {
            return;
        }
    }

    bool LB = (	lcStart.x >= 0 &&
                lcStart.y >= 0 &&
                lcEnd.x <= ( src_desc.width  - 1 ) &&
                lcEnd.y <= ( src_desc.height - 1 ) );

    if( LB )
    {
        if( get_local_id(1) == 2 )	// HW #3
        {
            return;
        }
    }
    // Yet to process 18 pixels row above the block + 18 pixels row below the block
    // 18 = 1 + 16 + 1

    // above row
    if( get_local_id(1) == 5 && get_local_id(0) < 16 )
    {
    }
    // below row
    else if( get_local_id(1) == 6 && get_local_id(0) < 16 )
    {
    }
    // right left corner pixel
    else if( get_local_id(1) == 7 )
    {
        if( get_local_id(0) == 0 )
        {
            // up left
            int2 myCoord = (int2)((int)src_coords.x,(int)src_coords.y) + (int2)(-1,-1);
            int dstOffset = dst_lmem_desc.border_width - 1;
            ((__local uchar*)dst)[ dstOffset ] = *((__global uchar*)vca_clamp(src_desc, myCoord, address_mode, 1));
        }
        else if( get_local_id(0) == 1 )
        {
            // up right
            int2 myCoord = rcStart + (int2)(0,-1);
            int dstOffset = dst_lmem_desc.stride - dst_lmem_desc.border_width;
            ((__local uchar*)dst)[ dstOffset ] = *((__global uchar*)vca_clamp(src_desc, myCoord, address_mode, 1));
        }
        else if( get_local_id(0) == 2 )
        {
            // bottom left
            int2 myCoord = lcEnd + (int2)(0,1);
            int dstOffset = LMEM_16x8_3x3_U8_SIZE - dstStride + dst_lmem_desc.border_width - 1;
            ((__local uchar*)dst)[ dstOffset ] = *((__global uchar*)vca_clamp(src_desc, myCoord, address_mode, 1));
        }
        else if( get_local_id(0) == 3 )
        {
            // bottom right
            int2 myCoord = blockEnd + (int2)(1,1);
            int dstOffset = LMEM_16x8_3x3_U8_SIZE - dst_lmem_desc.border_width;
            ((__local uchar*)dst)[ dstOffset ] = *((__global uchar*)vca_clamp(src_desc, myCoord, address_mode, 1));
        }
    }
}


// buildOptions= -I testsuite/ocl/hsd/5055854
// RUN: %occ-cli %s --cl-options="-I%cwd -I%/S  -I testsuite/ocl/hsd/5055854" %cfg_path --cl-device=%cl_device 2>&1
