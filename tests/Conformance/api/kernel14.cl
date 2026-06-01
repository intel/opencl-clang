// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
kernel void
double_scalar_p(constant double *constantdoublep,
                constant double *restrict constantdoublerestrictp,
                global double *globaldoublep,
                global double *restrict globaldoublerestrictp,
                global const double *globalconstdoublep,
                global const double *restrict globalconstdoublerestrictp,
                global volatile double *globalvolatiledoublep,
                global volatile double *restrict globalvolatiledoublerestrictp,
                global const volatile double *globalconstvolatiledoublep) {}

kernel void double_scalar_p2(
    global const volatile double *restrict globalconstvolatiledoublerestrictp,
    local double *localdoublep, local double *restrict localdoublerestrictp,
    local const double *localconstdoublep,
    local const double *restrict localconstdoublerestrictp,
    local volatile double *localvolatiledoublep,
    local volatile double *restrict localvolatiledoublerestrictp,
    local const volatile double *localconstvolatiledoublep,
    local const volatile double *restrict localconstvolatiledoublerestrictp) {}

kernel void double_scalar_d(double doubled, const double constdoubled,
                            private double privatedoubled,
                            private const double privateconstdoubled) {}

kernel void double_vector2_p(
    constant double2 *constantdouble2p,
    constant double2 *restrict constantdouble2restrictp,
    global double2 *globaldouble2p,
    global double2 *restrict globaldouble2restrictp,
    global const double2 *globalconstdouble2p,
    global const double2 *restrict globalconstdouble2restrictp,
    global volatile double2 *globalvolatiledouble2p,
    global volatile double2 *restrict globalvolatiledouble2restrictp,
    global const volatile double2 *globalconstvolatiledouble2p) {}

kernel void double_vector2_p2(
    global const volatile double2 *restrict globalconstvolatiledouble2restrictp,
    local double2 *localdouble2p, local double2 *restrict localdouble2restrictp,
    local const double2 *localconstdouble2p,
    local const double2 *restrict localconstdouble2restrictp,
    local volatile double2 *localvolatiledouble2p,
    local volatile double2 *restrict localvolatiledouble2restrictp,
    local const volatile double2 *localconstvolatiledouble2p,
    local const volatile double2 *restrict localconstvolatiledouble2restrictp) {
}

kernel void double_vector2_d(double2 double2d, const double2 constdouble2d,
                             private double2 privatedouble2d,
                             private const double2 privateconstdouble2d) {}

kernel void double_vector3_p(
    constant double3 *constantdouble3p,
    constant double3 *restrict constantdouble3restrictp,
    global double3 *globaldouble3p,
    global double3 *restrict globaldouble3restrictp,
    global const double3 *globalconstdouble3p,
    global const double3 *restrict globalconstdouble3restrictp,
    global volatile double3 *globalvolatiledouble3p,
    global volatile double3 *restrict globalvolatiledouble3restrictp,
    global const volatile double3 *globalconstvolatiledouble3p) {}

kernel void double_vector3_p2(
    global const volatile double3 *restrict globalconstvolatiledouble3restrictp,
    local double3 *localdouble3p, local double3 *restrict localdouble3restrictp,
    local const double3 *localconstdouble3p,
    local const double3 *restrict localconstdouble3restrictp,
    local volatile double3 *localvolatiledouble3p,
    local volatile double3 *restrict localvolatiledouble3restrictp,
    local const volatile double3 *localconstvolatiledouble3p,
    local const volatile double3 *restrict localconstvolatiledouble3restrictp) {
}

kernel void double_vector3_d(double3 double3d, const double3 constdouble3d,
                             private double3 privatedouble3d,
                             private const double3 privateconstdouble3d) {}

kernel void double_vector4_p(
    constant double4 *constantdouble4p,
    constant double4 *restrict constantdouble4restrictp,
    global double4 *globaldouble4p,
    global double4 *restrict globaldouble4restrictp,
    global const double4 *globalconstdouble4p,
    global const double4 *restrict globalconstdouble4restrictp,
    global volatile double4 *globalvolatiledouble4p,
    global volatile double4 *restrict globalvolatiledouble4restrictp,
    global const volatile double4 *globalconstvolatiledouble4p) {}

kernel void double_vector4_p2(
    global const volatile double4 *restrict globalconstvolatiledouble4restrictp,
    local double4 *localdouble4p, local double4 *restrict localdouble4restrictp,
    local const double4 *localconstdouble4p,
    local const double4 *restrict localconstdouble4restrictp,
    local volatile double4 *localvolatiledouble4p,
    local volatile double4 *restrict localvolatiledouble4restrictp,
    local const volatile double4 *localconstvolatiledouble4p,
    local const volatile double4 *restrict localconstvolatiledouble4restrictp) {
}

kernel void double_vector4_d(double4 double4d, const double4 constdouble4d,
                             private double4 privatedouble4d,
                             private const double4 privateconstdouble4d) {}

kernel void double_vector8_p(
    constant double8 *constantdouble8p,
    constant double8 *restrict constantdouble8restrictp,
    global double8 *globaldouble8p,
    global double8 *restrict globaldouble8restrictp,
    global const double8 *globalconstdouble8p,
    global const double8 *restrict globalconstdouble8restrictp,
    global volatile double8 *globalvolatiledouble8p,
    global volatile double8 *restrict globalvolatiledouble8restrictp,
    global const volatile double8 *globalconstvolatiledouble8p) {}

kernel void double_vector8_p2(
    global const volatile double8 *restrict globalconstvolatiledouble8restrictp,
    local double8 *localdouble8p, local double8 *restrict localdouble8restrictp,
    local const double8 *localconstdouble8p,
    local const double8 *restrict localconstdouble8restrictp,
    local volatile double8 *localvolatiledouble8p,
    local volatile double8 *restrict localvolatiledouble8restrictp,
    local const volatile double8 *localconstvolatiledouble8p,
    local const volatile double8 *restrict localconstvolatiledouble8restrictp) {
}

kernel void double_vector8_d(double8 double8d, const double8 constdouble8d,
                             private double8 privatedouble8d,
                             private const double8 privateconstdouble8d) {}

kernel void double_vector16_p(
    constant double16 *constantdouble16p,
    constant double16 *restrict constantdouble16restrictp,
    global double16 *globaldouble16p,
    global double16 *restrict globaldouble16restrictp,
    global const double16 *globalconstdouble16p,
    global const double16 *restrict globalconstdouble16restrictp,
    global volatile double16 *globalvolatiledouble16p,
    global volatile double16 *restrict globalvolatiledouble16restrictp,
    global const volatile double16 *globalconstvolatiledouble16p) {}

kernel void double_vector16_p2(
    global const volatile double16
        *restrict globalconstvolatiledouble16restrictp,
    local double16 *localdouble16p,
    local double16 *restrict localdouble16restrictp,
    local const double16 *localconstdouble16p,
    local const double16 *restrict localconstdouble16restrictp,
    local volatile double16 *localvolatiledouble16p,
    local volatile double16 *restrict localvolatiledouble16restrictp,
    local const volatile double16 *localconstvolatiledouble16p,
    local const volatile double16
        *restrict localconstvolatiledouble16restrictp) {}

kernel void double_vector16_d(double16 double16d, const double16 constdouble16d,
                              private double16 privatedouble16d,
                              private const double16 privateconstdouble16d) {}
