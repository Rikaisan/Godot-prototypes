extends Node

signal start_game

var scores = [0, 0]

func _unhandled_input(event):
	if event.is_action_pressed("confirm"):
		start_game.emit()



func _on_score_zone_l_body_entered(body):
	if body.is_in_group("ball"):
		scores[1] += 1
		$"Score R".text = str(scores[1])


func _on_score_zone_r_body_entered(body):
	if body.is_in_group("ball"):
		scores[0] += 1
		$"Score L".text = str(scores[0])
