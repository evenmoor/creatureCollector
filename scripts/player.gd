extends Character

func _physics_process(delta: float) -> void:
	_get_input()
	_move()
	_animate(delta)

func _get_input() -> void:
	is_running = Input.is_action_pressed("run")
	direction = Input.get_vector("left", "right", "up", "down")
	
