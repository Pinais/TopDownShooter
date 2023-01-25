extends Sprite

var movimento = Vector2(1, 0)
var velocidade = 250

var dano

var dir_unica = true

func _process(delta):
	if dir_unica == true:
		look_at((get_global_mouse_position()))
		dir_unica = false
	global_position += movimento.rotated(rotation) * velocidade * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
