//The Kernels follows
// Copyright (c) 2013 Adobe Systems Inc. All rights reserved.
////////////////////////////////////////////////////////////////////////////////
// CUDA math functions
#define powf pow
#define expf exp
#define sqrtf sqrt
typedef unsigned short Npp16u;
typedef unsigned char Npp8u;
typedef signed int Npp32s;
typedef unsigned int Npp32u;
typedef float Npp32f;
typedef float energy_type;
// Height datatype
typedef Npp16u height_t;
#define HEIGHT_INF 65535 // MAX_HEIGHT
union edgeFlag_t {
Npp8u warp[4];
Npp32u line;
} ;
enum DIRECTION {LEFT=0, RIGHT, TOP, BOTTOM, TOPLEFT, BOTTOMRIGHT, TOPRIGHT, BOTTOMLEFT};
typedef struct graph_tile_OCL8f {
float terminals[32*32];
float edges[32*32*8];
union edgeFlag_t compressed_edges[32*8]; // need "union" at the beginning, c style
height_t height[32*32];
float border[34*4];
ushort2 pos;
unsigned char label[32*32];
Npp8u padding[92];
} graph_tile_8f;
__constant sampler_t sampler =
CLK_NORMALIZED_COORDS_FALSE |
CLK_ADDRESS_CLAMP_TO_EDGE   |
CLK_FILTER_NEAREST;
__constant int pixT[2] = { 0,-1};
__constant int pixB[2] = { 0, 1};
__constant int pixL[2] = {-1, 0};
__constant int pixR[2] = { 1 ,0};
#define TILE_IDX2(y, x) (35*((y)+1) + ((x)+1))
#define TILE_IDX(y, x) (33*(y) + (x))
typedef float weight_t;
// template
#define nbhd 8
#define PUSH_LENGTH 4
Npp32s zero() {
return 0;
}
Npp32f zerof() {
return 0.0f;
}

__kernel
void MemsetKernel(__global unsigned int* pData, unsigned int nValue, int nSizeInInt) {
int idx = get_global_id(0);
if( idx < nSizeInInt ) {
pData[idx] = nValue;
}
}
void readTileWithApronIntoSMEM_tileBased(__local int* s_H, const __global unsigned char* g_H, int step,
int boundary, int width, int height, const int elementsPerThread,
const int startX, const int startY, const int validW, const int validH)
{
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
int2 blockIdx = (int2)(get_group_id(0), get_group_id(1));
const Npp32s local_x = threadIdx.x;
const Npp32s local_y = threadIdx.y * elementsPerThread;
int global_x = blockIdx.x * 32;
int global_y = blockIdx.y * 32;
// Main Block
for( Npp32s k=0; k<elementsPerThread; ++ k ) {
//whole if( global_y+local_y+k < height && global_x+local_x < width )
if( global_y+local_y+k < validH && global_x+local_x < validW )
s_H[TILE_IDX2(local_y+k,local_x)] = g_H[(global_y+local_y+k) * step + global_x+local_x];
else
s_H[TILE_IDX2(local_y+k,local_x)] = boundary;
}
// Apron
// absolute x,y coordinates
int image_x = global_x + startX;
int image_y = global_y + startY;
switch( threadIdx.y ) {
case 0 : {
// Top
//whole if( global_y-1 >= 0 && global_x+ threadIdx.x < width )
if( image_y-1 >= 0 && image_x+ threadIdx.x < width )
s_H[TILE_IDX2(-1,threadIdx.x)] = g_H[(global_y-1) * step + global_x+ threadIdx.x];
else
s_H[TILE_IDX2(-1,threadIdx.x)] = boundary;
// Topleft
//whole if( global_y-1 >= 0 && global_x-1 >= 0 )
if( image_y-1 >= 0 && image_x-1 >= 0 )
s_H[TILE_IDX2(-1,-1)] = g_H[(global_y-1) * step + global_x-1];
else
s_H[TILE_IDX2(-1,-1)] = boundary;
// Topright
//whole if( global_y-1 >= 0 && global_x+32 < width )
if( image_y-1 >= 0 && image_x+32 < width )
s_H[TILE_IDX2(-1,32)] = g_H[(global_y-1) * step + global_x+32];
else
s_H[TILE_IDX2(-1,32)] = boundary;
break;
}
case 1 : {
// Bottom
//whole if( global_y+32 < height && global_x+ threadIdx.x < width )
if( image_y+32 < height && image_x+ threadIdx.x < width )
s_H[TILE_IDX2(32,threadIdx.x)] = g_H[(global_y+32) * step + global_x+ threadIdx.x];
else
s_H[TILE_IDX2(32,threadIdx.x)] = boundary;
// Bottomleft
//whole if( global_y+32 < height && global_x-1 >= 0 )
if( image_y+32 < height && image_x-1 >= 0 )
s_H[TILE_IDX2(32,-1)] = g_H[(global_y+32) * step + global_x-1];
else
s_H[TILE_IDX2(32,-1)] = boundary;
// bottomright
//whole if( global_y+32 < height && global_x+32 < width )
if( image_y+32 < height && image_x+32 < width )
s_H[TILE_IDX2(32,32)] = g_H[(global_y+32) * step + global_x+32];
else
s_H[TILE_IDX2(32,32)] = boundary;
break;
}
case 2 : {
// Left
//whole if( global_y+threadIdx.x < height && global_x -1 >= 0 )
if( image_y+threadIdx.x < height && image_x -1 >= 0 )
s_H[TILE_IDX2(threadIdx.x, -1)] = g_H[(global_y+threadIdx.x) * step + global_x - 1];
else
s_H[TILE_IDX2(threadIdx.x, -1)] = boundary;
break;
}
case 3 : {
// Right
//whole if( global_y+threadIdx.x < height && global_x + 32 < width )
if( image_y+threadIdx.x < height && image_x + 32 < width )
s_H[TILE_IDX2(threadIdx.x, 32)] = g_H[(global_y+threadIdx.x) * step + global_x + 32];
else
s_H[TILE_IDX2(threadIdx.x, 32)] = boundary;
break;
}
}
}
void readTileWithApronIntoSMEM_oneBufBased(__local int* s_H, const __global unsigned char* g_H, int step,
int boundary, int width, int height, const int elementsPerThread,
const int startX, const int startY, const int validW, const int validH)
{
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
int2 blockIdx = (int2)(get_group_id(0), get_group_id(1));
const Npp32s local_x = threadIdx.x;
const Npp32s local_y = threadIdx.y * elementsPerThread;
//OneBig	int global_x = blockIdx.x * 32;
//OneBig	int global_y = blockIdx.y * 32;
// Main Block
for( Npp32s k=0; k<elementsPerThread; ++ k ) {
//whole if( global_y+local_y+k < height && global_x+local_x < width )
//OneBig		if( global_y+local_y+k < validH && global_x+local_x < validW )
//OneBig			s_H[TILE_IDX2(local_y+k,local_x)] = g_H[(global_y+local_y+k) * step + global_x+local_x];
if( startY+local_y+k < height && startX+local_x < width )
s_H[TILE_IDX2(local_y+k,local_x)] = g_H[(local_y+k) * step + local_x];
else
s_H[TILE_IDX2(local_y+k,local_x)] = boundary;
}
// Apron
// absolute x,y coordinates
//OneBig	int image_x = global_x + startX;
//OneBig	int image_y = global_y + startY;
int image_x = startX;
int image_y = startY;
//OneBig
int global_x = 0; // so we don't need to change the following s_H...
int global_y = 0;
switch( threadIdx.y ) {
case 0 : {
// Top
//whole if( global_y-1 >= 0 && global_x+ threadIdx.x < width )
if( image_y-1 >= 0 && image_x+ threadIdx.x < width )
s_H[TILE_IDX2(-1,threadIdx.x)] = g_H[(global_y-1) * step + global_x+ threadIdx.x];
else
s_H[TILE_IDX2(-1,threadIdx.x)] = boundary;
// Topleft
//whole if( global_y-1 >= 0 && global_x-1 >= 0 )
if( image_y-1 >= 0 && image_x-1 >= 0 )
s_H[TILE_IDX2(-1,-1)] = g_H[(global_y-1) * step + global_x-1];
else
s_H[TILE_IDX2(-1,-1)] = boundary;
// Topright
//whole if( global_y-1 >= 0 && global_x+32 < width )
if( image_y-1 >= 0 && image_x+32 < width )
s_H[TILE_IDX2(-1,32)] = g_H[(global_y-1) * step + global_x+32];
else
s_H[TILE_IDX2(-1,32)] = boundary;
break;
}
case 1 : {
// Bottom
//whole if( global_y+32 < height && global_x+ threadIdx.x < width )
if( image_y+32 < height && image_x+ threadIdx.x < width )
s_H[TILE_IDX2(32,threadIdx.x)] = g_H[(global_y+32) * step + global_x+ threadIdx.x];
else
s_H[TILE_IDX2(32,threadIdx.x)] = boundary;
// Bottomleft
//whole if( global_y+32 < height && global_x-1 >= 0 )
if( image_y+32 < height && image_x-1 >= 0 )
s_H[TILE_IDX2(32,-1)] = g_H[(global_y+32) * step + global_x-1];
else
s_H[TILE_IDX2(32,-1)] = boundary;
// bottomright
//whole if( global_y+32 < height && global_x+32 < width )
if( image_y+32 < height && image_x+32 < width )
s_H[TILE_IDX2(32,32)] = g_H[(global_y+32) * step + global_x+32];
else
s_H[TILE_IDX2(32,32)] = boundary;
break;
}
case 2 : {
// Left
//whole if( global_y+threadIdx.x < height && global_x -1 >= 0 )
if( image_y+threadIdx.x < height && image_x -1 >= 0 )
s_H[TILE_IDX2(threadIdx.x, -1)] = g_H[(global_y+threadIdx.x) * step + global_x - 1];
else
s_H[TILE_IDX2(threadIdx.x, -1)] = boundary;
break;
}
case 3 : {
// Right
//whole if( global_y+threadIdx.x < height && global_x + 32 < width )
if( image_y+threadIdx.x < height && image_x + 32 < width )
s_H[TILE_IDX2(threadIdx.x, 32)] = g_H[(global_y+threadIdx.x) * step + global_x + 32];
else
s_H[TILE_IDX2(threadIdx.x, 32)] = boundary;
break;
}
}
}
// tiled version

__kernel void GraphcutRefineEdge_setupLayout(
__global Npp32s* graph_active_tile_count,
__global Npp32s* graph_layout,
const Npp32s graph_tileWidth,
const __global unsigned char* g_M,
const int step,
const int width,
const int height,
const int startX,
const int startY,
const int validW,
const int validH
)
{
__local int active;
active = 0;
barrier(CLK_LOCAL_MEM_FENCE);
const int elementsProcessedPerThread = 4;
int global_x = get_group_id(0) * 32;
int global_y = get_group_id(1) * 32;
int local_x = get_local_id(0);
int local_y = get_local_id(1) * elementsProcessedPerThread;
for( int i=0; i < 4; ++i ) {
//whole if( global_x + local_x < width && global_y + local_y < height ) {
if( global_x + local_x < validW && global_y + local_y < validH ) {
if( g_M[(global_y + local_y) * step + global_x + local_x] > 128 ) {
active = 1;
}
}
++local_y;
}
barrier(CLK_LOCAL_MEM_FENCE); // wait for active
if( active ) {
if( get_local_id(0) + get_local_id(1) == 0 ) {
int idx = atomic_inc( graph_active_tile_count );
//whole graph_layout[get_group_id(1) * graph_tileWidth + get_group_id(0)] = idx;
graph_layout[((global_y+startY)/32) * graph_tileWidth + (global_x+startX)/32] = idx;
}
}
}
float interactionEnergy(float3 sRGB, const __global unsigned char* sR, const __global unsigned char* sG, const __global unsigned char* sB, int neighborIndex, float neighborEnergyStrength, float colorSensitivity, float colorPower, float inverseDistance)
{
const float dR = sRGB.x - (float)sR[neighborIndex];
const float dG = sRGB.y - (float)sG[neighborIndex];
const float dB = sRGB.z - (float)sB[neighborIndex];
const float colorDistance = powf(colorSensitivity * (dR*dR + dG*dG + dB*dB), colorPower);
const energy_type interactionEnergy = (energy_type)(neighborEnergyStrength * expf(-colorDistance) * inverseDistance);
return interactionEnergy;
}
// tiled version

