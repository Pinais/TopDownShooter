extends Node2D

export(Array, PackedScene) var inimigos

func _ready():
	Global.criacao_no_pai = self
	Global.pontos = 0
	
func _exit_tree():
	Global.criacao_no_pai = null	


func _on_timer_spawn_inimigo_timeout():
	var posicao_inimigo = Vector2(rand_range(-160, 760), rand_range(-90, 390))

	while posicao_inimigo.x < 640 and posicao_inimigo.x > -80 and posicao_inimigo.y < 360 and posicao_inimigo.y > -45:
		posicao_inimigo = Vector2(rand_range(-160, 760), rand_range(-90, 390))
	
	var numero_inimigos = round(rand_range(0, inimigos.size() - 1))	
	Global.instance_node(inimigos[numero_inimigos], posicao_inimigo, self)

func _on_timer_dificuldade_timeout():
	if $timer_spawn_inimigo.wait_time > 0.50:
		$timer_spawn_inimigo.wait_time -= 0.25
