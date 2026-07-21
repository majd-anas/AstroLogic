extends Panel

@onready var icon: TextureRect = $Icon
@export var item: ItemData

func _ready() -> void:
	update_ui()

func update_ui() -> void:
	if not item:
		icon.texture = null
		return
	
	icon.texture = item.icon
	tooltip_text = item.item_name

func _get_drag_data(at_position: Vector2) -> Variant:
	if not item:
		return
		
	var preview = duplicate()
	var c = Control.new()
	c.add_child(preview)
	preview.position -= Vector2(50, 50)
	preview.self_modulate = Color.TRANSPARENT
	c.modulate = Color(c.modulate, 0.5)	
	set_drag_preview(c)
	
	return self
