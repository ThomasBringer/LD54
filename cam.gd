extends Camera2D


var screen_size = Vector2(1920, 1080) # get_viewport().get_rect().size
var cur_screen := Vector2( 0, 0 )

#func _init():
#	screen_size = get_viewport().get_rect().size

func _ready():
	position_smoothing_enabled = false
	set_as_top_level(true)
	global_position = get_parent().global_position
	_update_screen( cur_screen )
	await get_tree().create_timer(1.0).timeout
	position_smoothing_enabled = true

func _physics_process(delta):
	var parent_screen : Vector2 = ( get_parent().global_position / screen_size ).floor()
	if not parent_screen.is_equal_approx( cur_screen ):
		_update_screen( parent_screen )


func _update_screen( new_screen : Vector2 ):
	cur_screen = new_screen
	global_position = cur_screen * screen_size + screen_size * 0.5
