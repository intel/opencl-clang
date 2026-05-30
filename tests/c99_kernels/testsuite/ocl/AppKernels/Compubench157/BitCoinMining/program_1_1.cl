/**
    Copyright (C) 2010  puddinpop

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
**/

#ifdef AMDMEDIAOPS
#pragma OPENCL EXTENSION cl_amd_media_ops : enable
#define rotateright(x,bits) amd_bitalign(x,x,bits)
#else
#define rotateright(x,bits) (rotate(x,(uint)(32-bits)))
#endif

#ifdef WORKGROUPSIZE
#define WORKGROUP __attribute__((reqd_work_group_size(WORKGROUPSIZE, 1, 1)))
#else
#define WORKGROUP
#endif

//__constant uint f1=0xFF000000;
//__constant uint f2=0x00FF0000;
//__constant uint f3=0x0000FF00;
//__constant uint f4=0x000000FF;
__constant uint f5=0xFFFFFFFF;

//#define byteswap(x) (((x>>24) & f4) | ((x>>8) & f3) | ((x<<8) & f2) | ((x<<24) & f1))
#define R(x) (work[x] = (rotateright(work[x-2],17)^rotateright(work[x-2],19)^((work[x-2]&f5)>>10)) + work[x -  7] + (rotateright(work[x-15],7)^rotateright(work[x-15],18)^((work[x-15]&f5)>>3)) + work[x - 16])
#define sharound(a,b,c,d,e,f,g,h,x,K) {t1=h+(rotateright(e,6)^rotateright(e,11)^rotateright(e,25))+(g^(e&(f^g)))+K+x; t2=(rotateright(a,2)^rotateright(a,13)^rotateright(a,22))+((a&b)|(c&(a|b))); d+=t1; h=t1+t2;}

