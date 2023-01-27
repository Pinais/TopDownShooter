extends Node2D


signal mudar_qtd_municao


export var Projetil : PackedScene = preload("res://Projetil.tscn")
export var alcance : float = 2
export var dano : int = 20
export var perfuracao_projetil : int = 1
export var velocidade_projetil : int = 200

export var duracao_intervalo_tiro : float = 0.05
export var duracao_tempo_recarga : float = 2
export var municao_max : int = 20
export var municao_atual : int = municao_max
export var precisao : float = .1


var pode_atirar : bool = true
var recarregando : bool = false


onready var fim_da_arma = $FimDaArma
onready var direcao_projetil = $DirecaoProjetil
onready var intervalo_tiro = $IntervaloTiro
onready var tempo_recarga = $TempoRecarga


func _ready():
	intervalo_tiro.wait_time = duracao_intervalo_tiro
	tempo_recarga.wait_time = duracao_tempo_recarga
	recarregar(0.05)


func inicializar(_position : Vector2):
	position = _position
	scale.x = 2
	scale.y = 2


func atirar(pai):
	if municao_atual > 0 and pode_atirar and not recarregando:
		var instancia_projetil = Projetil.instance()
		var vetor_precisao = Vector2(rand_range(-precisao, precisao), rand_range(-precisao, precisao))
		var _direcao_projetil = direcao_projetil.global_position - vetor_precisao - fim_da_arma.global_position
		var movimento_projetil: Vector2 = (_direcao_projetil).normalized()
		var rotacao_projetil = get_angle_to(movimento_projetil)
		instancia_projetil.global_position = fim_da_arma.global_position
		pai.add_child(instancia_projetil)
		instancia_projetil.inicializar(movimento_projetil, velocidade_projetil, alcance, dano, perfuracao_projetil, rotacao_projetil)
		
		municao_atual -= 1
		print(municao_atual)
		emit_signal("mudar_qtd_municao", municao_atual)
		intervalo_tiro.start()
		pode_atirar = false
		if municao_atual <= 0 and not recarregando:
			recarregar()


func recarregar(_duracao_tempo_recarga = duracao_tempo_recarga):
	tempo_recarga.wait_time = _duracao_tempo_recarga
	tempo_recarga.start()
	recarregando = true
	emit_signal("mudar_qtd_municao", municao_atual)


func _on_IntervaloTiro_timeout():
	pode_atirar = true


func _on_TempoRecarga_timeout():
	municao_atual = municao_max
	emit_signal("mudar_qtd_municao", municao_atual)
	recarregando = false
