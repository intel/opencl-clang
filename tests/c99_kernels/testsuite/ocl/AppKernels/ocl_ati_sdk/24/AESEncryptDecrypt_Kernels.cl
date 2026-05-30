/**
 * \File AESEncryptDecrypt_Kernels.cl
 * \brief contains the kernels for encryption and decryption
 */

#pragma OPENCL EXTENSION cl_amd_printf : enable

inline uchar4
sbox(__global uchar * SBox,
	uchar4 block)
{
    return (uchar4)(SBox[block.x], SBox[block.y], SBox[block.z], SBox[block.w]);
}

uchar4
shiftRows(uchar4 value,
	unsigned int rowNumber)
{
	uchar4 tempValue = value;
	for (unsigned int i = 0; i < rowNumber; i++)
	{
		tempValue = tempValue.yzwx;
	}
	return tempValue;
}

uchar4
shiftRowsInv(uchar4 value,
	unsigned int j)
{
    uchar4 tempValue = value;
    for(uint i = 0; i < j; ++i)
    {
        tempValue = tempValue.wxyz;
    }
    return tempValue;
}

unsigned char
galoisMultiplication(unsigned char a,
	unsigned char b)
{
    unsigned char p = 0;
    for(unsigned int i = 0; i < 8; ++i)
    {
        if((b & 1) == 1)
        {
            p ^= a;
        }
        unsigned char hiBitSet = (a & 0x80);
        a <<= 1;
        if(hiBitSet == 0x80)
        {
            a ^= 0x1b;
        }
        b >>= 1;
    }
    return p;
}

uchar4
mixColumns(__local uchar4 * block,
	__private uchar4 * galiosCoeff,
	unsigned int j,
	unsigned int localIndex,
	unsigned int localSizex)
{
	unsigned int bw = 4;

    uchar x, y, z, w;

	unsigned int localIdx = localIndex - localSizex * j;

	x = galoisMultiplication(block[localIdx].x,
			galiosCoeff[(bw - j) % bw].x);
    y = galoisMultiplication(block[localIdx].y,
			galiosCoeff[(bw - j) % bw].x);
    z = galoisMultiplication(block[localIdx].z,
			galiosCoeff[(bw - j) % bw].x);
    w = galoisMultiplication(block[localIdx].w,
			galiosCoeff[(bw - j) % bw].x);

    for(unsigned int k = 1; k < 4; ++k)
    {
        x ^= galoisMultiplication(block[k * localSizex + localIdx].x,
				galiosCoeff[(k + bw - j) % bw].x);
        y ^= galoisMultiplication(block[k * localSizex + localIdx].y,
				galiosCoeff[(k + bw - j) % bw].x);
        z ^= galoisMultiplication(block[k * localSizex + localIdx].z,
				galiosCoeff[(k + bw - j) % bw].x);
        w ^= galoisMultiplication(block[k * localSizex + localIdx].w,
				galiosCoeff[(k + bw - j) % bw].x);
    }

	return (uchar4)(x, y, z, w);
}

__kernel
void AESEncrypt(__global  uchar4  * output  ,
                __global  uchar4  * input   ,
                __global  uchar4  * roundKey,
                __global  uchar   * SBox    ,
                __local   uchar4  * block0  ,
                __local   uchar4  * block1  ,
                const     uint      width   ,
                const     uint     rounds   )

