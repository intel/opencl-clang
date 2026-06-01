/*
 * For a description of the algorithm and the terms used, please see the
 * documentation for this sample.
 */


/**
 * @brief   Calculates decomposed signal with maximum of 9 levels by using
 *          1D Haar wavelet decomposition
 * @param   inSignal        input signal
 * @param   coefsSignal     Coefficient details of signal after 9 levels of decompostion
 * @param   AverageSignal   Averages of signal after 9 levels of decompostion
 * @param   sharedArray     shared array
 * @param   tLevels         actual levels required for full decomposition
 * @param   signalLength    length of signal
 * @param   levelsDone      level of decompositions done
 * @param   mLevels	    maximum number of levels to be processed on device
 */
__kernel
void dwtHaar1D(
                __global float *inSignal,
                __global float *coefsSignal,
                __global float *AverageSignal,
                __local float *sharedArray,
                uint tLevels,
                uint signalLength,
                uint levelsDone,
		uint mLevels)

{
    size_t localId = get_local_id(0);
    size_t groupId = get_group_id(0);
    size_t globalId = get_global_id(0);
    size_t localSize = get_local_size(0);

    /**
     * Read input signal data from global memory
     * to shared memory
     */
    sharedArray[localId * 2] = inSignal[groupId * localSize * 2 + localId * 2];
    sharedArray[localId * 2 + 1] = inSignal[groupId * localSize * 2 + localId * 2 + 1];

    /* Divide with signal length for normalized decomposition */
    if(0 == levelsDone)
    {
       sharedArray[localId * 2] /= sqrt((float)signalLength);
       sharedArray[localId * 2 + 1] /= sqrt((float)signalLength);
    }

    barrier(CLK_LOCAL_MEM_FENCE);

    uint levels = tLevels > mLevels ? mLevels: tLevels;
    uint activeThreads = (1 << levels) / 2;
    uint midOutPos = signalLength / 2;

    for(uint i = 0; i < levels; ++i)
    {
        if(localId < activeThreads)
        {
            float data0 = sharedArray[2 * localId];
            float data1 = sharedArray[2 * localId + 1];

            sharedArray[localId] = (data0 + data1) / sqrt((float)2);
            uint globalPos = midOutPos + groupId * activeThreads + localId;
            coefsSignal[globalPos] = (data0 - data1) / sqrt((float)2);

            midOutPos >>= 1;
        }
        activeThreads >>= 1;
        barrier(CLK_LOCAL_MEM_FENCE);
    }

    /**
     * Write 0th element for the next decomposition
     * steps which are performed on host
     */

     if(0 == localId)
        AverageSignal[groupId] = sharedArray[0];
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
