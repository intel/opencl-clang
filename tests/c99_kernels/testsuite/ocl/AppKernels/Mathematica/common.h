#ifndef __COMMON_H__
#define __COMMON_H__
#ifdef USING_OPENCL_FUNCTION
#	ifdef USING_DOUBLE _PRECISIONQ
#		ifdef OPENCLLINK_USING_NVIDIA
#			define DO_STUFF_IF_USING_NVIDIA_IN_DOUBLE_PRECISION_MODE
#			pragma OPENCL EXTENSION cl_khr_fp64 : enable
#		else /* OPENCLLINK_USING_NVIDIA */
#			define DO_STUFF_IF_USING_ATI_IN_DOUBLE_PRECISION_MODE
#			pragma OPENCL EXTENSION cl_amd_fp64 : enable
#		endif /* OPENCLLINK_USING_NVIDIA */
#	else /* USING_DOUBLE _PRECISIONQ */
#		ifdef OPENCLLINK_USING_NVIDIA
#			define DO_STUFF_IF_USING_NVIDIA_IN_SINGLE_PRECISION_MODE
#		else /* OPENCLLINK_USING_NVIDIA */
#			define DO_STUFF_IF_USING_ATI_IN_SINGLE_PRECISION_MODE
#		endif /* OPENCLLINK_USING_NVIDIA */
#	endif /* USING_DOUBLE _PRECISIONQ */
#else /* USING_OPENCL_FUNCTION */
#	if defined(cl_khr_fp64) || defined(cl_amd_fp64)
#		ifdef cl_khr_fp64
#			pragma OPENCL EXTENSION cl_khr_fp64 : enable
#		else /* cl_khr_fp64 */
#			pragma OPENCL EXTENSION cl_amd_fp64 : enable
#		endif /* cl_khr_fp64 */
#		ifndef Real_t
#			define Real_t double
#		endif /* Real_t */
#	else /* defined(cl_khr_fp64) || defined(cl_amd_fp64)*/
#		ifndef Real_t
#			define Real_t float
#		endif /* Real_t */
#	endif /* defined(cl_khr_fp64) || defined(cl_amd_fp64) */
#endif /* USING_OPENCL_FUNCTION */
#endif /* __COMMON_H__ */