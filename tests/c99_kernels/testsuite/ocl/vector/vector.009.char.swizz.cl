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

    char2 a0 = (char2) (105,-97);
    char2 swizc0 = a0.s11;

    // results validation
    if (!((swizc0.x == -97) && (swizc0.y == -97)))
        return -1;

    char3 e0 = (char3) (-59,107,-30);
    char3 swize0 = e0.s000;

    // results validation
    if (!((swize0.x == -59) && (swize0.y == -59) && (swize0.z == -59)))
        return -1;

    char4 b0 = (char4) (80,-85,80,7);
    char4 swizb0 = b0.s1212;

    // results validation
    if (!((swizb0.x == -85) && (swizb0.y == 80) && (swizb0.z == -85) && (swizb0.w == 80)))
        return -1;

    char8 c0 = (char8) (-39,-92,-2,96,48,-72,90,-35);
    char8 swiza0 = c0.s45262464;

    // results validation
    if (!((swiza0.s0 == 48) && (swiza0.s1 == -72) && (swiza0.s2 == -2) && (swiza0.s3 == 90) && (swiza0.s4 == -2) && (swiza0.s5 == 48) && (swiza0.s6 == 90) && (swiza0.s7 == 48)))
        return -1;

    char16 d0 = (char16) (-75,-9,37,-90,-40,-87,2,-58,-47,-78,76,-90,120,92,35,-102);
    char16 swiz0 = d0.s3748202611478634;

    // results validation
    if (!((swiz0.s0 == -90) && (swiz0.s1 == -58) && (swiz0.s2 == -40) && (swiz0.s3 == -47) && (swiz0.s4 == 37) && (swiz0.s5 == -75) && (swiz0.s6 == 37) && (swiz0.s7 == 2) && (swiz0.s8 == -9) && (swiz0.s9 == -9) && (swiz0.sA == -40) && (swiz0.sB == -58) && (swiz0.sC == -47) && (swiz0.sD == 2) && (swiz0.sE == -90) && (swiz0.sF == -40)))
        return -1;

    char2 a1 = (char2) (113,-57);
    char2 swizc1 = a1.s00;

    // results validation
    if (!((swizc1.x == 113) && (swizc1.y == 113)))
        return -1;

    char3 e1 = (char3) (-79,-36,77);
    char3 swize1 = e1.s202;

    // results validation
    if (!((swize1.x == 77) && (swize1.y == -79) && (swize1.z == 77)))
        return -1;

    char4 b1 = (char4) (112,-80,77,-37);
    char4 swizb1 = b1.s0113;

    // results validation
    if (!((swizb1.x == 112) && (swizb1.y == -80) && (swizb1.z == -80) && (swizb1.w == -37)))
        return -1;

    char8 c1 = (char8) (114,93,97,75,47,52,61,4);
    char8 swiza1 = c1.s64417174;

    // results validation
    if (!((swiza1.s0 == 61) && (swiza1.s1 == 47) && (swiza1.s2 == 47) && (swiza1.s3 == 93) && (swiza1.s4 == 4) && (swiza1.s5 == 93) && (swiza1.s6 == 4) && (swiza1.s7 == 47)))
        return -1;

    char16 d1 = (char16) (42,-34,59,-17,3,-113,-3,110,-68,-85,79,-50,98,-3,38,-52);
    char16 swiz1 = d1.s0386734696109010;

    // results validation
    if (!((swiz1.s0 == 42) && (swiz1.s1 == -17) && (swiz1.s2 == -68) && (swiz1.s3 == -3) && (swiz1.s4 == 110) && (swiz1.s5 == -17) && (swiz1.s6 == 3) && (swiz1.s7 == -3) && (swiz1.s8 == -85) && (swiz1.s9 == -3) && (swiz1.sA == -34) && (swiz1.sB == 42) && (swiz1.sC == -85) && (swiz1.sD == 42) && (swiz1.sE == -34) && (swiz1.sF == 42)))
        return -1;

    char2 a2 = (char2) (-53,120);
    char2 swizc2 = a2.s10;

    // results validation
    if (!((swizc2.x == 120) && (swizc2.y == -53)))
        return -1;

    char3 e2 = (char3) (-46,29,94);
    char3 swize2 = e2.s212;

    // results validation
    if (!((swize2.x == 94) && (swize2.y == 29) && (swize2.z == 94)))
        return -1;

    char4 b2 = (char4) (-117,-33,25,-100);
    char4 swizb2 = b2.s2000;

    // results validation
    if (!((swizb2.x == 25) && (swizb2.y == -117) && (swizb2.z == -117) && (swizb2.w == -117)))
        return -1;

    char8 c2 = (char8) (76,-53,14,-52,83,-98,-99,85);
    char8 swiza2 = c2.s10410024;

    // results validation
    if (!((swiza2.s0 == -53) && (swiza2.s1 == 76) && (swiza2.s2 == 83) && (swiza2.s3 == -53) && (swiza2.s4 == 76) && (swiza2.s5 == 76) && (swiza2.s6 == 14) && (swiza2.s7 == 83)))
        return -1;

    char16 d2 = (char16) (3,-113,104,51,49,8,104,61,20,49,-82,11,-115,44,102,23);
    char16 swiz2 = d2.s7241390895503903;

    // results validation
    if (!((swiz2.s0 == 61) && (swiz2.s1 == 104) && (swiz2.s2 == 49) && (swiz2.s3 == -113) && (swiz2.s4 == 51) && (swiz2.s5 == 49) && (swiz2.s6 == 3) && (swiz2.s7 == 20) && (swiz2.s8 == 49) && (swiz2.s9 == 8) && (swiz2.sA == 8) && (swiz2.sB == 3) && (swiz2.sC == 51) && (swiz2.sD == 49) && (swiz2.sE == 3) && (swiz2.sF == 51)))
        return -1;

    char2 a3 = (char2) (42,83);
    char2 swizc3 = a3.s00;

    // results validation
    if (!((swizc3.x == 42) && (swizc3.y == 42)))
        return -1;

    char3 e3 = (char3) (2,21,57);
    char3 swize3 = e3.s120;

    // results validation
    if (!((swize3.x == 21) && (swize3.y == 57) && (swize3.z == 2)))
        return -1;

    char4 b3 = (char4) (3,60,-51,24);
    char4 swizb3 = b3.s3031;

    // results validation
    if (!((swizb3.x == 24) && (swizb3.y == 3) && (swizb3.z == 24) && (swizb3.w == 60)))
        return -1;

    char8 c3 = (char8) (12,108,101,-96,-19,72,0,15);
    char8 swiza3 = c3.s26662601;

    // results validation
    if (!((swiza3.s0 == 101) && (swiza3.s1 == 0) && (swiza3.s2 == 0) && (swiza3.s3 == 0) && (swiza3.s4 == 101) && (swiza3.s5 == 0) && (swiza3.s6 == 12) && (swiza3.s7 == 108)))
        return -1;

    char16 d3 = (char16) (-38,122,-86,60,-37,-41,44,3,32,-7,36,-10,-60,-1,-116,110);
    char16 swiz3 = d3.s2684243269650769;

    // results validation
    if (!((swiz3.s0 == -86) && (swiz3.s1 == 44) && (swiz3.s2 == 32) && (swiz3.s3 == -37) && (swiz3.s4 == -86) && (swiz3.s5 == -37) && (swiz3.s6 == 60) && (swiz3.s7 == -86) && (swiz3.s8 == 44) && (swiz3.s9 == -7) && (swiz3.sA == 44) && (swiz3.sB == -41) && (swiz3.sC == -38) && (swiz3.sD == 3) && (swiz3.sE == 44) && (swiz3.sF == -7)))
        return -1;

    char2 a4 = (char2) (-55,35);
    char2 swizc4 = a4.s00;

    // results validation
    if (!((swizc4.x == -55) && (swizc4.y == -55)))
        return -1;

    char3 e4 = (char3) (-119,-58,79);
    char3 swize4 = e4.s012;

    // results validation
    if (!((swize4.x == -119) && (swize4.y == -58) && (swize4.z == 79)))
        return -1;

    char4 b4 = (char4) (-113,-12,-105,-5);
    char4 swizb4 = b4.s2303;

    // results validation
    if (!((swizb4.x == -105) && (swizb4.y == -5) && (swizb4.z == -113) && (swizb4.w == -5)))
        return -1;

    char8 c4 = (char8) (90,126,-92,3,42,113,14,125);
    char8 swiza4 = c4.s56073634;

    // results validation
    if (!((swiza4.s0 == 113) && (swiza4.s1 == 14) && (swiza4.s2 == 90) && (swiza4.s3 == 125) && (swiza4.s4 == 3) && (swiza4.s5 == 14) && (swiza4.s6 == 3) && (swiza4.s7 == 42)))
        return -1;

    char16 d4 = (char16) (53,1,33,83,81,20,-47,114,85,-67,-118,-60,-119,102,63,-27);
    char16 swiz4 = d4.s4477470869242898;

    // results validation
    if (!((swiz4.s0 == 81) && (swiz4.s1 == 81) && (swiz4.s2 == 114) && (swiz4.s3 == 114) && (swiz4.s4 == 81) && (swiz4.s5 == 114) && (swiz4.s6 == 53) && (swiz4.s7 == 85) && (swiz4.s8 == -47) && (swiz4.s9 == -67) && (swiz4.sA == 33) && (swiz4.sB == 81) && (swiz4.sC == 33) && (swiz4.sD == 85) && (swiz4.sE == -67) && (swiz4.sF == 85)))
        return -1;

    char2 a5 = (char2) (8,-30);
    char2 swizc5 = a5.s10;

    // results validation
    if (!((swizc5.x == -30) && (swizc5.y == 8)))
        return -1;

    char3 e5 = (char3) (-42,86,-97);
    char3 swize5 = e5.s112;

    // results validation
    if (!((swize5.x == 86) && (swize5.y == 86) && (swize5.z == -97)))
        return -1;

    char4 b5 = (char4) (-68,-22,7,101);
    char4 swizb5 = b5.s0331;

    // results validation
    if (!((swizb5.x == -68) && (swizb5.y == 101) && (swizb5.z == 101) && (swizb5.w == -22)))
        return -1;

    char8 c5 = (char8) (-27,123,33,1,-127,71,-105,83);
    char8 swiza5 = c5.s11126362;

    // results validation
    if (!((swiza5.s0 == 123) && (swiza5.s1 == 123) && (swiza5.s2 == 123) && (swiza5.s3 == 33) && (swiza5.s4 == -105) && (swiza5.s5 == 1) && (swiza5.s6 == -105) && (swiza5.s7 == 33)))
        return -1;

    char16 d5 = (char16) (-10,-54,-61,-66,-112,-112,-11,-15,74,-56,17,-77,-85,-14,92,47);
    char16 swiz5 = d5.s5023078260299356;

    // results validation
    if (!((swiz5.s0 == -112) && (swiz5.s1 == -10) && (swiz5.s2 == -61) && (swiz5.s3 == -66) && (swiz5.s4 == -10) && (swiz5.s5 == -15) && (swiz5.s6 == 74) && (swiz5.s7 == -61) && (swiz5.s8 == -11) && (swiz5.s9 == -10) && (swiz5.sA == -61) && (swiz5.sB == -56) && (swiz5.sC == -56) && (swiz5.sD == -66) && (swiz5.sE == -112) && (swiz5.sF == -11)))
        return -1;

    char2 a6 = (char2) (-78,114);
    char2 swizc6 = a6.s01;

    // results validation
    if (!((swizc6.x == -78) && (swizc6.y == 114)))
        return -1;

    char3 e6 = (char3) (81,-57,51);
    char3 swize6 = e6.s221;

    // results validation
    if (!((swize6.x == 51) && (swize6.y == 51) && (swize6.z == -57)))
        return -1;

    char4 b6 = (char4) (33,-38,-64,31);
    char4 swizb6 = b6.s0200;

    // results validation
    if (!((swizb6.x == 33) && (swizb6.y == -64) && (swizb6.z == 33) && (swizb6.w == 33)))
        return -1;

    char8 c6 = (char8) (111,-80,52,104,-24,-83,22,52);
    char8 swiza6 = c6.s40115721;

    // results validation
    if (!((swiza6.s0 == -24) && (swiza6.s1 == 111) && (swiza6.s2 == -80) && (swiza6.s3 == -80) && (swiza6.s4 == -83) && (swiza6.s5 == 52) && (swiza6.s6 == 52) && (swiza6.s7 == -80)))
        return -1;

    char16 d6 = (char16) (20,98,-49,-71,105,-62,-127,106,54,29,0,-60,37,57,-70,62);
    char16 swiz6 = d6.s2251820349732684;

    // results validation
    if (!((swiz6.s0 == -49) && (swiz6.s1 == -49) && (swiz6.s2 == -62) && (swiz6.s3 == 98) && (swiz6.s4 == 54) && (swiz6.s5 == -49) && (swiz6.s6 == 20) && (swiz6.s7 == -71) && (swiz6.s8 == 105) && (swiz6.s9 == 29) && (swiz6.sA == 106) && (swiz6.sB == -71) && (swiz6.sC == -49) && (swiz6.sD == -127) && (swiz6.sE == 54) && (swiz6.sF == 105)))
        return -1;

    char2 a7 = (char2) (4,-47);
    char2 swizc7 = a7.s00;

    // results validation
    if (!((swizc7.x == 4) && (swizc7.y == 4)))
        return -1;

    char3 e7 = (char3) (-20,110,36);
    char3 swize7 = e7.s000;

    // results validation
    if (!((swize7.x == -20) && (swize7.y == -20) && (swize7.z == -20)))
        return -1;

    char4 b7 = (char4) (-40,-101,-127,59);
    char4 swizb7 = b7.s3132;

    // results validation
    if (!((swizb7.x == 59) && (swizb7.y == -101) && (swizb7.z == 59) && (swizb7.w == -127)))
        return -1;

    char8 c7 = (char8) (-87,-25,76,-26,8,106,52,-64);
    char8 swiza7 = c7.s74601443;

    // results validation
    if (!((swiza7.s0 == -64) && (swiza7.s1 == 8) && (swiza7.s2 == 52) && (swiza7.s3 == -87) && (swiza7.s4 == -25) && (swiza7.s5 == 8) && (swiza7.s6 == 8) && (swiza7.s7 == -26)))
        return -1;

    char16 d7 = (char16) (115,-55,94,-55,-16,-84,-113,5,-53,-49,23,81,-19,-100,86,105);
    char16 swiz7 = d7.s9307850036529754;

    // results validation
    if (!((swiz7.s0 == -49) && (swiz7.s1 == -55) && (swiz7.s2 == 115) && (swiz7.s3 == 5) && (swiz7.s4 == -53) && (swiz7.s5 == -84) && (swiz7.s6 == 115) && (swiz7.s7 == 115) && (swiz7.s8 == -55) && (swiz7.s9 == -113) && (swiz7.sA == -84) && (swiz7.sB == 94) && (swiz7.sC == -49) && (swiz7.sD == 5) && (swiz7.sE == -84) && (swiz7.sF == -16)))
        return -1;

    char2 a8 = (char2) (109,-101);
    char2 swizc8 = a8.s11;

    // results validation
    if (!((swizc8.x == -101) && (swizc8.y == -101)))
        return -1;

    char3 e8 = (char3) (-61,-49,45);
    char3 swize8 = e8.s222;

    // results validation
    if (!((swize8.x == 45) && (swize8.y == 45) && (swize8.z == 45)))
        return -1;

    char4 b8 = (char4) (-86,76,-16,-71);
    char4 swizb8 = b8.s1033;

    // results validation
    if (!((swizb8.x == 76) && (swizb8.y == -86) && (swizb8.z == -71) && (swizb8.w == -71)))
        return -1;

    char8 c8 = (char8) (-65,-103,61,76,14,-55,70,-39);
    char8 swiza8 = c8.s16542331;

    // results validation
    if (!((swiza8.s0 == -103) && (swiza8.s1 == 70) && (swiza8.s2 == -55) && (swiza8.s3 == 14) && (swiza8.s4 == 61) && (swiza8.s5 == 76) && (swiza8.s6 == 76) && (swiza8.s7 == -103)))
        return -1;

    char16 d8 = (char16) (-47,71,63,29,86,-126,-3,-119,29,82,18,17,34,8,43,13);
    char16 swiz8 = d8.s8488881847722599;

    // results validation
    if (!((swiz8.s0 == 29) && (swiz8.s1 == 86) && (swiz8.s2 == 29) && (swiz8.s3 == 29) && (swiz8.s4 == 29) && (swiz8.s5 == 29) && (swiz8.s6 == 71) && (swiz8.s7 == 29) && (swiz8.s8 == 86) && (swiz8.s9 == -119) && (swiz8.sA == -119) && (swiz8.sB == 63) && (swiz8.sC == 63) && (swiz8.sD == -126) && (swiz8.sE == 82) && (swiz8.sF == 82)))
        return -1;

    char2 a9 = (char2) (100,98);
    char2 swizc9 = a9.s11;

    // results validation
    if (!((swizc9.x == 98) && (swizc9.y == 98)))
        return -1;

    char3 e9 = (char3) (57,62,-68);
    char3 swize9 = e9.s121;

    // results validation
    if (!((swize9.x == 62) && (swize9.y == -68) && (swize9.z == 62)))
        return -1;

    char4 b9 = (char4) (-11,13,9,-72);
    char4 swizb9 = b9.s3002;

    // results validation
    if (!((swizb9.x == -72) && (swizb9.y == -11) && (swizb9.z == -11) && (swizb9.w == 9)))
        return -1;

    char8 c9 = (char8) (-125,12,-40,39,-25,44,-40,63);
    char8 swiza9 = c9.s34426235;

    // results validation
    if (!((swiza9.s0 == 39) && (swiza9.s1 == -25) && (swiza9.s2 == -25) && (swiza9.s3 == -40) && (swiza9.s4 == -40) && (swiza9.s5 == -40) && (swiza9.s6 == 39) && (swiza9.s7 == 44)))
        return -1;

    char16 d9 = (char16) (93,119,-92,63,20,-60,98,-13,-126,90,-98,-91,-54,-57,-9,50);
    char16 swiz9 = d9.s0190228035920280;

    // results validation
    if (!((swiz9.s0 == 93) && (swiz9.s1 == 119) && (swiz9.s2 == 90) && (swiz9.s3 == 93) && (swiz9.s4 == -92) && (swiz9.s5 == -92) && (swiz9.s6 == -126) && (swiz9.s7 == 93) && (swiz9.s8 == 63) && (swiz9.s9 == -60) && (swiz9.sA == 90) && (swiz9.sB == -92) && (swiz9.sC == 93) && (swiz9.sD == -92) && (swiz9.sE == -126) && (swiz9.sF == 93)))
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
