extends Control

func _ready():
	await get_tree().create_timer(1).timeout
	$FadeInPlayer.play("fade_in")
	await get_tree().create_timer(2).timeout
	$FadeInPlayer.play_backwards("fade_in")
	await $FadeInPlayer.animation_finished
	Stinger.move_up("res://scenes/menu.tscn", Color.WHITE)
