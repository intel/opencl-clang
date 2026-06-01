/**
 * A random number generator based on the Tiny Encryption Algorithm (TEA),
 * as proposed by Zafar et al. in "GPU Random Numbers via the Tiny Encryption
 * Algorithm" at High Performance Graphics 2010.
 *
 * Generates a pair of 32-bit random numbers from the given pair of 32-bit
 * seed values. The number of iterations can be adjusted depending on the
 * required degree of randomness: 16 iterations is typically enough for any
 * use, but even 2 or 4 may be enough for less demanding use cases. Note
 * that the required number of iterations is proportional to how "random"
 * the seed values are.
 *
 * @param {uint2} seed an arbitrary seed for the random number generator
 * @param {uint} iterations the number of times to iterate in the generator
 * @return {uint2} a pair of 32-bit random numbers generated from the seed
 *
 * @author Tomi Aarnio
 * @license MIT, LGPL
 */

uint2 rand(uint2 seed, uint iterations) {
  uint sum = 0;
  uint delta = 0x9E3779B9;
  uint k[4] = { 0xA341316C, 0xC8013EA4, 0xAD90777D, 0x7E95761E };

  for (int j=0; j < iterations; j++) {
    sum += delta;
    seed.x += ((seed.y << 4) + k[0]) & (seed.y + sum) & ((seed.y >> 5) + k[1]);
    seed.y += ((seed.x << 4) + k[2]) & (seed.x + sum) & ((seed.x >> 5) + k[3]);
  }

  return seed;
}

/**
 * The number of times to iterate the random number generator; higher values
 * provide more random results. Fifteen iterations is enough to avoid any
 * visually discernible regularities in the output, but even 5-10 would be
 * enough for many uses.
 */

__constant uint ITER = 15;

/**
 * Fills the given 1D buffer with random colors to visualize the results
 * of the TEA random number generator (RNG).
 *
 * @param {uchar4*} dst the buffer to fill with random values
 * @param {uint} length the length of the dst buffer, in uchar4 elements
 * @param {uint} seed an arbitrary seed value to initialize the RNG with
 *
 * @author Tomi Aarnio
 * @license MIT, LGPL
 */

kernel void clRandom1D(__global uchar4* dst,
                         uint length,
                         uint seed)
{
  uint x = get_global_id(0);
  if (x >= length) return;

  uint2 rnd = (seed, seed << 3);
  rnd.x += x + (x << 11) + (x << 19);
  rnd.y += x + (x << 9) + (x << 21);
  rnd = rand(rnd, ITER);
  uchar r = rnd.x & 0xff;

  float t = cos(seed/31.4f)/2.0f + 0.5f;
  float baseAlpha = (rnd.x & 0xff00) >> 8;
  baseAlpha = mix(baseAlpha, max(baseAlpha-32.0f, 0.0f), t);
  float diffAlpha = dst[x].x / 4.0f;
  float targetAlpha = clamp(baseAlpha+diffAlpha, 0.0f, 255.0f);
  float alpha = mix(baseAlpha, targetAlpha, t);

  dst[x] = (uchar4)(r, r, r, alpha);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
