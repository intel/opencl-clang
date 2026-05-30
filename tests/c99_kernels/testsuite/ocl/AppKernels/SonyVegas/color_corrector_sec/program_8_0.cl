__constant sampler_t v0 = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST ; __kernel void kc8be33ae0 ( __write_only image2d_t v1 , const float4 v2 , const int v3 , const int v4 ) { int x = get_global_id ( 0 ) ; int y = get_global_id ( 1 ) ; if ( x < v3 && y < v4 ) { float4 v5 = ( float4 ) ( v2 . x * v2 . w , v2 . y * v2 . w , v2 . z * v2 . w , v2 . w ) ; write_imagef ( v1 , ( int2 ) ( x , y ) , v5 ) ; } }

// buildOptions= -w -cl-single-precision-constant -cl-denorms-are-zero -cl-fast-relaxed-math -DfHWBL=0
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -w -cl-single-precision-constant -cl-denorms-are-zero -cl-fast-relaxed-math -DfHWBL=0" %cfg_path --cl-device=%cl_device 2>&1
