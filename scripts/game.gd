extends Node2D

func _ready():
	var crosshair = preload("res://assets/sprites/crosshair.svg")
	Input.set_custom_mouse_cursor(crosshair, Input.CURSOR_ARROW, Vector2(26, 26))

func spawn_mob():
	var new_mob = preload("res://scenes/flying_saucer.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func _on_timer_timeout():
	spawn_mob()
