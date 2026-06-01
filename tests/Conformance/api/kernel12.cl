// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
typedef float4 typedef_type;

typedef struct struct_type {
  float4 float4d;
  int intd;
} typedef_struct_type;

typedef union union_type {
  float4 float4d;
  uint4 uint4d;
} typedef_union_type;

typedef enum enum_type {
  enum_type_zero,
  enum_type_one,
  enum_type_two
} typedef_enum_type;

kernel void constant_scalar_p0(constant void *constantvoidp,
                               constant char *constantcharp,
                               constant uchar *constantucharp,
                               constant unsigned char *constantunsignedcharp) {}
kernel void constant_scalar_p1(constant short *constantshortp,
                               constant ushort *constantushortp,
                               constant unsigned short *constantunsignedshortp,
                               constant int *constantintp) {}
kernel void constant_scalar_p2(constant uint *constantuintp,
                               constant unsigned int *constantunsignedintp,
                               constant long *constantlongp,
                               constant ulong *constantulongp) {}
kernel void constant_scalar_p3(constant unsigned long *constantunsignedlongp,
                               constant float *constantfloatp) {}

kernel void constant_scalar_restrict_p0(
    constant void *restrict constantvoidrestrictp,
    constant char *restrict constantcharrestrictp,
    constant uchar *restrict constantucharrestrictp,
    constant unsigned char *restrict constantunsignedcharrestrictp) {}
kernel void constant_scalar_restrict_p1(
    constant short *restrict constantshortrestrictp,
    constant ushort *restrict constantushortrestrictp,
    constant unsigned short *restrict constantunsignedshortrestrictp,
    constant int *restrict constantintrestrictp) {}
kernel void constant_scalar_restrict_p2(
    constant uint *restrict constantuintrestrictp,
    constant unsigned int *restrict constantunsignedintrestrictp,
    constant long *restrict constantlongrestrictp,
    constant ulong *restrict constantulongrestrictp) {}
kernel void constant_scalar_restrict_p3(
    constant unsigned long *restrict constantunsignedlongrestrictp,
    constant float *restrict constantfloatrestrictp) {}

kernel void global_scalar_p(
    global void *globalvoidp, global char *globalcharp,
    global uchar *globalucharp, global unsigned char *globalunsignedcharp,
    global short *globalshortp, global ushort *globalushortp,
    global unsigned short *globalunsignedshortp, global int *globalintp,
    global uint *globaluintp, global unsigned int *globalunsignedintp,
    global long *globallongp, global ulong *globalulongp,
    global unsigned long *globalunsignedlongp, global float *globalfloatp) {}

kernel void global_scalar_restrict_p(
    global void *restrict globalvoidrestrictp,
    global char *restrict globalcharrestrictp,
    global uchar *restrict globalucharrestrictp,
    global unsigned char *restrict globalunsignedcharrestrictp,
    global short *restrict globalshortrestrictp,
    global ushort *restrict globalushortrestrictp,
    global unsigned short *restrict globalunsignedshortrestrictp,
    global int *restrict globalintrestrictp,
    global uint *restrict globaluintrestrictp,
    global unsigned int *restrict globalunsignedintrestrictp,
    global long *restrict globallongrestrictp,
    global ulong *restrict globalulongrestrictp,
    global unsigned long *restrict globalunsignedlongrestrictp,
    global float *restrict globalfloatrestrictp) {}

kernel void global_const_scalar_p(
    global const void *globalconstvoidp, global const char *globalconstcharp,
    global const uchar *globalconstucharp,
    global const unsigned char *globalconstunsignedcharp,
    global const short *globalconstshortp,
    global const ushort *globalconstushortp,
    global const unsigned short *globalconstunsignedshortp,
    global const int *globalconstintp, global const uint *globalconstuintp,
    global const unsigned int *globalconstunsignedintp,
    global const long *globalconstlongp, global const ulong *globalconstulongp,
    global const unsigned long *globalconstunsignedlongp,
    global const float *globalconstfloatp) {}

kernel void global_const_scalar_restrict_p(
    global const void *restrict globalconstvoidrestrictp,
    global const char *restrict globalconstcharrestrictp,
    global const uchar *restrict globalconstucharrestrictp,
    global const unsigned char *restrict globalconstunsignedcharrestrictp,
    global const short *restrict globalconstshortrestrictp,
    global const ushort *restrict globalconstushortrestrictp,
    global const unsigned short *restrict globalconstunsignedshortrestrictp,
    global const int *restrict globalconstintrestrictp,
    global const uint *restrict globalconstuintrestrictp,
    global const unsigned int *restrict globalconstunsignedintrestrictp,
    global const long *restrict globalconstlongrestrictp,
    global const ulong *restrict globalconstulongrestrictp,
    global const unsigned long *restrict globalconstunsignedlongrestrictp,
    global const float *restrict globalconstfloatrestrictp) {}

kernel void global_volatile_scalar_p(
    global volatile void *globalvolatilevoidp,
    global volatile char *globalvolatilecharp,
    global volatile uchar *globalvolatileucharp,
    global volatile unsigned char *globalvolatileunsignedcharp,
    global volatile short *globalvolatileshortp,
    global volatile ushort *globalvolatileushortp,
    global volatile unsigned short *globalvolatileunsignedshortp,
    global volatile int *globalvolatileintp,
    global volatile uint *globalvolatileuintp,
    global volatile unsigned int *globalvolatileunsignedintp,
    global volatile long *globalvolatilelongp,
    global volatile ulong *globalvolatileulongp,
    global volatile unsigned long *globalvolatileunsignedlongp,
    global volatile float *globalvolatilefloatp) {}

kernel void global_volatile_scalar_restrict_p(
    global volatile void *restrict globalvolatilevoidrestrictp,
    global volatile char *restrict globalvolatilecharrestrictp,
    global volatile uchar *restrict globalvolatileucharrestrictp,
    global volatile unsigned char *restrict globalvolatileunsignedcharrestrictp,
    global volatile short *restrict globalvolatileshortrestrictp,
    global volatile ushort *restrict globalvolatileushortrestrictp,
    global volatile unsigned short
        *restrict globalvolatileunsignedshortrestrictp,
    global volatile int *restrict globalvolatileintrestrictp,
    global volatile uint *restrict globalvolatileuintrestrictp,
    global volatile unsigned int *restrict globalvolatileunsignedintrestrictp,
    global volatile long *restrict globalvolatilelongrestrictp,
    global volatile ulong *restrict globalvolatileulongrestrictp,
    global volatile unsigned long *restrict globalvolatileunsignedlongrestrictp,
    global volatile float *restrict globalvolatilefloatrestrictp) {}

kernel void global_const_volatile_scalar_p(
    global const volatile void *globalconstvolatilevoidp,
    global const volatile char *globalconstvolatilecharp,
    global const volatile uchar *globalconstvolatileucharp,
    global const volatile unsigned char *globalconstvolatileunsignedcharp,
    global const volatile short *globalconstvolatileshortp,
    global const volatile ushort *globalconstvolatileushortp,
    global const volatile unsigned short *globalconstvolatileunsignedshortp,
    global const volatile int *globalconstvolatileintp,
    global const volatile uint *globalconstvolatileuintp,
    global const volatile unsigned int *globalconstvolatileunsignedintp,
    global const volatile long *globalconstvolatilelongp,
    global const volatile ulong *globalconstvolatileulongp,
    global const volatile unsigned long *globalconstvolatileunsignedlongp,
    global const volatile float *globalconstvolatilefloatp) {}

kernel void global_const_volatile_scalar_restrict_p(
    global const volatile void *restrict globalconstvolatilevoidrestrictp,
    global const volatile char *restrict globalconstvolatilecharrestrictp,
    global const volatile uchar *restrict globalconstvolatileucharrestrictp,
    global const volatile unsigned char
        *restrict globalconstvolatileunsignedcharrestrictp,
    global const volatile short *restrict globalconstvolatileshortrestrictp,
    global const volatile ushort *restrict globalconstvolatileushortrestrictp,
    global const volatile unsigned short
        *restrict globalconstvolatileunsignedshortrestrictp,
    global const volatile int *restrict globalconstvolatileintrestrictp,
    global const volatile uint *restrict globalconstvolatileuintrestrictp,
    global const volatile unsigned int
        *restrict globalconstvolatileunsignedintrestrictp,
    global const volatile long *restrict globalconstvolatilelongrestrictp,
    global const volatile ulong *restrict globalconstvolatileulongrestrictp,
    global const volatile unsigned long
        *restrict globalconstvolatileunsignedlongrestrictp,
    global const volatile float *restrict globalconstvolatilefloatrestrictp) {}

kernel void local_scalar_p(local void *localvoidp, local char *localcharp,
                           local uchar *localucharp,
                           local unsigned char *localunsignedcharp,
                           local short *localshortp, local ushort *localushortp,
                           local unsigned short *localunsignedshortp,
                           local int *localintp, local uint *localuintp,
                           local unsigned int *localunsignedintp,
                           local long *locallongp, local ulong *localulongp,
                           local unsigned long *localunsignedlongp,
                           local float *localfloatp) {}

kernel void local_scalar_restrict_p(
    local void *restrict localvoidrestrictp,
    local char *restrict localcharrestrictp,
    local uchar *restrict localucharrestrictp,
    local unsigned char *restrict localunsignedcharrestrictp,
    local short *restrict localshortrestrictp,
    local ushort *restrict localushortrestrictp,
    local unsigned short *restrict localunsignedshortrestrictp,
    local int *restrict localintrestrictp,
    local uint *restrict localuintrestrictp,
    local unsigned int *restrict localunsignedintrestrictp,
    local long *restrict locallongrestrictp,
    local ulong *restrict localulongrestrictp,
    local unsigned long *restrict localunsignedlongrestrictp,
    local float *restrict localfloatrestrictp) {}

kernel void local_const_scalar_p(
    local const void *localconstvoidp, local const char *localconstcharp,
    local const uchar *localconstucharp,
    local const unsigned char *localconstunsignedcharp,
    local const short *localconstshortp, local const ushort *localconstushortp,
    local const unsigned short *localconstunsignedshortp,
    local const int *localconstintp, local const uint *localconstuintp,
    local const unsigned int *localconstunsignedintp,
    local const long *localconstlongp, local const ulong *localconstulongp,
    local const unsigned long *localconstunsignedlongp,
    local const float *localconstfloatp) {}

