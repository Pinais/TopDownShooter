extends Node
var dicionario_opcoes : Dictionary

func carregar_dicionario_opcoes():
	print("enviando dictionary")
	if FileAccess.file_exists("user://config.cfg"):
		var arquivo = FileAccess.open("user://config.cfg", FileAccess.READ)
		if  arquivo.get_length() != 0:
			var test_json_conv = JSON.new()
			test_json_conv.parse(arquivo.get_line())
			dicionario_opcoes = test_json_conv.get_data()
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
	var arquivo = FileAccess.open("user://config.cfg", FileAccess.WRITE)
	arquivo.store_line(JSON.stringify(_dicionario_opcoes))
	arquivo.close()
