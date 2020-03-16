# StartGame.gd
extends Control

func _on_StartGameButton_pressed():
	get_tree().change_scene("res://World.tscn")


func _on_QuitGameButton_pressed():
	get_tree().quit()


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://Options.tscn")