__kernel void GraphcutRefineEdge_setupCapacities(
const __global Npp32s* graph_layout,
const Npp32s graph_tileWidth,
__global graph_tile_8f* graph_tiles,
__global unsigned char* sR_1_1,
__global unsigned char* sG_1_1,
__global unsigned char* sB_1_1,
const int sRowBytes,
const float neighborEnergyStrength,
const float colorSensitivity,
const float colorPower,
const float frozenEnergy,
const __global unsigned char* F,
const __global unsigned char* B,
const __global unsigned char* mask,
const int m_step,
const __global unsigned char* g_BorderRegion,
const int width,
const int height,
const int border_step,
const int startX,
const int startY,
const int validW,
const int validH
)
{
int2 blockIdx = (int2)(get_group_id(0), get_group_id(1));
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
int global_x = blockIdx.x * 32;
int global_y = blockIdx.y * 32;
//whole int tile_idx = graph_layout[blockIdx.y * graph_tileWidth + blockIdx.x];
int tile_idx = graph_layout[(startY/32 + blockIdx.y) * graph_tileWidth + startX/32 + blockIdx.x];
// Early exit if tile is empty
if( tile_idx < 0 ) return;
__local int s_M[34*35];
// Load Border Graph Tile to SMEM
const Npp32s elementsPerThread = 4;
//whole readTileWithApronIntoSMEM( s_M, g_BorderRegion, m_step, 128, width, height, elementsPerThread);
readTileWithApronIntoSMEM_tileBased( s_M, (g_BorderRegion+border_step+1), border_step, 128, width, height, elementsPerThread,
startX, startY, validW, validH);
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[tile_idx];
//tile->pos = make_ushort2(blockIdx.x, blockIdx.y);
//whole tile->pos = (ushort2)(blockIdx.x, blockIdx.y);
tile->pos = (ushort2)(((startX/32)+blockIdx.x), ((startY/32)+blockIdx.y));
int local_x = threadIdx.x;
int local_y = threadIdx.y * 4;
for( int k=0; k < 4; ++k ) {
//whole if( global_x + local_x < width && global_y + local_y + k < height ) {
if( global_x + local_x < validW && global_y + local_y + k < validH ) {
int s = mask[(global_y + local_y + k) * m_step + global_x + local_x];
int h = s_M[TILE_IDX2(local_y+k,local_x)];
bool isBoundary = false;
if( h > 200 ) {
// Pixel is part of the border graph
int index = (global_y + local_y + k) * sRowBytes + global_x + local_x;
__global unsigned char* sR = sR_1_1 + sRowBytes + 1;
__global unsigned char* sG = sG_1_1 + sRowBytes + 1;
__global unsigned char* sB = sB_1_1 + sRowBytes + 1;
float3 center = (float3)(
sR[index],
sG[index],
sB[index]
);
// Left
if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 255 ) {
tile->edges[32*32*LEFT+local_x*32+local_y+k] = interactionEnergy(center, sR, sG, sB, index - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// RIGHT
if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 255 ){
tile->edges[32*32*RIGHT+local_x*32+local_y+k] = interactionEnergy(center, sR, sG, sB, index + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP LEFT
if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 255 ) {
tile->edges[32*32*TOPLEFT+(local_y+k)*32+local_x] = interactionEnergy(center, sR, sG, sB, index - sRowBytes - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM LEFT
if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 255 ) {
tile->edges[32*32*BOTTOMLEFT+(local_y+k)*32+local_x] = interactionEnergy(center, sR, sG, sB, index + sRowBytes - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// TOP RIGHT
if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 255 ) {
tile->edges[32*32*TOPRIGHT+(local_y+k)*32+local_x] = interactionEnergy(center, sR, sG, sB, index - sRowBytes + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM RIGHT
if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 255 ) {
tile->edges[32*32*BOTTOMRIGHT+(local_y+k)*32+local_x] = interactionEnergy(center, sR, sG, sB, index + sRowBytes + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM
if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 255 ) {
tile->edges[32*32*BOTTOM+(local_y+k)*32+local_x] = interactionEnergy(center, sR, sG, sB, index + sRowBytes, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP
if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 255 ) {
tile->edges[32*32*TOP+(local_y+k)*32+local_x] = interactionEnergy(center, sR, sG, sB, index - sRowBytes, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// Terminal Energies
if( isBoundary ) {
float sign = s > 128 ? -1.0f : 1.0f;
tile->terminals[(local_y+k) * 32 + local_x]	= sign * frozenEnergy;
}
if( F[(global_y + local_y + k) * m_step + global_x + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = -frozenEnergy;
if( B[(global_y + local_y+k) * m_step + global_x + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = frozenEnergy;
}
}
}
}

__kernel void GraphcutRefineEdge_setupOneBufCapacities(
const __global Npp32s* graph_layout,
const Npp32s graph_tileWidth,
__global graph_tile_8f* graph_tiles,
const __global unsigned char* sR_1_1,
const __global unsigned char* sG_1_1,
const __global unsigned char* sB_1_1,
const int sRowBytes,
const float neighborEnergyStrength,
const float colorSensitivity,
const float colorPower,
const float frozenEnergy,
const __global unsigned char* F,
const __global unsigned char* B,
const __global unsigned char* mask,
const int m_step,
const __global unsigned char* g_BorderRegion,
const int width,
const int height,
const int border_step,
const int startX,
const int startY,
const int validW,
const int validH,
const __global int* posIdx,
const __global int* posX,
const __global int* posY,
const int NopdBufSize,
const int BorPaddBufSize,
const int SrcPaddBufSize
)
{
int2 blockIdx = (int2)(get_group_id(0), get_group_id(1));
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
//OneBig	//int global_x = blockIdx.x * 32;
//OneBig	//int global_y = blockIdx.y * 32;
int global_x = posX[blockIdx.x]; //abs coord
int global_y = posY[blockIdx.x];
//whole int tile_idx = graph_layout[blockIdx.y * graph_tileWidth + blockIdx.x];
//OneBig	//int tile_idx = graph_layout[(startY/32 + blockIdx.y) * graph_tileWidth + startX/32 + blockIdx.x];
int tile_idx = posIdx[blockIdx.x];
// Early exit if tile is empty
if( tile_idx < 0 ) return;
__local int s_M[34*35];
// Load Border Graph Tile to SMEM
const Npp32s elementsPerThread = 4;
//whole readTileWithApronIntoSMEM( s_M, g_BorderRegion, m_step, 128, width, height, elementsPerThread);
//OneBig	readTileWithApronIntoSMEM_tileBased( s_M, (g_BorderRegion+border_step+1), border_step, 128, width, height, elementsPerThread,
//OneBig		startX, startY, validW, validH);
readTileWithApronIntoSMEM_oneBufBased( s_M, (g_BorderRegion+(blockIdx.x*BorPaddBufSize)+border_step+1), border_step, 128, width, height, elementsPerThread,
global_x, global_y, validW, validH);
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[tile_idx];
//tile->pos = make_ushort2(blockIdx.x, blockIdx.y);
//whole tile->pos = (ushort2)(blockIdx.x, blockIdx.y);
//OneBig	tile->pos = (ushort2)(((startX/32)+blockIdx.x), ((startY/32)+blockIdx.y));
tile->pos = (ushort2)(global_x/32, global_y/32);
int local_x = threadIdx.x;
int local_y = threadIdx.y * 4;
for( int k=0; k < 4; ++k ) {
//whole if( global_x + local_x < width && global_y + local_y + k < height ) {
//OneBig		if( global_x + local_x < validW && global_y + local_y + k < validH ) {
if( global_x + local_x < width && global_y + local_y + k < height ) {
//OneBig			int s = mask[(global_y + local_y + k) * m_step + global_x + local_x];
int s = mask[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x];
int h = s_M[TILE_IDX2(local_y+k,local_x)];
bool isBoundary = false;
if( h > 200 ) {
// Pixel is part of the border graph
//OneBig				int index = (global_y + local_y + k) * sRowBytes + global_x + local_x;
int index = blockIdx.x*SrcPaddBufSize + (local_y + k) * sRowBytes + local_x;
__global unsigned char* sR = sR_1_1 + sRowBytes + 1;
__global unsigned char* sG = sG_1_1 + sRowBytes + 1;
__global unsigned char* sB = sB_1_1 + sRowBytes + 1;
float3 center = (float3)(
sR[index],
sG[index],
sB[index]
);
// Left
if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 255 ) {
tile->edges[32*32*LEFT+local_x*32+local_y+k] = interactionEnergy(center, sR, sG, sB, index - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// RIGHT
if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 255 ){
tile->edges[32*32*RIGHT+local_x*32+local_y+k] = interactionEnergy(center, sR, sG, sB, index + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP LEFT
if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 255 ) {
tile->edges[32*32*TOPLEFT+(local_y+k)*32+local_x] = interactionEnergy(center, sR, sG, sB, index - sRowBytes - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM LEFT
if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 255 ) {
tile->edges[32*32*BOTTOMLEFT+(local_y+k)*32+local_x] = interactionEnergy(center, sR, sG, sB, index + sRowBytes - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// TOP RIGHT
if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 255 ) {
tile->edges[32*32*TOPRIGHT+(local_y+k)*32+local_x] = interactionEnergy(center, sR, sG, sB, index - sRowBytes + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM RIGHT
if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 255 ) {
tile->edges[32*32*BOTTOMRIGHT+(local_y+k)*32+local_x] = interactionEnergy(center, sR, sG, sB, index + sRowBytes + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM
if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 255 ) {
tile->edges[32*32*BOTTOM+(local_y+k)*32+local_x] = interactionEnergy(center, sR, sG, sB, index + sRowBytes, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP
if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 255 ) {
tile->edges[32*32*TOP+(local_y+k)*32+local_x] = interactionEnergy(center, sR, sG, sB, index - sRowBytes, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// Terminal Energies
if( isBoundary ) {
float sign = s > 128 ? -1.0f : 1.0f;
tile->terminals[(local_y+k) * 32 + local_x]	= sign * frozenEnergy;
}
//OneBig				if( F[(global_y + local_y + k) * m_step + global_x + local_x] > 128 )
if( F[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = -frozenEnergy;
//OneBig				if( B[(global_y + local_y+k) * m_step + global_x + local_x] > 128 )
if( B[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = frozenEnergy;
}
}
}
}

__kernel void GraphcutRefineEdgeCopyLabel(
__global graph_tile_8f* graph_tiles,
__global unsigned char* M,
const int step
)
{
__global graph_tile_8f* tile = &graph_tiles[get_group_id(0)];
ushort2 pos = tile->pos;
int global_x = pos.x * 32;
int global_y = pos.y * 32;
int local_x = get_local_id(0);
int local_y = get_local_id(1) * 4;
for( int i=0; i < 4; ++i) {
int l = tile->label[local_y * 32+ local_x];
if( l < 2 ) {
M[(global_y + local_y) * step + global_x + local_x] = (l == 0) ? 255 : 0;
}
// testing... some labels are still 2 (UNKNOWN) //ocl//
//else
//	M[(global_y + local_y) * step + global_x + local_x] = 128;
++local_y;
}
}
//
// combined from OCLSparseKernels.cl
//
#ifdef NVIDIA
inline void AtomicAdd(volatile __global float *source, const float operand) {
asm("red.global.add.f32 [%0], %1;" :: "r"(source) , "f"(operand));
}
#else
// using atomic... for floating
inline void AtomicAdd(volatile __global float *source, const float operand) {
union {
unsigned int intVal;
float floatVal;
} newVal;
union {
unsigned int intVal;
float floatVal;
} prevVal;
do {
prevVal.floatVal = *source;
newVal.floatVal = prevVal.floatVal + operand;
} while (atomic_cmpxchg((volatile __global unsigned int *)source, prevVal.intVal, newVal.intVal) != prevVal.intVal);
}
#endif

__kernel
void _clearKernel(__global int* pData, int nSizeInInt) {
int idx = get_global_id(0);
if( idx < nSizeInInt ) {
pData[idx] = 0;
}
}
//void push_tile(__global graph_tile_8f** graph_active_tiles, __global Npp32s* graph_active_tile_count, __global graph_tile_8f* tile)
// if we get tile_indexes, actually we don't need tile
void push_tile(__global Npp32s* graph_active_tile_indexes, __global Npp32s* graph_active_tile_count, __global graph_tile_8f* tile)
{
int idx = atomic_inc(graph_active_tile_count);
//graph_active_tiles[idx] = tile;
graph_active_tile_indexes[idx] = get_group_id(0);
}
// Block 32x8

__kernel void _findPushTiles(
__global graph_tile_8f* graph_tiles,
__global Npp32s* graph_active_tile_count,
__global Npp32s* graph_active_tile_indexes
)
{
__local volatile Npp32s s_active;
s_active = 0;
barrier(CLK_LOCAL_MEM_FENCE);
Npp32s active = 0;
__global graph_tile_8f* tile = &graph_tiles[get_group_id(0)];
Npp32s x = get_local_id(0);
Npp32s y = get_local_id(1);
for( Npp32s k=0; k < 4; ++k ) {
weight_t excess_flow = tile->terminals[y * 32 + x];
active += (tile->height[y * 32 + x] < HEIGHT_INF) && (excess_flow > zerof());
y += 8;
}
if( active > 0 ) s_active = 1;
barrier(CLK_LOCAL_MEM_FENCE);
if(  s_active > 0 ) {
if( get_local_id(0) + get_local_id(1) == 0 ) {
push_tile(graph_active_tile_indexes, graph_active_tile_count, tile);
}
}
}
void readHeightTileWithApronIntoSMEM(const Npp32s graph_tileWidth, const Npp32s graph_tileHeight, __global Npp32s* graph_layout, __global graph_tile_8f* graph_tiles, __global graph_tile_8f* tile, __local Npp32s* s_H, const int elementsPerThread)
{
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
const Npp32s local_x = threadIdx.x;
const Npp32s local_y = threadIdx.y * elementsPerThread;
ushort2 pos = tile->pos;
int tile_x = pos.x;
int tile_y = pos.y;
int layoutIdx = tile_y * graph_tileWidth + tile_x;
// Main Block
for( Npp32s k=0; k<elementsPerThread; ++ k ) {
s_H[TILE_IDX2(local_y+k,local_x)] = tile->height[(local_y+k) * 32 + local_x];
}
// Apron
switch( threadIdx.y ) {
case 0 : {
// Top
if( tile_y > 0 ) {
int topLayoutIdx = layoutIdx - graph_tileWidth;
int topTileIdx = graph_layout[topLayoutIdx];
if( topTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* topTile = &graph_tiles[topTileIdx];
// Read row 31
s_H[TILE_IDX2(-1,threadIdx.x)] = topTile->height[31*32 + threadIdx.x];
}
if( nbhd == 8 ) {
if( tile_x > 0 ) {
int topLeftTileIdx = graph_layout[topLayoutIdx - 1];
if( topLeftTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* topLeftTile = &graph_tiles[topLeftTileIdx];
// Read element 31,31
s_H[TILE_IDX2(-1,-1)] = topLeftTile->height[31*32 + 31];
}
}
if( tile_x < graph_tileWidth - 1 ) {
int topRightTileIdx = graph_layout[topLayoutIdx + 1];
if( topRightTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* topRightTile = &graph_tiles[topRightTileIdx];
// Read element 0,31
s_H[TILE_IDX2(-1,32)] = topRightTile->height[31*32 + 0];
}
}
}
}
break;
}
case 1 : {
// Bottom
if( tile_y < graph_tileHeight - 1 ) {
int bottomLayoutIdx = layoutIdx + graph_tileWidth;
int bottomTileIdx = graph_layout[bottomLayoutIdx];
if( bottomTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* bottomTile = &graph_tiles[bottomTileIdx];
// Read row 0
s_H[TILE_IDX2(32,threadIdx.x)] = bottomTile->height[threadIdx.x];
}
if( nbhd == 8 ) {
if( tile_x > 0 ) {
int bottomLeftTileIdx = graph_layout[bottomLayoutIdx - 1];
if( bottomLeftTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* bottomLeftTile = &graph_tiles[bottomLeftTileIdx];
// Read element 31,0
s_H[TILE_IDX2(32,-1)] = bottomLeftTile->height[31];
}
}
if( tile_x < graph_tileWidth - 1 ) {
int bottomRightTileIdx = graph_layout[bottomLayoutIdx + 1];
if( bottomRightTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* bottomRightTile = &graph_tiles[bottomRightTileIdx];
// Read element 0,0
s_H[TILE_IDX2(32,32)] = bottomRightTile->height[0];
}
}
}
}
break;
}
case 2 : {
// Left
if( tile_x > 0 ) {
int leftLayoutIdx = layoutIdx - 1;
int leftTileIdx = graph_layout[leftLayoutIdx];
if( leftTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* leftTile = &graph_tiles[leftTileIdx];
// Read column 31
s_H[TILE_IDX2(threadIdx.x,-1)] = leftTile->height[threadIdx.x * 32 + 31];
}
}
break;
}
case 3 : {
// Right
if( tile_x < graph_tileWidth - 1 ) {
int rightLayoutIdx = layoutIdx + 1;
int rightTileIdx = graph_layout[rightLayoutIdx];
if( rightTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* rightTile = &graph_tiles[rightTileIdx];
// Read column 0
s_H[TILE_IDX2(threadIdx.x,32)] = rightTile->height[threadIdx.x * 32];
}
}
break;
}
}
}
void readLabelTileWithApronIntoSMEM(const Npp32s graph_tileWidth, const Npp32s graph_tileHeight, __global Npp32s* graph_layout, __global graph_tile_8f* graph_tiles, __global graph_tile_8f* tile, __local Npp32s* s_L, const int elementsPerThread)
{
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
const Npp32s local_x = threadIdx.x;
const Npp32s local_y = threadIdx.y * elementsPerThread;
ushort2 pos = tile->pos;
int tile_x = pos.x;
int tile_y = pos.y;
int layoutIdx = tile_y * graph_tileWidth + tile_x;
// Main Block
for( Npp32s k=0; k<elementsPerThread; ++ k ) {
s_L[TILE_IDX2(local_y+k,local_x)] = tile->label[(local_y+k) * 32 + local_x];
}
// Apron
switch( threadIdx.y ) {
case 0 : {
// Top
if( tile_y > 0 ) {
int topLayoutIdx = layoutIdx - graph_tileWidth;
int topTileIdx = graph_layout[topLayoutIdx];
if( topTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* topTile = &graph_tiles[topTileIdx];
// Read row 31
s_L[TILE_IDX2(-1,threadIdx.x)] = topTile->label[31*32 + threadIdx.x];
}
if( nbhd == 8 ) {
if( tile_x > 0 ) {
int topLeftTileIdx = graph_layout[topLayoutIdx - 1];
if( topLeftTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* topLeftTile = &graph_tiles[topLeftTileIdx];
// Read element 31,31
s_L[TILE_IDX2(-1,-1)] = topLeftTile->label[31*32 + 31];
}
}
if( tile_x < graph_tileWidth - 1 ) {
int topRightTileIdx = graph_layout[topLayoutIdx + 1];
if( topRightTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* topRightTile = &graph_tiles[topRightTileIdx];
// Read element 0,31
s_L[TILE_IDX2(-1,32)] = topRightTile->label[31*32 + 0];
}
}
}
}
break;
}
case 1 : {
// Bottom
if( tile_y < graph_tileHeight - 1 ) {
int bottomLayoutIdx = layoutIdx + graph_tileWidth;
int bottomTileIdx = graph_layout[bottomLayoutIdx];
if( bottomTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* bottomTile = &graph_tiles[bottomTileIdx];
// Read row 0
s_L[TILE_IDX2(32,threadIdx.x)] = bottomTile->label[threadIdx.x];
}
if( nbhd == 8 ) {
if( tile_x > 0 ) {
int bottomLeftTileIdx = graph_layout[bottomLayoutIdx - 1];
if( bottomLeftTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* bottomLeftTile = &graph_tiles[bottomLeftTileIdx];
// Read element 31,0
s_L[TILE_IDX2(32,-1)] = bottomLeftTile->label[31];
}
}
if( tile_x < graph_tileWidth - 1 ) {
int bottomRightTileIdx = graph_layout[bottomLayoutIdx + 1];
if( bottomRightTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* bottomRightTile = &graph_tiles[bottomRightTileIdx];
// Read element 0,0
s_L[TILE_IDX2(32,32)] = bottomRightTile->label[0];
}
}
}
}
break;
}
case 2 : {
// Left
if( tile_x > 0 ) {
int leftLayoutIdx = layoutIdx - 1;
int leftTileIdx = graph_layout[leftLayoutIdx];
if( leftTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* leftTile = &graph_tiles[leftTileIdx];
// Read column 31
s_L[TILE_IDX2(threadIdx.x,-1)] = leftTile->label[threadIdx.x * 32 + 31];
}
}
break;
}
case 3 : {
// Right
if( tile_x < graph_tileWidth - 1 ) {
int rightLayoutIdx = layoutIdx + 1;
int rightTileIdx = graph_layout[rightLayoutIdx];
if( rightTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* rightTile = &graph_tiles[rightTileIdx];
// Read column 0
s_L[TILE_IDX2(threadIdx.x,32)] = rightTile->label[threadIdx.x * 32];
}
}
break;
}
}
}
// Warps push flow PUSH_LENGTH times per thread. First forward, then PUSH_LENGTH times backward
// Height condition gets stored in bitvector during forward direction, reused during backward direction
void push_horizontal(__global graph_tile_8f* graph_tiles, const Npp32s graph_tileWidth, __global Npp32s* graph_layout, __global graph_tile_8f* tile, __local weight_t* s_E, __local Npp32s* s_H, __local weight_t* s_border) {
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
Npp32u rev_dir;
Npp32s cur_height, next_height;
weight_t flow;
Npp32s local_x, local_y;
local_x = threadIdx.y * PUSH_LENGTH;
local_y = threadIdx.x;
flow = zerof();
cur_height = s_H[TILE_IDX2(local_y, local_x)];
rev_dir = cur_height - s_H[TILE_IDX2(local_y, local_x-1)] == 1 ? 1 : 0;
// Push right
for( Npp32s k=0; k < PUSH_LENGTH; ++k ) {
next_height = s_H[TILE_IDX2(local_y, local_x+1)];
weight_t edge = tile->edges[32*32*RIGHT+local_x*32 + local_y];
weight_t excess = s_E[TILE_IDX(local_y,local_x)] + flow;
flow = min(excess , edge);
Npp32s height_diff = cur_height - next_height;
if(  height_diff !=  + 1 )
flow = zerof();
if( height_diff == -1 )
rev_dir |= 1 << (k+1);
s_E[TILE_IDX(local_y,local_x)] = excess - flow;
if( flow > zerof() ) {
edge -= flow;
tile->edges[32*32*RIGHT+local_x*32 + local_y] = edge;
if( local_x < 31 ) {
// inside tile
tile->edges[32*32*LEFT+(local_x+1)*32 + local_y] += flow;
} else {
// right tile
ushort2 pos = tile->pos;
int rightTileIdx = graph_layout[pos.y * graph_tileWidth + pos.x + 1];
__global graph_tile_8f* rightTile = &graph_tiles[rightTileIdx];
rightTile->edges[32*32*LEFT+local_y] += flow;
}
}
local_x += 1;
cur_height = next_height;
}
barrier(CLK_LOCAL_MEM_FENCE);
#if 0
// org, works for NVIDIA and Intel and AMD on win
if( local_x < 32 ) {
// 2 smem
s_E[TILE_IDX(local_y,local_x)] += flow;
} else {
// 2 smem
s_border[34*RIGHT+ local_y + 1] += flow;
}
#else
// need this for AMD on mac
if( local_x < 32 ) {
// 2 smem
s_E[TILE_IDX(local_y,local_x)] += flow;
}
if (local_x >= 32) {
// 2 smem
s_border[34*RIGHT+ local_y + 1] += flow;
}
#endif
barrier(CLK_LOCAL_MEM_FENCE);
// Reverse direction
// Push left
local_x -= 1;
flow = 0;
for( Npp32s k=PUSH_LENGTH-1; k >=0; --k ) {
weight_t edge = tile->edges[32*32*LEFT+local_x*32 + local_y];
weight_t excess = s_E[TILE_IDX(local_y,local_x)] + flow;
flow = min(excess , edge);
if( (rev_dir & (1 << k)) == 0 )
flow = zerof();
s_E[TILE_IDX(local_y,local_x)] = excess - flow;
if( flow > zerof() ) {
edge -= flow;
tile->edges[32*32*LEFT+local_x*32 + local_y] = edge;
if( local_x > 0 ) {
// inside tile
tile->edges[32*32*RIGHT+(local_x-1)*32 + local_y] += flow;
} else {
// left tile
ushort2 pos = tile->pos;
int leftTileIdx = graph_layout[pos.y * graph_tileWidth + pos.x - 1];
__global graph_tile_8f* leftTile = &graph_tiles[leftTileIdx];
leftTile->edges[32*32*RIGHT+31*32+local_y] += flow;
}
}
local_x -= 1;
}
barrier(CLK_LOCAL_MEM_FENCE);
#if 0
// org, works for NVIDIA and Intel and AMD on win
if( local_x >= 0 ) {
// 2 smem
s_E[TILE_IDX(local_y,local_x)] += flow;
} else {
// 2 smem
s_border[34*LEFT + local_y + 1] += flow;
}
#else
// need this for AMD on mac
if( local_x >= 0 ) {
// 2 smem
s_E[TILE_IDX(local_y,local_x)] += flow;
}
if (local_x < 0) {
// 2 smem
s_border[34*LEFT + local_y + 1] += flow;
}
#endif
}
void push_vertical(__global graph_tile_8f* graph_tiles, const Npp32s graph_tileWidth, __global Npp32s* graph_layout, __global graph_tile_8f* tile, __local weight_t* s_E, __local Npp32s* s_H, __local weight_t* s_border, int dir, int dx) {
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
Npp32u rev_dir;
Npp32s cur_height, next_height;
const int forward_edge = 32*32*(dir+1);
const int backward_edge = 32*32*(dir);
weight_t flow;
Npp32s local_x, local_y;
local_x = threadIdx.x;
local_y = threadIdx.y * PUSH_LENGTH;
ushort2 pos = tile->pos;
flow = zerof();
cur_height = s_H[TILE_IDX2(local_y, local_x)];
rev_dir = cur_height - s_H[TILE_IDX2(local_y-1, local_x-dx)] == 1 ? 1 : 0;
for( Npp32s k=0; k < PUSH_LENGTH; ++k ) {
next_height = s_H[TILE_IDX2(local_y+1, local_x+dx)];
weight_t edge = tile->edges[forward_edge+local_y*32 + local_x];
weight_t excess = s_E[TILE_IDX(local_y,local_x)] + flow;
flow = min(excess, edge);
Npp32s height_diff = cur_height - next_height;
if(  height_diff !=  + 1 )
flow = zerof();
s_E[TILE_IDX(local_y,local_x)] = excess - flow;
if( flow > zerof() ) {
// 1 gmem in & 2 gmem out
edge -= flow;
tile->edges[forward_edge+local_y*32 + local_x] = edge;
int nb_tile_y_offset = (local_y+1) / 32;
int nb_tile_x_offset = (local_x + dx + 32) / 32 - 1;
int nb_tile_y_index = (local_y + 1) & 31;
int nb_tile_x_index = (local_x + dx +32) & 31;
int backEdgeTileIdx = graph_layout[(pos.y+nb_tile_y_offset) * graph_tileWidth + pos.x + nb_tile_x_offset];
__global graph_tile_8f* backEdgeTile = &graph_tiles[backEdgeTileIdx];
backEdgeTile->edges[backward_edge+(nb_tile_y_index)*32+nb_tile_x_index] += flow;
}
local_x += dx;
local_y += 1;
// Wrap the bottom most thread around
//  * Store the flow in the border array
//  * Lookup a new height
if( ( dx > 0 && local_x > 31) || (dx < 0 && local_x < 0 ) ) {
// 2 smem & 1 tex
if( dx > 0 ) {
s_border[34*RIGHT + local_y + 1] += flow;
local_x = 0;
} else {
s_border[34*LEFT + local_y + 1] += flow;
local_x = 31;
}
//cur_height = GET_HEIGHT(x - dx, y-1);
//next_height = GET_HEIGHT(x, y);
cur_height = s_H[TILE_IDX2(local_y-1, local_x-dx)];
next_height = s_H[TILE_IDX2(local_y, local_x)];
height_diff = cur_height - next_height;
flow = zerof();
}
if( height_diff == -1 )
rev_dir |= 1 << (k+1);
cur_height = next_height;
}
barrier(CLK_LOCAL_MEM_FENCE);
#if 0
// org, works for NVIDIA and Intel and AMD on win
if( local_y < 32 ) {
// 2 smem
s_E[TILE_IDX(local_y,local_x)] += flow;
} else {
// 2 smem
s_border[34 * BOTTOM + local_x + 1] += flow;
}
#else
// need this for AMD on mac
if( local_y < 32 ) {
// 2 smem
s_E[TILE_IDX(local_y,local_x)] += flow;
}
if (local_y >= 32) {
// 2 smem
s_border[34 * BOTTOM + local_x + 1] += flow;
}
#endif
barrier(CLK_LOCAL_MEM_FENCE);
// Reverse direction
local_x -= dx; local_y -= 1;
if( (dx > 0 && local_x < 0) || (dx < 0 && local_x > 31 ) ) {
local_x = dx > 0 ? 31 : 0;
}
flow = zerof();
for( Npp32s k=PUSH_LENGTH-1; k >=0; --k ) {
// 1 gmem in & 2 smem
weight_t edge = tile->edges[backward_edge+local_y*32 + local_x];
weight_t excess = s_E[TILE_IDX(local_y,local_x)] + flow;
flow = min(excess , edge);
if( (rev_dir & (1 << k)) == 0 )
flow = zerof();
s_E[TILE_IDX(local_y,local_x)] = excess - flow;
if( flow > zerof() ) {
edge -= flow;
tile->edges[backward_edge+local_y*32 + local_x] = edge;
int nb_tile_y_offset = (local_y-1+32) / 32-1;
int nb_tile_x_offset = (local_x - dx + 32) / 32 - 1;
int nb_tile_y_index = (local_y - 1+32) & 31;
int nb_tile_x_index = (local_x - dx +32) & 31;
int forwardEdgeTileIdx = graph_layout[(pos.y+nb_tile_y_offset) * graph_tileWidth + pos.x + nb_tile_x_offset];
__global graph_tile_8f* forwardEdgeTile = &graph_tiles[forwardEdgeTileIdx];
forwardEdgeTile->edges[forward_edge+(nb_tile_y_index)*32+nb_tile_x_index] += flow;
}
local_x -= dx; local_y -= 1;
// Wrap the top most thread around
//  * Store the flow in the border array
if( (dx > 0 && local_x < 0) || (dx < 0 && local_x > 31 ) ) {
// 1 gmem out
if( dx > 0 ) {
s_border[34*LEFT+local_y + 1] += flow;
local_x = 31;
} else {
s_border[34*RIGHT+local_y + 1] += flow;
local_x = 0;
}
flow = zerof();
}
}
barrier(CLK_LOCAL_MEM_FENCE);
#if 0
// org, works for NVIDIA and Intel and AMD on win
if( local_y >= 0 ) {
// 2 smem
s_E[TILE_IDX(local_y,local_x)] += flow;
} else {
s_border[34*TOP+local_x + 1] += flow;
}
#else
// need this for AMD on mac
if( local_y >= 0 ) {
// 2 smem
s_E[TILE_IDX(local_y,local_x)] += flow;
}
if (local_y < 0) {
s_border[34*TOP+local_x + 1] += flow;
}
#endif
}

__kernel void _pushActiveTiles(
__global graph_tile_8f* graph_tiles,
const Npp32s graph_tileWidth,
const Npp32s graph_tileHeight,
__global Npp32s* graph_layout,
__global Npp32s* graph_active_tile_count,
__global Npp32s* graph_active_tile_indexes
)
{
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
__local weight_t s_border[34*4];
__local weight_t s_E[33*32];
__local Npp32s s_H[34*35];
const Npp32s linearThreadIdx = threadIdx.y * 32 + threadIdx.x;
if( get_group_id(0) >= *graph_active_tile_count ) return;
__global graph_tile_8f* tile = &graph_tiles[graph_active_tile_indexes[get_group_id(0)]];
// Load Height to SMEM
readHeightTileWithApronIntoSMEM(graph_tileWidth, graph_tileHeight, graph_layout, graph_tiles, tile, s_H, PUSH_LENGTH);
// Load Excess Flow to SMEM
for( Npp32s k=0; k<PUSH_LENGTH; ++ k ) {
s_E[TILE_IDX(threadIdx.y+k*(32/PUSH_LENGTH),threadIdx.x)] = tile->terminals[(threadIdx.y+k*(32/PUSH_LENGTH))*32+threadIdx.x];
}
// Clear Border in SMEM
{
Npp32s idx = linearThreadIdx;
while( 	idx < 4 * 34 ) {
s_border[idx] = 0;
idx += get_local_size(1)*32;
}
}
// Push Excess Flow in all directions
barrier(CLK_LOCAL_MEM_FENCE);
push_horizontal(graph_tiles, graph_tileWidth, graph_layout, tile, s_E, s_H, s_border);
barrier(CLK_LOCAL_MEM_FENCE);
if( nbhd ==8 ) {
push_vertical(graph_tiles, graph_tileWidth, graph_layout, tile, s_E, s_H, s_border, TOPLEFT,+1);
barrier(CLK_LOCAL_MEM_FENCE);
}
push_vertical(graph_tiles, graph_tileWidth, graph_layout, tile, s_E, s_H, s_border, TOP,0);
barrier(CLK_LOCAL_MEM_FENCE);
if( nbhd ==8 ) {
push_vertical(graph_tiles, graph_tileWidth, graph_layout, tile, s_E, s_H, s_border, TOPRIGHT,-1);
barrier(CLK_LOCAL_MEM_FENCE);
}
// Store Excess Flow to GMEM
for( Npp32s k=0; k<PUSH_LENGTH; ++ k ) {
tile->terminals[(threadIdx.y+k*(32/PUSH_LENGTH))*32+threadIdx.x] = s_E[TILE_IDX(threadIdx.y+k*(32/PUSH_LENGTH),threadIdx.x)];
}
// Store Border to GMEM
{
Npp32s idx = linearThreadIdx;
while( 	idx < 4 * 34 ) {
tile->border[idx] = s_border[idx];
idx += get_local_size(1)*32;
}
}
}

__kernel void _addBordersAtomic(
__global graph_tile_8f* graph_tiles,
const Npp32s graph_tileWidth,
__global Npp32s* graph_layout,
__global Npp32s* graph_active_tile_count,
__global Npp32s* graph_active_tile_indexes
)
{
__local int sTileIdx;
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
if( get_group_id(0) >= *graph_active_tile_count ) return;
if( threadIdx.y ==  0 ) {
sTileIdx = graph_active_tile_indexes[get_group_id(0)];
}
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[sTileIdx];
ushort2 pos = tile->pos;
int tile_x = pos.x;
int tile_y = pos.y;
int nb_tile_offset = ((threadIdx.x + 31) / 32) - 1; // -1 0 ... 0 1
int nb_tile_index = threadIdx.x + 31 - ((threadIdx.x + 31) / 32) * 32; // 31 0 1 2 .. 31 0
if(threadIdx.y == 0)
{
weight_t flow = tile->border[34*LEFT+threadIdx.x];
if( flow > zerof() ) {
int leftTileIdx = graph_layout[(tile_y + nb_tile_offset) * graph_tileWidth + tile_x - 1];
__global graph_tile_8f* leftTile = &graph_tiles[leftTileIdx];
AtomicAdd((volatile __global float *)&leftTile->terminals[32*nb_tile_index+31], flow);
}
return;
}
if( threadIdx.y == 1)
{
weight_t flow = tile->border[34*RIGHT+threadIdx.x];
if( flow > zerof() ) {
int rightTileIdx = graph_layout[(tile_y + nb_tile_offset) * graph_tileWidth + tile_x + 1];
__global graph_tile_8f* rightTile = &graph_tiles[rightTileIdx];
AtomicAdd((volatile __global float *)&rightTile->terminals[32*nb_tile_index], flow);
}
return;
}
if( threadIdx.y == 2)
{
weight_t flow = tile->border[34*TOP+threadIdx.x];
if( flow > zerof() ) {
int topTileIdx = graph_layout[(tile_y - 1) * graph_tileWidth + tile_x + nb_tile_offset];
__global graph_tile_8f* topTile = &graph_tiles[topTileIdx];
AtomicAdd((volatile __global float *)&topTile->terminals[31*32+nb_tile_index], flow);
}
return;
}
if(threadIdx.y == 3)
{
weight_t flow = tile->border[34*BOTTOM+threadIdx.x];
if( flow > zerof() ) {
int bottomTileIdx = graph_layout[(tile_y + 1) * graph_tileWidth + tile_x + nb_tile_offset];
__global graph_tile_8f* bottomTile = &graph_tiles[bottomTileIdx];
AtomicAdd((volatile __global float *)&bottomTile->terminals[nb_tile_index], flow);
}
return;
}
}

__kernel void _addBordersAtomicLeft(
__global graph_tile_8f* graph_tiles,
const Npp32s graph_tileWidth,
__global Npp32s* graph_layout,
__global Npp32s* graph_active_tile_count,
__global Npp32s* graph_active_tile_indexes
)
{
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
if( get_group_id(0) >= *graph_active_tile_count ) return;
__global graph_tile_8f* tile = &graph_tiles[graph_active_tile_indexes[get_group_id(0)]];
ushort2 pos = tile->pos;
int tile_x = pos.x;
int tile_y = pos.y;
int nb_tile_offset = ((threadIdx.x + 31) / 32) - 1; // -1 0 ... 0 1
int nb_tile_index = threadIdx.x + 31 - ((threadIdx.x + 31) / 32) * 32; // 31 0 1 2 .. 31 0
switch( threadIdx.y ) {
case 0 :
{
weight_t flow = tile->border[34*LEFT+threadIdx.x];
if( flow > zerof() ) {
int leftTileIdx = graph_layout[(tile_y + nb_tile_offset) * graph_tileWidth + tile_x - 1];
__global graph_tile_8f* leftTile = &graph_tiles[leftTileIdx];
leftTile->terminals[32*nb_tile_index+31] += flow;
}
break;
}
};
}

__kernel void _addBordersAtomicRight(
__global graph_tile_8f* graph_tiles,
const Npp32s graph_tileWidth,
__global Npp32s* graph_layout,
__global Npp32s* graph_active_tile_count,
__global Npp32s* graph_active_tile_indexes
)
{
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
if( get_group_id(0) >= *graph_active_tile_count ) return;
__global graph_tile_8f* tile = &graph_tiles[graph_active_tile_indexes[get_group_id(0)]];
ushort2 pos = tile->pos;
int tile_x = pos.x;
int tile_y = pos.y;
int nb_tile_offset = ((threadIdx.x + 31) / 32) - 1; // -1 0 ... 0 1
int nb_tile_index = threadIdx.x + 31 - ((threadIdx.x + 31) / 32) * 32; // 31 0 1 2 .. 31 0
switch( threadIdx.y ) {
case 1 :
{
weight_t flow = tile->border[34*RIGHT+threadIdx.x];
if( flow > zerof() ) {
int rightTileIdx = graph_layout[(tile_y + nb_tile_offset) * graph_tileWidth + tile_x + 1];
__global graph_tile_8f* rightTile = &graph_tiles[rightTileIdx];
rightTile->terminals[32*nb_tile_index] += flow;
}
break;
}
};
}

__kernel void _addBordersAtomicTop(
__global graph_tile_8f* graph_tiles,
const Npp32s graph_tileWidth,
__global Npp32s* graph_layout,
__global Npp32s* graph_active_tile_count,
__global Npp32s* graph_active_tile_indexes
)
{
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
if( get_group_id(0) >= *graph_active_tile_count ) return;
__global graph_tile_8f* tile = &graph_tiles[graph_active_tile_indexes[get_group_id(0)]];
ushort2 pos = tile->pos;
int tile_x = pos.x;
int tile_y = pos.y;
int nb_tile_offset = ((threadIdx.x + 31) / 32) - 1; // -1 0 ... 0 1
int nb_tile_index = threadIdx.x + 31 - ((threadIdx.x + 31) / 32) * 32; // 31 0 1 2 .. 31 0
switch( threadIdx.y ) {
case 2 :
{
weight_t flow = tile->border[34*TOP+threadIdx.x];
if( flow > zerof() ) {
int topTileIdx = graph_layout[(tile_y - 1) * graph_tileWidth + tile_x + nb_tile_offset];
__global graph_tile_8f* topTile = &graph_tiles[topTileIdx];
topTile->terminals[31*32+nb_tile_index] += flow;
}
break;
}
};
}

__kernel void _addBordersAtomicBottom(
__global graph_tile_8f* graph_tiles,
const Npp32s graph_tileWidth,
__global Npp32s* graph_layout,
__global Npp32s* graph_active_tile_count,
__global Npp32s* graph_active_tile_indexes
)
{
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
if( get_group_id(0) >= *graph_active_tile_count ) return;
__global graph_tile_8f* tile = &graph_tiles[graph_active_tile_indexes[get_group_id(0)]];
ushort2 pos = tile->pos;
int tile_x = pos.x;
int tile_y = pos.y;
int nb_tile_offset = ((threadIdx.x + 31) / 32) - 1; // -1 0 ... 0 1
int nb_tile_index = threadIdx.x + 31 - ((threadIdx.x + 31) / 32) * 32; // 31 0 1 2 .. 31 0
switch( threadIdx.y ) {
case 3 :
{
weight_t flow = tile->border[34*BOTTOM+threadIdx.x];
if( flow > zerof() ) {
int bottomTileIdx = graph_layout[(tile_y + 1) * graph_tileWidth + tile_x + nb_tile_offset];
__global graph_tile_8f* bottomTile = &graph_tiles[bottomTileIdx];
bottomTile->terminals[nb_tile_index] += flow;
}
break;
}
};
}
//-----------------------------------------------------------------
//
//	Graph Compression
//
//-----------------------------------------------------------------
//template<int u_delta, class weight_t>
//weight_t = weight_t
//edgeFlag_t needs union before it?
void compress_dir(__global weight_t* pforward_edges, __global weight_t* pbackward_edges, __local union edgeFlag_t* forward_compressed, __local union edgeFlag_t* backward_compressed, const int u_delta)
{
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
Npp32s forward_edges = 0;
Npp32s backward_edges = 0;
__global weight_t* my_forward_edge = &pforward_edges[threadIdx.y * 8 * 32];
__global weight_t* my_backward_edge = &pbackward_edges[threadIdx.y * 8 * 32];
for( Npp32s k=0; k<8; ++k ) {
int u_offset = (threadIdx.x + k * u_delta + 32) & 31;
if( my_forward_edge[k * 32 + u_offset] > zerof() ) {
forward_edges ^= 1 << k;
}
if( my_backward_edge[k * 32 + u_offset] > zerof() ) {
backward_edges ^= 1 << (7-k);
}
}
forward_compressed[threadIdx.x].warp[threadIdx.y] = forward_edges;
backward_compressed[threadIdx.x].warp[threadIdx.y] = backward_edges;
}
// Block: 32x4
void compressEdgesTile(__global graph_tile_8f* tile, __local union edgeFlag_t* s_compressedEdges) {
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
compress_dir(&tile->edges[32*32*LEFT], &tile->edges[32*32*RIGHT], &s_compressedEdges[32*LEFT], &s_compressedEdges[32*RIGHT], 0);
compress_dir(&tile->edges[32*32*TOP], &tile->edges[32*32*BOTTOM], &s_compressedEdges[32*TOP], &s_compressedEdges[32*BOTTOM], 0);
if( nbhd ==8 ) {
compress_dir(&tile->edges[32*32*TOPLEFT], &tile->edges[32*32*BOTTOMRIGHT], &s_compressedEdges[32*TOPLEFT], &s_compressedEdges[32*BOTTOMRIGHT], 1);
compress_dir(&tile->edges[32*32*TOPRIGHT], &tile->edges[32*32*BOTTOMLEFT], &s_compressedEdges[32*TOPRIGHT], &s_compressedEdges[32*BOTTOMLEFT], -1);
}
barrier(CLK_LOCAL_MEM_FENCE);
int linearThreadIdx = threadIdx.y * 32 + threadIdx.x;
__local Npp32u* s_linearCompressedEdges = &s_compressedEdges[0].line;
__global Npp32u* g_linearCompressedEdges = &tile->compressed_edges[0].line;
for( Npp32s i = linearThreadIdx; i < 32 * nbhd; i+=32*4 ) {
g_linearCompressedEdges[i] = s_linearCompressedEdges[i];
}
}
// Block: 32x4

__kernel void _compressEdgesAllTiles(__global graph_tile_8f* graph_tiles) {
__global graph_tile_8f* tile = &graph_tiles[get_group_id(0)];

// Variables allocated in the __local address space can also be defined inside a __kernel function only
__local union edgeFlag_t s_compressedEdges[32*nbhd];
compressEdgesTile(tile, s_compressedEdges);
}

__kernel void _compressEdgesActiveTiles(
__global graph_tile_8f* graph_tiles,
__global Npp32s* graph_active_tile_count,
__global Npp32s* graph_active_tile_indexes
) {
if( get_group_id(0) >= *graph_active_tile_count ) return;
__global graph_tile_8f* tile = &graph_tiles[graph_active_tile_indexes[get_group_id(0)]];

// Variables allocated in the __local address space can also be defined inside a __kernel function only
__local union edgeFlag_t s_compressedEdges[32*nbhd];
compressEdgesTile(tile, s_compressedEdges);
}
//-----------------------------------------------------------------
//
//	Relabeling
//
//-----------------------------------------------------------------
bool hasLeftEdge(const __global union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = x_local & 7;
int warp = x_local >> 3;
return (edges_tile[32*LEFT+y_local].warp[warp] & (1u << k)) > 0;
}
bool hasRightEdge(const __global union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = x_local & 7;
int warp = x_local >> 3;
return (edges_tile[32 * RIGHT + y_local].warp[warp] & (1u << (7-k))) > 0;
}
bool hasTopEdge(const __global union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = y_local & 7;
int warp = y_local >> 3;
return (edges_tile[32 * TOP + x_local].warp[warp] & (1u << k)) > 0;
}
bool hasBottomEdge(const __global union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = y_local & 7;
int warp = y_local >> 3;
return (edges_tile[32 * BOTTOM + x_local].warp[warp] & (1u << (7-k))) > 0;
}
bool hasTopLeftEdge(const __global union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = y_local & 7;
int warp = y_local >> 3;
int thread = (x_local - k + 32) & 31;
return (edges_tile[32 * TOPLEFT + thread].warp[warp] & (1u << k)) > 0;
}
bool hasTopRightEdge(const __global union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = y_local & 7;
int warp = y_local >> 3;
int thread = (x_local + k) & 31;
return (edges_tile[32 * TOPRIGHT + thread].warp[warp] & (1u << k)) > 0;
}
bool hasBottomLeftEdge(const __global union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = y_local & 7;
int warp = y_local >> 3;
int thread = (x_local + k) & 31;
return (edges_tile[32 * BOTTOMLEFT + thread].warp[warp] & (1u << (7-k))) > 0;
}
bool hasBottomRightEdge(const __global union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = y_local & 7;
int warp = y_local >> 3;
int thread = (x_local - k + 32) & 31;
return (edges_tile[32 * BOTTOMRIGHT + thread].warp[warp] & (1u << (7-k))) > 0;
}
// for __local
bool hasLeftEdgeLocal(const __local union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = x_local & 7;
int warp = x_local >> 3;
return (edges_tile[32*LEFT+y_local].warp[warp] & (1u << k)) > 0;
}
bool hasRightEdgeLocal(const __local union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = x_local & 7;
int warp = x_local >> 3;
return (edges_tile[32 * RIGHT + y_local].warp[warp] & (1u << (7-k))) > 0;
}
bool hasTopEdgeLocal(const __local union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = y_local & 7;
int warp = y_local >> 3;
return (edges_tile[32 * TOP + x_local].warp[warp] & (1u << k)) > 0;
}
bool hasBottomEdgeLocal(const __local union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = y_local & 7;
int warp = y_local >> 3;
return (edges_tile[32 * BOTTOM + x_local].warp[warp] & (1u << (7-k))) > 0;
}
bool hasTopLeftEdgeLocal(const __local union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = y_local & 7;
int warp = y_local >> 3;
int thread = (x_local - k + 32) & 31;
return (edges_tile[32 * TOPLEFT + thread].warp[warp] & (1u << k)) > 0;
}
bool hasTopRightEdgeLocal(const __local union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = y_local & 7;
int warp = y_local >> 3;
int thread = (x_local + k) & 31;
return (edges_tile[32 * TOPRIGHT + thread].warp[warp] & (1u << k)) > 0;
}
bool hasBottomLeftEdgeLocal(const __local union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = y_local & 7;
int warp = y_local >> 3;
int thread = (x_local + k) & 31;
return (edges_tile[32 * BOTTOMLEFT + thread].warp[warp] & (1u << (7-k))) > 0;
}
bool hasBottomRightEdgeLocal(const __local union edgeFlag_t* edges_tile, int x_local, int y_local) {
int k = y_local & 7;
int warp = y_local >> 3;
int thread = (x_local - k + 32) & 31;
return (edges_tile[32 * BOTTOMRIGHT + thread].warp[warp] & (1u << (7-k))) > 0;
}
// Block: 32x8

__kernel void _resetHeightAndFindRelabelTiles(__global graph_tile_8f* graph_tiles,
//	__global Npp32s* graph_active_tile_count, __global graph_tile_8f** graph_active_tiles)
__global Npp32s* graph_active_tile_count, __global Npp32s* graph_active_tile_indexes)
{
__local Npp32s s_has_zero;
__local Npp32s s_has_inf;
s_has_zero=0;
s_has_inf=0;
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[get_group_id(0)];
Npp32s has_zero = 0;
Npp32s has_inf = 0;
int x = get_local_id(0);
int y = get_local_id(1);
for( Npp32s k=0; k<4; ++k ) {
weight_t excessFlow = tile->terminals[y*32 + x];
if( excessFlow < 0 ) {
tile->height[y*32+x] = 0;
has_zero = 1;
} else {
tile->height[y*32+x] = HEIGHT_INF;
has_inf = 1;
}
y+=8;
}
if( has_zero )
s_has_zero = 1;
if( has_inf )
s_has_inf = 1;
barrier(CLK_LOCAL_MEM_FENCE);
if(  get_local_id(0)+get_local_id(1) == 0  ) {
if( s_has_zero && s_has_inf ) {
//			push_tile(graph_active_tiles, graph_active_tile_count, tile);
push_tile(graph_active_tile_indexes, graph_active_tile_count, tile);
}
}
}
//Block: 32x4

__kernel
void _findBorderGapTiles(
__global graph_tile_8f* graph_tiles,
const Npp32s graph_tileWidth,
const Npp32s graph_tileHeight,
__global Npp32s* graph_layout,
__global Npp32s* graph_active_tile_count,
__global Npp32s* graph_active_tile_indexes
)
{
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
int2 blockIdx = (int2)(get_group_id(0), get_group_id(1));
__local volatile Npp32s s_schedule;
__local Npp32s out_height[4][34];
__global graph_tile_8f* tile = &graph_tiles[blockIdx.x];
ushort2 pos = tile->pos;
int tile_x = pos.x;
int tile_y = pos.y;
int layoutIdx = tile_y * graph_tileWidth + tile_x;
Npp32s in_height;
// Apron
switch( threadIdx.y ) {
case 0 : {
// Left
in_height = tile->height[32*threadIdx.x];
if( tile_x > 0 ) {
int leftLayoutIdx = layoutIdx - 1;
int leftTileIdx = graph_layout[leftLayoutIdx];
if( leftTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* leftTile = &graph_tiles[leftTileIdx];
// Read column 31
out_height[0][threadIdx.x+1] = leftTile->height[threadIdx.x * 32 + 31];
}
}
break;
}
case 1 : {
// Right
in_height = tile->height[32*threadIdx.x+31];
if( tile_x < graph_tileWidth - 1 ) {
int rightLayoutIdx = layoutIdx + 1;
int rightTileIdx = graph_layout[rightLayoutIdx];
if( rightTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* rightTile = &graph_tiles[rightTileIdx];
// Read column 0
out_height[1][threadIdx.x+1] = rightTile->height[threadIdx.x * 32];
}
}
break;
}
case 2 : {
// Top
in_height = tile->height[threadIdx.x];
if( tile_y > 0 ) {
int topLayoutIdx = layoutIdx - graph_tileWidth;
int topTileIdx = graph_layout[topLayoutIdx];
if( topTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* topTile = &graph_tiles[topTileIdx];
// Read row 31
out_height[2][threadIdx.x+1] = topTile->height[31*32 + threadIdx.x];
}
if( nbhd == 8 ) {
if( tile_x > 0 ) {
int topLeftTileIdx = graph_layout[topLayoutIdx - 1];
if( topLeftTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* topLeftTile = &graph_tiles[topLeftTileIdx];
// Read element 31,31
out_height[2][0] = out_height[0][0] = topLeftTile->height[31*32 + 31];
}
}
if( tile_x < graph_tileWidth - 1 ) {
int topRightTileIdx = graph_layout[topLayoutIdx + 1];
if( topRightTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* topRightTile = &graph_tiles[topRightTileIdx];
// Read element 0,31
out_height[2][33] = out_height[1][0] = topRightTile->height[31*32 + 0];
}
}
}
}
break;
}
case 3 : {
// Bottom
in_height = tile->height[31*32 + threadIdx.x];
if( tile_y < graph_tileHeight - 1 ) {
int bottomLayoutIdx = layoutIdx + graph_tileWidth;
int bottomTileIdx = graph_layout[bottomLayoutIdx];
if( bottomTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* bottomTile = &graph_tiles[bottomTileIdx];
// Read row 0
out_height[3][threadIdx.x+1] = bottomTile->height[threadIdx.x];
}
if( nbhd == 8 ) {
if( tile_x > 0 ) {
int bottomLeftTileIdx = graph_layout[bottomLayoutIdx - 1];
if( bottomLeftTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* bottomLeftTile = &graph_tiles[bottomLeftTileIdx];
// Read element 31,0
out_height[3][0] = out_height[0][33] = bottomLeftTile->height[31];
}
}
if( tile_x < graph_tileWidth - 1 ) {
int bottomRightTileIdx = graph_layout[bottomLayoutIdx + 1];
if( bottomRightTileIdx >= 0 ) {
// Tile exists
__global graph_tile_8f* bottomRightTile = &graph_tiles[bottomRightTileIdx];
// Read element 0,0
out_height[3][33] = out_height[1][33] = bottomRightTile->height[0];
}
}
}
}
break;
}
}
s_schedule = 0;
barrier(CLK_LOCAL_MEM_FENCE);
Npp32s schedule = 0;
switch( threadIdx.y ) {
case 0 : {
if( (in_height - out_height[0][threadIdx.x+1] > 1) &&
hasLeftEdge(tile->compressed_edges, 0, threadIdx.x) ) {
schedule = 1;
}
break;
}
case 1 : {
if( (in_height - out_height[1][threadIdx.x+1] > 1) &&
hasRightEdge(tile->compressed_edges, 31, threadIdx.x) ) {
schedule = 1;
}
break;
}
case 2 : {
if( (in_height - out_height[2][threadIdx.x+1] > 1) &&
hasTopEdge(tile->compressed_edges, threadIdx.x, 0) ) {
schedule = 1;
}
break;
}
case 3 : {
if( (in_height - out_height[3][threadIdx.x+1] > 1) &&
hasBottomEdge(tile->compressed_edges, threadIdx.x, 31) ) {
schedule = 1;
}
break;
}
};
if( schedule == 1 )
s_schedule = 1;
barrier(CLK_LOCAL_MEM_FENCE);
if( s_schedule > 0 ) {
if(  threadIdx.x+threadIdx.y == 0  ) {
push_tile(graph_active_tile_indexes, graph_active_tile_count, tile);
}
return;
}
if( nbhd != 8 ) return;
switch( threadIdx.y ) {
case 0 : {
if( (in_height - out_height[0][threadIdx.x] > 1) &&
hasTopLeftEdge(tile->compressed_edges, 0, threadIdx.x) ) {
schedule = 1;
}
break;
}
case 1 : {
if( (in_height - out_height[1][threadIdx.x] > 1) &&
hasTopRightEdge(tile->compressed_edges, 31, threadIdx.x) ) {
schedule = 1;
}
break;
}
case 2 : {
if( (in_height - out_height[2][threadIdx.x] > 1) &&
hasTopLeftEdge(tile->compressed_edges, threadIdx.x, 0) ) {
schedule = 1;
}
break;
}
case 3 : {
if( (in_height - out_height[3][threadIdx.x] > 1) &&
hasBottomLeftEdge(tile->compressed_edges, threadIdx.x, 31) ) {
schedule = 1;
}
break;
}
};
if( schedule == 1 )
s_schedule = 1;
barrier(CLK_LOCAL_MEM_FENCE);
if( s_schedule > 0 ) {
if(  threadIdx.x+threadIdx.y == 0  ) {
push_tile(graph_active_tile_indexes, graph_active_tile_count, tile);
}
return;
}
switch( threadIdx.y ) {
case 0 : {
if( (in_height - out_height[0][threadIdx.x+2] > 1) &&
hasBottomLeftEdge(tile->compressed_edges, 0, threadIdx.x) ) {
schedule = 1;
}
break;
}
case 1 : {
if( (in_height - out_height[1][threadIdx.x+2] > 1) &&
hasBottomRightEdge(tile->compressed_edges, 31, threadIdx.x) ) {
schedule = 1;
}
break;
}
case 2 : {
if( (in_height - out_height[2][threadIdx.x+2] > 1) &&
hasTopRightEdge(tile->compressed_edges, threadIdx.x, 0) ) {
schedule = 1;
}
break;
}
case 3 : {
if( (in_height - out_height[3][threadIdx.x+2] > 1) &&
hasBottomRightEdge(tile->compressed_edges, threadIdx.x, 31) ) {
schedule = 1;
}
break;
}
};
if( schedule == 1 )
s_schedule = 1;
barrier(CLK_LOCAL_MEM_FENCE);
if( s_schedule > 0 ) {
if(  threadIdx.x+threadIdx.y == 0  ) {
push_tile(graph_active_tile_indexes, graph_active_tile_count, tile);
}
}
}
int relabelHorizontal(__local Npp32s* s_H, const __local union edgeFlag_t* forwardEdges, const __local union edgeFlag_t* backwardEdges, const bool bHeight_op)
{
int changed = 0;
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
Npp32s local_x = threadIdx.y * 8;
Npp32s local_y = threadIdx.x;
Npp32s r_H[8];
Npp32s edges;
Npp32s current, neighbor;
// Forward
current = s_H[TILE_IDX2(local_y, local_x-1)];
edges = forwardEdges[threadIdx.x].warp[threadIdx.y];
for( Npp32s k=0; k<8; ++k ) {
neighbor = current;
current = s_H[TILE_IDX2(local_y, local_x+k)];
changed += current;
bool op_compare = bHeight_op ? (neighbor + 1 < current) : (neighbor < current); // height_op or label_op
if( op_compare && (edges & (1<<k))) {
current = bHeight_op ? neighbor + 1 : neighbor; // height_op or label_op
//changed = 1;
}
r_H[k] = current;
}
// Backward
current = s_H[TILE_IDX2(local_y, local_x+8)];
edges = backwardEdges[threadIdx.x].warp[threadIdx.y];
// Sync before writing the results
barrier(CLK_LOCAL_MEM_FENCE);
for( Npp32s k=7; k>=0; --k ) {
neighbor = current;
current = r_H[k];
bool op_compare = bHeight_op ? (neighbor + 1 < current) : (neighbor < current); // height_op or label_op
if( op_compare && (edges & (1<<(7-k))) ) {
current = bHeight_op ? neighbor + 1 : neighbor; // height_op or label_op
//changed = 1;
}
changed -= current;
s_H[TILE_IDX2(local_y, local_x+k)] = current;
}
// Sync after writing to SMEM
barrier(CLK_LOCAL_MEM_FENCE);
return changed;
}
int relabelVertical(__local Npp32s* s_H, const __local union edgeFlag_t* forwardEdges, const __local union edgeFlag_t* backwardEdges, const bool bHeight_op)
{
int changed = 0;
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
Npp32s local_y = threadIdx.y * 8;
Npp32s local_x = threadIdx.x;
Npp32s current, neighbor;
Npp32s r_H[8];
Npp32s edges;
// Forward
current = s_H[TILE_IDX2(local_y-1, local_x)];
edges = forwardEdges[threadIdx.x].warp[threadIdx.y];
for( Npp32s k=0; k<8; ++k ) {
neighbor = current;
current = s_H[TILE_IDX2(local_y+k, local_x)];
changed += current;
bool op_compare = bHeight_op ? (neighbor + 1 < current) : (neighbor < current); // height_op or label_op
if( op_compare && (edges & (1<<k)) ) {
current = bHeight_op ? neighbor + 1 : neighbor; // height_op or label_op
//changed = 1;
}
r_H[k] = current;
}
// Backward
current = s_H[TILE_IDX2(local_y+8, local_x)];
edges = backwardEdges[threadIdx.x].warp[threadIdx.y];
// Sync before writing the results
barrier(CLK_LOCAL_MEM_FENCE);
for( Npp32s k=7; k>=0; --k ) {
neighbor = current;
current = r_H[k];
bool op_compare = bHeight_op ? (neighbor + 1 < current) : (neighbor < current); // height_op or label_op
if( op_compare && (edges & (1<<(7-k))) ) {
current = bHeight_op ? neighbor + 1 : neighbor; // height_op or label_op
//changed = 1;
}
changed -= current;
s_H[TILE_IDX2(local_y+k, local_x)] = current;
}
// Sync after writing to SMEM
barrier(CLK_LOCAL_MEM_FENCE);
return changed;
}
int relabelDiagonal1(__local Npp32s* s_H, const __local union edgeFlag_t* forwardEdges, const __local union edgeFlag_t* backwardEdges, const bool bHeight_op)
{
int changed = 0;
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
Npp32s local_y = threadIdx.y * 8;
Npp32s local_x = threadIdx.x;
Npp32s current, neighbor;
Npp32s edges;
Npp32s r_H[8];
Npp32s wrap_neighbor;
// Forward
current = s_H[TILE_IDX2(local_y-1, local_x-1)];
edges = forwardEdges[threadIdx.x].warp[threadIdx.y];
Npp32s wrap_k = 32 - threadIdx.x;
if( wrap_k < 8 )
wrap_neighbor = s_H[TILE_IDX2(local_y+wrap_k-1, -1)];
for( Npp32s k=0; k<8; ++k ) {
if( k == wrap_k )
current = wrap_neighbor;
neighbor = current;
current = s_H[TILE_IDX2(local_y+k, (local_x+k) & 31)];
changed += current;
bool op_compare = bHeight_op ? (neighbor + 1 < current) : (neighbor < current); // height_op or label_op
if( op_compare && (edges & (1<<k)) ) {
current = bHeight_op ? neighbor + 1 : neighbor; // height_op or label_op
//changed = 1;
}
r_H[k] = current;
}
// Backward
current = s_H[TILE_IDX2(local_y+8, ((local_x+7) & 31) + 1)];
wrap_k = 31 - threadIdx.x;
if( wrap_k < 8 )
wrap_neighbor = s_H[TILE_IDX2(local_y+wrap_k+1, 32)];
edges = backwardEdges[threadIdx.x].warp[threadIdx.y];
// Sync before writing the results
barrier(CLK_LOCAL_MEM_FENCE);
for( Npp32s k=7; k>=0; --k ) {
if( k == wrap_k )
current = wrap_neighbor;
neighbor = current;
current = r_H[k];
bool op_compare = bHeight_op ? (neighbor + 1 < current) : (neighbor < current); // height_op or label_op
if( op_compare && (edges & (1<<(7-k))) ) {
current = bHeight_op ? neighbor + 1 : neighbor; // height_op or label_op
//changed = 1;
}
changed -= current;
s_H[TILE_IDX2(local_y+k, (local_x+k) & 31)] = current;
}
// Sync after writing to SMEM
barrier(CLK_LOCAL_MEM_FENCE);
return changed;
}
int relabelDiagonal2(__local Npp32s* s_H, const __local union edgeFlag_t* forwardEdges, const __local union edgeFlag_t* backwardEdges, const bool bHeight_op)
{
int changed = 0;
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
Npp32s local_y = threadIdx.y * 8;
Npp32s local_x = threadIdx.x;
Npp32s current, neighbor;
Npp32s edges;
Npp32s r_H[8];
Npp32s wrap_neighbor;
// Forward
current = s_H[TILE_IDX2(local_y-1, local_x+1)];
edges = forwardEdges[threadIdx.x].warp[threadIdx.y];
Npp32s wrap_k = threadIdx.x + 1;
if( wrap_k < 8 )
wrap_neighbor = s_H[TILE_IDX2(local_y+wrap_k-1, 32)];
for( Npp32s k=0; k<8; ++k ) {
if( k == wrap_k )
current = wrap_neighbor;
neighbor = current;
current = s_H[TILE_IDX2(local_y+k, (local_x-k+32) % 32)];
changed += current;
bool op_compare = bHeight_op ? (neighbor + 1 < current) : (neighbor < current); // height_op or label_op
if( op_compare && (edges & (1<<k)) ) {
current = bHeight_op ? neighbor + 1 : neighbor; // height_op or label_op
//changed = 1;
}
r_H[k] = current;
}
// Backward
current = s_H[TILE_IDX2(local_y+8, ((local_x-7+32) % 32)-1)];
wrap_k = threadIdx.x;
if( wrap_k < 8 )
wrap_neighbor = s_H[TILE_IDX2(local_y+wrap_k+1, -1)];
edges = backwardEdges[threadIdx.x].warp[threadIdx.y];
// Sync before writing the results
barrier(CLK_LOCAL_MEM_FENCE);
for( Npp32s k=7; k>=0; --k ) {
if( k == wrap_k )
current = wrap_neighbor;
neighbor = current;
current = r_H[k];
bool op_compare = bHeight_op ? (neighbor + 1 < current) : (neighbor < current); // height_op or label_op
if( op_compare && (edges & (1<<(7-k))) ) {
current = bHeight_op ? neighbor + 1 : neighbor; // height_op or label_op
//changed = 1;
}
changed -= current;
s_H[TILE_IDX2(local_y+k, (local_x-k+32) % 32)] = current;
}
// Sync after writing to SMEM
barrier(CLK_LOCAL_MEM_FENCE);
return changed;
}
#ifdef NVIDIA
int __syncthreads_or(int bFlag) {
int bResult;
asm("{ .reg .pred p1; \
.reg .pred p2; \
setp.ne.u32 p1, %1, 0;\
bar.red.or.pred p2, 0, p1;\
selp.u32 %0, 1, 0, p2; }" : "=r"(bResult) : "r"(bFlag));
return bResult;
}
#endif

__kernel void _relabelActiveTiles(
__global graph_tile_8f* graph_tiles,
const Npp32s graph_tileWidth,
const Npp32s graph_tileHeight,
__global Npp32s* graph_layout,
__global Npp32s* graph_active_tile_count,
__global Npp32s* graph_active_tile_indexes
)
{
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
__local Npp32s s_H[34*35];
__local union edgeFlag_t s_compressedEdges[32*nbhd];
if( get_group_id(0) >= *graph_active_tile_count ) return;
#if 0
__local int sTileIdx;
if( threadIdx.y == 0 ) {
sTileIdx = graph_active_tile_indexes[get_group_id(0)];
}
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[sTileIdx];
#else
__global graph_tile_8f* tile = &graph_tiles[graph_active_tile_indexes[get_group_id(0)]];
#endif
// Load Height to SMEM
readHeightTileWithApronIntoSMEM(graph_tileWidth, graph_tileHeight, graph_layout, graph_tiles, tile, s_H, 8);
// Load compressed graph to SMEM
int linearThreadIdx = threadIdx.y * 32 + threadIdx.x;
__local Npp32u* s_linearCompressedEdges = &s_compressedEdges[0].line;
__global Npp32u* g_linearCompressedEdges = &tile->compressed_edges[0].line;
for( Npp32s i = linearThreadIdx; i < 32 * nbhd; i+=32*4 ) {
s_linearCompressedEdges[i] = g_linearCompressedEdges[i];
}
// barrier at after changed = 1
Npp32s changed = 1;
// do we need volatile here?
#ifdef NVIDIA
while( __syncthreads_or(changed) )
{
// everyone come in
changed = 0;
if( relabelHorizontal( s_H, &s_compressedEdges[32*LEFT], &s_compressedEdges[32*RIGHT],true /*//ocl//height_op()*/) != 0 )
changed = 1;
if( relabelVertical(s_H, &s_compressedEdges[32*TOP], &s_compressedEdges[32*BOTTOM], true /*//ocl//height_op()*/) != 0 )
changed = 1;
if( relabelDiagonal1(s_H, &s_compressedEdges[32*TOPLEFT], &s_compressedEdges[32*BOTTOMRIGHT], true /*//ocl//height_op()*/) != 0 )
changed = 1;
if( relabelDiagonal2(s_H, &s_compressedEdges[32*TOPRIGHT], &s_compressedEdges[32*BOTTOMLEFT], true /*//ocl//height_op()*/) != 0 )
changed = 1;
}
#else
// do we need volatile here?
__local volatile Npp32s changedBlk;
changedBlk = 1;
barrier(CLK_LOCAL_MEM_FENCE);
while( changedBlk )
{
// everyone come in
changed = 0;
barrier(CLK_LOCAL_MEM_FENCE);
changedBlk = 0;
if( relabelHorizontal( s_H, &s_compressedEdges[32*LEFT], &s_compressedEdges[32*RIGHT],true /*//ocl//height_op()*/) != 0 )
changed = 1;
if( relabelVertical(s_H, &s_compressedEdges[32*TOP], &s_compressedEdges[32*BOTTOM], true /*//ocl//height_op()*/) != 0 )
changed = 1;
if( relabelDiagonal1(s_H, &s_compressedEdges[32*TOPLEFT], &s_compressedEdges[32*BOTTOMRIGHT], true /*//ocl//height_op()*/) != 0 )
changed = 1;
if( relabelDiagonal2(s_H, &s_compressedEdges[32*TOPRIGHT], &s_compressedEdges[32*BOTTOMLEFT], true /*//ocl//height_op()*/) != 0 )
changed = 1;
if (changed)
changedBlk = 1;
barrier(CLK_LOCAL_MEM_FENCE);
}
#endif
// Write back height
const Npp32s local_x = threadIdx.x;
const Npp32s local_y = threadIdx.y * 8;
for( Npp32s k=0; k<8; ++ k ) {
tile->height[(local_y+k) * 32 + local_x] = s_H[TILE_IDX2(local_y+k,local_x)];
}
}
// Block: 32x4

__kernel void _localRelabelActiveTiles(
__global graph_tile_8f* graph_tiles,
const Npp32s graph_tileWidth,
const Npp32s graph_tileHeight,
__global Npp32s* graph_layout,
__global Npp32s* graph_active_tile_count,
__global Npp32s* graph_active_tile_indexes
)
{
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
__local Npp32s s_H[34*35];
__local union edgeFlag_t s_compressedEdges[32*nbhd];
if( get_group_id(0) >= *graph_active_tile_count ) return;
__global graph_tile_8f* tile = &graph_tiles[graph_active_tile_indexes[get_group_id(0)]];
// Load Height to SMEM
readHeightTileWithApronIntoSMEM(graph_tileWidth, graph_tileHeight, graph_layout, graph_tiles, tile, s_H, 8);
// Load compressed graph to SMEM
int linearThreadIdx = threadIdx.y * 32 + threadIdx.x;
__local Npp32u* s_linearCompressedEdges = &s_compressedEdges[0].line;
__global Npp32u* g_linearCompressedEdges = &tile->compressed_edges[0].line;
for( Npp32s i = linearThreadIdx; i < 32 * nbhd; i+=32*4 ) {
s_linearCompressedEdges[i] = g_linearCompressedEdges[i];
}
barrier(CLK_LOCAL_MEM_FENCE);
const Npp32s local_x = threadIdx.x;
const Npp32s local_y = threadIdx.y * 8;
for( Npp32s k=0; k<8; ++k ) {
Npp32s height = s_H[TILE_IDX2(local_y+k, local_x)];
if( height > 0 ) {
height = HEIGHT_INF;
if( hasLeftEdgeLocal(s_compressedEdges, local_x, local_y+k) )
height = min(height, s_H[TILE_IDX2(local_y+k, local_x-1)]+1);
if( hasRightEdgeLocal(s_compressedEdges, local_x, local_y+k) )
height = min(height, s_H[TILE_IDX2(local_y+k, local_x+1)]+1);
if( hasTopEdgeLocal(s_compressedEdges, local_x, local_y+k) )
height = min(height, s_H[TILE_IDX2(local_y+k-1, local_x)]+1);
if( hasBottomEdgeLocal(s_compressedEdges, local_x, local_y+k) )
height = min(height, s_H[TILE_IDX2(local_y+k+1, local_x)]+1);
if( nbhd ==8 ) {
if( hasTopLeftEdgeLocal(s_compressedEdges, local_x, local_y+k) )
height = min(height, s_H[TILE_IDX2(local_y+k-1, local_x-1)]+1);
if( hasTopRightEdgeLocal(s_compressedEdges, local_x, local_y+k) )
height = min(height, s_H[TILE_IDX2(local_y+k-1, local_x+1)]+1);
if( hasBottomLeftEdgeLocal(s_compressedEdges, local_x, local_y+k) )
height = min(height, s_H[TILE_IDX2(local_y+k+1, local_x-1)]+1);
if( hasBottomRightEdgeLocal(s_compressedEdges, local_x, local_y+k) )
height = min(height, s_H[TILE_IDX2(local_y+k+1, local_x+1)]+1);
}
s_H[TILE_IDX2(local_y+k, local_x)] = height;
}
}
barrier(CLK_LOCAL_MEM_FENCE);
// Write back to gmem (without the apron)
for( Npp32s k=0; k<8; ++ k ) {
tile->height[(local_y+k) *32 + local_x] = s_H[TILE_IDX2(local_y+k,local_x)];
}
}

__kernel void _resetLabelAndFindLabelTiles(
__global graph_tile_8f* graph_tiles,
__global Npp32s* graph_active_tile_count,
__global Npp32s* graph_active_tile_indexes
)
{
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
__local Npp32s s_active;
s_active=0;
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[get_group_id(0)];
Npp32s active = 0;
Npp32s label = 0;
int x = threadIdx.x;
int y = threadIdx.y;
for( Npp32s k=0; k<4; ++k ) {
weight_t excess_flow = tile->terminals[y*32 + x];
Npp32s v_height = tile->height[y*32+x];
if( excess_flow < 0) {
// SINK
label = 0;
} else if( excess_flow > 0 &&  v_height >= HEIGHT_INF) {
// SOURCE
label = 1;
} else {
// UNKNOWN
label = 2;
active = 1;
}
tile->label[y*32+x] = label;
y+=8;
}
if( active )
s_active = 1;
barrier(CLK_LOCAL_MEM_FENCE);
if(  threadIdx.x+threadIdx.y == 0  ) {
if( s_active ) {
push_tile(graph_active_tile_indexes, graph_active_tile_count, tile);
}
}
}
// Block: 32x4

__kernel void _labelActiveTiles(
__global graph_tile_8f* graph_tiles,
const Npp32s graph_tileWidth,
const Npp32s graph_tileHeight,
__global Npp32s* graph_layout,
__global Npp32s* graph_active_tile_count,
__global Npp32s* graph_active_tile_indexes,
__global Npp32s* graph_flag
)
{
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
__local Npp32s s_L[34*35];
__local union edgeFlag_t s_compressedEdges[32*nbhd];
if( get_group_id(0) >= *graph_active_tile_count ) return;
__global graph_tile_8f* tile = &graph_tiles[graph_active_tile_indexes[get_group_id(0)]];
// Load Height to SMEM
readLabelTileWithApronIntoSMEM(graph_tileWidth, graph_tileHeight, graph_layout, graph_tiles, tile, s_L, 8);
// Load compressed graph to SMEM
int linearThreadIdx = threadIdx.y * 32 + threadIdx.x;
__local Npp32u* s_linearCompressedEdges = &s_compressedEdges[0].line;
__global Npp32u* g_linearCompressedEdges = &tile->compressed_edges[0].line;
for( Npp32s i = linearThreadIdx; i < 32 * nbhd; i+=32*4 ) {
s_linearCompressedEdges[i] = g_linearCompressedEdges[i];
}
Npp32s iteration = 0;
Npp32s changed = 1;
#ifdef NVIDIA
while( __syncthreads_or(changed) )
{
changed = 0;
if( relabelHorizontal( s_L, &s_compressedEdges[32*LEFT], &s_compressedEdges[32*RIGHT], false/*//ocl//label_op()*/) != 0 )
changed = 1;
if( relabelVertical(s_L, &s_compressedEdges[32*TOP], &s_compressedEdges[32*BOTTOM], false/*//ocl//label_op()*/) != 0 )
changed = 1;
if( relabelDiagonal1(s_L, &s_compressedEdges[32*TOPLEFT], &s_compressedEdges[32*BOTTOMRIGHT], false/*//ocl//label_op()*/) != 0 )
changed = 1;
if( relabelDiagonal2(s_L, &s_compressedEdges[32*TOPRIGHT], &s_compressedEdges[32*BOTTOMLEFT], false/*//ocl//label_op()*/) != 0 )
changed = 1;
iteration++;
}
#else
// do we need volatile here?
__local volatile Npp32s changedBlk;
changedBlk = 1;
barrier(CLK_LOCAL_MEM_FENCE);
while( changedBlk )
{
changed = 0;
barrier(CLK_LOCAL_MEM_FENCE);
changedBlk = 0;
if( relabelHorizontal( s_L, &s_compressedEdges[32*LEFT], &s_compressedEdges[32*RIGHT], false/*//ocl//label_op()*/) != 0 )
changed = 1;
if( relabelVertical(s_L, &s_compressedEdges[32*TOP], &s_compressedEdges[32*BOTTOM], false/*//ocl//label_op()*/) != 0 )
changed = 1;
if( relabelDiagonal1(s_L, &s_compressedEdges[32*TOPLEFT], &s_compressedEdges[32*BOTTOMRIGHT], false/*//ocl//label_op()*/) != 0 )
changed = 1;
if( relabelDiagonal2(s_L, &s_compressedEdges[32*TOPRIGHT], &s_compressedEdges[32*BOTTOMLEFT], false/*//ocl//label_op()*/) != 0 )
changed = 1;
iteration++;
// need this otherwise changedBlk = 1below may be overwrite by changedBlk=0 above
// but without this line, actually result is fine?
barrier(CLK_LOCAL_MEM_FENCE);
if (changed)
changedBlk = 1;
barrier(CLK_LOCAL_MEM_FENCE);
}
#endif
if( (iteration > 1) && (threadIdx.y == 0) )
*graph_flag = 1;
// Write back height
const Npp32s local_x = threadIdx.x;
const Npp32s local_y = threadIdx.y * 8;
for( Npp32s k=0; k<8; ++ k ) {
tile->label[(local_y+k) * 32 + local_x] = s_L[TILE_IDX2(local_y+k,local_x)];
}
}
/* add support for depth=8,16,32 channel=1,3,4 */
float interaction8b1cEnergy(float sG, const __global unsigned char* sGray, int neighborIndex, float neighborEnergyStrength, float colorSensitivity, float colorPower, float inverseDistance)
{
const float dG = sG - (float)sGray[neighborIndex];
const float colorDistance = powf(colorSensitivity * (dG*dG), colorPower);
const energy_type interactionEnergy = (energy_type)(neighborEnergyStrength * expf(-colorDistance) * inverseDistance);
return interactionEnergy;
}

__kernel void GraphcutRefineEdge_setup8b1cCapacities(
const __global Npp32s* graph_layout,
const Npp32s graph_tileWidth,
__global graph_tile_8f* graph_tiles,
__global unsigned char* sG_1_1,
const int sRowBytes,
const float neighborEnergyStrength,
const float colorSensitivity,
const float colorPower,
const float frozenEnergy,
const __global unsigned char* F,
const __global unsigned char* B,
const __global unsigned char* mask,
const int m_step,
const __global unsigned char* g_BorderRegion,
const int width,
const int height,
const int border_step,
const int startX,
const int startY,
const int validW,
const int validH
)
{
int2 blockIdx = (int2)(get_group_id(0), get_group_id(1));
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
int global_x = blockIdx.x * 32;
int global_y = blockIdx.y * 32;
//whole int tile_idx = graph_layout[blockIdx.y * graph_tileWidth + blockIdx.x];
int tile_idx = graph_layout[(startY/32 + blockIdx.y) * graph_tileWidth + startX/32 + blockIdx.x];
// Early exit if tile is empty
if( tile_idx < 0 ) return;
__local int s_M[34*35];
// Load Border Graph Tile to SMEM
const Npp32s elementsPerThread = 4;
//whole readTileWithApronIntoSMEM( s_M, g_BorderRegion, m_step, 128, width, height, elementsPerThread);
readTileWithApronIntoSMEM_tileBased( s_M, (g_BorderRegion+border_step+1), border_step, 128, width, height, elementsPerThread,
startX, startY, validW, validH);
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[tile_idx];
//tile->pos = make_ushort2(blockIdx.x, blockIdx.y);
//whole tile->pos = (ushort2)(blockIdx.x, blockIdx.y);
tile->pos = (ushort2)(((startX/32)+blockIdx.x), ((startY/32)+blockIdx.y));
int local_x = threadIdx.x;
int local_y = threadIdx.y * 4;
for( int k=0; k < 4; ++k ) {
//whole if( global_x + local_x < width && global_y + local_y + k < height ) {
if( global_x + local_x < validW && global_y + local_y + k < validH ) {
int s = mask[(global_y + local_y + k) * m_step + global_x + local_x];
int h = s_M[TILE_IDX2(local_y+k,local_x)];
bool isBoundary = false;
if( h > 200 ) {
// Pixel is part of the border graph
int index = (global_y + local_y + k) * sRowBytes + global_x + local_x;
__global unsigned char* sG = sG_1_1 + sRowBytes + 1;
float center = (float)(
sG[index]
);
// Left
if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 255 ) {
tile->edges[32*32*LEFT+local_x*32+local_y+k] = interaction8b1cEnergy(center, sG, index - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// RIGHT
if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 255 ){
tile->edges[32*32*RIGHT+local_x*32+local_y+k] = interaction8b1cEnergy(center, sG, index + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP LEFT
if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 255 ) {
tile->edges[32*32*TOPLEFT+(local_y+k)*32+local_x] = interaction8b1cEnergy(center, sG, index - sRowBytes - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM LEFT
if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 255 ) {
tile->edges[32*32*BOTTOMLEFT+(local_y+k)*32+local_x] = interaction8b1cEnergy(center, sG, index + sRowBytes - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// TOP RIGHT
if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 255 ) {
tile->edges[32*32*TOPRIGHT+(local_y+k)*32+local_x] = interaction8b1cEnergy(center, sG, index - sRowBytes + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM RIGHT
if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 255 ) {
tile->edges[32*32*BOTTOMRIGHT+(local_y+k)*32+local_x] = interaction8b1cEnergy(center, sG, index + sRowBytes + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM
if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 255 ) {
tile->edges[32*32*BOTTOM+(local_y+k)*32+local_x] = interaction8b1cEnergy(center, sG, index + sRowBytes, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP
if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 255 ) {
tile->edges[32*32*TOP+(local_y+k)*32+local_x] = interaction8b1cEnergy(center, sG, index - sRowBytes, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// Terminal Energies
if( isBoundary ) {
float sign = s > 128 ? -1.0f : 1.0f;
tile->terminals[(local_y+k) * 32 + local_x]	= sign * frozenEnergy;
}
if( F[(global_y + local_y + k) * m_step + global_x + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = -frozenEnergy;
if( B[(global_y + local_y+k) * m_step + global_x + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = frozenEnergy;
}
}
}
}
float interaction16b1cEnergy(float sG, const __global ushort *sGray, int neighborIndex, float neighborEnergyStrength, float colorSensitivity, float colorPower, float inverseDistance)
{
const float dG = sG - (float)sGray[neighborIndex];
const float colorDistance = powf(colorSensitivity * (dG*dG), colorPower);
const energy_type interactionEnergy = (energy_type)(neighborEnergyStrength * expf(-colorDistance) * inverseDistance);
return interactionEnergy;
}

__kernel void GraphcutRefineEdge_setup16b1cCapacities(
const __global Npp32s* graph_layout,
const Npp32s graph_tileWidth,
__global graph_tile_8f* graph_tiles,
__global ushort *sG_1_1,
const int sRowBytes,
const float neighborEnergyStrength,
const float colorSensitivity,
const float colorPower,
const float frozenEnergy,
const __global unsigned char* F,
const __global unsigned char* B,
const __global unsigned char* mask,
const int m_step,
const __global unsigned char* g_BorderRegion,
const int width,
const int height,
const int border_step,
const int startX,
const int startY,
const int validW,
const int validH
)
{
int2 blockIdx = (int2)(get_group_id(0), get_group_id(1));
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
int global_x = blockIdx.x * 32;
int global_y = blockIdx.y * 32;
//whole int tile_idx = graph_layout[blockIdx.y * graph_tileWidth + blockIdx.x];
int tile_idx = graph_layout[(startY/32 + blockIdx.y) * graph_tileWidth + startX/32 + blockIdx.x];
// Early exit if tile is empty
if( tile_idx < 0 ) return;
__local int s_M[34*35];
// Load Border Graph Tile to SMEM
const Npp32s elementsPerThread = 4;
//whole readTileWithApronIntoSMEM( s_M, g_BorderRegion, m_step, 128, width, height, elementsPerThread);
readTileWithApronIntoSMEM_tileBased( s_M, (g_BorderRegion+border_step+1), border_step, 128, width, height, elementsPerThread,
startX, startY, validW, validH);
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[tile_idx];
//tile->pos = make_ushort2(blockIdx.x, blockIdx.y);
//whole tile->pos = (ushort2)(blockIdx.x, blockIdx.y);
tile->pos = (ushort2)(((startX/32)+blockIdx.x), ((startY/32)+blockIdx.y));
int local_x = threadIdx.x;
int local_y = threadIdx.y * 4;
for( int k=0; k < 4; ++k ) {
//whole if( global_x + local_x < width && global_y + local_y + k < height ) {
if( global_x + local_x < validW && global_y + local_y + k < validH ) {
int s = mask[(global_y + local_y + k) * m_step + global_x + local_x];
int h = s_M[TILE_IDX2(local_y+k,local_x)];
bool isBoundary = false;
if( h > 200 ) {
// Pixel is part of the border graph
int index = (global_y + local_y + k) * (sRowBytes>>1) + global_x + local_x;
__global ushort *sG = sG_1_1 + (sRowBytes>>1) + 1;
float center = (float)(
sG[index]
);
// Left
if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 255 ) {
tile->edges[32*32*LEFT+local_x*32+local_y+k] = interaction16b1cEnergy(center, sG, index - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// RIGHT
if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 255 ){
tile->edges[32*32*RIGHT+local_x*32+local_y+k] = interaction16b1cEnergy(center, sG, index + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP LEFT
if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 255 ) {
tile->edges[32*32*TOPLEFT+(local_y+k)*32+local_x] = interaction16b1cEnergy(center, sG, index - (sRowBytes>>1) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM LEFT
if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 255 ) {
tile->edges[32*32*BOTTOMLEFT+(local_y+k)*32+local_x] = interaction16b1cEnergy(center, sG, index + (sRowBytes>>1) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// TOP RIGHT
if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 255 ) {
tile->edges[32*32*TOPRIGHT+(local_y+k)*32+local_x] = interaction16b1cEnergy(center, sG, index - (sRowBytes>>1) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM RIGHT
if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 255 ) {
tile->edges[32*32*BOTTOMRIGHT+(local_y+k)*32+local_x] = interaction16b1cEnergy(center, sG, index + (sRowBytes>>1) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM
if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 255 ) {
tile->edges[32*32*BOTTOM+(local_y+k)*32+local_x] = interaction16b1cEnergy(center, sG, index + (sRowBytes>>1), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP
if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 255 ) {
tile->edges[32*32*TOP+(local_y+k)*32+local_x] = interaction16b1cEnergy(center, sG, index - (sRowBytes>>1), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// Terminal Energies
if( isBoundary ) {
float sign = s > 128 ? -1.0f : 1.0f;
tile->terminals[(local_y+k) * 32 + local_x]	= sign * frozenEnergy;
}
if( F[(global_y + local_y + k) * m_step + global_x + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = -frozenEnergy;
if( B[(global_y + local_y+k) * m_step + global_x + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = frozenEnergy;
}
}
}
}
float interaction16b3cEnergy(float3 sRGB, const __global ushort *sR, const __global ushort *sG, const __global ushort *sB, int neighborIndex, float neighborEnergyStrength, float colorSensitivity, float colorPower, float inverseDistance)
{
const float dR = sRGB.x - (float)sR[neighborIndex];
const float dG = sRGB.y - (float)sG[neighborIndex];
const float dB = sRGB.z - (float)sB[neighborIndex];
const float colorDistance = powf(colorSensitivity * (dR*dR + dG*dG + dB*dB), colorPower);
const energy_type interactionEnergy = (energy_type)(neighborEnergyStrength * expf(-colorDistance) * inverseDistance);
return interactionEnergy;
}

__kernel void GraphcutRefineEdge_setup16b3cCapacities(
const __global Npp32s* graph_layout,
const Npp32s graph_tileWidth,
__global graph_tile_8f* graph_tiles,
__global ushort *sR_1_1,
__global ushort *sG_1_1,
__global ushort *sB_1_1,
const int sRowBytes,
const float neighborEnergyStrength,
const float colorSensitivity,
const float colorPower,
const float frozenEnergy,
const __global unsigned char* F,
const __global unsigned char* B,
const __global unsigned char* mask,
const int m_step,
const __global unsigned char* g_BorderRegion,
const int width,
const int height,
const int border_step,
const int startX,
const int startY,
const int validW,
const int validH
)
{
int2 blockIdx = (int2)(get_group_id(0), get_group_id(1));
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
int global_x = blockIdx.x * 32;
int global_y = blockIdx.y * 32;
//whole int tile_idx = graph_layout[blockIdx.y * graph_tileWidth + blockIdx.x];
int tile_idx = graph_layout[(startY/32 + blockIdx.y) * graph_tileWidth + startX/32 + blockIdx.x];
// Early exit if tile is empty
if( tile_idx < 0 ) return;
__local int s_M[34*35];
// Load Border Graph Tile to SMEM
const Npp32s elementsPerThread = 4;
//whole readTileWithApronIntoSMEM( s_M, g_BorderRegion, m_step, 128, width, height, elementsPerThread);
readTileWithApronIntoSMEM_tileBased( s_M, (g_BorderRegion+border_step+1), border_step, 128, width, height, elementsPerThread,
startX, startY, validW, validH);
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[tile_idx];
//tile->pos = make_ushort2(blockIdx.x, blockIdx.y);
//whole tile->pos = (ushort2)(blockIdx.x, blockIdx.y);
tile->pos = (ushort2)(((startX/32)+blockIdx.x), ((startY/32)+blockIdx.y));
int local_x = threadIdx.x;
int local_y = threadIdx.y * 4;
for( int k=0; k < 4; ++k ) {
//whole if( global_x + local_x < width && global_y + local_y + k < height ) {
if( global_x + local_x < validW && global_y + local_y + k < validH ) {
int s = mask[(global_y + local_y + k) * m_step + global_x + local_x];
int h = s_M[TILE_IDX2(local_y+k,local_x)];
bool isBoundary = false;
if( h > 200 ) {
// Pixel is part of the border graph
int index = (global_y + local_y + k) * (sRowBytes>>1) + global_x + local_x;
__global ushort *sR = sR_1_1 + (sRowBytes>>1) + 1;
__global ushort *sG = sG_1_1 + (sRowBytes>>1) + 1;
__global ushort *sB = sB_1_1 + (sRowBytes>>1) + 1;
float3 center = (float3)(
sR[index],
sG[index],
sB[index]
);
// Left
if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 255 ) {
tile->edges[32*32*LEFT+local_x*32+local_y+k] = interaction16b3cEnergy(center, sR, sG, sB, index - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// RIGHT
if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 255 ){
tile->edges[32*32*RIGHT+local_x*32+local_y+k] = interaction16b3cEnergy(center, sR, sG, sB, index + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP LEFT
if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 255 ) {
tile->edges[32*32*TOPLEFT+(local_y+k)*32+local_x] = interaction16b3cEnergy(center, sR, sG, sB, index - (sRowBytes>>1) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM LEFT
if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 255 ) {
tile->edges[32*32*BOTTOMLEFT+(local_y+k)*32+local_x] = interaction16b3cEnergy(center, sR, sG, sB, index + (sRowBytes>>1) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// TOP RIGHT
if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 255 ) {
tile->edges[32*32*TOPRIGHT+(local_y+k)*32+local_x] = interaction16b3cEnergy(center, sR, sG, sB, index - (sRowBytes>>1) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM RIGHT
if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 255 ) {
tile->edges[32*32*BOTTOMRIGHT+(local_y+k)*32+local_x] = interaction16b3cEnergy(center, sR, sG, sB, index + (sRowBytes>>1) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM
if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 255 ) {
tile->edges[32*32*BOTTOM+(local_y+k)*32+local_x] = interaction16b3cEnergy(center, sR, sG, sB, index + (sRowBytes>>1), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP
if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 255 ) {
tile->edges[32*32*TOP+(local_y+k)*32+local_x] = interaction16b3cEnergy(center, sR, sG, sB, index - (sRowBytes>>1), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// Terminal Energies
if( isBoundary ) {
float sign = s > 128 ? -1.0f : 1.0f;
tile->terminals[(local_y+k) * 32 + local_x]	= sign * frozenEnergy;
}
if( F[(global_y + local_y + k) * m_step + global_x + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = -frozenEnergy;
if( B[(global_y + local_y+k) * m_step + global_x + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = frozenEnergy;
}
}
}
}
float interaction32b1cEnergy(float sG, const __global float *sGray, int neighborIndex, float neighborEnergyStrength, float colorSensitivity, float colorPower, float inverseDistance)
{
const float dG = sG - (float)sGray[neighborIndex];
const float colorDistance = powf(colorSensitivity * (dG*dG), colorPower);
const energy_type interactionEnergy = (energy_type)(neighborEnergyStrength * expf(-colorDistance) * inverseDistance);
return interactionEnergy;
}

__kernel void GraphcutRefineEdge_setup32b1cCapacities(
const __global Npp32s* graph_layout,
const Npp32s graph_tileWidth,
__global graph_tile_8f* graph_tiles,
__global float *sG_1_1,
const int sRowBytes,
const float neighborEnergyStrength,
const float colorSensitivity,
const float colorPower,
const float frozenEnergy,
const __global unsigned char* F,
const __global unsigned char* B,
const __global unsigned char* mask,
const int m_step,
const __global unsigned char* g_BorderRegion,
const int width,
const int height,
const int border_step,
const int startX,
const int startY,
const int validW,
const int validH
)
{
int2 blockIdx = (int2)(get_group_id(0), get_group_id(1));
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
int global_x = blockIdx.x * 32;
int global_y = blockIdx.y * 32;
//whole int tile_idx = graph_layout[blockIdx.y * graph_tileWidth + blockIdx.x];
int tile_idx = graph_layout[(startY/32 + blockIdx.y) * graph_tileWidth + startX/32 + blockIdx.x];
// Early exit if tile is empty
if( tile_idx < 0 ) return;
__local int s_M[34*35];
// Load Border Graph Tile to SMEM
const Npp32s elementsPerThread = 4;
//whole readTileWithApronIntoSMEM( s_M, g_BorderRegion, m_step, 128, width, height, elementsPerThread);
readTileWithApronIntoSMEM_tileBased( s_M, (g_BorderRegion+border_step+1), border_step, 128, width, height, elementsPerThread,
startX, startY, validW, validH);
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[tile_idx];
//tile->pos = make_ushort2(blockIdx.x, blockIdx.y);
//whole tile->pos = (ushort2)(blockIdx.x, blockIdx.y);
tile->pos = (ushort2)(((startX/32)+blockIdx.x), ((startY/32)+blockIdx.y));
int local_x = threadIdx.x;
int local_y = threadIdx.y * 4;
for( int k=0; k < 4; ++k ) {
//whole if( global_x + local_x < width && global_y + local_y + k < height ) {
if( global_x + local_x < validW && global_y + local_y + k < validH ) {
int s = mask[(global_y + local_y + k) * m_step + global_x + local_x];
int h = s_M[TILE_IDX2(local_y+k,local_x)];
bool isBoundary = false;
if( h > 200 ) {
// Pixel is part of the border graph
int index = (global_y + local_y + k) * (sRowBytes>>2) + global_x + local_x;
__global float *sG = sG_1_1 + (sRowBytes>>2) + 1;
float center = (float)(
sG[index]
);
// Left
if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 255 ) {
tile->edges[32*32*LEFT+local_x*32+local_y+k] = interaction32b1cEnergy(center, sG, index - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// RIGHT
if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 255 ){
tile->edges[32*32*RIGHT+local_x*32+local_y+k] = interaction32b1cEnergy(center, sG, index + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP LEFT
if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 255 ) {
tile->edges[32*32*TOPLEFT+(local_y+k)*32+local_x] = interaction32b1cEnergy(center, sG, index - (sRowBytes>>2) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM LEFT
if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 255 ) {
tile->edges[32*32*BOTTOMLEFT+(local_y+k)*32+local_x] = interaction32b1cEnergy(center, sG, index + (sRowBytes>>2) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// TOP RIGHT
if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 255 ) {
tile->edges[32*32*TOPRIGHT+(local_y+k)*32+local_x] = interaction32b1cEnergy(center, sG, index - (sRowBytes>>2) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM RIGHT
if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 255 ) {
tile->edges[32*32*BOTTOMRIGHT+(local_y+k)*32+local_x] = interaction32b1cEnergy(center, sG, index + (sRowBytes>>2) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM
if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 255 ) {
tile->edges[32*32*BOTTOM+(local_y+k)*32+local_x] = interaction32b1cEnergy(center, sG, index + (sRowBytes>>2), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP
if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 255 ) {
tile->edges[32*32*TOP+(local_y+k)*32+local_x] = interaction32b1cEnergy(center, sG, index - (sRowBytes>>2), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// Terminal Energies
if( isBoundary ) {
float sign = s > 128 ? -1.0f : 1.0f;
tile->terminals[(local_y+k) * 32 + local_x]	= sign * frozenEnergy;
}
if( F[(global_y + local_y + k) * m_step + global_x + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = -frozenEnergy;
if( B[(global_y + local_y+k) * m_step + global_x + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = frozenEnergy;
}
}
}
}
float interaction32b3cEnergy(float3 sRGB, const __global float *sR, const __global float *sG, const __global float *sB, int neighborIndex, float neighborEnergyStrength, float colorSensitivity, float colorPower, float inverseDistance)
{
const float dR = sRGB.x - (float)sR[neighborIndex];
const float dG = sRGB.y - (float)sG[neighborIndex];
const float dB = sRGB.z - (float)sB[neighborIndex];
const float colorDistance = powf(colorSensitivity * (dR*dR + dG*dG + dB*dB), colorPower);
const energy_type interactionEnergy = (energy_type)(neighborEnergyStrength * expf(-colorDistance) * inverseDistance);
return interactionEnergy;
}

__kernel void GraphcutRefineEdge_setup32b3cCapacities(
const __global Npp32s* graph_layout,
const Npp32s graph_tileWidth,
__global graph_tile_8f* graph_tiles,
__global float *sR_1_1,
__global float *sG_1_1,
__global float *sB_1_1,
const int sRowBytes,
const float neighborEnergyStrength,
const float colorSensitivity,
const float colorPower,
const float frozenEnergy,
const __global unsigned char* F,
const __global unsigned char* B,
const __global unsigned char* mask,
const int m_step,
const __global unsigned char* g_BorderRegion,
const int width,
const int height,
const int border_step,
const int startX,
const int startY,
const int validW,
const int validH
)
{
int2 blockIdx = (int2)(get_group_id(0), get_group_id(1));
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
int global_x = blockIdx.x * 32;
int global_y = blockIdx.y * 32;
//whole int tile_idx = graph_layout[blockIdx.y * graph_tileWidth + blockIdx.x];
int tile_idx = graph_layout[(startY/32 + blockIdx.y) * graph_tileWidth + startX/32 + blockIdx.x];
// Early exit if tile is empty
if( tile_idx < 0 ) return;
__local int s_M[34*35];
// Load Border Graph Tile to SMEM
const Npp32s elementsPerThread = 4;
//whole readTileWithApronIntoSMEM( s_M, g_BorderRegion, m_step, 128, width, height, elementsPerThread);
readTileWithApronIntoSMEM_tileBased( s_M, (g_BorderRegion+border_step+1), border_step, 128, width, height, elementsPerThread,
startX, startY, validW, validH);
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[tile_idx];
//tile->pos = make_ushort2(blockIdx.x, blockIdx.y);
//whole tile->pos = (ushort2)(blockIdx.x, blockIdx.y);
tile->pos = (ushort2)(((startX/32)+blockIdx.x), ((startY/32)+blockIdx.y));
int local_x = threadIdx.x;
int local_y = threadIdx.y * 4;
for( int k=0; k < 4; ++k ) {
//whole if( global_x + local_x < width && global_y + local_y + k < height ) {
if( global_x + local_x < validW && global_y + local_y + k < validH ) {
int s = mask[(global_y + local_y + k) * m_step + global_x + local_x];
int h = s_M[TILE_IDX2(local_y+k,local_x)];
bool isBoundary = false;
if( h > 200 ) {
// Pixel is part of the border graph
int index = (global_y + local_y + k) * (sRowBytes>>2) + global_x + local_x;
__global float *sR = sR_1_1 + (sRowBytes>>2) + 1;
__global float *sG = sG_1_1 + (sRowBytes>>2) + 1;
__global float *sB = sB_1_1 + (sRowBytes>>2) + 1;
float3 center = (float3)(
sR[index],
sG[index],
sB[index]
);
// Left
if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 255 ) {
tile->edges[32*32*LEFT+local_x*32+local_y+k] = interaction32b3cEnergy(center, sR, sG, sB, index - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// RIGHT
if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 255 ){
tile->edges[32*32*RIGHT+local_x*32+local_y+k] = interaction32b3cEnergy(center, sR, sG, sB, index + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP LEFT
if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 255 ) {
tile->edges[32*32*TOPLEFT+(local_y+k)*32+local_x] = interaction32b3cEnergy(center, sR, sG, sB, index - (sRowBytes>>2) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM LEFT
if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 255 ) {
tile->edges[32*32*BOTTOMLEFT+(local_y+k)*32+local_x] = interaction32b3cEnergy(center, sR, sG, sB, index + (sRowBytes>>2) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// TOP RIGHT
if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 255 ) {
tile->edges[32*32*TOPRIGHT+(local_y+k)*32+local_x] = interaction32b3cEnergy(center, sR, sG, sB, index - (sRowBytes>>2) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM RIGHT
if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 255 ) {
tile->edges[32*32*BOTTOMRIGHT+(local_y+k)*32+local_x] = interaction32b3cEnergy(center, sR, sG, sB, index + (sRowBytes>>2) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM
if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 255 ) {
tile->edges[32*32*BOTTOM+(local_y+k)*32+local_x] = interaction32b3cEnergy(center, sR, sG, sB, index + (sRowBytes>>2), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP
if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 255 ) {
tile->edges[32*32*TOP+(local_y+k)*32+local_x] = interaction32b3cEnergy(center, sR, sG, sB, index - (sRowBytes>>2), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// Terminal Energies
if( isBoundary ) {
float sign = s > 128 ? -1.0f : 1.0f;
tile->terminals[(local_y+k) * 32 + local_x]	= sign * frozenEnergy;
}
if( F[(global_y + local_y + k) * m_step + global_x + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = -frozenEnergy;
if( B[(global_y + local_y+k) * m_step + global_x + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = frozenEnergy;
}
}
}
}

__kernel void GraphcutRefineEdge_setupOneBuf8b1cCapacities(
const __global Npp32s* graph_layout,
const Npp32s graph_tileWidth,
__global graph_tile_8f* graph_tiles,
const __global unsigned char* sG_1_1,
const int sRowBytes,
const float neighborEnergyStrength,
const float colorSensitivity,
const float colorPower,
const float frozenEnergy,
const __global unsigned char* F,
const __global unsigned char* B,
const __global unsigned char* mask,
const int m_step,
const __global unsigned char* g_BorderRegion,
const int width,
const int height,
const int border_step,
const int startX,
const int startY,
const int validW,
const int validH,
const __global int* posIdx,
const __global int* posX,
const __global int* posY,
const int NopdBufSize,
const int BorPaddBufSize,
const int SrcPaddBufSize
)
{
int2 blockIdx = (int2)(get_group_id(0), get_group_id(1));
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
//OneBig	//int global_x = blockIdx.x * 32;
//OneBig	//int global_y = blockIdx.y * 32;
int global_x = posX[blockIdx.x]; //abs coord
int global_y = posY[blockIdx.x];
//whole int tile_idx = graph_layout[blockIdx.y * graph_tileWidth + blockIdx.x];
//OneBig	//int tile_idx = graph_layout[(startY/32 + blockIdx.y) * graph_tileWidth + startX/32 + blockIdx.x];
int tile_idx = posIdx[blockIdx.x];
// Early exit if tile is empty
if( tile_idx < 0 ) return;
__local int s_M[34*35];
// Load Border Graph Tile to SMEM
const Npp32s elementsPerThread = 4;
//whole readTileWithApronIntoSMEM( s_M, g_BorderRegion, m_step, 128, width, height, elementsPerThread);
//OneBig	readTileWithApronIntoSMEM_tileBased( s_M, (g_BorderRegion+border_step+1), border_step, 128, width, height, elementsPerThread,
//OneBig		startX, startY, validW, validH);
readTileWithApronIntoSMEM_oneBufBased( s_M, (g_BorderRegion+(blockIdx.x*BorPaddBufSize)+border_step+1), border_step, 128, width, height, elementsPerThread,
global_x, global_y, validW, validH);
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[tile_idx];
//tile->pos = make_ushort2(blockIdx.x, blockIdx.y);
//whole tile->pos = (ushort2)(blockIdx.x, blockIdx.y);
//OneBig	tile->pos = (ushort2)(((startX/32)+blockIdx.x), ((startY/32)+blockIdx.y));
tile->pos = (ushort2)(global_x/32, global_y/32);
int local_x = threadIdx.x;
int local_y = threadIdx.y * 4;
for( int k=0; k < 4; ++k ) {
//whole if( global_x + local_x < width && global_y + local_y + k < height ) {
//OneBig		if( global_x + local_x < validW && global_y + local_y + k < validH ) {
if( global_x + local_x < width && global_y + local_y + k < height ) {
//OneBig			int s = mask[(global_y + local_y + k) * m_step + global_x + local_x];
int s = mask[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x];
int h = s_M[TILE_IDX2(local_y+k,local_x)];
bool isBoundary = false;
if( h > 200 ) {
// Pixel is part of the border graph
//OneBig				int index = (global_y + local_y + k) * sRowBytes + global_x + local_x;
int index = blockIdx.x*SrcPaddBufSize + (local_y + k) * sRowBytes + local_x;
__global unsigned char* sG = sG_1_1 + sRowBytes + 1;
float center = (float)(
sG[index]
);
// Left
if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 255 ) {
tile->edges[32*32*LEFT+local_x*32+local_y+k] = interaction8b1cEnergy(center, sG, index - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// RIGHT
if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 255 ){
tile->edges[32*32*RIGHT+local_x*32+local_y+k] = interaction8b1cEnergy(center, sG, index + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP LEFT
if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 255 ) {
tile->edges[32*32*TOPLEFT+(local_y+k)*32+local_x] = interaction8b1cEnergy(center, sG, index - sRowBytes - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM LEFT
if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 255 ) {
tile->edges[32*32*BOTTOMLEFT+(local_y+k)*32+local_x] = interaction8b1cEnergy(center, sG, index + sRowBytes - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// TOP RIGHT
if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 255 ) {
tile->edges[32*32*TOPRIGHT+(local_y+k)*32+local_x] = interaction8b1cEnergy(center, sG, index - sRowBytes + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM RIGHT
if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 255 ) {
tile->edges[32*32*BOTTOMRIGHT+(local_y+k)*32+local_x] = interaction8b1cEnergy(center, sG, index + sRowBytes + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM
if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 255 ) {
tile->edges[32*32*BOTTOM+(local_y+k)*32+local_x] = interaction8b1cEnergy(center, sG, index + sRowBytes, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP
if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 255 ) {
tile->edges[32*32*TOP+(local_y+k)*32+local_x] = interaction8b1cEnergy(center, sG, index - sRowBytes, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// Terminal Energies
if( isBoundary ) {
float sign = s > 128 ? -1.0f : 1.0f;
tile->terminals[(local_y+k) * 32 + local_x]	= sign * frozenEnergy;
}
//OneBig				if( F[(global_y + local_y + k) * m_step + global_x + local_x] > 128 )
if( F[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = -frozenEnergy;
//OneBig				if( B[(global_y + local_y+k) * m_step + global_x + local_x] > 128 )
if( B[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = frozenEnergy;
}
}
}
}

__kernel void GraphcutRefineEdge_setupOneBuf16b1cCapacities(
const __global Npp32s* graph_layout,
const Npp32s graph_tileWidth,
__global graph_tile_8f* graph_tiles,
const __global ushort *sG_1_1,
const int sRowBytes,
const float neighborEnergyStrength,
const float colorSensitivity,
const float colorPower,
const float frozenEnergy,
const __global unsigned char* F,
const __global unsigned char* B,
const __global unsigned char* mask,
const int m_step,
const __global unsigned char* g_BorderRegion,
const int width,
const int height,
const int border_step,
const int startX,
const int startY,
const int validW,
const int validH,
const __global int* posIdx,
const __global int* posX,
const __global int* posY,
const int NopdBufSize,
const int BorPaddBufSize,
const int SrcPaddBufSize
)
{
int2 blockIdx = (int2)(get_group_id(0), get_group_id(1));
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
//OneBig	//int global_x = blockIdx.x * 32;
//OneBig	//int global_y = blockIdx.y * 32;
int global_x = posX[blockIdx.x]; //abs coord
int global_y = posY[blockIdx.x];
//whole int tile_idx = graph_layout[blockIdx.y * graph_tileWidth + blockIdx.x];
//OneBig	//int tile_idx = graph_layout[(startY/32 + blockIdx.y) * graph_tileWidth + startX/32 + blockIdx.x];
int tile_idx = posIdx[blockIdx.x];
// Early exit if tile is empty
if( tile_idx < 0 ) return;
__local int s_M[34*35];
// Load Border Graph Tile to SMEM
const Npp32s elementsPerThread = 4;
//whole readTileWithApronIntoSMEM( s_M, g_BorderRegion, m_step, 128, width, height, elementsPerThread);
//OneBig	readTileWithApronIntoSMEM_tileBased( s_M, (g_BorderRegion+border_step+1), border_step, 128, width, height, elementsPerThread,
//OneBig		startX, startY, validW, validH);
readTileWithApronIntoSMEM_oneBufBased( s_M, (g_BorderRegion+(blockIdx.x*BorPaddBufSize)+border_step+1), border_step, 128, width, height, elementsPerThread,
global_x, global_y, validW, validH);
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[tile_idx];
//tile->pos = make_ushort2(blockIdx.x, blockIdx.y);
//whole tile->pos = (ushort2)(blockIdx.x, blockIdx.y);
//OneBig	tile->pos = (ushort2)(((startX/32)+blockIdx.x), ((startY/32)+blockIdx.y));
tile->pos = (ushort2)(global_x/32, global_y/32);
int local_x = threadIdx.x;
int local_y = threadIdx.y * 4;
for( int k=0; k < 4; ++k ) {
//whole if( global_x + local_x < width && global_y + local_y + k < height ) {
//OneBig		if( global_x + local_x < validW && global_y + local_y + k < validH ) {
if( global_x + local_x < width && global_y + local_y + k < height ) {
//OneBig			int s = mask[(global_y + local_y + k) * m_step + global_x + local_x];
int s = mask[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x];
int h = s_M[TILE_IDX2(local_y+k,local_x)];
bool isBoundary = false;
if( h > 200 ) {
// Pixel is part of the border graph
//OneBig				int index = (global_y + local_y + k) * (sRowBytes>>1) + global_x + local_x;
int index = ((blockIdx.x*SrcPaddBufSize + (local_y + k) * sRowBytes)>>1) + local_x;
__global ushort *sG = sG_1_1 + (sRowBytes>>1) + 1;
float center = (float)(
sG[index]
);
// Left
if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 255 ) {
tile->edges[32*32*LEFT+local_x*32+local_y+k] = interaction16b1cEnergy(center, sG, index - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// RIGHT
if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 255 ){
tile->edges[32*32*RIGHT+local_x*32+local_y+k] = interaction16b1cEnergy(center, sG, index + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP LEFT
if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 255 ) {
tile->edges[32*32*TOPLEFT+(local_y+k)*32+local_x] = interaction16b1cEnergy(center, sG, index - (sRowBytes>>1) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM LEFT
if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 255 ) {
tile->edges[32*32*BOTTOMLEFT+(local_y+k)*32+local_x] = interaction16b1cEnergy(center, sG, index + (sRowBytes>>1) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// TOP RIGHT
if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 255 ) {
tile->edges[32*32*TOPRIGHT+(local_y+k)*32+local_x] = interaction16b1cEnergy(center, sG, index - (sRowBytes>>1) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM RIGHT
if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 255 ) {
tile->edges[32*32*BOTTOMRIGHT+(local_y+k)*32+local_x] = interaction16b1cEnergy(center, sG, index + (sRowBytes>>1) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM
if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 255 ) {
tile->edges[32*32*BOTTOM+(local_y+k)*32+local_x] = interaction16b1cEnergy(center, sG, index + (sRowBytes>>1), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP
if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 255 ) {
tile->edges[32*32*TOP+(local_y+k)*32+local_x] = interaction16b1cEnergy(center, sG, index - (sRowBytes>>1), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// Terminal Energies
if( isBoundary ) {
float sign = s > 128 ? -1.0f : 1.0f;
tile->terminals[(local_y+k) * 32 + local_x]	= sign * frozenEnergy;
}
//OneBig				if( F[(global_y + local_y + k) * m_step + global_x + local_x] > 128 )
if( F[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = -frozenEnergy;
//OneBig				if( B[(global_y + local_y+k) * m_step + global_x + local_x] > 128 )
if( B[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = frozenEnergy;
}
}
}
}

__kernel void GraphcutRefineEdge_setupOneBuf16b3cCapacities(
const __global Npp32s* graph_layout,
const Npp32s graph_tileWidth,
__global graph_tile_8f* graph_tiles,
const __global ushort *sR_1_1,
const __global ushort *sG_1_1,
const __global ushort *sB_1_1,
const int sRowBytes,
const float neighborEnergyStrength,
const float colorSensitivity,
const float colorPower,
const float frozenEnergy,
const __global unsigned char* F,
const __global unsigned char* B,
const __global unsigned char* mask,
const int m_step,
const __global unsigned char* g_BorderRegion,
const int width,
const int height,
const int border_step,
const int startX,
const int startY,
const int validW,
const int validH,
const __global int* posIdx,
const __global int* posX,
const __global int* posY,
const int NopdBufSize,
const int BorPaddBufSize,
const int SrcPaddBufSize
)
{
int2 blockIdx = (int2)(get_group_id(0), get_group_id(1));
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
//OneBig	//int global_x = blockIdx.x * 32;
//OneBig	//int global_y = blockIdx.y * 32;
int global_x = posX[blockIdx.x]; //abs coord
int global_y = posY[blockIdx.x];
//whole int tile_idx = graph_layout[blockIdx.y * graph_tileWidth + blockIdx.x];
//OneBig	//int tile_idx = graph_layout[(startY/32 + blockIdx.y) * graph_tileWidth + startX/32 + blockIdx.x];
int tile_idx = posIdx[blockIdx.x];
// Early exit if tile is empty
if( tile_idx < 0 ) return;
__local int s_M[34*35];
// Load Border Graph Tile to SMEM
const Npp32s elementsPerThread = 4;
//whole readTileWithApronIntoSMEM( s_M, g_BorderRegion, m_step, 128, width, height, elementsPerThread);
//OneBig	readTileWithApronIntoSMEM_tileBased( s_M, (g_BorderRegion+border_step+1), border_step, 128, width, height, elementsPerThread,
//OneBig		startX, startY, validW, validH);
readTileWithApronIntoSMEM_oneBufBased( s_M, (g_BorderRegion+(blockIdx.x*BorPaddBufSize)+border_step+1), border_step, 128, width, height, elementsPerThread,
global_x, global_y, validW, validH);
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[tile_idx];
//tile->pos = make_ushort2(blockIdx.x, blockIdx.y);
//whole tile->pos = (ushort2)(blockIdx.x, blockIdx.y);
//OneBig	tile->pos = (ushort2)(((startX/32)+blockIdx.x), ((startY/32)+blockIdx.y));
tile->pos = (ushort2)(global_x/32, global_y/32);
int local_x = threadIdx.x;
int local_y = threadIdx.y * 4;
for( int k=0; k < 4; ++k ) {
//whole if( global_x + local_x < width && global_y + local_y + k < height ) {
//OneBig		if( global_x + local_x < validW && global_y + local_y + k < validH ) {
if( global_x + local_x < width && global_y + local_y + k < height ) {
//OneBig			int s = mask[(global_y + local_y + k) * m_step + global_x + local_x];
int s = mask[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x];
int h = s_M[TILE_IDX2(local_y+k,local_x)];
bool isBoundary = false;
if( h > 200 ) {
// Pixel is part of the border graph
//OneBig				int index = (global_y + local_y + k) * (sRowBytes>>1) + global_x + local_x;
int index = ((blockIdx.x*SrcPaddBufSize + (local_y + k) * sRowBytes)>>1) + local_x;
__global ushort *sR = sR_1_1 + (sRowBytes>>1) + 1;
__global ushort *sG = sG_1_1 + (sRowBytes>>1) + 1;
__global ushort *sB = sB_1_1 + (sRowBytes>>1) + 1;
float3 center = (float3)(
sR[index],
sG[index],
sB[index]
);
// Left
if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 255 ) {
tile->edges[32*32*LEFT+local_x*32+local_y+k] = interaction16b3cEnergy(center, sR, sG, sB, index - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// RIGHT
if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 255 ){
tile->edges[32*32*RIGHT+local_x*32+local_y+k] = interaction16b3cEnergy(center, sR, sG, sB, index + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP LEFT
if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 255 ) {
tile->edges[32*32*TOPLEFT+(local_y+k)*32+local_x] = interaction16b3cEnergy(center, sR, sG, sB, index - (sRowBytes>>1) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM LEFT
if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 255 ) {
tile->edges[32*32*BOTTOMLEFT+(local_y+k)*32+local_x] = interaction16b3cEnergy(center, sR, sG, sB, index + (sRowBytes>>1) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// TOP RIGHT
if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 255 ) {
tile->edges[32*32*TOPRIGHT+(local_y+k)*32+local_x] = interaction16b3cEnergy(center, sR, sG, sB, index - (sRowBytes>>1) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM RIGHT
if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 255 ) {
tile->edges[32*32*BOTTOMRIGHT+(local_y+k)*32+local_x] = interaction16b3cEnergy(center, sR, sG, sB, index + (sRowBytes>>1) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM
if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 255 ) {
tile->edges[32*32*BOTTOM+(local_y+k)*32+local_x] = interaction16b3cEnergy(center, sR, sG, sB, index + (sRowBytes>>1), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP
if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 255 ) {
tile->edges[32*32*TOP+(local_y+k)*32+local_x] = interaction16b3cEnergy(center, sR, sG, sB, index - (sRowBytes>>1), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// Terminal Energies
if( isBoundary ) {
float sign = s > 128 ? -1.0f : 1.0f;
tile->terminals[(local_y+k) * 32 + local_x]	= sign * frozenEnergy;
}
//OneBig				if( F[(global_y + local_y + k) * m_step + global_x + local_x] > 128 )
if( F[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = -frozenEnergy;
//OneBig				if( B[(global_y + local_y+k) * m_step + global_x + local_x] > 128 )
if( B[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = frozenEnergy;
}
}
}
}

__kernel void GraphcutRefineEdge_setupOneBuf32b1cCapacities(
const __global Npp32s* graph_layout,
const Npp32s graph_tileWidth,
__global graph_tile_8f* graph_tiles,
const __global float *sG_1_1,
const int sRowBytes,
const float neighborEnergyStrength,
const float colorSensitivity,
const float colorPower,
const float frozenEnergy,
const __global unsigned char* F,
const __global unsigned char* B,
const __global unsigned char* mask,
const int m_step,
const __global unsigned char* g_BorderRegion,
const int width,
const int height,
const int border_step,
const int startX,
const int startY,
const int validW,
const int validH,
const __global int* posIdx,
const __global int* posX,
const __global int* posY,
const int NopdBufSize,
const int BorPaddBufSize,
const int SrcPaddBufSize
)
{
int2 blockIdx = (int2)(get_group_id(0), get_group_id(1));
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
//OneBig	//int global_x = blockIdx.x * 32;
//OneBig	//int global_y = blockIdx.y * 32;
int global_x = posX[blockIdx.x]; //abs coord
int global_y = posY[blockIdx.x];
//whole int tile_idx = graph_layout[blockIdx.y * graph_tileWidth + blockIdx.x];
//OneBig	//int tile_idx = graph_layout[(startY/32 + blockIdx.y) * graph_tileWidth + startX/32 + blockIdx.x];
int tile_idx = posIdx[blockIdx.x];
// Early exit if tile is empty
if( tile_idx < 0 ) return;
__local int s_M[34*35];
// Load Border Graph Tile to SMEM
const Npp32s elementsPerThread = 4;
//whole readTileWithApronIntoSMEM( s_M, g_BorderRegion, m_step, 128, width, height, elementsPerThread);
//OneBig	readTileWithApronIntoSMEM_tileBased( s_M, (g_BorderRegion+border_step+1), border_step, 128, width, height, elementsPerThread,
//OneBig		startX, startY, validW, validH);
readTileWithApronIntoSMEM_oneBufBased( s_M, (g_BorderRegion+(blockIdx.x*BorPaddBufSize)+border_step+1), border_step, 128, width, height, elementsPerThread,
global_x, global_y, validW, validH);
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[tile_idx];
//tile->pos = make_ushort2(blockIdx.x, blockIdx.y);
//whole tile->pos = (ushort2)(blockIdx.x, blockIdx.y);
//OneBig	tile->pos = (ushort2)(((startX/32)+blockIdx.x), ((startY/32)+blockIdx.y));
tile->pos = (ushort2)(global_x/32, global_y/32);
int local_x = threadIdx.x;
int local_y = threadIdx.y * 4;
for( int k=0; k < 4; ++k ) {
//whole if( global_x + local_x < width && global_y + local_y + k < height ) {
//OneBig		if( global_x + local_x < validW && global_y + local_y + k < validH ) {
if( global_x + local_x < width && global_y + local_y + k < height ) {
//OneBig			int s = mask[(global_y + local_y + k) * m_step + global_x + local_x];
int s = mask[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x];
int h = s_M[TILE_IDX2(local_y+k,local_x)];
bool isBoundary = false;
if( h > 200 ) {
// Pixel is part of the border graph
//OneBig				int index = (global_y + local_y + k) * (sRowBytes>>2) + global_x + local_x;
int index = ((blockIdx.x*SrcPaddBufSize + (local_y + k) * sRowBytes)>>2) + local_x;
__global float *sG = sG_1_1 + (sRowBytes>>2) + 1;
float center = (float)(
sG[index]
);
// Left
if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 255 ) {
tile->edges[32*32*LEFT+local_x*32+local_y+k] = interaction32b1cEnergy(center, sG, index - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// RIGHT
if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 255 ){
tile->edges[32*32*RIGHT+local_x*32+local_y+k] = interaction32b1cEnergy(center, sG, index + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP LEFT
if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 255 ) {
tile->edges[32*32*TOPLEFT+(local_y+k)*32+local_x] = interaction32b1cEnergy(center, sG, index - (sRowBytes>>2) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM LEFT
if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 255 ) {
tile->edges[32*32*BOTTOMLEFT+(local_y+k)*32+local_x] = interaction32b1cEnergy(center, sG, index + (sRowBytes>>2) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// TOP RIGHT
if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 255 ) {
tile->edges[32*32*TOPRIGHT+(local_y+k)*32+local_x] = interaction32b1cEnergy(center, sG, index - (sRowBytes>>2) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM RIGHT
if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 255 ) {
tile->edges[32*32*BOTTOMRIGHT+(local_y+k)*32+local_x] = interaction32b1cEnergy(center, sG, index + (sRowBytes>>2) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM
if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 255 ) {
tile->edges[32*32*BOTTOM+(local_y+k)*32+local_x] = interaction32b1cEnergy(center, sG, index + (sRowBytes>>2), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP
if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 255 ) {
tile->edges[32*32*TOP+(local_y+k)*32+local_x] = interaction32b1cEnergy(center, sG, index - (sRowBytes>>2), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// Terminal Energies
if( isBoundary ) {
float sign = s > 128 ? -1.0f : 1.0f;
tile->terminals[(local_y+k) * 32 + local_x]	= sign * frozenEnergy;
}
//OneBig				if( F[(global_y + local_y + k) * m_step + global_x + local_x] > 128 )
if( F[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = -frozenEnergy;
//OneBig				if( B[(global_y + local_y+k) * m_step + global_x + local_x] > 128 )
if( B[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = frozenEnergy;
}
}
}
}

__kernel void GraphcutRefineEdge_setupOneBuf32b3cCapacities(
const __global Npp32s* graph_layout,
const Npp32s graph_tileWidth,
__global graph_tile_8f* graph_tiles,
const __global float *sR_1_1,
const __global float *sG_1_1,
const __global float *sB_1_1,
const int sRowBytes,
const float neighborEnergyStrength,
const float colorSensitivity,
const float colorPower,
const float frozenEnergy,
const __global unsigned char* F,
const __global unsigned char* B,
const __global unsigned char* mask,
const int m_step,
const __global unsigned char* g_BorderRegion,
const int width,
const int height,
const int border_step,
const int startX,
const int startY,
const int validW,
const int validH,
const __global int* posIdx,
const __global int* posX,
const __global int* posY,
const int NopdBufSize,
const int BorPaddBufSize,
const int SrcPaddBufSize
)
{
int2 blockIdx = (int2)(get_group_id(0), get_group_id(1));
int2 threadIdx = (int2)(get_local_id(0), get_local_id(1));
//OneBig	//int global_x = blockIdx.x * 32;
//OneBig	//int global_y = blockIdx.y * 32;
int global_x = posX[blockIdx.x]; //abs coord
int global_y = posY[blockIdx.x];
//whole int tile_idx = graph_layout[blockIdx.y * graph_tileWidth + blockIdx.x];
//OneBig	//int tile_idx = graph_layout[(startY/32 + blockIdx.y) * graph_tileWidth + startX/32 + blockIdx.x];
int tile_idx = posIdx[blockIdx.x];
// Early exit if tile is empty
if( tile_idx < 0 ) return;
__local int s_M[34*35];
// Load Border Graph Tile to SMEM
const Npp32s elementsPerThread = 4;
//whole readTileWithApronIntoSMEM( s_M, g_BorderRegion, m_step, 128, width, height, elementsPerThread);
//OneBig	readTileWithApronIntoSMEM_tileBased( s_M, (g_BorderRegion+border_step+1), border_step, 128, width, height, elementsPerThread,
//OneBig		startX, startY, validW, validH);
readTileWithApronIntoSMEM_oneBufBased( s_M, (g_BorderRegion+(blockIdx.x*BorPaddBufSize)+border_step+1), border_step, 128, width, height, elementsPerThread,
global_x, global_y, validW, validH);
barrier(CLK_LOCAL_MEM_FENCE);
__global graph_tile_8f* tile = &graph_tiles[tile_idx];
//tile->pos = make_ushort2(blockIdx.x, blockIdx.y);
//whole tile->pos = (ushort2)(blockIdx.x, blockIdx.y);
//OneBig	tile->pos = (ushort2)(((startX/32)+blockIdx.x), ((startY/32)+blockIdx.y));
tile->pos = (ushort2)(global_x/32, global_y/32);
int local_x = threadIdx.x;
int local_y = threadIdx.y * 4;
for( int k=0; k < 4; ++k ) {
//whole if( global_x + local_x < width && global_y + local_y + k < height ) {
//OneBig		if( global_x + local_x < validW && global_y + local_y + k < validH ) {
if( global_x + local_x < width && global_y + local_y + k < height ) {
//OneBig			int s = mask[(global_y + local_y + k) * m_step + global_x + local_x];
int s = mask[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x];
int h = s_M[TILE_IDX2(local_y+k,local_x)];
bool isBoundary = false;
if( h > 200 ) {
// Pixel is part of the border graph
//OneBig				int index = (global_y + local_y + k) * (sRowBytes>>2) + global_x + local_x;
int index = ((blockIdx.x*SrcPaddBufSize + (local_y + k) * sRowBytes)>>2) + local_x;
__global float *sR = sR_1_1 + (sRowBytes>>2) + 1;
__global float *sG = sG_1_1 + (sRowBytes>>2) + 1;
__global float *sB = sB_1_1 + (sRowBytes>>2) + 1;
float3 center = (float3)(
sR[index],
sG[index],
sB[index]
);
// Left
if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x-1)] == 255 ) {
tile->edges[32*32*LEFT+local_x*32+local_y+k] = interaction32b3cEnergy(center, sR, sG, sB, index - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// RIGHT
if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k,local_x+1)] == 255 ){
tile->edges[32*32*RIGHT+local_x*32+local_y+k] = interaction32b3cEnergy(center, sR, sG, sB, index + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP LEFT
if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x-1)] == 255 ) {
tile->edges[32*32*TOPLEFT+(local_y+k)*32+local_x] = interaction32b3cEnergy(center, sR, sG, sB, index - (sRowBytes>>2) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM LEFT
if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x-1)] == 255 ) {
tile->edges[32*32*BOTTOMLEFT+(local_y+k)*32+local_x] = interaction32b3cEnergy(center, sR, sG, sB, index + (sRowBytes>>2) - 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// TOP RIGHT
if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x+1)] == 255 ) {
tile->edges[32*32*TOPRIGHT+(local_y+k)*32+local_x] = interaction32b3cEnergy(center, sR, sG, sB, index - (sRowBytes>>2) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM RIGHT
if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x+1)] == 255 ) {
tile->edges[32*32*BOTTOMRIGHT+(local_y+k)*32+local_x] = interaction32b3cEnergy(center, sR, sG, sB, index + (sRowBytes>>2) + 1, neighborEnergyStrength, colorSensitivity, colorPower, 1.0f/sqrtf(2.0f));
}
// BOTTOM
if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k+1,local_x)] == 255 ) {
tile->edges[32*32*BOTTOM+(local_y+k)*32+local_x] = interaction32b3cEnergy(center, sR, sG, sB, index + (sRowBytes>>2), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// TOP
if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 0 ) {
isBoundary = true;
} else if( s_M[TILE_IDX2(local_y+k-1,local_x)] == 255 ) {
tile->edges[32*32*TOP+(local_y+k)*32+local_x] = interaction32b3cEnergy(center, sR, sG, sB, index - (sRowBytes>>2), neighborEnergyStrength, colorSensitivity, colorPower, 1.0f);
}
// Terminal Energies
if( isBoundary ) {
float sign = s > 128 ? -1.0f : 1.0f;
tile->terminals[(local_y+k) * 32 + local_x]	= sign * frozenEnergy;
}
//OneBig				if( F[(global_y + local_y + k) * m_step + global_x + local_x] > 128 )
if( F[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = -frozenEnergy;
//OneBig				if( B[(global_y + local_y+k) * m_step + global_x + local_x] > 128 )
if( B[(blockIdx.x*NopdBufSize) + (local_y + k) * m_step + local_x] > 128 )
tile->terminals[(local_y+k) * 32 + local_x] = frozenEnergy;
}
}
}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
