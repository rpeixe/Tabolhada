extends Node


func _ready():
	pass # Replace with function body.


func _on_StartGame_button_up():
	get_tree().change_scene("res://levels/main_game/main_game.tscn")


func _on_QuitGame_button_up():
	get_tree().quit()


func _on_Instructions_pressed():
	get_tree().change_scene("res://levels/instructions_menu/instructions_menu.tscn")
