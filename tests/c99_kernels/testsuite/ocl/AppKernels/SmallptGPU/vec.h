/*

Copyright (c) 2009 David Bucciarelli (davibu@interfree.it)



Permission is hereby granted, free of charge, to any person obtaining

a copy of this software and associated documentation files (the

"Software"), to deal in the Software without restriction, including

without limitation the rights to use, copy, modify, merge, publish,

distribute, sublicense, and/or sell copies of the Software, and to

permit persons to whom the Software is furnished to do so, subject to

the following conditions:



The above copyright notice and this permission notice shall be included

in all copies or substantial portions of the Software.



THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,

EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF

MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY

CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,

TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE

SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/



#ifndef _VEC_H

#define	_VEC_H



typedef struct {

	float x, y, z; // position, also color (r,g,b)

} Vec;



#define vinit(v, a, b, c) { (v).x = a; (v).y = b; (v).z = c; }

#define vassign(a, b) vinit(a, (b).x, (b).y, (b).z)

#define vclr(v) vinit(v, 0.f, 0.f, 0.f)

#define vadd(v, a, b) vinit(v, (a).x + (b).x, (a).y + (b).y, (a).z + (b).z)

#define vsub(v, a, b) vinit(v, (a).x - (b).x, (a).y - (b).y, (a).z - (b).z)

#define vsadd(v, a, b) { float k = (a); vinit(v, (b).x + k, (b).y + k, (b).z + k) }

#define vssub(v, a, b) { float k = (a); vinit(v, (b).x - k, (b).y - k, (b).z - k) }

#define vmul(v, a, b) vinit(v, (a).x * (b).x, (a).y * (b).y, (a).z * (b).z)

#define vsmul(v, a, b) { float k = (a); vinit(v, k * (b).x, k * (b).y, k * (b).z) }

#define vdot(a, b) ((a).x * (b).x + (a).y * (b).y + (a).z * (b).z)

#define vnorm(v) { float l = 1.f / sqrt(vdot(v, v)); vsmul(v, l, v); }

#define vxcross(v, a, b) vinit(v, (a).y * (b).z - (a).z * (b).y, (a).z * (b).x - (a).x * (b).z, (a).x * (b).y - (a).y * (b).x)

#define vfilter(v) ((v).x > (v).y && (v).x > (v).z ? (v).x : (v).y > (v).z ? (v).y : (v).z)

#define viszero(v) (((v).x == 0.f) && ((v).x == 0.f) && ((v).z == 0.f))



#ifndef GPU_KERNEL

#define clamp(x, a, b) ((x) < (a) ? (a) : ((x) > (b) ? (b) : (x)))

#define max(x, y) ( (x) > (y) ? (x) : (y))

#define min(x, y) ( (x) < (y) ? (x) : (y))

#define sign(x) ((x) > 0 ? 1 : -1)

#endif



#define toInt(x) ((int)(pow(clamp(x, 0.f, 1.f), 1.f / 2.2f) * 255.f + .5f))



// Rendering flags

#define RFLAGS_DISABLE_DIFFUSE_PATH 1



// NOTE: workaround for an Apple OpenCL compiler bug

#ifdef __APPLE__

#define OCL_CONSTANT_BUFFER __global

#else

#define OCL_CONSTANT_BUFFER __constant

#endif



#endif	/* _VEC_H */