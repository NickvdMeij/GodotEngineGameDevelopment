extends Area2D

var explosion_scene = preload("res://explosion.tscn")

var move_speed = 100.0
var score_emitted = false;

signal score

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	position -= Vector2(move_speed * delta, 0.0)
	if position.x <= -100:
		queue_free()
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass


func _on_asteroid_area_entered(area):
	
	if area.is_in_group("shots") or area.is_in_group("players"):
		if not score_emitted:
			score_emitted = true;
			emit_signal("score")
			queue_free()
			var stage_node = get_parent()
			var explosion_instance = explosion_scene.instance()
			explosion_instance.position = position
			stage_node.add_child(explosion_instance)
	pass # replace with function body
