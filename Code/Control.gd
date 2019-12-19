extends Control

func _on_Empezar_pressed():
	if get_tree().change_scene("res://World.tscn") != OK:
		print("Error al cargar la escena")
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()
	pass # Replace with function body.