kernel void local_const_scalar_restrict_p(
    local const void *restrict localconstvoidrestrictp,
    local const char *restrict localconstcharrestrictp,
    local const uchar *restrict localconstucharrestrictp,
    local const unsigned char *restrict localconstunsignedcharrestrictp,
    local const short *restrict localconstshortrestrictp,
    local const ushort *restrict localconstushortrestrictp,
    local const unsigned short *restrict localconstunsignedshortrestrictp,
    local const int *restrict localconstintrestrictp,
    local const uint *restrict localconstuintrestrictp,
    local const unsigned int *restrict localconstunsignedintrestrictp,
    local const long *restrict localconstlongrestrictp,
    local const ulong *restrict localconstulongrestrictp,
    local const unsigned long *restrict localconstunsignedlongrestrictp,
    local const float *restrict localconstfloatrestrictp) {}

kernel void local_volatile_scalar_p(
    local volatile void *localvolatilevoidp,
    local volatile char *localvolatilecharp,
    local volatile uchar *localvolatileucharp,
    local volatile unsigned char *localvolatileunsignedcharp,
    local volatile short *localvolatileshortp,
    local volatile ushort *localvolatileushortp,
    local volatile unsigned short *localvolatileunsignedshortp,
    local volatile int *localvolatileintp,
    local volatile uint *localvolatileuintp,
    local volatile unsigned int *localvolatileunsignedintp,
    local volatile long *localvolatilelongp,
    local volatile ulong *localvolatileulongp,
    local volatile unsigned long *localvolatileunsignedlongp,
    local volatile float *localvolatilefloatp) {}

kernel void local_volatile_scalar_restrict_p(
    local volatile void *restrict localvolatilevoidrestrictp,
    local volatile char *restrict localvolatilecharrestrictp,
    local volatile uchar *restrict localvolatileucharrestrictp,
    local volatile unsigned char *restrict localvolatileunsignedcharrestrictp,
    local volatile short *restrict localvolatileshortrestrictp,
    local volatile ushort *restrict localvolatileushortrestrictp,
    local volatile unsigned short *restrict localvolatileunsignedshortrestrictp,
    local volatile int *restrict localvolatileintrestrictp,
    local volatile uint *restrict localvolatileuintrestrictp,
    local volatile unsigned int *restrict localvolatileunsignedintrestrictp,
    local volatile long *restrict localvolatilelongrestrictp,
    local volatile ulong *restrict localvolatileulongrestrictp,
    local volatile unsigned long *restrict localvolatileunsignedlongrestrictp,
    local volatile float *restrict localvolatilefloatrestrictp) {}

kernel void local_const_volatile_scalar_p(
    local const volatile void *localconstvolatilevoidp,
    local const volatile char *localconstvolatilecharp,
    local const volatile uchar *localconstvolatileucharp,
    local const volatile unsigned char *localconstvolatileunsignedcharp,
    local const volatile short *localconstvolatileshortp,
    local const volatile ushort *localconstvolatileushortp,
    local const volatile unsigned short *localconstvolatileunsignedshortp,
    local const volatile int *localconstvolatileintp,
    local const volatile uint *localconstvolatileuintp,
    local const volatile unsigned int *localconstvolatileunsignedintp,
    local const volatile long *localconstvolatilelongp,
    local const volatile ulong *localconstvolatileulongp,
    local const volatile unsigned long *localconstvolatileunsignedlongp,
    local const volatile float *localconstvolatilefloatp) {}

kernel void local_const_volatile_scalar_restrict_p(
    local const volatile void *restrict localconstvolatilevoidrestrictp,
    local const volatile char *restrict localconstvolatilecharrestrictp,
    local const volatile uchar *restrict localconstvolatileucharrestrictp,
    local const volatile unsigned char
        *restrict localconstvolatileunsignedcharrestrictp,
    local const volatile short *restrict localconstvolatileshortrestrictp,
    local const volatile ushort *restrict localconstvolatileushortrestrictp,
    local const volatile unsigned short
        *restrict localconstvolatileunsignedshortrestrictp,
    local const volatile int *restrict localconstvolatileintrestrictp,
    local const volatile uint *restrict localconstvolatileuintrestrictp,
    local const volatile unsigned int
        *restrict localconstvolatileunsignedintrestrictp,
    local const volatile long *restrict localconstvolatilelongrestrictp,
    local const volatile ulong *restrict localconstvolatileulongrestrictp,
    local const volatile unsigned long
        *restrict localconstvolatileunsignedlongrestrictp,
    local const volatile float *restrict localconstvolatilefloatrestrictp) {}

kernel void scalar_d(char chard, uchar uchard, unsigned char unsignedchard,
                     short shortd, ushort ushortd,
                     unsigned short unsignedshortd, int intd, uint uintd,
                     unsigned int unsignedintd, long longd, ulong ulongd,
                     unsigned long unsignedlongd, float floatd) {}

kernel void const_scalar_d(const char constchard, const uchar constuchard,
                           const unsigned char constunsignedchard,
                           const short constshortd, const ushort constushortd,
                           const unsigned short constunsignedshortd,
                           const int constintd, const uint constuintd,
                           const unsigned int constunsignedintd,
                           const long constlongd, const ulong constulongd,
                           const unsigned long constunsignedlongd,
                           const float constfloatd) {}

kernel void private_scalar_d(
    private char privatechard, private uchar privateuchard,
    private unsigned char privateunsignedchard, private short privateshortd,
    private ushort privateushortd, private unsigned short privateunsignedshortd,
    private int privateintd, private uint privateuintd,
    private unsigned int privateunsignedintd, private long privatelongd,
    private ulong privateulongd, private unsigned long privateunsignedlongd,
    private float privatefloatd) {}

kernel void
private_const_scalar_d(private const char privateconstchard,
                       private const uchar privateconstuchard,
                       private const unsigned char privateconstunsignedchard,
                       private const short privateconstshortd,
                       private const ushort privateconstushortd,
                       private const unsigned short privateconstunsignedshortd,
                       private const int privateconstintd,
                       private const uint privateconstuintd,
                       private const unsigned int privateconstunsignedintd,
                       private const long privateconstlongd,
                       private const ulong privateconstulongd,
                       private const unsigned long privateconstunsignedlongd,
                       private const float privateconstfloatd) {}

kernel void constant_vector2_p0(constant char2 *constantchar2p,
                                constant uchar2 *constantuchar2p,
                                constant short2 *constantshort2p,
                                constant ushort2 *constantushort2p) {}

kernel void constant_vector2_p1(constant int2 *constantint2p,
                                constant uint2 *constantuint2p,
                                constant long2 *constantlong2p,
                                constant ulong2 *constantulong2p) {}

kernel void constant_vector2_p2(constant float2 *constantfloat2p) {}

kernel void constant_vector2_restrict_p0(
    constant char2 *restrict constantchar2restrictp,
    constant uchar2 *restrict constantuchar2restrictp,
    constant short2 *restrict constantshort2restrictp,
    constant ushort2 *restrict constantushort2restrictp) {}

kernel void constant_vector2_restrict_p1(
    constant int2 *restrict constantint2restrictp,
    constant uint2 *restrict constantuint2restrictp,
    constant long2 *restrict constantlong2restrictp,
    constant ulong2 *restrict constantulong2restrictp) {}

kernel void constant_vector2_restrict_p2(
    constant float2 *restrict constantfloat2restrictp) {}

kernel void
global_vector2_p(global char2 *globalchar2p, global uchar2 *globaluchar2p,
                 global short2 *globalshort2p, global ushort2 *globalushort2p,
                 global int2 *globalint2p, global uint2 *globaluint2p,
                 global long2 *globallong2p, global ulong2 *globalulong2p,
                 global float2 *globalfloat2p) {}

kernel void
global_vector2_restrict_p(global char2 *restrict globalchar2restrictp,
                          global uchar2 *restrict globaluchar2restrictp,
                          global short2 *restrict globalshort2restrictp,
                          global ushort2 *restrict globalushort2restrictp,
                          global int2 *restrict globalint2restrictp,
                          global uint2 *restrict globaluint2restrictp,
                          global long2 *restrict globallong2restrictp,
                          global ulong2 *restrict globalulong2restrictp,
                          global float2 *restrict globalfloat2restrictp) {}

kernel void global_const_vector2_p(global const char2 *globalconstchar2p,
                                   global const uchar2 *globalconstuchar2p,
                                   global const short2 *globalconstshort2p,
                                   global const ushort2 *globalconstushort2p,
                                   global const int2 *globalconstint2p,
                                   global const uint2 *globalconstuint2p,
                                   global const long2 *globalconstlong2p,
                                   global const ulong2 *globalconstulong2p,
                                   global const float2 *globalconstfloat2p) {}

kernel void global_const_vector2_restrict_p(
    global const char2 *restrict globalconstchar2restrictp,
    global const uchar2 *restrict globalconstuchar2restrictp,
    global const short2 *restrict globalconstshort2restrictp,
    global const ushort2 *restrict globalconstushort2restrictp,
    global const int2 *restrict globalconstint2restrictp,
    global const uint2 *restrict globalconstuint2restrictp,
    global const long2 *restrict globalconstlong2restrictp,
    global const ulong2 *restrict globalconstulong2restrictp,
    global const float2 *restrict globalconstfloat2restrictp) {}

kernel void
global_volatile_vector2_p(global volatile char2 *globalvolatilechar2p,
                          global volatile uchar2 *globalvolatileuchar2p,
                          global volatile short2 *globalvolatileshort2p,
                          global volatile ushort2 *globalvolatileushort2p,
                          global volatile int2 *globalvolatileint2p,
                          global volatile uint2 *globalvolatileuint2p,
                          global volatile long2 *globalvolatilelong2p,
                          global volatile ulong2 *globalvolatileulong2p,
                          global volatile float2 *globalvolatilefloat2p) {}

kernel void global_volatile_vector2_restrict_p(
    global volatile char2 *restrict globalvolatilechar2restrictp,
    global volatile uchar2 *restrict globalvolatileuchar2restrictp,
    global volatile short2 *restrict globalvolatileshort2restrictp,
    global volatile ushort2 *restrict globalvolatileushort2restrictp,
    global volatile int2 *restrict globalvolatileint2restrictp,
    global volatile uint2 *restrict globalvolatileuint2restrictp,
    global volatile long2 *restrict globalvolatilelong2restrictp,
    global volatile ulong2 *restrict globalvolatileulong2restrictp,
    global volatile float2 *restrict globalvolatilefloat2restrictp) {}

kernel void global_const_volatile_vector2_p(
    global const volatile char2 *globalconstvolatilechar2p,
    global const volatile uchar2 *globalconstvolatileuchar2p,
    global const volatile short2 *globalconstvolatileshort2p,
    global const volatile ushort2 *globalconstvolatileushort2p,
    global const volatile int2 *globalconstvolatileint2p,
    global const volatile uint2 *globalconstvolatileuint2p,
    global const volatile long2 *globalconstvolatilelong2p,
    global const volatile ulong2 *globalconstvolatileulong2p,
    global const volatile float2 *globalconstvolatilefloat2p) {}

