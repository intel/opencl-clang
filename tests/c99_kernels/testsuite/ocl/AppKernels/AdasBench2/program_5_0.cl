
constant sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE |
CLK_ADDRESS_CLAMP_TO_EDGE |
CLK_FILTER_LINEAR;

constant sampler_t sampler2 = CLK_NORMALIZED_COORDS_FALSE |
CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST; //P_ZOLI: Legyen inkabb linear

__kernel void findinterestpoint_stage1(
	read_only image2d_t image,
	__global float * L,
	int px,
					int py,
				  int harris_half_size,
				  int scan_half_size)

{
    int x0 = get_global_id(0) - 16;
    int y0 = get_global_id(1) - 16;

    float Lv;

    if (x0 < -scan_half_size || x0 > scan_half_size - 1 ||
        y0 < -scan_half_size || y0 > scan_half_size - 1) {
        Lv = 0;
    } else {

    float ixx = 0;
    float iyy = 0;
    float ixy = 0;

    // Do the convolution
    for (int y = -harris_half_size; y <= harris_half_size; y++) {
       for (int x = -harris_half_size; x <= harris_half_size; x++) {

            // The intensitites around the point in question
            float4 i   = read_imagef(image, sampler2, (int2)(px + x0 + x, py + y0 + y));
            float4 iy  = read_imagef(image, sampler2, (int2)(px + x0 + x, py + y0 + y - 1));
            float4 ix  = read_imagef(image, sampler2, (int2)(px + x0 + x - 1, py + y0 + y));

            float ig  = (i.s0  + i.s1  + i.s2 ) / 3.0f;
            float igy = (iy.s0 + iy.s1 + iy.s2 ) / 3.0f;
            float igx = (ix.s0 + ix.s1 + ix.s2 ) / 3.0f;

            // The derivatives
            float iix = ig - igx;
            float iiy = ig - igy;

            // The matrix elements
            ixx += iix * iix;
            iyy += iiy * iiy;
            ixy += iix * iiy;

        }
    }

    // Now check the eigenvalues of the Harris-matrix
    // The trace and the determinant
    float T = ixx + iyy;
    float D = ixx * iyy - ixy * ixy;

    // The eigenvalues
    float L1 = 0;
    float L2 = 0;
    if (T * T / 4 > D) {
        L1 = T / 2 + sqrt(T * T / 4 - D);
        L2 = T / 2 - sqrt(T * T / 4 - D);
    }
    Lv = L1 + L2;
    }

    // Saving the result
    L[(y0 + 16) * 32 + x0 + 16] = Lv;
}



