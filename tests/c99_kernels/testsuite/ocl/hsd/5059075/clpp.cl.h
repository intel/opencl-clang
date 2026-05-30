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

File Name: clpp.cl.h

Version: 
	0.5
Abstract: 
	The following is additional round of tunning the HPP Device-side APIs to 
	Better match Intel GPU hardware. 

*****************************************************************************/
#ifndef CLPP_CL_H
#define CLPP_CL_H

/* clpp_kernel_type */
#define	CLPP_KERNEL_LAPLACE          0x00000001
#define CLPP_KERNEL_SCHARR_H         0x00000002
#define CLPP_KERNEL_SCHARR_V         0x00000004
#define CLPP_KERNEL_SOBEL_H          0x00000008
#define CLPP_KERNEL_SOBEL_V          0x00000010
#define CLPP_KERNEL_SOBELNEG_V       0x00000020
#define CLPP_KERNEL_SOBEL            0x00000040
#define CLPP_KERNEL_GAUSSIAN         0x00000080 
/* clpp_kernel_type */
typedef uint					clpp_kernel_type;


/* clpp_buffer2d_desc */
typedef struct _clpp_buffer2d_desc
{
	__global uchar*				ptr;				/* must be aligned to 4-bytes */
	uint 						width;				/* width in pixels */
	uint 						height;				/* height in pixels */
	uint 						stride;				/* stride in bytes */
} clpp_buffer2d_desc;


enum CLPP_BLOCK_ID
{	
	//      4     4        4 
	// {1|BLK_X|BLK_Y|BORDER_SIZE}
	
	CLPP_BLK_16X8		= 0x1030,
	CLPP_BLK_64X8		= 0x1230,
	CLPP_BLK_128X8		= 0x1330,
	CLPP_BLK_256X8		= 0x1430,

	CLPP_BLK_16X8_1		= 0x1031,
	CLPP_BLK_64X8_1		= 0x1231,
	CLPP_BLK_128X8_1	= 0x1331,
	CLPP_BLK_256X8_1	= 0x1431,

	CLPP_BLK_16X8_2		= 0x1032,
	CLPP_BLK_64X8_2		= 0x1232,
	CLPP_BLK_128X8_2	= 0x1332,
	CLPP_BLK_256X8_2	= 0x1432,

	CLPP_BLK_16X8_3		= 0x1033,
	CLPP_BLK_64X8_3		= 0x1233,
	CLPP_BLK_128X8_3	= 0x1333,
	CLPP_BLK_256X8_3	= 0x1433,

	CLPP_BLK_16X8_4		= 0x1034,
	CLPP_BLK_64X8_4		= 0x1234,
	CLPP_BLK_128X8_4	= 0x1334,
	CLPP_BLK_256X8_4	= 0x1434,
};


enum CLPP_KERNELS
{
  K3X3   = 1,
  K5X5   = 2,
  K7X7   = 3,
  K9X9   = 4,
  K11X11 = 5
};
	


#define CLPP_ROUNDTO4(X)                (((X-1)/4+1)*4)
#define CLPP_BLK_BORDER_OFFSET			0
#define CLPP_BLK_BLK_Y_OFFSET			4
#define CLPP_BLK_BLK_X_OFFSET			8

		
#define CLPP_GET_FROM_BLK_ID(BLK_ID,VAR_NAME) \
	((BLK_ID >> CLPP_BLK_ ## VAR_NAME ## _OFFSET) & 0xF)

#define CLPP_SET_TO_BLK_ID(BLK_ID,VAR_NAME, val) \
	(BLK_ID | ((val & 0xF) << CLPP_BLK_ ## VAR_NAME ## _OFFSET))

	
// Helper MACROS for Kernel developer

#define CLPP_LMEM_U8_STRIDE(BLK_X,BLK_Y,KRN_CHAIN) \
	( BLK_X + 2 * CLPP_ROUNDTO4( KRN_CHAIN ) )
#define CLPP_LMEM_U8_SIZE(BLK_X,BLK_Y,KRN_CHAIN) \
	( CLPP_LMEM_U8_STRIDE( BLK_X, BLK_Y, KRN_CHAIN ) * (BLK_Y + 2 * KRN_CHAIN) )

#define CLPP_LMEM_S16_STRIDE(BLK_X,BLK_Y,KRN_CHAIN) \
	( 2 * BLK_X + 2 * CLPP_ROUNDTO4( 2 * KRN_CHAIN ) )
#define CLPP_LMEM_S16_SIZE(BLK_X,BLK_Y,KRN_CHAIN) \
	( CLPP_LMEM_S16_STRIDE( BLK_X, BLK_Y, KRN_CHAIN ) * (BLK_Y + 2 * KRN_CHAIN) )

#define CLPP_LMEM_BLK_ID_(BLK_X,BLK_Y) \
	CLPP_BLK_ ## BLK_X ## X ## BLK_Y
#define CLPP_LMEM_BLK_ID(BLK_X,BLK_Y,KRN_CHAIN) \
	(CLPP_SET_TO_BLK_ID(CLPP_LMEM_BLK_ID_(BLK_X, BLK_Y), BORDER, KRN_CHAIN))


// ------------------- HPP OpenCL Device Side Functions ---------------
//
// --------------------------------------------------------------------
void clpp_read_block_8u_wg(
	clpp_buffer2d_desc					src_desc,
	__local uchar*						dst,
	uint2								src_coords,
	uint								block_id,
	uint								address_mode
);

void clpp_write_block_8u_wg(
	__local uchar*						src,
	clpp_buffer2d_desc					dst_desc,
	uint2								dst_coords,
	uint								block_id
);

void clpp_write_block_16s_wg(
	__local short*						src,
	clpp_buffer2d_desc					dst_desc,
	uint2								dst_coords,
	uint								block_id
);

void clpp_filter_median_3x3_8u_wg(
	__local uchar*						src,
	__local uchar*						dst,
	uint								block_id
);

void clpp_filter_fixed_3x3_8u16s_wg(
	__local uchar*						src,
	__local short*						dst,
	clpp_kernel_type					kernel_type,
	uint								block_id
);

#endif // CLPP_CL_H