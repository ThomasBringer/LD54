extends Node

@export var bubble_packed: PackedScene
@onready var bubble = $Bubble
#@onready var bubble_coll = $Player/Bubble/CollisionPolygon2D
#@onready var bubble_sprite = $Player/Bubble/CollisionPolygon2D/Sprite

@onready var pipes = $Pipes
#@onready var player = $Player
@onready var char = $Character
@onready var char_coll = $Character/CollisionShape2D
@onready var glup = $Character/Sprite/Glup

@export var pipe_speed=500

@onready var pop = $Pop
@onready var mdm_pop = $Mdm_Pop

@export var explode_packed: PackedScene

func expl(pos: Vector2):
	var e = explode_packed.instantiate()
	add_child(e)
	e.global_position = pos
	e.emitting = true

var piping=false
var pipe

var follower

# Called when the node enters the scene tree for the first time.
func _ready():
	bubble = bubble_packed.instantiate()
	add_child(bubble)
	bubble.global_position = char.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt):
	if piping:
		char.global_transform = follower.global_transform
		follower.progress += pipe_speed * dt
#		var length=pipe.curve.get_baked_length()
#		if follower.progress>length:
#			follower.progress=length


func _on_spike_hit():
	pipe = get_closest_pipe()
	
	bubble.queue_free()
	
#	bubble.linear_velocity = Vector2.ZERO
#	bubble.angular_velocity = 0

#	bubble.freeze=true
#	char.set_axis_velocity(Vector2.ZERO)
	char.linear_velocity = Vector2.ZERO
	char.angular_velocity = 0
	char_coll.set_deferred("disabled", true)
	
	expl(char.global_position)
	pop.play()
#	char.freeze=true
	
#	bubble.set_deferred("freeze", true)
	var p2 = pipe.global_position + pipe.curve.get_point_position(0)
	var p1 = char.global_position
	var dir = p2-p1
	char.gravity_scale=0
	char.disabled = true
	char.set_axis_velocity(pipe_speed * dir.normalized())
	await get_tree().create_timer(dir.length()/pipe_speed).timeout
	char.set_deferred("freeze", true)
	char.linear_velocity = Vector2.ZERO
	char.angular_velocity = 0
#	char.freeze=true
	
	follower = pipe.get_node("Follower")
	follower.progress =0
	piping = true
	
	
	glup.show()
	
#	Extensions._reparent(char, follower)
	
#	player.remove_child(char)
#	follower.add_child(char)
	
	var sound_t = .6
	
	await get_tree().create_timer(pipe.curve.get_baked_length()/pipe_speed - sound_t).timeout

	mdm_pop.play()
	
	await get_tree().create_timer(sound_t).timeout

	expl(char.global_position)
#	for i in range(int(pipe.curve.get_baked_length()/pipe_speed)):
#		follower.progress += pipe_speed * .05
#		await get_tree().process_frame
	
#	_reparent(char, player)
#	follower.remove_child(char)
#	player.add_child(char)
	char.disabled = false
	piping = false
	glup.hide()
	char.freeze=false
	char.gravity_scale=1
	char_coll.set_deferred("disabled", false)
	
	
	bubble = bubble_packed.instantiate()
	add_child(bubble)
	bubble.global_position = char.global_position
	
	print("set bubble's global position to ",bubble.global_position)
#	bubble_sprite.show()
#	bubble.freeze=false
#	bubble_coll.disabled=false
#	await get_tree().create_timer(.1).timeout
#	bubble_coll.set_deferred("disabled", false)
#	char.freeze = true
#	bubble.on_spike_hit()

func get_closest_pipe():
	var min_pipe
	var min_dist_sqr=INF
	for i in range(pipes.get_child_count()):
		var pipe = pipes.get_child(i)
		var pos = pipe.global_position + pipe.curve.get_point_position(0)
		var dist_sqr = (pos - char.global_position).length_squared()
#		print(pipe.name, " dist_sqr ", dist_sqr)
		if dist_sqr < min_dist_sqr:
			min_pipe = pipe
			min_dist_sqr = dist_sqr
	return min_pipe


func _on_area_2d_body_entered(body):
	pass # Replace with function body.
