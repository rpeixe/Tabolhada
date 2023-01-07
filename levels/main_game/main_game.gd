extends Node


var rng = RandomNumberGenerator.new()
var num_1
var num_2
var result
var score = 0
var multiplier = 1
var main_menu = "res://levels/main_menu/main_menu.tscn"

signal result_changed(value)


func _ready():
	rng.randomize()
	randomize_numbers()

func _process(delta):
	$"%Time".text = str(int($GameTimer.time_left))

func randomize_numbers():
	num_1 = rng.randi_range(1, 10)
	num_2 = rng.randi_range(1, 10)
	result = num_1 * num_2
	$QuestionBoard.change_text(num_1, num_2)
	$ScoreResetTimer.start()
	emit_signal("result_changed", result)

func set_multiplier(value):
	multiplier = value
	$"%Multiplier".text = str(value) + "x"

func increase_score():
	score += multiplier
	if multiplier < 5:
		set_multiplier(multiplier + 1)
	$"%Score".text = str(score)

func on_correct_bubble_popped():
	increase_score()
	randomize_numbers()
	
func on_wrong_bubble_popped():
	set_multiplier(1)
	randomize_numbers()

func _on_ScoreResetTimer_timeout():
	randomize_numbers()


func _on_GameTimer_timeout():
	$UI/GameOverPopup/MarginContainer/VBoxContainer/FinalScore.text = str(score)
	$UI/GameOverPopup.popup_centered()
	get_tree().paused = true

func _on_GameOverButton_pressed():
	get_tree().change_scene(main_menu)
	get_tree().paused = false

func _on_HomeButton_pressed():
	$UI/QuitGamePopup.popup_centered()
	get_tree().paused = true

func _on_QuitButton_pressed():
	get_tree().change_scene(main_menu)
	get_tree().paused = false

func _on_CancelButton_pressed():
	$UI/QuitGamePopup.hide()
	get_tree().paused = false
