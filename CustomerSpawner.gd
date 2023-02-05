extends Node

export(PackedScene) var customer_scene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CustSpawnTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CustSpawnTimer_timeout():
	var customer = customer_scene.instance()
	
	customer.position = Vector2(100,100)
	
	add_child(customer)
