// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
typedef struct {
  uint workDim;
  uint globalSize[3];
  uint globalID[3];
  uint localSize[3];
  uint localID[3];
  uint numGroups[3];
  uint groupID[3];
} work_item_data;

__kernel void sample_kernel(__global work_item_data *outData) {
  int id = get_global_id(0);
  outData[id].workDim = (uint)get_work_dim();
  for (uint i = 0; i < get_work_dim(); i++) {
    outData[id].globalSize[i] = (uint)get_global_size(i);
    outData[id].globalID[i] = (uint)get_global_id(i);
    outData[id].localSize[i] = (uint)get_local_size(i);
    outData[id].localID[i] = (uint)get_local_id(i);
    outData[id].numGroups[i] = (uint)get_num_groups(i);
    outData[id].groupID[i] = (uint)get_group_id(i);
  }
}