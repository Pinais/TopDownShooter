extends Node2D


export var cena_inimigo : PackedScene = preload("res://Inimigo.tscn")
export var cena_ponto : PackedScene = preload("res://Ponto.tscn")


onready var jogador = $Jogador
onready var hud_jogador = $HUDJogador
onready var gerente_inimigos = $GerenteInimigos
onready var gerente_pontos = $GerentePontos

func _ready():
	randomize()
	hud_jogador.inicializar(jogador)


func gerar_inimigo_local_aleatorio():
	if jogador.esta_vivo:
		var posicao_aleatoria = Vector2(int(rand_range(-50, 1330)), int(rand_range(-50, 770)))
		while posicao_aleatoria.x > 0 and posicao_aleatoria.x < 1280 and posicao_aleatoria.y > 0 and posicao_aleatoria.y < 720:
			posicao_aleatoria = Vector2(int(rand_range(-50, 1330)), int(rand_range(-50, 770)))
		var inimigo = cena_inimigo.instance()
		gerente_inimigos.add_child(inimigo)
		inimigo.inicializar(posicao_aleatoria, jogador)
		
		inimigo.connect("soltar_pontos", self, "gerar_pontos_posicao")


func gerar_pontos_posicao(quantidade : int, posicao : Vector2):
	var instancia_ponto = cena_ponto.instance()
	
	instancia_ponto.scale.x = quantidade / 10.0
	instancia_ponto.scale.y = quantidade / 10.0
	
	gerente_pontos.call_deferred("add_child", instancia_ponto)
	instancia_ponto.global_position = posicao


func _on_TimerGerarInimigo_timeout():
	gerar_inimigo_local_aleatorio()
