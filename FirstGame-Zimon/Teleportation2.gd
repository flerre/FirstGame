
extends Area2D
#export var Teleport = Vector2(96, 508)
export(Vector2) var Teleport = Vector2(96, 508)

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies: 
		if body.name == "Spelare":
			body.set_position(Teleport)

