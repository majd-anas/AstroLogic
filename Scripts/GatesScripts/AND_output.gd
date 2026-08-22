extends Button

@onready var outgoing_wire: Line2D = $"../Line2D"
@onready var input_1: Button = $"../Input1"
@onready var input_2: Button = $"../Input2"
var is_extending = false
var button_center = position + (size / 2)

func _process(delta: float) -> void:
	if input_1.text == "1" and input_2.text == "1":
		text = "1"
	else:
		text = "0"
		
	if is_extending:
		CircuitsManager.gate = self
		CircuitsManager.value = text
		outgoing_wire.set_point_position(1, get_local_mouse_position())


func _on_pressed() -> void:
	outgoing_wire.clear_points()
	outgoing_wire.add_point(button_center)
	outgoing_wire.add_point(get_local_mouse_position())
	is_extending = true
