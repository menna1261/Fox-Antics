extends Control
@onready var color_rect = $ColorRect
@onready var level_complete = $"ColorRect/level complete"
@onready var game_over = $"ColorRect/game over"
@onready var label = $MarginContainer/HBoxContainer/Label

@onready var hearts = $MarginContainer/HBoxContainer/hearts
var heart : Array 
# Called when the node enters the scene tree for the first time.
func _ready():
	heart = hearts.get_children()
	SignalManager.on_level_complete.connect(on_level_complete)

	SignalManager.on_player_hit.connect(on_player_hit)
	SignalManager.on_score_updated.connect(on_score_updated)

func on_player_hit(lives : int):
	for life in range(heart.size()):
		heart[life].visible = lives > life
	
	
func on_score_updated():
	label.text = str(ScoreManager.get_score()).lpad(5, "0")	
	
func on_level_complete():
	level_complete.visible = true
	show_hud()
	
	
func show_hud():
	Engine.time_scale = 0
	color_rect.visible = true
	


func reduce_hearts(num : int):
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_over.visible == true:
		if Input.is_action_just_pressed("main"):
			GameManager.load_main()
