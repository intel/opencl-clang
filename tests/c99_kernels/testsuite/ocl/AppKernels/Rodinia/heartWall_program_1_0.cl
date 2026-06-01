// buildOptions=-Itestsuite/ocl/AppKernels/Rodinia
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -Itestsuite/ocl/AppKernels/Rodinia" %cfg_path --cl-device=%cl_device 2>&1

//========================================================================================================================================================================================================200
//	DEFINE / INCLUDE
//========================================================================================================================================================================================================200

//======================================================================================================================================================150
//	MAIN FUNCTION HEADER
//======================================================================================================================================================150

#include "./main.h"

//======================================================================================================================================================150
//	End
//======================================================================================================================================================150

//========================================================================================================================================================================================================200
//	KERNEL
//========================================================================================================================================================================================================200

// #pragma OPENCL EXTENSION cl_amd_printf : enable

__kernel void
kernel_gpu_opencl(	// structures
					params_common d_common,

					// common_change
					__global fp* d_frame,
					int d_frame_no,

					// common
					__global int* d_endoRow,
					__global int* d_endoCol,
					__global int* d_tEndoRowLoc,
					__global int* d_tEndoColLoc,
					__global int* d_epiRow,
					__global int* d_epiCol,
					__global int* d_tEpiRowLoc,
					__global int* d_tEpiColLoc,

					// common_unique
					__global fp* d_endoT,
					__global fp* d_epiT,
					__global fp* d_in2_all,
					__global fp* d_conv_all,
					__global fp* d_in2_pad_cumv_all,
					__global fp* d_in2_pad_cumv_sel_all,
					__global fp* d_in2_sub_cumh_all,
					__global fp* d_in2_sub_cumh_sel_all,
					__global fp* d_in2_sub2_all,
					__global fp* d_in2_sqr_all,
					__global fp* d_in2_sqr_sub2_all,
					__global fp* d_in_sqr_all,
					__global fp* d_tMask_all,
					__global fp* d_mask_conv_all,

					// local
					__local fp* d_in_mod_temp,
					__local fp* in_partial_sum,
					__local fp* in_sqr_partial_sum,
					__local fp* par_max_val,
					__local int* par_max_coo)
{

	//======================================================================================================================================================150
	//	COMMON VARIABLES
	//======================================================================================================================================================150

	__global fp* d_in;
	int rot_row;
	int rot_col;
	int in2_rowlow;
	int in2_collow;
	int ic;
	int jc;
	int jp1;
	int ja1, ja2;
	int ip1;
	int ia1, ia2;
	int ja, jb;
	int ia, ib;
	fp s;
	int i;
	int j;
	int row;
	int col;
	int ori_row;
	int ori_col;
	int position;
	fp sum;
	int pos_ori;
	fp temp;
	fp temp2;
	int location;
	int cent;
	int tMask_row;
	int tMask_col;
	fp largest_value_current = 0;
	fp largest_value = 0;
	int largest_coordinate_current = 0;
	int largest_coordinate = 0;
	fp fin_max_val = 0;
	int fin_max_coo = 0;
	int largest_row;
	int largest_col;
	int offset_row;
	int offset_col;
	fp mean;
	fp mean_sqr;
	fp variance;
	fp deviation;
	int pointer;
	int ori_pointer;
	int loc_pointer;

	__local fp in_final_sum;
	__local fp in_sqr_final_sum;
	__local fp denomT;

	//======================================================================================================================================================150
	//	BLOCK/THREAD IDs
	//======================================================================================================================================================150

	int bx = get_group_id(0);															// get current horizontal block index (0-n)
	int tx = get_local_id(0);															// get current horizontal thread index (0-n)
	int ei_new;

	//====================================================================================================100
	//	UNIQUE STRUCTURE RECONSTRUCTED HERE
	//====================================================================================================100

	__global fp* d_common_change_d_frame = &d_frame[0];

	int d_unique_point_no;
	__global int* d_unique_d_Row;
	__global int* d_unique_d_Col;
	__global int* d_unique_d_tRowLoc;
	__global int* d_unique_d_tColLoc;
	__global fp* d_unique_d_T;
	if(bx < d_common.endoPoints){
		d_unique_point_no = bx;
		d_unique_d_Row = d_endoRow;
		d_unique_d_Col = d_endoCol;
		d_unique_d_tRowLoc = d_tEndoRowLoc;
		d_unique_d_tColLoc = d_tEndoColLoc;
		d_unique_d_T = d_endoT;
	}
	else{
		d_unique_point_no = bx-d_common.endoPoints;
		d_unique_d_Row = d_epiRow;
		d_unique_d_Col = d_epiCol;
		d_unique_d_tRowLoc = d_tEpiRowLoc;
		d_unique_d_tColLoc = d_tEpiColLoc;
		d_unique_d_T = d_epiT;
	}

	int d_unique_in_pointer = d_unique_point_no * d_common.in_elem;

	__global fp* d_unique_d_in2 = &d_in2_all[bx*d_common.in2_elem];
	__global fp* d_unique_d_conv = &d_conv_all[bx*d_common.conv_elem];
	__global fp* d_unique_d_in2_pad_cumv = &d_in2_pad_cumv_all[bx*d_common.in2_pad_cumv_elem];
	__global fp* d_unique_d_in2_pad_cumv_sel = &d_in2_pad_cumv_sel_all[bx*d_common.in2_pad_cumv_sel_elem];
	__global fp* d_unique_d_in2_sub_cumh = &d_in2_sub_cumh_all[bx*d_common.in2_sub_cumh_elem];
	__global fp* d_unique_d_in2_sub_cumh_sel = &d_in2_sub_cumh_sel_all[bx*d_common.in2_sub_cumh_sel_elem];
	__global fp* d_unique_d_in2_sub2 = &d_in2_sub2_all[bx*d_common.in2_sub2_elem];
	__global fp* d_unique_d_in2_sqr = &d_in2_sqr_all[bx*d_common.in2_sqr_elem];
	__global fp* d_unique_d_in2_sqr_sub2 = &d_in2_sqr_sub2_all[bx*d_common.in2_sqr_sub2_elem];
	__global fp* d_unique_d_in_sqr = &d_in_sqr_all[bx*d_common.in_sqr_elem];
	__global fp* d_unique_d_tMask = &d_tMask_all[bx*d_common.tMask_elem];
	__global fp* d_unique_d_mask_conv = &d_mask_conv_all[bx*d_common.mask_conv_elem];

	//====================================================================================================100
	//	END
	//====================================================================================================100

	//======================================================================================================================================================150
	//	GENERATE TEMPLATE
	//======================================================================================================================================================150

	// generate templates based on the first frame only
	if(d_frame_no == 0){

		//====================================================================================================100
		// GET POINTER TO TEMPLATE FOR THE POINT
		//====================================================================================================100

		// pointers to: current template for current point
		d_in = &d_unique_d_T[d_unique_in_pointer];

		//====================================================================================================100
		//	UPDATE ROW LOC AND COL LOC
		//====================================================================================================100

		// uptade temporary endo/epi row/col coordinates (in each block corresponding to point, narrow work to one thread)
		ei_new = tx;
		if(ei_new == 0){

			// update temporary row/col coordinates
			pointer = d_unique_point_no*d_common.no_frames+d_frame_no;
			d_unique_d_tRowLoc[pointer] = d_unique_d_Row[d_unique_point_no];
			d_unique_d_tColLoc[pointer] = d_unique_d_Col[d_unique_point_no];

		}

		//====================================================================================================100
		//	CREATE TEMPLATES
		//====================================================================================================100

		// work
		ei_new = tx;
		while(ei_new < d_common.in_elem){

			// figure out row/col location in new matrix
			row = (ei_new+1) % d_common.in_rows - 1;												// (0-n) row
			col = (ei_new+1) / d_common.in_rows + 1 - 1;											// (0-n) column
			if((ei_new+1) % d_common.in_rows == 0){
				row = d_common.in_rows - 1;
				col = col-1;
			}

			// figure out row/col location in corresponding new template area in image and give to every thread (get top left corner and progress down and right)
			ori_row = d_unique_d_Row[d_unique_point_no] - 25 + row - 1;
			ori_col = d_unique_d_Col[d_unique_point_no] - 25 + col - 1;
			ori_pointer = ori_col*d_common.frame_rows+ori_row;

			// update template
			d_in[col*d_common.in_rows+row] = d_common_change_d_frame[ori_pointer];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//====================================================================================================100
		//	End
		//====================================================================================================100

	}

	//======================================================================================================================================================150
	//	PROCESS POINTS
	//======================================================================================================================================================150

	// process points in all frames except for the first one
	if(d_frame_no != 0){

		//====================================================================================================100
		//	SELECTION
		//====================================================================================================100

		in2_rowlow = d_unique_d_Row[d_unique_point_no] - d_common.sSize;													// (1 to n+1)
		in2_collow = d_unique_d_Col[d_unique_point_no] - d_common.sSize;

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_elem){

			// figure out row/col location in new matrix
			row = (ei_new+1) % d_common.in2_rows - 1;												// (0-n) row
			col = (ei_new+1) / d_common.in2_rows + 1 - 1;											// (0-n) column
			if((ei_new+1) % d_common.in2_rows == 0){
				row = d_common.in2_rows - 1;
				col = col-1;
			}

			// figure out corresponding location in old matrix and copy values to new matrix
			ori_row = row + in2_rowlow - 1;
			ori_col = col + in2_collow - 1;
			d_unique_d_in2[ei_new] = d_common_change_d_frame[ori_col*d_common.frame_rows+ori_row];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//====================================================================================================100
		//	SYNCHRONIZE THREADS
		//====================================================================================================100

		barrier(CLK_LOCAL_MEM_FENCE);

		//====================================================================================================100
		//	CONVOLUTION
		//====================================================================================================100

		//==================================================50
		//	ROTATION
		//==================================================50

		// variables
		d_in = &d_unique_d_T[d_unique_in_pointer];

		// work
		ei_new = tx;
		while(ei_new < d_common.in_elem){
		// while(ei_new < 1){

			// figure out row/col location in padded array
			row = (ei_new+1) % d_common.in_rows - 1;												// (0-n) row
			col = (ei_new+1) / d_common.in_rows + 1 - 1;											// (0-n) column
			if((ei_new+1) % d_common.in_rows == 0){
				row = d_common.in_rows - 1;
				col = col-1;
			}

			// execution
			rot_row = (d_common.in_rows-1) - row;
			rot_col = (d_common.in_rows-1) - col;
			d_in_mod_temp[ei_new] = d_in[rot_col*d_common.in_rows+rot_row];
			// d_in_mod_temp[ei_new] = d_in[0];
			// d_in_mod_temp[ei_new] = d_unique_d_T[d_unique_in_pointer];
			// d_in_mod_temp[ei_new] = d_unique_d_T[d_unique_point_no * d_common.in_elem];
			// d_in_mod_temp[ei_new] = d_unique_d_T[d_unique_point_no * 2601];
			// if((d_unique_point_no * d_common.in_elem) > (2601*51
				// printf("frame_no IS %d\n", d_common_change[0].frame_no);
			// d_in_mod_temp[ei_new] = d_unique_d_T[d_unique_point_no];

			// d_in_mod_temp[ei_new] = 1;
			// kot = d_in[rot_col*d_common.in_rows+rot_row];
			// d_in_mod_temp[ei_new] = kot;
			// d_in_mod_temp[ei_new] = d_unique_d_T[d_unique_in_pointer+rot_col*d_common.in_rows+rot_row];
			// d_in_mod_temp[ei_new] = d_unique_d_T[d_unique_point_no * d_common.in_elem+rot_col*d_common.in_rows+rot_row];
			//d_in_mod_temp[ei_new] = d_unique_d_T[d_unique_point_no];
			// d_unique_d_T[d_unique_in_pointer+rot_col*d_common.in_rows+rot_row] = 1;
			// d_unique_d_T[d_unique_in_pointer] = 1;
			// d_endoT[d_unique_in_pointer] = 1;
			// d_in_mod_temp[ei_new] = 1;

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	ACTUAL CONVOLUTION
		//==================================================50

		// work
		ei_new = tx;
		while(ei_new < d_common.conv_elem){

			// figure out row/col location in array
			ic = (ei_new+1) % d_common.conv_rows;												// (1-n)
			jc = (ei_new+1) / d_common.conv_rows + 1;											// (1-n)
			if((ei_new+1) % d_common.conv_rows == 0){
				ic = d_common.conv_rows;
				jc = jc-1;
			}

			//
			j = jc + d_common.joffset;
			jp1 = j + 1;
			if(d_common.in2_cols < jp1){
				ja1 = jp1 - d_common.in2_cols;
			}
			else{
				ja1 = 1;
			}
			if(d_common.in_cols < j){
				ja2 = d_common.in_cols;
			}
			else{
				ja2 = j;
			}

			i = ic + d_common.ioffset;
			ip1 = i + 1;

			if(d_common.in2_rows < ip1){
				ia1 = ip1 - d_common.in2_rows;
			}
			else{
				ia1 = 1;
			}
			if(d_common.in_rows < i){
				ia2 = d_common.in_rows;
			}
			else{
				ia2 = i;
			}

			s = 0;

			for(ja=ja1; ja<=ja2; ja++){
				jb = jp1 - ja;
				for(ia=ia1; ia<=ia2; ia++){
					ib = ip1 - ia;
					s = s + d_in_mod_temp[d_common.in_rows*(ja-1)+ia-1] * d_unique_d_in2[d_common.in2_rows*(jb-1)+ib-1];
				}
			}

			//d_unique_d_conv[d_common.conv_rows*(jc-1)+ic-1] = s;
			d_unique_d_conv[ei_new] = s;

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//====================================================================================================100
		//	SYNCHRONIZE THREADS
		//====================================================================================================100

		barrier(CLK_LOCAL_MEM_FENCE);

		//====================================================================================================100
		//	CUMULATIVE SUM
		//====================================================================================================100

		//==================================================50
		//	PAD ARRAY, VERTICAL CUMULATIVE SUM
		//==================================================50

		//==================================================
		//	PADD ARRAY
		//==================================================

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_pad_cumv_elem){

			// figure out row/col location in padded array
			row = (ei_new+1) % d_common.in2_pad_cumv_rows - 1;												// (0-n) row
			col = (ei_new+1) / d_common.in2_pad_cumv_rows + 1 - 1;											// (0-n) column
			if((ei_new+1) % d_common.in2_pad_cumv_rows == 0){
				row = d_common.in2_pad_cumv_rows - 1;
				col = col-1;
			}

			// execution
			if(	row > (d_common.in2_pad_add_rows-1) &&														// do if has numbers in original array
				row < (d_common.in2_pad_add_rows+d_common.in2_rows) &&
				col > (d_common.in2_pad_add_cols-1) &&
				col < (d_common.in2_pad_add_cols+d_common.in2_cols)){
				ori_row = row - d_common.in2_pad_add_rows;
				ori_col = col - d_common.in2_pad_add_cols;
				d_unique_d_in2_pad_cumv[ei_new] = d_unique_d_in2[ori_col*d_common.in2_rows+ori_row];
			}
			else{																			// do if otherwise
				d_unique_d_in2_pad_cumv[ei_new] = 0;
			}

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================
		//	SYNCHRONIZE THREADS
		//==================================================

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================
		//	VERTICAL CUMULATIVE SUM
		//==================================================

		//work
		ei_new = tx;
		while(ei_new < d_common.in2_pad_cumv_cols){

			// figure out column position
			pos_ori = ei_new*d_common.in2_pad_cumv_rows;

			// variables
			sum = 0;

			// loop through all rows
			for(position = pos_ori; position < pos_ori+d_common.in2_pad_cumv_rows; position = position + 1){
				d_unique_d_in2_pad_cumv[position] = d_unique_d_in2_pad_cumv[position] + sum;
				sum = d_unique_d_in2_pad_cumv[position];
			}

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	SELECTION
		//==================================================50

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_pad_cumv_sel_elem){

			// figure out row/col location in new matrix
			row = (ei_new+1) % d_common.in2_pad_cumv_sel_rows - 1;												// (0-n) row
			col = (ei_new+1) / d_common.in2_pad_cumv_sel_rows + 1 - 1;											// (0-n) column
			if((ei_new+1) % d_common.in2_pad_cumv_sel_rows == 0){
				row = d_common.in2_pad_cumv_sel_rows - 1;
				col = col-1;
			}

			// figure out corresponding location in old matrix and copy values to new matrix
			ori_row = row + d_common.in2_pad_cumv_sel_rowlow - 1;
			ori_col = col + d_common.in2_pad_cumv_sel_collow - 1;
			d_unique_d_in2_pad_cumv_sel[ei_new] = d_unique_d_in2_pad_cumv[ori_col*d_common.in2_pad_cumv_rows+ori_row];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	SELECTION 2, SUBTRACTION, HORIZONTAL CUMULATIVE SUM
		//==================================================50

		//==================================================
		//	SELECTION 2
		//==================================================

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sub_cumh_elem){

			// figure out row/col location in new matrix
			row = (ei_new+1) % d_common.in2_sub_cumh_rows - 1;												// (0-n) row
			col = (ei_new+1) / d_common.in2_sub_cumh_rows + 1 - 1;											// (0-n) column
			if((ei_new+1) % d_common.in2_sub_cumh_rows == 0){
				row = d_common.in2_sub_cumh_rows - 1;
				col = col-1;
			}

			// figure out corresponding location in old matrix and copy values to new matrix
			ori_row = row + d_common.in2_pad_cumv_sel2_rowlow - 1;
			ori_col = col + d_common.in2_pad_cumv_sel2_collow - 1;
			d_unique_d_in2_sub_cumh[ei_new] = d_unique_d_in2_pad_cumv[ori_col*d_common.in2_pad_cumv_rows+ori_row];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================
		//	SYNCHRONIZE THREADS
		//==================================================

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================
		//	SUBTRACTION
		//==================================================

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sub_cumh_elem){

			// subtract
			d_unique_d_in2_sub_cumh[ei_new] = d_unique_d_in2_pad_cumv_sel[ei_new] - d_unique_d_in2_sub_cumh[ei_new];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================
		//	SYNCHRONIZE THREADS
		//==================================================

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================
		//	HORIZONTAL CUMULATIVE SUM
		//==================================================

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sub_cumh_rows){

			// figure out row position
			pos_ori = ei_new;

			// variables
			sum = 0;

			// loop through all rows
			for(position = pos_ori; position < pos_ori+d_common.in2_sub_cumh_elem; position = position + d_common.in2_sub_cumh_rows){
				d_unique_d_in2_sub_cumh[position] = d_unique_d_in2_sub_cumh[position] + sum;
				sum = d_unique_d_in2_sub_cumh[position];
			}

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	SELECTION
		//==================================================50

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sub_cumh_sel_elem){

			// figure out row/col location in new matrix
			row = (ei_new+1) % d_common.in2_sub_cumh_sel_rows - 1;												// (0-n) row
			col = (ei_new+1) / d_common.in2_sub_cumh_sel_rows + 1 - 1;											// (0-n) column
			if((ei_new+1) % d_common.in2_sub_cumh_sel_rows == 0){
				row = d_common.in2_sub_cumh_sel_rows - 1;
				col = col - 1;
			}

			// figure out corresponding location in old matrix and copy values to new matrix
			ori_row = row + d_common.in2_sub_cumh_sel_rowlow - 1;
			ori_col = col + d_common.in2_sub_cumh_sel_collow - 1;
			d_unique_d_in2_sub_cumh_sel[ei_new] = d_unique_d_in2_sub_cumh[ori_col*d_common.in2_sub_cumh_rows+ori_row];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	SELECTION 2, SUBTRACTION
		//==================================================50

		//==================================================
		//	SELECTION 2
		//==================================================

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sub2_elem){

			// figure out row/col location in new matrix
			row = (ei_new+1) % d_common.in2_sub2_rows - 1;												// (0-n) row
			col = (ei_new+1) / d_common.in2_sub2_rows + 1 - 1;											// (0-n) column
			if((ei_new+1) % d_common.in2_sub2_rows == 0){
				row = d_common.in2_sub2_rows - 1;
				col = col-1;
			}

			// figure out corresponding location in old matrix and copy values to new matrix
			ori_row = row + d_common.in2_sub_cumh_sel2_rowlow - 1;
			ori_col = col + d_common.in2_sub_cumh_sel2_collow - 1;
			d_unique_d_in2_sub2[ei_new] = d_unique_d_in2_sub_cumh[ori_col*d_common.in2_sub_cumh_rows+ori_row];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================
		//	SYNCHRONIZE THREADS
		//==================================================

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================
		//	SUBTRACTION
		//==================================================

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sub2_elem){

			// subtract
			d_unique_d_in2_sub2[ei_new] = d_unique_d_in2_sub_cumh_sel[ei_new] - d_unique_d_in2_sub2[ei_new];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//====================================================================================================100
		//	SYNCHRONIZE THREADS
		//====================================================================================================100

		barrier(CLK_LOCAL_MEM_FENCE);

		//====================================================================================================100
		//	CUMULATIVE SUM 2
		//====================================================================================================100

		//==================================================50
		//	MULTIPLICATION
		//==================================================50

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sqr_elem){

			temp = d_unique_d_in2[ei_new];
			d_unique_d_in2_sqr[ei_new] = temp * temp;

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	PAD ARRAY, VERTICAL CUMULATIVE SUM
		//==================================================50

		//==================================================
		//	PAD ARRAY
		//==================================================

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_pad_cumv_elem){

			// figure out row/col location in padded array
			row = (ei_new+1) % d_common.in2_pad_cumv_rows - 1;												// (0-n) row
			col = (ei_new+1) / d_common.in2_pad_cumv_rows + 1 - 1;											// (0-n) column
			if((ei_new+1) % d_common.in2_pad_cumv_rows == 0){
				row = d_common.in2_pad_cumv_rows - 1;
				col = col-1;
			}

			// execution
			if(	row > (d_common.in2_pad_add_rows-1) &&													// do if has numbers in original array
				row < (d_common.in2_pad_add_rows+d_common.in2_sqr_rows) &&
				col > (d_common.in2_pad_add_cols-1) &&
				col < (d_common.in2_pad_add_cols+d_common.in2_sqr_cols)){
				ori_row = row - d_common.in2_pad_add_rows;
				ori_col = col - d_common.in2_pad_add_cols;
				d_unique_d_in2_pad_cumv[ei_new] = d_unique_d_in2_sqr[ori_col*d_common.in2_sqr_rows+ori_row];
			}
			else{																							// do if otherwise
				d_unique_d_in2_pad_cumv[ei_new] = 0;
			}

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================
		//	SYNCHRONIZE THREADS
		//==================================================

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================
		//	VERTICAL CUMULATIVE SUM
		//==================================================

		//work
		ei_new = tx;
		while(ei_new < d_common.in2_pad_cumv_cols){

			// figure out column position
			pos_ori = ei_new*d_common.in2_pad_cumv_rows;

			// variables
			sum = 0;

			// loop through all rows
			for(position = pos_ori; position < pos_ori+d_common.in2_pad_cumv_rows; position = position + 1){
				d_unique_d_in2_pad_cumv[position] = d_unique_d_in2_pad_cumv[position] + sum;
				sum = d_unique_d_in2_pad_cumv[position];
			}

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	SELECTION
		//==================================================50

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_pad_cumv_sel_elem){

			// figure out row/col location in new matrix
			row = (ei_new+1) % d_common.in2_pad_cumv_sel_rows - 1;												// (0-n) row
			col = (ei_new+1) / d_common.in2_pad_cumv_sel_rows + 1 - 1;											// (0-n) column
			if((ei_new+1) % d_common.in2_pad_cumv_sel_rows == 0){
				row = d_common.in2_pad_cumv_sel_rows - 1;
				col = col-1;
			}

			// figure out corresponding location in old matrix and copy values to new matrix
			ori_row = row + d_common.in2_pad_cumv_sel_rowlow - 1;
			ori_col = col + d_common.in2_pad_cumv_sel_collow - 1;
			d_unique_d_in2_pad_cumv_sel[ei_new] = d_unique_d_in2_pad_cumv[ori_col*d_common.in2_pad_cumv_rows+ori_row];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	SELECTION 2, SUBTRACTION, HORIZONTAL CUMULATIVE SUM
		//==================================================50

		//==================================================
		//	SELECTION 2
		//==================================================

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sub_cumh_elem){

			// figure out row/col location in new matrix
			row = (ei_new+1) % d_common.in2_sub_cumh_rows - 1;												// (0-n) row
			col = (ei_new+1) / d_common.in2_sub_cumh_rows + 1 - 1;											// (0-n) column
			if((ei_new+1) % d_common.in2_sub_cumh_rows == 0){
				row = d_common.in2_sub_cumh_rows - 1;
				col = col-1;
			}

			// figure out corresponding location in old matrix and copy values to new matrix
			ori_row = row + d_common.in2_pad_cumv_sel2_rowlow - 1;
			ori_col = col + d_common.in2_pad_cumv_sel2_collow - 1;
			d_unique_d_in2_sub_cumh[ei_new] = d_unique_d_in2_pad_cumv[ori_col*d_common.in2_pad_cumv_rows+ori_row];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================
		//	SYNCHRONIZE THREADS
		//==================================================

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================
		//	SUBTRACTION
		//==================================================

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sub_cumh_elem){

			// subtract
			d_unique_d_in2_sub_cumh[ei_new] = d_unique_d_in2_pad_cumv_sel[ei_new] - d_unique_d_in2_sub_cumh[ei_new];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================
		//	HORIZONTAL CUMULATIVE SUM
		//==================================================

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sub_cumh_rows){

			// figure out row position
			pos_ori = ei_new;

			// variables
			sum = 0;

			// loop through all rows
			for(position = pos_ori; position < pos_ori+d_common.in2_sub_cumh_elem; position = position + d_common.in2_sub_cumh_rows){
				d_unique_d_in2_sub_cumh[position] = d_unique_d_in2_sub_cumh[position] + sum;
				sum = d_unique_d_in2_sub_cumh[position];
			}

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	SELECTION
		//==================================================50

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sub_cumh_sel_elem){

			// figure out row/col location in new matrix
			row = (ei_new+1) % d_common.in2_sub_cumh_sel_rows - 1;												// (0-n) row
			col = (ei_new+1) / d_common.in2_sub_cumh_sel_rows + 1 - 1;											// (0-n) column
			if((ei_new+1) % d_common.in2_sub_cumh_sel_rows == 0){
				row = d_common.in2_sub_cumh_sel_rows - 1;
				col = col - 1;
			}

			// figure out corresponding location in old matrix and copy values to new matrix
			ori_row = row + d_common.in2_sub_cumh_sel_rowlow - 1;
			ori_col = col + d_common.in2_sub_cumh_sel_collow - 1;
			d_unique_d_in2_sub_cumh_sel[ei_new] = d_unique_d_in2_sub_cumh[ori_col*d_common.in2_sub_cumh_rows+ori_row];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	SELECTION 2, SUBTRACTION
		//==================================================50

		//==================================================
		//	SELECTION 2
		//==================================================

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sub2_elem){

			// figure out row/col location in new matrix
			row = (ei_new+1) % d_common.in2_sub2_rows - 1;												// (0-n) row
			col = (ei_new+1) / d_common.in2_sub2_rows + 1 - 1;											// (0-n) column
			if((ei_new+1) % d_common.in2_sub2_rows == 0){
				row = d_common.in2_sub2_rows - 1;
				col = col-1;
			}

			// figure out corresponding location in old matrix and copy values to new matrix
			ori_row = row + d_common.in2_sub_cumh_sel2_rowlow - 1;
			ori_col = col + d_common.in2_sub_cumh_sel2_collow - 1;
			d_unique_d_in2_sqr_sub2[ei_new] = d_unique_d_in2_sub_cumh[ori_col*d_common.in2_sub_cumh_rows+ori_row];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================
		//	SYNCHRONIZE THREADS
		//==================================================

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================
		//	SUBTRACTION
		//==================================================

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sub2_elem){

			// subtract
			d_unique_d_in2_sqr_sub2[ei_new] = d_unique_d_in2_sub_cumh_sel[ei_new] - d_unique_d_in2_sqr_sub2[ei_new];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//====================================================================================================100
		//	SYNCHRONIZE THREADS
		//====================================================================================================100

		barrier(CLK_LOCAL_MEM_FENCE);

		//====================================================================================================100
		//	FINAL
		//====================================================================================================100

		//==================================================50
		//	DENOMINATOR A		SAVE RESULT IN CUMULATIVE SUM A2
		//==================================================50

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sub2_elem){

			temp = d_unique_d_in2_sub2[ei_new];
			temp2 = d_unique_d_in2_sqr_sub2[ei_new] - (temp * temp / d_common.in_elem);
			if(temp2 < 0){
				temp2 = 0;
			}
			d_unique_d_in2_sqr_sub2[ei_new] = sqrt(temp2);


			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	MULTIPLICATION
		//==================================================50

		// work
		ei_new = tx;
		while(ei_new < d_common.in_sqr_elem){

			temp = d_in[ei_new];
			d_unique_d_in_sqr[ei_new] = temp * temp;

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	IN SUM
		//==================================================50

		// work
		ei_new = tx;
		while(ei_new < d_common.in_cols){

			sum = 0;
			for(i = 0; i < d_common.in_rows; i++){

				sum = sum + d_in[ei_new*d_common.in_rows+i];

			}
			in_partial_sum[ei_new] = sum;

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	IN_SQR SUM
		//==================================================50

		ei_new = tx;
		while(ei_new < d_common.in_sqr_rows){

			sum = 0;
			for(i = 0; i < d_common.in_sqr_cols; i++){

				sum = sum + d_unique_d_in_sqr[ei_new+d_common.in_sqr_rows*i];

			}
			in_sqr_partial_sum[ei_new] = sum;

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	FINAL SUMMATION
		//==================================================50

		if(tx == 0){

			in_final_sum = 0;
			for(i = 0; i<d_common.in_cols; i++){
				in_final_sum = in_final_sum + in_partial_sum[i];
			}

		}else if(tx == 1){

			in_sqr_final_sum = 0;
			for(i = 0; i<d_common.in_sqr_cols; i++){
				in_sqr_final_sum = in_sqr_final_sum + in_sqr_partial_sum[i];
			}

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	DENOMINATOR T
		//==================================================50

		if(tx == 0){

			mean = in_final_sum / d_common.in_elem;													// gets mean (average) value of element in ROI
			mean_sqr = mean * mean;
			variance  = (in_sqr_final_sum / d_common.in_elem) - mean_sqr;							// gets variance of ROI
			deviation = sqrt(variance);																// gets standard deviation of ROI

			denomT = sqrt((float)(d_common.in_elem-1))*deviation;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	DENOMINATOR		SAVE RESULT IN CUMULATIVE SUM A2
		//==================================================50

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sub2_elem){

			d_unique_d_in2_sqr_sub2[ei_new] = d_unique_d_in2_sqr_sub2[ei_new] * denomT;

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	NUMERATOR	SAVE RESULT IN CONVOLUTION
		//==================================================50

		// work
		ei_new = tx;
		while(ei_new < d_common.conv_elem){

			d_unique_d_conv[ei_new] = d_unique_d_conv[ei_new] - d_unique_d_in2_sub2[ei_new] * in_final_sum / d_common.in_elem;

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	CORRELATION	SAVE RESULT IN CUMULATIVE SUM A2
		//==================================================50

		// work
		ei_new = tx;
		while(ei_new < d_common.in2_sub2_elem){

			d_unique_d_in2_sqr_sub2[ei_new] = d_unique_d_conv[ei_new] / d_unique_d_in2_sqr_sub2[ei_new];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	End
		//==================================================50

		//====================================================================================================100
		//	SYNCHRONIZE THREADS
		//====================================================================================================100

		barrier(CLK_LOCAL_MEM_FENCE);

		//====================================================================================================100
		//	TEMPLATE MASK CREATE
		//====================================================================================================100

		cent = d_common.sSize + d_common.tSize + 1;
		if(d_frame_no == 0){
			tMask_row = cent + d_unique_d_Row[d_unique_point_no] - d_unique_d_Row[d_unique_point_no] - 1;
			tMask_col = cent + d_unique_d_Col[d_unique_point_no] - d_unique_d_Col[d_unique_point_no] - 1;
		}
		else{
			pointer = d_frame_no-1+d_unique_point_no*d_common.no_frames;
			tMask_row = cent + d_unique_d_tRowLoc[pointer] - d_unique_d_Row[d_unique_point_no] - 1;
			tMask_col = cent + d_unique_d_tColLoc[pointer] - d_unique_d_Col[d_unique_point_no] - 1;
		}

		//work
		ei_new = tx;
		while(ei_new < d_common.tMask_elem){

			location = tMask_col*d_common.tMask_rows + tMask_row;

			if(ei_new==location){
				d_unique_d_tMask[ei_new] = 1;
			}
			else{
				d_unique_d_tMask[ei_new] = 0;
			}

			//go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//====================================================================================================100
		//	SYNCHRONIZE THREADS
		//====================================================================================================100

		barrier(CLK_LOCAL_MEM_FENCE);

		//====================================================================================================100
		//	MASK CONVOLUTION
		//====================================================================================================100

		// work
		ei_new = tx;
		while(ei_new < d_common.mask_conv_elem){

			// figure out row/col location in array
			ic = (ei_new+1) % d_common.mask_conv_rows;												// (1-n)
			jc = (ei_new+1) / d_common.mask_conv_rows + 1;											// (1-n)
			if((ei_new+1) % d_common.mask_conv_rows == 0){
				ic = d_common.mask_conv_rows;
				jc = jc-1;
			}

			//
			j = jc + d_common.mask_conv_joffset;
			jp1 = j + 1;
			if(d_common.mask_cols < jp1){
				ja1 = jp1 - d_common.mask_cols;
			}
			else{
				ja1 = 1;
			}
			if(d_common.tMask_cols < j){
				ja2 = d_common.tMask_cols;
			}
			else{
				ja2 = j;
			}

			i = ic + d_common.mask_conv_ioffset;
			ip1 = i + 1;

			if(d_common.mask_rows < ip1){
				ia1 = ip1 - d_common.mask_rows;
			}
			else{
				ia1 = 1;
			}
			if(d_common.tMask_rows < i){
				ia2 = d_common.tMask_rows;
			}
			else{
				ia2 = i;
			}

			s = 0;

			for(ja=ja1; ja<=ja2; ja++){
				jb = jp1 - ja;
				for(ia=ia1; ia<=ia2; ia++){
					ib = ip1 - ia;
					s = s + d_unique_d_tMask[d_common.tMask_rows*(ja-1)+ia-1] * 1;
				}
			}

			// //d_unique_d_mask_conv[d_common.mask_conv_rows*(jc-1)+ic-1] = s;
			d_unique_d_mask_conv[ei_new] = d_unique_d_in2_sqr_sub2[ei_new] * s;

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//====================================================================================================100
		//	SYNCHRONIZE THREADS
		//====================================================================================================100

		barrier(CLK_LOCAL_MEM_FENCE);

		//====================================================================================================100
		//	MAXIMUM VALUE
		//====================================================================================================100

		//==================================================50
		//	INITIAL SEARCH
		//==================================================50

		ei_new = tx;
		while(ei_new < d_common.mask_conv_rows){

			for(i=0; i<d_common.mask_conv_cols; i++){
				largest_coordinate_current = ei_new*d_common.mask_conv_rows+i;
				largest_value_current = fabs(d_unique_d_mask_conv[largest_coordinate_current]);
				if(largest_value_current > largest_value){
					largest_coordinate = largest_coordinate_current;
					largest_value = largest_value_current;
				}
			}
			par_max_coo[ei_new] = largest_coordinate;
			par_max_val[ei_new] = largest_value;

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

		//==================================================50
		//	SYNCHRONIZE THREADS
		//==================================================50

		barrier(CLK_LOCAL_MEM_FENCE);

		//==================================================50
		//	FINAL SEARCH
		//==================================================50

		if(tx == 0){

			for(i = 0; i < d_common.mask_conv_rows; i++){
				if(par_max_val[i] > fin_max_val){
					fin_max_val = par_max_val[i];
					fin_max_coo = par_max_coo[i];
				}
			}

			// convert coordinate to row/col form
			largest_row = (fin_max_coo+1) % d_common.mask_conv_rows - 1;											// (0-n) row
			largest_col = (fin_max_coo+1) / d_common.mask_conv_rows;												// (0-n) column
			if((fin_max_coo+1) % d_common.mask_conv_rows == 0){
				largest_row = d_common.mask_conv_rows - 1;
				largest_col = largest_col - 1;
			}

			// calculate offset
			largest_row = largest_row + 1;																	// compensate to match MATLAB format (1-n)
			largest_col = largest_col + 1;																	// compensate to match MATLAB format (1-n)
			offset_row = largest_row - d_common.in_rows - (d_common.sSize - d_common.tSize);
			offset_col = largest_col - d_common.in_cols - (d_common.sSize - d_common.tSize);
			pointer = d_frame_no+d_unique_point_no*d_common.no_frames;
			d_unique_d_tRowLoc[pointer] = d_unique_d_Row[d_unique_point_no] + offset_row;
			d_unique_d_tColLoc[pointer] = d_unique_d_Col[d_unique_point_no] + offset_col;

		}

		//==================================================50
		//	End
		//==================================================50

		//====================================================================================================100
		//	SYNCHRONIZE THREADS
		//====================================================================================================100

		barrier(CLK_LOCAL_MEM_FENCE);

		//====================================================================================================100
		//	End
		//====================================================================================================100

	}

	//======================================================================================================================================================150
	//	COORDINATE AND TEMPLATE UPDATE
	//======================================================================================================================================================150

	// if the last frame in the bath, update template
	if(d_frame_no != 0 && (d_frame_no)%10 == 0){

		// update coordinate
		loc_pointer = d_unique_point_no*d_common.no_frames+d_frame_no;
		d_unique_d_Row[d_unique_point_no] = d_unique_d_tRowLoc[loc_pointer];
		d_unique_d_Col[d_unique_point_no] = d_unique_d_tColLoc[loc_pointer];

		// work
		ei_new = tx;
		while(ei_new < d_common.in_elem){

			// figure out row/col location in new matrix
			row = (ei_new+1) % d_common.in_rows - 1;												// (0-n) row
			col = (ei_new+1) / d_common.in_rows + 1 - 1;											// (0-n) column
			if((ei_new+1) % d_common.in_rows == 0){
				row = d_common.in_rows - 1;
				col = col-1;
			}

			// figure out row/col location in corresponding new template area in image and give to every thread (get top left corner and progress down and right)
			ori_row = d_unique_d_Row[d_unique_point_no] - 25 + row - 1;
			ori_col = d_unique_d_Col[d_unique_point_no] - 25 + col - 1;
			ori_pointer = ori_col*d_common.frame_rows+ori_row;

			// update template
			d_in[ei_new] = d_common.alpha*d_in[ei_new] + (1.00-d_common.alpha)*d_common_change_d_frame[ori_pointer];

			// go for second round
			ei_new = ei_new + NUMBER_THREADS;

		}

	}

	//======================================================================================================================================================150
	//	End
	//======================================================================================================================================================150

}

//========================================================================================================================================================================================================200
//	END
//========================================================================================================================================================================================================200

