extends Node2D


var jogador
var valor_etiqueta_pontuacao = 0
var valor_etiqueta_maior_pontuacao = 0
var tamanho_azulejo_municao = Vector2(16,16)


onready var barra_de_vida = $BarraDeVida
onready var etiqueta_pontuacao = $EtiquetaPontuacao
onready var etiqueta_maior_pontuacao = $EtiquetaMaiorPontuacao
onready var etiqueta_fps = $EtiquetaFPS
onready var azulejo_municao = $AzulejoMunicao
onready var imagem_arma = $ImagemArma

func _ready():
	etiqueta_pontuacao.text = str(valor_etiqueta_pontuacao)
	etiqueta_maior_pontuacao.text = str(valor_etiqueta_maior_pontuacao)


func inicializar(_jogador):
	jogador = _jogador
	jogador.connect("mudar_vida", self, "atualizar_valor_barra_vida")
	jogador.connect("mudar_pontuacao", self, "atualizar_valor_etiqueta_pontuacao")
	jogador.arma.connect("mudar_qtd_municao", self, "atualizar_qtd_municao")
	jogador.connect("mudar_arma_hud", self, "atualizar_arma_hud")
	jogador.connect("conectar_arma", self, "conectar_nova_arma")
	barra_de_vida.value = jogador.vida_max
	#azulejo_municao.rect_size.y += jogador.arma.municao_max * tamanho_azulejo_municao.y


func atualizar_valor_fps(valor):
	etiqueta_fps.text = str("FPS: ",valor)


func atualizar_valor_barra_vida(_valor : int):
	barra_de_vida.value -= _valor


func atualizar_valor_etiqueta_pontuacao (_valor : int):
	valor_etiqueta_pontuacao += _valor
	etiqueta_pontuacao.text = str("SCORE: ", valor_etiqueta_pontuacao)


func atualizar_valor_etiqueta_maior_pontuacao(valor):
	valor_etiqueta_maior_pontuacao = valor
	etiqueta_maior_pontuacao.text = str("HIGHSCORE: ", valor)


func verificar_valor_etiqueta_maior_pontuacao():
	if valor_etiqueta_maior_pontuacao < valor_etiqueta_pontuacao: 
		atualizar_valor_etiqueta_maior_pontuacao(valor_etiqueta_pontuacao)


func conectar_nova_arma(nova_arma):
	nova_arma.connect("mudar_qtd_municao", self, "atualizar_qtd_municao")


func atualizar_arma_hud(_imagem_arma):
	if imagem_arma.texture != _imagem_arma:
		imagem_arma.texture = _imagem_arma


func atualizar_qtd_municao (_qtd_municao):
	azulejo_municao.rect_size.y = _qtd_municao * tamanho_azulejo_municao.y
