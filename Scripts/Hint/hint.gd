extends Node2D
@export var hint: HintData 
@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text=hint.hint_text
	flash()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func flash() -> void:
	var tween = create_tween()
	tween.set_loops()

	tween.tween_property(label, "modulate:a", 0.0, 1)
	tween.tween_property(label, "modulate:a", 1.0, 0.5)
	
