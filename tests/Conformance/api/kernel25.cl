// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(
    long arg0, long arg1, long arg2, long arg3, long arg4, long arg5, long arg6,
    long arg7, long arg8, long arg9, long arg10, long arg11, long arg12,
    long arg13, long arg14, long arg15, long arg16, long arg17, long arg18,
    long arg19, long arg20, long arg21, long arg22, long arg23, long arg24,
    long arg25, long arg26, long arg27, long arg28, long arg29, long arg30,
    long arg31, long arg32, long arg33, long arg34, long arg35, long arg36,
    long arg37, long arg38, long arg39, long arg40, long arg41, long arg42,
    long arg43, long arg44, long arg45, long arg46, long arg47, long arg48,
    long arg49, long arg50, long arg51, long arg52, long arg53, long arg54,
    long arg55, long arg56, long arg57, long arg58, long arg59, long arg60,
    long arg61, long arg62, long arg63, long arg64, long arg65, long arg66,
    long arg67, long arg68, long arg69, long arg70, long arg71, long arg72,
    long arg73, long arg74, long arg75, long arg76, long arg77, long arg78,
    long arg79, long arg80, long arg81, long arg82, long arg83, long arg84,
    long arg85, long arg86, long arg87, long arg88, long arg89, long arg90,
    long arg91, long arg92, long arg93, long arg94, long arg95, long arg96,
    long arg97, long arg98, long arg99, long arg100, long arg101, long arg102,
    long arg103, long arg104, long arg105, long arg106, long arg107,
    long arg108, long arg109, long arg110, long arg111, long arg112,
    long arg113, long arg114, long arg115, long arg116, long arg117,
    long arg118, long arg119, long arg120, long arg121, long arg122,
    long arg123, long arg124, long arg125, long arg126, long arg127,
    long arg128, long arg129, long arg130, long arg131, long arg132,
    long arg133, long arg134, long arg135, long arg136, long arg137,
    long arg138, long arg139, long arg140, long arg141, long arg142,
    long arg143, long arg144, long arg145, long arg146, long arg147,
    long arg148, long arg149, long arg150, long arg151, long arg152,
    long arg153, long arg154, long arg155, long arg156, long arg157,
    long arg158, long arg159, long arg160, long arg161, long arg162,
    long arg163, long arg164, long arg165, long arg166, long arg167,
    long arg168, long arg169, long arg170, long arg171, long arg172,
    long arg173, long arg174, long arg175, long arg176, long arg177,
    long arg178, long arg179, long arg180, long arg181, long arg182,
    long arg183, long arg184, long arg185, long arg186, long arg187,
    long arg188, long arg189, long arg190, long arg191, long arg192,
    long arg193, long arg194, long arg195, long arg196, long arg197,
    long arg198, long arg199, long arg200, long arg201, long arg202,
    long arg203, long arg204, long arg205, long arg206, long arg207,
    long arg208, long arg209, long arg210, long arg211, long arg212,
    long arg213, long arg214, long arg215, long arg216, long arg217,
    long arg218, long arg219, long arg220, long arg221, long arg222,
    long arg223, long arg224, long arg225, long arg226, long arg227,
    long arg228, long arg229, long arg230, long arg231, long arg232,
    long arg233, long arg234, long arg235, long arg236, long arg237,
    long arg238, long arg239, long arg240, long arg241, long arg242,
    long arg243, long arg244, long arg245, long arg246, long arg247,
    long arg248, long arg249, long arg250, long arg251, long arg252,
    long arg253, long arg254, long arg255, long arg256, long arg257,
    long arg258, long arg259, long arg260, long arg261, long arg262,
    long arg263, long arg264, long arg265, long arg266, long arg267,
    long arg268, long arg269, long arg270, long arg271, long arg272,
    long arg273, long arg274, long arg275, long arg276, long arg277,
    long arg278, long arg279, long arg280, long arg281, long arg282,
    long arg283, long arg284, long arg285, long arg286, long arg287,
    long arg288, long arg289, long arg290, long arg291, long arg292,
    long arg293, long arg294, long arg295, long arg296, long arg297,
    long arg298, long arg299, long arg300, long arg301, long arg302,
    long arg303, long arg304, long arg305, long arg306, long arg307,
    long arg308, long arg309, long arg310, long arg311, long arg312,
    long arg313, long arg314, long arg315, long arg316, long arg317,
    long arg318, long arg319, long arg320, long arg321, long arg322,
    long arg323, long arg324, long arg325, long arg326, long arg327,
    long arg328, long arg329, long arg330, long arg331, long arg332,
    long arg333, long arg334, long arg335, long arg336, long arg337,
    long arg338, long arg339, long arg340, long arg341, long arg342,
    long arg343, long arg344, long arg345, long arg346, long arg347,
    long arg348, long arg349, long arg350, long arg351, long arg352,
    long arg353, long arg354, long arg355, long arg356, long arg357,
    long arg358, long arg359, long arg360, long arg361, long arg362,
    long arg363, long arg364, long arg365, long arg366, long arg367,
    long arg368, long arg369, long arg370, long arg371, long arg372,
    long arg373, long arg374, long arg375, long arg376, long arg377,
    long arg378, long arg379, long arg380, long arg381, long arg382,
    long arg383, long arg384, long arg385, long arg386, long arg387,
    long arg388, long arg389, long arg390, long arg391, long arg392,
    long arg393, long arg394, long arg395, long arg396, long arg397,
    long arg398, long arg399, long arg400, long arg401, long arg402,
    long arg403, long arg404, long arg405, long arg406, long arg407,
    long arg408, long arg409, long arg410, long arg411, long arg412,
    long arg413, long arg414, long arg415, long arg416, long arg417,
    long arg418, long arg419, long arg420, long arg421, long arg422,
    long arg423, long arg424, long arg425, long arg426, long arg427,
    long arg428, long arg429, long arg430, long arg431, long arg432,
    long arg433, long arg434, long arg435, long arg436, long arg437,
    long arg438, long arg439, long arg440, long arg441, long arg442,
    long arg443, long arg444, long arg445, long arg446, long arg447,
    long arg448, long arg449, long arg450, long arg451, long arg452,
    long arg453, long arg454, long arg455, long arg456, long arg457,
    long arg458, long arg459, long arg460, long arg461, long arg462,
    long arg463, long arg464, long arg465, long arg466, long arg467,
    long arg468, long arg469, long arg470, long arg471, long arg472,
    long arg473, long arg474, long arg475, long arg476, long arg477,
    long arg478, __global long *result) {
  result[0] = 0;
  result[0] += arg0;
  result[0] += arg1;
  result[0] += arg2;
  result[0] += arg3;
  result[0] += arg4;
  result[0] += arg5;
  result[0] += arg6;
  result[0] += arg7;
  result[0] += arg8;
  result[0] += arg9;
  result[0] += arg10;
  result[0] += arg11;
  result[0] += arg12;
  result[0] += arg13;
  result[0] += arg14;
  result[0] += arg15;
  result[0] += arg16;
  result[0] += arg17;
  result[0] += arg18;
  result[0] += arg19;
  result[0] += arg20;
  result[0] += arg21;
  result[0] += arg22;
  result[0] += arg23;
  result[0] += arg24;
  result[0] += arg25;
  result[0] += arg26;
  result[0] += arg27;
  result[0] += arg28;
  result[0] += arg29;
  result[0] += arg30;
  result[0] += arg31;
  result[0] += arg32;
  result[0] += arg33;
  result[0] += arg34;
  result[0] += arg35;
  result[0] += arg36;
  result[0] += arg37;
  result[0] += arg38;
  result[0] += arg39;
  result[0] += arg40;
  result[0] += arg41;
  result[0] += arg42;
  result[0] += arg43;
  result[0] += arg44;
  result[0] += arg45;
  result[0] += arg46;
  result[0] += arg47;
  result[0] += arg48;
  result[0] += arg49;
  result[0] += arg50;
  result[0] += arg51;
  result[0] += arg52;
  result[0] += arg53;
  result[0] += arg54;
  result[0] += arg55;
  result[0] += arg56;
  result[0] += arg57;
  result[0] += arg58;
  result[0] += arg59;
  result[0] += arg60;
  result[0] += arg61;
  result[0] += arg62;
  result[0] += arg63;
  result[0] += arg64;
  result[0] += arg65;
  result[0] += arg66;
  result[0] += arg67;
  result[0] += arg68;
  result[0] += arg69;
  result[0] += arg70;
  result[0] += arg71;
  result[0] += arg72;
  result[0] += arg73;
  result[0] += arg74;
  result[0] += arg75;
  result[0] += arg76;
  result[0] += arg77;
  result[0] += arg78;
  result[0] += arg79;
  result[0] += arg80;
  result[0] += arg81;
  result[0] += arg82;
  result[0] += arg83;
  result[0] += arg84;
  result[0] += arg85;
  result[0] += arg86;
  result[0] += arg87;
  result[0] += arg88;
  result[0] += arg89;
  result[0] += arg90;
  result[0] += arg91;
  result[0] += arg92;
  result[0] += arg93;
  result[0] += arg94;
  result[0] += arg95;
  result[0] += arg96;
  result[0] += arg97;
  result[0] += arg98;
  result[0] += arg99;
  result[0] += arg100;
  result[0] += arg101;
  result[0] += arg102;
  result[0] += arg103;
  result[0] += arg104;
  result[0] += arg105;
  result[0] += arg106;
  result[0] += arg107;
  result[0] += arg108;
  result[0] += arg109;
  result[0] += arg110;
  result[0] += arg111;
  result[0] += arg112;
  result[0] += arg113;
  result[0] += arg114;
  result[0] += arg115;
  result[0] += arg116;
  result[0] += arg117;
  result[0] += arg118;
  result[0] += arg119;
  result[0] += arg120;
  result[0] += arg121;
  result[0] += arg122;
  result[0] += arg123;
  result[0] += arg124;
  result[0] += arg125;
  result[0] += arg126;
  result[0] += arg127;
  result[0] += arg128;
  result[0] += arg129;
  result[0] += arg130;
  result[0] += arg131;
  result[0] += arg132;
  result[0] += arg133;
  result[0] += arg134;
  result[0] += arg135;
  result[0] += arg136;
  result[0] += arg137;
  result[0] += arg138;
  result[0] += arg139;
  result[0] += arg140;
  result[0] += arg141;
  result[0] += arg142;
  result[0] += arg143;
  result[0] += arg144;
  result[0] += arg145;
  result[0] += arg146;
  result[0] += arg147;
  result[0] += arg148;
  result[0] += arg149;
  result[0] += arg150;
  result[0] += arg151;
  result[0] += arg152;
  result[0] += arg153;
  result[0] += arg154;
  result[0] += arg155;
  result[0] += arg156;
  result[0] += arg157;
  result[0] += arg158;
  result[0] += arg159;
  result[0] += arg160;
  result[0] += arg161;
  result[0] += arg162;
  result[0] += arg163;
  result[0] += arg164;
  result[0] += arg165;
  result[0] += arg166;
  result[0] += arg167;
  result[0] += arg168;
  result[0] += arg169;
  result[0] += arg170;
  result[0] += arg171;
  result[0] += arg172;
  result[0] += arg173;
  result[0] += arg174;
  result[0] += arg175;
  result[0] += arg176;
  result[0] += arg177;
  result[0] += arg178;
  result[0] += arg179;
  result[0] += arg180;
  result[0] += arg181;
  result[0] += arg182;
  result[0] += arg183;
  result[0] += arg184;
  result[0] += arg185;
  result[0] += arg186;
  result[0] += arg187;
  result[0] += arg188;
  result[0] += arg189;
  result[0] += arg190;
  result[0] += arg191;
  result[0] += arg192;
  result[0] += arg193;
  result[0] += arg194;
  result[0] += arg195;
  result[0] += arg196;
  result[0] += arg197;
  result[0] += arg198;
  result[0] += arg199;
  result[0] += arg200;
  result[0] += arg201;
  result[0] += arg202;
  result[0] += arg203;
  result[0] += arg204;
  result[0] += arg205;
  result[0] += arg206;
  result[0] += arg207;
  result[0] += arg208;
  result[0] += arg209;
  result[0] += arg210;
  result[0] += arg211;
  result[0] += arg212;
  result[0] += arg213;
  result[0] += arg214;
  result[0] += arg215;
  result[0] += arg216;
  result[0] += arg217;
  result[0] += arg218;
  result[0] += arg219;
  result[0] += arg220;
  result[0] += arg221;
  result[0] += arg222;
  result[0] += arg223;
  result[0] += arg224;
  result[0] += arg225;
  result[0] += arg226;
  result[0] += arg227;
  result[0] += arg228;
  result[0] += arg229;
  result[0] += arg230;
  result[0] += arg231;
  result[0] += arg232;
  result[0] += arg233;
  result[0] += arg234;
  result[0] += arg235;
  result[0] += arg236;
  result[0] += arg237;
  result[0] += arg238;
  result[0] += arg239;
  result[0] += arg240;
  result[0] += arg241;
  result[0] += arg242;
  result[0] += arg243;
  result[0] += arg244;
  result[0] += arg245;
  result[0] += arg246;
  result[0] += arg247;
  result[0] += arg248;
  result[0] += arg249;
  result[0] += arg250;
  result[0] += arg251;
  result[0] += arg252;
  result[0] += arg253;
  result[0] += arg254;
  result[0] += arg255;
  result[0] += arg256;
  result[0] += arg257;
  result[0] += arg258;
  result[0] += arg259;
  result[0] += arg260;
  result[0] += arg261;
  result[0] += arg262;
  result[0] += arg263;
  result[0] += arg264;
  result[0] += arg265;
  result[0] += arg266;
  result[0] += arg267;
  result[0] += arg268;
  result[0] += arg269;
  result[0] += arg270;
  result[0] += arg271;
  result[0] += arg272;
  result[0] += arg273;
  result[0] += arg274;
  result[0] += arg275;
  result[0] += arg276;
  result[0] += arg277;
  result[0] += arg278;
  result[0] += arg279;
  result[0] += arg280;
  result[0] += arg281;
  result[0] += arg282;
  result[0] += arg283;
  result[0] += arg284;
  result[0] += arg285;
  result[0] += arg286;
  result[0] += arg287;
  result[0] += arg288;
  result[0] += arg289;
  result[0] += arg290;
  result[0] += arg291;
  result[0] += arg292;
  result[0] += arg293;
  result[0] += arg294;
  result[0] += arg295;
  result[0] += arg296;
  result[0] += arg297;
  result[0] += arg298;
  result[0] += arg299;
  result[0] += arg300;
  result[0] += arg301;
  result[0] += arg302;
  result[0] += arg303;
  result[0] += arg304;
  result[0] += arg305;
  result[0] += arg306;
  result[0] += arg307;
  result[0] += arg308;
  result[0] += arg309;
  result[0] += arg310;
  result[0] += arg311;
  result[0] += arg312;
  result[0] += arg313;
  result[0] += arg314;
  result[0] += arg315;
  result[0] += arg316;
  result[0] += arg317;
  result[0] += arg318;
  result[0] += arg319;
  result[0] += arg320;
  result[0] += arg321;
  result[0] += arg322;
  result[0] += arg323;
  result[0] += arg324;
  result[0] += arg325;
  result[0] += arg326;
  result[0] += arg327;
  result[0] += arg328;
  result[0] += arg329;
  result[0] += arg330;
  result[0] += arg331;
  result[0] += arg332;
  result[0] += arg333;
  result[0] += arg334;
  result[0] += arg335;
  result[0] += arg336;
  result[0] += arg337;
  result[0] += arg338;
  result[0] += arg339;
  result[0] += arg340;
  result[0] += arg341;
  result[0] += arg342;
  result[0] += arg343;
  result[0] += arg344;
  result[0] += arg345;
  result[0] += arg346;
  result[0] += arg347;
  result[0] += arg348;
  result[0] += arg349;
  result[0] += arg350;
  result[0] += arg351;
  result[0] += arg352;
  result[0] += arg353;
  result[0] += arg354;
  result[0] += arg355;
  result[0] += arg356;
  result[0] += arg357;
  result[0] += arg358;
  result[0] += arg359;
  result[0] += arg360;
  result[0] += arg361;
  result[0] += arg362;
  result[0] += arg363;
  result[0] += arg364;
  result[0] += arg365;
  result[0] += arg366;
  result[0] += arg367;
  result[0] += arg368;
  result[0] += arg369;
  result[0] += arg370;
  result[0] += arg371;
  result[0] += arg372;
  result[0] += arg373;
  result[0] += arg374;
  result[0] += arg375;
  result[0] += arg376;
  result[0] += arg377;
  result[0] += arg378;
  result[0] += arg379;
  result[0] += arg380;
  result[0] += arg381;
  result[0] += arg382;
  result[0] += arg383;
  result[0] += arg384;
  result[0] += arg385;
  result[0] += arg386;
  result[0] += arg387;
  result[0] += arg388;
  result[0] += arg389;
  result[0] += arg390;
  result[0] += arg391;
  result[0] += arg392;
  result[0] += arg393;
  result[0] += arg394;
  result[0] += arg395;
  result[0] += arg396;
  result[0] += arg397;
  result[0] += arg398;
  result[0] += arg399;
  result[0] += arg400;
  result[0] += arg401;
  result[0] += arg402;
  result[0] += arg403;
  result[0] += arg404;
  result[0] += arg405;
  result[0] += arg406;
  result[0] += arg407;
  result[0] += arg408;
  result[0] += arg409;
  result[0] += arg410;
  result[0] += arg411;
  result[0] += arg412;
  result[0] += arg413;
  result[0] += arg414;
  result[0] += arg415;
  result[0] += arg416;
  result[0] += arg417;
  result[0] += arg418;
  result[0] += arg419;
  result[0] += arg420;
  result[0] += arg421;
  result[0] += arg422;
  result[0] += arg423;
  result[0] += arg424;
  result[0] += arg425;
  result[0] += arg426;
  result[0] += arg427;
  result[0] += arg428;
  result[0] += arg429;
  result[0] += arg430;
  result[0] += arg431;
  result[0] += arg432;
  result[0] += arg433;
  result[0] += arg434;
  result[0] += arg435;
  result[0] += arg436;
  result[0] += arg437;
  result[0] += arg438;
  result[0] += arg439;
  result[0] += arg440;
  result[0] += arg441;
  result[0] += arg442;
  result[0] += arg443;
  result[0] += arg444;
  result[0] += arg445;
  result[0] += arg446;
  result[0] += arg447;
  result[0] += arg448;
  result[0] += arg449;
  result[0] += arg450;
  result[0] += arg451;
  result[0] += arg452;
  result[0] += arg453;
  result[0] += arg454;
  result[0] += arg455;
  result[0] += arg456;
  result[0] += arg457;
  result[0] += arg458;
  result[0] += arg459;
  result[0] += arg460;
  result[0] += arg461;
  result[0] += arg462;
  result[0] += arg463;
  result[0] += arg464;
  result[0] += arg465;
  result[0] += arg466;
  result[0] += arg467;
  result[0] += arg468;
  result[0] += arg469;
  result[0] += arg470;
  result[0] += arg471;
  result[0] += arg472;
  result[0] += arg473;
  result[0] += arg474;
  result[0] += arg475;
  result[0] += arg476;
  result[0] += arg477;
  result[0] += arg478;
}
