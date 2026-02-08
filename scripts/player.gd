extends Character

func _physics_process(delta: float) -> void:
	_get_input()
	_update_view_direction()
	_move()
	_animate(delta)

func _get_input() -> void:
	is_running = Input.is_action_pressed("run")
	direction = Input.get_vector("left", "right", "up", "down")

func _update_view_direction() -> void:
	if direction:
		var y = round(direction.y) if direction.x == 0 else 0 # we are stripping out diagonal vision angles by eliminating y values when x isn't 0
		view_direction = Vector2i(round(direction.x), y)
	vision.target_position = view_direction * character_view_distance
	
