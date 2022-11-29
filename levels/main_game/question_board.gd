extends KinematicBody2D

var bob_speed = 10.0

func change_text(num_1, num_2):
	$Multiplication.text = str(num_1) + "x" + str(num_2)

func _physics_process(delta):
	move_and_slide(Vector2.UP * cos($Timer.time_left) * bob_speed)
