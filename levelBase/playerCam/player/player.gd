extends CharacterBody2D
class_name Player
@onready var shooter = $shooter
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var sound_player = $soundPlayer
@onready var animation_player_2 = $AnimationPlayer2
@onready var timer = $Timer
@onready var hurt_timer = $hurt_timer


const GRAVITY : float = 1000.0
const RUN_SPEED : float = 150.0
const MAX_FALL : float = 400.0
const HURT_TIME : float = 0.3
const JUMP_VELOCITY : float = -350.0
const HURT_JUMP_VELOCITY : Vector2 = Vector2(0 , -100.0)
enum PLAYER_STATE {IDLE , RUN, JUMP , FALL , HURT}
var _state = PLAYER_STATE.IDLE
var invincible : bool = false
var lives : int = 5



# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_player_hit.emit(lives)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if is_on_floor() == false:
		velocity.y += GRAVITY*delta
	get_input()
	move_and_slide()
	calculate_state()
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot ():
	if sprite_2d.flip_h == true:
		shooter.shoot(Vector2.LEFT)
	else:
		shooter.shoot(Vector2.RIGHT)


func get_input()-> void:
	velocity.x =0 
	if Input.is_action_pressed("left")==true :

		velocity.x -=RUN_SPEED
		sprite_2d.flip_h = true
		
	if Input.is_action_pressed("right") == true:
		velocity.x = RUN_SPEED
		sprite_2d.flip_h = false		
		
	if Input.is_action_pressed("jump") == true and is_on_floor()==true:
		velocity.y = JUMP_VELOCITY
		SoundManager.play_clip(sound_player,SoundManager.SOUND_JUMP)
	#updating the velocity with a value between JUMP_VELOCITY and MAX_FALL	
	velocity.y = clampf(velocity.y , JUMP_VELOCITY , MAX_FALL)	


	
func calculate_state():
	if _state == PLAYER_STATE.HURT:
		return
	if is_on_floor() == true :
		if velocity.x ==0:
			set_state(PLAYER_STATE.IDLE)
		else:
			set_state(PLAYER_STATE.RUN) 		
	else:
		if velocity.y > 0 :
			set_state(PLAYER_STATE.FALL) 
		else:
			set_state(PLAYER_STATE.JUMP) 


	
func set_state(new_state):
	if new_state == _state:
		return
		
	if _state == PLAYER_STATE.FALL:
		SoundManager.play_clip(sound_player,SoundManager.SOUND_LAND)
		
	_state = new_state 
	match _state :
		PLAYER_STATE.IDLE:
			animation_player.play("idle")
		PLAYER_STATE.HURT:
			animation_player.play("hurt")
		PLAYER_STATE.RUN:
			animation_player.play("run")			
		PLAYER_STATE.JUMP:
			animation_player.play("jump")
		PLAYER_STATE.FALL:
			animation_player.play("fall")
		
func go_invincible():
	timer.start()
	invincible = true 
	animation_player_2.play("invincible")
	
	
func getting_hurt():
	set_state(PLAYER_STATE.HURT)
	velocity= HURT_JUMP_VELOCITY
	hurt_timer.start()

func reduce_life()->bool:
	lives-=1
	SignalManager.on_player_hit.emit(lives)
	if lives <=0 :
		SignalManager.on_game_over.emit()
		set_physics_process(false)
		return false
	return true
		
	
		
func apply_hit():
	if reduce_life() == false :
		return
	if invincible:
		return
	
	SoundManager.play_clip(sound_player, SoundManager.SOUND_DAMAGE)
	go_invincible()
	getting_hurt()
	
	
func _on_hitbox_area_entered(area):
	apply_hit()
	
func _on_timer_timeout():
	invincible = false 
	animation_player_2.stop()


func _on_hurt_timer_timeout():
	set_state(PLAYER_STATE.IDLE)
