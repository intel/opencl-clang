constant int RADIUS = 10;

__kernel void guidedCreateInputData( __global  float4* restrict normals, __global  float4* restrict image_in, __global  float* restrict filterShadow, __global float4* restrict GFInput0)
{
	const size_t currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);
	const size_t offset = get_global_size(0) * get_global_size(1);

	float4 inputp0, inputp1, inputp2, inputp3;
	float4 image = image_in[currIndex];
	float4 normal = normals[currIndex];
	normal = (float4)(clamp(normal.x+normal.y+normal.z, -3.0f, 3.0f), max(0.0f, filterShadow[currIndex]+normal.w), 0.0f, 0.0f);

	image = (float4)(clamp(image.x, 0.0f, 20.0f), clamp(image.y, 0.0f, 20.0f), clamp(image.z, 0.0f, 20.0f), 0.0f);

	inputp0.x = normal.x;
	inputp0.y = normal.y;
	inputp0.z = normal.x * normal.y;
	inputp0.w = 0.0f;
	inputp1.x = image.x;
	inputp1.y = image.y;
	inputp1.z = image.z;
	inputp1.w = 0.0f;
	inputp2.x = normal.x * image.x;
	inputp2.y = normal.x * image.y;
	inputp2.z = normal.x * image.z;
	inputp2.w = normal.x * normal.x;
	inputp3.x = normal.y * image.x;
	inputp3.y = normal.y * image.y;
	inputp3.z = normal.y * image.z;
	inputp3.w = normal.y * normal.y;

	GFInput0[0*offset + currIndex] = inputp0;
	GFInput0[1*offset + currIndex] = inputp1;
	GFInput0[2*offset + currIndex] = inputp2;
	GFInput0[3*offset + currIndex] = inputp3;

}

