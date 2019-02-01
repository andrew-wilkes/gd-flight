shader_type spatial;

uniform vec4 grass : hint_color;
uniform vec4 ocean : hint_color;

void vertex() {

}

void fragment() {
	vec3 g = grass.rgb;
	g.g *= (1.0 - 0.3 * fract(sin(UV.y) * 7.0 + sin(UV.y) * 32.0));
	ALBEDO = g;
}