extends CanvasLayer 

onready var bar = $HBoxContainer/Bars/LifeBar/Gauge 
onready var tween = $Tween
onready var life_points = $HBoxContainer/Bars/LifeBar/Count/BackGround/number
onready var wood_count = $HBoxContainer/Counters/WoodCounter 
onready var stone_count = $HBoxContainer/Counters/StoneCounter
onready var box = $HBoxContainer
#func _ready():
#	var player_max_health = $"..Characters/Player".max_health
#	bar.max_value = player_max_health
#	pass 

func _set_life(life):
	life_points.text = str (life)  
	bar.value = life
	
func _set_wood(count):
	wood_count.text = str (count) 

func _set_stone(count):
	stone_count.text = str (count)

func _set_visible(enable):
	box.visible = enable
	