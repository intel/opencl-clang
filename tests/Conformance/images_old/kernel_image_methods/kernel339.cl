// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
typedef struct {
  int width;
  int height;
  int depth;
  int widthDim;
  int heightDim;
  int depthDim;
  int channelType;
  int channelOrder;
  int expectedChannelType;
  int expectedChannelOrder;
} image_kernel_data;
__kernel void sample_kernel(read_only image2d_t input,
                            __global image_kernel_data *outData) {
  outData->width = get_image_width(input);
  outData->height = get_image_height(input);

  int2 dim = get_image_dim(input);
  outData->widthDim = dim.x;
  outData->heightDim = dim.y;

  outData->channelType = get_image_channel_data_type(input);
  outData->channelOrder = get_image_channel_order(input);

  outData->expectedChannelType = CLK_UNSIGNED_INT32;
  outData->expectedChannelOrder = CLK_R;
}