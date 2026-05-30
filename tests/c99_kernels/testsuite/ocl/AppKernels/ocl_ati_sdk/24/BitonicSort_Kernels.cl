/*
 * For a description of the algorithm and the terms used, please see the
 * documentation for this sample.
 *
 * One invocation of this kernel, i.e one work thread writes two output values.
 * Since every pass of this algorithm does width/2 comparisons, each compare
 * operation is done by one work thread.
 *
 * Depending of the direction of sort for the work thread, the output values
 * are written either as greater value to left element or lesser value to the
 * left element. Right element and left element are the two elements we are
 * comparing and "left" is the element with a smaller index into the array.
 *
 * if direction is CL_TRUE, i.e evaluates to non zero, it means "increasing".
 *
 * For an explanation of the terms "blockWidth", "sameDirectionBlockWidth",
 * stage, pass, pairDistance please go through the document shipped with this
 * sample.
 *
 * Since an explanation of the terms and the code here would be quite lengthy,
 * confusing and will greatly reduce the readability of this kernel, the code
 * has been explained in detail in the document mentioned above.
 */

__kernel
void bitonicSort(__global uint * theArray,
                 const uint stage,
                 const uint passOfStage,
                 const uint width,
                 const uint direction)
{
    uint sortIncreasing = direction;
    uint threadId = get_global_id(0);

    uint pairDistance = 1 << (stage - passOfStage);
    uint blockWidth   = 2 * pairDistance;

    uint leftId = (threadId % pairDistance)
                   + (threadId / pairDistance) * blockWidth;

    uint rightId = leftId + pairDistance;

    uint leftElement = theArray[leftId];
    uint rightElement = theArray[rightId];

    uint sameDirectionBlockWidth = 1 << stage;

    if((threadId/sameDirectionBlockWidth) % 2 == 1)
        sortIncreasing = 1 - sortIncreasing;

    uint greater;
    uint lesser;
    if(leftElement > rightElement)
    {
        greater = leftElement;
        lesser  = rightElement;
    }
    else
    {
        greater = rightElement;
        lesser  = leftElement;
    }

    if(sortIncreasing)
    {
        theArray[leftId]  = lesser;
        theArray[rightId] = greater;
    }
    else
    {
        theArray[leftId]  = greater;
        theArray[rightId] = lesser;
    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
