extends Position2D
export (PackedScene) var coloso2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	print("SPAWN ENEMY!!!!!")
	var newEnemy = coloso2.instance()
	get_tree().root.get_node("World").add_child(newEnemy)
	newEnemy.global_position = global_position
	pass # Replace with function body.
