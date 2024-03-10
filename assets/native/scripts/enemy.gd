extends KinematicBody


var delay_speed : float
var next_navigation_point : Vector3
var navig_no : int
var navig_toggle := true
export var max_navig_no := 4
var speed = 10

onready var navigation = $NavigationAgent

func _physics_process(delta):
#	var direction : Vector3
#	next_navigation_point = get_node("../../path/path0/" + str(navig_no) + str(1)).global_translation
#	navigation.set_target_location(next_navigation_point)
#	direction = navigation.get_next_location() - global_translation
#	direction = direction.normalized()
#
#	if navig_toggle == true:
#		var velocity = direction * speed * delta
#		move_and_slide(velocity, Vector3.UP)
	pass

