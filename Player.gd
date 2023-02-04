extends KinematicBody2D

enum Direction { UP, DOWN, LEFT, RIGHT }

onready var direction = Direction.RIGHT
export var speed = 400 # How fast the player will move (pixels/sec).

func _ready():
	# face right on start up
	$AnimatedSprite.animation = "right" 
	
func _physics_process(delta):
	var velocity = get_velocity()
	var motion = velocity * delta 
	
	set_direction(motion)
	set_interaction_box()
	set_animation(motion.length() == 0)
	move_and_collide(motion)
	
func get_velocity():
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

func set_direction(motion):
	if motion.x < 0:
		direction = Direction.LEFT
	elif motion.x > 0:
		direction = Direction.RIGHT
	elif motion.y < 0:
		direction = Direction.UP
	elif motion.y > 0:
		direction = Direction.DOWN

func set_animation(stop_animation: bool):
	if stop_animation:
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 1
		return
		
	var dir = "right"
	match direction:
		Direction.UP: dir = "up"
		Direction.DOWN: dir = "down"
		Direction.LEFT: dir = "left"
		Direction.RIGHT: dir = "right"
	$AnimatedSprite.animation = dir
	$AnimatedSprite.play()
	
func set_interaction_box():
	var dirs_dict = {
		Direction.UP: Vector2(0, -15),
		Direction.DOWN: Vector2(0, 20),
		Direction.LEFT: Vector2(-13, 2.5),
		Direction.RIGHT: Vector2(13, 2.5),
	}
	var box: CollisionShape2D = get_node(@"InteractionBox/InteractionBoxCollisionShape")
	box.position = dirs_dict[direction]
