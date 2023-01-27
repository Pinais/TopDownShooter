extends Node2D


signal mudar_qtd_municao


export var Projetil : PackedScene = preload("res://Projetil.tscn")
export var duracao_intervalo_tiro : float = 0.05
export var duracao_tempo_recarga : float = 2
export var alcance : float = 0.5
export var dano : int = 20
export var municao_max : int = 20
export var municao_atual : int = municao_max
export var velocidade_projetil : int = 200


var pode_atirar : bool = true
var recarregando : bool = false


onready var fim_da_arma = $FimDaArma
onready var direcao_projetil = $DirecaoProjetil
onready var intervalo_tiro = $IntervaloTiro
onready var tempo_recarga = $TempoRecarga


func _ready():
	intervalo_tiro.wait_time = duracao_intervalo_tiro
	tempo_recarga.wait_time = duracao_tempo_recarga


func inicializar(_position : Vector2):
	position = _position
	scale.x = 2
	scale.y = 2
	municao_atual = 0


func atirar(pai):
	if municao_atual > 0 and pode_atirar and not recarregando:
		var instancia_projetil = Projetil.instance()
		var movimento_projetil: Vector2 = (direcao_projetil.global_position - fim_da_arma.global_position).normalized()
		var posicao_projetil = fim_da_arma.global_position
		instancia_projetil.inicializar(movimento_projetil, velocidade_projetil, posicao_projetil, alcance, dano)
		pai.add_child(instancia_projetil)
		
		municao_atual -= 1
		print(municao_atual)
		emit_signal("mudar_qtd_municao", municao_atual)
		intervalo_tiro.start()
		pode_atirar = false
	elif municao_atual <= 0 and not recarregando:
		recarregar()


func recarregar():
	tempo_recarga.start()
	recarregando = true
	emit_signal("mudar_qtd_municao", municao_atual)


func _on_IntervaloTiro_timeout():
	pode_atirar = true


func _on_TempoRecarga_timeout():
	municao_atual = municao_max
	emit_signal("mudar_qtd_municao", municao_atual)
	recarregando = false
