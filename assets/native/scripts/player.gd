extends KinematicBody


#Params
var walk_speed := 5.0
var run_speed := 12.0
var model_angular_speed := 0.25
var disable_movement := false

#Pre-function requirments
var final_active_speed : float
var velocity : Vector3
var gravity_calc : float
var text_box_open : bool

#ALL the onready stuff
onready var camera = $camera_system/camera_pivot/Camera
onready var camera_core = $camera_system
onready var model_core = $model_core
onready var minimap_elements = $"UI_elements/UI/minimap/ViewportContainer/Viewport/minimap_elements"
onready var minimap_camera_element = $"UI_elements/UI/minimap/ViewportContainer/Viewport/minimap_elements/minimap_camera"
onready var interact_ray = $model_core/raycasts/interact
onready var ui_animation_player = $UI_elements/ui_animations
onready var text_box_chara_portrait = $UI_elements/UI/textbox/portrait
onready var text_box_text = $UI_elements/UI/textbox/text_box_rect/text
onready var interactability_indicator = $UI_elements/UI/interact/HBoxContainer

#Text box
func open_text_box(with_portrait:bool, text:String, disable_move:bool):
	if with_portrait == true:
		text_box_chara_portrait.visible = true
	else:
		text_box_chara_portrait.visible = false
	
	text_box_text.text = text
	text_box_text.visible_characters = 0
	text_box_open = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	ui_animation_player.play("open_text_box")
	disable_movement = disable_move

func update_text_box(new_text:String):
	text_box_text.text = new_text
	text_box_text.visible_characters = 0

func close_text_box():
	text_box_open = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	disable_movement = false
	ui_animation_player.play_backwards("open_text_box")

#Main loop
func _physics_process(delta):
	
	#Defining physics process specific stuff
	var base_velocity : Vector3
	var raw_input_dir : Vector3
	var active_speed : float
	
	raw_input_dir = Vector3(Input.get_action_strength("move_rightways") - Input.get_action_strength("move_leftways"), 0,
	Input.get_action_strength("move_backwards") - Input.get_action_strength("move_forward"))
	
	var final_input = raw_input_dir.rotated(Vector3.UP, camera.global_rotation.y).normalized()
	
	#Interacting with stuff
	if interact_ray.is_colliding():
		if interact_ray.get_collider().is_in_group("Interactable") and disable_movement == false:
			interactability_indicator.visible = true
			if Input.is_action_just_pressed("interact"):
				interact_ray.get_collider().interact()
				interact_ray.get_collider().interaction = self
		else:
			interactability_indicator.visible = false
	else:
		interactability_indicator.visible = false
	
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
	
	#Model rotation
	if final_input and not disable_movement:
		model_core.global_rotation.y = lerp_angle(model_core.global_rotation.y, atan2(-final_input.x, -final_input.z), 0.1)
	
	#Gravity and stuff
	if not is_on_floor():
		gravity_calc -= 20 * delta
		velocity.y = gravity_calc
	else:
		gravity_calc = 0
		velocity.y = gravity_calc
	
	#One last check..
	if disable_movement == true:
		velocity = Vector3()
	
	#Move and slide
	move_and_slide(velocity, Vector3.UP)

func _process(delta):
	#Minimap stuff
	minimap_elements.global_translation = global_translation
	minimap_camera_element.global_rotation.y = camera.global_rotation.y
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	#Text box ui stuff
	if text_box_open:
		text_box_text.visible_characters += ceil(1 * delta)


#all programmers trauma dump in their code's comments
#the sad part is nobody gets to see them
