// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

#ifndef UNITY_LIGHTING_COMMON_INCLUDED
#define UNITY_LIGHTING_COMMON_INCLUDED

fixed4 _LightColor0;
fixed4 _SpecColor;

struct UnityLight
{
    half3 color;
    half3 dir;
    half  ndotl; // Deprecated: Ndotl is now calculated on the fly and is no longer stored. Do not used it.
};

struct UnityIndirect
{
	//��ӹ���������
    half3 diffuse;
	//��ӹ��ո߹ⷴ��
    half3 specular;
};

struct UnityGI
{
	//���ع���Ϣ
    UnityLight light;
	//��ӹ�����Ϣ
    UnityIndirect indirect;
};

struct UnityGIInput
{
	//���ع���Ϣ
    UnityLight light; // pixel light, sent from the engine
	//����ռ�λ��
    float3 worldPos;
	//����ռ����ߣ�����
    half3 worldViewDir;
	//��Դ˥��ϵ��
    half atten;
	//������
    half3 ambient;

    // interpolated lightmap UVs are passed as full float precision data to fragment shaders
    // so lightmapUV (which is used as a tmp inside of lightmap fragment shaders) should
    // also be full float precision to avoid data loss before sampling a texture.
	//������ͼUV
    float4 lightmapUV; // .xy = static lightmap UV, .zw = dynamic lightmap UV
	//Probe���
    #if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
    float4 boxMin[2];
    #endif
    #ifdef UNITY_SPECCUBE_BOX_PROJECTION
    float4 boxMax[2];
    float4 probePosition[2];
    #endif
    // HDR cubemap properties, use to decompress HDR texture
    float4 probeHDR[2];
};

#endif
