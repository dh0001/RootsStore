extends KinematicBody2D

onready var _animated_sprite = $AnimatedSprite
export var speed = 400 # How fast the player will move (pixels/sec).

func _physics_process(delta):
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
	
	if test_move(self.transform, motion):
		_animated_sprite.animation = "walk"
	else:
		_animated_sprite.animation = "stand"
	_animated_sprite.play()

	move_and_collide(motion)
	
#func _process(delta):
#	_animated_sprite.play()
#func _process(delta):
#	var velocity = Vector2.ZERO
#	if Input.is_action_pressed("move_right"):
#		velocity.x += 1
#	if Input.is_action_pressed("move_left"):
#		velocity.x -= 1
#	if Input.is_action_pressed("move_up"):
#		velocity.y -= 1
#	if Input.is_action_pressed("move_down"):
#		velocity.y += 1
#
#	if velocity.length() > 0:
#		velocity = velocity.normalized() * speed
#		$AnimatedSprite.animation = "walk"
#	else:
#		$AnimatedSprite.animation = "stand"
#	$AnimatedSprite.play()
#
#	position += velocity * delta
#	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
#	position.y = clamp(position.y, 0, get_viewport_rect().size.y)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
