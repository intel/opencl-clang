#ifndef __AFFINE_ARITHMETIC_H__
#define __AFFINE_ARITHMETIC_H__

typedef float2 interval;
typedef float4 raf;

interval iadd(interval a, interval b) {
	interval i;
	i.x = a.x + b.x;
	i.y = a.y + b.y;
	return i;
}

interval iadd_scalar(interval a, float b) {
	interval i;
	i.x = a.x + b;
	i.y = a.y + b;
	return i;
}

interval imul(interval a, interval b) {
	float x = a.x*b.x, y = a.x*b.y, z = a.y*b.x, w = a.y*b.y;
	interval i;
	i.x = min(min(x,y),min(z,w));
	i.y = max(max(x,y),max(z,w));
	return i;
}

interval imul_scalar(interval a, float b) {
	interval i;
	i.x = min(a.x*b, a.y*b);
	i.y = max(a.x*b, a.y*b);
	return i;
}


raf interval_to_raf(interval i) {
	raf r;
	r.x = (i.y + i.x);
	r.y = (i.y - i.x);
	r.z = 0.0f;
	r.x *= 0.5f;
	r.y *= 0.5f;
	return r;
}

float raf_radius(raf a) {
	return fabs(a.y) + a.z;
}

interval raf_to_interval(raf a) {
	const float rad = raf_radius(a);
	interval i;
	i.x = a.x - rad;
	i.y = a.x + rad;
	return i;
}

int raf_contains(raf a, float b) {
	return (fabs(b - a.x) < raf_radius(a));
}

int raf_contains_negative(raf a) {
	return raf_contains(a, 0.0f) || (a.x < 0.0f);
}

raf raf_add(raf a, raf b) {
	raf r;
	r.x = a.x + b.x;
	r.y = a.y + b.y;
	r.z = a.z + b.z;
	return r;
}

raf raf_add_scalar(raf a, float b) {
	raf r;
	r.x = a.x + b;
	r.y = a.y;
	r.z = fabs(a.z); // abs necessary?
	return r;
}

raf raf_mul(raf a, raf b) {
	raf r;
	r.x = a.x * b.x;
	r.y = a.x * b.y + b.x * a.y;
	r.z = fabs(a.x*b.z) + fabs(b.x*a.z) + raf_radius(a)*raf_radius(b);
	return r;
}

raf raf_mul_scalar(raf a, float b) {
	raf r;
	r.x = b * a.x;
	r.y = b * a.y;
	r.z = fabs(b * a.z); // abs necessary?
	return r;
}

// Eventually user-supplied or Mathematica generated!
interval evaluate_interval(interval ix, interval iy, interval iz) {
	interval res;
	interval a, b, c;
	a = imul(ix, ix);
	a = imul(a, a);
	b = imul(iy, iy);
	b = imul(b, b);
	c = imul(iz, iz);
	c = imul(c, c);
	res = iadd(iadd(a, b), iadd_scalar(c, 1.0f));
	return res;
}

int interval_contains(interval i, float p) {
	return (i.x < p && p < i.y);
}

int interval_contains_negative(interval i) {
	return interval_contains(i, 0.0f) || (i.x < 0.0f);
}

#endif