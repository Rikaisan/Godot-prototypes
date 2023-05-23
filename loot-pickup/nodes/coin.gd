extends RigidBody2D

@export var speed = 60

var follow_player = false
@onready var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
var speed_multiplier = 1

func _process(delta: float) -> void:
	if player and follow_player:
		var player_direction = player.position - global_position
		linear_velocity += player_direction.normalized() * speed * speed_multiplier * delta


func _on_follow_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		speed_multiplier = 1
		follow_player = true
		$SpeedTimer.start()


func _on_follow_area_body_exited(body: Node2D) -> void:
		if body.is_in_group("player"):
			follow_player = false
			$SpeedTimer.stop()


func _on_speed_timer_timeout() -> void:
	if follow_player:
		speed_multiplier += 1


func _on_collection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		queue_free()
