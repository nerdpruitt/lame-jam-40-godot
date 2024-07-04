extends StaticBody2D

var velocity: Vector2
var travelled_distance = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	const SPEED = 1000
	const RANGE = 1200
	
	# gets direction bullet is pointed
	var direction = Vector2.RIGHT.rotated(rotation)
	velocity = SPEED * direction * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()
		
	move_and_collide(velocity)

func _on_hit_box_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(velocity)
