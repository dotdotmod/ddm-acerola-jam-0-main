extends KinematicBody


var walk_speed := 10.0
var run_speed := 20.0
var model_angular_speed := 0.25

func _physics_process(delta):
	#Defining physics process specific stuff
	var velocity : Vector3
	var raw_input_dir : Vector3
	var active_speed : float
	
	raw_input_dir = Vector3(Input.get_action_strength("move_rightways") - Input.get_action_strength("move_leftways"), 0,
	Input.get_action_strength("move_backwards"))


