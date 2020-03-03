extends Area2D

export(String, FILE, "*.tscn") var Teleport

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies: 
		if body.name == "Spelare":
			get_tree().change_scene(Teleport)