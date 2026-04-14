extends CanvasLayer

@onready var background:ColorRect = $ColorRect

func transition(target_location : Data.LOCATION, current_location : Data.LOCATION) -> void :
	var tween = create_tween()
	tween.tween_property(background, "modulate:a", 1.0, 0.8) #fade to black over .8 seconds
	tween.tween_interval(0.5) #wait .5 seconds
	tween.tween_callback(_change_scene.bind(target_location, current_location)) #bind the callback to the scene load.... I think we can eliminate the interval if we bind the callback but I am following the tutorial so I am laving it for now
	tween.tween_property(background, "modulate:a", 0.0, 0.8) #fade back out over .8 seconds

func _change_scene(target_location : Data.LOCATION, current_location : Data.LOCATION) -> void :
	if get_tree().current_scene:
		get_tree().current_scene.queue_free()
	var scene = load(Data.LEVEL_PATHS[target_location]).instantiate()
	get_tree().root.add_child(scene)
	get_tree().current_scene = scene
	Data.current_player_location = target_location
	scene.player_start_position(current_location)

func _ready() -> void:
	background.modulate.a = 0.0
