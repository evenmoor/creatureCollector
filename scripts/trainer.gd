extends Character



func _on_trainer_watch_timer_timeout() -> void:
	var view_array = [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN]
	if last_direction_looked: #don't look in the same direction multiple times
		view_array.erase(last_direction_looked)
	view_direction = view_array.pick_random()
	last_direction_looked = view_direction
	sprite.frame_coords.y = Data.CHARACTER_VIEW_DIRECTIONS[view_direction]
	vision.target_position = view_direction * character_view_distance
