extends Spatial

const SERVO_SPEED = 1.0
const MAX_PHI = PI / 4.0
const MAX_THRUST = 2000.0
const G = 9.8
const MASS = 100.0
const STALL_ANGLE = PI / 2.2
const GROUND_LEVEL = 0.5

var rudder = 0.0
var elevator = 0.0
var ailerons = 0.0
var thrust = 0.0
var speed = 0.0
var altitude = GROUND_LEVEL
var yaw = 0.0
var roll = 0.0
var pitch = 0.0
var wind = Vector3(0, 0, -1)

func _process(delta):
	process_inputs(delta * SERVO_SPEED)
	control_surfaces()
	apply_thrust()

func apply_thrust():
	$RB.thrust = thrust * MAX_THRUST

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
	if Input.is_action_pressed("ui_quit"):
		get_tree().quit()
	# limit range of values
	elevator = clamp(elevator, -1, 1)
	ailerons = clamp(ailerons, -1, 1)
	rudder = clamp(rudder, -1, 1)
	thrust = clamp(thrust, 0, 1)
