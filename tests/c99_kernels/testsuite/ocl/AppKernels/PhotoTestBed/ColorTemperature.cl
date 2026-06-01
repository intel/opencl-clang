#define ROUND_INT( dValue ) ((int)(dValue + 0.5))

constant sampler_t sample_nearest = CLK_NORMALIZED_COORDS_FALSE |
                            CLK_ADDRESS_CLAMP_TO_EDGE |
                            CLK_FILTER_NEAREST;

kernel void colorTemperature(global const ushort4* src,
                            global ushort4* dst,
                            int nWidth,
                            float mat10, float mat11, float mat12,
							float mat20, float mat21, float mat22,
							float mat30, float mat31, float mat32,
                            global ushort* tbl)
{
    int idx = get_global_id(0);
    if (idx >= nWidth)
        return;

    ushort4 buffer4 = src[idx];

    int	nRed    = ROUND_INT(mat10 * buffer4.s2 + mat11 * buffer4.s1 + mat12 * buffer4.s0);
    int	nGreen  = ROUND_INT(mat20 * buffer4.s2 + mat21 * buffer4.s1 + mat22 * buffer4.s0);
    int	nBlue   = ROUND_INT(mat30 * buffer4.s2 + mat31 * buffer4.s1 + mat32 * buffer4.s0);

    buffer4.s2  = clamp(nRed, 0, USHRT_MAX);
    buffer4.s1  = clamp(nGreen, 0, USHRT_MAX);
    buffer4.s0  = tbl[ clamp(nBlue, 0, USHRT_MAX) ];

    dst[idx] = buffer4;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
