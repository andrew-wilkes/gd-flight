shader_type spatial;

uniform vec4 tarmac : hint_color;
uniform vec4 stripe : hint_color;

void vertex() {

}

void fragment() {
	ALBEDO = tarmac.rgb;
}