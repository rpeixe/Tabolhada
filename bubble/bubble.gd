extends RigidBody2D


var value
var rng = RandomNumberGenerator.new()
signal bubble_popped(bubble_value)
const max_bob = 0.05
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
	$Sprite.modulate = color

func _ready():
	rng.randomize()
	launch()
	set_random_color()

func _physics_process(delta):
	$Sprite.scale.x = 1 - abs(max_bob * sin($BobTimer.time_left))
	$Sprite.scale.y = 1 - sin(max_bob * sin($BobTimer.time_left))

func init(num):
	value = num
	$Label.text = str(value)

func pop_bubble():
	emit_signal("bubble_popped", value)
	queue_free()
	

func _on_Bubble_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		pop_bubble()

func _on_Lifetime_timeout():
	queue_free()
