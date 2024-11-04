shader_type canvas_item;

uniform vec4 effect_color : source_color = vec4(1.0);
uniform float effect_amount : hint_range(0.0, 1.0) = 1.0;
uniform float uv_scale = 1.0;

void fragment() {
	COLOR.rgba = effect_color.rgba;
	float dist = mix(1.0, 0.0, 2.0*distance(UV, vec2(0.5)));
	COLOR.a *= step(1.0 - (effect_amount * dist), texture(TEXTURE, UV * uv_scale).r);
}
