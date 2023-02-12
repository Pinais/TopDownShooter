extends Node2D


export var cena_inimigo : PackedScene = preload("res://Atores/Inimigo.tscn")
export var cena_ponto : PackedScene = preload("res://Recursos/Ponto.tscn")
export (Array, PackedScene) var lista_armas


onready var jogador = $Jogador
onready var hud_jogador = $HUDJogador
onready var gerente_inimigos = $GerenteInimigos
onready var gerente_pontos = $GerentePontos
onready var gerente_armas = $GerenteArmas
onready var tela_morte = $TelaMorte


func _ready():
	randomize()
	if jogador.arma.imagem_arma != hud_jogador.imagem_arma:
		hud_jogador.atualizar_arma_hud(jogador.arma.imagem_arma)
	hud_jogador.inicializar(jogador)
	jogador.connect("jogador_morreu", self, "gerenciar_fim_de_tentativa")
	_carregar()
	tela_morte.visible = false


func _process(_delta):
	var qps = Engine.get_frames_per_second()
	hud_jogador.atualizar_valor_qps(qps)


func gerar_inimigo_local_aleatorio():
	if jogador.esta_vivo:
		var posicao_aleatoria = Vector2(int(rand_range(-50, 1330)), int(rand_range(-50, 770)))
		while posicao_aleatoria.x > 0 and posicao_aleatoria.x < 1280 and posicao_aleatoria.y > 0 and posicao_aleatoria.y < 720:
			posicao_aleatoria = Vector2(int(rand_range(-50, 1330)), int(rand_range(-50, 770)))
		var inimigo = cena_inimigo.instance()
		gerente_inimigos.add_child(inimigo)
		inimigo.inicializar(posicao_aleatoria, jogador)
		
		inimigo.connect("inimigo_morreu", self, "gerenciar_morte_inimigo")


func gerenciar_morte_inimigo(pontos : int, chance : float, posicao : Vector2):
	gerar_pontos_posicao(pontos, posicao)
	if rand_range(0, 1) <= chance:
		gerar_item_posicao(posicao)


func gerar_pontos_posicao(quantidade : int, posicao : Vector2):
	var instancia_ponto = cena_ponto.instance()
	
	instancia_ponto.scale.x = quantidade / 10.0
	instancia_ponto.scale.y = quantidade / 10.0
	
	gerente_pontos.call_deferred("add_child", instancia_ponto)
	instancia_ponto.global_position = posicao


func gerar_item_posicao(posicao : Vector2):
	var quantidade_armas = len(lista_armas)
	var arma_escolhida = lista_armas[rand_range(0, quantidade_armas)]
	var instancia_arma = arma_escolhida.instance()
	
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
	
	var arquivo = File.new()
	arquivo.open("user://savegame.save", File.WRITE)
	arquivo.store_line(to_json(dicionario_salvar))
	arquivo.close()


func _carregar():
	var arquivo = File.new()
	arquivo.open("user://savegame.save", File.READ)
	var dicionario_arquivo_carregado = parse_json(arquivo.get_line())
	arquivo.close()
	hud_jogador.atualizar_valor_etiqueta_maior_pontuacao(dicionario_arquivo_carregado["maior_pontuacao"])


func _unhandled_input(event):
	if event.is_action_pressed("recarregar") and not jogador.esta_vivo:
		nova_tentativa()


func _on_TimerGerarInimigo_timeout():
	gerar_inimigo_local_aleatorio()
