#Worldchanger, byter välrdar
extends Area2D
export(String, FILE, "*.tscn") var WorldChanger

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies: 
		if body.name == "Spelare":
			get_tree().change_scene(WorldChanger)