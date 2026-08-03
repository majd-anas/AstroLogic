extends Control


@onready var name_label = $NinePatchRect/Label
@onready var text_label = $NinePatchRect/RichTextLabel

func set_text(name, text):
	if name != "":
		name_label.text = name

	text_label.text = text
