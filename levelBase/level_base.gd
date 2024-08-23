extends Node2D
@onready var player = $player
@onready var player_cam = $playerCam


# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_cam.position = player.position
	
	if Input.is_action_just_pressed("main"):
		GameManager.load_main()
	
	
	
 

