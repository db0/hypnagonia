shader_type canvas_item;

uniform bool is_active = false;

void fragment(){
	vec4 color = texture(TEXTURE, UV);
	if (is_active) {
		COLOR = vec4(1.0 - color.rgb, color.a);
	} else {
		COLOR = color;
	}
}