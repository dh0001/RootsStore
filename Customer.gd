extends KinematicBody2D

enum Direction { UP, DOWN, LEFT, RIGHT }

onready var direction = Direction.RIGHT
export var speed = 50 # How fast the player will move (pixels/sec).

var cust_type = 0

var path: Array = [] # positions of path
var customerNavigation: Navigation2D = null
var destination: Vector2 = Vector2.ZERO
var curr_requested_item = ""

onready var line2d = $Line2D

# Called when the node enters the scene tree for the first time.
func _ready():	
	randomize()
	cust_type = (randi() % 4) + 1
	var items = ["bag1", "bag2", "boot1", "boot2", "hat1", "hat2", "heel1",
	"heel2", "pants1", "pants2", "shirt1", "shirt2"]
	request_item(items[randi() % items.size()])
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
	if customerNavigation and (global_position.distance_to(destination) > 5):
		generate_path()
		velocity = navigate()

	var motion: Vector2 = velocity * delta 
	
	set_direction(motion)
	set_animation(motion.length() == 0)
	move_and_collide(motion)

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
				
func request_item(item: String):
	curr_requested_item = item
	self.get_node("RequestItemTextBox").request_item(item)

func finish_request(given_item: String) -> bool:
	if given_item == curr_requested_item:
		self.get_node("RequestItemTextBox").finish_request()
		return true
	return false

func interact(player: KinematicBody2D):
	if !player.has_item():
		return
		
	var item = player.submit_item()
	if finish_request(item):
		global.score += 100
	else:
		global.score -= 50
