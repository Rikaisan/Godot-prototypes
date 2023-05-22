shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

uniform vec2 center = vec2(0.5, 0.5);
uniform float force : hint_range(-1.0, 1.0, 0.1) = 0.2;
uniform float size: hint_range(0.0, 1.0, 0.01) = 0;
uniform float feather: hint_range(0.0, 0.2, 0.01) = 0.04;
uniform float width: hint_range(0.0, 0.5, 0.01) = 0.07;

void fragment() {
	float aspect_ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	vec2 new_uv = vec2((SCREEN_UV.x - 0.5) / aspect_ratio + 0.5, SCREEN_UV.y);
	
	float mask = length(new_uv - center);
	mask = (1.0 - smoothstep(size - feather, size, mask)) * smoothstep(size - width, size - width + feather, mask);
	
	vec2 displacement = normalize(new_uv - center) * force * mask;	
	COLOR = texture(screen_texture, SCREEN_UV - displacement);
	
	// COLOR.rgb = vec3(mask);
}
