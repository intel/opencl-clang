/*
 * Calculates the number of eigen values of the tridiagonal symmetric matrix
 * which are less than the value x.
 */
float
calNumEigenValuesLessThan(__global float *diagonal,
                         __global float *offDiagonal,
                         const uint  width,
                         const float x)
{
    uint count = 0;

    float prev_diff = (diagonal[0] - x);
    count += (prev_diff < 0)? 1 : 0;
    for(uint i = 1; i < width; i += 1)
    {
        float diff = (diagonal[i] - x) - ((offDiagonal[i-1] * offDiagonal[i-1])/prev_diff);

        count += (diff < 0)? 1 : 0;
        prev_diff = diff;
    }
    return count;
}

/*
 * The kernel calculates the number of eigenvalues with in an Interval.
 * eigenIntervals have the lowerlimit and the upperlimit of an interval interleaved
 *
 */
__kernel
void calNumEigenValueInterval(__global uint  * numEigenIntervals,
                              __global float * eigenIntervals,
                              __global float * diagonal,
                              __global float * offDiagonal,
                              const     uint     width)
{
    uint threadId  = get_global_id(0);

    uint lowerId   = 2 * threadId;
    uint upperId   = lowerId + 1;

    float lowerLimit = eigenIntervals[lowerId];
    float upperLimit = eigenIntervals[upperId];

    uint numEigenValuesLessThanLowerLimit = calNumEigenValuesLessThan(diagonal, offDiagonal, width, lowerLimit);
    uint numEigenValuesLessThanUpperLimit = calNumEigenValuesLessThan(diagonal, offDiagonal, width, upperLimit);

    numEigenIntervals[threadId] = numEigenValuesLessThanUpperLimit - numEigenValuesLessThanLowerLimit;
}

/*
 * The kernel recalculates the eigenvalue intervals by doing the following things
 * 1. Discards the intervals with no eigenvalues
 * 2. Checks if the number of eigenvalues in an interval is 1 and further splits that
 *    interval into two halfs and considers the interval in which the eigenvalue exists
 * 3. if the number of eigenvalues is more than n i.e. more than 1. The interval is split
 *    into n equal intervals.
 */
__kernel
void recalculateEigenIntervals(__global float * newEigenIntervals,
                               __global float * eigenIntervals,
                               __global uint  * numEigenIntervals,
                               __global float * diagonal,
                               __global float * offDiagonal,
                               const    uint    width,
                               const    float   tolerance)
{
    uint threadId        = get_global_id(0);
    uint currentIndex    = threadId;

    uint lowerId  = 2 * threadId;
    uint upperId  = lowerId + 1;

    uint index = 0;
    while(currentIndex >= numEigenIntervals[index])
    {
        currentIndex -= numEigenIntervals[index];
        ++index;
    }

    uint lId = 2 * index;
    uint uId = lId + 1;

    /* if the number of eigenvalues in the interval is just 1 */
    if(numEigenIntervals[index] == 1)
    {
        float midValue = (eigenIntervals[uId] + eigenIntervals[lId])/2;
        float n        = calNumEigenValuesLessThan(diagonal, offDiagonal, width, midValue) -
                         calNumEigenValuesLessThan(diagonal, offDiagonal, width, eigenIntervals[lId]);

        /* check if the interval size is less than tolerance levels */
        if(eigenIntervals[uId] - eigenIntervals[lId] < tolerance)
        {
            newEigenIntervals[lowerId] = eigenIntervals[lId];
            newEigenIntervals[upperId] = eigenIntervals[uId];
        }
        else if(n == 0) /* if the eigenvalue lies in the right half of the interval */
        {
            newEigenIntervals[lowerId] = midValue;
            newEigenIntervals[upperId] = eigenIntervals[uId];
        }
        else           /* if the eigenvalue lies in the left half of the interval */
        {
            newEigenIntervals[lowerId] = eigenIntervals[lId];
            newEigenIntervals[upperId] = midValue;
        }
    }
    /* split the intervals into equal intervals of size divisionWidth */
    else /* (numEigenIntervals[index] > 1) */
    {
        float divisionWidth = (eigenIntervals[uId] - eigenIntervals[lId])/numEigenIntervals[index];
        newEigenIntervals[lowerId] = eigenIntervals[lId] + divisionWidth*currentIndex;
        newEigenIntervals[upperId] = newEigenIntervals[lowerId] + divisionWidth;

    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
