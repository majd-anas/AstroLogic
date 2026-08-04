extends Button

@onready var side_panel: Panel = $"../../../SidePanel"
@onready var xor_side_panel: Panel = $"../../../SidePanel/XORSidePanel"

func _on_pressed() -> void:
	var children  = side_panel.get_children()
	for c in children:
		c.visible = false
	xor_side_panel.visible = true
