/*
 * WireframeShader
 * 
 * Copyright(C) 2021 ㊥Maruchu
 * 
 * This software is released under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */




//ワイヤーフレームシェーダー
Shader "Maruchu/WireframeShader"
{
    Properties
    {
        _WireColor("WireColor", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Pass
        {
            Cull Back
            CGPROGRAM
            #pragma vertex   vert
            #pragma geometry geom
            #pragma fragment frag
            #define mulcolor 1.0
            #include "UnityCG.cginc"
            #include "WireframeShader.cginc"
            ENDCG
        }
        Pass
        {
            Cull Front
            CGPROGRAM
            #pragma vertex   vert
            #pragma geometry geom
            #pragma fragment frag
            #define mulcolor 0.5
            #include "UnityCG.cginc"
            #include "WireframeShader.cginc"
            ENDCG
        }
    }
}