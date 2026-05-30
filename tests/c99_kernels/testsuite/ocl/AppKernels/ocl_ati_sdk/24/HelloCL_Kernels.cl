//
// Copyright (c) 2009 Advanced Micro Devices, Inc. All rights reserved.
//

__kernel void
hello()
{
	/*
	Just a stub kernel.
	*/

    size_t i =  get_global_id(0);
    size_t j =  get_global_id(1);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
