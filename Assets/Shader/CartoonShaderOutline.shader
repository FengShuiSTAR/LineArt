Shader "Cartoon/Cartoon Shader Outline"
{
	Properties
	{
		_OutlineExtrusion("Outline Extrusion", float) = 0.05
		_OutlineColor("Outline Color", Color) = (0, 0, 0, 1)
	}
		SubShader
	{
		Tags {
			"RenderType" = "Opaque"
			"RenderPipeline" = "UniversalPipeline"
		}

		Pass {
			Name "Outline"
			//Blend SrcAlpha OneMinusSrcAlpha
			Cull Front
			
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"


			float4 _OutlineColor;
			float _OutlineExtrusion;

			struct vertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct vertexOutput
			{
				float4 pos : SV_POSITION;
				float4 color : COLOR;
			};

			vertexOutput vert(vertexInput input)
			{
				vertexOutput output;

				float4 newPos = input.vertex*_OutlineExtrusion ;

				//// normal extrusion technique
				//float3 normal = normalize(input.normal);
				//newPos += float4(normal, 0.0) * _OutlineExtrusion;

				// convert to world space
				
				output.pos = UnityObjectToClipPos(newPos);

				output.color = _OutlineColor;
				return output;
			}

			float4 frag(vertexOutput input) : COLOR
			{

				return input.color;
			}


			ENDCG
		}
	}
}