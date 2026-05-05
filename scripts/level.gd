extends Node2D

@onready var player:Character = $objects/characters/player

func _ready() -> void:
	pass # Replace with function body.

func player_start_position(target: Data.LOCATION) -> void:
	for gate in $transitionGates.get_children(): #should also check to make sure that only gates are looped over also this only checks one level of gates which is stupid, there should just be a data lookup for this
		if gate.target == target: 
			player.position = gate.position + gate.get_player_position_offset()
			var player_view_direction = gate.get_player_position_offset().normalized() as Vector2i
			player.set_view_direction(player_view_direction)
			break