{
	//calculating the local_id values
	unsigned int localIdx = get_local_id(0);
	unsigned int localIdy = get_local_id(1);

	//calculating global id values
	unsigned int globalIdx = get_global_id(0);
	unsigned int globalIdy = get_global_id(1);

	//calculating the block_id values
	unsigned int blockIdx = get_group_id(0);
	unsigned int blockIdy = get_group_id(1);

	//calculating NDRange sizes
	unsigned int ndRangeSizex = get_global_size(0);
	unsigned int ndRangeSizey = get_global_size(1);

	//calculating block size
	unsigned int localSizex = get_local_size(0);
	unsigned int localSizey = get_local_size(1);

	//calculating the localIndex value in the block
	unsigned int localIndex = localIdy * (localSizex) + localIdx;

	//calculating the global index value
	unsigned int globalIndex1 = localIndex +
									(localSizex * localSizey *
									(blockIdx + blockIdy * (ndRangeSizex / localSizex)));

	unsigned int globalIndex = globalIdy * ndRangeSizex + globalIdx;

	block0[localIndex] = input[globalIndex];

	/**
	* Applying AES algorithm
	**/

	//1. addRoundKey
	block0[localIndex] ^= roundKey[localIdy];

	__private uchar4 galiosCoeff[4];
    galiosCoeff[0] = (uchar4)(2, 0, 0, 0);
    galiosCoeff[1] = (uchar4)(3, 0, 0, 0);
    galiosCoeff[2] = (uchar4)(1, 0, 0, 0);
    galiosCoeff[3] = (uchar4)(1, 0, 0, 0);

	//Rounds
	for (int i = 1; i < rounds; i++)
	{
		//1. subytes
		block0[localIndex] = sbox(SBox,
								block0[localIndex]);

		//2. shiftRows
		block0[localIndex] = shiftRows(block0[localIndex],
								localIdy);
		barrier(CLK_LOCAL_MEM_FENCE);//local memory synchronization

		//3. mixCols
		block1[localIndex]  = mixColumns(block0,
								galiosCoeff,
								localIdy,
								localIndex,
								localSizex);
		barrier(CLK_LOCAL_MEM_FENCE);//local memory synchronization

		//4. addRoundKey
		block0[localIndex] = block1[localIndex] ^ roundKey[i * 4 + localIdy];
	}

	//1. subBytes
	block0[localIndex] = sbox(SBox,
							block0[localIndex]);

	//2. shiftRows
	block0[localIndex] = shiftRows(block0[localIndex],
							localIdy);

	//3. addRoundKey
	block0[localIndex] ^= roundKey[localIdy + rounds * 4];

	output[globalIndex] = block0[localIndex];
}

__kernel
void AESDecrypt(__global  uchar4  * output    ,
                __global  uchar4  * input     ,
                __global  uchar4  * roundKey  ,
                __global  uchar   * SBox      ,
                __local   uchar4  * block0    ,
                __local   uchar4  * block1    ,
                const     uint      width     ,
                const     uint      rounds    )

{
	//calculating the local_id values
	unsigned int localIdx = get_local_id(0);
	unsigned int localIdy = get_local_id(1);

	//calculating global id values
	unsigned int globalIdx = get_global_id(0);
	unsigned int globalIdy = get_global_id(1);

	//calculating the block_id values
	unsigned int blockIdx = get_group_id(0);
	unsigned int blockIdy = get_group_id(1);

	//calculating NDRange sizes
	unsigned int ndRangeSizex = get_global_size(0);
	unsigned int ndRangeSizey = get_global_size(1);

	//calculating block size
	unsigned int localSizex = get_local_size(0);
	unsigned int localSizey = get_local_size(1);

	//calculating the localIndex value in the block
	unsigned int localIndex = localIdy * (localSizex) + localIdx;

	//calculating the global index value
	unsigned int globalIndex1 = localIndex +
									(localSizex * localSizey *
									(blockIdx + blockIdy * (ndRangeSizex / localSizex)));

	unsigned int globalIndex = globalIdy * ndRangeSizex + globalIdx;

	block0[localIndex] = input[globalIndex];

	__private uchar4 galiosCoeff[4];
    galiosCoeff[0] = (uchar4)(14, 0, 0, 0);
    galiosCoeff[1] = (uchar4)(11, 0, 0, 0);
    galiosCoeff[2] = (uchar4)(13, 0, 0, 0);
    galiosCoeff[3] = (uchar4)(9, 0, 0, 0);

    //1. addRoundKey
    block0[localIndex] ^= roundKey[4 * rounds + localIdy];

	for(unsigned int r = rounds - 1; r > 0; --r)
    {
		//1. shiftRowsInv
		block0[localIndex] = shiftRowsInv(block0[localIndex],
								localIdy);

		//2. sbox
		block0[localIndex] = sbox(SBox,
								block0[localIndex]);
		barrier(CLK_LOCAL_MEM_FENCE);//local memory synchronization

		//3. addRoundKey
		block1[localIndex] = block0[localIndex] ^ roundKey[r * 4 + localIdy];
		barrier(CLK_LOCAL_MEM_FENCE);//local memory synchronization

		//4. mixColumns
		block0[localIndex]  = mixColumns(block1,
								galiosCoeff,
								localIdy,
								localIndex,
								localSizex);
    }

	//1. shiftRowsInv
	block0[localIndex] = shiftRowsInv(block0[localIndex],
							localIdy);

	//2. sbox
	block0[localIndex] = sbox(SBox,
							block0[localIndex]);

	output[globalIndex] =  block0[localIndex] ^ roundKey[localIdy];
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
