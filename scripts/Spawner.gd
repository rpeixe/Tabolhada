extends Node2D


var rng = RandomNumberGenerator.new()
var bubbles_per_wave = 5
var count = 0
var bubble = preload("res://scenes/Bubble.tscn")
var guaranteed_bubble
var current_result


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
	new_bubble.connect("bubble_popped", get_parent(), "on_bubble_popped")
	
	if count == guaranteed_bubble:
		bubble_value = current_result
	else:
		bubble_value = random_bubble_value()
		
	new_bubble.init(bubble_value)
	
	count += 1
	if count == bubbles_per_wave:
		count = 0
		$ShortTimer.stop()
		$LongTimer.start()


func _on_MainGame_result_changed(value):
	current_result = value
