extends Button

@onready var input_1: Button = $"../Input1"
@onready var input_2: Button = $"../Input2"

const WIRE = preload("uid://bssrojb7p4vvf")


func _process(delta: float) -> void:
	if input_1.text != input_2.text:
		text = "1"
	else:
		text = "0"

func _on_pressed() -> void:
	var wire = WIRE.instantiate()
	add_child(wire)
