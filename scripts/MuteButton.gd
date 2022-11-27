extends TextureButton


var master_sound = AudioServer.get_bus_index("Master")


func _on_MuteButton_toggled(button_pressed):
	AudioServer.set_bus_mute(master_sound, button_pressed)
