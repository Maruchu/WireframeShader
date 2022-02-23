/*
 * WireframeShader
 * 
 * Copyright(C) 2021 ㊥Maruchu
 * 
 * This software is released under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */




struct v2g {
    float4 pos        : SV_POSITION;
};
struct g2f {
    float4 pos        : SV_POSITION;
    float3 axis       : TEXCOORD0;
};
fixed4 _WireColor;
v2g vert(appdata_base v)
{
    v2g o;
    o.pos = UnityObjectToClipPos(v.vertex);
    return o;
}
[maxvertexcount(3)]
void geom(triangle v2g i[3], inout TriangleStream<g2f> triStream)
{
    g2f o;
    float3 scrpos[3];
    int j;
    for( j = 0; j < 3; j++) { scrpos[j] = ComputeScreenPos(UnityObjectToClipPos(i[j].pos)); }
    for( j = 0; j < 3; j++)
    {
        o.pos  = i[j].pos;
        half3 axis = half3(0,0,0);
        axis[j] = min(distance(scrpos[(j + 1) % 3], scrpos[j]),distance(scrpos[(j + 2) % 3], scrpos[j]));
        o.axis = axis;
        triStream.Append(o);
    }
}
fixed4 frag(g2f i) : SV_Target
{
    float far = min(i.axis.x, min(i.axis.y, i.axis.z));
    float temp = fwidth(i.axis);
    far = (temp * smoothstep(temp * 0.1, temp * 0.5, far));
    clip(-step(temp, far));
    return (_WireColor * mulcolor);
}
