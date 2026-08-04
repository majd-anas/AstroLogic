extends Panel


func _ready() -> void:
	var children  = get_children()
	for c in children:
		c.visible = false
