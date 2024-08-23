extends Node2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var timer = $Timer

@export var speed : float = 180.0
@export var life_span : float = 1.0
@export var bullet_key : ObjectMaker.BULLET_KEY
@export var shoot_delay : float = 0.2

var can_shoot : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = shoot_delay
	
func shoot(direction : Vector2):
	if can_shoot == false:
		return
		
	can_shoot = false 
	SoundManager.play_clip(audio_stream_player_2d, SoundManager.SOUND_LASER)
	ObjectMaker.create_bullet(speed, direction , global_position , life_span , bullet_key)
	timer.start()



func _on_timer_timeout():
	can_shoot = true
