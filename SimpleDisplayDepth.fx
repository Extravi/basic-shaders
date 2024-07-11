#include "Reshade.fxh"

float GetDepth(float2 texcoord)
{
    return ReShade::GetLinearizedDepth(texcoord);
}

float4 PS_DisplayDepth(float4 position : SV_Position, float2 texcoord : TEXCOORD0) : SV_Target
{
    // get the depth value at the texture coordinate
    float depth = GetDepth(texcoord);

    // depths scale value
    depth *= 0.2;

    // convert the depth value to a color
    // use the depth value for (RGB)
    float3 depth_color = float3(depth, depth, depth);

    // return the depth color with full opacity (alpha = 1.0)
    return float4(depth_color, 1.0);
}

technique DisplayDepth
{
    pass
    {
        VertexShader = PostProcessVS;
        PixelShader = PS_DisplayDepth;
    }
}
