extends Character

var interactable:Character

func _check_interactable() -> void :
	if vision.collide_with_bodies:
		interactable = vision.get_collider()

func _get_input() -> void:
	if Input.is_action_pressed("test"): #manually flip defeat bit to test dialog trees
		for trainer in get_tree().get_nodes_in_group("Enemies"):
			trainer.defeated = !trainer.defeated
		
	if not Data.current_active_character: #pause input when an enemy is moving to challenge
		is_running = Input.is_action_pressed("run")
		direction = Input.get_vector("left", "right", "up", "down")
		
		if Input.is_action_just_pressed("interact") and interactable:
			Data.current_active_character = interactable
			Data.current_active_character.looking_around = false
			Data.current_active_character.set_view_direction(-get_character_direction(Data.current_active_character))
			Data.current_active_character.show_dialog()
	else:
		set_view_direction(get_character_direction((Data.current_active_character)))
		direction = Vector2.ZERO
		is_running = false
		if Input.is_action_just_pressed("interact"):
			Data.current_active_character.advance_dialog()

func _update_view_direction() -> void:
	if direction:
		var y = round(direction.y) if direction.x == 0 else 0 # we are stripping out diagonal vision angles by eliminating y values when x isn't 0
		view_direction = Vector2i(round(direction.x), y)
	vision.target_position = view_direction * character_view_distance
	
func _physics_process(delta: float) -> void:
	_get_input()
	_update_view_direction()
	_check_interactable() 
	
	move()
	animate(delta)
