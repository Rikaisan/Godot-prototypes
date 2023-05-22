shader_type canvas_item;

uniform int shape_type = 0;
uniform vec2 center = vec2(0.5, 0.5);
uniform float size = 0.2;

vec3 circleMask(vec2 uv) {
	vec3 color = vec3(1.0);
	color = step(size, color * length(uv - center));
	return color;
}

vec3 squareMask() {
	return vec3(0.5);
}

vec3 lineMask() {
	return vec3(1.0);
}

void fragment() {
	switch (shape_type) {
		case 0:
			COLOR.rgb = circleMask(UV);
			break;
		case 1:
			COLOR.rgb = squareMask();
			break;
		case 2:
			COLOR.rgb = lineMask();
			break;
	}
}
