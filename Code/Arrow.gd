extends Area2D

const arrowSpeed = 400

func _ready():
	pass # Replace with function body.

func _process(delta):
	var speedX = 1
	var speedY = 0
	var motion = Vector2(speedX, speedY) * arrowSpeed
	position = position + motion * delta

func _on_Arrow_area_entered(area):
	if area.name == "Enemy" or area.name == "Enemy 2" or area.name == "Enemy 3":
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
