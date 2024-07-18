extends Node3D

func _on_speed_up_area_body_entered(body):
	if "implements" in body:
		if body.implements == Interface.IVelocity:
			body.activate_speedup()

	for child in body.get_children():
		if "implements" in child:
			if child.implements == Interface.IVelocity:
				child.activate_speedup()
