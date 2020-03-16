#WorldComplet.gd
extends Area2D

export(String, FILE, "*.tscn") var NextWorld

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Apple":
			get_tree().change_scene(NextWorld)  