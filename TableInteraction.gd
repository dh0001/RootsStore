extends StaticBody2D

var node_to_item = {
	"Bag1Table": "bag1",
	"Bag2Table": "bag2",
	"Boots1Table": "boot1",
	"Boots2Table": "boot2",
	"Hat1Table": "hat1",
	"Hat2Table": "hat2",
	"Heel1Table": "heel1",
	"Heel2Table": "heel2",
	"Pants1Table": "pants1",
	"Pants2Table": "pants2",
	"Shirt1Table": "shirt1",
	"Shirt2Table": "shirt2",
}

func interact(player: KinematicBody2D) -> void:
	if !node_to_item.has(self.name):
		return
	
	var methods = ["submit_item", "acquire_item", "has_item"]
	for method in methods:
		if !player.has_method(method): return
	
	player.acquire_item(node_to_item[self.name])
	
