extends KinematicBody2D

const GRAVITY = 20
const WALK_SPEED = 200
var JumpHeight = -700
var resistance = 100

var velocity = Vector2()

onready var globalAnim = $AnimationPlayer
onready var spriteAnim = $Animacion

var attacking : bool = false

func _ready():
	update_gui()
#	GUI._set_visible(true)

func update_gui():
	get_tree().call_group("GAME", "_set_life", resistance)
	
func _on_exit_tree():
	GUI._set_visible(false)

func _physics_process(delta):
	velocity.y += GRAVITY
	
	if !attacking && Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
		spriteAnim.flip_h = true
		spriteAnim.play("Run")
	elif  !attacking && Input.is_action_pressed("ui_right"):
		velocity.x =  WALK_SPEED
		spriteAnim.flip_h = false
		spriteAnim.play("Run")
	elif  !attacking :
		velocity.x = 0
		spriteAnim.play("Still")
		
	if !attacking and Input.is_action_just_pressed("Touch"):
		DoAttack()
		
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			velocity.y = JumpHeight  
		

	velocity = move_and_slide(velocity, Vector2(0, -1)) 


func DoAttack():
	attacking = true
	velocity.x = 0
	spriteAnim.play("Attack")
	globalAnim.play("attack")
	yield(get_tree().create_timer(1.3), "timeout")
	attacking = false
