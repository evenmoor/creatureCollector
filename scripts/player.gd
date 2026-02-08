extends Character

func _get_input() -> void:
	if not Data.current_active_character: #pause input when an enemy is moving to challenge
		is_running = Input.is_action_pressed("run")
		direction = Input.get_vector("left", "right", "up", "down")
	else:
		set_view_direction(get_character_direction((Data.current_active_character)))
		direction = Vector2.ZERO
		is_running = false

func _update_view_direction() -> void:
	if direction:
		var y = round(direction.y) if direction.x == 0 else 0 # we are stripping out diagonal vision angles by eliminating y values when x isn't 0
		view_direction = Vector2i(round(direction.x), y)
	vision.target_position = view_direction * character_view_distance
	
func _physics_process(delta: float) -> void:
	_get_input()
	_update_view_direction()
	move()
	animate(delta)
