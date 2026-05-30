float4 fir_get_mean_component_1D_CL(const global float4 *buf,
                                    int offset,
                                    const int delta_offset,
                                    constant float *cmatrix,
                                    const int matrix_length)
{
    float4 acc = 0.0f;
    int i;

    for(i=0; i<matrix_length; i++)
      {
        acc    += buf[offset] * cmatrix[i];
        offset += delta_offset;
      }
    return acc;
}

__kernel void fir_ver_blur_CL(const global float4 *src_buf,
                              const int src_width,
                              global float4 *dst_buf,
                              constant float *cmatrix,
                              const int matrix_length,
                              const int yoff)
{
    int gidx = get_global_id(0);
    int gidy = get_global_id(1);
    int gid  = gidx + gidy * get_global_size(0);

    int radius = matrix_length / 2;
    int src_offset = gidx + (gidy - radius + yoff) * src_width;

    dst_buf[gid] = fir_get_mean_component_1D_CL(
        src_buf, src_offset, src_width, cmatrix, matrix_length);
}

__kernel void fir_hor_blur_CL(const global float4 *src_buf,
                              const int src_width,
                              global float4 *dst_buf,
                              constant float *cmatrix,
                              const int matrix_length,
                              const int yoff)
{
    int gidx = get_global_id(0);
    int gidy = get_global_id(1);
    int gid  = gidx + gidy * get_global_size(0);

    int radius = matrix_length / 2;
    int src_offset = gidy * src_width + (gidx - radius + yoff);

    dst_buf[gid] = fir_get_mean_component_1D_CL(
        src_buf, src_offset, 1, cmatrix, matrix_length);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
