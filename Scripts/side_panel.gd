extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var children  = get_children()
	for c in children:
		c.visible = false
