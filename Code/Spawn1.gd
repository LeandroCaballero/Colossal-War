extends Position2D
export (PackedScene) var coloso1
export (PackedScene) var coloso2
export (PackedScene) var coloso3

var rng = RandomNumberGenerator.new()
var num: int = 0
var enemies : Array

func _ready():
	enemies = get_tree().get_nodes_in_group("Enemies")
	rng.randomize()
	pass # Replace with function body.

func _process(_delta):
	enemies = get_tree().get_nodes_in_group("Enemies")
	if enemies.size() == 0:
		spawn()

func spawn():
	num = rng.randf_range(1, 4)
	if num == 1:
		var newEnemy = coloso1.instance()
		get_tree().root.get_node("World").add_child(newEnemy)
		newEnemy.global_position = global_position
	elif num == 2:
		var newEnemy = coloso2.instance()
		get_tree().root.get_node("World").add_child(newEnemy)
		newEnemy.global_position = global_position
	else:
		var newEnemy = coloso3.instance()
		get_tree().root.get_node("World").add_child(newEnemy)
		newEnemy.global_position = global_position