#define TOPLEFT			in[index + ii - pitch - channels]
#define TOP				in[index + ii - pitch]
#define TOPRIGHT		in[index + ii - pitch + channels]
#define LEFT			in[index + ii - channels]
#define CENTER			in[index + ii]
#define RIGHT			in[index + ii + channels]
#define BOTTOMLEFT		in[index + ii + pitch - channels]
#define BOTTOM			in[index + ii + pitch]
#define BOTTOMRIGHT		in[index + ii + pitch + channels]

#define USING_OPENCL_FUNCTION 1
#define OPENCLLINK_USING_NVIDIA
#define mint long
#define Real_t double
#define USING_DOUBLE_PRECISIONQ 1
#define MAX_ITERATIONS 100

__kernel void sobelGX_vert(__global mint * in, __global mint * out, mint width, mint height, mint channels) {
	const int xIndex = get_global_id(0);
	const int yIndex = get_global_id(1);
    const int index = channels*(xIndex + yIndex*width);
    const int pitch = width*channels;

    if (yIndex >= height || xIndex >= width)
    	return ;

  	int ii;
    if (yIndex == 0 || yIndex == height-1) {
        for (ii = 0; ii < channels; ii++) {
            out[index + ii] = 0;
        }
    } else {
        for (ii = 0; ii < channels; ii++) {
            out[index + ii] = TOP + 2*CENTER + BOTTOM;
        }
    }
}

__kernel void sobelGX_horiz(__global mint * in, __global mint * out, mint width, mint height, mint channels) {
	const int xIndex = get_global_id(0);
	const int yIndex = get_global_id(1);
    const int index = channels*(xIndex + yIndex*width);
    const int pitch = width*channels;

    if (yIndex >= height || xIndex >= width)
    	return ;

  	int ii;
    if (xIndex == 0 || xIndex == width-1) {
        for (ii = 0; ii < channels; ii++) {
            out[index + ii] = 0;
        }
    } else {
        for (ii = 0; ii < channels; ii++) {
            out[index + ii] = LEFT - RIGHT;
        }
    }
}

 __kernel void sobelGX(__global mint * in, __global mint * out, mint width, mint height, mint channels) {
	const int xIndex = get_global_id(0);
	const int yIndex = get_global_id(1);
    const int index = channels*(xIndex + yIndex*width);
    const int pitch = width*channels;

    if (yIndex >= height || xIndex >= width)
    	return ;

  	int ii;
  	if (xIndex == 0 || xIndex == width-1) {
  		for (ii = 0; ii < channels; ii++) {
    			out[index + ii] = 0;
  		}
    } else {
    	if (yIndex == 0) {
    		for (ii = 0; ii < channels; ii++) {
    			out[index + ii] = BOTTOMLEFT + LEFT - (BOTTOMRIGHT + RIGHT);
    		}
    	} else if (yIndex == height-1) {
  			for (ii = 0; ii < channels; ii++) {
    			out[index + ii] = TOPLEFT + LEFT - (TOPRIGHT + RIGHT);
    		}
  		} else {
  			for (ii = 0; ii < channels; ii++) {
    			out[index + ii] = TOPLEFT + 2*LEFT + BOTTOMLEFT - (TOPRIGHT + 2*RIGHT + BOTTOMRIGHT);
    		}
  		}
    }
}

__kernel void sobelGY(__global mint * in, __global mint * out, mint width, mint height, mint channels) {
	const int xIndex = get_global_id(0);
	const int yIndex = get_global_id(1);
    const int index = channels*(xIndex + yIndex*width);
    const int pitch = width*channels;

    if (yIndex >= height || xIndex >= width)
    	return ;

  	int ii;
  	if (yIndex == 0 || yIndex == height-1) {
  		for (ii = 0; ii < channels; ii++) {
    		out[index + ii] = 0;
    	}
    } else {
    	if (xIndex == 0) {
    		for (ii = 0; ii < channels; ii++) {
    			out[index + ii] = TOP + TOPRIGHT  - (BOTTOM + BOTTOMRIGHT);
    		}
  		} else if (xIndex == width-1) {
  			for (ii = 0; ii < channels; ii++) {
    			out[index + ii] = TOPLEFT + TOP - (BOTTOMLEFT + BOTTOM);
    		}
  		} else {
  			for (ii = 0; ii < channels; ii++) {
    			out[index + ii] = TOPLEFT + 2*TOP + TOPRIGHT  - (BOTTOMLEFT + 2*BOTTOM + BOTTOMRIGHT);
    		}
  		}
    }
}


__kernel void sobelGY_vert(__global mint * in, __global mint * out, mint width, mint height, mint channels) {
	const int xIndex = get_global_id(0);
	const int yIndex = get_global_id(1);
    const int index = channels*(xIndex + yIndex*width);
    const int pitch = width*channels;

    if (yIndex >= height || xIndex >= width)
    	return ;

  	int ii;
    if (yIndex == 0 || yIndex == height-1) {
        for (ii = 0; ii < channels; ii++) {
            out[index + ii] = 0;
        }
    } else {
        for (ii = 0; ii < channels; ii++) {
            out[index + ii] = TOP - BOTTOM;
        }
    }
}

__kernel void sobelGY_horiz(__global mint * in, __global mint * out, mint width, mint height, mint channels) {
    const int xIndex = get_global_id(0);
	const int yIndex = get_global_id(1);
    const int index = channels*(xIndex + yIndex*width);
    const int pitch = width*channels;

    if (yIndex >= height || xIndex >= width)
    	return ;

  	int ii;
    if (xIndex == 0 || xIndex == width-1) {
        for (ii = 0; ii < channels; ii++) {
            out[index + ii] = 0;
        }
    } else {
        for (ii = 0; ii < channels; ii++) {
            out[index + ii] = LEFT + 2*CENTER + RIGHT;
        }
    }
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
