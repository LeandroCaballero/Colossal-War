extends KinematicBody2D

var site : Array

const GRAVITY = 20
const WALK_SPEED = 50
const arrow = preload("res://Arrow.tscn")

var velocity = Vector2()
var attackReady = false
onready var spriteAnim = $Animacion
enum state { SEARCH, ATTACK}
var currentState = state.SEARCH

func _ready():
	site = get_tree().get_nodes_in_group("siteAttack")
	pass

func _physics_process(delta):
	var sitioVector = site[0].position
	var sitioX = site[0].position.x
	velocity.y += GRAVITY
	var distance = sitioX - position.x
	
	if currentState == state.SEARCH:
		if distance > 10:
			mover(sitioVector, delta)
		else:
			attackReady = true
			currentState = state.ATTACK

	if (currentState == state.ATTACK and attackReady):
		attack()

func mover(pos: Vector2, delta):
	spriteAnim.play("Run")
	var subDistance = position.x - pos.x
	position.x -= subDistance * delta * 0.5

func attack():
	spriteAnim.play("Attack")
	attackReady = false
	get_node("Timer").start()
	var attack = arrow.instance()
	attack.set_position(position)
	get_parent().add_child(attack)
	$Arco.play()
	$TimerSonido.start()

func _on_Timer_timeout():
	attackReady = true
	pass 

func _on_TimerSonido_timeout():
	$Arco.stop()
	pass 