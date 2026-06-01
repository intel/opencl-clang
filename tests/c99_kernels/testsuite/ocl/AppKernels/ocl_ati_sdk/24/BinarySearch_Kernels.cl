/**
 * One instance of this kernel call is a thread.
 * Each thread finds out the segment in which it should look for the element.
 * After that, it checks if the element is between the lower bound and upper bound
 * of its segment. If yes, then this segment becomes the total searchspace for the next pass.
 *
 * To achieve this, it writes the lower bound and upper bound to the output array.
 * In case the element at the left end (lower bound) matches the element we are looking for,
 * That is marked in the output and we no longer need to look any further.
 */
__kernel void
binarySearch(        __global uint4 * outputArray,
             __const __global uint  * sortedArray,
             const   unsigned int findMe,
             const   unsigned int globalLowerBound,
             const   unsigned int globalUpperBound,
             const   unsigned int subdivSize)
{
    unsigned int tid = get_global_id(0);

    /* lower bound and upper bound are computed from segment and total search space for this pass
     * The total search space is known from global lower and upper bounds for this pass.
     */
    unsigned int lowerBound = globalLowerBound + subdivSize * tid;
    unsigned int upperBound = lowerBound + subdivSize - 1;

    /* Then we find the elements at the two ends of the search space for this thread */
    unsigned int lowerBoundElement = sortedArray[lowerBound];
    unsigned int upperBoundElement = sortedArray[upperBound];

    /* If the element to be found does not lie between them, then nothing left to do in this thread */
    if( (lowerBoundElement > findMe) || (upperBoundElement < findMe))
    {
        return;
    }
    else
    {
        /* However, if the element does lie between the lower and upper bounds of this thread's searchspace
         * we need to narrow down the search further in this search space
         */

        /* The search space for this thread is marked in the output as being the total search space for the next pass */
        outputArray[0].x = lowerBound;
        outputArray[0].y = upperBound;
        outputArray[0].w = 1;

    }
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
