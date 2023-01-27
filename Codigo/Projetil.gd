extends Sprite
class_name Projetil


export var dano : int = 5
export var duracao_tempo_projetil = 10
export var velocidade : int = 100
export var perfuracao : int = 2


var movimento : Vector2 = Vector2.ZERO


onready var tempo_projetil := $TempoProjetil


func _ready():
	pass

func _process(delta):
	global_position += movimento * velocidade * delta


func inicializar(_movimento : Vector2, _velocidade : int, alcance : float, _dano : int, _perfuracao : int, rotacao_projetil):
	movimento = _movimento
	rotate(rotacao_projetil)
	velocidade = _velocidade
	tempo_projetil.wait_time = alcance
	dano = _dano
	perfuracao = _perfuracao
	tempo_projetil.start()


func perfurar(qtd_perfuracao : int):
	perfuracao -= qtd_perfuracao
	if(perfuracao <= 0):
		queue_free()


func _on_TempoProjetil_timeout():
	queue_free()
