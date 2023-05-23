extends StaticBody2D

enum State {CLOSED, OPENED}

var state = State.CLOSED

@export var coin_scene : PackedScene = preload("res://nodes/coin.tscn")

func drop_loot():
	for n in range(5):
		var coin = coin_scene.instantiate()
		add_child(coin)
		coin.linear_velocity = Vector2(randi_range(-20, 20), randi_range(-20, -50))

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if state == State.CLOSED and body.is_in_group("player"):
		$Sprite2D/AnimationPlayer.play("open")
		call_deferred("drop_loot")
		state = State.OPENED
