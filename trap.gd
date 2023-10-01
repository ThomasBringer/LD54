extends Area2D

func _on_body_entered(body):
	print("evelyne")
	$Trap/AnimationPlayer.play("trap")
