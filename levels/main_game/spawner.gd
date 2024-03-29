extends Node


var rng = RandomNumberGenerator.new()
var bubbles_per_wave = 6
var count = 0
var bubble = preload("res://bubble/bubble.tscn")
var guaranteed_bubble
var current_result
onready var spawner = [$Spawner1, $Spawner2, $Spawner3]
var current_spawner = 0
onready var main_game = $".."
onready var dog = $"%Dog"


func random_bubble_value():
	var a = rng.randi_range(1, 10)
	var b = rng.randi_range(1, 10)
	var bubble_value = a * b
	return bubble_value


func _ready():
	rng.randomize()


func _on_LongTimer_timeout():
	$LongTimer.stop()
	$ShortTimer.start()
	guaranteed_bubble = rng.randi_range(0, bubbles_per_wave - 1)


func _on_ShortTimer_timeout():
	var new_bubble = bubble.instance()
	var bubble_value
	
	$Bubbles.add_child(new_bubble)
	main_game.connect("result_changed", new_bubble, "on_result_changed")
	new_bubble.connect("correct_bubble_popped", main_game, "on_correct_bubble_popped")
	new_bubble.connect("wrong_bubble_popped", main_game, "on_wrong_bubble_popped")
	new_bubble.connect("correct_bubble_popped", dog, "on_correct_bubble_popped")
	new_bubble.connect("wrong_bubble_popped", dog, "on_wrong_bubble_popped")
	new_bubble.global_position = spawner[current_spawner % 3].global_position
	current_spawner += 1
	
	if count == guaranteed_bubble:
		bubble_value = current_result
	else:
		bubble_value = random_bubble_value()
		
	new_bubble.init(bubble_value, current_result)
	
	count += 1
	if count == bubbles_per_wave:
		count = 0
		$ShortTimer.stop()
		$LongTimer.start()


func _on_MainGame_result_changed(value):
	current_result = value
