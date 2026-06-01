// INTEL CONFIDENTIAL
// ***************************************************************************
// Copyright (c) Intel Corporation (2014).
//
// INTEL MAKES NO WARRANTY OF ANY KIND REGARDING THE CODE.  THIS CODE
// IS LICENSED ON AN "AS IS" BASIS AND INTEL WILL NOT PROVIDE ANY
// SUPPORT, ASSISTANCE, INSTALLATION, TRAINING OR OTHER SERVICES.
// INTEL DOES NOT PROVIDE ANY UPDATES, ENHANCEMENTS OR EXTENSIONS.
// INTEL SPECIFICALLY DISCLAIMS ANY WARRANTY OF MERCHANTABILITY,
// NONINFRINGEMENT, FITNESS FOR ANY PARTICULAR PURPOSE, OR ANY OTHER
// WARRANTY.  Intel disclaims all liability, including liability for
// infringement of any proprietary rights, relating to use of the
// code. No license, express or implied, by estoppel or otherwise, to
// any intellectual property rights is granted herein.

int main_function_ocl(int argc, char **argv, __global int *ocl_test_results) {

    uchar2 a0 = (uchar2) (204,58);
    uchar2 swizc0 = a0.s00;

    // results validation
    if (!((swizc0.x == 204) && (swizc0.y == 204)))
        return -1;

    uchar3 e0 = (uchar3) (183,232,39);
    uchar3 swize0 = e0.s112;

    // results validation
    if (!((swize0.x == 232) && (swize0.y == 232) && (swize0.z == 39)))
        return -1;

    uchar4 b0 = (uchar4) (196,65,159,229);
    uchar4 swizb0 = b0.s2013;

    // results validation
    if (!((swizb0.x == 159) && (swizb0.y == 196) && (swizb0.z == 65) && (swizb0.w == 229)))
        return -1;

    uchar8 c0 = (uchar8) (149,61,199,128,108,66,102,103);
    uchar8 swiza0 = c0.s41665442;

    // results validation
    if (!((swiza0.s0 == 108) && (swiza0.s1 == 61) && (swiza0.s2 == 102) && (swiza0.s3 == 102) && (swiza0.s4 == 66) && (swiza0.s5 == 108) && (swiza0.s6 == 108) && (swiza0.s7 == 199)))
        return -1;

    uchar16 d0 = (uchar16) (234,92,163,87,135,117,39,182,194,228,135,161,8,117,182,249);
    uchar16 swiz0 = d0.s8699803608969333;

    // results validation
    if (!((swiz0.s0 == 194) && (swiz0.s1 == 39) && (swiz0.s2 == 228) && (swiz0.s3 == 228) && (swiz0.s4 == 194) && (swiz0.s5 == 234) && (swiz0.s6 == 87) && (swiz0.s7 == 39) && (swiz0.s8 == 234) && (swiz0.s9 == 194) && (swiz0.sA == 228) && (swiz0.sB == 39) && (swiz0.sC == 228) && (swiz0.sD == 87) && (swiz0.sE == 87) && (swiz0.sF == 87)))
        return -1;

    uchar2 a1 = (uchar2) (2,184);
    uchar2 swizc1 = a1.s10;

    // results validation
    if (!((swizc1.x == 184) && (swizc1.y == 2)))
        return -1;

    uchar3 e1 = (uchar3) (47,121,246);
    uchar3 swize1 = e1.s021;

    // results validation
    if (!((swize1.x == 47) && (swize1.y == 246) && (swize1.z == 121)))
        return -1;

    uchar4 b1 = (uchar4) (88,58,147,206);
    uchar4 swizb1 = b1.s3110;

    // results validation
    if (!((swizb1.x == 206) && (swizb1.y == 58) && (swizb1.z == 58) && (swizb1.w == 88)))
        return -1;

    uchar8 c1 = (uchar8) (192,107,186,32,129,242,239,234);
    uchar8 swiza1 = c1.s50746776;

    // results validation
    if (!((swiza1.s0 == 242) && (swiza1.s1 == 192) && (swiza1.s2 == 234) && (swiza1.s3 == 129) && (swiza1.s4 == 239) && (swiza1.s5 == 234) && (swiza1.s6 == 234) && (swiza1.s7 == 239)))
        return -1;

    uchar16 d1 = (uchar16) (123,216,220,122,191,235,146,156,32,57,14,44,62,55,193,114);
    uchar16 swiz1 = d1.s1299114147035999;

    // results validation
    if (!((swiz1.s0 == 216) && (swiz1.s1 == 220) && (swiz1.s2 == 57) && (swiz1.s3 == 57) && (swiz1.s4 == 216) && (swiz1.s5 == 216) && (swiz1.s6 == 191) && (swiz1.s7 == 216) && (swiz1.s8 == 191) && (swiz1.s9 == 156) && (swiz1.sA == 123) && (swiz1.sB == 122) && (swiz1.sC == 235) && (swiz1.sD == 57) && (swiz1.sE == 57) && (swiz1.sF == 57)))
        return -1;

    uchar2 a2 = (uchar2) (201,131);
    uchar2 swizc2 = a2.s10;

    // results validation
    if (!((swizc2.x == 131) && (swizc2.y == 201)))
        return -1;

    uchar3 e2 = (uchar3) (36,62,0);
    uchar3 swize2 = e2.s122;

    // results validation
    if (!((swize2.x == 62) && (swize2.y == 0) && (swize2.z == 0)))
        return -1;

    uchar4 b2 = (uchar4) (166,94,3,222);
    uchar4 swizb2 = b2.s2120;

    // results validation
    if (!((swizb2.x == 3) && (swizb2.y == 94) && (swizb2.z == 3) && (swizb2.w == 166)))
        return -1;

    uchar8 c2 = (uchar8) (96,97,254,10,155,37,220,155);
    uchar8 swiza2 = c2.s55063057;

    // results validation
    if (!((swiza2.s0 == 37) && (swiza2.s1 == 37) && (swiza2.s2 == 96) && (swiza2.s3 == 220) && (swiza2.s4 == 10) && (swiza2.s5 == 96) && (swiza2.s6 == 37) && (swiza2.s7 == 155)))
        return -1;

    uchar16 d2 = (uchar16) (181,156,40,216,83,78,48,178,204,1,194,148,26,234,132,128);
    uchar16 swiz2 = d2.s8049644156436937;

    // results validation
    if (!((swiz2.s0 == 204) && (swiz2.s1 == 181) && (swiz2.s2 == 83) && (swiz2.s3 == 1) && (swiz2.s4 == 48) && (swiz2.s5 == 83) && (swiz2.s6 == 83) && (swiz2.s7 == 156) && (swiz2.s8 == 78) && (swiz2.s9 == 48) && (swiz2.sA == 83) && (swiz2.sB == 216) && (swiz2.sC == 48) && (swiz2.sD == 1) && (swiz2.sE == 216) && (swiz2.sF == 178)))
        return -1;

    uchar2 a3 = (uchar2) (90,75);
    uchar2 swizc3 = a3.s10;

    // results validation
    if (!((swizc3.x == 75) && (swizc3.y == 90)))
        return -1;

    uchar3 e3 = (uchar3) (86,46,80);
    uchar3 swize3 = e3.s111;

    // results validation
    if (!((swize3.x == 46) && (swize3.y == 46) && (swize3.z == 46)))
        return -1;

    uchar4 b3 = (uchar4) (11,193,177,6);
    uchar4 swizb3 = b3.s1333;

    // results validation
    if (!((swizb3.x == 193) && (swizb3.y == 6) && (swizb3.z == 6) && (swizb3.w == 6)))
        return -1;

    uchar8 c3 = (uchar8) (252,174,123,242,132,130,175,129);
    uchar8 swiza3 = c3.s40610617;

    // results validation
    if (!((swiza3.s0 == 132) && (swiza3.s1 == 252) && (swiza3.s2 == 175) && (swiza3.s3 == 174) && (swiza3.s4 == 252) && (swiza3.s5 == 175) && (swiza3.s6 == 174) && (swiza3.s7 == 129)))
        return -1;

    uchar16 d3 = (uchar16) (40,183,59,195,108,192,203,169,134,209,220,60,221,33,8,147);
    uchar16 swiz3 = d3.s9672360558962135;

    // results validation
    if (!((swiz3.s0 == 209) && (swiz3.s1 == 203) && (swiz3.s2 == 169) && (swiz3.s3 == 59) && (swiz3.s4 == 195) && (swiz3.s5 == 203) && (swiz3.s6 == 40) && (swiz3.s7 == 192) && (swiz3.s8 == 192) && (swiz3.s9 == 134) && (swiz3.sA == 209) && (swiz3.sB == 203) && (swiz3.sC == 59) && (swiz3.sD == 183) && (swiz3.sE == 195) && (swiz3.sF == 192)))
        return -1;

    uchar2 a4 = (uchar2) (20,134);
    uchar2 swizc4 = a4.s10;

    // results validation
    if (!((swizc4.x == 134) && (swizc4.y == 20)))
        return -1;

    uchar3 e4 = (uchar3) (158,24,223);
    uchar3 swize4 = e4.s212;

    // results validation
    if (!((swize4.x == 223) && (swize4.y == 24) && (swize4.z == 223)))
        return -1;

    uchar4 b4 = (uchar4) (218,151,90,248);
    uchar4 swizb4 = b4.s2233;

    // results validation
    if (!((swizb4.x == 90) && (swizb4.y == 90) && (swizb4.z == 248) && (swizb4.w == 248)))
        return -1;

    uchar8 c4 = (uchar8) (105,97,119,218,148,192,77,164);
    uchar8 swiza4 = c4.s37677526;

    // results validation
    if (!((swiza4.s0 == 218) && (swiza4.s1 == 164) && (swiza4.s2 == 77) && (swiza4.s3 == 164) && (swiza4.s4 == 164) && (swiza4.s5 == 192) && (swiza4.s6 == 119) && (swiza4.s7 == 77)))
        return -1;

    uchar16 d4 = (uchar16) (193,240,162,93,161,169,214,231,1,243,14,185,218,200,156,191);
    uchar16 swiz4 = d4.s5723105757685927;

    // results validation
    if (!((swiz4.s0 == 169) && (swiz4.s1 == 231) && (swiz4.s2 == 162) && (swiz4.s3 == 93) && (swiz4.s4 == 240) && (swiz4.s5 == 193) && (swiz4.s6 == 169) && (swiz4.s7 == 231) && (swiz4.s8 == 169) && (swiz4.s9 == 231) && (swiz4.sA == 214) && (swiz4.sB == 1) && (swiz4.sC == 169) && (swiz4.sD == 243) && (swiz4.sE == 162) && (swiz4.sF == 231)))
        return -1;

    uchar2 a5 = (uchar2) (190,32);
    uchar2 swizc5 = a5.s11;

    // results validation
    if (!((swizc5.x == 32) && (swizc5.y == 32)))
        return -1;

    uchar3 e5 = (uchar3) (212,140,83);
    uchar3 swize5 = e5.s012;

    // results validation
    if (!((swize5.x == 212) && (swize5.y == 140) && (swize5.z == 83)))
        return -1;

    uchar4 b5 = (uchar4) (99,173,103,217);
    uchar4 swizb5 = b5.s3220;

    // results validation
    if (!((swizb5.x == 217) && (swizb5.y == 103) && (swizb5.z == 103) && (swizb5.w == 99)))
        return -1;

    uchar8 c5 = (uchar8) (5,84,105,193,96,10,115,69);
    uchar8 swiza5 = c5.s21722217;

    // results validation
    if (!((swiza5.s0 == 105) && (swiza5.s1 == 84) && (swiza5.s2 == 69) && (swiza5.s3 == 105) && (swiza5.s4 == 105) && (swiza5.s5 == 105) && (swiza5.s6 == 84) && (swiza5.s7 == 69)))
        return -1;

    uchar16 d5 = (uchar16) (72,193,40,123,164,170,234,219,207,184,105,233,25,8,147,98);
    uchar16 swiz5 = d5.s0903346348925838;

    // results validation
    if (!((swiz5.s0 == 72) && (swiz5.s1 == 184) && (swiz5.s2 == 72) && (swiz5.s3 == 123) && (swiz5.s4 == 123) && (swiz5.s5 == 164) && (swiz5.s6 == 234) && (swiz5.s7 == 123) && (swiz5.s8 == 164) && (swiz5.s9 == 207) && (swiz5.sA == 184) && (swiz5.sB == 40) && (swiz5.sC == 170) && (swiz5.sD == 207) && (swiz5.sE == 123) && (swiz5.sF == 207)))
        return -1;

    uchar2 a6 = (uchar2) (52,28);
    uchar2 swizc6 = a6.s10;

    // results validation
    if (!((swizc6.x == 28) && (swizc6.y == 52)))
        return -1;

    uchar3 e6 = (uchar3) (66,156,71);
    uchar3 swize6 = e6.s002;

    // results validation
    if (!((swize6.x == 66) && (swize6.y == 66) && (swize6.z == 71)))
        return -1;

    uchar4 b6 = (uchar4) (118,33,237,52);
    uchar4 swizb6 = b6.s2120;

    // results validation
    if (!((swizb6.x == 237) && (swizb6.y == 33) && (swizb6.z == 237) && (swizb6.w == 118)))
        return -1;

    uchar8 c6 = (uchar8) (210,230,126,220,22,236,119,2);
    uchar8 swiza6 = c6.s47564004;

    // results validation
    if (!((swiza6.s0 == 22) && (swiza6.s1 == 2) && (swiza6.s2 == 236) && (swiza6.s3 == 119) && (swiza6.s4 == 22) && (swiza6.s5 == 210) && (swiza6.s6 == 210) && (swiza6.s7 == 22)))
        return -1;

    uchar16 d6 = (uchar16) (184,225,71,67,239,243,173,154,150,68,36,32,12,110,234,21);
    uchar16 swiz6 = d6.s2761404919039584;

    // results validation
    if (!((swiz6.s0 == 71) && (swiz6.s1 == 154) && (swiz6.s2 == 173) && (swiz6.s3 == 225) && (swiz6.s4 == 239) && (swiz6.s5 == 184) && (swiz6.s6 == 239) && (swiz6.s7 == 68) && (swiz6.s8 == 225) && (swiz6.s9 == 68) && (swiz6.sA == 184) && (swiz6.sB == 67) && (swiz6.sC == 68) && (swiz6.sD == 243) && (swiz6.sE == 150) && (swiz6.sF == 239)))
        return -1;

    uchar2 a7 = (uchar2) (42,193);
    uchar2 swizc7 = a7.s01;

    // results validation
    if (!((swizc7.x == 42) && (swizc7.y == 193)))
        return -1;

    uchar3 e7 = (uchar3) (75,31,178);
    uchar3 swize7 = e7.s211;

    // results validation
    if (!((swize7.x == 178) && (swize7.y == 31) && (swize7.z == 31)))
        return -1;

    uchar4 b7 = (uchar4) (56,67,36,104);
    uchar4 swizb7 = b7.s0321;

    // results validation
    if (!((swizb7.x == 56) && (swizb7.y == 104) && (swizb7.z == 36) && (swizb7.w == 67)))
        return -1;

    uchar8 c7 = (uchar8) (219,118,38,48,119,27,5,151);
    uchar8 swiza7 = c7.s05055602;

    // results validation
    if (!((swiza7.s0 == 219) && (swiza7.s1 == 27) && (swiza7.s2 == 219) && (swiza7.s3 == 27) && (swiza7.s4 == 27) && (swiza7.s5 == 5) && (swiza7.s6 == 219) && (swiza7.s7 == 38)))
        return -1;

    uchar16 d7 = (uchar16) (23,169,60,50,178,13,230,117,212,9,125,223,246,245,210,177);
    uchar16 swiz7 = d7.s4874680911608525;

    // results validation
    if (!((swiz7.s0 == 178) && (swiz7.s1 == 212) && (swiz7.s2 == 117) && (swiz7.s3 == 178) && (swiz7.s4 == 230) && (swiz7.s5 == 212) && (swiz7.s6 == 23) && (swiz7.s7 == 9) && (swiz7.s8 == 169) && (swiz7.s9 == 169) && (swiz7.sA == 230) && (swiz7.sB == 23) && (swiz7.sC == 212) && (swiz7.sD == 13) && (swiz7.sE == 60) && (swiz7.sF == 13)))
        return -1;

    uchar2 a8 = (uchar2) (108,23);
    uchar2 swizc8 = a8.s00;

    // results validation
    if (!((swizc8.x == 108) && (swizc8.y == 108)))
        return -1;

    uchar3 e8 = (uchar3) (37,170,59);
    uchar3 swize8 = e8.s102;

    // results validation
    if (!((swize8.x == 170) && (swize8.y == 37) && (swize8.z == 59)))
        return -1;

    uchar4 b8 = (uchar4) (90,193,137,110);
    uchar4 swizb8 = b8.s3032;

    // results validation
    if (!((swizb8.x == 110) && (swizb8.y == 90) && (swizb8.z == 110) && (swizb8.w == 137)))
        return -1;

    uchar8 c8 = (uchar8) (75,177,172,84,5,220,19,191);
    uchar8 swiza8 = c8.s24574241;

    // results validation
    if (!((swiza8.s0 == 172) && (swiza8.s1 == 5) && (swiza8.s2 == 220) && (swiza8.s3 == 191) && (swiza8.s4 == 5) && (swiza8.s5 == 172) && (swiza8.s6 == 5) && (swiza8.s7 == 177)))
        return -1;

    uchar16 d8 = (uchar16) (88,82,111,244,233,221,229,211,129,134,82,79,189,148,140,232);
    uchar16 swiz8 = d8.s1663788972019173;

    // results validation
    if (!((swiz8.s0 == 82) && (swiz8.s1 == 229) && (swiz8.s2 == 229) && (swiz8.s3 == 244) && (swiz8.s4 == 211) && (swiz8.s5 == 129) && (swiz8.s6 == 129) && (swiz8.s7 == 134) && (swiz8.s8 == 211) && (swiz8.s9 == 111) && (swiz8.sA == 88) && (swiz8.sB == 82) && (swiz8.sC == 134) && (swiz8.sD == 82) && (swiz8.sE == 211) && (swiz8.sF == 244)))
        return -1;

    uchar2 a9 = (uchar2) (235,6);
    uchar2 swizc9 = a9.s01;

    // results validation
    if (!((swizc9.x == 235) && (swizc9.y == 6)))
        return -1;

    uchar3 e9 = (uchar3) (11,135,4);
    uchar3 swize9 = e9.s101;

    // results validation
    if (!((swize9.x == 135) && (swize9.y == 11) && (swize9.z == 135)))
        return -1;

    uchar4 b9 = (uchar4) (94,9,180,126);
    uchar4 swizb9 = b9.s2211;

    // results validation
    if (!((swizb9.x == 180) && (swizb9.y == 180) && (swizb9.z == 9) && (swizb9.w == 9)))
        return -1;

    uchar8 c9 = (uchar8) (28,172,200,33,152,92,105,1);
    uchar8 swiza9 = c9.s52746041;

    // results validation
    if (!((swiza9.s0 == 92) && (swiza9.s1 == 200) && (swiza9.s2 == 1) && (swiza9.s3 == 152) && (swiza9.s4 == 105) && (swiza9.s5 == 28) && (swiza9.s6 == 152) && (swiza9.s7 == 172)))
        return -1;

    uchar16 d9 = (uchar16) (151,133,72,146,229,68,26,133,162,174,159,153,158,231,185,180);
    uchar16 swiz9 = d9.s8586178912803007;

    // results validation
    if (!((swiz9.s0 == 162) && (swiz9.s1 == 68) && (swiz9.s2 == 162) && (swiz9.s3 == 26) && (swiz9.s4 == 133) && (swiz9.s5 == 133) && (swiz9.s6 == 162) && (swiz9.s7 == 174) && (swiz9.s8 == 133) && (swiz9.s9 == 72) && (swiz9.sA == 162) && (swiz9.sB == 151) && (swiz9.sC == 146) && (swiz9.sD == 151) && (swiz9.sE == 151) && (swiz9.sF == 133)))
        return -1;

    return 0;
}

__kernel void ocl_test_kernel(__global int *ocl_test_results)
{
  ocl_test_results[0] = 1; //kernel started
  ocl_test_results[3] = main_function_ocl(0,0,ocl_test_results);
  ocl_test_results[0] = 2; //kernel finished
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
// From groups/vector.lst: status: , errorcode: , message: 
