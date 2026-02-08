extends Character

@onready var dialog_box:PanelContainer = $dialogBox
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var walk_wait_timer:Timer = $timers/traimerWalkWaitTimer
@onready var watch_timer:Timer = $timers/trainerWatchTimer

#dialog variables
@export var dialog:Array[String] = []
var current_dialog:int = 0

func show_dialog() -> void:
	dialog_box.show()
	dialog_box.set_text(dialog[current_dialog])
	current_dialog += 1

func _on_trainer_watch_timer_timeout() -> void:
	if looking_around:
		var view_array = [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN]
		if last_direction_looked: #don't look in the same direction multiple times
			view_array.erase(last_direction_looked)
		view_direction = view_array.pick_random()
		last_direction_looked = view_direction
		sprite.frame_coords.y = Data.CHARACTER_VIEW_DIRECTIONS[view_direction]
		vision.target_position = view_direction * character_view_distance

func _on_traimer_walk_wait_timer_timeout() -> void:
	direction = get_character_direction(player)

func _process(delta: float) -> void:
	if vision.get_collider() == player and not Data.current_active_character and looking_around:
		print("I see the player!")
		Data.current_active_character = self
		walk_wait_timer.start()
		looking_around = false
		
	if direction:
		animate(delta)
		if position.distance_to(player.position) <= stop_radius :
			sprite.frame_coords.x = 0
			direction = Vector2.ZERO
			show_dialog()
		move()
