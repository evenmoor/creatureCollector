class_name Character extends CharacterBody2D #the classname allows us to extend this with the player class

#scene variables
@onready var sprite:Sprite2D = $characterSprite

#character variables
@export var character_style: Data.CHARACTER_STYLE

#variables to handle movement
var direction:Vector2
var speed:int = 60

func _move() -> void:
	velocity = direction * speed
	move_and_slide()

func _ready() -> void:
	sprite.texture = load(Data.CHARACTER_TEXTURE_DATA[character_style])
