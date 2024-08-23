extends Area2D

var direction : Vector2 = Vector2.RIGHT
var life_span = 7.0
var life_time = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_expired(delta)
	position += direction * delta 
	
func set_up(dir : Vector2 , _life_span :float , speed : float):
	direction =dir.normalized()*speed
	life_span = _life_span
	

func check_expired(delta):
	life_time+=delta
	if life_time > life_span :
		hide()
		queue_free()


func _on_area_entered(area):
	#when the bullet collides with anything it will just die
	queue_free()
