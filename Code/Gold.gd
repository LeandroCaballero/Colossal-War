extends Area2D
onready var game = get_tree().get_current_scene()

func _ready():
	pass # Replace with function body.

func _on_Gold_body_entered(body):
	if body.name == "Player":
		game.agregarOro()
		queue_free()