shader_type canvas_item;

uniform sampler2D screenTexture : hint_screen_texture, repeat_enable;

void fragment() {
	vec4 pixelColor = texture(screenTexture, SCREEN_UV * 4.0);
	COLOR = pixelColor;
}