__kernel void max_find(__global float * L)
{
    // The local id (has to be called with global size 1024, local size 256
    int lid = get_local_id(0);

    // Local stores for Ls and indexes
    __local float l_L[32 * 32];
    __local float l_IDX[32 * 32];

    // Copy the values from the global and fill up the indexes
    l_L[lid * 4 + 0]   = L[lid * 4 + 0];
    l_L[lid * 4 + 1]   = L[lid * 4 + 1];
    l_L[lid * 4 + 2]   = L[lid * 4 + 2];
    l_L[lid * 4 + 3]   = L[lid * 4 + 3];
    l_IDX[lid * 4 + 0] = lid * 4 + 0;
    l_IDX[lid * 4 + 1] = lid * 4 + 1;
    l_IDX[lid * 4 + 2] = lid * 4 + 2;
    l_IDX[lid * 4 + 3] = lid * 4 + 3;

    // Wait for everybody

    barrier(CLK_LOCAL_MEM_FENCE | CLK_GLOBAL_MEM_FENCE);

    if (l_L[512 + lid] < l_L[512 + lid + 256]) {
        l_L[512 + lid]   = l_L[512 + lid + 256];
        l_IDX[512 + lid] = l_IDX[512 + lid + 256];
    }

    barrier(CLK_LOCAL_MEM_FENCE);

    if (l_L[256 + lid] < l_L[256 + lid + 256]) {
        l_L[256 + lid]   = l_L[256 + lid + 256];
        l_IDX[256 + lid] = l_IDX[256 + lid + 256];
    }
    barrier(CLK_LOCAL_MEM_FENCE);

    // Now start the maximum finding
    int i = 512;
    while ( i > 1) {
        i = i / 2;
        if (lid < i) {
            if (l_L[lid]   < l_L[lid + i]) {
                l_L[lid]   = l_L[lid + i];
                l_IDX[lid] = l_IDX[lid + i];
            }
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }

    // Copy back the result
    L[0] = l_IDX[0];
}

__kernel void min_find(__global float * L)
{
    // The local id (has to be called with global size 1024, local size 256
    int lid = get_local_id(0);

    // Local stores for Ls and indexes
    __local float l_L[32 * 32];
    __local float l_IDX[32 * 32];

    // Copy the values from the global and fill up the indexes
    l_L[lid * 4 + 0]   = L[lid * 4 + 0];
    l_L[lid * 4 + 1]   = L[lid * 4 + 1];
    l_L[lid * 4 + 2]   = L[lid * 4 + 2];
    l_L[lid * 4 + 3]   = L[lid * 4 + 3];
    l_IDX[lid * 4 + 0] = lid * 4 + 0;
    l_IDX[lid * 4 + 1] = lid * 4 + 1;
    l_IDX[lid * 4 + 2] = lid * 4 + 2;
    l_IDX[lid * 4 + 3] = lid * 4 + 3;

    // Wait for everybody

    barrier(CLK_LOCAL_MEM_FENCE | CLK_GLOBAL_MEM_FENCE);

    if (l_L[512 + lid] > l_L[512 + lid + 256]) {
        l_L[512 + lid]   = l_L[512 + lid + 256];
        l_IDX[512 + lid] = l_IDX[512 + lid + 256];
    }

    barrier(CLK_LOCAL_MEM_FENCE);

    if (l_L[256 + lid] > l_L[256 + lid + 256]) {
        l_L[256 + lid]   = l_L[256 + lid + 256];
        l_IDX[256 + lid] = l_IDX[256 + lid + 256];
    }
    barrier(CLK_LOCAL_MEM_FENCE);

    // Now start the maximum finding
    int i = 512;
    while ( i > 1) {
        i = i / 2;
        if (lid < i) {
            if (l_L[lid]   > l_L[lid + i]) {
                l_L[lid]   = l_L[lid + i];
                l_IDX[lid] = l_IDX[lid + i];
            }
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }

    // Copy back the result
    L[0] = l_IDX[0];
}



__kernel void find_matches(read_only image2d_t prev_image, read_only image2d_t current_image, int search_half_range,
             int pattern_half_size, int p_x, int p_y, __global float * IP)
{
    float match = 0;

    int x0 = get_global_id(0) - 16;
    int y0 = get_global_id(1) - 16;

    if (x0 < -search_half_range || x0 > search_half_range - 1 ||
        y0 < -search_half_range || y0 > search_half_range - 1) {
        match = 0;
    } else {
    // Do the convolution
    for (int y = -pattern_half_size; y <= pattern_half_size; y++) {
        for (int x = -pattern_half_size; x <= pattern_half_size; x++) {

            float4 s = read_imagef(prev_image, sampler2, (int2)(p_x + x, p_y + y));
            float pattern_value = (s.s0 + s.s1 + s.s2) / 3.0f;

            float4 k = read_imagef(current_image, sampler2, (int2)(p_x + x0  + x, p_y + y0 + y));
            float gray_value = (k.s0 + k.s1 + k.s2) / 3.0f;

            float diff = pattern_value - gray_value;

            match += diff * diff;
        }
    }
    }
    IP[(y0 + 16) * 32 + x0 + 16] = match;
}


__kernel void ToGrayCar(read_only image2d_t inputImage, write_only image2d_t outputImage)
{
        int i = get_global_id(0);
        int j = get_global_id(1);

        float4 tmp = read_imagef(inputImage, sampler,(int2)(i, j));

        write_imagef(outputImage,(int2)(i, j), (tmp.x + tmp.y + tmp.z) / 3.0f);
}


__kernel void ToUCharGray(read_only image2d_t input, write_only image2d_t output)
{

        int i            = get_global_id(0);
        int j            = get_global_id(1);

        float4 tmp       = read_imagef(input, sampler,(float2)(i, j));
        float  value     = (tmp.x + tmp.y + tmp.z) / 3.0f;
        write_imagef(output, (int2)(i, j), value);
}

__kernel void SobelY(float _threshold, read_only image2d_t input, write_only image2d_t output) {

    int x0     = get_global_id(0);
    int y0     = get_global_id(1);

    float4 ym1 = read_imagef(input, sampler,(float2)(x0, y0 - 1));
    float4 y   = read_imagef(input, sampler, (float2)(x0, y0));

    float out    = 0.0f;
    float sobely = fabs(y.s0 - ym1.s0);

    if (sobely > _threshold) {out = 1.0f;}

    write_imagef(output, (int2)(x0, y0), out);
}


__kernel void ClearHorizLineSmall(write_only image2d_t small_image) {
    int x0 = get_global_id(0);
    int y0 = get_global_id(1);
    float4 out = {0.0f, 0.0f, 0.0f, 1.0f};
    write_imagef(small_image,(int2)(x0, y0), out);
}


__kernel void HorizontalLines(int scan_length, int min_length,
                        read_only image2d_t input, write_only image2d_t output) {

    int x0 = get_global_id(0);
    int y0 = get_global_id(1);
    int counter = 0;

    float out       = 0.0f;

    for (int x = -scan_length; x < scan_length; x++) {
        float4 value = read_imagef(input, sampler,(float2)(x0 + x, y0));
        if (value.s0 == 1) counter++;
    }
    if (counter > min_length) {
        out = 1.0f;
    }
    write_imagef(output,(int2)(x0, y0), out);
}



__kernel void FastHorizontalLines(int scan_length, int min_length, int width,
                        read_only image2d_t input, write_only image2d_t output) {

    int y = get_global_id(0);

    int counter = 0;
    for (int x = 0; x < 2 * scan_length; x++) {
        float4 value = read_imagef(input, sampler,(float2)(x, y));
        if (value.s0 == 1) counter++;
    }

    float leading;
    float trailing;

    for (int x = scan_length; x < width - scan_length; x++) {

        float leading  = read_imagef(input, sampler,(float2)(x + scan_length, y)).s0;
        float trailing = read_imagef(input, sampler,(float2)(x - scan_length, y)).s0;

        if (leading == 1) counter ++;
        if (trailing == 1) counter --;

        float out = 0.0f;
        if (counter > min_length) out = 1.0f;

        write_imagef(output, (int2)(x, y), out);
    }
}

__kernel void ReallyFastHorizontalLines(int scan_length, int min_length, int width,
                                read_only image2d_t input, write_only image2d_t output) {

    int x0 = get_global_id(0);
    int y0 = get_global_id(1);
    int length = 0;
    float out = 0;
    if ((x0 > scan_length) && ( x0 < width - scan_length)) {
        for (int x = - scan_length; x < scan_length; x++) {
            if (read_imagef(input, sampler,(float2)(x0 + x, y0)).s0 == 1) length++;
        }

        if (length > min_length) out = 1;

        write_imagef(output, (int2)(x0, y0), out);
    }
}


__kernel void CleanHorizontalLines(int scan_length, int min_number,
                         read_only image2d_t input, write_only image2d_t output) {

    int x0 = get_global_id(0);
    int y0 = get_global_id(1);
    int counter = 0;

    float out   = 0.0f;
    int blocker = 1;
    for (int y  = 0; y < scan_length; y++) {
        float4 value = read_imagef(input, sampler,(float2)(x0 + 0.5, y0 - y + 0.5));
        if ((value.s0 == 1) && (blocker == 1)) {
            counter++;
            blocker = -1;
        }
        if ((value.s0 == 0) && (blocker == -1)) {blocker = 1;}
    }

    if (counter > min_number) {
        out= 1.0f;
    }

    write_imagef(output,(int2)(x0, y0), out);
}





__kernel void RoadColorImage(float threshold, read_only image2d_t inputImage, write_only image2d_t outputImage)
{

	int i = get_global_id(0);
	int j = get_global_id(1);

	float o_color = 0;
	float4 i_color = read_imagef(inputImage, sampler, (float2)(i, j));
	if (i_color.s0 < threshold) { o_color = 1; }

	write_imagef(outputImage, (int2)(i, j), o_color);

}

__kernel void HaarXImage(int short_edge, int long_edge, float threshold,
	read_only image2d_t inputImage, write_only image2d_t outputImage) {

	int x0 = get_global_id(0);
	int y0 = get_global_id(1);

	float area = (4 * long_edge * short_edge);
	float value = 0;
	for (int y = -long_edge; y < long_edge; y++) {
		for (int x = -short_edge; x < short_edge; x++) {
			float sign = 1.0f; if (x < 0.0f) sign = -1.0f;
			value += sign * read_imagef(inputImage, sampler, (float2)(x0 + x, y0 + x)).s0;
		}
	}

	value /= area;

	if (fabs(value) > threshold) { value = 1.0f; }
	else { value = 0.0f; }

	write_imagef(outputImage, (int2)(x0, y0), value);

}

//__kernel void CreateProbImageFast(float rc_threshold, int short_edge, int long_edge, float edge_threshold,
//	read_only image2d_t input, read_only image2d_t red, write_only image2d_t output) {
//
//	int x0 = get_global_id(0);
//	int y0 = get_global_id(1);
//
//	float4 out = { 0.0f, 0.0f, 0.0f, 1.0f };
//
//
//	// The vertical edge image
//	float area = (4 * long_edge * short_edge);
//	float value = 0;
//	for (int y = -long_edge; y < long_edge; y++) {
//		for (int x = -short_edge; x < short_edge; x++) {
//			float sign = 1.0f; if (x < 0.0f) sign = -1.0f;
//			value += sign * read_imagef(input, sampler, (float2)(x0 + x, y0 + y)).s0;
//		}
//	}
//
//	value /= area;
//
//	if (fabs(value) > edge_threshold) { out.s1 = 1.0f; }
//	out.s0 = read_imagef(red, sampler, (float2)(x0, y0)).x;
//
//
//
//	// The road color segmentation
//	float4 i_color = read_imagef(input, sampler, (float2)(x0, y0));
//
//	// The color a bit before the point
//	float average = 0;
//	for (int x = 0; x < 20; x++) {
//		average += read_imagef(input, sampler, (float2)(x0 + x + 0.5, y0 + 20 + 0.5)).s0;
//	}
//	average /= 20;
//	if (i_color.s0 < average * 0.6) { out.s2 = 1.0f; }
//
//
//	// Writing out the stuff
//
//	write_imagef(output, (int2)(x0, y0), out);
//}















__kernel void CreateProbImageFastProba(float rc_threshold, int short_edge, int long_edge, float edge_threshold,
                read_only image2d_t input, read_only image2d_t red, write_only image2d_t output) {
//MODIFIED BY PZOLI, ADDED Y-DEPENDENCY for parameters of dimension image pixels.

   int x0 = get_global_id(0);
   int y0 = get_global_id(1);

   float4 out = {0.0f,0.0f,0.0f,1.0f};


   const int princip_y = 70;//PARAMETER, Danger, should be read from host.
   int y_princip = max(0, y0 - princip_y);


   // The vertical edge image
   short_edge = 1 + (y_princip / 24);
   long_edge = short_edge;// 1 + (y_princip / 16);

   float area_x = (short_edge);
   float area_y = (long_edge );
   float area = area_x*area_y;

   float value[4] = {0,0,0,0};
   float value_pos = 0;
   float value_neg = 0;

    for  (int y = - long_edge; y <= long_edge; y++) {
		float value_x = 0;
		if (y != 0){
			int idx_y = 0;
			if (y > 0)idx_y+=2;
			for (int x = -short_edge; x <= short_edge; x++) {
				int idx_x = idx_y; if (x > 0) idx_x++;
				if (x != 0){
					value[idx_x] += read_imagef(input, sampler2, (float2)(x0 + x, y0 + y)).s0;
				}
			}
		}
	}
    float muler=0.5 / area;
	float gx = (value[1] + value[3] - value[0] - value[2])*muler;
	float gy = (value[2] + value[3] - value[0] - value[1])*muler;
	//Szandekosan nem osztunk a tavolsaggal, plane nem a pixelben mert tavolsaggal...
	float K = gx*gx + gy*gy;
	float C = gx*gx - gy*gy;
	float S = 2 * gx*gy;

	/*
		//NINCS ERTELME, ALGEBRAILAG EKVIVALENS

		float gxy = value.dot((float4)(-0.7, 0, 0, 0.7));     //response to unit grad: 1.0
		float gx_y = value.dot((float4)(0, -0.7, 0.7, 0));
		float K2 = gxy*gxy + gx_y*gx_y;
		float C2 = gxy*gxy - gx_y*gx_y;
		float S2 = 2*gxy*gx_y;
		//C2 and S2 needs to be swapped.
		K+= K2;
		C+= - S2;
		S+=  C2;
		gx += 0.7*gxy - 0.7*gx_y;
		gy += 0.7*gxy + 0.7*gx_y;
	*/

	float val = 0;
	float gx_limit = 0.01;//PARAMETER
	float gx_lim2 = gx_limit*gx_limit;
	if (S*S<0.2*K*K&&gx*gx>gx_lim2){
		val = 0.5 + (gx*gx - gx_lim2) * 60;
	}
//	float val = fabs(value) / edge_threshold * 2;
//    if (val>0.25) {out.s1 = val;}
	out.s1 = val;



	// The road color segmentation
	float4 i_color = read_imagef(input, sampler2, (float2)(x0, y0));

	// The color a bit before the point
	float average = 0;
	int width = 4;// max(5, y_princip / 4);//regebben 20
	int delta_y = min(20, max(4, y_princip / 4));//regebben 20
	for (int x = 0; x < width; x++) {
		average += read_imagef(input, sampler2, (float2)(x0 + x - width / 2, y0 + delta_y)).s2;
	}
	average /= width;
	average = min(average, 255.0f);//PZOLI

	float limit = 0.95;
	float shadow = i_color.s2 / (average);
	if (shadow <  limit) {
//		out.s2 = 0.5+(limit - shadow) * 10;
		if (S*S<0.1*K*K&&gy>average*0.025){
			out.s2 = 0.5 + (gy - average*0.025)*50;
		}

	}



	out.s0 = read_imagef(red, sampler,(float2)(x0, y0)).x;

    // Writing out the stuff

    write_imagef(output,(int2)(x0, y0), out);
}

__kernel void create_histogram(
	__read_only image2d_t horizontal_lines,
	__global int * hist,
	__global int * base,
	const int height)
{
	const int x = get_global_id(0);

	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

	float max_val = 0.0f;
	int counter_val = 0;
	for (int y = 60; y < height; ++y)
	{
		const float val = read_imagef(horizontal_lines, sampler, (int2)(x, y)).x;
		if (val > 0.0f)
		{
			++counter_val;
			max_val = y;
		}
	}

	hist[x] = counter_val;
	base[x] = max_val;
}

//__kernel void integrate_r(
//	__read_only image2d_t prob_image,
//	__global float * integral,
//	const int width )
//{
//	const int y = get_global_id(0);
//	const int height = get_global_size(0);
//
//	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
//
//	float r_sum = 0.0f;
//	for (int x = 0; x < width; ++x)
//	{
//		float red = read_imagef(prob_image, sampler, (int2)(x, y)).z;
//		r_sum += red;
//		integral[x*height + y] = r_sum;	// better to write the transposed for better memory alignement
//	}
//}

#define WG_SIZE 128
#define MAX_ROW_SIZE 1024

__inline int RoiMinX(const float a, const float b, const int y)
{
	return max(0, (int)(((float)y - b) / a));
}

__inline int RoiMaxX(const float a, const float b, const int y, const int width)
{
	return min(width, max(0, (int)(((float)y - b) / a)));
}

/*
* Detect car shadows:
*
* search for long enough red stripes (horizontal edges) between green pixels (vertical edges)
*/
//__kernel __attribute__((reqd_work_group_size(WG_SIZE, 1, 1))) // each WG processes one image row
//	void shadow_detect(
//		__read_only image2d_t prob_image,
//		__global int4 * car_candidates,
//		const int width,
//		const int height,
//		const int ymin,
//		const float a1,
//		const float b1,
//		const float a2,
//		const float b2,
//		const int min_shadow_width )
//{
//	const int x = get_global_id(0);
//	const int y0 = get_global_id(1);
//	const int y = ymin + y0;
//	const int l_id = get_local_id(0);
//
//	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
//
//	__local uint starts[WG_SIZE * 2];			// green pixel locations (possible shadow starts / ends)
//	__local int red_integral[MAX_ROW_SIZE];		// one image row of horizontal edges used for faster counting
//	__local int counter;						// shadow start / end candidate count in one row
//
//	// init local memory...
//	if (l_id == 0) counter = 0;
//	starts[l_id]		= 0;
//	starts[WG_SIZE + l_id]	= 0;
//
//	// calculate ROI
//	float minX = RoiMinX(a1, b1, y);
//	float maxX = RoiMaxX(a2, b2, y, width);
//
//	for (int i = 0; i < MAX_ROW_SIZE / WG_SIZE; ++i) // fill in red pixels
//	{
//		const int idx = i * WG_SIZE + l_id;
//		ushort2 val = (ushort2)0;
//		if (idx < width)
//		{
//			const float2 p = read_imagef(prob_image, sampler, (int2)(idx, y)).zy;
//			const float2 p_prev = read_imagef(prob_image, sampler, (int2)(idx - 1, y)).zy;
//			const float2 p_next = read_imagef(prob_image, sampler, (int2)(idx + 1, y)).zy;
//			val.x = p.x > 0.5f ? 1 : 0;
//			if (p.y > 0.5f /*&& p_prev.y + p_next.y <= 1.0f*/ && idx > minX && idx < maxX)
//				val.y = 1;
//			val.x = p.x == 1.0f && val.y != 1 ? 1 : 0;
//
//		}
//		red_integral[idx] = as_uint(val);
//	}
//
//	barrier(CLK_LOCAL_MEM_FENCE); // INTEGRAL COMPUTATION (see prefix sum CL)
//
//	int offset = 1;
//
//	// build the sum in place up the tree
//	for (int d = MAX_ROW_SIZE >> 1; d > 0; d >>= 1)
//	{
//		barrier(CLK_LOCAL_MEM_FENCE);
//
//		// WG_SIZE < MAX_ROW_SIZE => loop through whole local memory
//		for (int k = 0; k < MAX_ROW_SIZE / WG_SIZE; ++k)
//		{
//			const int idx = WG_SIZE * k + l_id;
//			if (idx < d)
//			{
//				int ai = offset * (2 * idx + 1) - 1;
//				int bi = offset * (2 * idx + 2) - 1;
//
//				red_integral[bi] += red_integral[ai];
//			}
//		}
//
//
//		offset <<= 1;
//	}
//
//	// clear the last element
//	if (l_id == 0)
//	{
//		red_integral[MAX_ROW_SIZE - 1] = 0;
//	}
//
//	// traverse down the tree building the scan in the place
//	for (int d = 1; d < MAX_ROW_SIZE; d <<= 1)
//	{
//		offset >>= 1;
//		barrier(CLK_LOCAL_MEM_FENCE);
//
//		// again process whole local memory
//		for (int k = 0; k < MAX_ROW_SIZE / WG_SIZE; ++k)
//		{
//			const int idx = WG_SIZE * k + l_id;
//			if (idx < d)
//			{
//				int ai = offset * (2 * idx + 1) - 1;
//				int bi = offset * (2 * idx + 2) - 1;
//
//				int t = red_integral[ai];
//				red_integral[ai] = red_integral[bi];
//				red_integral[bi] += t;
//			}
//		}
//	}
//
//
//	barrier(CLK_LOCAL_MEM_FENCE);
//
//	// collect car candidates
//	const int block_count = (width - 1) / WG_SIZE + 1;
//	for (int i = 0; i < block_count; ++i)
//	{
//		const int idx = WG_SIZE * i + x;
//		const ushort sum2 = as_ushort2(red_integral[idx]).y;
//		const ushort sum1 = as_ushort2(red_integral[max(0, idx - 1)]).y;
//
//		if (sum2 > sum1)
//		{
//			starts[sum1] = idx;
//		}
//		//float g      = read_imagef(prob_image, sampler, (int2)(xi    , y)).y;
//		//float g_prev = read_imagef(prob_image, sampler, (int2)(xi - 1, y)).y;
//		//float g_next = read_imagef(prob_image, sampler, (int2)(xi + 1, y)).y;
//		//
//		//// candidate if green, has at least one green neighbour and inside ROI
//		//if (g == 1.0f && g_prev + g_next < 1.0f && xi > minX && xi < maxX)
//		//{
//		//	const int idx = atomic_inc(&counter);
//		//	starts[idx] = WG_SIZE * i + x;
//		//}
//	}
//
//	barrier(CLK_LOCAL_MEM_FENCE); // SORTING
//	// to find neighbouring car candidates locations (see bitonic sort CL)
//
//	/*if (counter == 0) return; // none found...
//
//	for (int l = 1; l < WG_SIZE; l <<= 1)
//	{
//		bool direction = ((l_id & (l << 1)) != 0); // direction of sort: 0=asc, 1=desc
//		// Loop on comparison distance (between keys)
//		for (int inc = l; inc > 0; inc >>= 1)
//		{
//			const int i = l_id;
//			const int j = l_id ^ inc; // sibling to compare
//
//			const uint iKey = starts[i];
//			const uint jKey = starts[j];
//			const bool smaller = (jKey < iKey) || (jKey == iKey && j < i);
//			const bool swap = smaller ^ (j < i) ^ direction;
//
//			barrier(CLK_LOCAL_MEM_FENCE);
//			starts[i] = (swap) ? jKey : iKey;
//			starts[j] = (swap) ? iKey : jKey;
//			barrier(CLK_LOCAL_MEM_FENCE);
//		}
//	}*/
//
//	int min_shadow_width__ = max(2,y0>>1);//BY PZOLI
//
//	// candidate shadow position
//	const uint start = starts[l_id];
//	const uint end = starts[l_id + 1];
//	if (end > 0 && start > 0)
//	{
//		const float reds = convert_float(as_ushort2(red_integral[end]).x) - convert_float(as_ushort2(red_integral[start]).x); // red pixel count
//		const float all_pixels = end - start;						// candidate length
//
//		float car_width = (float)(end - start) / (float)(abs(y - ymin)) * 1.5f;
//
//		// check candidate and write good ones to global memory
////		if (all_pixels > min_shadow_width && reds / all_pixels > 0.8f && car_width > 1.2f)
//		if (all_pixels > min_shadow_width__ && reds / all_pixels > 0.7f && car_width > 1.0f)//PZOLI
//		{
//			int idx = atomic_inc((__global int *)car_candidates);
//			car_candidates[idx] = (int4)(y, start, end, 0);
//		}
//	}
//
//}

__kernel void init_cars(
	__global int * cars)
{
	const int idx = get_global_id(0);
	cars[idx] = idx == 0 ? 1 : 0;
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
