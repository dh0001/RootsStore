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
		
	velocity = velocity.normalized() * speed
	var motion = velocity * delta 
	
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	return velocity.normalized() * speed

func set_animation(motion):
	if velocity.x < 0:
		$AnimatedSprite.animation = "left"
	elif velocity.x > 0:
		$AnimatedSprite.animation = "right"
	elif velocity.y < 0:
		$AnimatedSprite.animation = "up"
	elif velocity.y > 0:
		$AnimatedSprite.animation = "down"

	if test_move(self.transform, motion):
		_animated_sprite.animation = "walk"
	else:
		$AnimatedSprite.stop()
		
#	if test_move(self.transform, motion):
#		_animated_sprite.animation = "walk"
#	else:
#		_animated_sprite.animation = "stand"
#	_animated_sprite.play()

func _physics_process(delta):
	var velocity = get_velocity()
	var motion = velocity * delta 
	
	set_animation(motion)
	move_and_collide(motion)
