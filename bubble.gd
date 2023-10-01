extends RigidBody2D

@onready var child = $CollisionPolygon2D

@export var scale_factor=.002

func _physics_process(dt):
	var target_dir = linear_velocity
	var target_angle = target_dir.angle()
	
	var angle
	if(abs(target_angle - child.rotation)>PI/2):
		target_angle += PI
#	child.rotation = target_dir.angle()
#		angle = child.rotation + sign(target_angle-child.rotation)*10*dt
#		if(abs(target_angle - child.rotation)<=abs(target_angle - angle)):
#			angle = target_angle
			
	angle = child.rotation + sign(target_angle-child.rotation)*10*dt
	if(abs(target_angle - child.rotation)<=abs(target_angle - angle)):
		angle = target_angle
	child.rotation = angle
	
#	child.skew = .1*rad_to_deg(target_angle - child.rotation)
	
	var target_scale_x = 1+target_dir.length()*scale_factor
	var scale_x =  child.scale.x +sign(target_scale_x-child.scale.x) * 1 * dt
	if(abs(target_scale_x - child.scale.x)<=abs(target_scale_x - scale_x)):
		scale_x = target_scale_x
	child.scale = Vector2(scale_x, 1/scale_x)
