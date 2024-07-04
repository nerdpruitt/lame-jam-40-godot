extends CharacterBody2D

var health = 3
var stunned = false
var bullet_velocity

@export var max_speed = 600
@export var acceleration = 1500
@export var friction = 800
@export var knockback_power: int = 600

@onready var player = get_node("/root/Game/Player")

func _physics_process(delta):
	if stunned == false:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 300.0
	elif stunned:
		# stop movement toward player
		velocity = Vector2(0, 0)
		
		# set knockback direction based on bullet velocity
		var knockback_direction = (bullet_velocity - velocity).normalized() * knockback_power
		
		# move enemy in new direction
		velocity += knockback_direction * acceleration * delta
		velocity = velocity.limit_length(max_speed)
		
	move_and_slide()
	
func take_damage(bullet):
	modulate = Color.RED
	stunned = true
	bullet_velocity = bullet
	$StunTimer.start()
	
	health -= 1;
	
	if health == 0:
		queue_free()

func _on_stun_timer_timeout():
	modulate = Color.WHITE
	stunned = false	
