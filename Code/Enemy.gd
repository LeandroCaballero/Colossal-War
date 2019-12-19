extends Area2D

onready var hit = preload("res://slash.tscn")
onready var gold = preload("res://Gold.tscn")
onready var game = get_tree().get_current_scene() #tomas el arbol entero y elegis la escena actual
onready var hit_class = preload("res://slash.gd")
onready var spriteAnim = $Animacion

enum state { IDLE = 0, SEARCH, ATTACK}

var currentState = state.IDLE
var life : int = 100
var aldeanos : Array
var HPBar

func _ready():
	aldeanos = get_tree().get_nodes_in_group("Aldeanos")
	HPBar = get_tree().get_nodes_in_group("HPBar")[0]
	pass # Replace with function body.

var attackReady = false
var targetPos : Vector2 = Vector2.ZERO
var targetRef = null

func _process(delta):
	actualizarHPBar()
	if( currentState == state.IDLE and aldeanos.size() > 0):
		targetRef = aldeanos[0]
		targetPos = targetRef.position
		currentState = state.SEARCH

	var distance = position.x - targetPos.x
	
	if(currentState == state.SEARCH):
		if (distance >= 100):
			mover(targetPos, delta)
		else:
			attackReady = true
			currentState = state.ATTACK
	if (currentState == state.ATTACK and attackReady):
		attackBastards()

func mover(pos: Vector2, delta):
	spriteAnim.play("Run")
	var subDistance = position.x - pos.x
	position.x -= subDistance * delta * 0.5

func attackBastards():
	spriteAnim.play("Attack")
	attackReady = false
	get_node("Timer").start()
	if (targetRef != null and targetRef is hit_class == false):
		var attack = hit.instance()
		attack.set_position(position)
		get_parent().add_child(attack)
		get_node("AudioGolpe").play()
		
	else:
		currentState = state.IDLE
		get_node("AudioGolpe").stop()
		aldeanos = get_tree().get_nodes_in_group("Aldeanos")

func _on_Timer_timeout():
	attackReady = true
	pass # Replace with function body.

func receive_damage( hitPoint ):
	life -= hitPoint
	if life <= 0:
		var oro = gold.instance()
		oro.set_position(position)
		get_parent().call_deferred("add_child", oro)
		game.puntuar()
		queue_free()

func _on_Hit_area_entered(area):
	if area.name == "MeleeHitRight" or area.name == "MeleeHitLeft":
		receive_damage(25)
	elif area.name == "Arrow":
		receive_damage(10)

func actualizarHPBar():
	HPBar.value = life 