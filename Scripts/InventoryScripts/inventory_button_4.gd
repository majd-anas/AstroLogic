extends Button

@onready var side_panel: Panel = $"../../../SidePanel"
@onready var inverter_side_panel: Panel = $"../../../SidePanel/InverterSidePanel"

func _on_pressed() -> void:
	var children  = side_panel.get_children()
	for c in children:
		c.visible = false
	inverter_side_panel.visible = true
