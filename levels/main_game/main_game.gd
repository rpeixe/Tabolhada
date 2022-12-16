extends Node


var rng = RandomNumberGenerator.new()
var num_1
var num_2
var result
var score = 0
var multiplier = 1
var pop_sound_correct = preload("res://sounds/sfx/bubble_pop_sound/pop_sound_correct.tscn")
var pop_sound_wrong = preload("res://sounds/sfx/bubble_pop_sound/pop_sound_wrong.tscn")
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

func on_bubble_popped(value):
	var sound
	if value == result:
		increase_score()
		sound = pop_sound_correct.instance()
	else:
		set_multiplier(1)
		sound = pop_sound_wrong.instance()
	add_child(sound)
	randomize_numbers()

func _on_ScoreResetTimer_timeout():
	randomize_numbers()


func _on_GameTimer_timeout():
	$UI/GameOverPopup/MarginContainer/VBoxContainer/FinalScore.text = str(score)
	$UI/GameOverPopup.popup_centered()
	get_tree().paused = true

func _on_GameOverButton_button_up():
	get_tree().change_scene(main_menu)
	get_tree().paused = false


func _on_HomeButton_button_up():
	$UI/QuitGamePopup.popup_centered()
	get_tree().paused = true


func _on_QuitButton_button_up():
	get_tree().change_scene(main_menu)
	get_tree().paused = false


func _on_CancelButton_button_up():
	$UI/QuitGamePopup.hide()
	get_tree().paused = false
