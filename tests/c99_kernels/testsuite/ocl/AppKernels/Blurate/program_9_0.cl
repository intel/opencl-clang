//Secondary input is original surface
//Primary input is original surface
__kernel void specialKernel0(read_only image2d_t inputImage, write_only image2d_t outputImage, read_only image2d_t inputImage2)
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
    float4 pixel0 = read_imagef(inputImage,sampler,(int2)(i-9,j-5));
    float4 pixel1 = read_imagef(inputImage,sampler,(int2)(i-9,j-4));
    float4 pixel2 = read_imagef(inputImage,sampler,(int2)(i-9,j-3));
    float4 pixel3 = read_imagef(inputImage,sampler,(int2)(i-9,j-2));
    float4 pixel4 = read_imagef(inputImage,sampler,(int2)(i-9,j-1));
    float4 pixel5 = read_imagef(inputImage,sampler,(int2)(i-9,j+0));
    float4 pixel6 = read_imagef(inputImage,sampler,(int2)(i-9,j+1));
    float4 pixel7 = read_imagef(inputImage,sampler,(int2)(i-9,j+2));
    float4 pixel8 = read_imagef(inputImage,sampler,(int2)(i-9,j+3));
    float4 pixel9 = read_imagef(inputImage,sampler,(int2)(i-9,j+4));
    float4 pixel10 = read_imagef(inputImage,sampler,(int2)(i-9,j+5));
    float4 pixel11 = read_imagef(inputImage,sampler,(int2)(i-8,j-7));
    float4 pixel12 = read_imagef(inputImage,sampler,(int2)(i-8,j-6));
    float4 pixel13 = read_imagef(inputImage,sampler,(int2)(i-8,j-5));
    float4 pixel14 = read_imagef(inputImage,sampler,(int2)(i-8,j-4));
    float4 pixel15 = read_imagef(inputImage,sampler,(int2)(i-8,j-3));
    float4 pixel16 = read_imagef(inputImage,sampler,(int2)(i-8,j-2));
    float4 pixel17 = read_imagef(inputImage,sampler,(int2)(i-8,j-1));
    float4 pixel18 = read_imagef(inputImage,sampler,(int2)(i-8,j+0));
    float4 pixel19 = read_imagef(inputImage,sampler,(int2)(i-8,j+1));
    float4 pixel20 = read_imagef(inputImage,sampler,(int2)(i-8,j+2));
    float4 pixel21 = read_imagef(inputImage,sampler,(int2)(i-8,j+3));
    float4 pixel22 = read_imagef(inputImage,sampler,(int2)(i-8,j+4));
    float4 pixel23 = read_imagef(inputImage,sampler,(int2)(i-8,j+5));
    float4 pixel24 = read_imagef(inputImage,sampler,(int2)(i-8,j+6));
    float4 pixel25 = read_imagef(inputImage,sampler,(int2)(i-8,j+7));
    float4 pixel26 = read_imagef(inputImage,sampler,(int2)(i-7,j-8));
    float4 pixel27 = read_imagef(inputImage,sampler,(int2)(i-7,j-7));
    float4 pixel28 = read_imagef(inputImage,sampler,(int2)(i-7,j-6));
    float4 pixel29 = read_imagef(inputImage,sampler,(int2)(i-7,j-5));
    float4 pixel30 = read_imagef(inputImage,sampler,(int2)(i-7,j-4));
    float4 pixel31 = read_imagef(inputImage,sampler,(int2)(i-7,j-3));
    float4 pixel32 = read_imagef(inputImage,sampler,(int2)(i-7,j-2));
    float4 pixel33 = read_imagef(inputImage,sampler,(int2)(i-7,j-1));
    float4 pixel34 = read_imagef(inputImage,sampler,(int2)(i-7,j+0));
    float4 pixel35 = read_imagef(inputImage,sampler,(int2)(i-7,j+1));
    float4 pixel36 = read_imagef(inputImage,sampler,(int2)(i-7,j+2));
    float4 pixel37 = read_imagef(inputImage,sampler,(int2)(i-7,j+3));
    float4 pixel38 = read_imagef(inputImage,sampler,(int2)(i-7,j+4));
    float4 pixel39 = read_imagef(inputImage,sampler,(int2)(i-7,j+5));
    float4 pixel40 = read_imagef(inputImage,sampler,(int2)(i-7,j+6));
    float4 pixel41 = read_imagef(inputImage,sampler,(int2)(i-7,j+7));
    float4 pixel42 = read_imagef(inputImage,sampler,(int2)(i-7,j+8));
    float4 pixel43 = read_imagef(inputImage,sampler,(int2)(i-6,j-8));
    float4 pixel44 = read_imagef(inputImage,sampler,(int2)(i-6,j-7));
    float4 pixel45 = read_imagef(inputImage,sampler,(int2)(i-6,j-6));
    float4 pixel46 = read_imagef(inputImage,sampler,(int2)(i-6,j-5));
    float4 pixel47 = read_imagef(inputImage,sampler,(int2)(i-6,j-4));
    float4 pixel48 = read_imagef(inputImage,sampler,(int2)(i-6,j-3));
    float4 pixel49 = read_imagef(inputImage,sampler,(int2)(i-6,j-2));
    float4 pixel50 = read_imagef(inputImage,sampler,(int2)(i-6,j-1));
    float4 pixel51 = read_imagef(inputImage,sampler,(int2)(i-6,j+0));
    float4 pixel52 = read_imagef(inputImage,sampler,(int2)(i-6,j+1));
    float4 pixel53 = read_imagef(inputImage,sampler,(int2)(i-6,j+2));
    float4 pixel54 = read_imagef(inputImage,sampler,(int2)(i-6,j+3));
    float4 pixel55 = read_imagef(inputImage,sampler,(int2)(i-6,j+4));
    float4 pixel56 = read_imagef(inputImage,sampler,(int2)(i-6,j+5));
    float4 pixel57 = read_imagef(inputImage,sampler,(int2)(i-6,j+6));
    float4 pixel58 = read_imagef(inputImage,sampler,(int2)(i-6,j+7));
    float4 pixel59 = read_imagef(inputImage,sampler,(int2)(i-6,j+8));
    float4 pixel60 = read_imagef(inputImage,sampler,(int2)(i-5,j-9));
    float4 pixel61 = read_imagef(inputImage,sampler,(int2)(i-5,j-8));
    float4 pixel62 = read_imagef(inputImage,sampler,(int2)(i-5,j-7));
    float4 pixel63 = read_imagef(inputImage,sampler,(int2)(i-5,j-6));
    float4 pixel64 = read_imagef(inputImage,sampler,(int2)(i-5,j-5));
    float4 pixel65 = read_imagef(inputImage,sampler,(int2)(i-5,j-4));
    float4 pixel66 = read_imagef(inputImage,sampler,(int2)(i-5,j-3));
    float4 pixel67 = read_imagef(inputImage,sampler,(int2)(i-5,j-2));
    float4 pixel68 = read_imagef(inputImage,sampler,(int2)(i-5,j-1));
    float4 pixel69 = read_imagef(inputImage,sampler,(int2)(i-5,j+0));
    float4 pixel70 = read_imagef(inputImage,sampler,(int2)(i-5,j+1));
    float4 pixel71 = read_imagef(inputImage,sampler,(int2)(i-5,j+2));
    float4 pixel72 = read_imagef(inputImage,sampler,(int2)(i-5,j+3));
    float4 pixel73 = read_imagef(inputImage,sampler,(int2)(i-5,j+4));
    float4 pixel74 = read_imagef(inputImage,sampler,(int2)(i-5,j+5));
    float4 pixel75 = read_imagef(inputImage,sampler,(int2)(i-5,j+6));
    float4 pixel76 = read_imagef(inputImage,sampler,(int2)(i-5,j+7));
    float4 pixel77 = read_imagef(inputImage,sampler,(int2)(i-5,j+8));
    float4 pixel78 = read_imagef(inputImage,sampler,(int2)(i-5,j+9));
    float4 pixel79 = read_imagef(inputImage,sampler,(int2)(i-4,j-9));
    float4 pixel80 = read_imagef(inputImage,sampler,(int2)(i-4,j-8));
    float4 pixel81 = read_imagef(inputImage,sampler,(int2)(i-4,j-7));
    float4 pixel82 = read_imagef(inputImage,sampler,(int2)(i-4,j-6));
    float4 pixel83 = read_imagef(inputImage,sampler,(int2)(i-4,j-5));
    float4 pixel84 = read_imagef(inputImage,sampler,(int2)(i-4,j-4));
    float4 pixel85 = read_imagef(inputImage,sampler,(int2)(i-4,j-3));
    float4 pixel86 = read_imagef(inputImage,sampler,(int2)(i-4,j-2));
    float4 pixel87 = read_imagef(inputImage,sampler,(int2)(i-4,j-1));
    float4 pixel88 = read_imagef(inputImage,sampler,(int2)(i-4,j+0));
    float4 pixel89 = read_imagef(inputImage,sampler,(int2)(i-4,j+1));
    float4 pixel90 = read_imagef(inputImage,sampler,(int2)(i-4,j+2));
    float4 pixel91 = read_imagef(inputImage,sampler,(int2)(i-4,j+3));
    float4 pixel92 = read_imagef(inputImage,sampler,(int2)(i-4,j+4));
    float4 pixel93 = read_imagef(inputImage,sampler,(int2)(i-4,j+5));
    float4 pixel94 = read_imagef(inputImage,sampler,(int2)(i-4,j+6));
    float4 pixel95 = read_imagef(inputImage,sampler,(int2)(i-4,j+7));
    float4 pixel96 = read_imagef(inputImage,sampler,(int2)(i-4,j+8));
    float4 pixel97 = read_imagef(inputImage,sampler,(int2)(i-4,j+9));
    float4 pixel98 = read_imagef(inputImage,sampler,(int2)(i-3,j-9));
    float4 pixel99 = read_imagef(inputImage,sampler,(int2)(i-3,j-8));
    float4 pixel100 = read_imagef(inputImage,sampler,(int2)(i-3,j-7));
    float4 pixel101 = read_imagef(inputImage,sampler,(int2)(i-3,j-6));
    float4 pixel102 = read_imagef(inputImage,sampler,(int2)(i-3,j-5));
    float4 pixel103 = read_imagef(inputImage,sampler,(int2)(i-3,j-4));
    float4 pixel104 = read_imagef(inputImage,sampler,(int2)(i-3,j-3));
    float4 pixel105 = read_imagef(inputImage,sampler,(int2)(i-3,j-2));
    float4 pixel106 = read_imagef(inputImage,sampler,(int2)(i-3,j-1));
    float4 pixel107 = read_imagef(inputImage,sampler,(int2)(i-3,j+0));
    float4 pixel108 = read_imagef(inputImage,sampler,(int2)(i-3,j+1));
    float4 pixel109 = read_imagef(inputImage,sampler,(int2)(i-3,j+2));
    float4 pixel110 = read_imagef(inputImage,sampler,(int2)(i-3,j+3));
    float4 pixel111 = read_imagef(inputImage,sampler,(int2)(i-3,j+4));
    float4 pixel112 = read_imagef(inputImage,sampler,(int2)(i-3,j+5));
    float4 pixel113 = read_imagef(inputImage,sampler,(int2)(i-3,j+6));
    float4 pixel114 = read_imagef(inputImage,sampler,(int2)(i-3,j+7));
    float4 pixel115 = read_imagef(inputImage,sampler,(int2)(i-3,j+8));
    float4 pixel116 = read_imagef(inputImage,sampler,(int2)(i-3,j+9));
    float4 pixel117 = read_imagef(inputImage,sampler,(int2)(i-2,j-9));
    float4 pixel118 = read_imagef(inputImage,sampler,(int2)(i-2,j-8));
    float4 pixel119 = read_imagef(inputImage,sampler,(int2)(i-2,j-7));
    float4 pixel120 = read_imagef(inputImage,sampler,(int2)(i-2,j-6));
    float4 pixel121 = read_imagef(inputImage,sampler,(int2)(i-2,j-5));
    float4 pixel122 = read_imagef(inputImage,sampler,(int2)(i-2,j-4));
    float4 pixel123 = read_imagef(inputImage,sampler,(int2)(i-2,j-3));
    float4 pixel124 = read_imagef(inputImage,sampler,(int2)(i-2,j-2));
    float4 pixel125 = read_imagef(inputImage,sampler,(int2)(i-2,j-1));
    float4 pixel126 = read_imagef(inputImage,sampler,(int2)(i-2,j+0));
    float4 pixel127 = read_imagef(inputImage,sampler,(int2)(i-2,j+1));
    float4 pixel128 = read_imagef(inputImage,sampler,(int2)(i-2,j+2));
    float4 pixel129 = read_imagef(inputImage,sampler,(int2)(i-2,j+3));
    float4 pixel130 = read_imagef(inputImage,sampler,(int2)(i-2,j+4));
    float4 pixel131 = read_imagef(inputImage,sampler,(int2)(i-2,j+5));
    float4 pixel132 = read_imagef(inputImage,sampler,(int2)(i-2,j+6));
    float4 pixel133 = read_imagef(inputImage,sampler,(int2)(i-2,j+7));
    float4 pixel134 = read_imagef(inputImage,sampler,(int2)(i-2,j+8));
    float4 pixel135 = read_imagef(inputImage,sampler,(int2)(i-2,j+9));
    float4 pixel136 = read_imagef(inputImage,sampler,(int2)(i-1,j-9));
    float4 pixel137 = read_imagef(inputImage,sampler,(int2)(i-1,j-8));
    float4 pixel138 = read_imagef(inputImage,sampler,(int2)(i-1,j-7));
    float4 pixel139 = read_imagef(inputImage,sampler,(int2)(i-1,j-6));
    float4 pixel140 = read_imagef(inputImage,sampler,(int2)(i-1,j-5));
    float4 pixel141 = read_imagef(inputImage,sampler,(int2)(i-1,j-4));
    float4 pixel142 = read_imagef(inputImage,sampler,(int2)(i-1,j-3));
    float4 pixel143 = read_imagef(inputImage,sampler,(int2)(i-1,j-2));
    float4 pixel144 = read_imagef(inputImage,sampler,(int2)(i-1,j-1));
    float4 pixel145 = read_imagef(inputImage,sampler,(int2)(i-1,j+0));
    float4 pixel146 = read_imagef(inputImage,sampler,(int2)(i-1,j+1));
    float4 pixel147 = read_imagef(inputImage,sampler,(int2)(i-1,j+2));
    float4 pixel148 = read_imagef(inputImage,sampler,(int2)(i-1,j+3));
    float4 pixel149 = read_imagef(inputImage,sampler,(int2)(i-1,j+4));
    float4 pixel150 = read_imagef(inputImage,sampler,(int2)(i-1,j+5));
    float4 pixel151 = read_imagef(inputImage,sampler,(int2)(i-1,j+6));
    float4 pixel152 = read_imagef(inputImage,sampler,(int2)(i-1,j+7));
    float4 pixel153 = read_imagef(inputImage,sampler,(int2)(i-1,j+8));
    float4 pixel154 = read_imagef(inputImage,sampler,(int2)(i-1,j+9));
    float4 pixel155 = read_imagef(inputImage,sampler,(int2)(i-0,j-9));
    float4 pixel156 = read_imagef(inputImage,sampler,(int2)(i-0,j-8));
    float4 pixel157 = read_imagef(inputImage,sampler,(int2)(i-0,j-7));
    float4 pixel158 = read_imagef(inputImage,sampler,(int2)(i-0,j-6));
    float4 pixel159 = read_imagef(inputImage,sampler,(int2)(i-0,j-5));
    float4 pixel160 = read_imagef(inputImage,sampler,(int2)(i-0,j-4));
    float4 pixel161 = read_imagef(inputImage,sampler,(int2)(i-0,j-3));
    float4 pixel162 = read_imagef(inputImage,sampler,(int2)(i-0,j-2));
    float4 pixel163 = read_imagef(inputImage,sampler,(int2)(i-0,j-1));
    float4 pixel164 = read_imagef(inputImage,sampler,(int2)(i-0,j+0));
    float4 pixel165 = read_imagef(inputImage,sampler,(int2)(i-0,j+1));
    float4 pixel166 = read_imagef(inputImage,sampler,(int2)(i-0,j+2));
    float4 pixel167 = read_imagef(inputImage,sampler,(int2)(i-0,j+3));
    float4 pixel168 = read_imagef(inputImage,sampler,(int2)(i-0,j+4));
    float4 pixel169 = read_imagef(inputImage,sampler,(int2)(i-0,j+5));
    float4 pixel170 = read_imagef(inputImage,sampler,(int2)(i-0,j+6));
    float4 pixel171 = read_imagef(inputImage,sampler,(int2)(i-0,j+7));
    float4 pixel172 = read_imagef(inputImage,sampler,(int2)(i-0,j+8));
    float4 pixel173 = read_imagef(inputImage,sampler,(int2)(i-0,j+9));
    float4 pixel174 = read_imagef(inputImage,sampler,(int2)(i+1,j-9));
    float4 pixel175 = read_imagef(inputImage,sampler,(int2)(i+1,j-8));
    float4 pixel176 = read_imagef(inputImage,sampler,(int2)(i+1,j-7));
    float4 pixel177 = read_imagef(inputImage,sampler,(int2)(i+1,j-6));
    float4 pixel178 = read_imagef(inputImage,sampler,(int2)(i+1,j-5));
    float4 pixel179 = read_imagef(inputImage,sampler,(int2)(i+1,j-4));
    float4 pixel180 = read_imagef(inputImage,sampler,(int2)(i+1,j-3));
    float4 pixel181 = read_imagef(inputImage,sampler,(int2)(i+1,j-2));
    float4 pixel182 = read_imagef(inputImage,sampler,(int2)(i+1,j-1));
    float4 pixel183 = read_imagef(inputImage,sampler,(int2)(i+1,j+0));
    float4 pixel184 = read_imagef(inputImage,sampler,(int2)(i+1,j+1));
    float4 pixel185 = read_imagef(inputImage,sampler,(int2)(i+1,j+2));
    float4 pixel186 = read_imagef(inputImage,sampler,(int2)(i+1,j+3));
    float4 pixel187 = read_imagef(inputImage,sampler,(int2)(i+1,j+4));
    float4 pixel188 = read_imagef(inputImage,sampler,(int2)(i+1,j+5));
    float4 pixel189 = read_imagef(inputImage,sampler,(int2)(i+1,j+6));
    float4 pixel190 = read_imagef(inputImage,sampler,(int2)(i+1,j+7));
    float4 pixel191 = read_imagef(inputImage,sampler,(int2)(i+1,j+8));
    float4 pixel192 = read_imagef(inputImage,sampler,(int2)(i+1,j+9));
    float4 pixel193 = read_imagef(inputImage,sampler,(int2)(i+2,j-9));
    float4 pixel194 = read_imagef(inputImage,sampler,(int2)(i+2,j-8));
    float4 pixel195 = read_imagef(inputImage,sampler,(int2)(i+2,j-7));
    float4 pixel196 = read_imagef(inputImage,sampler,(int2)(i+2,j-6));
    float4 pixel197 = read_imagef(inputImage,sampler,(int2)(i+2,j-5));
    float4 pixel198 = read_imagef(inputImage,sampler,(int2)(i+2,j-4));
    float4 pixel199 = read_imagef(inputImage,sampler,(int2)(i+2,j-3));
    float4 pixel200 = read_imagef(inputImage,sampler,(int2)(i+2,j-2));
    float4 pixel201 = read_imagef(inputImage,sampler,(int2)(i+2,j-1));
    float4 pixel202 = read_imagef(inputImage,sampler,(int2)(i+2,j+0));
    float4 pixel203 = read_imagef(inputImage,sampler,(int2)(i+2,j+1));
    float4 pixel204 = read_imagef(inputImage,sampler,(int2)(i+2,j+2));
    float4 pixel205 = read_imagef(inputImage,sampler,(int2)(i+2,j+3));
    float4 pixel206 = read_imagef(inputImage,sampler,(int2)(i+2,j+4));
    float4 pixel207 = read_imagef(inputImage,sampler,(int2)(i+2,j+5));
    float4 pixel208 = read_imagef(inputImage,sampler,(int2)(i+2,j+6));
    float4 pixel209 = read_imagef(inputImage,sampler,(int2)(i+2,j+7));
    float4 pixel210 = read_imagef(inputImage,sampler,(int2)(i+2,j+8));
    float4 pixel211 = read_imagef(inputImage,sampler,(int2)(i+2,j+9));
    float4 pixel212 = read_imagef(inputImage,sampler,(int2)(i+3,j-9));
    float4 pixel213 = read_imagef(inputImage,sampler,(int2)(i+3,j-8));
    float4 pixel214 = read_imagef(inputImage,sampler,(int2)(i+3,j-7));
    float4 pixel215 = read_imagef(inputImage,sampler,(int2)(i+3,j-6));
    float4 pixel216 = read_imagef(inputImage,sampler,(int2)(i+3,j-5));
    float4 pixel217 = read_imagef(inputImage,sampler,(int2)(i+3,j-4));
    float4 pixel218 = read_imagef(inputImage,sampler,(int2)(i+3,j-3));
    float4 pixel219 = read_imagef(inputImage,sampler,(int2)(i+3,j-2));
    float4 pixel220 = read_imagef(inputImage,sampler,(int2)(i+3,j-1));
    float4 pixel221 = read_imagef(inputImage,sampler,(int2)(i+3,j+0));
    float4 pixel222 = read_imagef(inputImage,sampler,(int2)(i+3,j+1));
    float4 pixel223 = read_imagef(inputImage,sampler,(int2)(i+3,j+2));
    float4 pixel224 = read_imagef(inputImage,sampler,(int2)(i+3,j+3));
    float4 pixel225 = read_imagef(inputImage,sampler,(int2)(i+3,j+4));
    float4 pixel226 = read_imagef(inputImage,sampler,(int2)(i+3,j+5));
    float4 pixel227 = read_imagef(inputImage,sampler,(int2)(i+3,j+6));
    float4 pixel228 = read_imagef(inputImage,sampler,(int2)(i+3,j+7));
    float4 pixel229 = read_imagef(inputImage,sampler,(int2)(i+3,j+8));
    float4 pixel230 = read_imagef(inputImage,sampler,(int2)(i+3,j+9));
    float4 pixel231 = read_imagef(inputImage,sampler,(int2)(i+4,j-9));
    float4 pixel232 = read_imagef(inputImage,sampler,(int2)(i+4,j-8));
    float4 pixel233 = read_imagef(inputImage,sampler,(int2)(i+4,j-7));
    float4 pixel234 = read_imagef(inputImage,sampler,(int2)(i+4,j-6));
    float4 pixel235 = read_imagef(inputImage,sampler,(int2)(i+4,j-5));
    float4 pixel236 = read_imagef(inputImage,sampler,(int2)(i+4,j-4));
    float4 pixel237 = read_imagef(inputImage,sampler,(int2)(i+4,j-3));
    float4 pixel238 = read_imagef(inputImage,sampler,(int2)(i+4,j-2));
    float4 pixel239 = read_imagef(inputImage,sampler,(int2)(i+4,j-1));
    float4 pixel240 = read_imagef(inputImage,sampler,(int2)(i+4,j+0));
    float4 pixel241 = read_imagef(inputImage,sampler,(int2)(i+4,j+1));
    float4 pixel242 = read_imagef(inputImage,sampler,(int2)(i+4,j+2));
    float4 pixel243 = read_imagef(inputImage,sampler,(int2)(i+4,j+3));
    float4 pixel244 = read_imagef(inputImage,sampler,(int2)(i+4,j+4));
    float4 pixel245 = read_imagef(inputImage,sampler,(int2)(i+4,j+5));
    float4 pixel246 = read_imagef(inputImage,sampler,(int2)(i+4,j+6));
    float4 pixel247 = read_imagef(inputImage,sampler,(int2)(i+4,j+7));
    float4 pixel248 = read_imagef(inputImage,sampler,(int2)(i+4,j+8));
    float4 pixel249 = read_imagef(inputImage,sampler,(int2)(i+4,j+9));
    float4 pixel250 = read_imagef(inputImage,sampler,(int2)(i+5,j-9));
    float4 pixel251 = read_imagef(inputImage,sampler,(int2)(i+5,j-8));
    float4 pixel252 = read_imagef(inputImage,sampler,(int2)(i+5,j-7));
    float4 pixel253 = read_imagef(inputImage,sampler,(int2)(i+5,j-6));
    float4 pixel254 = read_imagef(inputImage,sampler,(int2)(i+5,j-5));
    float4 pixel255 = read_imagef(inputImage,sampler,(int2)(i+5,j-4));
    float4 pixel256 = read_imagef(inputImage,sampler,(int2)(i+5,j-3));
    float4 pixel257 = read_imagef(inputImage,sampler,(int2)(i+5,j-2));
    float4 pixel258 = read_imagef(inputImage,sampler,(int2)(i+5,j-1));
    float4 pixel259 = read_imagef(inputImage,sampler,(int2)(i+5,j+0));
    float4 pixel260 = read_imagef(inputImage,sampler,(int2)(i+5,j+1));
    float4 pixel261 = read_imagef(inputImage,sampler,(int2)(i+5,j+2));
    float4 pixel262 = read_imagef(inputImage,sampler,(int2)(i+5,j+3));
    float4 pixel263 = read_imagef(inputImage,sampler,(int2)(i+5,j+4));
    float4 pixel264 = read_imagef(inputImage,sampler,(int2)(i+5,j+5));
    float4 pixel265 = read_imagef(inputImage,sampler,(int2)(i+5,j+6));
    float4 pixel266 = read_imagef(inputImage,sampler,(int2)(i+5,j+7));
    float4 pixel267 = read_imagef(inputImage,sampler,(int2)(i+5,j+8));
    float4 pixel268 = read_imagef(inputImage,sampler,(int2)(i+5,j+9));
    float4 pixel269 = read_imagef(inputImage,sampler,(int2)(i+6,j-8));
    float4 pixel270 = read_imagef(inputImage,sampler,(int2)(i+6,j-7));
    float4 pixel271 = read_imagef(inputImage,sampler,(int2)(i+6,j-6));
    float4 pixel272 = read_imagef(inputImage,sampler,(int2)(i+6,j-5));
    float4 pixel273 = read_imagef(inputImage,sampler,(int2)(i+6,j-4));
    float4 pixel274 = read_imagef(inputImage,sampler,(int2)(i+6,j-3));
    float4 pixel275 = read_imagef(inputImage,sampler,(int2)(i+6,j-2));
    float4 pixel276 = read_imagef(inputImage,sampler,(int2)(i+6,j-1));
    float4 pixel277 = read_imagef(inputImage,sampler,(int2)(i+6,j+0));
    float4 pixel278 = read_imagef(inputImage,sampler,(int2)(i+6,j+1));
    float4 pixel279 = read_imagef(inputImage,sampler,(int2)(i+6,j+2));
    float4 pixel280 = read_imagef(inputImage,sampler,(int2)(i+6,j+3));
    float4 pixel281 = read_imagef(inputImage,sampler,(int2)(i+6,j+4));
    float4 pixel282 = read_imagef(inputImage,sampler,(int2)(i+6,j+5));
    float4 pixel283 = read_imagef(inputImage,sampler,(int2)(i+6,j+6));
    float4 pixel284 = read_imagef(inputImage,sampler,(int2)(i+6,j+7));
    float4 pixel285 = read_imagef(inputImage,sampler,(int2)(i+6,j+8));
    float4 pixel286 = read_imagef(inputImage,sampler,(int2)(i+7,j-8));
    float4 pixel287 = read_imagef(inputImage,sampler,(int2)(i+7,j-7));
    float4 pixel288 = read_imagef(inputImage,sampler,(int2)(i+7,j-6));
    float4 pixel289 = read_imagef(inputImage,sampler,(int2)(i+7,j-5));
    float4 pixel290 = read_imagef(inputImage,sampler,(int2)(i+7,j-4));
    float4 pixel291 = read_imagef(inputImage,sampler,(int2)(i+7,j-3));
    float4 pixel292 = read_imagef(inputImage,sampler,(int2)(i+7,j-2));
    float4 pixel293 = read_imagef(inputImage,sampler,(int2)(i+7,j-1));
    float4 pixel294 = read_imagef(inputImage,sampler,(int2)(i+7,j+0));
    float4 pixel295 = read_imagef(inputImage,sampler,(int2)(i+7,j+1));
    float4 pixel296 = read_imagef(inputImage,sampler,(int2)(i+7,j+2));
    float4 pixel297 = read_imagef(inputImage,sampler,(int2)(i+7,j+3));
    float4 pixel298 = read_imagef(inputImage,sampler,(int2)(i+7,j+4));
    float4 pixel299 = read_imagef(inputImage,sampler,(int2)(i+7,j+5));
    float4 pixel300 = read_imagef(inputImage,sampler,(int2)(i+7,j+6));
    float4 pixel301 = read_imagef(inputImage,sampler,(int2)(i+7,j+7));
    float4 pixel302 = read_imagef(inputImage,sampler,(int2)(i+7,j+8));
    float4 pixel303 = read_imagef(inputImage,sampler,(int2)(i+8,j-7));
    float4 pixel304 = read_imagef(inputImage,sampler,(int2)(i+8,j-6));
    float4 pixel305 = read_imagef(inputImage,sampler,(int2)(i+8,j-5));
    float4 pixel306 = read_imagef(inputImage,sampler,(int2)(i+8,j-4));
    float4 pixel307 = read_imagef(inputImage,sampler,(int2)(i+8,j-3));
    float4 pixel308 = read_imagef(inputImage,sampler,(int2)(i+8,j-2));
    float4 pixel309 = read_imagef(inputImage,sampler,(int2)(i+8,j-1));
    float4 pixel310 = read_imagef(inputImage,sampler,(int2)(i+8,j+0));
    float4 pixel311 = read_imagef(inputImage,sampler,(int2)(i+8,j+1));
    float4 pixel312 = read_imagef(inputImage,sampler,(int2)(i+8,j+2));
    float4 pixel313 = read_imagef(inputImage,sampler,(int2)(i+8,j+3));
    float4 pixel314 = read_imagef(inputImage,sampler,(int2)(i+8,j+4));
    float4 pixel315 = read_imagef(inputImage,sampler,(int2)(i+8,j+5));
    float4 pixel316 = read_imagef(inputImage,sampler,(int2)(i+8,j+6));
    float4 pixel317 = read_imagef(inputImage,sampler,(int2)(i+8,j+7));
    float4 pixel318 = read_imagef(inputImage,sampler,(int2)(i+9,j-5));
    float4 pixel319 = read_imagef(inputImage,sampler,(int2)(i+9,j-4));
    float4 pixel320 = read_imagef(inputImage,sampler,(int2)(i+9,j-3));
    float4 pixel321 = read_imagef(inputImage,sampler,(int2)(i+9,j-2));
    float4 pixel322 = read_imagef(inputImage,sampler,(int2)(i+9,j-1));
    float4 pixel323 = read_imagef(inputImage,sampler,(int2)(i+9,j+0));
    float4 pixel324 = read_imagef(inputImage,sampler,(int2)(i+9,j+1));
    float4 pixel325 = read_imagef(inputImage,sampler,(int2)(i+9,j+2));
    float4 pixel326 = read_imagef(inputImage,sampler,(int2)(i+9,j+3));
    float4 pixel327 = read_imagef(inputImage,sampler,(int2)(i+9,j+4));
    float4 pixel328 = read_imagef(inputImage,sampler,(int2)(i+9,j+5));
    float pixel0_diffR = fabs(pixel0.x- (float)255);
    float pixel0_diffG = fabs(pixel0.y- (float)255);
    float pixel0_diffB = fabs(pixel0.z- (float)255);
    float pixel0_diffA = fabs(pixel0.w- (float)255);
   if ((pixel0_diffR<17)&& (pixel0_diffG<17)&&(pixel0_diffB<17 )&&(pixel0_diffA<17)){
	    pixel_new += (pixel0)*(float)1.0; accumWeights += 1;
    }
    float pixel1_diffR = fabs(pixel1.x- (float)255);
    float pixel1_diffG = fabs(pixel1.y- (float)255);
    float pixel1_diffB = fabs(pixel1.z- (float)255);
    float pixel1_diffA = fabs(pixel1.w- (float)255);
   if ((pixel1_diffR<17)&& (pixel1_diffG<17)&&(pixel1_diffB<17 )&&(pixel1_diffA<17)){
	    pixel_new += (pixel1)*(float)2.0; accumWeights += 2;
    }
    float pixel2_diffR = fabs(pixel2.x- (float)255);
    float pixel2_diffG = fabs(pixel2.y- (float)255);
    float pixel2_diffB = fabs(pixel2.z- (float)255);
    float pixel2_diffA = fabs(pixel2.w- (float)255);
   if ((pixel2_diffR<17)&& (pixel2_diffG<17)&&(pixel2_diffB<17 )&&(pixel2_diffA<17)){
	    pixel_new += (pixel2)*(float)2.0; accumWeights += 2;
    }
    float pixel3_diffR = fabs(pixel3.x- (float)255);
    float pixel3_diffG = fabs(pixel3.y- (float)255);
    float pixel3_diffB = fabs(pixel3.z- (float)255);
    float pixel3_diffA = fabs(pixel3.w- (float)255);
   if ((pixel3_diffR<17)&& (pixel3_diffG<17)&&(pixel3_diffB<17 )&&(pixel3_diffA<17)){
	    pixel_new += (pixel3)*(float)3.0; accumWeights += 3;
    }
    float pixel4_diffR = fabs(pixel4.x- (float)255);
    float pixel4_diffG = fabs(pixel4.y- (float)255);
    float pixel4_diffB = fabs(pixel4.z- (float)255);
    float pixel4_diffA = fabs(pixel4.w- (float)255);
   if ((pixel4_diffR<17)&& (pixel4_diffG<17)&&(pixel4_diffB<17 )&&(pixel4_diffA<17)){
	    pixel_new += (pixel4)*(float)3.0; accumWeights += 3;
    }
    float pixel5_diffR = fabs(pixel5.x- (float)255);
    float pixel5_diffG = fabs(pixel5.y- (float)255);
    float pixel5_diffB = fabs(pixel5.z- (float)255);
    float pixel5_diffA = fabs(pixel5.w- (float)255);
   if ((pixel5_diffR<17)&& (pixel5_diffG<17)&&(pixel5_diffB<17 )&&(pixel5_diffA<17)){
	    pixel_new += (pixel5)*(float)3.0; accumWeights += 3;
    }
    float pixel6_diffR = fabs(pixel6.x- (float)255);
    float pixel6_diffG = fabs(pixel6.y- (float)255);
    float pixel6_diffB = fabs(pixel6.z- (float)255);
    float pixel6_diffA = fabs(pixel6.w- (float)255);
   if ((pixel6_diffR<17)&& (pixel6_diffG<17)&&(pixel6_diffB<17 )&&(pixel6_diffA<17)){
	    pixel_new += (pixel6)*(float)3.0; accumWeights += 3;
    }
    float pixel7_diffR = fabs(pixel7.x- (float)255);
    float pixel7_diffG = fabs(pixel7.y- (float)255);
    float pixel7_diffB = fabs(pixel7.z- (float)255);
    float pixel7_diffA = fabs(pixel7.w- (float)255);
   if ((pixel7_diffR<17)&& (pixel7_diffG<17)&&(pixel7_diffB<17 )&&(pixel7_diffA<17)){
	    pixel_new += (pixel7)*(float)3.0; accumWeights += 3;
    }
    float pixel8_diffR = fabs(pixel8.x- (float)255);
    float pixel8_diffG = fabs(pixel8.y- (float)255);
    float pixel8_diffB = fabs(pixel8.z- (float)255);
    float pixel8_diffA = fabs(pixel8.w- (float)255);
   if ((pixel8_diffR<17)&& (pixel8_diffG<17)&&(pixel8_diffB<17 )&&(pixel8_diffA<17)){
	    pixel_new += (pixel8)*(float)2.0; accumWeights += 2;
    }
    float pixel9_diffR = fabs(pixel9.x- (float)255);
    float pixel9_diffG = fabs(pixel9.y- (float)255);
    float pixel9_diffB = fabs(pixel9.z- (float)255);
    float pixel9_diffA = fabs(pixel9.w- (float)255);
   if ((pixel9_diffR<17)&& (pixel9_diffG<17)&&(pixel9_diffB<17 )&&(pixel9_diffA<17)){
	    pixel_new += (pixel9)*(float)2.0; accumWeights += 2;
    }
    float pixel10_diffR = fabs(pixel10.x- (float)255);
    float pixel10_diffG = fabs(pixel10.y- (float)255);
    float pixel10_diffB = fabs(pixel10.z- (float)255);
    float pixel10_diffA = fabs(pixel10.w- (float)255);
   if ((pixel10_diffR<17)&& (pixel10_diffG<17)&&(pixel10_diffB<17 )&&(pixel10_diffA<17)){
	    pixel_new += (pixel10)*(float)1.0; accumWeights += 1;
    }
    float pixel11_diffR = fabs(pixel11.x- (float)255);
    float pixel11_diffG = fabs(pixel11.y- (float)255);
    float pixel11_diffB = fabs(pixel11.z- (float)255);
    float pixel11_diffA = fabs(pixel11.w- (float)255);
   if ((pixel11_diffR<17)&& (pixel11_diffG<17)&&(pixel11_diffB<17 )&&(pixel11_diffA<17)){
	    pixel_new += (pixel11)*(float)1.0; accumWeights += 1;
    }
    float pixel12_diffR = fabs(pixel12.x- (float)255);
    float pixel12_diffG = fabs(pixel12.y- (float)255);
    float pixel12_diffB = fabs(pixel12.z- (float)255);
    float pixel12_diffA = fabs(pixel12.w- (float)255);
   if ((pixel12_diffR<17)&& (pixel12_diffG<17)&&(pixel12_diffB<17 )&&(pixel12_diffA<17)){
	    pixel_new += (pixel12)*(float)1.0; accumWeights += 1;
    }
    float pixel13_diffR = fabs(pixel13.x- (float)255);
    float pixel13_diffG = fabs(pixel13.y- (float)255);
    float pixel13_diffB = fabs(pixel13.z- (float)255);
    float pixel13_diffA = fabs(pixel13.w- (float)255);
   if ((pixel13_diffR<17)&& (pixel13_diffG<17)&&(pixel13_diffB<17 )&&(pixel13_diffA<17)){
	    pixel_new += (pixel13)*(float)2.0; accumWeights += 2;
    }
    float pixel14_diffR = fabs(pixel14.x- (float)255);
    float pixel14_diffG = fabs(pixel14.y- (float)255);
    float pixel14_diffB = fabs(pixel14.z- (float)255);
    float pixel14_diffA = fabs(pixel14.w- (float)255);
   if ((pixel14_diffR<17)&& (pixel14_diffG<17)&&(pixel14_diffB<17 )&&(pixel14_diffA<17)){
	    pixel_new += (pixel14)*(float)4.0; accumWeights += 4;
    }
    float pixel15_diffR = fabs(pixel15.x- (float)255);
    float pixel15_diffG = fabs(pixel15.y- (float)255);
    float pixel15_diffB = fabs(pixel15.z- (float)255);
    float pixel15_diffA = fabs(pixel15.w- (float)255);
   if ((pixel15_diffR<17)&& (pixel15_diffG<17)&&(pixel15_diffB<17 )&&(pixel15_diffA<17)){
	    pixel_new += (pixel15)*(float)5.0; accumWeights += 5;
    }
    float pixel16_diffR = fabs(pixel16.x- (float)255);
    float pixel16_diffG = fabs(pixel16.y- (float)255);
    float pixel16_diffB = fabs(pixel16.z- (float)255);
    float pixel16_diffA = fabs(pixel16.w- (float)255);
   if ((pixel16_diffR<17)&& (pixel16_diffG<17)&&(pixel16_diffB<17 )&&(pixel16_diffA<17)){
	    pixel_new += (pixel16)*(float)6.0; accumWeights += 6;
    }
    float pixel17_diffR = fabs(pixel17.x- (float)255);
    float pixel17_diffG = fabs(pixel17.y- (float)255);
    float pixel17_diffB = fabs(pixel17.z- (float)255);
    float pixel17_diffA = fabs(pixel17.w- (float)255);
   if ((pixel17_diffR<17)&& (pixel17_diffG<17)&&(pixel17_diffB<17 )&&(pixel17_diffA<17)){
	    pixel_new += (pixel17)*(float)7.0; accumWeights += 7;
    }
    float pixel18_diffR = fabs(pixel18.x- (float)255);
    float pixel18_diffG = fabs(pixel18.y- (float)255);
    float pixel18_diffB = fabs(pixel18.z- (float)255);
    float pixel18_diffA = fabs(pixel18.w- (float)255);
   if ((pixel18_diffR<17)&& (pixel18_diffG<17)&&(pixel18_diffB<17 )&&(pixel18_diffA<17)){
	    pixel_new += (pixel18)*(float)7.0; accumWeights += 7;
    }
    float pixel19_diffR = fabs(pixel19.x- (float)255);
    float pixel19_diffG = fabs(pixel19.y- (float)255);
    float pixel19_diffB = fabs(pixel19.z- (float)255);
    float pixel19_diffA = fabs(pixel19.w- (float)255);
   if ((pixel19_diffR<17)&& (pixel19_diffG<17)&&(pixel19_diffB<17 )&&(pixel19_diffA<17)){
	    pixel_new += (pixel19)*(float)7.0; accumWeights += 7;
    }
    float pixel20_diffR = fabs(pixel20.x- (float)255);
    float pixel20_diffG = fabs(pixel20.y- (float)255);
    float pixel20_diffB = fabs(pixel20.z- (float)255);
    float pixel20_diffA = fabs(pixel20.w- (float)255);
   if ((pixel20_diffR<17)&& (pixel20_diffG<17)&&(pixel20_diffB<17 )&&(pixel20_diffA<17)){
	    pixel_new += (pixel20)*(float)6.0; accumWeights += 6;
    }
    float pixel21_diffR = fabs(pixel21.x- (float)255);
    float pixel21_diffG = fabs(pixel21.y- (float)255);
    float pixel21_diffB = fabs(pixel21.z- (float)255);
    float pixel21_diffA = fabs(pixel21.w- (float)255);
   if ((pixel21_diffR<17)&& (pixel21_diffG<17)&&(pixel21_diffB<17 )&&(pixel21_diffA<17)){
	    pixel_new += (pixel21)*(float)5.0; accumWeights += 5;
    }
    float pixel22_diffR = fabs(pixel22.x- (float)255);
    float pixel22_diffG = fabs(pixel22.y- (float)255);
    float pixel22_diffB = fabs(pixel22.z- (float)255);
    float pixel22_diffA = fabs(pixel22.w- (float)255);
   if ((pixel22_diffR<17)&& (pixel22_diffG<17)&&(pixel22_diffB<17 )&&(pixel22_diffA<17)){
	    pixel_new += (pixel22)*(float)4.0; accumWeights += 4;
    }
    float pixel23_diffR = fabs(pixel23.x- (float)255);
    float pixel23_diffG = fabs(pixel23.y- (float)255);
    float pixel23_diffB = fabs(pixel23.z- (float)255);
    float pixel23_diffA = fabs(pixel23.w- (float)255);
   if ((pixel23_diffR<17)&& (pixel23_diffG<17)&&(pixel23_diffB<17 )&&(pixel23_diffA<17)){
	    pixel_new += (pixel23)*(float)2.0; accumWeights += 2;
    }
    float pixel24_diffR = fabs(pixel24.x- (float)255);
    float pixel24_diffG = fabs(pixel24.y- (float)255);
    float pixel24_diffB = fabs(pixel24.z- (float)255);
    float pixel24_diffA = fabs(pixel24.w- (float)255);
   if ((pixel24_diffR<17)&& (pixel24_diffG<17)&&(pixel24_diffB<17 )&&(pixel24_diffA<17)){
	    pixel_new += (pixel24)*(float)1.0; accumWeights += 1;
    }
    float pixel25_diffR = fabs(pixel25.x- (float)255);
    float pixel25_diffG = fabs(pixel25.y- (float)255);
    float pixel25_diffB = fabs(pixel25.z- (float)255);
    float pixel25_diffA = fabs(pixel25.w- (float)255);
   if ((pixel25_diffR<17)&& (pixel25_diffG<17)&&(pixel25_diffB<17 )&&(pixel25_diffA<17)){
	    pixel_new += (pixel25)*(float)1.0; accumWeights += 1;
    }
    float pixel26_diffR = fabs(pixel26.x- (float)255);
    float pixel26_diffG = fabs(pixel26.y- (float)255);
    float pixel26_diffB = fabs(pixel26.z- (float)255);
    float pixel26_diffA = fabs(pixel26.w- (float)255);
   if ((pixel26_diffR<17)&& (pixel26_diffG<17)&&(pixel26_diffB<17 )&&(pixel26_diffA<17)){
	    pixel_new += (pixel26)*(float)1.0; accumWeights += 1;
    }
    float pixel27_diffR = fabs(pixel27.x- (float)255);
    float pixel27_diffG = fabs(pixel27.y- (float)255);
    float pixel27_diffB = fabs(pixel27.z- (float)255);
    float pixel27_diffA = fabs(pixel27.w- (float)255);
   if ((pixel27_diffR<17)&& (pixel27_diffG<17)&&(pixel27_diffB<17 )&&(pixel27_diffA<17)){
	    pixel_new += (pixel27)*(float)1.0; accumWeights += 1;
    }
    float pixel28_diffR = fabs(pixel28.x- (float)255);
    float pixel28_diffG = fabs(pixel28.y- (float)255);
    float pixel28_diffB = fabs(pixel28.z- (float)255);
    float pixel28_diffA = fabs(pixel28.w- (float)255);
   if ((pixel28_diffR<17)&& (pixel28_diffG<17)&&(pixel28_diffB<17 )&&(pixel28_diffA<17)){
	    pixel_new += (pixel28)*(float)3.0; accumWeights += 3;
    }
    float pixel29_diffR = fabs(pixel29.x- (float)255);
    float pixel29_diffG = fabs(pixel29.y- (float)255);
    float pixel29_diffB = fabs(pixel29.z- (float)255);
    float pixel29_diffA = fabs(pixel29.w- (float)255);
   if ((pixel29_diffR<17)&& (pixel29_diffG<17)&&(pixel29_diffB<17 )&&(pixel29_diffA<17)){
	    pixel_new += (pixel29)*(float)5.0; accumWeights += 5;
    }
    float pixel30_diffR = fabs(pixel30.x- (float)255);
    float pixel30_diffG = fabs(pixel30.y- (float)255);
    float pixel30_diffB = fabs(pixel30.z- (float)255);
    float pixel30_diffA = fabs(pixel30.w- (float)255);
   if ((pixel30_diffR<17)&& (pixel30_diffG<17)&&(pixel30_diffB<17 )&&(pixel30_diffA<17)){
	    pixel_new += (pixel30)*(float)7.0; accumWeights += 7;
    }
    float pixel31_diffR = fabs(pixel31.x- (float)255);
    float pixel31_diffG = fabs(pixel31.y- (float)255);
    float pixel31_diffB = fabs(pixel31.z- (float)255);
    float pixel31_diffA = fabs(pixel31.w- (float)255);
   if ((pixel31_diffR<17)&& (pixel31_diffG<17)&&(pixel31_diffB<17 )&&(pixel31_diffA<17)){
	    pixel_new += (pixel31)*(float)9.0; accumWeights += 9;
    }
    float pixel32_diffR = fabs(pixel32.x- (float)255);
    float pixel32_diffG = fabs(pixel32.y- (float)255);
    float pixel32_diffB = fabs(pixel32.z- (float)255);
    float pixel32_diffA = fabs(pixel32.w- (float)255);
   if ((pixel32_diffR<17)&& (pixel32_diffG<17)&&(pixel32_diffB<17 )&&(pixel32_diffA<17)){
	    pixel_new += (pixel32)*(float)12.0; accumWeights += 12;
    }
    float pixel33_diffR = fabs(pixel33.x- (float)255);
    float pixel33_diffG = fabs(pixel33.y- (float)255);
    float pixel33_diffB = fabs(pixel33.z- (float)255);
    float pixel33_diffA = fabs(pixel33.w- (float)255);
   if ((pixel33_diffR<17)&& (pixel33_diffG<17)&&(pixel33_diffB<17 )&&(pixel33_diffA<17)){
	    pixel_new += (pixel33)*(float)13.0; accumWeights += 13;
    }
    float pixel34_diffR = fabs(pixel34.x- (float)255);
    float pixel34_diffG = fabs(pixel34.y- (float)255);
    float pixel34_diffB = fabs(pixel34.z- (float)255);
    float pixel34_diffA = fabs(pixel34.w- (float)255);
   if ((pixel34_diffR<17)&& (pixel34_diffG<17)&&(pixel34_diffB<17 )&&(pixel34_diffA<17)){
	    pixel_new += (pixel34)*(float)14.0; accumWeights += 14;
    }
    float pixel35_diffR = fabs(pixel35.x- (float)255);
    float pixel35_diffG = fabs(pixel35.y- (float)255);
    float pixel35_diffB = fabs(pixel35.z- (float)255);
    float pixel35_diffA = fabs(pixel35.w- (float)255);
   if ((pixel35_diffR<17)&& (pixel35_diffG<17)&&(pixel35_diffB<17 )&&(pixel35_diffA<17)){
	    pixel_new += (pixel35)*(float)13.0; accumWeights += 13;
    }
    float pixel36_diffR = fabs(pixel36.x- (float)255);
    float pixel36_diffG = fabs(pixel36.y- (float)255);
    float pixel36_diffB = fabs(pixel36.z- (float)255);
    float pixel36_diffA = fabs(pixel36.w- (float)255);
   if ((pixel36_diffR<17)&& (pixel36_diffG<17)&&(pixel36_diffB<17 )&&(pixel36_diffA<17)){
	    pixel_new += (pixel36)*(float)12.0; accumWeights += 12;
    }
    float pixel37_diffR = fabs(pixel37.x- (float)255);
    float pixel37_diffG = fabs(pixel37.y- (float)255);
    float pixel37_diffB = fabs(pixel37.z- (float)255);
    float pixel37_diffA = fabs(pixel37.w- (float)255);
   if ((pixel37_diffR<17)&& (pixel37_diffG<17)&&(pixel37_diffB<17 )&&(pixel37_diffA<17)){
	    pixel_new += (pixel37)*(float)9.0; accumWeights += 9;
    }
    float pixel38_diffR = fabs(pixel38.x- (float)255);
    float pixel38_diffG = fabs(pixel38.y- (float)255);
    float pixel38_diffB = fabs(pixel38.z- (float)255);
    float pixel38_diffA = fabs(pixel38.w- (float)255);
   if ((pixel38_diffR<17)&& (pixel38_diffG<17)&&(pixel38_diffB<17 )&&(pixel38_diffA<17)){
	    pixel_new += (pixel38)*(float)7.0; accumWeights += 7;
    }
    float pixel39_diffR = fabs(pixel39.x- (float)255);
    float pixel39_diffG = fabs(pixel39.y- (float)255);
    float pixel39_diffB = fabs(pixel39.z- (float)255);
    float pixel39_diffA = fabs(pixel39.w- (float)255);
   if ((pixel39_diffR<17)&& (pixel39_diffG<17)&&(pixel39_diffB<17 )&&(pixel39_diffA<17)){
	    pixel_new += (pixel39)*(float)5.0; accumWeights += 5;
    }
    float pixel40_diffR = fabs(pixel40.x- (float)255);
    float pixel40_diffG = fabs(pixel40.y- (float)255);
    float pixel40_diffB = fabs(pixel40.z- (float)255);
    float pixel40_diffA = fabs(pixel40.w- (float)255);
   if ((pixel40_diffR<17)&& (pixel40_diffG<17)&&(pixel40_diffB<17 )&&(pixel40_diffA<17)){
	    pixel_new += (pixel40)*(float)3.0; accumWeights += 3;
    }
    float pixel41_diffR = fabs(pixel41.x- (float)255);
    float pixel41_diffG = fabs(pixel41.y- (float)255);
    float pixel41_diffB = fabs(pixel41.z- (float)255);
    float pixel41_diffA = fabs(pixel41.w- (float)255);
   if ((pixel41_diffR<17)&& (pixel41_diffG<17)&&(pixel41_diffB<17 )&&(pixel41_diffA<17)){
	    pixel_new += (pixel41)*(float)1.0; accumWeights += 1;
    }
    float pixel42_diffR = fabs(pixel42.x- (float)255);
    float pixel42_diffG = fabs(pixel42.y- (float)255);
    float pixel42_diffB = fabs(pixel42.z- (float)255);
    float pixel42_diffA = fabs(pixel42.w- (float)255);
   if ((pixel42_diffR<17)&& (pixel42_diffG<17)&&(pixel42_diffB<17 )&&(pixel42_diffA<17)){
	    pixel_new += (pixel42)*(float)1.0; accumWeights += 1;
    }
    float pixel43_diffR = fabs(pixel43.x- (float)255);
    float pixel43_diffG = fabs(pixel43.y- (float)255);
    float pixel43_diffB = fabs(pixel43.z- (float)255);
    float pixel43_diffA = fabs(pixel43.w- (float)255);
   if ((pixel43_diffR<17)&& (pixel43_diffG<17)&&(pixel43_diffB<17 )&&(pixel43_diffA<17)){
	    pixel_new += (pixel43)*(float)1.0; accumWeights += 1;
    }
    float pixel44_diffR = fabs(pixel44.x- (float)255);
    float pixel44_diffG = fabs(pixel44.y- (float)255);
    float pixel44_diffB = fabs(pixel44.z- (float)255);
    float pixel44_diffA = fabs(pixel44.w- (float)255);
   if ((pixel44_diffR<17)&& (pixel44_diffG<17)&&(pixel44_diffB<17 )&&(pixel44_diffA<17)){
	    pixel_new += (pixel44)*(float)3.0; accumWeights += 3;
    }
    float pixel45_diffR = fabs(pixel45.x- (float)255);
    float pixel45_diffG = fabs(pixel45.y- (float)255);
    float pixel45_diffB = fabs(pixel45.z- (float)255);
    float pixel45_diffA = fabs(pixel45.w- (float)255);
   if ((pixel45_diffR<17)&& (pixel45_diffG<17)&&(pixel45_diffB<17 )&&(pixel45_diffA<17)){
	    pixel_new += (pixel45)*(float)5.0; accumWeights += 5;
    }
    float pixel46_diffR = fabs(pixel46.x- (float)255);
    float pixel46_diffG = fabs(pixel46.y- (float)255);
    float pixel46_diffB = fabs(pixel46.z- (float)255);
    float pixel46_diffA = fabs(pixel46.w- (float)255);
   if ((pixel46_diffR<17)&& (pixel46_diffG<17)&&(pixel46_diffB<17 )&&(pixel46_diffA<17)){
	    pixel_new += (pixel46)*(float)8.0; accumWeights += 8;
    }
    float pixel47_diffR = fabs(pixel47.x- (float)255);
    float pixel47_diffG = fabs(pixel47.y- (float)255);
    float pixel47_diffB = fabs(pixel47.z- (float)255);
    float pixel47_diffA = fabs(pixel47.w- (float)255);
   if ((pixel47_diffR<17)&& (pixel47_diffG<17)&&(pixel47_diffB<17 )&&(pixel47_diffA<17)){
	    pixel_new += (pixel47)*(float)12.0; accumWeights += 12;
    }
    float pixel48_diffR = fabs(pixel48.x- (float)255);
    float pixel48_diffG = fabs(pixel48.y- (float)255);
    float pixel48_diffB = fabs(pixel48.z- (float)255);
    float pixel48_diffA = fabs(pixel48.w- (float)255);
   if ((pixel48_diffR<17)&& (pixel48_diffG<17)&&(pixel48_diffB<17 )&&(pixel48_diffA<17)){
	    pixel_new += (pixel48)*(float)16.0; accumWeights += 16;
    }
    float pixel49_diffR = fabs(pixel49.x- (float)255);
    float pixel49_diffG = fabs(pixel49.y- (float)255);
    float pixel49_diffB = fabs(pixel49.z- (float)255);
    float pixel49_diffA = fabs(pixel49.w- (float)255);
   if ((pixel49_diffR<17)&& (pixel49_diffG<17)&&(pixel49_diffB<17 )&&(pixel49_diffA<17)){
	    pixel_new += (pixel49)*(float)20.0; accumWeights += 20;
    }
    float pixel50_diffR = fabs(pixel50.x- (float)255);
    float pixel50_diffG = fabs(pixel50.y- (float)255);
    float pixel50_diffB = fabs(pixel50.z- (float)255);
    float pixel50_diffA = fabs(pixel50.w- (float)255);
   if ((pixel50_diffR<17)&& (pixel50_diffG<17)&&(pixel50_diffB<17 )&&(pixel50_diffA<17)){
	    pixel_new += (pixel50)*(float)22.0; accumWeights += 22;
    }
    float pixel51_diffR = fabs(pixel51.x- (float)255);
    float pixel51_diffG = fabs(pixel51.y- (float)255);
    float pixel51_diffB = fabs(pixel51.z- (float)255);
    float pixel51_diffA = fabs(pixel51.w- (float)255);
   if ((pixel51_diffR<17)&& (pixel51_diffG<17)&&(pixel51_diffB<17 )&&(pixel51_diffA<17)){
	    pixel_new += (pixel51)*(float)23.0; accumWeights += 23;
    }
    float pixel52_diffR = fabs(pixel52.x- (float)255);
    float pixel52_diffG = fabs(pixel52.y- (float)255);
    float pixel52_diffB = fabs(pixel52.z- (float)255);
    float pixel52_diffA = fabs(pixel52.w- (float)255);
   if ((pixel52_diffR<17)&& (pixel52_diffG<17)&&(pixel52_diffB<17 )&&(pixel52_diffA<17)){
	    pixel_new += (pixel52)*(float)22.0; accumWeights += 22;
    }
    float pixel53_diffR = fabs(pixel53.x- (float)255);
    float pixel53_diffG = fabs(pixel53.y- (float)255);
    float pixel53_diffB = fabs(pixel53.z- (float)255);
    float pixel53_diffA = fabs(pixel53.w- (float)255);
   if ((pixel53_diffR<17)&& (pixel53_diffG<17)&&(pixel53_diffB<17 )&&(pixel53_diffA<17)){
	    pixel_new += (pixel53)*(float)20.0; accumWeights += 20;
    }
    float pixel54_diffR = fabs(pixel54.x- (float)255);
    float pixel54_diffG = fabs(pixel54.y- (float)255);
    float pixel54_diffB = fabs(pixel54.z- (float)255);
    float pixel54_diffA = fabs(pixel54.w- (float)255);
   if ((pixel54_diffR<17)&& (pixel54_diffG<17)&&(pixel54_diffB<17 )&&(pixel54_diffA<17)){
	    pixel_new += (pixel54)*(float)16.0; accumWeights += 16;
    }
    float pixel55_diffR = fabs(pixel55.x- (float)255);
    float pixel55_diffG = fabs(pixel55.y- (float)255);
    float pixel55_diffB = fabs(pixel55.z- (float)255);
    float pixel55_diffA = fabs(pixel55.w- (float)255);
   if ((pixel55_diffR<17)&& (pixel55_diffG<17)&&(pixel55_diffB<17 )&&(pixel55_diffA<17)){
	    pixel_new += (pixel55)*(float)12.0; accumWeights += 12;
    }
    float pixel56_diffR = fabs(pixel56.x- (float)255);
    float pixel56_diffG = fabs(pixel56.y- (float)255);
    float pixel56_diffB = fabs(pixel56.z- (float)255);
    float pixel56_diffA = fabs(pixel56.w- (float)255);
   if ((pixel56_diffR<17)&& (pixel56_diffG<17)&&(pixel56_diffB<17 )&&(pixel56_diffA<17)){
	    pixel_new += (pixel56)*(float)8.0; accumWeights += 8;
    }
    float pixel57_diffR = fabs(pixel57.x- (float)255);
    float pixel57_diffG = fabs(pixel57.y- (float)255);
    float pixel57_diffB = fabs(pixel57.z- (float)255);
    float pixel57_diffA = fabs(pixel57.w- (float)255);
   if ((pixel57_diffR<17)&& (pixel57_diffG<17)&&(pixel57_diffB<17 )&&(pixel57_diffA<17)){
	    pixel_new += (pixel57)*(float)5.0; accumWeights += 5;
    }
    float pixel58_diffR = fabs(pixel58.x- (float)255);
    float pixel58_diffG = fabs(pixel58.y- (float)255);
    float pixel58_diffB = fabs(pixel58.z- (float)255);
    float pixel58_diffA = fabs(pixel58.w- (float)255);
   if ((pixel58_diffR<17)&& (pixel58_diffG<17)&&(pixel58_diffB<17 )&&(pixel58_diffA<17)){
	    pixel_new += (pixel58)*(float)3.0; accumWeights += 3;
    }
    float pixel59_diffR = fabs(pixel59.x- (float)255);
    float pixel59_diffG = fabs(pixel59.y- (float)255);
    float pixel59_diffB = fabs(pixel59.z- (float)255);
    float pixel59_diffA = fabs(pixel59.w- (float)255);
   if ((pixel59_diffR<17)&& (pixel59_diffG<17)&&(pixel59_diffB<17 )&&(pixel59_diffA<17)){
	    pixel_new += (pixel59)*(float)1.0; accumWeights += 1;
    }
    float pixel60_diffR = fabs(pixel60.x- (float)255);
    float pixel60_diffG = fabs(pixel60.y- (float)255);
    float pixel60_diffB = fabs(pixel60.z- (float)255);
    float pixel60_diffA = fabs(pixel60.w- (float)255);
   if ((pixel60_diffR<17)&& (pixel60_diffG<17)&&(pixel60_diffB<17 )&&(pixel60_diffA<17)){
	    pixel_new += (pixel60)*(float)1.0; accumWeights += 1;
    }
    float pixel61_diffR = fabs(pixel61.x- (float)255);
    float pixel61_diffG = fabs(pixel61.y- (float)255);
    float pixel61_diffB = fabs(pixel61.z- (float)255);
    float pixel61_diffA = fabs(pixel61.w- (float)255);
   if ((pixel61_diffR<17)&& (pixel61_diffG<17)&&(pixel61_diffB<17 )&&(pixel61_diffA<17)){
	    pixel_new += (pixel61)*(float)2.0; accumWeights += 2;
    }
    float pixel62_diffR = fabs(pixel62.x- (float)255);
    float pixel62_diffG = fabs(pixel62.y- (float)255);
    float pixel62_diffB = fabs(pixel62.z- (float)255);
    float pixel62_diffA = fabs(pixel62.w- (float)255);
   if ((pixel62_diffR<17)&& (pixel62_diffG<17)&&(pixel62_diffB<17 )&&(pixel62_diffA<17)){
	    pixel_new += (pixel62)*(float)5.0; accumWeights += 5;
    }
    float pixel63_diffR = fabs(pixel63.x- (float)255);
    float pixel63_diffG = fabs(pixel63.y- (float)255);
    float pixel63_diffB = fabs(pixel63.z- (float)255);
    float pixel63_diffA = fabs(pixel63.w- (float)255);
   if ((pixel63_diffR<17)&& (pixel63_diffG<17)&&(pixel63_diffB<17 )&&(pixel63_diffA<17)){
	    pixel_new += (pixel63)*(float)8.0; accumWeights += 8;
    }
    float pixel64_diffR = fabs(pixel64.x- (float)255);
    float pixel64_diffG = fabs(pixel64.y- (float)255);
    float pixel64_diffB = fabs(pixel64.z- (float)255);
    float pixel64_diffA = fabs(pixel64.w- (float)255);
   if ((pixel64_diffR<17)&& (pixel64_diffG<17)&&(pixel64_diffB<17 )&&(pixel64_diffA<17)){
	    pixel_new += (pixel64)*(float)13.0; accumWeights += 13;
    }
    float pixel65_diffR = fabs(pixel65.x- (float)255);
    float pixel65_diffG = fabs(pixel65.y- (float)255);
    float pixel65_diffB = fabs(pixel65.z- (float)255);
    float pixel65_diffA = fabs(pixel65.w- (float)255);
   if ((pixel65_diffR<17)&& (pixel65_diffG<17)&&(pixel65_diffB<17 )&&(pixel65_diffA<17)){
	    pixel_new += (pixel65)*(float)19.0; accumWeights += 19;
    }
    float pixel66_diffR = fabs(pixel66.x- (float)255);
    float pixel66_diffG = fabs(pixel66.y- (float)255);
    float pixel66_diffB = fabs(pixel66.z- (float)255);
    float pixel66_diffA = fabs(pixel66.w- (float)255);
   if ((pixel66_diffR<17)&& (pixel66_diffG<17)&&(pixel66_diffB<17 )&&(pixel66_diffA<17)){
	    pixel_new += (pixel66)*(float)25.0; accumWeights += 25;
    }
    float pixel67_diffR = fabs(pixel67.x- (float)255);
    float pixel67_diffG = fabs(pixel67.y- (float)255);
    float pixel67_diffB = fabs(pixel67.z- (float)255);
    float pixel67_diffA = fabs(pixel67.w- (float)255);
   if ((pixel67_diffR<17)&& (pixel67_diffG<17)&&(pixel67_diffB<17 )&&(pixel67_diffA<17)){
	    pixel_new += (pixel67)*(float)31.0; accumWeights += 31;
    }
    float pixel68_diffR = fabs(pixel68.x- (float)255);
    float pixel68_diffG = fabs(pixel68.y- (float)255);
    float pixel68_diffB = fabs(pixel68.z- (float)255);
    float pixel68_diffA = fabs(pixel68.w- (float)255);
   if ((pixel68_diffR<17)&& (pixel68_diffG<17)&&(pixel68_diffB<17 )&&(pixel68_diffA<17)){
	    pixel_new += (pixel68)*(float)35.0; accumWeights += 35;
    }
    float pixel69_diffR = fabs(pixel69.x- (float)255);
    float pixel69_diffG = fabs(pixel69.y- (float)255);
    float pixel69_diffB = fabs(pixel69.z- (float)255);
    float pixel69_diffA = fabs(pixel69.w- (float)255);
   if ((pixel69_diffR<17)&& (pixel69_diffG<17)&&(pixel69_diffB<17 )&&(pixel69_diffA<17)){
	    pixel_new += (pixel69)*(float)36.0; accumWeights += 36;
    }
    float pixel70_diffR = fabs(pixel70.x- (float)255);
    float pixel70_diffG = fabs(pixel70.y- (float)255);
    float pixel70_diffB = fabs(pixel70.z- (float)255);
    float pixel70_diffA = fabs(pixel70.w- (float)255);
   if ((pixel70_diffR<17)&& (pixel70_diffG<17)&&(pixel70_diffB<17 )&&(pixel70_diffA<17)){
	    pixel_new += (pixel70)*(float)35.0; accumWeights += 35;
    }
    float pixel71_diffR = fabs(pixel71.x- (float)255);
    float pixel71_diffG = fabs(pixel71.y- (float)255);
    float pixel71_diffB = fabs(pixel71.z- (float)255);
    float pixel71_diffA = fabs(pixel71.w- (float)255);
   if ((pixel71_diffR<17)&& (pixel71_diffG<17)&&(pixel71_diffB<17 )&&(pixel71_diffA<17)){
	    pixel_new += (pixel71)*(float)31.0; accumWeights += 31;
    }
    float pixel72_diffR = fabs(pixel72.x- (float)255);
    float pixel72_diffG = fabs(pixel72.y- (float)255);
    float pixel72_diffB = fabs(pixel72.z- (float)255);
    float pixel72_diffA = fabs(pixel72.w- (float)255);
   if ((pixel72_diffR<17)&& (pixel72_diffG<17)&&(pixel72_diffB<17 )&&(pixel72_diffA<17)){
	    pixel_new += (pixel72)*(float)25.0; accumWeights += 25;
    }
    float pixel73_diffR = fabs(pixel73.x- (float)255);
    float pixel73_diffG = fabs(pixel73.y- (float)255);
    float pixel73_diffB = fabs(pixel73.z- (float)255);
    float pixel73_diffA = fabs(pixel73.w- (float)255);
   if ((pixel73_diffR<17)&& (pixel73_diffG<17)&&(pixel73_diffB<17 )&&(pixel73_diffA<17)){
	    pixel_new += (pixel73)*(float)19.0; accumWeights += 19;
    }
    float pixel74_diffR = fabs(pixel74.x- (float)255);
    float pixel74_diffG = fabs(pixel74.y- (float)255);
    float pixel74_diffB = fabs(pixel74.z- (float)255);
    float pixel74_diffA = fabs(pixel74.w- (float)255);
   if ((pixel74_diffR<17)&& (pixel74_diffG<17)&&(pixel74_diffB<17 )&&(pixel74_diffA<17)){
	    pixel_new += (pixel74)*(float)13.0; accumWeights += 13;
    }
    float pixel75_diffR = fabs(pixel75.x- (float)255);
    float pixel75_diffG = fabs(pixel75.y- (float)255);
    float pixel75_diffB = fabs(pixel75.z- (float)255);
    float pixel75_diffA = fabs(pixel75.w- (float)255);
   if ((pixel75_diffR<17)&& (pixel75_diffG<17)&&(pixel75_diffB<17 )&&(pixel75_diffA<17)){
	    pixel_new += (pixel75)*(float)8.0; accumWeights += 8;
    }
    float pixel76_diffR = fabs(pixel76.x- (float)255);
    float pixel76_diffG = fabs(pixel76.y- (float)255);
    float pixel76_diffB = fabs(pixel76.z- (float)255);
    float pixel76_diffA = fabs(pixel76.w- (float)255);
   if ((pixel76_diffR<17)&& (pixel76_diffG<17)&&(pixel76_diffB<17 )&&(pixel76_diffA<17)){
	    pixel_new += (pixel76)*(float)5.0; accumWeights += 5;
    }
    float pixel77_diffR = fabs(pixel77.x- (float)255);
    float pixel77_diffG = fabs(pixel77.y- (float)255);
    float pixel77_diffB = fabs(pixel77.z- (float)255);
    float pixel77_diffA = fabs(pixel77.w- (float)255);
   if ((pixel77_diffR<17)&& (pixel77_diffG<17)&&(pixel77_diffB<17 )&&(pixel77_diffA<17)){
	    pixel_new += (pixel77)*(float)2.0; accumWeights += 2;
    }
    float pixel78_diffR = fabs(pixel78.x- (float)255);
    float pixel78_diffG = fabs(pixel78.y- (float)255);
    float pixel78_diffB = fabs(pixel78.z- (float)255);
    float pixel78_diffA = fabs(pixel78.w- (float)255);
   if ((pixel78_diffR<17)&& (pixel78_diffG<17)&&(pixel78_diffB<17 )&&(pixel78_diffA<17)){
	    pixel_new += (pixel78)*(float)1.0; accumWeights += 1;
    }
    float pixel79_diffR = fabs(pixel79.x- (float)255);
    float pixel79_diffG = fabs(pixel79.y- (float)255);
    float pixel79_diffB = fabs(pixel79.z- (float)255);
    float pixel79_diffA = fabs(pixel79.w- (float)255);
   if ((pixel79_diffR<17)&& (pixel79_diffG<17)&&(pixel79_diffB<17 )&&(pixel79_diffA<17)){
	    pixel_new += (pixel79)*(float)2.0; accumWeights += 2;
    }
    float pixel80_diffR = fabs(pixel80.x- (float)255);
    float pixel80_diffG = fabs(pixel80.y- (float)255);
    float pixel80_diffB = fabs(pixel80.z- (float)255);
    float pixel80_diffA = fabs(pixel80.w- (float)255);
   if ((pixel80_diffR<17)&& (pixel80_diffG<17)&&(pixel80_diffB<17 )&&(pixel80_diffA<17)){
	    pixel_new += (pixel80)*(float)4.0; accumWeights += 4;
    }
    float pixel81_diffR = fabs(pixel81.x- (float)255);
    float pixel81_diffG = fabs(pixel81.y- (float)255);
    float pixel81_diffB = fabs(pixel81.z- (float)255);
    float pixel81_diffA = fabs(pixel81.w- (float)255);
   if ((pixel81_diffR<17)&& (pixel81_diffG<17)&&(pixel81_diffB<17 )&&(pixel81_diffA<17)){
	    pixel_new += (pixel81)*(float)7.0; accumWeights += 7;
    }
    float pixel82_diffR = fabs(pixel82.x- (float)255);
    float pixel82_diffG = fabs(pixel82.y- (float)255);
    float pixel82_diffB = fabs(pixel82.z- (float)255);
    float pixel82_diffA = fabs(pixel82.w- (float)255);
   if ((pixel82_diffR<17)&& (pixel82_diffG<17)&&(pixel82_diffB<17 )&&(pixel82_diffA<17)){
	    pixel_new += (pixel82)*(float)12.0; accumWeights += 12;
    }
    float pixel83_diffR = fabs(pixel83.x- (float)255);
    float pixel83_diffG = fabs(pixel83.y- (float)255);
    float pixel83_diffB = fabs(pixel83.z- (float)255);
    float pixel83_diffA = fabs(pixel83.w- (float)255);
   if ((pixel83_diffR<17)&& (pixel83_diffG<17)&&(pixel83_diffB<17 )&&(pixel83_diffA<17)){
	    pixel_new += (pixel83)*(float)19.0; accumWeights += 19;
    }
    float pixel84_diffR = fabs(pixel84.x- (float)255);
    float pixel84_diffG = fabs(pixel84.y- (float)255);
    float pixel84_diffB = fabs(pixel84.z- (float)255);
    float pixel84_diffA = fabs(pixel84.w- (float)255);
   if ((pixel84_diffR<17)&& (pixel84_diffG<17)&&(pixel84_diffB<17 )&&(pixel84_diffA<17)){
	    pixel_new += (pixel84)*(float)27.0; accumWeights += 27;
    }
    float pixel85_diffR = fabs(pixel85.x- (float)255);
    float pixel85_diffG = fabs(pixel85.y- (float)255);
    float pixel85_diffB = fabs(pixel85.z- (float)255);
    float pixel85_diffA = fabs(pixel85.w- (float)255);
   if ((pixel85_diffR<17)&& (pixel85_diffG<17)&&(pixel85_diffB<17 )&&(pixel85_diffA<17)){
	    pixel_new += (pixel85)*(float)36.0; accumWeights += 36;
    }
    float pixel86_diffR = fabs(pixel86.x- (float)255);
    float pixel86_diffG = fabs(pixel86.y- (float)255);
    float pixel86_diffB = fabs(pixel86.z- (float)255);
    float pixel86_diffA = fabs(pixel86.w- (float)255);
   if ((pixel86_diffR<17)&& (pixel86_diffG<17)&&(pixel86_diffB<17 )&&(pixel86_diffA<17)){
	    pixel_new += (pixel86)*(float)44.0; accumWeights += 44;
    }
    float pixel87_diffR = fabs(pixel87.x- (float)255);
    float pixel87_diffG = fabs(pixel87.y- (float)255);
    float pixel87_diffB = fabs(pixel87.z- (float)255);
    float pixel87_diffA = fabs(pixel87.w- (float)255);
   if ((pixel87_diffR<17)&& (pixel87_diffG<17)&&(pixel87_diffB<17 )&&(pixel87_diffA<17)){
	    pixel_new += (pixel87)*(float)50.0; accumWeights += 50;
    }
    float pixel88_diffR = fabs(pixel88.x- (float)255);
    float pixel88_diffG = fabs(pixel88.y- (float)255);
    float pixel88_diffB = fabs(pixel88.z- (float)255);
    float pixel88_diffA = fabs(pixel88.w- (float)255);
   if ((pixel88_diffR<17)&& (pixel88_diffG<17)&&(pixel88_diffB<17 )&&(pixel88_diffA<17)){
	    pixel_new += (pixel88)*(float)52.0; accumWeights += 52;
    }
    float pixel89_diffR = fabs(pixel89.x- (float)255);
    float pixel89_diffG = fabs(pixel89.y- (float)255);
    float pixel89_diffB = fabs(pixel89.z- (float)255);
    float pixel89_diffA = fabs(pixel89.w- (float)255);
   if ((pixel89_diffR<17)&& (pixel89_diffG<17)&&(pixel89_diffB<17 )&&(pixel89_diffA<17)){
	    pixel_new += (pixel89)*(float)50.0; accumWeights += 50;
    }
    float pixel90_diffR = fabs(pixel90.x- (float)255);
    float pixel90_diffG = fabs(pixel90.y- (float)255);
    float pixel90_diffB = fabs(pixel90.z- (float)255);
    float pixel90_diffA = fabs(pixel90.w- (float)255);
   if ((pixel90_diffR<17)&& (pixel90_diffG<17)&&(pixel90_diffB<17 )&&(pixel90_diffA<17)){
	    pixel_new += (pixel90)*(float)44.0; accumWeights += 44;
    }
    float pixel91_diffR = fabs(pixel91.x- (float)255);
    float pixel91_diffG = fabs(pixel91.y- (float)255);
    float pixel91_diffB = fabs(pixel91.z- (float)255);
    float pixel91_diffA = fabs(pixel91.w- (float)255);
   if ((pixel91_diffR<17)&& (pixel91_diffG<17)&&(pixel91_diffB<17 )&&(pixel91_diffA<17)){
	    pixel_new += (pixel91)*(float)36.0; accumWeights += 36;
    }
    float pixel92_diffR = fabs(pixel92.x- (float)255);
    float pixel92_diffG = fabs(pixel92.y- (float)255);
    float pixel92_diffB = fabs(pixel92.z- (float)255);
    float pixel92_diffA = fabs(pixel92.w- (float)255);
   if ((pixel92_diffR<17)&& (pixel92_diffG<17)&&(pixel92_diffB<17 )&&(pixel92_diffA<17)){
	    pixel_new += (pixel92)*(float)27.0; accumWeights += 27;
    }
    float pixel93_diffR = fabs(pixel93.x- (float)255);
    float pixel93_diffG = fabs(pixel93.y- (float)255);
    float pixel93_diffB = fabs(pixel93.z- (float)255);
    float pixel93_diffA = fabs(pixel93.w- (float)255);
   if ((pixel93_diffR<17)&& (pixel93_diffG<17)&&(pixel93_diffB<17 )&&(pixel93_diffA<17)){
	    pixel_new += (pixel93)*(float)19.0; accumWeights += 19;
    }
    float pixel94_diffR = fabs(pixel94.x- (float)255);
    float pixel94_diffG = fabs(pixel94.y- (float)255);
    float pixel94_diffB = fabs(pixel94.z- (float)255);
    float pixel94_diffA = fabs(pixel94.w- (float)255);
   if ((pixel94_diffR<17)&& (pixel94_diffG<17)&&(pixel94_diffB<17 )&&(pixel94_diffA<17)){
	    pixel_new += (pixel94)*(float)12.0; accumWeights += 12;
    }
    float pixel95_diffR = fabs(pixel95.x- (float)255);
    float pixel95_diffG = fabs(pixel95.y- (float)255);
    float pixel95_diffB = fabs(pixel95.z- (float)255);
    float pixel95_diffA = fabs(pixel95.w- (float)255);
   if ((pixel95_diffR<17)&& (pixel95_diffG<17)&&(pixel95_diffB<17 )&&(pixel95_diffA<17)){
	    pixel_new += (pixel95)*(float)7.0; accumWeights += 7;
    }
    float pixel96_diffR = fabs(pixel96.x- (float)255);
    float pixel96_diffG = fabs(pixel96.y- (float)255);
    float pixel96_diffB = fabs(pixel96.z- (float)255);
    float pixel96_diffA = fabs(pixel96.w- (float)255);
   if ((pixel96_diffR<17)&& (pixel96_diffG<17)&&(pixel96_diffB<17 )&&(pixel96_diffA<17)){
	    pixel_new += (pixel96)*(float)4.0; accumWeights += 4;
    }
    float pixel97_diffR = fabs(pixel97.x- (float)255);
    float pixel97_diffG = fabs(pixel97.y- (float)255);
    float pixel97_diffB = fabs(pixel97.z- (float)255);
    float pixel97_diffA = fabs(pixel97.w- (float)255);
   if ((pixel97_diffR<17)&& (pixel97_diffG<17)&&(pixel97_diffB<17 )&&(pixel97_diffA<17)){
	    pixel_new += (pixel97)*(float)2.0; accumWeights += 2;
    }
    float pixel98_diffR = fabs(pixel98.x- (float)255);
    float pixel98_diffG = fabs(pixel98.y- (float)255);
    float pixel98_diffB = fabs(pixel98.z- (float)255);
    float pixel98_diffA = fabs(pixel98.w- (float)255);
   if ((pixel98_diffR<17)&& (pixel98_diffG<17)&&(pixel98_diffB<17 )&&(pixel98_diffA<17)){
	    pixel_new += (pixel98)*(float)2.0; accumWeights += 2;
    }
    float pixel99_diffR = fabs(pixel99.x- (float)255);
    float pixel99_diffG = fabs(pixel99.y- (float)255);
    float pixel99_diffB = fabs(pixel99.z- (float)255);
    float pixel99_diffA = fabs(pixel99.w- (float)255);
   if ((pixel99_diffR<17)&& (pixel99_diffG<17)&&(pixel99_diffB<17 )&&(pixel99_diffA<17)){
	    pixel_new += (pixel99)*(float)5.0; accumWeights += 5;
    }
    float pixel100_diffR = fabs(pixel100.x- (float)255);
    float pixel100_diffG = fabs(pixel100.y- (float)255);
    float pixel100_diffB = fabs(pixel100.z- (float)255);
    float pixel100_diffA = fabs(pixel100.w- (float)255);
   if ((pixel100_diffR<17)&& (pixel100_diffG<17)&&(pixel100_diffB<17 )&&(pixel100_diffA<17)){
	    pixel_new += (pixel100)*(float)9.0; accumWeights += 9;
    }
    float pixel101_diffR = fabs(pixel101.x- (float)255);
    float pixel101_diffG = fabs(pixel101.y- (float)255);
    float pixel101_diffB = fabs(pixel101.z- (float)255);
    float pixel101_diffA = fabs(pixel101.w- (float)255);
   if ((pixel101_diffR<17)&& (pixel101_diffG<17)&&(pixel101_diffB<17 )&&(pixel101_diffA<17)){
	    pixel_new += (pixel101)*(float)16.0; accumWeights += 16;
    }
    float pixel102_diffR = fabs(pixel102.x- (float)255);
    float pixel102_diffG = fabs(pixel102.y- (float)255);
    float pixel102_diffB = fabs(pixel102.z- (float)255);
    float pixel102_diffA = fabs(pixel102.w- (float)255);
   if ((pixel102_diffR<17)&& (pixel102_diffG<17)&&(pixel102_diffB<17 )&&(pixel102_diffA<17)){
	    pixel_new += (pixel102)*(float)25.0; accumWeights += 25;
    }
    float pixel103_diffR = fabs(pixel103.x- (float)255);
    float pixel103_diffG = fabs(pixel103.y- (float)255);
    float pixel103_diffB = fabs(pixel103.z- (float)255);
    float pixel103_diffA = fabs(pixel103.w- (float)255);
   if ((pixel103_diffR<17)&& (pixel103_diffG<17)&&(pixel103_diffB<17 )&&(pixel103_diffA<17)){
	    pixel_new += (pixel103)*(float)36.0; accumWeights += 36;
    }
    float pixel104_diffR = fabs(pixel104.x- (float)255);
    float pixel104_diffG = fabs(pixel104.y- (float)255);
    float pixel104_diffB = fabs(pixel104.z- (float)255);
    float pixel104_diffA = fabs(pixel104.w- (float)255);
   if ((pixel104_diffR<17)&& (pixel104_diffG<17)&&(pixel104_diffB<17 )&&(pixel104_diffA<17)){
	    pixel_new += (pixel104)*(float)48.0; accumWeights += 48;
    }
    float pixel105_diffR = fabs(pixel105.x- (float)255);
    float pixel105_diffG = fabs(pixel105.y- (float)255);
    float pixel105_diffB = fabs(pixel105.z- (float)255);
    float pixel105_diffA = fabs(pixel105.w- (float)255);
   if ((pixel105_diffR<17)&& (pixel105_diffG<17)&&(pixel105_diffB<17 )&&(pixel105_diffA<17)){
	    pixel_new += (pixel105)*(float)59.0; accumWeights += 59;
    }
    float pixel106_diffR = fabs(pixel106.x- (float)255);
    float pixel106_diffG = fabs(pixel106.y- (float)255);
    float pixel106_diffB = fabs(pixel106.z- (float)255);
    float pixel106_diffA = fabs(pixel106.w- (float)255);
   if ((pixel106_diffR<17)&& (pixel106_diffG<17)&&(pixel106_diffB<17 )&&(pixel106_diffA<17)){
	    pixel_new += (pixel106)*(float)67.0; accumWeights += 67;
    }
    float pixel107_diffR = fabs(pixel107.x- (float)255);
    float pixel107_diffG = fabs(pixel107.y- (float)255);
    float pixel107_diffB = fabs(pixel107.z- (float)255);
    float pixel107_diffA = fabs(pixel107.w- (float)255);
   if ((pixel107_diffR<17)&& (pixel107_diffG<17)&&(pixel107_diffB<17 )&&(pixel107_diffA<17)){
	    pixel_new += (pixel107)*(float)69.0; accumWeights += 69;
    }
    float pixel108_diffR = fabs(pixel108.x- (float)255);
    float pixel108_diffG = fabs(pixel108.y- (float)255);
    float pixel108_diffB = fabs(pixel108.z- (float)255);
    float pixel108_diffA = fabs(pixel108.w- (float)255);
   if ((pixel108_diffR<17)&& (pixel108_diffG<17)&&(pixel108_diffB<17 )&&(pixel108_diffA<17)){
	    pixel_new += (pixel108)*(float)67.0; accumWeights += 67;
    }
    float pixel109_diffR = fabs(pixel109.x- (float)255);
    float pixel109_diffG = fabs(pixel109.y- (float)255);
    float pixel109_diffB = fabs(pixel109.z- (float)255);
    float pixel109_diffA = fabs(pixel109.w- (float)255);
   if ((pixel109_diffR<17)&& (pixel109_diffG<17)&&(pixel109_diffB<17 )&&(pixel109_diffA<17)){
	    pixel_new += (pixel109)*(float)59.0; accumWeights += 59;
    }
    float pixel110_diffR = fabs(pixel110.x- (float)255);
    float pixel110_diffG = fabs(pixel110.y- (float)255);
    float pixel110_diffB = fabs(pixel110.z- (float)255);
    float pixel110_diffA = fabs(pixel110.w- (float)255);
   if ((pixel110_diffR<17)&& (pixel110_diffG<17)&&(pixel110_diffB<17 )&&(pixel110_diffA<17)){
	    pixel_new += (pixel110)*(float)48.0; accumWeights += 48;
    }
    float pixel111_diffR = fabs(pixel111.x- (float)255);
    float pixel111_diffG = fabs(pixel111.y- (float)255);
    float pixel111_diffB = fabs(pixel111.z- (float)255);
    float pixel111_diffA = fabs(pixel111.w- (float)255);
   if ((pixel111_diffR<17)&& (pixel111_diffG<17)&&(pixel111_diffB<17 )&&(pixel111_diffA<17)){
	    pixel_new += (pixel111)*(float)36.0; accumWeights += 36;
    }
    float pixel112_diffR = fabs(pixel112.x- (float)255);
    float pixel112_diffG = fabs(pixel112.y- (float)255);
    float pixel112_diffB = fabs(pixel112.z- (float)255);
    float pixel112_diffA = fabs(pixel112.w- (float)255);
   if ((pixel112_diffR<17)&& (pixel112_diffG<17)&&(pixel112_diffB<17 )&&(pixel112_diffA<17)){
	    pixel_new += (pixel112)*(float)25.0; accumWeights += 25;
    }
    float pixel113_diffR = fabs(pixel113.x- (float)255);
    float pixel113_diffG = fabs(pixel113.y- (float)255);
    float pixel113_diffB = fabs(pixel113.z- (float)255);
    float pixel113_diffA = fabs(pixel113.w- (float)255);
   if ((pixel113_diffR<17)&& (pixel113_diffG<17)&&(pixel113_diffB<17 )&&(pixel113_diffA<17)){
	    pixel_new += (pixel113)*(float)16.0; accumWeights += 16;
    }
    float pixel114_diffR = fabs(pixel114.x- (float)255);
    float pixel114_diffG = fabs(pixel114.y- (float)255);
    float pixel114_diffB = fabs(pixel114.z- (float)255);
    float pixel114_diffA = fabs(pixel114.w- (float)255);
   if ((pixel114_diffR<17)&& (pixel114_diffG<17)&&(pixel114_diffB<17 )&&(pixel114_diffA<17)){
	    pixel_new += (pixel114)*(float)9.0; accumWeights += 9;
    }
    float pixel115_diffR = fabs(pixel115.x- (float)255);
    float pixel115_diffG = fabs(pixel115.y- (float)255);
    float pixel115_diffB = fabs(pixel115.z- (float)255);
    float pixel115_diffA = fabs(pixel115.w- (float)255);
   if ((pixel115_diffR<17)&& (pixel115_diffG<17)&&(pixel115_diffB<17 )&&(pixel115_diffA<17)){
	    pixel_new += (pixel115)*(float)5.0; accumWeights += 5;
    }
    float pixel116_diffR = fabs(pixel116.x- (float)255);
    float pixel116_diffG = fabs(pixel116.y- (float)255);
    float pixel116_diffB = fabs(pixel116.z- (float)255);
    float pixel116_diffA = fabs(pixel116.w- (float)255);
   if ((pixel116_diffR<17)&& (pixel116_diffG<17)&&(pixel116_diffB<17 )&&(pixel116_diffA<17)){
	    pixel_new += (pixel116)*(float)2.0; accumWeights += 2;
    }
    float pixel117_diffR = fabs(pixel117.x- (float)255);
    float pixel117_diffG = fabs(pixel117.y- (float)255);
    float pixel117_diffB = fabs(pixel117.z- (float)255);
    float pixel117_diffA = fabs(pixel117.w- (float)255);
   if ((pixel117_diffR<17)&& (pixel117_diffG<17)&&(pixel117_diffB<17 )&&(pixel117_diffA<17)){
	    pixel_new += (pixel117)*(float)3.0; accumWeights += 3;
    }
    float pixel118_diffR = fabs(pixel118.x- (float)255);
    float pixel118_diffG = fabs(pixel118.y- (float)255);
    float pixel118_diffB = fabs(pixel118.z- (float)255);
    float pixel118_diffA = fabs(pixel118.w- (float)255);
   if ((pixel118_diffR<17)&& (pixel118_diffG<17)&&(pixel118_diffB<17 )&&(pixel118_diffA<17)){
	    pixel_new += (pixel118)*(float)6.0; accumWeights += 6;
    }
    float pixel119_diffR = fabs(pixel119.x- (float)255);
    float pixel119_diffG = fabs(pixel119.y- (float)255);
    float pixel119_diffB = fabs(pixel119.z- (float)255);
    float pixel119_diffA = fabs(pixel119.w- (float)255);
   if ((pixel119_diffR<17)&& (pixel119_diffG<17)&&(pixel119_diffB<17 )&&(pixel119_diffA<17)){
	    pixel_new += (pixel119)*(float)12.0; accumWeights += 12;
    }
    float pixel120_diffR = fabs(pixel120.x- (float)255);
    float pixel120_diffG = fabs(pixel120.y- (float)255);
    float pixel120_diffB = fabs(pixel120.z- (float)255);
    float pixel120_diffA = fabs(pixel120.w- (float)255);
   if ((pixel120_diffR<17)&& (pixel120_diffG<17)&&(pixel120_diffB<17 )&&(pixel120_diffA<17)){
	    pixel_new += (pixel120)*(float)20.0; accumWeights += 20;
    }
    float pixel121_diffR = fabs(pixel121.x- (float)255);
    float pixel121_diffG = fabs(pixel121.y- (float)255);
    float pixel121_diffB = fabs(pixel121.z- (float)255);
    float pixel121_diffA = fabs(pixel121.w- (float)255);
   if ((pixel121_diffR<17)&& (pixel121_diffG<17)&&(pixel121_diffB<17 )&&(pixel121_diffA<17)){
	    pixel_new += (pixel121)*(float)31.0; accumWeights += 31;
    }
    float pixel122_diffR = fabs(pixel122.x- (float)255);
    float pixel122_diffG = fabs(pixel122.y- (float)255);
    float pixel122_diffB = fabs(pixel122.z- (float)255);
    float pixel122_diffA = fabs(pixel122.w- (float)255);
   if ((pixel122_diffR<17)&& (pixel122_diffG<17)&&(pixel122_diffB<17 )&&(pixel122_diffA<17)){
	    pixel_new += (pixel122)*(float)44.0; accumWeights += 44;
    }
    float pixel123_diffR = fabs(pixel123.x- (float)255);
    float pixel123_diffG = fabs(pixel123.y- (float)255);
    float pixel123_diffB = fabs(pixel123.z- (float)255);
    float pixel123_diffA = fabs(pixel123.w- (float)255);
   if ((pixel123_diffR<17)&& (pixel123_diffG<17)&&(pixel123_diffB<17 )&&(pixel123_diffA<17)){
	    pixel_new += (pixel123)*(float)59.0; accumWeights += 59;
    }
    float pixel124_diffR = fabs(pixel124.x- (float)255);
    float pixel124_diffG = fabs(pixel124.y- (float)255);
    float pixel124_diffB = fabs(pixel124.z- (float)255);
    float pixel124_diffA = fabs(pixel124.w- (float)255);
   if ((pixel124_diffR<17)&& (pixel124_diffG<17)&&(pixel124_diffB<17 )&&(pixel124_diffA<17)){
	    pixel_new += (pixel124)*(float)72.0; accumWeights += 72;
    }
    float pixel125_diffR = fabs(pixel125.x- (float)255);
    float pixel125_diffG = fabs(pixel125.y- (float)255);
    float pixel125_diffB = fabs(pixel125.z- (float)255);
    float pixel125_diffA = fabs(pixel125.w- (float)255);
   if ((pixel125_diffR<17)&& (pixel125_diffG<17)&&(pixel125_diffB<17 )&&(pixel125_diffA<17)){
	    pixel_new += (pixel125)*(float)81.0; accumWeights += 81;
    }
    float pixel126_diffR = fabs(pixel126.x- (float)255);
    float pixel126_diffG = fabs(pixel126.y- (float)255);
    float pixel126_diffB = fabs(pixel126.z- (float)255);
    float pixel126_diffA = fabs(pixel126.w- (float)255);
   if ((pixel126_diffR<17)&& (pixel126_diffG<17)&&(pixel126_diffB<17 )&&(pixel126_diffA<17)){
	    pixel_new += (pixel126)*(float)85.0; accumWeights += 85;
    }
    float pixel127_diffR = fabs(pixel127.x- (float)255);
    float pixel127_diffG = fabs(pixel127.y- (float)255);
    float pixel127_diffB = fabs(pixel127.z- (float)255);
    float pixel127_diffA = fabs(pixel127.w- (float)255);
   if ((pixel127_diffR<17)&& (pixel127_diffG<17)&&(pixel127_diffB<17 )&&(pixel127_diffA<17)){
	    pixel_new += (pixel127)*(float)81.0; accumWeights += 81;
    }
    float pixel128_diffR = fabs(pixel128.x- (float)255);
    float pixel128_diffG = fabs(pixel128.y- (float)255);
    float pixel128_diffB = fabs(pixel128.z- (float)255);
    float pixel128_diffA = fabs(pixel128.w- (float)255);
   if ((pixel128_diffR<17)&& (pixel128_diffG<17)&&(pixel128_diffB<17 )&&(pixel128_diffA<17)){
	    pixel_new += (pixel128)*(float)72.0; accumWeights += 72;
    }
    float pixel129_diffR = fabs(pixel129.x- (float)255);
    float pixel129_diffG = fabs(pixel129.y- (float)255);
    float pixel129_diffB = fabs(pixel129.z- (float)255);
    float pixel129_diffA = fabs(pixel129.w- (float)255);
   if ((pixel129_diffR<17)&& (pixel129_diffG<17)&&(pixel129_diffB<17 )&&(pixel129_diffA<17)){
	    pixel_new += (pixel129)*(float)59.0; accumWeights += 59;
    }
    float pixel130_diffR = fabs(pixel130.x- (float)255);
    float pixel130_diffG = fabs(pixel130.y- (float)255);
    float pixel130_diffB = fabs(pixel130.z- (float)255);
    float pixel130_diffA = fabs(pixel130.w- (float)255);
   if ((pixel130_diffR<17)&& (pixel130_diffG<17)&&(pixel130_diffB<17 )&&(pixel130_diffA<17)){
	    pixel_new += (pixel130)*(float)44.0; accumWeights += 44;
    }
    float pixel131_diffR = fabs(pixel131.x- (float)255);
    float pixel131_diffG = fabs(pixel131.y- (float)255);
    float pixel131_diffB = fabs(pixel131.z- (float)255);
    float pixel131_diffA = fabs(pixel131.w- (float)255);
   if ((pixel131_diffR<17)&& (pixel131_diffG<17)&&(pixel131_diffB<17 )&&(pixel131_diffA<17)){
	    pixel_new += (pixel131)*(float)31.0; accumWeights += 31;
    }
    float pixel132_diffR = fabs(pixel132.x- (float)255);
    float pixel132_diffG = fabs(pixel132.y- (float)255);
    float pixel132_diffB = fabs(pixel132.z- (float)255);
    float pixel132_diffA = fabs(pixel132.w- (float)255);
   if ((pixel132_diffR<17)&& (pixel132_diffG<17)&&(pixel132_diffB<17 )&&(pixel132_diffA<17)){
	    pixel_new += (pixel132)*(float)20.0; accumWeights += 20;
    }
    float pixel133_diffR = fabs(pixel133.x- (float)255);
    float pixel133_diffG = fabs(pixel133.y- (float)255);
    float pixel133_diffB = fabs(pixel133.z- (float)255);
    float pixel133_diffA = fabs(pixel133.w- (float)255);
   if ((pixel133_diffR<17)&& (pixel133_diffG<17)&&(pixel133_diffB<17 )&&(pixel133_diffA<17)){
	    pixel_new += (pixel133)*(float)12.0; accumWeights += 12;
    }
    float pixel134_diffR = fabs(pixel134.x- (float)255);
    float pixel134_diffG = fabs(pixel134.y- (float)255);
    float pixel134_diffB = fabs(pixel134.z- (float)255);
    float pixel134_diffA = fabs(pixel134.w- (float)255);
   if ((pixel134_diffR<17)&& (pixel134_diffG<17)&&(pixel134_diffB<17 )&&(pixel134_diffA<17)){
	    pixel_new += (pixel134)*(float)6.0; accumWeights += 6;
    }
    float pixel135_diffR = fabs(pixel135.x- (float)255);
    float pixel135_diffG = fabs(pixel135.y- (float)255);
    float pixel135_diffB = fabs(pixel135.z- (float)255);
    float pixel135_diffA = fabs(pixel135.w- (float)255);
   if ((pixel135_diffR<17)&& (pixel135_diffG<17)&&(pixel135_diffB<17 )&&(pixel135_diffA<17)){
	    pixel_new += (pixel135)*(float)3.0; accumWeights += 3;
    }
    float pixel136_diffR = fabs(pixel136.x- (float)255);
    float pixel136_diffG = fabs(pixel136.y- (float)255);
    float pixel136_diffB = fabs(pixel136.z- (float)255);
    float pixel136_diffA = fabs(pixel136.w- (float)255);
   if ((pixel136_diffR<17)&& (pixel136_diffG<17)&&(pixel136_diffB<17 )&&(pixel136_diffA<17)){
	    pixel_new += (pixel136)*(float)3.0; accumWeights += 3;
    }
    float pixel137_diffR = fabs(pixel137.x- (float)255);
    float pixel137_diffG = fabs(pixel137.y- (float)255);
    float pixel137_diffB = fabs(pixel137.z- (float)255);
    float pixel137_diffA = fabs(pixel137.w- (float)255);
   if ((pixel137_diffR<17)&& (pixel137_diffG<17)&&(pixel137_diffB<17 )&&(pixel137_diffA<17)){
	    pixel_new += (pixel137)*(float)7.0; accumWeights += 7;
    }
    float pixel138_diffR = fabs(pixel138.x- (float)255);
    float pixel138_diffG = fabs(pixel138.y- (float)255);
    float pixel138_diffB = fabs(pixel138.z- (float)255);
    float pixel138_diffA = fabs(pixel138.w- (float)255);
   if ((pixel138_diffR<17)&& (pixel138_diffG<17)&&(pixel138_diffB<17 )&&(pixel138_diffA<17)){
	    pixel_new += (pixel138)*(float)13.0; accumWeights += 13;
    }
    float pixel139_diffR = fabs(pixel139.x- (float)255);
    float pixel139_diffG = fabs(pixel139.y- (float)255);
    float pixel139_diffB = fabs(pixel139.z- (float)255);
    float pixel139_diffA = fabs(pixel139.w- (float)255);
   if ((pixel139_diffR<17)&& (pixel139_diffG<17)&&(pixel139_diffB<17 )&&(pixel139_diffA<17)){
	    pixel_new += (pixel139)*(float)22.0; accumWeights += 22;
    }
    float pixel140_diffR = fabs(pixel140.x- (float)255);
    float pixel140_diffG = fabs(pixel140.y- (float)255);
    float pixel140_diffB = fabs(pixel140.z- (float)255);
    float pixel140_diffA = fabs(pixel140.w- (float)255);
   if ((pixel140_diffR<17)&& (pixel140_diffG<17)&&(pixel140_diffB<17 )&&(pixel140_diffA<17)){
	    pixel_new += (pixel140)*(float)35.0; accumWeights += 35;
    }
    float pixel141_diffR = fabs(pixel141.x- (float)255);
    float pixel141_diffG = fabs(pixel141.y- (float)255);
    float pixel141_diffB = fabs(pixel141.z- (float)255);
    float pixel141_diffA = fabs(pixel141.w- (float)255);
   if ((pixel141_diffR<17)&& (pixel141_diffG<17)&&(pixel141_diffB<17 )&&(pixel141_diffA<17)){
	    pixel_new += (pixel141)*(float)50.0; accumWeights += 50;
    }
    float pixel142_diffR = fabs(pixel142.x- (float)255);
    float pixel142_diffG = fabs(pixel142.y- (float)255);
    float pixel142_diffB = fabs(pixel142.z- (float)255);
    float pixel142_diffA = fabs(pixel142.w- (float)255);
   if ((pixel142_diffR<17)&& (pixel142_diffG<17)&&(pixel142_diffB<17 )&&(pixel142_diffA<17)){
	    pixel_new += (pixel142)*(float)67.0; accumWeights += 67;
    }
    float pixel143_diffR = fabs(pixel143.x- (float)255);
    float pixel143_diffG = fabs(pixel143.y- (float)255);
    float pixel143_diffB = fabs(pixel143.z- (float)255);
    float pixel143_diffA = fabs(pixel143.w- (float)255);
   if ((pixel143_diffR<17)&& (pixel143_diffG<17)&&(pixel143_diffB<17 )&&(pixel143_diffA<17)){
	    pixel_new += (pixel143)*(float)81.0; accumWeights += 81;
    }
    float pixel144_diffR = fabs(pixel144.x- (float)255);
    float pixel144_diffG = fabs(pixel144.y- (float)255);
    float pixel144_diffB = fabs(pixel144.z- (float)255);
    float pixel144_diffA = fabs(pixel144.w- (float)255);
   if ((pixel144_diffR<17)&& (pixel144_diffG<17)&&(pixel144_diffB<17 )&&(pixel144_diffA<17)){
	    pixel_new += (pixel144)*(float)92.0; accumWeights += 92;
    }
    float pixel145_diffR = fabs(pixel145.x- (float)255);
    float pixel145_diffG = fabs(pixel145.y- (float)255);
    float pixel145_diffB = fabs(pixel145.z- (float)255);
    float pixel145_diffA = fabs(pixel145.w- (float)255);
   if ((pixel145_diffR<17)&& (pixel145_diffG<17)&&(pixel145_diffB<17 )&&(pixel145_diffA<17)){
	    pixel_new += (pixel145)*(float)96.0; accumWeights += 96;
    }
    float pixel146_diffR = fabs(pixel146.x- (float)255);
    float pixel146_diffG = fabs(pixel146.y- (float)255);
    float pixel146_diffB = fabs(pixel146.z- (float)255);
    float pixel146_diffA = fabs(pixel146.w- (float)255);
   if ((pixel146_diffR<17)&& (pixel146_diffG<17)&&(pixel146_diffB<17 )&&(pixel146_diffA<17)){
	    pixel_new += (pixel146)*(float)92.0; accumWeights += 92;
    }
    float pixel147_diffR = fabs(pixel147.x- (float)255);
    float pixel147_diffG = fabs(pixel147.y- (float)255);
    float pixel147_diffB = fabs(pixel147.z- (float)255);
    float pixel147_diffA = fabs(pixel147.w- (float)255);
   if ((pixel147_diffR<17)&& (pixel147_diffG<17)&&(pixel147_diffB<17 )&&(pixel147_diffA<17)){
	    pixel_new += (pixel147)*(float)81.0; accumWeights += 81;
    }
    float pixel148_diffR = fabs(pixel148.x- (float)255);
    float pixel148_diffG = fabs(pixel148.y- (float)255);
    float pixel148_diffB = fabs(pixel148.z- (float)255);
    float pixel148_diffA = fabs(pixel148.w- (float)255);
   if ((pixel148_diffR<17)&& (pixel148_diffG<17)&&(pixel148_diffB<17 )&&(pixel148_diffA<17)){
	    pixel_new += (pixel148)*(float)67.0; accumWeights += 67;
    }
    float pixel149_diffR = fabs(pixel149.x- (float)255);
    float pixel149_diffG = fabs(pixel149.y- (float)255);
    float pixel149_diffB = fabs(pixel149.z- (float)255);
    float pixel149_diffA = fabs(pixel149.w- (float)255);
   if ((pixel149_diffR<17)&& (pixel149_diffG<17)&&(pixel149_diffB<17 )&&(pixel149_diffA<17)){
	    pixel_new += (pixel149)*(float)50.0; accumWeights += 50;
    }
    float pixel150_diffR = fabs(pixel150.x- (float)255);
    float pixel150_diffG = fabs(pixel150.y- (float)255);
    float pixel150_diffB = fabs(pixel150.z- (float)255);
    float pixel150_diffA = fabs(pixel150.w- (float)255);
   if ((pixel150_diffR<17)&& (pixel150_diffG<17)&&(pixel150_diffB<17 )&&(pixel150_diffA<17)){
	    pixel_new += (pixel150)*(float)35.0; accumWeights += 35;
    }
    float pixel151_diffR = fabs(pixel151.x- (float)255);
    float pixel151_diffG = fabs(pixel151.y- (float)255);
    float pixel151_diffB = fabs(pixel151.z- (float)255);
    float pixel151_diffA = fabs(pixel151.w- (float)255);
   if ((pixel151_diffR<17)&& (pixel151_diffG<17)&&(pixel151_diffB<17 )&&(pixel151_diffA<17)){
	    pixel_new += (pixel151)*(float)22.0; accumWeights += 22;
    }
    float pixel152_diffR = fabs(pixel152.x- (float)255);
    float pixel152_diffG = fabs(pixel152.y- (float)255);
    float pixel152_diffB = fabs(pixel152.z- (float)255);
    float pixel152_diffA = fabs(pixel152.w- (float)255);
   if ((pixel152_diffR<17)&& (pixel152_diffG<17)&&(pixel152_diffB<17 )&&(pixel152_diffA<17)){
	    pixel_new += (pixel152)*(float)13.0; accumWeights += 13;
    }
    float pixel153_diffR = fabs(pixel153.x- (float)255);
    float pixel153_diffG = fabs(pixel153.y- (float)255);
    float pixel153_diffB = fabs(pixel153.z- (float)255);
    float pixel153_diffA = fabs(pixel153.w- (float)255);
   if ((pixel153_diffR<17)&& (pixel153_diffG<17)&&(pixel153_diffB<17 )&&(pixel153_diffA<17)){
	    pixel_new += (pixel153)*(float)7.0; accumWeights += 7;
    }
    float pixel154_diffR = fabs(pixel154.x- (float)255);
    float pixel154_diffG = fabs(pixel154.y- (float)255);
    float pixel154_diffB = fabs(pixel154.z- (float)255);
    float pixel154_diffA = fabs(pixel154.w- (float)255);
   if ((pixel154_diffR<17)&& (pixel154_diffG<17)&&(pixel154_diffB<17 )&&(pixel154_diffA<17)){
	    pixel_new += (pixel154)*(float)3.0; accumWeights += 3;
    }
    float pixel155_diffR = fabs(pixel155.x- (float)255);
    float pixel155_diffG = fabs(pixel155.y- (float)255);
    float pixel155_diffB = fabs(pixel155.z- (float)255);
    float pixel155_diffA = fabs(pixel155.w- (float)255);
   if ((pixel155_diffR<17)&& (pixel155_diffG<17)&&(pixel155_diffB<17 )&&(pixel155_diffA<17)){
	    pixel_new += (pixel155)*(float)3.0; accumWeights += 3;
    }
    float pixel156_diffR = fabs(pixel156.x- (float)255);
    float pixel156_diffG = fabs(pixel156.y- (float)255);
    float pixel156_diffB = fabs(pixel156.z- (float)255);
    float pixel156_diffA = fabs(pixel156.w- (float)255);
   if ((pixel156_diffR<17)&& (pixel156_diffG<17)&&(pixel156_diffB<17 )&&(pixel156_diffA<17)){
	    pixel_new += (pixel156)*(float)7.0; accumWeights += 7;
    }
    float pixel157_diffR = fabs(pixel157.x- (float)255);
    float pixel157_diffG = fabs(pixel157.y- (float)255);
    float pixel157_diffB = fabs(pixel157.z- (float)255);
    float pixel157_diffA = fabs(pixel157.w- (float)255);
   if ((pixel157_diffR<17)&& (pixel157_diffG<17)&&(pixel157_diffB<17 )&&(pixel157_diffA<17)){
	    pixel_new += (pixel157)*(float)14.0; accumWeights += 14;
    }
    float pixel158_diffR = fabs(pixel158.x- (float)255);
    float pixel158_diffG = fabs(pixel158.y- (float)255);
    float pixel158_diffB = fabs(pixel158.z- (float)255);
    float pixel158_diffA = fabs(pixel158.w- (float)255);
   if ((pixel158_diffR<17)&& (pixel158_diffG<17)&&(pixel158_diffB<17 )&&(pixel158_diffA<17)){
	    pixel_new += (pixel158)*(float)23.0; accumWeights += 23;
    }
    float pixel159_diffR = fabs(pixel159.x- (float)255);
    float pixel159_diffG = fabs(pixel159.y- (float)255);
    float pixel159_diffB = fabs(pixel159.z- (float)255);
    float pixel159_diffA = fabs(pixel159.w- (float)255);
   if ((pixel159_diffR<17)&& (pixel159_diffG<17)&&(pixel159_diffB<17 )&&(pixel159_diffA<17)){
	    pixel_new += (pixel159)*(float)36.0; accumWeights += 36;
    }
    float pixel160_diffR = fabs(pixel160.x- (float)255);
    float pixel160_diffG = fabs(pixel160.y- (float)255);
    float pixel160_diffB = fabs(pixel160.z- (float)255);
    float pixel160_diffA = fabs(pixel160.w- (float)255);
   if ((pixel160_diffR<17)&& (pixel160_diffG<17)&&(pixel160_diffB<17 )&&(pixel160_diffA<17)){
	    pixel_new += (pixel160)*(float)52.0; accumWeights += 52;
    }
    float pixel161_diffR = fabs(pixel161.x- (float)255);
    float pixel161_diffG = fabs(pixel161.y- (float)255);
    float pixel161_diffB = fabs(pixel161.z- (float)255);
    float pixel161_diffA = fabs(pixel161.w- (float)255);
   if ((pixel161_diffR<17)&& (pixel161_diffG<17)&&(pixel161_diffB<17 )&&(pixel161_diffA<17)){
	    pixel_new += (pixel161)*(float)69.0; accumWeights += 69;
    }
    float pixel162_diffR = fabs(pixel162.x- (float)255);
    float pixel162_diffG = fabs(pixel162.y- (float)255);
    float pixel162_diffB = fabs(pixel162.z- (float)255);
    float pixel162_diffA = fabs(pixel162.w- (float)255);
   if ((pixel162_diffR<17)&& (pixel162_diffG<17)&&(pixel162_diffB<17 )&&(pixel162_diffA<17)){
	    pixel_new += (pixel162)*(float)85.0; accumWeights += 85;
    }
    float pixel163_diffR = fabs(pixel163.x- (float)255);
    float pixel163_diffG = fabs(pixel163.y- (float)255);
    float pixel163_diffB = fabs(pixel163.z- (float)255);
    float pixel163_diffA = fabs(pixel163.w- (float)255);
   if ((pixel163_diffR<17)&& (pixel163_diffG<17)&&(pixel163_diffB<17 )&&(pixel163_diffA<17)){
	    pixel_new += (pixel163)*(float)96.0; accumWeights += 96;
    }
    float pixel164_diffR = fabs(pixel164.x- (float)255);
    float pixel164_diffG = fabs(pixel164.y- (float)255);
    float pixel164_diffB = fabs(pixel164.z- (float)255);
    float pixel164_diffA = fabs(pixel164.w- (float)255);
   if ((pixel164_diffR<17)&& (pixel164_diffG<17)&&(pixel164_diffB<17 )&&(pixel164_diffA<17)){
	    pixel_new += (pixel164)*(float)100.0; accumWeights += 100;
    }
    float pixel165_diffR = fabs(pixel165.x- (float)255);
    float pixel165_diffG = fabs(pixel165.y- (float)255);
    float pixel165_diffB = fabs(pixel165.z- (float)255);
    float pixel165_diffA = fabs(pixel165.w- (float)255);
   if ((pixel165_diffR<17)&& (pixel165_diffG<17)&&(pixel165_diffB<17 )&&(pixel165_diffA<17)){
	    pixel_new += (pixel165)*(float)96.0; accumWeights += 96;
    }
    float pixel166_diffR = fabs(pixel166.x- (float)255);
    float pixel166_diffG = fabs(pixel166.y- (float)255);
    float pixel166_diffB = fabs(pixel166.z- (float)255);
    float pixel166_diffA = fabs(pixel166.w- (float)255);
   if ((pixel166_diffR<17)&& (pixel166_diffG<17)&&(pixel166_diffB<17 )&&(pixel166_diffA<17)){
	    pixel_new += (pixel166)*(float)85.0; accumWeights += 85;
    }
    float pixel167_diffR = fabs(pixel167.x- (float)255);
    float pixel167_diffG = fabs(pixel167.y- (float)255);
    float pixel167_diffB = fabs(pixel167.z- (float)255);
    float pixel167_diffA = fabs(pixel167.w- (float)255);
   if ((pixel167_diffR<17)&& (pixel167_diffG<17)&&(pixel167_diffB<17 )&&(pixel167_diffA<17)){
	    pixel_new += (pixel167)*(float)69.0; accumWeights += 69;
    }
    float pixel168_diffR = fabs(pixel168.x- (float)255);
    float pixel168_diffG = fabs(pixel168.y- (float)255);
    float pixel168_diffB = fabs(pixel168.z- (float)255);
    float pixel168_diffA = fabs(pixel168.w- (float)255);
   if ((pixel168_diffR<17)&& (pixel168_diffG<17)&&(pixel168_diffB<17 )&&(pixel168_diffA<17)){
	    pixel_new += (pixel168)*(float)52.0; accumWeights += 52;
    }
    float pixel169_diffR = fabs(pixel169.x- (float)255);
    float pixel169_diffG = fabs(pixel169.y- (float)255);
    float pixel169_diffB = fabs(pixel169.z- (float)255);
    float pixel169_diffA = fabs(pixel169.w- (float)255);
   if ((pixel169_diffR<17)&& (pixel169_diffG<17)&&(pixel169_diffB<17 )&&(pixel169_diffA<17)){
	    pixel_new += (pixel169)*(float)36.0; accumWeights += 36;
    }
    float pixel170_diffR = fabs(pixel170.x- (float)255);
    float pixel170_diffG = fabs(pixel170.y- (float)255);
    float pixel170_diffB = fabs(pixel170.z- (float)255);
    float pixel170_diffA = fabs(pixel170.w- (float)255);
   if ((pixel170_diffR<17)&& (pixel170_diffG<17)&&(pixel170_diffB<17 )&&(pixel170_diffA<17)){
	    pixel_new += (pixel170)*(float)23.0; accumWeights += 23;
    }
    float pixel171_diffR = fabs(pixel171.x- (float)255);
    float pixel171_diffG = fabs(pixel171.y- (float)255);
    float pixel171_diffB = fabs(pixel171.z- (float)255);
    float pixel171_diffA = fabs(pixel171.w- (float)255);
   if ((pixel171_diffR<17)&& (pixel171_diffG<17)&&(pixel171_diffB<17 )&&(pixel171_diffA<17)){
	    pixel_new += (pixel171)*(float)14.0; accumWeights += 14;
    }
    float pixel172_diffR = fabs(pixel172.x- (float)255);
    float pixel172_diffG = fabs(pixel172.y- (float)255);
    float pixel172_diffB = fabs(pixel172.z- (float)255);
    float pixel172_diffA = fabs(pixel172.w- (float)255);
   if ((pixel172_diffR<17)&& (pixel172_diffG<17)&&(pixel172_diffB<17 )&&(pixel172_diffA<17)){
	    pixel_new += (pixel172)*(float)7.0; accumWeights += 7;
    }
    float pixel173_diffR = fabs(pixel173.x- (float)255);
    float pixel173_diffG = fabs(pixel173.y- (float)255);
    float pixel173_diffB = fabs(pixel173.z- (float)255);
    float pixel173_diffA = fabs(pixel173.w- (float)255);
   if ((pixel173_diffR<17)&& (pixel173_diffG<17)&&(pixel173_diffB<17 )&&(pixel173_diffA<17)){
	    pixel_new += (pixel173)*(float)3.0; accumWeights += 3;
    }
    float pixel174_diffR = fabs(pixel174.x- (float)255);
    float pixel174_diffG = fabs(pixel174.y- (float)255);
    float pixel174_diffB = fabs(pixel174.z- (float)255);
    float pixel174_diffA = fabs(pixel174.w- (float)255);
   if ((pixel174_diffR<17)&& (pixel174_diffG<17)&&(pixel174_diffB<17 )&&(pixel174_diffA<17)){
	    pixel_new += (pixel174)*(float)3.0; accumWeights += 3;
    }
    float pixel175_diffR = fabs(pixel175.x- (float)255);
    float pixel175_diffG = fabs(pixel175.y- (float)255);
    float pixel175_diffB = fabs(pixel175.z- (float)255);
    float pixel175_diffA = fabs(pixel175.w- (float)255);
   if ((pixel175_diffR<17)&& (pixel175_diffG<17)&&(pixel175_diffB<17 )&&(pixel175_diffA<17)){
	    pixel_new += (pixel175)*(float)7.0; accumWeights += 7;
    }
    float pixel176_diffR = fabs(pixel176.x- (float)255);
    float pixel176_diffG = fabs(pixel176.y- (float)255);
    float pixel176_diffB = fabs(pixel176.z- (float)255);
    float pixel176_diffA = fabs(pixel176.w- (float)255);
   if ((pixel176_diffR<17)&& (pixel176_diffG<17)&&(pixel176_diffB<17 )&&(pixel176_diffA<17)){
	    pixel_new += (pixel176)*(float)13.0; accumWeights += 13;
    }
    float pixel177_diffR = fabs(pixel177.x- (float)255);
    float pixel177_diffG = fabs(pixel177.y- (float)255);
    float pixel177_diffB = fabs(pixel177.z- (float)255);
    float pixel177_diffA = fabs(pixel177.w- (float)255);
   if ((pixel177_diffR<17)&& (pixel177_diffG<17)&&(pixel177_diffB<17 )&&(pixel177_diffA<17)){
	    pixel_new += (pixel177)*(float)22.0; accumWeights += 22;
    }
    float pixel178_diffR = fabs(pixel178.x- (float)255);
    float pixel178_diffG = fabs(pixel178.y- (float)255);
    float pixel178_diffB = fabs(pixel178.z- (float)255);
    float pixel178_diffA = fabs(pixel178.w- (float)255);
   if ((pixel178_diffR<17)&& (pixel178_diffG<17)&&(pixel178_diffB<17 )&&(pixel178_diffA<17)){
	    pixel_new += (pixel178)*(float)35.0; accumWeights += 35;
    }
    float pixel179_diffR = fabs(pixel179.x- (float)255);
    float pixel179_diffG = fabs(pixel179.y- (float)255);
    float pixel179_diffB = fabs(pixel179.z- (float)255);
    float pixel179_diffA = fabs(pixel179.w- (float)255);
   if ((pixel179_diffR<17)&& (pixel179_diffG<17)&&(pixel179_diffB<17 )&&(pixel179_diffA<17)){
	    pixel_new += (pixel179)*(float)50.0; accumWeights += 50;
    }
    float pixel180_diffR = fabs(pixel180.x- (float)255);
    float pixel180_diffG = fabs(pixel180.y- (float)255);
    float pixel180_diffB = fabs(pixel180.z- (float)255);
    float pixel180_diffA = fabs(pixel180.w- (float)255);
   if ((pixel180_diffR<17)&& (pixel180_diffG<17)&&(pixel180_diffB<17 )&&(pixel180_diffA<17)){
	    pixel_new += (pixel180)*(float)67.0; accumWeights += 67;
    }
    float pixel181_diffR = fabs(pixel181.x- (float)255);
    float pixel181_diffG = fabs(pixel181.y- (float)255);
    float pixel181_diffB = fabs(pixel181.z- (float)255);
    float pixel181_diffA = fabs(pixel181.w- (float)255);
   if ((pixel181_diffR<17)&& (pixel181_diffG<17)&&(pixel181_diffB<17 )&&(pixel181_diffA<17)){
	    pixel_new += (pixel181)*(float)81.0; accumWeights += 81;
    }
    float pixel182_diffR = fabs(pixel182.x- (float)255);
    float pixel182_diffG = fabs(pixel182.y- (float)255);
    float pixel182_diffB = fabs(pixel182.z- (float)255);
    float pixel182_diffA = fabs(pixel182.w- (float)255);
   if ((pixel182_diffR<17)&& (pixel182_diffG<17)&&(pixel182_diffB<17 )&&(pixel182_diffA<17)){
	    pixel_new += (pixel182)*(float)92.0; accumWeights += 92;
    }
    float pixel183_diffR = fabs(pixel183.x- (float)255);
    float pixel183_diffG = fabs(pixel183.y- (float)255);
    float pixel183_diffB = fabs(pixel183.z- (float)255);
    float pixel183_diffA = fabs(pixel183.w- (float)255);
   if ((pixel183_diffR<17)&& (pixel183_diffG<17)&&(pixel183_diffB<17 )&&(pixel183_diffA<17)){
	    pixel_new += (pixel183)*(float)96.0; accumWeights += 96;
    }
    float pixel184_diffR = fabs(pixel184.x- (float)255);
    float pixel184_diffG = fabs(pixel184.y- (float)255);
    float pixel184_diffB = fabs(pixel184.z- (float)255);
    float pixel184_diffA = fabs(pixel184.w- (float)255);
   if ((pixel184_diffR<17)&& (pixel184_diffG<17)&&(pixel184_diffB<17 )&&(pixel184_diffA<17)){
	    pixel_new += (pixel184)*(float)92.0; accumWeights += 92;
    }
    float pixel185_diffR = fabs(pixel185.x- (float)255);
    float pixel185_diffG = fabs(pixel185.y- (float)255);
    float pixel185_diffB = fabs(pixel185.z- (float)255);
    float pixel185_diffA = fabs(pixel185.w- (float)255);
   if ((pixel185_diffR<17)&& (pixel185_diffG<17)&&(pixel185_diffB<17 )&&(pixel185_diffA<17)){
	    pixel_new += (pixel185)*(float)81.0; accumWeights += 81;
    }
    float pixel186_diffR = fabs(pixel186.x- (float)255);
    float pixel186_diffG = fabs(pixel186.y- (float)255);
    float pixel186_diffB = fabs(pixel186.z- (float)255);
    float pixel186_diffA = fabs(pixel186.w- (float)255);
   if ((pixel186_diffR<17)&& (pixel186_diffG<17)&&(pixel186_diffB<17 )&&(pixel186_diffA<17)){
	    pixel_new += (pixel186)*(float)67.0; accumWeights += 67;
    }
    float pixel187_diffR = fabs(pixel187.x- (float)255);
    float pixel187_diffG = fabs(pixel187.y- (float)255);
    float pixel187_diffB = fabs(pixel187.z- (float)255);
    float pixel187_diffA = fabs(pixel187.w- (float)255);
   if ((pixel187_diffR<17)&& (pixel187_diffG<17)&&(pixel187_diffB<17 )&&(pixel187_diffA<17)){
	    pixel_new += (pixel187)*(float)50.0; accumWeights += 50;
    }
    float pixel188_diffR = fabs(pixel188.x- (float)255);
    float pixel188_diffG = fabs(pixel188.y- (float)255);
    float pixel188_diffB = fabs(pixel188.z- (float)255);
    float pixel188_diffA = fabs(pixel188.w- (float)255);
   if ((pixel188_diffR<17)&& (pixel188_diffG<17)&&(pixel188_diffB<17 )&&(pixel188_diffA<17)){
	    pixel_new += (pixel188)*(float)35.0; accumWeights += 35;
    }
    float pixel189_diffR = fabs(pixel189.x- (float)255);
    float pixel189_diffG = fabs(pixel189.y- (float)255);
    float pixel189_diffB = fabs(pixel189.z- (float)255);
    float pixel189_diffA = fabs(pixel189.w- (float)255);
   if ((pixel189_diffR<17)&& (pixel189_diffG<17)&&(pixel189_diffB<17 )&&(pixel189_diffA<17)){
	    pixel_new += (pixel189)*(float)22.0; accumWeights += 22;
    }
    float pixel190_diffR = fabs(pixel190.x- (float)255);
    float pixel190_diffG = fabs(pixel190.y- (float)255);
    float pixel190_diffB = fabs(pixel190.z- (float)255);
    float pixel190_diffA = fabs(pixel190.w- (float)255);
   if ((pixel190_diffR<17)&& (pixel190_diffG<17)&&(pixel190_diffB<17 )&&(pixel190_diffA<17)){
	    pixel_new += (pixel190)*(float)13.0; accumWeights += 13;
    }
    float pixel191_diffR = fabs(pixel191.x- (float)255);
    float pixel191_diffG = fabs(pixel191.y- (float)255);
    float pixel191_diffB = fabs(pixel191.z- (float)255);
    float pixel191_diffA = fabs(pixel191.w- (float)255);
   if ((pixel191_diffR<17)&& (pixel191_diffG<17)&&(pixel191_diffB<17 )&&(pixel191_diffA<17)){
	    pixel_new += (pixel191)*(float)7.0; accumWeights += 7;
    }
    float pixel192_diffR = fabs(pixel192.x- (float)255);
    float pixel192_diffG = fabs(pixel192.y- (float)255);
    float pixel192_diffB = fabs(pixel192.z- (float)255);
    float pixel192_diffA = fabs(pixel192.w- (float)255);
   if ((pixel192_diffR<17)&& (pixel192_diffG<17)&&(pixel192_diffB<17 )&&(pixel192_diffA<17)){
	    pixel_new += (pixel192)*(float)3.0; accumWeights += 3;
    }
    float pixel193_diffR = fabs(pixel193.x- (float)255);
    float pixel193_diffG = fabs(pixel193.y- (float)255);
    float pixel193_diffB = fabs(pixel193.z- (float)255);
    float pixel193_diffA = fabs(pixel193.w- (float)255);
   if ((pixel193_diffR<17)&& (pixel193_diffG<17)&&(pixel193_diffB<17 )&&(pixel193_diffA<17)){
	    pixel_new += (pixel193)*(float)3.0; accumWeights += 3;
    }
    float pixel194_diffR = fabs(pixel194.x- (float)255);
    float pixel194_diffG = fabs(pixel194.y- (float)255);
    float pixel194_diffB = fabs(pixel194.z- (float)255);
    float pixel194_diffA = fabs(pixel194.w- (float)255);
   if ((pixel194_diffR<17)&& (pixel194_diffG<17)&&(pixel194_diffB<17 )&&(pixel194_diffA<17)){
	    pixel_new += (pixel194)*(float)6.0; accumWeights += 6;
    }
    float pixel195_diffR = fabs(pixel195.x- (float)255);
    float pixel195_diffG = fabs(pixel195.y- (float)255);
    float pixel195_diffB = fabs(pixel195.z- (float)255);
    float pixel195_diffA = fabs(pixel195.w- (float)255);
   if ((pixel195_diffR<17)&& (pixel195_diffG<17)&&(pixel195_diffB<17 )&&(pixel195_diffA<17)){
	    pixel_new += (pixel195)*(float)12.0; accumWeights += 12;
    }
    float pixel196_diffR = fabs(pixel196.x- (float)255);
    float pixel196_diffG = fabs(pixel196.y- (float)255);
    float pixel196_diffB = fabs(pixel196.z- (float)255);
    float pixel196_diffA = fabs(pixel196.w- (float)255);
   if ((pixel196_diffR<17)&& (pixel196_diffG<17)&&(pixel196_diffB<17 )&&(pixel196_diffA<17)){
	    pixel_new += (pixel196)*(float)20.0; accumWeights += 20;
    }
    float pixel197_diffR = fabs(pixel197.x- (float)255);
    float pixel197_diffG = fabs(pixel197.y- (float)255);
    float pixel197_diffB = fabs(pixel197.z- (float)255);
    float pixel197_diffA = fabs(pixel197.w- (float)255);
   if ((pixel197_diffR<17)&& (pixel197_diffG<17)&&(pixel197_diffB<17 )&&(pixel197_diffA<17)){
	    pixel_new += (pixel197)*(float)31.0; accumWeights += 31;
    }
    float pixel198_diffR = fabs(pixel198.x- (float)255);
    float pixel198_diffG = fabs(pixel198.y- (float)255);
    float pixel198_diffB = fabs(pixel198.z- (float)255);
    float pixel198_diffA = fabs(pixel198.w- (float)255);
   if ((pixel198_diffR<17)&& (pixel198_diffG<17)&&(pixel198_diffB<17 )&&(pixel198_diffA<17)){
	    pixel_new += (pixel198)*(float)44.0; accumWeights += 44;
    }
    float pixel199_diffR = fabs(pixel199.x- (float)255);
    float pixel199_diffG = fabs(pixel199.y- (float)255);
    float pixel199_diffB = fabs(pixel199.z- (float)255);
    float pixel199_diffA = fabs(pixel199.w- (float)255);
   if ((pixel199_diffR<17)&& (pixel199_diffG<17)&&(pixel199_diffB<17 )&&(pixel199_diffA<17)){
	    pixel_new += (pixel199)*(float)59.0; accumWeights += 59;
    }
    float pixel200_diffR = fabs(pixel200.x- (float)255);
    float pixel200_diffG = fabs(pixel200.y- (float)255);
    float pixel200_diffB = fabs(pixel200.z- (float)255);
    float pixel200_diffA = fabs(pixel200.w- (float)255);
   if ((pixel200_diffR<17)&& (pixel200_diffG<17)&&(pixel200_diffB<17 )&&(pixel200_diffA<17)){
	    pixel_new += (pixel200)*(float)72.0; accumWeights += 72;
    }
    float pixel201_diffR = fabs(pixel201.x- (float)255);
    float pixel201_diffG = fabs(pixel201.y- (float)255);
    float pixel201_diffB = fabs(pixel201.z- (float)255);
    float pixel201_diffA = fabs(pixel201.w- (float)255);
   if ((pixel201_diffR<17)&& (pixel201_diffG<17)&&(pixel201_diffB<17 )&&(pixel201_diffA<17)){
	    pixel_new += (pixel201)*(float)81.0; accumWeights += 81;
    }
    float pixel202_diffR = fabs(pixel202.x- (float)255);
    float pixel202_diffG = fabs(pixel202.y- (float)255);
    float pixel202_diffB = fabs(pixel202.z- (float)255);
    float pixel202_diffA = fabs(pixel202.w- (float)255);
   if ((pixel202_diffR<17)&& (pixel202_diffG<17)&&(pixel202_diffB<17 )&&(pixel202_diffA<17)){
	    pixel_new += (pixel202)*(float)85.0; accumWeights += 85;
    }
    float pixel203_diffR = fabs(pixel203.x- (float)255);
    float pixel203_diffG = fabs(pixel203.y- (float)255);
    float pixel203_diffB = fabs(pixel203.z- (float)255);
    float pixel203_diffA = fabs(pixel203.w- (float)255);
   if ((pixel203_diffR<17)&& (pixel203_diffG<17)&&(pixel203_diffB<17 )&&(pixel203_diffA<17)){
	    pixel_new += (pixel203)*(float)81.0; accumWeights += 81;
    }
    float pixel204_diffR = fabs(pixel204.x- (float)255);
    float pixel204_diffG = fabs(pixel204.y- (float)255);
    float pixel204_diffB = fabs(pixel204.z- (float)255);
    float pixel204_diffA = fabs(pixel204.w- (float)255);
   if ((pixel204_diffR<17)&& (pixel204_diffG<17)&&(pixel204_diffB<17 )&&(pixel204_diffA<17)){
	    pixel_new += (pixel204)*(float)72.0; accumWeights += 72;
    }
    float pixel205_diffR = fabs(pixel205.x- (float)255);
    float pixel205_diffG = fabs(pixel205.y- (float)255);
    float pixel205_diffB = fabs(pixel205.z- (float)255);
    float pixel205_diffA = fabs(pixel205.w- (float)255);
   if ((pixel205_diffR<17)&& (pixel205_diffG<17)&&(pixel205_diffB<17 )&&(pixel205_diffA<17)){
	    pixel_new += (pixel205)*(float)59.0; accumWeights += 59;
    }
    float pixel206_diffR = fabs(pixel206.x- (float)255);
    float pixel206_diffG = fabs(pixel206.y- (float)255);
    float pixel206_diffB = fabs(pixel206.z- (float)255);
    float pixel206_diffA = fabs(pixel206.w- (float)255);
   if ((pixel206_diffR<17)&& (pixel206_diffG<17)&&(pixel206_diffB<17 )&&(pixel206_diffA<17)){
	    pixel_new += (pixel206)*(float)44.0; accumWeights += 44;
    }
    float pixel207_diffR = fabs(pixel207.x- (float)255);
    float pixel207_diffG = fabs(pixel207.y- (float)255);
    float pixel207_diffB = fabs(pixel207.z- (float)255);
    float pixel207_diffA = fabs(pixel207.w- (float)255);
   if ((pixel207_diffR<17)&& (pixel207_diffG<17)&&(pixel207_diffB<17 )&&(pixel207_diffA<17)){
	    pixel_new += (pixel207)*(float)31.0; accumWeights += 31;
    }
    float pixel208_diffR = fabs(pixel208.x- (float)255);
    float pixel208_diffG = fabs(pixel208.y- (float)255);
    float pixel208_diffB = fabs(pixel208.z- (float)255);
    float pixel208_diffA = fabs(pixel208.w- (float)255);
   if ((pixel208_diffR<17)&& (pixel208_diffG<17)&&(pixel208_diffB<17 )&&(pixel208_diffA<17)){
	    pixel_new += (pixel208)*(float)20.0; accumWeights += 20;
    }
    float pixel209_diffR = fabs(pixel209.x- (float)255);
    float pixel209_diffG = fabs(pixel209.y- (float)255);
    float pixel209_diffB = fabs(pixel209.z- (float)255);
    float pixel209_diffA = fabs(pixel209.w- (float)255);
   if ((pixel209_diffR<17)&& (pixel209_diffG<17)&&(pixel209_diffB<17 )&&(pixel209_diffA<17)){
	    pixel_new += (pixel209)*(float)12.0; accumWeights += 12;
    }
    float pixel210_diffR = fabs(pixel210.x- (float)255);
    float pixel210_diffG = fabs(pixel210.y- (float)255);
    float pixel210_diffB = fabs(pixel210.z- (float)255);
    float pixel210_diffA = fabs(pixel210.w- (float)255);
   if ((pixel210_diffR<17)&& (pixel210_diffG<17)&&(pixel210_diffB<17 )&&(pixel210_diffA<17)){
	    pixel_new += (pixel210)*(float)6.0; accumWeights += 6;
    }
    float pixel211_diffR = fabs(pixel211.x- (float)255);
    float pixel211_diffG = fabs(pixel211.y- (float)255);
    float pixel211_diffB = fabs(pixel211.z- (float)255);
    float pixel211_diffA = fabs(pixel211.w- (float)255);
   if ((pixel211_diffR<17)&& (pixel211_diffG<17)&&(pixel211_diffB<17 )&&(pixel211_diffA<17)){
	    pixel_new += (pixel211)*(float)3.0; accumWeights += 3;
    }
    float pixel212_diffR = fabs(pixel212.x- (float)255);
    float pixel212_diffG = fabs(pixel212.y- (float)255);
    float pixel212_diffB = fabs(pixel212.z- (float)255);
    float pixel212_diffA = fabs(pixel212.w- (float)255);
   if ((pixel212_diffR<17)&& (pixel212_diffG<17)&&(pixel212_diffB<17 )&&(pixel212_diffA<17)){
	    pixel_new += (pixel212)*(float)2.0; accumWeights += 2;
    }
    float pixel213_diffR = fabs(pixel213.x- (float)255);
    float pixel213_diffG = fabs(pixel213.y- (float)255);
    float pixel213_diffB = fabs(pixel213.z- (float)255);
    float pixel213_diffA = fabs(pixel213.w- (float)255);
   if ((pixel213_diffR<17)&& (pixel213_diffG<17)&&(pixel213_diffB<17 )&&(pixel213_diffA<17)){
	    pixel_new += (pixel213)*(float)5.0; accumWeights += 5;
    }
    float pixel214_diffR = fabs(pixel214.x- (float)255);
    float pixel214_diffG = fabs(pixel214.y- (float)255);
    float pixel214_diffB = fabs(pixel214.z- (float)255);
    float pixel214_diffA = fabs(pixel214.w- (float)255);
   if ((pixel214_diffR<17)&& (pixel214_diffG<17)&&(pixel214_diffB<17 )&&(pixel214_diffA<17)){
	    pixel_new += (pixel214)*(float)9.0; accumWeights += 9;
    }
    float pixel215_diffR = fabs(pixel215.x- (float)255);
    float pixel215_diffG = fabs(pixel215.y- (float)255);
    float pixel215_diffB = fabs(pixel215.z- (float)255);
    float pixel215_diffA = fabs(pixel215.w- (float)255);
   if ((pixel215_diffR<17)&& (pixel215_diffG<17)&&(pixel215_diffB<17 )&&(pixel215_diffA<17)){
	    pixel_new += (pixel215)*(float)16.0; accumWeights += 16;
    }
    float pixel216_diffR = fabs(pixel216.x- (float)255);
    float pixel216_diffG = fabs(pixel216.y- (float)255);
    float pixel216_diffB = fabs(pixel216.z- (float)255);
    float pixel216_diffA = fabs(pixel216.w- (float)255);
   if ((pixel216_diffR<17)&& (pixel216_diffG<17)&&(pixel216_diffB<17 )&&(pixel216_diffA<17)){
	    pixel_new += (pixel216)*(float)25.0; accumWeights += 25;
    }
    float pixel217_diffR = fabs(pixel217.x- (float)255);
    float pixel217_diffG = fabs(pixel217.y- (float)255);
    float pixel217_diffB = fabs(pixel217.z- (float)255);
    float pixel217_diffA = fabs(pixel217.w- (float)255);
   if ((pixel217_diffR<17)&& (pixel217_diffG<17)&&(pixel217_diffB<17 )&&(pixel217_diffA<17)){
	    pixel_new += (pixel217)*(float)36.0; accumWeights += 36;
    }
    float pixel218_diffR = fabs(pixel218.x- (float)255);
    float pixel218_diffG = fabs(pixel218.y- (float)255);
    float pixel218_diffB = fabs(pixel218.z- (float)255);
    float pixel218_diffA = fabs(pixel218.w- (float)255);
   if ((pixel218_diffR<17)&& (pixel218_diffG<17)&&(pixel218_diffB<17 )&&(pixel218_diffA<17)){
	    pixel_new += (pixel218)*(float)48.0; accumWeights += 48;
    }
    float pixel219_diffR = fabs(pixel219.x- (float)255);
    float pixel219_diffG = fabs(pixel219.y- (float)255);
    float pixel219_diffB = fabs(pixel219.z- (float)255);
    float pixel219_diffA = fabs(pixel219.w- (float)255);
   if ((pixel219_diffR<17)&& (pixel219_diffG<17)&&(pixel219_diffB<17 )&&(pixel219_diffA<17)){
	    pixel_new += (pixel219)*(float)59.0; accumWeights += 59;
    }
    float pixel220_diffR = fabs(pixel220.x- (float)255);
    float pixel220_diffG = fabs(pixel220.y- (float)255);
    float pixel220_diffB = fabs(pixel220.z- (float)255);
    float pixel220_diffA = fabs(pixel220.w- (float)255);
   if ((pixel220_diffR<17)&& (pixel220_diffG<17)&&(pixel220_diffB<17 )&&(pixel220_diffA<17)){
	    pixel_new += (pixel220)*(float)67.0; accumWeights += 67;
    }
    float pixel221_diffR = fabs(pixel221.x- (float)255);
    float pixel221_diffG = fabs(pixel221.y- (float)255);
    float pixel221_diffB = fabs(pixel221.z- (float)255);
    float pixel221_diffA = fabs(pixel221.w- (float)255);
   if ((pixel221_diffR<17)&& (pixel221_diffG<17)&&(pixel221_diffB<17 )&&(pixel221_diffA<17)){
	    pixel_new += (pixel221)*(float)69.0; accumWeights += 69;
    }
    float pixel222_diffR = fabs(pixel222.x- (float)255);
    float pixel222_diffG = fabs(pixel222.y- (float)255);
    float pixel222_diffB = fabs(pixel222.z- (float)255);
    float pixel222_diffA = fabs(pixel222.w- (float)255);
   if ((pixel222_diffR<17)&& (pixel222_diffG<17)&&(pixel222_diffB<17 )&&(pixel222_diffA<17)){
	    pixel_new += (pixel222)*(float)67.0; accumWeights += 67;
    }
    float pixel223_diffR = fabs(pixel223.x- (float)255);
    float pixel223_diffG = fabs(pixel223.y- (float)255);
    float pixel223_diffB = fabs(pixel223.z- (float)255);
    float pixel223_diffA = fabs(pixel223.w- (float)255);
   if ((pixel223_diffR<17)&& (pixel223_diffG<17)&&(pixel223_diffB<17 )&&(pixel223_diffA<17)){
	    pixel_new += (pixel223)*(float)59.0; accumWeights += 59;
    }
    float pixel224_diffR = fabs(pixel224.x- (float)255);
    float pixel224_diffG = fabs(pixel224.y- (float)255);
    float pixel224_diffB = fabs(pixel224.z- (float)255);
    float pixel224_diffA = fabs(pixel224.w- (float)255);
   if ((pixel224_diffR<17)&& (pixel224_diffG<17)&&(pixel224_diffB<17 )&&(pixel224_diffA<17)){
	    pixel_new += (pixel224)*(float)48.0; accumWeights += 48;
    }
    float pixel225_diffR = fabs(pixel225.x- (float)255);
    float pixel225_diffG = fabs(pixel225.y- (float)255);
    float pixel225_diffB = fabs(pixel225.z- (float)255);
    float pixel225_diffA = fabs(pixel225.w- (float)255);
   if ((pixel225_diffR<17)&& (pixel225_diffG<17)&&(pixel225_diffB<17 )&&(pixel225_diffA<17)){
	    pixel_new += (pixel225)*(float)36.0; accumWeights += 36;
    }
    float pixel226_diffR = fabs(pixel226.x- (float)255);
    float pixel226_diffG = fabs(pixel226.y- (float)255);
    float pixel226_diffB = fabs(pixel226.z- (float)255);
    float pixel226_diffA = fabs(pixel226.w- (float)255);
   if ((pixel226_diffR<17)&& (pixel226_diffG<17)&&(pixel226_diffB<17 )&&(pixel226_diffA<17)){
	    pixel_new += (pixel226)*(float)25.0; accumWeights += 25;
    }
    float pixel227_diffR = fabs(pixel227.x- (float)255);
    float pixel227_diffG = fabs(pixel227.y- (float)255);
    float pixel227_diffB = fabs(pixel227.z- (float)255);
    float pixel227_diffA = fabs(pixel227.w- (float)255);
   if ((pixel227_diffR<17)&& (pixel227_diffG<17)&&(pixel227_diffB<17 )&&(pixel227_diffA<17)){
	    pixel_new += (pixel227)*(float)16.0; accumWeights += 16;
    }
    float pixel228_diffR = fabs(pixel228.x- (float)255);
    float pixel228_diffG = fabs(pixel228.y- (float)255);
    float pixel228_diffB = fabs(pixel228.z- (float)255);
    float pixel228_diffA = fabs(pixel228.w- (float)255);
   if ((pixel228_diffR<17)&& (pixel228_diffG<17)&&(pixel228_diffB<17 )&&(pixel228_diffA<17)){
	    pixel_new += (pixel228)*(float)9.0; accumWeights += 9;
    }
    float pixel229_diffR = fabs(pixel229.x- (float)255);
    float pixel229_diffG = fabs(pixel229.y- (float)255);
    float pixel229_diffB = fabs(pixel229.z- (float)255);
    float pixel229_diffA = fabs(pixel229.w- (float)255);
   if ((pixel229_diffR<17)&& (pixel229_diffG<17)&&(pixel229_diffB<17 )&&(pixel229_diffA<17)){
	    pixel_new += (pixel229)*(float)5.0; accumWeights += 5;
    }
    float pixel230_diffR = fabs(pixel230.x- (float)255);
    float pixel230_diffG = fabs(pixel230.y- (float)255);
    float pixel230_diffB = fabs(pixel230.z- (float)255);
    float pixel230_diffA = fabs(pixel230.w- (float)255);
   if ((pixel230_diffR<17)&& (pixel230_diffG<17)&&(pixel230_diffB<17 )&&(pixel230_diffA<17)){
	    pixel_new += (pixel230)*(float)2.0; accumWeights += 2;
    }
    float pixel231_diffR = fabs(pixel231.x- (float)255);
    float pixel231_diffG = fabs(pixel231.y- (float)255);
    float pixel231_diffB = fabs(pixel231.z- (float)255);
    float pixel231_diffA = fabs(pixel231.w- (float)255);
   if ((pixel231_diffR<17)&& (pixel231_diffG<17)&&(pixel231_diffB<17 )&&(pixel231_diffA<17)){
	    pixel_new += (pixel231)*(float)2.0; accumWeights += 2;
    }
    float pixel232_diffR = fabs(pixel232.x- (float)255);
    float pixel232_diffG = fabs(pixel232.y- (float)255);
    float pixel232_diffB = fabs(pixel232.z- (float)255);
    float pixel232_diffA = fabs(pixel232.w- (float)255);
   if ((pixel232_diffR<17)&& (pixel232_diffG<17)&&(pixel232_diffB<17 )&&(pixel232_diffA<17)){
	    pixel_new += (pixel232)*(float)4.0; accumWeights += 4;
    }
    float pixel233_diffR = fabs(pixel233.x- (float)255);
    float pixel233_diffG = fabs(pixel233.y- (float)255);
    float pixel233_diffB = fabs(pixel233.z- (float)255);
    float pixel233_diffA = fabs(pixel233.w- (float)255);
   if ((pixel233_diffR<17)&& (pixel233_diffG<17)&&(pixel233_diffB<17 )&&(pixel233_diffA<17)){
	    pixel_new += (pixel233)*(float)7.0; accumWeights += 7;
    }
    float pixel234_diffR = fabs(pixel234.x- (float)255);
    float pixel234_diffG = fabs(pixel234.y- (float)255);
    float pixel234_diffB = fabs(pixel234.z- (float)255);
    float pixel234_diffA = fabs(pixel234.w- (float)255);
   if ((pixel234_diffR<17)&& (pixel234_diffG<17)&&(pixel234_diffB<17 )&&(pixel234_diffA<17)){
	    pixel_new += (pixel234)*(float)12.0; accumWeights += 12;
    }
    float pixel235_diffR = fabs(pixel235.x- (float)255);
    float pixel235_diffG = fabs(pixel235.y- (float)255);
    float pixel235_diffB = fabs(pixel235.z- (float)255);
    float pixel235_diffA = fabs(pixel235.w- (float)255);
   if ((pixel235_diffR<17)&& (pixel235_diffG<17)&&(pixel235_diffB<17 )&&(pixel235_diffA<17)){
	    pixel_new += (pixel235)*(float)19.0; accumWeights += 19;
    }
    float pixel236_diffR = fabs(pixel236.x- (float)255);
    float pixel236_diffG = fabs(pixel236.y- (float)255);
    float pixel236_diffB = fabs(pixel236.z- (float)255);
    float pixel236_diffA = fabs(pixel236.w- (float)255);
   if ((pixel236_diffR<17)&& (pixel236_diffG<17)&&(pixel236_diffB<17 )&&(pixel236_diffA<17)){
	    pixel_new += (pixel236)*(float)27.0; accumWeights += 27;
    }
    float pixel237_diffR = fabs(pixel237.x- (float)255);
    float pixel237_diffG = fabs(pixel237.y- (float)255);
    float pixel237_diffB = fabs(pixel237.z- (float)255);
    float pixel237_diffA = fabs(pixel237.w- (float)255);
   if ((pixel237_diffR<17)&& (pixel237_diffG<17)&&(pixel237_diffB<17 )&&(pixel237_diffA<17)){
	    pixel_new += (pixel237)*(float)36.0; accumWeights += 36;
    }
    float pixel238_diffR = fabs(pixel238.x- (float)255);
    float pixel238_diffG = fabs(pixel238.y- (float)255);
    float pixel238_diffB = fabs(pixel238.z- (float)255);
    float pixel238_diffA = fabs(pixel238.w- (float)255);
   if ((pixel238_diffR<17)&& (pixel238_diffG<17)&&(pixel238_diffB<17 )&&(pixel238_diffA<17)){
	    pixel_new += (pixel238)*(float)44.0; accumWeights += 44;
    }
    float pixel239_diffR = fabs(pixel239.x- (float)255);
    float pixel239_diffG = fabs(pixel239.y- (float)255);
    float pixel239_diffB = fabs(pixel239.z- (float)255);
    float pixel239_diffA = fabs(pixel239.w- (float)255);
   if ((pixel239_diffR<17)&& (pixel239_diffG<17)&&(pixel239_diffB<17 )&&(pixel239_diffA<17)){
	    pixel_new += (pixel239)*(float)50.0; accumWeights += 50;
    }
    float pixel240_diffR = fabs(pixel240.x- (float)255);
    float pixel240_diffG = fabs(pixel240.y- (float)255);
    float pixel240_diffB = fabs(pixel240.z- (float)255);
    float pixel240_diffA = fabs(pixel240.w- (float)255);
   if ((pixel240_diffR<17)&& (pixel240_diffG<17)&&(pixel240_diffB<17 )&&(pixel240_diffA<17)){
	    pixel_new += (pixel240)*(float)52.0; accumWeights += 52;
    }
    float pixel241_diffR = fabs(pixel241.x- (float)255);
    float pixel241_diffG = fabs(pixel241.y- (float)255);
    float pixel241_diffB = fabs(pixel241.z- (float)255);
    float pixel241_diffA = fabs(pixel241.w- (float)255);
   if ((pixel241_diffR<17)&& (pixel241_diffG<17)&&(pixel241_diffB<17 )&&(pixel241_diffA<17)){
	    pixel_new += (pixel241)*(float)50.0; accumWeights += 50;
    }
    float pixel242_diffR = fabs(pixel242.x- (float)255);
    float pixel242_diffG = fabs(pixel242.y- (float)255);
    float pixel242_diffB = fabs(pixel242.z- (float)255);
    float pixel242_diffA = fabs(pixel242.w- (float)255);
   if ((pixel242_diffR<17)&& (pixel242_diffG<17)&&(pixel242_diffB<17 )&&(pixel242_diffA<17)){
	    pixel_new += (pixel242)*(float)44.0; accumWeights += 44;
    }
    float pixel243_diffR = fabs(pixel243.x- (float)255);
    float pixel243_diffG = fabs(pixel243.y- (float)255);
    float pixel243_diffB = fabs(pixel243.z- (float)255);
    float pixel243_diffA = fabs(pixel243.w- (float)255);
   if ((pixel243_diffR<17)&& (pixel243_diffG<17)&&(pixel243_diffB<17 )&&(pixel243_diffA<17)){
	    pixel_new += (pixel243)*(float)36.0; accumWeights += 36;
    }
    float pixel244_diffR = fabs(pixel244.x- (float)255);
    float pixel244_diffG = fabs(pixel244.y- (float)255);
    float pixel244_diffB = fabs(pixel244.z- (float)255);
    float pixel244_diffA = fabs(pixel244.w- (float)255);
   if ((pixel244_diffR<17)&& (pixel244_diffG<17)&&(pixel244_diffB<17 )&&(pixel244_diffA<17)){
	    pixel_new += (pixel244)*(float)27.0; accumWeights += 27;
    }
    float pixel245_diffR = fabs(pixel245.x- (float)255);
    float pixel245_diffG = fabs(pixel245.y- (float)255);
    float pixel245_diffB = fabs(pixel245.z- (float)255);
    float pixel245_diffA = fabs(pixel245.w- (float)255);
   if ((pixel245_diffR<17)&& (pixel245_diffG<17)&&(pixel245_diffB<17 )&&(pixel245_diffA<17)){
	    pixel_new += (pixel245)*(float)19.0; accumWeights += 19;
    }
    float pixel246_diffR = fabs(pixel246.x- (float)255);
    float pixel246_diffG = fabs(pixel246.y- (float)255);
    float pixel246_diffB = fabs(pixel246.z- (float)255);
    float pixel246_diffA = fabs(pixel246.w- (float)255);
   if ((pixel246_diffR<17)&& (pixel246_diffG<17)&&(pixel246_diffB<17 )&&(pixel246_diffA<17)){
	    pixel_new += (pixel246)*(float)12.0; accumWeights += 12;
    }
    float pixel247_diffR = fabs(pixel247.x- (float)255);
    float pixel247_diffG = fabs(pixel247.y- (float)255);
    float pixel247_diffB = fabs(pixel247.z- (float)255);
    float pixel247_diffA = fabs(pixel247.w- (float)255);
   if ((pixel247_diffR<17)&& (pixel247_diffG<17)&&(pixel247_diffB<17 )&&(pixel247_diffA<17)){
	    pixel_new += (pixel247)*(float)7.0; accumWeights += 7;
    }
    float pixel248_diffR = fabs(pixel248.x- (float)255);
    float pixel248_diffG = fabs(pixel248.y- (float)255);
    float pixel248_diffB = fabs(pixel248.z- (float)255);
    float pixel248_diffA = fabs(pixel248.w- (float)255);
   if ((pixel248_diffR<17)&& (pixel248_diffG<17)&&(pixel248_diffB<17 )&&(pixel248_diffA<17)){
	    pixel_new += (pixel248)*(float)4.0; accumWeights += 4;
    }
    float pixel249_diffR = fabs(pixel249.x- (float)255);
    float pixel249_diffG = fabs(pixel249.y- (float)255);
    float pixel249_diffB = fabs(pixel249.z- (float)255);
    float pixel249_diffA = fabs(pixel249.w- (float)255);
   if ((pixel249_diffR<17)&& (pixel249_diffG<17)&&(pixel249_diffB<17 )&&(pixel249_diffA<17)){
	    pixel_new += (pixel249)*(float)2.0; accumWeights += 2;
    }
    float pixel250_diffR = fabs(pixel250.x- (float)255);
    float pixel250_diffG = fabs(pixel250.y- (float)255);
    float pixel250_diffB = fabs(pixel250.z- (float)255);
    float pixel250_diffA = fabs(pixel250.w- (float)255);
   if ((pixel250_diffR<17)&& (pixel250_diffG<17)&&(pixel250_diffB<17 )&&(pixel250_diffA<17)){
	    pixel_new += (pixel250)*(float)1.0; accumWeights += 1;
    }
    float pixel251_diffR = fabs(pixel251.x- (float)255);
    float pixel251_diffG = fabs(pixel251.y- (float)255);
    float pixel251_diffB = fabs(pixel251.z- (float)255);
    float pixel251_diffA = fabs(pixel251.w- (float)255);
   if ((pixel251_diffR<17)&& (pixel251_diffG<17)&&(pixel251_diffB<17 )&&(pixel251_diffA<17)){
	    pixel_new += (pixel251)*(float)2.0; accumWeights += 2;
    }
    float pixel252_diffR = fabs(pixel252.x- (float)255);
    float pixel252_diffG = fabs(pixel252.y- (float)255);
    float pixel252_diffB = fabs(pixel252.z- (float)255);
    float pixel252_diffA = fabs(pixel252.w- (float)255);
   if ((pixel252_diffR<17)&& (pixel252_diffG<17)&&(pixel252_diffB<17 )&&(pixel252_diffA<17)){
	    pixel_new += (pixel252)*(float)5.0; accumWeights += 5;
    }
    float pixel253_diffR = fabs(pixel253.x- (float)255);
    float pixel253_diffG = fabs(pixel253.y- (float)255);
    float pixel253_diffB = fabs(pixel253.z- (float)255);
    float pixel253_diffA = fabs(pixel253.w- (float)255);
   if ((pixel253_diffR<17)&& (pixel253_diffG<17)&&(pixel253_diffB<17 )&&(pixel253_diffA<17)){
	    pixel_new += (pixel253)*(float)8.0; accumWeights += 8;
    }
    float pixel254_diffR = fabs(pixel254.x- (float)255);
    float pixel254_diffG = fabs(pixel254.y- (float)255);
    float pixel254_diffB = fabs(pixel254.z- (float)255);
    float pixel254_diffA = fabs(pixel254.w- (float)255);
   if ((pixel254_diffR<17)&& (pixel254_diffG<17)&&(pixel254_diffB<17 )&&(pixel254_diffA<17)){
	    pixel_new += (pixel254)*(float)13.0; accumWeights += 13;
    }
    float pixel255_diffR = fabs(pixel255.x- (float)255);
    float pixel255_diffG = fabs(pixel255.y- (float)255);
    float pixel255_diffB = fabs(pixel255.z- (float)255);
    float pixel255_diffA = fabs(pixel255.w- (float)255);
   if ((pixel255_diffR<17)&& (pixel255_diffG<17)&&(pixel255_diffB<17 )&&(pixel255_diffA<17)){
	    pixel_new += (pixel255)*(float)19.0; accumWeights += 19;
    }
    float pixel256_diffR = fabs(pixel256.x- (float)255);
    float pixel256_diffG = fabs(pixel256.y- (float)255);
    float pixel256_diffB = fabs(pixel256.z- (float)255);
    float pixel256_diffA = fabs(pixel256.w- (float)255);
   if ((pixel256_diffR<17)&& (pixel256_diffG<17)&&(pixel256_diffB<17 )&&(pixel256_diffA<17)){
	    pixel_new += (pixel256)*(float)25.0; accumWeights += 25;
    }
    float pixel257_diffR = fabs(pixel257.x- (float)255);
    float pixel257_diffG = fabs(pixel257.y- (float)255);
    float pixel257_diffB = fabs(pixel257.z- (float)255);
    float pixel257_diffA = fabs(pixel257.w- (float)255);
   if ((pixel257_diffR<17)&& (pixel257_diffG<17)&&(pixel257_diffB<17 )&&(pixel257_diffA<17)){
	    pixel_new += (pixel257)*(float)31.0; accumWeights += 31;
    }
    float pixel258_diffR = fabs(pixel258.x- (float)255);
    float pixel258_diffG = fabs(pixel258.y- (float)255);
    float pixel258_diffB = fabs(pixel258.z- (float)255);
    float pixel258_diffA = fabs(pixel258.w- (float)255);
   if ((pixel258_diffR<17)&& (pixel258_diffG<17)&&(pixel258_diffB<17 )&&(pixel258_diffA<17)){
	    pixel_new += (pixel258)*(float)35.0; accumWeights += 35;
    }
    float pixel259_diffR = fabs(pixel259.x- (float)255);
    float pixel259_diffG = fabs(pixel259.y- (float)255);
    float pixel259_diffB = fabs(pixel259.z- (float)255);
    float pixel259_diffA = fabs(pixel259.w- (float)255);
   if ((pixel259_diffR<17)&& (pixel259_diffG<17)&&(pixel259_diffB<17 )&&(pixel259_diffA<17)){
	    pixel_new += (pixel259)*(float)36.0; accumWeights += 36;
    }
    float pixel260_diffR = fabs(pixel260.x- (float)255);
    float pixel260_diffG = fabs(pixel260.y- (float)255);
    float pixel260_diffB = fabs(pixel260.z- (float)255);
    float pixel260_diffA = fabs(pixel260.w- (float)255);
   if ((pixel260_diffR<17)&& (pixel260_diffG<17)&&(pixel260_diffB<17 )&&(pixel260_diffA<17)){
	    pixel_new += (pixel260)*(float)35.0; accumWeights += 35;
    }
    float pixel261_diffR = fabs(pixel261.x- (float)255);
    float pixel261_diffG = fabs(pixel261.y- (float)255);
    float pixel261_diffB = fabs(pixel261.z- (float)255);
    float pixel261_diffA = fabs(pixel261.w- (float)255);
   if ((pixel261_diffR<17)&& (pixel261_diffG<17)&&(pixel261_diffB<17 )&&(pixel261_diffA<17)){
	    pixel_new += (pixel261)*(float)31.0; accumWeights += 31;
    }
    float pixel262_diffR = fabs(pixel262.x- (float)255);
    float pixel262_diffG = fabs(pixel262.y- (float)255);
    float pixel262_diffB = fabs(pixel262.z- (float)255);
    float pixel262_diffA = fabs(pixel262.w- (float)255);
   if ((pixel262_diffR<17)&& (pixel262_diffG<17)&&(pixel262_diffB<17 )&&(pixel262_diffA<17)){
	    pixel_new += (pixel262)*(float)25.0; accumWeights += 25;
    }
    float pixel263_diffR = fabs(pixel263.x- (float)255);
    float pixel263_diffG = fabs(pixel263.y- (float)255);
    float pixel263_diffB = fabs(pixel263.z- (float)255);
    float pixel263_diffA = fabs(pixel263.w- (float)255);
   if ((pixel263_diffR<17)&& (pixel263_diffG<17)&&(pixel263_diffB<17 )&&(pixel263_diffA<17)){
	    pixel_new += (pixel263)*(float)19.0; accumWeights += 19;
    }
    float pixel264_diffR = fabs(pixel264.x- (float)255);
    float pixel264_diffG = fabs(pixel264.y- (float)255);
    float pixel264_diffB = fabs(pixel264.z- (float)255);
    float pixel264_diffA = fabs(pixel264.w- (float)255);
   if ((pixel264_diffR<17)&& (pixel264_diffG<17)&&(pixel264_diffB<17 )&&(pixel264_diffA<17)){
	    pixel_new += (pixel264)*(float)13.0; accumWeights += 13;
    }
    float pixel265_diffR = fabs(pixel265.x- (float)255);
    float pixel265_diffG = fabs(pixel265.y- (float)255);
    float pixel265_diffB = fabs(pixel265.z- (float)255);
    float pixel265_diffA = fabs(pixel265.w- (float)255);
   if ((pixel265_diffR<17)&& (pixel265_diffG<17)&&(pixel265_diffB<17 )&&(pixel265_diffA<17)){
	    pixel_new += (pixel265)*(float)8.0; accumWeights += 8;
    }
    float pixel266_diffR = fabs(pixel266.x- (float)255);
    float pixel266_diffG = fabs(pixel266.y- (float)255);
    float pixel266_diffB = fabs(pixel266.z- (float)255);
    float pixel266_diffA = fabs(pixel266.w- (float)255);
   if ((pixel266_diffR<17)&& (pixel266_diffG<17)&&(pixel266_diffB<17 )&&(pixel266_diffA<17)){
	    pixel_new += (pixel266)*(float)5.0; accumWeights += 5;
    }
    float pixel267_diffR = fabs(pixel267.x- (float)255);
    float pixel267_diffG = fabs(pixel267.y- (float)255);
    float pixel267_diffB = fabs(pixel267.z- (float)255);
    float pixel267_diffA = fabs(pixel267.w- (float)255);
   if ((pixel267_diffR<17)&& (pixel267_diffG<17)&&(pixel267_diffB<17 )&&(pixel267_diffA<17)){
	    pixel_new += (pixel267)*(float)2.0; accumWeights += 2;
    }
    float pixel268_diffR = fabs(pixel268.x- (float)255);
    float pixel268_diffG = fabs(pixel268.y- (float)255);
    float pixel268_diffB = fabs(pixel268.z- (float)255);
    float pixel268_diffA = fabs(pixel268.w- (float)255);
   if ((pixel268_diffR<17)&& (pixel268_diffG<17)&&(pixel268_diffB<17 )&&(pixel268_diffA<17)){
	    pixel_new += (pixel268)*(float)1.0; accumWeights += 1;
    }
    float pixel269_diffR = fabs(pixel269.x- (float)255);
    float pixel269_diffG = fabs(pixel269.y- (float)255);
    float pixel269_diffB = fabs(pixel269.z- (float)255);
    float pixel269_diffA = fabs(pixel269.w- (float)255);
   if ((pixel269_diffR<17)&& (pixel269_diffG<17)&&(pixel269_diffB<17 )&&(pixel269_diffA<17)){
	    pixel_new += (pixel269)*(float)1.0; accumWeights += 1;
    }
    float pixel270_diffR = fabs(pixel270.x- (float)255);
    float pixel270_diffG = fabs(pixel270.y- (float)255);
    float pixel270_diffB = fabs(pixel270.z- (float)255);
    float pixel270_diffA = fabs(pixel270.w- (float)255);
   if ((pixel270_diffR<17)&& (pixel270_diffG<17)&&(pixel270_diffB<17 )&&(pixel270_diffA<17)){
	    pixel_new += (pixel270)*(float)3.0; accumWeights += 3;
    }
    float pixel271_diffR = fabs(pixel271.x- (float)255);
    float pixel271_diffG = fabs(pixel271.y- (float)255);
    float pixel271_diffB = fabs(pixel271.z- (float)255);
    float pixel271_diffA = fabs(pixel271.w- (float)255);
   if ((pixel271_diffR<17)&& (pixel271_diffG<17)&&(pixel271_diffB<17 )&&(pixel271_diffA<17)){
	    pixel_new += (pixel271)*(float)5.0; accumWeights += 5;
    }
    float pixel272_diffR = fabs(pixel272.x- (float)255);
    float pixel272_diffG = fabs(pixel272.y- (float)255);
    float pixel272_diffB = fabs(pixel272.z- (float)255);
    float pixel272_diffA = fabs(pixel272.w- (float)255);
   if ((pixel272_diffR<17)&& (pixel272_diffG<17)&&(pixel272_diffB<17 )&&(pixel272_diffA<17)){
	    pixel_new += (pixel272)*(float)8.0; accumWeights += 8;
    }
    float pixel273_diffR = fabs(pixel273.x- (float)255);
    float pixel273_diffG = fabs(pixel273.y- (float)255);
    float pixel273_diffB = fabs(pixel273.z- (float)255);
    float pixel273_diffA = fabs(pixel273.w- (float)255);
   if ((pixel273_diffR<17)&& (pixel273_diffG<17)&&(pixel273_diffB<17 )&&(pixel273_diffA<17)){
	    pixel_new += (pixel273)*(float)12.0; accumWeights += 12;
    }
    float pixel274_diffR = fabs(pixel274.x- (float)255);
    float pixel274_diffG = fabs(pixel274.y- (float)255);
    float pixel274_diffB = fabs(pixel274.z- (float)255);
    float pixel274_diffA = fabs(pixel274.w- (float)255);
   if ((pixel274_diffR<17)&& (pixel274_diffG<17)&&(pixel274_diffB<17 )&&(pixel274_diffA<17)){
	    pixel_new += (pixel274)*(float)16.0; accumWeights += 16;
    }
    float pixel275_diffR = fabs(pixel275.x- (float)255);
    float pixel275_diffG = fabs(pixel275.y- (float)255);
    float pixel275_diffB = fabs(pixel275.z- (float)255);
    float pixel275_diffA = fabs(pixel275.w- (float)255);
   if ((pixel275_diffR<17)&& (pixel275_diffG<17)&&(pixel275_diffB<17 )&&(pixel275_diffA<17)){
	    pixel_new += (pixel275)*(float)20.0; accumWeights += 20;
    }
    float pixel276_diffR = fabs(pixel276.x- (float)255);
    float pixel276_diffG = fabs(pixel276.y- (float)255);
    float pixel276_diffB = fabs(pixel276.z- (float)255);
    float pixel276_diffA = fabs(pixel276.w- (float)255);
   if ((pixel276_diffR<17)&& (pixel276_diffG<17)&&(pixel276_diffB<17 )&&(pixel276_diffA<17)){
	    pixel_new += (pixel276)*(float)22.0; accumWeights += 22;
    }
    float pixel277_diffR = fabs(pixel277.x- (float)255);
    float pixel277_diffG = fabs(pixel277.y- (float)255);
    float pixel277_diffB = fabs(pixel277.z- (float)255);
    float pixel277_diffA = fabs(pixel277.w- (float)255);
   if ((pixel277_diffR<17)&& (pixel277_diffG<17)&&(pixel277_diffB<17 )&&(pixel277_diffA<17)){
	    pixel_new += (pixel277)*(float)23.0; accumWeights += 23;
    }
    float pixel278_diffR = fabs(pixel278.x- (float)255);
    float pixel278_diffG = fabs(pixel278.y- (float)255);
    float pixel278_diffB = fabs(pixel278.z- (float)255);
    float pixel278_diffA = fabs(pixel278.w- (float)255);
   if ((pixel278_diffR<17)&& (pixel278_diffG<17)&&(pixel278_diffB<17 )&&(pixel278_diffA<17)){
	    pixel_new += (pixel278)*(float)22.0; accumWeights += 22;
    }
    float pixel279_diffR = fabs(pixel279.x- (float)255);
    float pixel279_diffG = fabs(pixel279.y- (float)255);
    float pixel279_diffB = fabs(pixel279.z- (float)255);
    float pixel279_diffA = fabs(pixel279.w- (float)255);
   if ((pixel279_diffR<17)&& (pixel279_diffG<17)&&(pixel279_diffB<17 )&&(pixel279_diffA<17)){
	    pixel_new += (pixel279)*(float)20.0; accumWeights += 20;
    }
    float pixel280_diffR = fabs(pixel280.x- (float)255);
    float pixel280_diffG = fabs(pixel280.y- (float)255);
    float pixel280_diffB = fabs(pixel280.z- (float)255);
    float pixel280_diffA = fabs(pixel280.w- (float)255);
   if ((pixel280_diffR<17)&& (pixel280_diffG<17)&&(pixel280_diffB<17 )&&(pixel280_diffA<17)){
	    pixel_new += (pixel280)*(float)16.0; accumWeights += 16;
    }
    float pixel281_diffR = fabs(pixel281.x- (float)255);
    float pixel281_diffG = fabs(pixel281.y- (float)255);
    float pixel281_diffB = fabs(pixel281.z- (float)255);
    float pixel281_diffA = fabs(pixel281.w- (float)255);
   if ((pixel281_diffR<17)&& (pixel281_diffG<17)&&(pixel281_diffB<17 )&&(pixel281_diffA<17)){
	    pixel_new += (pixel281)*(float)12.0; accumWeights += 12;
    }
    float pixel282_diffR = fabs(pixel282.x- (float)255);
    float pixel282_diffG = fabs(pixel282.y- (float)255);
    float pixel282_diffB = fabs(pixel282.z- (float)255);
    float pixel282_diffA = fabs(pixel282.w- (float)255);
   if ((pixel282_diffR<17)&& (pixel282_diffG<17)&&(pixel282_diffB<17 )&&(pixel282_diffA<17)){
	    pixel_new += (pixel282)*(float)8.0; accumWeights += 8;
    }
    float pixel283_diffR = fabs(pixel283.x- (float)255);
    float pixel283_diffG = fabs(pixel283.y- (float)255);
    float pixel283_diffB = fabs(pixel283.z- (float)255);
    float pixel283_diffA = fabs(pixel283.w- (float)255);
   if ((pixel283_diffR<17)&& (pixel283_diffG<17)&&(pixel283_diffB<17 )&&(pixel283_diffA<17)){
	    pixel_new += (pixel283)*(float)5.0; accumWeights += 5;
    }
    float pixel284_diffR = fabs(pixel284.x- (float)255);
    float pixel284_diffG = fabs(pixel284.y- (float)255);
    float pixel284_diffB = fabs(pixel284.z- (float)255);
    float pixel284_diffA = fabs(pixel284.w- (float)255);
   if ((pixel284_diffR<17)&& (pixel284_diffG<17)&&(pixel284_diffB<17 )&&(pixel284_diffA<17)){
	    pixel_new += (pixel284)*(float)3.0; accumWeights += 3;
    }
    float pixel285_diffR = fabs(pixel285.x- (float)255);
    float pixel285_diffG = fabs(pixel285.y- (float)255);
    float pixel285_diffB = fabs(pixel285.z- (float)255);
    float pixel285_diffA = fabs(pixel285.w- (float)255);
   if ((pixel285_diffR<17)&& (pixel285_diffG<17)&&(pixel285_diffB<17 )&&(pixel285_diffA<17)){
	    pixel_new += (pixel285)*(float)1.0; accumWeights += 1;
    }
    float pixel286_diffR = fabs(pixel286.x- (float)255);
    float pixel286_diffG = fabs(pixel286.y- (float)255);
    float pixel286_diffB = fabs(pixel286.z- (float)255);
    float pixel286_diffA = fabs(pixel286.w- (float)255);
   if ((pixel286_diffR<17)&& (pixel286_diffG<17)&&(pixel286_diffB<17 )&&(pixel286_diffA<17)){
	    pixel_new += (pixel286)*(float)1.0; accumWeights += 1;
    }
    float pixel287_diffR = fabs(pixel287.x- (float)255);
    float pixel287_diffG = fabs(pixel287.y- (float)255);
    float pixel287_diffB = fabs(pixel287.z- (float)255);
    float pixel287_diffA = fabs(pixel287.w- (float)255);
   if ((pixel287_diffR<17)&& (pixel287_diffG<17)&&(pixel287_diffB<17 )&&(pixel287_diffA<17)){
	    pixel_new += (pixel287)*(float)1.0; accumWeights += 1;
    }
    float pixel288_diffR = fabs(pixel288.x- (float)255);
    float pixel288_diffG = fabs(pixel288.y- (float)255);
    float pixel288_diffB = fabs(pixel288.z- (float)255);
    float pixel288_diffA = fabs(pixel288.w- (float)255);
   if ((pixel288_diffR<17)&& (pixel288_diffG<17)&&(pixel288_diffB<17 )&&(pixel288_diffA<17)){
	    pixel_new += (pixel288)*(float)3.0; accumWeights += 3;
    }
    float pixel289_diffR = fabs(pixel289.x- (float)255);
    float pixel289_diffG = fabs(pixel289.y- (float)255);
    float pixel289_diffB = fabs(pixel289.z- (float)255);
    float pixel289_diffA = fabs(pixel289.w- (float)255);
   if ((pixel289_diffR<17)&& (pixel289_diffG<17)&&(pixel289_diffB<17 )&&(pixel289_diffA<17)){
	    pixel_new += (pixel289)*(float)5.0; accumWeights += 5;
    }
    float pixel290_diffR = fabs(pixel290.x- (float)255);
    float pixel290_diffG = fabs(pixel290.y- (float)255);
    float pixel290_diffB = fabs(pixel290.z- (float)255);
    float pixel290_diffA = fabs(pixel290.w- (float)255);
   if ((pixel290_diffR<17)&& (pixel290_diffG<17)&&(pixel290_diffB<17 )&&(pixel290_diffA<17)){
	    pixel_new += (pixel290)*(float)7.0; accumWeights += 7;
    }
    float pixel291_diffR = fabs(pixel291.x- (float)255);
    float pixel291_diffG = fabs(pixel291.y- (float)255);
    float pixel291_diffB = fabs(pixel291.z- (float)255);
    float pixel291_diffA = fabs(pixel291.w- (float)255);
   if ((pixel291_diffR<17)&& (pixel291_diffG<17)&&(pixel291_diffB<17 )&&(pixel291_diffA<17)){
	    pixel_new += (pixel291)*(float)9.0; accumWeights += 9;
    }
    float pixel292_diffR = fabs(pixel292.x- (float)255);
    float pixel292_diffG = fabs(pixel292.y- (float)255);
    float pixel292_diffB = fabs(pixel292.z- (float)255);
    float pixel292_diffA = fabs(pixel292.w- (float)255);
   if ((pixel292_diffR<17)&& (pixel292_diffG<17)&&(pixel292_diffB<17 )&&(pixel292_diffA<17)){
	    pixel_new += (pixel292)*(float)12.0; accumWeights += 12;
    }
    float pixel293_diffR = fabs(pixel293.x- (float)255);
    float pixel293_diffG = fabs(pixel293.y- (float)255);
    float pixel293_diffB = fabs(pixel293.z- (float)255);
    float pixel293_diffA = fabs(pixel293.w- (float)255);
   if ((pixel293_diffR<17)&& (pixel293_diffG<17)&&(pixel293_diffB<17 )&&(pixel293_diffA<17)){
	    pixel_new += (pixel293)*(float)13.0; accumWeights += 13;
    }
    float pixel294_diffR = fabs(pixel294.x- (float)255);
    float pixel294_diffG = fabs(pixel294.y- (float)255);
    float pixel294_diffB = fabs(pixel294.z- (float)255);
    float pixel294_diffA = fabs(pixel294.w- (float)255);
   if ((pixel294_diffR<17)&& (pixel294_diffG<17)&&(pixel294_diffB<17 )&&(pixel294_diffA<17)){
	    pixel_new += (pixel294)*(float)14.0; accumWeights += 14;
    }
    float pixel295_diffR = fabs(pixel295.x- (float)255);
    float pixel295_diffG = fabs(pixel295.y- (float)255);
    float pixel295_diffB = fabs(pixel295.z- (float)255);
    float pixel295_diffA = fabs(pixel295.w- (float)255);
   if ((pixel295_diffR<17)&& (pixel295_diffG<17)&&(pixel295_diffB<17 )&&(pixel295_diffA<17)){
	    pixel_new += (pixel295)*(float)13.0; accumWeights += 13;
    }
    float pixel296_diffR = fabs(pixel296.x- (float)255);
    float pixel296_diffG = fabs(pixel296.y- (float)255);
    float pixel296_diffB = fabs(pixel296.z- (float)255);
    float pixel296_diffA = fabs(pixel296.w- (float)255);
   if ((pixel296_diffR<17)&& (pixel296_diffG<17)&&(pixel296_diffB<17 )&&(pixel296_diffA<17)){
	    pixel_new += (pixel296)*(float)12.0; accumWeights += 12;
    }
    float pixel297_diffR = fabs(pixel297.x- (float)255);
    float pixel297_diffG = fabs(pixel297.y- (float)255);
    float pixel297_diffB = fabs(pixel297.z- (float)255);
    float pixel297_diffA = fabs(pixel297.w- (float)255);
   if ((pixel297_diffR<17)&& (pixel297_diffG<17)&&(pixel297_diffB<17 )&&(pixel297_diffA<17)){
	    pixel_new += (pixel297)*(float)9.0; accumWeights += 9;
    }
    float pixel298_diffR = fabs(pixel298.x- (float)255);
    float pixel298_diffG = fabs(pixel298.y- (float)255);
    float pixel298_diffB = fabs(pixel298.z- (float)255);
    float pixel298_diffA = fabs(pixel298.w- (float)255);
   if ((pixel298_diffR<17)&& (pixel298_diffG<17)&&(pixel298_diffB<17 )&&(pixel298_diffA<17)){
	    pixel_new += (pixel298)*(float)7.0; accumWeights += 7;
    }
    float pixel299_diffR = fabs(pixel299.x- (float)255);
    float pixel299_diffG = fabs(pixel299.y- (float)255);
    float pixel299_diffB = fabs(pixel299.z- (float)255);
    float pixel299_diffA = fabs(pixel299.w- (float)255);
   if ((pixel299_diffR<17)&& (pixel299_diffG<17)&&(pixel299_diffB<17 )&&(pixel299_diffA<17)){
	    pixel_new += (pixel299)*(float)5.0; accumWeights += 5;
    }
    float pixel300_diffR = fabs(pixel300.x- (float)255);
    float pixel300_diffG = fabs(pixel300.y- (float)255);
    float pixel300_diffB = fabs(pixel300.z- (float)255);
    float pixel300_diffA = fabs(pixel300.w- (float)255);
   if ((pixel300_diffR<17)&& (pixel300_diffG<17)&&(pixel300_diffB<17 )&&(pixel300_diffA<17)){
	    pixel_new += (pixel300)*(float)3.0; accumWeights += 3;
    }
    float pixel301_diffR = fabs(pixel301.x- (float)255);
    float pixel301_diffG = fabs(pixel301.y- (float)255);
    float pixel301_diffB = fabs(pixel301.z- (float)255);
    float pixel301_diffA = fabs(pixel301.w- (float)255);
   if ((pixel301_diffR<17)&& (pixel301_diffG<17)&&(pixel301_diffB<17 )&&(pixel301_diffA<17)){
	    pixel_new += (pixel301)*(float)1.0; accumWeights += 1;
    }
    float pixel302_diffR = fabs(pixel302.x- (float)255);
    float pixel302_diffG = fabs(pixel302.y- (float)255);
    float pixel302_diffB = fabs(pixel302.z- (float)255);
    float pixel302_diffA = fabs(pixel302.w- (float)255);
   if ((pixel302_diffR<17)&& (pixel302_diffG<17)&&(pixel302_diffB<17 )&&(pixel302_diffA<17)){
	    pixel_new += (pixel302)*(float)1.0; accumWeights += 1;
    }
    float pixel303_diffR = fabs(pixel303.x- (float)255);
    float pixel303_diffG = fabs(pixel303.y- (float)255);
    float pixel303_diffB = fabs(pixel303.z- (float)255);
    float pixel303_diffA = fabs(pixel303.w- (float)255);
   if ((pixel303_diffR<17)&& (pixel303_diffG<17)&&(pixel303_diffB<17 )&&(pixel303_diffA<17)){
	    pixel_new += (pixel303)*(float)1.0; accumWeights += 1;
    }
    float pixel304_diffR = fabs(pixel304.x- (float)255);
    float pixel304_diffG = fabs(pixel304.y- (float)255);
    float pixel304_diffB = fabs(pixel304.z- (float)255);
    float pixel304_diffA = fabs(pixel304.w- (float)255);
   if ((pixel304_diffR<17)&& (pixel304_diffG<17)&&(pixel304_diffB<17 )&&(pixel304_diffA<17)){
	    pixel_new += (pixel304)*(float)1.0; accumWeights += 1;
    }
    float pixel305_diffR = fabs(pixel305.x- (float)255);
    float pixel305_diffG = fabs(pixel305.y- (float)255);
    float pixel305_diffB = fabs(pixel305.z- (float)255);
    float pixel305_diffA = fabs(pixel305.w- (float)255);
   if ((pixel305_diffR<17)&& (pixel305_diffG<17)&&(pixel305_diffB<17 )&&(pixel305_diffA<17)){
	    pixel_new += (pixel305)*(float)2.0; accumWeights += 2;
    }
    float pixel306_diffR = fabs(pixel306.x- (float)255);
    float pixel306_diffG = fabs(pixel306.y- (float)255);
    float pixel306_diffB = fabs(pixel306.z- (float)255);
    float pixel306_diffA = fabs(pixel306.w- (float)255);
   if ((pixel306_diffR<17)&& (pixel306_diffG<17)&&(pixel306_diffB<17 )&&(pixel306_diffA<17)){
	    pixel_new += (pixel306)*(float)4.0; accumWeights += 4;
    }
    float pixel307_diffR = fabs(pixel307.x- (float)255);
    float pixel307_diffG = fabs(pixel307.y- (float)255);
    float pixel307_diffB = fabs(pixel307.z- (float)255);
    float pixel307_diffA = fabs(pixel307.w- (float)255);
   if ((pixel307_diffR<17)&& (pixel307_diffG<17)&&(pixel307_diffB<17 )&&(pixel307_diffA<17)){
	    pixel_new += (pixel307)*(float)5.0; accumWeights += 5;
    }
    float pixel308_diffR = fabs(pixel308.x- (float)255);
    float pixel308_diffG = fabs(pixel308.y- (float)255);
    float pixel308_diffB = fabs(pixel308.z- (float)255);
    float pixel308_diffA = fabs(pixel308.w- (float)255);
   if ((pixel308_diffR<17)&& (pixel308_diffG<17)&&(pixel308_diffB<17 )&&(pixel308_diffA<17)){
	    pixel_new += (pixel308)*(float)6.0; accumWeights += 6;
    }
    float pixel309_diffR = fabs(pixel309.x- (float)255);
    float pixel309_diffG = fabs(pixel309.y- (float)255);
    float pixel309_diffB = fabs(pixel309.z- (float)255);
    float pixel309_diffA = fabs(pixel309.w- (float)255);
   if ((pixel309_diffR<17)&& (pixel309_diffG<17)&&(pixel309_diffB<17 )&&(pixel309_diffA<17)){
	    pixel_new += (pixel309)*(float)7.0; accumWeights += 7;
    }
    float pixel310_diffR = fabs(pixel310.x- (float)255);
    float pixel310_diffG = fabs(pixel310.y- (float)255);
    float pixel310_diffB = fabs(pixel310.z- (float)255);
    float pixel310_diffA = fabs(pixel310.w- (float)255);
   if ((pixel310_diffR<17)&& (pixel310_diffG<17)&&(pixel310_diffB<17 )&&(pixel310_diffA<17)){
	    pixel_new += (pixel310)*(float)7.0; accumWeights += 7;
    }
    float pixel311_diffR = fabs(pixel311.x- (float)255);
    float pixel311_diffG = fabs(pixel311.y- (float)255);
    float pixel311_diffB = fabs(pixel311.z- (float)255);
    float pixel311_diffA = fabs(pixel311.w- (float)255);
   if ((pixel311_diffR<17)&& (pixel311_diffG<17)&&(pixel311_diffB<17 )&&(pixel311_diffA<17)){
	    pixel_new += (pixel311)*(float)7.0; accumWeights += 7;
    }
    float pixel312_diffR = fabs(pixel312.x- (float)255);
    float pixel312_diffG = fabs(pixel312.y- (float)255);
    float pixel312_diffB = fabs(pixel312.z- (float)255);
    float pixel312_diffA = fabs(pixel312.w- (float)255);
   if ((pixel312_diffR<17)&& (pixel312_diffG<17)&&(pixel312_diffB<17 )&&(pixel312_diffA<17)){
	    pixel_new += (pixel312)*(float)6.0; accumWeights += 6;
    }
    float pixel313_diffR = fabs(pixel313.x- (float)255);
    float pixel313_diffG = fabs(pixel313.y- (float)255);
    float pixel313_diffB = fabs(pixel313.z- (float)255);
    float pixel313_diffA = fabs(pixel313.w- (float)255);
   if ((pixel313_diffR<17)&& (pixel313_diffG<17)&&(pixel313_diffB<17 )&&(pixel313_diffA<17)){
	    pixel_new += (pixel313)*(float)5.0; accumWeights += 5;
    }
    float pixel314_diffR = fabs(pixel314.x- (float)255);
    float pixel314_diffG = fabs(pixel314.y- (float)255);
    float pixel314_diffB = fabs(pixel314.z- (float)255);
    float pixel314_diffA = fabs(pixel314.w- (float)255);
   if ((pixel314_diffR<17)&& (pixel314_diffG<17)&&(pixel314_diffB<17 )&&(pixel314_diffA<17)){
	    pixel_new += (pixel314)*(float)4.0; accumWeights += 4;
    }
    float pixel315_diffR = fabs(pixel315.x- (float)255);
    float pixel315_diffG = fabs(pixel315.y- (float)255);
    float pixel315_diffB = fabs(pixel315.z- (float)255);
    float pixel315_diffA = fabs(pixel315.w- (float)255);
   if ((pixel315_diffR<17)&& (pixel315_diffG<17)&&(pixel315_diffB<17 )&&(pixel315_diffA<17)){
	    pixel_new += (pixel315)*(float)2.0; accumWeights += 2;
    }
    float pixel316_diffR = fabs(pixel316.x- (float)255);
    float pixel316_diffG = fabs(pixel316.y- (float)255);
    float pixel316_diffB = fabs(pixel316.z- (float)255);
    float pixel316_diffA = fabs(pixel316.w- (float)255);
   if ((pixel316_diffR<17)&& (pixel316_diffG<17)&&(pixel316_diffB<17 )&&(pixel316_diffA<17)){
	    pixel_new += (pixel316)*(float)1.0; accumWeights += 1;
    }
    float pixel317_diffR = fabs(pixel317.x- (float)255);
    float pixel317_diffG = fabs(pixel317.y- (float)255);
    float pixel317_diffB = fabs(pixel317.z- (float)255);
    float pixel317_diffA = fabs(pixel317.w- (float)255);
   if ((pixel317_diffR<17)&& (pixel317_diffG<17)&&(pixel317_diffB<17 )&&(pixel317_diffA<17)){
	    pixel_new += (pixel317)*(float)1.0; accumWeights += 1;
    }
    float pixel318_diffR = fabs(pixel318.x- (float)255);
    float pixel318_diffG = fabs(pixel318.y- (float)255);
    float pixel318_diffB = fabs(pixel318.z- (float)255);
    float pixel318_diffA = fabs(pixel318.w- (float)255);
   if ((pixel318_diffR<17)&& (pixel318_diffG<17)&&(pixel318_diffB<17 )&&(pixel318_diffA<17)){
	    pixel_new += (pixel318)*(float)1.0; accumWeights += 1;
    }
    float pixel319_diffR = fabs(pixel319.x- (float)255);
    float pixel319_diffG = fabs(pixel319.y- (float)255);
    float pixel319_diffB = fabs(pixel319.z- (float)255);
    float pixel319_diffA = fabs(pixel319.w- (float)255);
   if ((pixel319_diffR<17)&& (pixel319_diffG<17)&&(pixel319_diffB<17 )&&(pixel319_diffA<17)){
	    pixel_new += (pixel319)*(float)2.0; accumWeights += 2;
    }
    float pixel320_diffR = fabs(pixel320.x- (float)255);
    float pixel320_diffG = fabs(pixel320.y- (float)255);
    float pixel320_diffB = fabs(pixel320.z- (float)255);
    float pixel320_diffA = fabs(pixel320.w- (float)255);
   if ((pixel320_diffR<17)&& (pixel320_diffG<17)&&(pixel320_diffB<17 )&&(pixel320_diffA<17)){
	    pixel_new += (pixel320)*(float)2.0; accumWeights += 2;
    }
    float pixel321_diffR = fabs(pixel321.x- (float)255);
    float pixel321_diffG = fabs(pixel321.y- (float)255);
    float pixel321_diffB = fabs(pixel321.z- (float)255);
    float pixel321_diffA = fabs(pixel321.w- (float)255);
   if ((pixel321_diffR<17)&& (pixel321_diffG<17)&&(pixel321_diffB<17 )&&(pixel321_diffA<17)){
	    pixel_new += (pixel321)*(float)3.0; accumWeights += 3;
    }
    float pixel322_diffR = fabs(pixel322.x- (float)255);
    float pixel322_diffG = fabs(pixel322.y- (float)255);
    float pixel322_diffB = fabs(pixel322.z- (float)255);
    float pixel322_diffA = fabs(pixel322.w- (float)255);
   if ((pixel322_diffR<17)&& (pixel322_diffG<17)&&(pixel322_diffB<17 )&&(pixel322_diffA<17)){
	    pixel_new += (pixel322)*(float)3.0; accumWeights += 3;
    }
    float pixel323_diffR = fabs(pixel323.x- (float)255);
    float pixel323_diffG = fabs(pixel323.y- (float)255);
    float pixel323_diffB = fabs(pixel323.z- (float)255);
    float pixel323_diffA = fabs(pixel323.w- (float)255);
   if ((pixel323_diffR<17)&& (pixel323_diffG<17)&&(pixel323_diffB<17 )&&(pixel323_diffA<17)){
	    pixel_new += (pixel323)*(float)3.0; accumWeights += 3;
    }
    float pixel324_diffR = fabs(pixel324.x- (float)255);
    float pixel324_diffG = fabs(pixel324.y- (float)255);
    float pixel324_diffB = fabs(pixel324.z- (float)255);
    float pixel324_diffA = fabs(pixel324.w- (float)255);
   if ((pixel324_diffR<17)&& (pixel324_diffG<17)&&(pixel324_diffB<17 )&&(pixel324_diffA<17)){
	    pixel_new += (pixel324)*(float)3.0; accumWeights += 3;
    }
    float pixel325_diffR = fabs(pixel325.x- (float)255);
    float pixel325_diffG = fabs(pixel325.y- (float)255);
    float pixel325_diffB = fabs(pixel325.z- (float)255);
    float pixel325_diffA = fabs(pixel325.w- (float)255);
   if ((pixel325_diffR<17)&& (pixel325_diffG<17)&&(pixel325_diffB<17 )&&(pixel325_diffA<17)){
	    pixel_new += (pixel325)*(float)3.0; accumWeights += 3;
    }
    float pixel326_diffR = fabs(pixel326.x- (float)255);
    float pixel326_diffG = fabs(pixel326.y- (float)255);
    float pixel326_diffB = fabs(pixel326.z- (float)255);
    float pixel326_diffA = fabs(pixel326.w- (float)255);
   if ((pixel326_diffR<17)&& (pixel326_diffG<17)&&(pixel326_diffB<17 )&&(pixel326_diffA<17)){
	    pixel_new += (pixel326)*(float)2.0; accumWeights += 2;
    }
    float pixel327_diffR = fabs(pixel327.x- (float)255);
    float pixel327_diffG = fabs(pixel327.y- (float)255);
    float pixel327_diffB = fabs(pixel327.z- (float)255);
    float pixel327_diffA = fabs(pixel327.w- (float)255);
   if ((pixel327_diffR<17)&& (pixel327_diffG<17)&&(pixel327_diffB<17 )&&(pixel327_diffA<17)){
	    pixel_new += (pixel327)*(float)2.0; accumWeights += 2;
    }
    float pixel328_diffR = fabs(pixel328.x- (float)255);
    float pixel328_diffG = fabs(pixel328.y- (float)255);
    float pixel328_diffB = fabs(pixel328.z- (float)255);
    float pixel328_diffA = fabs(pixel328.w- (float)255);
   if ((pixel328_diffR<17)&& (pixel328_diffG<17)&&(pixel328_diffB<17 )&&(pixel328_diffA<17)){
	    pixel_new += (pixel328)*(float)1.0; accumWeights += 1;
    }
    pixel_new = (accumWeights==0)?0:pixel_new/accumWeights; pixel_new.w = 255;
    float4 pixel_2ndary=read_imagef(inputImage2,sampler,(int2)(i,j));
    pixel_new += pixel_2ndary;
    pixel_new = fabs(pixel_new);
    if (pixel_new.x>255) pixel_new.x = 255;
    if (pixel_new.y>255) pixel_new.y = 255;
    if (pixel_new.z>255) pixel_new.z = 255;
    pixel_new.w = 255;
    write_imagef(outputImage,(int2)(i,j), pixel_new);
};


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
