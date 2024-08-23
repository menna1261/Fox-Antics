extends AnimatableBody2D
@export var p1: Marker2D
@export var p2: Marker2D

var speed: float = 50.0
var time_to_move: float = 0.0

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	set_time_to_move()
	moving()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _exit_tree():
	tween.kill()

func set_time_to_move():
	var distance = p1.global_position.distance_to(p2.global_position)
	time_to_move = distance / speed

func moving():
	tween = get_tree().create_tween()
	tween.set_loops(-1)  # Set to -1 to loop indefinitely
	tween.tween_property(self, "global_position", p1.global_position, time_to_move)
	tween.tween_property(self, "global_position", p2.global_position, time_to_move)
