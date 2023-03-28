extends Node2D


func _on_Botao_Comecar_pressed():
	var _change_scene = get_tree().change_scene_to_file("res://Main.tscn")


func _on_Botao_Opcoes_pressed():
	var _change_scene = get_tree().change_scene_to_file("res://Cenas/TelaOpcoes.tscn")


func _on_Botao_Sair_pressed():
	get_tree().quit()
