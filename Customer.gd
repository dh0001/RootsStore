extends KinematicBody2D

enum Direction { UP, DOWN, LEFT, RIGHT }

onready var direction = Direction.RIGHT
export var speed = 50 # How fast the player will move (pixels/sec).

var cust_type = 0

var path: Array = [] # positions of path
var customerNavigation: Navigation2D = null
var destination: Vector2 = Vector2.ZERO

onready var line2d = $Line2D

# Called when the node enters the scene tree for the first time.
func _ready():	
	randomize()
	cust_type = (randi() % 4) + 1
	
	customerNavigation = get_node("/root/game/CustomerNavigation")
	
func navigate():
	var velocity = Vector2.ZERO
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * speed
		
		if global_position == path[0]:
			path.pop_front()
	return velocity
	
func generate_path():
	if customerNavigation != null:
		path = customerNavigation.get_simple_path(global_position, destination, false)
	line2d.points = path


func _physics_process(delta):
	var velocity = Vector2.ZERO
	line2d.global_position = Vector2.ZERO
	if customerNavigation and (global_position.distance_to(destination) > 2):
		generate_path()
		velocity = navigate()

	var motion: Vector2 = velocity * delta 
	
	set_direction(motion)
	set_animation(motion.length() == 0)
	move_and_collide(motion)
	
func get_velocity():
	var velocity = Vector2.ZERO
	velocity.x -= 1
#	if Input.is_action_pressed("move_right"):
#		velocity.x += 1
#	if Input.is_action_pressed("move_left"):
#		velocity.x -= 1
#	if Input.is_action_pressed("move_up"):
#		velocity.y -= 1
#	if Input.is_action_pressed("move_down"):
#		velocity.y += 1
		
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

	$AnimatedSprite.animation = "customer" + str(cust_type) + "_" + dir
	$AnimatedSprite.play()
