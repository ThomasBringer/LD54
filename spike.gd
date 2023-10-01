extends Area2D

signal hit

func _on_body_entered(body):
	print(self.name)
#	await get_tree().create_timer(1.0).timeout
	hit.emit()
