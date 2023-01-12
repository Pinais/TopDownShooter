extends Sprite

var velocidade = 150
var movimento = Vector2.ZERO

var projetil = preload("res://projetil.tscn")
var recarregado = true

func _process(delta: float) -> void:
	movimento.x = int(Input.is_action_pressed("direita")) - int(Input.is_action_pressed("esquerda"))
	movimento.y = int(Input.is_action_pressed("baixo")) - int(Input.is_action_pressed("cima"))
		
	global_position += velocidade * movimento * delta
	
	if Input.is_action_pressed("atirar") and Global.criacao_no_pai != null and recarregado:
		Global.instance_node(projetil, global_position, Global.criacao_no_pai)
		recarregado = false
		$tempo_recarga.start()


func _on_tempo_recarga_timeout():
	recarregado = true
