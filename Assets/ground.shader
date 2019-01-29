shader_type spatial;

uniform vec4 grass : hint_color;
uniform vec4 ocean : hint_color;

void vertex() {

}

void fragment() {
	ALBEDO = grass.rgb;
}