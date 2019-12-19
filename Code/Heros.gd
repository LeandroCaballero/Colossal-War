extends KinematicBody2D

onready var game = get_tree().get_current_scene()
onready var globalAnim = $AnimationPlayer
onready var spriteAnim = $Animacion

const GRAVITY = 20
const WALK_SPEED = 200
const archer = preload("res://Arquero.tscn")

var origen : Array
var JumpHeight = -700
var posicion
var velocity = Vector2()
var horRight = false #esta horientado hacia la derecha?
var attacking : bool = false

func _ready():
	origen = get_tree().get_nodes_in_group("Origin")
	posicion = origen[0].position

func _physics_process(_delta):
	velocity.y += GRAVITY
	
	if !attacking && Input.is_action_pressed("ui_left"):
		horRight = false
		velocity.x = -WALK_SPEED
		spriteAnim.flip_h = true
		spriteAnim.play("Run")
	elif  !attacking && Input.is_action_pressed("ui_right"):
		horRight = true
		velocity.x =  WALK_SPEED
		spriteAnim.flip_h = false
		spriteAnim.play("Run")
	elif  !attacking :
		velocity.x = 0
		spriteAnim.play("Still")
		
	if !attacking and Input.is_action_just_pressed("Touch") and horRight == true:
		DoAttackRight()
		$Audio.play()
		$Audio/Timer.start()
	elif !attacking and Input.is_action_just_pressed("Touch") and horRight == false:
		DoAttackLeft()
		$Audio.play()
		$Audio/Timer.start()
		
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			velocity.y = JumpHeight  
		
	velocity = move_and_slide(velocity, Vector2(0, -1)) 

func DoAttackRight():
	attacking = true
	velocity.x = 0
	spriteAnim.flip_h = false
	spriteAnim.play("Attack")
	globalAnim.play("attack")
	yield(get_tree().create_timer(1.3), "timeout")
	attacking = false

func DoAttackLeft():
	attacking = true
	velocity.x = 0
	spriteAnim.flip_h = true
	spriteAnim.play("Attack")
	globalAnim.play("attackLeft")
	yield(get_tree().create_timer(1.3), "timeout")
	attacking = false

func _on_Archer_pressed():
	var arquero = archer.instance()
	arquero.set_position(posicion)
	get_parent().add_child(arquero)
	game.quitarOro()
	pass # Replace with function body.

func _on_Timer_timeout():
	$Audio.stop()
	pass # Replace with function body.