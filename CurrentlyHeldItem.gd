extends Sprite

var bag1 = preload("res://art/clothes_sprites/bag1.png")
var bag2 = preload("res://art/clothes_sprites/bag2.png")
var boot1 = preload("res://art/clothes_sprites/boot1.png")
var boot2 = preload("res://art/clothes_sprites/boot2.png")
var hat1 = preload("res://art/clothes_sprites/hat1.png")
var hat2 = preload("res://art/clothes_sprites/hat2.png")
var heel1 = preload("res://art/clothes_sprites/heel1.png")
var heel2 = preload("res://art/clothes_sprites/heel2.png")
var pants1 = preload("res://art/clothes_sprites/pants1.png")
var pants2 = preload("res://art/clothes_sprites/pants2.png")
var shirt1 = preload("res://art/clothes_sprites/shirt1.png")
var shirt2 = preload("res://art/clothes_sprites/shirt2.png")

var item_to_texture = {
	"bag1": bag1,
	"bag2": bag2,
	"boot1": boot1,
	"boot2": boot2,
	"hat1": hat1,
	"hat2": hat2,
	"heel1": heel1,
	"heel2": heel2,
	"pants1": pants1,
	"pants2": pants2,
	"shirt1": shirt1,
	"shirt2": shirt2
}

func set_item_texture(texture: String):
	if item_to_texture.has(texture):
		self.set_texture(item_to_texture[texture])
	else:
		self.set_texture(null)
