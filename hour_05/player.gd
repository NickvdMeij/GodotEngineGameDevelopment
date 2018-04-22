extends Area2D

const MOVE_SPEED = 150

const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180

var can_shoot = true

var shot_scene = preload("res://shot.tscn")
var explosion_scene = preload("res://explosion.tscn")

signal destroyed
var emitted_destroyed = false;

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	var stage_node = get_parent()
	if Input.is_key_pressed(KEY_SPACE) and can_shoot:
		var bottom_shot_instance = shot_scene.instance()
		bottom_shot_instance.position = (position + Vector2(9, -5))
		stage_node.add_child(bottom_shot_instance)
		
		var top_shot_instance = shot_scene.instance()
		top_shot_instance.position = (position + Vector2(9, 5))
		stage_node.add_child(top_shot_instance)
		
		can_shoot = false
		$reload_timer.start()
	
	var input_dir = Vector2()
	
	if Input.is_key_pressed(KEY_UP):
		input_dir.y -= 1.0
	if Input.is_key_pressed(KEY_DOWN):
		input_dir.y += 1.0
	if Input.is_key_pressed(KEY_LEFT):
		input_dir.x -= 1.0
	if Input.is_key_pressed(KEY_RIGHT):
		input_dir.x += 1.0
		
	if position.x < $sprite.frames.get_frame("default",0).get_width():
		position.x = $sprite.frames.get_frame("default",0).get_width()
	if position.y < $sprite.frames.get_frame("default",0).get_height():
		position.y = $sprite.frames.get_frame("default",0).get_height();
	if position.x > (SCREEN_WIDTH - $sprite.frames.get_frame("default",0).get_width()):
		position.x = (SCREEN_WIDTH - $sprite.frames.get_frame("default",0).get_width())
	if position.y > (SCREEN_HEIGHT - $sprite.frames.get_frame("default",0).get_height()):
		position.y = (SCREEN_HEIGHT - $sprite.frames.get_frame("default",0).get_height())
	
	position += (delta * MOVE_SPEED) * input_dir
	
	pass

func _on_reload_timer_timeout():
	can_shoot = true
	pass

func _on_player_area_entered(area):
	if area.is_in_group("shots") or area.is_in_group("asteroids"):
		if not emitted_destroyed:
			emit_signal("destroyed")
			queue_free()
			var stage_node = get_parent()
			var explosion_instance = explosion_scene.instance()
			explosion_instance.position = position
			stage_node.add_child(explosion_instance)
	pass # replace with function body
