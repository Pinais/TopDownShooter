extends Sprite

export(int) var velocidade = 75
var movimento = Vector2.ZERO
export(int) var recuo = 600
export(int) var hp = 3

var atordoado = false

var particula_sangue = preload("res://particula_sangue.tscn")

onready var cor_atual = modulate

func _process(delta):
	if hp <= 0 and Global.criacao_no_pai != null:
		if Global.camera != null:
			Global.camera.tremer_tela(50, 0.1)
		Global.pontos += 10
		var instancia_particula_sangue = Global.instance_node(particula_sangue, global_position, Global.criacao_no_pai)
		instancia_particula_sangue.rotation = movimento.angle()
		instancia_particula_sangue.modulate = Color.from_hsv(cor_atual.h, 1, 0.3)
		queue_free()

func movimento_basico_inimigo(delta):
	if Global.jogador != null and atordoado == false:
		movimento = global_position.direction_to(Global.jogador.global_position)
		global_position += movimento * velocidade * delta	
	elif atordoado:
		movimento = lerp(movimento, Vector2.ZERO, 0.1)	
		global_position += movimento * delta	
			
	
func _on_hitbox_area_entered(area):
	if area.is_in_group("dano") and atordoado == false:
		modulate = Color.white
		area.get_parent().queue_free()
		movimento = -movimento * recuo
		atordoado = true
		hp -= 1 
		$timer_recuo.start()

func _on_timer_recuo_timeout():
	modulate = cor_atual
	atordoado = false

