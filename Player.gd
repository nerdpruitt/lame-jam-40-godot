extends CharacterBody2D

@export var max_speed = 400
@export var acceleration = 1500
@export var friction = 600

var input = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input.normalized() # gets angle/direction of vector movement

func player_movement(delta):
	# get positive or negative x and y
	input = get_input()
	
	if input == Vector2.ZERO: # no input
		# deceleration, slowing down or stopped
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else: 
			velocity = Vector2.ZERO
	else: # input
		# acceleration, speed up to max speed
		velocity += (input * acceleration * delta)
		velocity = velocity.limit_length(max_speed)
	
	move_and_slide()
