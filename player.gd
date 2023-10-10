extends Node2D

@export var base_speed = 500
var screen_size


func _ready():
	screen_size = get_viewport_rect().size

func shoot():
	pass


func _process(delta):
	var speed = base_speed
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("shoot"):
		shoot()
	
	if Input.is_action_pressed("bracke"):
		speed = 200
	
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
