#include "Reshade.fxh"

uniform float FAR_PLANE <
	ui_type = "slider";
	ui_min = 1.1;
	ui_max = 3000.0;
	ui_label = "Far Plane";
> = 2000.0;

uniform float NEAR_PLANE <
	ui_type = "slider";
	ui_min = 1.1;
	ui_max = 1000.0;
	ui_label = "Near Plane";
> = 25.0;

float GetDepth(float2 texcoord)
{
    return ReShade::GetLinearizedDepth(texcoord);
}

float3 PS_DisplayDepth(float4 position : SV_Position, float2 texcoord : TEXCOORD0) : SV_Target
{
    // defines far plane distance and near plane distance
    float f = FAR_PLANE;
	float n = NEAR_PLANE;

    // get the depth value at the texture coordinate
	float depth = GetDepth(texcoord);

    // linearize depth
	depth = lerp(n, f, depth);
    
    // normalize depth
	return depth / (f - n);
}

technique DisplayDepth
{
    pass
    {
        VertexShader = PostProcessVS;
        PixelShader = PS_DisplayDepth;
    }
}
