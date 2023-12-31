extends Area2D

signal mob_killed

@export var speed = 700


func _physics_process(delta):
	position += transform.x * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
		mob_killed.emit()
	queue_free()