kernel void global_const_volatile_vector2_restrict_p(
    global const volatile char2 *restrict globalconstvolatilechar2restrictp,
    global const volatile uchar2 *restrict globalconstvolatileuchar2restrictp,
    global const volatile short2 *restrict globalconstvolatileshort2restrictp,
    global const volatile ushort2 *restrict globalconstvolatileushort2restrictp,
    global const volatile int2 *restrict globalconstvolatileint2restrictp,
    global const volatile uint2 *restrict globalconstvolatileuint2restrictp,
    global const volatile long2 *restrict globalconstvolatilelong2restrictp,
    global const volatile ulong2 *restrict globalconstvolatileulong2restrictp,
    global const volatile float2 *restrict globalconstvolatilefloat2restrictp) {
}

kernel void
local_vector2_p(local char2 *localchar2p, local uchar2 *localuchar2p,
                local short2 *localshort2p, local ushort2 *localushort2p,
                local int2 *localint2p, local uint2 *localuint2p,
                local long2 *locallong2p, local ulong2 *localulong2p,
                local float2 *localfloat2p) {}

kernel void
local_vector2_restrict_p(local char2 *restrict localchar2restrictp,
                         local uchar2 *restrict localuchar2restrictp,
                         local short2 *restrict localshort2restrictp,
                         local ushort2 *restrict localushort2restrictp,
                         local int2 *restrict localint2restrictp,
                         local uint2 *restrict localuint2restrictp,
                         local long2 *restrict locallong2restrictp,
                         local ulong2 *restrict localulong2restrictp,
                         local float2 *restrict localfloat2restrictp) {}

kernel void local_const_vector2_p(local const char2 *localconstchar2p,
                                  local const uchar2 *localconstuchar2p,
                                  local const short2 *localconstshort2p,
                                  local const ushort2 *localconstushort2p,
                                  local const int2 *localconstint2p,
                                  local const uint2 *localconstuint2p,
                                  local const long2 *localconstlong2p,
                                  local const ulong2 *localconstulong2p,
                                  local const float2 *localconstfloat2p) {}

kernel void local_const_vector2_restrict_p(
    local const char2 *restrict localconstchar2restrictp,
    local const uchar2 *restrict localconstuchar2restrictp,
    local const short2 *restrict localconstshort2restrictp,
    local const ushort2 *restrict localconstushort2restrictp,
    local const int2 *restrict localconstint2restrictp,
    local const uint2 *restrict localconstuint2restrictp,
    local const long2 *restrict localconstlong2restrictp,
    local const ulong2 *restrict localconstulong2restrictp,
    local const float2 *restrict localconstfloat2restrictp) {}

kernel void
local_volatile_vector2_p(local volatile char2 *localvolatilechar2p,
                         local volatile uchar2 *localvolatileuchar2p,
                         local volatile short2 *localvolatileshort2p,
                         local volatile ushort2 *localvolatileushort2p,
                         local volatile int2 *localvolatileint2p,
                         local volatile uint2 *localvolatileuint2p,
                         local volatile long2 *localvolatilelong2p,
                         local volatile ulong2 *localvolatileulong2p,
                         local volatile float2 *localvolatilefloat2p) {}

kernel void local_volatile_vector2_restrict_p(
    local volatile char2 *restrict localvolatilechar2restrictp,
    local volatile uchar2 *restrict localvolatileuchar2restrictp,
    local volatile short2 *restrict localvolatileshort2restrictp,
    local volatile ushort2 *restrict localvolatileushort2restrictp,
    local volatile int2 *restrict localvolatileint2restrictp,
    local volatile uint2 *restrict localvolatileuint2restrictp,
    local volatile long2 *restrict localvolatilelong2restrictp,
    local volatile ulong2 *restrict localvolatileulong2restrictp,
    local volatile float2 *restrict localvolatilefloat2restrictp) {}

kernel void local_const_volatile_vector2_p(
    local const volatile char2 *localconstvolatilechar2p,
    local const volatile uchar2 *localconstvolatileuchar2p,
    local const volatile short2 *localconstvolatileshort2p,
    local const volatile ushort2 *localconstvolatileushort2p,
    local const volatile int2 *localconstvolatileint2p,
    local const volatile uint2 *localconstvolatileuint2p,
    local const volatile long2 *localconstvolatilelong2p,
    local const volatile ulong2 *localconstvolatileulong2p,
    local const volatile float2 *localconstvolatilefloat2p) {}

kernel void local_const_volatile_vector2_restrict_p(
    local const volatile char2 *restrict localconstvolatilechar2restrictp,
    local const volatile uchar2 *restrict localconstvolatileuchar2restrictp,
    local const volatile short2 *restrict localconstvolatileshort2restrictp,
    local const volatile ushort2 *restrict localconstvolatileushort2restrictp,
    local const volatile int2 *restrict localconstvolatileint2restrictp,
    local const volatile uint2 *restrict localconstvolatileuint2restrictp,
    local const volatile long2 *restrict localconstvolatilelong2restrictp,
    local const volatile ulong2 *restrict localconstvolatileulong2restrictp,
    local const volatile float2 *restrict localconstvolatilefloat2restrictp) {}

kernel void vector2_d(char2 char2d, uchar2 uchar2d, short2 short2d,
                      ushort2 ushort2d, int2 int2d, uint2 uint2d, long2 long2d,
                      ulong2 ulong2d, float2 float2d) {}

kernel void const_vector2_d(const char2 constchar2d, const uchar2 constuchar2d,
                            const short2 constshort2d,
                            const ushort2 constushort2d, const int2 constint2d,
                            const uint2 constuint2d, const long2 constlong2d,
                            const ulong2 constulong2d,
                            const float2 constfloat2d) {}

kernel void
private_vector2_d(private char2 privatechar2d, private uchar2 privateuchar2d,
                  private short2 privateshort2d,
                  private ushort2 privateushort2d, private int2 privateint2d,
                  private uint2 privateuint2d, private long2 privatelong2d,
                  private ulong2 privateulong2d,
                  private float2 privatefloat2d) {}

kernel void private_const_vector2_d(private const char2 privateconstchar2d,
                                    private const uchar2 privateconstuchar2d,
                                    private const short2 privateconstshort2d,
                                    private const ushort2 privateconstushort2d,
                                    private const int2 privateconstint2d,
                                    private const uint2 privateconstuint2d,
                                    private const long2 privateconstlong2d,
                                    private const ulong2 privateconstulong2d,
                                    private const float2 privateconstfloat2d) {}

kernel void constant_vector3_p0(constant char3 *constantchar3p,
                                constant uchar3 *constantuchar3p,
                                constant short3 *constantshort3p,
                                constant ushort3 *constantushort3p) {}

kernel void constant_vector3_p1(constant int3 *constantint3p,
                                constant uint3 *constantuint3p,
                                constant long3 *constantlong3p,
                                constant ulong3 *constantulong3p) {}

kernel void constant_vector3_p2(constant float3 *constantfloat3p) {}

kernel void constant_vector3_restrict_p0(
    constant char3 *restrict constantchar3restrictp,
    constant uchar3 *restrict constantuchar3restrictp,
    constant short3 *restrict constantshort3restrictp,
    constant ushort3 *restrict constantushort3restrictp) {}

kernel void constant_vector3_restrict_p1(
    constant int3 *restrict constantint3restrictp,
    constant uint3 *restrict constantuint3restrictp,
    constant long3 *restrict constantlong3restrictp,
    constant ulong3 *restrict constantulong3restrictp) {}

kernel void constant_vector3_restrict_p2(
    constant float3 *restrict constantfloat3restrictp) {}

kernel void
global_vector3_p(global char3 *globalchar3p, global uchar3 *globaluchar3p,
                 global short3 *globalshort3p, global ushort3 *globalushort3p,
                 global int3 *globalint3p, global uint3 *globaluint3p,
                 global long3 *globallong3p, global ulong3 *globalulong3p,
                 global float3 *globalfloat3p) {}

kernel void
global_vector3_restrict_p(global char3 *restrict globalchar3restrictp,
                          global uchar3 *restrict globaluchar3restrictp,
                          global short3 *restrict globalshort3restrictp,
                          global ushort3 *restrict globalushort3restrictp,
                          global int3 *restrict globalint3restrictp,
                          global uint3 *restrict globaluint3restrictp,
                          global long3 *restrict globallong3restrictp,
                          global ulong3 *restrict globalulong3restrictp,
                          global float3 *restrict globalfloat3restrictp) {}

kernel void global_const_vector3_p(global const char3 *globalconstchar3p,
                                   global const uchar3 *globalconstuchar3p,
                                   global const short3 *globalconstshort3p,
                                   global const ushort3 *globalconstushort3p,
                                   global const int3 *globalconstint3p,
                                   global const uint3 *globalconstuint3p,
                                   global const long3 *globalconstlong3p,
                                   global const ulong3 *globalconstulong3p,
                                   global const float3 *globalconstfloat3p) {}

kernel void global_const_vector3_restrict_p(
    global const char3 *restrict globalconstchar3restrictp,
    global const uchar3 *restrict globalconstuchar3restrictp,
    global const short3 *restrict globalconstshort3restrictp,
    global const ushort3 *restrict globalconstushort3restrictp,
    global const int3 *restrict globalconstint3restrictp,
    global const uint3 *restrict globalconstuint3restrictp,
    global const long3 *restrict globalconstlong3restrictp,
    global const ulong3 *restrict globalconstulong3restrictp,
    global const float3 *restrict globalconstfloat3restrictp) {}

kernel void
global_volatile_vector3_p(global volatile char3 *globalvolatilechar3p,
                          global volatile uchar3 *globalvolatileuchar3p,
                          global volatile short3 *globalvolatileshort3p,
                          global volatile ushort3 *globalvolatileushort3p,
                          global volatile int3 *globalvolatileint3p,
                          global volatile uint3 *globalvolatileuint3p,
                          global volatile long3 *globalvolatilelong3p,
                          global volatile ulong3 *globalvolatileulong3p,
                          global volatile float3 *globalvolatilefloat3p) {}

kernel void global_volatile_vector3_restrict_p(
    global volatile char3 *restrict globalvolatilechar3restrictp,
    global volatile uchar3 *restrict globalvolatileuchar3restrictp,
    global volatile short3 *restrict globalvolatileshort3restrictp,
    global volatile ushort3 *restrict globalvolatileushort3restrictp,
    global volatile int3 *restrict globalvolatileint3restrictp,
    global volatile uint3 *restrict globalvolatileuint3restrictp,
    global volatile long3 *restrict globalvolatilelong3restrictp,
    global volatile ulong3 *restrict globalvolatileulong3restrictp,
    global volatile float3 *restrict globalvolatilefloat3restrictp) {}

