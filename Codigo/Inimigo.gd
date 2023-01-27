extends Sprite


signal soltar_pontos


export var vida_max : int = 10
export var vida_atual : int = 10


export var dano : int = 5

export var velocidade : int = 100
export var movimento : Vector2 = Vector2.ZERO

export var pontos : int = 10


var posicao_jogador : Vector2 = Vector2.ZERO


onready var jogador = get_parent().get_node("Jogador")


func _process(delta):
	if not jogador.esta_vivo:
		queue_free()
	posicao_jogador = jogador.global_position
	look_at(posicao_jogador)
	movimento = jogador.global_position - self.global_position
	global_position += movimento.normalized() * velocidade * delta


func inicializar(posicao : Vector2):
	global_position = posicao


func tomar_dano(_dano : int):
	vida_atual -= _dano
	if vida_atual <= 0:
		morrer()


func morrer():
	queue_free()
	emit_signal("soltar_pontos", pontos, global_position)


func _on_Area2D_area_entered(area):
	if area.is_in_group("tiro"):
		tomar_dano(area.get_parent().dano)
