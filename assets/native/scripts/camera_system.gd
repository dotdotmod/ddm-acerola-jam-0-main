extends Spatial


var v : float
var h : float

var camera_mode := "Manual"

export var h_sensitivity := 0.5
export var v_sensitivity := 0.5
var camera_lookat_pos = global_translation

onready var cam_pivot = $camera_pivot
onready var camera = $camera_pivot/Camera

func switch_camera_mode(mode:String):
	camera_mode = mode

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion and get_parent().disable_movement == false:
		v -= event.relative.y * v_sensitivity
		v = clamp(v, -40, 40)
		h -= event.relative.x * h_sensitivity

func _process(delta):
	
	match camera_mode:
		"Manual":
			camera.set_as_toplevel(false)
			cam_pivot.spring_length = 5
			v = lerp(v, -10, 0.01)
			cam_pivot.rotation_degrees.y = lerp(cam_pivot.rotation_degrees.y, h, 0.5)
			cam_pivot.rotation_degrees.x = lerp(cam_pivot.rotation_degrees.x, v, 0.5)

