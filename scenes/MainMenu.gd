extends Control


func _ready():
	pass # Replace with function body.


func _on_StartGame_button_up():
	get_tree().change_scene("res://scenes/MainGame.tscn")


func _on_QuitGame_button_up():
	get_tree().quit()