__kernel void guidedFilter(__global float4* restrict GFInput0, __global  float4* restrict Akf4)
{
	const size_t currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);
	const size_t x = get_global_id(0);
	const size_t y = get_global_id(1);
	const size_t xSize = get_global_size(0);
	const size_t offset = get_global_size(0) * get_global_size(1);

	int radius = RADIUS;
	float epsilon = 0.01f;

	int2 UR = clamp( (int2)(x+radius, y-radius-1),   (int2)(0,0), (int2)(get_global_size(0)-1,get_global_size(1)-1) );
	int2 LR = clamp( (int2)(x+radius, y+radius),     (int2)(0,0), (int2)(get_global_size(0)-1,get_global_size(1)-1) );
	int2 UL = clamp( (int2)(x-radius-1, y-radius-1), (int2)(0,0), (int2)(get_global_size(0)-1,get_global_size(1)-1) );
	int2 LL = clamp( (int2)(x-radius-1, y+radius),   (int2)(0,0), (int2)(get_global_size(0)-1,get_global_size(1)-1) );

	int num = x<=radius ? (y<=radius ? (LR.x+1)*(LR.y+1) : (LR.x+1)*(LR.y-UR.y)) : (y>radius ? (LR.x-LL.x)*(LR.y-UR.y) : (LR.x-LL.x)*(LR.y+1));

	float4 GFI00UR =  GFInput0[0*offset + UR.y*xSize + UR.x];
	float4 GFI01UR =  GFInput0[1*offset + UR.y*xSize + UR.x];
	float4 GFI00LR =  GFInput0[0*offset + LR.y*xSize + LR.x];
	float4 GFI01LR =  GFInput0[1*offset + LR.y*xSize + LR.x];
	float4 GFI00UL =  GFInput0[0*offset + UL.y*xSize + UL.x];
	float4 GFI01UL =  GFInput0[1*offset + UL.y*xSize + UL.x];
	float4 GFI00LL =  GFInput0[0*offset + LL.y*xSize + LL.x];
	float4 GFI01LL =  GFInput0[1*offset + LL.y*xSize + LL.x];


	float4 temp =    (x<=radius ? (y<=radius ? GFI00LR : GFI00LR-GFI00UR) : (y>radius ? GFI00UL+GFI00LR-GFI00LL-GFI00UR : GFI00LR-GFI00LL))/num;
	float4 mean_P =    (x<=radius ? (y<=radius ? GFI01LR : GFI01LR-GFI01UR) : (y>radius ? GFI01UL+GFI01LR-GFI01LL-GFI01UR : GFI01LR-GFI01LL))/num;
	float4 mean_I = (float4)(temp.x, temp.y, 0.0f, 0.0f);
	float xy = temp.z;

	GFI00UR =  GFInput0[2*offset + UR.y*xSize + UR.x];
	GFI01UR =  GFInput0[3*offset + UR.y*xSize + UR.x];
	GFI00LR =  GFInput0[2*offset + LR.y*xSize + LR.x];
	GFI01LR =  GFInput0[3*offset + LR.y*xSize + LR.x];
	GFI00UL =  GFInput0[2*offset + UL.y*xSize + UL.x];
	GFI01UL =  GFInput0[3*offset + UL.y*xSize + UL.x];
	GFI00LL =  GFInput0[2*offset + LL.y*xSize + LL.x];
	GFI01LL =  GFInput0[3*offset + LL.y*xSize + LL.x];

	float4 mean_IP_x = (x<=radius ? (y<=radius ? GFI00LR : GFI00LR-GFI00UR) : (y>radius ? GFI00UL+GFI00LR-GFI00LL-GFI00UR : GFI00LR-GFI00LL))/num;
	float4 mean_IP_y = (x<=radius ? (y<=radius ? GFI01LR : GFI01LR-GFI01UR) : (y>radius ? GFI01UL+GFI01LR-GFI01LL-GFI01UR : GFI01LR-GFI01LL))/num;
	float xx = mean_IP_x.w;
	float yy = mean_IP_y.w;
	mean_IP_x.w = 0.0f;
	mean_IP_y.w = 0.0f;

	xx = xx - mean_I.x * mean_I.x + epsilon;
	xy-= mean_I.x * mean_I.y;
	yy = yy - mean_I.y * mean_I.y + 5.0f;

	float invdet = 1.0f/(xx*yy - xy*xy);
    float mxx =  yy * invdet;
    float mxy = -xy * invdet;
    float myx = -xy * invdet;
    float myy =  xx * invdet;

	float4 cov_IP_x = mean_IP_x - mean_I.x*mean_P;
	float4 cov_IP_y = mean_IP_y - mean_I.y*mean_P;

	float4 Akx = (float4) (cov_IP_x.x*mxx + cov_IP_y.x*myx, cov_IP_x.y*mxx + cov_IP_y.y*mxy, cov_IP_x.z*mxx + cov_IP_y.z*mxy, 0.0f);
	float4 Aky = (float4) (cov_IP_x.x*mxy + cov_IP_y.x*myy, cov_IP_x.y*mxy + cov_IP_y.y*myy, cov_IP_x.z*mxy + cov_IP_y.z*myy, 0.0f);
	float4 Bk0 = (float4)(mean_P.x - Akx.x * mean_I.x - Aky.x * mean_I.y, mean_P.y - Akx.y * mean_I.x - Aky.y * mean_I.y, mean_P.z - Akx.z * mean_I.x - Aky.z * mean_I.y, 0.0f);

	Akf4[0*offset + currIndex] = Akx;
	Akf4[1*offset + currIndex] = Aky;
	Akf4[2*offset + currIndex] = Bk0;

}

__kernel void guidedFilterSAT (const int w, const int h ,__global const float4* restrict in, __global  float4* restrict out)
{
	const int globaloffset = h * w;
	size_t currIndex = get_global_id(0);
	int shift = get_global_id(1);

	float4 sum = (float4)(0.0f);
	for(int i = 0; i<h; i++ ){
		sum +=in[shift*globaloffset + currIndex];
		out[shift*globaloffset + currIndex] = sum;
		currIndex += w;
	}
}

__kernel void guidedFilterTransposeLocal16x16( const int w, const int h ,__global const float4* restrict in, __global  float4* restrict out)
{
	const int globaloffset = h * w;
	size_t i = get_global_id(2);

	local float4 aux[256];
	int bx = get_group_id(0),
		by = get_group_id(1);
	int ix = get_local_id(0),
		iy = get_local_id(1);

	by = (by+bx)%get_num_groups(1);

	in += (bx*16)+(by*16)*w;
	out += (by*16)+(bx*16)*h;

	aux[iy+ix*16] = in[i*globaloffset + ix+w*iy];
	barrier(CLK_LOCAL_MEM_FENCE);
	out[i*globaloffset + ix+h*iy] = aux[ix+iy*16];
	barrier(CLK_LOCAL_MEM_FENCE);
}

