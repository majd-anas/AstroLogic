extends Line2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		var mouse_pos = get_local_mouse_position()
		
		if is_point_near_line(mouse_pos, width / 2.0):
			clear_points()


func is_point_near_line(click_pos: Vector2, tolerance: float) -> bool:
	if points.size() < 2:
		return false
		
	for i in range(points.size() - 1):
		var p1 = points[i]
		var p2 = points[i+1]
		
		# Find the closest point on this segment to the click position
		var closest_point = Geometry2D.get_closest_point_to_segment(click_pos, p1, p2)
		
		# Check if the click is within the allowed distance (half the line width)
		if click_pos.distance_to(closest_point) <= tolerance:
			return true
			
	return false
