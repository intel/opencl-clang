unsigned int combine_device(unsigned int M, unsigned int N)
{

   unsigned int P, I, N1, R;
   N1 = N;
   P = M - N1;
   if(N1 >= P) goto L10;
   P = N1;
   N1 = M - P;
L10:
   R = N1 + 1;
   if(P == 0) R = 1;
   if(P < 2) goto L30;
   for(I = 2; I <= P; I++)
   {
     R = (R * (N1 + I)) / I;
   }
L30:
   return R;
}


__kernel void combine_kernel(__global unsigned int* d_D1,__global unsigned int* d_D2,__global unsigned int* d_D3, __global unsigned int* d_D4, __global unsigned int* d_D5, __global unsigned int* d_D6,__global unsigned int* d_ST)
{


  int tid = get_global_id(0);

  if(tid < 134596)
  {

	unsigned int K, R, C[7],i;
	K = 0;
    C[1] = tid;
	for (unsigned int I = 1; I <= 5; I++)
	{
		C[I] = 0;
		if (I != 1)
		C[I] = C[I - 1];
L11:
		C[I] = C[I] + 1;
		R = combine_device(24 - C[I], 6 - I);
		K = K + R;
		if (K < tid) goto L11;
		K = K - R;
	}
	C[6] = C[5] + tid - K;



    unsigned int FirstFilter = 1;
	for(i = 1; i < 4000; i += 2)
    {
	 if(d_ST[i * 8 + 6] != 0)
	 {
	  unsigned int local40 = (d_ST[i * 8 + 6] * 8) + (FirstFilter - 1);
	  unsigned int local35 = FirstFilter;
	  while(local35 <= local40)
      {
        int local34 = 0;
		while(local34 <= 7)
	    {
         int ELM = local35 + local34;
		 if((d_D1[ELM] == C[1]) || (d_D2[ELM] == C[1]) || (d_D3[ELM] == C[1]) || (d_D4[ELM] == C[1]) || (d_D5[ELM] == C[1]) || (d_D6[ELM] == C[1]))
	     {
		   goto C2;
         }
         local34++;
	    }
		goto NextLoop;
C2:
        local34 = 0;
		while(local34 <= 7)
	    {
         int ELM = local35 + local34;
		 if((d_D1[ELM] == C[2]) || (d_D2[ELM] == C[2]) || (d_D3[ELM] == C[2]) || (d_D4[ELM] == C[2]) || (d_D5[ELM] == C[2]) || (d_D6[ELM] == C[2]))
	     {
		 goto C3;
         }
         local34++;
	    }
		goto NextLoop;
C3:
        local34 = 0;
		while(local34 <= 7)
	    {
         int ELM = local35 + local34;
		 if((d_D1[ELM] == C[3]) || (d_D2[ELM] == C[3]) || (d_D3[ELM] == C[3]) || (d_D4[ELM] == C[3]) || (d_D5[ELM] == C[3]) || (d_D6[ELM] == C[3]))
	     {
		   goto C4;
         }
         local34++;
	    }
		goto NextLoop;
C4:
        local34 = 0;
		while(local34 <= 7)
	    {
         int ELM = local35 + local34;
		 if((d_D1[ELM] == C[4]) || (d_D2[ELM] == C[4]) || (d_D3[ELM] == C[4]) || (d_D4[ELM] == C[4]) || (d_D5[ELM] == C[4]) || (d_D6[ELM] == C[4]))
	     {
		  goto C5;
         }
         local34++;
	    }
        goto NextLoop;
C5:
        local34 = 0;
		while(local34 <= 7)
	    {
         int ELM = local35 + local34;
		 if((d_D1[ELM] == C[5]) || (d_D2[ELM] == C[5]) || (d_D3[ELM] == C[5]) || (d_D4[ELM] == C[5]) || (d_D5[ELM] == C[5]) || (d_D6[ELM] == C[5]))
	     {
		  goto C6;
         }
         local34++;
	    }
        goto NextLoop;
C6:
        local34 = 0;
		while(local34 <= 7)
	    {
         int ELM = local35 + local34;
		 if((d_D1[ELM] == C[6]) || (d_D2[ELM] == C[6]) || (d_D3[ELM] == C[6]) || (d_D4[ELM] == C[6]) || (d_D5[ELM] == C[6]) || (d_D6[ELM] == C[6]))
	     {
		   return;
         }
         local34++;
	    }
NextLoop:
        local35 += 8;
      }
     }
     FirstFilter += 59;
    }


    }
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
