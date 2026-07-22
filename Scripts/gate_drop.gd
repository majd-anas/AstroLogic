extends Control
const AND_GATE = preload("res://Scenes/AND_gate.tscn")
const OR_GATE = preload("res://Scenes/OR_gate.tscn")

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
	
	get_tree().current_scene.add_child(node)
	node.global_position = get_global_mouse_position()
