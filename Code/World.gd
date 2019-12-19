extends Node2D

var score = 0
var gold = 0
var vidas = 3

func _ready():
	pass # Replace with function body.

func _process(_delta):
	if gold >= 3:
		get_node("Player/Camera2D/ParallaxBackground/CanvasLayer/Archer").disabled = false
	else:
		get_node("Player/Camera2D/ParallaxBackground/CanvasLayer/Archer").disabled = true

func puntuar():
	score += 1
	get_node("Player/Camera2D/ParallaxBackground/CanvasLayer/Killed").text = str(score)
	if score == 14:
		if get_tree().change_scene("res://FinalWin.tscn") != OK:
			print("Error al cargar la escena")
	
func agregarOro():
	gold += 1
	get_node("Player/Camera2D/ParallaxBackground/CanvasLayer/Gold").text = str(gold)
	pass

func quitarOro():
	gold -= 3
	get_node("Player/Camera2D/ParallaxBackground/CanvasLayer/Gold").text = str(gold)
	
func quitarVida():
	vidas -= 1
	if vidas == 0:
		if get_tree().change_scene("res://Final.tscn") != OK:
			print("Error al cargar la escena")