extends Spatial



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact():
	$AnimationPlayer.play("door")
