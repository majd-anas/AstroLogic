extends Control

const WORLD_ITEM = preload("res://Scenes/world_item.tscn")

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	var node = WORLD_ITEM.instantiate()
	
	#node.set_meta("item_data", data.item)
	
	node.texture = data.item.icon
	
	get_tree().current_scene.add_child(node)
	
	node.global_position = get_global_mouse_position() - Vector2(20, 20)
