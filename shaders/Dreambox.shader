shader_type canvas_item;
// Using code from

// thiagoborn for the Dreambox shader
// https://www.shadertoy.com/view/WsBGDm
// Ported to Godot and customized for FragmentForge by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US


uniform bool is_card = true;
//uniform float iTime;

uniform float eps = 0.0001;
uniform int steps = 32;
uniform float minDist = 0.01;
uniform float maxDist = 10.0;
uniform float delta = 1.0;

uniform float foldingLimit = 1.0;
const float minRadius =  0.5;
const float minRadius2 = minRadius*minRadius;

const float fixedRadius = 1.0;
const float fixedRadius2 = fixedRadius*fixedRadius;

uniform int Iterations = 5;
uniform float Scale = 1.5;

void sphereFold(inout vec3 z, inout float dz) {
	float r2 = dot(z,z);
	if (r2<minRadius2) { 
		// linear inner scaling
		float temp = (fixedRadius2/minRadius2);
		z *= temp;
		dz*= temp;
	} else if (r2<fixedRadius2) { 
		// this is the actual sphere inversion
		float temp =(fixedRadius2/r2);
		z *= temp;
		dz*= temp;
	}
}

void boxFold(inout vec3 z, inout float dz) {
	z = clamp(z, -foldingLimit, foldingLimit) * 2.0 - z;
}

float mandelbox(vec3 z)
{
	vec3 offset = z;
	float dr = 1.0;
	for(int n = 0; n < Iterations; n++) {
		boxFold(z,dr);       
		sphereFold(z,dr);    
		z=Scale*z + offset;  
        dr = dr*abs(Scale)+1.0;
	}
	float r = length(z);
	return r/abs(dr);
}

float world(vec3 p){
  return mandelbox(p);
}
    
float trace(vec3 origin,vec3 direction){
    float distTraveled = minDist;
   
    for(int i=0;i<steps;i++){
   		vec3 point = origin + direction * distTraveled;
        float dist = world(point);
        if(dist<eps){
            return distTraveled;
        }
       	distTraveled += dist * delta;
       
    }
    return distTraveled;
}

float shadow(vec3 ro,vec3 rd,float mint,float maxt,float k)
{
    float res = 1.0;
    float ph = 1e20;
    for(float t = mint; t < maxt; t++){
        float h = world(ro + rd*t);
        if( h<0.001 )
            return 0.0;
        float y = h*h/(2.0*ph);
        float d = sqrt(h*h-y*y);
        res = min( res, k*d/max(0.0,t-y) );
        ph = h;
        t += h;
    }
    return res;
}

vec3 calcNormal(vec3 p) {   
    return normalize(vec3(
        world(vec3(p.x + eps, p.y, p.z)) - world(vec3(p.x - eps, p.y, p.z)),
        world(vec3(p.x, p.y + eps, p.z)) - world(vec3(p.x, p.y - eps, p.z)),
        world(vec3(p.x, p.y, p.z  + eps)) - world(vec3(p.x, p.y, p.z - eps))
    ));
}

void fragment()
{
//    vec2 uv = fragCoord/iResolution.xy;
    vec2 uv = UV;
    uv  = uv * 2.0 - 1.0;
//    uv.x *= iResolution.x / iResolution.y;
    
    
    vec3 lookingTo = vec3(0.,0.,0.);
    float it = TIME / 20.;
    vec3 viewer = vec3(
        0.1+sin(it/2.5) * 1.,
        0.2+cos(it/3.0) * 1.,
        sin(it/3.5) * 1.
    );
    
    vec3 forward = normalize(lookingTo-viewer);
    vec3 rigth = cross(vec3(0.0,1.0,0.0),forward);
    vec3 up = cross(forward,rigth);
    
    vec3 direction = normalize(forward *2.0 + rigth * uv.x + up * uv.y);
    float dist = trace(viewer,direction); 
	vec3 color = vec3(0.0);    
	float fog = 1.0 / (1.0 + dist);
    color = vec3(fog);
	COLOR = vec4(color,1.0);

}