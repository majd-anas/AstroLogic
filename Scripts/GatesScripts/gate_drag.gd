extends CollisionShape2D
@onready var input_1: Button = $"../../Input1"
@onready var input_2: Button = $"../../Input2"
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
				
				if input_1.source != null:
					input_1.incoming_line.terminate_connection()
				if input_2 != null and input_2.source != null:
					input_2.incoming_line.terminate_connection()
					
				node.queue_free()
				
			if event.button_index == MOUSE_BUTTON_LEFT:
				dragging = true
				offset = global_position - get_global_mouse_position()
		else:
			dragging = false
