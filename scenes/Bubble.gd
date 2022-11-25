extends RigidBody2D


var value
var rng = RandomNumberGenerator.new()
signal bubble_popped(bubble_value)


func _ready():
	rng.randomize()
	var x_velocity = rng.randf_range(-100, 100)
	var y_velocity = rng.randf_range(-100, -200)
	apply_central_impulse(Vector2(x_velocity, y_velocity))


func init(num):
	value = num
	get_node("BubbleLabel").text = str(value)


func _on_Bubble_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		emit_signal("bubble_popped", value)
		queue_free()


func _on_Timer_timeout():
	queue_free()
