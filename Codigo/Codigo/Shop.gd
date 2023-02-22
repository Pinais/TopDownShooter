extends Node2D


export (Array, PackedScene) var lista_possiveis_itens
export (Array, Vector2) var lista_posicao_item


var item1
var item2
var item3
var item4
var lista_itens := [item1, item2, item3, item4]
var botao_ativo : bool = false


onready var botao_reroll := $BotaoReroll
onready var gerente_itens := $GerenteItens


func _ready():
	trocar_itens()


func trocar_itens():
	var qtd_itens = len(lista_itens)
	var i = 0
	while(i < qtd_itens):
		if lista_itens[i] != null and is_instance_valid(lista_itens[i]):
			lista_itens[i].queue_free()
			gerente_itens.remove_child(lista_itens[i])
			
		var item_escolhido = lista_possiveis_itens[int(rand_range(0, len(lista_possiveis_itens)))]
		lista_itens[i] = instanciar_posicao(item_escolhido, gerente_itens, lista_posicao_item[i], Vector2(5,5))
		i += 1


func instanciar_posicao(objeto, pai, posicao : Vector2 = Vector2(0,0), escala : Vector2 = Vector2(1,1)):
	var receptaculo = objeto.instance()
	pai.add_child(receptaculo)
	receptaculo.position = posicao
	receptaculo.scale = escala
	return receptaculo


func _unhandled_input(event):
	if event.is_action_pressed("interagir") and botao_ativo:
		trocar_itens()
		pass

func _on_BotaoReroll_area_entered(_area):
	botao_ativo = true

func _on_BotaoReroll_area_exited(_area):
	botao_ativo = false
