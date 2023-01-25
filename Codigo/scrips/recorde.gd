extends Label

func _ready():
	text = String (Global.recorde)

func _process(_delta):
	if Global.pontos > Global.recorde:
		Global.recorde = Global.pontos
