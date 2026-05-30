// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void
sample_test(write_only image2d_t dstimg0, write_only image2d_t dstimg1,
            write_only image2d_t dstimg2, write_only image2d_t dstimg3,
            write_only image2d_t dstimg4, write_only image2d_t dstimg5,
            write_only image2d_t dstimg6, write_only image2d_t dstimg7,
            write_only image2d_t dstimg8, write_only image2d_t dstimg9,
            write_only image2d_t dstimg10, write_only image2d_t dstimg11,
            write_only image2d_t dstimg12, write_only image2d_t dstimg13,
            write_only image2d_t dstimg14, write_only image2d_t dstimg15,
            write_only image2d_t dstimg16, write_only image2d_t dstimg17,
            write_only image2d_t dstimg18, write_only image2d_t dstimg19,
            write_only image2d_t dstimg20, write_only image2d_t dstimg21,
            write_only image2d_t dstimg22, write_only image2d_t dstimg23,
            write_only image2d_t dstimg24, write_only image2d_t dstimg25,
            write_only image2d_t dstimg26, write_only image2d_t dstimg27,
            write_only image2d_t dstimg28, write_only image2d_t dstimg29,
            write_only image2d_t dstimg30, write_only image2d_t dstimg31,
            write_only image2d_t dstimg32, write_only image2d_t dstimg33,
            write_only image2d_t dstimg34, write_only image2d_t dstimg35,
            write_only image2d_t dstimg36, write_only image2d_t dstimg37,
            write_only image2d_t dstimg38, write_only image2d_t dstimg39,
            write_only image2d_t dstimg40, write_only image2d_t dstimg41,
            write_only image2d_t dstimg42, write_only image2d_t dstimg43,
            write_only image2d_t dstimg44, write_only image2d_t dstimg45,
            write_only image2d_t dstimg46, write_only image2d_t dstimg47,
            write_only image2d_t dstimg48, write_only image2d_t dstimg49,
            write_only image2d_t dstimg50, write_only image2d_t dstimg51,
            write_only image2d_t dstimg52, write_only image2d_t dstimg53,
            write_only image2d_t dstimg54, write_only image2d_t dstimg55,
            write_only image2d_t dstimg56, write_only image2d_t dstimg57,
            write_only image2d_t dstimg58, write_only image2d_t dstimg59,
            write_only image2d_t dstimg60, write_only image2d_t dstimg61,
            write_only image2d_t dstimg62, write_only image2d_t dstimg63,
            write_only image2d_t dstimg64, write_only image2d_t dstimg65,
            write_only image2d_t dstimg66, write_only image2d_t dstimg67,
            write_only image2d_t dstimg68, write_only image2d_t dstimg69,
            write_only image2d_t dstimg70, write_only image2d_t dstimg71,
            write_only image2d_t dstimg72, write_only image2d_t dstimg73,
            write_only image2d_t dstimg74, write_only image2d_t dstimg75,
            write_only image2d_t dstimg76, write_only image2d_t dstimg77,
            write_only image2d_t dstimg78, write_only image2d_t dstimg79,
            write_only image2d_t dstimg80, write_only image2d_t dstimg81,
            write_only image2d_t dstimg82, write_only image2d_t dstimg83,
            write_only image2d_t dstimg84, write_only image2d_t dstimg85,
            write_only image2d_t dstimg86, write_only image2d_t dstimg87,
            write_only image2d_t dstimg88, write_only image2d_t dstimg89,
            write_only image2d_t dstimg90, write_only image2d_t dstimg91,
            write_only image2d_t dstimg92, write_only image2d_t dstimg93,
            write_only image2d_t dstimg94, write_only image2d_t dstimg95,
            write_only image2d_t dstimg96, write_only image2d_t dstimg97,
            write_only image2d_t dstimg98, write_only image2d_t dstimg99,
            write_only image2d_t dstimg100, write_only image2d_t dstimg101,
            write_only image2d_t dstimg102, write_only image2d_t dstimg103,
            write_only image2d_t dstimg104, write_only image2d_t dstimg105,
            write_only image2d_t dstimg106, write_only image2d_t dstimg107,
            write_only image2d_t dstimg108, write_only image2d_t dstimg109,
            write_only image2d_t dstimg110, write_only image2d_t dstimg111,
            write_only image2d_t dstimg112, write_only image2d_t dstimg113,
            write_only image2d_t dstimg114, write_only image2d_t dstimg115,
            write_only image2d_t dstimg116, write_only image2d_t dstimg117,
            write_only image2d_t dstimg118, write_only image2d_t dstimg119,
            write_only image2d_t dstimg120, write_only image2d_t dstimg121,
            write_only image2d_t dstimg122, write_only image2d_t dstimg123,
            write_only image2d_t dstimg124, write_only image2d_t dstimg125,
            write_only image2d_t dstimg126, write_only image2d_t dstimg127,
            write_only image2d_t dstimg128, write_only image2d_t dstimg129,
            write_only image2d_t dstimg130, write_only image2d_t dstimg131,
            write_only image2d_t dstimg132, write_only image2d_t dstimg133,
            write_only image2d_t dstimg134, write_only image2d_t dstimg135,
            write_only image2d_t dstimg136, write_only image2d_t dstimg137,
            write_only image2d_t dstimg138, write_only image2d_t dstimg139,
            write_only image2d_t dstimg140, write_only image2d_t dstimg141,
            write_only image2d_t dstimg142, write_only image2d_t dstimg143,
            write_only image2d_t dstimg144, write_only image2d_t dstimg145,
            write_only image2d_t dstimg146, write_only image2d_t dstimg147,
            write_only image2d_t dstimg148, write_only image2d_t dstimg149,
            write_only image2d_t dstimg150, write_only image2d_t dstimg151,
            write_only image2d_t dstimg152, write_only image2d_t dstimg153,
            write_only image2d_t dstimg154, write_only image2d_t dstimg155,
            write_only image2d_t dstimg156, write_only image2d_t dstimg157,
            write_only image2d_t dstimg158, write_only image2d_t dstimg159,
            write_only image2d_t dstimg160, write_only image2d_t dstimg161,
            write_only image2d_t dstimg162, write_only image2d_t dstimg163,
            write_only image2d_t dstimg164, write_only image2d_t dstimg165,
            write_only image2d_t dstimg166, write_only image2d_t dstimg167,
            write_only image2d_t dstimg168, write_only image2d_t dstimg169,
            write_only image2d_t dstimg170, write_only image2d_t dstimg171,
            write_only image2d_t dstimg172, write_only image2d_t dstimg173,
            write_only image2d_t dstimg174, write_only image2d_t dstimg175,
            write_only image2d_t dstimg176, write_only image2d_t dstimg177,
            write_only image2d_t dstimg178, write_only image2d_t dstimg179,
            write_only image2d_t dstimg180, write_only image2d_t dstimg181,
            write_only image2d_t dstimg182, write_only image2d_t dstimg183,
            write_only image2d_t dstimg184, write_only image2d_t dstimg185,
            write_only image2d_t dstimg186, write_only image2d_t dstimg187,
            write_only image2d_t dstimg188, write_only image2d_t dstimg189,
            write_only image2d_t dstimg190, write_only image2d_t dstimg191,
            write_only image2d_t dstimg192, write_only image2d_t dstimg193,
            write_only image2d_t dstimg194, write_only image2d_t dstimg195,
            write_only image2d_t dstimg196, write_only image2d_t dstimg197,
            write_only image2d_t dstimg198, write_only image2d_t dstimg199,
            write_only image2d_t dstimg200, write_only image2d_t dstimg201,
            write_only image2d_t dstimg202, write_only image2d_t dstimg203,
            write_only image2d_t dstimg204, write_only image2d_t dstimg205,
            write_only image2d_t dstimg206, write_only image2d_t dstimg207,
            write_only image2d_t dstimg208, write_only image2d_t dstimg209,
            write_only image2d_t dstimg210, write_only image2d_t dstimg211,
            write_only image2d_t dstimg212, write_only image2d_t dstimg213,
            write_only image2d_t dstimg214, write_only image2d_t dstimg215,
            write_only image2d_t dstimg216, write_only image2d_t dstimg217,
            write_only image2d_t dstimg218, write_only image2d_t dstimg219,
            write_only image2d_t dstimg220, write_only image2d_t dstimg221,
            write_only image2d_t dstimg222, write_only image2d_t dstimg223,
            write_only image2d_t dstimg224, write_only image2d_t dstimg225,
            write_only image2d_t dstimg226, write_only image2d_t dstimg227,
            write_only image2d_t dstimg228, write_only image2d_t dstimg229,
            write_only image2d_t dstimg230, write_only image2d_t dstimg231,
            write_only image2d_t dstimg232, write_only image2d_t dstimg233,
            write_only image2d_t dstimg234, write_only image2d_t dstimg235,
            write_only image2d_t dstimg236, write_only image2d_t dstimg237,
            write_only image2d_t dstimg238, write_only image2d_t dstimg239,
            write_only image2d_t dstimg240, write_only image2d_t dstimg241,
            write_only image2d_t dstimg242, write_only image2d_t dstimg243,
            write_only image2d_t dstimg244, write_only image2d_t dstimg245,
            write_only image2d_t dstimg246, write_only image2d_t dstimg247,
            write_only image2d_t dstimg248, write_only image2d_t dstimg249,
            write_only image2d_t dstimg250, write_only image2d_t dstimg251,
            write_only image2d_t dstimg252, write_only image2d_t dstimg253,
            write_only image2d_t dstimg254, write_only image2d_t dstimg255,
            write_only image2d_t dstimg256, write_only image2d_t dstimg257,
            write_only image2d_t dstimg258, write_only image2d_t dstimg259,
            write_only image2d_t dstimg260, write_only image2d_t dstimg261,
            write_only image2d_t dstimg262, write_only image2d_t dstimg263,
            write_only image2d_t dstimg264, write_only image2d_t dstimg265,
            write_only image2d_t dstimg266, write_only image2d_t dstimg267,
            write_only image2d_t dstimg268, write_only image2d_t dstimg269,
            write_only image2d_t dstimg270, write_only image2d_t dstimg271,
            write_only image2d_t dstimg272, write_only image2d_t dstimg273,
            write_only image2d_t dstimg274, write_only image2d_t dstimg275,
            write_only image2d_t dstimg276, write_only image2d_t dstimg277,
            write_only image2d_t dstimg278, write_only image2d_t dstimg279,
            write_only image2d_t dstimg280, write_only image2d_t dstimg281,
            write_only image2d_t dstimg282, write_only image2d_t dstimg283,
            write_only image2d_t dstimg284, write_only image2d_t dstimg285,
            write_only image2d_t dstimg286, write_only image2d_t dstimg287,
            write_only image2d_t dstimg288, write_only image2d_t dstimg289,
            write_only image2d_t dstimg290, write_only image2d_t dstimg291,
            write_only image2d_t dstimg292, write_only image2d_t dstimg293,
            write_only image2d_t dstimg294, write_only image2d_t dstimg295,
            write_only image2d_t dstimg296, write_only image2d_t dstimg297,
            write_only image2d_t dstimg298, write_only image2d_t dstimg299,
            write_only image2d_t dstimg300, write_only image2d_t dstimg301,
            write_only image2d_t dstimg302, write_only image2d_t dstimg303,
            write_only image2d_t dstimg304, write_only image2d_t dstimg305,
            write_only image2d_t dstimg306, write_only image2d_t dstimg307,
            write_only image2d_t dstimg308, write_only image2d_t dstimg309,
            write_only image2d_t dstimg310, write_only image2d_t dstimg311,
            write_only image2d_t dstimg312, write_only image2d_t dstimg313,
            write_only image2d_t dstimg314, write_only image2d_t dstimg315,
            write_only image2d_t dstimg316, write_only image2d_t dstimg317,
            write_only image2d_t dstimg318, write_only image2d_t dstimg319,
            write_only image2d_t dstimg320, write_only image2d_t dstimg321,
            write_only image2d_t dstimg322, write_only image2d_t dstimg323,
            write_only image2d_t dstimg324, write_only image2d_t dstimg325,
            write_only image2d_t dstimg326, write_only image2d_t dstimg327,
            write_only image2d_t dstimg328, write_only image2d_t dstimg329,
            write_only image2d_t dstimg330, write_only image2d_t dstimg331,
            write_only image2d_t dstimg332, write_only image2d_t dstimg333,
            write_only image2d_t dstimg334, write_only image2d_t dstimg335,
            write_only image2d_t dstimg336, write_only image2d_t dstimg337,
            write_only image2d_t dstimg338, write_only image2d_t dstimg339,
            write_only image2d_t dstimg340, write_only image2d_t dstimg341,
            write_only image2d_t dstimg342, write_only image2d_t dstimg343,
            write_only image2d_t dstimg344, write_only image2d_t dstimg345,
            write_only image2d_t dstimg346, write_only image2d_t dstimg347,
            write_only image2d_t dstimg348, write_only image2d_t dstimg349,
            write_only image2d_t dstimg350, write_only image2d_t dstimg351,
            write_only image2d_t dstimg352, write_only image2d_t dstimg353,
            write_only image2d_t dstimg354, write_only image2d_t dstimg355,
            write_only image2d_t dstimg356, write_only image2d_t dstimg357,
            write_only image2d_t dstimg358, write_only image2d_t dstimg359,
            write_only image2d_t dstimg360, write_only image2d_t dstimg361,
            write_only image2d_t dstimg362, write_only image2d_t dstimg363,
            write_only image2d_t dstimg364, write_only image2d_t dstimg365,
            write_only image2d_t dstimg366, write_only image2d_t dstimg367,
            write_only image2d_t dstimg368, write_only image2d_t dstimg369,
            write_only image2d_t dstimg370, write_only image2d_t dstimg371,
            write_only image2d_t dstimg372, write_only image2d_t dstimg373,
            write_only image2d_t dstimg374, write_only image2d_t dstimg375,
            write_only image2d_t dstimg376, write_only image2d_t dstimg377,
            write_only image2d_t dstimg378, write_only image2d_t dstimg379,
            write_only image2d_t dstimg380, write_only image2d_t dstimg381,
            write_only image2d_t dstimg382, write_only image2d_t dstimg383,
            write_only image2d_t dstimg384, write_only image2d_t dstimg385,
            write_only image2d_t dstimg386, write_only image2d_t dstimg387,
            write_only image2d_t dstimg388, write_only image2d_t dstimg389,
            write_only image2d_t dstimg390, write_only image2d_t dstimg391,
            write_only image2d_t dstimg392, write_only image2d_t dstimg393,
            write_only image2d_t dstimg394, write_only image2d_t dstimg395,
            write_only image2d_t dstimg396, write_only image2d_t dstimg397,
            write_only image2d_t dstimg398, write_only image2d_t dstimg399,
            write_only image2d_t dstimg400, write_only image2d_t dstimg401,
            write_only image2d_t dstimg402, write_only image2d_t dstimg403,
            write_only image2d_t dstimg404, write_only image2d_t dstimg405,
            write_only image2d_t dstimg406, write_only image2d_t dstimg407,
            write_only image2d_t dstimg408, write_only image2d_t dstimg409,
            write_only image2d_t dstimg410, write_only image2d_t dstimg411,
            write_only image2d_t dstimg412, write_only image2d_t dstimg413,
            write_only image2d_t dstimg414, write_only image2d_t dstimg415,
            write_only image2d_t dstimg416, write_only image2d_t dstimg417,
            write_only image2d_t dstimg418, write_only image2d_t dstimg419,
            write_only image2d_t dstimg420, write_only image2d_t dstimg421,
            write_only image2d_t dstimg422, write_only image2d_t dstimg423,
            write_only image2d_t dstimg424, write_only image2d_t dstimg425,
            write_only image2d_t dstimg426, write_only image2d_t dstimg427,
            write_only image2d_t dstimg428, write_only image2d_t dstimg429,
            write_only image2d_t dstimg430, write_only image2d_t dstimg431,
            write_only image2d_t dstimg432, write_only image2d_t dstimg433,
            write_only image2d_t dstimg434, write_only image2d_t dstimg435,
            write_only image2d_t dstimg436, write_only image2d_t dstimg437,
            write_only image2d_t dstimg438, write_only image2d_t dstimg439,
            write_only image2d_t dstimg440, write_only image2d_t dstimg441,
            write_only image2d_t dstimg442, write_only image2d_t dstimg443,
            write_only image2d_t dstimg444, write_only image2d_t dstimg445,
            write_only image2d_t dstimg446, write_only image2d_t dstimg447,
            write_only image2d_t dstimg448, write_only image2d_t dstimg449,
            write_only image2d_t dstimg450, write_only image2d_t dstimg451,
            write_only image2d_t dstimg452, write_only image2d_t dstimg453,
            write_only image2d_t dstimg454, write_only image2d_t dstimg455,
            write_only image2d_t dstimg456, write_only image2d_t dstimg457,
            write_only image2d_t dstimg458, write_only image2d_t dstimg459,
            write_only image2d_t dstimg460, write_only image2d_t dstimg461,
            write_only image2d_t dstimg462, write_only image2d_t dstimg463,
            write_only image2d_t dstimg464, write_only image2d_t dstimg465,
            write_only image2d_t dstimg466, write_only image2d_t dstimg467,
            write_only image2d_t dstimg468, write_only image2d_t dstimg469,
            write_only image2d_t dstimg470, write_only image2d_t dstimg471,
            write_only image2d_t dstimg472, write_only image2d_t dstimg473,
            write_only image2d_t dstimg474, write_only image2d_t dstimg475,
            write_only image2d_t dstimg476, write_only image2d_t dstimg477,
            write_only image2d_t dstimg478, write_only image2d_t dstimg479) {
  int tid = get_global_id(0);
  write_imagef(dstimg0, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg1, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg2, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg3, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg4, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg5, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg6, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg7, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg8, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg9, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg10, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg11, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg12, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg13, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg14, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg15, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg16, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg17, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg18, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg19, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg20, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg21, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg22, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg23, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg24, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg25, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg26, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg27, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg28, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg29, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg30, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg31, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg32, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg33, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg34, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg35, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg36, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg37, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg38, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg39, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg40, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg41, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg42, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg43, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg44, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg45, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg46, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg47, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg48, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg49, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg50, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg51, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg52, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg53, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg54, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg55, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg56, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg57, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg58, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg59, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg60, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg61, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg62, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg63, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg64, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg65, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg66, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg67, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg68, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg69, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg70, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg71, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg72, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg73, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg74, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg75, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg76, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg77, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg78, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg79, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg80, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg81, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg82, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg83, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg84, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg85, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg86, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg87, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg88, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg89, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg90, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg91, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg92, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg93, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg94, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg95, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg96, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg97, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg98, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg99, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg100, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg101, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg102, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg103, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg104, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg105, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg106, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg107, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg108, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg109, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg110, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg111, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg112, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg113, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg114, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg115, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg116, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg117, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg118, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg119, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg120, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg121, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg122, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg123, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg124, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg125, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg126, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg127, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg128, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg129, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg130, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg131, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg132, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg133, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg134, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg135, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg136, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg137, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg138, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg139, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg140, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg141, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg142, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg143, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg144, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg145, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg146, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg147, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg148, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg149, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg150, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg151, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg152, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg153, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg154, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg155, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg156, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg157, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg158, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg159, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg160, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg161, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg162, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg163, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg164, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg165, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg166, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg167, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg168, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg169, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg170, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg171, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg172, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg173, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg174, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg175, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg176, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg177, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg178, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg179, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg180, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg181, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg182, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg183, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg184, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg185, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg186, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg187, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg188, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg189, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg190, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg191, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg192, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg193, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg194, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg195, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg196, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg197, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg198, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg199, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg200, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg201, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg202, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg203, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg204, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg205, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg206, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg207, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg208, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg209, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg210, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg211, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg212, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg213, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg214, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg215, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg216, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg217, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg218, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg219, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg220, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg221, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg222, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg223, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg224, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg225, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg226, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg227, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg228, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg229, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg230, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg231, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg232, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg233, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg234, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg235, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg236, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg237, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg238, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg239, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg240, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg241, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg242, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg243, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg244, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg245, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg246, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg247, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg248, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg249, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg250, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg251, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg252, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg253, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg254, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg255, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg256, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg257, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg258, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg259, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg260, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg261, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg262, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg263, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg264, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg265, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg266, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg267, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg268, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg269, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg270, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg271, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg272, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg273, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg274, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg275, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg276, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg277, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg278, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg279, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg280, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg281, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg282, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg283, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg284, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg285, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg286, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg287, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg288, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg289, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg290, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg291, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg292, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg293, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg294, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg295, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg296, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg297, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg298, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg299, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg300, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg301, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg302, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg303, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg304, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg305, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg306, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg307, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg308, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg309, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg310, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg311, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg312, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg313, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg314, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg315, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg316, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg317, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg318, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg319, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg320, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg321, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg322, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg323, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg324, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg325, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg326, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg327, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg328, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg329, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg330, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg331, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg332, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg333, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg334, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg335, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg336, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg337, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg338, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg339, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg340, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg341, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg342, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg343, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg344, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg345, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg346, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg347, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg348, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg349, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg350, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg351, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg352, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg353, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg354, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg355, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg356, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg357, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg358, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg359, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg360, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg361, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg362, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg363, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg364, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg365, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg366, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg367, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg368, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg369, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg370, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg371, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg372, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg373, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg374, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg375, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg376, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg377, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg378, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg379, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg380, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg381, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg382, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg383, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg384, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg385, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg386, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg387, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg388, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg389, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg390, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg391, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg392, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg393, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg394, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg395, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg396, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg397, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg398, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg399, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg400, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg401, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg402, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg403, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg404, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg405, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg406, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg407, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg408, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg409, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg410, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg411, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg412, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg413, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg414, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg415, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg416, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg417, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg418, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg419, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg420, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg421, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg422, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg423, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg424, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg425, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg426, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg427, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg428, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg429, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg430, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg431, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg432, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg433, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg434, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg435, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg436, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg437, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg438, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg439, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg440, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg441, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg442, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg443, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg444, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg445, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg446, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg447, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg448, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg449, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg450, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg451, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg452, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg453, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg454, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg455, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg456, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg457, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg458, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg459, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg460, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg461, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg462, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg463, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg464, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg465, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg466, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg467, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg468, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg469, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg470, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg471, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg472, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg473, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg474, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg475, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg476, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg477, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg478, (int2)(0, 0), (float4)(0, 0, 0, 0));
  write_imagef(dstimg479, (int2)(0, 0), (float4)(0, 0, 0, 0));
}
