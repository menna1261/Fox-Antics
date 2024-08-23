extends Node

var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_pickup_hit.connect(on_pickup_hit)
	SignalManager.on_enemy_hit.connect(on_enemy_hit)	


func on_enemy_hit(p : int, v:Vector2):
	update_score(p)
	

func on_pickup_hit(p : int ):
	update_score(p)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_score(points : int):
	score += points
	SignalManager.on_score_updated.emit()
	print("current score " , score)
	
func get_score():
	return score
	
func reset_score():
	score = 0
	
