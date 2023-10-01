@tool
extends Path2D

@onready var start_sprite = $Sprite2DStart
@onready var end_sprite = $Sprite2DEnd
@onready var line = $Line2D

@export var res_per_seg=10

func _process(dt):
	start_sprite.position = curve.get_point_position(0)
	end_sprite.position = curve.get_point_position(curve.point_count - 1)
	
	start_sprite.rotation =  curve.get_point_out(0).angle()+PI/2
	end_sprite.rotation =  curve.get_point_out(curve.point_count - 1).angle()+PI/2

	line.clear_points( )
	var t
	var pos
	for v in range(curve.point_count-1):
		for i in range(res_per_seg):
			t = float(i) / float(res_per_seg)
			pos = curve.sample(v, t)
			line.add_point(pos)
