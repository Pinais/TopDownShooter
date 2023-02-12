extends Sprite


signal mudar_vida
signal mudar_pontuacao
signal conectar_arma
signal jogador_morreu
signal mudar_arma_hud


export var vida_max : int = 100
export var vida_atual : int = 100
export var velocidade : int = 250
export var armadura : int = 0


var movimento : Vector2 = Vector2.ZERO
var posicao_arma : Vector2 = Vector2(-16, 16)
var qtd_dano = 0
var invencivel = false
var esta_vivo = true
var pontuacao = 0
var vetor_itens_chao = []


onready var arma = $Arma
onready var tempo_invencibilidade = $TempoInvencibilidade


func _ready():
	arma.inicializar(posicao_arma)
	emit_signal("mudar_arma_hud", arma.imagem_arma)


func _process(_delta:float) -> void:
	if esta_vivo:
		movimento.x = int(Input.is_action_pressed("direita")) - int(Input.is_action_pressed("esquerda"))
		movimento.y = int(Input.is_action_pressed("baixo")) - int(Input.is_action_pressed("cima"))
		movimentar(movimento, velocidade, _delta)
		
		look_at(get_global_mouse_position())
		
		if Input.is_action_pressed("atirar"):
			arma.atirar(get_parent())
		if qtd_dano > 0:
			tomar_dano(qtd_dano)


func movimentar(_movimento:Vector2, _velocidade: int, _delta: float) -> void:
	global_position += (_movimento).normalized() * _velocidade * _delta	


func pegar_arma(nova_arma):
	arma.queue_free()
	self.remove_child(arma)
	
	arma = nova_arma.duplicate()
	nova_arma.queue_free()
	nova_arma.get_parent().remove_child(nova_arma)
	
	call_deferred("add_child",arma)
	arma.position = posicao_arma
	
	arma.inicializar(posicao_arma)
	emit_signal("conectar_arma", arma)
	emit_signal("mudar_arma_hud", arma.imagem_arma)


func tomar_dano(_dano):
	if not invencivel:
		vida_atual -= _dano
		emit_signal("mudar_vida", _dano)
		tempo_invencibilidade.start()
		invencivel = true
	if vida_atual <= 0:
		morrer()


func morrer():
	esta_vivo = false
	visible = false
	emit_signal("jogador_morreu")


func nova_tentativa():
	vida_atual = vida_max
	emit_signal("mudar_vida", -vida_max)
	emit_signal("mudar_pontuacao", -pontuacao)
	pontuacao = 0
	arma.recarregar(0.1)
	global_position = Vector2(640,360)
	esta_vivo = true
	visible = true


func pontuar(valor:int):
	pontuacao += valor
	emit_signal("mudar_pontuacao", valor)


func _unhandled_input(event):
	if event.is_action_pressed("recarregar"):
		if esta_vivo:
			arma.recarregar()
	if event.is_action_pressed("interagir"):
		if not vetor_itens_chao.empty():
			pegar_arma(vetor_itens_chao[len(vetor_itens_chao)-1])


func _on_Area2D_area_entered(area):
	if area.is_in_group("area_arma"):
		var arma_chao = area.get_parent()
		if arma_chao != arma:
			vetor_itens_chao.append(arma_chao)
	
	if area.is_in_group("pontos"):
		var pontos = area.get_parent()
		pontuar(pontos.scale.x * 10)
		pontos.queue_free()
	
	if area.is_in_group("inimigo"):
		qtd_dano += area.get_parent().dano


func _on_Area2D_area_exited(area):
	if area.is_in_group("inimigo"):
		qtd_dano = clamp(qtd_dano - area.get_parent().dano, 0, 1000)
	if area.is_in_group("area_arma"):
		var arma_chao = area.get_parent()
		vetor_itens_chao.erase(arma_chao)


func _on_TempoInvencibilidade_timeout():
	invencivel = false
