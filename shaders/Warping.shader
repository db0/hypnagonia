shader_type canvas_item;
// Using code from

// iq for the Warping shader
// https://www.shadertoy.com/view/MdSXzz
// Ported to Godot and customized for FragmentForge by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US

uniform bool is_card = true;
//uniform float iTime;

const mat2 m = mat2(vec2(0.80,  0.60), vec2(-0.60,  0.80) );

float hash( vec2 p )
{
	float h = dot(p,vec2(127.1,311.7));
    return -1.0 + 2.0*fract(sin(h)*43758.5453123);
}

float noise( in vec2 p )
{
    vec2 i = floor( p );
    vec2 f = fract( p );
	
	vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( hash( i + vec2(0.0,0.0) ), 
                     hash( i + vec2(1.0,0.0) ), u.x),
                mix( hash( i + vec2(0.0,1.0) ), 
                     hash( i + vec2(1.0,1.0) ), u.x), u.y);
}

float fbm( vec2 p )
{
    float f = 0.0;
    f += 0.5000*noise( p ); p = m*p*2.02;
    f += 0.2500*noise( p ); p = m*p*2.03;
    f += 0.1250*noise( p ); p = m*p*2.01;
    f += 0.0625*noise( p );
    return f/0.9375;
}

vec2 fbm2( in vec2 p )
{
    return vec2( fbm(p.xy), fbm(p.yx) );
}

vec3 map( vec2 p, float iTime )
{   
    p *= 0.7;

    float f = dot( fbm2( 1.0*(0.05*iTime + p + fbm2(-0.05*iTime+2.0*(p + fbm2(4.0*p)))) ), vec2(1.0,-1.0) );

    float bl = smoothstep( -0.8, 0.8, f );

    float ti = smoothstep( -1.0, 1.0, fbm(p) );

    return mix( mix( vec3(0.50,0.00,0.00), 
                     vec3(1.00,0.75,0.35), ti ), 
                     vec3(0.00,0.00,0.02), bl );
}

void fragment()
{
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE;
//    vec2 p = (-iResolution.xy+2.0*FRAGCOORD.xy)/iResolution.y;
    vec2 p = UV;
	p -= 0.5;
    

    float e = 0.0045;

    vec3 colc = map( p , TIME              ); float gc = dot(colc,vec3(0.333));
    vec3 cola = map( p + vec2(e,0.0), TIME ); float ga = dot(cola,vec3(0.333));
    vec3 colb = map( p + vec2(0.0,e), TIME ); float gb = dot(colb,vec3(0.333));
    
    vec3 nor = normalize( vec3(ga-gc, e, gb-gc ) );

    vec3 col = colc;
    col += vec3(1.0,0.7,0.6)*8.0*abs(2.0*gc-ga-gb);
    col *= 1.0+0.2*nor.y*nor.y;
    col += 0.05*nor.y*nor.y*nor.y;
    
    
//    vec2 q = FRAGCOORD.xy/iResolution.xy;
    vec2 q = UV;
    col *= pow(16.0*q.x*q.y*(1.0-q.x)*(1.0-q.y),0.1);
    COLOR = vec4( col, 1.0 );
}