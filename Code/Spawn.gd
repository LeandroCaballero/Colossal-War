extends Position2D
export (PackedScene) var coloso2

func _ready():
	pass # Replace with function body.

func _on_Timer_timeout():
	print("SPAWN ENEMY!!!!!")
	var newEnemy = coloso2.instance()
	get_tree().root.get_node("World").add_child(newEnemy)
	newEnemy.global_position = global_position
	pass # Replace with function body.