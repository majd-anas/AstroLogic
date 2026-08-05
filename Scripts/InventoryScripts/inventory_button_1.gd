extends Button

@onready var side_panel: Panel = $"../../../SidePanel"
@onready var and_side_panel: Panel = $"../../../SidePanel/ANDSidePanel"

func _on_pressed() -> void:
	var children  = side_panel.get_children()
	for c in children:
		c.visible = false
	and_side_panel.visible = true
