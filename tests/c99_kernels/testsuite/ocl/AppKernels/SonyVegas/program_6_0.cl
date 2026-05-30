__constant sampler_t v0 = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST ; __kernel void kc8be33ae0 ( __write_only image2d_t v1 , const float4 v2 ) { int x = get_global_id ( 0 ) ; int y = get_global_id ( 1 ) ; float4 v3 = ( float4 ) ( v2 . x * v2 . w , v2 . y * v2 . w , v2 . z * v2 . w , v2 . w ) ; write_imagef ( v1 , ( int2 ) ( x , y ) , v3 ) ; }

// buildOptions=-w -cl-single-precision-constant -cl-denorms-are-zero -cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -w -cl-single-precision-constant -cl-denorms-are-zero -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