kernel void global_const_volatile_vector3_p(
    global const volatile char3 *globalconstvolatilechar3p,
    global const volatile uchar3 *globalconstvolatileuchar3p,
    global const volatile short3 *globalconstvolatileshort3p,
    global const volatile ushort3 *globalconstvolatileushort3p,
    global const volatile int3 *globalconstvolatileint3p,
    global const volatile uint3 *globalconstvolatileuint3p,
    global const volatile long3 *globalconstvolatilelong3p,
    global const volatile ulong3 *globalconstvolatileulong3p,
    global const volatile float3 *globalconstvolatilefloat3p) {}

kernel void global_const_volatile_vector3_restrict_p(
    global const volatile char3 *restrict globalconstvolatilechar3restrictp,
    global const volatile uchar3 *restrict globalconstvolatileuchar3restrictp,
    global const volatile short3 *restrict globalconstvolatileshort3restrictp,
    global const volatile ushort3 *restrict globalconstvolatileushort3restrictp,
    global const volatile int3 *restrict globalconstvolatileint3restrictp,
    global const volatile uint3 *restrict globalconstvolatileuint3restrictp,
    global const volatile long3 *restrict globalconstvolatilelong3restrictp,
    global const volatile ulong3 *restrict globalconstvolatileulong3restrictp,
    global const volatile float3 *restrict globalconstvolatilefloat3restrictp) {
}

kernel void
local_vector3_p(local char3 *localchar3p, local uchar3 *localuchar3p,
                local short3 *localshort3p, local ushort3 *localushort3p,
                local int3 *localint3p, local uint3 *localuint3p,
                local long3 *locallong3p, local ulong3 *localulong3p,
                local float3 *localfloat3p) {}

kernel void
local_vector3_restrict_p(local char3 *restrict localchar3restrictp,
                         local uchar3 *restrict localuchar3restrictp,
                         local short3 *restrict localshort3restrictp,
                         local ushort3 *restrict localushort3restrictp,
                         local int3 *restrict localint3restrictp,
                         local uint3 *restrict localuint3restrictp,
                         local long3 *restrict locallong3restrictp,
                         local ulong3 *restrict localulong3restrictp,
                         local float3 *restrict localfloat3restrictp) {}

kernel void local_const_vector3_p(local const char3 *localconstchar3p,
                                  local const uchar3 *localconstuchar3p,
                                  local const short3 *localconstshort3p,
                                  local const ushort3 *localconstushort3p,
                                  local const int3 *localconstint3p,
                                  local const uint3 *localconstuint3p,
                                  local const long3 *localconstlong3p,
                                  local const ulong3 *localconstulong3p,
                                  local const float3 *localconstfloat3p) {}

kernel void local_const_vector3_restrict_p(
    local const char3 *restrict localconstchar3restrictp,
    local const uchar3 *restrict localconstuchar3restrictp,
    local const short3 *restrict localconstshort3restrictp,
    local const ushort3 *restrict localconstushort3restrictp,
    local const int3 *restrict localconstint3restrictp,
    local const uint3 *restrict localconstuint3restrictp,
    local const long3 *restrict localconstlong3restrictp,
    local const ulong3 *restrict localconstulong3restrictp,
    local const float3 *restrict localconstfloat3restrictp) {}

kernel void
local_volatile_vector3_p(local volatile char3 *localvolatilechar3p,
                         local volatile uchar3 *localvolatileuchar3p,
                         local volatile short3 *localvolatileshort3p,
                         local volatile ushort3 *localvolatileushort3p,
                         local volatile int3 *localvolatileint3p,
                         local volatile uint3 *localvolatileuint3p,
                         local volatile long3 *localvolatilelong3p,
                         local volatile ulong3 *localvolatileulong3p,
                         local volatile float3 *localvolatilefloat3p) {}

kernel void local_volatile_vector3_restrict_p(
    local volatile char3 *restrict localvolatilechar3restrictp,
    local volatile uchar3 *restrict localvolatileuchar3restrictp,
    local volatile short3 *restrict localvolatileshort3restrictp,
    local volatile ushort3 *restrict localvolatileushort3restrictp,
    local volatile int3 *restrict localvolatileint3restrictp,
    local volatile uint3 *restrict localvolatileuint3restrictp,
    local volatile long3 *restrict localvolatilelong3restrictp,
    local volatile ulong3 *restrict localvolatileulong3restrictp,
    local volatile float3 *restrict localvolatilefloat3restrictp) {}

kernel void local_const_volatile_vector3_p(
    local const volatile char3 *localconstvolatilechar3p,
    local const volatile uchar3 *localconstvolatileuchar3p,
    local const volatile short3 *localconstvolatileshort3p,
    local const volatile ushort3 *localconstvolatileushort3p,
    local const volatile int3 *localconstvolatileint3p,
    local const volatile uint3 *localconstvolatileuint3p,
    local const volatile long3 *localconstvolatilelong3p,
    local const volatile ulong3 *localconstvolatileulong3p,
    local const volatile float3 *localconstvolatilefloat3p) {}

kernel void local_const_volatile_vector3_restrict_p(
    local const volatile char3 *restrict localconstvolatilechar3restrictp,
    local const volatile uchar3 *restrict localconstvolatileuchar3restrictp,
    local const volatile short3 *restrict localconstvolatileshort3restrictp,
    local const volatile ushort3 *restrict localconstvolatileushort3restrictp,
    local const volatile int3 *restrict localconstvolatileint3restrictp,
    local const volatile uint3 *restrict localconstvolatileuint3restrictp,
    local const volatile long3 *restrict localconstvolatilelong3restrictp,
    local const volatile ulong3 *restrict localconstvolatileulong3restrictp,
    local const volatile float3 *restrict localconstvolatilefloat3restrictp) {}

kernel void vector3_d(char3 char3d, uchar3 uchar3d, short3 short3d,
                      ushort3 ushort3d, int3 int3d, uint3 uint3d, long3 long3d,
                      ulong3 ulong3d, float3 float3d) {}

kernel void const_vector3_d(const char3 constchar3d, const uchar3 constuchar3d,
                            const short3 constshort3d,
                            const ushort3 constushort3d, const int3 constint3d,
                            const uint3 constuint3d, const long3 constlong3d,
                            const ulong3 constulong3d,
                            const float3 constfloat3d) {}

kernel void
private_vector3_d(private char3 privatechar3d, private uchar3 privateuchar3d,
                  private short3 privateshort3d,
                  private ushort3 privateushort3d, private int3 privateint3d,
                  private uint3 privateuint3d, private long3 privatelong3d,
                  private ulong3 privateulong3d,
                  private float3 privatefloat3d) {}

kernel void private_const_vector3_d(private const char3 privateconstchar3d,
                                    private const uchar3 privateconstuchar3d,
                                    private const short3 privateconstshort3d,
                                    private const ushort3 privateconstushort3d,
                                    private const int3 privateconstint3d,
                                    private const uint3 privateconstuint3d,
                                    private const long3 privateconstlong3d,
                                    private const ulong3 privateconstulong3d,
                                    private const float3 privateconstfloat3d) {}

kernel void constant_vector4_p0(constant char4 *constantchar4p,
                                constant uchar4 *constantuchar4p,
                                constant short4 *constantshort4p,
                                constant ushort4 *constantushort4p) {}

kernel void constant_vector4_p1(constant int4 *constantint4p,
                                constant uint4 *constantuint4p,
                                constant long4 *constantlong4p,
                                constant ulong4 *constantulong4p) {}

kernel void constant_vector4_p2(constant float4 *constantfloat4p) {}

kernel void constant_vector4_restrict_p0(
    constant char4 *restrict constantchar4restrictp,
    constant uchar4 *restrict constantuchar4restrictp,
    constant short4 *restrict constantshort4restrictp,
    constant ushort4 *restrict constantushort4restrictp) {}

kernel void constant_vector4_restrict_p1(
    constant int4 *restrict constantint4restrictp,
    constant uint4 *restrict constantuint4restrictp,
    constant long4 *restrict constantlong4restrictp,
    constant ulong4 *restrict constantulong4restrictp) {}

kernel void constant_vector4_restrict_p2(
    constant float4 *restrict constantfloat4restrictp) {}

kernel void
global_vector4_p(global char4 *globalchar4p, global uchar4 *globaluchar4p,
                 global short4 *globalshort4p, global ushort4 *globalushort4p,
                 global int4 *globalint4p, global uint4 *globaluint4p,
                 global long4 *globallong4p, global ulong4 *globalulong4p,
                 global float4 *globalfloat4p) {}

kernel void
global_vector4_restrict_p(global char4 *restrict globalchar4restrictp,
                          global uchar4 *restrict globaluchar4restrictp,
                          global short4 *restrict globalshort4restrictp,
                          global ushort4 *restrict globalushort4restrictp,
                          global int4 *restrict globalint4restrictp,
                          global uint4 *restrict globaluint4restrictp,
                          global long4 *restrict globallong4restrictp,
                          global ulong4 *restrict globalulong4restrictp,
                          global float4 *restrict globalfloat4restrictp) {}

kernel void global_const_vector4_p(global const char4 *globalconstchar4p,
                                   global const uchar4 *globalconstuchar4p,
                                   global const short4 *globalconstshort4p,
                                   global const ushort4 *globalconstushort4p,
                                   global const int4 *globalconstint4p,
                                   global const uint4 *globalconstuint4p,
                                   global const long4 *globalconstlong4p,
                                   global const ulong4 *globalconstulong4p,
                                   global const float4 *globalconstfloat4p) {}

kernel void global_const_vector4_restrict_p(
    global const char4 *restrict globalconstchar4restrictp,
    global const uchar4 *restrict globalconstuchar4restrictp,
    global const short4 *restrict globalconstshort4restrictp,
    global const ushort4 *restrict globalconstushort4restrictp,
    global const int4 *restrict globalconstint4restrictp,
    global const uint4 *restrict globalconstuint4restrictp,
    global const long4 *restrict globalconstlong4restrictp,
    global const ulong4 *restrict globalconstulong4restrictp,
    global const float4 *restrict globalconstfloat4restrictp) {}

