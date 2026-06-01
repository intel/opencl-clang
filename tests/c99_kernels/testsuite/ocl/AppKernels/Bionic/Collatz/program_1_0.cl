//NOTICE: This kernel must define LUTSTEP and SIEVESTEP
//Table: power of 3
__constant uint power3[21] =
	{1u,3u,9u,27u,81u,243u,729u,2187u,6561u,19683u,
	59049u,177147u,531441u,1594323u,4782969u,14348907u,43046721u,129140163u,387420489u,1162261467u,
	3486784401u
};
inline uint2 mul64(const uint a, const uint b){
	return (uint2)(a*b, mul_hi(a,b));
}
__kernel void kernelSteps (
   __global uint4 *results, //Result: s0:max step; s1:low offset; s2:high offset; s3:total steps. Size = global work size
   __global const uint *sieve, //Numbers needed to compute for every 2^(SIEVESTEP) numbers. size = global work size
   __global const uint2 *table, //look-up table for jumping in collatz algorithm. Size = 2^(LUTSTEP)
   __global const uint *delay, //Collatz delays for numbers under 2^(LUTSTEP),. Size = 2^(LUTSTEP)
   const ulong2 start, //Starting value (128-bit), must be multiple of 2^(SIEVESTEP)
   const uint kNo //'kernel set' number, kNo = 1 means offset = 1* 2^(SIEVESTEP). kNo = 0 means clear the result
)
{
   const uint gid = get_global_id(0);
   const uint bitDiff = 32 - LUTSTEP, tableSizeMinusOne = (1u << LUTSTEP) - 1;
   const uint maxStep = 0xfffffff; //maximum step allowed by this kernel (2^28-1)
   uint contCarry = 1u, stepCount = 0, p3, overflow; //contCarry : if loop should continue and hold carry bits, stepCount : count collatz Delay, p3 : store power3[]
   const ulong totalOffset = (ulong)sieve[gid] + ((ulong)kNo * (ulong)(SIEVESIZE));
   ulong2 uval = (ulong2)(start.s0 + totalOffset, start.s1);
   uval.s1 += (uval.s0 < totalOffset);
   uint2 lut, mulResult, val_h; //lut : table item. mulResult : mul64() result, val_h : val and val_h combined to be a 196-bit integer
	uint4 val = (uint4)((uint)uval.s0,(uint)(uval.s0>>32), (uint)uval.s1, (uint)(uval.s1>>32));
	val_h = (uint2)(0u, 0u );
	//Loop
	while(contCarry){
		//get look-up table item
		lut = table[val.s0 & tableSizeMinusOne];
		p3 = power3[lut.s0];
		//Do n = (n>>LUTSTEP)*a + b
		//bit 0-31
		mulResult = mul64((val.s0 >> LUTSTEP) + (val.s1 << bitDiff), p3); //Multiply 'a'
		val.s0 = mulResult.s0 + lut.s1; //Add 'b'
		contCarry = mulResult.s1 + (val.s0 < mulResult.s0); //count carry bits
		//bit 32-63
		mulResult = mul64((val.s1 >> LUTSTEP) + (val.s2 << bitDiff), p3);
		val.s1 = mulResult.s0 + contCarry;
		contCarry = mulResult.s1 + (val.s1 < mulResult.s0);
		//bit 64-95
		mulResult = mul64((val.s2 >> LUTSTEP) + (val.s3 << bitDiff), p3);
		val.s2 = mulResult.s0 + contCarry;
		contCarry = mulResult.s1 + (val.s2 < mulResult.s0);
		//bit 96-127
		mulResult = mul64((val.s3 >> LUTSTEP) + (val_h.s0 << bitDiff), p3);
		val.s3 = mulResult.s0 + contCarry;
		contCarry = mulResult.s1 + (val.s3 < mulResult.s0);
		//bit 128-159
		mulResult = mul64((val_h.s0 >> LUTSTEP) + (val_h.s1 << bitDiff), p3);
		val_h.s0 = mulResult.s0 + contCarry;
		contCarry = mulResult.s1 + (val_h.s0 < mulResult.s0);
		//bit 160-191 and overflow detection
		mulResult = mul64((val_h.s1 >> LUTSTEP), p3);
		val_h.s1 = mulResult.s0 + contCarry;
		overflow = mulResult.s1 + (val_h.s1 < mulResult.s0);
		stepCount += (lut.s0 + LUTSTEP); //add step
		//if val < tableSize or overflow or step >= maxStep, exit loop (set contCarry to 0), else set it to 1
		contCarry = ((val.s0 > tableSizeMinusOne) | (val.s1 | val.s2 | val.s3 | val_h.s0 | val_h.s1)) && (!(overflow | (stepCount >= maxStep)));
	}
	//If overflow is true, stepCount = maxStep; otherwise, stepCount += delay[val.s0&(tableSize-1)], contCarry is use as a temporary int
	contCarry = stepCount + delay[val.s0 & tableSizeMinusOne];
	stepCount = select(contCarry, maxStep, overflow);
	//Use val as the result to save space as it's no longer used
	val = results[gid];
   contCarry = (stepCount > val.s0) | (kNo == 0) | ((stepCount == val.s0) && (totalOffset < ((ulong)val.s1 + ((ulong)val.s2<<32))));
   val.s0 = select(val.s0,stepCount,contCarry);
   val.s1 = select(val.s1, (uint)totalOffset, contCarry);
   val.s2 = select(val.s2, (uint)(totalOffset>>32), contCarry);
   contCarry = (kNo == 0);
   val.s3 = select(val.s3 + stepCount, stepCount, contCarry);
	//save result to output array
	results[gid] = val;
}  //end of kernel
__kernel void kernelReduce(__global uint4 *results, __global uint4 *out, __local uint4 *temp)
{
    uint gid = get_global_id(0);
    uint gsz = get_global_size(0);
    uint lid = get_local_id(0);
    uint lsz = get_local_size(0);
    uint4 a = results[gid];
    uint4 b = results[gid + gsz];
    ulong ua, ub;
    ua = (ulong)a.s1 + ((ulong)a.s2<<32);
    ub = (ulong)b.s1 + ((ulong)b.s2<<32);
    uint x = (a.s0 > b.s0) || ((a.s0 == b.s0) && (ua < ub)) ;
    temp[lid].s0 = select(b.s0,a.s0,x);
    temp[lid].s1 = select(b.s1,a.s1,x);
    temp[lid].s2 = select(b.s2,a.s2,x);
    temp[lid].s3 = a.s3 + b.s3;
    barrier(CLK_LOCAL_MEM_FENCE);
    for(uint stride=lsz/2;stride>1;stride>>=1)
    {
        if (lid < stride)
        {
            a = temp[lid];
            b = temp[lid + stride];
            ua = (ulong)a.s1 + ((ulong)a.s2<<32);
            ub = (ulong)b.s1 + ((ulong)b.s2<<32);
            x = (a.s0 > b.s0) || ((a.s0 == b.s0) && (ua < ub)) ;
            temp[lid].s0 = select(b.s0,a.s0,x);
            temp[lid].s1 = select(b.s1,a.s1,x);
            temp[lid].s2 = select(b.s2,a.s2,x);
            temp[lid].s3 = a.s3 + b.s3;
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }
    if (lid == 0)
    {
        //x = temp[0].s0 >= temp[1].s0;
        ua = (ulong)temp[0].s1 + ((ulong)temp[0].s2<<32);
        ub = (ulong)temp[1].s1 + ((ulong)temp[1].s2<<32);
        x = (temp[0].s0 > temp[1].s0) || ((temp[0].s0 == temp[1].s0) && (ua < ub)) ;
        a.s0 = select(temp[1].s0,temp[0].s0,x);
        a.s1 = select(temp[1].s1,temp[0].s1,x);
        a.s2 = select(temp[1].s2,temp[0].s2,x);
        a.s3 = temp[0].s3 + temp[1].s3;
        out[get_group_id(0)] = a;
    }
}



// buildOptions=-cl-finite-math-only -cl-no-signed-zeros -Werror -D LUTSTEP=12 -D SIEVESTEP=26 -D SIEVESIZE=67108864
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-finite-math-only -cl-no-signed-zeros -Werror -D LUTSTEP=12 -D SIEVESTEP=26 -D SIEVESIZE=67108864" %cfg_path --cl-device=%cl_device 2>&1
