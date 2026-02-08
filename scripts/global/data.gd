extends Node
#global enums
enum CHARACTER_STYLE {CHARACTER, BLONDE, PLAYER, GREEN, FIRE, GRASS, ICE, PURPLE, STRAW, BOY, GIRL} #character types

#global consts
const ANIMATION_SPEED:int = 6
const ANIMATION_SPEED_FAST:int = 9

#global const dictionaries
const CHARACTER_TEXTURE_DATA = {
	CHARACTER_STYLE.CHARACTER : "res://assets/graphics/sprites/character/character.png",
	CHARACTER_STYLE.BLONDE : "res://assets/graphics/sprites/character/blond.png",
	CHARACTER_STYLE.PLAYER : "res://assets/graphics/sprites/character/player.png",
	CHARACTER_STYLE.GREEN : "res://assets/graphics/sprites/character/green.png",
	CHARACTER_STYLE.FIRE : "res://assets/graphics/sprites/character/fire_boss.png",
	CHARACTER_STYLE.GRASS : "res://assets/graphics/sprites/character/grass_boss.png", 
	CHARACTER_STYLE.ICE : "res://assets/graphics/sprites/character/ice_boss.png",
	CHARACTER_STYLE.PURPLE : "res://assets/graphics/sprites/character/purple.png",
	CHARACTER_STYLE.BOY : "res://assets/graphics/sprites/character/young_boy.png",
	CHARACTER_STYLE.GIRL : "res://assets/graphics/sprites/character/young_girl.png"
}
const CHARACTER_VIEW_DIRECTIONS = {
	Vector2i.DOWN: 0, 
	Vector2i.LEFT: 1, 
	Vector2i.RIGHT: 2, 
	Vector2i.UP: 3,
	Vector2i.ZERO: 0,
	Vector2i(1,1) : 2, # down right
	Vector2i(1,-1) : 2, # up right
	Vector2i(-1,1) : 1, # down left
	Vector2i(-1,-1) : 1, # up left
}
