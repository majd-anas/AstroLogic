extends Button

const WIRE = preload("uid://bssrojb7p4vvf")
var expression = text

func _on_pressed() -> void:
	var wire = WIRE.instantiate()
	add_child(wire)
