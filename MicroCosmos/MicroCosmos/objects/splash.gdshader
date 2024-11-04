shader_type canvas_item;

uniform vec4 effect_color : source_color = vec4(1.0);
uniform float effect_amount : hint_range(0.0, 1.0) = 1.0;
uniform float uv_scale = 1.0;

uniform float wobble_amp : hint_range(0.0, 1.0) = 0.3;
uniform float wobble_speed = 0.1;

void fragment() {
	COLOR.rgba = effect_color.rgba;
	float dist = mix(1.0, 0.0, 2.0*distance(UV, vec2(0.5)));

	float wobble = (2.0 * texture(TEXTURE, vec2(wobble_speed * TIME, 0.0)).r - 1.0) * wobble_amp;
	vec2 uv = UV * uv_scale;

	float effect_strength = effect_amount * (dist + wobble);

	COLOR.a *= step(1.0 - effect_strength, texture(TEXTURE, uv).r);
}
