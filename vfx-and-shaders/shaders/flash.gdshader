shader_type canvas_item;

uniform vec4 flash_color : source_color = vec4(1, 1, 1, 1);
uniform float flash_amount : hint_range(0.0, 1.0, 0.1) = 1.0;
uniform bool use_alpha = false;

void fragment() {
	vec4 new_color = texture(TEXTURE, UV);
	new_color.rgb = mix(new_color.rgb, flash_color.rgb, use_alpha ? flash_color.a : flash_amount);
	COLOR = new_color;
}
