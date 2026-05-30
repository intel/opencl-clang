//Primary input is original surface
__kernel void specialKernel0(read_only image2d_t inputImage, write_only image2d_t outputImage)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
    int i = get_global_id(0);
    int j = get_global_id(1);
    //if (i>=src[0]) return;
    //if (j>=src[1]) return;
    float accumWeights = 0;
    float4 pixel_orig=read_imagef(inputImage,sampler,(int2)(i,j));
    //long4 pixel_orig_long=convert_long4(pixel_orig);
    float reduced = (float)((pixel_orig.x*20+pixel_orig.y*40+pixel_orig.z*1)/(20+40+1));;
    float4 pixel_new =  (float4)(reduced, reduced, reduced, 255);
    pixel_new.w = 255;
    write_imagef(outputImage,(int2)(i,j), pixel_new);
};
//Primary input is output of Pass0
__kernel void specialKernel1(read_only image2d_t inputImage, write_only image2d_t outputImage)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
    int i = get_global_id(0);
    int j = get_global_id(1);
    //if (i>=src[0]) return;
    //if (j>=src[1]) return;
    float accumWeights = 0;
    float4 pixel_orig=read_imagef(inputImage,sampler,(int2)(i,j));
    //long4 pixel_orig_long=convert_long4(pixel_orig);
    float4 pixel_new = (float4)(log10(pixel_orig.x),log10(pixel_orig.y),log10(pixel_orig.z),255);
    pixel_new.w = 255;
    write_imagef(outputImage,(int2)(i,j), pixel_new);
};
//Primary input is output of Pass1
__kernel void specialKernel2(read_only image2d_t inputImage, write_only image2d_t outputImage)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
    int i = get_global_id(0);
    int j = get_global_id(1);
    //if (i>=src[0]) return;
    //if (j>=src[1]) return;
    float accumWeights = 0;
    float4 pixel_orig=read_imagef(inputImage,sampler,(int2)(i,j));
    //long4 pixel_orig_long=convert_long4(pixel_orig);
    float4 pixel_new = (float4)(0, 0, 0, 255);
    float4 pixel0 = read_imagef(inputImage,sampler,(int2)(i+9,j+9));
    float4 pixel1 = read_imagef(inputImage,sampler,(int2)(i+9,j+8));
    float4 pixel2 = read_imagef(inputImage,sampler,(int2)(i+9,j+7));
    float4 pixel3 = read_imagef(inputImage,sampler,(int2)(i+9,j+6));
    float4 pixel4 = read_imagef(inputImage,sampler,(int2)(i+9,j+5));
    float4 pixel5 = read_imagef(inputImage,sampler,(int2)(i+9,j+4));
    float4 pixel6 = read_imagef(inputImage,sampler,(int2)(i+9,j+3));
    float4 pixel7 = read_imagef(inputImage,sampler,(int2)(i+9,j+2));
    float4 pixel8 = read_imagef(inputImage,sampler,(int2)(i+9,j+1));
    float4 pixel9 = read_imagef(inputImage,sampler,(int2)(i+9,j+0));
    float4 pixel10 = read_imagef(inputImage,sampler,(int2)(i+9,j-1));
    float4 pixel11 = read_imagef(inputImage,sampler,(int2)(i+9,j-2));
    float4 pixel12 = read_imagef(inputImage,sampler,(int2)(i+9,j-3));
    float4 pixel13 = read_imagef(inputImage,sampler,(int2)(i+9,j-4));
    float4 pixel14 = read_imagef(inputImage,sampler,(int2)(i+9,j-5));
    float4 pixel15 = read_imagef(inputImage,sampler,(int2)(i+9,j-6));
    float4 pixel16 = read_imagef(inputImage,sampler,(int2)(i+9,j-7));
    float4 pixel17 = read_imagef(inputImage,sampler,(int2)(i+9,j-8));
    float4 pixel18 = read_imagef(inputImage,sampler,(int2)(i+9,j-9));
    float4 pixel19 = read_imagef(inputImage,sampler,(int2)(i+8,j+9));
    float4 pixel20 = read_imagef(inputImage,sampler,(int2)(i+8,j+8));
    float4 pixel21 = read_imagef(inputImage,sampler,(int2)(i+8,j+7));
    float4 pixel22 = read_imagef(inputImage,sampler,(int2)(i+8,j+6));
    float4 pixel23 = read_imagef(inputImage,sampler,(int2)(i+8,j+5));
    float4 pixel24 = read_imagef(inputImage,sampler,(int2)(i+8,j+4));
    float4 pixel25 = read_imagef(inputImage,sampler,(int2)(i+8,j+3));
    float4 pixel26 = read_imagef(inputImage,sampler,(int2)(i+8,j+2));
    float4 pixel27 = read_imagef(inputImage,sampler,(int2)(i+8,j+1));
    float4 pixel28 = read_imagef(inputImage,sampler,(int2)(i+8,j+0));
    float4 pixel29 = read_imagef(inputImage,sampler,(int2)(i+8,j-1));
    float4 pixel30 = read_imagef(inputImage,sampler,(int2)(i+8,j-2));
    float4 pixel31 = read_imagef(inputImage,sampler,(int2)(i+8,j-3));
    float4 pixel32 = read_imagef(inputImage,sampler,(int2)(i+8,j-4));
    float4 pixel33 = read_imagef(inputImage,sampler,(int2)(i+8,j-5));
    float4 pixel34 = read_imagef(inputImage,sampler,(int2)(i+8,j-6));
    float4 pixel35 = read_imagef(inputImage,sampler,(int2)(i+8,j-7));
    float4 pixel36 = read_imagef(inputImage,sampler,(int2)(i+8,j-8));
    float4 pixel37 = read_imagef(inputImage,sampler,(int2)(i+8,j-9));
    float4 pixel38 = read_imagef(inputImage,sampler,(int2)(i+7,j+9));
    float4 pixel39 = read_imagef(inputImage,sampler,(int2)(i+7,j+8));
    float4 pixel40 = read_imagef(inputImage,sampler,(int2)(i+7,j+7));
    float4 pixel41 = read_imagef(inputImage,sampler,(int2)(i+7,j+6));
    float4 pixel42 = read_imagef(inputImage,sampler,(int2)(i+7,j+5));
    float4 pixel43 = read_imagef(inputImage,sampler,(int2)(i+7,j+4));
    float4 pixel44 = read_imagef(inputImage,sampler,(int2)(i+7,j+3));
    float4 pixel45 = read_imagef(inputImage,sampler,(int2)(i+7,j+2));
    float4 pixel46 = read_imagef(inputImage,sampler,(int2)(i+7,j+1));
    float4 pixel47 = read_imagef(inputImage,sampler,(int2)(i+7,j+0));
    float4 pixel48 = read_imagef(inputImage,sampler,(int2)(i+7,j-1));
    float4 pixel49 = read_imagef(inputImage,sampler,(int2)(i+7,j-2));
    float4 pixel50 = read_imagef(inputImage,sampler,(int2)(i+7,j-3));
    float4 pixel51 = read_imagef(inputImage,sampler,(int2)(i+7,j-4));
    float4 pixel52 = read_imagef(inputImage,sampler,(int2)(i+7,j-5));
    float4 pixel53 = read_imagef(inputImage,sampler,(int2)(i+7,j-6));
    float4 pixel54 = read_imagef(inputImage,sampler,(int2)(i+7,j-7));
    float4 pixel55 = read_imagef(inputImage,sampler,(int2)(i+7,j-8));
    float4 pixel56 = read_imagef(inputImage,sampler,(int2)(i+7,j-9));
    float4 pixel57 = read_imagef(inputImage,sampler,(int2)(i+6,j+9));
    float4 pixel58 = read_imagef(inputImage,sampler,(int2)(i+6,j+8));
    float4 pixel59 = read_imagef(inputImage,sampler,(int2)(i+6,j+7));
    float4 pixel60 = read_imagef(inputImage,sampler,(int2)(i+6,j+6));
    float4 pixel61 = read_imagef(inputImage,sampler,(int2)(i+6,j+5));
    float4 pixel62 = read_imagef(inputImage,sampler,(int2)(i+6,j+4));
    float4 pixel63 = read_imagef(inputImage,sampler,(int2)(i+6,j+3));
    float4 pixel64 = read_imagef(inputImage,sampler,(int2)(i+6,j+2));
    float4 pixel65 = read_imagef(inputImage,sampler,(int2)(i+6,j+1));
    float4 pixel66 = read_imagef(inputImage,sampler,(int2)(i+6,j+0));
    float4 pixel67 = read_imagef(inputImage,sampler,(int2)(i+6,j-1));
    float4 pixel68 = read_imagef(inputImage,sampler,(int2)(i+6,j-2));
    float4 pixel69 = read_imagef(inputImage,sampler,(int2)(i+6,j-3));
    float4 pixel70 = read_imagef(inputImage,sampler,(int2)(i+6,j-4));
    float4 pixel71 = read_imagef(inputImage,sampler,(int2)(i+6,j-5));
    float4 pixel72 = read_imagef(inputImage,sampler,(int2)(i+6,j-6));
    float4 pixel73 = read_imagef(inputImage,sampler,(int2)(i+6,j-7));
    float4 pixel74 = read_imagef(inputImage,sampler,(int2)(i+6,j-8));
    float4 pixel75 = read_imagef(inputImage,sampler,(int2)(i+6,j-9));
    float4 pixel76 = read_imagef(inputImage,sampler,(int2)(i+5,j+9));
    float4 pixel77 = read_imagef(inputImage,sampler,(int2)(i+5,j+8));
    float4 pixel78 = read_imagef(inputImage,sampler,(int2)(i+5,j+7));
    float4 pixel79 = read_imagef(inputImage,sampler,(int2)(i+5,j+6));
    float4 pixel80 = read_imagef(inputImage,sampler,(int2)(i+5,j+5));
    float4 pixel81 = read_imagef(inputImage,sampler,(int2)(i+5,j+4));
    float4 pixel82 = read_imagef(inputImage,sampler,(int2)(i+5,j+3));
    float4 pixel83 = read_imagef(inputImage,sampler,(int2)(i+5,j+2));
    float4 pixel84 = read_imagef(inputImage,sampler,(int2)(i+5,j+1));
    float4 pixel85 = read_imagef(inputImage,sampler,(int2)(i+5,j+0));
    float4 pixel86 = read_imagef(inputImage,sampler,(int2)(i+5,j-1));
    float4 pixel87 = read_imagef(inputImage,sampler,(int2)(i+5,j-2));
    float4 pixel88 = read_imagef(inputImage,sampler,(int2)(i+5,j-3));
    float4 pixel89 = read_imagef(inputImage,sampler,(int2)(i+5,j-4));
    float4 pixel90 = read_imagef(inputImage,sampler,(int2)(i+5,j-5));
    float4 pixel91 = read_imagef(inputImage,sampler,(int2)(i+5,j-6));
    float4 pixel92 = read_imagef(inputImage,sampler,(int2)(i+5,j-7));
    float4 pixel93 = read_imagef(inputImage,sampler,(int2)(i+5,j-8));
    float4 pixel94 = read_imagef(inputImage,sampler,(int2)(i+5,j-9));
    float4 pixel95 = read_imagef(inputImage,sampler,(int2)(i+4,j+9));
    float4 pixel96 = read_imagef(inputImage,sampler,(int2)(i+4,j+8));
    float4 pixel97 = read_imagef(inputImage,sampler,(int2)(i+4,j+7));
    float4 pixel98 = read_imagef(inputImage,sampler,(int2)(i+4,j+6));
    float4 pixel99 = read_imagef(inputImage,sampler,(int2)(i+4,j+5));
    float4 pixel100 = read_imagef(inputImage,sampler,(int2)(i+4,j+4));
    float4 pixel101 = read_imagef(inputImage,sampler,(int2)(i+4,j+3));
    float4 pixel102 = read_imagef(inputImage,sampler,(int2)(i+4,j+2));
    float4 pixel103 = read_imagef(inputImage,sampler,(int2)(i+4,j+1));
    float4 pixel104 = read_imagef(inputImage,sampler,(int2)(i+4,j+0));
    float4 pixel105 = read_imagef(inputImage,sampler,(int2)(i+4,j-1));
    float4 pixel106 = read_imagef(inputImage,sampler,(int2)(i+4,j-2));
    float4 pixel107 = read_imagef(inputImage,sampler,(int2)(i+4,j-3));
    float4 pixel108 = read_imagef(inputImage,sampler,(int2)(i+4,j-4));
    float4 pixel109 = read_imagef(inputImage,sampler,(int2)(i+4,j-5));
    float4 pixel110 = read_imagef(inputImage,sampler,(int2)(i+4,j-6));
    float4 pixel111 = read_imagef(inputImage,sampler,(int2)(i+4,j-7));
    float4 pixel112 = read_imagef(inputImage,sampler,(int2)(i+4,j-8));
    float4 pixel113 = read_imagef(inputImage,sampler,(int2)(i+4,j-9));
    float4 pixel114 = read_imagef(inputImage,sampler,(int2)(i+3,j+9));
    float4 pixel115 = read_imagef(inputImage,sampler,(int2)(i+3,j+8));
    float4 pixel116 = read_imagef(inputImage,sampler,(int2)(i+3,j+7));
    float4 pixel117 = read_imagef(inputImage,sampler,(int2)(i+3,j+6));
    float4 pixel118 = read_imagef(inputImage,sampler,(int2)(i+3,j+5));
    float4 pixel119 = read_imagef(inputImage,sampler,(int2)(i+3,j+4));
    float4 pixel120 = read_imagef(inputImage,sampler,(int2)(i+3,j+3));
    float4 pixel121 = read_imagef(inputImage,sampler,(int2)(i+3,j+2));
    float4 pixel122 = read_imagef(inputImage,sampler,(int2)(i+3,j+1));
    float4 pixel123 = read_imagef(inputImage,sampler,(int2)(i+3,j+0));
    float4 pixel124 = read_imagef(inputImage,sampler,(int2)(i+3,j-1));
    float4 pixel125 = read_imagef(inputImage,sampler,(int2)(i+3,j-2));
    float4 pixel126 = read_imagef(inputImage,sampler,(int2)(i+3,j-3));
    float4 pixel127 = read_imagef(inputImage,sampler,(int2)(i+3,j-4));
    float4 pixel128 = read_imagef(inputImage,sampler,(int2)(i+3,j-5));
    float4 pixel129 = read_imagef(inputImage,sampler,(int2)(i+3,j-6));
    float4 pixel130 = read_imagef(inputImage,sampler,(int2)(i+3,j-7));
    float4 pixel131 = read_imagef(inputImage,sampler,(int2)(i+3,j-8));
    float4 pixel132 = read_imagef(inputImage,sampler,(int2)(i+3,j-9));
    float4 pixel133 = read_imagef(inputImage,sampler,(int2)(i+2,j+9));
    float4 pixel134 = read_imagef(inputImage,sampler,(int2)(i+2,j+8));
    float4 pixel135 = read_imagef(inputImage,sampler,(int2)(i+2,j+7));
    float4 pixel136 = read_imagef(inputImage,sampler,(int2)(i+2,j+6));
    float4 pixel137 = read_imagef(inputImage,sampler,(int2)(i+2,j+5));
    float4 pixel138 = read_imagef(inputImage,sampler,(int2)(i+2,j+4));
    float4 pixel139 = read_imagef(inputImage,sampler,(int2)(i+2,j+3));
    float4 pixel140 = read_imagef(inputImage,sampler,(int2)(i+2,j+2));
    float4 pixel141 = read_imagef(inputImage,sampler,(int2)(i+2,j+1));
    float4 pixel142 = read_imagef(inputImage,sampler,(int2)(i+2,j+0));
    float4 pixel143 = read_imagef(inputImage,sampler,(int2)(i+2,j-1));
    float4 pixel144 = read_imagef(inputImage,sampler,(int2)(i+2,j-2));
    float4 pixel145 = read_imagef(inputImage,sampler,(int2)(i+2,j-3));
    float4 pixel146 = read_imagef(inputImage,sampler,(int2)(i+2,j-4));
    float4 pixel147 = read_imagef(inputImage,sampler,(int2)(i+2,j-5));
    float4 pixel148 = read_imagef(inputImage,sampler,(int2)(i+2,j-6));
    float4 pixel149 = read_imagef(inputImage,sampler,(int2)(i+2,j-7));
    float4 pixel150 = read_imagef(inputImage,sampler,(int2)(i+2,j-8));
    float4 pixel151 = read_imagef(inputImage,sampler,(int2)(i+2,j-9));
    float4 pixel152 = read_imagef(inputImage,sampler,(int2)(i+1,j+9));
    float4 pixel153 = read_imagef(inputImage,sampler,(int2)(i+1,j+8));
    float4 pixel154 = read_imagef(inputImage,sampler,(int2)(i+1,j+7));
    float4 pixel155 = read_imagef(inputImage,sampler,(int2)(i+1,j+6));
    float4 pixel156 = read_imagef(inputImage,sampler,(int2)(i+1,j+5));
    float4 pixel157 = read_imagef(inputImage,sampler,(int2)(i+1,j+4));
    float4 pixel158 = read_imagef(inputImage,sampler,(int2)(i+1,j+3));
    float4 pixel159 = read_imagef(inputImage,sampler,(int2)(i+1,j+2));
    float4 pixel160 = read_imagef(inputImage,sampler,(int2)(i+1,j+1));
    float4 pixel161 = read_imagef(inputImage,sampler,(int2)(i+1,j+0));
    float4 pixel162 = read_imagef(inputImage,sampler,(int2)(i+1,j-1));
    float4 pixel163 = read_imagef(inputImage,sampler,(int2)(i+1,j-2));
    float4 pixel164 = read_imagef(inputImage,sampler,(int2)(i+1,j-3));
    float4 pixel165 = read_imagef(inputImage,sampler,(int2)(i+1,j-4));
    float4 pixel166 = read_imagef(inputImage,sampler,(int2)(i+1,j-5));
    float4 pixel167 = read_imagef(inputImage,sampler,(int2)(i+1,j-6));
    float4 pixel168 = read_imagef(inputImage,sampler,(int2)(i+1,j-7));
    float4 pixel169 = read_imagef(inputImage,sampler,(int2)(i+1,j-8));
    float4 pixel170 = read_imagef(inputImage,sampler,(int2)(i+1,j-9));
    float4 pixel171 = read_imagef(inputImage,sampler,(int2)(i-0,j+9));
    float4 pixel172 = read_imagef(inputImage,sampler,(int2)(i-0,j+8));
    float4 pixel173 = read_imagef(inputImage,sampler,(int2)(i-0,j+7));
    float4 pixel174 = read_imagef(inputImage,sampler,(int2)(i-0,j+6));
    float4 pixel175 = read_imagef(inputImage,sampler,(int2)(i-0,j+5));
    float4 pixel176 = read_imagef(inputImage,sampler,(int2)(i-0,j+4));
    float4 pixel177 = read_imagef(inputImage,sampler,(int2)(i-0,j+3));
    float4 pixel178 = read_imagef(inputImage,sampler,(int2)(i-0,j+2));
    float4 pixel179 = read_imagef(inputImage,sampler,(int2)(i-0,j+1));
    float4 pixel180 = read_imagef(inputImage,sampler,(int2)(i-0,j+0));
    float4 pixel181 = read_imagef(inputImage,sampler,(int2)(i-0,j-1));
    float4 pixel182 = read_imagef(inputImage,sampler,(int2)(i-0,j-2));
    float4 pixel183 = read_imagef(inputImage,sampler,(int2)(i-0,j-3));
    float4 pixel184 = read_imagef(inputImage,sampler,(int2)(i-0,j-4));
    float4 pixel185 = read_imagef(inputImage,sampler,(int2)(i-0,j-5));
    float4 pixel186 = read_imagef(inputImage,sampler,(int2)(i-0,j-6));
    float4 pixel187 = read_imagef(inputImage,sampler,(int2)(i-0,j-7));
    float4 pixel188 = read_imagef(inputImage,sampler,(int2)(i-0,j-8));
    float4 pixel189 = read_imagef(inputImage,sampler,(int2)(i-0,j-9));
    float4 pixel190 = read_imagef(inputImage,sampler,(int2)(i-1,j+9));
    float4 pixel191 = read_imagef(inputImage,sampler,(int2)(i-1,j+8));
    float4 pixel192 = read_imagef(inputImage,sampler,(int2)(i-1,j+7));
    float4 pixel193 = read_imagef(inputImage,sampler,(int2)(i-1,j+6));
    float4 pixel194 = read_imagef(inputImage,sampler,(int2)(i-1,j+5));
    float4 pixel195 = read_imagef(inputImage,sampler,(int2)(i-1,j+4));
    float4 pixel196 = read_imagef(inputImage,sampler,(int2)(i-1,j+3));
    float4 pixel197 = read_imagef(inputImage,sampler,(int2)(i-1,j+2));
    float4 pixel198 = read_imagef(inputImage,sampler,(int2)(i-1,j+1));
    float4 pixel199 = read_imagef(inputImage,sampler,(int2)(i-1,j+0));
    float4 pixel200 = read_imagef(inputImage,sampler,(int2)(i-1,j-1));
    float4 pixel201 = read_imagef(inputImage,sampler,(int2)(i-1,j-2));
    float4 pixel202 = read_imagef(inputImage,sampler,(int2)(i-1,j-3));
    float4 pixel203 = read_imagef(inputImage,sampler,(int2)(i-1,j-4));
    float4 pixel204 = read_imagef(inputImage,sampler,(int2)(i-1,j-5));
    float4 pixel205 = read_imagef(inputImage,sampler,(int2)(i-1,j-6));
    float4 pixel206 = read_imagef(inputImage,sampler,(int2)(i-1,j-7));
    float4 pixel207 = read_imagef(inputImage,sampler,(int2)(i-1,j-8));
    float4 pixel208 = read_imagef(inputImage,sampler,(int2)(i-1,j-9));
    float4 pixel209 = read_imagef(inputImage,sampler,(int2)(i-2,j+9));
    float4 pixel210 = read_imagef(inputImage,sampler,(int2)(i-2,j+8));
    float4 pixel211 = read_imagef(inputImage,sampler,(int2)(i-2,j+7));
    float4 pixel212 = read_imagef(inputImage,sampler,(int2)(i-2,j+6));
    float4 pixel213 = read_imagef(inputImage,sampler,(int2)(i-2,j+5));
    float4 pixel214 = read_imagef(inputImage,sampler,(int2)(i-2,j+4));
    float4 pixel215 = read_imagef(inputImage,sampler,(int2)(i-2,j+3));
    float4 pixel216 = read_imagef(inputImage,sampler,(int2)(i-2,j+2));
    float4 pixel217 = read_imagef(inputImage,sampler,(int2)(i-2,j+1));
    float4 pixel218 = read_imagef(inputImage,sampler,(int2)(i-2,j+0));
    float4 pixel219 = read_imagef(inputImage,sampler,(int2)(i-2,j-1));
    float4 pixel220 = read_imagef(inputImage,sampler,(int2)(i-2,j-2));
    float4 pixel221 = read_imagef(inputImage,sampler,(int2)(i-2,j-3));
    float4 pixel222 = read_imagef(inputImage,sampler,(int2)(i-2,j-4));
    float4 pixel223 = read_imagef(inputImage,sampler,(int2)(i-2,j-5));
    float4 pixel224 = read_imagef(inputImage,sampler,(int2)(i-2,j-6));
    float4 pixel225 = read_imagef(inputImage,sampler,(int2)(i-2,j-7));
    float4 pixel226 = read_imagef(inputImage,sampler,(int2)(i-2,j-8));
    float4 pixel227 = read_imagef(inputImage,sampler,(int2)(i-2,j-9));
    float4 pixel228 = read_imagef(inputImage,sampler,(int2)(i-3,j+9));
    float4 pixel229 = read_imagef(inputImage,sampler,(int2)(i-3,j+8));
    float4 pixel230 = read_imagef(inputImage,sampler,(int2)(i-3,j+7));
    float4 pixel231 = read_imagef(inputImage,sampler,(int2)(i-3,j+6));
    float4 pixel232 = read_imagef(inputImage,sampler,(int2)(i-3,j+5));
    float4 pixel233 = read_imagef(inputImage,sampler,(int2)(i-3,j+4));
    float4 pixel234 = read_imagef(inputImage,sampler,(int2)(i-3,j+3));
    float4 pixel235 = read_imagef(inputImage,sampler,(int2)(i-3,j+2));
    float4 pixel236 = read_imagef(inputImage,sampler,(int2)(i-3,j+1));
    float4 pixel237 = read_imagef(inputImage,sampler,(int2)(i-3,j+0));
    float4 pixel238 = read_imagef(inputImage,sampler,(int2)(i-3,j-1));
    float4 pixel239 = read_imagef(inputImage,sampler,(int2)(i-3,j-2));
    float4 pixel240 = read_imagef(inputImage,sampler,(int2)(i-3,j-3));
    float4 pixel241 = read_imagef(inputImage,sampler,(int2)(i-3,j-4));
    float4 pixel242 = read_imagef(inputImage,sampler,(int2)(i-3,j-5));
    float4 pixel243 = read_imagef(inputImage,sampler,(int2)(i-3,j-6));
    float4 pixel244 = read_imagef(inputImage,sampler,(int2)(i-3,j-7));
    float4 pixel245 = read_imagef(inputImage,sampler,(int2)(i-3,j-8));
    float4 pixel246 = read_imagef(inputImage,sampler,(int2)(i-3,j-9));
    float4 pixel247 = read_imagef(inputImage,sampler,(int2)(i-4,j+9));
    float4 pixel248 = read_imagef(inputImage,sampler,(int2)(i-4,j+8));
    float4 pixel249 = read_imagef(inputImage,sampler,(int2)(i-4,j+7));
    float4 pixel250 = read_imagef(inputImage,sampler,(int2)(i-4,j+6));
    float4 pixel251 = read_imagef(inputImage,sampler,(int2)(i-4,j+5));
    float4 pixel252 = read_imagef(inputImage,sampler,(int2)(i-4,j+4));
    float4 pixel253 = read_imagef(inputImage,sampler,(int2)(i-4,j+3));
    float4 pixel254 = read_imagef(inputImage,sampler,(int2)(i-4,j+2));
    float4 pixel255 = read_imagef(inputImage,sampler,(int2)(i-4,j+1));
    float4 pixel256 = read_imagef(inputImage,sampler,(int2)(i-4,j+0));
    float4 pixel257 = read_imagef(inputImage,sampler,(int2)(i-4,j-1));
    float4 pixel258 = read_imagef(inputImage,sampler,(int2)(i-4,j-2));
    float4 pixel259 = read_imagef(inputImage,sampler,(int2)(i-4,j-3));
    float4 pixel260 = read_imagef(inputImage,sampler,(int2)(i-4,j-4));
    float4 pixel261 = read_imagef(inputImage,sampler,(int2)(i-4,j-5));
    float4 pixel262 = read_imagef(inputImage,sampler,(int2)(i-4,j-6));
    float4 pixel263 = read_imagef(inputImage,sampler,(int2)(i-4,j-7));
    float4 pixel264 = read_imagef(inputImage,sampler,(int2)(i-4,j-8));
    float4 pixel265 = read_imagef(inputImage,sampler,(int2)(i-4,j-9));
    float4 pixel266 = read_imagef(inputImage,sampler,(int2)(i-5,j+9));
    float4 pixel267 = read_imagef(inputImage,sampler,(int2)(i-5,j+8));
    float4 pixel268 = read_imagef(inputImage,sampler,(int2)(i-5,j+7));
    float4 pixel269 = read_imagef(inputImage,sampler,(int2)(i-5,j+6));
    float4 pixel270 = read_imagef(inputImage,sampler,(int2)(i-5,j+5));
    float4 pixel271 = read_imagef(inputImage,sampler,(int2)(i-5,j+4));
    float4 pixel272 = read_imagef(inputImage,sampler,(int2)(i-5,j+3));
    float4 pixel273 = read_imagef(inputImage,sampler,(int2)(i-5,j+2));
    float4 pixel274 = read_imagef(inputImage,sampler,(int2)(i-5,j+1));
    float4 pixel275 = read_imagef(inputImage,sampler,(int2)(i-5,j+0));
    float4 pixel276 = read_imagef(inputImage,sampler,(int2)(i-5,j-1));
    float4 pixel277 = read_imagef(inputImage,sampler,(int2)(i-5,j-2));
    float4 pixel278 = read_imagef(inputImage,sampler,(int2)(i-5,j-3));
    float4 pixel279 = read_imagef(inputImage,sampler,(int2)(i-5,j-4));
    float4 pixel280 = read_imagef(inputImage,sampler,(int2)(i-5,j-5));
    float4 pixel281 = read_imagef(inputImage,sampler,(int2)(i-5,j-6));
    float4 pixel282 = read_imagef(inputImage,sampler,(int2)(i-5,j-7));
    float4 pixel283 = read_imagef(inputImage,sampler,(int2)(i-5,j-8));
    float4 pixel284 = read_imagef(inputImage,sampler,(int2)(i-5,j-9));
    float4 pixel285 = read_imagef(inputImage,sampler,(int2)(i-6,j+9));
    float4 pixel286 = read_imagef(inputImage,sampler,(int2)(i-6,j+8));
    float4 pixel287 = read_imagef(inputImage,sampler,(int2)(i-6,j+7));
    float4 pixel288 = read_imagef(inputImage,sampler,(int2)(i-6,j+6));
    float4 pixel289 = read_imagef(inputImage,sampler,(int2)(i-6,j+5));
    float4 pixel290 = read_imagef(inputImage,sampler,(int2)(i-6,j+4));
    float4 pixel291 = read_imagef(inputImage,sampler,(int2)(i-6,j+3));
    float4 pixel292 = read_imagef(inputImage,sampler,(int2)(i-6,j+2));
    float4 pixel293 = read_imagef(inputImage,sampler,(int2)(i-6,j+1));
    float4 pixel294 = read_imagef(inputImage,sampler,(int2)(i-6,j+0));
    float4 pixel295 = read_imagef(inputImage,sampler,(int2)(i-6,j-1));
    float4 pixel296 = read_imagef(inputImage,sampler,(int2)(i-6,j-2));
    float4 pixel297 = read_imagef(inputImage,sampler,(int2)(i-6,j-3));
    float4 pixel298 = read_imagef(inputImage,sampler,(int2)(i-6,j-4));
    float4 pixel299 = read_imagef(inputImage,sampler,(int2)(i-6,j-5));
    float4 pixel300 = read_imagef(inputImage,sampler,(int2)(i-6,j-6));
    float4 pixel301 = read_imagef(inputImage,sampler,(int2)(i-6,j-7));
    float4 pixel302 = read_imagef(inputImage,sampler,(int2)(i-6,j-8));
    float4 pixel303 = read_imagef(inputImage,sampler,(int2)(i-6,j-9));
    float4 pixel304 = read_imagef(inputImage,sampler,(int2)(i-7,j+9));
    float4 pixel305 = read_imagef(inputImage,sampler,(int2)(i-7,j+8));
    float4 pixel306 = read_imagef(inputImage,sampler,(int2)(i-7,j+7));
    float4 pixel307 = read_imagef(inputImage,sampler,(int2)(i-7,j+6));
    float4 pixel308 = read_imagef(inputImage,sampler,(int2)(i-7,j+5));
    float4 pixel309 = read_imagef(inputImage,sampler,(int2)(i-7,j+4));
    float4 pixel310 = read_imagef(inputImage,sampler,(int2)(i-7,j+3));
    float4 pixel311 = read_imagef(inputImage,sampler,(int2)(i-7,j+2));
    float4 pixel312 = read_imagef(inputImage,sampler,(int2)(i-7,j+1));
    float4 pixel313 = read_imagef(inputImage,sampler,(int2)(i-7,j+0));
    float4 pixel314 = read_imagef(inputImage,sampler,(int2)(i-7,j-1));
    float4 pixel315 = read_imagef(inputImage,sampler,(int2)(i-7,j-2));
    float4 pixel316 = read_imagef(inputImage,sampler,(int2)(i-7,j-3));
    float4 pixel317 = read_imagef(inputImage,sampler,(int2)(i-7,j-4));
    float4 pixel318 = read_imagef(inputImage,sampler,(int2)(i-7,j-5));
    float4 pixel319 = read_imagef(inputImage,sampler,(int2)(i-7,j-6));
    float4 pixel320 = read_imagef(inputImage,sampler,(int2)(i-7,j-7));
    float4 pixel321 = read_imagef(inputImage,sampler,(int2)(i-7,j-8));
    float4 pixel322 = read_imagef(inputImage,sampler,(int2)(i-7,j-9));
    float4 pixel323 = read_imagef(inputImage,sampler,(int2)(i-8,j+9));
    float4 pixel324 = read_imagef(inputImage,sampler,(int2)(i-8,j+8));
    float4 pixel325 = read_imagef(inputImage,sampler,(int2)(i-8,j+7));
    float4 pixel326 = read_imagef(inputImage,sampler,(int2)(i-8,j+6));
    float4 pixel327 = read_imagef(inputImage,sampler,(int2)(i-8,j+5));
    float4 pixel328 = read_imagef(inputImage,sampler,(int2)(i-8,j+4));
    float4 pixel329 = read_imagef(inputImage,sampler,(int2)(i-8,j+3));
    float4 pixel330 = read_imagef(inputImage,sampler,(int2)(i-8,j+2));
    float4 pixel331 = read_imagef(inputImage,sampler,(int2)(i-8,j+1));
    float4 pixel332 = read_imagef(inputImage,sampler,(int2)(i-8,j+0));
    float4 pixel333 = read_imagef(inputImage,sampler,(int2)(i-8,j-1));
    float4 pixel334 = read_imagef(inputImage,sampler,(int2)(i-8,j-2));
    float4 pixel335 = read_imagef(inputImage,sampler,(int2)(i-8,j-3));
    float4 pixel336 = read_imagef(inputImage,sampler,(int2)(i-8,j-4));
    float4 pixel337 = read_imagef(inputImage,sampler,(int2)(i-8,j-5));
    float4 pixel338 = read_imagef(inputImage,sampler,(int2)(i-8,j-6));
    float4 pixel339 = read_imagef(inputImage,sampler,(int2)(i-8,j-7));
    float4 pixel340 = read_imagef(inputImage,sampler,(int2)(i-8,j-8));
    float4 pixel341 = read_imagef(inputImage,sampler,(int2)(i-8,j-9));
    float4 pixel342 = read_imagef(inputImage,sampler,(int2)(i-9,j+9));
    float4 pixel343 = read_imagef(inputImage,sampler,(int2)(i-9,j+8));
    float4 pixel344 = read_imagef(inputImage,sampler,(int2)(i-9,j+7));
    float4 pixel345 = read_imagef(inputImage,sampler,(int2)(i-9,j+6));
    float4 pixel346 = read_imagef(inputImage,sampler,(int2)(i-9,j+5));
    float4 pixel347 = read_imagef(inputImage,sampler,(int2)(i-9,j+4));
    float4 pixel348 = read_imagef(inputImage,sampler,(int2)(i-9,j+3));
    float4 pixel349 = read_imagef(inputImage,sampler,(int2)(i-9,j+2));
    float4 pixel350 = read_imagef(inputImage,sampler,(int2)(i-9,j+1));
    float4 pixel351 = read_imagef(inputImage,sampler,(int2)(i-9,j+0));
    float4 pixel352 = read_imagef(inputImage,sampler,(int2)(i-9,j-1));
    float4 pixel353 = read_imagef(inputImage,sampler,(int2)(i-9,j-2));
    float4 pixel354 = read_imagef(inputImage,sampler,(int2)(i-9,j-3));
    float4 pixel355 = read_imagef(inputImage,sampler,(int2)(i-9,j-4));
    float4 pixel356 = read_imagef(inputImage,sampler,(int2)(i-9,j-5));
    float4 pixel357 = read_imagef(inputImage,sampler,(int2)(i-9,j-6));
    float4 pixel358 = read_imagef(inputImage,sampler,(int2)(i-9,j-7));
    float4 pixel359 = read_imagef(inputImage,sampler,(int2)(i-9,j-8));
    float4 pixel360 = read_imagef(inputImage,sampler,(int2)(i-9,j-9));
    float pixel0_prcntDiffR = fabs((pixel0.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel0_prcntDiffG = fabs((pixel0.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel0_prcntDiffB = fabs((pixel0.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel0_prcntDiffA = fabs((pixel0.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel0_prcntDiffR<16)&& (pixel0_prcntDiffG<16)&&(pixel0_prcntDiffB<16 )&&(pixel0_prcntDiffA<16)){
	    pixel_new += (pixel0)*(float)2.0; accumWeights += 2;
    }
    float pixel1_prcntDiffR = fabs((pixel1.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel1_prcntDiffG = fabs((pixel1.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel1_prcntDiffB = fabs((pixel1.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel1_prcntDiffA = fabs((pixel1.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel1_prcntDiffR<16)&& (pixel1_prcntDiffG<16)&&(pixel1_prcntDiffB<16 )&&(pixel1_prcntDiffA<16)){
	    pixel_new += (pixel1)*(float)3.0; accumWeights += 3;
    }
    float pixel2_prcntDiffR = fabs((pixel2.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel2_prcntDiffG = fabs((pixel2.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel2_prcntDiffB = fabs((pixel2.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel2_prcntDiffA = fabs((pixel2.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel2_prcntDiffR<16)&& (pixel2_prcntDiffG<16)&&(pixel2_prcntDiffB<16 )&&(pixel2_prcntDiffA<16)){
	    pixel_new += (pixel2)*(float)5.0; accumWeights += 5;
    }
    float pixel3_prcntDiffR = fabs((pixel3.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel3_prcntDiffG = fabs((pixel3.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel3_prcntDiffB = fabs((pixel3.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel3_prcntDiffA = fabs((pixel3.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel3_prcntDiffR<16)&& (pixel3_prcntDiffG<16)&&(pixel3_prcntDiffB<16 )&&(pixel3_prcntDiffA<16)){
	    pixel_new += (pixel3)*(float)7.0; accumWeights += 7;
    }
    float pixel4_prcntDiffR = fabs((pixel4.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel4_prcntDiffG = fabs((pixel4.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel4_prcntDiffB = fabs((pixel4.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel4_prcntDiffA = fabs((pixel4.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel4_prcntDiffR<16)&& (pixel4_prcntDiffG<16)&&(pixel4_prcntDiffB<16 )&&(pixel4_prcntDiffA<16)){
	    pixel_new += (pixel4)*(float)9.0; accumWeights += 9;
    }
    float pixel5_prcntDiffR = fabs((pixel5.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel5_prcntDiffG = fabs((pixel5.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel5_prcntDiffB = fabs((pixel5.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel5_prcntDiffA = fabs((pixel5.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel5_prcntDiffR<16)&& (pixel5_prcntDiffG<16)&&(pixel5_prcntDiffB<16 )&&(pixel5_prcntDiffA<16)){
	    pixel_new += (pixel5)*(float)11.0; accumWeights += 11;
    }
    float pixel6_prcntDiffR = fabs((pixel6.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel6_prcntDiffG = fabs((pixel6.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel6_prcntDiffB = fabs((pixel6.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel6_prcntDiffA = fabs((pixel6.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel6_prcntDiffR<16)&& (pixel6_prcntDiffG<16)&&(pixel6_prcntDiffB<16 )&&(pixel6_prcntDiffA<16)){
	    pixel_new += (pixel6)*(float)13.0; accumWeights += 13;
    }
    float pixel7_prcntDiffR = fabs((pixel7.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel7_prcntDiffG = fabs((pixel7.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel7_prcntDiffB = fabs((pixel7.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel7_prcntDiffA = fabs((pixel7.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel7_prcntDiffR<16)&& (pixel7_prcntDiffG<16)&&(pixel7_prcntDiffB<16 )&&(pixel7_prcntDiffA<16)){
	    pixel_new += (pixel7)*(float)15.0; accumWeights += 15;
    }
    float pixel8_prcntDiffR = fabs((pixel8.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel8_prcntDiffG = fabs((pixel8.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel8_prcntDiffB = fabs((pixel8.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel8_prcntDiffA = fabs((pixel8.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel8_prcntDiffR<16)&& (pixel8_prcntDiffG<16)&&(pixel8_prcntDiffB<16 )&&(pixel8_prcntDiffA<16)){
	    pixel_new += (pixel8)*(float)16.0; accumWeights += 16;
    }
    float pixel9_prcntDiffR = fabs((pixel9.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel9_prcntDiffG = fabs((pixel9.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel9_prcntDiffB = fabs((pixel9.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel9_prcntDiffA = fabs((pixel9.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel9_prcntDiffR<16)&& (pixel9_prcntDiffG<16)&&(pixel9_prcntDiffB<16 )&&(pixel9_prcntDiffA<16)){
	    pixel_new += (pixel9)*(float)16.0; accumWeights += 16;
    }
    float pixel10_prcntDiffR = fabs((pixel10.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel10_prcntDiffG = fabs((pixel10.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel10_prcntDiffB = fabs((pixel10.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel10_prcntDiffA = fabs((pixel10.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel10_prcntDiffR<16)&& (pixel10_prcntDiffG<16)&&(pixel10_prcntDiffB<16 )&&(pixel10_prcntDiffA<16)){
	    pixel_new += (pixel10)*(float)16.0; accumWeights += 16;
    }
    float pixel11_prcntDiffR = fabs((pixel11.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel11_prcntDiffG = fabs((pixel11.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel11_prcntDiffB = fabs((pixel11.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel11_prcntDiffA = fabs((pixel11.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel11_prcntDiffR<16)&& (pixel11_prcntDiffG<16)&&(pixel11_prcntDiffB<16 )&&(pixel11_prcntDiffA<16)){
	    pixel_new += (pixel11)*(float)15.0; accumWeights += 15;
    }
    float pixel12_prcntDiffR = fabs((pixel12.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel12_prcntDiffG = fabs((pixel12.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel12_prcntDiffB = fabs((pixel12.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel12_prcntDiffA = fabs((pixel12.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel12_prcntDiffR<16)&& (pixel12_prcntDiffG<16)&&(pixel12_prcntDiffB<16 )&&(pixel12_prcntDiffA<16)){
	    pixel_new += (pixel12)*(float)13.0; accumWeights += 13;
    }
    float pixel13_prcntDiffR = fabs((pixel13.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel13_prcntDiffG = fabs((pixel13.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel13_prcntDiffB = fabs((pixel13.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel13_prcntDiffA = fabs((pixel13.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel13_prcntDiffR<16)&& (pixel13_prcntDiffG<16)&&(pixel13_prcntDiffB<16 )&&(pixel13_prcntDiffA<16)){
	    pixel_new += (pixel13)*(float)11.0; accumWeights += 11;
    }
    float pixel14_prcntDiffR = fabs((pixel14.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel14_prcntDiffG = fabs((pixel14.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel14_prcntDiffB = fabs((pixel14.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel14_prcntDiffA = fabs((pixel14.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel14_prcntDiffR<16)&& (pixel14_prcntDiffG<16)&&(pixel14_prcntDiffB<16 )&&(pixel14_prcntDiffA<16)){
	    pixel_new += (pixel14)*(float)9.0; accumWeights += 9;
    }
    float pixel15_prcntDiffR = fabs((pixel15.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel15_prcntDiffG = fabs((pixel15.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel15_prcntDiffB = fabs((pixel15.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel15_prcntDiffA = fabs((pixel15.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel15_prcntDiffR<16)&& (pixel15_prcntDiffG<16)&&(pixel15_prcntDiffB<16 )&&(pixel15_prcntDiffA<16)){
	    pixel_new += (pixel15)*(float)7.0; accumWeights += 7;
    }
    float pixel16_prcntDiffR = fabs((pixel16.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel16_prcntDiffG = fabs((pixel16.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel16_prcntDiffB = fabs((pixel16.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel16_prcntDiffA = fabs((pixel16.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel16_prcntDiffR<16)&& (pixel16_prcntDiffG<16)&&(pixel16_prcntDiffB<16 )&&(pixel16_prcntDiffA<16)){
	    pixel_new += (pixel16)*(float)5.0; accumWeights += 5;
    }
    float pixel17_prcntDiffR = fabs((pixel17.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel17_prcntDiffG = fabs((pixel17.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel17_prcntDiffB = fabs((pixel17.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel17_prcntDiffA = fabs((pixel17.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel17_prcntDiffR<16)&& (pixel17_prcntDiffG<16)&&(pixel17_prcntDiffB<16 )&&(pixel17_prcntDiffA<16)){
	    pixel_new += (pixel17)*(float)3.0; accumWeights += 3;
    }
    float pixel18_prcntDiffR = fabs((pixel18.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel18_prcntDiffG = fabs((pixel18.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel18_prcntDiffB = fabs((pixel18.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel18_prcntDiffA = fabs((pixel18.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel18_prcntDiffR<16)&& (pixel18_prcntDiffG<16)&&(pixel18_prcntDiffB<16 )&&(pixel18_prcntDiffA<16)){
	    pixel_new += (pixel18)*(float)2.0; accumWeights += 2;
    }
    float pixel19_prcntDiffR = fabs((pixel19.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel19_prcntDiffG = fabs((pixel19.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel19_prcntDiffB = fabs((pixel19.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel19_prcntDiffA = fabs((pixel19.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel19_prcntDiffR<16)&& (pixel19_prcntDiffG<16)&&(pixel19_prcntDiffB<16 )&&(pixel19_prcntDiffA<16)){
	    pixel_new += (pixel19)*(float)3.0; accumWeights += 3;
    }
    float pixel20_prcntDiffR = fabs((pixel20.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel20_prcntDiffG = fabs((pixel20.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel20_prcntDiffB = fabs((pixel20.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel20_prcntDiffA = fabs((pixel20.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel20_prcntDiffR<16)&& (pixel20_prcntDiffG<16)&&(pixel20_prcntDiffB<16 )&&(pixel20_prcntDiffA<16)){
	    pixel_new += (pixel20)*(float)5.0; accumWeights += 5;
    }
    float pixel21_prcntDiffR = fabs((pixel21.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel21_prcntDiffG = fabs((pixel21.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel21_prcntDiffB = fabs((pixel21.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel21_prcntDiffA = fabs((pixel21.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel21_prcntDiffR<16)&& (pixel21_prcntDiffG<16)&&(pixel21_prcntDiffB<16 )&&(pixel21_prcntDiffA<16)){
	    pixel_new += (pixel21)*(float)8.0; accumWeights += 8;
    }
    float pixel22_prcntDiffR = fabs((pixel22.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel22_prcntDiffG = fabs((pixel22.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel22_prcntDiffB = fabs((pixel22.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel22_prcntDiffA = fabs((pixel22.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel22_prcntDiffR<16)&& (pixel22_prcntDiffG<16)&&(pixel22_prcntDiffB<16 )&&(pixel22_prcntDiffA<16)){
	    pixel_new += (pixel22)*(float)10.0; accumWeights += 10;
    }
    float pixel23_prcntDiffR = fabs((pixel23.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel23_prcntDiffG = fabs((pixel23.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel23_prcntDiffB = fabs((pixel23.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel23_prcntDiffA = fabs((pixel23.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel23_prcntDiffR<16)&& (pixel23_prcntDiffG<16)&&(pixel23_prcntDiffB<16 )&&(pixel23_prcntDiffA<16)){
	    pixel_new += (pixel23)*(float)13.0; accumWeights += 13;
    }
    float pixel24_prcntDiffR = fabs((pixel24.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel24_prcntDiffG = fabs((pixel24.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel24_prcntDiffB = fabs((pixel24.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel24_prcntDiffA = fabs((pixel24.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel24_prcntDiffR<16)&& (pixel24_prcntDiffG<16)&&(pixel24_prcntDiffB<16 )&&(pixel24_prcntDiffA<16)){
	    pixel_new += (pixel24)*(float)16.0; accumWeights += 16;
    }
    float pixel25_prcntDiffR = fabs((pixel25.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel25_prcntDiffG = fabs((pixel25.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel25_prcntDiffB = fabs((pixel25.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel25_prcntDiffA = fabs((pixel25.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel25_prcntDiffR<16)&& (pixel25_prcntDiffG<16)&&(pixel25_prcntDiffB<16 )&&(pixel25_prcntDiffA<16)){
	    pixel_new += (pixel25)*(float)19.0; accumWeights += 19;
    }
    float pixel26_prcntDiffR = fabs((pixel26.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel26_prcntDiffG = fabs((pixel26.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel26_prcntDiffB = fabs((pixel26.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel26_prcntDiffA = fabs((pixel26.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel26_prcntDiffR<16)&& (pixel26_prcntDiffG<16)&&(pixel26_prcntDiffB<16 )&&(pixel26_prcntDiffA<16)){
	    pixel_new += (pixel26)*(float)22.0; accumWeights += 22;
    }
    float pixel27_prcntDiffR = fabs((pixel27.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel27_prcntDiffG = fabs((pixel27.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel27_prcntDiffB = fabs((pixel27.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel27_prcntDiffA = fabs((pixel27.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel27_prcntDiffR<16)&& (pixel27_prcntDiffG<16)&&(pixel27_prcntDiffB<16 )&&(pixel27_prcntDiffA<16)){
	    pixel_new += (pixel27)*(float)23.0; accumWeights += 23;
    }
    float pixel28_prcntDiffR = fabs((pixel28.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel28_prcntDiffG = fabs((pixel28.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel28_prcntDiffB = fabs((pixel28.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel28_prcntDiffA = fabs((pixel28.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel28_prcntDiffR<16)&& (pixel28_prcntDiffG<16)&&(pixel28_prcntDiffB<16 )&&(pixel28_prcntDiffA<16)){
	    pixel_new += (pixel28)*(float)24.0; accumWeights += 24;
    }
    float pixel29_prcntDiffR = fabs((pixel29.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel29_prcntDiffG = fabs((pixel29.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel29_prcntDiffB = fabs((pixel29.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel29_prcntDiffA = fabs((pixel29.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel29_prcntDiffR<16)&& (pixel29_prcntDiffG<16)&&(pixel29_prcntDiffB<16 )&&(pixel29_prcntDiffA<16)){
	    pixel_new += (pixel29)*(float)23.0; accumWeights += 23;
    }
    float pixel30_prcntDiffR = fabs((pixel30.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel30_prcntDiffG = fabs((pixel30.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel30_prcntDiffB = fabs((pixel30.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel30_prcntDiffA = fabs((pixel30.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel30_prcntDiffR<16)&& (pixel30_prcntDiffG<16)&&(pixel30_prcntDiffB<16 )&&(pixel30_prcntDiffA<16)){
	    pixel_new += (pixel30)*(float)22.0; accumWeights += 22;
    }
    float pixel31_prcntDiffR = fabs((pixel31.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel31_prcntDiffG = fabs((pixel31.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel31_prcntDiffB = fabs((pixel31.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel31_prcntDiffA = fabs((pixel31.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel31_prcntDiffR<16)&& (pixel31_prcntDiffG<16)&&(pixel31_prcntDiffB<16 )&&(pixel31_prcntDiffA<16)){
	    pixel_new += (pixel31)*(float)19.0; accumWeights += 19;
    }
    float pixel32_prcntDiffR = fabs((pixel32.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel32_prcntDiffG = fabs((pixel32.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel32_prcntDiffB = fabs((pixel32.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel32_prcntDiffA = fabs((pixel32.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel32_prcntDiffR<16)&& (pixel32_prcntDiffG<16)&&(pixel32_prcntDiffB<16 )&&(pixel32_prcntDiffA<16)){
	    pixel_new += (pixel32)*(float)16.0; accumWeights += 16;
    }
    float pixel33_prcntDiffR = fabs((pixel33.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel33_prcntDiffG = fabs((pixel33.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel33_prcntDiffB = fabs((pixel33.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel33_prcntDiffA = fabs((pixel33.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel33_prcntDiffR<16)&& (pixel33_prcntDiffG<16)&&(pixel33_prcntDiffB<16 )&&(pixel33_prcntDiffA<16)){
	    pixel_new += (pixel33)*(float)13.0; accumWeights += 13;
    }
    float pixel34_prcntDiffR = fabs((pixel34.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel34_prcntDiffG = fabs((pixel34.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel34_prcntDiffB = fabs((pixel34.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel34_prcntDiffA = fabs((pixel34.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel34_prcntDiffR<16)&& (pixel34_prcntDiffG<16)&&(pixel34_prcntDiffB<16 )&&(pixel34_prcntDiffA<16)){
	    pixel_new += (pixel34)*(float)10.0; accumWeights += 10;
    }
    float pixel35_prcntDiffR = fabs((pixel35.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel35_prcntDiffG = fabs((pixel35.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel35_prcntDiffB = fabs((pixel35.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel35_prcntDiffA = fabs((pixel35.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel35_prcntDiffR<16)&& (pixel35_prcntDiffG<16)&&(pixel35_prcntDiffB<16 )&&(pixel35_prcntDiffA<16)){
	    pixel_new += (pixel35)*(float)8.0; accumWeights += 8;
    }
    float pixel36_prcntDiffR = fabs((pixel36.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel36_prcntDiffG = fabs((pixel36.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel36_prcntDiffB = fabs((pixel36.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel36_prcntDiffA = fabs((pixel36.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel36_prcntDiffR<16)&& (pixel36_prcntDiffG<16)&&(pixel36_prcntDiffB<16 )&&(pixel36_prcntDiffA<16)){
	    pixel_new += (pixel36)*(float)5.0; accumWeights += 5;
    }
    float pixel37_prcntDiffR = fabs((pixel37.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel37_prcntDiffG = fabs((pixel37.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel37_prcntDiffB = fabs((pixel37.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel37_prcntDiffA = fabs((pixel37.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel37_prcntDiffR<16)&& (pixel37_prcntDiffG<16)&&(pixel37_prcntDiffB<16 )&&(pixel37_prcntDiffA<16)){
	    pixel_new += (pixel37)*(float)3.0; accumWeights += 3;
    }
    float pixel38_prcntDiffR = fabs((pixel38.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel38_prcntDiffG = fabs((pixel38.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel38_prcntDiffB = fabs((pixel38.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel38_prcntDiffA = fabs((pixel38.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel38_prcntDiffR<16)&& (pixel38_prcntDiffG<16)&&(pixel38_prcntDiffB<16 )&&(pixel38_prcntDiffA<16)){
	    pixel_new += (pixel38)*(float)5.0; accumWeights += 5;
    }
    float pixel39_prcntDiffR = fabs((pixel39.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel39_prcntDiffG = fabs((pixel39.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel39_prcntDiffB = fabs((pixel39.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel39_prcntDiffA = fabs((pixel39.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel39_prcntDiffR<16)&& (pixel39_prcntDiffG<16)&&(pixel39_prcntDiffB<16 )&&(pixel39_prcntDiffA<16)){
	    pixel_new += (pixel39)*(float)8.0; accumWeights += 8;
    }
    float pixel40_prcntDiffR = fabs((pixel40.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel40_prcntDiffG = fabs((pixel40.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel40_prcntDiffB = fabs((pixel40.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel40_prcntDiffA = fabs((pixel40.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel40_prcntDiffR<16)&& (pixel40_prcntDiffG<16)&&(pixel40_prcntDiffB<16 )&&(pixel40_prcntDiffA<16)){
	    pixel_new += (pixel40)*(float)11.0; accumWeights += 11;
    }
    float pixel41_prcntDiffR = fabs((pixel41.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel41_prcntDiffG = fabs((pixel41.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel41_prcntDiffB = fabs((pixel41.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel41_prcntDiffA = fabs((pixel41.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel41_prcntDiffR<16)&& (pixel41_prcntDiffG<16)&&(pixel41_prcntDiffB<16 )&&(pixel41_prcntDiffA<16)){
	    pixel_new += (pixel41)*(float)15.0; accumWeights += 15;
    }
    float pixel42_prcntDiffR = fabs((pixel42.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel42_prcntDiffG = fabs((pixel42.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel42_prcntDiffB = fabs((pixel42.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel42_prcntDiffA = fabs((pixel42.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel42_prcntDiffR<16)&& (pixel42_prcntDiffG<16)&&(pixel42_prcntDiffB<16 )&&(pixel42_prcntDiffA<16)){
	    pixel_new += (pixel42)*(float)19.0; accumWeights += 19;
    }
    float pixel43_prcntDiffR = fabs((pixel43.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel43_prcntDiffG = fabs((pixel43.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel43_prcntDiffB = fabs((pixel43.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel43_prcntDiffA = fabs((pixel43.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel43_prcntDiffR<16)&& (pixel43_prcntDiffG<16)&&(pixel43_prcntDiffB<16 )&&(pixel43_prcntDiffA<16)){
	    pixel_new += (pixel43)*(float)23.0; accumWeights += 23;
    }
    float pixel44_prcntDiffR = fabs((pixel44.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel44_prcntDiffG = fabs((pixel44.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel44_prcntDiffB = fabs((pixel44.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel44_prcntDiffA = fabs((pixel44.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel44_prcntDiffR<16)&& (pixel44_prcntDiffG<16)&&(pixel44_prcntDiffB<16 )&&(pixel44_prcntDiffA<16)){
	    pixel_new += (pixel44)*(float)27.0; accumWeights += 27;
    }
    float pixel45_prcntDiffR = fabs((pixel45.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel45_prcntDiffG = fabs((pixel45.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel45_prcntDiffB = fabs((pixel45.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel45_prcntDiffA = fabs((pixel45.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel45_prcntDiffR<16)&& (pixel45_prcntDiffG<16)&&(pixel45_prcntDiffB<16 )&&(pixel45_prcntDiffA<16)){
	    pixel_new += (pixel45)*(float)30.0; accumWeights += 30;
    }
    float pixel46_prcntDiffR = fabs((pixel46.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel46_prcntDiffG = fabs((pixel46.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel46_prcntDiffB = fabs((pixel46.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel46_prcntDiffA = fabs((pixel46.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel46_prcntDiffR<16)&& (pixel46_prcntDiffG<16)&&(pixel46_prcntDiffB<16 )&&(pixel46_prcntDiffA<16)){
	    pixel_new += (pixel46)*(float)32.0; accumWeights += 32;
    }
    float pixel47_prcntDiffR = fabs((pixel47.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel47_prcntDiffG = fabs((pixel47.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel47_prcntDiffB = fabs((pixel47.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel47_prcntDiffA = fabs((pixel47.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel47_prcntDiffR<16)&& (pixel47_prcntDiffG<16)&&(pixel47_prcntDiffB<16 )&&(pixel47_prcntDiffA<16)){
	    pixel_new += (pixel47)*(float)33.0; accumWeights += 33;
    }
    float pixel48_prcntDiffR = fabs((pixel48.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel48_prcntDiffG = fabs((pixel48.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel48_prcntDiffB = fabs((pixel48.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel48_prcntDiffA = fabs((pixel48.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel48_prcntDiffR<16)&& (pixel48_prcntDiffG<16)&&(pixel48_prcntDiffB<16 )&&(pixel48_prcntDiffA<16)){
	    pixel_new += (pixel48)*(float)32.0; accumWeights += 32;
    }
    float pixel49_prcntDiffR = fabs((pixel49.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel49_prcntDiffG = fabs((pixel49.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel49_prcntDiffB = fabs((pixel49.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel49_prcntDiffA = fabs((pixel49.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel49_prcntDiffR<16)&& (pixel49_prcntDiffG<16)&&(pixel49_prcntDiffB<16 )&&(pixel49_prcntDiffA<16)){
	    pixel_new += (pixel49)*(float)30.0; accumWeights += 30;
    }
    float pixel50_prcntDiffR = fabs((pixel50.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel50_prcntDiffG = fabs((pixel50.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel50_prcntDiffB = fabs((pixel50.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel50_prcntDiffA = fabs((pixel50.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel50_prcntDiffR<16)&& (pixel50_prcntDiffG<16)&&(pixel50_prcntDiffB<16 )&&(pixel50_prcntDiffA<16)){
	    pixel_new += (pixel50)*(float)27.0; accumWeights += 27;
    }
    float pixel51_prcntDiffR = fabs((pixel51.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel51_prcntDiffG = fabs((pixel51.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel51_prcntDiffB = fabs((pixel51.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel51_prcntDiffA = fabs((pixel51.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel51_prcntDiffR<16)&& (pixel51_prcntDiffG<16)&&(pixel51_prcntDiffB<16 )&&(pixel51_prcntDiffA<16)){
	    pixel_new += (pixel51)*(float)23.0; accumWeights += 23;
    }
    float pixel52_prcntDiffR = fabs((pixel52.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel52_prcntDiffG = fabs((pixel52.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel52_prcntDiffB = fabs((pixel52.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel52_prcntDiffA = fabs((pixel52.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel52_prcntDiffR<16)&& (pixel52_prcntDiffG<16)&&(pixel52_prcntDiffB<16 )&&(pixel52_prcntDiffA<16)){
	    pixel_new += (pixel52)*(float)19.0; accumWeights += 19;
    }
    float pixel53_prcntDiffR = fabs((pixel53.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel53_prcntDiffG = fabs((pixel53.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel53_prcntDiffB = fabs((pixel53.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel53_prcntDiffA = fabs((pixel53.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel53_prcntDiffR<16)&& (pixel53_prcntDiffG<16)&&(pixel53_prcntDiffB<16 )&&(pixel53_prcntDiffA<16)){
	    pixel_new += (pixel53)*(float)15.0; accumWeights += 15;
    }
    float pixel54_prcntDiffR = fabs((pixel54.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel54_prcntDiffG = fabs((pixel54.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel54_prcntDiffB = fabs((pixel54.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel54_prcntDiffA = fabs((pixel54.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel54_prcntDiffR<16)&& (pixel54_prcntDiffG<16)&&(pixel54_prcntDiffB<16 )&&(pixel54_prcntDiffA<16)){
	    pixel_new += (pixel54)*(float)11.0; accumWeights += 11;
    }
    float pixel55_prcntDiffR = fabs((pixel55.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel55_prcntDiffG = fabs((pixel55.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel55_prcntDiffB = fabs((pixel55.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel55_prcntDiffA = fabs((pixel55.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel55_prcntDiffR<16)&& (pixel55_prcntDiffG<16)&&(pixel55_prcntDiffB<16 )&&(pixel55_prcntDiffA<16)){
	    pixel_new += (pixel55)*(float)8.0; accumWeights += 8;
    }
    float pixel56_prcntDiffR = fabs((pixel56.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel56_prcntDiffG = fabs((pixel56.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel56_prcntDiffB = fabs((pixel56.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel56_prcntDiffA = fabs((pixel56.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel56_prcntDiffR<16)&& (pixel56_prcntDiffG<16)&&(pixel56_prcntDiffB<16 )&&(pixel56_prcntDiffA<16)){
	    pixel_new += (pixel56)*(float)5.0; accumWeights += 5;
    }
    float pixel57_prcntDiffR = fabs((pixel57.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel57_prcntDiffG = fabs((pixel57.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel57_prcntDiffB = fabs((pixel57.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel57_prcntDiffA = fabs((pixel57.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel57_prcntDiffR<16)&& (pixel57_prcntDiffG<16)&&(pixel57_prcntDiffB<16 )&&(pixel57_prcntDiffA<16)){
	    pixel_new += (pixel57)*(float)7.0; accumWeights += 7;
    }
    float pixel58_prcntDiffR = fabs((pixel58.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel58_prcntDiffG = fabs((pixel58.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel58_prcntDiffB = fabs((pixel58.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel58_prcntDiffA = fabs((pixel58.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel58_prcntDiffR<16)&& (pixel58_prcntDiffG<16)&&(pixel58_prcntDiffB<16 )&&(pixel58_prcntDiffA<16)){
	    pixel_new += (pixel58)*(float)10.0; accumWeights += 10;
    }
    float pixel59_prcntDiffR = fabs((pixel59.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel59_prcntDiffG = fabs((pixel59.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel59_prcntDiffB = fabs((pixel59.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel59_prcntDiffA = fabs((pixel59.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel59_prcntDiffR<16)&& (pixel59_prcntDiffG<16)&&(pixel59_prcntDiffB<16 )&&(pixel59_prcntDiffA<16)){
	    pixel_new += (pixel59)*(float)15.0; accumWeights += 15;
    }
    float pixel60_prcntDiffR = fabs((pixel60.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel60_prcntDiffG = fabs((pixel60.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel60_prcntDiffB = fabs((pixel60.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel60_prcntDiffA = fabs((pixel60.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel60_prcntDiffR<16)&& (pixel60_prcntDiffG<16)&&(pixel60_prcntDiffB<16 )&&(pixel60_prcntDiffA<16)){
	    pixel_new += (pixel60)*(float)20.0; accumWeights += 20;
    }
    float pixel61_prcntDiffR = fabs((pixel61.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel61_prcntDiffG = fabs((pixel61.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel61_prcntDiffB = fabs((pixel61.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel61_prcntDiffA = fabs((pixel61.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel61_prcntDiffR<16)&& (pixel61_prcntDiffG<16)&&(pixel61_prcntDiffB<16 )&&(pixel61_prcntDiffA<16)){
	    pixel_new += (pixel61)*(float)25.0; accumWeights += 25;
    }
    float pixel62_prcntDiffR = fabs((pixel62.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel62_prcntDiffG = fabs((pixel62.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel62_prcntDiffB = fabs((pixel62.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel62_prcntDiffA = fabs((pixel62.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel62_prcntDiffR<16)&& (pixel62_prcntDiffG<16)&&(pixel62_prcntDiffB<16 )&&(pixel62_prcntDiffA<16)){
	    pixel_new += (pixel62)*(float)31.0; accumWeights += 31;
    }
    float pixel63_prcntDiffR = fabs((pixel63.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel63_prcntDiffG = fabs((pixel63.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel63_prcntDiffB = fabs((pixel63.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel63_prcntDiffA = fabs((pixel63.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel63_prcntDiffR<16)&& (pixel63_prcntDiffG<16)&&(pixel63_prcntDiffB<16 )&&(pixel63_prcntDiffA<16)){
	    pixel_new += (pixel63)*(float)36.0; accumWeights += 36;
    }
    float pixel64_prcntDiffR = fabs((pixel64.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel64_prcntDiffG = fabs((pixel64.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel64_prcntDiffB = fabs((pixel64.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel64_prcntDiffA = fabs((pixel64.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel64_prcntDiffR<16)&& (pixel64_prcntDiffG<16)&&(pixel64_prcntDiffB<16 )&&(pixel64_prcntDiffA<16)){
	    pixel_new += (pixel64)*(float)41.0; accumWeights += 41;
    }
    float pixel65_prcntDiffR = fabs((pixel65.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel65_prcntDiffG = fabs((pixel65.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel65_prcntDiffB = fabs((pixel65.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel65_prcntDiffA = fabs((pixel65.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel65_prcntDiffR<16)&& (pixel65_prcntDiffG<16)&&(pixel65_prcntDiffB<16 )&&(pixel65_prcntDiffA<16)){
	    pixel_new += (pixel65)*(float)43.0; accumWeights += 43;
    }
    float pixel66_prcntDiffR = fabs((pixel66.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel66_prcntDiffG = fabs((pixel66.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel66_prcntDiffB = fabs((pixel66.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel66_prcntDiffA = fabs((pixel66.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel66_prcntDiffR<16)&& (pixel66_prcntDiffG<16)&&(pixel66_prcntDiffB<16 )&&(pixel66_prcntDiffA<16)){
	    pixel_new += (pixel66)*(float)44.0; accumWeights += 44;
    }
    float pixel67_prcntDiffR = fabs((pixel67.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel67_prcntDiffG = fabs((pixel67.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel67_prcntDiffB = fabs((pixel67.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel67_prcntDiffA = fabs((pixel67.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel67_prcntDiffR<16)&& (pixel67_prcntDiffG<16)&&(pixel67_prcntDiffB<16 )&&(pixel67_prcntDiffA<16)){
	    pixel_new += (pixel67)*(float)43.0; accumWeights += 43;
    }
    float pixel68_prcntDiffR = fabs((pixel68.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel68_prcntDiffG = fabs((pixel68.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel68_prcntDiffB = fabs((pixel68.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel68_prcntDiffA = fabs((pixel68.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel68_prcntDiffR<16)&& (pixel68_prcntDiffG<16)&&(pixel68_prcntDiffB<16 )&&(pixel68_prcntDiffA<16)){
	    pixel_new += (pixel68)*(float)41.0; accumWeights += 41;
    }
    float pixel69_prcntDiffR = fabs((pixel69.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel69_prcntDiffG = fabs((pixel69.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel69_prcntDiffB = fabs((pixel69.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel69_prcntDiffA = fabs((pixel69.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel69_prcntDiffR<16)&& (pixel69_prcntDiffG<16)&&(pixel69_prcntDiffB<16 )&&(pixel69_prcntDiffA<16)){
	    pixel_new += (pixel69)*(float)36.0; accumWeights += 36;
    }
    float pixel70_prcntDiffR = fabs((pixel70.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel70_prcntDiffG = fabs((pixel70.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel70_prcntDiffB = fabs((pixel70.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel70_prcntDiffA = fabs((pixel70.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel70_prcntDiffR<16)&& (pixel70_prcntDiffG<16)&&(pixel70_prcntDiffB<16 )&&(pixel70_prcntDiffA<16)){
	    pixel_new += (pixel70)*(float)31.0; accumWeights += 31;
    }
    float pixel71_prcntDiffR = fabs((pixel71.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel71_prcntDiffG = fabs((pixel71.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel71_prcntDiffB = fabs((pixel71.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel71_prcntDiffA = fabs((pixel71.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel71_prcntDiffR<16)&& (pixel71_prcntDiffG<16)&&(pixel71_prcntDiffB<16 )&&(pixel71_prcntDiffA<16)){
	    pixel_new += (pixel71)*(float)25.0; accumWeights += 25;
    }
    float pixel72_prcntDiffR = fabs((pixel72.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel72_prcntDiffG = fabs((pixel72.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel72_prcntDiffB = fabs((pixel72.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel72_prcntDiffA = fabs((pixel72.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel72_prcntDiffR<16)&& (pixel72_prcntDiffG<16)&&(pixel72_prcntDiffB<16 )&&(pixel72_prcntDiffA<16)){
	    pixel_new += (pixel72)*(float)20.0; accumWeights += 20;
    }
    float pixel73_prcntDiffR = fabs((pixel73.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel73_prcntDiffG = fabs((pixel73.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel73_prcntDiffB = fabs((pixel73.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel73_prcntDiffA = fabs((pixel73.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel73_prcntDiffR<16)&& (pixel73_prcntDiffG<16)&&(pixel73_prcntDiffB<16 )&&(pixel73_prcntDiffA<16)){
	    pixel_new += (pixel73)*(float)15.0; accumWeights += 15;
    }
    float pixel74_prcntDiffR = fabs((pixel74.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel74_prcntDiffG = fabs((pixel74.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel74_prcntDiffB = fabs((pixel74.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel74_prcntDiffA = fabs((pixel74.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel74_prcntDiffR<16)&& (pixel74_prcntDiffG<16)&&(pixel74_prcntDiffB<16 )&&(pixel74_prcntDiffA<16)){
	    pixel_new += (pixel74)*(float)10.0; accumWeights += 10;
    }
    float pixel75_prcntDiffR = fabs((pixel75.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel75_prcntDiffG = fabs((pixel75.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel75_prcntDiffB = fabs((pixel75.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel75_prcntDiffA = fabs((pixel75.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel75_prcntDiffR<16)&& (pixel75_prcntDiffG<16)&&(pixel75_prcntDiffB<16 )&&(pixel75_prcntDiffA<16)){
	    pixel_new += (pixel75)*(float)7.0; accumWeights += 7;
    }
    float pixel76_prcntDiffR = fabs((pixel76.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel76_prcntDiffG = fabs((pixel76.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel76_prcntDiffB = fabs((pixel76.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel76_prcntDiffA = fabs((pixel76.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel76_prcntDiffR<16)&& (pixel76_prcntDiffG<16)&&(pixel76_prcntDiffB<16 )&&(pixel76_prcntDiffA<16)){
	    pixel_new += (pixel76)*(float)9.0; accumWeights += 9;
    }
    float pixel77_prcntDiffR = fabs((pixel77.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel77_prcntDiffG = fabs((pixel77.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel77_prcntDiffB = fabs((pixel77.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel77_prcntDiffA = fabs((pixel77.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel77_prcntDiffR<16)&& (pixel77_prcntDiffG<16)&&(pixel77_prcntDiffB<16 )&&(pixel77_prcntDiffA<16)){
	    pixel_new += (pixel77)*(float)13.0; accumWeights += 13;
    }
    float pixel78_prcntDiffR = fabs((pixel78.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel78_prcntDiffG = fabs((pixel78.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel78_prcntDiffB = fabs((pixel78.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel78_prcntDiffA = fabs((pixel78.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel78_prcntDiffR<16)&& (pixel78_prcntDiffG<16)&&(pixel78_prcntDiffB<16 )&&(pixel78_prcntDiffA<16)){
	    pixel_new += (pixel78)*(float)19.0; accumWeights += 19;
    }
    float pixel79_prcntDiffR = fabs((pixel79.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel79_prcntDiffG = fabs((pixel79.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel79_prcntDiffB = fabs((pixel79.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel79_prcntDiffA = fabs((pixel79.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel79_prcntDiffR<16)&& (pixel79_prcntDiffG<16)&&(pixel79_prcntDiffB<16 )&&(pixel79_prcntDiffA<16)){
	    pixel_new += (pixel79)*(float)25.0; accumWeights += 25;
    }
    float pixel80_prcntDiffR = fabs((pixel80.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel80_prcntDiffG = fabs((pixel80.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel80_prcntDiffB = fabs((pixel80.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel80_prcntDiffA = fabs((pixel80.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel80_prcntDiffR<16)&& (pixel80_prcntDiffG<16)&&(pixel80_prcntDiffB<16 )&&(pixel80_prcntDiffA<16)){
	    pixel_new += (pixel80)*(float)32.0; accumWeights += 32;
    }
    float pixel81_prcntDiffR = fabs((pixel81.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel81_prcntDiffG = fabs((pixel81.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel81_prcntDiffB = fabs((pixel81.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel81_prcntDiffA = fabs((pixel81.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel81_prcntDiffR<16)&& (pixel81_prcntDiffG<16)&&(pixel81_prcntDiffB<16 )&&(pixel81_prcntDiffA<16)){
	    pixel_new += (pixel81)*(float)40.0; accumWeights += 40;
    }
    float pixel82_prcntDiffR = fabs((pixel82.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel82_prcntDiffG = fabs((pixel82.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel82_prcntDiffB = fabs((pixel82.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel82_prcntDiffA = fabs((pixel82.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel82_prcntDiffR<16)&& (pixel82_prcntDiffG<16)&&(pixel82_prcntDiffB<16 )&&(pixel82_prcntDiffA<16)){
	    pixel_new += (pixel82)*(float)46.0; accumWeights += 46;
    }
    float pixel83_prcntDiffR = fabs((pixel83.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel83_prcntDiffG = fabs((pixel83.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel83_prcntDiffB = fabs((pixel83.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel83_prcntDiffA = fabs((pixel83.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel83_prcntDiffR<16)&& (pixel83_prcntDiffG<16)&&(pixel83_prcntDiffB<16 )&&(pixel83_prcntDiffA<16)){
	    pixel_new += (pixel83)*(float)52.0; accumWeights += 52;
    }
    float pixel84_prcntDiffR = fabs((pixel84.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel84_prcntDiffG = fabs((pixel84.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel84_prcntDiffB = fabs((pixel84.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel84_prcntDiffA = fabs((pixel84.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel84_prcntDiffR<16)&& (pixel84_prcntDiffG<16)&&(pixel84_prcntDiffB<16 )&&(pixel84_prcntDiffA<16)){
	    pixel_new += (pixel84)*(float)56.0; accumWeights += 56;
    }
    float pixel85_prcntDiffR = fabs((pixel85.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel85_prcntDiffG = fabs((pixel85.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel85_prcntDiffB = fabs((pixel85.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel85_prcntDiffA = fabs((pixel85.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel85_prcntDiffR<16)&& (pixel85_prcntDiffG<16)&&(pixel85_prcntDiffB<16 )&&(pixel85_prcntDiffA<16)){
	    pixel_new += (pixel85)*(float)57.0; accumWeights += 57;
    }
    float pixel86_prcntDiffR = fabs((pixel86.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel86_prcntDiffG = fabs((pixel86.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel86_prcntDiffB = fabs((pixel86.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel86_prcntDiffA = fabs((pixel86.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel86_prcntDiffR<16)&& (pixel86_prcntDiffG<16)&&(pixel86_prcntDiffB<16 )&&(pixel86_prcntDiffA<16)){
	    pixel_new += (pixel86)*(float)56.0; accumWeights += 56;
    }
    float pixel87_prcntDiffR = fabs((pixel87.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel87_prcntDiffG = fabs((pixel87.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel87_prcntDiffB = fabs((pixel87.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel87_prcntDiffA = fabs((pixel87.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel87_prcntDiffR<16)&& (pixel87_prcntDiffG<16)&&(pixel87_prcntDiffB<16 )&&(pixel87_prcntDiffA<16)){
	    pixel_new += (pixel87)*(float)52.0; accumWeights += 52;
    }
    float pixel88_prcntDiffR = fabs((pixel88.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel88_prcntDiffG = fabs((pixel88.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel88_prcntDiffB = fabs((pixel88.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel88_prcntDiffA = fabs((pixel88.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel88_prcntDiffR<16)&& (pixel88_prcntDiffG<16)&&(pixel88_prcntDiffB<16 )&&(pixel88_prcntDiffA<16)){
	    pixel_new += (pixel88)*(float)46.0; accumWeights += 46;
    }
    float pixel89_prcntDiffR = fabs((pixel89.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel89_prcntDiffG = fabs((pixel89.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel89_prcntDiffB = fabs((pixel89.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel89_prcntDiffA = fabs((pixel89.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel89_prcntDiffR<16)&& (pixel89_prcntDiffG<16)&&(pixel89_prcntDiffB<16 )&&(pixel89_prcntDiffA<16)){
	    pixel_new += (pixel89)*(float)40.0; accumWeights += 40;
    }
    float pixel90_prcntDiffR = fabs((pixel90.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel90_prcntDiffG = fabs((pixel90.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel90_prcntDiffB = fabs((pixel90.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel90_prcntDiffA = fabs((pixel90.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel90_prcntDiffR<16)&& (pixel90_prcntDiffG<16)&&(pixel90_prcntDiffB<16 )&&(pixel90_prcntDiffA<16)){
	    pixel_new += (pixel90)*(float)32.0; accumWeights += 32;
    }
    float pixel91_prcntDiffR = fabs((pixel91.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel91_prcntDiffG = fabs((pixel91.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel91_prcntDiffB = fabs((pixel91.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel91_prcntDiffA = fabs((pixel91.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel91_prcntDiffR<16)&& (pixel91_prcntDiffG<16)&&(pixel91_prcntDiffB<16 )&&(pixel91_prcntDiffA<16)){
	    pixel_new += (pixel91)*(float)25.0; accumWeights += 25;
    }
    float pixel92_prcntDiffR = fabs((pixel92.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel92_prcntDiffG = fabs((pixel92.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel92_prcntDiffB = fabs((pixel92.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel92_prcntDiffA = fabs((pixel92.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel92_prcntDiffR<16)&& (pixel92_prcntDiffG<16)&&(pixel92_prcntDiffB<16 )&&(pixel92_prcntDiffA<16)){
	    pixel_new += (pixel92)*(float)19.0; accumWeights += 19;
    }
    float pixel93_prcntDiffR = fabs((pixel93.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel93_prcntDiffG = fabs((pixel93.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel93_prcntDiffB = fabs((pixel93.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel93_prcntDiffA = fabs((pixel93.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel93_prcntDiffR<16)&& (pixel93_prcntDiffG<16)&&(pixel93_prcntDiffB<16 )&&(pixel93_prcntDiffA<16)){
	    pixel_new += (pixel93)*(float)13.0; accumWeights += 13;
    }
    float pixel94_prcntDiffR = fabs((pixel94.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel94_prcntDiffG = fabs((pixel94.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel94_prcntDiffB = fabs((pixel94.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel94_prcntDiffA = fabs((pixel94.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel94_prcntDiffR<16)&& (pixel94_prcntDiffG<16)&&(pixel94_prcntDiffB<16 )&&(pixel94_prcntDiffA<16)){
	    pixel_new += (pixel94)*(float)9.0; accumWeights += 9;
    }
    float pixel95_prcntDiffR = fabs((pixel95.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel95_prcntDiffG = fabs((pixel95.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel95_prcntDiffB = fabs((pixel95.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel95_prcntDiffA = fabs((pixel95.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel95_prcntDiffR<16)&& (pixel95_prcntDiffG<16)&&(pixel95_prcntDiffB<16 )&&(pixel95_prcntDiffA<16)){
	    pixel_new += (pixel95)*(float)11.0; accumWeights += 11;
    }
    float pixel96_prcntDiffR = fabs((pixel96.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel96_prcntDiffG = fabs((pixel96.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel96_prcntDiffB = fabs((pixel96.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel96_prcntDiffA = fabs((pixel96.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel96_prcntDiffR<16)&& (pixel96_prcntDiffG<16)&&(pixel96_prcntDiffB<16 )&&(pixel96_prcntDiffA<16)){
	    pixel_new += (pixel96)*(float)16.0; accumWeights += 16;
    }
    float pixel97_prcntDiffR = fabs((pixel97.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel97_prcntDiffG = fabs((pixel97.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel97_prcntDiffB = fabs((pixel97.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel97_prcntDiffA = fabs((pixel97.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel97_prcntDiffR<16)&& (pixel97_prcntDiffG<16)&&(pixel97_prcntDiffB<16 )&&(pixel97_prcntDiffA<16)){
	    pixel_new += (pixel97)*(float)23.0; accumWeights += 23;
    }
    float pixel98_prcntDiffR = fabs((pixel98.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel98_prcntDiffG = fabs((pixel98.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel98_prcntDiffB = fabs((pixel98.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel98_prcntDiffA = fabs((pixel98.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel98_prcntDiffR<16)&& (pixel98_prcntDiffG<16)&&(pixel98_prcntDiffB<16 )&&(pixel98_prcntDiffA<16)){
	    pixel_new += (pixel98)*(float)31.0; accumWeights += 31;
    }
    float pixel99_prcntDiffR = fabs((pixel99.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel99_prcntDiffG = fabs((pixel99.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel99_prcntDiffB = fabs((pixel99.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel99_prcntDiffA = fabs((pixel99.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel99_prcntDiffR<16)&& (pixel99_prcntDiffG<16)&&(pixel99_prcntDiffB<16 )&&(pixel99_prcntDiffA<16)){
	    pixel_new += (pixel99)*(float)40.0; accumWeights += 40;
    }
    float pixel100_prcntDiffR = fabs((pixel100.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel100_prcntDiffG = fabs((pixel100.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel100_prcntDiffB = fabs((pixel100.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel100_prcntDiffA = fabs((pixel100.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel100_prcntDiffR<16)&& (pixel100_prcntDiffG<16)&&(pixel100_prcntDiffB<16 )&&(pixel100_prcntDiffA<16)){
	    pixel_new += (pixel100)*(float)49.0; accumWeights += 49;
    }
    float pixel101_prcntDiffR = fabs((pixel101.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel101_prcntDiffG = fabs((pixel101.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel101_prcntDiffB = fabs((pixel101.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel101_prcntDiffA = fabs((pixel101.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel101_prcntDiffR<16)&& (pixel101_prcntDiffG<16)&&(pixel101_prcntDiffB<16 )&&(pixel101_prcntDiffA<16)){
	    pixel_new += (pixel101)*(float)57.0; accumWeights += 57;
    }
    float pixel102_prcntDiffR = fabs((pixel102.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel102_prcntDiffG = fabs((pixel102.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel102_prcntDiffB = fabs((pixel102.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel102_prcntDiffA = fabs((pixel102.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel102_prcntDiffR<16)&& (pixel102_prcntDiffG<16)&&(pixel102_prcntDiffB<16 )&&(pixel102_prcntDiffA<16)){
	    pixel_new += (pixel102)*(float)64.0; accumWeights += 64;
    }
    float pixel103_prcntDiffR = fabs((pixel103.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel103_prcntDiffG = fabs((pixel103.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel103_prcntDiffB = fabs((pixel103.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel103_prcntDiffA = fabs((pixel103.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel103_prcntDiffR<16)&& (pixel103_prcntDiffG<16)&&(pixel103_prcntDiffB<16 )&&(pixel103_prcntDiffA<16)){
	    pixel_new += (pixel103)*(float)68.0; accumWeights += 68;
    }
    float pixel104_prcntDiffR = fabs((pixel104.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel104_prcntDiffG = fabs((pixel104.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel104_prcntDiffB = fabs((pixel104.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel104_prcntDiffA = fabs((pixel104.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel104_prcntDiffR<16)&& (pixel104_prcntDiffG<16)&&(pixel104_prcntDiffB<16 )&&(pixel104_prcntDiffA<16)){
	    pixel_new += (pixel104)*(float)70.0; accumWeights += 70;
    }
    float pixel105_prcntDiffR = fabs((pixel105.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel105_prcntDiffG = fabs((pixel105.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel105_prcntDiffB = fabs((pixel105.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel105_prcntDiffA = fabs((pixel105.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel105_prcntDiffR<16)&& (pixel105_prcntDiffG<16)&&(pixel105_prcntDiffB<16 )&&(pixel105_prcntDiffA<16)){
	    pixel_new += (pixel105)*(float)68.0; accumWeights += 68;
    }
    float pixel106_prcntDiffR = fabs((pixel106.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel106_prcntDiffG = fabs((pixel106.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel106_prcntDiffB = fabs((pixel106.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel106_prcntDiffA = fabs((pixel106.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel106_prcntDiffR<16)&& (pixel106_prcntDiffG<16)&&(pixel106_prcntDiffB<16 )&&(pixel106_prcntDiffA<16)){
	    pixel_new += (pixel106)*(float)64.0; accumWeights += 64;
    }
    float pixel107_prcntDiffR = fabs((pixel107.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel107_prcntDiffG = fabs((pixel107.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel107_prcntDiffB = fabs((pixel107.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel107_prcntDiffA = fabs((pixel107.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel107_prcntDiffR<16)&& (pixel107_prcntDiffG<16)&&(pixel107_prcntDiffB<16 )&&(pixel107_prcntDiffA<16)){
	    pixel_new += (pixel107)*(float)57.0; accumWeights += 57;
    }
    float pixel108_prcntDiffR = fabs((pixel108.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel108_prcntDiffG = fabs((pixel108.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel108_prcntDiffB = fabs((pixel108.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel108_prcntDiffA = fabs((pixel108.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel108_prcntDiffR<16)&& (pixel108_prcntDiffG<16)&&(pixel108_prcntDiffB<16 )&&(pixel108_prcntDiffA<16)){
	    pixel_new += (pixel108)*(float)49.0; accumWeights += 49;
    }
    float pixel109_prcntDiffR = fabs((pixel109.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel109_prcntDiffG = fabs((pixel109.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel109_prcntDiffB = fabs((pixel109.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel109_prcntDiffA = fabs((pixel109.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel109_prcntDiffR<16)&& (pixel109_prcntDiffG<16)&&(pixel109_prcntDiffB<16 )&&(pixel109_prcntDiffA<16)){
	    pixel_new += (pixel109)*(float)40.0; accumWeights += 40;
    }
    float pixel110_prcntDiffR = fabs((pixel110.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel110_prcntDiffG = fabs((pixel110.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel110_prcntDiffB = fabs((pixel110.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel110_prcntDiffA = fabs((pixel110.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel110_prcntDiffR<16)&& (pixel110_prcntDiffG<16)&&(pixel110_prcntDiffB<16 )&&(pixel110_prcntDiffA<16)){
	    pixel_new += (pixel110)*(float)31.0; accumWeights += 31;
    }
    float pixel111_prcntDiffR = fabs((pixel111.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel111_prcntDiffG = fabs((pixel111.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel111_prcntDiffB = fabs((pixel111.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel111_prcntDiffA = fabs((pixel111.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel111_prcntDiffR<16)&& (pixel111_prcntDiffG<16)&&(pixel111_prcntDiffB<16 )&&(pixel111_prcntDiffA<16)){
	    pixel_new += (pixel111)*(float)23.0; accumWeights += 23;
    }
    float pixel112_prcntDiffR = fabs((pixel112.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel112_prcntDiffG = fabs((pixel112.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel112_prcntDiffB = fabs((pixel112.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel112_prcntDiffA = fabs((pixel112.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel112_prcntDiffR<16)&& (pixel112_prcntDiffG<16)&&(pixel112_prcntDiffB<16 )&&(pixel112_prcntDiffA<16)){
	    pixel_new += (pixel112)*(float)16.0; accumWeights += 16;
    }
    float pixel113_prcntDiffR = fabs((pixel113.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel113_prcntDiffG = fabs((pixel113.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel113_prcntDiffB = fabs((pixel113.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel113_prcntDiffA = fabs((pixel113.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel113_prcntDiffR<16)&& (pixel113_prcntDiffG<16)&&(pixel113_prcntDiffB<16 )&&(pixel113_prcntDiffA<16)){
	    pixel_new += (pixel113)*(float)11.0; accumWeights += 11;
    }
    float pixel114_prcntDiffR = fabs((pixel114.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel114_prcntDiffG = fabs((pixel114.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel114_prcntDiffB = fabs((pixel114.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel114_prcntDiffA = fabs((pixel114.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel114_prcntDiffR<16)&& (pixel114_prcntDiffG<16)&&(pixel114_prcntDiffB<16 )&&(pixel114_prcntDiffA<16)){
	    pixel_new += (pixel114)*(float)13.0; accumWeights += 13;
    }
    float pixel115_prcntDiffR = fabs((pixel115.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel115_prcntDiffG = fabs((pixel115.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel115_prcntDiffB = fabs((pixel115.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel115_prcntDiffA = fabs((pixel115.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel115_prcntDiffR<16)&& (pixel115_prcntDiffG<16)&&(pixel115_prcntDiffB<16 )&&(pixel115_prcntDiffA<16)){
	    pixel_new += (pixel115)*(float)19.0; accumWeights += 19;
    }
    float pixel116_prcntDiffR = fabs((pixel116.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel116_prcntDiffG = fabs((pixel116.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel116_prcntDiffB = fabs((pixel116.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel116_prcntDiffA = fabs((pixel116.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel116_prcntDiffR<16)&& (pixel116_prcntDiffG<16)&&(pixel116_prcntDiffB<16 )&&(pixel116_prcntDiffA<16)){
	    pixel_new += (pixel116)*(float)27.0; accumWeights += 27;
    }
    float pixel117_prcntDiffR = fabs((pixel117.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel117_prcntDiffG = fabs((pixel117.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel117_prcntDiffB = fabs((pixel117.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel117_prcntDiffA = fabs((pixel117.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel117_prcntDiffR<16)&& (pixel117_prcntDiffG<16)&&(pixel117_prcntDiffB<16 )&&(pixel117_prcntDiffA<16)){
	    pixel_new += (pixel117)*(float)36.0; accumWeights += 36;
    }
    float pixel118_prcntDiffR = fabs((pixel118.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel118_prcntDiffG = fabs((pixel118.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel118_prcntDiffB = fabs((pixel118.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel118_prcntDiffA = fabs((pixel118.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel118_prcntDiffR<16)&& (pixel118_prcntDiffG<16)&&(pixel118_prcntDiffB<16 )&&(pixel118_prcntDiffA<16)){
	    pixel_new += (pixel118)*(float)46.0; accumWeights += 46;
    }
    float pixel119_prcntDiffR = fabs((pixel119.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel119_prcntDiffG = fabs((pixel119.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel119_prcntDiffB = fabs((pixel119.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel119_prcntDiffA = fabs((pixel119.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel119_prcntDiffR<16)&& (pixel119_prcntDiffG<16)&&(pixel119_prcntDiffB<16 )&&(pixel119_prcntDiffA<16)){
	    pixel_new += (pixel119)*(float)57.0; accumWeights += 57;
    }
    float pixel120_prcntDiffR = fabs((pixel120.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel120_prcntDiffG = fabs((pixel120.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel120_prcntDiffB = fabs((pixel120.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel120_prcntDiffA = fabs((pixel120.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel120_prcntDiffR<16)&& (pixel120_prcntDiffG<16)&&(pixel120_prcntDiffB<16 )&&(pixel120_prcntDiffA<16)){
	    pixel_new += (pixel120)*(float)67.0; accumWeights += 67;
    }
    float pixel121_prcntDiffR = fabs((pixel121.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel121_prcntDiffG = fabs((pixel121.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel121_prcntDiffB = fabs((pixel121.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel121_prcntDiffA = fabs((pixel121.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel121_prcntDiffR<16)&& (pixel121_prcntDiffG<16)&&(pixel121_prcntDiffB<16 )&&(pixel121_prcntDiffA<16)){
	    pixel_new += (pixel121)*(float)74.0; accumWeights += 74;
    }
    float pixel122_prcntDiffR = fabs((pixel122.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel122_prcntDiffG = fabs((pixel122.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel122_prcntDiffB = fabs((pixel122.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel122_prcntDiffA = fabs((pixel122.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel122_prcntDiffR<16)&& (pixel122_prcntDiffG<16)&&(pixel122_prcntDiffB<16 )&&(pixel122_prcntDiffA<16)){
	    pixel_new += (pixel122)*(float)80.0; accumWeights += 80;
    }
    float pixel123_prcntDiffR = fabs((pixel123.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel123_prcntDiffG = fabs((pixel123.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel123_prcntDiffB = fabs((pixel123.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel123_prcntDiffA = fabs((pixel123.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel123_prcntDiffR<16)&& (pixel123_prcntDiffG<16)&&(pixel123_prcntDiffB<16 )&&(pixel123_prcntDiffA<16)){
	    pixel_new += (pixel123)*(float)81.0; accumWeights += 81;
    }
    float pixel124_prcntDiffR = fabs((pixel124.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel124_prcntDiffG = fabs((pixel124.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel124_prcntDiffB = fabs((pixel124.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel124_prcntDiffA = fabs((pixel124.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel124_prcntDiffR<16)&& (pixel124_prcntDiffG<16)&&(pixel124_prcntDiffB<16 )&&(pixel124_prcntDiffA<16)){
	    pixel_new += (pixel124)*(float)80.0; accumWeights += 80;
    }
    float pixel125_prcntDiffR = fabs((pixel125.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel125_prcntDiffG = fabs((pixel125.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel125_prcntDiffB = fabs((pixel125.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel125_prcntDiffA = fabs((pixel125.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel125_prcntDiffR<16)&& (pixel125_prcntDiffG<16)&&(pixel125_prcntDiffB<16 )&&(pixel125_prcntDiffA<16)){
	    pixel_new += (pixel125)*(float)74.0; accumWeights += 74;
    }
    float pixel126_prcntDiffR = fabs((pixel126.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel126_prcntDiffG = fabs((pixel126.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel126_prcntDiffB = fabs((pixel126.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel126_prcntDiffA = fabs((pixel126.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel126_prcntDiffR<16)&& (pixel126_prcntDiffG<16)&&(pixel126_prcntDiffB<16 )&&(pixel126_prcntDiffA<16)){
	    pixel_new += (pixel126)*(float)67.0; accumWeights += 67;
    }
    float pixel127_prcntDiffR = fabs((pixel127.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel127_prcntDiffG = fabs((pixel127.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel127_prcntDiffB = fabs((pixel127.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel127_prcntDiffA = fabs((pixel127.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel127_prcntDiffR<16)&& (pixel127_prcntDiffG<16)&&(pixel127_prcntDiffB<16 )&&(pixel127_prcntDiffA<16)){
	    pixel_new += (pixel127)*(float)57.0; accumWeights += 57;
    }
    float pixel128_prcntDiffR = fabs((pixel128.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel128_prcntDiffG = fabs((pixel128.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel128_prcntDiffB = fabs((pixel128.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel128_prcntDiffA = fabs((pixel128.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel128_prcntDiffR<16)&& (pixel128_prcntDiffG<16)&&(pixel128_prcntDiffB<16 )&&(pixel128_prcntDiffA<16)){
	    pixel_new += (pixel128)*(float)46.0; accumWeights += 46;
    }
    float pixel129_prcntDiffR = fabs((pixel129.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel129_prcntDiffG = fabs((pixel129.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel129_prcntDiffB = fabs((pixel129.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel129_prcntDiffA = fabs((pixel129.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel129_prcntDiffR<16)&& (pixel129_prcntDiffG<16)&&(pixel129_prcntDiffB<16 )&&(pixel129_prcntDiffA<16)){
	    pixel_new += (pixel129)*(float)36.0; accumWeights += 36;
    }
    float pixel130_prcntDiffR = fabs((pixel130.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel130_prcntDiffG = fabs((pixel130.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel130_prcntDiffB = fabs((pixel130.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel130_prcntDiffA = fabs((pixel130.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel130_prcntDiffR<16)&& (pixel130_prcntDiffG<16)&&(pixel130_prcntDiffB<16 )&&(pixel130_prcntDiffA<16)){
	    pixel_new += (pixel130)*(float)27.0; accumWeights += 27;
    }
    float pixel131_prcntDiffR = fabs((pixel131.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel131_prcntDiffG = fabs((pixel131.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel131_prcntDiffB = fabs((pixel131.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel131_prcntDiffA = fabs((pixel131.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel131_prcntDiffR<16)&& (pixel131_prcntDiffG<16)&&(pixel131_prcntDiffB<16 )&&(pixel131_prcntDiffA<16)){
	    pixel_new += (pixel131)*(float)19.0; accumWeights += 19;
    }
    float pixel132_prcntDiffR = fabs((pixel132.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel132_prcntDiffG = fabs((pixel132.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel132_prcntDiffB = fabs((pixel132.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel132_prcntDiffA = fabs((pixel132.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel132_prcntDiffR<16)&& (pixel132_prcntDiffG<16)&&(pixel132_prcntDiffB<16 )&&(pixel132_prcntDiffA<16)){
	    pixel_new += (pixel132)*(float)13.0; accumWeights += 13;
    }
    float pixel133_prcntDiffR = fabs((pixel133.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel133_prcntDiffG = fabs((pixel133.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel133_prcntDiffB = fabs((pixel133.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel133_prcntDiffA = fabs((pixel133.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel133_prcntDiffR<16)&& (pixel133_prcntDiffG<16)&&(pixel133_prcntDiffB<16 )&&(pixel133_prcntDiffA<16)){
	    pixel_new += (pixel133)*(float)15.0; accumWeights += 15;
    }
    float pixel134_prcntDiffR = fabs((pixel134.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel134_prcntDiffG = fabs((pixel134.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel134_prcntDiffB = fabs((pixel134.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel134_prcntDiffA = fabs((pixel134.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel134_prcntDiffR<16)&& (pixel134_prcntDiffG<16)&&(pixel134_prcntDiffB<16 )&&(pixel134_prcntDiffA<16)){
	    pixel_new += (pixel134)*(float)22.0; accumWeights += 22;
    }
    float pixel135_prcntDiffR = fabs((pixel135.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel135_prcntDiffG = fabs((pixel135.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel135_prcntDiffB = fabs((pixel135.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel135_prcntDiffA = fabs((pixel135.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel135_prcntDiffR<16)&& (pixel135_prcntDiffG<16)&&(pixel135_prcntDiffB<16 )&&(pixel135_prcntDiffA<16)){
	    pixel_new += (pixel135)*(float)30.0; accumWeights += 30;
    }
    float pixel136_prcntDiffR = fabs((pixel136.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel136_prcntDiffG = fabs((pixel136.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel136_prcntDiffB = fabs((pixel136.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel136_prcntDiffA = fabs((pixel136.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel136_prcntDiffR<16)&& (pixel136_prcntDiffG<16)&&(pixel136_prcntDiffB<16 )&&(pixel136_prcntDiffA<16)){
	    pixel_new += (pixel136)*(float)41.0; accumWeights += 41;
    }
    float pixel137_prcntDiffR = fabs((pixel137.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel137_prcntDiffG = fabs((pixel137.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel137_prcntDiffB = fabs((pixel137.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel137_prcntDiffA = fabs((pixel137.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel137_prcntDiffR<16)&& (pixel137_prcntDiffG<16)&&(pixel137_prcntDiffB<16 )&&(pixel137_prcntDiffA<16)){
	    pixel_new += (pixel137)*(float)52.0; accumWeights += 52;
    }
    float pixel138_prcntDiffR = fabs((pixel138.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel138_prcntDiffG = fabs((pixel138.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel138_prcntDiffB = fabs((pixel138.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel138_prcntDiffA = fabs((pixel138.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel138_prcntDiffR<16)&& (pixel138_prcntDiffG<16)&&(pixel138_prcntDiffB<16 )&&(pixel138_prcntDiffA<16)){
	    pixel_new += (pixel138)*(float)64.0; accumWeights += 64;
    }
    float pixel139_prcntDiffR = fabs((pixel139.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel139_prcntDiffG = fabs((pixel139.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel139_prcntDiffB = fabs((pixel139.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel139_prcntDiffA = fabs((pixel139.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel139_prcntDiffR<16)&& (pixel139_prcntDiffG<16)&&(pixel139_prcntDiffB<16 )&&(pixel139_prcntDiffA<16)){
	    pixel_new += (pixel139)*(float)74.0; accumWeights += 74;
    }
    float pixel140_prcntDiffR = fabs((pixel140.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel140_prcntDiffG = fabs((pixel140.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel140_prcntDiffB = fabs((pixel140.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel140_prcntDiffA = fabs((pixel140.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel140_prcntDiffR<16)&& (pixel140_prcntDiffG<16)&&(pixel140_prcntDiffB<16 )&&(pixel140_prcntDiffA<16)){
	    pixel_new += (pixel140)*(float)83.0; accumWeights += 83;
    }
    float pixel141_prcntDiffR = fabs((pixel141.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel141_prcntDiffG = fabs((pixel141.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel141_prcntDiffB = fabs((pixel141.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel141_prcntDiffA = fabs((pixel141.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel141_prcntDiffR<16)&& (pixel141_prcntDiffG<16)&&(pixel141_prcntDiffB<16 )&&(pixel141_prcntDiffA<16)){
	    pixel_new += (pixel141)*(float)89.0; accumWeights += 89;
    }
    float pixel142_prcntDiffR = fabs((pixel142.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel142_prcntDiffG = fabs((pixel142.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel142_prcntDiffB = fabs((pixel142.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel142_prcntDiffA = fabs((pixel142.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel142_prcntDiffR<16)&& (pixel142_prcntDiffG<16)&&(pixel142_prcntDiffB<16 )&&(pixel142_prcntDiffA<16)){
	    pixel_new += (pixel142)*(float)91.0; accumWeights += 91;
    }
    float pixel143_prcntDiffR = fabs((pixel143.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel143_prcntDiffG = fabs((pixel143.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel143_prcntDiffB = fabs((pixel143.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel143_prcntDiffA = fabs((pixel143.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel143_prcntDiffR<16)&& (pixel143_prcntDiffG<16)&&(pixel143_prcntDiffB<16 )&&(pixel143_prcntDiffA<16)){
	    pixel_new += (pixel143)*(float)89.0; accumWeights += 89;
    }
    float pixel144_prcntDiffR = fabs((pixel144.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel144_prcntDiffG = fabs((pixel144.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel144_prcntDiffB = fabs((pixel144.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel144_prcntDiffA = fabs((pixel144.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel144_prcntDiffR<16)&& (pixel144_prcntDiffG<16)&&(pixel144_prcntDiffB<16 )&&(pixel144_prcntDiffA<16)){
	    pixel_new += (pixel144)*(float)83.0; accumWeights += 83;
    }
    float pixel145_prcntDiffR = fabs((pixel145.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel145_prcntDiffG = fabs((pixel145.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel145_prcntDiffB = fabs((pixel145.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel145_prcntDiffA = fabs((pixel145.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel145_prcntDiffR<16)&& (pixel145_prcntDiffG<16)&&(pixel145_prcntDiffB<16 )&&(pixel145_prcntDiffA<16)){
	    pixel_new += (pixel145)*(float)74.0; accumWeights += 74;
    }
    float pixel146_prcntDiffR = fabs((pixel146.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel146_prcntDiffG = fabs((pixel146.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel146_prcntDiffB = fabs((pixel146.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel146_prcntDiffA = fabs((pixel146.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel146_prcntDiffR<16)&& (pixel146_prcntDiffG<16)&&(pixel146_prcntDiffB<16 )&&(pixel146_prcntDiffA<16)){
	    pixel_new += (pixel146)*(float)64.0; accumWeights += 64;
    }
    float pixel147_prcntDiffR = fabs((pixel147.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel147_prcntDiffG = fabs((pixel147.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel147_prcntDiffB = fabs((pixel147.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel147_prcntDiffA = fabs((pixel147.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel147_prcntDiffR<16)&& (pixel147_prcntDiffG<16)&&(pixel147_prcntDiffB<16 )&&(pixel147_prcntDiffA<16)){
	    pixel_new += (pixel147)*(float)52.0; accumWeights += 52;
    }
    float pixel148_prcntDiffR = fabs((pixel148.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel148_prcntDiffG = fabs((pixel148.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel148_prcntDiffB = fabs((pixel148.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel148_prcntDiffA = fabs((pixel148.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel148_prcntDiffR<16)&& (pixel148_prcntDiffG<16)&&(pixel148_prcntDiffB<16 )&&(pixel148_prcntDiffA<16)){
	    pixel_new += (pixel148)*(float)41.0; accumWeights += 41;
    }
    float pixel149_prcntDiffR = fabs((pixel149.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel149_prcntDiffG = fabs((pixel149.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel149_prcntDiffB = fabs((pixel149.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel149_prcntDiffA = fabs((pixel149.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel149_prcntDiffR<16)&& (pixel149_prcntDiffG<16)&&(pixel149_prcntDiffB<16 )&&(pixel149_prcntDiffA<16)){
	    pixel_new += (pixel149)*(float)30.0; accumWeights += 30;
    }
    float pixel150_prcntDiffR = fabs((pixel150.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel150_prcntDiffG = fabs((pixel150.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel150_prcntDiffB = fabs((pixel150.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel150_prcntDiffA = fabs((pixel150.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel150_prcntDiffR<16)&& (pixel150_prcntDiffG<16)&&(pixel150_prcntDiffB<16 )&&(pixel150_prcntDiffA<16)){
	    pixel_new += (pixel150)*(float)22.0; accumWeights += 22;
    }
    float pixel151_prcntDiffR = fabs((pixel151.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel151_prcntDiffG = fabs((pixel151.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel151_prcntDiffB = fabs((pixel151.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel151_prcntDiffA = fabs((pixel151.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel151_prcntDiffR<16)&& (pixel151_prcntDiffG<16)&&(pixel151_prcntDiffB<16 )&&(pixel151_prcntDiffA<16)){
	    pixel_new += (pixel151)*(float)15.0; accumWeights += 15;
    }
    float pixel152_prcntDiffR = fabs((pixel152.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel152_prcntDiffG = fabs((pixel152.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel152_prcntDiffB = fabs((pixel152.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel152_prcntDiffA = fabs((pixel152.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel152_prcntDiffR<16)&& (pixel152_prcntDiffG<16)&&(pixel152_prcntDiffB<16 )&&(pixel152_prcntDiffA<16)){
	    pixel_new += (pixel152)*(float)16.0; accumWeights += 16;
    }
    float pixel153_prcntDiffR = fabs((pixel153.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel153_prcntDiffG = fabs((pixel153.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel153_prcntDiffB = fabs((pixel153.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel153_prcntDiffA = fabs((pixel153.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel153_prcntDiffR<16)&& (pixel153_prcntDiffG<16)&&(pixel153_prcntDiffB<16 )&&(pixel153_prcntDiffA<16)){
	    pixel_new += (pixel153)*(float)23.0; accumWeights += 23;
    }
    float pixel154_prcntDiffR = fabs((pixel154.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel154_prcntDiffG = fabs((pixel154.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel154_prcntDiffB = fabs((pixel154.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel154_prcntDiffA = fabs((pixel154.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel154_prcntDiffR<16)&& (pixel154_prcntDiffG<16)&&(pixel154_prcntDiffB<16 )&&(pixel154_prcntDiffA<16)){
	    pixel_new += (pixel154)*(float)32.0; accumWeights += 32;
    }
    float pixel155_prcntDiffR = fabs((pixel155.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel155_prcntDiffG = fabs((pixel155.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel155_prcntDiffB = fabs((pixel155.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel155_prcntDiffA = fabs((pixel155.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel155_prcntDiffR<16)&& (pixel155_prcntDiffG<16)&&(pixel155_prcntDiffB<16 )&&(pixel155_prcntDiffA<16)){
	    pixel_new += (pixel155)*(float)43.0; accumWeights += 43;
    }
    float pixel156_prcntDiffR = fabs((pixel156.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel156_prcntDiffG = fabs((pixel156.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel156_prcntDiffB = fabs((pixel156.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel156_prcntDiffA = fabs((pixel156.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel156_prcntDiffR<16)&& (pixel156_prcntDiffG<16)&&(pixel156_prcntDiffB<16 )&&(pixel156_prcntDiffA<16)){
	    pixel_new += (pixel156)*(float)56.0; accumWeights += 56;
    }
    float pixel157_prcntDiffR = fabs((pixel157.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel157_prcntDiffG = fabs((pixel157.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel157_prcntDiffB = fabs((pixel157.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel157_prcntDiffA = fabs((pixel157.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel157_prcntDiffR<16)&& (pixel157_prcntDiffG<16)&&(pixel157_prcntDiffB<16 )&&(pixel157_prcntDiffA<16)){
	    pixel_new += (pixel157)*(float)68.0; accumWeights += 68;
    }
    float pixel158_prcntDiffR = fabs((pixel158.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel158_prcntDiffG = fabs((pixel158.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel158_prcntDiffB = fabs((pixel158.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel158_prcntDiffA = fabs((pixel158.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel158_prcntDiffR<16)&& (pixel158_prcntDiffG<16)&&(pixel158_prcntDiffB<16 )&&(pixel158_prcntDiffA<16)){
	    pixel_new += (pixel158)*(float)80.0; accumWeights += 80;
    }
    float pixel159_prcntDiffR = fabs((pixel159.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel159_prcntDiffG = fabs((pixel159.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel159_prcntDiffB = fabs((pixel159.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel159_prcntDiffA = fabs((pixel159.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel159_prcntDiffR<16)&& (pixel159_prcntDiffG<16)&&(pixel159_prcntDiffB<16 )&&(pixel159_prcntDiffA<16)){
	    pixel_new += (pixel159)*(float)89.0; accumWeights += 89;
    }
    float pixel160_prcntDiffR = fabs((pixel160.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel160_prcntDiffG = fabs((pixel160.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel160_prcntDiffB = fabs((pixel160.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel160_prcntDiffA = fabs((pixel160.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel160_prcntDiffR<16)&& (pixel160_prcntDiffG<16)&&(pixel160_prcntDiffB<16 )&&(pixel160_prcntDiffA<16)){
	    pixel_new += (pixel160)*(float)95.0; accumWeights += 95;
    }
    float pixel161_prcntDiffR = fabs((pixel161.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel161_prcntDiffG = fabs((pixel161.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel161_prcntDiffB = fabs((pixel161.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel161_prcntDiffA = fabs((pixel161.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel161_prcntDiffR<16)&& (pixel161_prcntDiffG<16)&&(pixel161_prcntDiffB<16 )&&(pixel161_prcntDiffA<16)){
	    pixel_new += (pixel161)*(float)97.0; accumWeights += 97;
    }
    float pixel162_prcntDiffR = fabs((pixel162.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel162_prcntDiffG = fabs((pixel162.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel162_prcntDiffB = fabs((pixel162.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel162_prcntDiffA = fabs((pixel162.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel162_prcntDiffR<16)&& (pixel162_prcntDiffG<16)&&(pixel162_prcntDiffB<16 )&&(pixel162_prcntDiffA<16)){
	    pixel_new += (pixel162)*(float)95.0; accumWeights += 95;
    }
    float pixel163_prcntDiffR = fabs((pixel163.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel163_prcntDiffG = fabs((pixel163.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel163_prcntDiffB = fabs((pixel163.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel163_prcntDiffA = fabs((pixel163.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel163_prcntDiffR<16)&& (pixel163_prcntDiffG<16)&&(pixel163_prcntDiffB<16 )&&(pixel163_prcntDiffA<16)){
	    pixel_new += (pixel163)*(float)89.0; accumWeights += 89;
    }
    float pixel164_prcntDiffR = fabs((pixel164.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel164_prcntDiffG = fabs((pixel164.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel164_prcntDiffB = fabs((pixel164.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel164_prcntDiffA = fabs((pixel164.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel164_prcntDiffR<16)&& (pixel164_prcntDiffG<16)&&(pixel164_prcntDiffB<16 )&&(pixel164_prcntDiffA<16)){
	    pixel_new += (pixel164)*(float)80.0; accumWeights += 80;
    }
    float pixel165_prcntDiffR = fabs((pixel165.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel165_prcntDiffG = fabs((pixel165.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel165_prcntDiffB = fabs((pixel165.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel165_prcntDiffA = fabs((pixel165.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel165_prcntDiffR<16)&& (pixel165_prcntDiffG<16)&&(pixel165_prcntDiffB<16 )&&(pixel165_prcntDiffA<16)){
	    pixel_new += (pixel165)*(float)68.0; accumWeights += 68;
    }
    float pixel166_prcntDiffR = fabs((pixel166.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel166_prcntDiffG = fabs((pixel166.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel166_prcntDiffB = fabs((pixel166.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel166_prcntDiffA = fabs((pixel166.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel166_prcntDiffR<16)&& (pixel166_prcntDiffG<16)&&(pixel166_prcntDiffB<16 )&&(pixel166_prcntDiffA<16)){
	    pixel_new += (pixel166)*(float)56.0; accumWeights += 56;
    }
    float pixel167_prcntDiffR = fabs((pixel167.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel167_prcntDiffG = fabs((pixel167.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel167_prcntDiffB = fabs((pixel167.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel167_prcntDiffA = fabs((pixel167.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel167_prcntDiffR<16)&& (pixel167_prcntDiffG<16)&&(pixel167_prcntDiffB<16 )&&(pixel167_prcntDiffA<16)){
	    pixel_new += (pixel167)*(float)43.0; accumWeights += 43;
    }
    float pixel168_prcntDiffR = fabs((pixel168.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel168_prcntDiffG = fabs((pixel168.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel168_prcntDiffB = fabs((pixel168.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel168_prcntDiffA = fabs((pixel168.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel168_prcntDiffR<16)&& (pixel168_prcntDiffG<16)&&(pixel168_prcntDiffB<16 )&&(pixel168_prcntDiffA<16)){
	    pixel_new += (pixel168)*(float)32.0; accumWeights += 32;
    }
    float pixel169_prcntDiffR = fabs((pixel169.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel169_prcntDiffG = fabs((pixel169.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel169_prcntDiffB = fabs((pixel169.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel169_prcntDiffA = fabs((pixel169.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel169_prcntDiffR<16)&& (pixel169_prcntDiffG<16)&&(pixel169_prcntDiffB<16 )&&(pixel169_prcntDiffA<16)){
	    pixel_new += (pixel169)*(float)23.0; accumWeights += 23;
    }
    float pixel170_prcntDiffR = fabs((pixel170.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel170_prcntDiffG = fabs((pixel170.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel170_prcntDiffB = fabs((pixel170.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel170_prcntDiffA = fabs((pixel170.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel170_prcntDiffR<16)&& (pixel170_prcntDiffG<16)&&(pixel170_prcntDiffB<16 )&&(pixel170_prcntDiffA<16)){
	    pixel_new += (pixel170)*(float)16.0; accumWeights += 16;
    }
    float pixel171_prcntDiffR = fabs((pixel171.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel171_prcntDiffG = fabs((pixel171.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel171_prcntDiffB = fabs((pixel171.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel171_prcntDiffA = fabs((pixel171.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel171_prcntDiffR<16)&& (pixel171_prcntDiffG<16)&&(pixel171_prcntDiffB<16 )&&(pixel171_prcntDiffA<16)){
	    pixel_new += (pixel171)*(float)16.0; accumWeights += 16;
    }
    float pixel172_prcntDiffR = fabs((pixel172.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel172_prcntDiffG = fabs((pixel172.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel172_prcntDiffB = fabs((pixel172.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel172_prcntDiffA = fabs((pixel172.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel172_prcntDiffR<16)&& (pixel172_prcntDiffG<16)&&(pixel172_prcntDiffB<16 )&&(pixel172_prcntDiffA<16)){
	    pixel_new += (pixel172)*(float)24.0; accumWeights += 24;
    }
    float pixel173_prcntDiffR = fabs((pixel173.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel173_prcntDiffG = fabs((pixel173.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel173_prcntDiffB = fabs((pixel173.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel173_prcntDiffA = fabs((pixel173.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel173_prcntDiffR<16)&& (pixel173_prcntDiffG<16)&&(pixel173_prcntDiffB<16 )&&(pixel173_prcntDiffA<16)){
	    pixel_new += (pixel173)*(float)33.0; accumWeights += 33;
    }
    float pixel174_prcntDiffR = fabs((pixel174.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel174_prcntDiffG = fabs((pixel174.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel174_prcntDiffB = fabs((pixel174.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel174_prcntDiffA = fabs((pixel174.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel174_prcntDiffR<16)&& (pixel174_prcntDiffG<16)&&(pixel174_prcntDiffB<16 )&&(pixel174_prcntDiffA<16)){
	    pixel_new += (pixel174)*(float)44.0; accumWeights += 44;
    }
    float pixel175_prcntDiffR = fabs((pixel175.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel175_prcntDiffG = fabs((pixel175.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel175_prcntDiffB = fabs((pixel175.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel175_prcntDiffA = fabs((pixel175.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel175_prcntDiffR<16)&& (pixel175_prcntDiffG<16)&&(pixel175_prcntDiffB<16 )&&(pixel175_prcntDiffA<16)){
	    pixel_new += (pixel175)*(float)57.0; accumWeights += 57;
    }
    float pixel176_prcntDiffR = fabs((pixel176.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel176_prcntDiffG = fabs((pixel176.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel176_prcntDiffB = fabs((pixel176.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel176_prcntDiffA = fabs((pixel176.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel176_prcntDiffR<16)&& (pixel176_prcntDiffG<16)&&(pixel176_prcntDiffB<16 )&&(pixel176_prcntDiffA<16)){
	    pixel_new += (pixel176)*(float)70.0; accumWeights += 70;
    }
    float pixel177_prcntDiffR = fabs((pixel177.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel177_prcntDiffG = fabs((pixel177.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel177_prcntDiffB = fabs((pixel177.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel177_prcntDiffA = fabs((pixel177.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel177_prcntDiffR<16)&& (pixel177_prcntDiffG<16)&&(pixel177_prcntDiffB<16 )&&(pixel177_prcntDiffA<16)){
	    pixel_new += (pixel177)*(float)81.0; accumWeights += 81;
    }
    float pixel178_prcntDiffR = fabs((pixel178.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel178_prcntDiffG = fabs((pixel178.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel178_prcntDiffB = fabs((pixel178.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel178_prcntDiffA = fabs((pixel178.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel178_prcntDiffR<16)&& (pixel178_prcntDiffG<16)&&(pixel178_prcntDiffB<16 )&&(pixel178_prcntDiffA<16)){
	    pixel_new += (pixel178)*(float)91.0; accumWeights += 91;
    }
    float pixel179_prcntDiffR = fabs((pixel179.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel179_prcntDiffG = fabs((pixel179.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel179_prcntDiffB = fabs((pixel179.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel179_prcntDiffA = fabs((pixel179.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel179_prcntDiffR<16)&& (pixel179_prcntDiffG<16)&&(pixel179_prcntDiffB<16 )&&(pixel179_prcntDiffA<16)){
	    pixel_new += (pixel179)*(float)97.0; accumWeights += 97;
    }
    float pixel180_prcntDiffR = fabs((pixel180.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel180_prcntDiffG = fabs((pixel180.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel180_prcntDiffB = fabs((pixel180.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel180_prcntDiffA = fabs((pixel180.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel180_prcntDiffR<16)&& (pixel180_prcntDiffG<16)&&(pixel180_prcntDiffB<16 )&&(pixel180_prcntDiffA<16)){
	    pixel_new += (pixel180)*(float)100.0; accumWeights += 100;
    }
    float pixel181_prcntDiffR = fabs((pixel181.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel181_prcntDiffG = fabs((pixel181.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel181_prcntDiffB = fabs((pixel181.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel181_prcntDiffA = fabs((pixel181.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel181_prcntDiffR<16)&& (pixel181_prcntDiffG<16)&&(pixel181_prcntDiffB<16 )&&(pixel181_prcntDiffA<16)){
	    pixel_new += (pixel181)*(float)97.0; accumWeights += 97;
    }
    float pixel182_prcntDiffR = fabs((pixel182.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel182_prcntDiffG = fabs((pixel182.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel182_prcntDiffB = fabs((pixel182.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel182_prcntDiffA = fabs((pixel182.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel182_prcntDiffR<16)&& (pixel182_prcntDiffG<16)&&(pixel182_prcntDiffB<16 )&&(pixel182_prcntDiffA<16)){
	    pixel_new += (pixel182)*(float)91.0; accumWeights += 91;
    }
    float pixel183_prcntDiffR = fabs((pixel183.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel183_prcntDiffG = fabs((pixel183.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel183_prcntDiffB = fabs((pixel183.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel183_prcntDiffA = fabs((pixel183.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel183_prcntDiffR<16)&& (pixel183_prcntDiffG<16)&&(pixel183_prcntDiffB<16 )&&(pixel183_prcntDiffA<16)){
	    pixel_new += (pixel183)*(float)81.0; accumWeights += 81;
    }
    float pixel184_prcntDiffR = fabs((pixel184.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel184_prcntDiffG = fabs((pixel184.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel184_prcntDiffB = fabs((pixel184.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel184_prcntDiffA = fabs((pixel184.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel184_prcntDiffR<16)&& (pixel184_prcntDiffG<16)&&(pixel184_prcntDiffB<16 )&&(pixel184_prcntDiffA<16)){
	    pixel_new += (pixel184)*(float)70.0; accumWeights += 70;
    }
    float pixel185_prcntDiffR = fabs((pixel185.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel185_prcntDiffG = fabs((pixel185.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel185_prcntDiffB = fabs((pixel185.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel185_prcntDiffA = fabs((pixel185.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel185_prcntDiffR<16)&& (pixel185_prcntDiffG<16)&&(pixel185_prcntDiffB<16 )&&(pixel185_prcntDiffA<16)){
	    pixel_new += (pixel185)*(float)57.0; accumWeights += 57;
    }
    float pixel186_prcntDiffR = fabs((pixel186.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel186_prcntDiffG = fabs((pixel186.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel186_prcntDiffB = fabs((pixel186.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel186_prcntDiffA = fabs((pixel186.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel186_prcntDiffR<16)&& (pixel186_prcntDiffG<16)&&(pixel186_prcntDiffB<16 )&&(pixel186_prcntDiffA<16)){
	    pixel_new += (pixel186)*(float)44.0; accumWeights += 44;
    }
    float pixel187_prcntDiffR = fabs((pixel187.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel187_prcntDiffG = fabs((pixel187.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel187_prcntDiffB = fabs((pixel187.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel187_prcntDiffA = fabs((pixel187.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel187_prcntDiffR<16)&& (pixel187_prcntDiffG<16)&&(pixel187_prcntDiffB<16 )&&(pixel187_prcntDiffA<16)){
	    pixel_new += (pixel187)*(float)33.0; accumWeights += 33;
    }
    float pixel188_prcntDiffR = fabs((pixel188.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel188_prcntDiffG = fabs((pixel188.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel188_prcntDiffB = fabs((pixel188.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel188_prcntDiffA = fabs((pixel188.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel188_prcntDiffR<16)&& (pixel188_prcntDiffG<16)&&(pixel188_prcntDiffB<16 )&&(pixel188_prcntDiffA<16)){
	    pixel_new += (pixel188)*(float)24.0; accumWeights += 24;
    }
    float pixel189_prcntDiffR = fabs((pixel189.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel189_prcntDiffG = fabs((pixel189.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel189_prcntDiffB = fabs((pixel189.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel189_prcntDiffA = fabs((pixel189.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel189_prcntDiffR<16)&& (pixel189_prcntDiffG<16)&&(pixel189_prcntDiffB<16 )&&(pixel189_prcntDiffA<16)){
	    pixel_new += (pixel189)*(float)16.0; accumWeights += 16;
    }
    float pixel190_prcntDiffR = fabs((pixel190.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel190_prcntDiffG = fabs((pixel190.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel190_prcntDiffB = fabs((pixel190.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel190_prcntDiffA = fabs((pixel190.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel190_prcntDiffR<16)&& (pixel190_prcntDiffG<16)&&(pixel190_prcntDiffB<16 )&&(pixel190_prcntDiffA<16)){
	    pixel_new += (pixel190)*(float)16.0; accumWeights += 16;
    }
    float pixel191_prcntDiffR = fabs((pixel191.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel191_prcntDiffG = fabs((pixel191.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel191_prcntDiffB = fabs((pixel191.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel191_prcntDiffA = fabs((pixel191.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel191_prcntDiffR<16)&& (pixel191_prcntDiffG<16)&&(pixel191_prcntDiffB<16 )&&(pixel191_prcntDiffA<16)){
	    pixel_new += (pixel191)*(float)23.0; accumWeights += 23;
    }
    float pixel192_prcntDiffR = fabs((pixel192.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel192_prcntDiffG = fabs((pixel192.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel192_prcntDiffB = fabs((pixel192.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel192_prcntDiffA = fabs((pixel192.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel192_prcntDiffR<16)&& (pixel192_prcntDiffG<16)&&(pixel192_prcntDiffB<16 )&&(pixel192_prcntDiffA<16)){
	    pixel_new += (pixel192)*(float)32.0; accumWeights += 32;
    }
    float pixel193_prcntDiffR = fabs((pixel193.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel193_prcntDiffG = fabs((pixel193.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel193_prcntDiffB = fabs((pixel193.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel193_prcntDiffA = fabs((pixel193.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel193_prcntDiffR<16)&& (pixel193_prcntDiffG<16)&&(pixel193_prcntDiffB<16 )&&(pixel193_prcntDiffA<16)){
	    pixel_new += (pixel193)*(float)43.0; accumWeights += 43;
    }
    float pixel194_prcntDiffR = fabs((pixel194.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel194_prcntDiffG = fabs((pixel194.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel194_prcntDiffB = fabs((pixel194.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel194_prcntDiffA = fabs((pixel194.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel194_prcntDiffR<16)&& (pixel194_prcntDiffG<16)&&(pixel194_prcntDiffB<16 )&&(pixel194_prcntDiffA<16)){
	    pixel_new += (pixel194)*(float)56.0; accumWeights += 56;
    }
    float pixel195_prcntDiffR = fabs((pixel195.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel195_prcntDiffG = fabs((pixel195.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel195_prcntDiffB = fabs((pixel195.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel195_prcntDiffA = fabs((pixel195.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel195_prcntDiffR<16)&& (pixel195_prcntDiffG<16)&&(pixel195_prcntDiffB<16 )&&(pixel195_prcntDiffA<16)){
	    pixel_new += (pixel195)*(float)68.0; accumWeights += 68;
    }
    float pixel196_prcntDiffR = fabs((pixel196.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel196_prcntDiffG = fabs((pixel196.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel196_prcntDiffB = fabs((pixel196.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel196_prcntDiffA = fabs((pixel196.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel196_prcntDiffR<16)&& (pixel196_prcntDiffG<16)&&(pixel196_prcntDiffB<16 )&&(pixel196_prcntDiffA<16)){
	    pixel_new += (pixel196)*(float)80.0; accumWeights += 80;
    }
    float pixel197_prcntDiffR = fabs((pixel197.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel197_prcntDiffG = fabs((pixel197.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel197_prcntDiffB = fabs((pixel197.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel197_prcntDiffA = fabs((pixel197.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel197_prcntDiffR<16)&& (pixel197_prcntDiffG<16)&&(pixel197_prcntDiffB<16 )&&(pixel197_prcntDiffA<16)){
	    pixel_new += (pixel197)*(float)89.0; accumWeights += 89;
    }
    float pixel198_prcntDiffR = fabs((pixel198.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel198_prcntDiffG = fabs((pixel198.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel198_prcntDiffB = fabs((pixel198.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel198_prcntDiffA = fabs((pixel198.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel198_prcntDiffR<16)&& (pixel198_prcntDiffG<16)&&(pixel198_prcntDiffB<16 )&&(pixel198_prcntDiffA<16)){
	    pixel_new += (pixel198)*(float)95.0; accumWeights += 95;
    }
    float pixel199_prcntDiffR = fabs((pixel199.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel199_prcntDiffG = fabs((pixel199.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel199_prcntDiffB = fabs((pixel199.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel199_prcntDiffA = fabs((pixel199.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel199_prcntDiffR<16)&& (pixel199_prcntDiffG<16)&&(pixel199_prcntDiffB<16 )&&(pixel199_prcntDiffA<16)){
	    pixel_new += (pixel199)*(float)97.0; accumWeights += 97;
    }
    float pixel200_prcntDiffR = fabs((pixel200.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel200_prcntDiffG = fabs((pixel200.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel200_prcntDiffB = fabs((pixel200.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel200_prcntDiffA = fabs((pixel200.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel200_prcntDiffR<16)&& (pixel200_prcntDiffG<16)&&(pixel200_prcntDiffB<16 )&&(pixel200_prcntDiffA<16)){
	    pixel_new += (pixel200)*(float)95.0; accumWeights += 95;
    }
    float pixel201_prcntDiffR = fabs((pixel201.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel201_prcntDiffG = fabs((pixel201.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel201_prcntDiffB = fabs((pixel201.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel201_prcntDiffA = fabs((pixel201.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel201_prcntDiffR<16)&& (pixel201_prcntDiffG<16)&&(pixel201_prcntDiffB<16 )&&(pixel201_prcntDiffA<16)){
	    pixel_new += (pixel201)*(float)89.0; accumWeights += 89;
    }
    float pixel202_prcntDiffR = fabs((pixel202.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel202_prcntDiffG = fabs((pixel202.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel202_prcntDiffB = fabs((pixel202.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel202_prcntDiffA = fabs((pixel202.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel202_prcntDiffR<16)&& (pixel202_prcntDiffG<16)&&(pixel202_prcntDiffB<16 )&&(pixel202_prcntDiffA<16)){
	    pixel_new += (pixel202)*(float)80.0; accumWeights += 80;
    }
    float pixel203_prcntDiffR = fabs((pixel203.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel203_prcntDiffG = fabs((pixel203.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel203_prcntDiffB = fabs((pixel203.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel203_prcntDiffA = fabs((pixel203.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel203_prcntDiffR<16)&& (pixel203_prcntDiffG<16)&&(pixel203_prcntDiffB<16 )&&(pixel203_prcntDiffA<16)){
	    pixel_new += (pixel203)*(float)68.0; accumWeights += 68;
    }
    float pixel204_prcntDiffR = fabs((pixel204.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel204_prcntDiffG = fabs((pixel204.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel204_prcntDiffB = fabs((pixel204.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel204_prcntDiffA = fabs((pixel204.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel204_prcntDiffR<16)&& (pixel204_prcntDiffG<16)&&(pixel204_prcntDiffB<16 )&&(pixel204_prcntDiffA<16)){
	    pixel_new += (pixel204)*(float)56.0; accumWeights += 56;
    }
    float pixel205_prcntDiffR = fabs((pixel205.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel205_prcntDiffG = fabs((pixel205.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel205_prcntDiffB = fabs((pixel205.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel205_prcntDiffA = fabs((pixel205.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel205_prcntDiffR<16)&& (pixel205_prcntDiffG<16)&&(pixel205_prcntDiffB<16 )&&(pixel205_prcntDiffA<16)){
	    pixel_new += (pixel205)*(float)43.0; accumWeights += 43;
    }
    float pixel206_prcntDiffR = fabs((pixel206.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel206_prcntDiffG = fabs((pixel206.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel206_prcntDiffB = fabs((pixel206.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel206_prcntDiffA = fabs((pixel206.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel206_prcntDiffR<16)&& (pixel206_prcntDiffG<16)&&(pixel206_prcntDiffB<16 )&&(pixel206_prcntDiffA<16)){
	    pixel_new += (pixel206)*(float)32.0; accumWeights += 32;
    }
    float pixel207_prcntDiffR = fabs((pixel207.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel207_prcntDiffG = fabs((pixel207.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel207_prcntDiffB = fabs((pixel207.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel207_prcntDiffA = fabs((pixel207.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel207_prcntDiffR<16)&& (pixel207_prcntDiffG<16)&&(pixel207_prcntDiffB<16 )&&(pixel207_prcntDiffA<16)){
	    pixel_new += (pixel207)*(float)23.0; accumWeights += 23;
    }
    float pixel208_prcntDiffR = fabs((pixel208.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel208_prcntDiffG = fabs((pixel208.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel208_prcntDiffB = fabs((pixel208.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel208_prcntDiffA = fabs((pixel208.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel208_prcntDiffR<16)&& (pixel208_prcntDiffG<16)&&(pixel208_prcntDiffB<16 )&&(pixel208_prcntDiffA<16)){
	    pixel_new += (pixel208)*(float)16.0; accumWeights += 16;
    }
    float pixel209_prcntDiffR = fabs((pixel209.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel209_prcntDiffG = fabs((pixel209.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel209_prcntDiffB = fabs((pixel209.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel209_prcntDiffA = fabs((pixel209.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel209_prcntDiffR<16)&& (pixel209_prcntDiffG<16)&&(pixel209_prcntDiffB<16 )&&(pixel209_prcntDiffA<16)){
	    pixel_new += (pixel209)*(float)15.0; accumWeights += 15;
    }
    float pixel210_prcntDiffR = fabs((pixel210.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel210_prcntDiffG = fabs((pixel210.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel210_prcntDiffB = fabs((pixel210.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel210_prcntDiffA = fabs((pixel210.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel210_prcntDiffR<16)&& (pixel210_prcntDiffG<16)&&(pixel210_prcntDiffB<16 )&&(pixel210_prcntDiffA<16)){
	    pixel_new += (pixel210)*(float)22.0; accumWeights += 22;
    }
    float pixel211_prcntDiffR = fabs((pixel211.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel211_prcntDiffG = fabs((pixel211.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel211_prcntDiffB = fabs((pixel211.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel211_prcntDiffA = fabs((pixel211.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel211_prcntDiffR<16)&& (pixel211_prcntDiffG<16)&&(pixel211_prcntDiffB<16 )&&(pixel211_prcntDiffA<16)){
	    pixel_new += (pixel211)*(float)30.0; accumWeights += 30;
    }
    float pixel212_prcntDiffR = fabs((pixel212.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel212_prcntDiffG = fabs((pixel212.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel212_prcntDiffB = fabs((pixel212.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel212_prcntDiffA = fabs((pixel212.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel212_prcntDiffR<16)&& (pixel212_prcntDiffG<16)&&(pixel212_prcntDiffB<16 )&&(pixel212_prcntDiffA<16)){
	    pixel_new += (pixel212)*(float)41.0; accumWeights += 41;
    }
    float pixel213_prcntDiffR = fabs((pixel213.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel213_prcntDiffG = fabs((pixel213.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel213_prcntDiffB = fabs((pixel213.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel213_prcntDiffA = fabs((pixel213.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel213_prcntDiffR<16)&& (pixel213_prcntDiffG<16)&&(pixel213_prcntDiffB<16 )&&(pixel213_prcntDiffA<16)){
	    pixel_new += (pixel213)*(float)52.0; accumWeights += 52;
    }
    float pixel214_prcntDiffR = fabs((pixel214.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel214_prcntDiffG = fabs((pixel214.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel214_prcntDiffB = fabs((pixel214.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel214_prcntDiffA = fabs((pixel214.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel214_prcntDiffR<16)&& (pixel214_prcntDiffG<16)&&(pixel214_prcntDiffB<16 )&&(pixel214_prcntDiffA<16)){
	    pixel_new += (pixel214)*(float)64.0; accumWeights += 64;
    }
    float pixel215_prcntDiffR = fabs((pixel215.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel215_prcntDiffG = fabs((pixel215.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel215_prcntDiffB = fabs((pixel215.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel215_prcntDiffA = fabs((pixel215.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel215_prcntDiffR<16)&& (pixel215_prcntDiffG<16)&&(pixel215_prcntDiffB<16 )&&(pixel215_prcntDiffA<16)){
	    pixel_new += (pixel215)*(float)74.0; accumWeights += 74;
    }
    float pixel216_prcntDiffR = fabs((pixel216.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel216_prcntDiffG = fabs((pixel216.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel216_prcntDiffB = fabs((pixel216.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel216_prcntDiffA = fabs((pixel216.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel216_prcntDiffR<16)&& (pixel216_prcntDiffG<16)&&(pixel216_prcntDiffB<16 )&&(pixel216_prcntDiffA<16)){
	    pixel_new += (pixel216)*(float)83.0; accumWeights += 83;
    }
    float pixel217_prcntDiffR = fabs((pixel217.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel217_prcntDiffG = fabs((pixel217.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel217_prcntDiffB = fabs((pixel217.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel217_prcntDiffA = fabs((pixel217.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel217_prcntDiffR<16)&& (pixel217_prcntDiffG<16)&&(pixel217_prcntDiffB<16 )&&(pixel217_prcntDiffA<16)){
	    pixel_new += (pixel217)*(float)89.0; accumWeights += 89;
    }
    float pixel218_prcntDiffR = fabs((pixel218.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel218_prcntDiffG = fabs((pixel218.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel218_prcntDiffB = fabs((pixel218.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel218_prcntDiffA = fabs((pixel218.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel218_prcntDiffR<16)&& (pixel218_prcntDiffG<16)&&(pixel218_prcntDiffB<16 )&&(pixel218_prcntDiffA<16)){
	    pixel_new += (pixel218)*(float)91.0; accumWeights += 91;
    }
    float pixel219_prcntDiffR = fabs((pixel219.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel219_prcntDiffG = fabs((pixel219.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel219_prcntDiffB = fabs((pixel219.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel219_prcntDiffA = fabs((pixel219.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel219_prcntDiffR<16)&& (pixel219_prcntDiffG<16)&&(pixel219_prcntDiffB<16 )&&(pixel219_prcntDiffA<16)){
	    pixel_new += (pixel219)*(float)89.0; accumWeights += 89;
    }
    float pixel220_prcntDiffR = fabs((pixel220.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel220_prcntDiffG = fabs((pixel220.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel220_prcntDiffB = fabs((pixel220.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel220_prcntDiffA = fabs((pixel220.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel220_prcntDiffR<16)&& (pixel220_prcntDiffG<16)&&(pixel220_prcntDiffB<16 )&&(pixel220_prcntDiffA<16)){
	    pixel_new += (pixel220)*(float)83.0; accumWeights += 83;
    }
    float pixel221_prcntDiffR = fabs((pixel221.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel221_prcntDiffG = fabs((pixel221.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel221_prcntDiffB = fabs((pixel221.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel221_prcntDiffA = fabs((pixel221.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel221_prcntDiffR<16)&& (pixel221_prcntDiffG<16)&&(pixel221_prcntDiffB<16 )&&(pixel221_prcntDiffA<16)){
	    pixel_new += (pixel221)*(float)74.0; accumWeights += 74;
    }
    float pixel222_prcntDiffR = fabs((pixel222.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel222_prcntDiffG = fabs((pixel222.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel222_prcntDiffB = fabs((pixel222.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel222_prcntDiffA = fabs((pixel222.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel222_prcntDiffR<16)&& (pixel222_prcntDiffG<16)&&(pixel222_prcntDiffB<16 )&&(pixel222_prcntDiffA<16)){
	    pixel_new += (pixel222)*(float)64.0; accumWeights += 64;
    }
    float pixel223_prcntDiffR = fabs((pixel223.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel223_prcntDiffG = fabs((pixel223.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel223_prcntDiffB = fabs((pixel223.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel223_prcntDiffA = fabs((pixel223.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel223_prcntDiffR<16)&& (pixel223_prcntDiffG<16)&&(pixel223_prcntDiffB<16 )&&(pixel223_prcntDiffA<16)){
	    pixel_new += (pixel223)*(float)52.0; accumWeights += 52;
    }
    float pixel224_prcntDiffR = fabs((pixel224.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel224_prcntDiffG = fabs((pixel224.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel224_prcntDiffB = fabs((pixel224.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel224_prcntDiffA = fabs((pixel224.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel224_prcntDiffR<16)&& (pixel224_prcntDiffG<16)&&(pixel224_prcntDiffB<16 )&&(pixel224_prcntDiffA<16)){
	    pixel_new += (pixel224)*(float)41.0; accumWeights += 41;
    }
    float pixel225_prcntDiffR = fabs((pixel225.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel225_prcntDiffG = fabs((pixel225.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel225_prcntDiffB = fabs((pixel225.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel225_prcntDiffA = fabs((pixel225.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel225_prcntDiffR<16)&& (pixel225_prcntDiffG<16)&&(pixel225_prcntDiffB<16 )&&(pixel225_prcntDiffA<16)){
	    pixel_new += (pixel225)*(float)30.0; accumWeights += 30;
    }
    float pixel226_prcntDiffR = fabs((pixel226.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel226_prcntDiffG = fabs((pixel226.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel226_prcntDiffB = fabs((pixel226.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel226_prcntDiffA = fabs((pixel226.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel226_prcntDiffR<16)&& (pixel226_prcntDiffG<16)&&(pixel226_prcntDiffB<16 )&&(pixel226_prcntDiffA<16)){
	    pixel_new += (pixel226)*(float)22.0; accumWeights += 22;
    }
    float pixel227_prcntDiffR = fabs((pixel227.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel227_prcntDiffG = fabs((pixel227.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel227_prcntDiffB = fabs((pixel227.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel227_prcntDiffA = fabs((pixel227.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel227_prcntDiffR<16)&& (pixel227_prcntDiffG<16)&&(pixel227_prcntDiffB<16 )&&(pixel227_prcntDiffA<16)){
	    pixel_new += (pixel227)*(float)15.0; accumWeights += 15;
    }
    float pixel228_prcntDiffR = fabs((pixel228.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel228_prcntDiffG = fabs((pixel228.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel228_prcntDiffB = fabs((pixel228.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel228_prcntDiffA = fabs((pixel228.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel228_prcntDiffR<16)&& (pixel228_prcntDiffG<16)&&(pixel228_prcntDiffB<16 )&&(pixel228_prcntDiffA<16)){
	    pixel_new += (pixel228)*(float)13.0; accumWeights += 13;
    }
    float pixel229_prcntDiffR = fabs((pixel229.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel229_prcntDiffG = fabs((pixel229.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel229_prcntDiffB = fabs((pixel229.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel229_prcntDiffA = fabs((pixel229.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel229_prcntDiffR<16)&& (pixel229_prcntDiffG<16)&&(pixel229_prcntDiffB<16 )&&(pixel229_prcntDiffA<16)){
	    pixel_new += (pixel229)*(float)19.0; accumWeights += 19;
    }
    float pixel230_prcntDiffR = fabs((pixel230.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel230_prcntDiffG = fabs((pixel230.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel230_prcntDiffB = fabs((pixel230.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel230_prcntDiffA = fabs((pixel230.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel230_prcntDiffR<16)&& (pixel230_prcntDiffG<16)&&(pixel230_prcntDiffB<16 )&&(pixel230_prcntDiffA<16)){
	    pixel_new += (pixel230)*(float)27.0; accumWeights += 27;
    }
    float pixel231_prcntDiffR = fabs((pixel231.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel231_prcntDiffG = fabs((pixel231.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel231_prcntDiffB = fabs((pixel231.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel231_prcntDiffA = fabs((pixel231.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel231_prcntDiffR<16)&& (pixel231_prcntDiffG<16)&&(pixel231_prcntDiffB<16 )&&(pixel231_prcntDiffA<16)){
	    pixel_new += (pixel231)*(float)36.0; accumWeights += 36;
    }
    float pixel232_prcntDiffR = fabs((pixel232.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel232_prcntDiffG = fabs((pixel232.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel232_prcntDiffB = fabs((pixel232.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel232_prcntDiffA = fabs((pixel232.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel232_prcntDiffR<16)&& (pixel232_prcntDiffG<16)&&(pixel232_prcntDiffB<16 )&&(pixel232_prcntDiffA<16)){
	    pixel_new += (pixel232)*(float)46.0; accumWeights += 46;
    }
    float pixel233_prcntDiffR = fabs((pixel233.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel233_prcntDiffG = fabs((pixel233.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel233_prcntDiffB = fabs((pixel233.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel233_prcntDiffA = fabs((pixel233.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel233_prcntDiffR<16)&& (pixel233_prcntDiffG<16)&&(pixel233_prcntDiffB<16 )&&(pixel233_prcntDiffA<16)){
	    pixel_new += (pixel233)*(float)57.0; accumWeights += 57;
    }
    float pixel234_prcntDiffR = fabs((pixel234.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel234_prcntDiffG = fabs((pixel234.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel234_prcntDiffB = fabs((pixel234.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel234_prcntDiffA = fabs((pixel234.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel234_prcntDiffR<16)&& (pixel234_prcntDiffG<16)&&(pixel234_prcntDiffB<16 )&&(pixel234_prcntDiffA<16)){
	    pixel_new += (pixel234)*(float)67.0; accumWeights += 67;
    }
    float pixel235_prcntDiffR = fabs((pixel235.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel235_prcntDiffG = fabs((pixel235.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel235_prcntDiffB = fabs((pixel235.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel235_prcntDiffA = fabs((pixel235.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel235_prcntDiffR<16)&& (pixel235_prcntDiffG<16)&&(pixel235_prcntDiffB<16 )&&(pixel235_prcntDiffA<16)){
	    pixel_new += (pixel235)*(float)74.0; accumWeights += 74;
    }
    float pixel236_prcntDiffR = fabs((pixel236.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel236_prcntDiffG = fabs((pixel236.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel236_prcntDiffB = fabs((pixel236.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel236_prcntDiffA = fabs((pixel236.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel236_prcntDiffR<16)&& (pixel236_prcntDiffG<16)&&(pixel236_prcntDiffB<16 )&&(pixel236_prcntDiffA<16)){
	    pixel_new += (pixel236)*(float)80.0; accumWeights += 80;
    }
    float pixel237_prcntDiffR = fabs((pixel237.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel237_prcntDiffG = fabs((pixel237.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel237_prcntDiffB = fabs((pixel237.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel237_prcntDiffA = fabs((pixel237.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel237_prcntDiffR<16)&& (pixel237_prcntDiffG<16)&&(pixel237_prcntDiffB<16 )&&(pixel237_prcntDiffA<16)){
	    pixel_new += (pixel237)*(float)81.0; accumWeights += 81;
    }
    float pixel238_prcntDiffR = fabs((pixel238.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel238_prcntDiffG = fabs((pixel238.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel238_prcntDiffB = fabs((pixel238.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel238_prcntDiffA = fabs((pixel238.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel238_prcntDiffR<16)&& (pixel238_prcntDiffG<16)&&(pixel238_prcntDiffB<16 )&&(pixel238_prcntDiffA<16)){
	    pixel_new += (pixel238)*(float)80.0; accumWeights += 80;
    }
    float pixel239_prcntDiffR = fabs((pixel239.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel239_prcntDiffG = fabs((pixel239.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel239_prcntDiffB = fabs((pixel239.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel239_prcntDiffA = fabs((pixel239.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel239_prcntDiffR<16)&& (pixel239_prcntDiffG<16)&&(pixel239_prcntDiffB<16 )&&(pixel239_prcntDiffA<16)){
	    pixel_new += (pixel239)*(float)74.0; accumWeights += 74;
    }
    float pixel240_prcntDiffR = fabs((pixel240.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel240_prcntDiffG = fabs((pixel240.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel240_prcntDiffB = fabs((pixel240.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel240_prcntDiffA = fabs((pixel240.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel240_prcntDiffR<16)&& (pixel240_prcntDiffG<16)&&(pixel240_prcntDiffB<16 )&&(pixel240_prcntDiffA<16)){
	    pixel_new += (pixel240)*(float)67.0; accumWeights += 67;
    }
    float pixel241_prcntDiffR = fabs((pixel241.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel241_prcntDiffG = fabs((pixel241.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel241_prcntDiffB = fabs((pixel241.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel241_prcntDiffA = fabs((pixel241.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel241_prcntDiffR<16)&& (pixel241_prcntDiffG<16)&&(pixel241_prcntDiffB<16 )&&(pixel241_prcntDiffA<16)){
	    pixel_new += (pixel241)*(float)57.0; accumWeights += 57;
    }
    float pixel242_prcntDiffR = fabs((pixel242.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel242_prcntDiffG = fabs((pixel242.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel242_prcntDiffB = fabs((pixel242.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel242_prcntDiffA = fabs((pixel242.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel242_prcntDiffR<16)&& (pixel242_prcntDiffG<16)&&(pixel242_prcntDiffB<16 )&&(pixel242_prcntDiffA<16)){
	    pixel_new += (pixel242)*(float)46.0; accumWeights += 46;
    }
    float pixel243_prcntDiffR = fabs((pixel243.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel243_prcntDiffG = fabs((pixel243.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel243_prcntDiffB = fabs((pixel243.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel243_prcntDiffA = fabs((pixel243.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel243_prcntDiffR<16)&& (pixel243_prcntDiffG<16)&&(pixel243_prcntDiffB<16 )&&(pixel243_prcntDiffA<16)){
	    pixel_new += (pixel243)*(float)36.0; accumWeights += 36;
    }
    float pixel244_prcntDiffR = fabs((pixel244.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel244_prcntDiffG = fabs((pixel244.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel244_prcntDiffB = fabs((pixel244.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel244_prcntDiffA = fabs((pixel244.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel244_prcntDiffR<16)&& (pixel244_prcntDiffG<16)&&(pixel244_prcntDiffB<16 )&&(pixel244_prcntDiffA<16)){
	    pixel_new += (pixel244)*(float)27.0; accumWeights += 27;
    }
    float pixel245_prcntDiffR = fabs((pixel245.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel245_prcntDiffG = fabs((pixel245.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel245_prcntDiffB = fabs((pixel245.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel245_prcntDiffA = fabs((pixel245.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel245_prcntDiffR<16)&& (pixel245_prcntDiffG<16)&&(pixel245_prcntDiffB<16 )&&(pixel245_prcntDiffA<16)){
	    pixel_new += (pixel245)*(float)19.0; accumWeights += 19;
    }
    float pixel246_prcntDiffR = fabs((pixel246.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel246_prcntDiffG = fabs((pixel246.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel246_prcntDiffB = fabs((pixel246.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel246_prcntDiffA = fabs((pixel246.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel246_prcntDiffR<16)&& (pixel246_prcntDiffG<16)&&(pixel246_prcntDiffB<16 )&&(pixel246_prcntDiffA<16)){
	    pixel_new += (pixel246)*(float)13.0; accumWeights += 13;
    }
    float pixel247_prcntDiffR = fabs((pixel247.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel247_prcntDiffG = fabs((pixel247.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel247_prcntDiffB = fabs((pixel247.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel247_prcntDiffA = fabs((pixel247.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel247_prcntDiffR<16)&& (pixel247_prcntDiffG<16)&&(pixel247_prcntDiffB<16 )&&(pixel247_prcntDiffA<16)){
	    pixel_new += (pixel247)*(float)11.0; accumWeights += 11;
    }
    float pixel248_prcntDiffR = fabs((pixel248.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel248_prcntDiffG = fabs((pixel248.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel248_prcntDiffB = fabs((pixel248.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel248_prcntDiffA = fabs((pixel248.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel248_prcntDiffR<16)&& (pixel248_prcntDiffG<16)&&(pixel248_prcntDiffB<16 )&&(pixel248_prcntDiffA<16)){
	    pixel_new += (pixel248)*(float)16.0; accumWeights += 16;
    }
    float pixel249_prcntDiffR = fabs((pixel249.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel249_prcntDiffG = fabs((pixel249.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel249_prcntDiffB = fabs((pixel249.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel249_prcntDiffA = fabs((pixel249.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel249_prcntDiffR<16)&& (pixel249_prcntDiffG<16)&&(pixel249_prcntDiffB<16 )&&(pixel249_prcntDiffA<16)){
	    pixel_new += (pixel249)*(float)23.0; accumWeights += 23;
    }
    float pixel250_prcntDiffR = fabs((pixel250.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel250_prcntDiffG = fabs((pixel250.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel250_prcntDiffB = fabs((pixel250.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel250_prcntDiffA = fabs((pixel250.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel250_prcntDiffR<16)&& (pixel250_prcntDiffG<16)&&(pixel250_prcntDiffB<16 )&&(pixel250_prcntDiffA<16)){
	    pixel_new += (pixel250)*(float)31.0; accumWeights += 31;
    }
    float pixel251_prcntDiffR = fabs((pixel251.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel251_prcntDiffG = fabs((pixel251.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel251_prcntDiffB = fabs((pixel251.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel251_prcntDiffA = fabs((pixel251.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel251_prcntDiffR<16)&& (pixel251_prcntDiffG<16)&&(pixel251_prcntDiffB<16 )&&(pixel251_prcntDiffA<16)){
	    pixel_new += (pixel251)*(float)40.0; accumWeights += 40;
    }
    float pixel252_prcntDiffR = fabs((pixel252.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel252_prcntDiffG = fabs((pixel252.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel252_prcntDiffB = fabs((pixel252.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel252_prcntDiffA = fabs((pixel252.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel252_prcntDiffR<16)&& (pixel252_prcntDiffG<16)&&(pixel252_prcntDiffB<16 )&&(pixel252_prcntDiffA<16)){
	    pixel_new += (pixel252)*(float)49.0; accumWeights += 49;
    }
    float pixel253_prcntDiffR = fabs((pixel253.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel253_prcntDiffG = fabs((pixel253.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel253_prcntDiffB = fabs((pixel253.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel253_prcntDiffA = fabs((pixel253.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel253_prcntDiffR<16)&& (pixel253_prcntDiffG<16)&&(pixel253_prcntDiffB<16 )&&(pixel253_prcntDiffA<16)){
	    pixel_new += (pixel253)*(float)57.0; accumWeights += 57;
    }
    float pixel254_prcntDiffR = fabs((pixel254.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel254_prcntDiffG = fabs((pixel254.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel254_prcntDiffB = fabs((pixel254.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel254_prcntDiffA = fabs((pixel254.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel254_prcntDiffR<16)&& (pixel254_prcntDiffG<16)&&(pixel254_prcntDiffB<16 )&&(pixel254_prcntDiffA<16)){
	    pixel_new += (pixel254)*(float)64.0; accumWeights += 64;
    }
    float pixel255_prcntDiffR = fabs((pixel255.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel255_prcntDiffG = fabs((pixel255.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel255_prcntDiffB = fabs((pixel255.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel255_prcntDiffA = fabs((pixel255.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel255_prcntDiffR<16)&& (pixel255_prcntDiffG<16)&&(pixel255_prcntDiffB<16 )&&(pixel255_prcntDiffA<16)){
	    pixel_new += (pixel255)*(float)68.0; accumWeights += 68;
    }
    float pixel256_prcntDiffR = fabs((pixel256.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel256_prcntDiffG = fabs((pixel256.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel256_prcntDiffB = fabs((pixel256.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel256_prcntDiffA = fabs((pixel256.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel256_prcntDiffR<16)&& (pixel256_prcntDiffG<16)&&(pixel256_prcntDiffB<16 )&&(pixel256_prcntDiffA<16)){
	    pixel_new += (pixel256)*(float)70.0; accumWeights += 70;
    }
    float pixel257_prcntDiffR = fabs((pixel257.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel257_prcntDiffG = fabs((pixel257.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel257_prcntDiffB = fabs((pixel257.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel257_prcntDiffA = fabs((pixel257.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel257_prcntDiffR<16)&& (pixel257_prcntDiffG<16)&&(pixel257_prcntDiffB<16 )&&(pixel257_prcntDiffA<16)){
	    pixel_new += (pixel257)*(float)68.0; accumWeights += 68;
    }
    float pixel258_prcntDiffR = fabs((pixel258.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel258_prcntDiffG = fabs((pixel258.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel258_prcntDiffB = fabs((pixel258.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel258_prcntDiffA = fabs((pixel258.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel258_prcntDiffR<16)&& (pixel258_prcntDiffG<16)&&(pixel258_prcntDiffB<16 )&&(pixel258_prcntDiffA<16)){
	    pixel_new += (pixel258)*(float)64.0; accumWeights += 64;
    }
    float pixel259_prcntDiffR = fabs((pixel259.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel259_prcntDiffG = fabs((pixel259.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel259_prcntDiffB = fabs((pixel259.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel259_prcntDiffA = fabs((pixel259.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel259_prcntDiffR<16)&& (pixel259_prcntDiffG<16)&&(pixel259_prcntDiffB<16 )&&(pixel259_prcntDiffA<16)){
	    pixel_new += (pixel259)*(float)57.0; accumWeights += 57;
    }
    float pixel260_prcntDiffR = fabs((pixel260.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel260_prcntDiffG = fabs((pixel260.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel260_prcntDiffB = fabs((pixel260.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel260_prcntDiffA = fabs((pixel260.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel260_prcntDiffR<16)&& (pixel260_prcntDiffG<16)&&(pixel260_prcntDiffB<16 )&&(pixel260_prcntDiffA<16)){
	    pixel_new += (pixel260)*(float)49.0; accumWeights += 49;
    }
    float pixel261_prcntDiffR = fabs((pixel261.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel261_prcntDiffG = fabs((pixel261.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel261_prcntDiffB = fabs((pixel261.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel261_prcntDiffA = fabs((pixel261.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel261_prcntDiffR<16)&& (pixel261_prcntDiffG<16)&&(pixel261_prcntDiffB<16 )&&(pixel261_prcntDiffA<16)){
	    pixel_new += (pixel261)*(float)40.0; accumWeights += 40;
    }
    float pixel262_prcntDiffR = fabs((pixel262.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel262_prcntDiffG = fabs((pixel262.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel262_prcntDiffB = fabs((pixel262.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel262_prcntDiffA = fabs((pixel262.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel262_prcntDiffR<16)&& (pixel262_prcntDiffG<16)&&(pixel262_prcntDiffB<16 )&&(pixel262_prcntDiffA<16)){
	    pixel_new += (pixel262)*(float)31.0; accumWeights += 31;
    }
    float pixel263_prcntDiffR = fabs((pixel263.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel263_prcntDiffG = fabs((pixel263.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel263_prcntDiffB = fabs((pixel263.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel263_prcntDiffA = fabs((pixel263.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel263_prcntDiffR<16)&& (pixel263_prcntDiffG<16)&&(pixel263_prcntDiffB<16 )&&(pixel263_prcntDiffA<16)){
	    pixel_new += (pixel263)*(float)23.0; accumWeights += 23;
    }
    float pixel264_prcntDiffR = fabs((pixel264.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel264_prcntDiffG = fabs((pixel264.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel264_prcntDiffB = fabs((pixel264.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel264_prcntDiffA = fabs((pixel264.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel264_prcntDiffR<16)&& (pixel264_prcntDiffG<16)&&(pixel264_prcntDiffB<16 )&&(pixel264_prcntDiffA<16)){
	    pixel_new += (pixel264)*(float)16.0; accumWeights += 16;
    }
    float pixel265_prcntDiffR = fabs((pixel265.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel265_prcntDiffG = fabs((pixel265.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel265_prcntDiffB = fabs((pixel265.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel265_prcntDiffA = fabs((pixel265.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel265_prcntDiffR<16)&& (pixel265_prcntDiffG<16)&&(pixel265_prcntDiffB<16 )&&(pixel265_prcntDiffA<16)){
	    pixel_new += (pixel265)*(float)11.0; accumWeights += 11;
    }
    float pixel266_prcntDiffR = fabs((pixel266.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel266_prcntDiffG = fabs((pixel266.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel266_prcntDiffB = fabs((pixel266.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel266_prcntDiffA = fabs((pixel266.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel266_prcntDiffR<16)&& (pixel266_prcntDiffG<16)&&(pixel266_prcntDiffB<16 )&&(pixel266_prcntDiffA<16)){
	    pixel_new += (pixel266)*(float)9.0; accumWeights += 9;
    }
    float pixel267_prcntDiffR = fabs((pixel267.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel267_prcntDiffG = fabs((pixel267.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel267_prcntDiffB = fabs((pixel267.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel267_prcntDiffA = fabs((pixel267.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel267_prcntDiffR<16)&& (pixel267_prcntDiffG<16)&&(pixel267_prcntDiffB<16 )&&(pixel267_prcntDiffA<16)){
	    pixel_new += (pixel267)*(float)13.0; accumWeights += 13;
    }
    float pixel268_prcntDiffR = fabs((pixel268.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel268_prcntDiffG = fabs((pixel268.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel268_prcntDiffB = fabs((pixel268.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel268_prcntDiffA = fabs((pixel268.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel268_prcntDiffR<16)&& (pixel268_prcntDiffG<16)&&(pixel268_prcntDiffB<16 )&&(pixel268_prcntDiffA<16)){
	    pixel_new += (pixel268)*(float)19.0; accumWeights += 19;
    }
    float pixel269_prcntDiffR = fabs((pixel269.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel269_prcntDiffG = fabs((pixel269.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel269_prcntDiffB = fabs((pixel269.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel269_prcntDiffA = fabs((pixel269.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel269_prcntDiffR<16)&& (pixel269_prcntDiffG<16)&&(pixel269_prcntDiffB<16 )&&(pixel269_prcntDiffA<16)){
	    pixel_new += (pixel269)*(float)25.0; accumWeights += 25;
    }
    float pixel270_prcntDiffR = fabs((pixel270.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel270_prcntDiffG = fabs((pixel270.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel270_prcntDiffB = fabs((pixel270.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel270_prcntDiffA = fabs((pixel270.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel270_prcntDiffR<16)&& (pixel270_prcntDiffG<16)&&(pixel270_prcntDiffB<16 )&&(pixel270_prcntDiffA<16)){
	    pixel_new += (pixel270)*(float)32.0; accumWeights += 32;
    }
    float pixel271_prcntDiffR = fabs((pixel271.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel271_prcntDiffG = fabs((pixel271.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel271_prcntDiffB = fabs((pixel271.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel271_prcntDiffA = fabs((pixel271.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel271_prcntDiffR<16)&& (pixel271_prcntDiffG<16)&&(pixel271_prcntDiffB<16 )&&(pixel271_prcntDiffA<16)){
	    pixel_new += (pixel271)*(float)40.0; accumWeights += 40;
    }
    float pixel272_prcntDiffR = fabs((pixel272.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel272_prcntDiffG = fabs((pixel272.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel272_prcntDiffB = fabs((pixel272.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel272_prcntDiffA = fabs((pixel272.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel272_prcntDiffR<16)&& (pixel272_prcntDiffG<16)&&(pixel272_prcntDiffB<16 )&&(pixel272_prcntDiffA<16)){
	    pixel_new += (pixel272)*(float)46.0; accumWeights += 46;
    }
    float pixel273_prcntDiffR = fabs((pixel273.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel273_prcntDiffG = fabs((pixel273.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel273_prcntDiffB = fabs((pixel273.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel273_prcntDiffA = fabs((pixel273.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel273_prcntDiffR<16)&& (pixel273_prcntDiffG<16)&&(pixel273_prcntDiffB<16 )&&(pixel273_prcntDiffA<16)){
	    pixel_new += (pixel273)*(float)52.0; accumWeights += 52;
    }
    float pixel274_prcntDiffR = fabs((pixel274.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel274_prcntDiffG = fabs((pixel274.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel274_prcntDiffB = fabs((pixel274.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel274_prcntDiffA = fabs((pixel274.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel274_prcntDiffR<16)&& (pixel274_prcntDiffG<16)&&(pixel274_prcntDiffB<16 )&&(pixel274_prcntDiffA<16)){
	    pixel_new += (pixel274)*(float)56.0; accumWeights += 56;
    }
    float pixel275_prcntDiffR = fabs((pixel275.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel275_prcntDiffG = fabs((pixel275.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel275_prcntDiffB = fabs((pixel275.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel275_prcntDiffA = fabs((pixel275.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel275_prcntDiffR<16)&& (pixel275_prcntDiffG<16)&&(pixel275_prcntDiffB<16 )&&(pixel275_prcntDiffA<16)){
	    pixel_new += (pixel275)*(float)57.0; accumWeights += 57;
    }
    float pixel276_prcntDiffR = fabs((pixel276.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel276_prcntDiffG = fabs((pixel276.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel276_prcntDiffB = fabs((pixel276.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel276_prcntDiffA = fabs((pixel276.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel276_prcntDiffR<16)&& (pixel276_prcntDiffG<16)&&(pixel276_prcntDiffB<16 )&&(pixel276_prcntDiffA<16)){
	    pixel_new += (pixel276)*(float)56.0; accumWeights += 56;
    }
    float pixel277_prcntDiffR = fabs((pixel277.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel277_prcntDiffG = fabs((pixel277.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel277_prcntDiffB = fabs((pixel277.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel277_prcntDiffA = fabs((pixel277.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel277_prcntDiffR<16)&& (pixel277_prcntDiffG<16)&&(pixel277_prcntDiffB<16 )&&(pixel277_prcntDiffA<16)){
	    pixel_new += (pixel277)*(float)52.0; accumWeights += 52;
    }
    float pixel278_prcntDiffR = fabs((pixel278.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel278_prcntDiffG = fabs((pixel278.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel278_prcntDiffB = fabs((pixel278.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel278_prcntDiffA = fabs((pixel278.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel278_prcntDiffR<16)&& (pixel278_prcntDiffG<16)&&(pixel278_prcntDiffB<16 )&&(pixel278_prcntDiffA<16)){
	    pixel_new += (pixel278)*(float)46.0; accumWeights += 46;
    }
    float pixel279_prcntDiffR = fabs((pixel279.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel279_prcntDiffG = fabs((pixel279.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel279_prcntDiffB = fabs((pixel279.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel279_prcntDiffA = fabs((pixel279.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel279_prcntDiffR<16)&& (pixel279_prcntDiffG<16)&&(pixel279_prcntDiffB<16 )&&(pixel279_prcntDiffA<16)){
	    pixel_new += (pixel279)*(float)40.0; accumWeights += 40;
    }
    float pixel280_prcntDiffR = fabs((pixel280.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel280_prcntDiffG = fabs((pixel280.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel280_prcntDiffB = fabs((pixel280.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel280_prcntDiffA = fabs((pixel280.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel280_prcntDiffR<16)&& (pixel280_prcntDiffG<16)&&(pixel280_prcntDiffB<16 )&&(pixel280_prcntDiffA<16)){
	    pixel_new += (pixel280)*(float)32.0; accumWeights += 32;
    }
    float pixel281_prcntDiffR = fabs((pixel281.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel281_prcntDiffG = fabs((pixel281.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel281_prcntDiffB = fabs((pixel281.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel281_prcntDiffA = fabs((pixel281.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel281_prcntDiffR<16)&& (pixel281_prcntDiffG<16)&&(pixel281_prcntDiffB<16 )&&(pixel281_prcntDiffA<16)){
	    pixel_new += (pixel281)*(float)25.0; accumWeights += 25;
    }
    float pixel282_prcntDiffR = fabs((pixel282.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel282_prcntDiffG = fabs((pixel282.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel282_prcntDiffB = fabs((pixel282.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel282_prcntDiffA = fabs((pixel282.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel282_prcntDiffR<16)&& (pixel282_prcntDiffG<16)&&(pixel282_prcntDiffB<16 )&&(pixel282_prcntDiffA<16)){
	    pixel_new += (pixel282)*(float)19.0; accumWeights += 19;
    }
    float pixel283_prcntDiffR = fabs((pixel283.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel283_prcntDiffG = fabs((pixel283.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel283_prcntDiffB = fabs((pixel283.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel283_prcntDiffA = fabs((pixel283.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel283_prcntDiffR<16)&& (pixel283_prcntDiffG<16)&&(pixel283_prcntDiffB<16 )&&(pixel283_prcntDiffA<16)){
	    pixel_new += (pixel283)*(float)13.0; accumWeights += 13;
    }
    float pixel284_prcntDiffR = fabs((pixel284.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel284_prcntDiffG = fabs((pixel284.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel284_prcntDiffB = fabs((pixel284.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel284_prcntDiffA = fabs((pixel284.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel284_prcntDiffR<16)&& (pixel284_prcntDiffG<16)&&(pixel284_prcntDiffB<16 )&&(pixel284_prcntDiffA<16)){
	    pixel_new += (pixel284)*(float)9.0; accumWeights += 9;
    }
    float pixel285_prcntDiffR = fabs((pixel285.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel285_prcntDiffG = fabs((pixel285.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel285_prcntDiffB = fabs((pixel285.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel285_prcntDiffA = fabs((pixel285.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel285_prcntDiffR<16)&& (pixel285_prcntDiffG<16)&&(pixel285_prcntDiffB<16 )&&(pixel285_prcntDiffA<16)){
	    pixel_new += (pixel285)*(float)7.0; accumWeights += 7;
    }
    float pixel286_prcntDiffR = fabs((pixel286.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel286_prcntDiffG = fabs((pixel286.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel286_prcntDiffB = fabs((pixel286.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel286_prcntDiffA = fabs((pixel286.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel286_prcntDiffR<16)&& (pixel286_prcntDiffG<16)&&(pixel286_prcntDiffB<16 )&&(pixel286_prcntDiffA<16)){
	    pixel_new += (pixel286)*(float)10.0; accumWeights += 10;
    }
    float pixel287_prcntDiffR = fabs((pixel287.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel287_prcntDiffG = fabs((pixel287.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel287_prcntDiffB = fabs((pixel287.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel287_prcntDiffA = fabs((pixel287.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel287_prcntDiffR<16)&& (pixel287_prcntDiffG<16)&&(pixel287_prcntDiffB<16 )&&(pixel287_prcntDiffA<16)){
	    pixel_new += (pixel287)*(float)15.0; accumWeights += 15;
    }
    float pixel288_prcntDiffR = fabs((pixel288.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel288_prcntDiffG = fabs((pixel288.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel288_prcntDiffB = fabs((pixel288.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel288_prcntDiffA = fabs((pixel288.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel288_prcntDiffR<16)&& (pixel288_prcntDiffG<16)&&(pixel288_prcntDiffB<16 )&&(pixel288_prcntDiffA<16)){
	    pixel_new += (pixel288)*(float)20.0; accumWeights += 20;
    }
    float pixel289_prcntDiffR = fabs((pixel289.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel289_prcntDiffG = fabs((pixel289.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel289_prcntDiffB = fabs((pixel289.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel289_prcntDiffA = fabs((pixel289.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel289_prcntDiffR<16)&& (pixel289_prcntDiffG<16)&&(pixel289_prcntDiffB<16 )&&(pixel289_prcntDiffA<16)){
	    pixel_new += (pixel289)*(float)25.0; accumWeights += 25;
    }
    float pixel290_prcntDiffR = fabs((pixel290.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel290_prcntDiffG = fabs((pixel290.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel290_prcntDiffB = fabs((pixel290.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel290_prcntDiffA = fabs((pixel290.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel290_prcntDiffR<16)&& (pixel290_prcntDiffG<16)&&(pixel290_prcntDiffB<16 )&&(pixel290_prcntDiffA<16)){
	    pixel_new += (pixel290)*(float)31.0; accumWeights += 31;
    }
    float pixel291_prcntDiffR = fabs((pixel291.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel291_prcntDiffG = fabs((pixel291.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel291_prcntDiffB = fabs((pixel291.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel291_prcntDiffA = fabs((pixel291.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel291_prcntDiffR<16)&& (pixel291_prcntDiffG<16)&&(pixel291_prcntDiffB<16 )&&(pixel291_prcntDiffA<16)){
	    pixel_new += (pixel291)*(float)36.0; accumWeights += 36;
    }
    float pixel292_prcntDiffR = fabs((pixel292.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel292_prcntDiffG = fabs((pixel292.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel292_prcntDiffB = fabs((pixel292.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel292_prcntDiffA = fabs((pixel292.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel292_prcntDiffR<16)&& (pixel292_prcntDiffG<16)&&(pixel292_prcntDiffB<16 )&&(pixel292_prcntDiffA<16)){
	    pixel_new += (pixel292)*(float)41.0; accumWeights += 41;
    }
    float pixel293_prcntDiffR = fabs((pixel293.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel293_prcntDiffG = fabs((pixel293.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel293_prcntDiffB = fabs((pixel293.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel293_prcntDiffA = fabs((pixel293.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel293_prcntDiffR<16)&& (pixel293_prcntDiffG<16)&&(pixel293_prcntDiffB<16 )&&(pixel293_prcntDiffA<16)){
	    pixel_new += (pixel293)*(float)43.0; accumWeights += 43;
    }
    float pixel294_prcntDiffR = fabs((pixel294.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel294_prcntDiffG = fabs((pixel294.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel294_prcntDiffB = fabs((pixel294.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel294_prcntDiffA = fabs((pixel294.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel294_prcntDiffR<16)&& (pixel294_prcntDiffG<16)&&(pixel294_prcntDiffB<16 )&&(pixel294_prcntDiffA<16)){
	    pixel_new += (pixel294)*(float)44.0; accumWeights += 44;
    }
    float pixel295_prcntDiffR = fabs((pixel295.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel295_prcntDiffG = fabs((pixel295.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel295_prcntDiffB = fabs((pixel295.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel295_prcntDiffA = fabs((pixel295.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel295_prcntDiffR<16)&& (pixel295_prcntDiffG<16)&&(pixel295_prcntDiffB<16 )&&(pixel295_prcntDiffA<16)){
	    pixel_new += (pixel295)*(float)43.0; accumWeights += 43;
    }
    float pixel296_prcntDiffR = fabs((pixel296.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel296_prcntDiffG = fabs((pixel296.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel296_prcntDiffB = fabs((pixel296.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel296_prcntDiffA = fabs((pixel296.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel296_prcntDiffR<16)&& (pixel296_prcntDiffG<16)&&(pixel296_prcntDiffB<16 )&&(pixel296_prcntDiffA<16)){
	    pixel_new += (pixel296)*(float)41.0; accumWeights += 41;
    }
    float pixel297_prcntDiffR = fabs((pixel297.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel297_prcntDiffG = fabs((pixel297.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel297_prcntDiffB = fabs((pixel297.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel297_prcntDiffA = fabs((pixel297.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel297_prcntDiffR<16)&& (pixel297_prcntDiffG<16)&&(pixel297_prcntDiffB<16 )&&(pixel297_prcntDiffA<16)){
	    pixel_new += (pixel297)*(float)36.0; accumWeights += 36;
    }
    float pixel298_prcntDiffR = fabs((pixel298.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel298_prcntDiffG = fabs((pixel298.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel298_prcntDiffB = fabs((pixel298.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel298_prcntDiffA = fabs((pixel298.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel298_prcntDiffR<16)&& (pixel298_prcntDiffG<16)&&(pixel298_prcntDiffB<16 )&&(pixel298_prcntDiffA<16)){
	    pixel_new += (pixel298)*(float)31.0; accumWeights += 31;
    }
    float pixel299_prcntDiffR = fabs((pixel299.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel299_prcntDiffG = fabs((pixel299.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel299_prcntDiffB = fabs((pixel299.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel299_prcntDiffA = fabs((pixel299.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel299_prcntDiffR<16)&& (pixel299_prcntDiffG<16)&&(pixel299_prcntDiffB<16 )&&(pixel299_prcntDiffA<16)){
	    pixel_new += (pixel299)*(float)25.0; accumWeights += 25;
    }
    float pixel300_prcntDiffR = fabs((pixel300.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel300_prcntDiffG = fabs((pixel300.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel300_prcntDiffB = fabs((pixel300.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel300_prcntDiffA = fabs((pixel300.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel300_prcntDiffR<16)&& (pixel300_prcntDiffG<16)&&(pixel300_prcntDiffB<16 )&&(pixel300_prcntDiffA<16)){
	    pixel_new += (pixel300)*(float)20.0; accumWeights += 20;
    }
    float pixel301_prcntDiffR = fabs((pixel301.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel301_prcntDiffG = fabs((pixel301.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel301_prcntDiffB = fabs((pixel301.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel301_prcntDiffA = fabs((pixel301.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel301_prcntDiffR<16)&& (pixel301_prcntDiffG<16)&&(pixel301_prcntDiffB<16 )&&(pixel301_prcntDiffA<16)){
	    pixel_new += (pixel301)*(float)15.0; accumWeights += 15;
    }
    float pixel302_prcntDiffR = fabs((pixel302.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel302_prcntDiffG = fabs((pixel302.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel302_prcntDiffB = fabs((pixel302.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel302_prcntDiffA = fabs((pixel302.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel302_prcntDiffR<16)&& (pixel302_prcntDiffG<16)&&(pixel302_prcntDiffB<16 )&&(pixel302_prcntDiffA<16)){
	    pixel_new += (pixel302)*(float)10.0; accumWeights += 10;
    }
    float pixel303_prcntDiffR = fabs((pixel303.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel303_prcntDiffG = fabs((pixel303.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel303_prcntDiffB = fabs((pixel303.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel303_prcntDiffA = fabs((pixel303.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel303_prcntDiffR<16)&& (pixel303_prcntDiffG<16)&&(pixel303_prcntDiffB<16 )&&(pixel303_prcntDiffA<16)){
	    pixel_new += (pixel303)*(float)7.0; accumWeights += 7;
    }
    float pixel304_prcntDiffR = fabs((pixel304.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel304_prcntDiffG = fabs((pixel304.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel304_prcntDiffB = fabs((pixel304.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel304_prcntDiffA = fabs((pixel304.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel304_prcntDiffR<16)&& (pixel304_prcntDiffG<16)&&(pixel304_prcntDiffB<16 )&&(pixel304_prcntDiffA<16)){
	    pixel_new += (pixel304)*(float)5.0; accumWeights += 5;
    }
    float pixel305_prcntDiffR = fabs((pixel305.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel305_prcntDiffG = fabs((pixel305.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel305_prcntDiffB = fabs((pixel305.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel305_prcntDiffA = fabs((pixel305.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel305_prcntDiffR<16)&& (pixel305_prcntDiffG<16)&&(pixel305_prcntDiffB<16 )&&(pixel305_prcntDiffA<16)){
	    pixel_new += (pixel305)*(float)8.0; accumWeights += 8;
    }
    float pixel306_prcntDiffR = fabs((pixel306.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel306_prcntDiffG = fabs((pixel306.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel306_prcntDiffB = fabs((pixel306.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel306_prcntDiffA = fabs((pixel306.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel306_prcntDiffR<16)&& (pixel306_prcntDiffG<16)&&(pixel306_prcntDiffB<16 )&&(pixel306_prcntDiffA<16)){
	    pixel_new += (pixel306)*(float)11.0; accumWeights += 11;
    }
    float pixel307_prcntDiffR = fabs((pixel307.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel307_prcntDiffG = fabs((pixel307.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel307_prcntDiffB = fabs((pixel307.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel307_prcntDiffA = fabs((pixel307.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel307_prcntDiffR<16)&& (pixel307_prcntDiffG<16)&&(pixel307_prcntDiffB<16 )&&(pixel307_prcntDiffA<16)){
	    pixel_new += (pixel307)*(float)15.0; accumWeights += 15;
    }
    float pixel308_prcntDiffR = fabs((pixel308.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel308_prcntDiffG = fabs((pixel308.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel308_prcntDiffB = fabs((pixel308.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel308_prcntDiffA = fabs((pixel308.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel308_prcntDiffR<16)&& (pixel308_prcntDiffG<16)&&(pixel308_prcntDiffB<16 )&&(pixel308_prcntDiffA<16)){
	    pixel_new += (pixel308)*(float)19.0; accumWeights += 19;
    }
    float pixel309_prcntDiffR = fabs((pixel309.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel309_prcntDiffG = fabs((pixel309.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel309_prcntDiffB = fabs((pixel309.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel309_prcntDiffA = fabs((pixel309.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel309_prcntDiffR<16)&& (pixel309_prcntDiffG<16)&&(pixel309_prcntDiffB<16 )&&(pixel309_prcntDiffA<16)){
	    pixel_new += (pixel309)*(float)23.0; accumWeights += 23;
    }
    float pixel310_prcntDiffR = fabs((pixel310.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel310_prcntDiffG = fabs((pixel310.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel310_prcntDiffB = fabs((pixel310.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel310_prcntDiffA = fabs((pixel310.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel310_prcntDiffR<16)&& (pixel310_prcntDiffG<16)&&(pixel310_prcntDiffB<16 )&&(pixel310_prcntDiffA<16)){
	    pixel_new += (pixel310)*(float)27.0; accumWeights += 27;
    }
    float pixel311_prcntDiffR = fabs((pixel311.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel311_prcntDiffG = fabs((pixel311.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel311_prcntDiffB = fabs((pixel311.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel311_prcntDiffA = fabs((pixel311.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel311_prcntDiffR<16)&& (pixel311_prcntDiffG<16)&&(pixel311_prcntDiffB<16 )&&(pixel311_prcntDiffA<16)){
	    pixel_new += (pixel311)*(float)30.0; accumWeights += 30;
    }
    float pixel312_prcntDiffR = fabs((pixel312.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel312_prcntDiffG = fabs((pixel312.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel312_prcntDiffB = fabs((pixel312.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel312_prcntDiffA = fabs((pixel312.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel312_prcntDiffR<16)&& (pixel312_prcntDiffG<16)&&(pixel312_prcntDiffB<16 )&&(pixel312_prcntDiffA<16)){
	    pixel_new += (pixel312)*(float)32.0; accumWeights += 32;
    }
    float pixel313_prcntDiffR = fabs((pixel313.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel313_prcntDiffG = fabs((pixel313.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel313_prcntDiffB = fabs((pixel313.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel313_prcntDiffA = fabs((pixel313.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel313_prcntDiffR<16)&& (pixel313_prcntDiffG<16)&&(pixel313_prcntDiffB<16 )&&(pixel313_prcntDiffA<16)){
	    pixel_new += (pixel313)*(float)33.0; accumWeights += 33;
    }
    float pixel314_prcntDiffR = fabs((pixel314.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel314_prcntDiffG = fabs((pixel314.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel314_prcntDiffB = fabs((pixel314.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel314_prcntDiffA = fabs((pixel314.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel314_prcntDiffR<16)&& (pixel314_prcntDiffG<16)&&(pixel314_prcntDiffB<16 )&&(pixel314_prcntDiffA<16)){
	    pixel_new += (pixel314)*(float)32.0; accumWeights += 32;
    }
    float pixel315_prcntDiffR = fabs((pixel315.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel315_prcntDiffG = fabs((pixel315.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel315_prcntDiffB = fabs((pixel315.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel315_prcntDiffA = fabs((pixel315.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel315_prcntDiffR<16)&& (pixel315_prcntDiffG<16)&&(pixel315_prcntDiffB<16 )&&(pixel315_prcntDiffA<16)){
	    pixel_new += (pixel315)*(float)30.0; accumWeights += 30;
    }
    float pixel316_prcntDiffR = fabs((pixel316.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel316_prcntDiffG = fabs((pixel316.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel316_prcntDiffB = fabs((pixel316.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel316_prcntDiffA = fabs((pixel316.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel316_prcntDiffR<16)&& (pixel316_prcntDiffG<16)&&(pixel316_prcntDiffB<16 )&&(pixel316_prcntDiffA<16)){
	    pixel_new += (pixel316)*(float)27.0; accumWeights += 27;
    }
    float pixel317_prcntDiffR = fabs((pixel317.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel317_prcntDiffG = fabs((pixel317.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel317_prcntDiffB = fabs((pixel317.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel317_prcntDiffA = fabs((pixel317.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel317_prcntDiffR<16)&& (pixel317_prcntDiffG<16)&&(pixel317_prcntDiffB<16 )&&(pixel317_prcntDiffA<16)){
	    pixel_new += (pixel317)*(float)23.0; accumWeights += 23;
    }
    float pixel318_prcntDiffR = fabs((pixel318.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel318_prcntDiffG = fabs((pixel318.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel318_prcntDiffB = fabs((pixel318.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel318_prcntDiffA = fabs((pixel318.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel318_prcntDiffR<16)&& (pixel318_prcntDiffG<16)&&(pixel318_prcntDiffB<16 )&&(pixel318_prcntDiffA<16)){
	    pixel_new += (pixel318)*(float)19.0; accumWeights += 19;
    }
    float pixel319_prcntDiffR = fabs((pixel319.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel319_prcntDiffG = fabs((pixel319.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel319_prcntDiffB = fabs((pixel319.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel319_prcntDiffA = fabs((pixel319.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel319_prcntDiffR<16)&& (pixel319_prcntDiffG<16)&&(pixel319_prcntDiffB<16 )&&(pixel319_prcntDiffA<16)){
	    pixel_new += (pixel319)*(float)15.0; accumWeights += 15;
    }
    float pixel320_prcntDiffR = fabs((pixel320.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel320_prcntDiffG = fabs((pixel320.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel320_prcntDiffB = fabs((pixel320.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel320_prcntDiffA = fabs((pixel320.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel320_prcntDiffR<16)&& (pixel320_prcntDiffG<16)&&(pixel320_prcntDiffB<16 )&&(pixel320_prcntDiffA<16)){
	    pixel_new += (pixel320)*(float)11.0; accumWeights += 11;
    }
    float pixel321_prcntDiffR = fabs((pixel321.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel321_prcntDiffG = fabs((pixel321.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel321_prcntDiffB = fabs((pixel321.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel321_prcntDiffA = fabs((pixel321.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel321_prcntDiffR<16)&& (pixel321_prcntDiffG<16)&&(pixel321_prcntDiffB<16 )&&(pixel321_prcntDiffA<16)){
	    pixel_new += (pixel321)*(float)8.0; accumWeights += 8;
    }
    float pixel322_prcntDiffR = fabs((pixel322.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel322_prcntDiffG = fabs((pixel322.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel322_prcntDiffB = fabs((pixel322.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel322_prcntDiffA = fabs((pixel322.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel322_prcntDiffR<16)&& (pixel322_prcntDiffG<16)&&(pixel322_prcntDiffB<16 )&&(pixel322_prcntDiffA<16)){
	    pixel_new += (pixel322)*(float)5.0; accumWeights += 5;
    }
    float pixel323_prcntDiffR = fabs((pixel323.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel323_prcntDiffG = fabs((pixel323.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel323_prcntDiffB = fabs((pixel323.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel323_prcntDiffA = fabs((pixel323.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel323_prcntDiffR<16)&& (pixel323_prcntDiffG<16)&&(pixel323_prcntDiffB<16 )&&(pixel323_prcntDiffA<16)){
	    pixel_new += (pixel323)*(float)3.0; accumWeights += 3;
    }
    float pixel324_prcntDiffR = fabs((pixel324.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel324_prcntDiffG = fabs((pixel324.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel324_prcntDiffB = fabs((pixel324.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel324_prcntDiffA = fabs((pixel324.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel324_prcntDiffR<16)&& (pixel324_prcntDiffG<16)&&(pixel324_prcntDiffB<16 )&&(pixel324_prcntDiffA<16)){
	    pixel_new += (pixel324)*(float)5.0; accumWeights += 5;
    }
    float pixel325_prcntDiffR = fabs((pixel325.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel325_prcntDiffG = fabs((pixel325.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel325_prcntDiffB = fabs((pixel325.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel325_prcntDiffA = fabs((pixel325.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel325_prcntDiffR<16)&& (pixel325_prcntDiffG<16)&&(pixel325_prcntDiffB<16 )&&(pixel325_prcntDiffA<16)){
	    pixel_new += (pixel325)*(float)8.0; accumWeights += 8;
    }
    float pixel326_prcntDiffR = fabs((pixel326.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel326_prcntDiffG = fabs((pixel326.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel326_prcntDiffB = fabs((pixel326.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel326_prcntDiffA = fabs((pixel326.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel326_prcntDiffR<16)&& (pixel326_prcntDiffG<16)&&(pixel326_prcntDiffB<16 )&&(pixel326_prcntDiffA<16)){
	    pixel_new += (pixel326)*(float)10.0; accumWeights += 10;
    }
    float pixel327_prcntDiffR = fabs((pixel327.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel327_prcntDiffG = fabs((pixel327.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel327_prcntDiffB = fabs((pixel327.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel327_prcntDiffA = fabs((pixel327.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel327_prcntDiffR<16)&& (pixel327_prcntDiffG<16)&&(pixel327_prcntDiffB<16 )&&(pixel327_prcntDiffA<16)){
	    pixel_new += (pixel327)*(float)13.0; accumWeights += 13;
    }
    float pixel328_prcntDiffR = fabs((pixel328.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel328_prcntDiffG = fabs((pixel328.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel328_prcntDiffB = fabs((pixel328.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel328_prcntDiffA = fabs((pixel328.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel328_prcntDiffR<16)&& (pixel328_prcntDiffG<16)&&(pixel328_prcntDiffB<16 )&&(pixel328_prcntDiffA<16)){
	    pixel_new += (pixel328)*(float)16.0; accumWeights += 16;
    }
    float pixel329_prcntDiffR = fabs((pixel329.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel329_prcntDiffG = fabs((pixel329.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel329_prcntDiffB = fabs((pixel329.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel329_prcntDiffA = fabs((pixel329.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel329_prcntDiffR<16)&& (pixel329_prcntDiffG<16)&&(pixel329_prcntDiffB<16 )&&(pixel329_prcntDiffA<16)){
	    pixel_new += (pixel329)*(float)19.0; accumWeights += 19;
    }
    float pixel330_prcntDiffR = fabs((pixel330.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel330_prcntDiffG = fabs((pixel330.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel330_prcntDiffB = fabs((pixel330.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel330_prcntDiffA = fabs((pixel330.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel330_prcntDiffR<16)&& (pixel330_prcntDiffG<16)&&(pixel330_prcntDiffB<16 )&&(pixel330_prcntDiffA<16)){
	    pixel_new += (pixel330)*(float)22.0; accumWeights += 22;
    }
    float pixel331_prcntDiffR = fabs((pixel331.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel331_prcntDiffG = fabs((pixel331.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel331_prcntDiffB = fabs((pixel331.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel331_prcntDiffA = fabs((pixel331.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel331_prcntDiffR<16)&& (pixel331_prcntDiffG<16)&&(pixel331_prcntDiffB<16 )&&(pixel331_prcntDiffA<16)){
	    pixel_new += (pixel331)*(float)23.0; accumWeights += 23;
    }
    float pixel332_prcntDiffR = fabs((pixel332.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel332_prcntDiffG = fabs((pixel332.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel332_prcntDiffB = fabs((pixel332.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel332_prcntDiffA = fabs((pixel332.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel332_prcntDiffR<16)&& (pixel332_prcntDiffG<16)&&(pixel332_prcntDiffB<16 )&&(pixel332_prcntDiffA<16)){
	    pixel_new += (pixel332)*(float)24.0; accumWeights += 24;
    }
    float pixel333_prcntDiffR = fabs((pixel333.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel333_prcntDiffG = fabs((pixel333.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel333_prcntDiffB = fabs((pixel333.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel333_prcntDiffA = fabs((pixel333.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel333_prcntDiffR<16)&& (pixel333_prcntDiffG<16)&&(pixel333_prcntDiffB<16 )&&(pixel333_prcntDiffA<16)){
	    pixel_new += (pixel333)*(float)23.0; accumWeights += 23;
    }
    float pixel334_prcntDiffR = fabs((pixel334.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel334_prcntDiffG = fabs((pixel334.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel334_prcntDiffB = fabs((pixel334.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel334_prcntDiffA = fabs((pixel334.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel334_prcntDiffR<16)&& (pixel334_prcntDiffG<16)&&(pixel334_prcntDiffB<16 )&&(pixel334_prcntDiffA<16)){
	    pixel_new += (pixel334)*(float)22.0; accumWeights += 22;
    }
    float pixel335_prcntDiffR = fabs((pixel335.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel335_prcntDiffG = fabs((pixel335.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel335_prcntDiffB = fabs((pixel335.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel335_prcntDiffA = fabs((pixel335.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel335_prcntDiffR<16)&& (pixel335_prcntDiffG<16)&&(pixel335_prcntDiffB<16 )&&(pixel335_prcntDiffA<16)){
	    pixel_new += (pixel335)*(float)19.0; accumWeights += 19;
    }
    float pixel336_prcntDiffR = fabs((pixel336.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel336_prcntDiffG = fabs((pixel336.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel336_prcntDiffB = fabs((pixel336.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel336_prcntDiffA = fabs((pixel336.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel336_prcntDiffR<16)&& (pixel336_prcntDiffG<16)&&(pixel336_prcntDiffB<16 )&&(pixel336_prcntDiffA<16)){
	    pixel_new += (pixel336)*(float)16.0; accumWeights += 16;
    }
    float pixel337_prcntDiffR = fabs((pixel337.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel337_prcntDiffG = fabs((pixel337.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel337_prcntDiffB = fabs((pixel337.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel337_prcntDiffA = fabs((pixel337.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel337_prcntDiffR<16)&& (pixel337_prcntDiffG<16)&&(pixel337_prcntDiffB<16 )&&(pixel337_prcntDiffA<16)){
	    pixel_new += (pixel337)*(float)13.0; accumWeights += 13;
    }
    float pixel338_prcntDiffR = fabs((pixel338.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel338_prcntDiffG = fabs((pixel338.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel338_prcntDiffB = fabs((pixel338.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel338_prcntDiffA = fabs((pixel338.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel338_prcntDiffR<16)&& (pixel338_prcntDiffG<16)&&(pixel338_prcntDiffB<16 )&&(pixel338_prcntDiffA<16)){
	    pixel_new += (pixel338)*(float)10.0; accumWeights += 10;
    }
    float pixel339_prcntDiffR = fabs((pixel339.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel339_prcntDiffG = fabs((pixel339.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel339_prcntDiffB = fabs((pixel339.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel339_prcntDiffA = fabs((pixel339.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel339_prcntDiffR<16)&& (pixel339_prcntDiffG<16)&&(pixel339_prcntDiffB<16 )&&(pixel339_prcntDiffA<16)){
	    pixel_new += (pixel339)*(float)8.0; accumWeights += 8;
    }
    float pixel340_prcntDiffR = fabs((pixel340.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel340_prcntDiffG = fabs((pixel340.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel340_prcntDiffB = fabs((pixel340.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel340_prcntDiffA = fabs((pixel340.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel340_prcntDiffR<16)&& (pixel340_prcntDiffG<16)&&(pixel340_prcntDiffB<16 )&&(pixel340_prcntDiffA<16)){
	    pixel_new += (pixel340)*(float)5.0; accumWeights += 5;
    }
    float pixel341_prcntDiffR = fabs((pixel341.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel341_prcntDiffG = fabs((pixel341.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel341_prcntDiffB = fabs((pixel341.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel341_prcntDiffA = fabs((pixel341.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel341_prcntDiffR<16)&& (pixel341_prcntDiffG<16)&&(pixel341_prcntDiffB<16 )&&(pixel341_prcntDiffA<16)){
	    pixel_new += (pixel341)*(float)3.0; accumWeights += 3;
    }
    float pixel342_prcntDiffR = fabs((pixel342.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel342_prcntDiffG = fabs((pixel342.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel342_prcntDiffB = fabs((pixel342.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel342_prcntDiffA = fabs((pixel342.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel342_prcntDiffR<16)&& (pixel342_prcntDiffG<16)&&(pixel342_prcntDiffB<16 )&&(pixel342_prcntDiffA<16)){
	    pixel_new += (pixel342)*(float)2.0; accumWeights += 2;
    }
    float pixel343_prcntDiffR = fabs((pixel343.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel343_prcntDiffG = fabs((pixel343.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel343_prcntDiffB = fabs((pixel343.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel343_prcntDiffA = fabs((pixel343.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel343_prcntDiffR<16)&& (pixel343_prcntDiffG<16)&&(pixel343_prcntDiffB<16 )&&(pixel343_prcntDiffA<16)){
	    pixel_new += (pixel343)*(float)3.0; accumWeights += 3;
    }
    float pixel344_prcntDiffR = fabs((pixel344.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel344_prcntDiffG = fabs((pixel344.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel344_prcntDiffB = fabs((pixel344.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel344_prcntDiffA = fabs((pixel344.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel344_prcntDiffR<16)&& (pixel344_prcntDiffG<16)&&(pixel344_prcntDiffB<16 )&&(pixel344_prcntDiffA<16)){
	    pixel_new += (pixel344)*(float)5.0; accumWeights += 5;
    }
    float pixel345_prcntDiffR = fabs((pixel345.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel345_prcntDiffG = fabs((pixel345.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel345_prcntDiffB = fabs((pixel345.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel345_prcntDiffA = fabs((pixel345.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel345_prcntDiffR<16)&& (pixel345_prcntDiffG<16)&&(pixel345_prcntDiffB<16 )&&(pixel345_prcntDiffA<16)){
	    pixel_new += (pixel345)*(float)7.0; accumWeights += 7;
    }
    float pixel346_prcntDiffR = fabs((pixel346.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel346_prcntDiffG = fabs((pixel346.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel346_prcntDiffB = fabs((pixel346.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel346_prcntDiffA = fabs((pixel346.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel346_prcntDiffR<16)&& (pixel346_prcntDiffG<16)&&(pixel346_prcntDiffB<16 )&&(pixel346_prcntDiffA<16)){
	    pixel_new += (pixel346)*(float)9.0; accumWeights += 9;
    }
    float pixel347_prcntDiffR = fabs((pixel347.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel347_prcntDiffG = fabs((pixel347.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel347_prcntDiffB = fabs((pixel347.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel347_prcntDiffA = fabs((pixel347.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel347_prcntDiffR<16)&& (pixel347_prcntDiffG<16)&&(pixel347_prcntDiffB<16 )&&(pixel347_prcntDiffA<16)){
	    pixel_new += (pixel347)*(float)11.0; accumWeights += 11;
    }
    float pixel348_prcntDiffR = fabs((pixel348.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel348_prcntDiffG = fabs((pixel348.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel348_prcntDiffB = fabs((pixel348.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel348_prcntDiffA = fabs((pixel348.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel348_prcntDiffR<16)&& (pixel348_prcntDiffG<16)&&(pixel348_prcntDiffB<16 )&&(pixel348_prcntDiffA<16)){
	    pixel_new += (pixel348)*(float)13.0; accumWeights += 13;
    }
    float pixel349_prcntDiffR = fabs((pixel349.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel349_prcntDiffG = fabs((pixel349.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel349_prcntDiffB = fabs((pixel349.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel349_prcntDiffA = fabs((pixel349.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel349_prcntDiffR<16)&& (pixel349_prcntDiffG<16)&&(pixel349_prcntDiffB<16 )&&(pixel349_prcntDiffA<16)){
	    pixel_new += (pixel349)*(float)15.0; accumWeights += 15;
    }
    float pixel350_prcntDiffR = fabs((pixel350.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel350_prcntDiffG = fabs((pixel350.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel350_prcntDiffB = fabs((pixel350.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel350_prcntDiffA = fabs((pixel350.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel350_prcntDiffR<16)&& (pixel350_prcntDiffG<16)&&(pixel350_prcntDiffB<16 )&&(pixel350_prcntDiffA<16)){
	    pixel_new += (pixel350)*(float)16.0; accumWeights += 16;
    }
    float pixel351_prcntDiffR = fabs((pixel351.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel351_prcntDiffG = fabs((pixel351.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel351_prcntDiffB = fabs((pixel351.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel351_prcntDiffA = fabs((pixel351.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel351_prcntDiffR<16)&& (pixel351_prcntDiffG<16)&&(pixel351_prcntDiffB<16 )&&(pixel351_prcntDiffA<16)){
	    pixel_new += (pixel351)*(float)16.0; accumWeights += 16;
    }
    float pixel352_prcntDiffR = fabs((pixel352.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel352_prcntDiffG = fabs((pixel352.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel352_prcntDiffB = fabs((pixel352.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel352_prcntDiffA = fabs((pixel352.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel352_prcntDiffR<16)&& (pixel352_prcntDiffG<16)&&(pixel352_prcntDiffB<16 )&&(pixel352_prcntDiffA<16)){
	    pixel_new += (pixel352)*(float)16.0; accumWeights += 16;
    }
    float pixel353_prcntDiffR = fabs((pixel353.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel353_prcntDiffG = fabs((pixel353.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel353_prcntDiffB = fabs((pixel353.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel353_prcntDiffA = fabs((pixel353.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel353_prcntDiffR<16)&& (pixel353_prcntDiffG<16)&&(pixel353_prcntDiffB<16 )&&(pixel353_prcntDiffA<16)){
	    pixel_new += (pixel353)*(float)15.0; accumWeights += 15;
    }
    float pixel354_prcntDiffR = fabs((pixel354.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel354_prcntDiffG = fabs((pixel354.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel354_prcntDiffB = fabs((pixel354.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel354_prcntDiffA = fabs((pixel354.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel354_prcntDiffR<16)&& (pixel354_prcntDiffG<16)&&(pixel354_prcntDiffB<16 )&&(pixel354_prcntDiffA<16)){
	    pixel_new += (pixel354)*(float)13.0; accumWeights += 13;
    }
    float pixel355_prcntDiffR = fabs((pixel355.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel355_prcntDiffG = fabs((pixel355.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel355_prcntDiffB = fabs((pixel355.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel355_prcntDiffA = fabs((pixel355.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel355_prcntDiffR<16)&& (pixel355_prcntDiffG<16)&&(pixel355_prcntDiffB<16 )&&(pixel355_prcntDiffA<16)){
	    pixel_new += (pixel355)*(float)11.0; accumWeights += 11;
    }
    float pixel356_prcntDiffR = fabs((pixel356.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel356_prcntDiffG = fabs((pixel356.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel356_prcntDiffB = fabs((pixel356.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel356_prcntDiffA = fabs((pixel356.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel356_prcntDiffR<16)&& (pixel356_prcntDiffG<16)&&(pixel356_prcntDiffB<16 )&&(pixel356_prcntDiffA<16)){
	    pixel_new += (pixel356)*(float)9.0; accumWeights += 9;
    }
    float pixel357_prcntDiffR = fabs((pixel357.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel357_prcntDiffG = fabs((pixel357.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel357_prcntDiffB = fabs((pixel357.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel357_prcntDiffA = fabs((pixel357.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel357_prcntDiffR<16)&& (pixel357_prcntDiffG<16)&&(pixel357_prcntDiffB<16 )&&(pixel357_prcntDiffA<16)){
	    pixel_new += (pixel357)*(float)7.0; accumWeights += 7;
    }
    float pixel358_prcntDiffR = fabs((pixel358.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel358_prcntDiffG = fabs((pixel358.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel358_prcntDiffB = fabs((pixel358.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel358_prcntDiffA = fabs((pixel358.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel358_prcntDiffR<16)&& (pixel358_prcntDiffG<16)&&(pixel358_prcntDiffB<16 )&&(pixel358_prcntDiffA<16)){
	    pixel_new += (pixel358)*(float)5.0; accumWeights += 5;
    }
    float pixel359_prcntDiffR = fabs((pixel359.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel359_prcntDiffG = fabs((pixel359.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel359_prcntDiffB = fabs((pixel359.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel359_prcntDiffA = fabs((pixel359.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel359_prcntDiffR<16)&& (pixel359_prcntDiffG<16)&&(pixel359_prcntDiffB<16 )&&(pixel359_prcntDiffA<16)){
	    pixel_new += (pixel359)*(float)3.0; accumWeights += 3;
    }
    float pixel360_prcntDiffR = fabs((pixel360.x-(float)pixel_orig.x)/pixel_orig.x)*100;
    float pixel360_prcntDiffG = fabs((pixel360.y-(float)pixel_orig.y)/pixel_orig.y)*100;
    float pixel360_prcntDiffB = fabs((pixel360.z-(float)pixel_orig.z)/pixel_orig.z)*100;
    float pixel360_prcntDiffA = fabs((pixel360.w-(float)pixel_orig.w)/pixel_orig.w)*100;
   if ((pixel360_prcntDiffR<16)&& (pixel360_prcntDiffG<16)&&(pixel360_prcntDiffB<16 )&&(pixel360_prcntDiffA<16)){
	    pixel_new += (pixel360)*(float)2.0; accumWeights += 2;
    }
    pixel_new = (accumWeights==0)?0:pixel_new/accumWeights; pixel_new.w = 255;
    pixel_new.w = 255;
    write_imagef(outputImage,(int2)(i,j), pixel_new);
};
//Primary input is output of Pass2
__kernel void specialKernel3(read_only image2d_t inputImage, write_only image2d_t outputImage)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
    int i = get_global_id(0);
    int j = get_global_id(1);
    //if (i>=src[0]) return;
    //if (j>=src[1]) return;
    float accumWeights = 0;
    float4 pixel_orig=read_imagef(inputImage,sampler,(int2)(i,j));
    //long4 pixel_orig_long=convert_long4(pixel_orig);
    float4 pixel_new = (float4)pixel_orig*(float4)(0.4,0.4,0.4,1.0);
    pixel_new.w = 255;
    write_imagef(outputImage,(int2)(i,j), pixel_new);
};
//Secondary input is output of Pass2
//Primary input is output of Pass1
__kernel void specialKernel4(read_only image2d_t inputImage, write_only image2d_t outputImage, read_only image2d_t inputImage2)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
    int i = get_global_id(0);
    int j = get_global_id(1);
    //if (i>=src[0]) return;
    //if (j>=src[1]) return;
    float accumWeights = 0;
    float4 pixel_orig=read_imagef(inputImage,sampler,(int2)(i,j));
    //long4 pixel_orig_long=convert_long4(pixel_orig);
    float4 pixel_new = (float4)(0, 0, 0, 255);
    float4 pixel0 = read_imagef(inputImage,sampler,(int2)(i-0,j+0));
    pixel_new += (pixel0)*(float)1.0; accumWeights += 1;
    float4 pixel_2ndary=read_imagef(inputImage2,sampler,(int2)(i,j));
    pixel_new = pixel_new - pixel_2ndary;
    pixel_new.w = 255;
    write_imagef(outputImage,(int2)(i,j), pixel_new);
};
//Secondary input is output of Pass4
//Primary input is output of Pass3
__kernel void specialKernel5(read_only image2d_t inputImage, write_only image2d_t outputImage, read_only image2d_t inputImage2)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
    int i = get_global_id(0);
    int j = get_global_id(1);
    //if (i>=src[0]) return;
    //if (j>=src[1]) return;
    float accumWeights = 0;
    float4 pixel_orig=read_imagef(inputImage,sampler,(int2)(i,j));
    //long4 pixel_orig_long=convert_long4(pixel_orig);
    float4 pixel_new = (float4)(0, 0, 0, 255);
    float4 pixel0 = read_imagef(inputImage,sampler,(int2)(i-0,j+0));
    pixel_new += (pixel0)*(float)1.0; accumWeights += 1;
    float4 pixel_2ndary=read_imagef(inputImage2,sampler,(int2)(i,j));
    pixel_new += pixel_2ndary;
    pixel_new.w = 255;
    write_imagef(outputImage,(int2)(i,j), pixel_new);
};
//Secondary input is original surface
//Primary input is output of Pass5
__kernel void specialKernel6(read_only image2d_t inputImage, write_only image2d_t outputImage, read_only image2d_t inputImage2)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
    int i = get_global_id(0);
    int j = get_global_id(1);
    //if (i>=src[0]) return;
    //if (j>=src[1]) return;
    float accumWeights = 0;
    float4 pixel_orig=read_imagef(inputImage,sampler,(int2)(i,j));
    //long4 pixel_orig_long=convert_long4(pixel_orig);
    float4 pixel_new = (float4)(exp10(pixel_orig.x),exp10(pixel_orig.y),exp10(pixel_orig.z),255);
    float4 pixel_2ndary=read_imagef(inputImage2,sampler,(int2)(i,j));
    pixel_new = pixel_new * pixel_2ndary;
    pixel_new.w = 255;
    write_imagef(outputImage,(int2)(i,j), pixel_new);
};
//Secondary input is output of Pass0
//Primary input is output of Pass6
__kernel void specialKernel7(read_only image2d_t inputImage, write_only image2d_t outputImage, read_only image2d_t inputImage2)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
    int i = get_global_id(0);
    int j = get_global_id(1);
    //if (i>=src[0]) return;
    //if (j>=src[1]) return;
    float accumWeights = 0;
    float4 pixel_orig=read_imagef(inputImage,sampler,(int2)(i,j));
    //long4 pixel_orig_long=convert_long4(pixel_orig);
    float4 pixel_new = (float4)(0, 0, 0, 255);
    float4 pixel0 = read_imagef(inputImage,sampler,(int2)(i-0,j+0));
    pixel_new += (pixel0)*(float)1.0; accumWeights += 1;
    float4 pixel_2ndary=read_imagef(inputImage2,sampler,(int2)(i,j));
    pixel_new = pixel_new / pixel_2ndary;
    pixel_new.w = 255;
    write_imagef(outputImage,(int2)(i,j), pixel_new);
};
//Primary input is output of Pass7
__kernel void specialKernel8(read_only image2d_t inputImage, write_only image2d_t outputImage)
{
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
    int i = get_global_id(0);
    int j = get_global_id(1);
    //if (i>=src[0]) return;
    //if (j>=src[1]) return;
    float accumWeights = 0;
    float4 pixel_orig=read_imagef(inputImage,sampler,(int2)(i,j));
    //long4 pixel_orig_long=convert_long4(pixel_orig);
    float4 pixel_new = (float4)pixel_orig*(float4)(12,12,12,1.0);
    pixel_new = fabs(pixel_new);
    if (pixel_new.x>255) pixel_new.x = 255;
    if (pixel_new.y>255) pixel_new.y = 255;
    if (pixel_new.z>255) pixel_new.z = 255;
    pixel_new.w = 255;
    write_imagef(outputImage,(int2)(i,j), pixel_new);
};


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