kernel void
global_volatile_vector4_p(global volatile char4 *globalvolatilechar4p,
                          global volatile uchar4 *globalvolatileuchar4p,
                          global volatile short4 *globalvolatileshort4p,
                          global volatile ushort4 *globalvolatileushort4p,
                          global volatile int4 *globalvolatileint4p,
                          global volatile uint4 *globalvolatileuint4p,
                          global volatile long4 *globalvolatilelong4p,
                          global volatile ulong4 *globalvolatileulong4p,
                          global volatile float4 *globalvolatilefloat4p) {}

kernel void global_volatile_vector4_restrict_p(
    global volatile char4 *restrict globalvolatilechar4restrictp,
    global volatile uchar4 *restrict globalvolatileuchar4restrictp,
    global volatile short4 *restrict globalvolatileshort4restrictp,
    global volatile ushort4 *restrict globalvolatileushort4restrictp,
    global volatile int4 *restrict globalvolatileint4restrictp,
    global volatile uint4 *restrict globalvolatileuint4restrictp,
    global volatile long4 *restrict globalvolatilelong4restrictp,
    global volatile ulong4 *restrict globalvolatileulong4restrictp,
    global volatile float4 *restrict globalvolatilefloat4restrictp) {}

kernel void global_const_volatile_vector4_p(
    global const volatile char4 *globalconstvolatilechar4p,
    global const volatile uchar4 *globalconstvolatileuchar4p,
    global const volatile short4 *globalconstvolatileshort4p,
    global const volatile ushort4 *globalconstvolatileushort4p,
    global const volatile int4 *globalconstvolatileint4p,
    global const volatile uint4 *globalconstvolatileuint4p,
    global const volatile long4 *globalconstvolatilelong4p,
    global const volatile ulong4 *globalconstvolatileulong4p,
    global const volatile float4 *globalconstvolatilefloat4p) {}

kernel void global_const_volatile_vector4_restrict_p(
    global const volatile char4 *restrict globalconstvolatilechar4restrictp,
    global const volatile uchar4 *restrict globalconstvolatileuchar4restrictp,
    global const volatile short4 *restrict globalconstvolatileshort4restrictp,
    global const volatile ushort4 *restrict globalconstvolatileushort4restrictp,
    global const volatile int4 *restrict globalconstvolatileint4restrictp,
    global const volatile uint4 *restrict globalconstvolatileuint4restrictp,
    global const volatile long4 *restrict globalconstvolatilelong4restrictp,
    global const volatile ulong4 *restrict globalconstvolatileulong4restrictp,
    global const volatile float4 *restrict globalconstvolatilefloat4restrictp) {
}

kernel void
local_vector4_p(local char4 *localchar4p, local uchar4 *localuchar4p,
                local short4 *localshort4p, local ushort4 *localushort4p,
                local int4 *localint4p, local uint4 *localuint4p,
                local long4 *locallong4p, local ulong4 *localulong4p,
                local float4 *localfloat4p) {}

kernel void
local_vector4_restrict_p(local char4 *restrict localchar4restrictp,
                         local uchar4 *restrict localuchar4restrictp,
                         local short4 *restrict localshort4restrictp,
                         local ushort4 *restrict localushort4restrictp,
                         local int4 *restrict localint4restrictp,
                         local uint4 *restrict localuint4restrictp,
                         local long4 *restrict locallong4restrictp,
                         local ulong4 *restrict localulong4restrictp,
                         local float4 *restrict localfloat4restrictp) {}

kernel void local_const_vector4_p(local const char4 *localconstchar4p,
                                  local const uchar4 *localconstuchar4p,
                                  local const short4 *localconstshort4p,
                                  local const ushort4 *localconstushort4p,
                                  local const int4 *localconstint4p,
                                  local const uint4 *localconstuint4p,
                                  local const long4 *localconstlong4p,
                                  local const ulong4 *localconstulong4p,
                                  local const float4 *localconstfloat4p) {}

kernel void local_const_vector4_restrict_p(
    local const char4 *restrict localconstchar4restrictp,
    local const uchar4 *restrict localconstuchar4restrictp,
    local const short4 *restrict localconstshort4restrictp,
    local const ushort4 *restrict localconstushort4restrictp,
    local const int4 *restrict localconstint4restrictp,
    local const uint4 *restrict localconstuint4restrictp,
    local const long4 *restrict localconstlong4restrictp,
    local const ulong4 *restrict localconstulong4restrictp,
    local const float4 *restrict localconstfloat4restrictp) {}

kernel void
local_volatile_vector4_p(local volatile char4 *localvolatilechar4p,
                         local volatile uchar4 *localvolatileuchar4p,
                         local volatile short4 *localvolatileshort4p,
                         local volatile ushort4 *localvolatileushort4p,
                         local volatile int4 *localvolatileint4p,
                         local volatile uint4 *localvolatileuint4p,
                         local volatile long4 *localvolatilelong4p,
                         local volatile ulong4 *localvolatileulong4p,
                         local volatile float4 *localvolatilefloat4p) {}

kernel void local_volatile_vector4_restrict_p(
    local volatile char4 *restrict localvolatilechar4restrictp,
    local volatile uchar4 *restrict localvolatileuchar4restrictp,
    local volatile short4 *restrict localvolatileshort4restrictp,
    local volatile ushort4 *restrict localvolatileushort4restrictp,
    local volatile int4 *restrict localvolatileint4restrictp,
    local volatile uint4 *restrict localvolatileuint4restrictp,
    local volatile long4 *restrict localvolatilelong4restrictp,
    local volatile ulong4 *restrict localvolatileulong4restrictp,
    local volatile float4 *restrict localvolatilefloat4restrictp) {}

kernel void local_const_volatile_vector4_p(
    local const volatile char4 *localconstvolatilechar4p,
    local const volatile uchar4 *localconstvolatileuchar4p,
    local const volatile short4 *localconstvolatileshort4p,
    local const volatile ushort4 *localconstvolatileushort4p,
    local const volatile int4 *localconstvolatileint4p,
    local const volatile uint4 *localconstvolatileuint4p,
    local const volatile long4 *localconstvolatilelong4p,
    local const volatile ulong4 *localconstvolatileulong4p,
    local const volatile float4 *localconstvolatilefloat4p) {}

kernel void local_const_volatile_vector4_restrict_p(
    local const volatile char4 *restrict localconstvolatilechar4restrictp,
    local const volatile uchar4 *restrict localconstvolatileuchar4restrictp,
    local const volatile short4 *restrict localconstvolatileshort4restrictp,
    local const volatile ushort4 *restrict localconstvolatileushort4restrictp,
    local const volatile int4 *restrict localconstvolatileint4restrictp,
    local const volatile uint4 *restrict localconstvolatileuint4restrictp,
    local const volatile long4 *restrict localconstvolatilelong4restrictp,
    local const volatile ulong4 *restrict localconstvolatileulong4restrictp,
    local const volatile float4 *restrict localconstvolatilefloat4restrictp) {}

kernel void vector4_d(char4 char4d, uchar4 uchar4d, short4 short4d,
                      ushort4 ushort4d, int4 int4d, uint4 uint4d, long4 long4d,
                      ulong4 ulong4d, float4 float4d) {}

kernel void const_vector4_d(const char4 constchar4d, const uchar4 constuchar4d,
                            const short4 constshort4d,
                            const ushort4 constushort4d, const int4 constint4d,
                            const uint4 constuint4d, const long4 constlong4d,
                            const ulong4 constulong4d,
                            const float4 constfloat4d) {}

kernel void
private_vector4_d(private char4 privatechar4d, private uchar4 privateuchar4d,
                  private short4 privateshort4d,
                  private ushort4 privateushort4d, private int4 privateint4d,
                  private uint4 privateuint4d, private long4 privatelong4d,
                  private ulong4 privateulong4d,
                  private float4 privatefloat4d) {}

kernel void private_const_vector4_d(private const char4 privateconstchar4d,
                                    private const uchar4 privateconstuchar4d,
                                    private const short4 privateconstshort4d,
                                    private const ushort4 privateconstushort4d,
                                    private const int4 privateconstint4d,
                                    private const uint4 privateconstuint4d,
                                    private const long4 privateconstlong4d,
                                    private const ulong4 privateconstulong4d,
                                    private const float4 privateconstfloat4d) {}

kernel void constant_vector8_p0(constant char8 *constantchar8p,
                                constant uchar8 *constantuchar8p,
                                constant short8 *constantshort8p,
                                constant ushort8 *constantushort8p) {}

kernel void constant_vector8_p1(constant int8 *constantint8p,
                                constant uint8 *constantuint8p,
                                constant long8 *constantlong8p,
                                constant ulong8 *constantulong8p) {}

kernel void constant_vector8_p2(constant float8 *constantfloat8p) {}

kernel void constant_vector8_restrict_p0(
    constant char8 *restrict constantchar8restrictp,
    constant uchar8 *restrict constantuchar8restrictp,
    constant short8 *restrict constantshort8restrictp,
    constant ushort8 *restrict constantushort8restrictp) {}

kernel void constant_vector8_restrict_p1(
    constant int8 *restrict constantint8restrictp,
    constant uint8 *restrict constantuint8restrictp,
    constant long8 *restrict constantlong8restrictp,
    constant ulong8 *restrict constantulong8restrictp) {}

kernel void constant_vector8_restrict_p2(
    constant float8 *restrict constantfloat8restrictp) {}

kernel void
global_vector8_p(global char8 *globalchar8p, global uchar8 *globaluchar8p,
                 global short8 *globalshort8p, global ushort8 *globalushort8p,
                 global int8 *globalint8p, global uint8 *globaluint8p,
                 global long8 *globallong8p, global ulong8 *globalulong8p,
                 global float8 *globalfloat8p) {}

kernel void
global_vector8_restrict_p(global char8 *restrict globalchar8restrictp,
                          global uchar8 *restrict globaluchar8restrictp,
                          global short8 *restrict globalshort8restrictp,
                          global ushort8 *restrict globalushort8restrictp,
                          global int8 *restrict globalint8restrictp,
                          global uint8 *restrict globaluint8restrictp,
                          global long8 *restrict globallong8restrictp,
                          global ulong8 *restrict globalulong8restrictp,
                          global float8 *restrict globalfloat8restrictp) {}

kernel void global_const_vector8_p(global const char8 *globalconstchar8p,
                                   global const uchar8 *globalconstuchar8p,
                                   global const short8 *globalconstshort8p,
                                   global const ushort8 *globalconstushort8p,
                                   global const int8 *globalconstint8p,
                                   global const uint8 *globalconstuint8p,
                                   global const long8 *globalconstlong8p,
                                   global const ulong8 *globalconstulong8p,
                                   global const float8 *globalconstfloat8p) {}

