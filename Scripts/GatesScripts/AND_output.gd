extends Button

@onready var outgoing_wire: Line2D = $"../Line2D"
@onready var input_1: Button = $"../Input1"
@onready var input_2: Button = $"../Input2"

const WIRE = preload("uid://bssrojb7p4vvf")
var expression


func _process(delta: float) -> void:
	if input_1.text == "1" and input_2.text == "1":
		text = "1"
	else:
		text = "0"
		
	expression = "(" + input_1.expression + ") and (" + input_2.expression + ")"

func _on_pressed() -> void:
	var wire = WIRE.instantiate()
	add_child(wire)
