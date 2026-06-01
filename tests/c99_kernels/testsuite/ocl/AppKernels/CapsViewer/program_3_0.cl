#define    C_a 1.3870398453221474618216191915664f  //a = sqrt(2) * cos(1 * pi / 16)
#define    C_b 1.3065629648763765278566431734272f  //b = sqrt(2) * cos(2 * pi / 16)
#define    C_c 1.1758756024193587169744671046113f  //c = sqrt(2) * cos(3 * pi / 16)
#define    C_d 0.78569495838710218127789736765722f //d = sqrt(2) * cos(5 * pi / 16)
#define    C_e 0.54119610014619698439972320536639f //e = sqrt(2) * cos(6 * pi / 16)
#define    C_f 0.27589937928294301233595756366937f //f = sqrt(2) * cos(7 * pi / 16)
#define C_norm 0.35355339059327376220042218105242f //1 / sqrt(8)
inline void DCT8(float *D)
{
  float X07P = D[0] + D[7];
  float X16P = D[1] + D[6];
  float X25P = D[2] + D[5];
  float X34P = D[3] + D[4];
  float X07M = D[0] - D[7];
  float X61M = D[6] - D[1];
  float X25M = D[2] - D[5];
  float X43M = D[4] - D[3];
  float X07P34PP = X07P + X34P;
  float X07P34PM = X07P - X34P;
  float X16P25PP = X16P + X25P;
  float X16P25PM = X16P - X25P;
  D[0] = C_norm * (X07P34PP + X16P25PP);
  D[2] = C_norm * (C_b * X07P34PM + C_e * X16P25PM);
  D[4] = C_norm * (X07P34PP - X16P25PP);
  D[6] = C_norm * (C_e * X07P34PM - C_b * X16P25PM);
  D[1] = C_norm * (C_a * X07M - C_c * X61M + C_d * X25M - C_f * X43M);
  D[3] = C_norm * (C_c * X07M + C_f * X61M - C_a * X25M + C_d * X43M);
  D[5] = C_norm * (C_d * X07M + C_a * X61M + C_f * X25M - C_c * X43M);
  D[7] = C_norm * (C_f * X07M + C_d * X61M + C_c * X25M + C_a * X43M);
}
float4 MatrixVecMult(float *m, float4 v)
{
  float x = m[0]*v.x + m[4]*v.y + m[8]*v.z;
  float y = m[1]*v.x + m[5]*v.y + m[9]*v.z;
	 float z = m[2]*v.x + m[6]*v.y + m[10]*v.z;
	 return (float4)(x, y, z, 0.0f);
}
float4 computeNormal(float4 position, float4 tangent, float4 binormal, float phase, float freq)
{
	float J[16];
	float dist = sqrt((float)(position.x*position.x + position.z*position.z));
	float jac_coef = cos((float)(freq*dist + phase)) / (dist+0.00001f);
	J[0] = 1.0f;
	J[1] = jac_coef * position.x;
	J[2] = 0.0f;
	J[3] = 0.0f;
	J[4] = 0.0f;
	J[5] = 1.0f;
	J[6] = 0.0f;
	J[7] = 0.0f;
	J[8] = 0.0f;
	J[9] = jac_coef * position.z;
	J[10] = 1.0f;
	J[11] = 0.0f;
	J[12] = 0.0f;
	J[13] = 0.0f;
	J[14] = 0.0f;
	J[15] = 0.0f;
  float4 u = MatrixVecMult(J, tangent);
  float4 v = MatrixVecMult(J, binormal);
	return normalize(cross(v, u));
}
float4 displacePositionFunc(float4 position, float phase, float frequency)
{
	float4 new_pos;
	new_pos.x = position.x;
	new_pos.z = position.z;
	new_pos.w = position.w;
	float dist = sqrt(position.x*position.x + position.z*position.z);
	new_pos.y = position.y + 0.5f * sin((frequency * dist) + phase) + (1.0f / (dist+0.6f));
	return new_pos;
}
float4 computeNormal_NativeSin(float4 position, float4 tangent, float4 binormal, float phase, float freq)
{
	float J[16];
	float dist = native_sqrt((float)(position.x*position.x + position.z*position.z));
	float jac_coef = native_cos((float)(freq*dist + phase)) / (dist+0.00001f);
	J[0] = 1.0f;
	J[1] = jac_coef * position.x;
	J[2] = 0.0f;
	J[3] = 0.0f;
	J[4] = 0.0f;
	J[5] = 1.0f;
	J[6] = 0.0f;
	J[7] = 0.0f;
	J[8] = 0.0f;
	J[9] = jac_coef * position.z;
	J[10] = 1.0f;
	J[11] = 0.0f;
	J[12] = 0.0f;
	J[13] = 0.0f;
	J[14] = 0.0f;
	J[15] = 0.0f;
  float4 u = MatrixVecMult(J, tangent);
  float4 v = MatrixVecMult(J, binormal);
	return normalize(cross(v, u));
}
float4 displacePositionFunc_NativeSin(float4 position, float phase, float frequency)
{
	float4 new_pos;
	new_pos.x = position.x;
	new_pos.z = position.z;
	new_pos.w = position.w;
	float dist = native_sqrt(position.x*position.x + position.z*position.z);
	new_pos.y = position.y + 0.5f * native_sin((frequency * dist) + phase) + (1.0f / (dist+0.6f));
	return new_pos;
}
__kernel void surface_deformer_with_check(__global float4* positions, __global float4* normals, unsigned int width, unsigned int height, float frequency, float time, unsigned int burn_loop_sin, unsigned int burn_loop_mad, __global float* sincos)
{
    float4 displacedPosition = (float4)(0.659870f, 1.02565f, 0.89752f, 1.256f);
    unsigned int x = get_global_id(0);
    unsigned int y = get_global_id(1);
    if ((x >= width) || (y >= height))
     return;
    int offset = y*width+x;
    float u = x / (float) width;
    float v = y / (float) height;
    u = (u*2.0f - 1.0f) * 2.0f;
    v = (v*2.0f - 1.0f) * 2.0f;
    float4 position = (float4)(u, 0.0f, v, 1.0f);
    float4 normal = (float4)(0.0f, 1.0f, 0.0f, 0.0f);
    float4 tangent;
    float4 binormal;
    float4 c1 = cross(normal, (float4)(0.0f, 0.0f, 1.0f, 0.0f));
    float4 c2 = cross(normal, (float4)(0.0f, 1.0f, 0.0f, 0.0f));
    if(length(c1) > length(c2))
     tangent = c1;
    else
     tangent = c2;
    tangent = normalize(tangent);
	   binormal = normalize(cross(normal, tangent));
    float freq2 = frequency * (4.0f + 2.0f * cos(u*0.8f));
    displacedPosition = displacePositionFunc(position, time*2.0f, freq2);
    float4 displacedNormal = computeNormal(displacedPosition, tangent, binormal, time*2.0f, freq2);
    positions[offset] = displacedPosition;
    normals[offset] = displacedNormal;
    size_t i;
    float cs = 0.0f;
    for (i=0; i<burn_loop_sin; ++i)
    {
      float pi = 4.0f * atan(1.0f);
      float c = cos(pi * (float)(x));
      float s = sin(pi * (float)(y));
      cs += sqrt(c*c + s*s);
    }
    sincos[offset] = cs;
    float dct8[8];
    dct8[0] = 0.2569f;
    dct8[1] = 0.5569f;
    dct8[2] = 0.45698f;
    dct8[3] = 0.85214f;
    dct8[4] = 0.357f;
    dct8[5] = 0.9524f;
    dct8[6] = 0.6259f;
    dct8[7] = 0.558f;
    float sum = 0.0f;
    for (i=0; i<burn_loop_mad; ++i)
    {
     size_t j;
     for (j=0; j<1000; ++j)
     {
       float x = dct8[0]*dct8[0] + dct8[1]*dct8[1];
       float y = dct8[2]*dct8[2] + dct8[3]*dct8[3];
       float z = dct8[4]*dct8[4] + dct8[5]*dct8[5];
       float w = dct8[6]*dct8[6] + dct8[7]*dct8[7];
       float norm = 1.0f / (displacedPosition.x*displacedPosition.x + displacedPosition.y*displacedPosition.y + displacedPosition.z*displacedPosition.z + 0.001f);
       sum += norm ;
     }
    }
    sincos[offset] = cs + sum;
}__kernel void surface_deformer_with_check_native_sin(__global float4* positions, __global float4* normals, unsigned int width, unsigned int height, float frequency, float time, unsigned int burn_loop_sin, unsigned int burn_loop_mad, __global float* sincos)
{
    float4 displacedPosition = (float4)(0.659870f, 1.02565f, 0.89752f, 1.256f);
    unsigned int x = get_global_id(0);
    unsigned int y = get_global_id(1);
    if ((x >= width) || (y >= height))
     return;
    int offset = y*width+x;
    float u = x / (float) width;
    float v = y / (float) height;
    u = (u*2.0f - 1.0f) * 2.0f;
    v = (v*2.0f - 1.0f) * 2.0f;
    float4 position = (float4)(u, 0.0f, v, 1.0f);
    float4 normal = (float4)(0.0f, 1.0f, 0.0f, 0.0f);
    float4 tangent;
    float4 binormal;
    float4 c1 = cross(normal, (float4)(0.0f, 0.0f, 1.0f, 0.0f));
    float4 c2 = cross(normal, (float4)(0.0f, 1.0f, 0.0f, 0.0f));
    if(length(c1) > length(c2))
     tangent = c1;
    else
     tangent = c2;
    tangent = normalize(tangent);
	   binormal = normalize(cross(normal, tangent));
    float freq2 = frequency * (4.0f + 2.0f * native_cos(u*0.8f));
    displacedPosition = displacePositionFunc_NativeSin(position, time*2.0f, freq2);
    float4 displacedNormal = computeNormal_NativeSin(displacedPosition, tangent, binormal, time*2.0f, freq2);
    positions[offset] = displacedPosition;
    normals[offset] = displacedNormal;
    size_t i;
    float cs = 0.0f;
    for (i=0; i<burn_loop_sin; ++i)
    {
      float pi = 4.0f * native_tan(1.0f);
      float c = native_cos(pi * (float)(x));
      float s = native_sin(pi * (float)(y));
      cs += native_sqrt(c*c + s*s);
    }
    sincos[offset] = cs;
    float dct8[8];
    dct8[0] = 0.2569f;
    dct8[1] = 0.5569f;
    dct8[2] = 0.45698f;
    dct8[3] = 0.85214f;
    dct8[4] = 0.357f;
    dct8[5] = 0.9524f;
    dct8[6] = 0.6259f;
    dct8[7] = 0.558f;
    float sum = 0.0f;
    for (i=0; i<burn_loop_mad; ++i)
    {
     size_t j;
     for (j=0; j<1000; ++j)
     {
       float x = dct8[0]*dct8[0] + dct8[1]*dct8[1];
       float y = dct8[2]*dct8[2] + dct8[3]*dct8[3];
       float z = dct8[4]*dct8[4] + dct8[5]*dct8[5];
       float w = dct8[6]*dct8[6] + dct8[7]*dct8[7];
       float norm = 1.0f / (displacedPosition.x*displacedPosition.x + displacedPosition.y*displacedPosition.y + displacedPosition.z*displacedPosition.z + 0.001f);
       sum += norm ;
     }
    }
    sincos[offset] = cs + sum;
}__kernel void surface_deformer(__global float4* positions, __global float4* normals, unsigned int width, unsigned int height, float frequency, float time, unsigned int burn_loop_sin, unsigned int burn_loop_mad)
{
    float4 displacedPosition = (float4)(0.659870f, 1.02565f, 0.89752f, 1.256f);
    unsigned int x = get_global_id(0);
    unsigned int y = get_global_id(1);
    if ((x >= width) || (y >= height))
     return;
    int offset = y*width+x;
    float u = x / (float) width;
    float v = y / (float) height;
    u = (u*2.0f - 1.0f) * 2.0f;
    v = (v*2.0f - 1.0f) * 2.0f;
    float4 position = (float4)(u, 0.0f, v, 1.0f);
    float4 normal = (float4)(0.0f, 1.0f, 0.0f, 0.0f);
    float4 tangent;
    float4 binormal;
    float4 c1 = cross(normal, (float4)(0.0f, 0.0f, 1.0f, 0.0f));
    float4 c2 = cross(normal, (float4)(0.0f, 1.0f, 0.0f, 0.0f));
    if(length(c1) > length(c2))
     tangent = c1;
    else
     tangent = c2;
    tangent = normalize(tangent);
	   binormal = normalize(cross(normal, tangent));
    float freq2 = frequency * (4.0f + 2.0f * cos(u*0.8f));
    displacedPosition = displacePositionFunc(position, time*2.0f, freq2);
    float4 displacedNormal = computeNormal(displacedPosition, tangent, binormal, time*2.0f, freq2);
    positions[offset] = displacedPosition;
    normals[offset] = displacedNormal;
    size_t i;
    float cs = 0.0f;
    float sum = 0.0f;
    for (i=0; i<burn_loop_sin; ++i)
    {
      float pi = 4.0f * tan(1.0f);
      float c = cos(pi * (float)(x));
      float s = sin(pi * (float)(y));
      sum += sqrt(c*c + s*s);
    }
    float dct8[8];
    dct8[0] = 0.2569f;
    dct8[1] = 0.5569f;
    dct8[2] = 0.45698f;
    dct8[3] = 0.85214f;
    dct8[4] = 0.357f;
    dct8[5] = 0.9524f;
    dct8[6] = 0.6259f;
    dct8[7] = 0.558f;
    for (i=0; i<burn_loop_mad; ++i)
    {
     size_t j;
     for (j=0; j<1000; ++j)
     {
       float x = dct8[0]*dct8[0] + dct8[1]*dct8[1];
       float y = dct8[2]*dct8[2] + dct8[3]*dct8[3];
       float z = dct8[4]*dct8[4] + dct8[5]*dct8[5];
       float w = dct8[6]*dct8[6] + dct8[7]*dct8[7];
       float norm = 1.0f / (displacedPosition.x*displacedPosition.x + displacedPosition.y*displacedPosition.y + displacedPosition.z*displacedPosition.z + 0.001f);
       sum += norm ;
     }
    }
    cs = sum;
}__kernel void surface_deformer_native_sin(__global float4* positions, __global float4* normals, unsigned int width, unsigned int height, float frequency, float time, unsigned int burn_loop_sin, unsigned int burn_loop_mad)
{
    float4 displacedPosition = (float4)(0.659870f, 1.02565f, 0.89752f, 1.256f);
    unsigned int x = get_global_id(0);
    unsigned int y = get_global_id(1);
    if ((x >= width) || (y >= height))
     return;
    int offset = y*width+x;
    float u = x / (float) width;
    float v = y / (float) height;
    u = (u*2.0f - 1.0f) * 2.0f;
    v = (v*2.0f - 1.0f) * 2.0f;
    float4 position = (float4)(u, 0.0f, v, 1.0f);
    float4 normal = (float4)(0.0f, 1.0f, 0.0f, 0.0f);
    float4 tangent;
    float4 binormal;
    float4 c1 = cross(normal, (float4)(0.0f, 0.0f, 1.0f, 0.0f));
    float4 c2 = cross(normal, (float4)(0.0f, 1.0f, 0.0f, 0.0f));
    if(length(c1) > length(c2))
     tangent = c1;
    else
     tangent = c2;
    tangent = normalize(tangent);
	   binormal = normalize(cross(normal, tangent));
    float freq2 = frequency * (4.0f + 2.0f * native_cos(u*0.8f));
    displacedPosition = displacePositionFunc_NativeSin(position, time*2.0f, freq2);
    float4 displacedNormal = computeNormal_NativeSin(displacedPosition, tangent, binormal, time*2.0f, freq2);
    positions[offset] = displacedPosition;
    normals[offset] = displacedNormal;
    size_t i;
    float cs = 0.0f;
    float sum = 0.0f;
    for (i=0; i<burn_loop_sin; ++i)
    {
      float pi = 4.0f * native_tan(1.0f);
      float c = native_cos(pi * (float)(x));
      float s = native_sin(pi * (float)(y));
      sum += native_sqrt(c*c + s*s);
    }
    float dct8[8];
    dct8[0] = 0.2569f;
    dct8[1] = 0.5569f;
    dct8[2] = 0.45698f;
    dct8[3] = 0.85214f;
    dct8[4] = 0.357f;
    dct8[5] = 0.9524f;
    dct8[6] = 0.6259f;
    dct8[7] = 0.558f;
    for (i=0; i<burn_loop_mad; ++i)
    {
     size_t j;
     for (j=0; j<1000; ++j)
     {
       float x = dct8[0]*dct8[0] + dct8[1]*dct8[1];
       float y = dct8[2]*dct8[2] + dct8[3]*dct8[3];
       float z = dct8[4]*dct8[4] + dct8[5]*dct8[5];
       float w = dct8[6]*dct8[6] + dct8[7]*dct8[7];
       float norm = 1.0f / (displacedPosition.x*displacedPosition.x + displacedPosition.y*displacedPosition.y + displacedPosition.z*displacedPosition.z + 0.001f);
       sum += norm ;
     }
    }
    cs = sum;
 }


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
