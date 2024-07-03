extends CharacterBody2D

@export var max_speed = 600
@export var acceleration = 1500
@export var friction = 800
@export var knockback_power: int = 600

signal health_depleted

var health = 100.0

var input = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)
	detect_mob_overlap(delta)

func detect_mob_overlap(delta):
	const DAMAGE_RATE = 50.0
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		knockback(overlapping_mobs[0].velocity, delta)
		print("knockback")
		
	if health <= 0.0:
		health_depleted.emit()

func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input.normalized() # gets angle/direction of vector movement

#func get_mouse_input():
	#if Input.is_action_pressed("shoot") and can_shoot:
		#var dir = get_global_mouse_position() - position
		#shoot.emit(position, dir)
		#can_shoot = false
		#$ShotTimer.start()
		
func player_movement(delta):
	# get positive or negative x and y
	input = get_input()
	
	#get_mouse_input()
	
	if input == Vector2.ZERO: # no input
		# deceleration, slowing down or stopped
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else: 
			velocity = Vector2.ZERO
	else: # input
		# direction * acceleration, capped at max speed
		velocity += (input * acceleration * delta)
		velocity = velocity.limit_length(max_speed)
	
	move_and_slide()
	
func knockback(enemy_velocity, delta):
	# knockback_direction is a vector calculated by the difference between enemy velocity and player velocity
	var knockback_direction = (enemy_velocity - velocity).normalized() * knockback_power
	
	# direction * acceleration, capped at max speed
	velocity += knockback_direction * acceleration * delta
	velocity = velocity.limit_length(max_speed)
	move_and_slide()
