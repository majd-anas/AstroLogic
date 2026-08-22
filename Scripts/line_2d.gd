extends Line2D

@onready var output: Button = $"../output"
var is_extending = false
var destination = null

func _process(delta: float) -> void:
	if is_extending:
		CircuitsManager.value = output.text
		set_point_position(1, get_local_mouse_position())
		if not CircuitsManager.extending:
			set_point_position(1, to_local(CircuitsManager.destination_position))
			destination = CircuitsManager.destination
			is_extending = false
	if destination != null:
		set_point_position(1, to_local(destination.global_position) + (destination.size / 2))
		
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		var mouse_pos = get_local_mouse_position()
		if is_point_near_line(mouse_pos, width / 2.0):
			clear_points()
			is_extending = false
			CircuitsManager.extending = false
			if destination != null:
				destination.source = null
			destination = null

func is_point_near_line(click_pos: Vector2, tolerance: float) -> bool:
	if points.size() < 2:
		return false
		
	var p1 = points[0]
	var p2 = points[1]
	
	var closest_point = Geometry2D.get_closest_point_to_segment(click_pos, p1, p2)

	if click_pos.distance_to(closest_point) <= tolerance:
		return true
		
	return false


func _on_output_pressed() -> void:
	clear_points()
	if destination != null:
		destination.source = null
	destination = null
	var button_center = to_local(output.global_position) + (output.size / 2)
	add_point(button_center)
	add_point(get_local_mouse_position())
	is_extending = true
	CircuitsManager.extending = true
	CircuitsManager.value = output.text
	CircuitsManager.source = output
	CircuitsManager.destination = null
