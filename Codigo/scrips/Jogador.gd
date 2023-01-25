extends Sprite

var movimento = Vector2.ZERO

var velocidade = 150
var tempo_recarga = 0.1
var padrao_tempo_recarga = tempo_recarga
var dano = 1
var dano_padrao = dano
var max_vidas = 3
var vidas = max_vidas

signal mudar_vidas(vidas_jodador)

var reset_poder = []
var projetil = preload("res://projetil.tscn")

var recarregado = true
var morto = false


func _ready():
	Global.jogador = self
	connect("mudar_vidas", get_parent().get_node("UI/Control"), "on_mudar_vidas_jogador")
	emit_signal("mudar_vidas", max_vidas)
	
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
		var instancia_projetil = Global.instance_node(projetil, global_position, Global.criacao_no_pai)
		instancia_projetil.dano = dano
		recarregado = false
		$tempo_recarga.start()


func _on_tempo_recarga_timeout():
	recarregado = true
	$tempo_recarga.wait_time = tempo_recarga


func _on_hitbox_area_entered(area):
	if area.is_in_group("inimigo"):
		vidas -= 1
		emit_signal("mudar_vidas", vidas)
		
	if vidas <= 0:
		visible = false
		morto = true
		yield(get_tree().create_timer(1), "timeout")
		var _change = get_tree().reload_current_scene()


func _on_tempo_recarga_cooldown_timeout():
	if reset_poder.find("tempo_recarga") != null:
		tempo_recarga = padrao_tempo_recarga
		reset_poder.erase("tempo_recarga")
	if reset_poder.find("dano") != null:
		dano = dano_padrao
		reset_poder.erase("dano")
