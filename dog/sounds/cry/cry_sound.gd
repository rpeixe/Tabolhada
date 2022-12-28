extends AudioStreamPlayer


func _on_CrySound_finished():
	queue_free()
