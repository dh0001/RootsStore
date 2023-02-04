extends Area2D

func interact(areas: Array):
	if areas.size() == 0:
		return
	
	var area = areas[0] # only interact with the 0th element
	print("trying to interact with " + area.name)
	if area.has_method("interact"):
		area.interact()

func _input(ev):
	if Input.is_action_pressed("select"):
		interact(self.get_overlapping_bodies())
