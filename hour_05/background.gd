extends Sprite

const SCREEN_WIDTH = 320
var scroll_speed = 30.0

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	position += Vector2(-scroll_speed * delta, 0.0)
	
	if position.x <= -SCREEN_WIDTH:
		position.x += SCREEN_WIDTH
