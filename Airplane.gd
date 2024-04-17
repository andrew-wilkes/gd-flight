extends Spatial

const SERVO_SPEED = 1.0
const MAX_PHI = PI / 4.0
const MAX_THRUST = 2000.0
const STALL_ANGLE = PI / 2.2
const GROUND_LEVEL = 1.5
const MAX_SPEED = 100 # m/s 360km/h
const DRAG_FACTOR = MAX_THRUST / MAX_SPEED / MAX_SPEED
const LIFT_FACTOR = 600.0

var rudder = 0.0
var elevator = 0.0
var ailerons = 0.0
var thrust = 0.0
var wind_velocity = Vector3(0, 0, -1)

func _process(delta):
	process_inputs(delta * SERVO_SPEED)
	control_surfaces()
	$RB.set_forces(thrust * MAX_THRUST, wind_velocity, DRAG_FACTOR, LIFT_FACTOR, elevator, ailerons, rudder)

func control_surfaces():
	var axis = Vector3(1, 0, 0)
	rotate_object(axis, $RB/Elevator, elevator)
	rotate_object(axis, $RB/LeftAileron, -ailerons)
	rotate_object(axis, $RB/RightAileron, ailerons)
	axis = Vector3(0, 1, 0)
	rotate_object(axis, $RB/Rudder, rudder)

func rotate_object(axis, ob, amount):
	ob.transform.basis = Basis() # reset rotation
	ob.rotate_object_local(axis, amount * MAX_PHI)

func process_inputs(d):
	if Input.is_action_pressed("ui_up"):
		elevator += d
	if Input.is_action_pressed("ui_down"):
		elevator -= d
	if Input.is_action_pressed("ui_left"):
		ailerons -= d
	if Input.is_action_pressed("ui_right"):
		ailerons += d
	if Input.is_action_pressed("ui_rudder_left"):
		rudder -= d
	if Input.is_action_pressed("ui_rudder_right"):
		rudder += d
	if Input.is_action_pressed("ui_more_thrust"):
		thrust += d
	if Input.is_action_pressed("ui_less_thrust"):
		thrust -= d
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	# limit range of values
	elevator = clamp(elevator, -1, 1)
	ailerons = clamp(ailerons, -1, 1)
	rudder = clamp(rudder, -1, 1)
	thrust = clamp(thrust, 0, 1)
