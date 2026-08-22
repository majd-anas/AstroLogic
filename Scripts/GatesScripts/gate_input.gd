extends Button

var button_center = global_position + (size / 2)

func _ready() -> void:
	text = "0"


func _on_pressed() -> void:
	if CircuitsManager.value == null:
		if text == "0":
			text = "1"
		else:
			text = "0"
	else:
		text = CircuitsManager.value
		CircuitsManager.gate.is_extending = false
		CircuitsManager.gate.outgoing_wire.set_point_position(1, button_center)
		print(button_center)
		CircuitsManager.value = null
		CircuitsManager.gate = null
			
