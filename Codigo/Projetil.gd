extends Sprite
class_name Projetil


var dano : int = 5
var duracao_tempo_projetil = 0.5
var velocidade : int = 100
var movimento : Vector2 = Vector2.ZERO


onready var tempo_projetil := $TempoProjetil


func _ready():
	tempo_projetil.wait_time = duracao_tempo_projetil
	tempo_projetil.start()


func _process(delta):
	global_position += movimento * velocidade * delta


func inicializar(_movimento : Vector2, _velocidade : int, posicao_inicial : Vector2, alcance : float, _dano : int):
	movimento = _movimento
	velocidade = _velocidade
	global_position = posicao_inicial
	duracao_tempo_projetil = alcance
	dano = _dano


func _on_TempoProjetil_timeout():
	queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("inimigo"):
		queue_free()
