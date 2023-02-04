extends KinematicBody2D

onready var _animated_sprite = $AnimatedSprite
export var speed = 400 # How fast the player will move (pixels/sec).

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

func set_animation(motion):
	if motion.x < 0:
		$AnimatedSprite.animation = "left"
	elif motion.x > 0:
		$AnimatedSprite.animation = "right"
	elif motion.y < 0:
		$AnimatedSprite.animation = "up"
	elif motion.y > 0:
		$AnimatedSprite.animation = "down"
		
	if motion.length() > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

func _physics_process(delta):
	var velocity = get_velocity()
	var motion = velocity * delta 
	
	set_animation(motion)
	move_and_collide(motion)
