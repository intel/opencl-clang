/* em3d_fdtd_gpu_kern.cl
 *
 * Copyright (c) 2008 Brown Deer Technology, LLC.  All Rights Reserved.
 *
 * This software was developed by Brown Deer Technology, LLC.
 * For more information contact info@browndeertechnology.com
 *
 * This program is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 3 as published by
 * the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/* DAR */

#define HX	0
#define HY	1
#define HZ	2

#define EX	0
#define EY	1
#define EZ	2

__kernel void
hcomp_kern(
	float4 src,
	int nx, int ny, int nz,
	float4 b,
	__global float4* hh,
	__global float4* ee
)
{
	float4 zero4 = (float4){0.0f,0.0f,0.0f,0.0f};
	float4 one4 = (float4){1.0f,1.0f,1.0f,1.0f};
	float4 mask_xyz0 = (float4){1.0f,1.0f,1.0f,0.0f};
	float4 bx4 = (float4){b.x,b.x,b.x,b.x};
	float4 by4 = (float4){b.y,b.y,b.y,b.y};
	float4 bz4 = (float4){b.z,b.z,b.z,b.z};

	__local float4 w_hx000[260];
	__local float4 w_hy000[260];
	__local float4 w_hz000[260];

	__local float4 w_ex000[130];
	__local float4 w_ey000[130];
	__local float4 w_ez000[130];

	__local float4 w_ex100[65];
	__local float4 w_ey100[65];
	__local float4 w_ez100[65];

	int nyz = ny*nz;

	int mx = nx - 1;
	int my = ny - 1;
	int mz = nz - 1;

	int nx2 = nx/2;
	int ny2 = ny/2;


	// get global thread coordinate //

	int gtx = get_global_id(0);
	int gty = get_global_id(1);
	int gtz = get_global_id(2);

	int gtx1 = (gtx+1)%nx;

	int y = 4*gty;
	int y1 = y+1;
	int y2 = y1+1;
	int y3 = y2+1;
	int y4 = (y3+1)%ny;

	// get local thread coordinate in work-group //

	int tz = get_local_id(2);

	// copy data into local storage, threads in work-group work together //

	int gci0003 = 3*(gtx*nyz + y*nz) + gtz;
	int gci0103 = 3*(gtx*nyz + y1*nz) + gtz;
	int gci0203 = 3*(gtx*nyz + y2*nz) + gtz;
	int gci0303 = 3*(gtx*nyz + y3*nz) + gtz;

	w_hx000[tz] 		= hh[gci0003+HX*nz];
	w_hy000[tz] 		= hh[gci0003+HY*nz];
	w_hz000[tz] 		= hh[gci0003+HZ*nz];

	w_hx000[tz+65] 	= hh[gci0103+HX*nz];
	w_hy000[tz+65] 	= hh[gci0103+HY*nz];
	w_hz000[tz+65] 	= hh[gci0103+HZ*nz];

	w_hx000[tz+130] 	= hh[gci0203+HX*nz];
	w_hy000[tz+130] 	= hh[gci0203+HY*nz];
	w_hz000[tz+130] 	= hh[gci0203+HZ*nz];

	w_hx000[tz+195] 	= hh[gci0303+HX*nz];
	w_hy000[tz+195] 	= hh[gci0303+HY*nz];
	w_hz000[tz+195] 	= hh[gci0303+HZ*nz];


//	float4 maska = (gtx==mx)? zero4 : one4;
//	float4 maskb = (y3==my)? zero4 : one4;
//	float4 maskc = (gtz==mx)? mask_xyz0 : one4;


//// load 0

	{
	int gci0003 = 3*(gtx*nyz + y*nz) + gtz;
	int gci0103 = 3*(gtx*nyz + y1*nz) + gtz;
	int gci1003 = 3*(gtx1*nyz + y*nz) + gtz;

	w_ex000[tz] = ee[gci0003+EX*nz];
	w_ey000[tz] = ee[gci0003+EY*nz];
	w_ez000[tz] = ee[gci0003+EZ*nz];

	w_ex000[tz+65] = ee[gci0103+EX*nz];
	w_ey000[tz+65] = ee[gci0103+EY*nz];
	w_ez000[tz+65] = ee[gci0103+EZ*nz];

	w_ex100[tz] = ee[gci1003+EX*nz];
	w_ey100[tz] = ee[gci1003+EY*nz];
	w_ez100[tz] = ee[gci1003+EZ*nz];

	if (tz==0) {
		w_ex000[64] = w_ex000[0].yzwx;
		w_ex000[64+65] = w_ex000[0+65].yzwx;

		w_ey000[64] = w_ey000[0].yzwx;
		w_ey000[64+65] = w_ey000[0+65].yzwx;

		w_ez000[64] = w_ez000[0].yzwx;
		w_ez000[64+65] = w_ez000[0+65].yzwx;

	}

	barrier(CLK_LOCAL_MEM_FENCE);

	w_hx000[tz] += bz4*(w_ey000[tz+1] - w_ey000[tz]) + by4*(w_ez000[tz] - w_ez000[tz+65]);
	w_hy000[tz] += bx4*(w_ez100[tz] - w_ez000[tz]) + bz4*(w_ex000[tz] - w_ex000[tz+1]);
	w_hz000[tz] += by4*(w_ex000[tz+65] - w_ex000[tz]) + bx4*(w_ey000[tz] - w_ey100[tz]);


//   w_hx000[tz] *= maskc;
//   w_hy000[tz] *= maska*maskc;
//   w_hz000[tz] *= maska;

	}

//// reload +1

	{
	int gci0003 = 3*(gtx*nyz + y1*nz) + gtz;
	int gci0103 = 3*(gtx*nyz + y2*nz) + gtz;
	int gci1003 = 3*(gtx1*nyz + y1*nz) + gtz;

   w_ex000[tz] = ee[gci0003+EX*nz];
   w_ey000[tz] = ee[gci0003+EY*nz];
   w_ez000[tz] = ee[gci0003+EZ*nz];

   w_ex000[tz+65] = ee[gci0103+EX*nz];
   w_ey000[tz+65] = ee[gci0103+EY*nz];
   w_ez000[tz+65] = ee[gci0103+EZ*nz];

   w_ex100[tz] = ee[gci1003+EX*nz];
   w_ey100[tz] = ee[gci1003+EY*nz];
   w_ez100[tz] = ee[gci1003+EZ*nz];

   if (tz==0) {
      w_ex000[64] = w_ex000[0].yzwx;
      w_ex000[64+65] = w_ex000[0+65].yzwx;

      w_ey000[64] = w_ey000[0].yzwx;
      w_ey000[64+65] = w_ey000[0+65].yzwx;

   }

   barrier(CLK_LOCAL_MEM_FENCE);

   w_hx000[tz+65] += bz4*(w_ey000[tz+1] - w_ey000[tz]) + by4*(w_ez000[tz] - w_ez000[tz+65]);
   w_hy000[tz+65] += bx4*(w_ez100[tz] - w_ez000[tz]) + bz4*(w_ex000[tz] - w_ex000[tz+1]);
   w_hz000[tz+65] += by4*(w_ex000[tz+65] - w_ex000[tz]) + bx4*(w_ey000[tz] - w_ey100[tz]);


//   w_hx000[tz+65] *= maskc;
//   w_hy000[tz+65] *= maska*maskc;
//   w_hz000[tz+65] *= maska;

	}


//// reload +2

	{
   int gci0003 = 3*(gtx*nyz + y2*nz) + gtz;
   int gci0103 = 3*(gtx*nyz + y3*nz) + gtz;
   int gci1003 = 3*(gtx1*nyz + y2*nz) + gtz;

   w_ex000[tz] = ee[gci0003+EX*nz];
   w_ey000[tz] = ee[gci0003+EY*nz];
   w_ez000[tz] = ee[gci0003+EZ*nz];

   w_ex000[tz+65] = ee[gci0103+EX*nz];
   w_ey000[tz+65] = ee[gci0103+EY*nz];
   w_ez000[tz+65] = ee[gci0103+EZ*nz];

   w_ex100[tz] = ee[gci1003+EX*nz];
   w_ey100[tz] = ee[gci1003+EY*nz];
   w_ez100[tz] = ee[gci1003+EZ*nz];

   if (tz==0) {
      w_ex000[64] = w_ex000[0].yzwx;
      w_ex000[64+65] = w_ex000[0+65].yzwx;

      w_ey000[64] = w_ey000[0].yzwx;
      w_ey000[64+65] = w_ey000[0+65].yzwx;

   }

   barrier(CLK_LOCAL_MEM_FENCE);

   w_hx000[tz+130] += bz4*(w_ey000[tz+1] - w_ey000[tz]) + by4*(w_ez000[tz] - w_ez000[tz+65]);
   w_hy000[tz+130] += bx4*(w_ez100[tz] - w_ez000[tz]) + bz4*(w_ex000[tz] - w_ex000[tz+1]);
   w_hz000[tz+130] += by4*(w_ex000[tz+65] - w_ex000[tz]) + bx4*(w_ey000[tz] - w_ey100[tz]);


//   w_hx000[tz+130] *= maskc;
//   w_hy000[tz+130] *= maska*maskc;
//   w_hz000[tz+130] *= maska;
	}

//// reload +3

	{
   int gci0003 = 3*(gtx*nyz + y3*nz) + gtz;
   int gci0103 = 3*(gtx*nyz + y4*nz) + gtz;
   int gci1003 = 3*(gtx1*nyz + y3*nz) + gtz;

   w_ex000[tz] = ee[gci0003+EX*nz];
   w_ey000[tz] = ee[gci0003+EY*nz];
   w_ez000[tz] = ee[gci0003+EZ*nz];

   w_ex000[tz+65] = ee[gci0103+EX*nz];
   w_ey000[tz+65] = ee[gci0103+EY*nz];
   w_ez000[tz+65] = ee[gci0103+EZ*nz];

   w_ex100[tz] = ee[gci1003+EX*nz];
   w_ey100[tz] = ee[gci1003+EY*nz];
   w_ez100[tz] = ee[gci1003+EZ*nz];

   if (tz==0) {
      w_ex000[64] = w_ex000[0].yzwx;
      w_ex000[64+65] = w_ex000[0+65].yzwx;

      w_ey000[64] = w_ey000[0].yzwx;
      w_ey000[64+65] = w_ey000[0+65].yzwx;

   }

   barrier(CLK_LOCAL_MEM_FENCE);

   w_hx000[tz+195] += bz4*(w_ey000[tz+1] - w_ey000[tz]) + by4*(w_ez000[tz] - w_ez000[tz+65]);
   w_hy000[tz+195] += bx4*(w_ez100[tz] - w_ez000[tz]) + bz4*(w_ex000[tz] - w_ex000[tz+1]);
   w_hz000[tz+195] += by4*(w_ex000[tz+65] - w_ex000[tz]) + bx4*(w_ey000[tz] - w_ey100[tz]);


//   w_hx000[tz+195] *= maskb*maskc;
//   w_hy000[tz+195] *= maska*maskc;
//   w_hz000[tz+195] *= maska*maskb;
	}


//// write back results

	{
	int gci0003 = 3*(gtx*nyz + y*nz) + gtz;
	int gci0103 = 3*(gtx*nyz + y1*nz) + gtz;
	int gci0203 = 3*(gtx*nyz + y2*nz) + gtz;
	int gci0303 = 3*(gtx*nyz + y3*nz) + gtz;

	hh[gci0003+HX*nz] = w_hx000[tz];
	hh[gci0003+HY*nz] = w_hy000[tz];
	hh[gci0003+HZ*nz] = w_hz000[tz];

	hh[gci0103+HX*nz] = w_hx000[tz+65];
	hh[gci0103+HY*nz] = w_hy000[tz+65];
	hh[gci0103+HZ*nz] = w_hz000[tz+65];

	hh[gci0203+HX*nz] = w_hx000[tz+130];
	hh[gci0203+HY*nz] = w_hy000[tz+130];
	hh[gci0203+HZ*nz] = w_hz000[tz+130];

	hh[gci0303+HX*nz] = w_hx000[tz+195];
	hh[gci0303+HY*nz] = w_hy000[tz+195];
	hh[gci0303+HZ*nz] = w_hz000[tz+195];

	}

}




