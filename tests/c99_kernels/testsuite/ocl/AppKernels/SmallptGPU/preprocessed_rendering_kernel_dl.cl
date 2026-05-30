# 1 "<stdin>"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "<stdin>"
# 26 "<stdin>"
# 1 "camera.h" 1
# 27 "camera.h"
# 1 "vec.h" 1
# 27 "vec.h"
typedef struct {
 float x, y, z;
} Vec;
# 28 "camera.h" 2

typedef struct {

 Vec orig, target;

 Vec dir, x, y;
} Camera;
# 27 "<stdin>" 2
# 1 "geomfunc.h" 1
# 27 "geomfunc.h"
# 1 "geom.h" 1
# 32 "geom.h"
typedef struct {
 Vec o, d;
} Ray;




enum Refl {
 DIFF, SPEC, REFR
};

typedef struct {
 float rad;
 Vec p, e, c;
 enum Refl refl;
} Sphere;
# 28 "geomfunc.h" 2
# 1 "simplernd.h" 1
# 34 "simplernd.h"
 float GetRandom(unsigned int *seed0, unsigned int *seed1) {
 *seed0 = 36969 * ((*seed0) & 65535) + ((*seed0) >> 16);
 *seed1 = 18000 * ((*seed1) & 65535) + ((*seed1) >> 16);

 unsigned int ires = ((*seed0) << 16) + (*seed1);


 union {
  float f;
  unsigned int ui;
 } res;
 res.ui = (ires & 0x007fffff) | 0x40000000;

 return (res.f - 2.f) / 2.f;
}
# 29 "geomfunc.h" 2



 float SphereIntersect(

__constant

 const Sphere *s,
 const Ray *r) {
 Vec op;
 { (op).x = (s->p).x - (r->o).x; (op).y = (s->p).y - (r->o).y; (op).z = (s->p).z - (r->o).z; };

 float b = ((op).x * (r->d).x + (op).y * (r->d).y + (op).z * (r->d).z);
 float det = b * b - ((op).x * (op).x + (op).y * (op).y + (op).z * (op).z) + s->rad * s->rad;
 if (det < 0.f)
  return 0.f;
 else
  det = sqrt(det);

 float t = b - det;
 if (t > 0.01f)
  return t;
 else {
  t = b + det;

  if (t > 0.01f)
   return t;
  else
   return 0.f;
 }
}

 void UniformSampleSphere(const float u1, const float u2, Vec *v) {
 const float zz = 1.f - 2.f * u1;
 const float r = sqrt(max(0.f, 1.f - zz * zz));
 const float phi = 2.f * 3.14159265358979323846f * u2;
 const float xx = r * cos(phi);
 const float yy = r * sin(phi);

 { (*v).x = xx; (*v).y = yy; (*v).z = zz; };
}

 int Intersect(

__constant

 const Sphere *spheres,
 const unsigned int sphereCount,
 const Ray *r,
 float *t,
 unsigned int *id) {
 float inf = (*t) = 1e20f;

 unsigned int i = sphereCount;
 i--; for(; i; i--) {
  const float d = SphereIntersect(&spheres[i], r);
  if ((d != 0.f) && (d < *t)) {
   *t = d;
   *id = i;
  }
 }

 return (*t < inf);
}

 int IntersectP(

__constant

 const Sphere *spheres,
 const unsigned int sphereCount,
 const Ray *r,
 const float maxt) {
 unsigned int i = sphereCount;
 i--; for(; i; i--) {
  const float d = SphereIntersect(&spheres[i], r);
  if ((d != 0.f) && (d < maxt))
   return 1;
 }

 return 0;
}

 void SampleLights(

__constant

 const Sphere *spheres,
 const unsigned int sphereCount,
 unsigned int *seed0, unsigned int *seed1,
 const Vec *hitPoint,
 const Vec *normal,
 Vec *result) {
 { (*result).x = 0.f; (*result).y = 0.f; (*result).z = 0.f; };


 unsigned int i;
 for (i = 0; i < sphereCount; i++) {

__constant

  const Sphere *light = &spheres[i];
  if (!(((light->e).x == 0.f) && ((light->e).x == 0.f) && ((light->e).z == 0.f))) {

   Ray shadowRay;
   shadowRay.o = *hitPoint;


   Vec unitSpherePoint;
   UniformSampleSphere(GetRandom(seed0, seed1), GetRandom(seed0, seed1), &unitSpherePoint);
   Vec spherePoint;
   { float k = (light->rad); { (spherePoint).x = k * (unitSpherePoint).x; (spherePoint).y = k * (unitSpherePoint).y; (spherePoint).z = k * (unitSpherePoint).z; } };
   { (spherePoint).x = (spherePoint).x + (light->p).x; (spherePoint).y = (spherePoint).y + (light->p).y; (spherePoint).z = (spherePoint).z + (light->p).z; };


   { (shadowRay.d).x = (spherePoint).x - (*hitPoint).x; (shadowRay.d).y = (spherePoint).y - (*hitPoint).y; (shadowRay.d).z = (spherePoint).z - (*hitPoint).z; };
   const float len = sqrt(((shadowRay.d).x * (shadowRay.d).x + (shadowRay.d).y * (shadowRay.d).y + (shadowRay.d).z * (shadowRay.d).z));
   { float k = (1.f / len); { (shadowRay.d).x = k * (shadowRay.d).x; (shadowRay.d).y = k * (shadowRay.d).y; (shadowRay.d).z = k * (shadowRay.d).z; } };

   float wo = ((shadowRay.d).x * (unitSpherePoint).x + (shadowRay.d).y * (unitSpherePoint).y + (shadowRay.d).z * (unitSpherePoint).z);
   if (wo > 0.f) {

    continue;
   } else
    wo = -wo;


   const float wi = ((shadowRay.d).x * (*normal).x + (shadowRay.d).y * (*normal).y + (shadowRay.d).z * (*normal).z);
   if ((wi > 0.f) && (!IntersectP(spheres, sphereCount, &shadowRay, len - 0.01f))) {
    Vec c; { (c).x = (light->e).x; (c).y = (light->e).y; (c).z = (light->e).z; };
    const float s = (4.f * 3.14159265358979323846f * light->rad * light->rad) * wi * wo / (len *len);
    { float k = (s); { (c).x = k * (c).x; (c).y = k * (c).y; (c).z = k * (c).z; } };
    { (*result).x = (*result).x + (c).x; (*result).y = (*result).y + (c).y; (*result).z = (*result).z + (c).z; };
   }
  }
 }
}

 void RadiancePathTracing(

__constant

 const Sphere *spheres,
 const unsigned int sphereCount,
 const Ray *startRay,
 unsigned int *seed0, unsigned int *seed1,
 Vec *result) {
 Ray currentRay; { { ((currentRay).o).x = ((*startRay).o).x; ((currentRay).o).y = ((*startRay).o).y; ((currentRay).o).z = ((*startRay).o).z; }; { ((currentRay).d).x = ((*startRay).d).x; ((currentRay).d).y = ((*startRay).d).y; ((currentRay).d).z = ((*startRay).d).z; }; };
 Vec rad; { (rad).x = 0.f; (rad).y = 0.f; (rad).z = 0.f; };
 Vec throughput; { (throughput).x = 1.f; (throughput).y = 1.f; (throughput).z = 1.f; };

 unsigned int depth = 0;
 int specularBounce = 1;
 for (;; ++depth) {

  if (depth > 6) {
   *result = rad;
   return;
  }

  float t;
  unsigned int id = 0;
  if (!Intersect(spheres, sphereCount, &currentRay, &t, &id)) {
   *result = rad;
   return;
  }


__constant

  const Sphere *obj = &spheres[id];

  Vec hitPoint;
  { float k = (t); { (hitPoint).x = k * (currentRay.d).x; (hitPoint).y = k * (currentRay.d).y; (hitPoint).z = k * (currentRay.d).z; } };
  { (hitPoint).x = (currentRay.o).x + (hitPoint).x; (hitPoint).y = (currentRay.o).y + (hitPoint).y; (hitPoint).z = (currentRay.o).z + (hitPoint).z; };

  Vec normal;
  { (normal).x = (hitPoint).x - (obj->p).x; (normal).y = (hitPoint).y - (obj->p).y; (normal).z = (hitPoint).z - (obj->p).z; };
  { float l = 1.f / sqrt(((normal).x * (normal).x + (normal).y * (normal).y + (normal).z * (normal).z)); { float k = (l); { (normal).x = k * (normal).x; (normal).y = k * (normal).y; (normal).z = k * (normal).z; } }; };

  const float dp = ((normal).x * (currentRay.d).x + (normal).y * (currentRay.d).y + (normal).z * (currentRay.d).z);

  Vec nl;

  const float invSignDP = -1.f * sign(dp);
  { float k = (invSignDP); { (nl).x = k * (normal).x; (nl).y = k * (normal).y; (nl).z = k * (normal).z; } };


  Vec eCol; { (eCol).x = (obj->e).x; (eCol).y = (obj->e).y; (eCol).z = (obj->e).z; };
  if (!(((eCol).x == 0.f) && ((eCol).x == 0.f) && ((eCol).z == 0.f))) {
   if (specularBounce) {
    { float k = (fabs(dp)); { (eCol).x = k * (eCol).x; (eCol).y = k * (eCol).y; (eCol).z = k * (eCol).z; } };
    { (eCol).x = (throughput).x * (eCol).x; (eCol).y = (throughput).y * (eCol).y; (eCol).z = (throughput).z * (eCol).z; };
    { (rad).x = (rad).x + (eCol).x; (rad).y = (rad).y + (eCol).y; (rad).z = (rad).z + (eCol).z; };
   }

   *result = rad;
   return;
  }

  if (obj->refl == DIFF) {
   specularBounce = 0;
   { (throughput).x = (throughput).x * (obj->c).x; (throughput).y = (throughput).y * (obj->c).y; (throughput).z = (throughput).z * (obj->c).z; };



   Vec Ld;
   SampleLights(spheres, sphereCount, seed0, seed1, &hitPoint, &nl, &Ld);
   { (Ld).x = (throughput).x * (Ld).x; (Ld).y = (throughput).y * (Ld).y; (Ld).z = (throughput).z * (Ld).z; };
   { (rad).x = (rad).x + (Ld).x; (rad).y = (rad).y + (Ld).y; (rad).z = (rad).z + (Ld).z; };



   float r1 = 2.f * 3.14159265358979323846f * GetRandom(seed0, seed1);
   float r2 = GetRandom(seed0, seed1);
   float r2s = sqrt(r2);

   Vec w; { (w).x = (nl).x; (w).y = (nl).y; (w).z = (nl).z; };

   Vec u, a;
   if (fabs(w.x) > .1f) {
    { (a).x = 0.f; (a).y = 1.f; (a).z = 0.f; };
   } else {
    { (a).x = 1.f; (a).y = 0.f; (a).z = 0.f; };
   }
   { (u).x = (a).y * (w).z - (a).z * (w).y; (u).y = (a).z * (w).x - (a).x * (w).z; (u).z = (a).x * (w).y - (a).y * (w).x; };
   { float l = 1.f / sqrt(((u).x * (u).x + (u).y * (u).y + (u).z * (u).z)); { float k = (l); { (u).x = k * (u).x; (u).y = k * (u).y; (u).z = k * (u).z; } }; };

   Vec v;
   { (v).x = (w).y * (u).z - (w).z * (u).y; (v).y = (w).z * (u).x - (w).x * (u).z; (v).z = (w).x * (u).y - (w).y * (u).x; };

   Vec newDir;
   { float k = (cos(r1) * r2s); { (u).x = k * (u).x; (u).y = k * (u).y; (u).z = k * (u).z; } };
   { float k = (sin(r1) * r2s); { (v).x = k * (v).x; (v).y = k * (v).y; (v).z = k * (v).z; } };
   { (newDir).x = (u).x + (v).x; (newDir).y = (u).y + (v).y; (newDir).z = (u).z + (v).z; };
   { float k = (sqrt(1 - r2)); { (w).x = k * (w).x; (w).y = k * (w).y; (w).z = k * (w).z; } };
   { (newDir).x = (newDir).x + (w).x; (newDir).y = (newDir).y + (w).y; (newDir).z = (newDir).z + (w).z; };

   currentRay.o = hitPoint;
   currentRay.d = newDir;
   continue;
  } else if (obj->refl == SPEC) {
   specularBounce = 1;

   Vec newDir;
   { float k = (2.f * ((normal).x * (currentRay.d).x + (normal).y * (currentRay.d).y + (normal).z * (currentRay.d).z)); { (newDir).x = k * (normal).x; (newDir).y = k * (normal).y; (newDir).z = k * (normal).z; } };
   { (newDir).x = (currentRay.d).x - (newDir).x; (newDir).y = (currentRay.d).y - (newDir).y; (newDir).z = (currentRay.d).z - (newDir).z; };

   { (throughput).x = (throughput).x * (obj->c).x; (throughput).y = (throughput).y * (obj->c).y; (throughput).z = (throughput).z * (obj->c).z; };

   { { ((currentRay).o).x = (hitPoint).x; ((currentRay).o).y = (hitPoint).y; ((currentRay).o).z = (hitPoint).z; }; { ((currentRay).d).x = (newDir).x; ((currentRay).d).y = (newDir).y; ((currentRay).d).z = (newDir).z; }; };
   continue;
  } else {
   specularBounce = 1;

   Vec newDir;
   { float k = (2.f * ((normal).x * (currentRay.d).x + (normal).y * (currentRay.d).y + (normal).z * (currentRay.d).z)); { (newDir).x = k * (normal).x; (newDir).y = k * (normal).y; (newDir).z = k * (normal).z; } };
   { (newDir).x = (currentRay.d).x - (newDir).x; (newDir).y = (currentRay.d).y - (newDir).y; (newDir).z = (currentRay.d).z - (newDir).z; };

   Ray reflRay; { { ((reflRay).o).x = (hitPoint).x; ((reflRay).o).y = (hitPoint).y; ((reflRay).o).z = (hitPoint).z; }; { ((reflRay).d).x = (newDir).x; ((reflRay).d).y = (newDir).y; ((reflRay).d).z = (newDir).z; }; };
   int into = (((normal).x * (nl).x + (normal).y * (nl).y + (normal).z * (nl).z) > 0);

   float nc = 1.f;
   float nt = 1.5f;
   float nnt = into ? nc / nt : nt / nc;
   float ddn = ((currentRay.d).x * (nl).x + (currentRay.d).y * (nl).y + (currentRay.d).z * (nl).z);
   float cos2t = 1.f - nnt * nnt * (1.f - ddn * ddn);

   if (cos2t < 0.f) {
    { (throughput).x = (throughput).x * (obj->c).x; (throughput).y = (throughput).y * (obj->c).y; (throughput).z = (throughput).z * (obj->c).z; };

    { { ((currentRay).o).x = ((reflRay).o).x; ((currentRay).o).y = ((reflRay).o).y; ((currentRay).o).z = ((reflRay).o).z; }; { ((currentRay).d).x = ((reflRay).d).x; ((currentRay).d).y = ((reflRay).d).y; ((currentRay).d).z = ((reflRay).d).z; }; };
    continue;
   }

   float kk = (into ? 1 : -1) * (ddn * nnt + sqrt(cos2t));
   Vec nkk;
   { float k = (kk); { (nkk).x = k * (normal).x; (nkk).y = k * (normal).y; (nkk).z = k * (normal).z; } };
   Vec transDir;
   { float k = (nnt); { (transDir).x = k * (currentRay.d).x; (transDir).y = k * (currentRay.d).y; (transDir).z = k * (currentRay.d).z; } };
   { (transDir).x = (transDir).x - (nkk).x; (transDir).y = (transDir).y - (nkk).y; (transDir).z = (transDir).z - (nkk).z; };
   { float l = 1.f / sqrt(((transDir).x * (transDir).x + (transDir).y * (transDir).y + (transDir).z * (transDir).z)); { float k = (l); { (transDir).x = k * (transDir).x; (transDir).y = k * (transDir).y; (transDir).z = k * (transDir).z; } }; };

   float a = nt - nc;
   float b = nt + nc;
   float R0 = a * a / (b * b);
   float c = 1 - (into ? -ddn : ((transDir).x * (normal).x + (transDir).y * (normal).y + (transDir).z * (normal).z));

   float Re = R0 + (1 - R0) * c * c * c * c*c;
   float Tr = 1.f - Re;
   float P = .25f + .5f * Re;
   float RP = Re / P;
   float TP = Tr / (1.f - P);

   if (GetRandom(seed0, seed1) < P) {
    { float k = (RP); { (throughput).x = k * (throughput).x; (throughput).y = k * (throughput).y; (throughput).z = k * (throughput).z; } };
    { (throughput).x = (throughput).x * (obj->c).x; (throughput).y = (throughput).y * (obj->c).y; (throughput).z = (throughput).z * (obj->c).z; };

    { { ((currentRay).o).x = ((reflRay).o).x; ((currentRay).o).y = ((reflRay).o).y; ((currentRay).o).z = ((reflRay).o).z; }; { ((currentRay).d).x = ((reflRay).d).x; ((currentRay).d).y = ((reflRay).d).y; ((currentRay).d).z = ((reflRay).d).z; }; };
    continue;
   } else {
    { float k = (TP); { (throughput).x = k * (throughput).x; (throughput).y = k * (throughput).y; (throughput).z = k * (throughput).z; } };
    { (throughput).x = (throughput).x * (obj->c).x; (throughput).y = (throughput).y * (obj->c).y; (throughput).z = (throughput).z * (obj->c).z; };

    { { ((currentRay).o).x = (hitPoint).x; ((currentRay).o).y = (hitPoint).y; ((currentRay).o).z = (hitPoint).z; }; { ((currentRay).d).x = (transDir).x; ((currentRay).d).y = (transDir).y; ((currentRay).d).z = (transDir).z; }; };
    continue;
   }
  }
 }
}

 void RadianceDirectLighting(

__constant

 const Sphere *spheres,
 const unsigned int sphereCount,
 const Ray *startRay,
 unsigned int *seed0, unsigned int *seed1,
 Vec *result) {
 Ray currentRay; { { ((currentRay).o).x = ((*startRay).o).x; ((currentRay).o).y = ((*startRay).o).y; ((currentRay).o).z = ((*startRay).o).z; }; { ((currentRay).d).x = ((*startRay).d).x; ((currentRay).d).y = ((*startRay).d).y; ((currentRay).d).z = ((*startRay).d).z; }; };
 Vec rad; { (rad).x = 0.f; (rad).y = 0.f; (rad).z = 0.f; };
 Vec throughput; { (throughput).x = 1.f; (throughput).y = 1.f; (throughput).z = 1.f; };

 unsigned int depth = 0;
 int specularBounce = 1;
 for (;; ++depth) {

  if (depth > 6) {
   *result = rad;
   return;
  }

  float t;
  unsigned int id = 0;
  if (!Intersect(spheres, sphereCount, &currentRay, &t, &id)) {
   *result = rad;
   return;
  }


__constant

  const Sphere *obj = &spheres[id];

  Vec hitPoint;
  { float k = (t); { (hitPoint).x = k * (currentRay.d).x; (hitPoint).y = k * (currentRay.d).y; (hitPoint).z = k * (currentRay.d).z; } };
  { (hitPoint).x = (currentRay.o).x + (hitPoint).x; (hitPoint).y = (currentRay.o).y + (hitPoint).y; (hitPoint).z = (currentRay.o).z + (hitPoint).z; };

  Vec normal;
  { (normal).x = (hitPoint).x - (obj->p).x; (normal).y = (hitPoint).y - (obj->p).y; (normal).z = (hitPoint).z - (obj->p).z; };
  { float l = 1.f / sqrt(((normal).x * (normal).x + (normal).y * (normal).y + (normal).z * (normal).z)); { float k = (l); { (normal).x = k * (normal).x; (normal).y = k * (normal).y; (normal).z = k * (normal).z; } }; };

  const float dp = ((normal).x * (currentRay.d).x + (normal).y * (currentRay.d).y + (normal).z * (currentRay.d).z);

  Vec nl;

  const float invSignDP = -1.f * sign(dp);
  { float k = (invSignDP); { (nl).x = k * (normal).x; (nl).y = k * (normal).y; (nl).z = k * (normal).z; } };


  Vec eCol; { (eCol).x = (obj->e).x; (eCol).y = (obj->e).y; (eCol).z = (obj->e).z; };
  if (!(((eCol).x == 0.f) && ((eCol).x == 0.f) && ((eCol).z == 0.f))) {
   if (specularBounce) {
    { float k = (fabs(dp)); { (eCol).x = k * (eCol).x; (eCol).y = k * (eCol).y; (eCol).z = k * (eCol).z; } };
    { (eCol).x = (throughput).x * (eCol).x; (eCol).y = (throughput).y * (eCol).y; (eCol).z = (throughput).z * (eCol).z; };
    { (rad).x = (rad).x + (eCol).x; (rad).y = (rad).y + (eCol).y; (rad).z = (rad).z + (eCol).z; };
   }

   *result = rad;
   return;
  }

  if (obj->refl == DIFF) {
   specularBounce = 0;
   { (throughput).x = (throughput).x * (obj->c).x; (throughput).y = (throughput).y * (obj->c).y; (throughput).z = (throughput).z * (obj->c).z; };



   Vec Ld;
   SampleLights(spheres, sphereCount, seed0, seed1, &hitPoint, &nl, &Ld);
   { (Ld).x = (throughput).x * (Ld).x; (Ld).y = (throughput).y * (Ld).y; (Ld).z = (throughput).z * (Ld).z; };
   { (rad).x = (rad).x + (Ld).x; (rad).y = (rad).y + (Ld).y; (rad).z = (rad).z + (Ld).z; };

   *result = rad;
   return;
  } else if (obj->refl == SPEC) {
   specularBounce = 1;

   Vec newDir;
   { float k = (2.f * ((normal).x * (currentRay.d).x + (normal).y * (currentRay.d).y + (normal).z * (currentRay.d).z)); { (newDir).x = k * (normal).x; (newDir).y = k * (normal).y; (newDir).z = k * (normal).z; } };
   { (newDir).x = (currentRay.d).x - (newDir).x; (newDir).y = (currentRay.d).y - (newDir).y; (newDir).z = (currentRay.d).z - (newDir).z; };

   { (throughput).x = (throughput).x * (obj->c).x; (throughput).y = (throughput).y * (obj->c).y; (throughput).z = (throughput).z * (obj->c).z; };

   { { ((currentRay).o).x = (hitPoint).x; ((currentRay).o).y = (hitPoint).y; ((currentRay).o).z = (hitPoint).z; }; { ((currentRay).d).x = (newDir).x; ((currentRay).d).y = (newDir).y; ((currentRay).d).z = (newDir).z; }; };
   continue;
  } else {
   specularBounce = 1;

   Vec newDir;
   { float k = (2.f * ((normal).x * (currentRay.d).x + (normal).y * (currentRay.d).y + (normal).z * (currentRay.d).z)); { (newDir).x = k * (normal).x; (newDir).y = k * (normal).y; (newDir).z = k * (normal).z; } };
   { (newDir).x = (currentRay.d).x - (newDir).x; (newDir).y = (currentRay.d).y - (newDir).y; (newDir).z = (currentRay.d).z - (newDir).z; };

   Ray reflRay; { { ((reflRay).o).x = (hitPoint).x; ((reflRay).o).y = (hitPoint).y; ((reflRay).o).z = (hitPoint).z; }; { ((reflRay).d).x = (newDir).x; ((reflRay).d).y = (newDir).y; ((reflRay).d).z = (newDir).z; }; };
   int into = (((normal).x * (nl).x + (normal).y * (nl).y + (normal).z * (nl).z) > 0);

   float nc = 1.f;
   float nt = 1.5f;
   float nnt = into ? nc / nt : nt / nc;
   float ddn = ((currentRay.d).x * (nl).x + (currentRay.d).y * (nl).y + (currentRay.d).z * (nl).z);
   float cos2t = 1.f - nnt * nnt * (1.f - ddn * ddn);

   if (cos2t < 0.f) {
    { (throughput).x = (throughput).x * (obj->c).x; (throughput).y = (throughput).y * (obj->c).y; (throughput).z = (throughput).z * (obj->c).z; };

    { { ((currentRay).o).x = ((reflRay).o).x; ((currentRay).o).y = ((reflRay).o).y; ((currentRay).o).z = ((reflRay).o).z; }; { ((currentRay).d).x = ((reflRay).d).x; ((currentRay).d).y = ((reflRay).d).y; ((currentRay).d).z = ((reflRay).d).z; }; };
    continue;
   }

   float kk = (into ? 1 : -1) * (ddn * nnt + sqrt(cos2t));
   Vec nkk;
   { float k = (kk); { (nkk).x = k * (normal).x; (nkk).y = k * (normal).y; (nkk).z = k * (normal).z; } };
   Vec transDir;
   { float k = (nnt); { (transDir).x = k * (currentRay.d).x; (transDir).y = k * (currentRay.d).y; (transDir).z = k * (currentRay.d).z; } };
   { (transDir).x = (transDir).x - (nkk).x; (transDir).y = (transDir).y - (nkk).y; (transDir).z = (transDir).z - (nkk).z; };
   { float l = 1.f / sqrt(((transDir).x * (transDir).x + (transDir).y * (transDir).y + (transDir).z * (transDir).z)); { float k = (l); { (transDir).x = k * (transDir).x; (transDir).y = k * (transDir).y; (transDir).z = k * (transDir).z; } }; };

   float a = nt - nc;
   float b = nt + nc;
   float R0 = a * a / (b * b);
   float c = 1 - (into ? -ddn : ((transDir).x * (normal).x + (transDir).y * (normal).y + (transDir).z * (normal).z));

   float Re = R0 + (1 - R0) * c * c * c * c*c;
   float Tr = 1.f - Re;
   float P = .25f + .5f * Re;
   float RP = Re / P;
   float TP = Tr / (1.f - P);

   if (GetRandom(seed0, seed1) < P) {
    { float k = (RP); { (throughput).x = k * (throughput).x; (throughput).y = k * (throughput).y; (throughput).z = k * (throughput).z; } };
    { (throughput).x = (throughput).x * (obj->c).x; (throughput).y = (throughput).y * (obj->c).y; (throughput).z = (throughput).z * (obj->c).z; };

    { { ((currentRay).o).x = ((reflRay).o).x; ((currentRay).o).y = ((reflRay).o).y; ((currentRay).o).z = ((reflRay).o).z; }; { ((currentRay).d).x = ((reflRay).d).x; ((currentRay).d).y = ((reflRay).d).y; ((currentRay).d).z = ((reflRay).d).z; }; };
    continue;
   } else {
    { float k = (TP); { (throughput).x = k * (throughput).x; (throughput).y = k * (throughput).y; (throughput).z = k * (throughput).z; } };
    { (throughput).x = (throughput).x * (obj->c).x; (throughput).y = (throughput).y * (obj->c).y; (throughput).z = (throughput).z * (obj->c).z; };

    { { ((currentRay).o).x = (hitPoint).x; ((currentRay).o).y = (hitPoint).y; ((currentRay).o).z = (hitPoint).z; }; { ((currentRay).d).x = (transDir).x; ((currentRay).d).y = (transDir).y; ((currentRay).d).z = (transDir).z; }; };
    continue;
   }
  }
 }
}
# 28 "<stdin>" 2

 void GenerateCameraRay(__constant Camera *camera,
  unsigned int *seed0, unsigned int *seed1,
  const int width, const int height, const int x, const int y, Ray *ray) {
 const float invWidth = 1.f / width;
 const float invHeight = 1.f / height;
 const float r1 = GetRandom(seed0, seed1) - .5f;
 const float r2 = GetRandom(seed0, seed1) - .5f;
 const float kcx = (x + r1) * invWidth - .5f;
 const float kcy = (y + r2) * invHeight - .5f;

 Vec rdir;
 { (rdir).x = camera->x.x * kcx + camera->y.x * kcy + camera->dir.x; (rdir).y = camera->x.y * kcx + camera->y.y * kcy + camera->dir.y; (rdir).z = camera->x.z * kcx + camera->y.z * kcy + camera->dir.z; };




 Vec rorig;
 { float k = (0.1f); { (rorig).x = k * (rdir).x; (rorig).y = k * (rdir).y; (rorig).z = k * (rdir).z; } };
 { (rorig).x = (rorig).x + (camera->orig).x; (rorig).y = (rorig).y + (camera->orig).y; (rorig).z = (rorig).z + (camera->orig).z; }

 { float l = 1.f / sqrt(((rdir).x * (rdir).x + (rdir).y * (rdir).y + (rdir).z * (rdir).z)); { float k = (l); { (rdir).x = k * (rdir).x; (rdir).y = k * (rdir).y; (rdir).z = k * (rdir).z; } }; };
 { { ((*ray).o).x = (rorig).x; ((*ray).o).y = (rorig).y; ((*ray).o).z = (rorig).z; }; { ((*ray).d).x = (rdir).x; ((*ray).d).y = (rdir).y; ((*ray).d).z = (rdir).z; }; };
}

