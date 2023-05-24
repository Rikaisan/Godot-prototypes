shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_enable;

uniform float red_offset_x : hint_range(-1.0, 1.0, 1.0);
uniform float red_offset_y : hint_range(-1.0, 1.0, 1.0);
uniform float green_offset_x : hint_range(-1.0, 1.0, 1.0);
uniform float green_offset_y : hint_range(-1.0, 1.0, 1.0);
uniform float blue_offset_x : hint_range(-1.0, 1.0, 1.0);
uniform float blue_offset_y : hint_range(-1.0, 1.0, 1.0);

uniform float force : hint_range(0.0, 1.0, 0.05) = 0.25;

void fragment() {
	float scaled_force = force / 100.0;
	COLOR = texture(screen_texture, SCREEN_UV);
	COLOR.r = texture(screen_texture, SCREEN_UV + scaled_force * vec2(red_offset_x, red_offset_y)).r;
	COLOR.g = texture(screen_texture, SCREEN_UV + scaled_force * vec2(green_offset_x, green_offset_y)).g;
	COLOR.b = texture(screen_texture, SCREEN_UV + scaled_force * vec2(blue_offset_x, blue_offset_y)).b;
}
