#define TRUE true

#define FALSE false
#define ANGLE_PRIME 95273
#define RADIUS_PRIME 29537

void sample_min_max(const __global   float4 *src_buf,
                                     int     src_width,
                                     int     src_height,
                    const __global   float  *radiuses,
                    const __global   float  *lut_cos,
                    const __global   float  *lut_sin,
                                     int     x,
                                     int     y,
                                     int     radius,
                                     int     samples,
                                     float4 *min,
                                     float4 *max,
                                     int     j,
                                     int     iterations)
{
    float4 best_min;
    float4 best_max;
    float4 center_pix = *(src_buf + src_width * y + x);
    int i;

    best_min = center_pix;
    best_max = center_pix;

    int angle_no  = (src_width * y + x) * (iterations) *
                       samples + j * samples;
    int radius_no = angle_no;
    angle_no  %= ANGLE_PRIME;
    radius_no %= RADIUS_PRIME;
    for(i=0; i<samples; i++)
    {
        int angle;
        float rmag;
        /* if we've sampled outside the valid image
           area, we grab another sample instead, this
           should potentially work better than mirroring
           or extending the image */

         angle = angle_no++;
         rmag  = radiuses[radius_no++] * radius;

         if( angle_no  >= ANGLE_PRIME)
             angle_no   = 0;
         if( radius_no >= RADIUS_PRIME)
             radius_no  = 0;

         int u = x + rmag * lut_cos[angle];
         int v = y + rmag * lut_sin[angle];

         if(u>=src_width || u <0 || v>=src_height || v<0)
         {
             //--i;
             continue;
         }
         float4 pixel = *(src_buf + (src_width * v + u));
         if(pixel.w<=0.0f)
         {
             //--i;
             continue;
         }

         best_min = pixel < best_min ? pixel : best_min;
         best_max = pixel > best_max ? pixel : best_max;
    }

    (*min).xyz = best_min.xyz;
    (*max).xyz = best_max.xyz;
}

void compute_envelopes_CL(const __global  float4 *src_buf,
                                          int     src_width,
                                          int     src_height,
                          const __global  float  *radiuses,
                          const __global  float  *lut_cos,
                          const __global  float  *lut_sin,
                                          int     x,
                                          int     y,
                                          int     radius,
                                          int     samples,
                                          int     iterations,
                                          float4 *min_envelope,
                                          float4 *max_envelope)
{
    float4 range_sum = 0;
    float4 relative_brightness_sum = 0;
    float4 pixel = *(src_buf + src_width * y + x);

    int i;
    for(i =0; i<iterations; i++)
    {
        float4 min,max;
        float4 range, relative_brightness;

        sample_min_max(src_buf, src_width, src_height,
                        radiuses, lut_cos, lut_sin, x, y,
                        radius,samples,&min,&max,i,iterations);
        range = max - min;
        relative_brightness = range <= 0.0f ?
                               0.5f : (pixel - min) / range;
        relative_brightness_sum += relative_brightness;
        range_sum += range;
    }

    float4 relative_brightness = relative_brightness_sum / iterations;
    float4 range = range_sum / iterations;

    if(max_envelope)
        *max_envelope = pixel + (1.0f - relative_brightness) * range;

    if(min_envelope)
        *min_envelope = pixel - relative_brightness * range;
}

__kernel void C2g_CL(const __global float4 *src_buf,
                                    int     src_width,
                                    int     src_height,
                     const __global float  *radiuses,
                     const __global float  *lut_cos,
                     const __global float  *lut_sin,
                           __global float2 *dst_buf,
                                    int     radius,
                                    int     samples,
                                    int     iterations)
{
    int gidx = get_global_id(0);
    int gidy = get_global_id(1);

    int x = gidx + radius;
    int y = gidy + radius;

    int src_offset = (src_width * y + x);
    int dst_offset = gidx + get_global_size(0) * gidy;
    float4 min,max;

    compute_envelopes_CL(src_buf, src_width, src_height,
                         radiuses, lut_cos, lut_sin, x, y,
                         radius, samples, iterations, &min, &max);

    float4 pixel = *(src_buf + src_offset);

    float nominator=0, denominator=0;
    float4 t1 = (pixel - min) * (pixel - min);
    float4 t2 = (pixel - max) * (pixel - max);

    nominator   = t1.x + t1.y + t1.z;
    denominator = t2.x + t2.y + t2.z;

    nominator   = sqrt(nominator);
    denominator = sqrt(denominator);
    denominator+= nominator + denominator;

    dst_buf[dst_offset].x = (denominator > 0.000f)
                             ? (nominator / denominator) : 0.5f;
    dst_buf[dst_offset].y =  src_buf[src_offset].w;
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
