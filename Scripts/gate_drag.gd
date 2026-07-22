extends CollisionShape2D

@onready var node: Node2D = $"../.."
var dragging : bool = false
var offset = Vector2(0,0)

func _process(delta: float) -> void:
	if dragging:
		node.global_position = get_global_mouse_position() + offset

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_RIGHT:
				node.queue_free()
			if event.button_index == MOUSE_BUTTON_LEFT:
				dragging = true
				offset = global_position - get_global_mouse_position()
		else:
			dragging = false
