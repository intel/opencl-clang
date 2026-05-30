#define IA 16807    			// a
#define IM 2147483647 			// m
#define AM (1.0/IM) 			// 1/m - To calculate floating point result
#define IQ 127773
#define IR 2836
#define NTAB 4
#define NDIV (1 + (IM - 1)/ NTAB)
#define EPS 1.2e-7
#define RMAX (1.0 - EPS)
#define FACTOR 60			// Deviation factor
#define GROUP_SIZE 256
#define PI 3.14


/* Generate uniform random deviation */
// Park-Miller with Bays-Durham shuffle and added safeguards
// Returns a uniform random deviate between (-FACTOR/2, FACTOR/2)
// input seed should be negative
float ran1(int idum, __local int *iv)
{
    int j;
    int k;
    int iy = 0;
    //__local int iv[NTAB * GROUP_SIZE];
    int tid = get_local_id(0);

    for(j = NTAB; j >=0; j--)			//Load the shuffle
    {
        k = idum / IQ;
        idum = IA * (idum - k * IQ) - IR * k;

        if(idum < 0)
            idum += IM;

        if(j < NTAB)
            iv[NTAB* tid + j] = idum;
    }
    iy = iv[0];


    k = idum / IQ;
    idum = IA * (idum - k * IQ) - IR * k;

    if(idum < 0)
        idum += IM;

    j = iy / NDIV;
    iy = iv[NTAB * tid + j];
    return (AM * iy);	//AM *iy will be between 0.0 and 1.0
}




/* Box muller transformation */
float2 BoxMuller(float2 uniform)
{
  float r = sqrt(-2 * log(uniform.x));
  float theta = 2 * PI * uniform.y;
  return (float2)(r * sin(theta), r * cos(theta));
}


__kernel void gaussian_transform(__global uchar4* inputImage, __global uchar4 *outputImage, int factor)
{
	/* Global threads in x-direction = ImageWidth / 2 */
	int pos = get_global_id(0) + 2 * get_global_size(0) * get_global_id(1);

	/* Read 2 texels from image data */
	float4 texel0 = convert_float4(inputImage[pos]);
	float4 texel1 = convert_float4(inputImage[pos + get_global_size(0)]);

	/* Compute the average value for each pixel */
	float avg0 = (texel0.x + texel0.y + texel0.z + texel0.w) / 4;
	float avg1 = (texel1.x + texel1.y + texel1.z + texel1.w) / 4;

	__local int iv0[NTAB * GROUP_SIZE];
	__local int iv1[NTAB * GROUP_SIZE];

	/* Compute uniform deviation for the pixel */
	float dev0 = ran1(-avg0, iv0);
	float dev1 = ran1(-avg1, iv1);

	/* Apply the box-muller transform */
	float2 gaussian = BoxMuller((float2)(dev0, dev1));

	/* Write 2 texels with deviation added */
	outputImage[pos] = convert_uchar4_sat(texel0 + (float4)(gaussian.x * factor));
	outputImage[pos + get_global_size(0)] = convert_uchar4_sat(texel1 + (float4)(gaussian.y * factor));

}





























// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
