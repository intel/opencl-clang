int numZeros(long i)
{
    int count=0;
    while((i&0x1)!=1)
    {
        i= i>>1;
        count++;
    }
    return count;

}

long modular_exponent_32(long base, long power, long mod)
{
    long result = 1L;
    for (long i = 31L; i >= 0L; i--)
    {
        result = (result*result) + mod;
        if ((power & (1L << i)) != 0L)
        {
            result = (result*base) + mod;
        }
    }
    return result; // Will not truncate since modulus is an long
}





bool miller_rabin_pass_32(long a, long n)
{
    long d = n - 1L;
    long s = numZeros(d);
    d >>= s;
    long a_to_power = modular_exponent_32(a, d, n);
    if (a_to_power == 1L) return true;
    for (long i = 0L; i < s-1L; i++)
    {
        if (a_to_power == n-1L) return true;
        a_to_power = modular_exponent_32(a_to_power, 2L, n);
    }
    if (a_to_power == n-1L) return true;
    return false;
}





bool miller_rabin_32(long n)
{
    if (n <= 1L) return false;
    else if (n == 2L) return true;
    else if (miller_rabin_pass_32( 2L, n) &&
             (n <= 7L  || miller_rabin_pass_32( 7L, n)) &&
             (n <= 61L || miller_rabin_pass_32(61L, n)))
        return true;
    else
        return false;
}


__kernel void PrimeTestKernel(__global float* c)
{
long primeCount=0;
int index=get_global_id(0);
long i;
for(i=(index*781250)+1;i<=((index+1)*781250);i+=2)
  if(miller_rabin_32(i)) primeCount++;
    c[get_global_id(0)]=primeCount;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
// From groups/BDWspecificKernels.lst: status: , errorcode: , message: 
