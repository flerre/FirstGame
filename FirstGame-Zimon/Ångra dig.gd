extends Control
export(String, FILE, "*.tscn") var WorldChanger

func _on_angra_pressed():
	get_tree().change_scene(WorldChanger)

