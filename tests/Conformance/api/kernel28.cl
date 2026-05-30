// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(
    __constant int *src1, __constant int *src2, __constant int *src3,
    __constant int *src4, __constant int *src5, __constant int *src6,
    __constant int *src7, __constant int *src8, __constant int *src9,
    __constant int *src10, __constant int *src11, __constant int *src12,
    __constant int *src13, __constant int *src14, __constant int *src15,
    __constant int *src16, __constant int *src17, __constant int *src18,
    __constant int *src19, __constant int *src20, __constant int *src21,
    __constant int *src22, __constant int *src23, __constant int *src24,
    __constant int *src25, __constant int *src26, __constant int *src27,
    __constant int *src28, __constant int *src29, __constant int *src30,
    __constant int *src31, __constant int *src32, __constant int *src33,
    __constant int *src34, __constant int *src35, __constant int *src36,
    __constant int *src37, __constant int *src38, __constant int *src39,
    __constant int *src40, __constant int *src41, __constant int *src42,
    __constant int *src43, __constant int *src44, __constant int *src45,
    __constant int *src46, __constant int *src47, __constant int *src48,
    __constant int *src49, __constant int *src50, __constant int *src51,
    __constant int *src52, __constant int *src53, __constant int *src54,
    __constant int *src55, __constant int *src56, __constant int *src57,
    __constant int *src58, __constant int *src59, __constant int *src60,
    __constant int *src61, __constant int *src62, __constant int *src63,
    __constant int *src64, __constant int *src65, __constant int *src66,
    __constant int *src67, __constant int *src68, __constant int *src69,
    __constant int *src70, __constant int *src71, __constant int *src72,
    __constant int *src73, __constant int *src74, __constant int *src75,
    __constant int *src76, __constant int *src77, __constant int *src78,
    __constant int *src79, __constant int *src80, __constant int *src81,
    __constant int *src82, __constant int *src83, __constant int *src84,
    __constant int *src85, __constant int *src86, __constant int *src87,
    __constant int *src88, __constant int *src89, __constant int *src90,
    __constant int *src91, __constant int *src92, __constant int *src93,
    __constant int *src94, __constant int *src95, __constant int *src96,
    __constant int *src97, __constant int *src98, __constant int *src99,
    __constant int *src100, __constant int *src101, __constant int *src102,
    __constant int *src103, __constant int *src104, __constant int *src105,
    __constant int *src106, __constant int *src107, __constant int *src108,
    __constant int *src109, __constant int *src110, __constant int *src111,
    __constant int *src112, __constant int *src113, __constant int *src114,
    __constant int *src115, __constant int *src116, __constant int *src117,
    __constant int *src118, __constant int *src119, __constant int *src120,
    __constant int *src121, __constant int *src122, __constant int *src123,
    __constant int *src124, __constant int *src125, __constant int *src126,
    __constant int *src127, __constant int *src128, __constant int *src129,
    __constant int *src130, __constant int *src131, __constant int *src132,
    __constant int *src133, __constant int *src134, __constant int *src135,
    __constant int *src136, __constant int *src137, __constant int *src138,
    __constant int *src139, __constant int *src140, __constant int *src141,
    __constant int *src142, __constant int *src143, __constant int *src144,
    __constant int *src145, __constant int *src146, __constant int *src147,
    __constant int *src148, __constant int *src149, __constant int *src150,
    __constant int *src151, __constant int *src152, __constant int *src153,
    __constant int *src154, __constant int *src155, __constant int *src156,
    __constant int *src157, __constant int *src158, __constant int *src159,
    __constant int *src160, __constant int *src161, __constant int *src162,
    __constant int *src163, __constant int *src164, __constant int *src165,
    __constant int *src166, __constant int *src167, __constant int *src168,
    __constant int *src169, __constant int *src170, __constant int *src171,
    __constant int *src172, __constant int *src173, __constant int *src174,
    __constant int *src175, __constant int *src176, __constant int *src177,
    __constant int *src178, __constant int *src179, __constant int *src180,
    __constant int *src181, __constant int *src182, __constant int *src183,
    __constant int *src184, __constant int *src185, __constant int *src186,
    __constant int *src187, __constant int *src188, __constant int *src189,
    __constant int *src190, __constant int *src191, __constant int *src192,
    __constant int *src193, __constant int *src194, __constant int *src195,
    __constant int *src196, __constant int *src197, __constant int *src198,
    __constant int *src199, __constant int *src200, __constant int *src201,
    __constant int *src202, __constant int *src203, __constant int *src204,
    __constant int *src205, __constant int *src206, __constant int *src207,
    __constant int *src208, __constant int *src209, __constant int *src210,
    __constant int *src211, __constant int *src212, __constant int *src213,
    __constant int *src214, __constant int *src215, __constant int *src216,
    __constant int *src217, __constant int *src218, __constant int *src219,
    __constant int *src220, __constant int *src221, __constant int *src222,
    __constant int *src223, __constant int *src224, __constant int *src225,
    __constant int *src226, __constant int *src227, __constant int *src228,
    __constant int *src229, __constant int *src230, __constant int *src231,
    __constant int *src232, __constant int *src233, __constant int *src234,
    __constant int *src235, __constant int *src236, __constant int *src237,
    __constant int *src238, __constant int *src239, __constant int *src240,
    __constant int *src241, __constant int *src242, __constant int *src243,
    __constant int *src244, __constant int *src245, __constant int *src246,
    __constant int *src247, __constant int *src248, __constant int *src249,
    __constant int *src250, __constant int *src251, __constant int *src252,
    __constant int *src253, __constant int *src254, __constant int *src255,
    __constant int *src256, __constant int *src257, __constant int *src258,
    __constant int *src259, __constant int *src260, __constant int *src261,
    __constant int *src262, __constant int *src263, __constant int *src264,
    __constant int *src265, __constant int *src266, __constant int *src267,
    __constant int *src268, __constant int *src269, __constant int *src270,
    __constant int *src271, __constant int *src272, __constant int *src273,
    __constant int *src274, __constant int *src275, __constant int *src276,
    __constant int *src277, __constant int *src278, __constant int *src279,
    __constant int *src280, __constant int *src281, __constant int *src282,
    __constant int *src283, __constant int *src284, __constant int *src285,
    __constant int *src286, __constant int *src287, __constant int *src288,
    __constant int *src289, __constant int *src290, __constant int *src291,
    __constant int *src292, __constant int *src293, __constant int *src294,
    __constant int *src295, __constant int *src296, __constant int *src297,
    __constant int *src298, __constant int *src299, __constant int *src300,
    __constant int *src301, __constant int *src302, __constant int *src303,
    __constant int *src304, __constant int *src305, __constant int *src306,
    __constant int *src307, __constant int *src308, __constant int *src309,
    __constant int *src310, __constant int *src311, __constant int *src312,
    __constant int *src313, __constant int *src314, __constant int *src315,
    __constant int *src316, __constant int *src317, __constant int *src318,
    __constant int *src319, __constant int *src320, __constant int *src321,
    __constant int *src322, __constant int *src323, __constant int *src324,
    __constant int *src325, __constant int *src326, __constant int *src327,
    __constant int *src328, __constant int *src329, __constant int *src330,
    __constant int *src331, __constant int *src332, __constant int *src333,
    __constant int *src334, __constant int *src335, __constant int *src336,
    __constant int *src337, __constant int *src338, __constant int *src339,
    __constant int *src340, __constant int *src341, __constant int *src342,
    __constant int *src343, __constant int *src344, __constant int *src345,
    __constant int *src346, __constant int *src347, __constant int *src348,
    __constant int *src349, __constant int *src350, __constant int *src351,
    __constant int *src352, __constant int *src353, __constant int *src354,
    __constant int *src355, __constant int *src356, __constant int *src357,
    __constant int *src358, __constant int *src359, __constant int *src360,
    __constant int *src361, __constant int *src362, __constant int *src363,
    __constant int *src364, __constant int *src365, __constant int *src366,
    __constant int *src367, __constant int *src368, __constant int *src369,
    __constant int *src370, __constant int *src371, __constant int *src372,
    __constant int *src373, __constant int *src374, __constant int *src375,
    __constant int *src376, __constant int *src377, __constant int *src378,
    __constant int *src379, __constant int *src380, __constant int *src381,
    __constant int *src382, __constant int *src383, __constant int *src384,
    __constant int *src385, __constant int *src386, __constant int *src387,
    __constant int *src388, __constant int *src389, __constant int *src390,
    __constant int *src391, __constant int *src392, __constant int *src393,
    __constant int *src394, __constant int *src395, __constant int *src396,
    __constant int *src397, __constant int *src398, __constant int *src399,
    __constant int *src400, __constant int *src401, __constant int *src402,
    __constant int *src403, __constant int *src404, __constant int *src405,
    __constant int *src406, __constant int *src407, __constant int *src408,
    __constant int *src409, __constant int *src410, __constant int *src411,
    __constant int *src412, __constant int *src413, __constant int *src414,
    __constant int *src415, __constant int *src416, __constant int *src417,
    __constant int *src418, __constant int *src419, __constant int *src420,
    __constant int *src421, __constant int *src422, __constant int *src423,
    __constant int *src424, __constant int *src425, __constant int *src426,
    __constant int *src427, __constant int *src428, __constant int *src429,
    __constant int *src430, __constant int *src431, __constant int *src432,
    __constant int *src433, __constant int *src434, __constant int *src435,
    __constant int *src436, __constant int *src437, __constant int *src438,
    __constant int *src439, __constant int *src440, __constant int *src441,
    __constant int *src442, __constant int *src443, __constant int *src444,
    __constant int *src445, __constant int *src446, __constant int *src447,
    __constant int *src448, __constant int *src449, __constant int *src450,
    __constant int *src451, __constant int *src452, __constant int *src453,
    __constant int *src454, __constant int *src455, __constant int *src456,
    __constant int *src457, __constant int *src458, __constant int *src459,
    __constant int *src460, __constant int *src461, __constant int *src462,
    __constant int *src463, __constant int *src464, __constant int *src465,
    __constant int *src466, __constant int *src467, __constant int *src468,
    __constant int *src469, __constant int *src470, __constant int *src471,
    __constant int *src472, __constant int *src473, __constant int *src474,
    __constant int *src475, __constant int *src476, __constant int *src477,
    __constant int *src478, __constant int *src479, __constant int *src480,
    __global int *dst) {
  int tid = get_global_id(0);

  dst[tid] = src1[tid];
  dst[tid] += src2[tid];
  dst[tid] += src3[tid];
  dst[tid] += src4[tid];
  dst[tid] += src5[tid];
  dst[tid] += src6[tid];
  dst[tid] += src7[tid];
  dst[tid] += src8[tid];
  dst[tid] += src9[tid];
  dst[tid] += src10[tid];
  dst[tid] += src11[tid];
  dst[tid] += src12[tid];
  dst[tid] += src13[tid];
  dst[tid] += src14[tid];
  dst[tid] += src15[tid];
  dst[tid] += src16[tid];
  dst[tid] += src17[tid];
  dst[tid] += src18[tid];
  dst[tid] += src19[tid];
  dst[tid] += src20[tid];
  dst[tid] += src21[tid];
  dst[tid] += src22[tid];
  dst[tid] += src23[tid];
  dst[tid] += src24[tid];
  dst[tid] += src25[tid];
  dst[tid] += src26[tid];
  dst[tid] += src27[tid];
  dst[tid] += src28[tid];
  dst[tid] += src29[tid];
  dst[tid] += src30[tid];
  dst[tid] += src31[tid];
  dst[tid] += src32[tid];
  dst[tid] += src33[tid];
  dst[tid] += src34[tid];
  dst[tid] += src35[tid];
  dst[tid] += src36[tid];
  dst[tid] += src37[tid];
  dst[tid] += src38[tid];
  dst[tid] += src39[tid];
  dst[tid] += src40[tid];
  dst[tid] += src41[tid];
  dst[tid] += src42[tid];
  dst[tid] += src43[tid];
  dst[tid] += src44[tid];
  dst[tid] += src45[tid];
  dst[tid] += src46[tid];
  dst[tid] += src47[tid];
  dst[tid] += src48[tid];
  dst[tid] += src49[tid];
  dst[tid] += src50[tid];
  dst[tid] += src51[tid];
  dst[tid] += src52[tid];
  dst[tid] += src53[tid];
  dst[tid] += src54[tid];
  dst[tid] += src55[tid];
  dst[tid] += src56[tid];
  dst[tid] += src57[tid];
  dst[tid] += src58[tid];
  dst[tid] += src59[tid];
  dst[tid] += src60[tid];
  dst[tid] += src61[tid];
  dst[tid] += src62[tid];
  dst[tid] += src63[tid];
  dst[tid] += src64[tid];
  dst[tid] += src65[tid];
  dst[tid] += src66[tid];
  dst[tid] += src67[tid];
  dst[tid] += src68[tid];
  dst[tid] += src69[tid];
  dst[tid] += src70[tid];
  dst[tid] += src71[tid];
  dst[tid] += src72[tid];
  dst[tid] += src73[tid];
  dst[tid] += src74[tid];
  dst[tid] += src75[tid];
  dst[tid] += src76[tid];
  dst[tid] += src77[tid];
  dst[tid] += src78[tid];
  dst[tid] += src79[tid];
  dst[tid] += src80[tid];
  dst[tid] += src81[tid];
  dst[tid] += src82[tid];
  dst[tid] += src83[tid];
  dst[tid] += src84[tid];
  dst[tid] += src85[tid];
  dst[tid] += src86[tid];
  dst[tid] += src87[tid];
  dst[tid] += src88[tid];
  dst[tid] += src89[tid];
  dst[tid] += src90[tid];
  dst[tid] += src91[tid];
  dst[tid] += src92[tid];
  dst[tid] += src93[tid];
  dst[tid] += src94[tid];
  dst[tid] += src95[tid];
  dst[tid] += src96[tid];
  dst[tid] += src97[tid];
  dst[tid] += src98[tid];
  dst[tid] += src99[tid];
  dst[tid] += src100[tid];
  dst[tid] += src101[tid];
  dst[tid] += src102[tid];
  dst[tid] += src103[tid];
  dst[tid] += src104[tid];
  dst[tid] += src105[tid];
  dst[tid] += src106[tid];
  dst[tid] += src107[tid];
  dst[tid] += src108[tid];
  dst[tid] += src109[tid];
  dst[tid] += src110[tid];
  dst[tid] += src111[tid];
  dst[tid] += src112[tid];
  dst[tid] += src113[tid];
  dst[tid] += src114[tid];
  dst[tid] += src115[tid];
  dst[tid] += src116[tid];
  dst[tid] += src117[tid];
  dst[tid] += src118[tid];
  dst[tid] += src119[tid];
  dst[tid] += src120[tid];
  dst[tid] += src121[tid];
  dst[tid] += src122[tid];
  dst[tid] += src123[tid];
  dst[tid] += src124[tid];
  dst[tid] += src125[tid];
  dst[tid] += src126[tid];
  dst[tid] += src127[tid];
  dst[tid] += src128[tid];
  dst[tid] += src129[tid];
  dst[tid] += src130[tid];
  dst[tid] += src131[tid];
  dst[tid] += src132[tid];
  dst[tid] += src133[tid];
  dst[tid] += src134[tid];
  dst[tid] += src135[tid];
  dst[tid] += src136[tid];
  dst[tid] += src137[tid];
  dst[tid] += src138[tid];
  dst[tid] += src139[tid];
  dst[tid] += src140[tid];
  dst[tid] += src141[tid];
  dst[tid] += src142[tid];
  dst[tid] += src143[tid];
  dst[tid] += src144[tid];
  dst[tid] += src145[tid];
  dst[tid] += src146[tid];
  dst[tid] += src147[tid];
  dst[tid] += src148[tid];
  dst[tid] += src149[tid];
  dst[tid] += src150[tid];
  dst[tid] += src151[tid];
  dst[tid] += src152[tid];
  dst[tid] += src153[tid];
  dst[tid] += src154[tid];
  dst[tid] += src155[tid];
  dst[tid] += src156[tid];
  dst[tid] += src157[tid];
  dst[tid] += src158[tid];
  dst[tid] += src159[tid];
  dst[tid] += src160[tid];
  dst[tid] += src161[tid];
  dst[tid] += src162[tid];
  dst[tid] += src163[tid];
  dst[tid] += src164[tid];
  dst[tid] += src165[tid];
  dst[tid] += src166[tid];
  dst[tid] += src167[tid];
  dst[tid] += src168[tid];
  dst[tid] += src169[tid];
  dst[tid] += src170[tid];
  dst[tid] += src171[tid];
  dst[tid] += src172[tid];
  dst[tid] += src173[tid];
  dst[tid] += src174[tid];
  dst[tid] += src175[tid];
  dst[tid] += src176[tid];
  dst[tid] += src177[tid];
  dst[tid] += src178[tid];
  dst[tid] += src179[tid];
  dst[tid] += src180[tid];
  dst[tid] += src181[tid];
  dst[tid] += src182[tid];
  dst[tid] += src183[tid];
  dst[tid] += src184[tid];
  dst[tid] += src185[tid];
  dst[tid] += src186[tid];
  dst[tid] += src187[tid];
  dst[tid] += src188[tid];
  dst[tid] += src189[tid];
  dst[tid] += src190[tid];
  dst[tid] += src191[tid];
  dst[tid] += src192[tid];
  dst[tid] += src193[tid];
  dst[tid] += src194[tid];
  dst[tid] += src195[tid];
  dst[tid] += src196[tid];
  dst[tid] += src197[tid];
  dst[tid] += src198[tid];
  dst[tid] += src199[tid];
  dst[tid] += src200[tid];
  dst[tid] += src201[tid];
  dst[tid] += src202[tid];
  dst[tid] += src203[tid];
  dst[tid] += src204[tid];
  dst[tid] += src205[tid];
  dst[tid] += src206[tid];
  dst[tid] += src207[tid];
  dst[tid] += src208[tid];
  dst[tid] += src209[tid];
  dst[tid] += src210[tid];
  dst[tid] += src211[tid];
  dst[tid] += src212[tid];
  dst[tid] += src213[tid];
  dst[tid] += src214[tid];
  dst[tid] += src215[tid];
  dst[tid] += src216[tid];
  dst[tid] += src217[tid];
  dst[tid] += src218[tid];
  dst[tid] += src219[tid];
  dst[tid] += src220[tid];
  dst[tid] += src221[tid];
  dst[tid] += src222[tid];
  dst[tid] += src223[tid];
  dst[tid] += src224[tid];
  dst[tid] += src225[tid];
  dst[tid] += src226[tid];
  dst[tid] += src227[tid];
  dst[tid] += src228[tid];
  dst[tid] += src229[tid];
  dst[tid] += src230[tid];
  dst[tid] += src231[tid];
  dst[tid] += src232[tid];
  dst[tid] += src233[tid];
  dst[tid] += src234[tid];
  dst[tid] += src235[tid];
  dst[tid] += src236[tid];
  dst[tid] += src237[tid];
  dst[tid] += src238[tid];
  dst[tid] += src239[tid];
  dst[tid] += src240[tid];
  dst[tid] += src241[tid];
  dst[tid] += src242[tid];
  dst[tid] += src243[tid];
  dst[tid] += src244[tid];
  dst[tid] += src245[tid];
  dst[tid] += src246[tid];
  dst[tid] += src247[tid];
  dst[tid] += src248[tid];
  dst[tid] += src249[tid];
  dst[tid] += src250[tid];
  dst[tid] += src251[tid];
  dst[tid] += src252[tid];
  dst[tid] += src253[tid];
  dst[tid] += src254[tid];
  dst[tid] += src255[tid];
  dst[tid] += src256[tid];
  dst[tid] += src257[tid];
  dst[tid] += src258[tid];
  dst[tid] += src259[tid];
  dst[tid] += src260[tid];
  dst[tid] += src261[tid];
  dst[tid] += src262[tid];
  dst[tid] += src263[tid];
  dst[tid] += src264[tid];
  dst[tid] += src265[tid];
  dst[tid] += src266[tid];
  dst[tid] += src267[tid];
  dst[tid] += src268[tid];
  dst[tid] += src269[tid];
  dst[tid] += src270[tid];
  dst[tid] += src271[tid];
  dst[tid] += src272[tid];
  dst[tid] += src273[tid];
  dst[tid] += src274[tid];
  dst[tid] += src275[tid];
  dst[tid] += src276[tid];
  dst[tid] += src277[tid];
  dst[tid] += src278[tid];
  dst[tid] += src279[tid];
  dst[tid] += src280[tid];
  dst[tid] += src281[tid];
  dst[tid] += src282[tid];
  dst[tid] += src283[tid];
  dst[tid] += src284[tid];
  dst[tid] += src285[tid];
  dst[tid] += src286[tid];
  dst[tid] += src287[tid];
  dst[tid] += src288[tid];
  dst[tid] += src289[tid];
  dst[tid] += src290[tid];
  dst[tid] += src291[tid];
  dst[tid] += src292[tid];
  dst[tid] += src293[tid];
  dst[tid] += src294[tid];
  dst[tid] += src295[tid];
  dst[tid] += src296[tid];
  dst[tid] += src297[tid];
  dst[tid] += src298[tid];
  dst[tid] += src299[tid];
  dst[tid] += src300[tid];
  dst[tid] += src301[tid];
  dst[tid] += src302[tid];
  dst[tid] += src303[tid];
  dst[tid] += src304[tid];
  dst[tid] += src305[tid];
  dst[tid] += src306[tid];
  dst[tid] += src307[tid];
  dst[tid] += src308[tid];
  dst[tid] += src309[tid];
  dst[tid] += src310[tid];
  dst[tid] += src311[tid];
  dst[tid] += src312[tid];
  dst[tid] += src313[tid];
  dst[tid] += src314[tid];
  dst[tid] += src315[tid];
  dst[tid] += src316[tid];
  dst[tid] += src317[tid];
  dst[tid] += src318[tid];
  dst[tid] += src319[tid];
  dst[tid] += src320[tid];
  dst[tid] += src321[tid];
  dst[tid] += src322[tid];
  dst[tid] += src323[tid];
  dst[tid] += src324[tid];
  dst[tid] += src325[tid];
  dst[tid] += src326[tid];
  dst[tid] += src327[tid];
  dst[tid] += src328[tid];
  dst[tid] += src329[tid];
  dst[tid] += src330[tid];
  dst[tid] += src331[tid];
  dst[tid] += src332[tid];
  dst[tid] += src333[tid];
  dst[tid] += src334[tid];
  dst[tid] += src335[tid];
  dst[tid] += src336[tid];
  dst[tid] += src337[tid];
  dst[tid] += src338[tid];
  dst[tid] += src339[tid];
  dst[tid] += src340[tid];
  dst[tid] += src341[tid];
  dst[tid] += src342[tid];
  dst[tid] += src343[tid];
  dst[tid] += src344[tid];
  dst[tid] += src345[tid];
  dst[tid] += src346[tid];
  dst[tid] += src347[tid];
  dst[tid] += src348[tid];
  dst[tid] += src349[tid];
  dst[tid] += src350[tid];
  dst[tid] += src351[tid];
  dst[tid] += src352[tid];
  dst[tid] += src353[tid];
  dst[tid] += src354[tid];
  dst[tid] += src355[tid];
  dst[tid] += src356[tid];
  dst[tid] += src357[tid];
  dst[tid] += src358[tid];
  dst[tid] += src359[tid];
  dst[tid] += src360[tid];
  dst[tid] += src361[tid];
  dst[tid] += src362[tid];
  dst[tid] += src363[tid];
  dst[tid] += src364[tid];
  dst[tid] += src365[tid];
  dst[tid] += src366[tid];
  dst[tid] += src367[tid];
  dst[tid] += src368[tid];
  dst[tid] += src369[tid];
  dst[tid] += src370[tid];
  dst[tid] += src371[tid];
  dst[tid] += src372[tid];
  dst[tid] += src373[tid];
  dst[tid] += src374[tid];
  dst[tid] += src375[tid];
  dst[tid] += src376[tid];
  dst[tid] += src377[tid];
  dst[tid] += src378[tid];
  dst[tid] += src379[tid];
  dst[tid] += src380[tid];
  dst[tid] += src381[tid];
  dst[tid] += src382[tid];
  dst[tid] += src383[tid];
  dst[tid] += src384[tid];
  dst[tid] += src385[tid];
  dst[tid] += src386[tid];
  dst[tid] += src387[tid];
  dst[tid] += src388[tid];
  dst[tid] += src389[tid];
  dst[tid] += src390[tid];
  dst[tid] += src391[tid];
  dst[tid] += src392[tid];
  dst[tid] += src393[tid];
  dst[tid] += src394[tid];
  dst[tid] += src395[tid];
  dst[tid] += src396[tid];
  dst[tid] += src397[tid];
  dst[tid] += src398[tid];
  dst[tid] += src399[tid];
  dst[tid] += src400[tid];
  dst[tid] += src401[tid];
  dst[tid] += src402[tid];
  dst[tid] += src403[tid];
  dst[tid] += src404[tid];
  dst[tid] += src405[tid];
  dst[tid] += src406[tid];
  dst[tid] += src407[tid];
  dst[tid] += src408[tid];
  dst[tid] += src409[tid];
  dst[tid] += src410[tid];
  dst[tid] += src411[tid];
  dst[tid] += src412[tid];
  dst[tid] += src413[tid];
  dst[tid] += src414[tid];
  dst[tid] += src415[tid];
  dst[tid] += src416[tid];
  dst[tid] += src417[tid];
  dst[tid] += src418[tid];
  dst[tid] += src419[tid];
  dst[tid] += src420[tid];
  dst[tid] += src421[tid];
  dst[tid] += src422[tid];
  dst[tid] += src423[tid];
  dst[tid] += src424[tid];
  dst[tid] += src425[tid];
  dst[tid] += src426[tid];
  dst[tid] += src427[tid];
  dst[tid] += src428[tid];
  dst[tid] += src429[tid];
  dst[tid] += src430[tid];
  dst[tid] += src431[tid];
  dst[tid] += src432[tid];
  dst[tid] += src433[tid];
  dst[tid] += src434[tid];
  dst[tid] += src435[tid];
  dst[tid] += src436[tid];
  dst[tid] += src437[tid];
  dst[tid] += src438[tid];
  dst[tid] += src439[tid];
  dst[tid] += src440[tid];
  dst[tid] += src441[tid];
  dst[tid] += src442[tid];
  dst[tid] += src443[tid];
  dst[tid] += src444[tid];
  dst[tid] += src445[tid];
  dst[tid] += src446[tid];
  dst[tid] += src447[tid];
  dst[tid] += src448[tid];
  dst[tid] += src449[tid];
  dst[tid] += src450[tid];
  dst[tid] += src451[tid];
  dst[tid] += src452[tid];
  dst[tid] += src453[tid];
  dst[tid] += src454[tid];
  dst[tid] += src455[tid];
  dst[tid] += src456[tid];
  dst[tid] += src457[tid];
  dst[tid] += src458[tid];
  dst[tid] += src459[tid];
  dst[tid] += src460[tid];
  dst[tid] += src461[tid];
  dst[tid] += src462[tid];
  dst[tid] += src463[tid];
  dst[tid] += src464[tid];
  dst[tid] += src465[tid];
  dst[tid] += src466[tid];
  dst[tid] += src467[tid];
  dst[tid] += src468[tid];
  dst[tid] += src469[tid];
  dst[tid] += src470[tid];
  dst[tid] += src471[tid];
  dst[tid] += src472[tid];
  dst[tid] += src473[tid];
  dst[tid] += src474[tid];
  dst[tid] += src475[tid];
  dst[tid] += src476[tid];
  dst[tid] += src477[tid];
  dst[tid] += src478[tid];
  dst[tid] += src479[tid];
  dst[tid] += src480[tid];
}
