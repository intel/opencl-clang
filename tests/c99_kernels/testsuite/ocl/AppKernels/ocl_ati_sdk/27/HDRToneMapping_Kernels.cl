#pragma OPENCL EXTENSION cl_amd_printf : enable

float
luminance(float r, float g, float b)
{
    return ( 0.2126f * r ) + ( 0.7152f * g ) + ( 0.0722f * b );
}

__kernel
void toneMappingPattanaik1(__global float *input,
        __global float *output,
        float averageLuminance,
        float gamma,
        float c,
        float delta,
        uint width,
        uint numChannels,
        uint height)
{
    uint globalIdX = get_global_id(0);
    uint globalIdY = get_global_id(1);
    float r, r1;
    float g, g1;
    float b, b1;
    float yLuminance = 0.0f;
    float cLPattanaik = 0.0f;
    float yLPattanaik = 0.0f;
    r1 = input[width * numChannels * globalIdY + (globalIdX * numChannels + 0)];
    g1 = input[width * numChannels * globalIdY + (globalIdX * numChannels + 1)];
    b1 = input[width * numChannels * globalIdY + (globalIdX * numChannels + 2)];

    yLuminance = luminance(r1, g1, b1);

    float gcPattanaik = c * averageLuminance;

    if (globalIdX != 0 && globalIdY != 0 && globalIdX != width -1 && globalIdY != height -1)
    {
        //Calculating mean
        float leftUp = 0.0f;
        float up = 0.0f;
        float rightUp = 0.0f;
        float left = 0.0f;
        float right = 0.0f;
        float leftDown = 0.0f;
        float down = 0.0f;
        float rightDown = 0.0f;

        r = input[width * numChannels * (globalIdY - 1)+ ((globalIdX - 1) * numChannels) + 0 ];
        g = input[width * numChannels * (globalIdY - 1)+ ((globalIdX - 1) * numChannels) + 1 ];
        b = input[width * numChannels * (globalIdY - 1)+ ((globalIdX - 1) * numChannels) + 2 ];

        leftUp = luminance( r, g, b );

        r = input[width * numChannels * (globalIdY - 1) + ((globalIdX) * numChannels) + 0 ];
        g = input[width * numChannels * (globalIdY - 1) + ((globalIdX) * numChannels) + 1 ];
        b = input[width * numChannels * (globalIdY - 1) + ((globalIdX) * numChannels) + 2 ];

        up = luminance( r, g, b );

        r = input[width * numChannels * (globalIdY - 1) + ((globalIdX + 1) * numChannels) + 0 ];
        g = input[width * numChannels * (globalIdY - 1) + ((globalIdX + 1) * numChannels) + 1 ];
        b = input[width * numChannels * (globalIdY - 1) + ((globalIdX + 1) * numChannels) + 2 ];

        rightUp = luminance( r, g, b );

        r = input[width * numChannels * (globalIdY) + ((globalIdX - 1) * numChannels) + 0 ];
        g = input[width * numChannels * (globalIdY) + ((globalIdX - 1) * numChannels) + 1 ];
        b = input[width * numChannels * (globalIdY) + ((globalIdX - 1) * numChannels) + 2 ];

        left = luminance( r, g, b );

        r = input[width * numChannels * (globalIdY) + ((globalIdX + 1) * numChannels) + 0 ];
        g = input[width * numChannels * (globalIdY) + ((globalIdX + 1) * numChannels) + 1 ];
        b = input[width * numChannels * (globalIdY) + ((globalIdX + 1) * numChannels) + 2 ];

        right = luminance( r, g, b );

        r = input[width * numChannels * (globalIdY + 1) + ((globalIdX - 1) * numChannels) + 0 ];
        g = input[width * numChannels * (globalIdY + 1) + ((globalIdX - 1) * numChannels) + 1 ];
        b = input[width * numChannels * (globalIdY + 1) + ((globalIdX - 1) * numChannels) + 2 ];

        leftDown = luminance( r, g, b );

        r = input[width * numChannels * (globalIdY + 1) + ((globalIdX) * numChannels) + 0 ];
        g = input[width * numChannels * (globalIdY + 1) + ((globalIdX) * numChannels) + 1 ];
        b = input[width * numChannels * (globalIdY + 1) + ((globalIdX) * numChannels) + 2 ];

        down = luminance( r, g, b );

        r = input[width * numChannels * (globalIdY + 1) + ((globalIdX + 1) * numChannels) + 0 ];
        g = input[width * numChannels * (globalIdY + 1) + ((globalIdX + 1) * numChannels) + 1 ];
        b = input[width * numChannels * (globalIdY + 1) + ((globalIdX + 1) * numChannels) + 2 ];

        rightDown = luminance( r, g, b );

        //Calculate median

        yLPattanaik = (leftUp + up + rightUp + left + right + leftDown + down + rightDown) / 8;
    }
    else
    {
        yLPattanaik = yLuminance;
    }

    cLPattanaik =  yLPattanaik * log(delta + yLPattanaik / yLuminance) + gcPattanaik;

#ifdef __GPU__
    //cLPattanaik = cLPattanaik / 10;
#endif

    float yDPattanaik = yLuminance / (yLuminance + cLPattanaik);

    r = pow((r1 / yLuminance), gamma) * yDPattanaik;
    g = pow((g1 / yLuminance), gamma) * yDPattanaik;
    b = pow((b1 / yLuminance), gamma) * yDPattanaik;

    output[width * numChannels * globalIdY + (globalIdX * numChannels + 0)] = r;
    output[width * numChannels * globalIdY + (globalIdX * numChannels + 1)] = g;
    output[width * numChannels * globalIdY + (globalIdX * numChannels + 2)] = b;
    output[width * numChannels * globalIdY + (globalIdX * numChannels + 3)] = input[width * numChannels * globalIdY + (globalIdX * numChannels + 3)];
}

