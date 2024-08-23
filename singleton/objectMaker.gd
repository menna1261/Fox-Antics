extends Node

enum BULLET_KEY {PLAYER , ENEMY}
const BULLETS = {
	BULLET_KEY.PLAYER : preload("res://enemies/player_bullets.tscn"),
	BULLET_KEY.ENEMY : preload("res://enemies/enemy_bullet.tscn")
}
const explosion_scene : PackedScene = preload("res://enemy_explotion.tscn")
const pickup_scene : PackedScene = preload("res://pickup.tscn")
func add_child_deferred(child_to_add):
	get_tree().root.add_child(child_to_add)


func call_add_child(child_to_add):
	call_deferred("add_child_deferred", child_to_add)


func create_bullet(speed : float , direction : Vector2 , start_pos : Vector2 ,
					  life_span : float , key : BULLET_KEY):
	var new_bullet = BULLETS[key].instantiate()
	new_bullet.set_up(direction , life_span , speed )
	new_bullet.global_position = start_pos
	call_add_child(new_bullet)
	
func explosion(start_pos : Vector2):
	var new_exp = explosion_scene.instantiate()
	new_exp.global_position = start_pos
	call_add_child(new_exp)
	
func create_pickup(start_pos : Vector2):
	var new_exp = pickup_scene.instantiate()
	new_exp.global_position = start_pos
	call_add_child(new_exp)
	
