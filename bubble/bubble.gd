extends RigidBody2D


var value
var correct_value
var rng = RandomNumberGenerator.new()
signal correct_bubble_popped()
signal wrong_bubble_popped()
const max_bob = 0.05
onready var sprite = $Sprite
onready var label = $Label
onready var collision_shape = $CollisionShape2D
onready var pop_sound_correct = preload("res://sounds/sfx/bubble_pop_sound/pop_sound_correct.tscn")
onready var pop_sound_wrong = preload("res://sounds/sfx/bubble_pop_sound/pop_sound_wrong.tscn")
var colors = [
	Color.red,
	Color.blue,
	Color.yellow,
	Color.orange,
	Color.green,
	Color.purple,
	Color.teal,
	Color.orangered,
	Color.magenta,
	Color.chartreuse,
	Color.sandybrown,
	Color.violet,
]

func launch():
	var x_velocity = rng.randf_range(-150, 150)
	var y_velocity = rng.randf_range(-200, -300)
	apply_central_impulse(Vector2(x_velocity, y_velocity))

func set_random_color():
	var color = colors[rng.randi_range(0, colors.size() - 1)]
	sprite.modulate = color

func _ready():
	rng.randomize()
	launch()
	set_random_color()

func _physics_process(delta):
	sprite.scale.x = 1 - abs(max_bob * sin($BobTimer.time_left))
	sprite.scale.y = 1 - sin(max_bob * sin($BobTimer.time_left))

func init(num, correct):
	value = num
	correct_value = correct
	label.text = str(value)

func pop_bubble():
	var sound
	var animation
	label.queue_free()
	collision_shape.queue_free()
	
	if value == correct_value:
		sound = pop_sound_correct.instance()
		emit_signal("correct_bubble_popped")
		animation = "pop_correct"
	else:
		emit_signal("wrong_bubble_popped")
		sound = pop_sound_wrong.instance()
		animation = "default"
	get_parent().add_child(sound)
	sprite.play(animation)
	
func on_result_changed(num):
	correct_value = num

func _on_Bubble_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		pop_bubble()

func _on_Lifetime_timeout():
	queue_free()


func _on_Sprite_animation_finished():
	queue_free()
