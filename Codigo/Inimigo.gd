extends Sprite


signal soltar_pontos


export var vida_max : int = 10
export var vida_atual : int = 10
export var armadura : int = 0
export var resistencia : int = 1
export var dano : int = 5
export var velocidade : int = 100
export var pontos : int = 10


var movimento : Vector2 = Vector2.ZERO
var posicao_jogador : Vector2 = Vector2.ZERO
var jogador


func _process(delta):
	if jogador != null:
		posicao_jogador = jogador.global_position
		look_at(posicao_jogador)
		movimento = jogador.global_position - self.global_position
		global_position += movimento.normalized() * velocidade * delta


func inicializar(posicao : Vector2, _jogador):
	global_position = posicao
	jogador = _jogador


func tomar_dano(_dano : int):
	vida_atual -= _dano - armadura
	if vida_atual <= 0:
		morrer()


func morrer():
	queue_free()
	emit_signal("soltar_pontos", pontos, global_position)


func _on_Area2D_area_entered(area):
	if area.is_in_group("tiro"):
		var projetil = area.get_parent()
		tomar_dano(projetil.dano)
		projetil.perfurar(resistencia)
