extends CharacterBody2D

signal shoot

var can_shoot: bool

@export var max_speed = 400
@export var acceleration = 1500
@export var friction = 600

var input = Vector2.ZERO

func _ready():
	can_shoot = true

func _physics_process(delta):
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input.normalized() # gets angle/direction of vector movement

func get_mouse_input():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
		var dir = get_global_mouse_position() - position
		shoot.emit(position, dir)
		can_shoot = false
		$ShotTimer.start()
		
func player_movement(delta):
	# get positive or negative x and y
	input = get_input()
	
	get_mouse_input()
	
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


func _on_shot_timer_timeout():
	can_shoot = true
