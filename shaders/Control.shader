shader_type canvas_item;
// Using code from

// cineshader for the 002-Blue shader
// https://www.shadertoy.com/view/WldSRn
// Ported to Godot and customized for Project Dreams by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US

uniform bool is_card = true;
uniform float time_offset;
//uniform float iTime;

float sdSphere(vec3 pos, float size)
{
    return length(pos) - size;
}

float sdBox(vec3 pos, vec3 size)
{
    pos = abs(pos) - vec3(size);
    return max(max(pos.x, pos.y), pos.z);
}

float sdOctahedron(vec3 p, float s)
{
    p = abs(p);
    float m = p.x+p.y+p.z-s;
    vec3 q;
         if( 3.0*p.x < m ) q = p.xyz;
    else if( 3.0*p.y < m ) q = p.yzx;
    else if( 3.0*p.z < m ) q = p.zxy;
    else return m*0.57735027;
    
    float k = clamp(0.5*(q.z-q.y+s),0.0,s); 
    return length(vec3(q.x,q.y-s+k,q.z-k)); 
}

float sdPlane(vec3 pos)
{
    return pos.y;
}

mat2 rotate(float a)
{
    float s = sin(a);
    float c = cos(a);
    return mat2(vec2(c, s), vec2(-s, c));
}

vec3 repeat(vec3 pos, vec3 span)
{
    return abs(mod(pos, span)) - span * 0.5;
}

float getDistance(vec3 pos, vec2 uv, float iTime)
{
    vec3 originalPos = pos;

    for(int i = 0; i < 3; i++)
    {
        pos = abs(pos) - 4.5;
        pos.xz *= rotate(1.0);
        pos.yz *= rotate(1.0);
    }

    pos = repeat(pos, vec3(4.0));

    float d0 = abs(originalPos.x) - 0.1;
    float d1 = sdBox(pos, vec3(0.8));

    pos.xy *= rotate(mix(1.0, 2.0, abs(sin(iTime))));
    float size = mix(1.1, 1.3, (abs(uv.y) * abs(uv.x)));
    float d2 = sdSphere(pos, size);
    float dd2 = sdOctahedron(pos, 1.8);
    float ddd2 = mix(d2, dd2, abs(sin(iTime)));
  
    return max(max(d1, -ddd2), -d0);
}

void fragment()
{
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE;
    vec2 p = (UV - 0.5) * 2.0;

    // camera
	float iTime = TIME / 5. + time_offset;
    vec3 cameraOrigin = vec3(0.0, 0.0, -10.0 + iTime * 4.0);
    vec3 cameraTarget = vec3(cos(iTime) + sin(iTime / 2.0) * 10.0, exp(sin(iTime)) * 2.0, 3.0 + iTime * 4.0);
    vec3 upDirection = vec3(0.0, 1.0, 0.0);
    vec3 cameraDir = normalize(cameraTarget - cameraOrigin);
    vec3 cameraRight = normalize(cross(upDirection, cameraOrigin));
    vec3 cameraUp = cross(cameraDir, cameraRight);
    vec3 rayDirection = normalize(cameraRight * p.x + cameraUp * p.y + cameraDir);
    
    float depth = 0.0;
    float ac = 0.0;
    vec3 rayPos = vec3(0.0);
    float d = 0.0;

    for(int i = 0; i < 80; i++)
    {
        rayPos = cameraOrigin + rayDirection * depth;
        d = getDistance(rayPos, p, iTime);

        if(abs(d) < 0.0001)
        {
            break;
        }

        ac += exp(-d * mix(5.0, 10.0, abs(sin(iTime))));        
        depth += d;
    }
    
    vec3 col = vec3(0.0, 0.3, 0.7);
    ac *= 1.2 * (iResolution.x/iResolution.y - abs(p.x)) ;
    vec3 finalCol = col * ac * 0.06;
    COLOR = vec4(finalCol, 1.0);
    COLOR.w = 1.0 - depth * 0.1;
}
