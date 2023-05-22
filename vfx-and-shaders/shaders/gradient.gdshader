shader_type canvas_item;

uniform sampler2D screenTexture : hint_screen_texture, repeat_enable;
uniform sampler2D gradient;

void fragment() {
	COLOR.rgb = texture(screenTexture, SCREEN_UV).rgb;
	COLOR.rgb = COLOR.rgb + texture(gradient, vec2(1.0 - SCREEN_UV.y, SCREEN_UV.x)).rgb * 0.5;
}
