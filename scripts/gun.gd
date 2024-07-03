extends Area2D

func _physics_process(_delta):
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)

func shoot():
	const BULLET = preload("res://scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	# put starter postition at the marker for shooting point
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)

# todo: update this to come from a signal from the player
func _on_timer_timeout()	:
	shoot()
