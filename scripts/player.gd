extends Character

func _physics_process(_delta: float) -> void:
	_get_input()

func _get_input() -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	_move()
