extends CharacterBody2D


const SPEED = 100.0


func _physics_process(delta: float) -> void:	
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		if direction.x < 0:
			$Sprite2D.flip_h = true
		elif direction.x > 0:
			$Sprite2D.flip_h = false
		
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
