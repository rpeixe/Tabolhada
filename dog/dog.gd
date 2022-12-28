extends Node2D

onready var sprite = $Sprite
onready var bark = preload("res://dog/sounds/bark/bark_sound.tscn")
onready var cry = preload("res://dog/sounds/cry/cry_sound.tscn")
var play_sound = false

func on_correct_bubble_popped():
	sprite.play("happy")
	play_sound = true

func on_wrong_bubble_popped():
	sprite.play("sad")
	play_sound = true

func _on_Sprite_animation_finished():
	sprite.play("idle")

func _process(delta):
	if play_sound == true:
		if sprite.animation == "happy" and sprite.frame == 4:
			var sound = bark.instance()
			add_child(sound)
			play_sound = false
		if sprite.animation == "sad" and sprite.frame == 5:
			var sound = cry.instance()
			add_child(sound)
			play_sound = false
