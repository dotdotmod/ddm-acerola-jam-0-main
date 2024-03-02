extends KinematicBody


var walk_speed := 5.0
var run_speed := 15.0
var model_angular_speed := 0.25
var final_active_speed : float
var velocity : Vector3

onready var camera = $camera_system/SpringArm/Camera
onready var camera_core = $camera_system
onready var model_core = $model_core


func _physics_process(delta):
	
	#Defining physics process specific stuff
	var base_velocity : Vector3
	var raw_input_dir : Vector3
	var active_speed : float
	
	raw_input_dir = Vector3(Input.get_action_strength("move_rightways") - Input.get_action_strength("move_leftways"), 0,
	Input.get_action_strength("move_backwards") - Input.get_action_strength("move_forward"))
	
	var final_input = raw_input_dir.rotated(Vector3.UP, camera.rotation.y).normalized()
	
	if Input.is_action_pressed("sprint"):
		active_speed = final_input.length() + run_speed
	else:
		active_speed = final_input.length() + walk_speed
	
	final_active_speed = lerp(final_active_speed, active_speed, 0.2)
	
	base_velocity = final_input * final_active_speed
	velocity = lerp(velocity, base_velocity, 0.2)
	
	move_and_slide(velocity, Vector3.UP)



