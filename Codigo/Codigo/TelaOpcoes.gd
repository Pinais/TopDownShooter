extends Node2D


var dicionario_opcoes = {}


onready var bt_facil = $Dificuldade/BtFacil
onready var bt_medio = $Dificuldade/BtMedio
onready var bt_dificil = $Dificuldade/BtDificil


func _ready():
	carregar_dicionario_opcoes()
	atualizar_iu()


func carregar_dicionario_opcoes():
	var arquivo = File.new()
	if arquivo.file_exists("user://config.cfg"):
		arquivo.open("user://config.cfg", File.READ)
		dicionario_opcoes = parse_json(arquivo.get_line())
		arquivo.close()
	else:
		criar_dicionario_padrao()
		salvar_dicionario_opcoes()


func escrever_dicionario(chave : String, valor):
	dicionario_opcoes[chave] = valor


func criar_dicionario_padrao():
	#futuramente adicionar as outras opções padrão aqui também
	dicionario_opcoes["dificuldade"] = "facil"


func salvar_dicionario_opcoes():
	var arquivo = File.new()
	arquivo.open("user://config.cfg", File.WRITE)
	arquivo.store_line(to_json(dicionario_opcoes))
	arquivo.close()


func atualizar_iu():
	#futuramente adicionar as outras opções padrão aqui também
	var dificuldade = dicionario_opcoes["dificuldade"]
	if dificuldade == "facil":
		botao_radio(bt_facil, "facil")
	elif dificuldade == "medio":
		botao_radio(bt_medio, "medio")
	elif dificuldade == "dificil":
		botao_radio(bt_dificil, "dificil")


func botao_radio(bt_apertado, string_dificuldade):
	bt_facil.pressed =  bt_apertado == bt_facil
	bt_medio.pressed = bt_apertado == bt_medio
	bt_dificil.pressed = bt_apertado == bt_dificil	
	escrever_dicionario("dificuldade", string_dificuldade)


func _on_BtFacil_pressed():
	botao_radio(bt_facil, "facil")

func _on_BtMedio_pressed():
	botao_radio(bt_medio, "medio")

func _on_BtDificil_pressed():
	botao_radio(bt_dificil, "dificil")


func _on_BtSair_pressed():
	salvar_dicionario_opcoes()
	var _resultado = get_tree().change_scene("res://MenuInicial.tscn")
