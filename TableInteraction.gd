extends StaticBody2D

var nodeToItem = {
	"Bag1Table": "bag1",
	"Bag2Table": "bag2",
	"Boots1Table": "boots1",
	"Boots2Table": "boots2",
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
	if player.has_method('acquire_item') and nodeToItem.has(self.name):
		player.acquire_item(nodeToItem[self.name])
