
__kernel void ckGray(__global const uchar4* src, __global uchar4* dst, int width, int height)
{
    int x = get_global_id(0);
    int y = get_global_id(1);
    int offset = mul24(y, width) + x;

	unsigned int grayvalue = (( 1053 * src[offset].x + 2064 * src[offset].y  + 401 * src[offset].z +67584 ) >> 12 );
	unsigned char Temp = (unsigned char)grayvalue;

    dst[offset].x = Temp;
    dst[offset].y = Temp;
    dst[offset].z = Temp;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
