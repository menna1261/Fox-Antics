extends CharacterBody2D
class_name EnemyBase


enum FACING {RIGHT = 1, LEFT= -1}
const OFF_SCREEN_KILL_ME : float = 1000.0

@export var default_facing = FACING.LEFT
@export var points : int  = 1
@export var _speed : float  = 30.0

var gravity : float = 800.0
var facing : FACING = default_facing
var player_ref : Player 
var _dying : bool = false


func _ready():
	#getting a reference of the player before loading the scene
	player_ref = get_tree().get_nodes_in_group(GameManager.GROUP_PLAYER)[0]


func _physics_process(delta):
	fallen_off()


func fallen_off():
	if global_position.y > OFF_SCREEN_KILL_ME:
		queue_free()

func die():
	if _dying == true :
		return
		
	_dying = true
	SignalManager.on_enemy_hit.emit(points, global_position)
	ObjectMaker.explosion(global_position)
	set_physics_process(false)
	hide()
	queue_free()
	ObjectMaker.create_pickup(global_position)

func _on_visible_on_screen_notifier_2d_screen_entered():
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # Replace with function body.


func _on_hitbox_area_entered(area):
	print("enemy hit")
	die()
	
