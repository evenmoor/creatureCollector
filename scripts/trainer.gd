extends Character

@onready var dialog_box:PanelContainer = $dialogBox
@onready var walk_wait_timer:Timer = $timers/traimerWalkWaitTimer
@onready var watch_timer:Timer = $timers/trainerWatchTimer

#charcter data
var unique_id:String
var defeated:bool = false:
	set(value): #setter annotation
		defeated = value
		if unique_id in Data.character_data : #check to see if the dictionary has been instantiated for this character yet
			Data.character_data[unique_id]['defeated'] = value
#dialog variables
@export var dialog:Array[String] = []
@export var defeated_dialog:Array[String] = []
var current_dialog_index:int = 0

func show_dialog() -> void:
	dialog_box.show()
	current_dialog_index = 0
	dialog_box.set_text(defeated_dialog[current_dialog_index] if defeated else dialog[current_dialog_index])

func advance_dialog() -> void:
	var current_dialog = defeated_dialog if defeated else dialog
	current_dialog_index += 1
	if current_dialog_index < current_dialog.size():
		dialog_box.set_text(current_dialog[current_dialog_index])
	else:
		dialog_box.hide()
		Data.current_active_character = null #release the current character... this really shouldn't be done until the battle is done so this will need to be moved once the battle is programmed
		print("do whatever is next")

func _get_player() -> Character: #replaced the @onready player variable so that we don't lose the player to every load/unload
	return get_tree().get_first_node_in_group("Player")

func _generate_unique_id() -> String: #unique id to reference data dictionary for this trainer's data
	var current_scene_name:String = get_owner().scene_file_path.get_file().get_basename()
	var new_id:String = current_scene_name + "_" + name
	return new_id.to_upper()
	
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
	direction = get_character_direction(_get_player())

func _enter_tree() -> void:
	unique_id = _generate_unique_id()
	if unique_id not in Data.character_data:
		Data.character_data[unique_id] = { 'defeated' : defeated }
	else:
		var load_data = Data.character_data[unique_id]
		defeated = load_data.defeated

func _process(delta: float) -> void:
	if vision.get_collider() == _get_player() and not Data.current_active_character and looking_around:
		Data.current_active_character = self
		walk_wait_timer.start()
		looking_around = false
		
	if direction and can_move:
		animate(delta)
		if position.distance_to(_get_player().position) <= stop_radius :
			sprite.frame_coords.x = 0
			direction = Vector2.ZERO
			show_dialog()
		move()
