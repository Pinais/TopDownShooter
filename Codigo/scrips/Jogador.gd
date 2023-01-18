extends Sprite

var velocidade = 150
var movimento = Vector2.ZERO

var projetil = preload("res://projetil.tscn")

var recarregado = true
var morto = false

func _ready():
	Global.jogador = self
	
func _exit_tree():
	Global.jogador = null
	
func _process(delta: float) -> void:
	movimento.x = int(Input.is_action_pressed("direita")) - int(Input.is_action_pressed("esquerda"))
	movimento.y = int(Input.is_action_pressed("baixo")) - int(Input.is_action_pressed("cima"))
	
	global_position.x = clamp(global_position.x, 24, 616)
	global_position.y = clamp(global_position.y, 24, 336)
	
	if morto == false:	
		global_position += velocidade * movimento * delta
	
	if Input.is_action_pressed("atirar") and Global.criacao_no_pai != null and recarregado and morto == false:
		Global.instance_node(projetil, global_position, Global.criacao_no_pai)
		recarregado = false
		$tempo_recarga.start()


func _on_tempo_recarga_timeout():
	recarregado = true


func _on_hitbox_area_entered(area):
	if area.is_in_group("inimigo"):
		visible = false
		morto = true
		yield(get_tree().create_timer(1), "timeout")
		get_tree().reload_current_scene()