kernel void global_const_vector8_restrict_p(
    global const char8 *restrict globalconstchar8restrictp,
    global const uchar8 *restrict globalconstuchar8restrictp,
    global const short8 *restrict globalconstshort8restrictp,
    global const ushort8 *restrict globalconstushort8restrictp,
    global const int8 *restrict globalconstint8restrictp,
    global const uint8 *restrict globalconstuint8restrictp,
    global const long8 *restrict globalconstlong8restrictp,
    global const ulong8 *restrict globalconstulong8restrictp,
    global const float8 *restrict globalconstfloat8restrictp) {}

kernel void
global_volatile_vector8_p(global volatile char8 *globalvolatilechar8p,
                          global volatile uchar8 *globalvolatileuchar8p,
                          global volatile short8 *globalvolatileshort8p,
                          global volatile ushort8 *globalvolatileushort8p,
                          global volatile int8 *globalvolatileint8p,
                          global volatile uint8 *globalvolatileuint8p,
                          global volatile long8 *globalvolatilelong8p,
                          global volatile ulong8 *globalvolatileulong8p,
                          global volatile float8 *globalvolatilefloat8p) {}

kernel void global_volatile_vector8_restrict_p(
    global volatile char8 *restrict globalvolatilechar8restrictp,
    global volatile uchar8 *restrict globalvolatileuchar8restrictp,
    global volatile short8 *restrict globalvolatileshort8restrictp,
    global volatile ushort8 *restrict globalvolatileushort8restrictp,
    global volatile int8 *restrict globalvolatileint8restrictp,
    global volatile uint8 *restrict globalvolatileuint8restrictp,
    global volatile long8 *restrict globalvolatilelong8restrictp,
    global volatile ulong8 *restrict globalvolatileulong8restrictp,
    global volatile float8 *restrict globalvolatilefloat8restrictp) {}

kernel void global_const_volatile_vector8_p(
    global const volatile char8 *globalconstvolatilechar8p,
    global const volatile uchar8 *globalconstvolatileuchar8p,
    global const volatile short8 *globalconstvolatileshort8p,
    global const volatile ushort8 *globalconstvolatileushort8p,
    global const volatile int8 *globalconstvolatileint8p,
    global const volatile uint8 *globalconstvolatileuint8p,
    global const volatile long8 *globalconstvolatilelong8p,
    global const volatile ulong8 *globalconstvolatileulong8p,
    global const volatile float8 *globalconstvolatilefloat8p) {}

kernel void global_const_volatile_vector8_restrict_p(
    global const volatile char8 *restrict globalconstvolatilechar8restrictp,
    global const volatile uchar8 *restrict globalconstvolatileuchar8restrictp,
    global const volatile short8 *restrict globalconstvolatileshort8restrictp,
    global const volatile ushort8 *restrict globalconstvolatileushort8restrictp,
    global const volatile int8 *restrict globalconstvolatileint8restrictp,
    global const volatile uint8 *restrict globalconstvolatileuint8restrictp,
    global const volatile long8 *restrict globalconstvolatilelong8restrictp,
    global const volatile ulong8 *restrict globalconstvolatileulong8restrictp,
    global const volatile float8 *restrict globalconstvolatilefloat8restrictp) {
}

kernel void
local_vector8_p(local char8 *localchar8p, local uchar8 *localuchar8p,
                local short8 *localshort8p, local ushort8 *localushort8p,
                local int8 *localint8p, local uint8 *localuint8p,
                local long8 *locallong8p, local ulong8 *localulong8p,
                local float8 *localfloat8p) {}

kernel void
local_vector8_restrict_p(local char8 *restrict localchar8restrictp,
                         local uchar8 *restrict localuchar8restrictp,
                         local short8 *restrict localshort8restrictp,
                         local ushort8 *restrict localushort8restrictp,
                         local int8 *restrict localint8restrictp,
                         local uint8 *restrict localuint8restrictp,
                         local long8 *restrict locallong8restrictp,
                         local ulong8 *restrict localulong8restrictp,
                         local float8 *restrict localfloat8restrictp) {}

kernel void local_const_vector8_p(local const char8 *localconstchar8p,
                                  local const uchar8 *localconstuchar8p,
                                  local const short8 *localconstshort8p,
                                  local const ushort8 *localconstushort8p,
                                  local const int8 *localconstint8p,
                                  local const uint8 *localconstuint8p,
                                  local const long8 *localconstlong8p,
                                  local const ulong8 *localconstulong8p,
                                  local const float8 *localconstfloat8p) {}

kernel void local_const_vector8_restrict_p(
    local const char8 *restrict localconstchar8restrictp,
    local const uchar8 *restrict localconstuchar8restrictp,
    local const short8 *restrict localconstshort8restrictp,
    local const ushort8 *restrict localconstushort8restrictp,
    local const int8 *restrict localconstint8restrictp,
    local const uint8 *restrict localconstuint8restrictp,
    local const long8 *restrict localconstlong8restrictp,
    local const ulong8 *restrict localconstulong8restrictp,
    local const float8 *restrict localconstfloat8restrictp) {}

kernel void
local_volatile_vector8_p(local volatile char8 *localvolatilechar8p,
                         local volatile uchar8 *localvolatileuchar8p,
                         local volatile short8 *localvolatileshort8p,
                         local volatile ushort8 *localvolatileushort8p,
                         local volatile int8 *localvolatileint8p,
                         local volatile uint8 *localvolatileuint8p,
                         local volatile long8 *localvolatilelong8p,
                         local volatile ulong8 *localvolatileulong8p,
                         local volatile float8 *localvolatilefloat8p) {}

kernel void local_volatile_vector8_restrict_p(
    local volatile char8 *restrict localvolatilechar8restrictp,
    local volatile uchar8 *restrict localvolatileuchar8restrictp,
    local volatile short8 *restrict localvolatileshort8restrictp,
    local volatile ushort8 *restrict localvolatileushort8restrictp,
    local volatile int8 *restrict localvolatileint8restrictp,
    local volatile uint8 *restrict localvolatileuint8restrictp,
    local volatile long8 *restrict localvolatilelong8restrictp,
    local volatile ulong8 *restrict localvolatileulong8restrictp,
    local volatile float8 *restrict localvolatilefloat8restrictp) {}

kernel void local_const_volatile_vector8_p(
    local const volatile char8 *localconstvolatilechar8p,
    local const volatile uchar8 *localconstvolatileuchar8p,
    local const volatile short8 *localconstvolatileshort8p,
    local const volatile ushort8 *localconstvolatileushort8p,
    local const volatile int8 *localconstvolatileint8p,
    local const volatile uint8 *localconstvolatileuint8p,
    local const volatile long8 *localconstvolatilelong8p,
    local const volatile ulong8 *localconstvolatileulong8p,
    local const volatile float8 *localconstvolatilefloat8p) {}

kernel void local_const_volatile_vector8_restrict_p(
    local const volatile char8 *restrict localconstvolatilechar8restrictp,
    local const volatile uchar8 *restrict localconstvolatileuchar8restrictp,
    local const volatile short8 *restrict localconstvolatileshort8restrictp,
    local const volatile ushort8 *restrict localconstvolatileushort8restrictp,
    local const volatile int8 *restrict localconstvolatileint8restrictp,
    local const volatile uint8 *restrict localconstvolatileuint8restrictp,
    local const volatile long8 *restrict localconstvolatilelong8restrictp,
    local const volatile ulong8 *restrict localconstvolatileulong8restrictp,
    local const volatile float8 *restrict localconstvolatilefloat8restrictp) {}

kernel void vector8_d(char8 char8d, uchar8 uchar8d, short8 short8d,
                      ushort8 ushort8d, int8 int8d, uint8 uint8d, long8 long8d,
                      ulong8 ulong8d, float8 float8d) {}

kernel void const_vector8_d(const char8 constchar8d, const uchar8 constuchar8d,
                            const short8 constshort8d,
                            const ushort8 constushort8d, const int8 constint8d,
                            const uint8 constuint8d, const long8 constlong8d,
                            const ulong8 constulong8d,
                            const float8 constfloat8d) {}

kernel void
private_vector8_d(private char8 privatechar8d, private uchar8 privateuchar8d,
                  private short8 privateshort8d,
                  private ushort8 privateushort8d, private int8 privateint8d,
                  private uint8 privateuint8d, private long8 privatelong8d,
                  private ulong8 privateulong8d,
                  private float8 privatefloat8d) {}

kernel void private_const_vector8_d(private const char8 privateconstchar8d,
                                    private const uchar8 privateconstuchar8d,
                                    private const short8 privateconstshort8d,
                                    private const ushort8 privateconstushort8d,
                                    private const int8 privateconstint8d,
                                    private const uint8 privateconstuint8d,
                                    private const long8 privateconstlong8d,
                                    private const ulong8 privateconstulong8d,
                                    private const float8 privateconstfloat8d) {}

kernel void constant_vector16_p0(constant char16 *constantchar16p,
                                 constant uchar16 *constantuchar16p,
                                 constant short16 *constantshort16p,
                                 constant ushort16 *constantushort16p) {}

kernel void constant_vector16_p1(constant int16 *constantint16p,
                                 constant uint16 *constantuint16p,
                                 constant long16 *constantlong16p,
                                 constant ulong16 *constantulong16p) {}

kernel void constant_vector16_p2(constant float16 *constantfloat16p) {}

kernel void constant_vector16_restrict_p0(
    constant char16 *restrict constantchar16restrictp,
    constant uchar16 *restrict constantuchar16restrictp,
    constant short16 *restrict constantshort16restrictp,
    constant ushort16 *restrict constantushort16restrictp) {}

kernel void constant_vector16_restrict_p1(
    constant int16 *restrict constantint16restrictp,
    constant uint16 *restrict constantuint16restrictp,
    constant long16 *restrict constantlong16restrictp,
    constant ulong16 *restrict constantulong16restrictp) {}

kernel void constant_vector16_restrict_p2(
    constant float16 *restrict constantfloat16restrictp) {}

kernel void
global_vector16_p(global char16 *globalchar16p, global uchar16 *globaluchar16p,
                  global short16 *globalshort16p,
                  global ushort16 *globalushort16p, global int16 *globalint16p,
                  global uint16 *globaluint16p, global long16 *globallong16p,
                  global ulong16 *globalulong16p,
                  global float16 *globalfloat16p) {}

kernel void
global_vector16_restrict_p(global char16 *restrict globalchar16restrictp,
                           global uchar16 *restrict globaluchar16restrictp,
                           global short16 *restrict globalshort16restrictp,
                           global ushort16 *restrict globalushort16restrictp,
                           global int16 *restrict globalint16restrictp,
                           global uint16 *restrict globaluint16restrictp,
                           global long16 *restrict globallong16restrictp,
                           global ulong16 *restrict globalulong16restrictp,
                           global float16 *restrict globalfloat16restrictp) {}

