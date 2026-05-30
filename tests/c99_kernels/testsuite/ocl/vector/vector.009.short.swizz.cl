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

    short2 a0 = (short2) (-1266,24790);
    short2 swizc0 = a0.s10;

    // results validation
    if (!((swizc0.x == 24790) && (swizc0.y == -1266)))
        return -1;

    short3 e0 = (short3) (13536,25015,-4784);
    short3 swize0 = e0.s102;

    // results validation
    if (!((swize0.x == 25015) && (swize0.y == 13536) && (swize0.z == -4784)))
        return -1;

    short4 b0 = (short4) (10132,1293,31353,16655);
    short4 swizb0 = b0.s2102;

    // results validation
    if (!((swizb0.x == 31353) && (swizb0.y == 1293) && (swizb0.z == 10132) && (swizb0.w == 31353)))
        return -1;

    short8 c0 = (short8) (6002,-9038,-32529,-19525,4560,-27706,24013,21151);
    short8 swiza0 = c0.s72320007;

    // results validation
    if (!((swiza0.s0 == 21151) && (swiza0.s1 == -32529) && (swiza0.s2 == -19525) && (swiza0.s3 == -32529) && (swiza0.s4 == 6002) && (swiza0.s5 == 6002) && (swiza0.s6 == 6002) && (swiza0.s7 == 21151)))
        return -1;

    short16 d0 = (short16) (18750,14195,17418,5844,-31339,-22322,6897,-16151,31548,-30885,22181,-5052,1813,13135,-3500,6336);
    short16 swiz0 = d0.s3624096051923758;

    // results validation
    if (!((swiz0.s0 == 5844) && (swiz0.s1 == 6897) && (swiz0.s2 == 17418) && (swiz0.s3 == -31339) && (swiz0.s4 == 18750) && (swiz0.s5 == -30885) && (swiz0.s6 == 6897) && (swiz0.s7 == 18750) && (swiz0.s8 == -22322) && (swiz0.s9 == 14195) && (swiz0.sA == -30885) && (swiz0.sB == 17418) && (swiz0.sC == 5844) && (swiz0.sD == -16151) && (swiz0.sE == -22322) && (swiz0.sF == 31548)))
        return -1;

    short2 a1 = (short2) (9480,7124);
    short2 swizc1 = a1.s01;

    // results validation
    if (!((swizc1.x == 9480) && (swizc1.y == 7124)))
        return -1;

    short3 e1 = (short3) (12542,6239,-1449);
    short3 swize1 = e1.s200;

    // results validation
    if (!((swize1.x == -1449) && (swize1.y == 12542) && (swize1.z == 12542)))
        return -1;

    short4 b1 = (short4) (-7380,30705,13293,31494);
    short4 swizb1 = b1.s3312;

    // results validation
    if (!((swizb1.x == 31494) && (swizb1.y == 31494) && (swizb1.z == 30705) && (swizb1.w == 13293)))
        return -1;

    short8 c1 = (short8) (-12642,-757,846,905,8594,15334,32512,26292);
    short8 swiza1 = c1.s02070371;

    // results validation
    if (!((swiza1.s0 == -12642) && (swiza1.s1 == 846) && (swiza1.s2 == -12642) && (swiza1.s3 == 26292) && (swiza1.s4 == -12642) && (swiza1.s5 == 905) && (swiza1.s6 == 26292) && (swiza1.s7 == -757)))
        return -1;

    short16 d1 = (short16) (-8151,-30675,-11063,23562,-26521,32560,-10095,12429,-28988,32674,27119,-21356,652,22432,7810,402);
    short16 swiz1 = d1.s6408313772783973;

    // results validation
    if (!((swiz1.s0 == -10095) && (swiz1.s1 == -26521) && (swiz1.s2 == -8151) && (swiz1.s3 == -28988) && (swiz1.s4 == 23562) && (swiz1.s5 == -30675) && (swiz1.s6 == 23562) && (swiz1.s7 == 12429) && (swiz1.s8 == 12429) && (swiz1.s9 == -11063) && (swiz1.sA == 12429) && (swiz1.sB == -28988) && (swiz1.sC == 23562) && (swiz1.sD == 32674) && (swiz1.sE == 12429) && (swiz1.sF == 23562)))
        return -1;

    short2 a2 = (short2) (24476,31100);
    short2 swizc2 = a2.s11;

    // results validation
    if (!((swizc2.x == 31100) && (swizc2.y == 31100)))
        return -1;

    short3 e2 = (short3) (-1087,-31248,27846);
    short3 swize2 = e2.s022;

    // results validation
    if (!((swize2.x == -1087) && (swize2.y == 27846) && (swize2.z == 27846)))
        return -1;

    short4 b2 = (short4) (21426,-12281,-16224,-1327);
    short4 swizb2 = b2.s1201;

    // results validation
    if (!((swizb2.x == -12281) && (swizb2.y == -16224) && (swizb2.z == 21426) && (swizb2.w == -12281)))
        return -1;

    short8 c2 = (short8) (4662,-6470,4305,-21502,-9271,-22057,15669,27814);
    short8 swiza2 = c2.s66560110;

    // results validation
    if (!((swiza2.s0 == 15669) && (swiza2.s1 == 15669) && (swiza2.s2 == -22057) && (swiza2.s3 == 15669) && (swiza2.s4 == 4662) && (swiza2.s5 == -6470) && (swiza2.s6 == -6470) && (swiza2.s7 == 4662)))
        return -1;

    short16 d2 = (short16) (920,-4684,17626,4723,-20625,2602,22017,-11498,-31708,1952,18631,-12058,29616,-4949,-8003,28964);
    short16 swiz2 = d2.s0425643665240454;

    // results validation
    if (!((swiz2.s0 == 920) && (swiz2.s1 == -20625) && (swiz2.s2 == 17626) && (swiz2.s3 == 2602) && (swiz2.s4 == 22017) && (swiz2.s5 == -20625) && (swiz2.s6 == 4723) && (swiz2.s7 == 22017) && (swiz2.s8 == 22017) && (swiz2.s9 == 2602) && (swiz2.sA == 17626) && (swiz2.sB == -20625) && (swiz2.sC == 920) && (swiz2.sD == -20625) && (swiz2.sE == 2602) && (swiz2.sF == -20625)))
        return -1;

    short2 a3 = (short2) (20642,16993);
    short2 swizc3 = a3.s10;

    // results validation
    if (!((swizc3.x == 16993) && (swizc3.y == 20642)))
        return -1;

    short3 e3 = (short3) (-10190,19059,-4030);
    short3 swize3 = e3.s021;

    // results validation
    if (!((swize3.x == -10190) && (swize3.y == -4030) && (swize3.z == 19059)))
        return -1;

    short4 b3 = (short4) (-23400,5248,-20245,-20196);
    short4 swizb3 = b3.s2330;

    // results validation
    if (!((swizb3.x == -20245) && (swizb3.y == -20196) && (swizb3.z == -20196) && (swizb3.w == -23400)))
        return -1;

    short8 c3 = (short8) (-28848,-7004,-23685,32226,-30996,-13900,31852,-27727);
    short8 swiza3 = c3.s77520326;

    // results validation
    if (!((swiza3.s0 == -27727) && (swiza3.s1 == -27727) && (swiza3.s2 == -13900) && (swiza3.s3 == -23685) && (swiza3.s4 == -28848) && (swiza3.s5 == 32226) && (swiza3.s6 == -23685) && (swiza3.s7 == 31852)))
        return -1;

    short16 d3 = (short16) (-23166,-1010,-11223,-30436,-8159,6923,22412,-595,3057,17882,-3048,-12475,-11016,-10044,-3661,25896);
    short16 swiz3 = d3.s0206352023926704;

    // results validation
    if (!((swiz3.s0 == -23166) && (swiz3.s1 == -11223) && (swiz3.s2 == -23166) && (swiz3.s3 == 22412) && (swiz3.s4 == -30436) && (swiz3.s5 == 6923) && (swiz3.s6 == -11223) && (swiz3.s7 == -23166) && (swiz3.s8 == -11223) && (swiz3.s9 == -30436) && (swiz3.sA == 17882) && (swiz3.sB == -11223) && (swiz3.sC == 22412) && (swiz3.sD == -595) && (swiz3.sE == -23166) && (swiz3.sF == -8159)))
        return -1;

    short2 a4 = (short2) (-13879,3013);
    short2 swizc4 = a4.s11;

    // results validation
    if (!((swizc4.x == 3013) && (swizc4.y == 3013)))
        return -1;

    short3 e4 = (short3) (8735,25983,25856);
    short3 swize4 = e4.s100;

    // results validation
    if (!((swize4.x == 25983) && (swize4.y == 8735) && (swize4.z == 8735)))
        return -1;

    short4 b4 = (short4) (25863,3014,30428,29594);
    short4 swizb4 = b4.s0022;

    // results validation
    if (!((swizb4.x == 25863) && (swizb4.y == 25863) && (swizb4.z == 30428) && (swizb4.w == 30428)))
        return -1;

    short8 c4 = (short8) (23154,22299,-3848,-5672,23200,-25078,26227,1696);
    short8 swiza4 = c4.s25472575;

    // results validation
    if (!((swiza4.s0 == -3848) && (swiza4.s1 == -25078) && (swiza4.s2 == 23200) && (swiza4.s3 == 1696) && (swiza4.s4 == -3848) && (swiza4.s5 == -25078) && (swiza4.s6 == 1696) && (swiza4.s7 == -25078)))
        return -1;

    short16 d4 = (short16) (-17993,11037,-9696,-5402,-24538,-28196,7455,-25894,-31097,-16220,-16175,21423,-13104,6056,31906,16680);
    short16 swiz4 = d4.s3170530293826756;

    // results validation
    if (!((swiz4.s0 == -5402) && (swiz4.s1 == 11037) && (swiz4.s2 == -25894) && (swiz4.s3 == -17993) && (swiz4.s4 == -28196) && (swiz4.s5 == -5402) && (swiz4.s6 == -17993) && (swiz4.s7 == -9696) && (swiz4.s8 == -16220) && (swiz4.s9 == -5402) && (swiz4.sA == -31097) && (swiz4.sB == -9696) && (swiz4.sC == 7455) && (swiz4.sD == -25894) && (swiz4.sE == -28196) && (swiz4.sF == 7455)))
        return -1;

    short2 a5 = (short2) (30131,-535);
    short2 swizc5 = a5.s10;

    // results validation
    if (!((swizc5.x == -535) && (swizc5.y == 30131)))
        return -1;

    short3 e5 = (short3) (-29295,-6617,-2907);
    short3 swize5 = e5.s022;

    // results validation
    if (!((swize5.x == -29295) && (swize5.y == -2907) && (swize5.z == -2907)))
        return -1;

    short4 b5 = (short4) (3724,-26985,10313,19485);
    short4 swizb5 = b5.s1103;

    // results validation
    if (!((swizb5.x == -26985) && (swizb5.y == -26985) && (swizb5.z == 3724) && (swizb5.w == 19485)))
        return -1;

    short8 c5 = (short8) (-27743,30338,-12011,2230,-10352,-18894,-18017,10736);
    short8 swiza5 = c5.s64206367;

    // results validation
    if (!((swiza5.s0 == -18017) && (swiza5.s1 == -10352) && (swiza5.s2 == -12011) && (swiza5.s3 == -27743) && (swiza5.s4 == -18017) && (swiza5.s5 == 2230) && (swiza5.s6 == -18017) && (swiza5.s7 == 10736)))
        return -1;

    short16 d5 = (short16) (22511,9202,13701,23404,11915,-14314,-17393,-32710,8972,-11414,-4767,-1117,30695,-604,-13932,28314);
    short16 swiz5 = d5.s5930608039464697;

    // results validation
    if (!((swiz5.s0 == -14314) && (swiz5.s1 == -11414) && (swiz5.s2 == 23404) && (swiz5.s3 == 22511) && (swiz5.s4 == -17393) && (swiz5.s5 == 22511) && (swiz5.s6 == 8972) && (swiz5.s7 == 22511) && (swiz5.s8 == 23404) && (swiz5.s9 == -11414) && (swiz5.sA == 11915) && (swiz5.sB == -17393) && (swiz5.sC == 11915) && (swiz5.sD == -17393) && (swiz5.sE == -11414) && (swiz5.sF == -32710)))
        return -1;

    short2 a6 = (short2) (-29540,-29582);
    short2 swizc6 = a6.s00;

    // results validation
    if (!((swizc6.x == -29540) && (swizc6.y == -29540)))
        return -1;

    short3 e6 = (short3) (6744,515,28696);
    short3 swize6 = e6.s221;

    // results validation
    if (!((swize6.x == 28696) && (swize6.y == 28696) && (swize6.z == 515)))
        return -1;

    short4 b6 = (short4) (17795,28914,-10074,32381);
    short4 swizb6 = b6.s3313;

    // results validation
    if (!((swizb6.x == 32381) && (swizb6.y == 32381) && (swizb6.z == 28914) && (swizb6.w == 32381)))
        return -1;

    short8 c6 = (short8) (31931,11976,25124,5929,26673,8744,-26647,-29298);
    short8 swiza6 = c6.s37036246;

    // results validation
    if (!((swiza6.s0 == 5929) && (swiza6.s1 == -29298) && (swiza6.s2 == 31931) && (swiza6.s3 == 5929) && (swiza6.s4 == -26647) && (swiza6.s5 == 25124) && (swiza6.s6 == 26673) && (swiza6.s7 == -26647)))
        return -1;

    short16 d6 = (short16) (7023,13553,-2175,-13912,30879,-13784,-156,9051,25713,8147,-7538,17449,-14662,5318,7349,-12981);
    short16 swiz6 = d6.s1532629249722410;

    // results validation
    if (!((swiz6.s0 == 13553) && (swiz6.s1 == -13784) && (swiz6.s2 == -13912) && (swiz6.s3 == -2175) && (swiz6.s4 == -156) && (swiz6.s5 == -2175) && (swiz6.s6 == 8147) && (swiz6.s7 == -2175) && (swiz6.s8 == 30879) && (swiz6.s9 == 8147) && (swiz6.sA == 9051) && (swiz6.sB == -2175) && (swiz6.sC == -2175) && (swiz6.sD == 30879) && (swiz6.sE == 13553) && (swiz6.sF == 7023)))
        return -1;

    short2 a7 = (short2) (4070,16139);
    short2 swizc7 = a7.s01;

    // results validation
    if (!((swizc7.x == 4070) && (swizc7.y == 16139)))
        return -1;

    short3 e7 = (short3) (-10626,19252,26559);
    short3 swize7 = e7.s110;

    // results validation
    if (!((swize7.x == 19252) && (swize7.y == 19252) && (swize7.z == -10626)))
        return -1;

    short4 b7 = (short4) (-19319,7081,20397,-27571);
    short4 swizb7 = b7.s3301;

    // results validation
    if (!((swizb7.x == -27571) && (swizb7.y == -27571) && (swizb7.z == -19319) && (swizb7.w == 7081)))
        return -1;

    short8 c7 = (short8) (-16909,6275,25550,20551,-29584,-7300,977,-3966);
    short8 swiza7 = c7.s17670424;

    // results validation
    if (!((swiza7.s0 == 6275) && (swiza7.s1 == -3966) && (swiza7.s2 == 977) && (swiza7.s3 == -3966) && (swiza7.s4 == -16909) && (swiza7.s5 == -29584) && (swiza7.s6 == 25550) && (swiza7.s7 == -29584)))
        return -1;

    short16 d7 = (short16) (14709,-13834,-29827,4766,25567,-30856,-5799,21538,31118,20807,-2821,21200,-23141,-9652,19071,-15410);
    short16 swiz7 = d7.s6518869322944662;

    // results validation
    if (!((swiz7.s0 == -5799) && (swiz7.s1 == -30856) && (swiz7.s2 == -13834) && (swiz7.s3 == 31118) && (swiz7.s4 == 31118) && (swiz7.s5 == -5799) && (swiz7.s6 == 20807) && (swiz7.s7 == 4766) && (swiz7.s8 == -29827) && (swiz7.s9 == -29827) && (swiz7.sA == 20807) && (swiz7.sB == 25567) && (swiz7.sC == 25567) && (swiz7.sD == -5799) && (swiz7.sE == -5799) && (swiz7.sF == -29827)))
        return -1;

    short2 a8 = (short2) (-4300,-25454);
    short2 swizc8 = a8.s11;

    // results validation
    if (!((swizc8.x == -25454) && (swizc8.y == -25454)))
        return -1;

    short3 e8 = (short3) (-12168,-18385,24032);
    short3 swize8 = e8.s012;

    // results validation
    if (!((swize8.x == -12168) && (swize8.y == -18385) && (swize8.z == 24032)))
        return -1;

    short4 b8 = (short4) (17746,-21,-25448,5516);
    short4 swizb8 = b8.s2123;

    // results validation
    if (!((swizb8.x == -25448) && (swizb8.y == -21) && (swizb8.z == -25448) && (swizb8.w == 5516)))
        return -1;

    short8 c8 = (short8) (4911,-30824,17016,23325,-18125,-17891,-13971,-7568);
    short8 swiza8 = c8.s06501534;

    // results validation
    if (!((swiza8.s0 == 4911) && (swiza8.s1 == -13971) && (swiza8.s2 == -17891) && (swiza8.s3 == 4911) && (swiza8.s4 == -30824) && (swiza8.s5 == -17891) && (swiza8.s6 == 23325) && (swiza8.s7 == -18125)))
        return -1;

    short16 d8 = (short16) (-30889,20702,-9949,8099,28757,-24482,5190,14913,25748,12523,20651,-15913,21288,31132,-8957,-1070);
    short16 swiz8 = d8.s6225226288746170;

    // results validation
    if (!((swiz8.s0 == 5190) && (swiz8.s1 == -9949) && (swiz8.s2 == -9949) && (swiz8.s3 == -24482) && (swiz8.s4 == -9949) && (swiz8.s5 == -9949) && (swiz8.s6 == 5190) && (swiz8.s7 == -9949) && (swiz8.s8 == 25748) && (swiz8.s9 == 25748) && (swiz8.sA == 14913) && (swiz8.sB == 28757) && (swiz8.sC == 5190) && (swiz8.sD == 20702) && (swiz8.sE == 14913) && (swiz8.sF == -30889)))
        return -1;

    short2 a9 = (short2) (-20540,-15675);
    short2 swizc9 = a9.s00;

    // results validation
    if (!((swizc9.x == -20540) && (swizc9.y == -20540)))
        return -1;

    short3 e9 = (short3) (11147,-27375,16797);
    short3 swize9 = e9.s111;

    // results validation
    if (!((swize9.x == -27375) && (swize9.y == -27375) && (swize9.z == -27375)))
        return -1;

    short4 b9 = (short4) (-1317,12066,12519,18106);
    short4 swizb9 = b9.s0310;

    // results validation
    if (!((swizb9.x == -1317) && (swizb9.y == 18106) && (swizb9.z == 12066) && (swizb9.w == -1317)))
        return -1;

    short8 c9 = (short8) (30880,-7851,-6716,-10712,-27423,-16895,9592,9051);
    short8 swiza9 = c9.s76126273;

    // results validation
    if (!((swiza9.s0 == 9051) && (swiza9.s1 == 9592) && (swiza9.s2 == -7851) && (swiza9.s3 == -6716) && (swiza9.s4 == 9592) && (swiza9.s5 == -6716) && (swiza9.s6 == 9051) && (swiza9.s7 == -10712)))
        return -1;

    short16 d9 = (short16) (-9784,790,30191,14677,-7192,19996,-5970,-16677,22227,-8544,7059,-32048,-30198,10805,-17014,26261);
    short16 swiz9 = d9.s5741887178929775;

    // results validation
    if (!((swiz9.s0 == 19996) && (swiz9.s1 == -16677) && (swiz9.s2 == -7192) && (swiz9.s3 == 790) && (swiz9.s4 == 22227) && (swiz9.s5 == 22227) && (swiz9.s6 == -16677) && (swiz9.s7 == 790) && (swiz9.s8 == -16677) && (swiz9.s9 == 22227) && (swiz9.sA == -8544) && (swiz9.sB == 30191) && (swiz9.sC == -8544) && (swiz9.sD == -16677) && (swiz9.sE == -16677) && (swiz9.sF == 19996)))
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
