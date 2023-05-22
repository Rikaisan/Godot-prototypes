extends CanvasLayer

signal finished

func change_scene(taget_scene):
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(taget_scene)
	$AnimationPlayer.play_backwards("fade_in")

func change_scene_out(taget_scene):
	$Background.modulate = Color(1, 1, 1, 1)
	get_tree().change_scene_to_file(taget_scene)
	$AnimationPlayer.play_backwards("fade_in")

func fade_in():
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	finished.emit()

func fade_out():
	$AnimationPlayer.play_backwards("fade_in")
	await $AnimationPlayer.animation_finished
	finished.emit()

func move_up(taget_scene, color):
	$Background.modulate = color
	get_tree().change_scene_to_file(taget_scene)
	$AnimationPlayer.play("move_up")
	await $AnimationPlayer.animation_finished
	finished.emit()
