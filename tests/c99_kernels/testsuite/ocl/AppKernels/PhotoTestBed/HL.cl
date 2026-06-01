#define LDF_EPSILON	0.03f
#define RECOVERY_MAX_DEGREE_STRENGTH 0.7f

kernel void GetLumi(global const ushort4* src_buf, global float* Lumi_buf, int width, int height, int src_stride, int SrcChannelNum, int nChannelBoundary)
{
	int		x = get_global_id(0);
	int		y = get_global_id(1);

	if( x >= width || y >= height )
		return;

    int	src_index = y*src_stride + x;
	int	L_index = y*width + x;

	ushort4 src = src_buf[src_index];   // read from input
    float pLumi = Lumi_buf[L_index];   // read from input

	pLumi = (float)(0.114f * src.s0 + 0.587f * src.s1 + 0.299f * src.s2) / (float)nChannelBoundary;
	Lumi_buf[L_index] = pLumi;
}

kernel void ReintroduceColor(global const ushort4* src_buf, global ushort4* dst_buf, global float* Lumi_buf, int width, int height, int src_stride, int SrcChannelNum, int nChannelBoundary, global float* pfOut_buf, int temp_stride)
{
	int		x = get_global_id(0);
	int		y = get_global_id(1);

	if( x >= width || y >= height )
		return;

    int	src_index = y*src_stride + x;
	int	temp_index = y*temp_stride + x;

	ushort4 pSrc = src_buf[src_index];   // read from input
	ushort4 pDst = dst_buf[src_index];
    float pLumi = Lumi_buf[temp_index];   // read from input
    float pfOut = pfOut_buf[temp_index];

	float	fRatio, fVal[3];

	/// use LDF_EPSILON to avoid scaling up noise
	fRatio  = clamp(( pfOut + LDF_EPSILON ), 0.0f, 1.0f ) / (pLumi + LDF_EPSILON);
    if ( fRatio < RECOVERY_MAX_DEGREE_STRENGTH ) { fRatio = RECOVERY_MAX_DEGREE_STRENGTH; }

	fVal[0] = fRatio * (float)pSrc.s0;
	fVal[1] = fRatio * (float)pSrc.s1;
	fVal[2] = fRatio * (float)pSrc.s2;

	/// Over Boundary case : Re-ratio to Max:65535
	if( fVal[0] > nChannelBoundary || fVal[1] > nChannelBoundary || fVal[2] > nChannelBoundary )
	{
		fRatio	= (float)nChannelBoundary / max( max( fVal[0], fVal[1]), fVal[2] );
		fVal[0] *= fRatio;
		fVal[1] *= fRatio;
		fVal[2] *= fRatio;
	}

	pDst.s0		= (ushort)fVal[0];
	pDst.s1		= (ushort)fVal[1];
	pDst.s2		= (ushort)fVal[2];
	dst_buf[src_index] = pDst;
}

kernel void ProcessImage_If(global float4* pSeq_buf, global float* Lumi_buf, int width, int height, int seq_stride, int SeqChannelNum, int nBoundary, global int* mFillLight_pnMappingTable, global int* mRecovery_pnMappingTable, int m_nIntensity, float m_fAlpha, global float* arrC, global float* arrExpC)
{
	int		x = get_global_id(0);
	int		y = get_global_id(1);

	if( x >= width || y >= height )
		return;

	int	pSeq_index = y*seq_stride + x;
	int	L_index = y*width + x;

	float pLumi = Lumi_buf[L_index];   // read from input
	float fID, fWeight, fWeightFillLight, fWeightRecovery, fToneVal;
	int c, nID;
	float m, k;

	fID	= pLumi * nBoundary;
	nID	= (int)fID;
	fWeightFillLight = mFillLight_pnMappingTable[nID] - fID;
	fWeightRecovery	= mRecovery_pnMappingTable[nID]  - fID;
	fWeight	= (fWeightFillLight + fWeightRecovery) / nBoundary;
	fToneVal = pLumi + fWeight;

	float4 seq;
	float4 arrc = {arrC[0], arrC[1], arrC[2], arrC[3]};
	float4 arrExp = {arrExpC[0], arrExpC[1], arrExpC[2], arrExpC[3]};

	m = exp( pLumi / (float)m_nIntensity);
	k = exp( -0.5f*pLumi*pLumi );
	float4 n = {1, m, m*m, m*m*m};
	float4 ex = arrExp*k*n;
	float4 fDiff = pLumi - arrc;
	fDiff = m_fAlpha * fDiff * ex;
	seq = fToneVal + fDiff * fabs(fWeight);
	pSeq_buf[pSeq_index] = seq;
}

kernel void ProcessImage_Else(global float4* pSeq_buf, global float* Lumi_buf, int width, int height, int seq_stride, int SeqChannelNum, int m_nIntensity, float m_fAlpha, global float* arrC1)
{
	int		x = get_global_id(0);
	int		y = get_global_id(1);

	if( x >= width || y >= height )
		return;

	int	pSeq_index = y*seq_stride + x;
	int	L_index = y*width + x;

	float pLumi = Lumi_buf[L_index];   // read from input

	float4 fDiff;
	float4 arrC = {arrC1[0], arrC1[1], arrC1[2], arrC1[3]};
	float4 seq;

	fDiff = pLumi - arrC;
	fDiff = m_fAlpha * fDiff * exp( - fDiff * fDiff * 0.5f);
	seq = pLumi + fDiff;
	pSeq_buf[pSeq_index] = seq;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
