shader_type canvas_item;

uniform sampler2D screenTexture : hint_screen_texture;
uniform int method : hint_range(0, 3, 1);

void fragment() {
	vec4 currentColor = texture(screenTexture, SCREEN_UV);
	switch (method) {
		case 0:
			COLOR.rgb = vec3(currentColor.r);
			break;
		case 1:
			COLOR.rgb = vec3(currentColor.g);
			break;
		case 2:
			COLOR.rgb = vec3(currentColor.b);
			break;
		case 3:
			float average = (currentColor.r + currentColor.g + currentColor.b) / 3.0;
			COLOR.rgb = vec3(average);
			break;
	}
}
