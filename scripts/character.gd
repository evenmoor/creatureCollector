class_name Character extends CharacterBody2D #the classname allows us to extend this with the player class

#scene variables
@onready var sprite:Sprite2D = $characterSprite
@onready var vision:RayCast2D = $caracterVisionRay

#character variables
@export var character_style: Data.CHARACTER_STYLE

#variables to handle view not sure why these are here... it might make more sense for these to be in the trainer class unless there are plans for other character types that will need them.....
@export var character_view_distance:int = 90
var view_direction:Vector2i #direction currently looking
var last_direction_looked:Vector2i #last direction this character looked
var looking_around:bool = true

#variables to handle movement
var direction:Vector2
var character_walk_speed:int = 60
var character_run_speed:int = 130
@export var stop_radius:int = 27
var is_running:bool = false

#animation variables
var current_h_frame:float

#animate the sprite based on the detla time
func animate(delta) -> void:
	if direction:
		var face_dir:Vector2i = Vector2i(round(direction.x), round(direction.y))
		sprite.frame_coords.y = Data.CHARACTER_VIEW_DIRECTIONS[face_dir] #this is a very cool cheat when linked with a sprite sheet laid out in the right order and the right h & v frame settings in the UI
		var animation_speed:float = Data.ANIMATION_SPEED_FAST if is_running else Data.ANIMATION_SPEED
		current_h_frame += animation_speed * delta
	else:
		current_h_frame = 0 # resets the walking animation
		
	sprite.frame_coords.x = int(current_h_frame) % sprite.hframes #trick to allow the ever increasing values of current_h_frame to be bounded by the number of frames available

#change the view direction of the character to a specific vector 
func set_view_direction(new_view_direction:Vector2i) -> void:
	sprite.frame_coords.y = Data.CHARACTER_VIEW_DIRECTIONS[new_view_direction]

#determine the vector2i direction between this character and another character
func get_character_direction(target:Character) -> Vector2i:
	var target_direction = (target.position - position).normalized()
	return Vector2i(round(target_direction.x), round(target_direction.y))

#handle the movement of this character in its direction supporting running
func move() -> void:
	var speed:int = character_run_speed if is_running else character_walk_speed
	velocity = direction * speed
	move_and_slide()

func _ready() -> void:
	sprite.texture = load(Data.CHARACTER_TEXTURE_DATA[character_style])
