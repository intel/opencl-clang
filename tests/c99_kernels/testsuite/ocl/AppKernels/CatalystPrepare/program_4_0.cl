__constant sampler_t v0 = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST ;
__kernel void ASCCDL ( __read_only image2d_t v1 , __write_only image2d_t
v2 , const float v3 , const float v4 ,
const float v5 , const float v6 , const float
v7 , const float v8 , const float v9 ,
const float v10 , const float v11 , const float
v12 , const int v13 , const int v14 )
{ int x = get_global_id ( 0 ) ; int
y = get_global_id ( 1 ) ; if ( x
< v13 && y < v14 ) { int2 v15
= ( int2 ) ( x , y ) ;
float4 v16 = read_imagef ( v1 , v0 , v15
) ; float4 v17 = ( float4 ) ( v3
, v4 , v5 , 1.0f ) ; float4 v18
= ( float4 ) ( v6 , v7 , v8
, 0.0f ) ; v16 = v16 * v17 +
v18 ; float4 v19 = ( float4 ) ( v9
, v10 , v11 , 1.0f ) ; { v16
= copysign ( half_powr ( fabs ( v16 ) ,
v19 ) , v16 ) ; } float4 v20 =
( float4 ) ( 0.2126f , 0.7152f , 0.0722f ,
0.0f ) ; float v21 = dot ( v16 ,
v20 ) ; float4 v22 = ( float4 ) (
v21 , v21 , v21 , v16 . w )
; v16 = ( v16 - v22 ) * (
float4 ) v12 + v22 ; write_imagef ( v2 ,
v15 , v16 ) ; } }


// buildOptions=-w -cl-single-precision-constant -cl-denorms-are-zero -cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -w -cl-single-precision-constant -cl-denorms-are-zero -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