__kernel void
ecomp_kern(
	float4 src,
	int nx, int ny, int nz,
	float4 a,
	__global float4* hh,
	__global float4* ee
)
{
	float4 zero4 = (float4){0.0f,0.0f,0.0f,0.0f};
	float4 one4 = (float4){1.0f,1.0f,1.0f,1.0f};
	float4 mask_xyz0 = (float4){1.0f,1.0f,1.0f,0.0f};
	float4 mask_0yzw = (float4){0.0f,1.0f,1.0f,1.0f};
	float4 ax4 = (float4){a.x,a.x,a.x,a.x};
	float4 ay4 = (float4){a.y,a.y,a.y,a.y};
	float4 az4 = (float4){a.z,a.z,a.z,a.z};

	__local float4 w_ex111[260];
	__local float4 w_ey111[260];
	__local float4 w_ez111[260];

	__local float4 w_hx111[130];
	__local float4 w_hy111[130];
	__local float4 w_hz111[130];

	__local float4 w_hx011[65];
	__local float4 w_hy011[65];
	__local float4 w_hz011[65];

	int nyz = ny*nz;

	int mx = nx - 1;
	int my = ny - 1;
	int mz = nz - 1;

	int nx2 = nx/2;
	int ny2 = ny/2;


	// get global thread coordinate //

	int gtx = get_global_id(0);
	int gty = get_global_id(1);
	int gtz = get_global_id(2);

	int x1 = gtx;
	int y1 = 4*gty;
	int z1 = gtz;

	int x0 = (x1+nx-1)%nx;
	int y0 = (y1+ny-1)%ny;

	int y2 = y1 + 1;
	int y3 = y2 + 1;
	int y4 = y3 + 1;

	int tz = gtz;
	int tz1 = 1+tz;


	// copy data into local storage, threads in work-group work together //

	int gci1113 = 3*(x1*nyz + y1*nz) + z1;
	int gci1213 = 3*(x1*nyz + y2*nz) + z1;
	int gci1313 = 3*(x1*nyz + y3*nz) + z1;
	int gci1413 = 3*(x1*nyz + y4*nz) + z1;

	w_ex111[tz1] 		= ee[gci1113+EX*nz];
	w_ey111[tz1] 		= ee[gci1113+EY*nz];
	w_ez111[tz1] 		= ee[gci1113+EZ*nz];

	w_ex111[tz1+65] 	= ee[gci1213+EX*nz];
	w_ey111[tz1+65] 	= ee[gci1213+EY*nz];
	w_ez111[tz1+65] 	= ee[gci1213+EZ*nz];

	w_ex111[tz1+130] 	= ee[gci1313+EX*nz];
	w_ey111[tz1+130] 	= ee[gci1313+EY*nz];
	w_ez111[tz1+130] 	= ee[gci1313+EZ*nz];

	w_ex111[tz1+195] 	= ee[gci1413+EX*nz];
	w_ey111[tz1+195] 	= ee[gci1413+EY*nz];
	w_ez111[tz1+195] 	= ee[gci1413+EZ*nz];


	float t = src.x;
	float q = src.y*sin(t*src.z);
//	float q = src.y*t;
   float4 q4 = (float4){q,q,q,q};


//// load 0

	{
	int gci1013 = 3*(x1*nyz + y0*nz) + z1;
	int gci1113 = 3*(x1*nyz + y1*nz) + z1;
	int gci0113 = 3*(x0*nyz + y1*nz) + z1;

	w_hx111[tz1] = hh[gci1013+HX*nz];
	w_hy111[tz1] = hh[gci1013+HY*nz];
	w_hz111[tz1] = hh[gci1013+HZ*nz];

	w_hx111[tz1+65] = hh[gci1113+HX*nz];
	w_hy111[tz1+65] = hh[gci1113+HY*nz];
	w_hz111[tz1+65] = hh[gci1113+HZ*nz];

	w_hx011[tz1] = hh[gci0113+HX*nz];
	w_hy011[tz1] = hh[gci0113+HY*nz];
	w_hz011[tz1] = hh[gci0113+HZ*nz];

	if (tz==0) {
		w_hx111[0] = w_hx111[64].wxyz;
		w_hy111[0] = w_hy111[64].wxyz;
		w_hz111[0] = w_hz111[64].wxyz;

		w_hx111[0+65] = w_hx111[64+65].wxyz;
		w_hy111[0+65] = w_hy111[64+65].wxyz;
		w_hz111[0+65] = w_hz111[64+65].wxyz;

		w_hx011[0] = w_hx011[64].wxyz;
		w_hy011[0] = w_hy011[64].wxyz;
		w_hz011[0] = w_hz011[64].wxyz;

	}

	barrier(CLK_LOCAL_MEM_FENCE);

	w_ex111[tz1] += az4*(w_hy111[tz+65] - w_hy111[tz1+65]) + ay4*(w_hz111[tz1+65] - w_hz111[tz1]);
	w_ey111[tz1] += ax4*(w_hz011[tz1] - w_hz111[tz1+65]) + az4*(w_hx111[tz1+65] - w_hx111[tz+65]);
	w_ez111[tz1] += ay4*(w_hx111[tz1] - w_hx111[tz1+65]) + ax4*(w_hy111[tz1+65] - w_hy011[tz1]);

   float4 maska = (gtx==0)? zero4 : one4;
   maska = (gtx==mx)? zero4 : maska;

   float4 maskb = (gty==0)? zero4 : one4;

   float4 maskc = (gtz==0)? mask_0yzw : one4;
   maskc = (gtz==mz)? mask_xyz0 : maskc;

//   w_ex111[tz1] *= maskb*maskc;
//   w_ey111[tz1] *= maska*maskc;
//   w_ez111[tz1] *= maska*maskb;

	float4 tmp4 = w_ez111[tz1];
//	w_ez111[tz1] = ((gty==0 )? q4 : tmp4);
	w_ez111[tz1] = ((gty==16 && gtx==16)? q4 : tmp4);

	}

//// reload +1

	{
   int gci1013 = 3*(x1*nyz + y1*nz) + z1;
   int gci1113 = 3*(x1*nyz + y2*nz) + z1;
   int gci0113 = 3*(x0*nyz + y2*nz) + z1;

   w_hx111[tz1] = hh[gci1013+HX*nz];
   w_hy111[tz1] = hh[gci1013+HY*nz];
   w_hz111[tz1] = hh[gci1013+HZ*nz];

   w_hx111[tz1+65] = hh[gci1113+HX*nz];
   w_hy111[tz1+65] = hh[gci1113+HY*nz];
   w_hz111[tz1+65] = hh[gci1113+HZ*nz];

   w_hx011[tz1] = hh[gci0113+HX*nz];
   w_hy011[tz1] = hh[gci0113+HY*nz];
   w_hz011[tz1] = hh[gci0113+HZ*nz];

   if (tz==0) {
      w_hx111[0] = w_hx111[64].wxyz;
      w_hy111[0] = w_hy111[64].wxyz;
      w_hz111[0] = w_hz111[64].wxyz;

      w_hx111[0+65] = w_hx111[64+65].wxyz;
      w_hy111[0+65] = w_hy111[64+65].wxyz;
      w_hz111[0+65] = w_hz111[64+65].wxyz;

      w_hx011[0] = w_hx011[64].wxyz;
      w_hy011[0] = w_hy011[64].wxyz;
      w_hz011[0] = w_hz011[64].wxyz;

   }

   barrier(CLK_LOCAL_MEM_FENCE);

   w_ex111[tz1+65] += az4*(w_hy111[tz+65] - w_hy111[tz1+65]) + ay4*(w_hz111[tz1+65] - w_hz111[tz1]);
   w_ey111[tz1+65] += ax4*(w_hz011[tz1] - w_hz111[tz1+65]) + az4*(w_hx111[tz1+65] - w_hx111[tz+65]);
   w_ez111[tz1+65] += ay4*(w_hx111[tz1] - w_hx111[tz1+65]) + ax4*(w_hy111[tz1+65] - w_hy011[tz1]);


   float4 maska = (gtx==0)? zero4 : one4;
   maska = (gtx==mx)? zero4 : maska;

   float4 maskc = (gtz==0)? mask_0yzw : one4;
   maskc = (gtz==mz)? mask_xyz0 : maskc;

//   w_ex111[tz1+65] *= maskc;
//   w_ey111[tz1+65] *= maska*maskc;
//   w_ez111[tz1+65] *= maska;

//	float4 tmp4 = w_ez111[tz1+65];
//	w_ez111[tz1+65] = ((gtx==0 )? q4 : tmp4);

	}


//// reload +2

	{
   int gci1013 = 3*(x1*nyz + y2*nz) + z1;
   int gci1113 = 3*(x1*nyz + y3*nz) + z1;
   int gci0113 = 3*(x0*nyz + y3*nz) + z1;

   w_hx111[tz1] = hh[gci1013+HX*nz];
   w_hy111[tz1] = hh[gci1013+HY*nz];
   w_hz111[tz1] = hh[gci1013+HZ*nz];

   w_hx111[tz1+65] = hh[gci1113+HX*nz];
   w_hy111[tz1+65] = hh[gci1113+HY*nz];
   w_hz111[tz1+65] = hh[gci1113+HZ*nz];

   w_hx011[tz1] = hh[gci0113+HX*nz];
   w_hy011[tz1] = hh[gci0113+HY*nz];
   w_hz011[tz1] = hh[gci0113+HZ*nz];

   if (tz==0) {
      w_hx111[0] = w_hx111[64].wxyz;
      w_hy111[0] = w_hy111[64].wxyz;
      w_hz111[0] = w_hz111[64].wxyz;

      w_hx111[0+65] = w_hx111[64+65].wxyz;
      w_hy111[0+65] = w_hy111[64+65].wxyz;
      w_hz111[0+65] = w_hz111[64+65].wxyz;

      w_hx011[0] = w_hx011[64].wxyz;
      w_hy011[0] = w_hy011[64].wxyz;
      w_hz011[0] = w_hz011[64].wxyz;

   }

   barrier(CLK_LOCAL_MEM_FENCE);

   w_ex111[tz1+130] += az4*(w_hy111[tz+65] - w_hy111[tz1+65]) + ay4*(w_hz111[tz1+65] - w_hz111[tz1]);
   w_ey111[tz1+130] += ax4*(w_hz011[tz1] - w_hz111[tz1+65]) + az4*(w_hx111[tz1+65] - w_hx111[tz+65]);
   w_ez111[tz1+130] += ay4*(w_hx111[tz1] - w_hx111[tz1+65]) + ax4*(w_hy111[tz1+65] - w_hy011[tz1]);


   float4 maska = (gtx==0)? zero4 : one4;
   maska = (gtx==mx)? zero4 : maska;

   float4 maskc = (gtz==0)? mask_0yzw : one4;
   maskc = (gtz==mz)? mask_xyz0 : maskc;

//   w_ex111[tz1+130] *= maskc;
//   w_ey111[tz1+130] *= maska*maskc;
//   w_ez111[tz1+130] *= maska;

//	float4 tmp4 = w_ez111[tz1+130];
//	w_ez111[tz1+130] = ((gtx==0 )? q4 : tmp4);

	}

//// reload +3

	{
   int gci1013 = 3*(x1*nyz + y3*nz) + z1;
   int gci1113 = 3*(x1*nyz + y4*nz) + z1;
   int gci0113 = 3*(x0*nyz + y4*nz) + z1;

   w_hx111[tz1] = hh[gci1013+HX*nz];
   w_hy111[tz1] = hh[gci1013+HY*nz];
   w_hz111[tz1] = hh[gci1013+HZ*nz];

   w_hx111[tz1+65] = hh[gci1113+HX*nz];
   w_hy111[tz1+65] = hh[gci1113+HY*nz];
   w_hz111[tz1+65] = hh[gci1113+HZ*nz];

   w_hx011[tz1] = hh[gci0113+HX*nz];
   w_hy011[tz1] = hh[gci0113+HY*nz];
   w_hz011[tz1] = hh[gci0113+HZ*nz];

   if (tz==0) {
      w_hx111[0] = w_hx111[64].wxyz;
      w_hy111[0] = w_hy111[64].wxyz;
      w_hz111[0] = w_hz111[64].wxyz;

      w_hx111[0+65] = w_hx111[64+65].wxyz;
      w_hy111[0+65] = w_hy111[64+65].wxyz;
      w_hz111[0+65] = w_hz111[64+65].wxyz;

      w_hx011[0] = w_hx011[64].wxyz;
      w_hy011[0] = w_hy011[64].wxyz;
      w_hz011[0] = w_hz011[64].wxyz;

   }

   barrier(CLK_LOCAL_MEM_FENCE);

   w_ex111[tz1+195] += az4*(w_hy111[tz+65] - w_hy111[tz1+65]) + ay4*(w_hz111[tz1+65] - w_hz111[tz1]);
   w_ey111[tz1+195] += ax4*(w_hz011[tz1] - w_hz111[tz1+65]) + az4*(w_hx111[tz1+65] - w_hx111[tz+65]);
   w_ez111[tz1+195] += ay4*(w_hx111[tz1] - w_hx111[tz1+65]) + ax4*(w_hy111[tz1+65] - w_hy011[tz1]);


   float4 maska = (gtx==0)? zero4 : one4;
   maska = (gtx==mx)? zero4 : maska;

   float4 maskb = (gty==my)? zero4 : one4;

   float4 maskc = (gtz==0)? mask_0yzw : one4;
   maskc = (gtz==mz)? mask_xyz0 : maskc;

//   w_ex111[tz1+195] *= maskb*maskc;
//   w_ey111[tz1+195] *= maska*maskc;
//   w_ez111[tz1+195] *= maska*maskb;

//	float4 tmp4 = w_ez111[tz1+195];
//	w_ez111[tz1+195] = ((gtx==0 )? q4 : tmp4);

	}


//// write back results

	{

	int gci1113 = 3*(x1*nyz + y1*nz) + z1;
	int gci1213 = 3*(x1*nyz + y2*nz) + z1;
	int gci1313 = 3*(x1*nyz + y3*nz) + z1;
	int gci1413 = 3*(x1*nyz + y4*nz) + z1;

	ee[gci1113+EX*nz] = w_ex111[tz1];
	ee[gci1113+EY*nz] = w_ey111[tz1];
	ee[gci1113+EZ*nz] = w_ez111[tz1];

	ee[gci1213+EX*nz] = w_ex111[tz1+65];
	ee[gci1213+EY*nz] = w_ey111[tz1+65];
	ee[gci1213+EZ*nz] = w_ez111[tz1+65];

	ee[gci1313+EX*nz] = w_ex111[tz1+130];
	ee[gci1313+EY*nz] = w_ey111[tz1+130];
	ee[gci1313+EZ*nz] = w_ez111[tz1+130];

	ee[gci1413+EX*nz] = w_ex111[tz1+195];
	ee[gci1413+EY*nz] = w_ey111[tz1+195];
	ee[gci1413+EZ*nz] = w_ez111[tz1+195];

	}

}


__kernel void
slice_kern(
   int nx, int ny, int nz,
   int iz, int offset,
   __global float4* slice,
   __global float4* ee
)
{
   const float4 third4 = (float4)(0.3f,0.3f,0.3f,0.3f);
   int gtx = get_global_id(0);
   int gty = get_global_id(1);

   int gci3 = 3*(gtx*ny*nz + gty*nz) + 3;

   float4 tmpx = ee[gci3+EX*nz];
   float4 tmpy = ee[gci3+EY*nz];
   float4 tmpz = ee[gci3+EZ*nz];

	tmpx *= tmpx;
	tmpy *= tmpy;
	tmpz *= tmpz;
   float4 power = third4 * fabs(tmpx+tmpy+tmpz);

   slice[offset + gtx*ny + gty] = power;

   return;
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
