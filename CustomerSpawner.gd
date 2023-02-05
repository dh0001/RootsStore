extends Node

export(PackedScene) var customer_scene

var max_customers = 5
var customer_count = 0
var dest_index = 0
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
	if customer_count < max_customers:
		customer_count += 1
		var customer = customer_scene.instance()
		customer.position = Vector2(250, 50)
		
		add_child(customer)
		
func spawn_customer():
	customer_count -= 1
	
