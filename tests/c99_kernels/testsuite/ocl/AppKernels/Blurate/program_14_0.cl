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
    float4 pixel_new = (float4)(0, 0, 0, 255);
    float4 pixel0 = read_imagef(inputImage,sampler,(int2)(i+11,j+11));
    float4 pixel1 = read_imagef(inputImage,sampler,(int2)(i+11,j+10));
    float4 pixel2 = read_imagef(inputImage,sampler,(int2)(i+11,j+9));
    float4 pixel3 = read_imagef(inputImage,sampler,(int2)(i+11,j+8));
    float4 pixel4 = read_imagef(inputImage,sampler,(int2)(i+11,j+7));
    float4 pixel5 = read_imagef(inputImage,sampler,(int2)(i+11,j+6));
    float4 pixel6 = read_imagef(inputImage,sampler,(int2)(i+11,j+5));
    float4 pixel7 = read_imagef(inputImage,sampler,(int2)(i+11,j+4));
    float4 pixel8 = read_imagef(inputImage,sampler,(int2)(i+11,j+3));
    float4 pixel9 = read_imagef(inputImage,sampler,(int2)(i+11,j+2));
    float4 pixel10 = read_imagef(inputImage,sampler,(int2)(i+11,j+1));
    float4 pixel11 = read_imagef(inputImage,sampler,(int2)(i+11,j+0));
    float4 pixel12 = read_imagef(inputImage,sampler,(int2)(i+11,j-1));
    float4 pixel13 = read_imagef(inputImage,sampler,(int2)(i+11,j-2));
    float4 pixel14 = read_imagef(inputImage,sampler,(int2)(i+11,j-3));
    float4 pixel15 = read_imagef(inputImage,sampler,(int2)(i+11,j-4));
    float4 pixel16 = read_imagef(inputImage,sampler,(int2)(i+11,j-5));
    float4 pixel17 = read_imagef(inputImage,sampler,(int2)(i+11,j-6));
    float4 pixel18 = read_imagef(inputImage,sampler,(int2)(i+11,j-7));
    float4 pixel19 = read_imagef(inputImage,sampler,(int2)(i+11,j-8));
    float4 pixel20 = read_imagef(inputImage,sampler,(int2)(i+11,j-9));
    float4 pixel21 = read_imagef(inputImage,sampler,(int2)(i+11,j-10));
    float4 pixel22 = read_imagef(inputImage,sampler,(int2)(i+11,j-11));
    float4 pixel23 = read_imagef(inputImage,sampler,(int2)(i+10,j+11));
    float4 pixel24 = read_imagef(inputImage,sampler,(int2)(i+10,j+10));
    float4 pixel25 = read_imagef(inputImage,sampler,(int2)(i+10,j+9));
    float4 pixel26 = read_imagef(inputImage,sampler,(int2)(i+10,j+8));
    float4 pixel27 = read_imagef(inputImage,sampler,(int2)(i+10,j+7));
    float4 pixel28 = read_imagef(inputImage,sampler,(int2)(i+10,j+6));
    float4 pixel29 = read_imagef(inputImage,sampler,(int2)(i+10,j+5));
    float4 pixel30 = read_imagef(inputImage,sampler,(int2)(i+10,j+4));
    float4 pixel31 = read_imagef(inputImage,sampler,(int2)(i+10,j+3));
    float4 pixel32 = read_imagef(inputImage,sampler,(int2)(i+10,j+2));
    float4 pixel33 = read_imagef(inputImage,sampler,(int2)(i+10,j+1));
    float4 pixel34 = read_imagef(inputImage,sampler,(int2)(i+10,j+0));
    float4 pixel35 = read_imagef(inputImage,sampler,(int2)(i+10,j-1));
    float4 pixel36 = read_imagef(inputImage,sampler,(int2)(i+10,j-2));
    float4 pixel37 = read_imagef(inputImage,sampler,(int2)(i+10,j-3));
    float4 pixel38 = read_imagef(inputImage,sampler,(int2)(i+10,j-4));
    float4 pixel39 = read_imagef(inputImage,sampler,(int2)(i+10,j-5));
    float4 pixel40 = read_imagef(inputImage,sampler,(int2)(i+10,j-6));
    float4 pixel41 = read_imagef(inputImage,sampler,(int2)(i+10,j-7));
    float4 pixel42 = read_imagef(inputImage,sampler,(int2)(i+10,j-8));
    float4 pixel43 = read_imagef(inputImage,sampler,(int2)(i+10,j-9));
    float4 pixel44 = read_imagef(inputImage,sampler,(int2)(i+10,j-10));
    float4 pixel45 = read_imagef(inputImage,sampler,(int2)(i+10,j-11));
    float4 pixel46 = read_imagef(inputImage,sampler,(int2)(i+9,j+11));
    float4 pixel47 = read_imagef(inputImage,sampler,(int2)(i+9,j+10));
    float4 pixel48 = read_imagef(inputImage,sampler,(int2)(i+9,j+9));
    float4 pixel49 = read_imagef(inputImage,sampler,(int2)(i+9,j+8));
    float4 pixel50 = read_imagef(inputImage,sampler,(int2)(i+9,j+7));
    float4 pixel51 = read_imagef(inputImage,sampler,(int2)(i+9,j+6));
    float4 pixel52 = read_imagef(inputImage,sampler,(int2)(i+9,j+5));
    float4 pixel53 = read_imagef(inputImage,sampler,(int2)(i+9,j+4));
    float4 pixel54 = read_imagef(inputImage,sampler,(int2)(i+9,j+3));
    float4 pixel55 = read_imagef(inputImage,sampler,(int2)(i+9,j+2));
    float4 pixel56 = read_imagef(inputImage,sampler,(int2)(i+9,j+1));
    float4 pixel57 = read_imagef(inputImage,sampler,(int2)(i+9,j+0));
    float4 pixel58 = read_imagef(inputImage,sampler,(int2)(i+9,j-1));
    float4 pixel59 = read_imagef(inputImage,sampler,(int2)(i+9,j-2));
    float4 pixel60 = read_imagef(inputImage,sampler,(int2)(i+9,j-3));
    float4 pixel61 = read_imagef(inputImage,sampler,(int2)(i+9,j-4));
    float4 pixel62 = read_imagef(inputImage,sampler,(int2)(i+9,j-5));
    float4 pixel63 = read_imagef(inputImage,sampler,(int2)(i+9,j-6));
    float4 pixel64 = read_imagef(inputImage,sampler,(int2)(i+9,j-7));
    float4 pixel65 = read_imagef(inputImage,sampler,(int2)(i+9,j-8));
    float4 pixel66 = read_imagef(inputImage,sampler,(int2)(i+9,j-9));
    float4 pixel67 = read_imagef(inputImage,sampler,(int2)(i+9,j-10));
    float4 pixel68 = read_imagef(inputImage,sampler,(int2)(i+9,j-11));
    float4 pixel69 = read_imagef(inputImage,sampler,(int2)(i+8,j+11));
    float4 pixel70 = read_imagef(inputImage,sampler,(int2)(i+8,j+10));
    float4 pixel71 = read_imagef(inputImage,sampler,(int2)(i+8,j+9));
    float4 pixel72 = read_imagef(inputImage,sampler,(int2)(i+8,j+8));
    float4 pixel73 = read_imagef(inputImage,sampler,(int2)(i+8,j+7));
    float4 pixel74 = read_imagef(inputImage,sampler,(int2)(i+8,j+6));
    float4 pixel75 = read_imagef(inputImage,sampler,(int2)(i+8,j+5));
    float4 pixel76 = read_imagef(inputImage,sampler,(int2)(i+8,j+4));
    float4 pixel77 = read_imagef(inputImage,sampler,(int2)(i+8,j+3));
    float4 pixel78 = read_imagef(inputImage,sampler,(int2)(i+8,j+2));
    float4 pixel79 = read_imagef(inputImage,sampler,(int2)(i+8,j+1));
    float4 pixel80 = read_imagef(inputImage,sampler,(int2)(i+8,j+0));
    float4 pixel81 = read_imagef(inputImage,sampler,(int2)(i+8,j-1));
    float4 pixel82 = read_imagef(inputImage,sampler,(int2)(i+8,j-2));
    float4 pixel83 = read_imagef(inputImage,sampler,(int2)(i+8,j-3));
    float4 pixel84 = read_imagef(inputImage,sampler,(int2)(i+8,j-4));
    float4 pixel85 = read_imagef(inputImage,sampler,(int2)(i+8,j-5));
    float4 pixel86 = read_imagef(inputImage,sampler,(int2)(i+8,j-6));
    float4 pixel87 = read_imagef(inputImage,sampler,(int2)(i+8,j-7));
    float4 pixel88 = read_imagef(inputImage,sampler,(int2)(i+8,j-8));
    float4 pixel89 = read_imagef(inputImage,sampler,(int2)(i+8,j-9));
    float4 pixel90 = read_imagef(inputImage,sampler,(int2)(i+8,j-10));
    float4 pixel91 = read_imagef(inputImage,sampler,(int2)(i+8,j-11));
    float4 pixel92 = read_imagef(inputImage,sampler,(int2)(i+7,j+11));
    float4 pixel93 = read_imagef(inputImage,sampler,(int2)(i+7,j+10));
    float4 pixel94 = read_imagef(inputImage,sampler,(int2)(i+7,j+9));
    float4 pixel95 = read_imagef(inputImage,sampler,(int2)(i+7,j+8));
    float4 pixel96 = read_imagef(inputImage,sampler,(int2)(i+7,j+7));
    float4 pixel97 = read_imagef(inputImage,sampler,(int2)(i+7,j+6));
    float4 pixel98 = read_imagef(inputImage,sampler,(int2)(i+7,j+5));
    float4 pixel99 = read_imagef(inputImage,sampler,(int2)(i+7,j+4));
    float4 pixel100 = read_imagef(inputImage,sampler,(int2)(i+7,j+3));
    float4 pixel101 = read_imagef(inputImage,sampler,(int2)(i+7,j+2));
    float4 pixel102 = read_imagef(inputImage,sampler,(int2)(i+7,j+1));
    float4 pixel103 = read_imagef(inputImage,sampler,(int2)(i+7,j+0));
    float4 pixel104 = read_imagef(inputImage,sampler,(int2)(i+7,j-1));
    float4 pixel105 = read_imagef(inputImage,sampler,(int2)(i+7,j-2));
    float4 pixel106 = read_imagef(inputImage,sampler,(int2)(i+7,j-3));
    float4 pixel107 = read_imagef(inputImage,sampler,(int2)(i+7,j-4));
    float4 pixel108 = read_imagef(inputImage,sampler,(int2)(i+7,j-5));
    float4 pixel109 = read_imagef(inputImage,sampler,(int2)(i+7,j-6));
    float4 pixel110 = read_imagef(inputImage,sampler,(int2)(i+7,j-7));
    float4 pixel111 = read_imagef(inputImage,sampler,(int2)(i+7,j-8));
    float4 pixel112 = read_imagef(inputImage,sampler,(int2)(i+7,j-9));
    float4 pixel113 = read_imagef(inputImage,sampler,(int2)(i+7,j-10));
    float4 pixel114 = read_imagef(inputImage,sampler,(int2)(i+7,j-11));
    float4 pixel115 = read_imagef(inputImage,sampler,(int2)(i+6,j+11));
    float4 pixel116 = read_imagef(inputImage,sampler,(int2)(i+6,j+10));
    float4 pixel117 = read_imagef(inputImage,sampler,(int2)(i+6,j+9));
    float4 pixel118 = read_imagef(inputImage,sampler,(int2)(i+6,j+8));
    float4 pixel119 = read_imagef(inputImage,sampler,(int2)(i+6,j+7));
    float4 pixel120 = read_imagef(inputImage,sampler,(int2)(i+6,j+6));
    float4 pixel121 = read_imagef(inputImage,sampler,(int2)(i+6,j+5));
    float4 pixel122 = read_imagef(inputImage,sampler,(int2)(i+6,j+4));
    float4 pixel123 = read_imagef(inputImage,sampler,(int2)(i+6,j+3));
    float4 pixel124 = read_imagef(inputImage,sampler,(int2)(i+6,j+2));
    float4 pixel125 = read_imagef(inputImage,sampler,(int2)(i+6,j+1));
    float4 pixel126 = read_imagef(inputImage,sampler,(int2)(i+6,j+0));
    float4 pixel127 = read_imagef(inputImage,sampler,(int2)(i+6,j-1));
    float4 pixel128 = read_imagef(inputImage,sampler,(int2)(i+6,j-2));
    float4 pixel129 = read_imagef(inputImage,sampler,(int2)(i+6,j-3));
    float4 pixel130 = read_imagef(inputImage,sampler,(int2)(i+6,j-4));
    float4 pixel131 = read_imagef(inputImage,sampler,(int2)(i+6,j-5));
    float4 pixel132 = read_imagef(inputImage,sampler,(int2)(i+6,j-6));
    float4 pixel133 = read_imagef(inputImage,sampler,(int2)(i+6,j-7));
    float4 pixel134 = read_imagef(inputImage,sampler,(int2)(i+6,j-8));
    float4 pixel135 = read_imagef(inputImage,sampler,(int2)(i+6,j-9));
    float4 pixel136 = read_imagef(inputImage,sampler,(int2)(i+6,j-10));
    float4 pixel137 = read_imagef(inputImage,sampler,(int2)(i+6,j-11));
    float4 pixel138 = read_imagef(inputImage,sampler,(int2)(i+5,j+11));
    float4 pixel139 = read_imagef(inputImage,sampler,(int2)(i+5,j+10));
    float4 pixel140 = read_imagef(inputImage,sampler,(int2)(i+5,j+9));
    float4 pixel141 = read_imagef(inputImage,sampler,(int2)(i+5,j+8));
    float4 pixel142 = read_imagef(inputImage,sampler,(int2)(i+5,j+7));
    float4 pixel143 = read_imagef(inputImage,sampler,(int2)(i+5,j+6));
    float4 pixel144 = read_imagef(inputImage,sampler,(int2)(i+5,j+5));
    float4 pixel145 = read_imagef(inputImage,sampler,(int2)(i+5,j+4));
    float4 pixel146 = read_imagef(inputImage,sampler,(int2)(i+5,j+3));
    float4 pixel147 = read_imagef(inputImage,sampler,(int2)(i+5,j+2));
    float4 pixel148 = read_imagef(inputImage,sampler,(int2)(i+5,j+1));
    float4 pixel149 = read_imagef(inputImage,sampler,(int2)(i+5,j+0));
    float4 pixel150 = read_imagef(inputImage,sampler,(int2)(i+5,j-1));
    float4 pixel151 = read_imagef(inputImage,sampler,(int2)(i+5,j-2));
    float4 pixel152 = read_imagef(inputImage,sampler,(int2)(i+5,j-3));
    float4 pixel153 = read_imagef(inputImage,sampler,(int2)(i+5,j-4));
    float4 pixel154 = read_imagef(inputImage,sampler,(int2)(i+5,j-5));
    float4 pixel155 = read_imagef(inputImage,sampler,(int2)(i+5,j-6));
    float4 pixel156 = read_imagef(inputImage,sampler,(int2)(i+5,j-7));
    float4 pixel157 = read_imagef(inputImage,sampler,(int2)(i+5,j-8));
    float4 pixel158 = read_imagef(inputImage,sampler,(int2)(i+5,j-9));
    float4 pixel159 = read_imagef(inputImage,sampler,(int2)(i+5,j-10));
    float4 pixel160 = read_imagef(inputImage,sampler,(int2)(i+5,j-11));
    float4 pixel161 = read_imagef(inputImage,sampler,(int2)(i+4,j+11));
    float4 pixel162 = read_imagef(inputImage,sampler,(int2)(i+4,j+10));
    float4 pixel163 = read_imagef(inputImage,sampler,(int2)(i+4,j+9));
    float4 pixel164 = read_imagef(inputImage,sampler,(int2)(i+4,j+8));
    float4 pixel165 = read_imagef(inputImage,sampler,(int2)(i+4,j+7));
    float4 pixel166 = read_imagef(inputImage,sampler,(int2)(i+4,j+6));
    float4 pixel167 = read_imagef(inputImage,sampler,(int2)(i+4,j+5));
    float4 pixel168 = read_imagef(inputImage,sampler,(int2)(i+4,j+4));
    float4 pixel169 = read_imagef(inputImage,sampler,(int2)(i+4,j+3));
    float4 pixel170 = read_imagef(inputImage,sampler,(int2)(i+4,j+2));
    float4 pixel171 = read_imagef(inputImage,sampler,(int2)(i+4,j+1));
    float4 pixel172 = read_imagef(inputImage,sampler,(int2)(i+4,j+0));
    float4 pixel173 = read_imagef(inputImage,sampler,(int2)(i+4,j-1));
    float4 pixel174 = read_imagef(inputImage,sampler,(int2)(i+4,j-2));
    float4 pixel175 = read_imagef(inputImage,sampler,(int2)(i+4,j-3));
    float4 pixel176 = read_imagef(inputImage,sampler,(int2)(i+4,j-4));
    float4 pixel177 = read_imagef(inputImage,sampler,(int2)(i+4,j-5));
    float4 pixel178 = read_imagef(inputImage,sampler,(int2)(i+4,j-6));
    float4 pixel179 = read_imagef(inputImage,sampler,(int2)(i+4,j-7));
    float4 pixel180 = read_imagef(inputImage,sampler,(int2)(i+4,j-8));
    float4 pixel181 = read_imagef(inputImage,sampler,(int2)(i+4,j-9));
    float4 pixel182 = read_imagef(inputImage,sampler,(int2)(i+4,j-10));
    float4 pixel183 = read_imagef(inputImage,sampler,(int2)(i+4,j-11));
    float4 pixel184 = read_imagef(inputImage,sampler,(int2)(i+3,j+11));
    float4 pixel185 = read_imagef(inputImage,sampler,(int2)(i+3,j+10));
    float4 pixel186 = read_imagef(inputImage,sampler,(int2)(i+3,j+9));
    float4 pixel187 = read_imagef(inputImage,sampler,(int2)(i+3,j+8));
    float4 pixel188 = read_imagef(inputImage,sampler,(int2)(i+3,j+7));
    float4 pixel189 = read_imagef(inputImage,sampler,(int2)(i+3,j+6));
    float4 pixel190 = read_imagef(inputImage,sampler,(int2)(i+3,j+5));
    float4 pixel191 = read_imagef(inputImage,sampler,(int2)(i+3,j+4));
    float4 pixel192 = read_imagef(inputImage,sampler,(int2)(i+3,j+3));
    float4 pixel193 = read_imagef(inputImage,sampler,(int2)(i+3,j+2));
    float4 pixel194 = read_imagef(inputImage,sampler,(int2)(i+3,j+1));
    float4 pixel195 = read_imagef(inputImage,sampler,(int2)(i+3,j+0));
    float4 pixel196 = read_imagef(inputImage,sampler,(int2)(i+3,j-1));
    float4 pixel197 = read_imagef(inputImage,sampler,(int2)(i+3,j-2));
    float4 pixel198 = read_imagef(inputImage,sampler,(int2)(i+3,j-3));
    float4 pixel199 = read_imagef(inputImage,sampler,(int2)(i+3,j-4));
    float4 pixel200 = read_imagef(inputImage,sampler,(int2)(i+3,j-5));
    float4 pixel201 = read_imagef(inputImage,sampler,(int2)(i+3,j-6));
    float4 pixel202 = read_imagef(inputImage,sampler,(int2)(i+3,j-7));
    float4 pixel203 = read_imagef(inputImage,sampler,(int2)(i+3,j-8));
    float4 pixel204 = read_imagef(inputImage,sampler,(int2)(i+3,j-9));
    float4 pixel205 = read_imagef(inputImage,sampler,(int2)(i+3,j-10));
    float4 pixel206 = read_imagef(inputImage,sampler,(int2)(i+3,j-11));
    float4 pixel207 = read_imagef(inputImage,sampler,(int2)(i+2,j+11));
    float4 pixel208 = read_imagef(inputImage,sampler,(int2)(i+2,j+10));
    float4 pixel209 = read_imagef(inputImage,sampler,(int2)(i+2,j+9));
    float4 pixel210 = read_imagef(inputImage,sampler,(int2)(i+2,j+8));
    float4 pixel211 = read_imagef(inputImage,sampler,(int2)(i+2,j+7));
    float4 pixel212 = read_imagef(inputImage,sampler,(int2)(i+2,j+6));
    float4 pixel213 = read_imagef(inputImage,sampler,(int2)(i+2,j+5));
    float4 pixel214 = read_imagef(inputImage,sampler,(int2)(i+2,j+4));
    float4 pixel215 = read_imagef(inputImage,sampler,(int2)(i+2,j+3));
    float4 pixel216 = read_imagef(inputImage,sampler,(int2)(i+2,j+2));
    float4 pixel217 = read_imagef(inputImage,sampler,(int2)(i+2,j+1));
    float4 pixel218 = read_imagef(inputImage,sampler,(int2)(i+2,j+0));
    float4 pixel219 = read_imagef(inputImage,sampler,(int2)(i+2,j-1));
    float4 pixel220 = read_imagef(inputImage,sampler,(int2)(i+2,j-2));
    float4 pixel221 = read_imagef(inputImage,sampler,(int2)(i+2,j-3));
    float4 pixel222 = read_imagef(inputImage,sampler,(int2)(i+2,j-4));
    float4 pixel223 = read_imagef(inputImage,sampler,(int2)(i+2,j-5));
    float4 pixel224 = read_imagef(inputImage,sampler,(int2)(i+2,j-6));
    float4 pixel225 = read_imagef(inputImage,sampler,(int2)(i+2,j-7));
    float4 pixel226 = read_imagef(inputImage,sampler,(int2)(i+2,j-8));
    float4 pixel227 = read_imagef(inputImage,sampler,(int2)(i+2,j-9));
    float4 pixel228 = read_imagef(inputImage,sampler,(int2)(i+2,j-10));
    float4 pixel229 = read_imagef(inputImage,sampler,(int2)(i+2,j-11));
    float4 pixel230 = read_imagef(inputImage,sampler,(int2)(i+1,j+11));
    float4 pixel231 = read_imagef(inputImage,sampler,(int2)(i+1,j+10));
    float4 pixel232 = read_imagef(inputImage,sampler,(int2)(i+1,j+9));
    float4 pixel233 = read_imagef(inputImage,sampler,(int2)(i+1,j+8));
    float4 pixel234 = read_imagef(inputImage,sampler,(int2)(i+1,j+7));
    float4 pixel235 = read_imagef(inputImage,sampler,(int2)(i+1,j+6));
    float4 pixel236 = read_imagef(inputImage,sampler,(int2)(i+1,j+5));
    float4 pixel237 = read_imagef(inputImage,sampler,(int2)(i+1,j+4));
    float4 pixel238 = read_imagef(inputImage,sampler,(int2)(i+1,j+3));
    float4 pixel239 = read_imagef(inputImage,sampler,(int2)(i+1,j+2));
    float4 pixel240 = read_imagef(inputImage,sampler,(int2)(i+1,j+1));
    float4 pixel241 = read_imagef(inputImage,sampler,(int2)(i+1,j+0));
    float4 pixel242 = read_imagef(inputImage,sampler,(int2)(i+1,j-1));
    float4 pixel243 = read_imagef(inputImage,sampler,(int2)(i+1,j-2));
    float4 pixel244 = read_imagef(inputImage,sampler,(int2)(i+1,j-3));
    float4 pixel245 = read_imagef(inputImage,sampler,(int2)(i+1,j-4));
    float4 pixel246 = read_imagef(inputImage,sampler,(int2)(i+1,j-5));
    float4 pixel247 = read_imagef(inputImage,sampler,(int2)(i+1,j-6));
    float4 pixel248 = read_imagef(inputImage,sampler,(int2)(i+1,j-7));
    float4 pixel249 = read_imagef(inputImage,sampler,(int2)(i+1,j-8));
    float4 pixel250 = read_imagef(inputImage,sampler,(int2)(i+1,j-9));
    float4 pixel251 = read_imagef(inputImage,sampler,(int2)(i+1,j-10));
    float4 pixel252 = read_imagef(inputImage,sampler,(int2)(i+1,j-11));
    float4 pixel253 = read_imagef(inputImage,sampler,(int2)(i-0,j+11));
    float4 pixel254 = read_imagef(inputImage,sampler,(int2)(i-0,j+10));
    float4 pixel255 = read_imagef(inputImage,sampler,(int2)(i-0,j+9));
    float4 pixel256 = read_imagef(inputImage,sampler,(int2)(i-0,j+8));
    float4 pixel257 = read_imagef(inputImage,sampler,(int2)(i-0,j+7));
    float4 pixel258 = read_imagef(inputImage,sampler,(int2)(i-0,j+6));
    float4 pixel259 = read_imagef(inputImage,sampler,(int2)(i-0,j+5));
    float4 pixel260 = read_imagef(inputImage,sampler,(int2)(i-0,j+4));
    float4 pixel261 = read_imagef(inputImage,sampler,(int2)(i-0,j+3));
    float4 pixel262 = read_imagef(inputImage,sampler,(int2)(i-0,j+2));
    float4 pixel263 = read_imagef(inputImage,sampler,(int2)(i-0,j+1));
    float4 pixel264 = read_imagef(inputImage,sampler,(int2)(i-0,j+0));
    float4 pixel265 = read_imagef(inputImage,sampler,(int2)(i-0,j-1));
    float4 pixel266 = read_imagef(inputImage,sampler,(int2)(i-0,j-2));
    float4 pixel267 = read_imagef(inputImage,sampler,(int2)(i-0,j-3));
    float4 pixel268 = read_imagef(inputImage,sampler,(int2)(i-0,j-4));
    float4 pixel269 = read_imagef(inputImage,sampler,(int2)(i-0,j-5));
    float4 pixel270 = read_imagef(inputImage,sampler,(int2)(i-0,j-6));
    float4 pixel271 = read_imagef(inputImage,sampler,(int2)(i-0,j-7));
    float4 pixel272 = read_imagef(inputImage,sampler,(int2)(i-0,j-8));
    float4 pixel273 = read_imagef(inputImage,sampler,(int2)(i-0,j-9));
    float4 pixel274 = read_imagef(inputImage,sampler,(int2)(i-0,j-10));
    float4 pixel275 = read_imagef(inputImage,sampler,(int2)(i-0,j-11));
    float4 pixel276 = read_imagef(inputImage,sampler,(int2)(i-1,j+11));
    float4 pixel277 = read_imagef(inputImage,sampler,(int2)(i-1,j+10));
    float4 pixel278 = read_imagef(inputImage,sampler,(int2)(i-1,j+9));
    float4 pixel279 = read_imagef(inputImage,sampler,(int2)(i-1,j+8));
    float4 pixel280 = read_imagef(inputImage,sampler,(int2)(i-1,j+7));
    float4 pixel281 = read_imagef(inputImage,sampler,(int2)(i-1,j+6));
    float4 pixel282 = read_imagef(inputImage,sampler,(int2)(i-1,j+5));
    float4 pixel283 = read_imagef(inputImage,sampler,(int2)(i-1,j+4));
    float4 pixel284 = read_imagef(inputImage,sampler,(int2)(i-1,j+3));
    float4 pixel285 = read_imagef(inputImage,sampler,(int2)(i-1,j+2));
    float4 pixel286 = read_imagef(inputImage,sampler,(int2)(i-1,j+1));
    float4 pixel287 = read_imagef(inputImage,sampler,(int2)(i-1,j+0));
    float4 pixel288 = read_imagef(inputImage,sampler,(int2)(i-1,j-1));
    float4 pixel289 = read_imagef(inputImage,sampler,(int2)(i-1,j-2));
    float4 pixel290 = read_imagef(inputImage,sampler,(int2)(i-1,j-3));
    float4 pixel291 = read_imagef(inputImage,sampler,(int2)(i-1,j-4));
    float4 pixel292 = read_imagef(inputImage,sampler,(int2)(i-1,j-5));
    float4 pixel293 = read_imagef(inputImage,sampler,(int2)(i-1,j-6));
    float4 pixel294 = read_imagef(inputImage,sampler,(int2)(i-1,j-7));
    float4 pixel295 = read_imagef(inputImage,sampler,(int2)(i-1,j-8));
    float4 pixel296 = read_imagef(inputImage,sampler,(int2)(i-1,j-9));
    float4 pixel297 = read_imagef(inputImage,sampler,(int2)(i-1,j-10));
    float4 pixel298 = read_imagef(inputImage,sampler,(int2)(i-1,j-11));
    float4 pixel299 = read_imagef(inputImage,sampler,(int2)(i-2,j+11));
    float4 pixel300 = read_imagef(inputImage,sampler,(int2)(i-2,j+10));
    float4 pixel301 = read_imagef(inputImage,sampler,(int2)(i-2,j+9));
    float4 pixel302 = read_imagef(inputImage,sampler,(int2)(i-2,j+8));
    float4 pixel303 = read_imagef(inputImage,sampler,(int2)(i-2,j+7));
    float4 pixel304 = read_imagef(inputImage,sampler,(int2)(i-2,j+6));
    float4 pixel305 = read_imagef(inputImage,sampler,(int2)(i-2,j+5));
    float4 pixel306 = read_imagef(inputImage,sampler,(int2)(i-2,j+4));
    float4 pixel307 = read_imagef(inputImage,sampler,(int2)(i-2,j+3));
    float4 pixel308 = read_imagef(inputImage,sampler,(int2)(i-2,j+2));
    float4 pixel309 = read_imagef(inputImage,sampler,(int2)(i-2,j+1));
    float4 pixel310 = read_imagef(inputImage,sampler,(int2)(i-2,j+0));
    float4 pixel311 = read_imagef(inputImage,sampler,(int2)(i-2,j-1));
    float4 pixel312 = read_imagef(inputImage,sampler,(int2)(i-2,j-2));
    float4 pixel313 = read_imagef(inputImage,sampler,(int2)(i-2,j-3));
    float4 pixel314 = read_imagef(inputImage,sampler,(int2)(i-2,j-4));
    float4 pixel315 = read_imagef(inputImage,sampler,(int2)(i-2,j-5));
    float4 pixel316 = read_imagef(inputImage,sampler,(int2)(i-2,j-6));
    float4 pixel317 = read_imagef(inputImage,sampler,(int2)(i-2,j-7));
    float4 pixel318 = read_imagef(inputImage,sampler,(int2)(i-2,j-8));
    float4 pixel319 = read_imagef(inputImage,sampler,(int2)(i-2,j-9));
    float4 pixel320 = read_imagef(inputImage,sampler,(int2)(i-2,j-10));
    float4 pixel321 = read_imagef(inputImage,sampler,(int2)(i-2,j-11));
    float4 pixel322 = read_imagef(inputImage,sampler,(int2)(i-3,j+11));
    float4 pixel323 = read_imagef(inputImage,sampler,(int2)(i-3,j+10));
    float4 pixel324 = read_imagef(inputImage,sampler,(int2)(i-3,j+9));
    float4 pixel325 = read_imagef(inputImage,sampler,(int2)(i-3,j+8));
    float4 pixel326 = read_imagef(inputImage,sampler,(int2)(i-3,j+7));
    float4 pixel327 = read_imagef(inputImage,sampler,(int2)(i-3,j+6));
    float4 pixel328 = read_imagef(inputImage,sampler,(int2)(i-3,j+5));
    float4 pixel329 = read_imagef(inputImage,sampler,(int2)(i-3,j+4));
    float4 pixel330 = read_imagef(inputImage,sampler,(int2)(i-3,j+3));
    float4 pixel331 = read_imagef(inputImage,sampler,(int2)(i-3,j+2));
    float4 pixel332 = read_imagef(inputImage,sampler,(int2)(i-3,j+1));
    float4 pixel333 = read_imagef(inputImage,sampler,(int2)(i-3,j+0));
    float4 pixel334 = read_imagef(inputImage,sampler,(int2)(i-3,j-1));
    float4 pixel335 = read_imagef(inputImage,sampler,(int2)(i-3,j-2));
    float4 pixel336 = read_imagef(inputImage,sampler,(int2)(i-3,j-3));
    float4 pixel337 = read_imagef(inputImage,sampler,(int2)(i-3,j-4));
    float4 pixel338 = read_imagef(inputImage,sampler,(int2)(i-3,j-5));
    float4 pixel339 = read_imagef(inputImage,sampler,(int2)(i-3,j-6));
    float4 pixel340 = read_imagef(inputImage,sampler,(int2)(i-3,j-7));
    float4 pixel341 = read_imagef(inputImage,sampler,(int2)(i-3,j-8));
    float4 pixel342 = read_imagef(inputImage,sampler,(int2)(i-3,j-9));
    float4 pixel343 = read_imagef(inputImage,sampler,(int2)(i-3,j-10));
    float4 pixel344 = read_imagef(inputImage,sampler,(int2)(i-3,j-11));
    float4 pixel345 = read_imagef(inputImage,sampler,(int2)(i-4,j+11));
    float4 pixel346 = read_imagef(inputImage,sampler,(int2)(i-4,j+10));
    float4 pixel347 = read_imagef(inputImage,sampler,(int2)(i-4,j+9));
    float4 pixel348 = read_imagef(inputImage,sampler,(int2)(i-4,j+8));
    float4 pixel349 = read_imagef(inputImage,sampler,(int2)(i-4,j+7));
    float4 pixel350 = read_imagef(inputImage,sampler,(int2)(i-4,j+6));
    float4 pixel351 = read_imagef(inputImage,sampler,(int2)(i-4,j+5));
    float4 pixel352 = read_imagef(inputImage,sampler,(int2)(i-4,j+4));
    float4 pixel353 = read_imagef(inputImage,sampler,(int2)(i-4,j+3));
    float4 pixel354 = read_imagef(inputImage,sampler,(int2)(i-4,j+2));
    float4 pixel355 = read_imagef(inputImage,sampler,(int2)(i-4,j+1));
    float4 pixel356 = read_imagef(inputImage,sampler,(int2)(i-4,j+0));
    float4 pixel357 = read_imagef(inputImage,sampler,(int2)(i-4,j-1));
    float4 pixel358 = read_imagef(inputImage,sampler,(int2)(i-4,j-2));
    float4 pixel359 = read_imagef(inputImage,sampler,(int2)(i-4,j-3));
    float4 pixel360 = read_imagef(inputImage,sampler,(int2)(i-4,j-4));
    float4 pixel361 = read_imagef(inputImage,sampler,(int2)(i-4,j-5));
    float4 pixel362 = read_imagef(inputImage,sampler,(int2)(i-4,j-6));
    float4 pixel363 = read_imagef(inputImage,sampler,(int2)(i-4,j-7));
    float4 pixel364 = read_imagef(inputImage,sampler,(int2)(i-4,j-8));
    float4 pixel365 = read_imagef(inputImage,sampler,(int2)(i-4,j-9));
    float4 pixel366 = read_imagef(inputImage,sampler,(int2)(i-4,j-10));
    float4 pixel367 = read_imagef(inputImage,sampler,(int2)(i-4,j-11));
    float4 pixel368 = read_imagef(inputImage,sampler,(int2)(i-5,j+11));
    float4 pixel369 = read_imagef(inputImage,sampler,(int2)(i-5,j+10));
    float4 pixel370 = read_imagef(inputImage,sampler,(int2)(i-5,j+9));
    float4 pixel371 = read_imagef(inputImage,sampler,(int2)(i-5,j+8));
    float4 pixel372 = read_imagef(inputImage,sampler,(int2)(i-5,j+7));
    float4 pixel373 = read_imagef(inputImage,sampler,(int2)(i-5,j+6));
    float4 pixel374 = read_imagef(inputImage,sampler,(int2)(i-5,j+5));
    float4 pixel375 = read_imagef(inputImage,sampler,(int2)(i-5,j+4));
    float4 pixel376 = read_imagef(inputImage,sampler,(int2)(i-5,j+3));
    float4 pixel377 = read_imagef(inputImage,sampler,(int2)(i-5,j+2));
    float4 pixel378 = read_imagef(inputImage,sampler,(int2)(i-5,j+1));
    float4 pixel379 = read_imagef(inputImage,sampler,(int2)(i-5,j+0));
    float4 pixel380 = read_imagef(inputImage,sampler,(int2)(i-5,j-1));
    float4 pixel381 = read_imagef(inputImage,sampler,(int2)(i-5,j-2));
    float4 pixel382 = read_imagef(inputImage,sampler,(int2)(i-5,j-3));
    float4 pixel383 = read_imagef(inputImage,sampler,(int2)(i-5,j-4));
    float4 pixel384 = read_imagef(inputImage,sampler,(int2)(i-5,j-5));
    float4 pixel385 = read_imagef(inputImage,sampler,(int2)(i-5,j-6));
    float4 pixel386 = read_imagef(inputImage,sampler,(int2)(i-5,j-7));
    float4 pixel387 = read_imagef(inputImage,sampler,(int2)(i-5,j-8));
    float4 pixel388 = read_imagef(inputImage,sampler,(int2)(i-5,j-9));
    float4 pixel389 = read_imagef(inputImage,sampler,(int2)(i-5,j-10));
    float4 pixel390 = read_imagef(inputImage,sampler,(int2)(i-5,j-11));
    float4 pixel391 = read_imagef(inputImage,sampler,(int2)(i-6,j+11));
    float4 pixel392 = read_imagef(inputImage,sampler,(int2)(i-6,j+10));
    float4 pixel393 = read_imagef(inputImage,sampler,(int2)(i-6,j+9));
    float4 pixel394 = read_imagef(inputImage,sampler,(int2)(i-6,j+8));
    float4 pixel395 = read_imagef(inputImage,sampler,(int2)(i-6,j+7));
    float4 pixel396 = read_imagef(inputImage,sampler,(int2)(i-6,j+6));
    float4 pixel397 = read_imagef(inputImage,sampler,(int2)(i-6,j+5));
    float4 pixel398 = read_imagef(inputImage,sampler,(int2)(i-6,j+4));
    float4 pixel399 = read_imagef(inputImage,sampler,(int2)(i-6,j+3));
    float4 pixel400 = read_imagef(inputImage,sampler,(int2)(i-6,j+2));
    float4 pixel401 = read_imagef(inputImage,sampler,(int2)(i-6,j+1));
    float4 pixel402 = read_imagef(inputImage,sampler,(int2)(i-6,j+0));
    float4 pixel403 = read_imagef(inputImage,sampler,(int2)(i-6,j-1));
    float4 pixel404 = read_imagef(inputImage,sampler,(int2)(i-6,j-2));
    float4 pixel405 = read_imagef(inputImage,sampler,(int2)(i-6,j-3));
    float4 pixel406 = read_imagef(inputImage,sampler,(int2)(i-6,j-4));
    float4 pixel407 = read_imagef(inputImage,sampler,(int2)(i-6,j-5));
    float4 pixel408 = read_imagef(inputImage,sampler,(int2)(i-6,j-6));
    float4 pixel409 = read_imagef(inputImage,sampler,(int2)(i-6,j-7));
    float4 pixel410 = read_imagef(inputImage,sampler,(int2)(i-6,j-8));
    float4 pixel411 = read_imagef(inputImage,sampler,(int2)(i-6,j-9));
    float4 pixel412 = read_imagef(inputImage,sampler,(int2)(i-6,j-10));
    float4 pixel413 = read_imagef(inputImage,sampler,(int2)(i-6,j-11));
    float4 pixel414 = read_imagef(inputImage,sampler,(int2)(i-7,j+11));
    float4 pixel415 = read_imagef(inputImage,sampler,(int2)(i-7,j+10));
    float4 pixel416 = read_imagef(inputImage,sampler,(int2)(i-7,j+9));
    float4 pixel417 = read_imagef(inputImage,sampler,(int2)(i-7,j+8));
    float4 pixel418 = read_imagef(inputImage,sampler,(int2)(i-7,j+7));
    float4 pixel419 = read_imagef(inputImage,sampler,(int2)(i-7,j+6));
    float4 pixel420 = read_imagef(inputImage,sampler,(int2)(i-7,j+5));
    float4 pixel421 = read_imagef(inputImage,sampler,(int2)(i-7,j+4));
    float4 pixel422 = read_imagef(inputImage,sampler,(int2)(i-7,j+3));
    float4 pixel423 = read_imagef(inputImage,sampler,(int2)(i-7,j+2));
    float4 pixel424 = read_imagef(inputImage,sampler,(int2)(i-7,j+1));
    float4 pixel425 = read_imagef(inputImage,sampler,(int2)(i-7,j+0));
    float4 pixel426 = read_imagef(inputImage,sampler,(int2)(i-7,j-1));
    float4 pixel427 = read_imagef(inputImage,sampler,(int2)(i-7,j-2));
    float4 pixel428 = read_imagef(inputImage,sampler,(int2)(i-7,j-3));
    float4 pixel429 = read_imagef(inputImage,sampler,(int2)(i-7,j-4));
    float4 pixel430 = read_imagef(inputImage,sampler,(int2)(i-7,j-5));
    float4 pixel431 = read_imagef(inputImage,sampler,(int2)(i-7,j-6));
    float4 pixel432 = read_imagef(inputImage,sampler,(int2)(i-7,j-7));
    float4 pixel433 = read_imagef(inputImage,sampler,(int2)(i-7,j-8));
    float4 pixel434 = read_imagef(inputImage,sampler,(int2)(i-7,j-9));
    float4 pixel435 = read_imagef(inputImage,sampler,(int2)(i-7,j-10));
    float4 pixel436 = read_imagef(inputImage,sampler,(int2)(i-7,j-11));
    float4 pixel437 = read_imagef(inputImage,sampler,(int2)(i-8,j+11));
    float4 pixel438 = read_imagef(inputImage,sampler,(int2)(i-8,j+10));
    float4 pixel439 = read_imagef(inputImage,sampler,(int2)(i-8,j+9));
    float4 pixel440 = read_imagef(inputImage,sampler,(int2)(i-8,j+8));
    float4 pixel441 = read_imagef(inputImage,sampler,(int2)(i-8,j+7));
    float4 pixel442 = read_imagef(inputImage,sampler,(int2)(i-8,j+6));
    float4 pixel443 = read_imagef(inputImage,sampler,(int2)(i-8,j+5));
    float4 pixel444 = read_imagef(inputImage,sampler,(int2)(i-8,j+4));
    float4 pixel445 = read_imagef(inputImage,sampler,(int2)(i-8,j+3));
    float4 pixel446 = read_imagef(inputImage,sampler,(int2)(i-8,j+2));
    float4 pixel447 = read_imagef(inputImage,sampler,(int2)(i-8,j+1));
    float4 pixel448 = read_imagef(inputImage,sampler,(int2)(i-8,j+0));
    float4 pixel449 = read_imagef(inputImage,sampler,(int2)(i-8,j-1));
    float4 pixel450 = read_imagef(inputImage,sampler,(int2)(i-8,j-2));
    float4 pixel451 = read_imagef(inputImage,sampler,(int2)(i-8,j-3));
    float4 pixel452 = read_imagef(inputImage,sampler,(int2)(i-8,j-4));
    float4 pixel453 = read_imagef(inputImage,sampler,(int2)(i-8,j-5));
    float4 pixel454 = read_imagef(inputImage,sampler,(int2)(i-8,j-6));
    float4 pixel455 = read_imagef(inputImage,sampler,(int2)(i-8,j-7));
    float4 pixel456 = read_imagef(inputImage,sampler,(int2)(i-8,j-8));
    float4 pixel457 = read_imagef(inputImage,sampler,(int2)(i-8,j-9));
    float4 pixel458 = read_imagef(inputImage,sampler,(int2)(i-8,j-10));
    float4 pixel459 = read_imagef(inputImage,sampler,(int2)(i-8,j-11));
    float4 pixel460 = read_imagef(inputImage,sampler,(int2)(i-9,j+11));
    float4 pixel461 = read_imagef(inputImage,sampler,(int2)(i-9,j+10));
    float4 pixel462 = read_imagef(inputImage,sampler,(int2)(i-9,j+9));
    float4 pixel463 = read_imagef(inputImage,sampler,(int2)(i-9,j+8));
    float4 pixel464 = read_imagef(inputImage,sampler,(int2)(i-9,j+7));
    float4 pixel465 = read_imagef(inputImage,sampler,(int2)(i-9,j+6));
    float4 pixel466 = read_imagef(inputImage,sampler,(int2)(i-9,j+5));
    float4 pixel467 = read_imagef(inputImage,sampler,(int2)(i-9,j+4));
    float4 pixel468 = read_imagef(inputImage,sampler,(int2)(i-9,j+3));
    float4 pixel469 = read_imagef(inputImage,sampler,(int2)(i-9,j+2));
    float4 pixel470 = read_imagef(inputImage,sampler,(int2)(i-9,j+1));
    float4 pixel471 = read_imagef(inputImage,sampler,(int2)(i-9,j+0));
    float4 pixel472 = read_imagef(inputImage,sampler,(int2)(i-9,j-1));
    float4 pixel473 = read_imagef(inputImage,sampler,(int2)(i-9,j-2));
    float4 pixel474 = read_imagef(inputImage,sampler,(int2)(i-9,j-3));
    float4 pixel475 = read_imagef(inputImage,sampler,(int2)(i-9,j-4));
    float4 pixel476 = read_imagef(inputImage,sampler,(int2)(i-9,j-5));
    float4 pixel477 = read_imagef(inputImage,sampler,(int2)(i-9,j-6));
    float4 pixel478 = read_imagef(inputImage,sampler,(int2)(i-9,j-7));
    float4 pixel479 = read_imagef(inputImage,sampler,(int2)(i-9,j-8));
    float4 pixel480 = read_imagef(inputImage,sampler,(int2)(i-9,j-9));
    float4 pixel481 = read_imagef(inputImage,sampler,(int2)(i-9,j-10));
    float4 pixel482 = read_imagef(inputImage,sampler,(int2)(i-9,j-11));
    float4 pixel483 = read_imagef(inputImage,sampler,(int2)(i-10,j+11));
    float4 pixel484 = read_imagef(inputImage,sampler,(int2)(i-10,j+10));
    float4 pixel485 = read_imagef(inputImage,sampler,(int2)(i-10,j+9));
    float4 pixel486 = read_imagef(inputImage,sampler,(int2)(i-10,j+8));
    float4 pixel487 = read_imagef(inputImage,sampler,(int2)(i-10,j+7));
    float4 pixel488 = read_imagef(inputImage,sampler,(int2)(i-10,j+6));
    float4 pixel489 = read_imagef(inputImage,sampler,(int2)(i-10,j+5));
    float4 pixel490 = read_imagef(inputImage,sampler,(int2)(i-10,j+4));
    float4 pixel491 = read_imagef(inputImage,sampler,(int2)(i-10,j+3));
    float4 pixel492 = read_imagef(inputImage,sampler,(int2)(i-10,j+2));
    float4 pixel493 = read_imagef(inputImage,sampler,(int2)(i-10,j+1));
    float4 pixel494 = read_imagef(inputImage,sampler,(int2)(i-10,j+0));
    float4 pixel495 = read_imagef(inputImage,sampler,(int2)(i-10,j-1));
    float4 pixel496 = read_imagef(inputImage,sampler,(int2)(i-10,j-2));
    float4 pixel497 = read_imagef(inputImage,sampler,(int2)(i-10,j-3));
    float4 pixel498 = read_imagef(inputImage,sampler,(int2)(i-10,j-4));
    float4 pixel499 = read_imagef(inputImage,sampler,(int2)(i-10,j-5));
    float4 pixel500 = read_imagef(inputImage,sampler,(int2)(i-10,j-6));
    float4 pixel501 = read_imagef(inputImage,sampler,(int2)(i-10,j-7));
    float4 pixel502 = read_imagef(inputImage,sampler,(int2)(i-10,j-8));
    float4 pixel503 = read_imagef(inputImage,sampler,(int2)(i-10,j-9));
    float4 pixel504 = read_imagef(inputImage,sampler,(int2)(i-10,j-10));
    float4 pixel505 = read_imagef(inputImage,sampler,(int2)(i-10,j-11));
    float4 pixel506 = read_imagef(inputImage,sampler,(int2)(i-11,j+11));
    float4 pixel507 = read_imagef(inputImage,sampler,(int2)(i-11,j+10));
    float4 pixel508 = read_imagef(inputImage,sampler,(int2)(i-11,j+9));
    float4 pixel509 = read_imagef(inputImage,sampler,(int2)(i-11,j+8));
    float4 pixel510 = read_imagef(inputImage,sampler,(int2)(i-11,j+7));
    float4 pixel511 = read_imagef(inputImage,sampler,(int2)(i-11,j+6));
    float4 pixel512 = read_imagef(inputImage,sampler,(int2)(i-11,j+5));
    float4 pixel513 = read_imagef(inputImage,sampler,(int2)(i-11,j+4));
    float4 pixel514 = read_imagef(inputImage,sampler,(int2)(i-11,j+3));
    float4 pixel515 = read_imagef(inputImage,sampler,(int2)(i-11,j+2));
    float4 pixel516 = read_imagef(inputImage,sampler,(int2)(i-11,j+1));
    float4 pixel517 = read_imagef(inputImage,sampler,(int2)(i-11,j+0));
    float4 pixel518 = read_imagef(inputImage,sampler,(int2)(i-11,j-1));
    float4 pixel519 = read_imagef(inputImage,sampler,(int2)(i-11,j-2));
    float4 pixel520 = read_imagef(inputImage,sampler,(int2)(i-11,j-3));
    float4 pixel521 = read_imagef(inputImage,sampler,(int2)(i-11,j-4));
    float4 pixel522 = read_imagef(inputImage,sampler,(int2)(i-11,j-5));
    float4 pixel523 = read_imagef(inputImage,sampler,(int2)(i-11,j-6));
    float4 pixel524 = read_imagef(inputImage,sampler,(int2)(i-11,j-7));
    float4 pixel525 = read_imagef(inputImage,sampler,(int2)(i-11,j-8));
    float4 pixel526 = read_imagef(inputImage,sampler,(int2)(i-11,j-9));
    float4 pixel527 = read_imagef(inputImage,sampler,(int2)(i-11,j-10));
    float4 pixel528 = read_imagef(inputImage,sampler,(int2)(i-11,j-11));
    float pixel0_diffR = fabs(pixel0.x- (float)pixel_orig.x);
    float pixel0_diffG = fabs(pixel0.y- (float)pixel_orig.y);
    float pixel0_diffB = fabs(pixel0.z- (float)pixel_orig.z);
    float pixel0_diffA = fabs(pixel0.w- (float)pixel_orig.w);
   if ((pixel0_diffR<30)&& (pixel0_diffG< 30)&&(pixel0_diffB< 30 )&&(pixel0_diffA< 30)){
	    pixel_new += (pixel0)*(float)1.0; accumWeights += 1;
    }
    float pixel1_diffR = fabs(pixel1.x- (float)pixel_orig.x);
    float pixel1_diffG = fabs(pixel1.y- (float)pixel_orig.y);
    float pixel1_diffB = fabs(pixel1.z- (float)pixel_orig.z);
    float pixel1_diffA = fabs(pixel1.w- (float)pixel_orig.w);
   if ((pixel1_diffR<30)&& (pixel1_diffG< 30)&&(pixel1_diffB< 30 )&&(pixel1_diffA< 30)){
	    pixel_new += (pixel1)*(float)1.0; accumWeights += 1;
    }
    float pixel2_diffR = fabs(pixel2.x- (float)pixel_orig.x);
    float pixel2_diffG = fabs(pixel2.y- (float)pixel_orig.y);
    float pixel2_diffB = fabs(pixel2.z- (float)pixel_orig.z);
    float pixel2_diffA = fabs(pixel2.w- (float)pixel_orig.w);
   if ((pixel2_diffR<30)&& (pixel2_diffG< 30)&&(pixel2_diffB< 30 )&&(pixel2_diffA< 30)){
	    pixel_new += (pixel2)*(float)1.0; accumWeights += 1;
    }
    float pixel3_diffR = fabs(pixel3.x- (float)pixel_orig.x);
    float pixel3_diffG = fabs(pixel3.y- (float)pixel_orig.y);
    float pixel3_diffB = fabs(pixel3.z- (float)pixel_orig.z);
    float pixel3_diffA = fabs(pixel3.w- (float)pixel_orig.w);
   if ((pixel3_diffR<30)&& (pixel3_diffG< 30)&&(pixel3_diffB< 30 )&&(pixel3_diffA< 30)){
	    pixel_new += (pixel3)*(float)1.0; accumWeights += 1;
    }
    float pixel4_diffR = fabs(pixel4.x- (float)pixel_orig.x);
    float pixel4_diffG = fabs(pixel4.y- (float)pixel_orig.y);
    float pixel4_diffB = fabs(pixel4.z- (float)pixel_orig.z);
    float pixel4_diffA = fabs(pixel4.w- (float)pixel_orig.w);
   if ((pixel4_diffR<30)&& (pixel4_diffG< 30)&&(pixel4_diffB< 30 )&&(pixel4_diffA< 30)){
	    pixel_new += (pixel4)*(float)1.0; accumWeights += 1;
    }
    float pixel5_diffR = fabs(pixel5.x- (float)pixel_orig.x);
    float pixel5_diffG = fabs(pixel5.y- (float)pixel_orig.y);
    float pixel5_diffB = fabs(pixel5.z- (float)pixel_orig.z);
    float pixel5_diffA = fabs(pixel5.w- (float)pixel_orig.w);
   if ((pixel5_diffR<30)&& (pixel5_diffG< 30)&&(pixel5_diffB< 30 )&&(pixel5_diffA< 30)){
	    pixel_new += (pixel5)*(float)1.0; accumWeights += 1;
    }
    float pixel6_diffR = fabs(pixel6.x- (float)pixel_orig.x);
    float pixel6_diffG = fabs(pixel6.y- (float)pixel_orig.y);
    float pixel6_diffB = fabs(pixel6.z- (float)pixel_orig.z);
    float pixel6_diffA = fabs(pixel6.w- (float)pixel_orig.w);
   if ((pixel6_diffR<30)&& (pixel6_diffG< 30)&&(pixel6_diffB< 30 )&&(pixel6_diffA< 30)){
	    pixel_new += (pixel6)*(float)1.0; accumWeights += 1;
    }
    float pixel7_diffR = fabs(pixel7.x- (float)pixel_orig.x);
    float pixel7_diffG = fabs(pixel7.y- (float)pixel_orig.y);
    float pixel7_diffB = fabs(pixel7.z- (float)pixel_orig.z);
    float pixel7_diffA = fabs(pixel7.w- (float)pixel_orig.w);
   if ((pixel7_diffR<30)&& (pixel7_diffG< 30)&&(pixel7_diffB< 30 )&&(pixel7_diffA< 30)){
	    pixel_new += (pixel7)*(float)1.0; accumWeights += 1;
    }
    float pixel8_diffR = fabs(pixel8.x- (float)pixel_orig.x);
    float pixel8_diffG = fabs(pixel8.y- (float)pixel_orig.y);
    float pixel8_diffB = fabs(pixel8.z- (float)pixel_orig.z);
    float pixel8_diffA = fabs(pixel8.w- (float)pixel_orig.w);
   if ((pixel8_diffR<30)&& (pixel8_diffG< 30)&&(pixel8_diffB< 30 )&&(pixel8_diffA< 30)){
	    pixel_new += (pixel8)*(float)1.0; accumWeights += 1;
    }
    float pixel9_diffR = fabs(pixel9.x- (float)pixel_orig.x);
    float pixel9_diffG = fabs(pixel9.y- (float)pixel_orig.y);
    float pixel9_diffB = fabs(pixel9.z- (float)pixel_orig.z);
    float pixel9_diffA = fabs(pixel9.w- (float)pixel_orig.w);
   if ((pixel9_diffR<30)&& (pixel9_diffG< 30)&&(pixel9_diffB< 30 )&&(pixel9_diffA< 30)){
	    pixel_new += (pixel9)*(float)1.0; accumWeights += 1;
    }
    float pixel10_diffR = fabs(pixel10.x- (float)pixel_orig.x);
    float pixel10_diffG = fabs(pixel10.y- (float)pixel_orig.y);
    float pixel10_diffB = fabs(pixel10.z- (float)pixel_orig.z);
    float pixel10_diffA = fabs(pixel10.w- (float)pixel_orig.w);
   if ((pixel10_diffR<30)&& (pixel10_diffG< 30)&&(pixel10_diffB< 30 )&&(pixel10_diffA< 30)){
	    pixel_new += (pixel10)*(float)1.0; accumWeights += 1;
    }
    float pixel11_diffR = fabs(pixel11.x- (float)pixel_orig.x);
    float pixel11_diffG = fabs(pixel11.y- (float)pixel_orig.y);
    float pixel11_diffB = fabs(pixel11.z- (float)pixel_orig.z);
    float pixel11_diffA = fabs(pixel11.w- (float)pixel_orig.w);
   if ((pixel11_diffR<30)&& (pixel11_diffG< 30)&&(pixel11_diffB< 30 )&&(pixel11_diffA< 30)){
	    pixel_new += (pixel11)*(float)1.0; accumWeights += 1;
    }
    float pixel12_diffR = fabs(pixel12.x- (float)pixel_orig.x);
    float pixel12_diffG = fabs(pixel12.y- (float)pixel_orig.y);
    float pixel12_diffB = fabs(pixel12.z- (float)pixel_orig.z);
    float pixel12_diffA = fabs(pixel12.w- (float)pixel_orig.w);
   if ((pixel12_diffR<30)&& (pixel12_diffG< 30)&&(pixel12_diffB< 30 )&&(pixel12_diffA< 30)){
	    pixel_new += (pixel12)*(float)1.0; accumWeights += 1;
    }
    float pixel13_diffR = fabs(pixel13.x- (float)pixel_orig.x);
    float pixel13_diffG = fabs(pixel13.y- (float)pixel_orig.y);
    float pixel13_diffB = fabs(pixel13.z- (float)pixel_orig.z);
    float pixel13_diffA = fabs(pixel13.w- (float)pixel_orig.w);
   if ((pixel13_diffR<30)&& (pixel13_diffG< 30)&&(pixel13_diffB< 30 )&&(pixel13_diffA< 30)){
	    pixel_new += (pixel13)*(float)1.0; accumWeights += 1;
    }
    float pixel14_diffR = fabs(pixel14.x- (float)pixel_orig.x);
    float pixel14_diffG = fabs(pixel14.y- (float)pixel_orig.y);
    float pixel14_diffB = fabs(pixel14.z- (float)pixel_orig.z);
    float pixel14_diffA = fabs(pixel14.w- (float)pixel_orig.w);
   if ((pixel14_diffR<30)&& (pixel14_diffG< 30)&&(pixel14_diffB< 30 )&&(pixel14_diffA< 30)){
	    pixel_new += (pixel14)*(float)1.0; accumWeights += 1;
    }
    float pixel15_diffR = fabs(pixel15.x- (float)pixel_orig.x);
    float pixel15_diffG = fabs(pixel15.y- (float)pixel_orig.y);
    float pixel15_diffB = fabs(pixel15.z- (float)pixel_orig.z);
    float pixel15_diffA = fabs(pixel15.w- (float)pixel_orig.w);
   if ((pixel15_diffR<30)&& (pixel15_diffG< 30)&&(pixel15_diffB< 30 )&&(pixel15_diffA< 30)){
	    pixel_new += (pixel15)*(float)1.0; accumWeights += 1;
    }
    float pixel16_diffR = fabs(pixel16.x- (float)pixel_orig.x);
    float pixel16_diffG = fabs(pixel16.y- (float)pixel_orig.y);
    float pixel16_diffB = fabs(pixel16.z- (float)pixel_orig.z);
    float pixel16_diffA = fabs(pixel16.w- (float)pixel_orig.w);
   if ((pixel16_diffR<30)&& (pixel16_diffG< 30)&&(pixel16_diffB< 30 )&&(pixel16_diffA< 30)){
	    pixel_new += (pixel16)*(float)1.0; accumWeights += 1;
    }
    float pixel17_diffR = fabs(pixel17.x- (float)pixel_orig.x);
    float pixel17_diffG = fabs(pixel17.y- (float)pixel_orig.y);
    float pixel17_diffB = fabs(pixel17.z- (float)pixel_orig.z);
    float pixel17_diffA = fabs(pixel17.w- (float)pixel_orig.w);
   if ((pixel17_diffR<30)&& (pixel17_diffG< 30)&&(pixel17_diffB< 30 )&&(pixel17_diffA< 30)){
	    pixel_new += (pixel17)*(float)1.0; accumWeights += 1;
    }
    float pixel18_diffR = fabs(pixel18.x- (float)pixel_orig.x);
    float pixel18_diffG = fabs(pixel18.y- (float)pixel_orig.y);
    float pixel18_diffB = fabs(pixel18.z- (float)pixel_orig.z);
    float pixel18_diffA = fabs(pixel18.w- (float)pixel_orig.w);
   if ((pixel18_diffR<30)&& (pixel18_diffG< 30)&&(pixel18_diffB< 30 )&&(pixel18_diffA< 30)){
	    pixel_new += (pixel18)*(float)1.0; accumWeights += 1;
    }
    float pixel19_diffR = fabs(pixel19.x- (float)pixel_orig.x);
    float pixel19_diffG = fabs(pixel19.y- (float)pixel_orig.y);
    float pixel19_diffB = fabs(pixel19.z- (float)pixel_orig.z);
    float pixel19_diffA = fabs(pixel19.w- (float)pixel_orig.w);
   if ((pixel19_diffR<30)&& (pixel19_diffG< 30)&&(pixel19_diffB< 30 )&&(pixel19_diffA< 30)){
	    pixel_new += (pixel19)*(float)1.0; accumWeights += 1;
    }
    float pixel20_diffR = fabs(pixel20.x- (float)pixel_orig.x);
    float pixel20_diffG = fabs(pixel20.y- (float)pixel_orig.y);
    float pixel20_diffB = fabs(pixel20.z- (float)pixel_orig.z);
    float pixel20_diffA = fabs(pixel20.w- (float)pixel_orig.w);
   if ((pixel20_diffR<30)&& (pixel20_diffG< 30)&&(pixel20_diffB< 30 )&&(pixel20_diffA< 30)){
	    pixel_new += (pixel20)*(float)1.0; accumWeights += 1;
    }
    float pixel21_diffR = fabs(pixel21.x- (float)pixel_orig.x);
    float pixel21_diffG = fabs(pixel21.y- (float)pixel_orig.y);
    float pixel21_diffB = fabs(pixel21.z- (float)pixel_orig.z);
    float pixel21_diffA = fabs(pixel21.w- (float)pixel_orig.w);
   if ((pixel21_diffR<30)&& (pixel21_diffG< 30)&&(pixel21_diffB< 30 )&&(pixel21_diffA< 30)){
	    pixel_new += (pixel21)*(float)1.0; accumWeights += 1;
    }
    float pixel22_diffR = fabs(pixel22.x- (float)pixel_orig.x);
    float pixel22_diffG = fabs(pixel22.y- (float)pixel_orig.y);
    float pixel22_diffB = fabs(pixel22.z- (float)pixel_orig.z);
    float pixel22_diffA = fabs(pixel22.w- (float)pixel_orig.w);
   if ((pixel22_diffR<30)&& (pixel22_diffG< 30)&&(pixel22_diffB< 30 )&&(pixel22_diffA< 30)){
	    pixel_new += (pixel22)*(float)1.0; accumWeights += 1;
    }
    float pixel23_diffR = fabs(pixel23.x- (float)pixel_orig.x);
    float pixel23_diffG = fabs(pixel23.y- (float)pixel_orig.y);
    float pixel23_diffB = fabs(pixel23.z- (float)pixel_orig.z);
    float pixel23_diffA = fabs(pixel23.w- (float)pixel_orig.w);
   if ((pixel23_diffR<30)&& (pixel23_diffG< 30)&&(pixel23_diffB< 30 )&&(pixel23_diffA< 30)){
	    pixel_new += (pixel23)*(float)1.0; accumWeights += 1;
    }
    float pixel24_diffR = fabs(pixel24.x- (float)pixel_orig.x);
    float pixel24_diffG = fabs(pixel24.y- (float)pixel_orig.y);
    float pixel24_diffB = fabs(pixel24.z- (float)pixel_orig.z);
    float pixel24_diffA = fabs(pixel24.w- (float)pixel_orig.w);
   if ((pixel24_diffR<30)&& (pixel24_diffG< 30)&&(pixel24_diffB< 30 )&&(pixel24_diffA< 30)){
	    pixel_new += (pixel24)*(float)1.0; accumWeights += 1;
    }
    float pixel25_diffR = fabs(pixel25.x- (float)pixel_orig.x);
    float pixel25_diffG = fabs(pixel25.y- (float)pixel_orig.y);
    float pixel25_diffB = fabs(pixel25.z- (float)pixel_orig.z);
    float pixel25_diffA = fabs(pixel25.w- (float)pixel_orig.w);
   if ((pixel25_diffR<30)&& (pixel25_diffG< 30)&&(pixel25_diffB< 30 )&&(pixel25_diffA< 30)){
	    pixel_new += (pixel25)*(float)1.0; accumWeights += 1;
    }
    float pixel26_diffR = fabs(pixel26.x- (float)pixel_orig.x);
    float pixel26_diffG = fabs(pixel26.y- (float)pixel_orig.y);
    float pixel26_diffB = fabs(pixel26.z- (float)pixel_orig.z);
    float pixel26_diffA = fabs(pixel26.w- (float)pixel_orig.w);
   if ((pixel26_diffR<30)&& (pixel26_diffG< 30)&&(pixel26_diffB< 30 )&&(pixel26_diffA< 30)){
	    pixel_new += (pixel26)*(float)1.0; accumWeights += 1;
    }
    float pixel27_diffR = fabs(pixel27.x- (float)pixel_orig.x);
    float pixel27_diffG = fabs(pixel27.y- (float)pixel_orig.y);
    float pixel27_diffB = fabs(pixel27.z- (float)pixel_orig.z);
    float pixel27_diffA = fabs(pixel27.w- (float)pixel_orig.w);
   if ((pixel27_diffR<30)&& (pixel27_diffG< 30)&&(pixel27_diffB< 30 )&&(pixel27_diffA< 30)){
	    pixel_new += (pixel27)*(float)1.0; accumWeights += 1;
    }
    float pixel28_diffR = fabs(pixel28.x- (float)pixel_orig.x);
    float pixel28_diffG = fabs(pixel28.y- (float)pixel_orig.y);
    float pixel28_diffB = fabs(pixel28.z- (float)pixel_orig.z);
    float pixel28_diffA = fabs(pixel28.w- (float)pixel_orig.w);
   if ((pixel28_diffR<30)&& (pixel28_diffG< 30)&&(pixel28_diffB< 30 )&&(pixel28_diffA< 30)){
	    pixel_new += (pixel28)*(float)1.0; accumWeights += 1;
    }
    float pixel29_diffR = fabs(pixel29.x- (float)pixel_orig.x);
    float pixel29_diffG = fabs(pixel29.y- (float)pixel_orig.y);
    float pixel29_diffB = fabs(pixel29.z- (float)pixel_orig.z);
    float pixel29_diffA = fabs(pixel29.w- (float)pixel_orig.w);
   if ((pixel29_diffR<30)&& (pixel29_diffG< 30)&&(pixel29_diffB< 30 )&&(pixel29_diffA< 30)){
	    pixel_new += (pixel29)*(float)1.0; accumWeights += 1;
    }
    float pixel30_diffR = fabs(pixel30.x- (float)pixel_orig.x);
    float pixel30_diffG = fabs(pixel30.y- (float)pixel_orig.y);
    float pixel30_diffB = fabs(pixel30.z- (float)pixel_orig.z);
    float pixel30_diffA = fabs(pixel30.w- (float)pixel_orig.w);
   if ((pixel30_diffR<30)&& (pixel30_diffG< 30)&&(pixel30_diffB< 30 )&&(pixel30_diffA< 30)){
	    pixel_new += (pixel30)*(float)1.0; accumWeights += 1;
    }
    float pixel31_diffR = fabs(pixel31.x- (float)pixel_orig.x);
    float pixel31_diffG = fabs(pixel31.y- (float)pixel_orig.y);
    float pixel31_diffB = fabs(pixel31.z- (float)pixel_orig.z);
    float pixel31_diffA = fabs(pixel31.w- (float)pixel_orig.w);
   if ((pixel31_diffR<30)&& (pixel31_diffG< 30)&&(pixel31_diffB< 30 )&&(pixel31_diffA< 30)){
	    pixel_new += (pixel31)*(float)1.0; accumWeights += 1;
    }
    float pixel32_diffR = fabs(pixel32.x- (float)pixel_orig.x);
    float pixel32_diffG = fabs(pixel32.y- (float)pixel_orig.y);
    float pixel32_diffB = fabs(pixel32.z- (float)pixel_orig.z);
    float pixel32_diffA = fabs(pixel32.w- (float)pixel_orig.w);
   if ((pixel32_diffR<30)&& (pixel32_diffG< 30)&&(pixel32_diffB< 30 )&&(pixel32_diffA< 30)){
	    pixel_new += (pixel32)*(float)1.0; accumWeights += 1;
    }
    float pixel33_diffR = fabs(pixel33.x- (float)pixel_orig.x);
    float pixel33_diffG = fabs(pixel33.y- (float)pixel_orig.y);
    float pixel33_diffB = fabs(pixel33.z- (float)pixel_orig.z);
    float pixel33_diffA = fabs(pixel33.w- (float)pixel_orig.w);
   if ((pixel33_diffR<30)&& (pixel33_diffG< 30)&&(pixel33_diffB< 30 )&&(pixel33_diffA< 30)){
	    pixel_new += (pixel33)*(float)1.0; accumWeights += 1;
    }
    float pixel34_diffR = fabs(pixel34.x- (float)pixel_orig.x);
    float pixel34_diffG = fabs(pixel34.y- (float)pixel_orig.y);
    float pixel34_diffB = fabs(pixel34.z- (float)pixel_orig.z);
    float pixel34_diffA = fabs(pixel34.w- (float)pixel_orig.w);
   if ((pixel34_diffR<30)&& (pixel34_diffG< 30)&&(pixel34_diffB< 30 )&&(pixel34_diffA< 30)){
	    pixel_new += (pixel34)*(float)1.0; accumWeights += 1;
    }
    float pixel35_diffR = fabs(pixel35.x- (float)pixel_orig.x);
    float pixel35_diffG = fabs(pixel35.y- (float)pixel_orig.y);
    float pixel35_diffB = fabs(pixel35.z- (float)pixel_orig.z);
    float pixel35_diffA = fabs(pixel35.w- (float)pixel_orig.w);
   if ((pixel35_diffR<30)&& (pixel35_diffG< 30)&&(pixel35_diffB< 30 )&&(pixel35_diffA< 30)){
	    pixel_new += (pixel35)*(float)1.0; accumWeights += 1;
    }
    float pixel36_diffR = fabs(pixel36.x- (float)pixel_orig.x);
    float pixel36_diffG = fabs(pixel36.y- (float)pixel_orig.y);
    float pixel36_diffB = fabs(pixel36.z- (float)pixel_orig.z);
    float pixel36_diffA = fabs(pixel36.w- (float)pixel_orig.w);
   if ((pixel36_diffR<30)&& (pixel36_diffG< 30)&&(pixel36_diffB< 30 )&&(pixel36_diffA< 30)){
	    pixel_new += (pixel36)*(float)1.0; accumWeights += 1;
    }
    float pixel37_diffR = fabs(pixel37.x- (float)pixel_orig.x);
    float pixel37_diffG = fabs(pixel37.y- (float)pixel_orig.y);
    float pixel37_diffB = fabs(pixel37.z- (float)pixel_orig.z);
    float pixel37_diffA = fabs(pixel37.w- (float)pixel_orig.w);
   if ((pixel37_diffR<30)&& (pixel37_diffG< 30)&&(pixel37_diffB< 30 )&&(pixel37_diffA< 30)){
	    pixel_new += (pixel37)*(float)1.0; accumWeights += 1;
    }
    float pixel38_diffR = fabs(pixel38.x- (float)pixel_orig.x);
    float pixel38_diffG = fabs(pixel38.y- (float)pixel_orig.y);
    float pixel38_diffB = fabs(pixel38.z- (float)pixel_orig.z);
    float pixel38_diffA = fabs(pixel38.w- (float)pixel_orig.w);
   if ((pixel38_diffR<30)&& (pixel38_diffG< 30)&&(pixel38_diffB< 30 )&&(pixel38_diffA< 30)){
	    pixel_new += (pixel38)*(float)1.0; accumWeights += 1;
    }
    float pixel39_diffR = fabs(pixel39.x- (float)pixel_orig.x);
    float pixel39_diffG = fabs(pixel39.y- (float)pixel_orig.y);
    float pixel39_diffB = fabs(pixel39.z- (float)pixel_orig.z);
    float pixel39_diffA = fabs(pixel39.w- (float)pixel_orig.w);
   if ((pixel39_diffR<30)&& (pixel39_diffG< 30)&&(pixel39_diffB< 30 )&&(pixel39_diffA< 30)){
	    pixel_new += (pixel39)*(float)1.0; accumWeights += 1;
    }
    float pixel40_diffR = fabs(pixel40.x- (float)pixel_orig.x);
    float pixel40_diffG = fabs(pixel40.y- (float)pixel_orig.y);
    float pixel40_diffB = fabs(pixel40.z- (float)pixel_orig.z);
    float pixel40_diffA = fabs(pixel40.w- (float)pixel_orig.w);
   if ((pixel40_diffR<30)&& (pixel40_diffG< 30)&&(pixel40_diffB< 30 )&&(pixel40_diffA< 30)){
	    pixel_new += (pixel40)*(float)1.0; accumWeights += 1;
    }
    float pixel41_diffR = fabs(pixel41.x- (float)pixel_orig.x);
    float pixel41_diffG = fabs(pixel41.y- (float)pixel_orig.y);
    float pixel41_diffB = fabs(pixel41.z- (float)pixel_orig.z);
    float pixel41_diffA = fabs(pixel41.w- (float)pixel_orig.w);
   if ((pixel41_diffR<30)&& (pixel41_diffG< 30)&&(pixel41_diffB< 30 )&&(pixel41_diffA< 30)){
	    pixel_new += (pixel41)*(float)1.0; accumWeights += 1;
    }
    float pixel42_diffR = fabs(pixel42.x- (float)pixel_orig.x);
    float pixel42_diffG = fabs(pixel42.y- (float)pixel_orig.y);
    float pixel42_diffB = fabs(pixel42.z- (float)pixel_orig.z);
    float pixel42_diffA = fabs(pixel42.w- (float)pixel_orig.w);
   if ((pixel42_diffR<30)&& (pixel42_diffG< 30)&&(pixel42_diffB< 30 )&&(pixel42_diffA< 30)){
	    pixel_new += (pixel42)*(float)1.0; accumWeights += 1;
    }
    float pixel43_diffR = fabs(pixel43.x- (float)pixel_orig.x);
    float pixel43_diffG = fabs(pixel43.y- (float)pixel_orig.y);
    float pixel43_diffB = fabs(pixel43.z- (float)pixel_orig.z);
    float pixel43_diffA = fabs(pixel43.w- (float)pixel_orig.w);
   if ((pixel43_diffR<30)&& (pixel43_diffG< 30)&&(pixel43_diffB< 30 )&&(pixel43_diffA< 30)){
	    pixel_new += (pixel43)*(float)1.0; accumWeights += 1;
    }
    float pixel44_diffR = fabs(pixel44.x- (float)pixel_orig.x);
    float pixel44_diffG = fabs(pixel44.y- (float)pixel_orig.y);
    float pixel44_diffB = fabs(pixel44.z- (float)pixel_orig.z);
    float pixel44_diffA = fabs(pixel44.w- (float)pixel_orig.w);
   if ((pixel44_diffR<30)&& (pixel44_diffG< 30)&&(pixel44_diffB< 30 )&&(pixel44_diffA< 30)){
	    pixel_new += (pixel44)*(float)1.0; accumWeights += 1;
    }
    float pixel45_diffR = fabs(pixel45.x- (float)pixel_orig.x);
    float pixel45_diffG = fabs(pixel45.y- (float)pixel_orig.y);
    float pixel45_diffB = fabs(pixel45.z- (float)pixel_orig.z);
    float pixel45_diffA = fabs(pixel45.w- (float)pixel_orig.w);
   if ((pixel45_diffR<30)&& (pixel45_diffG< 30)&&(pixel45_diffB< 30 )&&(pixel45_diffA< 30)){
	    pixel_new += (pixel45)*(float)1.0; accumWeights += 1;
    }
    float pixel46_diffR = fabs(pixel46.x- (float)pixel_orig.x);
    float pixel46_diffG = fabs(pixel46.y- (float)pixel_orig.y);
    float pixel46_diffB = fabs(pixel46.z- (float)pixel_orig.z);
    float pixel46_diffA = fabs(pixel46.w- (float)pixel_orig.w);
   if ((pixel46_diffR<30)&& (pixel46_diffG< 30)&&(pixel46_diffB< 30 )&&(pixel46_diffA< 30)){
	    pixel_new += (pixel46)*(float)1.0; accumWeights += 1;
    }
    float pixel47_diffR = fabs(pixel47.x- (float)pixel_orig.x);
    float pixel47_diffG = fabs(pixel47.y- (float)pixel_orig.y);
    float pixel47_diffB = fabs(pixel47.z- (float)pixel_orig.z);
    float pixel47_diffA = fabs(pixel47.w- (float)pixel_orig.w);
   if ((pixel47_diffR<30)&& (pixel47_diffG< 30)&&(pixel47_diffB< 30 )&&(pixel47_diffA< 30)){
	    pixel_new += (pixel47)*(float)1.0; accumWeights += 1;
    }
    float pixel48_diffR = fabs(pixel48.x- (float)pixel_orig.x);
    float pixel48_diffG = fabs(pixel48.y- (float)pixel_orig.y);
    float pixel48_diffB = fabs(pixel48.z- (float)pixel_orig.z);
    float pixel48_diffA = fabs(pixel48.w- (float)pixel_orig.w);
   if ((pixel48_diffR<30)&& (pixel48_diffG< 30)&&(pixel48_diffB< 30 )&&(pixel48_diffA< 30)){
	    pixel_new += (pixel48)*(float)1.0; accumWeights += 1;
    }
    float pixel49_diffR = fabs(pixel49.x- (float)pixel_orig.x);
    float pixel49_diffG = fabs(pixel49.y- (float)pixel_orig.y);
    float pixel49_diffB = fabs(pixel49.z- (float)pixel_orig.z);
    float pixel49_diffA = fabs(pixel49.w- (float)pixel_orig.w);
   if ((pixel49_diffR<30)&& (pixel49_diffG< 30)&&(pixel49_diffB< 30 )&&(pixel49_diffA< 30)){
	    pixel_new += (pixel49)*(float)1.0; accumWeights += 1;
    }
    float pixel50_diffR = fabs(pixel50.x- (float)pixel_orig.x);
    float pixel50_diffG = fabs(pixel50.y- (float)pixel_orig.y);
    float pixel50_diffB = fabs(pixel50.z- (float)pixel_orig.z);
    float pixel50_diffA = fabs(pixel50.w- (float)pixel_orig.w);
   if ((pixel50_diffR<30)&& (pixel50_diffG< 30)&&(pixel50_diffB< 30 )&&(pixel50_diffA< 30)){
	    pixel_new += (pixel50)*(float)1.0; accumWeights += 1;
    }
    float pixel51_diffR = fabs(pixel51.x- (float)pixel_orig.x);
    float pixel51_diffG = fabs(pixel51.y- (float)pixel_orig.y);
    float pixel51_diffB = fabs(pixel51.z- (float)pixel_orig.z);
    float pixel51_diffA = fabs(pixel51.w- (float)pixel_orig.w);
   if ((pixel51_diffR<30)&& (pixel51_diffG< 30)&&(pixel51_diffB< 30 )&&(pixel51_diffA< 30)){
	    pixel_new += (pixel51)*(float)1.0; accumWeights += 1;
    }
    float pixel52_diffR = fabs(pixel52.x- (float)pixel_orig.x);
    float pixel52_diffG = fabs(pixel52.y- (float)pixel_orig.y);
    float pixel52_diffB = fabs(pixel52.z- (float)pixel_orig.z);
    float pixel52_diffA = fabs(pixel52.w- (float)pixel_orig.w);
   if ((pixel52_diffR<30)&& (pixel52_diffG< 30)&&(pixel52_diffB< 30 )&&(pixel52_diffA< 30)){
	    pixel_new += (pixel52)*(float)1.0; accumWeights += 1;
    }
    float pixel53_diffR = fabs(pixel53.x- (float)pixel_orig.x);
    float pixel53_diffG = fabs(pixel53.y- (float)pixel_orig.y);
    float pixel53_diffB = fabs(pixel53.z- (float)pixel_orig.z);
    float pixel53_diffA = fabs(pixel53.w- (float)pixel_orig.w);
   if ((pixel53_diffR<30)&& (pixel53_diffG< 30)&&(pixel53_diffB< 30 )&&(pixel53_diffA< 30)){
	    pixel_new += (pixel53)*(float)1.0; accumWeights += 1;
    }
    float pixel54_diffR = fabs(pixel54.x- (float)pixel_orig.x);
    float pixel54_diffG = fabs(pixel54.y- (float)pixel_orig.y);
    float pixel54_diffB = fabs(pixel54.z- (float)pixel_orig.z);
    float pixel54_diffA = fabs(pixel54.w- (float)pixel_orig.w);
   if ((pixel54_diffR<30)&& (pixel54_diffG< 30)&&(pixel54_diffB< 30 )&&(pixel54_diffA< 30)){
	    pixel_new += (pixel54)*(float)1.0; accumWeights += 1;
    }
    float pixel55_diffR = fabs(pixel55.x- (float)pixel_orig.x);
    float pixel55_diffG = fabs(pixel55.y- (float)pixel_orig.y);
    float pixel55_diffB = fabs(pixel55.z- (float)pixel_orig.z);
    float pixel55_diffA = fabs(pixel55.w- (float)pixel_orig.w);
   if ((pixel55_diffR<30)&& (pixel55_diffG< 30)&&(pixel55_diffB< 30 )&&(pixel55_diffA< 30)){
	    pixel_new += (pixel55)*(float)1.0; accumWeights += 1;
    }
    float pixel56_diffR = fabs(pixel56.x- (float)pixel_orig.x);
    float pixel56_diffG = fabs(pixel56.y- (float)pixel_orig.y);
    float pixel56_diffB = fabs(pixel56.z- (float)pixel_orig.z);
    float pixel56_diffA = fabs(pixel56.w- (float)pixel_orig.w);
   if ((pixel56_diffR<30)&& (pixel56_diffG< 30)&&(pixel56_diffB< 30 )&&(pixel56_diffA< 30)){
	    pixel_new += (pixel56)*(float)1.0; accumWeights += 1;
    }
    float pixel57_diffR = fabs(pixel57.x- (float)pixel_orig.x);
    float pixel57_diffG = fabs(pixel57.y- (float)pixel_orig.y);
    float pixel57_diffB = fabs(pixel57.z- (float)pixel_orig.z);
    float pixel57_diffA = fabs(pixel57.w- (float)pixel_orig.w);
   if ((pixel57_diffR<30)&& (pixel57_diffG< 30)&&(pixel57_diffB< 30 )&&(pixel57_diffA< 30)){
	    pixel_new += (pixel57)*(float)1.0; accumWeights += 1;
    }
    float pixel58_diffR = fabs(pixel58.x- (float)pixel_orig.x);
    float pixel58_diffG = fabs(pixel58.y- (float)pixel_orig.y);
    float pixel58_diffB = fabs(pixel58.z- (float)pixel_orig.z);
    float pixel58_diffA = fabs(pixel58.w- (float)pixel_orig.w);
   if ((pixel58_diffR<30)&& (pixel58_diffG< 30)&&(pixel58_diffB< 30 )&&(pixel58_diffA< 30)){
	    pixel_new += (pixel58)*(float)1.0; accumWeights += 1;
    }
    float pixel59_diffR = fabs(pixel59.x- (float)pixel_orig.x);
    float pixel59_diffG = fabs(pixel59.y- (float)pixel_orig.y);
    float pixel59_diffB = fabs(pixel59.z- (float)pixel_orig.z);
    float pixel59_diffA = fabs(pixel59.w- (float)pixel_orig.w);
   if ((pixel59_diffR<30)&& (pixel59_diffG< 30)&&(pixel59_diffB< 30 )&&(pixel59_diffA< 30)){
	    pixel_new += (pixel59)*(float)1.0; accumWeights += 1;
    }
    float pixel60_diffR = fabs(pixel60.x- (float)pixel_orig.x);
    float pixel60_diffG = fabs(pixel60.y- (float)pixel_orig.y);
    float pixel60_diffB = fabs(pixel60.z- (float)pixel_orig.z);
    float pixel60_diffA = fabs(pixel60.w- (float)pixel_orig.w);
   if ((pixel60_diffR<30)&& (pixel60_diffG< 30)&&(pixel60_diffB< 30 )&&(pixel60_diffA< 30)){
	    pixel_new += (pixel60)*(float)1.0; accumWeights += 1;
    }
    float pixel61_diffR = fabs(pixel61.x- (float)pixel_orig.x);
    float pixel61_diffG = fabs(pixel61.y- (float)pixel_orig.y);
    float pixel61_diffB = fabs(pixel61.z- (float)pixel_orig.z);
    float pixel61_diffA = fabs(pixel61.w- (float)pixel_orig.w);
   if ((pixel61_diffR<30)&& (pixel61_diffG< 30)&&(pixel61_diffB< 30 )&&(pixel61_diffA< 30)){
	    pixel_new += (pixel61)*(float)1.0; accumWeights += 1;
    }
    float pixel62_diffR = fabs(pixel62.x- (float)pixel_orig.x);
    float pixel62_diffG = fabs(pixel62.y- (float)pixel_orig.y);
    float pixel62_diffB = fabs(pixel62.z- (float)pixel_orig.z);
    float pixel62_diffA = fabs(pixel62.w- (float)pixel_orig.w);
   if ((pixel62_diffR<30)&& (pixel62_diffG< 30)&&(pixel62_diffB< 30 )&&(pixel62_diffA< 30)){
	    pixel_new += (pixel62)*(float)1.0; accumWeights += 1;
    }
    float pixel63_diffR = fabs(pixel63.x- (float)pixel_orig.x);
    float pixel63_diffG = fabs(pixel63.y- (float)pixel_orig.y);
    float pixel63_diffB = fabs(pixel63.z- (float)pixel_orig.z);
    float pixel63_diffA = fabs(pixel63.w- (float)pixel_orig.w);
   if ((pixel63_diffR<30)&& (pixel63_diffG< 30)&&(pixel63_diffB< 30 )&&(pixel63_diffA< 30)){
	    pixel_new += (pixel63)*(float)1.0; accumWeights += 1;
    }
    float pixel64_diffR = fabs(pixel64.x- (float)pixel_orig.x);
    float pixel64_diffG = fabs(pixel64.y- (float)pixel_orig.y);
    float pixel64_diffB = fabs(pixel64.z- (float)pixel_orig.z);
    float pixel64_diffA = fabs(pixel64.w- (float)pixel_orig.w);
   if ((pixel64_diffR<30)&& (pixel64_diffG< 30)&&(pixel64_diffB< 30 )&&(pixel64_diffA< 30)){
	    pixel_new += (pixel64)*(float)1.0; accumWeights += 1;
    }
    float pixel65_diffR = fabs(pixel65.x- (float)pixel_orig.x);
    float pixel65_diffG = fabs(pixel65.y- (float)pixel_orig.y);
    float pixel65_diffB = fabs(pixel65.z- (float)pixel_orig.z);
    float pixel65_diffA = fabs(pixel65.w- (float)pixel_orig.w);
   if ((pixel65_diffR<30)&& (pixel65_diffG< 30)&&(pixel65_diffB< 30 )&&(pixel65_diffA< 30)){
	    pixel_new += (pixel65)*(float)1.0; accumWeights += 1;
    }
    float pixel66_diffR = fabs(pixel66.x- (float)pixel_orig.x);
    float pixel66_diffG = fabs(pixel66.y- (float)pixel_orig.y);
    float pixel66_diffB = fabs(pixel66.z- (float)pixel_orig.z);
    float pixel66_diffA = fabs(pixel66.w- (float)pixel_orig.w);
   if ((pixel66_diffR<30)&& (pixel66_diffG< 30)&&(pixel66_diffB< 30 )&&(pixel66_diffA< 30)){
	    pixel_new += (pixel66)*(float)1.0; accumWeights += 1;
    }
    float pixel67_diffR = fabs(pixel67.x- (float)pixel_orig.x);
    float pixel67_diffG = fabs(pixel67.y- (float)pixel_orig.y);
    float pixel67_diffB = fabs(pixel67.z- (float)pixel_orig.z);
    float pixel67_diffA = fabs(pixel67.w- (float)pixel_orig.w);
   if ((pixel67_diffR<30)&& (pixel67_diffG< 30)&&(pixel67_diffB< 30 )&&(pixel67_diffA< 30)){
	    pixel_new += (pixel67)*(float)1.0; accumWeights += 1;
    }
    float pixel68_diffR = fabs(pixel68.x- (float)pixel_orig.x);
    float pixel68_diffG = fabs(pixel68.y- (float)pixel_orig.y);
    float pixel68_diffB = fabs(pixel68.z- (float)pixel_orig.z);
    float pixel68_diffA = fabs(pixel68.w- (float)pixel_orig.w);
   if ((pixel68_diffR<30)&& (pixel68_diffG< 30)&&(pixel68_diffB< 30 )&&(pixel68_diffA< 30)){
	    pixel_new += (pixel68)*(float)1.0; accumWeights += 1;
    }
    float pixel69_diffR = fabs(pixel69.x- (float)pixel_orig.x);
    float pixel69_diffG = fabs(pixel69.y- (float)pixel_orig.y);
    float pixel69_diffB = fabs(pixel69.z- (float)pixel_orig.z);
    float pixel69_diffA = fabs(pixel69.w- (float)pixel_orig.w);
   if ((pixel69_diffR<30)&& (pixel69_diffG< 30)&&(pixel69_diffB< 30 )&&(pixel69_diffA< 30)){
	    pixel_new += (pixel69)*(float)1.0; accumWeights += 1;
    }
    float pixel70_diffR = fabs(pixel70.x- (float)pixel_orig.x);
    float pixel70_diffG = fabs(pixel70.y- (float)pixel_orig.y);
    float pixel70_diffB = fabs(pixel70.z- (float)pixel_orig.z);
    float pixel70_diffA = fabs(pixel70.w- (float)pixel_orig.w);
   if ((pixel70_diffR<30)&& (pixel70_diffG< 30)&&(pixel70_diffB< 30 )&&(pixel70_diffA< 30)){
	    pixel_new += (pixel70)*(float)1.0; accumWeights += 1;
    }
    float pixel71_diffR = fabs(pixel71.x- (float)pixel_orig.x);
    float pixel71_diffG = fabs(pixel71.y- (float)pixel_orig.y);
    float pixel71_diffB = fabs(pixel71.z- (float)pixel_orig.z);
    float pixel71_diffA = fabs(pixel71.w- (float)pixel_orig.w);
   if ((pixel71_diffR<30)&& (pixel71_diffG< 30)&&(pixel71_diffB< 30 )&&(pixel71_diffA< 30)){
	    pixel_new += (pixel71)*(float)1.0; accumWeights += 1;
    }
    float pixel72_diffR = fabs(pixel72.x- (float)pixel_orig.x);
    float pixel72_diffG = fabs(pixel72.y- (float)pixel_orig.y);
    float pixel72_diffB = fabs(pixel72.z- (float)pixel_orig.z);
    float pixel72_diffA = fabs(pixel72.w- (float)pixel_orig.w);
   if ((pixel72_diffR<30)&& (pixel72_diffG< 30)&&(pixel72_diffB< 30 )&&(pixel72_diffA< 30)){
	    pixel_new += (pixel72)*(float)1.0; accumWeights += 1;
    }
    float pixel73_diffR = fabs(pixel73.x- (float)pixel_orig.x);
    float pixel73_diffG = fabs(pixel73.y- (float)pixel_orig.y);
    float pixel73_diffB = fabs(pixel73.z- (float)pixel_orig.z);
    float pixel73_diffA = fabs(pixel73.w- (float)pixel_orig.w);
   if ((pixel73_diffR<30)&& (pixel73_diffG< 30)&&(pixel73_diffB< 30 )&&(pixel73_diffA< 30)){
	    pixel_new += (pixel73)*(float)1.0; accumWeights += 1;
    }
    float pixel74_diffR = fabs(pixel74.x- (float)pixel_orig.x);
    float pixel74_diffG = fabs(pixel74.y- (float)pixel_orig.y);
    float pixel74_diffB = fabs(pixel74.z- (float)pixel_orig.z);
    float pixel74_diffA = fabs(pixel74.w- (float)pixel_orig.w);
   if ((pixel74_diffR<30)&& (pixel74_diffG< 30)&&(pixel74_diffB< 30 )&&(pixel74_diffA< 30)){
	    pixel_new += (pixel74)*(float)1.0; accumWeights += 1;
    }
    float pixel75_diffR = fabs(pixel75.x- (float)pixel_orig.x);
    float pixel75_diffG = fabs(pixel75.y- (float)pixel_orig.y);
    float pixel75_diffB = fabs(pixel75.z- (float)pixel_orig.z);
    float pixel75_diffA = fabs(pixel75.w- (float)pixel_orig.w);
   if ((pixel75_diffR<30)&& (pixel75_diffG< 30)&&(pixel75_diffB< 30 )&&(pixel75_diffA< 30)){
	    pixel_new += (pixel75)*(float)1.0; accumWeights += 1;
    }
    float pixel76_diffR = fabs(pixel76.x- (float)pixel_orig.x);
    float pixel76_diffG = fabs(pixel76.y- (float)pixel_orig.y);
    float pixel76_diffB = fabs(pixel76.z- (float)pixel_orig.z);
    float pixel76_diffA = fabs(pixel76.w- (float)pixel_orig.w);
   if ((pixel76_diffR<30)&& (pixel76_diffG< 30)&&(pixel76_diffB< 30 )&&(pixel76_diffA< 30)){
	    pixel_new += (pixel76)*(float)1.0; accumWeights += 1;
    }
    float pixel77_diffR = fabs(pixel77.x- (float)pixel_orig.x);
    float pixel77_diffG = fabs(pixel77.y- (float)pixel_orig.y);
    float pixel77_diffB = fabs(pixel77.z- (float)pixel_orig.z);
    float pixel77_diffA = fabs(pixel77.w- (float)pixel_orig.w);
   if ((pixel77_diffR<30)&& (pixel77_diffG< 30)&&(pixel77_diffB< 30 )&&(pixel77_diffA< 30)){
	    pixel_new += (pixel77)*(float)1.0; accumWeights += 1;
    }
    float pixel78_diffR = fabs(pixel78.x- (float)pixel_orig.x);
    float pixel78_diffG = fabs(pixel78.y- (float)pixel_orig.y);
    float pixel78_diffB = fabs(pixel78.z- (float)pixel_orig.z);
    float pixel78_diffA = fabs(pixel78.w- (float)pixel_orig.w);
   if ((pixel78_diffR<30)&& (pixel78_diffG< 30)&&(pixel78_diffB< 30 )&&(pixel78_diffA< 30)){
	    pixel_new += (pixel78)*(float)1.0; accumWeights += 1;
    }
    float pixel79_diffR = fabs(pixel79.x- (float)pixel_orig.x);
    float pixel79_diffG = fabs(pixel79.y- (float)pixel_orig.y);
    float pixel79_diffB = fabs(pixel79.z- (float)pixel_orig.z);
    float pixel79_diffA = fabs(pixel79.w- (float)pixel_orig.w);
   if ((pixel79_diffR<30)&& (pixel79_diffG< 30)&&(pixel79_diffB< 30 )&&(pixel79_diffA< 30)){
	    pixel_new += (pixel79)*(float)1.0; accumWeights += 1;
    }
    float pixel80_diffR = fabs(pixel80.x- (float)pixel_orig.x);
    float pixel80_diffG = fabs(pixel80.y- (float)pixel_orig.y);
    float pixel80_diffB = fabs(pixel80.z- (float)pixel_orig.z);
    float pixel80_diffA = fabs(pixel80.w- (float)pixel_orig.w);
   if ((pixel80_diffR<30)&& (pixel80_diffG< 30)&&(pixel80_diffB< 30 )&&(pixel80_diffA< 30)){
	    pixel_new += (pixel80)*(float)1.0; accumWeights += 1;
    }
    float pixel81_diffR = fabs(pixel81.x- (float)pixel_orig.x);
    float pixel81_diffG = fabs(pixel81.y- (float)pixel_orig.y);
    float pixel81_diffB = fabs(pixel81.z- (float)pixel_orig.z);
    float pixel81_diffA = fabs(pixel81.w- (float)pixel_orig.w);
   if ((pixel81_diffR<30)&& (pixel81_diffG< 30)&&(pixel81_diffB< 30 )&&(pixel81_diffA< 30)){
	    pixel_new += (pixel81)*(float)1.0; accumWeights += 1;
    }
    float pixel82_diffR = fabs(pixel82.x- (float)pixel_orig.x);
    float pixel82_diffG = fabs(pixel82.y- (float)pixel_orig.y);
    float pixel82_diffB = fabs(pixel82.z- (float)pixel_orig.z);
    float pixel82_diffA = fabs(pixel82.w- (float)pixel_orig.w);
   if ((pixel82_diffR<30)&& (pixel82_diffG< 30)&&(pixel82_diffB< 30 )&&(pixel82_diffA< 30)){
	    pixel_new += (pixel82)*(float)1.0; accumWeights += 1;
    }
    float pixel83_diffR = fabs(pixel83.x- (float)pixel_orig.x);
    float pixel83_diffG = fabs(pixel83.y- (float)pixel_orig.y);
    float pixel83_diffB = fabs(pixel83.z- (float)pixel_orig.z);
    float pixel83_diffA = fabs(pixel83.w- (float)pixel_orig.w);
   if ((pixel83_diffR<30)&& (pixel83_diffG< 30)&&(pixel83_diffB< 30 )&&(pixel83_diffA< 30)){
	    pixel_new += (pixel83)*(float)1.0; accumWeights += 1;
    }
    float pixel84_diffR = fabs(pixel84.x- (float)pixel_orig.x);
    float pixel84_diffG = fabs(pixel84.y- (float)pixel_orig.y);
    float pixel84_diffB = fabs(pixel84.z- (float)pixel_orig.z);
    float pixel84_diffA = fabs(pixel84.w- (float)pixel_orig.w);
   if ((pixel84_diffR<30)&& (pixel84_diffG< 30)&&(pixel84_diffB< 30 )&&(pixel84_diffA< 30)){
	    pixel_new += (pixel84)*(float)1.0; accumWeights += 1;
    }
    float pixel85_diffR = fabs(pixel85.x- (float)pixel_orig.x);
    float pixel85_diffG = fabs(pixel85.y- (float)pixel_orig.y);
    float pixel85_diffB = fabs(pixel85.z- (float)pixel_orig.z);
    float pixel85_diffA = fabs(pixel85.w- (float)pixel_orig.w);
   if ((pixel85_diffR<30)&& (pixel85_diffG< 30)&&(pixel85_diffB< 30 )&&(pixel85_diffA< 30)){
	    pixel_new += (pixel85)*(float)1.0; accumWeights += 1;
    }
    float pixel86_diffR = fabs(pixel86.x- (float)pixel_orig.x);
    float pixel86_diffG = fabs(pixel86.y- (float)pixel_orig.y);
    float pixel86_diffB = fabs(pixel86.z- (float)pixel_orig.z);
    float pixel86_diffA = fabs(pixel86.w- (float)pixel_orig.w);
   if ((pixel86_diffR<30)&& (pixel86_diffG< 30)&&(pixel86_diffB< 30 )&&(pixel86_diffA< 30)){
	    pixel_new += (pixel86)*(float)1.0; accumWeights += 1;
    }
    float pixel87_diffR = fabs(pixel87.x- (float)pixel_orig.x);
    float pixel87_diffG = fabs(pixel87.y- (float)pixel_orig.y);
    float pixel87_diffB = fabs(pixel87.z- (float)pixel_orig.z);
    float pixel87_diffA = fabs(pixel87.w- (float)pixel_orig.w);
   if ((pixel87_diffR<30)&& (pixel87_diffG< 30)&&(pixel87_diffB< 30 )&&(pixel87_diffA< 30)){
	    pixel_new += (pixel87)*(float)1.0; accumWeights += 1;
    }
    float pixel88_diffR = fabs(pixel88.x- (float)pixel_orig.x);
    float pixel88_diffG = fabs(pixel88.y- (float)pixel_orig.y);
    float pixel88_diffB = fabs(pixel88.z- (float)pixel_orig.z);
    float pixel88_diffA = fabs(pixel88.w- (float)pixel_orig.w);
   if ((pixel88_diffR<30)&& (pixel88_diffG< 30)&&(pixel88_diffB< 30 )&&(pixel88_diffA< 30)){
	    pixel_new += (pixel88)*(float)1.0; accumWeights += 1;
    }
    float pixel89_diffR = fabs(pixel89.x- (float)pixel_orig.x);
    float pixel89_diffG = fabs(pixel89.y- (float)pixel_orig.y);
    float pixel89_diffB = fabs(pixel89.z- (float)pixel_orig.z);
    float pixel89_diffA = fabs(pixel89.w- (float)pixel_orig.w);
   if ((pixel89_diffR<30)&& (pixel89_diffG< 30)&&(pixel89_diffB< 30 )&&(pixel89_diffA< 30)){
	    pixel_new += (pixel89)*(float)1.0; accumWeights += 1;
    }
    float pixel90_diffR = fabs(pixel90.x- (float)pixel_orig.x);
    float pixel90_diffG = fabs(pixel90.y- (float)pixel_orig.y);
    float pixel90_diffB = fabs(pixel90.z- (float)pixel_orig.z);
    float pixel90_diffA = fabs(pixel90.w- (float)pixel_orig.w);
   if ((pixel90_diffR<30)&& (pixel90_diffG< 30)&&(pixel90_diffB< 30 )&&(pixel90_diffA< 30)){
	    pixel_new += (pixel90)*(float)1.0; accumWeights += 1;
    }
    float pixel91_diffR = fabs(pixel91.x- (float)pixel_orig.x);
    float pixel91_diffG = fabs(pixel91.y- (float)pixel_orig.y);
    float pixel91_diffB = fabs(pixel91.z- (float)pixel_orig.z);
    float pixel91_diffA = fabs(pixel91.w- (float)pixel_orig.w);
   if ((pixel91_diffR<30)&& (pixel91_diffG< 30)&&(pixel91_diffB< 30 )&&(pixel91_diffA< 30)){
	    pixel_new += (pixel91)*(float)1.0; accumWeights += 1;
    }
    float pixel92_diffR = fabs(pixel92.x- (float)pixel_orig.x);
    float pixel92_diffG = fabs(pixel92.y- (float)pixel_orig.y);
    float pixel92_diffB = fabs(pixel92.z- (float)pixel_orig.z);
    float pixel92_diffA = fabs(pixel92.w- (float)pixel_orig.w);
   if ((pixel92_diffR<30)&& (pixel92_diffG< 30)&&(pixel92_diffB< 30 )&&(pixel92_diffA< 30)){
	    pixel_new += (pixel92)*(float)1.0; accumWeights += 1;
    }
    float pixel93_diffR = fabs(pixel93.x- (float)pixel_orig.x);
    float pixel93_diffG = fabs(pixel93.y- (float)pixel_orig.y);
    float pixel93_diffB = fabs(pixel93.z- (float)pixel_orig.z);
    float pixel93_diffA = fabs(pixel93.w- (float)pixel_orig.w);
   if ((pixel93_diffR<30)&& (pixel93_diffG< 30)&&(pixel93_diffB< 30 )&&(pixel93_diffA< 30)){
	    pixel_new += (pixel93)*(float)1.0; accumWeights += 1;
    }
    float pixel94_diffR = fabs(pixel94.x- (float)pixel_orig.x);
    float pixel94_diffG = fabs(pixel94.y- (float)pixel_orig.y);
    float pixel94_diffB = fabs(pixel94.z- (float)pixel_orig.z);
    float pixel94_diffA = fabs(pixel94.w- (float)pixel_orig.w);
   if ((pixel94_diffR<30)&& (pixel94_diffG< 30)&&(pixel94_diffB< 30 )&&(pixel94_diffA< 30)){
	    pixel_new += (pixel94)*(float)1.0; accumWeights += 1;
    }
    float pixel95_diffR = fabs(pixel95.x- (float)pixel_orig.x);
    float pixel95_diffG = fabs(pixel95.y- (float)pixel_orig.y);
    float pixel95_diffB = fabs(pixel95.z- (float)pixel_orig.z);
    float pixel95_diffA = fabs(pixel95.w- (float)pixel_orig.w);
   if ((pixel95_diffR<30)&& (pixel95_diffG< 30)&&(pixel95_diffB< 30 )&&(pixel95_diffA< 30)){
	    pixel_new += (pixel95)*(float)1.0; accumWeights += 1;
    }
    float pixel96_diffR = fabs(pixel96.x- (float)pixel_orig.x);
    float pixel96_diffG = fabs(pixel96.y- (float)pixel_orig.y);
    float pixel96_diffB = fabs(pixel96.z- (float)pixel_orig.z);
    float pixel96_diffA = fabs(pixel96.w- (float)pixel_orig.w);
   if ((pixel96_diffR<30)&& (pixel96_diffG< 30)&&(pixel96_diffB< 30 )&&(pixel96_diffA< 30)){
	    pixel_new += (pixel96)*(float)1.0; accumWeights += 1;
    }
    float pixel97_diffR = fabs(pixel97.x- (float)pixel_orig.x);
    float pixel97_diffG = fabs(pixel97.y- (float)pixel_orig.y);
    float pixel97_diffB = fabs(pixel97.z- (float)pixel_orig.z);
    float pixel97_diffA = fabs(pixel97.w- (float)pixel_orig.w);
   if ((pixel97_diffR<30)&& (pixel97_diffG< 30)&&(pixel97_diffB< 30 )&&(pixel97_diffA< 30)){
	    pixel_new += (pixel97)*(float)1.0; accumWeights += 1;
    }
    float pixel98_diffR = fabs(pixel98.x- (float)pixel_orig.x);
    float pixel98_diffG = fabs(pixel98.y- (float)pixel_orig.y);
    float pixel98_diffB = fabs(pixel98.z- (float)pixel_orig.z);
    float pixel98_diffA = fabs(pixel98.w- (float)pixel_orig.w);
   if ((pixel98_diffR<30)&& (pixel98_diffG< 30)&&(pixel98_diffB< 30 )&&(pixel98_diffA< 30)){
	    pixel_new += (pixel98)*(float)1.0; accumWeights += 1;
    }
    float pixel99_diffR = fabs(pixel99.x- (float)pixel_orig.x);
    float pixel99_diffG = fabs(pixel99.y- (float)pixel_orig.y);
    float pixel99_diffB = fabs(pixel99.z- (float)pixel_orig.z);
    float pixel99_diffA = fabs(pixel99.w- (float)pixel_orig.w);
   if ((pixel99_diffR<30)&& (pixel99_diffG< 30)&&(pixel99_diffB< 30 )&&(pixel99_diffA< 30)){
	    pixel_new += (pixel99)*(float)1.0; accumWeights += 1;
    }
    float pixel100_diffR = fabs(pixel100.x- (float)pixel_orig.x);
    float pixel100_diffG = fabs(pixel100.y- (float)pixel_orig.y);
    float pixel100_diffB = fabs(pixel100.z- (float)pixel_orig.z);
    float pixel100_diffA = fabs(pixel100.w- (float)pixel_orig.w);
   if ((pixel100_diffR<30)&& (pixel100_diffG< 30)&&(pixel100_diffB< 30 )&&(pixel100_diffA< 30)){
	    pixel_new += (pixel100)*(float)1.0; accumWeights += 1;
    }
    float pixel101_diffR = fabs(pixel101.x- (float)pixel_orig.x);
    float pixel101_diffG = fabs(pixel101.y- (float)pixel_orig.y);
    float pixel101_diffB = fabs(pixel101.z- (float)pixel_orig.z);
    float pixel101_diffA = fabs(pixel101.w- (float)pixel_orig.w);
   if ((pixel101_diffR<30)&& (pixel101_diffG< 30)&&(pixel101_diffB< 30 )&&(pixel101_diffA< 30)){
	    pixel_new += (pixel101)*(float)1.0; accumWeights += 1;
    }
    float pixel102_diffR = fabs(pixel102.x- (float)pixel_orig.x);
    float pixel102_diffG = fabs(pixel102.y- (float)pixel_orig.y);
    float pixel102_diffB = fabs(pixel102.z- (float)pixel_orig.z);
    float pixel102_diffA = fabs(pixel102.w- (float)pixel_orig.w);
   if ((pixel102_diffR<30)&& (pixel102_diffG< 30)&&(pixel102_diffB< 30 )&&(pixel102_diffA< 30)){
	    pixel_new += (pixel102)*(float)1.0; accumWeights += 1;
    }
    float pixel103_diffR = fabs(pixel103.x- (float)pixel_orig.x);
    float pixel103_diffG = fabs(pixel103.y- (float)pixel_orig.y);
    float pixel103_diffB = fabs(pixel103.z- (float)pixel_orig.z);
    float pixel103_diffA = fabs(pixel103.w- (float)pixel_orig.w);
   if ((pixel103_diffR<30)&& (pixel103_diffG< 30)&&(pixel103_diffB< 30 )&&(pixel103_diffA< 30)){
	    pixel_new += (pixel103)*(float)1.0; accumWeights += 1;
    }
    float pixel104_diffR = fabs(pixel104.x- (float)pixel_orig.x);
    float pixel104_diffG = fabs(pixel104.y- (float)pixel_orig.y);
    float pixel104_diffB = fabs(pixel104.z- (float)pixel_orig.z);
    float pixel104_diffA = fabs(pixel104.w- (float)pixel_orig.w);
   if ((pixel104_diffR<30)&& (pixel104_diffG< 30)&&(pixel104_diffB< 30 )&&(pixel104_diffA< 30)){
	    pixel_new += (pixel104)*(float)1.0; accumWeights += 1;
    }
    float pixel105_diffR = fabs(pixel105.x- (float)pixel_orig.x);
    float pixel105_diffG = fabs(pixel105.y- (float)pixel_orig.y);
    float pixel105_diffB = fabs(pixel105.z- (float)pixel_orig.z);
    float pixel105_diffA = fabs(pixel105.w- (float)pixel_orig.w);
   if ((pixel105_diffR<30)&& (pixel105_diffG< 30)&&(pixel105_diffB< 30 )&&(pixel105_diffA< 30)){
	    pixel_new += (pixel105)*(float)1.0; accumWeights += 1;
    }
    float pixel106_diffR = fabs(pixel106.x- (float)pixel_orig.x);
    float pixel106_diffG = fabs(pixel106.y- (float)pixel_orig.y);
    float pixel106_diffB = fabs(pixel106.z- (float)pixel_orig.z);
    float pixel106_diffA = fabs(pixel106.w- (float)pixel_orig.w);
   if ((pixel106_diffR<30)&& (pixel106_diffG< 30)&&(pixel106_diffB< 30 )&&(pixel106_diffA< 30)){
	    pixel_new += (pixel106)*(float)1.0; accumWeights += 1;
    }
    float pixel107_diffR = fabs(pixel107.x- (float)pixel_orig.x);
    float pixel107_diffG = fabs(pixel107.y- (float)pixel_orig.y);
    float pixel107_diffB = fabs(pixel107.z- (float)pixel_orig.z);
    float pixel107_diffA = fabs(pixel107.w- (float)pixel_orig.w);
   if ((pixel107_diffR<30)&& (pixel107_diffG< 30)&&(pixel107_diffB< 30 )&&(pixel107_diffA< 30)){
	    pixel_new += (pixel107)*(float)1.0; accumWeights += 1;
    }
    float pixel108_diffR = fabs(pixel108.x- (float)pixel_orig.x);
    float pixel108_diffG = fabs(pixel108.y- (float)pixel_orig.y);
    float pixel108_diffB = fabs(pixel108.z- (float)pixel_orig.z);
    float pixel108_diffA = fabs(pixel108.w- (float)pixel_orig.w);
   if ((pixel108_diffR<30)&& (pixel108_diffG< 30)&&(pixel108_diffB< 30 )&&(pixel108_diffA< 30)){
	    pixel_new += (pixel108)*(float)1.0; accumWeights += 1;
    }
    float pixel109_diffR = fabs(pixel109.x- (float)pixel_orig.x);
    float pixel109_diffG = fabs(pixel109.y- (float)pixel_orig.y);
    float pixel109_diffB = fabs(pixel109.z- (float)pixel_orig.z);
    float pixel109_diffA = fabs(pixel109.w- (float)pixel_orig.w);
   if ((pixel109_diffR<30)&& (pixel109_diffG< 30)&&(pixel109_diffB< 30 )&&(pixel109_diffA< 30)){
	    pixel_new += (pixel109)*(float)1.0; accumWeights += 1;
    }
    float pixel110_diffR = fabs(pixel110.x- (float)pixel_orig.x);
    float pixel110_diffG = fabs(pixel110.y- (float)pixel_orig.y);
    float pixel110_diffB = fabs(pixel110.z- (float)pixel_orig.z);
    float pixel110_diffA = fabs(pixel110.w- (float)pixel_orig.w);
   if ((pixel110_diffR<30)&& (pixel110_diffG< 30)&&(pixel110_diffB< 30 )&&(pixel110_diffA< 30)){
	    pixel_new += (pixel110)*(float)1.0; accumWeights += 1;
    }
    float pixel111_diffR = fabs(pixel111.x- (float)pixel_orig.x);
    float pixel111_diffG = fabs(pixel111.y- (float)pixel_orig.y);
    float pixel111_diffB = fabs(pixel111.z- (float)pixel_orig.z);
    float pixel111_diffA = fabs(pixel111.w- (float)pixel_orig.w);
   if ((pixel111_diffR<30)&& (pixel111_diffG< 30)&&(pixel111_diffB< 30 )&&(pixel111_diffA< 30)){
	    pixel_new += (pixel111)*(float)1.0; accumWeights += 1;
    }
    float pixel112_diffR = fabs(pixel112.x- (float)pixel_orig.x);
    float pixel112_diffG = fabs(pixel112.y- (float)pixel_orig.y);
    float pixel112_diffB = fabs(pixel112.z- (float)pixel_orig.z);
    float pixel112_diffA = fabs(pixel112.w- (float)pixel_orig.w);
   if ((pixel112_diffR<30)&& (pixel112_diffG< 30)&&(pixel112_diffB< 30 )&&(pixel112_diffA< 30)){
	    pixel_new += (pixel112)*(float)1.0; accumWeights += 1;
    }
    float pixel113_diffR = fabs(pixel113.x- (float)pixel_orig.x);
    float pixel113_diffG = fabs(pixel113.y- (float)pixel_orig.y);
    float pixel113_diffB = fabs(pixel113.z- (float)pixel_orig.z);
    float pixel113_diffA = fabs(pixel113.w- (float)pixel_orig.w);
   if ((pixel113_diffR<30)&& (pixel113_diffG< 30)&&(pixel113_diffB< 30 )&&(pixel113_diffA< 30)){
	    pixel_new += (pixel113)*(float)1.0; accumWeights += 1;
    }
    float pixel114_diffR = fabs(pixel114.x- (float)pixel_orig.x);
    float pixel114_diffG = fabs(pixel114.y- (float)pixel_orig.y);
    float pixel114_diffB = fabs(pixel114.z- (float)pixel_orig.z);
    float pixel114_diffA = fabs(pixel114.w- (float)pixel_orig.w);
   if ((pixel114_diffR<30)&& (pixel114_diffG< 30)&&(pixel114_diffB< 30 )&&(pixel114_diffA< 30)){
	    pixel_new += (pixel114)*(float)1.0; accumWeights += 1;
    }
    float pixel115_diffR = fabs(pixel115.x- (float)pixel_orig.x);
    float pixel115_diffG = fabs(pixel115.y- (float)pixel_orig.y);
    float pixel115_diffB = fabs(pixel115.z- (float)pixel_orig.z);
    float pixel115_diffA = fabs(pixel115.w- (float)pixel_orig.w);
   if ((pixel115_diffR<30)&& (pixel115_diffG< 30)&&(pixel115_diffB< 30 )&&(pixel115_diffA< 30)){
	    pixel_new += (pixel115)*(float)1.0; accumWeights += 1;
    }
    float pixel116_diffR = fabs(pixel116.x- (float)pixel_orig.x);
    float pixel116_diffG = fabs(pixel116.y- (float)pixel_orig.y);
    float pixel116_diffB = fabs(pixel116.z- (float)pixel_orig.z);
    float pixel116_diffA = fabs(pixel116.w- (float)pixel_orig.w);
   if ((pixel116_diffR<30)&& (pixel116_diffG< 30)&&(pixel116_diffB< 30 )&&(pixel116_diffA< 30)){
	    pixel_new += (pixel116)*(float)1.0; accumWeights += 1;
    }
    float pixel117_diffR = fabs(pixel117.x- (float)pixel_orig.x);
    float pixel117_diffG = fabs(pixel117.y- (float)pixel_orig.y);
    float pixel117_diffB = fabs(pixel117.z- (float)pixel_orig.z);
    float pixel117_diffA = fabs(pixel117.w- (float)pixel_orig.w);
   if ((pixel117_diffR<30)&& (pixel117_diffG< 30)&&(pixel117_diffB< 30 )&&(pixel117_diffA< 30)){
	    pixel_new += (pixel117)*(float)1.0; accumWeights += 1;
    }
    float pixel118_diffR = fabs(pixel118.x- (float)pixel_orig.x);
    float pixel118_diffG = fabs(pixel118.y- (float)pixel_orig.y);
    float pixel118_diffB = fabs(pixel118.z- (float)pixel_orig.z);
    float pixel118_diffA = fabs(pixel118.w- (float)pixel_orig.w);
   if ((pixel118_diffR<30)&& (pixel118_diffG< 30)&&(pixel118_diffB< 30 )&&(pixel118_diffA< 30)){
	    pixel_new += (pixel118)*(float)1.0; accumWeights += 1;
    }
    float pixel119_diffR = fabs(pixel119.x- (float)pixel_orig.x);
    float pixel119_diffG = fabs(pixel119.y- (float)pixel_orig.y);
    float pixel119_diffB = fabs(pixel119.z- (float)pixel_orig.z);
    float pixel119_diffA = fabs(pixel119.w- (float)pixel_orig.w);
   if ((pixel119_diffR<30)&& (pixel119_diffG< 30)&&(pixel119_diffB< 30 )&&(pixel119_diffA< 30)){
	    pixel_new += (pixel119)*(float)1.0; accumWeights += 1;
    }
    float pixel120_diffR = fabs(pixel120.x- (float)pixel_orig.x);
    float pixel120_diffG = fabs(pixel120.y- (float)pixel_orig.y);
    float pixel120_diffB = fabs(pixel120.z- (float)pixel_orig.z);
    float pixel120_diffA = fabs(pixel120.w- (float)pixel_orig.w);
   if ((pixel120_diffR<30)&& (pixel120_diffG< 30)&&(pixel120_diffB< 30 )&&(pixel120_diffA< 30)){
	    pixel_new += (pixel120)*(float)1.0; accumWeights += 1;
    }
    float pixel121_diffR = fabs(pixel121.x- (float)pixel_orig.x);
    float pixel121_diffG = fabs(pixel121.y- (float)pixel_orig.y);
    float pixel121_diffB = fabs(pixel121.z- (float)pixel_orig.z);
    float pixel121_diffA = fabs(pixel121.w- (float)pixel_orig.w);
   if ((pixel121_diffR<30)&& (pixel121_diffG< 30)&&(pixel121_diffB< 30 )&&(pixel121_diffA< 30)){
	    pixel_new += (pixel121)*(float)1.0; accumWeights += 1;
    }
    float pixel122_diffR = fabs(pixel122.x- (float)pixel_orig.x);
    float pixel122_diffG = fabs(pixel122.y- (float)pixel_orig.y);
    float pixel122_diffB = fabs(pixel122.z- (float)pixel_orig.z);
    float pixel122_diffA = fabs(pixel122.w- (float)pixel_orig.w);
   if ((pixel122_diffR<30)&& (pixel122_diffG< 30)&&(pixel122_diffB< 30 )&&(pixel122_diffA< 30)){
	    pixel_new += (pixel122)*(float)1.0; accumWeights += 1;
    }
    float pixel123_diffR = fabs(pixel123.x- (float)pixel_orig.x);
    float pixel123_diffG = fabs(pixel123.y- (float)pixel_orig.y);
    float pixel123_diffB = fabs(pixel123.z- (float)pixel_orig.z);
    float pixel123_diffA = fabs(pixel123.w- (float)pixel_orig.w);
   if ((pixel123_diffR<30)&& (pixel123_diffG< 30)&&(pixel123_diffB< 30 )&&(pixel123_diffA< 30)){
	    pixel_new += (pixel123)*(float)1.0; accumWeights += 1;
    }
    float pixel124_diffR = fabs(pixel124.x- (float)pixel_orig.x);
    float pixel124_diffG = fabs(pixel124.y- (float)pixel_orig.y);
    float pixel124_diffB = fabs(pixel124.z- (float)pixel_orig.z);
    float pixel124_diffA = fabs(pixel124.w- (float)pixel_orig.w);
   if ((pixel124_diffR<30)&& (pixel124_diffG< 30)&&(pixel124_diffB< 30 )&&(pixel124_diffA< 30)){
	    pixel_new += (pixel124)*(float)1.0; accumWeights += 1;
    }
    float pixel125_diffR = fabs(pixel125.x- (float)pixel_orig.x);
    float pixel125_diffG = fabs(pixel125.y- (float)pixel_orig.y);
    float pixel125_diffB = fabs(pixel125.z- (float)pixel_orig.z);
    float pixel125_diffA = fabs(pixel125.w- (float)pixel_orig.w);
   if ((pixel125_diffR<30)&& (pixel125_diffG< 30)&&(pixel125_diffB< 30 )&&(pixel125_diffA< 30)){
	    pixel_new += (pixel125)*(float)1.0; accumWeights += 1;
    }
    float pixel126_diffR = fabs(pixel126.x- (float)pixel_orig.x);
    float pixel126_diffG = fabs(pixel126.y- (float)pixel_orig.y);
    float pixel126_diffB = fabs(pixel126.z- (float)pixel_orig.z);
    float pixel126_diffA = fabs(pixel126.w- (float)pixel_orig.w);
   if ((pixel126_diffR<30)&& (pixel126_diffG< 30)&&(pixel126_diffB< 30 )&&(pixel126_diffA< 30)){
	    pixel_new += (pixel126)*(float)1.0; accumWeights += 1;
    }
    float pixel127_diffR = fabs(pixel127.x- (float)pixel_orig.x);
    float pixel127_diffG = fabs(pixel127.y- (float)pixel_orig.y);
    float pixel127_diffB = fabs(pixel127.z- (float)pixel_orig.z);
    float pixel127_diffA = fabs(pixel127.w- (float)pixel_orig.w);
   if ((pixel127_diffR<30)&& (pixel127_diffG< 30)&&(pixel127_diffB< 30 )&&(pixel127_diffA< 30)){
	    pixel_new += (pixel127)*(float)1.0; accumWeights += 1;
    }
    float pixel128_diffR = fabs(pixel128.x- (float)pixel_orig.x);
    float pixel128_diffG = fabs(pixel128.y- (float)pixel_orig.y);
    float pixel128_diffB = fabs(pixel128.z- (float)pixel_orig.z);
    float pixel128_diffA = fabs(pixel128.w- (float)pixel_orig.w);
   if ((pixel128_diffR<30)&& (pixel128_diffG< 30)&&(pixel128_diffB< 30 )&&(pixel128_diffA< 30)){
	    pixel_new += (pixel128)*(float)1.0; accumWeights += 1;
    }
    float pixel129_diffR = fabs(pixel129.x- (float)pixel_orig.x);
    float pixel129_diffG = fabs(pixel129.y- (float)pixel_orig.y);
    float pixel129_diffB = fabs(pixel129.z- (float)pixel_orig.z);
    float pixel129_diffA = fabs(pixel129.w- (float)pixel_orig.w);
   if ((pixel129_diffR<30)&& (pixel129_diffG< 30)&&(pixel129_diffB< 30 )&&(pixel129_diffA< 30)){
	    pixel_new += (pixel129)*(float)1.0; accumWeights += 1;
    }
    float pixel130_diffR = fabs(pixel130.x- (float)pixel_orig.x);
    float pixel130_diffG = fabs(pixel130.y- (float)pixel_orig.y);
    float pixel130_diffB = fabs(pixel130.z- (float)pixel_orig.z);
    float pixel130_diffA = fabs(pixel130.w- (float)pixel_orig.w);
   if ((pixel130_diffR<30)&& (pixel130_diffG< 30)&&(pixel130_diffB< 30 )&&(pixel130_diffA< 30)){
	    pixel_new += (pixel130)*(float)1.0; accumWeights += 1;
    }
    float pixel131_diffR = fabs(pixel131.x- (float)pixel_orig.x);
    float pixel131_diffG = fabs(pixel131.y- (float)pixel_orig.y);
    float pixel131_diffB = fabs(pixel131.z- (float)pixel_orig.z);
    float pixel131_diffA = fabs(pixel131.w- (float)pixel_orig.w);
   if ((pixel131_diffR<30)&& (pixel131_diffG< 30)&&(pixel131_diffB< 30 )&&(pixel131_diffA< 30)){
	    pixel_new += (pixel131)*(float)1.0; accumWeights += 1;
    }
    float pixel132_diffR = fabs(pixel132.x- (float)pixel_orig.x);
    float pixel132_diffG = fabs(pixel132.y- (float)pixel_orig.y);
    float pixel132_diffB = fabs(pixel132.z- (float)pixel_orig.z);
    float pixel132_diffA = fabs(pixel132.w- (float)pixel_orig.w);
   if ((pixel132_diffR<30)&& (pixel132_diffG< 30)&&(pixel132_diffB< 30 )&&(pixel132_diffA< 30)){
	    pixel_new += (pixel132)*(float)1.0; accumWeights += 1;
    }
    float pixel133_diffR = fabs(pixel133.x- (float)pixel_orig.x);
    float pixel133_diffG = fabs(pixel133.y- (float)pixel_orig.y);
    float pixel133_diffB = fabs(pixel133.z- (float)pixel_orig.z);
    float pixel133_diffA = fabs(pixel133.w- (float)pixel_orig.w);
   if ((pixel133_diffR<30)&& (pixel133_diffG< 30)&&(pixel133_diffB< 30 )&&(pixel133_diffA< 30)){
	    pixel_new += (pixel133)*(float)1.0; accumWeights += 1;
    }
    float pixel134_diffR = fabs(pixel134.x- (float)pixel_orig.x);
    float pixel134_diffG = fabs(pixel134.y- (float)pixel_orig.y);
    float pixel134_diffB = fabs(pixel134.z- (float)pixel_orig.z);
    float pixel134_diffA = fabs(pixel134.w- (float)pixel_orig.w);
   if ((pixel134_diffR<30)&& (pixel134_diffG< 30)&&(pixel134_diffB< 30 )&&(pixel134_diffA< 30)){
	    pixel_new += (pixel134)*(float)1.0; accumWeights += 1;
    }
    float pixel135_diffR = fabs(pixel135.x- (float)pixel_orig.x);
    float pixel135_diffG = fabs(pixel135.y- (float)pixel_orig.y);
    float pixel135_diffB = fabs(pixel135.z- (float)pixel_orig.z);
    float pixel135_diffA = fabs(pixel135.w- (float)pixel_orig.w);
   if ((pixel135_diffR<30)&& (pixel135_diffG< 30)&&(pixel135_diffB< 30 )&&(pixel135_diffA< 30)){
	    pixel_new += (pixel135)*(float)1.0; accumWeights += 1;
    }
    float pixel136_diffR = fabs(pixel136.x- (float)pixel_orig.x);
    float pixel136_diffG = fabs(pixel136.y- (float)pixel_orig.y);
    float pixel136_diffB = fabs(pixel136.z- (float)pixel_orig.z);
    float pixel136_diffA = fabs(pixel136.w- (float)pixel_orig.w);
   if ((pixel136_diffR<30)&& (pixel136_diffG< 30)&&(pixel136_diffB< 30 )&&(pixel136_diffA< 30)){
	    pixel_new += (pixel136)*(float)1.0; accumWeights += 1;
    }
    float pixel137_diffR = fabs(pixel137.x- (float)pixel_orig.x);
    float pixel137_diffG = fabs(pixel137.y- (float)pixel_orig.y);
    float pixel137_diffB = fabs(pixel137.z- (float)pixel_orig.z);
    float pixel137_diffA = fabs(pixel137.w- (float)pixel_orig.w);
   if ((pixel137_diffR<30)&& (pixel137_diffG< 30)&&(pixel137_diffB< 30 )&&(pixel137_diffA< 30)){
	    pixel_new += (pixel137)*(float)1.0; accumWeights += 1;
    }
    float pixel138_diffR = fabs(pixel138.x- (float)pixel_orig.x);
    float pixel138_diffG = fabs(pixel138.y- (float)pixel_orig.y);
    float pixel138_diffB = fabs(pixel138.z- (float)pixel_orig.z);
    float pixel138_diffA = fabs(pixel138.w- (float)pixel_orig.w);
   if ((pixel138_diffR<30)&& (pixel138_diffG< 30)&&(pixel138_diffB< 30 )&&(pixel138_diffA< 30)){
	    pixel_new += (pixel138)*(float)1.0; accumWeights += 1;
    }
    float pixel139_diffR = fabs(pixel139.x- (float)pixel_orig.x);
    float pixel139_diffG = fabs(pixel139.y- (float)pixel_orig.y);
    float pixel139_diffB = fabs(pixel139.z- (float)pixel_orig.z);
    float pixel139_diffA = fabs(pixel139.w- (float)pixel_orig.w);
   if ((pixel139_diffR<30)&& (pixel139_diffG< 30)&&(pixel139_diffB< 30 )&&(pixel139_diffA< 30)){
	    pixel_new += (pixel139)*(float)1.0; accumWeights += 1;
    }
    float pixel140_diffR = fabs(pixel140.x- (float)pixel_orig.x);
    float pixel140_diffG = fabs(pixel140.y- (float)pixel_orig.y);
    float pixel140_diffB = fabs(pixel140.z- (float)pixel_orig.z);
    float pixel140_diffA = fabs(pixel140.w- (float)pixel_orig.w);
   if ((pixel140_diffR<30)&& (pixel140_diffG< 30)&&(pixel140_diffB< 30 )&&(pixel140_diffA< 30)){
	    pixel_new += (pixel140)*(float)1.0; accumWeights += 1;
    }
    float pixel141_diffR = fabs(pixel141.x- (float)pixel_orig.x);
    float pixel141_diffG = fabs(pixel141.y- (float)pixel_orig.y);
    float pixel141_diffB = fabs(pixel141.z- (float)pixel_orig.z);
    float pixel141_diffA = fabs(pixel141.w- (float)pixel_orig.w);
   if ((pixel141_diffR<30)&& (pixel141_diffG< 30)&&(pixel141_diffB< 30 )&&(pixel141_diffA< 30)){
	    pixel_new += (pixel141)*(float)1.0; accumWeights += 1;
    }
    float pixel142_diffR = fabs(pixel142.x- (float)pixel_orig.x);
    float pixel142_diffG = fabs(pixel142.y- (float)pixel_orig.y);
    float pixel142_diffB = fabs(pixel142.z- (float)pixel_orig.z);
    float pixel142_diffA = fabs(pixel142.w- (float)pixel_orig.w);
   if ((pixel142_diffR<30)&& (pixel142_diffG< 30)&&(pixel142_diffB< 30 )&&(pixel142_diffA< 30)){
	    pixel_new += (pixel142)*(float)1.0; accumWeights += 1;
    }
    float pixel143_diffR = fabs(pixel143.x- (float)pixel_orig.x);
    float pixel143_diffG = fabs(pixel143.y- (float)pixel_orig.y);
    float pixel143_diffB = fabs(pixel143.z- (float)pixel_orig.z);
    float pixel143_diffA = fabs(pixel143.w- (float)pixel_orig.w);
   if ((pixel143_diffR<30)&& (pixel143_diffG< 30)&&(pixel143_diffB< 30 )&&(pixel143_diffA< 30)){
	    pixel_new += (pixel143)*(float)1.0; accumWeights += 1;
    }
    float pixel144_diffR = fabs(pixel144.x- (float)pixel_orig.x);
    float pixel144_diffG = fabs(pixel144.y- (float)pixel_orig.y);
    float pixel144_diffB = fabs(pixel144.z- (float)pixel_orig.z);
    float pixel144_diffA = fabs(pixel144.w- (float)pixel_orig.w);
   if ((pixel144_diffR<30)&& (pixel144_diffG< 30)&&(pixel144_diffB< 30 )&&(pixel144_diffA< 30)){
	    pixel_new += (pixel144)*(float)1.0; accumWeights += 1;
    }
    float pixel145_diffR = fabs(pixel145.x- (float)pixel_orig.x);
    float pixel145_diffG = fabs(pixel145.y- (float)pixel_orig.y);
    float pixel145_diffB = fabs(pixel145.z- (float)pixel_orig.z);
    float pixel145_diffA = fabs(pixel145.w- (float)pixel_orig.w);
   if ((pixel145_diffR<30)&& (pixel145_diffG< 30)&&(pixel145_diffB< 30 )&&(pixel145_diffA< 30)){
	    pixel_new += (pixel145)*(float)1.0; accumWeights += 1;
    }
    float pixel146_diffR = fabs(pixel146.x- (float)pixel_orig.x);
    float pixel146_diffG = fabs(pixel146.y- (float)pixel_orig.y);
    float pixel146_diffB = fabs(pixel146.z- (float)pixel_orig.z);
    float pixel146_diffA = fabs(pixel146.w- (float)pixel_orig.w);
   if ((pixel146_diffR<30)&& (pixel146_diffG< 30)&&(pixel146_diffB< 30 )&&(pixel146_diffA< 30)){
	    pixel_new += (pixel146)*(float)1.0; accumWeights += 1;
    }
    float pixel147_diffR = fabs(pixel147.x- (float)pixel_orig.x);
    float pixel147_diffG = fabs(pixel147.y- (float)pixel_orig.y);
    float pixel147_diffB = fabs(pixel147.z- (float)pixel_orig.z);
    float pixel147_diffA = fabs(pixel147.w- (float)pixel_orig.w);
   if ((pixel147_diffR<30)&& (pixel147_diffG< 30)&&(pixel147_diffB< 30 )&&(pixel147_diffA< 30)){
	    pixel_new += (pixel147)*(float)1.0; accumWeights += 1;
    }
    float pixel148_diffR = fabs(pixel148.x- (float)pixel_orig.x);
    float pixel148_diffG = fabs(pixel148.y- (float)pixel_orig.y);
    float pixel148_diffB = fabs(pixel148.z- (float)pixel_orig.z);
    float pixel148_diffA = fabs(pixel148.w- (float)pixel_orig.w);
   if ((pixel148_diffR<30)&& (pixel148_diffG< 30)&&(pixel148_diffB< 30 )&&(pixel148_diffA< 30)){
	    pixel_new += (pixel148)*(float)1.0; accumWeights += 1;
    }
    float pixel149_diffR = fabs(pixel149.x- (float)pixel_orig.x);
    float pixel149_diffG = fabs(pixel149.y- (float)pixel_orig.y);
    float pixel149_diffB = fabs(pixel149.z- (float)pixel_orig.z);
    float pixel149_diffA = fabs(pixel149.w- (float)pixel_orig.w);
   if ((pixel149_diffR<30)&& (pixel149_diffG< 30)&&(pixel149_diffB< 30 )&&(pixel149_diffA< 30)){
	    pixel_new += (pixel149)*(float)1.0; accumWeights += 1;
    }
    float pixel150_diffR = fabs(pixel150.x- (float)pixel_orig.x);
    float pixel150_diffG = fabs(pixel150.y- (float)pixel_orig.y);
    float pixel150_diffB = fabs(pixel150.z- (float)pixel_orig.z);
    float pixel150_diffA = fabs(pixel150.w- (float)pixel_orig.w);
   if ((pixel150_diffR<30)&& (pixel150_diffG< 30)&&(pixel150_diffB< 30 )&&(pixel150_diffA< 30)){
	    pixel_new += (pixel150)*(float)1.0; accumWeights += 1;
    }
    float pixel151_diffR = fabs(pixel151.x- (float)pixel_orig.x);
    float pixel151_diffG = fabs(pixel151.y- (float)pixel_orig.y);
    float pixel151_diffB = fabs(pixel151.z- (float)pixel_orig.z);
    float pixel151_diffA = fabs(pixel151.w- (float)pixel_orig.w);
   if ((pixel151_diffR<30)&& (pixel151_diffG< 30)&&(pixel151_diffB< 30 )&&(pixel151_diffA< 30)){
	    pixel_new += (pixel151)*(float)1.0; accumWeights += 1;
    }
    float pixel152_diffR = fabs(pixel152.x- (float)pixel_orig.x);
    float pixel152_diffG = fabs(pixel152.y- (float)pixel_orig.y);
    float pixel152_diffB = fabs(pixel152.z- (float)pixel_orig.z);
    float pixel152_diffA = fabs(pixel152.w- (float)pixel_orig.w);
   if ((pixel152_diffR<30)&& (pixel152_diffG< 30)&&(pixel152_diffB< 30 )&&(pixel152_diffA< 30)){
	    pixel_new += (pixel152)*(float)1.0; accumWeights += 1;
    }
    float pixel153_diffR = fabs(pixel153.x- (float)pixel_orig.x);
    float pixel153_diffG = fabs(pixel153.y- (float)pixel_orig.y);
    float pixel153_diffB = fabs(pixel153.z- (float)pixel_orig.z);
    float pixel153_diffA = fabs(pixel153.w- (float)pixel_orig.w);
   if ((pixel153_diffR<30)&& (pixel153_diffG< 30)&&(pixel153_diffB< 30 )&&(pixel153_diffA< 30)){
	    pixel_new += (pixel153)*(float)1.0; accumWeights += 1;
    }
    float pixel154_diffR = fabs(pixel154.x- (float)pixel_orig.x);
    float pixel154_diffG = fabs(pixel154.y- (float)pixel_orig.y);
    float pixel154_diffB = fabs(pixel154.z- (float)pixel_orig.z);
    float pixel154_diffA = fabs(pixel154.w- (float)pixel_orig.w);
   if ((pixel154_diffR<30)&& (pixel154_diffG< 30)&&(pixel154_diffB< 30 )&&(pixel154_diffA< 30)){
	    pixel_new += (pixel154)*(float)1.0; accumWeights += 1;
    }
    float pixel155_diffR = fabs(pixel155.x- (float)pixel_orig.x);
    float pixel155_diffG = fabs(pixel155.y- (float)pixel_orig.y);
    float pixel155_diffB = fabs(pixel155.z- (float)pixel_orig.z);
    float pixel155_diffA = fabs(pixel155.w- (float)pixel_orig.w);
   if ((pixel155_diffR<30)&& (pixel155_diffG< 30)&&(pixel155_diffB< 30 )&&(pixel155_diffA< 30)){
	    pixel_new += (pixel155)*(float)1.0; accumWeights += 1;
    }
    float pixel156_diffR = fabs(pixel156.x- (float)pixel_orig.x);
    float pixel156_diffG = fabs(pixel156.y- (float)pixel_orig.y);
    float pixel156_diffB = fabs(pixel156.z- (float)pixel_orig.z);
    float pixel156_diffA = fabs(pixel156.w- (float)pixel_orig.w);
   if ((pixel156_diffR<30)&& (pixel156_diffG< 30)&&(pixel156_diffB< 30 )&&(pixel156_diffA< 30)){
	    pixel_new += (pixel156)*(float)1.0; accumWeights += 1;
    }
    float pixel157_diffR = fabs(pixel157.x- (float)pixel_orig.x);
    float pixel157_diffG = fabs(pixel157.y- (float)pixel_orig.y);
    float pixel157_diffB = fabs(pixel157.z- (float)pixel_orig.z);
    float pixel157_diffA = fabs(pixel157.w- (float)pixel_orig.w);
   if ((pixel157_diffR<30)&& (pixel157_diffG< 30)&&(pixel157_diffB< 30 )&&(pixel157_diffA< 30)){
	    pixel_new += (pixel157)*(float)1.0; accumWeights += 1;
    }
    float pixel158_diffR = fabs(pixel158.x- (float)pixel_orig.x);
    float pixel158_diffG = fabs(pixel158.y- (float)pixel_orig.y);
    float pixel158_diffB = fabs(pixel158.z- (float)pixel_orig.z);
    float pixel158_diffA = fabs(pixel158.w- (float)pixel_orig.w);
   if ((pixel158_diffR<30)&& (pixel158_diffG< 30)&&(pixel158_diffB< 30 )&&(pixel158_diffA< 30)){
	    pixel_new += (pixel158)*(float)1.0; accumWeights += 1;
    }
    float pixel159_diffR = fabs(pixel159.x- (float)pixel_orig.x);
    float pixel159_diffG = fabs(pixel159.y- (float)pixel_orig.y);
    float pixel159_diffB = fabs(pixel159.z- (float)pixel_orig.z);
    float pixel159_diffA = fabs(pixel159.w- (float)pixel_orig.w);
   if ((pixel159_diffR<30)&& (pixel159_diffG< 30)&&(pixel159_diffB< 30 )&&(pixel159_diffA< 30)){
	    pixel_new += (pixel159)*(float)1.0; accumWeights += 1;
    }
    float pixel160_diffR = fabs(pixel160.x- (float)pixel_orig.x);
    float pixel160_diffG = fabs(pixel160.y- (float)pixel_orig.y);
    float pixel160_diffB = fabs(pixel160.z- (float)pixel_orig.z);
    float pixel160_diffA = fabs(pixel160.w- (float)pixel_orig.w);
   if ((pixel160_diffR<30)&& (pixel160_diffG< 30)&&(pixel160_diffB< 30 )&&(pixel160_diffA< 30)){
	    pixel_new += (pixel160)*(float)1.0; accumWeights += 1;
    }
    float pixel161_diffR = fabs(pixel161.x- (float)pixel_orig.x);
    float pixel161_diffG = fabs(pixel161.y- (float)pixel_orig.y);
    float pixel161_diffB = fabs(pixel161.z- (float)pixel_orig.z);
    float pixel161_diffA = fabs(pixel161.w- (float)pixel_orig.w);
   if ((pixel161_diffR<30)&& (pixel161_diffG< 30)&&(pixel161_diffB< 30 )&&(pixel161_diffA< 30)){
	    pixel_new += (pixel161)*(float)1.0; accumWeights += 1;
    }
    float pixel162_diffR = fabs(pixel162.x- (float)pixel_orig.x);
    float pixel162_diffG = fabs(pixel162.y- (float)pixel_orig.y);
    float pixel162_diffB = fabs(pixel162.z- (float)pixel_orig.z);
    float pixel162_diffA = fabs(pixel162.w- (float)pixel_orig.w);
   if ((pixel162_diffR<30)&& (pixel162_diffG< 30)&&(pixel162_diffB< 30 )&&(pixel162_diffA< 30)){
	    pixel_new += (pixel162)*(float)1.0; accumWeights += 1;
    }
    float pixel163_diffR = fabs(pixel163.x- (float)pixel_orig.x);
    float pixel163_diffG = fabs(pixel163.y- (float)pixel_orig.y);
    float pixel163_diffB = fabs(pixel163.z- (float)pixel_orig.z);
    float pixel163_diffA = fabs(pixel163.w- (float)pixel_orig.w);
   if ((pixel163_diffR<30)&& (pixel163_diffG< 30)&&(pixel163_diffB< 30 )&&(pixel163_diffA< 30)){
	    pixel_new += (pixel163)*(float)1.0; accumWeights += 1;
    }
    float pixel164_diffR = fabs(pixel164.x- (float)pixel_orig.x);
    float pixel164_diffG = fabs(pixel164.y- (float)pixel_orig.y);
    float pixel164_diffB = fabs(pixel164.z- (float)pixel_orig.z);
    float pixel164_diffA = fabs(pixel164.w- (float)pixel_orig.w);
   if ((pixel164_diffR<30)&& (pixel164_diffG< 30)&&(pixel164_diffB< 30 )&&(pixel164_diffA< 30)){
	    pixel_new += (pixel164)*(float)1.0; accumWeights += 1;
    }
    float pixel165_diffR = fabs(pixel165.x- (float)pixel_orig.x);
    float pixel165_diffG = fabs(pixel165.y- (float)pixel_orig.y);
    float pixel165_diffB = fabs(pixel165.z- (float)pixel_orig.z);
    float pixel165_diffA = fabs(pixel165.w- (float)pixel_orig.w);
   if ((pixel165_diffR<30)&& (pixel165_diffG< 30)&&(pixel165_diffB< 30 )&&(pixel165_diffA< 30)){
	    pixel_new += (pixel165)*(float)1.0; accumWeights += 1;
    }
    float pixel166_diffR = fabs(pixel166.x- (float)pixel_orig.x);
    float pixel166_diffG = fabs(pixel166.y- (float)pixel_orig.y);
    float pixel166_diffB = fabs(pixel166.z- (float)pixel_orig.z);
    float pixel166_diffA = fabs(pixel166.w- (float)pixel_orig.w);
   if ((pixel166_diffR<30)&& (pixel166_diffG< 30)&&(pixel166_diffB< 30 )&&(pixel166_diffA< 30)){
	    pixel_new += (pixel166)*(float)1.0; accumWeights += 1;
    }
    float pixel167_diffR = fabs(pixel167.x- (float)pixel_orig.x);
    float pixel167_diffG = fabs(pixel167.y- (float)pixel_orig.y);
    float pixel167_diffB = fabs(pixel167.z- (float)pixel_orig.z);
    float pixel167_diffA = fabs(pixel167.w- (float)pixel_orig.w);
   if ((pixel167_diffR<30)&& (pixel167_diffG< 30)&&(pixel167_diffB< 30 )&&(pixel167_diffA< 30)){
	    pixel_new += (pixel167)*(float)1.0; accumWeights += 1;
    }
    float pixel168_diffR = fabs(pixel168.x- (float)pixel_orig.x);
    float pixel168_diffG = fabs(pixel168.y- (float)pixel_orig.y);
    float pixel168_diffB = fabs(pixel168.z- (float)pixel_orig.z);
    float pixel168_diffA = fabs(pixel168.w- (float)pixel_orig.w);
   if ((pixel168_diffR<30)&& (pixel168_diffG< 30)&&(pixel168_diffB< 30 )&&(pixel168_diffA< 30)){
	    pixel_new += (pixel168)*(float)1.0; accumWeights += 1;
    }
    float pixel169_diffR = fabs(pixel169.x- (float)pixel_orig.x);
    float pixel169_diffG = fabs(pixel169.y- (float)pixel_orig.y);
    float pixel169_diffB = fabs(pixel169.z- (float)pixel_orig.z);
    float pixel169_diffA = fabs(pixel169.w- (float)pixel_orig.w);
   if ((pixel169_diffR<30)&& (pixel169_diffG< 30)&&(pixel169_diffB< 30 )&&(pixel169_diffA< 30)){
	    pixel_new += (pixel169)*(float)1.0; accumWeights += 1;
    }
    float pixel170_diffR = fabs(pixel170.x- (float)pixel_orig.x);
    float pixel170_diffG = fabs(pixel170.y- (float)pixel_orig.y);
    float pixel170_diffB = fabs(pixel170.z- (float)pixel_orig.z);
    float pixel170_diffA = fabs(pixel170.w- (float)pixel_orig.w);
   if ((pixel170_diffR<30)&& (pixel170_diffG< 30)&&(pixel170_diffB< 30 )&&(pixel170_diffA< 30)){
	    pixel_new += (pixel170)*(float)1.0; accumWeights += 1;
    }
    float pixel171_diffR = fabs(pixel171.x- (float)pixel_orig.x);
    float pixel171_diffG = fabs(pixel171.y- (float)pixel_orig.y);
    float pixel171_diffB = fabs(pixel171.z- (float)pixel_orig.z);
    float pixel171_diffA = fabs(pixel171.w- (float)pixel_orig.w);
   if ((pixel171_diffR<30)&& (pixel171_diffG< 30)&&(pixel171_diffB< 30 )&&(pixel171_diffA< 30)){
	    pixel_new += (pixel171)*(float)1.0; accumWeights += 1;
    }
    float pixel172_diffR = fabs(pixel172.x- (float)pixel_orig.x);
    float pixel172_diffG = fabs(pixel172.y- (float)pixel_orig.y);
    float pixel172_diffB = fabs(pixel172.z- (float)pixel_orig.z);
    float pixel172_diffA = fabs(pixel172.w- (float)pixel_orig.w);
   if ((pixel172_diffR<30)&& (pixel172_diffG< 30)&&(pixel172_diffB< 30 )&&(pixel172_diffA< 30)){
	    pixel_new += (pixel172)*(float)1.0; accumWeights += 1;
    }
    float pixel173_diffR = fabs(pixel173.x- (float)pixel_orig.x);
    float pixel173_diffG = fabs(pixel173.y- (float)pixel_orig.y);
    float pixel173_diffB = fabs(pixel173.z- (float)pixel_orig.z);
    float pixel173_diffA = fabs(pixel173.w- (float)pixel_orig.w);
   if ((pixel173_diffR<30)&& (pixel173_diffG< 30)&&(pixel173_diffB< 30 )&&(pixel173_diffA< 30)){
	    pixel_new += (pixel173)*(float)1.0; accumWeights += 1;
    }
    float pixel174_diffR = fabs(pixel174.x- (float)pixel_orig.x);
    float pixel174_diffG = fabs(pixel174.y- (float)pixel_orig.y);
    float pixel174_diffB = fabs(pixel174.z- (float)pixel_orig.z);
    float pixel174_diffA = fabs(pixel174.w- (float)pixel_orig.w);
   if ((pixel174_diffR<30)&& (pixel174_diffG< 30)&&(pixel174_diffB< 30 )&&(pixel174_diffA< 30)){
	    pixel_new += (pixel174)*(float)1.0; accumWeights += 1;
    }
    float pixel175_diffR = fabs(pixel175.x- (float)pixel_orig.x);
    float pixel175_diffG = fabs(pixel175.y- (float)pixel_orig.y);
    float pixel175_diffB = fabs(pixel175.z- (float)pixel_orig.z);
    float pixel175_diffA = fabs(pixel175.w- (float)pixel_orig.w);
   if ((pixel175_diffR<30)&& (pixel175_diffG< 30)&&(pixel175_diffB< 30 )&&(pixel175_diffA< 30)){
	    pixel_new += (pixel175)*(float)1.0; accumWeights += 1;
    }
    float pixel176_diffR = fabs(pixel176.x- (float)pixel_orig.x);
    float pixel176_diffG = fabs(pixel176.y- (float)pixel_orig.y);
    float pixel176_diffB = fabs(pixel176.z- (float)pixel_orig.z);
    float pixel176_diffA = fabs(pixel176.w- (float)pixel_orig.w);
   if ((pixel176_diffR<30)&& (pixel176_diffG< 30)&&(pixel176_diffB< 30 )&&(pixel176_diffA< 30)){
	    pixel_new += (pixel176)*(float)1.0; accumWeights += 1;
    }
    float pixel177_diffR = fabs(pixel177.x- (float)pixel_orig.x);
    float pixel177_diffG = fabs(pixel177.y- (float)pixel_orig.y);
    float pixel177_diffB = fabs(pixel177.z- (float)pixel_orig.z);
    float pixel177_diffA = fabs(pixel177.w- (float)pixel_orig.w);
   if ((pixel177_diffR<30)&& (pixel177_diffG< 30)&&(pixel177_diffB< 30 )&&(pixel177_diffA< 30)){
	    pixel_new += (pixel177)*(float)1.0; accumWeights += 1;
    }
    float pixel178_diffR = fabs(pixel178.x- (float)pixel_orig.x);
    float pixel178_diffG = fabs(pixel178.y- (float)pixel_orig.y);
    float pixel178_diffB = fabs(pixel178.z- (float)pixel_orig.z);
    float pixel178_diffA = fabs(pixel178.w- (float)pixel_orig.w);
   if ((pixel178_diffR<30)&& (pixel178_diffG< 30)&&(pixel178_diffB< 30 )&&(pixel178_diffA< 30)){
	    pixel_new += (pixel178)*(float)1.0; accumWeights += 1;
    }
    float pixel179_diffR = fabs(pixel179.x- (float)pixel_orig.x);
    float pixel179_diffG = fabs(pixel179.y- (float)pixel_orig.y);
    float pixel179_diffB = fabs(pixel179.z- (float)pixel_orig.z);
    float pixel179_diffA = fabs(pixel179.w- (float)pixel_orig.w);
   if ((pixel179_diffR<30)&& (pixel179_diffG< 30)&&(pixel179_diffB< 30 )&&(pixel179_diffA< 30)){
	    pixel_new += (pixel179)*(float)1.0; accumWeights += 1;
    }
    float pixel180_diffR = fabs(pixel180.x- (float)pixel_orig.x);
    float pixel180_diffG = fabs(pixel180.y- (float)pixel_orig.y);
    float pixel180_diffB = fabs(pixel180.z- (float)pixel_orig.z);
    float pixel180_diffA = fabs(pixel180.w- (float)pixel_orig.w);
   if ((pixel180_diffR<30)&& (pixel180_diffG< 30)&&(pixel180_diffB< 30 )&&(pixel180_diffA< 30)){
	    pixel_new += (pixel180)*(float)1.0; accumWeights += 1;
    }
    float pixel181_diffR = fabs(pixel181.x- (float)pixel_orig.x);
    float pixel181_diffG = fabs(pixel181.y- (float)pixel_orig.y);
    float pixel181_diffB = fabs(pixel181.z- (float)pixel_orig.z);
    float pixel181_diffA = fabs(pixel181.w- (float)pixel_orig.w);
   if ((pixel181_diffR<30)&& (pixel181_diffG< 30)&&(pixel181_diffB< 30 )&&(pixel181_diffA< 30)){
	    pixel_new += (pixel181)*(float)1.0; accumWeights += 1;
    }
    float pixel182_diffR = fabs(pixel182.x- (float)pixel_orig.x);
    float pixel182_diffG = fabs(pixel182.y- (float)pixel_orig.y);
    float pixel182_diffB = fabs(pixel182.z- (float)pixel_orig.z);
    float pixel182_diffA = fabs(pixel182.w- (float)pixel_orig.w);
   if ((pixel182_diffR<30)&& (pixel182_diffG< 30)&&(pixel182_diffB< 30 )&&(pixel182_diffA< 30)){
	    pixel_new += (pixel182)*(float)1.0; accumWeights += 1;
    }
    float pixel183_diffR = fabs(pixel183.x- (float)pixel_orig.x);
    float pixel183_diffG = fabs(pixel183.y- (float)pixel_orig.y);
    float pixel183_diffB = fabs(pixel183.z- (float)pixel_orig.z);
    float pixel183_diffA = fabs(pixel183.w- (float)pixel_orig.w);
   if ((pixel183_diffR<30)&& (pixel183_diffG< 30)&&(pixel183_diffB< 30 )&&(pixel183_diffA< 30)){
	    pixel_new += (pixel183)*(float)1.0; accumWeights += 1;
    }
    float pixel184_diffR = fabs(pixel184.x- (float)pixel_orig.x);
    float pixel184_diffG = fabs(pixel184.y- (float)pixel_orig.y);
    float pixel184_diffB = fabs(pixel184.z- (float)pixel_orig.z);
    float pixel184_diffA = fabs(pixel184.w- (float)pixel_orig.w);
   if ((pixel184_diffR<30)&& (pixel184_diffG< 30)&&(pixel184_diffB< 30 )&&(pixel184_diffA< 30)){
	    pixel_new += (pixel184)*(float)1.0; accumWeights += 1;
    }
    float pixel185_diffR = fabs(pixel185.x- (float)pixel_orig.x);
    float pixel185_diffG = fabs(pixel185.y- (float)pixel_orig.y);
    float pixel185_diffB = fabs(pixel185.z- (float)pixel_orig.z);
    float pixel185_diffA = fabs(pixel185.w- (float)pixel_orig.w);
   if ((pixel185_diffR<30)&& (pixel185_diffG< 30)&&(pixel185_diffB< 30 )&&(pixel185_diffA< 30)){
	    pixel_new += (pixel185)*(float)1.0; accumWeights += 1;
    }
    float pixel186_diffR = fabs(pixel186.x- (float)pixel_orig.x);
    float pixel186_diffG = fabs(pixel186.y- (float)pixel_orig.y);
    float pixel186_diffB = fabs(pixel186.z- (float)pixel_orig.z);
    float pixel186_diffA = fabs(pixel186.w- (float)pixel_orig.w);
   if ((pixel186_diffR<30)&& (pixel186_diffG< 30)&&(pixel186_diffB< 30 )&&(pixel186_diffA< 30)){
	    pixel_new += (pixel186)*(float)1.0; accumWeights += 1;
    }
    float pixel187_diffR = fabs(pixel187.x- (float)pixel_orig.x);
    float pixel187_diffG = fabs(pixel187.y- (float)pixel_orig.y);
    float pixel187_diffB = fabs(pixel187.z- (float)pixel_orig.z);
    float pixel187_diffA = fabs(pixel187.w- (float)pixel_orig.w);
   if ((pixel187_diffR<30)&& (pixel187_diffG< 30)&&(pixel187_diffB< 30 )&&(pixel187_diffA< 30)){
	    pixel_new += (pixel187)*(float)1.0; accumWeights += 1;
    }
    float pixel188_diffR = fabs(pixel188.x- (float)pixel_orig.x);
    float pixel188_diffG = fabs(pixel188.y- (float)pixel_orig.y);
    float pixel188_diffB = fabs(pixel188.z- (float)pixel_orig.z);
    float pixel188_diffA = fabs(pixel188.w- (float)pixel_orig.w);
   if ((pixel188_diffR<30)&& (pixel188_diffG< 30)&&(pixel188_diffB< 30 )&&(pixel188_diffA< 30)){
	    pixel_new += (pixel188)*(float)1.0; accumWeights += 1;
    }
    float pixel189_diffR = fabs(pixel189.x- (float)pixel_orig.x);
    float pixel189_diffG = fabs(pixel189.y- (float)pixel_orig.y);
    float pixel189_diffB = fabs(pixel189.z- (float)pixel_orig.z);
    float pixel189_diffA = fabs(pixel189.w- (float)pixel_orig.w);
   if ((pixel189_diffR<30)&& (pixel189_diffG< 30)&&(pixel189_diffB< 30 )&&(pixel189_diffA< 30)){
	    pixel_new += (pixel189)*(float)1.0; accumWeights += 1;
    }
    float pixel190_diffR = fabs(pixel190.x- (float)pixel_orig.x);
    float pixel190_diffG = fabs(pixel190.y- (float)pixel_orig.y);
    float pixel190_diffB = fabs(pixel190.z- (float)pixel_orig.z);
    float pixel190_diffA = fabs(pixel190.w- (float)pixel_orig.w);
   if ((pixel190_diffR<30)&& (pixel190_diffG< 30)&&(pixel190_diffB< 30 )&&(pixel190_diffA< 30)){
	    pixel_new += (pixel190)*(float)1.0; accumWeights += 1;
    }
    float pixel191_diffR = fabs(pixel191.x- (float)pixel_orig.x);
    float pixel191_diffG = fabs(pixel191.y- (float)pixel_orig.y);
    float pixel191_diffB = fabs(pixel191.z- (float)pixel_orig.z);
    float pixel191_diffA = fabs(pixel191.w- (float)pixel_orig.w);
   if ((pixel191_diffR<30)&& (pixel191_diffG< 30)&&(pixel191_diffB< 30 )&&(pixel191_diffA< 30)){
	    pixel_new += (pixel191)*(float)1.0; accumWeights += 1;
    }
    float pixel192_diffR = fabs(pixel192.x- (float)pixel_orig.x);
    float pixel192_diffG = fabs(pixel192.y- (float)pixel_orig.y);
    float pixel192_diffB = fabs(pixel192.z- (float)pixel_orig.z);
    float pixel192_diffA = fabs(pixel192.w- (float)pixel_orig.w);
   if ((pixel192_diffR<30)&& (pixel192_diffG< 30)&&(pixel192_diffB< 30 )&&(pixel192_diffA< 30)){
	    pixel_new += (pixel192)*(float)1.0; accumWeights += 1;
    }
    float pixel193_diffR = fabs(pixel193.x- (float)pixel_orig.x);
    float pixel193_diffG = fabs(pixel193.y- (float)pixel_orig.y);
    float pixel193_diffB = fabs(pixel193.z- (float)pixel_orig.z);
    float pixel193_diffA = fabs(pixel193.w- (float)pixel_orig.w);
   if ((pixel193_diffR<30)&& (pixel193_diffG< 30)&&(pixel193_diffB< 30 )&&(pixel193_diffA< 30)){
	    pixel_new += (pixel193)*(float)1.0; accumWeights += 1;
    }
    float pixel194_diffR = fabs(pixel194.x- (float)pixel_orig.x);
    float pixel194_diffG = fabs(pixel194.y- (float)pixel_orig.y);
    float pixel194_diffB = fabs(pixel194.z- (float)pixel_orig.z);
    float pixel194_diffA = fabs(pixel194.w- (float)pixel_orig.w);
   if ((pixel194_diffR<30)&& (pixel194_diffG< 30)&&(pixel194_diffB< 30 )&&(pixel194_diffA< 30)){
	    pixel_new += (pixel194)*(float)1.0; accumWeights += 1;
    }
    float pixel195_diffR = fabs(pixel195.x- (float)pixel_orig.x);
    float pixel195_diffG = fabs(pixel195.y- (float)pixel_orig.y);
    float pixel195_diffB = fabs(pixel195.z- (float)pixel_orig.z);
    float pixel195_diffA = fabs(pixel195.w- (float)pixel_orig.w);
   if ((pixel195_diffR<30)&& (pixel195_diffG< 30)&&(pixel195_diffB< 30 )&&(pixel195_diffA< 30)){
	    pixel_new += (pixel195)*(float)1.0; accumWeights += 1;
    }
    float pixel196_diffR = fabs(pixel196.x- (float)pixel_orig.x);
    float pixel196_diffG = fabs(pixel196.y- (float)pixel_orig.y);
    float pixel196_diffB = fabs(pixel196.z- (float)pixel_orig.z);
    float pixel196_diffA = fabs(pixel196.w- (float)pixel_orig.w);
   if ((pixel196_diffR<30)&& (pixel196_diffG< 30)&&(pixel196_diffB< 30 )&&(pixel196_diffA< 30)){
	    pixel_new += (pixel196)*(float)1.0; accumWeights += 1;
    }
    float pixel197_diffR = fabs(pixel197.x- (float)pixel_orig.x);
    float pixel197_diffG = fabs(pixel197.y- (float)pixel_orig.y);
    float pixel197_diffB = fabs(pixel197.z- (float)pixel_orig.z);
    float pixel197_diffA = fabs(pixel197.w- (float)pixel_orig.w);
   if ((pixel197_diffR<30)&& (pixel197_diffG< 30)&&(pixel197_diffB< 30 )&&(pixel197_diffA< 30)){
	    pixel_new += (pixel197)*(float)1.0; accumWeights += 1;
    }
    float pixel198_diffR = fabs(pixel198.x- (float)pixel_orig.x);
    float pixel198_diffG = fabs(pixel198.y- (float)pixel_orig.y);
    float pixel198_diffB = fabs(pixel198.z- (float)pixel_orig.z);
    float pixel198_diffA = fabs(pixel198.w- (float)pixel_orig.w);
   if ((pixel198_diffR<30)&& (pixel198_diffG< 30)&&(pixel198_diffB< 30 )&&(pixel198_diffA< 30)){
	    pixel_new += (pixel198)*(float)1.0; accumWeights += 1;
    }
    float pixel199_diffR = fabs(pixel199.x- (float)pixel_orig.x);
    float pixel199_diffG = fabs(pixel199.y- (float)pixel_orig.y);
    float pixel199_diffB = fabs(pixel199.z- (float)pixel_orig.z);
    float pixel199_diffA = fabs(pixel199.w- (float)pixel_orig.w);
   if ((pixel199_diffR<30)&& (pixel199_diffG< 30)&&(pixel199_diffB< 30 )&&(pixel199_diffA< 30)){
	    pixel_new += (pixel199)*(float)1.0; accumWeights += 1;
    }
    float pixel200_diffR = fabs(pixel200.x- (float)pixel_orig.x);
    float pixel200_diffG = fabs(pixel200.y- (float)pixel_orig.y);
    float pixel200_diffB = fabs(pixel200.z- (float)pixel_orig.z);
    float pixel200_diffA = fabs(pixel200.w- (float)pixel_orig.w);
   if ((pixel200_diffR<30)&& (pixel200_diffG< 30)&&(pixel200_diffB< 30 )&&(pixel200_diffA< 30)){
	    pixel_new += (pixel200)*(float)1.0; accumWeights += 1;
    }
    float pixel201_diffR = fabs(pixel201.x- (float)pixel_orig.x);
    float pixel201_diffG = fabs(pixel201.y- (float)pixel_orig.y);
    float pixel201_diffB = fabs(pixel201.z- (float)pixel_orig.z);
    float pixel201_diffA = fabs(pixel201.w- (float)pixel_orig.w);
   if ((pixel201_diffR<30)&& (pixel201_diffG< 30)&&(pixel201_diffB< 30 )&&(pixel201_diffA< 30)){
	    pixel_new += (pixel201)*(float)1.0; accumWeights += 1;
    }
    float pixel202_diffR = fabs(pixel202.x- (float)pixel_orig.x);
    float pixel202_diffG = fabs(pixel202.y- (float)pixel_orig.y);
    float pixel202_diffB = fabs(pixel202.z- (float)pixel_orig.z);
    float pixel202_diffA = fabs(pixel202.w- (float)pixel_orig.w);
   if ((pixel202_diffR<30)&& (pixel202_diffG< 30)&&(pixel202_diffB< 30 )&&(pixel202_diffA< 30)){
	    pixel_new += (pixel202)*(float)1.0; accumWeights += 1;
    }
    float pixel203_diffR = fabs(pixel203.x- (float)pixel_orig.x);
    float pixel203_diffG = fabs(pixel203.y- (float)pixel_orig.y);
    float pixel203_diffB = fabs(pixel203.z- (float)pixel_orig.z);
    float pixel203_diffA = fabs(pixel203.w- (float)pixel_orig.w);
   if ((pixel203_diffR<30)&& (pixel203_diffG< 30)&&(pixel203_diffB< 30 )&&(pixel203_diffA< 30)){
	    pixel_new += (pixel203)*(float)1.0; accumWeights += 1;
    }
    float pixel204_diffR = fabs(pixel204.x- (float)pixel_orig.x);
    float pixel204_diffG = fabs(pixel204.y- (float)pixel_orig.y);
    float pixel204_diffB = fabs(pixel204.z- (float)pixel_orig.z);
    float pixel204_diffA = fabs(pixel204.w- (float)pixel_orig.w);
   if ((pixel204_diffR<30)&& (pixel204_diffG< 30)&&(pixel204_diffB< 30 )&&(pixel204_diffA< 30)){
	    pixel_new += (pixel204)*(float)1.0; accumWeights += 1;
    }
    float pixel205_diffR = fabs(pixel205.x- (float)pixel_orig.x);
    float pixel205_diffG = fabs(pixel205.y- (float)pixel_orig.y);
    float pixel205_diffB = fabs(pixel205.z- (float)pixel_orig.z);
    float pixel205_diffA = fabs(pixel205.w- (float)pixel_orig.w);
   if ((pixel205_diffR<30)&& (pixel205_diffG< 30)&&(pixel205_diffB< 30 )&&(pixel205_diffA< 30)){
	    pixel_new += (pixel205)*(float)1.0; accumWeights += 1;
    }
    float pixel206_diffR = fabs(pixel206.x- (float)pixel_orig.x);
    float pixel206_diffG = fabs(pixel206.y- (float)pixel_orig.y);
    float pixel206_diffB = fabs(pixel206.z- (float)pixel_orig.z);
    float pixel206_diffA = fabs(pixel206.w- (float)pixel_orig.w);
   if ((pixel206_diffR<30)&& (pixel206_diffG< 30)&&(pixel206_diffB< 30 )&&(pixel206_diffA< 30)){
	    pixel_new += (pixel206)*(float)1.0; accumWeights += 1;
    }
    float pixel207_diffR = fabs(pixel207.x- (float)pixel_orig.x);
    float pixel207_diffG = fabs(pixel207.y- (float)pixel_orig.y);
    float pixel207_diffB = fabs(pixel207.z- (float)pixel_orig.z);
    float pixel207_diffA = fabs(pixel207.w- (float)pixel_orig.w);
   if ((pixel207_diffR<30)&& (pixel207_diffG< 30)&&(pixel207_diffB< 30 )&&(pixel207_diffA< 30)){
	    pixel_new += (pixel207)*(float)1.0; accumWeights += 1;
    }
    float pixel208_diffR = fabs(pixel208.x- (float)pixel_orig.x);
    float pixel208_diffG = fabs(pixel208.y- (float)pixel_orig.y);
    float pixel208_diffB = fabs(pixel208.z- (float)pixel_orig.z);
    float pixel208_diffA = fabs(pixel208.w- (float)pixel_orig.w);
   if ((pixel208_diffR<30)&& (pixel208_diffG< 30)&&(pixel208_diffB< 30 )&&(pixel208_diffA< 30)){
	    pixel_new += (pixel208)*(float)1.0; accumWeights += 1;
    }
    float pixel209_diffR = fabs(pixel209.x- (float)pixel_orig.x);
    float pixel209_diffG = fabs(pixel209.y- (float)pixel_orig.y);
    float pixel209_diffB = fabs(pixel209.z- (float)pixel_orig.z);
    float pixel209_diffA = fabs(pixel209.w- (float)pixel_orig.w);
   if ((pixel209_diffR<30)&& (pixel209_diffG< 30)&&(pixel209_diffB< 30 )&&(pixel209_diffA< 30)){
	    pixel_new += (pixel209)*(float)1.0; accumWeights += 1;
    }
    float pixel210_diffR = fabs(pixel210.x- (float)pixel_orig.x);
    float pixel210_diffG = fabs(pixel210.y- (float)pixel_orig.y);
    float pixel210_diffB = fabs(pixel210.z- (float)pixel_orig.z);
    float pixel210_diffA = fabs(pixel210.w- (float)pixel_orig.w);
   if ((pixel210_diffR<30)&& (pixel210_diffG< 30)&&(pixel210_diffB< 30 )&&(pixel210_diffA< 30)){
	    pixel_new += (pixel210)*(float)1.0; accumWeights += 1;
    }
    float pixel211_diffR = fabs(pixel211.x- (float)pixel_orig.x);
    float pixel211_diffG = fabs(pixel211.y- (float)pixel_orig.y);
    float pixel211_diffB = fabs(pixel211.z- (float)pixel_orig.z);
    float pixel211_diffA = fabs(pixel211.w- (float)pixel_orig.w);
   if ((pixel211_diffR<30)&& (pixel211_diffG< 30)&&(pixel211_diffB< 30 )&&(pixel211_diffA< 30)){
	    pixel_new += (pixel211)*(float)1.0; accumWeights += 1;
    }
    float pixel212_diffR = fabs(pixel212.x- (float)pixel_orig.x);
    float pixel212_diffG = fabs(pixel212.y- (float)pixel_orig.y);
    float pixel212_diffB = fabs(pixel212.z- (float)pixel_orig.z);
    float pixel212_diffA = fabs(pixel212.w- (float)pixel_orig.w);
   if ((pixel212_diffR<30)&& (pixel212_diffG< 30)&&(pixel212_diffB< 30 )&&(pixel212_diffA< 30)){
	    pixel_new += (pixel212)*(float)1.0; accumWeights += 1;
    }
    float pixel213_diffR = fabs(pixel213.x- (float)pixel_orig.x);
    float pixel213_diffG = fabs(pixel213.y- (float)pixel_orig.y);
    float pixel213_diffB = fabs(pixel213.z- (float)pixel_orig.z);
    float pixel213_diffA = fabs(pixel213.w- (float)pixel_orig.w);
   if ((pixel213_diffR<30)&& (pixel213_diffG< 30)&&(pixel213_diffB< 30 )&&(pixel213_diffA< 30)){
	    pixel_new += (pixel213)*(float)1.0; accumWeights += 1;
    }
    float pixel214_diffR = fabs(pixel214.x- (float)pixel_orig.x);
    float pixel214_diffG = fabs(pixel214.y- (float)pixel_orig.y);
    float pixel214_diffB = fabs(pixel214.z- (float)pixel_orig.z);
    float pixel214_diffA = fabs(pixel214.w- (float)pixel_orig.w);
   if ((pixel214_diffR<30)&& (pixel214_diffG< 30)&&(pixel214_diffB< 30 )&&(pixel214_diffA< 30)){
	    pixel_new += (pixel214)*(float)1.0; accumWeights += 1;
    }
    float pixel215_diffR = fabs(pixel215.x- (float)pixel_orig.x);
    float pixel215_diffG = fabs(pixel215.y- (float)pixel_orig.y);
    float pixel215_diffB = fabs(pixel215.z- (float)pixel_orig.z);
    float pixel215_diffA = fabs(pixel215.w- (float)pixel_orig.w);
   if ((pixel215_diffR<30)&& (pixel215_diffG< 30)&&(pixel215_diffB< 30 )&&(pixel215_diffA< 30)){
	    pixel_new += (pixel215)*(float)1.0; accumWeights += 1;
    }
    float pixel216_diffR = fabs(pixel216.x- (float)pixel_orig.x);
    float pixel216_diffG = fabs(pixel216.y- (float)pixel_orig.y);
    float pixel216_diffB = fabs(pixel216.z- (float)pixel_orig.z);
    float pixel216_diffA = fabs(pixel216.w- (float)pixel_orig.w);
   if ((pixel216_diffR<30)&& (pixel216_diffG< 30)&&(pixel216_diffB< 30 )&&(pixel216_diffA< 30)){
	    pixel_new += (pixel216)*(float)1.0; accumWeights += 1;
    }
    float pixel217_diffR = fabs(pixel217.x- (float)pixel_orig.x);
    float pixel217_diffG = fabs(pixel217.y- (float)pixel_orig.y);
    float pixel217_diffB = fabs(pixel217.z- (float)pixel_orig.z);
    float pixel217_diffA = fabs(pixel217.w- (float)pixel_orig.w);
   if ((pixel217_diffR<30)&& (pixel217_diffG< 30)&&(pixel217_diffB< 30 )&&(pixel217_diffA< 30)){
	    pixel_new += (pixel217)*(float)1.0; accumWeights += 1;
    }
    float pixel218_diffR = fabs(pixel218.x- (float)pixel_orig.x);
    float pixel218_diffG = fabs(pixel218.y- (float)pixel_orig.y);
    float pixel218_diffB = fabs(pixel218.z- (float)pixel_orig.z);
    float pixel218_diffA = fabs(pixel218.w- (float)pixel_orig.w);
   if ((pixel218_diffR<30)&& (pixel218_diffG< 30)&&(pixel218_diffB< 30 )&&(pixel218_diffA< 30)){
	    pixel_new += (pixel218)*(float)1.0; accumWeights += 1;
    }
    float pixel219_diffR = fabs(pixel219.x- (float)pixel_orig.x);
    float pixel219_diffG = fabs(pixel219.y- (float)pixel_orig.y);
    float pixel219_diffB = fabs(pixel219.z- (float)pixel_orig.z);
    float pixel219_diffA = fabs(pixel219.w- (float)pixel_orig.w);
   if ((pixel219_diffR<30)&& (pixel219_diffG< 30)&&(pixel219_diffB< 30 )&&(pixel219_diffA< 30)){
	    pixel_new += (pixel219)*(float)1.0; accumWeights += 1;
    }
    float pixel220_diffR = fabs(pixel220.x- (float)pixel_orig.x);
    float pixel220_diffG = fabs(pixel220.y- (float)pixel_orig.y);
    float pixel220_diffB = fabs(pixel220.z- (float)pixel_orig.z);
    float pixel220_diffA = fabs(pixel220.w- (float)pixel_orig.w);
   if ((pixel220_diffR<30)&& (pixel220_diffG< 30)&&(pixel220_diffB< 30 )&&(pixel220_diffA< 30)){
	    pixel_new += (pixel220)*(float)1.0; accumWeights += 1;
    }
    float pixel221_diffR = fabs(pixel221.x- (float)pixel_orig.x);
    float pixel221_diffG = fabs(pixel221.y- (float)pixel_orig.y);
    float pixel221_diffB = fabs(pixel221.z- (float)pixel_orig.z);
    float pixel221_diffA = fabs(pixel221.w- (float)pixel_orig.w);
   if ((pixel221_diffR<30)&& (pixel221_diffG< 30)&&(pixel221_diffB< 30 )&&(pixel221_diffA< 30)){
	    pixel_new += (pixel221)*(float)1.0; accumWeights += 1;
    }
    float pixel222_diffR = fabs(pixel222.x- (float)pixel_orig.x);
    float pixel222_diffG = fabs(pixel222.y- (float)pixel_orig.y);
    float pixel222_diffB = fabs(pixel222.z- (float)pixel_orig.z);
    float pixel222_diffA = fabs(pixel222.w- (float)pixel_orig.w);
   if ((pixel222_diffR<30)&& (pixel222_diffG< 30)&&(pixel222_diffB< 30 )&&(pixel222_diffA< 30)){
	    pixel_new += (pixel222)*(float)1.0; accumWeights += 1;
    }
    float pixel223_diffR = fabs(pixel223.x- (float)pixel_orig.x);
    float pixel223_diffG = fabs(pixel223.y- (float)pixel_orig.y);
    float pixel223_diffB = fabs(pixel223.z- (float)pixel_orig.z);
    float pixel223_diffA = fabs(pixel223.w- (float)pixel_orig.w);
   if ((pixel223_diffR<30)&& (pixel223_diffG< 30)&&(pixel223_diffB< 30 )&&(pixel223_diffA< 30)){
	    pixel_new += (pixel223)*(float)1.0; accumWeights += 1;
    }
    float pixel224_diffR = fabs(pixel224.x- (float)pixel_orig.x);
    float pixel224_diffG = fabs(pixel224.y- (float)pixel_orig.y);
    float pixel224_diffB = fabs(pixel224.z- (float)pixel_orig.z);
    float pixel224_diffA = fabs(pixel224.w- (float)pixel_orig.w);
   if ((pixel224_diffR<30)&& (pixel224_diffG< 30)&&(pixel224_diffB< 30 )&&(pixel224_diffA< 30)){
	    pixel_new += (pixel224)*(float)1.0; accumWeights += 1;
    }
    float pixel225_diffR = fabs(pixel225.x- (float)pixel_orig.x);
    float pixel225_diffG = fabs(pixel225.y- (float)pixel_orig.y);
    float pixel225_diffB = fabs(pixel225.z- (float)pixel_orig.z);
    float pixel225_diffA = fabs(pixel225.w- (float)pixel_orig.w);
   if ((pixel225_diffR<30)&& (pixel225_diffG< 30)&&(pixel225_diffB< 30 )&&(pixel225_diffA< 30)){
	    pixel_new += (pixel225)*(float)1.0; accumWeights += 1;
    }
    float pixel226_diffR = fabs(pixel226.x- (float)pixel_orig.x);
    float pixel226_diffG = fabs(pixel226.y- (float)pixel_orig.y);
    float pixel226_diffB = fabs(pixel226.z- (float)pixel_orig.z);
    float pixel226_diffA = fabs(pixel226.w- (float)pixel_orig.w);
   if ((pixel226_diffR<30)&& (pixel226_diffG< 30)&&(pixel226_diffB< 30 )&&(pixel226_diffA< 30)){
	    pixel_new += (pixel226)*(float)1.0; accumWeights += 1;
    }
    float pixel227_diffR = fabs(pixel227.x- (float)pixel_orig.x);
    float pixel227_diffG = fabs(pixel227.y- (float)pixel_orig.y);
    float pixel227_diffB = fabs(pixel227.z- (float)pixel_orig.z);
    float pixel227_diffA = fabs(pixel227.w- (float)pixel_orig.w);
   if ((pixel227_diffR<30)&& (pixel227_diffG< 30)&&(pixel227_diffB< 30 )&&(pixel227_diffA< 30)){
	    pixel_new += (pixel227)*(float)1.0; accumWeights += 1;
    }
    float pixel228_diffR = fabs(pixel228.x- (float)pixel_orig.x);
    float pixel228_diffG = fabs(pixel228.y- (float)pixel_orig.y);
    float pixel228_diffB = fabs(pixel228.z- (float)pixel_orig.z);
    float pixel228_diffA = fabs(pixel228.w- (float)pixel_orig.w);
   if ((pixel228_diffR<30)&& (pixel228_diffG< 30)&&(pixel228_diffB< 30 )&&(pixel228_diffA< 30)){
	    pixel_new += (pixel228)*(float)1.0; accumWeights += 1;
    }
    float pixel229_diffR = fabs(pixel229.x- (float)pixel_orig.x);
    float pixel229_diffG = fabs(pixel229.y- (float)pixel_orig.y);
    float pixel229_diffB = fabs(pixel229.z- (float)pixel_orig.z);
    float pixel229_diffA = fabs(pixel229.w- (float)pixel_orig.w);
   if ((pixel229_diffR<30)&& (pixel229_diffG< 30)&&(pixel229_diffB< 30 )&&(pixel229_diffA< 30)){
	    pixel_new += (pixel229)*(float)1.0; accumWeights += 1;
    }
    float pixel230_diffR = fabs(pixel230.x- (float)pixel_orig.x);
    float pixel230_diffG = fabs(pixel230.y- (float)pixel_orig.y);
    float pixel230_diffB = fabs(pixel230.z- (float)pixel_orig.z);
    float pixel230_diffA = fabs(pixel230.w- (float)pixel_orig.w);
   if ((pixel230_diffR<30)&& (pixel230_diffG< 30)&&(pixel230_diffB< 30 )&&(pixel230_diffA< 30)){
	    pixel_new += (pixel230)*(float)1.0; accumWeights += 1;
    }
    float pixel231_diffR = fabs(pixel231.x- (float)pixel_orig.x);
    float pixel231_diffG = fabs(pixel231.y- (float)pixel_orig.y);
    float pixel231_diffB = fabs(pixel231.z- (float)pixel_orig.z);
    float pixel231_diffA = fabs(pixel231.w- (float)pixel_orig.w);
   if ((pixel231_diffR<30)&& (pixel231_diffG< 30)&&(pixel231_diffB< 30 )&&(pixel231_diffA< 30)){
	    pixel_new += (pixel231)*(float)1.0; accumWeights += 1;
    }
    float pixel232_diffR = fabs(pixel232.x- (float)pixel_orig.x);
    float pixel232_diffG = fabs(pixel232.y- (float)pixel_orig.y);
    float pixel232_diffB = fabs(pixel232.z- (float)pixel_orig.z);
    float pixel232_diffA = fabs(pixel232.w- (float)pixel_orig.w);
   if ((pixel232_diffR<30)&& (pixel232_diffG< 30)&&(pixel232_diffB< 30 )&&(pixel232_diffA< 30)){
	    pixel_new += (pixel232)*(float)1.0; accumWeights += 1;
    }
    float pixel233_diffR = fabs(pixel233.x- (float)pixel_orig.x);
    float pixel233_diffG = fabs(pixel233.y- (float)pixel_orig.y);
    float pixel233_diffB = fabs(pixel233.z- (float)pixel_orig.z);
    float pixel233_diffA = fabs(pixel233.w- (float)pixel_orig.w);
   if ((pixel233_diffR<30)&& (pixel233_diffG< 30)&&(pixel233_diffB< 30 )&&(pixel233_diffA< 30)){
	    pixel_new += (pixel233)*(float)1.0; accumWeights += 1;
    }
    float pixel234_diffR = fabs(pixel234.x- (float)pixel_orig.x);
    float pixel234_diffG = fabs(pixel234.y- (float)pixel_orig.y);
    float pixel234_diffB = fabs(pixel234.z- (float)pixel_orig.z);
    float pixel234_diffA = fabs(pixel234.w- (float)pixel_orig.w);
   if ((pixel234_diffR<30)&& (pixel234_diffG< 30)&&(pixel234_diffB< 30 )&&(pixel234_diffA< 30)){
	    pixel_new += (pixel234)*(float)1.0; accumWeights += 1;
    }
    float pixel235_diffR = fabs(pixel235.x- (float)pixel_orig.x);
    float pixel235_diffG = fabs(pixel235.y- (float)pixel_orig.y);
    float pixel235_diffB = fabs(pixel235.z- (float)pixel_orig.z);
    float pixel235_diffA = fabs(pixel235.w- (float)pixel_orig.w);
   if ((pixel235_diffR<30)&& (pixel235_diffG< 30)&&(pixel235_diffB< 30 )&&(pixel235_diffA< 30)){
	    pixel_new += (pixel235)*(float)1.0; accumWeights += 1;
    }
    float pixel236_diffR = fabs(pixel236.x- (float)pixel_orig.x);
    float pixel236_diffG = fabs(pixel236.y- (float)pixel_orig.y);
    float pixel236_diffB = fabs(pixel236.z- (float)pixel_orig.z);
    float pixel236_diffA = fabs(pixel236.w- (float)pixel_orig.w);
   if ((pixel236_diffR<30)&& (pixel236_diffG< 30)&&(pixel236_diffB< 30 )&&(pixel236_diffA< 30)){
	    pixel_new += (pixel236)*(float)1.0; accumWeights += 1;
    }
    float pixel237_diffR = fabs(pixel237.x- (float)pixel_orig.x);
    float pixel237_diffG = fabs(pixel237.y- (float)pixel_orig.y);
    float pixel237_diffB = fabs(pixel237.z- (float)pixel_orig.z);
    float pixel237_diffA = fabs(pixel237.w- (float)pixel_orig.w);
   if ((pixel237_diffR<30)&& (pixel237_diffG< 30)&&(pixel237_diffB< 30 )&&(pixel237_diffA< 30)){
	    pixel_new += (pixel237)*(float)1.0; accumWeights += 1;
    }
    float pixel238_diffR = fabs(pixel238.x- (float)pixel_orig.x);
    float pixel238_diffG = fabs(pixel238.y- (float)pixel_orig.y);
    float pixel238_diffB = fabs(pixel238.z- (float)pixel_orig.z);
    float pixel238_diffA = fabs(pixel238.w- (float)pixel_orig.w);
   if ((pixel238_diffR<30)&& (pixel238_diffG< 30)&&(pixel238_diffB< 30 )&&(pixel238_diffA< 30)){
	    pixel_new += (pixel238)*(float)1.0; accumWeights += 1;
    }
    float pixel239_diffR = fabs(pixel239.x- (float)pixel_orig.x);
    float pixel239_diffG = fabs(pixel239.y- (float)pixel_orig.y);
    float pixel239_diffB = fabs(pixel239.z- (float)pixel_orig.z);
    float pixel239_diffA = fabs(pixel239.w- (float)pixel_orig.w);
   if ((pixel239_diffR<30)&& (pixel239_diffG< 30)&&(pixel239_diffB< 30 )&&(pixel239_diffA< 30)){
	    pixel_new += (pixel239)*(float)1.0; accumWeights += 1;
    }
    float pixel240_diffR = fabs(pixel240.x- (float)pixel_orig.x);
    float pixel240_diffG = fabs(pixel240.y- (float)pixel_orig.y);
    float pixel240_diffB = fabs(pixel240.z- (float)pixel_orig.z);
    float pixel240_diffA = fabs(pixel240.w- (float)pixel_orig.w);
   if ((pixel240_diffR<30)&& (pixel240_diffG< 30)&&(pixel240_diffB< 30 )&&(pixel240_diffA< 30)){
	    pixel_new += (pixel240)*(float)1.0; accumWeights += 1;
    }
    float pixel241_diffR = fabs(pixel241.x- (float)pixel_orig.x);
    float pixel241_diffG = fabs(pixel241.y- (float)pixel_orig.y);
    float pixel241_diffB = fabs(pixel241.z- (float)pixel_orig.z);
    float pixel241_diffA = fabs(pixel241.w- (float)pixel_orig.w);
   if ((pixel241_diffR<30)&& (pixel241_diffG< 30)&&(pixel241_diffB< 30 )&&(pixel241_diffA< 30)){
	    pixel_new += (pixel241)*(float)1.0; accumWeights += 1;
    }
    float pixel242_diffR = fabs(pixel242.x- (float)pixel_orig.x);
    float pixel242_diffG = fabs(pixel242.y- (float)pixel_orig.y);
    float pixel242_diffB = fabs(pixel242.z- (float)pixel_orig.z);
    float pixel242_diffA = fabs(pixel242.w- (float)pixel_orig.w);
   if ((pixel242_diffR<30)&& (pixel242_diffG< 30)&&(pixel242_diffB< 30 )&&(pixel242_diffA< 30)){
	    pixel_new += (pixel242)*(float)1.0; accumWeights += 1;
    }
    float pixel243_diffR = fabs(pixel243.x- (float)pixel_orig.x);
    float pixel243_diffG = fabs(pixel243.y- (float)pixel_orig.y);
    float pixel243_diffB = fabs(pixel243.z- (float)pixel_orig.z);
    float pixel243_diffA = fabs(pixel243.w- (float)pixel_orig.w);
   if ((pixel243_diffR<30)&& (pixel243_diffG< 30)&&(pixel243_diffB< 30 )&&(pixel243_diffA< 30)){
	    pixel_new += (pixel243)*(float)1.0; accumWeights += 1;
    }
    float pixel244_diffR = fabs(pixel244.x- (float)pixel_orig.x);
    float pixel244_diffG = fabs(pixel244.y- (float)pixel_orig.y);
    float pixel244_diffB = fabs(pixel244.z- (float)pixel_orig.z);
    float pixel244_diffA = fabs(pixel244.w- (float)pixel_orig.w);
   if ((pixel244_diffR<30)&& (pixel244_diffG< 30)&&(pixel244_diffB< 30 )&&(pixel244_diffA< 30)){
	    pixel_new += (pixel244)*(float)1.0; accumWeights += 1;
    }
    float pixel245_diffR = fabs(pixel245.x- (float)pixel_orig.x);
    float pixel245_diffG = fabs(pixel245.y- (float)pixel_orig.y);
    float pixel245_diffB = fabs(pixel245.z- (float)pixel_orig.z);
    float pixel245_diffA = fabs(pixel245.w- (float)pixel_orig.w);
   if ((pixel245_diffR<30)&& (pixel245_diffG< 30)&&(pixel245_diffB< 30 )&&(pixel245_diffA< 30)){
	    pixel_new += (pixel245)*(float)1.0; accumWeights += 1;
    }
    float pixel246_diffR = fabs(pixel246.x- (float)pixel_orig.x);
    float pixel246_diffG = fabs(pixel246.y- (float)pixel_orig.y);
    float pixel246_diffB = fabs(pixel246.z- (float)pixel_orig.z);
    float pixel246_diffA = fabs(pixel246.w- (float)pixel_orig.w);
   if ((pixel246_diffR<30)&& (pixel246_diffG< 30)&&(pixel246_diffB< 30 )&&(pixel246_diffA< 30)){
	    pixel_new += (pixel246)*(float)1.0; accumWeights += 1;
    }
    float pixel247_diffR = fabs(pixel247.x- (float)pixel_orig.x);
    float pixel247_diffG = fabs(pixel247.y- (float)pixel_orig.y);
    float pixel247_diffB = fabs(pixel247.z- (float)pixel_orig.z);
    float pixel247_diffA = fabs(pixel247.w- (float)pixel_orig.w);
   if ((pixel247_diffR<30)&& (pixel247_diffG< 30)&&(pixel247_diffB< 30 )&&(pixel247_diffA< 30)){
	    pixel_new += (pixel247)*(float)1.0; accumWeights += 1;
    }
    float pixel248_diffR = fabs(pixel248.x- (float)pixel_orig.x);
    float pixel248_diffG = fabs(pixel248.y- (float)pixel_orig.y);
    float pixel248_diffB = fabs(pixel248.z- (float)pixel_orig.z);
    float pixel248_diffA = fabs(pixel248.w- (float)pixel_orig.w);
   if ((pixel248_diffR<30)&& (pixel248_diffG< 30)&&(pixel248_diffB< 30 )&&(pixel248_diffA< 30)){
	    pixel_new += (pixel248)*(float)1.0; accumWeights += 1;
    }
    float pixel249_diffR = fabs(pixel249.x- (float)pixel_orig.x);
    float pixel249_diffG = fabs(pixel249.y- (float)pixel_orig.y);
    float pixel249_diffB = fabs(pixel249.z- (float)pixel_orig.z);
    float pixel249_diffA = fabs(pixel249.w- (float)pixel_orig.w);
   if ((pixel249_diffR<30)&& (pixel249_diffG< 30)&&(pixel249_diffB< 30 )&&(pixel249_diffA< 30)){
	    pixel_new += (pixel249)*(float)1.0; accumWeights += 1;
    }
    float pixel250_diffR = fabs(pixel250.x- (float)pixel_orig.x);
    float pixel250_diffG = fabs(pixel250.y- (float)pixel_orig.y);
    float pixel250_diffB = fabs(pixel250.z- (float)pixel_orig.z);
    float pixel250_diffA = fabs(pixel250.w- (float)pixel_orig.w);
   if ((pixel250_diffR<30)&& (pixel250_diffG< 30)&&(pixel250_diffB< 30 )&&(pixel250_diffA< 30)){
	    pixel_new += (pixel250)*(float)1.0; accumWeights += 1;
    }
    float pixel251_diffR = fabs(pixel251.x- (float)pixel_orig.x);
    float pixel251_diffG = fabs(pixel251.y- (float)pixel_orig.y);
    float pixel251_diffB = fabs(pixel251.z- (float)pixel_orig.z);
    float pixel251_diffA = fabs(pixel251.w- (float)pixel_orig.w);
   if ((pixel251_diffR<30)&& (pixel251_diffG< 30)&&(pixel251_diffB< 30 )&&(pixel251_diffA< 30)){
	    pixel_new += (pixel251)*(float)1.0; accumWeights += 1;
    }
    float pixel252_diffR = fabs(pixel252.x- (float)pixel_orig.x);
    float pixel252_diffG = fabs(pixel252.y- (float)pixel_orig.y);
    float pixel252_diffB = fabs(pixel252.z- (float)pixel_orig.z);
    float pixel252_diffA = fabs(pixel252.w- (float)pixel_orig.w);
   if ((pixel252_diffR<30)&& (pixel252_diffG< 30)&&(pixel252_diffB< 30 )&&(pixel252_diffA< 30)){
	    pixel_new += (pixel252)*(float)1.0; accumWeights += 1;
    }
    float pixel253_diffR = fabs(pixel253.x- (float)pixel_orig.x);
    float pixel253_diffG = fabs(pixel253.y- (float)pixel_orig.y);
    float pixel253_diffB = fabs(pixel253.z- (float)pixel_orig.z);
    float pixel253_diffA = fabs(pixel253.w- (float)pixel_orig.w);
   if ((pixel253_diffR<30)&& (pixel253_diffG< 30)&&(pixel253_diffB< 30 )&&(pixel253_diffA< 30)){
	    pixel_new += (pixel253)*(float)1.0; accumWeights += 1;
    }
    float pixel254_diffR = fabs(pixel254.x- (float)pixel_orig.x);
    float pixel254_diffG = fabs(pixel254.y- (float)pixel_orig.y);
    float pixel254_diffB = fabs(pixel254.z- (float)pixel_orig.z);
    float pixel254_diffA = fabs(pixel254.w- (float)pixel_orig.w);
   if ((pixel254_diffR<30)&& (pixel254_diffG< 30)&&(pixel254_diffB< 30 )&&(pixel254_diffA< 30)){
	    pixel_new += (pixel254)*(float)1.0; accumWeights += 1;
    }
    float pixel255_diffR = fabs(pixel255.x- (float)pixel_orig.x);
    float pixel255_diffG = fabs(pixel255.y- (float)pixel_orig.y);
    float pixel255_diffB = fabs(pixel255.z- (float)pixel_orig.z);
    float pixel255_diffA = fabs(pixel255.w- (float)pixel_orig.w);
   if ((pixel255_diffR<30)&& (pixel255_diffG< 30)&&(pixel255_diffB< 30 )&&(pixel255_diffA< 30)){
	    pixel_new += (pixel255)*(float)1.0; accumWeights += 1;
    }
    float pixel256_diffR = fabs(pixel256.x- (float)pixel_orig.x);
    float pixel256_diffG = fabs(pixel256.y- (float)pixel_orig.y);
    float pixel256_diffB = fabs(pixel256.z- (float)pixel_orig.z);
    float pixel256_diffA = fabs(pixel256.w- (float)pixel_orig.w);
   if ((pixel256_diffR<30)&& (pixel256_diffG< 30)&&(pixel256_diffB< 30 )&&(pixel256_diffA< 30)){
	    pixel_new += (pixel256)*(float)1.0; accumWeights += 1;
    }
    float pixel257_diffR = fabs(pixel257.x- (float)pixel_orig.x);
    float pixel257_diffG = fabs(pixel257.y- (float)pixel_orig.y);
    float pixel257_diffB = fabs(pixel257.z- (float)pixel_orig.z);
    float pixel257_diffA = fabs(pixel257.w- (float)pixel_orig.w);
   if ((pixel257_diffR<30)&& (pixel257_diffG< 30)&&(pixel257_diffB< 30 )&&(pixel257_diffA< 30)){
	    pixel_new += (pixel257)*(float)1.0; accumWeights += 1;
    }
    float pixel258_diffR = fabs(pixel258.x- (float)pixel_orig.x);
    float pixel258_diffG = fabs(pixel258.y- (float)pixel_orig.y);
    float pixel258_diffB = fabs(pixel258.z- (float)pixel_orig.z);
    float pixel258_diffA = fabs(pixel258.w- (float)pixel_orig.w);
   if ((pixel258_diffR<30)&& (pixel258_diffG< 30)&&(pixel258_diffB< 30 )&&(pixel258_diffA< 30)){
	    pixel_new += (pixel258)*(float)1.0; accumWeights += 1;
    }
    float pixel259_diffR = fabs(pixel259.x- (float)pixel_orig.x);
    float pixel259_diffG = fabs(pixel259.y- (float)pixel_orig.y);
    float pixel259_diffB = fabs(pixel259.z- (float)pixel_orig.z);
    float pixel259_diffA = fabs(pixel259.w- (float)pixel_orig.w);
   if ((pixel259_diffR<30)&& (pixel259_diffG< 30)&&(pixel259_diffB< 30 )&&(pixel259_diffA< 30)){
	    pixel_new += (pixel259)*(float)1.0; accumWeights += 1;
    }
    float pixel260_diffR = fabs(pixel260.x- (float)pixel_orig.x);
    float pixel260_diffG = fabs(pixel260.y- (float)pixel_orig.y);
    float pixel260_diffB = fabs(pixel260.z- (float)pixel_orig.z);
    float pixel260_diffA = fabs(pixel260.w- (float)pixel_orig.w);
   if ((pixel260_diffR<30)&& (pixel260_diffG< 30)&&(pixel260_diffB< 30 )&&(pixel260_diffA< 30)){
	    pixel_new += (pixel260)*(float)1.0; accumWeights += 1;
    }
    float pixel261_diffR = fabs(pixel261.x- (float)pixel_orig.x);
    float pixel261_diffG = fabs(pixel261.y- (float)pixel_orig.y);
    float pixel261_diffB = fabs(pixel261.z- (float)pixel_orig.z);
    float pixel261_diffA = fabs(pixel261.w- (float)pixel_orig.w);
   if ((pixel261_diffR<30)&& (pixel261_diffG< 30)&&(pixel261_diffB< 30 )&&(pixel261_diffA< 30)){
	    pixel_new += (pixel261)*(float)1.0; accumWeights += 1;
    }
    float pixel262_diffR = fabs(pixel262.x- (float)pixel_orig.x);
    float pixel262_diffG = fabs(pixel262.y- (float)pixel_orig.y);
    float pixel262_diffB = fabs(pixel262.z- (float)pixel_orig.z);
    float pixel262_diffA = fabs(pixel262.w- (float)pixel_orig.w);
   if ((pixel262_diffR<30)&& (pixel262_diffG< 30)&&(pixel262_diffB< 30 )&&(pixel262_diffA< 30)){
	    pixel_new += (pixel262)*(float)1.0; accumWeights += 1;
    }
    float pixel263_diffR = fabs(pixel263.x- (float)pixel_orig.x);
    float pixel263_diffG = fabs(pixel263.y- (float)pixel_orig.y);
    float pixel263_diffB = fabs(pixel263.z- (float)pixel_orig.z);
    float pixel263_diffA = fabs(pixel263.w- (float)pixel_orig.w);
   if ((pixel263_diffR<30)&& (pixel263_diffG< 30)&&(pixel263_diffB< 30 )&&(pixel263_diffA< 30)){
	    pixel_new += (pixel263)*(float)1.0; accumWeights += 1;
    }
    float pixel264_diffR = fabs(pixel264.x- (float)pixel_orig.x);
    float pixel264_diffG = fabs(pixel264.y- (float)pixel_orig.y);
    float pixel264_diffB = fabs(pixel264.z- (float)pixel_orig.z);
    float pixel264_diffA = fabs(pixel264.w- (float)pixel_orig.w);
   if ((pixel264_diffR<30)&& (pixel264_diffG< 30)&&(pixel264_diffB< 30 )&&(pixel264_diffA< 30)){
	    pixel_new += (pixel264)*(float)1.0; accumWeights += 1;
    }
    float pixel265_diffR = fabs(pixel265.x- (float)pixel_orig.x);
    float pixel265_diffG = fabs(pixel265.y- (float)pixel_orig.y);
    float pixel265_diffB = fabs(pixel265.z- (float)pixel_orig.z);
    float pixel265_diffA = fabs(pixel265.w- (float)pixel_orig.w);
   if ((pixel265_diffR<30)&& (pixel265_diffG< 30)&&(pixel265_diffB< 30 )&&(pixel265_diffA< 30)){
	    pixel_new += (pixel265)*(float)1.0; accumWeights += 1;
    }
    float pixel266_diffR = fabs(pixel266.x- (float)pixel_orig.x);
    float pixel266_diffG = fabs(pixel266.y- (float)pixel_orig.y);
    float pixel266_diffB = fabs(pixel266.z- (float)pixel_orig.z);
    float pixel266_diffA = fabs(pixel266.w- (float)pixel_orig.w);
   if ((pixel266_diffR<30)&& (pixel266_diffG< 30)&&(pixel266_diffB< 30 )&&(pixel266_diffA< 30)){
	    pixel_new += (pixel266)*(float)1.0; accumWeights += 1;
    }
    float pixel267_diffR = fabs(pixel267.x- (float)pixel_orig.x);
    float pixel267_diffG = fabs(pixel267.y- (float)pixel_orig.y);
    float pixel267_diffB = fabs(pixel267.z- (float)pixel_orig.z);
    float pixel267_diffA = fabs(pixel267.w- (float)pixel_orig.w);
   if ((pixel267_diffR<30)&& (pixel267_diffG< 30)&&(pixel267_diffB< 30 )&&(pixel267_diffA< 30)){
	    pixel_new += (pixel267)*(float)1.0; accumWeights += 1;
    }
    float pixel268_diffR = fabs(pixel268.x- (float)pixel_orig.x);
    float pixel268_diffG = fabs(pixel268.y- (float)pixel_orig.y);
    float pixel268_diffB = fabs(pixel268.z- (float)pixel_orig.z);
    float pixel268_diffA = fabs(pixel268.w- (float)pixel_orig.w);
   if ((pixel268_diffR<30)&& (pixel268_diffG< 30)&&(pixel268_diffB< 30 )&&(pixel268_diffA< 30)){
	    pixel_new += (pixel268)*(float)1.0; accumWeights += 1;
    }
    float pixel269_diffR = fabs(pixel269.x- (float)pixel_orig.x);
    float pixel269_diffG = fabs(pixel269.y- (float)pixel_orig.y);
    float pixel269_diffB = fabs(pixel269.z- (float)pixel_orig.z);
    float pixel269_diffA = fabs(pixel269.w- (float)pixel_orig.w);
   if ((pixel269_diffR<30)&& (pixel269_diffG< 30)&&(pixel269_diffB< 30 )&&(pixel269_diffA< 30)){
	    pixel_new += (pixel269)*(float)1.0; accumWeights += 1;
    }
    float pixel270_diffR = fabs(pixel270.x- (float)pixel_orig.x);
    float pixel270_diffG = fabs(pixel270.y- (float)pixel_orig.y);
    float pixel270_diffB = fabs(pixel270.z- (float)pixel_orig.z);
    float pixel270_diffA = fabs(pixel270.w- (float)pixel_orig.w);
   if ((pixel270_diffR<30)&& (pixel270_diffG< 30)&&(pixel270_diffB< 30 )&&(pixel270_diffA< 30)){
	    pixel_new += (pixel270)*(float)1.0; accumWeights += 1;
    }
    float pixel271_diffR = fabs(pixel271.x- (float)pixel_orig.x);
    float pixel271_diffG = fabs(pixel271.y- (float)pixel_orig.y);
    float pixel271_diffB = fabs(pixel271.z- (float)pixel_orig.z);
    float pixel271_diffA = fabs(pixel271.w- (float)pixel_orig.w);
   if ((pixel271_diffR<30)&& (pixel271_diffG< 30)&&(pixel271_diffB< 30 )&&(pixel271_diffA< 30)){
	    pixel_new += (pixel271)*(float)1.0; accumWeights += 1;
    }
    float pixel272_diffR = fabs(pixel272.x- (float)pixel_orig.x);
    float pixel272_diffG = fabs(pixel272.y- (float)pixel_orig.y);
    float pixel272_diffB = fabs(pixel272.z- (float)pixel_orig.z);
    float pixel272_diffA = fabs(pixel272.w- (float)pixel_orig.w);
   if ((pixel272_diffR<30)&& (pixel272_diffG< 30)&&(pixel272_diffB< 30 )&&(pixel272_diffA< 30)){
	    pixel_new += (pixel272)*(float)1.0; accumWeights += 1;
    }
    float pixel273_diffR = fabs(pixel273.x- (float)pixel_orig.x);
    float pixel273_diffG = fabs(pixel273.y- (float)pixel_orig.y);
    float pixel273_diffB = fabs(pixel273.z- (float)pixel_orig.z);
    float pixel273_diffA = fabs(pixel273.w- (float)pixel_orig.w);
   if ((pixel273_diffR<30)&& (pixel273_diffG< 30)&&(pixel273_diffB< 30 )&&(pixel273_diffA< 30)){
	    pixel_new += (pixel273)*(float)1.0; accumWeights += 1;
    }
    float pixel274_diffR = fabs(pixel274.x- (float)pixel_orig.x);
    float pixel274_diffG = fabs(pixel274.y- (float)pixel_orig.y);
    float pixel274_diffB = fabs(pixel274.z- (float)pixel_orig.z);
    float pixel274_diffA = fabs(pixel274.w- (float)pixel_orig.w);
   if ((pixel274_diffR<30)&& (pixel274_diffG< 30)&&(pixel274_diffB< 30 )&&(pixel274_diffA< 30)){
	    pixel_new += (pixel274)*(float)1.0; accumWeights += 1;
    }
    float pixel275_diffR = fabs(pixel275.x- (float)pixel_orig.x);
    float pixel275_diffG = fabs(pixel275.y- (float)pixel_orig.y);
    float pixel275_diffB = fabs(pixel275.z- (float)pixel_orig.z);
    float pixel275_diffA = fabs(pixel275.w- (float)pixel_orig.w);
   if ((pixel275_diffR<30)&& (pixel275_diffG< 30)&&(pixel275_diffB< 30 )&&(pixel275_diffA< 30)){
	    pixel_new += (pixel275)*(float)1.0; accumWeights += 1;
    }
    float pixel276_diffR = fabs(pixel276.x- (float)pixel_orig.x);
    float pixel276_diffG = fabs(pixel276.y- (float)pixel_orig.y);
    float pixel276_diffB = fabs(pixel276.z- (float)pixel_orig.z);
    float pixel276_diffA = fabs(pixel276.w- (float)pixel_orig.w);
   if ((pixel276_diffR<30)&& (pixel276_diffG< 30)&&(pixel276_diffB< 30 )&&(pixel276_diffA< 30)){
	    pixel_new += (pixel276)*(float)1.0; accumWeights += 1;
    }
    float pixel277_diffR = fabs(pixel277.x- (float)pixel_orig.x);
    float pixel277_diffG = fabs(pixel277.y- (float)pixel_orig.y);
    float pixel277_diffB = fabs(pixel277.z- (float)pixel_orig.z);
    float pixel277_diffA = fabs(pixel277.w- (float)pixel_orig.w);
   if ((pixel277_diffR<30)&& (pixel277_diffG< 30)&&(pixel277_diffB< 30 )&&(pixel277_diffA< 30)){
	    pixel_new += (pixel277)*(float)1.0; accumWeights += 1;
    }
    float pixel278_diffR = fabs(pixel278.x- (float)pixel_orig.x);
    float pixel278_diffG = fabs(pixel278.y- (float)pixel_orig.y);
    float pixel278_diffB = fabs(pixel278.z- (float)pixel_orig.z);
    float pixel278_diffA = fabs(pixel278.w- (float)pixel_orig.w);
   if ((pixel278_diffR<30)&& (pixel278_diffG< 30)&&(pixel278_diffB< 30 )&&(pixel278_diffA< 30)){
	    pixel_new += (pixel278)*(float)1.0; accumWeights += 1;
    }
    float pixel279_diffR = fabs(pixel279.x- (float)pixel_orig.x);
    float pixel279_diffG = fabs(pixel279.y- (float)pixel_orig.y);
    float pixel279_diffB = fabs(pixel279.z- (float)pixel_orig.z);
    float pixel279_diffA = fabs(pixel279.w- (float)pixel_orig.w);
   if ((pixel279_diffR<30)&& (pixel279_diffG< 30)&&(pixel279_diffB< 30 )&&(pixel279_diffA< 30)){
	    pixel_new += (pixel279)*(float)1.0; accumWeights += 1;
    }
    float pixel280_diffR = fabs(pixel280.x- (float)pixel_orig.x);
    float pixel280_diffG = fabs(pixel280.y- (float)pixel_orig.y);
    float pixel280_diffB = fabs(pixel280.z- (float)pixel_orig.z);
    float pixel280_diffA = fabs(pixel280.w- (float)pixel_orig.w);
   if ((pixel280_diffR<30)&& (pixel280_diffG< 30)&&(pixel280_diffB< 30 )&&(pixel280_diffA< 30)){
	    pixel_new += (pixel280)*(float)1.0; accumWeights += 1;
    }
    float pixel281_diffR = fabs(pixel281.x- (float)pixel_orig.x);
    float pixel281_diffG = fabs(pixel281.y- (float)pixel_orig.y);
    float pixel281_diffB = fabs(pixel281.z- (float)pixel_orig.z);
    float pixel281_diffA = fabs(pixel281.w- (float)pixel_orig.w);
   if ((pixel281_diffR<30)&& (pixel281_diffG< 30)&&(pixel281_diffB< 30 )&&(pixel281_diffA< 30)){
	    pixel_new += (pixel281)*(float)1.0; accumWeights += 1;
    }
    float pixel282_diffR = fabs(pixel282.x- (float)pixel_orig.x);
    float pixel282_diffG = fabs(pixel282.y- (float)pixel_orig.y);
    float pixel282_diffB = fabs(pixel282.z- (float)pixel_orig.z);
    float pixel282_diffA = fabs(pixel282.w- (float)pixel_orig.w);
   if ((pixel282_diffR<30)&& (pixel282_diffG< 30)&&(pixel282_diffB< 30 )&&(pixel282_diffA< 30)){
	    pixel_new += (pixel282)*(float)1.0; accumWeights += 1;
    }
    float pixel283_diffR = fabs(pixel283.x- (float)pixel_orig.x);
    float pixel283_diffG = fabs(pixel283.y- (float)pixel_orig.y);
    float pixel283_diffB = fabs(pixel283.z- (float)pixel_orig.z);
    float pixel283_diffA = fabs(pixel283.w- (float)pixel_orig.w);
   if ((pixel283_diffR<30)&& (pixel283_diffG< 30)&&(pixel283_diffB< 30 )&&(pixel283_diffA< 30)){
	    pixel_new += (pixel283)*(float)1.0; accumWeights += 1;
    }
    float pixel284_diffR = fabs(pixel284.x- (float)pixel_orig.x);
    float pixel284_diffG = fabs(pixel284.y- (float)pixel_orig.y);
    float pixel284_diffB = fabs(pixel284.z- (float)pixel_orig.z);
    float pixel284_diffA = fabs(pixel284.w- (float)pixel_orig.w);
   if ((pixel284_diffR<30)&& (pixel284_diffG< 30)&&(pixel284_diffB< 30 )&&(pixel284_diffA< 30)){
	    pixel_new += (pixel284)*(float)1.0; accumWeights += 1;
    }
    float pixel285_diffR = fabs(pixel285.x- (float)pixel_orig.x);
    float pixel285_diffG = fabs(pixel285.y- (float)pixel_orig.y);
    float pixel285_diffB = fabs(pixel285.z- (float)pixel_orig.z);
    float pixel285_diffA = fabs(pixel285.w- (float)pixel_orig.w);
   if ((pixel285_diffR<30)&& (pixel285_diffG< 30)&&(pixel285_diffB< 30 )&&(pixel285_diffA< 30)){
	    pixel_new += (pixel285)*(float)1.0; accumWeights += 1;
    }
    float pixel286_diffR = fabs(pixel286.x- (float)pixel_orig.x);
    float pixel286_diffG = fabs(pixel286.y- (float)pixel_orig.y);
    float pixel286_diffB = fabs(pixel286.z- (float)pixel_orig.z);
    float pixel286_diffA = fabs(pixel286.w- (float)pixel_orig.w);
   if ((pixel286_diffR<30)&& (pixel286_diffG< 30)&&(pixel286_diffB< 30 )&&(pixel286_diffA< 30)){
	    pixel_new += (pixel286)*(float)1.0; accumWeights += 1;
    }
    float pixel287_diffR = fabs(pixel287.x- (float)pixel_orig.x);
    float pixel287_diffG = fabs(pixel287.y- (float)pixel_orig.y);
    float pixel287_diffB = fabs(pixel287.z- (float)pixel_orig.z);
    float pixel287_diffA = fabs(pixel287.w- (float)pixel_orig.w);
   if ((pixel287_diffR<30)&& (pixel287_diffG< 30)&&(pixel287_diffB< 30 )&&(pixel287_diffA< 30)){
	    pixel_new += (pixel287)*(float)1.0; accumWeights += 1;
    }
    float pixel288_diffR = fabs(pixel288.x- (float)pixel_orig.x);
    float pixel288_diffG = fabs(pixel288.y- (float)pixel_orig.y);
    float pixel288_diffB = fabs(pixel288.z- (float)pixel_orig.z);
    float pixel288_diffA = fabs(pixel288.w- (float)pixel_orig.w);
   if ((pixel288_diffR<30)&& (pixel288_diffG< 30)&&(pixel288_diffB< 30 )&&(pixel288_diffA< 30)){
	    pixel_new += (pixel288)*(float)1.0; accumWeights += 1;
    }
    float pixel289_diffR = fabs(pixel289.x- (float)pixel_orig.x);
    float pixel289_diffG = fabs(pixel289.y- (float)pixel_orig.y);
    float pixel289_diffB = fabs(pixel289.z- (float)pixel_orig.z);
    float pixel289_diffA = fabs(pixel289.w- (float)pixel_orig.w);
   if ((pixel289_diffR<30)&& (pixel289_diffG< 30)&&(pixel289_diffB< 30 )&&(pixel289_diffA< 30)){
	    pixel_new += (pixel289)*(float)1.0; accumWeights += 1;
    }
    float pixel290_diffR = fabs(pixel290.x- (float)pixel_orig.x);
    float pixel290_diffG = fabs(pixel290.y- (float)pixel_orig.y);
    float pixel290_diffB = fabs(pixel290.z- (float)pixel_orig.z);
    float pixel290_diffA = fabs(pixel290.w- (float)pixel_orig.w);
   if ((pixel290_diffR<30)&& (pixel290_diffG< 30)&&(pixel290_diffB< 30 )&&(pixel290_diffA< 30)){
	    pixel_new += (pixel290)*(float)1.0; accumWeights += 1;
    }
    float pixel291_diffR = fabs(pixel291.x- (float)pixel_orig.x);
    float pixel291_diffG = fabs(pixel291.y- (float)pixel_orig.y);
    float pixel291_diffB = fabs(pixel291.z- (float)pixel_orig.z);
    float pixel291_diffA = fabs(pixel291.w- (float)pixel_orig.w);
   if ((pixel291_diffR<30)&& (pixel291_diffG< 30)&&(pixel291_diffB< 30 )&&(pixel291_diffA< 30)){
	    pixel_new += (pixel291)*(float)1.0; accumWeights += 1;
    }
    float pixel292_diffR = fabs(pixel292.x- (float)pixel_orig.x);
    float pixel292_diffG = fabs(pixel292.y- (float)pixel_orig.y);
    float pixel292_diffB = fabs(pixel292.z- (float)pixel_orig.z);
    float pixel292_diffA = fabs(pixel292.w- (float)pixel_orig.w);
   if ((pixel292_diffR<30)&& (pixel292_diffG< 30)&&(pixel292_diffB< 30 )&&(pixel292_diffA< 30)){
	    pixel_new += (pixel292)*(float)1.0; accumWeights += 1;
    }
    float pixel293_diffR = fabs(pixel293.x- (float)pixel_orig.x);
    float pixel293_diffG = fabs(pixel293.y- (float)pixel_orig.y);
    float pixel293_diffB = fabs(pixel293.z- (float)pixel_orig.z);
    float pixel293_diffA = fabs(pixel293.w- (float)pixel_orig.w);
   if ((pixel293_diffR<30)&& (pixel293_diffG< 30)&&(pixel293_diffB< 30 )&&(pixel293_diffA< 30)){
	    pixel_new += (pixel293)*(float)1.0; accumWeights += 1;
    }
    float pixel294_diffR = fabs(pixel294.x- (float)pixel_orig.x);
    float pixel294_diffG = fabs(pixel294.y- (float)pixel_orig.y);
    float pixel294_diffB = fabs(pixel294.z- (float)pixel_orig.z);
    float pixel294_diffA = fabs(pixel294.w- (float)pixel_orig.w);
   if ((pixel294_diffR<30)&& (pixel294_diffG< 30)&&(pixel294_diffB< 30 )&&(pixel294_diffA< 30)){
	    pixel_new += (pixel294)*(float)1.0; accumWeights += 1;
    }
    float pixel295_diffR = fabs(pixel295.x- (float)pixel_orig.x);
    float pixel295_diffG = fabs(pixel295.y- (float)pixel_orig.y);
    float pixel295_diffB = fabs(pixel295.z- (float)pixel_orig.z);
    float pixel295_diffA = fabs(pixel295.w- (float)pixel_orig.w);
   if ((pixel295_diffR<30)&& (pixel295_diffG< 30)&&(pixel295_diffB< 30 )&&(pixel295_diffA< 30)){
	    pixel_new += (pixel295)*(float)1.0; accumWeights += 1;
    }
    float pixel296_diffR = fabs(pixel296.x- (float)pixel_orig.x);
    float pixel296_diffG = fabs(pixel296.y- (float)pixel_orig.y);
    float pixel296_diffB = fabs(pixel296.z- (float)pixel_orig.z);
    float pixel296_diffA = fabs(pixel296.w- (float)pixel_orig.w);
   if ((pixel296_diffR<30)&& (pixel296_diffG< 30)&&(pixel296_diffB< 30 )&&(pixel296_diffA< 30)){
	    pixel_new += (pixel296)*(float)1.0; accumWeights += 1;
    }
    float pixel297_diffR = fabs(pixel297.x- (float)pixel_orig.x);
    float pixel297_diffG = fabs(pixel297.y- (float)pixel_orig.y);
    float pixel297_diffB = fabs(pixel297.z- (float)pixel_orig.z);
    float pixel297_diffA = fabs(pixel297.w- (float)pixel_orig.w);
   if ((pixel297_diffR<30)&& (pixel297_diffG< 30)&&(pixel297_diffB< 30 )&&(pixel297_diffA< 30)){
	    pixel_new += (pixel297)*(float)1.0; accumWeights += 1;
    }
    float pixel298_diffR = fabs(pixel298.x- (float)pixel_orig.x);
    float pixel298_diffG = fabs(pixel298.y- (float)pixel_orig.y);
    float pixel298_diffB = fabs(pixel298.z- (float)pixel_orig.z);
    float pixel298_diffA = fabs(pixel298.w- (float)pixel_orig.w);
   if ((pixel298_diffR<30)&& (pixel298_diffG< 30)&&(pixel298_diffB< 30 )&&(pixel298_diffA< 30)){
	    pixel_new += (pixel298)*(float)1.0; accumWeights += 1;
    }
    float pixel299_diffR = fabs(pixel299.x- (float)pixel_orig.x);
    float pixel299_diffG = fabs(pixel299.y- (float)pixel_orig.y);
    float pixel299_diffB = fabs(pixel299.z- (float)pixel_orig.z);
    float pixel299_diffA = fabs(pixel299.w- (float)pixel_orig.w);
   if ((pixel299_diffR<30)&& (pixel299_diffG< 30)&&(pixel299_diffB< 30 )&&(pixel299_diffA< 30)){
	    pixel_new += (pixel299)*(float)1.0; accumWeights += 1;
    }
    float pixel300_diffR = fabs(pixel300.x- (float)pixel_orig.x);
    float pixel300_diffG = fabs(pixel300.y- (float)pixel_orig.y);
    float pixel300_diffB = fabs(pixel300.z- (float)pixel_orig.z);
    float pixel300_diffA = fabs(pixel300.w- (float)pixel_orig.w);
   if ((pixel300_diffR<30)&& (pixel300_diffG< 30)&&(pixel300_diffB< 30 )&&(pixel300_diffA< 30)){
	    pixel_new += (pixel300)*(float)1.0; accumWeights += 1;
    }
    float pixel301_diffR = fabs(pixel301.x- (float)pixel_orig.x);
    float pixel301_diffG = fabs(pixel301.y- (float)pixel_orig.y);
    float pixel301_diffB = fabs(pixel301.z- (float)pixel_orig.z);
    float pixel301_diffA = fabs(pixel301.w- (float)pixel_orig.w);
   if ((pixel301_diffR<30)&& (pixel301_diffG< 30)&&(pixel301_diffB< 30 )&&(pixel301_diffA< 30)){
	    pixel_new += (pixel301)*(float)1.0; accumWeights += 1;
    }
    float pixel302_diffR = fabs(pixel302.x- (float)pixel_orig.x);
    float pixel302_diffG = fabs(pixel302.y- (float)pixel_orig.y);
    float pixel302_diffB = fabs(pixel302.z- (float)pixel_orig.z);
    float pixel302_diffA = fabs(pixel302.w- (float)pixel_orig.w);
   if ((pixel302_diffR<30)&& (pixel302_diffG< 30)&&(pixel302_diffB< 30 )&&(pixel302_diffA< 30)){
	    pixel_new += (pixel302)*(float)1.0; accumWeights += 1;
    }
    float pixel303_diffR = fabs(pixel303.x- (float)pixel_orig.x);
    float pixel303_diffG = fabs(pixel303.y- (float)pixel_orig.y);
    float pixel303_diffB = fabs(pixel303.z- (float)pixel_orig.z);
    float pixel303_diffA = fabs(pixel303.w- (float)pixel_orig.w);
   if ((pixel303_diffR<30)&& (pixel303_diffG< 30)&&(pixel303_diffB< 30 )&&(pixel303_diffA< 30)){
	    pixel_new += (pixel303)*(float)1.0; accumWeights += 1;
    }
    float pixel304_diffR = fabs(pixel304.x- (float)pixel_orig.x);
    float pixel304_diffG = fabs(pixel304.y- (float)pixel_orig.y);
    float pixel304_diffB = fabs(pixel304.z- (float)pixel_orig.z);
    float pixel304_diffA = fabs(pixel304.w- (float)pixel_orig.w);
   if ((pixel304_diffR<30)&& (pixel304_diffG< 30)&&(pixel304_diffB< 30 )&&(pixel304_diffA< 30)){
	    pixel_new += (pixel304)*(float)1.0; accumWeights += 1;
    }
    float pixel305_diffR = fabs(pixel305.x- (float)pixel_orig.x);
    float pixel305_diffG = fabs(pixel305.y- (float)pixel_orig.y);
    float pixel305_diffB = fabs(pixel305.z- (float)pixel_orig.z);
    float pixel305_diffA = fabs(pixel305.w- (float)pixel_orig.w);
   if ((pixel305_diffR<30)&& (pixel305_diffG< 30)&&(pixel305_diffB< 30 )&&(pixel305_diffA< 30)){
	    pixel_new += (pixel305)*(float)1.0; accumWeights += 1;
    }
    float pixel306_diffR = fabs(pixel306.x- (float)pixel_orig.x);
    float pixel306_diffG = fabs(pixel306.y- (float)pixel_orig.y);
    float pixel306_diffB = fabs(pixel306.z- (float)pixel_orig.z);
    float pixel306_diffA = fabs(pixel306.w- (float)pixel_orig.w);
   if ((pixel306_diffR<30)&& (pixel306_diffG< 30)&&(pixel306_diffB< 30 )&&(pixel306_diffA< 30)){
	    pixel_new += (pixel306)*(float)1.0; accumWeights += 1;
    }
    float pixel307_diffR = fabs(pixel307.x- (float)pixel_orig.x);
    float pixel307_diffG = fabs(pixel307.y- (float)pixel_orig.y);
    float pixel307_diffB = fabs(pixel307.z- (float)pixel_orig.z);
    float pixel307_diffA = fabs(pixel307.w- (float)pixel_orig.w);
   if ((pixel307_diffR<30)&& (pixel307_diffG< 30)&&(pixel307_diffB< 30 )&&(pixel307_diffA< 30)){
	    pixel_new += (pixel307)*(float)1.0; accumWeights += 1;
    }
    float pixel308_diffR = fabs(pixel308.x- (float)pixel_orig.x);
    float pixel308_diffG = fabs(pixel308.y- (float)pixel_orig.y);
    float pixel308_diffB = fabs(pixel308.z- (float)pixel_orig.z);
    float pixel308_diffA = fabs(pixel308.w- (float)pixel_orig.w);
   if ((pixel308_diffR<30)&& (pixel308_diffG< 30)&&(pixel308_diffB< 30 )&&(pixel308_diffA< 30)){
	    pixel_new += (pixel308)*(float)1.0; accumWeights += 1;
    }
    float pixel309_diffR = fabs(pixel309.x- (float)pixel_orig.x);
    float pixel309_diffG = fabs(pixel309.y- (float)pixel_orig.y);
    float pixel309_diffB = fabs(pixel309.z- (float)pixel_orig.z);
    float pixel309_diffA = fabs(pixel309.w- (float)pixel_orig.w);
   if ((pixel309_diffR<30)&& (pixel309_diffG< 30)&&(pixel309_diffB< 30 )&&(pixel309_diffA< 30)){
	    pixel_new += (pixel309)*(float)1.0; accumWeights += 1;
    }
    float pixel310_diffR = fabs(pixel310.x- (float)pixel_orig.x);
    float pixel310_diffG = fabs(pixel310.y- (float)pixel_orig.y);
    float pixel310_diffB = fabs(pixel310.z- (float)pixel_orig.z);
    float pixel310_diffA = fabs(pixel310.w- (float)pixel_orig.w);
   if ((pixel310_diffR<30)&& (pixel310_diffG< 30)&&(pixel310_diffB< 30 )&&(pixel310_diffA< 30)){
	    pixel_new += (pixel310)*(float)1.0; accumWeights += 1;
    }
    float pixel311_diffR = fabs(pixel311.x- (float)pixel_orig.x);
    float pixel311_diffG = fabs(pixel311.y- (float)pixel_orig.y);
    float pixel311_diffB = fabs(pixel311.z- (float)pixel_orig.z);
    float pixel311_diffA = fabs(pixel311.w- (float)pixel_orig.w);
   if ((pixel311_diffR<30)&& (pixel311_diffG< 30)&&(pixel311_diffB< 30 )&&(pixel311_diffA< 30)){
	    pixel_new += (pixel311)*(float)1.0; accumWeights += 1;
    }
    float pixel312_diffR = fabs(pixel312.x- (float)pixel_orig.x);
    float pixel312_diffG = fabs(pixel312.y- (float)pixel_orig.y);
    float pixel312_diffB = fabs(pixel312.z- (float)pixel_orig.z);
    float pixel312_diffA = fabs(pixel312.w- (float)pixel_orig.w);
   if ((pixel312_diffR<30)&& (pixel312_diffG< 30)&&(pixel312_diffB< 30 )&&(pixel312_diffA< 30)){
	    pixel_new += (pixel312)*(float)1.0; accumWeights += 1;
    }
    float pixel313_diffR = fabs(pixel313.x- (float)pixel_orig.x);
    float pixel313_diffG = fabs(pixel313.y- (float)pixel_orig.y);
    float pixel313_diffB = fabs(pixel313.z- (float)pixel_orig.z);
    float pixel313_diffA = fabs(pixel313.w- (float)pixel_orig.w);
   if ((pixel313_diffR<30)&& (pixel313_diffG< 30)&&(pixel313_diffB< 30 )&&(pixel313_diffA< 30)){
	    pixel_new += (pixel313)*(float)1.0; accumWeights += 1;
    }
    float pixel314_diffR = fabs(pixel314.x- (float)pixel_orig.x);
    float pixel314_diffG = fabs(pixel314.y- (float)pixel_orig.y);
    float pixel314_diffB = fabs(pixel314.z- (float)pixel_orig.z);
    float pixel314_diffA = fabs(pixel314.w- (float)pixel_orig.w);
   if ((pixel314_diffR<30)&& (pixel314_diffG< 30)&&(pixel314_diffB< 30 )&&(pixel314_diffA< 30)){
	    pixel_new += (pixel314)*(float)1.0; accumWeights += 1;
    }
    float pixel315_diffR = fabs(pixel315.x- (float)pixel_orig.x);
    float pixel315_diffG = fabs(pixel315.y- (float)pixel_orig.y);
    float pixel315_diffB = fabs(pixel315.z- (float)pixel_orig.z);
    float pixel315_diffA = fabs(pixel315.w- (float)pixel_orig.w);
   if ((pixel315_diffR<30)&& (pixel315_diffG< 30)&&(pixel315_diffB< 30 )&&(pixel315_diffA< 30)){
	    pixel_new += (pixel315)*(float)1.0; accumWeights += 1;
    }
    float pixel316_diffR = fabs(pixel316.x- (float)pixel_orig.x);
    float pixel316_diffG = fabs(pixel316.y- (float)pixel_orig.y);
    float pixel316_diffB = fabs(pixel316.z- (float)pixel_orig.z);
    float pixel316_diffA = fabs(pixel316.w- (float)pixel_orig.w);
   if ((pixel316_diffR<30)&& (pixel316_diffG< 30)&&(pixel316_diffB< 30 )&&(pixel316_diffA< 30)){
	    pixel_new += (pixel316)*(float)1.0; accumWeights += 1;
    }
    float pixel317_diffR = fabs(pixel317.x- (float)pixel_orig.x);
    float pixel317_diffG = fabs(pixel317.y- (float)pixel_orig.y);
    float pixel317_diffB = fabs(pixel317.z- (float)pixel_orig.z);
    float pixel317_diffA = fabs(pixel317.w- (float)pixel_orig.w);
   if ((pixel317_diffR<30)&& (pixel317_diffG< 30)&&(pixel317_diffB< 30 )&&(pixel317_diffA< 30)){
	    pixel_new += (pixel317)*(float)1.0; accumWeights += 1;
    }
    float pixel318_diffR = fabs(pixel318.x- (float)pixel_orig.x);
    float pixel318_diffG = fabs(pixel318.y- (float)pixel_orig.y);
    float pixel318_diffB = fabs(pixel318.z- (float)pixel_orig.z);
    float pixel318_diffA = fabs(pixel318.w- (float)pixel_orig.w);
   if ((pixel318_diffR<30)&& (pixel318_diffG< 30)&&(pixel318_diffB< 30 )&&(pixel318_diffA< 30)){
	    pixel_new += (pixel318)*(float)1.0; accumWeights += 1;
    }
    float pixel319_diffR = fabs(pixel319.x- (float)pixel_orig.x);
    float pixel319_diffG = fabs(pixel319.y- (float)pixel_orig.y);
    float pixel319_diffB = fabs(pixel319.z- (float)pixel_orig.z);
    float pixel319_diffA = fabs(pixel319.w- (float)pixel_orig.w);
   if ((pixel319_diffR<30)&& (pixel319_diffG< 30)&&(pixel319_diffB< 30 )&&(pixel319_diffA< 30)){
	    pixel_new += (pixel319)*(float)1.0; accumWeights += 1;
    }
    float pixel320_diffR = fabs(pixel320.x- (float)pixel_orig.x);
    float pixel320_diffG = fabs(pixel320.y- (float)pixel_orig.y);
    float pixel320_diffB = fabs(pixel320.z- (float)pixel_orig.z);
    float pixel320_diffA = fabs(pixel320.w- (float)pixel_orig.w);
   if ((pixel320_diffR<30)&& (pixel320_diffG< 30)&&(pixel320_diffB< 30 )&&(pixel320_diffA< 30)){
	    pixel_new += (pixel320)*(float)1.0; accumWeights += 1;
    }
    float pixel321_diffR = fabs(pixel321.x- (float)pixel_orig.x);
    float pixel321_diffG = fabs(pixel321.y- (float)pixel_orig.y);
    float pixel321_diffB = fabs(pixel321.z- (float)pixel_orig.z);
    float pixel321_diffA = fabs(pixel321.w- (float)pixel_orig.w);
   if ((pixel321_diffR<30)&& (pixel321_diffG< 30)&&(pixel321_diffB< 30 )&&(pixel321_diffA< 30)){
	    pixel_new += (pixel321)*(float)1.0; accumWeights += 1;
    }
    float pixel322_diffR = fabs(pixel322.x- (float)pixel_orig.x);
    float pixel322_diffG = fabs(pixel322.y- (float)pixel_orig.y);
    float pixel322_diffB = fabs(pixel322.z- (float)pixel_orig.z);
    float pixel322_diffA = fabs(pixel322.w- (float)pixel_orig.w);
   if ((pixel322_diffR<30)&& (pixel322_diffG< 30)&&(pixel322_diffB< 30 )&&(pixel322_diffA< 30)){
	    pixel_new += (pixel322)*(float)1.0; accumWeights += 1;
    }
    float pixel323_diffR = fabs(pixel323.x- (float)pixel_orig.x);
    float pixel323_diffG = fabs(pixel323.y- (float)pixel_orig.y);
    float pixel323_diffB = fabs(pixel323.z- (float)pixel_orig.z);
    float pixel323_diffA = fabs(pixel323.w- (float)pixel_orig.w);
   if ((pixel323_diffR<30)&& (pixel323_diffG< 30)&&(pixel323_diffB< 30 )&&(pixel323_diffA< 30)){
	    pixel_new += (pixel323)*(float)1.0; accumWeights += 1;
    }
    float pixel324_diffR = fabs(pixel324.x- (float)pixel_orig.x);
    float pixel324_diffG = fabs(pixel324.y- (float)pixel_orig.y);
    float pixel324_diffB = fabs(pixel324.z- (float)pixel_orig.z);
    float pixel324_diffA = fabs(pixel324.w- (float)pixel_orig.w);
   if ((pixel324_diffR<30)&& (pixel324_diffG< 30)&&(pixel324_diffB< 30 )&&(pixel324_diffA< 30)){
	    pixel_new += (pixel324)*(float)1.0; accumWeights += 1;
    }
    float pixel325_diffR = fabs(pixel325.x- (float)pixel_orig.x);
    float pixel325_diffG = fabs(pixel325.y- (float)pixel_orig.y);
    float pixel325_diffB = fabs(pixel325.z- (float)pixel_orig.z);
    float pixel325_diffA = fabs(pixel325.w- (float)pixel_orig.w);
   if ((pixel325_diffR<30)&& (pixel325_diffG< 30)&&(pixel325_diffB< 30 )&&(pixel325_diffA< 30)){
	    pixel_new += (pixel325)*(float)1.0; accumWeights += 1;
    }
    float pixel326_diffR = fabs(pixel326.x- (float)pixel_orig.x);
    float pixel326_diffG = fabs(pixel326.y- (float)pixel_orig.y);
    float pixel326_diffB = fabs(pixel326.z- (float)pixel_orig.z);
    float pixel326_diffA = fabs(pixel326.w- (float)pixel_orig.w);
   if ((pixel326_diffR<30)&& (pixel326_diffG< 30)&&(pixel326_diffB< 30 )&&(pixel326_diffA< 30)){
	    pixel_new += (pixel326)*(float)1.0; accumWeights += 1;
    }
    float pixel327_diffR = fabs(pixel327.x- (float)pixel_orig.x);
    float pixel327_diffG = fabs(pixel327.y- (float)pixel_orig.y);
    float pixel327_diffB = fabs(pixel327.z- (float)pixel_orig.z);
    float pixel327_diffA = fabs(pixel327.w- (float)pixel_orig.w);
   if ((pixel327_diffR<30)&& (pixel327_diffG< 30)&&(pixel327_diffB< 30 )&&(pixel327_diffA< 30)){
	    pixel_new += (pixel327)*(float)1.0; accumWeights += 1;
    }
    float pixel328_diffR = fabs(pixel328.x- (float)pixel_orig.x);
    float pixel328_diffG = fabs(pixel328.y- (float)pixel_orig.y);
    float pixel328_diffB = fabs(pixel328.z- (float)pixel_orig.z);
    float pixel328_diffA = fabs(pixel328.w- (float)pixel_orig.w);
   if ((pixel328_diffR<30)&& (pixel328_diffG< 30)&&(pixel328_diffB< 30 )&&(pixel328_diffA< 30)){
	    pixel_new += (pixel328)*(float)1.0; accumWeights += 1;
    }
    float pixel329_diffR = fabs(pixel329.x- (float)pixel_orig.x);
    float pixel329_diffG = fabs(pixel329.y- (float)pixel_orig.y);
    float pixel329_diffB = fabs(pixel329.z- (float)pixel_orig.z);
    float pixel329_diffA = fabs(pixel329.w- (float)pixel_orig.w);
   if ((pixel329_diffR<30)&& (pixel329_diffG< 30)&&(pixel329_diffB< 30 )&&(pixel329_diffA< 30)){
	    pixel_new += (pixel329)*(float)1.0; accumWeights += 1;
    }
    float pixel330_diffR = fabs(pixel330.x- (float)pixel_orig.x);
    float pixel330_diffG = fabs(pixel330.y- (float)pixel_orig.y);
    float pixel330_diffB = fabs(pixel330.z- (float)pixel_orig.z);
    float pixel330_diffA = fabs(pixel330.w- (float)pixel_orig.w);
   if ((pixel330_diffR<30)&& (pixel330_diffG< 30)&&(pixel330_diffB< 30 )&&(pixel330_diffA< 30)){
	    pixel_new += (pixel330)*(float)1.0; accumWeights += 1;
    }
    float pixel331_diffR = fabs(pixel331.x- (float)pixel_orig.x);
    float pixel331_diffG = fabs(pixel331.y- (float)pixel_orig.y);
    float pixel331_diffB = fabs(pixel331.z- (float)pixel_orig.z);
    float pixel331_diffA = fabs(pixel331.w- (float)pixel_orig.w);
   if ((pixel331_diffR<30)&& (pixel331_diffG< 30)&&(pixel331_diffB< 30 )&&(pixel331_diffA< 30)){
	    pixel_new += (pixel331)*(float)1.0; accumWeights += 1;
    }
    float pixel332_diffR = fabs(pixel332.x- (float)pixel_orig.x);
    float pixel332_diffG = fabs(pixel332.y- (float)pixel_orig.y);
    float pixel332_diffB = fabs(pixel332.z- (float)pixel_orig.z);
    float pixel332_diffA = fabs(pixel332.w- (float)pixel_orig.w);
   if ((pixel332_diffR<30)&& (pixel332_diffG< 30)&&(pixel332_diffB< 30 )&&(pixel332_diffA< 30)){
	    pixel_new += (pixel332)*(float)1.0; accumWeights += 1;
    }
    float pixel333_diffR = fabs(pixel333.x- (float)pixel_orig.x);
    float pixel333_diffG = fabs(pixel333.y- (float)pixel_orig.y);
    float pixel333_diffB = fabs(pixel333.z- (float)pixel_orig.z);
    float pixel333_diffA = fabs(pixel333.w- (float)pixel_orig.w);
   if ((pixel333_diffR<30)&& (pixel333_diffG< 30)&&(pixel333_diffB< 30 )&&(pixel333_diffA< 30)){
	    pixel_new += (pixel333)*(float)1.0; accumWeights += 1;
    }
    float pixel334_diffR = fabs(pixel334.x- (float)pixel_orig.x);
    float pixel334_diffG = fabs(pixel334.y- (float)pixel_orig.y);
    float pixel334_diffB = fabs(pixel334.z- (float)pixel_orig.z);
    float pixel334_diffA = fabs(pixel334.w- (float)pixel_orig.w);
   if ((pixel334_diffR<30)&& (pixel334_diffG< 30)&&(pixel334_diffB< 30 )&&(pixel334_diffA< 30)){
	    pixel_new += (pixel334)*(float)1.0; accumWeights += 1;
    }
    float pixel335_diffR = fabs(pixel335.x- (float)pixel_orig.x);
    float pixel335_diffG = fabs(pixel335.y- (float)pixel_orig.y);
    float pixel335_diffB = fabs(pixel335.z- (float)pixel_orig.z);
    float pixel335_diffA = fabs(pixel335.w- (float)pixel_orig.w);
   if ((pixel335_diffR<30)&& (pixel335_diffG< 30)&&(pixel335_diffB< 30 )&&(pixel335_diffA< 30)){
	    pixel_new += (pixel335)*(float)1.0; accumWeights += 1;
    }
    float pixel336_diffR = fabs(pixel336.x- (float)pixel_orig.x);
    float pixel336_diffG = fabs(pixel336.y- (float)pixel_orig.y);
    float pixel336_diffB = fabs(pixel336.z- (float)pixel_orig.z);
    float pixel336_diffA = fabs(pixel336.w- (float)pixel_orig.w);
   if ((pixel336_diffR<30)&& (pixel336_diffG< 30)&&(pixel336_diffB< 30 )&&(pixel336_diffA< 30)){
	    pixel_new += (pixel336)*(float)1.0; accumWeights += 1;
    }
    float pixel337_diffR = fabs(pixel337.x- (float)pixel_orig.x);
    float pixel337_diffG = fabs(pixel337.y- (float)pixel_orig.y);
    float pixel337_diffB = fabs(pixel337.z- (float)pixel_orig.z);
    float pixel337_diffA = fabs(pixel337.w- (float)pixel_orig.w);
   if ((pixel337_diffR<30)&& (pixel337_diffG< 30)&&(pixel337_diffB< 30 )&&(pixel337_diffA< 30)){
	    pixel_new += (pixel337)*(float)1.0; accumWeights += 1;
    }
    float pixel338_diffR = fabs(pixel338.x- (float)pixel_orig.x);
    float pixel338_diffG = fabs(pixel338.y- (float)pixel_orig.y);
    float pixel338_diffB = fabs(pixel338.z- (float)pixel_orig.z);
    float pixel338_diffA = fabs(pixel338.w- (float)pixel_orig.w);
   if ((pixel338_diffR<30)&& (pixel338_diffG< 30)&&(pixel338_diffB< 30 )&&(pixel338_diffA< 30)){
	    pixel_new += (pixel338)*(float)1.0; accumWeights += 1;
    }
    float pixel339_diffR = fabs(pixel339.x- (float)pixel_orig.x);
    float pixel339_diffG = fabs(pixel339.y- (float)pixel_orig.y);
    float pixel339_diffB = fabs(pixel339.z- (float)pixel_orig.z);
    float pixel339_diffA = fabs(pixel339.w- (float)pixel_orig.w);
   if ((pixel339_diffR<30)&& (pixel339_diffG< 30)&&(pixel339_diffB< 30 )&&(pixel339_diffA< 30)){
	    pixel_new += (pixel339)*(float)1.0; accumWeights += 1;
    }
    float pixel340_diffR = fabs(pixel340.x- (float)pixel_orig.x);
    float pixel340_diffG = fabs(pixel340.y- (float)pixel_orig.y);
    float pixel340_diffB = fabs(pixel340.z- (float)pixel_orig.z);
    float pixel340_diffA = fabs(pixel340.w- (float)pixel_orig.w);
   if ((pixel340_diffR<30)&& (pixel340_diffG< 30)&&(pixel340_diffB< 30 )&&(pixel340_diffA< 30)){
	    pixel_new += (pixel340)*(float)1.0; accumWeights += 1;
    }
    float pixel341_diffR = fabs(pixel341.x- (float)pixel_orig.x);
    float pixel341_diffG = fabs(pixel341.y- (float)pixel_orig.y);
    float pixel341_diffB = fabs(pixel341.z- (float)pixel_orig.z);
    float pixel341_diffA = fabs(pixel341.w- (float)pixel_orig.w);
   if ((pixel341_diffR<30)&& (pixel341_diffG< 30)&&(pixel341_diffB< 30 )&&(pixel341_diffA< 30)){
	    pixel_new += (pixel341)*(float)1.0; accumWeights += 1;
    }
    float pixel342_diffR = fabs(pixel342.x- (float)pixel_orig.x);
    float pixel342_diffG = fabs(pixel342.y- (float)pixel_orig.y);
    float pixel342_diffB = fabs(pixel342.z- (float)pixel_orig.z);
    float pixel342_diffA = fabs(pixel342.w- (float)pixel_orig.w);
   if ((pixel342_diffR<30)&& (pixel342_diffG< 30)&&(pixel342_diffB< 30 )&&(pixel342_diffA< 30)){
	    pixel_new += (pixel342)*(float)1.0; accumWeights += 1;
    }
    float pixel343_diffR = fabs(pixel343.x- (float)pixel_orig.x);
    float pixel343_diffG = fabs(pixel343.y- (float)pixel_orig.y);
    float pixel343_diffB = fabs(pixel343.z- (float)pixel_orig.z);
    float pixel343_diffA = fabs(pixel343.w- (float)pixel_orig.w);
   if ((pixel343_diffR<30)&& (pixel343_diffG< 30)&&(pixel343_diffB< 30 )&&(pixel343_diffA< 30)){
	    pixel_new += (pixel343)*(float)1.0; accumWeights += 1;
    }
    float pixel344_diffR = fabs(pixel344.x- (float)pixel_orig.x);
    float pixel344_diffG = fabs(pixel344.y- (float)pixel_orig.y);
    float pixel344_diffB = fabs(pixel344.z- (float)pixel_orig.z);
    float pixel344_diffA = fabs(pixel344.w- (float)pixel_orig.w);
   if ((pixel344_diffR<30)&& (pixel344_diffG< 30)&&(pixel344_diffB< 30 )&&(pixel344_diffA< 30)){
	    pixel_new += (pixel344)*(float)1.0; accumWeights += 1;
    }
    float pixel345_diffR = fabs(pixel345.x- (float)pixel_orig.x);
    float pixel345_diffG = fabs(pixel345.y- (float)pixel_orig.y);
    float pixel345_diffB = fabs(pixel345.z- (float)pixel_orig.z);
    float pixel345_diffA = fabs(pixel345.w- (float)pixel_orig.w);
   if ((pixel345_diffR<30)&& (pixel345_diffG< 30)&&(pixel345_diffB< 30 )&&(pixel345_diffA< 30)){
	    pixel_new += (pixel345)*(float)1.0; accumWeights += 1;
    }
    float pixel346_diffR = fabs(pixel346.x- (float)pixel_orig.x);
    float pixel346_diffG = fabs(pixel346.y- (float)pixel_orig.y);
    float pixel346_diffB = fabs(pixel346.z- (float)pixel_orig.z);
    float pixel346_diffA = fabs(pixel346.w- (float)pixel_orig.w);
   if ((pixel346_diffR<30)&& (pixel346_diffG< 30)&&(pixel346_diffB< 30 )&&(pixel346_diffA< 30)){
	    pixel_new += (pixel346)*(float)1.0; accumWeights += 1;
    }
    float pixel347_diffR = fabs(pixel347.x- (float)pixel_orig.x);
    float pixel347_diffG = fabs(pixel347.y- (float)pixel_orig.y);
    float pixel347_diffB = fabs(pixel347.z- (float)pixel_orig.z);
    float pixel347_diffA = fabs(pixel347.w- (float)pixel_orig.w);
   if ((pixel347_diffR<30)&& (pixel347_diffG< 30)&&(pixel347_diffB< 30 )&&(pixel347_diffA< 30)){
	    pixel_new += (pixel347)*(float)1.0; accumWeights += 1;
    }
    float pixel348_diffR = fabs(pixel348.x- (float)pixel_orig.x);
    float pixel348_diffG = fabs(pixel348.y- (float)pixel_orig.y);
    float pixel348_diffB = fabs(pixel348.z- (float)pixel_orig.z);
    float pixel348_diffA = fabs(pixel348.w- (float)pixel_orig.w);
   if ((pixel348_diffR<30)&& (pixel348_diffG< 30)&&(pixel348_diffB< 30 )&&(pixel348_diffA< 30)){
	    pixel_new += (pixel348)*(float)1.0; accumWeights += 1;
    }
    float pixel349_diffR = fabs(pixel349.x- (float)pixel_orig.x);
    float pixel349_diffG = fabs(pixel349.y- (float)pixel_orig.y);
    float pixel349_diffB = fabs(pixel349.z- (float)pixel_orig.z);
    float pixel349_diffA = fabs(pixel349.w- (float)pixel_orig.w);
   if ((pixel349_diffR<30)&& (pixel349_diffG< 30)&&(pixel349_diffB< 30 )&&(pixel349_diffA< 30)){
	    pixel_new += (pixel349)*(float)1.0; accumWeights += 1;
    }
    float pixel350_diffR = fabs(pixel350.x- (float)pixel_orig.x);
    float pixel350_diffG = fabs(pixel350.y- (float)pixel_orig.y);
    float pixel350_diffB = fabs(pixel350.z- (float)pixel_orig.z);
    float pixel350_diffA = fabs(pixel350.w- (float)pixel_orig.w);
   if ((pixel350_diffR<30)&& (pixel350_diffG< 30)&&(pixel350_diffB< 30 )&&(pixel350_diffA< 30)){
	    pixel_new += (pixel350)*(float)1.0; accumWeights += 1;
    }
    float pixel351_diffR = fabs(pixel351.x- (float)pixel_orig.x);
    float pixel351_diffG = fabs(pixel351.y- (float)pixel_orig.y);
    float pixel351_diffB = fabs(pixel351.z- (float)pixel_orig.z);
    float pixel351_diffA = fabs(pixel351.w- (float)pixel_orig.w);
   if ((pixel351_diffR<30)&& (pixel351_diffG< 30)&&(pixel351_diffB< 30 )&&(pixel351_diffA< 30)){
	    pixel_new += (pixel351)*(float)1.0; accumWeights += 1;
    }
    float pixel352_diffR = fabs(pixel352.x- (float)pixel_orig.x);
    float pixel352_diffG = fabs(pixel352.y- (float)pixel_orig.y);
    float pixel352_diffB = fabs(pixel352.z- (float)pixel_orig.z);
    float pixel352_diffA = fabs(pixel352.w- (float)pixel_orig.w);
   if ((pixel352_diffR<30)&& (pixel352_diffG< 30)&&(pixel352_diffB< 30 )&&(pixel352_diffA< 30)){
	    pixel_new += (pixel352)*(float)1.0; accumWeights += 1;
    }
    float pixel353_diffR = fabs(pixel353.x- (float)pixel_orig.x);
    float pixel353_diffG = fabs(pixel353.y- (float)pixel_orig.y);
    float pixel353_diffB = fabs(pixel353.z- (float)pixel_orig.z);
    float pixel353_diffA = fabs(pixel353.w- (float)pixel_orig.w);
   if ((pixel353_diffR<30)&& (pixel353_diffG< 30)&&(pixel353_diffB< 30 )&&(pixel353_diffA< 30)){
	    pixel_new += (pixel353)*(float)1.0; accumWeights += 1;
    }
    float pixel354_diffR = fabs(pixel354.x- (float)pixel_orig.x);
    float pixel354_diffG = fabs(pixel354.y- (float)pixel_orig.y);
    float pixel354_diffB = fabs(pixel354.z- (float)pixel_orig.z);
    float pixel354_diffA = fabs(pixel354.w- (float)pixel_orig.w);
   if ((pixel354_diffR<30)&& (pixel354_diffG< 30)&&(pixel354_diffB< 30 )&&(pixel354_diffA< 30)){
	    pixel_new += (pixel354)*(float)1.0; accumWeights += 1;
    }
    float pixel355_diffR = fabs(pixel355.x- (float)pixel_orig.x);
    float pixel355_diffG = fabs(pixel355.y- (float)pixel_orig.y);
    float pixel355_diffB = fabs(pixel355.z- (float)pixel_orig.z);
    float pixel355_diffA = fabs(pixel355.w- (float)pixel_orig.w);
   if ((pixel355_diffR<30)&& (pixel355_diffG< 30)&&(pixel355_diffB< 30 )&&(pixel355_diffA< 30)){
	    pixel_new += (pixel355)*(float)1.0; accumWeights += 1;
    }
    float pixel356_diffR = fabs(pixel356.x- (float)pixel_orig.x);
    float pixel356_diffG = fabs(pixel356.y- (float)pixel_orig.y);
    float pixel356_diffB = fabs(pixel356.z- (float)pixel_orig.z);
    float pixel356_diffA = fabs(pixel356.w- (float)pixel_orig.w);
   if ((pixel356_diffR<30)&& (pixel356_diffG< 30)&&(pixel356_diffB< 30 )&&(pixel356_diffA< 30)){
	    pixel_new += (pixel356)*(float)1.0; accumWeights += 1;
    }
    float pixel357_diffR = fabs(pixel357.x- (float)pixel_orig.x);
    float pixel357_diffG = fabs(pixel357.y- (float)pixel_orig.y);
    float pixel357_diffB = fabs(pixel357.z- (float)pixel_orig.z);
    float pixel357_diffA = fabs(pixel357.w- (float)pixel_orig.w);
   if ((pixel357_diffR<30)&& (pixel357_diffG< 30)&&(pixel357_diffB< 30 )&&(pixel357_diffA< 30)){
	    pixel_new += (pixel357)*(float)1.0; accumWeights += 1;
    }
    float pixel358_diffR = fabs(pixel358.x- (float)pixel_orig.x);
    float pixel358_diffG = fabs(pixel358.y- (float)pixel_orig.y);
    float pixel358_diffB = fabs(pixel358.z- (float)pixel_orig.z);
    float pixel358_diffA = fabs(pixel358.w- (float)pixel_orig.w);
   if ((pixel358_diffR<30)&& (pixel358_diffG< 30)&&(pixel358_diffB< 30 )&&(pixel358_diffA< 30)){
	    pixel_new += (pixel358)*(float)1.0; accumWeights += 1;
    }
    float pixel359_diffR = fabs(pixel359.x- (float)pixel_orig.x);
    float pixel359_diffG = fabs(pixel359.y- (float)pixel_orig.y);
    float pixel359_diffB = fabs(pixel359.z- (float)pixel_orig.z);
    float pixel359_diffA = fabs(pixel359.w- (float)pixel_orig.w);
   if ((pixel359_diffR<30)&& (pixel359_diffG< 30)&&(pixel359_diffB< 30 )&&(pixel359_diffA< 30)){
	    pixel_new += (pixel359)*(float)1.0; accumWeights += 1;
    }
    float pixel360_diffR = fabs(pixel360.x- (float)pixel_orig.x);
    float pixel360_diffG = fabs(pixel360.y- (float)pixel_orig.y);
    float pixel360_diffB = fabs(pixel360.z- (float)pixel_orig.z);
    float pixel360_diffA = fabs(pixel360.w- (float)pixel_orig.w);
   if ((pixel360_diffR<30)&& (pixel360_diffG< 30)&&(pixel360_diffB< 30 )&&(pixel360_diffA< 30)){
	    pixel_new += (pixel360)*(float)1.0; accumWeights += 1;
    }
    float pixel361_diffR = fabs(pixel361.x- (float)pixel_orig.x);
    float pixel361_diffG = fabs(pixel361.y- (float)pixel_orig.y);
    float pixel361_diffB = fabs(pixel361.z- (float)pixel_orig.z);
    float pixel361_diffA = fabs(pixel361.w- (float)pixel_orig.w);
   if ((pixel361_diffR<30)&& (pixel361_diffG< 30)&&(pixel361_diffB< 30 )&&(pixel361_diffA< 30)){
	    pixel_new += (pixel361)*(float)1.0; accumWeights += 1;
    }
    float pixel362_diffR = fabs(pixel362.x- (float)pixel_orig.x);
    float pixel362_diffG = fabs(pixel362.y- (float)pixel_orig.y);
    float pixel362_diffB = fabs(pixel362.z- (float)pixel_orig.z);
    float pixel362_diffA = fabs(pixel362.w- (float)pixel_orig.w);
   if ((pixel362_diffR<30)&& (pixel362_diffG< 30)&&(pixel362_diffB< 30 )&&(pixel362_diffA< 30)){
	    pixel_new += (pixel362)*(float)1.0; accumWeights += 1;
    }
    float pixel363_diffR = fabs(pixel363.x- (float)pixel_orig.x);
    float pixel363_diffG = fabs(pixel363.y- (float)pixel_orig.y);
    float pixel363_diffB = fabs(pixel363.z- (float)pixel_orig.z);
    float pixel363_diffA = fabs(pixel363.w- (float)pixel_orig.w);
   if ((pixel363_diffR<30)&& (pixel363_diffG< 30)&&(pixel363_diffB< 30 )&&(pixel363_diffA< 30)){
	    pixel_new += (pixel363)*(float)1.0; accumWeights += 1;
    }
    float pixel364_diffR = fabs(pixel364.x- (float)pixel_orig.x);
    float pixel364_diffG = fabs(pixel364.y- (float)pixel_orig.y);
    float pixel364_diffB = fabs(pixel364.z- (float)pixel_orig.z);
    float pixel364_diffA = fabs(pixel364.w- (float)pixel_orig.w);
   if ((pixel364_diffR<30)&& (pixel364_diffG< 30)&&(pixel364_diffB< 30 )&&(pixel364_diffA< 30)){
	    pixel_new += (pixel364)*(float)1.0; accumWeights += 1;
    }
    float pixel365_diffR = fabs(pixel365.x- (float)pixel_orig.x);
    float pixel365_diffG = fabs(pixel365.y- (float)pixel_orig.y);
    float pixel365_diffB = fabs(pixel365.z- (float)pixel_orig.z);
    float pixel365_diffA = fabs(pixel365.w- (float)pixel_orig.w);
   if ((pixel365_diffR<30)&& (pixel365_diffG< 30)&&(pixel365_diffB< 30 )&&(pixel365_diffA< 30)){
	    pixel_new += (pixel365)*(float)1.0; accumWeights += 1;
    }
    float pixel366_diffR = fabs(pixel366.x- (float)pixel_orig.x);
    float pixel366_diffG = fabs(pixel366.y- (float)pixel_orig.y);
    float pixel366_diffB = fabs(pixel366.z- (float)pixel_orig.z);
    float pixel366_diffA = fabs(pixel366.w- (float)pixel_orig.w);
   if ((pixel366_diffR<30)&& (pixel366_diffG< 30)&&(pixel366_diffB< 30 )&&(pixel366_diffA< 30)){
	    pixel_new += (pixel366)*(float)1.0; accumWeights += 1;
    }
    float pixel367_diffR = fabs(pixel367.x- (float)pixel_orig.x);
    float pixel367_diffG = fabs(pixel367.y- (float)pixel_orig.y);
    float pixel367_diffB = fabs(pixel367.z- (float)pixel_orig.z);
    float pixel367_diffA = fabs(pixel367.w- (float)pixel_orig.w);
   if ((pixel367_diffR<30)&& (pixel367_diffG< 30)&&(pixel367_diffB< 30 )&&(pixel367_diffA< 30)){
	    pixel_new += (pixel367)*(float)1.0; accumWeights += 1;
    }
    float pixel368_diffR = fabs(pixel368.x- (float)pixel_orig.x);
    float pixel368_diffG = fabs(pixel368.y- (float)pixel_orig.y);
    float pixel368_diffB = fabs(pixel368.z- (float)pixel_orig.z);
    float pixel368_diffA = fabs(pixel368.w- (float)pixel_orig.w);
   if ((pixel368_diffR<30)&& (pixel368_diffG< 30)&&(pixel368_diffB< 30 )&&(pixel368_diffA< 30)){
	    pixel_new += (pixel368)*(float)1.0; accumWeights += 1;
    }
    float pixel369_diffR = fabs(pixel369.x- (float)pixel_orig.x);
    float pixel369_diffG = fabs(pixel369.y- (float)pixel_orig.y);
    float pixel369_diffB = fabs(pixel369.z- (float)pixel_orig.z);
    float pixel369_diffA = fabs(pixel369.w- (float)pixel_orig.w);
   if ((pixel369_diffR<30)&& (pixel369_diffG< 30)&&(pixel369_diffB< 30 )&&(pixel369_diffA< 30)){
	    pixel_new += (pixel369)*(float)1.0; accumWeights += 1;
    }
    float pixel370_diffR = fabs(pixel370.x- (float)pixel_orig.x);
    float pixel370_diffG = fabs(pixel370.y- (float)pixel_orig.y);
    float pixel370_diffB = fabs(pixel370.z- (float)pixel_orig.z);
    float pixel370_diffA = fabs(pixel370.w- (float)pixel_orig.w);
   if ((pixel370_diffR<30)&& (pixel370_diffG< 30)&&(pixel370_diffB< 30 )&&(pixel370_diffA< 30)){
	    pixel_new += (pixel370)*(float)1.0; accumWeights += 1;
    }
    float pixel371_diffR = fabs(pixel371.x- (float)pixel_orig.x);
    float pixel371_diffG = fabs(pixel371.y- (float)pixel_orig.y);
    float pixel371_diffB = fabs(pixel371.z- (float)pixel_orig.z);
    float pixel371_diffA = fabs(pixel371.w- (float)pixel_orig.w);
   if ((pixel371_diffR<30)&& (pixel371_diffG< 30)&&(pixel371_diffB< 30 )&&(pixel371_diffA< 30)){
	    pixel_new += (pixel371)*(float)1.0; accumWeights += 1;
    }
    float pixel372_diffR = fabs(pixel372.x- (float)pixel_orig.x);
    float pixel372_diffG = fabs(pixel372.y- (float)pixel_orig.y);
    float pixel372_diffB = fabs(pixel372.z- (float)pixel_orig.z);
    float pixel372_diffA = fabs(pixel372.w- (float)pixel_orig.w);
   if ((pixel372_diffR<30)&& (pixel372_diffG< 30)&&(pixel372_diffB< 30 )&&(pixel372_diffA< 30)){
	    pixel_new += (pixel372)*(float)1.0; accumWeights += 1;
    }
    float pixel373_diffR = fabs(pixel373.x- (float)pixel_orig.x);
    float pixel373_diffG = fabs(pixel373.y- (float)pixel_orig.y);
    float pixel373_diffB = fabs(pixel373.z- (float)pixel_orig.z);
    float pixel373_diffA = fabs(pixel373.w- (float)pixel_orig.w);
   if ((pixel373_diffR<30)&& (pixel373_diffG< 30)&&(pixel373_diffB< 30 )&&(pixel373_diffA< 30)){
	    pixel_new += (pixel373)*(float)1.0; accumWeights += 1;
    }
    float pixel374_diffR = fabs(pixel374.x- (float)pixel_orig.x);
    float pixel374_diffG = fabs(pixel374.y- (float)pixel_orig.y);
    float pixel374_diffB = fabs(pixel374.z- (float)pixel_orig.z);
    float pixel374_diffA = fabs(pixel374.w- (float)pixel_orig.w);
   if ((pixel374_diffR<30)&& (pixel374_diffG< 30)&&(pixel374_diffB< 30 )&&(pixel374_diffA< 30)){
	    pixel_new += (pixel374)*(float)1.0; accumWeights += 1;
    }
    float pixel375_diffR = fabs(pixel375.x- (float)pixel_orig.x);
    float pixel375_diffG = fabs(pixel375.y- (float)pixel_orig.y);
    float pixel375_diffB = fabs(pixel375.z- (float)pixel_orig.z);
    float pixel375_diffA = fabs(pixel375.w- (float)pixel_orig.w);
   if ((pixel375_diffR<30)&& (pixel375_diffG< 30)&&(pixel375_diffB< 30 )&&(pixel375_diffA< 30)){
	    pixel_new += (pixel375)*(float)1.0; accumWeights += 1;
    }
    float pixel376_diffR = fabs(pixel376.x- (float)pixel_orig.x);
    float pixel376_diffG = fabs(pixel376.y- (float)pixel_orig.y);
    float pixel376_diffB = fabs(pixel376.z- (float)pixel_orig.z);
    float pixel376_diffA = fabs(pixel376.w- (float)pixel_orig.w);
   if ((pixel376_diffR<30)&& (pixel376_diffG< 30)&&(pixel376_diffB< 30 )&&(pixel376_diffA< 30)){
	    pixel_new += (pixel376)*(float)1.0; accumWeights += 1;
    }
    float pixel377_diffR = fabs(pixel377.x- (float)pixel_orig.x);
    float pixel377_diffG = fabs(pixel377.y- (float)pixel_orig.y);
    float pixel377_diffB = fabs(pixel377.z- (float)pixel_orig.z);
    float pixel377_diffA = fabs(pixel377.w- (float)pixel_orig.w);
   if ((pixel377_diffR<30)&& (pixel377_diffG< 30)&&(pixel377_diffB< 30 )&&(pixel377_diffA< 30)){
	    pixel_new += (pixel377)*(float)1.0; accumWeights += 1;
    }
    float pixel378_diffR = fabs(pixel378.x- (float)pixel_orig.x);
    float pixel378_diffG = fabs(pixel378.y- (float)pixel_orig.y);
    float pixel378_diffB = fabs(pixel378.z- (float)pixel_orig.z);
    float pixel378_diffA = fabs(pixel378.w- (float)pixel_orig.w);
   if ((pixel378_diffR<30)&& (pixel378_diffG< 30)&&(pixel378_diffB< 30 )&&(pixel378_diffA< 30)){
	    pixel_new += (pixel378)*(float)1.0; accumWeights += 1;
    }
    float pixel379_diffR = fabs(pixel379.x- (float)pixel_orig.x);
    float pixel379_diffG = fabs(pixel379.y- (float)pixel_orig.y);
    float pixel379_diffB = fabs(pixel379.z- (float)pixel_orig.z);
    float pixel379_diffA = fabs(pixel379.w- (float)pixel_orig.w);
   if ((pixel379_diffR<30)&& (pixel379_diffG< 30)&&(pixel379_diffB< 30 )&&(pixel379_diffA< 30)){
	    pixel_new += (pixel379)*(float)1.0; accumWeights += 1;
    }
    float pixel380_diffR = fabs(pixel380.x- (float)pixel_orig.x);
    float pixel380_diffG = fabs(pixel380.y- (float)pixel_orig.y);
    float pixel380_diffB = fabs(pixel380.z- (float)pixel_orig.z);
    float pixel380_diffA = fabs(pixel380.w- (float)pixel_orig.w);
   if ((pixel380_diffR<30)&& (pixel380_diffG< 30)&&(pixel380_diffB< 30 )&&(pixel380_diffA< 30)){
	    pixel_new += (pixel380)*(float)1.0; accumWeights += 1;
    }
    float pixel381_diffR = fabs(pixel381.x- (float)pixel_orig.x);
    float pixel381_diffG = fabs(pixel381.y- (float)pixel_orig.y);
    float pixel381_diffB = fabs(pixel381.z- (float)pixel_orig.z);
    float pixel381_diffA = fabs(pixel381.w- (float)pixel_orig.w);
   if ((pixel381_diffR<30)&& (pixel381_diffG< 30)&&(pixel381_diffB< 30 )&&(pixel381_diffA< 30)){
	    pixel_new += (pixel381)*(float)1.0; accumWeights += 1;
    }
    float pixel382_diffR = fabs(pixel382.x- (float)pixel_orig.x);
    float pixel382_diffG = fabs(pixel382.y- (float)pixel_orig.y);
    float pixel382_diffB = fabs(pixel382.z- (float)pixel_orig.z);
    float pixel382_diffA = fabs(pixel382.w- (float)pixel_orig.w);
   if ((pixel382_diffR<30)&& (pixel382_diffG< 30)&&(pixel382_diffB< 30 )&&(pixel382_diffA< 30)){
	    pixel_new += (pixel382)*(float)1.0; accumWeights += 1;
    }
    float pixel383_diffR = fabs(pixel383.x- (float)pixel_orig.x);
    float pixel383_diffG = fabs(pixel383.y- (float)pixel_orig.y);
    float pixel383_diffB = fabs(pixel383.z- (float)pixel_orig.z);
    float pixel383_diffA = fabs(pixel383.w- (float)pixel_orig.w);
   if ((pixel383_diffR<30)&& (pixel383_diffG< 30)&&(pixel383_diffB< 30 )&&(pixel383_diffA< 30)){
	    pixel_new += (pixel383)*(float)1.0; accumWeights += 1;
    }
    float pixel384_diffR = fabs(pixel384.x- (float)pixel_orig.x);
    float pixel384_diffG = fabs(pixel384.y- (float)pixel_orig.y);
    float pixel384_diffB = fabs(pixel384.z- (float)pixel_orig.z);
    float pixel384_diffA = fabs(pixel384.w- (float)pixel_orig.w);
   if ((pixel384_diffR<30)&& (pixel384_diffG< 30)&&(pixel384_diffB< 30 )&&(pixel384_diffA< 30)){
	    pixel_new += (pixel384)*(float)1.0; accumWeights += 1;
    }
    float pixel385_diffR = fabs(pixel385.x- (float)pixel_orig.x);
    float pixel385_diffG = fabs(pixel385.y- (float)pixel_orig.y);
    float pixel385_diffB = fabs(pixel385.z- (float)pixel_orig.z);
    float pixel385_diffA = fabs(pixel385.w- (float)pixel_orig.w);
   if ((pixel385_diffR<30)&& (pixel385_diffG< 30)&&(pixel385_diffB< 30 )&&(pixel385_diffA< 30)){
	    pixel_new += (pixel385)*(float)1.0; accumWeights += 1;
    }
    float pixel386_diffR = fabs(pixel386.x- (float)pixel_orig.x);
    float pixel386_diffG = fabs(pixel386.y- (float)pixel_orig.y);
    float pixel386_diffB = fabs(pixel386.z- (float)pixel_orig.z);
    float pixel386_diffA = fabs(pixel386.w- (float)pixel_orig.w);
   if ((pixel386_diffR<30)&& (pixel386_diffG< 30)&&(pixel386_diffB< 30 )&&(pixel386_diffA< 30)){
	    pixel_new += (pixel386)*(float)1.0; accumWeights += 1;
    }
    float pixel387_diffR = fabs(pixel387.x- (float)pixel_orig.x);
    float pixel387_diffG = fabs(pixel387.y- (float)pixel_orig.y);
    float pixel387_diffB = fabs(pixel387.z- (float)pixel_orig.z);
    float pixel387_diffA = fabs(pixel387.w- (float)pixel_orig.w);
   if ((pixel387_diffR<30)&& (pixel387_diffG< 30)&&(pixel387_diffB< 30 )&&(pixel387_diffA< 30)){
	    pixel_new += (pixel387)*(float)1.0; accumWeights += 1;
    }
    float pixel388_diffR = fabs(pixel388.x- (float)pixel_orig.x);
    float pixel388_diffG = fabs(pixel388.y- (float)pixel_orig.y);
    float pixel388_diffB = fabs(pixel388.z- (float)pixel_orig.z);
    float pixel388_diffA = fabs(pixel388.w- (float)pixel_orig.w);
   if ((pixel388_diffR<30)&& (pixel388_diffG< 30)&&(pixel388_diffB< 30 )&&(pixel388_diffA< 30)){
	    pixel_new += (pixel388)*(float)1.0; accumWeights += 1;
    }
    float pixel389_diffR = fabs(pixel389.x- (float)pixel_orig.x);
    float pixel389_diffG = fabs(pixel389.y- (float)pixel_orig.y);
    float pixel389_diffB = fabs(pixel389.z- (float)pixel_orig.z);
    float pixel389_diffA = fabs(pixel389.w- (float)pixel_orig.w);
   if ((pixel389_diffR<30)&& (pixel389_diffG< 30)&&(pixel389_diffB< 30 )&&(pixel389_diffA< 30)){
	    pixel_new += (pixel389)*(float)1.0; accumWeights += 1;
    }
    float pixel390_diffR = fabs(pixel390.x- (float)pixel_orig.x);
    float pixel390_diffG = fabs(pixel390.y- (float)pixel_orig.y);
    float pixel390_diffB = fabs(pixel390.z- (float)pixel_orig.z);
    float pixel390_diffA = fabs(pixel390.w- (float)pixel_orig.w);
   if ((pixel390_diffR<30)&& (pixel390_diffG< 30)&&(pixel390_diffB< 30 )&&(pixel390_diffA< 30)){
	    pixel_new += (pixel390)*(float)1.0; accumWeights += 1;
    }
    float pixel391_diffR = fabs(pixel391.x- (float)pixel_orig.x);
    float pixel391_diffG = fabs(pixel391.y- (float)pixel_orig.y);
    float pixel391_diffB = fabs(pixel391.z- (float)pixel_orig.z);
    float pixel391_diffA = fabs(pixel391.w- (float)pixel_orig.w);
   if ((pixel391_diffR<30)&& (pixel391_diffG< 30)&&(pixel391_diffB< 30 )&&(pixel391_diffA< 30)){
	    pixel_new += (pixel391)*(float)1.0; accumWeights += 1;
    }
    float pixel392_diffR = fabs(pixel392.x- (float)pixel_orig.x);
    float pixel392_diffG = fabs(pixel392.y- (float)pixel_orig.y);
    float pixel392_diffB = fabs(pixel392.z- (float)pixel_orig.z);
    float pixel392_diffA = fabs(pixel392.w- (float)pixel_orig.w);
   if ((pixel392_diffR<30)&& (pixel392_diffG< 30)&&(pixel392_diffB< 30 )&&(pixel392_diffA< 30)){
	    pixel_new += (pixel392)*(float)1.0; accumWeights += 1;
    }
    float pixel393_diffR = fabs(pixel393.x- (float)pixel_orig.x);
    float pixel393_diffG = fabs(pixel393.y- (float)pixel_orig.y);
    float pixel393_diffB = fabs(pixel393.z- (float)pixel_orig.z);
    float pixel393_diffA = fabs(pixel393.w- (float)pixel_orig.w);
   if ((pixel393_diffR<30)&& (pixel393_diffG< 30)&&(pixel393_diffB< 30 )&&(pixel393_diffA< 30)){
	    pixel_new += (pixel393)*(float)1.0; accumWeights += 1;
    }
    float pixel394_diffR = fabs(pixel394.x- (float)pixel_orig.x);
    float pixel394_diffG = fabs(pixel394.y- (float)pixel_orig.y);
    float pixel394_diffB = fabs(pixel394.z- (float)pixel_orig.z);
    float pixel394_diffA = fabs(pixel394.w- (float)pixel_orig.w);
   if ((pixel394_diffR<30)&& (pixel394_diffG< 30)&&(pixel394_diffB< 30 )&&(pixel394_diffA< 30)){
	    pixel_new += (pixel394)*(float)1.0; accumWeights += 1;
    }
    float pixel395_diffR = fabs(pixel395.x- (float)pixel_orig.x);
    float pixel395_diffG = fabs(pixel395.y- (float)pixel_orig.y);
    float pixel395_diffB = fabs(pixel395.z- (float)pixel_orig.z);
    float pixel395_diffA = fabs(pixel395.w- (float)pixel_orig.w);
   if ((pixel395_diffR<30)&& (pixel395_diffG< 30)&&(pixel395_diffB< 30 )&&(pixel395_diffA< 30)){
	    pixel_new += (pixel395)*(float)1.0; accumWeights += 1;
    }
    float pixel396_diffR = fabs(pixel396.x- (float)pixel_orig.x);
    float pixel396_diffG = fabs(pixel396.y- (float)pixel_orig.y);
    float pixel396_diffB = fabs(pixel396.z- (float)pixel_orig.z);
    float pixel396_diffA = fabs(pixel396.w- (float)pixel_orig.w);
   if ((pixel396_diffR<30)&& (pixel396_diffG< 30)&&(pixel396_diffB< 30 )&&(pixel396_diffA< 30)){
	    pixel_new += (pixel396)*(float)1.0; accumWeights += 1;
    }
    float pixel397_diffR = fabs(pixel397.x- (float)pixel_orig.x);
    float pixel397_diffG = fabs(pixel397.y- (float)pixel_orig.y);
    float pixel397_diffB = fabs(pixel397.z- (float)pixel_orig.z);
    float pixel397_diffA = fabs(pixel397.w- (float)pixel_orig.w);
   if ((pixel397_diffR<30)&& (pixel397_diffG< 30)&&(pixel397_diffB< 30 )&&(pixel397_diffA< 30)){
	    pixel_new += (pixel397)*(float)1.0; accumWeights += 1;
    }
    float pixel398_diffR = fabs(pixel398.x- (float)pixel_orig.x);
    float pixel398_diffG = fabs(pixel398.y- (float)pixel_orig.y);
    float pixel398_diffB = fabs(pixel398.z- (float)pixel_orig.z);
    float pixel398_diffA = fabs(pixel398.w- (float)pixel_orig.w);
   if ((pixel398_diffR<30)&& (pixel398_diffG< 30)&&(pixel398_diffB< 30 )&&(pixel398_diffA< 30)){
	    pixel_new += (pixel398)*(float)1.0; accumWeights += 1;
    }
    float pixel399_diffR = fabs(pixel399.x- (float)pixel_orig.x);
    float pixel399_diffG = fabs(pixel399.y- (float)pixel_orig.y);
    float pixel399_diffB = fabs(pixel399.z- (float)pixel_orig.z);
    float pixel399_diffA = fabs(pixel399.w- (float)pixel_orig.w);
   if ((pixel399_diffR<30)&& (pixel399_diffG< 30)&&(pixel399_diffB< 30 )&&(pixel399_diffA< 30)){
	    pixel_new += (pixel399)*(float)1.0; accumWeights += 1;
    }
    float pixel400_diffR = fabs(pixel400.x- (float)pixel_orig.x);
    float pixel400_diffG = fabs(pixel400.y- (float)pixel_orig.y);
    float pixel400_diffB = fabs(pixel400.z- (float)pixel_orig.z);
    float pixel400_diffA = fabs(pixel400.w- (float)pixel_orig.w);
   if ((pixel400_diffR<30)&& (pixel400_diffG< 30)&&(pixel400_diffB< 30 )&&(pixel400_diffA< 30)){
	    pixel_new += (pixel400)*(float)1.0; accumWeights += 1;
    }
    float pixel401_diffR = fabs(pixel401.x- (float)pixel_orig.x);
    float pixel401_diffG = fabs(pixel401.y- (float)pixel_orig.y);
    float pixel401_diffB = fabs(pixel401.z- (float)pixel_orig.z);
    float pixel401_diffA = fabs(pixel401.w- (float)pixel_orig.w);
   if ((pixel401_diffR<30)&& (pixel401_diffG< 30)&&(pixel401_diffB< 30 )&&(pixel401_diffA< 30)){
	    pixel_new += (pixel401)*(float)1.0; accumWeights += 1;
    }
    float pixel402_diffR = fabs(pixel402.x- (float)pixel_orig.x);
    float pixel402_diffG = fabs(pixel402.y- (float)pixel_orig.y);
    float pixel402_diffB = fabs(pixel402.z- (float)pixel_orig.z);
    float pixel402_diffA = fabs(pixel402.w- (float)pixel_orig.w);
   if ((pixel402_diffR<30)&& (pixel402_diffG< 30)&&(pixel402_diffB< 30 )&&(pixel402_diffA< 30)){
	    pixel_new += (pixel402)*(float)1.0; accumWeights += 1;
    }
    float pixel403_diffR = fabs(pixel403.x- (float)pixel_orig.x);
    float pixel403_diffG = fabs(pixel403.y- (float)pixel_orig.y);
    float pixel403_diffB = fabs(pixel403.z- (float)pixel_orig.z);
    float pixel403_diffA = fabs(pixel403.w- (float)pixel_orig.w);
   if ((pixel403_diffR<30)&& (pixel403_diffG< 30)&&(pixel403_diffB< 30 )&&(pixel403_diffA< 30)){
	    pixel_new += (pixel403)*(float)1.0; accumWeights += 1;
    }
    float pixel404_diffR = fabs(pixel404.x- (float)pixel_orig.x);
    float pixel404_diffG = fabs(pixel404.y- (float)pixel_orig.y);
    float pixel404_diffB = fabs(pixel404.z- (float)pixel_orig.z);
    float pixel404_diffA = fabs(pixel404.w- (float)pixel_orig.w);
   if ((pixel404_diffR<30)&& (pixel404_diffG< 30)&&(pixel404_diffB< 30 )&&(pixel404_diffA< 30)){
	    pixel_new += (pixel404)*(float)1.0; accumWeights += 1;
    }
    float pixel405_diffR = fabs(pixel405.x- (float)pixel_orig.x);
    float pixel405_diffG = fabs(pixel405.y- (float)pixel_orig.y);
    float pixel405_diffB = fabs(pixel405.z- (float)pixel_orig.z);
    float pixel405_diffA = fabs(pixel405.w- (float)pixel_orig.w);
   if ((pixel405_diffR<30)&& (pixel405_diffG< 30)&&(pixel405_diffB< 30 )&&(pixel405_diffA< 30)){
	    pixel_new += (pixel405)*(float)1.0; accumWeights += 1;
    }
    float pixel406_diffR = fabs(pixel406.x- (float)pixel_orig.x);
    float pixel406_diffG = fabs(pixel406.y- (float)pixel_orig.y);
    float pixel406_diffB = fabs(pixel406.z- (float)pixel_orig.z);
    float pixel406_diffA = fabs(pixel406.w- (float)pixel_orig.w);
   if ((pixel406_diffR<30)&& (pixel406_diffG< 30)&&(pixel406_diffB< 30 )&&(pixel406_diffA< 30)){
	    pixel_new += (pixel406)*(float)1.0; accumWeights += 1;
    }
    float pixel407_diffR = fabs(pixel407.x- (float)pixel_orig.x);
    float pixel407_diffG = fabs(pixel407.y- (float)pixel_orig.y);
    float pixel407_diffB = fabs(pixel407.z- (float)pixel_orig.z);
    float pixel407_diffA = fabs(pixel407.w- (float)pixel_orig.w);
   if ((pixel407_diffR<30)&& (pixel407_diffG< 30)&&(pixel407_diffB< 30 )&&(pixel407_diffA< 30)){
	    pixel_new += (pixel407)*(float)1.0; accumWeights += 1;
    }
    float pixel408_diffR = fabs(pixel408.x- (float)pixel_orig.x);
    float pixel408_diffG = fabs(pixel408.y- (float)pixel_orig.y);
    float pixel408_diffB = fabs(pixel408.z- (float)pixel_orig.z);
    float pixel408_diffA = fabs(pixel408.w- (float)pixel_orig.w);
   if ((pixel408_diffR<30)&& (pixel408_diffG< 30)&&(pixel408_diffB< 30 )&&(pixel408_diffA< 30)){
	    pixel_new += (pixel408)*(float)1.0; accumWeights += 1;
    }
    float pixel409_diffR = fabs(pixel409.x- (float)pixel_orig.x);
    float pixel409_diffG = fabs(pixel409.y- (float)pixel_orig.y);
    float pixel409_diffB = fabs(pixel409.z- (float)pixel_orig.z);
    float pixel409_diffA = fabs(pixel409.w- (float)pixel_orig.w);
   if ((pixel409_diffR<30)&& (pixel409_diffG< 30)&&(pixel409_diffB< 30 )&&(pixel409_diffA< 30)){
	    pixel_new += (pixel409)*(float)1.0; accumWeights += 1;
    }
    float pixel410_diffR = fabs(pixel410.x- (float)pixel_orig.x);
    float pixel410_diffG = fabs(pixel410.y- (float)pixel_orig.y);
    float pixel410_diffB = fabs(pixel410.z- (float)pixel_orig.z);
    float pixel410_diffA = fabs(pixel410.w- (float)pixel_orig.w);
   if ((pixel410_diffR<30)&& (pixel410_diffG< 30)&&(pixel410_diffB< 30 )&&(pixel410_diffA< 30)){
	    pixel_new += (pixel410)*(float)1.0; accumWeights += 1;
    }
    float pixel411_diffR = fabs(pixel411.x- (float)pixel_orig.x);
    float pixel411_diffG = fabs(pixel411.y- (float)pixel_orig.y);
    float pixel411_diffB = fabs(pixel411.z- (float)pixel_orig.z);
    float pixel411_diffA = fabs(pixel411.w- (float)pixel_orig.w);
   if ((pixel411_diffR<30)&& (pixel411_diffG< 30)&&(pixel411_diffB< 30 )&&(pixel411_diffA< 30)){
	    pixel_new += (pixel411)*(float)1.0; accumWeights += 1;
    }
    float pixel412_diffR = fabs(pixel412.x- (float)pixel_orig.x);
    float pixel412_diffG = fabs(pixel412.y- (float)pixel_orig.y);
    float pixel412_diffB = fabs(pixel412.z- (float)pixel_orig.z);
    float pixel412_diffA = fabs(pixel412.w- (float)pixel_orig.w);
   if ((pixel412_diffR<30)&& (pixel412_diffG< 30)&&(pixel412_diffB< 30 )&&(pixel412_diffA< 30)){
	    pixel_new += (pixel412)*(float)1.0; accumWeights += 1;
    }
    float pixel413_diffR = fabs(pixel413.x- (float)pixel_orig.x);
    float pixel413_diffG = fabs(pixel413.y- (float)pixel_orig.y);
    float pixel413_diffB = fabs(pixel413.z- (float)pixel_orig.z);
    float pixel413_diffA = fabs(pixel413.w- (float)pixel_orig.w);
   if ((pixel413_diffR<30)&& (pixel413_diffG< 30)&&(pixel413_diffB< 30 )&&(pixel413_diffA< 30)){
	    pixel_new += (pixel413)*(float)1.0; accumWeights += 1;
    }
    float pixel414_diffR = fabs(pixel414.x- (float)pixel_orig.x);
    float pixel414_diffG = fabs(pixel414.y- (float)pixel_orig.y);
    float pixel414_diffB = fabs(pixel414.z- (float)pixel_orig.z);
    float pixel414_diffA = fabs(pixel414.w- (float)pixel_orig.w);
   if ((pixel414_diffR<30)&& (pixel414_diffG< 30)&&(pixel414_diffB< 30 )&&(pixel414_diffA< 30)){
	    pixel_new += (pixel414)*(float)1.0; accumWeights += 1;
    }
    float pixel415_diffR = fabs(pixel415.x- (float)pixel_orig.x);
    float pixel415_diffG = fabs(pixel415.y- (float)pixel_orig.y);
    float pixel415_diffB = fabs(pixel415.z- (float)pixel_orig.z);
    float pixel415_diffA = fabs(pixel415.w- (float)pixel_orig.w);
   if ((pixel415_diffR<30)&& (pixel415_diffG< 30)&&(pixel415_diffB< 30 )&&(pixel415_diffA< 30)){
	    pixel_new += (pixel415)*(float)1.0; accumWeights += 1;
    }
    float pixel416_diffR = fabs(pixel416.x- (float)pixel_orig.x);
    float pixel416_diffG = fabs(pixel416.y- (float)pixel_orig.y);
    float pixel416_diffB = fabs(pixel416.z- (float)pixel_orig.z);
    float pixel416_diffA = fabs(pixel416.w- (float)pixel_orig.w);
   if ((pixel416_diffR<30)&& (pixel416_diffG< 30)&&(pixel416_diffB< 30 )&&(pixel416_diffA< 30)){
	    pixel_new += (pixel416)*(float)1.0; accumWeights += 1;
    }
    float pixel417_diffR = fabs(pixel417.x- (float)pixel_orig.x);
    float pixel417_diffG = fabs(pixel417.y- (float)pixel_orig.y);
    float pixel417_diffB = fabs(pixel417.z- (float)pixel_orig.z);
    float pixel417_diffA = fabs(pixel417.w- (float)pixel_orig.w);
   if ((pixel417_diffR<30)&& (pixel417_diffG< 30)&&(pixel417_diffB< 30 )&&(pixel417_diffA< 30)){
	    pixel_new += (pixel417)*(float)1.0; accumWeights += 1;
    }
    float pixel418_diffR = fabs(pixel418.x- (float)pixel_orig.x);
    float pixel418_diffG = fabs(pixel418.y- (float)pixel_orig.y);
    float pixel418_diffB = fabs(pixel418.z- (float)pixel_orig.z);
    float pixel418_diffA = fabs(pixel418.w- (float)pixel_orig.w);
   if ((pixel418_diffR<30)&& (pixel418_diffG< 30)&&(pixel418_diffB< 30 )&&(pixel418_diffA< 30)){
	    pixel_new += (pixel418)*(float)1.0; accumWeights += 1;
    }
    float pixel419_diffR = fabs(pixel419.x- (float)pixel_orig.x);
    float pixel419_diffG = fabs(pixel419.y- (float)pixel_orig.y);
    float pixel419_diffB = fabs(pixel419.z- (float)pixel_orig.z);
    float pixel419_diffA = fabs(pixel419.w- (float)pixel_orig.w);
   if ((pixel419_diffR<30)&& (pixel419_diffG< 30)&&(pixel419_diffB< 30 )&&(pixel419_diffA< 30)){
	    pixel_new += (pixel419)*(float)1.0; accumWeights += 1;
    }
    float pixel420_diffR = fabs(pixel420.x- (float)pixel_orig.x);
    float pixel420_diffG = fabs(pixel420.y- (float)pixel_orig.y);
    float pixel420_diffB = fabs(pixel420.z- (float)pixel_orig.z);
    float pixel420_diffA = fabs(pixel420.w- (float)pixel_orig.w);
   if ((pixel420_diffR<30)&& (pixel420_diffG< 30)&&(pixel420_diffB< 30 )&&(pixel420_diffA< 30)){
	    pixel_new += (pixel420)*(float)1.0; accumWeights += 1;
    }
    float pixel421_diffR = fabs(pixel421.x- (float)pixel_orig.x);
    float pixel421_diffG = fabs(pixel421.y- (float)pixel_orig.y);
    float pixel421_diffB = fabs(pixel421.z- (float)pixel_orig.z);
    float pixel421_diffA = fabs(pixel421.w- (float)pixel_orig.w);
   if ((pixel421_diffR<30)&& (pixel421_diffG< 30)&&(pixel421_diffB< 30 )&&(pixel421_diffA< 30)){
	    pixel_new += (pixel421)*(float)1.0; accumWeights += 1;
    }
    float pixel422_diffR = fabs(pixel422.x- (float)pixel_orig.x);
    float pixel422_diffG = fabs(pixel422.y- (float)pixel_orig.y);
    float pixel422_diffB = fabs(pixel422.z- (float)pixel_orig.z);
    float pixel422_diffA = fabs(pixel422.w- (float)pixel_orig.w);
   if ((pixel422_diffR<30)&& (pixel422_diffG< 30)&&(pixel422_diffB< 30 )&&(pixel422_diffA< 30)){
	    pixel_new += (pixel422)*(float)1.0; accumWeights += 1;
    }
    float pixel423_diffR = fabs(pixel423.x- (float)pixel_orig.x);
    float pixel423_diffG = fabs(pixel423.y- (float)pixel_orig.y);
    float pixel423_diffB = fabs(pixel423.z- (float)pixel_orig.z);
    float pixel423_diffA = fabs(pixel423.w- (float)pixel_orig.w);
   if ((pixel423_diffR<30)&& (pixel423_diffG< 30)&&(pixel423_diffB< 30 )&&(pixel423_diffA< 30)){
	    pixel_new += (pixel423)*(float)1.0; accumWeights += 1;
    }
    float pixel424_diffR = fabs(pixel424.x- (float)pixel_orig.x);
    float pixel424_diffG = fabs(pixel424.y- (float)pixel_orig.y);
    float pixel424_diffB = fabs(pixel424.z- (float)pixel_orig.z);
    float pixel424_diffA = fabs(pixel424.w- (float)pixel_orig.w);
   if ((pixel424_diffR<30)&& (pixel424_diffG< 30)&&(pixel424_diffB< 30 )&&(pixel424_diffA< 30)){
	    pixel_new += (pixel424)*(float)1.0; accumWeights += 1;
    }
    float pixel425_diffR = fabs(pixel425.x- (float)pixel_orig.x);
    float pixel425_diffG = fabs(pixel425.y- (float)pixel_orig.y);
    float pixel425_diffB = fabs(pixel425.z- (float)pixel_orig.z);
    float pixel425_diffA = fabs(pixel425.w- (float)pixel_orig.w);
   if ((pixel425_diffR<30)&& (pixel425_diffG< 30)&&(pixel425_diffB< 30 )&&(pixel425_diffA< 30)){
	    pixel_new += (pixel425)*(float)1.0; accumWeights += 1;
    }
    float pixel426_diffR = fabs(pixel426.x- (float)pixel_orig.x);
    float pixel426_diffG = fabs(pixel426.y- (float)pixel_orig.y);
    float pixel426_diffB = fabs(pixel426.z- (float)pixel_orig.z);
    float pixel426_diffA = fabs(pixel426.w- (float)pixel_orig.w);
   if ((pixel426_diffR<30)&& (pixel426_diffG< 30)&&(pixel426_diffB< 30 )&&(pixel426_diffA< 30)){
	    pixel_new += (pixel426)*(float)1.0; accumWeights += 1;
    }
    float pixel427_diffR = fabs(pixel427.x- (float)pixel_orig.x);
    float pixel427_diffG = fabs(pixel427.y- (float)pixel_orig.y);
    float pixel427_diffB = fabs(pixel427.z- (float)pixel_orig.z);
    float pixel427_diffA = fabs(pixel427.w- (float)pixel_orig.w);
   if ((pixel427_diffR<30)&& (pixel427_diffG< 30)&&(pixel427_diffB< 30 )&&(pixel427_diffA< 30)){
	    pixel_new += (pixel427)*(float)1.0; accumWeights += 1;
    }
    float pixel428_diffR = fabs(pixel428.x- (float)pixel_orig.x);
    float pixel428_diffG = fabs(pixel428.y- (float)pixel_orig.y);
    float pixel428_diffB = fabs(pixel428.z- (float)pixel_orig.z);
    float pixel428_diffA = fabs(pixel428.w- (float)pixel_orig.w);
   if ((pixel428_diffR<30)&& (pixel428_diffG< 30)&&(pixel428_diffB< 30 )&&(pixel428_diffA< 30)){
	    pixel_new += (pixel428)*(float)1.0; accumWeights += 1;
    }
    float pixel429_diffR = fabs(pixel429.x- (float)pixel_orig.x);
    float pixel429_diffG = fabs(pixel429.y- (float)pixel_orig.y);
    float pixel429_diffB = fabs(pixel429.z- (float)pixel_orig.z);
    float pixel429_diffA = fabs(pixel429.w- (float)pixel_orig.w);
   if ((pixel429_diffR<30)&& (pixel429_diffG< 30)&&(pixel429_diffB< 30 )&&(pixel429_diffA< 30)){
	    pixel_new += (pixel429)*(float)1.0; accumWeights += 1;
    }
    float pixel430_diffR = fabs(pixel430.x- (float)pixel_orig.x);
    float pixel430_diffG = fabs(pixel430.y- (float)pixel_orig.y);
    float pixel430_diffB = fabs(pixel430.z- (float)pixel_orig.z);
    float pixel430_diffA = fabs(pixel430.w- (float)pixel_orig.w);
   if ((pixel430_diffR<30)&& (pixel430_diffG< 30)&&(pixel430_diffB< 30 )&&(pixel430_diffA< 30)){
	    pixel_new += (pixel430)*(float)1.0; accumWeights += 1;
    }
    float pixel431_diffR = fabs(pixel431.x- (float)pixel_orig.x);
    float pixel431_diffG = fabs(pixel431.y- (float)pixel_orig.y);
    float pixel431_diffB = fabs(pixel431.z- (float)pixel_orig.z);
    float pixel431_diffA = fabs(pixel431.w- (float)pixel_orig.w);
   if ((pixel431_diffR<30)&& (pixel431_diffG< 30)&&(pixel431_diffB< 30 )&&(pixel431_diffA< 30)){
	    pixel_new += (pixel431)*(float)1.0; accumWeights += 1;
    }
    float pixel432_diffR = fabs(pixel432.x- (float)pixel_orig.x);
    float pixel432_diffG = fabs(pixel432.y- (float)pixel_orig.y);
    float pixel432_diffB = fabs(pixel432.z- (float)pixel_orig.z);
    float pixel432_diffA = fabs(pixel432.w- (float)pixel_orig.w);
   if ((pixel432_diffR<30)&& (pixel432_diffG< 30)&&(pixel432_diffB< 30 )&&(pixel432_diffA< 30)){
	    pixel_new += (pixel432)*(float)1.0; accumWeights += 1;
    }
    float pixel433_diffR = fabs(pixel433.x- (float)pixel_orig.x);
    float pixel433_diffG = fabs(pixel433.y- (float)pixel_orig.y);
    float pixel433_diffB = fabs(pixel433.z- (float)pixel_orig.z);
    float pixel433_diffA = fabs(pixel433.w- (float)pixel_orig.w);
   if ((pixel433_diffR<30)&& (pixel433_diffG< 30)&&(pixel433_diffB< 30 )&&(pixel433_diffA< 30)){
	    pixel_new += (pixel433)*(float)1.0; accumWeights += 1;
    }
    float pixel434_diffR = fabs(pixel434.x- (float)pixel_orig.x);
    float pixel434_diffG = fabs(pixel434.y- (float)pixel_orig.y);
    float pixel434_diffB = fabs(pixel434.z- (float)pixel_orig.z);
    float pixel434_diffA = fabs(pixel434.w- (float)pixel_orig.w);
   if ((pixel434_diffR<30)&& (pixel434_diffG< 30)&&(pixel434_diffB< 30 )&&(pixel434_diffA< 30)){
	    pixel_new += (pixel434)*(float)1.0; accumWeights += 1;
    }
    float pixel435_diffR = fabs(pixel435.x- (float)pixel_orig.x);
    float pixel435_diffG = fabs(pixel435.y- (float)pixel_orig.y);
    float pixel435_diffB = fabs(pixel435.z- (float)pixel_orig.z);
    float pixel435_diffA = fabs(pixel435.w- (float)pixel_orig.w);
   if ((pixel435_diffR<30)&& (pixel435_diffG< 30)&&(pixel435_diffB< 30 )&&(pixel435_diffA< 30)){
	    pixel_new += (pixel435)*(float)1.0; accumWeights += 1;
    }
    float pixel436_diffR = fabs(pixel436.x- (float)pixel_orig.x);
    float pixel436_diffG = fabs(pixel436.y- (float)pixel_orig.y);
    float pixel436_diffB = fabs(pixel436.z- (float)pixel_orig.z);
    float pixel436_diffA = fabs(pixel436.w- (float)pixel_orig.w);
   if ((pixel436_diffR<30)&& (pixel436_diffG< 30)&&(pixel436_diffB< 30 )&&(pixel436_diffA< 30)){
	    pixel_new += (pixel436)*(float)1.0; accumWeights += 1;
    }
    float pixel437_diffR = fabs(pixel437.x- (float)pixel_orig.x);
    float pixel437_diffG = fabs(pixel437.y- (float)pixel_orig.y);
    float pixel437_diffB = fabs(pixel437.z- (float)pixel_orig.z);
    float pixel437_diffA = fabs(pixel437.w- (float)pixel_orig.w);
   if ((pixel437_diffR<30)&& (pixel437_diffG< 30)&&(pixel437_diffB< 30 )&&(pixel437_diffA< 30)){
	    pixel_new += (pixel437)*(float)1.0; accumWeights += 1;
    }
    float pixel438_diffR = fabs(pixel438.x- (float)pixel_orig.x);
    float pixel438_diffG = fabs(pixel438.y- (float)pixel_orig.y);
    float pixel438_diffB = fabs(pixel438.z- (float)pixel_orig.z);
    float pixel438_diffA = fabs(pixel438.w- (float)pixel_orig.w);
   if ((pixel438_diffR<30)&& (pixel438_diffG< 30)&&(pixel438_diffB< 30 )&&(pixel438_diffA< 30)){
	    pixel_new += (pixel438)*(float)1.0; accumWeights += 1;
    }
    float pixel439_diffR = fabs(pixel439.x- (float)pixel_orig.x);
    float pixel439_diffG = fabs(pixel439.y- (float)pixel_orig.y);
    float pixel439_diffB = fabs(pixel439.z- (float)pixel_orig.z);
    float pixel439_diffA = fabs(pixel439.w- (float)pixel_orig.w);
   if ((pixel439_diffR<30)&& (pixel439_diffG< 30)&&(pixel439_diffB< 30 )&&(pixel439_diffA< 30)){
	    pixel_new += (pixel439)*(float)1.0; accumWeights += 1;
    }
    float pixel440_diffR = fabs(pixel440.x- (float)pixel_orig.x);
    float pixel440_diffG = fabs(pixel440.y- (float)pixel_orig.y);
    float pixel440_diffB = fabs(pixel440.z- (float)pixel_orig.z);
    float pixel440_diffA = fabs(pixel440.w- (float)pixel_orig.w);
   if ((pixel440_diffR<30)&& (pixel440_diffG< 30)&&(pixel440_diffB< 30 )&&(pixel440_diffA< 30)){
	    pixel_new += (pixel440)*(float)1.0; accumWeights += 1;
    }
    float pixel441_diffR = fabs(pixel441.x- (float)pixel_orig.x);
    float pixel441_diffG = fabs(pixel441.y- (float)pixel_orig.y);
    float pixel441_diffB = fabs(pixel441.z- (float)pixel_orig.z);
    float pixel441_diffA = fabs(pixel441.w- (float)pixel_orig.w);
   if ((pixel441_diffR<30)&& (pixel441_diffG< 30)&&(pixel441_diffB< 30 )&&(pixel441_diffA< 30)){
	    pixel_new += (pixel441)*(float)1.0; accumWeights += 1;
    }
    float pixel442_diffR = fabs(pixel442.x- (float)pixel_orig.x);
    float pixel442_diffG = fabs(pixel442.y- (float)pixel_orig.y);
    float pixel442_diffB = fabs(pixel442.z- (float)pixel_orig.z);
    float pixel442_diffA = fabs(pixel442.w- (float)pixel_orig.w);
   if ((pixel442_diffR<30)&& (pixel442_diffG< 30)&&(pixel442_diffB< 30 )&&(pixel442_diffA< 30)){
	    pixel_new += (pixel442)*(float)1.0; accumWeights += 1;
    }
    float pixel443_diffR = fabs(pixel443.x- (float)pixel_orig.x);
    float pixel443_diffG = fabs(pixel443.y- (float)pixel_orig.y);
    float pixel443_diffB = fabs(pixel443.z- (float)pixel_orig.z);
    float pixel443_diffA = fabs(pixel443.w- (float)pixel_orig.w);
   if ((pixel443_diffR<30)&& (pixel443_diffG< 30)&&(pixel443_diffB< 30 )&&(pixel443_diffA< 30)){
	    pixel_new += (pixel443)*(float)1.0; accumWeights += 1;
    }
    float pixel444_diffR = fabs(pixel444.x- (float)pixel_orig.x);
    float pixel444_diffG = fabs(pixel444.y- (float)pixel_orig.y);
    float pixel444_diffB = fabs(pixel444.z- (float)pixel_orig.z);
    float pixel444_diffA = fabs(pixel444.w- (float)pixel_orig.w);
   if ((pixel444_diffR<30)&& (pixel444_diffG< 30)&&(pixel444_diffB< 30 )&&(pixel444_diffA< 30)){
	    pixel_new += (pixel444)*(float)1.0; accumWeights += 1;
    }
    float pixel445_diffR = fabs(pixel445.x- (float)pixel_orig.x);
    float pixel445_diffG = fabs(pixel445.y- (float)pixel_orig.y);
    float pixel445_diffB = fabs(pixel445.z- (float)pixel_orig.z);
    float pixel445_diffA = fabs(pixel445.w- (float)pixel_orig.w);
   if ((pixel445_diffR<30)&& (pixel445_diffG< 30)&&(pixel445_diffB< 30 )&&(pixel445_diffA< 30)){
	    pixel_new += (pixel445)*(float)1.0; accumWeights += 1;
    }
    float pixel446_diffR = fabs(pixel446.x- (float)pixel_orig.x);
    float pixel446_diffG = fabs(pixel446.y- (float)pixel_orig.y);
    float pixel446_diffB = fabs(pixel446.z- (float)pixel_orig.z);
    float pixel446_diffA = fabs(pixel446.w- (float)pixel_orig.w);
   if ((pixel446_diffR<30)&& (pixel446_diffG< 30)&&(pixel446_diffB< 30 )&&(pixel446_diffA< 30)){
	    pixel_new += (pixel446)*(float)1.0; accumWeights += 1;
    }
    float pixel447_diffR = fabs(pixel447.x- (float)pixel_orig.x);
    float pixel447_diffG = fabs(pixel447.y- (float)pixel_orig.y);
    float pixel447_diffB = fabs(pixel447.z- (float)pixel_orig.z);
    float pixel447_diffA = fabs(pixel447.w- (float)pixel_orig.w);
   if ((pixel447_diffR<30)&& (pixel447_diffG< 30)&&(pixel447_diffB< 30 )&&(pixel447_diffA< 30)){
	    pixel_new += (pixel447)*(float)1.0; accumWeights += 1;
    }
    float pixel448_diffR = fabs(pixel448.x- (float)pixel_orig.x);
    float pixel448_diffG = fabs(pixel448.y- (float)pixel_orig.y);
    float pixel448_diffB = fabs(pixel448.z- (float)pixel_orig.z);
    float pixel448_diffA = fabs(pixel448.w- (float)pixel_orig.w);
   if ((pixel448_diffR<30)&& (pixel448_diffG< 30)&&(pixel448_diffB< 30 )&&(pixel448_diffA< 30)){
	    pixel_new += (pixel448)*(float)1.0; accumWeights += 1;
    }
    float pixel449_diffR = fabs(pixel449.x- (float)pixel_orig.x);
    float pixel449_diffG = fabs(pixel449.y- (float)pixel_orig.y);
    float pixel449_diffB = fabs(pixel449.z- (float)pixel_orig.z);
    float pixel449_diffA = fabs(pixel449.w- (float)pixel_orig.w);
   if ((pixel449_diffR<30)&& (pixel449_diffG< 30)&&(pixel449_diffB< 30 )&&(pixel449_diffA< 30)){
	    pixel_new += (pixel449)*(float)1.0; accumWeights += 1;
    }
    float pixel450_diffR = fabs(pixel450.x- (float)pixel_orig.x);
    float pixel450_diffG = fabs(pixel450.y- (float)pixel_orig.y);
    float pixel450_diffB = fabs(pixel450.z- (float)pixel_orig.z);
    float pixel450_diffA = fabs(pixel450.w- (float)pixel_orig.w);
   if ((pixel450_diffR<30)&& (pixel450_diffG< 30)&&(pixel450_diffB< 30 )&&(pixel450_diffA< 30)){
	    pixel_new += (pixel450)*(float)1.0; accumWeights += 1;
    }
    float pixel451_diffR = fabs(pixel451.x- (float)pixel_orig.x);
    float pixel451_diffG = fabs(pixel451.y- (float)pixel_orig.y);
    float pixel451_diffB = fabs(pixel451.z- (float)pixel_orig.z);
    float pixel451_diffA = fabs(pixel451.w- (float)pixel_orig.w);
   if ((pixel451_diffR<30)&& (pixel451_diffG< 30)&&(pixel451_diffB< 30 )&&(pixel451_diffA< 30)){
	    pixel_new += (pixel451)*(float)1.0; accumWeights += 1;
    }
    float pixel452_diffR = fabs(pixel452.x- (float)pixel_orig.x);
    float pixel452_diffG = fabs(pixel452.y- (float)pixel_orig.y);
    float pixel452_diffB = fabs(pixel452.z- (float)pixel_orig.z);
    float pixel452_diffA = fabs(pixel452.w- (float)pixel_orig.w);
   if ((pixel452_diffR<30)&& (pixel452_diffG< 30)&&(pixel452_diffB< 30 )&&(pixel452_diffA< 30)){
	    pixel_new += (pixel452)*(float)1.0; accumWeights += 1;
    }
    float pixel453_diffR = fabs(pixel453.x- (float)pixel_orig.x);
    float pixel453_diffG = fabs(pixel453.y- (float)pixel_orig.y);
    float pixel453_diffB = fabs(pixel453.z- (float)pixel_orig.z);
    float pixel453_diffA = fabs(pixel453.w- (float)pixel_orig.w);
   if ((pixel453_diffR<30)&& (pixel453_diffG< 30)&&(pixel453_diffB< 30 )&&(pixel453_diffA< 30)){
	    pixel_new += (pixel453)*(float)1.0; accumWeights += 1;
    }
    float pixel454_diffR = fabs(pixel454.x- (float)pixel_orig.x);
    float pixel454_diffG = fabs(pixel454.y- (float)pixel_orig.y);
    float pixel454_diffB = fabs(pixel454.z- (float)pixel_orig.z);
    float pixel454_diffA = fabs(pixel454.w- (float)pixel_orig.w);
   if ((pixel454_diffR<30)&& (pixel454_diffG< 30)&&(pixel454_diffB< 30 )&&(pixel454_diffA< 30)){
	    pixel_new += (pixel454)*(float)1.0; accumWeights += 1;
    }
    float pixel455_diffR = fabs(pixel455.x- (float)pixel_orig.x);
    float pixel455_diffG = fabs(pixel455.y- (float)pixel_orig.y);
    float pixel455_diffB = fabs(pixel455.z- (float)pixel_orig.z);
    float pixel455_diffA = fabs(pixel455.w- (float)pixel_orig.w);
   if ((pixel455_diffR<30)&& (pixel455_diffG< 30)&&(pixel455_diffB< 30 )&&(pixel455_diffA< 30)){
	    pixel_new += (pixel455)*(float)1.0; accumWeights += 1;
    }
    float pixel456_diffR = fabs(pixel456.x- (float)pixel_orig.x);
    float pixel456_diffG = fabs(pixel456.y- (float)pixel_orig.y);
    float pixel456_diffB = fabs(pixel456.z- (float)pixel_orig.z);
    float pixel456_diffA = fabs(pixel456.w- (float)pixel_orig.w);
   if ((pixel456_diffR<30)&& (pixel456_diffG< 30)&&(pixel456_diffB< 30 )&&(pixel456_diffA< 30)){
	    pixel_new += (pixel456)*(float)1.0; accumWeights += 1;
    }
    float pixel457_diffR = fabs(pixel457.x- (float)pixel_orig.x);
    float pixel457_diffG = fabs(pixel457.y- (float)pixel_orig.y);
    float pixel457_diffB = fabs(pixel457.z- (float)pixel_orig.z);
    float pixel457_diffA = fabs(pixel457.w- (float)pixel_orig.w);
   if ((pixel457_diffR<30)&& (pixel457_diffG< 30)&&(pixel457_diffB< 30 )&&(pixel457_diffA< 30)){
	    pixel_new += (pixel457)*(float)1.0; accumWeights += 1;
    }
    float pixel458_diffR = fabs(pixel458.x- (float)pixel_orig.x);
    float pixel458_diffG = fabs(pixel458.y- (float)pixel_orig.y);
    float pixel458_diffB = fabs(pixel458.z- (float)pixel_orig.z);
    float pixel458_diffA = fabs(pixel458.w- (float)pixel_orig.w);
   if ((pixel458_diffR<30)&& (pixel458_diffG< 30)&&(pixel458_diffB< 30 )&&(pixel458_diffA< 30)){
	    pixel_new += (pixel458)*(float)1.0; accumWeights += 1;
    }
    float pixel459_diffR = fabs(pixel459.x- (float)pixel_orig.x);
    float pixel459_diffG = fabs(pixel459.y- (float)pixel_orig.y);
    float pixel459_diffB = fabs(pixel459.z- (float)pixel_orig.z);
    float pixel459_diffA = fabs(pixel459.w- (float)pixel_orig.w);
   if ((pixel459_diffR<30)&& (pixel459_diffG< 30)&&(pixel459_diffB< 30 )&&(pixel459_diffA< 30)){
	    pixel_new += (pixel459)*(float)1.0; accumWeights += 1;
    }
    float pixel460_diffR = fabs(pixel460.x- (float)pixel_orig.x);
    float pixel460_diffG = fabs(pixel460.y- (float)pixel_orig.y);
    float pixel460_diffB = fabs(pixel460.z- (float)pixel_orig.z);
    float pixel460_diffA = fabs(pixel460.w- (float)pixel_orig.w);
   if ((pixel460_diffR<30)&& (pixel460_diffG< 30)&&(pixel460_diffB< 30 )&&(pixel460_diffA< 30)){
	    pixel_new += (pixel460)*(float)1.0; accumWeights += 1;
    }
    float pixel461_diffR = fabs(pixel461.x- (float)pixel_orig.x);
    float pixel461_diffG = fabs(pixel461.y- (float)pixel_orig.y);
    float pixel461_diffB = fabs(pixel461.z- (float)pixel_orig.z);
    float pixel461_diffA = fabs(pixel461.w- (float)pixel_orig.w);
   if ((pixel461_diffR<30)&& (pixel461_diffG< 30)&&(pixel461_diffB< 30 )&&(pixel461_diffA< 30)){
	    pixel_new += (pixel461)*(float)1.0; accumWeights += 1;
    }
    float pixel462_diffR = fabs(pixel462.x- (float)pixel_orig.x);
    float pixel462_diffG = fabs(pixel462.y- (float)pixel_orig.y);
    float pixel462_diffB = fabs(pixel462.z- (float)pixel_orig.z);
    float pixel462_diffA = fabs(pixel462.w- (float)pixel_orig.w);
   if ((pixel462_diffR<30)&& (pixel462_diffG< 30)&&(pixel462_diffB< 30 )&&(pixel462_diffA< 30)){
	    pixel_new += (pixel462)*(float)1.0; accumWeights += 1;
    }
    float pixel463_diffR = fabs(pixel463.x- (float)pixel_orig.x);
    float pixel463_diffG = fabs(pixel463.y- (float)pixel_orig.y);
    float pixel463_diffB = fabs(pixel463.z- (float)pixel_orig.z);
    float pixel463_diffA = fabs(pixel463.w- (float)pixel_orig.w);
   if ((pixel463_diffR<30)&& (pixel463_diffG< 30)&&(pixel463_diffB< 30 )&&(pixel463_diffA< 30)){
	    pixel_new += (pixel463)*(float)1.0; accumWeights += 1;
    }
    float pixel464_diffR = fabs(pixel464.x- (float)pixel_orig.x);
    float pixel464_diffG = fabs(pixel464.y- (float)pixel_orig.y);
    float pixel464_diffB = fabs(pixel464.z- (float)pixel_orig.z);
    float pixel464_diffA = fabs(pixel464.w- (float)pixel_orig.w);
   if ((pixel464_diffR<30)&& (pixel464_diffG< 30)&&(pixel464_diffB< 30 )&&(pixel464_diffA< 30)){
	    pixel_new += (pixel464)*(float)1.0; accumWeights += 1;
    }
    float pixel465_diffR = fabs(pixel465.x- (float)pixel_orig.x);
    float pixel465_diffG = fabs(pixel465.y- (float)pixel_orig.y);
    float pixel465_diffB = fabs(pixel465.z- (float)pixel_orig.z);
    float pixel465_diffA = fabs(pixel465.w- (float)pixel_orig.w);
   if ((pixel465_diffR<30)&& (pixel465_diffG< 30)&&(pixel465_diffB< 30 )&&(pixel465_diffA< 30)){
	    pixel_new += (pixel465)*(float)1.0; accumWeights += 1;
    }
    float pixel466_diffR = fabs(pixel466.x- (float)pixel_orig.x);
    float pixel466_diffG = fabs(pixel466.y- (float)pixel_orig.y);
    float pixel466_diffB = fabs(pixel466.z- (float)pixel_orig.z);
    float pixel466_diffA = fabs(pixel466.w- (float)pixel_orig.w);
   if ((pixel466_diffR<30)&& (pixel466_diffG< 30)&&(pixel466_diffB< 30 )&&(pixel466_diffA< 30)){
	    pixel_new += (pixel466)*(float)1.0; accumWeights += 1;
    }
    float pixel467_diffR = fabs(pixel467.x- (float)pixel_orig.x);
    float pixel467_diffG = fabs(pixel467.y- (float)pixel_orig.y);
    float pixel467_diffB = fabs(pixel467.z- (float)pixel_orig.z);
    float pixel467_diffA = fabs(pixel467.w- (float)pixel_orig.w);
   if ((pixel467_diffR<30)&& (pixel467_diffG< 30)&&(pixel467_diffB< 30 )&&(pixel467_diffA< 30)){
	    pixel_new += (pixel467)*(float)1.0; accumWeights += 1;
    }
    float pixel468_diffR = fabs(pixel468.x- (float)pixel_orig.x);
    float pixel468_diffG = fabs(pixel468.y- (float)pixel_orig.y);
    float pixel468_diffB = fabs(pixel468.z- (float)pixel_orig.z);
    float pixel468_diffA = fabs(pixel468.w- (float)pixel_orig.w);
   if ((pixel468_diffR<30)&& (pixel468_diffG< 30)&&(pixel468_diffB< 30 )&&(pixel468_diffA< 30)){
	    pixel_new += (pixel468)*(float)1.0; accumWeights += 1;
    }
    float pixel469_diffR = fabs(pixel469.x- (float)pixel_orig.x);
    float pixel469_diffG = fabs(pixel469.y- (float)pixel_orig.y);
    float pixel469_diffB = fabs(pixel469.z- (float)pixel_orig.z);
    float pixel469_diffA = fabs(pixel469.w- (float)pixel_orig.w);
   if ((pixel469_diffR<30)&& (pixel469_diffG< 30)&&(pixel469_diffB< 30 )&&(pixel469_diffA< 30)){
	    pixel_new += (pixel469)*(float)1.0; accumWeights += 1;
    }
    float pixel470_diffR = fabs(pixel470.x- (float)pixel_orig.x);
    float pixel470_diffG = fabs(pixel470.y- (float)pixel_orig.y);
    float pixel470_diffB = fabs(pixel470.z- (float)pixel_orig.z);
    float pixel470_diffA = fabs(pixel470.w- (float)pixel_orig.w);
   if ((pixel470_diffR<30)&& (pixel470_diffG< 30)&&(pixel470_diffB< 30 )&&(pixel470_diffA< 30)){
	    pixel_new += (pixel470)*(float)1.0; accumWeights += 1;
    }
    float pixel471_diffR = fabs(pixel471.x- (float)pixel_orig.x);
    float pixel471_diffG = fabs(pixel471.y- (float)pixel_orig.y);
    float pixel471_diffB = fabs(pixel471.z- (float)pixel_orig.z);
    float pixel471_diffA = fabs(pixel471.w- (float)pixel_orig.w);
   if ((pixel471_diffR<30)&& (pixel471_diffG< 30)&&(pixel471_diffB< 30 )&&(pixel471_diffA< 30)){
	    pixel_new += (pixel471)*(float)1.0; accumWeights += 1;
    }
    float pixel472_diffR = fabs(pixel472.x- (float)pixel_orig.x);
    float pixel472_diffG = fabs(pixel472.y- (float)pixel_orig.y);
    float pixel472_diffB = fabs(pixel472.z- (float)pixel_orig.z);
    float pixel472_diffA = fabs(pixel472.w- (float)pixel_orig.w);
   if ((pixel472_diffR<30)&& (pixel472_diffG< 30)&&(pixel472_diffB< 30 )&&(pixel472_diffA< 30)){
	    pixel_new += (pixel472)*(float)1.0; accumWeights += 1;
    }
    float pixel473_diffR = fabs(pixel473.x- (float)pixel_orig.x);
    float pixel473_diffG = fabs(pixel473.y- (float)pixel_orig.y);
    float pixel473_diffB = fabs(pixel473.z- (float)pixel_orig.z);
    float pixel473_diffA = fabs(pixel473.w- (float)pixel_orig.w);
   if ((pixel473_diffR<30)&& (pixel473_diffG< 30)&&(pixel473_diffB< 30 )&&(pixel473_diffA< 30)){
	    pixel_new += (pixel473)*(float)1.0; accumWeights += 1;
    }
    float pixel474_diffR = fabs(pixel474.x- (float)pixel_orig.x);
    float pixel474_diffG = fabs(pixel474.y- (float)pixel_orig.y);
    float pixel474_diffB = fabs(pixel474.z- (float)pixel_orig.z);
    float pixel474_diffA = fabs(pixel474.w- (float)pixel_orig.w);
   if ((pixel474_diffR<30)&& (pixel474_diffG< 30)&&(pixel474_diffB< 30 )&&(pixel474_diffA< 30)){
	    pixel_new += (pixel474)*(float)1.0; accumWeights += 1;
    }
    float pixel475_diffR = fabs(pixel475.x- (float)pixel_orig.x);
    float pixel475_diffG = fabs(pixel475.y- (float)pixel_orig.y);
    float pixel475_diffB = fabs(pixel475.z- (float)pixel_orig.z);
    float pixel475_diffA = fabs(pixel475.w- (float)pixel_orig.w);
   if ((pixel475_diffR<30)&& (pixel475_diffG< 30)&&(pixel475_diffB< 30 )&&(pixel475_diffA< 30)){
	    pixel_new += (pixel475)*(float)1.0; accumWeights += 1;
    }
    float pixel476_diffR = fabs(pixel476.x- (float)pixel_orig.x);
    float pixel476_diffG = fabs(pixel476.y- (float)pixel_orig.y);
    float pixel476_diffB = fabs(pixel476.z- (float)pixel_orig.z);
    float pixel476_diffA = fabs(pixel476.w- (float)pixel_orig.w);
   if ((pixel476_diffR<30)&& (pixel476_diffG< 30)&&(pixel476_diffB< 30 )&&(pixel476_diffA< 30)){
	    pixel_new += (pixel476)*(float)1.0; accumWeights += 1;
    }
    float pixel477_diffR = fabs(pixel477.x- (float)pixel_orig.x);
    float pixel477_diffG = fabs(pixel477.y- (float)pixel_orig.y);
    float pixel477_diffB = fabs(pixel477.z- (float)pixel_orig.z);
    float pixel477_diffA = fabs(pixel477.w- (float)pixel_orig.w);
   if ((pixel477_diffR<30)&& (pixel477_diffG< 30)&&(pixel477_diffB< 30 )&&(pixel477_diffA< 30)){
	    pixel_new += (pixel477)*(float)1.0; accumWeights += 1;
    }
    float pixel478_diffR = fabs(pixel478.x- (float)pixel_orig.x);
    float pixel478_diffG = fabs(pixel478.y- (float)pixel_orig.y);
    float pixel478_diffB = fabs(pixel478.z- (float)pixel_orig.z);
    float pixel478_diffA = fabs(pixel478.w- (float)pixel_orig.w);
   if ((pixel478_diffR<30)&& (pixel478_diffG< 30)&&(pixel478_diffB< 30 )&&(pixel478_diffA< 30)){
	    pixel_new += (pixel478)*(float)1.0; accumWeights += 1;
    }
    float pixel479_diffR = fabs(pixel479.x- (float)pixel_orig.x);
    float pixel479_diffG = fabs(pixel479.y- (float)pixel_orig.y);
    float pixel479_diffB = fabs(pixel479.z- (float)pixel_orig.z);
    float pixel479_diffA = fabs(pixel479.w- (float)pixel_orig.w);
   if ((pixel479_diffR<30)&& (pixel479_diffG< 30)&&(pixel479_diffB< 30 )&&(pixel479_diffA< 30)){
	    pixel_new += (pixel479)*(float)1.0; accumWeights += 1;
    }
    float pixel480_diffR = fabs(pixel480.x- (float)pixel_orig.x);
    float pixel480_diffG = fabs(pixel480.y- (float)pixel_orig.y);
    float pixel480_diffB = fabs(pixel480.z- (float)pixel_orig.z);
    float pixel480_diffA = fabs(pixel480.w- (float)pixel_orig.w);
   if ((pixel480_diffR<30)&& (pixel480_diffG< 30)&&(pixel480_diffB< 30 )&&(pixel480_diffA< 30)){
	    pixel_new += (pixel480)*(float)1.0; accumWeights += 1;
    }
    float pixel481_diffR = fabs(pixel481.x- (float)pixel_orig.x);
    float pixel481_diffG = fabs(pixel481.y- (float)pixel_orig.y);
    float pixel481_diffB = fabs(pixel481.z- (float)pixel_orig.z);
    float pixel481_diffA = fabs(pixel481.w- (float)pixel_orig.w);
   if ((pixel481_diffR<30)&& (pixel481_diffG< 30)&&(pixel481_diffB< 30 )&&(pixel481_diffA< 30)){
	    pixel_new += (pixel481)*(float)1.0; accumWeights += 1;
    }
    float pixel482_diffR = fabs(pixel482.x- (float)pixel_orig.x);
    float pixel482_diffG = fabs(pixel482.y- (float)pixel_orig.y);
    float pixel482_diffB = fabs(pixel482.z- (float)pixel_orig.z);
    float pixel482_diffA = fabs(pixel482.w- (float)pixel_orig.w);
   if ((pixel482_diffR<30)&& (pixel482_diffG< 30)&&(pixel482_diffB< 30 )&&(pixel482_diffA< 30)){
	    pixel_new += (pixel482)*(float)1.0; accumWeights += 1;
    }
    float pixel483_diffR = fabs(pixel483.x- (float)pixel_orig.x);
    float pixel483_diffG = fabs(pixel483.y- (float)pixel_orig.y);
    float pixel483_diffB = fabs(pixel483.z- (float)pixel_orig.z);
    float pixel483_diffA = fabs(pixel483.w- (float)pixel_orig.w);
   if ((pixel483_diffR<30)&& (pixel483_diffG< 30)&&(pixel483_diffB< 30 )&&(pixel483_diffA< 30)){
	    pixel_new += (pixel483)*(float)1.0; accumWeights += 1;
    }
    float pixel484_diffR = fabs(pixel484.x- (float)pixel_orig.x);
    float pixel484_diffG = fabs(pixel484.y- (float)pixel_orig.y);
    float pixel484_diffB = fabs(pixel484.z- (float)pixel_orig.z);
    float pixel484_diffA = fabs(pixel484.w- (float)pixel_orig.w);
   if ((pixel484_diffR<30)&& (pixel484_diffG< 30)&&(pixel484_diffB< 30 )&&(pixel484_diffA< 30)){
	    pixel_new += (pixel484)*(float)1.0; accumWeights += 1;
    }
    float pixel485_diffR = fabs(pixel485.x- (float)pixel_orig.x);
    float pixel485_diffG = fabs(pixel485.y- (float)pixel_orig.y);
    float pixel485_diffB = fabs(pixel485.z- (float)pixel_orig.z);
    float pixel485_diffA = fabs(pixel485.w- (float)pixel_orig.w);
   if ((pixel485_diffR<30)&& (pixel485_diffG< 30)&&(pixel485_diffB< 30 )&&(pixel485_diffA< 30)){
	    pixel_new += (pixel485)*(float)1.0; accumWeights += 1;
    }
    float pixel486_diffR = fabs(pixel486.x- (float)pixel_orig.x);
    float pixel486_diffG = fabs(pixel486.y- (float)pixel_orig.y);
    float pixel486_diffB = fabs(pixel486.z- (float)pixel_orig.z);
    float pixel486_diffA = fabs(pixel486.w- (float)pixel_orig.w);
   if ((pixel486_diffR<30)&& (pixel486_diffG< 30)&&(pixel486_diffB< 30 )&&(pixel486_diffA< 30)){
	    pixel_new += (pixel486)*(float)1.0; accumWeights += 1;
    }
    float pixel487_diffR = fabs(pixel487.x- (float)pixel_orig.x);
    float pixel487_diffG = fabs(pixel487.y- (float)pixel_orig.y);
    float pixel487_diffB = fabs(pixel487.z- (float)pixel_orig.z);
    float pixel487_diffA = fabs(pixel487.w- (float)pixel_orig.w);
   if ((pixel487_diffR<30)&& (pixel487_diffG< 30)&&(pixel487_diffB< 30 )&&(pixel487_diffA< 30)){
	    pixel_new += (pixel487)*(float)1.0; accumWeights += 1;
    }
    float pixel488_diffR = fabs(pixel488.x- (float)pixel_orig.x);
    float pixel488_diffG = fabs(pixel488.y- (float)pixel_orig.y);
    float pixel488_diffB = fabs(pixel488.z- (float)pixel_orig.z);
    float pixel488_diffA = fabs(pixel488.w- (float)pixel_orig.w);
   if ((pixel488_diffR<30)&& (pixel488_diffG< 30)&&(pixel488_diffB< 30 )&&(pixel488_diffA< 30)){
	    pixel_new += (pixel488)*(float)1.0; accumWeights += 1;
    }
    float pixel489_diffR = fabs(pixel489.x- (float)pixel_orig.x);
    float pixel489_diffG = fabs(pixel489.y- (float)pixel_orig.y);
    float pixel489_diffB = fabs(pixel489.z- (float)pixel_orig.z);
    float pixel489_diffA = fabs(pixel489.w- (float)pixel_orig.w);
   if ((pixel489_diffR<30)&& (pixel489_diffG< 30)&&(pixel489_diffB< 30 )&&(pixel489_diffA< 30)){
	    pixel_new += (pixel489)*(float)1.0; accumWeights += 1;
    }
    float pixel490_diffR = fabs(pixel490.x- (float)pixel_orig.x);
    float pixel490_diffG = fabs(pixel490.y- (float)pixel_orig.y);
    float pixel490_diffB = fabs(pixel490.z- (float)pixel_orig.z);
    float pixel490_diffA = fabs(pixel490.w- (float)pixel_orig.w);
   if ((pixel490_diffR<30)&& (pixel490_diffG< 30)&&(pixel490_diffB< 30 )&&(pixel490_diffA< 30)){
	    pixel_new += (pixel490)*(float)1.0; accumWeights += 1;
    }
    float pixel491_diffR = fabs(pixel491.x- (float)pixel_orig.x);
    float pixel491_diffG = fabs(pixel491.y- (float)pixel_orig.y);
    float pixel491_diffB = fabs(pixel491.z- (float)pixel_orig.z);
    float pixel491_diffA = fabs(pixel491.w- (float)pixel_orig.w);
   if ((pixel491_diffR<30)&& (pixel491_diffG< 30)&&(pixel491_diffB< 30 )&&(pixel491_diffA< 30)){
	    pixel_new += (pixel491)*(float)1.0; accumWeights += 1;
    }
    float pixel492_diffR = fabs(pixel492.x- (float)pixel_orig.x);
    float pixel492_diffG = fabs(pixel492.y- (float)pixel_orig.y);
    float pixel492_diffB = fabs(pixel492.z- (float)pixel_orig.z);
    float pixel492_diffA = fabs(pixel492.w- (float)pixel_orig.w);
   if ((pixel492_diffR<30)&& (pixel492_diffG< 30)&&(pixel492_diffB< 30 )&&(pixel492_diffA< 30)){
	    pixel_new += (pixel492)*(float)1.0; accumWeights += 1;
    }
    float pixel493_diffR = fabs(pixel493.x- (float)pixel_orig.x);
    float pixel493_diffG = fabs(pixel493.y- (float)pixel_orig.y);
    float pixel493_diffB = fabs(pixel493.z- (float)pixel_orig.z);
    float pixel493_diffA = fabs(pixel493.w- (float)pixel_orig.w);
   if ((pixel493_diffR<30)&& (pixel493_diffG< 30)&&(pixel493_diffB< 30 )&&(pixel493_diffA< 30)){
	    pixel_new += (pixel493)*(float)1.0; accumWeights += 1;
    }
    float pixel494_diffR = fabs(pixel494.x- (float)pixel_orig.x);
    float pixel494_diffG = fabs(pixel494.y- (float)pixel_orig.y);
    float pixel494_diffB = fabs(pixel494.z- (float)pixel_orig.z);
    float pixel494_diffA = fabs(pixel494.w- (float)pixel_orig.w);
   if ((pixel494_diffR<30)&& (pixel494_diffG< 30)&&(pixel494_diffB< 30 )&&(pixel494_diffA< 30)){
	    pixel_new += (pixel494)*(float)1.0; accumWeights += 1;
    }
    float pixel495_diffR = fabs(pixel495.x- (float)pixel_orig.x);
    float pixel495_diffG = fabs(pixel495.y- (float)pixel_orig.y);
    float pixel495_diffB = fabs(pixel495.z- (float)pixel_orig.z);
    float pixel495_diffA = fabs(pixel495.w- (float)pixel_orig.w);
   if ((pixel495_diffR<30)&& (pixel495_diffG< 30)&&(pixel495_diffB< 30 )&&(pixel495_diffA< 30)){
	    pixel_new += (pixel495)*(float)1.0; accumWeights += 1;
    }
    float pixel496_diffR = fabs(pixel496.x- (float)pixel_orig.x);
    float pixel496_diffG = fabs(pixel496.y- (float)pixel_orig.y);
    float pixel496_diffB = fabs(pixel496.z- (float)pixel_orig.z);
    float pixel496_diffA = fabs(pixel496.w- (float)pixel_orig.w);
   if ((pixel496_diffR<30)&& (pixel496_diffG< 30)&&(pixel496_diffB< 30 )&&(pixel496_diffA< 30)){
	    pixel_new += (pixel496)*(float)1.0; accumWeights += 1;
    }
    float pixel497_diffR = fabs(pixel497.x- (float)pixel_orig.x);
    float pixel497_diffG = fabs(pixel497.y- (float)pixel_orig.y);
    float pixel497_diffB = fabs(pixel497.z- (float)pixel_orig.z);
    float pixel497_diffA = fabs(pixel497.w- (float)pixel_orig.w);
   if ((pixel497_diffR<30)&& (pixel497_diffG< 30)&&(pixel497_diffB< 30 )&&(pixel497_diffA< 30)){
	    pixel_new += (pixel497)*(float)1.0; accumWeights += 1;
    }
    float pixel498_diffR = fabs(pixel498.x- (float)pixel_orig.x);
    float pixel498_diffG = fabs(pixel498.y- (float)pixel_orig.y);
    float pixel498_diffB = fabs(pixel498.z- (float)pixel_orig.z);
    float pixel498_diffA = fabs(pixel498.w- (float)pixel_orig.w);
   if ((pixel498_diffR<30)&& (pixel498_diffG< 30)&&(pixel498_diffB< 30 )&&(pixel498_diffA< 30)){
	    pixel_new += (pixel498)*(float)1.0; accumWeights += 1;
    }
    float pixel499_diffR = fabs(pixel499.x- (float)pixel_orig.x);
    float pixel499_diffG = fabs(pixel499.y- (float)pixel_orig.y);
    float pixel499_diffB = fabs(pixel499.z- (float)pixel_orig.z);
    float pixel499_diffA = fabs(pixel499.w- (float)pixel_orig.w);
   if ((pixel499_diffR<30)&& (pixel499_diffG< 30)&&(pixel499_diffB< 30 )&&(pixel499_diffA< 30)){
	    pixel_new += (pixel499)*(float)1.0; accumWeights += 1;
    }
    float pixel500_diffR = fabs(pixel500.x- (float)pixel_orig.x);
    float pixel500_diffG = fabs(pixel500.y- (float)pixel_orig.y);
    float pixel500_diffB = fabs(pixel500.z- (float)pixel_orig.z);
    float pixel500_diffA = fabs(pixel500.w- (float)pixel_orig.w);
   if ((pixel500_diffR<30)&& (pixel500_diffG< 30)&&(pixel500_diffB< 30 )&&(pixel500_diffA< 30)){
	    pixel_new += (pixel500)*(float)1.0; accumWeights += 1;
    }
    float pixel501_diffR = fabs(pixel501.x- (float)pixel_orig.x);
    float pixel501_diffG = fabs(pixel501.y- (float)pixel_orig.y);
    float pixel501_diffB = fabs(pixel501.z- (float)pixel_orig.z);
    float pixel501_diffA = fabs(pixel501.w- (float)pixel_orig.w);
   if ((pixel501_diffR<30)&& (pixel501_diffG< 30)&&(pixel501_diffB< 30 )&&(pixel501_diffA< 30)){
	    pixel_new += (pixel501)*(float)1.0; accumWeights += 1;
    }
    float pixel502_diffR = fabs(pixel502.x- (float)pixel_orig.x);
    float pixel502_diffG = fabs(pixel502.y- (float)pixel_orig.y);
    float pixel502_diffB = fabs(pixel502.z- (float)pixel_orig.z);
    float pixel502_diffA = fabs(pixel502.w- (float)pixel_orig.w);
   if ((pixel502_diffR<30)&& (pixel502_diffG< 30)&&(pixel502_diffB< 30 )&&(pixel502_diffA< 30)){
	    pixel_new += (pixel502)*(float)1.0; accumWeights += 1;
    }
    float pixel503_diffR = fabs(pixel503.x- (float)pixel_orig.x);
    float pixel503_diffG = fabs(pixel503.y- (float)pixel_orig.y);
    float pixel503_diffB = fabs(pixel503.z- (float)pixel_orig.z);
    float pixel503_diffA = fabs(pixel503.w- (float)pixel_orig.w);
   if ((pixel503_diffR<30)&& (pixel503_diffG< 30)&&(pixel503_diffB< 30 )&&(pixel503_diffA< 30)){
	    pixel_new += (pixel503)*(float)1.0; accumWeights += 1;
    }
    float pixel504_diffR = fabs(pixel504.x- (float)pixel_orig.x);
    float pixel504_diffG = fabs(pixel504.y- (float)pixel_orig.y);
    float pixel504_diffB = fabs(pixel504.z- (float)pixel_orig.z);
    float pixel504_diffA = fabs(pixel504.w- (float)pixel_orig.w);
   if ((pixel504_diffR<30)&& (pixel504_diffG< 30)&&(pixel504_diffB< 30 )&&(pixel504_diffA< 30)){
	    pixel_new += (pixel504)*(float)1.0; accumWeights += 1;
    }
    float pixel505_diffR = fabs(pixel505.x- (float)pixel_orig.x);
    float pixel505_diffG = fabs(pixel505.y- (float)pixel_orig.y);
    float pixel505_diffB = fabs(pixel505.z- (float)pixel_orig.z);
    float pixel505_diffA = fabs(pixel505.w- (float)pixel_orig.w);
   if ((pixel505_diffR<30)&& (pixel505_diffG< 30)&&(pixel505_diffB< 30 )&&(pixel505_diffA< 30)){
	    pixel_new += (pixel505)*(float)1.0; accumWeights += 1;
    }
    float pixel506_diffR = fabs(pixel506.x- (float)pixel_orig.x);
    float pixel506_diffG = fabs(pixel506.y- (float)pixel_orig.y);
    float pixel506_diffB = fabs(pixel506.z- (float)pixel_orig.z);
    float pixel506_diffA = fabs(pixel506.w- (float)pixel_orig.w);
   if ((pixel506_diffR<30)&& (pixel506_diffG< 30)&&(pixel506_diffB< 30 )&&(pixel506_diffA< 30)){
	    pixel_new += (pixel506)*(float)1.0; accumWeights += 1;
    }
    float pixel507_diffR = fabs(pixel507.x- (float)pixel_orig.x);
    float pixel507_diffG = fabs(pixel507.y- (float)pixel_orig.y);
    float pixel507_diffB = fabs(pixel507.z- (float)pixel_orig.z);
    float pixel507_diffA = fabs(pixel507.w- (float)pixel_orig.w);
   if ((pixel507_diffR<30)&& (pixel507_diffG< 30)&&(pixel507_diffB< 30 )&&(pixel507_diffA< 30)){
	    pixel_new += (pixel507)*(float)1.0; accumWeights += 1;
    }
    float pixel508_diffR = fabs(pixel508.x- (float)pixel_orig.x);
    float pixel508_diffG = fabs(pixel508.y- (float)pixel_orig.y);
    float pixel508_diffB = fabs(pixel508.z- (float)pixel_orig.z);
    float pixel508_diffA = fabs(pixel508.w- (float)pixel_orig.w);
   if ((pixel508_diffR<30)&& (pixel508_diffG< 30)&&(pixel508_diffB< 30 )&&(pixel508_diffA< 30)){
	    pixel_new += (pixel508)*(float)1.0; accumWeights += 1;
    }
    float pixel509_diffR = fabs(pixel509.x- (float)pixel_orig.x);
    float pixel509_diffG = fabs(pixel509.y- (float)pixel_orig.y);
    float pixel509_diffB = fabs(pixel509.z- (float)pixel_orig.z);
    float pixel509_diffA = fabs(pixel509.w- (float)pixel_orig.w);
   if ((pixel509_diffR<30)&& (pixel509_diffG< 30)&&(pixel509_diffB< 30 )&&(pixel509_diffA< 30)){
	    pixel_new += (pixel509)*(float)1.0; accumWeights += 1;
    }
    float pixel510_diffR = fabs(pixel510.x- (float)pixel_orig.x);
    float pixel510_diffG = fabs(pixel510.y- (float)pixel_orig.y);
    float pixel510_diffB = fabs(pixel510.z- (float)pixel_orig.z);
    float pixel510_diffA = fabs(pixel510.w- (float)pixel_orig.w);
   if ((pixel510_diffR<30)&& (pixel510_diffG< 30)&&(pixel510_diffB< 30 )&&(pixel510_diffA< 30)){
	    pixel_new += (pixel510)*(float)1.0; accumWeights += 1;
    }
    float pixel511_diffR = fabs(pixel511.x- (float)pixel_orig.x);
    float pixel511_diffG = fabs(pixel511.y- (float)pixel_orig.y);
    float pixel511_diffB = fabs(pixel511.z- (float)pixel_orig.z);
    float pixel511_diffA = fabs(pixel511.w- (float)pixel_orig.w);
   if ((pixel511_diffR<30)&& (pixel511_diffG< 30)&&(pixel511_diffB< 30 )&&(pixel511_diffA< 30)){
	    pixel_new += (pixel511)*(float)1.0; accumWeights += 1;
    }
    float pixel512_diffR = fabs(pixel512.x- (float)pixel_orig.x);
    float pixel512_diffG = fabs(pixel512.y- (float)pixel_orig.y);
    float pixel512_diffB = fabs(pixel512.z- (float)pixel_orig.z);
    float pixel512_diffA = fabs(pixel512.w- (float)pixel_orig.w);
   if ((pixel512_diffR<30)&& (pixel512_diffG< 30)&&(pixel512_diffB< 30 )&&(pixel512_diffA< 30)){
	    pixel_new += (pixel512)*(float)1.0; accumWeights += 1;
    }
    float pixel513_diffR = fabs(pixel513.x- (float)pixel_orig.x);
    float pixel513_diffG = fabs(pixel513.y- (float)pixel_orig.y);
    float pixel513_diffB = fabs(pixel513.z- (float)pixel_orig.z);
    float pixel513_diffA = fabs(pixel513.w- (float)pixel_orig.w);
   if ((pixel513_diffR<30)&& (pixel513_diffG< 30)&&(pixel513_diffB< 30 )&&(pixel513_diffA< 30)){
	    pixel_new += (pixel513)*(float)1.0; accumWeights += 1;
    }
    float pixel514_diffR = fabs(pixel514.x- (float)pixel_orig.x);
    float pixel514_diffG = fabs(pixel514.y- (float)pixel_orig.y);
    float pixel514_diffB = fabs(pixel514.z- (float)pixel_orig.z);
    float pixel514_diffA = fabs(pixel514.w- (float)pixel_orig.w);
   if ((pixel514_diffR<30)&& (pixel514_diffG< 30)&&(pixel514_diffB< 30 )&&(pixel514_diffA< 30)){
	    pixel_new += (pixel514)*(float)1.0; accumWeights += 1;
    }
    float pixel515_diffR = fabs(pixel515.x- (float)pixel_orig.x);
    float pixel515_diffG = fabs(pixel515.y- (float)pixel_orig.y);
    float pixel515_diffB = fabs(pixel515.z- (float)pixel_orig.z);
    float pixel515_diffA = fabs(pixel515.w- (float)pixel_orig.w);
   if ((pixel515_diffR<30)&& (pixel515_diffG< 30)&&(pixel515_diffB< 30 )&&(pixel515_diffA< 30)){
	    pixel_new += (pixel515)*(float)1.0; accumWeights += 1;
    }
    float pixel516_diffR = fabs(pixel516.x- (float)pixel_orig.x);
    float pixel516_diffG = fabs(pixel516.y- (float)pixel_orig.y);
    float pixel516_diffB = fabs(pixel516.z- (float)pixel_orig.z);
    float pixel516_diffA = fabs(pixel516.w- (float)pixel_orig.w);
   if ((pixel516_diffR<30)&& (pixel516_diffG< 30)&&(pixel516_diffB< 30 )&&(pixel516_diffA< 30)){
	    pixel_new += (pixel516)*(float)1.0; accumWeights += 1;
    }
    float pixel517_diffR = fabs(pixel517.x- (float)pixel_orig.x);
    float pixel517_diffG = fabs(pixel517.y- (float)pixel_orig.y);
    float pixel517_diffB = fabs(pixel517.z- (float)pixel_orig.z);
    float pixel517_diffA = fabs(pixel517.w- (float)pixel_orig.w);
   if ((pixel517_diffR<30)&& (pixel517_diffG< 30)&&(pixel517_diffB< 30 )&&(pixel517_diffA< 30)){
	    pixel_new += (pixel517)*(float)1.0; accumWeights += 1;
    }
    float pixel518_diffR = fabs(pixel518.x- (float)pixel_orig.x);
    float pixel518_diffG = fabs(pixel518.y- (float)pixel_orig.y);
    float pixel518_diffB = fabs(pixel518.z- (float)pixel_orig.z);
    float pixel518_diffA = fabs(pixel518.w- (float)pixel_orig.w);
   if ((pixel518_diffR<30)&& (pixel518_diffG< 30)&&(pixel518_diffB< 30 )&&(pixel518_diffA< 30)){
	    pixel_new += (pixel518)*(float)1.0; accumWeights += 1;
    }
    float pixel519_diffR = fabs(pixel519.x- (float)pixel_orig.x);
    float pixel519_diffG = fabs(pixel519.y- (float)pixel_orig.y);
    float pixel519_diffB = fabs(pixel519.z- (float)pixel_orig.z);
    float pixel519_diffA = fabs(pixel519.w- (float)pixel_orig.w);
   if ((pixel519_diffR<30)&& (pixel519_diffG< 30)&&(pixel519_diffB< 30 )&&(pixel519_diffA< 30)){
	    pixel_new += (pixel519)*(float)1.0; accumWeights += 1;
    }
    float pixel520_diffR = fabs(pixel520.x- (float)pixel_orig.x);
    float pixel520_diffG = fabs(pixel520.y- (float)pixel_orig.y);
    float pixel520_diffB = fabs(pixel520.z- (float)pixel_orig.z);
    float pixel520_diffA = fabs(pixel520.w- (float)pixel_orig.w);
   if ((pixel520_diffR<30)&& (pixel520_diffG< 30)&&(pixel520_diffB< 30 )&&(pixel520_diffA< 30)){
	    pixel_new += (pixel520)*(float)1.0; accumWeights += 1;
    }
    float pixel521_diffR = fabs(pixel521.x- (float)pixel_orig.x);
    float pixel521_diffG = fabs(pixel521.y- (float)pixel_orig.y);
    float pixel521_diffB = fabs(pixel521.z- (float)pixel_orig.z);
    float pixel521_diffA = fabs(pixel521.w- (float)pixel_orig.w);
   if ((pixel521_diffR<30)&& (pixel521_diffG< 30)&&(pixel521_diffB< 30 )&&(pixel521_diffA< 30)){
	    pixel_new += (pixel521)*(float)1.0; accumWeights += 1;
    }
    float pixel522_diffR = fabs(pixel522.x- (float)pixel_orig.x);
    float pixel522_diffG = fabs(pixel522.y- (float)pixel_orig.y);
    float pixel522_diffB = fabs(pixel522.z- (float)pixel_orig.z);
    float pixel522_diffA = fabs(pixel522.w- (float)pixel_orig.w);
   if ((pixel522_diffR<30)&& (pixel522_diffG< 30)&&(pixel522_diffB< 30 )&&(pixel522_diffA< 30)){
	    pixel_new += (pixel522)*(float)1.0; accumWeights += 1;
    }
    float pixel523_diffR = fabs(pixel523.x- (float)pixel_orig.x);
    float pixel523_diffG = fabs(pixel523.y- (float)pixel_orig.y);
    float pixel523_diffB = fabs(pixel523.z- (float)pixel_orig.z);
    float pixel523_diffA = fabs(pixel523.w- (float)pixel_orig.w);
   if ((pixel523_diffR<30)&& (pixel523_diffG< 30)&&(pixel523_diffB< 30 )&&(pixel523_diffA< 30)){
	    pixel_new += (pixel523)*(float)1.0; accumWeights += 1;
    }
    float pixel524_diffR = fabs(pixel524.x- (float)pixel_orig.x);
    float pixel524_diffG = fabs(pixel524.y- (float)pixel_orig.y);
    float pixel524_diffB = fabs(pixel524.z- (float)pixel_orig.z);
    float pixel524_diffA = fabs(pixel524.w- (float)pixel_orig.w);
   if ((pixel524_diffR<30)&& (pixel524_diffG< 30)&&(pixel524_diffB< 30 )&&(pixel524_diffA< 30)){
	    pixel_new += (pixel524)*(float)1.0; accumWeights += 1;
    }
    float pixel525_diffR = fabs(pixel525.x- (float)pixel_orig.x);
    float pixel525_diffG = fabs(pixel525.y- (float)pixel_orig.y);
    float pixel525_diffB = fabs(pixel525.z- (float)pixel_orig.z);
    float pixel525_diffA = fabs(pixel525.w- (float)pixel_orig.w);
   if ((pixel525_diffR<30)&& (pixel525_diffG< 30)&&(pixel525_diffB< 30 )&&(pixel525_diffA< 30)){
	    pixel_new += (pixel525)*(float)1.0; accumWeights += 1;
    }
    float pixel526_diffR = fabs(pixel526.x- (float)pixel_orig.x);
    float pixel526_diffG = fabs(pixel526.y- (float)pixel_orig.y);
    float pixel526_diffB = fabs(pixel526.z- (float)pixel_orig.z);
    float pixel526_diffA = fabs(pixel526.w- (float)pixel_orig.w);
   if ((pixel526_diffR<30)&& (pixel526_diffG< 30)&&(pixel526_diffB< 30 )&&(pixel526_diffA< 30)){
	    pixel_new += (pixel526)*(float)1.0; accumWeights += 1;
    }
    float pixel527_diffR = fabs(pixel527.x- (float)pixel_orig.x);
    float pixel527_diffG = fabs(pixel527.y- (float)pixel_orig.y);
    float pixel527_diffB = fabs(pixel527.z- (float)pixel_orig.z);
    float pixel527_diffA = fabs(pixel527.w- (float)pixel_orig.w);
   if ((pixel527_diffR<30)&& (pixel527_diffG< 30)&&(pixel527_diffB< 30 )&&(pixel527_diffA< 30)){
	    pixel_new += (pixel527)*(float)1.0; accumWeights += 1;
    }
    float pixel528_diffR = fabs(pixel528.x- (float)pixel_orig.x);
    float pixel528_diffG = fabs(pixel528.y- (float)pixel_orig.y);
    float pixel528_diffB = fabs(pixel528.z- (float)pixel_orig.z);
    float pixel528_diffA = fabs(pixel528.w- (float)pixel_orig.w);
   if ((pixel528_diffR<30)&& (pixel528_diffG< 30)&&(pixel528_diffB< 30 )&&(pixel528_diffA< 30)){
	    pixel_new += (pixel528)*(float)1.0; accumWeights += 1;
    }
    pixel_new = (accumWeights==0)?0:pixel_new/accumWeights; pixel_new.w = 255;
    pixel_new = fabs(pixel_new);
    if (pixel_new.x>255) pixel_new.x = 255;
    if (pixel_new.y>255) pixel_new.y = 255;
    if (pixel_new.z>255) pixel_new.z = 255;
    pixel_new.w = 255;
    write_imagef(outputImage,(int2)(i,j), pixel_new);
};


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
