extends Area2D

onready var boom = preload("res://Explosión.tscn")
onready var game = get_tree().get_current_scene()
var resistance : int = 100
onready var spriteAnim = $AnimatedSprite

func _ready():
	spriteAnim.play("Casa normal")
	pass # Replace with function body.

func _process(_delta):
	pass

func _on_Slash_body_entered(body):
	if body.name == "Slash":
		receive_damage(10)
	pass # Replace with function body.

func receive_damage( hitPoint : int = 2):
	resistance -= hitPoint
	if resistance < 70:
		spriteAnim.play("Destruida 1")
	if resistance < 30:
		spriteAnim.play("Destruida 2")
	if resistance <= 0:
		var explosion = boom.instance()
		explosion.set_position(position)
		get_parent().add_child(explosion)
		game.quitarVida()
		queue_free()