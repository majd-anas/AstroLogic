extends Panel

@export var gate: String

func _get_drag_data(at_position: Vector2) -> Variant:
	if not gate:
		return
		
	var preview = duplicate()
	var c = Control.new()
	c.add_child(preview)
	preview.position -= Vector2(50, 50)
	preview.self_modulate = Color.TRANSPARENT
	c.modulate = Color(c.modulate, 0.5)	
	set_drag_preview(c)
	
	return gate
