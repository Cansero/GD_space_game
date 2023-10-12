extends RigidBody2D


func _ready():
	await get_tree().create_timer(10.0).timeout
	set_gravity_scale(0.5)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
