extends KinematicBody2D

enum Direction { UP, DOWN, LEFT, RIGHT }

export var speed :=  100 # How fast the player will move (pixels/sec).
export(NodePath) var held_item_sprite_path
var held_item_sprite: Sprite
var item: String = "" 

onready var direction = Direction.RIGHT

func _ready():
	# face right on start up
	$AnimatedSprite.animation = "right" 
	held_item_sprite = get_node(held_item_sprite_path)

func _physics_process(delta: float) -> void:
	var velocity := get_velocity()
	var motion := velocity * delta 
	
	set_direction(motion)
	set_interaction_box()
	set_animation(motion.length() == 0)
	move_and_collide(motion)
	
func get_velocity() -> Vector2:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	return velocity.normalized() * speed

func set_direction(motion: Vector2) -> void:
	if motion.x < 0:
		direction = Direction.LEFT
	elif motion.x > 0:
		direction = Direction.RIGHT
	elif motion.y < 0:
		direction = Direction.UP
	elif motion.y > 0:
		direction = Direction.DOWN

func set_animation(stop_animation: bool) -> void:
	if stop_animation:
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 1
		return
		
	var dir := "right"
	match direction:
		Direction.UP: dir = "up"
		Direction.DOWN: dir = "down"
		Direction.LEFT: dir = "left"
		Direction.RIGHT: dir = "right"
	$AnimatedSprite.animation = dir
	$AnimatedSprite.play()
	
func set_interaction_box() -> void:
	var dirs_dict = {
		Direction.UP: Vector2(0, -15),
		Direction.DOWN: Vector2(0, 20),
		Direction.LEFT: Vector2(-13, 2.5),
		Direction.RIGHT: Vector2(13, 2.5),
	}
	var box: CollisionShape2D = get_node(@"InteractionBox/InteractionBoxCollisionShape")
	box.position = dirs_dict[direction]

func acquire_item(other_item: String) -> void:
	print("acquiring item " + other_item)
	item = other_item
	if held_item_sprite.has_method("set_item_texture"):
		held_item_sprite.set_item_texture(other_item)

func has_item() -> bool:
	return self.item != ""

func submit_item() -> String:
	var item_submitting = item
	item = ""
	held_item_sprite.set_item_texture("")
	return item_submitting
	
