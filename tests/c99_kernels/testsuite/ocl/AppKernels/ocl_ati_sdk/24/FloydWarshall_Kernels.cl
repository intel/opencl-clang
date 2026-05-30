/*!
 * returns the lesser of the two integers a and b
 */
inline
unsigned int uintMin(unsigned int a, unsigned int b)
{
    return (b < a) ? b : a;
}

/*!
 * The floyd Warshall algorithm is a multipass algorithm
 * that calculates the shortest path between each pair of
 * nodes represented by pathDistanceBuffer.
 *
 * In each pass a node k is introduced and the pathDistanceBuffer
 * which has the shortest distance between each pair of nodes
 * considering the (k-1) nodes (that are introduced in the previous
 * passes) is updated such that
 *
 * ShortestPath(x,y,k) = min(ShortestPath(x,y,k-1), ShortestPath(x,k,k-1) + ShortestPath(k,y,k-1))
 * where x and y are the pair of nodes between which the shortest distance
 * is being calculated.
 *
 * pathBuffer stores the intermediate nodes through which the shortest
 * path goes for each pair of nodes.
 *
 * width is the number of nodes in the graph.
 *
 * for more detailed explaination of the algorithm kindly refer to the document
 * provided with the sample
 */

__kernel
void floydWarshallPass(__global unsigned int * pathDistanceBuffer,
                       __global unsigned int * pathBuffer        ,
                       const unsigned int width                  ,
                       const unsigned int pass                   )
{
    unsigned int x = get_local_id(0);
    unsigned int y = get_group_id(0);

    unsigned int k = pass;
    unsigned int yXwidth = y * width;

    unsigned int distanceYtoX = pathDistanceBuffer[yXwidth + x];

    unsigned int distanceYtoK = pathDistanceBuffer[yXwidth + k];
    unsigned int distanceKtoX = pathDistanceBuffer[k*width + x];

    unsigned int indirectDistance = distanceYtoK + distanceKtoX;

    if(indirectDistance < distanceYtoX)
    {
        pathDistanceBuffer[yXwidth + x]    = indirectDistance;
        pathBuffer[yXwidth + x] = k;
    }
    pathDistanceBuffer[yXwidth + x] = uintMin(pathDistanceBuffer[yXwidth + x],
                                                       pathDistanceBuffer[yXwidth + k] + pathDistanceBuffer[k*width + x]);
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