__kernel void RadianceGPU(
    __global Vec *colors, __global unsigned int *seedsInput,
 __constant Sphere *sphere, __constant Camera *camera,
 const unsigned int sphereCount,
 const int width, const int height,
 const int currentSample,
 __global int *pixels) {
    const int gid = get_global_id(0);
 const int gid2 = 2 * gid;
 const int x = gid % width;
 const int y = gid / width;


 if (y >= height)
  return;


 unsigned int seed0 = seedsInput[gid2];
 unsigned int seed1 = seedsInput[gid2 + 1];

 Ray ray;
 GenerateCameraRay(camera, &seed0, &seed1, width, height, x, y, &ray);

 Vec r;
 RadianceDirectLighting(sphere, sphereCount, &ray, &seed0, &seed1, &r);

 const int i = (height - y - 1) * width + x;
 if (currentSample == 0) {

  { (colors[i]).x = (r).x; (colors[i]).y = (r).y; (colors[i]).z = (r).z; };
 } else {
  const float k1 = currentSample;
  const float k2 = 1.f / (currentSample + 1.f);
  colors[i].x = (colors[i].x * k1 + r.x) * k2;
  colors[i].y = (colors[i].y * k1 + r.y) * k2;
  colors[i].z = (colors[i].z * k1 + r.z) * k2;
 }

 pixels[y * width + x] = ((int)(pow(clamp(colors[i].x, 0.f, 1.f), 1.f / 2.2f) * 255.f + .5f)) |
   (((int)(pow(clamp(colors[i].y, 0.f, 1.f), 1.f / 2.2f) * 255.f + .5f)) << 8) |
   (((int)(pow(clamp(colors[i].z, 0.f, 1.f), 1.f / 2.2f) * 255.f + .5f)) << 16);

 seedsInput[gid2] = seed0;
 seedsInput[gid2 + 1] = seed1;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
