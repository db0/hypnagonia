shader_type canvas_item;
// Using code from

// Stephane Cuillerdier - Aiekick/2014 for the  Fractal Experiment 7
// https://www.shadertoy.com/view/Mlj3Wh
// Ported to Godot and customized for Project Dreams by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US

uniform bool is_card = true;
float magicBox(vec3 p) 
{
    p = 1. - abs(1. - mod(p, 2.));
    float lL = length(p), nL = lL, tot = 0., c = 0.913;
    for (int i=0; i < 13; i++) 
	{
      p = abs(p)/(lL*lL) - c;
      nL = length(p);
      tot += abs(nL-lL);
      lL = nL;
    }
    return tot;
}

void fragment()
{
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE;
	vec2 s = iResolution.xy;
	
//	vec2 uv = (2.*FRAGCOORD.xy-s)/s.y * .2;
	vec2 uv = (UV - 0.5) * 1.;

	// count arms
	float n = 10.0;
	
	// angle 
	float a = atan(uv.y,uv.x);
	
	// bg
	vec3 topColor = vec3(.16,1,.11);
	vec3 bottomColor = vec3(0.1,.52,.1);
	COLOR.rgb = mix( topColor, bottomColor, sqrt(UV).y );
	
	// fractal
	float fc = magicBox(vec3(uv,0)) + a*n + TIME * 2.;
	
	COLOR.rgb += cos(fc) + .000001/dot(uv,uv);
}