__kernel
void toneMappingPattanaik(__global float4 *input,
        __global float4 *output,
        float averageLuminance,
        float gamma,
        float c,
        float delta,
        uint width,
        uint numChannels,
        uint height)
{
    uint globalIdX = get_global_id(0);
    uint globalIdY = get_global_id(1);
    float r, r1;
    float g, g1;
    float b, b1;
    float yLuminance = 0.0f;
    float cLPattanaik = 0.0f;
    float yLPattanaik = 0.0f;
    r1 = input[width * globalIdY + globalIdX].x;
    g1 = input[width * globalIdY + globalIdX].y;
    b1 = input[width * globalIdY + globalIdX].z;

    yLuminance = luminance(r1, g1, b1);

    float gcPattanaik = c * averageLuminance;

    if (globalIdX != 0 && globalIdY != 0 && globalIdX != width -1 && globalIdY != height -1)
    {
        //Calculating mean
        float leftUp = 0.0f;
        float up = 0.0f;
        float rightUp = 0.0f;
        float left = 0.0f;
        float right = 0.0f;
        float leftDown = 0.0f;
        float down = 0.0f;
        float rightDown = 0.0f;

        r = input[width * (globalIdY - 1)+ globalIdX - 1].x;
        g = input[width * (globalIdY - 1)+ globalIdX - 1].y;
        b = input[width * (globalIdY - 1)+ globalIdX - 1].z;

        leftUp = luminance( r, g, b );

        r = input[width * (globalIdY - 1) + globalIdX].x;
		g = input[width * (globalIdY - 1) + globalIdX].y;
		b = input[width * (globalIdY - 1) + globalIdX].z;

        up = luminance( r, g, b );

        r = input[width * (globalIdY - 1) + globalIdX + 1].x;
        g = input[width * (globalIdY - 1) + globalIdX + 1].y;
        b = input[width * (globalIdY - 1) + globalIdX + 1].z;

        rightUp = luminance( r, g, b );

        r = input[width * globalIdY + globalIdX - 1].x;
        g = input[width * globalIdY + globalIdX - 1].y;
        b = input[width * globalIdY + globalIdX - 1].z;

        left = luminance( r, g, b );

        r = input[width * globalIdY + globalIdX + 1].x;
        g = input[width * globalIdY + globalIdX + 1].y;
        b = input[width * globalIdY + globalIdX + 1].z;

        right = luminance( r, g, b );

        r = input[width * (globalIdY + 1) + globalIdX - 1].x;
        g = input[width * (globalIdY + 1) + globalIdX - 1].y;
        b = input[width * (globalIdY + 1) + globalIdX - 1].z;

        leftDown = luminance( r, g, b );

        r = input[width * (globalIdY + 1) + globalIdX].x;
        g = input[width * (globalIdY + 1) + globalIdX].y;
        b = input[width * (globalIdY + 1) + globalIdX].z;

        down = luminance( r, g, b );

        r = input[width * (globalIdY + 1) + globalIdX + 1].x;
        g = input[width * (globalIdY + 1) + globalIdX + 1].y;
        b = input[width * (globalIdY + 1) + globalIdX + 1].z;

        rightDown = luminance( r, g, b );

        //Calculate median

        yLPattanaik = (leftUp + up + rightUp + left + right + leftDown + down + rightDown) / 8;
    }
    else
    {
        yLPattanaik = yLuminance;
    }

    cLPattanaik =  yLPattanaik * log(delta + yLPattanaik / yLuminance) + gcPattanaik;

#ifdef __GPU__
    //cLPattanaik = cLPattanaik / 10;
#endif

    float yDPattanaik = yLuminance / (yLuminance + cLPattanaik);

    r = pow((r1 / yLuminance), gamma) * yDPattanaik;
    g = pow((g1 / yLuminance), gamma) * yDPattanaik;
    b = pow((b1 / yLuminance), gamma) * yDPattanaik;

    output[width * globalIdY + globalIdX].x = r;
    output[width * globalIdY + globalIdX].y = g;
    output[width * globalIdY + globalIdX].z = b;
    output[width * globalIdY + globalIdX].w = input[width * globalIdY + globalIdX].w;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
