extends Node2D


var dicionario_opcoes = {}


onready var gerente_opcoes = $gerenteOpcoes
onready var bt_facil = $ColorRect/TabContainer/Jogo/Dificuldade/BtFacil
onready var bt_medio = $ColorRect/TabContainer/Jogo/Dificuldade/BtMedio
onready var bt_dificil = $ColorRect/TabContainer/Jogo/Dificuldade/BtDificil
onready var opt_bt_limite_fps = $ColorRect/TabContainer/Video/FPS/OptBtLimiteFps
onready var chk_bt_exibir_fps = $ColorRect/TabContainer/Video/ExibirFPS/ChkBtExibirFps


func _ready():
	dicionario_opcoes = gerente_opcoes.carregar_dicionario_opcoes()
	inicializar_opcoes_limite_fps()
	atualizar_iu()


func atualizar_iu():
	#futuramente adicionar as outras opções padrão aqui também
	var dificuldade = dicionario_opcoes["dificuldade"]
	if dificuldade == "facil":
		botao_radio(bt_facil, "facil")
	elif dificuldade == "medio":
		botao_radio(bt_medio, "medio")
	elif dificuldade == "dificil":
		botao_radio(bt_dificil, "dificil")
	
	var limite_fps = int(dicionario_opcoes["index_limite_fps"])
	alterar_limite_fps(limite_fps)
	
	var exibir_fps = bool(dicionario_opcoes["exibir_fps"])
	_on_ChkBtExibirFps_toggled(exibir_fps)
	chk_bt_exibir_fps.pressed = exibir_fps


func inicializar_opcoes_limite_fps():
	opt_bt_limite_fps.add_item("30")
	opt_bt_limite_fps.add_item("60")
	opt_bt_limite_fps.add_item("120")
	opt_bt_limite_fps.add_item("Ilimitado")

func alterar_limite_fps(index : int):
	var fps
	
	if index == 0:
		fps = 30
	elif index == 1:
		fps = 60
	elif index == 2:
		fps = 120
	else:
		fps = 0

	Engine.set_target_fps(fps)
	gerente_opcoes.escrever_dicionario(dicionario_opcoes, "index_limite_fps", index)
	gerente_opcoes.escrever_dicionario(dicionario_opcoes, "valor_limite_fps", fps)
	opt_bt_limite_fps.selected = index

func _on_OptBtLimiteFps_item_selected(index):
	alterar_limite_fps(index)


func _on_ChkBtExibirFps_toggled(button_pressed):
	gerente_opcoes.escrever_dicionario(dicionario_opcoes, "exibir_fps", button_pressed)


func botao_radio(bt_apertado, string_dificuldade):
	bt_facil.pressed =  bt_apertado == bt_facil
	bt_medio.pressed = bt_apertado == bt_medio
	bt_dificil.pressed = bt_apertado == bt_dificil	
	gerente_opcoes.escrever_dicionario(dicionario_opcoes, "dificuldade", string_dificuldade)

func _on_BtFacil_pressed():
	botao_radio(bt_facil, "facil")

func _on_BtMedio_pressed():
	botao_radio(bt_medio, "medio")

func _on_BtDificil_pressed():
	botao_radio(bt_dificil, "dificil")


func reset_pontuacao_max():
	var dicionario_salvar = {
		"maior_pontuacao" : 0,
	}
	
	var arquivo = File.new()
	arquivo.open("user://savegame.save", File.WRITE)
	arquivo.store_line(to_json(dicionario_salvar))
	arquivo.close()

func _on_BtReset_pressed():
	reset_pontuacao_max()


func _on_BtSair_pressed():
	gerente_opcoes.salvar_dicionario_opcoes(dicionario_opcoes)
	var _resultado = get_tree().change_scene("res://MenuInicial.tscn")
