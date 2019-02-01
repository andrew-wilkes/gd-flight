extends RigidBody

var thrust = 0.0
var torque = Vector3(0, 0, 0)

func _integrate_forces(state):
	add_central_force(Vector3(0, 0, thrust))
	add_torque(torque)
