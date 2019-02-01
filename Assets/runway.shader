shader_type spatial;

uniform vec4 tarmac : hint_color;
uniform vec4 stripe : hint_color;

varying vec3 v;

void vertex() {
	v = VERTEX;
}

void fragment() {
	float end_x = abs(v.x * 8.0);
	float z = v.z * 16.0;
	if (v.x > 0.95 || v.x < -0.95 || v.z > 0.94 && end_x < 7.0 && end_x > 0.5 && fract(end_x) < 0.5 || fract(z) < 0.5 && abs(v.x) < 0.02)
		ALBEDO = stripe.rgb;
	else
		ALBEDO = tarmac.rgb;
}