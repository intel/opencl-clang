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

    uint2 a0 = (uint2) (2473770126,2626809216);
    uint2 swizc0 = a0.s01;

    // results validation
    if (!((swizc0.x == 2473770126) && (swizc0.y == 2626809216)))
        return -1;

    uint3 e0 = (uint3) (649874897,83015214,327100240);
    uint3 swize0 = e0.s200;

    // results validation
    if (!((swize0.x == 327100240) && (swize0.y == 649874897) && (swize0.z == 649874897)))
        return -1;

    uint4 b0 = (uint4) (3686050553,1192636221,3031480236,1298036043);
    uint4 swizb0 = b0.s1203;

    // results validation
    if (!((swizb0.x == 1192636221) && (swizb0.y == 3031480236) && (swizb0.z == 3686050553) && (swizb0.w == 1298036043)))
        return -1;

    uint8 c0 = (uint8) (3155791870,1102514997,131904425,670852170,364423828,369124946,82165095,1015500528);
    uint8 swiza0 = c0.s16357113;

    // results validation
    if (!((swiza0.s0 == 1102514997) && (swiza0.s1 == 82165095) && (swiza0.s2 == 670852170) && (swiza0.s3 == 369124946) && (swiza0.s4 == 1015500528) && (swiza0.s5 == 1102514997) && (swiza0.s6 == 1102514997) && (swiza0.s7 == 670852170)))
        return -1;

    uint16 d0 = (uint16) (565065511,2895566393,850095352,455646677,1616314114,2287327316,2540788737,3875771897,1012886071,225219691,2338701938,694211626,2963778803,263828109,2069906453,77475622);
    uint16 swiz0 = d0.s4729679577232583;

    // results validation
    if (!((swiz0.s0 == 1616314114) && (swiz0.s1 == 3875771897) && (swiz0.s2 == 850095352) && (swiz0.s3 == 225219691) && (swiz0.s4 == 2540788737) && (swiz0.s5 == 3875771897) && (swiz0.s6 == 225219691) && (swiz0.s7 == 2287327316) && (swiz0.s8 == 3875771897) && (swiz0.s9 == 3875771897) && (swiz0.sA == 850095352) && (swiz0.sB == 455646677) && (swiz0.sC == 850095352) && (swiz0.sD == 2287327316) && (swiz0.sE == 1012886071) && (swiz0.sF == 455646677)))
        return -1;

    uint2 a1 = (uint2) (1589689986,553875663);
    uint2 swizc1 = a1.s00;

    // results validation
    if (!((swizc1.x == 1589689986) && (swizc1.y == 1589689986)))
        return -1;

    uint3 e1 = (uint3) (609321730,2357102449,2493087303);
    uint3 swize1 = e1.s221;

    // results validation
    if (!((swize1.x == 2493087303) && (swize1.y == 2493087303) && (swize1.z == 2357102449)))
        return -1;

    uint4 b1 = (uint4) (2845125556,600892915,3960127015,1065429722);
    uint4 swizb1 = b1.s2221;

    // results validation
    if (!((swizb1.x == 3960127015) && (swizb1.y == 3960127015) && (swizb1.z == 3960127015) && (swizb1.w == 600892915)))
        return -1;

    uint8 c1 = (uint8) (3438225814,1094507184,768803077,3285534605,1473000354,1072553299,3894069713,2979434597);
    uint8 swiza1 = c1.s16343140;

    // results validation
    if (!((swiza1.s0 == 1094507184) && (swiza1.s1 == 3894069713) && (swiza1.s2 == 3285534605) && (swiza1.s3 == 1473000354) && (swiza1.s4 == 3285534605) && (swiza1.s5 == 1094507184) && (swiza1.s6 == 1473000354) && (swiza1.s7 == 3438225814)))
        return -1;

    uint16 d1 = (uint16) (1477268825,1352610283,3761099323,199282701,440449901,3296285454,297592038,744658016,921512732,4170829532,87976980,1981138555,3845990166,1239670701,2867257068,94085607);
    uint16 swiz1 = d1.s0523246050486118;

    // results validation
    if (!((swiz1.s0 == 1477268825) && (swiz1.s1 == 3296285454) && (swiz1.s2 == 3761099323) && (swiz1.s3 == 199282701) && (swiz1.s4 == 3761099323) && (swiz1.s5 == 440449901) && (swiz1.s6 == 297592038) && (swiz1.s7 == 1477268825) && (swiz1.s8 == 3296285454) && (swiz1.s9 == 1477268825) && (swiz1.sA == 440449901) && (swiz1.sB == 921512732) && (swiz1.sC == 297592038) && (swiz1.sD == 1352610283) && (swiz1.sE == 1352610283) && (swiz1.sF == 921512732)))
        return -1;

    uint2 a2 = (uint2) (3997422279,4170726287);
    uint2 swizc2 = a2.s10;

    // results validation
    if (!((swizc2.x == 4170726287) && (swizc2.y == 3997422279)))
        return -1;

    uint3 e2 = (uint3) (3171788619,2157574511,1640381417);
    uint3 swize2 = e2.s202;

    // results validation
    if (!((swize2.x == 1640381417) && (swize2.y == 3171788619) && (swize2.z == 1640381417)))
        return -1;

    uint4 b2 = (uint4) (316977446,3789210403,231536092,3214685265);
    uint4 swizb2 = b2.s3022;

    // results validation
    if (!((swizb2.x == 3214685265) && (swizb2.y == 316977446) && (swizb2.z == 231536092) && (swizb2.w == 231536092)))
        return -1;

    uint8 c2 = (uint8) (4179470425,943852920,1154400742,3450100252,406411648,1561663935,1824560494,1708571901);
    uint8 swiza2 = c2.s42013212;

    // results validation
    if (!((swiza2.s0 == 406411648) && (swiza2.s1 == 1154400742) && (swiza2.s2 == 4179470425) && (swiza2.s3 == 943852920) && (swiza2.s4 == 3450100252) && (swiza2.s5 == 1154400742) && (swiza2.s6 == 943852920) && (swiza2.s7 == 1154400742)))
        return -1;

    uint16 d2 = (uint16) (93344417,3793328244,2383362234,3815111417,325357907,3477996424,728392189,2969541316,3986820798,3526840653,3380532739,3466298186,1691870954,4079738771,498753165,3646677743);
    uint16 swiz2 = d2.s8846149804077338;

    // results validation
    if (!((swiz2.s0 == 3986820798) && (swiz2.s1 == 3986820798) && (swiz2.s2 == 325357907) && (swiz2.s3 == 728392189) && (swiz2.s4 == 3793328244) && (swiz2.s5 == 325357907) && (swiz2.s6 == 3526840653) && (swiz2.s7 == 3986820798) && (swiz2.s8 == 93344417) && (swiz2.s9 == 325357907) && (swiz2.sA == 93344417) && (swiz2.sB == 2969541316) && (swiz2.sC == 2969541316) && (swiz2.sD == 3815111417) && (swiz2.sE == 3815111417) && (swiz2.sF == 3986820798)))
        return -1;

    uint2 a3 = (uint2) (2633462296,3328391286);
    uint2 swizc3 = a3.s01;

    // results validation
    if (!((swizc3.x == 2633462296) && (swizc3.y == 3328391286)))
        return -1;

    uint3 e3 = (uint3) (2336910241,3965583119,1846066577);
    uint3 swize3 = e3.s112;

    // results validation
    if (!((swize3.x == 3965583119) && (swize3.y == 3965583119) && (swize3.z == 1846066577)))
        return -1;

    uint4 b3 = (uint4) (2623364488,1527542746,2470705900,2431079929);
    uint4 swizb3 = b3.s3103;

    // results validation
    if (!((swizb3.x == 2431079929) && (swizb3.y == 1527542746) && (swizb3.z == 2623364488) && (swizb3.w == 2431079929)))
        return -1;

    uint8 c3 = (uint8) (2129877294,3373306013,4134606561,4119532242,2412981244,592179134,4101837583,2368501581);
    uint8 swiza3 = c3.s21213755;

    // results validation
    if (!((swiza3.s0 == 4134606561) && (swiza3.s1 == 3373306013) && (swiza3.s2 == 4134606561) && (swiza3.s3 == 3373306013) && (swiza3.s4 == 4119532242) && (swiza3.s5 == 2368501581) && (swiza3.s6 == 592179134) && (swiza3.s7 == 592179134)))
        return -1;

    uint16 d3 = (uint16) (2405206224,1832336280,79862009,3152541427,17068341,480654982,2798333214,164596317,1778895109,2406963193,4168606780,1486548957,2310067786,1090352245,453113825,4013972827);
    uint16 swiz3 = d3.s2519367221016269;

    // results validation
    if (!((swiz3.s0 == 79862009) && (swiz3.s1 == 480654982) && (swiz3.s2 == 1832336280) && (swiz3.s3 == 2406963193) && (swiz3.s4 == 3152541427) && (swiz3.s5 == 2798333214) && (swiz3.s6 == 164596317) && (swiz3.s7 == 79862009) && (swiz3.s8 == 79862009) && (swiz3.s9 == 1832336280) && (swiz3.sA == 2405206224) && (swiz3.sB == 1832336280) && (swiz3.sC == 2798333214) && (swiz3.sD == 79862009) && (swiz3.sE == 2798333214) && (swiz3.sF == 2406963193)))
        return -1;

    uint2 a4 = (uint2) (3807734101,4210905914);
    uint2 swizc4 = a4.s11;

    // results validation
    if (!((swizc4.x == 4210905914) && (swizc4.y == 4210905914)))
        return -1;

    uint3 e4 = (uint3) (1730801907,1753142591,1428629535);
    uint3 swize4 = e4.s010;

    // results validation
    if (!((swize4.x == 1730801907) && (swize4.y == 1753142591) && (swize4.z == 1730801907)))
        return -1;

    uint4 b4 = (uint4) (3294603067,1412987419,3526943717,444514439);
    uint4 swizb4 = b4.s0300;

    // results validation
    if (!((swizb4.x == 3294603067) && (swizb4.y == 444514439) && (swizb4.z == 3294603067) && (swizb4.w == 3294603067)))
        return -1;

    uint8 c4 = (uint8) (1994302848,1908360567,637989318,200824542,4195730538,1442483600,1960651876,3172980008);
    uint8 swiza4 = c4.s44403756;

    // results validation
    if (!((swiza4.s0 == 4195730538) && (swiza4.s1 == 4195730538) && (swiza4.s2 == 4195730538) && (swiza4.s3 == 1994302848) && (swiza4.s4 == 200824542) && (swiza4.s5 == 3172980008) && (swiza4.s6 == 1442483600) && (swiza4.s7 == 1960651876)))
        return -1;

    uint16 d4 = (uint16) (2867196485,3124058029,1712913874,3658757188,3679440487,1215985069,3971599192,3439299231,3949902074,3159257996,822977546,425520973,2959986690,2824785138,2709707374,941950030);
    uint16 swiz4 = d4.s4179731571389447;

    // results validation
    if (!((swiz4.s0 == 3679440487) && (swiz4.s1 == 3124058029) && (swiz4.s2 == 3439299231) && (swiz4.s3 == 3159257996) && (swiz4.s4 == 3439299231) && (swiz4.s5 == 3658757188) && (swiz4.s6 == 3124058029) && (swiz4.s7 == 1215985069) && (swiz4.s8 == 3439299231) && (swiz4.s9 == 3124058029) && (swiz4.sA == 3658757188) && (swiz4.sB == 3949902074) && (swiz4.sC == 3159257996) && (swiz4.sD == 3679440487) && (swiz4.sE == 3679440487) && (swiz4.sF == 3439299231)))
        return -1;

    uint2 a5 = (uint2) (4274647786,2025940263);
    uint2 swizc5 = a5.s11;

    // results validation
    if (!((swizc5.x == 2025940263) && (swizc5.y == 2025940263)))
        return -1;

    uint3 e5 = (uint3) (1001815510,1287626120,291904172);
    uint3 swize5 = e5.s220;

    // results validation
    if (!((swize5.x == 291904172) && (swize5.y == 291904172) && (swize5.z == 1001815510)))
        return -1;

    uint4 b5 = (uint4) (1493408240,2478237220,1298060193,3435441987);
    uint4 swizb5 = b5.s2020;

    // results validation
    if (!((swizb5.x == 1298060193) && (swizb5.y == 1493408240) && (swizb5.z == 1298060193) && (swizb5.w == 1493408240)))
        return -1;

    uint8 c5 = (uint8) (496234467,2070938368,10297664,1406867474,675711811,1660641351,458322046,401523134);
    uint8 swiza5 = c5.s00754563;

    // results validation
    if (!((swiza5.s0 == 496234467) && (swiza5.s1 == 496234467) && (swiza5.s2 == 401523134) && (swiza5.s3 == 1660641351) && (swiza5.s4 == 675711811) && (swiza5.s5 == 1660641351) && (swiza5.s6 == 458322046) && (swiza5.s7 == 1406867474)))
        return -1;

    uint16 d5 = (uint16) (3122143074,998818203,3461826284,792038528,28565572,1198861624,1590584339,1946214300,2230037794,239933080,2510179908,3967109956,27913978,2772166559,948710962,1349504264);
    uint16 swiz5 = d5.s9187993655095429;

    // results validation
    if (!((swiz5.s0 == 239933080) && (swiz5.s1 == 998818203) && (swiz5.s2 == 2230037794) && (swiz5.s3 == 1946214300) && (swiz5.s4 == 239933080) && (swiz5.s5 == 239933080) && (swiz5.s6 == 792038528) && (swiz5.s7 == 1590584339) && (swiz5.s8 == 1198861624) && (swiz5.s9 == 1198861624) && (swiz5.sA == 3122143074) && (swiz5.sB == 239933080) && (swiz5.sC == 1198861624) && (swiz5.sD == 28565572) && (swiz5.sE == 3461826284) && (swiz5.sF == 239933080)))
        return -1;

    uint2 a6 = (uint2) (3202284169,152514770);
    uint2 swizc6 = a6.s11;

    // results validation
    if (!((swizc6.x == 152514770) && (swizc6.y == 152514770)))
        return -1;

    uint3 e6 = (uint3) (2611209362,2588675378,2400844586);
    uint3 swize6 = e6.s111;

    // results validation
    if (!((swize6.x == 2588675378) && (swize6.y == 2588675378) && (swize6.z == 2588675378)))
        return -1;

    uint4 b6 = (uint4) (425732705,3978232427,3555410041,591252201);
    uint4 swizb6 = b6.s3230;

    // results validation
    if (!((swizb6.x == 591252201) && (swizb6.y == 3555410041) && (swizb6.z == 591252201) && (swizb6.w == 425732705)))
        return -1;

    uint8 c6 = (uint8) (3617357634,2208881263,307106244,4039923162,2052004708,2563071272,2934262778,1577001640);
    uint8 swiza6 = c6.s74653144;

    // results validation
    if (!((swiza6.s0 == 1577001640) && (swiza6.s1 == 2052004708) && (swiza6.s2 == 2934262778) && (swiza6.s3 == 2563071272) && (swiza6.s4 == 4039923162) && (swiza6.s5 == 2208881263) && (swiza6.s6 == 2052004708) && (swiza6.s7 == 2052004708)))
        return -1;

    uint16 d6 = (uint16) (1947291473,3971792763,198939721,3129929302,1156015482,61426361,1478126366,1828077421,3392714861,2119875313,928568335,2617523990,1333807360,3698950684,3638527411,2861480106);
    uint16 swiz6 = d6.s3104739968118898;

    // results validation
    if (!((swiz6.s0 == 3129929302) && (swiz6.s1 == 3971792763) && (swiz6.s2 == 1947291473) && (swiz6.s3 == 1156015482) && (swiz6.s4 == 1828077421) && (swiz6.s5 == 3129929302) && (swiz6.s6 == 2119875313) && (swiz6.s7 == 2119875313) && (swiz6.s8 == 1478126366) && (swiz6.s9 == 3392714861) && (swiz6.sA == 3971792763) && (swiz6.sB == 3971792763) && (swiz6.sC == 3392714861) && (swiz6.sD == 3392714861) && (swiz6.sE == 2119875313) && (swiz6.sF == 3392714861)))
        return -1;

    uint2 a7 = (uint2) (901263140,1920842321);
    uint2 swizc7 = a7.s01;

    // results validation
    if (!((swizc7.x == 901263140) && (swizc7.y == 1920842321)))
        return -1;

    uint3 e7 = (uint3) (2316042252,1142221244,2956140023);
    uint3 swize7 = e7.s110;

    // results validation
    if (!((swize7.x == 1142221244) && (swize7.y == 1142221244) && (swize7.z == 2316042252)))
        return -1;

    uint4 b7 = (uint4) (1058962310,516088701,1029926180,4025115009);
    uint4 swizb7 = b7.s3022;

    // results validation
    if (!((swizb7.x == 4025115009) && (swizb7.y == 1058962310) && (swizb7.z == 1029926180) && (swizb7.w == 1029926180)))
        return -1;

    uint8 c7 = (uint8) (881826932,3064278504,2303146560,2535081015,940925589,1958062857,1492981548,898037938);
    uint8 swiza7 = c7.s40237113;

    // results validation
    if (!((swiza7.s0 == 940925589) && (swiza7.s1 == 881826932) && (swiza7.s2 == 2303146560) && (swiza7.s3 == 2535081015) && (swiza7.s4 == 898037938) && (swiza7.s5 == 3064278504) && (swiza7.s6 == 3064278504) && (swiza7.s7 == 2535081015)))
        return -1;

    uint16 d7 = (uint16) (632070224,3289356814,1906537920,3098799419,3465168577,2243078076,3037057965,1671931855,3461984219,92881995,228928951,860198198,1674317431,1073264891,2815321738,3424812634);
    uint16 swiz7 = d7.s1878542538026088;

    // results validation
    if (!((swiz7.s0 == 3289356814) && (swiz7.s1 == 3461984219) && (swiz7.s2 == 1671931855) && (swiz7.s3 == 3461984219) && (swiz7.s4 == 2243078076) && (swiz7.s5 == 3465168577) && (swiz7.s6 == 1906537920) && (swiz7.s7 == 2243078076) && (swiz7.s8 == 3098799419) && (swiz7.s9 == 3461984219) && (swiz7.sA == 632070224) && (swiz7.sB == 1906537920) && (swiz7.sC == 3037057965) && (swiz7.sD == 632070224) && (swiz7.sE == 3461984219) && (swiz7.sF == 3461984219)))
        return -1;

    uint2 a8 = (uint2) (1088641290,1237920088);
    uint2 swizc8 = a8.s10;

    // results validation
    if (!((swizc8.x == 1237920088) && (swizc8.y == 1088641290)))
        return -1;

    uint3 e8 = (uint3) (1792561407,3608444184,1187724595);
    uint3 swize8 = e8.s221;

    // results validation
    if (!((swize8.x == 1187724595) && (swize8.y == 1187724595) && (swize8.z == 3608444184)))
        return -1;

    uint4 b8 = (uint4) (697713654,1865660989,4114023557,3929448786);
    uint4 swizb8 = b8.s3033;

    // results validation
    if (!((swizb8.x == 3929448786) && (swizb8.y == 697713654) && (swizb8.z == 3929448786) && (swizb8.w == 3929448786)))
        return -1;

    uint8 c8 = (uint8) (2577166099,1448703797,263448932,2334165141,1830333448,2964497149,961325705,3219517347);
    uint8 swiza8 = c8.s54746724;

    // results validation
    if (!((swiza8.s0 == 2964497149) && (swiza8.s1 == 1830333448) && (swiza8.s2 == 3219517347) && (swiza8.s3 == 1830333448) && (swiza8.s4 == 961325705) && (swiza8.s5 == 3219517347) && (swiza8.s6 == 263448932) && (swiza8.s7 == 1830333448)))
        return -1;

    uint16 d8 = (uint16) (1294175113,2995932442,3065569579,2418988342,2886561287,3244399429,3098595886,2842757856,1575938509,2754092489,3492286630,619858921,30280057,2022175866,3602511938,895216121);
    uint16 swiz8 = d8.s4507602787648392;

    // results validation
    if (!((swiz8.s0 == 2886561287) && (swiz8.s1 == 3244399429) && (swiz8.s2 == 1294175113) && (swiz8.s3 == 2842757856) && (swiz8.s4 == 3098595886) && (swiz8.s5 == 1294175113) && (swiz8.s6 == 3065569579) && (swiz8.s7 == 2842757856) && (swiz8.s8 == 1575938509) && (swiz8.s9 == 2842757856) && (swiz8.sA == 3098595886) && (swiz8.sB == 2886561287) && (swiz8.sC == 1575938509) && (swiz8.sD == 2418988342) && (swiz8.sE == 2754092489) && (swiz8.sF == 3065569579)))
        return -1;

    uint2 a9 = (uint2) (934292485,1432550930);
    uint2 swizc9 = a9.s01;

    // results validation
    if (!((swizc9.x == 934292485) && (swizc9.y == 1432550930)))
        return -1;

    uint3 e9 = (uint3) (1687690652,2554672511,353926070);
    uint3 swize9 = e9.s200;

    // results validation
    if (!((swize9.x == 353926070) && (swize9.y == 1687690652) && (swize9.z == 1687690652)))
        return -1;

    uint4 b9 = (uint4) (708946135,72010339,297103208,3067112126);
    uint4 swizb9 = b9.s0333;

    // results validation
    if (!((swizb9.x == 708946135) && (swizb9.y == 3067112126) && (swizb9.z == 3067112126) && (swizb9.w == 3067112126)))
        return -1;

    uint8 c9 = (uint8) (358368833,1932621532,1938515760,2419332991,1650889170,4227646273,543986147,1696475100);
    uint8 swiza9 = c9.s03660664;

    // results validation
    if (!((swiza9.s0 == 358368833) && (swiza9.s1 == 2419332991) && (swiza9.s2 == 543986147) && (swiza9.s3 == 543986147) && (swiza9.s4 == 358368833) && (swiza9.s5 == 543986147) && (swiza9.s6 == 543986147) && (swiza9.s7 == 1650889170)))
        return -1;

    uint16 d9 = (uint16) (3746913626,1793110997,2356748133,1894319289,3082636081,3278360947,889942072,4181083820,532788292,3224372672,1075030029,2725782744,4201595857,428253478,2326940588,3985028300);
    uint16 swiz9 = d9.s1870639697363860;

    // results validation
    if (!((swiz9.s0 == 1793110997) && (swiz9.s1 == 532788292) && (swiz9.s2 == 4181083820) && (swiz9.s3 == 3746913626) && (swiz9.s4 == 889942072) && (swiz9.s5 == 1894319289) && (swiz9.s6 == 3224372672) && (swiz9.s7 == 889942072) && (swiz9.s8 == 3224372672) && (swiz9.s9 == 4181083820) && (swiz9.sA == 1894319289) && (swiz9.sB == 889942072) && (swiz9.sC == 1894319289) && (swiz9.sD == 532788292) && (swiz9.sE == 889942072) && (swiz9.sF == 3746913626)))
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
