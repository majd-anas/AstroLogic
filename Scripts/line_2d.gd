extends Line2D

const WIRE = preload("uid://bssrojb7p4vvf")
var line2d_script = load("uid://b78fydtcc5l6s")
var source: Button = null
var button_center

var is_extending = false
var destination = null

func _ready() -> void:
	width = 3
	default_color = Color.BLACK
	if get_parent() is Button:
		source = get_parent()
		button_center = source.global_position + (source.size / 2)
		start_connection(to_local(button_center))
	else:
		source = get_parent().source
		start_connection(get_local_mouse_position())
	

func _process(delta: float) -> void:
	if is_extending:
		set_point_position(1, get_local_mouse_position())
		if not CircuitsManager.extending:
			set_point_position(1, to_local(CircuitsManager.destination_position))
			destination = CircuitsManager.destination
			is_extending = false

	if destination != null:
		set_point_position(1, to_local(destination.global_position) + (destination.size / 2))
		

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if is_point_near_line(get_local_mouse_position(), width / 2.0):
			if event.button_index == MOUSE_BUTTON_RIGHT:
				terminate_connection()
			
			if event.button_index == MOUSE_BUTTON_LEFT and not CircuitsManager.extending:
				var new_wire = WIRE.instantiate()
				add_child(new_wire)
			
			
func is_point_near_line(click_pos: Vector2, tolerance: float) -> bool:
	if points.size() < 2:
		return false
		
	var p1 = points[0]
	var p2 = points[1]
	var closest_point = Geometry2D.get_closest_point_to_segment(click_pos, p1, p2)

	if click_pos.distance_to(closest_point) <= tolerance:
		return true
		
	return false


#func _on_output_pressed() -> void:
	#if CircuitsManager.extending:
		#return
	#terminate_connection()
	#button_center = source.global_position + (source.size / 2)
	#start_connection(to_local(button_center))

func start_connection(coordinates : Vector2) -> void:
	add_point(coordinates)
	add_point(get_local_mouse_position())
	is_extending = true
	CircuitsManager.extending = true
	CircuitsManager.value = source.text
	CircuitsManager.source = source
	CircuitsManager.line = self

func terminate_connection() -> void:
	if destination != null:
		destination.source = null
	#CircuitsManager.extending = false
	if get_child_count() > 0:
		get_child(0).set_point_position(0,points[0])
		get_child(0).reparent(get_parent())
	
	queue_free()
