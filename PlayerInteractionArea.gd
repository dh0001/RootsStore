extends Area2D

func interact(areas: Array) -> void:
#	print(areas)
	if areas.size() == 0:
		return
	
	var area = areas[0] # only interact with the 0th element
	if area.has_method("interact"):
		area.interact(self.get_parent())

func _input(ev):
	if ev.is_action_pressed("select"):
		interact(self.get_overlapping_bodies())
