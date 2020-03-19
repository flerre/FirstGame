extends Control
export(String, FILE, "*.tscn") var WorldChanger
export(String, FILE, "*.tscn") var WorldChanger2

func _on_Spela_pressed():
	get_tree().change_scene(WorldChanger)


func _on_Spela_inte_pressed():
	get_tree().change_scene(WorldChanger2)
