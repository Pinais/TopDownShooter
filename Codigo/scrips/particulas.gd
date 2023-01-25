extends Node2D

var fade = false

var alpha = 1

func _process(_delta):
	if fade:
		alpha = lerp(alpha, 0, 0.1)
		modulate.a = alpha
		
	if alpha < 0.05:
		queue_free()	

func _on_timer_fade_timeout():
	fade = true
