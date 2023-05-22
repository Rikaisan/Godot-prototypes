shader_type canvas_item;

uniform sampler2D screenTexture : hint_screen_texture, repeat_enable;
uniform sampler2D noiseTexture : repeat_enable;
uniform float strenght : hint_range(0.0, 0.1, 0.005) = 0.020;
uniform bool animate = true;

void fragment() {
	vec2 newUV = SCREEN_UV + texture(noiseTexture, UV + vec2(animate ? TIME / 8.0 : 0.0, 0.0)).r * strenght;
	COLOR.rgb = texture(screenTexture, newUV).rgb;
}
