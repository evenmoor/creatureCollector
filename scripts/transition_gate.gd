extends Area2D

@export var target: Data.LOCATION
@export var current: Data.LOCATION
@export_enum("UP", "DOWN", "LEFT", "RIGHT") var player_position_offset_direction = "UP"
@export var player_position_offset_distance: int = 30

func _on_body_entered(player: Character) -> void:
	player.stop()
	TransitionLayer.transition(target, current)

func get_player_position_offset() -> Vector2:
	return{
		"UP": Vector2.UP,
		"DOWN": Vector2.DOWN,
		"LEFT": Vector2.LEFT,
		"RIGHT": Vector2.RIGHT
	}[player_position_offset_direction] * player_position_offset_distance
