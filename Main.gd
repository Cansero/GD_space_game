extends Node

@export var mob_scene: PackedScene
@export var meteor_scene: PackedScene


func new_game():
	$MobTimer.start()
	$MeteorTimer.start()


func game_over():
	$MobTimer.stop()
	$MeteorTimer.stop()


func base_hit():
	pass


func _ready():
	new_game()


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = get_node("MobPath/MobLocation")
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)


func _on_meteor_timer_timeout():
	var enemies = get_tree().get_nodes_in_group("meteor")
	enemies = enemies.size()
	if enemies < 5:
		var meteor = meteor_scene.instantiate()
		
		var meteor_spawn_location = get_node("MobPath/MobLocation")
		meteor_spawn_location.progress_ratio = randf()
		
		var direction = meteor_spawn_location.rotation + PI / 2
		
		meteor.position = meteor_spawn_location.position
		meteor.rotation = direction
		
		var velocity = Vector2(randf_range(100.0, 450.0), 0.0)
		meteor.linear_velocity = velocity.rotated(direction)
		
		add_child(meteor)
	
	$MeteorTimer.start(randi_range(5, 8))


func _on_player_death():
	game_over()


func _on_exit_area_body_entered(body):
	if body.is_in_group("mobs"):
		base_hit()
