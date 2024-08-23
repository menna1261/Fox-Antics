extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var audio_stream_player = $AudioStreamPlayer

@onready var timer = $Timer
const FRUITS : Array = ["melon" , "kiwi" ,"banana","cherry"]
const GRAVITY : float = 130
const JUMP = -80.0
const POINTS : int = 2

var start_y : float
var speed_y  = JUMP
var stopped = false


# Called when the node enters the scene tree for the first time.
func _ready():
	start_y = global_position.y
	animated_sprite_2d.play(FRUITS.pick_random())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stopped == true:
		return
	position.y += speed_y * delta
	speed_y += GRAVITY * delta
	
	if global_position.y >start_y:
		stopped = true

func kill_me():
	
	hide()
	#_process(false)
	queue_free()
	

func _on_timer_timeout():
	kill_me()


func _on_area_entered(area):
	SignalManager.on_pickup_hit.emit(POINTS)
	audio_stream_player.play()
	kill_me()
	
