extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("level"):
		GameManager.load_level1()
