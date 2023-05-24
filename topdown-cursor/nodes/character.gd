extends CharacterBody2D


@export_enum("Normal:100", "Fast:200", "Very Fast:300") var speed := 300

enum Direction {DOWN, UP, LEFT, RIGHT}
var facing : Direction

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal_axis = Input.get_axis("move_left", "move_right")
	var vertical_axis = Input.get_axis("move_up", "move_down")
	var direction = Vector2(horizontal_axis, vertical_axis)
	if direction:
		velocity = direction * speed
		if horizontal_axis < 0:
			facing = Direction.LEFT
			$AnimationPlayer.play("walk_left")
			$Sprite2D.flip_h = false
		elif horizontal_axis > 0:
			facing = Direction.RIGHT
			$AnimationPlayer.play("walk_left")
			$Sprite2D.flip_h = true
		elif vertical_axis < 0:
			facing = Direction.UP
			$AnimationPlayer.play("walk_up")
		elif vertical_axis > 0:
			facing = Direction.DOWN
			$AnimationPlayer.play("walk_down")
	else:
		var animation
		match facing:
			Direction.LEFT:
				animation = "idle_left"
				$Sprite2D.flip_h = false
			Direction.RIGHT:
				animation = "idle_left"
				$Sprite2D.flip_h = true
			Direction.UP:
				animation = "idle_up"
			Direction.DOWN:
				animation = "idle_down"
		$AnimationPlayer.play(animation)
		velocity = Vector2.ZERO

	move_and_slide()
