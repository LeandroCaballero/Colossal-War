extends Area2D

onready var hit = preload("res://slash.tscn")
 
onready var hit_class = preload("res://slash.gd")
onready var home_class = preload("res://Code/Home.gd")

enum state { IDLE = 0, SEARCH, ATTACK}

var currentState = state.IDLE

var life : int = 40

var aldeanos : Array

# Called when the node enters the scene tree for the first time.

func _ready():
	aldeanos = get_tree().get_nodes_in_group("Aldeanos")
	pass # Replace with function body.

var posCasa = null

var attackReady = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if( currentState == state.IDLE and aldeanos.size() > 0):
		posCasa = aldeanos[0].position
		currentState = state.SEARCH
	
	var distance = position.x - posCasa.x
	if(currentState == state.SEARCH):
		if (distance >= 100):
			mover(posCasa, delta)
		else:
			attackReady = true
			currentState = state.ATTACK
	if (currentState == state.ATTACK and attackReady):
		attackBastards()

func mover(pos: Vector2, delta):
	var subDistance = position.x - pos.x
#	position += velocity
	position.x -= subDistance * delta * 0.5

func attackBastards():
	attackReady = false

	get_node("Timer").start()
#	if (posCasa != null and posCasa is home_class ):
#	if (posCasa != null and posCasa.name == "Bulin"):
	if (posCasa != null and posCasa is hit_class == false):
		var attack = hit.instance()
		attack.set_position(position)
		get_parent().add_child(attack)
#		posCasa.receive_damage(4)
	else:
		currentState = state.IDLE
		aldeanos = get_tree().get_nodes_in_group("Aldeanos")
#		attackReady = false


func _on_Timer_timeout():
	attackReady = true
	pass # Replace with function body.

func receive_damage( hitPoint : int = 2):
	life -= hitPoint
	print("Life: ", life)
	if life <= 0:
		print("Derrotado")
		queue_free()

func _on_Hit_area_entered(area):
	if area.name == "MeleeHitRight":
		print("auch!")
		receive_damage(5)
		
	pass # Replace with function body.