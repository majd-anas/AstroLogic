extends Button

@onready var input_1: Button = $"../Input1"

const WIRE = preload("uid://bssrojb7p4vvf")


func _process(delta: float) -> void:
	if input_1.text == "1":
		text = "0"
	else:
		text = "1"


func _on_pressed() -> void:
	var wire = WIRE.instantiate()
	add_child(wire)
