extends Node2D


export (Array, PackedScene) var lista_possiveis_itens


var item1
var item2
var item3
var item4
var botao_ativo := false


onready var botao_reroll := $BotaoReroll
onready var posicao_item1 := $PosicaoItem1
onready var posicao_item2 := $PosicaoItem2
onready var posicao_item3 := $PosicaoItem3
onready var posicao_item4 := $PosicaoItem4


func _ready():
	gerar_itens_aleatorios(true,true,true,true)


func gerar_itens_aleatorios(pos1:bool, pos2:bool, pos3:bool, pos4:bool):
	print("ok")
	var lista_reroll_atual = lista_possiveis_itens.duplicate(true)
	if pos1:
		var tamanho_lista_itens = len(lista_possiveis_itens)
		var valor_aleatorio = int(rand_range(0, tamanho_lista_itens))
		var item_escolhido = lista_possiveis_itens[valor_aleatorio]
		lista_reroll_atual.erase(item_escolhido)
		item1 = item_escolhido.instance()
		item1.position = posicao_item1.position
		item1.scale = Vector2(5,5)
		add_child(item1)
		
	if pos2:
		var tamanho_lista_itens = len(lista_possiveis_itens)
		var item_escolhido = lista_possiveis_itens[int(rand_range(0, tamanho_lista_itens))]
		lista_reroll_atual.erase(item_escolhido)
		item2 = item_escolhido.instance()
		item2.position = posicao_item2.position
		item2.scale = Vector2(5,5)
		add_child(item2)
		
	if pos3:
		var tamanho_lista_itens = len(lista_possiveis_itens)
		var item_escolhido = lista_possiveis_itens[int(rand_range(0, tamanho_lista_itens))]
		lista_reroll_atual.erase(item_escolhido)
		item3 = item_escolhido.instance()
		item3.position = posicao_item3.position
		item3.scale = Vector2(5,5)
		add_child(item3)
		
	if pos4:
		var tamanho_lista_itens = len(lista_possiveis_itens)
		var item_escolhido = lista_possiveis_itens[int(rand_range(0, tamanho_lista_itens))]
		lista_reroll_atual.erase(item_escolhido)
		item4 = item_escolhido.instance()
		item4.position = posicao_item4.position
		item4.scale = Vector2(5,5)
		add_child(item4)

func _unhandled_input(event):
	if event.is_action_pressed("interagir") and botao_ativo:
			gerar_itens_aleatorios(true,true,true,true)

func _on_BotaoReroll_area_entered(area):
	print("ta dentro")
	gerar_itens_aleatorios(true,true,true,true)
	botao_ativo = true
	
func _on_BotaoReroll_area_exited(area):
	print("ta fora")
	botao_ativo = false
