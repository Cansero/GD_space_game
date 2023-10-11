extends Node2D

signal hit

@export var bullet: PackedScene
@export var base_speed = 500
@export var brake_speed = 200
var screen_size


func _ready():
	screen_size = get_viewport_rect().size

func shoot():
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = $Marker2D.global_transform


func _process(delta):
	var speed = base_speed
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("shoot"):
		if $ShootDelay.is_stopped():
			shoot()
			$ShootDelay.start()
	
	if Input.is_action_pressed("bracke"):
		speed = brake_speed
	
	# Movement
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
