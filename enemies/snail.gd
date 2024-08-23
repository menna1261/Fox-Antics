extends EnemyBase

@onready var floor_detection = $FloorDetection
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var flip_cooldown_time : float = 0.2
var last_flip_time : float = -flip_cooldown_time

func _physics_process(delta):
	super._physics_process(delta)

	if is_on_floor() == false:
		velocity.y += gravity * delta
	else:
		velocity.x = _speed * facing

	move_and_slide()
	if is_on_floor() == true:
		if (is_on_wall() == true or floor_detection.is_colliding() == false) and (get_time() - last_flip_time > flip_cooldown_time):
			flip_me()

func flip_me():
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	floor_detection.position.x = floor_detection.position.x * -1
	
	if facing == FACING.LEFT:
		facing = FACING.RIGHT
	elif facing == FACING.RIGHT:
		facing = FACING.LEFT

	last_flip_time = get_time()

func get_time() -> float:
	return Time.get_ticks_msec() / 1000.0

