// ------------------ Definitions -------------------------------------
// Version 0.1
// 
// The following is additional round of tunning the HPP Device-side APIs to 
// Better match Intel GPU hardware. 
//
// Based on HPP_Requirements.docx document maintained by 'Chris Cormack'
// -----------------------------------------------------------------------

/* dspp_kernel_type */
#define	DSPP_KERNEL_LAPLACE          0x00000001
#define DSPP_KERNEL_SCHARR_H         0x00000002
#define DSPP_KERNEL_SCHARR_V         0x00000004
#define DSPP_KERNEL_SOBEL_H          0x00000008
#define DSPP_KERNEL_SOBEL_V          0x00000010
#define DSPP_KERNEL_SOBELNEG_V       0x00000020
#define DSPP_KERNEL_SOBEL            0x00000040
#define DSPP_KERNEL_GAUSSIAN         0x00000080 

typedef uint					dspp_kernel_type;


/* dspp_buffer2d_desc */
typedef struct _dspp_buffer2d_desc
{
	__global uchar*				ptr;				/* must be aligned to 4-bytes */
	uint 						width;				/* width in pixels */
	uint 						height;				/* height in pixels */
	uint 						stride;				/* stride in bytes */
} dspp_buffer2d_desc;


/* dspp_local2d_desc */
typedef struct _dspp_local2d_desc
{	
	uint						width;				/* width in bytes  - must be multiple of 4 */
	uint						height;				/* height in bytes - must be multiple of 4 */
	uint						border_width;		/* border width in bytes - must be multiple of 4 */
	uint						border_height;		/* border height in bytes - must be multiple of 4 */
	uint						stride;				/* full row stride in bytes */
} dspp_local2d_desc;


/*** Internal <<<< ***/

#define DSPP_ENUM_L2(VARA,VARB,VARC,VARD) \
	DSPP_ ## VARA ## x ## VARB ## _ ## VARC ## _ ## VARD ## _ID
#define DSPP_ENUM_L1(VARA,VARB,VARC,VARD) \
	DSPP_ENUM_L2(VARA,VARB,VARC,VARD)

#define DSPP_VAR_L2(VARA,VARB,VARC,VARD) \
	dspp_lmem_ ## VARA ## x ## VARB ## _ ## VARC ## _ ## VARD ## _desc
#define DSPP_VAR_L1(VARA,VARB,VARC,VARD) \
	DSPP_VAR_L2(VARA,VARB,VARC,VARD)

//extern constant dspp_local2d_desc dspp_lmem_16x8_3x3_u8_desc;
//extern constant dspp_local2d_desc dspp_lmem_16x4_3x3_u8_desc = { ... };
//extern constant dspp_local2d_desc dspp_lmem_16x1_3x3_u8_desc = { ... };

enum DSPP_BLOCK_ID
{
	DSPP_16x8_3x3_u8_ID = 0,
};

/*** Internal >>>> ***/


// Helper MACROS for Kernel developer
#define DSPP_LMEM_3X3_U8_BLK_SIZE(BLK_WIDTH,BLK_HEIGHT) \
	((((BLK_WIDTH)+8)*((BLK_HEIGHT)+2))>>2)

#define DSPP_LMEM_3X3_U8_BLK_DESC(BLK_WIDTH,BLK_HEIGHT) \
	DSPP_VAR_L1(BLK_X,BLK_Y,3x3,u8)

#define DSPP_LMEM_3X3_U8_BLK_ID(BLK_WIDTH,BLK_HEIGHT) \
	DSPP_ENUM_L1(BLK_X,BLK_Y,3x3,u8)


// ------------------- HPP OpenCL Device Side Functions ---------------
//
// --------------------------------------------------------------------
void dspp_read_block_8u_wg
(
	__local uchar*						dst,
	dspp_local2d_desc					dst_lmem_desc,
	dspp_buffer2d_desc					src_desc,
	uint2 								src_coords, 
	uint 								address_mode
);