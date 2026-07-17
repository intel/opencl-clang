// RUN: %occ-cli %s %cfg_path --cl-device=%cl_device --output=%t.bc
// RUN: %occ-cli %s %cfg_path --cl-options="-DUSE_CHANNELS -cl-std=CL2.0" --cl-version=200 --use-channels --cl-device=%cl_device --output=%t.bc
// XFAIL: *

#ifndef cl_intel_channels

#ifdef USE_CHANNELS
#error "cl_intel_channels expected to be enabled"
#endif

__kernel void foo() { int channel = 1; }

#else // cl_intel_channels

#ifndef USE_CHANNELS
#error "cl_intel_channels should NOT be enabled"
#endif

#pragma OPENCL EXTENSION cl_intel_channels : enable
channel int ch;
__kernel void foo() { int i = read_channel_intel(ch); }
#endif // cl_intel_channels
