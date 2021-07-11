/*
Shader from Godot Shaders - the free shader library.
https://godotshaders.com/shader/loading-effect-color-over-grayscale/

This shader is under CC0 license. Feel free to use, improve and 
change this shader according to your needs and consider sharing 
the modified result on godotshaders.com.
*/

shader_type canvas_item;

uniform float percentage: hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec4 main_tx = texture(SCREEN_TEXTURE, SCREEN_UV);
    float avg = (main_tx.r + main_tx.g + main_tx.b) / 3.0;
	COLOR.a = main_tx.a;
	COLOR.rgb = main_tx.rgb * step(UV.x, percentage) + (vec3(avg) * step(percentage, UV.x));
}