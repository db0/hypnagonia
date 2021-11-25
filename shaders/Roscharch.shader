shader_type canvas_item;
// Using code from

// xjorma for the  Rorschach Ink Test shader
// https://www.shadertoy.com/view/wslcDf
// Ported to Godot and customized for FragmentForge by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US

uniform bool is_card = true;
uniform float iTime;
uniform float time_offset;
uniform vec3 tint = vec3(255, 68, 23);
// Created by David Gallardo - xjorma/2020
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0

//	Simplex 3D Noise 
//	by Ian McEwan, Ashima Arts
//
vec4 permute(vec4 x){return mod(((x*34.0)+1.0)*x, 289.0);}
vec4 taylorInvSqrt(vec4 r){return 1.79284291400159 - 0.85373472095314 * r;}

float snoise(vec3 v){ 
  const vec2  C = vec2(1.0/6.0, 1.0/3.0) ;
  const vec4  D = vec4(0.0, 0.5, 1.0, 2.0);

// First corner
  vec3 i  = floor(v + dot(v, C.yyy) );
  vec3 x0 =   v - i + dot(i, C.xxx) ;

// Other corners
  vec3 g = step(x0.yzx, x0.xyz);
  vec3 l = 1.0 - g;
  vec3 i1 = min( g.xyz, l.zxy );
  vec3 i2 = max( g.xyz, l.zxy );

  //  x0 = x0 - 0. + 0.0 * C 
  vec3 x1 = x0 - i1 + 1.0 * C.xxx;
  vec3 x2 = x0 - i2 + 2.0 * C.xxx;
  vec3 x3 = x0 - 1. + 3.0 * C.xxx;

// Permutations
  i = mod(i, 289.0 ); 
  vec4 p = permute( permute( permute( 
             i.z + vec4(0.0, i1.z, i2.z, 1.0 ))
           + i.y + vec4(0.0, i1.y, i2.y, 1.0 )) 
           + i.x + vec4(0.0, i1.x, i2.x, 1.0 ));

// Gradients
// ( N*N points uniformly over a square, mapped onto an octahedron.)
  float n_ = 1.0/7.0; // N=7
  vec3  ns = n_ * D.wyz - D.xzx;

  vec4 j = p - 49.0 * floor(p * ns.z *ns.z);  //  mod(p,N*N)

  vec4 x_ = floor(j * ns.z);
  vec4 y_ = floor(j - 7.0 * x_ );    // mod(j,N)

  vec4 x = x_ *ns.x + ns.yyyy;
  vec4 y = y_ *ns.x + ns.yyyy;
  vec4 h = 1.0 - abs(x) - abs(y);

  vec4 b0 = vec4( x.xy, y.xy );
  vec4 b1 = vec4( x.zw, y.zw );

  vec4 s0 = floor(b0)*2.0 + 1.0;
  vec4 s1 = floor(b1)*2.0 + 1.0;
  vec4 sh = -step(h, vec4(0.0));

  vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;
  vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;

  vec3 p0 = vec3(a0.xy,h.x);
  vec3 p1 = vec3(a0.zw,h.y);
  vec3 p2 = vec3(a1.xy,h.z);
  vec3 p3 = vec3(a1.zw,h.w);

//Normalise gradients
  vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;

// Mix final noise value
  vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
  m = m * m;
  return 42.0 * dot( m*m, vec4( dot(p0,x0), dot(p1,x1), 
                                dot(p2,x2), dot(p3,x3) ) );
}


float sat(float v)
{
    return min(max(v, 0.), 1.);
}


float fbm(vec3 p, int octaveNum)
{
	float acc = 0.0;	
	float freq = 1.0;
	float amp = 0.5;
    vec3 shift = vec3(100);
	for (int i = 0; i < octaveNum; i++)
	{
		acc += snoise(p) * amp;
        p = p * 2.0 + shift;
        amp *= 0.5;
	}
	return acc;
}

float hash21(vec2 uv)
{
	return fract(sin(dot(uv.xy ,vec2(532.1231,1378.3453))) * 53211.1223);
}

const vec3	inkColor1  = vec3( 28,  28,  40) / 255.;
const vec3	paperColor = vec3( 28,  28,  40) / 255.;

vec3 vignette(vec3 color, vec2 q, float v)
{
    color *= 0.3 + 0.8 * pow(16.0 * q.x * q.y * (1.0 - q.x) * (1.0 - q.y), v);
    return color;
}

void fragment()
{

  vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste
//    vec2 uv = fragCoord/iResolution.xy;
    vec2 uv = UV;
    uv  = uv * 2.0 - 1.0;
//    uv.x *= iResolution.x / iResolution.y;
    
	vec2	p = uv;
//	vec2	p = (2. * FRAGCOORD.xy - iResolution.xy) / iResolution.y;
    vec2	sp = p;
    sp.x = abs(sp.x);
    
    vec3 col = vec3(252,232,225) / 255.;
    
	col += hash21(p) / 20.;
    
    float offTime = TIME + time_offset;
    
    float i1 = smoothstep(.03, 0., fbm(vec3(sp, offTime * 0.05 + 30.), 7) - 0.2 + length(p) * 0.5);
    float i2 = smoothstep(.03, 0., fbm(vec3(sp, offTime * 0.04 + 16.), 7) + length(p) * 0.5);
    vec3	inkColor2  = tint / 255.;
    col = mix(col, inkColor2, i2 * (0.4 + 0.6 * (fbm(vec3(p * 0.75, offTime * 0.04 + 256.), 5))));
    col = mix(col, inkColor1, i1 * (0.4 + 0.6 * (fbm(vec3(p * 0.75, offTime * 0.04 + 2445.), 5))));
    
    col = vignette(col, FRAGCOORD.xy / iResolution.xy, 0.3);

    // Output to screen
    COLOR = vec4(col, 1);
}