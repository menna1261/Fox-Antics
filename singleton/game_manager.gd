extends Node
const GROUP_PLAYER : String = "player"

const MAIN : PackedScene = preload("res://levelBase/canvas_layer.tscn")
const level1 : PackedScene = preload("res://levelBase/level_1.tscn")

func _ready():
	ScoreManager.reset_score()

func load_main():
	get_tree().change_scene_to_packed(MAIN)
	ScoreManager.reset_score()
	if Input.is_action_just_pressed("jump"):
		load_level1()

func load_level1():
	get_tree().change_scene_to_packed(level1)
	
