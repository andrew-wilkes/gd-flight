extends RigidBody

var force = Vector3(0, 0, 0)
var torque = Vector3(0, 0, 0)
var w = Vector3(0, 0, 0)
var f = Vector3(0, 0, 0)

func _process(delta):
	g.set_speed(get_linear_velocity().length())
	g.altitude = translation.y

func set_forces(thrust, wind, drag_factor, lift_factor, elevator, ailerons, rudder):
	# Get apparent wind vector
	var wv = get_linear_velocity() - wind
	# Get wind components acting on plane
	w.z = transform.basis.z.dot(wv)
	w.y = transform.basis.y.dot(wv)
	w.x = transform.basis.x.dot(wv)
	w *= w
	f.z = thrust - w.z * drag_factor # Drag factor determines the max speed at max thrust
	f.y = w.y * lift_factor # Lift factor is set such that the plane overcomes gravity at take-off speed
	force = transform.basis.z * f.z + transform.basis.y * f.y
	# Set torque
	w *= 0.01 # Abitrary value to reduce the effect
	torque = transform.basis.y * w.z * rudder + transform.basis.z * w.z * ailerons - transform.basis.x * w.z * elevator

func _integrate_forces(state):
	add_central_force(force)
	add_torque(torque)
