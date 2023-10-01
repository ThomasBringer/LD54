extends CollisionPolygon2D

@export var radius=128
@export var res=32

func _ready():	
	var array = []
	array.resize(2*res)
	
	var angle
	var vec = radius * Vector2.RIGHT
	array[0] = vec
	array[2*res-1] = vec
	for i in range(1,res):
		angle = 2*PI*i/res
		vec = radius* Vector2(cos(angle), sin(angle))
		array[2*i] = vec
		array[2*i-1] = vec
	
	polygon = array
