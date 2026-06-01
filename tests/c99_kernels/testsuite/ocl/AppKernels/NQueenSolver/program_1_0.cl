// N-queen solver for OpenCL
// Ping-Che Chen


// define this to use predicated version in the rotation check part
#define PREDICATED


#ifdef USE_ATOMICS
#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
#endif

#ifdef ENABLE_CHAR
#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : enable
#endif


inline int bit_scan(unsigned int x)
{
	int res = 0;
	res |= (x & 0xaaaaaaaa) ? 1 : 0;
	res |= (x & 0xcccccccc) ? 2 : 0;
	res |= (x & 0xf0f0f0f0) ? 4 : 0;
	res |= (x & 0xff00ff00) ? 8 : 0;
	res |= (x & 0xffff0000) ? 16 : 0;
	return res;
}


#ifdef FORCE_CPU
/*
__kernel void nqueen(int board_size, int level, int threads, __global uint* params, __global uint* results)
{
	int idx = get_global_id(0);
	uint mask = params[idx];
	uint left_mask = params[idx + threads];
	uint right_mask = params[idx + threads * 2];
	uint coeff = params[idx + threads * 3];
	uint board_mask = (1 << board_size) - 1;

	uint masks[32];
	uint left_masks[32];
	uint right_masks[32];
	uint ms[32];
	uint ns;
	uint solutions = 0;
	int i = 0;

	masks[0] = mask;
	left_masks[0] = left_mask;
	right_masks[0] = right_mask;
	ms[0] = mask | left_mask | right_mask;

	while(i >= 0) {
		ns = ((ms[i] + 1) & ~ms[i]);
		if((ns & board_mask) != 0) {
			ms[i] |= ns;

			if(i == level - 1) {
				solutions++;
				i--;
			}
			else {
				masks[i+1] = masks[i] | ns;
				left_masks[i+1] = (left_masks[i] | ns) << 1;
				right_masks[i+1] = (right_masks[i] | ns) >> 1;
				ms[i+1] = masks[i+1] | left_masks[i+1] | right_masks[i + 1];
				i++;
			}
		}
		else {
			i--;
		}
	}

	results[idx] = solutions * coeff;
}
*/

#define BOARD(x) ((x) < board_size - level ? params[idx + pitch * (4 + (x))] : ns[(x) - board_size + level])

__kernel void nqueen(int board_size, int level, int threads, int pitch, __global uint* params, __global uint* results, __constant uint* forbidden)
{
	int idx = get_global_id(0);
	int tid = get_local_id(0);
	uint mask = params[idx];
	uint left_mask = params[idx + pitch];
	uint right_mask = params[idx + pitch * 2];
	uint index = params[idx + pitch * 3];
	uint board_mask = (1 << board_size) - 1;
	uint left_mask_big = 0;
	uint right_mask_big = 0;

	uint left_masks[32];
	uint right_masks[32];
	uint ms[32];
	uint ns[33];
	uint solutions = 0;
	uint unique_solutions = 0;
	int i = 0;
	int j;

	int t_array[32];
	int board_array[32];

	ms[0] = mask | left_mask | right_mask | forbidden[0];
	ns[0] = ((ms[0] + 1) & ~ms[0]);
	left_masks[0] = left_mask;
	right_masks[0] = right_mask;

	results[idx + pitch * 2] = params[idx];	// for checking kernel exeuction completion

	while(i >= 0) {
		if((ns[i] & board_mask) != 0) {
			mask |= ns[i];
			left_masks[i+1] = (left_masks[i] | ns[i]) << 1;
			right_masks[i+1] = (right_masks[i] | ns[i]) >> 1;
			ms[i+1] = mask | left_masks[i+1] | right_masks[i+1] | forbidden[i + 1];
			ns[i+1] = ((ms[i+1] + 1) & ~ms[i+1]);
			i++;
		}
		else {
			if(i == level) {
				int repeat_times = 8;
				bool repeat = false;
				bool equal = true;

				bool rotate1 = (BOARD(index) == (1 << (board_size - 1)));
				bool rotate2 = (BOARD(board_size - index - 1) == 1);
				bool rotate3 = (ns[level - 1] == (1 << (board_size - index - 1)));

				if(rotate1 || rotate2 || rotate3) {
					for(j = 0; j < board_size - level; j++) {
						board_array[j] = bit_scan(params[idx + pitch * (4 + j)]);
					}
					for(j = 0; j < level; j++) {
						board_array[j + board_size - level] = bit_scan(ns[j]);
					}

					if(rotate3) {
						// rotate 180
						equal = true;
						for(j = 0; j < board_size; j++) {
							t_array[board_size - j - 1] = (board_size - board_array[j] - 1);
						}

						for(j = 0; j < board_size; j++) {
							if(t_array[j] < board_array[j]) {
								repeat = true;
								equal = false;
								break;
							}
							else if(t_array[j] > board_array[j]) {
								equal = false;
								break;
							}
						}

						if(equal) {
							repeat_times = 4;
						}
					}

					// rotate cw
					if(!repeat && rotate1) {
						equal = true;
						for(j = 0; j < board_size; j++) {
							t_array[board_size - board_array[j] - 1] = j;
						}

						for(j = 0; j < board_size; j++) {
							if(t_array[j] < board_array[j]) {
								repeat = true;
								equal = false;
								break;
							}
							else if(t_array[j] > board_array[j]) {
								equal = false;
								break;
							}
						}

						if(equal) {
							repeat_times = 2;
						}
					}

					if(!repeat && rotate2) {
						// rotate ccw
						equal = true;
						for(j = 0; j < board_size; j++) {
							t_array[board_array[j]] = (board_size - j - 1);
						}
						for(j = 0; j < board_size; j++) {
							if(t_array[j] < board_array[j]) {
								repeat = true;
								equal = false;
								break;
							}
							else if(t_array[j] > board_array[j]) {
								equal = false;
								break;
							}
						}

						if(equal) {
							repeat_times = 2;
						}
					}

					if(!repeat) {
						solutions += repeat_times;
						unique_solutions++;
					}
				}
				else {
					solutions += 8;
					unique_solutions ++;
				}
			}

			i--;
			if(i >= 0) {
				mask &= ~ns[i];
				ms[i] |= ns[i];
				ns[i] = ((ms[i] + 1) & ~ms[i]);
			}
		}
	}

	results[idx] = solutions;
	results[idx + pitch] = unique_solutions;
	results[idx + pitch * 3] = params[idx];	// for checking kernel exeuction completion
}

__kernel void nqueen1(int board_size, int level, int threads, int pitch, __global uint* params, __global uint* results, __constant uint* forbidden)
{
	int idx = get_global_id(0);
	int tid = get_local_id(0);
	uint mask = params[idx];
	uint left_mask = params[idx + pitch];
	uint right_mask = params[idx + pitch * 2];
	int second_row = params[idx + pitch * 3];
	uint board_mask = (1 << board_size) - 1;
	uint left_mask_big = 0;
	uint right_mask_big = 0;

	uint left_masks[32];
	uint right_masks[32];
	uint ms[32];
	uint ns[33];
	uint solutions = 0;
	int i = 0;

	ms[0] = mask | left_mask | right_mask | (i < second_row ? 2 : 0);
	ns[0] = ((ms[0] + 1) & ~ms[0]);
	left_masks[0] = left_mask;
	right_masks[0] = right_mask;

	results[idx + pitch * 2] = params[idx];	// for checking kernel exeuction completion

	while(i >= 0) {
		if((ns[i] & board_mask) != 0) {
			mask |= ns[i];
			left_masks[i+1] = (left_masks[i] | ns[i]) << 1;
			right_masks[i+1] = (right_masks[i] | ns[i]) >> 1;
			ms[i+1] = mask | left_masks[i+1] | right_masks[i+1] | (i + 1 < second_row ? 2 : 0);
			ns[i + 1] = ((ms[i+1] + 1) & ~ms[i+1]);
			i++;
		}
		else {
			if(i == level) {
				solutions++;
			}

			i--;
			if(i >= 0) {
				mask &= ~ns[i];
				ms[i] |= ns[i];
				ns[i] = ((ms[i] + 1) & ~ms[i]);
			}
		}
	}

	results[idx] = solutions * 8;
	results[idx + pitch] = solutions;
	results[idx + pitch * 3] = params[idx];	// for checking kernel exeuction completion
}

#else

#ifdef FORCE_LOCAL
#define ARRAY_DECL __local uint ns[12][WORK_ITEMS];
#define NS(x) ns[x][tid]
#define FORBIDDEN_DECL __local uint forbidden[12][32];
#define FORBIDDEN(x) forbidden[x][tid % 32]
//#define BOARD_ARRAY_DECL __local char board_array[32][WORK_ITEMS];
//#define BOARD_ARRAY(x) board_array[x][tid]
#ifdef ENABLE_CHAR
#define BOARD_ARRAY_DECL char board_array[32];
#else
#define BOARD_ARRAY_DECL int board_array[32];
#endif
#define BOARD_ARRAY(x) board_array[x]
#else
#define ARRAY_DECL uint ns[12];
#define NS(x) ns[x]
#define FORBIDDEN_DECL
#define FORBIDDEN(x) forbidden_data[x]
#define BOARD_ARRAY_DECL int board_array[32];
#define BOARD_ARRAY(x) board_array[x]
#endif

#define BOARD(x) ((x) < board_size - level ? params[idx + pitch * (4 + (x))] : NS((x) - board_size + level))

