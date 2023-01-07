extends Node


func _on_StartGame_pressed():
	get_tree().change_scene("res://levels/main_game/main_game.tscn")


func _on_Instructions_pressed():
	get_tree().change_scene("res://levels/instructions_menu/instructions_menu.tscn")


func _on_Credits_pressed():
	get_tree().change_scene("res://levels/credits_menu/credits_menu.tscn")


func _on_QuitGame_pressed():
	get_tree().quit()
