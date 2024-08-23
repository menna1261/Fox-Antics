extends EnemyBase
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var direction_timer = $DirectionTimer
@onready var player_detector = $playerDetector
@onready var shooter = $shooter

const FLY_SPEED : Vector2 = Vector2(35 , 15)
var fly_direction :Vector2 = Vector2.ZERO

func _physics_process(delta):
	super._physics_process(delta)
	velocity = fly_direction
	shoot()
	move_and_slide()
	

func shoot():
	if player_detector.is_colliding() == true :
		shooter.shoot(
			global_position.direction_to(player_ref.global_position)
		)
	


func set_and_flip():
	#x_dir will be 1 if the player is to the right and -1 if left
	var x_dir = sign(player_ref.global_position.x - global_position.x)
	if x_dir  > 0 :
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
	fly_direction = Vector2(x_dir , 1 ) * FLY_SPEED
	
func fly_to_player():
	set_and_flip()
	direction_timer.start()
	

func _on_visible_on_screen_notifier_2d_screen_entered():
	animated_sprite_2d.play("fly")
	fly_to_player()


func _on_direction_timer_timeout():
	fly_to_player()
