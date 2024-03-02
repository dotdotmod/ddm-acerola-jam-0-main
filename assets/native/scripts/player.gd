extends KinematicBody


var walk_speed := 5.0
var run_speed := 12.0
var model_angular_speed := 0.25
var final_active_speed : float
var velocity : Vector3
var gravity_calc : float

onready var camera = $camera_system/camera_pivot/Camera
onready var camera_core = $camera_system
onready var model_core = $model_core
onready var minimap_elements = $"UI/minimap/ViewportContainer/Viewport/minimap elements"
onready var minimap_camera_element = $"UI/minimap/ViewportContainer/Viewport/minimap elements/minimap camera"

func _physics_process(delta):
	
	#Defining physics process specific stuff
	var base_velocity : Vector3
	var raw_input_dir : Vector3
	var active_speed : float
	
	raw_input_dir = Vector3(Input.get_action_strength("move_rightways") - Input.get_action_strength("move_leftways"), 0,
	Input.get_action_strength("move_backwards") - Input.get_action_strength("move_forward"))
	
	var final_input = raw_input_dir.rotated(Vector3.UP, camera.global_rotation.y).normalized()
	
	#Sprinting
	if Input.is_action_pressed("sprint"):
		active_speed = final_input.length() + run_speed
	else:
		active_speed = final_input.length() + walk_speed
	
	#Final active speed
	final_active_speed = lerp(final_active_speed, active_speed, 0.2)
	
	#Setting the velocities
	base_velocity = final_input * final_active_speed
	velocity = lerp(velocity, base_velocity, 0.2)
	
	if not is_on_floor():
		gravity_calc -= 20 * delta
		velocity.y = gravity_calc
	else:
		gravity_calc = 0
		velocity.y = gravity_calc
	
	#Move and slide
	move_and_slide(velocity, Vector3.UP)

func _process(delta):
	#Minimap stuff
	minimap_elements.global_translation = global_translation
	minimap_camera_element.global_rotation.y = camera.global_rotation.y