#ifdef USE_ATOMICS
__kernel __attribute__((reqd_work_group_size(WORK_ITEMS, 1,1))) void nqueen(int board_size, int level, int threads, int pitch, __global uint* params, __global uint* results, __constant uint* forbidden_data, __global int* global_index)
#else
__kernel __attribute__((reqd_work_group_size(WORK_ITEMS, 1,1))) void nqueen(int board_size, int level, int threads, int pitch, __global uint* params, __global uint* results, __constant uint* forbidden_data)
#endif
{
	int idx = get_global_id(0);
	int tid = get_local_id(0);

	BOARD_ARRAY_DECL

	uint ms;
	ARRAY_DECL
	FORBIDDEN_DECL

	uint solutions = 0;
	uint unique_solutions = 0;
	int i;
	int j;

	uint mask = params[idx];
	uint left_mask = params[idx + pitch];
	uint right_mask = params[idx + pitch * 2];
	uint index = params[idx + pitch * 3];
	uint board_mask = (1 << board_size) - 1;
	uint left_mask_big = 0;
	uint right_mask_big = 0;

	results[idx + pitch * 2] = params[idx];	// for checking kernel exeuction completion

	for(j = 0; j < board_size - level; j++) {
		BOARD_ARRAY(j) = bit_scan(params[idx + pitch * (4 + j)]);
	}

#ifdef FORCE_LOCAL
	if(tid < 32) {
		for(i = 0; i <= level; i++) {
			FORBIDDEN(i) = forbidden_data[i];
		}
	}

	barrier(CLK_LOCAL_MEM_FENCE);
#endif

	i = 0;

	ms = mask | left_mask | right_mask | FORBIDDEN(0);
	NS(0) = ((ms + 1) & ~ms);

	for(;;) {
		if(i >= 0) {
			if((NS(i) & board_mask) != 0) {
				mask |= NS(i);
				left_mask_big = (left_mask_big << 1) | (left_mask >> 31);
				left_mask = (left_mask | NS(i)) << 1;
				right_mask_big = (right_mask_big >> 1) | (right_mask << 31);
				right_mask = (right_mask | NS(i)) >> 1;
				ms = mask | left_mask | right_mask | FORBIDDEN(i + 1);
				NS(i + 1) = ((ms + 1) & ~ms);
				i++;
			}
			else {
				if(i == level) {
					int repeat_times = 8;
					bool equal = true;

					bool rotate1 = (BOARD(index) == (1 << (board_size - 1)));
					bool rotate2 = (BOARD(board_size - index - 1) == 1);
					bool rotate3 = (NS(level - 1) == (1 << (board_size - index - 1)));

					if(rotate1 || rotate2 || rotate3) {
						for(j = 0; j < level; j++) {
							BOARD_ARRAY(j + board_size - level) = bit_scan(NS(j));
						}

						int min_pos = board_size;
						int relation = 0;

						// rotate cw
						if(rotate1) {
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[board_size - board_array[j] - 1] = j;
	//						}
	//
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < board_array[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > board_array[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							relation = 0;
							for(j = 0; j < board_size; j++) {
#ifndef PREDICATED
								if(BOARD_ARRAY(board_size - BOARD_ARRAY(j) - 1) != j) {
									equal = false;
									if(min_pos > board_size - BOARD_ARRAY(j) - 1) {
										relation = BOARD_ARRAY(board_size - BOARD_ARRAY(j) - 1) - j;
										min_pos = board_size - BOARD_ARRAY(j) - 1;
									}
								}
#else
								int p = board_size - BOARD_ARRAY(j) - 1;
								bool cond = (BOARD_ARRAY(p) != j);
								equal = equal && !cond;
								cond = cond && (min_pos > p);
								relation = cond ? BOARD_ARRAY(p) - j : relation;
								min_pos = cond ? p : min_pos;
#endif
							}

							repeat_times = equal ? 2 : repeat_times;
//							if(equal) {
//								repeat_times = 2;
//							}
						}

						if(relation >= 0 && rotate2) {
							// rotate ccw
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[board_array[j]] = (board_size - j - 1);
	//						}
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < board_array[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > board_array[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							min_pos = board_size;
							relation = 0;
							for(j = 0; j < board_size; j++) {
#ifndef PREDICATED
								if(BOARD_ARRAY(BOARD_ARRAY(j)) != board_size - j - 1) {
									equal = false;
									if(min_pos > BOARD_ARRAY(j)) {
										relation = BOARD_ARRAY(BOARD_ARRAY(j)) - (board_size - j - 1);
										min_pos = BOARD_ARRAY(j);
									}
								}
#else
								int p = BOARD_ARRAY(j);
								bool cond = (BOARD_ARRAY(p) != board_size - j - 1);
								equal = equal && !cond;
								cond = cond && (min_pos > p);
								relation = cond ? BOARD_ARRAY(p) - (board_size - j - 1) : relation;
								min_pos = cond ? p : min_pos;
#endif

							}

							repeat_times = equal ? 2 : repeat_times;
//							if(equal) {
//								repeat_times = 2;
//							}
						}

						if(relation >= 0 && repeat_times == 8 && rotate3) {
							// rotate 180
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[board_size - j - 1] = (board_size - board_array[j] - 1);
	//						}
	//
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < board_array[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > board_array[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							min_pos = board_size;
							relation = 0;
							for(j = board_size - 1; j >= board_size / 2; j--) {
								if(BOARD_ARRAY(board_size - j - 1) != board_size - BOARD_ARRAY(j) - 1) {
									equal = false;
									relation = BOARD_ARRAY(board_size - j - 1) - (board_size - BOARD_ARRAY(j) - 1);
									break;
								}
							}
	//						for(j = 0; j < board_size; j++) {
	//							if(BOARD_ARRAY(board_size - j - 1) != board_size - BOARD_ARRAY(j) - 1) {
	//								equal = false;
	//								if(min_pos > board_size - j - 1) {
	//									relation = BOARD_ARRAY(board_size - j - 1) - (board_size - BOARD_ARRAY(j) - 1);
	//									min_pos = board_size - j - 1;
	//								}
	//							}
	//						}

							repeat_times = equal ? 4 : repeat_times;
//							if(equal) {
//								repeat_times = 4;
//							}
						}

						solutions += (relation >= 0) ? repeat_times : 0;
						unique_solutions += (relation >= 0) ? 1 : 0;
//						if(relation >= 0) {
//							solutions += repeat_times;
//							unique_solutions++;
//						}
					}
					else {
						solutions += 8;
						unique_solutions ++;
					}
				}

				i--;
				if(i >= 0) {
					mask &= ~NS(i);
					left_mask = ((left_mask >> 1) | (left_mask_big << 31)) & ~NS(i);
					left_mask_big >>= 1;
					right_mask = ((right_mask << 1) | (right_mask_big >> 31)) & ~NS(i);
					right_mask_big <<= 1;
					ms = mask | left_mask | right_mask | NS(i) | FORBIDDEN(i);
					NS(i) = ((ms + NS(i)) & ~ms);
				}
			}
		}
		else {
			results[idx] = solutions;
			results[idx + pitch] = unique_solutions;
			results[idx + pitch * 3] = params[idx];	// for checking kernel exeuction completion


#ifdef USE_ATOMICS
			idx = atom_inc(global_index);
			if(idx < threads) {
				solutions = 0;
				unique_solutions = 0;
				i = 0;

				mask = params[idx];
				left_mask = params[idx + pitch];
				right_mask = params[idx + pitch * 2];
				index = params[idx + pitch * 3];
				left_mask_big = 0;
				right_mask_big = 0;

				results[idx + pitch * 2] = params[idx];	// for checking kernel exeuction completion

				for(j = 0; j < board_size - level; j++) {
					BOARD_ARRAY(j) = bit_scan(params[idx + pitch * (4 + j)]);
				}

				ms = mask | left_mask | right_mask | FORBIDDEN(0);
				NS(0) = ((ms + 1) & ~ms);
			}
			else {
				break;
			}
#else
			break;
#endif
		}
	}
}

#ifdef USE_ATOMICS
__kernel __attribute__((reqd_work_group_size(WORK_ITEMS, 1,1))) void nqueen1(int board_size, int level, int threads, int pitch, __global uint* params, __global uint* results, __constant uint* forbidden, __global int* global_index)
#else
__kernel __attribute__((reqd_work_group_size(WORK_ITEMS, 1,1))) void nqueen1(int board_size, int level, int threads, int pitch, __global uint* params, __global uint* results, __constant uint* forbidden)
#endif
{
	int idx = get_global_id(0);
	int tid = get_local_id(0);

	uint ms;
	ARRAY_DECL

	uint mask = params[idx];
	uint left_mask = params[idx + pitch];
	uint right_mask = params[idx + pitch * 2];
	int second_row = params[idx + pitch * 3];
	uint board_mask = (1 << board_size) - 1;
	uint left_mask_big = 0;
	uint right_mask_big = 0;
	uint solutions = 0;
	int i = 0;

	ms = mask | left_mask | right_mask | (i < second_row ? 2 : 0);
	NS(0) = ((ms + 1) & ~ms);

	results[idx + pitch * 2] = params[idx];	// for checking kernel exeuction completion

	for(;;) {
		if(i >= 0) {
			if((NS(i) & board_mask) != 0) {
				mask |= NS(i);
				left_mask_big = (left_mask_big << 1) | (left_mask >> 31);
				left_mask = (left_mask | NS(i)) << 1;
				right_mask_big = (right_mask_big >> 1) | (right_mask << 31);
				right_mask = (right_mask | NS(i)) >> 1;
				ms = mask | left_mask | right_mask | (i + 1 < second_row ? 2 : 0);
				NS(i + 1) = ((ms + 1) & ~ms);
				i++;
			}
			else {
				if(i == level) {
					solutions++;
				}

				i--;
				if(i >= 0) {
					mask &= ~NS(i);
					left_mask = ((left_mask >> 1) | (left_mask_big << 31)) & ~NS(i);
					left_mask_big >>= 1;
					right_mask = ((right_mask << 1) | (right_mask_big >> 31)) & ~NS(i);
					right_mask_big <<= 1;
					ms = mask | left_mask | right_mask | NS(i) | (i < second_row ? 2 : 0);
					NS(i) = ((ms + NS(i)) & ~ms);
				}
			}

/*
			bool n = ((NS(i) & board_mask) != 0);
			uint nss = NS(i);
			mask = n ? (mask | nss) : mask;
			left_mask_big = n ? ((left_mask_big << 1) | (left_mask >> 31)) : left_mask_big;
			left_mask = n ? ((left_mask | nss) << 1) : left_mask;
			right_mask_big = n ? ((right_mask_big >> 1) | (right_mask << 31)) : right_mask_big;
			right_mask = n ? ((right_mask | nss) >> 1) : right_mask;
			ms = mask | left_mask | right_mask | (i + 1 < second_row ? 2 : 0);
			nss = NS(i + 1);
			NS(i + 1) = n ? ((ms + 1) & ~ms) : nss;
//			i = n ? i + 1 : i;

			solutions = (!n && i == level) ? solutions + 1 : solutions;

			i = n ? i + 1 : i - 1;
//			i = !n ? i - 1 : i;
			n = (!n && i >= 0);
			nss = ~NS(max(i, 0));
			mask = n ? (mask & nss) : mask;
			left_mask = n ? (((left_mask >> 1) | (left_mask_big << 31)) & nss) : left_mask;
			left_mask_big = n ? (left_mask_big >> 1) : left_mask_big;
			right_mask = n ? (((right_mask << 1) | (right_mask_big >> 31)) & nss) : right_mask;
			right_mask_big = n ? (right_mask_big << 1) : right_mask_big;
			ms = mask | left_mask | right_mask | ~nss | (i < second_row ? 2 : 0);
			if(n) NS(i) = (ms + ~nss) & ~ms;
*/
		}
		else {
			results[idx] = solutions * 8;
			results[idx + pitch] = solutions;
			results[idx + pitch * 3] = params[idx];	// for checking kernel exeuction completion

#ifdef USE_ATOMICS
			idx = atom_inc(global_index);
			if(idx < threads) {
				mask = params[idx];
				left_mask = params[idx + pitch];
				right_mask = params[idx + pitch * 2];
				second_row = params[idx + pitch * 3];
				left_mask_big = 0;
				right_mask_big = 0;
				solutions = 0;
				i = 0;

				results[idx + pitch * 2] = params[idx];	// for checking kernel exeuction completion

				ms = mask | left_mask | right_mask | (i < second_row ? 2 : 0);
				NS(0) = ((ms + 1) & ~ms);
			}
			else {
				break;
			}
#else
			break;
#endif
		}
	}
}


#ifdef ENABLE_VECTORIZE


#ifndef USE_VEC2
// vec4 version
#ifdef USE_ATOMICS
__kernel __attribute__((reqd_work_group_size(WORK_ITEMS, 1,1))) void nqueen1_vec(int board_size, int level, int threads, int pitch, __global uint4* params, __global uint4* results, __constant uint* forbidden, __global int* global_index)
#else
__kernel __attribute__((reqd_work_group_size(WORK_ITEMS, 1,1))) void nqueen1_vec(int board_size, int level, int threads, int pitch, __global uint4* params, __global uint4* results, __constant uint* forbidden)
#endif
{
	int idx = get_global_id(0);
	int tid = get_local_id(0);

	uint4 ms;
	__local uint nsx[12][WORK_ITEMS];
	__local uint nsy[12][WORK_ITEMS];
	__local uint nsz[12][WORK_ITEMS];
	__local uint nsw[12][WORK_ITEMS];

	uint4 mask = params[idx];
	uint4 left_mask = params[idx + pitch];
	uint4 right_mask = params[idx + pitch * 2];
	int4 second_row = convert_int4(params[idx + pitch * 3]);
	uint4 board_mask = (uint4) ((1 << board_size) - 1);
	uint4 left_mask_big = (uint4) 0;
	uint4 right_mask_big = (uint4) 0;
	uint4 solutions = (uint4) 0;
	int4 i = (int4) 0;
	uint4 nsi, nsi_mask;

	ms = mask | left_mask | right_mask | (convert_uint4(i < second_row) & (uint4)2);
	nsi = ((ms + (uint4) 1) & ~ms);
	nsx[0][tid] = nsi.x;
	nsy[0][tid] = nsi.y;
	nsz[0][tid] = nsi.z;
	nsw[0][tid] = nsi.w;

	results[idx + pitch * 2] = params[idx];	// for checking kernel exeuction completion

	for(;;) {
		if(any(i >= (int4) 0)) {
			nsi.x = nsx[max(i.x, 0)][tid];
			nsi.y = nsy[max(i.y, 0)][tid];
			nsi.z = nsz[max(i.z, 0)][tid];
			nsi.w = nsw[max(i.w, 0)][tid];
			nsi_mask = convert_uint4((nsi & board_mask) != (uint4) 0) & convert_uint4(i >= (int4) 0);

			{
				// for nsi_mask == true...
				mask |= (nsi & nsi_mask);
				left_mask_big = select(left_mask_big, (left_mask_big << (uint4) 1) | (left_mask >> (uint4) 31), nsi_mask);
				left_mask = select(left_mask, (left_mask | nsi) << (uint4) 1, nsi_mask);
				right_mask_big = select(right_mask_big, (right_mask_big >> (uint4) 1) | (right_mask << (uint4) 31), nsi_mask);
				right_mask = select(right_mask, ((right_mask | nsi) >> (uint4) 1), nsi_mask);
				ms = mask | left_mask | right_mask | (convert_uint4((i + 1) < second_row) & (uint4)2);
				nsi = select(nsi, ((ms + (uint4) 1) & ~ms), nsi_mask);
				i = select(i, i + 1, convert_int4(nsi_mask));
				nsx[max(i.x, 0)][tid] = nsi.x;
				nsy[max(i.y, 0)][tid] = nsi.y;
				nsz[max(i.z, 0)][tid] = nsi.z;
				nsw[max(i.w, 0)][tid] = nsi.w;
			}

			{
				// for nsi_mask == false
				solutions -= (convert_uint4(i == (int4) level) & ~nsi_mask);
				i = select(i - 1, i, convert_int4(nsi_mask));

				nsi.x = nsx[max(i.x, 0)][tid];
				nsi.y = nsy[max(i.y, 0)][tid];
				nsi.z = nsz[max(i.z, 0)][tid];
				nsi.w = nsw[max(i.w, 0)][tid];
				nsi_mask = ~nsi_mask & convert_uint4(i >= (int4) 0);

				// for i >= 0
				mask = select(mask, mask & ~nsi, nsi_mask);
				left_mask = select(left_mask, (((left_mask >> (uint4) 1) | (left_mask_big << (uint4) 31)) & ~nsi), nsi_mask);
				left_mask_big = select(left_mask_big, (left_mask_big >> (uint4) 1), nsi_mask);
				right_mask = select(right_mask, (((right_mask << (uint4) 1) | (right_mask_big >> (uint4) 31)) & ~nsi), nsi_mask);
				right_mask_big = select(right_mask_big, (right_mask_big << (uint4) 1), nsi_mask);
				ms = mask | left_mask | right_mask | nsi | (convert_uint4(i < second_row) & (uint4)2);
				nsi = select(nsi, ((ms + nsi) & ~ms), nsi_mask);

				nsx[max(i.x, 0)][tid] = nsi.x;
				nsy[max(i.y, 0)][tid] = nsi.y;
				nsz[max(i.z, 0)][tid] = nsi.z;
				nsw[max(i.w, 0)][tid] = nsi.w;
			}
		}
		else {
			results[idx] = solutions * (uint4) 8;
			results[idx + pitch] = solutions;
			results[idx + pitch * 3] = params[idx];	// for checking kernel exeuction completion

#ifdef USE_ATOMICS
			idx = atom_inc(global_index);
			if(idx < threads) {
				mask = params[idx];
				left_mask = params[idx + pitch];
				right_mask = params[idx + pitch * 2];
				second_row = convert_int4(params[idx + pitch * 3]);
				board_mask = (uint4) ((1 << board_size) - 1);
				left_mask_big = (uint4) 0;
				right_mask_big = (uint4) 0;
				solutions = (uint4) 0;
				i = (int4) 0;

				ms = mask | left_mask | right_mask | (convert_uint4(i < second_row) & (uint4)2);
				nsi = ((ms + (uint4) 1) & ~ms);
				nsx[0][tid] = nsi.x;
				nsy[0][tid] = nsi.y;
				nsz[0][tid] = nsi.z;
				nsw[0][tid] = nsi.w;

				results[idx + pitch * 2] = params[idx];	// for checking kernel exeuction completion
			}
			else {
				break;
			}
#else
		break;
#endif
		}
	}
}

#else

#ifdef USE_ATOMICS
__kernel __attribute__((reqd_work_group_size(WORK_ITEMS, 1,1))) void nqueen1_vec(int board_size, int level, int threads, int pitch, __global uint2* params, __global uint2* results, __constant uint* forbidden, __global int* global_index)
#else
__kernel __attribute__((reqd_work_group_size(WORK_ITEMS, 1,1))) void nqueen1_vec(int board_size, int level, int threads, int pitch, __global uint2* params, __global uint2* results, __constant uint* forbidden)
#endif
{
	int idx = get_global_id(0);
	int tid = get_local_id(0);

	uint2 ms;
	__local uint nsx[12][WORK_ITEMS];
	__local uint nsy[12][WORK_ITEMS];

	uint2 mask = params[idx];
	uint2 left_mask = params[idx + pitch];
	uint2 right_mask = params[idx + pitch * 2];
	int2 second_row = convert_int2(params[idx + pitch * 3]);
	uint2 board_mask = (uint2) ((1 << board_size) - 1);
	uint2 left_mask_big = (uint2) 0;
	uint2 right_mask_big = (uint2) 0;
	uint2 solutions = (uint2) 0;
	int2 i = (int2) 0;
	uint2 nsi, nsi_mask;

	ms = mask | left_mask | right_mask | (convert_uint2(i < second_row) & (uint2)2);
	nsi = ((ms + (uint2) 1) & ~ms);
	nsx[0][tid] = nsi.x;
	nsy[0][tid] = nsi.y;

	results[idx + pitch * 2] = params[idx];	// for checking kernel exeuction completion

	for(;;) {
		if(any(i >= (int2) 0)) {
			nsi.x = nsx[max(i.x, 0)][tid];
			nsi.y = nsy[max(i.y, 0)][tid];
			nsi_mask = convert_uint2((nsi & board_mask) != (uint2) 0) & convert_uint2(i >= (int2) 0);

			{
				// for nsi_mask == true...
				mask |= (nsi & nsi_mask);
				left_mask_big = select(left_mask_big, (left_mask_big << (uint2) 1) | (left_mask >> (uint2) 31), nsi_mask);
				left_mask = select(left_mask, (left_mask | nsi) << (uint2) 1, nsi_mask);
				right_mask_big = select(right_mask_big, (right_mask_big >> (uint2) 1) | (right_mask << (uint2) 31), nsi_mask);
				right_mask = select(right_mask, ((right_mask | nsi) >> (uint2) 1), nsi_mask);
				ms = mask | left_mask | right_mask | (convert_uint2((i + 1) < second_row) & (uint2)2);
				nsi = select(nsi, ((ms + (uint2) 1) & ~ms), nsi_mask);
				i = select(i, i + 1, convert_int2(nsi_mask));
				nsx[max(i.x, 0)][tid] = nsi.x;
				nsy[max(i.y, 0)][tid] = nsi.y;
			}

			{
				// for nsi_mask == false
				solutions -= (convert_uint2(i == (int2) level) & ~nsi_mask);
				i = select(i - 1, i, convert_int2(nsi_mask));

				nsi.x = nsx[max(i.x, 0)][tid];
				nsi.y = nsy[max(i.y, 0)][tid];
				nsi_mask = ~nsi_mask & convert_uint2(i >= (int2) 0);

				// for i >= 0
				mask = select(mask, mask & ~nsi, nsi_mask);
				left_mask = select(left_mask, (((left_mask >> (uint2) 1) | (left_mask_big << (uint2) 31)) & ~nsi), nsi_mask);
				left_mask_big = select(left_mask_big, (left_mask_big >> (uint2) 1), nsi_mask);
				right_mask = select(right_mask, (((right_mask << (uint2) 1) | (right_mask_big >> (uint2) 31)) & ~nsi), nsi_mask);
				right_mask_big = select(right_mask_big, (right_mask_big << (uint2) 1), nsi_mask);
				ms = mask | left_mask | right_mask | nsi | (convert_uint2(i < second_row) & (uint2)2);
				nsi = select(nsi, ((ms + nsi) & ~ms), nsi_mask);

				nsx[max(i.x, 0)][tid] = nsi.x;
				nsy[max(i.y, 0)][tid] = nsi.y;
			}
		}
		else {
			results[idx] = solutions * (uint2) 8;
			results[idx + pitch] = solutions;
			results[idx + pitch * 3] = params[idx];	// for checking kernel exeuction completion

#ifdef USE_ATOMICS
			idx = atom_inc(global_index);
			if(idx < threads) {
				mask = params[idx];
				left_mask = params[idx + pitch];
				right_mask = params[idx + pitch * 2];
				second_row = convert_int2(params[idx + pitch * 3]);
				board_mask = (uint2) ((1 << board_size) - 1);
				left_mask_big = (uint2) 0;
				right_mask_big = (uint2) 0;
				solutions = (uint2) 0;
				i = (int2) 0;

				ms = mask | left_mask | right_mask | (convert_uint2(i < second_row) & (uint2)2);
				nsi = ((ms + (uint2) 1) & ~ms);
				nsx[0][tid] = nsi.x;
				nsy[0][tid] = nsi.y;

				results[idx + pitch * 2] = params[idx];	// for checking kernel exeuction completion
			}
			else {
				break;
			}
#else
			break;
#endif
		}
	}
}

#endif


//#define BOARDX(n) ((n) < board_size - level ? params[idx + pitch * (4 + (n))].x : nsx[((n) - board_size + level)][tid])
//#define BOARDY(n) ((n) < board_size - level ? params[idx + pitch * (4 + (n))].y : nsy[((n) - board_size + level)][tid])
#define BOARDX(n) ((n) < board_size - level ? (1 << BOARD_ARRAYX(n)) : nsx[((n) - board_size + level)][tid])
#define BOARDY(n) ((n) < board_size - level ? (1 << BOARD_ARRAYY(n)) : nsy[((n) - board_size + level)][tid])
#define BOARDZ(n) ((n) < board_size - level ? (1 << BOARD_ARRAYZ(n)) : nsz[((n) - board_size + level)][tid])
#define BOARDW(n) ((n) < board_size - level ? (1 << BOARD_ARRAYW(n)) : nsw[((n) - board_size + level)][tid])

#ifdef ENABLE_CHAR
#define BOARD_ARRAYX(n) board_array_x[(n)][tid]
#define BOARD_ARRAYY(n) board_array_y[(n)][tid]
#define BOARD_ARRAYZ(n) board_array_z[(n)][tid]
#define BOARD_ARRAYW(n) board_array_w[(n)][tid]
#else
#define BOARD_ARRAYX(n) ((board_array_x[(n) / 4][tid] >> (((n) % 4) * 8)) & 0xff)
#define BOARD_ARRAYY(n) ((board_array_y[(n) / 4][tid] >> (((n) % 4) * 8)) & 0xff)
#define BOARD_ARRAYZ(n) ((board_array_z[(n) / 4][tid] >> (((n) % 4) * 8)) & 0xff)
#define BOARD_ARRAYW(n) ((board_array_w[(n) / 4][tid] >> (((n) % 4) * 8)) & 0xff)
#endif

#ifdef USE_VEC2

#ifdef USE_ATOMICS
__kernel __attribute__((reqd_work_group_size(WORK_ITEMS, 1,1))) void nqueen_vec(int board_size, int level, int threads, int pitch, __global uint2* params, __global uint2* results, __constant uint* forbidden_data, __global int* global_index)
#else
__kernel __attribute__((reqd_work_group_size(WORK_ITEMS, 1,1))) void nqueen_vec(int board_size, int level, int threads, int pitch, __global uint2* params, __global uint2* results, __constant uint* forbidden_data)
#endif
{
	int idx = get_global_id(0);
	int tid = get_local_id(0);

	uint2 ms;
	__local uint nsx[12][WORK_ITEMS];
	__local uint nsy[12][WORK_ITEMS];
	__local uint forbidden[12][32];

#ifdef ENABLE_CHAR
	__local char board_array_x[32][WORK_ITEMS];
	__local char board_array_y[32][WORK_ITEMS];
#else
	__local uint board_array_x[8][WORK_ITEMS];
	__local uint board_array_y[8][WORK_ITEMS];
#endif

	uint2 solutions = (uint2) 0;
	uint2 unique_solutions = (uint2) 0;
	int2 i = (int2) 0;
	int j;

	uint2 mask = params[idx];
	uint2 left_mask = params[idx + pitch];
	uint2 right_mask = params[idx + pitch * 2];
	uint2 index = params[idx + pitch * 3];
	uint2 board_mask = (uint2) ((1 << board_size) - 1);
	uint2 left_mask_big = (uint2) 0;
	uint2 right_mask_big = (uint2) 0;
	uint2 f;
	uint2 nsi, nsi_mask;

	results[idx + pitch * 2] = params[idx];	// for checking kernel exeuction completion

#ifdef ENABLE_CHAR
	for(j = 0; j < board_size - level; j++) {
		board_array_x[j][tid] = bit_scan(params[idx + pitch * (4 + j)].x);
		board_array_y[j][tid] = bit_scan(params[idx + pitch * (4 + j)].y);
	}
#else
	for(j = 0; j < 8; j++) {
		board_array_x[j][tid] = 0;
		board_array_y[j][tid] = 0;
	}

	for(j = 0; j < board_size - level; j++) {
		board_array_x[j / 4][tid] |= (bit_scan(params[idx + pitch * (4 + j)].x) << ((j % 4) * 8));
		board_array_y[j / 4][tid] |= (bit_scan(params[idx + pitch * (4 + j)].y) << ((j % 4) * 8));
	}
#endif

#ifdef FORCE_LOCAL
	if(tid < 32) {
		for(j = 0; j <= level; j++) {
			forbidden[j][tid] = forbidden_data[j];
		}
	}

	barrier(CLK_LOCAL_MEM_FENCE);
#endif

	ms = mask | left_mask | right_mask | (uint2) forbidden[0][tid % 32];
	nsi = ((ms + (uint2) 1) & ~ms);
	nsx[0][tid] = nsi.x;
	nsy[0][tid] = nsi.y;

	for(;;) {
		if(any(i >= (int2) 0)) {
			nsi.x = nsx[max(i.x, 0)][tid];
			nsi.y = nsy[max(i.y, 0)][tid];
			nsi_mask = convert_uint2((nsi & board_mask) != (uint2) 0) & convert_uint2(i >= (int2) 0);

			{
				// for nsi_mask == true...
				mask |= (nsi & nsi_mask);
				left_mask_big = select(left_mask_big, (left_mask_big << (uint2) 1) | (left_mask >> (uint2) 31), nsi_mask);
				left_mask = select(left_mask, (left_mask | nsi) << (uint2) 1, nsi_mask);
				right_mask_big = select(right_mask_big, (right_mask_big >> (uint2) 1) | (right_mask << (uint2) 31), nsi_mask);
				right_mask = select(right_mask, ((right_mask | nsi) >> (uint2) 1), nsi_mask);
				i = select(i, i + 1, convert_int2(nsi_mask));
				f.x = forbidden[i.x][tid % 32];
				f.y = forbidden[i.y][tid % 32];
				ms = mask | left_mask | right_mask | f;
				nsi = select(nsi, ((ms + (uint2) 1) & ~ms), nsi_mask);
				nsx[max(i.x, 0)][tid] = nsi.x;
				nsy[max(i.y, 0)][tid] = nsi.y;
			}

			{
				if(nsi_mask.x == 0 && i.x == level) {
					int repeat_times = 8;
					bool equal = true;

					bool rotate1 = (BOARDX(index.x) == (1 << (board_size - 1)));
					bool rotate2 = (BOARDX(board_size - index.x - 1) == 1);
					bool rotate3 = (nsx[level - 1][tid] == (1 << (board_size - index.x - 1)));

					if(rotate1 || rotate2 || rotate3) {
#ifdef ENABLE_CHAR
						for(j = 0; j < level; j++) {
							board_array_x[j + board_size - level][tid] = bit_scan(nsx[j][tid]);
						}
#else
						for(j = 0; j < level; j++) {
							board_array_x[(j + board_size - level) / 4][tid] &= ~(0xff << (((j + board_size - level) % 4) * 8));
							board_array_x[(j + board_size - level) / 4][tid] |= (bit_scan(nsx[j][tid]) << (((j + board_size - level) % 4) * 8));
						}
#endif

						int min_pos = board_size;
						int relation = 0;

						// rotate cw
						if(rotate1) {
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[board_size - BOARD_ARRAYX[j] - 1] = j;
	//						}
	//
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < BOARD_ARRAYX[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > BOARD_ARRAYX[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							relation = 0;
							for(j = 0; j < board_size; j++) {
#ifndef PREDICATED
								if(BOARD_ARRAYX(board_size - BOARD_ARRAYX(j) - 1) != j) {
									equal = false;
									if(min_pos > board_size - BOARD_ARRAYX(j) - 1) {
										relation = BOARD_ARRAYX(board_size - BOARD_ARRAYX(j) - 1) - j;
										min_pos = board_size - BOARD_ARRAYX(j) - 1;
									}
								}
#else
								int p = board_size - BOARD_ARRAYX(j) - 1;
								bool cond = (BOARD_ARRAYX(p) != j);
								equal = equal && !cond;
								cond = cond && (min_pos > p);
								relation = cond ? BOARD_ARRAYX(p) - j : relation;
								min_pos = cond ? p : min_pos;
#endif
							}

							repeat_times = equal ? 2 : repeat_times;
//							if(equal) {
//								repeat_times = 2;
//							}
						}

						if(relation >= 0 && rotate2) {
							// rotate ccw
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[BOARD_ARRAYX[j]] = (board_size - j - 1);
	//						}
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < BOARD_ARRAYX[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > BOARD_ARRAYX[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							min_pos = board_size;
							relation = 0;
							for(j = 0; j < board_size; j++) {
#ifndef PREDICATED
								if(BOARD_ARRAYX(BOARD_ARRAYX(j)) != board_size - j - 1) {
									equal = false;
									if(min_pos > BOARD_ARRAYX(j)) {
										relation = BOARD_ARRAYX(BOARD_ARRAYX(j)) - (board_size - j - 1);
										min_pos = BOARD_ARRAYX(j);
									}
								}
#else
								int p = BOARD_ARRAYX(j);
								bool cond = (BOARD_ARRAYX(p) != board_size - j - 1);
								equal = equal && !cond;
								cond = cond && (min_pos > p);
								relation = cond ? BOARD_ARRAYX(p) - (board_size - j - 1) : relation;
								min_pos = cond ? p : min_pos;
#endif
							}

							repeat_times = equal ? 2 : repeat_times;
//							if(equal) {
//								repeat_times = 2;
//							}
						}

						if(relation >= 0 && repeat_times == 8 && rotate3) {
							// rotate 180
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[board_size - j - 1] = (board_size - BOARD_ARRAYX[j] - 1);
	//						}
	//
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < BOARD_ARRAYX[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > BOARD_ARRAYX[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							min_pos = board_size;
							relation = 0;
							for(j = board_size - 1; j >= board_size / 2; j--) {
								if(BOARD_ARRAYX(board_size - j - 1) != board_size - BOARD_ARRAYX(j) - 1) {
									equal = false;
									relation = BOARD_ARRAYX(board_size - j - 1) - (board_size - BOARD_ARRAYX(j) - 1);
									break;
								}
//								int p = BOARD_ARRAYX(board_size - j - 1) - (board_size - BOARD_ARRAYX(j) - 1);
//								bool cond = (p != 0);
//								relation = (equal && cond) ? p : relation;
//								equal = equal && !cond;
							}
	//						for(j = 0; j < board_size; j++) {
	//							if(BOARD_ARRAYX(board_size - j - 1) != board_size - BOARD_ARRAYX(j) - 1) {
	//								equal = false;
	//								if(min_pos > board_size - j - 1) {
	//									relation = BOARD_ARRAYX(board_size - j - 1) - (board_size - BOARD_ARRAYX(j) - 1);
	//									min_pos = board_size - j - 1;
	//								}
	//							}
	//						}

							repeat_times = equal ? 4 : repeat_times;
//							if(equal) {
//								repeat_times = 4;
//							}
						}

						solutions.x += (relation >= 0) ? repeat_times : 0;
						unique_solutions.x += (relation >= 0) ? 1 : 0;
//						if(relation >= 0) {
//							solutions.x += repeat_times;
//							unique_solutions.x++;
//						}
					}
					else {
						solutions.x += 8;
						unique_solutions.x ++;
					}
				}

				if(nsi_mask.y == 0 && i.y == level) {
					int repeat_times = 8;
					bool equal = true;

					bool rotate1 = (BOARDY(index.y) == (1 << (board_size - 1)));
					bool rotate2 = (BOARDY(board_size - index.y - 1) == 1);
					bool rotate3 = (nsy[level - 1][tid] == (1 << (board_size - index.y - 1)));

					if(rotate1 || rotate2 || rotate3) {
#ifdef ENABLE_CHAR
						for(j = 0; j < level; j++) {
							board_array_y[j + board_size - level][tid] = bit_scan(nsy[j][tid]);
						}
#else
						for(j = 0; j < level; j++) {
							board_array_y[(j + board_size - level) / 4][tid] &= ~(0xff << (((j + board_size - level) % 4) * 8));
							board_array_y[(j + board_size - level) / 4][tid] |= (bit_scan(nsy[j][tid]) << (((j + board_size - level) % 4) * 8));
						}
#endif

						int min_pos = board_size;
						int relation = 0;

						// rotate cw
						if(rotate1) {
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[board_size - BOARD_ARRAYY[j] - 1] = j;
	//						}
	//
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < BOARD_ARRAYY[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > BOARD_ARRAYY[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							relation = 0;
							for(j = 0; j < board_size; j++) {
#ifndef PREDICATED
								if(BOARD_ARRAYY(board_size - BOARD_ARRAYY(j) - 1) != j) {
									equal = false;
									if(min_pos > board_size - BOARD_ARRAYY(j) - 1) {
										relation = BOARD_ARRAYY(board_size - BOARD_ARRAYY(j) - 1) - j;
										min_pos = board_size - BOARD_ARRAYY(j) - 1;
									}
								}
#else
								int p = board_size - BOARD_ARRAYY(j) - 1;
								bool cond = (BOARD_ARRAYY(p) != j);
								equal = equal && !cond;
								cond = cond && (min_pos > p);
								relation = cond ? BOARD_ARRAYY(p) - j : relation;
								min_pos = cond ? p : min_pos;
#endif
							}

							repeat_times = equal ? 2 : repeat_times;
//							if(equal) {
//								repeat_times = 2;
//							}
						}

						if(relation >= 0 && rotate2) {
							// rotate ccw
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[BOARD_ARRAYY[j]] = (board_size - j - 1);
	//						}
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < BOARD_ARRAYY[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > BOARD_ARRAYY[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							min_pos = board_size;
							relation = 0;
							for(j = 0; j < board_size; j++) {
#ifndef PREDICATED
								if(BOARD_ARRAYY(BOARD_ARRAYY(j)) != board_size - j - 1) {
									equal = false;
									if(min_pos > BOARD_ARRAYY(j)) {
										relation = BOARD_ARRAYY(BOARD_ARRAYY(j)) - (board_size - j - 1);
										min_pos = BOARD_ARRAYY(j);
									}
								}
#else
								int p = BOARD_ARRAYY(j);
								bool cond = (BOARD_ARRAYY(p) != board_size - j - 1);
								equal = equal && !cond;
								cond = cond && (min_pos > p);
								relation = cond ? BOARD_ARRAYY(p) - (board_size - j - 1) : relation;
								min_pos = cond ? p : min_pos;
#endif
							}

							repeat_times = equal ? 2 : repeat_times;
//							if(equal) {
//								repeat_times = 2;
//							}
						}

						if(relation >= 0 && repeat_times == 8 && rotate3) {
							// rotate 180
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[board_size - j - 1] = (board_size - BOARD_ARRAYY[j] - 1);
	//						}
	//
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < BOARD_ARRAYY[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > BOARD_ARRAYY[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							min_pos = board_size;
							relation = 0;
							for(j = board_size - 1; j >= board_size / 2; j--) {
								if(BOARD_ARRAYY(board_size - j - 1) != board_size - BOARD_ARRAYY(j) - 1) {
									equal = false;
									relation = BOARD_ARRAYY(board_size - j - 1) - (board_size - BOARD_ARRAYY(j) - 1);
									break;
								}
//								int p = BOARD_ARRAYY(board_size - j - 1) - (board_size - BOARD_ARRAYY(j) - 1);
//								bool cond = (p != 0);
//								relation = (equal && cond) ? p : relation;
//								equal = equal && !cond;
							}
	//						for(j = 0; j < board_size; j++) {
	//							if(BOARD_ARRAYY(board_size - j - 1) != board_size - BOARD_ARRAYY(j) - 1) {
	//								equal = false;
	//								if(min_pos > board_size - j - 1) {
	//									relation = BOARD_ARRAYY(board_size - j - 1) - (board_size - BOARD_ARRAYY(j) - 1);
	//									min_pos = board_size - j - 1;
	//								}
	//							}
	//						}

							repeat_times = equal ? 4 : repeat_times;
//							if(equal) {
//								repeat_times = 4;
//							}
						}

						solutions.x += (relation >= 0) ? repeat_times : 0;
						unique_solutions.x += (relation >= 0) ? 1 : 0;
//						if(relation >= 0) {
//							solutions.y += repeat_times;
//							unique_solutions.y++;
//						}
					}
					else {
						solutions.y += 8;
						unique_solutions.y ++;
					}
				}


				// for nsi_mask == false
				i = select(i - 1, i, convert_int2(nsi_mask));

				nsi.x = nsx[max(i.x, 0)][tid];
				nsi.y = nsy[max(i.y, 0)][tid];
				nsi_mask = ~nsi_mask & convert_uint2(i >= (int2) 0);

				// for i >= 0
				mask = select(mask, mask & ~nsi, nsi_mask);
				left_mask = select(left_mask, (((left_mask >> (uint2) 1) | (left_mask_big << (uint2) 31)) & ~nsi), nsi_mask);
				left_mask_big = select(left_mask_big, (left_mask_big >> (uint2) 1), nsi_mask);
				right_mask = select(right_mask, (((right_mask << (uint2) 1) | (right_mask_big >> (uint2) 31)) & ~nsi), nsi_mask);
				right_mask_big = select(right_mask_big, (right_mask_big << (uint2) 1), nsi_mask);
				f.x = forbidden[max(i.x, 0)][tid % 32];
				f.y = forbidden[max(i.y, 0)][tid % 32];
				ms = mask | left_mask | right_mask | nsi | f;
				nsi = select(nsi, ((ms + nsi) & ~ms), nsi_mask);

				nsx[max(i.x, 0)][tid] = nsi.x;
				nsy[max(i.y, 0)][tid] = nsi.y;
			}
		}
		else {
			results[idx] = solutions;
			results[idx + pitch] = unique_solutions;
			results[idx + pitch * 3] = params[idx];	// for checking kernel exeuction completion

#ifdef USE_ATOMICS
			idx = atom_inc(global_index);
			if(idx < threads) {
				solutions = (uint2) 0;
				unique_solutions = (uint2) 0;
				i = (int2) 0;

				mask = params[idx];
				left_mask = params[idx + pitch];
				right_mask = params[idx + pitch * 2];
				index = params[idx + pitch * 3];
				board_mask = (uint2) ((1 << board_size) - 1);
				left_mask_big = (uint2) 0;
				right_mask_big = (uint2) 0;

				results[idx + pitch * 2] = params[idx];	// for checking kernel exeuction completion

#ifdef ENABLE_CHAR
				for(j = 0; j < board_size - level; j++) {
					board_array_x[j][tid] = bit_scan(params[idx + pitch * (4 + j)].x);
					board_array_y[j][tid] = bit_scan(params[idx + pitch * (4 + j)].y);
				}
#else
				for(j = 0; j < 8; j++) {
					board_array_x[j][tid] = 0;
					board_array_y[j][tid] = 0;
				}

				for(j = 0; j < board_size - level; j++) {
					board_array_x[j / 4][tid] |= (bit_scan(params[idx + pitch * (4 + j)].x) << ((j % 4) * 8));
					board_array_y[j / 4][tid] |= (bit_scan(params[idx + pitch * (4 + j)].y) << ((j % 4) * 8));
				}
#endif

				ms = mask | left_mask | right_mask | (uint2) forbidden[0][tid % 32];
				nsi = ((ms + (uint2) 1) & ~ms);
				nsx[0][tid] = nsi.x;
				nsy[0][tid] = nsi.y;
			}
			else {
				break;
			}
#else
			break;
#endif
		}
	}
}

#else

#ifdef USE_ATOMICS
__kernel __attribute__((reqd_work_group_size(WORK_ITEMS, 1,1))) void nqueen_vec(int board_size, int level, int threads, int pitch, __global uint4* params, __global uint4* results, __constant uint* forbidden_data, __global int* global_index)
#else
__kernel __attribute__((reqd_work_group_size(WORK_ITEMS, 1,1))) void nqueen_vec(int board_size, int level, int threads, int pitch, __global uint4* params, __global uint4* results, __constant uint* forbidden_data)
#endif
{
	int idx = get_global_id(0);
	int tid = get_local_id(0);

	uint4 ms;
	__local uint nsx[12][WORK_ITEMS];
	__local uint nsy[12][WORK_ITEMS];
	__local uint nsz[12][WORK_ITEMS];
	__local uint nsw[12][WORK_ITEMS];
	__local uint forbidden[12][32];

#ifdef ENABLE_CHAR
	__local char board_array_x[32][WORK_ITEMS];
	__local char board_array_y[32][WORK_ITEMS];
	__local char board_array_z[32][WORK_ITEMS];
	__local char board_array_w[32][WORK_ITEMS];
#else
	__local uint board_array_x[8][WORK_ITEMS];
	__local uint board_array_y[8][WORK_ITEMS];
	__local uint board_array_z[8][WORK_ITEMS];
	__local uint board_array_w[8][WORK_ITEMS];
#endif

	uint4 solutions = (uint4) 0;
	uint4 unique_solutions = (uint4) 0;
	int4 i = (int4) 0;
	int j;

	uint4 mask = params[idx];
	uint4 left_mask = params[idx + pitch];
	uint4 right_mask = params[idx + pitch * 2];
	uint4 index = params[idx + pitch * 3];
	uint4 board_mask = (uint4) ((1 << board_size) - 1);
	uint4 left_mask_big = (uint4) 0;
	uint4 right_mask_big = (uint4) 0;
	uint4 f;
	uint4 nsi, nsi_mask;

	results[idx + pitch * 2] = params[idx];	// for checking kernel exeuction completion

#ifdef ENABLE_CHAR
	for(j = 0; j < board_size - level; j++) {
		board_array_x[j][tid] = bit_scan(params[idx + pitch * (4 + j)].x);
		board_array_y[j][tid] = bit_scan(params[idx + pitch * (4 + j)].y);
		board_array_z[j][tid] = bit_scan(params[idx + pitch * (4 + j)].z);
		board_array_w[j][tid] = bit_scan(params[idx + pitch * (4 + j)].w);
	}
#else
	for(j = 0; j < 8; j++) {
		board_array_x[j][tid] = 0;
		board_array_y[j][tid] = 0;
		board_array_z[j][tid] = 0;
		board_array_w[j][tid] = 0;
	}

	for(j = 0; j < board_size - level; j++) {
		board_array_x[j / 4][tid] |= (bit_scan(params[idx + pitch * (4 + j)].x) << ((j % 4) * 8));
		board_array_y[j / 4][tid] |= (bit_scan(params[idx + pitch * (4 + j)].y) << ((j % 4) * 8));
		board_array_z[j / 4][tid] |= (bit_scan(params[idx + pitch * (4 + j)].z) << ((j % 4) * 8));
		board_array_w[j / 4][tid] |= (bit_scan(params[idx + pitch * (4 + j)].w) << ((j % 4) * 8));
	}
#endif

#ifdef FORCE_LOCAL
	if(tid < 32) {
		for(j = 0; j <= level; j++) {
			forbidden[j][tid] = forbidden_data[j];
		}
	}

	barrier(CLK_LOCAL_MEM_FENCE);
#endif

	ms = mask | left_mask | right_mask | (uint4) forbidden[0][tid % 32];
	nsi = ((ms + (uint4) 1) & ~ms);
	nsx[0][tid] = nsi.x;
	nsy[0][tid] = nsi.y;
	nsz[0][tid] = nsi.z;
	nsw[0][tid] = nsi.w;

	for(;;) {
		if(any(i >= (int4) 0)) {
			nsi.x = nsx[max(i.x, 0)][tid];
			nsi.y = nsy[max(i.y, 0)][tid];
			nsi.z = nsz[max(i.z, 0)][tid];
			nsi.w = nsw[max(i.w, 0)][tid];
			nsi_mask = convert_uint4((nsi & board_mask) != (uint4) 0) & convert_uint4(i >= (int4) 0);

			{
				// for nsi_mask == true...
				mask |= (nsi & nsi_mask);
				left_mask_big = select(left_mask_big, (left_mask_big << (uint4) 1) | (left_mask >> (uint4) 31), nsi_mask);
				left_mask = select(left_mask, (left_mask | nsi) << (uint4) 1, nsi_mask);
				right_mask_big = select(right_mask_big, (right_mask_big >> (uint4) 1) | (right_mask << (uint4) 31), nsi_mask);
				right_mask = select(right_mask, ((right_mask | nsi) >> (uint4) 1), nsi_mask);
				i = select(i, i + 1, convert_int4(nsi_mask));
				f.x = forbidden[i.x][tid % 32];
				f.y = forbidden[i.y][tid % 32];
				f.z = forbidden[i.z][tid % 32];
				f.w = forbidden[i.w][tid % 32];
				ms = mask | left_mask | right_mask | f;
				nsi = select(nsi, ((ms + (uint4) 1) & ~ms), nsi_mask);
				nsx[max(i.x, 0)][tid] = nsi.x;
				nsy[max(i.y, 0)][tid] = nsi.y;
				nsz[max(i.z, 0)][tid] = nsi.z;
				nsw[max(i.w, 0)][tid] = nsi.w;
			}

			{

				if(nsi_mask.x == 0 && i.x == level) {
					int repeat_times = 8;
					bool equal = true;

					bool rotate1 = (BOARDX(index.x) == (1 << (board_size - 1)));
					bool rotate2 = (BOARDX(board_size - index.x - 1) == 1);
					bool rotate3 = (nsx[level - 1][tid] == (1 << (board_size - index.x - 1)));

					if(rotate1 || rotate2 || rotate3) {
#ifdef ENABLE_CHAR
						for(j = 0; j < level; j++) {
							board_array_x[j + board_size - level][tid] = bit_scan(nsx[j][tid]);
						}
#else
						for(j = 0; j < level; j++) {
							board_array_x[(j + board_size - level) / 4][tid] &= ~(0xff << (((j + board_size - level) % 4) * 8));
							board_array_x[(j + board_size - level) / 4][tid] |= (bit_scan(nsx[j][tid]) << (((j + board_size - level) % 4) * 8));
						}
#endif

						int min_pos = board_size;
						int relation = 0;

						// rotate cw
						if(rotate1) {
							equal = true;
							relation = 0;
							for(j = 0; j < board_size; j++) {
#ifndef PREDICATED
								if(BOARD_ARRAYX(board_size - BOARD_ARRAYX(j) - 1) != j) {
									equal = false;
									if(min_pos > board_size - BOARD_ARRAYX(j) - 1) {
										relation = BOARD_ARRAYX(board_size - BOARD_ARRAYX(j) - 1) - j;
										min_pos = board_size - BOARD_ARRAYX(j) - 1;
									}
								}
#else
								int p = board_size - BOARD_ARRAYX(j) - 1;
								bool cond = (BOARD_ARRAYX(p) != j);
								equal = equal && !cond;
								cond = cond && (min_pos > p);
								relation = cond ? BOARD_ARRAYX(p) - j : relation;
								min_pos = cond ? p : min_pos;
#endif
							}

							repeat_times = equal ? 2 : repeat_times;
//							if(equal) {
//								repeat_times = 2;
//							}
						}

						if(relation >= 0 && rotate2) {
							// rotate ccw
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[BOARD_ARRAYX[j]] = (board_size - j - 1);
	//						}
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < BOARD_ARRAYX[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > BOARD_ARRAYX[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							min_pos = board_size;
							relation = 0;
							for(j = 0; j < board_size; j++) {
#ifndef PREDICATED
								if(BOARD_ARRAYX(BOARD_ARRAYX(j)) != board_size - j - 1) {
									equal = false;
									if(min_pos > BOARD_ARRAYX(j)) {
										relation = BOARD_ARRAYX(BOARD_ARRAYX(j)) - (board_size - j - 1);
										min_pos = BOARD_ARRAYX(j);
									}
								}
#else
								int p = BOARD_ARRAYX(j);
								bool cond = (BOARD_ARRAYX(p) != board_size - j - 1);
								equal = equal && !cond;
								cond = cond && (min_pos > p);
								relation = cond ? BOARD_ARRAYX(p) - (board_size - j - 1) : relation;
								min_pos = cond ? p : min_pos;
#endif
							}

							repeat_times = equal ? 2 : repeat_times;
//							if(equal) {
//								repeat_times = 2;
//							}
						}

						if(relation >= 0 && repeat_times == 8 && rotate3) {
							// rotate 180
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[board_size - j - 1] = (board_size - BOARD_ARRAYX[j] - 1);
	//						}
	//
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < BOARD_ARRAYX[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > BOARD_ARRAYX[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							min_pos = board_size;
							relation = 0;
							for(j = board_size - 1; j >= board_size / 2; j--) {
								if(BOARD_ARRAYX(board_size - j - 1) != board_size - BOARD_ARRAYX(j) - 1) {
									equal = false;
									relation = BOARD_ARRAYX(board_size - j - 1) - (board_size - BOARD_ARRAYX(j) - 1);
									break;
								}
//								int p = BOARD_ARRAYX(board_size - j - 1) - (board_size - BOARD_ARRAYX(j) - 1);
//								bool cond = (p != 0);
//								relation = (equal && cond) ? p : relation;
//								equal = equal && !cond;
							}
	//						for(j = 0; j < board_size; j++) {
	//							if(BOARD_ARRAYX(board_size - j - 1) != board_size - BOARD_ARRAYX(j) - 1) {
	//								equal = false;
	//								if(min_pos > board_size - j - 1) {
	//									relation = BOARD_ARRAYX(board_size - j - 1) - (board_size - BOARD_ARRAYX(j) - 1);
	//									min_pos = board_size - j - 1;
	//								}
	//							}
	//						}

							repeat_times = equal ? 4 : repeat_times;
//							if(equal) {
//								repeat_times = 4;
//							}
						}

						solutions.x += (relation >= 0) ? repeat_times : 0;
						unique_solutions.x += (relation >= 0) ? 1 : 0;
//						if(relation >= 0) {
//							solutions.x += repeat_times;
//							unique_solutions.x++;
//						}
					}
					else {
						solutions.x += 8;
						unique_solutions.x ++;
					}
//					solutions += 8;
//					unique_solutions ++;
				}

				if(nsi_mask.y == 0 && i.y == level) {
					int repeat_times = 8;
					bool equal = true;

					bool rotate1 = (BOARDY(index.y) == (1 << (board_size - 1)));
					bool rotate2 = (BOARDY(board_size - index.y - 1) == 1);
					bool rotate3 = (nsy[level - 1][tid] == (1 << (board_size - index.y - 1)));

					if(rotate1 || rotate2 || rotate3) {
#ifdef ENABLE_CHAR
						for(j = 0; j < level; j++) {
							board_array_y[j + board_size - level][tid] = bit_scan(nsy[j][tid]);
						}
#else
						for(j = 0; j < level; j++) {
							board_array_y[(j + board_size - level) / 4][tid] &= ~(0xff << (((j + board_size - level) % 4) * 8));
							board_array_y[(j + board_size - level) / 4][tid] |= (bit_scan(nsy[j][tid]) << (((j + board_size - level) % 4) * 8));
						}
#endif

						int min_pos = board_size;
						int relation = 0;

						// rotate cw
						if(rotate1) {
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[board_size - BOARD_ARRAYY[j] - 1] = j;
	//						}
	//
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < BOARD_ARRAYY[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > BOARD_ARRAYY[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							relation = 0;
							for(j = 0; j < board_size; j++) {
#ifndef PREDICATED
								if(BOARD_ARRAYY(board_size - BOARD_ARRAYY(j) - 1) != j) {
									equal = false;
									if(min_pos > board_size - BOARD_ARRAYY(j) - 1) {
										relation = BOARD_ARRAYY(board_size - BOARD_ARRAYY(j) - 1) - j;
										min_pos = board_size - BOARD_ARRAYY(j) - 1;
									}
								}
#else
								int p = board_size - BOARD_ARRAYY(j) - 1;
								bool cond = (BOARD_ARRAYY(p) != j);
								equal = equal && !cond;
								cond = cond && (min_pos > p);
								relation = cond ? BOARD_ARRAYY(p) - j : relation;
								min_pos = cond ? p : min_pos;
#endif
							}

							repeat_times = equal ? 2 : repeat_times;
//							if(equal) {
//								repeat_times = 2;
//							}
						}

						if(relation >= 0 && rotate2) {
							// rotate ccw
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[BOARD_ARRAYY[j]] = (board_size - j - 1);
	//						}
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < BOARD_ARRAYY[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > BOARD_ARRAYY[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							min_pos = board_size;
							relation = 0;
							for(j = 0; j < board_size; j++) {
#ifndef PREDICATED
								if(BOARD_ARRAYY(BOARD_ARRAYY(j)) != board_size - j - 1) {
									equal = false;
									if(min_pos > BOARD_ARRAYY(j)) {
										relation = BOARD_ARRAYY(BOARD_ARRAYY(j)) - (board_size - j - 1);
										min_pos = BOARD_ARRAYY(j);
									}
								}
#else
								int p = BOARD_ARRAYY(j);
								bool cond = (BOARD_ARRAYY(p) != board_size - j - 1);
								equal = equal && !cond;
								cond = cond && (min_pos > p);
								relation = cond ? BOARD_ARRAYY(p) - (board_size - j - 1) : relation;
								min_pos = cond ? p : min_pos;
#endif
							}

							repeat_times = equal ? 2 : repeat_times;
//							if(equal) {
//								repeat_times = 2;
//							}
						}

						if(relation >= 0 && repeat_times == 8 && rotate3) {
							// rotate 180
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[board_size - j - 1] = (board_size - BOARD_ARRAYY[j] - 1);
	//						}
	//
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < BOARD_ARRAYY[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > BOARD_ARRAYY[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							min_pos = board_size;
							relation = 0;
							for(j = board_size - 1; j >= board_size / 2; j--) {
								if(BOARD_ARRAYY(board_size - j - 1) != board_size - BOARD_ARRAYY(j) - 1) {
									equal = false;
									relation = BOARD_ARRAYY(board_size - j - 1) - (board_size - BOARD_ARRAYY(j) - 1);
									break;
								}
//								int p = BOARD_ARRAYY(board_size - j - 1) - (board_size - BOARD_ARRAYY(j) - 1);
//								bool cond = (p != 0);
//								relation = (equal && cond) ? p : relation;
//								equal = equal && !cond;
							}
	//						for(j = 0; j < board_size; j++) {
	//							if(BOARD_ARRAYY(board_size - j - 1) != board_size - BOARD_ARRAYY(j) - 1) {
	//								equal = false;
	//								if(min_pos > board_size - j - 1) {
	//									relation = BOARD_ARRAYY(board_size - j - 1) - (board_size - BOARD_ARRAYY(j) - 1);
	//									min_pos = board_size - j - 1;
	//								}
	//							}
	//						}

							repeat_times = equal ? 4 : repeat_times;
//							if(equal) {
//								repeat_times = 4;
//							}
						}

						solutions.y += (relation >= 0) ? repeat_times : 0;
						unique_solutions.y += (relation >= 0) ? 1 : 0;
//						if(relation >= 0) {
//							solutions.y += repeat_times;
//							unique_solutions.y++;
//						}
					}
					else {
						solutions.y += 8;
						unique_solutions.y ++;
					}
//					solutions += 8;
//					unique_solutions ++;
				}

				if(nsi_mask.z == 0 && i.z == level) {
					int repeat_times = 8;
					bool equal = true;

					bool rotate1 = (BOARDZ(index.z) == (1 << (board_size - 1)));
					bool rotate2 = (BOARDZ(board_size - index.z - 1) == 1);
					bool rotate3 = (nsz[level - 1][tid] == (1 << (board_size - index.z - 1)));

					if(rotate1 || rotate2 || rotate3) {
#ifdef ENABLE_CHAR
						for(j = 0; j < level; j++) {
							board_array_z[j + board_size - level][tid] = bit_scan(nsz[j][tid]);
						}
#else

						for(j = 0; j < level; j++) {
							board_array_z[(j + board_size - level) / 4][tid] &= ~(0xff << (((j + board_size - level) % 4) * 8));
							board_array_z[(j + board_size - level) / 4][tid] |= (bit_scan(nsz[j][tid]) << (((j + board_size - level) % 4) * 8));
						}
#endif

						int min_pos = board_size;
						int relation = 0;

						// rotate cw
						if(rotate1) {
							equal = true;
							relation = 0;
							for(j = 0; j < board_size; j++) {
#ifndef PREDICATED
								if(BOARD_ARRAYZ(board_size - BOARD_ARRAYZ(j) - 1) != j) {
									equal = false;
									if(min_pos > board_size - BOARD_ARRAYZ(j) - 1) {
										relation = BOARD_ARRAYZ(board_size - BOARD_ARRAYZ(j) - 1) - j;
										min_pos = board_size - BOARD_ARRAYZ(j) - 1;
									}
								}
#else
								int p = board_size - BOARD_ARRAYZ(j) - 1;
								bool cond = (BOARD_ARRAYZ(p) != j);
								equal = equal && !cond;
								cond = cond && (min_pos > p);
								relation = cond ? BOARD_ARRAYZ(p) - j : relation;
								min_pos = cond ? p : min_pos;
#endif
							}

							repeat_times = equal ? 2 : repeat_times;
//							if(equal) {
//								repeat_times = 2;
//							}
						}

						if(relation >= 0 && rotate2) {
							// rotate ccw
							equal = true;
							min_pos = board_size;
							relation = 0;
							for(j = 0; j < board_size; j++) {
#ifndef PREDICATED
								if(BOARD_ARRAYZ(BOARD_ARRAYZ(j)) != board_size - j - 1) {
									equal = false;
									if(min_pos > BOARD_ARRAYZ(j)) {
										relation = BOARD_ARRAYZ(BOARD_ARRAYZ(j)) - (board_size - j - 1);
										min_pos = BOARD_ARRAYZ(j);
									}
								}
#else
								int p = BOARD_ARRAYZ(j);
								bool cond = (BOARD_ARRAYZ(p) != board_size - j - 1);
								equal = equal && !cond;
								cond = cond && (min_pos > p);
								relation = cond ? BOARD_ARRAYZ(p) - (board_size - j - 1) : relation;
								min_pos = cond ? p : min_pos;
#endif
							}

							repeat_times = equal ? 2 : repeat_times;
//							if(equal) {
//								repeat_times = 2;
//							}
						}

						if(relation >= 0 && repeat_times == 8 && rotate3) {
							// rotate 180
							equal = true;

							min_pos = board_size;
							relation = 0;
							for(j = board_size - 1; j >= board_size / 2; j--) {
								if(BOARD_ARRAYZ(board_size - j - 1) != board_size - BOARD_ARRAYZ(j) - 1) {
									equal = false;
									relation = BOARD_ARRAYZ(board_size - j - 1) - (board_size - BOARD_ARRAYZ(j) - 1);
									break;
								}
//								int p = BOARD_ARRAYZ(board_size - j - 1) - (board_size - BOARD_ARRAYZ(j) - 1);
//								bool cond = (p != 0);
//								relation = (equal && cond) ? p : relation;
//								equal = equal && !cond;
							}
	//						for(j = 0; j < board_size; j++) {
	//							if(BOARD_ARRAYZ(board_size - j - 1) != board_size - BOARD_ARRAYZ(j) - 1) {
	//								equal = false;
	//								if(min_pos > board_size - j - 1) {
	//									relation = BOARD_ARRAYZ(board_size - j - 1) - (board_size - BOARD_ARRAYZ(j) - 1);
	//									min_pos = board_size - j - 1;
	//								}
	//							}
	//						}

							repeat_times = equal ? 4 : repeat_times;
//							if(equal) {
//								repeat_times = 4;
//							}
						}

						solutions.z += (relation >= 0) ? repeat_times : 0;
						unique_solutions.z += (relation >= 0) ? 1 : 0;
//						if(relation >= 0) {
//							solutions.y += repeat_times;
//							unique_solutions.y++;
//						}
					}
					else {
						solutions.z += 8;
						unique_solutions.z ++;
					}
//					solutions += 8;
//					unique_solutions ++;
				}

				if(nsi_mask.w == 0 && i.w == level) {
					int repeat_times = 8;
					bool equal = true;

					bool rotate1 = (BOARDW(index.w) == (1 << (board_size - 1)));
					bool rotate2 = (BOARDW(board_size - index.w - 1) == 1);
					bool rotate3 = (nsw[level - 1][tid] == (1 << (board_size - index.w - 1)));

					if(rotate1 || rotate2 || rotate3) {
#ifdef ENABLE_CHAR
						for(j = 0; j < level; j++) {
							board_array_w[j + board_size - level][tid] = bit_scan(nsw[j][tid]);
						}
#else

						for(j = 0; j < level; j++) {
							board_array_w[(j + board_size - level) / 4][tid] &= ~(0xff << (((j + board_size - level) % 4) * 8));
							board_array_w[(j + board_size - level) / 4][tid] |= (bit_scan(nsw[j][tid]) << (((j + board_size - level) % 4) * 8));
						}
#endif

						int min_pos = board_size;
						int relation = 0;

						// rotate cw
						if(rotate1) {
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[board_size - BOARD_ARRAYW[j] - 1] = j;
	//						}
	//
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < BOARD_ARRAYW[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > BOARD_ARRAYW[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							relation = 0;
							for(j = 0; j < board_size; j++) {
#ifndef PREDICATED
								if(BOARD_ARRAYW(board_size - BOARD_ARRAYW(j) - 1) != j) {
									equal = false;
									if(min_pos > board_size - BOARD_ARRAYW(j) - 1) {
										relation = BOARD_ARRAYW(board_size - BOARD_ARRAYW(j) - 1) - j;
										min_pos = board_size - BOARD_ARRAYW(j) - 1;
									}
								}
#else
								int p = board_size - BOARD_ARRAYW(j) - 1;
								bool cond = (BOARD_ARRAYW(p) != j);
								equal = equal && !cond;
								cond = cond && (min_pos > p);
								relation = cond ? BOARD_ARRAYW(p) - j : relation;
								min_pos = cond ? p : min_pos;
#endif
							}

							repeat_times = equal ? 2 : repeat_times;
//							if(equal) {
//								repeat_times = 2;
//							}
						}

						if(relation >= 0 && rotate2) {
							// rotate ccw
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[BOARD_ARRAYW[j]] = (board_size - j - 1);
	//						}
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < BOARD_ARRAYW[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > BOARD_ARRAYW[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							min_pos = board_size;
							relation = 0;
							for(j = 0; j < board_size; j++) {
#ifndef PREDICATED
								if(BOARD_ARRAYW(BOARD_ARRAYW(j)) != board_size - j - 1) {
									equal = false;
									if(min_pos > BOARD_ARRAYW(j)) {
										relation = BOARD_ARRAYW(BOARD_ARRAYW(j)) - (board_size - j - 1);
										min_pos = BOARD_ARRAYW(j);
									}
								}
#else
								int p = BOARD_ARRAYW(j);
								bool cond = (BOARD_ARRAYW(p) != board_size - j - 1);
								equal = equal && !cond;
								cond = cond && (min_pos > p);
								relation = cond ? BOARD_ARRAYW(p) - (board_size - j - 1) : relation;
								min_pos = cond ? p : min_pos;
#endif
							}

							repeat_times = equal ? 2 : repeat_times;
//							if(equal) {
//								repeat_times = 2;
//							}
						}

						if(relation >= 0 && repeat_times == 8 && rotate3) {
							// rotate 180
							equal = true;
	//						for(j = 0; j < board_size; j++) {
	//							t_array[board_size - j - 1] = (board_size - BOARD_ARRAYW[j] - 1);
	//						}
	//
	//						for(j = 0; j < board_size; j++) {
	//							if(t_array[j] < BOARD_ARRAYW[j]) {
	//								repeat = true;
	//								equal = false;
	//								break;
	//							}
	//							else if(t_array[j] > BOARD_ARRAYW[j]) {
	//								equal = false;
	//								break;
	//							}
	//						}

							min_pos = board_size;
							relation = 0;
							for(j = board_size - 1; j >= board_size / 2; j--) {
								if(BOARD_ARRAYW(board_size - j - 1) != board_size - BOARD_ARRAYW(j) - 1) {
									equal = false;
									relation = BOARD_ARRAYW(board_size - j - 1) - (board_size - BOARD_ARRAYW(j) - 1);
									break;
								}
//								int p = BOARD_ARRAYW(board_size - j - 1) - (board_size - BOARD_ARRAYW(j) - 1);
//								bool cond = (p != 0);
//								relation = (equal && cond) ? p : relation;
//								equal = equal && !cond;
							}
	//						for(j = 0; j < board_size; j++) {
	//							if(BOARD_ARRAYW(board_size - j - 1) != board_size - BOARD_ARRAYW(j) - 1) {
	//								equal = false;
	//								if(min_pos > board_size - j - 1) {
	//									relation = BOARD_ARRAYW(board_size - j - 1) - (board_size - BOARD_ARRAYW(j) - 1);
	//									min_pos = board_size - j - 1;
	//								}
	//							}
	//						}

							repeat_times = equal ? 4 : repeat_times;
//							if(equal) {
//								repeat_times = 4;
//							}
						}

						solutions.w += (relation >= 0) ? repeat_times : 0;
						unique_solutions.w += (relation >= 0) ? 1 : 0;
//						if(relation >= 0) {
//							solutions.y += repeat_times;
//							unique_solutions.y++;
//						}
					}
					else {
						solutions.w += 8;
						unique_solutions.w ++;
					}
//					solutions += 8;
//					unique_solutions ++;
				}


				// for nsi_mask == false
				i = select(i - 1, i, convert_int4(nsi_mask));

				nsi.x = nsx[max(i.x, 0)][tid];
				nsi.y = nsy[max(i.y, 0)][tid];
				nsi.z = nsz[max(i.z, 0)][tid];
				nsi.w = nsw[max(i.w, 0)][tid];
				nsi_mask = ~nsi_mask & convert_uint4(i >= (int4) 0);

				// for i >= 0
				mask = select(mask, mask & ~nsi, nsi_mask);
				left_mask = select(left_mask, (((left_mask >> (uint4) 1) | (left_mask_big << (uint4) 31)) & ~nsi), nsi_mask);
				left_mask_big = select(left_mask_big, (left_mask_big >> (uint4) 1), nsi_mask);
				right_mask = select(right_mask, (((right_mask << (uint4) 1) | (right_mask_big >> (uint4) 31)) & ~nsi), nsi_mask);
				right_mask_big = select(right_mask_big, (right_mask_big << (uint4) 1), nsi_mask);
				f.x = forbidden[max(i.x, 0)][tid % 32];
				f.y = forbidden[max(i.y, 0)][tid % 32];
				f.z = forbidden[max(i.z, 0)][tid % 32];
				f.w = forbidden[max(i.w, 0)][tid % 32];
				ms = mask | left_mask | right_mask | nsi | f;
				nsi = select(nsi, ((ms + nsi) & ~ms), nsi_mask);

				nsx[max(i.x, 0)][tid] = nsi.x;
				nsy[max(i.y, 0)][tid] = nsi.y;
				nsz[max(i.z, 0)][tid] = nsi.z;
				nsw[max(i.w, 0)][tid] = nsi.w;
			}
		}
		else {
			results[idx] = solutions;
			results[idx + pitch] = unique_solutions;
			results[idx + pitch * 3] = params[idx];	// for checking kernel exeuction completion

#ifdef USE_ATOMICS
			idx = atom_inc(global_index);
			if(idx < threads) {
				solutions = (uint4) 0;
				unique_solutions = (uint4) 0;
				i = (int4) 0;

				mask = params[idx];
				left_mask = params[idx + pitch];
				right_mask = params[idx + pitch * 2];
				index = params[idx + pitch * 3];
				board_mask = (uint4) ((1 << board_size) - 1);
				left_mask_big = (uint4) 0;
				right_mask_big = (uint4) 0;

				results[idx + pitch * 2] = params[idx];	// for checking kernel exeuction completion

#ifdef ENABLE_CHAR
				for(j = 0; j < board_size - level; j++) {
					board_array_x[j][tid] = bit_scan(params[idx + pitch * (4 + j)].x);
					board_array_y[j][tid] = bit_scan(params[idx + pitch * (4 + j)].y);
					board_array_z[j][tid] = bit_scan(params[idx + pitch * (4 + j)].z);
					board_array_w[j][tid] = bit_scan(params[idx + pitch * (4 + j)].w);
				}
#else
				for(j = 0; j < 8; j++) {
					board_array_x[j][tid] = 0;
					board_array_y[j][tid] = 0;
					board_array_z[j][tid] = 0;
					board_array_w[j][tid] = 0;
				}

				for(j = 0; j < board_size - level; j++) {
					board_array_x[j / 4][tid] |= (bit_scan(params[idx + pitch * (4 + j)].x) << ((j % 4) * 8));
					board_array_y[j / 4][tid] |= (bit_scan(params[idx + pitch * (4 + j)].y) << ((j % 4) * 8));
					board_array_z[j / 4][tid] |= (bit_scan(params[idx + pitch * (4 + j)].z) << ((j % 4) * 8));
					board_array_w[j / 4][tid] |= (bit_scan(params[idx + pitch * (4 + j)].w) << ((j % 4) * 8));
				}
#endif

				ms = mask | left_mask | right_mask | (uint4) forbidden[0][tid % 32];
				nsi = ((ms + (uint4) 1) & ~ms);
				nsx[0][tid] = nsi.x;
				nsy[0][tid] = nsi.y;
				nsz[0][tid] = nsi.z;
				nsw[0][tid] = nsi.w;
			}
			else {
				break;
			}
#else
			break;
#endif
		}
	}
}

#endif

#endif

#endif


/*
__kernel void nqueen(int board_size, int level, int threads, __global uint* params, __global uint* results)
{
	int idx = get_global_id(0);
	uint mask = params[idx];
	uint left_mask = params[idx + threads];
	uint right_mask = params[idx + threads * 2];
	uint coeff = params[idx + threads * 3];
	uint board_mask = (1 << board_size) - 1;
	uint left_mask_big = 0;
	uint right_mask_big = 0;

	uint ms;
	uint ns[12];
	uint solutions = 0;
	int i = 0;

	ms = mask | left_mask | right_mask;
	ns[0] = ((ms + 1) & ~ms);

	while(i >= 0) {
		if((ns[i] & board_mask) != 0) {
			mask |= ns[i];
			left_mask_big = (left_mask_big << 1) | (left_mask >> 31);
			left_mask = (left_mask | ns[i]) << 1;
			right_mask_big = (right_mask_big >> 1) | (right_mask << 31);
			right_mask = (right_mask | ns[i]) >> 1;
			ms = mask | left_mask | right_mask;
			ns[i + 1] = ((ms + 1) & ~ms);
			i++;
		}
		else {
			if(i == level) {
				solutions++;
			}

			i--;
			if(i >= 0) {
				mask &= ~ns[i];
				left_mask = ((left_mask >> 1) | (left_mask_big << 31)) & ~ns[i];
				left_mask_big >>= 1;
				right_mask = ((right_mask << 1) | (right_mask_big >> 31)) & ~ns[i];
				right_mask_big <<= 1;
				ms = mask | left_mask | right_mask | ns[i];
				ns[i] = ((ms + ns[i]) & ~ms);
			}
		}
	}

	results[idx] = solutions * coeff;
}
*/



// buildOptions=-D WORK_ITEMS=256 -D FORCE_LOCAL -D USE_ATOMICS -D ENABLE_CHAR
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D WORK_ITEMS=256 -D FORCE_LOCAL -D USE_ATOMICS -D ENABLE_CHAR" %cfg_path --cl-device=%cl_device 2>&1
