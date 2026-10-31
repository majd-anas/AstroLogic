extends Button

@onready var input_1: Button = $"../Input1"

const WIRE = preload("uid://bssrojb7p4vvf")
var expression

func _process(delta: float) -> void:
	if input_1.text == "1":
		text = "0"
	else:
		text = "1"
	
	expression = "not (" + input_1.expression + ")"
	print(expression)
	
func _on_pressed() -> void:
	var wire = WIRE.instantiate()
	add_child(wire)
