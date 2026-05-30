/*
 * Implemented Gaussian Random Number Generator. SIMD-oriented Fast Mersenne
 * Twister(SFMT) used to generate random numbers and Box mullar transformation used
 * to convert them to Gaussian random numbers.
 *
 * The SFMT algorithm details could be found at
 * http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/SFMT/index.html
 *
 * Box-Muller Transformation
 * http://mathworld.wolfram.com/Box-MullerTransformation.html
 *
 * One invocation of this kernel(gaussianRand), i.e one work thread writes
 * mulFactor output values.
 */

/**
 * @brief Left shift
 * @param input input to be shifted
 * @param shift shifting count
 * @param output result after shifting input
 */
void
lshift128(uint4 input, uint shift, uint4* output)
{
    unsigned int invshift = 32u - shift;

    uint4 temp;
    temp.x = input.x << shift;
    temp.y = (input.y << shift) | (input.x >> invshift);
    temp.z = (input.z << shift) | (input.y >> invshift);
    temp.w = (input.w << shift) | (input.z >> invshift);

    *output = temp;
}

/**
 * @brief Right shift
 * @param input input to be shifted
 * @param shift shifting count
 * @param output result after shifting input
 */
void
rshift128(uint4 input, uint shift, uint4* output)
{
    unsigned int invshift = 32u - shift;

    uint4 temp;

    temp.w = input.w >> shift;
    temp.z = (input.z >> shift) | (input.w << invshift);
    temp.y = (input.y >> shift) | (input.z << invshift);
    temp.x = (input.x >> shift) | (input.y << invshift);

    *output = temp;
}

/**
 * @brief Generates gaussian random numbers by using
 *        Mersenenne Twister algo and box muller transformation
 * @param seedArray  array of seeds
 * @param width width of 2D seedArray
 * @param mulFactor No of generated random numbers for each seed
 * @param randArray  array of random number from given seeds
 */
__kernel
void gaussianRand(const __global uint4 *seedArray,
            uint width,
            uint mulFactor,
            __global float4 *gaussianRand)
{

    uint4 temp[8];

    size_t xPid = get_global_id(0);
    size_t yPid = get_global_id(1);

    uint4 state1 = seedArray[yPid *width + xPid];
    uint4 state2 = (uint4)(0);
    uint4 state3 = (uint4)(0);
    uint4 state4 = (uint4)(0);
    uint4 state5 = (uint4)(0);

    uint stateMask = 1812433253u;
    uint thirty = 30u;
    uint4 mask4 = (uint4)(stateMask);
    uint4 thirty4 = (uint4)(thirty);
    uint4 one4 = (uint4)(1u);
    uint4 two4 = (uint4)(2u);
    uint4 three4 = (uint4)(3u);
    uint4 four4 = (uint4)(4u);

    uint4 r1 = (uint4)(0);
    uint4 r2 = (uint4)(0);

    uint4 a = (uint4)(0);
    uint4 b = (uint4)(0);

    uint4 e = (uint4)(0);
    uint4 f = (uint4)(0);

    unsigned int thirteen  = 13u;
    unsigned int fifteen = 15u;
    unsigned int shift = 8u * 3u;

    unsigned int mask11 = 0xfdff37ffu;
    unsigned int mask12 = 0xef7f3f7du;
    unsigned int mask13 = 0xff777b7du;
    unsigned int mask14 = 0x7ff7fb2fu;

    size_t actualPos = (size_t)0;


    const float one = 1.0f;
    const float intMax = 4294967296.0f;
    const float PI = 3.14159265358979f;
    const float two = 2.0f;

    float4 r;
    float4 phi;

    float4 temp1;
    float4 temp2;

    //Initializing states.
    state2 = mask4 * (state1 ^ (state1 >> thirty4)) + one4;
    state3 = mask4 * (state2 ^ (state2 >> thirty4)) + two4;
    state4 = mask4 * (state3 ^ (state3 >> thirty4)) + three4;
    state5 = mask4 * (state4 ^ (state4 >> thirty4)) + four4;

    uint i = 0;
    for(i = 0; i < mulFactor; ++i)
    {
        switch(i)
        {
            case 0:
                r1 = state4;
                r2 = state5;
                a = state1;
                b = state3;
                break;
            case 1:
                r1 = r2;
                r2 = temp[0];
                a = state2;
                b = state4;
                break;
            case 2:
                r1 = r2;
                r2 = temp[1];
                a = state3;
                b = state5;
                break;
            case 3:
                r1 = r2;
                r2 = temp[2];
                a = state4;
                b = state1;
                break;
            case 4:
                r1 = r2;
                r2 = temp[3];
                a = state5;
                b = state2;
                break;
            case 5:
                r1 = r2;
                r2 = temp[4];
                a = temp[0];
                b = temp[2];
                break;
            case 6:
                r1 = r2;
                r2 = temp[5];
                a = temp[1];
                b = temp[3];
                break;
            case 7:
                r1 = r2;
                r2 = temp[6];
                a = temp[2];
                b = temp[4];
                break;
            default:
                break;

        }

        lshift128(a, shift, &e);
        rshift128(r1, shift, &f);

        temp[i].x = a.x ^ e.x ^ ((b.x >> thirteen) & mask11) ^ f.x ^ (r2.x << fifteen);
        temp[i].y = a.y ^ e.y ^ ((b.y >> thirteen) & mask12) ^ f.y ^ (r2.y << fifteen);
        temp[i].z = a.z ^ e.z ^ ((b.z >> thirteen) & mask13) ^ f.z ^ (r2.z << fifteen);
        temp[i].w = a.w ^ e.w ^ ((b.w >> thirteen) & mask14) ^ f.w ^ (r2.w << fifteen);
    }

    actualPos = (yPid * width + xPid) * mulFactor;

    for(i = 0; i < mulFactor / 2; ++i)
    {
        temp1 = convert_float4(temp[i]) * one / intMax;
        temp2 = convert_float4(temp[i + 1]) * one / intMax;

        // Applying Box Mullar Transformations.
        r = sqrt((-two) * log(temp1));
        phi  = two * PI * temp2;
        gaussianRand[actualPos + i * 2 + 0] = r * cos(phi);
        gaussianRand[actualPos + i * 2 + 1] = r * sin(phi);
    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
