extends Area2D

var resistance : int = 10000


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


func receive_damage( hitPoint ):
	resistance -= hitPoint
#	print("Attack to resistance ", resistance)
	if resistance <= 0:
		print("te quedaste sin casa, sonaste, a la calle")
		queue_free()

func _on_Slash_body_entered(body):
	if body.name == "Slash":
		receive_damage(2)
		print("SLASHER")
	pass # Replace with function body.