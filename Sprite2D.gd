extends Sprite2D

var speed
var angular_speed = PI

func _ready():
	speed = randf_range(0.0, 2.0)

func _process(delta):
	rotation += angular_speed * speed * delta
