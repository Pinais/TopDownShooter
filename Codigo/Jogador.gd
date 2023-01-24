extends Sprite


onready var fim_da_arma = $FimDaArma
onready var direcao_projetil = $DirecaoProjetil


var Projetil = preload("res://Projetil.tscn")
var movimento: Vector2 = Vector2.ZERO
var velocidade: int = 100


func _process(_delta:float) -> void:
	movimento.x = int(Input.is_action_pressed("direita")) - int(Input.is_action_pressed("esquerda"))
	movimento.y = int(Input.is_action_pressed("baixo")) - int(Input.is_action_pressed("cima"))
	movimentar(movimento, velocidade, _delta)
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("atirar"):
		atirar()


func movimentar(_movimento:Vector2, _velocidade: int, _delta: float) -> void:
	global_position += (_movimento).normalized() * _velocidade * _delta


func atirar():
	var instancia_projetil = Projetil.instance()
	var movimento_projetil: Vector2 = (direcao_projetil.global_position - fim_da_arma.global_position).normalized()
	var velocidade_projetil: int = 100
	var posicao_projetil = global_position
	instancia_projetil.inicializar(movimento_projetil, velocidade_projetil, posicao_projetil)
	get_parent().add_child(instancia_projetil)
