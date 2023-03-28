extends Node2D


signal fim_estado_loja


enum Estado{
	ESPERANDO_ENTRAR,
	ENTRANDO,
	PARADO,
	SAINDO,
}


@export var lista_possiveis_itens : Array[PackedScene]
@export var lista_posicao_item : Array[Vector2]


var velocidade := 100.0
var y_meio_da_tela := 360.0
var estado_loja = Estado.ESPERANDO_ENTRAR
var item1
var item2
var item3
var item4
var lista_itens := [item1, item2, item3, item4]
var botao_loja_ativo : bool = false
var botao_sair_ativo : bool = false


@onready var botao_reroll := $BotaoReroll
@onready var gerente_itens := $GerenteItens


func _ready():
	trocar_itens()


func _process(_delta):
	match estado_loja:
		Estado.ESPERANDO_ENTRAR:
			global_position = Vector2(1080,980)
		Estado.ENTRANDO:
			global_position.y -= velocidade * _delta
			if global_position.y >= y_meio_da_tela and global_position.y <= y_meio_da_tela + 0.3:
				proximo_estado()
		Estado.PARADO:
			pass
		Estado.SAINDO:
			global_position.y -= velocidade * _delta
			if global_position.y == -980:
				proximo_estado()


func proximo_estado():
	if estado_loja == Estado.ESPERANDO_ENTRAR:
		estado_loja = Estado.ENTRANDO
	elif estado_loja == Estado.ENTRANDO:
		estado_loja = Estado.PARADO
	elif estado_loja == Estado.PARADO:
		estado_loja = Estado.SAINDO
	elif estado_loja == Estado.SAINDO:
		estado_loja = Estado.ESPERANDO_ENTRAR


func trocar_itens():
	var qtd_itens = len(lista_itens)
	var i = 0
	while(i < qtd_itens):
		if lista_itens[i] != null and is_instance_valid(lista_itens[i]):
			lista_itens[i].queue_free()
			gerente_itens.remove_child(lista_itens[i])
			
		var item_escolhido = lista_possiveis_itens[int(randf_range(0, len(lista_possiveis_itens)))]
		lista_itens[i] = instanciar_posicao(item_escolhido, gerente_itens, lista_posicao_item[i], Vector2(5,5))
		i += 1


func instanciar_posicao(objeto, pai, posicao : Vector2 = Vector2(0,0), escala : Vector2 = Vector2(1,1)):
	var receptaculo = objeto.instantiate()
	pai.add_child(receptaculo)
	receptaculo.position = posicao
	receptaculo.scale = escala
	return receptaculo


func _unhandled_input(event):
	if event.is_action_pressed("interagir") and botao_loja_ativo:
		trocar_itens()
	if event.is_action_pressed("interagir") and botao_sair_ativo:
		proximo_estado()
		emit_signal("fim_estado_loja")

func _on_BotaoReroll_area_entered(_area):
	botao_loja_ativo = true

func _on_BotaoReroll_area_exited(_area):
	botao_loja_ativo = false


func _on_BotaoSairLoja_area_entered(_area):
	botao_sair_ativo = true

func _on_BotaoSairLoja_area_exited(_area):
	botao_sair_ativo = false
