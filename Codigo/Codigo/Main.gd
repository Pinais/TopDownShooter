extends Node2D


enum EstadoJogo {
	NORMAL,
	LOJA
}


@export var cena_inimigo : PackedScene = preload("res://Atores/Inimigo.tscn")
@export var cena_ponto : PackedScene = preload("res://Recursos/Ponto.tscn")
@export var lista_armas : Array[PackedScene]


var mostrar_fps : bool
var dicionario_opcoes : Dictionary = {}
var estado_jogo : int = EstadoJogo.NORMAL


@onready var jogador = $Jogador
@onready var hud_jogador = $HUDJogador
@onready var gerente_inimigos = $GerenteInimigos
@onready var gerente_pontos = $GerentePontos
@onready var gerente_armas = $GerenteArmas
@onready var tela_morte = $TelaMorte
@onready var gerente_opcoes = $GerenteOpcoes
@onready var timer_gerar_inimigo = $TimerGerarInimigo
@onready var timer_loja = $TimerLoja
@onready var loja = $Loja


func _ready():
	randomize()
	if jogador.arma.imagem_arma != hud_jogador.imagem_arma:
		hud_jogador.atualizar_arma_hud(jogador.arma.imagem_arma)
	hud_jogador.inicializar(jogador)
	jogador.connect("jogador_morreu", Callable(self, "gerenciar_fim_de_tentativa"))
	loja.connect("fim_estado_loja", Callable(self, "estado_normal"))
	_carregar()
	tela_morte.visible = false
	dicionario_opcoes = gerente_opcoes.carregar_dicionario_opcoes()
	mostrar_fps = dicionario_opcoes["exibir_fps"]


func _process(_delta):
	var fps = Engine.get_frames_per_second()
	if mostrar_fps:
		hud_jogador.atualizar_valor_fps(fps)


func gerar_inimigo_local_aleatorio():
	if jogador.esta_vivo:
		var posicao_aleatoria = Vector2(int(randf_range(-50, 1330)), int(randf_range(-50, 770)))
		while posicao_aleatoria.x > 0 and posicao_aleatoria.x < 1280 and posicao_aleatoria.y > 0 and posicao_aleatoria.y < 720:
			posicao_aleatoria = Vector2(int(randf_range(-50, 1330)), int(randf_range(-50, 770)))
		var inimigo = cena_inimigo.instantiate()
		gerente_inimigos.add_child(inimigo)
		inimigo.inicializar(posicao_aleatoria, jogador)
		
		inimigo.connect("inimigo_morreu", Callable(self, "gerenciar_morte_inimigo"))


func gerenciar_morte_inimigo(pontos : int, chance : float, posicao : Vector2):
	gerar_pontos_posicao(pontos, posicao)
	if randf_range(0, 1) <= chance:
		gerar_item_posicao(posicao)


func gerar_pontos_posicao(quantidade : int, posicao : Vector2):
	var instancia_ponto = cena_ponto.instantiate()
	
	instancia_ponto.scale.x = quantidade / 10.0
	instancia_ponto.scale.y = quantidade / 10.0
	
	gerente_pontos.call_deferred("add_child", instancia_ponto)
	instancia_ponto.global_position = posicao


func gerar_item_posicao(posicao : Vector2):
	var quantidade_armas = len(lista_armas)
	var arma_escolhida = lista_armas[randf_range(0, quantidade_armas)]
	var instancia_arma = arma_escolhida.instantiate()
	
	instancia_arma.z_index = -6
	instancia_arma.scale.x = 5
	instancia_arma.scale.y = 5
	instancia_arma.global_position = posicao
	
	gerente_armas.call_deferred("add_child", instancia_arma)


func gerenciar_fim_de_tentativa():
	hud_jogador.verificar_valor_etiqueta_maior_pontuacao()
	_salvar(hud_jogador.valor_etiqueta_maior_pontuacao)
	for inimigo in gerente_inimigos.get_children():
		inimigo.queue_free()
	
	for ponto in gerente_pontos.get_children():
		ponto.queue_free()
	
	for arma in gerente_armas.get_children():
		arma.queue_free()
	
	tela_morte.visible = true


func nova_tentativa():
	tela_morte.visible = false
	jogador.nova_tentativa()


func _salvar(maior_pontuacao):
	var dicionario_salvar = {
		"maior_pontuacao" : maior_pontuacao,
	}
	var arquivo = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	arquivo.store_line(JSON.stringify(dicionario_salvar))
	arquivo.close()


func _carregar():
	var dicionario_arquivo_carregado = {}
	if FileAccess.file_exists("user://savegame.save"):
		var arquivo = FileAccess.open("user://savegame.save", FileAccess.READ)
		if arquivo.get_length() != 0:
			var test_json_conv = JSON.new()
			test_json_conv.parse(arquivo.get_line())
			dicionario_arquivo_carregado = test_json_conv.get_data()
			arquivo.close()
	else:
		dicionario_arquivo_carregado = {"maior_pontuacao" : 0}
	hud_jogador.atualizar_valor_etiqueta_maior_pontuacao(dicionario_arquivo_carregado["maior_pontuacao"])


func _unhandled_input(event):
	if event.is_action_pressed("recarregar") and not jogador.esta_vivo:
		nova_tentativa()

func _on_TimerGerarInimigo_timeout():
	gerar_inimigo_local_aleatorio()


func estado_normal():
	estado_jogo = EstadoJogo.NORMAL
	timer_gerar_inimigo.start()
	timer_loja.start()

func estado_loja():
	estado_jogo = EstadoJogo.LOJA
	loja.proximo_estado()

func _on_TimerLoja_timeout():
	estado_loja()
	timer_gerar_inimigo.stop()
