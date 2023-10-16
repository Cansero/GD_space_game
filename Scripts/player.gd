extends Node2D

signal death
signal mob_kill

@export var bullet: PackedScene
@export var base_speed = 500
@export var brake_speed = 200
@export var base_life = 3

var screen_size
var braking
var life


func _ready():
	screen_size = get_viewport_rect().size
	hide()

func shoot():
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = $Marker2D.global_transform
	b.connect("mob_killed", _on_mob_killed)


func _process(delta):
	var speed = base_speed
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("bracke"):
		$ShootDelay.set_wait_time(0.2)
		speed = brake_speed
	else:
		$ShootDelay.set_wait_time(0.7)
		speed = base_speed
	
	if Input.is_action_pressed("shoot"):
		if $ShootDelay.is_stopped():
			shoot()
			$ShootDelay.start()
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func hit(times, duration):
	for x in range(times):
		hide()
		await get_tree().create_timer(duration).timeout
		show()
		await get_tree().create_timer(duration).timeout


func _on_body_entered(body):
	life -= 1
	
	if life > 0:
		hit(3, 0.2)
	
	else:
		hide()
		death.emit()


func show_player():
	show()


func _on_mob_killed():
	mob_kill.emit()


func start(pos):
	position = pos
	show()
	life = base_life
