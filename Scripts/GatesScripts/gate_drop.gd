extends Control
const AND_GATE = preload("res://Scenes/AND_gate.tscn")
const OR_GATE = preload("res://Scenes/OR_gate.tscn")
const XOR_GATE = preload("res://Scenes/XOR_gate.tscn")
const INVERTER = preload("res://Scenes/Inverter.tscn")

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	var node
	if not data:
		return
	if data == "AND":
		node = AND_GATE.instantiate()
		
	elif data == "OR":
		node = OR_GATE.instantiate()
	
	elif data == "XOR":
		node = XOR_GATE.instantiate()
	
	elif data == "Inverter":
		node = INVERTER.instantiate()
	
	get_tree().current_scene.add_child(node)
	node.global_position = get_global_mouse_position()
