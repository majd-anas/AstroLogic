extends Button

@onready var input_1: Button = $"../Input1"
@onready var input_2: Button = $"../Input2"

const WIRE = preload("uid://bssrojb7p4vvf")
var expression

func _process(delta: float) -> void:
	if input_1.text == "1" or input_2.text == "1":
		text = "1"
	else:
		text = "0"
		
	expression = "(" + input_1.expression + ") or (" + input_2.expression + ")"
	print(expression)
func _on_pressed() -> void:
	var wire = WIRE.instantiate()
	add_child(wire)
