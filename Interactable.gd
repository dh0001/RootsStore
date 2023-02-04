extends Area2D

# What happens if there are multiple other interactable bodies?
var other_body = null


func _input(ev):
	if Input.is_action_pressed("select") and other_body != null:
		if get_parent().has_method("interact"):
			get_parent().interact()
	
func _on_Interactable_body_entered(body):
	print(body.name + " entered")
	other_body = body

func _on_Interactable_body_exited(body):
	print(body.name + " exited")
	other_body = null