kernel void global_const_vector16_p(global const char16 *globalconstchar16p,
                                    global const uchar16 *globalconstuchar16p,
                                    global const short16 *globalconstshort16p,
                                    global const ushort16 *globalconstushort16p,
                                    global const int16 *globalconstint16p,
                                    global const uint16 *globalconstuint16p,
                                    global const long16 *globalconstlong16p,
                                    global const ulong16 *globalconstulong16p,
                                    global const float16 *globalconstfloat16p) {
}

kernel void global_const_vector16_restrict_p(
    global const char16 *restrict globalconstchar16restrictp,
    global const uchar16 *restrict globalconstuchar16restrictp,
    global const short16 *restrict globalconstshort16restrictp,
    global const ushort16 *restrict globalconstushort16restrictp,
    global const int16 *restrict globalconstint16restrictp,
    global const uint16 *restrict globalconstuint16restrictp,
    global const long16 *restrict globalconstlong16restrictp,
    global const ulong16 *restrict globalconstulong16restrictp,
    global const float16 *restrict globalconstfloat16restrictp) {}

kernel void
global_volatile_vector16_p(global volatile char16 *globalvolatilechar16p,
                           global volatile uchar16 *globalvolatileuchar16p,
                           global volatile short16 *globalvolatileshort16p,
                           global volatile ushort16 *globalvolatileushort16p,
                           global volatile int16 *globalvolatileint16p,
                           global volatile uint16 *globalvolatileuint16p,
                           global volatile long16 *globalvolatilelong16p,
                           global volatile ulong16 *globalvolatileulong16p,
                           global volatile float16 *globalvolatilefloat16p) {}

kernel void global_volatile_vector16_restrict_p(
    global volatile char16 *restrict globalvolatilechar16restrictp,
    global volatile uchar16 *restrict globalvolatileuchar16restrictp,
    global volatile short16 *restrict globalvolatileshort16restrictp,
    global volatile ushort16 *restrict globalvolatileushort16restrictp,
    global volatile int16 *restrict globalvolatileint16restrictp,
    global volatile uint16 *restrict globalvolatileuint16restrictp,
    global volatile long16 *restrict globalvolatilelong16restrictp,
    global volatile ulong16 *restrict globalvolatileulong16restrictp,
    global volatile float16 *restrict globalvolatilefloat16restrictp) {}

kernel void global_const_volatile_vector16_p(
    global const volatile char16 *globalconstvolatilechar16p,
    global const volatile uchar16 *globalconstvolatileuchar16p,
    global const volatile short16 *globalconstvolatileshort16p,
    global const volatile ushort16 *globalconstvolatileushort16p,
    global const volatile int16 *globalconstvolatileint16p,
    global const volatile uint16 *globalconstvolatileuint16p,
    global const volatile long16 *globalconstvolatilelong16p,
    global const volatile ulong16 *globalconstvolatileulong16p,
    global const volatile float16 *globalconstvolatilefloat16p) {}

kernel void global_const_volatile_vector16_restrict_p(
    global const volatile char16 *restrict globalconstvolatilechar16restrictp,
    global const volatile uchar16 *restrict globalconstvolatileuchar16restrictp,
    global const volatile short16 *restrict globalconstvolatileshort16restrictp,
    global const volatile ushort16
        *restrict globalconstvolatileushort16restrictp,
    global const volatile int16 *restrict globalconstvolatileint16restrictp,
    global const volatile uint16 *restrict globalconstvolatileuint16restrictp,
    global const volatile long16 *restrict globalconstvolatilelong16restrictp,
    global const volatile ulong16 *restrict globalconstvolatileulong16restrictp,
    global const volatile float16
        *restrict globalconstvolatilefloat16restrictp) {}

kernel void
local_vector16_p(local char16 *localchar16p, local uchar16 *localuchar16p,
                 local short16 *localshort16p, local ushort16 *localushort16p,
                 local int16 *localint16p, local uint16 *localuint16p,
                 local long16 *locallong16p, local ulong16 *localulong16p,
                 local float16 *localfloat16p) {}

kernel void
local_vector16_restrict_p(local char16 *restrict localchar16restrictp,
                          local uchar16 *restrict localuchar16restrictp,
                          local short16 *restrict localshort16restrictp,
                          local ushort16 *restrict localushort16restrictp,
                          local int16 *restrict localint16restrictp,
                          local uint16 *restrict localuint16restrictp,
                          local long16 *restrict locallong16restrictp,
                          local ulong16 *restrict localulong16restrictp,
                          local float16 *restrict localfloat16restrictp) {}

kernel void local_const_vector16_p(local const char16 *localconstchar16p,
                                   local const uchar16 *localconstuchar16p,
                                   local const short16 *localconstshort16p,
                                   local const ushort16 *localconstushort16p,
                                   local const int16 *localconstint16p,
                                   local const uint16 *localconstuint16p,
                                   local const long16 *localconstlong16p,
                                   local const ulong16 *localconstulong16p,
                                   local const float16 *localconstfloat16p) {}

kernel void local_const_vector16_restrict_p(
    local const char16 *restrict localconstchar16restrictp,
    local const uchar16 *restrict localconstuchar16restrictp,
    local const short16 *restrict localconstshort16restrictp,
    local const ushort16 *restrict localconstushort16restrictp,
    local const int16 *restrict localconstint16restrictp,
    local const uint16 *restrict localconstuint16restrictp,
    local const long16 *restrict localconstlong16restrictp,
    local const ulong16 *restrict localconstulong16restrictp,
    local const float16 *restrict localconstfloat16restrictp) {}

kernel void
local_volatile_vector16_p(local volatile char16 *localvolatilechar16p,
                          local volatile uchar16 *localvolatileuchar16p,
                          local volatile short16 *localvolatileshort16p,
                          local volatile ushort16 *localvolatileushort16p,
                          local volatile int16 *localvolatileint16p,
                          local volatile uint16 *localvolatileuint16p,
                          local volatile long16 *localvolatilelong16p,
                          local volatile ulong16 *localvolatileulong16p,
                          local volatile float16 *localvolatilefloat16p) {}

kernel void local_volatile_vector16_restrict_p(
    local volatile char16 *restrict localvolatilechar16restrictp,
    local volatile uchar16 *restrict localvolatileuchar16restrictp,
    local volatile short16 *restrict localvolatileshort16restrictp,
    local volatile ushort16 *restrict localvolatileushort16restrictp,
    local volatile int16 *restrict localvolatileint16restrictp,
    local volatile uint16 *restrict localvolatileuint16restrictp,
    local volatile long16 *restrict localvolatilelong16restrictp,
    local volatile ulong16 *restrict localvolatileulong16restrictp,
    local volatile float16 *restrict localvolatilefloat16restrictp) {}

kernel void local_const_volatile_vector16_p(
    local const volatile char16 *localconstvolatilechar16p,
    local const volatile uchar16 *localconstvolatileuchar16p,
    local const volatile short16 *localconstvolatileshort16p,
    local const volatile ushort16 *localconstvolatileushort16p,
    local const volatile int16 *localconstvolatileint16p,
    local const volatile uint16 *localconstvolatileuint16p,
    local const volatile long16 *localconstvolatilelong16p,
    local const volatile ulong16 *localconstvolatileulong16p,
    local const volatile float16 *localconstvolatilefloat16p) {}

kernel void local_const_volatile_vector16_restrict_p(
    local const volatile char16 *restrict localconstvolatilechar16restrictp,
    local const volatile uchar16 *restrict localconstvolatileuchar16restrictp,
    local const volatile short16 *restrict localconstvolatileshort16restrictp,
    local const volatile ushort16 *restrict localconstvolatileushort16restrictp,
    local const volatile int16 *restrict localconstvolatileint16restrictp,
    local const volatile uint16 *restrict localconstvolatileuint16restrictp,
    local const volatile long16 *restrict localconstvolatilelong16restrictp,
    local const volatile ulong16 *restrict localconstvolatileulong16restrictp,
    local const volatile float16 *restrict localconstvolatilefloat16restrictp) {
}

kernel void vector16_d(char16 char16d, uchar16 uchar16d, short16 short16d,
                       ushort16 ushort16d, int16 int16d, uint16 uint16d,
                       long16 long16d, ulong16 ulong16d, float16 float16d) {}

kernel void
const_vector16_d(const char16 constchar16d, const uchar16 constuchar16d,
                 const short16 constshort16d, const ushort16 constushort16d,
                 const int16 constint16d, const uint16 constuint16d,
                 const long16 constlong16d, const ulong16 constulong16d,
                 const float16 constfloat16d) {}

kernel void private_vector16_d(
    private char16 privatechar16d, private uchar16 privateuchar16d,
    private short16 privateshort16d, private ushort16 privateushort16d,
    private int16 privateint16d, private uint16 privateuint16d,
    private long16 privatelong16d, private ulong16 privateulong16d,
    private float16 privatefloat16d) {}

kernel void
private_const_vector16_d(private const char16 privateconstchar16d,
                         private const uchar16 privateconstuchar16d,
                         private const short16 privateconstshort16d,
                         private const ushort16 privateconstushort16d,
                         private const int16 privateconstint16d,
                         private const uint16 privateconstuint16d,
                         private const long16 privateconstlong16d,
                         private const ulong16 privateconstulong16d,
                         private const float16 privateconstfloat16d) {}

kernel void
constant_derived_p0(constant typedef_type *constanttypedef_typep,
                    constant struct struct_type *constantstructstruct_typep,
                    constant typedef_struct_type *constanttypedef_struct_typep,
                    constant union union_type *constantunionunion_typep) {}

kernel void
constant_derived_p1(constant typedef_union_type *constanttypedef_union_typep,
                    constant enum enum_type *constantenumenum_typep,
                    constant typedef_enum_type *constanttypedef_enum_typep) {}

kernel void constant_derived_restrict_p0(
    constant typedef_type *restrict constanttypedef_typerestrictp,
    constant struct struct_type *restrict constantstructstruct_typerestrictp,
    constant typedef_struct_type *restrict constanttypedef_struct_typerestrictp,
    constant union union_type *restrict constantunionunion_typerestrictp) {}

kernel void constant_derived_restrict_p1(
    constant typedef_union_type *restrict constanttypedef_union_typerestrictp,
    constant enum enum_type *restrict constantenumenum_typerestrictp,
    constant typedef_enum_type *restrict constanttypedef_enum_typerestrictp) {}