__kernel void guidedFilterTransposeLocal8x8( const int w, const int h ,__global const float4* restrict in, __global  float4* restrict out)
{
	const int globaloffset = h * w;
	size_t i = get_global_id(2);

	local float4 aux[256];
	int bx = get_group_id(0),
		by = get_group_id(1);
	int ix = get_local_id(0),
		iy = get_local_id(1);

	by = (by+bx)%get_num_groups(1);

	in += (bx*8)+(by*8)*w;
	out += (by*8)+(bx*8)*h;

	aux[iy+ix*8] = in[i*globaloffset + ix+w*iy];
	barrier(CLK_LOCAL_MEM_FENCE);
	out[i*globaloffset + ix+h*iy] = aux[ix+iy*8];
	barrier(CLK_LOCAL_MEM_FENCE);
}

__kernel void guidedFilterTransposeGlobal( const int w, const int h ,__global const float4* restrict in, __global  float4* restrict out)
{
	const int globaloffset = h * w;

	const size_t x = get_global_id(0);
	const size_t y = get_global_id(1);
	for (int i=0; i<4; i++)
		out[i*globaloffset +  y+x*h] = in[i*globaloffset +  x+y*w];
}

__kernel void guidedFilterComp( __global  float4* restrict normals, __global  float4* restrict image_in, __global  float4* restrict Ak, __global  float* restrict filterShadow, __global float4* restrict out)
{
	const size_t x = get_global_id(0);
	const size_t y = get_global_id(1);
	const size_t xSize = get_global_size(0);
	const size_t offset = get_global_size(0) * get_global_size(1);
	const size_t currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);

	int radius = RADIUS;

	int2 UR = clamp( (int2)(x+radius,   y-radius-1), (int2)(0,0), (int2)(get_global_size(0)-1,get_global_size(1)-1) );
	int2 LR = clamp( (int2)(x+radius,   y+radius  ), (int2)(0,0), (int2)(get_global_size(0)-1,get_global_size(1)-1) );
	int2 UL = clamp( (int2)(x-radius-1, y-radius-1), (int2)(0,0), (int2)(get_global_size(0)-1,get_global_size(1)-1) );
	int2 LL = clamp( (int2)(x-radius-1, y+radius  ), (int2)(0,0), (int2)(get_global_size(0)-1,get_global_size(1)-1) );

	int num = x<=radius ? (y<=radius ? (LR.x+1)*(LR.y+1) : (LR.x+1)*(LR.y-UR.y)) : (y>radius ? (LR.x-LL.x)*(LR.y-UR.y) : (LR.x-LL.x)*(LR.y+1));

	float4 GFI00UR =  Ak[0*offset + UR.y*xSize + UR.x];
	float4 GFI01UR =  Ak[1*offset + UR.y*xSize + UR.x];
	float4 GFI02UR =  Ak[2*offset + UR.y*xSize + UR.x];
	float4 GFI00LR =  Ak[0*offset + LR.y*xSize + LR.x];
	float4 GFI01LR =  Ak[1*offset + LR.y*xSize + LR.x];
	float4 GFI02LR =  Ak[2*offset + LR.y*xSize + LR.x];
	float4 GFI00UL =  Ak[0*offset + UL.y*xSize + UL.x];
	float4 GFI01UL =  Ak[1*offset + UL.y*xSize + UL.x];
	float4 GFI02UL =  Ak[2*offset + UL.y*xSize + UL.x];
	float4 GFI00LL =  Ak[0*offset + LL.y*xSize + LL.x];
	float4 GFI01LL =  Ak[1*offset + LL.y*xSize + LL.x];
	float4 GFI02LL =  Ak[2*offset + LL.y*xSize + LL.x];

	float4 Akx = (x<=radius ? (y<=radius ? GFI00LR : GFI00LR-GFI00UR) : (y>radius ? GFI00UL+GFI00LR-GFI00LL-GFI00UR : GFI00LR-GFI00LL))/num;
	float4 Aky = (x<=radius ? (y<=radius ? GFI01LR : GFI01LR-GFI01UR) : (y>radius ? GFI01UL+GFI01LR-GFI01LL-GFI01UR : GFI01LR-GFI01LL))/num;
	float4 Bk = (x<=radius ? (y<=radius ? GFI02LR : GFI02LR-GFI02UR) : (y>radius ? GFI02UL+GFI02LR-GFI02LL-GFI02UR : GFI02LR-GFI02LL))/num;

	out[currIndex] =(Akx*(normals[currIndex].x+normals[currIndex].y+normals[currIndex].z) + Aky*(filterShadow[currIndex]+normals[currIndex].w) + Bk);
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
