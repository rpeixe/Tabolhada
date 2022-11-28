extends AudioStreamPlayer





func _on_PopSound_finished():
	queue_free()
