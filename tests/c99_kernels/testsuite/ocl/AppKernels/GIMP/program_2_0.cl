#define POW2(a) ((a) * (a))
kernel void bilateral_filter(global float4 *in,
                             global float4 *out,
                             const  float radius,
                             const  float preserve)
{
    int gidx       = get_global_id(0);
    int gidy       = get_global_id(1);
    int n_radius   = ceil(radius);
    int dst_width  = get_global_size(0);
    int src_width  = dst_width + n_radius * 2;

    int u, v, i, j;
    float4 center_pix =
        in[(gidy + n_radius) * src_width + gidx + n_radius];
    float4 accumulated = 0.0f;
    float4 tempf       = 0.0f;
    float  count       = 0.0f;
    float  diff_map, gaussian_weight, weight;

    for (v = -n_radius;v <= n_radius; ++v)
    {
        for (u = -n_radius;u <= n_radius; ++u)
        {
            i = gidx + n_radius + u;
            j = gidy + n_radius + v;

            int gid1d = i + j * src_width;
            tempf = in[gid1d];

            diff_map = exp (
                - (   POW2(center_pix.x - tempf.x)
                    + POW2(center_pix.y - tempf.y)
                    + POW2(center_pix.z - tempf.z))
                * preserve);

            gaussian_weight =
                exp( - 0.5f * (POW2(u) + POW2(v)) / radius);

            weight = diff_map * gaussian_weight;

            accumulated += tempf * weight;
            count += weight;
        }
    }
    out[gidx + gidy * dst_width] = accumulated / count;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
