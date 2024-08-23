extends Area2D
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer
var level_complete = preload("res://hud.tscn")
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_entered(area):
	SignalManager.on_level_complete.emit()
	animation_player.play("flag_open")
	SoundManager.play_clip(audio_stream_player_2d, SoundManager.SOUND_WIN)



