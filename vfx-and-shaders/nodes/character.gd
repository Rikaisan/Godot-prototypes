extends CharacterBody2D


@export_enum("Normal:100", "Fast:200", "Very Fast:300") var speed := 300

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _process(delta: float) -> void:
	return
	match velocity.angle():
		0.0:
			$AnimationPlayer.play("walk_left")
		PI:
			$AnimationPlayer.play("walk_up")
		TAU:
			$AnimationPlayer.play("walk_left")
		PI + TAU:
			$AnimationPlayer.play("walk_down")
		_:
			$AnimationPlayer.play("idle_down")
