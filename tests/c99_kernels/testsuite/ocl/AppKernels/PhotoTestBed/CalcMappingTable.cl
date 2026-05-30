#define FASTHSV_SVMAX			32640
#define TABLE_SIZE              32641
#define ROUND_INT( dValue ) ((int)(dValue + 0.5))


/////////////// SHOLD BE MOVED TO CL HEADER FILE (Ilya) /////////////////////////////////
typedef enum _HUE_COLOR_DEF
{
	Hue_None = -1,
	Hue_Red = 0,
	Hue_Orange,
	Hue_Yellow,
	Hue_Green,
	Hue_Aqua,
	Hue_Blue,
	Hue_Purple,
	Hue_Magenta,
	Hue_COLOR_COUNT = 8
} HUE_COLOR_DEF;


typedef ushort colors_table[Hue_COLOR_COUNT];

typedef enum _S_mapping
{
	Val_Ast = 0,	// Luminance
	Sat_Adj,		// Saturation
	Sat_Min,
	Vib_Adj,		// Vibrance
	Vib_Min
} S_mapping;
typedef enum _V_mapping
{
	Val_Adj = 0,
	Sat_Ast,
	Vib_Ast
} V_mapping;

typedef struct _hsv_color_table
{
	ushort S_tables[8][32641][5];
	ushort V_tables[8][32641][3];
} hsv_color_table;

#define GET_S_VALUE(val, color, tbl_id) mappingTbl->S_tables[color][val][tbl_id]
#define GET_V_VALUE(val, color, tbl_id) mappingTbl->V_tables[color][val][tbl_id]

float HermiteSpline( float X1, float Y1, float X2, float Y2, float m1, float m2, float x )
{
	float scale = (X2 - X1);
	float t = (x - X1) / (X2 - X1);

	float H00 = 2.0 * t * t * t - 3.0 * t * t + 1.0;
	float H01 = (-2.0) * t * t * t + 3.0 * t * t;
	float H10 = t * t * t - 2.0 * t * t + t;
	float H11 = t * t * t - t * t;

	return H00 * Y1 + H10 * scale * m1 + H01 * Y2 + H11 * scale * m2;
}

float CardinalSpline( float* pCtrlX, float* pCtrlY, float tension, float x )
{
	if ( pCtrlX == 0 || pCtrlY == 0 )
		return 0;

	if ( pCtrlX[2] - pCtrlX[0] == 0 )
		return pCtrlY[2];

	if ( pCtrlX[3] - pCtrlX[1] == 0 )
		return pCtrlY[3];

	if ( pCtrlX[2] - pCtrlX[1] == 0 )
		return pCtrlY[2];

	float m1 = ( 1.0 - tension ) * ( pCtrlY[2] - pCtrlY[0] ) / ( pCtrlX[2] - pCtrlX[0] );
	float m2 = ( 1.0 - tension ) * ( pCtrlY[3] - pCtrlY[1] ) / ( pCtrlX[3] - pCtrlX[1] );

	return HermiteSpline( pCtrlX[1], pCtrlY[1], pCtrlX[2], pCtrlY[2], m1, m2, x );
}

void m_fnGenerate4Points( int nIndex,
                          float* pdCtrlX, float* pdCtrlY,
                          global int* cpAryX,
                          global int* cpAryY,
                          int cpCnt)
{

	if ( nIndex < 0 || nIndex >= cpCnt - 1 )
		return;

	int nFourIndex[4];

	if ( nIndex - 1 < 0 )
		nFourIndex[0] = nIndex;
	else
		nFourIndex[0] = nIndex - 1;

	nFourIndex[1] = nIndex;
	nFourIndex[2] = nIndex+1;

	if ( nIndex + 2 >= cpCnt )
		nFourIndex[3] = nIndex + 1;
	else
		nFourIndex[3] = nIndex + 2;

	for ( int i = 0; i < 4; i++ )
	{
		pdCtrlX[i] = cpAryX[nFourIndex[i]];
		pdCtrlY[i] = cpAryY[nFourIndex[i]];
	}

}

kernel void UpdateMappingTable(global int* allTbl,
							   int         offset,
							   global int* cpAryX,
							   global int* cpAryY,
							   int         cpCnt,
							   int         bound )
{
    int idx = get_global_id(0);
	if(idx >= TABLE_SIZE)
		return;

    int shift = offset * TABLE_SIZE;
    global int* mapTbl = &allTbl[shift];

    mapTbl[idx] = idx;

    if ( cpCnt == 0 )
        return;

	if ( bound <= 0 )
		return;

    mapTbl[idx] = 0;
    int value = 0;

    if ( idx >= cpAryX[cpCnt-1] )
    {
        value = ROUND_INT( cpAryY[cpCnt-1] );
    }
	else
    {
        int ctlIdx = 0;
        for (int i = 0; i < cpCnt; ++i)
        {
            if (idx < cpAryX[i])
            {
                ctlIdx = i-1;
                break;
            }
        }

        float aryX[4], aryY[4];
        m_fnGenerate4Points( ctlIdx, aryX, aryY, cpAryX, cpAryY, cpCnt);
        value = ROUND_INT( (CardinalSpline( aryX, aryY, 0, (float) idx )) );
    }

    if ( value > bound )
        mapTbl[idx] = bound;
    else if ( value < 0 )
        mapTbl[idx] = 0;
    else
        mapTbl[idx] = value;

}

#define HEADER_SIZE 9*8

kernel void UpdateMappingTable_SVM(	global hsv_color_table* Tbl,
									global int* g_points )
{
    int idx   = get_global_id(0);
	int color = get_global_id(1);

	if(idx >= TABLE_SIZE)
		return;

	global ushort *val;

	int cpCnt;
	global int *cpAryX;
	global int *cpAryY;

	global int *counts = g_points + 9*color+1;		// 8 elements with curve length for each table
	g_points += 2*g_points[9*color] + HEADER_SIZE;	// Move pointer to actual data

	for(int table_id = 0; table_id < 8; table_id++) {

		cpCnt  = counts[table_id];	// number of control points
		cpAryX = g_points;
		cpAryY = g_points + cpCnt;
		g_points += 2*cpCnt;		// go to the next table

		if(table_id < 5)			// S_tables
			val = &Tbl->S_tables[color][idx][table_id];
		else
			val = &Tbl->V_tables[color][idx][table_id-5];

		*val = idx;

		if ( cpCnt == 0 )
			continue;

		// FIXME - not needed? seems to be a constant from the host code (FASTHSV_SVMAX)
		//if ( bound <= 0 )
		//	continue; // return;

		// mapTbl[idx] = 0;
		*val = 0;
		int value = 0;

		if ( idx >= cpAryX[cpCnt-1] )
		{
			value = ROUND_INT( cpAryY[cpCnt-1] );
		}
		else
		{
			// FIXME - is it a linear search ?!?
			int ctlIdx = 0;
			for (int i = 0; i < cpCnt; ++i)
			{
				if (idx < cpAryX[i])
				{
					ctlIdx = i-1;
					break;
				}
			}

			float aryX[4], aryY[4];
			m_fnGenerate4Points( ctlIdx, aryX, aryY, cpAryX, cpAryY, cpCnt);
			value = ROUND_INT( (CardinalSpline( aryX, aryY, 0, (float) idx )) );
		}

		if ( value > FASTHSV_SVMAX )
			*val = FASTHSV_SVMAX;
		else if ( value < 0 )
			*val = 0;
		else
			*val = value;

	}

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
