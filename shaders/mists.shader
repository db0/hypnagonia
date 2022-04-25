shader_type canvas_item;
// Using code from


//  bogz for the  2D Misty Shader
// https://www.shadertoy.com/view/7lfXRB
// Ported to Godot and customized for FragmentForge by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US


//precision highp float;

float rand(vec2 coords)
{
	return fract(sin(dot(coords, vec2(56.3456f,78.3456f)) * 5.0f) * 10000.0f);
}

float noise(vec2 coords)
{
	vec2 i = floor(coords);
	vec2 f = fract(coords);

	float a = rand(i);
	float b = rand(i + vec2(1.0f, 0.0f));
	float c = rand(i + vec2(0.0f, 1.0f));
	float d = rand(i + vec2(1.0f, 1.0f));

	vec2 cubic = f * f * (3.0f - 2.0f * f);

	return mix(a, b, cubic.x) + (c - a) * cubic.y * (1.0f - cubic.x) + (d - b) * cubic.x * cubic.y;
}

float fbm(vec2 coords)
{
	float value = 0.0f;
	float scale = 0.5f;

	for (int i = 0; i < 10; i++)
	{
		value += noise(coords) * scale;
		coords *= 4.0f;
		scale *= 0.5f;
	}

	return value;
}


void fragment()
{
//    vec2 uv = fragCoord.xy / iResolution.y * 2.0f;
    vec2 uv = UV;
    uv  = uv * 2.0 - 1.0;
//    uv.x *= iResolution.x / iResolution.y;
    float iTime = TIME; 
	float final = 0.0f;
    
    for (int i =1; i < 6; i++)
    {
        vec2 motion = vec2(fbm(uv + iTime * 0.05f + vec2(float(i))));

        final += fbm(uv + motion);

    }
    
    final /= 5.0f;
//	fragColor = vec4(mix(vec3(-0.3f), vec3(0.45, 0.4f, 0.6f) + vec3(0.6f), final), 1);
	vec4 final_color = vec4(mix(vec3(-0.3f), vec3(0.45, 0.4f, 0.6f) + vec3(0.6f), final), 1);
	
	COLOR = final_color;
}