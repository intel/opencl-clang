
#define USING_OPENCL_FUNCTION 1
#define OPENCLLINK_USING_NVIDIA
#define mint int
#define USING_DOUBLE_PRECISIONQ 1
#define MAX_ITERATIONS 100

#ifndef Real_t
#define Real_t           float
#endif

#define LOCALWORKSIZEDIM 16

#define LOW_THRESHOLD    40
#define HIGH_THRESHOLD   60

#define CANDIDATE_PIXEL  0


__kernel void gaussianVert_kernel(__global mint * in, __global mint * out, mint width, mint height, mint channels, mint pitch) {
    __local int lmem[LOCALWORKSIZEDIM][LOCALWORKSIZEDIM+6];

    int tx = get_local_id(0), ty = get_local_id(1);
    int bx = get_group_id(0), by = get_group_id(1);
    int xIndex = get_global_id(0);
    int yIndex = get_global_id(1);

    if (xIndex >= width)
        return;

    int index = channels*xIndex + yIndex*pitch;

    Real_t accum;
    int cc;
    __global int * col = &in[xIndex*channels];

    for (cc = 0; cc < channels; cc++) {
        lmem[tx][ty+3] = yIndex < height ? col[yIndex*pitch + cc] : 0;
        if (ty < 3) {
            lmem[tx][ty] = (yIndex < height && yIndex > ty) ? col[(yIndex-3)*pitch + cc] : 0;
            lmem[tx][ty+LOCALWORKSIZEDIM+3] = (yIndex+LOCALWORKSIZEDIM < height) ? col[(yIndex+LOCALWORKSIZEDIM)*pitch + cc] : 0;
        }
        barrier(CLK_LOCAL_MEM_FENCE);

        if (yIndex < height) {
            accum  = 0.006f * lmem[tx][ty];
            accum += 0.061f * lmem[tx][ty+1];
            accum += 0.242f * lmem[tx][ty+2];
            accum += 0.383f * lmem[tx][ty+3];
            accum += 0.242f * lmem[tx][ty+4];
            accum += 0.061f * lmem[tx][ty+5];
            accum += 0.006f * lmem[tx][ty+6];
            out[index + cc] = accum;
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }
}

__kernel void gaussianHoriz_kernel(__global mint * in, __global mint * out, mint width, mint height, mint channels, mint pitch) {
    __local int lmem[LOCALWORKSIZEDIM+6][LOCALWORKSIZEDIM];

    int tx = get_local_id(0), ty = get_local_id(1);
    int bx = get_group_id(0), by = get_group_id(1);
    int xIndex = get_global_id(0);
    int yIndex = get_global_id(1);

    if (yIndex >= height)
        return;

    int index = channels*xIndex + yIndex*pitch;

    Real_t accum;
    int cc;
    __global int * row = &in[yIndex*pitch];

    for (cc = 0; cc < channels; cc++) {
        lmem[tx+3][ty] = xIndex < width ? row[xIndex*channels + cc] : 0;
        if (tx < 3) {
            lmem[tx][ty] = (xIndex < width && xIndex > tx) ? row[(xIndex-3)*channels + cc] : 0;
            lmem[tx+LOCALWORKSIZEDIM+3][ty] = (xIndex + LOCALWORKSIZEDIM < width) ? row[(xIndex + LOCALWORKSIZEDIM)*channels + cc] : 0;
        }
        barrier(CLK_LOCAL_MEM_FENCE);

        if (xIndex < width) {
            accum  = 0.006f * lmem[tx][ty];
            accum += 0.061f * lmem[tx+1][ty];
            accum += 0.242f * lmem[tx+2][ty];
            accum += 0.383f * lmem[tx+3][ty];
            accum += 0.242f * lmem[tx+4][ty];
            accum += 0.061f * lmem[tx+5][ty];
            accum += 0.006f * lmem[tx+6][ty];
            out[index + cc] = accum;
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }
}


__kernel void sobelGxVert_kernel(__global mint * in, __global mint * out, mint width, mint height, mint channels, mint pitch) {
    __local int lmem[LOCALWORKSIZEDIM][LOCALWORKSIZEDIM+2];

    int tx = get_local_id(0), ty = get_local_id(1);
    int bx = get_group_id(0), by = get_group_id(1);
    int xIndex = get_global_id(0);
    int yIndex = get_global_id(1);

    if (xIndex >= width)
        return;

    int index = channels*xIndex + yIndex*pitch;

    int cc;
    __global int * col = &in[xIndex*channels];

    for (cc = 0; cc < channels; cc++) {
        lmem[tx][ty+1] = (yIndex < height) ? col[yIndex*pitch + cc] : 0;
        if (ty == 0) {
            lmem[tx][0] = (yIndex < height && yIndex > 0) ? col[(yIndex-1)*pitch + cc] : 0;
            lmem[tx][LOCALWORKSIZEDIM+1] = (yIndex+LOCALWORKSIZEDIM < height) ? col[(yIndex+LOCALWORKSIZEDIM)*pitch + cc] : 0;
        }
        barrier(CLK_LOCAL_MEM_FENCE);

        if (yIndex < height)
            out[index + cc] = lmem[tx][ty] + 2*lmem[tx][ty+1] + lmem[tx][ty+2];
        barrier(CLK_LOCAL_MEM_FENCE);
    }
}

__kernel void sobelGxHoriz_kernel(__global mint * in, __global mint * out, mint width, mint height, mint channels, mint pitch) {
    __local int lmem[LOCALWORKSIZEDIM+2][LOCALWORKSIZEDIM];

    int tx = get_local_id(0), ty = get_local_id(1);
    int bx = get_group_id(0), by = get_group_id(1);
    int xIndex = get_global_id(0);
    int yIndex = get_global_id(1);

    if (yIndex >= height)
        return;

    int index = channels*xIndex + yIndex*pitch;

    int cc;
    __global int * row = &in[yIndex*pitch];

    for (cc = 0; cc < channels; cc++) {
        lmem[tx+1][ty] = (xIndex < width) ? row[xIndex*channels + cc] : 0;
        if (tx == 0) {
            lmem[0][ty] = (xIndex < width && xIndex > 0) ? row[(xIndex-1)*channels + cc] : 0;
            lmem[LOCALWORKSIZEDIM+1][ty] = (xIndex+LOCALWORKSIZEDIM < width) ? row[(xIndex+LOCALWORKSIZEDIM)*channels + cc] : 0;
        }
        barrier(CLK_LOCAL_MEM_FENCE);

        if (xIndex < width)
            out[index + cc] = lmem[tx][ty] - lmem[tx+2][ty];
        barrier(CLK_LOCAL_MEM_FENCE);
    }
}

__kernel void sobelGyVert_kernel(__global mint * in, __global mint * out, mint width, mint height, mint channels, mint pitch) {
    __local int lmem[LOCALWORKSIZEDIM][LOCALWORKSIZEDIM+2];

    int tx = get_local_id(0), ty = get_local_id(1);
    int bx = get_group_id(0), by = get_group_id(1);
    int xIndex = get_global_id(0);
    int yIndex = get_global_id(1);

    if (xIndex >= width)
        return;

    int index = channels*xIndex + yIndex*pitch;

    int cc;
    __global int * col = &in[xIndex*channels];

    for (cc = 0; cc < channels; cc++) {
        lmem[tx][ty+1] = (yIndex < height) ? col[yIndex*pitch + cc] : 0;
        if (ty == 0) {
            lmem[tx][0] = (yIndex < height && yIndex > 0) ? col[(yIndex-1)*pitch + cc] : 0;
            lmem[tx][LOCALWORKSIZEDIM+1] = (yIndex+LOCALWORKSIZEDIM < height) ? col[(yIndex+LOCALWORKSIZEDIM)*pitch + cc] : 0;
        }
        barrier(CLK_LOCAL_MEM_FENCE);

        if (yIndex < height)
            out[index + cc] = lmem[tx][ty] - lmem[tx][ty+2];
        barrier(CLK_LOCAL_MEM_FENCE);
    }
}

__kernel void sobelGyHoriz_kernel(__global mint * in, __global mint * out, mint width, mint height, mint channels, mint pitch) {
    __local int lmem[LOCALWORKSIZEDIM+2][LOCALWORKSIZEDIM];

    int tx = get_local_id(0), ty = get_local_id(1);
    int bx = get_group_id(0), by = get_group_id(1);
    int xIndex = get_global_id(0);
    int yIndex = get_global_id(1);

    if (yIndex >= height)
        return;

    int index = channels*xIndex + yIndex*pitch;

    int cc;
    __global int * row = &in[yIndex*pitch];

    for (cc = 0; cc < channels; cc++) {
        lmem[tx+1][ty] = (xIndex < width) ? row[xIndex*channels + cc] : 0;
        if (tx == 0) {
            lmem[0][ty] = (xIndex < width && xIndex > 0) ? row[(xIndex-1)*channels + cc] : 0;
            lmem[LOCALWORKSIZEDIM+1][ty] = (xIndex+LOCALWORKSIZEDIM < width) ? row[(xIndex+LOCALWORKSIZEDIM)*channels + cc] : 0;
        }
        barrier(CLK_LOCAL_MEM_FENCE);

        if (xIndex < width)
            out[index + cc] = lmem[tx][ty] + 2*lmem[tx+1][ty] + lmem[tx+2][ty];
        barrier(CLK_LOCAL_MEM_FENCE);
    }
}

__kernel void magnitude_kernel(__global mint * gx, __global mint * gy, __global mint * out, mint width, mint height, mint channels, mint pitch) {
    int tx = get_local_id(0), ty = get_local_id(1);
    int bx = get_group_id(0), by = get_group_id(1);
    int xIndex = get_global_id(0);
    int yIndex = get_global_id(1);

    int index = channels*xIndex + yIndex*pitch;
    int cc;

    if (yIndex < height) {
        for (cc = 0; cc < channels; cc++)
            out[index + cc] = hypot((Real_t) gx[index+cc], (Real_t) gy[index+cc]);
    }
}


__kernel void atan_kernel(__global mint * gx, __global mint * gy, __global Real_t * out, mint width, mint height, mint channels, mint pitch) {
    int tx = get_local_id(0), ty = get_local_id(1);
    int bx = get_group_id(0), by = get_group_id(1);
    int xIndex = get_global_id(0);
    int yIndex = get_global_id(1);

    int index = channels*xIndex + yIndex*pitch;
    int cc, d;

    if (xIndex < width && yIndex < height) {
        for (cc = 0; cc < channels; cc++) {
            d = gx[index+cc];
            if (d != 0)
                out[index + cc] = atan((Real_t) gy[index+cc]/d);
            else
                out[index + cc] = gy[index+cc] ? 90.0f : 0.0f;
        }
    }
}


__kernel void zeroCrossing_kernel(__global Real_t * in, __global mint * out, mint width, mint height, mint channels, mint pitch) {
    int tx = get_local_id(0), ty = get_local_id(1);
    int bx = get_group_id(0), by = get_group_id(1);
    int xIndex = get_global_id(0);
    int yIndex = get_global_id(1);

    int index = channels*xIndex + yIndex*pitch;
    int cc;
    Real_t d;

    if (xIndex < width && yIndex < height) {
        for (cc = 0; cc < channels; cc++) {
            d = in[index+cc];
            if (d <= 22.5f || d >= 157.5f) {
                out[index+cc] = 0;
            } else if (d <= 67.5f) {
                out[index+cc] = 45;
            } else if (d <= 112.5f) {
                out[index+cc] = 90;
            } else {
                out[index+cc] = 135;
            }
        }
    }
}

__kernel void nonMaximalSuppression_kernel(__global mint * in, __global mint * direction, __global mint * out,
                                           mint width, mint height, mint channels, mint pitch) {
    __local int lmem[LOCALWORKSIZEDIM+2][LOCALWORKSIZEDIM+2];

    int tx = get_local_id(0), ty = get_local_id(1);
    int bx = get_group_id(0), by = get_group_id(1);
    int xIndex = get_global_id(0);
    int yIndex = get_global_id(1);
    int index = xIndex*channels + yIndex*pitch;
    int ii, jj, cc, d;

    for (cc = 0, ii = tx, jj = ty; cc < channels; cc++) {
        lmem[tx+1][ty+1] = (xIndex < width && yIndex < height) ? in[index + cc] : 0;
        if (tx == 0) {
            lmem[0][ty+1] = (xIndex > 0 && yIndex < height) ? in[index + cc - channels] : 0;
            lmem[LOCALWORKSIZEDIM+1][ty+1] = (xIndex+LOCALWORKSIZEDIM < width && yIndex < height) ? in[index + cc + channels*LOCALWORKSIZEDIM] : 0;
        }
        if (ty == 0) {
            lmem[tx+1][0] = (xIndex < width && yIndex > ty) ? in[index + cc - pitch] : 0;
            lmem[tx+1][LOCALWORKSIZEDIM+1] = (yIndex+LOCALWORKSIZEDIM < height && xIndex < width) ? in[index + cc + LOCALWORKSIZEDIM*pitch] : 0;
        }

        if (tx == 0 && ty == 0) {
            if (xIndex > 0 && yIndex > 0)
                lmem[0][0] = (xIndex < width && yIndex < width) ? in[index + cc - LOCALWORKSIZEDIM*pitch - channels] : 0;
            else
                lmem[0][0] = 0;

            if (xIndex > 0 && yIndex+LOCALWORKSIZEDIM < height)
                lmem[0][LOCALWORKSIZEDIM+1] = (xIndex < width) ? in[index + cc - channels + LOCALWORKSIZEDIM*pitch] : 0;
            else
                lmem[0][LOCALWORKSIZEDIM+1] = 0;

            if (xIndex+LOCALWORKSIZEDIM < width && yIndex > 0)
                lmem[LOCALWORKSIZEDIM+1][0] = (yIndex < height) ? in[index + cc + LOCALWORKSIZEDIM*channels - pitch] : 0;
            else
                lmem[LOCALWORKSIZEDIM+1][0] = 0;

            if (xIndex+LOCALWORKSIZEDIM < width && yIndex+LOCALWORKSIZEDIM < height)
                lmem[LOCALWORKSIZEDIM+1][LOCALWORKSIZEDIM+1] = in[index + cc + channels + LOCALWORKSIZEDIM*pitch];
            else
                lmem[LOCALWORKSIZEDIM+1][LOCALWORKSIZEDIM+1] = 0;
        }
        barrier(CLK_LOCAL_MEM_FENCE);

        tx++;
        ty++;

        if (xIndex < width && yIndex < height) {
            d = direction[index+cc];
            if (d == 0) {
                if (lmem[tx][ty+1] >= lmem[tx][ty] || lmem[tx][ty-1] >= lmem[tx][ty])
                    out[index+cc] = 0;
                else
                    out[index+cc] = lmem[tx][ty];
            } else if (d == 45) {
                if (lmem[tx-1][ty-1] >= lmem[tx][ty] || lmem[tx+1][ty+1] >= lmem[tx][ty])
                    out[index+cc] = 0;
                else
                    out[index+cc] = lmem[tx][ty];
            } else if (d == 90) {
                if (lmem[tx-1][ty] >= lmem[tx][ty] || lmem[tx+1][ty] >= lmem[tx][ty])
                    out[index+cc] = 0;
                else
                    out[index+cc] = lmem[tx][ty];
            } else {
                if (lmem[tx+1][ty-1] >= lmem[tx][ty] || lmem[tx-1][ty+1] >= lmem[tx][ty])
                    out[index+cc] = 0;
                else
                    out[index+cc] = lmem[tx][ty];
            }
        }
        tx = ii;
        ty = jj;
        barrier(CLK_LOCAL_MEM_FENCE);
    }
}

__kernel void hysteresis_kernel(__global mint * in, __global mint * out, mint width, mint height, mint channels, mint pitch) {
    int tx = get_local_id(0), ty = get_local_id(1);
    int bx = get_group_id(0), by = get_group_id(1);
    int xIndex = get_global_id(0);
    int yIndex = get_global_id(1);

    int index = channels*xIndex + yIndex*pitch;
    int cc, px;

    if (xIndex < width && yIndex < height) {
        for (cc = 0; cc < channels; cc++) {
            px = in[index+cc];
            if (px >= HIGH_THRESHOLD)
                out[index + cc] = 255;
            else if (px <= LOW_THRESHOLD)
                out[index + cc] = 0;
            else
                out[index + cc] = CANDIDATE_PIXEL; // should do another pass.
        }
    }
}

__kernel void binarize_kernel(__global mint * in, __global mint * out, mint width, mint height, mint channels, mint pitch) {
    int tx = get_local_id(0), ty = get_local_id(1);
    int bx = get_group_id(0), by = get_group_id(1);
    int xIndex = get_global_id(0);
    int yIndex = get_global_id(1);

    int index = channels*xIndex + yIndex*pitch;
    int cc, accum;

    if (xIndex < width && yIndex < height) {
        for (cc = 0, accum = 0; cc < channels; cc++)
            accum += in[index+cc];
        if (accum) {
            for (cc = 0; cc < channels; cc++)
                out[index+cc] = 255;
        } else {
            for (cc = 0; cc < channels; cc++)
                out[index+cc] = 0;
        }
    }
}





// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
