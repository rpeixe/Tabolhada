extends Node

var main_menu = "res://levels/main_menu/main_menu.tscn"


func _on_Button_pressed():
	get_tree().change_scene(main_menu)
