shader_type canvas_item;

uniform sampler2D screenTexture : hint_screen_texture;
uniform sampler2D colors;
uniform bool remap_colors = false;

void fragment() {
	// Make it gray
	vec4 currentColor = texture(screenTexture, SCREEN_UV);
	float average = (currentColor.r + currentColor.g + currentColor.b) / 3.0;	
	// Multiply by colors (?)
	COLOR.rgb = remap_colors ? texture(colors, vec2(average)).rgb : vec3(average);
}
