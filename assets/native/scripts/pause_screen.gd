extends CanvasLayer

#guys im loosing my mind pleas help me therss only a week left i need to make whole ass gmae in a week
#please

onready var pause_animation_player = $pause_animation
var game_paused := false

func _ready():
	pass # Replace with function body.

func pause():
	if game_paused:
		game_paused = false
		pause_animation_player.play_backwards("pause_anim")
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		pause_animation_player.play("pause_anim")
		game_paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _process(_delta):
	#Make sure the thing is actually paused
	get_tree().paused = game_paused
	#
	if Input.is_action_just_pressed("pause"):
		pause()
