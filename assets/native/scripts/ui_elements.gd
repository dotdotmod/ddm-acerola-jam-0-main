extends CanvasLayer


#Base Input device class
var input_device : String

func _input(event):
	if event is InputEventJoypadButton:
		input_device = Input.get_joy_name(0)
	elif event is InputEventKey:
		input_device = "Mouse and Keyboard"

func _process(delta):
	#
	match input_device:
		"PS3 Controller":
			pass
		"PS4 Controller":
			pass
		"PS5 Controller":
			pass
		"DualShock 2":
			pass
		"DualShock 3":
			pass
		"Xbox 360 Controller":
			pass
		"Xbox One Controller":
			pass
		"Xbox One S Controller":
			pass
		"Xbox Series Controller":
			pass
		"Xbox Series X Controller":
			pass

