extends Node

export(PackedScene) var customer_scene

var max_customers = 5
var customer_count = 0
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
	
	customer.position = Vector2(250, 50)#Vector2(400, 50)
	customer.destination = generate_destination()
	add_child(customer)
	
	customer_count += 1
	if customer_count >= max_customers:
		$CustSpawnTimer.stop()
	
func generate_destination():
	var destinations: Array = [
		Vector2(100, 120),
		Vector2(100, 200),
		Vector2(280, 170),
		Vector2(370, 180),
		Vector2(350, 50),
		Vector2(285, 150) ]

	return destinations[randi() % destinations.size()]

