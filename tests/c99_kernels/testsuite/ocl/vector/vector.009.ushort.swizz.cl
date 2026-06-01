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

    ushort2 a0 = (ushort2) (11462,52400);
    ushort2 swizc0 = a0.s10;

    // results validation
    if (!((swizc0.x == 52400) && (swizc0.y == 11462)))
        return -1;

    ushort3 e0 = (ushort3) (58166,21748,19681);
    ushort3 swize0 = e0.s210;

    // results validation
    if (!((swize0.x == 19681) && (swize0.y == 21748) && (swize0.z == 58166)))
        return -1;

    ushort4 b0 = (ushort4) (21917,36820,53023,61301);
    ushort4 swizb0 = b0.s3201;

    // results validation
    if (!((swizb0.x == 61301) && (swizb0.y == 53023) && (swizb0.z == 21917) && (swizb0.w == 36820)))
        return -1;

    ushort8 c0 = (ushort8) (35808,34296,32163,6116,20057,42344,35557,56043);
    ushort8 swiza0 = c0.s55665607;

    // results validation
    if (!((swiza0.s0 == 42344) && (swiza0.s1 == 42344) && (swiza0.s2 == 35557) && (swiza0.s3 == 35557) && (swiza0.s4 == 42344) && (swiza0.s5 == 35557) && (swiza0.s6 == 35808) && (swiza0.s7 == 56043)))
        return -1;

    ushort16 d0 = (ushort16) (1725,20866,16150,62304,19119,53512,60811,1550,641,60014,28497,32966,64396,12184,63863,63808);
    ushort16 swiz0 = d0.s2682904543540656;

    // results validation
    if (!((swiz0.s0 == 16150) && (swiz0.s1 == 60811) && (swiz0.s2 == 641) && (swiz0.s3 == 16150) && (swiz0.s4 == 60014) && (swiz0.s5 == 1725) && (swiz0.s6 == 19119) && (swiz0.s7 == 53512) && (swiz0.s8 == 19119) && (swiz0.s9 == 62304) && (swiz0.sA == 53512) && (swiz0.sB == 19119) && (swiz0.sC == 1725) && (swiz0.sD == 60811) && (swiz0.sE == 53512) && (swiz0.sF == 60811)))
        return -1;

    ushort2 a1 = (ushort2) (22805,40401);
    ushort2 swizc1 = a1.s01;

    // results validation
    if (!((swizc1.x == 22805) && (swizc1.y == 40401)))
        return -1;

    ushort3 e1 = (ushort3) (4778,9674,57595);
    ushort3 swize1 = e1.s110;

    // results validation
    if (!((swize1.x == 9674) && (swize1.y == 9674) && (swize1.z == 4778)))
        return -1;

    ushort4 b1 = (ushort4) (3814,2972,4123,46222);
    ushort4 swizb1 = b1.s3220;

    // results validation
    if (!((swizb1.x == 46222) && (swizb1.y == 4123) && (swizb1.z == 4123) && (swizb1.w == 3814)))
        return -1;

    ushort8 c1 = (ushort8) (16487,62338,30472,41187,12367,63889,18097,49768);
    ushort8 swiza1 = c1.s56306002;

    // results validation
    if (!((swiza1.s0 == 63889) && (swiza1.s1 == 18097) && (swiza1.s2 == 41187) && (swiza1.s3 == 16487) && (swiza1.s4 == 18097) && (swiza1.s5 == 16487) && (swiza1.s6 == 16487) && (swiza1.s7 == 30472)))
        return -1;

    ushort16 d1 = (ushort16) (54936,27086,38287,60274,6920,58176,29615,50269,55430,31715,65147,64877,45434,183,12993,13778);
    ushort16 swiz1 = d1.s1490149179095363;

    // results validation
    if (!((swiz1.s0 == 27086) && (swiz1.s1 == 6920) && (swiz1.s2 == 31715) && (swiz1.s3 == 54936) && (swiz1.s4 == 27086) && (swiz1.s5 == 6920) && (swiz1.s6 == 31715) && (swiz1.s7 == 27086) && (swiz1.s8 == 50269) && (swiz1.s9 == 31715) && (swiz1.sA == 54936) && (swiz1.sB == 31715) && (swiz1.sC == 58176) && (swiz1.sD == 60274) && (swiz1.sE == 29615) && (swiz1.sF == 60274)))
        return -1;

    ushort2 a2 = (ushort2) (894,56130);
    ushort2 swizc2 = a2.s11;

    // results validation
    if (!((swizc2.x == 56130) && (swizc2.y == 56130)))
        return -1;

    ushort3 e2 = (ushort3) (65377,90,21878);
    ushort3 swize2 = e2.s122;

    // results validation
    if (!((swize2.x == 90) && (swize2.y == 21878) && (swize2.z == 21878)))
        return -1;

    ushort4 b2 = (ushort4) (23877,35434,27356,50841);
    ushort4 swizb2 = b2.s3100;

    // results validation
    if (!((swizb2.x == 50841) && (swizb2.y == 35434) && (swizb2.z == 23877) && (swizb2.w == 23877)))
        return -1;

    ushort8 c2 = (ushort8) (28611,60037,50581,23256,56153,50772,60454,27674);
    ushort8 swiza2 = c2.s37477342;

    // results validation
    if (!((swiza2.s0 == 23256) && (swiza2.s1 == 27674) && (swiza2.s2 == 56153) && (swiza2.s3 == 27674) && (swiza2.s4 == 27674) && (swiza2.s5 == 23256) && (swiza2.s6 == 56153) && (swiza2.s7 == 50581)))
        return -1;

    ushort16 d2 = (ushort16) (44368,30740,51133,63750,27703,11208,10911,2924,41774,56643,53139,2548,40279,10905,11945,4808);
    ushort16 swiz2 = d2.s2695374760230975;

    // results validation
    if (!((swiz2.s0 == 51133) && (swiz2.s1 == 10911) && (swiz2.s2 == 56643) && (swiz2.s3 == 11208) && (swiz2.s4 == 63750) && (swiz2.s5 == 2924) && (swiz2.s6 == 27703) && (swiz2.s7 == 2924) && (swiz2.s8 == 10911) && (swiz2.s9 == 44368) && (swiz2.sA == 51133) && (swiz2.sB == 63750) && (swiz2.sC == 44368) && (swiz2.sD == 56643) && (swiz2.sE == 2924) && (swiz2.sF == 11208)))
        return -1;

    ushort2 a3 = (ushort2) (55670,41632);
    ushort2 swizc3 = a3.s11;

    // results validation
    if (!((swizc3.x == 41632) && (swizc3.y == 41632)))
        return -1;

    ushort3 e3 = (ushort3) (39443,64255,25466);
    ushort3 swize3 = e3.s201;

    // results validation
    if (!((swize3.x == 25466) && (swize3.y == 39443) && (swize3.z == 64255)))
        return -1;

    ushort4 b3 = (ushort4) (24276,20351,14560,62871);
    ushort4 swizb3 = b3.s2210;

    // results validation
    if (!((swizb3.x == 14560) && (swizb3.y == 14560) && (swizb3.z == 20351) && (swizb3.w == 24276)))
        return -1;

    ushort8 c3 = (ushort8) (9072,31522,27042,48033,62310,40111,45033,8324);
    ushort8 swiza3 = c3.s23700431;

    // results validation
    if (!((swiza3.s0 == 27042) && (swiza3.s1 == 48033) && (swiza3.s2 == 8324) && (swiza3.s3 == 9072) && (swiza3.s4 == 9072) && (swiza3.s5 == 62310) && (swiza3.s6 == 48033) && (swiza3.s7 == 31522)))
        return -1;

    ushort16 d3 = (ushort16) (25780,19672,60767,8157,56398,15633,14533,9296,15737,43529,31183,39131,36161,43440,41034,12810);
    ushort16 swiz3 = d3.s8991282920376649;

    // results validation
    if (!((swiz3.s0 == 15737) && (swiz3.s1 == 43529) && (swiz3.s2 == 43529) && (swiz3.s3 == 19672) && (swiz3.s4 == 60767) && (swiz3.s5 == 15737) && (swiz3.s6 == 60767) && (swiz3.s7 == 43529) && (swiz3.s8 == 60767) && (swiz3.s9 == 25780) && (swiz3.sA == 8157) && (swiz3.sB == 9296) && (swiz3.sC == 14533) && (swiz3.sD == 14533) && (swiz3.sE == 56398) && (swiz3.sF == 43529)))
        return -1;

    ushort2 a4 = (ushort2) (16788,63313);
    ushort2 swizc4 = a4.s10;

    // results validation
    if (!((swizc4.x == 63313) && (swizc4.y == 16788)))
        return -1;

    ushort3 e4 = (ushort3) (41503,21514,41949);
    ushort3 swize4 = e4.s110;

    // results validation
    if (!((swize4.x == 21514) && (swize4.y == 21514) && (swize4.z == 41503)))
        return -1;

    ushort4 b4 = (ushort4) (11592,52315,41895,61480);
    ushort4 swizb4 = b4.s2202;

    // results validation
    if (!((swizb4.x == 41895) && (swizb4.y == 41895) && (swizb4.z == 11592) && (swizb4.w == 41895)))
        return -1;

    ushort8 c4 = (ushort8) (34196,38057,34712,293,59053,1250,34491,24412);
    ushort8 swiza4 = c4.s07227741;

    // results validation
    if (!((swiza4.s0 == 34196) && (swiza4.s1 == 24412) && (swiza4.s2 == 34712) && (swiza4.s3 == 34712) && (swiza4.s4 == 24412) && (swiza4.s5 == 24412) && (swiza4.s6 == 59053) && (swiza4.s7 == 38057)))
        return -1;

    ushort16 d4 = (ushort16) (12543,59280,65484,5519,686,28874,2120,32680,10535,4365,17586,26132,13046,63414,1821,52769);
    ushort16 swiz4 = d4.s0447826034224439;

    // results validation
    if (!((swiz4.s0 == 12543) && (swiz4.s1 == 686) && (swiz4.s2 == 686) && (swiz4.s3 == 32680) && (swiz4.s4 == 10535) && (swiz4.s5 == 65484) && (swiz4.s6 == 2120) && (swiz4.s7 == 12543) && (swiz4.s8 == 5519) && (swiz4.s9 == 686) && (swiz4.sA == 65484) && (swiz4.sB == 65484) && (swiz4.sC == 686) && (swiz4.sD == 686) && (swiz4.sE == 5519) && (swiz4.sF == 4365)))
        return -1;

    ushort2 a5 = (ushort2) (19747,10190);
    ushort2 swizc5 = a5.s11;

    // results validation
    if (!((swizc5.x == 10190) && (swizc5.y == 10190)))
        return -1;

    ushort3 e5 = (ushort3) (41896,12870,8124);
    ushort3 swize5 = e5.s211;

    // results validation
    if (!((swize5.x == 8124) && (swize5.y == 12870) && (swize5.z == 12870)))
        return -1;

    ushort4 b5 = (ushort4) (17288,65337,17827,12363);
    ushort4 swizb5 = b5.s1223;

    // results validation
    if (!((swizb5.x == 65337) && (swizb5.y == 17827) && (swizb5.z == 17827) && (swizb5.w == 12363)))
        return -1;

    ushort8 c5 = (ushort8) (42653,25547,50141,54227,7981,59388,31135,44998);
    ushort8 swiza5 = c5.s64577761;

    // results validation
    if (!((swiza5.s0 == 31135) && (swiza5.s1 == 7981) && (swiza5.s2 == 59388) && (swiza5.s3 == 44998) && (swiza5.s4 == 44998) && (swiza5.s5 == 44998) && (swiza5.s6 == 31135) && (swiza5.s7 == 25547)))
        return -1;

    ushort16 d5 = (ushort16) (1993,11498,40829,499,45810,48074,50199,30728,9569,49306,51099,62412,42165,61658,13879,43515);
    ushort16 swiz5 = d5.s6462289417069153;

    // results validation
    if (!((swiz5.s0 == 50199) && (swiz5.s1 == 45810) && (swiz5.s2 == 50199) && (swiz5.s3 == 40829) && (swiz5.s4 == 40829) && (swiz5.s5 == 9569) && (swiz5.s6 == 49306) && (swiz5.s7 == 45810) && (swiz5.s8 == 11498) && (swiz5.s9 == 30728) && (swiz5.sA == 1993) && (swiz5.sB == 50199) && (swiz5.sC == 49306) && (swiz5.sD == 11498) && (swiz5.sE == 48074) && (swiz5.sF == 499)))
        return -1;

    ushort2 a6 = (ushort2) (29500,40097);
    ushort2 swizc6 = a6.s01;

    // results validation
    if (!((swizc6.x == 29500) && (swizc6.y == 40097)))
        return -1;

    ushort3 e6 = (ushort3) (54458,52054,13326);
    ushort3 swize6 = e6.s220;

    // results validation
    if (!((swize6.x == 13326) && (swize6.y == 13326) && (swize6.z == 54458)))
        return -1;

    ushort4 b6 = (ushort4) (38930,39012,42573,62637);
    ushort4 swizb6 = b6.s2300;

    // results validation
    if (!((swizb6.x == 42573) && (swizb6.y == 62637) && (swizb6.z == 38930) && (swizb6.w == 38930)))
        return -1;

    ushort8 c6 = (ushort8) (927,7251,32879,32112,9134,2348,55398,51687);
    ushort8 swiza6 = c6.s24604156;

    // results validation
    if (!((swiza6.s0 == 32879) && (swiza6.s1 == 9134) && (swiza6.s2 == 55398) && (swiza6.s3 == 927) && (swiza6.s4 == 9134) && (swiza6.s5 == 7251) && (swiza6.s6 == 2348) && (swiza6.s7 == 55398)))
        return -1;

    ushort16 d6 = (ushort16) (5656,8061,1219,28447,5775,60245,7575,2849,4391,58236,11466,54729,380,6996,40877,18614);
    ushort16 swiz6 = d6.s9663315739971118;

    // results validation
    if (!((swiz6.s0 == 58236) && (swiz6.s1 == 7575) && (swiz6.s2 == 7575) && (swiz6.s3 == 28447) && (swiz6.s4 == 28447) && (swiz6.s5 == 8061) && (swiz6.s6 == 60245) && (swiz6.s7 == 2849) && (swiz6.s8 == 28447) && (swiz6.s9 == 58236) && (swiz6.sA == 58236) && (swiz6.sB == 2849) && (swiz6.sC == 8061) && (swiz6.sD == 8061) && (swiz6.sE == 8061) && (swiz6.sF == 4391)))
        return -1;

    ushort2 a7 = (ushort2) (58927,7081);
    ushort2 swizc7 = a7.s01;

    // results validation
    if (!((swizc7.x == 58927) && (swizc7.y == 7081)))
        return -1;

    ushort3 e7 = (ushort3) (36385,29540,28658);
    ushort3 swize7 = e7.s012;

    // results validation
    if (!((swize7.x == 36385) && (swize7.y == 29540) && (swize7.z == 28658)))
        return -1;

    ushort4 b7 = (ushort4) (31819,38554,376,27779);
    ushort4 swizb7 = b7.s1022;

    // results validation
    if (!((swizb7.x == 38554) && (swizb7.y == 31819) && (swizb7.z == 376) && (swizb7.w == 376)))
        return -1;

    ushort8 c7 = (ushort8) (49301,35507,47940,63607,1646,38002,5628,44655);
    ushort8 swiza7 = c7.s60554475;

    // results validation
    if (!((swiza7.s0 == 5628) && (swiza7.s1 == 49301) && (swiza7.s2 == 38002) && (swiza7.s3 == 38002) && (swiza7.s4 == 1646) && (swiza7.s5 == 1646) && (swiza7.s6 == 44655) && (swiza7.s7 == 38002)))
        return -1;

    ushort16 d7 = (ushort16) (31413,51581,5769,61410,41730,52836,41962,14292,4253,40888,32165,50533,49116,9199,19548,42142);
    ushort16 swiz7 = d7.s1841214645340844;

    // results validation
    if (!((swiz7.s0 == 51581) && (swiz7.s1 == 4253) && (swiz7.s2 == 41730) && (swiz7.s3 == 51581) && (swiz7.s4 == 5769) && (swiz7.s5 == 51581) && (swiz7.s6 == 41730) && (swiz7.s7 == 41962) && (swiz7.s8 == 41730) && (swiz7.s9 == 52836) && (swiz7.sA == 61410) && (swiz7.sB == 41730) && (swiz7.sC == 31413) && (swiz7.sD == 4253) && (swiz7.sE == 41730) && (swiz7.sF == 41730)))
        return -1;

    ushort2 a8 = (ushort2) (10932,6291);
    ushort2 swizc8 = a8.s11;

    // results validation
    if (!((swizc8.x == 6291) && (swizc8.y == 6291)))
        return -1;

    ushort3 e8 = (ushort3) (23834,31683,59429);
    ushort3 swize8 = e8.s102;

    // results validation
    if (!((swize8.x == 31683) && (swize8.y == 23834) && (swize8.z == 59429)))
        return -1;

    ushort4 b8 = (ushort4) (60968,60798,7274,14582);
    ushort4 swizb8 = b8.s2210;

    // results validation
    if (!((swizb8.x == 7274) && (swizb8.y == 7274) && (swizb8.z == 60798) && (swizb8.w == 60968)))
        return -1;

    ushort8 c8 = (ushort8) (29476,8481,48446,10678,35343,1671,47916,12718);
    ushort8 swiza8 = c8.s75070521;

    // results validation
    if (!((swiza8.s0 == 12718) && (swiza8.s1 == 1671) && (swiza8.s2 == 29476) && (swiza8.s3 == 12718) && (swiza8.s4 == 29476) && (swiza8.s5 == 1671) && (swiza8.s6 == 48446) && (swiza8.s7 == 8481)))
        return -1;

    ushort16 d8 = (ushort16) (55459,55945,9916,12934,23582,18989,46642,6670,36768,36007,36196,20522,35682,14180,23126,57961);
    ushort16 swiz8 = d8.s5128545523806991;

    // results validation
    if (!((swiz8.s0 == 18989) && (swiz8.s1 == 55945) && (swiz8.s2 == 9916) && (swiz8.s3 == 36768) && (swiz8.s4 == 18989) && (swiz8.s5 == 23582) && (swiz8.s6 == 18989) && (swiz8.s7 == 18989) && (swiz8.s8 == 9916) && (swiz8.s9 == 12934) && (swiz8.sA == 36768) && (swiz8.sB == 55459) && (swiz8.sC == 46642) && (swiz8.sD == 36007) && (swiz8.sE == 36007) && (swiz8.sF == 55945)))
        return -1;

    ushort2 a9 = (ushort2) (29077,13676);
    ushort2 swizc9 = a9.s01;

    // results validation
    if (!((swizc9.x == 29077) && (swizc9.y == 13676)))
        return -1;

    ushort3 e9 = (ushort3) (46710,46038,19920);
    ushort3 swize9 = e9.s021;

    // results validation
    if (!((swize9.x == 46710) && (swize9.y == 19920) && (swize9.z == 46038)))
        return -1;

    ushort4 b9 = (ushort4) (35817,37168,33823,14529);
    ushort4 swizb9 = b9.s2200;

    // results validation
    if (!((swizb9.x == 33823) && (swizb9.y == 33823) && (swizb9.z == 35817) && (swizb9.w == 35817)))
        return -1;

    ushort8 c9 = (ushort8) (7412,59112,49733,37352,14350,64123,52256,41052);
    ushort8 swiza9 = c9.s54463030;

    // results validation
    if (!((swiza9.s0 == 64123) && (swiza9.s1 == 14350) && (swiza9.s2 == 14350) && (swiza9.s3 == 52256) && (swiza9.s4 == 37352) && (swiza9.s5 == 7412) && (swiza9.s6 == 37352) && (swiza9.s7 == 7412)))
        return -1;

    ushort16 d9 = (ushort16) (34775,61450,23767,58582,25133,29242,28637,27088,9218,5827,51421,30166,36975,47310,57278,60505);
    ushort16 swiz9 = d9.s2521067943165729;

    // results validation
    if (!((swiz9.s0 == 23767) && (swiz9.s1 == 29242) && (swiz9.s2 == 23767) && (swiz9.s3 == 61450) && (swiz9.s4 == 34775) && (swiz9.s5 == 28637) && (swiz9.s6 == 27088) && (swiz9.s7 == 5827) && (swiz9.s8 == 25133) && (swiz9.s9 == 58582) && (swiz9.sA == 61450) && (swiz9.sB == 28637) && (swiz9.sC == 29242) && (swiz9.sD == 27088) && (swiz9.sE == 23767) && (swiz9.sF == 5827)))
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
