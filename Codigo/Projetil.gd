extends Sprite
class_name Projetil


var movimento: Vector2 = Vector2.ZERO
var velocidade: int = 100


func _process(delta):
	global_position += movimento * velocidade * delta


func inicializar(_movimento: Vector2, _velocidade:int, posicao_inicial: Vector2):
	movimento = _movimento
	velocidade = _velocidade
	global_position = posicao_inicial
