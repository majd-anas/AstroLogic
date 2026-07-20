extends TextureButton

func _on_pressed() -> void:
	print(name)
	var Level = "res://Scenes/Planets/"+name+".tscn" #LevelsScrean path gose here
	get_tree().change_scene_to_file(Level)
	print(Level)

func _on_mouse_entered() -> void:
	self_modulate.v-=0.55
	self_modulate.s+=0.1

func _on_mouse_exited() -> void:
	self_modulate.v+=0.55
	self_modulate.s-=0.1
