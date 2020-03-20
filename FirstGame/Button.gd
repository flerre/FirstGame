extends Button
export(String, FILE, "*.tscn") var WorldChanger

func _physics_process(delta):
	if 
		get_tree().change_scene(WorldChanger)