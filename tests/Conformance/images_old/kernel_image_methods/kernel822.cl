// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
typedef struct {
  int width;
  int arraySize;
  int channelType;
  int channelOrder;
  int expectedChannelType;
  int expectedChannelOrder;
} image_kernel_data;
__kernel void sample_kernel(read_only image1d_array_t input,
                            __global image_kernel_data *outData) {
  outData->width = get_image_width(input);
  outData->arraySize = get_image_array_size(input);
  outData->channelType = get_image_channel_data_type(input);
  outData->channelOrder = get_image_channel_order(input);

  outData->expectedChannelType = CLK_UNORM_INT8;
  outData->expectedChannelOrder = CLK_LUMINANCE;
}