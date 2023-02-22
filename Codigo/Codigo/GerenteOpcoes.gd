extends Node
var dicionario_opcoes : Dictionary

func carregar_dicionario_opcoes():
	print("enviando dictionary")
	var arquivo = File.new()
	if arquivo.file_exists("user://config.cfg") and arquivo.get_len() != 0:
		arquivo.open("user://config.cfg", File.READ)
		dicionario_opcoes = parse_json(arquivo.get_line())
		arquivo.close()
	else:
		criar_dicionario_padrao()
		salvar_dicionario_opcoes(dicionario_opcoes)
	return dicionario_opcoes

func escrever_dicionario(dicionario:Dictionary, chave : String, valor):
	dicionario[chave] = valor

func criar_dicionario_padrao():
	#futuramente adicionar as outras opções padrão aqui também
	dicionario_opcoes["dificuldade"] = "facil"
	dicionario_opcoes["index_limite_fps"] = 0
	dicionario_opcoes["valor_limite_fps"] = 0
	dicionario_opcoes["exibir_fps"] = false
	return dicionario_opcoes

func salvar_dicionario_opcoes(_dicionario_opcoes : Dictionary):
	var arquivo = File.new()
	arquivo.open("user://config.cfg", File.WRITE)
	arquivo.store_line(to_json(_dicionario_opcoes))
	arquivo.close()
