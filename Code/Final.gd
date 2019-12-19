extends Node2D

func _ready():
	get_node("Timer").start()
	pass # Replace with function body.

func _on_Timer_timeout():
	if get_tree().change_scene("res://Inicio.tscn") != OK:
		print("Error al cargar la escena")
	pass # Replace with function body.