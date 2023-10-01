extends RigidBody2D

var touching = false
var start_touch_pos: Vector2

@export var drag_scale=1
@export var max_speed=1024

@onready var ray_cast = $RayCast2D
@onready var shape = $CollisionShape2D

var disabled=false
#var drag_char_offset =96

func get_speed():
	var end_touch_pos = get_viewport().get_mouse_position()
	var vec = end_touch_pos - start_touch_pos
	var speed = - drag_scale * vec
	if speed.length() > max_speed:
		speed = max_speed * speed.normalized()
	return speed

func _physics_process(dt):
	if disabled:
		return
	
	if Input.is_action_just_pressed("touch"):
		touching = true
		start_touch_pos = get_viewport().get_mouse_position()
	elif Input.is_action_just_released("touch"):
		touching = false
		var speed = get_speed()
#		ray_cast.global_rotation = 0
#		ray_cast.target_position = 100*speed
#		var point = ray_cast.get_collision_point()
##		print(point, global_position)
#		var dist = (point-global_position).length()
#		var coef=clamp((dist-48)/64, 0, 1)
#		print("c ",coef)
#		speed *= coef
		
		set_axis_velocity(speed)
#	elif touching:
#		var speed = get_speed()
#		var offset = - speed / max_speed * drag_char_offset
#		char.position = offset