__kernel void opencl_process(const uint m_AH0, const uint m_AH1, const uint m_AH2, const uint m_AH3, const uint m_AH4, const uint m_AH5, const uint m_AH6, const uint m_AH7, const uint m_merkle, const uint m_ntime, const uint m_nbits, const uint m_nonce, __global uint *m_bestnonce, const uint loops, const uint bits)
{

    uint work[64];
    uint A,B,C,D,E,F,G,H;
	const uint myid=get_global_id(0);
	const uint nonce=m_nonce + (myid << bits);
	uint t1,t2;
	uint bestnonce=0;
	//uint bestg=~0;

	// the first 3 rounds we can do outside the loop because they depend on work[0] through work[2] which won't change
	uint A1,B1,C1,D1,E1,F1,G1,H1;
	A1=m_AH0;
	B1=m_AH1;
	C1=m_AH2;
	D1=m_AH3;
	E1=m_AH4;
	F1=m_AH5;
	G1=m_AH6;
	H1=m_AH7;
	sharound(A1,B1,C1,D1,E1,F1,G1,H1,m_merkle,0x428A2F98);
	sharound(H1,A1,B1,C1,D1,E1,F1,G1,m_ntime,0x71374491);
	sharound(G1,H1,A1,B1,C1,D1,E1,F1,m_nbits,0xB5C0FBCF);

    #pragma unroll 1
	for(uint it=0; it<loops; it++)
	{
		A=A1;
		B=B1;
		C=C1;
		D=D1;
		E=E1;
		F=F1;
		G=G1;
		H=H1;

		work[0]=m_merkle;
		work[1]=m_ntime;
		work[2]=m_nbits;
		work[3]=nonce+it;
		work[4]=0x80000000;
		work[5]=0x00000000;
		work[6]=0x00000000;
		work[7]=0x00000000;
		work[8]=0x00000000;
		work[9]=0x00000000;
		work[10]=0x00000000;
		work[11]=0x00000000;
		work[12]=0x00000000;
		work[13]=0x00000000;
		work[14]=0x00000000;
		work[15]=0x00000280;

		//sharound(A,B,C,D,E,F,G,H,work[0],0x428A2F98);
		//sharound(H,A,B,C,D,E,F,G,work[1],0x71374491);
		//sharound(G,H,A,B,C,D,E,F,work[2],0xB5C0FBCF);
		sharound(F,G,H,A,B,C,D,E,work[3],0xE9B5DBA5);
		sharound(E,F,G,H,A,B,C,D,work[4],0x3956C25B);
		sharound(D,E,F,G,H,A,B,C,work[5],0x59F111F1);
		sharound(C,D,E,F,G,H,A,B,work[6],0x923F82A4);
		sharound(B,C,D,E,F,G,H,A,work[7],0xAB1C5ED5);
		sharound(A,B,C,D,E,F,G,H,work[8],0xD807AA98);
		sharound(H,A,B,C,D,E,F,G,work[9],0x12835B01);
		sharound(G,H,A,B,C,D,E,F,work[10],0x243185BE);
		sharound(F,G,H,A,B,C,D,E,work[11],0x550C7DC3);
		sharound(E,F,G,H,A,B,C,D,work[12],0x72BE5D74);
		sharound(D,E,F,G,H,A,B,C,work[13],0x80DEB1FE);
		sharound(C,D,E,F,G,H,A,B,work[14],0x9BDC06A7);
		sharound(B,C,D,E,F,G,H,A,work[15],0xC19BF174);
		sharound(A,B,C,D,E,F,G,H,R(16),0xE49B69C1);
		sharound(H,A,B,C,D,E,F,G,R(17),0xEFBE4786);
		sharound(G,H,A,B,C,D,E,F,R(18),0x0FC19DC6);
		sharound(F,G,H,A,B,C,D,E,R(19),0x240CA1CC);
		sharound(E,F,G,H,A,B,C,D,R(20),0x2DE92C6F);
		sharound(D,E,F,G,H,A,B,C,R(21),0x4A7484AA);
		sharound(C,D,E,F,G,H,A,B,R(22),0x5CB0A9DC);
		sharound(B,C,D,E,F,G,H,A,R(23),0x76F988DA);
		sharound(A,B,C,D,E,F,G,H,R(24),0x983E5152);
		sharound(H,A,B,C,D,E,F,G,R(25),0xA831C66D);
		sharound(G,H,A,B,C,D,E,F,R(26),0xB00327C8);
		sharound(F,G,H,A,B,C,D,E,R(27),0xBF597FC7);
		sharound(E,F,G,H,A,B,C,D,R(28),0xC6E00BF3);
		sharound(D,E,F,G,H,A,B,C,R(29),0xD5A79147);
		sharound(C,D,E,F,G,H,A,B,R(30),0x06CA6351);
		sharound(B,C,D,E,F,G,H,A,R(31),0x14292967);
		sharound(A,B,C,D,E,F,G,H,R(32),0x27B70A85);
		sharound(H,A,B,C,D,E,F,G,R(33),0x2E1B2138);
		sharound(G,H,A,B,C,D,E,F,R(34),0x4D2C6DFC);
		sharound(F,G,H,A,B,C,D,E,R(35),0x53380D13);
		sharound(E,F,G,H,A,B,C,D,R(36),0x650A7354);
		sharound(D,E,F,G,H,A,B,C,R(37),0x766A0ABB);
		sharound(C,D,E,F,G,H,A,B,R(38),0x81C2C92E);
		sharound(B,C,D,E,F,G,H,A,R(39),0x92722C85);
		sharound(A,B,C,D,E,F,G,H,R(40),0xA2BFE8A1);
		sharound(H,A,B,C,D,E,F,G,R(41),0xA81A664B);
		sharound(G,H,A,B,C,D,E,F,R(42),0xC24B8B70);
		sharound(F,G,H,A,B,C,D,E,R(43),0xC76C51A3);
		sharound(E,F,G,H,A,B,C,D,R(44),0xD192E819);
		sharound(D,E,F,G,H,A,B,C,R(45),0xD6990624);
		sharound(C,D,E,F,G,H,A,B,R(46),0xF40E3585);
		sharound(B,C,D,E,F,G,H,A,R(47),0x106AA070);
		sharound(A,B,C,D,E,F,G,H,R(48),0x19A4C116);
		sharound(H,A,B,C,D,E,F,G,R(49),0x1E376C08);
		sharound(G,H,A,B,C,D,E,F,R(50),0x2748774C);
		sharound(F,G,H,A,B,C,D,E,R(51),0x34B0BCB5);
		sharound(E,F,G,H,A,B,C,D,R(52),0x391C0CB3);
		sharound(D,E,F,G,H,A,B,C,R(53),0x4ED8AA4A);
		sharound(C,D,E,F,G,H,A,B,R(54),0x5B9CCA4F);
		sharound(B,C,D,E,F,G,H,A,R(55),0x682E6FF3);
		sharound(A,B,C,D,E,F,G,H,R(56),0x748F82EE);
		sharound(H,A,B,C,D,E,F,G,R(57),0x78A5636F);
		sharound(G,H,A,B,C,D,E,F,R(58),0x84C87814);
		sharound(F,G,H,A,B,C,D,E,R(59),0x8CC70208);
		sharound(E,F,G,H,A,B,C,D,R(60),0x90BEFFFA);
		sharound(D,E,F,G,H,A,B,C,R(61),0xA4506CEB);
		sharound(C,D,E,F,G,H,A,B,R(62),0xBEF9A3F7);
		sharound(B,C,D,E,F,G,H,A,R(63),0xC67178F2);

		// hash the hash now

		work[0]=m_AH0+A;
		work[1]=m_AH1+B;
		work[2]=m_AH2+C;
		work[3]=m_AH3+D;
		work[4]=m_AH4+E;
		work[5]=m_AH5+F;
		work[6]=m_AH6+G;
		work[7]=m_AH7+H;
		work[8]=0x80000000;
		work[9]=0x00000000;
		work[10]=0x00000000;
		work[11]=0x00000000;
		work[12]=0x00000000;
		work[13]=0x00000000;
		work[14]=0x00000000;
		work[15]=0x00000100;

		A=0x6a09e667;
		B=0xbb67ae85;
		C=0x3c6ef372;
		D=0xa54ff53a;
		E=0x510e527f;
		F=0x9b05688c;
		G=0x1f83d9ab;
		H=0x5be0cd19;

		sharound(A,B,C,D,E,F,G,H,work[0],0x428A2F98);
		sharound(H,A,B,C,D,E,F,G,work[1],0x71374491);
		sharound(G,H,A,B,C,D,E,F,work[2],0xB5C0FBCF);
		sharound(F,G,H,A,B,C,D,E,work[3],0xE9B5DBA5);
		sharound(E,F,G,H,A,B,C,D,work[4],0x3956C25B);
		sharound(D,E,F,G,H,A,B,C,work[5],0x59F111F1);
		sharound(C,D,E,F,G,H,A,B,work[6],0x923F82A4);
		sharound(B,C,D,E,F,G,H,A,work[7],0xAB1C5ED5);
		sharound(A,B,C,D,E,F,G,H,work[8],0xD807AA98);
		sharound(H,A,B,C,D,E,F,G,work[9],0x12835B01);
		sharound(G,H,A,B,C,D,E,F,work[10],0x243185BE);
		sharound(F,G,H,A,B,C,D,E,work[11],0x550C7DC3);
		sharound(E,F,G,H,A,B,C,D,work[12],0x72BE5D74);
		sharound(D,E,F,G,H,A,B,C,work[13],0x80DEB1FE);
		sharound(C,D,E,F,G,H,A,B,work[14],0x9BDC06A7);
		sharound(B,C,D,E,F,G,H,A,work[15],0xC19BF174);
		sharound(A,B,C,D,E,F,G,H,R(16),0xE49B69C1);
		sharound(H,A,B,C,D,E,F,G,R(17),0xEFBE4786);
		sharound(G,H,A,B,C,D,E,F,R(18),0x0FC19DC6);
		sharound(F,G,H,A,B,C,D,E,R(19),0x240CA1CC);
		sharound(E,F,G,H,A,B,C,D,R(20),0x2DE92C6F);
		sharound(D,E,F,G,H,A,B,C,R(21),0x4A7484AA);
		sharound(C,D,E,F,G,H,A,B,R(22),0x5CB0A9DC);
		sharound(B,C,D,E,F,G,H,A,R(23),0x76F988DA);
		sharound(A,B,C,D,E,F,G,H,R(24),0x983E5152);
		sharound(H,A,B,C,D,E,F,G,R(25),0xA831C66D);
		sharound(G,H,A,B,C,D,E,F,R(26),0xB00327C8);
		sharound(F,G,H,A,B,C,D,E,R(27),0xBF597FC7);
		sharound(E,F,G,H,A,B,C,D,R(28),0xC6E00BF3);
		sharound(D,E,F,G,H,A,B,C,R(29),0xD5A79147);
		sharound(C,D,E,F,G,H,A,B,R(30),0x06CA6351);
		sharound(B,C,D,E,F,G,H,A,R(31),0x14292967);
		sharound(A,B,C,D,E,F,G,H,R(32),0x27B70A85);
		sharound(H,A,B,C,D,E,F,G,R(33),0x2E1B2138);
		sharound(G,H,A,B,C,D,E,F,R(34),0x4D2C6DFC);
		sharound(F,G,H,A,B,C,D,E,R(35),0x53380D13);
		sharound(E,F,G,H,A,B,C,D,R(36),0x650A7354);
		sharound(D,E,F,G,H,A,B,C,R(37),0x766A0ABB);
		sharound(C,D,E,F,G,H,A,B,R(38),0x81C2C92E);
		sharound(B,C,D,E,F,G,H,A,R(39),0x92722C85);
		sharound(A,B,C,D,E,F,G,H,R(40),0xA2BFE8A1);
		sharound(H,A,B,C,D,E,F,G,R(41),0xA81A664B);
		sharound(G,H,A,B,C,D,E,F,R(42),0xC24B8B70);
		sharound(F,G,H,A,B,C,D,E,R(43),0xC76C51A3);
		sharound(E,F,G,H,A,B,C,D,R(44),0xD192E819);
		sharound(D,E,F,G,H,A,B,C,R(45),0xD6990624);
		sharound(C,D,E,F,G,H,A,B,R(46),0xF40E3585);
		sharound(B,C,D,E,F,G,H,A,R(47),0x106AA070);
		sharound(A,B,C,D,E,F,G,H,R(48),0x19A4C116);
		sharound(H,A,B,C,D,E,F,G,R(49),0x1E376C08);
		sharound(G,H,A,B,C,D,E,F,R(50),0x2748774C);
		sharound(F,G,H,A,B,C,D,E,R(51),0x34B0BCB5);
		sharound(E,F,G,H,A,B,C,D,R(52),0x391C0CB3);
		sharound(D,E,F,G,H,A,B,C,R(53),0x4ED8AA4A);
		sharound(C,D,E,F,G,H,A,B,R(54),0x5B9CCA4F);
		sharound(B,C,D,E,F,G,H,A,R(55),0x682E6FF3);
		sharound(A,B,C,D,E,F,G,H,R(56),0x748F82EE);
		sharound(H,A,B,C,D,E,F,G,R(57),0x78A5636F);
		sharound(G,H,A,B,C,D,E,F,R(58),0x84C87814);
		sharound(F,G,H,A,B,C,D,E,R(59),0x8CC70208);
		sharound(E,F,G,H,A,B,C,D,R(60),0x90BEFFFA);
		sharound(D,E,F,G,H,A,B,C,R(61),0xA4506CEB);
		//we don't need to do these last 2 rounds as they update F, B, E and A, but we only care about G and H
		//sharound(C,D,E,F,G,H,A,B,R(62),0xBEF9A3F7);
		//sharound(B,C,D,E,F,G,H,A,R(63),0xC67178F2);

		//G+=0x1f83d9ab;
		//G=byteswap(G);
		H+=0x5be0cd19;

		if((H==0))// && (G<=bestg))
		{
			bestnonce=nonce+it;
			//bestg=G;
			//out[0].m_bestnonce=nonce+it;
		}

    }

    m_bestnonce[myid]=bestnonce;
    //out[myid].m_bestg=bestg;

}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
