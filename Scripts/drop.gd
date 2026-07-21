extends Control

const WORLD_ITEM = preload("res://Scenes/world_item.tscn")
const AND_GATE_SCENE = preload("res://Scenes/AND_gate_scene.tscn")

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	var node = AND_GATE_SCENE.instantiate()
	
	get_tree().current_scene.add_child(node)
	
	node.global_position = get_global_mouse_position()
