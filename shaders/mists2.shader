shader_type canvas_item;
// Using code from

// thiagoborn for the Dreambox shader
// https://www.shadertoy.com/view/WsBGDm
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

	for (int i = 0; i < 5; i++)
	{
		value += noise(coords) * scale;
		coords *= 4.0f;
		scale *= 0.5f;
	}

	return value;
}

float value(vec2 uv)
{
    float Pixels = 1024.0;
    float dx = 10.0 * (1.0 / Pixels);
    float dy = 10.0 * (1.0 / Pixels);
  

    float final = 0.0f;
    
    vec2 uvc = uv;
    
    vec2 Coord = vec2(dx * floor(uvc.x / dx),
                          dy * floor(uvc.y / dy));

    
    for (int i =0;i < 3; i++)
    {
        vec2 motion = vec2(fbm(Coord + vec2(float(i))));
        final += fbm(Coord + motion + vec2(float(i)));
    }

	return final / 3.0f;
}

vec2 fluid(vec2 uv1, float iTime){
 vec2 uv = uv1;
 vec2 result;
 float t = iTime/8.;
 //uv += iTime;
 for (float i = 1.; i < 15.; i++)
  {
    
    uv.x += sin((t+uv.y)*.333)*1.333/i* sin(i * uv.y + t * 0.333);
    uv.y += sin((t+uv.x)*.333)*1.333/i* sin(i * uv.x + t * 0.333 );
    //uv = uv/1.01;
    //uv1 += uv/.;
    //uv += noise(uv/i/i)/(i*i)/8.;
    //result = max(uv,-result);
    //uv = max(uv,uv1);
  }
  return uv;
}
void fragment()
{
//    vec2 uv = fragCoord.xy / iResolution.y * 2.0f;
    vec2 uv = UV;
	uv  = uv * 2.0 - 1.0;
//    uv  = uv * 2.0 - 1.0;
//    uv.x *= iResolution.x / iResolution.y;
    float iTime = TIME / 3.; 
    uv = uv - iTime/4.;
    uv = fluid(uv, iTime);
    
	COLOR = vec4(mix(vec3(-0.3f), vec3(0.45, 0.4f, 0.6f) + vec3(0.6f), value(uv)), 1);
}