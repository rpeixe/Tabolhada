extends AudioStreamPlayer


func _on_BarkSound_finished():
	queue_free()