kernel void
global_derived_p(global typedef_type *globaltypedef_typep,
                 global struct struct_type *globalstructstruct_typep,
                 global typedef_struct_type *globaltypedef_struct_typep,
                 global union union_type *globalunionunion_typep,
                 global typedef_union_type *globaltypedef_union_typep,
                 global enum enum_type *globalenumenum_typep,
                 global typedef_enum_type *globaltypedef_enum_typep) {}

kernel void global_derived_restrict_p(
    global typedef_type *restrict globaltypedef_typerestrictp,
    global struct struct_type *restrict globalstructstruct_typerestrictp,
    global typedef_struct_type *restrict globaltypedef_struct_typerestrictp,
    global union union_type *restrict globalunionunion_typerestrictp,
    global typedef_union_type *restrict globaltypedef_union_typerestrictp,
    global enum enum_type *restrict globalenumenum_typerestrictp,
    global typedef_enum_type *restrict globaltypedef_enum_typerestrictp) {}

kernel void global_const_derived_p(
    global const typedef_type *globalconsttypedef_typep,
    global const struct struct_type *globalconststructstruct_typep,
    global const typedef_struct_type *globalconsttypedef_struct_typep,
    global const union union_type *globalconstunionunion_typep,
    global const typedef_union_type *globalconsttypedef_union_typep,
    global const enum enum_type *globalconstenumenum_typep,
    global const typedef_enum_type *globalconsttypedef_enum_typep) {}

kernel void global_const_derived_restrict_p(
    global const typedef_type *restrict globalconsttypedef_typerestrictp,
    global const struct struct_type
        *restrict globalconststructstruct_typerestrictp,
    global const typedef_struct_type
        *restrict globalconsttypedef_struct_typerestrictp,
    global const union union_type *restrict globalconstunionunion_typerestrictp,
    global const typedef_union_type
        *restrict globalconsttypedef_union_typerestrictp,
    global const enum enum_type *restrict globalconstenumenum_typerestrictp,
    global const typedef_enum_type
        *restrict globalconsttypedef_enum_typerestrictp) {}

kernel void global_volatile_derived_p(
    global volatile typedef_type *globalvolatiletypedef_typep,
    global volatile struct struct_type *globalvolatilestructstruct_typep,
    global volatile typedef_struct_type *globalvolatiletypedef_struct_typep,
    global volatile union union_type *globalvolatileunionunion_typep,
    global volatile typedef_union_type *globalvolatiletypedef_union_typep,
    global volatile enum enum_type *globalvolatileenumenum_typep,
    global volatile typedef_enum_type *globalvolatiletypedef_enum_typep) {}

kernel void global_volatile_derived_restrict_p(
    global volatile typedef_type *restrict globalvolatiletypedef_typerestrictp,
    global volatile struct struct_type
        *restrict globalvolatilestructstruct_typerestrictp,
    global volatile typedef_struct_type
        *restrict globalvolatiletypedef_struct_typerestrictp,
    global volatile union union_type
        *restrict globalvolatileunionunion_typerestrictp,
    global volatile typedef_union_type
        *restrict globalvolatiletypedef_union_typerestrictp,
    global volatile enum enum_type
        *restrict globalvolatileenumenum_typerestrictp,
    global volatile typedef_enum_type
        *restrict globalvolatiletypedef_enum_typerestrictp) {}

kernel void global_const_volatile_derived_p(
    global const volatile typedef_type *globalconstvolatiletypedef_typep,
    global const volatile struct struct_type
        *globalconstvolatilestructstruct_typep,
    global const volatile typedef_struct_type
        *globalconstvolatiletypedef_struct_typep,
    global const volatile union union_type *globalconstvolatileunionunion_typep,
    global const volatile typedef_union_type
        *globalconstvolatiletypedef_union_typep,
    global const volatile enum enum_type *globalconstvolatileenumenum_typep,
    global const volatile typedef_enum_type
        *globalconstvolatiletypedef_enum_typep) {}

kernel void global_const_volatile_derived_restrict_p(
    global const volatile typedef_type
        *restrict globalconstvolatiletypedef_typerestrictp,
    global const volatile struct struct_type
        *restrict globalconstvolatilestructstruct_typerestrictp,
    global const volatile typedef_struct_type
        *restrict globalconstvolatiletypedef_struct_typerestrictp,
    global const volatile union union_type
        *restrict globalconstvolatileunionunion_typerestrictp,
    global const volatile typedef_union_type
        *restrict globalconstvolatiletypedef_union_typerestrictp,
    global const volatile enum enum_type
        *restrict globalconstvolatileenumenum_typerestrictp,
    global const volatile typedef_enum_type
        *restrict globalconstvolatiletypedef_enum_typerestrictp) {}

kernel void
local_derived_p(local typedef_type *localtypedef_typep,
                local struct struct_type *localstructstruct_typep,
                local typedef_struct_type *localtypedef_struct_typep,
                local union union_type *localunionunion_typep,
                local typedef_union_type *localtypedef_union_typep,
                local enum enum_type *localenumenum_typep,
                local typedef_enum_type *localtypedef_enum_typep) {}

kernel void local_derived_restrict_p(
    local typedef_type *restrict localtypedef_typerestrictp,
    local struct struct_type *restrict localstructstruct_typerestrictp,
    local typedef_struct_type *restrict localtypedef_struct_typerestrictp,
    local union union_type *restrict localunionunion_typerestrictp,
    local typedef_union_type *restrict localtypedef_union_typerestrictp,
    local enum enum_type *restrict localenumenum_typerestrictp,
    local typedef_enum_type *restrict localtypedef_enum_typerestrictp) {}

kernel void local_const_derived_p(
    local const typedef_type *localconsttypedef_typep,
    local const struct struct_type *localconststructstruct_typep,
    local const typedef_struct_type *localconsttypedef_struct_typep,
    local const union union_type *localconstunionunion_typep,
    local const typedef_union_type *localconsttypedef_union_typep,
    local const enum enum_type *localconstenumenum_typep,
    local const typedef_enum_type *localconsttypedef_enum_typep) {}

kernel void local_const_derived_restrict_p(
    local const typedef_type *restrict localconsttypedef_typerestrictp,
    local const struct struct_type
        *restrict localconststructstruct_typerestrictp,
    local const typedef_struct_type
        *restrict localconsttypedef_struct_typerestrictp,
    local const union union_type *restrict localconstunionunion_typerestrictp,
    local const typedef_union_type
        *restrict localconsttypedef_union_typerestrictp,
    local const enum enum_type *restrict localconstenumenum_typerestrictp,
    local const typedef_enum_type
        *restrict localconsttypedef_enum_typerestrictp) {}

kernel void local_volatile_derived_p(
    local volatile typedef_type *localvolatiletypedef_typep,
    local volatile struct struct_type *localvolatilestructstruct_typep,
    local volatile typedef_struct_type *localvolatiletypedef_struct_typep,
    local volatile union union_type *localvolatileunionunion_typep,
    local volatile typedef_union_type *localvolatiletypedef_union_typep,
    local volatile enum enum_type *localvolatileenumenum_typep,
    local volatile typedef_enum_type *localvolatiletypedef_enum_typep) {}

kernel void local_volatile_derived_restrict_p(
    local volatile typedef_type *restrict localvolatiletypedef_typerestrictp,
    local volatile struct struct_type
        *restrict localvolatilestructstruct_typerestrictp,
    local volatile typedef_struct_type
        *restrict localvolatiletypedef_struct_typerestrictp,
    local volatile union union_type
        *restrict localvolatileunionunion_typerestrictp,
    local volatile typedef_union_type
        *restrict localvolatiletypedef_union_typerestrictp,
    local volatile enum enum_type *restrict localvolatileenumenum_typerestrictp,
    local volatile typedef_enum_type
        *restrict localvolatiletypedef_enum_typerestrictp) {}

kernel void local_const_volatile_derived_p(
    local const volatile typedef_type *localconstvolatiletypedef_typep,
    local const volatile struct struct_type
        *localconstvolatilestructstruct_typep,
    local const volatile typedef_struct_type
        *localconstvolatiletypedef_struct_typep,
    local const volatile union union_type *localconstvolatileunionunion_typep,
    local const volatile typedef_union_type
        *localconstvolatiletypedef_union_typep,
    local const volatile enum enum_type *localconstvolatileenumenum_typep,
    local const volatile typedef_enum_type
        *localconstvolatiletypedef_enum_typep) {}

kernel void local_const_volatile_derived_restrict_p(
    local const volatile typedef_type
        *restrict localconstvolatiletypedef_typerestrictp,
    local const volatile struct struct_type
        *restrict localconstvolatilestructstruct_typerestrictp,
    local const volatile typedef_struct_type
        *restrict localconstvolatiletypedef_struct_typerestrictp,
    local const volatile union union_type
        *restrict localconstvolatileunionunion_typerestrictp,
    local const volatile typedef_union_type
        *restrict localconstvolatiletypedef_union_typerestrictp,
    local const volatile enum enum_type
        *restrict localconstvolatileenumenum_typerestrictp,
    local const volatile typedef_enum_type
        *restrict localconstvolatiletypedef_enum_typerestrictp) {}

kernel void derived_d(typedef_type typedef_typed,
                      struct struct_type structstruct_typed,
                      typedef_struct_type typedef_struct_typed,
                      union union_type unionunion_typed,
                      typedef_union_type typedef_union_typed,
                      enum enum_type enumenum_typed,
                      typedef_enum_type typedef_enum_typed) {}

kernel void const_derived_d(const typedef_type consttypedef_typed,
                            const struct struct_type conststructstruct_typed,
                            const typedef_struct_type consttypedef_struct_typed,
                            const union union_type constunionunion_typed,
                            const typedef_union_type consttypedef_union_typed,
                            const enum enum_type constenumenum_typed,
                            const typedef_enum_type consttypedef_enum_typed) {}

kernel void
private_derived_d(private typedef_type privatetypedef_typed,
                  private struct struct_type privatestructstruct_typed,
                  private typedef_struct_type privatetypedef_struct_typed,
                  private union union_type privateunionunion_typed,
                  private typedef_union_type privatetypedef_union_typed,
                  private enum enum_type privateenumenum_typed,
                  private typedef_enum_type privatetypedef_enum_typed) {}

kernel void private_const_derived_d(
    private const typedef_type privateconsttypedef_typed,
    private const struct struct_type privateconststructstruct_typed,
    private const typedef_struct_type privateconsttypedef_struct_typed,
    private const union union_type privateconstunionunion_typed,
    private const typedef_union_type privateconsttypedef_union_typed,
    private const enum enum_type privateconstenumenum_typed,
    private const typedef_enum_type privateconsttypedef_enum_typed) {}
