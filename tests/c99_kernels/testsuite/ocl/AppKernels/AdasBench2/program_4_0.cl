__kernel void clearBuffer(__global unsigned char * src) {
	unsigned int gid = get_global_id(0);
        src[gid] = 0;
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
