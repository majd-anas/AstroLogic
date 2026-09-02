extends Control
@onready var label: Label = $Panel/Label
@onready var label_2: Label = $Panel/Label2
@onready var label_3: Label = $Panel/Label3

var  expression=["A'","B","C"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text=expression[0]
	label_2.text=expression[1]
	label_3.text=expression[2]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
