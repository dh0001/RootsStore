extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	$TileMap2/RichTextLabel.bbcode_text = "Game Over! Your score is: %s\n\n[center]-- Press A to continue --[/center]" % [global.score]



func _input(event):
	if event.is_action_pressed("select"):
		global.score = 0
		get_tree().change_scene("res://game.tscn")
